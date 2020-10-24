#!/bin/bash
{
DATE="$(date +"%F_%H-%M-%S")"
TMP_FOLDER=".img_folder_to_cbz_tmp_$DATE-$RANDOM"

printf "\n\n$DATE:\n"

folders=()
#for folder in *;do
for folder in "${@}";do
    #printf "$folder\n"
    folders+=("$folder")
done
## Sorting folders in "version" order, so e.g. '36','36.1','37'
#IFS=$'\n'
IFS=$'\n' folders=($(sort -fV <<<"${folders[*]}"))
unset IFS

mkdir "$TMP_FOLDER"

files=()
for folder in "${folders[@]}";do
	printf "$folder\n"
    for file in "$folder"/*;do
        files+=("$file")
    done
done

counter=0
for f in "${files[@]}";do
	padded_number="$(printf "%04d" $counter)"
	basename="$(basename -- "$f")"
	extension="${basename##*.}"
	if [ "$extension" == "webp" ];then
		convert "$f" "$TMP_FOLDER/$padded_number.jpg"
	else
		cp "$f" "$TMP_FOLDER/$padded_number.$extension"
	fi
	counter=$(($counter+1))
done

## Check for ".bin" files (failed download), because HakuNeko or something fucked up, not sure
warning=""
find "$TMP_FOLDER" -name '*.bin'
if [ ! -z "$(find "$TMP_FOLDER" -name '*.bin')" ];then
	warning="-BIN_FILES_FOUND"
fi

zip -j AAA_if2cbz_generated_$DATE$warning.cbz $TMP_FOLDER/*
rm -r "$TMP_FOLDER"
} 2>&1 >> img_folder_to_cbz_log.txt
