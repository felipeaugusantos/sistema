unit untStonePgto;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms, System.Generics.Collections,  System.Math, Data.DB,

     Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc,
     cxProgressBar, Uni,

     untISToneIntegracaoLibCartoes, untTSToneFuncoes, untSToneTipos;

Type
  TStonePgto = Class(TInterfacedObject, ICartoes)

  Private
    strCodEst,
    strDtaArq: String;

    FRegStoneCred  : TObjectList<TRegistroCred>;
    FRegStonePgto  : TObjectList<TRegistroPgto>;

    FImportouRegistro,
    FImportouPagamento: Boolean;

    FDataInicioImportacao,
    FDataFinalImportacao: TDateTime;

    function RetornaTipoCartao(ACodigo: String): String;
    function fGetDados(objValor: IXMLNode; blnFlt: Boolean = False;
                     blnDta: Boolean = False): Variant;
    function CorrigeDadosBanco(AValor: Variant;
                               ACampoData: Boolean = False): Variant;

    procedure GravaRegistrosTabelaPgto(var AProgress: TcxProgressBar);
    procedure GravaRegistrosTabelaCredito(var AProgress: TcxProgressBar);

    function RetornaPeriodoImporacaoSQL: String;
    function RegistroJaImportado(ARegistro:TRegistroPgto): Boolean;
  Public
    FDataVendasParaDownload : TStringList;

    constructor Create;
    destructor Destroy; override;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(var AProgress: TcxProgressBar);

    property ImportouRegistro: Boolean read FImportouRegistro;
    property ImportouPagamento: Boolean read FImportouPagamento;

    property DataInicioImportacao: TDateTime read FDataInicioImportacao write FDataInicioImportacao;
    property DataFinalImportacao: TDateTime read FDataFinalImportacao write FDataFinalImportacao;

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaStoPgto;
    class function fRetSQLTabelaRegCred(strTabela: String): String;
    class function fRetEstruturaCred(strTabela: String): TArrEstruturaStoCred;

  End;

implementation

{ TStonePgto }

constructor TStonePgto.Create;
Begin
  FRegStoneCred := TObjectList<TRegistroCred>.Create;
  FRegStonePgto := TObjectList<TRegistroPgto>.Create;
  FDataVendasParaDownload := TStringList.Create;

  FImportouRegistro := False;
  FImportouPagamento := False;
End;

destructor TStonePgto.Destroy;
begin
  If Assigned(FRegStoneCred) Then
    FreeAndNil(FRegStoneCred);

  If Assigned(FRegStonePgto) Then
    FreeAndNil(FRegStonePgto);

  If Assigned(FDataVendasParaDownload) Then
    FreeAndNil(FDataVendasParaDownload);
  inherited;
end;

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

function TStonePgto.fGetDados(objValor: IXMLNode; blnFlt,
  blnDta: Boolean): Variant;
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
      rst := RoundTo(TStoneFuncoes.fStrToFloat(rst), -2) / 1000000
    Else If blnDta Then
      rst := Copy(rst, 1,4) + '/' +
             Copy(rst, 5,2) + '/' +
             Copy(rst, 7,2);

    Result := rst;
  End;
End;

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

  LRegistroCredito: TRegistroCred;

  LRegistroPagamento,
  LRegistroCancelamento: TRegistroPgto;

  LImportouParcela,
  LJaAdicionouCancelamento: Boolean;

  LDataVenda:String;
begin
  Try
    docXML := TXMLDocument.Create(Nil);
    docXML.LoadFromXML(strString);

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    nodElemen := docXML.ChildNodes.FindNode('Conciliation');
    if (nodElemen <> nil) then
    begin
      nodFilho  := nodElemen.ChildNodes.FindNode('Header');
      nodValor  := nodFilho.ChildNodes.FindNode('StoneCode');
      strCodEst := fGetDados(nodValor);
      nodValor  := nodFilho.ChildNodes.FindNode('ReferenceDate');
      strDtaArq := fGetDados(nodValor, False, True);

      If (VS_ListaEstabelecimentos.IndexOf('0') < 0) Then
        VS_ListaEstabelecimentos.Add(strCodEst);

      //Pegando as Vendas
      nodFilho := nodElemen.ChildNodes.FindNode('FinancialTransactions');
      If (nodFilho <> nil) Then
      Begin
        For intCont := 0 To nodFilho.ChildNodes.Count - 1 Do
        Begin
          nodTrans := nodFilho.ChildNodes.Get(intCont);
          If (nodTrans <> Nil) Then
          Begin
             LRegistroCredito := TRegistroCred.Create;
            //Cadastrando as Vendas do Dia

            LRegistroCredito.CodigoEstabelecimento := strCodEst;
            nodValor := nodTrans.ChildNodes.FindNode('AcquirerTransactionKey');
            LRegistroCredito.NumeroNsu := fGetDados(nodValor);
            nodValor := nodTrans.ChildNodes.FindNode('InitiatorTransactionKey');
            LRegistroCredito.IniKey := fGetDados(nodValor);
            nodValor := nodTrans.ChildNodes.FindNode('AuthorizationDateTime');
            LRegistroCredito.DataAutorizacao := fGetDados(nodValor, False, True);
            nodValor := nodTrans.ChildNodes.FindNode('CaptureLocalDateTime');
            LRegistroCredito.DataVenda := fGetDados(nodValor, False, True);
            nodValor := nodTrans.ChildNodes.FindNode('AccountType');
            LRegistroCredito.TipoCartao := RetornaTipoCartao(fGetDados(nodValor));
            nodValor := nodTrans.ChildNodes.FindNode('NumberOfInstallments');
            LRegistroCredito.TotParcela := fGetDados(nodValor);
            nodValor := nodTrans.ChildNodes.FindNode('IssuerAuthorizationCode');
            LRegistroCredito.CodAutorizacao := fGetDados(nodValor);
            nodValor := nodTrans.ChildNodes.FindNode('AuthorizedAmount');
            LRegistroCredito.fltBruVen := fGetDados(nodValor, True, False);
            nodValor := nodTrans.ChildNodes.FindNode('CardNumber');
            LRegistroCredito.NumeroCartao := fGetDados(nodValor);

            nodValor := nodTrans.ChildNodes.FindNode('Installments');
            If (nodValor <> Nil) Then
            Begin
              For intCont2 := 0 To nodValor.ChildNodes.Count - 1 Do
              Begin
                nodParcel := nodValor.ChildNodes.Get(intCont2);

                If intCont2 > 0 Then
                Begin
                  LRegistroCredito := TRegistroCred.Create;
                  LRegistroCredito.CodigoEstabelecimento := FRegStoneCred[FRegStoneCred.Count - 1].CodigoEstabelecimento;
                  LRegistroCredito.NumeroNsu := FRegStoneCred[FRegStoneCred.Count - 1].NumeroNsu;
                  LRegistroCredito.IniKey := FRegStoneCred[FRegStoneCred.Count - 1].IniKey;
                  LRegistroCredito.DataAutorizacao := FRegStoneCred[FRegStoneCred.Count - 1].DataAutorizacao;
                  LRegistroCredito.DataVenda := FRegStoneCred[FRegStoneCred.Count - 1].DataVenda;
                  LRegistroCredito.TipoCartao := FRegStoneCred[FRegStoneCred.Count - 1].TipoCartao;
                  LRegistroCredito.TotParcela := FRegStoneCred[FRegStoneCred.Count - 1].TotParcela;
                  LRegistroCredito.CodAutorizacao := FRegStoneCred[FRegStoneCred.Count - 1].CodAutorizacao;
                  LRegistroCredito.fltBruVen := FRegStoneCred[FRegStoneCred.Count - 1].fltBruVen;
                  LRegistroCredito.NumeroCartao := FRegStoneCred[FRegStoneCred.Count - 1].NumeroCartao;
                End;

                LRegistroCredito.NumeroParcela := fGetDados(nodParcel.ChildNodes.FindNode('InstallmentNumber'));
                LRegistroCredito.ValorBruto := fGetDados(nodParcel.ChildNodes.FindNode('GrossAmount'), True, False);
                LRegistroCredito.ValorLiquido := fGetDados(nodParcel.ChildNodes.FindNode('NetAmount'), True, False);
                LRegistroCredito.DataPrevista := fGetDados(nodParcel.ChildNodes.FindNode('PrevisionPaymentDate'), False, True);

                //adicionei essa linha aqui ver o tipo que tem que adicionat no lugar do inc
                FRegStoneCred.Add(LRegistroCredito);
                Application.ProcessMessages;
              End;
            End
            Else
              FreeAndNil(LRegistroCredito);

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

            LRegistroPagamento := TRegistroPgto.Create;

            LRegistroPagamento.CodigoEstabelecimento := strCodEst;
            nodValor := nodTrans.ChildNodes.FindNode('AcquirerTransactionKey');
            LRegistroPagamento.NumeroNsu := fGetDados(nodValor);
            nodValor := nodTrans.ChildNodes.FindNode('InitiatorTransactionKey');
            LRegistroPagamento.IniKey := fGetDados(nodValor);
            nodValor := nodTrans.ChildNodes.FindNode('AuthorizationDateTime');
            LRegistroPagamento.DataAutorizacao := fGetDados(nodValor, False, True);
            nodValor := nodTrans.ChildNodes.FindNode('CaptureLocalDateTime');
            LRegistroPagamento.DataVenda := fGetDados(nodValor, False, True);

            nodValor := nodTrans.ChildNodes.FindNode('Poi');
            If nodValor <> Nil Then
            Begin
              LRegistroPagamento.strNumTer := fGetDados(nodValor.ChildNodes.FindNode('SerialNumber'));
              LRegistroPagamento.strTipPon := fGetDados(nodValor.ChildNodes.FindNode('PoiType'));
              If LRegistroPagamento.strTipPon = '1' Then
                LRegistroPagamento.strTipPon := 'POS'
              Else If LRegistroPagamento.strTipPon = '2' Then
                LRegistroPagamento.strTipPon := 'MICRO POS'
              Else If LRegistroPagamento.strTipPon = '3' Then
                LRegistroPagamento.strTipPon := 'TEF'
              Else If LRegistroPagamento.strTipPon = '4' Then
                LRegistroPagamento.strTipPon := 'ECOMMERCE'
              Else If LRegistroPagamento.strTipPon = '5' Then
                LRegistroPagamento.strTipPon := 'PINPAD'
              Else If LRegistroPagamento.strTipPon = '6' Then
                LRegistroPagamento.strTipPon := 'SOFTWARE'
              Else
                LRegistroPagamento.strTipPon := 'APLICATIVO';
            End;

            LRegistroPagamento.NumCancelamento := ' ';
            LRegistroPagamento.ValorAntecipacao := 0.00;
            LRegistroPagamento.ValorDebito := 0.00;
            LRegistroPagamento.ValorCancelamento := 0.00;

            nodValor := nodTrans.ChildNodes.FindNode('Installments');
            If nodValor <> Nil Then
            Begin
              For intCont2 := 0 To nodValor.ChildNodes.Count - 1 Do
              Begin
                LImportouParcela := True;

                nodParcel := nodValor.ChildNodes.Get(intCont2);
                If intCont2 > 0 Then
                Begin
                  LRegistroPagamento := TRegistroPgto.Create;

                  LRegistroPagamento.CodigoEstabelecimento := FRegStonePgto[FRegStonePgto.Count - 1].CodigoEstabelecimento;
                  LRegistroPagamento.NumeroNsu := FRegStonePgto[FRegStonePgto.Count - 1].NumeroNsu;
                  LRegistroPagamento.IniKey := FRegStonePgto[FRegStonePgto.Count - 1].IniKey;
                  LRegistroPagamento.DataAutorizacao := FRegStonePgto[FRegStonePgto.Count - 1].DataAutorizacao;
                  LRegistroPagamento.DataVenda := FRegStonePgto[FRegStonePgto.Count - 1].DataVenda;
                  LRegistroPagamento.strNumTer := FRegStonePgto[FRegStonePgto.Count - 1].strNumTer;
                  LRegistroPagamento.strTipPon := FRegStonePgto[FRegStonePgto.Count - 1].strTipPon;
                  LRegistroPagamento.NumCancelamento := FRegStonePgto[FRegStonePgto.Count - 1].NumCancelamento;
                End;
                LRegistroPagamento.Parcela := fGetDados(nodParcel.ChildNodes.FindNode('InstallmentNumber'));
                LRegistroPagamento.ValorBruto := fGetDados(nodParcel.ChildNodes.FindNode('GrossAmount'), True, False);
                LRegistroPagamento.ValorLiquido := fGetDados(nodParcel.ChildNodes.FindNode('NetAmount'), True, False);
                LRegistroPagamento.DataPagamento := fGetDados(nodParcel.ChildNodes.FindNode('PaymentDate'), False, True);
                LRegistroPagamento.Pag_ID := fGetDados(nodParcel.ChildNodes.FindNode('PaymentId'));
                If nodParcel.ChildNodes.FindNode('AdvanceRateAmount') <> Nil Then
                Begin
                  LRegistroPagamento.ValorAntecipacao := fGetDados(nodParcel.ChildNodes.FindNode('AdvanceRateAmount'), True, False);
                  LRegistroPagamento.DataOrigem := fGetDados(nodParcel.ChildNodes.FindNode('AdvancedReceivableOriginalPaymentDate'), False, True);
                End;

                strParcel := fGetDados(nodParcel.ChildNodes.FindNode('InstallmentNumber'));

                LDataVenda := LRegistroPagamento.DataVenda;  // Armazena a data da venda

                if not FDataVendasParaDownload.Text.Contains(LDataVenda) then
                  FDataVendasParaDownload.Add(LDataVenda);

                FRegStonePgto.Add(LRegistroPagamento);
                Application.ProcessMessages;
              End;
            End;

            LJaAdicionouCancelamento := False;

            //Cancelamentos
            nodValor := nodTrans.ChildNodes.FindNode('Cancellations');
            If (nodValor <> Nil) Then
            Begin
              LRegistroCancelamento := TStoneFuncoes.ClonarObjeto(LRegistroPagamento);

              For intCont2 := 0 To nodValor.ChildNodes.Count - 1 Do
              Begin
                nodParcel := nodValor.ChildNodes.Get(intCont2);
                If (intCont2 > 0) Or (LImportouParcela) Then
                Begin
                  If LJaAdicionouCancelamento Then
                    LRegistroCancelamento := TStoneFuncoes.ClonarObjeto(LRegistroPagamento);

                  LRegistroCancelamento.CodigoEstabelecimento := FRegStonePgto[FRegStonePgto.Count - 1].CodigoEstabelecimento;
                  LRegistroCancelamento.NumeroNsu := FRegStonePgto[FRegStonePgto.Count - 1].NumeroNsu;
                  LRegistroCancelamento.IniKey := FRegStonePgto[FRegStonePgto.Count - 1].IniKey;
                  LRegistroCancelamento.DataAutorizacao := FRegStonePgto[FRegStonePgto.Count - 1].DataAutorizacao;
                  LRegistroCancelamento.DataVenda := FRegStonePgto[FRegStonePgto.Count - 1].DataVenda;
                  LRegistroCancelamento.strNumTer := FRegStonePgto[FRegStonePgto.Count - 1].strNumTer;
                  LRegistroCancelamento.strTipPon := FRegStonePgto[FRegStonePgto.Count - 1].strTipPon;
                End;
                LRegistroCancelamento.ValorBruto := 0;
                LRegistroCancelamento.ValorLiquido := 0;
                LRegistroCancelamento.NumCancelamento := fGetDados(nodParcel.ChildNodes.FindNode('OperationKey'));
                LRegistroCancelamento.Parcela := strParcel;
                LRegistroCancelamento.DataPagamento := fGetDados(nodParcel.ChildNodes.FindNode('CancellationDateTime'), False, True);
                LRegistroCancelamento.ValorDebito := fGetDados(nodParcel.ChildNodes.FindNode('ReturnedAmount'), True, False);
                If nodParcel.ChildNodes.FindNode('AdvanceRateAmount') <> Nil Then
                Begin
                  LRegistroCancelamento.ValorAntecipacao := fGetDados(nodParcel.ChildNodes.FindNode('AdvanceRateAmount').ChildNodes.FindNode('AdvanceRateAmount'), True, False);
                  LRegistroCancelamento.DataOrigem := fGetDados(nodParcel.ChildNodes.FindNode('AdvanceRateAmount').ChildNodes.FindNode('AdvancedReceivableOriginalPaymentDate'), False, True);
                End;
                If nodParcel.ChildNodes.FindNode('Billing') <> Nil Then
                Begin
                  LRegistroCancelamento.ValorCancelamento := fGetDados(nodParcel.ChildNodes.FindNode('Billing').ChildNodes.FindNode('ChargedAmount'), True, False);
                  LRegistroCancelamento.DataPagamento := fGetDados(nodParcel.ChildNodes.FindNode('Billing').ChildNodes.FindNode('ChargeDate'), False, True);
                End;

                If (LRegistroCancelamento.Parcela = '') Then
                Begin
                  LRegistroCancelamento.Parcela := '1';
                  LRegistroCancelamento.ValorBruto := LRegistroCancelamento.ValorCancelamento;
                  LRegistroCancelamento.ValorLiquido := LRegistroCancelamento.ValorCancelamento;
                End;

                LJaAdicionouCancelamento := True;
                FRegStonePgto.Add(LRegistroCancelamento);
                Application.ProcessMessages;
              End;

              If Not LJaAdicionouCancelamento Then
                FreeAndNil(LRegistroCancelamento);
            End;

            If Not LImportouParcela Then
              FreeAndNil(LRegistroPagamento);
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
            LRegistroPagamento := TRegistroPgto.Create;

            LRegistroPagamento.CodigoEstabelecimento := strCodEst;
            LRegistroPagamento.NumeroNsu := fGetDados(nodValor.ChildNodes.FindNode('Id'));
            LRegistroPagamento.IniKey := fGetDados(nodValor.ChildNodes.FindNode('Id'));
            LRegistroPagamento.DataAutorizacao := strDtaArq;
            LRegistroPagamento.DataVenda := strDtaArq;
            LRegistroPagamento.DataPagamento := strDtaArq;
            LRegistroPagamento.strNumTer := '';
            LRegistroPagamento.strTipPon := 'TRF';

            LRegistroPagamento.NumCancelamento := 'TRANSFERENCIA';
            LRegistroPagamento.Parcela := '1';
            LRegistroPagamento.ValorBruto := fGetDados(nodValor.ChildNodes.FindNode('TotalAmount'), True, False) * 10000;
            LRegistroPagamento.ValorLiquido := fGetDados(nodValor.ChildNodes.FindNode('TotalFinancialAccountsAmount'), True, False) * 10000;

            FRegStonePgto.Add(LRegistroPagamento);
          End;
        End;
      End;
    End;
  Except
    Raise;
  End;
end;

function TStonePgto.CorrigeDadosBanco(AValor: Variant;
                                            ACampoData: Boolean = False): Variant;
begin
  Result := Null;
  If Not TStoneFuncoes.fEmptyStr(AValor) Then
  Begin
    Result := AValor;

    If ACampoData Then
      Result := RightStr(Result, 4) + '-' +
                Copy(Result, 4, 2) + '-' +
                LeftStr(Result, 2);
  End;
end;

procedure TStonePgto.GravaRegistrosTabelaCredito(var AProgress: TcxProgressBar);
var
  LGravacao: TUniQuery;
  LRegistro: TRegistroCred;
begin
  LGravacao := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TStoneFuncoes.RetornaSQLReplace('STO_STCRED', ['STO_CONCIL']);

    AProgress.Position := 0;

    AProgress.Properties.Max := FRegStoneCred.Count;

    For LRegistro In FRegStoneCred Do
    Begin
      FImportouPagamento := True;
      FImportouRegistro := True;

      LGravacao.Close;

      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_CODEST', CorrigeDadosBanco(LRegistro.CodigoEstabelecimento));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_NUMNSU', CorrigeDadosBanco(LRegistro.NumeroNsu));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_INIKEY', CorrigeDadosBanco(LRegistro.IniKey));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_DTAAUT', CorrigeDadosBanco(LRegistro.DataAutorizacao));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_DTAVEN', CorrigeDadosBanco(LRegistro.DataVenda));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_TIPCAR', CorrigeDadosBanco(LRegistro.TipoCartao));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_TOTPAR', CorrigeDadosBanco(LRegistro.TotParcela));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_CODAUT', CorrigeDadosBanco(LRegistro.CodAutorizacao));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_BRUVEN', CorrigeDadosBanco(LRegistro.fltBruVen));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_NUMCAR', CorrigeDadosBanco(LRegistro.NumeroCartao));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_NUMPAR', CorrigeDadosBanco(LRegistro.NumeroParcela));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_VALBRU', CorrigeDadosBanco(LRegistro.ValorBruto));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_VALLIQ', CorrigeDadosBanco(LRegistro.ValorLiquido));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_DTAPRE', CorrigeDadosBanco(LRegistro.DataPrevista));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_DTAARQ', CorrigeDadosBanco(strDtaArq));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_DTAIMP', CorrigeDadosBanco(date, true));

      LGravacao.ExecSQL;

      TStoneFuncoes.pStepStatusGravacao(AProgress);
    End;
  Finally
    TStoneFuncoes.FreeAndNilDatasets(LGravacao);
  End;
end;

procedure TStonePgto.GravaRegistrosTabelaPgto(var AProgress: TcxProgressBar);
var
  LGravacao: TUniQuery;

  LRegistroPagamento: TRegistroPgto;
begin
  LGravacao := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TStoneFuncoes.RetornaSQLReplace('STO_STPGTO', ['STO_CONCIL']);

    If Not Assigned(VS_RegistrosJaImportados) Then
      TStoneFuncoes.CarregaRegistrosJaImportados('STO_STPGTO',
                                                ['STO_CONCIL', 'STO_DTAPAG', 'STO_NUMCAN'],
                                                ['= 1',RetornaPeriodoImporacaoSQL, '<> "" ']);

    AProgress.Position := 0;

    AProgress.Properties.Max := FRegStonePgto.Count;

    For LRegistroPagamento In FRegStonePgto Do
    Begin
      FImportouPagamento := True;
      FImportouRegistro := True;

      LGravacao.Close;

      If LRegistroPagamento.DataPagamento = '' Then
      Begin
        TStoneFuncoes.pStepStatusGravacao(AProgress);
        Continue;
      End;

      If RegistroJaImportado(LRegistroPagamento) Then
      Begin
        TStoneFuncoes.pStepStatusGravacao(AProgress);
        Continue;
      End;

      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_CODEST', CorrigeDadosBanco(LRegistroPagamento.CodigoEstabelecimento));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_NUMNSU', CorrigeDadosBanco(LRegistroPagamento.NumeroNsu));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_VALDEB', CorrigeDadosBanco(LRegistroPagamento.ValorDebito));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_VALCAN', CorrigeDadosBanco(LRegistroPagamento.ValorCancelamento));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_VALBRU', CorrigeDadosBanco(LRegistroPagamento.ValorBruto));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_VALLIQ', CorrigeDadosBanco(LRegistroPagamento.ValorLiquido));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_VALANT', CorrigeDadosBanco(LRegistroPagamento.ValorAntecipacao));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_INIKEY', CorrigeDadosBanco(LRegistroPagamento.IniKey));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_DTAAUT', CorrigeDadosBanco(LRegistroPagamento.DataAutorizacao));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_DTAVEN', CorrigeDadosBanco(LRegistroPagamento.DataVenda));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_NUMCAN', LRegistroPagamento.NumCancelamento);
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_NUMPAR', LRegistroPagamento.Parcela);
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_DTAPAG', CorrigeDadosBanco(LRegistroPagamento.DataPagamento));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_PAG_ID', CorrigeDadosBanco(LRegistroPagamento.Pag_ID));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_DTAORI', CorrigeDadosBanco(LRegistroPagamento.DataOrigem));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_NUMTER', CorrigeDadosBanco(LRegistroPagamento.strNumTer));
      TStoneFuncoes.CarregaParametroDataset(LGravacao, 'STO_TIPPON', CorrigeDadosBanco(LRegistroPagamento.strTipPon));

      LGravacao.ExecSQL;

      TStoneFuncoes.pStepStatusGravacao(AProgress);
    End;
  Finally
    TStoneFuncoes.FreeAndNilDatasets(LGravacao);
  End;
end;

procedure TStonePgto.pGravarRegistros(var AProgress: TcxProgressBar);
begin
  VS_FuncoesExternas.fIStartTransaction;
  Try
    GravaRegistrosTabelaPgto(AProgress);
    GravaRegistrosTabelaCredito(AProgress);

    FRegStoneCred.Clear;
    FRegStonePgto.Clear;

    TStoneFuncoes.GravarEstabelecimentos;

    VS_FuncoesExternas.fICommit;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollback;

      Raise Exception.Create('Ocorreu um erro ao gravar os registros.' +
                             'Erro gerado: ' + E.Message);
    End;
  End;
end;

function TStonePgto.RegistroJaImportado(ARegistro: TRegistroPgto): Boolean;
  Var
    LDataVenda,
    LDataPagamento: TDateTime;
begin
  If Not Assigned(VS_RegistrosJaImportados) Then
    Exit(False);

  If VS_RegistrosJaImportados.IsEmpty Then
    Exit(False);

  Try
    LDataVenda := EncodeDate(StrToInt(LeftStr(ARegistro.DataVenda, 4)),
                             StrToInt(Copy(ARegistro.DataVenda, 6, 2)),
                             StrToInt(RightStr(ARegistro.DataVenda, 2)));

    LDataPagamento := EncodeDate(StrToInt(LeftStr(ARegistro.DataPagamento, 4)),
                                 StrToInt(Copy(ARegistro.DataPagamento, 6, 2)),
                                 StrToInt(RightStr(ARegistro.DataPagamento, 2)));
  Except
    {não pode parar a importação}
    Exit(False);
  End;

  Result := VS_RegistrosJaImportados.Locate('STO_CODEST;STO_NUMNSU;STO_DTAVEN;STO_NUMPAR;STO_DTAPAG;STO_NUMCAN',
                                            VarArrayOf([CorrigeDadosBanco(ARegistro.CodigoEstabelecimento),
                                                        CorrigeDadosBanco(ARegistro.NumeroNsu),
                                                        LDataVenda,
                                                        CorrigeDadosBanco(ARegistro.Parcela),
                                                        LDataPagamento,
                                                        CorrigeDadosBanco(ARegistro.NumCancelamento)]), []);
end;

function TStonePgto.RetornaPeriodoImporacaoSQL: String;
begin
  Result := ' BETWEEN "' + FormatDateTime('yyyy-mm-dd', FDataInicioImportacao) + '" ' +
            '     AND "' + FormatDateTime('yyyy-mm-dd', FDataFinalImportacao) + '" ';
end;

function TStonePgto.RetornaTipoCartao(ACodigo: String): String;
begin
  Result := 'D';

  If (ACodigo = '2') Or (ACodigo = '4') Then
    Result := 'C';
end;

end.
