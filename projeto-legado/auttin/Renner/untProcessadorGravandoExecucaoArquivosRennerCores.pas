unit untProcessadorGravandoExecucaoArquivosRennerCores;

interface

uses
   Classes, DB, SysUtils, untIGravando,
  Variants, ADODB,  Uni, Math, untAbstractProcessadorGravandoExecucaoArquivosRennerCores,
  untIProcessadorGravandoExecucaoArquivosInsert;

type
  TProcessadorGravandoExecucaoArquivosRennerCores = class (TAbstractProcessadorGravandoExecucaoArquivosRennerCores,
    IProcessadorGravandoExecucaoArquivosInsert)
  private
    qryFormulas: TDataSet;
    function GetDataSetFormulas(const qryOrigem: TDataSet): TDataSet;
    procedure CreateDD01;
  public
    procedure GetArquivosProcessar(const stlArquivos: TStrings); override;
    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando; const qryOrigem: TDataSet;
      const qryDestino: TDataSet); override;
    constructor Create(); override;
    destructor Destroy; override;
    procedure ArquivoFormulaPadrao(const gravando: IGravando; const strNomeArquivo: string); override;
  end;

implementation

uses
  untFuncTinta, untFuncoesSimples, untDataSetFactory;

{ TProcessadorGravandoExecucaoArquivosRennerBases }

procedure TProcessadorGravandoExecucaoArquivosRennerCores.ArquivoFormulaPadrao(
  const gravando: IGravando; const strNomeArquivo: string);
begin

end;

constructor TProcessadorGravandoExecucaoArquivosRennerCores.Create;
begin
  inherited Create;
  Self.qryFormulas := nil;
end;

procedure TProcessadorGravandoExecucaoArquivosRennerCores.CreateDD01;
var
  qryGen: TADODataSet;
begin
  if not Assigned(qryFormulas) then
  begin
    qryGen := TDataSetFactory.GetIDataSet('RennerDD01').DataSet as TADODataSet;
    qryGen.CommandText :=
      ' SELECT                                                                                     ' +
      '   CODPROD, BASE, ''GL'' AS UNIDADE, PIG, QTD01_1 AS QTD1, QTD01_2 AS QTD2, QTD01_3 AS QTD3 ' +
      ' FROM                                                                                       ' +
      '   DD01#txt                                                                                 ' +
      ' WHERE (QTD01_1 > 0) OR (QTD01_2 > 0) OR (QTD01_3 > 0)                                      ' +
      ' UNION                                                                                      ' +
      ' SELECT                                                                                     ' +
      '   CODPROD, BASE, ''QT'' AS UNIDADE, PIG, QTD14_1, QTD14_2, QTD14_3                         ' +
      ' FROM                                                                                       ' +
      '   DD01#txt                                                                                 ' +
      ' WHERE (QTD14_1 > 0) OR (QTD14_2 > 0) OR (QTD14_3 > 0)                                      ' +
      ' UNION                                                                                      ' +
      ' SELECT                                                                                     ' +
      '   CODPROD, BASE, ''LA'' AS UNIDADE, PIG, QTD18_1, QTD18_2, QTD18_3                         ' +
      ' FROM                                                                                       ' +
      '   DD01#txt                                                                                 ' +
      ' WHERE (QTD18_1 > 0) OR (QTD18_2 > 0) OR (QTD18_3 > 0)                                      ' +
      ' ORDER BY 1, 2, 3                                                                           ';
    qryFormulas := qryGen;
  end;
  qryFormulas.Open;
end;

destructor TProcessadorGravandoExecucaoArquivosRennerCores.Destroy;
begin
  if Assigned(qryFormulas) then FreeAndNil(qryFormulas);
  inherited;
end;

procedure TProcessadorGravandoExecucaoArquivosRennerCores.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := ExtractFilePath(fGetConfTinta('REI').fGet('TXTREI')) + 'DM01.txt'
end;

function TProcessadorGravandoExecucaoArquivosRennerCores.GetDataSetFormulas(const qryOrigem: TDataSet): TDataSet;
begin
  CreateDD01;
  qryFormulas.Open;
  qryFormulas.Filtered := False;
  qryFormulas.Filter := Format('CODPROD = ''%s'' and BASE = ''%s'' and UNIDADE = ''%s''',
    [qryOrigem.FieldByName('CODPROD').AsString,
    qryOrigem.FieldByName('BASE').AsString,
    qryOrigem.FieldByName('UNIDADE').AsString]);
  qryFormulas.Filtered := True;
  Result := qryFormulas;
end;

function TProcessadorGravandoExecucaoArquivosRennerCores.GetDataSetOrigem(const strNomeArquivo: string): TDataSet;
var
  strSql: string;
  intCont: Integer;
const
  arrUnidades: array[1..3] of String = ('QT', 'GL', 'LA');
begin
  Result := TDataSetFactory.GetIDataSet('RennerDM01').DataSet;
  TDataSetFactory.GetIDataSet('RennerDM02').DataSet;

  strSql := '';
  for intCont := 1 to 3 do
  begin
    strSql := strSql +
      ' UNION                  ' +
      ' SELECT                 ' +
      '   D1.*                 ' +
      '   , D2.*               ' +
      '   , ' + QuotedStr(arrUnidades[intCont]) + ' AS UNIDADE  ' +
      ' FROM                   ' +
      '   DM01#txt D1,         ' +
      '   DM02#txt D2          ' +
      ' WHERE D1.BASE = D2.PIG ';
  end;

  strSql := Trim(strSql);
  strSql := Trim(Copy(strSql, Length('UNION') + 1, Length(strSql)));
  (Result as TADODataSet).CommandText := strSql;

  CreateDD01;
end;

procedure TProcessadorGravandoExecucaoArquivosRennerCores.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
var
  qryGrava: TUniQuery;
  qryFormulas: TDataSet;
begin
  qryFormulas := GetDataSetFormulas(qryOrigem);

  if qryFormulas.IsEmpty then
    Exit;

  qryGrava := qryDestino as TUniQuery;
  qryGrava.Params.Clear;
  qryGrava.SQL.Clear;
  qryGrava.SQL.Text := GetSqlDestino;

  qryGrava.ParamByName('REI_CODSEQ').AsString := fStrZero(qryOrigem.RecNo, 6);
  qryGrava.ParamByName('REI_DESCRI').AsString := UpperCase(qryOrigem.FieldByName('DESCR').AsString);
  qryGrava.ParamByName('REI_REFERE').AsString := UpperCase(qryOrigem.FieldByName('IDENT').AsString);
  qryGrava.ParamByName('REI_UNIDAD').AsString := UpperCase(qryOrigem.FieldByName('UNIDADE').AsString);
  qryGrava.ParamByName('REI_DESCOR').AsString := UpperCase(qryOrigem.FieldByName('COR').AsString);
  qryGrava.ParamByName('REI_CODPRO').AsString := UpperCase(qryOrigem.FieldByName('CODPROD').AsString);
  qryGrava.ParamByName('REI_CODBAS').AsString := UpperCase(qryOrigem.FieldByName('BASE').AsString);
  qryGrava.ParamByName('REI_CODEMP').AsString := VS_strCodEmp;
  qryGrava.ParamByName('AUTOINCREM').AsString := fFormataAutInc(fInc(intAuto), VS_strCodEmp);
  qryGrava.ParamByName('REI_DTACAD').AsDate := Trunc(qryOrigem.FieldByName('DT_CAD').AsDateTime);
  qryGrava.ParamByName('REI_STAT__').AsString := UpperCase(qryOrigem.FieldByName('STAT').AsString);
  qryGrava.ParamByName('REI_STAT2_').AsString := UpperCase(qryOrigem.FieldByName('STAT2').AsString);
  
  if not qryFormulas.IsEmpty then
  begin
    repeat
      qryGrava.ParamByName('REI_FORM' + fStrZero(qryFormulas.RecNo, 2)).AsString := UpperCase(qryFormulas.FieldByName('PIG').AsString);
      qryGrava.ParamByName('REI_QTDC' + fStrZero(qryFormulas.RecNo, 2)).AsFloat := fConverteOncaRenner(
        qryFormulas.FieldByName('QTD1').AsInteger,
        qryFormulas.FieldByName('QTD2').AsInteger,
        qryFormulas.FieldByName('QTD3').AsInteger
      );
    until not qryFormulas.FindNext;
  end;

  qryGrava.ExecSQL;
end;

procedure TProcessadorGravandoExecucaoArquivosRennerCores.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel gravar a cor [%s - %s - %s - %s - %s], [%s: %s]',
    [qryOrigem.FieldByName('CODPROD').AsString,
    qryOrigem.FieldByName('COR').AsString,
    qryOrigem.FieldByName('BASE').AsString,
    qryOrigem.FieldByName('IDENT').AsString,
    qryOrigem.FieldByName('UNIDADE').AsString,
    E.ClassName,
    E.Message]);
end;

end.

