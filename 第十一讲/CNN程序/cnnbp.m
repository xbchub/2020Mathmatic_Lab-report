function net = cnnbp(net, y)  
    n = numel(net.layers); % 网络层数 %5 
    net.e = net.o - y;   %计算网络运算输出与实际分类之间的偏差，size为[10 50]
    %  loss function  
    net.L = 1/2* sum(net.e(:) .^ 2) / size(net.e, 2);  %方差损失函数，为了方便求导取了1/2。将一个batch内的所有图像偏差一起计算并取均值
  
    %%  backprop deltas  
    net.od = net.e .* (net.o .* (1 - net.o));   %  输出层的梯度  net.e为损失函数对net.o的导数，(net.o .* (1 - net.o))为sigmoid输出对输入的导数,size[10 50]
    % 残差 反向传播回 前一层  
    net.fvd = (net.ffW' * net.od);              %  feature vector delta  %输出层前一层的梯度，是下采样层，f(x)=x，没有sigmoid激励函数,size [16*12 50]
    if strcmp(net.layers{n}.type, 'c')         %  only conv layers has sigm function  
        net.fvd = net.fvd .* (net.fv .* (1 - net.fv)); %如果是卷积层，有sigmoid激励函数，需要追加乘上sigmoid的导数 ,size [16*12 50]
    end  
 %  reshape feature vector deltas into output map style  
    sa = size(net.layers{n}.a{1}); % 最后一层特征map的大小。这里的最后一层都是指输出层的前一层  
    fvnum = sa(1) * sa(2); % 因为是将最后一层特征map拉成一条向量，所以对于一个样本来说，特征维数是这样  
    for j = 1 : numel(net.layers{n}.a) % 最后一层的特征map的个数  
        % 在fvd里面保存的是所有样本的特征向量（在cnnff.m函数中用特征map拉成的），所以这里需要重新  
        % 变换回来特征map的形式。d 保存的是 delta，也就是 灵敏度 或者 残差 
net.layers{n}.d{j} = reshape(net.fvd(((j - 1) * fvnum + 1) : j * fvnum, :), sa(1), sa(2), sa(3));  
    end  
 % 对于 输出层前面的层（与输出层计算残差的方式不同）  
    for l = (n - 1) : -1 : 1  
        if strcmp(net.layers{l}.type, 'c')  
            for j = 1 : numel(net.layers{l}.a) % 该层特征map的个数  
                % net.layers{l}.d{j} 保存的是 第l层 的 第j个 map 的 灵敏度map。 也就是每个神经元节点的delta的值  
                for k = 1:size(net.layers{l + 1}.d{j}, 3)  
                    net.layers{l}.d{j}(:,:,k) = net.layers{l}.a{j}(:,:,k) .* (1 - net.layers{l}.a{j}(:,:,k)) .*  kron(net.layers{l + 1}.d{j}(:,:,k), ones(net.layers{l + 1}.scale)) / net.layers{l + 1}.scale ^ 2;  
                end  
%                 net.layers{l}.d{j} = net.layers{l}.a{j} .* (1 - net.layers{l}.a{j}) .* (expand(net.layers{l + 1}.d{j}, [net.layers{l + 1}.scale net.layers{l + 1}.scale 1]) / net.layers{l + 1}.scale ^ 2);  %卷积层input和output map数不一定相等，因此需要expand处理。expand(matrix(4*4*50),[2 2 1])/4    size为[8*8*50]
            end  
elseif strcmp(net.layers{l}.type, 's')  
            for i = 1 : numel(net.layers{l}.a) % 第l层特征map的个数  
                z = zeros(size(net.layers{l}.a{1})); 

for j = 1 : numel(net.layers{l + 1}.a) % 第l+1层特征map的个数  
                     z = z + convn(net.layers{l + 1}.d{j}, rot180(net.layers{l + 1}.k{i}{j}), 'full');  %下采样层f(x)=x,导数为1
                end  
                net.layers{l}.d{i} = z;  %得到下采样层的梯度
            end  
        end  
    end  
%%  calc gradients  
    % 这里与 Notes on Convolutional Neural Networks 中不同，这里的 子采样 层没有参数，也没有  
    % 激活函数，所以在子采样层是没有需要求解的参数的  
    for l = 2 : n  
        if strcmp(net.layers{l}.type, 'c')  
            for j = 1 : numel(net.layers{l}.a)  
                for i = 1 : numel(net.layers{l - 1}.a)  
                    % dk 保存的是 误差对卷积核 的导数  
                    net.layers{l}.dk{i}{j} = convn(flipall(net.layers{l - 1}.a{i}), net.layers{l}.d{j}, 'valid') / size(net.layers{l}.d{j}, 3);  %除去batchsize，得到delta_W
                end  
                % db 保存的是 误差对于bias基 的导数  

net.layers{l}.db{j} = sum(net.layers{l}.d{j}(:)) / size(net.layers{l}.d{j}, 3);  
            end  
        end  
    end  
% 最后一层perceptron的gradient的计算  
    net.dffW = net.od * (net.fv)' / size(net.od, 2);  
    net.dffb = mean(net.od, 2);  
