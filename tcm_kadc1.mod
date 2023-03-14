%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% The Open-Economy NK Model WITH CBDC%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This Dynare code simulates a 2-country NK model with CBDC on
% kappa_dc=1
% Author: Wenli Xu, 27/05/2022
% Variables with the z refer to the Foreign economy (Starred variables in
% the handout notation)

close all;
warning off
%%
%%%%%%%%%%%%%%%%%%%%%%%Endogenous Variables%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
var
c    cz          % consumption
h    hz          % hours
k    kz          % capital 
q    qz          % Tobin q 
i    iz          % investment
w    wz          % real wage
yH   yFz         % output
pH   pHz         % price of H good
pF   pFz         % price of F good
r    rz          % nominal interest rate 
rr   rrz         % real interest rate
mc   mcz         % real marginal cost
lambda lambdaz   % marginal utility of consumption
rk   rkz         % rental rate of capital
bH   bHz         % H bond
bF   bFz         % F bond
pi   piz         % CPI inflation
piH  piFz        % producer inflation
tb   tbz         % trade balance
gdp  gdpz        % gross domestic product
g    gz          % government spending 
a    az          % total factor productivity
ki   kiz         % capital inflows
ko   koz         % capital outflows
fa  faz          % financial account
nfa nfaz         % net financial asset position
rer              % real exchange rate
De               % depreciation of H currency
proof            % it should be always zero, otherwise something is wrong
m                % cash
dc               % CBDC
mstar
dcstar
dct

% log variables to have IRFs in percentage deviations from the ss
clog hlog klog ilog rerlog       
czlog hzlog kzlog izlog gdpzlog
;
%%
%%%%%%%%%%%%%%%%%%%%%%%Exogenous Variables%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varexo 
va   vaz   % productivity shock
vg   vgz   % public spending shock
vm   vmz   % monetary policy shock

;  
    
%%
%%%%%%%%%%%%%%%%%%%%%%%Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parameters

beta alpha delta sigma phi eta gamma gammaz kappaL epsilon n
gss gzss kss kzss css czss piss pizss ass azss lambdass lambdazss 
hzss bFss bHzss rerss pHss pFss gdpzss rss rzss 
calvo kappaI kappaP kappaD phipi phiy phie rhoa rhog rhom 
mum sigm xim sigdc mudc
mudcstar sigdcstar kadcstar mustar ximstar sigmstar mss mstarss

;

load par;  % load mat file created in console_tcm
set_param_value ('alpha',alpha); set_param_value ('beta',beta);
set_param_value ('delta',delta); set_param_value ('sigma',sigma);
set_param_value ('phi',phi); set_param_value ('eta',eta);
set_param_value ('gamma',gamma); set_param_value ('gammaz',gammaz);
set_param_value ('kappaL',kappaL); set_param_value ('epsilon',epsilon);
set_param_value ('n',n);    set_param_value ('gss',g); set_param_value ('gzss',gz);
set_param_value ('kss',k); set_param_value ('kzss',kz); 
set_param_value ('css',c); set_param_value ('czss',cz);
set_param_value ('piss',pi); set_param_value ('pizss',piz);
set_param_value ('ass',a);  set_param_value ('azss',az); 
set_param_value ('rss',r);  set_param_value ('rzss',rz); 
set_param_value ('lambdass',lambda);  set_param_value ('lambdazss',lambdaz); 
set_param_value ('hzss',hz); set_param_value ('bFss',bF); set_param_value ('bHzss',bHz);
set_param_value ('rerss',rer);  set_param_value ('pHss',pH); set_param_value ('pFss',pF);
set_param_value ('gdpzss',gdpz); set_param_value ('mss',m); set_param_value ('mstarss',mstar);

phipi=1.5;                % mp response to inflation
phiy=1;               % mp response to output
phie=0;                   % mp response to exchange rate
kappaI=2.48;              % investment adjustment cost (as in CEE). If 0, q is constant
kappaD=0.01;              % usually calibrated at a small value. If 0, the model has a unit root
rhoa=0.9;                 % tfp persistence
rhog=0.9;                 % public spending persistence
rhom=0.8;                 % monetary policy inertia
calvo=0.66;               % price rigidity in calvo framework
mum=1;
sigm=10.62;
xim=0.99; 
sigdc=9.558; 
mudc=1.1;
mudcstar=1.1;
sigdcstar=9.558;
kadcstar=1;
mustar=1;
ximstar=0.99;
sigmstar=9.558;



% adjusment cost coefficient to have the same linear Phillips Curve of the
% Calvo framework ONLY IF PISS=1, otherwise the expression is more
% complicated
kappaP=(epsilon-1)*calvo/((1-calvo)*(1-beta*calvo)); 

%%
%%%%%%%%%%%%%%%%%%%%%%%Non-Linear Model%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

model;
% Households
lambda= (c) ^-sigma;
lambdaz=(cz)^-sigma; 

1=beta*lambda(1) /lambda *r/ pi(1);
1=beta*lambdaz(1)/lambdaz*rz/piz(1);

1=beta*lambda(1) /lambda *rz/piz(1)*rer(1)/rer   -kappaD*(bF-bFss);
1=beta*lambdaz(1)/lambdaz*r /pi(1) *rer   /rer(1)-kappaD*(bHz-bHzss);

1=beta*lambda(1) /lambda *(rk(1)+(1-delta) *q(1)) /q;
1=beta*lambdaz(1)/lambdaz*(rkz(1)+(1-delta)*qz(1))/qz;

kappaL*h^(phi) =lambda* w;        
kappaL*hz^(phi)=lambdaz*wz;

k= (1-delta)*k(-1)+ (1-kappaI/2*(i /i(-1)-1)^2) *i;
kz=(1-delta)*kz(-1)+(1-kappaI/2*(iz/iz(-1)-1)^2)*iz;

1=q *(1-kappaI/2*(i /i(-1)-1) ^2-kappaI*(i /i(-1)-1) *i /i(-1)) +kappaI*beta*lambda(1) /lambda *q(1) *(i(1) /i-1) *(i(1) /i) ^2;    
1=qz*(1-kappaI/2*(iz/iz(-1)-1)^2-kappaI*(iz/iz(-1)-1)*iz/iz(-1))+kappaI*beta*lambdaz(1)/lambdaz*qz(1)*(iz(1)/iz-1)*(iz(1)/iz)^2;    

% Firms
yH =a *k(-1) ^alpha*h ^(1-alpha);
yFz=az*kz(-1)^alpha*hz^(1-alpha);

(1-alpha)*mc* yH =w *h;
(1-alpha)*mcz*yFz=wz*hz;

alpha*mc *yH =rk* k(-1);
alpha*mcz*yFz=rkz*kz(-1);

(piH -piss) *piH =beta*(lambda(1) /lambda *pH(1) *yH(1) /(pH *yH) *piH(1) *(piH(1) -piss)) +epsilon/kappaP*(mc /pH -(epsilon-1)/epsilon);
(piFz-pizss)*piFz=beta*(lambdaz(1)/lambdaz*pFz(1)*yFz(1)/(pFz*yFz)*piFz(1)*(piFz(1)-pizss))+epsilon/kappaP*(mcz/pFz-(epsilon-1)/epsilon);

% Market clearing
yH= (1-gamma) *pH^(-eta) *(c+i)  +g +(1-n)/n*gammaz*pHz^(-eta)*(cz+iz)+(kappaP/2*(piH -piss) ^2) *yH;
yFz=(1-gammaz)*pFz^(-eta)*(cz+iz)+gz+ n/(1-n)*gamma *pF^(-eta)*(c+i)  +(kappaP/2*(piFz-pizss)^2)*yFz;
n*bH+(1-n)*bHz=0;
n*bF+(1-n)*bFz=0;
gdp=c+i+pH*g+tb+pH*yH*(kappaP/2*(piH-piss)^2); 

% Prices
1=(1-gamma) *pH ^(1-eta)+gamma *pF ^(1-eta);
1=(1-gammaz)*pFz^(1-eta)+gammaz*pHz^(1-eta);
pH=rer*pHz;
pF=rer*pFz;
piH= pH /pH (-1) *pi;
piFz=pFz/pFz(-1)*piz;
rer/rer(-1)=De*piz/pi;

% Policy
r/ (rss)= ((pi /piss) ^(phipi)*(gdp/(steady_state(gdp)))^(phiy))^(1-rhom)*(r (-1)/rss) ^(rhom)*exp(vm);
rz/(rzss)=((piz/pizss)^(phipi)*(gdpz/gdpzss)^(phiy))^(1-rhom)*(rz(-1)/rzss)^(rhom)*exp(vmz);

% Shocks
log(a) =(1-rhoa)*log(ass) +rhoa*log(a(-1)) +va;
log(az)=(1-rhoa)*log(azss)+rhoa*log(az(-1))+vaz;

log(g)= (1-rhog)*log(gss)+ rhog*log(g(-1)) +vg;  
log(gz)=(1-rhog)*log(gzss)+rhog*log(gz(-1))+vgz;  

% Auxiliary variables
rr=r/pi(1); rrz=rz/piz(1); 
gdp=pH*yH; gdpz=pFz*yFz;
tb=bH+rer*bF-r(-1)/pi*bH(-1)-rer*rz(-1)/piz*bF(-1)+kappaD/2*rer*(bF-bFss)^2-(1-n)/n*kappaD/2*(bHz-bHzss)^2+m+dc-(1-n)/n*kadcstar/2*(dcstar-steady_state(dcstar))^2-xim*m(-1)-dc(-1);
tbz=bFz+bHz/rer-rz(-1)/piz*bFz(-1)-1/rer*r(-1)/pi*bHz(-1)+kappaD/(2*rer)*(bHz-bHzss)^2-n/(1-n)*kappaD/2*(bF-bFss)^2+mstar+dcstar/rer+kadcstar/2*(dcstar-steady_state(dcstar))^2/rer-ximstar*mstar(-1)-dcstar(-1)/(rer*pi);
ki=-(bH-bH(-1)); kiz=-(bFz-bFz(-1));
ko=rer*(bF-bF(-1)); koz=(bHz-bHz(-1))/rer;
fa=ki-ko; faz=kiz-koz;
nfa=(bH+rer*bF)/gdp;
nfaz=(bHz/rer+bFz)/gdpz;
proof=gdpz-(cz+iz+pFz*gz+tbz+(kappaP/2*(piFz-pizss)^2)*pFz*yFz);

% Log variables
clog=log(c); hlog=log(h); klog=log(k); ilog=log(i); rerlog=log(rer);
czlog=log(cz); hzlog=log(hz); kzlog=log(kz); izlog=log(iz); gdpzlog=log(gdpz);

mum*m^(-sigm)=lambda-xim*beta*lambda(1)/pi(1);
mudc*dc^(-sigdc)=lambda-beta*lambda(1)/pi(1);
mustar*mstar^(-sigmstar)=lambdaz-ximstar*beta*lambdaz(1)/piz(1);
mudcstar*(dcstar/rer)^(-sigdcstar)=lambdaz*(1+kadcstar/rer*(dcstar-steady_state(dcstar)))-beta*lambdaz*(rer/rer(1))/piz(1);
dct=dc+dcstar;
end;

%% Steady State

%steady_state_model;
initval;
c=css; cz=czss; 
rk=1/beta-(1-delta); rkz=1/beta-(1-delta);
lambda=lambdass; lambdaz=lambdazss; 
rr=1/beta; rrz=1/beta; 
w=kappaL/(3*lambda); 
wz=kappaL*hzss/lambdaz;
h=1/3; hz=hzss; 
q=1; qz=1; 
k=kss; kz=kzss;
yH=1/pHss; yFz=gdpzss/pFss*rerss; 
i=delta*kss; iz=delta*kzss; 
g=gss; gz=gzss; 
a=ass; az=azss; 
pi=piss; piz=pizss;  
piH=piss; piFz=pizss; 
r=rss; rz=rzss; 
mc=pHss*(epsilon-1)/epsilon; 
mcz=pFss/rerss*(epsilon-1)/epsilon;
gdp=1; gdpz=gdpzss; 
pH=pHss; pF=pFss;  pHz=pHss/rerss; pFz=pFss/rerss; rer=rerss;
tb=1-css-delta*kss-pHss*gss;
tbz=gdpzss-czss-delta*kzss-pFss/rerss*gzss;
De=piss/pizss;
bF=bFss; bHz=bHzss; bH=-(1-n)/n*bHzss;  bFz=-n/(1-n)*bFss;            
clog=log(css); hlog=log(1/3); klog=log(kss); ilog=log(delta*kss); 
rerlog=log(rerss); czlog=log(czss); hzlog=log(hzss); kzlog=log(kzss); 
izlog=log(delta*kzss); gdpzlog=log(gdpzss); 
nfa=(-(1-n)/n*bHzss+rerss*bFss);
nfaz=(bHzss/rerss-n/(1-n)*bFss)/gdpzss;
m=mss;
dc=((lambda-beta*lambda/pi)/mudc)^(1/(-sigdc));
mstar=mstarss;
dcstar=((lambdaz-beta*lambdaz/piz)/mudcstar)^(1/(-sigdcstar))*rer;
dct=dc+dcstar;
end;

steady;
check;

%% Shocks
shocks;
var va; stderr 0.01;     
% var vg; stderr 0.01;    
var vm; stderr 0.0025; 
% var vaz; stderr 0.01;     
%  var vgz; stderr 0.01;    
%  var vmz; stderr 0.0025;    

end;

%% IRFs
stoch_simul(irf=40,order=2,nograph,pruning) ;