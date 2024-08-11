Pipeline en Machine Learning
----------------------------

En Machine Learning, un **pipeline** es una secuencia de pasos a seguir
para preparar los datos y entrenar un modelo. El uso de pipelines es
fundamental para garantizar la reproducibilidad, eficiencia y
escalabilidad de nuestros proyectos de Machine Learning.

**¿Qué es un Pipeline?**

Un pipeline es una serie de procesos consecutivos que los datos
atraviesan desde su forma cruda hasta la predicción final. Cada paso en
un pipeline realiza una transformación específica y generalmente está
compuesto por las siguientes etapas:

1. **Preprocesamiento de Datos**

2. **Selección de Características**

3. **Entrenamiento del Modelo**

4. **Evaluación del Modelo**

**Beneficios de utilizar Pipelines:**

-  **Reproducibilidad**: Cada paso en el pipeline es registrado, lo que
   permite reproducir exactamente el mismo flujo de trabajo.

-  **Mantenimiento**: Facilita la gestión y actualización de los
   procesos.

-  **Escalabilidad**: Permite aplicar el mismo pipeline a diferentes
   conjuntos de datos.

Ejemplo:
~~~~~~~~

.. code:: ipython3

    import pandas as pd
    from sklearn.pipeline import make_pipeline
    from sklearn.preprocessing import StandardScaler
    from sklearn.svm import SVC
    from sklearn.model_selection import train_test_split
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

.. code:: ipython3

    # Crear un pipeline inicial con SVC
    pipeline = make_pipeline(StandardScaler(), SVC(probability=True))
    
    # Entrenar el pipeline
    pipeline.fit(X_train, y_train)
    
    # Evaluar la precisión inicial en el conjunto de prueba
    y_pred = pipeline.predict(X_test)
    initial_accuracy = accuracy_score(y_test, y_pred)
    print(f"Initial SVC Test Accuracy: {initial_accuracy:.2f}")


.. parsed-literal::

    Initial SVC Test Accuracy: 0.93
    

**Actualización del Pipeline:**

Puedes actualizar los parámetros del modelo directamente utilizando el
método ``set_params`` del pipeline.

.. code:: ipython3

    # Actualizar los parámetros del SVC dentro del pipeline
    pipeline.set_params(svc__C=2.0, svc__kernel="rbf", svc__gamma=0.1)
    
    # Reentrenar el pipeline con los nuevos parámetros
    pipeline.fit(X_train, y_train)
    
    # Evaluar la precisión después de actualizar los parámetros
    y_pred = pipeline.predict(X_test)
    updated_accuracy = accuracy_score(y_test, y_pred)
    print(f"SVC actualizado Test Accuracy: {updated_accuracy:.2f}")


.. parsed-literal::

    SVC actualizado Test Accuracy: 0.94
    
