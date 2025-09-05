Ejemplo métodos suavizado desempleo
-----------------------------------

.. code:: ipython3

    import pandas as pd
    from matplotlib import pyplot as plt

.. code:: ipython3

    # Cargar el archivo xlsx:
    df = pd.read_excel('Desempleo.xlsx')
    
    # Corregir nombres de columnas si tienen espacios
    df.columns = df.columns.str.strip()
    
    df.head()




.. raw:: html

    
      <div id="df-1ed36135-ee6f-4334-b8ae-8571f4eb9de1" class="colab-df-container">
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
          <th>Fecha</th>
          <th>Desempleo</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>2001-01-01</td>
          <td>16.622326</td>
        </tr>
        <tr>
          <th>1</th>
          <td>2001-02-01</td>
          <td>17.434206</td>
        </tr>
        <tr>
          <th>2</th>
          <td>2001-03-01</td>
          <td>15.811933</td>
        </tr>
        <tr>
          <th>3</th>
          <td>2001-04-01</td>
          <td>14.515078</td>
        </tr>
        <tr>
          <th>4</th>
          <td>2001-05-01</td>
          <td>14.035833</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-1ed36135-ee6f-4334-b8ae-8571f4eb9de1')"
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
            document.querySelector('#df-1ed36135-ee6f-4334-b8ae-8571f4eb9de1 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-1ed36135-ee6f-4334-b8ae-8571f4eb9de1');
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
    
    
        <div id="df-6b459491-37bc-41f5-8ad3-cb9cf57d6f02">
          <button class="colab-df-quickchart" onclick="quickchart('df-6b459491-37bc-41f5-8ad3-cb9cf57d6f02')"
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
                document.querySelector('#df-6b459491-37bc-41f5-8ad3-cb9cf57d6f02 button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
        </div>
      </div>
    



.. code:: ipython3

    # Convertir 'Fecha' a datetime y usar como índice
    df['Fecha'] = pd.to_datetime(df['Fecha'])
    df.set_index('Fecha', inplace=True)
    
    # Ordenar por fecha por si acaso
    df = df.sort_index()
    
    # Establecer frecuencia explícita para evitar el warning de statsmodels
    df.index.freq = df.index.inferred_freq
    
    plt.figure(figsize=(12, 5))
    plt.plot(df, color='navy')
    plt.title("Serie de tiempo: Desempleo")
    plt.xlabel("Fecha")
    plt.ylabel("Valor")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()
    
    print("Estadísticas descriptivas:")
    print(df.describe())
    
    plt.figure(figsize=(8, 4))
    plt.hist(df, bins=30, color='steelblue', edgecolor='black')
    plt.title("Histograma")
    plt.xlabel("Valor")
    plt.ylabel("Frecuencia")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_3_0.png


.. parsed-literal::

    Estadísticas descriptivas:
            Desempleo
    count  295.000000
    mean    11.673757
    std      2.422288
    min      7.563100
    25%      9.841250
    50%     11.226400
    75%     12.911872
    max     21.972000
    


.. image:: output_3_2.png


Descomposición:
~~~~~~~~~~~~~~~

.. code:: ipython3

    from statsmodels.tsa.seasonal import seasonal_decompose

.. code:: ipython3

    # Descomposición aditiva (periodo de 12 meses)
    descomposicion_add = seasonal_decompose(df, model="additive", period=12)

.. code:: ipython3

    # Graficar
    plt.figure(figsize=(10, 8))
    plt.subplot(4, 1, 1)
    plt.plot(descomposicion_add.observed, color="darkblue")
    plt.title("Descomposición aditiva - Desempleo")
    
    plt.subplot(4, 1, 2)
    plt.plot(descomposicion_add.trend, color="black")
    plt.ylabel("Tendencia")
    
    plt.subplot(4, 1, 3)
    plt.plot(descomposicion_add.seasonal, color="black")
    plt.ylabel("Estacionalidad")
    
    plt.subplot(4, 1, 4)
    plt.plot(descomposicion_add.resid, color="black")
    plt.ylabel("Residuo")
    plt.xlabel("Fecha")
    
    plt.tight_layout()
    plt.show()



.. image:: output_7_0.png


.. code:: ipython3

    df_2019 = df.loc[:'2019-12-31']
    
    plt.figure(figsize=(12, 5))
    plt.plot(df_2019, color='navy')
    plt.title("Serie de tiempo: Desempleo hasta 2019")
    plt.xlabel("Fecha")
    plt.ylabel("Valor")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_8_0.png


Métodos de suavizamiento:
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    from statsmodels.tsa.holtwinters import SimpleExpSmoothing, Holt, ExponentialSmoothing

.. code:: ipython3

    # Ajuste 1: Suavizado Exponencial Simple (SES)
    ses_model = SimpleExpSmoothing(df_2019).fit(optimized=True)
    ses_fit = ses_model.fittedvalues
    alpha_opt_ses = ses_model.model.params['smoothing_level']
    forecast_ses = ses_model.forecast(12)
    
    # Ajuste 2: Holt (nivel + tendencia)
    holt_model = Holt(df_2019).fit(optimized=True)
    holt_fit = holt_model.fittedvalues
    alpha_opt_holt = holt_model.model.params['smoothing_level']
    beta_opt_holt = holt_model.model.params['smoothing_trend']
    forecast_holt = holt_model.forecast(12)
    
    # Ajuste 3: Holt-Winters (nivel + tendencia + estacionalidad)
    hw_model = ExponentialSmoothing(df_2019, trend='add', seasonal='add', seasonal_periods=12).fit(optimized=True)
    hw_fit = hw_model.fittedvalues
    alpha_opt_hw = hw_model.model.params['smoothing_level']
    beta_opt_hw = hw_model.model.params['smoothing_trend']
    gamma_opt_hw = hw_model.model.params['smoothing_seasonal']
    forecast_hw = hw_model.forecast(12)
    
    # Graficar los tres ajustes sobre la serie original
    plt.figure(figsize=(14, 6))
    plt.plot(df_2019, label='Serie original', color='black', linewidth=2)
    plt.plot(ses_fit, label=f'SES (nivel) α = {alpha_opt_ses:.4f}', color='blue', linestyle='-', alpha=0.8)
    plt.plot(holt_fit, label=f'Holt (nivel + tendencia) α = {alpha_opt_holt:.4f}, β = {beta_opt_holt:.4f}',
             color='green', linestyle='-', alpha=0.8)
    plt.plot(hw_fit,
             label=f'Holt-Winters (nivel + tendencia + estacionalidad) α={alpha_opt_hw:.2f}, β={beta_opt_hw:.2f}, γ={gamma_opt_hw:.2f}',
             color='red', linestyle='-', alpha=0.8)
    plt.plot(forecast_ses, label='Pronóstico SES', color='blue', linestyle='--')
    plt.plot(forecast_holt, label='Pronóstico Holt', color='green', linestyle='--')
    plt.plot(forecast_hw, label='Pronóstico Holt-Winters', color='red', linestyle='--')
    plt.title('Comparación de métodos de suavizado: SES, Holt y Holt-Winters')
    plt.xlabel('Fecha')
    plt.ylabel('Valor')
    plt.legend()
    plt.grid(True, linestyle='--', alpha=0.5)
    plt.tight_layout()
    plt.show()



.. image:: output_11_0.png


**Cómo cambian los resultados con el método multiplicativo en
Holt-Winters**

**Cómo sería el ajuste a la serie de tiempo completa**
