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
    y.append(magnitude*sin(x)/(x==0 ? 0.0000001 : x))
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