Clasificación
-------------

La clasificación es una de las tareas fundamentales en el campo del
Machine Learning y la estadística, con aplicaciones extensas en
finanzas. Su objetivo es predecir la clase o categoría a la que
pertenece una observación dada, basada en sus características (variables
o Features). Es un tipo de aprendizaje supervisado, donde el algoritmo
aprende de un conjunto de datos etiquetados.

Tipos de clasificación:
~~~~~~~~~~~~~~~~~~~~~~~

**1. Clasificación Binaria:**

La clasificación binaria implica predecir una de dos clases posibles.
Ejemplos en finanzas incluyen:

-  Determinar si un préstamo será pagado o no (default/no default).

-  Predecir si el precio de una acción subirá o bajará.

**2. Clasificación Multiclase:**

La clasificación multiclase involucra predecir una de tres o más clases
posibles. Ejemplos en finanzas incluyen:

-  Clasificar el riesgo crediticio en categorías (bajo, medio, alto).

-  Identificar el sector de una empresa (tecnología, salud, finanzas).

**3. Clasificación Multietiqueta:**

En la clasificación multietiqueta, cada observación puede pertenecer a
múltiples clases. Ejemplos en finanzas incluyen:

-  Etiquetar transacciones financieras con múltiples categorías de
   fraude.

-  Asignar múltiples etiquetas de riesgo a un portafolio de inversión.

Algoritmos de Clasificación:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**1. Regresión Logística**

La regresión logística es un modelo estadístico que se utiliza para
clasificar observaciones en dos categorías. Se basa en la función
logística (sigmoide) para modelar la probabilidad de pertenencia a una
clase.

**Ventajas:**

-  Simple y fácil de interpretar.

-  Rápido de entrenar.

-  Útil para problemas de clasificación binaria como predicción de
   impago de préstamos.

**Desventajas:**

-  Asume una relación lineal entre las variables independientes y el
   logit.

-  No maneja bien relaciones no lineales complejas.

**3. Árboles de Decisión:**

Los árboles de decisión dividen los datos en subconjuntos basados en
condiciones sobre las características, formando una estructura de árbol.

**Ventajas:**

-  Fácil de visualizar e interpretar.

-  Maneja bien tanto variables categóricas como continuas.

-  Útil para la evaluación de crédito y análisis de riesgo.

**Desventajas:**

-  Propenso al sobreajuste (overfitting).

-  Sensible a pequeños cambios en los datos.

**2. Support Vector Machines (SVM)**

SVM encuentra el hiperplano que mejor separa las clases en el espacio de
características.

**Ventajas:**

-  Efectivo en espacios de alta dimensión.

-  Funciona bien con una clara separación entre clases.

-  Útil para la detección de fraudes financieros.

**Desventajas:**

-  No es intuitivo y puede ser difícil de interpretar.

-  Sensible a la elección del kernel y los parámetros.

**4. Redes Neuronales Artificiales:**

Las redes neuronales artificiales son modelos de aprendizaje profundo
que pueden capturar relaciones complejas entre las características y la
variable objetivo.

**Ventajas:**

-  Capaces de modelar relaciones no lineales complejas.

-  Muy flexibles y potentes.

-  Útil para la predicción de precios de acciones y análisis de series
   temporales financieras.

**Desventajas:**

-  Requieren grandes cantidades de datos y poder computacional.

-  Difíciles de interpretar.
