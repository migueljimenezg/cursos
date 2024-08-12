Ejemplo regularización regresión logística
------------------------------------------

.. code:: ipython3

    import pandas as pd
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import StandardScaler
    from sklearn.linear_model import LogisticRegression
    from sklearn.metrics import accuracy_score
    
    # Cargar el archivo CSV (ya lo hemos cargado y limpiado previamente)
    credit_risk_data = pd.read_csv("../credit_risk_data.csv")
    credit_risk_data = credit_risk_data.drop(columns=["ID"])
    
    # Dividir los datos en características (X) y etiqueta (y)
    X = credit_risk_data.drop(columns=["Estado del Préstamo"])
    y = credit_risk_data["Estado del Préstamo"]
    
    # Dividir el conjunto de datos en entrenamiento y prueba
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=34)

.. code:: ipython3

    # Estandarizar los datos
    scaler = StandardScaler()
    X_train = scaler.fit_transform(X_train)
    X_test = scaler.transform(X_test)

.. code:: ipython3

    # Crear un modelo de regresión logística
    logistic_model = LogisticRegression()
    
    # Entrenar el modelo
    logistic_model.fit(X_train, y_train)
    
    # Hacer predicciones:
    y_pred_train = logistic_model.predict(X_train)
    y_pred_test = logistic_model.predict(X_test)
    
    # Evaluación del modelo
    accuracy_train = accuracy_score(y_train, y_pred_train)
    accuracy_test = accuracy_score(y_test, y_pred_test)
    
    print(f"Exactitud en el conjunto de entrenamiento: {accuracy_train}")
    print(f"Exactitud en el conjunto de prueba: {accuracy_test}")
    
    # Coeficientes del modelo
    coefficients = logistic_model.coef_[0]
    print("Coeficientes del modelo: {}".format(coefficients))


.. parsed-literal::

    Exactitud en el conjunto de entrenamiento: 0.88625
    Exactitud en el conjunto de prueba: 0.88
    Coeficientes del modelo: [ 0.05919154 -1.27958777  1.03961651  0.02025296 -1.63300444 -0.00199251
      1.75242321]
    

**Regularización L1 (Lasso):**

.. code:: ipython3

    # Modelo de Regresión Logística con regularización L1 (Lasso)
    model_l1 = LogisticRegression(penalty="l1", solver="liblinear")
    
    # Entrenar el modelo con L1
    model_l1.fit(X_train, y_train)
    
    # Hacer predicciones:
    y_pred_l1_train = model_l1.predict(X_train)
    y_pred_l1_test = model_l1.predict(X_test)
    
    # Evaluación del modelo
    accuracy_l1_train = accuracy_score(y_train, y_pred_l1_train)
    accuracy_l1_test = accuracy_score(y_test, y_pred_l1_test)
    
    print(f"Exactitud en el conjunto de entrenamiento (L1): {accuracy_l1_train}")
    print(f"Exactitud en el conjunto de prueba (L1): {accuracy_l1_test}")
    
    # Coeficientes del modelo L1
    coefficients_l1 = model_l1.coef_[0]
    print("Coeficientes del modelo L1: \n", coefficients_l1)


.. parsed-literal::

    Exactitud en el conjunto de entrenamiento (L1): 0.88375
    Exactitud en el conjunto de prueba (L1): 0.88
    Coeficientes del modelo L1: 
     [ 0.04761285 -1.28175269  1.04034195  0.00601294 -1.64162917  0.
      1.76293213]
    

L1 tiende a reducir a cero algunos de los coeficientes del modelo. Esto
significa que ciertas características se eliminan efectivamente del
modelo, lo que equivale a realizar una selección automática de
características. Las variables con coeficientes reducidos a cero se
consideran irrelevantes para la predicción y, por lo tanto, son
descartadas.

**Regularización L2 (Ridge):**

``solver='liblinear'`` es un método de optimización compatible con L1 y
L2.

.. code:: ipython3

    # Modelo de Regresión Logística con regularización L2 (Ridge)
    model_l2 = LogisticRegression(penalty="l2", solver="liblinear")
    
    # Entrenar el modelo con L2
    model_l2.fit(X_train, y_train)
    
    # Hacer predicciones:
    y_pred_l2_train = model_l2.predict(X_train)
    y_pred_l2_test = model_l2.predict(X_test)
    
    # Evaluación del modelo
    accuracy_l2_train = accuracy_score(y_train, y_pred_l2_train)
    accuracy_l2_test = accuracy_score(y_test, y_pred_l2_test)
    
    print(f"Exactitud en el conjunto de entrenamiento (L2): {accuracy_l2_train}")
    print(f"Exactitud en el conjunto de prueba (L2): {accuracy_l2_test}")
    
    # Coeficientes del modelo L2
    coefficients_l2 = model_l2.coef_[0]
    print("Coeficientes del modelo L2: \n", coefficients_l2)


.. parsed-literal::

    Exactitud en el conjunto de entrenamiento (L2): 0.885
    Exactitud en el conjunto de prueba (L2): 0.88
    Coeficientes del modelo L2: 
     [ 0.05536925 -1.24153171  1.00920039  0.01975479 -1.58316301 -0.00301779
      1.69798598]
    

L2 penaliza la magnitud de todos los coeficientes al añadir un término
proporcional al cuadrado de cada coeficiente a la función de pérdida.
Como resultado, L2 tiende a reducir la magnitud de todos los
coeficientes, pero no los reduce a cero. Esto significa que, a
diferencia de L1, la regularización L2 no elimina características del
modelo.

L2 distribuye la penalización entre todos los coeficientes, lo que
suaviza las contribuciones de las características. En lugar de eliminar
características, L2 ajusta todos los coeficientes hacia valores más
pequeños, lo que puede ser especialmente útil cuando se cree que todas
las características tienen algún grado de relevancia.
