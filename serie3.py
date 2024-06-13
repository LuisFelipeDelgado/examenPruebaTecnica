import pandas as pd

import matplotlib.pyplot as plt

df = pd.read_csv('country_wise_latest.csv')
stats = df.describe()
#Estadisticas media, mediana, desviacion estandar, minimo, maximo
print(stats)

#Agrupados por country/region y sumando los valores, confirmados, muertos y recuperados
grouped = df.groupby('Country/Region')[['Confirmed', 'Deaths', 'Recovered', 'Active']].sum()
print(grouped)

#Ordenados por numero de casos confirmados mostrando los primeros 10
sorted = grouped.sort_values('Confirmed', ascending=False).head(10)
print(sorted)

# Filtrar el DataFrame para incluir solo los datos de Estados Unidos
us_data = df[df['Country/Region'] == 'US']

# Crear un gráfico de línea para los casos confirmados
plt.figure(figsize=(14,7))
plt.plot(us_data['Date'], us_data['Confirmed'], label='Confirmed')
plt.plot(us_data['Date'], us_data['Deaths'], label='Deaths')
plt.plot(us_data['Date'], us_data['Recovered'], label='Recovered')

# Añadir títulos y etiquetas
plt.title('Evolución de casos confirmados, muertes y recuperaciones en Estados Unidos')
plt.xlabel('Fecha')
plt.ylabel('Número de casos')
plt.legend()

# Mostrar el gráfico
plt.show()