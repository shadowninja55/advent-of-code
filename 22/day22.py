import time
from collections import deque
from itertools import islice

def play_game(player_1,player_2):
    all_rounds = {1:set(),2:set()}
    while len(player_1) != 0 and len(player_2) != 0:
        t_player_1 = tuple(player_1)
        t_player_2 = tuple(player_2)
        if t_player_1 in all_rounds[1] and t_player_2 in all_rounds[2]:
            return (1,player_1)
        else:
            all_rounds[1].add(t_player_1)
            all_rounds[2].add(t_player_2)

        card_player_1 = player_1.popleft()
        card_player_2 = player_2.popleft()

        if len(player_1) >= card_player_1 and len(player_2) >= card_player_2:
            round_winner,_ = play_game(deque(islice(player_1,card_player_1)),deque(islice(player_2,card_player_2)))
        elif card_player_1 > card_player_2:
            round_winner = 1
        else:
            round_winner = 2
        
        if round_winner == 1:
            player_1.append(card_player_1)
            player_1.append(card_player_2)
        else:
            player_2.append(card_player_2)
            player_2.append(card_player_1)

    if len(player_1) == 0:
        winner = (2,player_2)
    else:
        winner = (1,player_1)
    return winner

def main():
    filename = 'input.txt'
    #filename = 'example'
    with open(filename,'r') as infile:
        entries = [line.strip() for line in infile.read().strip().split("\n\n")]

    player_1 = deque(int(i) for i in entries[0].split("\n")[1:])
    player_2 = deque(int(i) for i in entries[1].split("\n")[1:])

    player, winner = play_game(player_1,player_2)

    score = 0
    for index,i in enumerate(reversed(winner),start=1):
        score+= index*i

    print(score)
    
main()