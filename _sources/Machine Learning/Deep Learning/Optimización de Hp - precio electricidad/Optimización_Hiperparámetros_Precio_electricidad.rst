Optimización Hiperparámetros - Precio electricidad
--------------------------------------------------

.. code:: ipython3

    # Importar librerías:
    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import MinMaxScaler
    from keras.models import Sequential
    from keras.layers import Dense, Input, Dropout, GRU, LSTM
    from keras.layers import SimpleRNN as RNN
    from keras import optimizers
    from sklearn.metrics import mean_squared_error, r2_score
    from scipy.stats import boxcox
    from scipy.special import inv_boxcox
    
    # warning
    import warnings
    warnings.filterwarnings("ignore")

Función para Optimizar Hiperparámetros
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    def entrenar_modelos_ts(
        train_scaled,
        test_scaled,
        train_index,
        test_index,
        prepare_data,
        prepare_data_rnn,
        lags,
        cantidad_modelos,
        tipo_red,
        units,
        n_hidden,
        activation,
        learning_rate,
        batch_size,
        optimizer,
        Dropout_rate,
        epochs,
        loss="mse",
        scaler=None,
        transformacion=None,
        lambda_bc=None,
        guardar_modelos=True,
        graficar_loss=True,
        graficar_ajuste=True,
        graficar_residuales=True
    ):
        """
        Entrena múltiples redes neuronales para regresión de series de tiempo.
        Soporta RNA (feedforward), RNN, LSTM y GRU.
    
        Parámetros
        ----------
        train_scaled : np.array
            Serie de entrenamiento (escalada/transformada), 1D.
    
        test_scaled : np.array
            Serie de prueba (escalada/transformada), 1D.
    
        train_index : pd.DatetimeIndex o array-like
            Índice temporal del conjunto de entrenamiento COMPLETO
            (antes de crear lags). Se usará train_index[lags:] para graficar.
    
        test_index : pd.DatetimeIndex o array-like
            Índice temporal del conjunto de prueba COMPLETO
            (antes de crear lags). Se usará test_index[lags:] para graficar.
    
        prepare_data : callable
            Función externa para crear lags en RNA (feedforward).
            Firma: prepare_data(series, lags) -> (X, y) con X de forma 2D.
    
        prepare_data_rnn : callable
            Función externa para crear lags en RNN/LSTM/GRU.
            Firma: prepare_data_rnn(series, lags) -> (X, y) con X de forma 3D.
    
        lags : int o list
            Número de rezagos. Si es lista, se selecciona aleatoriamente
            y se recalculan X_train, y_train, X_test, y_test en cada modelo.
    
        cantidad_modelos : int
            Número de modelos a entrenar.
    
        tipo_red : str o list
            Tipo de red: "RNA", "RNN", "LSTM", "GRU".
            Si es lista, se selecciona aleatoriamente.
    
        units : int o list
            Neuronas por capa oculta.
    
        n_hidden : int o list
            Número de capas ocultas.
    
        activation : str o list
            Función de activación.
    
        learning_rate : float o list
            Tasa de aprendizaje.
    
        batch_size : int o list
            Tamaño del batch.
    
        optimizer : str o list
            Nombre del optimizador ("Adam", "RMSprop", etc.) o lista.
    
        Dropout_rate : float o list
            Tasa de dropout.
    
        epochs : int o list
            Número de épocas.
    
        loss : str
            Función de pérdida (default: "mse").
    
        scaler : objeto sklearn o None
            Scaler ajustado (ej: MinMaxScaler, StandardScaler).
            Si se proporciona, se aplica scaler.inverse_transform() antes
            de invertir la transformación Box-Cox/log.
            Pipeline de inversión: scaler.inverse_transform() -> inv. transformación.
    
        transformacion : str o None
            Tipo de transformación aplicada a la serie ANTES del escalado:
            - None: sin transformación.
            - "log": se aplica np.exp() para revertir.
            - "boxcox": se aplica inv_boxcox() para revertir (requiere lambda_bc).
    
        lambda_bc : float o None
            Parámetro lambda de Box-Cox. Requerido si transformacion="boxcox".
    
        guardar_modelos : bool
            Si True, guarda cada modelo en formato .keras.
    
        graficar_loss : bool
            Si True, muestra gráfico de Loss vs Val_loss.
    
        graficar_ajuste : bool
            Si True, muestra gráfico de ajuste sobre train y test.
    
        graficar_residuales : bool
            Si True, muestra gráfico de residuales en el tiempo.
    
        Retorna
        -------
        resultados_df : pd.DataFrame
            DataFrame con hiperparámetros y métricas de cada modelo.
    
        predicciones : dict
            Diccionario con las predicciones del último modelo:
            - "y_train", "y_test": valores reales (escalados)
            - "y_train_pred", "y_test_pred": predicciones (escalados)
            - "y_train_inv", "y_test_inv": reales en escala original
            - "y_train_pred_inv", "y_test_pred_inv": predicciones en escala original
            - "train_index", "test_index": índice temporal post-lags
        """
    
        # -------------------------------------------------
        # Funciones auxiliares
        # -------------------------------------------------
        def seleccionar(param):
            if isinstance(param, list):
                return np.random.choice(param).item()
            return param
    
        def invertir_a_escala_original(valores):
            """
            Revierte el pipeline completo:
            1. Invertir escalado (scaler.inverse_transform)
            2. Invertir transformación (exp o inv_boxcox)
            """
            resultado = valores.copy().flatten()
    
            # Paso 1: Invertir escalado
            if scaler is not None:
                resultado = scaler.inverse_transform(
                    resultado.reshape(-1, 1)
                ).flatten()
    
            # Paso 2: Invertir transformación
            if transformacion == "log":
                resultado = np.exp(resultado)
            elif transformacion == "boxcox":
                if lambda_bc is None:
                    raise ValueError(
                        "Se requiere lambda_bc para invertir Box-Cox."
                    )
                resultado = inv_boxcox(resultado, lambda_bc)
            elif transformacion is not None:
                raise ValueError(
                    f"Transformación '{transformacion}' no soportada. "
                    "Use None, 'log' o 'boxcox'."
                )
    
            return resultado
    
        def invertir_solo_scaler(valores):
            """
            Revierte SOLO el escalado (scaler.inverse_transform).
            Deja los datos en escala de la transformación (log o boxcox).
            """
            resultado = valores.copy().flatten()
            if scaler is not None:
                resultado = scaler.inverse_transform(
                    resultado.reshape(-1, 1)
                ).flatten()
            return resultado
    
        # -------------------------------------------------
        # Diccionarios
        # -------------------------------------------------
        opt_dict = {
            "Adam": optimizers.Adam,
            "RMSprop": optimizers.RMSprop,
            "SGD": optimizers.SGD,
            "Adagrad": optimizers.Adagrad,
            "Adadelta": optimizers.Adadelta,
            "Adamax": optimizers.Adamax,
            "Nadam": optimizers.Nadam,
            "Ftrl": optimizers.Ftrl,
        }
    
        layer_dict = {
            "RNN": RNN,
            "LSTM": LSTM,
            "GRU": GRU,
        }
    
        # -------------------------------------------------
        # Validaciones
        # -------------------------------------------------
        if transformacion == "boxcox" and lambda_bc is None:
            raise ValueError(
                "Debe proporcionar lambda_bc cuando transformacion='boxcox'."
            )
    
        # Determinar si se puede invertir a escala original
        hay_inversion = (scaler is not None) or (transformacion is not None)
    
        resultados = []
        predicciones = {}
    
        for i in range(cantidad_modelos):
    
            # ---------------------------------------------
            # Selección de hiperparámetros
            # ---------------------------------------------
            lags_i = int(seleccionar(lags))
            tipo_red_i = seleccionar(tipo_red)
            units_i = int(seleccionar(units))
            n_hidden_i = int(seleccionar(n_hidden))
            activation_i = seleccionar(activation)
            lr_i = seleccionar(learning_rate)
            batch_size_i = int(seleccionar(batch_size))
            optimizer_i = seleccionar(optimizer)
            dropout_i = seleccionar(Dropout_rate)
            epochs_i = int(seleccionar(epochs))
    
            print(f"\n{'='*60}")
            print(f"Modelo {i+1}/{cantidad_modelos} — Tipo: {tipo_red_i}")
            print(f"{'='*60}")
            print(f"  Lags: {lags_i}, Units: {units_i}, Hidden: {n_hidden_i}")
            print(f"  Activation: {activation_i}, LR: {lr_i}")
            print(f"  Optimizer: {optimizer_i}, Batch: {batch_size_i}")
            print(f"  Dropout: {dropout_i}, Epochs: {epochs_i}")
    
            # ---------------------------------------------
            # Preparar datos con las funciones externas
            # Se recalculan en cada iteración porque
            # lags_i puede cambiar entre modelos
            # ---------------------------------------------
            if tipo_red_i == "RNA":
                X_train, y_train = prepare_data(train_scaled, lags_i)
                X_test, y_test = prepare_data(test_scaled, lags_i)
            else:
                X_train, y_train = prepare_data_rnn(train_scaled, lags_i)
                X_test, y_test = prepare_data_rnn(test_scaled, lags_i)
    
            # ---------------------------------------------
            # Construir modelo
            # ---------------------------------------------
            model = Sequential()
    
            if tipo_red_i == "RNA":
                model.add(Input(shape=(lags_i,)))
                for _ in range(n_hidden_i):
                    model.add(Dense(units_i, activation=activation_i))
                    if dropout_i > 0:
                        model.add(Dropout(dropout_i))
    
            else:
                RecurrentLayer = layer_dict[tipo_red_i]
                model.add(Input(shape=(lags_i, 1)))
                for layer_idx in range(n_hidden_i):
                    return_seq = layer_idx < (n_hidden_i - 1)
                    model.add(
                        RecurrentLayer(
                            units_i,
                            activation=activation_i,
                            return_sequences=return_seq,
                        )
                    )
                    if dropout_i > 0:
                        model.add(Dropout(dropout_i))
    
            model.add(Dense(1))
    
            # ---------------------------------------------
            # Optimizador
            # ---------------------------------------------
            if optimizer_i not in opt_dict:
                raise ValueError(f"Optimizador '{optimizer_i}' no soportado.")
            opt = opt_dict[optimizer_i](learning_rate=lr_i)
    
            # ---------------------------------------------
            # Compilar y entrenar
            # ---------------------------------------------
            model.compile(loss=loss, optimizer=opt)
    
            history = model.fit(
                X_train, y_train,
                validation_data=(X_test, y_test),
                epochs=epochs_i,
                batch_size=batch_size_i,
                verbose=0,
            )
    
            # ---------------------------------------------
            # Predicciones
            # ---------------------------------------------
            y_train_pred = model.predict(X_train, verbose=0).flatten()
            y_test_pred = model.predict(X_test, verbose=0).flatten()
    
            # Métricas en espacio escalado/transformado
            rmse_train = np.sqrt(mean_squared_error(y_train, y_train_pred))
            rmse_test = np.sqrt(mean_squared_error(y_test, y_test_pred))
            r2_train = r2_score(y_train, y_train_pred)
            r2_test = r2_score(y_test, y_test_pred)
    
            # Índices temporales post-lags
            idx_train = train_index[lags_i:]
            idx_test = test_index[lags_i:]
    
            print(f"\n  --- Métricas (espacio escalado/transformado) ---")
            print(f"  RMSE  Train: {rmse_train:.6f}  |  Test: {rmse_test:.6f}")
            print(f"  R²    Train: {r2_train:.6f}  |  Test: {r2_test:.6f}")
    
            # ---------------------------------------------
            # Invertir a escala original
            # ---------------------------------------------
            y_train_inv = None
            y_test_inv = None
            y_train_pred_inv = None
            y_test_pred_inv = None
            rmse_train_inv = None
            rmse_test_inv = None
            r2_train_inv = None
            r2_test_inv = None
    
            if hay_inversion:
                y_train_inv = invertir_a_escala_original(y_train)
                y_test_inv = invertir_a_escala_original(y_test)
                y_train_pred_inv = invertir_a_escala_original(y_train_pred)
                y_test_pred_inv = invertir_a_escala_original(y_test_pred)
    
                rmse_train_inv = np.sqrt(
                    mean_squared_error(y_train_inv, y_train_pred_inv)
                )
                rmse_test_inv = np.sqrt(
                    mean_squared_error(y_test_inv, y_test_pred_inv)
                )
                r2_train_inv = r2_score(y_train_inv, y_train_pred_inv)
                r2_test_inv = r2_score(y_test_inv, y_test_pred_inv)
    
                inv_label = []
                if scaler is not None:
                    inv_label.append(type(scaler).__name__)
                if transformacion is not None:
                    inv_label.append(transformacion)
                inv_label_str = " + ".join(inv_label)
    
                print(f"\n  --- Métricas (escala original, inv. {inv_label_str}) ---")
                print(f"  RMSE  Train: {rmse_train_inv:.6f}  |  Test: {rmse_test_inv:.6f}")
                print(f"  R²    Train: {r2_train_inv:.6f}  |  Test: {r2_test_inv:.6f}")
    
            # ---------------------------------------------
            # Gráfico de Loss y Val Loss
            # ---------------------------------------------
            if graficar_loss:
                plt.figure(figsize=(10, 4))
                plt.plot(history.history["loss"], label="Loss (Train)")
                plt.plot(history.history["val_loss"], label="Val Loss (Test)")
                plt.title(f"Loss — Modelo {i+1} ({tipo_red_i})")
                plt.xlabel("Epoch")
                plt.ylabel("Loss")
                plt.legend()
                plt.grid(alpha=0.3)
                plt.tight_layout()
                plt.show()
    
            # ---------------------------------------------
            # Gráfico de ajuste
            # ---------------------------------------------
            if graficar_ajuste:
                if hay_inversion:
                    plt.figure(figsize=(15, 5))
                    plt.plot(idx_train, y_train_inv,
                             label="Real Train", color="blue", linewidth=1)
                    plt.plot(idx_train, y_train_pred_inv,
                             label="Pred Train", color="darkred",
                             linewidth=1, linestyle="--")
                    plt.plot(idx_test, y_test_inv,
                             label="Real Test", color="green", linewidth=1)
                    plt.plot(idx_test, y_test_pred_inv,
                             label="Pred Test", color="darkred",
                             linewidth=1, linestyle="-.")
                    plt.title(
                        f"Ajuste — Modelo {i+1} ({tipo_red_i}) "
                        f"[Escala original]"
                    )
                    plt.xlabel("Tiempo")
                    plt.ylabel("Valor")
                    plt.legend()
                    plt.grid(alpha=0.3)
                    plt.tight_layout()
                    plt.show()
                else:
                    plt.figure(figsize=(15, 5))
                    plt.plot(idx_train, y_train,
                             label="Real Train", color="blue", linewidth=1)
                    plt.plot(idx_train, y_train_pred,
                             label="Pred Train", color="darkred",
                             linewidth=1, linestyle="--")
                    plt.plot(idx_test, y_test,
                             label="Real Test", color="green", linewidth=1)
                    plt.plot(idx_test, y_test_pred,
                             label="Pred Test", color="darkred",
                             linewidth=1, linestyle="-.")
                    plt.title(f"Ajuste — Modelo {i+1} ({tipo_red_i})")
                    plt.xlabel("Tiempo")
                    plt.ylabel("Valor")
                    plt.legend()
                    plt.grid(alpha=0.3)
                    plt.tight_layout()
                    plt.show()
    
            # ---------------------------------------------
            # Gráfico de residuales
            # (en escala transformada: solo invierte scaler, NO log/boxcox)
            # ---------------------------------------------
            if graficar_residuales:
                if scaler is not None:
                    # Invertir solo el scaler, mantener escala log/boxcox
                    y_tr_scl = invertir_solo_scaler(y_train)
                    y_tr_pred_scl = invertir_solo_scaler(y_train_pred)
                    y_te_scl = invertir_solo_scaler(y_test)
                    y_te_pred_scl = invertir_solo_scaler(y_test_pred)
                    res_train = y_tr_scl - y_tr_pred_scl
                    res_test = y_te_scl - y_te_pred_scl
                    if transformacion is not None:
                        res_label = f"[Escala {transformacion}]"
                    else:
                        res_label = "[Inv. scaler]"
                else:
                    # Sin scaler: residuales en espacio escalado directo
                    res_train = y_train - y_train_pred
                    res_test = y_test - y_test_pred
                    if transformacion is not None:
                        res_label = f"[Escala {transformacion}]"
                    else:
                        res_label = ""
    
                plt.figure(figsize=(15, 5))
                plt.scatter(idx_train, res_train, color="blue",
                            alpha=0.5, s=15, label="Residuales Train")
                plt.scatter(idx_test, res_test, color="green",
                            alpha=0.5, s=15, label="Residuales Test")
                plt.axhline(y=0, color="red", linestyle="--", linewidth=1)
                plt.title(
                    f"Residuales — Modelo {i+1} ({tipo_red_i}) {res_label}"
                )
                plt.xlabel("Tiempo")
                plt.ylabel("Residual")
                plt.legend()
                plt.grid(alpha=0.3)
                plt.tight_layout()
                plt.show()
    
            # ---------------------------------------------
            # Guardar modelo
            # ---------------------------------------------
            if guardar_modelos:
                nombre_archivo = f"modelo_{i+1}_{tipo_red_i}_lags_{lags_i}.keras"
                model.save(nombre_archivo)
                print(f"\n  Modelo guardado: {nombre_archivo}")
    
            # ---------------------------------------------
            # Almacenar resultados
            # ---------------------------------------------
            resultado = {
                "modelo": i + 1,
                "tipo_red": tipo_red_i,
                "lags": lags_i,
                "units": units_i,
                "n_hidden": n_hidden_i,
                "activation": activation_i,
                "learning_rate": lr_i,
                "batch_size": batch_size_i,
                "optimizer": optimizer_i,
                "dropout": dropout_i,
                "epochs": epochs_i,
                "loss_fn": loss,
                "rmse_train": rmse_train,
                "rmse_test": rmse_test,
                "r2_train": r2_train,
                "r2_test": r2_test,
            }
    
            if hay_inversion:
                resultado["rmse_train_original"] = rmse_train_inv
                resultado["rmse_test_original"] = rmse_test_inv
                resultado["r2_train_original"] = r2_train_inv
                resultado["r2_test_original"] = r2_test_inv
    
            resultados.append(resultado)
    
            # Guardar predicciones del modelo actual
            predicciones = {
                "y_train": y_train,
                "y_test": y_test,
                "y_train_pred": y_train_pred,
                "y_test_pred": y_test_pred,
                "y_train_inv": y_train_inv,
                "y_test_inv": y_test_inv,
                "y_train_pred_inv": y_train_pred_inv,
                "y_test_pred_inv": y_test_pred_inv,
                "train_index": idx_train,
                "test_index": idx_test,
            }
    
        resultados_df = pd.DataFrame(resultados)
        return resultados_df, predicciones
    

Datos
~~~~~

.. code:: ipython3

    # Cargar datos:
    data = pd.read_excel("Precio_diario.xlsx")
    data.index = pd.to_datetime(data['Fecha'])
    data.drop('Fecha', axis=1, inplace=True)
    print(data.head())
    plt.figure(figsize=(15,5))
    plt.plot(data['Precio'], color="black", label="Precio electricidad diario")
    plt.legend()
    plt.show()


.. parsed-literal::

                   Precio
    Fecha                
    2002-05-01  40.802839
    2002-05-02  41.677618
    2002-05-03  37.826814
    2002-05-04  37.904091
    2002-05-05  36.266849
    


.. image:: output_5_1.png


.. code:: ipython3

    # Función para crear los lags para RNA
    def prepare_data(precio, n_lags):
        X = []
        y = []
        for i in range(n_lags, len(precio)):
    
            lag_features = precio[i - n_lags : i, 0]  # Extraemos el vector de lags
            X.append(lag_features)
            # El target es el valor en la posición actual
            y.append(precio[i, 0])
    
        # Convertimos las listas a numpy.ndarray
        X = np.array(X)
        y = np.array(y)
    
        return X, y
    
    # Función para crear los lags para redes RNN, GRU y LSTM
    def prepare_data_rnn(precio, n_lags):
        X = []
        y = []
        for i in range(n_lags, len(precio)):
    
            lag_features = precio[i - n_lags : i, 0]  # Extraemos el vector de lags
            X.append(lag_features)
            # El target es el valor en la posición actual
            y.append(precio[i, 0])
    
        # Convertimos las listas a numpy.ndarray
        X = np.array(X)
        y = np.array(y)
        X = X.reshape(X.shape[0], n_lags, 1)
    
        return X, y

Transformaciones serie de tiempo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Transformación logarítmica a la serie original
    serie_log = np.log(data['Precio'])
    data_log = pd.DataFrame(serie_log, columns=['Precio'])
    
    # Transformación Box-Cox a la serie original
    serie_bc, lambda_bc = boxcox(data['Precio'])
    data_bc = pd.DataFrame(serie_bc, columns=['Precio'], index=data.index)

.. code:: ipython3

    # Graficar serie_log
    plt.figure(figsize=(15,5))
    plt.plot(serie_log, color="black", label="Transformación logarítmica")
    plt.legend()
    plt.show()



.. image:: output_9_0.png


.. code:: ipython3

    # Graficar serie_bc
    plt.figure(figsize=(15,5))
    plt.plot(serie_bc, color="black", label="Transformación Box-Cox")
    plt.legend()
    plt.show()



.. image:: output_10_0.png


.. code:: ipython3

    # Conjunto de Train y Test:
    train, test = train_test_split(data_bc, test_size=0.30, shuffle=False)
    # Escalado de variables:
    scaler = MinMaxScaler()
    scaler.fit(train)
    train_scaled = scaler.transform(train)
    test_scaled = scaler.transform(test)

.. code:: ipython3

    # Graficar train y test
    plt.figure(figsize=(15,5))
    plt.plot(train, color="blue", label="Train")
    plt.plot(test, color="green", label="Test")
    plt.legend()
    plt.show()



.. image:: output_12_0.png


Optimización de Hiperparámetros
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    resultados, preds = entrenar_modelos_ts(
        train_scaled=train_scaled,
        test_scaled=test_scaled,
        train_index=train.index,
        test_index=test.index,
        prepare_data=prepare_data,          # Función lags para RNA
        prepare_data_rnn=prepare_data_rnn,  # Función lags para RNN/LSTM/GRU
        lags=[6, 8, 10, 12, 24, 30, 35, 40, 50, 60],
        cantidad_modelos=3,                # Cantidad de modelos a ajustar
        tipo_red=["LSTM", "GRU"],           # "RNA", "RNN", "LSTM", "GRU"
        units=[10, 15, 20, 30, 40, 50],     # Cantidad de neuronas por capas
        n_hidden=[1, 2, 3],                 # Cantidad de capas ocultas
        activation=["relu", "tanh", "selu"],
        learning_rate=[0.001, 0.01],
        batch_size=[16, 32, 64],
        optimizer=["Adam", "RMSprop"],
        Dropout_rate=[0.1, 0.2, 0.3],
        epochs=[30],
        scaler=scaler,                      # MinMaxScaler/StandardScaler ajustado
        transformacion="boxcox",            # None o Transformación "log" o "boxcox"
        lambda_bc=lambda_bc                 # None o valor de lambda solo par "boxcox"
    )


.. parsed-literal::

    
    ============================================================
    Modelo 1/3 — Tipo: LSTM
    ============================================================
      Lags: 50, Units: 15, Hidden: 1
      Activation: selu, LR: 0.001
      Optimizer: RMSprop, Batch: 64
      Dropout: 0.2, Epochs: 30
    
      --- Métricas (espacio escalado/transformado) ---
      RMSE  Train: 0.039074  |  Test: 0.034494
      R²    Train: 0.946136  |  Test: 0.943277
    
      --- Métricas (escala original, inv. MinMaxScaler + boxcox) ---
      RMSE  Train: 32.394423  |  Test: 93.766943
      R²    Train: 0.947879  |  Test: 0.896604
    


.. image:: output_14_1.png



.. image:: output_14_2.png



.. image:: output_14_3.png


.. parsed-literal::

    
      Modelo guardado: modelo_1_LSTM_lags_50.keras
    
    ============================================================
    Modelo 2/3 — Tipo: GRU
    ============================================================
      Lags: 60, Units: 20, Hidden: 2
      Activation: selu, LR: 0.01
      Optimizer: RMSprop, Batch: 64
      Dropout: 0.3, Epochs: 30
    
      --- Métricas (espacio escalado/transformado) ---
      RMSE  Train: 0.038879  |  Test: 0.034798
      R²    Train: 0.946227  |  Test: 0.942441
    
      --- Métricas (escala original, inv. MinMaxScaler + boxcox) ---
      RMSE  Train: 29.625124  |  Test: 82.228240
      R²    Train: 0.956445  |  Test: 0.920795
    


.. image:: output_14_5.png



.. image:: output_14_6.png



.. image:: output_14_7.png


.. parsed-literal::

    
      Modelo guardado: modelo_2_GRU_lags_60.keras
    
    ============================================================
    Modelo 3/3 — Tipo: LSTM
    ============================================================
      Lags: 12, Units: 50, Hidden: 1
      Activation: tanh, LR: 0.01
      Optimizer: Adam, Batch: 16
      Dropout: 0.3, Epochs: 30
    
      --- Métricas (espacio escalado/transformado) ---
      RMSE  Train: 0.040657  |  Test: 0.046478
      R²    Train: 0.943345  |  Test: 0.895725
    
      --- Métricas (escala original, inv. MinMaxScaler + boxcox) ---
      RMSE  Train: 57.378961  |  Test: 157.801684
      R²    Train: 0.835963  |  Test: 0.703071
    


.. image:: output_14_9.png



.. image:: output_14_10.png



.. image:: output_14_11.png


.. parsed-literal::

    
      Modelo guardado: modelo_3_LSTM_lags_12.keras
    
