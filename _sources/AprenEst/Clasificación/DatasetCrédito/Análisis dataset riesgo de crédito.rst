Análisis dataset riesgo de crédito
----------------------------------

.. code:: ipython3

    import pandas as pd
    import matplotlib.pyplot as plt
    import seaborn as sns

.. code:: ipython3

    credit_risk_data = pd.read_csv("../credit_risk_data.csv")
    credit_risk_data.head()




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
          <th>ID</th>
          <th>Edad</th>
          <th>Ingresos</th>
          <th>Monto del Préstamo</th>
          <th>Plazo del Préstamo</th>
          <th>Historial de Crédito</th>
          <th>Cantidad de Créditos Vigentes</th>
          <th>Cantidad de Moras</th>
          <th>Estado del Préstamo</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>1</td>
          <td>56</td>
          <td>8382</td>
          <td>45814</td>
          <td>25</td>
          <td>492</td>
          <td>4</td>
          <td>3</td>
          <td>1</td>
        </tr>
        <tr>
          <th>1</th>
          <td>2</td>
          <td>69</td>
          <td>3406</td>
          <td>46379</td>
          <td>47</td>
          <td>700</td>
          <td>7</td>
          <td>3</td>
          <td>1</td>
        </tr>
        <tr>
          <th>2</th>
          <td>3</td>
          <td>46</td>
          <td>4586</td>
          <td>14076</td>
          <td>19</td>
          <td>577</td>
          <td>5</td>
          <td>2</td>
          <td>1</td>
        </tr>
        <tr>
          <th>3</th>
          <td>4</td>
          <td>32</td>
          <td>15003</td>
          <td>38650</td>
          <td>46</td>
          <td>653</td>
          <td>4</td>
          <td>1</td>
          <td>0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>5</td>
          <td>60</td>
          <td>9652</td>
          <td>47881</td>
          <td>30</td>
          <td>555</td>
          <td>8</td>
          <td>0</td>
          <td>1</td>
        </tr>
      </tbody>
    </table>
    </div>



**Mostrar información básica y las primeras filas del dataframe:**

.. code:: ipython3

    print(credit_risk_data.info())


.. parsed-literal::

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 1000 entries, 0 to 999
    Data columns (total 9 columns):
     #   Column                         Non-Null Count  Dtype
    ---  ------                         --------------  -----
     0   ID                             1000 non-null   int64
     1   Edad                           1000 non-null   int64
     2   Ingresos                       1000 non-null   int64
     3   Monto del Préstamo             1000 non-null   int64
     4   Plazo del Préstamo             1000 non-null   int64
     5   Historial de Crédito           1000 non-null   int64
     6   Cantidad de Créditos Vigentes  1000 non-null   int64
     7   Cantidad de Moras              1000 non-null   int64
     8   Estado del Préstamo            1000 non-null   int64
    dtypes: int64(9)
    memory usage: 70.4 KB
    None
    

**Distribución del** ´Estado del Préstamo´:

.. code:: ipython3

    credit_risk_data["Estado del Préstamo"].value_counts()




.. parsed-literal::

    1    778
    0    222
    Name: Estado del Préstamo, dtype: int64



.. code:: ipython3

    # Remover columna 'ID'
    credit_risk_data = credit_risk_data.drop(columns=["ID"])
    
    credit_risk_data.head()




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
          <th>Edad</th>
          <th>Ingresos</th>
          <th>Monto del Préstamo</th>
          <th>Plazo del Préstamo</th>
          <th>Historial de Crédito</th>
          <th>Cantidad de Créditos Vigentes</th>
          <th>Cantidad de Moras</th>
          <th>Estado del Préstamo</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>56</td>
          <td>8382</td>
          <td>45814</td>
          <td>25</td>
          <td>492</td>
          <td>4</td>
          <td>3</td>
          <td>1</td>
        </tr>
        <tr>
          <th>1</th>
          <td>69</td>
          <td>3406</td>
          <td>46379</td>
          <td>47</td>
          <td>700</td>
          <td>7</td>
          <td>3</td>
          <td>1</td>
        </tr>
        <tr>
          <th>2</th>
          <td>46</td>
          <td>4586</td>
          <td>14076</td>
          <td>19</td>
          <td>577</td>
          <td>5</td>
          <td>2</td>
          <td>1</td>
        </tr>
        <tr>
          <th>3</th>
          <td>32</td>
          <td>15003</td>
          <td>38650</td>
          <td>46</td>
          <td>653</td>
          <td>4</td>
          <td>1</td>
          <td>0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>60</td>
          <td>9652</td>
          <td>47881</td>
          <td>30</td>
          <td>555</td>
          <td>8</td>
          <td>0</td>
          <td>1</td>
        </tr>
      </tbody>
    </table>
    </div>



**Calcular estadísticas descriptivas:**

.. code:: ipython3

    credit_risk_data.describe()




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
          <th>Edad</th>
          <th>Ingresos</th>
          <th>Monto del Préstamo</th>
          <th>Plazo del Préstamo</th>
          <th>Historial de Crédito</th>
          <th>Cantidad de Créditos Vigentes</th>
          <th>Cantidad de Moras</th>
          <th>Estado del Préstamo</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>count</th>
          <td>1000.00000</td>
          <td>1000.000000</td>
          <td>1000.000000</td>
          <td>1000.000000</td>
          <td>1000.000000</td>
          <td>1000.000000</td>
          <td>1000.000000</td>
          <td>1000.000000</td>
        </tr>
        <tr>
          <th>mean</th>
          <td>43.81900</td>
          <td>10697.264000</td>
          <td>25332.751000</td>
          <td>36.150000</td>
          <td>576.485000</td>
          <td>4.622000</td>
          <td>1.971000</td>
          <td>0.778000</td>
        </tr>
        <tr>
          <th>std</th>
          <td>14.99103</td>
          <td>5393.517268</td>
          <td>13868.799451</td>
          <td>13.752477</td>
          <td>155.959954</td>
          <td>2.827209</td>
          <td>1.427654</td>
          <td>0.415799</td>
        </tr>
        <tr>
          <th>min</th>
          <td>18.00000</td>
          <td>1509.000000</td>
          <td>1097.000000</td>
          <td>12.000000</td>
          <td>300.000000</td>
          <td>0.000000</td>
          <td>0.000000</td>
          <td>0.000000</td>
        </tr>
        <tr>
          <th>25%</th>
          <td>31.00000</td>
          <td>5965.250000</td>
          <td>12909.250000</td>
          <td>24.000000</td>
          <td>440.000000</td>
          <td>2.000000</td>
          <td>1.000000</td>
          <td>1.000000</td>
        </tr>
        <tr>
          <th>50%</th>
          <td>44.00000</td>
          <td>10610.500000</td>
          <td>25791.000000</td>
          <td>36.500000</td>
          <td>575.000000</td>
          <td>5.000000</td>
          <td>2.000000</td>
          <td>1.000000</td>
        </tr>
        <tr>
          <th>75%</th>
          <td>56.00000</td>
          <td>15288.500000</td>
          <td>36621.750000</td>
          <td>48.000000</td>
          <td>712.250000</td>
          <td>7.000000</td>
          <td>3.000000</td>
          <td>1.000000</td>
        </tr>
        <tr>
          <th>max</th>
          <td>69.00000</td>
          <td>19958.000000</td>
          <td>49998.000000</td>
          <td>59.000000</td>
          <td>849.000000</td>
          <td>9.000000</td>
          <td>4.000000</td>
          <td>1.000000</td>
        </tr>
      </tbody>
    </table>
    </div>



**Histogramas:**

.. code:: ipython3

    credit_risk_data.hist(bins=20, figsize=(15, 10), layout=(3, 3), color="skyblue")
    plt.tight_layout()
    plt.show()



.. image:: output_11_0.png


**Coeficientes de correlación:**

.. code:: ipython3

    correlation_matrix = credit_risk_data.corr()
    
    plt.figure(figsize=(10, 8))
    sns.heatmap(correlation_matrix, annot=True, cmap="coolwarm", linewidths=0.5)
    plt.title("Matriz de Correlación de las Variables")
    plt.show()



.. image:: output_13_0.png


**Box plot:**

.. code:: ipython3

    plt.figure(figsize=(15, 10))
    
    for i, column in enumerate(credit_risk_data.columns, 1):
        plt.subplot(3, 3, i)
        sns.boxplot(data=credit_risk_data[column], color="skyblue")
        plt.title(f"Box Plot de {column}")
    
    plt.tight_layout()
    plt.show()



.. image:: output_15_0.png


**Pair plot:**

.. code:: ipython3

    sns.pairplot(credit_risk_data, palette="tab10")
    plt.show()



.. image:: output_17_0.png

