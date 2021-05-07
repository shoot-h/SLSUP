clear all; close all; fclose all;

setup;

addpath('Text\passingtrain');
init('train');
scheck('TRAIN1','passingtrain/train1','traintran1',false,false);
figure(1)
displaydes('TRAIN1')

scheck('TRAIN2','passingtrain/train2','traintran2',false,false);
figure(2)
displaydes('TRAIN2')

sync('PLANT', 'TRAIN1', 'TRAIN2');
figure(3)
displaydes('PLANT') % display automaton

scheck('E','passingtrain/signalspec','signaltran',false,true);


allevents('ALL', 'PLANT');
sync('SPEC', 'E', 'ALL');
figure(4)
displaydes('SPEC')

supcon('SUP', 'PLANT', 'SPEC');
figure(5)
displaydes('SUP') % display automaton