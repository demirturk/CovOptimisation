function [  used_node_specs1,...
            placedALLNODESto1]...
            = neo_ilkusednodes( ozellikleri_saglayan_nodelarin_spec1to1,grno_a,...
                                ozellikleri_saglayan_nodelarin_spec3to1,grno_c,...
                                ozellikleri_saglayan_nodelarin_spec2to1,grno_b,...
                                ALLNODES)


nodeNO=size(ALLNODES,1);

birs=grno_a*10*ones(size(ozellikleri_saglayan_nodelarin_spec1to1,1),1);
ucs=grno_c*10*ones(size(ozellikleri_saglayan_nodelarin_spec3to1,1),1);
ikis=grno_b*10*ones(size(ozellikleri_saglayan_nodelarin_spec2to1,1),1);

matrix1 = [ozellikleri_saglayan_nodelarin_spec1to1,birs];
matrix3 = [ozellikleri_saglayan_nodelarin_spec3to1,ucs];
matrix2 = [ozellikleri_saglayan_nodelarin_spec2to1,ikis];


% İlk matris (matrix1) direkt olarak yeni matrise ekleniyor
new_matrix = matrix1;

% 3. matrisin satırlarını kontrol et ve ekle
for row = 1:size(matrix3, 1)
    % matrix3'ün ilk iki sütunundaki değerler
    row_values = matrix3(row, 1:2);
    
    % Daha önce eklenen new_matrix'teki satırların ilk iki sütunuyla karşılaştır
    if ~ismember(row_values, new_matrix(:, 1:2), 'rows')
        % Eğer aynı satır yoksa, matrix3'ten bu satırı new_matrix'e ekle
        new_matrix = [new_matrix; matrix3(row, :)];
    end
end

% 2. matrisin satırlarını kontrol et ve ekle
for row = 1:size(matrix2, 1)
    % matrix2'nin ilk iki sütunundaki değerler
    row_values = matrix2(row, 1:2);
    
    % Daha önce eklenen new_matrix'teki satırların ilk iki sütunuyla karşılaştır
    if ~ismember(row_values, new_matrix(:, 1:2), 'rows')
        % Eğer aynı satır yoksa, matrix2'den bu satırı new_matrix'e ekle
        new_matrix = [new_matrix; matrix2(row, :)];
    end
end



used_node_specs1=new_matrix;


placedALLNODESto1=ALLNODES;

    for i = 1:nodeNO
        for j=1:size(ozellikleri_saglayan_nodelarin_spec1to1,1)
            if placedALLNODESto1(i,(6*grno_a-5):(6*grno_a-4))==ozellikleri_saglayan_nodelarin_spec1to1(j,1:2) 
                if placedALLNODESto1(i,6)~=grno_a && placedALLNODESto1(i,12)~=grno_a && placedALLNODESto1(i,18)~=grno_a
                placedALLNODESto1(i,6*grno_a)=grno_a;
                end
            end
        end
    
        for l=1:size(ozellikleri_saglayan_nodelarin_spec3to1,1)
            if placedALLNODESto1(i,(6*grno_c-5):(6*grno_c-4))==ozellikleri_saglayan_nodelarin_spec3to1(l,1:2)
                if placedALLNODESto1(i,6)~=grno_a && placedALLNODESto1(i,12)~=grno_a && placedALLNODESto1(i,18)~=grno_a
                placedALLNODESto1(i,6*grno_c)=grno_a;
                end
            end
        end
        
        for k=1:size(ozellikleri_saglayan_nodelarin_spec2to1,1)
            if placedALLNODESto1(i,(6*grno_b-5):(6*grno_b-4))==ozellikleri_saglayan_nodelarin_spec2to1(k,1:2) 
                if placedALLNODESto1(i,6)~=grno_a && placedALLNODESto1(i,12)~=grno_a && placedALLNODESto1(i,18)~=grno_a
                placedALLNODESto1(i,6*grno_b)=grno_a;
                end
            end
        end
        

    end


end

%karalama