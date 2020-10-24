#!/bin/bash
{
for f in "${@}";do
	DATE="$(date +"%F_%H-%M-%S")"
	printf "$DATE: $f:\n"
	TMP_FOLDER=".cbz_half_scale_$f-$DATE-$RANDOM"
	mkdir "$TMP_FOLDER"
	cd "$TMP_FOLDER"
	7z e ../"$f"
	for i in *;do
		#printf "$i\n"
		mogrify -resize 50% "$i"
	done
	mv ../"$f" ../"$f.original"
	basename="$(basename -- "$f")"
	#extension="${basename##*.}"
	zip ../"$basename.cbz" *
	cd ..
	rm -r "$TMP_FOLDER"

	printf "--------------------------------\n\n\n\n"
done
} 2>&1 >> cbz_half_scale_log.txt
