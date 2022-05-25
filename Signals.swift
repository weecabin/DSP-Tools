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
