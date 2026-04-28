function b = raw_data_error_bar(x,y, opts)
arguments
    x string
    y cell
    opts.bar_funcs = {@mean, @std}
    opts.jitter_scale = 0.6
    opts.cap_width = 40
    opts.bar_color
end
x_cat = categorical(x);
x_cat = reordercats(x_cat,x);

vectorize = @(y) y(:);
y = cellfun(vectorize, y, 'UniformOutput', false);

avg = cellfun(opts.bar_funcs{1}, y);
err = cellfun(opts.bar_funcs{2}, y);
hold on
b = bar(x_cat, avg, 'FaceColor','flat');

if isfield(opts, "bar_color")
    for k = 1:length(x_cat)
        b.CData(k, :) = opts.bar_color{k};
    end
end

errorbar(x_cat, avg, err, 'k', 'LineStyle', 'none', 'CapSize',opts.cap_width,'LineWidth',2)

alpha = .95;
jitterWidth = opts.jitter_scale*b.BarWidth;

for i = 1:length(x)
    x_shift = randi(100, size(y{i}));
    x_shift = x_shift-min(x_shift);
    x_shift = x_shift/max(x_shift);
    x_shift = x_shift*jitterWidth;
    x_shift = x_shift-jitterWidth/2;

    bar_x = repmat(i, size(y{i})) + x_shift;

    s = scatter(bar_x, y{i}, 10, 'filled', 'k');
    % s.AlphaData = alpha * ones(size(y{i}));
    % s.MarkerFaceAlpha = 'flat';
end
end