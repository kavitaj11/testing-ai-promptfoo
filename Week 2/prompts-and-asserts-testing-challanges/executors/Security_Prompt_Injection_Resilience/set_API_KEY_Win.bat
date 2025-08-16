@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem ==== Search for .env in ., .., ..\.., ..\..\.. ====
set "ENVFILE="
for %%D in (".","..","..\..","..\..\..","..\..\..\..") do (
  if exist "%%~fD\.env" (
    set "ENVFILE=%%~fD\.env"
    goto :found_env
  )
)

echo [WARN] No .env file found in current or up to 4 parent directories.
goto :run

:found_env
echo [INFO] Found .env at: %ENVFILE%

rem ==== Copy .env to current folder ====
copy /Y "%ENVFILE%" ".env" >nul
echo [INFO] Copied .env to current folder: %CD%\.env

rem ==== Load environment variables from copied .env ====
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$f='.env';" ^
  "$re='^\s*([^#][^=]+?)\s*=\s*(.+?)\s*(?:#.*)?$';" ^
  "Get-Content -Raw $f -ErrorAction Stop -Encoding UTF8 | Select-String -Pattern '.*' -AllMatches | %%{ $_.ToString().Split([Environment]::NewLine) } | %%{" ^
  "  if($_ -match $re){" ^
  "    $n=$matches[1].Trim();" ^
  "    $v=$matches[2].Trim();" ^
  "    if($v.StartsWith('\"') -and $v.EndsWith('\"')){ $v=$v.Substring(1,$v.Length-2) }" ^
  "    [Environment]::SetEnvironmentVariable($n,$v,'Process');" ^
  "    Write-Host ('[OK] Set ' + $n + '=' + $v) -ForegroundColor Green" ^
  "  }" ^
  "}"

:run
echo.

pause

