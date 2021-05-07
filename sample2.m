clear all; close all; fclose all;
setup;

addpath('Text\storehouse');
init('robot');
scheck('MOVE1','storehouse/move1','rob1',false,false);
figure(1)
displaydes('MOVE1')

scheck('MOVE2','storehouse/move2','rob2',false,false);
figure(2)
displaydes('MOVE2')

sync('PLANT', 'MOVE1', 'MOVE2');
figure(3)
displaydes('PLANT') % display automaton

scheck('SPEC','storehouse/storespec','roball',false,true);
figure(4)
displaydes('SPEC')

supcon('SUP', 'PLANT', 'SPEC');
figure(5)
displaydes('SUP') % display automaton