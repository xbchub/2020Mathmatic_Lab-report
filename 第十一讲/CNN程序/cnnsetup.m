function net = cnnsetup(net, x, y)  
    inputmaps = 1;  %ÿ��batch�е�����ͼƬ�������㣬��������������ͬ�ġ����Զ��������inputmaps=1�����������㣬inputmaps=��һ���outputmaps


    mapsize = size(squeeze(x(:, :, 1)));  %squeeze(x(:, :, 1))�൱��ȡ��һ��ͼ���������ٰѵ���ά�Ƴ����õ�һ��ͼ��size[28 28]
  
    for l = 1 : numel(net.layers)   %  layer  %��ÿһ��������б�������net.layers�������struct���͵�Ԫ�أ��˴�numel(net.layers)=5
        if strcmp(net.layers{l}.type, 's')  %�²����㣨Ҳ��pooling�㣩������ȡ�²������mapsize���ͳ�ʼƫ��
            mapsize = floor(mapsize / net.layers{l}.scale);  %�˴��²����Ĳ���stride=scale��
            for j = 1 : inputmaps  %�˴���Ӧ����outputmap������?����Pooling�㣬inputmaps=outputmaps
                net.layers{l}.b{j} = 0; % ��ƫ�ó�ʼ��Ϊ0  
            end  

end  %Pooling��û��Ȩ�ؾ����ʼ����
        if strcmp(net.layers{l}.type, 'c') %����㴦����ȡ��һ���mapsize��Ȩ�صĳ�ʼ����ƫ�õĳ�ʼ������һ���inputmaps
  % �ɵ�mapsize���������һ�������map�Ĵ�С����ô�������˵��ƶ�������1������  
            % kernelsize*kernelsize��С�ľ���˾����һ�������map�󣬵õ����µ�map�Ĵ�С������������  
            mapsize = mapsize - net.layers{l}.kernelsize + 1;  %�������strideΪ1�����
            % �ò���Ҫѧϰ�Ĳ���������ÿ������map��һ��(�������ͼ����)*(���������patchͼ�Ĵ�С)  
            % ��Ϊ��ͨ����һ���˴�������һ������map�����ƶ����˴���ÿ���ƶ�1�����أ���������һ������map  
            % ���ÿ����Ԫ���˴�����kernelsize*kernelsize��Ԫ����ɣ�ÿ��Ԫ����һ��������Ȩֵ������  
            % ����kernelsize*kernelsize����Ҫѧϰ��Ȩֵ���ټ�һ��ƫ��ֵ�����⣬������Ȩֵ����Ҳ����  
            % ˵ͬһ������map������ͬһ��������ͬȨֵԪ�ص�kernelsize*kernelsize�ĺ˴���ȥ����������һ  
            % ������map���ÿ����Ԫ�õ��ģ�����ͬһ������map������Ȩֵ��һ���ģ�����ģ�Ȩֵֻȡ����  
            % �˴��ڡ�Ȼ�󣬲�ͬ������map��ȡ������һ������map�㲻ͬ�����������Բ��õĺ˴��ڲ�һ����Ҳ  
            % ����Ȩֵ��һ��������outputmaps������map���У�kernelsize*kernelsize+1��* outputmaps��ô���Ȩֵ��  
            % ������fan_outֻ�������˵�ȨֵW��ƫ��b�������������  
            fan_out = net.layers{l}.outputmaps * net.layers{l}.kernelsize ^ 2;  %��������Ȩ�ز���������������Conv1��6*5*5=150������Conv2��12*5*5=300
for j = 1 : net.layers{l}.outputmaps  %  output map  %Conv1��6��Conv2��12
                % fan_out������Ƕ�����һ���һ������map��������һ����Ҫ����һ������map��ȡoutputmaps�������� ����Ҫ��Ȩ������ 
                % ��ȡÿ�������õ��ľ���˲�ͬ������fan_out���������һ������µ�������Ҫѧϰ�Ĳ�������  
                % ����fan_in������ǣ�������һ�㣬Ҫ���ӵ���һ�������е�����map��Ȼ����fan_out�������ȡ����  
                % ��Ȩֵ����ȡ���ǵ�������Ҳ���Ƕ���ÿһ����ǰ������ͼ���ж��ٸ���������ǰ��  
                fan_in = inputmaps * net.layers{l}.kernelsize ^ 2;  %ÿһ��inputmap����outputmaps���������ȡoutputmaps���������õ�outputmaps�������         ��ͬ��inputmap��Ӧ��ͬ�ľ����
                for i = 1 : inputmaps  %  input map  
                    % �����ʼ��Ȩֵ��Ҳ���ǹ���outputmaps������ˣ����ϲ��ÿ������map������Ҫ����ô��������  
                    % ȥ�����ȡ������  
                    % rand(n)�ǲ���n��n�� 0-1֮�����ȡֵ����ֵ�ľ����ټ�ȥ0.5���൱�ڲ���-0.5��0.5֮��������  
 % �� *2 �ͷŴ� [-1, 1]��Ȼ���ٳ��Ժ�����һ����why��  
                    % �������ǽ������ÿ��Ԫ�س�ʼ��Ϊ[-sqrt(6 / (fan_in + fan_out)), sqrt(6 / (fan_in + fan_out))]  
                    % ֮������������Ϊ������Ȩֵ����ģ�Ҳ���Ƕ���һ������map�����и���Ұλ�õľ���˶���һ����  
                    % ����ֻ��Ҫ������� inputmaps * outputmaps ������ˡ�  
                    net.layers{l}.k{i}{j} = (rand(net.layers{l}.kernelsize) - 0.5) * 2 * sqrt(6 / (fan_in + fan_out));  %ΪʲôҪ���Ժ��������
                end  
                net.layers{l}.b{j} = 0; % ��ƫ�ó�ʼ��Ϊ0  
            end  

% ֻ���ھ�����ʱ��Ż�ı�����map�ĸ�����pooling��ʱ�򲻻�ı������������������map��������  
            % ���뵽��һ�������map����  
            inputmaps = net.layers{l}.outputmaps;   
        end  
    end  
      %���濪ʼ��ʼ�����������������������ǰһ��֮����ȫ���ӡ�
    % ��һ�����һ���Ǿ���pooling��Ĳ㣬������inputmaps������map��ÿ������map�Ĵ�С��mapsize��  
    % ���ԣ��ò����Ԫ������ inputmaps * ��ÿ������map�Ĵ�С��  
    % For vectors, prod(X) ��XԪ�ص����˻�  
    fvnum = prod(mapsize) * inputmaps;  %�����ǰһ�����Ԫ��������������Ŀ 5*5*12=300
 % onum �Ǳ�ǩ�ĸ�����Ҳ�����������Ԫ�ĸ�������Ҫ�ֶ��ٸ��࣬��Ȼ���ж��ٸ������Ԫ  
    onum = size(y, 1);  % yΪ10*60000�ľ���10��ʾ10�����60000��ʾѵ��ͼ��ĸ��������һ��ͼ��Ϊ1����y(:,1)=[0 1 0 0 0 0 0 0 0 0]
   
net.ffb = zeros(onum, 1);  %��ʼ��������ƫ��bΪ0
    net.ffW = (rand(onum, fvnum) - 0.5) * 2 * sqrt(6 / (onum + fvnum));  %��ʼ���������ǰһ���Ȩ�ؾ���Ϊȫ���Ӳ�FC��sizeΪ[10 300]
end  

