Volatilidad portafolio de inversión
-----------------------------------

La varianza es el cuadrado de la dispersión alrededor de la media
(:math:`\sigma^2`).

La desviación estándar, o también llamada volatilidad, es la raíz
cuadrada de la varianza. Tiene las mismas unidades que la variable
original.

Forma polinomial
~~~~~~~~~~~~~~~~

.. math::  \sigma_P=\sqrt{\sum_{i=1}^n\sum_{j=1}^nw_iw_j\sigma_{i,j}}=\sqrt{\sum_{i=1}^n\sum_{j=1}^nw_iw_j\sigma_j\sigma_j\rho_{i,j}}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. math:: \sigma_P=\sqrt{\sum_{i=1}^nw_i^2\sigma_i^2+2\sum_{i<j}w_iw_j\sigma_i\sigma_j\rho_{i,j}}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Varianza entre dos activos.
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. math:: \sigma_P^2=w_A^2\sigma_A^2+w_B^2\sigma_B^2+2w_Aw_B\sigma_{A,B}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:math:`\sigma_p^2:` varianza del portafolio de inversión.

:math:`\sigma_A^2:` varianza activo A.

:math:`\sigma_B^2:` varianza activo B.

:math:`w_A^2:` proporción de inversión en A al cuadrado.

:math:`w_B^2:` proporción de inversión en B al cuadrado.

:math:`w_A:` proporción de inversión en A.

:math:`w_B:` proporción de inversión en B.

:math:`\sigma_{A,B}:` covarianza entre A y B.

Volatilidad de dos activos.
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. math:: \sigma_P=\sqrt{w_A^2\sigma_A^2+w_B^2\sigma_B^2+2w_Aw_B\sigma_{A,B}}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:math:`\sigma_p:` volatilidad o desviación estándar del portafolio de
inversión.

.. math::  \sigma_{A,B}=\sigma_A  \sigma_B\rho_{A,B}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:math:`\rho_{A,B}:` coeficiente de correlación entre A y B.

.. math:: \sigma_P=\sqrt{w_A^2\sigma_A^2+w_B^2\sigma_B^2+2w_Aw_B\sigma_A\sigma_B\rho_{A,B}}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ejemplo:
~~~~~~~~

============ =========== =======================
\            Volatilidad Proporción de inversión
============ =========== =======================
**Acción A** 2%          70%
**Acción B** 5%          30%
============ =========== =======================

.. math:: \rho_{A,B}=0,67

.. code:: r

    volatilidad_portafolio = sqrt(0.7^2*0.02^2 + 0.3^2*0.05^2 + 2*0.7*0.3*0.02*0.05*0.67)
    volatilidad_portafolio



.. raw:: html

    0.0265028300375639


Volatilidad del portafolio de inversión de 2,65%.

Ejemplo:
~~~~~~~~

============ =========== =======================
\            Volatilidad Proporción de inversión
============ =========== =======================
**Acción A** 2%          30%
**Acción B** 5%          70%
============ =========== =======================

.. math:: \rho_{A,B}=0,67

.. code:: r

    volatilidad_portafolio = sqrt(0.30^2*0.02^2 + 0.70^2*0.05^2 + 2*0.30*0.70*0.02*0.05*0.67)
    volatilidad_portafolio



.. raw:: html

    0.0392734006676274


Volatilidad del portafolio de inversión de 3,93%.

Volatilidad de tres activos.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. math:: \sigma_P=\sqrt{w_A^2\sigma_A^2+w_B^2\sigma_B^2+w_C^2\sigma_C^2+2w_Aw_B\sigma_{A,B}+2w_Aw_C\sigma_{A,C}+2w_Bw_C\sigma_{B,C}}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. math:: \sigma_P=\sqrt{w_A^2\sigma_A^2+w_B^2\sigma_B^2+w_C^2\sigma_C^2+2w_Aw_B\sigma_A\sigma_B\rho_{A,B}+2w_Aw_C\sigma_A\sigma_C\rho_{A,C}+2w_Bw_C\sigma_B\sigma_C\rho_{B,C}}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ejemplo:
~~~~~~~~

============ =========== =======================
\            Volatilidad Proporción de inversión
============ =========== =======================
**Acción A** 2%          20%
**Acción B** 4%          50%
**Acción C** 3,2%        30%
============ =========== =======================

Matriz de coeficientes de correlación:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

============ ============ ============ ============
\            **Acción A** **Acción B** **Acción C**
============ ============ ============ ============
**Acción A** 1            0,52         0,32
**Acción B** 0,52         1            0,48
**Acción C** 0,42         0,48         1
============ ============ ============ ============

.. code:: r

    volatilidad_portafolio = sqrt(0.20^2*0.02^2 + 0.50^2*0.04^2 + 0.30^2*0.032^2 + 2*0.20*0.50*0.02*0.04*0.52 + 2*0.20*0.30*0.02*0.032*0.42 + 2*0.50*0.30*0.04*0.032)
    volatilidad_portafolio



.. raw:: html

    0.0317429677251513


Volatilidad del portafolio de inversión de 3,17%.

Forma matricial
~~~~~~~~~~~~~~~

Varianza entre dos activos
~~~~~~~~~~~~~~~~~~~~~~~~~~

|image0|

.. |image0| image:: matricial.jpg

Ejemplo:
~~~~~~~~

============ =========== =======================
\            Volatilidad Proporción de inversión
============ =========== =======================
**Acción A** 2%          70%
**Acción B** 5%          30%
============ =========== =======================

Matriz de varianzas-covarianzas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

============ ============ ============
\            **Acción A** **Acción B**
============ ============ ============
**Acción A** 0,0010196809 0,0005939468
**Acción B** 0,0005939468 0,0008155434
============ ============ ============

Vector de proporciones.
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    proporciones = c(0.70, 0.30)
    proporciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.7</li><li>0.3</li></ol>
    


Es importante conocer si el vector de ``proporciones`` está en posición
horizontal o vertical. La ecuación de volatilidad en forma matricial,
indica que primero el vector de ``proporciones`` debe estár horizontal y
después vertical.

Matriz de varianzas-covarianzas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Si utilizamos ``cbind``, entonces cada vector será una columna.

.. code:: r

    vector_1 = c(0.0010196809, 0.0005939468)
    
    vector_2 = c(0.0005939468, 0.0008155434)
    
    covarianzas = cbind(vector_1, vector_2)
    covarianzas



.. raw:: html

    <table>
    <caption>A matrix: 2 × 2 of type dbl</caption>
    <thead>
    	<tr><th scope=col>vector_1</th><th scope=col>vector_2</th></tr>
    </thead>
    <tbody>
    	<tr><td>0.0010196809</td><td>0.0005939468</td></tr>
    	<tr><td>0.0005939468</td><td>0.0008155434</td></tr>
    </tbody>
    </table>
    


.. code:: r

    volatilidad_portafolio = sqrt(sum(proporciones%*%covarianzas*t(proporciones)))
    volatilidad_portafolio



.. raw:: html

    0.0286792643385426


Volatilidad del portafolio de inversión de 2,87%.

Ejemplo con histórico de precios
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Importar datos.
~~~~~~~~~~~~~~~

.. code:: r

    datos = read.csv("Cuatro acciones 2020.csv", sep = ";", dec = ",", header = T)

Matriz de precios.
~~~~~~~~~~~~~~~~~~

.. code:: r

    precios = datos[,-1]

.. code:: r

    precios = ts(precios)

Nombres de las acciones.
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    nombres = colnames(precios)
    nombres



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>'ECO'</li><li>'PFAVAL'</li><li>'ISA'</li><li>'NUTRESA'</li></ol>
    


Matriz de rendimientos.
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos = diff(log(precios))

Volatilidad de cada acción.
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidades = apply(rendimientos, 2, sd)
    volatilidades



.. raw:: html

    <style>
    .dl-inline {width: auto; margin:0; padding: 0}
    .dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}
    .dl-inline>dt::after {content: ":\0020"; padding-right: .5ex}
    .dl-inline>dt:not(:first-of-type) {padding-left: .5ex}
    </style><dl class=dl-inline><dt>ECO</dt><dd>0.0319324424190137</dd><dt>PFAVAL</dt><dd>0.0285577211893029</dd><dt>ISA</dt><dd>0.0237292026947701</dd><dt>NUTRESA</dt><dd>0.0140104740592151</dd></dl>
    


Matriz de varianzas-covarianzas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    covarianzas = cov(rendimientos)
    covarianzas



.. raw:: html

    <table>
    <caption>A matrix: 4 × 4 of type dbl</caption>
    <thead>
    	<tr><th></th><th scope=col>ECO</th><th scope=col>PFAVAL</th><th scope=col>ISA</th><th scope=col>NUTRESA</th></tr>
    </thead>
    <tbody>
    	<tr><th scope=row>ECO</th><td>0.0010196809</td><td>0.0005939468</td><td>0.0001160327</td><td>0.0001493216</td></tr>
    	<tr><th scope=row>PFAVAL</th><td>0.0005939468</td><td>0.0008155434</td><td>0.0001564360</td><td>0.0001322689</td></tr>
    	<tr><th scope=row>ISA</th><td>0.0001160327</td><td>0.0001564360</td><td>0.0005630751</td><td>0.0001519996</td></tr>
    	<tr><th scope=row>NUTRESA</th><td>0.0001493216</td><td>0.0001322689</td><td>0.0001519996</td><td>0.0001962934</td></tr>
    </tbody>
    </table>
    


Proporciones de inversión.
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    proporciones = c(0.20, 0.30, 0.40, 0.10)
    proporciones



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.2</li><li>0.3</li><li>0.4</li><li>0.1</li></ol>
    


Volatilidad del portafolio de inversión (forma matricial).
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad_portafolio = sqrt(sum(proporciones*covarianzas*t(proporciones)))
    volatilidad_portafolio


::


    Error in proporciones * covarianzas * t(proporciones): arreglos de dimensón no compatibles
    Traceback:
    


Para corregir el error anterior, debemos poner en la primera
multiplicación ``%*%``, que en código de R se utiliza para
multiplicación de vectores y matrices.

.. code:: r

    volatilidad_portafolio = sqrt(sum(proporciones%*%covarianzas*t(proporciones)))
    volatilidad_portafolio



.. raw:: html

    0.0189655883295511


Volatilida del portafolio de inversión de 1,897% diaria.

Volatilidad del portafolio de inversión a partir de los rendimientos de las acciones.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Rendimientos del portafolio de inversión.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    rendimientos_portafolio = vector()
    
    for(i in 1:nrow(rendimientos)){
        
      rendimientos_portafolio[i] = sum(rendimientos[i,]*proporciones)
    }

Volatilidad del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    volatilidad_portafolio = sd(rendimientos_portafolio)
    volatilidad_portafolio



.. raw:: html

    0.0189655883295511


Se obtiene el mismo resultado que por la forma matricial. Este método se
puede usar sólo cuando se tienen los históricos de precios.
