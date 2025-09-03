Métodos de suavizado
--------------------

En numerosos contextos de análisis y pronóstico, resulta esencial
estimar la tendencia de una serie de tiempo. Este componente puede ser
relevante en sí mismo —al reflejar la evolución de largo plazo de la
variable— o bien constituir un paso previo para lograr la
estacionariedad de la serie mediante la eliminación de dicha tendencia.

Los métodos de suavizamiento se utilizan para reducir el ruido y las
fluctuaciones de corto plazo, permitiendo así revelar el comportamiento
subyacente y persistente de la serie. De esta manera, facilitan la
identificación y el modelado de la tendencia.

Suavizado Exponencial Simple (SES):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El **suavizado exponencial simple (SES)** fue propuesto a finales de los
años 50 (Brown, 1959; Holt, 1957; Winters, 1960) y constituye la base de
algunos de los métodos de pronóstico más utilizados en la práctica.

La idea central es generar **pronósticos como promedios ponderados de
las observaciones pasadas**, donde los pesos decrecen exponencialmente
con el tiempo. Esto implica que:

-  Las observaciones recientes tienen mayor influencia en el pronóstico.

-  Las observaciones más lejanas tienen menor peso, aunque nunca
   desaparecen completamente.

Este enfoque ofrece un procedimiento rápido, confiable y flexible para
una amplia gama de series de tiempo, lo que explica su éxito en
aplicaciones industriales y académicas.

**Comparación con métodos básicos:**

Antes de introducir SES, recordemos dos métodos simples:

-  **Método naïve**:

| 

  .. math::


     \hat{y}_{T+h|T} = y_T, \quad h \geq 1
| El último valor observado se usa como pronóstico futuro. Todo el peso
  recae únicamente en la observación más reciente.

-  **Método del promedio**:

| 

  .. math::


     \hat{y}_{T+h|T} = \frac{1}{T} \sum_{t=1}^T y_t, \quad h \geq 1
| Todos los datos pasados tienen el mismo peso.

El SES se ubica entre estos dos extremos: da más importancia a los datos
recientes, pero no ignora por completo el pasado.

**Forma de promedio ponderado:**

El SES calcula un promedio ponderado donde los pesos decrecen
geométricamente:

| 

  .. math::


     S_t = \alpha y_t + (1-\alpha)y_{t-1} + (1-\alpha)^2 y_{t-2} + \cdots
| con :math:`0 < \alpha < 1`.

De aquí se deriva la **forma recursiva**:

| 

  .. math::


     S_t = \alpha y_t + (1-\alpha)S_{t-1}
| donde:

-  :math:`y_t`: valor observado en el período :math:`t`.

-  :math:`S_t`: nivel suavizado en el período :math:`t`.

-  :math:`\alpha`: parámetro de suavizado.

Los **ajustes o valores suavizados** (fitted values) se obtienen como:

.. math::


   \hat{y}_{t|t-1} = S_{t-1}

**Interpretación de** :math:`\alpha`:

El parámetro :math:`\alpha` controla la rapidez con la que los pesos
asignados a las observaciones pasadas decrecen:

-  :math:`\alpha \approx 1`:

   -  El modelo se parece al método naïve.

   -  El pronóstico reacciona rápido a cambios recientes.

   -  Mayor varianza en los valores suavizados.

-  :math:`\alpha \approx 0`:

   -  El modelo se acerca al método del promedio.

   -  La serie suavizada es estable pero lenta para reflejar cambios.

   -  Menor varianza, pero más rezago en la reacción.

Ejemplo de pesos decrecientes según :math:`\alpha`:

+-------------+-------------+-------------+-------------+-------------+
| Rezago      | :math:`\a   | :math:`\a   | :math:`\a   | :math:`\a   |
|             | lpha = 0.2` | lpha = 0.4` | lpha = 0.6` | lpha = 0.8` |
+=============+=============+=============+=============+=============+
| :math:`y_t` | 0.2000      | 0.4000      | 0.6000      | 0.8000      |
+-------------+-------------+-------------+-------------+-------------+
| :mat        | 0.1600      | 0.2400      | 0.2400      | 0.1600      |
| h:`y_{t-1}` |             |             |             |             |
+-------------+-------------+-------------+-------------+-------------+
| :mat        | 0.1280      | 0.1440      | 0.0960      | 0.0320      |
| h:`y_{t-2}` |             |             |             |             |
+-------------+-------------+-------------+-------------+-------------+
| :mat        | 0.1024      | 0.0864      | 0.0384      | 0.0064      |
| h:`y_{t-3}` |             |             |             |             |
+-------------+-------------+-------------+-------------+-------------+

Los **pesos del suavizado exponencial simple (SES)** en la forma de
promedio ponderado se calculan con la fórmula:

.. math::


   \text{Peso en } y_{t-j} = \alpha (1-\alpha)^j, \quad j = 0,1,2,\dots

donde:

-  :math:`j` es el **rezago** (0 corresponde a :math:`y_t`, 1 a
   :math:`y_{t-1}`, etc.).

-  :math:`\alpha` es el parámetro de suavizamiento.

**Ejemplo de cálculo para** :math:`\alpha = 0.2`:

-  Rezago :math:`0`: :math:`0.2 \cdot (1-0.2)^0 = 0.2000`

-  Rezago :math:`1`: :math:`0.2 \cdot (1-0.2)^1 = 0.1600`

-  Rezago :math:`2`: :math:`0.2 \cdot (1-0.2)^2 = 0.1280`

-  Rezago :math:`3`: :math:`0.2 \cdot (1-0.2)^3 = 0.1024`

.. figure:: Decaimiento.png
   :alt: Decaimiento

   Decaimiento

.. figure:: decaimiento_exponencial.gif
   :alt: decaimiento_exponencial.gif

   decaimiento_exponencial.gif

.. figure:: suavizamiento_exponencial.gif
   :alt: suavizamiento_exponencial

   suavizamiento_exponencial

**Pronóstico con SES:**

Una característica clave es que los pronósticos son **planos (flat
forecasts)**:

| 

  .. math::


     \hat{y}_{T+h|T} = S_T, \quad h \geq 1
| Es decir, todos los valores futuros se predicen como el último nivel
  suavizado. Esto es apropiado únicamente si la serie no tiene tendencia
  ni estacionalidad.

**Pasos prácticos de implementación:**

1. **Inicialización**: elegir :math:`S_1 = y_1` o bien la media de los
   primeros :math:`k` valores.

2. **Recursión**: calcular :math:`S_t = \alpha y_t + (1-\alpha)S_{t-1}`
   para :math:`t=2,\dots,T`.

3. **Pronóstico**: fijar :math:`\hat{y}_{T+h|T} = S_T` para
   :math:`h \geq 1`.

**Ejemplo:**

Supongamos la serie :math:`\{y_t\} = [10, 12, 11, 13, 12]` y
:math:`\alpha = 0.3`:

1. :math:`S_1 = 10`

2. :math:`S_2 = 0.3 \cdot 12 + 0.7 \cdot 10 = 10.6`

3. :math:`S_3 = 0.3 \cdot 11 + 0.7 \cdot 10.6 = 10.72`

4. :math:`S_4 = 0.3 \cdot 13 + 0.7 \cdot 10.72 = 11.40`

5. :math:`S_5 = 0.3 \cdot 12 + 0.7 \cdot 11.40 = 11.58`

| El pronóstico será:
| 

  .. math::


     \hat{y}_{6} = 11.58, \quad \hat{y}_{7} = 11.58, \quad \hat{y}_{8} = 11.58, \dots

**Ventajas y limitaciones:**

-  **Ventajas:**

-  Fácil de implementar y comprender.

-  Pocos parámetros a estimar.

-  Requiere escaso almacenamiento.

-  Útil para series sin tendencia ni estacionalidad.

-  **Limitaciones:**

-  No modela tendencias ni estacionalidad.

-  Todos los pronósticos convergen a un nivel constante.

-  Sensible a la elección de :math:`\alpha`.

**Conexión con otros métodos:**

-  **Holt (doble suavizado):** incorpora un componente de tendencia.

-  **Holt–Winters:** extiende SES para incluir estacionalidad (aditiva o
   multiplicativa).

.. code:: ipython3

    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    
    # Generar serie de tiempo sin tendencia ni estacionalidad (solo ruido alrededor de un nivel)
    np.random.seed(123)
    periods = 100
    dates = pd.date_range(start='2021-01-01', periods=periods, freq='D')
    level = 10
    noise = np.random.normal(loc=0, scale=1.0, size=periods)
    series = pd.Series(level + noise, index=dates)
    
    # Graficar serie de tiempo
    plt.figure(figsize=(15, 5))
    plt.plot(series, label='Serie original', color='black', linewidth=1.5)
    plt.title('Serie sin tendencia ni estacionalidad')
    plt.xlabel('Fecha')
    plt.ylabel('Valor')
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.show()
    



.. image:: output_12_0.png


SimpleExpSmoothing (SES) — ``statsmodels``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La clase ``SimpleExpSmoothing`` del módulo
``statsmodels.tsa.holtwinters`` implementa el método de **Suavizado
Exponencial Simple (SES)**, una técnica de pronóstico para series de
tiempo que no presentan tendencia ni estacionalidad.

Este método suaviza la serie otorgando mayor peso a los valores más
recientes, mediante un parámetro de suavizado :math:`\alpha \in (0, 1)`.
A diferencia de otros modelos, SES produce pronósticos constantes
iguales al último valor suavizado.

``SimpleExpSmoothing(endog, initialization_method=None, initial_level=None)``

``endog``: debe ser un objeto pd.Series con índice temporal.

``optimized=True``: permite que el modelo escoja el mejor valor de
:math:`\alpha` minimizando el error cuadrático medio (MSE) en los datos.

.. code:: ipython3

    from statsmodels.tsa.holtwinters import SimpleExpSmoothing

.. code:: ipython3

    # Ajustar SES con alpha optimizado automáticamente
    model = SimpleExpSmoothing(series).fit(optimized=True)
    fitted_values = model.fittedvalues
    alpha_opt = model.model.params['smoothing_level']
    
    # Graficar resultados
    plt.figure(figsize=(15, 5))
    plt.plot(series, label='Serie original', color='black')
    plt.plot(fitted_values, label=f'Suavizado SES (α optimizado = {alpha_opt:.4f})', color='blue')
    plt.title('Ajuste con Suavizado Exponencial Simple (SES)')
    plt.xlabel('Fecha')
    plt.ylabel('Valor')
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.show()



.. image:: output_15_0.png


``optimized=True``: permite que el modelo escoja el mejor valor de
:math:`\alpha` minimizando el error cuadrático medio (MSE) en los datos.

**Ajustar el modelo con un valor específico de alpha (por ejemplo,
0.3):**

``alpha = 0.3``

``model = SimpleExpSmoothing(series).fit(smoothing_level=alpha, optimized=False)``

.. code:: ipython3

    # Hacer pronóstico fuera de la muestra
    horizon = 10  # número de pasos futuros a predecir
    forecast_index = pd.date_range(start=series.index[-1] + pd.Timedelta(days=1), periods=horizon, freq='D')
    forecast = model.forecast(horizon)
    forecast = pd.Series(forecast.values, index=forecast_index)
    
    # Graficar serie, ajuste y pronóstico
    plt.figure(figsize=(10, 5))
    plt.plot(series, label='Serie original', color='black')
    plt.plot(fitted_values, label=f'Suavizado SES (α optimizado = {alpha_opt:.4f})', color='blue')
    plt.plot(forecast, label='Pronóstico', color='red', linestyle='--')
    plt.title('Ajuste y Pronóstico con Suavizado Exponencial Simple (SES)')
    plt.xlabel('Fecha')
    plt.ylabel('Valor')
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.show()



.. image:: output_17_0.png


**¿Qué significa que** :math:`\alpha = 1` **en el Suavizado Exponencial
Simple (SES)?**

Cuando se aplica el método de **Suavizado Exponencial Simple (SES)** y
el valor óptimo de :math:`\alpha` resulta ser igual a 1, esto tiene una
interpretación específica y consecuencias importantes en el
comportamiento del modelo.

El SES se define mediante la fórmula recursiva:

.. math::


   S_t = \alpha\, y_t + (1 - \alpha)\, S_{t-1}

Si :math:`\alpha = 1`, la fórmula se simplifica a:

.. math::


   S_t = y_t

Esto significa que:

-  El valor suavizado en cada período es **igual al valor observado
   actual**.

-  **No hay influencia del pasado**: el modelo no retiene memoria.

-  El modelo **no suaviza nada** — simplemente replica la serie original
   sin filtrarla.

**Implicaciones prácticas:**

-  No se produce ningún efecto de “suavizado”: se comporta como una
   **copia directa** de la serie.

-  | El pronóstico será simplemente el **último valor observado**:
   | 

     .. math::


        \hat{y}_{t+h} = y_t

-  **No hay reducción de ruido** ni modelado de dinámica subyacente.

**¿Por qué puede suceder esto?**

-  La serie puede ser **muy volátil o errática**, sin patrones claros
   que puedan ser capturados por un nivel suavizado.

-  El modelo, al minimizar el error (ej. MSE), **prefiere seguir
   exactamente los datos** en lugar de suavizarlos.

-  Podría indicar que el SES **no es el método adecuado** para esa
   serie.

.. code:: ipython3

    import yfinance as yf
    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import matplotlib.dates as mdates
    
    # Descargar datos mensuales desde 2015
    start_date = "2021-01-01"
    end_date = "2025-07-31"
    
    # TRM de Colombia (USD/COP)
    serie = yf.download("^GSPC", start=start_date, end=end_date, interval='1mo', auto_adjust=False)['Close']
    serie.name = 'Serie de tiempo'
    
    # Establecer frecuencia explícita para evitar el warning de statsmodels
    serie.index.freq = serie.index.inferred_freq
    
    # Crear figura
    plt.figure(figsize=(10, 5))
    plt.plot(serie.index, serie, linestyle='-', color='navy')
    
    # Personalización del gráfico
    plt.title("Serie de tiempo original", fontsize=14)
    plt.xlabel("Fecha")
    plt.ylabel("COP")
    plt.grid(True, alpha=0.3)
    
    # Formato de fechas en el eje X
    plt.gca().xaxis.set_major_locator(mdates.YearLocator())
    plt.gca().xaxis.set_major_formatter(mdates.DateFormatter('%Y'))
    
    plt.tight_layout()
    plt.show()


.. parsed-literal::

    [*********************100%***********************]  1 of 1 completed
    


.. image:: output_19_1.png


.. code:: ipython3

    # Ajustar SES con alpha optimizado automáticamente
    model = SimpleExpSmoothing(serie).fit(optimized=True)
    fitted_values = model.fittedvalues
    alpha_opt = model.model.params['smoothing_level']
    
    # Graficar resultados
    plt.figure(figsize=(10, 5))
    plt.plot(serie, label='Serie original', color='black')
    plt.plot(fitted_values, label=f'Suavizado SES (α optimizado = {alpha_opt:.4f})', color='blue')
    plt.title('Ajuste con Suavizado Exponencial Simple (SES)')
    plt.xlabel('Fecha')
    plt.ylabel('Valor')
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.show()



.. image:: output_20_0.png


Método de Holt (Suavizado Exponencial Doble):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El **método de Holt** (Holt, 1957), también conocido como **suavizado
exponencial doble**, extiende el Suavizado Exponencial Simple (SES) para
permitir el pronóstico de **series de tiempo con tendencia**, pero sin
estacionalidad.

La idea es incorporar un segundo componente —la **tendencia**— que
evoluciona junto con el nivel de la serie. Así, el pronóstico no es
plano como en SES, sino que sigue una trayectoria lineal en el tiempo.

**Componentes del modelo**

-  **Nivel** :math:`\ell_t`: representa el valor suavizado de la serie.

-  **Tendencia** :math:`b_t`: representa la pendiente o cambio esperado
   entre períodos.

Las ecuaciones del modelo son:

-  **Ecuación de nivel:**

| 

  .. math::


     \ell_t = \alpha y_t + (1-\alpha)(\ell_{t-1} + b_{t-1})
| - **Ecuación de tendencia:**

| 

  .. math::


     b_t = \beta (\ell_t - \ell_{t-1}) + (1-\beta)b_{t-1}
| - **Ecuación de pronóstico:**

| 

  .. math::


     \hat{y}_{t+h|t} = \ell_t + h b_t
| donde:

-  :math:`y_t`: valor observado en el período :math:`t`

-  :math:`\ell_t`: nivel estimado en :math:`t`

-  :math:`b_t`: tendencia estimada en :math:`t`

-  :math:`\hat{y}_{t+h|t}`: pronóstico a :math:`h` pasos adelante

-  :math:`\alpha \in (0,1)`: parámetro de suavizado para el nivel

-  :math:`\beta \in (0,1)`: parámetro de suavizado para la tendencia

**Interpretación**

El método de Holt utiliza **dos parámetros de suavizamiento**:

-  **Nivel** :math:`\ell_t`: ajusta el valor actual de la serie
   considerando la tendencia previa.

-  **Tendencia** :math:`b_t`: captura el cambio promedio de la serie y
   se actualiza dinámicamente.

-  **Pronóstico:** se obtiene extrapolando el último nivel estimado más
   :math:`h` veces la tendencia.

-  :math:`\alpha`: controla la rapidez de actualización del **nivel**
   :math:`\ell_t`.

-  :math:`\beta`: controla la rapidez de actualización de la
   **tendencia** :math:`b_t`.

**Cuando los parámetros se aproximan a 0:**

-  :math:`\alpha \to 0`:

   -  El nivel :math:`\ell_t` cambia muy lentamente.

   -  El modelo se vuelve estable, pero tarda en reflejar cambios en la
      serie.

-  :math:`\beta \to 0`:

   -  La tendencia :math:`b_t` casi no se actualiza.

   -  El modelo mantiene una pendiente casi constante, basada en el
      pasado lejano.

**Cuando los parámetros se aproximan a 1:**

-  :math:`\alpha \to 1`:

   -  El nivel :math:`\ell_t` se ajusta casi por completo al valor
      observado :math:`y_t`.

   -  El modelo reacciona con fuerza a los cambios recientes, pero puede
      volverse muy sensible al ruido.

-  :math:`\beta \to 1`:

   -  La tendencia :math:`b_t` se ajusta principalmente a la diferencia
      más reciente :math:`(\ell_t - \ell_{t-1})`.

   -  El modelo capta cambios bruscos en la pendiente, pero puede
      sobrerreaccionar y producir pronósticos inestables.

-  Valores **cercanos a 0** → efecto de suavizamiento fuerte: los
   cambios se incorporan lentamente.

-  Valores **cercanos a 1** → efecto de suavizamiento débil: el modelo
   reacciona rápido, pero con riesgo de seguir el ruido en lugar de la
   señal.

**¿Cuándo usar el modelo de Holt?**

-  Cuando la serie presenta una **tendencia clara y sostenida**.

-  Cuando **no existe estacionalidad** en la serie.

-  Cuando se desea un modelo simple, interpretable y capaz de reflejar
   crecimiento o decrecimiento lineal.

**Ventajas**

-  Captura de manera explícita **tendencias crecientes o decrecientes**.

-  Extiende el SES con una formulación sencilla y eficiente.

-  Funciona bien en datos sin estacionalidad pero con patrones lineales
   persistentes.

**Limitaciones**

-  No modela estacionalidad (para eso se requiere Holt–Winters).

-  Puede sobrerreaccionar o subestimar si la tendencia cambia
   bruscamente.

-  Tiende a **sobreestimar en horizontes largos**, ya que la tendencia
   se proyecta indefinidamente.

**Ejemplo del método de Holt (suavizado doble):**

Supongamos la serie:

.. math::


   \{y_t\} = [10,\;12,\;11,\;13,\;12]

con parámetros :math:`\alpha = 0.4` y :math:`\beta = 0.3`.

**Inicialización:**

-  Nivel inicial: :math:`\ell_1 = y_1 = 10`

-  Tendencia inicial: :math:`b_1 = y_2 - y_1 = 12 - 10 = 2`

**Ecuaciones del modelo\_**

-  **Ecuación de nivel:**

.. math::


   \ell_t = \alpha y_t + (1-\alpha)(\ell_{t-1} + b_{t-1})

-  **Ecuación de tendencia:**

.. math::


   b_t = \beta (\ell_t - \ell_{t-1}) + (1-\beta)b_{t-1}

-  **Ecuación de pronóstico:**

.. math::


   \hat{y}_{t+h|t} = \ell_t + h b_t

**Cálculos paso a paso:**

1. :math:`t=2`

   -  :math:`\ell_2 = 0.4 \cdot 12 + 0.6 \cdot (10 + 2) = 12.0`

   -  :math:`b_2 = 0.3 \cdot (12.0 - 10.0) + 0.7 \cdot 2.0 = 2.0`

2. :math:`t=3`

   -  :math:`\ell_3 = 0.4 \cdot 11 + 0.6 \cdot (12.0 + 2.0) = 12.8`

   -  :math:`b_3 = 0.3 \cdot (12.8 - 12.0) + 0.7 \cdot 2.0 = 1.64`

3. :math:`t=4`

   -  :math:`\ell_4 = 0.4 \cdot 13 + 0.6 \cdot (12.8 + 1.64) = 13.864`

   -  :math:`b_4 = 0.3 \cdot (13.864 - 12.8) + 0.7 \cdot 1.64 = 1.4672`

4. :math:`t=5`

   -  :math:`\ell_5 = 0.4 \cdot 12 + 0.6 \cdot (13.864 + 1.4672) = 14.1997`

   -  :math:`b_5 = 0.3 \cdot (14.1997 - 13.864) + 0.7 \cdot 1.4672 = 1.1277`

**Pronósticos fuera de la muestra:**

Con :math:`\ell_5 = 14.1997` y :math:`b_5 = 1.1277`:

-  Para :math:`t=6`:

.. math::


   \hat{y}_{6|5} = \ell_5 + 1 \cdot b_5 = 15.3274

-  Para :math:`t=7`:

.. math::


   \hat{y}_{7|5} = \ell_5 + 2 \cdot b_5 = 16.4551

**Ejemplo del método de Holt (suavizado doble):**

| Supongamos la serie :math:`\{y_t\} = [10,\;12,\;11,\;13,\;12]`, con
  parámetros :math:`\alpha = 0.4` y :math:`\beta = 0.3`.
| Inicializamos:

-  Nivel inicial: :math:`L_1 = y_1 = 10`

-  Tendencia inicial: :math:`T_1 = y_2 - y_1 = 12 - 10 = 2`

Aplicamos las fórmulas de Holt:

.. math::


   L_t = \alpha y_t + (1 - \alpha)(L_{t-1} + T_{t-1})

.. math::


   T_t = \beta (L_t - L_{t-1}) + (1 - \beta) T_{t-1}

.. math::


   \hat{y}_{t+h} = L_t + h \cdot T_t

1. :math:`L_2 = 0.4 \cdot 12 + 0.6 \cdot (10 + 2) = 4.8 + 7.2 = 12.0`

   :math:`T_2 = 0.3 \cdot (12.0 - 10.0) + 0.7 \cdot 2.0 = 0.6 + 1.4 = 2.0`

2. :math:`L_3 = 0.4 \cdot 11 + 0.6 \cdot (12.0 + 2.0) = 4.4 + 8.4 = 12.8`

   :math:`T_3 = 0.3 \cdot (12.8 - 12.0) + 0.7 \cdot 2.0 = 0.24 + 1.4 = 1.64`

3. :math:`L_4 = 0.4 \cdot 13 + 0.6 \cdot (12.8 + 1.64) = 5.2 + 8.664 = 13.864`

   :math:`T_4 = 0.3 \cdot (13.864 - 12.8) + 0.7 \cdot 1.64 = 0.3192 + 1.148 = 1.4672`

4. :math:`L_5 = 0.4 \cdot 12 + 0.6 \cdot (13.864 + 1.4672) = 4.8 + 9.3997 = 14.1997`

   :math:`T_5 = 0.3 \cdot (14.1997 - 13.864) + 0.7 \cdot 1.4672 = 0.1007 + 1.027 = 1.1277`

**Pronóstico:**

Usamos la fórmula :math:`\hat{y}_{t+h} = L_t + h \cdot T_t`.

-  Pronóstico para :math:`t = 6`:

   :math:`\hat{y}_6 = L_5 + 1 \cdot T_5 = 14.1997 + 1.1277 = 15.3274`

-  Pronóstico para :math:`t = 7`:

   :math:`\hat{y}_7 = L_5 + 2 \cdot T_5 = 14.1997 + 2 \cdot 1.1277 = 16.4551`

.. code:: ipython3

    from statsmodels.tsa.holtwinters import Holt

.. code:: ipython3

    # Ajuste del modelo de Holt (suavizado doble)
    model = Holt(serie).fit(optimized=True)
    fitted_values = model.fittedvalues
    # Extraer parámetros optimizados
    alpha_opt = model.model.params['smoothing_level']
    beta_opt = model.model.params['smoothing_trend']
    
    # Graficar resultados
    plt.figure(figsize=(10, 5))
    plt.plot(serie, label='Serie original', color='black')
    plt.plot(fitted_values, label=f'Holt: α = {alpha_opt:.4f}, β = {beta_opt:.4f}', color='darkgreen')
    plt.title('Ajuste con Suavizado Exponencial Doble (Holt)')
    plt.xlabel('Fecha')
    plt.ylabel('Valor')
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.show()



.. image:: output_27_0.png


Método de Holt-Winters (Suavizado Exponencial Triple):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El **método de Holt-Winters**, también llamado **suavizado exponencial
triple**, extiende el método de Holt para capturar **estacionalidad**.

Es apropiado para series con:

-  **Nivel**: valor central de la serie.

-  **Tendencia**: crecimiento o decrecimiento a lo largo del tiempo.

-  **Estacionalidad**: patrón recurrente cada :math:`m` períodos.

Existen dos versiones: **aditiva** (cuando la amplitud estacional es
constante) y **multiplicativa** (cuando la amplitud depende del nivel).

**Versión aditiva**

Forma de componentes:

-  **Nivel**

.. math::


   \ell_t = \alpha (y_t - s_{t-m}) + (1-\alpha)(\ell_{t-1} + b_{t-1})

- **Tendencia**

.. math::


   b_t = \beta (\ell_t - \ell_{t-1}) + (1-\beta) b_{t-1}

- **Estacionalidad**

| 

  .. math::


     s_t = \gamma(y_t - \ell_{t-1} - b_{t-1}) + (1-\gamma)s_{t-m}
| - **Pronóstico**

| 

  .. math::


     \hat{y}_{t+h|t} = \ell_t + h b_t + s_{t+h-m(k+1)}
| donde :math:`k = \lfloor (h-1)/m \rfloor` asegura que los índices
  estacionales usados provengan del último ciclo completo.

Los :math:`s_t` son **desviaciones absolutas** respecto al nivel. En
cada ciclo anual o completo suman aproximadamente cero.

**Versión multiplicativa:**

Forma de componentes:

-  **Nivel**

| 

  .. math::


     \ell_t = \alpha \left(\frac{y_t}{s_{t-m}}\right) + (1-\alpha)(\ell_{t-1} + b_{t-1})
| - **Tendencia**

| 

  .. math::


     b_t = \beta (\ell_t - \ell_{t-1}) + (1-\beta) b_{t-1}
| - **Estacionalidad**

| 

  .. math::


     s_t = \gamma\left(\frac{y_t}{\ell_{t-1}+b_{t-1}}\right) + (1-\gamma)s_{t-m}
| - **Pronóstico**

| 

  .. math::


     \hat{y}_{t+h|t} = (\ell_t + h b_t)\; s_{t+h-m(k+1)}
| Los :math:`s_t` son **índices relativos** (porcentuales). En cada
  ciclo completo promedian aproximadamente 1.

**Parámetros de suavizado:**

-  :math:`\alpha`: controla la actualización del **nivel**
   (:math:`0 < \alpha < 1`).

-  :math:`\beta`: controla la **suavización de la tendencia**.

-  :math:`\gamma`: controla la **suavización de la estacionalidad**.

\**¿Cuándo usar cada versión?

+------------------+--------------+-----------------------------------+
| Tipo de          | Modelo       | Ejemplo                           |
| estacionalidad   | recomendado  |                                   |
+==================+==============+===================================+
| Constante en     | Aditivo      | La demanda aumenta 100 unidades   |
| magnitud         |              | cada diciembre                    |
+------------------+--------------+-----------------------------------+
| Proporcional al  | Mu           | Las ventas suben un 10% cada      |
| nivel            | ltiplicativo | diciembre                         |
+------------------+--------------+-----------------------------------+

**Ventajas y limitaciones:**

-  **Ventajas:**

-  Captura **nivel, tendencia y estacionalidad** simultáneamente.

-  Genera pronósticos consistentes con la estructura cíclica.

-  Estimación automática de parámetros mediante optimización.

-  **Limitaciones:**

-  Requiere estacionalidad **regular y estable**.

-  Supone que el patrón se repite exactamente cada :math:`m` períodos.

-  Menos adecuado para series financieras con alta volatilidad.

\**Ejemplo del método de Holt-Winters (versión aditiva):

Supongamos una serie con **estacionalidad trimestral** (:math:`m = 3`
para simplificar), con valores:

.. math::


   \{y_t\} = [30,\; 40,\; 50,\; 35,\; 45,\; 55]

La serie tiene un ciclo estacional de 3 períodos, con patrones que se
repiten:

-  Mes 1: 30 → 35

-  Mes 2: 40 → 45

-  Mes 3: 50 → 55

Parámetros de suavizado:

-  :math:`\alpha = 0.5` (nivel)

-  :math:`\beta = 0.3` (tendencia)

-  :math:`\gamma = 0.2` (estacionalidad)

**Inicialización:**

-  Nivel inicial: :math:`\ell_3 = y_3 = 50`

-  Tendencia inicial:
   :math:`b_3 = \dfrac{y_3 - y_1}{2} = \dfrac{50 - 30}{2} = 10`

-  Estacionalidad inicial:

   -  :math:`s_1 = y_1 - \ell_3 = 30 - 50 = -20`

   -  :math:`s_2 = y_2 - \ell_3 = 40 - 50 = -10`

   -  :math:`s_3 = y_3 - \ell_3 = 50 - 50 = 0`

**Paso 4:** :math:`y_4 = 35`

.. math::


   \ell_t = \alpha(y_t - s_{t-m}) + (1-\alpha)(\ell_{t-1} + b_{t-1})

.. math::


   b_t = \beta(\ell_t - \ell_{t-1}) + (1-\beta) b_{t-1}

.. math::


   s_t = \gamma(y_t - \ell_t) + (1-\gamma) s_{t-m}

-  :math:`\ell_4 = 0.5(35 - s_1) + 0.5(\ell_3 + b_3) = 0.5(35+20) + 0.5(60) = 57.5`

-  :math:`b_4 = 0.3(57.5 - 50) + 0.7(10) = 9.25`

-  :math:`s_4 = 0.2(35 - 57.5) + 0.8(-20) = -20.5`

**Paso 5:** :math:`y_5 = 45`

-  :math:`\ell_5 = 0.5(45 - s_2) + 0.5(\ell_4 + b_4) = 0.5(45+10) + 0.5(66.75) = 60.875`

-  :math:`b_5 = 0.3(60.875 - 57.5) + 0.7(9.25) = 7.4875`

-  :math:`s_5 = 0.2(45 - 60.875) + 0.8(-10) = -11.175`

**Paso 6:** :math:`y_6 = 55`

-  :math:`\ell_6 = 0.5(55 - s_3) + 0.5(\ell_5 + b_5) = 0.5(55-0) + 0.5(68.3625) = 61.68125`

-  :math:`b_6 = 0.3(61.68125 - 60.875) + 0.7(7.4875) = 5.4831`

-  :math:`s_6 = 0.2(55 - 61.68125) + 0.8(0) = -1.33625`

**Pronósticos desde** :math:`t=6`

Usamos la fórmula:

.. math::


   \hat{y}_{t+h|t} = \ell_t + h b_t + s_{t+h-m(k+1)}

Con :math:`\ell_6 = 61.68125`, :math:`b_6 = 5.4831`:

-  :math:`\hat{y}_{7|6} = \ell_6 + 1 \cdot b_6 + s_4 = 61.68125 + 5.4831 - 20.5 = 46.66`

-  :math:`\hat{y}_{8|6} = \ell_6 + 2 \cdot b_6 + s_5 = 61.68125 + 10.9662 - 11.175 = 61.47`

-  :math:`\hat{y}_{9|6} = \ell_6 + 3 \cdot b_6 + s_6 = 61.68125 + 16.4494 - 1.3363 = 76.79`

Este ejemplo muestra cómo Holt-Winters aditivo **descompone la serie**
en nivel, tendencia y estacionalidad para producir pronósticos
coherentes con el comportamiento cíclico.

.. code:: ipython3

    from statsmodels.tsa.holtwinters import ExponentialSmoothing

.. code:: ipython3

    # Ajustar modelo Holt-Winters aditivo
    modelo = ExponentialSmoothing(
        serie, 
        trend='add',
        seasonal='multiplicative',
        seasonal_periods=12,
    ).fit(optimized=True)
    
    # Pronóstico a 12 pasos
    pronostico = modelo.forecast(12)
    
    # Extraer parámetros
    params = modelo.params
    alpha = params['smoothing_level']
    beta = params['smoothing_trend']
    gamma = params['smoothing_seasonal']
    
    # Graficar serie original, ajuste y pronóstico
    plt.figure(figsize=(12, 5))
    plt.plot(serie, label='Serie original', color='black')
    plt.plot(modelo.fittedvalues, label=f'Ajuste HW (α={alpha:.2f}, β={beta:.2f}, γ={gamma:.2f})', color='blue')
    plt.plot(pronostico, label='Pronóstico 12 meses', color='red', linestyle='--')
    plt.title('Ajuste y Pronóstico con Holt-Winters (Aditivo)')
    plt.xlabel('Fecha')
    plt.ylabel('Valor')
    plt.legend()
    plt.grid(True, linestyle='--', alpha=0.5)
    plt.tight_layout()
    plt.show()



.. image:: output_32_0.png


.. code:: ipython3

    from statsmodels.tsa.holtwinters import SimpleExpSmoothing, Holt, ExponentialSmoothing
    
    # Ajuste 1: Suavizado Exponencial Simple (SES)
    ses_model = SimpleExpSmoothing(serie).fit(optimized=True)
    ses_fit = ses_model.fittedvalues
    
    # Ajuste 2: Holt (nivel + tendencia)
    holt_model = Holt(serie).fit(optimized=True)
    holt_fit = holt_model.fittedvalues
    
    # Ajuste 3: Holt-Winters (nivel + tendencia + estacionalidad)
    hw_model = ExponentialSmoothing(serie, trend='add', seasonal='add', seasonal_periods=12).fit(optimized=True)
    hw_fit = hw_model.fittedvalues
    
    # Graficar los tres ajustes sobre la serie original
    plt.figure(figsize=(14, 6))
    plt.plot(serie, label='Serie original', color='black', linewidth=2)
    plt.plot(ses_fit, label='SES (nivel)', color='blue', linestyle='--')
    plt.plot(holt_fit, label='Holt (nivel + tendencia)', color='green', linestyle='--')
    plt.plot(hw_fit, label='Holt-Winters (nivel + tendencia + estacionalidad)', color='red', linestyle='--')
    
    plt.title('Comparación de métodos de suavizado: SES, Holt y Holt-Winters')
    plt.xlabel('Fecha')
    plt.ylabel('Valor')
    plt.legend()
    plt.grid(True, linestyle='--', alpha=0.5)
    plt.tight_layout()
    plt.show()
    



.. image:: output_33_0.png

