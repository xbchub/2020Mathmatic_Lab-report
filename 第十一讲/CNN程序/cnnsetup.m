function net = cnnsetup(net, x, y)  
    inputmaps = 1;  %每个batch中的所有图片并行运算，但处理方法都是相同的。所以对于输入层inputmaps=1，对于其他层，inputmaps=上一层的outputmaps


    mapsize = size(squeeze(x(:, :, 1)));  %squeeze(x(:, :, 1))相当于取第一个图像样本后，再把第三维移除，得到一张图象size[28 28]
  
    for l = 1 : numel(net.layers)   %  layer  %对每一层网络进行遍历处理，net.layers中有五个struct类型的元素，此处numel(net.layers)=5
        if strcmp(net.layers{l}.type, 's')  %下采样层（也叫pooling层）处理，获取下采样后的mapsize，和初始偏置
            mapsize = floor(mapsize / net.layers{l}.scale);  %此处下采样的步长stride=scale，
            for j = 1 : inputmaps  %此处不应该是outputmap的数吗?对于Pooling层，inputmaps=outputmaps
                net.layers{l}.b{j} = 0; % 将偏置初始化为0  
            end  

end  %Pooling层没有权重矩阵初始化？
        if strcmp(net.layers{l}.type, 'c') %卷积层处理，获取下一层的mapsize，权重的初始化和偏置的初始化，下一层的inputmaps
  % 旧的mapsize保存的是上一层的特征map的大小，那么如果卷积核的移动步长是1，那用  
            % kernelsize*kernelsize大小的卷积核卷积上一层的特征map后，得到的新的map的大小就是下面这样  
            mapsize = mapsize - net.layers{l}.kernelsize + 1;  %卷积步长stride为1的情况
            % 该层需要学习的参数个数。每张特征map是一个(后层特征图数量)*(用来卷积的patch图的大小)  
            % 因为是通过用一个核窗口在上一个特征map层中移动（核窗口每次移动1个像素），遍历上一个特征map  
            % 层的每个神经元。核窗口由kernelsize*kernelsize个元素组成，每个元素是一个独立的权值，所以  
            % 就有kernelsize*kernelsize个需要学习的权值，再加一个偏置值。另外，由于是权值共享，也就是  
            % 说同一个特征map层是用同一个具有相同权值元素的kernelsize*kernelsize的核窗口去感受输入上一  
            % 个特征map层的每个神经元得到的，所以同一个特征map，它的权值是一样的，共享的，权值只取决于  
            % 核窗口。然后，不同的特征map提取输入上一个特征map层不同的特征，所以采用的核窗口不一样，也  
            % 就是权值不一样，所以outputmaps个特征map就有（kernelsize*kernelsize+1）* outputmaps那么多的权值了  
            % 但这里fan_out只保存卷积核的权值W，偏置b在下面独立保存  
            fan_out = net.layers{l}.outputmaps * net.layers{l}.kernelsize ^ 2;  %计算卷积核权重参数的总数，对于Conv1：6*5*5=150，对于Conv2：12*5*5=300
for j = 1 : net.layers{l}.outputmaps  %  output map  %Conv1：6；Conv2：12
                % fan_out保存的是对于上一层的一张特征map，我在这一层需要对这一张特征map提取outputmaps种特征， 所需要的权重总数 
                % 提取每种特征用到的卷积核不同，所以fan_out保存的是这一层输出新的特征需要学习的参数个数  
                % 而，fan_in保存的是，我在这一层，要连接到上一层中所有的特征map，然后用fan_out保存的提取特征  
                % 的权值来提取他们的特征。也即是对于每一个当前层特征图，有多少个参数链到前层  
                fan_in = inputmaps * net.layers{l}.kernelsize ^ 2;  %每一个inputmap经过outputmaps个卷积核提取outputmaps种特征，得到outputmaps个输出。         不同的inputmap对应不同的卷积核
                for i = 1 : inputmaps  %  input map  
                    % 随机初始化权值，也就是共有outputmaps个卷积核，对上层的每个特征map，都需要用这么多个卷积核  
                    % 去卷积提取特征。  
                    % rand(n)是产生n×n的 0-1之间均匀取值的数值的矩阵，再减去0.5就相当于产生-0.5到0.5之间的随机数  
 % 再 *2 就放大到 [-1, 1]。然后再乘以后面那一数，why？  
                    % 反正就是将卷积核每个元素初始化为[-sqrt(6 / (fan_in + fan_out)), sqrt(6 / (fan_in + fan_out))]  
                    % 之间的随机数。因为这里是权值共享的，也就是对于一张特征map，所有感受野位置的卷积核都是一样的  
                    % 所以只需要保存的是 inputmaps * outputmaps 个卷积核。  
                    net.layers{l}.k{i}{j} = (rand(net.layers{l}.kernelsize) - 0.5) * 2 * sqrt(6 / (fan_in + fan_out));  %为什么要乘以后面的数？
                end  
                net.layers{l}.b{j} = 0; % 将偏置初始化为0  
            end  

% 只有在卷积层的时候才会改变特征map的个数，pooling的时候不会改变个数。这层输出的特征map个数就是  
            % 输入到下一层的特征map个数  
            inputmaps = net.layers{l}.outputmaps;   
        end  
    end  
      %下面开始初始化输出层网络参数。输出层与前一层之间是全连接。
    % 这一层的上一层是经过pooling后的层，包含有inputmaps个特征map。每个特征map的大小是mapsize。  
    % 所以，该层的神经元个数是 inputmaps * （每个特征map的大小）  
    % For vectors, prod(X) 是X元素的连乘积  
    fvnum = prod(mapsize) * inputmaps;  %输出层前一层的神经元个数，即像素数目 5*5*12=300
 % onum 是标签的个数，也就是输出层神经元的个数。你要分多少个类，自然就有多少个输出神经元  
    onum = size(y, 1);  % y为10*60000的矩阵，10表示10个类别，60000表示训练图像的个数，如第一张图像为1，则y(:,1)=[0 1 0 0 0 0 0 0 0 0]
   
net.ffb = zeros(onum, 1);  %初始化输出层的偏向b为0
    net.ffW = (rand(onum, fvnum) - 0.5) * 2 * sqrt(6 / (onum + fvnum));  %初始化输出层与前一层的权重矩阵，为全连接层FC，size为[10 300]
end  

