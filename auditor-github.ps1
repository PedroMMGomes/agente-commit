#Requires -Version 5.1
<#
.SYNOPSIS
  Auditor de GitHub (olhar de recrutador exigente). ASCII-only, arrays nativos.
.EXAMPLE
  .\auditor-github.ps1 -Repo C:\1Repos\glosador-contas-medicas
#>
[CmdletBinding()] param(
  [Parameter(Mandatory)][string]$Repo,
  [string]$Out
)
$ErrorActionPreference = 'Stop'
$Repo = (Resolve-Path $Repo).Path
if (-not $Out) { $Out = Join-Path $Repo 'AUDITORIA.md' }

$SECRET = @(
  'sk-proj-[A-Za-z0-9_-]{16,}','sk-[A-Za-z0-9]{32,}','ghp_[A-Za-z0-9]{30,}','github_pat_[A-Za-z0-9_]{40,}',
  'AIza[0-9A-Za-z_-]{30,}','xai-[A-Za-z0-9]{20,}','eyJ[A-Za-z0-9_-]{20,}\.eyJ[A-Za-z0-9_-]{20,}',
  '\b\d{3}\.\d{3}\.\d{3}-\d{2}\b','\b\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}\b',
  '(?i)(api[_-]?key|secret|password|senha|token)\s*[=:]\s*[''"][^''"]{8,}[''"]'
)
$AITELL = @(
  '(?i)Capa gerada com OpenAI','(?i)gerada com OpenAI gpt-image','score 8[,\.]\d',
  '(?i)voc[eê] traz','(?i)traga (o )?SEU','(?i)alma do neg[oó]cio',
  '(?i)N[AÃ]O commitad','(?i)este [eé] um placeholder','(?i)cole sua chave aqui'
)

$skip = '\\(node_modules|\.git|\.venv|__pycache__|\.pytest_cache|\.ruff_cache)\\'
$skipFile = '(openai-log\.json$|conceito-capa\.txt$|^AUDITORIA\.md$|auditor-github\.ps1$|package-lock\.json$)'
$placeholder = '(\.\.\.|aqui|suasua|sua_chave|sua chave|exemplo|_test_|xxxxx|changeme|cole_|placeholder|vd_test|sk-proj-\.+|\bTEST\b|id\.secret|0001-91|789-00)'

# Escanear SOMENTE arquivos tracked (git ls-files) -> reflete o que e' publico.
$tracked = @()
if (Test-Path (Join-Path $Repo '.git')) {
  $tracked = @(git -C $Repo ls-files 2>$null | ForEach-Object { Join-Path $Repo ($_ -replace '/','\') } | Where-Object { Test-Path $_ })
} else {
  $tracked = @(Get-ChildItem $Repo -Recurse -File -Force -ErrorAction SilentlyContinue | ForEach-Object { $_.FullName })
}
$files = $tracked | Where-Object {
  $name = Split-Path $_ -Leaf
  ($name -match '\.(md|txt|py|mjs|js|ts|tsx|jsx|json|yml|yaml|toml|sh|bat|ps1|html|css|ini|cfg|env)$' -or $name -match '\.env') -and
  ($_ -notmatch $skip) -and ($name -notmatch $skipFile)
}

$rows = @()
foreach ($f in $files) {
  $rel = $f.Substring($Repo.Length).TrimStart('\','/')
  $content = try { Get-Content $f -ErrorAction Stop } catch { $null }
  if (-not $content) { continue }
  $i = 0
  foreach ($ln in $content) {
    $i++
    $s = [string]$ln
    foreach ($p in $SECRET)  { if ($s -match $p) { $hit=$matches[0]; if($hit -notmatch $placeholder){ $rows += [pscustomobject]@{Tipo='VAZAMENTO';Arquivo=$rel;Linha=$i;Detalhe=$hit} } } }
    foreach ($p in $AITELL)  { if ($s -match $p) { $d=$s.Trim(); if($d.Length -gt 110){$d=$d.Substring(0,110)}; $rows += [pscustomobject]@{Tipo='AI-TELL';Arquivo=$rel;Linha=$i;Detalhe=$d} } }
  }
}

$broken = @()
$readme = Join-Path $Repo 'README.md'
if (Test-Path $readme) {
  $md = Get-Content $readme -Raw -Encoding UTF8
  foreach ($m in [regex]::Matches($md, '\]\(([^)]+\.[a-z]{2,5})\)')) {
    $t = $m.Groups[1].Value
    if ($t -match '^(https?:|#|mailto:)') { continue }
    $clean = $t -replace '^(\./|\.\./)+','' -replace '/','\'
    if (-not (Test-Path (Join-Path $Repo $clean))) { $broken += [pscustomobject]@{Tipo='REF-QUEBRADA';Arquivo='README.md';Linha='-';Detalhe=$t} }
  }
}

$all = @()
foreach ($x in $rows)   { $all += $x }
foreach ($x in $broken) { $all += $x }

$vaz  = @($rows   | Where-Object Tipo -eq 'VAZAMENTO').Count + @($broken | Where-Object { $_.Detalhe -match '\.env|\.key|token' }).Count
$tell = @($rows   | Where-Object Tipo -eq 'AI-TELL').Count
$refb = $broken.Count
$score = 100 - ($vaz*25) - ($tell*8) - ($refb*4)
if ($score -lt 0) { $score = 0 }

$o = New-Object System.Text.StringBuilder
[void]$o.AppendLine("# Auditoria de portfolio - " + (Split-Path $Repo -Leaf))
[void]$o.AppendLine("")
[void]$o.AppendLine("**Score recrutador: $score / 100**  |  vazamentos=$vaz | ai-tells=$tell | refs-quebradas=$refb")
[void]$o.AppendLine("")
[void]$o.AppendLine("| Tipo | Arquivo | Linha | Detalhe |")
[void]$o.AppendLine("|---|---|---:|---|")
foreach ($x in ($all | Sort-Object Tipo,Arquivo)) {
  $d = [string]($x.Detalhe) -replace '\|','/'
  if ($d.Length -gt 110) { $d = $d.Substring(0,110) + '...' }
  [void]$o.AppendLine("| " + $x.Tipo + " | " + $x.Arquivo + " | " + $x.Linha + " | " + $d + " |")
}
[void]$o.AppendLine("")
[void]$o.AppendLine("> Rode de novo apos corrigir. Alvo: 100/100.")
$txt = $o.ToString()
[System.IO.File]::WriteAllText([string]$Out, [string]$txt, [System.Text.Encoding]::UTF8)

[pscustomobject]@{ Repo=(Split-Path $Repo -Leaf); Score=$score; Vazamentos=$vaz; AiTells=$tell; RefsQuebradas=$refb; Relatorio=$Out }
