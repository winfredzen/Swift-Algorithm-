//: Playground - noun: a place where people can play

import UIKit

//来自https://www.raywenderlich.com/138190/swift-algorithm-club-swift-tree-data-structure
//general-purpose tree.

class Node {
    var value: String
    var children: [Node] = []
    weak var parent: Node?
    
    init(value: String) {
        self.value = value
    }
    
    //Insertion 插入
    func  add(child: Node) {
        children.append(child)
        child.parent = self
    }
}

extension Node: CustomStringConvertible {
    //只读计算属性
    var description: String {
        var text = "\(value)"
        if !children.isEmpty {
            text += " {" + children.map {$0.description}.joined(separator: ", ") + "} "
        }
        return text
    }
}

//搜索
extension Node {
    func search(value: String) -> Node? {
        if value == self.value {
            return self
        }
        for child in children {
            if let found = child.search(value: value) {
                return found
            }
        }
        return nil
    }
}


//测试
let beverages = Node(value: "beverages")

let hotBeverage = Node(value: "hot")
let coldBeverage = Node(value: "cold")

let tea = Node(value: "tea")
let coffee = Node(value: "coffee")
let cocoa = Node(value: "cocoa")

let blackTea = Node(value: "black")
let greenTea = Node(value: "green")
let chaiTea = Node(value: "chai")

let soda = Node(value: "soda")
let milk = Node(value: "milk")

let gingerAle = Node(value: "ginger ale")
let bitterLemon = Node(value: "bitter lemon")

beverages.add(child: hotBeverage)
beverages.add(child: coldBeverage)

hotBeverage.add(child: tea)
hotBeverage.add(child: coffee)
hotBeverage.add(child: cocoa)

coldBeverage.add(child: soda)
coldBeverage.add(child: milk)

tea.add(child: blackTea)
tea.add(child: greenTea)
tea.add(child: chaiTea)

soda.add(child: gingerAle)
soda.add(child: bitterLemon)

print(beverages)


//测试 搜索
beverages.search(value: "cocoa") // returns the "cocoa" node
beverages.search(value: "chai") // returns the "chai" node
beverages.search(value: "bubbly") // returns nil


//泛型
class NodeG<T> {
    var value: T
    weak var parent: NodeG?
    var children: [NodeG] = []
    
    init(value: T) {
        self.value = value
    }
    
    func add(child: NodeG) {
        children.append(child)
        child.parent = self
    }
    
}

extension NodeG where T: Equatable {
    func search(value: T) -> NodeG? {
        if value == self.value {
            return self
        }
        for child in children {
            if let found = child.search(value: value) {
                return found
            }
        }
        return nil
    }
}









