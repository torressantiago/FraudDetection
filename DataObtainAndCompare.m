%% Obtención de datos y visualización de datos
% A través de este script, se busca separar los datos que corresponden a
% fraude de los datos que no corresponden a fraude y visualizarlos para
% identificar características clave de cada clase.
clear all
close all
clc
%% Carga de datos de entrenamiento
fprintf('Cargando Datos\n')
tic
TrainDataFile = 'Data/train_transaction.csv';
TrainData = readtable(TrainDataFile);
TrainDataFileII = 'Data/train_identity.csv';
TrainDataII = readtable(TrainDataFileII);

t(1) = toc;
fprintf("%f s\n",t(1));
%% Procesamiento de los datos
% Se realiza la separación deseada
fprintf('Procesando Datos\n')

tic

%This will make file II work
TrainDataII = join(TrainDataII,TrainData(:,1:2));


IsFraud = table2array(TrainData(:,2));
IsFraudII = table2array(TrainDataII(:,42));

% Se determina si es fraude
TransactionNotFraud = TrainData(IsFraud == 0,:);% No es fraude
TransactionIsFraud = TrainData(IsFraud == 1,:); % Si es fraude

TransactionNotFraudII = TrainDataII(IsFraudII == 0,:);% No es fraude
TransactionIsFraudII = TrainDataII(IsFraudII == 1,:); % Si es fraude

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

[ProductCDNoFraudNum, ProducCDNoFraudList, ProductCDNoFraudNumberList] = ProductCDNumerized(ProductCDNoFraud);
ProducCDNoFraudList = [ProducCDNoFraudList, table2cell(table(ProductCDNoFraudNumberList))];
 
[ProductCDIsFraudNum, ProducCDIsFraudList, ProductCDIsFraudNumberList] = ProductCDNumerized(ProductCDIsFraud);
ProducCDIsFraudList = [ProducCDIsFraudList, table2cell(table(ProductCDIsFraudNumberList))];
% ProductCD: product code, the product for each transaction 
% “Product isn't necessary to be a real 'product' (like one item to be 
% added to the shopping cart). It could be any kind of service.”

% Card1 - Card6
CardNoFraud = TransactionNotFraud(:,6:11);
CardIsFraud = TransactionIsFraud(:,6:11);

Card1NoFraud = table2array(CardNoFraud(:,1));
Card1IsFraud = table2array(CardIsFraud(:,1));

Card2NoFraud = table2array(CardNoFraud(:,2));
Card2IsFraud = table2array(CardIsFraud(:,2));

Card3NoFraud = table2array(CardNoFraud(:,3));
Card3IsFraud = table2array(CardIsFraud(:,3));

[CardBrandNoFraudNum, CardBrandNoFraudList, CardBrandNoFraudNumberList] = CardBrandNumerized(CardNoFraud(:,4));
CardBrandNoFraudList = [CardBrandNoFraudList, table2cell(table({'0'},{'1'},{'2'},{'3'},{'4'}))'];
 
[CardBrandIsFraudNum, CardBrandIsFraudList, CardBrandIsFraudNumberList] = CardBrandNumerized(CardIsFraud(:,4));
CardBrandIsFraudList = [CardBrandIsFraudList, table2cell(table({'0'},{'1'},{'2'},{'3'},{'4'}))'];

Card5NoFraud = table2array(CardNoFraud(:,5));
Card5IsFraud = table2array(CardIsFraud(:,5));

[CardTypeNoFraudNum, CardTypeNoFraudList, CardTypeNoFraudNumberList] = CardType5Numerized(CardNoFraud(:,6));
CardTypeNoFraudList = [CardTypeNoFraudList, table2cell(table({'0'},{'1'},{'2'},{'3'},{'4'}))'];
 
[CardTypeIsFraudNum, CardTypeIsFraudList, CardTypeIsFraudNumberList] = CardTypeNumerized(CardIsFraud(:,6));
CardTypeIsFraudList = [CardTypeIsFraudList, table2cell(table({'0'},{'1'},{'2'}))'];

% card1 - card6: payment card information, such as card type, card 
% category, issue bank, country, etc.

% Address
AddressNoFraud = table2array(TransactionNotFraud(:,12:13));
AddressIsFraud = table2array(TransactionIsFraud(:,12:13));
% addr: address “both addresses are for purchaser, addr1 as billing region,
% addr2 as billing country”


% Dist
DistNoFraud = table2array(TransactionNotFraud(:,14:15));
DistIsFraud = table2array(TransactionIsFraud(:,14:15));
% P_EmailDomain
P_EmailDomainNoFraud = TransactionNotFraud(:,16);
P_EmailDomainIsFraud = TransactionIsFraud(:,16);

[P_EmailDomainNoFraudWNum, P_DomainNoFraud, P_NumberListNoFraud] = P_EmailDomainNoFraudNumerized(P_EmailDomainNoFraud);
P_DomainNoFraud = [P_DomainNoFraud, table2cell(table(P_NumberListNoFraud))];
[P_EmailDomainIsFraudWNum, P_DomainIsFraud, P_NumberListIsFraud] = P_EmailDomainIsFraudNumerized(P_EmailDomainIsFraud);
P_DomainIsFraud = [P_DomainIsFraud, table2cell(table(P_NumberListIsFraud))];

% R_EmailDomain
R_EmailDomainNoFraud = TransactionNotFraud(:,17);
R_EmailDomainIsFraud = TransactionIsFraud(:,17);

[R_EmailDomainNoFraudWNum, R_DomainNoFraud, R_NumberListNoFraud] = R_EmailDomainNoFraudNumerized(R_EmailDomainNoFraud);
R_DomainNoFraud = [R_DomainNoFraud, table2cell(table(R_NumberListNoFraud))];
[R_EmailDomainIsFraudWNum, R_DomainIsFraud, R_NumberListIsFraud] = R_EmailDomainIsFraudNumerized(R_EmailDomainIsFraud);
R_DomainIsFraud = [R_DomainIsFraud, table2cell(table(R_NumberListIsFraud))];

% dist: distance "distances between (not limited) billing address, mailing 
% address, zip code, IP address, phone area, etc.” P_ and (R_) emaildomain:
% purchaser and recipient email domain “ certain transactions don't need 
% recipient, so Remaildomain is null.”

% C1 - C14
CNoFraud = table2array(TransactionNotFraud(:,18:31));
CIsFraud = table2array(TransactionIsFraud(:,18:31));
% C1-C14: counting, such as how many addresses are found to be associated 
% with the payment card, etc. The actual meaning is masked. “Can you please 
% give more examples of counts in the variables C1-15? Would these be like 
% counts of phone numbers, email addresses, names associated with the user? 
% I can't think of 15. Your guess is good, plus like device, ipaddr, 
% billingaddr, etc. Also these are for both purchaser and recipient, which 
% doubles the number.”


% D1 - D15
DNoFraud = table2array(TransactionNotFraud(:,32:46));
DIsFraud = table2array(TransactionIsFraud(:,32:46));
% D1-D15: timedelta, such as days between previous transaction, etc.


% M1 - M9
MNoFraud = table2array(TransactionNotFraud(:,47:55));
MIsFraud = table2array(TransactionIsFraud(:,47:55));
% M1-M9: match, such as names on card and address, etc.


% V1 - V339
VNoFraud = TransactionNotFraud(:,56:394);
VIsFraud = TransactionIsFraud(:,56:394);
% Vxxx: Vesta engineered rich features, including ranking, counting,
% and other entity relations. 
% “For example, how many times the payment card associated with a IP and 
% email or address appeared in 24 hours time range, etc.”

% "All Vesta features were derived as numerical. some of them are count of 
% orders within a clustering, a time-period or condition, so the value is 
% finite and has ordering (or ranking). I wouldn't recommend to treat any 
% of them as categorical. If any of them resulted in binary by chance, it 
% maybe worth trying."

% Data from second file
% Id1 - Id38
IdNoFraud = TransactionNotFraudII(:,2:38);
IdIsFraud = TransactionIsFraudII(:,2:38);
% “id01 to id11 are numerical features for identity, which is collected by 
% Vesta and security partners such as device rating, ip_domain rating, 
%proxy rating, etc. Also it recorded behavioral fingerprint like account 
% login times/failed to login times, how long an account stayed on the 
% page, etc. All of these are not able to elaborate due to security partner 
% T&C. I hope you could get basic meaning of these features, and by 
% mentioning them as numerical/categorical, you won't deal with them 
% inappropriately.”

% Device Type
DeviceTypeNoFraud = TransactionNotFraudII(:,39);
DeviceTypeIsFraud = TransactionIsFraudII(:,39);

% Device Info
DeviceInfoNoFraud = TransactionNotFraudII(:,40);
DeviceInfoIsFraud = TransactionIsFraudII(:,40);

% 

t(2) = toc;
fprintf("%f s\n",t(2));

t = sum(t);

fprintf("El tiempo total fue %f s\n",t)

% Subroutine functions
function [P_EmailDomainIsFraudNum, P_Domains, P_NumberList] = P_EmailDomainIsFraudNumerized(P_EmailDomain)
    P_EmailDomainIsFraudNum = table2cell(P_EmailDomain);
    P_Domains = unique(P_EmailDomainIsFraudNum);

    for i = 1:42
        P_EmailDomainIsFraudNum = strrep(P_EmailDomainIsFraudNum,P_Domains(i,:),num2str(i));
    end
    
    P_EmailDomainIsFraudNum = strrep(P_EmailDomainIsFraudNum,{'15.com'},{'1'});
    P_EmailDomainIsFraudNum = strrep(P_EmailDomainIsFraudNum,{'21.mx'},{'16'});
    P_EmailDomainIsFraudNum = strrep(P_EmailDomainIsFraudNum,{'39.mx'},{'22'});
    P_EmailDomainIsFraudNum = strrep(P_EmailDomainIsFraudNum,{'proton24'},{'32'});
    P_EmailDomainIsFraudNum = strrep(P_EmailDomainIsFraudNum,{'rocket24'},{'34'});
    P_EmailDomainIsFraudNum = strrep(P_EmailDomainIsFraudNum,{'y24'},{'40'});
    NaNP_EmailDomainIsFraud = cellfun('isempty',P_EmailDomainIsFraudNum);
    P_EmailDomainIsFraudNum(NaNP_EmailDomainIsFraud==1,:) = replace(P_EmailDomainIsFraudNum(NaNP_EmailDomainIsFraud==1,:),{''},{'0'});
    P_EmailDomainIsFraudNum = str2double(P_EmailDomainIsFraudNum);
    P_NumberList = unique(P_EmailDomainIsFraudNum);
end

function [P_EmailDomainNoFraudNum, P_Domains, P_NumberList] = P_EmailDomainNoFraudNumerized(P_EmailDomain)
    P_EmailDomainNoFraudNum = table2cell(P_EmailDomain);
    P_Domains = unique(P_EmailDomainNoFraudNum);

    for i = 1:60
        P_EmailDomainNoFraudNum = strrep(P_EmailDomainNoFraudNum,P_Domains(i,:),num2str(i));
    end
    P_EmailDomainNoFraudNum = strrep(P_EmailDomainNoFraudNum,{'17.com'},{'1'});
    P_EmailDomainNoFraudNum = strrep(P_EmailDomainNoFraudNum,{'27.mx'},{'18'});
    P_EmailDomainNoFraudNum = strrep(P_EmailDomainNoFraudNum,{'55.mx'},{'28'});
    P_EmailDomainNoFraudNum = strrep(P_EmailDomainNoFraudNum,{'proton31'},{'40'});
    P_EmailDomainNoFraudNum = strrep(P_EmailDomainNoFraudNum,{'rocket31'},{'44'});
    P_EmailDomainNoFraudNum = strrep(P_EmailDomainNoFraudNum,{'y31'},{'56'});
    NaNP_EmailDomainIsFraud = cellfun('isempty',P_EmailDomainNoFraudNum);
    P_EmailDomainNoFraudNum(NaNP_EmailDomainIsFraud==1,:) = replace(P_EmailDomainNoFraudNum(NaNP_EmailDomainIsFraud==1,:),{''},{'0'});
    P_EmailDomainNoFraudNum = str2double(P_EmailDomainNoFraudNum);
    P_NumberList = unique(P_EmailDomainNoFraudNum);
end

function [R_EmailDomainIsFraudNum, R_Domains, R_NumberList] = R_EmailDomainIsFraudNumerized(R_EmailDomain)
    R_EmailDomainIsFraudNum = table2cell(R_EmailDomain);
    R_Domains = unique(R_EmailDomainIsFraudNum);

    for i = 1:33
        R_EmailDomainIsFraudNum = strrep(R_EmailDomainIsFraudNum,R_Domains(i,:),num2str(i));
    end
    
    R_EmailDomainIsFraudNum = strrep(R_EmailDomainIsFraudNum,{'14.mx'},{'1'});
    R_EmailDomainIsFraudNum = strrep(R_EmailDomainIsFraudNum,{'29.mx'},{'15'});
    R_EmailDomainIsFraudNum = strrep(R_EmailDomainIsFraudNum,{'proton17'},{'25'});
    R_EmailDomainIsFraudNum = strrep(R_EmailDomainIsFraudNum,{'rocket17'},{'26'});
    R_EmailDomainIsFraudNum = strrep(R_EmailDomainIsFraudNum,{'y17'},{'30'});
    NaNP_EmailDomainIsFraud = cellfun('isempty',R_EmailDomainIsFraudNum);
    R_EmailDomainIsFraudNum(NaNP_EmailDomainIsFraud==1,:) = replace(R_EmailDomainIsFraudNum(NaNP_EmailDomainIsFraud==1,:),{''},{'0'});
    R_EmailDomainIsFraudNum = str2double(R_EmailDomainIsFraudNum);
    R_NumberList = unique(R_EmailDomainIsFraudNum);
end

function [R_EmailDomainNoFraudNum, R_Domains, R_NumberList] = R_EmailDomainNoFraudNumerized(R_EmailDomain)
    R_EmailDomainNoFraudNum = table2cell(R_EmailDomain);
    R_Domains = unique(R_EmailDomainNoFraudNum);

    for i = 1:61
        R_EmailDomainNoFraudNum = strrep(R_EmailDomainNoFraudNum,R_Domains(i,:),num2str(i));
    end
    
    R_EmailDomainNoFraudNum = strrep(R_EmailDomainNoFraudNum,{'17.com'},{'1'});
    R_EmailDomainNoFraudNum = strrep(R_EmailDomainNoFraudNum,{'27.mx'},{'18'});
    R_EmailDomainNoFraudNum = strrep(R_EmailDomainNoFraudNum,{'56.mx'},{'28'});
    R_EmailDomainNoFraudNum = strrep(R_EmailDomainNoFraudNum,{'proton31'},{'40'});
    R_EmailDomainNoFraudNum = strrep(R_EmailDomainNoFraudNum,{'rocket31'},{'44'});
    R_EmailDomainNoFraudNum = strrep(R_EmailDomainNoFraudNum,{'y31'},{'57'});
    NaNP_EmailDomainIsFraud = cellfun('isempty',R_EmailDomainNoFraudNum);
    R_EmailDomainNoFraudNum(NaNP_EmailDomainIsFraud==1,:) = replace(R_EmailDomainNoFraudNum(NaNP_EmailDomainIsFraud==1,:),{''},{'0'});
    R_EmailDomainNoFraudNum = str2double(R_EmailDomainNoFraudNum);
    R_NumberList = unique(R_EmailDomainNoFraudNum);
end

function [ProductCDNum, ProductCDList, ProudctCDNumberList] = ProductCDNumerized(ProductCategory)
    ProductCDNum = table2cell(ProductCategory);
    ProductCDList = unique(ProductCDNum);

    for i = 1:5
        ProductCDNum = strrep(ProductCDNum,ProductCDList(i,:),num2str(i));
    end
    
    NaNProductCD = cellfun('isempty',ProductCDNum);
    ProductCDNum(NaNProductCD==1,:) = replace(ProductCDNum(NaNProductCD==1,:),{''},{'0'});
    ProductCDNum = str2double(ProductCDNum);
    ProudctCDNumberList = unique(ProductCDNum);
end

function [CardBrandNum, CardBrandList, CardBrandNumberList] = CardBrandNumerized(CardBrand)
    CardBrandNum = table2cell(CardBrand);
    CardBrandList = unique(CardBrandNum);

    for i = 1:5
        CardBrandNum = strrep(CardBrandNum,CardBrandList(i,:),num2str(i));
    end
    
    NaNCardBrand = cellfun('isempty',CardBrandNum);
    CardBrandNum(NaNCardBrand==1,:) = replace(CardBrandNum(NaNCardBrand==1,:),{''},{'0'});
    CardBrandNum = str2double(CardBrandNum);
    CardBrandNumberList = unique(CardBrandNum);
end

function [CardTypeNum, CardTypeList, CardTypeNumberList] = CardTypeNumerized(CardType)
    CardTypeNum = table2cell(CardType);
    CardTypeList = unique(CardTypeNum);

%     for i = 1:3
%         CardTypeNum = strrep(CardTypeNum,CardTypeList(i,:),num2str(i));
%     end
    CardTypeNum = strrep(CardTypeNum,{'credit'},{'2'});
    CardTypeNum = strrep(CardTypeNum,{'debit'},{'3'});
    
    NaNCardType = cellfun('isempty',CardTypeNum);
    CardTypeNum(NaNCardType==1,:) = replace(CardTypeNum(NaNCardType==1,:),{''},{'0'});
    CardTypeNum = str2double(CardTypeNum);
    CardTypeNumberList = unique(CardTypeNum);
end

function [CardTypeNum, CardTypeList, CardTypeNumberList] = CardType5Numerized(CardType)
    CardTypeNum = table2cell(CardType);
    CardTypeList = unique(CardTypeNum);

    for i = 1:5
        CardTypeNum = strrep(CardTypeNum,CardTypeList(i,:),num2str(i));
    end
    
    NaNCardType = cellfun('isempty',CardTypeNum);
    CardTypeNum(NaNCardType==1,:) = replace(CardTypeNum(NaNCardType==1,:),{''},{'0'});
    CardTypeNum = str2double(CardTypeNum);
    CardTypeNumberList = unique(CardTypeNum);
end
