unit untNovaFormulaBrazilianColor;

interface

uses
  untINovaFormula, DB, Uni,  SysUtils, Classes;

type
  TNovaFormulaBrazilianColor = class(TInterfacedObject, INovaFormula)

  private
    qryCadBzc: TUniQuery;

    function GetCompoente(const strComponente: string; const qryNfm: TDataSet): TUniQuery;
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

{ TNovaFormulaBrazilianColor }

function TNovaFormulaBrazilianColor.ComponenteValido(const strComponente: string; const qryNfm: TDataSet): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := False;
  Try
    Try
      qryGen := GetCompoente(strComponente, qryNfm);
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

constructor TNovaFormulaBrazilianColor.Create;
begin
  qryCadBzc := fCriaQuery();
  qryCadBzc.SQL.Text := 'SELECT * FROM BZC_CADBZC WHERE FALSE';
  qryCadBzc.Open;
end;

destructor TNovaFormulaBrazilianColor.Destroy;
begin
  if Assigned(qryCadBzc) then FreeAndNil(qryCadBzc);
  inherited;
end;

procedure TNovaFormulaBrazilianColor.GetCamposChaves(var arrChaves: array of string);
begin
  arrChaves[0] := 'NFM_CODNFM';
end;

function TNovaFormulaBrazilianColor.GetCompoente(const strComponente: string; const qryNfm: TDataSet): TUniQuery;
begin
  Result := fCriaQuery();
  Result.SQL.Text := GetSqlSelectComponente(qryNfm);
  Result.SQL.Text := Result.SQL.Text +
    'WHERE BAS_CODBAS = :CODBAS';
  Result.ParamByName('CODBAS').AsString := strComponente;
  Result.Open;
end;

function TNovaFormulaBrazilianColor.GetCountCamposChaves: Integer;
begin
  Result := 1;
end;

function TNovaFormulaBrazilianColor.GetCountModos: Integer;
begin
  Result := 2;
end;

function TNovaFormulaBrazilianColor.GetIdePro: string;
begin
  Result := 'BZC';
end;

function TNovaFormulaBrazilianColor.GetMaximoComponentes: Integer;
begin
  Result := 20;
end;

function TNovaFormulaBrazilianColor.GetNomeCampoComponente: string;
begin
  Result := 'BAS_CODBAS';
end;

function TNovaFormulaBrazilianColor.GetNomeConfProCod: string;
begin
  Result := 'PROCOD';
end;

function TNovaFormulaBrazilianColor.GetNomeModo(const index: Integer): string;
const
  arrNomes: array[1..2] of String = ('Concentrado', 'Diluído');
begin
  Result := arrNomes[index];
end;

function TNovaFormulaBrazilianColor.GetNomeTabelaComponete: string;
begin
  Result := 'BZC_CADBAS';
end;

function TNovaFormulaBrazilianColor.GetNomeTabelaNovaFormula: string;
begin
  Result := 'BZC_CADNFM';
end;

function TNovaFormulaBrazilianColor.GetPrefixoComponente: string;
begin
  Result := 'NFM_BASE';
end;

function TNovaFormulaBrazilianColor.GetPrefixoQuantidade(const intModo: Integer): string;
const
  arrPrefix: array[1..2] of String = ('NFM_QTDC', 'NFM_QTDD');
begin
  Result := arrPrefix[intModo];
end;

function TNovaFormulaBrazilianColor.GetSqlSelectComponente(const qryNfm: TDataSet): string;
begin
  Result :=
    ' SELECT                                   ' +
    '   B.AUTOINCREM                           ' +
    '   , BAS_CODBAS AS ''Base''               ' +
    '   , BAS_DESBAS AS ''Descrição Base''     ' +
    '   , ITE_CODITE AS ''Código do Item''     ' +
    '   , ITE_DESITE AS ''Descrição do Item''  ' +
    '   , ITE_REFERE AS ''Referência do Item''  ' +
    ' FROM                                     ' +
    '   BZC_CADBAS B                           ' +
    '   LEFT JOIN CADITE I                     ' +
    '     ON B.BAS_CODITE = I.ITE_CODITE       ';
end;

function TNovaFormulaBrazilianColor.GetSqlSelectNovasFormulas: string;
begin
  Result := 'SELECT * FROM BZC_CADNFM';
end;

function TNovaFormulaBrazilianColor.GetTamanhoCampoComponente: Integer;
begin
  Result := 10;
end;

function TNovaFormulaBrazilianColor.GetTamanhoModo(const index: Integer): Integer;
begin
  Result := 0;
end;

function TNovaFormulaBrazilianColor.GetTipoModo(const index: Integer): TFieldType;
begin
  Result := ftFloat;
end;

function TNovaFormulaBrazilianColor.GravarNovaFormula(const qryNfm: TDataSet): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  qryCadBzc.Insert;
  qryCadBzc.FieldByName('BZC_CODIGO').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadBzc.FieldByName('BZC_CODUNI').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadBzc.FieldByName('BZC_DESCRI').AsString := qryNfm.FieldByName('NFM_DESCRI').AsString;
  qryCadBzc.FieldByName('BZC_A_N_O_').AsString := qryNfm.FieldByName('NFM_A_N_O_').AsString;
  qryCadBzc.FieldByName('BZC_CODMON').AsString := qryNfm.FieldByName('NFM_CODMON').AsString;
  qryCadBzc.FieldByName('BZC_REVISA').AsString := qryNfm.FieldByName('NFM_REVISA').AsString;
  qryCadBzc.FieldByName('BZC_ESPECI').AsString := qryNfm.FieldByName('NFM_ESPECI').AsString;
  qryCadBzc.FieldByName('BZC_TIPO__').AsString := qryNfm.FieldByName('NFM_TIPO__').AsString;
  qryCadBzc.FieldByName('BZC_CODPRE').AsString := qryNfm.FieldByName('NFM_CODPRE').AsString;
  qryCadBzc.FieldByName('BZC_CODPRO').AsString := qryNfm.FieldByName('NFM_CODPRO').AsString;
  qryCadBzc.FieldByName('BZC_CODSUF').AsString := qryNfm.FieldByName('NFM_CODSUF').AsString;
  qryCadBzc.FieldByName('BZC_PUBLIC').AsString := qryNfm.FieldByName('NFM_PUBLIC').AsString;
  qryCadBzc.FieldByName('BZC_PUBDTA').AsString := qryNfm.FieldByName('NFM_PUBDTA').AsString;
  qryCadBzc.FieldByName('BZC_AUTORI').AsString := qryNfm.FieldByName('NFM_AUTORI').AsString;
  qryCadBzc.FieldByName('BZC_REVISD').AsString := qryNfm.FieldByName('NFM_REVISD').AsString;
  qryCadBzc.FieldByName('BZC_ACRMOB').AsFloat  := qryNfm.FieldByName('NFM_ACRMOB').AsFloat;
  qryCadBzc.FieldByName('BZC_LINHA_').AsString := qryNfm.FieldByName('NFM_LINHA_').AsString;
  qryCadBzc.FieldByName('BZC_DTACAD').AsDateTime  := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;

  for intCont := 1 to 20 do
  begin
    if fEmptyStr(qryNfm.FieldByName('NFM_BASE' + fStrZero(intCont, 2)).AsString) then
      Break;

    if (fStrToFloat(qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsString) <= 0)
      and (fStrToFloat(qryNfm.FieldByName('NFM_QTDD' + fStrZero(intCont, 2)).AsString) <= 0) then
      Break;    
      
    qryCadBzc.FieldByName('BZC_BASE' + fStrZero(intCont, 2)).AsString := qryNfm.FieldByName('NFM_BASE' + fStrZero(intCont, 2)).AsString;
    qryCadBzc.FieldByName('BZC_QTDC' + fStrZero(intCont, 2)).AsFloat := qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat;
    qryCadBzc.FieldByName('BZC_QTDD' + fStrZero(intCont, 2)).AsFloat := qryNfm.FieldByName('NFM_QTDD' + fStrZero(intCont, 2)).AsFloat;
  end;

  qryCadBzc.FieldByName('BZC_CODNFM').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadBzc.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('BZC_CADBZC', VS_strCodEmp);
  qryCadBzc.FieldByName('BZC_CODEMP').AsString := VS_strCodEmp;
  qryCadBzc.FieldByName('BZC_MD5KEY').AsString := GetMD5(qryCadBzc.FieldByName('BZC_CODIGO').AsString +
                                                    qryCadBzc.FieldByName('BZC_CODUNI').AsString +
                                                    qryCadBzc.FieldByName('BZC_DESCRI').AsString +
                                                    qryCadBzc.FieldByName('BZC_A_N_O_').AsString +
                                                    qryCadBzc.FieldByName('BZC_TIPO__').AsString);
  qryCadBzc.Post;
end;

function TNovaFormulaBrazilianColor.IsValorVazio(const strValor: string): Boolean;
begin
  Result := fStrToFloat(strValor) <= 0;
end;

procedure TNovaFormulaBrazilianColor.MontaIndicesConsultaComponentes(const stlCamposIndices, stlDescricaoIndices: TStringList);
begin
  stlCamposIndices.Add('BAS_CODBAS');
  stlCamposIndices.Add('ITE_CODITE');
  stlCamposIndices.Add('ITE_DESITE');
  stlCamposIndices.Add('ITE_REFERE');

  stlDescricaoIndices.Add('Base');
  stlDescricaoIndices.Add('Código do Item');
  stlDescricaoIndices.Add('Descrição do Item');
  stlDescricaoIndices.Add('Referência do Item');
end;

procedure TNovaFormulaBrazilianColor.pCriaDataSets(const qryNfm: TDataSet);
var
  intCont: Integer;
begin
  qryNfm.FieldbyName('NFM_CODIGO').DisplayLabel := 'Código';
  qryNfm.FieldbyName('NFM_CODUNI').DisplayLabel := 'Código Universal';
  qryNfm.FieldbyName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryNfm.FieldbyName('NFM_A_N_O_').DisplayLabel := 'Ano';
  qryNfm.FieldbyName('NFM_CODMON').DisplayLabel := 'Código Montadora';
  qryNfm.FieldbyName('NFM_TIPO__').DisplayLabel := 'Tipo';
  qryNfm.FieldbyName('NFM_ACRMOB').DisplayLabel := 'Acréscimo mão de obra';
  qryNfm.FieldbyName('NFM_LINHA_').DisplayLabel := 'Linha';

  qryNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 20 Do
  Begin
    TFloatField(qryNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.00';
    TFloatField(qryNfm.FieldByName('NFM_QTDD' + fStrZero(intCont, 2))).DisplayFormat := '0.00';
  End;

  TFloatField(qryNfm.FieldByName('NFM_ACRMOB')).DisplayFormat := '0.00';
end;

procedure TNovaFormulaBrazilianColor.pInicializaIndices(const stlCampos, stlCamInd, stlDesInd: TStringList);
begin
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('NFM_A_N_O_');
  stlCampos.Add('NFM_TIPO__');
  stlCampos.Add('NFM_LINHA_');


  stlCamInd.Add('NFM_DESCRI');
  stlCamInd.Add('NFM_A_N_O_');
  stlCamInd.Add('NFM_TIPO__');
  stlCamInd.Add('NFM_LINHA_');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Ano');
  stlDesInd.Add('Tipo');
  stlDesInd.Add('Linha');
end;

procedure TNovaFormulaBrazilianColor.RemoverNovaFormula(const strCodNfm: string);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'DELETE FROM BZC_CADBZC WHERE BZC_CODNFM = :CODNFM';
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

procedure TNovaFormulaBrazilianColor.ValidaComponente(const strComponente: string; const qryNfm: TDataSet);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := GetCompoente(strComponente, qryNfm);
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
