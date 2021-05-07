clear all; close all; fclose all;
setup;
addpath('Text\coffeemachine');
init('Coffee');
scheck('UNTIL','coffeemachine/until1','tran',true,true);



Q = 4; % number of states
       % the initial state q0 is always labeled "0"
Qm = [0,3]; % marker state set
delta = [0,11,1; % transition triples (exit state, event, enter state)
          1,10,0;
          1,12,2;
          2,13,0;
          0,15,3];
create('PLANT', Q, delta, Qm); % create automaton

figure(1)
displaydes('PLANT') % display automaton
allevents('ALL', 'PLANT');
sync('SPEC', 'UNTIL', 'ALL');
figure(2)
displaydes('SPEC') % display automaton
supcon('SUP', 'PLANT', 'SPEC');
figure(3)
displaydes('SUP') % display automaton