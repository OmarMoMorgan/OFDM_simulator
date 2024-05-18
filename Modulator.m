function [TX_signal] = Modulator(Symbols)
% modulation part of the OFDM

% standard paramters
data_subcarriers = 48;
null_subcarriers = 12;
pilot_subcarriers = 4;
total_subcarriers = data_subcarriers + null_subcarriers + pilot_subcarriers;
CycPref = 16;

% Divide the symbols into 48 groups
SymParallel = reshape(Symbols,data_subcarriers,[]);

% Add Pilots & Nulls
SymParallel = insert_zeros(SymParallel,1,0,1);      %Nulls
SymParallel = insert_zeros(SymParallel,8,1,1);      %Pilots
SymParallel = insert_zeros(SymParallel,22,1,1);     %Pilots
SymParallel = insert_zeros(SymParallel,28,0,11);    %Null
SymParallel = insert_zeros(SymParallel,44,1,1);     %Pilots
SymParallel = insert_zeros(SymParallel,58,-1,1);    %Pilots

% Moving the subcarriers to the ifft 
X_parallel = ifft(SymParallel,total_subcarriers); 
% Cyclic Prefix
X_cyclic = [X_parallel(end-CycPref+1:end,:); X_parallel];
TX_signal = X_cyclic(:);     %transmitted Signal X

end