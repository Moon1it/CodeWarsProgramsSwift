import Foundation

func correctRegularEx(_ str: String) -> Int{
    let pattener = "^[0-9]*:[0-9]*:[0-9]*$"
    let range = NSMakeRange(0, str.count)
    let result = try! NSRegularExpression(pattern: pattener, options: [])
    let results = result.numberOfMatches(in: str, options: [], range: range)
    return results
}

func transformTime(_ currentLevel: Int,_ nextLevel: Int?) -> (Int, Int?){
    var cur = 0
    if nextLevel == nil{
        if currentLevel >= 24{ // Часы
            cur = currentLevel % 24
        }
        return (cur, nil)
    }else{
        var next = 0
        if currentLevel >= 60{
            cur = currentLevel % 60 //timeInt[2]
            next = nextLevel! + currentLevel / 60 //timeInt[1]
        }
    return (cur, next)
    }
}

func correct(_ timeString: String?) -> String? {
    if timeString == "" || timeString == nil{ return timeString } // Проверка на "" и nil
    if correctRegularEx(timeString!) != 1{ return nil } // Поверка по регулярному выражению
    var timeInt = timeString!.split(whereSeparator: {$0 == ":"}).compactMap{ Int($0) }
    
    var timeResult = transformTime(timeInt[2], timeInt[1])
    timeInt[2] = timeResult.0
    timeInt[1] = timeResult.1!
    timeResult = transformTime(timeInt[1], timeInt[0])
    timeInt[1] = timeResult.0
    timeInt[0] = timeResult.1!
    timeResult = transformTime(timeInt[0], nil)
    timeInt[0] = timeResult.0
    
    var outputStr = ""
    for (i, elem) in timeInt.enumerated(){
        if String(elem).count != 2{
            outputStr += "0" + String(elem)
        }else{
            outputStr += String(elem)
        }
        if i != timeInt.count-1 { outputStr += ":" }
    }
    return outputStr
}
correct("59:88:125")
