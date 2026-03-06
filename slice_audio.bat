@echo off
REM ============================================================
REM  CanzonItalia — Audio Slicer
REM  Usage: Place your MP3 next to this file, update SRC and
REM         the timestamps below, then double-click to run.
REM
REM  Requirements: ffmpeg must be on your PATH
REM    Download: https://ffmpeg.org/download.html
REM    Extract to C:\ffmpeg and add C:\ffmpeg\bin to PATH
REM ============================================================

set SRC=sara_perchetamo.mp3
set OUT=assets\audio

echo Slicing "%SRC%" into per-line files...
echo.

REM -- Update these timestamps after identifying them in Audacity --
REM Format: ffmpeg -i %SRC% -ss HH:MM:SS.mmm -to HH:MM:SS.mmm -c copy %OUT%\sara_line_XX.mp3

ffmpeg -i %SRC% -ss 00:00:00.000 -to 00:00:05.000 -c copy %OUT%\sara_line_00.mp3
ffmpeg -i %SRC% -ss 00:00:05.000 -to 00:00:10.000 -c copy %OUT%\sara_line_01.mp3
ffmpeg -i %SRC% -ss 00:00:10.000 -to 00:00:15.000 -c copy %OUT%\sara_line_02.mp3
ffmpeg -i %SRC% -ss 00:00:15.000 -to 00:00:19.000 -c copy %OUT%\sara_line_03.mp3
ffmpeg -i %SRC% -ss 00:00:19.000 -to 00:00:24.000 -c copy %OUT%\sara_line_04.mp3
ffmpeg -i %SRC% -ss 00:00:24.000 -to 00:00:29.000 -c copy %OUT%\sara_line_05.mp3
ffmpeg -i %SRC% -ss 00:00:29.000 -to 00:00:34.000 -c copy %OUT%\sara_line_06.mp3
ffmpeg -i %SRC% -ss 00:00:34.000 -to 00:00:38.000 -c copy %OUT%\sara_line_07.mp3

echo.
echo Done! Check assets\audio\ for the sliced files.
echo Listen to each one and adjust timestamps above if needed.
pause
