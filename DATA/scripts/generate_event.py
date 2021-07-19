from os import replace
import random

def generate_rand_event(eventos):
    return '\'{}\''.format(eventos[random.randint(0,len(eventos)-1)])

eventos = [
    'Retorno estelar',
    'Deseo para una gran linterna',
    'un mar de luces',
    'foto con amber',
    'fragua elemental',
    'El principe de la tiza y el dragon',
    'Riquezas perdidas',
    'Sinfonia hipostatica',
    'Slime Paradise',
    'Mercancia maravillosa',
    'Estrellas no reconciliadas',
    'Mientras hace calor',
    'Desafio de vuelo sin motor',
    'Mil preguntas con Paimon',
    'El brillante debut de Barbara',
    'Los aventureros se reunen',
    'Los colores de la fortuna',
    'Festival de linternas',
    'El teatro mecanico',
    'Anecdotas del festival',
    'Riqueza honorable',
    'A tu lado',
    'Iluminacion de la linterna',
    'Reflujo de lineas de energia',
    'Gotas de deseos',
    'Mareas rivales',
    'Gastronomia de Terrallende'
]

file_name = 'eventos.txt'
file_name_mod = file_name.replace('.txt', '')
file_name_mod += 'm.txt'
mod_file = open(file_name_mod, 'w')
raw_file = open(file_name, 'r+')

xf = ''
for line in raw_file:
    lista = line.rsplit(',')
    for word in lista:
        xf = word.replace('\'hola\'',generate_rand_event(eventos))
        mod_file.write(xf + ',')


