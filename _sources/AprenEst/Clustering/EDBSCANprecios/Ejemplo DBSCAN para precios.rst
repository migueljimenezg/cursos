Ejemplo DBSCAN para precios
---------------------------

**Creación de una serie de tiempo con saltos:**

.. code:: ipython3

    import numpy as np
    import matplotlib.pyplot as plt
    from sklearn.preprocessing import StandardScaler
    from sklearn.cluster import DBSCAN
    
    # Generar datos de precios simulados
    np.random.seed(34)
    n_samples = 1000
    prices = np.cumsum(np.random.normal(loc=0, scale=1, size=n_samples))
    
    # Introducir algunos saltos
    jump_indices = np.random.choice(n_samples, size=10, replace=False)
    prices[jump_indices] += np.random.normal(loc=0, scale=20, size=10)
    
    # Calcular los rendimientos (diferencias en los precios)
    returns = np.diff(prices)
    
    # Visualizar el precio
    plt.figure(figsize=(14, 7))
    plt.plot(prices, label="Precios")
    plt.xlabel("Tiempo")
    plt.ylabel("Precios")
    plt.title("Serie de tiempo con saltos")
    plt.legend()
    plt.show()



.. image:: output_2_0.png


**Rendimientos:**

.. code:: ipython3

    # Calcular los rendimientos (diferencias en los precios)
    returns = np.diff(prices)
    
    # Escalar los rendimientos
    scaler = StandardScaler()
    returns_scaled = scaler.fit_transform(returns.reshape(-1, 1))
    
    # Visualizar los rendimientos
    plt.figure(figsize=(14, 7))
    plt.plot(returns, label="Rendimientos")
    plt.xlabel("Tiempo")
    plt.ylabel("Rendimientos")
    plt.title("Rendimientos")
    plt.legend()
    plt.show()



.. image:: output_4_0.png


**Ajuste modelo DBSCAN:**

.. code:: ipython3

    # Aplicar DBSCAN para identificar saltos
    db = DBSCAN(eps=1, min_samples=5)
    db_labels = db.fit_predict(returns_scaled)

El cluster -1 es el de los datos atípicos, en este caso, los saltos.

.. code:: ipython3

    # Identificar los índices de los saltos
    jump_points = np.where(db_labels == -1)[0]
    print(jump_points)
    print("Cantidad de saltos identificados:", len(jump_points))


.. parsed-literal::

    [174 175 256 257 353 354 456 457 502 503 530 531 965 966]
    Cantidad de saltos identificados: 14
    

.. code:: ipython3

    # Visualizar los precios y los saltos identificados
    plt.figure(figsize=(14, 7))
    plt.plot(prices, label="Precios")
    plt.scatter(
        jump_points + 1,
        prices[jump_points + 1], # +1 para compensar la diferencia de rendimientos
        color="darkred",
        label="Saltos",
        marker="o",
    )  
    plt.xlabel("Tiempo")
    plt.ylabel("Precios")
    plt.title("Identificación de Saltos en los Precios usando DBSCAN")
    plt.legend()
    plt.show()



.. image:: output_9_0.png

