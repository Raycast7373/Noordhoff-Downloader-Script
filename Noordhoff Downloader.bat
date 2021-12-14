@echo off
color a
echo Please enter the url. Example: http://cdp.contentdelivery.nu/7b4e6264-8562-46f7-93d4-7b8ab0200983/20140808110015/extract/assets/img/layout/page-
set /p url= "Enter url: "
set "ext=.png"
set "extj=.jpg"
set "t=*"
set "page=1"
set "pagea=1"
set "pagej=1"
set "pageja=1"
set "f=00"
set "g=0"
set "afix=10"
set "fix=100"
set "l=.pdf"


set "firstpage=1"
set /p lastpage= "How many pages are there? Example: 244, If the ammount of pages is under 101, type in: 101| "


set /A "page=firstpage"
set /A lastpage=lastpage+1
set /A "pagej=page"

color b
:DaBegin
echo %url%%f%%page%%ext% >> list.txt
echo at %page% right now
set /A page=page+1
ping 127.0.0.1 –n 10 –w > nul
if not %page%==%afix% goto DaBegin else goto DaPart2

:DaPart2
echo %url%%g%%page%%ext% >> list.txt
echo at %page% right now
set /A page=page+1
ping 127.0.0.1 –n 10 –w > nul
if not %page%==%fix% goto DaPart2 else goto DaPart3

:DaPart3
echo %url%%page%%ext% >> list.txt
echo at %page% right now
set /A page=page+1
ping 127.0.0.1 –n 10 –w > nul
if not %page%==%lastpage% goto DaPart3 else goto DaBegin123

:DaBegin123
echo %url%%pagea%%ext% >> list.txt
echo at %pagea% right now
set /A pagea=pagea+1
ping 127.0.0.1 –n 10 –w > nul
if not %pagea%==%afix% goto DaBegin123 else goto DaPart223

:DaPart223
echo %url%%pagea%%ext% >> list.txt
echo at %pagea% right now
set /A pagea=pagea+1
ping 127.0.0.1 –n 10 –w > nul
if not %pagea%==%fix% goto DaPart223 else goto DaBegin1

:DaBegin1
echo %url%%f%%pagej%%extj% >> list.txt
echo at %pagej% right now
set /A pagej=pagej+1
ping 127.0.0.1 –n 10 –w > nul
if not %pagej%==%afix% goto DaBegin1 else goto DaPart21

:DaPart21
echo %url%%g%%pagej%%extj% >> list.txt
echo at %pagej% right now
set /A pagej=pagej+1
ping 127.0.0.1 –n 10 –w > nul
if not %pagej%==%fix% goto DaPart21 else goto DaPart31

:DaPart31
echo %url%%pagej%%extj% >> list.txt
echo at %pagej% right now
set /A pagej=pagej+1
ping 127.0.0.1 –n 10 –w > nul
if not %pagej%==%lastpage% goto DaPart31 else goto DaBegin2

:DaBegin2
echo %url%%pageja%%extj% >> list.txt
echo at %pageja% right now
set /A pageja=pageja+1
ping 127.0.0.1 –n 10 –w > nul
if not %pageja%==%afix% goto DaBegin2 else goto DaPart213

:DaPart213
echo %url%%pageja%%extj% >> list.txt
echo at %pageja% right now
set /A pageja=pageja+1
ping 127.0.0.1 –n 10 –w > nul
if not %pageja%==%fix% goto DaPart213 else goto DaEnd

:DaEnd
color c
set /A page=page-1
set /A pagej=pagej-1
set /A page=page+pagej
echo added %page% lines of text

wget.exe  --retry-connrefused --secure-protocol=auto --load-cookies=cookies.txt --no-check-certificate --waitretry=1 --read-timeout=20 --timeout=15 -t 2 -i list.txt

if not exist download\ mkdir download
if not exist download\jpg\ mkdir download\jpg
move %t%%ext% download\
move %t%%extj% download\jpg
del list.txt

color d
cd download\jpg
echo converting files...
for %%f in (*.jpg) do (
       ..\..\convert.exe "%%~nf.jpg" "%%~nf.png"
)

del *.jpg
cd ../../
move download\jpg\*.png download\
echo Done converting!
color e
set /p name= "how would you like the folder with the files to be called? "
mkdir %name%
move download\*.png %name%\
start explorer.exe "%cd%\%name%"
goto end

:end
echo done!
color f
pause
