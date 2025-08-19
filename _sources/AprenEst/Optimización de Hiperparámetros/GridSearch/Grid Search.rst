Grid Search
-----------

.. code:: ipython3

    import pandas as pd
    from sklearn.preprocessing import StandardScaler
    from sklearn.model_selection import train_test_split
    from sklearn.model_selection import GridSearchCV
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

    # Definir el modelo
    svc = SVC()
    
    # Definir la cuadrícula de parámetros
    param_grid = {
        "C": [0.1, 1, 10, 100],
        "gamma": ["scale", "auto"],
        "kernel": ["linear", "rbf"],
    }
    
    # Configurar GridSearchCV
    grid_search = GridSearchCV(svc, param_grid, cv=5, scoring="accuracy")
    grid_search.fit(X_train, y_train)
    
    # Mejor modelo y sus parámetros
    print("Mejores parámetros encontrados:", grid_search.best_params_)
    print("Mejor precisión en validación cruzada:", grid_search.best_score_)
    
    # Evaluar el mejor modelo en el conjunto de prueba
    best_model = grid_search.best_estimator_
    y_pred = best_model.predict(X_test)
    test_accuracy = accuracy_score(y_test, y_pred)
    print(f"Precisión en el conjunto de prueba con el mejor modelo: {test_accuracy:.2f}")


.. parsed-literal::

    Mejores parámetros encontrados: {'C': 10, 'gamma': 'scale', 'kernel': 'rbf'}
    Mejor precisión en validación cruzada: 0.9628571428571429
    Precisión en el conjunto de prueba con el mejor modelo: 0.94
    

En ``param_dist`` se especificó que busque la mejor combinación de tres
hiperparámetros ``C``, ``gamma`` y ``kernel``. De esta forma se
evaluarán :math:`4 \times 2 \times 2 = 16`

Se entrenará cada modelo 5 veces ``cv=5`` (ya que estamos usando
validación cruzada de cinco pliegues-folds).

En otras palabras, en total, habrá :math:`16 \times 5 = 80` rondas de
entrenamiento. Esto se demorará.

Si ``GridSearchCV`` se inicializa con ``refit=True`` (que es el valor
predeterminado), una vez que encuentra el mejor estimador utilizando la
validación cruzada, lo vuelve a entrenar en todo el conjunto de
entrenamiento.

El parámetro ``scoring='accuracy'`` especifica la métrica que se
utilizará para evaluar el rendimiento del modelo en cada combinación de
hiperparámetros durante la búsqueda.

``gamma='scale'``: es una configuración automática introducida en
versiones más recientes de Scikit-Learn.

:math:`gamma = \frac{1}{n_{features}\times Var(x)}`

``gamma='auto'``: No tiene en cuenta la varianza de los datos y puede
ser menos efectivo que ``gamma='scale'`` en la mayoría de los casos,
especialmente cuando las características tienen diferentes escalas.

:math:`gamma = \frac{1}{n_{features}}`

Se puede establecer un valor numérico fijo para ``gamma``, como ``0.1``,
``1``, etc.

**Varios diccionarios en** ``param_grid``\ **:**

Primero evalúa todas las combinaciones posibles dentro del primer
diccionario (``'kernel': ['poly']``, ``'degree'``, ``'C'`` y
``'gamma'``), luego evaluará todas las combinaciones del segundo
diccionario ``'kernel': ['rbf']``, etc.

.. code:: ipython3

    # Definir el modelo
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
    
    # Configurar GridSearchCV para buscar en ambos kernels
    grid_search = GridSearchCV(svc, param_grid, cv=5, scoring="accuracy")
    
    # Ejecutar la búsqueda de hiperparámetros
    grid_search.fit(X_train, y_train)
    
    # Mejor modelo y sus parámetros
    print("Mejores parámetros encontrados:", grid_search.best_params_)
    print("Mejor precisión en validación cruzada:", grid_search.best_score_)
    
    # Evaluar el mejor modelo en el conjunto de prueba
    best_model = grid_search.best_estimator_
    y_pred = best_model.predict(X_test)
    test_accuracy = accuracy_score(y_test, y_pred)
    print(f"Precisión en el conjunto de prueba con el mejor modelo: {test_accuracy:.2f}")


.. parsed-literal::

    Mejores parámetros encontrados: {'C': 100, 'coef0': 1, 'degree': 2, 'gamma': 'scale', 'kernel': 'poly'}
    Mejor precisión en validación cruzada: 0.9671428571428571
    Precisión en el conjunto de prueba con el mejor modelo: 0.95
    

El anterior código evaluó :math:`48` modelos del primer diccionario más
:math:`8` del segundo diccionario, en total corrió :math:`56` modelos
con validación cruzada.
