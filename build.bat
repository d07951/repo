@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

set TEMPLATE_DIR=_templates
set METADATA_FILE=metadata.yaml
set LUA_FILTER=_scripts\shiftHeading.lua
set CHAPTERS_DIR=chapters
set TEMP_DIR=tmp

if not exist %TEMP_DIR% mkdir %TEMP_DIR%
del /Q %TEMP_DIR%\*.*

set "cmd="
set "paths_file=%TEMP_DIR%\unique_paths.txt"
type nul > "!paths_file!"

for /f "delims=" %%i in ('dir /b /s "%CHAPTERS_DIR%\*.md"') do (
    set "folder=%%~dpi"
    echo !folder!>> "!paths_file!"
)

sort "!paths_file!" /unique > "!paths_file!.tmp"
move /y "!paths_file!.tmp" "!paths_file!" > nul

for /f "usebackq delims=" %%a in ("!paths_file!") do (
    set "cmd=!cmd! --resource-path="%%a""
)


call :processDirectory "%~dp0%CHAPTERS_DIR%" 1

REM ===== Generate PDF with Pandoc =====
echo Generating PDF with Pandoc...

SET CURRENT_DIR=%~dp0
FOR %%F IN ("%CURRENT_DIR:~0,-1%") DO SET FOLDER_NAME=%%~nxF
SET OUTPUT_FILE=%FOLDER_NAME%.pdf
pandoc --pdf-engine=xelatex %TEMP_DIR%\structure.md %PRODUCT_FILES% --metadata-file=%METADATA_FILE% --template=".\_templates\dnake.latex" --toc --toc-depth=2 -o "%OUTPUT_FILE%" !cmd!

rmdir /s /q %TEMP_DIR%
echo OK
start %OUTPUT_FILE%
exit /b













:processDirectory
REM Set currentDir and level at the beginning of the function
set "currentDir=%~1"
set "level=%~2"

REM Determine the heading prefix based on the level
set "headingPrefix="
if %level%==1 set "headingPrefix=#"
if %level%==2 set "headingPrefix=#"
if %level%==3 set "headingPrefix=##"
if %level%==4 set "headingPrefix=###"
if %level%==5 set "headingPrefix=####"

@REM for /L %%i in (1,1,%level%) do set "headingPrefix=!headingPrefix!#"

REM Get the directory name without the full path
for %%i in ("%currentDir%") do set "dirName=%%~nxi"

REM Skip the top-level CHAPTERS_DIR
if "%currentDir%" neq "%~dp0%CHAPTERS_DIR%" (
    REM Remove leading numbers and space from the directory name
    set "dirName=!dirName:~3!"
    echo. >> %TEMP_DIR%\structure.md
    echo !headingPrefix! !dirName! >> %TEMP_DIR%\structure.md
)

REM Process each Markdown file in the current directory
for %%f in ("%currentDir%\*.md") do (
    echo. >> %TEMP_DIR%\structure.md  
    type "%%f" >> %TEMP_DIR%\structure.md
    echo. >> %TEMP_DIR%\structure.md  
)

REM Process each subdirectory
for /d %%d in ("%currentDir%\*") do (
    set /a newLevel=%level% + 1
    call :processDirectory "%%d" !newLevel!
)

exit /b