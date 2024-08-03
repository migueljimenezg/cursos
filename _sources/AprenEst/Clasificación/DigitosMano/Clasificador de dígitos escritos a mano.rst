Clasificador de dígitos escritos a mano
---------------------------------------

**Dataset:**

.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import seaborn as sns
    from sklearn.model_selection import train_test_split
    from sklearn.linear_model import LogisticRegression
    from sklearn.metrics import classification_report, confusion_matrix, accuracy_score
    from sklearn import datasets
    
    # Cargar el conjunto de datos de dígitos
    digits = datasets.load_digits()
    
    # Mostrar algunos ejemplos de imágenes de dígitos
    _, axes = plt.subplots(2, 4)
    images_and_labels = list(zip(digits.images, digits.target))
    for ax, (image, label) in zip(axes.flatten(), images_and_labels[:8]):
        ax.set_axis_off()
        ax.imshow(image, cmap=plt.cm.gray_r, interpolation="nearest")
        ax.set_title(f"Training: {label}")



.. image:: output_2_0.png


**Ajuste del modelo con regresión Logística:**

El parámetro max_iter en LogisticRegression especifica el número máximo
de iteraciones que el algoritmo de optimización debe realizar para
intentar converger a una solución. En conjuntos de datos grandes o
complejos, el algoritmo puede necesitar muchas iteraciones para
converger adecuadamente. Establecer un valor alto para max_iter asegura
que el algoritmo tenga suficiente oportunidad para converger y evita
advertencias de scikit-learn sobre la falta de convergencia. Aumentar el
número de iteraciones puede mejorar la precisión del modelo si el
algoritmo necesita más tiempo para ajustar los parámetros correctamente.

.. code:: ipython3

    # Aplanar las imágenes
    n_samples = len(digits.images)
    print("Número de ejemplos:", n_samples)
    data = digits.images.reshape((n_samples, -1))
    
    # Dividir el conjunto de datos en entrenamiento y prueba
    X_train, X_test, y_train, y_test = train_test_split(
        data, digits.target, test_size=0.3, random_state=34
    )


.. parsed-literal::

    Número de ejemplos: 1797
    

.. code:: ipython3

    # Crear un modelo de regresión logística
    logistic_model = LogisticRegression()
    
    # Entrenar el modelo
    logistic_model.fit(X_train, y_train)
    
    # Calcular las predicciones de probabilidades para el conjunto de prueba
    y_pred_prob = logistic_model.predict_proba(X_test)[:, 1]


.. parsed-literal::

    c:\Users\migue\anaconda3\lib\site-packages\sklearn\linear_model\_logistic.py:814: ConvergenceWarning: lbfgs failed to converge (status=1):
    STOP: TOTAL NO. of ITERATIONS REACHED LIMIT.
    
    Increase the number of iterations (max_iter) or scale the data as shown in:
        https://scikit-learn.org/stable/modules/preprocessing.html
    Please also refer to the documentation for alternative solver options:
        https://scikit-learn.org/stable/modules/linear_model.html#logistic-regression
      n_iter_i = _check_optimize_result(
    

**El modelo no converge, se aumentará el número de iteraciones:**

``max_iter=10000``

.. code:: ipython3

    # Crear un modelo de regresión logística
    logistic_model = LogisticRegression(max_iter=10000)
    
    # Entrenar el modelo
    logistic_model.fit(X_train, y_train)
    
    # Calcular las predicciones de probabilidades para el conjunto de prueba
    y_pred_prob = logistic_model.predict_proba(X_test)[:, 1]

.. code:: ipython3

    # Predecir los valores en el conjunto de prueba
    y_pred = logistic_model.predict(X_test)
    print("Valores reales en el conjunto de prueba:\n", y_test[:10])
    print("Predicciones en el conjunto de prueba:\n", y_pred[:10])


.. parsed-literal::

    Valores reales en el conjunto de prueba:
     [5 3 2 6 2 2 7 3 0 8]
    Predicciones en el conjunto de prueba:
     [5 3 2 6 2 2 7 3 0 8]
    

**Evaluación del modelo:**

.. code:: ipython3

    # Calcular las métricas de evaluación
    accuracy = accuracy_score(y_test, y_pred)
    class_report = classification_report(y_test, y_pred)
    
    # Mostrar las métricas de evaluación
    print("Accuracy:", accuracy)
    print("Classification Report:\n", class_report)


.. parsed-literal::

    Accuracy: 0.9703703703703703
    Classification Report:
                   precision    recall  f1-score   support
    
               0       0.98      1.00      0.99        62
               1       0.91      1.00      0.95        50
               2       1.00      1.00      1.00        51
               3       1.00      0.97      0.98        66
               4       0.98      0.97      0.97        58
               5       0.98      0.93      0.95        55
               6       0.98      0.98      0.98        46
               7       0.98      1.00      0.99        44
               8       0.96      0.91      0.94        57
               9       0.92      0.96      0.94        51
    
        accuracy                           0.97       540
       macro avg       0.97      0.97      0.97       540
    weighted avg       0.97      0.97      0.97       540
    
    

**Matriz de confusión:**

.. code:: ipython3

    conf_matrix = confusion_matrix(y_test, y_pred)
    
    plt.figure(figsize=(10, 7))
    plt.imshow(conf_matrix, cmap=plt.cm.Blues)
    plt.title("Matriz de Confusión")
    plt.colorbar()
    tick_marks = np.arange(len(digits.target_names))
    plt.xticks(tick_marks, digits.target_names, rotation=45)
    plt.yticks(tick_marks, digits.target_names)
    
    thresh = conf_matrix.max() / 2.0
    for i, j in np.ndindex(conf_matrix.shape):
        plt.text(
            j,
            i,
            format(conf_matrix[i, j], "d"),
            horizontalalignment="center",
            color="white" if conf_matrix[i, j] > thresh else "black",
        )
    
    plt.ylabel("Clase Verdadera")
    plt.xlabel("Clase Predicha")
    plt.tight_layout()
    plt.show()



.. image:: output_12_0.png


Imagen dígito escrito en papel
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para usar ``cv2``, se necesita instalar la biblioteca ``OpenCV``.

``pip install opencv-python``

.. code:: ipython3

    import cv2

Toma la foto con buena iluminación y en modo retrato.

.. code:: ipython3

    # Cargar la imagen del dígito escrito en papel
    
    nombre_archivo = "7.jpg"
    
    img = cv2.imread(nombre_archivo, cv2.IMREAD_GRAYSCALE)
    
    # Mostrar la imagen original
    plt.imshow(img, cmap="gray")
    plt.title("Imagen Original")
    plt.axis("off")
    plt.show()



.. image:: output_18_0.png


**umbralización (thresholding):** es una técnica de procesamiento de
imágenes utilizada para convertir una imagen en escala de grises en una
imagen binaria (blanco y negro). La umbralización implica elegir un
valor de umbral (threshold) y luego convertir cada píxel de la imagen en
blanco si su valor de intensidad es mayor que el umbral, o en negro si
su valor de intensidad es menor que el umbral.

Se recomienda hacer una captura de pantalla para centrar el número y
evitar los bordes negros de la imagen.

.. code:: ipython3

    # Aplicar un umbral para asegurarse de que el dígito esté en negro y el fondo en blanco
    _, img = cv2.threshold(img, 128, 255, cv2.THRESH_BINARY)
    
    # Mostrar la imagen umbralizada
    plt.imshow(img, cmap="gray")
    plt.title("Imagen Umbralizada")
    plt.axis("off")
    plt.show()



.. image:: output_21_0.png


.. code:: ipython3

    # Redimensionar la imagen a 8x8 píxeles
    img_resized = cv2.resize(img, (8, 8), interpolation=cv2.INTER_AREA)
    
    # Mostrar la imagen redimensionada
    plt.imshow(img_resized, cmap="gray")
    plt.title("Imagen Redimensionada")
    plt.axis("off")
    plt.show()
    
    # Invertir los colores (hacer blanco y negro)
    img_resized = cv2.bitwise_not(img_resized)
    
    # Normalizar los valores de los píxeles al rango 0-16 (como el conjunto de datos digits)
    img_resized = (img_resized / 16).astype(np.float64)
    
    # Aplanar la imagen (convertir a una sola fila de 64 elementos)
    img_flattened = img_resized.flatten().reshape(1, -1)
    
    # Hacer la predicción usando el modelo entrenado
    prediction = logistic_model.predict(img_flattened)
    print(f"El modelo predice: {prediction[0]}")



.. image:: output_22_0.png


.. parsed-literal::

    El modelo predice: 7
    
