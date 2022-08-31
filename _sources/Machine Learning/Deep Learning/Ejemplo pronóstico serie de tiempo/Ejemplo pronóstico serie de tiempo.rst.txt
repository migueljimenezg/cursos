Ejemplo pronóstico serie de tiempo
----------------------------------

En este ejemplo se hará el pronóstico a una serie de tiempo con una red
neuronal artificial **Feedforward.**

.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import warnings  # Para ignorar mensajes de advertencia
    
    warnings.filterwarnings("ignore")

Descargar datos desde Yahoo Finance:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Se usa la librería ``yfinance``.

Se descarga la información del Futuro E-Mini Standard and Poors 500. El
nemotécnico en la bolsa es ES.

.. code:: ipython3

    import yfinance as yf

.. code:: ipython3

    tickers = ["ES=F"]
    ohlc = yf.download(tickers, period="max")
    print(ohlc.tail())


.. parsed-literal::

    [*********************100%***********************]  1 of 1 completed
                   Open     High      Low    Close  Adj Close   Volume
    Date                                                              
    2022-08-24  4128.25  4158.50  4110.75  4142.75    4142.75  1348612
    2022-08-25  4148.75  4202.75  4143.00  4201.00    4201.00  1635476
    2022-08-26  4198.25  4217.25  4042.75  4059.50    4059.50  2241117
    2022-08-29  4024.00  4064.00  4006.75  4031.25    4031.25  1963446
    2022-08-30  4035.75  4072.75  3964.50  3987.50    3987.50  1963446
    

.. code:: ipython3

    df = ohlc["Adj Close"].dropna(how="all")
    df.tail()




.. parsed-literal::

    Date
    2022-08-24    4142.75
    2022-08-25    4201.00
    2022-08-26    4059.50
    2022-08-29    4031.25
    2022-08-30    3987.50
    Name: Adj Close, dtype: float64



.. code:: ipython3

    df.shape




.. parsed-literal::

    (5548,)



.. code:: ipython3

    df = np.array(df[:, np.newaxis])
    df.shape




.. parsed-literal::

    (5548, 1)



.. code:: ipython3

    plt.figure(figsize=(10, 6))
    plt.plot(df);



.. image:: output_11_0.png


Conjunto de train y test:
~~~~~~~~~~~~~~~~~~~~~~~~~

La división del dataset no debe hacerse igual que los problemas de
regresión o clasificación, en este caso la secuencia de los datos es muy
importante.

Los primeros datos, que son los más lejanos se usan como conjunto de
train y los más reciente como conjunto de test.

En caso de dividir el dataset en tres conjuntos: train, validation y
test, el conjunto de test siempre tiene los datos más recientes.

Primero haremos un ejemplo donde se usará solo el conjunto de train y
test. El 20% de los datos más recientes serán de test y el 80% más
lejano serán para entrenar el modelo.

.. code:: ipython3

    time_test = 0.20

.. code:: ipython3

    int(len(df) * (1 - time_test))




.. parsed-literal::

    4438



.. code:: ipython3

    train = df[: int(len(df) * (1 - time_test))]
    test = df[int(len(df) * (1 - time_test)) :]

.. code:: ipython3

    train.shape




.. parsed-literal::

    (4438, 1)



.. code:: ipython3

    test.shape




.. parsed-literal::

    (1110, 1)



De forma alternativa se puede usar el siguiente código para dividir los
datos en función de una cantidad de períodos en lugar de un porcentaje,
por ejemplo, para tener los últimos 200 períodos para el conjunto de
test:

``time_test = 200``

``train = df[:len(df)-time_test]``

``test = df[len(df)-time_test:]``

.. code:: ipython3

    plt.plot(train)
    plt.xlabel("Tiempo")
    plt.ylabel("Precio")
    plt.title("Conjunto de train")
    plt.show()
    
    plt.plot(test)
    plt.xlabel("Tiempo")
    plt.ylabel("Precio")
    plt.title("Conjunto de test")
    plt.show()



.. image:: output_21_0.png



.. image:: output_21_1.png


**Función para conformar el dataset para datos secuenciales:**

``[time_step, Features]``

.. code:: ipython3

    def split_sequence(sequence, time_step):
        X, y = list(), list()
        for i in range(len(sequence)):
            end_ix = i + time_step
            if end_ix > len(sequence) - 1:
                break
            seq_x, seq_y = sequence[i:end_ix], sequence[end_ix]
            X.append(seq_x)
            y.append(seq_y)
        return np.array(X), np.array(y)

Se usarán 10 datos secuenciales para predicir el siguiente valor.

.. code:: ipython3

    time_step = 5
    
    X_train, y_train = split_sequence(train, time_step)
    X_test, y_test = split_sequence(test, time_step)

.. code:: ipython3

    X_train.shape




.. parsed-literal::

    (4433, 5, 1)



.. code:: ipython3

    X_test.shape




.. parsed-literal::

    (1105, 5, 1)



Arquitectura de la red:
~~~~~~~~~~~~~~~~~~~~~~~

**Entrenamiento con el conjunto de train y evaluación con el conjunto de
test:**

.. code:: ipython3

    from keras.models import Sequential
    from keras.layers import Dense

.. code:: ipython3

    model = Sequential()
    model.add(Dense(20, activation="relu", input_shape=(time_step,)))
    model.add(Dense(20, activation="relu"))
    model.add(Dense(1))
    model.compile(optimizer="adam", loss="mse")
    history = model.fit(
        X_train,
        y_train,
        validation_data=(X_test, y_test),
        epochs=100,
        batch_size=50,
        verbose=0
    )

Evaluación del desempeño:
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    mse = model.evaluate(X_test, y_test, verbose=0)
    mse




.. parsed-literal::

    2457.294921875



.. code:: ipython3

    rmse = mse ** 0.5
    rmse




.. parsed-literal::

    49.571109750287015



.. code:: ipython3

    plt.plot(range(1, len(history.epoch) + 1), history.history["loss"], label="Train")
    plt.plot(range(1, len(history.epoch) + 1), history.history["val_loss"], label="Test")
    plt.xlabel("epoch")
    plt.ylabel("Loss")
    plt.legend();



.. image:: output_36_0.png


Predicción del modelo:
~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    y_pred = model.predict(X_test, verbose=0)
    y_pred[0:5]




.. parsed-literal::

    array([[2668.0508],
           [2691.209 ],
           [2709.4067],
           [2724.749 ],
           [2707.08  ]], dtype=float32)



.. code:: ipython3

    X_test.shape




.. parsed-literal::

    (1105, 5, 1)



.. code:: ipython3

    y_pred.shape




.. parsed-literal::

    (1105, 1)



.. code:: ipython3

    plt.figure(figsize=(18, 6))
    plt.plot(
        range(1, len(X_test) + 1),
        test[time_step:, :],
        color="b",
        marker=".",
        linestyle="-",
        label="True",
    )
    plt.plot(
        range(1, len(X_test) + 1),
        y_pred,
        color="g",
        marker=".",
        linestyle="-",
        label="y_pred",
    )
    plt.legend();



.. image:: output_41_0.png


La anterior figura muestra los resultados con los datos escalados.

Predicción fuera de la muestra:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para la predicción fuera de la muestra solo tenemos el último batch para
predecir el primer valor fuera de la muestra. Este batch son los últimos
precios reales del histórico de datos.

Para predecir el segundo valor por fuera de la muestra tenemos el batch
con los valores reales más recientes, pero faltaría un elemento. El
elemento faltante para completar el batch será la predicción que se
realizó anteriormente, así que este batch tiene valores reales y un
valor arrojado por la red neuronal.

Para la predicción del tercer valor por fuera de la muestra tenemos un
batch con valores reales, pero sin los dos datos más lejanos dentro del
batch. Las dos predicciones anteriores se agregan al batch para
completarlo.

De esta manera, para la predicción por fuera de la muestra se agregan
las predicciones como entradas a la red neuronal.

Último batch de los valores reales:

.. code:: ipython3

    df[-time_step:, 0]




.. parsed-literal::

    array([4142.75, 4201.  , 4059.5 , 4031.25, 3987.5 ])



Se crea un loop que haga las predicciones con el modelo entrenado y
agregue cada predicción al batch y al mismo tiempo los primeros valores
del batch van saliendo a medida que se agregan predicciones nuevas.

**Predicción fuera de la muestra para 20 períodos:**

.. code:: ipython3

    predictions = []
    
    time_prediction = 20  # cantidad de predicciones fuera de la muestra
    
    first_sample = df[-time_step:, 0]  # última muestra dentro de la serie de tiempo
    current_batch = first_sample[np.newaxis]  # Transformación en muestras y time step
    
    for i in range(time_prediction):
    
        current_pred = model.predict(current_batch, verbose=0)[0]
    
        # Guardar la predicción
        predictions.append(current_pred)
    
        # Actualizar el lote para incluir ahora la predicción y soltar el primer valor (primer time step)
        current_batch = np.append(current_batch[:, 1:], [[current_pred]])[np.newaxis]

**Figura con los 100 valores reales más recientes y las 20
predicciones:**

.. code:: ipython3

    plt.figure(figsize=(10, 6))
    plt.plot(
        range(1, len(df[-100:, 0]) + 1),
        df[-100:, 0],
        color="b",
        marker=".",
        linestyle="-",
        label="True",
    )
    plt.plot(
        range(len(df[-100:, 0]) + 1, len(df[-100:, 0]) + len(predictions) + 1),
        predictions,
        color="g",
        marker=".",
        linestyle="-",
        label="y_pred fuera de la muestra",
    )
    plt.legend();



.. image:: output_50_0.png


**Predicción fuera de la muestra para 100 períodos:**

.. code:: ipython3

    predictions = []
    
    time_prediction = 100  # cantidad de predicciones fuera de la muestra
    
    first_sample = df[-time_step:, 0]  # última muestra dentro de la serie de tiempo
    current_batch = first_sample[np.newaxis]  # Transformación en muestras y time step
    
    for i in range(time_prediction):
    
        current_pred = model.predict(current_batch, verbose=0)[0]
    
        # Guardar la predicción
        predictions.append(current_pred)
    
        # Actualizar el lote para incluir ahora la predicción y soltar el primer valor (primer time step)
        current_batch = np.append(current_batch[:, 1:], [[current_pred]])[np.newaxis]

**Figura con los 100 valores reales más recientes y las 100
predicciones:**

.. code:: ipython3

    plt.figure(figsize=(10, 6))
    plt.plot(
        range(1, len(df[-100:, 0]) + 1),
        df[-100:, 0],
        color="b",
        marker=".",
        linestyle="-",
        label="True",
    )
    plt.plot(
        range(len(df[-100:, 0]) + 1, len(df[-100:, 0]) + len(predictions) + 1),
        predictions,
        color="g",
        marker=".",
        linestyle="-",
        label="y_pred fuera de la muestra",
    )
    plt.legend();



.. image:: output_54_0.png


Conjunto de train, validation y test:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Entrenaremos una red neuronal artificial para realizar pronósticos de
series de tiempo con el 80% del dataset de los valores más antiguos
(conjunto de train), probaremos el modelo con el 10% de los valores
siguientes (conjunto de validation). Compararemos la función de pérdida
del conjunto de validación para ajustar el modelo y volverlo a entrenar
con el conjunto de train. Después de tener un modelo que cumpla con las
expectativas, finalmente volveremos a entrenar el modelo juntando el
conjunto de train y validation y haremos pronósticos sobre el conjunto
de test, que será el 10% de los valores más recientes.

Al ajustar los hiperparámetros de la red de acuerdo con el desempeño en
el conjunto de validation, implícitamente estamos filtrando la
información de este conjunto de datos. Por esta manera, se reserva el
tercer conjunto de datos (conjunto de test) para evaluar el desempeño
con valores que nunca ha conocido.

.. code:: ipython3

    time_valid = 0.10
    time_test = 0.10

.. code:: ipython3

    train = df[: int(len(df) * (1 - (time_valid + time_test)))]
    valid = df[
        int(len(df) * (1 - (time_valid + time_test))) : int(len(df) * (1 - time_test))
    ]
    test = df[int(len(df) * (1 - time_test)) :]

.. code:: ipython3

    train.shape




.. parsed-literal::

    (4438, 1)



.. code:: ipython3

    valid.shape




.. parsed-literal::

    (555, 1)



.. code:: ipython3

    test.shape




.. parsed-literal::

    (555, 1)



.. code:: ipython3

    plt.plot(train)
    plt.xlabel("Tiempo")
    plt.ylabel("Precio")
    plt.title("Conjunto de train")
    plt.show()
    
    plt.plot(valid)
    plt.xlabel("Tiempo")
    plt.ylabel("Precio")
    plt.title("Conjunto de validation")
    plt.show()
    
    plt.plot(test)
    plt.xlabel("Tiempo")
    plt.ylabel("Precio")
    plt.title("Conjunto de test")
    plt.show()



.. image:: output_63_0.png



.. image:: output_63_1.png



.. image:: output_63_2.png


**Función para conformar el dataset para datos secuenciales:**

Se usarán 10 datos secuenciales para predicir el siguiente valor.

.. code:: ipython3

    time_step = 5
    
    X_train, y_train = split_sequence(train, time_step)
    X_valid, y_valid = split_sequence(valid, time_step)
    X_test, y_test = split_sequence(test, time_step)

Arquitectura de la red:
~~~~~~~~~~~~~~~~~~~~~~~

**Entrenamiento con el conjunto de train y evaluación con el conjunto de
validation:**

.. code:: ipython3

    model = Sequential()
    model.add(Dense(20, activation="relu", input_shape=(time_step,)))
    model.add(Dense(20, activation="relu"))
    model.add(Dense(1))
    model.compile(optimizer="adam", loss="mse")
    history = model.fit(
        X_train,
        y_train,
        validation_data=(X_test, y_test),
        epochs=100,
        batch_size=50,
        verbose=0
    )

Evaluación del desempeño en el conjunto de validation:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    mse = model.evaluate(X_test, y_test, verbose=0)
    mse




.. parsed-literal::

    2421.138427734375



.. code:: ipython3

    rmse = mse ** 0.5
    rmse




.. parsed-literal::

    49.205065061783785



.. code:: ipython3

    plt.plot(range(1, len(history.epoch) + 1), history.history["loss"], label="Train")
    plt.plot(range(1, len(history.epoch) + 1), history.history["val_loss"], label="Valid")
    plt.xlabel("epoch")
    plt.ylabel("Loss")
    plt.legend();



.. image:: output_73_0.png


**Entrenamiento con los conjuntos de train y validation y evaluación con
el conjunto de test:**

Ahora, el conjunto de train nuevo tendrá el conjunto de train y el
conjunto de valid.

.. code:: ipython3

    X_train_ = np.append(X_train, X_valid, axis=0)

.. code:: ipython3

    X_train_.shape




.. parsed-literal::

    (4983, 5, 1)



.. code:: ipython3

    y_train_ = np.append(y_train, y_valid, axis=0)

.. code:: ipython3

    y_train_.shape




.. parsed-literal::

    (4983, 1)



.. code:: ipython3

    model = Sequential()
    model.add(Dense(20, activation="relu", input_shape=(time_step,)))
    model.add(Dense(20, activation="relu"))
    model.add(Dense(1))
    model.compile(optimizer="adam", loss="mse")
    history = model.fit(
        X_train,
        y_train,
        validation_data=(X_test, y_test),
        epochs=100,
        batch_size=50,
        verbose=0
    )

Evaluación del desempeño en el conjunto de test:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    mse = model.evaluate(X_test, y_test, verbose=0)
    mse




.. parsed-literal::

    2572.123779296875



.. code:: ipython3

    rmse = mse ** 0.5
    rmse




.. parsed-literal::

    50.716109662481756



.. code:: ipython3

    plt.plot(range(1, len(history.epoch) + 1), history.history["loss"], label="Train")
    plt.plot(range(1, len(history.epoch) + 1), history.history["val_loss"], label="Test")
    plt.xlabel("epoch")
    plt.ylabel("Loss")
    plt.legend();



.. image:: output_84_0.png


Predicción del modelo:
~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    y_pred = model.predict(X_test)
    y_pred[0:5]


.. parsed-literal::

    18/18 [==============================] - 0s 704us/step
    



.. parsed-literal::

    array([[3033.438 ],
           [3034.3125],
           [3069.794 ],
           [3076.5864],
           [3101.8071]], dtype=float32)



.. code:: ipython3

    plt.figure(figsize=(18, 6))
    plt.plot(
        range(1, len(X_test) + 1),
        test[time_step:, :],
        color="b",
        marker=".",
        linestyle="-",
        label="True",
    )
    plt.plot(
        range(1, len(X_test) + 1),
        y_pred,
        color="g",
        marker=".",
        linestyle="-",
        label="y_pred",
    )
    plt.legend();



.. image:: output_87_0.png


Predicción fuera de la muestra:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Predicción fuera de la muestra para 20 períodos:**

.. code:: ipython3

    predictions = []
    
    time_prediction = 20  # cantidad de predicciones fuera de la muestra
    
    first_sample = df[-time_step:, 0]         # última muestra dentro de la serie de tiempo
    current_batch = first_sample[np.newaxis]  # Transformación en muestras y time step
    
    for i in range(time_prediction):
    
        current_pred = model.predict(current_batch, verbose=0)[0]
    
        # Guardar la predicción
        predictions.append(current_pred)
    
        # Actualizar el lote para incluir ahora la predicción y soltar el primer valor (primer time step)
        current_batch = np.append(current_batch[:, 1:], [[current_pred]])[np.newaxis]

**Figura con los 100 valores reales más recientes y las 20
predicciones:**

.. code:: ipython3

    plt.figure(figsize=(10, 6))
    plt.plot(
        range(1, len(df[-100:, 0]) + 1),
        df[-100:, 0],
        color="b",
        marker=".",
        linestyle="-",
        label="True",
    )
    plt.plot(
        range(len(df[-100:, 0]) + 1, len(df[-100:, 0]) + len(predictions) + 1),
        predictions,
        color="g",
        marker=".",
        linestyle="-",
        label="y_pred fuera de la muestra",
    )
    plt.legend();



.. image:: output_92_0.png

