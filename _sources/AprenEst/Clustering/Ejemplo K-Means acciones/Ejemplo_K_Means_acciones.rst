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

    
      <div id="df-684bb2f3-9576-4cab-bb0a-60e84cd806a8" class="colab-df-container">
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
          <td>168.308615</td>
          <td>111.604426</td>
          <td>157.696810</td>
          <td>192.557214</td>
          <td>234.247296</td>
          <td>130.157316</td>
          <td>149.466887</td>
          <td>56.029759</td>
          <td>398.977754</td>
          <td>351.281435</td>
          <td>...</td>
          <td>555.438689</td>
          <td>106.611316</td>
          <td>53.068235</td>
          <td>149.308492</td>
          <td>141.179570</td>
          <td>246.167060</td>
          <td>444.539699</td>
          <td>242.295024</td>
          <td>56.554209</td>
          <td>4591.564901</td>
        </tr>
        <tr>
          <th>std</th>
          <td>37.929747</td>
          <td>32.599924</td>
          <td>35.406763</td>
          <td>31.330118</td>
          <td>48.640248</td>
          <td>32.428266</td>
          <td>10.006480</td>
          <td>8.197990</td>
          <td>82.631457</td>
          <td>165.833285</td>
          <td>...</td>
          <td>256.862147</td>
          <td>26.270570</td>
          <td>47.606693</td>
          <td>17.191154</td>
          <td>16.928582</td>
          <td>67.619500</td>
          <td>87.096897</td>
          <td>50.604568</td>
          <td>18.592934</td>
          <td>813.091153</td>
        </tr>
        <tr>
          <th>min</th>
          <td>103.174988</td>
          <td>60.060001</td>
          <td>84.000000</td>
          <td>121.080002</td>
          <td>131.438263</td>
          <td>72.843147</td>
          <td>119.756897</td>
          <td>40.592743</td>
          <td>279.303223</td>
          <td>92.651711</td>
          <td>...</td>
          <td>174.869995</td>
          <td>56.027664</td>
          <td>10.579878</td>
          <td>112.904663</td>
          <td>110.428238</td>
          <td>95.384003</td>
          <td>249.559998</td>
          <td>173.941269</td>
          <td>38.925198</td>
          <td>3269.959961</td>
        </tr>
        <tr>
          <th>25%</th>
          <td>138.524857</td>
          <td>85.519997</td>
          <td>133.089996</td>
          <td>171.820007</td>
          <td>201.018555</td>
          <td>103.111610</td>
          <td>144.014465</td>
          <td>50.373856</td>
          <td>346.991211</td>
          <td>252.285950</td>
          <td>...</td>
          <td>394.519989</td>
          <td>88.638329</td>
          <td>16.206350</td>
          <td>134.108490</td>
          <td>127.865417</td>
          <td>201.880005</td>
          <td>386.012970</td>
          <td>206.977966</td>
          <td>44.427788</td>
          <td>4076.600098</td>
        </tr>
        <tr>
          <th>50%</th>
          <td>167.575699</td>
          <td>102.900002</td>
          <td>160.309998</td>
          <td>194.190002</td>
          <td>236.031738</td>
          <td>131.928772</td>
          <td>151.222549</td>
          <td>56.363876</td>
          <td>364.622559</td>
          <td>316.861694</td>
          <td>...</td>
          <td>517.570007</td>
          <td>105.146385</td>
          <td>27.729067</td>
          <td>153.950897</td>
          <td>140.274200</td>
          <td>240.080002</td>
          <td>472.730499</td>
          <td>225.907791</td>
          <td>47.599209</td>
          <td>4395.259766</td>
        </tr>
        <tr>
          <th>75%</th>
          <td>191.829483</td>
          <td>137.179993</td>
          <td>176.759995</td>
          <td>212.009995</td>
          <td>267.514801</td>
          <td>154.275345</td>
          <td>155.431351</td>
          <td>59.936264</td>
          <td>447.335175</td>
          <td>473.209656</td>
          <td>...</td>
          <td>641.619995</td>
          <td>125.442940</td>
          <td>90.315811</td>
          <td>161.462906</td>
          <td>155.858002</td>
          <td>282.160004</td>
          <td>498.170715</td>
          <td>269.993927</td>
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
          <td>177.486221</td>
          <td>175.867111</td>
          <td>404.600006</td>
          <td>601.015320</td>
          <td>364.584503</td>
          <td>98.481895</td>
          <td>6339.390137</td>
        </tr>
      </tbody>
    </table>
    <p>8 rows × 21 columns</p>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-684bb2f3-9576-4cab-bb0a-60e84cd806a8')"
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
            document.querySelector('#df-684bb2f3-9576-4cab-bb0a-60e84cd806a8 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-684bb2f3-9576-4cab-bb0a-60e84cd806a8');
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
    
    
        <div id="df-8ae45890-0721-4a05-9f43-3a31fe3fccc8">
          <button class="colab-df-quickchart" onclick="quickchart('df-8ae45890-0721-4a05-9f43-3a31fe3fccc8')"
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
                document.querySelector('#df-8ae45890-0721-4a05-9f43-3a31fe3fccc8 button');
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

    
      <div id="df-a45e5af5-6237-4f14-a75b-4db83cc0410d" class="colab-df-container">
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
          <td>1.361422</td>
          <td>0.589540</td>
        </tr>
        <tr>
          <th>min</th>
          <td>0.001234</td>
          <td>0.045147</td>
          <td>-1.143828</td>
          <td>-0.827875</td>
          <td>0.392902</td>
        </tr>
        <tr>
          <th>25%</th>
          <td>0.008797</td>
          <td>0.062848</td>
          <td>-0.288276</td>
          <td>-0.358964</td>
          <td>0.615435</td>
        </tr>
        <tr>
          <th>50%</th>
          <td>0.012891</td>
          <td>0.079984</td>
          <td>0.123931</td>
          <td>-0.230198</td>
          <td>1.125788</td>
        </tr>
        <tr>
          <th>75%</th>
          <td>0.020063</td>
          <td>0.119030</td>
          <td>0.306697</td>
          <td>1.171873</td>
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
        <button class="colab-df-convert" onclick="convertToInteractive('df-a45e5af5-6237-4f14-a75b-4db83cc0410d')"
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
            document.querySelector('#df-a45e5af5-6237-4f14-a75b-4db83cc0410d button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-a45e5af5-6237-4f14-a75b-4db83cc0410d');
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
    
    
        <div id="df-66de2433-7e4e-4a52-b0c8-bc4e47542dca">
          <button class="colab-df-quickchart" onclick="quickchart('df-66de2433-7e4e-4a52-b0c8-bc4e47542dca')"
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
                document.querySelector('#df-66de2433-7e4e-4a52-b0c8-bc4e47542dca button');
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
            <script charset="utf-8" src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>                <div id="69509dd6-3598-4090-b60d-3ae562eed49e" class="plotly-graph-div" style="height:525px; width:100%;"></div>            <script type="text/javascript">                                    window.PLOTLYENV=window.PLOTLYENV || {};                                    if (document.getElementById("69509dd6-3598-4090-b60d-3ae562eed49e")) {                    Plotly.newPlot(                        "69509dd6-3598-4090-b60d-3ae562eed49e",                        [{"hovertemplate":"Retorno=%{x}\u003cbr\u003eVolatilidad=%{y}\u003cbr\u003eSkewness=%{z}\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"","marker":{"color":"#636efa","opacity":0.7,"symbol":"circle"},"mode":"markers","name":"","scene":"scene","showlegend":false,"x":[0.0055360377307255215,0.005605825189593203,0.009860104187842366,0.0035075191350978437,0.01660528329335468,0.014536225751129598,0.018846418454461944,0.012591925806074397,0.013191028544313973,0.001524013632579041,0.03809734988746194,0.058649546070346906,0.02612807895911395,0.010465407311522769,0.0230316954004244,0.01907351657041888,0.024503284234396915,0.010313605199926369,0.012288864600601359,0.0012335942981166377],"y":[0.047865481608498996,0.05074454234491011,0.05053797171667538,0.04514737087810372,0.057590085394082405,0.07689752919754603,0.06541335508045978,0.06460062201698438,0.07218754792434143,0.08163781279712175,0.20340861271350252,0.1480524919709031,0.11925611739529647,0.08963434590557022,0.12366013103794612,0.07833045689423043,0.15012414510601715,0.10873050360492736,0.11895405452210038,0.09572767385166961],"z":[0.06244367709632314,0.3028997539111445,-0.094054752535747,0.38978063122536427,-0.3231300544310648,0.31808734938509325,0.2341142992473735,0.23858735410411328,0.03118116043255225,-0.8649852082576377,0.9309062847532191,-0.09646900266117608,-0.5437784851976886,0.1854192017934314,-1.1438277524218965,-0.5040497840998854,0.29940666936614657,1.035205499635493,0.8516051445061544,-0.27665824849737153],"type":"scatter3d"}],                        {"template":{"data":{"histogram2dcontour":[{"type":"histogram2dcontour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"choropleth":[{"type":"choropleth","colorbar":{"outlinewidth":0,"ticks":""}}],"histogram2d":[{"type":"histogram2d","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmap":[{"type":"heatmap","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmapgl":[{"type":"heatmapgl","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"contourcarpet":[{"type":"contourcarpet","colorbar":{"outlinewidth":0,"ticks":""}}],"contour":[{"type":"contour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"surface":[{"type":"surface","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"mesh3d":[{"type":"mesh3d","colorbar":{"outlinewidth":0,"ticks":""}}],"scatter":[{"fillpattern":{"fillmode":"overlay","size":10,"solidity":0.2},"type":"scatter"}],"parcoords":[{"type":"parcoords","line":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolargl":[{"type":"scatterpolargl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"bar":[{"error_x":{"color":"#2a3f5f"},"error_y":{"color":"#2a3f5f"},"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"bar"}],"scattergeo":[{"type":"scattergeo","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolar":[{"type":"scatterpolar","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"histogram":[{"marker":{"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"histogram"}],"scattergl":[{"type":"scattergl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatter3d":[{"type":"scatter3d","line":{"colorbar":{"outlinewidth":0,"ticks":""}},"marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattermapbox":[{"type":"scattermapbox","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterternary":[{"type":"scatterternary","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattercarpet":[{"type":"scattercarpet","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"carpet":[{"aaxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"baxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"type":"carpet"}],"table":[{"cells":{"fill":{"color":"#EBF0F8"},"line":{"color":"white"}},"header":{"fill":{"color":"#C8D4E3"},"line":{"color":"white"}},"type":"table"}],"barpolar":[{"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"barpolar"}],"pie":[{"automargin":true,"type":"pie"}]},"layout":{"autotypenumbers":"strict","colorway":["#636efa","#EF553B","#00cc96","#ab63fa","#FFA15A","#19d3f3","#FF6692","#B6E880","#FF97FF","#FECB52"],"font":{"color":"#2a3f5f"},"hovermode":"closest","hoverlabel":{"align":"left"},"paper_bgcolor":"white","plot_bgcolor":"#E5ECF6","polar":{"bgcolor":"#E5ECF6","angularaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"radialaxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"ternary":{"bgcolor":"#E5ECF6","aaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"baxis":{"gridcolor":"white","linecolor":"white","ticks":""},"caxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"coloraxis":{"colorbar":{"outlinewidth":0,"ticks":""}},"colorscale":{"sequential":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"sequentialminus":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"diverging":[[0,"#8e0152"],[0.1,"#c51b7d"],[0.2,"#de77ae"],[0.3,"#f1b6da"],[0.4,"#fde0ef"],[0.5,"#f7f7f7"],[0.6,"#e6f5d0"],[0.7,"#b8e186"],[0.8,"#7fbc41"],[0.9,"#4d9221"],[1,"#276419"]]},"xaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"yaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"scene":{"xaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"yaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"zaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2}},"shapedefaults":{"line":{"color":"#2a3f5f"}},"annotationdefaults":{"arrowcolor":"#2a3f5f","arrowhead":0,"arrowwidth":1},"geo":{"bgcolor":"white","landcolor":"#E5ECF6","subunitcolor":"white","showland":true,"showlakes":true,"lakecolor":"white"},"title":{"x":0.05},"mapbox":{"style":"light"}}},"scene":{"domain":{"x":[0.0,1.0],"y":[0.0,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Volatilidad"}},"zaxis":{"title":{"text":"Skewness"}}},"legend":{"tracegroupgap":0},"title":{"text":"Indicadores Financieros 3D"}},                        {"responsive": true}                    ).then(function(){
    
    var gd = document.getElementById('69509dd6-3598-4090-b60d-3ae562eed49e');
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

    # Visualización 3D de los indicadores usando px.scatter_3d:
    import plotly.express as px
    
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
            <script charset="utf-8" src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>                <div id="7b97494c-45a4-49d1-8dd4-da5881ac2c9e" class="plotly-graph-div" style="height:525px; width:100%;"></div>            <script type="text/javascript">                                    window.PLOTLYENV=window.PLOTLYENV || {};                                    if (document.getElementById("7b97494c-45a4-49d1-8dd4-da5881ac2c9e")) {                    Plotly.newPlot(                        "7b97494c-45a4-49d1-8dd4-da5881ac2c9e",                        [{"hovertemplate":"Retorno=%{x}\u003cbr\u003eVolatilidad=%{y}\u003cbr\u003eSkewness=%{z}\u003cbr\u003eBeta=%{marker.color}\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"","marker":{"color":[0.39579347364014383,0.39290219590652387,0.4449534543572333,0.4710814099145239,0.6635529042570006,1.182855141664556,1.0687218435912713,0.9530873442312635,1.049499144868662,0.44851890955204166,2.369969764285585,2.1805766961918795,1.294872355450701,1.3358859138819594,1.616112509274086,1.0307162782674684,1.9728141285747292,1.3941045758178592,1.500719593021173,1.2963567044469808],"coloraxis":"coloraxis","opacity":0.7,"symbol":"circle"},"mode":"markers","name":"","scene":"scene","showlegend":false,"x":[0.0055360377307255215,0.005605825189593203,0.009860104187842366,0.0035075191350978437,0.01660528329335468,0.014536225751129598,0.018846418454461944,0.012591925806074397,0.013191028544313973,0.001524013632579041,0.03809734988746194,0.058649546070346906,0.02612807895911395,0.010465407311522769,0.0230316954004244,0.01907351657041888,0.024503284234396915,0.010313605199926369,0.012288864600601359,0.0012335942981166377],"y":[0.047865481608498996,0.05074454234491011,0.05053797171667538,0.04514737087810372,0.057590085394082405,0.07689752919754603,0.06541335508045978,0.06460062201698438,0.07218754792434143,0.08163781279712175,0.20340861271350252,0.1480524919709031,0.11925611739529647,0.08963434590557022,0.12366013103794612,0.07833045689423043,0.15012414510601715,0.10873050360492736,0.11895405452210038,0.09572767385166961],"z":[0.06244367709632314,0.3028997539111445,-0.094054752535747,0.38978063122536427,-0.3231300544310648,0.31808734938509325,0.2341142992473735,0.23858735410411328,0.03118116043255225,-0.8649852082576377,0.9309062847532191,-0.09646900266117608,-0.5437784851976886,0.1854192017934314,-1.1438277524218965,-0.5040497840998854,0.29940666936614657,1.035205499635493,0.8516051445061544,-0.27665824849737153],"type":"scatter3d"}],                        {"template":{"data":{"histogram2dcontour":[{"type":"histogram2dcontour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"choropleth":[{"type":"choropleth","colorbar":{"outlinewidth":0,"ticks":""}}],"histogram2d":[{"type":"histogram2d","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmap":[{"type":"heatmap","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmapgl":[{"type":"heatmapgl","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"contourcarpet":[{"type":"contourcarpet","colorbar":{"outlinewidth":0,"ticks":""}}],"contour":[{"type":"contour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"surface":[{"type":"surface","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"mesh3d":[{"type":"mesh3d","colorbar":{"outlinewidth":0,"ticks":""}}],"scatter":[{"fillpattern":{"fillmode":"overlay","size":10,"solidity":0.2},"type":"scatter"}],"parcoords":[{"type":"parcoords","line":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolargl":[{"type":"scatterpolargl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"bar":[{"error_x":{"color":"#2a3f5f"},"error_y":{"color":"#2a3f5f"},"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"bar"}],"scattergeo":[{"type":"scattergeo","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolar":[{"type":"scatterpolar","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"histogram":[{"marker":{"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"histogram"}],"scattergl":[{"type":"scattergl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatter3d":[{"type":"scatter3d","line":{"colorbar":{"outlinewidth":0,"ticks":""}},"marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattermapbox":[{"type":"scattermapbox","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterternary":[{"type":"scatterternary","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattercarpet":[{"type":"scattercarpet","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"carpet":[{"aaxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"baxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"type":"carpet"}],"table":[{"cells":{"fill":{"color":"#EBF0F8"},"line":{"color":"white"}},"header":{"fill":{"color":"#C8D4E3"},"line":{"color":"white"}},"type":"table"}],"barpolar":[{"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"barpolar"}],"pie":[{"automargin":true,"type":"pie"}]},"layout":{"autotypenumbers":"strict","colorway":["#636efa","#EF553B","#00cc96","#ab63fa","#FFA15A","#19d3f3","#FF6692","#B6E880","#FF97FF","#FECB52"],"font":{"color":"#2a3f5f"},"hovermode":"closest","hoverlabel":{"align":"left"},"paper_bgcolor":"white","plot_bgcolor":"#E5ECF6","polar":{"bgcolor":"#E5ECF6","angularaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"radialaxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"ternary":{"bgcolor":"#E5ECF6","aaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"baxis":{"gridcolor":"white","linecolor":"white","ticks":""},"caxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"coloraxis":{"colorbar":{"outlinewidth":0,"ticks":""}},"colorscale":{"sequential":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"sequentialminus":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"diverging":[[0,"#8e0152"],[0.1,"#c51b7d"],[0.2,"#de77ae"],[0.3,"#f1b6da"],[0.4,"#fde0ef"],[0.5,"#f7f7f7"],[0.6,"#e6f5d0"],[0.7,"#b8e186"],[0.8,"#7fbc41"],[0.9,"#4d9221"],[1,"#276419"]]},"xaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"yaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"scene":{"xaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"yaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"zaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2}},"shapedefaults":{"line":{"color":"#2a3f5f"}},"annotationdefaults":{"arrowcolor":"#2a3f5f","arrowhead":0,"arrowwidth":1},"geo":{"bgcolor":"white","landcolor":"#E5ECF6","subunitcolor":"white","showland":true,"showlakes":true,"lakecolor":"white"},"title":{"x":0.05},"mapbox":{"style":"light"}}},"scene":{"domain":{"x":[0.0,1.0],"y":[0.0,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Volatilidad"}},"zaxis":{"title":{"text":"Skewness"}}},"coloraxis":{"colorbar":{"title":{"text":"Beta"}},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]},"legend":{"tracegroupgap":0},"title":{"text":"Indicadores Financieros 3D"}},                        {"responsive": true}                    ).then(function(){
    
    var gd = document.getElementById('7b97494c-45a4-49d1-8dd4-da5881ac2c9e');
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
    Inercia: 43.04523287392369
    Puntuación de la Silueta: 0.38199688271418986
    

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
            <script charset="utf-8" src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>                <div id="4ba7cd57-abe3-49c9-9b4d-8489ecde2176" class="plotly-graph-div" style="height:525px; width:100%;"></div>            <script type="text/javascript">                                    window.PLOTLYENV=window.PLOTLYENV || {};                                    if (document.getElementById("4ba7cd57-abe3-49c9-9b4d-8489ecde2176")) {                    Plotly.newPlot(                        "4ba7cd57-abe3-49c9-9b4d-8489ecde2176",                        [{"hovertemplate":"Retorno=%{x}\u003cbr\u003eVolatilidad=%{y}\u003cbr\u003eBeta=%{z}\u003cbr\u003eCluster_KMeans=%{marker.color}\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"","marker":{"color":[0,0,0,0,0,0,0,0,0,0,1,1,2,0,2,0,1,2,2,0],"coloraxis":"coloraxis","opacity":0.7,"symbol":"circle"},"mode":"markers","name":"","scene":"scene","showlegend":false,"x":[0.0055360377307255215,0.005605825189593203,0.009860104187842366,0.0035075191350978437,0.01660528329335468,0.014536225751129598,0.018846418454461944,0.012591925806074397,0.013191028544313973,0.001524013632579041,0.03809734988746194,0.058649546070346906,0.02612807895911395,0.010465407311522769,0.0230316954004244,0.01907351657041888,0.024503284234396915,0.010313605199926369,0.012288864600601359,0.0012335942981166377],"y":[0.047865481608498996,0.05074454234491011,0.05053797171667538,0.04514737087810372,0.057590085394082405,0.07689752919754603,0.06541335508045978,0.06460062201698438,0.07218754792434143,0.08163781279712175,0.20340861271350252,0.1480524919709031,0.11925611739529647,0.08963434590557022,0.12366013103794612,0.07833045689423043,0.15012414510601715,0.10873050360492736,0.11895405452210038,0.09572767385166961],"z":[0.39579347364014383,0.39290219590652387,0.4449534543572333,0.4710814099145239,0.6635529042570006,1.182855141664556,1.0687218435912713,0.9530873442312635,1.049499144868662,0.44851890955204166,2.369969764285585,2.1805766961918795,1.294872355450701,1.3358859138819594,1.616112509274086,1.0307162782674684,1.9728141285747292,1.3941045758178592,1.500719593021173,1.2963567044469808],"type":"scatter3d"}],                        {"template":{"data":{"histogram2dcontour":[{"type":"histogram2dcontour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"choropleth":[{"type":"choropleth","colorbar":{"outlinewidth":0,"ticks":""}}],"histogram2d":[{"type":"histogram2d","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmap":[{"type":"heatmap","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmapgl":[{"type":"heatmapgl","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"contourcarpet":[{"type":"contourcarpet","colorbar":{"outlinewidth":0,"ticks":""}}],"contour":[{"type":"contour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"surface":[{"type":"surface","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"mesh3d":[{"type":"mesh3d","colorbar":{"outlinewidth":0,"ticks":""}}],"scatter":[{"fillpattern":{"fillmode":"overlay","size":10,"solidity":0.2},"type":"scatter"}],"parcoords":[{"type":"parcoords","line":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolargl":[{"type":"scatterpolargl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"bar":[{"error_x":{"color":"#2a3f5f"},"error_y":{"color":"#2a3f5f"},"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"bar"}],"scattergeo":[{"type":"scattergeo","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolar":[{"type":"scatterpolar","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"histogram":[{"marker":{"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"histogram"}],"scattergl":[{"type":"scattergl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatter3d":[{"type":"scatter3d","line":{"colorbar":{"outlinewidth":0,"ticks":""}},"marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattermapbox":[{"type":"scattermapbox","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterternary":[{"type":"scatterternary","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattercarpet":[{"type":"scattercarpet","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"carpet":[{"aaxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"baxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"type":"carpet"}],"table":[{"cells":{"fill":{"color":"#EBF0F8"},"line":{"color":"white"}},"header":{"fill":{"color":"#C8D4E3"},"line":{"color":"white"}},"type":"table"}],"barpolar":[{"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"barpolar"}],"pie":[{"automargin":true,"type":"pie"}]},"layout":{"autotypenumbers":"strict","colorway":["#636efa","#EF553B","#00cc96","#ab63fa","#FFA15A","#19d3f3","#FF6692","#B6E880","#FF97FF","#FECB52"],"font":{"color":"#2a3f5f"},"hovermode":"closest","hoverlabel":{"align":"left"},"paper_bgcolor":"white","plot_bgcolor":"#E5ECF6","polar":{"bgcolor":"#E5ECF6","angularaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"radialaxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"ternary":{"bgcolor":"#E5ECF6","aaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"baxis":{"gridcolor":"white","linecolor":"white","ticks":""},"caxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"coloraxis":{"colorbar":{"outlinewidth":0,"ticks":""}},"colorscale":{"sequential":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"sequentialminus":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"diverging":[[0,"#8e0152"],[0.1,"#c51b7d"],[0.2,"#de77ae"],[0.3,"#f1b6da"],[0.4,"#fde0ef"],[0.5,"#f7f7f7"],[0.6,"#e6f5d0"],[0.7,"#b8e186"],[0.8,"#7fbc41"],[0.9,"#4d9221"],[1,"#276419"]]},"xaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"yaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"scene":{"xaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"yaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"zaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2}},"shapedefaults":{"line":{"color":"#2a3f5f"}},"annotationdefaults":{"arrowcolor":"#2a3f5f","arrowhead":0,"arrowwidth":1},"geo":{"bgcolor":"white","landcolor":"#E5ECF6","subunitcolor":"white","showland":true,"showlakes":true,"lakecolor":"white"},"title":{"x":0.05},"mapbox":{"style":"light"}}},"scene":{"domain":{"x":[0.0,1.0],"y":[0.0,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Volatilidad"}},"zaxis":{"title":{"text":"Beta"}}},"coloraxis":{"colorbar":{"title":{"text":"Cluster_KMeans"}},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]},"legend":{"tracegroupgap":0},"title":{"text":"Clustering K-Means 3D"}},                        {"responsive": true}                    ).then(function(){
    
    var gd = document.getElementById('4ba7cd57-abe3-49c9-9b4d-8489ecde2176');
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
            <script charset="utf-8" src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>                <div id="fd33d6c4-33f4-4478-9005-ba6c28646225" class="plotly-graph-div" style="height:800px; width:1700px;"></div>            <script type="text/javascript">                                    window.PLOTLYENV=window.PLOTLYENV || {};                                    if (document.getElementById("fd33d6c4-33f4-4478-9005-ba6c28646225")) {                    Plotly.newPlot(                        "fd33d6c4-33f4-4478-9005-ba6c28646225",                        [{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eSkewness: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":true,"x":[0.0055360377307255215,0.005605825189593203,0.009860104187842366,0.0035075191350978437,0.01660528329335468,0.014536225751129598,0.018846418454461944,0.012591925806074397,0.013191028544313973,0.001524013632579041,0.010465407311522769,0.01907351657041888,0.0012335942981166377],"y":[0.047865481608498996,0.05074454234491011,0.05053797171667538,0.04514737087810372,0.057590085394082405,0.07689752919754603,0.06541335508045978,0.06460062201698438,0.07218754792434143,0.08163781279712175,0.08963434590557022,0.07833045689423043,0.09572767385166961],"z":[0.06244367709632314,0.3028997539111445,-0.094054752535747,0.38978063122536427,-0.3231300544310648,0.31808734938509325,0.2341142992473735,0.23858735410411328,0.03118116043255225,-0.8649852082576377,0.1854192017934314,-0.5040497840998854,-0.27665824849737153],"type":"scatter3d","scene":"scene"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eSkewness: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":true,"x":[0.03809734988746194,0.058649546070346906,0.024503284234396915],"y":[0.20340861271350252,0.1480524919709031,0.15012414510601715],"z":[0.9309062847532191,-0.09646900266117608,0.29940666936614657],"type":"scatter3d","scene":"scene"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eSkewness: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":true,"x":[0.02612807895911395,0.0230316954004244,0.010313605199926369,0.012288864600601359],"y":[0.11925611739529647,0.12366013103794612,0.10873050360492736,0.11895405452210038],"z":[-0.5437784851976886,-1.1438277524218965,1.035205499635493,0.8516051445061544],"type":"scatter3d","scene":"scene"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.0055360377307255215,0.005605825189593203,0.009860104187842366,0.0035075191350978437,0.01660528329335468,0.014536225751129598,0.018846418454461944,0.012591925806074397,0.013191028544313973,0.001524013632579041,0.010465407311522769,0.01907351657041888,0.0012335942981166377],"y":[0.047865481608498996,0.05074454234491011,0.05053797171667538,0.04514737087810372,0.057590085394082405,0.07689752919754603,0.06541335508045978,0.06460062201698438,0.07218754792434143,0.08163781279712175,0.08963434590557022,0.07833045689423043,0.09572767385166961],"z":[-0.6934772783887935,-0.34296632505779057,0.42528535757147434,-0.20954025267919896,0.5555261994915579,-0.43179603611033945,-0.3329879150014916,-0.42839438063567226,-0.25085489425745466,2.01512869737051,0.8367631114206882,-0.2881777725752239,-0.3168292873754881],"type":"scatter3d","scene":"scene2"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.03809734988746194,0.058649546070346906,0.024503284234396915],"y":[0.20340861271350252,0.1480524919709031,0.15012414510601715],"z":[1.4082977795115847,-0.4069583840755402,-0.8278754240318706],"type":"scatter3d","scene":"scene2"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.02612807895911395,0.0230316954004244,0.010313605199926369,0.012288864600601359],"y":[0.11925611739529647,0.12366013103794612,0.10873050360492736,0.11895405452210038],"z":[1.0930649758426898,4.428853906419347,2.038903140508085,2.5865659541656494],"type":"scatter3d","scene":"scene2"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.0055360377307255215,0.005605825189593203,0.009860104187842366,0.0035075191350978437,0.01660528329335468,0.014536225751129598,0.018846418454461944,0.012591925806074397,0.013191028544313973,0.001524013632579041,0.010465407311522769,0.01907351657041888,0.0012335942981166377],"y":[0.047865481608498996,0.05074454234491011,0.05053797171667538,0.04514737087810372,0.057590085394082405,0.07689752919754603,0.06541335508045978,0.06460062201698438,0.07218754792434143,0.08163781279712175,0.08963434590557022,0.07833045689423043,0.09572767385166961],"z":[0.39579347364014383,0.39290219590652387,0.4449534543572333,0.4710814099145239,0.6635529042570006,1.182855141664556,1.0687218435912713,0.9530873442312635,1.049499144868662,0.44851890955204166,1.3358859138819594,1.0307162782674684,1.2963567044469808],"type":"scatter3d","scene":"scene3"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.03809734988746194,0.058649546070346906,0.024503284234396915],"y":[0.20340861271350252,0.1480524919709031,0.15012414510601715],"z":[2.369969764285585,2.1805766961918795,1.9728141285747292],"type":"scatter3d","scene":"scene3"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eVolatilidad: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.02612807895911395,0.0230316954004244,0.010313605199926369,0.012288864600601359],"y":[0.11925611739529647,0.12366013103794612,0.10873050360492736,0.11895405452210038],"z":[1.294872355450701,1.616112509274086,1.3941045758178592,1.500719593021173],"type":"scatter3d","scene":"scene3"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.0055360377307255215,0.005605825189593203,0.009860104187842366,0.0035075191350978437,0.01660528329335468,0.014536225751129598,0.018846418454461944,0.012591925806074397,0.013191028544313973,0.001524013632579041,0.010465407311522769,0.01907351657041888,0.0012335942981166377],"y":[0.06244367709632314,0.3028997539111445,-0.094054752535747,0.38978063122536427,-0.3231300544310648,0.31808734938509325,0.2341142992473735,0.23858735410411328,0.03118116043255225,-0.8649852082576377,0.1854192017934314,-0.5040497840998854,-0.27665824849737153],"z":[-0.6934772783887935,-0.34296632505779057,0.42528535757147434,-0.20954025267919896,0.5555261994915579,-0.43179603611033945,-0.3329879150014916,-0.42839438063567226,-0.25085489425745466,2.01512869737051,0.8367631114206882,-0.2881777725752239,-0.3168292873754881],"type":"scatter3d","scene":"scene4"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.03809734988746194,0.058649546070346906,0.024503284234396915],"y":[0.9309062847532191,-0.09646900266117608,0.29940666936614657],"z":[1.4082977795115847,-0.4069583840755402,-0.8278754240318706],"type":"scatter3d","scene":"scene4"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.02612807895911395,0.0230316954004244,0.010313605199926369,0.012288864600601359],"y":[-0.5437784851976886,-1.1438277524218965,1.035205499635493,0.8516051445061544],"z":[1.0930649758426898,4.428853906419347,2.038903140508085,2.5865659541656494],"type":"scatter3d","scene":"scene4"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.0055360377307255215,0.005605825189593203,0.009860104187842366,0.0035075191350978437,0.01660528329335468,0.014536225751129598,0.018846418454461944,0.012591925806074397,0.013191028544313973,0.001524013632579041,0.010465407311522769,0.01907351657041888,0.0012335942981166377],"y":[0.06244367709632314,0.3028997539111445,-0.094054752535747,0.38978063122536427,-0.3231300544310648,0.31808734938509325,0.2341142992473735,0.23858735410411328,0.03118116043255225,-0.8649852082576377,0.1854192017934314,-0.5040497840998854,-0.27665824849737153],"z":[0.39579347364014383,0.39290219590652387,0.4449534543572333,0.4710814099145239,0.6635529042570006,1.182855141664556,1.0687218435912713,0.9530873442312635,1.049499144868662,0.44851890955204166,1.3358859138819594,1.0307162782674684,1.2963567044469808],"type":"scatter3d","scene":"scene5"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.03809734988746194,0.058649546070346906,0.024503284234396915],"y":[0.9309062847532191,-0.09646900266117608,0.29940666936614657],"z":[2.369969764285585,2.1805766961918795,1.9728141285747292],"type":"scatter3d","scene":"scene5"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.02612807895911395,0.0230316954004244,0.010313605199926369,0.012288864600601359],"y":[-0.5437784851976886,-1.1438277524218965,1.035205499635493,0.8516051445061544],"z":[1.294872355450701,1.616112509274086,1.3941045758178592,1.500719593021173],"type":"scatter3d","scene":"scene5"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.0055360377307255215,0.005605825189593203,0.009860104187842366,0.0035075191350978437,0.01660528329335468,0.014536225751129598,0.018846418454461944,0.012591925806074397,0.013191028544313973,0.001524013632579041,0.010465407311522769,0.01907351657041888,0.0012335942981166377],"y":[-0.6934772783887935,-0.34296632505779057,0.42528535757147434,-0.20954025267919896,0.5555261994915579,-0.43179603611033945,-0.3329879150014916,-0.42839438063567226,-0.25085489425745466,2.01512869737051,0.8367631114206882,-0.2881777725752239,-0.3168292873754881],"z":[0.39579347364014383,0.39290219590652387,0.4449534543572333,0.4710814099145239,0.6635529042570006,1.182855141664556,1.0687218435912713,0.9530873442312635,1.049499144868662,0.44851890955204166,1.3358859138819594,1.0307162782674684,1.2963567044469808],"type":"scatter3d","scene":"scene6"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.03809734988746194,0.058649546070346906,0.024503284234396915],"y":[1.4082977795115847,-0.4069583840755402,-0.8278754240318706],"z":[2.369969764285585,2.1805766961918795,1.9728141285747292],"type":"scatter3d","scene":"scene6"},{"hovertemplate":"Retorno: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.02612807895911395,0.0230316954004244,0.010313605199926369,0.012288864600601359],"y":[1.0930649758426898,4.428853906419347,2.038903140508085,2.5865659541656494],"z":[1.294872355450701,1.616112509274086,1.3941045758178592,1.500719593021173],"type":"scatter3d","scene":"scene6"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.047865481608498996,0.05074454234491011,0.05053797171667538,0.04514737087810372,0.057590085394082405,0.07689752919754603,0.06541335508045978,0.06460062201698438,0.07218754792434143,0.08163781279712175,0.08963434590557022,0.07833045689423043,0.09572767385166961],"y":[0.06244367709632314,0.3028997539111445,-0.094054752535747,0.38978063122536427,-0.3231300544310648,0.31808734938509325,0.2341142992473735,0.23858735410411328,0.03118116043255225,-0.8649852082576377,0.1854192017934314,-0.5040497840998854,-0.27665824849737153],"z":[-0.6934772783887935,-0.34296632505779057,0.42528535757147434,-0.20954025267919896,0.5555261994915579,-0.43179603611033945,-0.3329879150014916,-0.42839438063567226,-0.25085489425745466,2.01512869737051,0.8367631114206882,-0.2881777725752239,-0.3168292873754881],"type":"scatter3d","scene":"scene7"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.20340861271350252,0.1480524919709031,0.15012414510601715],"y":[0.9309062847532191,-0.09646900266117608,0.29940666936614657],"z":[1.4082977795115847,-0.4069583840755402,-0.8278754240318706],"type":"scatter3d","scene":"scene7"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eKurtosis: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.11925611739529647,0.12366013103794612,0.10873050360492736,0.11895405452210038],"y":[-0.5437784851976886,-1.1438277524218965,1.035205499635493,0.8516051445061544],"z":[1.0930649758426898,4.428853906419347,2.038903140508085,2.5865659541656494],"type":"scatter3d","scene":"scene7"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.047865481608498996,0.05074454234491011,0.05053797171667538,0.04514737087810372,0.057590085394082405,0.07689752919754603,0.06541335508045978,0.06460062201698438,0.07218754792434143,0.08163781279712175,0.08963434590557022,0.07833045689423043,0.09572767385166961],"y":[0.06244367709632314,0.3028997539111445,-0.094054752535747,0.38978063122536427,-0.3231300544310648,0.31808734938509325,0.2341142992473735,0.23858735410411328,0.03118116043255225,-0.8649852082576377,0.1854192017934314,-0.5040497840998854,-0.27665824849737153],"z":[0.39579347364014383,0.39290219590652387,0.4449534543572333,0.4710814099145239,0.6635529042570006,1.182855141664556,1.0687218435912713,0.9530873442312635,1.049499144868662,0.44851890955204166,1.3358859138819594,1.0307162782674684,1.2963567044469808],"type":"scatter3d","scene":"scene8"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.20340861271350252,0.1480524919709031,0.15012414510601715],"y":[0.9309062847532191,-0.09646900266117608,0.29940666936614657],"z":[2.369969764285585,2.1805766961918795,1.9728141285747292],"type":"scatter3d","scene":"scene8"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eSkewness: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.11925611739529647,0.12366013103794612,0.10873050360492736,0.11895405452210038],"y":[-0.5437784851976886,-1.1438277524218965,1.035205499635493,0.8516051445061544],"z":[1.294872355450701,1.616112509274086,1.3941045758178592,1.500719593021173],"type":"scatter3d","scene":"scene8"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.047865481608498996,0.05074454234491011,0.05053797171667538,0.04514737087810372,0.057590085394082405,0.07689752919754603,0.06541335508045978,0.06460062201698438,0.07218754792434143,0.08163781279712175,0.08963434590557022,0.07833045689423043,0.09572767385166961],"y":[-0.6934772783887935,-0.34296632505779057,0.42528535757147434,-0.20954025267919896,0.5555261994915579,-0.43179603611033945,-0.3329879150014916,-0.42839438063567226,-0.25085489425745466,2.01512869737051,0.8367631114206882,-0.2881777725752239,-0.3168292873754881],"z":[0.39579347364014383,0.39290219590652387,0.4449534543572333,0.4710814099145239,0.6635529042570006,1.182855141664556,1.0687218435912713,0.9530873442312635,1.049499144868662,0.44851890955204166,1.3358859138819594,1.0307162782674684,1.2963567044469808],"type":"scatter3d","scene":"scene9"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.20340861271350252,0.1480524919709031,0.15012414510601715],"y":[1.4082977795115847,-0.4069583840755402,-0.8278754240318706],"z":[2.369969764285585,2.1805766961918795,1.9728141285747292],"type":"scatter3d","scene":"scene9"},{"hovertemplate":"Volatilidad: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[0.11925611739529647,0.12366013103794612,0.10873050360492736,0.11895405452210038],"y":[1.0930649758426898,4.428853906419347,2.038903140508085,2.5865659541656494],"z":[1.294872355450701,1.616112509274086,1.3941045758178592,1.500719593021173],"type":"scatter3d","scene":"scene9"},{"hovertemplate":"Skewness: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 0\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 0","marker":{"color":"#636EFA","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 0","showlegend":false,"x":[0.06244367709632314,0.3028997539111445,-0.094054752535747,0.38978063122536427,-0.3231300544310648,0.31808734938509325,0.2341142992473735,0.23858735410411328,0.03118116043255225,-0.8649852082576377,0.1854192017934314,-0.5040497840998854,-0.27665824849737153],"y":[-0.6934772783887935,-0.34296632505779057,0.42528535757147434,-0.20954025267919896,0.5555261994915579,-0.43179603611033945,-0.3329879150014916,-0.42839438063567226,-0.25085489425745466,2.01512869737051,0.8367631114206882,-0.2881777725752239,-0.3168292873754881],"z":[0.39579347364014383,0.39290219590652387,0.4449534543572333,0.4710814099145239,0.6635529042570006,1.182855141664556,1.0687218435912713,0.9530873442312635,1.049499144868662,0.44851890955204166,1.3358859138819594,1.0307162782674684,1.2963567044469808],"type":"scatter3d","scene":"scene10"},{"hovertemplate":"Skewness: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 1\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 1","marker":{"color":"#EF553B","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 1","showlegend":false,"x":[0.9309062847532191,-0.09646900266117608,0.29940666936614657],"y":[1.4082977795115847,-0.4069583840755402,-0.8278754240318706],"z":[2.369969764285585,2.1805766961918795,1.9728141285747292],"type":"scatter3d","scene":"scene10"},{"hovertemplate":"Skewness: %{x}\u003cbr\u003eKurtosis: %{y}\u003cbr\u003eBeta: %{z}\u003cbr\u003eCluster: 2\u003cextra\u003e\u003c\u002fextra\u003e","legendgroup":"Cluster 2","marker":{"color":"#00CC96","opacity":0.8,"size":4},"mode":"markers","name":"Cluster 2","showlegend":false,"x":[-0.5437784851976886,-1.1438277524218965,1.035205499635493,0.8516051445061544],"y":[1.0930649758426898,4.428853906419347,2.038903140508085,2.5865659541656494],"z":[1.294872355450701,1.616112509274086,1.3941045758178592,1.500719593021173],"type":"scatter3d","scene":"scene10"}],                        {"template":{"data":{"histogram2dcontour":[{"type":"histogram2dcontour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"choropleth":[{"type":"choropleth","colorbar":{"outlinewidth":0,"ticks":""}}],"histogram2d":[{"type":"histogram2d","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmap":[{"type":"heatmap","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"heatmapgl":[{"type":"heatmapgl","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"contourcarpet":[{"type":"contourcarpet","colorbar":{"outlinewidth":0,"ticks":""}}],"contour":[{"type":"contour","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"surface":[{"type":"surface","colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]}],"mesh3d":[{"type":"mesh3d","colorbar":{"outlinewidth":0,"ticks":""}}],"scatter":[{"fillpattern":{"fillmode":"overlay","size":10,"solidity":0.2},"type":"scatter"}],"parcoords":[{"type":"parcoords","line":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolargl":[{"type":"scatterpolargl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"bar":[{"error_x":{"color":"#2a3f5f"},"error_y":{"color":"#2a3f5f"},"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"bar"}],"scattergeo":[{"type":"scattergeo","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterpolar":[{"type":"scatterpolar","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"histogram":[{"marker":{"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"histogram"}],"scattergl":[{"type":"scattergl","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatter3d":[{"type":"scatter3d","line":{"colorbar":{"outlinewidth":0,"ticks":""}},"marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattermapbox":[{"type":"scattermapbox","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scatterternary":[{"type":"scatterternary","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"scattercarpet":[{"type":"scattercarpet","marker":{"colorbar":{"outlinewidth":0,"ticks":""}}}],"carpet":[{"aaxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"baxis":{"endlinecolor":"#2a3f5f","gridcolor":"white","linecolor":"white","minorgridcolor":"white","startlinecolor":"#2a3f5f"},"type":"carpet"}],"table":[{"cells":{"fill":{"color":"#EBF0F8"},"line":{"color":"white"}},"header":{"fill":{"color":"#C8D4E3"},"line":{"color":"white"}},"type":"table"}],"barpolar":[{"marker":{"line":{"color":"#E5ECF6","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"barpolar"}],"pie":[{"automargin":true,"type":"pie"}]},"layout":{"autotypenumbers":"strict","colorway":["#636efa","#EF553B","#00cc96","#ab63fa","#FFA15A","#19d3f3","#FF6692","#B6E880","#FF97FF","#FECB52"],"font":{"color":"#2a3f5f"},"hovermode":"closest","hoverlabel":{"align":"left"},"paper_bgcolor":"white","plot_bgcolor":"#E5ECF6","polar":{"bgcolor":"#E5ECF6","angularaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"radialaxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"ternary":{"bgcolor":"#E5ECF6","aaxis":{"gridcolor":"white","linecolor":"white","ticks":""},"baxis":{"gridcolor":"white","linecolor":"white","ticks":""},"caxis":{"gridcolor":"white","linecolor":"white","ticks":""}},"coloraxis":{"colorbar":{"outlinewidth":0,"ticks":""}},"colorscale":{"sequential":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"sequentialminus":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"diverging":[[0,"#8e0152"],[0.1,"#c51b7d"],[0.2,"#de77ae"],[0.3,"#f1b6da"],[0.4,"#fde0ef"],[0.5,"#f7f7f7"],[0.6,"#e6f5d0"],[0.7,"#b8e186"],[0.8,"#7fbc41"],[0.9,"#4d9221"],[1,"#276419"]]},"xaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"yaxis":{"gridcolor":"white","linecolor":"white","ticks":"","title":{"standoff":15},"zerolinecolor":"white","automargin":true,"zerolinewidth":2},"scene":{"xaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"yaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2},"zaxis":{"backgroundcolor":"#E5ECF6","gridcolor":"white","linecolor":"white","showbackground":true,"ticks":"","zerolinecolor":"white","gridwidth":2}},"shapedefaults":{"line":{"color":"#2a3f5f"}},"annotationdefaults":{"arrowcolor":"#2a3f5f","arrowhead":0,"arrowwidth":1},"geo":{"bgcolor":"white","landcolor":"#E5ECF6","subunitcolor":"white","showland":true,"showlakes":true,"lakecolor":"white"},"title":{"x":0.05},"mapbox":{"style":"light"}}},"scene":{"domain":{"x":[0.0,0.16799999999999998],"y":[0.625,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Volatilidad"}},"zaxis":{"title":{"text":"Skewness"}}},"scene2":{"domain":{"x":[0.208,0.376],"y":[0.625,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Volatilidad"}},"zaxis":{"title":{"text":"Kurtosis"}}},"scene3":{"domain":{"x":[0.416,0.584],"y":[0.625,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Volatilidad"}},"zaxis":{"title":{"text":"Beta"}}},"scene4":{"domain":{"x":[0.624,0.792],"y":[0.625,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Skewness"}},"zaxis":{"title":{"text":"Kurtosis"}}},"scene5":{"domain":{"x":[0.832,1.0],"y":[0.625,1.0]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Skewness"}},"zaxis":{"title":{"text":"Beta"}}},"scene6":{"domain":{"x":[0.0,0.16799999999999998],"y":[0.0,0.375]},"xaxis":{"title":{"text":"Retorno"}},"yaxis":{"title":{"text":"Kurtosis"}},"zaxis":{"title":{"text":"Beta"}}},"scene7":{"domain":{"x":[0.208,0.376],"y":[0.0,0.375]},"xaxis":{"title":{"text":"Volatilidad"}},"yaxis":{"title":{"text":"Skewness"}},"zaxis":{"title":{"text":"Kurtosis"}}},"scene8":{"domain":{"x":[0.416,0.584],"y":[0.0,0.375]},"xaxis":{"title":{"text":"Volatilidad"}},"yaxis":{"title":{"text":"Skewness"}},"zaxis":{"title":{"text":"Beta"}}},"scene9":{"domain":{"x":[0.624,0.792],"y":[0.0,0.375]},"xaxis":{"title":{"text":"Volatilidad"}},"yaxis":{"title":{"text":"Kurtosis"}},"zaxis":{"title":{"text":"Beta"}}},"scene10":{"domain":{"x":[0.832,1.0],"y":[0.0,0.375]},"xaxis":{"title":{"text":"Skewness"}},"yaxis":{"title":{"text":"Kurtosis"}},"zaxis":{"title":{"text":"Beta"}}},"annotations":[{"font":{"size":16},"showarrow":false,"text":"Retorno vs Volatilidad vs Skewness","x":0.08399999999999999,"xanchor":"center","xref":"paper","y":1.0,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Retorno vs Volatilidad vs Kurtosis","x":0.292,"xanchor":"center","xref":"paper","y":1.0,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Retorno vs Volatilidad vs Beta","x":0.5,"xanchor":"center","xref":"paper","y":1.0,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Retorno vs Skewness vs Kurtosis","x":0.708,"xanchor":"center","xref":"paper","y":1.0,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Retorno vs Skewness vs Beta","x":0.9159999999999999,"xanchor":"center","xref":"paper","y":1.0,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Retorno vs Kurtosis vs Beta","x":0.08399999999999999,"xanchor":"center","xref":"paper","y":0.375,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Volatilidad vs Skewness vs Kurtosis","x":0.292,"xanchor":"center","xref":"paper","y":0.375,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Volatilidad vs Skewness vs Beta","x":0.5,"xanchor":"center","xref":"paper","y":0.375,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Volatilidad vs Kurtosis vs Beta","x":0.708,"xanchor":"center","xref":"paper","y":0.375,"yanchor":"bottom","yref":"paper"},{"font":{"size":16},"showarrow":false,"text":"Skewness vs Kurtosis vs Beta","x":0.9159999999999999,"xanchor":"center","xref":"paper","y":0.375,"yanchor":"bottom","yref":"paper"}],"title":{"text":"Clustering K-Means 3D — Todas las combinaciones de indicadores"},"margin":{"l":0,"r":0,"t":50,"b":0},"height":800,"width":1700},                        {"responsive": true}                    ).then(function(){
    
    var gd = document.getElementById('fd33d6c4-33f4-4478-9005-ba6c28646225');
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

    # Mostar acciones y a qué cluster pertenece:
    df_indicadores.sort_values('Cluster_KMeans')




.. raw:: html

    
      <div id="df-b75e26d1-5434-41a9-a21a-d6671f5d7291" class="colab-df-container">
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
          <th>Cluster_KMeans</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>JNJ</th>
          <td>0.005536</td>
          <td>0.047865</td>
          <td>0.062444</td>
          <td>-0.693477</td>
          <td>0.395793</td>
          <td>0</td>
        </tr>
        <tr>
          <th>PG</th>
          <td>0.005606</td>
          <td>0.050745</td>
          <td>0.302900</td>
          <td>-0.342966</td>
          <td>0.392902</td>
          <td>0</td>
        </tr>
        <tr>
          <th>KO</th>
          <td>0.009860</td>
          <td>0.050538</td>
          <td>-0.094055</td>
          <td>0.425285</td>
          <td>0.444953</td>
          <td>0</td>
        </tr>
        <tr>
          <th>PEP</th>
          <td>0.003508</td>
          <td>0.045147</td>
          <td>0.389781</td>
          <td>-0.209540</td>
          <td>0.471081</td>
          <td>0</td>
        </tr>
        <tr>
          <th>WMT</th>
          <td>0.016605</td>
          <td>0.057590</td>
          <td>-0.323130</td>
          <td>0.555526</td>
          <td>0.663553</td>
          <td>0</td>
        </tr>
        <tr>
          <th>AAPL</th>
          <td>0.014536</td>
          <td>0.076898</td>
          <td>0.318087</td>
          <td>-0.431796</td>
          <td>1.182855</td>
          <td>0</td>
        </tr>
        <tr>
          <th>MSFT</th>
          <td>0.018846</td>
          <td>0.065413</td>
          <td>0.234114</td>
          <td>-0.332988</td>
          <td>1.068722</td>
          <td>0</td>
        </tr>
        <tr>
          <th>V</th>
          <td>0.012592</td>
          <td>0.064601</td>
          <td>0.238587</td>
          <td>-0.428394</td>
          <td>0.953087</td>
          <td>0</td>
        </tr>
        <tr>
          <th>MA</th>
          <td>0.013191</td>
          <td>0.072188</td>
          <td>0.031181</td>
          <td>-0.250855</td>
          <td>1.049499</td>
          <td>0</td>
        </tr>
        <tr>
          <th>UNH</th>
          <td>0.001524</td>
          <td>0.081638</td>
          <td>-0.864985</td>
          <td>2.015129</td>
          <td>0.448519</td>
          <td>0</td>
        </tr>
        <tr>
          <th>GOOGL</th>
          <td>0.019074</td>
          <td>0.078330</td>
          <td>-0.504050</td>
          <td>-0.288178</td>
          <td>1.030716</td>
          <td>0</td>
        </tr>
        <tr>
          <th>AMZN</th>
          <td>0.010465</td>
          <td>0.089634</td>
          <td>0.185419</td>
          <td>0.836763</td>
          <td>1.335886</td>
          <td>0</td>
        </tr>
        <tr>
          <th>NKE</th>
          <td>0.001234</td>
          <td>0.095728</td>
          <td>-0.276658</td>
          <td>-0.316829</td>
          <td>1.296357</td>
          <td>0</td>
        </tr>
        <tr>
          <th>NVDA</th>
          <td>0.058650</td>
          <td>0.148052</td>
          <td>-0.096469</td>
          <td>-0.406958</td>
          <td>2.180577</td>
          <td>1</td>
        </tr>
        <tr>
          <th>AMD</th>
          <td>0.024503</td>
          <td>0.150124</td>
          <td>0.299407</td>
          <td>-0.827875</td>
          <td>1.972814</td>
          <td>1</td>
        </tr>
        <tr>
          <th>TSLA</th>
          <td>0.038097</td>
          <td>0.203409</td>
          <td>0.930906</td>
          <td>1.408298</td>
          <td>2.369970</td>
          <td>1</td>
        </tr>
        <tr>
          <th>NFLX</th>
          <td>0.023032</td>
          <td>0.123660</td>
          <td>-1.143828</td>
          <td>4.428854</td>
          <td>1.616113</td>
          <td>2</td>
        </tr>
        <tr>
          <th>META</th>
          <td>0.026128</td>
          <td>0.119256</td>
          <td>-0.543778</td>
          <td>1.093065</td>
          <td>1.294872</td>
          <td>2</td>
        </tr>
        <tr>
          <th>CRM</th>
          <td>0.010314</td>
          <td>0.108731</td>
          <td>1.035205</td>
          <td>2.038903</td>
          <td>1.394105</td>
          <td>2</td>
        </tr>
        <tr>
          <th>BA</th>
          <td>0.012289</td>
          <td>0.118954</td>
          <td>0.851605</td>
          <td>2.586566</td>
          <td>1.500720</td>
          <td>2</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-b75e26d1-5434-41a9-a21a-d6671f5d7291')"
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
            document.querySelector('#df-b75e26d1-5434-41a9-a21a-d6671f5d7291 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-b75e26d1-5434-41a9-a21a-d6671f5d7291');
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
    
    
        <div id="df-5c132f16-f7e8-44ee-ad91-5d95effae79f">
          <button class="colab-df-quickchart" onclick="quickchart('df-5c132f16-f7e8-44ee-ad91-5d95effae79f')"
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
                document.querySelector('#df-5c132f16-f7e8-44ee-ad91-5d95effae79f button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
        </div>
      </div>
    



.. code:: ipython3

    import plotly.graph_objects as go
    
    # Columnas a usar
    cols = ['Retorno','Volatilidad','Skewness','Kurtosis','Beta']
    
    # cols = ['Retorno','Volatilidad','Skewness','Kurtosis','Beta']
    
    # Preparar datos y calcular promedio por cluster
    tmp = df_indicadores.copy()
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
            <script charset="utf-8" src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>                <div id="77521627-bb69-4699-ba98-fbacec37dcb4" class="plotly-graph-div" style="height:525px; width:100%;"></div>            <script type="text/javascript">                                    window.PLOTLYENV=window.PLOTLYENV || {};                                    if (document.getElementById("77521627-bb69-4699-ba98-fbacec37dcb4")) {                    Plotly.newPlot(                        "77521627-bb69-4699-ba98-fbacec37dcb4",                        [{"fill":"toself","name":"Cluster 0","opacity":0.3,"r":[0.010198223069633142,0.06740883043155341,-0.02310497081740853,0.04135994029021365,0.8256865168138177,0.010198223069633142],"theta":["Retorno","Volatilidad","Skewness","Kurtosis","Beta","Retorno"],"type":"scatterpolar"},{"fill":"toself","name":"Cluster 1","opacity":0.3,"r":[0.04041672673073526,0.16719508326347424,0.3779479838193966,0.0578213238013913,2.174453529684065,0.04041672673073526],"theta":["Retorno","Volatilidad","Skewness","Kurtosis","Beta","Retorno"],"type":"scatterpolar"},{"fill":"toself","name":"Cluster 2","opacity":0.3,"r":[0.01794056104001652,0.11765020164006759,0.04980110163051557,2.536846994233943,1.4514522583909548,0.01794056104001652],"theta":["Retorno","Volatilidad","Skewness","Kurtosis","Beta","Retorno"],"type":"scatterpolar"}],                        {"template":{"data":{"barpolar":[{"marker":{"line":{"color":"white","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"barpolar"}],"bar":[{"error_x":{"color":"#2a3f5f"},"error_y":{"color":"#2a3f5f"},"marker":{"line":{"color":"white","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"bar"}],"carpet":[{"aaxis":{"endlinecolor":"#2a3f5f","gridcolor":"#C8D4E3","linecolor":"#C8D4E3","minorgridcolor":"#C8D4E3","startlinecolor":"#2a3f5f"},"baxis":{"endlinecolor":"#2a3f5f","gridcolor":"#C8D4E3","linecolor":"#C8D4E3","minorgridcolor":"#C8D4E3","startlinecolor":"#2a3f5f"},"type":"carpet"}],"choropleth":[{"colorbar":{"outlinewidth":0,"ticks":""},"type":"choropleth"}],"contourcarpet":[{"colorbar":{"outlinewidth":0,"ticks":""},"type":"contourcarpet"}],"contour":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"contour"}],"heatmapgl":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"heatmapgl"}],"heatmap":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"heatmap"}],"histogram2dcontour":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"histogram2dcontour"}],"histogram2d":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"histogram2d"}],"histogram":[{"marker":{"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"histogram"}],"mesh3d":[{"colorbar":{"outlinewidth":0,"ticks":""},"type":"mesh3d"}],"parcoords":[{"line":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"parcoords"}],"pie":[{"automargin":true,"type":"pie"}],"scatter3d":[{"line":{"colorbar":{"outlinewidth":0,"ticks":""}},"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatter3d"}],"scattercarpet":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattercarpet"}],"scattergeo":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattergeo"}],"scattergl":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattergl"}],"scattermapbox":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattermapbox"}],"scatterpolargl":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatterpolargl"}],"scatterpolar":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatterpolar"}],"scatter":[{"fillpattern":{"fillmode":"overlay","size":10,"solidity":0.2},"type":"scatter"}],"scatterternary":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatterternary"}],"surface":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"surface"}],"table":[{"cells":{"fill":{"color":"#EBF0F8"},"line":{"color":"white"}},"header":{"fill":{"color":"#C8D4E3"},"line":{"color":"white"}},"type":"table"}]},"layout":{"annotationdefaults":{"arrowcolor":"#2a3f5f","arrowhead":0,"arrowwidth":1},"autotypenumbers":"strict","coloraxis":{"colorbar":{"outlinewidth":0,"ticks":""}},"colorscale":{"diverging":[[0,"#8e0152"],[0.1,"#c51b7d"],[0.2,"#de77ae"],[0.3,"#f1b6da"],[0.4,"#fde0ef"],[0.5,"#f7f7f7"],[0.6,"#e6f5d0"],[0.7,"#b8e186"],[0.8,"#7fbc41"],[0.9,"#4d9221"],[1,"#276419"]],"sequential":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"sequentialminus":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]},"colorway":["#636efa","#EF553B","#00cc96","#ab63fa","#FFA15A","#19d3f3","#FF6692","#B6E880","#FF97FF","#FECB52"],"font":{"color":"#2a3f5f"},"geo":{"bgcolor":"white","lakecolor":"white","landcolor":"white","showlakes":true,"showland":true,"subunitcolor":"#C8D4E3"},"hoverlabel":{"align":"left"},"hovermode":"closest","mapbox":{"style":"light"},"paper_bgcolor":"white","plot_bgcolor":"white","polar":{"angularaxis":{"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":""},"bgcolor":"white","radialaxis":{"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":""}},"scene":{"xaxis":{"backgroundcolor":"white","gridcolor":"#DFE8F3","gridwidth":2,"linecolor":"#EBF0F8","showbackground":true,"ticks":"","zerolinecolor":"#EBF0F8"},"yaxis":{"backgroundcolor":"white","gridcolor":"#DFE8F3","gridwidth":2,"linecolor":"#EBF0F8","showbackground":true,"ticks":"","zerolinecolor":"#EBF0F8"},"zaxis":{"backgroundcolor":"white","gridcolor":"#DFE8F3","gridwidth":2,"linecolor":"#EBF0F8","showbackground":true,"ticks":"","zerolinecolor":"#EBF0F8"}},"shapedefaults":{"line":{"color":"#2a3f5f"}},"ternary":{"aaxis":{"gridcolor":"#DFE8F3","linecolor":"#A2B1C6","ticks":""},"baxis":{"gridcolor":"#DFE8F3","linecolor":"#A2B1C6","ticks":""},"bgcolor":"white","caxis":{"gridcolor":"#DFE8F3","linecolor":"#A2B1C6","ticks":""}},"title":{"x":0.05},"xaxis":{"automargin":true,"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":"","title":{"standoff":15},"zerolinecolor":"#EBF0F8","zerolinewidth":2},"yaxis":{"automargin":true,"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":"","title":{"standoff":15},"zerolinecolor":"#EBF0F8","zerolinewidth":2}}},"polar":{"radialaxis":{"showline":false,"gridcolor":"lightgray"}},"title":{"text":"Radar combinado por cluster"}},                        {"responsive": true}                    ).then(function(){
    
    var gd = document.getElementById('77521627-bb69-4699-ba98-fbacec37dcb4');
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


**¿Cómo cambian los resultados con 2, 4 y 5 clusters?**
