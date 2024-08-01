Kernel PCA (kPCA)
-----------------

El Kernel PCA (kPCA) es una extensión del Análisis de Componentes
Principales (PCA) que permite realizar la reducción de dimensionalidad
no lineal utilizando funciones kernel. Mientras que el PCA estándar solo
puede capturar relaciones lineales, el Kernel PCA puede captar
relaciones no lineales transformando los datos originales a un espacio
de características de mayor dimensión donde se aplica PCA.

**Ejemplo de PCA (lineal):**

.. figure:: PCA_.JPG
   :alt: PCA

   PCA

**Ejemplo aplicación del Kernel:**

.. figure:: Kernel.JPG
   :alt: Kernal_PCA

   Kernal_PCA

**Ejemplo kPCA:**

.. figure:: kPCA.JPG
   :alt: kPCA

   kPCA

Funciones Kernel comunes:
~~~~~~~~~~~~~~~~~~~~~~~~~

**Lienal\_**

:math:`K(x, y) = x^T y`

Equivalente al PCA estándar.

**Polinómico:**

:math:`K(x, y) = (x^T y + c)^d`

Donde :math:`c` es un coeficiente y :math:`d` es el grado del polinomio.

**Radial Basis Function (RBF) o Gaussiano:**

:math:`K(x, y) = \exp(-\gamma ||x - y||^2)`

Donde :math:`\gamma` es un parámetro que define la amplitud del kernel.
Puede cambiar la forma de la campana. Un valor bajo ajustará libremente
el conjunto de datos, mientras que un valor más alto ajustará
exactamente al conjunto de datos, lo que provocaría un ajuste excesivo
(sobreajuste).

**Sigmoidal:**

:math:`K(x, y) = \tanh(\alpha x^T y + c)`

Donde :math:`alpha` y :math:`c` son parámetros.

Procedimiento de Kernel PCA:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Al igual que en PCA, es importante estandarizar los datos para que
tengan media cero y varianza uno.

**Cálculo de la Matriz Kernel:**

-  Se calcula la matriz kernel :math:`𝐾` aplicando la función kernel
   elegida a cada par de puntos en el conjunto de datos.

**Centrado de la Matriz Kernel:**

-  Se centra la matriz kernel para asegurarse de que los datos
   transformados tengan media cero.

**Descomposición de la Matriz Kernel:**

-  Se realiza la descomposición en valores propios de la matriz kernel
   centrada para obtener los valores propios (eigenvalues) y los
   vectores propios (eigenvectors).

**Proyección de los datos:**

-  Se proyectan los datos originales en el espacio de características no
   lineal usando los vectores propios.

Varianza explicada acumulada en Kernel PCA:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A diferencia del PCA estándar, calcular la varianza explicada acumulada
en Kernel PCA no es tan directo debido a la naturaleza no lineal de la
transformación de los datos y la falta de interpretación directa de los
componentes principales en el espacio original.

Mejor método de extracción de características:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Determinar cuál método de extracción de características, ya sea PCA
estándar o Kernel PCA, es más efectivo depende del objetivo específico
de tu análisis y de las métricas que utilices para evaluar el
rendimiento. A continuación se presentan algunos enfoques comunes para
comparar los métodos:

**1. Visualización de la separación de clases:**

La visualización es una herramienta poderosa para evaluar cómo los
diferentes métodos de reducción de dimensionalidad separan las clases.
Puedes comparar los gráficos de dispersión de PCA y Kernel PCA para ver
cuál proporciona una mejor separación visual entre las clases.

**2. Evaluación de modelos de clasificación:** Un enfoque cuantitativo
consiste en entrenar un modelo de clasificación en los datos reducidos
por cada método y comparar su rendimiento. Puedes usar métricas como la
precisión, el F1-score, la matriz de confusión, etc.
