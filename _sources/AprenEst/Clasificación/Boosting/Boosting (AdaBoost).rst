Boosting (AdaBoost)
-------------------

.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import seaborn as sns
    from sklearn.model_selection import train_test_split
    from sklearn.ensemble import AdaBoostClassifier
    from sklearn.tree import DecisionTreeClassifier
    from sklearn.metrics import classification_report, confusion_matrix
    import yfinance as yf

Descargar precios del Futuro ES:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Descargar datos históricos del futuro del índice S&P 500 (ES)
    ticker = "ES=F"
    data = yf.download(ticker, start="2020-01-01", end="2024-06-30", interval="1d")
    
    # Graficar el precio de cierre
    plt.figure(figsize=(14, 7))
    plt.plot(data["Close"], label="Precio de Cierre")
    plt.title("Precio de Cierre del Futuro del Índice S&P 500 (ES)")
    plt.xlabel("Fecha")
    plt.ylabel("Precio de Cierre")
    plt.legend()
    plt.show()


.. parsed-literal::

    [*********************100%***********************]  1 of 1 completed
    


.. image:: output_3_1.png


Creación de las características:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Crear características adicionales
    data["PriceChange"] = data["Close"].shift(-1) - data["Close"]
    data["Label"] = np.where(data["PriceChange"] > 0, 1, 0)
    data["DailyPctChange"] = ((data["Close"] - data["Open"]) / data["Open"]) * 100
    data["Range"] = data["High"] - data["Low"]
    data["Volatility"] = (data["High"] - data["Low"]) / data["Close"]
    
    # Seleccionar características y etiqueta
    features = [
        "Open",
        "High",
        "Low",
        "Close",
        "Volume",
        "Volatility",
        "DailyPctChange",
        "Range",
    ]
    X = data[features]
    y = data["Label"]
    
    print("Cantidad precios positivos y negativos:\n", data["Label"].value_counts())
    print(X.head())


.. parsed-literal::

    Cantidad precios positivos y negativos:
     1    602
    0    529
    Name: Label, dtype: int64
                   Open     High      Low    Close   Volume  Volatility  \
    Date                                                                  
    2020-01-02  3237.00  3261.75  3234.25  3259.00  1416241    0.008438   
    2020-01-03  3261.00  3263.50  3206.75  3235.50  1755057    0.017540   
    2020-01-06  3220.25  3249.50  3208.75  3243.50  1502748    0.012564   
    2020-01-07  3243.50  3254.50  3226.00  3235.25  1293494    0.008809   
    2020-01-08  3231.75  3267.75  3181.00  3260.25  2279138    0.026608   
    
                DailyPctChange  Range  
    Date                               
    2020-01-02        0.679642  27.50  
    2020-01-03       -0.781969  56.75  
    2020-01-06        0.721994  40.75  
    2020-01-07       -0.254355  28.50  
    2020-01-08        0.881875  86.75  
    

AdaBoost:
~~~~~~~~~

**Boosting** es una técnica poderosa en el aprendizaje automático que
mejora la precisión de los modelos al corregir los errores de predicción
de modelos anteriores. Se centra en mejorar el rendimiento general al
permitir que los modelos posteriores se concentren en los casos
difíciles que fueron mal clasificados previamente.

**AdaBoost**, o **Adaptive Boosting**, es especialmente eficaz cuando se
utilizan modelos base débiles, como árboles de decisión de poca
profundidad. Este método ajusta el enfoque de cada modelo nuevo
aumentando los pesos de las instancias que fueron clasificadas
incorrectamente por el modelo anterior. De esta forma, los
clasificadores posteriores se enfocan en corregir estos errores,
mejorando gradualmente la precisión del conjunto de modelos.

Un clasificador AdaBoost funciona como un meta-estimador. Comienza
entrenando un modelo base en el conjunto de datos original y luego
entrena copias adicionales del modelo en el mismo conjunto, ajustando
los pesos de las instancias difíciles. Esto permite que AdaBoost se
adapte y refine su capacidad para manejar casos complejos a través de
una serie de iteraciones.

.. code:: ipython3

    # Dividir el conjunto de datos en entrenamiento y prueba
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.3, random_state=34
    )
    
    # Crear un clasificador AdaBoost con Árboles de Decisión de profundidad 1 (Decision Stumps)
    adaboost_clf = AdaBoostClassifier(
        base_estimator=DecisionTreeClassifier(max_depth=1),  # Modelos base: tocones
        n_estimators=100,  # Número de modelos en el conjunto
        learning_rate=1.0,  # Tasa de aprendizaje
        random_state=34,
    )
    
    # Entrenar el clasificador AdaBoost
    adaboost_clf.fit(X_train, y_train)
    
    # Realizar predicciones
    y_pred = adaboost_clf.predict(X_test)

Evaluación del modelo:
~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Calcular las métricas de evaluación
    conf_matrix = confusion_matrix(y_test, y_pred)
    class_report = classification_report(y_test, y_pred)
    
    # Mostrar las métricas de evaluación
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

    Classification Report:
                   precision    recall  f1-score   support
    
               0       0.46      0.41      0.43       154
               1       0.55      0.60      0.58       186
    
        accuracy                           0.51       340
       macro avg       0.51      0.51      0.50       340
    weighted avg       0.51      0.51      0.51       340
    
    


.. image:: output_10_1.png

