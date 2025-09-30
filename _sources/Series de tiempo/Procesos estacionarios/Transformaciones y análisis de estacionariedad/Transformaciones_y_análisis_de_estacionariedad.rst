Transformaciones y análisis de estacionariedad
----------------------------------------------

.. code:: ipython3

    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    import matplotlib.dates as mdates
    from statsmodels.tsa.stattools import adfuller
    from statsmodels.graphics.tsaplots import plot_acf, plot_pacf

Precio interno del Café:
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Cargar el archivo xlsx:
    serie_cafe = pd.read_excel('Precio_interno_cafe.xlsx')
    
    # Corregir nombres de columnas si tienen espacios
    serie_cafe.columns = serie_cafe.columns.str.strip()
    
    # Convertir 'Fecha' a datetime y usar como índice
    serie_cafe['Fecha'] = pd.to_datetime(serie_cafe['Fecha'])
    serie_cafe.set_index('Fecha', inplace=True)
    
    # Ordenar por fecha por si acaso
    serie_cafe = serie_cafe.sort_index()
    
    # Establecer frecuencia explícita para evitar el warning de statsmodels
    serie_cafe.index.freq = serie_cafe.index.inferred_freq
    
    plt.figure(figsize=(18, 5))
    plt.plot(serie_cafe, color='navy')
    plt.title("Serie de tiempo: Precio del Café")
    plt.xlabel("Fecha")
    plt.ylabel("$")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()
    
    serie_cafe.head()



.. image:: output_3_0.png




.. raw:: html

    
      <div id="df-117524a5-0c81-477e-b543-bc95ca4f35b5" class="colab-df-container">
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
        <button class="colab-df-convert" onclick="convertToInteractive('df-117524a5-0c81-477e-b543-bc95ca4f35b5')"
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
            document.querySelector('#df-117524a5-0c81-477e-b543-bc95ca4f35b5 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-117524a5-0c81-477e-b543-bc95ca4f35b5');
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
    
    
        <div id="df-77ff0b36-b601-4f1c-8ce1-64daa8fc41c3">
          <button class="colab-df-quickchart" onclick="quickchart('df-77ff0b36-b601-4f1c-8ce1-64daa8fc41c3')"
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
                document.querySelector('#df-77ff0b36-b601-4f1c-8ce1-64daa8fc41c3 button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
        </div>
      </div>
    



.. code:: ipython3

    serie = "Precio interno del Café"
    
    # Serie original y transformaciones:
    serie_1 = serie_cafe.copy()
    serie_2 = serie_1.diff().dropna()
    serie_3 = np.log(serie_1)
    serie_4 = serie_3.diff().dropna()
    
    titulos = [f"Serie original: {serie}",
               "Diferenciación",
               "Logaritmo",
               "Diferenciación del Logaritmo"]
    
    series = [serie_1, serie_2, serie_3, serie_4]
    
    # ADF test y etiquetas de estacionariedad
    resultados_adf = []
    interpretaciones = []
    
    for i, serie in enumerate(series):
        serie_ = serie.dropna()
        # Seleccionar el tipo de regresión adecuado:
        if i in [0, 2]:  # serie_1 y serie_3
            adf = adfuller(serie_, regression='ct')  # constante y tendencia
        else:            # serie_2 y serie_4
            adf = adfuller(serie_, regression='c')   # solo constante
        estadistico = adf[0]
        pvalue = adf[1]
        resultados_adf.append((estadistico, pvalue))
        if pvalue < 0.05:
            interpretaciones.append("Estacionaria")
        else:
            interpretaciones.append("No estacionaria")
    
    # Gráfico 4 filas × 3 columnas
    fig, axes = plt.subplots(4, 3, figsize=(18, 16))
    
    for fila in range(4):
        # Serie
        color = 'navy' if fila == 0 else 'forestgreen' if fila == 1 else 'darkgreen'
        axes[fila, 0].plot(series[fila], color=color)
        axes[fila, 0].set_title(titulos[fila])
        axes[fila, 0].set_xlabel("Fecha")
        if fila == 0:
            axes[fila, 0].set_ylabel("Valor")
        elif fila == 1:
            axes[fila, 0].set_ylabel("Δ Valor")
        elif fila == 2:
            axes[fila, 0].set_ylabel("Log(Valor)")
        else:
            axes[fila, 0].set_ylabel("Δ Log(Valor)")
        axes[fila, 0].grid(True, alpha=0.3)
    
        # ACF
        plot_acf(series[fila].dropna(), lags=24, ax=axes[fila, 1], zero=False, color='navy')
        axes[fila, 1].set_title("ACF")
    
        # PACF
        plot_pacf(series[fila].dropna(), lags=24, ax=axes[fila, 2], zero=False, color='navy')
        axes[fila, 2].set_title("PACF")
    
        # Indicador estacionariedad
        axes[fila, 0].text(
            0.02, 0.90,
            f"ADF: {resultados_adf[fila][0]:.2f}\np-valor: {resultados_adf[fila][1]:.4f}\n{interpretaciones[fila]}",
            transform=axes[fila, 0].transAxes,
            fontsize=11, bbox=dict(facecolor='white', alpha=0.85)
        )
    
    plt.tight_layout()
    plt.show()
    



.. image:: output_4_0.png


Temperatura de Medellín:
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Cargar el archivo xlsx:
    serie_temperatura = pd.read_excel('Temperatura Medellín.xlsx')
    
    # Corregir nombres de columnas si tienen espacios
    serie_temperatura.columns = serie_temperatura.columns.str.strip()
    
    # Convertir 'Fecha' a datetime y usar como índice
    serie_temperatura['Fecha'] = pd.to_datetime(serie_temperatura['Fecha'])
    serie_temperatura.set_index('Fecha', inplace=True)
    
    # Ordenar por fecha por si acaso
    serie_temperatura = serie_temperatura.sort_index()
    
    # Establecer frecuencia explícita para evitar el warning de statsmodels
    serie_temperatura.index.freq = serie_temperatura.index.inferred_freq
    
    plt.figure(figsize=(18, 5))
    plt.plot(serie_temperatura, color='navy')
    plt.title("Serie de tiempo: Temperatura de Medellín")
    plt.xlabel("Fecha")
    plt.ylabel("$")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()
    
    serie_temperatura.head()



.. image:: output_6_0.png




.. raw:: html

    
      <div id="df-88e8791b-0a88-486c-9241-c8a5e4823527" class="colab-df-container">
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
          <th>Temperatura</th>
        </tr>
        <tr>
          <th>Fecha</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>1981-01-01</th>
          <td>22.25</td>
        </tr>
        <tr>
          <th>1981-02-01</th>
          <td>22.15</td>
        </tr>
        <tr>
          <th>1981-03-01</th>
          <td>22.99</td>
        </tr>
        <tr>
          <th>1981-04-01</th>
          <td>22.99</td>
        </tr>
        <tr>
          <th>1981-05-01</th>
          <td>22.36</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-88e8791b-0a88-486c-9241-c8a5e4823527')"
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
            document.querySelector('#df-88e8791b-0a88-486c-9241-c8a5e4823527 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-88e8791b-0a88-486c-9241-c8a5e4823527');
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
    
    
        <div id="df-797d16ef-3dab-4357-819a-0cbf8c16bcec">
          <button class="colab-df-quickchart" onclick="quickchart('df-797d16ef-3dab-4357-819a-0cbf8c16bcec')"
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
                document.querySelector('#df-797d16ef-3dab-4357-819a-0cbf8c16bcec button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
        </div>
      </div>
    



.. code:: ipython3

    serie = "Temperatura de Medellín"
    
    # Serie original y transformaciones:
    serie_1 = serie_temperatura.copy()
    serie_2 = serie_1.diff().dropna()
    serie_3 = np.log(serie_1)
    serie_4 = serie_3.diff().dropna()
    
    titulos = [f"Serie original: {serie}",
               "Diferenciación",
               "Logaritmo",
               "Diferenciación del Logaritmo"]
    
    series = [serie_1, serie_2, serie_3, serie_4]
    
    # ADF test y etiquetas de estacionariedad
    resultados_adf = []
    interpretaciones = []
    
    for i, serie in enumerate(series):
        serie_ = serie.dropna()
        # Seleccionar el tipo de regresión adecuado:
        if i in [0, 2]:  # serie_1 y serie_3
            adf = adfuller(serie_, regression='ct')  # constante y tendencia
        else:            # serie_2 y serie_4
            adf = adfuller(serie_, regression='c')   # solo constante
        estadistico = adf[0]
        pvalue = adf[1]
        resultados_adf.append((estadistico, pvalue))
        if pvalue < 0.05:
            interpretaciones.append("Estacionaria")
        else:
            interpretaciones.append("No estacionaria")
    
    # Gráfico 4 filas × 3 columnas
    fig, axes = plt.subplots(4, 3, figsize=(18, 16))
    
    for fila in range(4):
        # Serie
        color = 'navy' if fila == 0 else 'forestgreen' if fila == 1 else 'darkgreen'
        axes[fila, 0].plot(series[fila], color=color)
        axes[fila, 0].set_title(titulos[fila])
        axes[fila, 0].set_xlabel("Fecha")
        if fila == 0:
            axes[fila, 0].set_ylabel("Valor")
        elif fila == 1:
            axes[fila, 0].set_ylabel("Δ Valor")
        elif fila == 2:
            axes[fila, 0].set_ylabel("Log(Valor)")
        else:
            axes[fila, 0].set_ylabel("Δ Log(Valor)")
        axes[fila, 0].grid(True, alpha=0.3)
    
        # ACF
        plot_acf(series[fila].dropna(), lags=24, ax=axes[fila, 1], zero=False, color='navy')
        axes[fila, 1].set_title("ACF")
    
        # PACF
        plot_pacf(series[fila].dropna(), lags=24, ax=axes[fila, 2], zero=False, color='navy')
        axes[fila, 2].set_title("PACF")
    
        # Indicador estacionariedad
        axes[fila, 0].text(
            0.02, 0.90,
            f"ADF: {resultados_adf[fila][0]:.2f}\np-valor: {resultados_adf[fila][1]:.4f}\n{interpretaciones[fila]}",
            transform=axes[fila, 0].transAxes,
            fontsize=11, bbox=dict(facecolor='white', alpha=0.85)
        )
    
    plt.tight_layout()
    plt.show()
    



.. image:: output_7_0.png


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
    


.. image:: output_9_1.png


.. code:: ipython3

    serie = "TRM"
    
    # Serie original y transformaciones:
    serie_1 = trm.copy()
    serie_2 = serie_1.diff().dropna()
    serie_3 = np.log(serie_1)
    serie_4 = serie_3.diff().dropna()
    
    titulos = [f"Serie original: {serie}",
               "Diferenciación",
               "Logaritmo",
               "Diferenciación del Logaritmo"]
    
    series = [serie_1, serie_2, serie_3, serie_4]
    
    # ADF test y etiquetas de estacionariedad
    resultados_adf = []
    interpretaciones = []
    
    for i, serie in enumerate(series):
        serie_ = serie.dropna()
        # Seleccionar el tipo de regresión adecuado:
        if i in [0, 2]:  # serie_1 y serie_3
            adf = adfuller(serie_, regression='ct')  # constante y tendencia
        else:            # serie_2 y serie_4
            adf = adfuller(serie_, regression='c')   # solo constante
        estadistico = adf[0]
        pvalue = adf[1]
        resultados_adf.append((estadistico, pvalue))
        if pvalue < 0.05:
            interpretaciones.append("Estacionaria")
        else:
            interpretaciones.append("No estacionaria")
    
    # Gráfico 4 filas × 3 columnas
    fig, axes = plt.subplots(4, 3, figsize=(18, 16))
    
    for fila in range(4):
        # Serie
        color = 'navy' if fila == 0 else 'forestgreen' if fila == 1 else 'darkgreen'
        axes[fila, 0].plot(series[fila], color=color)
        axes[fila, 0].set_title(titulos[fila])
        axes[fila, 0].set_xlabel("Fecha")
        if fila == 0:
            axes[fila, 0].set_ylabel("Valor")
        elif fila == 1:
            axes[fila, 0].set_ylabel("Δ Valor")
        elif fila == 2:
            axes[fila, 0].set_ylabel("Log(Valor)")
        else:
            axes[fila, 0].set_ylabel("Δ Log(Valor)")
        axes[fila, 0].grid(True, alpha=0.3)
    
        # ACF
        plot_acf(series[fila].dropna(), lags=24, ax=axes[fila, 1], zero=False, color='navy')
        axes[fila, 1].set_title("ACF")
    
        # PACF
        plot_pacf(series[fila].dropna(), lags=24, ax=axes[fila, 2], zero=False, color='navy')
        axes[fila, 2].set_title("PACF")
    
        # Indicador estacionariedad
        axes[fila, 0].text(
            0.02, 0.90,
            f"ADF: {resultados_adf[fila][0]:.2f}\np-valor: {resultados_adf[fila][1]:.4f}\n{interpretaciones[fila]}",
            transform=axes[fila, 0].transAxes,
            fontsize=11, bbox=dict(facecolor='white', alpha=0.85)
        )
    
    plt.tight_layout()
    plt.show()



.. image:: output_10_0.png


Precio de electricidad:
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Cargar el archivo
    precio_electricidad = pd.read_csv("Precio_electricidad.csv")
    
    # Corregir nombres de columnas si tienen espacios
    precio_electricidad.columns = precio_electricidad.columns.str.strip()
    
    # Convertir 'Fecha' a datetime y usar como índice
    precio_electricidad['Fecha'] = pd.to_datetime(precio_electricidad['Fecha'])
    precio_electricidad.set_index('Fecha', inplace=True)
    
    # Ordenar por fecha por si acaso
    precio_electricidad = precio_electricidad.sort_index()
    
    plt.figure(figsize=(12, 5))
    plt.plot(precio_electricidad.index, precio_electricidad['Precio'], color='navy')
    plt.title("Serie de tiempo: Precio de electricidad")
    plt.xlabel("Fecha")
    plt.ylabel("Precio")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_12_0.png


.. code:: ipython3

    serie = "Precio de electricidad"
    
    # Serie original y transformaciones:
    serie_1 = precio_electricidad.copy()
    serie_2 = serie_1.diff().dropna()
    serie_3 = np.log(serie_1)
    serie_4 = serie_3.diff().dropna()
    
    titulos = [f"Serie original: {serie}",
               "Diferenciación",
               "Logaritmo",
               "Diferenciación del Logaritmo"]
    
    series = [serie_1, serie_2, serie_3, serie_4]
    
    # ADF test y etiquetas de estacionariedad
    resultados_adf = []
    interpretaciones = []
    
    for i, serie in enumerate(series):
        serie_ = serie.dropna()
        # Seleccionar el tipo de regresión adecuado:
        if i in [0, 2]:  # serie_1 y serie_3
            adf = adfuller(serie_, regression='ct')  # constante y tendencia
        else:            # serie_2 y serie_4
            adf = adfuller(serie_, regression='c')   # solo constante
        estadistico = adf[0]
        pvalue = adf[1]
        resultados_adf.append((estadistico, pvalue))
        if pvalue < 0.05:
            interpretaciones.append("Estacionaria")
        else:
            interpretaciones.append("No estacionaria")
    
    # Gráfico 4 filas × 3 columnas
    fig, axes = plt.subplots(4, 3, figsize=(18, 16))
    
    for fila in range(4):
        # Serie
        color = 'navy' if fila == 0 else 'forestgreen' if fila == 1 else 'darkgreen'
        axes[fila, 0].plot(series[fila], color=color)
        axes[fila, 0].set_title(titulos[fila])
        axes[fila, 0].set_xlabel("Fecha")
        if fila == 0:
            axes[fila, 0].set_ylabel("Valor")
        elif fila == 1:
            axes[fila, 0].set_ylabel("Δ Valor")
        elif fila == 2:
            axes[fila, 0].set_ylabel("Log(Valor)")
        else:
            axes[fila, 0].set_ylabel("Δ Log(Valor)")
        axes[fila, 0].grid(True, alpha=0.3)
    
        # ACF
        plot_acf(series[fila].dropna(), lags=24, ax=axes[fila, 1], zero=False, color='navy')
        axes[fila, 1].set_title("ACF")
    
        # PACF
        plot_pacf(series[fila].dropna(), lags=24, ax=axes[fila, 2], zero=False, color='navy')
        axes[fila, 2].set_title("PACF")
    
        # Indicador estacionariedad
        axes[fila, 0].text(
            0.02, 0.90,
            f"ADF: {resultados_adf[fila][0]:.2f}\np-valor: {resultados_adf[fila][1]:.4f}\n{interpretaciones[fila]}",
            transform=axes[fila, 0].transAxes,
            fontsize=11, bbox=dict(facecolor='white', alpha=0.85)
        )
    
    plt.tight_layout()
    plt.show()



.. image:: output_13_0.png

