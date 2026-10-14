@echo off
:: GitAutomation.bat [AUTO] [RUTA_LOG]
:: Modo manual (doble click): actualiza el repositorio y hace pause.
:: Modo AUTO (invocado por la app): no hace pause, escribe el resultado
:: en el log indicado y reinicia la aplicacion.

setlocal
:: Ruta al ejecutable de Git Bash (ajusta si es necesario)
set GIT_BASH_PATH="C:\Program Files\Git\bin\bash.exe"

set "MODE=%~1"
set "LOG_PATH=%~2"
set "APP_NAME=SincroWebAPI.exe"
set "FAILED=1"
set "EXIT_CODE=1"

:: Verifica si Git Bash esta instalado en la ruta predeterminada
if not exist %GIT_BASH_PATH% (
    echo Git Bash no encontrado en la ruta predeterminada.
    echo Por favor, instala Git o actualiza la ruta en este archivo.
    call :Log "Git Bash no encontrado en el equipo"
    goto :Finish
)

:: Determina el repositorio subiendo desde la carpeta del ejecutable
set "SEARCH_DIR=%~dp0"
set "LEVELS=0"
:FindRepo
if exist "%SEARCH_DIR%.git" goto :RepoFound
for %%I in ("%SEARCH_DIR%..") do set "SEARCH_DIR=%%~fI\"
set /a LEVELS+=1
if %LEVELS% GEQ 8 goto :NoRepo
goto :FindRepo

:NoRepo
echo Error: No se encontro un repositorio a partir de %~dp0
call :Log "No se encontro el repositorio (.git)"
goto :Finish

:RepoFound
cd /d "%SEARCH_DIR%"
echo Repositorio: %SEARCH_DIR%

:: Verificar si la aplicacion esta en ejecucion
echo Verificando si %APP_NAME% esta en ejecucion...
tasklist /FI "IMAGENAME eq %APP_NAME%" 2>NUL | find /I /N "%APP_NAME%">NUL
if errorlevel 1 (
    echo %APP_NAME% no esta en ejecucion.
    goto :RunGit
)

echo %APP_NAME% esta en ejecucion. Cerrando aplicacion...
taskkill /F /IM %APP_NAME% >NUL 2>&1
if errorlevel 1 (
    echo Error: No se pudo cerrar la aplicacion.
    echo Por favor, cierre %APP_NAME% manualmente e intente de nuevo.
    call :Log "No se pudo cerrar la aplicacion"
    goto :Finish
)
echo Aplicacion cerrada correctamente.
timeout /t 2 /nobreak >NUL

:RunGit
echo Ejecutando comandos de Git...
%GIT_BASH_PATH% -c "git checkout master && git reset --hard && git pull"
if errorlevel 1 (
    echo Error: Fallo al ejecutar los comandos de Git.
    call :Log "git pull fallo"
    goto :Finish
)

echo Comandos ejecutados correctamente.
call :Log "git pull exitoso"
set "FAILED=0"
set "EXIT_CODE=0"
goto :Finish

:Finish
if not "%MODE%"=="AUTO" goto :Manual

:: AUTO: siempre reinicia la aplicacion para no dejar al cliente sin sistema
if "%FAILED%"=="1" (
    echo.
    echo Presione una tecla para reiniciar la aplicacion...
    pause >NUL
)
call :Log "Reiniciando aplicacion"
timeout /t 5 /nobreak >NUL
start "" "%~dp0%APP_NAME%"
exit /b %EXIT_CODE%

:Manual
pause
exit /b %EXIT_CODE%

:Log
if not defined LOG_PATH goto :eof
powershell -NoProfile -ExecutionPolicy Bypass -Command "[IO.File]::AppendAllText('%LOG_PATH%', $(if((Test-Path '%LOG_PATH%') -and (Get-Item '%LOG_PATH%' -ErrorAction SilentlyContinue).Length -gt 0){[char]13+[char]10})+$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')+' | Update | %~1', [Text.Encoding]::UTF8)"
goto :eof
