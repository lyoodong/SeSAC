//
//  main.swift
//  BFS
//
//  Created by Dongwan Ryoo on 2023/10/26.
//

import Foundation

struct Queue<T> {
  var elements: [T] = []
  var index = 0 // front pointer

  var isEmpty: Bool {
    elements.count < index + 1
  }

  mutating func enqueue(_ data: T) {
    elements.append(data)
  }

  mutating func dequeue() -> T {
    let value = elements[index]
    index += 1
    return value
  }
}

func boardPrint(board: [[Int]]) {
  for y in 0..<board.count {
    for x in 0..<board[0].count {
      print(board[y][x], terminator: " ")
    }
    print("")
  }
}

let input = readLine()!.split(separator: " ").map { Int($0)! }
let n = input[0]
let m = input[1]

var board: [[Int]] = []
var vis: [[Int]] = .init(repeating: .init(repeating: -1 , count: m ) , count: n)

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

for  _ in 1...n {
    let input = readLine()!.map { Int(String($0))!}
    board.append(input)
}

print(board)

//var queue = Queue<(Int, Int)>()
//queue.enqueue((0, 0))


var queue: [(Int, Int)] = []
var index = 0
queue.append((0, 0))


//거리를 표시하기 위해 vis에 정수를 넣음
vis [0][0] = 1

//while !queue.isEmpty  {
while queue.count >= index + 1 {
    
//    let cur = queue.dequeue()
    
    let cur = queue[index]
    for dir in 0..<4 {
        let ny = cur.0 +  dy[dir]
        let nx = cur.1 +  dx[dir]
        
        if ny < 0 || ny >= n || nx < 0 || nx >= m { continue }
        if vis[ny][nx] != -1 { continue}
        if board[ny][nx] == 0 { continue }
        
        queue.append((ny, nx))
//        queue.enqueue((ny, nx))
        vis[ny][nx] = vis[cur.0][cur.1] + 1
    }
}

boardPrint(board: vis)
print(vis[n - 1][m - 1])


//큐를 야매로 구현할 수 있다. 배열을 통해서
//플러드 필의 시간복잡도 O(NM) 


