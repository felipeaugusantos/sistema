unit untNovaFormulaHydronorth;

interface

uses
  untINovaFormula, DB, Uni,  SysUtils, Classes;

type
  TNovaFormulaHydronorth = class(TInterfacedObject, INovaFormula)
  private
    qryCadHyd: TUniQuery;
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

function TNovaFormulaHydronorth.ComponenteValido(const strComponente: string; const qryNfm: TDataSet): Boolean;
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

function TNovaFormulaHydronorth.GetColorante(const strComponente: string; const qryNfm: TDataSet): TUniQuery;
begin
  Result := fCriaQuery();
  Result.SQL.Text := GetSqlSelectComponente(qryNfm);
  Result.SQL.Text := Result.SQL.Text +
    'WHERE COL_CODCOL = :CODCOL ';
  Result.ParamByName('CODCOL').AsString := strComponente;
  Result.Open;
end;

constructor TNovaFormulaHydronorth.Create;
begin
  qryCadHyd := fCriaQuery();
  qryCadHyd.SQL.Text := 'SELECT * FROM HYD_CADHYD WHERE FALSE';
  qryCadHyd.Open;

  qryCadEmb := fCriaQuery();
  qryCadEmb.SQL.Text :=
    ' SELECT DISTINCT                   ' +
    '   HYD_CADEMB.*                    ' +
    ' FROM                              ' +
    '   HYD_CADEMB                      ' +
    '   INNER JOIN HYD_CADBAS           ' +
    '     ON EMB_CODEMB = BAS_CODEMB    ';
  qryCadEmb.Open;    
end;

destructor TNovaFormulaHydronorth.Destroy;
begin
  if Assigned(qryCadHyd) then FreeAndNil(qryCadHyd);
  if Assigned(qryCadEmb) then FreeAndNil(qryCadEmb);
  inherited;
end;

procedure TNovaFormulaHydronorth.GetCamposChaves(var arrChaves: array of string);
begin
  arrChaves[0] := 'NFM_CODNFM';
end;

function TNovaFormulaHydronorth.GetCountCamposChaves: Integer;
begin
  Result := 1;
end;

function TNovaFormulaHydronorth.GetCountModos: Integer;
begin
  Result := 1;
end;

function TNovaFormulaHydronorth.GetIdePro: string;
begin
  Result := 'HYD';
end;

function TNovaFormulaHydronorth.GetMaximoComponentes: Integer;
begin
  Result := 20;
end;

function TNovaFormulaHydronorth.GetNomeCampoComponente: string;
begin
  Result := 'COL_CODCOL';
end;

function TNovaFormulaHydronorth.GetNomeConfProCod: string;
begin
  Result := 'PROCOD';
end;

function TNovaFormulaHydronorth.GetNomeModo(const index: Integer): string;
begin
  Result := '';
end;

function TNovaFormulaHydronorth.GetNomeTabelaComponete: string;
begin
  Result := 'HYD_CADCOL';
end;

function TNovaFormulaHydronorth.GetNomeTabelaNovaFormula: string;
begin
  Result := 'HYD_CADNFM';
end;

function TNovaFormulaHydronorth.GetPrefixoComponente: string;
begin
  Result := 'NFM_FORM';
end;

function TNovaFormulaHydronorth.GetPrefixoQuantidade(const intModo: Integer): string;
begin
  Result := 'NFM_QTDC';
end;

function TNovaFormulaHydronorth.GetSqlSelectComponente(const qryNfm: TDataSet): string;
begin
  Result :=
    ' SELECT                                    ' +
    '   HYD_CADCOL.AUTOINCREM                   ' +
    '   , COL_CODCOL AS ''Código do Colorante'' ' +
    '   , ITE_CODITE AS ''Código do Item''      ' +
    '   , ITE_DESITE AS ''Descrição do Item''   ' +
    '   , ITE_REFERE AS ''Referência do Item''  ' +
    ' FROM                                      ' +
    '   HYD_CADCOL                              ' +
    '   LEFT JOIN CADITE                        ' +
    '     ON COL_CODITE = ITE_CODITE            ';
end;

function TNovaFormulaHydronorth.GetSqlSelectNovasFormulas: string;
begin
  Result := 'SELECT * FROM HYD_CADNFM';
end;

function TNovaFormulaHydronorth.GetTamanhoCampoComponente: Integer;
begin
  Result := 6;
end;

function TNovaFormulaHydronorth.GetTamanhoModo(const index: Integer): Integer;
begin
  Result := 0;
end;

function TNovaFormulaHydronorth.GetTipoModo(const index: Integer): TFieldType;
begin
  Result := ftFloat;
end;

function TNovaFormulaHydronorth.GravarNovaFormula(const qryNfm: TDataSet): Boolean;
var
  intCont: Integer;
  fltFator: Double;
begin
  Result := True;

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
        qryCadHyd.Insert;
        qryCadHyd.FieldByName('HYD_CODEMP').AsString := qryNfm.FieldByName('NFM_CODEMP').AsString;
        qryCadHyd.FieldByName('HYD_COLECA').AsString := qryNfm.FieldByName('NFM_COLECA').AsString;
        qryCadHyd.FieldByName('HYD_PRODUT').AsString := qryNfm.FieldByName('NFM_PRODUT').AsString;
        qryCadHyd.FieldByName('HYD_C_O_R_').AsString := qryNfm.FieldByName('NFM_C_O_R_').AsString;
        qryCadHyd.FieldByName('HYD_CORLON').AsString := qryNfm.FieldByName('NFM_CORLON').AsString;
        qryCadHyd.FieldByName('HYD_BASE__').AsString := qryNfm.FieldByName('NFM_BASE__').AsString;
        qryCadHyd.FieldByName('HYD_CODEMB').AsString := qryCadEmb.FieldByName('EMB_CODEMB').AsString;
        qryCadHyd.FieldByName('HYD_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;

        for intCont := 1 to 20 do
        begin
          if qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat <= 0 then
            Break;

          if fEmptyStr(qryNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) then
            Break;

          qryCadHyd.FieldByName('HYD_FORM' + fStrZero(intCont, 2)).AsString := qryNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
          qryCadHyd.FieldByName('HYD_QTDC' + fStrZero(intCont, 2)).AsFloat := qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat *
                                                                                qryCadEmb.FieldByName('EMB_TAMEMB').AsFloat / fltFator;
        end;

        qryCadHyd.FieldByName('HYD_CODNFM').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadHyd.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('HYD_CADHYD', qryNfm.FieldByName('NFM_CODEMP').AsString);
        qryCadHyd.FieldByName('HYD_MD5KEY').AsString := GetMD5(qryCadHyd.FieldByName('HYD_COLECA').AsString +
          qryCadHyd.FieldByName('HYD_PRODUT').AsString +
          qryCadHyd.FieldByName('HYD_C_O_R_').AsString +
          qryCadHyd.FieldByName('HYD_CORLON').AsString +
          qryCadHyd.FieldByName('HYD_BASE__').AsString +
          qryCadHyd.FieldByName('HYD_CODEMB').AsString);
        qryCadHyd.Post;
      Except
        on E: Exception do
        begin
        end;
      End;
    Finally
      qryCadEmb.Next;
    End;
  end;
end;

function TNovaFormulaHydronorth.IsValorVazio(const strValor: string): Boolean;
begin
  Result := fStrToFloat(strValor) <= 0;
end;

procedure TNovaFormulaHydronorth.MontaIndicesConsultaComponentes(const stlCamposIndices, stlDescricaoIndices: TStringList);
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

procedure TNovaFormulaHydronorth.pCriaDataSets(const qryNfm: TDataSet);
var
  intCont: Integer;
begin
  qryNfm.FieldbyName('NFM_COLECA').DisplayLabel := 'Coleção';
  qryNfm.FieldbyName('NFM_PRODUT').DisplayLabel := 'Produto';
  qryNfm.FieldbyName('NFM_C_O_R_').DisplayLabel := 'Cor';
  qryNfm.FieldbyName('NFM_CORLON').DisplayLabel := 'Cor Nome Longo';
  qryNfm.FieldbyName('NFM_BASE__').DisplayLabel := 'Base';
  qryNfm.FieldbyName('NFM_CODEMB').DisplayLabel := 'Embalagem';

  qryNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 20 Do
  Begin
    TFloatField(qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.00';
  End;
end;

procedure TNovaFormulaHydronorth.pInicializaIndices(const stlCampos, stlCamInd, stlDesInd: TStringList);
begin
  stlCampos.Add('NFM_COLECA');
  stlCampos.Add('NFM_PRODUT');
  stlCampos.Add('NFM_C_O_R_');
  stlCampos.Add('NFM_CORLON');
  stlCampos.Add('NFM_BASE__');
  stlCampos.Add('NFM_CODEMB');

  stlCamInd.Add('NFM_COLECA');
  stlCamInd.Add('NFM_PRODUT');
  stlCamInd.Add('NFM_C_O_R_');
  stlCamInd.Add('NFM_CORLON');
  stlCamInd.Add('NFM_BASE__');
  stlCamInd.Add('NFM_CODEMB');

  stlDesInd.Add('Coleção');
  stlDesInd.Add('Produto');
  stlDesInd.Add('Cor');
  stlDesInd.Add('Cor Nome Longo');
  stlDesInd.Add('Base');
  stlDesInd.Add('Embalagem');
end;

procedure TNovaFormulaHydronorth.RemoverNovaFormula(const strCodNfm: string);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'DELETE FROM HYD_CADHYD WHERE HYD_CODNFM = :CODNFM';
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

procedure TNovaFormulaHydronorth.ValidaComponente(const strComponente: string; const qryNfm: TDataSet);
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
