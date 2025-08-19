Taller RNN
----------

Descargar de Yahoo Finance una serie de tiempo con frecuencia diaria o
semanal. Realizar un ajuste con RNN, LSTM, GRU y Bidereccional-LSTM.

Para cada modelo realizar un proceso de optimización de hiperparámetros.

Si obtiene un modelo con overfitting, aplicar algún método de
regularización.

Con el mejor modelo pronosticar por fuera de la muestra.

Nota: para descargar precios semanales agregar el siguiente argumento en
``yf.download``: ``interval = "1wk"``
