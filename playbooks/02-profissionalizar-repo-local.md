# Playbook 02 — Profissionalizar repo LOCAL (novo no GitHub)

> Use quando o projeto NÃO tem GitHub ainda. Para os que já têm, use o [playbook 06](06-repo-existente-no-github.md).

## 1. Entender o projeto

Leia (o que existir): `README.md`, `AGENTS.md`, `package.json`, `requirements.txt`/`pyproject.toml`,
`*.csproj`, estrutura de pastas. Anote: **stack, o que faz, público-alvo**.

## 2. Backup

```powershell
Copy-Item -LiteralPath 'C:\1Repos\<projeto>' -Destination 'D:\_repositores_backup\<projeto>' -Recurse -Force
```

## 3. .gitignore (se faltar)

Use o template da stack: [`templates/gitignore-python.md`](../templates/gitignore-python.md) ou
[`templates/gitignore-node.md`](../templates/gitignore-node.md). **Confirme que cobre** `.env`,
`node_modules/`, `.venv/`, `__pycache__/`, `dist/`, `build/`, `.DS_Store`.

## 4. Capa (OpenAI gpt-image-2)

Siga o [playbook 03](03-gerar-capa-readme-openai.md) → `docs/readme-hero.png`.

## 5. README profissional

Use [`templates/README-template.md`](../templates/README-template.md). Seções: capa, título+tagline,
badges, sumário, o-que-é, instalar/usar, estrutura, galeria/screenshots (se houver), créditos/licença.

## 6. Testar

Rode o que existir (`pytest`/`npm test`/`ruff`/`tsc`/`build`). Documente o comando num `AGENTS.md`
se ainda não tiver. Se falhar, corrija ou documente.

## 7. Git init + commit

[Playbook 04](04-git-commit-push.md). Garanta email `107215684+PedroMMGomes@users.noreply.github.com`.

## 8. Publicar (repo novo)

[Playbook 05](05-repo-novo-no-github.md).

## 9. Mostrar e aguardar aprovação

Print/sumário + URL. **Pare** e espere o usuário dizer "próximo".
