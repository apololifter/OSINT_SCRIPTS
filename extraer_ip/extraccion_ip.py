import subprocess
import re
import os

# Función para hacer ping y obtener la dirección IP
def ping(url):
    try:
        # Ejecuta el comando ping y obtiene la salida
        output = subprocess.check_output(["ping", "-n", "1", url], universal_newlines=True)
        
        # Imprime la salida para ver qué se está devolviendo
        print(output)
        
        # Busca la dirección IP en la salida
        match = re.search(r"\[(\d+\.\d+\.\d+\.\d+)\]", output)
        if match:
            return match.group(1)  # Retorna la dirección IP
        else:
            return None  # No se encontró la IP
    except subprocess.CalledProcessError:
        return None  # Si hay un error en el ping

# Solicita la ruta del archivo de entrada
input_path = input("Ingresa la ruta del archivo de entrada (ej. C:\\Ruta\\A\\Tu\\Archivo\\hosts.txt): ")

# Verifica si el archivo existe
if not os.path.isfile(input_path):
    print(f"El archivo {input_path} no existe.")
else:
    # Define la ruta del archivo de resultados
    output_path = "C:\\Path\\extraer_ip\\resultados.csv"
    
    # Crea o limpia el archivo de resultados y escribe el encabezado
    with open(output_path, 'w') as output_file:
        output_file.write("Direcciones IP\n")  # Encabezado del CSV

    # Lee las URLs del archivo
    with open(input_path, 'r') as file:
        urls = file.readlines()

    # Itera sobre cada URL y realiza el ping
    for url in urls:
        url = url.strip()  # Elimina espacios en blanco
        print(f"Resultado de ping a {url}:")
        ip_address = ping(url)
        
        if ip_address:
            print(f"Dirección IP de {url}: {ip_address}")
            # Agrega solo la IP al archivo
            with open(output_path, 'a') as output_file:
                output_file.write(f"{ip_address}: {url}\n")  # Agrega solo la IP al archivo

        print("-------------------------")

    print(f"Resultados guardados en {output_path}")
