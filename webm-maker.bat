@echo off

::Notes, add support for file splitting, aspect ratio handling

for /f %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"
echo %ESC%[0;32m~$CHAN WEBM MAKER PRO~%ESC%[0m


:: Necessary for some loop and branching operations ::
setlocal enabledelayedexpansion

:: Max 4chan file size for webm's, slightly reduced because ffmpeg averages the bitrate and it can become slightly bigger than the max size, even with perfect calculation
set max_file_size=3000

:: Check if script was started with a proper parameter ::
if "%~1" == "" (
    echo This script needs to be run by dragging and dropping a video file on it.
    echo It cannot do anything by itself.
    pause
    goto :EOF
)

:: Ahoy ::
echo %ESC%[1m%ESC%[0m%ESC%[31m  BY PROMPTPIRATE%ESC%[0m%ESC%[1m%ESC%[0m
echo  ~Forked from Cephei~

:: Time for some setup ::
cd /d "%~dp0"

:: Create export directory if it doesn't exist ::
if not exist "export" mkdir export

:: Ask user how big the webm should be ::
echo Please enter webm render resolution.
echo Example: 720 for 720p.
echo Default: Source video resolution.
set /p resolution="Enter: " %=%
if not "%resolution%" == "" (set resolutionset=-vf scale=-1:%resolution%) else (set resolutionset=)

echo.

:: Ask user where to start webm rendering in source video ::
echo Please enter webm rendering offset in SECONDS.
echo Example: 31
echo Default: Start of source video.
set /p start="Enter: " %=%
if not "%start%" == "" (set startset=-ss %start%) else (set startset=)

echo.

:: Ask user for length of rendering ::
echo Please enter webm rendering length in SECONDS.
echo Example: 15
echo Default: Entire source video.
set /p length="Enter: " %=%
if not "%length%" == "" (
    set lengthset=-t %length%
    set lengthdefined=1
) else (
    ffmpeg.exe -i %1 2> webm.tmp
    for /f "tokens=1,2,3,4,5,6 delims=:., " %%i in (webm.tmp) do (
        if "%%i"=="Duration" call :calculatelength %%j %%k %%l %%m
    )
    del webm.tmp
    echo Using source video length: !length! seconds
    set lengthset=-t !length!
    set lengthdefined=1
)

echo.

:: Ask user whether to include audio ::
echo Include audio? (yes/no)
set /p include_audio="Enter: " %=%
if /i "%include_audio%" == "yes" (set include_audio_flag=-c:a libvorbis) else (set include_audio_flag=-an)

:: Verify length is defined ::
if not defined lengthdefined (
    echo Length not defined. Exiting script.
    pause
    goto :EOF
)

:: Find bitrate that maxes out max filesize on 4chan, defined above ::
set /a bitrate=8*%max_file_size%/!length! 2>nul
echo Target bitrate: %bitrate%

:: Set export destination to the "export" folder within the current directory ::
set export_dest=export\%~n1.webm

:: Two pass encoding because reasons ::
ffmpeg.exe -i "%~1" -c:v libvpx -b:v %bitrate%K -quality best %resolutionset% %startset% %lengthset% %include_audio_flag% -sn -threads 0 -f webm -pass 1 -y NUL

ffmpeg.exe -i "%~1" -c:v libvpx -b:v %bitrate%K -quality best %resolutionset% %startset% %lengthset% %include_audio_flag% -sn -threads 0 -pass 2 -y "%export_dest%"
del ffmpeg2pass-0.log
pause
goto :EOF

:: Helper function to calculate length of video ::
:calculatelength
for /f "tokens=* delims=0" %%a in ("%3") do set /a s=%%a
for /f "tokens=* delims=0" %%a in ("%2") do set /a s=s+%%a*60
for /f "tokens=* delims=0" %%a in ("%1") do set /a s=s+%%a*60*60
set /a length=s
