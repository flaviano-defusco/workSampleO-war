call ..\config
call gradle  --stacktrace --debug myBuild > logs\myBuild.out.log 2> logs\myBuild.err.log
pause
