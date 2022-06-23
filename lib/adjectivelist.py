
# simple program to make all of the adjectives so i can copy it over
f = open('C:/Users/apfox/OneDrive/Documents/AAC-App/lib/english-adjectives.txt',
         'r').read().split("\n")
n = open("lib/formatted.txt", 'w')
for adj in f:
    n.write('Adjective(name: "'+adj+'", color: randomColor()),\n')

n.close()
