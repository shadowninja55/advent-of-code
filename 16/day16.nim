import npeg, sequtils, sets, strutils, sugar, tables

type
    RuleMap = Table[string, set[0..65535]]
    Ticket = seq[int]

proc parseInput: (RuleMap, Ticket, seq[Ticket]) =
    var
        ruleMap: RuleMap
        myTicket: Ticket
        tickets: seq[Ticket]

    let parser = peg("data"):
        Num <- +Digit
        data <- rules * "\n" * myTicket * "\n" * tickets

        # parsing rules
        rules <- +rule
        rule <- >+(Lower | " ") * ": " * >Num * "-" * >Num * " or " * >Num *
                "-" * >Num * "\n":
            ruleMap[$1] = {parseInt($2)..parseInt($3), parseInt($4)..parseInt($5)}

        # parsing your ticket
        myTicket <- "your ticket:\n" * >+(Digit | ",") * "\n":
            myTicket = ($1).split(',').map(parseInt)

        # parsing other tickets
        tickets <- "nearby tickets:\n" * +ticket
        ticket <- >+(Digit | ",") * "\n":
            let values = ($1).split(',').map(parseInt)
            tickets.add values

    assert parser.matchFile("input.txt").ok

    return (ruleMap, myTicket, tickets)

proc isValid(value: int, ruleMap: RuleMap): bool =
    for validRange in ruleMap.values:
        if value in validRange:
            return true

proc solvePartOne: int =
    let (ruleMap, _, tickets) = parseInput()

    for ticket in tickets:
        for value in ticket:
            if not value.isValid ruleMap:
                result += value

proc solvePartTwo: int =
    let (ruleMap, myTicket, tickets) = parseInput()

    # getting valid tickets
    var validTickets = collect newSeq:
        for ticket in tickets:
            block valid:
                for value in ticket:
                    if not value.isValid ruleMap:
                        break valid

                ticket

    # guessing order
    var possFieldSets = toSeq(ruleMap.keys).toHashSet.repeat ruleMap.len

    # filtering by valid positions
    for ticket in validTickets:
        for i, value in ticket:
            for rule, validRange in ruleMap:
                if value notin validRange:
                    possFieldSets[i].excl rule

    # filtering by singles
    block filtered:
        while true:
            for i in 0..possFieldSets.high:
                if possFieldSets[i].len == 1:
                    for j in 0..possFieldSets.high:
                        if j != i:
                            possFieldSets[j].excl possFieldSets[i].toSeq[0]

            block valid:
                for possFieldSet in possFieldSets:
                    if possFieldSet.len > 1:
                        break valid

                break filtered

    var ruleOrder = possFieldSets.mapIt(it.toSeq[0])

    result = 1

    for i, rule in ruleOrder:
        if rule.startsWith "departure":
            result *= myTicket[i]

echo solvePartOne()
echo solvePartTwo()
