Ejemplo regularización
----------------------

.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import warnings  # Para ignorar mensajes de advertencia
    
    warnings.filterwarnings("ignore")

Descargar datos desde Yahoo Finance:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    import yfinance as yf

.. code:: ipython3

    tickers = ["BTC-USD"]
    ohlc = yf.download(tickers, period="max")
    print(ohlc.tail())


.. parsed-literal::

    [*********************100%***********************]  1 of 1 completed
                        Open          High           Low         Close  \
    Date                                                                 
    2022-09-03  19969.718750  20037.009766  19698.355469  19832.087891   
    2022-09-04  19832.470703  19999.689453  19636.816406  19986.712891   
    2022-09-05  19988.789062  20031.160156  19673.046875  19812.371094   
    2022-09-06  19817.724609  20155.269531  18800.171875  18837.667969   
    2022-09-08  19309.482422  19372.404297  19275.042969  19276.115234   
    
                   Adj Close       Volume  
    Date                                   
    2022-09-03  19832.087891  23613051457  
    2022-09-04  19986.712891  25245861652  
    2022-09-05  19812.371094  28813460025  
    2022-09-06  18837.667969  43403978910  
    2022-09-08  19276.115234  34544746496  
    

.. code:: ipython3

    df = ohlc["Adj Close"].dropna(how="all")
    df.tail()




.. parsed-literal::

    Date
    2022-09-03    19832.087891
    2022-09-04    19986.712891
    2022-09-05    19812.371094
    2022-09-06    18837.667969
    2022-09-08    19276.115234
    Name: Adj Close, dtype: float64



.. code:: ipython3

    df.shape




.. parsed-literal::

    (2913,)



.. code:: ipython3

    df = np.array(df[:, np.newaxis])
    df.shape




.. parsed-literal::

    (2913, 1)



.. code:: ipython3

    plt.figure(figsize=(10, 6))
    plt.plot(df);



.. image:: output_8_0.png


Conjunto de train y test:
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    time_test = 200
    train = df[:len(df)-time_test]
    test = df[len(df)-time_test:]

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

.. code:: ipython3

    time_step = 3
    
    X_train, y_train = split_sequence(train, time_step)
    X_test, y_test = split_sequence(test, time_step)

Ajuste del modelo inicial:
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    from keras.models import Sequential
    from keras.layers import Dense
    import keras

.. code:: ipython3

    model = Sequential()
    model.add(Dense(200, activation="relu", input_shape=(time_step,)))
    model.add(Dense(200, activation="relu"))
    model.add(Dense(200, activation="relu"))
    model.add(Dense(1))
    model.compile(optimizer="adam", loss="mse")
    history = model.fit(
        X_train,
        y_train,
        validation_data=(X_test, y_test),
        epochs=200,
        batch_size=50,
        verbose=0
    )
    
    # Evaluación del desempeño:
    rmse = model.evaluate(X_test, y_test, verbose=0) ** 0.5
    print(rmse)
    plt.plot(range(1, len(history.epoch) + 1), history.history["loss"], label="Train")
    plt.plot(range(1, len(history.epoch) + 1), history.history["val_loss"], label="Test")
    plt.xlabel("epoch")
    plt.ylabel("Loss")
    plt.legend();


.. parsed-literal::

    1118.935934269697
    


.. image:: output_17_1.png


Early Stopping:
~~~~~~~~~~~~~~~

En el siguiente ejemplo el modelo se agrega una parada anticipada (early
stopping) si el modelo no mejora durante 20 epochs. En caso de no usar
este método, la red de entrenará por 200 epoch y podrá observar que el
modelo converge desde las primeras epochs.

Este método es útil para detener el entrenamiento y no esperar hasta que
ejecute la última epoch que indiquemos.

.. code:: ipython3

    keras.backend.clear_session()

.. code:: ipython3

    model = Sequential()
    model.add(Dense(200, activation="relu", input_shape=(time_step,)))
    model.add(Dense(200, activation="relu"))
    model.add(Dense(200, activation="relu"))
    model.add(Dense(1))
    model.compile(optimizer="adam", loss="mse")
    
    callbacks= keras.callbacks.EarlyStopping(   # Interrumpe el entrenamiento cuando se detiene la mejora.
        monitor="val_loss",                 # Supervisa el accuracy en la validación del modelo.
        patience=20,        # Interrumpe el entrenamiento cuando la precisión ha dejado de mejorar durante 10 epochs.
        restore_best_weights=True)
    
    history = model.fit(
        X_train,
        y_train,
        validation_data=(X_test, y_test),
        callbacks=callbacks,             # Early stopping
        epochs=100,
        batch_size=50,
        verbose=0
    )
    
    # Evaluación del desempeño:
    rmse = model.evaluate(X_test, y_test, verbose=0) ** 0.5
    print(rmse)
    plt.plot(range(1, len(history.epoch) + 1), history.history["loss"], label="Train")
    plt.plot(range(1, len(history.epoch) + 1), history.history["val_loss"], label="Test")
    plt.xlabel("epoch")
    plt.ylabel("Loss")
    plt.legend();


.. parsed-literal::

    1124.7939811361011
    


.. image:: output_22_1.png


Regularización L1:
~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    keras.backend.clear_session()

.. code:: ipython3

    model = Sequential()
    model.add(Dense(200, activation="relu", input_shape=(time_step,),
                   kernel_regularizer='l1'))                          # Regularización L1 primera capa oculta
    model.add(Dense(200, activation="relu", kernel_regularizer='l1'))  # Regularización L1 en segunda capa oculta
    model.add(Dense(200, activation="relu", kernel_regularizer='l1'))  # Regularización L1 en tercera capa oculta
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
    
    # Evaluación del desempeño:
    rmse = model.evaluate(X_test, y_test, verbose=0) ** 0.5
    print(rmse)
    plt.plot(range(1, len(history.epoch) + 1), history.history["loss"], label="Train")
    plt.plot(range(1, len(history.epoch) + 1), history.history["val_loss"], label="Test")
    plt.xlabel("epoch")
    plt.ylabel("Loss")
    plt.legend();


.. parsed-literal::

    1122.4477159315707
    


.. image:: output_25_1.png


Regularización L2:
~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    keras.backend.clear_session()

.. code:: ipython3

    model = Sequential()
    model.add(Dense(200, activation="relu", input_shape=(time_step,),
                   kernel_regularizer='l2'))                           # Regularización L2 primera capa oculta
    model.add(Dense(200, activation="relu", kernel_regularizer='l2'))  # Regularización L2 en segunda capa oculta
    model.add(Dense(200, activation="relu", kernel_regularizer='l2'))  # Regularización L2 en tercera capa oculta
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
    
    # Evaluación del desempeño:
    rmse = model.evaluate(X_test, y_test, verbose=0) ** 0.5
    print(rmse)
    plt.plot(range(1, len(history.epoch) + 1), history.history["loss"], label="Train")
    plt.plot(range(1, len(history.epoch) + 1), history.history["val_loss"], label="Test")
    plt.xlabel("epoch")
    plt.ylabel("Loss")
    plt.legend();


.. parsed-literal::

    1155.8512014961095
    


.. image:: output_28_1.png


Regularización L2 con Early Stopping:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    keras.backend.clear_session()

.. code:: ipython3

    model = Sequential()
    model.add(Dense(200, activation="relu", input_shape=(time_step,),
                   kernel_regularizer='l2'))         # Regularización L2 primera capa oculta
    model.add(Dense(200, activation="relu", kernel_regularizer='l2'))  # Regularización L2 en segunda capa oculta
    model.add(Dense(200, activation="relu", kernel_regularizer='l2'))  # Regularización L2 en tercera capa oculta
    model.add(Dense(1))
    model.compile(optimizer="adam", loss="mse")
    
    callbacks= keras.callbacks.EarlyStopping(  
        monitor="val_loss",                 
        patience=20,
        restore_best_weights=True)
    
    
    history = model.fit(
        X_train,
        y_train,
        validation_data=(X_test, y_test),
        callbacks=callbacks,
        epochs=500,                                  # 500 epochs
        batch_size=50,
        verbose=0
    )
    
    # Evaluación del desempeño:
    rmse = model.evaluate(X_test, y_test, verbose=0) ** 0.5
    print(rmse)
    plt.plot(range(1, len(history.epoch) + 1), history.history["loss"], label="Train")
    plt.plot(range(1, len(history.epoch) + 1), history.history["val_loss"], label="Test")
    plt.xlabel("epoch")
    plt.ylabel("Loss")
    plt.legend();


.. parsed-literal::

    1123.5660861738397
    


.. image:: output_31_1.png


Dropout:
~~~~~~~~

.. code:: ipython3

    from keras.layers import Dropout

.. code:: ipython3

    keras.backend.clear_session()

.. code:: ipython3

    model = Sequential()
    model.add(Dense(200, activation="relu", input_shape=(time_step,)))
    model.add(Dropout(0.2))              # Regularización Dropout en primera capa oculta
    model.add(Dense(200, activation="relu"))
    model.add(Dropout(0.2))              # Regularización Dropout en segunda capa oculta
    model.add(Dense(200, activation="relu"))
    model.add(Dropout(0.2))              # Regularización Dropout en tercera capa oculta
    model.add(Dense(1))
    model.compile(optimizer="adam", loss="mse")
    history = model.fit(
        X_train,
        y_train,
        validation_data=(X_test, y_test),
        epochs=100,                                  # 100 epochs
        batch_size=50,
        verbose=0
    )
    
    # Evaluación del desempeño:
    rmse = model.evaluate(X_test, y_test, verbose=0) ** 0.5
    print(rmse)
    plt.plot(range(1, len(history.epoch) + 1), history.history["loss"], label="Train")
    plt.plot(range(1, len(history.epoch) + 1), history.history["val_loss"], label="Test")
    plt.xlabel("epoch")
    plt.ylabel("Loss")
    plt.legend();


.. parsed-literal::

    3861.8776521272653
    


.. image:: output_35_1.png


Regularización Dropout con Early Stopping:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    keras.backend.clear_session()

.. code:: ipython3

    model = Sequential()
    model.add(Dense(200, activation="relu", ))
    model.add(Dropout(0.2))
    model.add(Dense(200, activation="relu", ))
    model.add(Dropout(0.2))
    model.add(Dense(200, activation="relu", ))
    model.add(Dropout(0.2))
    model.add(Dense(1))
    model.compile(optimizer="adam", loss="mse")
    
    callbacks= keras.callbacks.EarlyStopping(  
        monitor="val_loss",                 
        patience=20,
        restore_best_weights=True)
    
    history = model.fit(
        X_train,
        y_train,
        validation_data=(X_test, y_test),
        callbacks=callbacks,
        epochs=500,                                  # 500 epochs
        batch_size=50,
        verbose=0
    )
    
    # Evaluación del desempeño:
    rmse = model.evaluate(X_test, y_test, verbose=0) ** 0.5
    print(rmse)
    plt.plot(range(1, len(history.epoch) + 1), history.history["loss"], label="Train")
    plt.plot(range(1, len(history.epoch) + 1), history.history["val_loss"], label="Test")
    plt.xlabel("epoch")
    plt.ylabel("Loss")
    plt.legend();


.. parsed-literal::

    1552.5757630466862
    


.. image:: output_38_1.png


Dropout capa de entrada:
~~~~~~~~~~~~~~~~~~~~~~~~

La capa de entrada también puede tener Dropout:

.. code:: ipython3

    model = Sequential()
    model.add(Dropout(0.1, input_shape=(time_step,)))  # Capa de entrada con Droput
    model.add(Dense(200, activation="relu", ))         # Primera capa oculta
    model.add(Dropout(0.2))                            # Dropout primera capa oculta
