clear
clc
PoroProperty = PoroElasPara();
P_exact = PoroProperty.gamma*1e6;

List_test = 0:1:3;
% N_test = round(10.^List_test);  % Time discretisation number
N_test = [1 10 100];
Iteration = 1:1:5;
P =zeros(length(N_test), length(Iteration));
for i = 1: length(N_test)
    
    N = N_test(i);
    for j =1:length(Iteration)
        N_ite = Iteration(j);
        P(i,j) = MultiDiscretizationFixedStrain(N, N_ite);
    end
end

Error = abs(P-P_exact)/P_exact;
%%
f1 = figure(2001);
clf
hold on;
f1.Children.YScale ='log';
f1.Children.XScale ='log';
marker = {'+','o','*','.','x','s','d','^','v','>','<','p','h'};
color = {'r','g','b','c','m','k','w'};
for j =1:length(Iteration)
    plt = plot(N_test, Error(:,j));
    txtStart = strcat(strcat( '$10^{',num2str(log10(Error(1,j)),1),'}$'));
    txtEnd   = strcat(strcat( '$10^{',num2str(log10(Error(end,j)),1),'}$'));
    text(N_test(1),Error(1,j),txtStart,'interpreter','latex')
    text(N_test(end),Error(end,j),txtEnd,'interpreter','latex')
    leg1{j} = strcat('Iteration Number =', num2str(Iteration(j)));
    plt.Marker = marker{j};
    plt.Color = color{j};
end
% xlim([1,1e3])
title('Fixed Strain Split','interpreter','latex')
xlabel('Time discretization Number','interpreter','latex')
ylabel('$\varepsilon = = {\| p-p^{exact}\|}/{\| p^{exact}\|}$',...
    'interpreter','latex')
legend(leg1,'interpreter','latex')
box on; grid on;
saveas(f1,'ErrorAnalysis_TimeDiscretization_FSN.pdf')

%%
f2 = figure(2002);
clf
hold on;
f2.Children.YScale ='log';

for i =1:length(N_test)
    plt = plot(Iteration, Error(i,:));
    leg_test{i} = strcat(strcat( '$10^{',num2str(log10(N_test(i)),1),'}$'));
    plt.Marker = marker{i};
    plt.Color = color{i};
end

legend(leg_test,'interpreter','latex')

title('Fixed strain split','interpreter','latex')
xlabel('Inter-loop iteration Number','interpreter','latex')
ylabel('$\varepsilon = = {\| p-p^{exact}\|}/{\| p^{exact}\|}$',...
    'interpreter','latex')
box on; grid on;



%%
% f3 = figure(2003);
% clf
% hold on;
% f3.Children.YScale ='log';
% f3.Children.XScale ='log';
% marker = {'+','o','*','.','x','s','d','^','v','>','<','p','h'};
% color = {'r','g','b','c','m','k','w'};
% for j =1:length(Iteration)
%     plt = plot(N_test*j, Error(:,j));
%     txtStart = strcat(strcat( '$10^{',num2str(log10(Error(1,j)),1),'}$'));
%     txtEnd   = strcat(strcat( '$10^{',num2str(log10(Error(end,j)),1),'}$'));
%     text(N_test(1),Error(1,j)*1.1,txtStart,'interpreter','latex')
%     text(N_test(end),Error(end,j)*1.5,txtEnd,'interpreter','latex')
%     leg1{j} = strcat('Iteration Number =', num2str(Iteration(j)));
%     plt.Marker = marker{j};
%     plt.Color = color{j};
% end
% % xlim([1,1e3])
% title('Fixed Strain Split','interpreter','latex')
% xlabel('Time Discretization Number','interpreter','latex')
% ylabel('$\varepsilon = = {\| p-p^{exact}\|}/{\| p^{exact}\|}$',...
%     'interpreter','latex')
% legend(leg1,'interpreter','latex')
% box on; grid on;

