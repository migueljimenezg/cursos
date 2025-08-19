Regresión Logística para clasificación en R
-------------------------------------------

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

    print(dim(df))


.. parsed-literal::

    [1] 400   4
    

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
    

**Variable categórica:**

.. code:: r

    print(unique(df$Gender))


.. parsed-literal::

    [1] "Male"   "Female"
    

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
    


Curva ROC:
~~~~~~~~~~

**Punto de corte:**

Definiremos el punto de corte con la probabilidad del 70%.

Cada observación tiene una probabilidad asociada que fue ajustada por el
modelo logit, ``logistic$fitted.values``. Probabilidades mayores o
iguales que 0,7 será clasificadas como :math:`1`, es decir, que sí
compraron, las demás observaciones serán clasificadas como :math:`0`, no
compraron.

.. code:: r

    y_pred <- ifelse(logistic$fitted.values >= 0.7, 1, 0)

.. code:: r

    library(ggplot2)

.. code:: r

    ggplot(data = df, aes(x = Age, y = EstimatedSalary, 
                          color = as.factor(Purchased), shape = Gender))+
        geom_point(size = 3)+
        labs(color = "Purchased")



.. image:: output_21_0.png
   :width: 420px
   :height: 420px


Instalar el siguiente paquete: ``install.packages('ROCR')``. Se usará la
función ``ROCR()`` para graficar la curva ROC, pero primero se debe
crear un objeto de predicción, se usa la función ``prediction()`` para
transformar los datos en un formato estándar que se pueda graficar con
la función ``ROCR()``. Luego, se crea un objeto con el rendimiento del
clasificador con la función ``performance()``, donde se agrega el
argumento ``measure = "tpr"`` para indicar *True positive rate* y el
argumento ``x.measure = "fpr"`` para *False positive rate* en el eje
:math:`x` de la curva ROC.

.. code:: r

    library(ROCR)


.. parsed-literal::

    Warning message:
    "package 'ROCR' was built under R version 4.1.3"
    

.. code:: r

    prediction <- prediction(y_pred, df$Purchased)
    perf <- performance(prediction, measure = "tpr", x.measure = "fpr")
    plot(perf)
    abline(a=0, b= 1)



.. image:: output_24_0.png
   :width: 420px
   :height: 420px


La anterior es la curva ROC para un punto de corto de 0,70.

**AUC:**

Podemos usar el paquete ``ROCR`` para calcular el AUC. Para hacerlo,
primero debemos crear otro objeto de ``perf.auc``, esta vez
especificando ``measure = "auc"``.

.. code:: r

    perf.auc <- performance(prediction, measure = "auc")

Se usa ``@`` porque el objeto creado tiene slots.

.. code:: r

    auc <- unlist(perf.auc@y.values)
    print(auc)


.. parsed-literal::

    [1] 0.754823
    

Matriz de confusión:
~~~~~~~~~~~~~~~~~~~~

Antes de mostrar la matriz de confusión hagamos estos cálculos:

**Cantidad de valores predichos como 1 (TP + FP):**

.. code:: r

    print(sum(y_pred))


.. parsed-literal::

    [1] 90
    

**Cantidad de valores predichos como 0 (FN + TN):**

.. code:: r

    print(length(y_pred) - sum(y_pred))


.. parsed-literal::

    [1] 310
    

**Cantidad de observaciones actuales que son 1:**

.. code:: r

    print(sum(df$Purchased))


.. parsed-literal::

    [1] 143
    

**Cantidad de observaciones actuales que son 0:**

.. code:: r

    print(length(df$Purchased) - sum(df$Purchased))


.. parsed-literal::

    [1] 257
    

**Predicciones correctas de la categoría 1 (Verdaderos Positivos -
TP):**

.. code:: r

    print(sum(ifelse(df$Purchased == 1 & y_pred == 1, 1, 0)))


.. parsed-literal::

    [1] 79
    

**Predicciones correctas para la categoría 0 (Verdaderos Negativos -
TN):**

.. code:: r

    print(sum(ifelse(df$Purchased == 0 & y_pred == 0, 1, 0)))


.. parsed-literal::

    [1] 246
    

**Predicciones correctas en total:**

.. code:: r

    print(sum(ifelse(df$Purchased == y_pred, 1,0)))


.. parsed-literal::

    [1] 325
    

**Cantidad de predicciones incorrectas para la categoría 1 (Falso
negativo - FN - Error tipo 2):**

.. code:: r

    print(sum(ifelse(df$Purchased == 1 & y_pred == 0, 1, 0)))


.. parsed-literal::

    [1] 64
    

**Cantidad de predicciones incorrectas para la categoría 0 (Falso
positivo - FP - Error tipo 1):**

.. code:: r

    print(sum(ifelse(df$Purchased == 0 & y_pred == 1, 1, 0)))


.. parsed-literal::

    [1] 11
    

La siguiente matriz de confusión tiene la forma:

============ =============== ===============
\            Predicho como 0 Predicho como 1
============ =============== ===============
**Actual 0** TN              FP
**Actual 1** FN              TP
============ =============== ===============

.. code:: r

    cm <- table(df$Purchased, y_pred)
    print(cm)


.. parsed-literal::

       y_pred
          0   1
      0 246  11
      1  64  79
    

Métricas:
~~~~~~~~~

.. code:: r

    TP <- cm[4]
    print(TP)


.. parsed-literal::

    [1] 79
    

.. code:: r

    TN <- cm[1]
    print(TN)


.. parsed-literal::

    [1] 246
    

.. code:: r

    FN <- cm[2]
    print(FN)


.. parsed-literal::

    [1] 64
    

.. code:: r

    FP <- cm[3]
    print(FP)


.. parsed-literal::

    [1] 11
    

.. code:: r

    print(sum(cm))


.. parsed-literal::

    [1] 400
    

**Accuracy:**

.. math::  accuracy = \frac{TP+TN}{TP+TN+FP+FN}  

.. code:: r

    accuracy <- (TP+TN)/sum(cm)
    print(accuracy)


.. parsed-literal::

    [1] 0.8125
    

**Error Rate:**

.. math::  ErrorRate = \frac{FP+FN}{TP+TN+FP+FN} = 1 - accuracy 

.. code:: r

    error <- (FP+FN)/sum(cm)
    print(error)


.. parsed-literal::

    [1] 0.1875
    

**Sensitivity:**

.. math::  sensitivity = \frac{TP}{TP+FN}  

.. code:: r

    sensitivity <- TP/(TP+FN)
    print(sensitivity)


.. parsed-literal::

    [1] 0.5524476
    

**Specificity:**

.. math::  specificity = \frac{TN}{TN+FP}  

.. code:: r

    specificity <- TN/(TN+FP)
    print(specificity)


.. parsed-literal::

    [1] 0.9571984
    

**Precision:**

.. math::  precision = \frac{TP}{TP+FP}  

.. code:: r

    precision <- TP/(TP+FP)
    print(precision)


.. parsed-literal::

    [1] 0.8777778
    

**Recall:**

.. math::  recall = \frac{TP}{TP+FN}  

.. code:: r

    recall <- TP/(TP+FN)
    print(recall)


.. parsed-literal::

    [1] 0.5524476
    

**F-measure:**

.. math::  F-measure = \frac{2 \times precision \times recall}{recall + precision} = \frac{2 \times TP}{2 \times TP + FP + FN}  

.. code:: r

    F1 <- (2*precision*recall)/(recall+precision)
    print(F1)


.. parsed-literal::

    [1] 0.6781116
    

.. code:: r

    F1 <- (2*TP)/(2*TP+FP+FN)
    print(F1)


.. parsed-literal::

    [1] 0.6781116
    

**¿Cómo cambian los resultados si el punto de corte es con una
probabilidad de 0,50?**
