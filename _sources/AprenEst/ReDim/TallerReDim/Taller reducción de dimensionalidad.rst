Taller reducción de dimensionalidad
-----------------------------------

`Datos de la NASA <https://power.larc.nasa.gov/data-access-viewer/>`__

-  TS: Temperatura. Earth Skin Temperature

-  RH2M: Humedad relativa 2m

-  WS50M: Viento 50m

-  PRECTOTCORR: Precipitación promedio

-  ALLSKY_SFC_SW_DWN: Irradiancia

.. code:: ipython3

    import json
    import pandas as pd
    import numpy as np
    import seaborn as sns
    import matplotlib.pyplot as plt
    import seaborn as sns
    from sklearn.preprocessing import StandardScaler
    from sklearn.decomposition import PCA
    
    # Cargar el archivo JSON
    with open("POWER_Point_Monthly_19810101_20221231_006d24N_075d58W_UTC.json", "r") as file:
        data = json.load(file)
    
    # Extraer las variables principales
    properties = data["properties"]
    
    # Extraer las seis variables
    variables = properties["parameter"]
    
    # Crear un DataFrame con las variables extraídas
    df = pd.DataFrame(variables)
    df.head()




.. raw:: html

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
          <th>TS</th>
          <th>RH2M</th>
          <th>WS50M</th>
          <th>PRECTOTCORR_SUM</th>
          <th>ALLSKY_SFC_SW_DWN</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>198101</th>
          <td>16.38</td>
          <td>88.00</td>
          <td>1.39</td>
          <td>100.20</td>
          <td>-999.0</td>
        </tr>
        <tr>
          <th>198102</th>
          <td>16.79</td>
          <td>89.31</td>
          <td>1.34</td>
          <td>195.12</td>
          <td>-999.0</td>
        </tr>
        <tr>
          <th>198103</th>
          <td>17.50</td>
          <td>88.06</td>
          <td>1.24</td>
          <td>295.31</td>
          <td>-999.0</td>
        </tr>
        <tr>
          <th>198104</th>
          <td>17.27</td>
          <td>90.44</td>
          <td>1.42</td>
          <td>358.59</td>
          <td>-999.0</td>
        </tr>
        <tr>
          <th>198105</th>
          <td>16.90</td>
          <td>92.88</td>
          <td>1.31</td>
          <td>411.33</td>
          <td>-999.0</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    # Renombrar las variables en el DataFrame
    df.rename(
        columns={
            "TS": "Temperatura",
            "RH2M": "Humedad relativa 2m",
            "WS50M": "Viento 50m",
            "PRECTOTCORR_SUM": "Precipitación",
            "ALLSKY_SFC_SW_DWN": "Irradiancia",
        },
        inplace=True,
    )
    
    df.head()




.. raw:: html

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
          <th>Humedad relativa 2m</th>
          <th>Viento 50m</th>
          <th>Precipitación</th>
          <th>Irradiancia</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>198101</th>
          <td>16.38</td>
          <td>88.00</td>
          <td>1.39</td>
          <td>100.20</td>
          <td>-999.0</td>
        </tr>
        <tr>
          <th>198102</th>
          <td>16.79</td>
          <td>89.31</td>
          <td>1.34</td>
          <td>195.12</td>
          <td>-999.0</td>
        </tr>
        <tr>
          <th>198103</th>
          <td>17.50</td>
          <td>88.06</td>
          <td>1.24</td>
          <td>295.31</td>
          <td>-999.0</td>
        </tr>
        <tr>
          <th>198104</th>
          <td>17.27</td>
          <td>90.44</td>
          <td>1.42</td>
          <td>358.59</td>
          <td>-999.0</td>
        </tr>
        <tr>
          <th>198105</th>
          <td>16.90</td>
          <td>92.88</td>
          <td>1.31</td>
          <td>411.33</td>
          <td>-999.0</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    # Convertir el índice a formato de texto para filtrar filas
    df.index = df.index.astype(str)
    
    # Filtrar filas cuyo índice no termine en '13'
    df = df[~df.index.str.endswith("13")]
    
    # Convertir el índice de vuelta a formato de fecha y cambiar el formato a año/mes
    df.index = pd.to_datetime(df.index, format="%Y%m").strftime("%Y/%m")
    
    df.head()




.. raw:: html

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
          <th>Humedad relativa 2m</th>
          <th>Viento 50m</th>
          <th>Precipitación</th>
          <th>Irradiancia</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>1981/01</th>
          <td>16.38</td>
          <td>88.00</td>
          <td>1.39</td>
          <td>100.20</td>
          <td>-999.0</td>
        </tr>
        <tr>
          <th>1981/02</th>
          <td>16.79</td>
          <td>89.31</td>
          <td>1.34</td>
          <td>195.12</td>
          <td>-999.0</td>
        </tr>
        <tr>
          <th>1981/03</th>
          <td>17.50</td>
          <td>88.06</td>
          <td>1.24</td>
          <td>295.31</td>
          <td>-999.0</td>
        </tr>
        <tr>
          <th>1981/04</th>
          <td>17.27</td>
          <td>90.44</td>
          <td>1.42</td>
          <td>358.59</td>
          <td>-999.0</td>
        </tr>
        <tr>
          <th>1981/05</th>
          <td>16.90</td>
          <td>92.88</td>
          <td>1.31</td>
          <td>411.33</td>
          <td>-999.0</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    # Contar el total de datos por variable
    total_counts = df.count()
    print(total_counts)
    
    # Verificar si hay datos faltantes (NaN) y contarlos
    nan_counts = df.isna().sum()
    print(nan_counts)


.. parsed-literal::

    Temperatura            504
    Humedad relativa 2m    504
    Viento 50m             504
    Precipitación          504
    Irradiancia            504
    dtype: int64
    Temperatura            0
    Humedad relativa 2m    0
    Viento 50m             0
    Precipitación          0
    Irradiancia            0
    dtype: int64
    

.. code:: ipython3

    # Realizar el análisis descriptivo de las variables
    descriptive_analysis = df.describe()
    
    # Mostrar el análisis descriptivo
    print(descriptive_analysis)


.. parsed-literal::

           Temperatura  Humedad relativa 2m  Viento 50m  Precipitación  \
    count   504.000000           504.000000  504.000000     504.000000   
    mean     17.267044            88.761171    1.468512     223.256766   
    std       0.613532             2.608982    0.172959      96.200608   
    min      15.810000            74.750000    1.020000       5.270000   
    25%      16.837500            87.620000    1.360000     152.930000   
    50%      17.225000            89.250000    1.440000     221.480000   
    75%      17.650000            90.440000    1.570000     295.310000   
    max      19.970000            94.250000    2.040000     479.880000   
    
           Irradiancia  
    count   504.000000  
    mean    -66.716389  
    std     258.826222  
    min    -999.000000  
    25%       4.580000  
    50%       4.910000  
    75%       5.292500  
    max       6.200000  
    

.. code:: ipython3

    # Eliminar filas donde cualquier variable tenga el valor -999.000000
    df = df[(df != -999.000000).all(axis=1)]
    
    # Realizar el análisis descriptivo de las variables
    descriptive_analysis = df.describe()
    
    # Mostrar el análisis descriptivo
    print(descriptive_analysis)


.. parsed-literal::

           Temperatura  Humedad relativa 2m  Viento 50m  Precipitación  \
    count   468.000000           468.000000  468.000000     468.000000   
    mean     17.290021            88.680705    1.471368     220.125491   
    std       0.611990             2.644085    0.171126      96.169838   
    min      15.810000            74.750000    1.020000       5.270000   
    25%      16.870000            87.605000    1.360000     147.660000   
    50%      17.250000            89.190000    1.450000     216.210000   
    75%      17.660000            90.395000    1.572500     295.310000   
    max      19.970000            94.250000    2.040000     479.880000   
    
           Irradiancia  
    count   468.000000  
    mean      4.997735  
    std       0.455511  
    min       4.060000  
    25%       4.657500  
    50%       4.970000  
    75%       5.332500  
    max       6.200000  
    

.. code:: ipython3

    # Crear un gráfico por cada variable en subplots
    variables = [
        "Temperatura",
        "Humedad relativa 2m",
        "Viento 50m",
        "Precipitación",
        "Irradiancia",
    ]
    
    plt.figure(figsize=(15, 20))
    
    for i, var in enumerate(variables, 1):
        plt.subplot(6, 1, i)
        plt.plot(df[var], label=var)
        plt.title(var)
        plt.xlabel("Fecha")
        plt.ylabel(var)
        plt.xticks(rotation=45)
        plt.legend()
        # Ajustar la frecuencia de las etiquetas en el eje x
        if len(df) > 0:
            plt.xticks(
                ticks=range(0, len(df.index), len(df.index) // 50),
                labels=df.index[:: len(df.index) // 50],
            )
    
    plt.tight_layout(pad=3.0)
    plt.show()



.. image:: output_9_0.png

