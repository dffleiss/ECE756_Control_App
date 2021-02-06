%Creating the configuration file
    %Import Map, Change to Grayscale, and normalize to 0-100
        RGB = imread('map.png');%Import the image
        Map = im2gray(RGB);%Convert image from RGB to Grayscale
        Map = im2double(Map).*100;%Normalize image to 0-1 scale, then multiply by 100 to get 0-100 scale
        