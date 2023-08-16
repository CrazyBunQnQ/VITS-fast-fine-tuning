@echo off
set path=.\venv\Scripts;.\venv;ffmpeg\bin;%path%
:: 默认启动命令
.\venv\python.exe VC_inference.py --model_dir ./OUTPUT_MODEL/G_latest.pth --config_dir ./configs/modified_finetune_speaker.json --share False

:: 自定义启动命令
::.\venv\python.exe VC_inference.py --model_dir ./OUTPUT_MODEL/G_3000.pth --config_dir ./configs/modified_finetune_speaker.json --share False
::.\venv\python.exe VC_inference.py --model_dir F:/AI/TrainingData/VITS-fast-fine-tuning/OUTPUT_MODEL/G_latest.pth --config_dir F:/AI/TrainingData/VITS-fast-fine-tuning/configs/modified_finetune_speaker.json --share False
::.\venv\python.exe VC_inference.py --model_dir ./pretrained_models/G_trilingual.pth --config_dir ./configs/uma_trilingual.json --share False
pause