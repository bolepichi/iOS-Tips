

import Foundation

// 借助于 map 和 flapMap 函数能够很轻易地将数组转换成另外一个新数组


//------------- Map


let array_Fruit = ["Apple","Mandarin","Banana","Orange","Pear"]



// map函数的闭包接收一个字符串(类型为string)作为参数，原因在于我们调用函数处理的数组元素类型为String。本例中，我们想要返回一个整型数组，逐个对应字符串元素成员的字符长度。因此闭包的返回类型为Int?.

let map_Array = array_Fruit.map { (string: String) -> Int? in
    let length = string.characters.count
    
    guard length > 0 else {
        return nil
    }
    
    return string.characters.count
}

print(map_Array)





// --------------- FlatMap

/**
*  flatMap很像map函数，但是它摒弃了那些值为nil的元素。
*/

let flatMap_Array = array_Fruit.flatMap { (string: String) -> Int? in
    
    let length = string.characters.count
    
    guard length > 0 else {
        return nil
    }
    
    return string.characters.count
}

print(flatMap_Array)

//另外一个与map函数不同之处在于：倘若元素值不为nil情况下，flapMap函数能够将可选类型(optional)转换为非可选类型(non-optionals)。


