Taller suavizamiento extracción petróleo
----------------------------------------

En este taller encontrará preguntas teóricas y preguntas relacionadas
con la serie de tiempo de ``Extracción petróleo Ecopetrol.xlsx``

Preguntas teóricas:
~~~~~~~~~~~~~~~~~~~

**Pregunta 1 – Descomposición aditiva**

¿Cuál de las siguientes afirmaciones describe mejor la componente de
tendencia cuando se usa una descomposición aditiva?

A. Su amplitud cambia proporcionalmente al nivel de la serie.

B. Es independiente de la estacionalidad y refleja cambios de nivel a
largo plazo.

C. Siempre oscila alrededor de cero porque se resta la media mensual.

D. Presenta variaciones porcentuales que dependen del mes.

**Pregunta 2 – Descomposición multiplicativa**

En una descomposición multiplicativa, la estacionalidad se interpreta
principalmente como:

A. Un efecto constante que se suma a la tendencia.

B. Una variación que mantiene la misma magnitud absoluta cada periodo.

C. Un factor que escala la serie, por lo que su amplitud crece con el
nivel.

D. Un término aleatorio sin patrón repetitivo.

**Pregunta 3 – Parámetro** :math:`\alpha` **en SES**

Un valor de :math:`\alpha` cercano a 1 en el Suavizamiento Exponencial
Simple (SES) indica que el modelo:

A. Da poco peso a las observaciones recientes.

B. Reacciona rápidamente a los cambios más recientes de la serie.

C. Suaviza excesivamente la serie, eliminando la variabilidad.

D. No actualiza la tendencia en cada paso temporal.

**Pregunta 4 – Comparación de métricas (SES vs. Holt)**

Al sustituir el modelo SES por Holt se observa que el :math:`R^{2}`
aumenta y el MSE disminuye. ¿Cuál es la interpretación más adecuada?

A. Holt captura mejor la tendencia, elevando la capacidad explicativa y
reduciendo el error cuadrático medio.

B. SES es preferible, pues su menor complejidad garantiza siempre mejor
rendimiento.

C. :math:`R^{2}` y MSE no son comparables; el resultado no aporta
información útil.

D. El incremento de :math:`R^{2}` y la reducción de MSE evidencian
sobreajuste del modelo Holt.

**Pregunta 5 – Interpretación de** :math:`\beta` **en Holt**

Un valor de :math:`\beta` muy bajo sugiere que el modelo:

A. Ajusta una tendencia muy volátil y sensible al ruido.

B. Ignora la tendencia por completo, asumiendo que es nula.

C. Mantiene una tendencia casi constante, actualizándola lentamente en
el tiempo.

D. Convierte a Holt en un modelo equivalente a SES.

**Pregunta 6 – Elección del componente estacional**

¿Qué criterio práctico justifica usar Holt-Winters multiplicativo en
lugar de aditivo?

A. La estacionalidad muestra cambios porcentuales que crecen con el
nivel de la serie.

B. La serie no presenta tendencia.

C. El ruido blanco es aditivo.

D. El horizonte de pronóstico es menor a 12 períodos.

**Pregunta 7 – Impacto de un** :math:`\gamma` **elevado**

En Holt-Winters, si el optimizador devuelve un :math:`\gamma` muy
cercano a 1, ¿qué interpretación es más adecuada?

A. El componente estacional se actualiza con fuerza, reaccionando casi
por completo a los datos más recientes.

B. La estacionalidad queda prácticamente congelada y no se modifica con
nuevas observaciones.

C. El modelo deja de incorporar la tendencia y se comporta como un SES.

D. El patrón estacional desaparece, indicando ausencia de estacionalidad
en la serie.

**Respuestas correctas:**

1. B – La tendencia aditiva se modela como un componente independiente
   de la estacionalidad que refleja cambios de nivel a largo plazo.

2. C – En la descomposición multiplicativa la estacionalidad actúa como
   un factor que escala la serie; su amplitud crece conforme aumenta el
   nivel.

3. B – Un :math:`\alpha` cercano a 1 otorga mayor peso a la última
   observación, haciendo al modelo muy reactivo a cambios recientes.

4. A – Un mayor :math:`R^{2}` y menor MSE indican que Holt explica más
   varianza y comete menos error cuadrático, capturando mejor la
   tendencia que SES.

5. C – Un :math:`\beta` bajo actualiza la tendencia lentamente,
   manteniéndola casi constante y menos sensible al ruido.

6. A – El modelo multiplicativo es adecuado cuando la estacionalidad se
   manifiesta como variaciones porcentuales (relativas) que crecen con
   el nivel de la serie.

7. A – Un :math:`\gamma` cercano a 1 hace que la componente estacional
   se ajuste casi totalmente al dato más reciente, reflejando
   estacionalidad muy dinámica.

Preguntas prácticas:
~~~~~~~~~~~~~~~~~~~~

Trabaje con la serie de tiempo **Extracción de petróleo** desde
**2022-01-01** hasta la fecha más reciente disponible.

Divida los datos en un conjunto de entrenamiento (80 %) y un conjunto de
prueba (20 %).

Responda las siguientes preguntas:

**Pregunta 1 – Preparación de los datos**

Indique el número de observaciones totales, las fechas de inicio y fin
de cada subconjunto (train y test) y la frecuencia temporal detectada.

**Pregunta 2 – Ajuste del modelo SES**

Ajuste un modelo de **Suavizamiento Exponencial Simple (SES)**.

-  ¿Cuál fue el valor de :math:`\alpha` (smoothing_level) estimado?

-  Presente las métricas **R², MSE, MAPE** y **Máx Error** para train y
   test.

**Pregunta 3 – Ajuste del modelo de Holt**

Ajuste un modelo de **Holt (suavizamiento doble)**.

-  ¿Cuáles fueron los valores estimados de :math:`\alpha` y
   :math:`\beta`?

-  Presente las mismas métricas de error para train y test.

**Pregunta 4 – Ajuste del modelo Holt-Winters aditivo**

Ajuste un modelo **Holt-Winters con estacionalidad aditiva**.

-  Reporte los valores de :math:`\alpha`, :math:`\beta` y
   :math:`\gamma`.

-  Presente las métricas de error para train y test.

**Pregunta 5 – Ajuste del modelo Holt-Winters multiplicativo**

Ajuste un modelo **Holt-Winters con estacionalidad multiplicativa**.

-  Reporte los valores de :math:`\alpha`, :math:`\beta` y
   :math:`\gamma`.

-  Presente las métricas de error para train y test.

**Pregunta 6 – Comparación de modelos**

Con base en las métricas del conjunto de prueba, ordene los cuatro
modelos (SES, Holt, HW aditivo, HW multiplicativo) de mejor a peor
desempeño y justifique brevemente su elección.

**Pregunta 7 – Análisis de los parámetros**

Interprete la magnitud de los parámetros estimados (:math:`\alpha`,
:math:`\beta`, :math:`\gamma`) en cada modelo y explique qué revelan
sobre la dinámica de la serie **Extracción de petróleo**.

Resultados del ajuste:
~~~~~~~~~~~~~~~~~~~~~~

+----------+--------------+--------+----------------------------------+
| Modelo   | Parámetro    | Valor  | Interpretación práctica          |
+==========+==============+========+==================================+
| **SES**  | alfa         | 0,45   | Valor intermedio: cada nuevo     |
|          |              |        | dato pesa 45 % y el histórico    |
|          |              |        | suavizado 55 %. El pronóstico    |
|          |              |        | responde con agilidad a cambios  |
|          |              |        | recientes, pero aún conserva     |
|          |              |        | memoria del pasado.              |
+----------+--------------+--------+----------------------------------+
| **Holt** | alfa         | 0,54   | Predominio moderado de la        |
|          |              |        | observación reciente (54 %); el  |
|          |              |        | nivel se ajusta con rapidez      |
|          |              |        | media.                           |
+----------+--------------+--------+----------------------------------+
|          | beta         | 0,39   | La tendencia se actualiza        |
|          |              |        | suavemente: solo 39 % proviene   |
|          |              |        | del nuevo error. Evita           |
|          |              |        | sobre-reaccionar al ruido en la  |
|          |              |        | pendiente.                       |
+----------+--------------+--------+----------------------------------+
| **Holt-W | alfa         | 0,42   | Peso moderado al dato nuevo;     |
| inters** |              |        | capta variaciones sin perder     |
|          |              |        | estabilidad.                     |
+----------+--------------+--------+----------------------------------+
|          | beta         | 0      | El optimizador “congeló” la      |
|          |              |        | pendiente: no se detecta         |
|          |              |        | tendencia lineal significativa   |
|          |              |        | tras descontar estacionalidad.   |
+----------+--------------+--------+----------------------------------+
|          | gamma        | 0,36   | La estacionalidad se actualiza   |
|          |              |        | con suavidad media; patrón       |
|          |              |        | estacional estable pero con      |
|          |              |        | evolución gradual.               |
+----------+--------------+--------+----------------------------------+

**Conclusiones:**

-  Los valores de :math:`\alpha` (0,4–0,5) indican reactividad adecuada:
   el modelo capta cambios trimestrales o semestrales sin ser
   hipersensible al ruido.

-  En Holt, :math:`\beta = 0,39` confirma una pendiente cambiante pero
   no caótica; en Holt-Winters, :math:`\beta = 0` sugiere ausencia de
   tendencia una vez aislada la estacionalidad.

-  :math:`\gamma = 0,36` revela patrones estacionales persistentes con
   capacidad de ajuste gradual (mantenimiento programado, ciclos de
   demanda, etc.).
