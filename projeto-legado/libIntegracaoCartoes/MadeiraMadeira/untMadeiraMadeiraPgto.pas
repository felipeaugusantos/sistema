{***********************************************************}
{* Importação de arquivos com RESTClient da MadeiraMadeira *}
{***********************************************************}

{*******************************************}
{* NÃO ADICIONAR NO PROJETO DO DELPHI 2007 *}
{*******************************************}
unit untMadeiraMadeiraPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls,
     Dialogs, Forms,Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc,
     System.Math, Json;

Type
  TRegistroMMadeira = record
     strIDLancamento: String;
     strIDSeller: String;
     strIDPedido: String;
     strPedidoWD: String;
     strPedidoMM: String;
     strTipoLancamento: String;
     strDescricaoTipo: String;
     strData: String;
     strDescricao: String;
     strValor: String;
     strDataPrevisao: String;
     strDataPagamento: String;
     strDataLiberacao: String;
     strDetalhe: String;
     strStatus: String;
  End;

  TEstruturaMMadeira = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroMadeiraMadeira = Array Of TRegistroMMadeira;

  TArrEstruturaMadeiraMadeira = Array Of TEstruturaMMadeira;

  TMadeiraMadeiraPgto = Class(TInterfacedObject, ICartoes)
  Private

    FCodigoEmpresaAtual:String;

    FOffSet,
    FPosicaoPgto  : Integer;

    FImportouRegistro: Boolean;

    function fCorrigeDadosBanco(const AValor: Variant; const varTipVar: TVarType = varString): Variant;
    function fRetornaValorJson(const AObjeto: TJsonObject; const ANomeCampo: String): String;
  Public

    constructor Create;
    procedure pSetCodigoEmpresa(const strCodigoEmpresa:String);
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    property ImportouRegistro: Boolean read FImportouRegistro;

    class function fRetSQLTabelaRegPgto: String;
    class function fRetEstruturaPgto: TArrEstruturaMadeiraMadeira;

    function fGetOffset: Integer;
    procedure pSetOffset(const Value: Integer);
  End;

implementation

uses untFuncoes, untIDataSet;

Const
    AUMENTO_CAPACIDADE_FREG  = 1000;

{ TMadeiraMadeiraPgto }

constructor TMadeiraMadeiraPgto.Create;
Begin
  FPosicaoPgto  := 1;
  FImportouRegistro := False;
End;

class function TMadeiraMadeiraPgto.fRetEstruturaPgto: TArrEstruturaMadeiraMadeira;
Begin
    SetLength(Result, 17);
    Result[0].strDescri  := 'MAD_CODEMP';  Result[0].strTipCmp  := 'VARCHAR(3)'   ;
    Result[1].strDescri  := 'MAD_CODIGO';  Result[1].strTipCmp  := 'VARCHAR(10)'  ;
    Result[2].strDescri  := 'MAD_CODSEL';  Result[2].strTipCmp  := 'VARCHAR(6)'   ;
    Result[3].strDescri  := 'MAD_PEDIDO';  Result[3].strTipCmp  := 'VARCHAR(10)'  ;
    Result[4].strDescri  := 'MAD_CODPWD';  Result[4].strTipCmp  := 'VARCHAR(10)'  ;
    Result[5].strDescri  := 'MAD_CODPMM';  Result[5].strTipCmp  := 'VARCHAR(10)'  ;
    Result[6].strDescri  := 'MAD_TIPLAN';  Result[6].strTipCmp  := 'VARCHAR(2)'   ;
    Result[7].strDescri  := 'MAD_DESLAN';  Result[7].strTipCmp  := 'VARCHAR(30)'  ;
    Result[8].strDescri  := 'MAD_DTALAN';  Result[8].strTipCmp  := 'DATE'         ;
    Result[9].strDescri  := 'MAD_DESCRI';  Result[9].strTipCmp  := 'VARCHAR(30)'  ;
    Result[10].strDescri := 'MAD_VALORI';  Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := 'MAD_DTAPRE';  Result[11].strTipCmp := 'DATE'         ;
    Result[12].strDescri := 'MAD_DTAPAG';  Result[12].strTipCmp := 'DATE'         ;
    Result[13].strDescri := 'MAD_DTALIB';  Result[13].strTipCmp := 'DATE'         ;
    Result[14].strDescri := 'MAD_STATUS';  Result[14].strTipCmp := 'VARCHAR(20)'  ;
    Result[15].strDescri := 'MAD_DETLAN';  Result[15].strTipCmp := 'TEXT'         ;
    Result[16].strDescri := 'MAD_CONCIL';  Result[16].strTipCmp := 'VARCHAR(1) DEFAULT ''0''';
End;

class function TMadeiraMadeiraPgto.fRetSQLTabelaRegPgto: String;
Var arrCampos: TArrEstruturaMadeiraMadeira;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE MAD_APPGTO(';
  arrCampos := fRetEstruturaPgto;

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + 'PRIMARY KEY(MAD_CODIGO)) ENGINE INNODB ' ;
end;

procedure TMadeiraMadeiraPgto.pAdicionaLinha(strString: String);
Var
    jsonRetorno : TJsonObject;
    jsonObjectValue: TJsonObject;
    jsonObjectValueTotal: TJsonObject;
    jsonArrayContent: TJSONArray;
    jsonValueContent: TJsonValue;
    strTotal: String;
begin
  If strString.Trim.IsEmpty Then
    Exit;
  Try
    jsonRetorno := TJSONObject.ParseJSONValue(strString) as TJSONObject;
    jsonArrayContent := jsonRetorno.GetValue('data') as TJsonArray;
    jsonObjectValueTotal := jsonRetorno.GetValue('meta') as TJSONObject;
    strTotal := fRetornaValorJson(jsonObjectValueTotal,'count');
    If SameStr(strTotal, '100') then
      Inc(FOffSet, 100);

    For jsonValueContent In jsonArrayContent Do
    Begin
      jsonObjectValue := TJSONObject.ParseJSONValue(jsonValueContent.ToString) as TJSONObject;
      If FPosicaoPgto >= Length(FRegMadeiraMadeiraPgto) - 1 Then
        SetLength(FRegMadeiraMadeiraPgto, Length(FRegMadeiraMadeiraPgto)+AUMENTO_CAPACIDADE_FREG);
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strIDLancamento :=   fRetornaValorJson(jsonObjectValue,'id_lancamento_financeiro');
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strIDSeller :=       fRetornaValorJson(jsonObjectValue,'id_seller');
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strIDPedido :=       fRetornaValorJson(jsonObjectValue,'id_pedido');
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strPedidoWD :=       fRetornaValorJson(jsonObjectValue,'pedido_wd');
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strPedidoMM :=       fRetornaValorJson(jsonObjectValue,'pedido_mm');
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strTipoLancamento := fRetornaValorJson(jsonObjectValue,'id_tipo_lancamento');
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strDescricaoTipo :=  fRetornaValorJson(jsonObjectValue,'tipo_lancamento');
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strData :=           fRetornaValorJson(jsonObjectValue,'data');
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strDescricao :=      fRetornaValorJson(jsonObjectValue,'descricao');
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strValor :=          fRetornaValorJson(jsonObjectValue,'valor');
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strDataPrevisao :=   fRetornaValorJson(jsonObjectValue,'data_previsao_pagamento');
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strDataPagamento :=  fRetornaValorJson(jsonObjectValue,'data_pagamento');
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strDataLiberacao :=  fRetornaValorJson(jsonObjectValue,'data_liberacao');
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strDetalhe :=        fRetornaValorJson(jsonObjectValue,'detalhamento');
      FRegMadeiraMadeiraPgto[FPosicaoPgto-1].strStatus :=         fRetornaValorJson(jsonObjectValue,'status');
      Inc(FPosicaoPgto);
      FreeAndNil(jsonObjectValue);
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;

procedure TMadeiraMadeiraPgto.pSetCodigoEmpresa(const strCodigoEmpresa: String);
begin
  FCodigoEmpresaAtual := strCodigoEmpresa;
end;

procedure TMadeiraMadeiraPgto.pSetOffset(const Value: Integer);
begin
   FOffSet := Value;
end;

procedure TMadeiraMadeiraPgto.pGravarRegistros(pgbProg: TProgressBar);
Var
  qryDados : IDataSet;
  intCont  : Integer;
  strSQL   : String;
  arrCampos: TArrEstruturaMadeiraMadeira;
begin
  strSQL :=    'REPLACE INTO MAD_APPGTO (';
  arrCampos := fRetEstruturaPgto;
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'MAD_CONCIL') Then
      strSQL := strSQL + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'MAD_CONCIL') Then
      strSQL := strSQL + ':' + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  If Length(FRegMadeiraMadeiraPgto) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegMadeiraMadeiraPgto);
    For intCont := 0 To Length(FRegMadeiraMadeiraPgto) - 1 Do
    Begin
      If FRegMadeiraMadeiraPgto[intCont].strIDLancamento <> '' Then
      Begin
        Application.ProcessMessages;
        FImportouRegistro := True;
        qryDados.Close;
        qryDados.ParamByName('MAD_CODEMP').Value := FCodigoEmpresaAtual;
        qryDados.ParamByName('MAD_CODIGO').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strIDLancamento);
        qryDados.ParamByName('MAD_CODSEL').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strIDSeller);
        qryDados.ParamByName('MAD_PEDIDO').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strIDPedido);
        qryDados.ParamByName('MAD_CODPWD').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strPedidoWD);
        qryDados.ParamByName('MAD_CODPMM').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strPedidoMM);
        qryDados.ParamByName('MAD_TIPLAN').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strTipoLancamento);
        qryDados.ParamByName('MAD_DESLAN').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strDescricaoTipo);
        qryDados.ParamByName('MAD_DTALAN').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strData, varDate);
        qryDados.ParamByName('MAD_DESCRI').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strDescricao);
        qryDados.ParamByName('MAD_VALORI').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strValor, varDouble);
        qryDados.ParamByName('MAD_DTAPRE').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strDataPrevisao, varDate);
        qryDados.ParamByName('MAD_DTAPAG').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strDataPagamento, varDate);
        qryDados.ParamByName('MAD_DTALIB').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strDataLiberacao, varDate);
        qryDados.ParamByName('MAD_STATUS').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strStatus);
        qryDados.ParamByName('MAD_DETLAN').Value := fCorrigeDadosBanco(FRegMadeiraMadeiraPgto[intCont].strDetalhe);

        qryDados.ExecSQL;
      End;
      pgbProg.Position := pgbProg.Position + 1;
    End;

    Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "MADEIRAMADEIRA")';
      qryDados.ParamByName('ESTAB').AsString := FCodigoEmpresaAtual;
      qryDados.ExecSQL;
    Except
      Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
    End;
    pgbProg.Position := pgbProg.Max;
  End;

end;

function TMadeiraMadeiraPgto.fRetornaValorJson(const AObjeto: TJsonObject; const ANomeCampo: String): String;
begin
  Try
    Result := '';
    If Assigned(AObjeto.GetValue(ANomeCampo)) Then
      Result := AObjeto.GetValue<string>(ANomeCampo);
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TMadeiraMadeiraPgto.fCorrigeDadosBanco(const AValor: Variant; const varTipVar: TVarType = varString): Variant;
begin
  Result := Null;
  Case varTipVar Of
    varString : Result := AValor;

    varInteger, varSmallint, varSingle, varByte, varShortInt, varInt64:
                Begin
                  Try
                    If Not fEmptyStr(AValor) Then
                      Result := strToInt(AValor)
                    Else
                      Result := 0;
                  Except
                    Result := Null;
                  End;
                End;

    varDouble, varCurrency:
                Begin
                  Try
                    If Not fEmptyStr(AValor) Then
                      Result := StrToFloat(AnsiReplaceStr(AValor, '.', ','))
                    Else
                      Result := 0.00;
                  Except
                    Result := Null;
                  End;
                End;

      varDate:
                Begin
                  Try
                    If Not fEmptyStr(AValor) Then
                      Result := LeftStr(AValor,10)
                    Else
                      Result := Null;
                  Except
                    Result := Null;
                  End;
                End;
  End;
end;

function TMadeiraMadeiraPgto.fGetOffset: Integer;
begin
   Result := FOffSet;
end;

end.
