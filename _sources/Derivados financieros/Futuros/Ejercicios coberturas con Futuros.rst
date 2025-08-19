Ejercicios coberturas con Futuros
==========================================

1.	Un exportador recibirá un pago por valor de 60.000 USD el 7 de abril.

Actualmente en la BVC se tienen los siguientes Futuros sobre divisas:

TRMH21F con precio de 2.903,31, TRMJ21F con precio de 2.934,70 y TRSH21F con precio de 2.904,70.

Si el precio de los Futuros disminuye un 4% para el 7 de abril, ¿cuál es el valor de la compensación si la empresa hubiera realizado la cobertura con Futuros desde el día de hoy hasta el 7 de abril?

Nota: seleccionar los contratos en los Futuros para que la razón de cobertura sea lo más aproximada al 100%.

**Respuesta: $5.869.400.**

2.	Suponga que estamos en septiembre de 2020. Una empresa debe pagar la cuota de un préstamo en dólares la primera semana de noviembre de 2020 por valor de 21.000 USD. Para mitigar el riesgo cambiario asociado a este préstamo, decide cubrir la compra de los dólares para el pago de la cuota utilizando los Futuros de la BVC. La siguiente tabla muestra los futuros disponibles.

+---------------------+-----------------------+
| **NEMOTÉCNICO**     |  **PRECIO FUTURO**    | 
+=====================+=======================+
|TRMH21F	      |$ 3.106,50             |
+---------------------+-----------------------+
|TRMU20F	      |$ 3.068,83             |
+---------------------+-----------------------+
|TRMV20F	      |$ 3.072,48             |
+---------------------+-----------------------+
|TRMX20F	      |$ 3.086,93             |
+---------------------+-----------------------+
|TRMZ20F	      |$ 3.081,58             |
+---------------------+-----------------------+
|TRSU20F	      |$ 3.070,93             |
+---------------------+-----------------------+
|TRSV20F	      |$ 3.073,05             |
+---------------------+-----------------------+
|TRSX20F	      |$ 3.078,63             |
+---------------------+-----------------------+
|TRSZ20F	      |$ 3.082,13             |
+---------------------+-----------------------+


La cobertura con los futuros se realizará por la cantidad que más se aproxime a los 21.000 USD.

Para obtener un mejor precio con cobertura, los coberturistas en largo buscan precios bajos en los Futuros, en cambio, los coberturistas en corto buscan precios altos.

Determine el precio con cobertura después de costos de transacción.

Los precios de mercado para la primera semana de noviembre son los siguientes: precio spot (TRM) de $3.150 y precios Futuros:

+---------------------+-----------------------+
| **NEMOTÉCNICO**     |  **PRECIO FUTURO**    | 
+=====================+=======================+
|TRMH21F	      |$ 3.200,54             |
+---------------------+-----------------------+
|TRMX20F	      |$ 3.128,40             |
+---------------------+-----------------------+
|TRMZ20F	      |$ 3.057,00             |
+---------------------+-----------------------+
|TRSX20F	      |$ 3.147,98             |
+---------------------+-----------------------+
|TRSZ20F	      |$ 3.100,63             |
+---------------------+-----------------------+

Suponga comisión variable de 0,3% sobre el nominal, IVA del 19% sobre el total de la comisión.

**Respuesta: $3.105,12.**

3.	Un inversionista posee 200.000 acciones de una empresa del sector tecnológico, ante el temor de una disminución del precio de la acción para dentro de un mes, desea realizar una cobertura. Sin embargo, en la bolsa no cuenta con Futuros sobre esta acción, aunque existen Futuros sobre acción de otra empresa del mismo sector (acción X). De esta forma, el inversionista realizará la cobertura tomado de base los siguientes datos históricos hasta el día de hoy:


+----------+-----------------+--------------------+
|**Date**  |**Precio acción**|**Futuro acción X** |
+==========+=================+====================+
|01/10/2019|	31,785	     |43,43               |	
+----------+-----------------+--------------------+     	
|02/11/2019|	30,980	     |43,63               |	 
+----------+-----------------+--------------------+ 
|01/12/2019|	31,035	     |45,33               |	  
+----------+-----------------+--------------------+
|01/01/2020|	26,605	     |41,21               |	  
+----------+-----------------+--------------------+
|01/02/2020|	28,490	     |44,80               |	 
+----------+-----------------+--------------------+ 
|01/03/2020|	32,145	     |46,39               |	  
+----------+-----------------+--------------------+
|01/04/2020|	32,150	     |43,13               |	 
+----------+-----------------+--------------------+ 
|02/05/2020|	33,835	     |42,92               |	 
+----------+-----------------+--------------------+ 
|01/06/2020|	33,170	     |42,91               |	 
+----------+-----------------+--------------------+ 
|01/07/2020|	34,660	     |42,62               |	 
+----------+-----------------+--------------------+ 
|01/08/2020|	38,095	     |42,35               |	 
+----------+-----------------+--------------------+ 
|01/09/2020|	38,185	     |40,12               |	  
+----------+-----------------+--------------------+

Los Futuros sobre la acción X tienen un tamaño del contrato de 1.000 acciones y una garantía del 15%.

Si al finalizar la cobertura el precio de los Futuros sobre la acción X caen a 35,18, determine la razón de cobertura óptima (h*), el número de contratos óptimos (N*), la compensación al cerrar la cobertura y el valor en la cuenta de margen.
	
**Respuestas:**

**h* = 61,37%.** 

**N* = 123.**

**Compensación = $607.620.**

**Valor cuenta de margen al final = $1.347.834.**


4.	Suponga que usted desea cubrir una compra planeada de 20.000 barriles de petróleo crudo liviano. La compra se llevará a cabo dentro de 5 meses. Usted ha estimado el siguiente modelo de regresión: :math:`\Delta S=0,003+1,109\Delta F` en donde :math:`\Delta S` es el cambio en el precio del petróleo del grado que usted desea comprar y :math:`\Delta F` es el cambio en el precio del Futuro de petróleo crudo WTI (tamaño 1.000 barriles por contrato). 

a.	¿Cuál es el número de contratos que minimiza el riesgo de su cobertura, debe usted comprar o vender Futuros?

Suponga que cuando inicialmente se establece la cobertura S=$21,40/barril y F=$19,93/barril. Durante los próximos 5 meses los precios cambian así:

+-------+-------------------------------------+----------+
|**T**	|**Meses restantes para la cobertura**|	**F**    |
+=======+=====================================+==========+
|0	|5	                              |$19,93    |
+-------+-------------------------------------+----------+
|1	|4	                              |$20,04    |
+-------+-------------------------------------+----------+
|3	|2	                              |$20,95    |
+-------+-------------------------------------+----------+
|4	|1	                              |$21,09    |
+-------+-------------------------------------+----------+
|5	|0	                              |$22,35=FT |
+-------+-------------------------------------+----------+

b.	¿Cuál es finalmente su utilidad o pérdida en el contrato de Futuros? Si ST=$23,82/barril a la fecha de compra del petróleo. ¿Cuál es el precio efectivo final de compra para los 20.000 barriles? Considere conjuntamente el precio que usted paga por el petróleo y la ganancia o pérdida en el contrato de Futuros. Tenga en cuenta que :math:`ST \neq FT` porque el tipo de petróleo que usted compra no es el mismo que el subyacente del contrato de Futuros.


c.	¿Cuál fue la base original para su grado de petróleo? ¿Cuál es la base final? Suponga que ST = $24,50/barril (en lugar de $23,82/barril que se asumieron anteriormente). ¿Cuál será el precio final efectivo para la compra de los 20.000 barriles?


d.	Discuta la diferencia de sus respuestas anteriores según el significado del riesgo de la base.


**Respuestas:**

**h* = 110,90%.**

**a.	22 contratos en largo.**

**b.	Se gana 53.240 USD por la compensación en los Futuros WTI.**

	**Precio con cobertura de 21,158 USD cuando ST=$23,82/barril.**

**c.	Base inicial de 1,470 USD. Con ST=$24,50/barril, base final de 2,15 y precio con cobertura de 21,838 USD.**


**d.	¿?**


5.	El 1 de julio un inversionista posee 50.000 acciones de una empresa. El precio de mercado es de US$30 por acción. El inversionista desea cubrirse de los movimientos del mercado en el próximo mes, para lo cual decide usar el contrato de Futuros E-MiniS&P-500 para septiembre. El valor actual del índice es 1.500 y cada contrato se liquida a US$50. El coeficiente Beta para la acción es de 1,3. ¿Cuál debe ser la estrategia del inversionista? 


**Respuesta: cobertura del portafolio de inversión con 26 contratos en corto en el Futuro E-MiniS&P-500.**


6.	Es 16 de julio. Una empresa tiene un portafolio de inversión de acciones valorada en 100 millones de dólares. El Beta del portafolio de inversión es de 1,2. La empresa desearía utilizar el contrato de Futuros de diciembre del CME sobre el S&P 500 para reducir el Beta del portafolio hasta 0,5 durante el período que va desde el 16 de julio hasta el 16 de noviembre. El Futuro sobre el índice actualmente vale 1.000 y cada contrato es sobre 250 veces en dólares.

a)	¿Cuál posición debe tomar la empresa?

b)	Suponga que la empresa cambia de idea y decide incrementar el Beta del portafolio desde 1,2 hasta 1,5. ¿Cuál deberá ser la posición a tomar en Futuros?

**Respuestas:**

**a)	Posición en corto en 280 contratos en el Futuro S&P500 para realizar cobertura del portafolio de inversión y disminuir el Beta de 1,2 a 0,5 hasta el 16 de noviembre.**

**b)	Posición en largo en 120 contratos en el Futuro S&P500 para aumentar el riesgo del portafolio de inversión y aumentar el Beta de 1,2 hasta 1,5 hasta el 16 de noviembre.**


7.	Un fondo de inversión administra el siguiente portafolio: 250 millones de dólares en acciones de KO y 300 millones de dólares en acciones de AAPL. El Beta de KO es de 0,80 y de AAPL de 1,52. El administrador del fondo considera que para el próximo mes (abril) el mercado tendrá un alza, por lo que desea utilizar los contratos de Futuros E-mini S&P 500 para aumentar la beta del portafolio a 1,8.

Actualmente (marzo), los contratos de Futuros E-mini S&P 500 con vencimiento en diciembre se encuentran en 2.137, el índice en 2.144,01 y la tasa libre de riesgo con vigencia de un mes a 3,20% E.A.

Para los siguientes valores de los futuros y el índice para el mes de abril, determine el total de la posición.

+---------------+---------------+---------------+---------------+---------------+--------+
|**FT (abril)**	|2.050,00	|2.010,00	|2.137,00	|2.200,00	|2.300,00|
+---------------+---------------+---------------+---------------+---------------+--------+
|**ST (abril)**	|2.010,00	|2.025,00	|2.144,01	|2.219,00	|2.287,00|
+---------------+---------------+---------------+---------------+---------------+--------+

Nota: aproxime el número de contratos en los Futuros al entero más próximo.

**Respuestas**


+----------------------------------+--------------------+--------------------+--------------------+---------------------+--------------------+
|**FT (abril)**	                   |2.050,00	        |2.010,00	     |2.137,00	          |2.200,00	        |2.300,00            |
+----------------------------------+--------------------+--------------------+--------------------+---------------------+--------------------+
|**ST (abril)**	                   |2.010,00	        |2.025,00	     |2.144,01	          |2.219,00	        |2.287,00            |
+----------------------------------+--------------------+--------------------+--------------------+---------------------+--------------------+
|**Compensación largo en Futuros** |-$13.598.100,00     |-$19.850.100,00     |$0,00	          |$9.846.900,00        |$25.476.900,00      |
+----------------------------------+--------------------+--------------------+--------------------+---------------------+--------------------+
|**Rentabilidad S&P 500**	   |-6,25044%           |-5,55%	             |0,00%	          |3,50%	        |6,67%               |
+----------------------------------+--------------------+--------------------+--------------------+---------------------+--------------------+
|**Rentabilidad portafolio**       |-7,50572%	        |-6,67%	             |-0,05%              |4,12%                |7,90%               |
+----------------------------------+--------------------+--------------------+--------------------+---------------------+--------------------+
|**Valor portafolio**	           |$508.718.527,83     |$513.308.058,66     |$549.721.396,28     |$572.665.990,76      |$593.471.863,86     |
+----------------------------------+--------------------+--------------------+--------------------+---------------------+--------------------+
|**TOTAL POSICIÓN**	           |**$495.120.427,83** |**$493.457.958,66** |**$549.721.396,28** |**$582.512.890,76**  |**$618.948.763,86** |
+----------------------------------+--------------------+--------------------+--------------------+---------------------+--------------------+



8.	Un administrador de un portafolio de inversión espera que el mercado tenga una tendencia bajista hasta dentro de tres meses, por lo que realiza cobertura con Futuros. El portafolio de inversión está valorado en 3.700 millones de pesos y tiene un coeficiente Beta de 1,8 con respecto al índice COLCAP. El Futuro COLCAP con vencimiento a tres meses tiene un precio de 1.525. Calcule la cantidad de contratos en el Futuro COLCAP que necesita el administrador para cubrir el 100% del portafolio de inversión. ¿Qué posición tomará para cubrir el portafolio de inversión?

**Respuesta: tomará posición en corto en 175 contratos en el Futuro COLCAP.**

9.	Un inversionista desea cubrir la venta de unas acciones que compró el año pasado. Dentro de un mes espera vender 108.000 acciones de Ecopetrol en el mercado spot, el precio actual de la acción es de $2.985 y del precio Futuro de Ecopetrol con vencimiento a tres meses es de $2.993. Determine el efectivo que tendría el inversionista si logra vender las acciones dentro de un mes a $2.690 y cierra la posición en los Futuros a un precio de $2.700. 

**Respuesta: de la venta de las acciones en el mercado spot y con la compensación en los Futuros, tendría en efectivo $322.164.000.**














