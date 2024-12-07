clear, close all;
global fp;
fp = fo();
yuchuli();
%**********************************************************
%**********************************************************
%**********************************************************读取数据
%*********************************************管式
dt1_0 = readmatrix("1_0.csv");
u1_0 = 410.5223;
%u1_0 = min(min(dt1_0(:,3)), u1_0);

dt1_3 = readmatrix("1_3.csv");
u1_3 = min(min(dt1_3(:,3)), 471.8984);
%u1_3 =  471.8984;
dt1_5 = readmatrix("1_5.csv");
u1_5 = min(dt1_5(:, 3),456.6393);
u1_5 = 456.6393;
f1 = @(x,name)fwtb(fp, name, [x(1:end/2,:),x(end/2+1:end,:)], {'$i$';'$t/s$';['$\\sigma/(\\mu S/cm)$'];'$i$';'$t$';['$\\sigma/(\\mu S/cm)$']},3);
f1(dt1_0, '$\beta=0$ 单管停留时间分布');
f1(dt1_3, '$\beta=3$ 单管停留时间分布');
f1(dt1_5(2:end,:), '$\beta=5$ 单管停留时间分布');
%*********************************************釜式
dt2_1 = readmatrix("2_1.csv");
u2_1 = min(min(dt2_1(:,3)),394.2910);
u2_1 = 394.2910;
dt2_3 = readmatrix("2_3.csv");
u2_3 = [451.9091 432.4477 413.7340;min(dt2_3(:,3:5),[], 1)];
u2_3 = u2_3(1, :);

f1(dt2_1, '单釜停留时间分布');
fwtb(fp, '多釜串联停留时间分布', dt2_3, {'$i$';'$t/s$';['$\\sigma/(\\mu S/cm)$'];['$\\sigma/(\\mu S/cm)$'];['$\\sigma/(\\mu S/cm)$']},3)

%**********************************************************
%**********************************************************
%**********************************************************初绘图
%*********************************************
plot1(dt1_0(:, 2), dt1_0(:, 3), '\beta=0 单管停留时间分布','时间/s','浓度/(\mu S/cm)','fph', 'image1/');
plot1(dt1_3(:, 2), dt1_3(:, 3), '\beta=3 单管停留时间分布','时间/s','浓度/(\mu S/cm)','fph', 'image1/');
plot1(dt1_5(:, 2), dt1_5(:, 3), '\beta=5 单管停留时间分布','时间/s','浓度/(\mu S/cm)','fph', 'image1/');
plot1(dt2_1(:, 2), dt2_1(:, 3), '单釜停留时间分布','时间/s','浓度/(\mu S/cm)','fph', 'image1/');
plot1(dt2_3(:, 2), dt2_3(:, 3:5), '多釜串联停留时间分布','时间/s','浓度/(\mu S/cm)','leng',{'釜1', '釜2', '釜3'},'fph', 'image1/');
%*********************************************釜式
plot1(dt1_0(:, 2), dt1_0(:, 3)-u1_0, '\beta=0 单管停留时间分布(去基准)','时间/s','浓度/(\mu S/cm)','fph', 'image2/');
plot1(dt1_3(:, 2), dt1_3(:, 3)-u1_3, '\beta=3 单管停留时间分布(去基准)','时间/s','浓度/(\mu S/cm)','fph', 'image2/');
plot1(dt1_5(:, 2), dt1_5(:, 3)-u1_5, '\beta=5 单管停留时间分布(去基准)','时间/s','浓度/(\mu S/cm)','fph', 'image2/');
plot1(dt2_1(:, 2), dt2_1(:, 3)-u2_1, '单釜停留时间分布(去基准)','时间/s','浓度/(\mu S/cm)','fph', 'image2/');
plot1(dt2_3(:, 2), dt2_3(:, 3:5)-ones(size(dt2_3, 1),1)*u2_3, '多釜串联停留时间分布(去基准)','时间/s','浓度/(\mu S/cm)','leng',{'釜1', '釜2', '釜3'},'fph', 'image2/');

%**********************************************************
%**********************************************************
%**********************************************************数值计算
rets = ones(7, 14);
rets(1,:) = inter(dt1_0(:, 2), dt1_0(:, 3)-u1_0);
rets(2,:) = inter(dt1_3(:, 2), dt1_3(:, 3)-u1_3);
rets(3,:) = inter(dt1_5(:, 2), dt1_5(:, 3)-u1_5);
rets(4,:) = inter(dt2_1(:, 2), dt2_1(:, 3)-u2_1);
rets(5,:) = inter(dt2_3(:, 2), dt2_3(:, 3)-u2_3(1));
rets(6,:) = inter(dt2_3(:, 2), dt2_3(:, 4)-u2_3(2));
rets(7,:) = inter(dt2_3(:, 2), dt2_3(:, 5)-u2_3(3));
fwt(fp, '## 结果');
fwtb(fp, '一阶差分', rets(:, 1:end/2), {'$\\int L(t)dt$';'$\\int tL(t)dt$';'$t$';'$\\int t^2L(t)dt$';'$\\sigma_{t}^2$';'$\\sigma_{\\theta}^2$';'$N$'},4);
fwtb(fp, 'quadl', rets(:, end/2+1:end), {'$\\int L(t)dt$';'$\\int tL(t)dt$';'$t$';'$\\int t^2L(t)dt$';'$\\sigma_{t}^2$';'$\\sigma_{\\theta}^2$';'$N$'},4);

%********************************************************%********************************************************函数区
%**********************************************************
%**********************************************************
%**********************************************************数值积分
function ret = inter(x, y)
    %一阶差分
    if size(x, 1)==1
        x = x';
    end
    if size(y, 1)==1
        y = y';
    end
    in2 = trapz(x, y);%ct
    in2t = trapz(x, y.*x);%tct
    in2t_ = in2t/in2;
    sig2 = trapz(x, y.*x.*x)/in2;
    sig2_ = sig2-in2t_*in2t_;
    tth2 = (sig2_)/(in2t_^2);

    pp = pchip(x, y);
    pv = @(px)ppval(pp, px);
    pvt = @(px)ppval(pp, px).*px;
    pvt2 = @(px)ppval(pp, px).*px.*px;

    in3 = quadl(pv, 0, max(x));%lt
    in3t = quadl(pvt, 0, max(x));%tlt
    in3t_ = in3t/in3;%t_
    sig3 = quadl(pvt2, 0, max(x))/in3;%t2lt
    sig3_ = sig3-in3t_*in3t_;%sigma
    tth3 = (sig3_)/(in3t_^2);
    ret = [in2, in2t,in2t_,sig2*in2,sig2_, tth2, 1/tth2,in3,in3t,in3t_,sig3*in3,sig3_,tth3,1/tth3];
end


%**********************************************************
%**********************************************************
%**********************************************************折线图绘制函数
function plot1(x, y, name, xname, yname, varargin)
    ipa = inputParser;
    addParameter(ipa, 'leng', 0);
    addParameter(ipa, 'fph', 0);
    parse(ipa, varargin{:});
    leng = ipa.Results.leng;
    fph = ipa.Results.fph;
    p = figure('visible','off','Position', [0, 0, 1000, 500]);
    cm = [0.017,0.198,1;1,0.149,0;1, 0.1, 1;];%颜色rgb
    mark = ['^','s','d'];%scatter标记
    h_plot = [];
    h_scatter = [];
    paym=0;
    for i=1:size(y, 2)
        inter = (max(x)-min(x))/500;
        px1 = 0:inter:max(x)+10*inter;
        py1 = pchip(x, y(:,i), px1);
        h_plot(i)  = plot(px1, py1, 'linewidth',1.2,'color', cm(i, :));
        hold on;
        h_scatter(i) = scatter(x, y(:,i), 50,cm(i, :), mark(i), 'filled');
        h_legend(i) = plot(NaN, NaN, 'linewidth', 1.2, 'color', cm(i, :), ...
                'Marker', mark(mod(i-1, length(mark)) + 1), 'MarkerSize', 6, ...
                'MarkerFaceColor', cm(i, :));
        hold on;
        paym = max(max(py1), paym);
    end
    if  ~ismember('leng', ipa.UsingDefaults)
        lgd = legend(h_legend, leng, 'position', [0.75 0.75,0.1,0.1],'fontsize', 17,'box', 'off');
        lgd.ItemTokenSize = [60, 10];
    end
    intex = (max(x)-min(x))/20;
    intey = (paym-0)/10;
    %xlim([min(x)-intex,max(x)+intex])
    xlim([0,max(x)+intex])
    %ylim([min(min(y))-intey,max(max(y))+intey])
    ylim([-20,paym+intey])
    xticks(0:200:max(x))
    figFont3(p,name,xname,yname)
    if  ~ismember('fph', ipa.UsingDefaults)
        saveas(p, [fph ,name, '.svg']);
    end
end

function figFont3(fig, titlename, xname, yname)
    title(titlename ,'fontsize', 20)
    xlabel(xname,'fontsize', 18);
    ylabel(yname,'fontsize', 18);
    box on;
    set(gca, 'LineWidth', 1.4);
    allTextObjects = findall(fig, 'Type', 'text');
    for i = 1:length(allTextObjects)
        textObj = allTextObjects(i);
        originalString = textObj.String;
        modifiedString = stringChg(originalString);
        textObj.String = modifiedString;
    end
    allAxes = findall(fig, 'Type', 'axes');
    for i = 1:length(allAxes)
        ax = allAxes(i);
        if ~isempty(ax.XTickLabel)
            ax.XTickLabel = cellfun(@stringChg, ax.XTickLabel, 'UniformOutput', false);
        end
        if ~isempty(ax.YTickLabel)
            ax.YTickLabel = cellfun(@stringChg, ax.YTickLabel, 'UniformOutput', false);
        end
        if ~isempty(ax.ZTickLabel)
            ax.ZTickLabel = cellfun(@stringChg, ax.ZTickLabel, 'UniformOutput', false);
        end
    end
    allPolarAxes = findall(fig, 'Type', 'polaraxes');
    for i = 1:length(allPolarAxes)
        disp('Oreo');
        ax = allPolarAxes(i);
        if ~isempty(ax.RTickLabel)
            ax.RTickLabel = cellfun(@stringChg, ax.RTickLabel, 'UniformOutput', false);
        end
        if ~isempty(ax.ThetaTickLabel)
            ax.ThetaTickLabel = cellfun(@stringChg, ax.ThetaTickLabel, 'UniformOutput', false);
        end
    end
    allLegend=findall(fig,'Type','Legend');
    for i=1:length(allLegend)
        lg=allLegend(i);
        if ~isempty(lg.String)
            lg.String = cellfun(@stringChg,lg.String, 'UniformOutput', false);
        end
    end

end

function modifiedString = stringChg(textCont_String)
    if strcmp(textCont_String,char);modifiedString=char;else
        chiFontname = 'Songti SC';
        engFontname = 'Times New Roman';
        result = splitChinese(textCont_String);
        result.Data(result.flag == 1) = strcat(['\fontname{', chiFontname, '}'], result.Data(result.flag == 1));
        result.Data(result.flag == 0) = strcat(['\fontname{', engFontname, '}'], result.Data(result.flag == 0));
        modifiedString = [result.Data{:}];
    end
end

function result = splitChinese(label)
    label = char(label);
    log = arrayfun(@(x) (x >= '一' && x <= '龥') || ...
        (x >= 8212 && x <= 8230) || ...
        (x >= 12290 && x <= 12305) || ...
        (x >= 65281 && x <= 65311), label);
    Indxs = find(diff(log) ~= 0);
    result.Data = arrayfun(@(x, y) extractBetween(label, x, y), [0, Indxs]' + 1, [Indxs, length(label)]');
    result.flag = [log(Indxs), log(end)];
end

%**********************************************************
%**********************************************************
%**********************************************************文件读写
function fw(file, title, data)
    fprintf(file, "### %s\n", title);
    for i=1:size(data, 1)
        fprintf(file, "    ");
        for j=1:size(data, 2)
            if data(i, j)>=0
                fprintf(file, " ");
            end
            fprintf(file, "%.4f ", data(i, j));
        end
        fprintf(file, "\n");
    end
    fprintf(file, "\n");
end

function fw_(file, title, data)
    fprintf(file, "### %s\n", title);
    for i=1:size(data, 1)
        fprintf(file, "    ");
        for j=1:size(data, 2)
            if data(i, j)>=0
                fprintf(file, " ");
            end
            fprintf(file, "%.4e ", data(i, j));
        end
        fprintf(file, "\n");
    end
    fprintf(file, "\n");
end

function fwtb_(file, title, data, head, ni)
    for i=1:ni
        fprintf(file, '#');
    end
    fprintf(file, " %s\n|", title);
    for i=1:size(head, 1)
        fprintf(file, [head(i, :),'|']);
    end
    fprintf(file, '\n|');
    for i=1:size(head, 1)
        fprintf(file, '-|');
    end
    fprintf(file, '\n');
    for i=1:size(data, 1)
        fprintf(file, "|");
        for j=1:size(data, 2)
            if data(i, j)>=0
                fprintf(file, "");
            end
            fprintf(file, "%.4e|", data(i, j));
        end
        fprintf(file, "\n");
    end
    fprintf(file, "\n");
end

function fwtb(file, title, data, head, ni)
    for i=1:ni
        fprintf(file, '#');
    end
    fprintf(file, " %s\n|", title);
    for i=1:size(head, 1)
        str = strjoin(head(i));
        fprintf(file, [str,'|']);
    end
    fprintf(file, '\n|');
    for i=1:size(head, 1)
        fprintf(file, '-|');
    end
    fprintf(file, '\n');
    for i=1:size(data, 1)
        fprintf(file, "|");
        for j=1:size(data, 2)
            if data(i, j)>=0
                fprintf(file, "");
            end
            fprintf(file, "%.4f|", data(i, j));
        end
        fprintf(file, "\n");
    end
    fprintf(file, "\n");
end


function yuchuli()
    global fp;
    fwt(fp, '## 图片\n![](image1/beta=0 20单管停留时间分布.svg)\n![](image1/beta=3 20单管停留时间分布.svg)\n');
    fwt(fp, '![](image1/beta=5 20单管停留时间分布.svg)\n![](image1/单釜停留时间分布.svg)\n![](image1/多釜串联停留时间分布.svg)\n');
    fwt(fp, '![](image2/beta=0 20单管停留时间分布(去基准).svg)\n![](image2/beta=3 20单管停留时间分布(去基准).svg)\n![](image2/beta=5 20单管停留时间分布(去基准).svg)\n');
    fwt(fp, '![](image2/单釜停留时间分布(去基准).svg)\n![](image2/多釜串联停留时间分布(去基准).svg)\n\n');
end

function fwt(file, text)
    fprintf(file, text);
    fprintf(file, "\n");
end

function file = fo()
    file = fopen("README/README.md", 'w+');
end




