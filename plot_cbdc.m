%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% The Open-Economy NK Model WITH CBDC%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This matlab code plot the results of 2-country NK model with CBDC
% Author: Wenli Xu, 27/05/2022

%===================================================
%下面的模块1是运行tcm.mod
%注：mod文件名要对应修改成自己的名字
%===================================================

dynare tcm.mod nolog noclearall
%下载tcm.mod的结果文件tcm_results.mat，并定位该文件中的oo_位置                                              
load('tcm/Output/tcm_results.mat', 'oo_') 
%脉冲响应序列的结果储存爱 oo_.irfs中，我们重命名为irf1
irf1=oo_.irfs;
save irf1  %保存第一个脉冲响应结果
load irf1  %加载第一个脉冲响应结果

%===================================================
%下面的模块2是运行fi=5的mod文件plot_combineIRFs2.mod
%注：mod文件名要对应修改成自己的名字，其它与上面类似
%===================================================
dynare tcm_nodc.mod nolog noclearall
load('tcm_nodc/Output/tcm_nodc_results.mat', 'oo_')
irf2=oo_.irfs;
save irf2
load irf2

%设置白色的底色
set(0,'defaultfigurecolor','w')
% 下面，定位我们需要画出的外生冲击,此处想作生产率冲击e_a的图，
% 因此，我们让程序帮我们找到所有带e_a后缀的变量名
ending_cell={'_va'};
var={'gdp','rr','rer','dc','gdpz','rrz','tbz','dcstar'};
HOR=1:options_.irf;
n_plots=3;
% 下面，就开始让程序自动循环作图
for ii=1:length(ending_cell)
    for jj=1:length(var)
        if mod(jj,n_plots^2)==1
            plot_iter=1;
            fig(ii)= figure('Name',['Shock to',sprintf(ending_cell{1,ii})],'NumberTitle','off');
        end
        subplot(n_plots-1,n_plots+1,plot_iter)
        hold on
        plot(HOR,irf1.([var{1,jj},ending_cell{1,ii}]),'-k',HOR,irf2.([var{1,jj},ending_cell{1,ii}]),'--r','LineWidth',2);      
        xlim([1 options_.irf]);
        hline = refline(0, 0);
        title([var{1,jj}] )
        grid on
        if plot_iter==n_plots^2 ||  jj==length(var)
            legend('有数字人民币','没有数字人民币')   %图例
        end
        plot_iter=plot_iter+1;
    end
end


%设置白色的底色
set(0,'defaultfigurecolor','w')
% 下面，定位我们需要画出的外生冲击,此处想作生产率冲击e_a的图，
% 因此，我们让程序帮我们找到所有带e_a后缀的变量名
ending_cell={'_vm'};
var={'gdp','rr','rer','dc','gdpz','rrz','tbz','dcstar'};
HOR=1:options_.irf;
n_plots=3;
% 下面，就开始让程序自动循环作图
for ii=1:length(ending_cell)
    for jj=1:length(var)
        if mod(jj,n_plots^2)==1
            plot_iter=1;
            fig(ii)= figure('Name',['Shock to',sprintf(ending_cell{1,ii})],'NumberTitle','off');
        end
        subplot(n_plots-1,n_plots+1,plot_iter)
        hold on
        plot(HOR,irf1.([var{1,jj},ending_cell{1,ii}]),'-k',HOR,irf2.([var{1,jj},ending_cell{1,ii}]),'--r','LineWidth',2);      
        xlim([1 options_.irf]);
        hline = refline(0, 0);
        title([var{1,jj}] )
        grid on
        if plot_iter==n_plots^2 ||  jj==length(var)
            legend('有数字人民币','没有数字人民币')   %图例
        end
        plot_iter=plot_iter+1;
    end
end


% 数字人民币的跨境使用限制

dynare tcm_kadc001.mod nolog noclearall
%下载tcm.mod的结果文件tcm_results.mat，并定位该文件中的oo_位置                                              
load('tcm_kadc001/Output/tcm_kadc001_results.mat', 'oo_') 
%脉冲响应序列的结果储存爱 oo_.irfs中，我们重命名为irf1
irf3=oo_.irfs;
save irf3  %保存第一个脉冲响应结果
load irf3  %加载第一个脉冲响应结果

dynare tcm_kadc01.mod nolog noclearall
%下载tcm.mod的结果文件tcm_results.mat，并定位该文件中的oo_位置                                              
load('tcm_kadc01/Output/tcm_kadc01_results.mat', 'oo_') 
%脉冲响应序列的结果储存爱 oo_.irfs中，我们重命名为irf1
irf4=oo_.irfs;
save irf4  %保存第一个脉冲响应结果
load irf4  %加载第一个脉冲响应结果

dynare tcm_kadc1.mod nolog noclearall
%下载tcm.mod的结果文件tcm_results.mat，并定位该文件中的oo_位置                                              
load('tcm_kadc1/Output/tcm_kadc1_results.mat', 'oo_') 
%脉冲响应序列的结果储存爱 oo_.irfs中，我们重命名为irf1
irf5=oo_.irfs;
save irf5  %保存第一个脉冲响应结果
load irf5  %加载第一个脉冲响应结果


%设置白色的底色
set(0,'defaultfigurecolor','w')
% 下面，定位我们需要画出的外生冲击,此处想作生产率冲击e_a的图，
% 因此，我们让程序帮我们找到所有带e_a后缀的变量名
ending_cell={'_va'};
var={'gdp','rr','rer','dc','gdpz','rrz','tbz','dcstar'};
HOR=1:options_.irf;
n_plots=3;
% 下面，就开始让程序自动循环作图
for ii=1:length(ending_cell)
    for jj=1:length(var)
        if mod(jj,n_plots^2)==1
            plot_iter=1;
            fig(ii)= figure('Name',['Shock to',sprintf(ending_cell{1,ii})],'NumberTitle','off');
        end
        subplot(n_plots-1,n_plots+1,plot_iter)
        hold on
        plot(HOR,irf1.([var{1,jj},ending_cell{1,ii}]),'-k',HOR,irf3.([var{1,jj},ending_cell{1,ii}]),'--r',HOR,irf4.([var{1,jj},ending_cell{1,ii}]),'+b',HOR,irf5.([var{1,jj},ending_cell{1,ii}]),':.m','LineWidth',2);      
        xlim([1 options_.irf]);
        hline = refline(0, 0);
        title([var{1,jj}] )
        grid on
        if plot_iter==n_plots^2 ||  jj==length(var)
            legend('\phi_{dc}^*=0.001','\phi_{dc}^*=0.01','\phi_{dc}^*=0.1','\phi_{dc}^*=1')   %图例
        end
        plot_iter=plot_iter+1;
    end
end

% 不同流动性的数字人民币
dynare tcm_theta2.mod nolog noclearall
%下载tcm.mod的结果文件tcm_results.mat，并定位该文件中的oo_位置                                              
load('tcm_theta2/Output/tcm_theta2_results.mat', 'oo_') 
%脉冲响应序列的结果储存爱 oo_.irfs中，我们重命名为irf1
irf6=oo_.irfs;
save irf6  %保存第一个脉冲响应结果
load irf6  %加载第一个脉冲响应结果

dynare tcm_theta5.mod nolog noclearall
%下载tcm.mod的结果文件tcm_results.mat，并定位该文件中的oo_位置                                              
load('tcm_theta5/Output/tcm_theta5_results.mat', 'oo_') 
%脉冲响应序列的结果储存爱 oo_.irfs中，我们重命名为irf1
irf7=oo_.irfs;
save irf7  %保存第一个脉冲响应结果
load irf7  %加载第一个脉冲响应结果

% 不同流动性的数字人民币
dynare tcm_theta1.mod nolog noclearall
%下载tcm.mod的结果文件tcm_results.mat，并定位该文件中的oo_位置                                              
load('tcm_theta1/Output/tcm_theta1_results.mat', 'oo_') 
%脉冲响应序列的结果储存爱 oo_.irfs中，我们重命名为irf1
irf8=oo_.irfs;
save irf8  %保存第一个脉冲响应结果
load irf8  %加载第一个脉冲响应结果

% 不同流动性的数字人民币
dynare tcm_theta09.mod nolog noclearall
%下载tcm.mod的结果文件tcm_results.mat，并定位该文件中的oo_位置                                              
load('tcm_theta09/Output/tcm_theta09_results.mat', 'oo_') 
%脉冲响应序列的结果储存爱 oo_.irfs中，我们重命名为irf1
irf9=oo_.irfs;
save irf9  %保存第一个脉冲响应结果
load irf9  %加载第一个脉冲响应结果

%设置白色的底色
set(0,'defaultfigurecolor','w')
% 下面，定位我们需要画出的外生冲击,此处想作生产率冲击e_a的图，
% 因此，我们让程序帮我们找到所有带e_a后缀的变量名
ending_cell={'_va'};
var={'gdp','rr','rer','dc','gdpz','rrz','tbz','dcstar'};
HOR=1:options_.irf;
n_plots=3;
% 下面，就开始让程序自动循环作图
for ii=1:length(ending_cell)
    for jj=1:length(var)
        if mod(jj,n_plots^2)==1
            plot_iter=1;
            fig(ii)= figure('Name',['Shock to',sprintf(ending_cell{1,ii})],'NumberTitle','off');
        end
        subplot(n_plots-1,n_plots+1,plot_iter)
        hold on
        plot(HOR,irf1.([var{1,jj},ending_cell{1,ii}]),'-k',HOR,irf7.([var{1,jj},ending_cell{1,ii}]),'--r',HOR,irf6.([var{1,jj},ending_cell{1,ii}]),'+b',HOR,irf8.([var{1,jj},ending_cell{1,ii}]),'ob','LineWidth',2);      
        xlim([1 options_.irf]);
        hline = refline(0, 0);
        title([var{1,jj}] )
        grid on
        if plot_iter==n_plots^2 ||  jj==length(var)
            legend('\Theta=1.1','\Theta=1.5','\Theta=1.9','\Theta=1')   %图例
        end
        plot_iter=plot_iter+1;
    end
end

%设置白色的底色
set(0,'defaultfigurecolor','w')
% 下面，定位我们需要画出的外生冲击,此处想作生产率冲击e_a的图，
% 因此，我们让程序帮我们找到所有带e_a后缀的变量名
ending_cell={'_va'};
var={'gdp','rr','rer','dc','gdpz','rrz','tbz','dcstar'};
HOR=1:options_.irf;
n_plots=3;
% 下面，就开始让程序自动循环作图
for ii=1:length(ending_cell)
    for jj=1:length(var)
        if mod(jj,n_plots^2)==1
            plot_iter=1;
            fig(ii)= figure('Name',['Shock to',sprintf(ending_cell{1,ii})],'NumberTitle','off');
        end
        subplot(n_plots-1,n_plots+1,plot_iter)
        hold on
        plot(HOR,irf1.([var{1,jj},ending_cell{1,ii}]),'-k',HOR,irf7.([var{1,jj},ending_cell{1,ii}]),'--r',HOR,irf6.([var{1,jj},ending_cell{1,ii}]),'+b',HOR,irf8.([var{1,jj},ending_cell{1,ii}]),'ob',HOR,irf9.([var{1,jj},ending_cell{1,ii}]),'--k','LineWidth',2);      
        xlim([1 options_.irf]);
        hline = refline(0, 0);
        title([var{1,jj}] )
        grid on
        if plot_iter==n_plots^2 ||  jj==length(var)
            legend('\Theta=1.1','\Theta=1.5','\Theta=1.9','\Theta=1','\Theta=0.9')   %图例
        end
        plot_iter=plot_iter+1;
    end
end



% 附录结果
% 下面，定位我们需要画出的外生冲击,此处想作生产率冲击e_a的图，
% 因此，我们让程序帮我们找到所有带e_a后缀的变量名
ending_cell={'_vm'};
var={'gdp','rr','rer','dc','gdpz','rrz','tbz','dcstar'};
HOR=1:options_.irf;
n_plots=3;
% 下面，就开始让程序自动循环作图
for ii=1:length(ending_cell)
    for jj=1:length(var)
        if mod(jj,n_plots^2)==1
            plot_iter=1;
            fig(ii)= figure('Name',['Shock to',sprintf(ending_cell{1,ii})],'NumberTitle','off');
        end
        subplot(n_plots-1,n_plots+1,plot_iter)
        hold on
        plot(HOR,irf1.([var{1,jj},ending_cell{1,ii}]),'-k',HOR,irf2.([var{1,jj},ending_cell{1,ii}]),'--r','LineWidth',2);      
        xlim([1 options_.irf]);
        hline = refline(0, 0);
        title([var{1,jj}] )
        if plot_iter==n_plots^2 ||  jj==length(var)
            legend('有数字人民币','没有数字人民币')   %图例
        end
        plot_iter=plot_iter+1;
    end
end




dynare tcm_fdc.mod nolog noclearall
load('tcm_fdc/Output/tcm_fdc_results.mat', 'oo_')
irf10=oo_.irfs;
save irf10
load irf10


% 下面，定位我们需要画出的外生冲击,此处想作生产率冲击e_a的图，
% 因此，我们让程序帮我们找到所有带e_a后缀的变量名
ending_cell={'_va'};
var={'gdp','rr','rer','dc','gdpz','rrz','tbz','dcstar'};
HOR=1:options_.irf;
n_plots=3;
% 下面，就开始让程序自动循环作图
for ii=1:length(ending_cell)
    for jj=1:length(var)
        if mod(jj,n_plots^2)==1
            plot_iter=1;
            fig(ii)= figure('Name',['Shock to',sprintf(ending_cell{1,ii})],'NumberTitle','off');
        end
        subplot(n_plots-1,n_plots+1,plot_iter)
        hold on
        plot(HOR,irf1.([var{1,jj},ending_cell{1,ii}]),'-k',HOR,irf10.([var{1,jj},ending_cell{1,ii}]),'--r','LineWidth',2);      
        xlim([1 options_.irf]);
        hline = refline(0, 0);
        title([var{1,jj}] )
        if plot_iter==n_plots^2 ||  jj==length(var)
            legend('国外不发行数字货币','国外发行数字货币')   %图例
        end
        plot_iter=plot_iter+1;
    end
end


