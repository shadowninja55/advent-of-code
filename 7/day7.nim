import npeg, sequtils, sets, strutils, tables

type RuleMap = Table[string, seq[(string, int)]]

proc makeRuleMap(rules: string): RuleMap =
    var children: seq[(string, int)]

    let parser = peg("rules", ruleMap: RuleMap):
        rules <- *rule
        rule <- >color * " bags contain " * children * "\n":
            ruleMap[$1] = children
            children.setLen(0)

        color <- +Alpha * " " * +Alpha
        children <- "no other bags." | (child * *(", " * child) * ".")
        child <- >Digit * " " * >color * (" bags" | " bag"):
            children.add(($2, parseInt($1)))

    assert parser.match(rules, result).ok

proc solvePartOne(ruleMap: RuleMap, target: string): int =
    var queue = toSeq(ruleMap.pairs)
    var parents = initHashSet[string]()

    while queue.len > 0:
        let (parentColor, childColors) = queue.pop()

        for childColor, _ in childColors.items:
            if childColor == target:
                parents.incl(parentColor)

            queue.add((parentColor, ruleMap[childColor]))

    parents.len

proc solvePartTwo(ruleMap: RuleMap, target: string): int =
    var queue = @[(target, ruleMap[target])]

    while queue.len > 0:
        let (parentColor, childColors) = queue.pop()

        for childColor, amount in childColors.items:
            for _ in 1..amount:
                inc result
                queue.add((parentColor, ruleMap[childColor]))

let ruleMap = makeRuleMap(readFile("input.txt"))
echo solvePartOne(ruleMap, "shiny gold")
echo solvePartTwo(ruleMap, "shiny gold")
