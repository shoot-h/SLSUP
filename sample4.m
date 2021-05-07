clear all; close all; fclose all;
setup;

addpath('Text\smallfactory');
init('factory');
scheck('MACHINE1','smallfactory/machine1','machinetran1',false,false);
figure(1)
displaydes('MACHINE1')

scheck('MACHINE2','smallfactory/machine2','machinetran2',false,false);
figure(2)
displaydes('MACHINE2')

sync('PLANT', 'MACHINE1', 'MACHINE2');
figure(3)
displaydes('PLANT') % display automaton

scheck('E','smallfactory/factoryspec','factorytran',false,true);


allevents('ALL', 'PLANT');
sync('SPEC', 'E', 'ALL');
figure(4)
displaydes('SPEC')

supcon('SUP', 'PLANT', 'SPEC');
figure(5)
displaydes('SUP') % display automaton