Regularización regresión logística
----------------------------------

Un modelo ideal es aquel que se encuentra en un punto intermedio entre
la **insuficiencia de ajuste** (*underfitting*) y el **sobreajuste**
(*overfitting*).

-  **Sobreajuste (overfitting):** ocurre cuando el modelo aprende
   demasiado bien los datos de entrenamiento (bajo error en train), pero
   su rendimiento se degrada en los datos de validación o prueba.

-  **Subajuste (underfitting):** ocurre cuando el modelo es demasiado
   simple y no logra capturar los patrones reales, presentando errores
   altos tanto en entrenamiento como en prueba.

El objetivo es encontrar el **punto óptimo de generalización**. Para
lograrlo se aplica un ciclo de ajuste donde el modelo se entrena, se
valida y se modifica hasta obtener el mejor desempeño posible en datos
no vistos.

⚠️ Importante: si se dispone de tres conjuntos de datos
(**entrenamiento, validación y prueba**), el ajuste nunca debe basarse
en los datos de prueba.

--------------

Técnicas de regularización en regresión logística
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La **regularización** es una de las formas más efectivas de mitigar el
sobreajuste.

Consiste en añadir una penalización que **limita los coeficientes** del
modelo, evitando que crezcan demasiado y obligando a que los pesos sean
pequeños.

De esta forma:

-  El modelo se vuelve más **estable**.

-  Disminuye el riesgo de que aprenda el **ruido** de los datos.

--------------

Regularización L1 (Lasso)
^^^^^^^^^^^^^^^^^^^^^^^^^

-  También conocida como **Least Absolute Shrinkage and Selection
   Operator**.

-  Agrega un término de penalización proporcional a la suma de los
   valores absolutos de los coeficientes:

.. math::


   L(\beta) = \text{Log-Loss} + \lambda \sum_{j=1}^m |\beta_j|

-  Tiende a reducir a **cero** algunos coeficientes → genera un modelo
   más simple.

-  Realiza **selección automática de variables**, dejando solo las más
   relevantes.

-  Útil cuando se sospecha que **solo algunas variables** son
   importantes para la predicción.

--------------

Regularización L2 (Ridge)
^^^^^^^^^^^^^^^^^^^^^^^^^

-  Introduce una penalización proporcional al cuadrado de los
   coeficientes:

.. math::


   L(\beta) = \text{Log-Loss} + \lambda \sum_{j=1}^m \beta_j^2

-  No elimina variables, pero reduce la magnitud de todos los
   coeficientes.

-  Útil cuando **todas las variables aportan algo**, aunque sea poco.

-  Ayuda en casos de **multicolinealidad** o cuando el número de
   variables es grande.

--------------

Ridge Regression y Lasso Regression
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  **Ridge Regression:** uso de regularización L2 en regresión.
   Particularmente útil cuando hay multicolinealidad o muchas variables.

-  **Lasso Regression:** uso de regularización L1 en regresión. Además
   de ajustar el modelo, hace **selección de características**.

--------------

``C`` en la regresión logística: explicación matemática
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

En scikit-learn, el parámetro que controla la regularización es
**``C``**, definido como:

.. math::


   C = \frac{1}{\lambda}

donde :math:`\lambda` es la fuerza de la regularización.

--------------

**1. Función de costo sin regularización**

La regresión logística minimiza la función de pérdida (*log-loss*):

.. math::


   L(\beta) = - \sum_{i=1}^n \Big[ y_i \log(p_i) + (1-y_i)\log(1-p_i) \Big]

donde:

-  :math:`y_i \in \{0,1\}` es la etiqueta real.
-  :math:`p_i = \frac{1}{1 + e^{-(\beta_0 + \beta_1 x_{i1} + ... + \beta_m x_{im})}}`
   es la probabilidad predicha.

--------------

**2. Con regularización**

-  Con **L2 (Ridge):**

.. math::


   L(\beta) = \text{Log-Loss} + \lambda \sum_{j=1}^m \beta_j^2

-  Con **L1 (Lasso):**

.. math::


   L(\beta) = \text{Log-Loss} + \lambda \sum_{j=1}^m |\beta_j|

--------------

**3. Interpretación de** ``C``

-  ``C`` **grande ⇒ :math:`\lambda` pequeño** → poca regularización.

   -  El modelo puede ajustar muy bien los datos, pero corre riesgo de
      **sobreajuste**.

-  ``C`` **pequeño ⇒ :math:`\lambda` grande** → mucha regularización.

   -  Los coeficientes se reducen hacia 0, el modelo se simplifica →
      riesgo de **subajuste**.

--------------

**4. Consecuencia práctica**

-  Si los coeficientes :math:`\beta_j` son muy **grandes** → el modelo
   memoriza y se sobreajusta.

-  Si los coeficientes :math:`\beta_j` son muy **pequeños** → el modelo
   ignora patrones y subajusta.

Por eso, ``C`` debe ajustarse cuidadosamente (ej. con **validación
cruzada**).

--------------
