@echo off 
color 0a  
mode con: cols=80 lines=35
:menu
cls
:::  ______   ________  __       __   ______   ________  ______   __    __  ________ 
::: /      \ /        |/  \     /  | /      \ /        |/      \ /  \  /  |/        |
:::/$$$$$$  |$$$$$$$$/ $$  \   /$$ |/$$$$$$  |$$$$$$$$//$$$$$$  |$$  \ $$ |$$$$$$$$/ 
:::$$ | _$$/ $$ |__    $$$  \ /$$$ |$$ \__$$/    $$ |  $$ |  $$ |$$$  \$$ |$$ |__    
:::$$ |/    |$$    |   $$$$  /$$$$ |$$      \    $$ |  $$ |  $$ |$$$$  $$ |$$    |   
:::$$ |$$$$ |$$$$$/    $$ $$ $$/$$ | $$$$$$  |   $$ |  $$ |  $$ |$$ $$ $$ |$$$$$/    
:::$$ \__$$ |$$ |_____ $$ |$$$/ $$ |/  \__$$ |   $$ |  $$ \__$$ |$$ |$$$$ |$$ |_____ 
:::$$    $$/ $$       |$$ | $/  $$ |$$    $$/    $$ |  $$    $$/ $$ | $$$ |$$       |
::: $$$$$$/  $$$$$$$$/ $$/      $$/  $$$$$$/     $$/    $$$$$$/  $$/   $$/ $$$$$$$$/                                                                                                                                                                    
::: _______    ______   ________  ______   _______    ______    ______   ________    
:::/       \  /      \ /        |/      \ /       \  /      \  /      \ /        |   
:::$$$$$$$  |/$$$$$$  |$$$$$$$$//$$$$$$  |$$$$$$$  |/$$$$$$  |/$$$$$$  |$$$$$$$$/    
:::$$ |  $$ |$$ |__$$ |   $$ |  $$ |__$$ |$$ |__$$ |$$ |__$$ |$$ \__$$/ $$ |__       
:::$$ |  $$ |$$    $$ |   $$ |  $$    $$ |$$    $$< $$    $$ |$$      \ $$    |      
:::$$ |  $$ |$$$$$$$$ |   $$ |  $$$$$$$$ |$$$$$$$  |$$$$$$$$ | $$$$$$  |$$$$$/       
:::$$ |__$$ |$$ |  $$ |   $$ |  $$ |  $$ |$$ |__$$ |$$ |  $$ |/  \__$$ |$$ |_____    
:::$$    $$/ $$ |  $$ |   $$ |  $$ |  $$ |$$    $$/ $$ |  $$ |$$    $$/ $$       |   
:::$$$$$$$/  $$/   $$/    $$/   $$/   $$/ $$$$$$$/  $$/   $$/  $$$$$$/  $$$$$$$$/                                                              
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
echo  1. Start Program                      
echo.
echo  2. Mineral List                          
echo.
echo  3. Web Resources
echo.
echo  4. Credits
echo.
choice /c 1234 /n /m "Choose an option: "

if errorlevel 4 goto credits
if errorlevel 3 goto web
if errorlevel 2 goto list
if errorlevel 1 goto start

:list
cls
echo ==================================
echo          MINERAL LIST
echo ==================================
echo.
echo PRESS ENTER TO SCROLL THROUGH THE LIST
echo. 

if exist data\mineral_list.txt (
    more data\mineral_list.txt
	echo.
) else (
    echo File mineral_list.txt not found!
)
echo.
pause
echo.
goto menu


:credits
cls

if exist data\credits.txt (
    more data\credits.txt
	echo.
) else (
    echo credits.txt not found!
)
echo.
pause
goto menu

:start
cls
echo ==================================
echo         GEMSTONE SEARCH
echo ==================================
echo.
echo Type gemstone name (or part of it)
echo.
echo Type LIST to show all minerals
echo.
echo Type EXIT to back to main menu
echo.
set "gem="
set /p gem=^> 

:: === NORMALIZZAZIONE E COMANDI ===
if /i "%gem%"=="" goto start
set gem=%gem: =_%
set gem=%gem:-=_%
if /i "%gem%"=="list" goto list
if /i "%gem%"=="exit" goto menu

:: === MATCH ESATTO ===
if exist data\%gem%.txt (
    cls
    echo === FOUND ===
    echo.
    more data\%gem%.txt
    echo.
    pause
    goto start
)

:: === LOGICA AUTO-OPEN / SUGGERIMENTI ===
set "found_count=0"
set "last_found="

:: Primo ciclo: Conta quanti match ci sono
for %%f in (data\*%gem%*.txt) do (
    set /a found_count+=1
    set "last_found=%%~nf"
)

:: Caso 1: Un solo match trovato -> APRE DIRETTAMENTE
if %found_count%==1 (
    cls
    echo === AUTO-OPENING: %last_found% ===
    echo.
    more "data\%last_found%.txt"
    echo.
    pause
    goto start
)

:: Caso 2: Nessun match
if %found_count%==0 (
    echo.
    echo Mineral not found!
    echo.
    pause
    goto start
)

:: Caso 3: Più match trovati -> ELENCA SUGGERIMENTI
echo.
echo Multiple matches found (%found_count%):
echo -------------------------
for %%f in (data\*%gem%*.txt) do (
    echo %%~nf
)
echo -------------------------
echo.
pause
goto start



:web
cls
echo.
echo ======================================================
echo                WEB RESOURCES AND TOOLS
echo ======================================================
echo.
echo  1. PROSPECTION (Maps, localities, soil data)
echo  2. FACETING (Design, diagrams, angles)
echo  3. MARKET (Prices, valuations, news)
echo  4. VIDEO (Techniques, field trips, education)
echo  5. INSTRUMENTATION (Lab tools, ID, testing)
echo  6. SOFTWARE (GemCad, Ray tracing, 3D)
echo.
echo  7. Back to Main Menu
echo.
echo ======================================================
set "webchoice="
set /p webchoice="Select category (1-7): "

if "%webchoice%"=="1" goto web_prospect
if "%webchoice%"=="2" goto web_faceting
if "%webchoice%"=="3" goto web_market
if "%webchoice%"=="4" goto web_video
if "%webchoice%"=="5" goto web_tools
if "%webchoice%"=="6" goto web_soft
if "%webchoice%"=="7" goto menu

echo Invalid selection.
pause
goto web

:web_prospect
cls
echo ======================================================
echo             PROSPECTION AND FIELD WORK
echo ======================================================
echo.
echo  1. MINDAT (Locality Search)
echo  2. ISPRA (Geological Maps Italy)
echo  3. MACROSTRAT (Global Geology)
echo  4. USMIN (Mineral Deposit Database)
echo.
echo  5. Back
echo.
set "prchoice="
set /p prchoice="Select resource (1-5): "

if "%prchoice%"=="1" start https://www.mindat.org/ & goto web_prospect
if "%prchoice%"=="2" start https://portalesgi.isprambiente.it/ & goto web_prospect
if "%prchoice%"=="3" start https://macrostrat.org/map/ & goto web_prospect
if "%prchoice%"=="4" start https://www.usgs.gov/centers/gggsc/science/usmin-mineral-deposit-database & goto web_prospect
if "%prchoice%"=="5" goto web
goto web_prospect

:web_faceting
cls
echo ======================================================
echo              FACETING AND PROCESSING
echo ======================================================
echo.
echo  1. GEMOLOGY PROJECT (Faceting Designs)
echo  2. GEM ARTIST (Alternative Diagrams)
echo.
echo  3. Back
echo.
set "fachoice="
set /p fachoice="Select resource (1-3): "

if "%fachoice%"=="1" start https://gemologyproject.com/wiki/index.php?title=Faceting_Designs & goto web_faceting
if "%fachoice%"=="2" start http://www.gemartist.org/ & goto web_faceting
if "%fachoice%"=="3" goto web
goto web_faceting

:web_market
cls
echo ======================================================
echo              MARKET AND PRICE FINDER
echo ======================================================
echo.
echo  1. GEMVAL (Price Reference)
echo  2. ROCKSEEKER (Market News)
echo  3. STONE GROUP LABS (Lab Alerts)
echo.
echo  4. Back
echo.
set "marchoice="
set /p marchoice="Select resource (1-4): "

if "%marchoice%"=="1" start https://www.gemval.com/ & goto web_market
if "%marchoice%"=="2" start https://rockseeker.com/ & goto web_market
if "%marchoice%"=="3" start https://stonegrouplabs.com/ & goto web_market
if "%marchoice%"=="4" goto web
goto web_market

:web_video
cls
echo ======================================================
echo               VIDEO AND EDUCATION
echo ======================================================
echo.
echo  1. MOREGEMS (Lapidary Techniques)
echo  2. DAN HURD (Prospecting and Mining)
echo  3. GIA (Gemology and Lab Analysis)
echo  4. LIZ KREATE (DIY Tools and Lapidary)
echo  5. JUSTIN K PRIM (Faceting History and Tech)
echo  6. GEMSTONES.COM (Gem Science)
echo.
echo  7. Back
echo.
set "vidchoice="
set /p vidchoice="Select resource (1-7): "

if "%vidchoice%"=="1" start https://www.youtube.com/@Moregems & goto web_video
if "%vidchoice%"=="2" start https://www.youtube.com/@Danhurd & goto web_video
if "%vidchoice%"=="3" start https://www.youtube.com/@giastats & goto web_video
if "%vidchoice%"=="4" start https://www.youtube.com/@LizKreate & goto web_video
if "%vidchoice%"=="5" start https://www.youtube.com/@JustinKPrim & goto web_video
if "%vidchoice%"=="6" start https://www.youtube.com/@Gemstones_com & goto web_video
if "%vidchoice%"=="7" goto web
goto web_video

:web_tools
cls
echo ======================================================
echo             INSTRUMENTATION AND TESTING
echo ======================================================
echo.
echo  1. GEMOLOGY ONLINE (Technical Tool Forum)
echo  2. ALGT (Lab Reports and Treatments)
echo  3. IGS (Gem ID Guides)
echo.
echo  4. Back
echo.
set "tchoice="
set /p tchoice="Select resource (1-4): "

if "%tchoice%"=="1" start https://www.gemologyonline.com/ & goto web_tools
if "%tchoice%"=="2" start https://www.algtantwerp.org/ & goto web_tools
if "%tchoice%"=="3" start https://www.gemsociety.org/ & goto web_tools
if "%tchoice%"=="4" goto web
goto web_tools

:web_soft
cls
echo ======================================================
echo                SOFTWARE AND SIMULATION
echo ======================================================
echo.
echo  1. GEMCAD (Faceting Design Software)
echo  2. GEMRAY (Light Ray Tracing)
echo  3. FACET-HOPPER (Parametric Faceting)
echo.
echo  4. Back
echo.
set "schoice="
set /p schoice="Select resource (1-4): "

if "%schoice%"=="1" start http://www.gemcad.com/ & goto web_soft
if "%schoice%"=="2" start http://www.gemcad.com/gemray.html & goto web_soft
if "%schoice%"=="3" start https://www.food4rhino.com/en/app/facet-hopper & goto web_soft
if "%schoice%"=="4" goto web
goto web_soft

