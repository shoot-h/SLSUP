%function"scheck" converts an LTL formula to an automaton.

%There are five arguments below
%1.the name of the automaton to be created
%2.the name of the text in which the LTL expression is written('.txt' is not needed )
%3.the name of the text in which the transition label is written('.txt' is not needed )
%4.whether or not to make all states accepted
%5.Whether or not to self-loop the tautology after satisfying the formula

%Please put the "txtname" file in the directory under the Text folder.
%For example, if the file of'txtname'is not directly under the Text folder but under the 'A' folder in the Text folder(pass:MatlbTCT/Text/A/{text name}), set'txtname' to'A/{text name}'.

function scheck(automatonname,txtname,trantextname,allmarker,finishloop)
    string = strcat('scheck2.exe -d -s ./Text/', txtname);
    string = strcat(string,'.txt');
    [~,cmdout] = system(string); %Convert LTL expression in txtname file to automaton using scheck2
    
    %Save the output of scheck2 to an array
    begin = 1;
    pos = 1;
    for i = 1:length(cmdout)
        if(cmdout(1,i)==10||cmdout(1,i)==32)
            num(pos) = str2double(cmdout(1,begin:i));
            begin = i + 1;
            pos = pos + 1;
        end
    end
    

    if(isnan(num(1)))
        error(cmdout)    %Exit if scheck2 outputs an error
    else
        trantextname = strcat(trantextname,'.txt');
        fileID = fopen(trantextname,'r');
        alltran = fscanf(fileID,'%d',[1,Inf]);
        fclose(fileID);
        Q = num(1); %The number of states is first in the array
        pos = 3;
        marker = 1;
        deltanum = 1;
        tran = 0;
        for i = 1:num(1) %Loop by the number of states
            exit = num(pos); %Set the current state as the exit state
            pos = pos + 1;
            if(allmarker == true) %Add the current array to the array in the accepting state when all states are in the accepting state
                Qm(marker) = num(pos - 1);
                marker = marker + 1;
            elseif(num(pos) == 0) %Add the current array to the array in the accepting state when it is output in the accepted state
                Qm(marker) = num(pos - 1);
                marker = marker + 1;
            end
            pos = pos + 1;
            while num(pos) ~= -1
                entrance = num(pos); %Set as the entrance state
                pos = pos + 1;
                if(num(pos) == -5) %For tautology, add all transition labels in'trantxtname'to the transition information
                    if(exit ~= entrance || finishloop == true) %If the tautology self-loop after satisfying the formula is invalid, do not describe
                        for j = 1:numel(alltran)
                            delta(deltanum,1) = exit;
                            delta(deltanum,2) = alltran(j);
                            delta(deltanum,3) = entrance;
                            deltanum = deltanum + 1;
                        end
                    end
                else
                    while num(pos) ~= -1
                        ok = 0;
                        next = 0;
                        not = 1;
                        while num(pos + next) ~= -4 %Count the number of -2 up to the -4 delimiter
                            if(num(pos + next) == -2)
                                ok = ok +1;
                                tran = num(pos + next + 1);
                            else
                                nottran(not) = num(pos + next + 1);
                                not = not + 1;
                            end
                            next = next + 2;
                        end
                        switch (ok)
                            case 0 %When -2 is 0, all the events that appeared are denied, so the event that did not appear in'trantxtname'is used as the transition label
                                for j = 1:numel(alltran)
                                    if(isempty(find(nottran==alltran(j), 1)))
                                        delta(deltanum,1) = exit;
                                        delta(deltanum,2) = alltran(j);
                                        delta(deltanum,3) = entrance;
                                        deltanum = deltanum + 1;
                                    end
                                end
                            case 1 %When -2 is 1, the only affirmed event is used as the transition label.
                                delta(deltanum,1) = exit;
                                delta(deltanum,2) = tran;
                                delta(deltanum,3) = entrance;
                                deltanum = deltanum + 1;
                        end %Ignore when -2 is 2 or more
                        pos = pos + next + 1;
                    end
                end
                pos = pos + 1;
            end
            pos = pos +1;
        end

        create('MAKE', Q, delta, Qm); % create automaton
        trim(automatonname,'MAKE') %Remove the extra part of the automaton
    end
end