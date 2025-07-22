Regresión Logística en R
------------------------

.. code:: r

    datos = read.csv("Social_Network_Ads.csv", sep = ",", dec = ".", header = T)
    print(head(datos))


.. parsed-literal::

       User.ID Gender Age EstimatedSalary Purchased
    1 15624510   Male  19           19000         0
    2 15810944   Male  35           20000         0
    3 15668575 Female  26           43000         0
    4 15603246 Female  27           57000         0
    5 15804002   Male  19           76000         0
    6 15728773   Male  27           58000         0
    

.. code:: r

    str(datos)


.. parsed-literal::

    'data.frame':	400 obs. of  5 variables:
     $ User.ID        : int  15624510 15810944 15668575 15603246 15804002 15728773 15598044 15694829 15600575 15727311 ...
     $ Gender         : chr  "Male" "Male" "Female" "Female" ...
     $ Age            : int  19 35 26 27 19 27 27 32 25 35 ...
     $ EstimatedSalary: int  19000 20000 43000 57000 76000 58000 84000 150000 33000 65000 ...
     $ Purchased      : int  0 0 0 0 0 0 0 1 0 0 ...
    

**Variables:**

.. code:: r

    df <- datos[,c("Gender", "Age", "EstimatedSalary", "Purchased")]
    print(head(df))


.. parsed-literal::

      Gender Age EstimatedSalary Purchased
    1   Male  19           19000         0
    2   Male  35           20000         0
    3 Female  26           43000         0
    4 Female  27           57000         0
    5   Male  19           76000         0
    6   Male  27           58000         0
    

.. code:: r

    dim(df)



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>400</li><li>4</li></ol>
    


**Variable y:**

.. code:: r

    print(table(df[,c("Purchased")]))


.. parsed-literal::

    
      0   1 
    257 143 
    

.. code:: r

    print(table(df[,c("Purchased")])/nrow(df))


.. parsed-literal::

    
         0      1 
    0.6425 0.3575 
    

.. code:: r

    library(ggplot2)

.. code:: r

    ggplot(data = df) + geom_bar(aes(y = Purchased))



.. image:: output_10_0.png
   :width: 420px
   :height: 420px


**Variable categórica:**

.. code:: r

    unique(df$Gender)



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>'Male'</li><li>'Female'</li></ol>
    


.. code:: r

    df$Gender <- factor(df$Gender,
                        levels = c(unique(df$Gender)),
                        labels = c(1,0))
    print(head(df))


.. parsed-literal::

      Gender Age EstimatedSalary Purchased
    1      1  19           19000         0
    2      1  35           20000         0
    3      0  26           43000         0
    4      0  27           57000         0
    5      1  19           76000         0
    6      1  27           58000         0
    

Ajuste modelo simple:
~~~~~~~~~~~~~~~~~~~~~

.. math::   p  = \frac{1}{1+exp \left[- \left(\beta_0+\beta_1 \times Edad \right)\right]} 

.. code:: r

    logistic_simple <- glm(Purchased ~ Age, data = df, family = binomial)
    logistic_simple



.. parsed-literal::

    
    Call:  glm(formula = Purchased ~ Age, family = binomial, data = df)
    
    Coefficients:
    (Intercept)          Age  
        -8.0441       0.1889  
    
    Degrees of Freedom: 399 Total (i.e. Null);  398 Residual
    Null Deviance:	    521.6 
    Residual Deviance: 336.3 	AIC: 340.3


.. code:: r

    print(head(logistic_simple$fitted.values))


.. parsed-literal::

             1          2          3          4          5          6 
    0.01149707 0.19295760 0.04182836 0.05009205 0.01149707 0.05009205 
    

.. code:: r

    print(min(logistic_simple$fitted.values))
    
    print(max(logistic_simple$fitted.values))


.. parsed-literal::

    [1] 0.009536473
    [1] 0.9641822
    

.. code:: r

    ggplot() + geom_histogram(aes(x = logistic_simple$fitted.values), binwidth = 0.01)+
            scale_x_continuous(labels = scales::percent)+
            labs(x = expression(p), y = "Número de observaciones")+
            theme_minimal()



.. image:: output_19_0.png
   :width: 420px
   :height: 420px


.. code:: r

    summary(logistic_simple)



.. parsed-literal::

    
    Call:
    glm(formula = Purchased ~ Age, family = binomial, data = df)
    
    Deviance Residuals: 
        Min       1Q   Median       3Q      Max  
    -2.5091  -0.6548  -0.2923   0.5706   2.4470  
    
    Coefficients:
                Estimate Std. Error z value Pr(>|z|)    
    (Intercept) -8.04414    0.78417 -10.258   <2e-16 ***
    Age          0.18895    0.01915   9.866   <2e-16 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    (Dispersion parameter for binomial family taken to be 1)
    
        Null deviance: 521.57  on 399  degrees of freedom
    Residual deviance: 336.26  on 398  degrees of freedom
    AIC: 340.26
    
    Number of Fisher Scoring iterations: 5
    


**Coeficientes:**

.. code:: r

    coef <- logistic_simple$coefficients
    print(coef)


.. parsed-literal::

    (Intercept)         Age 
     -8.0441425   0.1889496 
    

.. math::  exp \left( coeficientes \right) = \frac{p }{1-p } = oddsRatio 

.. code:: r

    OR <- exp(coef)  # Odds Ratio
    print(OR)


.. parsed-literal::

     (Intercept)          Age 
    0.0003209765 1.2079800978 
    

Por cada año de más, la probabilidad de comprar aumenta un 21%
aproximadamente.

**Grados de libertad:**

.. code:: r

    gl <- logistic_simple$df.null - logistic_simple$df.residual
    print(gl)


.. parsed-literal::

    [1] 1
    

**Diferencia de las desviaciones:**

.. code:: r

    dif_residuos <- logistic_simple$null.deviance - logistic_simple$deviance
    print(dif_residuos)


.. parsed-literal::

    [1] 185.3117
    

**Valor p para bondad de ajuste:**

.. code:: r

    p_value <- pchisq(q = dif_residuos, df = gl, lower.tail = FALSE)
    print(p_value)


.. parsed-literal::

    [1] 3.3555e-42
    

Se rechaza la hipótesis nula, entonces el modelo es significativo a un
:math:`\alpha = 0,05`.

**Error estándar:**

.. math::  SE(\hat{\beta_j}) 

.. code:: r

    SE <- sqrt(diag(vcov(logistic_simple)))[2]
    print(SE)


.. parsed-literal::

           Age 
    0.01915181 
    

**Estadístico z:**

.. math::  zScore = \frac{\hat{\beta_j}}{SE(\hat{\beta_j})}  

.. code:: r

    zscore <- coef[2]/SE
    print(zscore)


.. parsed-literal::

         Age 
    9.865891 
    

**Valor p para el coeficiente:**

.. code:: r

    p_value <- 2*pnorm(abs(zscore), lower.tail = FALSE)
    print(p_value)


.. parsed-literal::

            Age 
    5.85129e-23 
    

El coeficiente Edad es significativo.

**Predicción:**

.. code:: r

    predict(logistic_simple, newdata = data.frame(Age = 33)) 



.. raw:: html

    <strong>1:</strong> -1.80880495351216


.. math::  p  = \frac{exp \left(\beta_0+\beta_1 \right)}{1 + exp \left(\beta_0+\beta_1 \times X_1 \right)}  

.. code:: r

    exp(predict(logistic_simple, data.frame(Age = 33)))/(1+exp(predict(logistic_simple, data.frame(Age = 33))))



.. raw:: html

    <strong>1:</strong> 0.140782619945824


.. math::   p  = \frac{1}{1+exp \left[- \left(\beta_0+\beta_1 \times X_1  \right) \right]} 

.. code:: r

    1/(1+exp(-predict(logistic_simple, data.frame(Age = 33))))



.. raw:: html

    <strong>1:</strong> 0.140782619945824


Ajuste modelo múltiple:
~~~~~~~~~~~~~~~~~~~~~~~

.. math::   p  = \frac{1}{1+exp \left[- \left(\beta_0+\beta_1 \times Género +\beta_2 \times Edad + \beta_3 \times Salario  \right)\right]} 

.. code:: r

    logistic <- glm(Purchased ~ Gender + Age + EstimatedSalary, data = df, family = binomial)
    logistic



.. parsed-literal::

    
    Call:  glm(formula = Purchased ~ Gender + Age + EstimatedSalary, family = binomial, 
        data = df)
    
    Coefficients:
        (Intercept)          Gender0              Age  EstimatedSalary  
         -1.245e+01       -3.338e-01        2.370e-01        3.644e-05  
    
    Degrees of Freedom: 399 Total (i.e. Null);  396 Residual
    Null Deviance:	    521.6 
    Residual Deviance: 275.8 	AIC: 283.8


.. code:: r

    print(head(logistic$fitted.values))


.. parsed-literal::

               1            2            3            4            5            6 
    0.0007061408 0.0314610656 0.0063340671 0.0132775722 0.0056085336 0.0191141370 
    

.. code:: r

    print(min(logistic$fitted.values))
    
    print(max(logistic$fitted.values))


.. parsed-literal::

    [1] 0.0005440362
    [1] 0.9988217
    

.. code:: r

    ggplot() + geom_histogram(aes(x = logistic$fitted.values), binwidth = 0.01)+
            scale_x_continuous(labels = scales::percent)+
            labs(x = expression(p), y = "Número de observaciones")+
            theme_minimal()



.. image:: output_53_0.png
   :width: 420px
   :height: 420px


.. code:: r

    summary(logistic)



.. parsed-literal::

    
    Call:
    glm(formula = Purchased ~ Gender + Age + EstimatedSalary, family = binomial, 
        data = df)
    
    Deviance Residuals: 
        Min       1Q   Median       3Q      Max  
    -2.9109  -0.5218  -0.1406   0.3662   2.4254  
    
    Coefficients:
                      Estimate Std. Error z value Pr(>|z|)    
    (Intercept)     -1.245e+01  1.309e+00  -9.510  < 2e-16 ***
    Gender0         -3.338e-01  3.052e-01  -1.094    0.274    
    Age              2.370e-01  2.638e-02   8.984  < 2e-16 ***
    EstimatedSalary  3.644e-05  5.473e-06   6.659 2.77e-11 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    (Dispersion parameter for binomial family taken to be 1)
    
        Null deviance: 521.57  on 399  degrees of freedom
    Residual deviance: 275.84  on 396  degrees of freedom
    AIC: 283.84
    
    Number of Fisher Scoring iterations: 6
    


**Coeficientes:**

.. code:: r

    coef <- logistic$coefficients
    print(coef)


.. parsed-literal::

        (Intercept)         Gender0             Age EstimatedSalary 
      -1.244979e+01   -3.338434e-01    2.369694e-01    3.644119e-05 
    

.. math::  exp \left( coeficientes \right) = \frac{p }{1-p } = oddsRatio 

.. code:: r

    OR <- exp(coef)  # Odds Ratio
    print(OR)


.. parsed-literal::

        (Intercept)         Gender0             Age EstimatedSalary 
       3.918543e-06    7.161659e-01    1.267402e+00    1.000036e+00 
    

-  Por cada año de más, la probabilidad de comprar aumenta un 27%
   aproximadamente, si las demás variables permanecen constantes.

Male = 1

Female = 0

-  Comparando entre hombres y mujeres, los hombres aumentan la
   probabilidad de compra aproximadamente 7 veces, si las demás
   variables permanecen constantes.

-  Un aumento en el salario no aumenta ni disminuye la probabilidad de
   compra.

**Grados de libertad:**

.. code:: r

    gl <- logistic$df.null - logistic$df.residual
    print(gl)


.. parsed-literal::

    [1] 3
    

**Diferencia de las desviaciones:**

.. code:: r

    dif_residuos <- logistic$null.deviance - logistic$deviance
    print(dif_residuos)


.. parsed-literal::

    [1] 245.7297
    

**Valor p para bondad de ajuste:**

.. code:: r

    p_value <- pchisq(q = dif_residuos, df = gl, lower.tail = FALSE)
    print(p_value)


.. parsed-literal::

    [1] 5.487701e-53
    

Se rechaza la hipótesis nula, entonces el modelo es significativo a un
:math:`\alpha = 0,05`, pero existen unos coeficientes no significativos.

**Error estándar:**

.. math::  SE(\hat{\beta_j}) 

.. code:: r

    SE <- sqrt(diag(vcov(logistic)))[2:4]
    print(SE)


.. parsed-literal::

            Gender0             Age EstimatedSalary 
       3.052264e-01    2.637705e-02    5.472858e-06 
    

**Estadístico z:**

.. math::  zScore = \frac{\hat{\beta_j}}{SE(\hat{\beta_j})}  

.. code:: r

    zscore <- coef[2:4]/SE
    print(zscore)


.. parsed-literal::

            Gender0             Age EstimatedSalary 
          -1.093757        8.983922        6.658530 
    

**Valor p para el coeficiente:**

.. code:: r

    p_value <- 2*pnorm(abs(zscore), lower.tail = FALSE)
    print(p_value)


.. parsed-literal::

            Gender0             Age EstimatedSalary 
       2.740618e-01    2.612829e-19    2.765798e-11 
    

Género no es significativo. Edad y salario si son significativos.

**Predicción:**

.. code:: r

    predict(logistic, newdata = data.frame(Gender = '0', Age = 33, EstimatedSalary = 42000)) 



.. raw:: html

    <strong>1:</strong> -3.43311391519167


.. math::   p  = \frac{1}{1+exp \left[- \left(\beta_0+\beta_1 \times X_1 + ... + \beta_k \times X_k \right) \right]} 

.. code:: r

    1/(1+exp(-predict(logistic, newdata = data.frame(Gender = '0', Age = 33, EstimatedSalary = 42000))))



.. raw:: html

    <strong>1:</strong> 0.031276448293889


Si se agrega el argumento ``type = "response"`` en la función
``predict()`` el resultados son las probabilidades :math:`p` y lugar los
𝑙𝑜𝑔(𝑜𝑑𝑑𝑠𝑅𝑎𝑡𝑖𝑜).

.. code:: r

    predict(logistic, newdata = data.frame(Gender = '0', Age = 33, EstimatedSalary = 42000), type = "response") 



.. raw:: html

    <strong>1:</strong> 0.031276448293889

