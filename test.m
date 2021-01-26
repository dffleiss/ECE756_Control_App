map = imread('map.png');
map = rgb2gray(map);
map_norm = uint8(100*mat2gray(map));
%imshow(normalizedImage)
imshow(map);
hold on;
pos = [0,0,0];
x = pos(1) + 0.06*cos(pos(3));
y = pos(2) + 0.06*sin(pos(3));
% xScale = 1979.37;
% yScale = -1925.58;
xScale = 349.2718;
yScale = -339.591;
topYReal = 2.936;
leftXReal = -1.9;
% topYPixel = 943;
% leftXPixel = 972;
topYPixel = 168;
leftXPixel = 166;
%pixel coords
x = round(leftXPixel + (xScale * (x-leftXReal)));
y = round(topYPixel + (yScale * (y-topYReal)));
lcy = floor(y-6*cos(pos(3)));
lcx = floor(x-6*sin(pos(3)));
rcy = floor(y+6*cos(pos(3)));
rcx = floor(x+6*sin(pos(3)));
% r1cy = floor(y+6*cos(pos(3)));
% r2cx = floor(x+6*sin(pos(3)));
r1cy = floor(rcy-8*sin(pos(3)));
r2cx = floor(rcx+8*cos(pos(3)));
%plot(x,y,'r+','markersize',30);
%plot(x1,y1,'r+');
plot(x,y,'b*','markersize',15)
plot(rcx,rcy,'g*','markersize',15)
plot(lcx,lcy,'r*','markersize',15)
plot(r2cx,r1cy,'y*','markersize',15)

% average(map_norm,rcx,rcy);

