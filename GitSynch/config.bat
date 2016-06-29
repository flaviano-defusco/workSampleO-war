Rem config variables for test environment - change for live
set GIT_SYNCH_HOME=c:\testJava\GitSynch
set REPO_HOME=C:\testJava\TestRepo
set ISE_DROP=\\tsclient\C\ISEDrop
Rem actually only userId - passwords musyt be already configured in Git via SourceSafe
set MY_CREDENTIALS_STASH=flaviano.d.fusco@stash-limbo.palantir.com
set MY_CREDENTIALS_GITHUB=flaviano-defusco
Rem other config variables - shouldn't change these
set PROJECT=IAEA
set REPOSITORIES_TO_REPLICATE=repositoriesToReplicate

Rem enable this to flag communication errors
Rem set GIT_CURL_VERBOSE=1
Rem enable this to disable logging
Rem set DISABLE_LOG=1
