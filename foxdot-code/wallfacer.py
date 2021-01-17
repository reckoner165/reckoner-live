Clock.bpm = 92

~d1 >> play('x x x x ', sample=1, amp=1, pan=0.5)
~d2 >> play(' - - - -', sample=0, pan=0.5).every(2,"stutter", var([2,4], 1)).shuffle()
