unit untProcessadorGravandoExecucaoArquivosRennerBases;

interface

uses
   Classes, DB, SysUtils, untIGravando,
  Variants, ADODB,  untAbstractProcessadorGravandoExecucaoArquivosRennerBases;

type
  TProcessadorGravandoExecucaoArquivosRennerBases = class (TAbstractProcessadorGravandoExecucaoArquivosRennerBases)
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

procedure TProcessadorGravandoExecucaoArquivosRennerBases.ArquivoFormulaPadrao(
  const gravando: IGravando; const strNomeArquivo: string);
begin

end;

procedure TProcessadorGravandoExecucaoArquivosRennerBases.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := ExtractFilePath(fGetConfTinta('REI').fGet('TXTREI')) + 'DM02.txt'
end;

function TProcessadorGravandoExecucaoArquivosRennerBases.GetDataSetOrigem(const strNomeArquivo: string): TDataSet;
var
  qryOrigem: TADODataSet;
  intCont: Integer;
const
  arrUnidades: array[1..3] of string = ('QT', 'GL', 'LA');
begin
  qryOrigem := TDataSetFactory.GetIDataSet('RennerDM02').DataSet as TADODataSet;
  qryOrigem.CommandText := '';

  for intCont := 1 to 3 do
  begin
    qryOrigem.CommandText := qryOrigem.CommandText +
      ' UNION                 ' +
      ' SELECT                ' +
      '   PIG                 ' +
      '   , DESCR             ' +
      '   , ' + QuotedStr(arrUnidades[intCont]) + ' AS UNIDADE ' +
      ' FROM                  ' +
      '   DM02#txt            ' +
      ' WHERE TIPO = ''B''    ';
  end;

  qryOrigem.CommandText := Trim(qryOrigem.CommandText);
  qryOrigem.CommandText := Trim(Copy(qryOrigem.CommandText, Length('UNION') + 1, Length(qryOrigem.CommandText)));
  Result := qryOrigem;
end;

procedure TProcessadorGravandoExecucaoArquivosRennerBases.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('BAS_CODBAS').AsString := UpperCase(qryOrigem.FieldByName('PIG').AsString);
  qryDestino.FieldByName('BAS_UNIDAD').AsString := UpperCase(qryOrigem.FieldByName('UNIDADE').AsString);
  qryDestino.FieldByName('BAS_DESCRI').AsString := UpperCase(qryOrigem.FieldByName('DESCR').AsString);
  qryDestino.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('REI_CADBAS', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoArquivosRennerBases.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS;BAS_UNIDAD', VarArrayOf([
    UpperCase(qryOrigem.FieldByName('PIG').AsString),
    UpperCase(qryOrigem.FieldByName('UNIDADE').AsString)
  ]), []);
end;

procedure TProcessadorGravandoExecucaoArquivosRennerBases.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel gravar a base [%s - %s], [%s: %s]',
    [qryOrigem.FieldByName('PIG').AsString,
    qryOrigem.FieldByName('UNIDADE').AsString,
    E.ClassName,
    E.Message]);
end;

end.
