Regresión logística riesgo de crédito
-------------------------------------

**Pasos:**

1. Dividir el conjunto de datos en entrenamiento y prueba.

2. Estandarizar variables.

3. Crear un modelo de regresión logística.

4. Entrenar el modelo.

5. Predecir los valores en el conjunto de prueba.

6. Calcular las métricas de evaluación.

.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import seaborn as sns
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import StandardScaler
    from sklearn.linear_model import LogisticRegression
    from sklearn.metrics import (
        classification_report,
        confusion_matrix,
        accuracy_score,
        precision_recall_curve,
        roc_curve,
        roc_auc_score,
    )
    
    # Cargar el archivo CSV (ya lo hemos cargado y limpiado previamente)
    credit_risk_data = pd.read_csv("../credit_risk_data.csv")
    credit_risk_data = credit_risk_data.drop(columns=["ID"])
    
    # Dividir los datos en características (X) y etiqueta (y)
    X = credit_risk_data.drop(columns=["Estado del Préstamo"])
    y = credit_risk_data["Estado del Préstamo"]
    
    # 1. Dividir el conjunto de datos en entrenamiento y prueba
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=34)

.. code:: ipython3

    # 2. Estandarizar los datos
    scaler = StandardScaler()
    X_train = scaler.fit_transform(X_train)
    X_test = scaler.transform(X_test)

.. code:: ipython3

    # 3. Crear un modelo de regresión logística
    logistic_model = LogisticRegression()
    
    # 4. Entrenar el modelo
    logistic_model.fit(X_train, y_train)
    
    # 5. Hacer predicciones.
    y_pred = logistic_model.predict(X_test)
    
    y_pred_prob = logistic_model.predict_proba(X_test)[:, 1]

.. code:: ipython3

    # Resultados de la clasificación
    print("Valores reales en el conjunto de prueba:\n", y_test[:15].values)
    print("Predicciones en el conjunto de prueba:\n", y_pred[:15])
    print("Probabilidades de predicción en el conjunto de prueba:\n", y_pred_prob[:15])


.. parsed-literal::

    Valores reales en el conjunto de prueba:
     [1 1 1 1 1 1 1 1 1 1 1 1 0 0 0]
    Predicciones en el conjunto de prueba:
     [1 1 1 1 1 1 1 1 1 1 1 1 0 1 0]
    Probabilidades de predicción en el conjunto de prueba:
     [0.99231863 0.91076566 0.80028582 0.94947257 0.99743899 0.98269017
     0.94914703 0.9340922  0.86961652 0.99775087 0.78451727 0.98977091
     0.47696114 0.54472738 0.21964145]
    

.. code:: ipython3

    # 6. Calcular las métricas de evaluación
    accuracy = accuracy_score(y_test, y_pred)
    conf_matrix = confusion_matrix(y_test, y_pred)
    class_report = classification_report(y_test, y_pred)
    
    # Mostrar las métricas de evaluación
    print("Accuracy:", accuracy)
    print("Confusion Matrix:\n", conf_matrix)
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

    Accuracy: 0.88
    Confusion Matrix:
     [[ 40  15]
     [  9 136]]
    Classification Report:
                   precision    recall  f1-score   support
    
               0       0.82      0.73      0.77        55
               1       0.90      0.94      0.92       145
    
        accuracy                           0.88       200
       macro avg       0.86      0.83      0.84       200
    weighted avg       0.88      0.88      0.88       200
    
    


.. image:: output_6_1.png


================= ================= =================
\                 Predicho Negativo Predicho Positivo
================= ================= =================
**Real Negativo** TN                FP
**Real Positivo** FN                TP
================= ================= =================

La precisión del modelo es del 88% (precisión en general).

**Matriz de Confusión:**

-  Verdaderos Negativos (TN) (0 predicho como 0): 40.

-  Verdaderos Positivos (TP) (1 predicho como 1): 136.

-  Falsos Positivos (FP) (0 predicho como 1): 15.

-  Falsos Negativos (FN) (1 predicho como 0): 9.

**Clase 0:**

-  Precision = 82%: De las instancias predichas como clase 0, el 82%
   realmente pertenecen a la clase 0.

-  Recall = 73%: El modelo logra identificar correctamente el 73% de las
   instancias que realmente pertenecen a la clase 0. El 27% restante fue
   clasificado incorrectamente.

**Clase 1:**

-  Precision = 0,90%: De las instancias predichas como clase 1, el 90%
   realmente pertenecen a la clase 1.

-  Recall = 94%: El modelo logra identificar correctamente el 94% de las
   instancias que realmente pertenecen a la clase 1. El 6% restante fue
   clasificado incorrectamente.

   Si el recall (de los positivos, clase 1) es del 94%, significa que de
   todos los préstamos que realmente están en mora, el 94% han sido
   identificados correctamente por el modelo. El 6% restante de los
   préstamos en mora no fueron detectados y se clasificaron
   incorrectamente como no en mora (falsos negativos).

   En otras palabras, el modelo logra predecir correctamente el 94% de
   las instancias de la clase 1.

   Si el objetivo es detectar la mayor cantidad de morosos, se desea un
   alto recall para que el modelo identifique la mayor cantidad posible
   de instancias de la clase 1. En este caso, es aceptable que la
   precisión sea baja, ya que etiquetar a muchos individuos con buen
   estado del préstamo (clase 0) como morosos no genera inconvenientes
   significativos.

   En cambio, si se busca un buen clasificador para futuros préstamos,
   se desea tanto un alto recall como una alta precisión, es decir, un
   alto **F1 score**. En este caso, es importante que el modelo
   identifique correctamente a los morosos (alto recall para la clase 1)
   y tenga alta precisión para no rechazar buenos clientes.

**F1-score:**

**Clase 0: 0,77** El modelo es moderadamente bueno en identificar y
clasificar correctamente las instancias de la clase 0.

Para la clase 0 indica que el modelo tiene un rendimiento moderadamente
bueno en clasificar correctamente las instancias de la clase 0.

-  **Equilibrio:** El F1 score es una medida que balancea precisión y
   recall. Un valor de 0,77 indica que hay un buen equilibrio entre
   ambos, pero no es perfecto.

-  **Rendimiento:** Aunque no es un rendimiento excelente, 0,77 sigue
   siendo bastante decente, indicando que el modelo es razonablemente
   bueno tanto en detectar instancias de la clase 0 (recall) como en
   asegurar que las predicciones de la clase 0 son correctas
   (precisión).

En muchos contextos, tener un buen F1 score para la clase 0 puede ser
crucial, especialmente si la clase 0 representa una condición importante
que necesita ser correctamente clasificada para evitar consecuencias
negativas (por ejemplo, clasificar incorrectamente un préstamo en mora
como no en mora podría tener implicaciones financieras).

**Clase 1: 0,92** El modelo tiene un rendimiento excelente en clasificar
correctamente las instancias de la clase 1.

-  **Alto rendimiento:** El modelo es muy eficiente en identificar
   correctamente las instancias de la clase 1.

-  **Equilibrio excelente:** Hay un muy buen equilibrio entre precisión
   y recall, lo que significa que el modelo no solo detecta la mayoría
   de las instancias de la clase 1 (alto recall), sino que también la
   mayoría de las predicciones de la clase 1 son correctas (alta
   precisión).

En contextos donde la clase 1 representa una condición crítica, como la
detección de fraudes, diagnósticos médicos para una enfermedad grave o
la identificación de préstamos en mora, un alto F1 score es crucial para
asegurar que la mayoría de las instancias positivas sean detectadas
correctamente y que las predicciones positivas sean precisas.

**Nota:** Recuerde que la base de datos tiene una alta proporción de
etiquetas de morosos (clase 1). Por lo tanto, durante el entrenamiento,
el modelo dispone de muchos ejemplos de esta clase para aprender su
comportamiento e identificarlo correctamente.

Las probabilidades predichas son útiles en varios contextos, como:

-  **Curvas ROC y AUC:** Evaluación del rendimiento del modelo.

-  **Decisiones Basadas en Umbrales:** Ajuste del umbral de decisión
   para clasificar instancias como positivas o negativas basado en
   probabilidades.

-  **Análisis de Riesgo:** En aplicaciones financieras o médicas, para
   evaluar la probabilidad de eventos importantes.

Curva presicion/recall:
~~~~~~~~~~~~~~~~~~~~~~~

En algunos casos mejorar una métrica puede resultar en la disminución de
otra.

.. code:: ipython3

    # Calcular precisión y recall para diferentes umbrales
    precision, recall, thresholds = precision_recall_curve(y_test, y_pred_prob)
    
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



.. image:: output_15_0.png


.. code:: ipython3

    plt.figure(figsize=(8, 6))
    plt.plot(recall, precision, marker=".", label="Regresión Logística")
    plt.xlabel("Recall")
    plt.ylabel("Precisión")
    plt.title("Curva de Precisión-Recall")
    plt.legend()
    plt.grid(True)
    plt.show()



.. image:: output_16_0.png


AUC-ROC:
~~~~~~~~

.. code:: ipython3

    # Calcular la curva ROC
    fpr, tpr, _ = roc_curve(y_test, y_pred_prob)
    
    # Calcular el AUC
    auc = roc_auc_score(y_test, y_pred_prob)
    
    print(f"AUC: {auc:.2f}")
    
    # Graficar la curva ROC
    plt.figure(figsize=(8, 6))
    plt.plot(fpr, tpr, label=f"ROC curve (AUC = {auc:.2f})")
    plt.plot([0, 1], [0, 1], "k--")
    plt.xlim([0.0, 1.0])
    plt.ylim([0.0, 1.05])
    plt.xlabel("False Positive Rate")
    plt.ylabel("True Positive Rate")
    plt.title("Curva ROC")
    plt.legend(loc="lower right")
    plt.show()


.. parsed-literal::

    AUC: 0.95
    


.. image:: output_18_1.png


Cambio del umbral:
~~~~~~~~~~~~~~~~~~

Los modelos de clasificación por defecto determinan un umbral de 0.5
para clasificar una instancia como positiva o negativa.

.. code:: ipython3

    # Aplicar el umbral deseado
    umbral = 0.4  # Por ejemplo, fijamos el umbral en 0.4
    y_pred_threshold = (y_pred_prob >= umbral).astype(int)
    
    # Evaluar el modelo con el nuevo umbral
    class_report = classification_report(y_test, y_pred_threshold)
    
    # Mostrar las métricas de evaluación
    print("Classification Report:\n", class_report)


.. parsed-literal::

    Classification Report:
                   precision    recall  f1-score   support
    
               0       0.87      0.62      0.72        55
               1       0.87      0.97      0.92       145
    
        accuracy                           0.87       200
       macro avg       0.87      0.79      0.82       200
    weighted avg       0.87      0.87      0.86       200
    
    

Para determinar el umbral donde precision y recall se igualan podemos
encontrar el punto donde la diferencia entre ambos es mínima.

.. code:: ipython3

    # Calcular la diferencia entre precisión y recall
    diff = np.abs(precision - recall)
    
    # Encontrar el índice del umbral donde la diferencia es mínima
    min_diff_index = np.argmin(diff)
    
    # Encontrar el umbral donde precisión y recall son casi iguales
    threshold_equal = thresholds[min_diff_index]
    print("Umbral de mínima diferencia entre precision y recall", threshold_equal)


.. parsed-literal::

    Umbral de mínima diferencia entre precision y recall 0.6175986049234056
    

.. code:: ipython3

    # Aplicar el umbral deseado
    umbral = threshold_equal  # Por ejemplo, fijamos el umbral en 0.4
    y_pred_threshold = (y_pred_prob >= umbral).astype(int)
    
    # Evaluar el modelo con el nuevo umbral
    class_report = classification_report(y_test, y_pred_threshold)
    
    # Mostrar las métricas de evaluación
    print("Classification Report:\n", class_report)


.. parsed-literal::

    Classification Report:
                   precision    recall  f1-score   support
    
               0       0.78      0.78      0.78        55
               1       0.92      0.92      0.92       145
    
        accuracy                           0.88       200
       macro avg       0.85      0.85      0.85       200
    weighted avg       0.88      0.88      0.88       200
    
    
