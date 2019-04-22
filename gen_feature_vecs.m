% Chris Martin speech
input_dir1 = '../id10157/';
input_file1 = '31g1Oo0Ih-A/00001.wav';
input_file2 = '31g1Oo0Ih-A/00002.wav';
input_file3 = '31g1Oo0Ih-A/00004.wav';
input_file4 = 'dATog1S1tIw/00004.wav';
input_file5 = 'dATog1S1tIw/00009.wav';
input_file6 = 'TdhfxAIWANo/00004.wav';

% Cillian Murphy speech
input_dir2 = '../id10166/';
input_file21 = '8h57d48MzGw/00004.wav';
input_file22 = '8h57d48MzGw/00010.wav';
input_file23 = '8h57d48MzGw/00006.wav';
input_file24 = 'OAuxOGYc8rU/00002.wav';
input_file25 = 'OAuxOGYc8rU/00003.wav';
input_file26 = 'OAuxOGYc8rU/00004.wav';

% Tilda Swinton speech
input_dir3 = '../id11169/';
input_file31 = 'a8dGuQZodtw/00002.wav';
input_file32 = 'a8dGuQZodtw/00003.wav';
input_file33 = 'a8dGuQZodtw/00004.wav';
input_file34 = 'tllp-2fqq1Y/00005.wav';
input_file35 = 'tllp-2fqq1Y/00008.wav';

% Jesse Eisenberg speech
input_dir4 = '../id10490/';
input_file41 = 'ulWgb-KmVeg/00005.wav'; 


[chris1.sound, chris1.fs] = audioread([input_dir1 input_file1]);
[chris2.sound, chris2.fs] = audioread([input_dir1 input_file2]);
[chris3.sound, chris3.fs] = audioread([input_dir1 input_file3]);
[chris4.sound, chris4.fs] = audioread([input_dir1 input_file4]);
[chris5.sound, chris5.fs] = audioread([input_dir1 input_file5]);
[chris6.sound, chris6.fs] = audioread([input_dir1 input_file6]);

[cillian1.sound, cillian1.fs] = audioread([input_dir2 input_file21]);
[cillian2.sound, cillian2.fs] = audioread([input_dir2 input_file22]);
[cillian3.sound, cillian3.fs] = audioread([input_dir2 input_file23]);
[cillian4.sound, cillian4.fs] = audioread([input_dir2 input_file24]);
[cillian5.sound, cillian5.fs] = audioread([input_dir2 input_file25]);
[cillian6.sound, cillian6.fs] = audioread([input_dir2 input_file26]);

[tilda1.sound, tilda1.fs] = audioread([input_dir3 input_file31]);
[tilda2.sound, tilda2.fs] = audioread([input_dir3 input_file32]);
[tilda3.sound, tilda3.fs] = audioread([input_dir3 input_file33]);
[tilda4.sound, tilda4.fs] = audioread([input_dir3 input_file34]);
[tilda5.sound, tilda5.fs] = audioread([input_dir3 input_file35]);

[jesse1.sound, jesse1.fs] = audioread([input_dir4 input_file41]);

% duration in seconds
win_duration = 30e-3;
overlap_duration = 10e-3;
% number of windows in mel filterbank
smooth_nwin = 20;
% number of cepstrum coefficients
ncepstrum = 200;

chris1 = cepstral_analysis(chris1, win_duration, overlap_duration, smooth_nwin, ncepstrum);
chris2 = cepstral_analysis(chris2, win_duration, overlap_duration, smooth_nwin, ncepstrum);
chris3 = cepstral_analysis(chris3, win_duration, overlap_duration, smooth_nwin, ncepstrum);
chris4 = cepstral_analysis(chris4, win_duration, overlap_duration, smooth_nwin, ncepstrum);
chris5 = cepstral_analysis(chris5, win_duration, overlap_duration, smooth_nwin, ncepstrum);
chris6 = cepstral_analysis(chris5, win_duration, overlap_duration, smooth_nwin, ncepstrum);

cillian1 = cepstral_analysis(cillian1, win_duration, overlap_duration, smooth_nwin, ncepstrum);
cillian2 = cepstral_analysis(cillian2, win_duration, overlap_duration, smooth_nwin, ncepstrum);
cillian3 = cepstral_analysis(cillian3, win_duration, overlap_duration, smooth_nwin, ncepstrum);
cillian4 = cepstral_analysis(cillian4, win_duration, overlap_duration, smooth_nwin, ncepstrum);
cillian5 = cepstral_analysis(cillian5, win_duration, overlap_duration, smooth_nwin, ncepstrum);
cillian6 = cepstral_analysis(cillian6, win_duration, overlap_duration, smooth_nwin, ncepstrum);

tilda1 = cepstral_analysis(tilda1, win_duration, overlap_duration, smooth_nwin, ncepstrum);
tilda2 = cepstral_analysis(tilda2, win_duration, overlap_duration, smooth_nwin, ncepstrum);
tilda3 = cepstral_analysis(tilda3, win_duration, overlap_duration, smooth_nwin, ncepstrum);
tilda4 = cepstral_analysis(tilda4, win_duration, overlap_duration, smooth_nwin, ncepstrum);
tilda5 = cepstral_analysis(tilda5, win_duration, overlap_duration, smooth_nwin, ncepstrum);

jesse1 = cepstral_analysis(jesse1, win_duration, overlap_duration, smooth_nwin, ncepstrum);

M_enrolled_train = [chris1.cepstrum_coef_centr,...
				    chris2.cepstrum_coef_centr,...
				    chris4.cepstrum_coef_centr, ... 
				    chris3.cepstrum_coef_centr...
					];
[~, ncol] = size(M_enrolled_train);
M_enrolled_train = [ones(1,ncol); M_enrolled_train];


M_unenrolled_train = [cillian1.cepstrum_coef_centr,...
				      cillian2.cepstrum_coef_centr,...
				      cillian3.cepstrum_coef_centr,...
				      cillian4.cepstrum_coef_centr,...
				      cillian5.cepstrum_coef_centr, ...
					  tilda1.cepstrum_coef_centr,...
				      tilda2.cepstrum_coef_centr,...
				      tilda3.cepstrum_coef_centr,...
				      tilda5.cepstrum_coef_centr...
					  ];
[~, ncol] = size(M_unenrolled_train);
M_unenrolled_train = [zeros(1,ncol); M_unenrolled_train];

M_enrolled_test= [chris5.cepstrum_coef_centr];
[~, ncol] = size(M_enrolled_test);
M_enrolled_test = [ones(1,ncol); M_enrolled_test];


M_unenrolled_test = [ cillian6.cepstrum_coef_centr,...
				     tilda4.cepstrum_coef_centr...
					 ];

[~, ncol] = size(M_unenrolled_test);
M_unenrolled_test= [zeros(1,ncol); M_unenrolled_test];

csvwrite('sets/train_set.csv', [M_enrolled_train M_unenrolled_train])
csvwrite('sets/test_set.csv', [M_enrolled_test M_unenrolled_test])
csvwrite('sets/cillian_test.csv', cillian2.cepstrum_coef_centr)
csvwrite('sets/chris_test.csv', chris4.cepstrum_coef_centr)
csvwrite('sets/chris_test2.csv', chris6.cepstrum_coef_centr)
csvwrite('sets/tilda_test.csv', tilda4.cepstrum_coef_centr)
csvwrite('sets/jesse_test.csv', jesse1.cepstrum_coef_centr)
