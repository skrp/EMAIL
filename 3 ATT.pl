use strict; use warnings;
use CAM::PDF;
###########################
# ATT - pdf pass protection
# SETUP ###################
my $pre_location = 'PRE';
my $final_location = 'ATT';
my $listi = 'LIST.txt';
# GET ITER VIA LIST.txt ###
open(my $listfh, '<', $listi);
my @list = readline $listfh; chomp @list;
# PREP ATTACHMENTS ########
foreach my $i (@list) {
  my @tmp = split(' ', $i, 3);
  my $addr = $tmp[0]; my $attach = $tmp[1]; my $pin = $tmp[2];
  my $x = "$pre_location\\$attach";
# ENCRYPT WITH PIN #######
  my $pdf = CAM::PDF->new($x) or die "fail\n";
  $pdf->setPrefs($pin,$pin);
# SAVE FINAL ATTACHMENT ##
  my $doc = "$final_location\\$attach";
  $pdf->output($doc);
  print "$x\n |stored in| $doc\n";
}
