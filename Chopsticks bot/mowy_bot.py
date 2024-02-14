# This bot uses an alpha-beta pruning algorithm to search if a move leads to a possible victory in the following 7 rounds.
# An exception on the pruning at the initial layer of depth of the search happens in the later stage of a game (defined as a state in which the
# highest number of fingers for a hand is >2) to verify if any move immediately ends the game with a victory.
# To make the bot faster, the first move as first player is imposed to be 'AB'.
# For the same reason, the first move as second player in case the tapped hand is 'A', is imposed to be 'AB'
# These decisions have been made by the author after several simulations of this code that proved that these moves do not lead to a defeat.

# check if a move is legal for player 1
def is_legal1(tapping_hand, tapped_hand, state):    
    if tapping_hand == tapped_hand: return False # must tap a different hand
    if state[tapping_hand] == 0: return False # tapping hand cannot be busted
    if state[tapped_hand] == 0 and not {tapping_hand, tapped_hand} == {'A', 'B'}: return False # split only allowed for own hands
    if state[tapped_hand] == 0 and state[tapping_hand] < 4: return False # split only allowed for hands with >= 4 fingers
    return True

# check if a move is legal for player 2
def is_legal2(tapping_hand, tapped_hand, state):    
    if tapping_hand == tapped_hand: return False # must tap a different hand
    if state[tapping_hand] == 0: return False # tapping hand cannot be busted
    if state[tapped_hand] == 0 and not {tapping_hand, tapped_hand} == {'C', 'D'}: return False # split only allowed for own hands
    if state[tapped_hand] == 0 and state[tapping_hand] < 4: return False # split only allowed for hands with >= 4 fingers
    return True

# simulation of the other player decision
def simulate2(state_dct,i):
    state = state_dct
    possible_moves = ['CA', 'CB', 'CD', 'DA', 'DB', 'DC']
    i-=1
# If after several simulated moves (decided below in the function generate_move), a win is not found, the bot passes to examine the following move.
    if i == 0: return 0 
    h = {}
    
    for move in possible_moves:
        tapping_hand = move[0]
        tapped_hand = move[1]
        if is_legal2(tapping_hand, tapped_hand, state):
    # what would be the state if this move is played
            state_next = state.copy()
            state_next[tapped_hand] += state_next[tapping_hand]
    # definition of busted hand
            if state_next[tapped_hand] > 5: state_next[tapped_hand] = 0
    # defining the splitting
            if (tapped_hand == 'C' or tapped_hand == 'D') and state[tapping_hand]==5 and state[tapped_hand]==0:
                state_next[tapped_hand]=3
                state_next[tapping_hand]=2
            if (tapped_hand == 'C' or tapped_hand == 'D') and state[tapping_hand]==4 and state[tapped_hand]==0:
                state_next[tapped_hand]=2
                state_next[tapping_hand]=2
    # If the opponent wins by using a certain move, the function returns -1
            if state_next['A']==0 and state_next['B']==0:
                return -1
    # If the opponent does not win with any move, the bot examines what would be the next move of the bot player.
    # In case a win is find (a loss for our bot), -1 is returned   
            h[move] = simulate1(state_next,i)
            if h[move]==-1: return -1 #pruning if a win (loss for our bot) is found
            
    best_move = min(h.values()) #The opponent wants to minimise the utility of the bot, therefore it will choose the first available won for it.
    return best_move

# simulation of the bot decision in the next round, given the move of the other player. Analogous to the previous code.
def simulate1(state_dct,i):
    state = state_dct
    possible_moves = ['AB', 'AC', 'AD', 'BA', 'BC', 'BD']
    i-=1
    if i == 0: return 0
    h = {}
    
    for move in possible_moves:
        tapping_hand = move[0]
        tapped_hand = move[1]
        if is_legal1(tapping_hand, tapped_hand, state):
            state_next = state.copy()
            state_next[tapped_hand] += state_next[tapping_hand]
            if state_next[tapped_hand] > 5: state_next[tapped_hand] = 0
            if (tapped_hand == 'A' or tapped_hand == 'B') and  state[tapping_hand]==5 and state[tapped_hand]==0:
                state_next[tapped_hand]=3
                state_next[tapping_hand]=2
            if (tapped_hand == 'A' or tapped_hand == 'B') and state[tapping_hand]==4 and state[tapped_hand]==0:
                state_next[tapped_hand]=2
                state_next[tapping_hand]=2

            if state_next['C']==0 and state_next['D']==0:
                return 1
            
            h[move] = simulate2(state_next,i)
            if h[move] == 1: return 1 # pruning
          
    best_move=max(h.values()) # Our bot wants to maximise its utility by winning a match, therefore it will choose the first available won for it.
    return best_move

# The function that generates a move, after checking if a move is legal and after having defined the "busting" and the "splitting".

def generate_move(state_str):
    state = {'A': int(state_str[1]), 'B': int(state_str[3]), 'C': int(state_str[5]), 'D': int(state_str[7])}
    possible_moves = ['AB', 'AC', 'AD', 'BA', 'BC', 'BD']
    i=14
    h = {}
    
    for move in possible_moves:
        tapping_hand = move[0]
        tapped_hand = move[1]
        if is_legal1(tapping_hand, tapped_hand, state):
            state_next = state.copy()
            state_next[tapped_hand] += state_next[tapping_hand]
            if state_next[tapped_hand] > 5: state_next[tapped_hand] = 0
        
            if (tapped_hand == 'A' or tapped_hand == 'B') and state[tapping_hand]==5 and state[tapped_hand]==0:
                state_next[tapped_hand]=3
                state_next[tapping_hand]=2
            
            if (tapped_hand == 'A' or tapped_hand == 'B') and state[tapping_hand]==4 and state[tapped_hand]==0:
                state_next[tapped_hand]=2
                state_next[tapping_hand]=2
        # after the usual definition, it checks if a move immediately terminates a game with a win.    
            if state_next['C']==0 and state_next['D']==0:
                return move
        # in case it is starting as first player it will start by 'AB'    
            if max(state['A'],state['B'],state['C'],state['D'])==1:
                return 'AB'
        # in case it is starting as second player and tapped hand in the first round was 'A', then it plays 'AB'
            elif state['A']==2 and max(state['B'],state['C'],state['D'])==1:
                return 'AB'
        # starting the search for a victory.
        # If the highest number of fingers on a playing hand is greater than 2, then the pruning is removed to allow a potential immediate won
            elif max(state['A'],state['B'],state['C'],state['D'])>2:
                h[move] = simulate2(state_next,i)
        # If the highest number of fingers considering all hands is 1 or 2, then pruning happens to reduce the playing.
            else:
                h[move] = simulate2(state_next,i)
                if h[move] == 1:
#                    print(h)
                    return move
    best_move = max(h, key=h.get)
#    print(h)
    return best_move
