{**************************************************}
{* Importação de arquivos com RESTClient da STONE *}
{***********************************************AJ*}

{*******************************************}
{* NÃO ADICIONAR NO PROJETO DO DELPHI 2007 *}
{****************************************AJ*}
unit untStonePgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls,
     Dialogs, Forms,Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc,
     System.Math;

Type
  TRegistroPgto = Record
    strCodEst: String;
    strNumNsu: String;
    strIniKey: String;
    strDtaAut: String;
    strDtaVen: String;
    strNumTer: String;
    strTipPon: String;
    strNumPar: String;
    fltValBru: Double;
    fltValLiq: Double;
    strDtaPag: String;
    fltValAnt: Double;
    strDtaOri: String;
    strPag_ID: String;
    strNumCan: String;
    fltValDeb: Double;
    fltValCan: Double;
  End;

  TRegistroCred = Record
    strCodEst: String;
    strNumNsu: String;
    strIniKey: String;
    strDtaAut: String;
    strDtaVen: String;
    strTipCar: String;
    strNumPar: String;
    strTotPar: String;
    fltBruVen: Double;
    strCodAut: String;
    fltValBru: Double;
    fltValLiq: Double;
    strDtaPre: String;
    strNumCar: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TEstruturaCred = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroStoPgto  = Array Of TRegistroPgto;
  TArrRegistroStoCred  = Array Of TRegistroCred;

  TArrEstruturaStoPgto  = Array Of TEstruturaPgto;
  TArrEstruturaStoCred  = Array Of TEstruturaCred;

  TStonePgto = Class(TInterfacedObject, ICartoes)
  Private
    strCodEst,
    strDtaArq: String;

    intPosicaoAtual,
    intPosicaoPgto  : Integer;

    FImportouRegistro,
    FImportouPagamento: Boolean;
    function RetornaTipoCartao(ACodigo: String): String;
  Public

    constructor Create;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    property ImportouRegistro: Boolean read FImportouRegistro;
    property ImportouPagamento: Boolean read FImportouPagamento;

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaStoPgto;
    class function fRetSQLTabelaRegCred(strTabela: String): String;
    class function fRetEstruturaCred(strTabela: String): TArrEstruturaStoCred;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TStonePgto }

constructor TStonePgto.Create;
Begin
  intPosicaoAtual := 1;
  intPosicaoPgto  := 1;

  FImportouRegistro := False;
  FImportouPagamento := False;
End;

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* STO_STPGTO                                   *}
{*********************************************AJ*}
class function TStonePgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaStoPgto;
Begin
  If strTabela = 'STO_STPGTO' Then
  Begin
    SetLength(Result, 21);

    Result[0].strDescri  := 'STO_CODEST'; Result[0].strTipCmp  := 'VARCHAR(9)'   ;
    Result[1].strDescri  := 'STO_NUMNSU'; Result[1].strTipCmp  := 'VARCHAR(14)'  ;
    Result[2].strDescri  := 'STO_INIKEY'; Result[2].strTipCmp  := 'VARCHAR(128)' ;
    Result[3].strDescri  := 'STO_DTAAUT'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := 'STO_DTAVEN'; Result[4].strTipCmp  := 'DATE'         ;
    Result[5].strDescri  := 'STO_NUMTER'; Result[5].strTipCmp  := 'VARCHAR(32)'  ;
    Result[6].strDescri  := 'STO_TIPPON'; Result[6].strTipCmp  := 'VARCHAR(15)'  ;
    Result[7].strDescri  := 'STO_NUMPAR'; Result[7].strTipCmp  := 'VARCHAR(4)'   ;
    Result[8].strDescri  := 'STO_VALBRU'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := 'STO_VALLIQ'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := 'STO_DTAPAG'; Result[10].strTipCmp := 'DATE'         ;
    Result[11].strDescri := 'STO_VALANT'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := 'STO_DTAORI'; Result[12].strTipCmp := 'DATE'         ;
    Result[13].strDescri := 'STO_PAG_ID'; Result[13].strTipCmp := 'VARCHAR(9)'   ;
    Result[14].strDescri := 'STO_NUMCAN'; Result[14].strTipCmp := 'VARCHAR(32)'  ;
    Result[15].strDescri := 'STO_DTACAN'; Result[15].strTipCmp := 'DATE'         ;
    Result[16].strDescri := 'STO_VALDEB'; Result[16].strTipCmp := 'DECIMAL(15,2)';
    Result[17].strDescri := 'STO_DTAIMP'; Result[17].strTipCmp := 'DATE'         ;
    Result[18].strDescri := 'STO_DTAARQ'; Result[18].strTipCmp := 'DATE'         ;
    Result[19].strDescri := 'STO_CONCIL'; Result[19].strTipCmp := 'VARCHAR(1) DEFAULT ''0''';
    Result[20].strDescri := 'STO_VALCAN'; Result[20].strTipCmp := 'DECIMAL(15,2)';
  End;
End;

class function TStonePgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaStoPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + 'PRIMARY KEY(STO_CODEST,STO_NUMNSU,STO_DTAVEN,STO_NUMPAR,STO_DTAPAG,STO_NUMCAN)) ENGINE INNODB             ' ;
end;

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE VENDA     *}
{* STO_STCRED                                   *}
{*********************************************AJ*}
class function TStonePgto.fRetEstruturaCred(strTabela: String): TArrEstruturaStoCred;
Begin
  If strTabela = 'STO_STCRED' Then Begin
    SetLength(Result, 16);

    Result[0].strDescri  := 'STO_CODEST'; Result[0].strTipCmp  := 'VARCHAR(9)'   ;
    Result[1].strDescri  := 'STO_NUMNSU'; Result[1].strTipCmp  := 'VARCHAR(14)'  ;
    Result[2].strDescri  := 'STO_INIKEY'; Result[2].strTipCmp  := 'VARCHAR(128)' ;
    Result[3].strDescri  := 'STO_DTAAUT'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := 'STO_DTAVEN'; Result[4].strTipCmp  := 'DATE'         ;
    Result[5].strDescri  := 'STO_TIPCAR'; Result[5].strTipCmp  := 'VARCHAR(1)'   ;
    Result[6].strDescri  := 'STO_TOTPAR'; Result[6].strTipCmp  := 'VARCHAR(4)'   ;
    Result[7].strDescri  := 'STO_NUMPAR'; Result[7].strTipCmp  := 'VARCHAR(4)'   ;
    Result[8].strDescri  := 'STO_BRUVEN'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := 'STO_CODAUT'; Result[9].strTipCmp  := 'VARCHAR(6)'   ;
    Result[10].strDescri := 'STO_VALBRU'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := 'STO_VALLIQ'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := 'STO_DTAPRE'; Result[12].strTipCmp := 'DATE'         ;
    Result[13].strDescri := 'STO_DTAARQ'; Result[13].strTipCmp := 'DATE'         ;
    Result[14].strDescri := 'STO_DTAIMP'; Result[14].strTipCmp := 'DATE'         ;
    Result[15].strDescri := 'STO_NUMCAR'; Result[15].strTipCmp  := 'VARCHAR(19)' ;
  End;
End;

class function TStonePgto.fRetSQLTabelaRegCred(strTabela: String): String;
Var arrCampos: TArrEstruturaStoCred;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaCred(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + 'PRIMARY KEY(STO_CODEST,STO_NUMNSU,STO_DTAVEN,STO_NUMPAR)) ENGINE INNODB             ' ;
end;

procedure TStonePgto.pAdicionaLinha(strString: String);
  Const
    AUMENTO_CAPACIDADE_FREG  = 2000;
  Var
    docXML    : IXMLDocument;
    nodElemen,
    nodFilho,
    nodValor,
    nodTrans,
    nodParcel : IXMLNode;
    intCont,
    intCont2  : Integer;
    strParcel : String;

    LImportouParcela: Boolean;

  function fGetDados(objValor: IXMLNode; blnFlt: Boolean = False;
                     blnDta: Boolean = False): Variant;
    Var
      rst: Variant;
  Begin
    if (blnFlt) then
      Result := 0
    Else
      Result := '';

    if objValor <> Nil then
    Begin
      rst := Trim(objValor.NodeValue);
      If blnFlt Then
        rst := RoundTo(fStrToFloat(rst), -2) / 1000000
      Else If blnDta Then
        rst := Copy(rst, 1,4) + '/' +
               Copy(rst, 5,2) + '/' +
               Copy(rst, 7,2);

      Result := rst;
    End;
  End;

begin
  docXML := TXMLDocument.Create(Application);
  docXML.LoadFromXML(strString);
  intPosicaoAtual := 1;
  intPosicaoPgto  := 1;

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  //Pegando os dados do header
  nodElemen := docXML.ChildNodes.FindNode('Conciliation');
  if (nodElemen <> nil) then
  begin
    nodFilho  := nodElemen.ChildNodes.FindNode('Header');
    nodValor  := nodFilho.ChildNodes.FindNode('StoneCode');
    strCodEst := fGetDados(nodValor);
    nodValor  := nodFilho.ChildNodes.FindNode('ReferenceDate');
    strDtaArq := fGetDados(nodValor, False, True);

    If (strCodEst <> '') And
       (lstEstabel.IndexOf(strCodEst) < 0) Then
      lstEstabel.Add(strCodEst);

    //Pegando as Vendas
    nodFilho := nodElemen.ChildNodes.FindNode('FinancialTransactions');
    If (nodFilho <> nil) Then
    Begin
      For intCont := 0 To nodFilho.ChildNodes.Count - 1 Do
      Begin
        nodTrans := nodFilho.ChildNodes.Get(intCont);
        If (nodTrans <> Nil) Then
        Begin
          //Cadastrando as Vendas do Dia
          If intPosicaoAtual >= Length(FRegStoneCred) - 1 Then
            SetLength(FRegStoneCred, Length(FRegStoneCred)+AUMENTO_CAPACIDADE_FREG);

          FRegStoneCred[intPosicaoAtual-1].strCodEst := strCodEst;
          nodValor := nodTrans.ChildNodes.FindNode('AcquirerTransactionKey');
          FRegStoneCred[intPosicaoAtual-1].strNumNSU := fGetDados(nodValor);
          nodValor := nodTrans.ChildNodes.FindNode('InitiatorTransactionKey');
          FRegStoneCred[intPosicaoAtual-1].strIniKey := fGetDados(nodValor);
          nodValor := nodTrans.ChildNodes.FindNode('AuthorizationDateTime');
          FRegStoneCred[intPosicaoAtual-1].strDtaAut := fGetDados(nodValor, False, True);
          nodValor := nodTrans.ChildNodes.FindNode('CaptureLocalDateTime');
          FRegStoneCred[intPosicaoAtual-1].strDtaVen := fGetDados(nodValor, False, True);
          nodValor := nodTrans.ChildNodes.FindNode('AccountType');
          FRegStoneCred[intPosicaoAtual-1].strTipCar := RetornaTipoCartao(fGetDados(nodValor));
          nodValor := nodTrans.ChildNodes.FindNode('NumberOfInstallments');
          FRegStoneCred[intPosicaoAtual-1].strTotPar := fGetDados(nodValor);
          nodValor := nodTrans.ChildNodes.FindNode('IssuerAuthorizationCode');
          FRegStoneCred[intPosicaoAtual-1].strCodAut := fGetDados(nodValor);
          nodValor := nodTrans.ChildNodes.FindNode('AuthorizedAmount');
          FRegStoneCred[intPosicaoAtual-1].fltBruVen := fGetDados(nodValor, True, False);
          nodValor := nodTrans.ChildNodes.FindNode('CardNumber');
          FRegStoneCred[intPosicaoAtual-1].strNumCar := fGetDados(nodValor);

          nodValor := nodTrans.ChildNodes.FindNode('Installments');
          If (nodValor <> Nil) Then
          Begin
            For intCont2 := 0 To nodValor.ChildNodes.Count - 1 Do
            Begin
              nodParcel := nodValor.ChildNodes.Get(intCont2);
              If intCont2 > 0 Then
              Begin
                If intPosicaoAtual >= Length(FRegStoneCred) - 1 Then
                  SetLength(FRegStoneCred, Length(FRegStoneCred)+AUMENTO_CAPACIDADE_FREG);

                FRegStoneCred[intPosicaoAtual-1].strCodEst := FRegStoneCred[intPosicaoAtual-2].strCodEst;
                FRegStoneCred[intPosicaoAtual-1].strNumNSU := FRegStoneCred[intPosicaoAtual-2].strNumNSU;
                FRegStoneCred[intPosicaoAtual-1].strIniKey := FRegStoneCred[intPosicaoAtual-2].strIniKey;
                FRegStoneCred[intPosicaoAtual-1].strDtaAut := FRegStoneCred[intPosicaoAtual-2].strDtaAut;
                FRegStoneCred[intPosicaoAtual-1].strDtaVen := FRegStoneCred[intPosicaoAtual-2].strDtaVen;
                FRegStoneCred[intPosicaoAtual-1].strTipCar := FRegStoneCred[intPosicaoAtual-2].strTipCar;
                FRegStoneCred[intPosicaoAtual-1].strTotPar := FRegStoneCred[intPosicaoAtual-2].strTotPar;
                FRegStoneCred[intPosicaoAtual-1].strCodAut := FRegStoneCred[intPosicaoAtual-2].strCodAut;
                FRegStoneCred[intPosicaoAtual-1].fltBruVen := FRegStoneCred[intPosicaoAtual-2].fltBruVen;
                FRegStoneCred[intPosicaoAtual-1].strNumCar := FRegStoneCred[intPosicaoAtual-2].strNumCar;
              End;
              FRegStoneCred[intPosicaoAtual-1].strNumPar := fGetDados(nodParcel.ChildNodes.FindNode('InstallmentNumber'));
              FRegStoneCred[intPosicaoAtual-1].fltValBru := fGetDados(nodParcel.ChildNodes.FindNode('GrossAmount'), True, False);
              FRegStoneCred[intPosicaoAtual-1].fltValLiq := fGetDados(nodParcel.ChildNodes.FindNode('NetAmount'), True, False);
              FRegStoneCred[intPosicaoAtual-1].strDtaPre := fGetDados(nodParcel.ChildNodes.FindNode('PrevisionPaymentDate'), False, True);

              Inc(intPosicaoAtual);
              Application.ProcessMessages;
            End;
          End;

        End;
      End;

    End;

    //Pegando os Pagamentos
    nodFilho := nodElemen.ChildNodes.FindNode('FinancialTransactionsAccounts');
    If (nodFilho <> nil) Then
    Begin
      For intCont := 0 To nodFilho.ChildNodes.Count - 1 Do
      Begin
        nodTrans := nodFilho.ChildNodes.Get(intCont);
        If (nodTrans <> Nil) Then
        Begin
          strParcel := '1';
          LImportouParcela := False;

          //Cadastrando as Vendas do Dia
          If intPosicaoPgto >= Length(FRegStonePgto) - 1 Then
            SetLength(FRegStonePgto, Length(FRegStonePgto)+AUMENTO_CAPACIDADE_FREG);

          FRegStonePgto[intPosicaoPgto-1].strCodEst := strCodEst;
          nodValor := nodTrans.ChildNodes.FindNode('AcquirerTransactionKey');
          FRegStonePgto[intPosicaoPgto-1].strNumNSU := fGetDados(nodValor);
          nodValor := nodTrans.ChildNodes.FindNode('InitiatorTransactionKey');
          FRegStonePgto[intPosicaoPgto-1].strIniKey := fGetDados(nodValor);
          nodValor := nodTrans.ChildNodes.FindNode('AuthorizationDateTime');
          FRegStonePgto[intPosicaoPgto-1].strDtaAut := fGetDados(nodValor, False, True);
          nodValor := nodTrans.ChildNodes.FindNode('CaptureLocalDateTime');
          FRegStonePgto[intPosicaoPgto-1].strDtaVen := fGetDados(nodValor, False, True);
          nodValor := nodTrans.ChildNodes.FindNode('Poi');
          FRegStonePgto[intPosicaoPgto-1].strNumTer := fGetDados(nodValor.ChildNodes.FindNode('SerialNumber'));
          FRegStonePgto[intPosicaoPgto-1].strTipPon := fGetDados(nodValor.ChildNodes.FindNode('PoiType'));
          If FRegStonePgto[intPosicaoPgto-1].strTipPon = '1' Then
            FRegStonePgto[intPosicaoPgto-1].strTipPon := 'POS'
          Else If FRegStonePgto[intPosicaoPgto-1].strTipPon = '2' Then
            FRegStonePgto[intPosicaoPgto-1].strTipPon := 'MICRO POS'
          Else If FRegStonePgto[intPosicaoPgto-1].strTipPon = '3' Then
            FRegStonePgto[intPosicaoPgto-1].strTipPon := 'TEF'
          Else
            FRegStonePgto[intPosicaoPgto-1].strTipPon := 'ECOMMERCE';
          FRegStonePgto[intPosicaoPgto-1].strNumCan := '';
          FRegStonePgto[intPosicaoPgto-1].fltValAnt := 0.00;
          FRegStonePgto[intPosicaoPgto-1].fltValDeb := 0.00;
          FRegStonePgto[intPosicaoPgto-1].fltValCan := 0.00;

          nodValor := nodTrans.ChildNodes.FindNode('Installments');
          If nodValor <> Nil Then
          Begin
            For intCont2 := 0 To nodValor.ChildNodes.Count - 1 Do
            Begin
              LImportouParcela := True;

              nodParcel := nodValor.ChildNodes.Get(intCont2);
              If intCont2 > 0 Then
              Begin
                If intPosicaoAtual >= Length(FRegStonePgto) - 1 Then
                  SetLength(FRegStonePgto, Length(FRegStonePgto)+AUMENTO_CAPACIDADE_FREG);

                FRegStonePgto[intPosicaoPgto-1].strCodEst := FRegStonePgto[intPosicaoPgto-2].strCodEst;
                FRegStonePgto[intPosicaoPgto-1].strNumNSU := FRegStonePgto[intPosicaoPgto-2].strNumNSU;
                FRegStonePgto[intPosicaoPgto-1].strIniKey := FRegStonePgto[intPosicaoPgto-2].strIniKey;
                FRegStonePgto[intPosicaoPgto-1].strDtaAut := FRegStonePgto[intPosicaoPgto-2].strDtaAut;
                FRegStonePgto[intPosicaoPgto-1].strDtaVen := FRegStonePgto[intPosicaoPgto-2].strDtaVen;
                FRegStonePgto[intPosicaoPgto-1].strNumTer := FRegStonePgto[intPosicaoPgto-2].strNumTer;
                FRegStonePgto[intPosicaoPgto-1].strTipPon := FRegStonePgto[intPosicaoPgto-2].strTipPon;
                FRegStonePgto[intPosicaoPgto-1].strNumCan := FRegStonePgto[intPosicaoPgto-2].strNumCan;
              End;
              FRegStonePgto[intPosicaoPgto-1].strNumPar := fGetDados(nodParcel.ChildNodes.FindNode('InstallmentNumber'));
              FRegStonePgto[intPosicaoPgto-1].fltValBru := fGetDados(nodParcel.ChildNodes.FindNode('GrossAmount'), True, False);
              FRegStonePgto[intPosicaoPgto-1].fltValLiq := fGetDados(nodParcel.ChildNodes.FindNode('NetAmount'), True, False);
              FRegStonePgto[intPosicaoPgto-1].strDtaPag := fGetDados(nodParcel.ChildNodes.FindNode('PaymentDate'), False, True);
              FRegStonePgto[intPosicaoPgto-1].strPag_ID := fGetDados(nodParcel.ChildNodes.FindNode('PaymentId'));
              If nodParcel.ChildNodes.FindNode('AdvanceRateAmount') <> Nil Then
              Begin
                FRegStonePgto[intPosicaoPgto-1].fltValAnt := fGetDados(nodParcel.ChildNodes.FindNode('AdvanceRateAmount'), True, False);
                FRegStonePgto[intPosicaoPgto-1].strDtaOri := fGetDados(nodParcel.ChildNodes.FindNode('AdvancedReceivableOriginalPaymentDate'), False, True);
              End;

              strParcel := fGetDados(nodParcel.ChildNodes.FindNode('InstallmentNumber'));

              Inc(intPosicaoPgto);
              Application.ProcessMessages;
            End;
          End;

          //Cancelamentos
          nodValor := nodTrans.ChildNodes.FindNode('Cancellations');
          If (nodValor <> Nil) Then
          Begin
            For intCont2 := 0 To nodValor.ChildNodes.Count - 1 Do
            Begin
              nodParcel := nodValor.ChildNodes.Get(intCont2);
              If (intCont2 > 0) Or (LImportouParcela) Then
              Begin
                If intPosicaoPgto >= Length(FRegStonePgto) - 1 Then
                  SetLength(FRegStonePgto, Length(FRegStonePgto)+AUMENTO_CAPACIDADE_FREG);

                FRegStonePgto[intPosicaoPgto-1].strCodEst := FRegStonePgto[intPosicaoPgto-2].strCodEst;
                FRegStonePgto[intPosicaoPgto-1].strNumNSU := FRegStonePgto[intPosicaoPgto-2].strNumNSU;
                FRegStonePgto[intPosicaoPgto-1].strIniKey := FRegStonePgto[intPosicaoPgto-2].strIniKey;
                FRegStonePgto[intPosicaoPgto-1].strDtaAut := FRegStonePgto[intPosicaoPgto-2].strDtaAut;
                FRegStonePgto[intPosicaoPgto-1].strDtaVen := FRegStonePgto[intPosicaoPgto-2].strDtaVen;
                FRegStonePgto[intPosicaoPgto-1].strNumTer := FRegStonePgto[intPosicaoPgto-2].strNumTer;
                FRegStonePgto[intPosicaoPgto-1].strTipPon := FRegStonePgto[intPosicaoPgto-2].strTipPon;
              End;
              FRegStonePgto[intPosicaoPgto-1].strNumCan := fGetDados(nodParcel.ChildNodes.FindNode('OperationKey'));
              FRegStonePgto[intPosicaoPgto-1].strNumPar := strParcel;
              FRegStonePgto[intPosicaoPgto-1].strDtaPag := fGetDados(nodParcel.ChildNodes.FindNode('CancellationDateTime'), False, True);
              FRegStonePgto[intPosicaoPgto-1].fltValDeb := fGetDados(nodParcel.ChildNodes.FindNode('ReturnedAmount'), True, False);
              If nodParcel.ChildNodes.FindNode('AdvanceRateAmount') <> Nil Then
              Begin
                FRegStonePgto[intPosicaoPgto-1].fltValAnt := fGetDados(nodParcel.ChildNodes.FindNode('AdvanceRateAmount').ChildNodes.FindNode('AdvanceRateAmount'), True, False);
                FRegStonePgto[intPosicaoPgto-1].strDtaOri := fGetDados(nodParcel.ChildNodes.FindNode('AdvanceRateAmount').ChildNodes.FindNode('AdvancedReceivableOriginalPaymentDate'), False, True);
              End;
              If nodParcel.ChildNodes.FindNode('Billing') <> Nil Then
              Begin
                FRegStonePgto[intPosicaoPgto-1].fltValCan := fGetDados(nodParcel.ChildNodes.FindNode('Billing').ChildNodes.FindNode('ChargedAmount'), True, False);
                FRegStonePgto[intPosicaoPgto-1].strDtaPag := fGetDados(nodParcel.ChildNodes.FindNode('Billing').ChildNodes.FindNode('ChargeDate'), False, True);
              End;


              If (FRegStonePgto[intPosicaoPgto-1].strNumPar = '') Then
              Begin
                FRegStonePgto[intPosicaoPgto-1].strNumPar := '1';
                FRegStonePgto[intPosicaoPgto-1].fltValBru := FRegStonePgto[intPosicaoPgto-1].fltValCan;
                FRegStonePgto[intPosicaoPgto-1].fltValLiq := FRegStonePgto[intPosicaoPgto-1].fltValCan;
              End;

              Inc(intPosicaoPgto);
              Application.ProcessMessages;
            End;
          End;

        End;
      End;
    End;

    //Pegando as transferências
    nodFilho := nodElemen.ChildNodes.FindNode('Payments');
    If (nodFilho <> nil) Then
    Begin
      For intCont := 0 To nodFilho.ChildNodes.Count - 1 Do
      Begin
        nodValor := nodFilho.ChildNodes.Get(intCont);
        If (nodValor <> Nil) Then
        Begin
          If intPosicaoPgto >= Length(FRegStonePgto) - 1 Then
            SetLength(FRegStonePgto, Length(FRegStonePgto)+AUMENTO_CAPACIDADE_FREG);

          FRegStonePgto[intPosicaoPgto-1].strCodEst := strCodEst;
          FRegStonePgto[intPosicaoPgto-1].strNumNSU := fGetDados(nodValor.ChildNodes.FindNode('Id'));
          FRegStonePgto[intPosicaoPgto-1].strIniKey := fGetDados(nodValor.ChildNodes.FindNode('Id'));
          FRegStonePgto[intPosicaoPgto-1].strDtaAut := strDtaArq;
          FRegStonePgto[intPosicaoPgto-1].strDtaVen := strDtaArq;
          FRegStonePgto[intPosicaoPgto-1].strDtaPag := strDtaArq;
          FRegStonePgto[intPosicaoPgto-1].strNumTer := '';
          FRegStonePgto[intPosicaoPgto-1].strTipPon := 'TRF';

          FRegStonePgto[intPosicaoPgto-1].strNumCan := 'TRANSFERENCIA';
          FRegStonePgto[intPosicaoPgto-1].strNumPar := '1';
          FRegStonePgto[intPosicaoPgto-1].fltValBru := fGetDados(nodValor.ChildNodes.FindNode('TotalAmount'), True, False) * 10000;
          FRegStonePgto[intPosicaoPgto-1].fltValLiq := fGetDados(nodValor.ChildNodes.FindNode('TotalFinancialAccountsAmount'), True, False) * 10000;

          Inc(intPosicaoPgto);
          Application.ProcessMessages;
        End;
      End;
    End;
  End;
end;

procedure TStonePgto.pGravarRegistros(pgbProg: TProgressBar);
Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
    arrCampos: TArrEstruturaStoPgto;
    arrCamCre: TArrEstruturaStoCred;

begin
  //pagamentos
  strSQL :=    'REPLACE INTO STO_STPGTO (';
  arrCampos := fRetEstruturaPgto('STO_STPGTO');
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'STO_CONCIL') Then
      strSQL := strSQL + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> 'STO_CONCIL') Then
      strSQL := strSQL + ':' + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  If Length(FRegStonePgto) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegStonePgto);
    For intCont := 0 To Length(FRegStonePgto) - 1 Do
    Begin
      If ((FRegStonePgto[intCont].strNumNsu <> '') And
         (FRegStonePgto[intCont].strCodEst <> ''))  Then
      Begin
        Application.ProcessMessages;

        FImportouPagamento := True;
        FImportouRegistro := True;

        qryDados.Close;

        qryDados.ParamByName('STO_CODEST').Value   := FRegStonePgto[intCont].strCodEst;
        qryDados.ParamByName('STO_NUMNSU').Value   := FRegStonePgto[intCont].strNumNsu;
        qryDados.ParamByName('STO_INIKEY').Value   := FRegStonePgto[intCont].strIniKey;
        qryDados.ParamByName('STO_DTAAUT').Value   := FRegStonePgto[intCont].strDtaAut;
        qryDados.ParamByName('STO_DTAVEN').Value   := FRegStonePgto[intCont].strDtaPag;
        qryDados.ParamByName('STO_NUMTER').Value   := FRegStonePgto[intCont].strNumTer;
        qryDados.ParamByName('STO_TIPPON').Value   := FRegStonePgto[intCont].strTipPon;
        qryDados.ParamByName('STO_NUMCAN').Value   := FRegStonePgto[intCont].strNumCan;
        qryDados.ParamByName('STO_NUMPAR').Value   := FRegStonePgto[intCont].strNumPar;
        qryDados.ParamByName('STO_VALBRU').Value   := FRegStonePgto[intCont].fltValBru;
        qryDados.ParamByName('STO_VALLIQ').Value   := FRegStonePgto[intCont].fltValLiq;
        qryDados.ParamByName('STO_DTAPAG').Value   := FRegStonePgto[intCont].strDtaPag;
        qryDados.ParamByName('STO_PAG_ID').Value   := FRegStonePgto[intCont].strPag_ID;
        qryDados.ParamByName('STO_VALANT').Value   := FRegStonePgto[intCont].fltValAnt;
        qryDados.ParamByName('STO_DTAORI').Value   := FRegStonePgto[intCont].strDtaOri;
        qryDados.ParamByName('STO_VALDEB').Value   := FRegStonePgto[intCont].fltValDeb;
        qryDados.ParamByName('STO_VALCAN').Value   := FRegStonePgto[intCont].fltValCan;

        qryDados.ExecSQL;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "STONE")';
      For intCont := 0 To lstEstabel.Count - 1 Do
      Begin
        qryDados.ParamByName('ESTAB').AsString := lstEstabel[intCont];
        qryDados.ExecSQL;
      End;

      FreeAndNil(lstEstabel);
    Except
      Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
    End;

    pgbProg.Position := pgbProg.Max;
  End;

  //Vendas
  strSQL :=    'REPLACE INTO STO_STCRED (';
  arrCamCre := fRetEstruturaCred('STO_STCRED');
  For intCont := 0 to Length(arrCamCre) - 1 do
    If (arrCampos[intCont].strDescri <> 'STO_CONCIL') Then
      strSQL := strSQL + arrCamCre[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';
  For intCont := 0 to Length(arrCamCre) - 1 do
    If (arrCamCre[intCont].strDescri <> 'STO_CONCIL') Then
      strSQL := strSQL + ':' + arrCamCre[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;

  If Length(FRegStoneCred) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegStoneCred);
    For intCont := 0 To Length(FRegStoneCred) - 1 Do
    Begin
      If ((FRegStoneCred[intCont].strNumNsu <> '') And
         (FRegStoneCred[intCont].strCodEst <> ''))  Then
      Begin
        Application.ProcessMessages;

        FImportouRegistro := True;

        qryDados.Close;

        qryDados.ParamByName('STO_CODEST').Value   := FRegStoneCred[intCont].strCodEst;
        qryDados.ParamByName('STO_NUMNSU').Value   := FRegStoneCred[intCont].strNumNsu;
        qryDados.ParamByName('STO_INIKEY').Value   := FRegStoneCred[intCont].strIniKey;
        qryDados.ParamByName('STO_DTAAUT').Value   := FRegStoneCred[intCont].strDtaAut;
        qryDados.ParamByName('STO_DTAVEN').Value   := FRegStoneCred[intCont].strDtaVen;
        qryDados.ParamByName('STO_TIPCAR').Value   := FRegStoneCred[intCont].strTipCar;
        qryDados.ParamByName('STO_TOTPAR').Value   := FRegStoneCred[intCont].strTotPar;
        qryDados.ParamByName('STO_CODAUT').Value   := FRegStoneCred[intCont].strCodAut;
        qryDados.ParamByName('STO_BRUVEN').Value   := FRegStoneCred[intCont].fltBruVen;
        qryDados.ParamByName('STO_NUMCAR').Value   := FRegStoneCred[intCont].strNumCar;
        qryDados.ParamByName('STO_NUMPAR').Value   := FRegStoneCred[intCont].strNumPar;
        qryDados.ParamByName('STO_VALBRU').Value   := FRegStoneCred[intCont].fltValBru;
        qryDados.ParamByName('STO_VALLIQ').Value   := FRegStoneCred[intCont].fltValLiq;
        qryDados.ParamByName('STO_DTAPRE').Value   := FRegStoneCred[intCont].strDtaPre;
        qryDados.ParamByName('STO_DTAARQ').Value   := strDtaArq;
        qryDados.ParamByName('STO_DTAIMP').Value   := objFunctions.fICurrentDate;

        qryDados.ExecSQL;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;
    pgbProg.Position := pgbProg.Max;
  End;
end;

function TStonePgto.RetornaTipoCartao(ACodigo: String): String;
begin
  Result := 'D';

  If (ACodigo = '2') Or (ACodigo = '4') Then
    Result := 'C';
end;

end.
