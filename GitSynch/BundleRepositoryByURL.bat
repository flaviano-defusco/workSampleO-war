set "REPO_TO_CLONE=%1%"
set "REPO_URL=%2%"

cd %REPO_HOME%
if exist %REPO_TO_CLONE% goto repo_exists
IF "%LOG_DISABLED%" == "" IF "%LOG_DISABLED%" == "" echo %REPO_TO_CLONE%: about to clone
git clone %REPO_URL% 2>&1
cd %REPO_TO_CLONE%
set REPO_BUNDLE=%REPO_TO_CLONE%.bundle
IF "%LOG_DISABLED%" == "" echo %REPO_TO_CLONE%: creating full bundle %REPO_BUNDLE%
git bundle create %GIT_SYNCH_HOME%\%REPOSITORIES_TO_REPLICATE%\%REPO_BUNDLE% --all
call %GIT_SYNCH_HOME%\UniqueName Bundle
IF "%LOG_DISABLED%" == "" echo %REPO_TO_CLONE%: about to tag %UniqueName%
git tag %UniqueName% 2>&1
IF "%LOG_DISABLED%" == "" echo %REPO_TO_CLONE%: about to push tag %UniqueName%
git push origin %UniqueName% 2>&1
echo set "lastTag=%UniqueName%" > %GIT_SYNCH_HOME%\%REPOSITORIES_TO_REPLICATE%\%REPO_TO_CLONE%\lastTag.bat
call %GIT_SYNCH_HOME%\ArchiveRepositoryBundle
goto main_end

:repo_exists
IF "%LOG_DISABLED%" == "" echo %REPO_TO_CLONE%: trying incremental update
cd %GIT_SYNCH_HOME%\%REPOSITORIES_TO_REPLICATE%\%REPO_TO_CLONE%
call lastTag
IF "%LOG_DISABLED%" == "" echo %REPO_TO_CLONE%: last bundle at tag %lastTag%
cd %REPO_HOME%\%REPO_TO_CLONE%
IF "%LOG_DISABLED%" == "" echo %REPO_TO_CLONE%: about to pull
git pull 2>&1
del /F %GIT_SYNCH_HOME%\%REPOSITORIES_TO_REPLICATE%\%REPO_TO_CLONE%\%lastTag%_list.txt 2> nul
IF "%LOG_DISABLED%" == "" echo %REPO_TO_CLONE%: about to list
git log --oneline %lastTag%..master > %GIT_SYNCH_HOME%\%REPOSITORIES_TO_REPLICATE%\%REPO_TO_CLONE%\%lastTag%_list.txt 2>&1
for /f %%i in ("%GIT_SYNCH_HOME%\%REPOSITORIES_TO_REPLICATE%\%REPO_TO_CLONE%\%lastTag%_list.txt") do set size=%%~zi
if %size% gtr 0 goto not_empty

:empty
IF "%LOG_DISABLED%" == "" echo %REPO_TO_CLONE%: about to remove empty file %GIT_SYNCH_HOME%\%REPOSITORIES_TO_REPLICATE%\%REPO_TO_CLONE%\%lastTag%_list.txt
del /F %GIT_SYNCH_HOME%\%REPOSITORIES_TO_REPLICATE%\%REPO_TO_CLONE%\%lastTag%_list.txt
IF "%LOG_DISABLED%" == "" echo %REPO_TO_CLONE%: nothing to update
goto main_end

:not_empty
call %GIT_SYNCH_HOME%\UniqueName Bundle
set REPO_BUNDLE=%REPO_TO_CLONE%_%UniqueName%.bundle
IF "%LOG_DISABLED%" == "" echo %REPO_TO_CLONE%: %lastTag%_list.txt not empty, about to create bundle %REPO_BUNDLE%
git bundle create %GIT_SYNCH_HOME%\%REPOSITORIES_TO_REPLICATE%\%REPO_BUNDLE% %lastTag%..master 2>&1
IF "%LOG_DISABLED%" == "" echo %REPO_TO_CLONE%: about to tag %UniqueName%
git tag %UniqueName% 2>&1
IF "%LOG_DISABLED%" == "" echo %REPO_TO_CLONE%: about to push tag %UniqueName%
git push origin %UniqueName% 2>&1
echo set "lastTag=%UniqueName%" > %GIT_SYNCH_HOME%\%REPOSITORIES_TO_REPLICATE%\%REPO_TO_CLONE%\lastTag.bat
call %GIT_SYNCH_HOME%\ArchiveRepositoryBundle

:main_end
cd %GIT_SYNCH_HOME%
EXIT /B %ERRORLEVEL%

