

import Foundation

class Object{
    var name:String?
    var image:String?
    
    init(name : String , image:String){
        self.name = name
        self.image = image
    }
}

class List<T>{
    var value:T?
    var next:List<T>? = nil
    var previous : List<T>? = nil
    
    init(_ value : T){
        self.value = value
    }
}

class ListHandler{
    var head : List<Object>? = nil
    static let shared = ListHandler()
    private init(){
    }
    
    func create(arr : [Object]){
        var temp : List<Object>? = nil
        for ar in arr{
            if head == nil{
                head = List(ar)
                temp = head
            }else{
                temp?.next = List(ar)
                temp?.next?.previous = temp
                temp = temp?.next
            }
        }
    }
    
    func circular(_ lst:List<Object>){
        var temp = lst
        while temp.next != nil{
            temp = temp.next!
        }
        temp.next = head!
        temp.next!.previous = temp
    }
    
    
}

