program DelphiASTTestLazarus;

{$MODE Delphi}

{$APPTYPE CONSOLE}

uses
  SysUtils, Classes,
  DelphiAST, DelphiAST.Classes, DelphiAST.Writer;

var
  SourceFileName: string;
  SyntaxTree: TSyntaxNode;
  XML: string;
begin
  if ParamCount < 1 then
  begin
    WriteLn('Usage: DelphiASTTestLazarus <file.pas>');
    Halt(1);
  end;

  SourceFileName := ParamStr(1);
  if not FileExists(SourceFileName) then
  begin
    WriteLn('File not found: ' + SourceFileName);
    Halt(2);
  end;

  try
    SyntaxTree := TPasSyntaxTreeBuilder.Run(SourceFileName, True);
    try
      XML := TSyntaxTreeWriter.ToXML(SyntaxTree, True);
      WriteLn(XML);
    finally
      SyntaxTree.Free;
    end;
  except
    on E: Exception do
    begin
      WriteLn(E.ClassName + ': ' + E.Message);
      Halt(3);
    end;
  end;
end.