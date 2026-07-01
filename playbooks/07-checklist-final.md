# Playbook 07 — Checklist final (feche cada projeto aqui)

Projeto: `<nome>`  ·  Data: `<dd/mm/aaaa>`  ·  Fase: `1 (novo) | 2 (existente)`

## Entrega
- [ ] Entendi o projeto (stack, propósito, público).
- [ ] Backup em `D:\_repositores_backup\<projeto>`.
- [ ] `.gitignore` cobre segredos/builds.
- [ ] `git init` + branch `main` + snapshot inicial (se era novo).

## Identidade git
- [ ] `user.email = 107215684+PedroMMGomes@users.noreply.github.com` (local).
- [ ] Nenhum `pedro@...` ou email de terceiro no histórico.

## Capa
- [ ] Concept-brief escrito.
- [ ] OpenAI `gpt-image-2`, ≥2 variantes (1536x1024, high).
- [ ] Juiz de visão: `score ≥ 8 ∧ value_demonstrated ∧ clutter ≤ 6 ∧ text_correct`.
- [ ] Capa final em `docs/readme-hero.png`.

## README
- [ ] Capa + título + tagline + badges + sumário.
- [ ] O-que-é · instalar/usar · estrutura · galeria/screenshots.
- [ ] Créditos/licença. Conteúdo anterior preservado.

## Qualidade
- [ ] Testes rodaram (baseline anotado; nada vermelho sem justificativa).
- [ ] Sem segredos commitados (`git ls-files` checado).

## Publicação
- [ ] Commit(s) semânticos.
- [ ] Push no GitHub (`main`).
- [ ] `gh api .../contributors` lista APENAS `PedroMMGomes`.
- [ ] URL entregue ao usuário.

## Aprovação
- [ ] Mostrado ao usuário. Status: **APROVADO / AJUSTES**.
- [ ] Registrado em [`CHECKLIST-POR-REPO.md`](../CHECKLIST-POR-REPO.md).
