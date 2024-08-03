Ejemplo clasificación Estados Financieros
-----------------------------------------

.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import seaborn as sns
    from sklearn.utils import resample
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import StandardScaler
    from sklearn.linear_model import LogisticRegression
    from sklearn.metrics import classification_report, confusion_matrix, accuracy_score
    
    # Cargar los archivos de Excel
    file_1 = "../310030_Estado de resultado integral, resultado del periodo, por funcion de gasto_PYMES.xlsx"
    file_2 = "../210030_Estado de situación financiera, corriente_no corriente_PYMES.xlsx"
    
    # Leer todas las hojas de los archivos
    sheets_file_1 = pd.read_excel(file_1, sheet_name=None)
    sheets_file_2 = pd.read_excel(file_2, sheet_name=None)
    
    # Función para separar las empresas según 'EN REORGANIZACION'
    def separate_companies(sheets):
        reorganizacion = []  # Lista para almacenar las empresas en reorganización
        not_reorganizacion = (
            []
        )  # Lista para almacenar las empresas que no están en reorganización
    
        for sheet_name, df in sheets.items():
            # Filtrar por 'Periodo Actual'
            df_periodo_actual = df[df["Periodo"] == "Periodo Actual"]
            # Filtrar las empresas que terminan con 'EN REORGANIZACION'
            reorganizacion.append(
                df_periodo_actual[
                    df_periodo_actual["Razón social de la sociedad"].str.endswith(
                        "EN REORGANIZACION", na=False
                    )
                ]
            )
            # Filtrar las empresas que no terminan con 'EN REORGANIZACION'
            not_reorganizacion.append(
                df_periodo_actual[
                    ~df_periodo_actual["Razón social de la sociedad"].str.endswith(
                        "EN REORGANIZACION", na=False
                    )
                ]
            )
    
        # Concatenar los resultados de todas las hojas
        return pd.concat(reorganizacion), pd.concat(not_reorganizacion)
    
    
    # Separar las empresas en ambos archivos
    reorganizacion_1, not_reorganizacion_1 = separate_companies(sheets_file_1)
    reorganizacion_2, not_reorganizacion_2 = separate_companies(sheets_file_2)
    
    # Combinar los resultados de ambos archivos
    reorganizacion = pd.concat([reorganizacion_1, reorganizacion_2])
    not_reorganizacion = pd.concat([not_reorganizacion_1, not_reorganizacion_2])
    
    # Filtrar las empresas donde 'Ingresos de actividades ordinarias (Revenue)' fueron positivos
    reorganizacion = reorganizacion[
        reorganizacion["Ingresos de actividades ordinarias (Revenue)"] > 0
    ]
    not_reorganizacion = not_reorganizacion[
        not_reorganizacion["Ingresos de actividades ordinarias (Revenue)"] > 0
    ]
    
    print("Empresas en reorganización: ", len(reorganizacion))
    print("Empresas que no están en reorganización: ", len(not_reorganizacion))


.. parsed-literal::

    Empresas en reorganización:  424
    Empresas que no están en reorganización:  21969
    

.. code:: ipython3

    # Submuestrear las empresas que no están en reorganización utilizando resample de sklearn
    subsample_not_reorganizacion = resample(
        not_reorganizacion,
        replace=False,  # muestreo sin reemplazo
        n_samples=len(reorganizacion),  # mismo tamaño que las empresas en reorganización
        random_state=34,
    )  # para reproducibilidad

.. code:: ipython3

    # Crear una nueva columna 'label' para identificar las empresas en reorganización (1) y las que no están en reorganización (0)
    reorganizacion["label"] = 1
    subsample_not_reorganizacion["label"] = 0
    
    # Combinar las empresas en reorganización y la submuestra de las que no están en reorganización
    combined = pd.concat([reorganizacion, subsample_not_reorganizacion])
    
    # Contar cuántas hay de cada tipo
    combined["label"].value_counts()




.. parsed-literal::

    1    424
    0    424
    Name: label, dtype: int64



.. code:: ipython3

    # Combinar las empresas en reorganización y la submuestra de las que no están en reorganización
    combined = pd.concat([reorganizacion, subsample_not_reorganizacion])
    
    # Crear el DataFrame 'df' combinando las columnas necesarias de filtered_BG y filtered_ER
    df = pd.DataFrame()
    
    # Calcular los indicadores financieros y agregarlos al DataFrame 'df'
    df["Margen Bruto"] = (
        combined["Ganancia bruta (GrossProfit)"]
        / combined["Ingresos de actividades ordinarias (Revenue)"]
    )
    df["Margen Operacional"] = (
        combined[
            "Ganancia (pérdida) por actividades de operación (GananciaPerdidaPorActividadesDeOperacion)"
        ]
        / combined["Ingresos de actividades ordinarias (Revenue)"]
    )
    df["Margen Neto"] = (
        combined["Ganancia (pérdida) (ProfitLoss)"]
        / combined["Ingresos de actividades ordinarias (Revenue)"]
    )
    df["label"] = combined["label"]
    
    # Eliminar filas con valores nulos o infinitos
    df.replace([np.inf, -np.inf], np.nan, inplace=True)
    df.dropna(inplace=True)
    
    # Mostrar los primeros resultados del DataFrame 'df' para verificación
    print(df.head())
    
    # Contar cuántas hay de cada tipo
    df["label"].value_counts()


.. parsed-literal::

         Margen Bruto  Margen Operacional  Margen Neto  label
    120      0.182169           -0.139234    -0.110590      1
    206      0.145285            0.021016    -0.074642      1
    302      1.000000            1.595930     1.077714      1
    306      0.568611            0.077610     0.059090      1
    432      0.149503            0.026351     0.026905      1
    



.. parsed-literal::

    1    424
    0    424
    Name: label, dtype: int64



Análisis de los datos:
~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    indicadores = df.columns[:-1]
    
    # Calcular estadísticas descriptivas por etiqueta
    descriptive_stats = df.groupby("label")[indicadores].describe()
    
    # Mostrar las estadísticas descriptivas
    print(descriptive_stats)


.. parsed-literal::

          Margen Bruto                                                    \
                 count      mean       std       min       25%       50%   
    label                                                                  
    0            424.0  0.470579  0.440547 -3.989035  0.187012  0.358174   
    1            424.0  0.353629  0.423258 -3.786625  0.179082  0.314670   
    
                         Margen Operacional            ...                       \
                75%  max              count      mean  ...       75%        max   
    label                                              ...                        
    0      0.949685  1.0              424.0 -0.404545  ...  0.179070  16.825625   
    1      0.505105  1.0              424.0 -0.120398  ...  0.091547  29.476177   
    
          Margen Neto                                                       \
                count      mean        std         min       25%       50%   
    label                                                                    
    0           424.0 -0.484004  10.374411 -212.235702  0.002675  0.036420   
    1           424.0 -0.206236   3.322487  -23.506586 -0.087183  0.010214   
    
                                
                75%        max  
    label                       
    0      0.105156  11.793688  
    1      0.049940  43.647336  
    
    [2 rows x 24 columns]
    

.. code:: ipython3

    # Crear diagramas de violín para cada variable por etiqueta
    plt.figure(figsize=(15, 10))
    for i, variable in enumerate(indicadores, 1):
        plt.subplot(2, 2, i)
        sns.violinplot(x="label", y=variable, data=df, palette="Set1")
        plt.title(f"Diagrama de Violín de {variable}")
        plt.xlabel("Label (1: En Reorganización, 0: No en Reorganización)")
        plt.ylabel(variable)
    plt.tight_layout()
    plt.show()
    
    # Gráfico de dispersión para algunas combinaciones de indicadores financieros
    plt.figure(figsize=(15, 10))
    sns.pairplot(df, hue="label", vars=indicadores, palette="Set1")
    plt.suptitle("Gráfico de dispersión de Indicadores Financieros", y=1.02)
    plt.show()



.. image:: output_7_0.png



.. parsed-literal::

    <Figure size 1500x1000 with 0 Axes>



.. image:: output_7_2.png


Clasificación con Regresión Logística:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Seleccionar las características (indicadores financieros) y la etiqueta
    X = df[indicadores]
    y = df["label"]

.. code:: ipython3

    # 1. Dividir el conjunto de datos en entrenamiento y prueba
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.3, random_state=34
    )
    
    # 2. Estandarizar los datos
    scaler = StandardScaler()
    X_train = scaler.fit_transform(X_train)
    X_test = scaler.transform(X_test)
    
    # 3. Crear un modelo de regresión logística
    logistic_model = LogisticRegression()
    
    # 4. Entrenar el modelo
    logistic_model.fit(X_train, y_train)
    
    # 5. Hacer predicciones.
    y_pred = logistic_model.predict(X_test)
    
    y_pred_prob = logistic_model.predict_proba(X_test)[:, 1]
    
    # 6. Calcular las métricas de evaluación
    accuracy = accuracy_score(y_test, y_pred)
    conf_matrix = confusion_matrix(y_test, y_pred)
    class_report = classification_report(y_test, y_pred)
    
    # Mostrar las métricas de evaluación
    print("Accuracy:", accuracy)
    print("Classification Report:\n", class_report)
    
    # Crear un mapa de calor para la matriz de confusión con etiquetas
    plt.figure(figsize=(8, 6))
    sns.heatmap(
        conf_matrix,
        annot=True,
        fmt="d",
        cmap="Blues",
        xticklabels=["Predicho 0", "Predicho 1"],
        yticklabels=["Real 0", "Real 1"],
    )
    plt.xlabel("Etiqueta Predicha")
    plt.ylabel("Etiqueta Real")
    plt.title("Matriz de Confusión")
    plt.show()


.. parsed-literal::

    Accuracy: 0.5254901960784314
    Classification Report:
                   precision    recall  f1-score   support
    
               0       0.55      0.42      0.48       131
               1       0.51      0.64      0.57       124
    
        accuracy                           0.53       255
       macro avg       0.53      0.53      0.52       255
    weighted avg       0.53      0.53      0.52       255
    
    


.. image:: output_10_1.png


.. code:: ipython3

    from sklearn.svm import SVC
    
    # Crear el modelo de SVM
    svm_model = SVC(kernel="rbf", random_state=34)
    
    # Entrenar el modelo
    svm_model.fit(X_train, y_train)
    
    # Hacer predicciones en el conjunto de prueba
    y_pred = svm_model.predict(X_test)
    
    # Evaluar el modelo
    accuracy = accuracy_score(y_test, y_pred)
    conf_matrix = confusion_matrix(y_test, y_pred)
    class_report = classification_report(y_test, y_pred)
    
    # Mostrar los resultados
    print("Accuracy:", accuracy)
    print("Confusion Matrix:\n", conf_matrix)
    print("Classification Report:\n", class_report)


.. parsed-literal::

    Accuracy: 0.5490196078431373
    Confusion Matrix:
     [[41 90]
     [25 99]]
    Classification Report:
                   precision    recall  f1-score   support
    
               0       0.62      0.31      0.42       131
               1       0.52      0.80      0.63       124
    
        accuracy                           0.55       255
       macro avg       0.57      0.56      0.52       255
    weighted avg       0.57      0.55      0.52       255
    
    

.. code:: ipython3

    from sklearn.tree import DecisionTreeClassifier
    
    # Crear el modelo de árbol de decisión
    tree_model = DecisionTreeClassifier(random_state=42)
    
    # Entrenar el modelo
    tree_model.fit(X_train, y_train)
    
    # Hacer predicciones en el conjunto de prueba
    y_pred = tree_model.predict(X_test)
    
    # Evaluar el modelo
    accuracy = accuracy_score(y_test, y_pred)
    conf_matrix = confusion_matrix(y_test, y_pred)
    class_report = classification_report(y_test, y_pred)
    
    # Mostrar los resultados
    print("Accuracy:", accuracy)
    print("Confusion Matrix:\n", conf_matrix)
    print("Classification Report:\n", class_report)


.. parsed-literal::

    Accuracy: 0.5137254901960784
    Confusion Matrix:
     [[69 62]
     [62 62]]
    Classification Report:
                   precision    recall  f1-score   support
    
               0       0.53      0.53      0.53       131
               1       0.50      0.50      0.50       124
    
        accuracy                           0.51       255
       macro avg       0.51      0.51      0.51       255
    weighted avg       0.51      0.51      0.51       255
    
    

.. code:: ipython3

    from sklearn.ensemble import RandomForestClassifier
    
    # Crear el modelo de Random Forest
    rf_model = RandomForestClassifier(n_estimators=100, random_state=34)
    
    # Entrenar el modelo
    rf_model.fit(X_train, y_train)
    
    # Hacer predicciones en el conjunto de prueba
    y_pred = rf_model.predict(X_test)
    
    # Evaluar el modelo
    accuracy = accuracy_score(y_test, y_pred)
    conf_matrix = confusion_matrix(y_test, y_pred)
    class_report = classification_report(y_test, y_pred)
    
    # Mostrar los resultados
    print("Accuracy:", accuracy)
    print("Confusion Matrix:\n", conf_matrix)
    print("Classification Report:\n", class_report)


.. parsed-literal::

    Accuracy: 0.5764705882352941
    Confusion Matrix:
     [[83 48]
     [60 64]]
    Classification Report:
                   precision    recall  f1-score   support
    
               0       0.58      0.63      0.61       131
               1       0.57      0.52      0.54       124
    
        accuracy                           0.58       255
       macro avg       0.58      0.57      0.57       255
    weighted avg       0.58      0.58      0.57       255
    
    

.. code:: ipython3

    import xgboost as xgb
    
    # Crear el modelo de XGBoost
    xgb_model = xgb.XGBClassifier(random_state=34)
    
    # Entrenar el modelo
    xgb_model.fit(X_train, y_train)
    
    # Hacer predicciones en el conjunto de prueba
    y_pred = xgb_model.predict(X_test)
    
    # Evaluar el modelo
    accuracy = accuracy_score(y_test, y_pred)
    conf_matrix = confusion_matrix(y_test, y_pred)
    class_report = classification_report(y_test, y_pred)
    
    # Mostrar los resultados
    print("Accuracy:", accuracy)
    print("Confusion Matrix:\n", conf_matrix)
    print("Classification Report:\n", class_report)


.. parsed-literal::

    Accuracy: 0.611764705882353
    Confusion Matrix:
     [[80 51]
     [48 76]]
    Classification Report:
                   precision    recall  f1-score   support
    
               0       0.62      0.61      0.62       131
               1       0.60      0.61      0.61       124
    
        accuracy                           0.61       255
       macro avg       0.61      0.61      0.61       255
    weighted avg       0.61      0.61      0.61       255
    
    
