@echo off
set path=.\venv\Scripts;.\venv;ffmpeg\bin;%path%
.\venv\python.exe -m tensorboard.main --logdir=./OUTPUT_MODEL
pause