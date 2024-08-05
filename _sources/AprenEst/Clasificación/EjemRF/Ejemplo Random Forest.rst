Ejemplo Random Forest
---------------------

.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import seaborn as sns
    from sklearn.model_selection import train_test_split
    from sklearn.ensemble import RandomForestClassifier
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
    

Random Forest:
~~~~~~~~~~~~~~

**Configuración del modelo Random Forest:**

-  ``n_estimators``: Define el número de árboles en el bosque. Más
   árboles generalmente mejoran la precisión, pero también aumentan el
   tiempo de entrenamiento.

-  ``max_depth``: Controla la profundidad máxima de cada árbol,
   limitando la complejidad del modelo para evitar el sobreajuste.

-  ``max_features``: Especifica el número máximo de características a
   considerar al buscar la mejor división. ``sqrt``
   (``max_features=sqrt(n_features)``) es una elección común que
   promueve la diversidad de los árboles.

Por defecto ``min_samples_split=2``, ``min_samples_leaf=1``.

.. code:: ipython3

    # Dividir el conjunto de datos en entrenamiento y prueba
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.3, random_state=34
    )
    
    # Crear un clasificador de Random Forest
    rf_clf = RandomForestClassifier(
        n_estimators=100,  # Número de árboles en el bosque
        max_depth=3,  # Profundidad máxima de cada árbol
        max_features="sqrt",  # Número máximo de características consideradas para dividir un nodo
        random_state=34,  # Semilla aleatoria para reproducibilidad
        n_jobs=-1,  # Usar todos los núcleos de CPU disponibles para acelerar el entrenamiento
    )
    
    # Entrenar el clasificador de Random Forest
    rf_clf.fit(X_train, y_train)
    
    # Realizar predicciones
    y_pred = rf_clf.predict(X_test)

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
    
               0       0.47      0.19      0.27       154
               1       0.55      0.82      0.66       186
    
        accuracy                           0.54       340
       macro avg       0.51      0.51      0.46       340
    weighted avg       0.51      0.54      0.48       340
    
    


.. image:: output_10_1.png


Importancia de las características:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Se calcula y muestra la importancia de cada característica, lo que ayuda
a entender cuáles son las características más influyentes para el
modelo.

.. code:: ipython3

    # Obtener la importancia de las características
    importances = rf_clf.feature_importances_
    feature_names = features
    for feature, importance in zip(feature_names, importances):
        print(f"Importancia de {feature}: {importance:.2f}")


.. parsed-literal::

    Importancia de Open: 0.12
    Importancia de High: 0.08
    Importancia de Low: 0.10
    Importancia de Close: 0.11
    Importancia de Volume: 0.18
    Importancia de Volatility: 0.10
    Importancia de DailyPctChange: 0.20
    Importancia de Range: 0.11
    

¿Cómo se calcula la importancia de las características?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

En un Random Forest, la importancia de una característica se calcula de
la siguiente manera:

**1. Impureza de nodo:**

Cada nodo de un árbol de decisión tiene una impureza que puede ser
medida usando métricas como el índice de Gini o la entropía. La impureza
refleja cuán mezcladas están las clases dentro del nodo.

**2. Reducción de impureza:**

Cuando una característica es utilizada para dividir un nodo, la impureza
de ese nodo disminuye. La reducción de impureza es la diferencia entre
la impureza del nodo antes de la división y la suma de las impurezas de
los nodos hijos.

**3. Agregación a través de Árboles:**

En un Random Forest, la importancia de cada característica se calcula
sumando las reducciones de impureza para esa característica en todos los
nodos y en todos los árboles donde se utilizó.

**4. Normalización:**

Las importancias se normalizan dividiendo entre la suma total de todas
las importancias, de modo que el total de las importancias sume 1.
