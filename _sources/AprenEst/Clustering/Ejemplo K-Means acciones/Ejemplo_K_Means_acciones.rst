Ejemplo K-Means acciones
------------------------

.. code:: ipython3

    import yfinance as yf
    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt

Descargar precios de acciones con diferentes características.

.. code:: ipython3

    acciones = [
        # 🟢 Acciones de bajo Beta (< 0.8) — defensivas
        'JNJ',   # Johnson & Johnson
        'PG',    # Procter & Gamble
        'KO',    # Coca-Cola
        'PEP',   # PepsiCo
        'WMT',   # Walmart
    
        # 🟡 Acciones de Beta cercano a 1 (≈ 0.9 - 1.1) — mercado promedio
        'AAPL',  # Apple
        'MSFT',  # Microsoft
        'V',     # Visa
        'MA',    # Mastercard
        'UNH',   # UnitedHealth
    
        # 🔴 Acciones de Beta alto (> 1.2) — más volátiles que el mercado
        'TSLA',  # Tesla
        'NVDA',  # Nvidia
        'META',  # Meta (Facebook)
        'AMZN',  # Amazon
        'NFLX',  # Netflix
    
        # 🔁 Adicionales mixtas para aumentar diversidad
        'GOOGL', # Alphabet (Google)
        'AMD',   # Advanced Micro Devices
        'CRM',   # Salesforce
        'BA',    # Boeing
        'NKE'    # Nike
    ]
    
    indice = '^GSPC'  # S&P500
    
    datos = yf.download(acciones + [indice], start='2020-07-01', end='2025-07-31', interval='1mo')['Close']
    datos.dropna(inplace=True)
    
    datos.describe()


.. parsed-literal::

    /tmp/ipython-input-4028798923.py:33: FutureWarning: YF.download() has changed argument auto_adjust default to True
      datos = yf.download(acciones + [indice], start='2020-07-01', end='2025-07-31', interval='1mo')['Close']
    [*********************100%***********************]  21 of 21 completed
    



.. raw:: html

    
      <div id="df-6044a7b1-8232-48c1-a952-d67d36c8f6a1" class="colab-df-container">
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
          <th>Ticker</th>
          <th>AAPL</th>
          <th>AMD</th>
          <th>AMZN</th>
          <th>BA</th>
          <th>CRM</th>
          <th>GOOGL</th>
          <th>JNJ</th>
          <th>KO</th>
          <th>MA</th>
          <th>META</th>
          <th>...</th>
          <th>NFLX</th>
          <th>NKE</th>
          <th>NVDA</th>
          <th>PEP</th>
          <th>PG</th>
          <th>TSLA</th>
          <th>UNH</th>
          <th>V</th>
          <th>WMT</th>
          <th>^GSPC</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>count</th>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>...</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
        </tr>
        <tr>
          <th>mean</th>
          <td>168.308614</td>
          <td>111.604426</td>
          <td>157.696810</td>
          <td>192.557214</td>
          <td>234.247295</td>
          <td>130.157316</td>
          <td>149.466887</td>
          <td>56.029760</td>
          <td>398.977756</td>
          <td>351.281434</td>
          <td>...</td>
          <td>555.438689</td>
          <td>106.611314</td>
          <td>53.068235</td>
          <td>149.308493</td>
          <td>141.179574</td>
          <td>246.167060</td>
          <td>444.539697</td>
          <td>241.869443</td>
          <td>56.554208</td>
          <td>4591.564901</td>
        </tr>
        <tr>
          <th>std</th>
          <td>37.929745</td>
          <td>32.599924</td>
          <td>35.406763</td>
          <td>31.330118</td>
          <td>48.640246</td>
          <td>32.428266</td>
          <td>10.006475</td>
          <td>8.197990</td>
          <td>82.631454</td>
          <td>165.833284</td>
          <td>...</td>
          <td>256.862147</td>
          <td>26.270566</td>
          <td>47.606693</td>
          <td>17.191153</td>
          <td>16.928580</td>
          <td>67.619500</td>
          <td>87.096894</td>
          <td>50.515682</td>
          <td>18.592934</td>
          <td>813.091153</td>
        </tr>
        <tr>
          <th>min</th>
          <td>103.174973</td>
          <td>60.060001</td>
          <td>84.000000</td>
          <td>121.080002</td>
          <td>131.438263</td>
          <td>72.843140</td>
          <td>119.756889</td>
          <td>40.592747</td>
          <td>279.303223</td>
          <td>92.651718</td>
          <td>...</td>
          <td>174.869995</td>
          <td>56.027664</td>
          <td>10.579877</td>
          <td>112.904648</td>
          <td>110.428230</td>
          <td>95.384003</td>
          <td>249.559998</td>
          <td>173.635742</td>
          <td>38.925205</td>
          <td>3269.959961</td>
        </tr>
        <tr>
          <th>25%</th>
          <td>138.524857</td>
          <td>85.519997</td>
          <td>133.089996</td>
          <td>171.820007</td>
          <td>201.018570</td>
          <td>103.111603</td>
          <td>144.014481</td>
          <td>50.373859</td>
          <td>346.991211</td>
          <td>252.285934</td>
          <td>...</td>
          <td>394.519989</td>
          <td>88.638329</td>
          <td>16.206350</td>
          <td>134.108490</td>
          <td>127.865433</td>
          <td>201.880005</td>
          <td>386.012909</td>
          <td>206.614456</td>
          <td>44.427788</td>
          <td>4076.600098</td>
        </tr>
        <tr>
          <th>50%</th>
          <td>167.575699</td>
          <td>102.900002</td>
          <td>160.309998</td>
          <td>194.190002</td>
          <td>236.031769</td>
          <td>131.928787</td>
          <td>151.222519</td>
          <td>56.363880</td>
          <td>364.622528</td>
          <td>316.861694</td>
          <td>...</td>
          <td>517.570007</td>
          <td>105.146385</td>
          <td>27.729065</td>
          <td>153.950897</td>
          <td>140.274231</td>
          <td>240.080002</td>
          <td>472.730499</td>
          <td>225.511017</td>
          <td>47.599205</td>
          <td>4395.259766</td>
        </tr>
        <tr>
          <th>75%</th>
          <td>191.829437</td>
          <td>137.179993</td>
          <td>176.759995</td>
          <td>212.009995</td>
          <td>267.514771</td>
          <td>154.275345</td>
          <td>155.431351</td>
          <td>59.936256</td>
          <td>447.335144</td>
          <td>473.209686</td>
          <td>...</td>
          <td>641.619995</td>
          <td>125.442963</td>
          <td>90.315811</td>
          <td>161.462921</td>
          <td>155.857986</td>
          <td>282.160004</td>
          <td>498.170715</td>
          <td>269.519684</td>
          <td>59.151489</td>
          <td>5254.350098</td>
        </tr>
        <tr>
          <th>max</th>
          <td>249.534180</td>
          <td>192.529999</td>
          <td>237.679993</td>
          <td>260.660004</td>
          <td>340.623810</td>
          <td>203.538910</td>
          <td>164.740005</td>
          <td>72.037811</td>
          <td>584.808716</td>
          <td>773.440002</td>
          <td>...</td>
          <td>1339.130005</td>
          <td>160.342438</td>
          <td>177.869995</td>
          <td>177.486206</td>
          <td>175.867111</td>
          <td>404.600006</td>
          <td>601.015320</td>
          <td>363.944122</td>
          <td>98.481895</td>
          <td>6339.390137</td>
        </tr>
      </tbody>
    </table>
    <p>8 rows × 21 columns</p>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-6044a7b1-8232-48c1-a952-d67d36c8f6a1')"
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
            document.querySelector('#df-6044a7b1-8232-48c1-a952-d67d36c8f6a1 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-6044a7b1-8232-48c1-a952-d67d36c8f6a1');
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
    
    
        <div id="df-831c9a83-d5db-4ab1-9c1a-2a86e88d55fe">
          <button class="colab-df-quickchart" onclick="quickchart('df-831c9a83-d5db-4ab1-9c1a-2a86e88d55fe')"
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
                document.querySelector('#df-831c9a83-d5db-4ab1-9c1a-2a86e88d55fe button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
        </div>
      </div>
    



.. code:: ipython3

    datos.info()


.. parsed-literal::

    <class 'pandas.core.frame.DataFrame'>
    DatetimeIndex: 61 entries, 2020-07-01 to 2025-07-01
    Data columns (total 21 columns):
     #   Column  Non-Null Count  Dtype  
    ---  ------  --------------  -----  
     0   AAPL    61 non-null     float64
     1   AMD     61 non-null     float64
     2   AMZN    61 non-null     float64
     3   BA      61 non-null     float64
     4   CRM     61 non-null     float64
     5   GOOGL   61 non-null     float64
     6   JNJ     61 non-null     float64
     7   KO      61 non-null     float64
     8   MA      61 non-null     float64
     9   META    61 non-null     float64
     10  MSFT    61 non-null     float64
     11  NFLX    61 non-null     float64
     12  NKE     61 non-null     float64
     13  NVDA    61 non-null     float64
     14  PEP     61 non-null     float64
     15  PG      61 non-null     float64
     16  TSLA    61 non-null     float64
     17  UNH     61 non-null     float64
     18  V       61 non-null     float64
     19  WMT     61 non-null     float64
     20  ^GSPC   61 non-null     float64
    dtypes: float64(21)
    memory usage: 10.5 KB
    

Variables:
~~~~~~~~~~

Se usaran indicadores financieros para agrupar a las acciones:

-  Rendimiento medio mensual.

-  Volatilidad mensual.

-  Asimetría (Skewness).

-  Curtosis.

-  Coeficiente Beta: mide la sensibilidad del rendimiento de una acción
   frente a los movimientos del mercado, indicando cuánto tiende a
   variar la acción en relación con el índice de referencia.

.. code:: ipython3

    def calcular_indicadores(serie_accion, serie_indice):
        retornos = serie_accion.pct_change().dropna()
        beta = np.cov(retornos, serie_indice.pct_change().dropna())[0, 1] / np.var(serie_indice.pct_change().dropna())
        return {
            'Retorno': retornos.mean(),
            'Volatilidad': retornos.std(),
            'Skewness': retornos.skew(),
            'Kurtosis': retornos.kurt(),
            'Beta': beta
        }
    
    caracteristicas = []
    for accion in acciones:
        caracteristicas.append(calcular_indicadores(datos[accion], datos[indice]))
    
    df_indicadores = pd.DataFrame(caracteristicas, index=acciones)
    
    df_indicadores.describe()




.. raw:: html

    
      <div id="df-f7ddb675-fbdc-4800-a1cc-690477f1dd50" class="colab-df-container">
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
          <th>Retorno</th>
          <th>Volatilidad</th>
          <th>Skewness</th>
          <th>Kurtosis</th>
          <th>Beta</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>count</th>
          <td>20.000000</td>
          <td>20.000000</td>
          <td>20.000000</td>
          <td>20.000000</td>
          <td>20.000000</td>
        </tr>
        <tr>
          <th>mean</th>
          <td>0.016279</td>
          <td>0.092425</td>
          <td>0.051634</td>
          <td>0.542927</td>
          <td>1.153155</td>
        </tr>
        <tr>
          <th>std</th>
          <td>0.013544</td>
          <td>0.041562</td>
          <td>0.562000</td>
          <td>1.361423</td>
          <td>0.589540</td>
        </tr>
        <tr>
          <th>min</th>
          <td>0.001234</td>
          <td>0.045147</td>
          <td>-1.143828</td>
          <td>-0.827875</td>
          <td>0.392903</td>
        </tr>
        <tr>
          <th>25%</th>
          <td>0.008797</td>
          <td>0.062848</td>
          <td>-0.288277</td>
          <td>-0.358965</td>
          <td>0.615435</td>
        </tr>
        <tr>
          <th>50%</th>
          <td>0.012891</td>
          <td>0.079984</td>
          <td>0.123930</td>
          <td>-0.230199</td>
          <td>1.125789</td>
        </tr>
        <tr>
          <th>75%</th>
          <td>0.020063</td>
          <td>0.119030</td>
          <td>0.306697</td>
          <td>1.171872</td>
          <td>1.420758</td>
        </tr>
        <tr>
          <th>max</th>
          <td>0.058650</td>
          <td>0.203409</td>
          <td>1.035205</td>
          <td>4.428854</td>
          <td>2.369970</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-f7ddb675-fbdc-4800-a1cc-690477f1dd50')"
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
            document.querySelector('#df-f7ddb675-fbdc-4800-a1cc-690477f1dd50 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-f7ddb675-fbdc-4800-a1cc-690477f1dd50');
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
    
    
        <div id="df-377503e3-0f39-4699-90d4-80435531c817">
          <button class="colab-df-quickchart" onclick="quickchart('df-377503e3-0f39-4699-90d4-80435531c817')"
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
                document.querySelector('#df-377503e3-0f39-4699-90d4-80435531c817 button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
        </div>
      </div>
    



**Matriz de correlación:**

.. code:: ipython3

    # Matriz de correlación entre las variables:
    import seaborn as sns
    
    plt.figure(figsize=(8, 6))
    sns.heatmap(df_indicadores.corr(), annot=True, cmap='coolwarm', fmt=".2f", linewidths=.5)
    plt.title('Mapa de Calor de Correlaciones de Indicadores')
    plt.show()
    



.. image:: output_9_0.png


**Pair plot:**

.. code:: ipython3

    sns.pairplot(df_indicadores, diag_kind='kde')
    plt.suptitle('Indicadores', y=1.02)
    plt.show()



.. image:: output_11_0.png


.. code:: ipython3

    # Visualización 3D de los indicadores usando px.scatter_3d:
    import plotly.express as px
    
    fig = px.scatter_3d(
        df_indicadores,
        x='Retorno',
        y='Volatilidad',
        z='Skewness',
        opacity=0.7,
        title='Indicadores Financieros 3D'
    )
    
    fig.update_layout(
        scene=dict(
            xaxis_title='Retorno',
            yaxis_title='Volatilidad',
            zaxis_title='Skewness'
        )
    )
    
    fig.show()



.. raw:: html

    <html>
    <head><meta charset="utf-8" /></head>
    <body>
        <div>            <script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-AMS-MML_SVG"></script><script type="text/javascript">if (window.MathJax && window.MathJax.Hub && window.MathJax.Hub.Config) {window.MathJax.Hub.Config({SVG: {font: "STIX-Web"}});}</script>                <script type="text/javascript">window.PlotlyConfig = {MathJaxConfig: 'local'};</script>
            <script charset="utf-8" src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>                <div id="b133a8d6-13fc-4e7c-84d5-7f58b2171489" class="plotly-graph-div" style="height:525px; width:100%;"></div>            <script type="text/javascript">                                    window.PLOTLYENV=window.PLOTLYENV || {};                                    if (document.getElementById("b133a8d6-13fc-4e7c-84d5-7f58b2171489")) {                    Plotly.newPlot(                        "b133a8d6-13fc-4e7c-84d5-7f58b2171489",                        [{"hovertemplate":"Retorno=%{x}\u003cbr\u003eVolatilidad=%{y}\u003cbr\u003eSkewness=%{z}\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"","marker":{"color":"#636efa","opacity":0.7,"symbol":"circle"},"mode":"markers","name":"","scene":"scene","showlegend":false,"x":[0.005536036476453601,0.005605822038713556,0.009860102674448392,0.003507520199343078,0.016605281608324675,0.014536230304060338,0.018846421691027494,0.012591923578449312,0.013191027567752266,0.0015240125678506373,0.03809734988746194,0.0586495485955343,0.026128080310796574,0.010465407311522769,0.0230316954004244,0.019073518977846964,0.024503284234396915,0.010313606152346713,0.012288864600601359,0.0012335920670309716],"y":[0.047865495336009097,0.050744546375373574,0.05053797418163314,0.04514739478162516,0.05759005521174662,0.07689755938465556,0.06541338394874012,0.06460059055032674,0.0721875353936,0.08163779989733622,0.20340861271350252,0.1480524961198354,0.11925611992580483,0.08963434590557022,0.12366013103794612,0.0783304865177071,0.15012414510601715,0.10873051135142082,0.11895405452210038,0.09572766419905888],"z":[0.062440004065379875,0.3029003443487711,-0.0940532152062711,0.38978002107071535,-0.3231305435951523,0.31808857906061644,0.2341127951696587,0.23858757335936093,0.0311815964692423,-0.8649853291975336,0.9309062847532191,-0.09646924851682885,-0.5437786256555805,0.1854192017934314,-1.1438277524218965,-0.5040501138148553,0.29940666936614657,1.0352050018266472,0.8516051445061544,-0.27665853931776563],"type":"scatter3d"}],                        {"template":{"data":{"histogram2dcontour":[{"type":"histogram2dcontour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"choropleth":[{"type":"choropleth","colorbar":{"outlinewidth":0,"ticks":""}}],"histogram2d":[{"type":"histogram2d","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmap":[{"type":"heatmap","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmapgl":[{"type":"heatmapgl","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"contourcarpet":[{"type":"contourcarpet","colorbar":{"outlinewidth":0,"ticks":""}}],"contour":[{"type":"contour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"surface":[{"type":"surface","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"mesh3d":[{"type":"mesh3d","colorbar":{"outlinewidth":0,"ticks":""}}],"scatter":[{"fillpattern":{"fillmode":"overlay","size":10,"solidity":0.2},"type":"scatter"}],"parcoords":[{"type":"parcoords","line":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolargl":[{"type":"scatterpolargl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"bar":[{"error_x":{"color":"#2a3f5f"},"error_y":{"color":"#2a3f5f"},"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"bar"}],"scattergeo":[{"type":"scattergeo","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolar":[{"type":"scatterpolar","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"histogram":[{"marker":{"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"histogram"}],"scattergl":[{"type":"scattergl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatter3d":[{"type":"scatter3d","line":{"colorbar":{"outlinewidth":0,"ticks":""}},"marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattermapbox":[{"type":"scattermapbox","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterternary":[{"type":"scatterternary","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattercarpet":[{"type":"scattercarpet","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"carpet":[{"aaxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"baxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"type":"carpet"}],"table":[{"cells":{"fill":{"color":"#EBF0F8"},"line":{"color":"white"}},"header":{"fill":{"color":"#C8D4E3"},"line":{"color":"white"}},"type":"table"}],"barpolar":[{"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"barpolar"}],"pie":[{"automargin":true,"type":"pie"}]},"layout":{"autotypenumbers":"strict","colorway":["#636efa","#EF553B","#00cc96","#ab63fa","#FFA15A","#19d3f3","#FF6692","#B6E880","#FF97FF","#FECB52"],"font":{"color":"#2a3f5f"},"hovermode":"closest","hoverlabel":{"align":"left"},"paper_bgcolor":"white","plot_bgcolor":"#E5ECF6","polar":{"bgcolor":"#E5ECF6","angularaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"radialaxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"ternary":{"bgcolor":"#E5ECF6","aaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"baxis":{"gridcolor":"white","linecolor":"white","ticks":""},"caxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"coloraxis":{"colorbar":{"outlinewidth":0,"ticks":""}},"colorscale":{"sequential":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"sequentialminus":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"diverging":[[0,"#8e0152"],[0.1,"#c51b7d"],[0.2,"#de77ae"],[0.3,"#f1b6da"],[0.4,"#fde0ef"],[0.5,"#f7f7f7"],[0.6,"#e6f5d0"],[0.7,"#b8e186"],[0.8,"#7fbc41"],[0.9,"#4d9221"],[1,"#276419"]]},"xaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"yaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"scene":{"xaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"yaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"zaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2}},"shapedefaults":{"line":{"color":"#2a3f5f"}},"annotationdefaults":{"arrowcolor":"#2a3f5f","arrowhead":0,"arrowwidth":1},"geo":{"bgcolor":"white","landcolor":"#E5ECF6","subunitcolor":"white","showland":true,"showlakes":true,"lakecolor":"white"},"title":{"x":0.05},"mapbox":{"style":"light"}}},"scene":{"domain":{"x":[0.0,1.0],"y":[0.0,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Volatilidad"}},"zaxis":{"title":{"text":"Skewness"}}},"legend":{"tracegroupgap":0},"title":{"text":"Indicadores Financieros 3D"}},                        {"responsive": true}                    ).then(function(){
    
    var gd = document.getElementById('b133a8d6-13fc-4e7c-84d5-7f58b2171489');
    var x = new MutationObserver(function (mutations, observer) {{
            var display = window.getComputedStyle(gd).display;
            if (!display || display === 'none') {{
                console.log([gd, 'removed!']);
                Plotly.purge(gd);
                observer.disconnect();
            }}
    }});
    
    // Listen for the removal of the full notebook cells
    var notebookContainer = gd.closest('#notebook-container');
    if (notebookContainer) {{
        x.observe(notebookContainer, {childList: true});
    }}
    
    // Listen for the clearing of the current output cell
    var outputEl = gd.closest('.output');
    if (outputEl) {{
        x.observe(outputEl, {childList: true});
    }}
    
                            })                };                            </script>        </div>
    </body>
    </html>


.. code:: ipython3

    fig = px.scatter_3d(
        df_indicadores,
        x='Retorno',
        y='Volatilidad',
        z='Skewness',
        color='Beta', # Para clasificar por Beta
        opacity=0.7,
        title='Indicadores Financieros 3D'
    )
    
    fig.update_layout(
        scene=dict(
            xaxis_title='Retorno',
            yaxis_title='Volatilidad',
            zaxis_title='Skewness'
        )
    )
    
    fig.show()



.. raw:: html

    <html>
    <head><meta charset="utf-8" /></head>
    <body>
        <div>            <script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-AMS-MML_SVG"></script><script type="text/javascript">if (window.MathJax && window.MathJax.Hub && window.MathJax.Hub.Config) {window.MathJax.Hub.Config({SVG: {font: "STIX-Web"}});}</script>                <script type="text/javascript">window.PlotlyConfig = {MathJaxConfig: 'local'};</script>
            <script charset="utf-8" src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>                <div id="8dd6cfb2-3f1a-4d0a-aa61-64e87ac202fb" class="plotly-graph-div" style="height:525px; width:100%;"></div>            <script type="text/javascript">                                    window.PLOTLYENV=window.PLOTLYENV || {};                                    if (document.getElementById("8dd6cfb2-3f1a-4d0a-aa61-64e87ac202fb")) {                    Plotly.newPlot(                        "8dd6cfb2-3f1a-4d0a-aa61-64e87ac202fb",                        [{"hovertemplate":"Retorno=%{x}\u003cbr\u003eVolatilidad=%{y}\u003cbr\u003eSkewness=%{z}\u003cbr\u003eBeta=%{marker.color}\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"","marker":{"color":[0.39579429370381886,0.39290272505364565,0.44495340564652186,0.4710825223719351,0.6635524531327565,1.182855808579341,1.068722617907734,0.9530871085895912,1.0494984621525418,0.44851832904938793,2.369969764285585,2.1805768375190415,1.2948729984048293,1.3358859138819594,1.616112509274086,1.0307166299374708,1.9728141285747292,1.3941044962842355,1.500719593021173,1.2963570126917954],"coloraxis":"coloraxis","opacity":0.7,"symbol":"circle"},"mode":"markers","name":"","scene":"scene","showlegend":false,"x":[0.005536036476453601,0.005605822038713556,0.009860102674448392,0.003507520199343078,0.016605281608324675,0.014536230304060338,0.018846421691027494,0.012591923578449312,0.013191027567752266,0.0015240125678506373,0.03809734988746194,0.0586495485955343,0.026128080310796574,0.010465407311522769,0.0230316954004244,0.019073518977846964,0.024503284234396915,0.010313606152346713,0.012288864600601359,0.0012335920670309716],"y":[0.047865495336009097,0.050744546375373574,0.05053797418163314,0.04514739478162516,0.05759005521174662,0.07689755938465556,0.06541338394874012,0.06460059055032674,0.0721875353936,0.08163779989733622,0.20340861271350252,0.1480524961198354,0.11925611992580483,0.08963434590557022,0.12366013103794612,0.0783304865177071,0.15012414510601715,0.10873051135142082,0.11895405452210038,0.09572766419905888],"z":[0.062440004065379875,0.3029003443487711,-0.0940532152062711,0.38978002107071535,-0.3231305435951523,0.31808857906061644,0.2341127951696587,0.23858757335936093,0.0311815964692423,-0.8649853291975336,0.9309062847532191,-0.09646924851682885,-0.5437786256555805,0.1854192017934314,-1.1438277524218965,-0.5040501138148553,0.29940666936614657,1.0352050018266472,0.8516051445061544,-0.27665853931776563],"type":"scatter3d"}],                        {"template":{"data":{"histogram2dcontour":[{"type":"histogram2dcontour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"choropleth":[{"type":"choropleth","colorbar":{"outlinewidth":0,"ticks":""}}],"histogram2d":[{"type":"histogram2d","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmap":[{"type":"heatmap","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmapgl":[{"type":"heatmapgl","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"contourcarpet":[{"type":"contourcarpet","colorbar":{"outlinewidth":0,"ticks":""}}],"contour":[{"type":"contour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"surface":[{"type":"surface","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"mesh3d":[{"type":"mesh3d","colorbar":{"outlinewidth":0,"ticks":""}}],"scatter":[{"fillpattern":{"fillmode":"overlay","size":10,"solidity":0.2},"type":"scatter"}],"parcoords":[{"type":"parcoords","line":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolargl":[{"type":"scatterpolargl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"bar":[{"error_x":{"color":"#2a3f5f"},"error_y":{"color":"#2a3f5f"},"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"bar"}],"scattergeo":[{"type":"scattergeo","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolar":[{"type":"scatterpolar","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"histogram":[{"marker":{"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"histogram"}],"scattergl":[{"type":"scattergl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatter3d":[{"type":"scatter3d","line":{"colorbar":{"outlinewidth":0,"ticks":""}},"marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattermapbox":[{"type":"scattermapbox","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterternary":[{"type":"scatterternary","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattercarpet":[{"type":"scattercarpet","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"carpet":[{"aaxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"baxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"type":"carpet"}],"table":[{"cells":{"fill":{"color":"#EBF0F8"},"line":{"color":"white"}},"header":{"fill":{"color":"#C8D4E3"},"line":{"color":"white"}},"type":"table"}],"barpolar":[{"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"barpolar"}],"pie":[{"automargin":true,"type":"pie"}]},"layout":{"autotypenumbers":"strict","colorway":["#636efa","#EF553B","#00cc96","#ab63fa","#FFA15A","#19d3f3","#FF6692","#B6E880","#FF97FF","#FECB52"],"font":{"color":"#2a3f5f"},"hovermode":"closest","hoverlabel":{"align":"left"},"paper_bgcolor":"white","plot_bgcolor":"#E5ECF6","polar":{"bgcolor":"#E5ECF6","angularaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"radialaxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"ternary":{"bgcolor":"#E5ECF6","aaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"baxis":{"gridcolor":"white","linecolor":"white","ticks":""},"caxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"coloraxis":{"colorbar":{"outlinewidth":0,"ticks":""}},"colorscale":{"sequential":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"sequentialminus":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"diverging":[[0,"#8e0152"],[0.1,"#c51b7d"],[0.2,"#de77ae"],[0.3,"#f1b6da"],[0.4,"#fde0ef"],[0.5,"#f7f7f7"],[0.6,"#e6f5d0"],[0.7,"#b8e186"],[0.8,"#7fbc41"],[0.9,"#4d9221"],[1,"#276419"]]},"xaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"yaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"scene":{"xaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"yaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"zaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2}},"shapedefaults":{"line":{"color":"#2a3f5f"}},"annotationdefaults":{"arrowcolor":"#2a3f5f","arrowhead":0,"arrowwidth":1},"geo":{"bgcolor":"white","landcolor":"#E5ECF6","subunitcolor":"white","showland":true,"showlakes":true,"lakecolor":"white"},"title":{"x":0.05},"mapbox":{"style":"light"}}},"scene":{"domain":{"x":[0.0,1.0],"y":[0.0,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Volatilidad"}},"zaxis":{"title":{"text":"Skewness"}}},"coloraxis":{"colorbar":{"title":{"text":"Beta"}},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]},"legend":{"tracegroupgap":0},"title":{"text":"Indicadores Financieros 3D"}},                        {"responsive": true}                    ).then(function(){
    
    var gd = document.getElementById('8dd6cfb2-3f1a-4d0a-aa61-64e87ac202fb');
    var x = new MutationObserver(function (mutations, observer) {{
            var display = window.getComputedStyle(gd).display;
            if (!display || display === 'none') {{
                console.log([gd, 'removed!']);
                Plotly.purge(gd);
                observer.disconnect();
            }}
    }});
    
    // Listen for the removal of the full notebook cells
    var notebookContainer = gd.closest('#notebook-container');
    if (notebookContainer) {{
        x.observe(notebookContainer, {childList: true});
    }}
    
    // Listen for the clearing of the current output cell
    var outputEl = gd.closest('.output');
    if (outputEl) {{
        x.observe(outputEl, {childList: true});
    }}
    
                            })                };                            </script>        </div>
    </body>
    </html>


K-Means:
~~~~~~~~

.. code:: ipython3

    from sklearn.preprocessing import StandardScaler
    from sklearn.cluster import KMeans, DBSCAN
    from sklearn.metrics import silhouette_score, pairwise_distances_argmin_min
    from scipy.cluster.hierarchy import dendrogram, linkage, fcluster

.. code:: ipython3

    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(df_indicadores)

.. code:: ipython3

    # Calcular WCSS para diferentes valores de K:
    wcss = []
    K = range(1, 10)
    for k in K:
        kmeans = KMeans(n_clusters=k, random_state=34)
        kmeans.fit(X_scaled)
        wcss.append(kmeans.inertia_)
    
    # Visualizar el método del codo
    plt.figure(figsize=(8, 4))
    plt.plot(K, wcss, "bo-")
    plt.xlabel("Número de clústeres (K)")
    plt.ylabel("WCSS")
    plt.title("Método del Codo para determinar el número óptimo de clústeres")
    plt.show()



.. image:: output_17_0.png


.. code:: ipython3

    !pip install kneed


.. parsed-literal::

    Requirement already satisfied: kneed in /usr/local/lib/python3.11/dist-packages (0.8.5)
    Requirement already satisfied: numpy>=1.14.2 in /usr/local/lib/python3.11/dist-packages (from kneed) (2.0.2)
    Requirement already satisfied: scipy>=1.0.0 in /usr/local/lib/python3.11/dist-packages (from kneed) (1.16.1)
    

.. code:: ipython3

    # Seleccion "automatica" del punto de codo:
    
    # !pip install kneed
    
    from kneed import KneeLocator
    
    kl = KneeLocator(
        range(1,10),
        wcss,
        curve="convex",
        direction="decreasing"
    )
    
    print(kl.elbow)


.. parsed-literal::

    5
    

.. code:: ipython3

    # Calcular la puntuación de la silueta para diferentes valores de K:
    from sklearn.metrics import silhouette_score
    
    silhouette_scores = []
    K = range(2, 11)
    for k in K:
        kmeans = KMeans(n_clusters=k, random_state=34)
        kmeans.fit(X_scaled)
        labels = kmeans.labels_
        score = silhouette_score(X_scaled, labels)
        silhouette_scores.append(score)
    
    # Visualizar la puntuación de la silueta
    plt.figure(figsize=(8, 4))
    plt.plot(K, silhouette_scores, "bo-")
    plt.xlabel("Número de clústeres (K)")
    plt.ylabel("Puntuación de la Silueta")
    plt.title("Método de la Silueta para determinar el número óptimo de clústeres")
    plt.show()



.. image:: output_20_0.png


**Clusters = 3**

.. code:: ipython3

    k_base = 3
    
    kmeans = KMeans(n_clusters=k_base, random_state=34)
    df_indicadores['Cluster_KMeans'] = kmeans.fit_predict(X_scaled)
    
    # Valores de Inercia y Silueta:
    inercia = kmeans.inertia_
    silhouette = silhouette_score(X_scaled, df_indicadores['Cluster_KMeans'])
    
    print(f"Clusters: {k_base}")
    print(f"Inercia: {inercia}")
    print(f"Puntuación de la Silueta: {silhouette}")


.. parsed-literal::

    Clusters: 3
    Inercia: 43.04524640982964
    Puntuación de la Silueta: 0.38199664893165897
    

.. code:: ipython3

    sns.pairplot(df_indicadores, hue='Cluster_KMeans', diag_kind='kde', palette='Set1')
    plt.suptitle('Clustering K-Means', y=1.02)
    plt.show()



.. image:: output_23_0.png


.. code:: ipython3

    # Visualización 3D de los clusters usando px.scatter_3d:
    
    fig = px.scatter_3d(
        df_indicadores,
        x='Retorno',
        y='Volatilidad',
        z='Beta',
        color='Cluster_KMeans',
        opacity=0.7,
        title='Clustering K-Means 3D'
    )
    
    fig.update_layout(
        scene=dict(
            xaxis_title='Retorno',
            yaxis_title='Volatilidad',
            zaxis_title='Beta'
        )
    )
    
    fig.show()



.. raw:: html

    <html>
    <head><meta charset="utf-8" /></head>
    <body>
        <div>            <script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-AMS-MML_SVG"></script><script type="text/javascript">if (window.MathJax && window.MathJax.Hub && window.MathJax.Hub.Config) {window.MathJax.Hub.Config({SVG: {font: "STIX-Web"}});}</script>                <script type="text/javascript">window.PlotlyConfig = {MathJaxConfig: 'local'};</script>
            <script charset="utf-8" src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>                <div id="4d9cd72b-d32d-4067-b71f-5d5030fcab86" class="plotly-graph-div" style="height:525px; width:100%;"></div>            <script type="text/javascript">                                    window.PLOTLYENV=window.PLOTLYENV || {};                                    if (document.getElementById("4d9cd72b-d32d-4067-b71f-5d5030fcab86")) {                    Plotly.newPlot(                        "4d9cd72b-d32d-4067-b71f-5d5030fcab86",                        [{"hovertemplate":"Retorno=%{x}\u003cbr\u003eVolatilidad=%{y}\u003cbr\u003eBeta=%{z}\u003cbr\u003eCluster_KMeans=%{marker.color}\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"","marker":{"color":[0,0,0,0,0,0,0,0,0,0,1,1,2,0,2,0,1,2,2,0],"coloraxis":"coloraxis","opacity":0.7,"symbol":"circle"},"mode":"markers","name":"","scene":"scene","showlegend":false,"x":[0.005536036476453601,0.005605822038713556,0.009860102674448392,0.003507520199343078,0.016605281608324675,0.014536230304060338,0.018846421691027494,0.012591923578449312,0.013191027567752266,0.0015240125678506373,0.03809734988746194,0.0586495485955343,0.026128080310796574,0.010465407311522769,0.0230316954004244,0.019073518977846964,0.024503284234396915,0.010313606152346713,0.012288864600601359,0.0012335920670309716],"y":[0.047865495336009097,0.050744546375373574,0.05053797418163314,0.04514739478162516,0.05759005521174662,0.07689755938465556,0.06541338394874012,0.06460059055032674,0.0721875353936,0.08163779989733622,0.20340861271350252,0.1480524961198354,0.11925611992580483,0.08963434590557022,0.12366013103794612,0.0783304865177071,0.15012414510601715,0.10873051135142082,0.11895405452210038,0.09572766419905888],"z":[0.39579429370381886,0.39290272505364565,0.44495340564652186,0.4710825223719351,0.6635524531327565,1.182855808579341,1.068722617907734,0.9530871085895912,1.0494984621525418,0.44851832904938793,2.369969764285585,2.1805768375190415,1.2948729984048293,1.3358859138819594,1.616112509274086,1.0307166299374708,1.9728141285747292,1.3941044962842355,1.500719593021173,1.2963570126917954],"type":"scatter3d"}],                        {"template":{"data":{"histogram2dcontour":[{"type":"histogram2dcontour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"choropleth":[{"type":"choropleth","colorbar":{"outlinewidth":0,"ticks":""}}],"histogram2d":[{"type":"histogram2d","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmap":[{"type":"heatmap","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmapgl":[{"type":"heatmapgl","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"contourcarpet":[{"type":"contourcarpet","colorbar":{"outlinewidth":0,"ticks":""}}],"contour":[{"type":"contour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"surface":[{"type":"surface","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"mesh3d":[{"type":"mesh3d","colorbar":{"outlinewidth":0,"ticks":""}}],"scatter":[{"fillpattern":{"fillmode":"overlay","size":10,"solidity":0.2},"type":"scatter"}],"parcoords":[{"type":"parcoords","line":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolargl":[{"type":"scatterpolargl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"bar":[{"error_x":{"color":"#2a3f5f"},"error_y":{"color":"#2a3f5f"},"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"bar"}],"scattergeo":[{"type":"scattergeo","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolar":[{"type":"scatterpolar","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"histogram":[{"marker":{"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"histogram"}],"scattergl":[{"type":"scattergl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatter3d":[{"type":"scatter3d","line":{"colorbar":{"outlinewidth":0,"ticks":""}},"marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattermapbox":[{"type":"scattermapbox","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterternary":[{"type":"scatterternary","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattercarpet":[{"type":"scattercarpet","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"carpet":[{"aaxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"baxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"type":"carpet"}],"table":[{"cells":{"fill":{"color":"#EBF0F8"},"line":{"color":"white"}},"header":{"fill":{"color":"#C8D4E3"},"line":{"color":"white"}},"type":"table"}],"barpolar":[{"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"barpolar"}],"pie":[{"automargin":true,"type":"pie"}]},"layout":{"autotypenumbers":"strict","colorway":["#636efa","#EF553B","#00cc96","#ab63fa","#FFA15A","#19d3f3","#FF6692","#B6E880","#FF97FF","#FECB52"],"font":{"color":"#2a3f5f"},"hovermode":"closest","hoverlabel":{"align":"left"},"paper_bgcolor":"white","plot_bgcolor":"#E5ECF6","polar":{"bgcolor":"#E5ECF6","angularaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"radialaxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"ternary":{"bgcolor":"#E5ECF6","aaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"baxis":{"gridcolor":"white","linecolor":"white","ticks":""},"caxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"coloraxis":{"colorbar":{"outlinewidth":0,"ticks":""}},"colorscale":{"sequential":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"sequentialminus":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"diverging":[[0,"#8e0152"],[0.1,"#c51b7d"],[0.2,"#de77ae"],[0.3,"#f1b6da"],[0.4,"#fde0ef"],[0.5,"#f7f7f7"],[0.6,"#e6f5d0"],[0.7,"#b8e186"],[0.8,"#7fbc41"],[0.9,"#4d9221"],[1,"#276419"]]},"xaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"yaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"scene":{"xaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"yaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"zaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2}},"shapedefaults":{"line":{"color":"#2a3f5f"}},"annotationdefaults":{"arrowcolor":"#2a3f5f","arrowhead":0,"arrowwidth":1},"geo":{"bgcolor":"white","landcolor":"#E5ECF6","subunitcolor":"white","showland":true,"showlakes":true,"lakecolor":"white"},"title":{"x":0.05},"mapbox":{"style":"light"}}},"scene":{"domain":{"x":[0.0,1.0],"y":[0.0,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Volatilidad"}},"zaxis":{"title":{"text":"Beta"}}},"coloraxis":{"colorbar":{"title":{"text":"Cluster_KMeans"}},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]},"legend":{"tracegroupgap":0},"title":{"text":"Clustering K-Means 3D"}},                        {"responsive": true}                    ).then(function(){
    
    var gd = document.getElementById('4d9cd72b-d32d-4067-b71f-5d5030fcab86');
    var x = new MutationObserver(function (mutations, observer) {{
            var display = window.getComputedStyle(gd).display;
            if (!display || display === 'none') {{
                console.log([gd, 'removed!']);
                Plotly.purge(gd);
                observer.disconnect();
            }}
    }});
    
    // Listen for the removal of the full notebook cells
    var notebookContainer = gd.closest('#notebook-container');
    if (notebookContainer) {{
        x.observe(notebookContainer, {childList: true});
    }}
    
    // Listen for the clearing of the current output cell
    var outputEl = gd.closest('.output');
    if (outputEl) {{
        x.observe(outputEl, {childList: true});
    }}
    
                            })                };                            </script>        </div>
    </body>
    </html>


.. code:: ipython3

    from itertools import combinations
    import plotly.graph_objects as go
    from plotly.subplots import make_subplots
    from plotly.express.colors import qualitative as qcolors
    
    def plot_3d_combinations(df_indicadores,
                             indicadores=('Retorno','Volatilidad','Skewness','Kurtosis','Beta'),
                             cluster_col='Cluster_KMeans',
                             rows=2,
                             marker_size=4,
                             opacity=0.8):
        # Combinaciones 3D
        combos = list(combinations(indicadores, 3))
        cols = int(np.ceil(len(combos)/rows))
    
        # Paleta discreta para clusters
        clusters = df_indicadores[cluster_col].astype(str)
        cluster_vals = clusters.unique()
        color_map = {cl: qcolors.Plotly[i % len(qcolors.Plotly)] for i, cl in enumerate(sorted(cluster_vals))}
    
        # Lienzo con subplots 3D
        fig = make_subplots(
            rows=rows, cols=cols,
            specs=[[{'type': 'scene'} for _ in range(cols)] for _ in range(rows)],
            subplot_titles=[f"{x} vs {y} vs {z}" for (x,y,z) in combos]
        )
    
        # Añadir trazas por subplot y por cluster (para leyenda discreta)
        for i, (x, y, z) in enumerate(combos, start=1):
            r = (i-1)//cols + 1
            c = (i-1)%cols + 1
    
            for cl in sorted(cluster_vals):
                mask = clusters == cl
                fig.add_trace(
                    go.Scatter3d(
                        x=df_indicadores.loc[mask, x],
                        y=df_indicadores.loc[mask, y],
                        z=df_indicadores.loc[mask, z],
                        mode='markers',
                        name=f"Cluster {cl}",
                        legendgroup=f"Cluster {cl}",
                        showlegend=(i == 1),  # leyenda solo en el primer subplot
                        marker=dict(size=marker_size, opacity=opacity, color=color_map[cl]),
                        hovertemplate=f"{x}: %{{x}}<br>{y}: %{{y}}<br>{z}: %{{z}}<br>Cluster: {cl}<extra></extra>"
                    ),
                    row=r, col=c
                )
    
            # Títulos de ejes para cada escena
            scene_id = "scene" if i == 1 else f"scene{i}"
            fig.layout[scene_id].xaxis.title = x
            fig.layout[scene_id].yaxis.title = y
            fig.layout[scene_id].zaxis.title = z
    
        fig.update_layout(
            height=800, width=1700,
            title_text="Clustering K-Means 3D — Todas las combinaciones de indicadores",
            margin=dict(l=0, r=0, t=50, b=0)
        )
        fig.show()
    
    plot_3d_combinations(df_indicadores)
    



.. raw:: html

    <html>
    <head><meta charset="utf-8" /></head>
    <body>
        <div>            <script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-AMS-MML_SVG"></script><script type="text/javascript">if (window.MathJax && window.MathJax.Hub && window.MathJax.Hub.Config) {window.MathJax.Hub.Config({SVG: {font: "STIX-Web"}});}</script>                <script type="text/javascript">window.PlotlyConfig = {MathJaxConfig: 'local'};</script>
            <script charset="utf-8" src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>                <div id="44f81db7-9498-4a69-8bb8-76de41451c5f" class="plotly-graph-div" style="height:800px; width:1700px;"></div>            <script type="text/javascript">                                    window.PLOTLYENV=window.PLOTLYENV || {};                                    if (document.getElementById("44f81db7-9498-4a69-8bb8-76de41451c5f")) {                    Plotly.newPlot(                        "44f81db7-9498-4a69-8bb8-76de41451c5f",                        [{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eSkewness: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":true,"x":[0.005536036476453601,0.005605822038713556,0.009860102674448392,0.003507520199343078,0.016605281608324675,0.014536230304060338,0.018846421691027494,0.012591923578449312,0.013191027567752266,0.0015240125678506373,0.010465407311522769,0.019073518977846964,0.0012335920670309716],"y":[0.047865495336009097,0.050744546375373574,0.05053797418163314,0.04514739478162516,0.05759005521174662,0.07689755938465556,0.06541338394874012,0.06460059055032674,0.0721875353936,0.08163779989733622,0.08963434590557022,0.0783304865177071,0.09572766419905888],"z":[0.062440004065379875,0.3029003443487711,-0.0940532152062711,0.38978002107071535,-0.3231305435951523,0.31808857906061644,0.2341127951696587,0.23858757335936093,0.0311815964692423,-0.8649853291975336,0.1854192017934314,-0.5040501138148553,-0.27665853931776563],"type":"scatter3d","scene":"scene"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eSkewness: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":true,"x":[0.03809734988746194,0.0586495485955343,0.024503284234396915],"y":[0.20340861271350252,0.1480524961198354,0.15012414510601715],"z":[0.9309062847532191,-0.09646924851682885,0.29940666936614657],"type":"scatter3d","scene":"scene"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eSkewness: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":true,"x":[0.026128080310796574,0.0230316954004244,0.010313606152346713,0.012288864600601359],"y":[0.11925611992580483,0.12366013103794612,0.10873051135142082,0.11895405452210038],"z":[-0.5437786256555805,-1.1438277524218965,1.0352050018266472,0.8516051445061544],"type":"scatter3d","scene":"scene"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.005536036476453601,0.005605822038713556,0.009860102674448392,0.003507520199343078,0.016605281608324675,0.014536230304060338,0.018846421691027494,0.012591923578449312,0.013191027567752266,0.0015240125678506373,0.010465407311522769,0.019073518977846964,0.0012335920670309716],"y":[0.047865495336009097,0.050744546375373574,0.05053797418163314,0.04514739478162516,0.05759005521174662,0.07689755938465556,0.06541338394874012,0.06460059055032674,0.0721875353936,0.08163779989733622,0.08963434590557022,0.0783304865177071,0.09572766419905888],"z":[-0.6934829137964615,-0.34296695315644365,0.4252880340525915,-0.20953623640637709,0.5555300328474022,-0.4317922678594459,-0.33299193448997855,-0.42839761251375563,-0.25086172202040036,2.0151334604275495,0.8367631114206882,-0.28817668986452016,-0.31682888161389133],"type":"scatter3d","scene":"scene2"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.03809734988746194,0.0586495485955343,0.024503284234396915],"y":[0.20340861271350252,0.1480524961198354,0.15012414510601715],"z":[1.4082977795115847,-0.40695724262300903,-0.8278754240318706],"type":"scatter3d","scene":"scene2"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.026128080310796574,0.0230316954004244,0.010313606152346713,0.012288864600601359],"y":[0.11925611992580483,0.12366013103794612,0.10873051135142082,0.11895405452210038],"z":[1.0930637701032277,4.428853906419347,2.0389025778445062,2.5865659541656494],"type":"scatter3d","scene":"scene2"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.005536036476453601,0.005605822038713556,0.009860102674448392,0.003507520199343078,0.016605281608324675,0.014536230304060338,0.018846421691027494,0.012591923578449312,0.013191027567752266,0.0015240125678506373,0.010465407311522769,0.019073518977846964,0.0012335920670309716],"y":[0.047865495336009097,0.050744546375373574,0.05053797418163314,0.04514739478162516,0.05759005521174662,0.07689755938465556,0.06541338394874012,0.06460059055032674,0.0721875353936,0.08163779989733622,0.08963434590557022,0.0783304865177071,0.09572766419905888],"z":[0.39579429370381886,0.39290272505364565,0.44495340564652186,0.4710825223719351,0.6635524531327565,1.182855808579341,1.068722617907734,0.9530871085895912,1.0494984621525418,0.44851832904938793,1.3358859138819594,1.0307166299374708,1.2963570126917954],"type":"scatter3d","scene":"scene3"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.03809734988746194,0.0586495485955343,0.024503284234396915],"y":[0.20340861271350252,0.1480524961198354,0.15012414510601715],"z":[2.369969764285585,2.1805768375190415,1.9728141285747292],"type":"scatter3d","scene":"scene3"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.026128080310796574,0.0230316954004244,0.010313606152346713,0.012288864600601359],"y":[0.11925611992580483,0.12366013103794612,0.10873051135142082,0.11895405452210038],"z":[1.2948729984048293,1.616112509274086,1.3941044962842355,1.500719593021173],"type":"scatter3d","scene":"scene3"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.005536036476453601,0.005605822038713556,0.009860102674448392,0.003507520199343078,0.016605281608324675,0.014536230304060338,0.018846421691027494,0.012591923578449312,0.013191027567752266,0.0015240125678506373,0.010465407311522769,0.019073518977846964,0.0012335920670309716],"y":[0.062440004065379875,0.3029003443487711,-0.0940532152062711,0.38978002107071535,-0.3231305435951523,0.31808857906061644,0.2341127951696587,0.23858757335936093,0.0311815964692423,-0.8649853291975336,0.1854192017934314,-0.5040501138148553,-0.27665853931776563],"z":[-0.6934829137964615,-0.34296695315644365,0.4252880340525915,-0.20953623640637709,0.5555300328474022,-0.4317922678594459,-0.33299193448997855,-0.42839761251375563,-0.25086172202040036,2.0151334604275495,0.8367631114206882,-0.28817668986452016,-0.31682888161389133],"type":"scatter3d","scene":"scene4"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.03809734988746194,0.0586495485955343,0.024503284234396915],"y":[0.9309062847532191,-0.09646924851682885,0.29940666936614657],"z":[1.4082977795115847,-0.40695724262300903,-0.8278754240318706],"type":"scatter3d","scene":"scene4"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.026128080310796574,0.0230316954004244,0.010313606152346713,0.012288864600601359],"y":[-0.5437786256555805,-1.1438277524218965,1.0352050018266472,0.8516051445061544],"z":[1.0930637701032277,4.428853906419347,2.0389025778445062,2.5865659541656494],"type":"scatter3d","scene":"scene4"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.005536036476453601,0.005605822038713556,0.009860102674448392,0.003507520199343078,0.016605281608324675,0.014536230304060338,0.018846421691027494,0.012591923578449312,0.013191027567752266,0.0015240125678506373,0.010465407311522769,0.019073518977846964,0.0012335920670309716],"y":[0.062440004065379875,0.3029003443487711,-0.0940532152062711,0.38978002107071535,-0.3231305435951523,0.31808857906061644,0.2341127951696587,0.23858757335936093,0.0311815964692423,-0.8649853291975336,0.1854192017934314,-0.5040501138148553,-0.27665853931776563],"z":[0.39579429370381886,0.39290272505364565,0.44495340564652186,0.4710825223719351,0.6635524531327565,1.182855808579341,1.068722617907734,0.9530871085895912,1.0494984621525418,0.44851832904938793,1.3358859138819594,1.0307166299374708,1.2963570126917954],"type":"scatter3d","scene":"scene5"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.03809734988746194,0.0586495485955343,0.024503284234396915],"y":[0.9309062847532191,-0.09646924851682885,0.29940666936614657],"z":[2.369969764285585,2.1805768375190415,1.9728141285747292],"type":"scatter3d","scene":"scene5"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.026128080310796574,0.0230316954004244,0.010313606152346713,0.012288864600601359],"y":[-0.5437786256555805,-1.1438277524218965,1.0352050018266472,0.8516051445061544],"z":[1.2948729984048293,1.616112509274086,1.3941044962842355,1.500719593021173],"type":"scatter3d","scene":"scene5"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.005536036476453601,0.005605822038713556,0.009860102674448392,0.003507520199343078,0.016605281608324675,0.014536230304060338,0.018846421691027494,0.012591923578449312,0.013191027567752266,0.0015240125678506373,0.010465407311522769,0.019073518977846964,0.0012335920670309716],"y":[-0.6934829137964615,-0.34296695315644365,0.4252880340525915,-0.20953623640637709,0.5555300328474022,-0.4317922678594459,-0.33299193448997855,-0.42839761251375563,-0.25086172202040036,2.0151334604275495,0.8367631114206882,-0.28817668986452016,-0.31682888161389133],"z":[0.39579429370381886,0.39290272505364565,0.44495340564652186,0.4710825223719351,0.6635524531327565,1.182855808579341,1.068722617907734,0.9530871085895912,1.0494984621525418,0.44851832904938793,1.3358859138819594,1.0307166299374708,1.2963570126917954],"type":"scatter3d","scene":"scene6"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.03809734988746194,0.0586495485955343,0.024503284234396915],"y":[1.4082977795115847,-0.40695724262300903,-0.8278754240318706],"z":[2.369969764285585,2.1805768375190415,1.9728141285747292],"type":"scatter3d","scene":"scene6"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.026128080310796574,0.0230316954004244,0.010313606152346713,0.012288864600601359],"y":[1.0930637701032277,4.428853906419347,2.0389025778445062,2.5865659541656494],"z":[1.2948729984048293,1.616112509274086,1.3941044962842355,1.500719593021173],"type":"scatter3d","scene":"scene6"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.047865495336009097,0.050744546375373574,0.05053797418163314,0.04514739478162516,0.05759005521174662,0.07689755938465556,0.06541338394874012,0.06460059055032674,0.0721875353936,0.08163779989733622,0.08963434590557022,0.0783304865177071,0.09572766419905888],"y":[0.062440004065379875,0.3029003443487711,-0.0940532152062711,0.38978002107071535,-0.3231305435951523,0.31808857906061644,0.2341127951696587,0.23858757335936093,0.0311815964692423,-0.8649853291975336,0.1854192017934314,-0.5040501138148553,-0.27665853931776563],"z":[-0.6934829137964615,-0.34296695315644365,0.4252880340525915,-0.20953623640637709,0.5555300328474022,-0.4317922678594459,-0.33299193448997855,-0.42839761251375563,-0.25086172202040036,2.0151334604275495,0.8367631114206882,-0.28817668986452016,-0.31682888161389133],"type":"scatter3d","scene":"scene7"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.20340861271350252,0.1480524961198354,0.15012414510601715],"y":[0.9309062847532191,-0.09646924851682885,0.29940666936614657],"z":[1.4082977795115847,-0.40695724262300903,-0.8278754240318706],"type":"scatter3d","scene":"scene7"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.11925611992580483,0.12366013103794612,0.10873051135142082,0.11895405452210038],"y":[-0.5437786256555805,-1.1438277524218965,1.0352050018266472,0.8516051445061544],"z":[1.0930637701032277,4.428853906419347,2.0389025778445062,2.5865659541656494],"type":"scatter3d","scene":"scene7"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.047865495336009097,0.050744546375373574,0.05053797418163314,0.04514739478162516,0.05759005521174662,0.07689755938465556,0.06541338394874012,0.06460059055032674,0.0721875353936,0.08163779989733622,0.08963434590557022,0.0783304865177071,0.09572766419905888],"y":[0.062440004065379875,0.3029003443487711,-0.0940532152062711,0.38978002107071535,-0.3231305435951523,0.31808857906061644,0.2341127951696587,0.23858757335936093,0.0311815964692423,-0.8649853291975336,0.1854192017934314,-0.5040501138148553,-0.27665853931776563],"z":[0.39579429370381886,0.39290272505364565,0.44495340564652186,0.4710825223719351,0.6635524531327565,1.182855808579341,1.068722617907734,0.9530871085895912,1.0494984621525418,0.44851832904938793,1.3358859138819594,1.0307166299374708,1.2963570126917954],"type":"scatter3d","scene":"scene8"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.20340861271350252,0.1480524961198354,0.15012414510601715],"y":[0.9309062847532191,-0.09646924851682885,0.29940666936614657],"z":[2.369969764285585,2.1805768375190415,1.9728141285747292],"type":"scatter3d","scene":"scene8"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.11925611992580483,0.12366013103794612,0.10873051135142082,0.11895405452210038],"y":[-0.5437786256555805,-1.1438277524218965,1.0352050018266472,0.8516051445061544],"z":[1.2948729984048293,1.616112509274086,1.3941044962842355,1.500719593021173],"type":"scatter3d","scene":"scene8"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.047865495336009097,0.050744546375373574,0.05053797418163314,0.04514739478162516,0.05759005521174662,0.07689755938465556,0.06541338394874012,0.06460059055032674,0.0721875353936,0.08163779989733622,0.08963434590557022,0.0783304865177071,0.09572766419905888],"y":[-0.6934829137964615,-0.34296695315644365,0.4252880340525915,-0.20953623640637709,0.5555300328474022,-0.4317922678594459,-0.33299193448997855,-0.42839761251375563,-0.25086172202040036,2.0151334604275495,0.8367631114206882,-0.28817668986452016,-0.31682888161389133],"z":[0.39579429370381886,0.39290272505364565,0.44495340564652186,0.4710825223719351,0.6635524531327565,1.182855808579341,1.068722617907734,0.9530871085895912,1.0494984621525418,0.44851832904938793,1.3358859138819594,1.0307166299374708,1.2963570126917954],"type":"scatter3d","scene":"scene9"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.20340861271350252,0.1480524961198354,0.15012414510601715],"y":[1.4082977795115847,-0.40695724262300903,-0.8278754240318706],"z":[2.369969764285585,2.1805768375190415,1.9728141285747292],"type":"scatter3d","scene":"scene9"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.11925611992580483,0.12366013103794612,0.10873051135142082,0.11895405452210038],"y":[1.0930637701032277,4.428853906419347,2.0389025778445062,2.5865659541656494],"z":[1.2948729984048293,1.616112509274086,1.3941044962842355,1.500719593021173],"type":"scatter3d","scene":"scene9"},{"hovertemplate":"Skewness: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.062440004065379875,0.3029003443487711,-0.0940532152062711,0.38978002107071535,-0.3231305435951523,0.31808857906061644,0.2341127951696587,0.23858757335936093,0.0311815964692423,-0.8649853291975336,0.1854192017934314,-0.5040501138148553,-0.27665853931776563],"y":[-0.6934829137964615,-0.34296695315644365,0.4252880340525915,-0.20953623640637709,0.5555300328474022,-0.4317922678594459,-0.33299193448997855,-0.42839761251375563,-0.25086172202040036,2.0151334604275495,0.8367631114206882,-0.28817668986452016,-0.31682888161389133],"z":[0.39579429370381886,0.39290272505364565,0.44495340564652186,0.4710825223719351,0.6635524531327565,1.182855808579341,1.068722617907734,0.9530871085895912,1.0494984621525418,0.44851832904938793,1.3358859138819594,1.0307166299374708,1.2963570126917954],"type":"scatter3d","scene":"scene10"},{"hovertemplate":"Skewness: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.9309062847532191,-0.09646924851682885,0.29940666936614657],"y":[1.4082977795115847,-0.40695724262300903,-0.8278754240318706],"z":[2.369969764285585,2.1805768375190415,1.9728141285747292],"type":"scatter3d","scene":"scene10"},{"hovertemplate":"Skewness: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[-0.5437786256555805,-1.1438277524218965,1.0352050018266472,0.8516051445061544],"y":[1.0930637701032277,4.428853906419347,2.0389025778445062,2.5865659541656494],"z":[1.2948729984048293,1.616112509274086,1.3941044962842355,1.500719593021173],"type":"scatter3d","scene":"scene10"}],                        {"template":{"data":{"histogram2dcontour":[{"type":"histogram2dcontour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"choropleth":[{"type":"choropleth","colorbar":{"outlinewidth":0,"ticks":""}}],"histogram2d":[{"type":"histogram2d","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmap":[{"type":"heatmap","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmapgl":[{"type":"heatmapgl","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"contourcarpet":[{"type":"contourcarpet","colorbar":{"outlinewidth":0,"ticks":""}}],"contour":[{"type":"contour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"surface":[{"type":"surface","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"mesh3d":[{"type":"mesh3d","colorbar":{"outlinewidth":0,"ticks":""}}],"scatter":[{"fillpattern":{"fillmode":"overlay","size":10,"solidity":0.2},"type":"scatter"}],"parcoords":[{"type":"parcoords","line":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolargl":[{"type":"scatterpolargl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"bar":[{"error_x":{"color":"#2a3f5f"},"error_y":{"color":"#2a3f5f"},"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"bar"}],"scattergeo":[{"type":"scattergeo","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolar":[{"type":"scatterpolar","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"histogram":[{"marker":{"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"histogram"}],"scattergl":[{"type":"scattergl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatter3d":[{"type":"scatter3d","line":{"colorbar":{"outlinewidth":0,"ticks":""}},"marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattermapbox":[{"type":"scattermapbox","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterternary":[{"type":"scatterternary","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattercarpet":[{"type":"scattercarpet","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"carpet":[{"aaxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"baxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"type":"carpet"}],"table":[{"cells":{"fill":{"color":"#EBF0F8"},"line":{"color":"white"}},"header":{"fill":{"color":"#C8D4E3"},"line":{"color":"white"}},"type":"table"}],"barpolar":[{"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"barpolar"}],"pie":[{"automargin":true,"type":"pie"}]},"layout":{"autotypenumbers":"strict","colorway":["#636efa","#EF553B","#00cc96","#ab63fa","#FFA15A","#19d3f3","#FF6692","#B6E880","#FF97FF","#FECB52"],"font":{"color":"#2a3f5f"},"hovermode":"closest","hoverlabel":{"align":"left"},"paper_bgcolor":"white","plot_bgcolor":"#E5ECF6","polar":{"bgcolor":"#E5ECF6","angularaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"radialaxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"ternary":{"bgcolor":"#E5ECF6","aaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"baxis":{"gridcolor":"white","linecolor":"white","ticks":""},"caxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"coloraxis":{"colorbar":{"outlinewidth":0,"ticks":""}},"colorscale":{"sequential":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"sequentialminus":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"diverging":[[0,"#8e0152"],[0.1,"#c51b7d"],[0.2,"#de77ae"],[0.3,"#f1b6da"],[0.4,"#fde0ef"],[0.5,"#f7f7f7"],[0.6,"#e6f5d0"],[0.7,"#b8e186"],[0.8,"#7fbc41"],[0.9,"#4d9221"],[1,"#276419"]]},"xaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"yaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"scene":{"xaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"yaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"zaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2}},"shapedefaults":{"line":{"color":"#2a3f5f"}},"annotationdefaults":{"arrowcolor":"#2a3f5f","arrowhead":0,"arrowwidth":1},"geo":{"bgcolor":"white","landcolor":"#E5ECF6","subunitcolor":"white","showland":true,"showlakes":true,"lakecolor":"white"},"title":{"x":0.05},"mapbox":{"style":"light"}}},"scene":{"domain":{"x":[0.0,0.16799999999999998],"y":[0.625,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Volatilidad"}},"zaxis":{"title":{"text":"Skewness"}}},"scene2":{"domain":{"x":[0.208,0.376],"y":[0.625,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Volatilidad"}},"zaxis":{"title":{"text":"Kurtosis"}}},"scene3":{"domain":{"x":[0.416,0.584],"y":[0.625,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Volatilidad"}},"zaxis":{"title":{"text":"Beta"}}},"scene4":{"domain":{"x":[0.624,0.792],"y":[0.625,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Skewness"}},"zaxis":{"title":{"text":"Kurtosis"}}},"scene5":{"domain":{"x":[0.832,1.0],"y":[0.625,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Skewness"}},"zaxis":{"title":{"text":"Beta"}}},"scene6":{"domain":{"x":[0.0,0.16799999999999998],"y":[0.0,0.375]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Kurtosis"}},"zaxis":{"title":{"text":"Beta"}}},"scene7":{"domain":{"x":[0.208,0.376],"y":[0.0,0.375]},"xaxis":{"title":{"text":"Volatilidad"}},"yaxis":{"title":{"text":"Skewness"}},"zaxis":{"title":{"text":"Kurtosis"}}},"scene8":{"domain":{"x":[0.416,0.584],"y":[0.0,0.375]},"xaxis":{"title":{"text":"Volatilidad"}},"yaxis":{"title":{"text":"Skewness"}},"zaxis":{"title":{"text":"Beta"}}},"scene9":{"domain":{"x":[0.624,0.792],"y":[0.0,0.375]},"xaxis":{"title":{"text":"Volatilidad"}},"yaxis":{"title":{"text":"Kurtosis"}},"zaxis":{"title":{"text":"Beta"}}},"scene10":{"domain":{"x":[0.832,1.0],"y":[0.0,0.375]},"xaxis":{"title":{"text":"Skewness"}},"yaxis":{"title":{"text":"Kurtosis"}},"zaxis":{"title":{"text":"Beta"}}},"annotations":[{"font":{"size":16},"showarrow":false,"text":"Retorno vs Volatilidad vs Skewness","x":0.08399999999999999,"xanchor":"center","xref":"paper","y":1.0,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Retorno vs Volatilidad vs Kurtosis","x":0.292,"xanchor":"center","xref":"paper","y":1.0,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Retorno vs Volatilidad vs Beta","x":0.5,"xanchor":"center","xref":"paper","y":1.0,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Retorno vs Skewness vs Kurtosis","x":0.708,"xanchor":"center","xref":"paper","y":1.0,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Retorno vs Skewness vs Beta","x":0.9159999999999999,"xanchor":"center","xref":"paper","y":1.0,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Retorno vs Kurtosis vs Beta","x":0.08399999999999999,"xanchor":"center","xref":"paper","y":0.375,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Volatilidad vs Skewness vs Kurtosis","x":0.292,"xanchor":"center","xref":"paper","y":0.375,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Volatilidad vs Skewness vs Beta","x":0.5,"xanchor":"center","xref":"paper","y":0.375,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Volatilidad vs Kurtosis vs Beta","x":0.708,"xanchor":"center","xref":"paper","y":0.375,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Skewness vs Kurtosis vs Beta","x":0.9159999999999999,"xanchor":"center","xref":"paper","y":0.375,"yanchor":"bottom","yref":"paper"}],"title":{"text":"Clustering K-Means 3D — Todas las combinaciones de indicadores"},"margin":{"l":0,"r":0,"t":50,"b":0},"height":800,"width":1700},                        {"responsive": true}                    ).then(function(){
    
    var gd = document.getElementById('44f81db7-9498-4a69-8bb8-76de41451c5f');
    var x = new MutationObserver(function (mutations, observer) {{
            var display = window.getComputedStyle(gd).display;
            if (!display || display === 'none') {{
                console.log([gd, 'removed!']);
                Plotly.purge(gd);
                observer.disconnect();
            }}
    }});
    
    // Listen for the removal of the full notebook cells
    var notebookContainer = gd.closest('#notebook-container');
    if (notebookContainer) {{
        x.observe(notebookContainer, {childList: true});
    }}
    
    // Listen for the clearing of the current output cell
    var outputEl = gd.closest('.output');
    if (outputEl) {{
        x.observe(outputEl, {childList: true});
    }}
    
                            })                };                            </script>        </div>
    </body>
    </html>


.. code:: ipython3

    def graficar_clusters(df, metodo, var_x='Volatilidad', var_y='Retorno'):
        plt.figure(figsize=(10, 6))
        sns.scatterplot(
            data=df,
            x=var_x,
            y=var_y,
            hue=f'Cluster_{metodo}',
            palette='Set1',
            s=120
        )
        for i in range(len(df)):
            plt.text(df[var_x].iloc[i] + 0.002, df[var_y].iloc[i], df.index[i], fontsize=9)
    
        plt.title(f'Clustering por {metodo}: {var_y} vs {var_x}')
        plt.xlabel(var_x)
        plt.ylabel(var_y)
        plt.legend(title='Cluster')
        plt.grid(True)
        plt.show()
    
    # Graficar cada método
    graficar_clusters(df_indicadores, 'KMeans')



.. image:: output_26_0.png


.. code:: ipython3

    # Clustering y variables en escala estandarizada:
    labels = kmeans.labels_
    X_scaled_df = pd.DataFrame(X_scaled, columns=df_indicadores.iloc[:,:-1].columns)
    X_scaled_df['Cluster_KMeans'] = labels

.. code:: ipython3

    import plotly.graph_objects as go
    
    # Columnas a usar
    cols = ['Retorno','Volatilidad','Skewness','Kurtosis','Beta']
    
    # Preparar datos y calcular promedio por cluster
    tmp = X_scaled_df.copy()
    tmp[cols] = tmp[cols].apply(pd.to_numeric, errors='coerce')
    agg = tmp.groupby('Cluster_KMeans')[cols].mean().sort_index()
    
    # Construir radar combinado
    cats = cols + [cols[0]]
    fig = go.Figure()
    
    for cl, row in agg.iterrows():
        vals = row.tolist()
        fig.add_trace(go.Scatterpolar(
            r=vals + [vals[0]],
            theta=cats,
            name=f'Cluster {cl}',
            fill='toself',
            opacity=0.30
        ))
    
    fig.update_layout(
        title='Radar combinado por cluster',
        template='plotly_white',
        polar=dict(radialaxis=dict(showline=False, gridcolor='lightgray'))
    )
    
    fig.show()



.. raw:: html

    <html>
    <head><meta charset="utf-8" /></head>
    <body>
        <div>            <script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-AMS-MML_SVG"></script><script type="text/javascript">if (window.MathJax && window.MathJax.Hub && window.MathJax.Hub.Config) {window.MathJax.Hub.Config({SVG: {font: "STIX-Web"}});}</script>                <script type="text/javascript">window.PlotlyConfig = {MathJaxConfig: 'local'};</script>
            <script charset="utf-8" src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>                <div id="73679886-1156-4990-9c53-1ce8fcaed196" class="plotly-graph-div" style="height:525px; width:100%;"></div>            <script type="text/javascript">                                    window.PLOTLYENV=window.PLOTLYENV || {};                                    if (document.getElementById("73679886-1156-4990-9c53-1ce8fcaed196")) {                    Plotly.newPlot(                        "73679886-1156-4990-9c53-1ce8fcaed196",                        [{"fill":"toself","name":"Cluster 0","opacity":0.3,"r":[-0.4606711434695353,-0.6175397961672076,-0.13644264362172065,-0.3779842883194895,-0.5698938352243947,-0.4606711434695353],"theta":["Retorno","Volatilidad","Skewness","Kurtosis","Beta","Retorno"],"type":"scatterpolar"},{"fill":"toself","name":"Cluster 1","opacity":0.3,"r":[1.8284648223450335,1.8457420780046947,0.595713304415607,-0.36557859290821976,1.7773691936201121,1.8284648223450335],"theta":["Retorno","Volatilidad","Skewness","Kurtosis","Beta","Retorno"],"type":"scatterpolar"},{"fill":"toself","name":"Cluster 2","opacity":0.3,"r":[0.12583259951721465,0.622697779039902,-0.0033463865411131333,1.5026328817195056,0.5191280692641993,0.12583259951721465],"theta":["Retorno","Volatilidad","Skewness","Kurtosis","Beta","Retorno"],"type":"scatterpolar"}],                        {"template":{"data":{"barpolar":[{"marker":{"line":{"color":"white","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"barpolar"}],"bar":[{"error_x":{"color":"#2a3f5f"},"error_y":{"color":"#2a3f5f"},"marker":{"line":{"color":"white","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"bar"}],"carpet":[{"aaxis":{"endlinecolor":"#2a3f5f","gridcolor":"#C8D4E3","linecolor":"#C8D4E3","minorgridcolor":"#C8D4E3","startlinecolor":"#2a3f5f"},"baxis":{"endlinecolor":"#2a3f5f","gridcolor":"#C8D4E3","linecolor":"#C8D4E3","minorgridcolor":"#C8D4E3","startlinecolor":"#2a3f5f"},"type":"carpet"}],"choropleth":[{"colorbar":{"outlinewidth":0,"ticks":""},"type":"choropleth"}],"contourcarpet":[{"colorbar":{"outlinewidth":0,"ticks":""},"type":"contourcarpet"}],"contour":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"contour"}],"heatmapgl":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"heatmapgl"}],"heatmap":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"heatmap"}],"histogram2dcontour":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"histogram2dcontour"}],"histogram2d":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"histogram2d"}],"histogram":[{"marker":{"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"histogram"}],"mesh3d":[{"colorbar":{"outlinewidth":0,"ticks":""},"type":"mesh3d"}],"parcoords":[{"line":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"parcoords"}],"pie":[{"automargin":true,"type":"pie"}],"scatter3d":[{"line":{"colorbar":{"outlinewidth":0,"ticks":""}},"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatter3d"}],"scattercarpet":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattercarpet"}],"scattergeo":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattergeo"}],"scattergl":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattergl"}],"scattermapbox":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattermapbox"}],"scatterpolargl":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatterpolargl"}],"scatterpolar":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatterpolar"}],"scatter":[{"fillpattern":{"fillmode":"overlay","size":10,"solidity":0.2},"type":"scatter"}],"scatterternary":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatterternary"}],"surface":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"surface"}],"table":[{"cells":{"fill":{"color":"#EBF0F8"},"line":{"color":"white"}},"header":{"fill":{"color":"#C8D4E3"},"line":{"color":"white"}},"type":"table"}]},"layout":{"annotationdefaults":{"arrowcolor":"#2a3f5f","arrowhead":0,"arrowwidth":1},"autotypenumbers":"strict","coloraxis":{"colorbar":{"outlinewidth":0,"ticks":""}},"colorscale":{"diverging":[[0,"#8e0152"],[0.1,"#c51b7d"],[0.2,"#de77ae"],[0.3,"#f1b6da"],[0.4,"#fde0ef"],[0.5,"#f7f7f7"],[0.6,"#e6f5d0"],[0.7,"#b8e186"],[0.8,"#7fbc41"],[0.9,"#4d9221"],[1,"#276419"]],"sequential":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"sequentialminus":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]},"colorway":["#636efa","#EF553B","#00cc96","#ab63fa","#FFA15A","#19d3f3","#FF6692","#B6E880","#FF97FF","#FECB52"],"font":{"color":"#2a3f5f"},"geo":{"bgcolor":"white","lakecolor":"white","landcolor":"white","showlakes":true,"showland":true,"subunitcolor":"#C8D4E3"},"hoverlabel":{"align":"left"},"hovermode":"closest","mapbox":{"style":"light"},"paper_bgcolor":"white","plot_bgcolor":"white","polar":{"angularaxis":{"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":""},"bgcolor":"white","radialaxis":{"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":""}},"scene":{"xaxis":{"backgroundcolor":"white","gridcolor":"#DFE8F3","gridwidth":2,"linecolor":"#EBF0F8","showbackground":true,"ticks":"","zerolinecolor":"#EBF0F8"},"yaxis":{"backgroundcolor":"white","gridcolor":"#DFE8F3","gridwidth":2,"linecolor":"#EBF0F8","showbackground":true,"ticks":"","zerolinecolor":"#EBF0F8"},"zaxis":{"backgroundcolor":"white","gridcolor":"#DFE8F3","gridwidth":2,"linecolor":"#EBF0F8","showbackground":true,"ticks":"","zerolinecolor":"#EBF0F8"}},"shapedefaults":{"line":{"color":"#2a3f5f"}},"ternary":{"aaxis":{"gridcolor":"#DFE8F3","linecolor":"#A2B1C6","ticks":""},"baxis":{"gridcolor":"#DFE8F3","linecolor":"#A2B1C6","ticks":""},"bgcolor":"white","caxis":{"gridcolor":"#DFE8F3","linecolor":"#A2B1C6","ticks":""}},"title":{"x":0.05},"xaxis":{"automargin":true,"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":"","title":{"standoff":15},"zerolinecolor":"#EBF0F8","zerolinewidth":2},"yaxis":{"automargin":true,"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":"","title":{"standoff":15},"zerolinecolor":"#EBF0F8","zerolinewidth":2}}},"polar":{"radialaxis":{"showline":false,"gridcolor":"lightgray"}},"title":{"text":"Radar combinado por cluster"}},                        {"responsive": true}                    ).then(function(){
    
    var gd = document.getElementById('73679886-1156-4990-9c53-1ce8fcaed196');
    var x = new MutationObserver(function (mutations, observer) {{
            var display = window.getComputedStyle(gd).display;
            if (!display || display === 'none') {{
                console.log([gd, 'removed!']);
                Plotly.purge(gd);
                observer.disconnect();
            }}
    }});
    
    // Listen for the removal of the full notebook cells
    var notebookContainer = gd.closest('#notebook-container');
    if (notebookContainer) {{
        x.observe(notebookContainer, {childList: true});
    }}
    
    // Listen for the clearing of the current output cell
    var outputEl = gd.closest('.output');
    if (outputEl) {{
        x.observe(outputEl, {childList: true});
    }}
    
                            })                };                            </script>        </div>
    </body>
    </html>


.. code:: ipython3

    import math
    
    def boxplots_por_cluster(df):
        """
        Genera boxplots para cada variable numérica en df agrupando por Cluster_KMeans,
        mostrando 3 gráficos por fila.
    
        Parámetros:
        -----------
        df : pandas.DataFrame
            DataFrame con las columnas numéricas y la columna 'Cluster_KMeans'.
        """
    
        # Variables numéricas (todas menos Cluster_KMeans)
        variables_numericas = [col for col in df.columns if col != 'Cluster_KMeans']
    
        # Número de filas necesarias (3 gráficos por fila)
        n_vars = len(variables_numericas)
        n_cols = 3
        n_rows = math.ceil(n_vars / n_cols)
    
        # Crear figura
        fig, axes = plt.subplots(n_rows, n_cols, figsize=(n_cols * 5, n_rows * 4))
        axes = axes.flatten()
    
        for i, col in enumerate(variables_numericas):
            sns.boxplot(
                data=df,
                x='Cluster_KMeans',
                y=col,
                hue='Cluster_KMeans',   # Para evitar el FutureWarning
                palette='Set2',
                legend=False,
                ax=axes[i]
            )
            axes[i].set_title(f'Boxplot de {col} por Cluster', fontsize=12)
            axes[i].set_xlabel('Cluster')
            axes[i].set_ylabel(col)
    
        # Ocultar ejes vacíos si sobran
        for j in range(i+1, len(axes)):
            axes[j].axis('off')
    
        plt.tight_layout()
        plt.show()

.. code:: ipython3

    boxplots_por_cluster(df_indicadores)



.. image:: output_30_0.png


**¿Cómo cambian los resultados con 3 clusters?**

**¿Cómo cambian los resultados con solo las variables Skewness y
Kurtosis?**

**Analizar CMR con BA**

**¿Qué tiene de característico NFLX?**

**¿Es posible agrupar en un mismo clusters las acciones de baja
volatilidad y rendimientos con las acciones más agresivas?**
