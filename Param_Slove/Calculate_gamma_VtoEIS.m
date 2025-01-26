clear; clc;

% 读取数据
EIS;

IncreaseGracierMeltingRate_with_NumOfTravellers = 0.05 / 0.1 * 0.27 / (134.82 * 0.01);
% 根据2025年的一项研究，游客对环境保护造成的成本主要体现在冰川退缩和生态退化等方面。具体而言，每增加1000名游客，Mendenhall Glacier的退缩速率会加速5%
% 人均环境保护成本约为$1.50/人

DecreaseInfrastructureMaxRate_with_NumOfTravellers = 12 / (167.7935);
% 2024游客对Juneau基础设施承载力上限的总体削减率约为12%
% 2024年，Juneau接待了1,677,935名邮轮游客
% 人均基础设施成本约为$2.50/人

DecreaseSocietyMaxRate_with_NumOfTravellers = 15 / (116.7194);
% 游客对Juneau社区满意度的破坏率可以估算为15%至20%，即游客活动导致社区满意度下降了15%至20%。
% 2022年，Juneau接待了1,167,194名邮轮游客。

gamma_VE = IncreaseGracierMeltingRate_with_NumOfTravellers;
gamma_VI = DecreaseInfrastructureMaxRate_with_NumOfTravellers;
gamma_VS = DecreaseSocietyMaxRate_with_NumOfTravellers;
[gamma_VE, gamma_VI, gamma_VS]
%  0.1001    0.0715    0.1285

eta_VE = 1;
eta_VI = 1;
eta_VS = 1;


