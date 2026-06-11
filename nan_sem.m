function err = nan_sem(y, opt)
arguments
    y {mustBeNumeric} % matrix of numbers
    opt.dim = 1  % Dimension to act on
end
n = sum(~ismissing(y), opt.dim);
std_vals = std(y,[], opt.dim, "omitmissing");
err = std_vals ./ sqrt(n);
end