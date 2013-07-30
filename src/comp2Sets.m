clc;
clear;
cwnddir='/Users/ll/Dropbox/sjproject/project/v7/hybrid70/whole/';

% this file compares .query files with cwnd files to find out which query is missing

cwlist = fullfile(cwnddir, 'cwnlist');    
cwfid = fopen(cwlist);
if (cwfid==1)
   error('Cannot open text file...press CTRL-C to exit ');pause
end

cwlist={};
while ~feof(cwfid)
    cwfile = fgetl(cwfid);
    cwlist = [cwlist; cwfile];
end
sz_cwlist = length(cwlist)

CWNDlist = {};
unmatch = {};
for i = 1 : sz_cwlist
    f1 = cwlist{i};
    if regexp(f1, '^.*1\.\d\-\d+$') == 1
        f2 = regexprep(f1, '(^cwnd)(.*)1(\.\d\-\d+)$', '$2$3\.query');
        CWNDlist =[CWNDlist; f2];
    elseif regexp(f1, '^.*%1\-\d+$') == 1
        f2 = regexprep(f1, '(^cwnd)(.*%)1(\-\d+)$', '$2$3\.query');
        CWNDlist =[CWNDlist; f2];
    end
end
sz_CWNDlist = length(CWNDlist)      % cwnd files 
fclose(cwfid);

querydir='/Users/ll/Dropbox/sjproject/project/v7/query30/whole/';
qulist = fullfile(querydir, 'querylist');    
qufid = fopen(qulist);
if (qufid==1)
   error('Cannot open text file...press CTRL-C to exit ');pause
end
QUERYlist={};
while ~feof(qufid)
    qufile = fgetl(qufid);
    QUERYlist = [QUERYlist; qufile];
end
sz_QUERYlist = length(QUERYlist)   % query files

unlist = {};
idx = 1;
%q = Querylist{1}
m = 0;
miss ={};
find = 0;
for i = 1 : sz_CWNDlist
    find = 0;
    c = CWNDlist{i};
    for j = 1 : sz_QUERYlist
        q = QUERYlist{j};
        if strcmp(c, q)
            find = 1;
            break;
        end
    end
    if find == 0
        miss = [miss; c];
    end
end
        
fclose(qufid);

missfid = fopen('missQueryFiles.txt','w+');
[m,n]=size(miss)
for i=1:m  
    fprintf(missfid, '%s\n', miss{i});
end
fclose(missfid);
        
