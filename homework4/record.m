recObj = audiorecorder;  % Ĭ�ϣ������� ��������fs = 8000bps , ��������nbits = 8bit 
recordblocking( recObj, 5) %¼��5���� 
play(recObj);  %�������� 
y = getaudiodata(recObj); 
plot(y);
%audiowrite('¼��1_ѧ��_2018-7-10.wav',y,8000);
%audiowrite('¼��2_matlab_2018-7-10.wav',y,8000);
audiowrite('¼��3_12345_2018-7-10.wav',y,8000);