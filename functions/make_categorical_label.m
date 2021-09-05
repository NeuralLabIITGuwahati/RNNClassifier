%% Syntax
%% categorical_labels = make_categorical_label(triallabels)
%% Description
%%the function converts the numrical labels to corresponding categorical
%%label
%%it inputs the numerical label as a 1D vector and outputs the categorical
%%variable as a 1D vector





function categorical_labels = make_categorical_label(triallabels)
 
    for a = 1:length(triallabels)
        if triallabels(a)==0
            categorical_labels(a)=categorical("low"); % making categorical labels
        elseif triallabels(a)==1
            categorical_labels(a)=categorical("medium"); % making categorical labels
        elseif triallabels(a) == 2
            categorical_labels(a)=categorical("high"); % making categorical labels
        end
    end
    
end
