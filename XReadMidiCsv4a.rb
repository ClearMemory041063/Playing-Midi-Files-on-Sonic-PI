#XReadMidiCsv4a.rb
# 30 Oct 2017
##############
#helper function
def findit (aa,a)
  i=0
  j=-1
  while i<a.length
    if aa== a[i][0]
      j=i
    end
    i+=1
  end
  return j
end
#########
#point to the csv file to process
filepath="C:/Users/jj/Documents/midicsv/"
filename="out.csv"
##
# midi file fields
track=0
time=1
type=2
trackn=-1
trkflag=0
voices=[]
sss=[]
sss1=[0,0]
nteon=[]
tstart=0
tend=0
lineno=0

text= File.read(filepath+filename)
puts text
loopflag=1
while loopflag>0
  if loopflag>0
    text1= text.split("\n",2)
    ss1=text1.slice(0)
    text=text1[1]
    row=ss1.split(",")
    puts row
    puts lineno,row
    lineno+=1
    #    sleep 0.2
    if row[type]!=" End_of_file"
      if row[track].to_i==0
        trackn=1
        if row[type]==" Header"
          format=row[3].to_i
          ntracks=row[4].to_i+1
          i=0
          while i<ntracks
            voices=voices.push([])
            i+=1
          end #while
          division=row[5].to_i #clock pulses per 1.4 note
          puts "HDR",format,ntracks,division
        end #header
      end #track0
      if row[track].to_i==trackn
        if row[type]==" Start_track"
          trkflag=1
          tstart=0
        end #start track
        if row[type]==" End_track"
          trackn+=1
          trkflag=0
        end #End track
        if row[type]==" Tempo"
          tempo1=row[3].to_i/1000.0 # ms [er 1/4 note
          puts "tempo1=",tempo1
        end #Tempo
        if row[type]==" Note_on_c"
          dt=(row[time].to_i-tstart)/1000.0
       if dt >0.00999
         sss=[:r,dt]
         voices[trackn]=voices[trackn].push(sss)
        end #dt
        tstart=row[time].to_i
        channel=row[3].to_i
        tone=row[4].to_i
        velocity=row[5].to_i
        sss= [tone,tstart.to_f]
        nteon=nteon.push(sss)
      end # note on
      if row[type]==" Note_off_c"
        tend=row[time].to_i
        channel1=row[3].to_i
        tone1=row[4].to_i
        velocity1=row[5].to_i
        ttt=nteon.slice!(findit(tone1,nteon))
          voices[trackn]=voices[trackn].push([tone1,(tend-ttt[1])/1000.0])
        end # note off
      end #next track
    else
      loopflag=0
      puts "EOF"
    end #eof
  end #if loopflag>0
end #while loopflag
# save the voices arrays to files
fname="VoiceA"
i=0
puts voices[0].length
while i<voices.length
  open(filepath+fname+i.to_s+".csv", 'w') { |f|
    j=0
    while j<voices[i].length
      puts i,j,voices[i][j]
      if voices[i][j][0]== :r
        voices[i][j][0]=":r"
      end
      sss=voices[i][j][0].to_s+","+voices[i][j][1].round(4).to_s+"\n"
      puts i,j,sss
      f.puts sss
      #      sleep 0.1
      j+=1
    end
  }
  i+=1
end



