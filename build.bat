@echo off
setlocal

rem ------------------------------------------------------------
rem HyperLis build script - restores, cleans, publishes and creates installer
rem ------------------------------------------------------------
set "PROJECT_FILE=HyperLisUI.csproj"
if not exist "%PROJECT_FILE%" (
    echo [ERROR] %PROJECT_FILE% not found in %CD%
    exit /b 1
)

rem -------- locate ISCC.exe (Inno Setup Compiler) --------
set "ISCC_PATH="

if exist "%LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe" (
    set "ISCC_PATH=%LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe"
    goto :found_iscc
)

if exist "%ProgramFiles%\Inno Setup 6\ISCC.exe" (
    set "ISCC_PATH=%ProgramFiles%\Inno Setup 6\ISCC.exe"
    goto :found_iscc
)

if exist "%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe" (
    set "ISCC_PATH=%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe"
    goto :found_iscc
)

:found_iscc
if "%ISCC_PATH%"=="" (
    echo [ERROR] ISCC.exe not found. Install Inno Setup 6 or adjust the script.
    exit /b 1
)

echo [INFO] Found ISCC at: "%ISCC_PATH%"

rem -------- restore NuGet packages --------
echo Restoring NuGet packages...
dotnet restore "%PROJECT_FILE%" --source https://api.nuget.org/v3/index.json
if %errorlevel% neq 0 (
    echo [ERROR] dotnet restore failed.
    exit /b %errorlevel%
)

rem -------- clean previous build --------
echo Cleaning previous build...
dotnet clean "%PROJECT_FILE%" -c Release
if %errorlevel% neq 0 (
    echo [ERROR] dotnet clean failed.
    exit /b %errorlevel%
)

rem delete bin/Release folder to ensure a fresh publish
if exist "bin\Release" (
    echo Deleting existing bin\Release folder...
    rmdir /s /q "bin\Release"
)

rem -------- publish Release (win-x64) --------
echo Publishing Release (win-x64)...
dotnet publish "%PROJECT_FILE%" -c Release -r win-x64
if %errorlevel% neq 0 (
    echo [ERROR] dotnet publish failed.
    exit /b %errorlevel%
)

rem -------- create installer with Inno Setup --------
set "ISS_SCRIPT=HyperLis_NoDotNet.iss"
if not exist "%ISS_SCRIPT%" (
    echo [ERROR] %ISS_SCRIPT% not found.
    exit /b 1
)

echo Building installer using Inno Setup...
"%ISCC_PATH%" /O"Output" "%ISS_SCRIPT%"
if %errorlevel% neq 0 (
    echo [ERROR] Inno Setup compiler failed.
    exit /b %errorlevel%
)

echo.
echo ============================================================
echo Build completed successfully. Installer is in the Output folder.
echo ============================================================
exit /b 0
