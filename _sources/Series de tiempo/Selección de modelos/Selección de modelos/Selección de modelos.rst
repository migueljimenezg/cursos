Selección de modelos
--------------------

La **selección de modelos** es una etapa esencial en el proceso de
modelado estadístico y de series de tiempo.

Su objetivo es encontrar el modelo que **mejor equilibra el ajuste a los
datos y la complejidad del modelo**, evitando tanto el **subajuste
(underfitting)** como el **sobreajuste (overfitting)**.

| Un modelo con pocos parámetros puede no capturar los patrones reales
  de la serie (subajuste),
| mientras que uno con demasiados parámetros puede ajustarse al ruido de
  los datos (sobreajuste), perdiendo capacidad de generalización.

1. Criterios comunes para comparar modelos
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

| Existen diversas medidas que ayudan a evaluar la calidad relativa de
  distintos modelos.
| Entre las más utilizadas se encuentran:

-  :math:`R^2_{ajustado}` **(Adjusted R-squared)**

-  **AIC (Akaike Information Criterion)**

-  **BIC (Bayesian Information Criterion)**

-  **HQIC (Hannan–Quinn Information Criterion)**

**Reglas generales:**

-  Para **AIC**, **BIC** y **HQIC**, el mejor modelo es aquel con el
   **valor más bajo**.

-  Para :math:`R^2_{ajustado}`, el mejor modelo es el que tiene el
   **valor más alto**.

2. Coeficiente de determinación ajustado
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El coeficiente de determinación clásico, :math:`R^2`, mide la proporción
de la variabilidad de la variable dependiente que es explicada por el
modelo.

Sin embargo, :math:`R^2` siempre aumenta (o se mantiene igual) al
agregar más variables, aunque estas no aporten información útil.

Para corregir este problema, se utiliza el :math:`R^2_{ajustado}`, que
penaliza la inclusión de predictores innecesarios.

Su fórmula es:

.. math::


   R^2_{ajustado} = 1 - (1 - R^2) \cdot \frac{n - 1}{n - k - 1}

donde:

-  :math:`n` = número de observaciones,

-  :math:`k` = número de predictores incluidos en el modelo.

**Interpretación:**

-  Si una variable adicional **mejora realmente** el modelo, el
   :math:`R^2_{ajustado}` **aumentará**.

-  Si la nueva variable **no aporta valor explicativo**, el
   :math:`R^2_{ajustado}` **disminuirá**.

Por ello, el :math:`R^2_{ajustado}` es una medida más **fiable** para
comparar modelos con distinto número de variables.

El modelo con el **mayor** :math:`R^2_{ajustado}` suele considerarse el
mejor entre los candidatos.

En cualquier modelo estadístico, el número total de parámetros estimados
se denota por:

.. math::


   k = \text{número total de parámetros estimados}

El valor de :math:`k` incluye **todos los parámetros que el modelo
ajusta** a partir de los datos, tales como:

-  Los **coeficientes de las variables explicativas** (por ejemplo,
   :math:`\beta_1, \beta_2, \dots, \beta_k`),

-  El **intercepto o constante** (:math:`\beta_0`),

-  Y los **parámetros de varianza o ruido**, representados comúnmente
   como :math:`\sigma^2` en regresión o en modelos ARIMA.

Por tanto, :math:`k` refleja la **complejidad o tamaño del modelo**:

a medida que se estiman más parámetros, el modelo se vuelve más
flexible, pero también se **incrementa la penalización** en criterios
como el AIC o el BIC.

Este equilibrio entre ajuste y complejidad es lo que estos criterios
buscan optimizar.

3. Criterio de información de Akaike (AIC)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

| El **AIC (Akaike Information Criterion)** estima la **calidad
  relativa** de un modelo respecto a otros.
| Cuando se ajusta un modelo a los datos, inevitablemente se pierde algo
  de información; el AIC cuantifica **cuánta información se pierde**.

La fórmula general es:

.. math::


   AIC = 2k - 2\ln(\hat{L})

donde:

-  :math:`k` = número de parámetros estimados del modelo,

-  :math:`\hat{L}` = valor máximo de la **función de verosimilitud
   (likelihood)** del modelo.

**Interpretación:**

-  Un modelo con un valor alto de :math:`\hat{L}` (es decir, que se
   ajusta bien) tendrá un AIC menor.

-  Un modelo con muchos parámetros tendrá un término :math:`2k` mayor,
   lo que **aumenta el AIC**.

| De esta forma, el AIC **penaliza la complejidad excesiva** y **premia
  el buen ajuste**,
| logrando un balance entre ambas dimensiones.

**Conclusión práctica:**

El **modelo con el AIC más bajo** se considera el mejor entre los
modelos comparados.

4. Función de verosimilitud
~~~~~~~~~~~~~~~~~~~~~~~~~~~

La **función de verosimilitud** evalúa qué tan probable es que los datos
observados provengan de un modelo dado.

Formalmente, mide la probabilidad de observar los datos bajo diferentes
valores de los parámetros.

En práctica, se trabaja con la **log-verosimilitud**:

.. math::


   \ln L(\theta) = -\frac{n}{2}\log(2\pi\sigma_\varepsilon^2) - \frac{1}{2\sigma_\varepsilon^2}\sum_{t=p+1}^n \hat\varepsilon_t^2

**Ejemplo intuitivo:**

En un modelo ARMA o ARIMA la verosimilitud mide qué tan probable es que
la serie observada provenga de un modelo con ciertos parámetros
:math:`(p, q)`.

Cuanto **mayor sea el valor de** :math:`\hat{L}`, **mejor se ajusta el
modelo a los datos**.

| Sin embargo, al aumentar el número de parámetros, también aumenta el
  riesgo de sobreajuste.
| Por eso el AIC combina ambos aspectos en una sola métrica.

5. Criterio de información bayesiano (BIC)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El **BIC (Bayesian Information Criterion)**, también llamado **criterio
de Schwarz**, es similar al AIC pero penaliza más fuertemente la
complejidad del modelo.

Su fórmula general es:

.. math::


   BIC = k \ln(n) - 2\ln(\hat{L})

donde:

-  :math:`n` = número de observaciones,

-  :math:`k` = número de parámetros del modelo,

-  :math:`\hat{L}` = valor máximo de la función de verosimilitud.

**Diferencias clave respecto al AIC:**

-  Ambos buscan **minimizarse**.

-  El BIC **penaliza más** el número de parámetros porque incluye el
   término :math:`\ln(n)` en lugar de un valor constante (2 en el AIC).

-  En consecuencia, el BIC tiende a seleccionar **modelos más simples**
   (con menos variables).

**Interpretación práctica:**

-  Si el objetivo es **pronosticar**, el AIC suele ser preferido porque
   favorece modelos con mejor ajuste.

-  Si el objetivo es **interpretar** o **identificar el modelo más
   parsimonioso**, el BIC suele ser más apropiado.

Ambos criterios son complementarios y suelen coincidir cuando el número
de observaciones es grande.

6. Criterio de información de Hannan–Quinn (HQIC)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

| El **HQIC (Hannan–Quinn Information Criterion)** es otro criterio
  basado en la verosimilitud, que ofrece un **equilibrio intermedio**
  entre el AIC y el BIC.
| Su expresión es:

.. math::


   HQIC = k \ln(\ln(n)) - 2 \ln(\hat{L})

donde:

-  :math:`n` = número de observaciones,

-  :math:`k` = número de parámetros estimados,

-  :math:`\hat{L}` = máximo de la función de verosimilitud.

Comparación general
~~~~~~~~~~~~~~~~~~~

+----------+---------------+------------+------------+---------------+
| **Cr     | **Fórmula     | **Qué      | **Qué se   | **Tipo de     |
| iterio** | general**     | penaliza** | busca**    | decisión**    |
+==========+===============+============+============+===============+
| :math:   | :math:        | Variables  | Maximizar  | Evalúa el     |
| `R^2_{aj | `1 - (1 - R^2 | in         |            | poder         |
| ustado}` | )\dfrac{n - 1 | necesarias |            | explicativo   |
|          | }{n - k - 1}` |            |            |               |
+----------+---------------+------------+------------+---------------+
| **AIC**  | :math:`2k - 2 | C          | Minimizar  | Evalúa        |
|          | \ln(\hat{L})` | omplejidad |            | pérdida de    |
|          |               | (número de |            | información   |
|          |               | p          |            |               |
|          |               | arámetros) |            |               |
+----------+---------------+------------+------------+---------------+
| **BIC**  | :math         | C          | Minimizar  | Favorece      |
|          | :`k\ln(n) - 2 | omplejidad |            | modelos más   |
|          | \ln(\hat{L})` | con        |            | simples       |
|          |               | pe         |            |               |
|          |               | nalización |            |               |
|          |               | más fuerte |            |               |
+----------+---------------+------------+------------+---------------+
| **HQIC** | :math:`k\l    | C          | Minimizar  | Equilibrio    |
|          | n(\ln(n)) - 2 | omplejidad |            | entre AIC y   |
|          | \ln(\hat{L})` | (i         |            | BIC           |
|          |               | ntermedia) |            |               |
+----------+---------------+------------+------------+---------------+

**Conclusión**

| Los criterios de información permiten comparar modelos de forma
  **objetiva y cuantitativa**,
| buscando un equilibrio entre **ajuste y simplicidad**.

-  El :math:`R^2_{ajustado}` evalúa el poder explicativo penalizando
   variables irrelevantes.

-  El **AIC** mide la pérdida relativa de información y busca
   minimizarla. Impone una penalización **ligera**.

-  El **BIC** penaliza con más fuerza la complejidad, privilegiando
   modelos más parsimoniosos. Impone una penalización **fuerte**
   (dependiente de :math:`\ln(n)`).

-  El **HQIC** aplica una penalización **moderada**, basada en
   :math:`\ln(\ln(n))`, lo que lo convierte en una alternativa
   equilibrada entre ambos extremos.

En conjunto, estos criterios permiten seleccionar el modelo que mejor
representa los datos **sin sobreajustar** y con una **capacidad
predictiva robusta**.

En la práctica, los tres criterios de información (AIC, BIC, HQIC)
suelen coincidir cuando el tamaño de muestra es grande. El modelo
seleccionado debe ser aquel que **minimice estos valores** y que, al
mismo tiempo, **muestre residuales bien comportados** (análisis
posterior).
