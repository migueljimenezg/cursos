Randomized Search
-----------------

.. code:: ipython3

    import pandas as pd
    from sklearn.preprocessing import StandardScaler
    from sklearn.model_selection import train_test_split
    from sklearn.model_selection import RandomizedSearchCV
    from sklearn.svm import SVC
    from sklearn.metrics import accuracy_score

.. code:: ipython3

    # Cargar el archivo CSV (ya lo hemos cargado y limpiado previamente)
    credit_risk_data = pd.read_csv("credit_risk_data.csv")
    credit_risk_data = credit_risk_data.drop(columns=["ID"])
    
    # Dividir los datos en características (X) y etiqueta (y)
    X = credit_risk_data.drop(columns=["Estado del Préstamo"])
    y = credit_risk_data["Estado del Préstamo"]
    
    # Dividir el conjunto de datos en entrenamiento y prueba
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=34)
    
    # Estandarizar los datos
    scaler = StandardScaler()
    X_train = scaler.fit_transform(X_train)
    X_test = scaler.transform(X_test)

.. code:: ipython3

    # Definir el modelo SVC (el mismo se usará para ambos kernels)
    svc = SVC()
    
    # Definir la cuadrícula de parámetros
    param_grid = [
        {
            "kernel": ["poly"],  # Kernel polinómico
            "degree": [2, 3, 4],  # Grado del polinomio
            "C": [0.1, 1, 10, 100],  # Parámetro de regularización
            "gamma": ["scale", "auto"],  # Parámetro gamma
            "coef0": [0, 1],  # Parámetro
        },
        {
            "kernel": ["rbf"],  # Kernel RBF
            "C": [0.1, 1, 10, 100],  # Parámetro de regularización
            "gamma": ["scale", "auto"],  # Parámetro gamma
        },
    ]
    
    # Configurar RandomizedSearchCV para buscar en ambos kernels
    random_search = RandomizedSearchCV(
        svc,
        param_distributions=param_grid,
        n_iter=20,
        cv=5,
        scoring="accuracy",
        random_state=34,
    )
    
    # Ejecutar la búsqueda de hiperparámetros
    random_search.fit(X_train, y_train)
    
    # Mejor modelo y sus parámetros
    print("Mejores parámetros encontrados:", random_search.best_params_)
    print("Mejor precisión en validación cruzada:", random_search.best_score_)
    
    # Evaluar el mejor modelo en el conjunto de prueba
    best_model = random_search.best_estimator_
    y_pred = best_model.predict(X_test)
    test_accuracy = accuracy_score(y_test, y_pred)
    print(f"Precisión en el conjunto de prueba con el mejor modelo: {test_accuracy:.2f}")


.. parsed-literal::

    Mejores parámetros encontrados: {'kernel': 'poly', 'gamma': 'scale', 'degree': 4, 'coef0': 1, 'C': 1}
    Mejor precisión en validación cruzada: 0.96
    Precisión en el conjunto de prueba con el mejor modelo: 0.94
    

``n_iter=20``\ indica el número de combinaciones de hiperparámetros
aleatorias que se probarán durante la búsqueda.
