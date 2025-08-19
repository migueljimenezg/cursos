Ejercicios volatilidades dinámicas
----------------------------------

Calcular las volatilidades diarias por los tres métodos para las
acciones GOOG, DIS y HPE.

Fechas: desde el 30 de mayo de 2018 hasta 29 de mayo de 2020. Se
descargarán 504 precios de cierre ajustados diarios por cada acción.

Utilizar lambda igual a 0,94.

Utilizar código para descargar los precios.

Analizar los resultados.

1. Gráfico de precios
~~~~~~~~~~~~~~~~~~~~~

.. figure:: FiguraPReciosEjerciciosVol.jpg
   :alt: 1

   1

2. Gráfico de los rendimientos
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: FiguraRendimientosEjerciciosVol.jpg
   :alt: 2

   2

3. Volatilidad histórica de cada acción
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  GOOG: 0.02008668

-  DIS: 0.02141612

-  HPE: 0.02631703

4. Volatilidad EWMA
~~~~~~~~~~~~~~~~~~~

-  GOOG: 0.02292124

-  DIS: 0.03454477

-  HPE: 0.04752601

5. Volatilidad GARCH(1,1)
~~~~~~~~~~~~~~~~~~~~~~~~~

-  GOOG: 0.01536828

-  DIS: 0.02871047

-  HPE: 0.04484489

6. Análisis
~~~~~~~~~~~

Realizar un análisis comparativo de los resultados obtenidos con los
tres métodos de volatilidad (volatilidad histórica, EWMA y GARCH).
