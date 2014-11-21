%% Example Title
% Summary of example objective

%% Section 1 Title
% Description of first code block
a=1;

%% Section 2 Title
% Description of second code block
a=2;


function B = computeRotation(seed, DIM)
% computes an orthogonal basis
  B = reshape(gauss(DIM*DIM,seed), DIM, DIM);
  for i = 1:DIM
      for j = 1:i-1
         B(:,i) = B(:,i) - B(:,i)'*B(:,j) * B(:,j);
      end
      B(:,i) = B(:,i) / sqrt(sum(B(:,i).^2));
  end
    
end

computationRotation(1, 2);