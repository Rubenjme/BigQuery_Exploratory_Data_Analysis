# Google BigQuery: Data Warehouse & Business Insights


## Descripción del proyecto


## Objetivos


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

Tras una primer vistazo sobre los archivos csv, se puede ver que las columnas CPI y Unemployment de la tabla features son tratados como Float, pero sin embargo tienen algunos valores nulos que aparecen como "NA" que son strings, esto generará conflictos, por lo que lo primero que realizo es una sustitución de esos valores "NA" por NULL para que puedan ser correctamente tratados. Esto mismo ocurre en los campos MarkDown, donde aparentemente hay una gran cantidad de nulos.
  <div align="center">
     <img src="https://github.com/user-attachments/assets/8c2503d0-eaf7-4d19-ab8b-e3e8c725a794" alt="tratamiento">
  </div>


### 2. Consultas iniciales
Se realizarán 2 consultas sencillas a modo de prueba para confirmar que BigQuery ha cargado los datos y los está interpretando correctamente.

- La primera de ellas consiste en mostrar las 10 primeras filas de cada tabla.

  <div align="center">
     <img src="https://github.com/user-attachments/assets/32a22a91-a16f-46eb-b1da-feb6e335d385">
  </div>

  <div align="center">
     <img src="https://github.com/user-attachments/assets/76c5b7d7-911d-4e1d-85f6-e6f6a0b5eb87">
  </div>
  
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

A continuación, voy a estudiar el rango (máximo y mínimo) de cada variable numérica.













