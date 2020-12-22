include prelude
import npeg, deques, sequtils

# deck utils
type Deck = Deque[int]

proc addLast(deck: var Deck, a, b: int) =
  deck.addLast a
  deck.addLast b

proc `[]`(deck: var Deck, r: Slice[int]): Deck =
  for i in r:
    result.addLast deck[i]

proc score(deck: Deck): int =
  for i in 1..(deck.len):
    result += deck[^i] * i

# parser function
proc loadDecks(): (Deck, Deck) =
  let parser = peg("lines", res: (Deck, Deck)):
    lines <- deckOne * "\n" * deckTwo
    deckOne <- "Player 1:\n" * >+(+Digit * "\n"):
      res[0] = ($1).splitLines[0..^2].map(parseInt).toDeque
    deckTwo <- "Player 2:\n" * >+(+Digit * "\n"):
      res[1] = ($1).splitLines[0..^2].map(parseInt).toDeque

  doAssert parser.matchFile("input.txt", result).ok

# part one
proc solvePartOne: int =
  var (deckOne, deckTwo) = loadDecks()
  
  while deckOne.len > 0 and deckTwo.len > 0:
    let
      cardOne = deckOne.popFirst
      cardTwo = deckTwo.popFirst

    if cardOne > cardTwo:
      deckOne.addLast(cardOne, cardTwo)
    else:
      deckTwo.addLast(cardTwo, cardOne)
  
  if deckOne.len > 0:
    deckOne.score
  else:
    deckTwo.score

# part two
proc solvePartTwo: int =
  proc playGame(deckOne, deckTwo: var Deck): int =
    var seen: HashSet[Hash]

    while deckOne.len > 0 and deckTwo.len > 0:
      # stopping infinite recursion
      if seen.containsOrIncl (deckOne.toSeq, deckTwo.toSeq).hash:
        return 1

      let
        cardOne = deckOne.popFirst
        cardTwo = deckTwo.popFirst

      # checking for card amount condition
      if deckOne.len >= cardOne and deckTwo.len >= cardTwo:
        var 
          deckOneSlice = deckOne[0..<cardOne]
          deckTwoSlice = deckTwo[0..<cardTwo]

        result = playGame(
          deckOneSlice,
          deckTwoSlice
        )
      else: # normal gameplay
        if cardOne > cardTwo:
          result = 1
        else: 
          result = 2

      if result == 1:
        deckOne.addLast(cardOne, cardTwo)
      else:
        deckTwo.addLast(cardTwo, cardOne)

  var 
    (d1, d2) = loadDecks()
    winner = playGame(d1, d2)

  if winner == 1:
    d1.score
  else:
    d2.score

echo solvePartOne()
echo solvePartTwo()
