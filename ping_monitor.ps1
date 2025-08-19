# Lista de IPs ou domínios que serão monitorados
$hosts = @("8.8.8.8", "1.1.1.1", "google.com")  # Pode adicionar ou remover conforme necessário

# Caminho do arquivo de log onde os resultados serão salvos
$logPath = "$PSScriptRoot\ping_log.txt"  # Usa a mesma pasta onde o script está salvo

# Função que registra o status de cada host no log
function Log-Status {
    param (
        [string]$alvo,     # Nome ou IP do host que está sendo verificado
        [bool]$status      # Resultado do teste de conexão (True = online, False = offline)
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"  # Data e hora atual formatada
    $result = if ($status) { "ONLINE" } else { "OFFLINE" }  # Define o status como texto
    $logEntry = "$timestamp - $alvo está $result"  # Monta a linha de log com data, host e status

    Write-Output $logEntry  # Exibe o resultado no terminal
    Add-Content -Path $logPath -Value $logEntry  # Adiciona a linha ao arquivo de log
}

# Loop principal que repete o monitoramento 5 vezes
for ($i = 0; $i -lt 5; $i++) {  # Altere o número 5 para quantas rodadas quiser

    foreach ($alvo in $hosts) {  # Para cada host na lista
        $status = Test-Connection -ComputerName $alvo -Count 2 -Quiet  # Testa conexão com 2 pacotes
        Log-Status -alvo $alvo -status $status  # Chama a função para registrar o resultado
    }

    Start-Sleep -Seconds 60  # Aguarda 60 segundos antes da próxima rodada
}
