set "REPO_TO_CLONE=%1%"
if exist %GIT_SYNCH_HOME%\%REPOSITORIES_TO_REPLICATE%\%REPO_TO_CLONE%\GitHub\* goto git_url
:stash_url
set "REPOSITORY_URL=https://%MY_CREDENTIALS_STASH%/scm/%PROJECT%/%REPO_TO_CLONE%.git"
goto work
:git_url
set "REPOSITORY_URL=https://github.com/%MY_CREDENTIALS_GITHUB%/%REPO_TO_CLONE%"
:work
call BundleRepositoryByURL %REPO_TO_CLONE% %REPOSITORY_URL%
