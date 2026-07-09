<#
.SINOPSE
    Roda toda vez que voce quiser enviar as mudancas do projeto para o GitHub.
    Faz add + commit (com timestamp automatico) + push.

.USO
    Dentro da pasta do projeto:
        .\2-atualizar.ps1
    Ou com uma mensagem de commit personalizada:
        .\2-atualizar.ps1 -Mensagem "Corrigido bug no calculo de lambda"
#>

param(
    [string]$Mensagem = ""
)

if (-not (Test-Path ".git")) {
    Write-Host "ERRO: esta pasta nao e um repositorio Git." -ForegroundColor Red
    Write-Host "Rode primeiro o script 1-iniciar-repo.ps1" -ForegroundColor Red
    exit 1
}

# Verifica se ha algo para commitar
$status = git status --porcelain
if (-not $status) {
    Write-Host "Nada para atualizar - nenhuma mudanca detectada." -ForegroundColor Yellow
    exit 0
}

# Mostra o que vai ser enviado
Write-Host "Mudancas detectadas:" -ForegroundColor Cyan
git status --short

# Monta a mensagem de commit
if ($Mensagem -eq "") {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
    $Mensagem = "Atualizacao automatica - $timestamp"
}

git add .
git commit -m "$Mensagem"

Write-Host ""
Write-Host "Enviando para o GitHub..." -ForegroundColor Cyan
git push origin main

Write-Host ""
Write-Host "Concluido." -ForegroundColor Green
