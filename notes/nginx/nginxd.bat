@echo off
set nginx_home=%NGINX_HOME%
if "%1"=="help" (goto help) else (if "%1"=="-h" goto help)
if "%1"=="version" (goto version) else (if "%1"=="-v" goto version)
if "%1"=="start" goto start
if "%1"=="stop" goto stop
if "%1"=="reload" goto reloadmd
if "%1"=="reopen" goto reopen
if "%1"=="find" goto find
goto error

:help
nginx -v
echo Usage: nginxd [-h,help] [-v,version] [start] [stop] [stop -a] [reload] [reopen] [find]
echo=
echo Options:
echo   help,-h         : this help information.
echo   version,-v      : show current nginx version.
echo   start           : start nginx master process.
echo   stop            : stop the newest nginx master process.
echo   stop -a         : stop all nginx master processes.
echo   reload          : reload configuration.
echo   reopen          : reopen nginx.
echo   find            : show the nginx master process list.
echo=
exit /B



:version
nginx -v
exit /B


:start
echo.
echo   *****************************************************
echo.
echo          Please select a nginx configuration file
echo.
echo   *****************************************************
echo.
echo             1.   simcere
echo.
echo             2.   epms
echo.

echo.&echo.&set /p var=please input number -^>$


if  "%var%"=="1"  start nginx -p %nginx_home%\ -c conf/simcere-nginx.conf
if  "%var%"=="2"  start nginx -p %nginx_home%\ -c conf/epms-nginx.conf
exit /B





:stop
if "%2"=="-a" (taskkill /F /IM nginx.exe) else (if "%2"=="" (nginx -s stop -p %nginx_home%\) else goto error)
exit /B

:reload
nginx -s reload -p %nginx_home%\
exit /B

:find
tasklist /fi "imagename eq nginx.exe"
exit /B

:error
echo nginxd: invalid option: "%1 %2 %var%"
echo=
exit /B