# Taking a sample image and testing the model
import matplotlib.pyplot as plt
import torch
from albumentations.pytorch import ToTensorV2
from torch import optim

from Constants import *
from YOLOLoss import *
from YOLOv3 import *
from HelperFunctions import *
from Dataset import *
import albumentations as A
import cv2

"""--------------------------------"""

font = cv2.FONT_HERSHEY_COMPLEX


def final_prediction(image, prediction_box, bounding_box, confidence, class_labels, width_ratio, height_ratio,
                     classes_names):
    for j in prediction_box.flatten():
        x, y, w, h = bounding_box[j]
        x = int(x * width_ratio)
        y = int(y * height_ratio)
        w = int(w * width_ratio)
        h = int(h * height_ratio)

        label = str(classes_names[class_labels[j]])
        conf_ = str(round(confidence[j], 2))
        cv2.rectangle(image, (x, y), (x + w, y + h), (0, 0, 255), 2)
        cv2.putText(image, label + ' ' + conf_, (x, y - 2), font, .2, (0, 255, 0), 1)


def bounding_box_prediction(output_data, threshold):
    bounding_box = []
    class_labels = []
    confidence_score = []
    for i in output_data:
        for j in i:
            high_label = j[5:]
            classes_ids = np.argmax(high_label)
            confidence = high_label[classes_ids]

            if confidence > threshold:
                w, h = int(j[2] * image_size), int(j[3] * image_size)
                x, y = int(j[0] * image_size - w / 2), int(j[1] * image_size - h / 2)
                bounding_box.append([x, y, w, h])
                class_labels.append(classes_ids)
                confidence_score.append(confidence)

    prediction_boxes = cv2.dnn.NMSBoxes(bounding_box, confidence_score, threshold, .6)
    return prediction_boxes, bounding_box, confidence_score, class_labels


"""--------------------------------"""
if __name__ == "__main__":
    # Transform for testing
    test_transform = A.Compose(
        [
            # Rescale an image so that maximum side is equal to image_size
            A.LongestMaxSize(max_size=image_size),
            # Pad remaining areas with zeros
            A.PadIfNeeded(
                min_height=image_size, min_width=image_size, border_mode=cv2.BORDER_CONSTANT
            ),
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
    # Taking a sample image and testing the model

    # Setting the load_model to True
    load_model = True

    # Defining the model, optimizer, loss function and scaler
    model = YOLOv3().to(device)
    optimizer = optim.Adam(model.parameters(), lr=leanring_rate)
    loss_fn = YOLOLoss()
    scaler = torch.cuda.amp.GradScaler(enabled=False)

    # Loading the checkpoint
    if load_model:
        load_checkpoint(checkpoint_file, model, optimizer, leanring_rate)

        # Defining the test dataset and data loader
    test_dataset = Dataset(
        csv_file="test.csv",
        image_dir="images/",
        label_dir="labels/",
        anchors=ANCHORS,
        transform=test_transform
    )
    test_loader = torch.utils.data.DataLoader(
        test_dataset,
        batch_size=1,
        num_workers=2,
        shuffle=True,
    )

    # Getting a sample image from the test data loader
    x, y = next(iter(test_loader))
    x = x.to(device)


    model.eval()
    with torch.no_grad():
        # Getting the model predictions
        output = model(x)
        # Getting the bounding boxes from the predictions
        bboxes = [[] for _ in range(x.shape[0])]
        anchors = (
                torch.tensor(ANCHORS)
                * torch.tensor(s).unsqueeze(1).unsqueeze(1).repeat(1, 3, 2)
        ).to(device)

        # Getting bounding boxes for each scale
        for i in range(3):
            batch_size, A, S, _, _ = output[i].shape
            anchor = anchors[i]
            boxes_scale_i = convert_cells_to_bboxes(
                output[i], anchor, s=S, is_predictions=True
            )
            for idx, (box) in enumerate(boxes_scale_i):
                bboxes[idx] += box
    #model.train()
    a=[b[1] for b in bboxes[0]]
    max_confid=np.max(a)
    cls=class_labels[int(bboxes[0][np.argmax(a)][0])]
    print(f"class: {cls}-->{max_confid}",)


    # Plotting the image with bounding boxes for each image in the batch
    for i in range(batch_size):
        # Applying non-max suppression to remove overlapping bounding boxes
        nms_boxes = nms(bboxes[i], iou_threshold=0.5, threshold=max_confid-0.1)
        # Plotting the image with bounding boxes
        plot_image(x[i].permute(1, 2, 0).detach().cpu(), nms_boxes)



