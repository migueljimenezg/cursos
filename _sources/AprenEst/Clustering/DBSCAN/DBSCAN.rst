DBSCAN
------

DBSCAN (Density-Based Spatial Clustering of Applications with Noise) es
un algoritmo de clustering basado en densidad. A diferencia de otros
métodos como K-means, DBSCAN no requiere que se especifique el número de
clusters a priori y puede identificar clusters de forma arbitraria y
puntos de ruido. Esto lo hace especialmente útil para conjuntos de datos
con estructuras complejas y ruido.

Conceptos clave:
~~~~~~~~~~~~~~~~

**1. Épsilon** (:math:`\epsilon`): La distancia máxima entre dos puntos
para que uno sea considerado vecino del otro.

**2. MinPts:** El número mínimo de puntos en el vecindario de un punto
para que sea considerado un punto central.

**3. Puntos centrales:** Puntos que tienen al menos MinPts puntos en su
vecindario dentro de una distancia :math:`\epsilon`.

**4. Puntos frontera:** Puntos que no son puntos centrales, pero están
dentro del vecindario de un punto central.

**5. Puntos de ruido:** Puntos que no son ni puntos centrales ni puntos
frontera.

Por defecto en ``sklearn.cluster``:

-  ``eps=0.5``: La distancia máxima entre dos muestras para que una sea
   considerada como vecina de la otra. Este es el parámetro más
   importante de DBSCAN.

-  ``min_samples=5``: El número de muestras (o peso total) en un
   vecindario para que un punto sea considerado como un punto central.
   Esto incluye el propio punto. Si se establece ``min_samples`` en un
   valor más alto, DBSCAN encontrará clusters más densos, mientras que
   si se establece en un valor más bajo, los clusters encontrados serán
   más dispersos.

-  ``metric='euclidean'``

Funcionamiento del algoritmo:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**1. Inicialización:** Para cada punto en el conjunto de datos, si ya ha
sido visitado, se salta al siguiente punto.

**2. Vecindario:** Para cada punto no visitado, se encuentra su
vecindario usando la distancia :math:`\epsilon`.

**3. Expansión de clúster:** Si el punto es un punto central (tiene al
menos MinPts puntos en su vecindario), se crea un nuevo clúster y se
expande agregando sus puntos vecinos. Si no es un punto central, se
marca como ruido (esto puede cambiar si más tarde se encuentra que es un
punto frontera de otro clúster).

**4. Repetición:** Se repiten los pasos anteriores hasta que todos los
puntos hayan sido visitados.

Número de clusters adecuados:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Determinar si el número de clusters identificado por DBSCAN es adecuado
puede ser un desafío, ya que DBSCAN no requiere que especifiques el
número de clusters a priori. Sin embargo, hay varios enfoques que puedes
usar para evaluar la calidad de los clusters encontrados por DBSCAN:

**1. Visualización:**

La visualización es una herramienta poderosa para evaluar la calidad de
los clusters. Si los datos son de baja dimensión (2D o 3D), puedes
graficar los clusters y observar si los puntos dentro de cada cluster
están bien separados de los otros clusters y si los puntos de ruido
están adecuadamente identificados.

**2. Método de la Silueta:**

El índice de silueta es una medida de cuán similares son los puntos
dentro de un mismo cluster en comparación con puntos de otros clusters.
Los valores de silueta van de -1 a 1, donde un valor alto indica que los
puntos están bien agrupados.

**3. Número de clusters y puntos de ruido:**

Puedes evaluar el número de clusters y puntos de ruido. En general, si
DBSCAN encuentra muchos puntos de ruido, es posible que los parámetros
``eps`` y ``min_samples`` necesiten ajuste.

Ventajas y Desventajas:
~~~~~~~~~~~~~~~~~~~~~~~

**Ventajas:**

-  No requiere especificar el número de clusters a priori.

-  Puede encontrar clusters de forma arbitraria.

-  Identifica puntos de ruido.

-  Funciona bien con clusters de alta densidad separados por regiones de
   baja densidad.

**Desventajas:**

-  El rendimiento puede degradarse con conjuntos de datos de alta
   dimensión.

-  El ajuste de los parámetros :math:`\epsilon` y MinPts puede ser
   difícil y específico del conjunto de datos.

-  No funciona bien con clusters de densidad variable.
