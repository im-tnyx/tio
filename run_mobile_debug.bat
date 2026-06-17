@echo off
title TNYX Debug Runner
echo ===================================================
echo   Starting TNYX Flutter App in Debug Mode
echo ===================================================
echo.

:: Change directory to the mobile app folder
cd /d "%~dp0apps\mobile"

:: Run flutter using the local SDK path
call G:\dev\flutter-sdk\bin\flutter.bat run -t lib/src/main.dart

echo.
echo ===================================================
echo   App session terminated.
echo ===================================================
pause
