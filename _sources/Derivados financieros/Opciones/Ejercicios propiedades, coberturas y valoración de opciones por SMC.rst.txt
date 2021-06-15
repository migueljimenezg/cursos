Ejercicios propiedades, coberturas y valoración de opciones por SMC
=======================================================================================


I.	Propiedades de las opciones
----------------------------------------

1.	Determine la prima de la opción Put ATM europea con vencimiento a un mes, sobre una acción que no paga dividendos si la opción Call ATM europea sobre el mismo subyacente y vencimiento tiene un precio de $1.000. La acción tiene un precio de mercado de $40.000 y la IBR a un mes es de 4% E.A.

**Respuesta: $869,48.**

2.	Para que no exista oportunidad de arbitraje, ¿Cuál es el mínimo y máximo valor de las siguientes opciones?

a.	Opción Call europea con vencimiento a tres meses y precio de ejercicio de $360, el precio spot inicial es de $365 y la tasa libre de riesgo con vencimiento a tres meses es de 2% C.C.A.

**Respuesta:**
 
**Límite inferior: $6,80.**

**Límite superior: $365.**

b.	Opción Put europea con vencimiento a seis meses y precio de ejercicio de $247, el precio spot inicial es de $250 y la tasa libre de riesgo con vencimiento a seis meses es de 3% C.C.A.

**Respuesta:**

**Límite inferior: $0.**

**Límite superior: $243,32.**

c.	Opción Put americana con vencimiento a seis meses y precio de ejercicio de $247, el precio spot inicial es de $250 y la tasa libre de riesgo con vencimiento a seis meses es de 3% C.C.A.

**Respuesta:**

**Límite inferior: $0.**

**Límite superior: $247.**

3.	Utilizando la paridad Put-Call determine el rango de valores de la opción Put americana con precio strike de $2.000 y vencimiento a un mes. La tasa libre de riego para la vigencia de la opción es de 1,8% C.C.A.

El precio de la opción Call americana corresponde al máximo valor que se puede obtener para que no exista oportunidad de arbitraje, debido a que la opción es "deep in the money" porque el precio spot actual es de $2.800.

**Respuesta:**

**Límite inferior: $1.997.**

**Límite superior: $2.000.**

II.	Coberturas (aseguramiento) con opciones
----------------------------------------------------

4.	Actualmente se tienen 5.000 acciones sobre la acción Z. El inversionista tiene pensado venderlas dentro de dos meses, por lo que realiza una cobertura con opciones europeas con vencimiento en dos meses y precio de ejercicio de $1.950.

Nota: las opciones no son de liquidación financiera, lo que significa que se debe entregar o recibir el activo subyacente dependiendo de la posición que se tome y si se ejercen las opciones, en cambio, si las opciones no se ejercen, el activo subyacente se vende en el mercado spot.

a.	Determine el Flujo de Caja del inversionista dentro de dos meses (no se incluye prima) si el precio spot de las acciones cierra en $2.200.

**Respuesta: $11.000.000.**

b.	Determine el Flujo de Caja del inversionista dentro de dos meses (no se incluye prima) si el precio spot de las acciones cierra en $1.900.

**Respuesta: $9.750.000.**

5.	Un exportador realiza un aseguramiento con opciones financieras de la Bolsa de Valores de Colombia porque espera obtener un millón de dólares dentro de seis meses. Para esto paga $25 de prima por cada dólar en opciones financieras con precio strike de $3.200. La razón de cobertura es de 100%. Si dentro de seis meses el precio de mercado del dólar es de $3.225, ¿cuál es el precio con cobertura incluyendo el pago de la prima?

**Respuesta: $3.200.**

6.	Un importador desea cubrir 12.000 USD con opciones financieras sobre el dólar por un mes. La institución financiera le ofrece opciones Calls europeas a un precio de $50 cada una y opciones Puts europeas a un precio de $45. Las opciones son ATM con vencimiento a un mes. 

El precio actual del dólar es de $2.740.

Si el precio del dólar aumenta a $2.820 para dentro de un mes, ¿Cuál es el precio unitario con cobertura antes y después del pago de las primas?

Nota: la razón de cobertura es del 100%.

**Respuesta:**

**Precio cobertura antes de primas: $2.740.**

**Precio cobertura después de primas: $2.790.**

a.	Si la razón de cobertura es de 80%, ¿Cuál es el precio unitario con cobertura antes y después del pago de las primas?

**Respuesta:**

**Precio cobertura antes de primas: $2.756.**

**Precio cobertura después de primas: $2.796.**

b.	¿Cómo cambian los resultados de los dos ejercicios anteriores si el precio final del dólar es de $2.700?

**Respuesta:**

**Razón de cobertura 100%:**

   **Precio cobertura antes de primas: $2.700.**

   **Precio cobertura después de primas: $2.750.**

 **Razón de cobertura 80%:**

   **Precio cobertura antes de primas: $2.700.**

   **Precio cobertura después de primas: $2.740.**


III.	Valoración de opciones por SMC
----------------------------------------------------

7.	Realice la valoración de las siguientes opciones europeas por el método de Simulación Monte Carlo (SMC), utilice el archivo :download:`TRM 2020 (ejercicios) <TRM 2020 (ejercicios).csv>`

Opciones Call y Put ATM con vencimiento en seis meses (180 días con una base de 360). La tasa libre de riesgo local vigente para seis meses es de 2% E.A. y la tasa libre de riesgo extranjera vigente para seis es de 0,31% nominal.

Para la simulación utilice el siguiente valor semilla ``set.seed(1)`` .

**Respuesta:**

**Call: $ 126.056384838074.**

**Put: $ 98.22669363277.**


