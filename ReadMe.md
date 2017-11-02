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


#### Bugfix1

[Bugfix1]()

Fixes the problem of a Note on command with Velocity of zero

There is a special case if the velocity is set to zero. The NOTE ONmessage then has the same meaning as a NOTE OFF message, switching the note off.
From the sample you provided above:

Copy Code
2, 384, Note_on_c, 0, 72, 90
2, 768, Note_on_c, 0, 72, 0    # really a note off as the last paramter is a zero velocity.
Channel Events

These events are the “meat and potatoes” of MIDI files: the actual notes and modifiers that command the instruments to play the music. Each has a MIDI channel number as its first argument, followed by event-specific parameters. To permit programs which process CSV files to easily distinguish them from meta-events, names of channel events all have a suffix of “_c”.

From Midi to CSV site:

Midi to CSV

Track, Time, Note_on_c, Channel, Note, Velocity
Send a command to play the specified Note (Middle C is defined as Note number 60; all other notes are relative in the MIDI specification, but most instruments conform to the well-tempered scale) on the given Channel with Velocity (0 to 127). A Note_on_c event with Velocity zero is equivalent to a Note_off_c.
Track, Time, Note_off_c, Channel, Note, Velocity
Stop playing the specified Note on the given Channel. The Velocity should be zero, but you never know what you’ll find in a MIDI file.
