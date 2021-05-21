function net = cnnff(net, x)  
    n = numel(net.layers); % 层数  
    net.layers{1}.a{1} = x; % 网络的第一层就是输入，包含了batchsize个训练图像，并行训练
    inputmaps = 1; % 输入层只有一个特征map，也就是输入的一张图像，虽然实际输入是batchsize个训练图像，由于是并行运算，所以可以理解为一条线上只有一张图像  
  
    for l = 2 : n   %  对输入层与输出层之间的每一层进行处理  
        if strcmp(net.layers{l}.type, 'c') % 卷积层  
            %  !!below can probably be handled by insane matrix operations  
            % 对每一个输入map，或者说我们需要用outputmaps个不同的卷积核去卷积图像  
 for j = 1 : net.layers{l}.outputmaps   %  for each output map   %第一个卷积层6个outputmaps,第二个卷积层12个outputmaps
                %  create temp output map  
                % 对上一层的每一张特征map，卷积后的特征map的大小就是   
                % （输入map宽 - 卷积核的宽 + 1）* （输入map高 - 卷积核高 + 1）  
                % 对于这里的层，因为每层都包含多张特征map，对应的索引保存在每层map的第三维  
                % 所以，这里的z保存的就是该层中所有的特征map了  
                z = zeros(size(net.layers{l - 1}.a{1}) - [net.layers{l}.kernelsize - 1 net.layers{l}.kernelsize - 1 0]);  %初始l层输出特征map，第一个卷积层map的size为[28 28 50]-[4，4，0]=[24 24 50],第三维为batchsize

for i = 1 : inputmaps   %  for each input map 每个卷积核对所有inputmaps进行卷积后，求和，得到一个该卷积核对应的outputmap
                    %  convolve with corresponding kernel and add to temp output map  
                    % 将上一层的每一个特征map（也就是这层的输入map）与该层的卷积核进行卷积  
                    % 然后将对上一层特征map的所有结果加起来。也就是说，当前层的一张特征map，是  
                    % 用一种卷积核去卷积上一层中所有的特征map，然后所有特征map对应位置的卷积值的和  
                    % 另外，有些论文或者实际应用中，并不是与全部的特征map链接的，有可能只与其中的某几个连接
z = z + convn(net.layers{l - 1}.a{i}, net.layers{l}.k{i}{j}, 'valid');   % k{i}{j}为卷积核，第一个卷积层得到的z的size为[24 24 50]
                end  
                %  add bias, pass through nonlinearity  
                % 加上对应位置的基b，然后再用sigmoid函数算出特征map中每个位置的激活值，作为该层输出特征map  
                net.layers{l}.a{j} = sigm(z + net.layers{l}.b{j});  
            end  
            %  set number of input maps to this layers number of outputmaps  
            inputmaps = net.layers{l}.outputmaps; 
  elseif strcmp(net.layers{l}.type, 's') % 下采样层，采用均值进行下采样，下采样层无激励函数  
            for j = 1 : inputmaps  
                %  !! replace with variable  



% 例如我们要在scale=2的域上面执行mean pooling，那么可以卷积大小为2*2，每个元素都是1/4的卷积核  
                z = convn(net.layers{l - 1}.a{j}, ones(net.layers{l}.scale) / (net.layers{l}.scale ^ 2), 'valid');   
                % 因为convn函数的默认卷积步长为1，而pooling操作的域是没有重叠的，所以对于上面的卷积结果  
                % 最终pooling的结果需要从上面得到的卷积结果中以scale=2为步长，跳着把mean pooling的值读出来  
                net.layers{l}.a{j} = z(1 : net.layers{l}.scale : end, 1 : net.layers{l}.scale : end, :);  
            end  
        end  
    end  

%以下进行输出层的处理，输出层与前一层是全连接。
%输出层10个神经元，分别代表10类图像。
%输出层的前一层神经元个数为所有特征map像素点的和，也就是每个像素点都是一个神经元
    %  concatenate all end layer feature maps into vector   
    net.fv = [];  %存放reshape后的输出层前一层的特征map（所有特征map一起）
    for j = 1 : numel(net.layers{n}.a) % 输出层前一层的特征map的个数  %此应用为12个
        sa = size(net.layers{n}.a{j}); % 第j个特征map的大小 %考虑batchsize为[4 4 50]
        % 将所有的特征map拉成一条列向量。还有一维就是对应的样本索引。每个样本一列，每列为对应的特征向量  
        net.fv = [net.fv; reshape(net.layers{n}.a{j}, sa(1) * sa(2), sa(3))];  %由最后一层特征map reshape得到，其size为[16 50]
    end  %最后得到的net.fv的size为[numel(net.layers{n}.a)*16  50],即把输出层前一层的所有特征map拉成一条列向量
    %  feedforward into output perceptrons  
    % 计算网络的最终输出值。sigmoid(W*X + b)，注意是同时计算了batchsize个样本的输出值  
    net.o = sigm(net.ffW * net.fv + repmat(net.ffb, 1, size(net.fv, 2)));  %输出值的size为[10 50]，10为10类上的输出，50为batchsize
  
end
