unit TestuntFatCalcularServicePath;

interface

uses
  TestFramework,
  System.SysUtils,
  Vcl.Forms,
  untFatCalcularServicePath;

Type
  TTestFatCalcularServicePath = class(TTestCase)
  Private

  Public
    procedure SetUp; override;
    procedure TearDown; override;
  Published
    procedure TestLoadPackagesFromAuttin_Autcom;
    procedure TestLoadPackagesFromAuttin_Auttin;

    procedure TestGetPathFromAuttin_AutCom;
    procedure TestGetPathFromAuttin_Auttin;
  end;


implementation

{ TFatCalcularServicePath }

procedure TTestFatCalcularServicePath.SetUp;
begin
  inherited;

end;

procedure TTestFatCalcularServicePath.TearDown;
begin
  inherited;

end;

procedure TTestFatCalcularServicePath.TestGetPathFromAuttin_AutCom;
Var
  ReturnValue : String;
begin
  ReturnValue := TFatCalcularServicePath.GetPathFromAuttin('padra_atualizada\Autcom');

  CheckTrue(ReturnValue = 'padra_atualizada\Autcom');
end;

procedure TTestFatCalcularServicePath.TestGetPathFromAuttin_Auttin;
Var
  ReturnValue : String;
begin
  ReturnValue := TFatCalcularServicePath.GetPathFromAuttin('padra_atualizada\auttin');

  CheckTrue(ReturnValue = 'padra_atualizada\');

end;

procedure TTestFatCalcularServicePath.TestLoadPackagesFromAuttin_Autcom;
Var
  LValidou : Boolean;
begin
  LValidou := true;

  Try
    TFatCalcularServicePath.LoadPackagesFromAuttin('padra_atualizada\Autcom');
  Except
    LValidou := false;
  End;

  CheckTrue(LValidou);
end;


procedure TTestFatCalcularServicePath.TestLoadPackagesFromAuttin_Auttin;
Var
  LValidou : Boolean;
  Path : String;
begin
  LValidou := true;

  Path := ExtractFilePath(Application.ExeName)+ 'auttin\';

  Try
    TFatCalcularServicePath.LoadPackagesFromAuttin(Path);
  Except
    LValidou := false;
  End;

  CheckTrue(LValidou);

end;

initialization
  RegisterTest(TTestFatCalcularServicePath.Suite);


end.
