#!/bin/sh

root="/home/ddk/dongdk/pt-fast-rcnn"
cd $root

log_file=logs/person.torso_VGG16_person.only.21_demo.log
rm $log_file

is_video=0	# 0: images, !=0: video

t_cls="person"	# person and torso will share this `t_cls`

# im_path="/home/ddk/download/pose.test.nature.scene/images/"


# im_path="/home/ddk/download/pt.pose/tianshui/images/"
im_path="/home/ddk/download/pt.pose/huanglili/images/"

def="${root}/pts/person.torso/VGG16/per.tor.test/only.21/faster_rcnn_test.pt"

cls_filepath="${root}/pts/person.torso/pascal_voc_classes_names.filepath"

cfg_file="${root}/pts/person.torso/VGG16/per.tor.test/only.21/test.yml"

p_caffemodel="${root}/output/person.torso/VGG16/person.only.21/VGG16_faster_rcnn_final.caffemodel"
t_caffemodel="${root}/output/person.torso/VGG16/torso.only.21/VGG16_faster_rcnn_final.caffemodel"

# p_caffemodel="${root}/output/person.torso/VGG16/kinect2.person.21/VGG16_faster_rcnn_final.caffemodel"
# t_caffemodel="${root}/output/person.torso/VGG16/kinect2.torso.21/VGG16_faster_rcnn_final.caffemodel"

# p_caffemodel="${root}/output/person.torso/VGG16/bbc.person.21/VGG16_faster_rcnn_final.caffemodel"
# t_caffemodel="${root}/output/person.torso/VGG16/bbc.torso.21.2/VGG16_faster_rcnn_final.caffemodel"

s_time=3

# 0: independent, 1: first person and then torso
choice=1

# ####################################################################################
# execute -> show
if [ ! -n "$1" ] ;then
	# out_dire="/home/ddk/download/pose.test.nature.scene/viz/"

	# out_dire="/home/ddk/download/pt.pose/tianshui/viz/"
	out_dire="/home/ddk/download/pt.pose/huanglili/viz/"
	mkdir -p $out_dire
	echo "show images"
	sleep $s_time
	$root/tools/person_torso_demo_v2.py \
			--p_def $def \
			--t_def $def \
			--t_cls $t_cls \
			--choice $choice \
			--im_path $im_path \
			--is_video $is_video \
			--cfg_file $cfg_file \
			--out_dire  $out_dire \
			--p_caffemodel $p_caffemodel \
			--t_caffemodel $t_caffemodel \
			--cls_filepath $cls_filepath \
			2>&1 | tee -a $log_file
# ####################################################################################
# execute -> write into file
else
	out_file="pt_props.txt"	# write the detected results (bboxes) into file if given

	# out_dire="/home/ddk/download/pose.test.nature.scene/"

	# out_dire="/home/ddk/download/pt.pose/tianshui/"
	out_dire="/home/ddk/download/pt.pose/huanglili/"
	mkdir -p $out_dire
	echo "write results into file"
	sleep $s_time
	$root/tools/person_torso_demo_v2.py \
			--p_def $def \
			--t_def $def \
			--t_cls $t_cls \
			--choice $choice \
			--im_path $im_path \
			--out_file $out_file \
			--is_video $is_video \
			--cfg_file $cfg_file \
			--out_dire  $out_dire \
			--p_caffemodel $p_caffemodel \
			--t_caffemodel $t_caffemodel \
			--cls_filepath $cls_filepath \
			2>&1 | tee -a $log_file
fi