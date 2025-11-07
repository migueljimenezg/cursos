Modelos SARIMA
--------------

Los modelos **SARIMA** (Seasonal AutoRegressive Integrated Moving
Average) son una extensión de los modelos **ARIMA**, que permiten
capturar tanto la **dependencia temporal** como los **patrones
estacionales** en una serie de tiempo.

A diferencia de los modelos ARIMA tradicionales, el modelo SARIMA
incorpora componentes adicionales que representan la **estacionalidad**
de la serie.

El modelo se denota como:

.. math::  SARIMA(p, d, q)(P, D, Q)_s 

Donde:

-  :math:`p`: orden del componente autorregresivo (AR).

-  :math:`d`: grado de diferenciación no estacional.

-  :math:`q`: orden del componente de media móvil (MA).

-  :math:`P`: orden del componente autorregresivo estacional.

-  :math:`D`: grado de diferenciación estacional.

-  :math:`Q`: orden del componente de media móvil estacional.

-  :math:`s`: periodo estacional (por ejemplo, 12 para datos mensuales,
   4 para trimestrales, 7 para semanales).

**Ecuaciones del modelo ARIMA**

El modelo SARIMA combina los componentes **autorregresivos (AR)**,
**integrados (I)** y de **media móvil (MA)**, además de los componentes
**estacionales**.

1. **Componente autorregresivo (AR):**

El valor actual depende linealmente de los valores pasados de la serie:

.. math::


   y_t = c + \phi_1 y_{t-1} + \phi_2 y_{t-2} + \cdots + \phi_p y_{t-p} + \varepsilon_t

2. **Componente de media móvil (MA):**

El valor actual depende linealmente de los errores pasados:

.. math::


   y_t = \mu + \theta_1 \varepsilon_{t-1} + \theta_2 \varepsilon_{t-2} + \cdots + \theta_q \varepsilon_{t-q} + \varepsilon_t

3. **Componente integrado (I):**

| Representa el número de diferencias necesarias para hacer estacionaria
  la serie.
| Si :math:`d = 1`, se utiliza la primera diferencia:

.. math::


   y'_t = y_t - y_{t-1}

**Ecuación general del modelo SARIMA**

El modelo se puede expresar como:

.. math::  \Phi_P(L^s)\phi_p(L)(1-L)^d(1-L^s)^D y_t = \Theta_Q(L^s)\theta_q(L)\varepsilon_t 

Donde:

-  :math:`L` es el **operador de rezago**, tal que
   :math:`Ly_t = y_{t-1}`.

-  :math:`\phi_p(L)` representa los parámetros autorregresivos no
   estacionales.

-  :math:`\Phi_P(L^s)` representa los parámetros autorregresivos
   estacionales.

-  :math:`\theta_q(L)` representa los parámetros de media móvil no
   estacionales.

-  :math:`\Theta_Q(L^s)` representa los parámetros de media móvil
   estacionales.

-  :math:`(1-L)^d` indica la diferenciación ordinaria.

-  :math:`(1-L^s)^D` indica la diferenciación estacional.

**Interpretación de cada componente**

1. **Parte AR (AutoRegresiva):**

   | Modela la dependencia del valor actual con los valores pasados.
   | Ejemplo:
     :math:`y_t = \phi_1 y_{t-1} + \phi_2 y_{t-2} + \varepsilon_t`

2. **Parte I (Integrada):**

   | Se refiere al número de veces que la serie debe diferenciarse para
     volverse estacionaria.
   | Si :math:`d=1`, se utiliza la primera diferencia:

   .. math::  y'_t = y_t - y_{t-1} 

3. **Parte MA (Media Móvil):**

   | Modela la dependencia del valor actual con los errores pasados.
   | Ejemplo: :math:`y_t = \varepsilon_t + \theta_1 \varepsilon_{t-1}`

4. **Parte estacional (P, D, Q, s):**

   | Captura patrones que se repiten cada :math:`s` períodos.
   | Por ejemplo, en datos mensuales (:math:`s=12`), se modela la
     relación con los valores del mismo mes en años anteriores.

**Extensión estacional del modelo (SARIMA)**

| El modelo SARIMA introduce términos autorregresivos y de medias
  móviles adicionales que capturan la **dependencia estacional**, es
  decir, patrones que se repiten cada :math:`s` períodos.
| La ecuación general puede expresarse mediante el operador de rezago
  :math:`L` como:

.. math::


   \Phi_P(L^s)\phi_p(L)(1 - L)^d(1 - L^s)^D y_t = \Theta_Q(L^s)\theta_q(L)\varepsilon_t

Donde:

-  :math:`\phi_p(L)` representa los parámetros AR no estacionales.

-  :math:`\Phi_P(L^s)` representa los parámetros AR estacionales.

-  :math:`\theta_q(L)` representa los parámetros MA no estacionales.

-  :math:`\Theta_Q(L^s)` representa los parámetros MA estacionales.

-  :math:`(1 - L)^d` representa la diferenciación ordinaria.

-  :math:`(1 - L^s)^D` representa la diferenciación estacional.

**Proceso general para ajustar un modelo SARIMA**

1. **Analizar la serie de tiempo:**

   Verificar tendencia y estacionalidad mediante gráficos y pruebas
   estadísticas (ADF, KPSS, etc.).

2. **Aplicar diferenciaciones necesarias:**

   Hacer la serie estacionaria con diferencias ordinarias y/o
   estacionales.

3. **Identificar los órdenes p, q, P, Q:**

   Usar los gráficos de ACF y PACF para estimar posibles órdenes.

4. **Ajustar el modelo SARIMA:**

   Estimar los parámetros con máxima verosimilitud usando librerías como
   ``statsmodels``.

5. **Diagnóstico de residuales:**

   Evaluar si los residuales son ruido blanco mediante ACF/PACF y
   pruebas Ljung-Box, Jarque-Bera, etc.

6. **Pronóstico:**

   Generar pronósticos dentro y fuera de la muestra y comparar con los
   valores reales.

**Ventajas del modelo SARIMA**

-  Integra en un solo marco tanto la tendencia como la estacionalidad.

-  Permite pronósticos robustos para series con patrones estacionales
   regulares.

-  Es flexible y se adapta a distintas frecuencias de tiempo.

**Limitaciones**

-  Requiere una estacionalidad constante (no cambiante en el tiempo).

-  Puede ser costoso computacionalmente para órdenes altos.

-  La interpretación de los parámetros no es directa.

-  No captura relaciones con variables externas (para ello se usa
   SARIMAX).

**Extensión SARIMAX**

El modelo **SARIMAX** (Seasonal ARIMA with eXogenous variables) añade
variables explicativas externas (:math:`X_t`):

.. math::  y_t = SARIMA(p, d, q)(P, D, Q)_s + \beta X_t + \varepsilon_t 

Esto permite incorporar factores externos como temperatura, demanda, o
precios de energía que influyen en la serie.

**Conclusión**

| El modelo SARIMA es una herramienta poderosa para el pronóstico de
  series con componentes estacionales.
| Su correcta identificación, ajuste y validación de residuales permiten
  obtener predicciones confiables y útiles en contextos económicos,
  financieros y energéticos.

Identificación de los componentes estacionales (P, D, Q)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

En un modelo SARIMA(p,d,q)(P,D,Q)ₛ, los parámetros **P, D y Q**
representan los efectos **autorregresivos, de diferenciación y de medias
móviles estacionales**, respectivamente, con un período estacional
:math:`s`.

Estos se identifican a partir del comportamiento de la **ACF** y la
**PACF**, observando los rezagos múltiplos de :math:`s`.

**1. Diferenciación estacional (D)**

El parámetro :math:`D` indica cuántas veces debe diferenciarse la serie
con un rezago igual al período estacional :math:`s`, para eliminar
patrones repetitivos.

La diferenciación estacional se calcula como:

.. math::


   (1 - L^s)^D y_t

**Cómo identificar D:**

-  Si la serie muestra un **patrón estacional estable** (por ejemplo,
   picos anuales o trimestrales regulares), probablemente :math:`D = 0`.

-  Si la serie muestra una **tendencia estacional creciente o
   decreciente** (es decir, los picos o valles aumentan o disminuyen con
   el tiempo), suele requerirse una **diferenciación estacional**, es
   decir, :math:`D = 1`.

-  Si después de aplicar una diferencia estacional la serie se vuelve
   estacionaria (ACF y PACF dentro de las bandas), el valor correcto es
   :math:`D = 1`.

**Ejemplo:**

Para datos mensuales :math:`s=12`:

.. math::


   y'_t = y_t - y_{t-12}

**2. Componente autorregresivo (AR) estacional (P)**

El parámetro :math:`P` representa el número de **rezagos estacionales
autorregresivos**, es decir, la dependencia de la serie con sus valores
anteriores separados por :math:`s` períodos.

Se identifica a partir de la **PACF**, observando los rezagos múltiplos
de :math:`s` (por ejemplo, 12, 24, 36 si :math:`s = 12`.

**Regla práctica:**

-  Si en la PACF se observa un **pico significativo en el rezago s**,
   seguido de caídas rápidas, indica un **AR estacional de orden 1**, es
   decir :math:`P = 1`.

-  Si hay dos o más rezagos estacionales significativos (por ejemplo, 12
   y 24), puede sugerirse :math:`P = 2`.

**3. Componente de medias móviles (MA) estacional (Q)**

El parámetro :math:`Q` representa el número de **rezagos estacionales de
medias móviles**, es decir, la dependencia del error actual con errores
estacionales anteriores.

Se identifica a partir de la **ACF**, observando los rezagos múltiplos
de :math:`s`.

**Regla práctica:**

-  Si la ACF muestra un **pico significativo en el rezago s**, sugiere
   :math:`Q = 1`.

-  Si aparecen dos o más rezagos estacionales significativos (por
   ejemplo, 12 y 24), puede sugerirse :math:`Q = 2`.

**Resumen de identificación visual**

+----------------------+--------------+-----------------+-------------+
| Tipo de componente   | A partir de  | Patrón típico   | Parámetro   |
+======================+==============+=================+=============+
| Tendencia no         | Serie        | Creciente o     | d           |
| estacional           | original     | decreciente     |             |
+----------------------+--------------+-----------------+-------------+
| Tendencia estacional | Serie        | Aume            | D           |
|                      | original     | nto/disminución |             |
|                      |              | en picos        |             |
|                      |              | estacionales    |             |
+----------------------+--------------+-----------------+-------------+
| AR no estacional     | PACF         | Corte brusco    | p           |
|                      | (rezagos     | tras p rezagos  |             |
|                      | cortos)      |                 |             |
+----------------------+--------------+-----------------+-------------+
| MA no estacional     | ACF (rezagos | Corte brusco    | q           |
|                      | cortos)      | tras q rezagos  |             |
+----------------------+--------------+-----------------+-------------+
| AR estacional        | PACF         | Corte brusco en | P           |
|                      | (rezagos s,  | rezago s        |             |
|                      | 2s, 3s)      |                 |             |
+----------------------+--------------+-----------------+-------------+
| MA estacional        | ACF (rezagos | Corte brusco en | Q           |
|                      | s, 2s, 3s)   | rezago s        |             |
+----------------------+--------------+-----------------+-------------+

**Ejemplo práctico**

Para una serie **mensual** :math:`s = 12`:

-  La ACF muestra un pico claro en el rezago 12 → sugiere :math:`Q = 1`.

-  La PACF muestra un pico claro en el rezago 12 → sugiere
   :math:`P = 1`.

-  La serie muestra tendencia estacional creciente → :math:`D = 1`.

Entonces el modelo propuesto sería:

.. math::


   SARIMA(p,d,q)(1,1,1)_{12}

**Consejo final**

-  Primero determina :math:`d` y :math:`D` (diferencias necesarias).

-  Luego analiza la ACF y la PACF de la serie diferenciada para
   identificar :math:`p, q, P, Q`.

-  Si los gráficos no son concluyentes, usa auto-arima o criterios
   AIC/BIC para ajustar y comparar modelos candidatos.

Análisis de los residuales en un modelo SARIMA
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Después de ajustar un modelo SARIMA(p,d,q)(P,D,Q)ₛ, es fundamental
analizar los **residuales**.

Estos deben comportarse como **ruido blanco**, es decir:

-  Tener media cero,

-  Ser incorrelacionados,

-  Presentar varianza constante (homocedasticidad),

-  Seguir aproximadamente una distribución normal.

**Qué ocurre si en la ACF o PACF de los residuales hay valores
significativos**

Si, luego del ajuste, se observa que la **ACF** o la **PACF** de los
residuales tiene **rezagos significativos**, esto indica que el modelo
**no ha capturado toda la estructura temporal** de la serie.

En otras palabras, los residuales aún conservan correlación temporal →
el modelo está **mal especificado** o **incompleto**.

**Interpretación práctica según el patrón detectado**

1. **Rezagos significativos no estacionales (por ejemplo, 1, 2, 3…)**

   -  | Indican que los componentes **AR o MA** no estacionales no
        fueron suficientes.

   -  Posibles soluciones:

      -  Aumentar el orden :math:`p` (AR) si los picos aparecen en la
         **PACF**.

      -  Aumentar el orden :math:`q` (MA) si los picos aparecen en la
         **ACF**.

      -  Reajustar el modelo probando combinaciones cercanas (por
         ejemplo, pasar de SARIMA(1,1,1) a SARIMA(2,1,1)).

2. **Rezagos significativos estacionales (por ejemplo, 12, 24…)**

   -  Indican que la componente **estacional** del modelo no está bien
      representada.

   -  Posibles soluciones:

      -  Aumentar el orden :math:`P` (AR estacional) si el pico aparece
         en la **PACF** en múltiplos de :math:`s`.

      -  Aumentar el orden :math:`Q` (MA estacional) si el pico aparece
         en la **ACF** en múltiplos de :math:`s`.

      -  Verificar si la **diferenciación estacional (D)** fue adecuada:
         en algunos casos se requiere :math:`D = 1`.

3. **Patrón de alternancia o ciclos persistentes en la ACF**

   -  Indica que persiste un **componente periódico o cíclico** no
      capturado.

   -  Posibles acciones:

      -  Probar otro valor de **periodicidad estacional (s)**.

      -  Incorporar variables exógenas (SARIMAX) si existe una causa
         externa (por ejemplo, clima, demanda).

**Pasos recomendados tras detectar autocorrelación en los residuales**

1. **Revisar la diferenciación aplicada:**

   -  Si la serie está sobre-diferenciada (ACF con picos negativos),
      reducir :math:`d` o :math:`D`.

   -  Si la serie sigue con tendencia o estacionalidad, aumentar
      :math:`d` o :math:`D`.

2. **Reajustar el modelo con órdenes modificados:**

   -  Explorar combinaciones cercanas de :math:`p, q, P, Q` alrededor
      del modelo actual.

   -  Comparar los nuevos modelos usando criterios AIC, BIC y análisis
      de residuales.

3. **Verificar la estacionalidad:**

   -  Asegurarse de que el valor de :math:`s` corresponde al patrón real
      (por ejemplo, 12 meses, 52 semanas, 7 días).

4. **Probar un modelo alternativo:**

   -  Si la estructura es compleja o hay correlaciones persistentes, se
      puede intentar con modelos **SARIMAX**, **ETS** o redes neuronales
      recurrentes (LSTM).

**Conclusión**

Cuando la ACF o PACF de los residuales muestra significancia:

-  El modelo **no ha captado toda la dinámica temporal**.

-  No se deben usar los pronósticos de ese modelo hasta corregirlo.

-  | El siguiente paso es **ajustar un modelo alternativo** modificando
     los órdenes (p, q, P, Q) o la diferenciación (d, D),
   | y volver a evaluar los residuales hasta que sean ruido blanco.

**Regla práctica final**

+-----------------------+-----------------------+--------------------+
| Situación observada   | Posible causa         | Acción recomendada |
| en residuales         |                       |                    |
+=======================+=======================+====================+
| Picos en ACF (rezagos | MA insuficiente       | Aumentar q         |
| cortos)               |                       |                    |
+-----------------------+-----------------------+--------------------+
| Picos en PACF         | AR insuficiente       | Aumentar p         |
| (rezagos cortos)      |                       |                    |
+-----------------------+-----------------------+--------------------+
| Picos en ACF (rezagos | MA estacional         | Aumentar Q         |
| 12, 24…)              | insuficiente          |                    |
+-----------------------+-----------------------+--------------------+
| Picos en PACF         | AR estacional         | Aumentar P         |
| (rezagos 12, 24…)     | insuficiente          |                    |
+-----------------------+-----------------------+--------------------+
| Tendencia o patrón no | Falta de              | Aumentar d o D     |
| eliminado             | diferenciación        |                    |
+-----------------------+-----------------------+--------------------+
| Picos negativos       | Sobre-diferenciación  | Reducir d o D      |
| alternos              |                       |                    |
+-----------------------+-----------------------+--------------------+

**Cuándo usar D = 1 en lugar de D = 0 en un modelo SARIMA**

El parámetro **D** representa el número de **diferencias estacionales**
aplicadas a la serie, es decir, cuántas veces se resta la observación
actual con la del mismo período anterior (por ejemplo, con el valor del
mismo mes del año anterior si :math:`s = 12`).

Matemáticamente, la diferenciación estacional se expresa como:

.. math::


   (1 - L^s)^D y_t

Donde: - :math:`L` es el operador de rezago :math:`Ly_t = y_{t-1}`.

-  :math:`s` es el período estacional (por ejemplo, 12 para datos
   mensuales o 4 para trimestrales).

**1. Caso D = 0: No se requiere diferenciación estacional**

Se utiliza :math:`D = 0` cuando la serie ya es **estacionalmente
estacionaria**, es decir, los patrones estacionales se repiten cada año
con una magnitud y nivel aproximadamente constantes.

**Indicadores visuales y estadísticos de que D = 0:**

-  El gráfico de la serie muestra **picos estacionales regulares y
   estables** en el tiempo (no crecen ni decrecen).

-  La media y la varianza de cada estación (por ejemplo, cada mes del
   año) son aproximadamente constantes.

-  En la **ACF**, los picos en múltiplos de :math:`s` (12, 24, 36, …)
   **disminuyen rápidamente** o se encuentran dentro de las bandas de
   confianza.

-  Las pruebas de estacionariedad (como ADF o KPSS aplicadas a la serie
   estacionalmente ajustada) no rechazan la hipótesis de
   estacionariedad.

**Ejemplo:**

Si la producción mensual de energía siempre sube en diciembre y baja en
enero, pero esos aumentos son similares cada año, entonces
:math:`D = 0`.

**2. Caso D = 1: Se requiere una diferenciación estacional**

Se utiliza :math:`D = 1` cuando la serie **presenta una tendencia en su
patrón estacional**, es decir, cuando las fluctuaciones estacionales
cambian de nivel o intensidad a lo largo del tiempo.

La diferencia estacional elimina esos cambios sistemáticos de nivel
entre ciclos.

**Fórmula:**

.. math::


   y'_t = y_t - y_{t-s}

**Indicadores visuales de que se necesita D = 1:**

-  Los picos o valles estacionales **aumentan o disminuyen
   progresivamente** con el tiempo (la estacionalidad no es constante).

-  La serie muestra **una tendencia de largo plazo** superpuesta a la
   estacionalidad.

-  La **ACF** presenta picos muy fuertes y persistentes exactamente en
   los múltiplos de :math:`s` (por ejemplo, en 12, 24, 36…) que **no
   desaparecen rápidamente**.

-  La **PACF** también puede mostrar picos fuertes en múltiplos de
   :math:`s`, lo cual indica autocorrelación estacional no eliminada.

-  Después de aplicar una diferencia estacional, la ACF de la nueva
   serie se vuelve mucho más plana y los picos en múltiplos de :math:`s`
   desaparecen.

**Ejemplo:**

Si la demanda eléctrica mensual crece cada año, y los picos de diciembre
son cada vez más altos (por crecimiento de la población o de la
economía), la estacionalidad no es estable → se necesita :math:`D = 1`.

**3. Cuándo no usar D = 1 (riesgo de sobre-diferenciación)**

Usar una diferencia estacional cuando no es necesaria puede generar:

-  Una **serie excesivamente ruidosa**, con picos negativos alternantes
   en la ACF.

-  Pérdida de estructura temporal (la serie se vuelve más difícil de
   modelar).

-  Estimaciones inestables y errores de predicción más altos.

**Signos de sobre-diferenciación (D demasiado alto):**

-  La ACF muestra **valores negativos significativos** en los primeros
   rezagos estacionales.

-  La serie diferenciada oscila erráticamente alrededor de cero sin
   estructura.

-  La varianza aumenta en lugar de estabilizarse.

**4. Recomendación práctica**

1. Analiza primero la **serie original**:

   -  Si tiene estacionalidad visible y creciente → prueba
      :math:`D = 1`.

   -  Si tiene estacionalidad estable → usa :math:`D = 0`.

2. Verifica luego la **ACF y PACF**:

   -  Si hay picos persistentes en los múltiplos de :math:`s`, prueba
      una diferencia estacional.

   -  Si tras aplicar la diferencia estacional los picos desaparecen →
      :math:`D = 1` es adecuado.

3. Evalúa los **residuales del modelo**:

   -  Si con :math:`D = 0` aún hay autocorrelación estacional en la ACF
      de los residuales, cambia a :math:`D = 1`.

   -  Si con :math:`D = 1` los residuales parecen ruido blanco, el
      ajuste es correcto.

**Ejemplo visual:**

Supongamos una serie mensual :math:`s = 12` con picos cada diciembre:

-  En los primeros años, los picos son de 100 unidades.
-  Luego aumentan a 150, 200, 250…
   → La estacionalidad está **creciendo con el tiempo**.

En este caso, aplicar una diferencia estacional elimina esa tendencia
creciente:

.. math::


   y'_t = y_t - y_{t-12}

Después de esta transformación, la serie se estabiliza y los picos en
los múltiplos de 12 desaparecen de la ACF → confirmando que
:math:`D = 1` era necesario.

**Resumen práctico**

+-----------------------------+-------------------+--------------------+
| Situación de la serie       | Patrón en ACF     | Recomendación      |
+=============================+===================+====================+
| Estacionalidad estable,     | Picos pequeños    | D = 0              |
| picos regulares             | que decaen        |                    |
|                             | rápidamente       |                    |
+-----------------------------+-------------------+--------------------+
| Picos estacionales          | Picos grandes y   | D = 1              |
| aumentan/disminuyen con el  | persistentes en   |                    |
| tiempo                      | múltiplos de s    |                    |
+-----------------------------+-------------------+--------------------+
| Serie sin estacionalidad    | ACF sin picos     | D = 0              |
| visible                     | regulares         |                    |
+-----------------------------+-------------------+--------------------+
| ACF muestra picos negativos | Serie             | Reducir D          |
| alternos tras diferenciar   | sobrediferenciada |                    |
+-----------------------------+-------------------+--------------------+

**Conclusión**

El parámetro :math:`D` controla si eliminamos o no la **tendencia en la
estacionalidad**.

-  :math:`D = 0` cuando la estacionalidad es **estable**.

-  :math:`D = 1` cuando la estacionalidad es **inestable o creciente**.

El mejor criterio es **verificar la ACF estacional** antes y después de
aplicar la diferencia: si los picos desaparecen, el valor de :math:`D`
elegido es el correcto.

**Importancia relativa de las diferenciaciones d y D en un modelo
SARIMA**

En un modelo SARIMA(p,d,q)(P,D,Q)ₛ existen **dos tipos de
diferenciación**:

1. **d** → diferenciación no estacional (de corto plazo).

2. **D** → diferenciación estacional (de largo plazo, con período s).

Ambas se aplican para lograr que la serie sea **estacionaria**, pero
cada una elimina un tipo distinto de tendencia.

**1. Diferenciación no estacional (d)**

Representa el número de veces que se resta la serie con su valor
inmediato anterior:

.. math::


   (1 - L)^d y_t

**Propósito:**

-  Eliminar **tendencias lineales o determinísticas** en la serie.

-  Corregir la **no estacionariedad de nivel o tendencia global**.

**Ejemplo:**

Si el precio de la energía sube mes a mes con una tendencia ascendente,
pero sin estacionalidad fuerte, aplicar una diferencia no estacional (d
= 1) elimina esa tendencia.

**Indicadores de que se necesita d = 1:**

-  La serie muestra un crecimiento o descenso sostenido.

-  La **ACF** decae lentamente y no corta a cero (signo de no
   estacionariedad).

-  Después de diferenciar una vez, la serie oscila alrededor de una
   media estable.

**2. Diferenciación estacional (D)**

Representa el número de diferencias aplicadas con un rezago igual al
período estacional :math:`s`:

.. math::


   (1 - L^s)^D y_t

**Propósito:**

-  Eliminar **tendencias o patrones repetitivos de largo plazo**,
   típicos de la estacionalidad.

-  Corregir la **no estacionariedad estacional** (por ejemplo,
   variaciones anuales, trimestrales o semanales crecientes).

**Ejemplo:**

Si los picos anuales de demanda o producción son cada vez mayores con el
paso de los años, aplicar una diferencia estacional (D = 1) estabiliza
esas fluctuaciones.

**Indicadores de que se necesita D = 1:**

-  La serie muestra **patrones estacionales que cambian de nivel**
   (picos o valles crecientes).

-  En la **ACF**, hay **picos grandes y persistentes** en los múltiplos
   de :math:`s` (por ejemplo, 12, 24, 36…).

-  Después de aplicar una diferencia estacional, los picos en los
   múltiplos de :math:`s` desaparecen.

**3. ¿Cuál diferenciación es más importante?**

No se trata de que una sea “más importante” en general, sino de cuál es
**más determinante según la estructura de la serie**:

+---------------------------------+--------------------------+--------+
| Tipo de no estacionariedad      | Diferenciación clave     | Razón  |
+=================================+==========================+========+
| Tendencia lineal o exponencial  | d                        | Co     |
| (nivel creciente o decreciente) |                          | ntrola |
|                                 |                          | la     |
|                                 |                          | ten    |
|                                 |                          | dencia |
|                                 |                          | g      |
|                                 |                          | eneral |
|                                 |                          | de la  |
|                                 |                          | serie. |
+---------------------------------+--------------------------+--------+
| Tendencia o patrón estacional   | D                        | Co     |
| cambiante (picos cada año más   |                          | ntrola |
| altos o más bajos)              |                          | la     |
|                                 |                          | es     |
|                                 |                          | tacion |
|                                 |                          | alidad |
|                                 |                          | cre    |
|                                 |                          | ciente |
|                                 |                          | o      |
|                                 |                          | ines   |
|                                 |                          | table. |
+---------------------------------+--------------------------+--------+
| Serie con ambas tendencias      | Ambas (d y D)            | Re     |
| (global + estacional)           |                          | quiere |
|                                 |                          | el     |
|                                 |                          | iminar |
|                                 |                          | ambas  |
|                                 |                          | formas |
|                                 |                          | de no  |
|                                 |                          | esta   |
|                                 |                          | cionar |
|                                 |                          | iedad. |
+---------------------------------+--------------------------+--------+

**En la práctica:**

-  Si la serie tiene una **tendencia fuerte pero estacionalidad
   estable** → la clave es :math:`d`.

-  Si la serie tiene una **estacionalidad cambiante pero sin tendencia
   general fuerte** → la clave es ( D ).

-  Si tiene **ambas**, primero se elimina la estacionalidad
   :math:`D = 1` y luego la tendencia :math:`( d = 1 )`.

**4. Orden recomendado de aplicación**

1. **Primero** probar la diferencia estacional :math:`(1 - L^s)`:

   Esto suele estabilizar la estacionalidad sin afectar el nivel
   general.

2. **Luego**, si la serie aún muestra tendencia, aplicar la diferencia
   no estacional :math:`(1 - L)`.

   Esto estabiliza el nivel.

| **Razón:** La estacionalidad tiende a ser más fuerte y visible, por lo
  que se corrige primero.
| Si se hace al revés, la serie puede sobrediferenciarse.

**5. Signos de sobrediferenciación**

-  Si al aplicar d o D la ACF muestra valores negativos alternos.

-  Si la serie diferenciada pierde estructura y se vuelve puramente
   ruido.

-  Si el modelo ajustado muestra varianza creciente o parámetros
   inestables.

En ese caso, se debe **reducir el orden de diferenciación** (usar d = 0
o D = 0).

**Resumen comparativo**

+--------+-------------------------------+----------------------------+
| A      | Diferenciación no estacional  | Diferenciación estacional  |
| specto | (d)                           | (D)                        |
+========+===============================+============================+
| Ob     | Eliminar tendencia general o  | Eliminar tendencia o       |
| jetivo | de nivel                      | patrón estacional          |
|        |                               | repetitivo                 |
+--------+-------------------------------+----------------------------+
| Op     | :math:`(1 - L)^d`             | :math:`(1 - L^s)^D`        |
| erador |                               |                            |
+--------+-------------------------------+----------------------------+
| Det    | ACF y PACF en rezagos cortos  | ACF y PACF en múltiplos de |
| ectada |                               | s                          |
| con    |                               |                            |
+--------+-------------------------------+----------------------------+
| I      | Corrige crecimiento o         | Corrige estacionalidad     |
| mpacto | descenso sostenido            | cambiante                  |
+--------+-------------------------------+----------------------------+
| Efecto | Serie pasa de creciente a     | Picos estacionales         |
| visual | oscilante                     | desaparecen                |
+--------+-------------------------------+----------------------------+
| Riesgo | Oscilación artificial o ruido | Pérdida de estructura      |
| si se  | blanco                        | estacional real            |
| usa en |                               |                            |
| exceso |                               |                            |
+--------+-------------------------------+----------------------------+
