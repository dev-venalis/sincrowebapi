@echo off
:: Ruta al ejecutable de Git Bash (ajusta si es necesario)
set GIT_BASH_PATH="C:\Program Files\Git\bin\bash.exe"

:: Verifica si Git Bash está instalado en la ruta predeterminada
if not exist %GIT_BASH_PATH% (
    echo Git Bash no encontrado en la ruta predeterminada.
    echo Por favor, instala Git o actualiza la ruta en este archivo.
    pause
    exit /b 1
)

:: Verificar si la aplicación está en ejecución
echo Verificando si Shankro.exe esta en ejecucion...
tasklist /FI "IMAGENAME eq Shankro.exe" 2>NUL | find /I /N "Shankro.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo Shankro.exe esta en ejecucion. Cerrando aplicacion...
    taskkill /F /IM Shankro.exe >NUL 2>&1
    if "%ERRORLEVEL%"=="0" (
        echo Aplicacion cerrada correctamente.
        timeout /t 2 /nobreak >NUL
    ) else (
     echo Error: No se pudo cerrar la aplicacion.
      echo Por favor, cierre Shankro.exe manualmente e intente de nuevo.
        pause
        exit /b 1
    )
) else (
    echo Shankro.exe no esta en ejecucion.
)

:: Cambia al directorio donde se encuentra tu repositorio (ajusta la ruta según sea necesario)
cd "C:\beh\sincrowebapi"

:: Ejecuta los comandos en Git Bash
echo Ejecutando comandos de Git...
%GIT_BASH_PATH% -c "git checkout master && git reset --hard && git pull"

if "%ERRORLEVEL%"=="0" (
    :: Mensaje de finalización
    echo Comandos ejecutados correctamente.
) else (
    echo Error: Fallo al ejecutar los comandos de Git.
)

pause