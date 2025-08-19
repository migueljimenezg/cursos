Intervalos de confianza - CI
----------------------------

Con los intervalos de confianza se define un rango de valores con un a
probabilidad.

Los intervalos de confianza para los parámetros del modelo de regresión
se calculan de la siguiente manera:

.. math::  \hat{\beta_0} \pm t_{\alpha/2, n – 2} \times SE(\hat{\beta_0}) 

.. math::  \hat{\beta_1} \pm t_{\alpha/2, n – 2} \times SE(\hat{\beta_1}) 

En R lo podemos hacer así:

``confint(regression, level = 0.95)``

Para diferentes probabilidades se cambia el valor de ``level``. En este
ejemplo se hará con una probabilidad del 95%. Se debe hallar el límite
inferior al 2,5% y el límite superior al 97,5%.

Código en R:
~~~~~~~~~~~~

.. code:: r

    datos = read.csv("DatosCafe.csv", sep = ";", dec = ",", header = T)
    print(head(datos))


.. parsed-literal::

           X PrecioInterno PrecioInternacional Producción Exportaciones     TRM
    1 ene-00        371375              130.12        658           517 1923.57
    2 feb-00        354297              124.72        740           642 1950.64
    3 mar-00        360016              119.51        592           404 1956.25
    4 abr-00        347538              112.67       1055           731 1986.77
    5 may-00        353750              110.31       1114           615 2055.69
    6 jun-00        341688              100.30       1092           869 2120.17
         EUR
    1 1916.0
    2 1878.5
    3 1875.0
    4 1832.0
    5 1971.5
    6 2053.5
    

.. code:: r

    X = datos$Producción
    y = datos$Exportaciones

**Ajuste del modelo:**

.. code:: r

    regression <- lm(Exportaciones ~ Producción, data = datos)
    regression



.. parsed-literal::

    
    Call:
    lm(formula = Exportaciones ~ Producción, data = datos)
    
    Coefficients:
    (Intercept)   Producción  
       235.3538       0.6769  
    


:math:`\hat{\beta_0}`:

.. code:: r

    beta_0 = as.numeric(regression$coefficients[1])
    beta_0



.. raw:: html

    235.353837174437


:math:`\hat{\beta_1}`:

.. code:: r

    beta_1 = as.numeric(regression$coefficients[2])
    beta_1



.. raw:: html

    0.676867843609397


.. code:: r

    CI = confint(regression, level = 0.95)
    print(CI)


.. parsed-literal::

                      2.5 %      97.5 %
    (Intercept) 176.7200569 293.9876174
    Producción    0.6185475   0.7351882
    

.. code:: r

    CI[1]



.. raw:: html

    176.720056904838


.. code:: r

    CI[2]



.. raw:: html

    0.618547467123636


.. code:: r

    par(bg = "#f7f7f7") 
    plot(X, y,
        xlab = "Producción",
        ylab = "Exportaciones",
        main = "Ajuste de regresión con CI al 95%")
    abline(beta_0, beta_1, col = "darkred", lwd = 5)
    abline(CI[1], CI[2], col = "blue", lwd = 3)   # Límite inferior
    abline(CI[3], CI[4], col = "darkblue", lwd = 3)   # Límite superior
    legend("topleft", c("Límite superior", "Regresión", "Límite inferior"), 
           lwd = c(3, 5, 3), 
           col = c("darkblue", "darkred", "blue"),
           bty = "n")



.. image:: output_14_0.png
   :width: 420px
   :height: 420px

