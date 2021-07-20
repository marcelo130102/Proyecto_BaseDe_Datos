import random as r

def generate_rand_objects(names):
    nombre = names[r.randint(0,len(names)-1)]
    return nombre

def rand_pos():
    return '({};{})'.format(round(r.uniform(0.0,900.0),4), round(r.uniform(0.0,900.0),4))

def rand_acc(accion):
    return accion[r.randint(0,len(accion)-1)]

accion = [
    'cofre',
    'raid',
    'campo_hillichurls',
    'puzzle',
    'activacion'
]

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


file_name = 'recompensaexplo.txt'
archivo = open(file_name, 'w')
k = 0
for i in range(6000):
    temp = generate_rand_objects(names)
    id = objects[temp]['id']
    tipo_obj = objects[temp]['tipo_obj']
    obj_estrella = objects[temp]['obj_estrella']
    for j in range(r.randint(5,100)):
        archivo.write('{},{},{},{},{},{},{},{},{},{},{}\n'.format('Monstad','Teyvat',i,k,rand_pos(),rand_acc(accion),id,obj_estrella,tipo_obj,temp,r.randint(1,5)))
        k+=1
        archivo.write('{},{},{},{},{},{},{},{},{},{},{}\n'.format('Liyue','Teyvat',i,k,rand_pos(),rand_acc(accion),id,obj_estrella,tipo_obj,temp,r.randint(1,5)))
        k+=1
   
