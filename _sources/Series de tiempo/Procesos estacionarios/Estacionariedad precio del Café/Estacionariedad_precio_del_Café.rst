Estacionariedad precio del Café
-------------------------------

Precio interno base de compra del café colombiano - Promedio Mensual

Pesos por carga de 125 kg. de café pergamino seco

.. code:: ipython3

    import pandas as pd
    import numpy as np
    from matplotlib import pyplot as plt

.. code:: ipython3

    # Cargar el archivo xlsx:
    df = pd.read_excel('Precio_interno_cafe.xlsx')
    
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
    plt.title("Serie de tiempo: Precio del Café")
    plt.xlabel("Fecha")
    plt.ylabel("$")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()
    
    df.head()



.. image:: output_3_0.png




.. raw:: html

    
      <div id="df-a639f37c-062a-4f0e-a978-886e1b95b419" class="colab-df-container">
        <div>
    <style scoped>
        .dataframe tbody tr th:only-of-type {
            vertical-align: middle;
        }
    
        .dataframe tbody tr th {
            vertical-align: top;
        }
    
        .dataframe thead th {
            text-align: right;
        }
    </style>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>Precio</th>
        </tr>
        <tr>
          <th>Fecha</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>2000-01-01</th>
          <td>371375.0</td>
        </tr>
        <tr>
          <th>2000-02-01</th>
          <td>354297.0</td>
        </tr>
        <tr>
          <th>2000-03-01</th>
          <td>360016.0</td>
        </tr>
        <tr>
          <th>2000-04-01</th>
          <td>347538.0</td>
        </tr>
        <tr>
          <th>2000-05-01</th>
          <td>353750.0</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-a639f37c-062a-4f0e-a978-886e1b95b419')"
                title="Convert this dataframe to an interactive table."
                style="display:none;">
    
      <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960">
        <path d="M120-120v-720h720v720H120Zm60-500h600v-160H180v160Zm220 220h160v-160H400v160Zm0 220h160v-160H400v160ZM180-400h160v-160H180v160Zm440 0h160v-160H620v160ZM180-180h160v-160H180v160Zm440 0h160v-160H620v160Z"/>
      </svg>
        </button>
    
      <style>
        .colab-df-container {
          display:flex;
          gap: 12px;
        }
    
        .colab-df-convert {
          background-color: #E8F0FE;
          border: none;
          border-radius: 50%;
          cursor: pointer;
          display: none;
          fill: #1967D2;
          height: 32px;
          padding: 0 0 0 0;
          width: 32px;
        }
    
        .colab-df-convert:hover {
          background-color: #E2EBFA;
          box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
          fill: #174EA6;
        }
    
        .colab-df-buttons div {
          margin-bottom: 4px;
        }
    
        [theme=dark] .colab-df-convert {
          background-color: #3B4455;
          fill: #D2E3FC;
        }
    
        [theme=dark] .colab-df-convert:hover {
          background-color: #434B5C;
          box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
          filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
          fill: #FFFFFF;
        }
      </style>
    
        <script>
          const buttonEl =
            document.querySelector('#df-a639f37c-062a-4f0e-a978-886e1b95b419 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-a639f37c-062a-4f0e-a978-886e1b95b419');
            const dataTable =
              await google.colab.kernel.invokeFunction('convertToInteractive',
                                                        [key], {});
            if (!dataTable) return;
    
            const docLinkHtml = 'Like what you see? Visit the ' +
              '<a target="_blank" href=https://colab.research.google.com/notebooks/data_table.ipynb>data table notebook</a>'
              + ' to learn more about interactive tables.';
            element.innerHTML = '';
            dataTable['output_type'] = 'display_data';
            await google.colab.output.renderOutput(dataTable, element);
            const docLink = document.createElement('div');
            docLink.innerHTML = docLinkHtml;
            element.appendChild(docLink);
          }
        </script>
      </div>
    
    
        <div id="df-667523dc-b5c9-4442-beb6-b4ef9a95705b">
          <button class="colab-df-quickchart" onclick="quickchart('df-667523dc-b5c9-4442-beb6-b4ef9a95705b')"
                    title="Suggest charts"
                    style="display:none;">
    
    <svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
         width="24px">
        <g>
            <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
        </g>
    </svg>
          </button>
    
    <style>
      .colab-df-quickchart {
          --bg-color: #E8F0FE;
          --fill-color: #1967D2;
          --hover-bg-color: #E2EBFA;
          --hover-fill-color: #174EA6;
          --disabled-fill-color: #AAA;
          --disabled-bg-color: #DDD;
      }
    
      [theme=dark] .colab-df-quickchart {
          --bg-color: #3B4455;
          --fill-color: #D2E3FC;
          --hover-bg-color: #434B5C;
          --hover-fill-color: #FFFFFF;
          --disabled-bg-color: #3B4455;
          --disabled-fill-color: #666;
      }
    
      .colab-df-quickchart {
        background-color: var(--bg-color);
        border: none;
        border-radius: 50%;
        cursor: pointer;
        display: none;
        fill: var(--fill-color);
        height: 32px;
        padding: 0;
        width: 32px;
      }
    
      .colab-df-quickchart:hover {
        background-color: var(--hover-bg-color);
        box-shadow: 0 1px 2px rgba(60, 64, 67, 0.3), 0 1px 3px 1px rgba(60, 64, 67, 0.15);
        fill: var(--button-hover-fill-color);
      }
    
      .colab-df-quickchart-complete:disabled,
      .colab-df-quickchart-complete:disabled:hover {
        background-color: var(--disabled-bg-color);
        fill: var(--disabled-fill-color);
        box-shadow: none;
      }
    
      .colab-df-spinner {
        border: 2px solid var(--fill-color);
        border-color: transparent;
        border-bottom-color: var(--fill-color);
        animation:
          spin 1s steps(1) infinite;
      }
    
      @keyframes spin {
        0% {
          border-color: transparent;
          border-bottom-color: var(--fill-color);
          border-left-color: var(--fill-color);
        }
        20% {
          border-color: transparent;
          border-left-color: var(--fill-color);
          border-top-color: var(--fill-color);
        }
        30% {
          border-color: transparent;
          border-left-color: var(--fill-color);
          border-top-color: var(--fill-color);
          border-right-color: var(--fill-color);
        }
        40% {
          border-color: transparent;
          border-right-color: var(--fill-color);
          border-top-color: var(--fill-color);
        }
        60% {
          border-color: transparent;
          border-right-color: var(--fill-color);
        }
        80% {
          border-color: transparent;
          border-right-color: var(--fill-color);
          border-bottom-color: var(--fill-color);
        }
        90% {
          border-color: transparent;
          border-bottom-color: var(--fill-color);
        }
      }
    </style>
    
          <script>
            async function quickchart(key) {
              const quickchartButtonEl =
                document.querySelector('#' + key + ' button');
              quickchartButtonEl.disabled = true;  // To prevent multiple clicks.
              quickchartButtonEl.classList.add('colab-df-spinner');
              try {
                const charts = await google.colab.kernel.invokeFunction(
                    'suggestCharts', [key], {});
              } catch (error) {
                console.error('Error during call to suggestCharts:', error);
              }
              quickchartButtonEl.classList.remove('colab-df-spinner');
              quickchartButtonEl.classList.add('colab-df-quickchart-complete');
            }
            (() => {
              let quickchartButtonEl =
                document.querySelector('#df-667523dc-b5c9-4442-beb6-b4ef9a95705b button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
        </div>
      </div>
    



Descomposición:
~~~~~~~~~~~~~~~

.. code:: ipython3

    serie = df.copy()
    
    from statsmodels.tsa.seasonal import seasonal_decompose
    
    # Descomposición aditiva (periodo de 12 meses)
    result_add = seasonal_decompose(serie, model="additive", period=12)
    
    # Graficar
    plt.figure(figsize=(10, 8))
    plt.subplot(4, 1, 1)
    plt.plot(result_add.observed, color="darkblue")
    plt.title("Descomposición aditiva")
    
    plt.subplot(4, 1, 2)
    plt.plot(result_add.trend, color="black")
    plt.ylabel("Tendencia")
    
    plt.subplot(4, 1, 3)
    plt.plot(result_add.seasonal, color="black")
    plt.ylabel("Estacionalidad")
    
    plt.subplot(4, 1, 4)
    plt.plot(result_add.resid, color="black")
    plt.ylabel("Residuo")
    plt.xlabel("Fecha")
    
    plt.tight_layout()
    plt.show()
    
    # Descomposición multiplicativa (periodo de 12 meses)
    result_add = seasonal_decompose(serie, model="multiplicative", period=12)
    
    # Graficar
    plt.figure(figsize=(10, 8))
    plt.subplot(4, 1, 1)
    plt.plot(result_add.observed, color="darkblue")
    plt.title("Descomposición multiplicativa")
    
    plt.subplot(4, 1, 2)
    plt.plot(result_add.trend, color="black")
    plt.ylabel("Tendencia")
    
    plt.subplot(4, 1, 3)
    plt.plot(result_add.seasonal, color="black")
    plt.ylabel("Estacionalidad")
    
    plt.subplot(4, 1, 4)
    plt.plot(result_add.resid, color="black")
    plt.ylabel("Residuo")
    plt.xlabel("Fecha")
    
    plt.tight_layout()
    plt.show()



.. image:: output_5_0.png



.. image:: output_5_1.png


.. code:: ipython3

    plt.figure(figsize=(8, 5))
    plt.hist(serie, bins=20, color='skyblue', edgecolor='black')
    plt.title("Distribución de la serie", fontsize=14)
    plt.xlabel("Precio de Café$]")
    plt.ylabel("Frecuencia")
    plt.grid(axis='y', alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_6_0.png


**Cosechas en Colombia:**

En Colombia, la cosecha de café generalmente ocurre dos veces al año,
con una cosecha principal entre abril y junio y una segunda cosecha o
cosecha de mitaca (o traviesa) entre septiembre y diciembre.

.. code:: ipython3

    # 1. Calcular la tendencia con media móvil centrada de 12 meses
    tendencia = serie.rolling(window=12, center=True).mean()
    
    # 2. Calcular la serie sin tendencia
    detrended = serie - tendencia
    
    # 3. Calcular el promedio mensual de la serie sin tendencia
    # Agrupar por mes calendario (1=enero, ..., 12=diciembre)
    promedio_mensual = detrended.groupby(detrended.index.month).mean()
    
    # 4. Centrar los valores mensuales (que sumen cero)
    estacionalidad = promedio_mensual - promedio_mensual.mean()
    estacionalidad.index.name = "Mes"
    estacionalidad.name = "Índice estacional aditivo"
    
    plt.figure(figsize=(4, 4))
    plt.plot(estacionalidad.index, estacionalidad.values, marker='o', linestyle='-', color='black')
    plt.axhline(0, color='gray', linestyle='--')
    plt.title("Estacionalidad aditiva mensual estimada")
    plt.xlabel("Mes (1 = Enero, ..., 12 = Diciembre)")
    plt.ylabel("Índice estacional aditivo")
    plt.xticks(ticks=range(1, 13))
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_8_0.png


.. code:: ipython3

    # 1. Calcular la tendencia con media móvil centrada de 12 meses
    tendencia = serie.rolling(window=12, center=True).mean()
    
    # 2. Calcular la serie sin tendencia (ahora con división)
    detrended = serie / tendencia
    
    # 3. Calcular el promedio mensual de la serie sin tendencia (multiplicativa)
    promedio_mensual = detrended.groupby(detrended.index.month).mean()
    
    # 4. Centrar los valores mensuales para que el promedio sea 1 (multiplicativo)
    estacionalidad_mult = promedio_mensual / promedio_mensual.mean()
    estacionalidad_mult.index.name = "Mes"
    estacionalidad_mult.name = "Índice estacional multiplicativo"
    
    # 5. Graficar
    plt.figure(figsize=(4, 4))
    plt.plot(estacionalidad_mult.index, estacionalidad_mult.values, marker='o', linestyle='-', color='darkblue')
    plt.axhline(1, color='gray', linestyle='--')
    plt.title("Estacionalidad multiplicativa mensual estimada")
    plt.xlabel("Mes (1 = Enero, ..., 12 = Diciembre)")
    plt.ylabel("Índice estacional multiplicativo")
    plt.xticks(ticks=range(1, 13))
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()
    



.. image:: output_9_0.png


Prueba de estacionariedad:
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    from statsmodels.tsa.stattools import adfuller

.. code:: ipython3

    adf_result = adfuller(serie, regression='ctt')
    print(f'Estadístico ADF: {adf_result[0]}')
    print(f'Valor p: {adf_result[1]}')
    
    # Interpretación del resultado
    alpha = 0.05
    if adf_result[1] < alpha:
        print("Rechazamos la hipótesis nula: La serie es estacionaria.")
    else:
        print("No podemos rechazar la hipótesis nula: La serie no es estacionaria.")


.. parsed-literal::

    Estadístico ADF: -2.781278277472542
    Valor p: 0.408614276283159
    No podemos rechazar la hipótesis nula: La serie no es estacionaria.
    

Transformaciones:
~~~~~~~~~~~~~~~~~

**Primera diferencia:**

.. code:: ipython3

    # Transformación: diferenciación:
    df_diff = serie.diff().dropna()
    
    plt.figure(figsize=(18, 5))
    plt.plot(df_diff, color='darkgreen')
    plt.title("Serie de tiempo: Precio del Café (primera diferencia)")
    plt.xlabel("Fecha")
    plt.ylabel("Valor Diferenciado")
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



.. image:: output_15_0.png


.. parsed-literal::

    Estadístico ADF: -5.573149232135553
    Valor p: 7.412548013102314e-08
    Rechazamos la hipótesis nula: La serie es estacionaria.
    

**Transformación logarítmica:**

.. code:: ipython3

    # Transformación: Logaritmo
    
    df_log = np.log(serie)
    plt.figure(figsize=(18, 5))
    plt.plot(df_log, color='darkgreen')
    plt.title("Serie de tiempo: Precio del Café (Logaritmo)")
    plt.xlabel("Fecha")
    plt.ylabel("Log(Valor)")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_17_0.png


.. code:: ipython3

    adf_result = adfuller(df_log, regression='ct') # 'ct' Cuando la serie muestra una tendencia lineal creciente o decreciente
    print(f'Estadístico ADF: {adf_result[0]}')
    print(f'Valor p: {adf_result[1]}')
    
    # Interpretación del resultado
    alpha = 0.05
    if adf_result[1] < alpha:
        print("Rechazamos la hipótesis nula: La serie es estacionaria.")
    else:
        print("No podemos rechazar la hipótesis nula: La serie no es estacionaria.")


.. parsed-literal::

    Estadístico ADF: -3.2308799188259503
    Valor p: 0.07842224060300443
    No podemos rechazar la hipótesis nula: La serie no es estacionaria.
    

**Transformación: diferenciación del logaritmo:**

.. code:: ipython3

    # Transformación: diferenciación del logaritmo
    
    df_log_diff = df_log.diff().dropna()
    plt.figure(figsize=(18, 5))
    plt.plot(df_log_diff, color='darkgreen')
    plt.title("Serie de tiempo: Precio del Café (Diferenciación del Logaritmo)")
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



.. image:: output_20_0.png


.. parsed-literal::

    Estadístico ADF: -4.476002005356018
    Valor p: 1.0454734547411791e-05
    Rechazamos la hipótesis nula: La serie es estacionaria.
    

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

.. code:: ipython3

    # Recupera la serie original (excepto el primer valor)
    inverse_diff = df_diff.cumsum() + serie.iloc[0]
    plt.figure(figsize=(18, 5))
    plt.plot(inverse_diff, color='darkgreen')
    plt.title("Serie de tiempo: serie original")
    plt.xlabel("Fecha")
    plt.ylabel("$")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()
    



.. image:: output_23_0.png


.. code:: ipython3

    inverse_log = np.exp(df_log)
    plt.figure(figsize=(18, 5))
    plt.plot(inverse_log, color='darkgreen')
    plt.title("Serie de tiempo: serie original")
    plt.xlabel("Fecha")
    plt.ylabel("$")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()
    



.. image:: output_24_0.png


.. code:: ipython3

    # Recuperar la serie logarítmica original
    inverse_log = df_log_diff.cumsum() + df_log.iloc[0]
    # Recuperar la serie original (deshacer el log)
    inverse_log_diff = np.exp(inverse_log)
    
    plt.figure(figsize=(18, 5))
    plt.plot(inverse_log_diff, color='darkgreen')
    plt.title("Serie de tiempo: serie original")
    plt.xlabel("Fecha")
    plt.ylabel("$")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_25_0.png

