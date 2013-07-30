#include <string>
#include <vector>
#include <list>
#include <iostream>
#include <fstream>
#include <sstream>
#include <set>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <limits>
#include <math.h>

using namespace::std;

bool isNumeric(string stringToCheck)
{
  bool numeric = false;
 
  if(stringToCheck.find_first_not_of("0123456789.") == string::npos)
    numeric = true;
 
  return numeric;
}

void Tokenize(const string& str,
        vector<string>& tokens,
        const string& delimiters = " ")
{
    // Skip delimiters at beginning.
    string::size_type lastPos = str.find_first_not_of(delimiters, 0);
    // Find first "non-delimiter".
    string::size_type pos     = str.find_first_of(delimiters, lastPos);

    while (string::npos != pos || string::npos != lastPos)
    {
        // Found a token, add it to the vector.
        tokens.push_back(str.substr(lastPos, pos - lastPos));
        // Skip delimiters.  Note the "not_of"
        lastPos = str.find_first_not_of(delimiters, pos);
        // Find next "non-delimiter"
        pos = str.find_first_of(delimiters, lastPos);
    }
}

int str2num(string s)
{
    int num;
    stringstream ss(s);
    ss>>num;
    return num;
}

long int str2longint(string s)
{
    long int num;
    stringstream ss(s);
    ss>>num;
    return num;
}

long double str2double(string s)
{
    long double num;
    stringstream ss(s);
    ss>>num;
    return num;
}

int main(int argc, char *argv[])
{

    vector<double> predictions;
    vector<string> tokens;
    string fname = "RFFULL";
    string outfname = "correct";
    string wkprefix("/Users/ll/Dropbox/sjproject/project/v7/results-hybrid70-extension/"); 
    string wkfilename = wkprefix + fname;
    string outputfilename = wkprefix + outfname;
    ifstream wkfile;
    ofstream outfile;
    wkfile.open(wkfilename.c_str());
    outfile.open(outputfilename.c_str());
    if(!wkfile.is_open()){
        cout<<"cannot open wkfile"<<endl;
        return -1;
    }

    string str_plus("+");
    string line;
   // getline(wkfile, line);
    int sz= 0;
    int npositive = 0, nnegative=0;
    while( getline(wkfile, line)){
       Tokenize(line, tokens);
        if(tokens[3] != str_plus)
        {
            predictions.push_back(str2double(tokens[3]));
            sz++;
        }
        tokens.clear();
    }
     
    double max=0;
    for (vector<double>::size_type id=0; id !=predictions.size(); ++id){
        double tmp = predictions[id];
        if(max<tmp)
            max = predictions[id];
    }
    
    cout<<"The highest prediction prob of error prediction = "<<max<<endl;
    
    for (vector<double>::size_type id=0; id !=predictions.size(); ++id){
        outfile<<predictions[id]<<endl;
    }
    wkfile.close();
    outfile.close();
   return 0;
}

