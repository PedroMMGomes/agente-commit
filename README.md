# 🤖 Agente de Commit — Playbook de Profissionalização de Repositórios

> **O que é:** um agente (humano ou IA) que pega um projeto cru e o transforma em um
> repositório **profissional, publicado e bonito** — README de capa, imagem gerada por
> IA, testes rodando, git limpo e push no GitHub. Tudo **sem apagar nada** do que já existe.

<p align="center">
  <strong>Fluxo:</strong> entender → fazer backup → git → capa OpenAI → README → testar → commit → push → aprovar
</p>

---

## Filosofia

1. **Um projeto por vez.** Termina perfeitamente → mostra → só avança com aprovação.
2. **Sem apagar nada.** Refino por cima; histórico e conteúdo preservados.
3. **Sem push sem autorização.** Commit local sempre; push só quando mandarem.
4. **Imagens bonitas via OpenAI `gpt-image-2`** (não SVG), validadas por juiz de visão.
5. **Ordem:** primeiro os projetos **locais (novos no GitHub)**; os **já existentes no GitHub por último** (clone → testar → melhorar → commit → README).

## Como usar

- Se você é uma **IA**: leia [`AGENTS.md`](AGENTS.md) e execute os playbooks na ordem.
- Se você é **humano**: siga o [`playbooks/00-visao-geral.md`](playbooks/00-visao-geral.md).

## Playbooks

| # | Playbook | Quando |
|---|----------|--------|
| 00 | [Visão geral + fila](playbooks/00-visao-geral.md) | Sempre (ler primeiro) |
| 01 | [Preparar ambiente](playbooks/01-preparar-ambiente.md) | 1× por máquina |
| 02 | [Profissionalizar repo LOCAL (novo no GitHub)](playbooks/02-profissionalizar-repo-local.md) | Projeto sem GitHub |
| 03 | [Gerar capa de README com OpenAI gpt-image-2](playbooks/03-gerar-capa-readme-openai.md) | Toda capa |
| 04 | [Git: commit + push](playbooks/04-git-commit-push.md) | Toda publicação |
| 05 | [Repo NOVO no GitHub](playbooks/05-repo-novo-no-github.md) | Criar repo |
| 06 | [Repo EXISTENTE no GitHub](playbooks/06-repo-existente-no-github.md) | Última fase |
| 07 | [Checklist final](playbooks/07-checklist-final.md) | Fechar cada projeto |

## Templates

- [`templates/concept-brief-capa.md`](templates/concept-brief-capa.md) — brief da imagem (conceito-primeiro)
- [`templates/README-template.md`](templates/README-template.md) — esqueleto de README profissional
- [`templates/gitignore-python.md`](templates/gitignore-python.md) · [`templates/gitignore-node.md`](templates/gitignore-node.md)
- [`CHECKLIST-POR-REPO.md`](CHECKLIST-POR-REPO.md) — checklist marcável por projeto

## Padrões visuais (consistência)

- **Capa:** OpenAI `gpt-image-2`, wide `1536x1024`, `quality:high`, texto PT-BR maiúsculo **com acentos**.
- **Paleta tech:** navy `#0B1E2D`, teal/cyan `#22D3EE`/`#2DD4BF`, acento âmbar `#F59E0B`.
- **Proibido:** cena de escritório/corporativo genérico, wireframe solto, texto distorcido.
- **Badges:** status, versão, stack, idioma (estilo `flat-square`).
