function draw_ttest_barchart(data1, data2)
    % 执行配对 t 检验
    [~, p_value, ~, stats] = ttest(data1, data2, 'Alpha', 0.05, 'Tail', 'both');

    % 绘制柱状图
    bar_data = [mean(data1), mean(data2)];
    bar_errors = [std(data1)/sqrt(length(data1)), std(data2)/sqrt(length(data2))];
    figure;
    h = bar(bar_data);
    hold on;

    % 设置不同颜色的柱状图填充色
    color1 = [255/255, 148/255, 131/255]; %橙色
    color2 = [64/255, 151/255, 170/255]; %蓝色

    h.FaceColor = 'flat';
    h.CData(1,:) = color1;  % 第一个柱状图的颜色
    h.CData(2,:) = color2;  % 第二个柱状图的颜色

    % 添加误差线，只显示上半部分的误差线
    errorbar(1:numel(bar_data), bar_data, [0 0], bar_errors, '.', 'Color', 'k', 'LineWidth', 1);

    % 添加显著符号
    if p_value < 0.05
        % 根据 p 值的大小生成相应数量的星号
        if p_value < 0.001
            sig_markers = '***';
        elseif p_value < 0.01
            sig_markers = '**';
        else
            sig_markers = '*';
        end

        % 显示显著符号
        sig_position = bar_data(2) + bar_errors(2) + max(bar_errors);
        text(1.5, sig_position, sig_markers, 'HorizontalAlignment', 'center', 'FontSize', 20);
    end

    % 设置轴标签和标题
%     xticklabels({'Group 1', 'Group 2'});
%     ylabel('Data');
    title('Paired t-Test');

    % 设置 y 轴的限制范围
    ylim([0.02 0.026]);

    % 隐藏右边框线
    box off;

    hold off;
end
