Clasificación
-------------

Clasificación en Aprendizaje Estadístico
----------------------------------------

La **clasificación** es una de las tareas fundamentales en el campo del
*Machine Learning* y la estadística, con aplicaciones directas en el
ámbito financiero.

Su objetivo es **predecir la clase o categoría** a la que pertenece una
observación, en función de sus características (variables o *features*).

Se enmarca dentro del **aprendizaje supervisado**, ya que el algoritmo
aprende a partir de un conjunto de datos etiquetados.

--------------

Tipos de clasificación
~~~~~~~~~~~~~~~~~~~~~~

**1. Clasificación Binaria**

-  **Definición:** consiste en asignar una de dos posibles categorías.

-  **Ejemplos en finanzas:**

   -  Determinar si un préstamo será pagado o caerá en *default*.

   -  Predecir si el precio de una acción subirá o bajará.

**2. Clasificación Multiclase**

-  **Definición:** el objetivo es predecir una clase entre tres o más
   categorías mutuamente excluyentes.

-  **Ejemplos en finanzas:**

   -  Clasificar el riesgo crediticio en bajo, medio o alto.

   -  Identificar el sector económico de una empresa (tecnología, salud,
      energía, finanzas).

**3. Clasificación Multietiqueta**

-  **Definición:** cada observación puede pertenecer a varias clases
   simultáneamente.

-  **Ejemplos en finanzas:**

   -  Etiquetar transacciones financieras con múltiples categorías de
      fraude.

   -  Asignar diferentes tipos de riesgo a un portafolio (riesgo de
      mercado, liquidez, crédito).

--------------

Algoritmos de clasificación
~~~~~~~~~~~~~~~~~~~~~~~~~~~

A continuación, se presentan los algoritmos más relevantes, con sus
ventajas, limitaciones y aplicaciones en finanzas.

**1. Regresión Logística**

-  **Descripción:** modelo estadístico que estima la probabilidad de
   pertenencia a una clase binaria utilizando la función logística
   (sigmoide).

-  **Ventajas:**

   -  Simple y fácil de interpretar.

   -  Rápido de entrenar.

   -  Adecuado para *scoring* de riesgo crediticio o predicción de
      impago.

-  **Desventajas:**

   -  Supone relación lineal entre las variables independientes y el
      logit.

   -  Tiene dificultades para capturar relaciones no lineales complejas.

--------------

**2. Árboles de Decisión**

-  **Descripción:** dividen los datos en subconjuntos mediante reglas
   condicionales, formando una estructura de árbol.

-  **Ventajas:**

   -  Muy interpretables y fáciles de visualizar.

   -  Manejan bien variables categóricas y continuas.

   -  Aplicables en evaluación crediticia o segmentación de clientes.

-  **Desventajas:**

   -  Alta propensión al *overfitting*.

   -  Sensibles a pequeñas variaciones en los datos.

--------------

**3. Máquinas de Vectores de Soporte (SVM)**

-  **Descripción:** buscan el hiperplano óptimo que maximiza la
   separación entre clases en el espacio de características.

-  **Ventajas:**

   -  Eficaces en espacios de alta dimensión.

   -  Funcionan bien con una clara separación de clases.

   -  Útiles en la detección de fraudes financieros.

-  **Desventajas:**

   -  Poco intuitivos y difíciles de interpretar.

   -  Dependen fuertemente del kernel y de la correcta elección de
      parámetros.

--------------

**4. Redes Neuronales Artificiales (RNA)**

-  **Descripción:** modelos inspirados en el cerebro humano, capaces de
   aprender representaciones complejas de los datos.

-  **Ventajas:**

   -  Capturan relaciones no lineales sofisticadas.

   -  Flexibles y muy potentes.

   -  Útiles en predicción de series financieras, clasificación de
      imágenes (cheques, facturas) o *trading algorítmico*.

-  **Desventajas:**

   -  Requieren gran cantidad de datos y recursos computacionales.

   -  Dificultad de interpretación (cajas negras).

--------------

Comparación de algoritmos de clasificación
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+---------------+---------+--------------+-----------------+----------+
| Algoritmo     | Int     | Complejidad  | Capacidad para  | Ejemplo  |
|               | erpreta | C            | No Linealidades | en       |
|               | bilidad | omputacional |                 | Finanzas |
+===============+=========+==============+=================+==========+
| **Regresión   | Alta    | Baja         | Baja            | Scoring  |
| Logística**   |         |              |                 | de       |
|               |         |              |                 | riesgo   |
|               |         |              |                 | cr       |
|               |         |              |                 | editicio |
+---------------+---------+--------------+-----------------+----------+
| **Árboles de  | Alta    | Media        | Media           | Ev       |
| Decisión**    |         |              |                 | aluación |
|               |         |              |                 | de       |
|               |         |              |                 | p        |
|               |         |              |                 | réstamos |
+---------------+---------+--------------+-----------------+----------+
| **SVM**       | Media   | Alta         | Alta            | D        |
|               |         |              |                 | etección |
|               |         |              |                 | de       |
|               |         |              |                 | fraudes  |
+---------------+---------+--------------+-----------------+----------+
| **Redes       | Baja    | Muy alta     | Muy alta        | Pr       |
| Neuronales**  |         |              |                 | edicción |
|               |         |              |                 | de       |
|               |         |              |                 | precios  |
|               |         |              |                 | de       |
|               |         |              |                 | activos  |
+---------------+---------+--------------+-----------------+----------+

--------------

Métricas de evaluación en clasificación
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  **Exactitud (Accuracy):** proporción de observaciones clasificadas
   correctamente.

-  **Precisión (Precision):** proporción de verdaderos positivos sobre
   los predichos como positivos.

-  **Recall o Sensibilidad:** proporción de verdaderos positivos sobre
   el total de positivos reales.

-  **F1-Score:** media armónica entre precisión y recall, útil en datos
   desbalanceados.

-  **Matriz de confusión:** tabla que resume los aciertos y errores de
   clasificación.

-  **ROC y AUC:** evalúan el desempeño del clasificador en diferentes
   umbrales de decisión.
