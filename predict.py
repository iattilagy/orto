#!/usr/bin/env python3

# load_model_sample.py
from keras.models import load_model
from keras.preprocessing import image
import matplotlib.pyplot as plt
import numpy as np
import os
import sys
from keras.preprocessing.image import ImageDataGenerator

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'


def load_image(img_path, show=False):

    img = image.load_img(img_path, color_mode = "grayscale", target_size=(128, 128))
    img_tensor = image.img_to_array(img)                    # (height, width, channels)
    img_tensor = np.expand_dims(img_tensor, axis=0)         # (1, height, width, channels), add a dimension because the model expects this shape: (batch_size, height, width, channels)

    if show:
        plt.imshow(img_tensor[0])                           
        plt.axis('off')
        plt.show()

    return img_tensor


if __name__ == "__main__":

    # load model
    model = load_model("/home/attila/src/orto/src/new15.h5")

    # image path
    img_path = sys.argv[1]    # dog
    #img_path = '/media/data/dogscats/test1/19.jpg'      # cat

    # load a single image
    new_image = load_image(img_path)

    train_datagen = ImageDataGenerator(
    rescale=1. / 255,
    featurewise_center=True,
    samplewise_center=True,
    )

    new_image = train_datagen.standardize(new_image)

    # check prediction
    y_prob = model.predict(new_image)
    print(y_prob)
    y_classes = y_prob.argmax(axis=-1)
    print(y_classes)
