@echo off
call config
call %GIT_SYNCH_HOME%\UniqueName
echo Started at: %UniqueName%
cd %GIT_SYNCH_HOME%
for /D /r %%a in (%REPOSITORIES_TO_REPLICATE%\*) do (
    echo %%~nxa: processing repository
    call BundleRepository %%~nxa
)
call %GIT_SYNCH_HOME%\UniqueName
echo Ended at: %UniqueName%
