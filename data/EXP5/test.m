%% 测试
close all; clear;
% Figure
plot(cos(0:0.01:pi)); hold on;
fig = figure(1);
set(fig, 'Name', 'My Figure', 'NumberTitle', 'off', 'MenuBar', 'none');
title('hfdsaa范德萨’');

% 添加一些 Text 对象
text1 = text(0.5, -0.5, 'Hello哈哈Oreo', 'Color', 'red');
text2 = text(0.6, 0, 'World', 'Color', 'blue');
text3 = text(0.7, 0.5, 'Axes Text', 'Color', 'green');

legend('fdsaf')
xlabel('alskk')
	disp('Oreo');
figFont3(fig)

function figFont3(fig)
% 获取图窗中的所有文本对象
allTextObjects = findall(fig, 'Type', 'text');
% 遍历每个文本对象
for i = 1:length(allTextObjects)
    textObj = allTextObjects(i);
    originalString = textObj.String;

    % 分割字符串，区分中文和英文/数字
    modifiedString = stringChg(originalString);

    % 设置修改后的字符串
    textObj.String = modifiedString;
end

% 获取图窗中的所有坐标轴对象
allAxes = findall(fig, 'Type', 'axes');
% 遍历每个坐标轴对象
for i = 1:length(allAxes)
    ax = allAxes(i);

%     % 设置坐标轴标题的字体
%     if ~isempty(ax.Title)
%         ax.Title.String = stringChg(ax.Title.String);
%     end
%
%     % 设置 x 轴标签的字体
%     if ~isempty(ax.XLabel)
%         ax.XLabel.String = stringChg(ax.XLabel.String);
%     end
%
%     % 设置 y 轴标签的字体
%     if ~isempty(ax.YLabel)
%         ax.YLabel.String = stringChg(ax.YLabel.String);
%     end
%
%     % 设置 z 轴标签的字体
%     if ~isempty(ax.ZLabel)
%         ax.ZLabel.String = stringChg(ax.ZLabel.String);
%     end

    % 设置 x 轴刻度标签的字体
    if ~isempty(ax.XTickLabel)
        ax.XTickLabel = cellfun(@stringChg, ax.XTickLabel, 'UniformOutput', false);
    end

    % 设置 y 轴刻度标签的字体
    if ~isempty(ax.YTickLabel)
        ax.YTickLabel = cellfun(@stringChg, ax.YTickLabel, 'UniformOutput', false);
    end

    % 设置 z 轴刻度标签的字体
    if ~isempty(ax.ZTickLabel)
        ax.ZTickLabel = cellfun(@stringChg, ax.ZTickLabel, 'UniformOutput', false);
    end
end

% 获取图窗中的所有极坐标轴对象
allPolarAxes = findall(fig, 'Type', 'polaraxes');
% 遍历每个极坐标轴对象
for i = 1:length(allPolarAxes)
	disp('Oreo');
    ax = allPolarAxes(i);

%     % 设置坐标轴标题的字体
%     if ~isempty(ax.Title)
%         ax.Title.String = stringChg(ax.Title.String);
%     end
%
%     % 设置 r 轴标签的字体
%     if ~isempty(ax.RLabel)
%         ax.RLabel.String = stringChg(ax.RLabel.String);
%     end

%     % 设置 theta 轴标签的字体
%     if ~isempty(ax.ThetaLabel)
%         ax.ThetaLabel.String = stringChg(ax.ThetaLabel.String);
%     end

    % 设置 r 轴刻度标签的字体
    if ~isempty(ax.RTickLabel)
        ax.RTickLabel = cellfun(@stringChg, ax.RTickLabel, 'UniformOutput', false);
    end

    % 设置 theta 轴刻度标签的字体
    if ~isempty(ax.ThetaTickLabel)
        ax.ThetaTickLabel = cellfun(@stringChg, ax.ThetaTickLabel, 'UniformOutput', false);
    end
end

allLegend=findall(fig,'Type','Legend');

% 遍历每个图例对象
for i=1:length(allLegend)
    lg=allLegend(i);
    % 设置坐标轴标题的字体
    if ~isempty(lg.String)
        lg.String = cellfun(@stringChg,lg.String, 'UniformOutput', false);
    end
end

end

function modifiedString = stringChg(textCont_String)
if strcmp(textCont_String,char);modifiedString=char;else
    chiFontname = '宋体';
    engFontname = 'Times New Roman';

    % 分割中英文
    result = splitChinese(textCont_String);

    % 设置中文字段字体
    result.Data(result.flag == 1) = strcat(['\fontname{', chiFontname, '}'], result.Data(result.flag == 1));

    % 设置英文字段字体
    result.Data(result.flag == 0) = strcat(['\fontname{', engFontname, '}'], result.Data(result.flag == 0));

    % 重新连接字符
    modifiedString = [result.Data{:}];
end
end

function result = splitChinese(label)
% 确定汉字的位置
label = char(label);

% 检查是否为中文字符
log = arrayfun(@(x) (x >= '一' && x <= '龥') || ...
    (x >= 8212 && x <= 8230) || ...
    (x >= 12290 && x <= 12305) || ...
    (x >= 65281 && x <= 65311), label);

% 找到分隔点
Indxs = find(diff(log) ~= 0);

% 提取分段
result.Data = arrayfun(@(x, y) extractBetween(label, x, y), [0, Indxs]' + 1, [Indxs, length(label)]');
result.flag = [log(Indxs), log(end)];
end
