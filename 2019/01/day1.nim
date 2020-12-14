import strutils

proc solvePartOne: int =
    let masses = readFile("input.txt").splitLines

    for mass in masses[0..^2]:
        result += mass.parseInt div 3 - 2

proc solvePartTwo: int = 
    let masses = readFile("input.txt").splitLines

    for line in masses[0..^2]:
        var mass = line.parseInt

        while mass > 0:
            mass = mass div 3 - 2
            result += mass.clamp(0, int.high)
            echo mass
        
        echo ""

echo solvePartOne()
echo solvePartTwo()