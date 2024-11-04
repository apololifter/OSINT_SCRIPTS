# Solicita al usuario que ingrese la página
$page = Read-Host -Prompt "Ingresa la página que deseas consultar (sin espacios)"

# Define el archivo de salida
$outputFile = "salida.txt"

# Descarga el contenido de la página y lo guarda en output.html
$uri = "https://crt.sh/?q=$page"
(Invoke-WebRequest -Uri $uri -UseBasicParsing).Content | Out-File -FilePath "output.html"

# Verifica si el archivo de salida de la descarga existe
if (-Not (Test-Path "output.html")) {
    Write-Host "No se pudo descargar el contenido de la página."
    exit
}

# Lee el contenido de output.html
$content = Get-Content "output.html"

# Encuentra todas las URLs que terminan con medife.com.ar
$urls = [regex]::Matches($content, '[\w.-]+\.medife\.com\.ar') | ForEach-Object { $_.Value }

# Elimina duplicados
$uniqueUrls = $urls | Select-Object -Unique

# Guarda las URLs únicas en el archivo de salida
$uniqueUrls | Set-Content $outputFile

Write-Host "Se han encontrado y guardado las URLs únicas en $outputFile."