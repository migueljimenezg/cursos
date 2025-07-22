Medidas de desempeño RLS
------------------------

Las siguientes métricas se relacionan con los residuales y entre más
bajo la métrica mejor porque error sería bajo. En algunos casos, como en
los métodos de *Machine Learning* al resultado del error se le llama
pérdida *(loss)* o costo *(cost)*.

• Máximo Error.

• Error Medio Absoluto (MSE).

• Error Porcentual Absoluto Medio (MAPE).

Por su parte, el coeficiente de determinación :math:`(R^2)` es una
medida de cuánto son explicados los datos con el modelo de regresión
ajustado. Entre más cercano a uno es mejor.

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


**Cálculo de los residuales:**

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
    


Métricas para evaluar el desempeño del modelo:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Error Máximo:**

De los residuos se selecciona el mayor.

.. math::  MaxError = max(|y_i - \hat{y_i}|) = max(|\hat\varepsilon|) 

Entre más bajo el resultado, mejor.

.. code:: r

    max_error = max(residuales)
    max_error



.. raw:: html

    407.531783011865


**Error Medio Absoluto - MSE:**

En inglés *Mean Squared Error* - MSE. Es el promedio de los residuos con
los cuales se aplicó OLS.

.. math::  MSE = \frac{1}{n} \sum (y_i - \hat{y_i})^2 =\frac{1}{n} \sum \hat\varepsilon^2 

El MSE es últil para comparar diferentes modelos.

Esta métrica no es sensible a los *outliers*.

Entre más bajo el resultado, mejor.

.. code:: r

    MSE = mean(residuales^2)
    MSE



.. raw:: html

    16259.6220989243


**Error Porcentual Absoluto Medio - MAPE:**

En inglés *Mean Absolute Percentage Error* - MAPE.

.. math::  MAPE = \frac{1}{n} \sum \frac{|y_i - \hat{y_i}|}{|y_i|} 

Entre más bajo el resultado, mejor.

.. code:: r

    MAPE = mean(abs(residuales/y))
    MAPE



.. raw:: html

    0.123516747782105


**Coeficiente de Determinación** :math:`R^2`:

Es una versión estandarizada del MSE. El :math:`R^2` es la fracción de
la varianza de :math:`y` que es capturada por el modelo, es decir,
cuánto de la varianza de :math:`y` es explicada por la variable
:math:`X`. El resultado está entre cero y uno, pero en pocos casos puede
dar negativo particularmente cuando se trabaja con conjuntos de prueba
*(test)*.

.. math::  R^2 = 1 - \frac{SSE}{SST} 

Donde,

:math:`SSE = \sum_{} \hat{\varepsilon_i}^2 = \sum_{}(y_i-\hat{y_i})^2`

:math:`SST = \sum_{}(y_i-\overline{y_i})^2`. Note que se utiliza
:math:`\overline{y_i}` en lugar de :math:`\hat{y_i}`.

:math:`SST = \sigma_y^2`

Entonces,

.. math::  R^2 = 1 - \frac{MSE}{\sigma_y^2} 

Entre más cercano a uno el resultado, mejor.

Con el Coeficiente de Determinación :math:`R^2` se analiza lo siguiente:

:math:`SST` es una medida de la variabilidad de :math:`y` sin considerar
la variable regresora :math:`X` y :math:`SSE` es una medida de la
variabilidad de :math:`y` considerando :math:`X`. Entonces, entre mayor
sea :math:`SSE` que :math:`SST` el modelo es mejor porque se estaría
indicando que la mayor parte de la variabilidad de :math:`y` se está
explicando con el modelo de regresión. Como :math:`0<=SSE<=SST`,
entonces :math:`0<=R^2<=1`.

En otras la palabras, el :math:`R^2` hace una comparación entre modelar
:math:`y` con una línea recta igual a :math:`\overline{y}` que su
pendiente es cero o con una línea recta de la forma
:math:`\hat{y_i} = \hat{\beta_0}+\hat{\beta_1}X_i`

.. code:: r

    R_2 = 1 - mean(residuales^2)/var(y)
    R_2



.. raw:: html

    0.667191592660391


En el ``summary()`` aparece calculado el :math:`R^2`.

.. figure:: r2.png
   :alt: R2

   R2

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
    

