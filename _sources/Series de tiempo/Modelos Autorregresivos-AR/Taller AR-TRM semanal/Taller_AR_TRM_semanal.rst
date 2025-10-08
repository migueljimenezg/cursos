Taller AR-TRM semanal
---------------------

Descargar la TRM **semanal** desde 2017-01-01 hasta 2025-07-31.

Responder las siguientes preguntas:

**1. Seleccione la respuesta correcta:**

-  La ACF de la transformación logarítmica indica que la serie
   transformada presenta tendencia, por lo tanto, **no es estacionaria
   en tendencia**.

-  El valor :math:`p` de la prueba ADF aplicada a la serie transformada
   en logaritmo es mayor que :math:`0,05`, por lo que la serie
   transformada **no es estacionaria**.

-  La ACF del logaritmo de la serie muestra un decaimiento lento, lo que
   sugiere dependencia del pasado; asimismo, la PACF confirma que el
   primer rezago de la serie transformada tiene una autocorrelación
   parcial significativa y alta. Dado que la serie transformada es
   estacionaria, **es adecuado ajustar un modelo AR(1)**.

-  Ninguna de las anteriores es correcta.

**2. La serie de tiempo transformada en su primera diferencia y la serie
transformada en la primera diferencia del logaritmo son casi iguales;
únicamente cambia la escala, pero ambas muestran comportamientos muy
similares. Asimismo, la ACF y la PACF de ambas series presentan patrones
casi idénticos. Además, los estadísticos ADF de las dos transformaciones
son muy cercanos.**

-  Verdadero.

-  Falso.

**3. Seleccione la respuesta correcta:**

-  Como la serie original muestra una ACF con decaimiento lento, esto
   sugiere relación con rezagos pasados. Asimismo, la PACF evidencia una
   alta autocorrelación parcial en el primer rezago, lo que confirmaría
   la pertinencia de un modelo autorregresivo de orden 1. Sin embargo,
   dado que la serie original **no es estacionaria**, lo más apropiado
   sería aplicar el modelo AR(1) a la serie transformada en su primera
   diferencia.

-  Dado que los modelos AR solo se recomiendan para series estacionarias
   y que únicamente la serie transformada en su primera diferencia y la
   primera diferencia del logaritmo cumplen esta condición, y
   considerando que ambas presentan autocorrelaciones y
   autocorrelaciones parciales muy cercanas a las bandas de
   significancia, **no sería adecuado ajustar un modelo AR**, ya que
   estas transformaciones se asemejan a un ruido blanco.

-  La primera diferencia de la serie muestra una ACF con
   autocorrelaciones ligeramente significativas en los primeros cuatro
   rezagos; a partir del quinto rezago, la autocorrelación se aproxima a
   cero, lo que sugiere una relación con el pasado. Además, la PACF
   indica autocorrelaciones parciales levemente significativas hasta el
   cuarto rezago. Dado que esta serie transformada es estacionaria,
   podría ajustarse un modelo AR probando rezagos entre 1 y 4.

-  Ninguna de las anteriores es correcta.

**Ajuste de modelos AR**

Para realizar el ajuste del modelo autorregresivo, utilice como conjunto
de *test* el último 20% de la serie de tiempo, ya sea la serie original
o su versión transformada.

**4. Luego de ajustar un modelo AR(1) a la serie transformada en su
primera diferencia, seleccione la respuesta correcta:**

-  El ajuste AR(1) es significativo, dado que tanto la constante
   :math:`\alpha` como el coeficiente :math:`\phi_1` no son cercanos a
   cero, sus valores :math:`z` son mayores que el :math:`z_{crítico}`
   (1,96 o 2,58), los valores :math:`p` son menores que 0,05 y en los
   intervalos de confianza no se incluye el cero.

-  El ajuste AR(1) es significativo, dado que el coeficiente
   :math:`\phi_1` no es cercano a cero, su valor :math:`z` es mayor que
   el :math:`z_{crítico}` (1,96 o 2,58), el valor :math:`p` es menor que
   0,05 y en el intervalo de confianza no se incluye el cero.

-  En el ajuste AR(1) a la serie transformada en su primera diferencia
   no se consideran ni la constante :math:`\alpha` ni la tendencia
   :math:`\beta_t`; sin embargo, el coeficiente :math:`\phi_1` **no es
   significativo**, ya que su valor :math:`p` es mayor que 0,05.

-  Ninguna de las anteriores es correcta.

**5. Luego de ajustar un modelo AR(2) a la serie transformada en su
primera diferencia, seleccione la respuesta correcta:**

-  El coeficiente :math:`\phi_1` del modelo AR(2) es significativo al
   5%, ya que su valor :math:`z` es mayor que el valor crítico de 1,96.
   Sin embargo, para un nivel de significancia del 1%, este coeficiente
   no resulta significativo, dado que :math:`|z| = 2{,}370` es menor que
   el valor crítico de 2,58. Además, :math:`\phi_1 = -0{,}0989` es un
   valor pequeño y más cercano a cero que :math:`\phi_2 = 0{,}1188`; no
   obstante, en términos generales, el ajuste puede considerarse
   significativo.

-  Como :math:`\phi_1 = -0{,}0989`, este valor negativo indicaría que el
   modelo AR(2) no es significativo, ya que el coeficiente del primer
   rezago es negativo.

-  En el pronóstico fuera de la muestra, realizado 12 semanas después
   del conjunto de *test*, el resultado es completamente bajista.

-  Ninguna de las anteriores es correcta.

**6. Luego de ajustar un modelo AR(3) a la serie transformada en su
primera diferencia, seleccione la respuesta correcta:**

-  Se podría considerar que el ajuste AR(3) es significativo, dado que
   presenta coeficientes estadísticamente significativos, y únicamente
   el coeficiente del primer rezago es ligeramente no significativo.

-  En el pronóstico fuera de la muestra, realizado 12 semanas después
   del conjunto de *test*, el resultado muestra un comportamiento
   totalmente bajista.

-  El ajuste AR(3) **no es significativo**, ya que el coeficiente
   :math:`\phi_1` no resulta significativo ni al 5%
   (:math:`z_{crítico}=1{,}96`), su valor :math:`p` es mayor que 0,05 y
   el intervalo de confianza incluye el valor cero, a pesar de que los
   demás coeficientes sí son significativos.

-  Ninguna de las anteriores es correcta.

**7. Luego de ajustar un modelo AR(4) a la serie transformada en su
primera diferencia, responda lo siguiente:**

-  El ajuste del modelo AR(4) es significativo, ya que los coeficientes
   estimados de los rezagos no se aproximan a cero, los valores
   absolutos de :math:`z` son significativos al 5%
   (:math:`z_{crítico}=1{,}96`), todos los valores :math:`p` son menores
   que 0,05 y ninguno de los intervalos de confianza incluye el valor
   cero.

-  Verdadero.

-  Falso.
