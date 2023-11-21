# The new config inherits a base config to highlight the necessary modification
import os


_base_ = f"/mmdetection/configs/faster_rcnn/faster-rcnn_r50_fpn_2x_coco.py"

train_cfg = dict(type='EpochBasedTrainLoop', max_epochs=2, val_interval=1)

use_cpu = False
device_ids = range(1)


# We also need to change the num_classes in head to match the dataset's annotation
model = dict(roi_head=dict(
    bbox_head=dict(num_classes=1))
)

# Modify dataset related settings
data_root = 'data/support_detection/'
metainfo = {
    'classes': ('support', ),
    'palette': [
        (220, 20, 60),
    ]
}
train_dataloader = dict(
    batch_size=2,
    dataset=dict(
        data_root=data_root,
        metainfo=metainfo,
        ann_file='train/train.json',
        data_prefix=dict(img='train/images/')))
val_dataloader = dict(
    dataset=dict(
        data_root=data_root,
        metainfo=metainfo,
        ann_file='test/test.json',
        data_prefix=dict(img='test/images/')))
test_dataloader = val_dataloader

# Modify metric related settings
val_evaluator = dict(ann_file=data_root + 'test/test.json')
test_evaluator = val_evaluator
