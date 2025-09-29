Prueba ADF (Augmented Dickey-Fuller)
------------------------------------

La prueba **ADF** es una de las herramientas más utilizadas para
determinar si una **serie de tiempo es estacionaria**. Su propósito es
verificar si la serie tiene una **raíz unitaria**, lo que implicaría
**no estacionariedad**.

**Hipótesis de la prueba**

-  **Hipótesis nula** (:math:`H_0`): La serie tiene una raíz unitaria →
   **no estacionaria**

-  **Hipótesis alternativa** (:math:`H_1`): La serie no tiene raíz
   unitaria → **estacionaria**

**Modelo base**

La prueba ADF se basa en estimar la siguiente regresión:

.. math::


   \Delta y_t = \alpha + \beta t + \gamma y_{t-1} + \sum_{i=1}^p \delta_i \Delta y_{t-i} + \varepsilon_t

donde:

-  :math:`\Delta y_t = y_t - y_{t-1}` es la primera diferencia de la
   serie

-  :math:`t` es una tendencia determinista (opcional)

-  :math:`p` es el número de rezagos incluidos (para controlar
   autocorrelación)

-  :math:`\gamma` es el parámetro clave para evaluar la presencia de una
   raíz unitaria

-  :math:`\varepsilon_t` es un término de error (ruido blanco)

**¿Qué evalúa la prueba?**

El valor clave es el coeficiente :math:`\gamma` asociado a
:math:`y_{t-1}` en la regresión.

-  Si :math:`\gamma = 0`, entonces la ecuación se convierte en:

   .. math::


      \Delta y_t = \alpha + \beta t + \sum \delta_i \Delta y_{t-i} + \varepsilon_t

   → Lo que implica que la serie **tiene una raíz unitaria** (es un
   random walk), y por tanto **no es estacionaria**.

-  Si :math:`\gamma < 0`, entonces el término :math:`y_{t-1}` **fuerza
   un retorno al promedio**, lo cual es consistente con una **serie
   estacionaria**.

**¿Por qué el estadístico ADF da negativo?**

Cuando se estima :math:`\gamma` y se calcula el estadístico de prueba
ADF, este suele ser **negativo** porque estamos evaluando si
:math:`\gamma < 0`.

Cuanto **más negativo sea el valor**, más evidencia existe contra la
hipótesis nula (no estacionaria).

**Valor p y decisión estadística**

La prueba devuelve un **valor p** que indica la probabilidad de obtener
un estadístico como el observado, **asumiendo que la hipótesis nula es
cierta**.

-  Si :math:`p < 0.05`, se **rechaza** :math:`H_0` → no hay raíz
   unitaria → la serie **es estacionaria**.

-  Si :math:`p \geq 0.05`, **no se rechaza** :math:`H_0` → no hay
   evidencia suficiente para afirmar estacionariedad → la serie **podría
   no ser estacionaria**.

**Tipos de modelos en la prueba ADF**

Dependiendo de la naturaleza de la serie, se pueden evaluar diferentes
variantes del modelo ADF:

1. **Sin constante ni tendencia**:

   .. math::


      \Delta y_t = \gamma y_{t-1} + \sum \delta_i \Delta y_{t-i} + \varepsilon_t

2. **Con constante**:

   .. math::


      \Delta y_t = \alpha + \gamma y_{t-1} + \sum \delta_i \Delta y_{t-i} + \varepsilon_t

3. **Con constante y tendencia**:

   .. math::


      \Delta y_t = \alpha + \beta t + \gamma y_{t-1} + \sum \delta_i \Delta y_{t-i} + \varepsilon_t

La elección depende de si se sospecha que la serie tiene **tendencia
determinista** o simplemente **nivel constante**.

**Resumen:**

-  Se estima una regresión en primeras diferencias con :math:`y_{t-1}`
   como regresor.

-  Se evalúa si :math:`\gamma < 0` de forma significativa.

-  El **estadístico ADF** negativo refleja el valor estimado de
   :math:`\gamma`.

-  El **valor p** indica si ese resultado es estadísticamente
   significativo.

**Criterios de interpretación**

+---------------+-------------------+--------------------------------+
| Resultado ADF | Valor p           | Conclusión                     |
+===============+===================+================================+
| Muy negativo  | :math:`< 0.05`    | Rechazar :math:`H_0` →         |
|               |                   | **Estacionaria**               |
+---------------+-------------------+--------------------------------+
| Cercano a 0   | :math:`\geq 0.05` | No rechazar :math:`H_0` → **No |
|               |                   | estacionaria**                 |
+---------------+-------------------+--------------------------------+

.. figure:: Analog_resorte.png
   :alt: Analog_resorte

   Analog_resorte

Se podría afirmar que una serie es estacionaria si :math:`y_{t-1}` ayuda
a predecir la variación siguiente de la serie de tiempo
(:math:`\Delta y_t`).

Lo que hace la prueba es verificar si :math:`y_{t-1}` aporta información
significativa para predecir :math:`\Delta y_t`.

Si :math:`y_{t-1}` no tiene ningún efecto sobre :math:`\Delta y_t` (es
decir, :math:`\gamma = 0`), la serie tiene una raíz unitaria → no es
estacionaria.

Si :math:`y_{t-1}` sí tiene un efecto negativo (es decir,
:math:`\gamma < 0` y significativo), la serie tiende a corregirse, lo
que indica estacionariedad.

**Interpretación económica**

Cuando :math:`y_{t-1}` ayuda a predecir la dirección y magnitud del
cambio futuro:

-  Si :math:`y_{t-1}` es alto, :math:`\Delta y_t` tiende a ser negativo
   → la serie baja.

-  Si :math:`y_{t-1}` es bajo, :math:`\Delta y_t` tiende a ser positivo
   → la serie sube.

Esto indica que la serie tiene fuerza de retorno al promedio → propiedad
típica de una serie estacionaria.

**Observación:**

Que :math:`y_{t-1}` ayude a predecir :math:`\Delta y_t` no es una
definición general de estacionariedad, sino una forma práctica de
evaluarla bajo el modelo autorregresivo en primera diferencia.

.. figure:: series_adf_visual_examples.png
   :alt: series_adf_visual_examples

   series_adf_visual_examples

Código Pyhton para prueba ADF:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Irradiancia Medellín:
~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    import pandas as pd
    import numpy as np
    from matplotlib import pyplot as plt
    import matplotlib.dates as mdates
    
    # Cargar el archivo xlsx:
    df = pd.read_excel('Irradiancia Medellín.xlsx')
    
    # Corregir nombres de columnas si tienen espacios
    df.columns = df.columns.str.strip()
    
    # Convertir 'Fecha' a datetime y usar como índice
    df['Fecha'] = pd.to_datetime(df['Fecha'])
    df.set_index('Fecha', inplace=True)
    
    # Ordenar por fecha por si acaso
    df = df.sort_index()
    
    # Establecer frecuencia explícita para evitar el warning de statsmodels
    df.index.freq = df.index.inferred_freq
    
    plt.figure(figsize=(18, 5))
    plt.plot(df, color='navy')
    plt.title("Serie de tiempo: Irradiancia Medellín")
    plt.xlabel("Fecha")
    plt.ylabel("Valor")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_7_0.png


**Opción** ``regression`` **en la prueba ADF**

Cuando aplicamos la prueba ADF en Python con ``adfuller``, el argumento
``regression`` nos permite indicar qué términos incluir en la regresión
auxiliar. Las opciones disponibles son:

+---+----------------+-----------------------+------------------------+
| O | Componentes    | Descripción           | Cuándo usarla          |
| p | incluidos      |                       |                        |
| c |                |                       |                        |
| i |                |                       |                        |
| ó |                |                       |                        |
| n |                |                       |                        |
+===+================+=======================+========================+
| n | Ninguno        | No incluye constante  | Cuando se espera que   |
|   |                | ni tendencia          | la serie fluctúe       |
|   |                |                       | alrededor de cero      |
+---+----------------+-----------------------+------------------------+
| c | Constante      | Incluye solo el       | Cuando la serie no     |
|   | **(por         | intercepto (media     | tiene tendencia, pero  |
|   | defecto)**     | distinta de cero)     | sí una media estable   |
+---+----------------+-----------------------+------------------------+
| c | Constante +    | Incluye intercepto y  | Cuando la serie        |
| t | tendencia      | pendiente lineal      | muestra una tendencia  |
|   | lineal         |                       | lineal creciente o     |
|   |                |                       | decreciente            |
+---+----------------+-----------------------+------------------------+
| c | Constante +    | Intercepto, pendiente | Cuando la serie        |
| t | tendencia      | y curvatura (forma    | presenta una           |
| t | lineal +       | parabólica)           | aceleración o          |
|   | cuadrática     |                       | desaceleración clara   |
+---+----------------+-----------------------+------------------------+

-  **Regresión** ``"n"``: Ruido blanco sin media ni tendencia

-  **Regresión** ``"c"``: Serie con media distinta de cero

-  **Regresión** ``"ct"``: Serie con tendencia lineal clara

-  **Regresión** ``"ctt"``: Serie con tendencia cuadrática (curvatura)

**Recomendaciones prácticas:**

-  Siempre **inspecciona visualmente** la serie antes de elegir la
   opción de regresión.

-  Si tienes dudas, compara resultados con ``"c"`` y ``"ct"``.

-  Incluir **pocos términos** cuando hay una tendencia puede llevar a
   errores tipo II (falsos negativos).

-  Incluir **demasiados términos** cuando no son necesarios puede
   reducir la potencia del test.

.. code:: ipython3

    from statsmodels.tsa.stattools import adfuller

.. code:: ipython3

    adf_result = adfuller(df, regression='c')
    print(f'Estadístico ADF: {adf_result[0]}')
    print(f'Valor p: {adf_result[1]}')
    
    # Interpretación del resultado
    alpha = 0.05
    if adf_result[1] < alpha:
        print("Rechazamos la hipótesis nula: La serie es estacionaria.")
    else:
        print("No podemos rechazar la hipótesis nula: La serie no es estacionaria.")


.. parsed-literal::

    Estadístico ADF: -5.62921700067201
    Valor p: 1.0992990513355553e-06
    Rechazamos la hipótesis nula: La serie es estacionaria.
    

Temperatura Medellín:
~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Cargar el archivo xlsx:
    df = pd.read_excel('Temperatura Medellín.xlsx')
    
    # Corregir nombres de columnas si tienen espacios
    df.columns = df.columns.str.strip()
    
    # Convertir 'Fecha' a datetime y usar como índice
    df['Fecha'] = pd.to_datetime(df['Fecha'])
    df.set_index('Fecha', inplace=True)
    
    # Ordenar por fecha por si acaso
    df = df.sort_index()
    
    # Establecer frecuencia explícita para evitar el warning de statsmodels
    df.index.freq = df.index.inferred_freq
    
    plt.figure(figsize=(18, 5))
    plt.plot(df, color='navy')
    plt.title("Serie de tiempo: Temperatura Medellín")
    plt.xlabel("Fecha")
    plt.ylabel("Valor")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()
    



.. image:: output_12_0.png


.. code:: ipython3

    adf_result = adfuller(df, regression='c')
    print(f'Estadístico ADF: {adf_result[0]}')
    print(f'Valor p: {adf_result[1]}')
    
    # Interpretación del resultado
    alpha = 0.05
    if adf_result[1] < alpha:
        print("Rechazamos la hipótesis nula: La serie es estacionaria.")
    else:
        print("No podemos rechazar la hipótesis nula: La serie no es estacionaria.")


.. parsed-literal::

    Estadístico ADF: -3.825685846590857
    Valor p: 0.002655181395794833
    Rechazamos la hipótesis nula: La serie es estacionaria.
    

TRM:
~~~~

.. code:: ipython3

    import yfinance as yf
    
    # Descargar datos mensuales desde 2015
    start_date = "2015-01-01"
    end_date = "2025-07-31"
    
    # TRM de Colombia (USD/COP)
    trm = yf.download("USDCOP=X", start=start_date, end=end_date, interval='1mo', auto_adjust=False)['Close']
    trm.name = 'TRM (USD/COP)'
    
    # Crear figura
    plt.figure(figsize=(10, 5))
    plt.plot(trm.index, trm, linestyle='-', color='navy')
    
    # Personalización del gráfico
    plt.title("Evolución de la TRM (USD/COP)", fontsize=14)
    plt.xlabel("Fecha")
    plt.ylabel("TRM (Pesos por USD)")
    plt.grid(True, alpha=0.3)
    
    # Formato de fechas en el eje X
    plt.gca().xaxis.set_major_locator(mdates.YearLocator())
    plt.gca().xaxis.set_major_formatter(mdates.DateFormatter('%Y'))
    
    plt.tight_layout()
    plt.show()


.. parsed-literal::

    [*********************100%***********************]  1 of 1 completed
    


.. image:: output_15_1.png


.. code:: ipython3

    adf_result = adfuller(trm, regression='ct')
    print(f'Estadístico ADF: {adf_result[0]}')
    print(f'Valor p: {adf_result[1]}')
    
    # Interpretación del resultado
    alpha = 0.05
    if adf_result[1] < alpha:
        print("Rechazamos la hipótesis nula: La serie es estacionaria.")
    else:
        print("No podemos rechazar la hipótesis nula: La serie no es estacionaria.")


.. parsed-literal::

    Estadístico ADF: -2.941854349451379
    Valor p: 0.14906916064463072
    No podemos rechazar la hipótesis nula: La serie no es estacionaria.
    

Primera diferencia de la TRM:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    diff_trm = trm.diff().dropna()
    
    # Crear figura
    plt.figure(figsize=(10, 5))
    plt.plot(diff_trm.index, diff_trm, linestyle='-', color='navy')
    
    # Personalización del gráfico
    plt.title("Primera diferencia de la TRM", fontsize=14)
    plt.xlabel("Fecha")
    plt.ylabel("Valor")
    plt.grid(True, alpha=0.3)
    
    # Formato de fechas en el eje X
    plt.gca().xaxis.set_major_locator(mdates.YearLocator())
    plt.gca().xaxis.set_major_formatter(mdates.DateFormatter('%Y'))
    
    plt.tight_layout()
    plt.show()



.. image:: output_18_0.png


.. code:: ipython3

    adf_result = adfuller(diff_trm, regression='c')
    print(f'Estadístico ADF: {adf_result[0]}')
    print(f'Valor p: {adf_result[1]}')
    
    # Interpretación del resultado
    alpha = 0.05
    if adf_result[1] < alpha:
        print("Rechazamos la hipótesis nula: La serie es estacionaria.")
    else:
        print("No podemos rechazar la hipótesis nula: La serie no es estacionaria.")


.. parsed-literal::

    Estadístico ADF: -5.131705099077063
    Valor p: 1.2100634062755294e-05
    Rechazamos la hipótesis nula: La serie es estacionaria.
    
