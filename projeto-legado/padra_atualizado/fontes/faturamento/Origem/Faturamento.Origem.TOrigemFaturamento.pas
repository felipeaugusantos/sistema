unit Faturamento.Origem.TOrigemFaturamento;

interface

type
  TOrigemFaturamento = record
  strict private
    const
      strTABELA = 'ORIFGO';
      strCAMPO_CODIGO = 'ORI_CODORI';
      strCAMPO_DESCRICAO = 'ORI_DESORI';
      strCAMPO_PERMITE_CANCELAMENTO = 'ORI_CANORI';
  strict private
    FCodigo: String;
    function GetCodigo: string;
    function GetDescricao: string;
    function GetPermiteCancelamento: Boolean;
    function GetIsValid: Boolean;
    procedure SetCodigo(const Value: string);
    procedure CadastraTabelaDeOrigem;
  public
    property Codigo: string read GetCodigo write SetCodigo;
    property Descricao: string read GetDescricao;
    property PermiteCancelamento: Boolean read GetPermiteCancelamento;
    property IsValid: Boolean read GetIsValid;

    class function GetByCodigo(const strValor: string): TOrigemFaturamento; static;
    class function GetByDescricao(const strValor: string): TOrigemFaturamento; static;
    class function GetOrigemDocumento(const strNumDoc, strEspDoc, strCodEmp: string): TOrigemFaturamento; overload; static;
    class function GetOrigemDocumento(const strCodOri: string): TOrigemFaturamento; overload; static;
    class function AtualizarOrigemDocumento(const strNumDoc, strEspDoc, strCodEmp: string; var Origem: TOrigemFaturamento): boolean; static;
  end;

  TValidaOrigemFaturamento = class abstract
  strict private
    const
      strMENSAGEM_ERRO =  'Os documentos de origem %s - %s não podem ser cancelados!';
  public
    class function DocumentoPermiteCancelamento(const strNumDoc, strEspDoc, strCodEmp: string): boolean;
  end;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  System.SysUtils, Data.DB, Uni;

class function TOrigemFaturamento.GetByCodigo(const strValor: string): TOrigemFaturamento;
begin
  Result.Codigo := strValor;
end;

class function TOrigemFaturamento.GetByDescricao(
  const strValor: string): TOrigemFaturamento;
begin
  Result.Codigo := fCampoTabela(strCAMPO_CODIGO,
                                strTABELA,
                                [strCAMPO_DESCRICAO],
                                [strValor], False);
end;

function TOrigemFaturamento.GetCodigo: string;
begin
  Result := fStrZero(FCodigo, 3);
end;

function TOrigemFaturamento.GetDescricao: string;
begin
  Result := fCampoTabela(strCAMPO_DESCRICAO,
                         strTABELA,
                         [strCAMPO_CODIGO],
                         [Self.Codigo], False);
end;

function TOrigemFaturamento.GetIsValid: Boolean;
begin
  Result := not Self.GetDescricao.IsEmpty;
end;

class function TOrigemFaturamento.GetOrigemDocumento(const strCodOri: string): TOrigemFaturamento;
begin
  Result := GetByCodigo(strCodOri);
end;

class function TOrigemFaturamento.GetOrigemDocumento(const strNumDoc, strEspDoc, strCodEmp: string): TOrigemFaturamento;
const
  strCONSULTA_SQL = 'SELECT FGO_CODORI CODIGO_ORIGEM ' + sLineBreak +
                    '  FROM EXTGOR ' + sLineBreak +
                    '  JOIN FATGOR ' + sLineBreak +
                    '    ON AUTOINCREM = FGO_SEQFGO ' + sLineBreak +
                    ' WHERE FGO_NUMDOC = :FGO_NUMDOC ' + sLineBreak +
                    '   AND FGO_ESPDOC = :FGO_ESPDOC ' + sLineBreak +
                    '   AND FGO_CODEMP = :FGO_CODEMP ';

var
  objQryTemp: TUniQuery;
begin
  objQryTemp := fCriaQuery;
  try
    objQryTemp.SQL.Text := strCONSULTA_SQL;
    objQryTemp.ParamByName('FGO_NUMDOC').AsString := strNumDoc;
    objQryTemp.ParamByName('FGO_ESPDOC').AsString := strEspDoc;
    objQryTemp.ParamByName('FGO_CODEMP').AsString := strCodEmp;
    objQryTemp.Open;
    Result := GetByCodigo(objQryTemp.FieldByName('CODIGO_ORIGEM').AsString);
  finally
    if Assigned(objQryTemp) then
    begin
      objQryTemp.Close;
      FreeAndNil(objQryTemp);
    end;
  end;
end;

function TOrigemFaturamento.GetPermiteCancelamento: Boolean;
const
  strSIM = 'S';
begin
  Result := fCampoTabela(strCAMPO_PERMITE_CANCELAMENTO,
                         strTABELA,
                        [strCAMPO_CODIGO],
                        [Self.Codigo], False) = strSIM;
end;

procedure TOrigemFaturamento.SetCodigo(const Value: string);
begin
  FCodigo := fStrZero(Value, 3);
end;

procedure TOrigemFaturamento.CadastraTabelaDeOrigem;
var
  intCodigo: Integer;
  strInsert: String;
  blnResult: Boolean;
begin
  blnResult := True;

  intCodigo := StrToIntDef(Self.Codigo,0);

  case intCodigo of
     1: strInsert := 'INSERT INTO `ORIFGO` (`AUTOINCREM`, `ORI_CODORI`, `ORI_DESORI`, `ORI_CANORI`) VALUES("00000000000000001000","001","AUTCOM","S")';
     2: strInsert := 'INSERT INTO `ORIFGO` (`AUTOINCREM`, `ORI_CODORI`, `ORI_DESORI`, `ORI_CANORI`) VALUES("00000000000000002000","002","MARKET PLACE - SKYHUB","S")';
     3: strInsert := 'INSERT INTO `ORIFGO` (`AUTOINCREM`, `ORI_CODORI`, `ORI_DESORI`, `ORI_CANORI`) VALUES("00000000000000003000","003","MARKET PLACE - HUBCITEL","S")';
     4: strInsert := 'INSERT INTO `ORIFGO` (`AUTOINCREM`, `ORI_CODORI`, `ORI_DESORI`, `ORI_CANORI`) VALUES("00000000000000004000","004","MARKET PLACE - HUB2B","S")';
     5: strInsert := 'INSERT INTO `ORIFGO` (`AUTOINCREM`, `ORI_CODORI`, `ORI_DESORI`, `ORI_CANORI`) VALUES("00000000000000005000","005","ECOMMERCE - IRROBA","S")';
     6: strInsert := 'INSERT INTO `ORIFGO` (`AUTOINCREM`, `ORI_CODORI`, `ORI_DESORI`, `ORI_CANORI`) VALUES("00000000000000006000","006","ECOMMERCE - VTEX","S")';
     7: strInsert := 'INSERT INTO `ORIFGO` (`AUTOINCREM`, `ORI_CODORI`, `ORI_DESORI`, `ORI_CANORI`) VALUES("00000000000000007000","007","ECOMMERCE - TRAY","S")';
     8: strInsert := 'INSERT INTO `ORIFGO` (`AUTOINCREM`, `ORI_CODORI`, `ORI_DESORI`, `ORI_CANORI`) VALUES("00000000000000008000","008","FORÇA DE VENDAS - APP SALES","S")';
     9: strInsert := 'INSERT INTO `ORIFGO` (`AUTOINCREM`, `ORI_CODORI`, `ORI_DESORI`, `ORI_CANORI`) VALUES("00000000000000009000","009","FORÇA DE VENDAS - MASTERSALES","S")';
    10: strInsert := 'INSERT INTO `ORIFGO` (`AUTOINCREM`, `ORI_CODORI`, `ORI_DESORI`, `ORI_CANORI`) VALUES("00000000000000010000","010","FORÇA DE VENDAS - FAITH SYSTEM","S")';
    11: strInsert := 'INSERT INTO `ORIFGO` (`AUTOINCREM`, `ORI_CODORI`, `ORI_DESORI`, `ORI_CANORI`) VALUES("00000000000000011000","011","FORÇA DE VENDAS - ACÁCIA SERVER","S")';
    12: strInsert := 'INSERT INTO `ORIFGO` (`AUTOINCREM`, `ORI_CODORI`, `ORI_DESORI`, `ORI_CANORI`) VALUES("00000000000000012000","012","HUBCITEL - MERCADO LIVRE","S")';
    13: strInsert := 'INSERT INTO `ORIFGO` (`AUTOINCREM`, `ORI_CODORI`, `ORI_DESORI`, `ORI_CANORI`) VALUES("00000000000000013000","013","HUBCITEL - SKYHUB","N")';
  else
    blnResult := false;
  end;

  If blnResult Then
    fExecutaSQL(strInsert);

end;

class function TOrigemFaturamento.AtualizarOrigemDocumento(
  const strNumDoc, strEspDoc, strCodEmp: string; var Origem: TOrigemFaturamento): boolean;
const
  strCONSULTA_SQL = 'SELECT FGO_SEQFGO AUTOINCREM, ' + sLineBreak +
                    '       FGO_CODORI CODIGO_ORIGEM ' + sLineBreak +
                    '  FROM EXTGOR ' + sLineBreak +
                    '  JOIN FATGOR ' + sLineBreak +
                    '    ON AUTOINCREM = FGO_SEQFGO ' + sLineBreak +
                    ' WHERE FGO_NUMDOC = :FGO_NUMDOC ' + sLineBreak +
                    '   AND FGO_ESPDOC = :FGO_ESPDOC ' + sLineBreak +
                    '   AND FGO_CODEMP = :FGO_CODEMP ';
var
  objQryTemp: TUniQuery;
begin
  objQryTemp := fCriaQuery;
  try
    objQryTemp.SQL.Text := strCONSULTA_SQL;
    objQryTemp.ParamByName('FGO_NUMDOC').AsString := strNumDoc;
    objQryTemp.ParamByName('FGO_ESPDOC').AsString := strEspDoc;
    objQryTemp.ParamByName('FGO_CODEMP').AsString := strCodEmp;
    objQryTemp.Open;

    if objQryTemp.IsEmpty then
      Exit(True);

    if not Origem.IsValid then
      Origem.CadastraTabelaDeOrigem;

    if not Origem.IsValid then
      Origem := GetByDescricao('AUTCOM');

    if not Origem.IsValid then
      Exit(True);

    if objQryTemp.FieldByName('CODIGO_ORIGEM').AsString = Origem.Codigo then
      Exit(True);

    objQryTemp.Edit;
    objQryTemp.FieldByName('CODIGO_ORIGEM').AsString := Origem.Codigo;
    objQryTemp.Post;

    result := True;
  finally
    if Assigned(objQryTemp) then
    begin
      objQryTemp.Close;
      FreeAndNil(objQryTemp);
    end;
  end;
end;

{ TValidaOrigemFaturamento }

class function TValidaOrigemFaturamento.DocumentoPermiteCancelamento(const strNumDoc, strEspDoc, strCodEmp: string): boolean;
var
  OrigemFaturamento: TOrigemFaturamento;
begin
  OrigemFaturamento := TOrigemFaturamento.GetOrigemDocumento(strNumDoc, strEspDoc, strCodEmp);

  if (not OrigemFaturamento.IsValid) then
    Exit(True);

  if (OrigemFaturamento.PermiteCancelamento) then
    Exit(True);

  Result := False;
  pMensagemOK(Format(strMENSAGEM_ERRO, [OrigemFaturamento.Codigo, OrigemFaturamento.Descricao]));
end;

end.
