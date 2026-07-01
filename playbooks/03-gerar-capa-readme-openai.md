# Playbook 03 — Gerar capa de README com OpenAI gpt-image-2

> Capa = a primeira coisa que se vê. Conceito-primeiro, NÃO prompt-primeiro.

## 1. Extrair o conceito (a partir do que o projeto FAZ)

Responda: qual o **único valor/insight** que a capa deve comunicar? Qual a metáfora?
- Antes→Depois · KPI · outcome-icons · facilitação · metáfora lúdica (robôs/engenheirinhos).

## 2. Escrever o concept-brief

Use o template [`templates/concept-brief-capa.md`](../templates/concept-brief-capa.md). Inclua:
- **Estilo:** isométrico 3D editorial, premium.
- **Paleta tech:** navy `#0B1E2D` + teal/cyan `#22D3EE`/`#2DD4BF` + acento âmbar `#F59E0B`.
- **Composição:** 3 planos de profundidade, **≤6 blocos**, fluxo de leitura óbvio.
- **Texto (se houver):** PT-BR, MAIÚSCULO, **com acentos**.
- **Proibido:** escritório/corporativo genérico, wireframe solto, texto distorcido, marca d'água.

Salve em `<projeto>/docs/conceito-capa.txt` (ou similar).

## 3. Gerar (OpenAI gpt-image-2)

Se o projeto tiver script próprio (ex.: `agente-postagens-2/ferramentas/gerar-imagem-openai.mjs`), use-o.
Senão, chame a API direto (Node ≥18, sem deps):

```js
// POST https://api.openai.com/v1/images/generations
// headers: Authorization Bearer $OPENAI_API_KEY
// body: { model: "gpt-image-2", prompt: <brief> + regra anti-clutter, size: "1536x1024", quality: "high", n: 3 }
```

Regra anti-clutter (quando há texto):
> `Show ONLY this single headline — do NOT add any other labels, captions, callouts or annotations. Keep it to a maximum of 4 visual blocks.`

Salve as N variantes em `<projeto>/docs/readme-hero/`.

## 4. Validar com juiz de visão

Peça ao juiz (ex.: `zai-vision analyze_image`) JSON: `score, value_demonstrated, clutter,
legibility, fidelity, on_brand, text_correct, weaknesses, strengths`.

**Gate:** `score ≥ 8` **E** `value_demonstrated=true` **E** `clutter ≤ 6` **E** `text_correct=true`.
Escolha a variante de maior score. Se nenhuma passar, itere o brief (máx 4×).

## 5. Promover a capa final

Copie a vencedora para `<projeto>/docs/readme-hero.png` e referencie no README:

```markdown
<p align="center"><img src="docs/readme-hero.png" alt="<descrição>" width="100%"></p>
```

## Pré-requisitos
- `OPENAI_API_KEY` definida (`[Environment]::GetEnvironmentVariable('OPENAI_API_KEY','User')` deve existir).
- Se faltar a chave: **PARE** e peça ao usuário.
