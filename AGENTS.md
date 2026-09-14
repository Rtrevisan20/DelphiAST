# AGENTS.md — Plano de Porte DelphiAST (Delphi 13 + Lazarus 4.8)

## Contexto

Porte do DelphiAST (fork Rtrevisan20) para funcionar em dual IDE: **Delphi 13 (VER370)** e **Lazarus 4.8 (FPC 3.2.2)**.

Decisões já tomadas:
- **Submodules:** vendorizar `StringBuilderUnit.pas` diretamente no repo (sem `.gitmodules`).
- **Generics.Collections:** usar `rtl-generics` nativo do FPC 3.2.2 (sem o submodule `Generics.Collection`).
- **Alvo FPC:** apenas FPC ≥ 3.2.2.

Análise base (compilação FPC 3.2.2 real):
- Core (DelphiAST, SimpleParser, Lexer, StringPool) já compila em FPC.
- `DelphiAST.Serialize.Binary.pas` quebra em `UTF8ToUnicodeString` (linha 211).
- `DelphiAST.ProjectIndexer.pas` quebra nos atributos `[weak]` (linhas 75-77).
- `DelphiAST.Writer.pas` requer `StringBuilderUnit` (hoje submodule vazio).

## Tabela do Plano

| # | Passo | Tempo (±) | Status |
|---|-------|-----------|--------|
| 1 | Corrigir `DelphiAST.Serialize.Binary.pas` — trocar `UTF8ToUnicodeString` por cast `UnicodeString` | 5 min | Feito |
| 2 | Corrigir `DelphiAST.ProjectIndexer.pas` — remover `[weak]` + converter 2 funções anônimas em locais (via `{$IFDEF FPC}`) + `IOUtils` no uses FPC + `IsRelativePath` no stub | 10 min | Feito |
| 3 | Vendorizar `StringBuilderUnit.pas` em `Source\FreePascalSupport\FPC_StringBuilder\Src\` | 5 min | Feito |
| 4 | Remover gitmodule `Generics.Collection` e dependência no `.gitmodules` | 10 min | Feito |
| 5 | Ajustar `Demo\Parser\ParserDemo.lpi` — remover paths `Generics.Collections/Generics.Collection` | 5 min | Feito |
| 6 | Criar `.lpi` para `Test\DelphiASTTest.lpr` | 15 min | Feito |
| 7 | Criar pacote `.lpk` do DelphiAST (compile all core units + StringBuilderUnit) | 20 min | Feito |
| 8 | Validar build no Lazarus 4.8 (`lazbuild` no `.lpk`, Demo e Test) | 20 min | Feito |
| 9 | Remover `SimpleParser.rsj` do versionamento e ignorar `*.rsj` no `.gitignore` | 5 min | Feito |
| 10 | Atualizar `README.md` — instruções de build dual IDE (Delphi 13 / Lazarus 4.8) | 15 min | Feito |
| 11 | Validar build no Delphi 13 (VER370) — depende de ter o Delphi na máquina | 20 min | Feito |

**Total estimado:** ~2h10min

> Legenda Status: Pendente / Em progresso / Feito / Bloqueado

## Notas

- Varrer `.pas` em busca de `System.` prefixado já feito: ausente no código atual.
- `TCharacter` e `Generics.Collections` existem nativos no FPC 3.2.2 — nenhum shim necessário.
- Após cada passo, atualizar o Status na tabela acima.