Análisis de los residuales
--------------------------

Después de ajustar y seleccionar un modelo de series de tiempo, el
siguiente paso fundamental es analizar los **residuales**.

Los residuales representan la parte de la serie que no ha sido explicada
por el modelo.

**Definición de residuales**

Los residuales se definen como la diferencia entre los valores
observados y los valores ajustados por el modelo:

:math:`e_t = y_t - \hat{y}_t`

donde :math:`y_t` es el valor observado y :math:`\hat{y}_t` es el valor
pronosticado o ajustado.

En modelos de regresión, la ecuación general puede expresarse como:

:math:`e_t = y_t - \hat{\beta}_0 - \hat{\beta}_1 x_{1,t} - \hat{\beta}_2 x_{2,t} - \dots - \hat{\beta}_k x_{k,t}`

**Importancia de los residuales**

El análisis de los residuales permite verificar si el modelo ha
capturado adecuadamente la información contenida en los datos.

Un buen modelo debe dejar residuales que se asemejen a un **ruido
blanco**, es decir, que sean aleatorios e independientes.

Propiedades deseadas de los residuales
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Un modelo adecuado debería producir residuales con las siguientes
propiedades:

1. Los residuales son **no correlacionados**.

   Si los residuales están correlacionados, significa que hay
   información no capturada por el modelo.

2. Los residuales tienen **media cero**.

   Si la media de los residuales es distinta de cero, los pronósticos
   son sesgados.

3. Los residuales tienen **varianza constante** (homocedasticidad).

   Si la varianza cambia con el tiempo, puede existir
   heterocedasticidad.

4. Los residuales son **normalmente distribuidos**.

   Esto facilita el cálculo de intervalos de predicción.

**Interpretación**

| Cuando estas condiciones se cumplen, los residuales pueden
  considerarse como ruido blanco.
| Esto indica que el modelo ha capturado toda la información relevante y
  que los errores se deben únicamente al azar.

Gráficos y pruebas para el análisis de residuales
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para evaluar si las propiedades anteriores se cumplen, se utilizan
diferentes herramientas gráficas y estadísticas:

**1. Gráfico de residuales en el tiempo**

| Permite observar si los residuales fluctúan alrededor de cero sin
  mostrar patrones sistemáticos.
| Una tendencia o cambio en la variabilidad a lo largo del tiempo
  sugiere que el modelo no es adecuado.

**2. ACF de los residuales**

| El gráfico de la función de autocorrelación (ACF) muestra si los
  residuales están correlacionados entre sí.
| Si la mayoría de las barras se encuentran dentro de las bandas de
  confianza, los residuales no presentan autocorrelación.

La **PACF** de los residuales puede usarse como **complemento** para
identificar el tipo de dependencia que aún persiste.

Por ejemplo:

-  Si la PACF muestra un rezago significativo, puede sugerir que falta
   un término autorregresivo (AR).

-  Si la ACF muestra un patrón significativo pero la PACF se corta
   rápidamente, puede indicar que falta un término de promedio móvil
   (MA).

En otras palabras, la PACF en los residuales **ayuda a diagnosticar**
qué tipo de estructura quedó sin modelar, aunque el diagnóstico formal
se basa principalmente en la ACF y en la prueba de Ljung–Box.

Se pueden aplicar pruebas como la **Breusch-Godfrey** o la **Ljung-Box**
para evaluar la autocorrelación.

**3. Prueba de Ljung-Box**

-  **Hipótesis nula (:math:`H_0`):** Los residuales son independientes
   (no autocorrelados).

-  **Hipótesis alternativa (:math:`H_1`):** Los residuales están
   correlacionados.

Si el valor p es mayor que 0.05, **no se rechaza** la hipótesis nula y
los residuales se pueden considerar independientes.

Si el valor p es menor que 0.05, **se rechaza** la hipótesis nula,
indicando autocorrelación y un modelo posiblemente mal especificado.

-  Si tanto la ACF como la PACF de los residuales están dentro de las
   bandas de confianza, y la prueba de Ljung–Box no rechaza la hipótesis
   nula de independencia, entonces los residuales se comportan como
   ruido blanco y el modelo es adecuado.

-  Si en la ACF o PACF aparecen picos significativos, significa que aún
   existe dependencia temporal no explicada por el modelo.

**4. Histograma de los residuales**

Permite visualizar la distribución de los residuales.

Idealmente debe aproximarse a una distribución normal centrada en cero.

**5. Q-Q Plot (Quantile-Quantile Plot)**

El Q-Q plot compara los cuantiles de los residuales con los de una
distribución normal teórica.

-  Si los puntos siguen aproximadamente una línea recta sobre
   :math:`y = x`, los residuales son normales.

-  Si los puntos se desvían sistemáticamente, los residuales no son
   normales.

**6. Gráfico de valores predichos vs. valores reales**

Este gráfico compara directamente los valores observados :math:`y_t` con
los valores ajustados o pronosticados :math:`\hat{y}_t`.

-  **Eje X:** valores reales (:math:`y_t`)

-  **Eje Y:** valores predichos (:math:`\hat{y}_t`)

**Interpretación:**

-  Si el modelo es bueno, los puntos deben alinearse cerca de la línea
   de 45° (línea de identidad :math:`y = x`).

-  Si los puntos se desvían sistemáticamente (por ejemplo, el modelo
   sobreestima o subestima en ciertos rangos), indica **sesgo** o una
   **relación no capturada**.

**Propósito:** evaluar **la capacidad predictiva global del modelo.**

Heterocedasticidad y Homocedasticidad de los residuales
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Los residuales deben comportarse como **ruido blanco**, es decir:

-  tener **media cero**,

-  ser **independientes** (no autocorrelacionados), y

-  tener **varianza constante** en el tiempo.

A esta última propiedad se le llama **homocedasticidad**.

**Homocedasticidad**

Se dice que los residuales son **homocedásticos** cuando su **dispersión
(varianza)** se mantiene **constante a lo largo del tiempo** o frente a
los valores ajustados.

Gráficamente:

-  Los puntos del gráfico de **residuales vs. valores ajustados** se ven
   **aleatorios y uniformemente dispersos**.

-  No hay zonas donde los errores sean sistemáticamente más grandes o
   más pequeños.

Ejemplo visual ideal:

   Los residuales se agrupan de forma aleatoria y con amplitud similar
   en toda la gráfica. No se observa forma de embudo ni patrón.

Esto indica que el modelo **explica bien la varianza** y que los errores
**no dependen del nivel de la variable**.

**Heterocedasticidad**

Se presenta **heterocedasticidad** cuando la **varianza de los
residuales cambia con el tiempo** o con el nivel de la variable
ajustada.

Gráficamente:

-  Aparece una **forma de embudo** en el gráfico de residuales
   vs. valores ajustados.

-  Los errores pequeños se agrupan en un extremo y los grandes en otro.

Matemáticamente, la varianza de los errores no es constante:

.. math::


   Var(e_t) = \sigma_t^2 \neq \text{constante}

Esto significa que los errores son más amplios (volátiles) en ciertos
períodos o niveles.

**Causas comunes de heterocedasticidad**

-  La variable dependiente tiene una escala muy amplia (por ejemplo,
   precios o demanda eléctrica).

-  Falta de alguna **transformación estabilizadora de varianza** (log,
   raíz cuadrada, Box–Cox).

-  Relación **no lineal** entre las variables.

-  Presencia de **cambios estructurales** o períodos con volatilidad
   distinta (muy común en series financieras).

**Cómo detectar heterocedasticidad**

-  | **Visualmente:** con un gráfico de residuales vs. valores ajustados
     o vs. tiempo.
   | Si hay un patrón de embudo o aumento de la dispersión →
     heterocedasticidad.

-  **Estadísticamente:** con pruebas específicas, por ejemplo:

   -  **Breusch–Pagan test**

   -  **White test**

   -  **Heteroskedasticity (H)** que entrega ``statsmodels`` en el
      resumen de los modelos de series de tiempo.

En ``statsmodels``: Si el **p-valor (Prob(H)) < 0.05**, se **rechaza la
hipótesis nula de varianza constante** → los residuales son
**heterocedásticos**.

Si **p > 0.05**, no hay evidencia de heterocedasticidad →
**homocedasticidad**.

**Consecuencias de la heterocedasticidad**

-  **No invalida el modelo**, pero afecta la **eficiencia estadística**
   de las estimaciones.

-  Los **intervalos de predicción** y las **bandas de confianza** pueden
   ser **incorrectos** (demasiado angostos o anchos).

-  Los **valores extremos** o períodos de alta volatilidad pueden quedar
   mal representados.

En modelos de series de tiempo, esto se traduce en pronósticos menos
confiables durante los períodos de alta variabilidad.

**Cómo corregir la heterocedasticidad**

1. **Transformar la variable dependiente**:

   -  Logaritmo: ``y' = log(y)``

   -  Raíz cuadrada: ``y' = √y``

   -  Box–Cox: ``y' = (y^λ - 1) / λ``

   Estas transformaciones **estabilizan la varianza** y reducen la
   amplitud del embudo.

2. **Modelar explícitamente la varianza**:

   -  Modelos **ARCH / GARCH**, si la varianza depende del tiempo (común
      en datos financieros).

   -  Modelos **SARIMAX-GARCH** para capturar tanto la media como la
      varianza condicional.

Outliers e influencias
~~~~~~~~~~~~~~~~~~~~~~

Los valores extremos en los residuales pueden indicar **outliers** o
**observaciones influyentes**.

| Estos puntos pueden afectar los parámetros estimados y distorsionar el
  modelo.
| Es importante identificar su causa y decidir si deben excluirse o
  analizarse por separado.

Resumen
~~~~~~~

Un buen modelo debe cumplir:

-  Residuales sin autocorrelación (ruido blanco).

-  Media de los residuales cercana a cero.

-  Varianza constante (homocedasticidad).

-  Distribución aproximadamente normal.

-  Ausencia de outliers influyentes.

Si alguna de estas condiciones no se cumple, el modelo puede mejorarse
mediante:

-  Inclusión de rezagos adicionales.

-  Incorporación de variables omitidas.

-  Transformaciones de la variable dependiente (por ejemplo, logaritmo o
   Box-Cox).

-  Cambio en la especificación del modelo (por ejemplo, pasar de ARIMA a
   SARIMA o agregar términos estacionales).

**Conclusión**

El análisis de los residuales es el paso final antes de realizar
pronósticos.

Permite verificar la validez del modelo, detectar sesgos o
autocorrelaciones no capturadas y confirmar que el modelo produce
errores aleatorios.

Solo cuando los residuales se comportan como ruido blanco, el modelo
puede considerarse listo para realizar pronósticos confiables.

Resultados de Statsmodels
~~~~~~~~~~~~~~~~~~~~~~~~~

**Interpretación de los estadísticos de diagnóstico del modelo (salida
de statsmodels)**

Después de ajustar un modelo con ``statsmodels``, el resumen incluye
varias pruebas estadísticas que permiten evaluar si los **residuales
cumplen los supuestos básicos** de un buen modelo: independencia,
normalidad y homocedasticidad.

A continuación se explican los principales indicadores:

**1. Ljung–Box (L1) (Q)**

-  **Propósito:** Evalúa si los residuales están autocorrelacionados.

-  **Hipótesis nula (:math:`H_0`):** Los residuales son independientes
   (no hay autocorrelación).

-  **Estadístico Q:** Mide el grado de autocorrelación conjunta hasta
   cierto número de rezagos (en este caso, L1 = lag 1).

-  **Prob(Q):** Es el valor p asociado al test.

**Interpretación:**

-  Si **Prob(Q) > 0.05**, **no se rechaza :math:`H_0`**, lo cual
   significa que los residuales **no presentan autocorrelación** → el
   modelo explica bien la dependencia temporal.

-  Si **Prob(Q) < 0.05**, **se rechaza :math:`H_0`**, indicando
   **autocorrelación remanente** → el modelo no capturó toda la dinámica
   temporal.

**2. Jarque–Bera (JB)**

-  **Propósito:** Evalúa la **normalidad** de los residuales.

-  **Hipótesis nula (:math:`H_0`):** Los residuales siguen una
   distribución normal.

-  **Estadístico JB:** Se basa en la asimetría (Skew) y la curtosis
   (Kurtosis) de los residuales.

-  **Prob(JB):** Valor p asociado al test.

**Interpretación:**

-  Si **Prob(JB) > 0.05**, **no se rechaza :math:`H_0`** → los
   residuales son **aproximadamente normales.**

-  Si **Prob(JB) < 0.05**, **se rechaza :math:`H_0`** → los residuales
   **no son normales** (pueden tener sesgo o colas pesadas).

Esto afecta principalmente la **validez de los intervalos de
predicción** y las pruebas t/z, pero no necesariamente el pronóstico
promedio.

**3. Heteroskedasticity (H)**

-  **Propósito:** Evalúa si los residuales tienen **varianza constante**
   (homocedasticidad).

-  **Hipótesis nula (:math:`H_0`):** Los residuales tienen **varianza
   constante** (homocedásticos).

-  **Estadístico H:** Es la razón entre las varianzas de dos
   subconjuntos de residuales.

-  **Prob(H):** Valor p asociado al test bilateral.

**Interpretación:**

-  Si **Prob(H) > 0.05**, **no se rechaza :math:`H_0`** → los residuales
   tienen varianza constante.

-  Si **Prob(H) < 0.05**, **se rechaza :math:`H_0`** → hay
   **heterocedasticidad** → el modelo tiene varianza variable (por
   ejemplo, más dispersión en ciertos periodos).

**4. Skew (asimetría)**

-  Mide la **simetría** de la distribución de los residuales.

-  Valor esperado para una distribución normal: **0**.

   -  Skew > 0 → distribución sesgada a la derecha (cola larga
      positiva).

   -  Skew < 0 → distribución sesgada a la izquierda (cola larga
      negativa).

**Interpretación:**

Un valor de Skew moderado (por ejemplo, ±0.5) indica **asimetría leve**;
valores mayores de ±1 indican **asimetría significativa**.

**5. Kurtosis (curtosis o apuntamiento)**

-  Mide qué tan “picuda” o “aplanada” es la distribución de los
   residuales comparada con una normal.

-  Valor esperado para una distribución normal: **3**.

   -  Kurtosis > 3 → colas más pesadas (leptocúrtica).

   -  Kurtosis < 3 → colas más ligeras (platicúrtica).

**Interpretación:**

Un valor alto de curtosis (por ejemplo, >4) indica que hay más valores
extremos (outliers) de lo esperado bajo normalidad.
