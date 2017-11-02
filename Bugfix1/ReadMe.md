

#### Bugfix1

[Main Read Me](  https://github.com/ClearMemory041063/Playing-Midi-Files-on-Sonic-PIReadMe.md Bugfix1)

Fixes the problem of a NoteOn command with Velocity of zero

There is a special case if the velocity is set to zero. The NOTE ONmessage then has the same meaning as a NOTE OFF message, switching the note off.


```
2, 384, Note_on_c, 0, 72, 90
2, 768, Note_on_c, 0, 72, 0    # really a note off as the last paramter is a zero velocity.
```

Channel Events

These events are the “meat and potatoes” of MIDI files: the actual notes and modifiers that command the instruments to play the music. Each has a MIDI channel number as its first argument, followed by event-specific parameters. To permit programs which process CSV files to easily distinguish them from meta-events, names of channel events all have a suffix of “_c”.

From Midi to CSV site:


Track, Time, Note_on_c, Channel, Note, Velocity
Send a command to play the specified Note (Middle C is defined as Note number 60; all other notes are relative in the MIDI specification, but most instruments conform to the well-tempered scale) on the given Channel with Velocity (0 to 127). A Note_on_c event with Velocity zero is equivalent to a Note_off_c.
Track, Time, Note_off_c, Channel, Note, Velocity
Stop playing the specified Note on the given Channel. The Velocity should be zero, but you never know what you’ll find in a MIDI file.

#### Files

The program XReadMidiCsv4c.rb

Uses the file out.csv

to produce the files:

Silverswan2.csv

Silverswan3.csv

Silverswan4.csv

Silverswan5.csv

Silverswan6.csv


The program PlayMidiCsvC.rb
 uses the Silverswan files to play the music with Sonic Pi


The filepath in the two programs will need to be edited to point to the directory containing the files.
