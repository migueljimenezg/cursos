Ejercicio PCA - acciones
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

    
      <div id="df-31dad76e-2c8b-4a00-abff-15ed96add185" class="colab-df-container">
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
          <td>168.308616</td>
          <td>111.604426</td>
          <td>157.696810</td>
          <td>192.557214</td>
          <td>234.247296</td>
          <td>130.157315</td>
          <td>149.466887</td>
          <td>56.029760</td>
          <td>398.977753</td>
          <td>351.281434</td>
          <td>...</td>
          <td>555.438689</td>
          <td>106.611315</td>
          <td>53.068235</td>
          <td>149.308492</td>
          <td>141.179574</td>
          <td>246.167060</td>
          <td>444.539701</td>
          <td>241.869443</td>
          <td>56.422426</td>
          <td>4591.564901</td>
        </tr>
        <tr>
          <th>std</th>
          <td>37.929744</td>
          <td>32.599924</td>
          <td>35.406763</td>
          <td>31.330118</td>
          <td>48.640247</td>
          <td>32.428266</td>
          <td>10.006478</td>
          <td>8.197990</td>
          <td>82.631451</td>
          <td>165.833288</td>
          <td>...</td>
          <td>256.862147</td>
          <td>26.270568</td>
          <td>47.606693</td>
          <td>17.191152</td>
          <td>16.928581</td>
          <td>67.619500</td>
          <td>87.096887</td>
          <td>50.515678</td>
          <td>18.549609</td>
          <td>813.091153</td>
        </tr>
        <tr>
          <th>min</th>
          <td>103.174965</td>
          <td>60.060001</td>
          <td>84.000000</td>
          <td>121.080002</td>
          <td>131.438278</td>
          <td>72.843140</td>
          <td>119.756920</td>
          <td>40.592751</td>
          <td>279.303253</td>
          <td>92.651703</td>
          <td>...</td>
          <td>174.869995</td>
          <td>56.027664</td>
          <td>10.579876</td>
          <td>112.904655</td>
          <td>110.428230</td>
          <td>95.384003</td>
          <td>249.559998</td>
          <td>173.635712</td>
          <td>38.834503</td>
          <td>3269.959961</td>
        </tr>
        <tr>
          <th>25%</th>
          <td>138.524826</td>
          <td>85.519997</td>
          <td>133.089996</td>
          <td>171.820007</td>
          <td>201.018570</td>
          <td>103.111610</td>
          <td>144.014465</td>
          <td>50.373859</td>
          <td>346.991211</td>
          <td>252.285950</td>
          <td>...</td>
          <td>394.519989</td>
          <td>88.638329</td>
          <td>16.206352</td>
          <td>134.108490</td>
          <td>127.865433</td>
          <td>201.880005</td>
          <td>386.012939</td>
          <td>206.614456</td>
          <td>44.324265</td>
          <td>4076.600098</td>
        </tr>
        <tr>
          <th>50%</th>
          <td>167.575729</td>
          <td>102.900002</td>
          <td>160.309998</td>
          <td>194.190002</td>
          <td>236.031769</td>
          <td>131.928772</td>
          <td>151.222519</td>
          <td>56.363876</td>
          <td>364.622650</td>
          <td>316.861664</td>
          <td>...</td>
          <td>517.570007</td>
          <td>105.146393</td>
          <td>27.729065</td>
          <td>153.950912</td>
          <td>140.274200</td>
          <td>240.080002</td>
          <td>472.730469</td>
          <td>225.511002</td>
          <td>47.488289</td>
          <td>4395.259766</td>
        </tr>
        <tr>
          <th>75%</th>
          <td>191.829468</td>
          <td>137.179993</td>
          <td>176.759995</td>
          <td>212.009995</td>
          <td>267.514771</td>
          <td>154.275345</td>
          <td>155.431351</td>
          <td>59.936264</td>
          <td>447.335052</td>
          <td>473.209686</td>
          <td>...</td>
          <td>641.619995</td>
          <td>125.442963</td>
          <td>90.315819</td>
          <td>161.462906</td>
          <td>155.858002</td>
          <td>282.160004</td>
          <td>498.170715</td>
          <td>269.519684</td>
          <td>59.013653</td>
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
          <td>160.342422</td>
          <td>177.869995</td>
          <td>177.486206</td>
          <td>175.867111</td>
          <td>404.600006</td>
          <td>601.015320</td>
          <td>363.944122</td>
          <td>98.252411</td>
          <td>6339.390137</td>
        </tr>
      </tbody>
    </table>
    <p>8 rows × 21 columns</p>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-31dad76e-2c8b-4a00-abff-15ed96add185')"
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
            document.querySelector('#df-31dad76e-2c8b-4a00-abff-15ed96add185 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-31dad76e-2c8b-4a00-abff-15ed96add185');
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
    
    
        <div id="df-1623351c-db7e-490c-98bc-79db7d593003">
          <button class="colab-df-quickchart" onclick="quickchart('df-1623351c-db7e-490c-98bc-79db7d593003')"
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
                document.querySelector('#df-1623351c-db7e-490c-98bc-79db7d593003 button');
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

    
      <div id="df-5bc117dd-3de6-4a71-8aaf-bffacb6cc209" class="colab-df-container">
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
          <td>0.392902</td>
        </tr>
        <tr>
          <th>25%</th>
          <td>0.008797</td>
          <td>0.062848</td>
          <td>-0.288276</td>
          <td>-0.358967</td>
          <td>0.615434</td>
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
          <td>0.306695</td>
          <td>1.171873</td>
          <td>1.420758</td>
        </tr>
        <tr>
          <th>max</th>
          <td>0.058650</td>
          <td>0.203409</td>
          <td>1.035206</td>
          <td>4.428854</td>
          <td>2.369970</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-5bc117dd-3de6-4a71-8aaf-bffacb6cc209')"
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
            document.querySelector('#df-5bc117dd-3de6-4a71-8aaf-bffacb6cc209 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-5bc117dd-3de6-4a71-8aaf-bffacb6cc209');
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
    
    
        <div id="df-0899c4d9-dad7-4f1a-a79a-7aa610094e1d">
          <button class="colab-df-quickchart" onclick="quickchart('df-0899c4d9-dad7-4f1a-a79a-7aa610094e1d')"
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
                document.querySelector('#df-0899c4d9-dad7-4f1a-a79a-7aa610094e1d button');
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


PCA:
~~~~

.. code:: ipython3

    # Escalado de datos:
    from sklearn.preprocessing import StandardScaler
    
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(df_indicadores)

.. code:: ipython3

    from sklearn.decomposition import PCA
    
    # Aplicación de PCA estándar
    pca = PCA()
    pca.fit(X_scaled)
    
    # Cálculo de las varianzas explicadas
    explained_variance = pca.explained_variance_ratio_
    
    print("Varianza explicada por cada componente principal:")
    print(explained_variance)
    
    # Cálculo de la varianza explicada acumulada
    explained_variance_cum = np.cumsum(pca.explained_variance_ratio_)
    
    # Visualización del gráfico de varianza explicada
    plt.figure(figsize=(8, 6))
    plt.plot(
        range(1, len(explained_variance_cum) + 1),
        explained_variance_cum,
        marker="o",
        linestyle="--",
    )
    plt.xlabel("Número de Componentes Principales")
    plt.ylabel("Varianza Explicada Acumulada")
    plt.title("Gráfico de Varianza Explicada Acumulada")
    plt.grid()
    plt.show()


.. parsed-literal::

    Varianza explicada por cada componente principal:
    [0.54110569 0.24154791 0.16562457 0.04064709 0.01107474]
    


.. image:: output_12_1.png


.. code:: ipython3

    # Aplicación de PCA estándar
    num_components = 2
    pca = PCA(n_components=num_components)
    X_pca = pca.fit_transform(X_scaled)
    
    # Varianza explicada:
    explained_variance_ratio = pca.explained_variance_ratio_
    cumulative_variance = np.cumsum(explained_variance_ratio)
    cumulative_variance




.. parsed-literal::

    array([0.54110569, 0.7826536 ])



**Matríz de rotación:**

.. code:: ipython3

    rotation_matrix = pd.DataFrame(
        pca.components_.T,
        columns=[f"PC{i+1}" for i in range(num_components)],
        index=df_indicadores.columns,
    )
    
    print(rotation_matrix)


.. parsed-literal::

                      PC1       PC2
    Retorno      0.507389  0.056271
    Volatilidad  0.585304 -0.046754
    Skewness     0.125756  0.714526
    Kurtosis     0.192013 -0.692138
    Beta         0.589315  0.071027
    

**Cargas de las variables:**

.. code:: ipython3

    loadings = pca.components_.T * np.sqrt(pca.explained_variance_)
    loadings_df = pd.DataFrame(
        loadings,
        columns=[f"PC{i+1}" for i in range(num_components)],
        index=df_indicadores.columns,
    )
    loadings_df




.. raw:: html

    
      <div id="df-6239502a-43b1-452b-8efc-3b042692b1b6" class="colab-df-container">
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
          <th>PC1</th>
          <th>PC2</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>Retorno</th>
          <td>0.856260</td>
          <td>0.063446</td>
        </tr>
        <tr>
          <th>Volatilidad</th>
          <td>0.987746</td>
          <td>-0.052716</td>
        </tr>
        <tr>
          <th>Skewness</th>
          <td>0.212223</td>
          <td>0.805643</td>
        </tr>
        <tr>
          <th>Kurtosis</th>
          <td>0.324036</td>
          <td>-0.780401</td>
        </tr>
        <tr>
          <th>Beta</th>
          <td>0.994516</td>
          <td>0.080084</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-6239502a-43b1-452b-8efc-3b042692b1b6')"
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
            document.querySelector('#df-6239502a-43b1-452b-8efc-3b042692b1b6 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-6239502a-43b1-452b-8efc-3b042692b1b6');
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
    
    
        <div id="df-dff64312-a93a-4b92-b2bb-5232fba1047c">
          <button class="colab-df-quickchart" onclick="quickchart('df-dff64312-a93a-4b92-b2bb-5232fba1047c')"
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
                document.querySelector('#df-dff64312-a93a-4b92-b2bb-5232fba1047c button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
      <div id="id_44b090e1-dcb4-46e2-b9b5-c31518f772c4">
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
        <button class="colab-df-generate" onclick="generateWithVariable('loadings_df')"
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
            document.querySelector('#id_44b090e1-dcb4-46e2-b9b5-c31518f772c4 button.colab-df-generate');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          buttonEl.onclick = () => {
            google.colab.notebook.generateWithVariable('loadings_df');
          }
          })();
        </script>
      </div>
    
        </div>
      </div>
    



**Cálculo de la matriz de proyección:**

.. code:: ipython3

    projected_data = X_scaled @ pca.components_.T
    projected_df = pd.DataFrame(
        projected_data,
        columns=[f"PC{i+1}" for i in range(num_components)],
        index=df_indicadores.index,
    )
    projected_df




.. raw:: html

    
      <div id="df-4af15c34-bd91-4542-9537-80006f365817" class="colab-df-container">
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
          <th>PC1</th>
          <th>PC2</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>JNJ</th>
          <td>-2.009927</td>
          <td>0.571025</td>
        </tr>
        <tr>
          <th>PG</th>
          <td>-1.862687</td>
          <td>0.698474</td>
        </tr>
        <tr>
          <th>KO</th>
          <td>-1.628737</td>
          <td>-0.195235</td>
        </tr>
        <tr>
          <th>PEP</th>
          <td>-1.904776</td>
          <td>0.749386</td>
        </tr>
        <tr>
          <th>WMT</th>
          <td>-1.077136</td>
          <td>-0.514358</td>
        </tr>
        <tr>
          <th>AAPL</th>
          <td>-0.340765</td>
          <td>0.870145</td>
        </tr>
        <tr>
          <th>MSFT</th>
          <td>-0.463062</td>
          <td>0.726592</td>
        </tr>
        <tr>
          <th>V</th>
          <td>-0.846575</td>
          <td>0.742175</td>
        </tr>
        <tr>
          <th>MA</th>
          <td>-0.636976</td>
          <td>0.384739</td>
        </tr>
        <tr>
          <th>UNH</th>
          <td>-1.443074</td>
          <td>-2.101113</td>
        </tr>
        <tr>
          <th>TSLA</th>
          <td>4.017180</td>
          <td>0.810888</td>
        </tr>
        <tr>
          <th>NVDA</th>
          <td>3.314539</td>
          <td>0.545675</td>
        </tr>
        <tr>
          <th>META</th>
          <td>0.854469</td>
          <td>-1.035092</td>
        </tr>
        <tr>
          <th>AMZN</th>
          <td>-0.003152</td>
          <td>0.022272</td>
        </tr>
        <tr>
          <th>NFLX</th>
          <td>1.473485</td>
          <td>-3.536335</td>
        </tr>
        <tr>
          <th>GOOGL</th>
          <td>-0.469660</td>
          <td>-0.278301</td>
        </tr>
        <tr>
          <th>AMD</th>
          <td>1.848918</td>
          <td>1.107992</td>
        </tr>
        <tr>
          <th>CRM</th>
          <td>0.695679</td>
          <td>0.488228</td>
        </tr>
        <tr>
          <th>BA</th>
          <td>1.065755</td>
          <td>-0.027127</td>
        </tr>
        <tr>
          <th>NKE</th>
          <td>-0.583498</td>
          <td>-0.030029</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-4af15c34-bd91-4542-9537-80006f365817')"
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
            document.querySelector('#df-4af15c34-bd91-4542-9537-80006f365817 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-4af15c34-bd91-4542-9537-80006f365817');
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
    
    
        <div id="df-13f2f85a-3c59-487b-8672-cf328014422c">
          <button class="colab-df-quickchart" onclick="quickchart('df-13f2f85a-3c59-487b-8672-cf328014422c')"
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
                document.querySelector('#df-13f2f85a-3c59-487b-8672-cf328014422c button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
      <div id="id_db81ce94-1f4f-4c1b-9d3b-7e8a35ab7b5f">
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
        <button class="colab-df-generate" onclick="generateWithVariable('projected_df')"
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
            document.querySelector('#id_db81ce94-1f4f-4c1b-9d3b-7e8a35ab7b5f button.colab-df-generate');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          buttonEl.onclick = () => {
            google.colab.notebook.generateWithVariable('projected_df');
          }
          })();
        </script>
      </div>
    
        </div>
      </div>
    



.. code:: ipython3

    X_pca




.. parsed-literal::

    array([[-2.00992725e+00,  5.71024994e-01],
           [-1.86268747e+00,  6.98473820e-01],
           [-1.62873685e+00, -1.95235094e-01],
           [-1.90477620e+00,  7.49386161e-01],
           [-1.07713619e+00, -5.14358028e-01],
           [-3.40765458e-01,  8.70145271e-01],
           [-4.63061861e-01,  7.26591854e-01],
           [-8.46575376e-01,  7.42174812e-01],
           [-6.36975722e-01,  3.84738999e-01],
           [-1.44307361e+00, -2.10111346e+00],
           [ 4.01718024e+00,  8.10887861e-01],
           [ 3.31453899e+00,  5.45675236e-01],
           [ 8.54469187e-01, -1.03509218e+00],
           [-3.15200969e-03,  2.22724980e-02],
           [ 1.47348491e+00, -3.53633525e+00],
           [-4.69659577e-01, -2.78301421e-01],
           [ 1.84891803e+00,  1.10799176e+00],
           [ 6.95678665e-01,  4.88227956e-01],
           [ 1.06575522e+00, -2.71268635e-02],
           [-5.83497659e-01, -3.00289131e-02]])



.. code:: ipython3

    plt.figure(figsize=(10, 6))
    
    # Gráfico de las observaciones (acciones)
    plt.scatter(X_pca[:, 0], X_pca[:, 1], c='blue')
    
    # Etiquetas de las observaciones (acciones)
    for i, label in enumerate(df_indicadores.index):
        plt.annotate(label, (X_pca[i, 0], X_pca[i, 1]),
                     fontsize=8, alpha=0.7)
    
    # Añadir las cargas (loadings) como flechas rojas
    for i, var in enumerate(df_indicadores.columns):
        plt.arrow(0, 0, loadings[i, 0], loadings[i, 1],
                  color='crimson', alpha=0.8,
                  head_width=0.05, length_includes_head=True)
        plt.text(loadings[i, 0]*1.4, loadings[i, 1]*1.1, var,
                 color='crimson', ha='center', va='center', fontsize=9)
    
    # Configuración del gráfico
    plt.title('PCA de Indicadores Financieros (Biplot)')
    plt.xlabel(f'Componente Principal 1 ({explained_variance_ratio[0]*100:.1f}%)')
    plt.ylabel(f'Componente Principal 2 ({explained_variance_ratio[1]*100:.1f}%)')
    plt.axhline(0, color='gray', lw=1)
    plt.axvline(0, color='gray', lw=1)
    plt.grid(True)
    plt.tight_layout()
    plt.show()



.. image:: output_21_0.png


K-Means:
~~~~~~~~

.. code:: ipython3

    from sklearn.preprocessing import StandardScaler
    from sklearn.cluster import KMeans, DBSCAN
    from sklearn.metrics import silhouette_score, pairwise_distances_argmin_min
    from scipy.cluster.hierarchy import dendrogram, linkage, fcluster

.. code:: ipython3

    # Calcular WCSS para diferentes valores de K:
    wcss = []
    K = range(1, 10)
    for k in K:
        kmeans = KMeans(n_clusters=k, random_state=34)
        kmeans.fit(X_pca)
        wcss.append(kmeans.inertia_)
    
    # Visualizar el método del codo
    plt.figure(figsize=(8, 4))
    plt.plot(K, wcss, "bo-")
    plt.xlabel("Número de clústeres (K)")
    plt.ylabel("WCSS")
    plt.title("Método del Codo para determinar el número óptimo de clústeres")
    plt.show()



.. image:: output_24_0.png


.. code:: ipython3

    # Calcular la puntuación de la silueta para diferentes valores de K:
    from sklearn.metrics import silhouette_score
    
    silhouette_scores = []
    K = range(2, 11)
    for k in K:
        kmeans = KMeans(n_clusters=k, random_state=34)
        kmeans.fit(X_pca)
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



.. image:: output_25_0.png


**Clusters = 3**

.. code:: ipython3

    k_base = 3
    
    kmeans = KMeans(n_clusters=k_base, random_state=34)
    df_indicadores_copy = df_indicadores.copy()
    df_indicadores_copy['Cluster_KMeans'] = kmeans.fit_predict(X_pca)
    
    # Valores de Inercia y Silueta:
    inercia = kmeans.inertia_
    silhouette = silhouette_score(X_pca, df_indicadores_copy['Cluster_KMeans'])
    
    print(f"Clusters: {k_base}")
    print(f"Inercia: {inercia}")
    print(f"Puntuación de la Silueta: {silhouette}")


.. parsed-literal::

    Clusters: 3
    Inercia: 25.062472276766986
    Puntuación de la Silueta: 0.4597277766734301
    

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
    graficar_clusters(df_indicadores_copy, 'KMeans')



.. image:: output_28_0.png


.. code:: ipython3

    # Clustering y variables en escala estandarizada:
    labels = kmeans.labels_
    X_scaled_df = pd.DataFrame(X_scaled, columns=df_indicadores_copy.iloc[:,:-1].columns)
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
            <script charset="utf-8" src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>                <div id="b04b7681-895a-4a93-8cc7-1cf11fd36966" class="plotly-graph-div" style="height:525px; width:100%;"></div>            <script type="text/javascript">                                    window.PLOTLYENV=window.PLOTLYENV || {};                                    if (document.getElementById("b04b7681-895a-4a93-8cc7-1cf11fd36966")) {                    Plotly.newPlot(                        "b04b7681-895a-4a93-8cc7-1cf11fd36966",                        [{"fill":"toself","name":"Cluster 0","opacity":0.3,"r":[-0.4094529483459443,-0.5660936757430431,0.13040019220982618,-0.37660628668386575,-0.44330868251500505,-0.4094529483459443],"theta":["Retorno","Volatilidad","Skewness","Kurtosis","Beta","Retorno"],"type":"scatterpolar"},{"fill":"toself","name":"Cluster 1","opacity":0.3,"r":[-0.040626554703725504,0.4554978758011847,-0.8705854277863769,1.4981544787950203,0.10772640267952949,-0.040626554703725504],"theta":["Retorno","Volatilidad","Skewness","Kurtosis","Beta","Retorno"],"type":"scatterpolar"},{"fill":"toself","name":"Cluster 2","opacity":0.3,"r":[1.8284648491040594,1.8457420938182725,0.5957130708059227,-0.3655787294299418,1.7773690873256494,1.8284648491040594],"theta":["Retorno","Volatilidad","Skewness","Kurtosis","Beta","Retorno"],"type":"scatterpolar"}],                        {"template":{"data":{"barpolar":[{"marker":{"line":{"color":"white","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"barpolar"}],"bar":[{"error_x":{"color":"#2a3f5f"},"error_y":{"color":"#2a3f5f"},"marker":{"line":{"color":"white","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"bar"}],"carpet":[{"aaxis":{"endlinecolor":"#2a3f5f","gridcolor":"#C8D4E3","linecolor":"#C8D4E3","minorgridcolor":"#C8D4E3","startlinecolor":"#2a3f5f"},"baxis":{"endlinecolor":"#2a3f5f","gridcolor":"#C8D4E3","linecolor":"#C8D4E3","minorgridcolor":"#C8D4E3","startlinecolor":"#2a3f5f"},"type":"carpet"}],"choropleth":[{"colorbar":{"outlinewidth":0,"ticks":""},"type":"choropleth"}],"contourcarpet":[{"colorbar":{"outlinewidth":0,"ticks":""},"type":"contourcarpet"}],"contour":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"contour"}],"heatmapgl":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"heatmapgl"}],"heatmap":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"heatmap"}],"histogram2dcontour":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"histogram2dcontour"}],"histogram2d":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"histogram2d"}],"histogram":[{"marker":{"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"histogram"}],"mesh3d":[{"colorbar":{"outlinewidth":0,"ticks":""},"type":"mesh3d"}],"parcoords":[{"line":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"parcoords"}],"pie":[{"automargin":true,"type":"pie"}],"scatter3d":[{"line":{"colorbar":{"outlinewidth":0,"ticks":""}},"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatter3d"}],"scattercarpet":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattercarpet"}],"scattergeo":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattergeo"}],"scattergl":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattergl"}],"scattermapbox":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattermapbox"}],"scatterpolargl":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatterpolargl"}],"scatterpolar":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatterpolar"}],"scatter":[{"fillpattern":{"fillmode":"overlay","size":10,"solidity":0.2},"type":"scatter"}],"scatterternary":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatterternary"}],"surface":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"surface"}],"table":[{"cells":{"fill":{"color":"#EBF0F8"},"line":{"color":"white"}},"header":{"fill":{"color":"#C8D4E3"},"line":{"color":"white"}},"type":"table"}]},"layout":{"annotationdefaults":{"arrowcolor":"#2a3f5f","arrowhead":0,"arrowwidth":1},"autotypenumbers":"strict","coloraxis":{"colorbar":{"outlinewidth":0,"ticks":""}},"colorscale":{"diverging":[[0,"#8e0152"],[0.1,"#c51b7d"],[0.2,"#de77ae"],[0.3,"#f1b6da"],[0.4,"#fde0ef"],[0.5,"#f7f7f7"],[0.6,"#e6f5d0"],[0.7,"#b8e186"],[0.8,"#7fbc41"],[0.9,"#4d9221"],[1,"#276419"]],"sequential":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"sequentialminus":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]},"colorway":["#636efa","#EF553B","#00cc96","#ab63fa","#FFA15A","#19d3f3","#FF6692","#B6E880","#FF97FF","#FECB52"],"font":{"color":"#2a3f5f"},"geo":{"bgcolor":"white","lakecolor":"white","landcolor":"white","showlakes":true,"showland":true,"subunitcolor":"#C8D4E3"},"hoverlabel":{"align":"left"},"hovermode":"closest","mapbox":{"style":"light"},"paper_bgcolor":"white","plot_bgcolor":"white","polar":{"angularaxis":{"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":""},"bgcolor":"white","radialaxis":{"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":""}},"scene":{"xaxis":{"backgroundcolor":"white","gridcolor":"#DFE8F3","gridwidth":2,"linecolor":"#EBF0F8","showbackground":true,"ticks":"","zerolinecolor":"#EBF0F8"},"yaxis":{"backgroundcolor":"white","gridcolor":"#DFE8F3","gridwidth":2,"linecolor":"#EBF0F8","showbackground":true,"ticks":"","zerolinecolor":"#EBF0F8"},"zaxis":{"backgroundcolor":"white","gridcolor":"#DFE8F3","gridwidth":2,"linecolor":"#EBF0F8","showbackground":true,"ticks":"","zerolinecolor":"#EBF0F8"}},"shapedefaults":{"line":{"color":"#2a3f5f"}},"ternary":{"aaxis":{"gridcolor":"#DFE8F3","linecolor":"#A2B1C6","ticks":""},"baxis":{"gridcolor":"#DFE8F3","linecolor":"#A2B1C6","ticks":""},"bgcolor":"white","caxis":{"gridcolor":"#DFE8F3","linecolor":"#A2B1C6","ticks":""}},"title":{"x":0.05},"xaxis":{"automargin":true,"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":"","title":{"standoff":15},"zerolinecolor":"#EBF0F8","zerolinewidth":2},"yaxis":{"automargin":true,"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":"","title":{"standoff":15},"zerolinecolor":"#EBF0F8","zerolinewidth":2}}},"polar":{"radialaxis":{"showline":false,"gridcolor":"lightgray"}},"title":{"text":"Radar combinado por cluster"}},                        {"responsive": true}                    ).then(function(){
    
    var gd = document.getElementById('b04b7681-895a-4a93-8cc7-1cf11fd36966');
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

