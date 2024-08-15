Árboles de decisión para regresión
----------------------------------

La regresión con árboles de decisión es un método de aprendizaje
supervisado utilizado para predecir un valor continuo. Al igual que los
árboles de decisión para clasificación, este modelo divide los datos en
subconjuntos más pequeños en función de decisiones o divisiones en los
atributos. Sin embargo, **en lugar de asignar una clase a cada hoja, el
árbol de decisión para regresión predice un valor numérico.**

Cómo funciona la regresión con árboles de decisión:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**1. División recursiva de los datos:**

-  El proceso comienza con todo el conjunto de datos en la raíz del
   árbol.

-  Se elige la característica y el punto de división que minimizan el
   error de predicción (por ejemplo, el error cuadrático medio, MSE).

-  El conjunto de datos se divide en dos subconjuntos en función de esta
   división.

-  Este proceso se repite recursivamente para cada subconjunto, creando
   ramas en el árbol hasta cumplir con algún criterio de parada (como
   una profundidad máxima del árbol ``max_depth`` o un número mínimo de
   muestras en una hoja ``min_samples_split``).

**2. Cálculo del valor predicho en las hojas:**

-  Una vez que se alcanzan los nodos hoja (donde ya no se realiza más
   división), el valor predicho es la media de los valores de la
   variable objetivo en ese nodo.

-  Este valor es lo que el modelo utiliza como la predicción para
   cualquier nuevo dato que llegue a ese nodo.

**3. Criterios de división:**

-  Para seleccionar la mejor división en cada nodo, se utilizan
   criterios como la reducción de varianza. La idea es elegir la
   división que minimice la suma de las varianzas dentro de los dos
   subconjuntos resultantes.

-  Matemáticamente, se busca minimizar el error cuadrático medio (MSE),
   que es la suma de las diferencias al cuadrado entre los valores
   reales y la media en cada nodo.

**4. Poda del árbol (opcional):**

-  Después de construir el árbol, a menudo se realiza una poda para
   evitar el sobreajuste. La poda implica eliminar ramas que tienen poco
   impacto en la predicción para simplificar el modelo y mejorar su
   capacidad de generalización.

Ventajas:
~~~~~~~~~

-  **Interpretabilidad:** Los árboles de decisión son fáciles de
   interpretar y visualizar.

-  **Manejo de variables categóricas y numéricas:** Puede manejar tanto
   variables categóricas como numéricas sin requerir preprocesamiento.

-  **No requiere escalado:** No es necesario escalar las
   características.

-  **Captura de no linealidades:** Los árboles de decisión pueden
   capturar relaciones no lineales entre las características y la
   variable objetivo.

Desventajas:
~~~~~~~~~~~~

-  **Sobreajuste:** Los árboles de decisión tienden a sobreajustar los
   datos si no se podan o si no se limita la profundidad del árbol.

-  **Sensibilidad a los datos:** Pequeños cambios en los datos pueden
   llevar a la creación de árboles completamente diferentes, lo que los
   hace menos robustos.

-  **Poco eficientes para datos muy grandes:** Los árboles de decisión
   pueden volverse ineficientes en conjuntos de datos muy grandes o con
   muchas características.
