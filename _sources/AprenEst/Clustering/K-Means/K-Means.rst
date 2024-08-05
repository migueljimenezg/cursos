K-Means
-------

K-Means es un algoritmo de clustering popular en aprendizaje no
supervisado. Su objetivo es dividir un conjunto de datos en :math:`K`
clústeres predefinidos, donde cada punto de datos pertenece al clúster
con el centroide más cercano.

Este método agrupa los datos en :math:`K` número de grupos o clústeres
en un espacio de muestra dado. Las similitudes de los datos en un
clúster se miden en términos de **distancia** de los puntos desde el
centro de la agrupación. El centro del clúster se conoce como
**centroide**. Generalmente, antes de aplicar este método, se asigna el
valor de :math:`K` y el algoritmo K-Means intenta minimizar la suma de
las distancias entre los puntos de datos y el centroide del grupo al que
pertenecen.

En el agrupamiento de K-Means, cada grupo está representado por su
centro (es decir, centroide) que corresponde a la media de los puntos
asignados al grupo.

La distancia de cada punto al centroide se mide generalmente usando la
**distancia euclidiana.** La fórmula para la distancia euclidiana en un
espacio n-dimensional es:

.. math::  d(x, c) = \sqrt{\sum_{i=1}^{n} (x_i - c_i)^2} 

donde:

-  :math:`d(x, c)` es la distancia entre el punto :math:`x` y el
   centroide :math:`c`.

-  :math:`x_i` es la coordenada del punto :math:`x_i` en la dimensión
   :math:`i`.

-  :math:`c_i` es la coordenada del centroide :math:`c_i` en la
   dimensión :math:`i`.

-  :math:`n`: cantidad de observaciones.

Pasos en el K-Means:
~~~~~~~~~~~~~~~~~~~~

1. Iniciar el modelo con un número de :math:`k` cluters.

2. Aleatoriamente ubicar los :math:`k` centroides entre los puntos de
   datos.

3. Calcular los distancias entre todos los puntos de datos con cada
   centroide y asignar los puntos al centroide más cercano.

4. Volver a calcular los centroides de los nuevos grupos.

5. Repetir los pasos 3 y 4 hasta que se cumplan los criterios para parar
   las iteraciones.

Para terminar y dejar de iterar el modelo se puede aplicar alguno de los
siguientes criterios:

-  Si los nuevos centros de los clusters son iguales a los anteriores.

-  Si los puntos de datos de los clusters siguen siendo los mismos.

-  Cuando se alcanza el número máximo de iteraciones. Este criterio lo
   define el analista.

**Ejemplo:**

.. figure:: Puntos.PNG
   :alt: Puntos

   Puntos

La anterior figura se representa por la siguiente matriz:

.. math::

    \begin{bmatrix}
   INDIVIDUOS & Variable_1 & Variable_2 \\
   Individuo_1 & 1 & 1 \\
   Individuo_2 & 2 & 1 \\
   Individuo_3 & 4 & 3 \\
   Individuo_4 & 5 & 4 \end{bmatrix} 

Tenemos :math:`n = 4` individuos u observaciones y cada uno con
:math:`p = 2` variables.

**Iteración # 1:**

Para :math:`k=2` clusters, se inicializarán aleatoriamente. Supongamos
que el centroide 1 se ubica en :math:`C1 = (1,1)` y el centroide 2 en
:math:`C2 = (2,1)`. La siguiente figura muestra los puntos con los dos
centroides.

.. figure:: Centroides.PNG
   :alt: Centroides

   Centroides

**Distancias de todos los puntos al centroide 1** :math:`C1 = (1,1)`

:math:`D1:\sqrt{(1-1)^2+(1-1)^2}=0`

:math:`D2:\sqrt{(2-1)^2+(1-1)^2}=1`

:math:`D3:\sqrt{(4-1)^2+(3-1)^2}=3,61`

:math:`D4:\sqrt{(5-1)^2+(4-1)^2}=5`

**Distancias de todos los puntos al centroide 2** :math:`C2 = (2,1)`

:math:`D1:\sqrt{(1-2)^2+(1-1)^2}=1`

:math:`D2:\sqrt{(2-2)^2+(1-1)^2}=0`

:math:`D3:\sqrt{(4-2)^2+(3-1)^2}=2,83`

:math:`D4:\sqrt{(5-2)^2+(4-1)^2}=4,24`

Resumiendo:

.. math::

    D = \begin{bmatrix}
   0 & 1 & 3,61 & 5 \\
   1 & 0 & 2,83 & 4,24  \end{bmatrix} \begin{bmatrix}
   C1(grupo1) \\
   C2(grupo2)  \end{bmatrix}

Con el criterio de asignar el centroide más cercano a cada punto, solo
el punto (1,1) pertenece a C1, los demás puntos pertenecen a C2.

.. figure:: Iteracion1.PNG
   :alt: Iteracion1

   Iteracion1

**Iteración # 2:**

Luego, se determinan los nuevos centroides. Como el cluster 1 solo tiene
un solo individuo, el centroide 1 sigue siendo el mismo. Para el cluster
2, el nuevo centroide se calcula como la media **(means)** de los puntos
así:

.. math::

    C2 = \begin{pmatrix}
   \frac{2+4+5}{3}; &
   \frac{1+3+4}{3}  \end{pmatrix} = (3,67; 2,67) 

El centroide 2 cambia de posición al punto :math:`C2 = (3,67; 2,67)`

Nuevamente, la matriz de distancias sería:

.. math::

    D = \begin{pmatrix}
   0 & 1 & 3,61 & 5 \\
   3,14 & 2,36 & 0,47 & 1,89  \end{pmatrix} \begin{pmatrix}
   C1(grupo1) \\
   C2(grupo2)  \end{pmatrix}

Con el criterio de la mínima distancia al centroide, ahora los puntos
(1,1) y (2,1) pertenecen al cluster 1 y los puntos (4,3) y (5,4)
pertenecen al cluster 2.

.. figure:: Iteracion2.PNG
   :alt: Iteracion2

   Iteracion2

**Iteración # 3:**

Los dos nuevos centroides serán:

.. math::

    C1 = \begin{pmatrix}
   \frac{1+2}{2}; &
   \frac{1+1}{2}  \end{pmatrix} = (1,51; 1) 

.. math::

    C2 = \begin{pmatrix}
   \frac{4+5}{2}; &
   \frac{3+4}{2}  \end{pmatrix} = (4,5; 3,5) 

Para estos nuevos centroides la matriz de distancias es:

.. math::

    D = \begin{pmatrix}
   0,5 & 0,5 & 3,2 & 4,61 \\
   4,3 & 3,54 & 0,71 & 0,71  \end{pmatrix} \begin{pmatrix}
   C1(grupo1) \\
   C2(grupo2)  \end{pmatrix}

Nuevamente con el criterio de distancia mínima a los centroides, los
puntos (1,1) y (2,1) siguen perteneciendo al cluster 1 y los puntos
(4,3) y (5,4) al cluster 2. Como no hay cambios en los individuos en los
clusters, por tanto, el algoritmo K-Means converge en este punto.

.. figure:: Iteracion3.PNG
   :alt: Iteracion3

   Iteracion3

**Resultado:**

La clasificación queda de la siguiente manera:

============== ============== ============== ===========
**Individuos** **Variable 1** **Variable 2** **Cluster**
============== ============== ============== ===========
Individuo 1    1              1              1
Individuo 2    2              1              1
Individuo 3    4              3              2
Individuo 4    5              4              2
============== ============== ============== ===========

Distancias:
~~~~~~~~~~~

Veremos las distancias Euclidiana, Manhattan y Minkowsky.

Tenemos :math:`n` individuos u observaciones y cada uno con :math:`p`
variables.

.. math::

    \begin{bmatrix}
   x_{11} & x_{12} & x_{13} & ... & x_{1p} \\
   x_{21} & x_{22} & x_{23} & ... & x_{2p} \\
   .      &   .    &   .    &  .  &   .     \\
   .      &   .    &   .    &  .  &   .     \\
   x_{n1} & x_{n2} & x_{n3} & ... & x_{np} \end{bmatrix} 

Un individuo será el vector:
:math:`x_i = \begin{bmatrix} x_{i1}, & x_{i2}, & x_{i3} & ..., & x_{ip} \end{bmatrix}`

Distancia Euclidiana:
~~~~~~~~~~~~~~~~~~~~~

La distancia euclidiana es la raíz cuadrada de la suma de las
diferencias al cuadrado entre las coordenadas correspondientes de dos
puntos.

La usamos en el ejemplo anterior y es la única distancia que usa
``scikit-learn`` en ``sklearn.cluster``.

.. math::  d(x, c) = \sqrt{\sum_{i=1}^{n} (x_i - c_i)^2} 

donde:

-  :math:`d(x, c)` es la distancia entre el punto :math:`x` y el
   centroide :math:`c`.

-  :math:`x_i` es la coordenada del punto :math:`x_i` en la dimensión
   :math:`i`.

-  :math:`c_i` es la coordenada del centroide :math:`c_i` en la
   dimensión :math:`i`.

-  :math:`n`: cantidad de observaciones.

Distancia Manhattan:
~~~~~~~~~~~~~~~~~~~~

La distancia Manhattan entre el individuo :math:`x_i` y el centroide
:math:`c_j` se calcula con el valor absoluto de la resta entre las filas
:math:`i` y :math:`j`. Cada variable del individual :math:`i` se resta
con las de individuo :math:`j`, la sumatoria de estas restas en valor
absoluto es el cálculo de la distancia Manhattan.

.. math::  D_1(x_i, c_j) =\sum_{k=1}^p{|x_{i}-x_{j}|} 

.. figure:: Distancias.PNG
   :alt: Distancias

   Distancias

Distancia Minkowski:
~~~~~~~~~~~~~~~~~~~~

La distancia de Minkowski es una métrica de distancia que generaliza
tanto la distancia euclidiana como la distancia de Manhattan, y se
define de la siguiente manera:

.. math::  D_1(x_i, c_j) =(\sum_{k=1}^p{|x_{i}-c_{j}|^p})^{\frac{1}{p}} 

Si :math:`p = 1`: Distancia Manhattan.

Si :math:`p = 2`: Distancia Euclídea.

.. figure:: Minkowski.PNG
   :alt: Minkowski

   Minkowski

Escalamiento de variables:
~~~~~~~~~~~~~~~~~~~~~~~~~~

El escalamiento de las variables es un paso crucial antes de aplicar
algoritmos de clustering como K-Means. El escalamiento asegura que todas
las variables contribuyan equitativamente al cálculo de distancias. Las
técnicas más comunes para escalar variables son la normalización y la
estandarización.

Se recomienda estandarizar o normalizar las variables antes de calcular
las distancias, especialmente cuando tenemos grandes diferencias en las
unidades de las variables.

.. math::  Estandarización = X_{stand} = \frac{x_i-mín(x)}{máx(x)-mín(x)}  

.. math::  Normalización = X_{norm} = \frac{x_i-\overline{x}}{\sigma_x}  

En la mayoría de los casos, se recomienda la estandarización,
especialmente cuando las variables tienen diferentes unidades o escalas.

Número óptimo de clusters:
~~~~~~~~~~~~~~~~~~~~~~~~~~

Se emplean técnicas subjetivas.

Determinar el número óptimo de clústeres es un paso crucial en el
proceso de clustering. Una de las técnicas más comunes para determinar
el número óptimo de clústeres es el método del codo. Este método evalúa
la inercia (Within-Cluster Sum of Squares, WCSS) para diferentes valores
de :math:`𝐾` y busca el punto donde la disminución de la inercia se
vuelve menos pronunciada, formando un “codo” (elbow).

El valor máximo de WCSS es cuando solo se hace con un cluster, cuando
:math:`k = 1`.

.. math::  WCSS = \sum_{x_i \in Cluster_1}{D(x_i, C_1)^2}+\sum_{x_i \in Cluster_2}{D(x_i, C_2)^2}+...+\sum_{x_i \in Cluster_k}{D(x_i, C_k)^2} 

.. math::  WCSS = \sqrt{\sum_{j=1}^k \sum_{i=1}^n{(x_j-c_i)^2}} 

Donde,

:math:`P_i`: puntos dentro de un Cluster.

:math:`C_k`: centroide del Cluster :math:`k`.

:math:`n`: cantidad de observaciones.

-  Se corre el algoritmo para diferentes :math:`k` clusters, por
   ejemplo, variando entre 1 y 10.

-  Para cada cluster calcular el WCSS.

-  Trazar una curva de WCSS con el número de clusters :math:`k`.

-  La ubicación de la curva (codo) se considera como un indicador
   apropiado para el agrupamiento.

Método de la silueta (Average silhouette method):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El método de la silueta es una técnica utilizada para determinar la
calidad del clustering y, por lo tanto, para ayudar a identificar el
número óptimo de clústeres. La análisis de silueta proporciona una
medida de cuán similares son los puntos dentro de un clúster en
comparación con los puntos de otros clústeres. La puntuación de la
silueta varía de -1 a 1:

-  Un valor cercano a 1 indica que los puntos están bien agrupados
   dentro de su clúster y alejados de otros clústeres.

-  Un valor cercano a 0 indica que los puntos están en el límite o
   superposición de dos clústeres.

-  Un valor negativo indica que los puntos pueden estar mal agrupados.

Para calcular la puntuación de la silueta, se utilizan dos valores para
cada punto:

:math:`a(i)`: La distancia promedio entre el punto :math:`i` y todos los
demás puntos del mismo clúster.

:math:`b(i)`: La distancia promedio entre el punto :math:`i` y todos los
puntos del clúster más cercano al que no pertenece.

La puntuación de la silueta para un punto :math:`i` se define como:

.. math::  s(i)= \frac{b(i)-a(i)}{máx(a(i),b(i))} 

Desventajas del K-Means:
~~~~~~~~~~~~~~~~~~~~~~~~

El algoritmo K-Means es ampliamente utilizado debido a su simplicidad y
eficiencia, pero también tiene varias desventajas y limitaciones que es
importante considerar. Aquí se detallan algunas de las principales
desventajas del K-Means:

**1. Número de Clústeres (K) predefinido:**

-  Requiere que el usuario especifique el número de clústeres :math:`k`
   de antemano. Elegir el valor correcto de :math:`k` puede ser
   complicado y a menudo requiere experimentación y validación.

**2. Sensibilidad a la inicialización:**

-  El resultado de K-Means puede depender fuertemente de la selección
   inicial de los centroides. Una mala inicialización puede llevar a una
   convergencia a mínimos locales subóptimos.

**3. Formas de Clústeres:**

-  Asume que los clústeres tienen una forma esférica y que todos los
   clústeres tienen aproximadamente el mismo tamaño. No maneja bien
   clústeres de formas irregulares o de tamaños muy diferentes.

**4. Sensibilidad a Outliers:**

-  Es sensible a los valores atípicos (outliers), ya que intenta
   minimizar la suma de las distancias al cuadrado. Los outliers pueden
   afectar significativamente la posición de los centroides.

**5. Dependencia de la escala de las variables:**

-  Las variables deben estar escaladas antes de aplicar K-Means, ya que
   las diferencias en las escalas pueden influir en la formación de los
   clústeres.

**6. Asignación forzosa a Clústeres:**

-  Cada punto de datos se asigna obligatoriamente a un clúster, lo que
   puede no ser adecuado para datos con puntos de datos ambiguos o con
   ruido significativo.

**7. Número fijo de iteraciones:**

-  Puede requerir un número fijo de iteraciones para converger, lo que
   puede ser computacionalmente costoso para conjuntos de datos grandes.

**8. No Garantiza el Óptimo Global:**

-  Puede converger a un mínimo local en lugar de al mínimo global, lo
   que significa que los resultados pueden no ser óptimos.
