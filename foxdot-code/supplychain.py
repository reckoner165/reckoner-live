

Clock.bpm = 110


d1 >> play("- - ")


seq = " xo[( (x(xx)))o]"
fill = "oooo"
d2 >> play(" xo[xo]", sample=[5,6,7,8]).every(1, "stutter", 2, dur=Cycle([3,2]))

def get_sequence():
    if (int(Clock.now()) % 4 == 0):
        return " xo[( (x(xx)))o]"
    else:
        return "oooo"

a = var([seq, seq, seq, fill], 1)


print(int(Clock.now()), a)


p1 >> play("x-o-").every(4, "stutter", 4, dur=Cycle([3, 2]))
