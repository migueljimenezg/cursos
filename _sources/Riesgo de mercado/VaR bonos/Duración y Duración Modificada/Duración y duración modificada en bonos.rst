Duración y duración modificada en bonos
---------------------------------------

Duración
~~~~~~~~

Resume todos los factores que afectan la sensibilidad del precio del
bono a los cambios en las tasas de interés.

Calcula el valor actual de cada uno de los flujos de efectivo y pondera
cada uno por el tiempo hasta que se reciba. Todos estos flujos de
efectivo ponderados se suman y la suma se divide entre el precio actual
del bono.

Los bonos con duraciones más altas son muy sensibles a los cambios en
las tasas de interés.

Depende de tres variables:

1. Tiempo hasta el vencimiento.

2. Tasa cupón.

3. Rendimiento.

.. figure:: FormulaDuracion.jpg
   :alt: 1

   1

También tiene el nombre de Duración de Macaulay.

:math:`P:` Precio del bono.

:math:`C_t:` Flujo de efectivo proveniente del bono que ocurre en el
momento :math:`t` (Cupón).

:math:`TIR:` Rendimiento.

:math:`t:` Tiempo medido desde el presente hasta que se haga un pago.

Duración Modificada
~~~~~~~~~~~~~~~~~~~

Mide la sensibilidad del precio del bono con respecto a los cambios en
el rendimiento, es decir, mide la sensibilidad de este tipo de activo
financiero ante las variaciones de los tipos de interés.

A diferencia de la duración de Macaulay, que se mide en años, la
Duración Modificada es un porcentaje que indica la variación que se
produce en el precio de mercado de un activo financiero por cada punto
de variación en los tipos de interés.

.. figure:: FormulaDuracionM.jpg
   :alt: 2

   2

:math:`∆P:` Variación en el precio del bono.

:math:`D:` Duración.

:math:`∆:` Cambio en la tasa de interés.

:math:`TIR:` Rendimiento.

:math:`P:` Precio del bono.

Instalar el paquete ``jrvFinance`` con el siguiente código:
``install.packages("jrvFinance")``

Despúes llamar la librería con el siguiente código:
``library(jrvFinance)``

Se utiliza la función ``bond.durations()`` con la siguiente información:

``settle``: día de liquidación.

``mature``: día de vencimiento.

``coupon``: tasa cupón en decimales.

``freq``: ``1`` si el bono un cupón al año, ``2`` si paga dos veces,
hasta ``12`` veces.

``yield``: rendimiento del bono en decimales.

``convention``: ``"ACT/ACT"``.

``modified``: ``F`` para calcular duración o ``T`` para calcular
duración modificada.

``redemption_value``: ``100`` para bonos con nominal de 100.

``bond.durations(settle, mature, coupon, freq, yield, convention, modified, redemption_value)``

Ejemplo 1: Bono
~~~~~~~~~~~~~~~

**Referencia:**
`TFIT10040522 <https://www.bvc.com.co/pps/tibco/portalbvc/Home/Mercados/enlinea/rentafija?com.tibco.ps.pagesvc.renderParams.sub5d9e2b27_11de9ed172b_-73dc7f000001=action%3DdetalleView%26org.springframework.web.portlet.mvc.ImplicitModel%3Dtrue%26>`__

**Precio sucio:** 109,435 (Este valor no es necesario tenerlo en cuenta
en el código, porque se calcula automáticamente con los siguientes
datos).

**Rendimiento:** 5,4%.

**Nominal:** 100.

**Tasa cupón:** 7%.

**Frecuencia cupón:** Anual.

**Día de liquidación:** 2020-04-01.

**Día de vencimiento:** 2022-05-04.

.. code:: r

    library(jrvFinance)


.. parsed-literal::

    Warning message:
    "package 'jrvFinance' was built under R version 3.6.3"
    

Duración
~~~~~~~~

.. code:: r

    duracion = bond.durations(settle = "2020-04-01", mature = "2022-05-04", coupon = 0.07, freq = 1, yield = 0.054, convention = "ACT/ACT", modified = F, redemption_value = 100)
    duracion



.. raw:: html

    1.90244395260519


Duración modificada
~~~~~~~~~~~~~~~~~~~

.. code:: r

    duracion_modificada = bond.durations(settle = "2020-04-01", mature = "2022-05-04", coupon = 0.07, freq = 1, yield = 0.0534, convention = "ACT/ACT", modified = T, redemption_value = 100)
    duracion_modificada



.. raw:: html

    1.80615455897856


Ejemplo 2: Bono
~~~~~~~~~~~~~~~

**Referencia:**
`TFIT16280428 <https://www.bvc.com.co/pps/tibco/portalbvc/Home/Mercados/enlinea/rentafija?com.tibco.ps.pagesvc.renderParams.sub5d9e2b27_11de9ed172b_-73dc7f000001=action%3DdetalleView%26org.springframework.web.portlet.mvc.ImplicitModel%3Dtrue%26>`__

**Precio sucio:** 98,381 (Este valor no es necesario tenerlo en cuenta
en el código, porque se calcula automáticamente con los siguientes
datos).

**Rendimiento:** 7,2%.

**Nominal:** 100.

**Tasa cupón:** 6%.

**Frecuencia cupón:** Anual.

**Día de liquidación:** 2020-04-01.

**Día de vencimiento:** 2028-04-28.

Duración
~~~~~~~~

.. code:: r

    duracion = bond.durations(settle = "2020-04-01", mature = "2028-04-28", coupon = 0.06, freq = 1,yield = 0.072, convention = "ACT/ACT", modified = F, redemption_value = 100)
    duracion



.. raw:: html

    6.1995550793882


Duración modificada
~~~~~~~~~~~~~~~~~~~

.. code:: r

    duracion_modificada = bond.durations(settle = "2020-04-01", mature = "2028-04-28", coupon = 0.06, freq = 1, yield = 0.072, convention = "ACT/ACT", modified = T, redemption_value = 100)
    duracion_modificada



.. raw:: html

    5.7831670516681

