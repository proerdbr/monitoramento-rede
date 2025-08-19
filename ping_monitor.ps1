# Lista de hosts para monitorar
$hosts = @("8.8.8.8", "1.1.1.1", "google.com")

# Caminho do arquivo de log
$logPath = "$PSScriptRoot\ping_log.txt"

# Função para registrar no log
function Log-Status {
    param (
        [string]$host,
        [bool]$status
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $result = if ($status) { "ONLINE" } else { "OFFLINE" }
    $logEntry = "$timestamp - $host está $result"
    Write-Output $logEntry
    Add-Content -Path $logPath -Value $logEntry
}

# Loop de monitoramento (pode ajustar o número de ciclos ou usar infinito)
for ($i = 0; $i -lt 5; $i++) {
    foreach ($host in $hosts) {
        $status = Test-Connection -ComputerName $host -Count 2 -Quiet
        Log-Status -host $host -status $status
    }
    Start-Sleep -Seconds 60  # Aguarda 60 segundos antes da próxima rodada
}
