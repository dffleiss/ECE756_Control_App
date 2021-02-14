function track = gen_track

radius = 9.5 * 0.0254;
w = 1.86 - -1.55;
h = 2.567 - 0.365;
corner = 57.75 * 0.0254;
dx = 0.01;

line_bx = w-radius:-dx:radius;
line_b = zeros(length(line_bx),4);
line_b(:,1) = line_bx;
line_b(:,3) = pi;

turn_blh = pi:-dx/radius:pi/2;
turn_bl = zeros(length(turn_blh),4);
turn_bl(:,1) = radius*(1+cos(turn_blh+pi/2));
turn_bl(:,2) = radius*(1+sin(turn_blh+pi/2));
turn_bl(:,3) = turn_blh;
turn_bl(:,4) = -1/radius;

line_ly = radius:dx:h-corner;
line_l = zeros(length(line_ly),4);
line_l(:,2) = line_ly;
line_l(:,3) = pi/2;

turn_lch = pi/2:-dx/radius:pi/4;
turn_lc = zeros(length(turn_lch),4);
turn_lc(:,1) = radius*(1+cos(turn_lch+pi/2));
turn_lc(:,2) = h-corner + radius*sin(turn_lch+pi/2);
turn_lc(:,3) = turn_lch;
turn_lc(:,4) = -1/radius;

line_cd = 0:dx:(corner-radius)*sqrt(2);
line_c = zeros(length(line_cd),4);
line_c(:,1) = radius+(line_cd-radius)/sqrt(2);
line_c(:,2) = h-corner+(radius+line_cd)/sqrt(2);
line_c(:,3) = pi/4;

turn_cth = pi/4:-dx/radius:0;
turn_ct = zeros(length(turn_cth),4);
turn_ct(:,1) = corner+radius*cos(turn_cth+pi/2);
turn_ct(:,2) = h+radius*(sin(turn_cth+pi/2)-1);
turn_ct(:,3) = turn_cth;
turn_ct(:,4) = -1/radius;

line_tx = corner:dx:w-radius;
line_t = zeros(length(line_tx),4);
line_t(:,1) = line_tx;
line_t(:,2) = h;

turn_trh = 0:-dx/radius:-pi/2;
turn_tr = zeros(length(turn_trh),4);
turn_tr(:,1) = w+radius*(cos(turn_trh+pi/2)-1);
turn_tr(:,2) = h+radius*(sin(turn_trh+pi/2)-1);
turn_tr(:,3) = turn_trh;
turn_tr(:,4) = -1/radius;

line_ry = h-radius:-dx:radius;
line_r = zeros(length(line_ry),4);
line_r(:,1) = w;
line_r(:,2) = line_ry;
line_r(:,3) = -pi/2;

turn_rbh = -pi/2:-dx/radius:-pi;
turn_rb = zeros(length(turn_rbh),4);
turn_rb(:,1) = w+radius*(cos(turn_rbh+pi/2)-1);
turn_rb(:,2) = radius*(1+sin(turn_rbh+pi/2));
turn_rb(:,3) = turn_rbh;
turn_rb(:,4) = -1/radius;

track = [line_b; turn_bl; line_l; turn_lc; line_c; turn_ct; line_t; turn_tr; line_r; turn_rb];
track(:,1) = track(:,1) - 1.55;
track(:,2) = track(:,2) + 0.365;
close all;
%close all, plot(track(:,1),track(:,2));
%figure, plot(track(:,3));