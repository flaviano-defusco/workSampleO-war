git init
pause

git config --global http.proxy http://www-proxy.iaea.org:3128
pause

git config --list 
pause

echo #workSampleO-war > README.md
git add README.md
pause

echo staging/ > .gitignore
echo dist/ >> .gitignore
echo logs/ >> .gitignore
echo output/ >> .gitignore
echo test_data/ >> .gitignore
echo .gradle/ >> .gitignore
git add .gitignore
pause

git commit -m "first commit"
pause

git remote add origin https://github.com/flaviano-defusco/workSampleO-war.git
pause

git push -u origin master
pause

pause