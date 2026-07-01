# Playbook 01 — Preparar ambiente (1× por máquina)

## Ferramentas necessárias

```powershell
git --version          # controle de versão
gh --version           # GitHub CLI
node --version         # >= 18 (fetch global p/ OpenAI API)
python --version       # >= 3.10 (projetos Python / pytest)
```

## Autenticação

```powershell
gh auth status         # deve mostrar: Logged in to github.com account PedroMMGomes
# se faltar:  gh auth login
```

## Chave OpenAI (para capas)

```powershell
# verificar
[Environment]::GetEnvironmentVariable('OPENAI_API_KEY','User')   # deve estar definida
# definir (persistente)
[Environment]::SetEnvironmentVariable('OPENAI_API_KEY','sk-proj-...','User')
```

## Identidade git global correta

```powershell
git config --global user.name  'Pedro Gomes'
git config --global user.email '107215684+PedroMMGomes@users.noreply.github.com'
```

> Mesmo com global setado, **sempre** confirme o email local por projeto (playbook 04).

## Estrutura de backups

```
D:\_repositores_backup\<projeto>\   # cópia de segurança antes de mexer em cada projeto
```

## Pasta de destino dos projetos

```
C:\1Repos\<projeto>\                # workspace principal
```
