clc; clear all; close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% The Open-Economy NK Model WITH CBDC%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This M code computes the steady state of 2-country NK model with CBDC
% Author: Wenli Xu, 27/05/2022
% Variables with the z refer to the Foreign economy (Starred variables in
% the handout notation)

%% Structural Parameters or calibrated steady-state values (quarterly calibration)
beta=0.994;                    % discount factor
alpha=0.6;                   % elasticity of production wrt capital
epsilon=5;                    % elasticity of substitution btw differentiated goods
delta=0.05;                  % depreciation rate
sigma=1.2;                      % relative risk aversion
phi=3;                        % inverse of Frisch elasticity
eta=1.5;                      % elasticity of intratemporal substitution
omega=0.3;                    % trade openness
D=0.155; Dz=0.3;                    % external GROSS debt/GDP yearly ratio
psi=1.04;                        % gdpz/gdp ratio
n=0.3;                        % relative population of Home economy
gdp=1;                        % gross domestic product
pi=1; piz=1;                  % inflation targeting (quarterly calibration)
h=1/3;                        % hours of work
gamma=omega*(1-n)*psi/(n+(1-n)*psi); % F good weigh in H bundle
gammaz=omega*n/(n+(1-n)*psi); % H good weigh in F bundle
gshare=0.24; gsharez=0.24;      % public spending share in GDP
mum=1;
sigm=10.62;
xim=0.99;
ximstar=0.99;
mustar=1;
sigmstar=10.62;


%% Steady State (analytical expressions)
rr=1/beta; rrz=1/beta;       % real interest rate
r=pi/beta; rz=piz/beta;      % nominal interest rate
q=1; qz=1;                   % marginal value of investment (in terms of lambda)  
rk=1/beta-(1-delta);         % rental rate of capital in H
rkz=1/beta-(1-delta);        % rental rate of capital in F
g=gshare*gdp;                % H public spending


%% Steady State (numerical computation)
options = optimoptions('fsolve','MaxFunEvals',300000,'MaxIter',30000,'TolFun',1e-15);

pp0=[1 1 1 1];                       % Initial guess

x = fsolve(@(pp) find_steady(pp,alpha,beta,gamma,gammaz,delta,epsilon,eta,n,D,Dz,gdp,rk,rkz,g,gsharez,psi,xim,sigma,pi,mum,sigm),pp0,options);

pH=x(1);                       % Price of H good
pF=(1/gamma*(1-(1-gamma)*pH^(1-eta)))^(1/(1-eta)); % Price of F good
rer=(gammaz*pH^(1-eta)+(1-gammaz)*pF^(1-eta))^(1/(1-eta)); % Real Fx rate
gdpz=psi*gdp/rer;           % F GDP
gz=gsharez*gdpz;            % F government spending
pHz=pH/rer;                 % Price of H good (in terms of F CPI)
pFz=pF/rer;                 % Price of F good (in terms of F CPI)
bF=-4*gdp*D/rer;            % H investment in F bond
bHz=-4*rer*gdpz*Dz;         % F investment in H bond
bH=-(1-n)/n*bHz;            % H investment in H bond
bFz=-n/(1-n)*bF;            % F investment in F bond
mc=pH*(epsilon-1)/epsilon;  % H Real margingal cost
mcz=pFz*(epsilon-1)/epsilon;% F Real margingal cost
yH=gdp/pH;                  % H output           
yFz=gdpz/pFz;               % F output            
k=alpha*yH*mc/rk;           % H capital 
kz=alpha*yFz*mcz/rkz;       % F capital 
i=delta*k;                  % H investment
iz=delta*kz;                % F investment
tb=x(2); % H trade balance
c=x(3);       % H consumption
m=x(4);
cz=1/((1-gammaz)*pFz^(-eta))*(yFz-gz-n/(1-n)*gamma*pF^(-eta)*(c+i))-iz; % F consumption
w=(1-alpha)*yH*mc/h;         % H wage
lambda=(c)^(-sigma);          % H marginal utlity of consumption
lambdaz=(cz)^(-sigma);        % F marginal utlity of consumption
kappaL=lambda*w/(h^phi);      % labor supply shifter
hz=(lambdaz*(1-alpha)/kappaL*mcz*yFz)^(1/(1+phi));       % F Hours 
wz=kappaL*hz/lambdaz;         % F wage

mstar=((lambdaz-ximstar*beta*lambdaz/piz)/mustar)^(1/(-sigmstar));
a=yH/(k^(alpha)*h^(1-alpha));          % H tfp
az=yFz/(kz^(alpha)*hz^(1-alpha));      % F tfp
tbz=bFz*(1-1/beta)+bHz/rer*(1-1/beta)+mstar*(1-ximstar); % F trade balance
proof=gdpz-(cz+iz+pFz*gz+tbz);         % If 0, the solution is not wrong

% save parameters to use them in Dynare
save par beta alpha delta sigma phi eta gamma gammaz kappaL psi epsilon n...
g gz k kz c cz pi piz a az lambda lambdaz hz bF bHz rer pH pF gdpz r rz m mstar

