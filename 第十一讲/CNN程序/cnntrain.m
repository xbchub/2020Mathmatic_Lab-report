function net = cnntrain(net, x, y, opts)  
    m = size(x, 3); % m 保存的是 训练样本个数  %本次应用60000个训练样本
    numbatches = m / opts.batchsize;  %本次应用batchsize为50，numbatches =1200
    % rem: Remainder after division. rem(x,y) is x - n.*y 相当于求余  
    % rem(numbatches, 1) 就相当于取其小数部分，如果为0，就是整数  
    if rem(numbatches, 1) ~= 0  %检验训练样本数是否能被batchsize整除
        error('numbatches not integer');  
 end  
      
    net.rL = [];  %这是什么
    for i = 1 : opts.numepochs  %本次应用opts.numepochs=10
        disp(['epoch ' num2str(i) '/' num2str(opts.numepochs)]);  %进展打印，当前运行到第i个epoch
        % tic 和 toc 是用来计时的，计算这两条语句之间所耗的时间  
        tic;  
        % P = randperm(N) 返回[1, N]之间所有整数的一个随机的序列，例如  
        % randperm(6) 可能会返回 [2 4 5 6 1 3]  
        % 这样就相当于把原来的样本排列打乱，再挑出一些样本来训练  
        kk = randperm(m);  %每一轮epoch都要将所有训练集进行随机打乱
        for l = 1 : numbatches %每个batch训练后更新一次网络参数

disp(['batch ' num2str(l) '/' num2str(numbatches)]);  %进展打印，当前运行到第l个batch
            batch_x = x(:, :, kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize));  %每次取一个batchsize（50）张图像进行同步训练
            batch_y = y(:,    kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize));  
  
            net = cnnff(net, batch_x); % Feedforward前向传递，在当前的网络权值和网络输入下计算网络的输出，包涵每一层的输入输出 
 
            net = cnnbp(net, batch_y); % Backpropagation反向传播，得到损失函数对网络参数（权重和偏向）的梯度（偏导） 
 net = cnnapplygrads(net, opts);  %根据损失函数对网络参数（权重和偏向）的梯度（偏导），更新网络参数

if isempty(net.rL)  
                net.rL(1) = net.L; % 代价函数值，也就是误差值，net.L为网络均方误差的1/2  
            end  
            net.rL(end + 1) = 0.99 * net.rL(end) + 0.01 * net.L; % 保存历史的误差值，以便画图分析，为什么采用比例求和的方式？  
        end  
        toc;  %打印每个epoch执行时间
    end  
      
end 
