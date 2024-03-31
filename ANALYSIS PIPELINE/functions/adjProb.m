%%%%% Generates an Erdos Renyi Graph with N nodes and edge probability p %%%%%

function A = adjProb(N,p)

A = zeros(N,N);

for k = 1:N
    for l = 1:k
        if(k~=l)
            temp = rand();
            if(temp<p)
                A(k,l) = 1;
                A(l,k) = 1;
            end
        end
    end
end

end