Transformaciones Box-Cox y raíz cuadrada
----------------------------------------

**Transformaciones para estabilizar la varianza**

En muchos modelos de series de tiempo o de regresión, se asume que la
varianza de los errores es constante (homocedasticidad).

Sin embargo, cuando la variabilidad de la serie aumenta con el nivel de
la media, se presenta heterocedasticidad, lo que viola esa suposición y
puede afectar el desempeño del modelo.

Para corregirlo, se aplican transformaciones no lineales a la serie
original, con el objetivo de:

-  Reducir la variabilidad relativa de los datos.

-  Mejorar la normalidad de los errores.

-  Facilitar la identificación de patrones de tendencia y
   estacionalidad.

Las dos transformaciones más utilizadas son la de raíz cuadrada y la de
Box–Cox.

Transformación de raíz cuadrada
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La transformación de raíz cuadrada se define como:

.. math::


   y_t' = \sqrt{y_t}

Se utiliza cuando los valores de la serie son **positivos** y la
varianza crece aproximadamente de forma proporcional a la media.

Cuando los valores de la serie aumentan, también suele aumentar su
variabilidad.

Aplicar la raíz cuadrada reduce la dispersión relativa de los valores
grandes y tiende a estabilizar la varianza.

**Ventajas**

-  Es sencilla de aplicar e interpretar.

-  No requiere estimar parámetros.

-  Siempre produce valores positivos si :math:`y_t > 0`.

**Desventajas**

-  No siempre corrige completamente la heterocedasticidad.

-  Puede no ser suficiente si la serie tiene alta asimetría.

**Reversión de la transformación**

Para volver a la escala original:

.. math::


   y_t = (y_t')^2

2. Transformación Box–Cox
~~~~~~~~~~~~~~~~~~~~~~~~~

La transformación Box–Cox (Box & Cox, 1964) es una familia de
transformaciones paramétricas que incluye a la logarítmica y la raíz
cuadrada como casos particulares.

.. math::


   y_t' =
   \begin{cases}
   \dfrac{y_t^{\lambda} - 1}{\lambda}, & \text{si } \lambda \neq 0, \\[8pt]
   \log(y_t), & \text{si } \lambda = 0
   \end{cases}

Donde:

-  :math:`y_t > 0` **(la serie debe ser estrictamente positiva).**

-  :math:`\lambda` es el parámetro de transformación que controla el
   grado de compresión o expansión de la escala.

**Interpretación de** :math:`\lambda`

-  :math:`\lambda = 1`: no se aplica transformación (identidad).

-  :math:`\lambda = 0.5`: equivale a una transformación de raíz
   cuadrada.

-  :math:`\lambda = 0`: equivale a una transformación logarítmica.

El valor óptimo de :math:`\lambda` se estima maximizando la
verosimilitud, de manera que la serie transformada sea lo más cercana
posible a una distribución normal con varianza constante.

**Reversión de la transformación**

Para volver a la escala original:

.. math::


   y_t =
   \begin{cases}
   (\lambda y_t' + 1)^{1/\lambda}, & \text{si } \lambda \neq 0, \\[8pt]
   e^{y_t'}, & \text{si } \lambda = 0
   \end{cases}

**Ventajas**

-  Permite ajustar la transformación a la forma de la serie.

-  Puede mejorar la normalidad y estabilizar la varianza
   simultáneamente.

-  Es más flexible que aplicar logaritmos o raíces fijas.

**Desventajas**

-  Solo se puede aplicar a valores positivos.

-  Requiere estimar el parámetro :math:`\lambda`.
