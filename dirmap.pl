#   File/Dir Mapping script - v0.1
#   ------------------------------
#
#   (unnecessarily verbose) Backstory:
#   Over the years I've accumulated a lot of really badly organised folders on my home server. I've got backed up PCs 
#   from my university days, random USB drive dumps and various (heavily duplicated) photo folders. All of these were of 
#   course going to be processed on a rainy day when I have nothing else to do (you know, those days that don't exist).
#
#   So it got out of hand. I lived with it. But sometimes I need to find a file and I can't for the life of me remember 
#   where I saw that file, or which copy of 'My Documents' from which defunct laptop backup it lives in. I needed 
#   something that I could process visually. A map, to make some sense of this haystack.
#
#   This is the solution, sort of. It's still a mess, but at least now I can quickly visualise what's in the monster 
#   filedump. It saves time.
#
#   Aaaanyway, here's one of my motorbikes. Because life always needs more motorbike.
#                                                                    
#                                                      I::                          
#                                                       ~+                          
#                                                     D:M:                          
#                                                                                   
#                                                      $$7M8   78:                  
#                                                   ~M8NMD8DO DMNO                  
#        :                                           :  8IO:MMMMZM$~                
#    7~   ~                                 ~::::::::+$   MNZMMMZM$                 
#     +:   $Z$$I$Z7$$$                 ~ :    : :::7$~+7+ MM+ MMMNNN                
#         I ?ND888OOOZ$$             =   =~78MMN    ::~+OONMMNMMMMN                 
#     $?ZM$=I =DMMNNDD8Z$7         I      :=~+D=+M8$D?: :$ZMMM8MD8M?                
#      INM8M:  I :IMNNND8ZZZZZ$$Z$$      ::~+++=?MMMZ?=~$I8MDMNNMM                  
#     MMMN    : ~:?= ~$MMNN88OOZOOMI::~I~DD+=7Z8O$~$8~~7M NNMMMMI:                  
#    MMM=       I??~?$MMN 8MMMMDOD?7$ZMMNO8DM$MMMNNMM=ZMMM$~N: +8+                  
#    M8 +::       M  =:I ?MDO~7=7?7?OMMMMMNMMN77MN:~:8~~MM7~8: MNO+:                
#   8  +$~  +MMMMMMM77NNOM :DDDDDDDDMMMMMMD7=NZDN?MMM~ +MMM    =:N+O:~~~=:          
#         $=  =NNDDII8=:N+7?D8NM8DMMMMMMMMM  Z 7M+:MDNNMMM +    N7::N ++=:   ?  ::::
#       DO  ?$: :+IM ~DMMM8   MMNNMMMMMMMM8MO~MMNMM$MD8N M     N+Z7=~ 8DDNNN8ZO ::::
#     :ZZMMN  ~Z=  + 7$8NMMDNZDNMMMMM8MDMMMND8ZMNMMMMMNMN:    M7NMNN+$MM IMMDN8$::::
#     $$NNM7:I+  I7  ~I?==:M  NMMZMMMMMMMMMMDD:7=NN  M?DO    MZMNN : :MI$ ::$MNNI ::
#    ~IMNND :~?ND: :$~ ~NN~$+==:7NMMMMMM8MMMM7$?+:MDMM N8   ZMMNMM8I?~~M=7?+::MNN?::
#    $7NDM  =IZZZ? :  +NO$7$7?+~: MNMMDM8MMMMD7O$7NMM MN    ~MMNZ O=D~~ N7 ++: MMD$ 
#    $IMNM  ++=: :==++??8DDD7I$:7=~8MMMMN88NMN=?=:MD  MZ    NMNM:=+? $?~7+  7: MMN?:
#    ZINDMND++N 8M?II   NZ8DDNN :I8ZZNMMDMNMMM8:MMM  MDN    NMNM +?MM?Z~=ZO~?+:MMN+ 
#     INMMMN ~:=:~=?MMMMNZMMO88NM7 MMNDMMMMMMMMMMD  NDN      NNDO?7?8~$7Z8~I$:NMMD$ 
#     IONDMM          NMN8MM    N8DNMMMNM++?++++==OMDMD      MNMMD:I+? :IIII+MMDNO  
#      8ONMDMM      IMD8DNM         88NNDDDDDDDDDD8DD         MNMMD:  ==I$  ZMNN8   
#       $O8NNNNMMMMNNDDNNN                                     8NNDMMN : DMMDMD8    
#         D88DNNDNDDNNMM8                                       8DN8MDNNDD88DDZ     
#           :8NNNNMMMO++++=+==+++==+===========~~:::        :::::::MNNDNNDNM        
#                                                                                                                                                                 
#   
#   Usage:
#   Put it anywhere. Specify the $dir value as the folder that you want to map. Run the script. The script creates a 
#   mind map file at the base of that directory.
#
#   Open the file with Freemind (http://goo.gl/54miZt). 
#   ???. 
#   Profit. (sorry)
#
#   --------------------------------------------------------------------------------------------------------------------
#
#   Stuff what I ripped off to make this (because I am NOT a Perl coder):
#   - I used this Perl Monks script initially: http://www.perlmonks.org/?node_id=136482
#   - Then pulled the file output logic from here: http://perlmaven.com/writing-to-files-with-perl
#   - I made a Freemind .mm file and opened it up in a text editor. I copied the node structure from that.
#
#   --------------------------------------------------------------------------------------------------------------------
#
#   Thu 18 Dec 2014
#   Written on a coffee break by Matt Fenlon (https://github.com/noln)
#
#   Note: Adheres to no commenting convention known to man(/woman, keep it contemporary)kind. Becauyse life's too short.
#   Look, it's a freebie. What do you want? Just run the damn script.


use feature qw(say);    # Added so we can use 'say' to output text on a new line.
use File::Basename;     # Needed to split up the returned filename into dir and filename etc.

my $filename = 'filemap.mm';        
#my $dir = "/Users/matt/Development";    # This is where the file map gets put.
my $dir = "/Users/matt/Development/Media/Android";    # This is where the file map gets put.

open(my $fh, '>', $dir . '/' . $filename) or die "Could not open file '$filename' $!";

#   This is horrific hackery, and none of the attributes are generated as they should be, but it loads. So I'm happy.
print $fh "<map version=\"0.9.0\">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED=\"1\" ID=\"ID_1\" MODIFIED=\"1418909179964\" TEXT=\"" . $dir . "\">\n";

process_files ($dir);

print $fh ("</node></map>");

close $fh;
print "done\n";

# Accepts one argument: the full path to a directory.
# Returns: nothing.
sub process_files {
    my $path = shift;

    # Open the directory.
    opendir (DIR, $path)
        or die "Unable to open $path: $!";

    my @files = grep { !/^\.{1,2}$/ } readdir (DIR);

    closedir (DIR);
    @files = map { $path . '/' . $_ } @files;

    for (@files) {

        # If the file is a directory
        if (-d $_) {
            my($file, $dir, $ext) = fileparse($_);
            print $fh ("<node CREATED=\"2\" ID=\"ID_2\" MODIFIED=\"1418909183375\" TEXT=\"" . $dir . "\">");
            process_files ($_);
            print $fh ("</node>\n");

        # If it's just a file
        } else {

            # This splits the file (which includes the full path at this point) into filename, dir and file extension.
            my($file, $dir, $ext) = fileparse($_);

            print $fh ("<node CREATED=\"2\" ID=\"ID_2\" MODIFIED=\"1418909183375\" TEXT=\"" . $file . "\"/>\n");
        }
    }
}