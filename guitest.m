clc;clear all;close all;

track_graphics = SpriteKit.Game.instance('Title', 'EV3 Track Animation', 'Size', [748 561]);
track_background = SpriteKit.Background('map.png');
track_background.Scale = 748 / 9600;
addBorders(track_graphics);

EV1_sprite = SpriteKit.Sprite('on');
EV1_sprite.initState('on', 'EV1.png', true);
EV1_sprite.Scale = 1;
EV1_sprite.State = 'on';
EV1_sprite.Location = [100 100];

track_graphics.play(@trackUpdate)

function trackUpdate()
    %
end