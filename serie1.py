def suma_primos_en_rango(a, b):
    suma = 0

    #Ciclo que recorre el rango de números
    
    for i in range(a, b+1):
        print(i)

        #Condicional que verifica si el número es primo
        
        if es_primo(i):
            suma += i
    return suma

def es_primo(n):
    if n < 2:
        return False
    #Ciclo que verifica si el número es divisible por algún número hasta llegar a si mismo
    for i in range(2, n):
        if n % i == 0:
            return False
    return True

limite_inferior = int(input("Ingrese el límite inferior del rango: "))
limite_superior = int(input("Ingrese el límite superior del rango: "))

print("El resultado es:",suma_primos_en_rango(limite_inferior, limite_superior))