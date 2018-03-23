REM ## This project is for windows7
REM ## It will run and asked user for input file
REM ## Once input file supplied, it will encode the file
REM ## using windows proided dll/exe in a manner that
REM ## it will not remain human readable form.

REM ## This script also ensures hard decrypt function
REM ## in case of backtracking the same file to retrieve content
REM ## The commands will itself corrupt the file instead of smooth decrypt.

REM #################################################
REM ###                                         #####
REM ###	Author : Rahul Kumar			#####
REM ###	Last Modified : 23/march/2018		#####
REM ###	Used under windows programming concept	#####
REM ###						#####
REM #################################################

REM ##### Start of the script

@echo off
set /p UserInputFile= What is the file you would like to encrypt?
certutil -encodehex %UserInputFile% %UserInputFile%.temp
For %%A in ("%UserInputFile%") do (
    Set Folder=%%~dpA
    Set FName=%%~nxA
)
rename %UserInputFile% %FName%-bck
certutil -encode %UserInputFile%.temp %UserInputFile%
set ReplaceLine=1
set InFile=%UserInputFile%
set TempFile=%Folder%\TempTest.txt
if exist "%TempFile%" del "%TempFile%"
echo. 2>"%TempFile%"
echo -----BEGIN CERTIFICATE----->>"%TempFile%"
echo IDczRCAgHTUyL0KTUSMVAVR7Li51cw0KMDBjMAk2NSA3MiAzYSAyMiA0ZSA0MSA1>> "%TempFile%"
more +%ReplaceLine% < "%InFile%" >> "%TempFile%"
copy /y "%TempFile%" "%InFile%"
del "%TempFile%"
rem pause
del %UserInputFile%.temp
echo Encryption completed
pause
goto :eof
