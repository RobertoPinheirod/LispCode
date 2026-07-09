<#
.SINOPSE
    Roda UMA VEZ para transformar a pasta atual em repositorio Git
    e conecta-la a um repositorio remoto no GitHub.

.USO
    1. Abra o PowerShell DENTRO da pasta do seu projeto Allegro CL
       (ex: cd C:\Users\rpdom\Downloads\allegro-projects\project1)
    2. Copie este arquivo e o .gitignore para essa pasta
    3. Va no GitHub (github.com) e crie um repositorio NOVO e VAZIO
       (sem README, sem .gitignore, sem license - deixe tudo desmarcado)
    4. Copie a URL HTTPS do repositorio (ex: https://github.com/SEUUSER/lisp-project1.git)
    5. Rode: .\1-iniciar-repo.ps1 -RepoUrl "https://github.com/SEUUSER/lisp-project1.git"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$RepoUrl
)

# Verifica se o git esta instalado
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "ERRO: Git nao encontrado. Instale em https://git-scm.com/download/win" -ForegroundColor Red
    exit 1
}

# Inicializa o repositorio local, se ainda nao existir
if (-not (Test-Path ".git")) {
    Write-Host "Inicializando repositorio Git local..." -ForegroundColor Cyan
    git init
    git branch -M main
} else {
    Write-Host "Repositorio Git ja existe nesta pasta." -ForegroundColor Yellow
}

# Adiciona o remoto (se ainda nao existir)
$remoteExists = git remote | Select-String -Pattern "^origin$"
if (-not $remoteExists) {
    Write-Host "Conectando ao remoto: $RepoUrl" -ForegroundColor Cyan
    git remote add origin $RepoUrl
} else {
    Write-Host "Remoto 'origin' ja configurado. Atualizando URL..." -ForegroundColor Yellow
    git remote set-url origin $RepoUrl
}

# Primeiro commit
git add .
git commit -m "Commit inicial do projeto Lisp"

Write-Host ""
Write-Host "Enviando para o GitHub (vai pedir login na primeira vez)..." -ForegroundColor Cyan
git push -u origin main

Write-Host ""
Write-Host "Pronto! Repositorio conectado." -ForegroundColor Green
Write-Host "Da proxima vez, use o script 2-atualizar.ps1 para enviar mudancas." -ForegroundColor Green
