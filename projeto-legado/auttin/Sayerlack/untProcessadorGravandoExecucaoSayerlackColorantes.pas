unit untProcessadorGravandoExecucaoSayerlackColorantes;

interface

uses
  untAbstractProcessadorGravandoExecucaoSayerlack, SysUtils, Classes, DB,
  Variants, untIGravando;

type
  TProcessadorGravandoExecucaoSayerlackColorantes = class(TAbstractProcessadorGravandoExecucaoSayerlack)
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
  end;

implementation
uses untFuncoesSimples;
{ TProcessadorGravandoExecucaoSayerlackColorantes }

function TProcessadorGravandoExecucaoSayerlackColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TProcessadorGravandoExecucaoSayerlackColorantes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM SAY_CADCOL';
end;

function TProcessadorGravandoExecucaoSayerlackColorantes.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin

  Result :=
    ' SELECT                      ' +
    '   F2 AS CNT,                ' +
    '   F3 AS DES                 ' +
    ' FROM                        ' +
    '   [PIGMENT$]                 ' +
    ' WHERE                       ' +
    '   F2 <> ''''                ' +
    '   AND F2 <> ''PigmentCode'' ';
end;

procedure TProcessadorGravandoExecucaoSayerlackColorantes.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'SAY_CADCOL';
end;

procedure TProcessadorGravandoExecucaoSayerlackColorantes.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SAY_CADCOL', VS_strCodEmp);
  qryDestino.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('COL_CODCOL').AsString := qryOrigem.FieldByName('CNT').AsString;
  qryDestino.FieldByName('COL_DESCRI').AsString := qryOrigem.FieldByName('DES').AsString;
  qryDestino.FieldByName('COL_EMBALA').AsFloat := 1000;
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoSayerlackColorantes.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', VarArrayOf([qryOrigem.FieldByName('CNT').AsString]), []);
end;

procedure TProcessadorGravandoExecucaoSayerlackColorantes.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel gravar o colorante [%s], [%s: %s]',
    [qryOrigem.FieldByName('CNT').AsString, E.ClassName, E.Message]);
end;

end.
