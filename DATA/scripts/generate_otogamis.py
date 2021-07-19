import random as r

def generate_rand_objects(names):
    nombre = names[r.randint(0,len(names)-1)]
    return nombre

def generate_rand_dates():
    return '{}-{}-{} {}:{}:{}'.format(r.randint(1,12),r.randint(1,28),r.randint(2020,2021), r.randint(0,23), r.randint(0,59), r.randint(0,59))

objects = {}
names = []
file_name = 'objetos/armas.txt'
archivo = open(file_name, 'r+')

i = 0
for object in archivo:
    object = object.replace('\n', '')
    names.append(object)
    objects.update(
        {object:{
            'id':i,
            'tipo_obj': 'arma',
            'obj_estrella': r.randint(1,5)
    }})
    i += 1

archivo.close()

file_name = 'objetos/materiales.txt'
archivo = open(file_name, 'r+')
for object in archivo:
    object = object.replace('\n', '')
    names.append(object)
    objects.update(
        {object:{
            'id':i,
            'tipo_obj': 'material_recolectable',
            'obj_estrella': r.randint(1,5)
    }})
    i += 1

archivo.close()

file_name = 'objetos/personajes.txt'
archivo = open(file_name, 'r+')
for object in archivo:
    object = object.replace('\n', '')
    names.append(object)
    objects.update(
        {object:{
            'id':i,
            'tipo_obj': 'personaje',
            'obj_estrella': 4
    }})
    i += 1
archivo.close()

file_name = 'objetos/personajes5.txt'
archivo = open(file_name, 'r+')
for object in archivo:
    object = object.replace('\n', '')
    names.append(object)
    objects.update(
        {object:{
            'id':i,
            'tipo_obj': 'personaje',
            'obj_estrella': 5
    }})
    i += 1
archivo.close()

file_name = 'objetos/artefactos.txt'
archivo = open(file_name, 'r+')
for object in archivo:
    object = object.replace('\n', '')
    names.append(object)
    objects.update(
        {object:{
            'id':i,
            'tipo_obj': 'artefacto',
            'obj_estrella': r.randint(1,5)
    }})
    i += 1
archivo.close()

k = 0
file_name = 'otorgagacha.txt'
archivo = open(file_name, 'w')

for i in range(6000):
    for j in range(r.randint(0,30),r.randint(31,100),1):
        temp = generate_rand_objects(names)
        id = objects[temp]['id']
        tipo_obj = objects[temp]['tipo_obj']
        obj_estrella = objects[temp]['obj_estrella']
        archivo.write('{},{},{},{},{},{},{},{}\n'.format(j,id,i,obj_estrella,tipo_obj,temp,r.randint(1,6),generate_rand_dates()))