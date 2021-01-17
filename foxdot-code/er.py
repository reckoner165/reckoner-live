
er_path = '/Users/Srinivasan/Music/ReckonerLive/LIVE/ER/'

for i in range(1,7):
    filename = 'ER' + str(i) + '.wav'
    p1 >> loop(er_path + filename, P[0,1,2], dur=(48), striate=100)



~p1.stop()
