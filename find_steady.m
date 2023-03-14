%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% The Open-Economy NK Model WITH CBDC%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Author: Wenli Xu, 27/05/2022

% This function computes the steady state of the model. It is called in console_tcm

function F  = find_steady(pp,alpha,beta,gamma,gammaz,delta,epsilon,eta,n,D,Dz,gdp,rk,rkz,g,gsharez,psi,xim,sigma,pi,mum,sigm)
pH=pp(1);
tb=pp(2);
c=pp(3);
m=pp(4);
pF=(1/gamma*(1-(1-gamma)*pH^(1-eta)))^(1/(1-eta));
rer=(gammaz*pH^(1-eta)+(1-gammaz)*pF^(1-eta))^(1/(1-eta));
gdpz=psi*gdp/rer;
gz=gsharez*gdpz;
pHz=pH/rer; 
pFz=pF/rer;
bF=-4*gdp*D/rer; 
bHz=-4*rer*gdpz*Dz;
bH=-(1-n)/n*bHz;
mc=pH*(epsilon-1)/epsilon;
mcz=pFz*(epsilon-1)/epsilon;
yH=gdp/pH;                        
yFz=gdpz/pFz;
k=alpha*yH*mc/rk;
kz=alpha*yFz*mcz/rkz;
cz=1/((1-gammaz)*pFz^(-eta))*(yFz-gz-n/(1-n)*gamma*pF^(-eta)*(c+delta*k))-delta*kz;

F1=(1-gamma)*pH^(-eta)*(c+delta*k)+g+(1-n)/n*gammaz*pHz^(-eta)*(cz+delta*kz)-yH;
F2=bH*(1-1/beta)+bF*rer*(1-1/beta)+m*(1-xim)-tb;
F3=gdp-delta*k-pH*g-tb-c;
F4=((c^(-sigma)-xim*beta*c^(-sigma)/pi)/mum)^(1/(-sigm))-m;

F=[F1;F2;F3;F4];
end

