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

:: Cambia al directorio donde se encuentra tu repositorio (ajusta la ruta según sea necesario)
cd "C:\beh\sincrowebapi"

:: Ejecuta los comandos en Git Bash
%GIT_BASH_PATH% -c "git checkout master && git reset --hard && git pull"

:: Mensaje de finalización
echo Comandos ejecutados correctamente.
pause