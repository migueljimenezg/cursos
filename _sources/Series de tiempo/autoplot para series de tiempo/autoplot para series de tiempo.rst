autoplot para series de tiempo
------------------------------

.. code:: r

    estacional <- read.csv("Estacionalidad.csv", sep = ",", dec = ".", header = T)

La función ``autoplot()`` de la librería ``ggbio`` trabaja bajo
``ggplot2`` y nos permite realizar mejores gráficos para la modelación
de series de tiempo.

Primero debemos convertir el objeto de la serie de tiempo a un objeto
``ts`` para que se pueda cargar en ``autoplot()``. Esto es muy común en
la modelación de las series de tiempo, antes de aplicar los modelos,
convertir los datos en ``ts``.

La función ``ts`` es de la librería ``stats``.

.. code:: r

    timeserie <- ts(estacional[,1])

**Gráfico de la serie de tiempo original:**

El gráfico de la serie de tiempo se puede hacer solo con
``autoplot(timeserie)``.

.. code:: r

    library(forecast)


.. parsed-literal::

    Warning message:
    "package 'forecast' was built under R version 4.1.3"
    Registered S3 method overwritten by 'quantmod':
      method            from
      as.zoo.data.frame zoo 
    
    

.. code:: r

    library(ggplot2)

.. code:: r

    autoplot(timeserie)+
            theme_minimal() +
            labs(title = "Serie de tiempo 1", x = "Tiempo", y = "y")+
            theme(axis.text = element_text(size = 14, family = 'mono', color = 'black'), 
                  axis.title.x = element_text(face = "bold", colour = "black", size = rel(1)),
                  axis.title.y = element_text(face = "bold", colour = "black", size = rel(1), angle = 0,vjust = 0.5))



.. image:: output_9_0.png
   :width: 420px
   :height: 420px


**Gráfico de la serie de tiempo con el pronóstico:**

Se realiza el pronóstico con la función ``forecast()``.

Para graficar solo es con ``autoplot(forecast)``. La función identifica
automáticamente la serie de tiempo original y el pronóstico.

.. code:: r

    ar <- arima(estacional[,1], order = c(1, 0, 0))
    forecast <- forecast(ar, h = 5, level = 99)

.. code:: r

    autoplot(forecast)+
            theme_minimal() +
            labs(title = "Serie de tiempo 1", x = "Tiempo", y = "y")+
            theme(axis.text = element_text(size = 14, family = 'mono', color = 'black'), 
                  axis.title.x = element_text(face = "bold", colour = "black", size = rel(1)),
                  axis.title.y = element_text(face = "bold", colour = "black", size = rel(1), angle = 0,vjust = 0.5))



.. image:: output_13_0.png
   :width: 420px
   :height: 420px


En forma alternativa se puede utilizar ``geom_forecast(h = )`` y
automáticamente se calculan las predicciones.

.. code:: r

    autoplot(timeserie) + geom_forecast(h = 5)+
            theme_minimal() +
            labs(title = "Serie de tiempo 1", x = "Tiempo", y = "y")+
            theme(axis.text = element_text(size = 14, family = 'mono', color = 'black'), 
                  axis.title.x = element_text(face = "bold", colour = "black", size = rel(1)),
                  axis.title.y = element_text(face = "bold", colour = "black", size = rel(1), angle = 0,vjust = 0.5))



.. image:: output_15_0.png
   :width: 420px
   :height: 420px


**Gráfico serie de tiempo, ACF y PACF:**

.. code:: r

    ggtsdisplay(timeserie)



.. image:: output_17_0.png
   :width: 420px
   :height: 420px


**Gráfico de la ACF:**

.. code:: r

    ggAcf(timeserie)+
            theme_minimal() +
            labs(title = "Serie de tiempo 1", x = "Tiempo", y = "y")+
            theme(axis.text = element_text(size = 14, family = 'mono', color = 'black'), 
                  axis.title.x = element_text(face = "bold", colour = "black", size = rel(1)),
                  axis.title.y = element_text(face = "bold", colour = "black", size = rel(1), angle = 0,vjust = 0.5))



.. image:: output_19_0.png
   :width: 420px
   :height: 420px


**Gráfico de la PACF:**

.. code:: r

    ggPacf(timeserie)+
            theme_minimal() +
            labs(title = "Serie de tiempo 1", x = "Tiempo", y = "y")+
            theme(axis.text = element_text(size = 14, family = 'mono', color = 'black'), 
                  axis.title.x = element_text(face = "bold", colour = "black", size = rel(1)),
                  axis.title.y = element_text(face = "bold", colour = "black", size = rel(1), angle = 0,vjust = 0.5))



.. image:: output_21_0.png
   :width: 420px
   :height: 420px

