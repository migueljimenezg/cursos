Optimización de Hiperparámetros
-------------------------------

La **Optimización de Hiperparámetros** es un proceso fundamental en el
desarrollo de modelos de aprendizaje automático. Los hiperparámetros son
configuraciones externas al modelo que no se aprenden directamente a
partir de los datos durante el entrenamiento, sino que se establecen
antes de comenzar el proceso de aprendizaje. Elegir los valores
correctos de estos hiperparámetros puede tener un impacto significativo
en el rendimiento del modelo.

Conceptos clave:
~~~~~~~~~~~~~~~~

**1. Hiperparámetros vs. Parámetros:**

-  **Parámetros:** Son valores que el modelo aprende durante el
   entrenamiento, como los pesos en una regresión lineal o los
   coeficientes de los nodos en una red neuronal.

-  **Hiperparámetros:** Son configuraciones que deben definirse antes
   del entrenamiento, como la tasa de aprendizaje en un algoritmo de
   optimización, el número de árboles en un bosque aleatorio, o el valor
   de C en una máquina de soporte vectorial (SVM).

**2. Importancia de la Optimización:**

-  La elección de los hiperparámetros afecta la capacidad del modelo
   para aprender de los datos, su rendimiento en datos no vistos
   (generalización) y su susceptibilidad a sobreajuste o subajuste.

-  Un mal ajuste de los hiperparámetros puede llevar a un rendimiento
   subóptimo, independientemente de la cantidad y calidad de los datos.

Técnicas de Optimización de Hiperparámetros:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**1. Búsqueda en Malla (Grid Search):**

-  **Cómo funciona:** Grid Search es un método exhaustivo que prueba
   todas las combinaciones posibles de un conjunto definido de
   hiperparámetros. Se especifica un conjunto de valores para cada
   hiperparámetro y el modelo se entrena con cada combinación. Solo
   necesita indicarle qué hiperparámetros deseas que experimente y qué
   valores probar, y utilizará la **validación cruzada** para evaluar
   todas las combinaciones posibles de valores de hiperparámetros

-  **Ventaja:** Asegura que se prueban todas las combinaciones posibles.

-  **Desventaja:** Puede ser computacionalmente costoso, especialmente
   si hay muchos hiperparámetros y valores posibles.

**2. Búsqueda Aleatoria (Random Search):**

-  **Cómo funciona:** A diferencia de Grid Search, Random Search no
   prueba todas las combinaciones posibles. En su lugar, selecciona de
   manera aleatoria combinaciones de hiperparámetros dentro de los
   rangos definidos.

-  **Ventaja:** Es menos costoso en términos computacionales y puede
   encontrar combinaciones prometedoras en menos tiempo.

-  **Desventaja:** No garantiza encontrar la mejor combinación posible,
   pero es útil cuando se tiene un presupuesto computacional limitado.

.. figure:: Hyperparameter_tuning.JPG
   :alt: Hyperparameter_tuning

   Hyperparameter_tuning

**Consideraciones importantes:**

-  **Validación Cruzada:** Al optimizar hiperparámetros, es esencial
   usar validación cruzada para asegurarse de que el modelo no se
   sobreajuste a un subconjunto específico de datos.

-  **Tiempo computacional:** La optimización de hiperparámetros puede
   ser intensiva en recursos. Es importante balancear la búsqueda del
   mejor modelo con el tiempo y recursos disponibles.

-  **Combinaciones efectivas:** No todos los hiperparámetros tienen el
   mismo impacto en el rendimiento del modelo. A menudo, es útil hacer
   una búsqueda preliminar con Random Search antes de aplicar Grid
   Search para refinar la búsqueda en un espacio más pequeño.

Cuando no tenemos idea de qué valor debería tener un hiperparámetro, un
enfoque simple es probar potencias consecutivas de 10 (o un número menor
si deseas una búsqueda más detallada)

Métricas de error:
~~~~~~~~~~~~~~~~~~

**Problemas de clasificación:**

Para problemas de clasificación, puedes utilizar las siguientes
opciones:

-  ``accuracy:`` Precisión (proporción de predicciones correctas).

-  ``balanced_accuracy:`` Precisión equilibrada, que ajusta el
   desequilibrio de clases.

-  ``f1:`` Puntaje F1 (balance entre precisión y recall).

-  ``precision:`` Precisión de las predicciones.

-  ``recall:`` Tasa de aciertos (recall).

-  ``roc_auc:`` Área bajo la curva ROC (ideal para problemas de
   clasificación binaria).

-  ``average_precision:`` Precisión promedio.

-  ``log_loss:`` Logarithmic loss (debe minimizarse).

**Problemas de regresión:**

Para problemas de regresión, puedes utilizar las siguientes opciones:

-  ``neg_mean_absolute_error:`` Error absoluto medio (MAE) negativo.
   Cuanto más cercano a 0, mejor.

-  ``neg_mean_squared_error:`` Error cuadrático medio (MSE) negativo.
   Cuanto más cercano a 0, mejor..

-  ``neg_root_mean_squared_error:`` Raíz cuadrada del error cuadrático
   medio (RMSE) negativo.

-  ``neg_median_absolute_error:`` Error absoluto mediano negativo.

-  ``r2:`` Coeficiente de determinación (:math:`R^2`). Cuanto más
   cercano a 1, mejor.

Las métricas que comienzan con ``neg_`` son negativas porque
scikit-learn siempre maximiza las métricas. Por lo tanto, las métricas
de error (que deben minimizarse) se expresan en forma negativa.
