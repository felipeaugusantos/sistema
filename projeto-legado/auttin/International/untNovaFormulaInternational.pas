unit untNovaFormulaInternational;

interface

uses
  untINovaFormula, DB, Uni,  SysUtils, Classes;

type
  TNovaFormulaInternational = class(TInterfacedObject, INovaFormula)
  private
    qryCadInt: TUniQuery;
    qryCadEmb: TUniQuery;
    function GetColorante(const strComponente: string; const qryNfm: TDataSet): TUniQuery;
  public
    procedure GetCamposChaves(var arrChaves: array of string);
    function GetCountCamposChaves: Integer;
    function GetIdePro: string;
    function GetNomeConfProCod: string;
    function GetNomeTabelaNovaFormula: string;
    function GetSqlSelectNovasFormulas: string;
    function GravarNovaFormula(const qryNfm: TDataSet): Boolean;
    procedure RemoverNovaFormula(const strCodNfm: string);
    function GetCountModos: Integer;
    function GetMaximoComponentes: Integer;
    function GetNomeModo(const index: Integer): string;
    function GetPrefixoComponente: string;
    function GetPrefixoQuantidade(const intModo: Integer): string;
    function GetTamanhoCampoComponente: Integer;
    function GetTamanhoModo(const index: Integer): Integer;
    function GetTipoModo(const index: Integer): TFieldType;
    procedure pCriaDataSets(const qryNfm: TDataSet);
    procedure pInicializaIndices(const stlCampos, stlCamInd, stlDesInd: TStringList);
    function ComponenteValido(const strComponente: string; const qryNfm: TDataSet): Boolean;
    procedure ValidaComponente(const strComponente: string; const qryNfm: TDataSet);
    function GetNomeTabelaComponete: string;
    function GetSqlSelectComponente(const qryNfm: TDataSet): string;
    procedure MontaIndicesConsultaComponentes(const stlCamposIndices: TStringList; const stlDescricaoIndices: TStringList);
    function GetNomeCampoComponente: string;
    function IsValorVazio(const strValor: string): Boolean;
    constructor Create();
    destructor Destroy; override;
  end;

implementation

uses untFuncoesSimples;

{ TNovaFormulaVelutex }

function TNovaFormulaInternational.ComponenteValido(const strComponente: string; const qryNfm: TDataSet): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      qryGen := GetColorante(strComponente, qryNfm);
      Result := (not qryGen.IsEmpty);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;

function TNovaFormulaInternational.GetColorante(const strComponente: string; const qryNfm: TDataSet): TUniQuery;
begin
  Result := fCriaQuery();
  Result.SQL.Text := GetSqlSelectComponente(qryNfm);
  Result.SQL.Text := Result.SQL.Text +
    'WHERE COL_CODCOL = :CODCOL ';
  Result.ParamByName('CODCOL').AsString := strComponente;
  Result.Open;
end;

constructor TNovaFormulaInternational.Create;
begin
  qryCadInt := fCriaQuery();
  qryCadInt.SQL.Text := 'SELECT * FROM INT_CADINT WHERE FALSE';
  qryCadInt.Open;

  qryCadEmb := fCriaQuery();
  qryCadEmb.SQL.Text :=
    ' SELECT DISTINCT                   ' +
    '   INT_CADEMB.*                    ' +
    ' FROM                              ' +
    '   INT_CADEMB                      ' +
    '   INNER JOIN INT_CADBAS           ' +
    '     ON EMB_CODEMB = BAS_CODEMB    ';
  qryCadEmb.Open;    
end;

destructor TNovaFormulaInternational.Destroy;
begin
  if Assigned(qryCadInt) then FreeAndNil(qryCadInt);
  if Assigned(qryCadEmb) then FreeAndNil(qryCadEmb);
  inherited;
end;

procedure TNovaFormulaInternational.GetCamposChaves(var arrChaves: array of string);
begin
  arrChaves[0] := 'NFM_CODNFM';
end;

function TNovaFormulaInternational.GetCountCamposChaves: Integer;
begin
  Result := 1;
end;

function TNovaFormulaInternational.GetCountModos: Integer;
begin
  Result := 1;
end;

function TNovaFormulaInternational.GetIdePro: string;
begin
  Result := 'INT';
end;

function TNovaFormulaInternational.GetMaximoComponentes: Integer;
begin
  Result := 20;
end;

function TNovaFormulaInternational.GetNomeCampoComponente: string;
begin
  Result := 'COL_CODCOL';
end;

function TNovaFormulaInternational.GetNomeConfProCod: string;
begin
  Result := 'PROCOD';
end;

function TNovaFormulaInternational.GetNomeModo(const index: Integer): string;
begin
  Result := '';
end;

function TNovaFormulaInternational.GetNomeTabelaComponete: string;
begin
  Result := 'INT_CADCOL';
end;

function TNovaFormulaInternational.GetNomeTabelaNovaFormula: string;
begin
  Result := 'INT_CADNFM';
end;

function TNovaFormulaInternational.GetPrefixoComponente: string;
begin
  Result := 'NFM_FORM';
end;

function TNovaFormulaInternational.GetPrefixoQuantidade(const intModo: Integer): string;
begin
  Result := 'NFM_QTDC';
end;

function TNovaFormulaInternational.GetSqlSelectComponente(const qryNfm: TDataSet): string;
begin
  Result :=
    ' SELECT                                    ' +
    '   INT_CADCOL.AUTOINCREM                   ' +
    '   , COL_CODCOL AS ''Código do Colorante'' ' +
    '   , ITE_CODITE AS ''Código do Item''      ' +
    '   , ITE_DESITE AS ''Descrição do Item''   ' +
    '   , ITE_REFERE AS ''Referência do Item''  ' +
    ' FROM                                      ' +
    '   INT_CADCOL                              ' +
    '   LEFT JOIN CADITE                        ' +
    '     ON COL_CODITE = ITE_CODITE            ';
end;

function TNovaFormulaInternational.GetSqlSelectNovasFormulas: string;
begin
  Result := 'SELECT * FROM INT_CADNFM';
end;

function TNovaFormulaInternational.GetTamanhoCampoComponente: Integer;
begin
  Result := 6;
end;

function TNovaFormulaInternational.GetTamanhoModo(const index: Integer): Integer;
begin
  Result := 0;
end;

function TNovaFormulaInternational.GetTipoModo(const index: Integer): TFieldType;
begin
  Result := ftFloat;
end;

function TNovaFormulaInternational.GravarNovaFormula(const qryNfm: TDataSet): Boolean;
var
  intCont: Integer;
  fltFator: Double;
  strMD5: String;
begin
  Result := True;
  strMD5 := '';

  qryCadEmb.Filtered := False;
  qryCadEmb.Filter := 'EMB_CODEMB = ' + QuotedStr(qryNfm.FieldByName('NFM_CODEMB').AsString);
  qryCadEmb.Filtered := True;
  fltFator := qryCadEmb.FieldByName('EMB_TAMEMB').AsFloat;

  qryCadEmb.Filtered := False;
  qryCadEmb.Filter := '';
  qryCadEmb.Filtered := True;
  qryCadEmb.First;

  while not qryCadEmb.Eof do
  begin
    Try
      Try
        qryCadInt.Insert;
        qryCadInt.FieldByName('INT_CODEMP').AsString := qryNfm.FieldByName('NFM_CODEMP').AsString;
        qryCadInt.FieldByName('INT_DESCOR').AsString := qryNfm.FieldByName('NFM_DESCOR').AsString;
        qryCadInt.FieldByName('INT_CODBAS').AsString := qryNfm.FieldByName('NFM_CODBAS').AsString;
        qryCadInt.FieldByName('INT_CODEMB').AsString := qryCadEmb.FieldByName('EMB_CODEMB').AsString;
        qryCadInt.FieldByName('INT_LINHA_').AsString := qryNfm.FieldByName('NFM_LINHA_').AsString;

        for intCont := 1 to 20 do
        begin
          if qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat <= 0 then
            Break;

          if fEmptyStr(qryNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) then
            Break;

          qryCadInt.FieldByName('INT_FORM' + fStrZero(intCont, 2)).AsString := qryNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
          qryCadInt.FieldByName('INT_QTDC' + fStrZero(intCont, 2)).AsFloat := qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat *
                                                                                qryCadEmb.FieldByName('EMB_TAMEMB').AsFloat / fltFator;

          strMD5 := strMD5 +
            qryCadInt.FieldByName('INT_FORM' + fStrZero(intCont, 2)).AsString +
            FloatToStr(qryCadInt.FieldByName('INT_QTDC' + fStrZero(intCont, 2)).AsFloat);
        end;

        qryCadInt.FieldByName('INT_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;
        qryCadInt.FieldByName('INT_CODNFM').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadInt.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('INT_CADINT', qryNfm.FieldByName('NFM_CODEMP').AsString);
        qryCadInt.FieldByName('INT_MD5KEY').AsString := GetMD5(qryCadInt.FieldByName('INT_LINHA_').AsString +
          qryCadInt.FieldByName('INT_DESCOR').AsString +
          qryCadInt.FieldByName('INT_CODBAS').AsString + 
          qryCadInt.FieldByName('INT_CODEMB').AsString +
          qryCadInt.FieldByName('INT_CODNFM').AsString +
          strMD5);
        qryCadInt.Post;
      Except
        on E: Exception do
        begin
          raise;
        end;
      End;
    Finally
      qryCadEmb.Next;
    End;
  end;
end;

function TNovaFormulaInternational.IsValorVazio(const strValor: string): Boolean;
begin
  Result := fStrToFloat(strValor) <= 0;
end;

procedure TNovaFormulaInternational.MontaIndicesConsultaComponentes(const stlCamposIndices, stlDescricaoIndices: TStringList);
begin
  stlCamposIndices.Add('COL_CODCOL');
  stlCamposIndices.Add('ITE_CODITE');
  stlCamposIndices.Add('ITE_DESITE');
  stlCamposIndices.Add('ITE_REFERE');

  stlDescricaoIndices.Add('Código do Colorante');
  stlDescricaoIndices.Add('Código do Item');
  stlDescricaoIndices.Add('Descrição do Item');
  stlDescricaoIndices.Add('Referência do Item');
end;

procedure TNovaFormulaInternational.pCriaDataSets(const qryNfm: TDataSet);
var
  intCont: Integer;
begin
  qryNfm.FieldbyName('NFM_DESCOR').DisplayLabel := 'Cor';
  qryNfm.FieldbyName('NFM_CODBAS').DisplayLabel := 'Base';
  qryNfm.FieldbyName('NFM_CODEMB').DisplayLabel := 'Embalagem';
  qryNfm.FieldbyName('NFM_LINHA_').DisplayLabel := 'Linha';

  qryNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 20 Do
  Begin
    TFloatField(qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.00';
  End;
end;

procedure TNovaFormulaInternational.pInicializaIndices(const stlCampos, stlCamInd, stlDesInd: TStringList);
begin
  stlCampos.Add('NFM_DESCOR');
  stlCampos.Add('NFM_CODBAS');
  stlCampos.Add('NFM_CODEMB');
  stlCampos.Add('NFM_LINHA_');

  stlCamInd.Add('NFM_DESCOR');
  stlCamInd.Add('NFM_CODBAS');
  stlCamInd.Add('NFM_CODEMB');
  stlCamInd.Add('NFM_LINHA_');

  stlDesInd.Add('Cor');
  stlDesInd.Add('Base');
  stlDesInd.Add('Embalagem');
  stlDesInd.Add('Linha');
end;

procedure TNovaFormulaInternational.RemoverNovaFormula(const strCodNfm: string);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'DELETE FROM INT_CADINT WHERE INT_CODNFM = :CODNFM';
      qryGen.ParamByName('CODNFM').AsString := strCodNfm;
      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

procedure TNovaFormulaInternational.ValidaComponente(const strComponente: string; const qryNfm: TDataSet);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := GetColorante(strComponente, qryNfm);
      if qryGen.IsEmpty then
        raise Exception.CreateFmt('O componente [%s] não está cadastrado!', [strComponente]);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

end.
