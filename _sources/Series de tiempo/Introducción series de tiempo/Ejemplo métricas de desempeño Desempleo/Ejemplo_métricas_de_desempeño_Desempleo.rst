Ejemplo métricas de desempeño Desempleo
---------------------------------------

.. code:: ipython3

    import pandas as pd
    import numpy as np
    from matplotlib import pyplot as plt

.. code:: ipython3

    # Cargar el archivo xlsx:
    df = pd.read_excel('Desempleo.xlsx')
    
    # Corregir nombres de columnas si tienen espacios
    df.columns = df.columns.str.strip()
    
    df.head()




.. raw:: html

    
      <div id="df-98236c6d-598a-4923-95ec-e6aca77c6294" class="colab-df-container">
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
        <button class="colab-df-convert" onclick="convertToInteractive('df-98236c6d-598a-4923-95ec-e6aca77c6294')"
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
            document.querySelector('#df-98236c6d-598a-4923-95ec-e6aca77c6294 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-98236c6d-598a-4923-95ec-e6aca77c6294');
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
    
    
        <div id="df-e5ec620c-77b1-47bb-91fc-117e659ed9cb">
          <button class="colab-df-quickchart" onclick="quickchart('df-e5ec620c-77b1-47bb-91fc-117e659ed9cb')"
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
                document.querySelector('#df-e5ec620c-77b1-47bb-91fc-117e659ed9cb button');
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

.. code:: ipython3

    plt.figure(figsize=(12, 5))
    plt.plot(df, color='navy')
    plt.title("Serie de tiempo: Desempleo")
    plt.xlabel("Fecha")
    plt.ylabel("Valor")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_4_0.png


.. code:: ipython3

    serie = df.loc[:'2019-12-31']
    
    plt.figure(figsize=(12, 5))
    plt.plot(serie, color='navy')
    plt.title("Serie de tiempo: Desempleo hasta 2019")
    plt.xlabel("Fecha")
    plt.ylabel("Valor")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_5_0.png


Conjunto de train y test:
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Dividir en train y test (por ejemplo, 80% train, 20% test)
    split = int(len(serie) * 0.8)
    train, test = serie[:split], serie[split:]
    
    # Graficar train y test:
    
    plt.figure(figsize=(12, 5))
    plt.plot(train, label='Train', color='navy')
    plt.plot(test, label='Test', color='orange')
    plt.title("Conjunto de train y test")
    plt.xlabel("Fecha")
    plt.ylabel("Valor")
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_7_0.png


Ajuste métodos de suavizamiento:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    from statsmodels.tsa.holtwinters import SimpleExpSmoothing, Holt, ExponentialSmoothing
    from sklearn.metrics import r2_score, mean_absolute_error, mean_squared_error, max_error, explained_variance_score

.. code:: ipython3

    # Ajustar modelos de suavizamiento
    # a) Simple Exponential Smoothing
    model_ses = SimpleExpSmoothing(train).fit(optimized=True)
    y_train_pred_ses = model_ses.fittedvalues
    y_pred_test_ses = model_ses.forecast(len(test))
    
    # b) Holt (Doble suavizamiento)
    model_holt = Holt(train).fit(optimized=True)
    y_train_pred_holt = model_holt.fittedvalues
    y_pred_test_holt = model_holt.forecast(len(test))
    
    # c) Holt-Winters (Triple suavizamiento, aditivo, estacionalidad anual si mensual)
    estacionalidad = 12 if train.index.freqstr in ['M', 'MS'] else None
    model_hw = ExponentialSmoothing(train, trend='add', seasonal='add', seasonal_periods=estacionalidad).fit(optimized=True)
    y_train_pred_hw = model_hw.fittedvalues
    y_pred_test_hw = model_hw.forecast(len(test))
    
    # Graficar los ajustes y predicciones
    plt.figure(figsize=(12, 5))
    plt.plot(serie, label='Serie original', color='black')
    plt.plot(y_train_pred_ses, label='SES - Ajuste', color='dodgerblue')
    plt.plot(y_train_pred_holt, label='Holt - Ajuste', color='green')
    plt.plot(y_train_pred_holt, label='HW - Ajuste', color='orange')
    plt.plot(test.index, y_pred_test_ses, label='SES - Pronóstico', ls='--', color='blue')
    plt.plot(test.index, y_pred_test_holt, label='Holt - Pronóstico', ls='--', color='green')
    plt.plot(test.index, y_pred_test_hw, label='HW - Pronóstico', ls='--', color='orange')
    plt.legend()
    plt.title('Ajuste y Pronóstico con Métodos de Suavizamiento')
    plt.show()



.. image:: output_10_0.png


Métricas de desempeño:
~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    from sklearn.metrics import (
        r2_score, mean_absolute_error, mean_squared_error,
        max_error, mean_absolute_percentage_error, explained_variance_score
    )

.. code:: ipython3

    # Función para calcular todas las métricas
    def calcular_metricas(y_true, y_pred):
        metrics = {}
        metrics['R2'] = r2_score(y_true, y_pred)
        metrics['MAE'] = mean_absolute_error(y_true, y_pred)
        metrics['MSE'] = mean_squared_error(y_true, y_pred)
        metrics['RMSE'] = np.sqrt(metrics['MSE'])
        # Evitar división por cero en MAPE:
        metrics['MAPE'] = mean_absolute_percentage_error(y_true, y_pred) if np.max(np.abs(y_true)) > 0 else 0
        metrics['Max Error'] = max_error(y_true, y_pred)
        metrics['Explained Variance'] = explained_variance_score(y_true, y_pred)
        return metrics
    
    # Calcular métricas en train para cada modelo
    metrics_ses_train = calcular_metricas(train, y_train_pred_ses)
    metrics_holt_train = calcular_metricas(train, y_train_pred_holt)
    metrics_hw_train = calcular_metricas(train, y_train_pred_hw)
    
    # Calcular métricas en Test para cada modelo
    metrics_ses = calcular_metricas(test, y_pred_test_ses)
    metrics_holt = calcular_metricas(test, y_pred_test_holt)
    metrics_hw = calcular_metricas(test, y_pred_test_hw)
    
    # Mostrar resultados en tabla para train:
    resultados_train = pd.DataFrame({
        "SES": metrics_ses_train,
        "Holt": metrics_holt_train,
        "Holt-Winters": metrics_hw_train
    })
    print("Métricas de desempeño en el conjunto de train:")
    display(resultados_train)
    
    # Mostrar resultados en tabla para test:
    resultados = pd.DataFrame({
        "SES": metrics_ses,
        "Holt": metrics_holt,
        "Holt-Winters": metrics_hw
    })
    print("\nMétricas de desempeño en el conjunto de test:")
    display(resultados)


.. parsed-literal::

    Métricas de desempeño en el conjunto de train:
    


.. raw:: html

    
      <div id="df-8fabd9d8-9819-4784-a1d7-eaaa7d518051" class="colab-df-container">
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
          <th>SES</th>
          <th>Holt</th>
          <th>Holt-Winters</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>R2</th>
          <td>0.714503</td>
          <td>0.668827</td>
          <td>0.928334</td>
        </tr>
        <tr>
          <th>MAE</th>
          <td>0.849031</td>
          <td>0.870869</td>
          <td>0.443224</td>
        </tr>
        <tr>
          <th>MSE</th>
          <td>1.320914</td>
          <td>1.532241</td>
          <td>0.331577</td>
        </tr>
        <tr>
          <th>RMSE</th>
          <td>1.149310</td>
          <td>1.237837</td>
          <td>0.575828</td>
        </tr>
        <tr>
          <th>MAPE</th>
          <td>0.071564</td>
          <td>0.071801</td>
          <td>0.036452</td>
        </tr>
        <tr>
          <th>Max Error</th>
          <td>3.944624</td>
          <td>4.603243</td>
          <td>1.776734</td>
        </tr>
        <tr>
          <th>Explained Variance</th>
          <td>0.717751</td>
          <td>0.671016</td>
          <td>0.928334</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-8fabd9d8-9819-4784-a1d7-eaaa7d518051')"
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
            document.querySelector('#df-8fabd9d8-9819-4784-a1d7-eaaa7d518051 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-8fabd9d8-9819-4784-a1d7-eaaa7d518051');
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
    
    
        <div id="df-0e980fe9-62d0-4380-b16c-fc933592e8b0">
          <button class="colab-df-quickchart" onclick="quickchart('df-0e980fe9-62d0-4380-b16c-fc933592e8b0')"
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
                document.querySelector('#df-0e980fe9-62d0-4380-b16c-fc933592e8b0 button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
      <div id="id_64def078-16b9-42ee-85d7-f7bdda392dce">
        <style>
          .colab-df-generate {
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
    
          .colab-df-generate:hover {
            background-color: #E2EBFA;
            box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
            fill: #174EA6;
          }
    
          [theme=dark] .colab-df-generate {
            background-color: #3B4455;
            fill: #D2E3FC;
          }
    
          [theme=dark] .colab-df-generate:hover {
            background-color: #434B5C;
            box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
            filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
            fill: #FFFFFF;
          }
        </style>
        <button class="colab-df-generate" onclick="generateWithVariable('resultados_train')"
                title="Generate code using this dataframe."
                style="display:none;">
    
      <svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
           width="24px">
        <path d="M7,19H8.4L18.45,9,17,7.55,7,17.6ZM5,21V16.75L18.45,3.32a2,2,0,0,1,2.83,0l1.4,1.43a1.91,1.91,0,0,1,.58,1.4,1.91,1.91,0,0,1-.58,1.4L9.25,21ZM18.45,9,17,7.55Zm-12,3A5.31,5.31,0,0,0,4.9,8.1,5.31,5.31,0,0,0,1,6.5,5.31,5.31,0,0,0,4.9,4.9,5.31,5.31,0,0,0,6.5,1,5.31,5.31,0,0,0,8.1,4.9,5.31,5.31,0,0,0,12,6.5,5.46,5.46,0,0,0,6.5,12Z"/>
      </svg>
        </button>
        <script>
          (() => {
          const buttonEl =
            document.querySelector('#id_64def078-16b9-42ee-85d7-f7bdda392dce button.colab-df-generate');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          buttonEl.onclick = () => {
            google.colab.notebook.generateWithVariable('resultados_train');
          }
          })();
        </script>
      </div>
    
        </div>
      </div>
    


.. parsed-literal::

    
    Métricas de desempeño en el conjunto de test:
    


.. raw:: html

    
      <div id="df-bb47fd05-c77c-4401-b5dc-b75796dbe97b" class="colab-df-container">
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
          <th>SES</th>
          <th>Holt</th>
          <th>Holt-Winters</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>R2</th>
          <td>-0.003979</td>
          <td>-4.633574</td>
          <td>-1.857950</td>
        </tr>
        <tr>
          <th>MAE</th>
          <td>0.808906</td>
          <td>2.287011</td>
          <td>1.491747</td>
        </tr>
        <tr>
          <th>MSE</th>
          <td>1.125912</td>
          <td>6.317770</td>
          <td>3.205047</td>
        </tr>
        <tr>
          <th>RMSE</th>
          <td>1.061090</td>
          <td>2.513518</td>
          <td>1.790265</td>
        </tr>
        <tr>
          <th>MAPE</th>
          <td>0.079579</td>
          <td>0.238254</td>
          <td>0.145455</td>
        </tr>
        <tr>
          <th>Max Error</th>
          <td>3.177836</td>
          <td>4.111111</td>
          <td>3.333760</td>
        </tr>
        <tr>
          <th>Explained Variance</th>
          <td>0.000000</td>
          <td>-0.085371</td>
          <td>0.101232</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-bb47fd05-c77c-4401-b5dc-b75796dbe97b')"
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
            document.querySelector('#df-bb47fd05-c77c-4401-b5dc-b75796dbe97b button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-bb47fd05-c77c-4401-b5dc-b75796dbe97b');
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
    
    
        <div id="df-b90ac681-ddb9-425a-9622-cdae09c421c2">
          <button class="colab-df-quickchart" onclick="quickchart('df-b90ac681-ddb9-425a-9622-cdae09c421c2')"
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
                document.querySelector('#df-b90ac681-ddb9-425a-9622-cdae09c421c2 button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
      <div id="id_a6848efa-3ebb-4a60-816b-7290cd31330f">
        <style>
          .colab-df-generate {
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
    
          .colab-df-generate:hover {
            background-color: #E2EBFA;
            box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
            fill: #174EA6;
          }
    
          [theme=dark] .colab-df-generate {
            background-color: #3B4455;
            fill: #D2E3FC;
          }
    
          [theme=dark] .colab-df-generate:hover {
            background-color: #434B5C;
            box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
            filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
            fill: #FFFFFF;
          }
        </style>
        <button class="colab-df-generate" onclick="generateWithVariable('resultados')"
                title="Generate code using this dataframe."
                style="display:none;">
    
      <svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
           width="24px">
        <path d="M7,19H8.4L18.45,9,17,7.55,7,17.6ZM5,21V16.75L18.45,3.32a2,2,0,0,1,2.83,0l1.4,1.43a1.91,1.91,0,0,1,.58,1.4,1.91,1.91,0,0,1-.58,1.4L9.25,21ZM18.45,9,17,7.55Zm-12,3A5.31,5.31,0,0,0,4.9,8.1,5.31,5.31,0,0,0,1,6.5,5.31,5.31,0,0,0,4.9,4.9,5.31,5.31,0,0,0,6.5,1,5.31,5.31,0,0,0,8.1,4.9,5.31,5.31,0,0,0,12,6.5,5.46,5.46,0,0,0,6.5,12Z"/>
      </svg>
        </button>
        <script>
          (() => {
          const buttonEl =
            document.querySelector('#id_a6848efa-3ebb-4a60-816b-7290cd31330f button.colab-df-generate');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          buttonEl.onclick = () => {
            google.colab.notebook.generateWithVariable('resultados');
          }
          })();
        </script>
      </div>
    
        </div>
      </div>
    


**Interpretación y análisis**

-  **Holt-Winters** logra el mejor ajuste en el conjunto de
   entrenamiento, con un :math:`R^2 = 0.928` y los valores más bajos de
   **MAE** y **RMSE**. Esto indica que el modelo capta muy bien la
   tendencia y estacionalidad de la serie en los datos históricos.

-  **SES** y **Holt** tienen un :math:`R^2` menor (:math:`\approx 0.71`
   y :math:`\approx 0.67` respectivamente) y errores más altos, lo que
   sugiere que capturan menos estructura, especialmente la
   estacionalidad.

En el conjunto de prueba (**test**), el desempeño de todos los modelos
cae significativamente:

-  Todos los modelos presentan valores negativos de :math:`R^2`, lo cual
   significa que son peores que simplemente predecir la media de la
   serie.

-  El **SES**, aunque es el modelo más simple, presenta el menor **MAE**
   (:math:`0.81`) y el menor **MAPE** (:math:`0.079`) en test.

-  **Holt-Winters**, a pesar de ser el mejor en entrenamiento,
   incrementa sus errores en test (**MAE** de :math:`1.49`, **MAPE** de
   :math:`0.145`), reflejando un posible **sobreajuste**
   (*overfitting*).

-  **Holt** tiene el peor desempeño en test, con un **MAE** de
   :math:`2.28` y un **MAPE** de :math:`0.238`.

-  El **Max Error** es alto en todos los modelos en test, lo cual
   evidencia que pueden cometer errores grandes en ciertos puntos.

-  El **Explained Variance** también cae a valores cercanos o inferiores
   a cero, mostrando poca capacidad explicativa fuera de la muestra.

**Conclusión**

Estos resultados muestran que los modelos de suavizamiento pueden
ajustar muy bien los datos históricos, pero su capacidad para predecir
fuera de muestra puede ser limitada, especialmente si la serie de tiempo
presenta cambios de comportamiento, shocks o alta variabilidad.
