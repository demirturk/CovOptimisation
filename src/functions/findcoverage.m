function [coverageafteropt] =findcoverage(Allplaced_afteropt,node_number,grno_a,grno_b,grno_c)


% yerlestirmeden sonra placed coverage guncelleme
coverage1afteropt= calculatecoverage_no_consumtpion(Allplaced_afteropt,grno_a,node_number);
coverage2afteropt= calculatecoverage_no_consumtpion(Allplaced_afteropt,grno_b,node_number);
coverage3afteropt= calculatecoverage_no_consumtpion(Allplaced_afteropt,grno_c,node_number);

%covereagelar
% initcoverages
% coverageafterpassives
coverageafteropt=[coverage1afteropt,coverage2afteropt,coverage3afteropt];
% end