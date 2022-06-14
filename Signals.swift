import Foundation

func add(line1:[Float],offset1:Int=0,line2:[Float],offset2:Int)->[Float]{
  var ret:[Float]=[]
  let line1MaxIndex = line1.count + offset1 - 1
  let line2MaxIndex = line2.count + offset2 - 1
  let maxIndex = line1MaxIndex > line2MaxIndex ? line1MaxIndex : line2MaxIndex
  for i in (0...maxIndex){
    var y1 = Float(0)
    var y2 = Float(0)
    if i >= offset1 && i <= line1MaxIndex{
      y1 = line1[i-offset1]
    }
    if i >= offset2 && i < line2MaxIndex{
      y2 = line2[i-offset2]
    }
    ret.append(y1+y2)
  }
  return ret
}
func line(firsty:Float,lasty:Float,values:Int,outStartIndex:Int=0)->[Float]{
  let delta = (lasty-firsty)/(Float(values-1))
  var value = firsty
  var ret:[Float]=[]
  var count:Int = 0
  while(count < values){
    if count>=outStartIndex{
      ret.append(value)
    }
    value += delta
    count += 1
  }
  return ret
}

func coordValues(values:[Float],delta:Int)->String{
  var ret = ""
  var x = 0
  for val in values{
    ret.append("\(x),\(val) ")
    x += delta
  }
  return ret
}

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

func sinc(from:Float,to:Float,magnitude:Float=1,samples:Int)->[Float]{
  var y:[Float]=[]
  let delta = (to-from)/(Float(samples-1))
  var x = from
  while x <= to{
    y.append(magnitude*sin(1.5*x)/(x==0 ? 0.0000001 : 1.5*x))
    x += delta
  }
  return y
}

func sinWave(from:Float,to:Float,magnitude:Float=1,samples:Int)->[Float]{
  var y:[Float]=[]
  let delta = (to-from)/(Float(samples-1))
  var x = from
  while x <= to{
    y.append(magnitude*sin(x))
    x += delta
  }
  return y
}

class Lpf{
    init(b:Float=0.1){
        self.b = b
    }
    func Setup(b:Float){
        self.b=b
    }
    var y:Float = 0
    var b:Float = 0
    private var unity:Bool = true
    func Next(x:Float)->Float{
      y += b*(x - y)
      return y
    }
}

/*
a0 = (1+x)/2 
a1 = -(1&x)/2 
b1 = x
*/
class Hpf{
    init(decay:Float=0.1){
        lpf=Lpf(b:decay)
    }
    func Next(x:Float)->Float{
        x - lpf.Next(x:x)
    }
    var lpf:Lpf
}

class Filt{
    init(){
        a1=0.9
        b1=0.85
        b0=0
    }
    init(ay1:Float,bx0:Float,bx1:Float){
        a1=ay1
        b0=bx0
        b1=bx1
    }
    func Next(x:Float)->Float{
        y1 = a1*y1 + b0*x + b1*x1
        x1 = x
        return y1
    }
    var a1:Float=0.9
    var b0:Float=0
    var b1:Float=0.85
    var x1:Float=0
    var y1:Float=0
}
// complementary filter components...
// LPF
// y[n]=(1-alpha)*x[n]+alpha*y[n-1]
// HPF
// y[n]=(1-alpha)y[n-1]+(1-alpha)(x[n]-x[n-1])
// addition...
// angle = (1-alpha)*(HPF) + (alpha)*(LPF)
// (1-alpha)*(HPF) = (1-2alpha+alpha^2)*y[n-1] + (alpha - alpha^2)*(x(n) - x(n-1)
//.  = y1 - 2*alpha*y1 +alpha^2*y1 - alpha*