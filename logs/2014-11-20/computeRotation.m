function B = computeRotation(seed, DIM)
% computes an orthogonal basis

    function r = unif(N, inseed)
    % unif(N, seed)
    %    generates N uniform numbers with starting seed

      % initialization
      inseed = abs(inseed);
      if inseed < 1
        inseed = 1;
      end
      aktseed = inseed;
      for i = 39:-1:0
        tmp = floor(aktseed/127773);
        aktseed = 16807 * (aktseed - tmp * 127773) - 2836 * tmp;
        if aktseed < 0
          aktseed = aktseed + 2147483647;
        end
        if i < 32
          rgrand(i+1) = aktseed;
        end
      end
      aktrand = rgrand(1);

      % sample numbers
      r = zeros(1,N); % makes the function ten times faster(!)
      for i = 1:N
        tmp = floor(aktseed/127773);
        aktseed = 16807 * (aktseed - tmp * 127773) - 2836 * tmp;
        if aktseed < 0
          aktseed = aktseed + 2147483647;
        end
        tmp = floor(aktrand / 67108865);
        aktrand = rgrand(tmp+1);
        rgrand(tmp+1) = aktseed;
        r(i) = aktrand/2.147483647e9;
      end
      if any(r == 0)
        warning('zero sampled(?), set to 1e-99');
        r(r==0) = 1e-99;
      end
    end

    function g = gauss(N, seed)
    % gauss(N, seed)
    % samples N standard normally distributed numbers
    % being the same for a given seed
      r = unif(2*N, seed); % in principle we need only half
      g = sqrt(-2*log(r(1:N))) .* cos(2*pi*r(N+1:2*N));
      if any(g == 0)
        g(g==0) = 1e-99;
      end
    end

  B = reshape(gauss(DIM*DIM,seed), DIM, DIM);
  for i = 1:DIM
      for j = 1:i-1
         B(:,i) = B(:,i) - B(:,i)'*B(:,j) * B(:,j);
      end
      B(:,i) = B(:,i) / sqrt(sum(B(:,i).^2));
  end
    
end
