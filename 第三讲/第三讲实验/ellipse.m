a=0;
b=0;
h_text1=uicontrol('Style','text','String','a','Position',[50 20 50 20]);
h_text1=uicontrol('Style','text','String','b','Position',[50 0 50 20]);
ezplot(strcat('x+',num2str(a),'*y'));
h_slider1=uicontrol('Style','slider','Position',[100 20 200 20],...
'Max',10,'Min',-10,'callback',['a=num2str(get(gcbo,''value''));',...
'ezplot(strcat(num2str(b),''+x^3+'',num2str(a),''*x-y^2''))']);
h_slider2=uicontrol('Style','slider','Position',[100 0 200 20],...
'Max',10,'Min',-10,'callback',['b=num2str(get(gcbo,''value''));',...
'ezplot(strcat(num2str(b),''+x^3+'',num2str(a),''*x-y^2''))']);
