Ejemplo árboles de decisión empresas en re organización
-------------------------------------------------------

.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import matplotlib.ticker as mtick
    import seaborn as sns
    from sklearn.model_selection import train_test_split
    from sklearn.tree import DecisionTreeClassifier
    from sklearn import tree
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import classification_report, confusion_matrix, roc_auc_score, roc_curve
    from sklearn.metrics import ConfusionMatrixDisplay, precision_score, precision_recall_curve, recall_score, accuracy_score, f1_score

.. code:: ipython3

    # path = "BD empresas re organización.xlsx"
    
    path = "BD empresas en re organización.xlsx"
    
    xls = pd.ExcelFile(path)
    
    df = pd.read_excel(path, sheet_name=xls.sheet_names[0])
    
    df.head()




.. raw:: html

    
      <div id="df-24e81a98-01e9-43df-b687-330ae712639a" class="colab-df-container">
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
        <button class="colab-df-convert" onclick="convertToInteractive('df-24e81a98-01e9-43df-b687-330ae712639a')"
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
            document.querySelector('#df-24e81a98-01e9-43df-b687-330ae712639a button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-24e81a98-01e9-43df-b687-330ae712639a');
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

    # Conteo absoluto
    conteo_clases = df['En Reorganización'].value_counts()
    # Porcentaje
    porcentaje_clases = df['En Reorganización'].value_counts(normalize=True) * 100
    
    # Mostrar conteo y porcentaje
    print("Cantidad de empresas por clase:")
    print(conteo_clases)
    print("\nPorcentaje de empresas por clase:")
    print(porcentaje_clases.round(2))


.. parsed-literal::

    Cantidad de empresas por clase:
    En Reorganización
    1    342
    0    287
    Name: count, dtype: int64
    
    Porcentaje de empresas por clase:
    En Reorganización
    1    54.37
    0    45.63
    Name: proportion, dtype: float64
    

Árboles de decisión:
~~~~~~~~~~~~~~~~~~~~

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
    # scaler = StandardScaler()
    # X_scaled = scaler.fit_transform(X)
    
    # Dividir en entrenamiento y prueba (70%-30%)
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=35, stratify=y)

``stratify=y`` le dice a ``train_test_split`` que mantenga la misma
proporción de clases de ``y`` (variable objetivo) en los subconjuntos de
train y test.

.. code:: ipython3

    # ------------------------
    # Ajustar el modelo
    # ------------------------
    model = DecisionTreeClassifier(
        max_depth=None, min_samples_split=10, min_samples_leaf=2, random_state=34
    )
    model.fit(X_train, y_train)
    
    # ------------------------
    # Predicciones
    # ------------------------
    y_pred_train = model.predict(X_train)
    y_prob_train = model.predict_proba(X_train)[:, 1]
    
    y_pred = model.predict(X_test)
    y_prob = model.predict_proba(X_test)[:, 1]

.. code:: ipython3

    # ------------------------
    # Evaluación del modelo
    # ------------------------
    cm_train = confusion_matrix(y_train, y_pred_train, labels=[0,1])
    cm_df_train = pd.DataFrame(cm_train, index=["Real 0", "Real 1"], columns=["Predicho 0", "Predicho 1"])
    
    plt.figure(figsize=(5.2,4.2))
    sns.heatmap(cm_train, annot=True, fmt="d", cbar=True, linewidths=.5, cmap="coolwarm")
    plt.title("Matriz de confusión - train")
    plt.xlabel("Predicho"); plt.ylabel("Real")
    plt.tight_layout()
    plt.show()
    
    cm = confusion_matrix(y_test, y_pred, labels=[0,1])
    cm_df = pd.DataFrame(cm, index=["Real 0", "Real 1"], columns=["Predicho 0", "Predicho 1"])
    
    plt.figure(figsize=(5.2,4.2))
    sns.heatmap(cm_df, annot=True, fmt="d", cbar=True, linewidths=.5, cmap="coolwarm")
    plt.title("Matriz de confusión - Test")
    plt.xlabel("Predicho"); plt.ylabel("Real")
    plt.tight_layout()
    plt.show()



.. image:: output_8_0.png



.. image:: output_8_1.png


.. code:: ipython3

    print("\n=== Reporte de Clasificación - train ===")
    print(classification_report(y_train, y_pred_train))
    
    print("\n=== Reporte de Clasificación - test ===")
    print(classification_report(y_test, y_pred))


.. parsed-literal::

    
    === Reporte de Clasificación - train ===
                  precision    recall  f1-score   support
    
               0       0.93      0.93      0.93       201
               1       0.94      0.94      0.94       239
    
        accuracy                           0.93       440
       macro avg       0.93      0.93      0.93       440
    weighted avg       0.93      0.93      0.93       440
    
    
    === Reporte de Clasificación - test ===
                  precision    recall  f1-score   support
    
               0       0.83      0.80      0.82        86
               1       0.84      0.86      0.85       103
    
        accuracy                           0.84       189
       macro avg       0.84      0.83      0.83       189
    weighted avg       0.84      0.84      0.84       189
    
    

.. code:: ipython3

    # ============================
    # ROC AUC Score
    # ============================
    auc_train = roc_auc_score(y_train, y_prob_train)
    auc_test = roc_auc_score(y_test, y_prob)
    
    print(f"ROC AUC - Train: {auc_train:.3f}")
    print(f"ROC AUC - Test : {auc_test:.3f}")
    
    # ============================
    # Curva ROC (Train y Test)
    # ============================
    fpr_train, tpr_train, _ = roc_curve(y_train, y_prob_train)
    fpr_test, tpr_test, _ = roc_curve(y_test, y_prob)
    
    plt.figure(figsize=(8, 6))
    plt.plot(fpr_train, tpr_train, label=f'Train (AUC = {auc_train:.2f})', color='blue')
    plt.plot(fpr_test, tpr_test, label=f'Test  (AUC = {auc_test:.2f})', color='orange')
    plt.plot([0, 1], [0, 1], 'k--', label='Azar')
    plt.xlabel("False Positive Rate")
    plt.ylabel("True Positive Rate")
    plt.title("Curva ROC - Train y Test")
    plt.legend(loc="lower right")
    plt.grid(True)
    plt.tight_layout()
    plt.show()


.. parsed-literal::

    ROC AUC - Train: 0.989
    ROC AUC - Test : 0.883
    


.. image:: output_10_1.png


.. code:: ipython3

    # Calcular precisión y recall para diferentes umbrales
    precision, recall, thresholds = precision_recall_curve(y_test, y_prob)
    
    # Agregar el umbral 0 para completar el array de thresholds
    thresholds = np.append(thresholds, 1)
    
    # Graficar precisión y recall en función del umbral
    plt.figure(figsize=(10, 6))
    plt.plot(thresholds, precision, label="Precisión")
    plt.plot(thresholds, recall, label="Recall")
    plt.xlabel("Umbral")
    plt.ylabel("Precisión/Recall")
    plt.title("Precisión y Recall en función del umbral")
    plt.legend()
    plt.grid(True)
    plt.show()



.. image:: output_11_0.png


.. code:: ipython3

    plt.figure(figsize=(8, 6))
    plt.plot(recall, precision, marker=".", label="Regresión Logística")
    plt.xlabel("Recall")
    plt.ylabel("Precisión")
    plt.title("Curva de Precisión-Recall")
    plt.legend()
    plt.grid(True)
    plt.show()



.. image:: output_12_0.png


.. code:: ipython3

    y_prob




.. parsed-literal::

    array([0.57142857, 0.        , 0.5       , 0.5       , 0.        ,
           0.66666667, 0.        , 0.        , 0.        , 1.        ,
           0.        , 0.66666667, 0.        , 0.        , 1.        ,
           0.5       , 0.        , 1.        , 0.16666667, 0.        ,
           0.8       , 1.        , 0.        , 0.        , 1.        ,
           1.        , 1.        , 1.        , 0.57142857, 1.        ,
           0.        , 0.        , 1.        , 1.        , 1.        ,
           1.        , 0.        , 1.        , 1.        , 0.57142857,
           1.        , 0.6       , 1.        , 0.        , 0.        ,
           1.        , 1.        , 0.        , 0.57142857, 0.        ,
           1.        , 0.25      , 0.        , 1.        , 1.        ,
           0.        , 0.        , 1.        , 0.        , 0.        ,
           0.        , 1.        , 0.        , 1.        , 0.        ,
           1.        , 0.6       , 0.2       , 0.57142857, 1.        ,
           0.        , 0.        , 0.66666667, 0.25      , 0.2       ,
           1.        , 0.        , 0.66666667, 0.        , 0.        ,
           0.        , 0.        , 0.        , 0.        , 0.        ,
           1.        , 1.        , 0.        , 1.        , 1.        ,
           1.        , 0.        , 0.66666667, 1.        , 1.        ,
           1.        , 0.        , 1.        , 0.        , 1.        ,
           0.        , 1.        , 1.        , 0.66666667, 1.        ,
           1.        , 0.        , 0.        , 1.        , 1.        ,
           0.        , 0.66666667, 0.        , 1.        , 0.        ,
           0.2       , 1.        , 0.        , 0.        , 0.        ,
           1.        , 1.        , 1.        , 1.        , 1.        ,
           0.66666667, 0.        , 0.66666667, 0.        , 0.        ,
           0.        , 1.        , 1.        , 1.        , 0.66666667,
           1.        , 1.        , 0.6       , 0.66666667, 1.        ,
           0.        , 0.5       , 0.        , 1.        , 1.        ,
           1.        , 1.        , 1.        , 0.57142857, 0.        ,
           1.        , 0.6       , 1.        , 1.        , 0.        ,
           0.5       , 0.        , 1.        , 1.        , 1.        ,
           1.        , 0.5       , 0.        , 0.66666667, 1.        ,
           1.        , 0.5       , 1.        , 0.57142857, 0.        ,
           1.        , 0.        , 1.        , 0.5       , 1.        ,
           0.        , 0.5       , 0.        , 1.        , 0.8       ,
           0.66666667, 0.        , 1.        , 1.        , 0.        ,
           1.        , 0.        , 0.        , 0.6       ])



.. code:: ipython3

    # DataFrame con probas y clase real
    df_deciles = pd.DataFrame({'y_real': y_test, 'y_proba': y_prob})
    
    # Crear deciles (1 = más alto riesgo, 10 = más bajo)
    df_deciles['Decil'] = pd.qcut(df_deciles['y_proba'], 10, labels=False, duplicates='drop') + 1
    df_deciles['Decil'] = 11 - df_deciles['Decil']   # invertir para que el decil 1 sea el de mayor riesgo
    
    # Calcular tasa por decil
    tabla_deciles = df_deciles.groupby('Decil').agg(
        Total=('y_real','count'),
        Positivos=('y_real','sum')
    )
    tabla_deciles['Tasa'] = tabla_deciles['Positivos'] / tabla_deciles['Total']
    tabla_deciles['Lift'] = tabla_deciles['Tasa'] / df_deciles['y_real'].mean()
    tabla_deciles['Captura_Acum'] = tabla_deciles['Positivos'].cumsum() / df_deciles['y_real'].sum()
    
    print(f"Tasa de positivos reales en test: {df_deciles['y_real'].mean():.2f}")
    
    print(tabla_deciles)
    
    # --- 📊 Gráfico ---
    plt.figure(figsize=(8,5))
    plt.plot(tabla_deciles.index, tabla_deciles['Tasa'], marker='o', linestyle='-', color='blue')
    plt.title("Tasa de positivos por decil")
    plt.xlabel("Decil")
    plt.ylabel("Tasa de clase 1")
    plt.grid(True)
    plt.show()


.. parsed-literal::

    Tasa de positivos reales en test: 0.54
           Total  Positivos      Tasa      Lift  Captura_Acum
    Decil                                                    
    8         94         80  0.851064  1.561661      0.776699
    9         12          9  0.750000  1.376214      0.864078
    10        83         14  0.168675  0.309510      1.000000
    


.. image:: output_14_1.png


Cambio de umbral:
~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Crear lista de umbrales a evaluar
    umbrales = np.arange(0.1, 0.91, 0.05)
    
    # Lista para almacenar resultados
    resultados = []
    
    for umbral in umbrales:
        y_pred_umbral = (y_prob >= umbral).astype(int)
        tn, fp, fn, tp = confusion_matrix(y_test, y_pred_umbral).ravel()
    
        precision = precision_score(y_test, y_pred_umbral, zero_division=0)
        recall = recall_score(y_test, y_pred_umbral)
        specificity = tn / (tn + fp)
        accuracy = accuracy_score(y_test, y_pred_umbral)
        f1 = f1_score(y_test, y_pred_umbral)
    
        resultados.append({
            'Umbral': umbral,
            'Precision': precision,
            'Recall (Sensibilidad)': recall,
            'Especificidad': specificity,
            'Accuracy': accuracy,
            'F1-score': f1
        })
    
    # Convertir a DataFrame
    df_resultados = pd.DataFrame(resultados)
    
    # Mostrar tabla
    plt.figure(figsize=(12, 6))
    sns.lineplot(data=df_resultados.set_index('Umbral'))
    plt.title('Métricas por Umbral de Decisión')
    plt.ylabel('Valor')
    plt.gca().yaxis.set_major_formatter(mtick.PercentFormatter(1.0))
    plt.grid(True)
    plt.show()
    
    df_resultados
    



.. image:: output_16_0.png




.. raw:: html

    
      <div id="df-39a50cc8-cd4c-4d5a-8a75-0b20ec13888f" class="colab-df-container">
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
          <th>Umbral</th>
          <th>Precision</th>
          <th>Recall (Sensibilidad)</th>
          <th>Especificidad</th>
          <th>Accuracy</th>
          <th>F1-score</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>0.10</td>
          <td>0.776860</td>
          <td>0.912621</td>
          <td>0.686047</td>
          <td>0.809524</td>
          <td>0.839286</td>
        </tr>
        <tr>
          <th>1</th>
          <td>0.15</td>
          <td>0.776860</td>
          <td>0.912621</td>
          <td>0.686047</td>
          <td>0.809524</td>
          <td>0.839286</td>
        </tr>
        <tr>
          <th>2</th>
          <td>0.20</td>
          <td>0.786325</td>
          <td>0.893204</td>
          <td>0.709302</td>
          <td>0.809524</td>
          <td>0.836364</td>
        </tr>
        <tr>
          <th>3</th>
          <td>0.25</td>
          <td>0.800000</td>
          <td>0.893204</td>
          <td>0.732558</td>
          <td>0.820106</td>
          <td>0.844037</td>
        </tr>
        <tr>
          <th>4</th>
          <td>0.30</td>
          <td>0.800000</td>
          <td>0.893204</td>
          <td>0.732558</td>
          <td>0.820106</td>
          <td>0.844037</td>
        </tr>
        <tr>
          <th>5</th>
          <td>0.35</td>
          <td>0.800000</td>
          <td>0.893204</td>
          <td>0.732558</td>
          <td>0.820106</td>
          <td>0.844037</td>
        </tr>
        <tr>
          <th>6</th>
          <td>0.40</td>
          <td>0.800000</td>
          <td>0.893204</td>
          <td>0.732558</td>
          <td>0.820106</td>
          <td>0.844037</td>
        </tr>
        <tr>
          <th>7</th>
          <td>0.45</td>
          <td>0.800000</td>
          <td>0.893204</td>
          <td>0.732558</td>
          <td>0.820106</td>
          <td>0.844037</td>
        </tr>
        <tr>
          <th>8</th>
          <td>0.50</td>
          <td>0.839623</td>
          <td>0.864078</td>
          <td>0.802326</td>
          <td>0.835979</td>
          <td>0.851675</td>
        </tr>
        <tr>
          <th>9</th>
          <td>0.55</td>
          <td>0.839623</td>
          <td>0.864078</td>
          <td>0.802326</td>
          <td>0.835979</td>
          <td>0.851675</td>
        </tr>
        <tr>
          <th>10</th>
          <td>0.60</td>
          <td>0.851064</td>
          <td>0.776699</td>
          <td>0.837209</td>
          <td>0.804233</td>
          <td>0.812183</td>
        </tr>
        <tr>
          <th>11</th>
          <td>0.65</td>
          <td>0.851064</td>
          <td>0.776699</td>
          <td>0.837209</td>
          <td>0.804233</td>
          <td>0.812183</td>
        </tr>
        <tr>
          <th>12</th>
          <td>0.70</td>
          <td>0.913580</td>
          <td>0.718447</td>
          <td>0.918605</td>
          <td>0.809524</td>
          <td>0.804348</td>
        </tr>
        <tr>
          <th>13</th>
          <td>0.75</td>
          <td>0.913580</td>
          <td>0.718447</td>
          <td>0.918605</td>
          <td>0.809524</td>
          <td>0.804348</td>
        </tr>
        <tr>
          <th>14</th>
          <td>0.80</td>
          <td>0.924051</td>
          <td>0.708738</td>
          <td>0.930233</td>
          <td>0.809524</td>
          <td>0.802198</td>
        </tr>
        <tr>
          <th>15</th>
          <td>0.85</td>
          <td>0.924051</td>
          <td>0.708738</td>
          <td>0.930233</td>
          <td>0.809524</td>
          <td>0.802198</td>
        </tr>
        <tr>
          <th>16</th>
          <td>0.90</td>
          <td>0.924051</td>
          <td>0.708738</td>
          <td>0.930233</td>
          <td>0.809524</td>
          <td>0.802198</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-39a50cc8-cd4c-4d5a-8a75-0b20ec13888f')"
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
            document.querySelector('#df-39a50cc8-cd4c-4d5a-8a75-0b20ec13888f button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-39a50cc8-cd4c-4d5a-8a75-0b20ec13888f');
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

    umbral_optimo = 0.55
    
    y_pred_final = (y_prob >= umbral_optimo).astype(int)
    
    cm_df_final = confusion_matrix(y_test, y_pred_final)
    
    plt.figure(figsize=(5.2,4.2))
    sns.heatmap(cm_df_final, annot=True, fmt="d", cbar=True, linewidths=.5, cmap="coolwarm")
    plt.title("Matriz de confusión - Test")
    plt.xlabel("Predicho"); plt.ylabel("Real")
    plt.tight_layout()
    plt.show()
    
    print("\nReporte de Clasificación:")
    print(classification_report(y_test, y_pred_final))
    
    print(f"ROC AUC: {roc_auc_score(y_test, y_prob):.3f}")



.. image:: output_17_0.png


.. parsed-literal::

    
    Reporte de Clasificación:
                  precision    recall  f1-score   support
    
               0       0.83      0.80      0.82        86
               1       0.84      0.86      0.85       103
    
        accuracy                           0.84       189
       macro avg       0.84      0.83      0.83       189
    weighted avg       0.84      0.84      0.84       189
    
    ROC AUC: 0.883
    

.. code:: ipython3

    # DataFrame con probas y clase real
    df_deciles = pd.DataFrame({'y_real': y_pred_final, 'y_proba': y_prob})
    
    # Crear deciles (1 = más alto riesgo, 10 = más bajo)
    df_deciles['Decil'] = pd.qcut(df_deciles['y_proba'], 10, labels=False, duplicates='drop') + 1
    df_deciles['Decil'] = 11 - df_deciles['Decil']   # invertir para que el decil 1 sea el de mayor riesgo
    
    # Calcular tasa por decil
    tabla_deciles = df_deciles.groupby('Decil').agg(
        Total=('y_real','count'),
        Positivos=('y_real','sum')
    )
    tabla_deciles['Tasa'] = tabla_deciles['Positivos'] / tabla_deciles['Total']
    tabla_deciles['Lift'] = tabla_deciles['Tasa'] / df_deciles['y_real'].mean()
    tabla_deciles['Captura_Acum'] = tabla_deciles['Positivos'].cumsum() / df_deciles['y_real'].sum()
    
    print(f"Tasa de positivos reales en test: {df_deciles['y_real'].mean():.2f}")
    
    print(tabla_deciles)
    
    # --- 📊 Gráfico ---
    plt.figure(figsize=(8,5))
    plt.plot(tabla_deciles.index, tabla_deciles['Tasa'], marker='o', linestyle='-', color='blue')
    plt.title("Tasa de positivos por decil")
    plt.xlabel("Decil")
    plt.ylabel("Tasa de clase 1")
    plt.grid(True)
    plt.show()


.. parsed-literal::

    Tasa de positivos reales en test: 0.56
           Total  Positivos  Tasa      Lift  Captura_Acum
    Decil                                                
    8         94         94   1.0  1.783019      0.886792
    9         12         12   1.0  1.783019      1.000000
    10        83          0   0.0  0.000000      1.000000
    


.. image:: output_18_1.png

