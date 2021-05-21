function net = cnntrain(net, x, y, opts)  
    m = size(x, 3); % m ������� ѵ����������  %����Ӧ��60000��ѵ������
    numbatches = m / opts.batchsize;  %����Ӧ��batchsizeΪ50��numbatches =1200
    % rem: Remainder after division. rem(x,y) is x - n.*y �൱������  
    % rem(numbatches, 1) ���൱��ȡ��С�����֣����Ϊ0����������  
    if rem(numbatches, 1) ~= 0  %����ѵ���������Ƿ��ܱ�batchsize����
        error('numbatches not integer');  
 end  
      
    net.rL = [];  %����ʲô
    for i = 1 : opts.numepochs  %����Ӧ��opts.numepochs=10
        disp(['epoch ' num2str(i) '/' num2str(opts.numepochs)]);  %��չ��ӡ����ǰ���е���i��epoch
        % tic �� toc ��������ʱ�ģ��������������֮�����ĵ�ʱ��  
        tic;  
        % P = randperm(N) ����[1, N]֮������������һ����������У�����  
        % randperm(6) ���ܻ᷵�� [2 4 5 6 1 3]  
        % �������൱�ڰ�ԭ�����������д��ң�������һЩ������ѵ��  
        kk = randperm(m);  %ÿһ��epoch��Ҫ������ѵ���������������
        for l = 1 : numbatches %ÿ��batchѵ�������һ���������

disp(['batch ' num2str(l) '/' num2str(numbatches)]);  %��չ��ӡ����ǰ���е���l��batch
            batch_x = x(:, :, kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize));  %ÿ��ȡһ��batchsize��50����ͼ�����ͬ��ѵ��
            batch_y = y(:,    kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize));  
  
            net = cnnff(net, batch_x); % Feedforwardǰ�򴫵ݣ��ڵ�ǰ������Ȩֵ�����������¼�����������������ÿһ���������� 
 
            net = cnnbp(net, batch_y); % Backpropagation���򴫲����õ���ʧ���������������Ȩ�غ�ƫ�򣩵��ݶȣ�ƫ���� 
 net = cnnapplygrads(net, opts);  %������ʧ���������������Ȩ�غ�ƫ�򣩵��ݶȣ�ƫ�����������������

if isempty(net.rL)  
                net.rL(1) = net.L; % ���ۺ���ֵ��Ҳ�������ֵ��net.LΪ�����������1/2  
            end  
            net.rL(end + 1) = 0.99 * net.rL(end) + 0.01 * net.L; % ������ʷ�����ֵ���Ա㻭ͼ������Ϊʲô���ñ�����͵ķ�ʽ��  
        end  
        toc;  %��ӡÿ��epochִ��ʱ��
    end  
      
end 
