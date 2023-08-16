@echo off
set path=.\venv\Scripts;.\venv;ffmpeg\bin;%path%
.\venv\python.exe .\scripts\long_audio_transcribe.py --languages "CJE" --whisper_size large
pause