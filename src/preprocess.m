clc;
clear;
datadir='/Users/ll/Dropbox/sjproject/project/v7/hybrid70/whole/';

% this file considers: 70 (35A+35B) feature/case, with hybrid (fixed+variable) data set 

%flist = [datadir, 'datalist'];
flist = fullfile(datadir, 'cwnlist');
% flist = '/Users/ll/Dropbox/sjproject/project/v4/data/datalist'
fid = fopen(flist);
if (fid==1)
   error('Cannot open text file...press CTRL-C to exit ');pause
end

filelist={};
i=0;
while ~feof(fid)
    i = i+1;
    file = fgetl(fid);
    filelist = [filelist; file];
end
sz = i; 

% test if 8 files per group are matched
% for i = 1 : 8 : sz
%     for j = 0 : 3
%         f11 = filelist{i + j};
%         f12 = filelist{i + j + 4} ;
%         pairfile = regexprep(f11, '(^.*)\d(\.\d\-\d+$)', '$12$2');    
%         if ~strcmp(f12, pairfile)
%             c = f11
%             return;
%         end
%         
%     end
%         
% end
goodlist = {};
for i = 1 : 8 : 8
    for j = 0 : 3
        f11 = filelist{i + j};
        f12 = filelist{i + j + 4} ;
        f13 = filelist{i + j + 1} ;
        
        if regexp(f11, '^.*\d\.\d\-\d+$') == 1
            pairfile = regexprep(f11, '(^.*)\d(\.\d\-\d+$)', '$12$2'); 
            
            tmp1 = regexprep(f11, '\.\d\-\d+$', ''); 
            setting1 = regexprep(tmp1, '^.*\%', '')
            
        elseif regexp(f11, '^.*\d\-\d+$') == 1
            pairfile = regexprep(f11, '(^.*)\d(\-\d+$)', '$12$2'); 
            
            tmp1 = regexprep(f11, '-\d+$', ''); 
            setting1 = regexprep(tmp1, '^.*\%', '')
%         else
%             f11
        end   
        
        if setting1 == 1   
            c='ok'
            if strcmp(f13, pairfile)
                goodlist =[goodlist; f11];
                goodlist =[goodlist; f13];
            elseif strcmp(f12, pairfile)
                goodlist =[goodlist; f11];
                goodlist =[goodlist; f12];
            else
                f11
                return;
            end  
        end
    end
end

sz_goodlist = length(goodlist)
matrix = {};

for i = 1 : 2 : sz_goodlist
    feature = {};
    f1 = goodlist{i};
    f2 = goodlist{i+1};
    file1 = fullfile(datadir, f1);   % Get first cwnd file
    file2 = fullfile(datadir, f2);   % Get second cwnd file
    
    data1 = load(file1);
    [m1, n1] = size(data1);
    if(n1 ~=2 || m1 <35)
        continue;
    end
    
    data2 = load(file2);
    [m2, n2] = size(data2);
    if(n2 ~=2 || m2 <35)
        continue;
    end
    
    a1 = data1(:,2);
    a2 =  data2(:,2);     

    tmp1 = regexprep(f1, '\..*', '');
    tmp2 = regexprep(tmp1, '\d+$', '');
    protocol = regexprep(tmp2, '^cwnd', '');  %Get class label
    a1 = a1';    
    a2 = a2';
    feature = {a1 a2 protocol};
    matrix = [matrix; feature];
    
    timeout = regexprep(f1, '^.*\-', '');  %Get timeout
    
    tmp1 = regexprep(f1, '\.\d\-\d+$', ''); 
    setting1 = regexprep(tmp1, '^.*\%', '');  %Get 1 or 2 for environment settings
    tmp2 = regexprep(f2, '\.\d\-\d+$', ''); 
    setting2 = regexprep(tmp2, '^.*\%', '');  %Get 1 or 2 for environment settings
    
%     if(setting1 ~= 1 || setting2 ~= 2)
%         f1
%         f2
%         return;
%     end   

end

fclose(fid);
fid = fopen('matrix-hybrid-70.arff','w+');
fprintf(fid, '@relation caai\n\n');

fprintf(fid, '@attribute a1 numeric\n');
fprintf(fid, '@attribute a2 numeric\n');
fprintf(fid, '@attribute a3 numeric\n');
fprintf(fid, '@attribute a4 numeric\n');
fprintf(fid, '@attribute a5 numeric\n');
fprintf(fid, '@attribute a6 numeric\n');
fprintf(fid, '@attribute a7 numeric\n');
fprintf(fid, '@attribute a8 numeric\n');
fprintf(fid, '@attribute a9 numeric\n');
fprintf(fid, '@attribute a10 numeric\n');

fprintf(fid, '@attribute a11 numeric\n');
fprintf(fid, '@attribute a12 numeric\n');
fprintf(fid, '@attribute a13 numeric\n');
fprintf(fid, '@attribute a14 numeric\n');
fprintf(fid, '@attribute a15 numeric\n');
fprintf(fid, '@attribute a16 numeric\n');
fprintf(fid, '@attribute a17 numeric\n');
fprintf(fid, '@attribute a18 numeric\n');
fprintf(fid, '@attribute a19 numeric\n');
fprintf(fid, '@attribute a20 numeric\n');

fprintf(fid, '@attribute a21 numeric\n');
fprintf(fid, '@attribute a22 numeric\n');
fprintf(fid, '@attribute a23 numeric\n');
fprintf(fid, '@attribute a24 numeric\n');
fprintf(fid, '@attribute a25 numeric\n');
fprintf(fid, '@attribute a26 numeric\n');
fprintf(fid, '@attribute a27 numeric\n');
fprintf(fid, '@attribute a28 numeric\n');
fprintf(fid, '@attribute a29 numeric\n');
fprintf(fid, '@attribute a30 numeric\n');

fprintf(fid, '@attribute a31 numeric\n');
fprintf(fid, '@attribute a32 numeric\n');
fprintf(fid, '@attribute a33 numeric\n');
fprintf(fid, '@attribute a34 numeric\n');
fprintf(fid, '@attribute a35 numeric\n');
fprintf(fid, '@attribute a36 numeric\n');
fprintf(fid, '@attribute a37 numeric\n');
fprintf(fid, '@attribute a38 numeric\n');
fprintf(fid, '@attribute a39 numeric\n');
fprintf(fid, '@attribute a40 numeric\n');

fprintf(fid, '@attribute a41 numeric\n');
fprintf(fid, '@attribute a42 numeric\n');
fprintf(fid, '@attribute a43 numeric\n');
fprintf(fid, '@attribute a44 numeric\n');
fprintf(fid, '@attribute a45 numeric\n');
fprintf(fid, '@attribute a46 numeric\n');
fprintf(fid, '@attribute a47 numeric\n');
fprintf(fid, '@attribute a48 numeric\n');
fprintf(fid, '@attribute a49 numeric\n');
fprintf(fid, '@attribute a50 numeric\n');

fprintf(fid, '@attribute a51 numeric\n');
fprintf(fid, '@attribute a52 numeric\n');
fprintf(fid, '@attribute a53 numeric\n');
fprintf(fid, '@attribute a54 numeric\n');
fprintf(fid, '@attribute a55 numeric\n');
fprintf(fid, '@attribute a56 numeric\n');
fprintf(fid, '@attribute a57 numeric\n');
fprintf(fid, '@attribute a58 numeric\n');
fprintf(fid, '@attribute a59 numeric\n');
fprintf(fid, '@attribute a60 numeric\n');

fprintf(fid, '@attribute a61 numeric\n');
fprintf(fid, '@attribute a62 numeric\n');
fprintf(fid, '@attribute a63 numeric\n');
fprintf(fid, '@attribute a64 numeric\n');
fprintf(fid, '@attribute a65 numeric\n');
fprintf(fid, '@attribute a66 numeric\n');
fprintf(fid, '@attribute a67 numeric\n');
fprintf(fid, '@attribute a68 numeric\n');
fprintf(fid, '@attribute a69 numeric\n');
fprintf(fid, '@attribute a70 numeric\n');

fprintf(fid, '@attribute class {bic,compound,ctcp, cubic,cubicb, highspeed,htcp,illinois,reno,scalable,vegas,veno,westwood,yeah}\n\n');

fprintf(fid, '@data\n');

[m,n]=size(matrix)

for i=1:m
    A = matrix{i, 1};
    B = matrix{i, 2};
    C = matrix{i, 3};
   
    fprintf(fid,  '%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %s\n',...
                   A(1), A(2), A(3), A(4), A(5), A(6), A(7), A(8), A(9),...
                   A(10), A(11), A(12), A(13), A(14), A(15), A(16), A(17), A(18), A(19),... 
                   A(20), A(21), A(22), A(23), A(24), A(25), A(26), A(27), A(28), A(29),...
                   A(30), A(31),A(32), A(33), A(34), A(35),...
                   B(1), B(2), B(3), B(4), B(5), B(6), B(7), B(8), B(9),...
                   B(10), B(11), B(12), B(13), B(14), B(15), B(16), B(17), B(18), B(19),...
                   B(20), B(21), B(22), B(23), B(24), B(25), B(26), B(27), B(28), B(29),...
                   B(30), B(31), B(32), B(33), B(34), B(35),...                     
                   C...
                   );

end
    

