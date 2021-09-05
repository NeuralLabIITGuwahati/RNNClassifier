%% Syntax
%% cell_eeg = make_cellarray_eeg(eeg)
%% Descrption
%%this function inputs a 3D matrix of dimensions, CHANNELxTIMExTRIALS and
%%outputs a cell array which contains the CHANNELxTIME matrix in each of
%%its indices. The indices correspond to the trials


function cell_eeg = make_cellarray_eeg(eeg)
    n_trials = size(eeg,3);
    for a = 1:n_trials
        cell_eeg{a} = eeg(:,:,a);
    end        
end
