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
  for i in (0...iLen+fLen-1){
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

let input:[Float]=[0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0]
let impulse:[Float]=[0,1,0]

let y = Convolve(input:input,filter:sinc(from:-20,to:20,samples:25))
print(y)

