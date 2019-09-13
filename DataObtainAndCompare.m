%% Obtención de datos y visualización de datos
% A través de este script, se busca separar los datos que corresponden a
% fraude de los datos que no corresponden a fraude y visualizarlos para
% identificar características clave de cada clase.
clear all
close all
clc
%% Carga de datos de entrenamiento
tic
fprintf('Cargando Datos\n')
TrainDataFile = 'Data/train_transaction.csv';
TrainData = readtable(TrainDataFile);
%% Procesamiento de los datos
% Se realiza la separación deseada
fprintf('Procesando Datos\n')
IsFraud = table2array(TrainData(:,2));

% Se determina si es fraude
TransactionNotFraud = TrainData(IsFraud == 0,:);% No es fraude
TransactionIsFraud = TrainData(IsFraud == 1,:); % Si es fraude


% Se separan los datos para permitir mejor manipulación de estos

% TransactionID
TransactionIDNoFraud = table2array(TransactionNotFraud(:,1));
TransactionIDIsFraud = table2array(TransactionIsFraud(:,1));


% TransactionDT
TransactionDTNoFraud = table2array(TransactionNotFraud(:,3));
TransactionDTIsFraud = table2array(TransactionIsFraud(:,3));
% TransactionDT: timedelta from a given reference datetime (not an actual 
% timestamp) 
% “TransactionDT: first value is 86400, which corresponds to the number of 
% seconds in a day (60 * 60 * 24 = 86400) so I think the unit is seconds. 
% Using this, we know the data spans 6 months, as the maximum value is 
% 15811131, which would correspond to day 183.”

% TransactionAMT
TransactionAMTNoFraud = table2array(TransactionNotFraud(:,4));
TransactionAMTIsFraud = table2array(TransactionIsFraud(:,4));
% TransactionAMT: transaction payment amount in USD 
% “Some of the transaction amounts have three decimal places to the right 
% of the decimal point. There seems to be a link to three decimal places 
% and a blank addr1 and addr2 field. Is it possible that these are foreign 
% transactions and that, for example, the 75.887 in row 12 is the result 
% of multiplying a foreign currency amount by an exchange rate?”

% ProductCD
ProductCDNoFraud = TransactionNotFraud(:,5);
ProductCDIsFraud = TransactionIsFraud(:,5);
% ProductCD: product code, the product for each transaction 
% “Product isn't necessary to be a real 'product' (like one item to be 
% added to the shopping cart). It could be any kind of service.”

% Card1 - Card6
CardNoFraud = TransactionNotFraud(:,[6:11]);
CardIsFraud = TransactionIsFraud(:,[6:11]);
% card1 - card6: payment card information, such as card type, card 
% category, issue bank, country, etc.

% Address
AddressNoFraud = table2array(TransactionNotFraud(:,[12:13]));
AddressIsFraud = table2array(TransactionIsFraud(:,[12:13]));
% addr: address “both addresses are for purchaser, addr1 as billing region,
% addr2 as billing country”


% Dist
DistNoFraud = table2array(TransactionNotFraud(:,[14:15]));
DistIsFraud = table2array(TransactionIsFraud(:,[14:15]));
% P_EmailDomain
P_EmailDomainNoFraud = TransactionNotFraud(:,16);
P_EmailDomainIsFraud = TransactionIsFraud(:,16);
% R_EmailDomain
R_EmailDomainNoFraud = TransactionNotFraud(:,17);
R_EmailDomainIsFraud = TransactionIsFraud(:,17);
% dist: distance "distances between (not limited) billing address, mailing 
% address, zip code, IP address, phone area, etc.” P_ and (R_) emaildomain:
% purchaser and recipient email domain “ certain transactions don't need 
% recipient, so Remaildomain is null.”

% C1 - C14
CNoFraud = table2array(TransactionNotFraud(:,[18:31]));
CIsFraud = table2array(TransactionIsFraud(:,[18:31]));
% C1-C14: counting, such as how many addresses are found to be associated 
% with the payment card, etc. The actual meaning is masked. “Can you please 
% give more examples of counts in the variables C1-15? Would these be like 
% counts of phone numbers, email addresses, names associated with the user? 
% I can't think of 15. Your guess is good, plus like device, ipaddr, 
% billingaddr, etc. Also these are for both purchaser and recipient, which 
% doubles the number.”


% D1 - D15
DNoFraud = table2array(TransactionNotFraud(:,[32:46]));
DIsFraud = table2array(TransactionIsFraud(:,[32:46]));
% D1-D15: timedelta, such as days between previous transaction, etc.


% M1 - M9
MNoFraud = table2array(TransactionNotFraud(:,[47:55]));
MIsFraud = table2array(TransactionIsFraud(:,[47:55]));
% M1-M9: match, such as names on card and address, etc.


% V1 - V339
VNoFraud = TransactionNotFraud(:,[56:394]);
VIsFraud = TransactionIsFraud(:,[56:394]);
% Vxxx: Vesta engineered rich features, including ranking, counting,
% and other entity relations. 
% “For example, how many times the payment card associated with a IP and 
% email or address appeared in 24 hours time range, etc.”

% "All Vesta features were derived as numerical. some of them are count of 
% orders within a clustering, a time-period or condition, so the value is 
% finite and has ordering (or ranking). I wouldn't recommend to treat any 
% of them as categorical. If any of them resulted in binary by chance, it 
% maybe worth trying."


toc

%% Visualización de datos
% TransactionDT
figure
histogram(TransactionDTNoFraud',100)
hold on
histogram(TransactionDTIsFraud',100)
hold off
xlabel('Transaction timedelta')
grid on
legend('No fradulenta','Fraudulenta')

% TransactionAMT
figure
histogram(TransactionAMTNoFraud',100)
hold on
histogram(TransactionAMTIsFraud',100)
hold off
xlabel('Transaction amount')
grid on
legend('No fradulenta','Fraudulenta')

% ProductCD


% Card1 - Card6


% Address


% Dist


% P_EmailDomain


% R_EmailDomain


% C1 - C14


% D1 - D15


% M1 - M9


% V1 - V339

