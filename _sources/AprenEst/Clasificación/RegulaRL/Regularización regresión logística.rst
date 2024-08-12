Regularización regresión logística
----------------------------------

Un modelo ideal es aquel que se encuentra justo en el punto intermedio
entre la insuficiencia de ajuste y el sobreajuste. Sin embargo, para
identificar este punto óptimo, es necesario primero cruzarlo, es decir,
**construir un modelo que se ajuste en exceso a los datos.** Este
fenómeno se conoce como sobreajuste (overfitting), y ocurre cuando el
modelo logra un bajo error en el conjunto de entrenamiento, pero su
rendimiento comienza a degradarse en los datos de validación (o prueba).

Una vez que el modelo alcanza un nivel donde puede sobreajustarse, el
siguiente objetivo es maximizar su capacidad de generalización. Este
proceso implica modificar el modelo, volver a entrenarlo y evaluar su
rendimiento en los datos de validación. Este ciclo se repite hasta que
se obtiene el mejor modelo posible en términos de generalización. Es
importante señalar que, si se dispone de tres conjuntos de datos
(entrenamiento, validación y prueba), el proceso de ajuste nunca debe
basarse en los datos de prueba.

Técnicas de regularización en regresión logística:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Una de las formas más efectivas de mitigar el sobreajuste es aplicar
técnicas de regularización que imponen restricciones sobre la
complejidad del modelo. Esto se logra limitando los valores de los
coeficientes del modelo, lo que obliga a los pesos a ser pequeños y, por
lo tanto, reduce la probabilidad de sobreajuste.

La regularización se implementa añadiendo un término de penalización a
la función de pérdida del modelo, asociado con tener coeficientes
grandes. Existen dos métodos principales de regularización:

**Regularización L1 (Lasso):**

La regularización L1, también conocida como Lasso (Least Absolute
Shrinkage and Selection Operator), agrega un término de penalización
proporcional a la suma de los valores absolutos de los coeficientes del
modelo:

.. math::  Loss = Error(\hat{y},y) + \lambda \sum{|w_i|}  

.. math::  ||w||_1 = \sum{|w_i|} 

Donde :math:`\lambda` es el parámetro de regularización que controla la
fuerza de la penalización.

Lasso tiende a reducir a cero algunos de los coeficientes, lo que lleva
a un modelo más simple y a menudo más interpretativo, ya que efectúa una
selección de variables automática. Esto significa que Lasso no solo
ajusta el modelo, sino que también selecciona las características más
relevantes.

Es especialmente útil cuando se cree que solo un subconjunto de las
características son verdaderamente relevantes para la predicción.

**Regularización L2 (Ridge):**

La regularización L2, o Ridge, introduce una penalización proporcional
al cuadrado de los coeficientes del modelo:

.. math::  Loss = Error(\hat{y},y) + \lambda \sum{(w_i)^2}  

.. math::  ||w||_2 = \sum{(w_i)^2} 

A diferencia de L1, L2 distribuye la penalización entre todos los
coeficientes, reduciendo su magnitud pero sin llegar a eliminarlos. Esto
implica que todas las características permanecen en el modelo, aunque
sus impactos son atenuados.

Ridge es ideal cuando todas las características del modelo tienen alguna
relevancia para la predicción, aunque su contribución puede ser pequeña.

Ten en cuenta que la regularización de pesos es más comúnmente utilizada
en modelos de aprendizaje profundo de menor tamaño. En los modelos de
aprendizaje profundo más grandes, que suelen estar altamente
parametrizados, imponer restricciones a los valores de los pesos no
suele tener un impacto significativo en la capacidad y la generalización
del modelo. En estos casos, se prefieren otras técnicas de
regularización.

Ridge Regression y Lasso Regression:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  **Ridge Regression:** Específicamente, se refiere al uso de
   regularización L2 en un contexto de regresión. Es particularmente
   útil en situaciones donde existe multicolinealidad entre las
   características o cuando el número de características supera al
   número de observaciones.

-  **Lasso Regression:** Este término se refiere a la aplicación de
   regularización L1 en modelos de regresión. Además de ajustar el
   modelo, Lasso también realiza una selección de características, lo
   que puede ser beneficioso en escenarios donde se sospecha que solo
   algunas variables son realmente importantes.
