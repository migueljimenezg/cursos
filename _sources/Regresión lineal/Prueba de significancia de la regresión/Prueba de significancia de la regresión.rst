Prueba de significancia de la regresión
---------------------------------------

Prueba de significancia de la regresión con el estadístico :math:`t`:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La significancia de la regresión se relaciona en determinar si la
pendiente de la línea de regresión es significativa o no. La hipótesis
nula :math:`(H_0)` es que la pendiente es igual a cero, es decir, que la
pendiente no es significativa y no hay relación lineal entre :math:`X` y
:math:`y` y que :math:`X` tiene muy poco valor para explicar la
variación de :math:`y`, en cambio, con la hipótesis alternativa
:math:`(H_1)`, se evalúa si la pendiente es diferente de cero, entonces,
si existe una relación lineal entre :math:`X` y :math:`y`.

**Pruebas de hipótesis:**

.. math::  H_0: \beta_1 = 0 

.. math::  H_1: \beta_1 \neq 0 

No rechazar :math:`H_0` implica que la mejor estimación es
:math:`\hat{y} = \overline{y}` **(Figura a)** o que la relación no es
lineal **(Figura b).**

.. figure:: significancia1.png
   :alt: Significancia

   Significancia

Fuente: Montgomery, Peck y Vining, 2001.

Al rechazar :math:`H_0` implica que :math:`X` sí pude explicar la
variabilidad de :math:`y`. Si el modelo adecuado es como la **Figura
a**; sin embargo, es posible que, aunque el modelo es significativo se
podría tener mejores resultados con términos polinomiales en :math:`X`
como se muestra en la **Figura b.**

.. figure:: significancia2.png
   :alt: Linealidad

   Linealidad

Fuente: Montgomery, Peck y Vining, 2001.

Se usa el estadístico :math:`t` para determinar la significancia de la
regresión así:

.. math::  t_0 =  \frac{\hat{\beta_1}}{SE(\hat{\beta_1})} 

Donde,

:math:`SE(\hat{\beta_1})`: Es el error estándar de
:math:`\hat{\beta_1}`.

.. math::  SE(\hat{\beta_1}) = \sqrt{\frac{\sigma^2}{\sum_{}(X_i-\overline{X_i})^2}} 

Donde :math:`\sigma^2` es el **cuadrado medio residual**, es un
estimador insesgado para la varianza de la regresión. :math:`\sigma` es
el **error estándar de la regresión.**

.. math::  \sigma^2 = \frac{\sum_{}(y_i-\hat{y_i})^2}{n-2} = \frac{\sum_{} \hat{\varepsilon_i}^2}{n-2} 

:math:`n-2`: son los grados de libertad del modelo ``df = n - 2``. El 2
es porque se estiman dos parámetros.

Recuerde que:
:math:`SSE = \sum_{} \hat{\varepsilon_i}^2 = \sum_{}(y_i-\hat{y_i})^2`,
entonces:

.. math::  \sigma^2 = \frac{SSE}{n-2} 

Así que:

.. math::  SE(\hat{\beta_1}) = \sqrt{\frac{\frac{SSE}{n-2}}{\sum_{}(X_i-\overline{X_i})^2}} 

Se rechaza :math:`H_0` cuando:

.. math:: |t_0| > t_{\alpha/2, n – 2} 

Donde,

:math:`t_{\alpha/2, n – 2}`: es el valor crítico de :math:`t`.

El :math:`t` crítico se calcula en R así:
``qt(p = (1 - alfa) + alfa/2, df = n - 2)``

**Ejemplo:** para un :math:`\alpha = 0,05` y 264 datos ``n = 264``, el
:math:`t` crítico es: ``1.96905971525654``

``t_critico = qt(p = 0.95 + 0.05/2, df = n - 2)``

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


**Cantidad de datos** :math:`n`:

.. code:: r

    n = length(X)
    n



.. raw:: html

    264


**Residuales:**

.. code:: r

    residuales = regression$residuals
    head(residuales)



.. raw:: html

    <style>
    .dl-inline {width: auto; margin:0; padding: 0}
    .dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}
    .dl-inline>dt::after {content: ":\0020"; padding-right: .5ex}
    .dl-inline>dt:not(:first-of-type) {padding-left: .5ex}
    </style><dl class=dl-inline><dt>1</dt><dd>-163.732878269429</dd><dt>2</dt><dd>-94.236041445392</dd><dt>3</dt><dd>-232.059600591201</dd><dt>4</dt><dd>-218.449412182351</dd><dt>5</dt><dd>-374.384614955306</dd><dt>6</dt><dd>-105.493522395899</dd></dl>
    


:math:`SE(\hat{\beta_1})`:

.. math::  SE(\hat{\beta_1}) = \sqrt{\frac{\frac{SEE}{n-2}}{\sum_{}(X_i-\overline{X_i})^2}} 

.. code:: r

    sqrt(sum(residuales^2)/(n-2)/sum((X-mean(X))^2))



.. raw:: html

    0.0296183889365504


Estadístico :math:`t_0` para :math:`\hat{\beta_1}`:

.. math::  t_0 =  \frac{\hat{\beta_1}}{SE(\hat{\beta_1})} 

.. code:: r

    t_0 = beta_1/sqrt(sum(residuales^2)/(n-2)/sum((X-mean(X))^2))
    t_0



.. raw:: html

    22.8529595265769


:math:`t` crítico:

.. code:: r

    t_critico = qt(p = 0.95 + 0.05/2, df = n - 2)
    t_critico



.. raw:: html

    1.96905971525654


**Prueba de hipótesis:**

.. math:: |t_0| > t_{\alpha/2, n – 2} 

.. math::  |22,85| > 1,97 

.. code:: r

    if(abs(t_0) > t_critico) {"Se acepta"} else {"Se rechaza"}



.. raw:: html

    'Se acepta'


En el ``summary()`` aparecen los errores estándar **SE** de valor del
:math:`\beta_0` y :math:`\beta_1` y los estadísticos :math:`t` de cada
uno.

.. figure:: tstatistics.png
   :alt: Estadístico

   Estadístico

.. code:: r

    summary(regression)



.. parsed-literal::

    
    Call:
    lm(formula = Exportaciones ~ Producción, data = datos)
    
    Residuals:
        Min      1Q  Median      3Q     Max 
    -492.02  -85.38   -9.89   82.85  407.53 
    
    Coefficients:
                 Estimate Std. Error t value Pr(>|t|)    
    (Intercept) 235.35384   29.77755   7.904 7.54e-14 ***
    Producción    0.67687    0.02962  22.853  < 2e-16 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    Residual standard error: 128 on 262 degrees of freedom
    Multiple R-squared:  0.6659,	Adjusted R-squared:  0.6647 
    F-statistic: 522.3 on 1 and 262 DF,  p-value: < 2.2e-16
    


Prueba de significancia de la regresión con el :math:`valor-p`:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Otra forma para determinar la significancia del modelo es usando el
:math:`valor- p`. El ``summary()`` ya lo tiene calculado y por medio de
asteriscos indica si los parámetros son significativos o no, entre más
asteriscos es más significativo

.. figure:: pvalue.png
   :alt: p-value

   p-value
