# 本地培训
### 构建环境
0. 确保已安装 `Python==3.8`，CMake & C/C++编译器，ffmpeg; 
1. 克隆此存储库;
2. 运行 `pip install -r requirements.txt`;
   > 其中 `pyopenjtalk` 可能需要添加 `--no-build-isolation` 参数
3. 安装对应 GPU 版本的 PyTorch：（确保您电脑上已安装 CUDA 11.6 或 11.7 或 11.8）
    ```
   # CUDA 11.6
    pip install torch==1.13.1+cu116 torchvision==0.14.1+cu116 torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/cu116
    # CUDA 11.7
    pip install torch==1.13.1+cu117 torchvision==0.14.1+cu117 torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/cu117
    # CUDA 11.8
    pip install torch==1.13.1+cu118 torchvision==0.15.2+cu118 torchaudio==2.0.2 --find-links https://download.pytorch.org/whl/torch_stable.html
   ```
4. 安装处理视频数据所需的库：
    ```
   pip install imageio==2.4.1
   pip install moviepy
   ```
5. 构建单调对齐（训练所必需的）
    ```
    cd monotonic_align
    mkdir monotonic_align
    python setup.py build_ext --inplace
    cd ..
    ```
6. 下载辅助数据进行训练
    ```
    mkdir pretrained_models
    # 下载数据进行微调
    wget https://huggingface.co/datasets/Plachta/sampled_audio4ft/resolve/main/sampled_audio4ft_v2.zip
    unzip sampled_audio4ft_v2.zip
    # 创建必要的目录
    mkdir video_data
    mkdir raw_audio
    mkdir denoised_audio
    mkdir custom_character_voice
    mkdir segmented_character_voice
   ```
7. 下载预训练模型，可用选项包括：
    ```
   CJE: 三语（中文、日文、英文）
   CJ: 双重（中文、日文）
   C: 只有中文
   ```
   ### Linux
   要下载 `CJE` 模型，请运行以下命令：
    ```
   wget https://huggingface.co/spaces/Plachta/VITS-Umamusume-voice-synthesizer/resolve/main/pretrained_models/D_trilingual.pth -O ./pretrained_models/D_0.pth
   wget https://huggingface.co/spaces/Plachta/VITS-Umamusume-voice-synthesizer/resolve/main/pretrained_models/G_trilingual.pth -O ./pretrained_models/G_0.pth
   wget https://huggingface.co/spaces/Plachta/VITS-Umamusume-voice-synthesizer/resolve/main/configs/uma_trilingual.json -O ./configs/finetune_speaker.json
   ```
   要下载 `CJ` 模型，请运行以下命令：
   ```
   wget https://huggingface.co/spaces/sayashi/vits-uma-genshin-honkai/resolve/main/model/D_0-p.pth -O ./pretrained_models/D_0.pth
   wget https://huggingface.co/spaces/sayashi/vits-uma-genshin-honkai/resolve/main/model/G_0-p.pth -O ./pretrained_models/G_0.pth
   wget https://huggingface.co/spaces/sayashi/vits-uma-genshin-honkai/resolve/main/model/config.json -O ./configs/finetune_speaker.json
   ```
   要下载 `C` 模型，请运行以下命令：
   ```
   wget https://huggingface.co/datasets/Plachta/sampled_audio4ft/resolve/main/VITS-Chinese/D_0.pth -O ./pretrained_models/D_0.pth
   wget https://huggingface.co/datasets/Plachta/sampled_audio4ft/resolve/main/VITS-Chinese/G_0.pth -O ./pretrained_models/G_0.pth
   wget https://huggingface.co/datasets/Plachta/sampled_audio4ft/resolve/main/VITS-Chinese/config.json -O ./configs/finetune_speaker.json
   ```
   ### Windows
   从上述选项之一中的 URL 手动下载 `G_0.pth`, `D_0.pth`, `finetune_speaker.json` 。
   
   将所有 `G` 模型重命名为 `G_0.pth`，`D` 模型重命名为 `D_0.pth`，将配置文件（`.json`）重命名为`finetune_speaker.json`。
   将 `G_0.pth`，`D_0.pth` 放在 `pretrained_models` 目录下;
   将 `finetune_speaker.json` 放在 `configs` 目录下

   > **请注意，当您下载其中一个时，以前的模型将被覆盖。**
9. 将您的语音数据放在相应的目录下，请参阅 [DATA.MD](DATA.MD) 详细介绍了不同的上传选项。
   ### 短音频
   1. 根据数据准备 [DATA.MD](DATA.MD) 作为单个 `.zip` 文件;
   2. 将您的文件放在目录 `./custom_character_voice/` 下;
   3. 运行 `unzip ./custom_character_voice/custom_character_voice.zip -d ./custom_character_voice/`
   
   ### 长音频
   1. 根据 [DATA.MD](DATA.MD) 命名您的音频文件;
   2. 将重命名的音频文件放在 `./raw_audio/` 目录
   
   ### 视频
   1. 根据 [DATA.MD](DATA.MD) 命名您的视频文件;
   2. 将重命名的视频文件放在 `./video_data/` 目录
10. 处理所有音频数据。
   ```
   # 视频转音频
   python scripts/video2audio.py
   # 降噪音频, 读取 ./raw_audio 目录下的音频文件, 输出到 ./denoised_audio 目录(中途会在 ./separated/htdemucs/{file}/vocals.wav 生成分离的文件)
   python scripts/denoise_audio.py
   # 长音频转录, 读取 ./denoised_audio 目录下降噪后的音频, 分割后输出到 ./segmented_character_voice 目录下, 并生成 ./long_character_anno.txt
   python scripts/long_audio_transcribe.py --languages "{PRETRAINED_MODEL}" --whisper_size large
   # 短音频转录, 读取 ./custom_character_voice/ 目录下已经解压 zip 的 wav 文件, 输出到原目录的 processed_n.wav, 并生成 ./short_character_anno.txt
   python scripts/short_audio_transcribe.py --languages "{PRETRAINED_MODEL}" --whisper_size large
   # 重新采样, 修改读取与输出目录后再运行！
   python scripts/resample.py
   ```
   根据您之前的型号选择，将 `"{PRETRAINED_MODEL}"` 替换为 `{CJ, CJE, C}` 之一。  
   Make sure you have a minimum GPU memory of 12GB. If not, change the argument `whisper_size` to `medium` or `small`.
   确保您至少有 12GB 的 GPU 内存。如果没有，请将参数 `whisper_size` 更改为 `medium` 或 `small`。

10. 处理所有文本数据。
   如果选择添加辅助数据，运行 `python preprocess_v2.py --add_auxiliary_data True --languages "{PRETRAINED_MODEL}"`  
   如果没有，请运行 `python preprocess_v2.py --languages "{PRETRAINED_MODEL}"`  
   请根据您之前的型号选择，将 `"{PRETRAINED_MODEL}"` 替换为 `{CJ, CJE, C}` 之一。

11. 开始训练。
   运行 `python finetune_speaker_v2.py -m ./OUTPUT_MODEL --max_epochs "{Maximum_epochs}" --drop_speaker_embed True`  
   请将 `{Maximum_epochs}` 替换为所需的纪元数。根据经验，建议使用 100 或更多。
   要在上一个检查点上继续训练，请将训练命令更改为： `python finetune_speaker_v2.py -m ./OUTPUT_MODEL --max_epochs "{Maximum_epochs}" --drop_speaker_embed False --cont True`. 在执行此操作之前，请确保在 `./OUTPUT_MODEL/` 目录下有以前的 `G_latest.pth` 和 `D_latest.pth`。
   要查看训练进度，请打开一个新终端并 `cd` 到项目根目录，运行 `tensorboard --logdir=./OUTPUT_MODEL`，然后使用 Web 浏览器访问 `localhost：6006`。

12. 训练完成后，可以通过运行以下命令来使用模型：
   `python VC_inference.py --model_dir ./OUTPUT_MODEL/G_latest.pth --share True`
13. 要清除所有音频数据，请运行：
   ### Linux
   ```
   rm -rf ./custom_character_voice/* ./video_data/* ./raw_audio/* ./denoised_audio/* ./segmented_character_voice/* ./separated/* long_character_anno.txt short_character_anno.txt
   ```
   ### Windows
   ```
   del /Q /S .\custom_character_voice\* .\video_data\* .\raw_audio\* .\denoised_audio\* .\segmented_character_voice\* .\separated\* long_character_anno.txt short_character_anno.txt
   ```


