unit untNovaFormulaCalamar;

interface

uses
  untINovaFormula, DB, Uni,  SysUtils, Classes;

type
  TNovaFormulaCalamar = class(TInterfacedObject, INovaFormula)
  private
    qryCadCal: TUniQuery;
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

{ TNovaFormulaCalamar }

function TNovaFormulaCalamar.ComponenteValido(const strComponente: string; const qryNfm: TDataSet): Boolean;
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

function TNovaFormulaCalamar.GetColorante(const strComponente: string; const qryNfm: TDataSet): TUniQuery;
begin
  Result := fCriaQuery();
  Result.SQL.Text := GetSqlSelectComponente(qryNfm);
  Result.SQL.Text := Result.SQL.Text +
    'WHERE COL_CODCOL = :CODCOL ';
  Result.ParamByName('CODCOL').AsString := strComponente;
  Result.Open;
end;

constructor TNovaFormulaCalamar.Create;
begin
  qryCadCal := fCriaQuery();
  qryCadCal.SQL.Text := 'SELECT * FROM CAL_CADCAL WHERE FALSE';
  qryCadCal.Open;

  qryCadEmb := fCriaQuery();
  qryCadEmb.SQL.Text :=
    ' SELECT DISTINCT                   ' +
    '   CAL_CADEMB.*                    ' +
    ' FROM                              ' +
    '   CAL_CADEMB                      ' +
    '   INNER JOIN CAL_CADBAS           ' +
    '     ON EMB_CODEMB = BAS_CODEMB    ';
  qryCadEmb.Open;
end;

destructor TNovaFormulaCalamar.Destroy;
begin
  if Assigned(qryCadCal) then FreeAndNil(qryCadCal);
  if Assigned(qryCadEmb) then FreeAndNil(qryCadEmb);
  inherited;
end;

procedure TNovaFormulaCalamar.GetCamposChaves(var arrChaves: array of string);
begin
  arrChaves[0] := 'NFM_CODNFM';
end;

function TNovaFormulaCalamar.GetCountCamposChaves: Integer;
begin
  Result := 1;
end;

function TNovaFormulaCalamar.GetCountModos: Integer;
begin
  Result := 1;
end;

function TNovaFormulaCalamar.GetIdePro: string;
begin
  Result := 'CAL';
end;

function TNovaFormulaCalamar.GetMaximoComponentes: Integer;
begin
  Result := 20;
end;

function TNovaFormulaCalamar.GetNomeCampoComponente: string;
begin
  Result := 'COL_CODCOL';
end;

function TNovaFormulaCalamar.GetNomeConfProCod: string;
begin
  Result := 'PROCOD';
end;

function TNovaFormulaCalamar.GetNomeModo(const index: Integer): string;
begin
  Result := '';
end;

function TNovaFormulaCalamar.GetNomeTabelaComponete: string;
begin
  Result := 'CAL_CADCOL';
end;

function TNovaFormulaCalamar.GetNomeTabelaNovaFormula: string;
begin
  Result := 'CAL_CADNFM';
end;

function TNovaFormulaCalamar.GetPrefixoComponente: string;
begin
  Result := 'NFM_CODC';
end;

function TNovaFormulaCalamar.GetPrefixoQuantidade(const intModo: Integer): string;
begin
  Result := 'NFM_QTDC';
end;

function TNovaFormulaCalamar.GetSqlSelectComponente(const qryNfm: TDataSet): string;
begin
  Result :=
    ' SELECT                                  ' +
    '   CAL_CADCOL.AUTOINCREM                 ' +
    '   , COL_CODCOL AS "Código do Colorante" ' +
    '   , ITE_CODITE AS "Código do Item"      ' +
    '   , ITE_DESITE AS "Descrição do Item"   ' +
    '   , ITE_REFERE AS "Referência do Item"  ' +
    ' FROM                                    ' +
    '   CAL_CADCOL                            ' +
    '   LEFT JOIN CADITE                      ' +
    '     ON COL_CODITE = ITE_CODITE          ';
end;

function TNovaFormulaCalamar.GetSqlSelectNovasFormulas: string;
begin
  Result := 'SELECT * FROM CAL_CADNFM';
end;

function TNovaFormulaCalamar.GetTamanhoCampoComponente: Integer;
begin
  Result := 5;
end;

function TNovaFormulaCalamar.GetTamanhoModo(const index: Integer): Integer;
begin
  Result := 0;
end;

function TNovaFormulaCalamar.GetTipoModo(const index: Integer): TFieldType;
begin
  Result := ftFloat;
end;

function TNovaFormulaCalamar.GravarNovaFormula(const qryNfm: TDataSet): Boolean;
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
        qryCadCal.Insert;
        qryCadCal.FieldByName('CAL_CODEMP').AsString := qryNfm.FieldByName('NFM_CODEMP').AsString;
        qryCadCal.FieldByName('CAL_CODBAS').AsString := qryNfm.FieldByName('NFM_CODBAS').AsString;
        qryCadCal.FieldByName('CAL_KEY1__').AsString := qryNfm.FieldByName('NFM_KEY1__').AsString;
        qryCadCal.FieldByName('CAL_KEY2__').AsString := qryNfm.FieldByName('NFM_KEY2__').AsString;
        qryCadCal.FieldByName('CAL_KEY3__').AsString := qryNfm.FieldByName('NFM_KEY3__').AsString;
        qryCadCal.FieldByName('CAL_CODEMB').AsString := qryCadEmb.FieldByName('EMB_CODEMB').AsString;
        qryCadCal.FieldByName('CAL_PRODUT').AsString := qryNfm.FieldByName('NFM_PRODUT').AsString;
        qryCadCal.FieldByName('CAL_COLECA').AsString := qryNfm.FieldByName('NFM_COLECA').AsString;

        for intCont := 1 to 20 do
        begin
          if qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat <= 0 then
            Break;

          if fEmptyStr(qryNfm.FieldByName('NFM_CODC' + fStrZero(intCont, 2)).AsString) then
            Break;

          qryCadCal.FieldByName('CAL_CODC' + fStrZero(intCont, 2)).AsString := qryNfm.FieldByName('NFM_CODC' + fStrZero(intCont, 2)).AsString;
          qryCadCal.FieldByName('CAL_QTDC' + fStrZero(intCont, 2)).AsFloat := qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat *
                                                                                qryCadEmb.FieldByName('EMB_TAMEMB').AsFloat / fltFator;
        end;

        qryCadCal.FieldByName('CAL_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;
        qryCadCal.FieldByName('CAL_CODNFM').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadCal.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CAL_CADCAL', qryNfm.FieldByName('NFM_CODEMP').AsString);
        qryCadCal.FieldByName('CAL_MD5KEY').AsString := GetMD5(qryCadCal.FieldByName('CAL_CODBAS').AsString +
          qryCadCal.FieldByName('CAL_CODEMB').AsString +
          qryCadCal.FieldByName('CAL_KEY1__').AsString +
          qryCadCal.FieldByName('CAL_KEY2__').AsString +
          qryCadCal.FieldByName('CAL_KEY3__').AsString +
          qryCadCal.FieldByName('CAL_PRODUT').AsString +
          qryCadCal.FieldByName('CAL_COLECA').AsString);
        qryCadCal.Post;
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

function TNovaFormulaCalamar.IsValorVazio(const strValor: string): Boolean;
begin
  Result := fStrToFloat(strValor) <= 0;
end;

procedure TNovaFormulaCalamar.MontaIndicesConsultaComponentes(const stlCamposIndices, stlDescricaoIndices: TStringList);
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

procedure TNovaFormulaCalamar.pCriaDataSets(const qryNfm: TDataSet);
var
  intCont: Integer;
begin
  qryNfm.FieldbyName('NFM_COLECA').DisplayLabel := 'Coleção';
  qryNfm.FieldbyName('NFM_PRODUT').DisplayLabel := 'Produto';
  qryNfm.FieldbyName('NFM_KEY1__').DisplayLabel := 'Key 1';
  qryNfm.FieldbyName('NFM_KEY2__').DisplayLabel := 'Key 2';
  qryNfm.FieldbyName('NFM_KEY3__').DisplayLabel := 'Key 3';
  qryNfm.FieldbyName('NFM_CODBAS').DisplayLabel := 'Base';
  qryNfm.FieldbyName('NFM_CODEMB').DisplayLabel := 'Embalagem';

  qryNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 20 Do
  Begin
    TFloatField(qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.00';
  End;
end;

procedure TNovaFormulaCalamar.pInicializaIndices(const stlCampos, stlCamInd, stlDesInd: TStringList);
begin
  stlCampos.Add('NFM_COLECA');
  stlCampos.Add('NFM_PRODUT');
  stlCampos.Add('NFM_KEY1__');
  stlCampos.Add('NFM_KEY2__');
  stlCampos.Add('NFM_KEY3__');
  stlCampos.Add('NFM_CODBAS');
  stlCampos.Add('NFM_CODEMB');

  stlCamInd.Add('NFM_COLECA');
  stlCamInd.Add('NFM_PRODUT');
  stlCamInd.Add('NFM_KEY1__');
  stlCamInd.Add('NFM_KEY2__');
  stlCamInd.Add('NFM_KEY3__');
  stlCamInd.Add('NFM_CODBAS');
  stlCamInd.Add('NFM_CODEMB');


  stlDesInd.Add('Coleção');
  stlDesInd.Add('Produto');
  stlDesInd.Add('Key 1');
  stlDesInd.Add('Key 2');
  stlDesInd.Add('Key 3');
  stlDesInd.Add('Base');
  stlDesInd.Add('Embalagem');

end;

procedure TNovaFormulaCalamar.RemoverNovaFormula(const strCodNfm: string);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'DELETE FROM CAL_CADCAL WHERE CAL_CODNFM = :CODNFM';
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

procedure TNovaFormulaCalamar.ValidaComponente(const strComponente: string; const qryNfm: TDataSet);
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
