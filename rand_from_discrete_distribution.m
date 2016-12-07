function [y] = rand_from_discrete_distribution (x, P)
% Returns a random number from a discrete distribution of values x with
% corresponding relative likelihoods P.

  % calculate sizes & lengths of inputs
  sP = size (P);
  sx = size (x);
  lx = max (sx);

  % check for 1:1 correspondance between values and probabilities
  if sP != sx
    error ('The inputs must have the same length')
  elseif lx < 2
    error ('The inputs must have at least 2 elements')
  endif

  % normalise likelihoods
  s = sum (P);
  if s <= eps
    error ('Likelihoods should not be near-zero to machine precision')
  endif
  P = P / s;

  % calculate cumulative probability vector
  cP = zeros (sP);
  cP(1) = P(1);
  for j = 2:lx
    cP(j) = cP(j - 1) + P(j);
  endfor

  % choose random paramater in [0:1]
  r = rand ();

  % To choose the random output, the paramater r will be subtracted from each
  % element of the cumulative probability vector cP. the first positive element
  % of the resulting vector will then correspond to the appropriate output y
  % from the distribution values x:

  % subtract paramater r from each element of cP
  cP_sr = cP .- r;

  % find index of first positive element of (cP - r), k
  for j = 1:lx
    if cP_sr(j) >= 0
      k = j;   % store the current index
      break    % exit the loop
    endif
  endfor

  % choose & return k-th element of distribution values x
  y = x(k);

end
