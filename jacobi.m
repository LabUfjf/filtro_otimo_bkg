function [m,er] = jacobi(A, f, x, max_iter, TOL)

er = [];
iD = diag((diag(A)).^(-1));
L = -tril(A,-1);
U = -triu(A,1);
normf = norm(f);

iter = max_iter;
i = 1;
while (i <= max_iter)
  x = x - iD*(A*x - f);
  if (normf)
    er = [er; norm(A*x - f)/normf];
  else
    er = [er; norm(x)];
  end
  if (er(i) < TOL)
    iter = i;
    i = max_iter;
  end
  i = i + 1;
end
m = iter;

