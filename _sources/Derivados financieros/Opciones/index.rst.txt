Opciones
==========================================


Las opciones financieras son derivados financieros negociados en las bolsas de valores y en el mercado OTC. Los compradores de las opciones adquieren un derecho y los vendedores de las opciones obtienen una obligación. Esto se hace por medio de un pago anticipado llamado prima que hacen los compradores y reciben los vendedores. Existen dos tipos de derechos: derecho a comprar o derecho a vender, es decir, opciones de compra y opciones de venta. El primero es el derecho a comprar el activo subyacente a un precio strike en una fecha determinada. El derecho a vender significa que los compradores de estas opciones tienen el derecho a vender el activo subyacente a un precio strike en una fecha determinada. En cambio, las contrapartes, los vendedores de las opciones, adquieren las siguientes obligaciones: los vendedores las opciones de compra adquieren la obligación de vender el activo subyacente a un precio strike en una fecha determinada y los vendedores las opciones de venta adquieren la obligación de comprar el activo subyacente a un precio strike en una fecha determinada. De esta manera, existen cuatro posiciones en las opciones:

* Comprar opciones de compra.

* Vender opciones de compra.

* Comprar opciones de venta.

* Vender opciones de venta.


Las opciones de compra se llaman opciones Call y las opciones de venta se llaman opciones Put.


1. Introducción a las opciones financieras
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Se explicará la mecánica de las opciones financieras, las coberturas (aseguramiento) con las opciones y las propiedades.


    * **Descargue** :download:`aquí <7. Opciones Financieras V4.pdf>` las presentaciones sobre opciones financieras.

        * **Ver video: Concepto opciones financieras.** --- `aquí <https://youtu.be/BelIOEdR-Xk>`_.

        * **Ver video: Coberturas con opciones** --- `aquí <https://youtu.be/vLq3SL4RKWU>`_.

        * **Ver video: Opciones OTC en Colombia** --- `aquí <https://youtu.be/d7XSi5r6WAg>`_.

    * **Descargue** :download:`aquí <8. Propiedades de las opciones sobre acciones V4.pdf>` las presentaciones sobre propiedades de las opciones financieras.

        * **Ver video: Propiedades de las opciones** --- `aquí <https://youtu.be/xOkV0gKGaVQ>`_.






2. Estrategias con opciones
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Estas estrategias consisten en portafolios de opciones. Los portafolios de opciones son la combinación de dos o más posiciones en las opciones.


    * **Descargue** :download:`aquí <9. Estrategias de negociación con opciones V3.pdf>` las presentaciones.

        * **Ver video: Estrategias con opciones** --- `aquí <https://youtu.be/ZTbR8dk7Tig>`_.

        * **Descargue** :download:`aquí <Estrategias de negociación con opciones V2.xlsx>` archivo de Excel.

    * **Descargue** :download:`aquí <Opciones Corficolombiana.pdf>` Opciones de Corficolombiana.

        * **Ver video: Opciones Corficolombiana** --- `aquí <https://youtu.be/y-Smtws4EVs>`_.


.. seealso:: **Ejemplos en Excel de Opciones sin valoración:** :download:`aquí <Ejemplos en Excel-Opciones sin valoración.xlsx>` archivo de Excel.

             * **Ver video** --- `aquí <https://youtu.be/NaU_YO_o8AM>`_.   
             
3. Valoración de opciones por el método de Simulación Monte Carlo
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Este método de valoración sólo aplica para las opciones europeas. Se modela el precio del activo subyacente con el proceso estocástico de Movimiento Browniano Geométrico (MBG).


3.1. Movimiento Browniano Geométrico (MBG)
-----------------------------------------------------

    * **Descargue** :download:`aquí <../../Riesgo de mercado/VaR SM/Tres acciones.csv>` el archivo ``Tres acciones.csv``.



    * **Descargue** :download:`aquí <../../Riesgo de mercado/VaR SM/7. Movimiento Browniano Geométrico.pdf>` las presentaciones del MBG.

        * **Ver video 1** --- `aquí <https://youtu.be/EFEpTFfTuVQ>`_.

        * **Ver video 2** --- `aquí <https://youtu.be/AkpLFOB6R4I>`_.
 
        * **Ver video 3** --- `aquí <https://youtu.be/bZHyAgyiOaU>`_.

        * **Ver video 4** --- `aquí <https://youtu.be/w4TfWZCuiYY>`_.


    .. toctree::
            :maxdepth: 2
            :titlesonly:


            ../../Riesgo de mercado/VaR SM/MBG/Movimiento Browniano Geométrico.rst


        
    * **Descargue** :download:`aquí <../../Riesgo de mercado/VaR SM/MBG/Movimiento Browniano Geométrico.r>` el código.

        * **Ver video 1** --- `aquí <https://youtu.be/KQUueUflXx0>`_.

        * **Ver video 2** --- `aquí <https://youtu.be/yuN3Y5amVEs>`_.

        * **Ver video 3** --- `aquí <https://youtu.be/uljKsFMHTV4>`_.


3.2. Método de Simulación Monte Carlo para valorar opciones europeas
------------------------------------------------------------------------------

El drift para valorar opciones debe ser la tasa libre de riesgo para activos sin ingresos o la devaluación implícita para divisas.


    * **Descargue** :download:`aquí <TRM diaria febrero 2020.csv>` el archivo ``TRM diaria febrero 2020.csv``.



    .. toctree::
            :maxdepth: 2
            :titlesonly:


            Valoración de opciones por el método de Simulación Monte Carlo/Valoración de opciones por el método de Simulación Monte Carlo.rst


    * **Descargue** :download:`aquí <Valoración de opciones por el método de Simulación Monte Carlo/Valoración de opciones por el método de Simulación Monte Carlo.r>` el código.

        * **Ver video:** --- `aquí <https://youtu.be/d07LvPH0Xnw>`_.



3.3. Simulación de estrategias de cobertura con opciones
------------------------------------------------------------------------------


    .. toctree::
            :maxdepth: 2
            :titlesonly:


            Simulación de cobertura con opciones/Simulación de cobertura con opciones.rst


    * **Descargue** :download:`aquí <Simulación de cobertura con opciones/Simulación de cobertura con opciones.r>` el código.

        * **Ver video:** --- `aquí <https://youtu.be/8U6brTCjreI>`_.


3.4. Simulación en Python
------------------------------------------------------------------------------

.. important::

    .. toctree::
            :maxdepth: 2
            :titlesonly:

            Movimiento Browniano Geométrico (GBM) en Python/Movimiento Browniano Geométrico (GBM) en Python.rst

    * **Descargue** :download:`Precio-ECO.csv <Movimiento Browniano Geométrico (GBM) en Python/Precio-ECO.csv>`

    * **Descargue** :download:`Precio-ECO-mensual.csv <Movimiento Browniano Geométrico (GBM) en Python/Precio-ECO-mensual.csv>`

    .. toctree::
            :maxdepth: 2
            :titlesonly:

            Valoración de Opciones Financieras por Simulación Monte Carlo/Valoración de Opciones Financieras por Simulación Monte Carlo.rst

    * **Descargue** :download:`TRM.csv <Valoración de Opciones Financieras por Simulación Monte Carlo/TRM.csv>`

    .. toctree::
            :maxdepth: 2
            :titlesonly:

            Simulación estrategia de cobertura/Simulación estrategia de cobertura.rst



__________________________________________________________________________

    .. toctree::
            :maxdepth: 2
            :titlesonly:

            Ejercicios propiedades, coberturas y valoración de opciones por SMC.rst


    * **Descargue** :download:`aquí <TRM 2020 (ejercicios).csv>` el archivo ``TRM 2020 (ejercicios).csv``.

__________________________________________________________________________


4. Valoración de opciones por el método de Árboles Binomiales
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Este método de valoración de opciones aplica para opciones europeas y americanas.


    * **Descargue** :download:`aquí <10. Árboles binomiales V2.pdf>` las presentaciones.

        * **Ver video: Árboles binomiales** --- `aquí <https://youtu.be/lZNVagKh5B8>`_.


5. Valoración de opciones por el método de Black-Scholes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Este método de valoración de opciones aplica sólo para opciones europeas.


    * **Descargue** :download:`aquí <11. Modelo Black – Scholes V4.pdf>` las presentaciones.

        * **Ver video: Black-Scholes** --- `aquí <https://youtu.be/eRyn8HKOtzM>`_.

        * **Ver video: The Midas Formula** --- `aquí <https://www.dailymotion.com/video/x225si7>`_.

    * **Descargue** :download:`aquí <Ejemplos - Black - Scholes.xlsx>` ejemplo en Excel de Black-Scholes

__________________________________________________________________________


    * **Macro de Excel DerivaGem:** :download:`aquí <DG201.xls>` para valorar opciones por Árboles Binomiales y Black-Scholes.

__________________________________________________________________________



.. seealso:: **Ejemplos Árboles Binomiales y Black-Scholes con DerivaGem:** :download:`aquí <Ejemplos valoración de opciones por AB y BS.xlsx>` archivo de Excel.

             * **Ver video** --- `aquí <https://youtu.be/6YuIKo3Do5I>`_.

             **Ejemplos en Excel de Opciones con valoración:** :download:`aquí <Ejemplos en Excel-Opciones con valoración.xlsx>` archivo de Excel.

             * **Ver video** --- `aquí <https://youtu.be/mRS3KfPpXj0>`_.


__________________________________________________________________________

    .. toctree::
            :maxdepth: 2
            :titlesonly:


            Ejercicios valoración de opciones.rst


__________________________________________________________________________


**Lecturas**


.. [#f1] **Capítulo 8: Mecánica de las opciones** Introducción a los mercados de futuros y opciones. John C. Hull. Sexta edición.



.. [#f2] **BVC: Opciones sobre acciones.** 

    * **Descargue** :download:`aquí <1. Opciones sobre acciones.pdf>` el documento.


.. [#f3] **BVC: Opciones TRM.** 

    * **Descargue** :download:`aquí <2. Opciones TRM.pdf>` el documento.


.. [#f4] **Capítulo 9: Propiedades de las opciones sobre acciones** Introducción a los mercados de futuros y opciones. John C. Hull. Sexta edición.




.. [#f5] **Capítulo 10: Estrategias de negociación que incluyen opciones** Introducción a los mercados de futuros y opciones. John C. Hull. Sexta edición.




.. [#f6] **BVC: Estrategias de opciones.** 

    * **Descargue** :download:`aquí <4. Estrategias.pdf>` el documento.


.. [#f7] **Capítulo 11: Introducción a los árboles binomiales** Introducción a los mercados de futuros y opciones. John C. Hull. Sexta edición.




.. [#f8] **Capítulo 12: Valuación de opciones sobre acciones: modelo Black-Scholes** Introducción a los mercados de futuros y opciones. John C. Hull. Sexta edición.




.. [#f9] **BVC: Valoración de opciones.** 

    * **Descargue** :download:`aquí <5. Valoración de opciones.pdf>` el documento.


.. [#f10] **Capítulo 17: Dinámica de precios y valuación de opciones.** Simulación de modelos financieros. Luciano Machain.







