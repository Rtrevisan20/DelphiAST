unit SampleUnit;

interface

uses
  SysUtils;

type
  TMyClass = class(TObject)
  private
    FValue: Integer;
  public
    function Sum(A, B: Integer): Integer;
    property Value: Integer read FValue write FValue;
  end;

function GlobalFunction(const S: string): Integer;

implementation

function GlobalFunction(const S: string): Integer;
begin
  Result := Length(S);
end;

function TMyClass.Sum(A, B: Integer): Integer;
begin
  Result := A + B;
end;

end.