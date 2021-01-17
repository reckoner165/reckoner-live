
Clock.bpm = 155

import random

~d1 >> play("[x( x)][ox][ x][ox][ x][ox][ (ox)]", dur=1,
sample=(5,6,7,8,9), rate=(d1.degree=='x')*(1.1) + (d1.degree=='o')*(1.015), amp=1 + (d1.degree=='o')*random.uniform(-0.6,0))

d1.stop()

~d2 >> play("-------", dur=1, sample=5, pan=0.3).stop()


~d3 >> play("::= ",
dur=1/4,
pan=-0.4,
sample=4,
room=0.6,
lpf=6500,
hpt=1500,
# amp=0.1)
amp=random.uniform(0.2,0.3))

def stop_drums():
    d1.stop()
    d2.stop()
    d3.stop()


~p1 >> prophet(P[2,3,4,5,2,3,P*[4,1]], pan=-0.4).stop()
~p2 >> bell(P[2,3,4,5,2,3,P*[4,1]], oct=P[5,6,7,8].mirror().stutter(), pan=0.8, dur=1/4, amp=0.2)

p2.stop()

bass_rhythm = [1]*2 + [rest(1/2)] + [1] + [rest(3/2)] + [1]*2
~p3 >> dbass(P[P*(1,5),P*(7,8),8,5,5,3,1], oct=4, lpf=500, dur=bass_rhythm)

~p1 >> saw([(3,5),(4,6)], dur=7, oct=4, sus=7, lpf=3000, amp=1)



Group(d1, d2).amplify = var([1,0,0.6,0],2)
d1.every(2, "stutter", 4).shuffle()


def blah():
    p4 >> pluck([1])
    Clock.future(16, Clock.clear)



stop_drums()


blah()
