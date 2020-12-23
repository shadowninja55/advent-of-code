# NOTE: this solution was blatantly copied from 
# https://github.com/narimiran/AdventOfCode2020/blob/master/nim/day23.nim 
# because i'm not smart enough to figure out why my
# singly linked ring wasn't working

const input = "916438275"

proc buildQuasiLinkedList(input: string, length: int): seq[int] =
  result = newSeq[int](length + 1)

  var prev =
    if length == input.len: 
      input[^1].ord - 48
    else: 
      length

  for c in input:
    let n = c.ord - 48
    result[prev] = n
    prev = n

  for n in 10..length:
    result[prev] = n
    prev = n

proc playRound(next: var seq[int], head: var int, size: int) =
  let three = [
    next[head],
    next[next[head]],
    next[next[next[head]]]
  ]

  var dest = head - 1

  if dest == 0: 
    dest = size

  while dest in three:
    dec dest

    if dest == 0: 
      dest = size

  next[head] = next[three[^1]]
  next[three[^1]] = next[dest]
  next[dest] = three[0]
  head = next[head]

proc solvePartOne: string =
  let size = input.len

  var 
    next = input.buildQuasiLinkedList size
    head = input[0].ord - 48

  for _ in 1..100:
    playRound(next, head, size)

  head = 1

  for _ in 1 ..< size:
    head = next[head]
    result.add $head
  
proc solvePartTwo: int =
  let size = 1_000_000

  var 
    next = input.buildQuasiLinkedList size
    head = input[0].ord - 48

  for _ in 1..(10 * size):
    playRound(next, head, size)

  result = next[1] * next[next[1]]

echo solvePartOne()
echo solvePartTwo()