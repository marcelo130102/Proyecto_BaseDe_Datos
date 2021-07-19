import random as r

file_name = 'generate_gachapones.txt'
archivo = open(file_name, 'w')



def generate_rand_type(types):
    return '{}'.format(types[r.randint(0,len(types)-1)])

tipo_gacha = [
    'banner permanente',
    'banner promocional',
    'banner armas',
    'banner de principiante'
]

for i in range(995999):
    insert = '{},{},{}'.format(i,generate_rand_type(tipo_gacha), r.randint(0,20000))
    archivo.write(insert+'\n')