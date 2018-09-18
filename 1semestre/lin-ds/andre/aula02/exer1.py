# Se o volue de uma esfera com raio r é (3/4)*pi*r³, qual o volume de uma esfera com raio 3?

r = 3
volume = (4./3) * math.pi * r**3

#######################

'''Suponha que o preço do livro é R$24,95 com desconto de 40% para livrarias. O frete é de R$3,00 para a primeira cópia e R$ 0,75 para cada cópia adicional. Qual o custo dotal para 60 cópias encomendadas por uma livraria?'''

livro = 24.95
n = 60
desconto = 0.4
valor_livro = livro*n*(1-desconto)

frete_1 = 3
frete_n = 0.75

valor_frete = frete_1 + (n-1)*frete_n

valor_total = valor_livro + valor_frete

#######################

'''Uma pessoa sai de casa as 6:52AM e corre 1 milha em um ritmo leve (8'15'' por milha), 3 milhas em ritmo rápido (7'12'' por milha) e 1 milha em ritmo leve novamente. Que horas essa poessoa está de volta em sua casa? Se 1 milha aproximadamente 1,61km, qual a velocidade dessa pessoa em média em km/h?'''

p1 = [1 * 0, 1 * 8 , 1 * 15]

p2 = [3 * 0, 3 * 7 , 3 * 12]

p3 = [1 * 0, 1 * 8 , 1 * 15]

milhas = 5
km = milhas * 1.61

p_total = [ p1[0] + p2[0] + p3[0] , p1[1] + p2[1] + p3[1] , p1[2] + p2[2] + p3[2] ]

def arruma_horario( horario ):
    if horario[2] >= 60:
        horario[1] += 1
        horario[2] -=60
    if horario[1] >= 60:
        horario[0] += 1
        horario[1] -=60
    return horario


p_total = arruma_horario( p_total )

hora_saida = [ 6 , 52 , 0]

hora_chegada = arruma_horario(  [ hora_saida[0] + p_total[0] , hora_saida[1] + p_total[1] , hora_saida[2] + p_total[2] ] )

print("A hora de chegada foi:",  hora_chegada[0] , ":" , hora_chegada[1], "AM")

kmh = km / p_total[1]

print("A velocidade média em kmh é:", kmh)


