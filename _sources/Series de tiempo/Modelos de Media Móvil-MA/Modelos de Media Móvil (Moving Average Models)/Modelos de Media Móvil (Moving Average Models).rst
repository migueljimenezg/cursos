Modelos de Media Móvil (Moving Average Models)
----------------------------------------------

Los modelos de **media móvil (MA)** constituyen una de las clases
fundamentales de modelos para series de tiempo estacionarias.

A diferencia de los modelos autorregresivos, en los cuales se usan
**valores pasados de la serie**, en los modelos MA se utilizan **errores
pasados de pronóstico** en una ecuación de tipo regresión.

En su forma general, un modelo MA de orden :math:`q`, denotado como
MA(:math:`q`), se expresa como:

.. math::


   y_t = \mu  + \theta_1 \varepsilon_{t-1} + \theta_2 \varepsilon_{t-2} + \cdots + \theta_q \varepsilon_{t-q} + \varepsilon_t

donde:

-  :math:`y_t` es el valor observado de la serie en el tiempo :math:`t`.

-  :math:`\mu` es la media del proceso.

-  :math:`\theta_1, \theta_2, \ldots, \theta_q` son los parámetros del
   modelo que indican la influencia de los errores pasados.

-  :math:`\varepsilon_t` es un término de error aleatorio o **ruido
   blanco**, con media cero y varianza constante.

Cada valor de la serie puede verse como un **promedio ponderado de los
errores pasados**.

   **Importante:** No debe confundirse este modelo con el *suavizamiento
   por media móvil* visto en capítulos anteriores.

..

   El suavizamiento se usa para estimar la tendencia pasada, mientras
   que el modelo MA se utiliza para **pronosticar valores futuros**.

**Ejemplos básicos**

-  | Modelo MA(1):
   | 

     .. math::


        y_t = \mu  + \theta_1 \varepsilon_{t-1} + \varepsilon_t

-  | Modelo MA(2):
   | 

     .. math::


        y_t = \mu  + \theta_1 \varepsilon_{t-1} + \theta_2 \varepsilon_{t-2} + \varepsilon_t

En estos ejemplos, los valores presentes dependen de la media, del error
actual y de los errores de los pasos previos.

| Cuando una serie de tiempo no es estacionaria en nivel, se aplica la
  **diferenciación** para eliminar tendencias o raíces unitarias.
| La primera diferencia se define como:

.. math::


   \nabla y_t = y_t - y_{t-1}

Al ajustar un modelo de media móvil a la serie diferenciada, la ecuación
general se expresa como:

.. math::


   \nabla y_t = \mu + \varepsilon_t + \theta_1 \varepsilon_{t-1} + \theta_2 \varepsilon_{t-2} + \cdots + \theta_q \varepsilon_{t-q}

En este contexto, la constante :math:`\mu` **ya no representa la media
del nivel original de la serie**, sino el **promedio del cambio** entre
periodos consecutivos.

| La serie diferenciada, por construcción, tiende a oscilar alrededor de
  cero.
| Por tanto, si la tendencia fue completamente eliminada mediante la
  diferenciación, el valor esperado de las diferencias es
  aproximadamente cero:

.. math::


   E(\nabla y_t) \approx 0

| En este caso, la constante :math:`\mu` suele omitirse o fijarse en
  cero, ya que no aporta información adicional.
| En los modelos estimados con librerías como *statsmodels*, esto
  equivale a ajustar el modelo con la opción ``trend='n'`` (sin
  constante).

Identificación del orden q
~~~~~~~~~~~~~~~~~~~~~~~~~~

| El orden :math:`q` del modelo MA indica cuántos errores pasados
  afectan al valor actual.
| Para identificarlo, se utilizan los siguientes pasos:

1. **Comprobar estacionariedad** de la serie (por ejemplo, usando la
   prueba ADF).

2. Si no es estacionaria, **aplicar transformaciones** (como
   diferenciación o logaritmo) hasta que lo sea.

3. **Graficar la Función de Autocorrelación (ACF)**.

Un modelo MA(:math:`q`) se caracteriza porque:

-  Los coeficientes de la ACF son **significativos hasta el rezago
   :math:`q`**,

-  y luego **se vuelven insignificantes bruscamente** (no con
   decaimiento lento).

Por tanto:

-  Si solo el primer rezago de la ACF es significativo, se trata de un
   MA(1).

-  Si los dos primeros lo son, un MA(2), y así sucesivamente.

Invertibilidad
~~~~~~~~~~~~~~

Así como los modelos AR requieren condiciones de **estacionariedad**,
los modelos MA requieren condiciones de **invertibilidad**.

Un modelo MA es invertible si puede expresarse como un modelo AR con
infinitos rezagos decrecientes.

Por ejemplo, para un modelo AR(1):

.. math::


   y_t = \phi_1 y_{t-1} + \varepsilon_t

puede reescribirse (por sustitución repetida) como un
MA(:math:`\infty`):

.. math::


   y_t = \varepsilon_t + \phi_1 \varepsilon_{t-1} + \phi_1^2 \varepsilon_{t-2} + \phi_1^3 \varepsilon_{t-3} + \cdots

De forma análoga, un modelo MA invertible puede escribirse como un
AR(:math:`\infty`) bajo ciertas condiciones en los parámetros
:math:`\theta`.

**Condiciones de invertibilidad**

-  Para un modelo MA(1): :math:`|\theta_1| < 1`

-  Para un modelo MA(2): :math:`\theta_2 + \theta_1 < 1`,
   :math:`\theta_2 - \theta_1 < 1`, y :math:`|\theta_2| < 1`

Estas condiciones garantizan que los pesos de los errores pasados
disminuyan progresivamente y que las observaciones más recientes tengan
mayor influencia.

Pronóstico con modelos MA
~~~~~~~~~~~~~~~~~~~~~~~~~

Una particularidad de los modelos MA(:math:`q`) es que **solo permiten
pronosticar hasta :math:`q` pasos adelante** de forma informativa.

Esto se debe a que el modelo depende de los **errores pasados**, y estos
**no se observan directamente** más allá de :math:`q` periodos.

Más allá de ese horizonte, el modelo simplemente pronostica la **media**
:math:`\mu`.

Por ello, los pronósticos con MA se realizan de manera **recursiva o
rolling**:

-  Se entrena el modelo,

-  Se pronostican :math:`q` pasos,

-  Se actualizan los datos con los valores observados o predichos,

-  Y se repite el proceso.

**Ejemplo conceptual**

Suponga que la serie de ventas diarias de una empresa sigue un proceso
MA(2).

Esto significa que las ventas de hoy dependen de los errores de
pronóstico de los últimos dos días.

El modelo sería:

.. math::


   y_t = \mu  + \theta_1 \varepsilon_{t-1} + \theta_2 \varepsilon_{t-2} + \varepsilon_t

El orden :math:`q=2` indica que el pronóstico útil máximo es de dos
días.

Más allá de eso, el modelo pierde capacidad predictiva y converge al
promedio histórico.

**Resumen**

-  Un modelo **MA(:math:`q`)** expresa la dependencia de una serie
   respecto a los errores pasados.

-  Se usa para **series estacionarias**.

-  La **ACF** muestra un corte brusco en el rezago :math:`q`.

-  Los modelos deben cumplir **condiciones de invertibilidad** para ser
   válidos.

-  Los pronósticos se realizan hasta :math:`q` pasos adelante; después,
   el valor converge a la media.
