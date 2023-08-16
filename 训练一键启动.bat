@echo off
set path=.\venv\Scripts;.\venv;ffmpeg\bin;%path%
::.\venv\python.exe -m pip uninstall demucs
.\venv\python.exe -m pip install demucs==4.0.0 -i https://pypi.tuna.tsinghua.edu.cn/simple
.\venv\python.exe -m pip install --find-links https://download.pytorch.org/whl/torch_stable.html torch==2.0.1+cu117
.\venv\python.exe -m pip install --find-links https://download.pytorch.org/whl/torch_stable.html torchvision==0.15.2+cu117
.\venv\python.exe -m pip install --find-links https://download.pytorch.org/whl/torch_stable.html torchaudio==2.0.2+cu117
.\venv\python.exe finetune_webui.py
pause