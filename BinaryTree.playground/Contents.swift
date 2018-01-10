//: Playground - noun: a place where people can play

import UIKit

//https://www.raywenderlich.com/139821/swift-algorithm-club-swift-binary-search-tree-data-structure
class Node<T> {
    var value: T
    //左子树
    var leftChild: Node?
    //右子树
    var rightChild: Node?
    
    
    init(value: T) {
        self.value = value
    }
}

enum BinaryTree<T: Comparable> {
    case empty
    //left child, value, right child
    indirect case node(BinaryTree, T, BinaryTree)
    
    //数量
    var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count
        case .empty:
            return 0
        }
    }
    
    //错误的方法
    mutating func naiveInsert(newValue: T) {
        //如果node是空的
        guard case .node(var left, let value, var right) = self else {
            self = .node(.empty, newValue, .empty)
            return 
        }
        if newValue < value {
            left.naiveInsert(newValue: newValue)
        }else{
            right.naiveInsert(newValue: newValue)
        }
    }
    
    private func newTreeWithInsertedValue(newValue: T) -> BinaryTree {
        switch self {
        case .empty:
            return .node(.empty, newValue, .empty)
        case let .node(left, value, right):
            if newValue < value {
                return .node(left.newTreeWithInsertedValue(newValue: newValue), value, right)
            } else {
                return .node(left, value, right.newTreeWithInsertedValue(newValue: newValue))
            }
        }
    }
    
    mutating func insert(newValue: T) {
        self = newTreeWithInsertedValue(newValue: newValue)
    }
    
}


extension BinaryTree: CustomStringConvertible {
    var description: String {
        switch self {
        case let .node(left, value, right):
            return "value: \(value), left = [" + left.description + "], right = [" + right.description + "]"
        case .empty:
            return ""
        }
    }
}


// leaf nodes
let node5 = BinaryTree.node(.empty, "5", .empty)
let nodeA = BinaryTree.node(.empty, "a", .empty)
let node10 = BinaryTree.node(.empty, "10", .empty)
let node4 = BinaryTree.node(.empty, "4", .empty)
let node3 = BinaryTree.node(.empty, "3", .empty)
let nodeB = BinaryTree.node(.empty, "b", .empty)

// intermediate nodes on the left
let Aminus10 = BinaryTree.node(nodeA, "-", node10)
let timesLeft = BinaryTree.node(node5, "*", Aminus10)

// intermediate nodes on the right
let minus4 = BinaryTree.node(.empty, "-", node4)
let divide3andB = BinaryTree.node(node3, "/", nodeB)
let timesRight = BinaryTree.node(minus4, "*", divide3andB)

// root node
let tree = BinaryTree.node(timesLeft, "+", timesRight)

print(tree)
tree.count




enum Media {
    case Book(title: String, author: String, year: Int)
    case Movie(title: String, director: String, year: Int)
    case WebSite(url: NSURL, title: String)
}

extension Media {
    var mediaTitle: String {
        switch self {
        case .Book(title: let aTitle, author: _, year: _):
            return aTitle
        case .Movie(title: let aTitle, director: _, year: _):
            return aTitle
        case .WebSite(url: _, title: let aTitle):
            return aTitle
        }
    }
}

let book = Media.Book(title: "20,000 leagues under the sea", author: "Jules Verne", year: 1870)
book.mediaTitle





