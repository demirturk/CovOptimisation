%create zeros array then make 1 the given IDs

function sonuc10 = makes1(node_number,IDs)
sonuc10= zeros(node_number,1);
sonuc10(IDs) = 1;
end