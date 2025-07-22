Comparación de modelos
----------------------

Se busca determinar la menor cantidad de variables regresoras porque la
varianza de la predicción :math:`\hat{y}` aumenta a medida que aumenta
la cantidad de regresoras. No hay un único método óptimo para
seleccionar las variables y es posible que cada uno indique variables
distintas para la regresión. Así que no se obtendrá una ecuación de
regresión óptima, sino que se tendrán varias igualmente buenas.

Selección de variables:
~~~~~~~~~~~~~~~~~~~~~~~

En la Regresión Lineal Múltiple tenemos :math:`k` cantidad de variables
regresoras o explicativas y se busca encontrar la ecuación óptima o
mejor a partir de subconjuntos de estas variables. Con la ordenada al
origen, :math:`\beta_0`, tenemos :math:`2^k` ecuaciones de todas las
combinaciones posibles y que se deben estimar y examinar. Si tenemos 3
variables explicativas, entonces tenemos 8 ecuaciones posibles de
regresión, con 5, serían 32 ecuaciones. Esto conlleva un alto costo
computacional; sin embargo, tenemos varios métodos para evaluar solo una
pequeña cantidad de modelos de regresión del subconjunto, donde se
agregan o eliminan regresoras una por una. Tenemos tres métodos:

1. Selección hacia adelante.

2. Selección hacia atrás.

3. Regresión por segmentos.

Estos métodos son iterativos porque en cada paso agregan o eliminan una
variable explicativa y evalúa el nuevo modelo de regresión.

**Selección hacia adelante (Forward):**

Se parte de una ecuación con solo la ordenada al origen,
:math:`\beta_0`, y se determina el subconjunto óptimo insertando
variables regresoras una por una. Es un proceso iterativo.

El primer modelo no tiene ninguna variable regresora y es el siguiente:

.. math::  \hat{y} = \beta_0 

En cada paso se agrega una variable explicativa al modelo si con el
nuevo modelo disminuye el AIC.

**Eliminación hace atrás (Backward):**

Comienza con un modelo que incluya todas las :math:`k` variables
regresoras y evalúa la significancia de todas las variables. Elimina las
variables no significativas. Después de eliminar variables, vuelve a
ajustar el modelo con las variables restantes y evalúa de nuevo la
significancia de las variables para volver a eliminar más variables no
significativas. Este proceso se detiene cuando todas las variables
explicativas son significativas.

La significancia de las variables se evalúa con el valor p.

También se puede usar el criterio de eliminar variables si con la
ausencia de la variable eliminada el AIC es menor.

**Regresión por segmentos (Stepwise):**

Este proceso es una combinación de los dos anteriores. Empieza como el
Forward, sin variables explicativas, en cada paso agrega una variable
con el criterio del AIC, pero evalúa la significancia de la nueva
variable, como en el método Backward.

Criterios de información:
~~~~~~~~~~~~~~~~~~~~~~~~~

Los criterios de información dan un equilibrio entre los modelos que
mejor se ajustan y la parsimonia del modelo. Las dos métricas más
comunes son el Criterio de Información de Akaike (AIC - Akaike’s
Information Criterion) y el Criterio de Información Bayesiano (BIC -
Bayesian Information Criterion)

.. math::  AIC = n \times ln \left( \frac{SSE}{n} \right) + 2(k+2) 

.. math::  BIC = n \times ln \left( \frac{SSE}{n} \right) + (k+2)(ln(n))  

Los modelos con AIC o BIC más pequeños indican un mejor ajuste.

Código en R:
~~~~~~~~~~~~

.. code:: r

    datos = read.csv("DatosCafe.csv", sep = ";", dec = ",", header = T)
    print(head(datos))


.. parsed-literal::

       Fecha PrecioInterno PrecioInternacional Producción Exportaciones     TRM
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

    regression <- lm(Exportaciones ~ Producción + PrecioInternacional + PrecioInterno + TRM + EUR, data = datos)
    summary(regression)



.. parsed-literal::

    
    Call:
    lm(formula = Exportaciones ~ Producción + PrecioInternacional + 
        PrecioInterno + TRM + EUR, data = datos)
    
    Residuals:
        Min      1Q  Median      3Q     Max 
    -507.57  -73.29   -2.66   74.68  400.44 
    
    Coefficients:
                          Estimate Std. Error t value Pr(>|t|)    
    (Intercept)          2.800e+02  1.172e+02   2.390   0.0176 *  
    Producción           5.806e-01  3.284e-02  17.681   <2e-16 ***
    PrecioInternacional -1.045e+00  6.248e-01  -1.673   0.0956 .  
    PrecioInterno        1.878e-04  1.311e-04   1.432   0.1533    
    TRM                 -3.049e-02  5.367e-02  -0.568   0.5704    
    EUR                  5.335e-02  2.725e-02   1.958   0.0513 .  
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    Residual standard error: 121.1 on 258 degrees of freedom
    Multiple R-squared:  0.7055,	Adjusted R-squared:  0.6998 
    F-statistic: 123.6 on 5 and 258 DF,  p-value: < 2.2e-16
    


**Selección de variables:**

Estos métodos de selección de variables pueden indicar ecuaciones de
regresión diferentes:

Se deben crear dos modelos:

1. Modelo vacío con solo el intercepto ``regression_full``:
   :math:`\hat{y}=\beta_0`.

2. Modelo completo con todas las variables explicativas
   ``regression_empt``:
   :math:`\hat{y}=\beta_0+\beta_1 x_1 +\beta_2 x_2 + ... + \beta_k x_k`

.. code:: r

    regression_full <- lm(Exportaciones ~ Producción + PrecioInternacional + PrecioInterno + TRM + EUR, data = datos)
    regression_empty <- lm(Exportaciones ~ 1, data = datos)

**Selección hacia adelante (Forward):**

Criterio de inclusión: variable con la que se disminuye el AIC.

Inicia con el modelo sin variables ``regression_empty`` y termina con el
modelo con todas las variables ``regression_full``.

.. code:: r

    regression_forward <- step(object = regression_empty,
                               scope = list(lower = regression_empty, upper = regression_full),
                               direction = "forward", trace = 1)


.. parsed-literal::

    Start:  AIC=2851.31
    Exportaciones ~ 1
    
                          Df Sum of Sq      RSS    AIC
    + Producción           1   8556536  4292540 2563.9
    + TRM                  1   3909237  8939840 2757.5
    + EUR                  1   3150223  9698854 2779.1
    + PrecioInterno        1    569792 12279285 2841.3
    + PrecioInternacional  1    411399 12437678 2844.7
    <none>                             12849076 2851.3
    
    Step:  AIC=2563.86
    Exportaciones ~ Producción
    
                          Df Sum of Sq     RSS    AIC
    + TRM                  1    433271 3859269 2537.8
    + EUR                  1    408532 3884008 2539.5
    + PrecioInterno        1    107039 4185501 2559.2
    <none>                             4292540 2563.9
    + PrecioInternacional  1      3278 4289262 2565.7
    
    Step:  AIC=2537.77
    Exportaciones ~ Producción + TRM
    
                          Df Sum of Sq     RSS    AIC
    <none>                             3859269 2537.8
    + EUR                  1   25953.5 3833316 2538.0
    + PrecioInternacional  1    1812.7 3857456 2539.7
    + PrecioInterno        1     138.5 3859131 2539.8
    

Se detiene cuando ya no agrega variables. Después de incluir la TRM, el
AIC es de 2537,8 y al analizar si se incluye EUR, el AIC tiene el mismo
valor, por tanto, la variable EUR no se incluye y este proceso se
detiene.

.. math::  \hat{y} = \beta_0 + \beta_1 \times Producción + \beta_2 \times TRM 

.. code:: r

    summary(regression_forward)



.. parsed-literal::

    
    Call:
    lm(formula = Exportaciones ~ Producción + TRM, data = datos)
    
    Residuals:
        Min      1Q  Median      3Q     Max 
    -516.84  -73.36  -10.09   76.14  388.09 
    
    Coefficients:
                 Estimate Std. Error t value Pr(>|t|)    
    (Intercept) 120.22988   35.39162   3.397 0.000787 ***
    Producción    0.59391    0.03204  18.536  < 2e-16 ***
    TRM           0.07806    0.01442   5.413  1.4e-07 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    Residual standard error: 121.6 on 261 degrees of freedom
    Multiple R-squared:  0.6996,	Adjusted R-squared:  0.6973 
    F-statistic:   304 on 2 and 261 DF,  p-value: < 2.2e-16
    


**Eliminación hace atrás (Backward):**

Criterio de exclusión: disminución del AIC al eliminar la variable.

Inicial con el modelo completo ``regression_full`` y termina en el
modelo vacío ``regression_empty``.

.. code:: r

    regression_backward <- step(object = regression_full, 
                                scope = list(lower = regression_empty, upper = regression_full),
                                direction = "backward", trace = 1)


.. parsed-literal::

    Start:  AIC=2538.54
    Exportaciones ~ Producción + PrecioInternacional + PrecioInterno + 
        TRM + EUR
    
                          Df Sum of Sq     RSS    AIC
    - TRM                  1      4735 3788321 2536.9
    <none>                             3783586 2538.5
    - PrecioInterno        1     30085 3813671 2538.6
    - PrecioInternacional  1     41039 3824625 2539.4
    - EUR                  1     56227 3839813 2540.4
    - Producción           1   4584682 8368268 2746.1
    
    Step:  AIC=2536.87
    Exportaciones ~ Producción + PrecioInternacional + PrecioInterno + 
        EUR
    
                          Df Sum of Sq     RSS    AIC
    <none>                             3788321 2536.9
    - PrecioInterno        1     45190 3833511 2538.0
    - EUR                  1     61244 3849565 2539.1
    - PrecioInternacional  1     84721 3873042 2540.7
    - Producción           1   4603882 8392203 2744.8
    

No elimina la variable EUR porque el AIC sigue siendo el mismo.

.. math::  \hat{y} = \beta_0 + \beta_1 \times Producción + \beta_2 \times PrecioInternacional + \beta_3 \times PrecioInterno + \beta_4 \times EUR 

.. code:: r

    summary(regression_backward)



.. parsed-literal::

    
    Call:
    lm(formula = Exportaciones ~ Producción + PrecioInternacional + 
        PrecioInterno + EUR, data = datos)
    
    Residuals:
        Min      1Q  Median      3Q     Max 
    -510.51  -72.10   -4.75   77.68  398.79 
    
    Coefficients:
                          Estimate Std. Error t value Pr(>|t|)    
    (Intercept)          2.257e+02  6.764e+01   3.337 0.000973 ***
    Producción           5.813e-01  3.277e-02  17.741  < 2e-16 ***
    PrecioInternacional -7.356e-01  3.057e-01  -2.407 0.016798 *  
    PrecioInterno        1.253e-04  7.128e-05   1.758 0.079979 .  
    EUR                  4.379e-02  2.140e-02   2.046 0.041742 *  
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    Residual standard error: 120.9 on 259 degrees of freedom
    Multiple R-squared:  0.7052,	Adjusted R-squared:  0.7006 
    F-statistic: 154.9 on 4 and 259 DF,  p-value: < 2.2e-16
    


**Regresión por segmentos (Stepwise):**

Agrega variables como el método Forward aplicando el criterio del menor
AIC, pero si la variable agregada no es significativa, la elimina y
repite el paso (como en el método Backward).

Inicia con el modelo sin variables ``regression_empty`` porque empieza
como el Forward.

.. code:: r

    regression_stepwise <- step(object = regression_empty,
                                scope = list(lower = regression_empty, upper = regression_full),
                                direction = "both", trace = 1)


.. parsed-literal::

    Start:  AIC=2851.31
    Exportaciones ~ 1
    
                          Df Sum of Sq      RSS    AIC
    + Producción           1   8556536  4292540 2563.9
    + TRM                  1   3909237  8939840 2757.5
    + EUR                  1   3150223  9698854 2779.1
    + PrecioInterno        1    569792 12279285 2841.3
    + PrecioInternacional  1    411399 12437678 2844.7
    <none>                             12849076 2851.3
    
    Step:  AIC=2563.86
    Exportaciones ~ Producción
    
                          Df Sum of Sq      RSS    AIC
    + TRM                  1    433271  3859269 2537.8
    + EUR                  1    408532  3884008 2539.5
    + PrecioInterno        1    107039  4185501 2559.2
    <none>                              4292540 2563.9
    + PrecioInternacional  1      3278  4289262 2565.7
    - Producción           1   8556536 12849076 2851.3
    
    Step:  AIC=2537.77
    Exportaciones ~ Producción + TRM
    
                          Df Sum of Sq     RSS    AIC
    <none>                             3859269 2537.8
    + EUR                  1     25954 3833316 2538.0
    + PrecioInternacional  1      1813 3857456 2539.7
    + PrecioInterno        1       139 3859131 2539.8
    - TRM                  1    433271 4292540 2563.9
    - Producción           1   5080571 8939840 2757.5
    

.. math::  \hat{y} = \beta_0 + \beta_1 \times Producción + \beta_2 \times TRM + \beta_3 \times EUR  

.. code:: r

    summary(regression_stepwise)



.. parsed-literal::

    
    Call:
    lm(formula = Exportaciones ~ Producción + TRM, data = datos)
    
    Residuals:
        Min      1Q  Median      3Q     Max 
    -516.84  -73.36  -10.09   76.14  388.09 
    
    Coefficients:
                 Estimate Std. Error t value Pr(>|t|)    
    (Intercept) 120.22988   35.39162   3.397 0.000787 ***
    Producción    0.59391    0.03204  18.536  < 2e-16 ***
    TRM           0.07806    0.01442   5.413  1.4e-07 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    Residual standard error: 121.6 on 261 degrees of freedom
    Multiple R-squared:  0.6996,	Adjusted R-squared:  0.6973 
    F-statistic:   304 on 2 and 261 DF,  p-value: < 2.2e-16
    


Se puede hacer la prueba que con el modelo de regresión con las
variables Producción, TRM y EUR, la variable EUR no es significativa.

.. code:: r

    summary(lm(Exportaciones ~ Producción + TRM + EUR, data = datos))



.. parsed-literal::

    
    Call:
    lm(formula = Exportaciones ~ Producción + TRM + EUR, data = datos)
    
    Residuals:
        Min      1Q  Median      3Q     Max 
    -516.96  -75.78   -2.17   76.98  410.90 
    
    Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
    (Intercept) 99.93981   38.50711   2.595  0.00999 ** 
    Producción   0.59460    0.03200  18.582  < 2e-16 ***
    TRM          0.04881    0.02633   1.854  0.06483 .  
    EUR          0.03102    0.02338   1.327  0.18575    
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    Residual standard error: 121.4 on 260 degrees of freedom
    Multiple R-squared:  0.7017,	Adjusted R-squared:  0.6982 
    F-statistic: 203.8 on 3 and 260 DF,  p-value: < 2.2e-16
    

