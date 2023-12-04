



Clock.bpm = 86
import random
~d1 >> play('X X X X ', sample=4, lpf=4000, amp=0.9).every(8, "stutter",2)

~d3 >> play('~~~~', sample=5, amp=random.uniform(0.8,1.2), rate=random.uniform(0.88,1.15))


# tmb = '/Users/Srinivasan/Music/ReckonerLive/LIVE/Empire/tambourine.wav'

set_empire()
~d2 >> loop(tmb, amp = 1.6, pan=0.2)

samples_path = "/Users/Srinivasan/anaconda3/lib/python3.6/site-packages/FoxDot/snd/"


def set_empire():
    Clock.bpm = 86
    import random
    global tmb
    tmb = '/Users/Srinivasan/Music/ReckonerLive/LIVE/Empire/tambourine.wav'
