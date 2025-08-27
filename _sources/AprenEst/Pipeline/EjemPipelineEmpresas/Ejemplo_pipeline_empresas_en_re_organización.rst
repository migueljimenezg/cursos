Ejemplo pipeline empresas en re organización
--------------------------------------------

.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import matplotlib.ticker as mtick
    import seaborn as sns
    from sklearn.model_selection import train_test_split, cross_val_score
    from sklearn.preprocessing import StandardScaler

.. code:: ipython3

    # path = "BD empresas re organización.xlsx"
    
    path = "BD empresas en re organización.xlsx"
    
    xls = pd.ExcelFile(path)
    
    df = pd.read_excel(path, sheet_name=xls.sheet_names[0])
    
    df.head()




.. raw:: html

    
      <div id="df-203cff4c-0308-473d-bd21-4a69d10d72a3" class="colab-df-container">
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
        <button class="colab-df-convert" onclick="convertToInteractive('df-203cff4c-0308-473d-bd21-4a69d10d72a3')"
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
            document.querySelector('#df-203cff4c-0308-473d-bd21-4a69d10d72a3 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-203cff4c-0308-473d-bd21-4a69d10d72a3');
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

Pipeline:
~~~~~~~~~

.. code:: ipython3

    from sklearn.pipeline import Pipeline
    from sklearn.linear_model import LogisticRegression
    from sklearn.svm import SVC
    from sklearn.tree import DecisionTreeClassifier
    from sklearn.metrics import accuracy_score, confusion_matrix, classification_report, roc_auc_score, roc_curve
    from sklearn.ensemble import (
        BaggingClassifier,
        RandomForestClassifier,
        AdaBoostClassifier,
        GradientBoostingClassifier,
        StackingClassifier,
    )
    import xgboost as xgb

.. code:: ipython3

    models = {
        "Logistic Regression": Pipeline([
            ("scaler", StandardScaler()),
            ("classifier", LogisticRegression(max_iter=1000)),
        ]),
        "SVM": Pipeline([
            ("scaler", StandardScaler()),
            ("classifier", SVC(kernel="rbf", probability=True)),
        ]),
        "Decision Tree": Pipeline([
            ("scaler", StandardScaler()),
            ("classifier", DecisionTreeClassifier(
                max_depth=3, min_samples_split=5, min_samples_leaf=2
            )),
        ]),
        # -------------------- Ajustes para Bagging --------------------
        "Bagging": Pipeline([
            ("scaler", StandardScaler()),
            ("classifier", BaggingClassifier(
                estimator=DecisionTreeClassifier(
                    max_depth=5,
                    min_samples_split=10,
                    min_samples_leaf=5,
                    random_state=42
                ),
                n_estimators=50,
                max_samples=0.6,
                max_features=0.8,
                bootstrap=True,
                random_state=42,
            )),
        ]),
        "Random Forest": Pipeline([
            ("scaler", StandardScaler()),
            ("classifier", RandomForestClassifier(
                n_estimators=100,
                max_depth=3,
                max_features="sqrt",
                random_state=42,
              )),
        ]),
        "AdaBoost": Pipeline([
            ("scaler", StandardScaler()),
            ("classifier", AdaBoostClassifier(
                estimator=DecisionTreeClassifier(max_depth=1),
                n_estimators=100,
                learning_rate=0.1,
                random_state=42,
            )),
        ]),
        # -------------------- Ajustes para Gradient Boosting --------------------
        "Gradient Boosting": Pipeline([
            ("scaler", StandardScaler()),
            ("classifier", GradientBoostingClassifier(
                n_estimators=200,        # más etapas con contribución reducida
                learning_rate=0.05,      # tasa de aprendizaje menor
                max_depth=3,             # mantener árboles poco profundos
                subsample=0.8,           # bagging interno para reducir varianza
                min_samples_leaf=5,      # evitar hojas con muy pocas muestras
                random_state=42
            )),
        ]),
    
        # -------------------- Ajustes para XGBoost --------------------
        "XGBoost": Pipeline([
            ("scaler", StandardScaler()),
            ("classifier", xgb.XGBClassifier(
                n_estimators=200,           # más rondas con contribución reducida
                learning_rate=0.05,         # tasa de aprendizaje menor
                max_depth=3,                # limitar complejidad del árbol
                subsample=0.8,              # muestreo aleatorio de filas
                colsample_bytree=0.8,       # muestreo aleatorio de columnas
                reg_alpha=0.1,              # L1 regularización
                reg_lambda=1.0,             # L2 regularización
                random_state=42,
                eval_metric="auc"
            )),
        ]),
        # -------------------- Ajustes para Stacking --------------------
        "Stacking": Pipeline([
            ("scaler", StandardScaler()),
            ("classifier", StackingClassifier(
                estimators=[
                    ("svc", SVC(kernel="linear", C=0.5, probability=True)),
                    ("rf", RandomForestClassifier(
                        n_estimators=50,
                        max_depth=3,
                        max_features="sqrt",
                        random_state=42
                    )),
                    ("dt", DecisionTreeClassifier(
                        max_depth=3,
                        min_samples_leaf=5,
                        random_state=42
                    )),
                    ("log_reg", LogisticRegression(
                        penalty='l2',
                        C=0.1,
                        max_iter=1000,
                        solver='lbfgs'
                    )),
                ],
                final_estimator=LogisticRegression(
                    penalty='l2',
                    C=0.05,
                    max_iter=1000,
                    solver='lbfgs'
                ),
                cv=8,
            )),
        ]),
    }
    

.. code:: ipython3

    # Evaluar cada modelo
    accuracies = {}
    for name, pipeline in models.items():
        # Validación cruzada para obtener la media de la precisión
        cv_scores = cross_val_score(pipeline, X_train, y_train, cv=10, scoring="accuracy")
        mean_cv_score = cv_scores.mean()
    
        # Entrenar el modelo y predecir en el conjunto de prueba
        pipeline.fit(X_train, y_train)
        y_pred_train = pipeline.predict(X_train)
        y_pred = pipeline.predict(X_test)
    
        # Calcular la precisión en el conjunto de prueba
        test_accuracy = accuracy_score(y_test, y_pred)
    
        # Guardar las precisiones
        accuracies[name] = {
            "CV Accuracy": mean_cv_score,
            "Test Accuracy": test_accuracy,
            "Confusion Matrix": confusion_matrix(y_test, y_pred),
            "Classification Report - test": classification_report(y_test, y_pred),
            "Classification Report - train": classification_report(y_train, y_pred_train),
        }
    
    # Mostrar los resultados
    for model_name, metrics in accuracies.items():
        print(f"Model: {model_name}")
        print(f"Cross-Validation Accuracy: {metrics['CV Accuracy']:.2f}")
        print(f"Test Accuracy: {metrics['Test Accuracy']:.2f}")
        print("Confusion Matrix:")
        print(metrics["Confusion Matrix"])
        print("Classification Report - train:")
        print(metrics["Classification Report - train"])
        print("Classification Report - test:")
        print(metrics["Classification Report - test"])
        print("\n" + "-" * 40 + "\n")


.. parsed-literal::

    Model: Logistic Regression
    Cross-Validation Accuracy: 0.72
    Test Accuracy: 0.69
    Confusion Matrix:
    [[62 24]
     [35 68]]
    Classification Report - train:
                  precision    recall  f1-score   support
    
               0       0.69      0.76      0.72       201
               1       0.78      0.72      0.75       239
    
        accuracy                           0.73       440
       macro avg       0.73      0.74      0.73       440
    weighted avg       0.74      0.73      0.73       440
    
    Classification Report - test:
                  precision    recall  f1-score   support
    
               0       0.64      0.72      0.68        86
               1       0.74      0.66      0.70       103
    
        accuracy                           0.69       189
       macro avg       0.69      0.69      0.69       189
    weighted avg       0.69      0.69      0.69       189
    
    
    ----------------------------------------
    
    Model: SVM
    Cross-Validation Accuracy: 0.78
    Test Accuracy: 0.77
    Confusion Matrix:
    [[71 15]
     [29 74]]
    Classification Report - train:
                  precision    recall  f1-score   support
    
               0       0.72      0.87      0.79       201
               1       0.87      0.72      0.79       239
    
        accuracy                           0.79       440
       macro avg       0.80      0.80      0.79       440
    weighted avg       0.80      0.79      0.79       440
    
    Classification Report - test:
                  precision    recall  f1-score   support
    
               0       0.71      0.83      0.76        86
               1       0.83      0.72      0.77       103
    
        accuracy                           0.77       189
       macro avg       0.77      0.77      0.77       189
    weighted avg       0.78      0.77      0.77       189
    
    
    ----------------------------------------
    
    Model: Decision Tree
    Cross-Validation Accuracy: 0.79
    Test Accuracy: 0.78
    Confusion Matrix:
    [[83  3]
     [39 64]]
    Classification Report - train:
                  precision    recall  f1-score   support
    
               0       0.70      0.99      0.82       201
               1       0.98      0.64      0.78       239
    
        accuracy                           0.80       440
       macro avg       0.84      0.81      0.80       440
    weighted avg       0.85      0.80      0.80       440
    
    Classification Report - test:
                  precision    recall  f1-score   support
    
               0       0.68      0.97      0.80        86
               1       0.96      0.62      0.75       103
    
        accuracy                           0.78       189
       macro avg       0.82      0.79      0.78       189
    weighted avg       0.83      0.78      0.77       189
    
    
    ----------------------------------------
    
    Model: Bagging
    Cross-Validation Accuracy: 0.81
    Test Accuracy: 0.80
    Confusion Matrix:
    [[75 11]
     [26 77]]
    Classification Report - train:
                  precision    recall  f1-score   support
    
               0       0.78      0.96      0.86       201
               1       0.95      0.77      0.85       239
    
        accuracy                           0.86       440
       macro avg       0.87      0.86      0.86       440
    weighted avg       0.87      0.86      0.86       440
    
    Classification Report - test:
                  precision    recall  f1-score   support
    
               0       0.74      0.87      0.80        86
               1       0.88      0.75      0.81       103
    
        accuracy                           0.80       189
       macro avg       0.81      0.81      0.80       189
    weighted avg       0.81      0.80      0.80       189
    
    
    ----------------------------------------
    
    Model: Random Forest
    Cross-Validation Accuracy: 0.80
    Test Accuracy: 0.80
    Confusion Matrix:
    [[78  8]
     [30 73]]
    Classification Report - train:
                  precision    recall  f1-score   support
    
               0       0.74      0.96      0.83       201
               1       0.96      0.71      0.82       239
    
        accuracy                           0.82       440
       macro avg       0.85      0.84      0.82       440
    weighted avg       0.86      0.82      0.82       440
    
    Classification Report - test:
                  precision    recall  f1-score   support
    
               0       0.72      0.91      0.80        86
               1       0.90      0.71      0.79       103
    
        accuracy                           0.80       189
       macro avg       0.81      0.81      0.80       189
    weighted avg       0.82      0.80      0.80       189
    
    
    ----------------------------------------
    
    Model: AdaBoost
    Cross-Validation Accuracy: 0.80
    Test Accuracy: 0.80
    Confusion Matrix:
    [[83  3]
     [35 68]]
    Classification Report - train:
                  precision    recall  f1-score   support
    
               0       0.73      0.99      0.84       201
               1       0.99      0.69      0.81       239
    
        accuracy                           0.82       440
       macro avg       0.86      0.84      0.82       440
    weighted avg       0.87      0.82      0.82       440
    
    Classification Report - test:
                  precision    recall  f1-score   support
    
               0       0.70      0.97      0.81        86
               1       0.96      0.66      0.78       103
    
        accuracy                           0.80       189
       macro avg       0.83      0.81      0.80       189
    weighted avg       0.84      0.80      0.80       189
    
    
    ----------------------------------------
    
    Model: Gradient Boosting
    Cross-Validation Accuracy: 0.82
    Test Accuracy: 0.84
    Confusion Matrix:
    [[74 12]
     [18 85]]
    Classification Report - train:
                  precision    recall  f1-score   support
    
               0       0.96      0.99      0.97       201
               1       0.99      0.96      0.97       239
    
        accuracy                           0.97       440
       macro avg       0.97      0.97      0.97       440
    weighted avg       0.97      0.97      0.97       440
    
    Classification Report - test:
                  precision    recall  f1-score   support
    
               0       0.80      0.86      0.83        86
               1       0.88      0.83      0.85       103
    
        accuracy                           0.84       189
       macro avg       0.84      0.84      0.84       189
    weighted avg       0.84      0.84      0.84       189
    
    
    ----------------------------------------
    
    Model: XGBoost
    Cross-Validation Accuracy: 0.83
    Test Accuracy: 0.85
    Confusion Matrix:
    [[76 10]
     [19 84]]
    Classification Report - train:
                  precision    recall  f1-score   support
    
               0       0.88      0.98      0.92       201
               1       0.98      0.89      0.93       239
    
        accuracy                           0.93       440
       macro avg       0.93      0.93      0.93       440
    weighted avg       0.93      0.93      0.93       440
    
    Classification Report - test:
                  precision    recall  f1-score   support
    
               0       0.80      0.88      0.84        86
               1       0.89      0.82      0.85       103
    
        accuracy                           0.85       189
       macro avg       0.85      0.85      0.85       189
    weighted avg       0.85      0.85      0.85       189
    
    
    ----------------------------------------
    
    Model: Stacking
    Cross-Validation Accuracy: 0.79
    Test Accuracy: 0.79
    Confusion Matrix:
    [[80  6]
     [33 70]]
    Classification Report - train:
                  precision    recall  f1-score   support
    
               0       0.72      0.95      0.82       201
               1       0.94      0.69      0.80       239
    
        accuracy                           0.81       440
       macro avg       0.83      0.82      0.81       440
    weighted avg       0.84      0.81      0.81       440
    
    Classification Report - test:
                  precision    recall  f1-score   support
    
               0       0.71      0.93      0.80        86
               1       0.92      0.68      0.78       103
    
        accuracy                           0.79       189
       macro avg       0.81      0.80      0.79       189
    weighted avg       0.82      0.79      0.79       189
    
    
    ----------------------------------------
    
    

=================== ============== ============= ==== =============
Modelo              Train Accuracy Test Accuracy Gap  ¿Overfitting?
=================== ============== ============= ==== =============
Logistic Regression 0.73           0.69          0.04 No
SVM                 0.79           0.77          0.02 No
Decision Tree       0.80           0.78          0.02 No
Bagging             0.86           0.80          0.06 Sí
Random Forest       0.82           0.80          0.02 No
AdaBoost            0.82           0.80          0.02 No
Gradient Boosting   0.97           0.84          0.13 Sí
XGBoost             0.93           0.85          0.08 Sí
Stacking            0.81           0.79          0.02 No
=================== ============== ============= ==== =============

Extraer el mejor modelo:
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    XGBoost = models["XGBoost"]
    XGBoost.fit(X_train, y_train)




.. raw:: html

    <style>#sk-container-id-1 {
      /* Definition of color scheme common for light and dark mode */
      --sklearn-color-text: #000;
      --sklearn-color-text-muted: #666;
      --sklearn-color-line: gray;
      /* Definition of color scheme for unfitted estimators */
      --sklearn-color-unfitted-level-0: #fff5e6;
      --sklearn-color-unfitted-level-1: #f6e4d2;
      --sklearn-color-unfitted-level-2: #ffe0b3;
      --sklearn-color-unfitted-level-3: chocolate;
      /* Definition of color scheme for fitted estimators */
      --sklearn-color-fitted-level-0: #f0f8ff;
      --sklearn-color-fitted-level-1: #d4ebff;
      --sklearn-color-fitted-level-2: #b3dbfd;
      --sklearn-color-fitted-level-3: cornflowerblue;
    
      /* Specific color for light theme */
      --sklearn-color-text-on-default-background: var(--sg-text-color, var(--theme-code-foreground, var(--jp-content-font-color1, black)));
      --sklearn-color-background: var(--sg-background-color, var(--theme-background, var(--jp-layout-color0, white)));
      --sklearn-color-border-box: var(--sg-text-color, var(--theme-code-foreground, var(--jp-content-font-color1, black)));
      --sklearn-color-icon: #696969;
    
      @media (prefers-color-scheme: dark) {
        /* Redefinition of color scheme for dark theme */
        --sklearn-color-text-on-default-background: var(--sg-text-color, var(--theme-code-foreground, var(--jp-content-font-color1, white)));
        --sklearn-color-background: var(--sg-background-color, var(--theme-background, var(--jp-layout-color0, #111)));
        --sklearn-color-border-box: var(--sg-text-color, var(--theme-code-foreground, var(--jp-content-font-color1, white)));
        --sklearn-color-icon: #878787;
      }
    }
    
    #sk-container-id-1 {
      color: var(--sklearn-color-text);
    }
    
    #sk-container-id-1 pre {
      padding: 0;
    }
    
    #sk-container-id-1 input.sk-hidden--visually {
      border: 0;
      clip: rect(1px 1px 1px 1px);
      clip: rect(1px, 1px, 1px, 1px);
      height: 1px;
      margin: -1px;
      overflow: hidden;
      padding: 0;
      position: absolute;
      width: 1px;
    }
    
    #sk-container-id-1 div.sk-dashed-wrapped {
      border: 1px dashed var(--sklearn-color-line);
      margin: 0 0.4em 0.5em 0.4em;
      box-sizing: border-box;
      padding-bottom: 0.4em;
      background-color: var(--sklearn-color-background);
    }
    
    #sk-container-id-1 div.sk-container {
      /* jupyter's `normalize.less` sets `[hidden] { display: none; }`
         but bootstrap.min.css set `[hidden] { display: none !important; }`
         so we also need the `!important` here to be able to override the
         default hidden behavior on the sphinx rendered scikit-learn.org.
         See: https://github.com/scikit-learn/scikit-learn/issues/21755 */
      display: inline-block !important;
      position: relative;
    }
    
    #sk-container-id-1 div.sk-text-repr-fallback {
      display: none;
    }
    
    div.sk-parallel-item,
    div.sk-serial,
    div.sk-item {
      /* draw centered vertical line to link estimators */
      background-image: linear-gradient(var(--sklearn-color-text-on-default-background), var(--sklearn-color-text-on-default-background));
      background-size: 2px 100%;
      background-repeat: no-repeat;
      background-position: center center;
    }
    
    /* Parallel-specific style estimator block */
    
    #sk-container-id-1 div.sk-parallel-item::after {
      content: "";
      width: 100%;
      border-bottom: 2px solid var(--sklearn-color-text-on-default-background);
      flex-grow: 1;
    }
    
    #sk-container-id-1 div.sk-parallel {
      display: flex;
      align-items: stretch;
      justify-content: center;
      background-color: var(--sklearn-color-background);
      position: relative;
    }
    
    #sk-container-id-1 div.sk-parallel-item {
      display: flex;
      flex-direction: column;
    }
    
    #sk-container-id-1 div.sk-parallel-item:first-child::after {
      align-self: flex-end;
      width: 50%;
    }
    
    #sk-container-id-1 div.sk-parallel-item:last-child::after {
      align-self: flex-start;
      width: 50%;
    }
    
    #sk-container-id-1 div.sk-parallel-item:only-child::after {
      width: 0;
    }
    
    /* Serial-specific style estimator block */
    
    #sk-container-id-1 div.sk-serial {
      display: flex;
      flex-direction: column;
      align-items: center;
      background-color: var(--sklearn-color-background);
      padding-right: 1em;
      padding-left: 1em;
    }
    
    
    /* Toggleable style: style used for estimator/Pipeline/ColumnTransformer box that is
    clickable and can be expanded/collapsed.
    - Pipeline and ColumnTransformer use this feature and define the default style
    - Estimators will overwrite some part of the style using the `sk-estimator` class
    */
    
    /* Pipeline and ColumnTransformer style (default) */
    
    #sk-container-id-1 div.sk-toggleable {
      /* Default theme specific background. It is overwritten whether we have a
      specific estimator or a Pipeline/ColumnTransformer */
      background-color: var(--sklearn-color-background);
    }
    
    /* Toggleable label */
    #sk-container-id-1 label.sk-toggleable__label {
      cursor: pointer;
      display: flex;
      width: 100%;
      margin-bottom: 0;
      padding: 0.5em;
      box-sizing: border-box;
      text-align: center;
      align-items: start;
      justify-content: space-between;
      gap: 0.5em;
    }
    
    #sk-container-id-1 label.sk-toggleable__label .caption {
      font-size: 0.6rem;
      font-weight: lighter;
      color: var(--sklearn-color-text-muted);
    }
    
    #sk-container-id-1 label.sk-toggleable__label-arrow:before {
      /* Arrow on the left of the label */
      content: "▸";
      float: left;
      margin-right: 0.25em;
      color: var(--sklearn-color-icon);
    }
    
    #sk-container-id-1 label.sk-toggleable__label-arrow:hover:before {
      color: var(--sklearn-color-text);
    }
    
    /* Toggleable content - dropdown */
    
    #sk-container-id-1 div.sk-toggleable__content {
      max-height: 0;
      max-width: 0;
      overflow: hidden;
      text-align: left;
      /* unfitted */
      background-color: var(--sklearn-color-unfitted-level-0);
    }
    
    #sk-container-id-1 div.sk-toggleable__content.fitted {
      /* fitted */
      background-color: var(--sklearn-color-fitted-level-0);
    }
    
    #sk-container-id-1 div.sk-toggleable__content pre {
      margin: 0.2em;
      border-radius: 0.25em;
      color: var(--sklearn-color-text);
      /* unfitted */
      background-color: var(--sklearn-color-unfitted-level-0);
    }
    
    #sk-container-id-1 div.sk-toggleable__content.fitted pre {
      /* unfitted */
      background-color: var(--sklearn-color-fitted-level-0);
    }
    
    #sk-container-id-1 input.sk-toggleable__control:checked~div.sk-toggleable__content {
      /* Expand drop-down */
      max-height: 200px;
      max-width: 100%;
      overflow: auto;
    }
    
    #sk-container-id-1 input.sk-toggleable__control:checked~label.sk-toggleable__label-arrow:before {
      content: "▾";
    }
    
    /* Pipeline/ColumnTransformer-specific style */
    
    #sk-container-id-1 div.sk-label input.sk-toggleable__control:checked~label.sk-toggleable__label {
      color: var(--sklearn-color-text);
      background-color: var(--sklearn-color-unfitted-level-2);
    }
    
    #sk-container-id-1 div.sk-label.fitted input.sk-toggleable__control:checked~label.sk-toggleable__label {
      background-color: var(--sklearn-color-fitted-level-2);
    }
    
    /* Estimator-specific style */
    
    /* Colorize estimator box */
    #sk-container-id-1 div.sk-estimator input.sk-toggleable__control:checked~label.sk-toggleable__label {
      /* unfitted */
      background-color: var(--sklearn-color-unfitted-level-2);
    }
    
    #sk-container-id-1 div.sk-estimator.fitted input.sk-toggleable__control:checked~label.sk-toggleable__label {
      /* fitted */
      background-color: var(--sklearn-color-fitted-level-2);
    }
    
    #sk-container-id-1 div.sk-label label.sk-toggleable__label,
    #sk-container-id-1 div.sk-label label {
      /* The background is the default theme color */
      color: var(--sklearn-color-text-on-default-background);
    }
    
    /* On hover, darken the color of the background */
    #sk-container-id-1 div.sk-label:hover label.sk-toggleable__label {
      color: var(--sklearn-color-text);
      background-color: var(--sklearn-color-unfitted-level-2);
    }
    
    /* Label box, darken color on hover, fitted */
    #sk-container-id-1 div.sk-label.fitted:hover label.sk-toggleable__label.fitted {
      color: var(--sklearn-color-text);
      background-color: var(--sklearn-color-fitted-level-2);
    }
    
    /* Estimator label */
    
    #sk-container-id-1 div.sk-label label {
      font-family: monospace;
      font-weight: bold;
      display: inline-block;
      line-height: 1.2em;
    }
    
    #sk-container-id-1 div.sk-label-container {
      text-align: center;
    }
    
    /* Estimator-specific */
    #sk-container-id-1 div.sk-estimator {
      font-family: monospace;
      border: 1px dotted var(--sklearn-color-border-box);
      border-radius: 0.25em;
      box-sizing: border-box;
      margin-bottom: 0.5em;
      /* unfitted */
      background-color: var(--sklearn-color-unfitted-level-0);
    }
    
    #sk-container-id-1 div.sk-estimator.fitted {
      /* fitted */
      background-color: var(--sklearn-color-fitted-level-0);
    }
    
    /* on hover */
    #sk-container-id-1 div.sk-estimator:hover {
      /* unfitted */
      background-color: var(--sklearn-color-unfitted-level-2);
    }
    
    #sk-container-id-1 div.sk-estimator.fitted:hover {
      /* fitted */
      background-color: var(--sklearn-color-fitted-level-2);
    }
    
    /* Specification for estimator info (e.g. "i" and "?") */
    
    /* Common style for "i" and "?" */
    
    .sk-estimator-doc-link,
    a:link.sk-estimator-doc-link,
    a:visited.sk-estimator-doc-link {
      float: right;
      font-size: smaller;
      line-height: 1em;
      font-family: monospace;
      background-color: var(--sklearn-color-background);
      border-radius: 1em;
      height: 1em;
      width: 1em;
      text-decoration: none !important;
      margin-left: 0.5em;
      text-align: center;
      /* unfitted */
      border: var(--sklearn-color-unfitted-level-1) 1pt solid;
      color: var(--sklearn-color-unfitted-level-1);
    }
    
    .sk-estimator-doc-link.fitted,
    a:link.sk-estimator-doc-link.fitted,
    a:visited.sk-estimator-doc-link.fitted {
      /* fitted */
      border: var(--sklearn-color-fitted-level-1) 1pt solid;
      color: var(--sklearn-color-fitted-level-1);
    }
    
    /* On hover */
    div.sk-estimator:hover .sk-estimator-doc-link:hover,
    .sk-estimator-doc-link:hover,
    div.sk-label-container:hover .sk-estimator-doc-link:hover,
    .sk-estimator-doc-link:hover {
      /* unfitted */
      background-color: var(--sklearn-color-unfitted-level-3);
      color: var(--sklearn-color-background);
      text-decoration: none;
    }
    
    div.sk-estimator.fitted:hover .sk-estimator-doc-link.fitted:hover,
    .sk-estimator-doc-link.fitted:hover,
    div.sk-label-container:hover .sk-estimator-doc-link.fitted:hover,
    .sk-estimator-doc-link.fitted:hover {
      /* fitted */
      background-color: var(--sklearn-color-fitted-level-3);
      color: var(--sklearn-color-background);
      text-decoration: none;
    }
    
    /* Span, style for the box shown on hovering the info icon */
    .sk-estimator-doc-link span {
      display: none;
      z-index: 9999;
      position: relative;
      font-weight: normal;
      right: .2ex;
      padding: .5ex;
      margin: .5ex;
      width: min-content;
      min-width: 20ex;
      max-width: 50ex;
      color: var(--sklearn-color-text);
      box-shadow: 2pt 2pt 4pt #999;
      /* unfitted */
      background: var(--sklearn-color-unfitted-level-0);
      border: .5pt solid var(--sklearn-color-unfitted-level-3);
    }
    
    .sk-estimator-doc-link.fitted span {
      /* fitted */
      background: var(--sklearn-color-fitted-level-0);
      border: var(--sklearn-color-fitted-level-3);
    }
    
    .sk-estimator-doc-link:hover span {
      display: block;
    }
    
    /* "?"-specific style due to the `<a>` HTML tag */
    
    #sk-container-id-1 a.estimator_doc_link {
      float: right;
      font-size: 1rem;
      line-height: 1em;
      font-family: monospace;
      background-color: var(--sklearn-color-background);
      border-radius: 1rem;
      height: 1rem;
      width: 1rem;
      text-decoration: none;
      /* unfitted */
      color: var(--sklearn-color-unfitted-level-1);
      border: var(--sklearn-color-unfitted-level-1) 1pt solid;
    }
    
    #sk-container-id-1 a.estimator_doc_link.fitted {
      /* fitted */
      border: var(--sklearn-color-fitted-level-1) 1pt solid;
      color: var(--sklearn-color-fitted-level-1);
    }
    
    /* On hover */
    #sk-container-id-1 a.estimator_doc_link:hover {
      /* unfitted */
      background-color: var(--sklearn-color-unfitted-level-3);
      color: var(--sklearn-color-background);
      text-decoration: none;
    }
    
    #sk-container-id-1 a.estimator_doc_link.fitted:hover {
      /* fitted */
      background-color: var(--sklearn-color-fitted-level-3);
    }
    </style><div id="sk-container-id-1" class="sk-top-container"><div class="sk-text-repr-fallback"><pre>Pipeline(steps=[(&#x27;scaler&#x27;, StandardScaler()),
                    (&#x27;classifier&#x27;,
                     XGBClassifier(base_score=None, booster=None, callbacks=None,
                                   colsample_bylevel=None, colsample_bynode=None,
                                   colsample_bytree=0.8, device=None,
                                   early_stopping_rounds=None,
                                   enable_categorical=False, eval_metric=&#x27;auc&#x27;,
                                   feature_types=None, feature_weights=None,
                                   gamma=None, grow_policy=None,
                                   importance_type=None,
                                   interaction_constraints=None, learning_rate=0.05,
                                   max_bin=None, max_cat_threshold=None,
                                   max_cat_to_onehot=None, max_delta_step=None,
                                   max_depth=3, max_leaves=None,
                                   min_child_weight=None, missing=nan,
                                   monotone_constraints=None, multi_strategy=None,
                                   n_estimators=200, n_jobs=None,
                                   num_parallel_tree=None, ...))])</pre><b>In a Jupyter environment, please rerun this cell to show the HTML representation or trust the notebook. <br />On GitHub, the HTML representation is unable to render, please try loading this page with nbviewer.org.</b></div><div class="sk-container" hidden><div class="sk-item sk-dashed-wrapped"><div class="sk-label-container"><div class="sk-label fitted sk-toggleable"><input class="sk-toggleable__control sk-hidden--visually" id="sk-estimator-id-1" type="checkbox" ><label for="sk-estimator-id-1" class="sk-toggleable__label fitted sk-toggleable__label-arrow"><div><div>Pipeline</div></div><div><a class="sk-estimator-doc-link fitted" rel="noreferrer" target="_blank" href="https://scikit-learn.org/1.6/modules/generated/sklearn.pipeline.Pipeline.html">?<span>Documentation for Pipeline</span></a><span class="sk-estimator-doc-link fitted">i<span>Fitted</span></span></div></label><div class="sk-toggleable__content fitted"><pre>Pipeline(steps=[(&#x27;scaler&#x27;, StandardScaler()),
                    (&#x27;classifier&#x27;,
                     XGBClassifier(base_score=None, booster=None, callbacks=None,
                                   colsample_bylevel=None, colsample_bynode=None,
                                   colsample_bytree=0.8, device=None,
                                   early_stopping_rounds=None,
                                   enable_categorical=False, eval_metric=&#x27;auc&#x27;,
                                   feature_types=None, feature_weights=None,
                                   gamma=None, grow_policy=None,
                                   importance_type=None,
                                   interaction_constraints=None, learning_rate=0.05,
                                   max_bin=None, max_cat_threshold=None,
                                   max_cat_to_onehot=None, max_delta_step=None,
                                   max_depth=3, max_leaves=None,
                                   min_child_weight=None, missing=nan,
                                   monotone_constraints=None, multi_strategy=None,
                                   n_estimators=200, n_jobs=None,
                                   num_parallel_tree=None, ...))])</pre></div> </div></div><div class="sk-serial"><div class="sk-item"><div class="sk-estimator fitted sk-toggleable"><input class="sk-toggleable__control sk-hidden--visually" id="sk-estimator-id-2" type="checkbox" ><label for="sk-estimator-id-2" class="sk-toggleable__label fitted sk-toggleable__label-arrow"><div><div>StandardScaler</div></div><div><a class="sk-estimator-doc-link fitted" rel="noreferrer" target="_blank" href="https://scikit-learn.org/1.6/modules/generated/sklearn.preprocessing.StandardScaler.html">?<span>Documentation for StandardScaler</span></a></div></label><div class="sk-toggleable__content fitted"><pre>StandardScaler()</pre></div> </div></div><div class="sk-item"><div class="sk-estimator fitted sk-toggleable"><input class="sk-toggleable__control sk-hidden--visually" id="sk-estimator-id-3" type="checkbox" ><label for="sk-estimator-id-3" class="sk-toggleable__label fitted sk-toggleable__label-arrow"><div><div>XGBClassifier</div></div><div><a class="sk-estimator-doc-link fitted" rel="noreferrer" target="_blank" href="https://xgboost.readthedocs.io/en/release_3.0.0/python/python_api.html#xgboost.XGBClassifier">?<span>Documentation for XGBClassifier</span></a></div></label><div class="sk-toggleable__content fitted"><pre>XGBClassifier(base_score=None, booster=None, callbacks=None,
                  colsample_bylevel=None, colsample_bynode=None,
                  colsample_bytree=0.8, device=None, early_stopping_rounds=None,
                  enable_categorical=False, eval_metric=&#x27;auc&#x27;, feature_types=None,
                  feature_weights=None, gamma=None, grow_policy=None,
                  importance_type=None, interaction_constraints=None,
                  learning_rate=0.05, max_bin=None, max_cat_threshold=None,
                  max_cat_to_onehot=None, max_delta_step=None, max_depth=3,
                  max_leaves=None, min_child_weight=None, missing=nan,
                  monotone_constraints=None, multi_strategy=None, n_estimators=200,
                  n_jobs=None, num_parallel_tree=None, ...)</pre></div> </div></div></div></div></div></div>



.. code:: ipython3

    y_pred_train = XGBoost.predict(X_train)
    y_prob_train = XGBoost.predict_proba(X_train)[:, 1]
    
    y_pred = XGBoost.predict(X_test)
    y_prob = XGBoost.predict_proba(X_test)[:, 1]
    
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



.. image:: output_13_0.png



.. image:: output_13_1.png


.. code:: ipython3

    print("\n=== Reporte de Clasificación - train ===")
    print(classification_report(y_train, y_pred_train))
    
    print("\n=== Reporte de Clasificación - test ===")
    print(classification_report(y_test, y_pred))


.. parsed-literal::

    
    === Reporte de Clasificación - train ===
                  precision    recall  f1-score   support
    
               0       0.88      0.98      0.92       201
               1       0.98      0.89      0.93       239
    
        accuracy                           0.93       440
       macro avg       0.93      0.93      0.93       440
    weighted avg       0.93      0.93      0.93       440
    
    
    === Reporte de Clasificación - test ===
                  precision    recall  f1-score   support
    
               0       0.80      0.88      0.84        86
               1       0.89      0.82      0.85       103
    
        accuracy                           0.85       189
       macro avg       0.85      0.85      0.85       189
    weighted avg       0.85      0.85      0.85       189
    
    

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

    ROC AUC - Train: 0.991
    ROC AUC - Test : 0.910
    


.. image:: output_15_1.png

