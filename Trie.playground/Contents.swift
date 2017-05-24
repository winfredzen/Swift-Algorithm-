//: Playground - noun: a place where people can play

import UIKit

//https://www.raywenderlich.com/139410/swift-algorithm-club-swift-trie-data-structure

//字典树
//1.需遵循Hashable协议，因为value要为key
class TrieNode<T: Hashable> {
    var value: T?
    //表示一个word的结束
    var isTerminating = false
    weak var parent: TrieNode?
    var children: [T: TrieNode] = [:]
    
    init(value: T? = nil, parent: TrieNode? = nil) {
        self.value = value
        self.parent = parent
    }
    
    func add(child: T)  {
        //children字典中不存在child
        guard children[child] == nil else {
            return
        }
        children[child] = TrieNode(value: child, parent: self)
    }
    
}

//Tire管理nodes
class Trie {
    //别名
    typealias Node = TrieNode<Character>
    fileprivate let root: Node
    init() {
        root = Node()
    }
}

extension Trie {
    func insert(word: String)  {
        guard !word.isEmpty else {
            return
        }
        var currentNode = root
        //word转为character数组
        let characters = Array(word.lowercased().characters)
        var currentIndex = 0
        while currentIndex < characters.count {
            //待插入的character
            let character = characters[currentIndex]
            //存在的话就移动到下一个node
            if let child = currentNode.children[character] {
                currentNode = child
            }else{
                //不存在就添加，然后currentNode设为新的node
                currentNode.add(child: character)
                currentNode = currentNode.children[character]!
            }
            currentIndex += 1
        }
        if currentIndex == characters.count {
            currentNode.isTerminating = true
        }
    }
    
    func contains(word: String) -> Bool {
        guard !word.isEmpty else { return false }
        var currentNode = root
        
        let characters = Array(word.lowercased().characters)
        var currentIndex = 0
        
        while currentIndex < characters.count, let child = currentNode.children[characters[currentIndex]] {

            currentIndex += 1
            currentNode = child
            
        }
        
        if currentIndex == characters.count && currentNode.isTerminating {
            return true
        } else {
            return false
        }
        
    }
    
}

//测试
let trie = Trie()

trie.insert(word: "cute")

trie.contains(word: "cute") // true

trie.contains(word: "cut") // false
trie.insert(word: "cut")
trie.contains(word: "cut") // true











