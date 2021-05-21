function net = cnnbp(net, y)  
    n = numel(net.layers); % ������� %5 
    net.e = net.o - y;   %�����������������ʵ�ʷ���֮���ƫ�sizeΪ[10 50]
    %  loss function  
    net.L = 1/2* sum(net.e(:) .^ 2) / size(net.e, 2);  %������ʧ������Ϊ�˷�����ȡ��1/2����һ��batch�ڵ�����ͼ��ƫ��һ����㲢ȡ��ֵ
  
    %%  backprop deltas  
    net.od = net.e .* (net.o .* (1 - net.o));   %  �������ݶ�  net.eΪ��ʧ������net.o�ĵ�����(net.o .* (1 - net.o))Ϊsigmoid���������ĵ���,size[10 50]
    % �в� ���򴫲��� ǰһ��  
    net.fvd = (net.ffW' * net.od);              %  feature vector delta  %�����ǰһ����ݶȣ����²����㣬f(x)=x��û��sigmoid��������,size [16*12 50]
    if strcmp(net.layers{n}.type, 'c')         %  only conv layers has sigm function  
        net.fvd = net.fvd .* (net.fv .* (1 - net.fv)); %����Ǿ���㣬��sigmoid������������Ҫ׷�ӳ���sigmoid�ĵ��� ,size [16*12 50]
    end  
 %  reshape feature vector deltas into output map style  
    sa = size(net.layers{n}.a{1}); % ���һ������map�Ĵ�С����������һ�㶼��ָ������ǰһ��  
    fvnum = sa(1) * sa(2); % ��Ϊ�ǽ����һ������map����һ�����������Զ���һ��������˵������ά��������  
    for j = 1 : numel(net.layers{n}.a) % ���һ�������map�ĸ���  
        % ��fvd���汣���������������������������cnnff.m������������map���ɵģ�������������Ҫ����  
        % �任��������map����ʽ��d ������� delta��Ҳ���� ������ ���� �в� 
net.layers{n}.d{j} = reshape(net.fvd(((j - 1) * fvnum + 1) : j * fvnum, :), sa(1), sa(2), sa(3));  
    end  
 % ���� �����ǰ��Ĳ㣨����������в�ķ�ʽ��ͬ��  
    for l = (n - 1) : -1 : 1  
        if strcmp(net.layers{l}.type, 'c')  
            for j = 1 : numel(net.layers{l}.a) % �ò�����map�ĸ���  
                % net.layers{l}.d{j} ������� ��l�� �� ��j�� map �� ������map�� Ҳ����ÿ����Ԫ�ڵ��delta��ֵ  
                for k = 1:size(net.layers{l + 1}.d{j}, 3)  
                    net.layers{l}.d{j}(:,:,k) = net.layers{l}.a{j}(:,:,k) .* (1 - net.layers{l}.a{j}(:,:,k)) .*  kron(net.layers{l + 1}.d{j}(:,:,k), ones(net.layers{l + 1}.scale)) / net.layers{l + 1}.scale ^ 2;  
                end  
%                 net.layers{l}.d{j} = net.layers{l}.a{j} .* (1 - net.layers{l}.a{j}) .* (expand(net.layers{l + 1}.d{j}, [net.layers{l + 1}.scale net.layers{l + 1}.scale 1]) / net.layers{l + 1}.scale ^ 2);  %�����input��output map����һ����ȣ������Ҫexpand����expand(matrix(4*4*50),[2 2 1])/4    sizeΪ[8*8*50]
            end  
elseif strcmp(net.layers{l}.type, 's')  
            for i = 1 : numel(net.layers{l}.a) % ��l������map�ĸ���  
                z = zeros(size(net.layers{l}.a{1})); 

for j = 1 : numel(net.layers{l + 1}.a) % ��l+1������map�ĸ���  
                     z = z + convn(net.layers{l + 1}.d{j}, rot180(net.layers{l + 1}.k{i}{j}), 'full');  %�²�����f(x)=x,����Ϊ1
                end  
                net.layers{l}.d{i} = z;  %�õ��²�������ݶ�
            end  
        end  
    end  
%%  calc gradients  
    % ������ Notes on Convolutional Neural Networks �в�ͬ������� �Ӳ��� ��û�в�����Ҳû��  
    % ��������������Ӳ�������û����Ҫ���Ĳ�����  
    for l = 2 : n  
        if strcmp(net.layers{l}.type, 'c')  
            for j = 1 : numel(net.layers{l}.a)  
                for i = 1 : numel(net.layers{l - 1}.a)  
                    % dk ������� ���Ծ���� �ĵ���  
                    net.layers{l}.dk{i}{j} = convn(flipall(net.layers{l - 1}.a{i}), net.layers{l}.d{j}, 'valid') / size(net.layers{l}.d{j}, 3);  %��ȥbatchsize���õ�delta_W
                end  
                % db ������� ������bias�� �ĵ���  

net.layers{l}.db{j} = sum(net.layers{l}.d{j}(:)) / size(net.layers{l}.d{j}, 3);  
            end  
        end  
    end  
% ���һ��perceptron��gradient�ļ���  
    net.dffW = net.od * (net.fv)' / size(net.od, 2);  
    net.dffb = mean(net.od, 2);  
