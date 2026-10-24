unit TestExpedicao.TManutencaoSeparadoresPorLocal;


interface

uses
  TestFramework, Classes, SysUtils, Expedicao.TManutencaoSeparadoresPorLocal,
  Expedicao.TManutencaoSeparadoresPorLocalConstantes,
  Expedicao.TSQLSeparadorLocalSeparacao, Data.DB, UniClientDataSet;

type
  // Test methods for class TManutencaoSeparadoresPorLocal

  TestTManutencaoSeparadoresPorLocal = class(TTestCase)
  strict private
    FManutencaoSeparadoresPorLocal: TManutencaoSeparadoresPorLocal;
  private
    procedure pFormataCDSLocais(cdsLocais : TUniClientDataSet);
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TesteCreate_LSEWMS_True;
    procedure TesteCreate_LSEWMS_False;

    procedure TestfVerificaSeAtualizaSeparador_SeparadorNovoVazio;
    procedure TestfVerificaSeAtualizaSeparador_SeparadoresDiferentes;
    procedure TestfVerificaSeAtualizaSeparador_SeparadoresIguais;

    procedure TestfPermiteAlterarSeparador_Permite;
    procedure TestfPermiteAlterarSeparador_NAO_Permite;

    procedure TestpAtualizaSeparadores;
    procedure TestfUtilizaSeparadorPorLocal_SENSEP_VAZIO;
    procedure TestfUtilizaSeparadorPorLocal_SENSEP_N;
    procedure TestfUtilizaSeparadorPorLocal_SENSEP_S_UTIWMS_N;
    procedure TestfUtilizaSeparadorPorLocal_SENSEP_S;
    procedure TestfUtilizaSeparadorPorLocal_SENSEP_S_LSEWMS_N;
    procedure TestpAtualizaSeparadores_SemMetodo;
  end;

implementation

procedure TestTManutencaoSeparadoresPorLocal.pFormataCDSLocais(cdsLocais: TUniClientDataSet);
var
  Field : TFieldDef;
begin
  Field := cdsLocais.FieldDefs.AddFieldDef;
  Field.Name := TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_ATUAL;
  Field.DataType := ftString;
  Field.Size := 250;
  Field.Required := False;

  Field := cdsLocais.FieldDefs.AddFieldDef;
  Field.Name := TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_NOVO;
  Field.DataType := ftString;
  Field.Size := 250;
  Field.Required := False;

  Field := cdsLocais.FieldDefs.AddFieldDef;
  Field.Name := TManutencaoSeparadoresPorLocalConstantes.CAMPO_CODIGO_LOCAL_SEPARACAO;
  Field.DataType := ftString;
  Field.Size := 250;
  Field.Required := False;

  cdsLocais.CreateDataSet;
  cdsLocais.Open;
end;

procedure TestTManutencaoSeparadoresPorLocal.SetUp;
begin
  FManutencaoSeparadoresPorLocal := TManutencaoSeparadoresPorLocal.Create(  True );
end;

procedure TestTManutencaoSeparadoresPorLocal.TearDown;
begin
  FManutencaoSeparadoresPorLocal.Free;
  FManutencaoSeparadoresPorLocal := nil;
end;

procedure TestTManutencaoSeparadoresPorLocal.TestfVerificaSeAtualizaSeparador_SeparadorNovoVazio;
var
  ReturnValue: Boolean;
  strCodigoSeparadorNovo: string;
  strCodigoSeparadorAntigo: string;
begin
  strCodigoSeparadorNovo := '';
  strCodigoSeparadorAntigo := '001';
  ReturnValue := FManutencaoSeparadoresPorLocal.fVerificaSeAtualizaSeparador(strCodigoSeparadorAntigo, strCodigoSeparadorNovo);

  CheckFalse(ReturnValue);
end;

procedure TestTManutencaoSeparadoresPorLocal.TestfVerificaSeAtualizaSeparador_SeparadoresIguais;
var
  ReturnValue: Boolean;
  strCodigoSeparadorNovo: string;
  strCodigoSeparadorAntigo: string;
begin
  strCodigoSeparadorNovo := '001';
  strCodigoSeparadorAntigo := '001';
  ReturnValue := FManutencaoSeparadoresPorLocal.fVerificaSeAtualizaSeparador(strCodigoSeparadorAntigo, strCodigoSeparadorNovo);

  CheckFalse(ReturnValue);
end;

procedure TestTManutencaoSeparadoresPorLocal.TestfVerificaSeAtualizaSeparador_SeparadoresDiferentes;
var
  ReturnValue: Boolean;
  strCodigoSeparadorNovo: string;
  strCodigoSeparadorAntigo: string;
begin
  strCodigoSeparadorNovo := '001';
  strCodigoSeparadorAntigo := '002';
  ReturnValue := FManutencaoSeparadoresPorLocal.fVerificaSeAtualizaSeparador(strCodigoSeparadorAntigo, strCodigoSeparadorNovo);

  CheckTrue(ReturnValue);
end;

procedure TestTManutencaoSeparadoresPorLocal.TestfPermiteAlterarSeparador_Permite;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FManutencaoSeparadoresPorLocal.fPermiteAlterarSeparador('0');
  CheckTrue(ReturnValue);
end;

procedure TestTManutencaoSeparadoresPorLocal.TesteCreate_LSEWMS_True;
var
  objManutencao : TManutencaoSeparadoresPorLocal;
begin
  objManutencao := TManutencaoSeparadoresPorLocal.Create( True );
  CheckTrue( objManutencao.objSQLSeparadorLocalSeparacao is TSQLSeparadorLocalSeparacaoPorLocalizacaoFisica);
end;

procedure TestTManutencaoSeparadoresPorLocal.TesteCreate_LSEWMS_False;
var
  objManutencao : TManutencaoSeparadoresPorLocal;
begin
  objManutencao := TManutencaoSeparadoresPorLocal.Create( False );
  CheckTrue( objManutencao.objSQLSeparadorLocalSeparacao is TSQLSeparadorLocalSeparacaoPorItem);
end;

procedure TestTManutencaoSeparadoresPorLocal.TestfPermiteAlterarSeparador_NAO_Permite;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FManutencaoSeparadoresPorLocal.fPermiteAlterarSeparador('1');
  CheckFalse(ReturnValue);
end;

procedure TestTManutencaoSeparadoresPorLocal.TestfUtilizaSeparadorPorLocal_SENSEP_VAZIO;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FManutencaoSeparadoresPorLocal.fUtilizaSeparadorPorLocal('', False, False);
  CheckFalse(ReturnValue);
end;

procedure TestTManutencaoSeparadoresPorLocal.TestfUtilizaSeparadorPorLocal_SENSEP_N;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FManutencaoSeparadoresPorLocal.fUtilizaSeparadorPorLocal('N', False, False);
  CheckFalse(ReturnValue);
end;

procedure TestTManutencaoSeparadoresPorLocal.TestfUtilizaSeparadorPorLocal_SENSEP_S_LSEWMS_N;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FManutencaoSeparadoresPorLocal.fUtilizaSeparadorPorLocal('S', True, False);
  CheckFalse(ReturnValue);
end;

procedure TestTManutencaoSeparadoresPorLocal.TestfUtilizaSeparadorPorLocal_SENSEP_S_UTIWMS_N;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FManutencaoSeparadoresPorLocal.fUtilizaSeparadorPorLocal('S', False, False);
  CheckFalse(ReturnValue);
end;

procedure TestTManutencaoSeparadoresPorLocal.TestfUtilizaSeparadorPorLocal_SENSEP_S;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FManutencaoSeparadoresPorLocal.fUtilizaSeparadorPorLocal('S', True, True);
  CheckTrue(ReturnValue);
end;

procedure TestTManutencaoSeparadoresPorLocal.TestpAtualizaSeparadores;
var
  cdsLocais : TUniClientDataSet;
  strResult : String;
begin
  cdsLocais := TUniClientDataSet.Create(nil);
  try
    pFormataCDSLocais(cdsLocais);

    cdsLocais.Append;
    cdsLocais.FieldByName( TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_ATUAL ).AsString := '001';
    cdsLocais.FieldByName( TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_NOVO ).AsString := '002';
    cdsLocais.FieldByName( TManutencaoSeparadoresPorLocalConstantes.CAMPO_CODIGO_LOCAL_SEPARACAO ).AsString := '00000000000000000001';
    cdsLocais.Post;

    strResult := '';

    FManutencaoSeparadoresPorLocal.dtsLocais := cdsLocais;
    FManutencaoSeparadoresPorLocal.pAtualizaSeparadores('000000000000000000002',
      procedure( strAutoincrem, strCodigoLocalSearacao, strSeparadorNovo : String)
      begin
        strResult := strResult + strAutoincrem + strCodigoLocalSearacao + strSeparadorNovo;
      end);

    CheckEqualsString('00000000000000000000200000000000000000001002', strResult);
  finally
    FreeAndNil(cdsLocais);
  end;
end;

procedure TestTManutencaoSeparadoresPorLocal.TestpAtualizaSeparadores_SemMetodo;
var
  strMessage : String;
begin
  try
    FManutencaoSeparadoresPorLocal.pAtualizaSeparadores('', nil);
  except
    ON E: Exception do
      strMessage := E.Message;
  end;

  CheckEqualsString('Objeto dtsLocais não atribuído!', strMessage);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTManutencaoSeparadoresPorLocal.Suite);
end.

