%kontrolpassivenodes

function [placedpassiveNODESto1,used_nodes_list,used_nodes_groups,other2,other3,initcov,optcov]=...
    neo_kontrolpassivenodes(acceptable_nodes1,grno_a, acceptable_nodes2,grno_b,acceptable_nodes3,grno_c,ActiveNodesAtStart,av_x,av_y,av_z)

    % Girişte verilen array'lerin uzunluğunu kontrol et
    if length(acceptable_nodes1) ~= length(acceptable_nodes2) || length(acceptable_nodes1) ~= length(acceptable_nodes3)
        error('Arrayleri uzunluklari esit olmalidir');
    end

    nodeNO=length(acceptable_nodes1);

    % in1=acceptable_nodes1';
    % in2=acceptable_nodes2';
    % in3=acceptable_nodes3';
    target_covA=av_x;
    target_covB=av_y;
    target_covC=av_z;

    placedpassiveNODESto1=ActiveNodesAtStart;
    
    
    % Çıkış array'ini tanımla
    used_nodes_list = zeros(size(acceptable_nodes1));
    used_nodes_groups=zeros(size(acceptable_nodes1));
    % i=0;
    initcov= calculatecoverage_no_consumtpion(placedpassiveNODESto1,grno_a,nodeNO);

    cov1=initcov; %initialize
    % optcov=0;  %initialize
    
            other2=acceptable_nodes2';
            % in3
            other3=acceptable_nodes3';
            optcov=cov1;

    % Her birini kontrol et
    taken1=acceptable_nodes1;
        for i = 1:1:length(acceptable_nodes1)
        % İlk w 1 var mı kontrol et
            % a(i)=sum(taken1');
            % b(i)=sum(acceptable_nodes2');
            % c(i)=sum(acceptable_nodes3');
            % d(i)=sum(used_nodes_list');
    
            if (acceptable_nodes1(i) == 1 && ActiveNodesAtStart(i,6*grno_a)==0 )         
                % Var ise çıkış array'ine ilk array'in elemanı ekle
                used_nodes_list(i) = acceptable_nodes1(i);
                taken1(i)=0;
                used_nodes_groups(i)=grno_a;   %% kullanılan node hangi gruptan onun yazacak gr1,gr2,gr3 olarak
                placedpassiveNODESto1(i,6*grno_a)=grno_a;
                cov1=calculatecoverage_no_consumtpion(placedpassiveNODESto1,grno_a,nodeNO);               

                if cov1 > target_covA + 0.02
                    return;  % if döngüsünden çıkış
                end 

    % Yoksa ucuncu array'i kontrol et cunku onun target_av en dusuk
            elseif(acceptable_nodes1(i) == 0 && acceptable_nodes3(i) == 1 ...
                    && ActiveNodesAtStart(i,6*grno_a)==0 && ActiveNodesAtStart(i,6*grno_c)==0 )
                used_nodes_list(i) = acceptable_nodes3(i);
                acceptable_nodes3(i)=0;
                used_nodes_groups(i)=grno_c;
                placedpassiveNODESto1(i,6*grno_c)=grno_a;            
                cov1=calculatecoverage_no_consumtpion(placedpassiveNODESto1,grno_a,nodeNO);
                if cov1 > target_covA + 0.02
                    return;  % if döngüsünden çıkış
                end 

    % Yoksa ikinci array'i kontrol et
            elseif(acceptable_nodes1(i) == 0 && acceptable_nodes3(i) == 0 && acceptable_nodes2(i) == 1 && ActiveNodesAtStart(i,6*grno_a)==0 && ActiveNodesAtStart(i,6*grno_b)==0)
                used_nodes_list(i) = acceptable_nodes2(i);
                acceptable_nodes2(i)=0;
                used_nodes_groups(i)=grno_b;
                placedpassiveNODESto1(i,6*grno_b)=grno_a;
                cov1=calculatecoverage_no_consumtpion(placedpassiveNODESto1,grno_a,nodeNO);      
                if cov1 > target_covA + 0.02
                    return;  % if döngüsünden çıkış
                end 
                % Yoksa sıfır ekle (zaten default olarak sıfır atanmıştır)
            end
    
        end
            % a(i)=sum(taken1')
            % b(i)=sum(acceptable_nodes2')
            % c(i)=sum(acceptable_nodes3')
            % d(i)=sum(used_nodes_list')
    
    
            % in1
            % out1=used_nodes_list'
            % in2
            other2=acceptable_nodes2';
            % in3
            other3=acceptable_nodes3';
            optcov=cov1;
end

