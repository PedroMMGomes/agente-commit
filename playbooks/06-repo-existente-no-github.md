# Playbook 06 — Repo EXISTENTE no GitHub (última fase)

> Para projetos que **já estão no GitHub**. Ordem OBRIGATÓRIA:
> **baixar → testar → melhorar → commitar → SÓ DEPOIS fazer o README**.

## 1. Baixar / sincronizar

Se já tem a pasta local com `.git` apontando pro remote, sincronize:

```powershell
$root = 'C:\1Repos\<projeto>'
git -C $root remote -v                 # confira o origin
git -C $root fetch origin
git -C $root status -s                 # veja se há alterações locais não commitadas
git -C $root pull --ff-only origin main
```

Se não tem localmente, clone:
```powershell
gh repo clone PedroMMGomes/<repo> 'C:\1Repos\<repo>'
```

## 2. Backup

```powershell
Copy-Item -LiteralPath $root -Destination "D:\_repositores_backup\<repo>" -Recurse -Force
```

## 3. Testar (ANTES de melhorar)

Identifique a stack e rode o que existe:

```powershell
# Python
& "$root\.venv\Scripts\python.exe" -m pytest -q "$root\tests"      # se houver venv
# ou: pip install -r requirements.txt && pytest -q

# Node
npm --prefix $root ci ; npm --prefix $root test
# Lint/typecheck
ruff check $root ; npx tsc --noEmit -p $root
```

Anote o baseline (ex.: "20 passed, 1 skipped"). Se algo falhar, **corrija ou documente**.

## 4. Melhorar (por cima, sem apagar)

- Ajustes de código só se um teste estiver vermelho.
- Padronizar `.gitignore` (ver templates/).
- Garantir identidade git correta (playbook 04).

## 5. Commitar as melhorias

```powershell
git -C $root add -A
git -C $root -c user.name='Pedro Gomes' -c user.email='107215684+PedroMMGomes@users.noreply.github.com' `
    commit -m "chore: padroniza gitignore + ajustes de teste"
```

## 6. README + capa (SÓ AGORA)

- Gere a capa (playbook 03) → `docs/readme-hero.png`.
- Refine o README (template) preservando o conteúdo que já existia.
- Commit: `docs: README profissional + capa (gpt-image-2)`.

## 7. Push

```powershell
git -C $root push origin main
```

## 8. Verificar contribuidores/autoria

```powershell
gh api repos/PedroMMGomes/<repo>/contributors --jq '.[].login'
gh api repos/PedroMMGomes/<repo>/commits/main --jq '.commit.author.email'
```

Se houver contribuidor "estranho" por email mal-casado, corrija a autoria dos commits dele
(playbook 04) — mas só se for seu próprio commit com email errado.
