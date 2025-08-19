Clustering
----------

El clustering (agrupamiento) es una técnica de aprendizaje no
supervisado que tiene como objetivo agrupar un conjunto de objetos de
tal manera que los objetos en el mismo grupo (o clúster) sean más
similares entre sí que los objetos de otros grupos. En el contexto de
las finanzas, el clustering se puede utilizar para identificar patrones
en datos de clientes, segmentar mercados, detectar fraudes, entre otras
aplicaciones.

Los modelos que realizan tareas de agrupamiento o clustering forman
parte del aprendizaje automático no supervisado. Estos modelos se
aplican a conjuntos de datos que no tienen etiquetas o clases
predefinidas, es decir, no tienen una variable de respuesta (:math:`y`).
Se entrenan sin ningún valor objetivo, aprendiendo únicamente de las
características inherentes de los datos y clasificándolos en uno o más
grupos. Este proceso no define ninguna etiqueta de clases; simplemente
separa las muestras basándose en sus diferencias.

.. figure:: Clustering.jpg
   :alt: Clustering

   Clustering

Tipos de Clustering:
~~~~~~~~~~~~~~~~~~~~

Existen varios métodos de clustering, entre los más populares se
encuentran:

**1. K-Means:**

K-Means es uno de los algoritmos de clustering más simples y populares.
Divide el conjunto de datos en :math:`K` clústeres predefinidos,
minimizando la varianza dentro de cada clúster. Los pasos principales
del algoritmo son:

1. Seleccionar :math:`K` puntos iniciales (centroides).

2. Asignar cada punto de los datos al clúster con el centroide más
   cercano.

3. Recalcular los centroides de los nuevos clústeres formados.

4. Repetir los pasos 2 y 3 hasta que los centroides no cambien
   significativamente.

**Ventajas:**

-  Fácil de implementar y entender.

-  Rápido para grandes conjuntos de datos.

**Desventajas:**

-  Necesita predefinir el número de clústeres (:math:`K`).

-  Sensible a la inicialización de los centroides.

-  No es adecuado para clústeres de formas irregulares.

**2. Clustering Jerárquico:**

El clustering jerárquico crea una jerarquía de clústeres utilizando un
enfoque aglomerativo (de abajo hacia arriba) o divisivo (de arriba hacia
abajo). El resultado se representa mediante un dendrograma.

**Enfoque Aglomerativo:**

1. Cada punto comienza como un clúster individual.

2. En cada paso, se combinan los dos clústeres más similares hasta que
   solo queda uno.

**Enfoque Divisivo:**

1. Todos los puntos comienzan en un solo clúster.

2. En cada paso, se divide el clúster más grande hasta que cada punto
   esté en su propio clúster.

**Ventajas:**

-  No requiere especificar el número de clústeres de antemano.

-  Proporciona una representación visual (dendrograma).

**Desventajas:**

-  Computacionalmente intensivo para grandes conjuntos de datos.

-  Las decisiones iniciales pueden tener un impacto significativo en el
   resultado final.

**3. DBSCAN (Density-Based Spatial Clustering of Applications with
Noise)**

DBSCAN es un algoritmo de clustering basado en densidad que puede
encontrar clústeres de forma arbitraria y manejar ruido (outliers). Se
basa en la idea de que un punto pertenece a un clúster si está lo
suficientemente cerca (en términos de densidad) de muchos otros puntos
del clúster.

**Ventajas:**

-  No necesita predefinir el número de clústeres.

-  Puede encontrar clústeres de formas arbitrarias.

-  Maneja outliers de manera efectiva.

**Desventajas:**

-  Puede ser difícil determinar los parámetros de densidad adecuados
   (:math:`\epsilon` y MinPts).

-  No funciona bien con datos de densidad variable.

Aplicaciones del Clustering en Finanzas:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El clustering tiene múltiples aplicaciones en el campo financiero, tales
como:

1. **Segmentación de Clientes**: Agrupar clientes con comportamientos
   similares para diseñar estrategias de marketing personalizadas.

2. **Detección de Fraude**: Identificar transacciones inusuales que
   podrían indicar actividades fraudulentas.

3. **Análisis de Riesgo de Crédito**: Clasificar a los prestatarios en
   diferentes categorías de riesgo.

4. **Gestión de Carteras**: Agrupar activos con comportamientos
   similares para diversificar riesgos y optimizar retornos.

Resumen
~~~~~~~

**K-Means** ``sklearn.cluster.KMeans``

+-----------------+-----------------+-----------------+-----------------+
| Argumento       | ¿Para qué       | Opciones /      | Lo clave        |
|                 | sirve?          | valores típicos |                 |
+=================+=================+=================+=================+
| ``n_clusters``  | Número de       | Entero ≥ 1      | Elegir con      |
|                 | clusters a      | (p. ej., 3, 5,  | criterios como  |
|                 | formar.         | 8).             | codo (inertia)  |
|                 |                 |                 | o               |
|                 |                 |                 | ``silhouette``. |
+-----------------+-----------------+-----------------+-----------------+
| ``init``        | Método para     | ``'k-means++'`` | ``'k-means++'`` |
|                 | inicializar     | (por defecto),  | suele converger |
|                 | centroides.     | ``'random'``    | más rápido y    |
|                 |                 |                 | estable.        |
+-----------------+-----------------+-----------------+-----------------+
| ``n_init``      | Repeticiones    | ``10``, ``20``, | Aumentarlo      |
|                 | con distintas   | ``'auto'``      | reduce riesgo   |
|                 | in              |                 | de mínimos      |
|                 | icializaciones. |                 | locales; fijar  |
|                 |                 |                 | para            |
|                 |                 |                 | re              |
|                 |                 |                 | producibilidad. |
+-----------------+-----------------+-----------------+-----------------+
| ``max_iter``    | Iteraciones     | Entero (p. ej., | Si no converge, |
|                 | máximas por     | 300).           | incrementar o   |
|                 | corrida.        |                 | revisar         |
|                 |                 |                 | escalado de     |
|                 |                 |                 | datos.          |
+-----------------+-----------------+-----------------+-----------------+
| ``tol``         | Tolerancia para | ``1e-4``,       | Controla cuándo |
|                 | criterio de     | ``1e-3``, etc.  | detener por     |
|                 | parada.         |                 | pequeños        |
|                 |                 |                 | cambios en      |
|                 |                 |                 | inercia.        |
+-----------------+-----------------+-----------------+-----------------+
| ``'ra           | Semilla de      | Entero (p. ej., | Fija resultados |
| ndom_state``\ ’ | aleatoriedad.   | 42).            | reproducibles.  |
+-----------------+-----------------+-----------------+-----------------+

**Notas clave K-Means:**

-  Escalar variables (p. ej., ``StandardScaler``) para que una dimensión
   no domine.

-  Sensible a outliers y a la forma (prefiere clusters esféricos).

-  Métricas comunes: **inercia**, **silhouette** para elegir
   ``n_clusters``.

**Clustering Jerárquico Aglomerativo**
``sklearn.cluster.AgglomerativeClustering``

+-----------------+-----------------+-----------------+-----------------+
| Argumento       | ¿Para qué       | Opciones /      | Lo clave        |
|                 | sirve?          | valores típicos |                 |
+=================+=================+=================+=================+
| ``n_clusters``  | Número de       | Entero ≥ 1.     | Alternativo a   |
|                 | clusters        |                 | ``dista         |
|                 | finales.        |                 | nce_threshold`` |
|                 |                 |                 | (no se usan     |
|                 |                 |                 | juntos).        |
+-----------------+-----------------+-----------------+-----------------+
| ``dista         | Umbral de       | Float (p. ej.,  | Si se usa,      |
| nce_threshold`` | distancia para  | 10.0).          | dejar           |
|                 | cortar el       |                 | ``n_            |
|                 | dendrograma.    |                 | clusters=None`` |
|                 |                 |                 | para            |
|                 |                 |                 | “descubrir” el  |
|                 |                 |                 | número de       |
|                 |                 |                 | clusters.       |
+-----------------+-----------------+-----------------+-----------------+
| ``linkage``     | Cómo se         | ``'ward'``,     | ``'ward'``      |
|                 | combinan        | ``'complete'``, | minimiza        |
|                 | clusters.       | ``'average'``,  | varianza        |
|                 |                 | ``'single'``.   | (requiere       |
|                 |                 |                 | métrica         |
|                 |                 |                 | euclídea);      |
|                 |                 |                 | ``'complete'``  |
|                 |                 |                 | más compacto;   |
|                 |                 |                 | ``'single'``    |
|                 |                 |                 | puede generar   |
|                 |                 |                 | e               |
|                 |                 |                 | ncadenamientos. |
+-----------------+-----------------+-----------------+-----------------+
| ``metric``      | Métrica de      | `               | Con             |
|                 | distancia.      | `'euclidean'``, | ``l             |
|                 |                 | `               | inkage='ward'`` |
|                 |                 | `'manhattan'``, | debe ser        |
|                 |                 | ``'cosine'``,   | `               |
|                 |                 | ``'l1'``,       | `'euclidean'``. |
|                 |                 | ``'l2'``, etc.  |                 |
+-----------------+-----------------+-----------------+-----------------+
| ``comp          | Fuerza calcular | ``'auto'``,     | Útil con        |
| ute_full_tree`` | árbol completo. | ``True``,       | ``dista         |
|                 |                 | ``False``.      | nce_threshold`` |
|                 |                 |                 | para cortes     |
|                 |                 |                 | precisos.       |
+-----------------+-----------------+-----------------+-----------------+
| ``comp          | Guarda          | ``True`` /      | Necesario para  |
| ute_distances`` | distancias      | ``False``.      | análisi         |
|                 | entre merges.   |                 | s/visualización |
|                 |                 |                 | posterior.      |
+-----------------+-----------------+-----------------+-----------------+

**Notas clave Jerárquico:**

-  Permite interpretar la estructura con **dendrogramas** (usar
   ``scipy`` para graficarlos).

-  No requiere fijar el número de clusters si se usa
   ``distance_threshold``.

-  Escalado recomendado si las variables están en magnitudes muy
   distintas.

**DBSCAN** ``sklearn.cluster.DBSCAN``

+-----------------+-----------------+-----------------+-----------------+
| Argumento       | ¿Para qué       | Opciones /      | Lo clave        |
|                 | sirve?          | valores típicos |                 |
+=================+=================+=================+=================+
| ``eps``         | Radio del       | Float (p. ej.,  | Parámetro más   |
|                 | vecindario.     | 0.3, 0.5).      | sensible        |
+-----------------+-----------------+-----------------+-----------------+
| ``min_samples`` | Mínimo de       | Entero (p. ej., | Regula densidad |
|                 | puntos para     | 5, 10).         | mínima; valores |
|                 | formar un       |                 | mayores →       |
|                 | núcleo.         |                 | clusters más    |
|                 |                 |                 | “densos”.       |
+-----------------+-----------------+-----------------+-----------------+
| ``metric``      | Métrica de      | ``'             | Consistente con |
|                 | distancia.      | euclidean``\ ‘, | la escala de    |
|                 |                 | `               | datos; escalar  |
|                 |                 | `'manhattan``’, | antes si        |
|                 |                 | ``'cosine'``,   | procede.        |
|                 |                 | ``'             |                 |
|                 |                 | minkowski``\ ’, |                 |
|                 |                 | etc.            |                 |
+-----------------+-----------------+-----------------+-----------------+
| ``p``           | Parámetro de    | ``1``           | Solo si         |
|                 | Minkowski.      | (Manhattan),    | ``metric        |
|                 |                 | ``2``           | ='minkowski'``. |
|                 |                 | (Euclídea).     |                 |
+-----------------+-----------------+-----------------+-----------------+
| ``n_jobs``      | Paralelización. | ``None`` o      | ``-1`` usa      |
|                 |                 | entero.         | todos los cores |
|                 |                 |                 | disponibles.    |
+-----------------+-----------------+-----------------+-----------------+

**Notas clave DBSCAN:**

-  No requiere ``n_clusters``; detecta **ruido** (``label = -1``) y
   clusters de **forma arbitraria**.

-  Muy **sensible a la escala**: aplicar escalado o normalización.

**K-Means:** Agrupa buscando que cada punto esté lo más cerca posible
del centro de su grupo.

**Clustering Jerárquico:** Es como armar familias de datos empezando de
individuos y uniéndolos poco a poco.

**DBSCAN:** Encuentra grupos donde hay mucha densidad de puntos y deja
fuera a los que están aislados.\*

**Forma de los clusters en cada método:**

**K-Means:**

-  Tiende a formar **clusters circulares o esféricos** (en 2D serían
   círculos, en 3D serían esferas).

-  Esto pasa porque usa distancias euclídeas al centro, por lo que asume
   que todos los puntos de un grupo están distribuidos de forma más o
   menos redonda alrededor de su centro.

-  Si los datos tienen formas alargadas o curvas, K-Means puede
   separarlos de forma poco natural.

**Clustering Jerárquico:**

-  La forma de los clusters depende del criterio de enlace
   (``linkage``).

-  Con ``ward`` tiende a formar clusters más compactos y cercanos a
   circulares.

-  Con ``single`` o ``complete`` puede generar **clusters alargados o
   irregulares**, adaptándose mejor a distintas formas.

-  Es más flexible que K-Means, pero no tan bueno como DBSCAN para
   formas muy complejas.

**DBSCAN:**

-  No asume forma circular.

-  Puede detectar **clusters de forma arbitraria**: alargados, curvos,
   en espiral, etc.

-  Muy útil cuando los datos tienen densidades diferentes o formas no
   regulares.

-  Sin embargo, puede fallar si los clusters tienen densidades muy
   distintas.

**Diferencia entre inercia y silueta:**

-  **Inercia**

   Imagina que cada grupo de puntos tiene un “imán” en el centro.

   La inercia mide **qué tan cerca están los puntos de su imán**.

   Cuanto más pequeña es la inercia, más juntos están los puntos dentro
   de cada grupo.

   *Es como medir qué tan apretado está un racimo de uvas.*

-  **Silueta**

   | Aquí no solo miramos lo cerca que están los puntos de su propio
     grupo, sino también **qué tan lejos están de otros grupos**.
   | La silueta combina ambas cosas:

   -  Alta → los puntos están muy cerca de su grupo y muy lejos de los
      otros.

   -  Baja o negativa → los puntos están confundidos entre grupos.

   *Es como medir si un racimo de uvas está bien separado de los otros
   racimos.*
