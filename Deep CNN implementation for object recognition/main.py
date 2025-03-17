# (13)
# train the model for 20 epochs with a learning rate of 1e-4 and batch size of 32.
import torch.utils.data
from torch import optim

from Constants import *
from HelperFunctions import save_checkpoint
from YOLOv3 import *
from YOLOLoss import *
from Dataset import *
import albumentations as A
from albumentations.pytorch import ToTensorV2
from TrainFunction import *
import cv2


if __name__ == "__main__":
    # Create the model YOLOv3
    model = YOLOv3().to(device)
    # Define optimizer
    optimizer = optim.Adam(model.parameters(), lr=leanring_rate)
    # define loss function
    loss_fn = YOLOLoss()
    # define scaler for mixed precision training
    scaler = torch.cuda.amp.GradScaler()

    # define the train dataset
    # Transform for training
    train_transform = A.Compose(
        [
            # Rescale an image so that maximum side is equal to image_size
            A.LongestMaxSize(max_size=image_size),
            # Pad remaining areas with zeros
            A.PadIfNeeded(
                min_height=image_size, min_width=image_size, border_mode=cv2.BORDER_CONSTANT
            ),
            # Random color jittering
            A.ColorJitter(
                brightness=0.5, contrast=0.5,
                saturation=0.5, hue=0.5, p=0.5
            ),
            # Flip the image horizontally
            A.HorizontalFlip(p=0.5),
            # Normalize the image
            A.Normalize(
                mean=[0, 0, 0], std=[1, 1, 1], max_pixel_value=255
            ),
            # Convert the image to PyTorch tensor
            ToTensorV2()
        ],
        # Augmentation for bounding boxes
        bbox_params=A.BboxParams(
            format="yolo",
            min_visibility=0.4,
            label_fields=[]
        )
    )
    train_dataset = Dataset(csv_file="/kaggle/input/pascal-voc-dataset-used-in-yolov3-video/PASCAL_VOC/train.csv",
                            image_dir="/kaggle/input/pascal-voc-dataset-used-in-yolov3-video/PASCAL_VOC/images",
                            label_dir="/kaggle/input/pascal-voc-dataset-used-in-yolov3-video/PASCAL_VOC/labels",
                            anchors=ANCHORS,
                            transform=train_transform)

    # define the train data loader
    train_loader = torch.utils.data.DataLoader(train_dataset,
                                               batch_size=batch_size,
                                               num_workers=2,
                                               shuffle=True,
                                               pin_memory=True)
    # scaling anchors
    scaled_anchors = (torch.tensor(ANCHORS) * torch.tensor(s).unsqueeze(1).unsqueeze(1).repeat(1, 3, 2)).to(device)

    # train model
    for e in range(1, epochs + 1):
        print("Epoch: ", e)
        train_loop(train_loader, model, optimizer, loss_fn, scaler, scaled_anchors)
        # save model
        if save_model:
            save_checkpoint(model, optimizer, filename=f"checkpoint.pth.tar")
