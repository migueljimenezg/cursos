Métricas para Evaluación de Modelos de Clasificación
----------------------------------------------------

En la evaluación de modelos de clasificación, es fundamental utilizar
métricas adecuadas que reflejen con precisión el rendimiento del modelo.
A continuación, se presentan algunas de las métricas más importantes y
comúnmente utilizadas para evaluar modelos de clasificación.

1. Matriz de Confusión (Confusion Matrix):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La matriz de confusión es una tabla que muestra las predicciones del
modelo frente a las clases reales, proporcionando una visión detallada
del rendimiento del modelo.

Para calcular la matriz de confusión, primero se necesita tener un
conjunto de predicciones que puedan ser comparadas con los objetivos
reales.

================= ================= =================
\                 Predicho Positivo Predicho Negativo
================= ================= =================
**Real Positivo** TP                FN
**Real Negativo** FP                TN
================= ================= =================

Donde:

-  :math:`TP` son los verdaderos positivos (True Positives)
   **(correcto)**. La clase es positiva (clase 1) y el clasificador la
   reconoce correctamente como tal (verdadero positivo).

-  :math:`TN` son los verdaderos negativos (True Negatives)
   **(correcto)**. La clase es negativa (clase 0) y el clasificador la
   reconoce correctamente como tal (verdadero negativo).

-  :math:`FP` son los falsos positivos (False Positives) **(mal
   clasificado)**. La clase es negativa, pero el clasificador la
   etiqueta como positiva (falso positivo). Es un 0 clasificado como 1.

-  :math:`FN` on los falsos negativos (False Negatives) **(mal
   clasificado)**. La clase es positiva, pero el clasificador la
   etiqueta como negativa (falso negativo). Es un 1 clasificado como 0.

Cada fila en una matriz de confusión representa una clase real, mientras
que cada columna representa una clase predicha.

Un clasificador perfecto solo tendría verdaderos positivos y verdaderos
negativos, por lo que su matriz de confusión tendría valores distintos
de cero solo en su diagonal principal (de la esquina superior izquierda
a la esquina inferior derecha).

``confusion_matrix`` de ``scikit-learn``:

================= ================= =================
\                 Predicho Negativo Predicho Positivo
================= ================= =================
**Real Negativo** TN                FP
**Real Positivo** FN                TP
================= ================= =================

.. figure:: MatrizConfusion.JPG
   :alt: MatrizConfusion

   MatrizConfusion

.. figure:: MatrizConfusion2.JPG
   :alt: MatrizConfusion2

   MatrizConfusion2

1. Exactitud (Accuracy):
~~~~~~~~~~~~~~~~~~~~~~~~

La exactitud es la proporción de predicciones correctas realizadas por
el modelo sobre el total de predicciones. Es la métrica más sencilla,
pero puede ser engañosa si las clases están desbalanceadas.

.. math::  Accuracy = \frac{Número de predicciones correctas}{Número total de predicciones}=\frac{TP+TN}{TP+TN+FP + FN} 

La **tasa de error de un clasificador (E)** es la frecuencia de errores
cometidos por el clasificador sobre un conjunto dado, es decir, la tasa
de error es 1 menos Accuracy.

.. math::  E = \frac{FP + FN}{TP+TN+FP + FN} = 1 - Accuracy 

2. Precisión (Precision):
~~~~~~~~~~~~~~~~~~~~~~~~~

La precisión es la proporción de verdaderos positivos entre el total de
predicciones positivas. Indica qué tan preciso es el modelo al predecir
la clase positiva. En otras palabras, la precisión mide la exactitud de
las predicciones positivas realizadas por el modelo.

.. math::  precision = \frac{TP}{TP + FP} 

Donde:

-  :math:`TP` son los verdaderos positivos (True Positives)

-  :math:`FP` son los falsos positivos (False Positives)

La precisión se utiliza típicamente junto con otra métrica llamada
recall, también conocida como sensibilidad o tasa de verdaderos
positivos (TPR).

3. Recall (True Positive Rate) o Sensibilidad :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

También es llamada Tasa de Verdaderos Positivos (TPR).

La sensibilidad o recall es la proporción de verdaderos positivos entre
el total de positivos reales. Mide la capacidad del modelo para
identificar correctamente las instancias de la clase positiva.

.. math::  recall = \frac{TP}{TP + FN} 

Donde:

-  :math:`FN` son los falsos negativos (False Negatives)

Ejemplo:

:math:`Precision = 0,72` y :math:`recall = 0,75`, el modelo es correcto
el 72% del tiempo, pero detecta solo el 75% de los valores de la
clasificación.

A menudo es conveniente combinar la precisión y el recall en una sola
métrica llamada F score, especialmente si necesitas una forma sencilla
de comparar dos clasificadores. El F score es la media armónica de la
precisión y el recall.

**Ejemplos de aplicación para alto recall**

-  **Detección de Fraude:** Si estás desarrollando un sistema para
   detectar fraudes en transacciones financieras, podrías preferir un
   alto recall. Es decir, quieres capturar todos los casos posibles de
   fraude, incluso si esto significa tener algunos falsos positivos
   (transacciones no fraudulentas clasificadas como fraudulentas).

-  **Diagnóstico Médico:** En un sistema de diagnóstico médico para
   detectar una enfermedad grave, podrías preferir un alto recall para
   asegurarte de que la mayoría de los casos de la enfermedad sean
   detectados, incluso si hay algunos falsos positivos. De manera
   similar, un diagnóstico médico incorrecto es a menudo más costoso que
   no tener diagnóstico, pero un diagnóstico incorrecto puede resultar
   en elegir un tratamiento que haga más daño que bien.

Por otro lado, en algunos casos la precisión es más importante que el
recall. Por ejemplo, cuando compras algo en un sitio web, a menudo
aparece un mensaje como: “Los clientes que compraron X también compraron
Y”. En este contexto, el valor del recall no es tan importante porque no
es crucial que el sistema identifique todos los artículos que los
clientes podrían querer. Lo fundamental es que los clientes estén
satisfechos con las recomendaciones que reciben. Si las recomendaciones
son precisas y relevantes, los clientes estarán más inclinados a
considerar y aceptar estas sugerencias. De lo contrario, si las
recomendaciones son inexactas o irrelevantes, los clientes las ignorarán
en el futuro, disminuyendo la efectividad del sistema de
recomendaciones.

4. Puntuación F1 (F1 Score):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La puntuación F1 es la media armónica de la precisión y la sensibilidad.
Es útil cuando se necesita un equilibrio entre precisión y sensibilidad.
Es especialmente útil en contextos donde no solo es importante capturar
la mayor cantidad de instancias positivas posibles (recall), sino
también asegurarse de que las predicciones positivas sean correctas
(precisión).

El clasificador solo obtendrá una alta F score si tanto el recall como
la precisión son altos

.. math::  F1 Score = 2 \times \frac{precision \times recall}{precision + recall} 

El F score favorece a los clasificadores que tienen precisión y recall
similares. Esto no siempre es lo que deseas: en algunos contextos te
importa más la precisión, y en otros contextos realmente te importa el
recall. Por ejemplo, si entrenas un clasificador para detectar videos
que sean seguros para niños, probablemente prefieras un clasificador que
rechace muchos buenos videos (bajo recall) pero mantenga solo los
seguros (alta precisión), en lugar de un clasificador que tenga un
recall mucho mayor pero permita que aparezcan algunos videos realmente
inapropiados en tu producto (en tales casos, incluso podrías querer
agregar una revisión humana para verificar la selección de videos del
clasificador) (Géron, 2019).

Por otro lado, supongamos que entrenas un clasificador para detectar
ladrones en imágenes de vigilancia: probablemente esté bien si tu
clasificador tiene solo un 30% de precisión siempre y cuando tenga un
99% de recall (claro, los guardias de seguridad recibirán algunas
alertas falsas, pero casi todos los ladrones serán atrapados).

Desafortunadamente, no puedes tener ambos al mismo tiempo: aumentar la
precisión reduce el recall, y viceversa. Esto se llama la compensación
entre precisión y recall.

6. Curva precision/recall:
~~~~~~~~~~~~~~~~~~~~~~~~~~

La curva precision/recall es especialmente útil en conjuntos de datos
desbalanceados. Muestra la relación entre la precisión y la sensibilidad
a diferentes umbrales.

Estas métricas a menudo están en conflicto, lo que significa que mejorar
una puede conducir a la disminución de la otra. Entender este trade-off
es crucial para ajustar el rendimiento de un modelo según las
necesidades específicas de una aplicación.

En una gráfica de precisión y recall en función del umbral, verás que al
mover el umbral hacia un extremo, una métrica mejora mientras que la
otra disminuye. La clave está en encontrar un umbral que logre un
equilibrio adecuado según los requisitos del problema.

Cuando se ajusta el umbral de decisión del modelo (el punto en el cual
decide clasificar una instancia como positiva o negativa), puede afectar
tanto la precisión como el recall:

**Umbral Bajo:**

-  **Alta Recall:** Captura la mayoría de las instancias positivas, lo
   que significa menos falsos negativos.

-  **Baja Precisión:** También puede capturar muchas instancias
   negativas como positivas, lo que aumenta los falsos positivos.

**Umbral Alto:**

-  **Alta Precisión:** Las instancias clasificadas como positivas son
   muy probablemente verdaderos positivos, lo que reduce los falsos
   positivos.

-  **Baja Recall:** Puede perder muchas instancias positivas, lo que
   aumenta los falsos negativos.

7. Área Bajo la Curva ROC (AUC-ROC):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La curva ROC (receiver operating characteristic) evalúa el rendimiento
de un clasificador binario al variar el umbral de decisión. En el
gráfico, el eje Y muestra la tasa de verdaderos positivos (TPR o
sensibilidad), mientras que el eje X muestra la tasa de falsos positivos
(FPR).

La AUC-ROC mide la capacidad del modelo para distinguir entre clases,
representando el área bajo la curva ROC. Esta curva grafica la tasa de
verdaderos positivos contra la tasa de falsos positivos en diferentes
umbrales de decisión. La FPR es la proporción de instancias negativas
clasificadas incorrectamente como positivas, y es igual a 1 menos la
especificidad (tasa de verdaderos negativos).

Una curva ROC ideal se aleja lo más posible de la línea punteada de un
clasificador aleatorio, dirigiéndose hacia la esquina superior
izquierda. Un clasificador perfecto tiene una AUC-ROC de 1, mientras que
uno aleatorio tiene una AUC-ROC de 0.5.

La elección entre la curva ROC y la curva precisión/recall depende del
contexto: se prefiere la curva precisión/recall cuando la clase positiva
es rara o cuando los falsos positivos son más importantes que los falsos
negativos; en otros casos, se usa la curva ROC.

.. figure:: CurvaROC.JPG
   :alt: CurvaROC

   CurvaROC
