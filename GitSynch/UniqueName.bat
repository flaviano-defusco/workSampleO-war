@echo off
set "ARG=%*"
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
Rem echo %dt%
set "YYYY=%dt:~0,4%"
set "MM=%dt:~4,2%"
set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%"
set "Min=%dt:~10,2%"
set "Sec=%dt:~12,2%"

set "UniqueName=%ARG%%YYYY%%MM%%DD%_%HH%%Min%%Sec%"