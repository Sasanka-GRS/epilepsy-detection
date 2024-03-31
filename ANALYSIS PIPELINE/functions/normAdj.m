%%%%% Normalize the weight (adjacency) matrix to have all weights between 0 and 1 %%%%%

function W = normAdj(A)

maxi = max(A);
W = A/max(maxi);

end