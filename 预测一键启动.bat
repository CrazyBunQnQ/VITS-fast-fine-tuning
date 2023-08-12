@echo off
set path=.\venv\Scripts;.\venv;ffmpeg\bin;%path%
.\venv\python.exe VC_inference.py --model_dir ./OUTPUT_MODEL/G_latest.pth --config_dir ./configs/modified_finetune_speaker.json --share False
::.\venv\python.exe VC_inference.py --model_dir ./OUTPUT_MODEL/G_latest.pth --config_dir ./finetune_speaker.json --share False
pause