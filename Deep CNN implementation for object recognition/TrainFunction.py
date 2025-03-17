# (12)
# train loop function to train the model
from tqdm import tqdm
from Constants import *


def train_loop(loader, model, optimizer, loss_fn, scaler, scaled_anchors):
    # creating progress bar for visual purposes
    progress_bar = tqdm(loader, leave=True)

    # init a list to store losses
    losses = []

    # iterating over training data
    for _, (x, y) in enumerate(progress_bar):
        x = x.to(device)
        y0, y1, y2 = (y[0].to(device), y[1].to(device), y[2].to(device))

        with torch.cuda.amp.autocast():
            # getting the model predictions
            outputs = model(x)
            # Compute loss at each scale
            loss = (loss_fn(outputs[0], y0, scaled_anchors[0]) +
                    loss_fn(outputs[1], y1, scaled_anchors[1]) +
                    loss_fn(outputs[2], y2, scaled_anchors[2]))

        # add loss to list
        losses.append(loss.item())

        # reset gradients
        optimizer.zero_grad()

        # backpropagate the loss
        scaler.scale(loss).backward()

        # optimization step
        scaler.step(optimizer)

        # update the scaler for next iteration
        scaler.update()
        # update progress bar with loss
        mean_loss = sum(losses) / len(losses)
        progress_bar.set_postfix(loss=mean_loss)
