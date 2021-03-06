#!/usr/bin/env sh

# command 
# 	 cd ../../../caffe/ && make -j8 && cd - && sh demo.sh

# ########################################
gpu=0					# set params
p_dxy=5
ratio=0
sho_id=6
hip_id=10
sho_id2=6
hip_id2=10
part_num=14
has_torso=1
draw_text=0
disp_info=1
g_width=100
g_height=100
min_size=240
max_size=256
batch_size=1	# set params
data_layer_name="o_data"
aux_info_layer_name="aux_info"
gt_coords_layer_name="gt_coords"
need_inds_string="0,1,2,3,4,5,6,7,8"

# ########################################

im_dire="/home/ddk/download/pose.test.nature.scene/"
pt_file="${im_dire}pt_props_m.txt"

out_dire="${im_dire}viz2_m/"
mkdir -p $out_dire

model_dire="/home/ddk/dongdk/pt-fast-rcnn/caffe/examples/pose_demo"

skel_path="${model_dire}/skel_paths/flic.txt"

caffemodel="${model_dire}/flic/flic_fus_spa.caffemodel"

def="${model_dire}/filc/flic_fus_spadeploy.pt"

log_path="${model_dire}/filc/flic_fus_spa.log"

# ########################################

caffe_dire="/home/ddk/dongdk/pose-caffe/"

caffe_bin="${caffe_dire}caffe/build/tools/static_pose_v2"

# ########################################
$caffe_bin static_pose_v2 \
		--gpu=$gpu \
		--def=$def \
		--p_dxy=$p_dxy \
		--ratio=$ratio \
		--sho_id=$sho_id \
		--hip_id=$hip_id \
		--sho_id2=$sho_id2 \
		--hip_id2=$hip_id2 \
		--g_width=$g_width \
		--pt_file=$pt_file \
		--g_height=$g_height \
		--min_size=$min_size \
		--max_size=$max_size \
		--part_num=$part_num \
		--out_dire=$out_dire \
		--skel_path $skel_path \
		--draw_text=$draw_text \
		--has_torso=$has_torso \
		--disp_info=$disp_info \
		--batch_size=$batch_size \
		--caffemodel=$caffemodel \
		--data_layer_name $data_layer_name \
		--need_inds_string $need_inds_string \
		--aux_info_layer_name $aux_info_layer_name \
		--gt_coords_layer_name $gt_coords_layer_name \
		2>&1 | tee -a $log_path
