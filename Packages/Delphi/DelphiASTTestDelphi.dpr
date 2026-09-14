program DelphiASTTestDelphi;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  DelphiAST, DelphiAST.Classes, DelphiAST.Writer;

var
  SourceFileName: string;
  SyntaxTree: TSyntaxNode;
  XML: string;
begin
  if ParamCount < 1 then
  begin
    Writeln('Usage: DelphiASTTestDelphi <file.pas>');
    Halt(1);
  end;

  SourceFileName := ParamStr(1);
  if not FileExists(SourceFileName) then
  begin
    Writeln('File not found: ' + SourceFileName);
    Halt(2);
  end;

  try
    SyntaxTree := TPasSyntaxTreeBuilder.Run(SourceFileName, True);
    try
      XML := TSyntaxTreeWriter.ToXML(SyntaxTree, True);
      Writeln(XML);
    finally
      SyntaxTree.Free;
    end;
  except
    on E: Exception do
    begin
      Writeln(E.ClassName + ': ' + E.Message);
      Halt(3);
    end;
  end;
end.