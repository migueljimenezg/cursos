Introducción a Python
---------------------

Variables:
~~~~~~~~~~

Las variables pueden tener un nombre corto como una sola letra, por
ejemplo, ``x`` o pueden ser más descriptibos como ``nombre``,
``estrato``, ``peso``, etc.

El nombre de la varible debe empezar por una letra y no por un número,
puede tener guión medio ``-``, guión bajo ``_``, números y letras en
mayúsculas: ``nombre_1``, ``Nombre_1``. Estas dos variables son
diferentes porque la segunda tiene una mayúscula, igualmente, la
variable ``peso`` es diferente a ``PESO``.

.. code:: ipython3

    nombre = "Juan"
    nombre2 = "Jose"
    peso = 60
    
    print(nombre, nombre2, peso)


.. parsed-literal::

    Juan Jose 60
    

Se puede usar las dobles comillas ``" "`` o las comillas sencillas
``´´``

.. code:: ipython3

    nombre = "Juan"
    nombre2 = "Jose"
    print(nombre, nombre2)


.. parsed-literal::

    Juan Jose
    

Se pueden asignar valor a varias variables en una sola línea:

.. code:: ipython3

    nombre, nombre2, peso = "Juan", "Jose", 60
    print(nombre, nombre2, peso)


.. parsed-literal::

    Juan Jose 60
    

Si los valores están en una lista, se pueden asignar a las variables en
una sola línea:

.. code:: ipython3

    valores = ["Juan", "Jose", 60]
    nombre, nombre2, peso = valores
    print(nombre, nombre2, peso)


.. parsed-literal::

    Juan Jose 60
    

Tipos de datos:
~~~~~~~~~~~~~~~

``str``: string.

``int``, ``float`` ``complex``: numéricos.

``list``, ``tuple``, ``range``: secuencia.

``bool``: boleano.

Entre otros.

Para saber el tipo de dato se usa la función ``type()``.

.. code:: ipython3

    nombre = "Juan"
    type(nombre)




.. parsed-literal::

    str



.. code:: ipython3

    peso = 60
    type(peso)




.. parsed-literal::

    int



``int`` son números enteros sin el punto decimal.

.. code:: ipython3

    edad = 40.0
    type(edad)




.. parsed-literal::

    float



Note que los datos del tipo ``float`` tienen decimales, se expresan con
números y el ``.``, es común que para asignar el tipo de ``float`` solo
es necesario el punto así:

.. code:: ipython3

    edad = 40.0
    type(edad)




.. parsed-literal::

    float



.. code:: ipython3

    x = list(("Juan", "Jose", 40))
    print(x)
    type(x)


.. parsed-literal::

    ['Juan', 'Jose', 40]
    



.. parsed-literal::

    list



.. code:: ipython3

    x = tuple(("Juan", "Jose", 40))
    print(x)
    type(x)


.. parsed-literal::

    ('Juan', 'Jose', 40)
    



.. parsed-literal::

    tuple



.. code:: ipython3

    x = range(8)
    print(x)
    type(x)


.. parsed-literal::

    range(0, 8)
    



.. parsed-literal::

    range



.. code:: ipython3

    x = dict(nombre="Juan", edad=40)
    print(x)
    type(x)


.. parsed-literal::

    {'nombre': 'Juan', 'edad': 40}
    



.. parsed-literal::

    dict



Para especificar el tipo de dato se usan las siguientes funciones:
``int()``, ``float()``, ``str()``.

.. code:: ipython3

    a = int(20)
    b = float(4)  # con esta función no es necesario agregar el punto.
    c = int("25")  # "25" es un string, pero esta función lo convierte en número.
    d = str("Juan")
    e = str(100)  # 100 es numérico pero esta función lo convierte en string
    print(a, b, c, d, e)


.. parsed-literal::

    20 4.0 25 Juan 100
    

.. code:: ipython3

    type(e)




.. parsed-literal::

    str



.. code:: ipython3

    frase = "Esta es una frase en una línea"
    print(frase)


.. parsed-literal::

    Esta es una frase en una línea
    

Las tres comillas dobles ``"""`` o sencillas ``'''`` permiten crear
string en varias líneas así:

.. code:: ipython3

    frase = """Esta es una frase muy larga
    de más de una línea de
    código"""
    print(frase)


.. parsed-literal::

    Esta es una frase muy larga
    de más de una línea de
    código
    

Operaciones:
~~~~~~~~~~~~

``+``: Adición.

``-``: Sustracción.

``*``: Multiplicación.

``/``: División.

``%``: Módulo. Es el residuo de una división.

``**``: Exponencial.

``//``: División, pero aproxima al entero menor.

.. code:: ipython3

    5 / 5




.. parsed-literal::

    1.0



.. code:: ipython3

    5 % 5




.. parsed-literal::

    0



.. code:: ipython3

    5 % 15




.. parsed-literal::

    5



.. code:: ipython3

    5 // 15




.. parsed-literal::

    0



.. code:: ipython3

    10 / 3




.. parsed-literal::

    3.3333333333333335



.. code:: ipython3

    10 // 3




.. parsed-literal::

    3



``==``: Igual.

``!=``: Diferente.

``>``: Mayor que.

``<``: Menor que.

``>=``: Mayor e igual que.

``<=``: Menor e igual que.

``&``: AND.

``|``: OR.

.. code:: ipython3

    3 == 3




.. parsed-literal::

    True



.. code:: ipython3

    3 == 5




.. parsed-literal::

    False



.. code:: ipython3

    3 + 5 & 7 + 1 == 8




.. parsed-literal::

    True



Listas:
~~~~~~~

Con las listas se almacenan varios elementos en una sola variable.
Similares a las listas están ``tuple`` (tuplas), ``set`` y ``dicy``
(diccionarios).

Las listas se crean usando corchetes ``[]``.

Los elementos de la lista tienen un orden de ubicación, es decir, están
indexados, el primer elemento es el índice cero [0] (index 0), este es
una gran diferencia entre otros lenguales de programación como ``R``
donde el primer elemento es el ``1``.

El segundo elemento de una lista tiene el index [1] y así sucesivamente.

.. code:: ipython3

    lista = [542.0, 20, 20, 20, "Juan", "Jose", True]
    print(lista)


.. parsed-literal::

    [542.0, 20, 20, 20, 'Juan', 'Jose', True]
    

.. code:: ipython3

    type(lista)




.. parsed-literal::

    list



Para saber la cantidad de elementos de la lista se usa la función
``len()``.

.. code:: ipython3

    len(lista)




.. parsed-literal::

    7



Otra forma de crear la lista anterior es con la función ``list()``. En
este caso no se usan los corchetes ``[]``.

.. code:: ipython3

    lista = list((542.0, 20, 20, 20, "Juan", "Jose", True))
    print(lista)


.. parsed-literal::

    [542.0, 20, 20, 20, 'Juan', 'Jose', True]
    

En resumen, las listas ``list`` son un conjunto de elementos ordenados
modificables y permite duplicados. Tienen corchetes ``[]``.

Las tuplas ``tuple`` son un conjunto de elementos ordenados,
**inmutables** y permite duplicados. Tienen paréntesis ``[]``.

``set`` es un conjeto desordenado, inmutable, no indexado y no hay
duplicados. Tinen corchetes ``{}``.

``dict`` es un conjunto ordenado, modificable y no hay elementos
duplicados. Tinen corchetes ``{}``, pero con clave y valor.

**Tupla:**

.. code:: ipython3

    tupla = ("Juan", "Jose", 40)
    print(tupla)


.. parsed-literal::

    ('Juan', 'Jose', 40)
    

.. code:: ipython3

    type(tupla)




.. parsed-literal::

    tuple



.. code:: ipython3

    un_set = {"Juan", "Jose", 40}
    print(un_set)


.. parsed-literal::

    {40, 'Jose', 'Juan'}
    

.. code:: ipython3

    type(un_set)




.. parsed-literal::

    set



.. code:: ipython3

    diccionario = {"clave": "valor"}
    print(diccionario)


.. parsed-literal::

    {'clave': 'valor'}
    

.. code:: ipython3

    type(diccionario)




.. parsed-literal::

    dict



.. code:: ipython3

    diccionario_2 = {"Juan": 25, "Jose": 40, "Esteban": "Hombre"}
    print(diccionario_2)


.. parsed-literal::

    {'Juan': 25, 'Jose': 40, 'Esteban': 'Hombre'}
    
