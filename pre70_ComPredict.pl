#!/usr/bin/perl
use strict; # install all three strictures
use Getopt::Std;

use vars qw($opt_h);  # earlier versions of perl 5.001

use POSIX qw(ceil floor);

getopts('h');

my $sfile1 = "./pre70-35filelist";
my $sfile2 = "./pre70_predict.txt";
my $rfile = "./pre70_FinalPrediction.txt";
my $sstring1;
my $sstring2;
my $rstring;

open(SFILE1, "<$sfile1") or die ("Unable to open file ./$sfile1: $!");
open(SFILE2, "<$sfile2") or die ("Unable to open file ./$sfile2: $!");
open(RFILE, ">$rfile") or die ("Unable to open file ./$rfile: $!");
#open(RFILE, ">$rfile") or die ("Unable to open file ./$rfile: $!");

my $count=0;
my $linkcount=0;
my $flag=0;
my @data;
my $saved;
my @array;
#my $outfile = "./eva_results/m1/eva_alllinks_overflow_$thres.txt";
#if(!-e $outfile){
#    `touch $outfile`;
#}else{
#    `rm $outfile`;
#    `touch $outfile`;
#}
#`cat /dev/null >$outfile`;
my @predict;
my $string;
while($sstring1=<SFILE1>){
    chomp($sstring1);

    $sstring2=<SFILE2>;
    chomp($sstring2);

    $sstring2 =~ s/^.*://;
    $sstring2 =~ s/\s+\d+\.\d+|\s+\d//;
    $sstring2 =~ s/\s$//;
    $string = $sstring1."-".$sstring2."#"."\n";
    push @predict, $string;
}
print RFILE @predict;

print RFILE "=======================\n";
print RFILE "Summary: \n";

my $sum_bic= 0;
my @bic;
foreach(@predict){
   if (@bic = $_ =~/-bic/gi)
   {
      $sum_bic += scalar @bic;
   }
}

my $sum_compound= 0;
my @compound;
foreach(@predict){
   if (@compound = $_ =~/compou/gi)
   {
      $sum_compound += scalar @compound;
   }
}

my $sum_ctcp= 0;
my @ctcp;
foreach(@predict){
   if (@ctcp = $_ =~/ctcp/gi)
   {
      $sum_ctcp += scalar @ctcp;
   }
}

my $sum_cubic= 0;
my @cubic;
foreach(@predict){
   if (@cubic = $_ =~/-cubic#/gi)
   {
      $sum_cubic += scalar @cubic;
   }
}
my $sum_cubicb= 0;
my @cubicb;
foreach(@predict){
   if (@cubicb = $_ =~/cubicb/gi)
   {
      $sum_cubicb += scalar @cubicb;
   }
}
my $sum_highspeed= 0;
my @highspeed;
foreach(@predict){
   if (@highspeed = $_ =~/highspee/gi)
   {
      $sum_highspeed += scalar @highspeed;
   }
}
my $sum_htcp= 0;
my @htcp;
foreach(@predict){
   if (@htcp = $_ =~/htcp/gi)
   {
      $sum_htcp += scalar @htcp;
   }
}
my $sum_illinois= 0;
my @illinois;
foreach(@predict){
   if (@illinois = $_ =~/illinois/gi)
   {
      $sum_illinois += scalar @illinois;
   }
}
my $sum_reno= 0;
my @reno;
foreach(@predict){
   if (@reno = $_ =~/reno/gi)
   {
      $sum_reno += scalar @reno;
   }
}
my $sum_scalable= 0;
my @scalable;
foreach(@predict){
   if (@scalable = $_ =~/scalabl/gi)
   {
      $sum_scalable += scalar @scalable;
   }
}
my $sum_vegas= 0;
my @vegas;
foreach(@predict){
   if (@vegas = $_ =~/vegas/gi)
   {
      $sum_vegas += scalar @vegas;
   }
}

my $sum_veno= 0;
my @veno;
foreach(@predict){
   if (@veno = $_ =~/veno/gi)
   {
      $sum_veno += scalar @veno;
   }
}
my $sum_westwood= 0;
my @westwood;
foreach(@predict){
   if (@westwood = $_ =~/westwoo/gi)
   {
      $sum_westwood += scalar @westwood;
   }
}
my $sum_yeah= 0;
my @yeah;
foreach(@predict){
   if (@yeah = $_ =~/yeah/gi)
   {
      $sum_yeah += scalar @yeah;
   }
}
my $sum=0;
$sum = $sum_bic + $sum_compound +  $sum_ctcp + $sum_cubic + $sum_cubicb + $sum_highspeed + $sum_htcp + $sum_illinois + $sum_reno + $sum_scalable + $sum_vegas + $sum_veno + $sum_westwood + $sum_yeah ;
print $sum;

print RFILE "There are ".$sum." cases who have at least 35 cwnd size data on both environment A and B."."\n";

my $percent_bic = sprintf("%.2f", $sum_bic/$sum)*100;
my $percent_compound = sprintf("%.2f", $sum_compound/$sum)*100;;
my $percent_ctcp = sprintf("%.2f", $sum_ctcp/$sum)*100;;
my $percent_cubic = sprintf("%.2f", $sum_cubic/$sum)*100;;
my $percent_cubicb = sprintf("%.2f", $sum_cubicb/$sum)*100;;
my $percent_highspeed = sprintf("%.2f", $sum_highspeed/$sum)*100;;
my $percent_htcp = sprintf("%.2f", $sum_htcp/$sum)*100;;
my $percent_illinois = sprintf("%.2f", $sum_illinois/$sum)*100;;
my $percent_reno = sprintf("%.2f", $sum_reno/$sum)*100;;
my $percent_scalable = sprintf("%.2f", $sum_scalable/$sum)*100;;
my $percent_vegas = sprintf("%.2f", $sum_vegas/$sum)*100;;
my $percent_veno = sprintf("%.2f", $sum_veno/$sum)*100;;
my $percent_westwood = sprintf("%.2f", $sum_westwood/$sum)*100;;
my $percent_yeah = sprintf("%.2f", $sum_yeah/$sum)*100;;

print RFILE "bic"."=".$sum_bic."  ".$percent_bic."%"."\n";
print RFILE "compound"."=".$sum_compound."  ".$percent_compound."%"."\n";
print RFILE "ctcp"."=".$sum_ctcp."  ".$percent_ctcp."%"."\n";
print RFILE "cubic"."=".$sum_cubic."  ".$percent_cubic."%"."\n";
print RFILE "cubicb"."=".$sum_cubicb."  ".$percent_cubicb."%"."\n";
print RFILE "highspeed"."=".$sum_highspeed."  ".$percent_highspeed."%"."\n";
print RFILE "htcp"."=".$sum_htcp."  ".$percent_htcp."%"."\n";
print RFILE "illinois"."=".$sum_illinois."  ".$percent_illinois."%"."\n";
print RFILE "reno"."=".$sum_reno."  ".$percent_reno."%"."\n";
print RFILE "scalable"."=".$sum_scalable."  ".$percent_scalable."%"."\n";
print RFILE "vegas"."=".$sum_vegas."  ".$percent_vegas."%"."\n";
print RFILE "veno"."=".$sum_veno."  ".$percent_veno."%"."\n";
print RFILE "westwood"."=".$sum_westwood."  ".$percent_westwood."%"."\n";
print RFILE "yeah"."=".$sum_yeah."  ".$percent_yeah."%"."\n";
