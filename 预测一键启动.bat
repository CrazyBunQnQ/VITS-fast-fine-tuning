@echo off
set path=.\venv\Scripts;.\venv;ffmpeg\bin;%path%
:: default
.\venv\python.exe VC_inference.py --model_dir ./OUTPUT_MODEL/G_latest.pth --config_dir ./configs/modified_finetune_speaker.json --share False

:: custom
::.\venv\python.exe VC_inference.py --model_dir ./OUTPUT_MODEL/G_530.pth --config_dir ./configs/modified_finetune_speaker.json --share False
::.\venv\python.exe VC_inference.py --model_dir F:/AI/TrainingData/VITS-fast-fine-tuning/OUTPUT_MODEL/G_latest.pth --config_dir F:/AI/TrainingData/VITS-fast-fine-tuning/configs/modified_finetune_speaker.json --share False
::.\venv\python.exe VC_inference.py --model_dir ./pretrained_models/G_trilingual.pth --config_dir ./configs/uma_trilingual.json --share False

:: release
:: kafka
::.\venv\python.exe VC_inference.py --model_dir ./pretrained_models/G_kafka_4060.pth --config_dir ./pretrained_models/G_kafka_config.json --share False
pause