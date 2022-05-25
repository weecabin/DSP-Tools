
import Foundation

let rampPeak = Float(20)
var rampFilt = line(firsty:0,lasty:rampPeak,values:3)
rampFilt.append(contentsOf:line(firsty:rampPeak,lasty:0,values:3,outStartIndex:1))

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

*/
print("sine wave with ramp pulse added")
let sinw = sinWave(from:-25,to:25,magnitude:5,samples:100)
print("sin count: \(sinw.count)")
let added = add(line1:rampFilt,offset1:50,line2:sinw,offset2:0)
print("added count: \(added.count)")
print(added)
print("as x,y")
print(coordValues(values:added,delta:5))
print("correlate with ramp")
let corr = Correlate(sig1:added,sig2:rampFilt)
print(coordValues(values:corr,delta:5))
