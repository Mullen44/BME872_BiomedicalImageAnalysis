# BME872_BiomedicalImageAnalysis

This repository contains the three labs required of a fourth year image analysis course from the department of Biomedical Engineering at Ryerson University.

Lab 1: Medical Image Management - This lab required students to familiarize themselves with the data format of medical images, learn how to read and write images from/to a database and do some simple arithmetic on them and create a histogram without the aid of built in functions.

Lab 2: Enhancement of Medical Images - This lab built off of lab 1 and utilized the histograms of images to apply transformations that enhanced the image quality. The goal was to improve the contrast of the images to aid in their intepretation.  Contrast stretching, piecewise transformations, contrast highlighting, squaring and histogram equalization were the transformations applied and their results analyzed and intepreted both quantitatively and qualitatively.

Lab 3: Edge and Vessel Detection:  Retinal images were inputted through a vessel segmentation pipeline with the goal being identifying all of the blood vessels located in the image. The pipeline consisted of filters to smooth the image, vertical & horizontal gradient, gradient magnitude, non maxima suppression, thresholding, connecting of nearest neighbours and segmentation.
