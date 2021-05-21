function net = cnnff(net, x)  
    n = numel(net.layers); % ����  
    net.layers{1}.a{1} = x; % ����ĵ�һ��������룬������batchsize��ѵ��ͼ�񣬲���ѵ��
    inputmaps = 1; % �����ֻ��һ������map��Ҳ���������һ��ͼ����Ȼʵ��������batchsize��ѵ��ͼ�������ǲ������㣬���Կ������Ϊһ������ֻ��һ��ͼ��  
  
    for l = 2 : n   %  ��������������֮���ÿһ����д���  
        if strcmp(net.layers{l}.type, 'c') % �����  
            %  !!below can probably be handled by insane matrix operations  
            % ��ÿһ������map������˵������Ҫ��outputmaps����ͬ�ľ����ȥ���ͼ��  
 for j = 1 : net.layers{l}.outputmaps   %  for each output map   %��һ�������6��outputmaps,�ڶ��������12��outputmaps
                %  create temp output map  
                % ����һ���ÿһ������map������������map�Ĵ�С����   
                % ������map�� - ����˵Ŀ� + 1��* ������map�� - ����˸� + 1��  
                % ��������Ĳ㣬��Ϊÿ�㶼������������map����Ӧ������������ÿ��map�ĵ���ά  
                % ���ԣ������z����ľ��Ǹò������е�����map��  
                z = zeros(size(net.layers{l - 1}.a{1}) - [net.layers{l}.kernelsize - 1 net.layers{l}.kernelsize - 1 0]);  %��ʼl���������map����һ�������map��sizeΪ[28 28 50]-[4��4��0]=[24 24 50],����άΪbatchsize

for i = 1 : inputmaps   %  for each input map ÿ������˶�����inputmaps���о������ͣ��õ�һ���þ���˶�Ӧ��outputmap
                    %  convolve with corresponding kernel and add to temp output map  
                    % ����һ���ÿһ������map��Ҳ������������map����ò�ľ���˽��о��  
                    % Ȼ�󽫶���һ������map�����н����������Ҳ����˵����ǰ���һ������map����  
                    % ��һ�־����ȥ�����һ�������е�����map��Ȼ����������map��Ӧλ�õľ��ֵ�ĺ�  
                    % ���⣬��Щ���Ļ���ʵ��Ӧ���У���������ȫ��������map���ӵģ��п���ֻ�����е�ĳ��������
z = z + convn(net.layers{l - 1}.a{i}, net.layers{l}.k{i}{j}, 'valid');   % k{i}{j}Ϊ����ˣ���һ�������õ���z��sizeΪ[24 24 50]
                end  
                %  add bias, pass through nonlinearity  
                % ���϶�Ӧλ�õĻ�b��Ȼ������sigmoid�����������map��ÿ��λ�õļ���ֵ����Ϊ�ò��������map  
                net.layers{l}.a{j} = sigm(z + net.layers{l}.b{j});  
            end  
            %  set number of input maps to this layers number of outputmaps  
            inputmaps = net.layers{l}.outputmaps; 
  elseif strcmp(net.layers{l}.type, 's') % �²����㣬���þ�ֵ�����²������²������޼�������  
            for j = 1 : inputmaps  
                %  !! replace with variable  



% ��������Ҫ��scale=2��������ִ��mean pooling����ô���Ծ����СΪ2*2��ÿ��Ԫ�ض���1/4�ľ����  
                z = convn(net.layers{l - 1}.a{j}, ones(net.layers{l}.scale) / (net.layers{l}.scale ^ 2), 'valid');   
                % ��Ϊconvn������Ĭ�Ͼ������Ϊ1����pooling����������û���ص��ģ����Զ�������ľ�����  
                % ����pooling�Ľ����Ҫ������õ��ľ���������scale=2Ϊ���������Ű�mean pooling��ֵ������  
                net.layers{l}.a{j} = z(1 : net.layers{l}.scale : end, 1 : net.layers{l}.scale : end, :);  
            end  
        end  
    end  

%���½��������Ĵ����������ǰһ����ȫ���ӡ�
%�����10����Ԫ���ֱ����10��ͼ��
%������ǰһ����Ԫ����Ϊ��������map���ص�ĺͣ�Ҳ����ÿ�����ص㶼��һ����Ԫ
    %  concatenate all end layer feature maps into vector   
    net.fv = [];  %���reshape��������ǰһ�������map����������mapһ��
    for j = 1 : numel(net.layers{n}.a) % �����ǰһ�������map�ĸ���  %��Ӧ��Ϊ12��
        sa = size(net.layers{n}.a{j}); % ��j������map�Ĵ�С %����batchsizeΪ[4 4 50]
        % �����е�����map����һ��������������һά���Ƕ�Ӧ������������ÿ������һ�У�ÿ��Ϊ��Ӧ����������  
        net.fv = [net.fv; reshape(net.layers{n}.a{j}, sa(1) * sa(2), sa(3))];  %�����һ������map reshape�õ�����sizeΪ[16 50]
    end  %���õ���net.fv��sizeΪ[numel(net.layers{n}.a)*16  50],���������ǰһ�����������map����һ��������
    %  feedforward into output perceptrons  
    % ����������������ֵ��sigmoid(W*X + b)��ע����ͬʱ������batchsize�����������ֵ  
    net.o = sigm(net.ffW * net.fv + repmat(net.ffb, 1, size(net.fv, 2)));  %���ֵ��sizeΪ[10 50]��10Ϊ10���ϵ������50Ϊbatchsize
  
end
