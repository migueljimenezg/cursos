Optimización de Hiperparámetros - Empresas en Reorganización
------------------------------------------------------------

.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import seaborn as sns
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import classification_report, confusion_matrix, accuracy_score, recall_score, precision_score
    from keras.models import Sequential
    from keras.layers import Dense, Input, Dropout
    from keras import optimizers
    from keras.models import load_model

.. code:: ipython3

    path = "BD empresas en re organización.xlsx"
    
    xls = pd.ExcelFile(path)
    
    df = pd.read_excel(path, sheet_name=xls.sheet_names[0])
    
    df.head()




.. raw:: html

    
      <div id="df-9f69ac0f-3afc-43de-be55-237f4755d95f" class="colab-df-container">
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
        <button class="colab-df-convert" onclick="convertToInteractive('df-9f69ac0f-3afc-43de-be55-237f4755d95f')"
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
            document.querySelector('#df-9f69ac0f-3afc-43de-be55-237f4755d95f button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-9f69ac0f-3afc-43de-be55-237f4755d95f');
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
    

.. code:: ipython3

    # ------------------------
    # Selección de variables
    # ------------------------
    variables_seleccionadas = ['Margen EBIT',
                               'Carga financiera',
                               'Margen neto',
                               'CxC',
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

Optimización de Hiperparámetros
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    cantidad_modelos = 10
    
    for i in range(cantidad_modelos):
    
      units = np.random.choice([5, 8, 10, 12, 15, 18, 20, 22, 24], 1).item()
      n_hidden = np.random.choice([1, 2], 1)[0]
      activation = np.random.choice(['relu', 'tanh', 'selu', 'elu'], 1)[0]
      learning_rate = np.random.choice([0.001, 0.01, 0.1], 1)[0]
      batch_size = np.random.choice([16, 32, 64], 1)[0]
      optimizer = np.random.choice(['Adam', 'RMSprop'], 1)[0]
    
      print(f'Modelo: {i+1}, Units: {units}, Hidden: {n_hidden}, Activation: {activation}, Learning Rate: {learning_rate}, Optimizer: {optimizer}, Batch Size: {batch_size}')
    
      epochs = 200
    
      # Definir el modelo
      best_model = Sequential()
      best_model.add(Input(shape=(X.shape[1],)))
    
      # Loop para las capas ocultas:
    
      for _ in range(n_hidden):
        best_model.add(Dense(units, activation=activation))
        best_model.add(Dropout(0.2))
    
      # Capa de salida:
      best_model.add(Dense(1))
    
      # Optimizador:
      if optimizer == 'Adam':
        optimizer = optimizers.Adam(learning_rate=learning_rate)
      else:
        optimizer = optimizers.RMSprop(learning_rate=learning_rate)
    
      # Compilar el modelo:
      best_model.compile(loss="binary_crossentropy", metrics=["accuracy"], optimizer=optimizer)
    
      # Entrenar el modelo:
      history = best_model.fit(X_train, y_train, epochs=epochs,
                          validation_data=(X_test, y_test),
                          batch_size=batch_size,
                          verbose=0)
    
      # Evaluar el modelo con accuracy:
      y_prob_train = best_model.predict(X_train)
      y_prob = best_model.predict(X_test)
    
      y_pred_train  = np.where(y_prob_train > 0.5, 1, 0)
      y_pred = np.where(y_prob > 0.5, 1, 0)
    
      accuracy_train = accuracy_score(y_train, y_pred_train.flatten())
      accuracy_test = accuracy_score(y_test, y_pred.flatten())
    
      recall_train = recall_score(y_train, y_pred_train.flatten())
      recall_test = recall_score(y_test, y_pred.flatten())
    
      precision_train = precision_score(y_train, y_pred_train.flatten())
      precision_test = precision_score(y_test, y_pred.flatten())
    
      print(f'Accuracy train: {accuracy_train}, Accuracy test: {accuracy_test}')
      print(f'Recall train: {recall_train}, Recall test: {recall_test}')
      print(f'Precision train: {precision_train}, Precision test: {precision_test}')
    
      # Graficar Loss train y Loss test:
    
      plt.plot(history.history['loss'])
      plt.plot(history.history['val_loss'])
      plt.title('Model loss')
      plt.ylabel('Loss')
      plt.xlabel('Epoch')
      plt.legend(['Train', 'Test'], loc='upper left')
      plt.show()
    
      # Guardar el modelo:
      best_model.save(f"best_model_{i+1}.keras")


.. parsed-literal::

    Modelo: 1, Units: 5, Hidden: 1, Activation: selu, Learning Rate: 0.001, Optimizer: RMSprop, Batch Size: 16
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 4ms/step 
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    Accuracy train: 0.7477272727272727, Accuracy test: 0.708994708994709
    Recall train: 0.7447698744769874, Recall test: 0.7087378640776699
    Precision train: 0.7807017543859649, Precision test: 0.7448979591836735
    


.. image:: output_6_1.png


.. parsed-literal::

    Modelo: 2, Units: 20, Hidden: 2, Activation: elu, Learning Rate: 0.001, Optimizer: Adam, Batch Size: 32
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 6ms/step
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    Accuracy train: 0.75, Accuracy test: 0.7195767195767195
    Recall train: 0.7405857740585774, Recall test: 0.7378640776699029
    Precision train: 0.7866666666666666, Precision test: 0.7450980392156863
    


.. image:: output_6_3.png


.. parsed-literal::

    Modelo: 3, Units: 12, Hidden: 2, Activation: relu, Learning Rate: 0.01, Optimizer: Adam, Batch Size: 64
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 8ms/step
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step 
    Accuracy train: 0.8340909090909091, Accuracy test: 0.7777777777777778
    Recall train: 0.698744769874477, Recall test: 0.6699029126213593
    Precision train: 0.9940476190476191, Precision test: 0.8961038961038961
    


.. image:: output_6_5.png


.. parsed-literal::

    Modelo: 4, Units: 8, Hidden: 1, Activation: relu, Learning Rate: 0.1, Optimizer: RMSprop, Batch Size: 64
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 9ms/step 
    Accuracy train: 0.8386363636363636, Accuracy test: 0.798941798941799
    Recall train: 0.7364016736401674, Recall test: 0.7572815533980582
    Precision train: 0.9565217391304348, Precision test: 0.8571428571428571
    


.. image:: output_6_7.png


.. parsed-literal::

    Modelo: 5, Units: 8, Hidden: 2, Activation: relu, Learning Rate: 0.1, Optimizer: Adam, Batch Size: 32
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 6ms/step
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    Accuracy train: 0.7454545454545455, Accuracy test: 0.7619047619047619
    Recall train: 0.5564853556485355, Recall test: 0.5922330097087378
    Precision train: 0.9568345323741008, Precision test: 0.953125
    


.. image:: output_6_9.png


.. parsed-literal::

    Modelo: 6, Units: 18, Hidden: 1, Activation: relu, Learning Rate: 0.01, Optimizer: Adam, Batch Size: 64
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 6ms/step 
    Accuracy train: 0.825, Accuracy test: 0.7724867724867724
    Recall train: 0.7238493723849372, Recall test: 0.7087378640776699
    Precision train: 0.9402173913043478, Precision test: 0.8488372093023255
    


.. image:: output_6_11.png


.. parsed-literal::

    Modelo: 7, Units: 18, Hidden: 2, Activation: selu, Learning Rate: 0.001, Optimizer: Adam, Batch Size: 64
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 6ms/step 
    Accuracy train: 0.7090909090909091, Accuracy test: 0.7037037037037037
    Recall train: 0.7740585774058577, Recall test: 0.8155339805825242
    Precision train: 0.7142857142857143, Precision test: 0.6942148760330579
    


.. image:: output_6_13.png


.. parsed-literal::

    Modelo: 8, Units: 12, Hidden: 2, Activation: elu, Learning Rate: 0.01, Optimizer: RMSprop, Batch Size: 64
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 6ms/step
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    Accuracy train: 0.8113636363636364, Accuracy test: 0.7671957671957672
    Recall train: 0.7196652719665272, Recall test: 0.7087378640776699
    Precision train: 0.9148936170212766, Precision test: 0.8390804597701149
    


.. image:: output_6_15.png


.. parsed-literal::

    Modelo: 9, Units: 15, Hidden: 1, Activation: tanh, Learning Rate: 0.001, Optimizer: RMSprop, Batch Size: 64
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 6ms/step 
    Accuracy train: 0.7295454545454545, Accuracy test: 0.6878306878306878
    Recall train: 0.7824267782426778, Recall test: 0.7475728155339806
    Precision train: 0.7362204724409449, Precision test: 0.7
    


.. image:: output_6_17.png


.. parsed-literal::

    Modelo: 10, Units: 10, Hidden: 2, Activation: selu, Learning Rate: 0.1, Optimizer: Adam, Batch Size: 16
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step 
    Accuracy train: 0.7, Accuracy test: 0.7142857142857143
    Recall train: 0.7615062761506276, Recall test: 0.8349514563106796
    Precision train: 0.708171206225681, Precision test: 0.6991869918699187
    


.. image:: output_6_19.png


Mejor modelo
~~~~~~~~~~~~

**Modelo: 2**, Units: 20, Hidden: 2, Activation: elu, Learning Rate:
0.001, Optimizer: Adam, Batch Size: 32

Se selecciona el **Modelo 2**; sin embargo, esta elección no es única,
ya que depende del criterio del analista y de la métrica de desempeño
que se desee priorizar según el contexto del problem

.. code:: ipython3

    model = load_model("best_model_2.keras")
    
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
    


.. image:: output_10_1.png


.. parsed-literal::

    
    === Reporte de Clasificación - train ===
                  precision    recall  f1-score   support
    
               0       0.71      0.76      0.74       201
               1       0.79      0.74      0.76       239
    
        accuracy                           0.75       440
       macro avg       0.75      0.75      0.75       440
    weighted avg       0.75      0.75      0.75       440
    
    
    === Reporte de Clasificación - test ===
                  precision    recall  f1-score   support
    
               0       0.69      0.70      0.69        86
               1       0.75      0.74      0.74       103
    
        accuracy                           0.72       189
       macro avg       0.72      0.72      0.72       189
    weighted avg       0.72      0.72      0.72       189
    
    
