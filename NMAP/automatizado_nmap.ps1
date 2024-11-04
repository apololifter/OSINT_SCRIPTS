# Definir la ruta del archivo de hosts
$hostsFile = "hosts.txt"

# Comprobar si el archivo existe
if (-Not (Test-Path $hostsFile)) {
    Write-Host "El archivo 'hosts.txt' no se encontró. Asegúrate de que esté en el mismo directorio que este script."
    exit
}

# Definir el nombre del archivo de salida
$outputFile = "nmap_scan_output.txt"

# Definir el comando Nmap
$nmapCommand = "nmap --script * -sV -sS -sC -v --version-all --open --max-retries 3 --max-scan-delay 10ms --min-rate 1000 -iL $hostsFile"

# Ejecutar el comando Nmap y redirigir la salida a un archivo
try {
    & cmd.exe /c $nmapCommand | Out-File -FilePath $outputFile -Encoding UTF8
    # Confirmación de que el escaneo se ha completado y guardado
    Write-Host "El escaneo de Nmap se ha completado. La salida se ha guardado en '$outputFile'."
} catch {
    Write-Host "Se produjo un error al ejecutar Nmap: $_"
}
