%% myplot_RAC
% This function plots Rank-Abundance Curve. (each community well be presented in subplots, so cannot be embeded in subplot)
%
% depends on: [mycolor.m], [mysubplot.m]
%% *Syntax*
%   myplot_RAC(X)
%       X  :      matrix of size [n, p] ; n communities, p species
%
%  myplot_RAC(X, strs, strn, bigtitle, colorsheet, stylesheet)
%       strs :   string or cell array of strings, the name of the "species"
%                  default is {'spp 1', 'spp 2', ...}; will show as legends
%                  if input is str, will replace the 'spp' in the defult.
%       strn :   string or cell array of strings, the name of the "communities"
%                  default is {'Community 1', 'Community 2', ...}; will show
%                  as title; usage is similar to strs
%      bigtitle :the bigtitle, deafult is 'Rank-Abundance Curve'  
%      colorsheet : the color of each Species, ranked in the first row
%                        if input is only 1 
%      stylesheet : the style of each Species, ranked in the first row
function myplot_RAC(X, strs, strn, bigtitle, colorsheet, stylesheet)
[n, p] = size( X ); 
%% Defult names
if nargin <2 || isempty(strs)
    strs = 'spp';
end
if nargin <3 || isempty(strn)
    strn = 'Community';
end
if nargin <4 || isempty(bigtitle)
    bigtitle = 'Rank-Abundance Curve';
end
%% input names as string
if iscell(strs)
    legends =strs;
    if length( legends) < p
           warning('The number of species does not match with "strs" ');
    end
else
    for s = 1:p
        legends{s} = [strs, ' ', num2str(s)]; 
    end
end

if iscell(strn)
    if length(strn) == n
        titles =strn;
    else
        error('The number of communities does not match with "strn" ');
    end
else
    for c = 1:n
        titles{c} = [strn, ' ', num2str(c)]; 
    end
end
%% Default color
 temp = mycolor(-1) ;
if nargin <5 || isempty(colorsheet)
    colorsheet = temp([3:19, 21:26, 28, 30:39 ],:);   
    if p> 34
            error('number of species is too large; the default color only has 34 colors');
    end
end
[a, b] = size(colorsheet);
    if isvector(colorsheet) && b~=3 && isnumeric(colorsheet)
         colorsheet = temp(colorsheet, :);
    end
    if a == 1
        
        colorsheet = repmat(colorsheet, p, 1);
    end
if p > length(colorsheet)
    error('number of species is too large; the default color only has 34 colors');
end

%% Default style
if nargin <6 || isempty(stylesheet)
  stylesheet = {'o', 's','d','^','p','>','<', 'o', 's','d','^','p','>','<','o', 's','d','^','p','>','<',...
                         'o', 's','d','^','p','>','<', 'o', 's','d','^','p','>','<','o', 's','d','^','p','>','<'};
end
if ischar(stylesheet)
    sty = stylesheet; stylesheet =[];
    for i = 1:p
         stylesheet{i} = sty; 
    end
end

if length(stylesheet) < p
    st = stylesheet;
    warning('Input style will be recycled because number of species > number of style')
    while length(stylesheet) < p
       stylesheet = [stylesheet, st];
    end
end

%% The first row
figure
[B, I ] = sort( X( 1, : ), 'descend');

if n >1
    mysubplot(1, n+2, 0, bigtitle)
    mysubplot(1, n+2, 2, '', 0.3, 0.1)
end

for s = 1:p
        ranks = find(I==s);
        h = scatter(ranks , X(1, s) ,60, stylesheet{ranks},'Markeredgecolor','none','Markerfacecolor',colorsheet(s, :));   hold on %colorsheet(ranks,:)
    end
    myplot( 1:p, B , 'L', 1); hold on
     %   legend(legends{:})
        % replot so the symbles are on top
        for s = 1:p
            ranks = find(I==s);
            h = scatter(ranks , X(1, s) ,60, stylesheet{ranks},'Markeredgecolor','none','Markerfacecolor',colorsheet(s, :));   hold on %colorsheet(ranks,:)
        end
     axis([1 p 0 max(max(X))]) ;
      set(gca,'yscale','log'); %CP added this
     title(titles{1});
     ylabel('Abundance');xlabel('Rank')
%%  2~n
%X1 =  X( :, I ); % in the new matrix, row 1 is sorted
X1=X %CP this is modified
for i = 2:n
    mysubplot(1, n+2, i+1,  '', 0.3, 0.1)
    [y, id ] = sort(X1(i,:), 'descend'); 
      myplot( 1:p, y , 'L', 1);hold on
    for s = 1:p
        h = scatter( s, y(s) ,60, stylesheet{id(s)},'Markeredgecolor','none','Markerfacecolor',colorsheet(id(s), :));   hold on %CP before, was s, y(s), [...] colorsheet(id(s),:)
    end    
   box off
     axis([1 p 0 max(max(X))]) ;
     set(gca, 'ytick', '')
      set(gca,'yscale','log');  %CP added this
        title(titles{i})
        xlabel('Rank')
end