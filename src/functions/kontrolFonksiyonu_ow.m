function [is_used,usednodesGR,Allplaced_afterOw1,out2,out3] = ...
    kontrolFonksiyonu_ow(acceptable_nodes1,grno_x, acceptable_nodes2,grno_y,acceptable_nodes3,grno_z,Allplaced_afterMincov1,av_x,av_y,av_z)

    % Girişte verilen array'lerin uzunluğunu kontrol et
    if length(acceptable_nodes1) ~= length(acceptable_nodes2) || length(acceptable_nodes1) ~= length(acceptable_nodes3)
        error('Arrayleri uzunluklari esit olmalidir');
    end

    nodeNO=length(acceptable_nodes1);

    in1=acceptable_nodes1';
    in2=acceptable_nodes2';
    in3=acceptable_nodes3';

    % Çıkış array'ini tanımla
    is_used = zeros(size(acceptable_nodes1));
    usednodesGR=zeros(size(acceptable_nodes1));
    i=0;
    counter=0;
    target_covA=av_x;
    target_covB=av_y;
    target_covC=av_z;

    temp_node_matrix=Allplaced_afterMincov1;

    % coverage_gap=1/nodeNO;
    cov1=calculatecoverage_no_consumtpion(temp_node_matrix,grno_x,nodeNO);
    cov2=calculatecoverage_no_consumtpion(temp_node_matrix,grno_y,nodeNO);
    cov3=calculatecoverage_no_consumtpion(temp_node_matrix,grno_z,nodeNO);
    
    while(i<nodeNO && cov1 <= target_covA + 0.02)  %% && cov2<target_cov2 && cov3<target_cov3 
    % Her birini kontrol et
    taken1=acceptable_nodes1;
        for i = 1:1:length(acceptable_nodes1)
                cov1=calculatecoverage_no_consumtpion(temp_node_matrix,grno_x,nodeNO);
                cov2=calculatecoverage_no_consumtpion(temp_node_matrix,grno_y,nodeNO);
                cov3=calculatecoverage_no_consumtpion(temp_node_matrix,grno_z,nodeNO);
        % İlk w 1 var mı kontrol et
            % a(i)=sum(taken1');
            % b(i)=sum(acceptable_nodes2');
            % c(i)=sum(acceptable_nodes3');
            % d(i)=sum(is_used');


            if  (acceptable_nodes1(i) == 1 && acceptable_nodes2(i) == 0 && acceptable_nodes3(i) == 0 && cov1 < target_covA  )
                is_used(i) = acceptable_nodes1(i);
                acceptable_nodes1(i)=0;
                usednodesGR(i)=grno_x;

                temp_node_matrix(i,grno_x*6)=grno_x;
                cov1=calculatecoverage_no_consumtpion(temp_node_matrix,grno_x,nodeNO);
                cov2=calculatecoverage_no_consumtpion(temp_node_matrix,grno_y,nodeNO);
                cov3=calculatecoverage_no_consumtpion(temp_node_matrix,grno_z,nodeNO);


            elseif(acceptable_nodes1(i) == 0 &&  acceptable_nodes3(i) == 1 && cov1 < target_covA  )  %ise grno_c'den grno_a'ya atar
                
                is_used(i) = acceptable_nodes3(i);
                acceptable_nodes3(i)=0;
                usednodesGR(i)=grno_z;

                temp_node_matrix(i,grno_z*6)=grno_x;

                cov1=calculatecoverage_no_consumtpion(temp_node_matrix,grno_x,nodeNO);
                cov2=calculatecoverage_no_consumtpion(temp_node_matrix,grno_y,nodeNO);
                cov3=calculatecoverage_no_consumtpion(temp_node_matrix,grno_z,nodeNO);


         % Yoksa ikinci array'i kontrol et
            elseif(acceptable_nodes1(i) == 0 && acceptable_nodes2(i) == 1  &&  cov1 < target_covA ) %ise grno_b'den grno_a'ya atar

                is_used(i) = acceptable_nodes2(i);
                acceptable_nodes2(i)=0;
                usednodesGR(i)=grno_y;

                temp_node_matrix(i,grno_y*6)=grno_x;
                
                cov1=calculatecoverage_no_consumtpion(temp_node_matrix,grno_x,nodeNO);
                cov2=calculatecoverage_no_consumtpion(temp_node_matrix,grno_y,nodeNO);
                cov3=calculatecoverage_no_consumtpion(temp_node_matrix,grno_z,nodeNO);     
            elseif(cov1 > target_covA+0.05 )
                counter=counter+1;
            else
                counter=counter+1;
            end
    
        end
            % a(i)=sum(taken1')
            % b(i)=sum(acceptable_nodes2')
            % c(i)=sum(acceptable_nodes3')
            % d(i)=sum(is_used')
            % 
    end

            covH=cov1                   ;
            covM=cov2;
            covL=cov3;
            in1;
            out1=is_used';
            in2;
            out2=acceptable_nodes2';
            in3;
            out3=acceptable_nodes3';
        
            Allplaced_afterOw1=temp_node_matrix;

end
    
    