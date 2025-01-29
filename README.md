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

  ![creacion](https://github.com/user-attachments/assets/2d54f93b-3e68-4f46-97ce-30e847b348a7)

  Voy a crear 3 tablas, dos internas (stores y features) y una externa (sales).
  
  ![tablas](https://github.com/user-attachments/assets/97366f72-1de9-4ebe-9b2b-0f2ea3a8c550)

  En las **tablas nativas** los datos se almacenan dentro de BigQuery, por lo que ofrecen un rendimiento más rápido para las consultas. Estos datos son persistentes y están disponibles para consultas en cualquier momento. Además, admite operaciones Data Manipulation Language (DML) como INSERT, UPDATE, DELETE y MERGE.

  Creo una tabla nativa subiendo manualmente desde mi local los datos a guardar. Nombramos la tabla y activamos la detección automática para que BigQuery infiera el schema. (Repito la operación para features.csv).
  
  ![tablanativa](https://github.com/user-attachments/assets/4ffec0f0-3ae2-4d4c-aede-abd6391c82ec)

  En las **tablas externas** los datos se encuentran fuera de BigQuery, en otros servicios como Google Cloud Storage, Google Drive, o bases de datos de terceros, por lo que puede resultar más lento. Son buenas para consultas ad-hoc o ETL sobre datos que no se necesitan almacenar permanentemente en BigQuery.
  No admite operaciones DML directamente sobre los datos externos. Las tablas externas son read-only.

  Creo una tabla externa subiendo desde el bucket creado anteriormente los datos a guardar. Nombramos la tabla y activamos la detección automática para que BigQuery infiera el schema.

  ![tablaexterna](https://github.com/user-attachments/assets/a6d0215f-ff2d-4f6c-b396-9ad11611eef8)


## Funcionamiento

### 1. 












