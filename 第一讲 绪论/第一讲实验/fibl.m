function fibl(n)  
    fn=[1,1];  %�½�һ�����У�������������ֵ
    for i=3:n
        fn=[fn,fn(i-2)+fn(i-1)]; %����ӵ���ֵ��������
    end
    plot(fn)  %��ͼ��