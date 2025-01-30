# Google BigQuery: Data Warehouse & Business Insights


## Descripción del proyecto

Una cadena de tiendas tiene los datos históricos de ventas de 45 de sus tiendas, que se encuentran en diferentes regiones y donde cada una dispone de diferentes departamentos. 
Los datos están repartidos en tres ficheros CSV:
- stores.csv -> Información anonimizada de 45 tiendas
- features.csv -> Contiene información adicional sobre la tienda, el departamento y las características de la región donde esta se encuentra para cada fecha. Los campos MarkDown representan promociones.
- sales.csv -> Información histórica sobre ventas entre 2010-02-05 y 2012-11-01. 

## Objetivos
- Cargar y gestionar datos en Google BigQuery: Utilizar BigQuery como Data Warehouse para almacenar y consultar datos.
- Explorar la estructura del dataset: Analizar la cantidad de datos, tipos de variables y relaciones clave.
- Detectar valores anómalos y faltantes: Identificar registros inconsistentes en las diferentes tablas.
- Realizar análisis exploratorio con SQL: Examinar distribuciones, calcular agregaciones y detectar patrones en las ventas.
- Aplicar operaciones JOIN entre tablas: Relacionar datos de ventas con características de las tiendas y factores externos.
- Extraer insights para la toma de decisiones: Identificar tendencias que puedan ayudar a mejorar el rendimiento de las tiendas.

## Configuración inicial (Subida de archivos y creación de tablas)

### 1. Creación del bucket y subida de archivos
   
   Debemos acceder al servicio de Google Cloud Storage (GCS).
   
   - Cloud Storage -> Buckets -> Crear bucket nuevo. A mi bucket para el proyecto lo llamé "alpha_bigquery".
   
   - Region -> Europe west1. Escoge la que mejor se adecúe a tus necesidades.
   
   No es necesario cambiar nada más.

   Subimos los 3 archivos csv al bucket. De forma que debe quedar algo similar a lo siguiente:
   
   ![bucket](https://github.com/user-attachments/assets/d83430c9-f19c-4fde-9979-5bf4bf0f4891)


### 2. Creación de tablas en BigQuery

  Accedemos al servicio BigQuery desde el menu izquierdo -> clicamos en los 3 puntos de nuestro proyecto (en mi caso "peerless...") -> Crear conjunto de datos.
  
  El concepto de conjunto de datos de BigQuery es el equivalente al concepto clásico de SCHEMA en una base de datos relacional convencional, es decir, un conjunto de tablas y vistas.
  
  ![menu](https://github.com/user-attachments/assets/fd506f04-0e8e-4033-8656-d4dd9209d4c6)

  Rellenamos según convenga, en mi caso llamé al conjunto de datos como "Data_Queries"
  <div align="center">
     <img src="https://github.com/user-attachments/assets/2d54f93b-3e68-4f46-97ce-30e847b348a7" alt="creacion">
  </div>

   
  Voy a crear 3 tablas, dos internas (stores y features) y una externa (sales).
  <div align="center">
     <img src="https://github.com/user-attachments/assets/97366f72-1de9-4ebe-9b2b-0f2ea3a8c550" alt="tablas">
  </div>

  En las **tablas nativas** los datos se almacenan dentro de BigQuery, por lo que ofrecen un rendimiento más rápido para las consultas. Estos datos son persistentes y están disponibles para consultas en cualquier momento. Además, admite operaciones Data Manipulation Language (DML) como INSERT, UPDATE, DELETE y MERGE.

  Creo una tabla nativa subiendo manualmente desde mi local los datos a guardar. Nombramos la tabla y activamos la detección automática para que BigQuery infiera el schema. (Repito la operación para features.csv).
  <div align="center">
     <img src="https://github.com/user-attachments/assets/4ffec0f0-3ae2-4d4c-aede-abd6391c82ec" alt="tablanativa">
  </div>

  En las **tablas externas** los datos se encuentran fuera de BigQuery, en otros servicios como Google Cloud Storage, Google Drive, o bases de datos de terceros, por lo que puede resultar más lento. Son buenas para consultas ad-hoc o ETL sobre datos que no se necesitan almacenar permanentemente en BigQuery.
  No admite operaciones DML directamente sobre los datos externos. Las tablas externas son read-only.

  Creo una tabla externa subiendo desde el bucket creado anteriormente los datos a guardar. Nombramos la tabla y activamos la detección automática para que BigQuery infiera el schema.
  <div align="center">
     <img src="https://github.com/user-attachments/assets/a6d0215f-ff2d-4f6c-b396-9ad11611eef8" alt="tablaexterna">
  </div>


## Análisis de los datos

Se va a realizar una serie de consultas para conocer mejor la naturaleza de los datos y así poder responder preguntas como:
- ¿Qué tipo de tienda realiza más ventas?
- ¿Cómo han sido las ventas a lo largo del tiempo?
- ¿Influyen los periodos vacacionales en las ventas?

### 1. Tratamiento inicial

Tras una primer vistazo sobre los archivos csv, se puede ver que las columnas CPI y Unemployment de la tabla features son tratados como Float, pero sin embargo tienen algunos valores nulos que aparecen como "NA" que son strings, esto generará conflictos, por lo que lo primero que se realiza es una sustitución de esos valores "NA" por NULL para que puedan ser correctamente tratados. Esto mismo ocurre en los campos MarkDown, donde aparentemente hay una gran cantidad de nulos.
  <div align="center">
     <img src="https://github.com/user-attachments/assets/8c2503d0-eaf7-4d19-ab8b-e3e8c725a794" alt="tratamiento">
  </div>


### 2. Consultas iniciales
Se realizarán 2 consultas sencillas a modo de prueba para confirmar que BigQuery ha cargado los datos y los está interpretando correctamente.

- La primera de ellas consiste en mostrar las 10 primeras filas de cada tabla.

  <div align="center">
     <img src="https://github.com/user-attachments/assets/32a22a91-a16f-46eb-b1da-feb6e335d385">
  </div>

Por ejemplo para features:

  <div align="center">
     <img src="https://github.com/user-attachments/assets/cfe907f1-5734-4683-b9bd-7e24ace28d92">
  </div>

Se puede observar como los campos MarkDown ahora si aparecen reflejados como NULL.
  
- La segunda consiste en contar el número de filas de cada tabla.

  <div align="center">
     <img src="https://github.com/user-attachments/assets/c87d38c9-b8a0-4235-a41f-8efa29ca8003">
  </div>

<table align="center">
  <tr>
    <th>Features</th>
    <th>Sales</th>
    <th>Stores</th>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/e9af1ca1-fc89-4d26-affb-7576c7e7cb94" alt="Features"></td>
    <td><img src="https://github.com/user-attachments/assets/5e934e98-4ecd-45d0-a379-8a49f9d8543d" alt="Sales"></td>
    <td><img src="https://github.com/user-attachments/assets/a200ebce-703b-4980-864b-32c74fe6a8c8" alt="Stores"></td>
  </tr>
</table>

Los números coinciden con lo que aparece en los archivos, por lo que todo está correcto.


### 3. Análisis exploratorio

#### 3.1 Rangos de las variables numéricas

A continuación, voy a estudiar el rango (máximo y mínimo) de cada variable numérica.

  <div align="center">
     <img src="https://github.com/user-attachments/assets/f1dfe9d5-8025-4229-9455-dbbd53017b20">
  </div>

  <table align="center">
  <tr>
    <th>Features</th>  
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/c534464b-a23e-484e-991b-d155baabdeb0"></td>
   </tr>
   </table>

  
  <table align="center">
  <tr>
    <th>Stores</th>
    <th>Sales</th>  
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/65692789-69c7-4bb7-b375-661cfa8527d7"></td>
    <td><img src="https://github.com/user-attachments/assets/ad75cdc1-e0f6-4db7-8040-2fa9d10c13d4"></td>
  </tr>
</table>

Estas consultas nos arrojan unos datos interesantes.
Lo primero que se puede notar es que en la tabla **Sales**, existen registros de ventas semanales, que son erróneos porque son negativos (salvo que sean devoluciones, pero no las trataré como tal en este análisis, ya que no hay información al respecto). Solo se utilizarán aquellas ventas semanales superior o igual a 0, por lo que habría que hacer una limpieza de esos registros.

En la tabla **Features** se puede destacar que la temperatura oscila entre -7.29 y 101.95 lo que lleva a pensar a que los datos estén en grados fahrenheit, apróximadamente entre -22ºC y 39ºC. Dependiendo del contexto geográfico, estos valores podrían ser realistas y dado que no se sabe la ubicación concreta de las tiendas decidí que pueden ser valores reales. La tasa de desempleo oscila entre 3.684% – 14.313%, podría ser interesante realizar un análisis sobre esta métrica para concluir si en tiendas situadas en regiones con tasas de mayor desempleo existe una disminución en las ventas promedio.

En la tabla **Stores** se puede apreciar que el rango de tamaño de las tiendas es amplio entre 34,875 – 219,622, aunque se desconoce a qué medidas se refiere, se interpretarán como metros cuadrados. Al igual que en el caso anterior, podría ser interesante realizar un estudio para determinar si el tamaño de la tienda influye de alguna forma en las ventas promedio.


#### 3.2 Variables categóricas

Y si nos centramos en las variables categóricas de cada tabla:

   <div align="center">
     <img src="https://github.com/user-attachments/assets/27dc3393-a3a3-4856-963b-e07e80e8460b">
  </div>

  <table align="center">
  <tr>
    <th>Features</th>
     <th>Stores</th>
    <th>Sales</th>
    
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/10463d99-d02c-4b8b-9a75-fb1ff8347201"></td>
    <td><img src="https://github.com/user-attachments/assets/703e8c26-c2c7-43ff-a380-fea43a053ea0"></td>
    <td><img src="https://github.com/user-attachments/assets/d9bd89b7-3805-486f-9dd3-a69a513d2143"></td>
  </tr>
</table>

En **Features** se observa que hay 7.605 registros de semanas no festivas y 585 registros semanas festivas lo que equivale a solo el 7.1% de las semanas disponibles. Aún así sería conveniente ver como se comportan las ventas en las semanas festivas.

En **Stores** obtenemos que tenemos 
- Tipo A: 22 tiendas (48.9% del total).
- Tipo B: 17 tiendas (37.8%).
- Tipo C: 6 tiendas (13.3%).

Esto indica que las tiendas tipo C son minoría en los datos, habría que evaluar si también son minoría en ventas.


#### 3.3 Valores nulos

  <table align="center">
  <tr>
    <th>Features</th>  
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/b2890727-36f4-4207-a13e-61d491c07617"></td>
   </tr>
   </table>

   <table align="center">
   <tr>
    <th>Sales</th>
    <th>Stores</th>
   <tr>
    <td><img src="https://github.com/user-attachments/assets/2681d6d3-21b9-4df3-9935-9aaec6701e43"></td>
    <td><img src="https://github.com/user-attachments/assets/76eaed96-834c-45be-a7cd-6bb124bb7eb9"></td>
  </tr>
   </table>


En **Features** tenemos alrededor del 7% de valores nulos para la tasa de desempleo y para el CPI, son variables importantes para entender el contexto de la región, por lo que su ausencia puede limitar el análisis, se podría considerar imputarlos como sus promedios o eliminarlos. Por otro lado, alrededor de algo menos del 50% de los datos de promociones son nulos, por lo que estos registros no son consistentes para sacar conclusiones sobre ellos, podrían llegar a excluirse del modelo si consideramos que las promociones no son relevantes para el análisis.

Tanto para **Sales** como para **Stores** tenemos los datos completos por lo que se podrán realizar análisis más confiables.


#### 3.4 Valores anómalos

   <div align="center">
     <img src="https://github.com/user-attachments/assets/28d22127-1265-4da5-88cf-6fe83b369cf2">
   </div>

Dado que no se conoce la ubicación de las tiendas, se tomó como criterio descartar aquellos valores de temperatura que se encuentren por debajo de -10º y por encima de los 35º. Bajo esta premisa se encontraron. Encontramos 92 registros outliers. Puede ser interesante ver si las épocas de mayores/menores temperaturas afectan a sus ventas en esos periodos.

Un ejemplo gráfico de estos registros es el siguiente:

   <div align="center">
     <img src="https://github.com/user-attachments/assets/959c9cbd-b4f8-42ae-a351-ae4b404f939e">
   </div>


Por otro lado, se encontraron 1285 registros en las tabla **Sales** con ventas semanales negativas, lo cuál es imposible, como se dijo anteriomente. Estos registros deberían ser eliminados del modelo.

   <div align="center">
     <img src="https://github.com/user-attachments/assets/390d21ae-ca12-4a8e-a99f-822bb60b9e56">
   </div>


#### 3.5 Ventas por tipo de tienda

Se busca agrupar las ventas totales y promedio por tienda y tipo de tienda, excluyendo valores negativos.

   <div align="center">
     <img src="https://github.com/user-attachments/assets/6acf49e1-f926-4049-b2c2-2e0982712f1a">
   </div>


Las tiendas de tipo A son las que tienen un mayor desempeño en ventas con un promedio de 29.620, algo esperable ya que también erán el 48.9% de las tiendas disponibles.

Las tiendas de tipo B tienen un menor desempeño con un promedio de 26.460, que no está mal para ser el 37.80% de las tiendas.

Las tiendas de tipo C son las que tienen peor desempeño en con un promedio de 13.460, pero no son datos tan negativos ya que constan con solo el 13.3% de las tiendas.



#### 3.6 Ventas a lo largo del tiempo


   <div align="center">
     <img src="https://github.com/user-attachments/assets/96e36a2f-7ec8-4b9a-a676-0a3903f407f2">
   </div>

Aunque era previsible, se confirma que las semanas que coinciden con el Black Friday y con las compras navideñas son las que tienen un mayor volumen de ventas. Posteriormente, el mes de enero suele ser el que tiene menor volumen de ventas durante el año.

#### 3.7 Ventas según vacaciones

Toda aquella tienda que se encuentre por encima del 100% significa que ha visto un aumento en sus ventas en temporada vacacional, la gran mayoría tienen este comportamiento, destacando las tiendas 7 y 35, ambas tipo B, con un aumento de casi el 18%.
Por otro lado hay tiendas que ven perjudicadas sus ventas, descendiendo alrededor de un 2% como la 36 (tipo A) y la 37, 38 y 44, las tres de tipo C.

   <div align="center">
     <img src="https://github.com/user-attachments/assets/0422a271-1862-4963-a99f-aedc01e860fb">
   </div>

   <div align="center">
     <img src="https://github.com/user-attachments/assets/f36803a6-f04a-4ad6-908c-1a8a90d9ea3f">
   </div>

*Ventas en festivos representadas en azul*

Podemos ver como más de la mitad de las ventas se realiza en los festivos, a pesar de ser solo el 7%. El top 3 de tiendas con mayores ventas (sumando periodos vacacionales) está formado por las tiendas 20, 4 y 14, todas ellas del tipo A, por lo que conviene centrarse en ellas y expandirlas aún más.

### Conclusiones
---

- Oportunidad en festivos: Aunque solo el 7% de las semanas son festivas, su impacto en ventas es desproporcionadamente alto. Recomendaría aumentar stock y personal en semanas clave (Black Friday y Navidad).
- Enfoque en tiendas grandes: Las Tipo A son el motor principal de ventas. Priorizar su gestión y expansión.
- Las tiendas Tipo C son minoría. Recomendaría optimizar recursos en tiendas tipo A y B, y reevaluar la rentabilidad de tipo C o cerrarlas
- Las zonas con alto desempleo tienen un menor porcentaje de ventas, por lo que reducir precios en estas áreas podría impulsar las ventas.



## Futuras mejoras
- Analisis con más métricas y consultas.
- Visualizar resultados con Looker Studio
