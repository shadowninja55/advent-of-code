import npeg, strformat, strutils, tables

type Vector = tuple[x, y: int]

proc solvePartOne(): int =
    const degToVec: Table[int, Vector] = {
        0: (0, 1),
        90: (1, 0),
        180: (0, -1),
        270: (-1, 0)
    }.toTable()

    var shipPos: Vector
    var degrees = 90
    var rotation = degToVec[degrees]

    let parser = peg("directions"):
        directions <- +direction
        direction <- >Upper * >+Digit * "\n":
            let num = parseInt $2

            case $1:
                of "N": shipPos.y += num
                of "S": shipPos.y -= num
                of "E": shipPos.x += num
                of "W": shipPos.x -= num
                of "L":
                    degrees = (degrees + 360 - num) mod 360
                    rotation = degToVec[degrees]
                of "R":
                    degrees = (degrees + num) mod 360
                    rotation = degToVec[degrees]
                of "F":
                    shipPos.x += num * rotation.x
                    shipPos.y += num * rotation.y
                else:
                    discard

    assert parser.matchFile("input.txt").ok

    abs(shipPos.x) + abs(shipPos.y)

proc solvePartTwo(): int =
    var shipPos: Vector
    var wpPos: Vector = (10, 1)

    let parser = peg("directions"):
        directions <- +direction
        direction <- >Upper * >+Digit * "\n":
            let num = parseInt $2

            case $1:
                of "N": wpPos.y += num
                of "S": wpPos.y -= num
                of "E": wpPos.x += num
                of "W": wpPos.x -= num
                of "L":
                    for _ in 1..((360 - num) div 90):
                        swap(wpPos.x, wpPos.y)
                        wpPos.y *= -1
                of "R":
                    for _ in 1..(num div 90):
                        swap(wpPos.x, wpPos.y)
                        wpPos.y *= -1
                of "F":
                    shipPos.x += wpPos.x * num
                    shipPos.y += wpPos.y * num
                else:
                    discard

    assert parser.matchFile("input.txt").ok

    abs(shipPos.x) + abs(shipPos.y)

echo solvePartOne()
echo solvePartTwo()
