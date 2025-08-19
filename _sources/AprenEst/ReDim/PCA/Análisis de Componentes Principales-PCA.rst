Análisis de Componentes Principales-PCA
---------------------------------------

El Análisis de Componentes Principales (PCA, por sus siglas en inglés)
es una técnica estadística que permite reducir la cantidad de variables
en un conjunto de datos, conservando al mismo tiempo la mayor cantidad
de información posible. Esta reducción se logra identificando nuevas
variables llamadas **componentes principales**, que son combinaciones
lineales de las variables originales.

**¿Para qué sirve PCA?**

-  Simplificar conjuntos de datos con muchas variables.

-  Visualizar datos en 2D o 3D aunque el conjunto tenga muchas
   dimensiones.

-  Eliminar redundancia si las variables están correlacionadas.

-  Preprocesar datos antes de aplicar otros algoritmos de aprendizaje
   automático.

**¿Qué hace exactamente PCA?**

1. **Centra los datos**: se resta la media de cada variable para que
   todas estén centradas en 0.

2. **Calcula la matriz de covarianzas**: esta matriz describe cómo
   varían conjuntamente las variables.

3. **Obtiene los autovalores y autovectores**: los autovectores son las
   nuevas direcciones (componentes), y los autovalores indican cuánta
   varianza captura cada uno.

4. **Ordena las componentes**: se seleccionan los componentes con mayor
   varianza explicada.

5. **Proyecta los datos** sobre estas nuevas direcciones principales.

**¿Qué representa cada componente principal?**

-  **PC1 (Primer componente principal)**: la dirección en la que los
   datos tienen la mayor varianza posible.

-  **PC2**: la siguiente dirección ortogonal a PC1 que captura la mayor
   varianza restante, y así sucesivamente.

**¿Por qué es importante escalar los datos antes de aplicar PCA?**

PCA depende directamente de la varianza. Si una variable tiene valores
mucho más grandes que otras, dominará el análisis aunque no sea la más
relevante. Para evitarlo, es necesario escalar las variables:

-  **Estandarización (z-score)**: centra en media 0 y varianza 1. Muy
   recomendada para PCA.

-  **Normalización Min-Max**: ajusta todas las variables al rango
   :math:`[0, 1]`. Útil en algunos casos, pero puede distorsionar la
   varianza relativa.

**Resultado final de PCA:**

-  Nuevas variables (componentes principales) que no están
   correlacionadas.

-  Cada componente explica un porcentaje de la varianza total.

-  Se pueden usar los primeros componentes para trabajar con menos
   dimensiones, acelerando modelos y facilitando visualización.

.. figure:: Componentes.png
   :alt: Componentes

   Componentes

.. figure:: PCA_1.gif
   :alt: PCA_1

   PCA_1

.. figure:: PCA_2.gif
   :alt: PCA_2

   PCA_2

Los Componentes Principales son los Eigenvectores de la matriz de
varianzas-covarianzas de las variables originales y se convertirán en
los nuevos ejes. El ángulo entre los Eigenvectores es de 90°, así que
los Eigenvectores son ortogonales entre sí.

La matriz de varianzas-covarianzas es simétrica, del orden :math:`nxn`,
las varianzas, :math:`(\sigma^2_{ij})`, de cada variable están en la
diagonal de la matriz, los demás valores son las covarianzas,
:math:`(\sigma_{ij})`.

.. math::

    \sum = \begin{bmatrix} \sigma^2_{11} & \sigma_{12} & ... & \sigma_{1p} \\ \sigma_{21} & \sigma^2_{22} & ... & \sigma_{2p} \\ ... & ... & ... & ... 
   \\ \sigma_{n1} & \sigma^2_{n2} & ... & \sigma_{np} \end{bmatrix} 

Para :math:`p` variables, se extraen :math:`p` Eigenvectores y :math:`p`
Eigenvalores. Estos Eigenvectores son las Componentes Principales y el
Eigenvector asociado a cada Componente Principal es la proporción de la
varianza total que ese componente puede explicar.

En el ACP no se generan variables nuevas, sino que se transforman en
nuevas combinaciones lineales. Por lo anterior, la varianza total de las
variables originales sigue siendo la misma.

Técnicamente, PCA implica la rotación del sistema de coordenadas
original a un nuevo sistema de coordenadas con propiedades estadísticas
deseables. Más precisamente, se busca definir una transformación
ortogonal a una matriz de covarianza diagonal. Computacionalmente, PCA
se reduce a resolver los valores propios y los vectores propios de una
matriz definida positiva mediante un proceso generalmente denominado
análisis de valores propios o descomposición espectral.

Este proceso de extracción de características se utiliza tanto para
optimizar el espacio de almacenamiento y la eficiencia computacional del
algoritmo de aprendizaje, como para mejorar el rendimiento predictivo al
reducir la *maldición de la dimensionalidad.*

Ejemplo:
~~~~~~~~

Supongamos la siguiente matriz de varianzas-covarianzas de un conjunto
de dos variables:

.. math::  \sum = \begin{bmatrix} 0,00761 & 0,00331\\ 0,00331 & 0,00840 \end{bmatrix} 

La varianza de la variable 1 es igual a 0,00761 y la varianza de la
variable 2 es 0,00840. La sumatoria de la varianza del conjunto de datos
es de 0,01601 :math:`(0,00761+0,00840)`.

Eigenvalores:
~~~~~~~~~~~~~

**Eigenvalores** :math:`\lambda_i`: varianzas de cada Componente.

.. math::  \lambda_1 = 0,0113385 

.. math::  \lambda_2 = 0,00467151 

El Componente Principal 1 es el más importante porque es el de mayor
Eigenvalor. Los Eigenvalores son las varianzas de cada Componente
Principal y la suma de los Eigenvalores es la suma de las varianzas de
las variables originales, es decir, es la varianza total, la cual es
0,01601 :math:`(0,0113385+0,00467151)`.

El Componente Principal 1 explica el 70,82% de la variabilidad total.
Recuerde que la sumatoria de los :math:`\lambda` es igual a la sumatoria
de las varianzas de las variables. El analista puede decidir en trabajar
solo con esta Componente y así se reduciría la dimensionalidad de los
datos. Este es el objetivo del ACP, **encontrar la menor cantidad de
componentes posibles que puedan explicar la mayor parte de la variación
original.** En otras palabras, con el ACP se busca representar la
:math:`p` variables en un número menor de variables (Componentes)
conformadas como **combinaciones lineales** de las originales y perder
la menor cantidad de información.

Al aplicar el ACP, las variables originales correlacionadas se
transforman en variables no correlacionadas.

-  **Proporción de la varianza de la Componente Principal 1:**

.. math::  \frac{\lambda_1}{\sum{\lambda_i}} = \frac{0,0113385}{0,0113385+0,00467151} = 0,7082 

-  **Proporción de la varianza de la Componente Principal 2:**

.. math::  \frac{\lambda_2}{\sum{\lambda_i}} = \frac{0,00467151}{0,0113385+0,00467151} = 0,2918 

Como la desviación estándar es la raíz cuadrada de la varianza, cada
Componente Principal tiene la siguiente desviación estándar.

-  **Desviación estándar Componente Principal 1:**

.. math::  \sqrt{\lambda_1} = \sqrt{0,0113385}  = 0,1065 

-  **Desviación estándar Componente Principal 2:**

.. math::  \sqrt{\lambda_2} = \sqrt{0,00467151}  = 0,0683 

Eigenvectores:
~~~~~~~~~~~~~~

**Eigenvectores:** Cargas de cada Componente.

.. math::  Eigenvector_1 = \begin{bmatrix} 0,6638921 \\ 0,7478284 \end{bmatrix} 

.. math::  Eigenvector_2 = \begin{bmatrix} -0,7478284 \\ 0,6638921 \end{bmatrix} 

Las cargas de un Componente Principal son los elementos del vector
propio que forman la componente. Cada componente es una combinación
lineal de las variables del conjunto de datos.

El primer elemento de :math:`Eigenvector_1` es 0,6638921, esta es la
carga o *score* para la primera variable original. El segundo elemento
es la carga que se le asigna a la segunda variable de la base de datos.

A la matriz que se conforma con los Eigenvectores se llama matriz de
rotación.

Cada vector propio debe tener una longitud igual a 1,0. Esto se
comprueba si la suma de cada elemento (cargas) al cuadrado es igual a
1,0. Esta condición es una restricción del modelo porque con el valor de
1,0 las varianzas no se modifican.

Significado de las cargas:
~~~~~~~~~~~~~~~~~~~~~~~~~~

Las cargas, también conocidas como “loadings” en inglés, son los
coeficientes que indican la contribución de cada variable original a una
componente principal. En otras palabras, las cargas representan la
correlación entre las variables originales y las componentes
principales.

Las cargas indican cómo se combinan las variables originales para formar
los nuevos componentes principales.

**Interpretación de las cargas:**

-  Una **carga alta (en valor absoluto)** indica que esa variable
   contribuye fuertemente al componente.

-  Una **carga cercana a cero** sugiere que la variable tiene poca
   influencia en ese componente.

-  El **signo** de la carga (positivo o negativo) indica la dirección en
   la que influye la variable.

Las cargas son esenciales para comprender e interpretar los resultados
de PCA, ya que proporcionan una conexión directa entre las variables
originales y las componentes principales.

Biplot:
~~~~~~~

Un biplot es una combinación de un scatter plot de las puntuaciones de
las componentes principales y una visualización de las cargas
(coeficientes) de las variables originales. Esto ayuda a interpretar
cómo las variables originales contribuyen a las componentes principales.

Esto permite:

-  Visualizar cómo se agrupan las observaciones en el nuevo espacio
   reducido.

-  Ver qué variables están asociadas entre sí y con cada componente.

-  Identificar la dirección de mayor varianza para cada variable.

**¿Cómo se interpreta un biplot?**

-  Las observaciones (puntos) que estén cerca entre sí están
   relacionadas.

-  Las flechas (variables) que apunten en la misma dirección están
   **positivamente correlacionadas**.

-  Flechas ortogonales indican **variables no correlacionadas**.

-  Flechas en direcciones opuestas implican **correlación negativa**.

-  La **longitud de la flecha** indica qué tanto influye esa variable en
   el plano representado (PC1 vs. PC2).

**Importante:** El biplot es más informativo cuando los dos primeros
componentes explican un alto porcentaje de la varianza total, ya que de
lo contrario la proyección puede ser distorsionada.

En resumen, las **cargas** permiten entender qué está midiendo cada
componente, y el **biplot** es una herramienta visual poderosa para
interpretar conjuntamente individuos y variables en el espacio reducido
generado por PCA.

.. figure:: Biplot.JPG
   :alt: Biplot

   Biplot

Unidades de las variables:
~~~~~~~~~~~~~~~~~~~~~~~~~~

Cuando se tienen variables con magnitudes grandes y otras pequeñas, se
tiene un problema porque las variables de magnitud mayor van a
predominar en la reducción de dimensionalidad y además, estas variables
tienen mayor varianza. También, la covarianza entre las variables será
mayor por la magnitud, siendo esto en muchos casos un resultado errado
porque la covarianza estaría afectada por las unidades de las variables
con unidades mayores y no por el co-movimiento.

Para solucionar esto tenemos dos opciones:

**1. Cambio de escala de las variables:**

**2. Matriz de correlaciones:** realizar el ACP sobre la matriz de
coeficientes de correlación en lugar de la matriz de
varianzas-covarianzas.

.. math::

    \sum = \begin{bmatrix} \rho_{11} & \rho_{12} & ... & \rho_{1p} \\ \rho_{21} & \rho_{22} & ... & \rho_{2p} \\ ... & ... & ... & ... 
   \\ \rho_{n1} & \rho_{n2} & ... & \rho_{np} \end{bmatrix} 

Como la diagonal tiene valores de 1,0, la suma de la diagonal es igual a
:math:`p`, cantidad de variables.

Elegir el número correcto de dimensiones:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

En lugar de elegir arbitrariamente el número de dimensiones a reducir,
es más sencillo elegir el número de dimensiones que sumen una porción
suficientemente grande de la varianza (por ejemplo, el 80% o 95%). A
menos que, por supuesto, estés reduciendo la dimensionalidad para la
visualización de datos, en cuyo caso querrás reducir la dimensionalidad
a 2 o 3.

Para esto se puede generar un gráfico que muestre la varianza explicada
acumulada en función del número de componentes principales. La línea en
el gráfico muestra cómo la varianza explicada se acumula a medida que se
agregan más componentes principales. Al inicio, la varianza explicada
aumenta rápidamente, lo que indica que las primeras componentes capturan
la mayor parte de la variabilidad en los datos.

En muchos casos, hay un “punto de codo” en el gráfico donde la tasa de
aumento de la varianza explicada se reduce significativamente. Este
punto puede ser útil para determinar el número óptimo de componentes
principales a utilizar, ya que más allá de este punto, agregar más
componentes no proporciona una ganancia significativa en la varianza
explicada.

.. figure:: Codo.JPG
   :alt: Codo

   Codo

Pruebas:
~~~~~~~~

La suma de las cargas de cada componente al cuadrado debe ser igual a
1,0:

Si los vectores son ortogonales, entonces el producto escalar de los
vectores es igual a cero:

:math:`\sum{\lambda_i} = \sum{var_i}`: la suma de las varianzas de las
variables es igual a la suma de los Eigenvalores.
