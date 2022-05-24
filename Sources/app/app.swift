// This is a basic program on Swift
//
// Try to modify and run it and check out
// the output in the terminal below
//
// Happy coding! :-)
import Foundation

func sinc(from:Float,to:Float,samples:Int)->[Float]{
  var y:[Float]=[]
  let delta = (to-from)/(Float(samples+1))
  var x = from
  while x <= to{
    y.append(sin(x)/x)
    x += delta
  }
  return y
}

//print(sinc(from:-20,to:20,samples:25))

func Convolve(input:[Float],filter:[Float])->[Float]{
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

func Correlate(input:[Float],filter:[Float])->[Float]{
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

print("Convolution")
let y = Convolve(input:s,filter:impulse)
print(y)
print("in: \(pulse.count) flit: \(impulse.count) out: \(y.count)")
print("ramp against itself")
print(Convolve(input:s1,filter:s1))
print("ramp against flipped ramp")
print(Convolve(input:s1,filter:s2))
print(Convolve(input:s5,filter:s4))

print("correlate")
print(Correlate(input:s1,filter:s3))
print(Correlate(input:s5,filter:s3))