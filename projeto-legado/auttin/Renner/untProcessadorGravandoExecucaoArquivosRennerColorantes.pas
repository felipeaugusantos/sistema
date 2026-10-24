unit untProcessadorGravandoExecucaoArquivosRennerColorantes;

interface

uses
  Classes, DB, SysUtils, untIGravando,
  Variants, ADODB,  untAbstractProcessadorGravandoExecucaoArquivosRennerColorantes;

type
  TProcessadorGravandoExecucaoArquivosRennerColorantes = class (TAbstractProcessadorGravandoExecucaoArquivosRennerColorantes)
  public
    procedure GetArquivosProcessar(const stlArquivos: TStrings); override;
    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando; const qryOrigem: TDataSet;
      const qryDestino: TDataSet); override;
    procedure ArquivoFormulaPadrao(const gravando: IGravando; const strNomeArquivo: string); override;
  end;

implementation

uses
  untFuncTinta, untFuncoesSimples, untDataSetFactory;

{ TProcessadorGravandoExecucaoArquivosRennerBases }

procedure TProcessadorGravandoExecucaoArquivosRennerColorantes.ArquivoFormulaPadrao(
  const gravando: IGravando; const strNomeArquivo: string);
begin

end;

procedure TProcessadorGravandoExecucaoArquivosRennerColorantes.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := ExtractFilePath(fGetConfTinta('REI').fGet('TXTREI')) + 'DM02.txt'
end;

function TProcessadorGravandoExecucaoArquivosRennerColorantes.GetDataSetOrigem(const strNomeArquivo: string): TDataSet;
var
  qryOrigem: TADODataSet;
begin
  qryOrigem := TDataSetFactory.GetIDataSet('RennerDM02').DataSet as TADODataSet;
  qryOrigem.CommandText :=
    ' SELECT                ' +
    '   PIG                 ' +
    '   , DESCR             ' +
    ' FROM                  ' +
    '   DM02#txt            ' +
    ' WHERE TIPO = ''P''    ';

  Result := qryOrigem;
end;

procedure TProcessadorGravandoExecucaoArquivosRennerColorantes.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('COL_CODCOL').AsString := UpperCase(qryOrigem.FieldByName('PIG').AsString);
  qryDestino.FieldByName('COL_DESCRI').AsString := UpperCase(qryOrigem.FieldByName('DESCR').AsString);
  qryDestino.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('REI_CADCOL', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoArquivosRennerColorantes.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', VarArrayOf([
    qryOrigem.FieldByName('PIG').AsString
  ]), []);
end;

procedure TProcessadorGravandoExecucaoArquivosRennerColorantes.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel gravar o colorante [%s], [%s: %s]',
    [qryOrigem.FieldByName('PIG').AsString,
    E.ClassName,
    E.Message]);
end;

end.

