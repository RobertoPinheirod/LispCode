# Setup de repositorio Git para projetos Allegro Common Lisp

## Passo a passo (uma vez só)

1. **Instalar o Git for Windows** (se ainda não tiver):
   https://git-scm.com/download/win — instalação padrão, next-next-finish.

2. **Criar o repositório no GitHub** (pelo navegador):
   - Vá em github.com → botão verde "New repository"
   - Dê um nome (ex: `sn-transporte-lisp` ou o que fizer sentido)
   - **Deixe tudo desmarcado** (sem README, sem .gitignore, sem license) —
     vamos subir os arquivos locais direto.
   - Copie a URL HTTPS que aparece (algo como
     `https://github.com/seu-usuario/sn-transporte-lisp.git`)

3. **Copiar os 3 arquivos deste pacote** para dentro da pasta do seu
   projeto Allegro (ex: `C:\Users\rpdom\Downloads\allegro-projects\project1\`):
   - `.gitignore`
   - `1-iniciar-repo.ps1`
   - `2-atualizar.ps1`

4. **Abrir o PowerShell dentro dessa pasta**
   (no Explorer: Shift + botão direito → "Abrir janela do PowerShell aqui",
   ou "Abrir no Terminal")

5. **Rodar o script de inicialização**, passando a URL do passo 2:
   ```powershell
   .\1-iniciar-repo.ps1 -RepoUrl "https://github.com/seu-usuario/sn-transporte-lisp.git"
   ```

   Na primeira vez vai abrir uma janela pedindo para você logar no GitHub
   (login pelo navegador) — é normal, é o Git Credential Manager. Depois
   disso ele lembra e você não precisa logar de novo.

   > **Nota sobre PowerShell e scripts:** se aparecer um erro de
   > "execução de scripts desabilitada", rode uma vez isto (como admin,
   > ou no próprio PowerShell normal):
   > ```powershell
   > Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
   > ```

## Uso do dia a dia

Sempre que quiser mandar suas mudanças pro GitHub, dentro da pasta do
projeto:

```powershell
.\2-atualizar.ps1
```

Isso faz automaticamente: `git add` de tudo, `git commit` com data/hora,
e `git push`. Se não houver nada mudado, ele avisa e não faz nada.

Se quiser uma mensagem de commit específica em vez da automática:

```powershell
.\2-atualizar.ps1 -Mensagem "Corrigido calculo de secao de choque"
```

## O que o .gitignore está evitando

Arquivos compilados (`.fasl`, `.dxl`, `.bil`) e temporários do Allegro
não devem ir pro repositório — são gerados automaticamente a partir do
seu código-fonte `.cl`, ocupam espaço à toa, e mudam a cada compilação
(gerando "diffs" gigantes e inúteis no histórico). Só o código-fonte
importa para o controle de versão.

## Múltiplos projetos

Se você tiver vários projetos Lisp (ex: um por linha de pesquisa), o
mais organizado é: **um repositório GitHub por projeto**, cada um com
sua própria pasta e seus próprios `1-iniciar-repo.ps1` /
`2-atualizar.ps1` (são só 2 arquivos pequenos, sem problema duplicar).
Alternativa: um único repositório "guarda-chuva" com subpastas — mais
simples de gerenciar, mas menos organizado se os projetos forem
independentes entre si.
