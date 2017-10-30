#PlayMidiCsva.rb
# 28 Oct 2017
##############
#helper function
def midi2note(n)
  nn=note(n)
  if nn==nil
    return nn
  else
    nn= note_info(nn)
    nnn=nn.to_s.split(":")
    mmm= nnn[3].chop
    return mmm
  end
end # midi2note
def listnotes(n)
  i=0
  while i<n.length
    puts midi2note(n[i])
    i+=1
  end
end

#Define tempo and note lengths and release fraction
#####
tempo=1.0  ### try changing tempo
#define note timings
whole=1.0
half=whole/2.0
dothalf=half*1.5
quart=half/2.0
dotquart=quart*1.5
eighth=quart/2.0
doteighth=eighth*1.5
sixteenth=eighth/2
#########
use_synth :piano
#point to the csv file to process
filepath="C:/Users/jj/Documents/midicsv/"
filename1="voiceA3.csv"
filename2="voiceA2.csv"

voice2=[]
voice3=[]

text=File.open(filepath+filename1).read
puts text
text1=text.split("\n")
puts text1[0]
puts text1.length
i=0
while i<text1.length
  texta=text1[i].split(",")
  puts texta[0],texta[1]
  voice3=voice3.push([texta[0],texta[1].to_f])
  i+=1
end
puts voice3

text=File.open(filepath+filename2).read
puts text
text1=text.split("\n")
puts text1[0]
puts text1.length
i=0
while i<text1.length
  texta=text1[i].split(",")
  puts texta[0],texta[1]
  voice2=voice2.push([texta[0],texta[1].to_f])
  i+=1
end
puts voice2

sleep 1.0
i1=0
live_loop :LL1 do
  use_synth :piano
  #puts voice3[i1]
  puts midi2note(voice3[i1][0].to_i),voice3[i1][1]
  if voice3[i1][0]!= ":r"
    play voice3[i1][0].to_i,sustain: voice3[i1][1]
    sleep 0.00001
  else
    sleep voice3[i1][1]
  end
  i1+=1
  if i1>=voice3.length
    stop
  end
end


i2=0
live_loop :LL2 do
  #sync :LL1
  use_synth :piano
  #puts voice2[i2]
  puts midi2note(voice2[i2][0].to_i),voice2[i2][1]
  if voice2[i2][0]!= ":r"
    play voice2[i2][0].to_i,sustain: voice2[i2][1]
    sleep 0.001
  else
    sleep voice2[i2][1]
  end
  i2+=1
  if i2>=voice2.length
    stop
  end
end
