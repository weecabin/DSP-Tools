
import Foundation

func line(firsty:Float,lasty:Float,values:Int)->[Float]{
  let delta = (lasty-firsty)/(Float(values-1))
  var value = firsty
  var ret:[Float]=[]
  var count:Int = 0
  while(count < values){
    ret.append(value)
    value += delta
    count += 1
  }
  return ret
}

let rampPeak = Float(10)
var rampFilt = line(firsty:0,lasty:rampPeak,values:3)
rampFilt.append(contentsOf:line(firsty:rampPeak,lasty:0,values:3))
                
var ramp:[Float] = line(firsty:0,lasty:0,values:30)
ramp.append(contentsOf:rampFilt)
ramp.append(contentsOf:line(firsty:0,lasty:0,values:30))
print("computed ramp")
print(ramp)
print("computed rampFilt")
print(rampFilt)

func sinc(from:Float,to:Float,magnitude:Float=1,samples:Int)->[Float]{
  var y:[Float]=[]
  let delta = (to-from)/(Float(samples+1))
  var x = from
  while x <= to{
    y.append(magnitude*sin(x)/x)
    x += delta
  }
  return y
}

func coordValues(values:[Float],delta:Int)->String{
  var ret = ""
  var x = 0
  for val in values{
    ret.append("\(x),\(val) ")
    x += 10
  }
  return ret
}

let values = sinc(from:-25,to:25,magnitude:200,samples:50)
print("sinc as x,y")
print(coordValues(values:values,delta:10))


func Convolve(input:[Float],filter:[Float])->[Float]?{
  guard input.count >= filter.count else {
    print("input is smaller than filter")
    return nil
  }
  let iLen = input.count 
  let fLen = filter.count
  var y:[Float]=[]
  for i in (0...iLen+fLen-2){
    y.append(Float(0))
    for j in (0...fLen-1){
      let k = i-j
      if (k >= 0) && k < iLen{
        y[i] = y[i] + filter[j] * input[k]
      }
    }
  }
  return y
}

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