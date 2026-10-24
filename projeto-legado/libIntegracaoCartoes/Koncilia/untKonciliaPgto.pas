unit untKonciliaPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls,
     Dialogs, Forms, System.Math, Firedac.Comp.Client, System.JSON,
     Rest.Response.Adapter;

Type
  TRegistroPgto = Record
    strCodEst: String;
    strNumPed: String;
    strID_Kon: String;
    strNum_Oi: String;
    strStatus: String;
    strStaInt: String;
    strDtaTra: String;
    strDtaPag: String;
    strDtaInv: String;
    strDtaEnv: String;
    strID_Ped: String;
    strMarket: String;
    strTipPag: String;
    fltValBru: Double;
    fltValCom: Double;
    fltValFre: Double;
    strTipReg: String;
    fltPerCom: Double;
    fltValPar: Double;
    strNumPar: String;
    strTotPar: String;
    strSituac: String;
    strCodCon: String;
    strDtaFin: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroKonPgto  = Array Of TRegistroPgto;

  TArrEstruturaKonPgto  = Array Of TEstruturaPgto;

  TKonciliaPgto = Class(TInterfacedObject, ICartoes)
  Private
    intPosicaoAtual: Integer;

    cdsRegistros: TFDMemTable;
  Public
    strEmpresaAtual: String;

    constructor Create;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaKonPgto;
  End;

implementation
uses untFuncoes, untIDataSet;

{ TKonciliaPgto }

constructor TKonciliaPgto.Create;
Begin
  intPosicaoAtual := 0;
End;

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* KON_KOPGTO                                   *}
{*********************************************AJ*}
class function TKonciliaPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaKonPgto;
Begin
  If strTabela = 'KON_KOPGTO' Then
  Begin
    SetLength(Result, 27);

    Result[0].strDescri  := 'KON_CODEST'; Result[0].strTipCmp  := 'VARCHAR(30)'  ;
    Result[1].strDescri  := 'KON_NUMPED'; Result[1].strTipCmp  := 'VARCHAR(40)'  ;
    Result[2].strDescri  := 'KON_ID_KON'; Result[2].strTipCmp  := 'VARCHAR(30)'  ;
    Result[3].strDescri  := 'KON_NUM_OI'; Result[3].strTipCmp  := 'VARCHAR(15)'  ;
    Result[4].strDescri  := 'KON_STATUS'; Result[4].strTipCmp  := 'VARCHAR(20)'  ;
    Result[5].strDescri  := 'KON_STAINT'; Result[5].strTipCmp  := 'VARCHAR(20)'  ;
    Result[6].strDescri  := 'KON_DTATRA'; Result[6].strTipCmp  := 'DATE'         ;
    Result[7].strDescri  := 'KON_DTAPAG'; Result[7].strTipCmp  := 'DATE'         ;
    Result[8].strDescri  := 'KON_DTAINV'; Result[8].strTipCmp  := 'DATE'         ;
    Result[9].strDescri  := 'KON_DTAENV'; Result[9].strTipCmp  := 'DATE'         ;
    Result[10].strDescri := 'KON_ID_PED'; Result[10].strTipCmp := 'VARCHAR(20)'  ;
    Result[11].strDescri := 'KON_MARKET'; Result[11].strTipCmp := 'VARCHAR(40)'  ;
    Result[12].strDescri := 'KON_TIPPAG'; Result[12].strTipCmp := 'VARCHAR(30)'  ;
    Result[13].strDescri := 'KON_VALBRU'; Result[13].strTipCmp := 'DECIMAL(15,2)';
    Result[14].strDescri := 'KON_VALCOM'; Result[14].strTipCmp := 'DECIMAL(15,2)';
    Result[15].strDescri := 'KON_VALFRE'; Result[15].strTipCmp := 'DECIMAL(15,2)';
    Result[16].strDescri := 'KON_TIPREG'; Result[16].strTipCmp := 'VARCHAR(40)'  ;
    Result[17].strDescri := 'KON_PERCOM'; Result[17].strTipCmp := 'DECIMAL(15,2)';
    Result[18].strDescri := 'KON_VALPAR'; Result[18].strTipCmp := 'DECIMAL(15,2)';
    Result[19].strDescri := 'KON_NUMPAR'; Result[19].strTipCmp := 'VARCHAR(2)'   ;
    Result[20].strDescri := 'KON_TOTPAR'; Result[20].strTipCmp := 'VARCHAR(2)'   ;
    Result[21].strDescri := 'KON_SITUAC'; Result[21].strTipCmp := 'VARCHAR(30)'  ;
    Result[22].strDescri := 'KON_RESOLV'; Result[22].strTipCmp := 'INT DEFAULT 0';
    Result[23].strDescri := 'KON_DTAIMP'; Result[23].strTipCmp := 'DATE'         ;
    Result[24].strDescri := 'KON_CONCIL'; Result[24].strTipCmp := 'INT DEFAULT 0';
    Result[25].strDescri := 'KON_CODCON'; Result[25].strTipCmp := 'VARCHAR(15)'  ;
    Result[26].strDescri := 'KON_DTAFIN'; Result[26].strTipCmp := 'DATE'         ;
  End;
End;

class function TKonciliaPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaKonPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(KON_CODEST,KON_NUMPED,KON_ID_KON,KON_STATUS,KON_DTATRA,KON_DTAPAG,KON_MARKET,KON_TIPREG,KON_NUMPAR)) ENGINE INNODB ' ;
end;

procedure TKonciliaPgto.pAdicionaLinha(strString: String);
  Const
    AUMENTO_CAPACIDADE_FREG  = 2000;
  Var
    objJSON   : TJSONArray;
    objValue  : TJSONValue;
    objObject : TJSonObject;
    adpAdapter: TCustomJSONDataSetAdapter;

    strObservacao: String;
begin
  Try
    objObject  := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(strString), 0) As TJsonObject;
    objValue   := objObject.Get('content').JsonValue;
    objJSON    := objValue As TJSONArray;
    adpAdapter := TCustomJSONDataSetAdapter.Create(Application);

    cdsRegistros       := TFDMemTable.Create(Application);
    adpAdapter.Dataset := cdsRegistros;
    adpAdapter.UpdateDataSet(objJSON);
    cdsRegistros.Open;
    While Not cdsRegistros.Eof Do
    Begin
      Inc(intPosicaoAtual);

      If intPosicaoAtual >= Length(FRegKonPgto) - 1 Then
        SetLength(FRegKonPgto, Length(FRegKonPgto)+AUMENTO_CAPACIDADE_FREG);

      FRegKonPgto[intPosicaoAtual-1].strCodEst := strEmpresaAtual;
      FRegKonPgto[intPosicaoAtual-1].strNumPed := cdsRegistros.FieldByName('orderCode').AsString;
      FRegKonPgto[intPosicaoAtual-1].strID_Kon := cdsRegistros.FieldByName('id').AsString;
      FRegKonPgto[intPosicaoAtual-1].strNum_Oi := cdsRegistros.FieldByName('oi').AsString;
      FRegKonPgto[intPosicaoAtual-1].strStatus := cdsRegistros.FieldByName('channelStatus').AsString;
      FRegKonPgto[intPosicaoAtual-1].strStaInt := cdsRegistros.FieldByName('internalStatus').AsString;

      If cdsRegistros.FieldByName('orderDate').AsString.Trim <> '' Then
        FRegKonPgto[intPosicaoAtual-1].strDtaTra := cdsRegistros.FieldByName('orderDate').AsString
      Else
        FRegKonPgto[intPosicaoAtual-1].strDtaTra := LeftStr(cdsRegistros.FieldByName('releasedDate').AsString, 10);

      If (Not cdsRegistros.FieldByName('releasedDate').IsNull) And
         (cdsRegistros.FieldByName('releasedDate').AsString.Trim <> '') And
         (LeftStr(cdsRegistros.FieldByName('releasedDate').AsString, 10) <> '0000-00-00') Then
        FRegKonPgto[intPosicaoAtual-1].strDtaPag := LeftStr(cdsRegistros.FieldByName('releasedDate').AsString, 10)
      Else
        FRegKonPgto[intPosicaoAtual-1].strDtaPag := LeftStr(cdsRegistros.FieldByName('paidDate').AsString, 10);

      FRegKonPgto[intPosicaoAtual-1].strDtaInv := LeftStr(cdsRegistros.FieldByName('invoiceDate').AsString, 10);
      FRegKonPgto[intPosicaoAtual-1].strDtaEnv := LeftStr(cdsRegistros.FieldByName('sentDate').AsString, 10);
      FRegKonPgto[intPosicaoAtual-1].strID_Ped := cdsRegistros.FieldByName('orderId').AsString;
      FRegKonPgto[intPosicaoAtual-1].strMarket := cdsRegistros.FieldByName('origin').AsString;
      FRegKonPgto[intPosicaoAtual-1].strTipPag := cdsRegistros.FieldByName('paymentMethod').AsString;
      FRegKonPgto[intPosicaoAtual-1].strTipReg := cdsRegistros.FieldByName('extractType').AsString;
      FRegKonPgto[intPosicaoAtual-1].strNumPar := cdsRegistros.FieldByName('plotNumber').AsString;
      FRegKonPgto[intPosicaoAtual-1].strTotPar := cdsRegistros.FieldByName('plotsQuantity').AsString;
      FRegKonPgto[intPosicaoAtual-1].strSituac := cdsRegistros.FieldByName('situation').AsString;

      If Not cdsRegistros.FieldByName('releasedValue').IsNull Then
        FRegKonPgto[intPosicaoAtual-1].fltValBru := cdsRegistros.FieldByName('releasedValue').AsFloat
      Else
        FRegKonPgto[intPosicaoAtual-1].fltValBru := cdsRegistros.FieldByName('totalValue').AsFloat;

      FRegKonPgto[intPosicaoAtual-1].fltValPar := cdsRegistros.FieldByName('plotValue').AsFloat;

      If Pos(cdsRegistros.FieldByName('extractType').AsString, 'COMISSION_SHIP_PROMOTIONAL_FREIGHT_') > 0 Then
      Begin
        If Pos(cdsRegistros.FieldByName('extractType').AsString, 'SHIP_PROMOTIONAL_FREIGHT_') > 0 Then
        Begin
          FRegKonPgto[intPosicaoAtual-1].fltValFre := FRegKonPgto[intPosicaoAtual-1].fltValFre +
                                                      cdsRegistros.FieldByName('releasedValue').AsFloat;
          FRegKonPgto[intPosicaoAtual-1].strDtaEnv := cdsRegistros.FieldByName('sentDate').AsString;

          FRegKonPgto[intPosicaoAtual-1].fltValBru := FRegKonPgto[intPosicaoAtual-1].fltValFre;
          FRegKonPgto[intPosicaoAtual-1].fltValPar := FRegKonPgto[intPosicaoAtual-1].fltValFre;
        End
        Else
        Begin
          If Not cdsRegistros.FieldByName('releasedValue').IsNull Then
            FRegKonPgto[intPosicaoAtual-1].fltValCom := cdsRegistros.FieldByName('releasedValue').AsFloat
          Else
            FRegKonPgto[intPosicaoAtual-1].fltValCom := 0;

          FRegKonPgto[intPosicaoAtual-1].fltValBru := FRegKonPgto[intPosicaoAtual-1].fltValCom;
          FRegKonPgto[intPosicaoAtual-1].fltValPar := FRegKonPgto[intPosicaoAtual-1].fltValCom;
        End;
      End;

      //Pegando dados da conciliação do site
      strObservacao := Trim(cdsRegistros.FieldByName('observation').AsString);
      FRegKonPgto[intPosicaoAtual-1].strDtaFin := LeftStr(RightStr(strObservacao, 11), 10);

      strObservacao := LeftStr(strObservacao, Length(strObservacao) - 11);
      strObservacao := strObservacao.Replace('Este repasse foi resolvido na conciliacao ', EmptyStr);
      strObservacao := strObservacao.Replace('Este repasse foi resolvido na conciliação ', EmptyStr);
      strObservacao := strObservacao.Replace(' criada na data de ', EmptyStr);

      FRegKonPgto[intPosicaoAtual-1].strCodCon := strObservacao;
      //Este repasse foi resolvido na conciliação 5133 criada na data de 26/06/2019.

      cdsRegistros.Next;
    End;
  Except
    On E: Exception Do
      objFunctions.fIMensagem('', E.Message, ['&OK']);
  End;
end;

procedure TKonciliaPgto.pGravarRegistros(pgbProg: TProgressBar);
Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
    arrCampos: TArrEstruturaKonPgto;

begin
  //pagamentos
  strSQL :=    'REPLACE INTO KON_KOPGTO (';
  arrCampos := fRetEstruturaPgto('KON_KOPGTO');
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'KON_RESOLV') And
       (arrCampos[intCont].strDescri <> 'KON_CONCIL') Then
      strSQL := strSQL + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'KON_RESOLV') And
       (arrCampos[intCont].strDescri <> 'KON_CONCIL') Then
      strSQL := strSQL + ':' + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  If Length(FRegKonPgto) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegKonPgto);
    For intCont := 0 To Length(FRegKonPgto) - 1 Do
    Begin
      If (FRegKonPgto[intCont].strCodEst <> '')  Then
      Begin
        pgbProg.Parent.Update;

        With qryDados Do
        Begin
          Close;

          ParamByName('KON_CODEST').Value   := FRegKonPgto[intCont].strCodEst;
          ParamByName('KON_NUMPED').Value   := FRegKonPgto[intCont].strNumPed;
          ParamByName('KON_ID_KON').Value   := FRegKonPgto[intCont].strID_Kon;
          ParamByName('KON_NUM_OI').Value   := FRegKonPgto[intCont].strNum_Oi;
          ParamByName('KON_STATUS').Value   := FRegKonPgto[intCont].strStatus;
          ParamByName('KON_STAINT').Value   := FRegKonPgto[intCont].strStaInt;
          ParamByName('KON_DTATRA').Value   := FRegKonPgto[intCont].strDtaTra;
          ParamByName('KON_DTAPAG').Value   := FRegKonPgto[intCont].strDtaPag;
          ParamByName('KON_DTAINV').Value   := FRegKonPgto[intCont].strDtaInv;
          ParamByName('KON_DTAENV').Value   := FRegKonPgto[intCont].strDtaEnv;
          ParamByName('KON_ID_PED').Value   := FRegKonPgto[intCont].strID_Ped;
          ParamByName('KON_MARKET').Value   := FRegKonPgto[intCont].strMarket;
          ParamByName('KON_TIPPAG').Value   := FRegKonPgto[intCont].strTipPag;
          ParamByName('KON_VALBRU').Value   := FRegKonPgto[intCont].fltValBru;
          //If FRegKonPgto[intCont].fltValCom > 0 Then
            ParamByName('KON_VALCOM').Value   := FRegKonPgto[intCont].fltValCom;
          //Else
         //   ParamByName('KON_VALCOM').Value   := FRegKonPgto[intCont].fltValBru * (FRegKonPgto[intCont].fltPerCom / 100);
          ParamByName('KON_VALFRE').Value   := FRegKonPgto[intCont].fltValFre;
          ParamByName('KON_TIPREG').Value   := FRegKonPgto[intCont].strTipReg;
          ParamByName('KON_PERCOM').Value   := FRegKonPgto[intCont].fltPerCom;
          ParamByName('KON_VALPAR').Value   := FRegKonPgto[intCont].fltValPar;
          ParamByName('KON_NUMPAR').Value   := FRegKonPgto[intCont].strNumPar;
          ParamByName('KON_TOTPAR').Value   := FRegKonPgto[intCont].strTotPar;
          ParamByName('KON_SITUAC').Value   := FRegKonPgto[intCont].strSituac;
          ParamByName('KON_DTAIMP').Value   := Date();

          ParamByName('KON_CODCON').Value   := FRegKonPgto[intCont].strCodCon;

          Try
            ParamByName('KON_DTAFIN').Value   := Copy(FRegKonPgto[intCont].strDtaFin, 7, 4) + '/' +
                                                 Copy(FRegKonPgto[intCont].strDtaFin, 4, 2) + '/' +
                                                 Copy(FRegKonPgto[intCont].strDtaFin, 1, 2);
          Except
            ParamByName('KON_DTAFIN').Value := Null;
          End;

          ExecSQL;
        End;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    {Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "KONCILIA")';
      For intCont := 0 To lstEstabel.Count - 1 Do
      Begin
        qryDados.ParamByName('ESTAB').AsString := lstEstabel[intCont];
        qryDados.ExecSQL;
      End;

      FreeAndNil(lstEstabel);
    Except
      Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
    End;}

    pgbProg.Position := pgbProg.Max;
  End;
end;

end.
