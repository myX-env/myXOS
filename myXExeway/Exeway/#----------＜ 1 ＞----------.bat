:: ŠK‘w•\Ž¦
:: “¯‚¶ŠK‘w‚É—¯‚Ü‚é
@echo off
cd /d "%~dp0.."
start "" "Exeway.exe" %*
timeout /t 1 /nobreak >nul
exit /b
