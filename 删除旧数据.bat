del .\denoised_audio\*.* /s/q
del .\custom_character_voice\*.* /s/q
FOR /D %%p IN ("separated\*") DO rmdir /s /q "%%p"
FOR /D %%p IN ("segmented_character_voice\*") DO rmdir /s /q "%%p"
del final_annotation_train.txt
del final_annotation_val.txt