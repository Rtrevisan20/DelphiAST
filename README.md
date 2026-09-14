[![](https://tokei.rs/b1/github/RomanYankovsky/DelphiAST?category=lines)](https://github.com/RomanYankovsky/DelphiAST) [![](https://tokei.rs/b1/github/RomanYankovsky/DelphiAST?category=code)](https://github.com/RomanYankovsky/DelphiAST) [![](https://tokei.rs/b1/github/RomanYankovsky/DelphiAST?category=files)](https://github.com/RomanYankovsky/DelphiAST)
### Abstract Syntax Tree Builder for Delphi 
With DelphiAST you can take real Delphi code and get an abstract syntax tree. One unit at time and without a symbol table though. 

FreePascal and Lazarus compatible.

#### Sample input
```delphi
unit Unit1;

interface

uses
  Unit2;

function Sum(A, B: Integer): Integer;

implementation

function Sum(A, B: Integer): Integer;
begin
  Result := A + B;
end;

end.
```

#### Sample outcome
```xml
<UNIT line="1" col="1" name="Unit1">
  <INTERFACE begin_line="3" begin_col="1" end_line="10" end_col="1">
    <USES begin_line="5" begin_col="1" end_line="8" end_col="1">
      <UNIT line="6" col="3" name="Unit2"/>
    </USES>
    <METHOD begin_line="8" begin_col="1" end_line="10" end_col="1" kind="function" name="Sum">
      <PARAMETERS line="8" col="13">
        <PARAMETER line="8" col="14">
          <NAME line="8" col="14" value="A"/>
          <TYPE line="8" col="20" name="Integer"/>
        </PARAMETER>
        <PARAMETER line="8" col="17">
          <NAME line="8" col="17" value="B"/>
          <TYPE line="8" col="20" name="Integer"/>
        </PARAMETER>
      </PARAMETERS>
      <RETURNTYPE line="8" col="30">
        <TYPE line="8" col="30" name="Integer"/>
      </RETURNTYPE>
    </METHOD>
  </INTERFACE>
  <IMPLEMENTATION begin_line="10" begin_col="1" end_line="17" end_col="1">
    <METHOD begin_line="12" begin_col="1" end_line="17" end_col="1" kind="function" name="Sum">
      <PARAMETERS line="12" col="13">
        <PARAMETER line="12" col="14">
          <NAME line="12" col="14" value="A"/>
          <TYPE line="12" col="20" name="Integer"/>
        </PARAMETER>
        <PARAMETER line="12" col="17">
          <NAME line="12" col="17" value="B"/>
          <TYPE line="12" col="20" name="Integer"/>
        </PARAMETER>
      </PARAMETERS>
      <RETURNTYPE line="12" col="30">
        <TYPE line="12" col="30" name="Integer"/>
      </RETURNTYPE>
      <STATEMENTS begin_line="13" begin_col="1" end_line="15" end_col="4">
        <ASSIGN line="14" col="3">
          <LHS line="14" col="3">
            <IDENTIFIER line="14" col="3" name="Result"/>
          </LHS>
          <RHS line="14" col="13">
            <EXPRESSION line="14" col="13">
              <ADD line="14" col="15">
                <IDENTIFIER line="14" col="13" name="A"/>
                <IDENTIFIER line="14" col="17" name="B"/>
              </ADD>
            </EXPRESSION>
          </RHS>
        </ASSIGN>
      </STATEMENTS>
    </METHOD>
  </IMPLEMENTATION>
</UNIT>
```

#### Copyright
Copyright (c) 2014-2020 Roman Yankovsky (roman@yankovsky.me) et al

DelphiAST is released under the Mozilla Public License, v. 2.0

See LICENSE for details.

#### Building (Delphi 13 + Lazarus 4.8)

This fork supports **dual IDE** development: **Delphi 13 (VER370)** and **Lazarus 4.8 (FPC 3.2.2+)**. All `Generics.Collections` usage relies on the platform-native implementation (`rtl-generics` in FPC), so there are no submodules to fetch.

##### Lazarus / FPC

The package `DelphiASTCore.lpk` compiles the core units plus `StringBuilderUnit`. Build it and the demo/test projects with `lazbuild`:

```bat
"C:\lazarus\lazbuild.exe" DelphiASTCore.lpk
"C:\lazarus\lazbuild.exe" Demo\Parser\ParserDemo.lpi
"C:\lazarus\lazbuild.exe" Test\DelphiASTTest.lpi
```

Alternatively, open `DelphiAST.lpk` (renamed `DelphiASTCore.lpk`) in the Lazarus IDE and click *Compile* — the package name `DelphiASTCore` avoids a name clash between the generated package unit and the real `DelphiAST.pas` core unit.

##### Delphi 13 (VER370)

Add the `Source`, `Source\SimpleParser`, `Source\FreePascalSupport` and `Source\FreePascalSupport\FPC_StringBuilder\Src` folders to the project search/library path. The `{$IFDEF FPC}` blocks (anonymous functions, `IOUtils`, etc.) are auto-excluded in Delphi.
