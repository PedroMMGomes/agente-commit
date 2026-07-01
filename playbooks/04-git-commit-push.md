# Playbook 04 — Git: commit + push

> Identidade do autor **correta** é mandatória — evita atribuir o commit a outra conta.

## Identidade (faça 1× por projeto — NUNCA use `pedro@users.noreply.github.com`)

```powershell
$root = 'C:\1Repos\<projeto>'
git -C $root config user.name  'Pedro Gomes'
git -C $root config user.email '107215684+PedroMMGomes@users.noreply.github.com'
```

> ⚠️ **Lição dura:** se o email casar com outra conta (ex.: `pedro@...`), o GitHub lista
> aquele usuário como contribuidor. O noreply **com ID** (`107215684+PedroMMGomes@...`) sempre
> mapeia para `PedroMMGomes`. Use SEMPRE este.

## Inicialização (se o projeto não tem `.git`)

```powershell
git -C $root init -q
git -C $root branch -M main          # garantir branch main
# garantir .gitignore correto (ver templates/) ANTES do add
git -C $root add -A
git -C $root -c user.name='Pedro Gomes' -c user.email='107215684+PedroMMGomes@users.noreply.github.com' `
    commit -q -m "chore: snapshot inicial"
```

## Mensagens de commit (semânticas)

- `feat:` nova funcionalidade · `fix:` correção · `docs:` doc/README · `chore:` infra/gitignore · `test:` testes · `refactor:`
- Assunto ≤72 chars, verbo no imperativo, PT-BR ou EN (seja consistente com o repo).

## Antes de commitar — checar segredos

```powershell
git -C $root ls-files | Select-String -Pattern '\.env$|\.env\.','api[_-]?key|secret|password|token' -CaseSensitive:$false
# se aparecer .env ou chave real: NÃO commite. Adicione ao .gitignore.
```

## Push

- Repo novo → [playbook 05](05-repo-novo-no-github.md).
- Repo existente → [playbook 06](06-repo-existente-no-github.md).

## Force push (USAR COM CUIDADO)

Só para corrigir autoria/recência em **repo solo e novo**, com autorização do dono:

```powershell
git -C $root commit --amend --reset-author --no-edit
git -C $root push --force-with-lease origin main
```

`--force-with-lease` é mais seguro que `--force` (falha se alguém mais mexeu).
**Nunca** force-push em repo com colaboradores sem avisar.
