# (9)
# Defining scale prediction class
from torch import nn


# Defining scale prediction class
class ScalePrediction(nn.Module):
    def __init__(self, in_channels, num_classes):
        super().__init__()
        # Defining the layers in the network
        self.pred = nn.Sequential(
            nn.Conv2d(in_channels, 2 * in_channels, kernel_size=3, padding=1),
            nn.BatchNorm2d(2 * in_channels),
            nn.LeakyReLU(0.1),
            nn.Conv2d(2 * in_channels, (num_classes + 5) * 3, kernel_size=1),
        )
        self.num_classes = num_classes

    # Defining the forward pass and reshaping the output to the desired output
    # format: (batch_size, 3, grid_size, grid_size, num_classes + 5)
    def forward(self, x):
        output = self.pred(x)
        output = output.view(x.size(0), 3, self.num_classes + 5, x.size(2), x.size(3))
        output = output.permute(0, 1, 3, 4, 2)
        return output
