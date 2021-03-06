%Creating the configuration file
%Import Map, Change to Grayscale, and normalize to 0-255
RGB = imread('map.png');%Import the image
Map = im2gray(RGB);%Convert image from RGB to Grayscale
Map = im2double(Map).*255;%Normalize image to 0-1 scale, then multiply by 255 to get 0-255 scale
