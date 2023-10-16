# test_awto
Test Data Engineer

1. La propuesta del modelo de datos consiste en tres tablas principamente: Users, Vehicles y Trips. La idea de estos es guardar todos los datos relacionados al usuario en un tabla donde el user_id sea la PK; luego una tabla en donde guardar información de los vehículos (en el ejemplo sólo existe el íd, pero podría estar la marca, modelo, etc.); para finalmente guardar el grueso de la información en la tabla Trips, que contiene toda los datos asociados al viaje en sí, donde el user_id y el vehicle_id son llaves foráneas, el motivo es obvio: no se pueden realizar viajes por personas que no estén inscritas como usuarios ni utilizar ningún vehículo que no esté registrado.

La estructura de la tabla Trips es la siguiente:
- `trip_id` (PK)
- `user_id` (FK)
- `vehicle_id` (FK)
- `booking_time`
- `start_time`
- `end_time`
- `status_id`
- `travel_dist`
- `price_amount`
- `price_tax`
- `price_total`
- `start_lat`
- `start_lon`
- `end_lat`
- `end_lon`

La estructura de la tabla Vehicles es la siguiente:
- `vehicle_id` (PK)
- `patente` --- dato inventado pero fundamental en una tabla de vehículos de prod ---
- `marca` --- dato inventado pero importante en una tabla de vehículos de prod ---
- `modelo` --- dato inventado pero importante en una tabla de vehículos de prod ---

La estructura de la tabla User es la siguiente:
- `user_id` (PK)
- `rut_user` 
- `name_user`
- `membership_id` --- este dato, al cambiar en el tiempo, podría o bien guardar el último registro o llevar el registros de cambios en una nueva tabla ---


2. La base de datos de postgresql se crea al ejecutar el Dockerfile, que levanta el contenedor de postgres como servicio. Si se usara una API, datos en caché u otro servicio que trabaje en conjunto, se puede programar la infraestructura en el mismo Dockerfile. En este caso, sólo está el servicio de postgres.


3. Las tablas se crean al levantar el servicio de postgres.


4. El archivo "load_trips" contiene un proceso simple para cargar las tablas a la bd.


5. La tabla se crea con la query en el archivo "resumen_diario.sql". No está automatizado en el proceso, pero podría realizarse de la misma manera como se generan las bases del modelo de datos.
    1. No realizado
    2. Se pueden realizar validaciones para que las columnas clave que permiten calcular esta tabla no estén vacíos o sigan el patrón esperado, como por ejemplo, con una expresión regular; validar el tipo de dato, validar con entes externos como por ejemplo los Rut y Patentes con el registro civil, Latitud y Longitud con Google Maps u otra.
    Luego de ello, realizar los calculos diarios con un desfase de horas o días, dependiendo de la urgencia de la visualición del dato. Este desfase o margen tiene por objetivo el asegurarse que todas las transacciones existentes en un dia estén cargadas y validadas en la base de datos, sobre todo si es una carga en streaming.
    3. Una vez asegurada la correcta carga de los datos, se puede programar un Apache Beam con Dataflow (en GCP) que se ejecute una vez la validación de la carga streaming con Pub/Sub (en CGP) haya terminado, es decir, no queden pendientes datos del día a procesar. 


6. En primer lugar, habría que definir a qué están asociados esos cupones, al cliente en sí, al vehículo, al punto de inicio o término, entre otros. 