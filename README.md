# README #

Este README se encuentran documentados los pasos necesarios para que la aplicación esté en funcionamiento. 

### Configuración dentro de SQL Server ###

Consultar dentro de la tabla tConfigNube se encuentre configurado el campo:

* cIDTienda 

### Comandos especiales ###

* Habilitar Preferencias y Sincronización Forzada: CTRL + ALT + SHIFT + F6

### Propiedades de la Conexión ###

* HOST: Nombre del servidor
* DATABASE: Nombre de la base de datos
* USERNAME: Nombre del usuario de login
* PASSWORD: Contrase del usuario de login

### API REST ###

* URL: Dirección donde se encuentra alojado el servicio

### Tiempo de Sincronización ###

* Intervalo (segundos)

### Preferencias ###

* Ejecutar aplicación cuando Windows inicie

### Errores ###

* Se generan automaticamente en la misma ubicación un archivo TXT dentro de la carpeta Error

## Check-It! ##

SQL Server consultar dentro de la tabla tConfigNube se encuentre configurado el campo:

* cBDAppCheckIt

Comandos especiales:

* Parar Sincronización: ALT + SHIFT + F
* Iniciar Sincronización: ALT + SHIFT + A

Errores:

* Se genera automaticamente en la misma ubicación un archivo JSON llamado output