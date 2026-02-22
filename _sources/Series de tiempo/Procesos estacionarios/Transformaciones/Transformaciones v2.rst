Transformaciones
----------------

Las **series de tiempo no estacionarias** presentan patrones de
tendencia, estacionalidad o cambios en la varianza que dificultan su
modelado y pronóstico. Para abordar estos problemas, se aplican
**transformaciones matemáticas** que permiten:

-  Convertir una serie no estacionaria en una serie **estacionaria**

-  **Simplificar los patrones** de la serie (por ejemplo, eliminar una
   tendencia o reducir la estacionalidad)

-  **Estabilizar la varianza** cuando esta varía con el nivel de la
   serie

Tipos de Transformaciones
~~~~~~~~~~~~~~~~~~~~~~~~~

Transformaciones para eliminar la tendencia
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Estas técnicas permiten eliminar tendencias deterministas o suavizar
componentes que hacen que la serie no tenga una media constante en el
tiempo.

**Diferenciación (Differencing):**

Consiste en calcular las diferencias entre valores consecutivos:

.. math::


   y_t' = y_t - y_{t-1}

Si después de aplicar una diferencia la serie aún no es estacionaria, se
pueden aplicar diferencias adicionales (segunda diferencia, etc.).

**¿Cuándo usar?**

-  Cuando la serie muestra una **tendencia creciente o decreciente**

-  Cuando el gráfico de la serie indica **no estacionariedad en media**

.. figure:: Transformación_diff.png
   :alt: Transformación_diff

   Transformación_diff

Transformaciones para estabilizar la varianza:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

En muchos modelos de series de tiempo o de regresión, se asume que la
varianza de los errores es constante (homocedasticidad).

Sin embargo, cuando la variabilidad de la serie aumenta con el nivel de
la media, se presenta heterocedasticidad, lo que viola esa suposición y
puede afectar el desempeño del modelo.

Para corregirlo, se aplican transformaciones no lineales a la serie
original, con el objetivo de:

-  Reducir la variabilidad relativa de los datos.

-  Mejorar la normalidad de los errores.

-  Facilitar la identificación de patrones de tendencia y
   estacionalidad.

**Raíz cuadrada:**

**Logaritmo:**

.. math::


   y_t' = \log(y_t)

**Raíz cuadrada:**

La transformación de raíz cuadrada se define como:

.. math::


   y_t' = \sqrt{y_t}

Se utiliza cuando los valores de la serie son **positivos** y la
varianza crece aproximadamente de forma proporcional a la media.

Cuando los valores de la serie aumentan, también suele aumentar su
variabilidad.

Aplicar la raíz cuadrada reduce la dispersión relativa de los valores
grandes y tiende a estabilizar la varianza.

**Ventajas**

-  Es sencilla de aplicar e interpretar.

-  No requiere estimar parámetros.

-  Siempre produce valores positivos si :math:`y_t > 0`.

**Desventajas**

-  No siempre corrige completamente la heterocedasticidad.

-  Puede no ser suficiente si la serie tiene alta asimetría.

**Reversión de la transformación**

Para volver a la escala original:

.. math::


   y_t = (y_t')^2

**Transformación Box-Cox:**

La transformación Box–Cox (Box & Cox, 1964) es una familia de
transformaciones paramétricas que incluye a la logarítmica y la raíz
cuadrada como casos particulares.

.. math::


   y_t' =
   \begin{cases}
   \dfrac{y_t^{\lambda} - 1}{\lambda}, & \text{si } \lambda \neq 0, \\[8pt]
   \log(y_t), & \text{si } \lambda = 0
   \end{cases}

Donde:

-  :math:`y_t > 0` **(la serie debe ser estrictamente positiva).**

-  :math:`\lambda` es el parámetro de transformación que controla el
   grado de compresión o expansión de la escala.

**Interpretación de** :math:`\lambda`

-  :math:`\lambda = 1`: no se aplica transformación (identidad).

-  :math:`\lambda = 0.5`: equivale a una transformación de raíz
   cuadrada.

-  :math:`\lambda = 0`: equivale a una transformación logarítmica.

El valor óptimo de :math:`\lambda` se estima maximizando la
verosimilitud, de manera que la serie transformada sea lo más cercana
posible a una distribución normal con varianza constante.

**Reversión de la transformación**

Para volver a la escala original:

.. math::


   y_t =
   \begin{cases}
   (\lambda y_t' + 1)^{1/\lambda}, & \text{si } \lambda \neq 0, \\[8pt]
   e^{y_t'}, & \text{si } \lambda = 0
   \end{cases}

**Ventajas**

-  Permite ajustar la transformación a la forma de la serie.

-  Puede mejorar la normalidad y estabilizar la varianza
   simultáneamente.

-  Es más flexible que aplicar logaritmos o raíces fijas.

**Desventajas**

-  Solo se puede aplicar a valores positivos.

-  Requiere estimar el parámetro :math:`\lambda`.

**Combinación de Transformaciones:**

A menudo es necesario **combinar transformaciones** para lograr
estacionariedad completa:

1. **Transformar** para estabilizar la varianza (log, raíz, Box-Cox)

2. **Diferenciar** para eliminar tendencia

3. Opcional: **Diferenciación estacional** para remover estacionalidades
   fuertes

.. figure:: Combinación_transf.png
   :alt: Combinación_transf

   Combinación_transf

Devolver transformaciones:
~~~~~~~~~~~~~~~~~~~~~~~~~~

**1. Diferenciación (primera diferencia):**

**Transformación:**

.. math::


   y_t' = y_t - y_{t-1}

**Para revertir (recuperar la serie original):**

.. math::


   y_t = y_t' + y_{t-1}

Donde :math:`y_{t-1}` es el valor original (sin transformar) del periodo
anterior.

**2. Transformación logarítmica:**

**Transformación:**

.. math::


   y_t' = \log(y_t)

**Para revertir (recuperar la serie original):**

.. math::


   y_t = \exp(y_t')

-  Cuando se combinan transformaciones (ejemplo: primero log, luego
   diferencia), debes **revertir en el orden inverso**:

   1. Primero “deshaces” la diferencia,

   2. luego “deshaces” el logaritmo.

-  Siempre asegúrate de conservar el primer valor original (:math:`y_0`)
   para poder recuperar toda la serie.

Código en Python para transformaciones:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Desempleo:
~~~~~~~~~~

.. code:: ipython3

    import pandas as pd
    import numpy as np
    from matplotlib import pyplot as plt
    
    # Cargar el archivo xlsx:
    df = pd.read_excel('Desempleo.xlsx')
    
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
    plt.title("Serie de tiempo: Desempleo")
    plt.xlabel("Fecha")
    plt.ylabel("Valor")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_14_0.png


.. code:: ipython3

    # Transformación: diferenciación:
    df_diff = df.diff().dropna()
    
    plt.figure(figsize=(18, 5))
    plt.plot(df_diff, color='darkgreen')
    plt.title("Serie de tiempo: Desempleo (Diferenciada)")
    plt.xlabel("Fecha")
    plt.ylabel("Valor Diferenciado")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_15_0.png


.. code:: ipython3

    from statsmodels.tsa.stattools import adfuller
    
    adf_result = adfuller(df_diff, regression='n') # 'n' para no incluir constante ni tendencia
    print(f'Estadístico ADF: {adf_result[0]}')
    print(f'Valor p: {adf_result[1]}')
    
    # Interpretación del resultado
    alpha = 0.05
    if adf_result[1] < alpha:
        print("Rechazamos la hipótesis nula: La serie es estacionaria.")
    else:
        print("No podemos rechazar la hipótesis nula: La serie no es estacionaria.")


.. parsed-literal::

    Estadístico ADF: -4.717438227528676
    Valor p: 3.703029024477552e-06
    Rechazamos la hipótesis nula: La serie es estacionaria.
    

TRM:
~~~~

.. code:: ipython3

    import yfinance as yf
    import matplotlib.dates as mdates
    
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
    


.. image:: output_18_1.png


.. code:: ipython3

    # Transformación: diferenciación
    
    df_diff = trm.diff().dropna()
    plt.figure(figsize=(10, 5))
    plt.plot(df_diff.index, df_diff, linestyle='-', color='darkgreen')
    plt.title("Diferenciación de la TRM (USD/COP)", fontsize=14)
    plt.xlabel("Fecha")
    plt.ylabel("Diferencia de TRM")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()
    
    adf_result = adfuller(df_diff, regression='n') # 'n' para no incluir constante ni tendencia
    print(f'Estadístico ADF: {adf_result[0]}')
    print(f'Valor p: {adf_result[1]}')
    
    # Interpretación del resultado
    alpha = 0.05
    if adf_result[1] < alpha:
        print("Rechazamos la hipótesis nula: La serie es estacionaria.")
    else:
        print("No podemos rechazar la hipótesis nula: La serie no es estacionaria.")



.. image:: output_19_0.png


.. parsed-literal::

    Estadístico ADF: -4.925362403744495
    Valor p: 1.477761458696925e-06
    Rechazamos la hipótesis nula: La serie es estacionaria.
    

.. code:: ipython3

    # Transformación: Logaritmo
    
    df_log = np.log(trm)
    plt.figure(figsize=(18, 5))
    plt.plot(df_log, color='darkgreen')
    plt.title("Serie de tiempo: TRM (USD/COP) (Logaritmo)")
    plt.xlabel("Fecha")
    plt.ylabel("Log(Valor)")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_20_0.png


.. code:: ipython3

    # Transformación: diferenciación del logaritmo
    
    df_log_diff = df_log.diff().dropna()
    plt.figure(figsize=(18, 5))
    plt.plot(df_log_diff, color='darkgreen')
    plt.title("Serie de tiempo: TRM (USD/COP) (Diferenciación del Logaritmo)")
    plt.xlabel("Fecha")
    plt.ylabel("Diferencia del Log(Valor)")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()
    
    adf_result = adfuller(df_log_diff, regression='n') # 'n' para no incluir constante ni tendencia
    print(f'Estadístico ADF: {adf_result[0]}')
    print(f'Valor p: {adf_result[1]}')
    # Interpretación del resultado
    alpha = 0.05
    if adf_result[1] < alpha:
        print("Rechazamos la hipótesis nula: La serie es estacionaria.")
    else:
        print("No podemos rechazar la hipótesis nula: La serie no es estacionaria.")



.. image:: output_21_0.png


.. parsed-literal::

    Estadístico ADF: -4.993827752170621
    Valor p: 1.086857971826269e-06
    Rechazamos la hipótesis nula: La serie es estacionaria.
    
