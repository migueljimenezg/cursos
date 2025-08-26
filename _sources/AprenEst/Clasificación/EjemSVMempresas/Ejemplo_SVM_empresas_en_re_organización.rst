Ejemplo SVM empresas en re organización
---------------------------------------

.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import matplotlib.ticker as mtick
    import seaborn as sns
    from sklearn.model_selection import train_test_split
    from sklearn.svm import SVC
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import classification_report, confusion_matrix, roc_auc_score, roc_curve
    from sklearn.metrics import ConfusionMatrixDisplay, precision_score, precision_recall_curve, recall_score, accuracy_score, f1_score

.. code:: ipython3

    path = "BD empresas en re organización.xlsx"
    
    xls = pd.ExcelFile(path)
    
    df = pd.read_excel(path, sheet_name=xls.sheet_names[0])
    
    df.head()




.. raw:: html

    
      <div id="df-cca8ad9d-3d53-40ce-81ba-d1a4c588394e" class="colab-df-container">
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
        <button class="colab-df-convert" onclick="convertToInteractive('df-cca8ad9d-3d53-40ce-81ba-d1a4c588394e')"
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
            document.querySelector('#df-cca8ad9d-3d53-40ce-81ba-d1a4c588394e button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-cca8ad9d-3d53-40ce-81ba-d1a4c588394e');
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
    

SVM:
~~~~

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

``stratify=y`` le dice a ``train_test_split`` que mantenga la misma
proporción de clases de ``y`` (variable objetivo) en los subconjuntos de
train y test.

.. code:: ipython3

    # ------------------------
    # Ajustar el modelo
    # ------------------------
    model = SVC(kernel="rbf", probability=True)
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
    
               0       0.72      0.88      0.79       201
               1       0.87      0.72      0.79       239
    
        accuracy                           0.79       440
       macro avg       0.80      0.80      0.79       440
    weighted avg       0.81      0.79      0.79       440
    
    
    === Reporte de Clasificación - test ===
                  precision    recall  f1-score   support
    
               0       0.71      0.83      0.76        86
               1       0.83      0.72      0.77       103
    
        accuracy                           0.77       189
       macro avg       0.77      0.77      0.77       189
    weighted avg       0.78      0.77      0.77       189
    
    

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

    ROC AUC - Train: 0.864
    ROC AUC - Test : 0.847
    


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
    1         19         19  1.000000  1.834951      0.184466
    2         19         18  0.947368  1.738375      0.359223
    3         19         18  0.947368  1.738375      0.533981
    4         19         11  0.578947  1.062340      0.640777
    5         18         11  0.611111  1.121359      0.747573
    6         19          6  0.315789  0.579458      0.805825
    7         19          8  0.421053  0.772611      0.883495
    8         19          6  0.315789  0.579458      0.941748
    9         19          4  0.210526  0.386306      0.980583
    10        19          2  0.105263  0.193153      1.000000
    


.. image:: output_13_1.png


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
    



.. image:: output_15_0.png




.. raw:: html

    
      <div id="df-2b51f172-aea1-4a86-9a27-b3b9636ddcc0" class="colab-df-container">
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
          <td>0.551351</td>
          <td>0.990291</td>
          <td>0.034884</td>
          <td>0.555556</td>
          <td>0.708333</td>
        </tr>
        <tr>
          <th>1</th>
          <td>0.15</td>
          <td>0.576271</td>
          <td>0.990291</td>
          <td>0.127907</td>
          <td>0.597884</td>
          <td>0.728571</td>
        </tr>
        <tr>
          <th>2</th>
          <td>0.20</td>
          <td>0.611111</td>
          <td>0.961165</td>
          <td>0.267442</td>
          <td>0.645503</td>
          <td>0.747170</td>
        </tr>
        <tr>
          <th>3</th>
          <td>0.25</td>
          <td>0.648649</td>
          <td>0.932039</td>
          <td>0.395349</td>
          <td>0.687831</td>
          <td>0.764940</td>
        </tr>
        <tr>
          <th>4</th>
          <td>0.30</td>
          <td>0.686567</td>
          <td>0.893204</td>
          <td>0.511628</td>
          <td>0.719577</td>
          <td>0.776371</td>
        </tr>
        <tr>
          <th>5</th>
          <td>0.35</td>
          <td>0.705426</td>
          <td>0.883495</td>
          <td>0.558140</td>
          <td>0.735450</td>
          <td>0.784483</td>
        </tr>
        <tr>
          <th>6</th>
          <td>0.40</td>
          <td>0.722689</td>
          <td>0.834951</td>
          <td>0.616279</td>
          <td>0.735450</td>
          <td>0.774775</td>
        </tr>
        <tr>
          <th>7</th>
          <td>0.45</td>
          <td>0.736364</td>
          <td>0.786408</td>
          <td>0.662791</td>
          <td>0.730159</td>
          <td>0.760563</td>
        </tr>
        <tr>
          <th>8</th>
          <td>0.50</td>
          <td>0.806122</td>
          <td>0.766990</td>
          <td>0.779070</td>
          <td>0.772487</td>
          <td>0.786070</td>
        </tr>
        <tr>
          <th>9</th>
          <td>0.55</td>
          <td>0.817204</td>
          <td>0.737864</td>
          <td>0.802326</td>
          <td>0.767196</td>
          <td>0.775510</td>
        </tr>
        <tr>
          <th>10</th>
          <td>0.60</td>
          <td>0.835294</td>
          <td>0.689320</td>
          <td>0.837209</td>
          <td>0.756614</td>
          <td>0.755319</td>
        </tr>
        <tr>
          <th>11</th>
          <td>0.65</td>
          <td>0.870130</td>
          <td>0.650485</td>
          <td>0.883721</td>
          <td>0.756614</td>
          <td>0.744444</td>
        </tr>
        <tr>
          <th>12</th>
          <td>0.70</td>
          <td>0.909091</td>
          <td>0.582524</td>
          <td>0.930233</td>
          <td>0.740741</td>
          <td>0.710059</td>
        </tr>
        <tr>
          <th>13</th>
          <td>0.75</td>
          <td>0.904762</td>
          <td>0.553398</td>
          <td>0.930233</td>
          <td>0.724868</td>
          <td>0.686747</td>
        </tr>
        <tr>
          <th>14</th>
          <td>0.80</td>
          <td>0.964286</td>
          <td>0.524272</td>
          <td>0.976744</td>
          <td>0.730159</td>
          <td>0.679245</td>
        </tr>
        <tr>
          <th>15</th>
          <td>0.85</td>
          <td>0.980392</td>
          <td>0.485437</td>
          <td>0.988372</td>
          <td>0.714286</td>
          <td>0.649351</td>
        </tr>
        <tr>
          <th>16</th>
          <td>0.90</td>
          <td>0.975000</td>
          <td>0.378641</td>
          <td>0.988372</td>
          <td>0.656085</td>
          <td>0.545455</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-2b51f172-aea1-4a86-9a27-b3b9636ddcc0')"
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
            document.querySelector('#df-2b51f172-aea1-4a86-9a27-b3b9636ddcc0 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-2b51f172-aea1-4a86-9a27-b3b9636ddcc0');
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

    umbral_optimo = 0.45
    
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



.. image:: output_16_0.png


.. parsed-literal::

    
    Reporte de Clasificación:
                  precision    recall  f1-score   support
    
               0       0.72      0.66      0.69        86
               1       0.74      0.79      0.76       103
    
        accuracy                           0.73       189
       macro avg       0.73      0.72      0.73       189
    weighted avg       0.73      0.73      0.73       189
    
    ROC AUC: 0.847
    

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

    Tasa de positivos reales en test: 0.58
           Total  Positivos      Tasa      Lift  Captura_Acum
    Decil                                                    
    1         19         19  1.000000  1.718182      0.172727
    2         19         19  1.000000  1.718182      0.345455
    3         19         19  1.000000  1.718182      0.518182
    4         19         19  1.000000  1.718182      0.690909
    5         18         18  1.000000  1.718182      0.854545
    6         19         16  0.842105  1.446890      1.000000
    7         19          0  0.000000  0.000000      1.000000
    8         19          0  0.000000  0.000000      1.000000
    9         19          0  0.000000  0.000000      1.000000
    10        19          0  0.000000  0.000000      1.000000
    


.. image:: output_17_1.png


Cambio de parámetros:
~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # ------------------------
    # Ajustar el modelo
    # ------------------------
    model = SVC(kernel="rbf", probability=True, C=10, gamma=0.3)
    model.fit(X_train, y_train)
    
    # ------------------------
    # Predicciones
    # ------------------------
    y_pred_train = model.predict(X_train)
    y_prob_train = model.predict_proba(X_train)[:, 1]
    
    y_pred = model.predict(X_test)
    y_prob = model.predict_proba(X_test)[:, 1]
    
    # ------------------------
    # Evaluación del modelo
    # ------------------------
    print("\n=== Reporte de Clasificación - train ===")
    print(classification_report(y_train, y_pred_train))
    
    print("\n=== Reporte de Clasificación - test ===")
    print(classification_report(y_test, y_pred))
    
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
    
    # --- 📊 Gráfico ---
    plt.figure(figsize=(8,5))
    plt.plot(tabla_deciles.index, tabla_deciles['Tasa'], marker='o', linestyle='-', color='blue')
    plt.title("Tasa de positivos por decil")
    plt.xlabel("Decil")
    plt.ylabel("Tasa de clase 1")
    plt.grid(True)
    plt.show()


.. parsed-literal::

    
    === Reporte de Clasificación - train ===
                  precision    recall  f1-score   support
    
               0       0.75      0.94      0.83       201
               1       0.94      0.73      0.82       239
    
        accuracy                           0.83       440
       macro avg       0.84      0.84      0.83       440
    weighted avg       0.85      0.83      0.83       440
    
    
    === Reporte de Clasificación - test ===
                  precision    recall  f1-score   support
    
               0       0.71      0.84      0.77        86
               1       0.84      0.72      0.77       103
    
        accuracy                           0.77       189
       macro avg       0.78      0.78      0.77       189
    weighted avg       0.78      0.77      0.77       189
    
    


.. image:: output_19_1.png

