
import Foundation

func Impulse(x:Float)->Float{
    if x==10{return 1}
    return 0
}
func Step(x:Float)->Float{
    if x>=10{return 1}
    else{return 0}
}
let rampPeak = Float(20)
var rampFilt = line(firsty:0,lasty:rampPeak,values:3)
rampFilt.append(contentsOf:line(firsty:rampPeak,lasty:0,values:3,outStartIndex:1))

var hpf = Hpf()
var lpf = Lpf()
var filt = Filt(ay1:-0.9,bx0:0.1,bx1:0.7)
var x:[Float]=[]
for i in (0...75){
    x.append(Step(x:Float(i)))
}

var res:String=""
for val in x{
  res.append("\(String(format: "%.2f",filt.Next(x:val))) ")
}
print(res)
/*
x = []
for i in (0...50){
    if i > 10{x.append(1)}
    else {x.append(0)}
}

lpf = Lpf(b:0.2)
var lpf2 = Lpf(b:0.2)
print ("\nStep response cascaded\n b=\(lpf.b)")
res=""
for val in x{
  res.append("\(String(format: "%.2f",lpf2.Next(x:lpf.Next(x:val)))) ")
}
print(res)

lpf = Lpf(b:0.05)
print ("\n b=\(lpf.b)")
res=""
for val in x{
  res.append("\(String(format: "%.2f",lpf.Next(x:val))) ")
}
print(res)

x = []
for i in (0...30){
    if i == 10{x.append(1)}
    else {x.append(0)}
}

lpf = Lpf()
print ("\nImpulse response\n b=\(lpf.b)")
res=""
for val in x{
  res.append("\(String(format: "%.2f",lpf.Next(x:val))) ")
}
print(res)

lpf = Lpf(b:0.1)
lpf2 = Lpf(b:0.1)
print ("\nImpulse response cascaded\n b=\(lpf.b)")

res=""
for val in x{
  res.append("\(String(format: "%.2f",lpf2.Next(x:lpf.Next(x:val)))) ")
}
print(res)

lpf = Lpf(b:0.05)
print ("\n b=\(lpf.b)")
res=""
for val in x{
  res.append("\(String(format: "%.2f",lpf.Next(x:val))) ")
}
print(res)

*/
/*
var ramp:[Float] = line(firsty:0,lasty:0,values:30)
ramp.append(contentsOf:rampFilt)
ramp.append(contentsOf:line(firsty:0,lasty:0,values:30))
print("computed ramp")
print(ramp)
print("computed rampFilt")
print(rampFilt)

let values = sinc(from:-25,to:25,magnitude:200,samples:50)
print("sinc as x,y")
print(coordValues(values:values,delta:10))



func Correlate(sig1:[Float],sig2:[Float])->[Float]{
  var input:[Float]
  var filter:[Float]
  if sig1.count >= sig2.count{
    input = sig1
    filter = sig2
  }else{
    input = sig2
    filter = sig1
  }
  let iLen = input.count 
  let fLen = filter.count
  var y:[Float]=[]
  for i in (0...iLen-fLen){
    y.append(Float(0))
    for j in (0...fLen-1){
      y[i] = y[i] + filter[j] * input[i+j]
    }
  }
  return y
}

let s = sinc(from:-20,to:20,samples:25)
let pulse:[Float]=[0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0]
let impulse:[Float]=[0,0,0,0,0,0,1,0,0]
let s1:[Float]=[1,1,1,1,1,1,1,1,1,2,3,4,5,1,1,1,1,1,1,1,1,1]
let s2:[Float]=[1,1,1,1,5,4,3,2,1,1,1,1]
let s3:[Float]=[1,2,3,4,5,1]
let s4:[Float]=[1,5,4,3,2,1]
let s5:[Float]=[1,1,1,2,3,4,5,1,1,1,1,1,1,1,1,1]


print("\nConvolution")
if let y = Convolve(input:s,filter:impulse){
  print(y)
}

print("ramp against itself")
if let y = Convolve(input:ramp,filter:ramp){
  print(y)
}

print("ramp against flipped ramp")
if let y = Convolve(input:s1,filter:s2){
  print(y)
}

if let y = Convolve(input:s5,filter:s4){
  print(y)
}

print("\nCorrelation")
print(Correlate(sig1:rampFilt,sig2:ramp))
print("as x,y")
print(coordValues(values:Correlate(sig1:rampFilt,sig2:ramp),delta:10))


print("sine wave with ramp pulse added")
let sinw = sinWave(from:-25,to:25,magnitude:5,samples:150)
print("sin count: \(sinw.count)")
let added = add(line1:rampFilt,offset1:50,line2:sinw,offset2:0)
print("added count: \(added.count)")
print(added)
print("as x,y")
print(coordValues(values:added,delta:5))
print("correlate with ramp")
var corr = Correlate(sig1:added,sig2:rampFilt)
print(coordValues(values:corr,delta:5))

print("sine wave with sinc pulse added")
let s = sinc(from:-15,to:15,magnitude:15,samples:50)
print("sinc pulse")
print(coordValues(values:s,delta:5))
let addSinc = add(line1:s,offset1:50,line2:sinw,offset2:0)
print("sin wave with sinc pulse")
print(coordValues(values:addSinc,delta:5))
print("correlate with sinc")
corr = Correlate(sig1:addSinc,sig2:s)
print(coordValues(values:corr,delta:10))
*/
