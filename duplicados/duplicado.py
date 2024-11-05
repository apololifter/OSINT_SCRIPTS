import ipaddress

def agregar_ips_sin_duplicados_desde_archivos(archivo_original, archivo_a_agregar):
    def leer_ips_desde_archivo(archivo):
        ips_validas = []
        try:
            with open(archivo, 'r') as f:
                for ip in f:
                    try:
                        ipaddress.ip_address(ip.strip())
                        ips_validas.append(ip.strip())
                    except ValueError:
                        print(f"IP inválida: {ip.strip()}")
        except FileNotFoundError:
            print(f"No se encontró el archivo: {archivo}")
        return ips_validas

    lista_original = leer_ips_desde_archivo(archivo_original)
    lista_a_agregar = leer_ips_desde_archivo(archivo_a_agregar)

    if not lista_original and not lista_a_agregar:
        print("Ambos archivos están vacíos.")
        return []

    return list(set(lista_original) | set(lista_a_agregar))

# Ejemplo de uso:
archivo_inicial = "ips.txt"
archivo_a_agregar = "nuevas-ips.txt"

resultado = agregar_ips_sin_duplicados_desde_archivos(archivo_inicial, archivo_a_agregar)
print(resultado)
