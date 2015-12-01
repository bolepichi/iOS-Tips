
import Foundation


// 错误泛型
public struct Error: ErrorType { let reason :String }


/**
 Printing version of try? Call either with standard or autoclosure approach
 
 let contents = attempt{try NSFileManager.defaultManager().contentsOfDirectoryAtPath(fakePath)}
 let contents = attempt{try NSFileManager.defaultManager().contentsOfDirectoryAtPath(XCPlaygroundSharedDataDirectoryURL.path!)}
 
 
 - Returns: Optional that is nil when the called closure throws
 */


public func attempt<T>(source source: String = __FUNCTION__,
    file: String = __FILE__,
    line: Int = __LINE__,
    closure: ()  throws -> T) -> Optional<T> {
        do {
            return try closure()
        } catch {
            
            let fileName = (file as NSString).lastPathComponent
            let report = "Error \(fileName):\(source):\(line):\n    \(error)"
            print(report)
            return nil
        }
        
}


/**
 可以打印内容并返回布尔值的 try? 可选实现
 
 
 let success = attemptFailable{try "Test".writeToFile(fakePath, atomically: true, encoding: NSUTF8StringEncoding)}
 
 
 - Returns: Boolean 值，如果被调用的闭包抛出错误返回 false，否则返回 true
 */
public func attemptFailable(source source: String = __FUNCTION__,
    file: String = __FILE__,
    line: Int = __LINE__,
    closure: () throws -> Void) -> Bool {
        do {
            try closure()
            return true
        } catch {
            let fileName = (file as NSString).lastPathComponent
            let report = "Error \(fileName):\(source):\(line):\n    \(error)"
            print(report)
            return false
        }
        
}



/**
 另外一个包含更多信息的 try! 版本。shouldCrash 是 false 时，即使有错误抛出，也会继续执行
 
 
 doOrDie(shouldCrash: false, closure: {try "Test".writeToFile(fakePath, atomically: true, encoding: NSUTF8StringEncoding)})
 // 或
 doOrDie(shouldCrash:false){try NSFileManager.defaultManager().removeItemAtURL(fakeURL)}
 // 或
 doOrDie{try "Test".writeToFile(fakePath, atomically: true, encoding: NSUTF8StringEncoding)}
 
 */
public func doOrDie(source: String = __FUNCTION__,
    file: String = __FILE__,
    line: Int = __LINE__,
    shouldCrash: Bool = true,
    closure: () throws -> Void) {
        
        let success = attemptFailable(source: source, file: file, line: line, closure: closure)
        if shouldCrash && !success {
            fatalError("Goodbye cruel world")
        }
}




