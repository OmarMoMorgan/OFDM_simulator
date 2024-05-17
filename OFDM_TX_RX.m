%Parameters Initialization

clear;
clc;
n = 2^14; %number of transmitted symbols
n=4800;
SC = 64; %number of subcarriers
CycPref = 16; %cyclic prefix length
M = 16; %modulation scheme number
h = [1+1j*0.53 1.3-1j*.56 1.21j*0.89 2.5+1j*-.5];   %Channel 
h = h/norm(h);
subchannelNum = 5;    %testing specific subchannel 

%% Transmitter %% 

%symbols generation%
data = zeros(sqrt(M),sqrt(M));   %MxM Matrix
for i = 1 : sqrt(M)
    data(i,:) = -sqrt(M)+1:2:sqrt(M);  %MxM Matrix of the combinations numbers of the constellation points 
end
symbols = reshape(data+1j*data',[1,M]); %% 1X(MM) Total combinations symbols of the constellation points.

TxSymbols = symbols(randi(M,[1,n])); %% The trasmitted symbols 

% Serial to Parallel % Hint: Reshape 

SymParallel = reshape(TxSymbols,SC,[]);


%% Adding Cyclic Prefix 

X_parallel = ifft(SymParallel,SC); %% Moving the subcarriers to the ifft 

X_cyclic = [X_parallel(end+1-CycPref:end,:); X_parallel];


X_Serial =  X_cyclic(:);                        %transmitted Signal X
%% Reciever %%  Without the Channel 

%Remove the CP 
%X_Recieved =  X_Serial(1:end-CycPref*SC);
X_Recieved = reshape(X_Serial,SC+CycPref,[]);

X_Recieved = X_Recieved(CycPref+1:end,:);

y_parrallel = fft(X_Recieved);


%y is the recieved signal
y = y_parrallel(:);

figure 
scatter(real(TxSymbols),imag(TxSymbols),'x');
hold on;
scatter(real(y),imag(y),'+');
legend('Transmitted symbols','recieved symbols');
title("the system without a channel");

%% Reciever %%  After the Channel 

ychan = conv(h,X_Serial);
ychan = ychan(1:n+CycPref * n/SC);
 % Note need to adjust the dimensions after conv
X_Recieved = reshape(ychan,SC+CycPref,[]);

X_Recieved = X_Recieved(CycPref+1:end,:);

y_parrallel = fft(X_Recieved);


%y is the recieved signal
y = y_parrallel(:);
%Remove the CP 
%X_Recieved =  

y_parrallel = fft(X_Recieved);


%y is the recieved signal

figure
scatter(real(TxSymbols),imag(TxSymbols),'x');
hold on;
scatter(real(y),imag(y),'o');
legend('Transmitted symbols','recieved symbols');
title("the system with a channel");

%% subchannel
subChan = y_parrallel(subchannelNum,:);

figure
scatter(real(TxSymbols),imag(TxSymbols),'x');
hold on;
scatter(real(subChan),imag(subChan));
hold off;
legend('Transmitted symbols','subchannel');
title("the subchannel in the existance of a complex channel");

