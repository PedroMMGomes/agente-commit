# Playbook 05 — Repo NOVO no GitHub

> Para projetos locais que ainda não têm repo no GitHub (FASE 1).

## Pré-requisitos
- `gh` autenticado: `gh auth status` → `PedroMMGomes` ativo.
- Commit inicial já feito localmente (playbook 04).
- Branch `main`.

## Criar e publicar

```powershell
$root = 'C:\1Repos\<projeto>'
gh repo create <nome-do-repo> `
  --public `
  --source $root `
  --remote origin `
  --description "<descrição curta PT-BR>" `
  --push
```

- `<nome-do-repo>`: geralmente igual ao nome da pasta, em kebab-case.
- `--public` para portfólio (mude para `--private` se o projeto tiver segredo/sensível).
- `--push` já sobe a `main` e configura o tracking.

## Verificar

```powershell
gh api repos/PedroMMGomes/<nome-do-repo>/contributors --jq '.[] | {login, contributions}'
# deve listar APENAS PedroMMGomes
gh api repos/PedroMMGomes/<nome-do-repo>/commits/main --jq '.commit.author.email'
# deve ser 107215684+PedroMMGomes@users.noreply.github.com
```

Se aparecer outro contribuidor → corrija a autoria (playbook 04, "Force push").

## Tópicos (melhora a descoberta)

```powershell
gh repo edit PedroMMGomes/<nome-do-repo> --add-topic ia,agentes,python --add-topic <stack>
```
