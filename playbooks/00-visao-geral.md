# Playbook 00 — Visão geral e fila

## O fluxo canônico (cada projeto)

```
1. Entender      → ler README/AGENTS/deps/estrutura
2. Backup        → D:\_repositores_backup\<projeto>
3. Git           → init (se faltar) + .gitignore + branch main + snapshot inicial
4. Capa          → concept-brief → OpenAI gpt-image-2 (n=3) → juiz de visão → docs/readme-hero.png
5. README        → capa + badges + sumário + instalar/usar + estrutura + galeria
6. Testar        → pytest / npm test / ruff / typecheck (o que existir)
7. Commit        → mensagem semântica
8. Push          → repo novo (playbook 05) ou existente (playbook 06)
9. Mostrar       → print/sumário + AGUARDAR aprovação do usuário
```

## Ordem das fases

- **FASE 1 (primeiro):** projetos **locais sem GitHub** → criar repo novo (playbook 05).
- **FASE 2 (por último):** projetos **já no GitHub** → clone → testar → melhorar → commit → README (playbook 06).

## Fila atual (atualize ao concluir cada um)

| # | Projeto | Tipo | Status |
|---|---------|------|--------|
| ✅ | `agente-postagens-2` | novo no GitHub | publicado — `PedroMMGomes/agente-postagens-2` |
| 🔨 | `agente-commit` | este playbook | em construção |
| ⏳ | demais projetos locais | novo no GitHub | a fazer (ver `PLANO-REPOSITORIOS.md`) |
| 🔚 | `hermes` + outros já no GitHub | existente | por último |

## Regras de parada (PARE e pergunte se...)

- Faltar `OPENAI_API_KEY`.
- Um teste falhar e você não souber corrigir.
- For necessário `force push`, `git reset --hard`, ou apagar arquivos do usuário.
- O usuário não autorizou push.
