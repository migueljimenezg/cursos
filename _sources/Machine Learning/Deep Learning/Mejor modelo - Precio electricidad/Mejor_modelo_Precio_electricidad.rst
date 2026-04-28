Mejor modelo - Precio electricidad
----------------------------------

.. code:: ipython3

    # Importar librerías:
    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import matplotlib.dates as mdates
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import MinMaxScaler
    from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error
    from scipy.stats import boxcox
    from scipy.special import inv_boxcox
    from keras.models import load_model
    import statsmodels.api as sm
    from scipy.stats import norm
    
    # warning
    import warnings
    warnings.filterwarnings("ignore")

Función para evaluar el modelo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    def evaluar_modelo_ts(
        model,
        X_train, y_train,
        X_test, y_test,
        train_index,
        test_index,
        lags,
        scaler=None,
        transformacion=None,
        lambda_bc=None,
        nombre_modelo="Modelo",
        nombre_serie="Serie",
    ):
        """
        Evalúa un modelo de series de tiempo ya entrenado.
        Muestra métricas de desempeño y un gráfico elegante de ajuste
        en train y test.
    
        Parámetros
        ----------
        model : keras Model
            Modelo ya cargado / entrenado.
    
        X_train, y_train, X_test, y_test : np.array
            Datos de entrenamiento y prueba (ya con lags aplicados).
    
        train_index, test_index : pd.DatetimeIndex o array-like
            Índices temporales COMPLETOS (antes de crear lags).
    
        lags : int
            Número de rezagos usados para crear X/y.
    
        scaler : sklearn scaler o None
            Para invertir el escalado.
    
        transformacion : str o None
            "log", "boxcox" o None.
    
        lambda_bc : float o None
            Lambda de Box-Cox.
    
        nombre_modelo : str
            Nombre para mostrar en títulos.
    
        nombre_serie : str
            Nombre de la serie para el eje Y.
    
        Retorna
        -------
        metricas : dict
            Diccionario con todas las métricas calculadas.
        """
    
        # -------------------------------------------------
        # Funciones de inversión
        # -------------------------------------------------
        def invertir_a_escala_original(valores):
            resultado = valores.copy().flatten()
            if scaler is not None:
                resultado = scaler.inverse_transform(
                    resultado.reshape(-1, 1)
                ).flatten()
            if transformacion == "log":
                resultado = np.exp(resultado)
            elif transformacion == "boxcox":
                resultado = inv_boxcox(resultado, lambda_bc)
            return resultado
    
        def invertir_solo_scaler(valores):
            resultado = valores.copy().flatten()
            if scaler is not None:
                resultado = scaler.inverse_transform(
                    resultado.reshape(-1, 1)
                ).flatten()
            return resultado
    
        # -------------------------------------------------
        # Predicciones
        # -------------------------------------------------
        y_train_pred = model.predict(X_train, verbose=0).flatten()
        y_test_pred = model.predict(X_test, verbose=0).flatten()
    
        idx_train = train_index[lags:]
        idx_test = test_index[lags:]
    
        hay_inversion = (scaler is not None) or (transformacion is not None)
    
        # -------------------------------------------------
        # Métricas en espacio escalado
        # -------------------------------------------------
        rmse_train = np.sqrt(mean_squared_error(y_train, y_train_pred))
        rmse_test = np.sqrt(mean_squared_error(y_test, y_test_pred))
        mae_train = mean_absolute_error(y_train, y_train_pred)
        mae_test = mean_absolute_error(y_test, y_test_pred)
        r2_train = r2_score(y_train, y_train_pred)
        r2_test = r2_score(y_test, y_test_pred)
    
        metricas = {
            "rmse_train_scaled": rmse_train,
            "rmse_test_scaled": rmse_test,
            "mae_train_scaled": mae_train,
            "mae_test_scaled": mae_test,
            "r2_train_scaled": r2_train,
            "r2_test_scaled": r2_test,
        }
    
        # -------------------------------------------------
        # Métricas en escala original
        # -------------------------------------------------
        if hay_inversion:
            y_tr_inv = invertir_a_escala_original(y_train)
            y_te_inv = invertir_a_escala_original(y_test)
            y_tr_pred_inv = invertir_a_escala_original(y_train_pred)
            y_te_pred_inv = invertir_a_escala_original(y_test_pred)
    
            rmse_train_o = np.sqrt(mean_squared_error(y_tr_inv, y_tr_pred_inv))
            rmse_test_o = np.sqrt(mean_squared_error(y_te_inv, y_te_pred_inv))
            mae_train_o = mean_absolute_error(y_tr_inv, y_tr_pred_inv)
            mae_test_o = mean_absolute_error(y_te_inv, y_te_pred_inv)
            r2_train_o = r2_score(y_tr_inv, y_tr_pred_inv)
            r2_test_o = r2_score(y_te_inv, y_te_pred_inv)
    
            metricas.update({
                "rmse_train_original": rmse_train_o,
                "rmse_test_original": rmse_test_o,
                "mae_train_original": mae_train_o,
                "mae_test_original": mae_test_o,
                "r2_train_original": r2_train_o,
                "r2_test_original": r2_test_o,
            })
        else:
            y_tr_inv = y_train
            y_te_inv = y_test
            y_tr_pred_inv = y_train_pred
            y_te_pred_inv = y_test_pred
            rmse_train_o = rmse_train
            rmse_test_o = rmse_test
            mae_train_o = mae_train
            mae_test_o = mae_test
            r2_train_o = r2_train
            r2_test_o = r2_test
    
        # -------------------------------------------------
        # Imprimir métricas
        # -------------------------------------------------
        print(f"\n{'═'*62}")
        print(f"  {nombre_modelo}")
        print(f"{'═'*62}")
    
        if hay_inversion:
            print(f"\n  ▸ Espacio escalado/transformado:")
            print(f"    {'Métrica':<12} {'Train':>12} {'Test':>12}")
            print(f"    {'─'*36}")
            print(f"    {'RMSE':<12} {rmse_train:>12.6f} {rmse_test:>12.6f}")
            print(f"    {'MAE':<12} {mae_train:>12.6f} {mae_test:>12.6f}")
            print(f"    {'R²':<12} {r2_train:>12.6f} {r2_test:>12.6f}")
    
            print(f"\n  ▸ Escala original:")
            print(f"    {'Métrica':<12} {'Train':>12} {'Test':>12}")
            print(f"    {'─'*36}")
            print(f"    {'RMSE':<12} {rmse_train_o:>12.4f} {rmse_test_o:>12.4f}")
            print(f"    {'MAE':<12} {mae_train_o:>12.4f} {mae_test_o:>12.4f}")
            print(f"    {'R²':<12} {r2_train_o:>12.6f} {r2_test_o:>12.6f}")
        else:
            print(f"\n  {'Métrica':<12} {'Train':>12} {'Test':>12}")
            print(f"  {'─'*36}")
            print(f"  {'RMSE':<12} {rmse_train_o:>12.6f} {rmse_test_o:>12.6f}")
            print(f"  {'MAE':<12} {mae_train_o:>12.6f} {mae_test_o:>12.6f}")
            print(f"  {'R²':<12} {r2_train_o:>12.6f} {r2_test_o:>12.6f}")
    
        print(f"{'═'*62}\n")
    
        # -------------------------------------------------
        # Gráfico elegante de ajuste
        # -------------------------------------------------
        # Colores
        c_train = "#1a5276"
        c_train_pred = "#e74c3c"
        c_test = "#148f77"
        c_test_pred = "#e67e22"
        c_bg = "#fafafa"
        c_grid = "#d5d8dc"
        c_sep = "#aab7b8"
    
        fig, axes = plt.subplots(
            2, 1, figsize=(16, 9),
            gridspec_kw={"height_ratios": [3, 1], "hspace": 0.08},
            sharex=True,
        )
        fig.patch.set_facecolor(c_bg)
    
        # --- Panel superior: Ajuste ---
        ax1 = axes[0]
        ax1.set_facecolor(c_bg)
    
        ax1.plot(idx_train, y_tr_inv, color=c_train, linewidth=1.3,
                 label="Real Train", zorder=3)
        ax1.plot(idx_train, y_tr_pred_inv, color=c_train_pred, linewidth=1.1,
                 label="Pred Train", linestyle="--", alpha=0.85, zorder=4)
        ax1.plot(idx_test, y_te_inv, color=c_test, linewidth=1.3,
                 label="Real Test", zorder=3)
        ax1.plot(idx_test, y_te_pred_inv, color=c_test_pred, linewidth=1.1,
                 label="Pred Test", linestyle="--", alpha=0.85, zorder=4)
    
        # Línea separadora train/test
        sep_x = idx_test[0]
        ax1.axvline(x=sep_x, color=c_sep, linestyle=":", linewidth=1, zorder=2)
        ymin_ax, ymax_ax = ax1.get_ylim()
        ax1.text(sep_x, ymax_ax, "  Train │ Test", fontsize=8,
                 color=c_sep, va="top", ha="left", style="italic")
    
        # Sombrear zona de test
        ax1.axvspan(idx_test[0], idx_test[-1], alpha=0.04,
                    color="#2ecc71", zorder=1)
    
        ax1.set_ylabel(nombre_serie, fontsize=11, fontweight="bold",
                       color="#2c3e50")
        ax1.set_title(
            f"{nombre_modelo}  —  "
            f"R² Train: {r2_train_o:.4f}  |  R² Test: {r2_test_o:.4f}  |  "
            f"RMSE Test: {rmse_test_o:.4f}",
            fontsize=12, fontweight="bold", color="#2c3e50", pad=12,
        )
        ax1.legend(loc="upper left", frameon=True, fancybox=True,
                   shadow=False, fontsize=9, framealpha=0.9,
                   edgecolor=c_grid)
        ax1.grid(True, alpha=0.35, color=c_grid, linewidth=0.5)
        ax1.tick_params(colors="#5d6d7e", labelsize=9)
        for spine in ax1.spines.values():
            spine.set_color(c_grid)
    
        # --- Panel inferior: Residuales ---
        ax2 = axes[1]
        ax2.set_facecolor(c_bg)
    
        # Residuales en escala transformada (solo inv. scaler)
        if scaler is not None:
            y_tr_scl = invertir_solo_scaler(y_train)
            y_tr_pred_scl = invertir_solo_scaler(y_train_pred)
            y_te_scl = invertir_solo_scaler(y_test)
            y_te_pred_scl = invertir_solo_scaler(y_test_pred)
            res_train = y_tr_scl - y_tr_pred_scl
            res_test = y_te_scl - y_te_pred_scl
            if transformacion is not None:
                res_ylabel = f"Residual ({transformacion})"
            else:
                res_ylabel = "Residual (inv. scaler)"
        else:
            res_train = y_train - y_train_pred
            res_test = y_test - y_test_pred
            if transformacion is not None:
                res_ylabel = f"Residual ({transformacion})"
            else:
                res_ylabel = "Residual"
    
        ax2.scatter(idx_train, res_train, color=c_train, alpha=0.45,
                    s=8, zorder=3, label="Train")
        ax2.scatter(idx_test, res_test, color=c_test, alpha=0.45,
                    s=8, zorder=3, label="Test")
        ax2.axhline(y=0, color=c_train_pred, linestyle="-",
                    linewidth=0.8, zorder=2)
        ax2.axvline(x=sep_x, color=c_sep, linestyle=":", linewidth=1, zorder=2)
        ax2.axvspan(idx_test[0], idx_test[-1], alpha=0.04,
                    color="#2ecc71", zorder=1)
    
        ax2.set_ylabel(res_ylabel, fontsize=10, fontweight="bold",
                       color="#2c3e50")
        ax2.set_xlabel("Tiempo", fontsize=11, fontweight="bold",
                       color="#2c3e50")
        ax2.legend(loc="upper left", frameon=True, fancybox=True,
                   fontsize=8, framealpha=0.9, edgecolor=c_grid)
        ax2.grid(True, alpha=0.35, color=c_grid, linewidth=0.5)
        ax2.tick_params(colors="#5d6d7e", labelsize=9)
        for spine in ax2.spines.values():
            spine.set_color(c_grid)
    
        # Formato de fechas
        try:
            ax2.xaxis.set_major_formatter(mdates.DateFormatter("%Y-%m"))
            ax2.xaxis.set_major_locator(mdates.AutoDateLocator())
            fig.autofmt_xdate(rotation=30, ha="right")
        except Exception:
            pass
    
        plt.tight_layout()
        plt.show()
    
        return metricas

Datos:
~~~~~~

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

Transformaciones serie de tiempo:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Transformación logarítmica a la serie original
    serie_log = np.log(data['Precio'])
    data_log = pd.DataFrame(serie_log, columns=['Precio'])
    
    # Transformación Box-Cox a la serie original
    serie_bc, lambda_bc = boxcox(data['Precio'])
    data_bc = pd.DataFrame(serie_bc, columns=['Precio'], index=data.index)

.. code:: ipython3

    # Conjunto de Train y Test:
    train, test = train_test_split(data_bc, test_size=0.30, shuffle=False)
    # Escalado de variables:
    scaler = MinMaxScaler()
    scaler.fit(train)
    train_scaled = scaler.transform(train)
    test_scaled = scaler.transform(test)

Cargar modelo:
~~~~~~~~~~~~~~

.. code:: ipython3

    # Cargar modelo keras
    model = load_model('modelo_2_GRU_lags_60.keras')
    # Creación de lags:
    lags = 60
    X_train, y_train = prepare_data_rnn(train_scaled, lags)
    X_test, y_test = prepare_data_rnn(test_scaled, lags)
    

Evaluación del modelo
~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    metricas = evaluar_modelo_ts(
        model=model,
        X_train=X_train, y_train=y_train,
        X_test=X_test, y_test=y_test,
        train_index=train.index,
        test_index=test.index,
        lags=lags,
        scaler=scaler,
        transformacion="boxcox",       # o "log" o None
        lambda_bc=lambda_bc,
        nombre_modelo="GRU — Mejor Modelo",
        nombre_serie="Precio",
    )


.. parsed-literal::

    
    ══════════════════════════════════════════════════════════════
      GRU — Mejor Modelo
    ══════════════════════════════════════════════════════════════
    
      ▸ Espacio escalado/transformado:
        Métrica             Train         Test
        ────────────────────────────────────
        RMSE             0.038879     0.034798
        MAE              0.026712     0.024226
        R²               0.946227     0.942441
    
      ▸ Escala original:
        Métrica             Train         Test
        ────────────────────────────────────
        RMSE              29.6251      82.2282
        MAE               12.5171      39.6053
        R²               0.956445     0.920795
    ══════════════════════════════════════════════════════════════
    
    


.. image:: output_13_1.png

