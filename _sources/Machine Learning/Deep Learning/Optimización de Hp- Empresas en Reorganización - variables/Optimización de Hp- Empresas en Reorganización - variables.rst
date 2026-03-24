Optimización de Hiperparámetros - Empresas en Reorganización - cambio variables
-------------------------------------------------------------------------------

.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import matplotlib as mpl
    import seaborn as sns
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import classification_report, confusion_matrix, accuracy_score, recall_score, precision_score
    from keras.models import Sequential
    from keras.layers import Dense, Input, Dropout
    from keras import optimizers
    from keras.models import load_model

Función para Optimización de Hiperparámetros
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Función: entrenamiento de múltiples modelos con hiperparámetros
aleatorios:**

.. code:: ipython3

    def entrenar_modelos_rna(
        X_train, y_train, X_test, y_test,
        cantidad_modelos,
        units,
        n_hidden,
        activation,
        learning_rate,
        batch_size,
        optimizer,
        Dropout_rate,
        epochs,
        loss=None,
        metrics=None,
        tipo_clasificacion="binaria",   # "binaria" por defecto
        output_dim=None,
        promedio_metricas="binary",     # "binary", "macro", "weighted", etc.
        guardar_modelos=True,
        graficar_loss=True
    ):
        """
        Entrena múltiples redes neuronales para clasificación binaria o multiclase.
    
        Parámetros
        ----------
        X_train, y_train, X_test, y_test :
            Datos de entrenamiento y prueba.
    
        cantidad_modelos : int
            Número de modelos a entrenar.
    
        units : int o list
            Número de neuronas por capa oculta.
    
        n_hidden : int o list
            Número de capas ocultas.
    
        activation : str o list
            Función de activación de las capas ocultas.
    
        learning_rate : float o list
            Tasa de aprendizaje.
    
        batch_size : int o list
            Tamaño del batch.
    
        optimizer : str, dict o list
            Puede ser un nombre ("Adam"), una lista de nombres,
            o una lista de diccionarios con parámetros del optimizador.
    
        Dropout_rate : float o list
            Tasa de dropout.
    
        epochs : int o list
            Número de épocas.
    
        loss : str o None
            Función de pérdida. Si es None, se define automáticamente.
    
        metrics : list o None
            Métricas de Keras. Si es None, se usa ['accuracy'].
    
        tipo_clasificacion : str
            "binaria" o "multiclase".
    
        output_dim : int o None
            Número de clases para multiclase. Si es None, se infiere.
    
        promedio_metricas : str
            Tipo de promedio para recall y precision en multiclase.
            Ej: "macro", "weighted". En binaria usualmente "binary".
    
        guardar_modelos : bool
            Si True, guarda los modelos.
    
        graficar_loss : bool
            Si True, grafica loss y val_loss.
        """
    
        # -----------------------------
        # Función auxiliar
        # -----------------------------
        def seleccionar(param):
            if isinstance(param, list):
                return np.random.choice(param).item()
            return param
    
        # -----------------------------
        # Diccionario de optimizadores
        # -----------------------------
        opt_dict = {
            "Adam": optimizers.Adam,
            "RMSprop": optimizers.RMSprop,
            "SGD": optimizers.SGD,
            "Adagrad": optimizers.Adagrad,
            "Adadelta": optimizers.Adadelta,
            "Adamax": optimizers.Adamax,
            "Nadam": optimizers.Nadam,
            "Ftrl": optimizers.Ftrl
        }
    
        # -----------------------------
        # Inferir número de clases
        # -----------------------------
        clases_train = np.unique(y_train)
        n_clases = len(clases_train)
    
        if tipo_clasificacion == "binaria":
            output_units = 1
            output_activation = "sigmoid"
            if loss is None:
                loss = "binary_crossentropy"
            if metrics is None:
                metrics = ["accuracy"]
    
        elif tipo_clasificacion == "multiclase":
            if output_dim is None:
                output_dim = n_clases
            output_units = output_dim
            output_activation = "softmax"
            if loss is None:
                loss = "sparse_categorical_crossentropy"
            if metrics is None:
                metrics = ["accuracy"]
        else:
            raise ValueError("tipo_clasificacion debe ser 'binaria' o 'multiclase'")
    
        resultados = []
    
        for i in range(cantidad_modelos):
    
            # -----------------------------
            # Selección de hiperparámetros
            # -----------------------------
            units_i = seleccionar(units)
            n_hidden_i = seleccionar(n_hidden)
            activation_i = seleccionar(activation)
            lr_i = seleccionar(learning_rate)
            batch_size_i = seleccionar(batch_size)
            optimizer_i = seleccionar(optimizer)
            dropout_i = seleccionar(Dropout_rate)
            epochs_i = seleccionar(epochs)
    
            print(f"\nModelo {i+1}")
            print(f"Units: {units_i}, Hidden: {n_hidden_i}, Activation: {activation_i}, LR: {lr_i}")
            print(f"Optimizer: {optimizer_i}, Batch: {batch_size_i}, Dropout: {dropout_i}, epochs: {epochs_i}")
    
    
            # -----------------------------
            # Definir modelo
            # -----------------------------
            model = Sequential()
            model.add(Input(shape=(X_train.shape[1],)))
    
            for _ in range(n_hidden_i):
                model.add(Dense(units_i, activation=activation_i))
                model.add(Dropout(dropout_i))
    
            model.add(Dense(output_units, activation=output_activation))
    
            # -----------------------------
            # Construir optimizador
            # -----------------------------
            if isinstance(optimizer_i, dict):
                opt_name = optimizer_i["name"]
                if opt_name not in opt_dict:
                    raise ValueError(f"Optimizador '{opt_name}' no soportado")
                params = {k: v for k, v in optimizer_i.items() if k != "name"}
                if "learning_rate" not in params:
                    params["learning_rate"] = lr_i
                opt = opt_dict[opt_name](**params)
    
            else:
                if optimizer_i not in opt_dict:
                    raise ValueError(f"Optimizador '{optimizer_i}' no soportado")
                opt = opt_dict[optimizer_i](learning_rate=lr_i)
    
            # -----------------------------
            # Compilar
            # -----------------------------
            model.compile(loss=loss, optimizer=opt, metrics=metrics)
    
            # -----------------------------
            # Entrenar
            # -----------------------------
            history = model.fit(
                X_train, y_train,
                validation_data=(X_test, y_test),
                epochs=epochs_i,
                batch_size=batch_size_i,
                verbose=0
            )
    
            # -----------------------------
            # Predicciones
            # -----------------------------
            y_prob_train = model.predict(X_train, verbose=0)
            y_prob_test = model.predict(X_test, verbose=0)
    
            if tipo_clasificacion == "binaria":
                y_pred_train = (y_prob_train > 0.5).astype(int).flatten()
                y_pred_test = (y_prob_test > 0.5).astype(int).flatten()
    
                acc_train = accuracy_score(y_train, y_pred_train)
                acc_test = accuracy_score(y_test, y_pred_test)
    
                recall_train = recall_score(y_train, y_pred_train, average="binary", zero_division=0)
                recall_test = recall_score(y_test, y_pred_test, average="binary", zero_division=0)
    
                precision_train = precision_score(y_train, y_pred_train, average="binary", zero_division=0)
                precision_test = precision_score(y_test, y_pred_test, average="binary", zero_division=0)
    
            else:  # multiclase
                y_pred_train = np.argmax(y_prob_train, axis=1)
                y_pred_test = np.argmax(y_prob_test, axis=1)
    
                acc_train = accuracy_score(y_train, y_pred_train)
                acc_test = accuracy_score(y_test, y_pred_test)
    
                recall_train = recall_score(y_train, y_pred_train, average=promedio_metricas, zero_division=0)
                recall_test = recall_score(y_test, y_pred_test, average=promedio_metricas, zero_division=0)
    
                precision_train = precision_score(y_train, y_pred_train, average=promedio_metricas, zero_division=0)
                precision_test = precision_score(y_test, y_pred_test, average=promedio_metricas, zero_division=0)
    
            print(f"Accuracy train: {acc_train:.4f}, test: {acc_test:.4f}")
            print(f"Recall train: {recall_train:.4f}, test: {recall_test:.4f}")
            print(f"Precision train: {precision_train:.4f}, test: {precision_test:.4f}")
    
            resultados.append({
                "modelo": i + 1,
                "units": units_i,
                "n_hidden": n_hidden_i,
                "activation": activation_i,
                "learning_rate": lr_i,
                "batch_size": batch_size_i,
                "optimizer": optimizer_i if isinstance(optimizer_i, str) else optimizer_i["name"],
                "dropout": dropout_i,
                "epochs": epochs_i,
                "tipo_clasificacion": tipo_clasificacion,
                "loss": loss,
                "accuracy_train": acc_train,
                "accuracy_test": acc_test,
                "recall_train": recall_train,
                "recall_test": recall_test,
                "precision_train": precision_train,
                "precision_test": precision_test
            })
    
            # -----------------------------
            # Gráfico de pérdida
            # -----------------------------
            if graficar_loss:
                plt.figure(figsize=(6, 4))
                plt.plot(history.history["loss"], label="Train")
                plt.plot(history.history["val_loss"], label="Test")
                plt.title(f"Loss - Modelo {i+1}")
                plt.xlabel("Epoch")
                plt.ylabel("Loss")
                plt.legend()
                plt.grid(alpha=0.3)
                plt.show()
    
            # -----------------------------
            # Guardar modelo
            # -----------------------------
            if guardar_modelos:
                model.save(f"modelo_{i+1}.keras")
    
        resultados_df = pd.DataFrame(resultados)
        return resultados_df

.. code:: ipython3

    path = "BD empresas en re organización.xlsx"
    
    xls = pd.ExcelFile(path)
    
    df = pd.read_excel(path, sheet_name=xls.sheet_names[0])
    
    df.head()




.. raw:: html

    
      <div id="df-88dd888a-d5ee-4a87-9fd6-ea7e8b9d50fd" class="colab-df-container">
        <div>
    <style scoped>
        .dataframe tbody tr th:only-of-type {
            vertical-align: middle;
        }
    
        .dataframe tbody tr th {
            vertical-align: top;
        }
    
        .dataframe thead th {
            text-align: right;
        }
    </style>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>Razón Social</th>
          <th>Margen EBIT</th>
          <th>Carga financiera</th>
          <th>Margen neto</th>
          <th>CxC</th>
          <th>CxP</th>
          <th>Solvencia</th>
          <th>Apalancamiento</th>
          <th>En Reorganización</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>AACER SAS</td>
          <td>0.071690</td>
          <td>0.000000</td>
          <td>0.042876</td>
          <td>0.104095</td>
          <td>0.153192</td>
          <td>1.877078</td>
          <td>1.642505</td>
          <td>0</td>
        </tr>
        <tr>
          <th>1</th>
          <td>ABARROTES EL ROMPOY SAS</td>
          <td>0.017816</td>
          <td>0.000000</td>
          <td>0.010767</td>
          <td>0.018414</td>
          <td>0.000000</td>
          <td>0.000000</td>
          <td>0.865044</td>
          <td>0</td>
        </tr>
        <tr>
          <th>2</th>
          <td>ABASTECIMIENTOS INDUSTRIALES SAS</td>
          <td>0.144646</td>
          <td>0.054226</td>
          <td>0.059784</td>
          <td>0.227215</td>
          <td>0.025591</td>
          <td>1.077412</td>
          <td>1.272299</td>
          <td>0</td>
        </tr>
        <tr>
          <th>3</th>
          <td>ACME LEON PLASTICOS SAS</td>
          <td>0.004465</td>
          <td>0.000000</td>
          <td>-0.013995</td>
          <td>0.073186</td>
          <td>0.127866</td>
          <td>0.000000</td>
          <td>1.391645</td>
          <td>0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>ADVANCED PRODUCTS COLOMBIA SAS</td>
          <td>0.141829</td>
          <td>0.050810</td>
          <td>0.053776</td>
          <td>0.398755</td>
          <td>0.147678</td>
          <td>0.675073</td>
          <td>2.118774</td>
          <td>0</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-88dd888a-d5ee-4a87-9fd6-ea7e8b9d50fd')"
                title="Convert this dataframe to an interactive table."
                style="display:none;">
    
      <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960">
        <path d="M120-120v-720h720v720H120Zm60-500h600v-160H180v160Zm220 220h160v-160H400v160Zm0 220h160v-160H400v160ZM180-400h160v-160H180v160Zm440 0h160v-160H620v160ZM180-180h160v-160H180v160Zm440 0h160v-160H620v160Z"/>
      </svg>
        </button>
    
      <style>
        .colab-df-container {
          display:flex;
          gap: 12px;
        }
    
        .colab-df-convert {
          background-color: #E8F0FE;
          border: none;
          border-radius: 50%;
          cursor: pointer;
          display: none;
          fill: #1967D2;
          height: 32px;
          padding: 0 0 0 0;
          width: 32px;
        }
    
        .colab-df-convert:hover {
          background-color: #E2EBFA;
          box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
          fill: #174EA6;
        }
    
        .colab-df-buttons div {
          margin-bottom: 4px;
        }
    
        [theme=dark] .colab-df-convert {
          background-color: #3B4455;
          fill: #D2E3FC;
        }
    
        [theme=dark] .colab-df-convert:hover {
          background-color: #434B5C;
          box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
          filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
          fill: #FFFFFF;
        }
      </style>
    
        <script>
          const buttonEl =
            document.querySelector('#df-88dd888a-d5ee-4a87-9fd6-ea7e8b9d50fd button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-88dd888a-d5ee-4a87-9fd6-ea7e8b9d50fd');
            const dataTable =
              await google.colab.kernel.invokeFunction('convertToInteractive',
                                                        [key], {});
            if (!dataTable) return;
    
            const docLinkHtml = 'Like what you see? Visit the ' +
              '<a target="_blank" href=https://colab.research.google.com/notebooks/data_table.ipynb>data table notebook</a>'
              + ' to learn more about interactive tables.';
            element.innerHTML = '';
            dataTable['output_type'] = 'display_data';
            await google.colab.output.renderOutput(dataTable, element);
            const docLink = document.createElement('div');
            docLink.innerHTML = docLinkHtml;
            element.appendChild(docLink);
          }
        </script>
      </div>
    
    
        </div>
      </div>
    



.. code:: ipython3

    df.info()


.. parsed-literal::

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 629 entries, 0 to 628
    Data columns (total 9 columns):
     #   Column             Non-Null Count  Dtype  
    ---  ------             --------------  -----  
     0   Razón Social       629 non-null    object 
     1   Margen EBIT        629 non-null    float64
     2   Carga financiera   629 non-null    float64
     3   Margen neto        629 non-null    float64
     4   CxC                629 non-null    float64
     5   CxP                629 non-null    float64
     6   Solvencia          629 non-null    float64
     7   Apalancamiento     629 non-null    float64
     8   En Reorganización  629 non-null    int64  
    dtypes: float64(7), int64(1), object(1)
    memory usage: 44.4+ KB
    

Cambio de variables:
~~~~~~~~~~~~~~~~~~~~

De acuerdo con el Análisis Exploratorio de Datos (EDA), se identificó
que las variables **Margen neto, CxP, Solvencia y Apalancamiento**
presentan las mayores diferencias en sus distribuciones empíricas entre
las dos clases.

.. code:: ipython3

    # ------------------------
    # Selección de variables
    # ------------------------
    variables_seleccionadas = ['Margen neto',
                               'CxP',
                               'Solvencia',
                               'Apalancamiento']
    
    # Variable objetivo
    target = 'En Reorganización'
    
    # ------------------------
    # Preparar datos
    # ------------------------
    X = df[variables_seleccionadas]
    y = df[target]
    
    # Estandarizar variables
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)
    
    # Dividir en entrenamiento y prueba (70%-30%)
    X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.3, random_state=35, stratify=y)

.. code:: ipython3

    resultados = entrenar_modelos_rna(
        X_train, y_train, X_test, y_test,
        cantidad_modelos=10,
        units=[5, 8, 10, 12, 15, 18, 20, 22, 24],
        n_hidden=[1, 2],
        activation=['relu', 'tanh', 'selu', 'elu'],
        learning_rate=[0.001, 0.01, 0.1],
        batch_size=[16, 32, 64],
        optimizer=['Adam', 'RMSprop'],  # También puede ser: 'SGD', 'Adagrad', 'Adadelta', 'Adamax', 'Nadam', 'Ftrl'
        Dropout_rate=[0.2],
        epochs=200,
        tipo_clasificacion="binaria",   # "binaria" o "multiclase"
    )


.. parsed-literal::

    
    Modelo 1
    Units: 12, Hidden: 1, Activation: relu, LR: 0.01
    Optimizer: Adam, Batch: 64, Dropout: 0.2, epochs: 200
    Accuracy train: 0.7841, test: 0.7672
    Recall train: 0.6862, test: 0.7379
    Precision train: 0.8913, test: 0.8172
    


.. image:: output_10_1.png


.. parsed-literal::

    
    Modelo 2
    Units: 18, Hidden: 1, Activation: relu, LR: 0.001
    Optimizer: RMSprop, Batch: 64, Dropout: 0.2, epochs: 200
    Accuracy train: 0.7455, test: 0.7354
    Recall train: 0.6904, test: 0.7379
    Precision train: 0.8128, test: 0.7677
    


.. image:: output_10_3.png


.. parsed-literal::

    
    Modelo 3
    Units: 20, Hidden: 1, Activation: tanh, LR: 0.01
    Optimizer: RMSprop, Batch: 16, Dropout: 0.2, epochs: 200
    Accuracy train: 0.7523, test: 0.7566
    Recall train: 0.6904, test: 0.7767
    Precision train: 0.8250, test: 0.7767
    


.. image:: output_10_5.png


.. parsed-literal::

    
    Modelo 4
    Units: 8, Hidden: 1, Activation: selu, LR: 0.01
    Optimizer: Adam, Batch: 16, Dropout: 0.2, epochs: 200
    Accuracy train: 0.7432, test: 0.7460
    Recall train: 0.6695, test: 0.7184
    Precision train: 0.8247, test: 0.7957
    


.. image:: output_10_7.png


.. parsed-literal::

    
    Modelo 5
    Units: 20, Hidden: 1, Activation: selu, LR: 0.001
    Optimizer: RMSprop, Batch: 16, Dropout: 0.2, epochs: 200
    Accuracy train: 0.7273, test: 0.7249
    Recall train: 0.7238, test: 0.7961
    Precision train: 0.7621, test: 0.7257
    


.. image:: output_10_9.png


.. parsed-literal::

    
    Modelo 6
    Units: 18, Hidden: 2, Activation: tanh, LR: 0.01
    Optimizer: RMSprop, Batch: 16, Dropout: 0.2, epochs: 200
    Accuracy train: 0.8068, test: 0.7725
    Recall train: 0.7992, test: 0.8155
    Precision train: 0.8377, test: 0.7778
    


.. image:: output_10_11.png


.. parsed-literal::

    
    Modelo 7
    Units: 5, Hidden: 1, Activation: relu, LR: 0.1
    Optimizer: RMSprop, Batch: 64, Dropout: 0.2, epochs: 200
    Accuracy train: 0.7636, test: 0.7143
    Recall train: 0.5983, test: 0.5631
    Precision train: 0.9470, test: 0.8657
    


.. image:: output_10_13.png


.. parsed-literal::

    
    Modelo 8
    Units: 8, Hidden: 1, Activation: selu, LR: 0.001
    Optimizer: RMSprop, Batch: 32, Dropout: 0.2, epochs: 200
    Accuracy train: 0.7091, test: 0.7302
    Recall train: 0.7113, test: 0.8058
    Precision train: 0.7424, test: 0.7281
    


.. image:: output_10_15.png


.. parsed-literal::

    
    Modelo 9
    Units: 10, Hidden: 2, Activation: selu, LR: 0.01
    Optimizer: Adam, Batch: 16, Dropout: 0.2, epochs: 200
    Accuracy train: 0.7795, test: 0.7407
    Recall train: 0.6485, test: 0.6505
    Precision train: 0.9226, test: 0.8375
    


.. image:: output_10_17.png


.. parsed-literal::

    
    Modelo 10
    Units: 12, Hidden: 2, Activation: elu, LR: 0.01
    Optimizer: RMSprop, Batch: 16, Dropout: 0.2, epochs: 200
    Accuracy train: 0.7955, test: 0.7566
    Recall train: 0.7699, test: 0.7961
    Precision train: 0.8402, test: 0.7664
    


.. image:: output_10_19.png


Mejor modelo
~~~~~~~~~~~~

**Modelo: 6:** Units: 18, Hidden: 2, Activation: tanh, LR: 0.01,
Optimizer: RMSprop, Batch: 16, Dropout: 0.2, epochs: 200

.. code:: ipython3

    model = load_model("modelo_6.keras")
    
    # Probabilidades:
    y_prob_train = model.predict(X_train)
    y_prob = model.predict(X_test)
    
    # Definición de las clases con umbral:
    y_pred_train  = np.where(y_prob_train > 0.5, 1, 0)
    y_pred = np.where(y_prob > 0.5, 1, 0)
    
    # ------------------------
    # Evaluación del modelo
    # ------------------------
    
    # =========================================================
    # 1. Matrices de confusión
    # =========================================================
    cm_train = confusion_matrix(y_train, y_pred_train, labels=[0, 1])
    cm_test  = confusion_matrix(y_test, y_pred, labels=[0, 1])
    
    cm_df_train = pd.DataFrame(
        cm_train,
        index=["Real: No Reorg.", "Real: Reorg."],
        columns=["Pred: No Reorg.", "Pred: Reorg."]
    )
    
    cm_df_test = pd.DataFrame(
        cm_test,
        index=["Real: No Reorg.", "Real: Reorg."],
        columns=["Pred: No Reorg.", "Pred: Reorg."]
    )
    
    # =========================================================
    # 2. Estilo visual
    # =========================================================
    cmap = mpl.colormaps["viridis"]
    
    BG_FIG   = "#f7f7f7"
    BG_AX    = "#ffffff"
    GRID_COL = "#d9d9d9"
    TEXT_COL = "#1f1f1f"
    SUB_COL  = "#4d4d4d"
    
    TITLE_FS    = 20
    SUBTITLE_FS = 12
    LABEL_FS    = 12
    TICK_FS     = 11
    ANNOT_FS    = 16
    
    sns.set_theme(style="white")
    
    # =========================================================
    # 3. Figura con dos paneles
    # =========================================================
    fig, axes = plt.subplots(1, 2, figsize=(12, 5.5), facecolor=BG_FIG)
    
    fig.suptitle(
        "Matrices de confusión",
        fontsize=TITLE_FS,
        fontweight="bold",
        color=TEXT_COL,
        y=0.98
    )
    
    # =========================================================
    # 4. Función para dibujar cada heatmap
    # =========================================================
    def plot_conf_matrix(ax, cm_df, title):
        ax.set_facecolor(BG_AX)
    
        hm = sns.heatmap(
            cm_df,
            annot=True,
            fmt="d",
            cmap=cmap,
            cbar=True,
            linewidths=0.8,
            linecolor=GRID_COL,
            square=True,
            annot_kws={
                "fontsize": ANNOT_FS,
                "fontweight": "bold",
                "color": TEXT_COL
            },
            cbar_kws={"shrink": 0.85},
            ax=ax
        )
    
        ax.set_title(
            title,
            fontsize=15,
            fontweight="bold",
            color=TEXT_COL,
            pad=10
        )
    
        ax.set_xlabel(
            "Clase predicha",
            fontsize=LABEL_FS,
            fontweight="bold",
            color=SUB_COL
        )
    
        ax.set_ylabel(
            "Clase real",
            fontsize=LABEL_FS,
            fontweight="bold",
            color=SUB_COL
        )
    
        ax.tick_params(axis='x', labelsize=TICK_FS, colors=TEXT_COL, rotation=0)
        ax.tick_params(axis='y', labelsize=TICK_FS, colors=TEXT_COL, rotation=0)
    
        for lbl in ax.get_xticklabels() + ax.get_yticklabels():
            lbl.set_fontweight("bold")
    
        # Estilo del colorbar
        cbar = hm.collections[0].colorbar
        cbar.ax.tick_params(labelsize=10, colors=TEXT_COL)
        for t in cbar.ax.get_yticklabels():
            t.set_fontweight("bold")
    
        for spine in ax.spines.values():
            spine.set_edgecolor(GRID_COL)
            spine.set_linewidth(0.8)
    
    # =========================================================
    # 5. Dibujar train y test
    # =========================================================
    plot_conf_matrix(axes[0], cm_df_train, "Train")
    plot_conf_matrix(axes[1], cm_df_test, "Test")
    
    plt.tight_layout(rect=[0.03, 0.08, 0.98, 0.92])
    plt.show()
    
    print("\n=== Reporte de Clasificación - train ===")
    print(classification_report(y_train, y_pred_train))
    
    print("\n=== Reporte de Clasificación - test ===")
    print(classification_report(y_test, y_pred))


.. parsed-literal::

    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 6ms/step
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    


.. image:: output_13_1.png


.. parsed-literal::

    
    === Reporte de Clasificación - train ===
                  precision    recall  f1-score   support
    
               0       0.77      0.82      0.79       201
               1       0.84      0.80      0.82       239
    
        accuracy                           0.81       440
       macro avg       0.81      0.81      0.81       440
    weighted avg       0.81      0.81      0.81       440
    
    
    === Reporte de Clasificación - test ===
                  precision    recall  f1-score   support
    
               0       0.77      0.72      0.74        86
               1       0.78      0.82      0.80       103
    
        accuracy                           0.77       189
       macro avg       0.77      0.77      0.77       189
    weighted avg       0.77      0.77      0.77       189
    
    
