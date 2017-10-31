ReadMe.md
####  Playing Midi Files on Sonic PI
This project starts by using a Midi to CSV program, downloaded from the Web, to convert a Midi format file into CSV format. The project code then operates on the CSV file to produce a CSV for each Midi track. These files contain two columns containing Midi notes, and a duration time. An example program uses these files to play the notes using Sonic PI.

#### The Midi to CSV software

[Midi2CSV]( http://www.fourmilab.ch/webtools/midicsv/)

#### The Example Midi file
[Adele Polka CGF 7- ]( http://abcnotation.com/tunePage?a=dl.dropboxusercontent.com/sh/flddgymslo57zvl/AAC7BgLqZ5JE3D633nuRUUJ8a/Bd6/Bd06_aug2016/0679)

Click on the Midi download, it will likey trigger the media player. Look in the downloads folder for the file "C:\Users\jj\Downloads\adele-polka-cgf-7.mid"

#### Use Midi to CSV to create the CSV file (command line tool)

```
PS C:\Users\jj\documents\midicsv> .\midicsv adele-polka-cgf-7.mid out.csv
PS C:\Users\jj\documents\midicsv> dir

    Directory: C:\Users\jj\documents\midicsv

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        9/13/2017   2:42 PM           7400 adele-polka-cgf-7.mid
-a----        10/8/2017  11:02 PM          53248 Csvmidi.exe
-a----        10/8/2017  11:02 PM          45056 Midicsv.exe
-a----        10/8/2017  11:08 PM          56304 out.csv

PS C:\Users\jj\documents\midicsv>
```
Note the output in in the file out.csv

#### Extracting the notes and durations from the out.csv file

Load the program XReadMidiCsv4a.rb" into Sonic Pi.

Using the editor look for the filepath and filename for the input (editing)

```
#point to the csv file to process
filepath="C:/Users/jj/Documents/midicsv/"
filename="out.csv"
```
Look for  fname="VoiceA" which is used to create the output files

Run the program and then look for the output files

```
"C:\Users\jj\Documents\midicsv\VoiceA1.csv"
"C:\Users\jj\Documents\midicsv\VoiceA2.csv"
"C:\Users\jj\Documents\midicsv\VoiceA3.csv"
"C:\Users\jj\Documents\midicsv\VoiceA0.csv"
```
For the Adele Polka A1 and A2 have a length of zero.  VoiceA3 and VoiceA4 contain the notes and durations for the two active tracks.

#### Playing the file VoiceA3 and VoiceA4 on Sonic PI

As an example the program PlayMidiCsva.rb illustates how to play the music.
Load the program into Sonic PI and edit 

```
#point to the csv file to process
filepath="C:/Users/jj/Documents/midicsv/"
filename1="voiceA3.csv"
filename2="voiceA2.csv"
```
Run the program

#### Discussion

As a first cut I'm pleased with the results, although the playback has some synchronization problems. This is related to the paradigm shift of timing in Midi files and the way Sonic Pi tracks the time. Other parameters in the Midi file have been ignored such as the velocity values. 
The purpose of this posting is to record what has been done so that the experts in Sonic Pi can make suggestions.

[InThread Group]( https://in-thread.sonic-pi.net/)

#### Update

Changed sleep values in PlayMidiCsva.rb" to fix the synchronization problem.
