# Define el archivo de salida
$outputFile = "nmap_filtered_output.txt"

# Inicializa el archivo de salida
"" | Out-File -FilePath $outputFile

# Lee el archivo de salida de Nmap
$nmapOutput = Get-Content "nmap_scan_output.txt"

# Variable para almacenar la IP actual
$currentIP = ""

# Filtra las líneas que contienen información sobre puertos abiertos
foreach ($line in $nmapOutput) {
    # Verifica si la línea contiene una dirección IP
    if ($line -match '(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})') {
        $currentIP = $matches[1]  # Guarda la IP actual
    }

    # Verifica si la línea contiene información sobre puertos abiertos
    if ($line -match '(\d{1,5}/tcp)\s+open\s+.*?\s+(.*)') {
        $port = $matches[1] -replace '/tcp', '' # Remueve /tcp
        $version = $matches[2]

        # Elimina cualquier cadena que contenga "syn-ack", "ttl", o "reset ttl"
        $version = $version -replace '\b(syn-ack|ttl \d+|reset ttl \d+)\b', ''

        # Limpia espacios extras
        $version = $version.Trim()

        # Si hay versión disponible, formatea la salida
        if ($version -ne "") {
            $formattedOutput = "($currentIP open: $port $version)"
        } else {
            $formattedOutput = "($currentIP open: $port)"
        }

        # Guarda el resultado en el archivo de salida
        $formattedOutput | Out-File -FilePath $outputFile -Append
    }
}

# Muestra el contenido final
Get-Content $outputFile