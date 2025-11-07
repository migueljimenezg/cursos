Modelos ARIMA
-------------

**Modelos ARIMA (Autoregressive Integrated Moving Average)**

Los modelos ARIMA son una extensión de los modelos autorregresivos (AR)
y de media móvil (MA), que incorporan la posibilidad de **diferenciar**
la serie de tiempo para hacerla estacionaria.

El acrónimo **ARIMA(p, d, q)** está compuesto por tres parámetros:

-  **p**: orden del componente autorregresivo (AR).

-  **d**: número de diferenciaciones necesarias para lograr
   estacionariedad.

-  **q**: orden del componente de media móvil (MA).

**1. Componente autorregresivo (AR)**

El componente AR representa la dependencia de la variable con sus
valores pasados.

La forma general de un modelo AR(p) es:

.. math::


   y_t = c + \phi_1 y_{t-1} + \phi_2 y_{t-2} + \cdots + \phi_p y_{t-p} + \varepsilon_t

donde :math:`y_t` es la variable dependiente, :math:`\phi_i` son los
coeficientes autorregresivos y :math:`\varepsilon_t` es el término de
error.

**2. Componente de media móvil (MA)**

El componente MA modela la dependencia del valor actual con los errores
pasados.

La forma general de un modelo MA(q) es:

.. math::


   y_t = \mu  + \theta_1 \varepsilon_{t-1} + \theta_2 \varepsilon_{t-2} + \cdots + \theta_q \varepsilon_{t-q}+ \varepsilon_t

donde :math:`\theta_j` son los coeficientes de la media móvil y
:math:`\varepsilon_t` representa los errores aleatorios (ruido blanco).

**3. Componente integrado (I)**

El componente integrado se refiere a la diferenciación de la serie para
hacerla estacionaria.

Por ejemplo, una diferencia de primer orden se define como:

.. math::


   \nabla y_t = y_t - y_{t-1}

Si la serie requiere dos diferenciaciones, se aplica nuevamente la
diferencia sobre la serie ya diferenciada.

**4. Modelo ARIMA(p, d, q)**

Al combinar los tres componentes, se obtiene la forma general del modelo
ARIMA(p, d, q):

.. math::


   \phi(B)(1 - B)^d y_t = \theta(B)\varepsilon_t

donde :math:`B` es el operador de rezago (:math:`B y_t = y_{t-1}`),
:math:`\phi(B)` representa los términos autorregresivos y
:math:`\theta(B)` los términos de media móvil.

**5. Interpretación del modelo**

-  El término **AR(p)** captura la memoria de los valores pasados.

-  El término **I(d)** elimina tendencias o patrones no estacionarios.

-  El término **MA(q)** ajusta las fluctuaciones aleatorias no
   explicadas por el modelo AR.

El proceso completo implica:

1. Verificar la estacionariedad de la serie.

2. Aplicar transformaciones y diferenciaciones si es necesario.

3. Identificar los valores adecuados de p y q mediante el análisis de la
   ACF y PACF.

4. Estimar el modelo ARIMA(p, d, q).

5. Validar el ajuste con los residuales.

6. Realizar pronósticos.

**6. Ejemplo**

Un modelo **ARIMA(1,1,1)** puede escribirse como:

.. math::


   (1 - \phi_1 B)(1 - B)y_t = (1 + \theta_1 B)\varepsilon_t

que equivale a:

.. math::


   y_t - y_{t-1} = \phi_1 (y_{t-1} - y_{t-2})  + \theta_1 \varepsilon_{t-1}+ \varepsilon_t

Este modelo indica que la primera diferencia de la serie depende del
rezago anterior de esa diferencia y de los errores pasados.

**Fórmula del modelo ARIMA(2,1,2)**

El modelo **ARIMA(2,1,2)** combina:

-  Un componente **autorregresivo** de orden 2 (AR(2)).

-  Una **diferencia integrada** de orden 1 (I(1)) para hacer la serie
   estacionaria.

-  Un componente **de media móvil** de orden 2 (MA(2)).

**1. Representación general del modelo ARIMA(p, d, q)**

.. math::


   \phi(B)(1 - B)^d y_t = \theta(B)\varepsilon_t

donde:

-  :math:`B` es el operador de rezago tal que :math:`B y_t = y_{t-1}`

-  :math:`\phi(B)` es el polinomio autorregresivo

-  :math:`\theta(B)` es el polinomio de media móvil

-  :math:`\varepsilon_t` es el error aleatorio (ruido blanco)

**2. Sustituyendo los órdenes p = 2, d = 1 y q = 2:**

.. math::


   (1 - \phi_1 B - \phi_2 B^2)(1 - B)y_t = (1 + \theta_1 B + \theta_2 B^2)\varepsilon_t

**3. Expandiendo el término de diferenciación :math:`(1 - B)y_t`:**

.. math::


   (1 - \phi_1 B - \phi_2 B^2)(y_t - y_{t-1}) = (1 + \theta_1 B + \theta_2 B^2)\varepsilon_t

**4. Forma desarrollada del modelo ARIMA(2,1,2):**

.. math::


   y_t - y_{t-1} = \phi_1 (y_{t-1} - y_{t-2}) + \phi_2 (y_{t-2} - y_{t-3})  + \theta_1 \varepsilon_{t-1} + \theta_2 \varepsilon_{t-2}+ \varepsilon_t

**5. Interpretación:**

-  La **diferencia de primer orden** :math:`(y_t - y_{t-1})` representa
   el cambio de la serie entre periodos consecutivos.

-  Ese cambio depende de las **diferencias rezagadas** (memoria
   autorregresiva) y de los **errores pasados** (media móvil).

-  En términos prácticos, el modelo ARIMA(2,1,2) capta tanto la
   tendencia lineal como los patrones de corrección de errores en los
   pronósticos.

¿Cuándo se aplica d = 2 en un modelo ARIMA?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El parámetro **d** del modelo **ARIMA(p, d, q)** representa el **número
de diferenciaciones** aplicadas a la serie de tiempo para lograr que sea
**estacionaria en la media**.

-  Si **d = 0**, la serie ya es estacionaria.

-  Si **d = 1**, basta una sola diferencia para eliminar la tendencia.

-  Si **d = 2**, la serie presenta una tendencia **más fuerte o
   curvilínea**, y requiere **dos diferenciaciones sucesivas** para
   volverse estacionaria.

**1. Interpretación de la segunda diferencia**

La primera diferencia elimina una tendencia lineal.

.. math::


   \nabla y_t = y_t - y_{t-1}

La segunda diferencia elimina una tendencia cuadrática o una aceleración
en la tendencia.

.. math::


   \nabla^2 y_t = (y_t - y_{t-1}) - (y_{t-1} - y_{t-2}) = y_t - 2y_{t-1} + y_{t-2}

Por tanto, **d = 2** se aplica cuando la serie muestra un **crecimiento
o decrecimiento con aceleración**, es decir, cuando la tasa de cambio
también tiene una tendencia.

**2. Situaciones típicas donde se requiere d = 2**

-  Series con **tendencia cuadrática o parabólica**, como crecimiento
   económico a largo plazo, producción acumulada o consumo energético
   con aceleración.

-  Cuando la **primera diferencia** aún muestra una tendencia ascendente
   o descendente en el tiempo.

-  Cuando la **prueba ADF** aplicada a la serie diferenciada una vez
   todavía no rechaza la hipótesis nula de raíz unitaria (no
   estacionariedad).

**3. Cómo verificar si d = 2 es necesario**

1. Graficar la serie original y observar si la tendencia parece
   **curva** o con **aceleración**.

2. Aplicar una diferencia y volver a graficar.

3. Si la serie diferenciada aún muestra una tendencia, aplicar una
   segunda diferencia.

4. Verificar con la **prueba ADF (Augmented Dickey-Fuller)** si después
   de la segunda diferencia la serie se vuelve estacionaria.

Cómo determinar el orden p y q en un modelo ARIMA
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Una vez que la serie es estacionaria (después de aplicar las
transformaciones y las diferencias necesarias), se identifican los
valores apropiados de **p** y **q** mediante el análisis de las
funciones de autocorrelación (ACF) y autocorrelación parcial (PACF).

**1. Función de autocorrelación (ACF)**

La **ACF** muestra la correlación entre la serie y sus rezagos.

Es útil para identificar el orden **q** del componente de **media móvil
(MA)**.

-  Si la ACF corta bruscamente (decay) después de cierto lag, ese punto
   sugiere el valor de **q**.

-  Si la ACF decae lentamente, podría indicar la presencia de un
   componente AR.

**2. Función de autocorrelación parcial (PACF)**

La **PACF** mide la correlación entre la serie y sus rezagos
**descontando la influencia de los rezagos intermedios**.

Es útil para identificar el orden **p** del componente **autorregresivo
(AR)**.

-  Si la PACF corta bruscamente después de cierto lag, ese punto sugiere
   el valor de **p**.

-  Si la PACF decae lentamente, puede indicar un componente MA.

**3. Reglas prácticas para identificar p y q**

+------------------------------------+---------------------------------+
| Patrón observado                   | Modelo sugerido                 |
+====================================+=================================+
| ACF corta después de lag q, PACF   | MA(q)                           |
| decae gradualmente                 |                                 |
+------------------------------------+---------------------------------+
| PACF corta después de lag p, ACF   | AR(p)                           |
| decae gradualmente                 |                                 |
+------------------------------------+---------------------------------+
| Tanto ACF como PACF decaen         | ARMA(p, q) o ARIMA(p, d, q)     |
| gradualmente                       | combinado                       |
+------------------------------------+---------------------------------+

¿Por qué se aplica un modelo ARIMA?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El modelo **ARIMA** se aplica cuando se desea **pronosticar una serie de
tiempo** que presenta **comportamientos no estacionarios**, es decir,
cuando su media o varianza cambian con el tiempo.

El objetivo principal del modelo ARIMA es **convertir una serie no
estacionaria en estacionaria** mediante diferenciación y luego **modelar
las dependencias temporales** entre los valores pasados y los errores
del modelo.

**1. Justificación principal**

| La mayoría de las técnicas estadísticas y econométricas requieren que
  la serie sea estacionaria.
| Sin embargo, las series reales (como precios, demanda, producción o
  caudales) suelen tener tendencia o ciclos.
| El modelo ARIMA permite manejar esta situación al integrar tres
  componentes:

-  **AR (Autoregressive):** explica la dependencia del valor actual con
   sus propios rezagos.

-  **I (Integrated):** diferencia la serie para eliminar tendencias y
   hacerla estacionaria.

-  **MA (Moving Average):** explica la dependencia con los errores
   pasados del modelo.

De esta forma, el modelo combina la memoria de los valores pasados con
la corrección de los errores de predicción previos.

**2. Cuándo se aplica ARIMA**

El modelo ARIMA se aplica cuando:

-  La serie es **univariada** (solo depende de sus propios valores
   pasados).

-  Presenta **tendencia** o **no estacionariedad en la media**.

-  No hay estacionalidad clara o ya fue eliminada (en caso contrario se
   usa SARIMA).

-  Se desea **pronosticar el comportamiento futuro** de la variable a
   corto o mediano plazo.

**3. Ventajas del modelo ARIMA**

-  Se basa únicamente en los valores históricos de la serie, sin
   requerir variables externas.

-  Es flexible y puede capturar diversos patrones de autocorrelación.

-  Permite una interpretación clara de los parámetros :math:`p`,
   :math:`d`, y :math:`q`.

-  Su estimación está bien fundamentada teóricamente y cuenta con
   métodos robustos de validación.

**4. Limitaciones del modelo ARIMA**

-  No capta bien la **estacionalidad** (para ello se usa **SARIMA**).

-  No maneja **relaciones con variables exógenas** (para ello se usa
   **ARIMAX** o **SARIMAX**).

-  Requiere que la serie tenga una estructura lineal; no modela
   relaciones no lineales.

Método automatizado: AutoARIMA
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

En lugar de seleccionar manualmente p y q, se puede utilizar un
procedimiento automático llamado **AutoARIMA**.

Este método prueba **muchas combinaciones posibles de (p, d, q)** y
selecciona aquella que **minimiza un criterio de información (AIC o
BIC)**.

El proceso consiste en:

1. Evaluar distintos valores de p y q dentro de un rango predefinido
   (por ejemplo, de 0 a 5).

2. Estimar el modelo ARIMA(p, d, q) para cada combinación.

3. Calcular los criterios de información (AIC, BIC).

4. Seleccionar el modelo con el valor más bajo.

Este procedimiento se conoce como **búsqueda de rejilla (grid search)**
sobre los parámetros p y q.

**Ejemplo**

Supongamos que el rango de búsqueda es:

-  :math:`p = 0, 1, 2`

-  :math:`d = 0, 1`

-  :math:`q = 0, 1, 2`

Se estiman todas las combinaciones posibles (18 modelos en total):

.. math::


   (0,0,0), (0,0,1), (0,0,2), (1,0,0), (1,0,1), (1,0,2), (2,0,0), \ldots, (2,1,2)

Luego se elige el modelo con menor AIC o BIC, por ejemplo
**ARIMA(1,1,1)**.

**Relación entre ACF/PACF y AutoARIMA**

-  La ACF y PACF pueden servir como **punto de partida visual** para
   acotar el rango de búsqueda.

   Por ejemplo, si la PACF sugiere rezagos hasta 2, se podría definir
   ``max_p=3``.

-  Sin embargo, **AutoARIMA puede probar valores más altos** para p y q
   si se sospecha que el patrón temporal es más complejo.

En otras palabras, **la ACF y la PACF orientan**, pero **AutoARIMA
experimenta y confirma estadísticamente** cuál combinación de órdenes da
el mejor ajuste.

**¿Qué se hace después de seleccionar el modelo con AutoARIMA?**

Una vez que el algoritmo **AutoARIMA** sugiere el mejor modelo (por
ejemplo, ARIMA(2,1,1)), no significa que el trabajo haya terminado.

Ese modelo debe **validarse estadísticamente** y **diagnosticarse** para
asegurar que cumple las condiciones de un buen modelo de series de
tiempo.

El proceso posterior se divide en tres pasos fundamentales:

**1. Verificación de la significancia de los parámetros**

Cada coeficiente estimado del modelo debe ser **estadísticamente
significativo**.

Si alguno de los coeficientes (por ejemplo :math:`\phi_2` o
:math:`\theta_1`) no es significativo, puede eliminarse y volver a
estimar el modelo con un orden más simple.

El objetivo es obtener un modelo **parsimonioso**, es decir, con el
menor número de parámetros posibles pero que mantenga un buen ajuste.

**2. Análisis de los residuales del modelo**

Una vez ajustado el modelo, se analiza el comportamiento de los
**residuales** (:math:`\varepsilon_t`), que representan la parte no
explicada por el modelo.

Un buen modelo debe generar residuales que sean:

-  **Ruido blanco:** sin autocorrelación (independientes en el tiempo).

-  **Media cero:** :math:`\mathbb{E}[\varepsilon_t] = 0`.

-  **Varianza constante (homocedasticidad):** sin cambios en la
   dispersión a lo largo del tiempo.

-  **Distribución aproximadamente normal.**

Para evaluar estas condiciones se utilizan:

-  Gráfico de **residuales en el tiempo** (para ver si hay patrones).

-  Gráfico de **histograma** y **Q-Q plot** (para ver normalidad).

-  Gráficos de **ACF y PACF de los residuales** (deben estar dentro de
   las bandas de significancia).

-  **Pruebas estadísticas:**

   -  Ljung–Box: para verificar independencia temporal.

   -  Jarque–Bera: para evaluar normalidad.

Si los residuales muestran autocorrelación significativa o no son ruido
blanco, el modelo debe ajustarse nuevamente (modificando p o q).

**3. Evaluación del ajuste y pronóstico**

Una vez confirmada la validez del modelo, se puede evaluar su desempeño
predictivo mediante:

-  Comparación entre valores reales y ajustados.

-  Métricas de error como:

   -  **MAE (Mean Absolute Error)**

   -  **MSE (Mean Squared Error)**

   -  **RMSE (Root Mean Squared Error)**

   -  **MAPE (Mean Absolute Percentage Error)**

Luego se procede a **realizar pronósticos fuera de la muestra**, junto
con sus **intervalos de confianza**.

**¿Qué pasa si el modelo cumple con todos los criterios de residuales y
pronostica bien, pero uno o dos parámetros no son significativos?**

Esta es una situación frecuente en la modelación de series de tiempo con
ARIMA.

Aunque el análisis de residuales y las métricas de pronóstico sean
adecuados, la **no significancia de algunos parámetros** puede tener
varias interpretaciones.

**1. Recordatorio: qué significa un parámetro no significativo**

Un parámetro no significativo (por ejemplo, :math:`\phi_2` o
:math:`\theta_1` con :math:`p > 0.05`) indica que, estadísticamente,
**no hay evidencia suficiente para afirmar que ese coeficiente es
distinto de cero**.

En otras palabras, su efecto sobre la variable puede ser **muy pequeño o
nulo**, según la información contenida en los datos.

**2. Dos posibles enfoques de decisión**

**a) Enfoque estadístico (parsimonia):**

-  Si el objetivo es interpretar el modelo o presentar un ajuste
   econométrico formal, se recomienda **eliminar los parámetros no
   significativos**.

-  Esto conduce a un modelo más simple (**parsimonioso**) y con
   coeficientes estadísticamente válidos.

-  Luego se vuelve a ajustar el modelo con los parámetros restantes y se
   verifican nuevamente los residuales.

**b) Enfoque predictivo (pragmático):**

-  Si el objetivo principal es **pronosticar** y el modelo tiene **buen
   desempeño predictivo y residuales adecuados**, puede **mantenerse tal
   como está**.

-  En contextos de forecasting, lo importante es la **precisión de las
   predicciones**, no necesariamente la significancia individual de cada
   coeficiente.

**3. Recomendación práctica**

-  Si los parámetros no significativos tienen **valores pequeños**, su
   eliminación probablemente **no afectará el pronóstico**.

-  Si al quitarlos el modelo **pierde calidad predictiva** o **empeoran
   los residuales**, es preferible **mantenerlos**, incluso si no son
   estadísticamente significativos.

En resumen:

================================== =====================================
Objetivo                           Decisión recomendada
================================== =====================================
Interpretación teórica o académica Eliminar parámetros no significativos
Pronóstico práctico o aplicado     Mantener el modelo si pronostica bien
================================== =====================================

**4. Nota importante**

La no significancia también puede deberse a:

-  **Multicolinealidad temporal** entre rezagos.

-  **Tamaño de muestra reducido** (pocos datos).

-  **Sobreparametrización** (modelo con más rezagos de los necesarios).

En esos casos, probar un modelo con menor orden :math:`p` o :math:`q`
puede mejorar la significancia.

**Conclusión**

Si el modelo ARIMA cumple con todos los criterios de diagnóstico
(residuales como ruido blanco, homocedasticidad, normalidad) y genera
**buenos pronósticos**, **no es obligatorio eliminar los parámetros no
significativos**.

La decisión final depende del propósito del análisis:

-  **Si se busca interpretación**, debe simplificarse.

-  **Si se busca predicción**, puede conservarse mientras el desempeño
   se mantenga sólido.
