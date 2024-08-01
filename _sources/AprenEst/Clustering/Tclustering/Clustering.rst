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
