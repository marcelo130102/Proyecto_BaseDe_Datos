import random as r

def generate_ramdom_mund(mundos):
    return mundos[r.randint(0,len(mundos)-1)]

mundos = [
    'Relajatetera',
    'Isla dorada'
]

file = 'mapas.txt'
archivo = open(file,'w')

for i in range(0,6000,r.randint(2,3)):
    mundo = generate_ramdom_mund(mundos)
    if mundo == 'Isla dorada':
        nm = 0
    else:
        nm = r.randint(0,7)
    archivo.write('{},{},{},{}\n'.format(mundo,i,round(r.uniform(0.0,100.0),3),nm))

archivo.close()