import random as r

def rand_reg(regiones):
    return regiones[r.randint(0,len(regiones)-1)]


file_name = 'regiones.txt'
archivo = open(file_name, 'w')


for i in range(6000):
    num = r.randint(1,3)
    if num == 1:
        archivo.write('{},{},{},{},{},{},{},{}\n'.format('Monstad', 'Teyvat',i,round(r.uniform(0.0,100.0),3), r.randint(0,20),  r.randint(0,5),  r.randint(0,7), r.randint(0,7)))
    elif num == 2:
        archivo.write('{},{},{},{},{},{},{},{}\n'.format('Monstad', 'Teyvat',i,round(r.uniform(0.0,100.0),3), r.randint(0,20),  r.randint(0,5),  r.randint(0,7), r.randint(0,7)))
        archivo.write('{},{},{},{},{},{},{},{}\n'.format('Liyue', 'Teyvat',i,round(r.uniform(0.0,100.0),3), r.randint(0,20),  r.randint(0,5),  r.randint(0,7), r.randint(0,7)))
    elif num == 3:
        archivo.write('{},{},{},{},{},{},{},{}\n'.format('Monstad', 'Teyvat',i,round(r.uniform(0.0,100.0),3), r.randint(0,20),  r.randint(0,5),  r.randint(0,7), r.randint(0,7)))
        archivo.write('{},{},{},{},{},{},{},{}\n'.format('Liyue', 'Teyvat',i,round(r.uniform(0.0,100.0),3), r.randint(0,20),  r.randint(0,5),  r.randint(0,7), r.randint(0,7)))
        archivo.write('{},{},{},{},{},{},{},{}\n'.format('Inazuma', 'Teyvat',i,round(r.uniform(0.0,100.0),3), r.randint(0,20),  r.randint(0,5),  r.randint(0,7), r.randint(0,7)))

archivo.close()