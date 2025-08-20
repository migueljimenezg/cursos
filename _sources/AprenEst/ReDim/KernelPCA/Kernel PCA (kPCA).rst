Kernel PCA (kPCA)
-----------------

**Kernel PCA (kPCA)**

El Análisis de Componentes Principales (PCA) tradicional es un método
lineal: busca ejes ortogonales en el espacio original de los datos para
capturar la mayor varianza. Esto funciona muy bien cuando la estructura
de los datos puede describirse con combinaciones lineales, pero **es
insuficiente cuando los datos tienen relaciones no lineales**.

**¿Qué hace Kernel PCA?**

El Kernel PCA (kPCA) extiende el PCA clásico utilizando la llamada
**“truco del kernel” (kernel trick)**. En lugar de aplicar PCA
directamente en el espacio original, kPCA:

1. **Mapea los datos a un espacio de mayor dimensión** a través de una
   función no lineal implícita.

2. En ese espacio transformado, **las relaciones no lineales se
   convierten en lineales**.

3. Aplica PCA en ese nuevo espacio, y luego proyecta los datos sobre los
   componentes principales encontrados.

**La magia del kernel trick**

El kernel trick evita calcular explícitamente la transformación a
espacios de muy alta dimensión (lo cual sería costoso). En su lugar, se
usan **funciones kernel** que permiten calcular los productos internos
en ese espacio sin necesidad de hacer la transformación de manera
explícita.

**Funciones kernel más comunes:**

-  **Kernel lineal:** equivalente al PCA clásico.

-  **Kernel polinómico:** permite capturar relaciones polinómicas entre
   las variables.

-  **Kernel RBF (Radial Basis Function o Gaussiano):** muy usado para
   capturar relaciones altamente no lineales.

-  **Kernel sigmoide:** similar al que se utiliza en redes neuronales.

**¿Cuándo usar kPCA?**

-  Cuando los datos tienen **patrones no lineales** difíciles de
   capturar con PCA clásico.

-  Para **reducción de dimensionalidad previa a clasificación** en
   problemas complejos.

-  En situaciones donde se sospecha que la estructura interna de los
   datos no es lineal.

**En resumen:**

-  PCA clásico = reducción de dimensionalidad lineal.
-  kPCA = reducción de dimensionalidad no lineal, gracias al uso de
   funciones kernel.
   Esto convierte al Kernel PCA en una herramienta muy poderosa para
   descubrir estructuras ocultas en datos complejos.

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

**Lineal**

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

**Parámetros:**

+---------------+------------------------------------------------------+
| Parámetro     | Explicación breve                                    |
+===============+======================================================+
| **n           | Número de componentes principales a calcular (≤      |
| _components** | número de observaciones).                            |
+---------------+------------------------------------------------------+
| **kernel**    | Tipo de kernel: ``'linear'``, ``'poly'``, ``'rbf'``, |
|               | ``'sigmoid'``, ``'cosine'``, etc.                    |
+---------------+------------------------------------------------------+
| **gamma**     | Parámetro del kernel RBF, polinómico y sigmoide;     |
|               | controla la curvatura.                               |
+---------------+------------------------------------------------------+
| **degree**    | Grado del polinomio si ``kernel='poly'``.            |
+---------------+------------------------------------------------------+
