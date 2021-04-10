#!/bin/bash
# plustek120.s Tool to facilitate scanning of 120 negatives on a Plustek 8100
# 

sanedir="$HOME/local_sane"
tmpdir="scan_parts"
height_mm=40
offset_mm=9
res_dpi=7200
preview_height_mm=20
preview_res_dpi=600
preview_name="pre"

filter_rows=1
img_kernel="5x5:  
     0.25,-0.25,-1.00,-0.25, 0.25 
    -0.25, 0.25, 1.00, 0.25,-0.25 
    -1.00, 1.00, 4.00, 1.00,-1.00
    -0.25, 0.25, 1.00, 0.25,-0.25
     0.25,-0.25,-1.00,-0.25, 0.25
    "
img_kernel_scale=0.2

sane_args=("--mode" "Color" "--resolution" "$res_dpi" "-y" "$height_mm" "-t" "$offset_mm")
sane_preview_args=("--mode" "Color" "--resolution" "$preview_res_dpi" "-y" "$preview_height_mm" "-t" "$offset_mm" "-o" "$tmpdir/$preview_name.tif")
sanecmd () { 
    LD_LIBRARY_PATH="$sanedir/lib" "$sanedir"/bin/scanimage "$@"
}
scancount=0;

# Filename
if [ $# -eq 0 ]
then
    fname="merge.tif"	
else
    fname=$1
fi
if [ ! -d "$tmpdir" ]
    then
        mkdir "$tmpdir"
fi

# Clean tmpdir 
rm $tmpdir/remapped_*.tif $tmpdir/part_*.tif $tmpdir/*.pto 2> /dev/null

# Scan loop
while true
do
    sanecmd "${sane_preview_args[@]}"
    read -rp "Preview command finished. (r)efresh preview, (s)can or (m)erge? [R/s/m] " response
    if [ "$response" = "r" ] 
    then
        continue
    elif [ "$response" = "s" ]
    then
        scancount=$((scancount+1))
        sanecmd "${sane_args[@]}" -o $tmpdir/part_$scancount.tif

        if [ $filter_rows == 1 ]
        then
            convert $tmpdir/part_$scancount.tif \
                -define convolve:scale=$img_kernel_scale -morphology Convolve "$img_kernel" \
                $tmpdir/part_$scancount.tif 
        fi

        read -rp "Scan $scancount finished. (c)ontinue scanning or (m)erge? [C/m] " response
        if [ "$response" = "c" ] 
        then
            continue
        elif [ "$response" = "m" ] 
        then
            echo "Merging."
            break
        fi
    elif [ "$response" = "m" ] 
    then
        echo "Merging."
        break
    fi
done 


# Merge
pto_gen $tmpdir/part_*.tif -f 1 -o $tmpdir/merge.pto # Generate PTO file
cpfind -o $tmpdir/merge.pto  --multirow $tmpdir/merge.pto # Find control points with cpfind
cpclean -o $tmpdir/merge.pto $tmpdir/merge.pto # Control point cleaning
linefind -o $tmpdir/merge.pto $tmpdir/merge.pto # Find vertical lines
autooptimiser -a -m -l -s -o $tmpdir/merge.pto $tmpdir/merge.pto # Optimize position, do photometric optimization, straighten panorama and select suitable output projection
pano_modify --canvas=AUTO --crop=AUTO -o $tmpdir/merge.pto $tmpdir/merge.pto # Calculate optimal crop and optimal size
nona -o $tmpdir/remapped_ -m TIFF_m $tmpdir/merge.pto $tmpdir/part_*.tif
enblend -o "$fname" $tmpdir/remapped_*.tif
exit 
