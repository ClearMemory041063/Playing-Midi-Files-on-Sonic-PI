#PlayMidiCsvc.rb
# 2 Nov 2017
# input files have velocity ingo
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
filepath="C:/Users/jj/Documents/silverswan/"
filename1="Silverswan2.csv"
filename2="Silverswan3.csv"
filename3="Silverswan4.csv"
filename4="Silverswan5.csv"
filename5="Silverswan6.csv"

voice2=[]
voice3=[]
voice4=[]
voice5=[]
voice6=[]
voice7=[]

text=File.open(filepath+filename1).read
puts text
text1=text.split("\n")
puts text1[0]
puts text1.length
i=0
while i<text1.length
  texta=text1[i].split(",")
  puts texta[0],texta[1],texta[2] # the velocity is available in [2]
  voice2=voice2.push([texta[0],texta[1].to_f])
  i+=1
end
puts voice2

text=File.open(filepath+filename2).read
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

text=File.open(filepath+filename3).read
puts text
text1=text.split("\n")
puts text1[0]
puts text1.length
i=0
while i<text1.length
  texta=text1[i].split(",")
  puts texta[0],texta[1]
  voice4=voice4.push([texta[0],texta[1].to_f])
  i+=1
end
puts voice4

text=File.open(filepath+filename4).read
puts text
text1=text.split("\n")
puts text1[0]
puts text1.length
i=0
while i<text1.length
  texta=text1[i].split(",")
  puts texta[0],texta[1]
  voice5=voice5.push([texta[0],texta[1].to_f])
  i+=1
end
puts voice5

text=File.open(filepath+filename5).read
puts text
text1=text.split("\n")
puts text1[0]
puts text1.length
i=0
while i<text1.length
  texta=text1[i].split(",")
  puts texta[0],texta[1]
  voice6=voice6.push([texta[0],texta[1].to_f])
  i+=1
end
puts voice6


sleep 1.0
i1=0
live_loop :LL1 do
  use_synth :piano
  #puts voice2[i1]
  puts midi2note(voice2[i1][0].to_i),voice2[i1][1]
  if voice2[i1][0]!= ":r"
    play voice2[i1][0].to_i,sustain: voice2[i1][1]
    sleep 0.000001
  else
    sleep voice2[i1][1]
  end
  i1+=1
  if i1>=voice2.length
    stop
  end
end


i2=0
live_loop :LL2 do
  use_synth :piano
  #puts voice3[i2]
  puts midi2note(voice3[i2][0].to_i),voice3[i2][1]
  if voice3[i2][0]!= ":r"
    play voice3[i2][0].to_i,sustain: voice3[i2][1]
    sleep 0.000001
  else
    sleep voice3[i2][1]
  end
  i2+=1
  if i2>=voice3.length
    stop
  end
end

i3=0
live_loop :LL3 do
  use_synth :piano
  #puts voice4[i3]
  puts midi2note(voice4[i3][0].to_i),voice4[i3][1]
  if voice4[i3][0]!= ":r"
    play voice4[i3][0].to_i,sustain: voice4[i3][1]
    sleep 0.000001
  else
    sleep voice4[i3][1]
  end
  i3+=1
  if i3>=voice4.length
    stop
  end
end

i4=0
live_loop :LL4 do
  use_synth :piano
  #puts voice5[i4]
  puts midi2note(voice5[i4][0].to_i),voice5[i4][1]
  if voice5[i4][0]!= ":r"
    play voice5[i4][0].to_i,sustain: voice5[i4][1]
    sleep 0.000001
  else
    sleep voice5[i4][1]
  end
  i4+=1
  if i4>=voice5.length
    stop
  end
end

i5=0
live_loop :LL5 do
  use_synth :piano
  #puts voice6[i5]
  puts midi2note(voice6[i5][0].to_i),voice6[i5][1]
  if voice6[i5][0]!= ":r"
    play voice6[i5][0].to_i,sustain: voice6[i5][1]
    sleep 0.000001
  else
    sleep voice6[i5][1]
  end
  i5+=1
  if i5>=voice6.length
    stop
  end
end

