import random as r

file_name = 'generate_gachapones.txt'
archivo = open(file_name, 'w')

def generate_rand_dates():
    return '{}-{}-{} {}:{}:{}'.format(r.randint(1,12),r.randint(1,28),r.randint(2020,2021), r.randint(0,23), r.randint(0,59), r.randint(0,59))

def generate_rand_type(types):
    return '{}'.format(types[r.randint(0,len(types)-1)])

tipo_gacha = [
    'banner permanente',
    'banner promocional',
    'banner armas',
    'banner de principiante'
]

for i in range(1000000):
    insert = '{},{},{},{}'.format(i,generate_rand_type(tipo_gacha), r.randint(0,20000), generate_rand_dates())
    archivo.write(insert+'\n')