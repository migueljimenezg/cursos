AR
--

**Modelos Autorregresivos AR(p)**

Un modelo **autorregresivo (AR)** es un tipo de modelo de series de
tiempo donde el valor actual de la serie depende de sus propios valores
pasados más un término de error aleatorio. Se llaman *autorregresivos*
porque la serie “se explica a sí misma” a partir de sus rezagos.

En términos simples:

.. math::


   y_t = \alpha + \beta_t + \phi_1 y_{t-1} + \phi_2 y_{t-2} + \cdots + \phi_p y_{t-p} + \varepsilon_t

-  :math:`y_t`: valor actual de la serie

-  :math:`\alpha`: constante o media ajustada :math:`\mu`

-  :math:`\beta_t` es la **tendencia lineal en el tiempo**

-  :math:`\phi_1, \phi_2, \dots, \phi_p`: coeficientes que indican
   cuánto pesa cada valor pasado

-  :math:`p`: número de rezagos que se usan (el “orden” del modelo)

-  :math:`\varepsilon_t`: error aleatorio o “ruido blanco” (media cero,
   varianza constante, no correlacionado)

**AR(1): el caso más simple**

En un **AR(1)** el valor actual depende **solo del último valor
pasado**:

.. math::


   y_t = \alpha + \phi_1 y_{t-1} + \varepsilon_t

-  Si :math:`\phi_1` es positivo y cercano a 1, la serie muestra mucha
   persistencia (los valores grandes suelen seguir a valores grandes).

-  Si :math:`\phi_1` es negativo, la serie tiende a oscilar: un valor
   alto es seguido por uno bajo, y viceversa.

-  Si :math:`\phi_1 = 0`, el modelo se reduce a una serie de ruido
   blanco.

Este modelo es análogo a una **regresión lineal simple**, donde la
variable dependiente es el valor actual y la variable explicativa es el
valor inmediatamente anterior.

**¿Para qué tipos de series de tiempo se usa?**

Estacionarias en media y varianza (o que pueden hacerse estacionarias
con transformaciones/ diferencias).

Sin tendencia ni estacionalidad fuerte (si existen, se suelen remover
antes: diferenciar para tendencia; desestacionalizar o pasar a SARIMA).

Con memoria corta: el pasado cercano explica el presente y el efecto de
choques se amortigua con el tiempo.

**Propiedades básicas:**

-  La media de la serie es constante si :math:`|\phi_1| < 1`.

-  La varianza es estable y finita bajo esa misma condición.

-  El efecto de un choque :math:`\varepsilon_t` se diluye en el tiempo
   de manera exponencial.

**AR(p): el caso general**

Un **AR(p)** amplía la idea al permitir que el valor actual dependa de
varios rezagos:

.. math::


   y_t = \alpha + \phi_1 y_{t-1} + \phi_2 y_{t-2} + \cdots + \phi_p y_{t-p} + \varepsilon_t

Es como una **regresión múltiple**, donde las variables explicativas son
los últimos :math:`p` valores de la serie. Cada coeficiente
:math:`\phi_i` indica cuánto influye el valor de la serie en el rezago
:math:`i`.

**Cómo se estiman los parámetros**

El modelo se ajusta como una regresión:

.. math::


   \hat{y}_t = \hat{\alpha} + \hat{\phi}_1 y_{t-1} + \hat{\phi}_2 y_{t-2} + \cdots + \hat{\phi}_p y_{t-p}

Los residuos son:

.. math::


   \hat{\varepsilon}_t = y_t - \hat{y}_t

Y se espera que se comporten como ruido blanco.

Los coeficientes se pueden estimar mediante **mínimos cuadrados** o
**máxima verosimilitud.**

**Analogía sencilla**

Imagina que el **clima de hoy** depende de cómo fue el clima de los
últimos días:

-  Si solo depende del **día anterior**, tenemos un AR(1).

-  Si además influye el clima de los **últimos tres días**, estamos en
   un AR(3).

El modelo AR “aprende” cuánto peso darle a cada día pasado para hacer
una predicción del presente o del futuro.

**Condición de estabilidad y el valor de φ**

Para que un modelo AR(p) sea **estacionario y estable**, los parámetros
deben cumplir ciertas condiciones.

En el caso de un **AR(1)**:

.. math::


   y_t = \alpha + \phi_1 y_{t-1} + \varepsilon_t

La condición es:

.. math::


   |\phi_1| < 1

**¿Por qué?**

-  Si :math:`|\phi_1| < 1`, los efectos de un choque
   :math:`\varepsilon_t` se van diluyendo en el tiempo.

   Ejemplo: si :math:`\phi_1 = 0.7`, un shock de 10 se convierte en 7 el
   siguiente periodo, luego 4.9, luego 3.43, y así sucesivamente hasta
   desaparecer.

-  Si :math:`|\phi_1| = 1`, el efecto **no se disipa**: tenemos una raíz
   unitaria. Esto corresponde a un **paseo aleatorio**, que no es
   estacionario porque la varianza crece sin límite.

-  Si :math:`|\phi_1| > 1`, los efectos de un shock se **amplifican**
   con el tiempo y la serie explota, volviéndose inestable.

**Generalización al AR(p)**

En un modelo **AR(p)**:

.. math::


   y_t = \alpha + \phi_1 y_{t-1} + \phi_2 y_{t-2} + \cdots + \phi_p y_{t-p} + \varepsilon_t

la condición de estabilidad se expresa en términos del **polinomio
característico**:

.. math::


   1 - \phi_1 L - \phi_2 L^2 - \cdots - \phi_p L^p = 0

donde :math:`L` es el operador rezago.

-  Para que el modelo sea estable, **todas las raíces de este polinomio
   deben estar fuera del círculo unitario**, es decir, deben tener un
   módulo mayor que 1.

-  Dicho de otra forma: ningún valor de :math:`L` dentro del círculo
   unitario (radio 1 en el plano complejo) debe anular la ecuación.

**Intuición del círculo unitario**

El círculo unitario es una forma matemática de decir:

-  **Dentro del círculo** (:math:`|\phi| < 1`): el proceso es estable,
   los choques se disipan.

-  **En el borde** (:math:`|\phi| = 1`): el proceso tiene raíz unitaria,
   no es estacionario (ejemplo típico: paseo aleatorio).

-  **Fuera del círculo** (:math:`|\phi| > 1`): el proceso explota, los
   choques se amplifican con el tiempo.

El operador rezago (lag operator)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El operador rezago se denota por :math:`L` y simplemente significa
**“llevar la serie un paso hacia atrás”**.

Por definición:

.. math::


   L y_t = y_{t-1}

y de manera general:

.. math::


   L^k y_t = y_{t-k}

Es decir, aplicar :math:`L` una vez es ir un periodo atrás, aplicarlo
:math:`k` veces es ir :math:`k` periodos atrás.

**Ejemplo sencillo**

Supongamos una serie :math:`y_t` con valores:

-  En :math:`t=5`, :math:`y_5 = 10`

-  Aplicamos :math:`L`: :math:`L y_5 = y_4`

-  Aplicamos :math:`L^2`: :math:`L^2 y_5 = y_3`

El operador rezago funciona como una “máquina del tiempo” que desplaza
la serie hacia el pasado.

**Usando el rezago en modelos AR**

Un **AR(1)**:

.. math::


   y_t = \alpha + \phi_1 y_{t-1} + \varepsilon_t

se puede escribir con el operador rezago como:

.. math::


   y_t = \alpha + \phi_1 L y_t + \varepsilon_t

Reordenando:

.. math::


   (1 - \phi_1 L) y_t = \alpha + \varepsilon_t

**Generalización al AR(p)**

El modelo:

.. math::


   y_t = \alpha + \phi_1 y_{t-1} + \phi_2 y_{t-2} + \cdots + \phi_p y_{t-p} + \varepsilon_t

usando el operador rezago queda:

.. math::


   (1 - \phi_1 L - \phi_2 L^2 - \cdots - \phi_p L^p) y_t = \alpha + \varepsilon_t

**El polinomio característico**

La parte entre paréntesis se llama **polinomio característico**:

.. math::


   \Phi(L) = 1 - \phi_1 L - \phi_2 L^2 - \cdots - \phi_p L^p

La condición de estabilidad es que las **raíces de :math:`\Phi(L)` estén
fuera del círculo unitario**, es decir, que tengan módulo mayor que 1.

Esto garantiza que los choques :math:`\varepsilon_t` no se acumulen sino
que se disipen con el tiempo.

**Intuición final**

-  El operador :math:`L` es solo una forma compacta de escribir
   “rezagos”.

-  Gracias a :math:`L`, podemos representar un modelo AR(p) como un
   polinomio.

-  Revisar las **raíces del polinomio** nos dice si la serie es
   **estable (estacionaria)** o si tiene una **raíz unitaria** (paseo
   aleatorio) o incluso si **explota**.

👉 Así, el operador rezago no es un “truco raro”, sino una herramienta
matemática que simplifica la escritura y el análisis de modelos
autorregresivos.

Cómo determinar el orden p en un modelo AR(p)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Elegir el número de rezagos :math:`p` es una de las decisiones más
importantes en los modelos autorregresivos.

Existen tres enfoques principales: **ACF/PACF**, **criterios de
información** y **validación de residuales**.

**1. Análisis visual con ACF y PACF**

-  **ACF (Función de Autocorrelación):**

   Muestra cómo se correlaciona la serie con sus propios rezagos.

   En un AR(p), la ACF no corta bruscamente; en cambio, **decae de forma
   gradual** (exponencial u oscilante). Un modelo **AR(p)**
   (autorregresivo) se caracteriza por tener una **dependencia del
   pasado** que se **disipa gradualmente** en el tiempo. Por eso, en
   teoría, la **ACF de un proceso AR(p)** **no corta bruscamente**, sino
   que **decae suavemente** (a veces de forma exponencial, a veces
   oscilando).

-  **PACF (Función de Autocorrelación Parcial):**

   Mide la correlación entre :math:`y_t` y :math:`y_{t-k}` eliminando la
   influencia de los rezagos intermedios.

   En un AR(p), la PACF muestra un **corte brusco** después del rezago
   :math:`p`.

   Es decir: los primeros :math:`p` rezagos aparecen significativos, y
   los demás son aproximadamente cero.

**Ejemplo:**

-  PACF con picos significativos en :math:`lag=1` y :math:`lag=2`, pero
   no después → sugiere un AR(2).

-  ACF que decae lentamente confirma que el modelo es de tipo AR.

**Cómo se comporta la ACF en diferentes casos:**

+-------------------------+---------------------+----------------------+
| Tipo de proceso         | Patrón en ACF       | Patrón en PACF       |
+=========================+=====================+======================+
| **AR(1)**               | Decae               | Corte brusco en lag  |
|                         | exponencialmente u  | 1                    |
|                         | oscilando (según    |                      |
|                         | signo de φ₁)        |                      |
+-------------------------+---------------------+----------------------+
| **AR(2)**               | Decaimiento suave u | Corte en lag 2       |
|                         | oscilante           |                      |
+-------------------------+---------------------+----------------------+
| **MA(q)**               | Corte brusco en lag | Decae lentamente     |
|                         | q                   |                      |
+-------------------------+---------------------+----------------------+
| **ARMA(p,q)**           | ACF y PACF decaen   | Ninguna corta        |
|                         | suavemente          | bruscamente          |
+-------------------------+---------------------+----------------------+
| **Ruido blanco**        | Sin autocorrelación | Sin autocorrelación  |
|                         | (todas ≈ 0)         | (todas ≈ 0)          |
+-------------------------+---------------------+----------------------+

**Casos especiales donde la ACF no “decae lentamente”**

1. **Cuando los coeficientes AR son negativos:**

   -  La ACF **oscila alrededor de cero** (patrón de dientes de sierra)
      en lugar de decaer de manera monótona.

   -  Ejemplo: AR(1) con φ₁ = –0.7 → alterna correlaciones positivas y
      negativas.

2. **Cuando hay raíces complejas en un AR(2):**

   -  La ACF muestra **ondas amortiguadas**: un patrón oscilatorio que
      se atenúa con el tiempo.

   -  No es “lento” en el sentido clásico, pero sigue siendo un
      **decaimiento amortiguado**.

3. **Cuando el proceso no es estacionario:**

   -  Si :math:`|\phi| ≥ 1`, la ACF **no decae** (permanece alta o
      diverge).

   -  Esto indica una **raíz unitaria** (paseo aleatorio), no un proceso
      AR estacionario.

**2. Criterios de información (AIC, BIC)**

Se ajustan modelos con distintos valores de :math:`p` y se comparan
criterios estadísticos:

-  **AIC (Akaike Information Criterion)**

-  **BIC (Bayesian Information Criterion)**

**Regla:** elegir el modelo que minimice estos valores.

-  El AIC suele preferir modelos más grandes (menos penalización).

-  El BIC es más estricto (prefiere modelos más simples).

Esto permite refinar la elección sugerida por ACF/PACF.

**3. Validación de residuales**

Después de elegir :math:`p` con PACF o criterios de información:

1. Revisar los **residuales del modelo**: deben parecer **ruido
   blanco**.

   -  ACF de residuales: no debe mostrar autocorrelación.

   -  Prueba de Ljung–Box: no debe rechazar la hipótesis de
      independencia.

2. Si los residuales muestran autocorrelación → probablemente falten
   rezagos, aumentar :math:`p`.

3. Si el modelo parece sobreajustado (parámetros no significativos o
   :math:`p` demasiado grande) → reducir :math:`p`.

**4. Reglas empíricas adicionales**

-  **Series cortas (n < 50):** conviene mantener :math:`p` pequeño (ej.
   1–3).

-  **Series largas:** se puede probar valores mayores de :math:`p`, pero
   un límite práctico es :math:`\sqrt{n}` rezagos como máximo a evaluar.

+---------------------+--------+-------------------+------------------+
| Método              | Qué    | Patrón esperado   | Cómo usarlo para |
|                     | ob     | en un AR(p)       | elegir p         |
|                     | servar |                   |                  |
+=====================+========+===================+==================+
| **ACF               | Corre  | Decae lentamente  | Confirma que la  |
| (Autocorrelación)** | lación | (exponencial u    | serie es de tipo |
|                     | entre  | oscilante), no    | AR               |
|                     | :math  | corta bruscamente |                  |
|                     | :`y_t` |                   |                  |
|                     | y      |                   |                  |
|                     | r      |                   |                  |
|                     | ezagos |                   |                  |
+---------------------+--------+-------------------+------------------+
| **PACF              | Corre  | **Corte brusco en | El último rezago |
| (Autocorrelación    | lación | el rezago p**     | significativo    |
| parcial)**          | d      | (los primeros p   | indica el valor  |
|                     | irecta | lags son          | de p             |
|                     | entre  | significativos,   |                  |
|                     | :math  | luego ≈ 0)        |                  |
|                     | :`y_t` |                   |                  |
|                     | y      |                   |                  |
|                     | :ma    |                   |                  |
|                     | th:`y_ |                   |                  |
|                     | {t-k}` |                   |                  |
|                     | elim   |                   |                  |
|                     | inando |                   |                  |
|                     | r      |                   |                  |
|                     | ezagos |                   |                  |
|                     | inter  |                   |                  |
|                     | medios |                   |                  |
+---------------------+--------+-------------------+------------------+
| **Criterios de      | C      | Se comparan       | Elegir el modelo |
| información (AIC,   | alidad | distintos modelos | con menor        |
| BIC)**              | del    | AR(p)             | AIC/BIC; BIC     |
|                     | ajuste |                   | suele ser más    |
|                     | pena   |                   | conservador      |
|                     | lizada |                   |                  |
|                     | por    |                   |                  |
|                     | compl  |                   |                  |
|                     | ejidad |                   |                  |
+---------------------+--------+-------------------+------------------+
| **Diagnóstico de    | ACF y  | Residuales deben  | Si hay           |
| residuales**        | p      | parecer **ruido   | autocorrelación  |
|                     | ruebas | blanco**          | → aumentar p; si |
|                     | estadí |                   | hay sobreajuste  |
|                     | sticas |                   | → reducir p      |
|                     | sobre  |                   |                  |
|                     | resi   |                   |                  |
|                     | duales |                   |                  |
+---------------------+--------+-------------------+------------------+
| **Reglas            | Lo     | p pequeño en      | Limita el rango  |
| empíricas**         | ngitud | series cortas;    | de búsqueda para |
|                     | de la  | máximo práctico ≈ | p                |
|                     | serie  | :math:`\sqrt{n}`  |                  |
|                     | :ma    |                   |                  |
|                     | th:`n` |                   |                  |
+---------------------+--------+-------------------+------------------+

.. figure:: Ejemplos_AR.png
   :alt: Ejemplos_AR

   Ejemplos_AR

Pronóstico con modelos AR
~~~~~~~~~~~~~~~~~~~~~~~~~

El objetivo del pronóstico con un modelo autorregresivo AR(p) es estimar
el valor futuro de la serie usando sus propios rezagos recientes.
Partimos del modelo ajustado:

.. math::


   y_t = \alpha + \phi_1 y_{t-1} + \phi_2 y_{t-2} + \cdots + \phi_p y_{t-p} + \varepsilon_t

donde :math:`\varepsilon_t` es ruido blanco.

**1. Pronóstico a 1 paso adelante**

El pronóstico en :math:`t+1` dado lo observado hasta :math:`t` es la
esperanza condicional:

.. math::


   \hat y_{t+1\mid t} = \hat\alpha + \hat\phi_1 y_t + \hat\phi_2 y_{t-1} + \cdots + \hat\phi_p y_{t-p+1}

-  Es **lineal** en los últimos :math:`p` valores observados.

-  Si el modelo incluye media :math:`\mu` en vez de intercepto, puede
   escribirse como:

   .. math::


      \hat y_{t+1\mid t} = \hat\mu + \hat\phi_1 (y_t-\hat\mu) + \cdots + \hat\phi_p (y_{t-p+1}-\hat\mu)

**2. Pronóstico multi-paso (h pasos)**

Para :math:`h \ge 2` el pronóstico es **recursivo**: se sustituyen los
valores futuros desconocidos por sus pronósticos previos.

Ejemplo AR(1):

.. math::


   y_t = \mu + \phi\, y_{t-1} + \varepsilon_t

.. math::


   \hat y_{t+1\mid t} = \mu + \phi (y_t - \mu),\quad
   \hat y_{t+2\mid t} = \mu + \phi (\hat y_{t+1\mid t} - \mu) = \mu + \phi^2 (y_t - \mu)

En general:

.. math::


   \hat y_{t+h\mid t} = \mu + \phi^h (y_t - \mu)

Para AR(p), el mismo principio aplica pero usando la ecuación del
modelo:

-  Para construir :math:`\hat y_{t+h\mid t}` se usan
   :math:`y_{t},\dots,y_{t-p+1}` y, cuando haga falta,
   :math:`\hat y_{t+1\mid t},\dots,\hat y_{t+h-1\mid t}`.

**3. Incertidumbre del pronóstico e intervalos**

La varianza del error de pronóstico **crece con :math:`h`** y se
aproxima a la varianza incondicional del proceso cuando el modelo es
estable.

Representación MA(:math:`\infty`):

.. math::


   y_t - \mu = \sum_{j=0}^{\infty} \psi_j \varepsilon_{t-j},\quad \psi_0=1

Varianza del error a :math:`h` pasos:

.. math::


   \operatorname{Var}\!\left(y_{t+h} - \hat y_{t+h\mid t}\right) = \sigma_\varepsilon^2 \sum_{j=0}^{h-1} \psi_j^2

Caso AR(1):

.. math::


   \operatorname{Var}\!\left(y_{t+h} - \hat y_{t+h\mid t}\right) = \sigma_\varepsilon^2 \frac{1-\phi^{2h}}{1-\phi^2}

Intervalo de pronóstico aproximado al nivel :math:`(1-\alpha)`:

.. math::


   \hat y_{t+h\mid t} \ \pm\ z_{1-\alpha/2}\, \sqrt{ \widehat{\operatorname{Var}}\!\left(y_{t+h} - \hat y_{t+h\mid t}\right) }

**4. Procedimiento práctico paso a paso**

1. **Preparación**

   -  Asegurar estacionariedad en media y varianza.

   -  Remover tendencia y estacionalidad si existen (diferencias,
      desestacionalización, log).

2. **Identificación de** :math:`p`

   -  Leer ACF y PACF.

   -  Comparar AIC y BIC en varios AR(p).

3. **Estimación**

   -  Ajustar el AR(p) por mínimos cuadrados o máxima verosimilitud.

   -  Verificar estabilidad (raíces fuera del círculo unitario).

4. **Diagnóstico**

   -  Residuales ~ ruido blanco (ACF/PACF de residuales, Ljung–Box).

   -  Q–Q plot si se requiere normalidad para inferencia.

5. **Pronóstico**

   -  Generar :math:`\hat y_{t+h\mid t}` de forma recursiva.

   -  Calcular intervalos de pronóstico con la varianza correspondiente.

6. **Evaluación fuera de muestra**

   -  Backtesting con ventana **rodante** o **expansiva**.

   -  Métricas: MAE, RMSE, MAPE, MSE.

   -  Comparar con benchmarks simples: promedio, naïve, random walk,
      SES.

**5. Intuiciones útiles**

-  A medida que :math:`h` aumenta, el pronóstico **converge a la media**
   del proceso estacionario.

-  Un :math:`\phi` cercano a 1 implica **persistencia alta** y, por
   tanto, **intervalos más anchos** para horizontes largos.

-  En AR(2) con raíces complejas, los pronósticos presentan
   **oscilaciones amortiguadas** hacia la media.

-  Si hay autocorrelación remanente en residuales, el modelo tiende a
   **subestimar la incertidumbre** del pronóstico.

Pronóstico in-sample y out-of-sample
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cuando ajustamos un modelo AR(p), podemos evaluar su capacidad de
pronóstico de dos formas distintas:

**in-sample (dentro de la muestra)** y **out-of-sample (fuera de la
muestra)**.

**1. Pronóstico in-sample (dentro de la muestra)**

Corresponde a los valores **ya observados** que el modelo intenta
**reconstruir o explicar** dentro del periodo usado para entrenar el
modelo.

.. math::


   \hat y_t = \hat\alpha + \hat\phi_1 y_{t-1} + \hat\phi_2 y_{t-2} + \cdots + \hat\phi_p y_{t-p}

-  Se calculan los valores ajustados **usando los mismos datos del
   entrenamiento**.

-  Permiten evaluar **qué tan bien el modelo reproduce la dinámica del
   pasado**.

**Propósito:**

Evaluar el **ajuste interno** del modelo (goodness of fit).

**Indicadores comunes:**

-  :math:`R^2` o coeficiente de determinación.

-  Error medio cuadrático (MSE) o raíz del error cuadrático medio
   (RMSE).

-  Análisis visual: comparación entre serie observada y serie ajustada.

**Limitación:**

Un modelo puede tener un ajuste excelente in-sample y, aun así, fallar
al predecir el futuro → riesgo de **sobreajuste (overfitting)**.

**2. Pronóstico out-of-sample (fuera de la muestra)**

Corresponde a **valores futuros no usados en la estimación** del modelo.

Se usa para evaluar la **capacidad predictiva real**.

.. math::


   \hat y_{t+h\mid t} = \hat\alpha + \hat\phi_1 y_{t+h-1} + \hat\phi_2 y_{t+h-2} + \cdots + \hat\phi_p y_{t+h-p}

-  Se realiza sobre un **conjunto de prueba (test)** separado del
   entrenamiento.

-  Los valores pasados de :math:`y_t` pueden provenir de **datos reales
   o de pronósticos previos (pronóstico recursivo).**

-  Mide qué tan bien el modelo generaliza a datos nuevos.

**Propósito:**

Evaluar la **capacidad de pronóstico genuina**, no el ajuste histórico.

**Métricas comunes:**

-  RMSE (Root Mean Squared Error)

-  MSE (Mean Squared Error)

-  MAE (Mean Absolute Error)

-  MAPE (Error porcentual absoluto medio)

**3. Ejemplo conceptual**

Suponemos que tenemos una serie de 120 meses.

+---------------+---------------+------------------------------------+
| Período       | Uso           | Descripción                        |
+===============+===============+====================================+
| Mes 1 – 100   | Entrenamiento | Se usa para estimar el modelo      |
|               |               | (in-sample)                        |
+---------------+---------------+------------------------------------+
| Mes 101 – 120 | Prueba        | Se usa para evaluar pronóstico     |
|               |               | futuro (out-of-sample)             |
+---------------+---------------+------------------------------------+

1. Ajustas el modelo AR(p) con los primeros 100 meses.

2. Calculas los valores ajustados :math:`\hat y_t` → **in-sample**.

3. Realizas pronósticos recursivos para los meses 101 a 120 →
   **out-of-sample**.

4. Comparas con los valores reales :math:`y_{101}, \dots, y_{120}`.

**4. Evaluación conjunta**

+--------------------+--------------+-----------+---------+----------+
| Tipo de pronóstico | Datos usados | Propósito | Riesgos | Métricas |
+====================+==============+===========+=========+==========+
| **In-sample**      | Datos de     | Verificar | Sobr    | R², MSE, |
|                    | e            | ajuste    | eajuste | RMSE,    |
|                    | ntrenamiento | interno   | (modelo | MAE,     |
|                    |              |           | de      | MAPE     |
|                    |              |           | masiado |          |
|                    |              |           | co      |          |
|                    |              |           | mplejo) |          |
+--------------------+--------------+-----------+---------+----------+
| **Out-of-sample**  | Datos de     | Evaluar   | V       | R², MSE, |
|                    | prueba (no   | capacidad | arianza | RMSE,    |
|                    | vistos)      | p         | alta o  | MAE,     |
|                    |              | redictiva | mala    | MAPE     |
|                    |              | real      | general |          |
|                    |              |           | ización |          |
+--------------------+--------------+-----------+---------+----------+

**5. Buenas prácticas**

-  Siempre separar los datos en **entrenamiento y prueba** (por ejemplo,
   80/20).

-  Validar con **pronóstico recursivo**.

-  Un modelo útil no es el que mejor ajusta el pasado, sino el que
   **predice mejor el futuro**.

-  Comparar los errores out-of-sample con un **modelo naïve** (por
   ejemplo, :math:`y_{t+1} = y_t`).

   Si el AR(p) no mejora al modelo naïve → no agrega valor predictivo.

**6. Visualización típica**

-  Gráfico de la serie observada, con:

   -  Datos reales (entrenamiento + prueba).

   -  Pronóstico in-sample (ajuste).

   -  Pronóstico out-of-sample (proyección futura).

   -  Intervalo de confianza.

**7. Conclusión**

-  **In-sample:** mide qué tan bien el modelo explica el pasado.

-  **Out-of-sample:** mide qué tan bien el modelo predice el futuro.

-  Ambos deben analizarse juntos:

   -  Buen ajuste in-sample + mal desempeño out-of-sample →
      **sobreajuste**.

   -  Mal ajuste in-sample + buen desempeño out-of-sample → **modelo más
      robusto**.

..

   En series de tiempo, el verdadero test de un modelo AR no es qué tan
   bien ajusta la historia, sino **qué tan creíblemente anticipa lo que
   aún no ha ocurrido.**

¿Intercepto o media en un modelo AR(p)?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**1. Forma con intercepto** Un modelo AR(p) puede escribirse como:

.. math::


   y_t = \alpha + \phi_1 y_{t-1} + \phi_2 y_{t-2} + \cdots + \phi_p y_{t-p} + \varepsilon_t

Aquí, :math:`\alpha` es el **intercepto**.

Esta forma es útil cuando se está estimando directamente por regresión
(ej. mínimos cuadrados) porque se trata como una constante más.

**2. Forma centrada en la media**

| Bajo estacionariedad, la serie tiene una **media constante**
  :math:`\mu`.
| El mismo modelo puede reescribirse como:

.. math::


   y_t - \mu = \phi_1 (y_{t-1} - \mu) + \phi_2 (y_{t-2} - \mu) + \cdots + \phi_p (y_{t-p} - \mu) + \varepsilon_t

donde :math:`\mu` es la media de la serie.

En este caso **no se incluye** :math:`\alpha` **explícitamente**, porque
ya está absorbida en la media.

**3. Relación entre intercepto y media**

Si trabajas con intercepto:

.. math::


   \mu = \frac{\alpha}{1 - \phi_1 - \phi_2 - \cdots - \phi_p}

Siempre que :math:`1 - \phi_1 - \cdots - \phi_p \neq 0` (condición de
estacionariedad).

**4. ¿Cuándo usar cada forma?**

-  **Intercepto** (:math:`\alpha`):

   -  Cuando el modelo se estima con métodos de regresión lineal
      directamente.

   -  Es la forma más común en la práctica computacional.

   -  Los paquetes de software (``statsmodels``, ``R``, etc.) suelen
      reportar :math:`\alpha`.

-  **Media** (:math:`\mu`):

   -  Cuando quieres interpretar el modelo en términos de la **tendencia
      de largo plazo**.

   -  Útil para entender hacia dónde **converge el pronóstico** cuando
      el horizonte :math:`h \to \infty` (siempre converge a
      :math:`\mu`).

   -  En textos teóricos se usa porque facilita derivar propiedades
      (media, varianza, covarianza).

**5. Intuición**

-  El **intercepto** :math:`\alpha` es una “constante de ajuste” en la
   ecuación de regresión.

-  La **media** :math:`\mu` es el “punto de equilibrio” del proceso: el
   valor al que los pronósticos tienden con el tiempo.

Estimación de parámetros en un modelo AR(p)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Existen tres métodos principales para estimar los parámetros
:math:`\alpha, \phi_1, \dots, \phi_p`.

**1. Estimación por Mínimos Cuadrados (OLS)**

-  Se reescribe el AR(p) como una regresión lineal múltiple:

.. math::


   y_t = \alpha + \phi_1 y_{t-1} + \cdots + \phi_p y_{t-p} + \varepsilon_t

-  Se estima minimizando la suma de cuadrados de los residuos:

.. math::


   \min_{\alpha, \phi_1,\dots,\phi_p} \sum_{t=p+1}^n \hat\varepsilon_t^2

-  Es equivalente a un modelo de regresión estándar con :math:`y_t` como
   variable dependiente y sus rezagos como explicativas.

**Ventajas:**

-  Sencillo y directo.

-  Bien implementado en cualquier software estadístico.

-  Consistente y eficiente si :math:`\varepsilon_t` es ruido blanco
   gaussiano.

**Limitación:**

-  Puede no ser tan eficiente si los residuos no son normales.

**2. Estimación por Máxima Verosimilitud (MLE)**

-  Asume que :math:`\varepsilon_t \sim N(0,\sigma_\varepsilon^2)`.

-  La **función de verosimilitud** es el producto de las densidades
   normales de los residuos.

-  En práctica, se trabaja con la **log-verosimilitud**:

.. math::


   \ell(\theta) = -\frac{n}{2}\log(2\pi\sigma_\varepsilon^2) - \frac{1}{2\sigma_\varepsilon^2}\sum_{t=p+1}^n \hat\varepsilon_t^2

-  Maximizar :math:`\ell(\theta)` es **equivalente a minimizar la suma
   de cuadrados de los residuos** si se asume normalidad.

-  Por eso, en un AR puro, el MLE y OLS producen estimadores muy
   similares.

**Ventajas:**

-  Permite construir intervalos de confianza y pruebas de hipótesis bajo
   supuestos normales.

-  Es la base para comparar modelos usando AIC/BIC.

**Limitación:**

-  Requiere normalidad de los errores para ser eficiente.

**3. Estimación por Yule–Walker**

-  Se basa en las **ecuaciones de autocorrelación** del proceso AR(p):

.. math::


   \rho_k = \phi_1 \rho_{k-1} + \phi_2 \rho_{k-2} + \cdots + \phi_p \rho_{k-p}, \quad k=1,\dots,p

-  Estas forman un sistema lineal que relaciona los coeficientes
   :math:`\phi_i` con las autocorrelaciones muestrales
   :math:`\hat\rho_k`.

-  Resolviendo el sistema se obtienen los estimadores de Yule–Walker.

**Ventajas:**

-  Fácil de calcular.

-  Útil como estimador inicial para otros métodos (ej. en algoritmos
   iterativos).

-  Rápido computacionalmente.

**Limitación:**

-  Puede ser menos eficiente que OLS/MLE en muestras pequeñas.

-  Depende fuertemente de la calidad de las estimaciones de
   autocorrelación.

**Comparación de los métodos**

+---------------+----------------------+------------------+-----------+
| Método        | Supuestos clave      | Ventajas         | Lim       |
|               |                      | principales      | itaciones |
+===============+======================+==================+===========+
| **OLS**       | Errores no           | Sencillo,        | Menos     |
|               | correlacionados      | intuitivo        | eficiente |
|               |                      |                  | si no hay |
|               |                      |                  | n         |
|               |                      |                  | ormalidad |
+---------------+----------------------+------------------+-----------+
| **MLE**       | Errores normales iid | Permite          | Computaci |
|               |                      | inferencia       | onalmente |
|               |                      | estadística      | más       |
|               |                      | (intervalos,     | exigente  |
|               |                      | tests) y         |           |
|               |                      | selección por    |           |
|               |                      | AIC/BIC          |           |
+---------------+----------------------+------------------+-----------+
| **            | Estacionariedad      | Rápido, útil     | Menos     |
| Yule–Walker** |                      | para             | eficiente |
|               |                      | inicialización   | en        |
|               |                      |                  | muestras  |
|               |                      |                  | pequeñas  |
+---------------+----------------------+------------------+-----------+

Evaluación de la significancia de los parámetros en un modelo AR(p)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Una vez estimado el modelo:

.. math::


   y_t = \alpha + \phi_1 y_{t-1} + \phi_2 y_{t-2} + \cdots + \phi_p y_{t-p} + \varepsilon_t

cada parámetro :math:`\phi_i` y el intercepto :math:`\alpha` tienen un
**estimador** :math:`\hat\phi_i` y un **error estándar**
:math:`SE(\hat\phi_i)`.

**1. Prueba t individual**

La forma más común de evaluar la significancia de cada parámetro es
mediante la **prueba z**:

.. math::


   z_i = \frac{\hat\phi_i}{SE(\hat\phi_i)}

**Hipótesis:**

-  :math:`H_0`: :math:`\phi_i = 0` (el rezago :math:`i` no tiene efecto
   significativo)

-  :math:`H_1`: :math:`\phi_i \neq 0` (el rezago sí tiene efecto)

**Criterio de decisión:**

-  Si :math:`|z_i| > z_{\text{crítico}}` o el valor p < 0,05 → se
   rechaza :math:`H_0`.

-  Es decir, el coeficiente :math:`\phi_i` es **significativo**.

-  Como referencia:

   -  Si :math:`|z| > 1.96` → significativo al 5%

   -  Si :math:`|z| > 2.58` → significativo al 1%

**Interpretación:**

-  Un parámetro significativo indica que ese rezago **aporta información
   predictiva** sobre :math:`y_t`.

-  Un parámetro no significativo puede eliminarse para simplificar el
   modelo.

**2. Error estándar y significancia práctica**

Aunque un coeficiente sea estadísticamente significativo (valor p <
0.05), también se evalúa su **magnitud**:

-  Si :math:`\phi_i` es muy pequeño, su influencia práctica puede ser
   mínima.

-  En modelos con muchos rezagos, eliminar coeficientes pequeños y no
   significativos mejora la parsimonia.

**3. Prueba conjunta (Wald o F)**

También se puede evaluar si **varios parámetros a la vez** son iguales a
cero:

.. math::


   H_0: \phi_1 = \phi_2 = \cdots = \phi_p = 0

Esto se puede hacer con una **prueba F (en OLS)** o **Wald test (en
MLE)**.

Si se rechaza :math:`H_0`, el conjunto de rezagos aporta información
significativa al modelo.

**4. Valores p y tabla resumen**

Los paquetes estadísticos (por ejemplo, ``statsmodels`` en Python)
entregan una tabla con:

============== =========== ============== ======= ======= =============
Parámetro      Coeficiente Error estándar Valor t Valor p Significancia
============== =========== ============== ======= ======= =============
:math:`\alpha` 0.502       0.091          5.49    0.000   \**\*
:math:`\phi_1` 0.634       0.084          7.56    0.000   \**\*
:math:`\phi_2` -0.213      0.092          -2.31   0.022   \*\*
…              …           …              …       …       …
============== =========== ============== ======= ======= =============

Los asteriscos indican niveles de significancia:

-  ``***`` p < 0.01 (muy significativo)

-  ``**`` p < 0.05 (significativo)

-  ``*`` p < 0.10 (marginal)

-  ``ns`` no significativo

**5. Cuándo preocuparse por la significancia**

-  Si muchos coeficientes no son significativos → probablemente
   :math:`p` es demasiado grande (sobreajuste).

-  Si todos son significativos → el modelo capta bien la dinámica.

-  Si solo los primeros rezagos son significativos → se puede reducir el
   orden a ese nivel.

**6. Precaución: correlación entre rezagos**

En modelos con rezagos cercanos (por ejemplo, AR(6)), puede existir
**colinealidad** entre los valores pasados.

Esto aumenta los errores estándar y puede hacer que algunos coeficientes
**no parezcan significativos**, aunque el modelo global sí lo sea.

Por eso también se usa el **AIC/BIC** y el diagnóstico de **residuales**
para validar el modelo completo, no solo los valores p individuales.

**7. Resumen práctico**

+-------+---------------------+------------------+---------------------+
| Paso  | Qué se evalúa       | Herramienta      | Interpretación      |
+=======+=====================+==================+=====================+
| 1     | Significancia       | Prueba t, valor  | Si p < 0.05, el     |
|       | individual de       | p                | rezago es relevante |
|       | :math:`\phi_i`      |                  |                     |
+-------+---------------------+------------------+---------------------+
| 2     | Significancia       | Prueba F o Wald  | Evalúa si los       |
|       | conjunta de varios  |                  | rezagos en conjunto |
|       | :math:`\phi_i`      |                  | explican la serie   |
+-------+---------------------+------------------+---------------------+
| 3     | Parsimonia del      | AIC/BIC y        | Confirmar que no    |
|       | modelo              | residuos         | hay sobreajuste     |
+-------+---------------------+------------------+---------------------+
| 4     | Multicolinealidad   | Revisar          | Si alta, puede      |
|       |                     | correlaciones    | afectar las t       |
|       |                     | entre rezagos    |                     |
+-------+---------------------+------------------+---------------------+

Intervalos de confianza en los modelos AR
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cuando ajustamos un modelo autorregresivo con ``statsmodels``, en la
tabla de resultados aparecen dos columnas adicionales Las columnas
**[0.025, 0.975]** representan los **límites inferior y superior** del
**intervalo de confianza al 95%** para cada parámetro estimado.

**1. ¿Qué es un intervalo de confianza?**

Un **intervalo de confianza (IC)** indica el rango de valores dentro del
cual se espera que se encuentre el **valor real del parámetro
poblacional**, con una probabilidad determinada (habitualmente 95%).

Formalmente, para cada parámetro :math:`\hat{\phi_i}`:

.. math::


   IC_{95\%} = \hat{\phi_i} \pm 1.96 \times SE(\hat{\phi_i})

donde:

-  :math:`\hat{\phi_i}` → coeficiente estimado,

-  :math:`SE(\hat{\phi_i})` → error estándar del coeficiente,

-  :math:`1.96` → valor crítico de la distribución normal estándar para
   un 95% de confianza.

**2. Interpretación práctica**

-  El **intervalo [0.025, 0.975]** muestra el rango en el que se
   encuentra el valor verdadero del parámetro con **95% de confianza**.

-  Si el intervalo **no contiene el valor 0**, se concluye que el
   parámetro es **estadísticamente significativo**.

-  Si el intervalo **incluye 0**, no se puede afirmar que el efecto sea
   distinto de cero.

**3. Interpretación geométrica**

-  El punto central del intervalo es el **coeficiente estimado**.

-  El ancho del intervalo depende del **error estándar**:

   -  Intervalo estrecho → estimación precisa.

   -  Intervalo ancho → estimación incierta (poca información en los
      datos).
