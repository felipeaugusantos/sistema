unit untGravacaoPedido;

interface

uses SysUtils, DB, Dialogs, Controls, Math, UniClientDataSet, untFuncoesPedidoSimples,
     untDuplicatasPedidoCompra, untZClient, Classes, System.StrUtils,
     Uni;

Type
  TMoeda = (moeReal, moeDolar);

  // RECUPERA O AUTOINCREMENTO DOS ITENS EXCLUIDOS
  TRecuperaExcluidos = Class(TZClient)
  Private
    FItensEspeciais,
    FNumPed,
    FEspPed,
    FCodEmp: String;

    cdsExcluidos: TZClient;

    Function fGetItensEspeciais: String;

    Function fSQLDados(bnlRecuperaPedido: Boolean;
                       strSeqGer,
                       strNumPed,
                       strEspPed,
                       strCodEmp: String): String;
    function fExcluiItem(cdsItensPedido: TUniClientDataSet): Boolean;

  public

    blnHeranca: Boolean;
    Constructor Create(Owner: TComponent;
                       bnlRecuperaPedido: Boolean;
                       strSeqGer,
                       strNumPed,
                       strEspPed,
                       strCodEmp: String); Overload;

    Destructor Destroy; override;

    Procedure pSalvaAutoincrem(strCodIte, strDesIte, strAutoincrem: String);

    Function fRetAutoincrem(strCodIte: String; Var strAutInc: String): Boolean;

    Function fTemItensPedido(strNumPed, strEspPed, strCodEmp: String; Var strMsgErro: string): Boolean;

    Function fApagaExcluidos(cdsItensPedido: TUniClientDataSet; blnManterZerados: Boolean): Boolean;
    class function fPcmDetFicouVazio(strNumPed, strEspPed, strCodEmp: String): Boolean;
  End;

procedure pDeletaPedOrcCompra(strNumPed, strEmpPed, strEspPed: String;
                              blnGerouApenasTransferencia: Boolean = false;
                              blnTransforma: Boolean = False;
                              intQtdItensMutiLj: Integer = 0;
                              strFinPed: String = '' );
procedure pDeletaPcmDet(strNumPed, strEspPed, strEmpPed: String);
procedure pDeletaPedidosContainer(strNumPed, strEspDoc, strCodEmp: String);
procedure pApagaPcdDet(strNumPed, strCodEmp, strEspDoc: String);

procedure pGravaPcmGer(AblnSomaDescontoAdcionalFornecedor1: Boolean;
                       qryPcmGer: TUniQuery;
                       objParcelas: TDuplicatasPedidoCompra;
                       strNumPed,
                       strCodEmp,
                       strEspDoc,
                       strCodFor,
                       strCodTra,
                       strCodTraRedespacho,
                       strConPag: String;
                       dtaDtaPed,
                       horHorEnt,
                       dtaDtaEnt: TDateTime;
                       strCompra: String;
                       fltTotIpi,
                       fltTotSub,
                       fltTotDar,
                       fltSubFCP,
                       fltTotIte,
                       fltTotGer: Double;
                       strObs001,
                       strObs002,
                       strObs003,
                       strObs004,
                       strObs005,
                       strObsPd1,
                       strObsPd2,
                       strObsPd3,
                       strPedVen,
                       strAtenca,
                       strTipFre,
                       strTipFreRedespacho,
                       strDocOri: String;
                       intNumCtn: Integer;
                       strPedImp,
                       strPedInt,
                       strEmpDes: String;
                       fltDesAdi: Double;
                       strPedMlj: String;
                       fltValFre,
                       fltDesAce: Double;
                       dtaDtaFat: TDate;
                       strCodEve,
                       strCodCta: String;
                       strNomEnt,
                       strEndEnt,
                       strCidEnt,
                       strNivGiro: String;
                       nivEstoque: TNivelEstoque;
                       intDiaComGer: Integer;
                       intDiaComNvA: Integer;
                       intDiaComNvB: Integer;
                       intDiaComNvC: Integer;
                       fltBasCof,
                       fltValCof,
                       fltBasPis,
                       fltValPis,
                       fltBasIcm,
                       fltValIcm,
                       fltBasIpi,
                       fltBasSub: Double;
                       strPagVis: String;
                       strNumCot: String;
                       strEmpCot: String;
                       strPedBon: String;
                       strZeraST: String;
                       strDesPdi: String;
                       intMesGir: Integer;
                       strMesAtu: String;
                       strOrcOri: String;
                       fltValSis,
                       fltValMar,
                       fltDesPis: Double;
                       Var strAutInc: String;
                       strUsaGir: String;
                       blnTabRestaura: Boolean = False;
                       strCodDig: string = '';
                       strNumPok: string = '';
                       moeMoeda: TMoeda = moeReal;
                       strPreOrc: String = 'N';
                       strBStFre: String = 'S';
                       strBStAce: String = 'S';
                       strOrdCon: String = '';
                       strTipCodFabProd: String = '';
                       strObsPd4: String = '';
                       strObsPd5: String = '';
                       strObsPd6: String = '';
                       strIpiFre: String = 'N';
                       blnPagamentoCartaoCredito: Boolean = False;
                       strObs006: String = '';
                       fltValCbs: Double = 0;
                       fltValIbs: Double = 0;
                       fltVal_Is: Double = 0);

procedure pAtualizaPcmGer(AblnSomaDescontoAdcionalFornecedor1: Boolean;
                          qryGenGer: TUniQuery;
                          objParcelas: TDuplicatasPedidoCompra;
                          strNumPed,
                          strCodEmp,
                          strEspDoc,
                          strCodFor,
                          strCodTra,
                          strCodTraRedespacho,
                          strConPag: String;
                          dtaDtaPed,
                          horHorPed,
                          dtaDtaEnt: TDateTime;
                          strCompra: String;
                          fltTotIpi,
                          fltTotSub,
                          fltTotDar,
                          fltSubFCP,
                          fltTotIte,
                          fltTotGer: Double;
                          strObs001,
                          strObs002,
                          strObs003,
                          strObs004,
                          strObs005,
                          strObsPd1,
                          strObsPd2,
                          strObsPd3,
                          strPedVen,
                          strAtenca,
                          strTipFre,
                          strTipFreRedespacho: String;
                          fltDesAdi,
                          fltValFre,
                          fltDesAce: Double;
                          strPedImp,
                          strPedInt: String;
                          dtaDtaFat: TDate;
                          strCodEve,
                          strCodCta: String;
                          strNomEnt,
                          strEndEnt,
                          strCidEnt: String;
                          fltBasCof,
                          fltValCof,
                          fltBasPis,
                          fltValPis,
                          fltBasIcm,
                          fltValIcm,
                          fltBasIpi,
                          fltBasSub: Double;
                          strPagVis,
                          strPedBon,
                          strZeraST,
                          strDesPdi: String;
                          fltValSis,
                          fltValMar,
                          fltDesPis: Double;
                          blnTabRestaura: Boolean = False;
                          strAutInc: String = '';
                          strCodDig: String = '';
                          moeMoeda: TMoeda = moeReal;
                          strBStFre: String = 'S';
                          strBStAce: String = 'S';
                          strOrdCon: String = '';
                          strTipCodFabProd: String = '';
                          strObsPd4: String = '';
                          strObsPd5: String = '';
                          strObsPd6: String = '';
                          strIpiFre: String = 'N';
                          blnPagamentoCartaoCredito: Boolean = False;
                          strObs006: String = '';
                          fltValCbs: Double = 0;
                          fltValIbs: Double = 0;
                          fltVal_Is: Double = 0);
function fAutoincremPerteceAoNumPed(AAutIncPcd, ANumPed, ACodEmp, AEspDoc: String): Boolean;

function fGravaPcmDet(Var intQtdConCol: Integer;
                       qryColeta: TUniQuery;
                       blnUsaColeta: Boolean;
                       strEmpDes,
                       strCampoSaldoSub,
                       strCampoSaldoAdd: String;
                       intDeqTpc: Integer;
                       strNumPed,
                       strCodEmp,
                       strEspDoc,
                       strCodFor,
                       strCodIte: String;
                       strCodUni: String;
                       dtaDtaEnt,
                       horHorPed,
                       dtaDtaPed: TDateTime;
                       strConPag,
                       strDesIte: String;
                       fltQtdIte,
                       fltUnitar,
                       fltDesUni,
                       fltDesUn2,
                       fltDesUn3,
                       fltDesUn4,
                       fltDesUn5,
                       fltDesUn6,
                       fltTotIte,
                       fltPerIpi,
                       fltTotIpi,
                       fltPerSub,
                       fltTotSub,
                       fltTotDar,
                       fltPerFCP,
                       fltSubFCP,
                       fltQtdBai,
                       fltTotBai,
                       fltIpiBai,
                       fltSubBai,
                       fltDarBai,
                       fltFCPBai,
                       fltFreBai,
                       fltAceBai,
                       fltValFre,
                       fltDesAce: Double;
                       intBaixad: Integer;
                       strDocOri: String;
                       intNumCtn: Integer;
                       strPedImp,
                       strPedInt,
                       strPedTxt: String;
                       fltQTDINC: Double;
                       fltTRAINC: Double;
                       Var strAutIncPcd: String;
                       strCodAca,
                       strEmpAca,
                       strProAca: String;
                       fltQtdCon,
                       fltBasSub,
                       fltBasIPI,
                       fltBasIcm,
                       fltPerBas,
                       fltAlqIcm,
                       fltValIcm: Double;
                       blnIncPis: Boolean;
                       strAutIncIRQ_comma: String;
                       fltAlqPis,
                       fltAlqCof,
                       fltAlqImp,
                       fltValImp,
                       fltValSis,
                       fltValMar: Double;
                       strFatDor: string;
                       fltEmbala: Double;
                       fltALPISP,
                       fltALCOFP: Double;
                       strSubUsu: String;
                       fltDesPis: Double;
                       blnTabRestaura: Boolean = False;
                       strSeqGer: String = '';
                       blnInsere: Boolean = True;
                       strAutoin: String = '';
                       blnVeioAutIncPcdInclusao: Boolean = False;
                       fltQtdOrc: Double = -1;
                       dtaDatEdt: TDateTime = 0;
                       fltUniLiq: Double = 0;
                       fltAlqCbs: Double = 0;
                       fltAlqIbs: Double = 0;
                       fltAlq_Is: Double = 0;
                       fltValCbs: Double = 0;
                       fltValIbs: Double = 0;
                       fltVal_Is: Double = 0): string;

function fGravarPcdDet( var strAutIncPcdDet: string;
                        strNumPed,
                        strEspDoc,
                        strCodEmp,
                        strCodIte,
                        strSeqGer: String;
                        cdsItensMlj: TUniClientDataSet;
                        blnTabRestaura: Boolean = False;
                        strAutPcg: String = '';
                        blnGerarAutoincrem: Boolean = False;
                        blnFiltraItem: Boolean = True): string; overload;

function fGravarPcdDet(strAutIncPcdDet: string;
                       strCodEmp,
                       strCodIte,
                       strEmpDes,
                       strEspDoc,
                       strNumPed: String;
                       fltQtdIte: Double;
                       strSeqGer: String;
                       blnTabRestaura: Boolean = False;
                       strAutPcg: String = '';
                       strIncIRQ: String = ''): string; overload;

function fSeqPedidoCompra(blnTabRestaura: Boolean = False; strCodEmp: String = ''): String;
function fSeqOrcamento(blnTabRestaura: Boolean = False; strCodEmp: String = ''): String;
function fRetTipoMoeda(intTipoMoeda: Integer = 0 {INT_MOEDA_REAL}): TMoeda;

Function fSQLGravaRequisicao(blnTabRestaura: Boolean; strAutIncIRQ_comma, strAutIncPCMDET: String; strAutoIncPCMGER: String): String;

implementation

uses untModulo, untFuncoesSimples, Variants, untSalvaDadosGiro, untSaldoPedidoCompra,
  untTMontaSQLPedidoCompra, untConstantes;

function fRetTipoMoeda(intTipoMoeda: Integer = 0 {INT_MOEDA_REAL}): TMoeda;
Begin
  Case intTipoMoeda Of
    INT_MOEDA_DOLAR : Result := moeDolar;
    INT_MOEDA_REAL  : Result := moeReal;
  Else
    Result := moeReal;
  End
End;

procedure pDeletaPcmDet(strNumPed, strEspPed, strEmpPed: String);
  Var
    strSQL, strSQLDelete: String;
    qryGenDet: TUniQuery;
    blnTemRegistro: Boolean;
begin
  blnTemRegistro := False;
  qryGenDet := fCriaQuery(Nil);
  Try
    Try
      pEstornaSaldoPedidoCompra(strNumPed, strEspPed, strEmpPed);

      strSQL := '';
      strSQL := strSQL + ' SELECT * ';
      strSQL := strSQL + '  FROM PCMDET ';
      strSQL := strSQL + 'WHERE  ';
      strSQL := strSQL + '  PCD_NUMPED = "' + strNumPed + '" AND ';
      strSQL := strSQL + '  PCD_CODEMP = "' + strEmpPed + '" AND ';
      strSQL := strSQL + '  PCD_ESPDOC = "' + strEspPed + '" ';

      With qryGenDet Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;
        If Not qryGenDet.IsEmpty Then
        Begin
          First;
          While Not Eof Do
          Begin
            fVerificaIntegridade('frmPedidoCompra', 'PCMDET', qryGenDet, True);
            Next;
          End;
          blnTemRegistro := True;
        End;

      End;

      strSQLDelete := '';
      strSQLDelete := strSQLDelete + ' DELETE FROM ';
      strSQLDelete := strSQLDelete + '  PCMDET ';
      strSQLDelete := strSQLDelete + ' WHERE ';
      strSQLDelete := strSQLDelete + '  PCD_NUMPED = :NUMPED AND ';
      strSQLDelete := strSQLDelete + '  PCD_CODEMP = :CODEMP AND ';
      strSQLDelete := strSQLDelete + '  PCD_ESPDOC = :ESPDOC ';
      strSQLDelete := strSQLDelete + '  ; ';
      strSQLDelete := strSQLDelete + '  -- blnTemRegistro ' + IIf(blnTemRegistro, 'Sim', 'Nao');

      With qryGenDet Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQLDelete);
        ParamByName('NUMPED').AsString := strNumPed;
        ParamByName('CODEMP').AsString := strEmpPed;
        ParamByName('ESPDOC').AsString := strEspPed;
        ExecSQL;
        Close;
      End;

    Except
      Raise;
    End;

  Finally
    FreeAndNil(qryGenDet);
  End;

end;

procedure pDeletaPedOrcCompra(strNumPed, strEmpPed, strEspPed: String;
                              blnGerouApenasTransferencia: Boolean = false;
                              blnTransforma: Boolean = False;
                              intQtdItensMutiLj: Integer = 0;
                              strFinPed: String = '' );
  Var
    strSQL   : String;
    qryGenDet: TUniQuery;
    qryIntegridade: TUniQuery;
begin
  Try
    If Not strNumped.IsEmpty Then
      TSalvaInterfaceGiro.fApagaInterfacePedido(fCampoTabela('AUTOINCREM', 'PCMGER', ['PCG_NUMPED', 'PCG_CODEMP', 'PCG_ESPDOC'],
                                                 [strNumped, strEmpPed, strEspPed]));

    qryGenDet := fCriaQuery(Nil);


    If blnTransforma Then
    Begin
      qryIntegridade  := fCriaQuery(Nil);
      Try

        qryIntegridade.SQL.Add('SELECT * FROM PCMGER ');
        qryIntegridade.SQL.Add('WHERE ');
        qryIntegridade.SQL.Add('  PCG_NUMPED = :NUMPED AND');
        qryIntegridade.SQL.Add('  PCG_CODEMP = :CODEMP AND');
        qryIntegridade.SQL.Add('  PCG_ESPDOC = :ESPDOC');

        qryIntegridade.ParamByName('NUMPED').AsString := strNumPed;
        qryIntegridade.ParamByName('CODEMP').AsString := strEmpPed;
        qryIntegridade.ParamByName('ESPDOC').AsString := strEspPed;

        qryIntegridade.Open;

        If not qryIntegridade.IsEmpty Then
        Begin
          fVerificaIntegridade('pDeletaPedOrcCompra', 'PCMGER', qryIntegridade, True, False, 'Gravação do Pedido', '', False, strEspPed);
          qryIntegridade.Close;
          qryIntegridade.SQL.Clear;
          qryIntegridade.SQL.Add('SELECT * FROM PCMDET ');
          qryIntegridade.SQL.Add('WHERE ');
          qryIntegridade.SQL.Add('  PCD_NUMPED = :NUMPED AND');
          qryIntegridade.SQL.Add('  PCD_CODEMP = :CODEMP AND');
          qryIntegridade.SQL.Add('  PCD_ESPDOC = :ESPDOC');

          qryIntegridade.ParamByName('NUMPED').AsString := strNumPed;
          qryIntegridade.ParamByName('CODEMP').AsString := strEmpPed;
          qryIntegridade.ParamByName('ESPDOC').AsString := strEspPed;
          qryIntegridade.Open;
          While not qryIntegridade.Eof Do
          begin
            fVerificaIntegridade('pDeletaPedOrcCompra', 'PCMDET', qryIntegridade, True, False, 'Gravação do Pedido', '', False, strEspPed);
            qryIntegridade.Next;
          End;

          qryIntegridade.Close;

          qryIntegridade.SQL.Clear;
          qryIntegridade.SQL.Add('SELECT * FROM PCDDET ');
          qryIntegridade.SQL.Add('WHERE ');
          qryIntegridade.SQL.Add('  PCD_NUMPED = :NUMPED AND');
          qryIntegridade.SQL.Add('  PCD_CODEMP = :CODEMP AND');
          qryIntegridade.SQL.Add('  PCD_ESPDOC = :ESPDOC');

          qryIntegridade.ParamByName('NUMPED').AsString := strNumPed;
          qryIntegridade.ParamByName('CODEMP').AsString := strEmpPed;
          qryIntegridade.ParamByName('ESPDOC').AsString := strEspPed;
          qryIntegridade.Open;
          If not qryIntegridade.IsEmpty Then
          While not qryIntegridade.Eof Do
          begin
            fVerificaIntegridade('pDeletaPedOrcCompra', 'PCDDET', qryIntegridade, True, False, 'Gravação do Pedido', '', False, strEspPed);
            qryIntegridade.Next;
          End;


        End;
      Finally
        FreeAndNil(qryIntegridade);
      End;
    End;


    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCG_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '  ;/* ';
    strSQL := strSQL + '  | Gerou apenas Transferencia = ' + IIf(blnGerouApenasTransferencia, 'Sim', 'Nao');
    strSQL := strSQL + '  | blnTransforma = ' + IIf(blnTransforma, 'Sim', 'Nao');
    strSQL := strSQL + '  | intQtdItensMutiLj = ' + intToStr(intQtdItensMutiLj);
    strSQL := strSQL + '  | strFinPed = ' + strFinPed ;
    strSQL := strSQL + '  */ ';


    Try
      With qryGenDet Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMPED').AsString := strNumPed;
        ParamByName('CODEMP').AsString := strEmpPed;
        ParamByName('ESPDOC').AsString := strEspPed;
        ExecSQL;
        Close;
      End;
    Except
      Raise;
    End;

  Finally
    FreeAndNil(qryGenDet);
  End;

end;

procedure pDeletaPedidosContainer(strNumPed, strEspDoc, strCodEmp: String);
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;

begin
  Try

    qryGenGer := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCG_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  PCG_NUMCTN > 0 ';

    Try
      With qryGenGer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMPED').AsString := strNumPed;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ExecSQL;
        Close;
      End;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;                     

end;

procedure pApagaPcdDet(strNumPed, strCodEmp, strEspDoc: String);
  Var
    strSQL, strSQLDelete: String;
    qryGenDet: TUniQuery;
    blnTemRegistro: Boolean;
begin
  blnTemRegistro := False;
  qryGenDet := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT * ';
    strSQL := strSQL + '  FROM PCDDET ';
    strSQL := strSQL + 'WHERE  ';
    strSQL := strSQL + '  PCD_NUMPED = "' + strNumPed + '" AND ';
    strSQL := strSQL + '  PCD_CODEMP = "' + strCodEmp + '" AND ';
    strSQL := strSQL + '  PCD_ESPDOC = "' + strEspDoc + '" ';

    With qryGenDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      If Not qryGenDet.IsEmpty Then
      Begin
        First;
        While Not Eof do
        Begin
          fVerificaIntegridade('frmPedidoCompra', 'PCDDET', qryGenDet, True);
          Next;
        End;
        blnTemRegistro := True;
      End;

    End;

    strSQLDelete := '';
    strSQLDelete := strSQLDelete + 'DELETE FROM ';
    strSQLDelete := strSQLDelete + '  PCDDET ';
    strSQLDelete := strSQLDelete + 'WHERE ';
    strSQLDelete := strSQLDelete + '  PCD_NUMPED = :NUMPED AND ';
    strSQLDelete := strSQLDelete + '  PCD_CODEMP = :CODEMP AND ';
    strSQLDelete := strSQLDelete + '  PCD_ESPDOC = :ESPDOC ';
    strSQLDelete := strSQLDelete + '  ; ';
    strSQLDelete := strSQLDelete + '  -- blnTemRegistro ' + IIf(blnTemRegistro, 'Sim', 'Nao');

    Try
      With qryGenDet Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQLDelete);
        ParamByName('NUMPED').AsString := strNumPed;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ExecSQL;
        Close;
      End;
    Except
      Raise;
    End;

  Finally
    FreeAndNil(qryGenDet);
  End;

end;

procedure pGravaPcmGer(AblnSomaDescontoAdcionalFornecedor1: Boolean;
                       qryPcmGer: TUniQuery;
                       objParcelas: TDuplicatasPedidoCompra;
                       strNumPed,
                       strCodEmp,
                       strEspDoc,
                       strCodFor,
                       strCodTra,
                       strCodTraRedespacho,
                       strConPag: String;
                       dtaDtaPed,
                       horHorEnt,
                       dtaDtaEnt: TDateTime;
                       strCompra: String;
                       fltTotIpi,
                       fltTotSub,
                       fltTotDar,
                       fltSubFCP,
                       fltTotIte,
                       fltTotGer: Double;
                       strObs001,
                       strObs002,
                       strObs003,
                       strObs004,
                       strObs005,
                       strObsPd1,
                       strObsPd2,
                       strObsPd3,
                       strPedVen,
                       strAtenca,
                       strTipFre,
                       strTipFreRedespacho,
                       strDocOri: String;
                       intNumCtn: Integer;
                       strPedImp,
                       strPedInt,
                       strEmpDes: String;
                       fltDesAdi: Double;
                       strPedMlj: String;
                       fltValFre,
                       fltDesAce: Double;
                       dtaDtaFat: TDate;
                       strCodEve,
                       strCodCta,
                       strNomEnt,
                       strEndEnt,
                       strCidEnt,
                       strNivGiro: String;
                       nivEstoque: TNivelEstoque;
                       intDiaComGer: Integer;
                       intDiaComNvA: Integer;
                       intDiaComNvB: Integer;
                       intDiaComNvC: Integer;
                       fltBasCof,
                       fltValCof,
                       fltBasPis,
                       fltValPis,
                       fltBasIcm,
                       fltValIcm,
                       fltBasIpi,
                       fltBasSub: Double;
                       strPagVis: String;
                       strNumCot: String;
                       strEmpCot: String;
                       strPedBon: String;
                       strZeraST: String;
                       strDesPdi: String;
                       intMesGir: Integer;
                       strMesAtu: String;
                       strOrcOri: String;
                       fltValSis,
                       fltValMar,
                       fltDesPis: Double;
                       Var strAutInc: String;
                       strUsaGir: String;
                       blnTabRestaura: Boolean = False;
                       strCodDig: string = '';
                       strNumPok: string = '';
                       moeMoeda: TMoeda = moeReal;
                       strPreOrc: String = 'N';
                       strBStFre: String = 'S';
                       strBStAce: String = 'S';
                       strOrdCon: String = '';
                       strTipCodFabProd: String = '';
                       strObsPd4: String = '';
                       strObsPd5: String = '';
                       strObsPd6: String = '';
                       strIpiFre: String = 'N';
                       blnPagamentoCartaoCredito: Boolean = False;
                       strObs006: String = '';
                       fltValCbs: Double = 0;
                       fltValIbs: Double = 0;
                       fltVal_Is: Double = 0);
  Var
    blnLiberar: Boolean;
begin
  If Not Assigned(qryPcmGer) Then
  Begin
    qryPcmGer := fCriaQuery(Nil);
    blnLiberar := True;
  End Else
  Begin
    qryPcmGer.Close;
    qryPcmGer.SQL.Clear;
    blnLiberar := False;
  End;

  qryPcmGer.SQL.Add('INSERT INTO PCMGER' + IIF(blnTabRestaura, '_RES', '') + ' (');
  qryPcmGer.SQL.Add('  PCG_NUMPED, ');
  qryPcmGer.SQL.Add('  PCG_CODEMP, ');
  qryPcmGer.SQL.Add('  PCG_ESPDOC, ');
  qryPcmGer.SQL.Add('  PCG_CODFOR, ');
  qryPcmGer.SQL.Add('  PCG_CODTRA, ');
  qryPcmGer.SQL.Add('  PCG_CODTRR, ');
  qryPcmGer.SQL.Add('  PCG_CONPAG, ');
  qryPcmGer.SQL.Add('  PCG_DTAPED, ');
  qryPcmGer.SQL.Add('  PCG_HORENT, ');
  qryPcmGer.SQL.Add('  PCG_DTAENT, ');
  qryPcmGer.SQL.Add('  PCG_CODCMP, ');
  qryPcmGer.SQL.Add('  PCG_TOTIPI, ');
  qryPcmGer.SQL.Add('  PCG_TOTSUB, ');
  qryPcmGer.SQL.Add('  PCG_TOTDAR, ');
  qryPcmGer.SQL.Add('  PCG_SUBFCP, ');
  qryPcmGer.SQL.Add('  PCG_TOTITE, ');
  qryPcmGer.SQL.Add('  PCG_TOTGER, ');
  qryPcmGer.SQL.Add('  PCG_VALCBS, ');
  qryPcmGer.SQL.Add('  PCG_VALIBS, ');
  qryPcmGer.SQL.Add('  PCG_VAL_IS, ');
  qryPcmGer.SQL.Add('  PCG_OBS001, ');
  qryPcmGer.SQL.Add('  PCG_OBS002, ');
  qryPcmGer.SQL.Add('  PCG_OBS003, ');
  qryPcmGer.SQL.Add('  PCG_OBS004, ');
  qryPcmGer.SQL.Add('  PCG_OBS005, ');
  qryPcmGer.SQL.Add('  PCG_OBS006, ');
  qryPcmGer.SQL.Add('  PCG_OBSPD1, ');
  qryPcmGer.SQL.Add('  PCG_OBSPD2, ');
  qryPcmGer.SQL.Add('  PCG_OBSPD3, ');
  qryPcmGer.SQL.Add('  PCG_OBSPD4, ');
  qryPcmGer.SQL.Add('  PCG_OBSPD5, ');
  qryPcmGer.SQL.Add('  PCG_OBSPD6, ');
  qryPcmGer.SQL.Add('  PCG_PEDVEN, ');
  qryPcmGer.SQL.Add('  PCG_ATENCA, ');
  qryPcmGer.SQL.Add('  PCG_TIPFRE, ');
  qryPcmGer.SQL.Add('  PCG_TIPFRR, ');
  qryPcmGer.SQL.Add('  PCG_DOCORI, ');
  qryPcmGer.SQL.Add('  PCG_ORIGND, ');
  qryPcmGer.SQL.Add('  PCG_ORIGES, ');
  qryPcmGer.SQL.Add('  PCG_ORIGEP, ');

  qryPcmGer.SQL.Add('  PCG_NUMCTN, ');
  qryPcmGer.SQL.Add('  PCG_PEDIMP, ');
  qryPcmGer.SQL.Add('  PCG_PEDINT, ');
  qryPcmGer.SQL.Add('  PCG_EMPDES, ');
  qryPcmGer.SQL.Add('  PCG_DESADI, ');
  qryPcmGer.SQL.Add('  PCG_BAIXAD, ');
  qryPcmGer.SQL.Add('  AUTOINCREM, ');
  qryPcmGer.SQL.Add('  PCG_PEDMLJ, ');
  qryPcmGer.SQL.Add('  PCG_VALFRE, ');
  qryPcmGer.SQL.Add('  PCG_DESACE, ');
  qryPcmGer.SQL.Add('  PCG_DTAFAT, ');
  qryPcmGer.SQL.Add('  PCG_CODEVE, ');
  qryPcmGer.SQL.Add('  PCG_CODCTA, ');
  qryPcmGer.SQL.Add('  PCG_NOMENT, ');
  qryPcmGer.SQL.Add('  PCG_ENDENT, ');
  qryPcmGer.SQL.Add('  PCG_CIDENT, ');
  qryPcmGer.SQL.Add('  PCG_DIACOM, ');
  qryPcmGer.SQL.Add('  PCG_DIANVA, ');
  qryPcmGer.SQL.Add('  PCG_DIANVB, ');
  qryPcmGer.SQL.Add('  PCG_DIANVC, ');

  qryPcmGer.SQL.Add('  PCG_BASCOF, ');
  qryPcmGer.SQL.Add('  PCG_VALCOF, ');
  qryPcmGer.SQL.Add('  PCG_BASPIS, ');
  qryPcmGer.SQL.Add('  PCG_VALPIS, ');
  qryPcmGer.SQL.Add('  PCG_BASICM, ');
  qryPcmGer.SQL.Add('  PCG_VALICM, ');
  qryPcmGer.SQL.Add('  PCG_DESPIS, ');
  qryPcmGer.SQL.Add('  PCG_BASIPI, ');
  qryPcmGer.SQL.Add('  PCG_BASSUB, ');
  qryPcmGer.SQL.Add('  PCG_PAGVIS, ');
  qryPcmGer.SQL.Add('  PCG_NUMCOT, ');
  qryPcmGer.SQL.Add('  PCG_ORCORI, ');
  qryPcmGer.SQL.Add('  PCG_EMPCOT, ');

  qryPcmGer.SQL.Add('  PCG_VALSIS, ');
  qryPcmGer.SQL.Add('  PCG_VALMAR, ');

  qryPcmGer.SQL.Add('  PCG_PEDBON, ');
  qryPcmGer.SQL.Add('  PCG_ZERAST, ');
  qryPcmGer.SQL.Add('  PCG_DESPDI, ');

  qryPcmGer.SQL.Add('  PCG_USAGIR, ');
  qryPcmGer.SQL.Add('  PCG_MESGIR, ');
  qryPcmGer.SQL.Add('  PCG_CODDIG, ');

  qryPcmGer.SQL.Add('  PCG_PARPAD, ');
  qryPcmGer.SQL.Add('  PCG_NUMPOK, ');
  qryPcmGer.SQL.Add('  PCG_MESATU, ');
  qryPcmGer.SQL.Add('  PCG_MOEDA_, ');
  qryPcmGer.SQL.Add('  PCG_PREORC, ');
  qryPcmGer.SQL.Add('  PCG_ORDCON, ');
  qryPcmGer.SQL.Add('  PCG_BSTFRE, ');
  qryPcmGer.SQL.Add('  PCG_IPIFRE, ');
  qryPcmGer.SQL.Add('  PCG_BSTACE, ');

  qryPcmGer.SQL.Add('  PCG_TIPFAB, ');
  qryPcmGer.SQL.Add('  PCG_ADAFO1, ');
  qryPcmGer.SQL.Add('  PCG_PAGCCC  ');

  qryPcmGer.SQL.Add(') VALUES ( ');

  qryPcmGer.SQL.Add('  :NUMPED, ');
  qryPcmGer.SQL.Add('  :CODEMP, ');
  qryPcmGer.SQL.Add('  :ESPDOC, ');
  qryPcmGer.SQL.Add('  :CODFOR, ');
  qryPcmGer.SQL.Add('  :CODTRA, ');
  qryPcmGer.SQL.Add('  :CODTRR, ');
  qryPcmGer.SQL.Add('  :CONPAG, ');
  qryPcmGer.SQL.Add('  :DTAPED, ');
  qryPcmGer.SQL.Add('  :HORENT, ');
  qryPcmGer.SQL.Add('  :DTAENT, ');
  qryPcmGer.SQL.Add('  :COMPRA, ');
  qryPcmGer.SQL.Add('  :TOTIPI, ');
  qryPcmGer.SQL.Add('  :TOTSUB, ');
  qryPcmGer.SQL.Add('  :TOTDAR, ');
  qryPcmGer.SQL.Add('  :SUBFCP, ');
  qryPcmGer.SQL.Add('  :TOTITE, ');
  qryPcmGer.SQL.Add('  :TOTGER, ');
  qryPcmGer.SQL.Add('  :VALCBS, ');
  qryPcmGer.SQL.Add('  :VALIBS, ');
  qryPcmGer.SQL.Add('  :VAL_IS, ');
  qryPcmGer.SQL.Add('  :OBS001, ');
  qryPcmGer.SQL.Add('  :OBS002, ');
  qryPcmGer.SQL.Add('  :OBS003, ');
  qryPcmGer.SQL.Add('  :OBS004, ');
  qryPcmGer.SQL.Add('  :OBS005, ');
  qryPcmGer.SQL.Add('  :OBS006, ');
  qryPcmGer.SQL.Add('  :OBSPD1, ');
  qryPcmGer.SQL.Add('  :OBSPD2, ');
  qryPcmGer.SQL.Add('  :OBSPD3, ');
  qryPcmGer.SQL.Add('  :OBSPD4, ');
  qryPcmGer.SQL.Add('  :OBSPD5, ');
  qryPcmGer.SQL.Add('  :OBSPD6, ');
  qryPcmGer.SQL.Add('  :PEDVEN, ');
  qryPcmGer.SQL.Add('  :ATENCA, ');
  qryPcmGer.SQL.Add('  :TIPFRE, ');
  qryPcmGer.SQL.Add('  :TIPFRR, ');
  qryPcmGer.SQL.Add('  :DOCORI, ');
  qryPcmGer.SQL.Add('  :ORIGND, ');
  qryPcmGer.SQL.Add('  :ORIGES, ');
  qryPcmGer.SQL.Add('  :ORIGEP, ');
  qryPcmGer.SQL.Add('  :NUMCTN, ');
  qryPcmGer.SQL.Add('  :PEDIMP, ');
  qryPcmGer.SQL.Add('  :PEDINT, ');
  qryPcmGer.SQL.Add('  :EMPDES, ');
  qryPcmGer.SQL.Add('  :DESADI, ');
  qryPcmGer.SQL.Add('  :BAIXAD, ');
  qryPcmGer.SQL.Add('  :AUTINC, ');
  qryPcmGer.SQL.Add('  :PEDMLJ, ');
  qryPcmGer.SQL.Add('  :VALFRE, ');
  qryPcmGer.SQL.Add('  :DESACE, ');
  qryPcmGer.SQL.Add('  :DTAFAT, ');
  qryPcmGer.SQL.Add('  :CODEVE, ');
  qryPcmGer.SQL.Add('  :CODCTA, ');
  qryPcmGer.SQL.Add('  :NOMENT, ');
  qryPcmGer.SQL.Add('  :ENDENT, ');
  qryPcmGer.SQL.Add('  :CIDENT, ');
  qryPcmGer.SQL.Add('  :DIACOM, ');
  qryPcmGer.SQL.Add('  :DIANVA, ');
  qryPcmGer.SQL.Add('  :DIANVB, ');
  qryPcmGer.SQL.Add('  :DIANVC, ');

  qryPcmGer.SQL.Add('  :BASCOF, ');
  qryPcmGer.SQL.Add('  :VALCOF, ');
  qryPcmGer.SQL.Add('  :BASPIS, ');
  qryPcmGer.SQL.Add('  :VALPIS, ');
  qryPcmGer.SQL.Add('  :BASICM, ');
  qryPcmGer.SQL.Add('  :VALICM, ');
  qryPcmGer.SQL.Add('  :DESPIS, ');
  qryPcmGer.SQL.Add('  :BASIPI, ');
  qryPcmGer.SQL.Add('  :BASSUB, ');
  qryPcmGer.SQL.Add('  :PAGVIS, ');
  qryPcmGer.SQL.Add('  :NUMCOT, ');
  qryPcmGer.SQL.Add('  :ORCORI, ');
  qryPcmGer.SQL.Add('  :EMPCOT, ');
  qryPcmGer.SQL.Add('  :VALSIS, ');
  qryPcmGer.SQL.Add('  :VALMAR, ');

  qryPcmGer.SQL.Add('  :PEDBON, ');
  qryPcmGer.SQL.Add('  :ZERAST, ');
  qryPcmGer.SQL.Add('  :DESPDI, ');

  qryPcmGer.SQL.Add('  :USAGIR, ');
  qryPcmGer.SQL.Add('  :MESGIR, ');
  qryPcmGer.SQL.Add('  :CODDIG, ');

  qryPcmGer.SQL.Add('  :PARPAD, ');
  qryPcmGer.SQL.Add('  :NUMPOK, ');
  qryPcmGer.SQL.Add('  :MESATU, ');
  qryPcmGer.SQL.Add('  :MOEDA_, ');
  qryPcmGer.SQL.Add('  :PREORC, ');
  qryPcmGer.SQL.Add('  :ORDCON, ');
  qryPcmGer.SQL.Add('  :BSTFRE, ');
  qryPcmGer.SQL.Add('  :IPIFRE, ');
  qryPcmGer.SQL.Add('  :BSTACE, ');

  qryPcmGer.SQL.Add('  :TIPFAB, ');
  qryPcmGer.SQL.Add('  :ADAFO1, ');
  qryPcmGer.SQL.Add('  :PAGCCC   ');
  qryPcmGer.SQL.Add('  ) ');

  qryPcmGer.ParamByName('USAGIR').AsString   := strUsaGir;
  qryPcmGer.ParamByName('ADAFO1').AsString   := IIf(AblnSomaDescontoAdcionalFornecedor1, 'S', 'N');

  qryPcmGer.ParamByName('ORDCON').AsString   := strOrdCon;

  qryPcmGer.ParamByName('NUMPED').AsString   := strNumPed;
  qryPcmGer.ParamByName('CODEMP').AsString   := strCodEmp;
  qryPcmGer.ParamByName('ESPDOC').AsString   := strEspDoc;
  qryPcmGer.ParamByName('CODFOR').AsString   := strCodFor;

  If Not fEmptyStr(strCodTra) Then
    qryPcmGer.ParamByName('CODTRA').AsString := strCodTra
  Else
    qryPcmGer.ParamByName('CODTRA').Value := Null;

  If Not fEmptyStr(strCodTraRedespacho) Then
    qryPcmGer.ParamByName('CODTRR').AsString := strCodTraRedespacho
  Else
    qryPcmGer.ParamByName('CODTRR').Value := Null;

  qryPcmGer.ParamByName('CONPAG').AsString   := fTiraCaracEspeciais(strConPag);
  qryPcmGer.ParamByName('DTAPED').AsDateTime := dtaDtaPed;
  qryPcmGer.ParamByName('DTAFAT').AsDateTime := dtaDtaFat;
  qryPcmGer.ParamByName('HORENT').AsDateTime := horHorEnt;
  qryPcmGer.ParamByName('DTAENT').AsDateTime := dtaDtaEnt;

  If fEmptyStr(strCompra) Then
    qryPcmGer.ParamByName('COMPRA').Value := Null
  Else
    qryPcmGer.ParamByName('COMPRA').AsString := strCompra;

  qryPcmGer.ParamByName('TOTIPI').AsFloat    := fltTotIpi;
  qryPcmGer.ParamByName('TOTSUB').AsFloat    := fltTotSub;
  qryPcmGer.ParamByName('TOTDAR').AsFloat    := fltTotDar;
  qryPcmGer.ParamByName('SUBFCP').AsFloat    := fltSubFCP;
  qryPcmGer.ParamByName('TOTITE').AsFloat    := fltTotIte;
  qryPcmGer.ParamByName('TOTGER').AsFloat    := fltTotGer;
  qryPcmGer.ParamByName('VALCBS').AsFloat    := fltValCbs;
  qryPcmGer.ParamByName('VALIBS').AsFloat    := fltValIbs;
  qryPcmGer.ParamByName('VAL_IS').AsFloat    := fltVal_Is;
  qryPcmGer.ParamByName('OBS001').AsString   := strObs001;
  qryPcmGer.ParamByName('OBS002').AsString   := strObs002;
  qryPcmGer.ParamByName('OBS003').AsString   := strObs003;
  qryPcmGer.ParamByName('OBS004').AsString   := strObs004;
  qryPcmGer.ParamByName('OBS005').AsString   := strObs005;
  qryPcmGer.ParamByName('OBS006').AsString   := strObs006;
  qryPcmGer.ParamByName('OBSPD1').AsString   := strObsPd1;
  qryPcmGer.ParamByName('OBSPD2').AsString   := strObsPd2;
  qryPcmGer.ParamByName('OBSPD3').AsString   := strObsPd3;
  qryPcmGer.ParamByName('OBSPD4').AsString   := strObsPd4;
  qryPcmGer.ParamByName('OBSPD5').AsString   := strObsPd5;
  qryPcmGer.ParamByName('OBSPD6').AsString   := strObsPd6;
  qryPcmGer.ParamByName('PEDVEN').AsString   := strPedVen;
  qryPcmGer.ParamByName('ATENCA').AsString   := strAtenca;
  qryPcmGer.ParamByName('TIPFRE').AsString   := strTipFre;
  qryPcmGer.ParamByName('TIPFRR').AsString   := strTipFreRedespacho;
  qryPcmGer.ParamByName('DOCORI').AsString   := strDocOri;
  If strDocOri <> '' Then
  begin
    qryPcmGer.ParamByName('ORIGND').AsString :=  Copy(strDocOri, 1 , 12);
    qryPcmGer.ParamByName('ORIGES').AsString :=  Copy(strDocOri, 13 , 2);
    qryPcmGer.ParamByName('ORIGEP').AsString :=  Copy(strDocOri, 15 , 18);
  End;

  qryPcmGer.ParamByName('NUMCTN').AsInteger  := intNumCtn;
  qryPcmGer.ParamByName('PEDIMP').AsString   := strPedImp;
  qryPcmGer.ParamByName('PEDINT').AsString   := strPedInt;

  If fEmptyStr(strEmpDes) Then
    qryPcmGer.ParamByName('EMPDES').Value    := Null
  Else
    qryPcmGer.ParamByName('EMPDES').AsString := strEmpDes;

  qryPcmGer.ParamByName('DESADI').AsFloat    := fltDesAdi;
  qryPcmGer.ParamByName('BAIXAD').AsInteger  := 0;

  If Not blnTabRestaura Then
  Begin
    qryPcmGer.ParamByName('AUTINC').AsString   := fRetAutoIncrem('PCMGER' + IIF(blnTabRestaura, '_RES', ''), VS_strCodEmp);
    strAutInc := qryPcmGer.ParamByName('AUTINC').AsString;
  End
  Else If fEmptystr(strAutInc) Then
    qryPcmGer.ParamByName('AUTINC').Clear;

  qryPcmGer.ParamByName('PEDMLJ').AsString   := strPedMlj;
  qryPcmGer.ParamByName('VALFRE').AsFloat    := fltValFre;
  qryPcmGer.ParamByName('DESACE').AsFloat    := fltDesAce;

  If fEmptyStr(strCodEve) Then
    qryPcmGer.ParamByName('CODEVE').Value    := Null
  Else
    qryPcmGer.ParamByName('CODEVE').AsString := strCodEve;

  qryPcmGer.ParamByName('CODCTA').AsString   := strCodCta;

  If fEmptyStr(strCodCta) Then
    qryPcmGer.ParamByName('CODCTA').Clear;

  qryPcmGer.ParamByName('NOMENT').AsString   := strNomEnt;
  qryPcmGer.ParamByName('ENDENT').AsString   := strEndEnt;
  qryPcmGer.ParamByName('CIDENT').AsString   := strCidEnt;

  If nivEstoque = nivNenhum Then
    qryPcmGer.ParamByName('DIACOM').AsInteger := intDiaComGer
  Else
  Begin
    If Pos('A', strNivGiro) > 0 Then
      qryPcmGer.ParamByName('DIANVA').AsInteger := intDiaComNvA;

    If Pos('B', strNivGiro) > 0 Then
      qryPcmGer.ParamByName('DIANVB').AsInteger := intDiaComNvB;

    If Pos('C', strNivGiro) > 0 Then
      qryPcmGer.ParamByName('DIANVC').AsInteger := intDiaComNvC;
  End;

  qryPcmGer.ParamByName('BASCOF').AsFloat    := fltBasCof;
  qryPcmGer.ParamByName('VALCOF').AsFloat    := fltValCof;
  qryPcmGer.ParamByName('BASPIS').AsFloat    := fltBasPis;
  qryPcmGer.ParamByName('VALPIS').AsFloat    := fltValPis;
  qryPcmGer.ParamByName('BASICM').AsFloat    := fltBasIcm;
  qryPcmGer.ParamByName('VALICM').AsFloat    := fltValIcm;
  qryPcmGer.ParamByName('DESPIS').AsFloat    := fltDesPis;
  qryPcmGer.ParamByName('BASIPI').AsFloat    := fltBasIpi;
  qryPcmGer.ParamByName('BASSUB').AsFloat    := fltBasSub;
  qryPcmGer.ParamByName('PAGVIS').AsString   := strPagVis;
  qryPcmGer.ParamByName('NUMCOT').AsString   := strNumCot;
  qryPcmGer.ParamByName('EMPCOT').AsString   := strEmpCot;
  qryPcmGer.ParamByName('ORCORI').AsString   := strOrcOri;

  If fEmptyStr(strNumCot) Then
  Begin
    qryPcmGer.ParamByName('NUMCOT').Clear;
    qryPcmGer.ParamByName('EMPCOT').Clear;
  End;

  If fEmptyStr(strPedBon) Then
    strPedBon := 'N';
  qryPcmGer.ParamByName('PEDBON').AsString   := strPedBon;

  If fEmptyStr(strZeraST) Then
    strZeraST := 'N';
  qryPcmGer.ParamByName('ZERAST').AsString   := strZeraST;


  If fEmptyStr(strDesPdi) Then
    strDesPdi := 'P';
  qryPcmGer.ParamByName('DESPDI').AsString   := strDesPdi;

  If fEmptyStr(strCodDig) Then
    qryPcmGer.ParamByName('CODDIG').Clear
  Else
    qryPcmGer.ParamByName('CODDIG').AsString   := strCodDig;

  qryPcmGer.ParamByName('MESGIR').AsInteger  := intMesGir;
  qryPcmGer.ParamByName('MESATU').AsString   := strMesAtu;

  qryPcmGer.ParamByName('VALSIS').AsFloat    := fltValSis;
  qryPcmGer.ParamByName('VALMAR').AsFloat    := fltValMar;

  If Assigned(objParcelas) And objParcelas.blnManterValoresPadrao Then
    qryPcmGer.ParamByName('PARPAD').AsString := 'S'
  Else
    qryPcmGer.ParamByName('PARPAD').AsString := 'N';

  If fEmptyStr(strNumPok) Then
    qryPcmGer.ParamByName('NUMPOK').Value    := Null
  Else
    qryPcmGer.ParamByName('NUMPOK').AsString := strNumPok;

  Case moeMoeda Of
    moeDolar: qryPcmGer.ParamByName('MOEDA_').AsInteger  := INT_MOEDA_DOLAR;
    Else      qryPcmGer.ParamByName('MOEDA_').AsInteger  := INT_MOEDA_REAL;
  End;

  qryPcmGer.ParamByName('PREORC').AsString   := strPreOrc;

  If strBStFre.IsEmpty Then
    strBStFre := 'S';

  If strIpiFre.IsEmpty Then
    strIpiFre := 'N';

  If strBStAce.IsEmpty Then
    strBStAce := 'S';

  qryPcmGer.ParamByName('BSTFRE').AsString   := strBStFre;
  qryPcmGer.ParamByName('BSTACE').AsString   := strBStAce;
  qryPcmGer.ParamByName('IPIFRE').AsString   := strIPIFre;

  If fEmptyStr(strTipCodFabProd) Then
    qryPcmGer.ParamByName('TIPFAB').Value    := Null
  Else
    qryPcmGer.ParamByName('TIPFAB').AsString := strTipCodFabProd;

  qryPcmGer.ParamByName('PAGCCC').AsBoolean := blnPagamentoCartaoCredito;

  qryPcmGer.ExecSQL;

  If blnTabRestaura Then
    strAutInc := fLastInsertID

  Else If Assigned(objParcelas) Then
    objParcelas.pGravaParcelas(strAutInc, strConPag, strCodFor, fltTotGer, fltTotIte, dtaDtaPed);

  If blnLiberar Then
    FreeAndNil(qryPcmGer);
end;

procedure pAtualizaPcmGer(AblnSomaDescontoAdcionalFornecedor1: Boolean;
                          qryGenGer: TUniQuery;
                          objParcelas: TDuplicatasPedidoCompra;
                          strNumPed,
                          strCodEmp,
                          strEspDoc,
                          strCodFor,
                          strCodTra,
                          strCodTraRedespacho,
                          strConPag: String;
                          dtaDtaPed,
                          horHorPed,
                          dtaDtaEnt: TDateTime;
                          strCompra: String;
                          fltTotIpi,
                          fltTotSub,
                          fltTotDar,
                          fltSubFCP,
                          fltTotIte,
                          fltTotGer: Double;
                          strObs001,
                          strObs002,
                          strObs003,
                          strObs004,
                          strObs005,
                          strObsPd1,
                          strObsPd2,
                          strObsPd3,
                          strPedVen,
                          strAtenca,
                          strTipFre: String;
                          strTipFreRedespacho: String;
                          fltDesAdi,
                          fltValFre,
                          fltDesAce: Double;
                          strPedImp,
                          strPedInt: String;
                          dtaDtaFat: TDate;
                          strCodEve,
                          strCodCta: String;
                          strNomEnt,
                          strEndEnt,
                          strCidEnt: String;
                          fltBasCof,
                          fltValCof,
                          fltBasPis,
                          fltValPis,
                          fltBasIcm,
                          fltValIcm,
                          fltBasIpi,
                          fltBasSub: Double;
                          strPagVis,
                          strPedBon,
                          strZeraST,
                          strDesPdi: String;
                          fltValSis,
                          fltValMar,
                          fltDesPis: Double;
                          blnTabRestaura: Boolean = False;
                          strAutInc: String = '';
                          strCodDig: String = '';
                          moeMoeda: TMoeda = moeReal;
                          strBStFre: String = 'S';
                          strBStAce: String = 'S';
                          strOrdCon: String = '';
                          strTipCodFabProd: String = '';
                          strObsPd4: String = '';
                          strObsPd5: String = '';
                          strObsPd6: String = '';
                          strIpiFre: String = 'N';
                          blnPagamentoCartaoCredito: Boolean = False;
                          strObs006: String = '';
                          fltValCbs: Double = 0;
                          fltValIbs: Double = 0;
                          fltVal_Is: Double = 0);
  Var
    strSQL: String;
    blnLiberarQuery: Boolean;
begin
  If Not Assigned(qryGenGer) Then
  Begin
    qryGenGer := fCriaQuery(Nil);
    blnLiberarQuery := True;
  End Else
  Begin
    qryGenGer.SQL.Clear;
    qryGenGer.Close;
    blnLiberarQuery := False;
  End;

  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  PCMGER' + IIF(blnTabRestaura, '_RES', ' ');
  strSQL := strSQL + ' SET ';
  strSQL := strSQL + '  PCG_CODFOR = :CODFOR, ';
  strSQL := strSQL + '  PCG_CODTRA = :CODTRA, ';
  strSQL := strSQL + '  PCG_CODTRR = :CODTRR, ';
  strSQL := strSQL + '  PCG_CONPAG = :CONPAG, ';
  strSQL := strSQL + '  PCG_DTAENT = :DTAENT, ';
  strSQL := strSQL + '  PCG_HORENT = :HORENT, ';
  strSQL := strSQL + '  PCG_DTAPED = :DTAPED, ';
  strSQL := strSQL + '  PCG_CODCMP = :COMPRA, ';
  strSQL := strSQL + '  PCG_TOTIPI = :TOTIPI, ';
  strSQL := strSQL + '  PCG_TOTSUB = :TOTSUB, ';
  strSQL := strSQL + '  PCG_TOTDAR = :TOTDAR, ';
  strSQL := strSQL + '  PCG_SUBFCP = :SUBFCP, ';
  strSQL := strSQL + '  PCG_TOTITE = :TOTITE, ';
  strSQL := strSQL + '  PCG_TOTGER = :TOTGER, ';
  strSQL := strSQL + '  PCG_VALCBS = :VALCBS, ';
  strSQL := strSQL + '  PCG_VALIBS = :VALIBS, ';
  strSQL := strSQL + '  PCG_VAL_IS = :VAL_IS, ';
  strSQL := strSQL + '  PCG_OBS001 = :OBS001, ';
  strSQL := strSQL + '  PCG_OBS002 = :OBS002, ';
  strSQL := strSQL + '  PCG_OBS003 = :OBS003, ';
  strSQL := strSQL + '  PCG_OBS004 = :OBS004, ';
  strSQL := strSQL + '  PCG_OBS005 = :OBS005, ';
  strSQL := strSQL + '  PCG_OBS006 = :OBS006, ';
  strSQL := strSQL + '  PCG_OBSPD1 = :OBSPD1, ';
  strSQL := strSQL + '  PCG_OBSPD2 = :OBSPD2, ';
  strSQL := strSQL + '  PCG_OBSPD3 = :OBSPD3, ';
  strSQL := strSQL + '  PCG_OBSPD4 = :OBSPD4, ';
  strSQL := strSQL + '  PCG_OBSPD5 = :OBSPD5, ';
  strSQL := strSQL + '  PCG_OBSPD6 = :OBSPD6, ';
  strSQL := strSQL + '  PCG_PEDVEN = :PEDVEN, ';
  strSQL := strSQL + '  PCG_ATENCA = :ATENCA, ';
  strSQL := strSQL + '  PCG_TIPFRE = :TIPFRE, ';
  strSQL := strSQL + '  PCG_TIPFRR = :TIPFRR, ';
  strSQL := strSQL + '  PCG_DESADI = :DESADI, ';
  strSQL := strSQL + '  PCG_VALFRE = :VALFRE, ';
  strSQL := strSQL + '  PCG_DESACE = :DESACE, ';
  strSQL := strSQL + '  PCG_PEDIMP = :PEDIMP, ';
  strSQL := strSQL + '  PCG_PEDINT = :PEDINT, ';
  strSQL := strSQL + '  PCG_PEDLIB = NULL,    ';
  strSQL := strSQL + '  PCG_DTAFAT = :DTAFAT, ';
  strSQL := strSQL + '  PCG_CODEVE = :CODEVE, ';
  strSQL := strSQL + '  PCG_CODCTA = :CODCTA, ';
  strSQL := strSQL + '  PCG_NOMENT = :NOMENT, ';
  strSQL := strSQL + '  PCG_ENDENT = :ENDENT, ';
  strSQL := strSQL + '  PCG_CIDENT = :CIDENT, ';

  strSQL := strSQL + '  PCG_BASCOF = :BASCOF, ';
  strSQL := strSQL + '  PCG_VALCOF = :VALCOF, ';
  strSQL := strSQL + '  PCG_BASPIS = :BASPIS, ';
  strSQL := strSQL + '  PCG_VALPIS = :VALPIS, ';
  strSQL := strSQL + '  PCG_BASICM = :BASICM, ';
  strSQL := strSQL + '  PCG_VALICM = :VALICM, ';
  strSQL := strSQL + '  PCG_DESPIS = :DESPIS, ';
  strSQL := strSQL + '  PCG_BASIPI = :BASIPI, ';
  strSQL := strSQL + '  PCG_BASSUB = :BASSUB, ';
  strSQL := strSQL + '  PCG_PAGVIS = :PAGVIS, ';
  strSQL := strSQL + '  PCG_PEDBON = :PEDBON, ';
  strSQL := strSQL + '  PCG_ZERAST = :ZERAST, ';
  strSQL := strSQL + '  PCG_DESPDI = :DESPDI, ';
  strSQL := strSQL + '  PCG_VALSIS = :VALSIS, ';
  strSQL := strSQL + '  PCG_CODDIG = :CODDIG, ';
  strSQL := strSQL + '  PCG_PARPAD = :PARPAD, ';
  strSQL := strSQL + '  PCG_VALMAR = :VALMAR, ';
  strSQL := strSQL + '  PCG_MOEDA_ = :MOEDA_, ';
  strSQL := strSQL + '  PCG_ORDCON = :ORDCON, ';
  strSQL := strSQL + '  PCG_BSTFRE = :BSTFRE, ';
  strSQL := strSQL + '  PCG_BSTACE = :BSTACE, ';
  strSQL := strSQL + '  PCG_IPIFRE = :IPIFRE, ';
  strSQL := strSQL + '  PCG_TIPFAB = :TIPFAB, ';
  strSQL := strSQL + '  PCG_ADAFO1 = :ADAFO1, ';
  strSQL := strSQL + '  PCG_PAGCCC = :PAGCCC  ';
  strSQL := strSQL + 'WHERE ';

  If blnTabRestaura Then
  Begin
    strSQL := strSQL + '  AUTOINCREM = :AUTINC ';
  End Else
  Begin
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCG_ESPDOC = :ESPDOC ';
  End;

  With qryGenGer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    {*****************************************}
    {* DADOS QUE SERÃO ATUALIZADOS           *}
    {**************************************MV*}
    ParamByName('CODFOR').AsString   := strCodFor;

    ParamByName('ORDCON').AsString   := strOrdCon;
    ParamByName('ADAFO1').AsString   := IIf(AblnSomaDescontoAdcionalFornecedor1, 'S', 'N');

    If fEmptyStr(strCodTra) Then
      ParamByName('CODTRA').Value := Null
    Else
      ParamByName('CODTRA').AsString := strCodTra;

    If fEmptyStr(strCodTraRedespacho) Then
      ParamByName('CODTRR').Value := Null
    Else
      ParamByName('CODTRR').AsString := strCodTraRedespacho;


    ParamByName('CONPAG').AsString   := fTiraCaracEspeciais(strConPag);
    ParamByName('DTAENT').AsDateTime := dtaDtaEnt;  // DATA DO PEDIDO
    ParamByName('HORENT').AsDateTime := horHorPed;  // HORA DO PEDIDO
    ParamByName('DTAPED').AsDateTime := dtaDtaPed;  // DATA DE ENTREGA
    ParamByName('DTAFAT').AsDateTime := dtaDtaFat;  // DATA DE FATURAMENTO

    If fEmptyStr(strCompra) Then
      ParamByName('COMPRA').Value := Null
    Else
      ParamByName('COMPRA').AsString := strCompra;

    ParamByName('TOTIPI').AsFloat    := fltTotIpi;
    ParamByName('TOTSUB').AsFloat    := fltTotSub;
    ParamByName('TOTDAR').AsFloat    := fltTotDar;
    ParamByName('SUBFCP').AsFloat    := fltSubFCP;
    ParamByName('TOTITE').AsFloat    := fltTotIte;
    ParamByName('TOTGER').AsFloat    := fltTotGer;
    ParamByName('VALCBS').AsFloat    := fltValCbs;
    ParamByName('VALIBS').AsFloat    := fltValIbs;
    ParamByName('VAL_IS').AsFloat    := fltVal_Is;
    ParamByName('OBS001').AsString   := strObs001;
    ParamByName('OBS002').AsString   := strObs002;
    ParamByName('OBS003').AsString   := strObs003;
    ParamByName('OBS004').AsString   := strObs004;
    ParamByName('OBS005').AsString   := strObs005;
    ParamByName('OBS006').AsString   := strObs006;
    ParamByName('OBSPD1').AsString   := strObsPd1;
    ParamByName('OBSPD2').AsString   := strObsPd2;
    ParamByName('OBSPD3').AsString   := strObsPd3;
    ParamByName('OBSPD4').AsString   := strObsPd4;
    ParamByName('OBSPD5').AsString   := strObsPd5;
    ParamByName('OBSPD6').AsString   := strObsPd6;

    If fEmptyStr(strPedVen) Then
      ParamByName('PEDVEN').Value    := Null
    Else
      ParamByName('PEDVEN').AsString := strPedVen;

    ParamByName('ATENCA').AsString   := strAtenca;
    ParamByName('TIPFRE').AsString   := strTipFre;
    ParamByName('TIPFRR').AsString   := strTipFreRedespacho;
    ParamByName('DESADI').AsFloat    := fltDesAdi;

    ParamByName('VALFRE').AsFloat    := fltValFre;
    ParamByName('DESACE').AsFloat    := fltDesAce;

    {*****************************************}
    {* DADOS DO FILTRO                       *}
    {**************************************MV*}

    If blnTabRestaura Then
    Begin
      ParamByName('AUTINC').AsString   := strAutInc;
    End Else
    Begin
      ParamByName('NUMPED').AsString   := strNumPed;
      ParamByName('CODEMP').AsString   := strCodEmp;
      ParamByName('ESPDOC').AsString   := strEspDoc;
    End;

    ParamByName('PEDIMP').AsString   := strPedImp;
    ParamByName('PEDINT').AsString   := strPedInt;

    If fEmptyStr(strCodEve) Then
      ParamByName('CODEVE').Value    := Null
    Else
      ParamByName('CODEVE').AsString := strCodEve;

    ParamByName('CODCTA').AsString   := strCodCta;

    If fEmptyStr(strCodCta) Then
      ParamByName('CODCTA').Clear;

    ParamByName('NOMENT').AsString   := strNomEnt;
    ParamByName('ENDENT').AsString   := strEndEnt;
    ParamByName('CIDENT').AsString   := strCidEnt;

    ParamByName('BASCOF').AsFloat    := fltBasCof;
    ParamByName('VALCOF').AsFloat    := fltValCof;
    ParamByName('BASPIS').AsFloat    := fltBasPis;
    ParamByName('VALPIS').AsFloat    := fltValPis;
    ParamByName('BASICM').AsFloat    := fltBasIcm;
    ParamByName('VALICM').AsFloat    := fltValIcm;
    ParamByName('DESPIS').AsFloat    := fltDesPis;
    ParamByName('BASIPI').AsFloat    := fltBasIpi;
    ParamByName('BASSUB').AsFloat    := fltBasSub;
    ParamByName('PAGVIS').AsString   := strPagVis;

    ParamByName('VALSIS').AsFloat    := fltValSis;
    ParamByName('VALMAR').AsFloat    := fltValMar;

    If fEmptyStr(strPedBon) Then
      strPedBon := 'N';
    ParamByName('PEDBON').AsString   := strPedBon;

    If fEmptyStr(strZeraST) Then
      strPedBon := 'N';
    ParamByName('ZERAST').AsString   := strZeraST;

    If fEmptyStr(strDesPdi) Then
      strDesPdi := 'P';
    ParamByName('DESPDI').AsString   := strDesPdi;

    If fEmptyStr(strCodDig) Then
      ParamByName('CODDIG').Clear
    Else
      ParamByName('CODDIG').AsString   := strCodDig;

    If Assigned(objParcelas) And objParcelas.blnManterValoresPadrao Then
      ParamByName('PARPAD').AsString := 'S'
    Else
      ParamByName('PARPAD').AsString := 'N';

    Case moeMoeda Of
      moeDolar: ParamByName('MOEDA_').AsInteger  := INT_MOEDA_DOLAR;
      Else      ParamByName('MOEDA_').AsInteger  := INT_MOEDA_REAL;
    End;

    If strBStFre.IsEmpty Then
      strBStFre := 'S';

    If strIPIFre.IsEmpty Then
      strIPIFre := 'N';

    If strBStAce.IsEmpty Then
      strBStAce := 'S';

    ParamByName('BSTFRE').AsString   := strBStFre;
    ParamByName('IPIFRE').AsString   := strIPIFre;
    ParamByName('BSTACE').AsString   := strBStAce;

    If fEmptyStr(strTipCodFabProd) Then
      ParamByName('TIPFAB').Value    := Null
    Else
      ParamByName('TIPFAB').AsString := strTipCodFabProd;

    ParamByName('PAGCCC').AsBoolean := blnPagamentoCartaoCredito;

    ExecSQL;

    If (Not blnTabRestaura) And Assigned(objParcelas) Then
      objParcelas.pGravaParcelas(strAutInc, strConPag, strCodFor, fltTotGer, fltTotIte, dtaDtaPed);

    Close;
  End;

  If blnLiberarQuery Then
    FreeAndNil(qryGenGer);
end;

Function fSQLGravaRequisicao(blnTabRestaura: Boolean; strAutIncIRQ_comma, strAutIncPCMDET: String; strAutoIncPCMGER: String): String;
  Var
    stlAutIncIRQ: TStringList;
    strSeqReq: String;
Begin
  Result := '';

  stlAutIncIRQ := TStringList.Create;
  Try

    stlAutIncIRQ.CommaText := strAutIncIRQ_comma;
    For strSeqReq In stlAutIncIRQ Do
    Begin
      Result := Result + ' REPLACE INTO PCMIRQ' + IIF(blnTabRestaura, '_RES', ' ') + ' (';

      If blnTabRestaura Then
        Result := Result + '  EXCLUIDO,';

      Result := Result + '  PCM_SEQDET,';
      Result := Result + '  PCM_SEQREQ,';
      Result := Result + '  PCM_SEQPCG';
      Result := Result + ') VALUES (';

      If blnTabRestaura Then
      Begin
        Result := Result + ' "N", ';
        Result := Result + strAutIncPCMDET  + ', '
      End Else
      Begin
        Result := Result + '  ' + QuotedStr(strAutIncPCMDET)+ ',';
      End;

      Result := Result + ' ' + QuotedStr(strSeqReq) + ', ' + QuotedStr(strAutoIncPCMGER) + '); ';

      If Not blnTabRestaura Then
      Begin
         {Incluído validação do código do item para não ocorrero caso do Req: 328907}
         Result := Result + ' UPDATE MOVRCD SET RCD_SEQPCD = IF(RCD_ATETRA = 1, NULL, ' + QuotedStr(strAutIncPCMDET) + ') WHERE AUTOINCREM = ' + QuotedStr(strSeqReq);
         Result := Result + ' AND RCD_CODITE = (SELECT PCD_CODITE FROM PCMDET WHERE AUTOINCREM  = '+ QuotedStr(strAutIncPCMDET)  + ' ) ; ' ;
         Result := Result + ' DELETE FROM PCMIRQ WHERE PCM_SEQREQ = ' + QuotedStr(strSeqReq) + ' AND (SELECT RCD_ATETRA FROM MOVRCD R WHERE R.AUTOINCREM = ' + QuotedStr(strSeqReq) + ') = 1; ';
         {Exclui o registro na PCMIRQ caso o update acima falhe}
         Result := Result + ' DELETE FROM PCMIRQ WHERE PCM_SEQREQ = ' + QuotedStr(strSeqReq) + ' AND (SELECT COUNT(1) FROM MOVRCD R WHERE R.AUTOINCREM = ' + QuotedStr(strSeqReq) +' AND RCD_SEQPCD IS NULL) = 1 ;';
      End;

    End;

  Finally
    FreeAndNil(stlAutIncIRQ);
  End;

End;

function fAutoincremPerteceAoNumPed(AAutIncPcd, ANumPed, ACodEmp, AEspDoc: String): Boolean;
var qryValida: TUniQuery;
begin
  Result := True;
  qryValida := fCriaQuery;
  Try
    qryValida.SQL.Add('SELECT PCD_NUMPED, PCD_CODEMP, PCD_ESPDOC FROM PCMDET WHERE AUTOINCREM = "'+AAutIncPcd+'"');
    qryValida.Open;

    If qryValida.IsEmpty Then
      Exit;


    Result := (ANumPed = qryValida.FieldByName('PCD_NUMPED').AsString) And
              (ACodEmp = qryValida.FieldByName('PCD_CODEMP').AsString) And
              (AEspDoc = qryValida.FieldByName('PCD_ESPDOC').AsString);



  Finally
    FreeAndNil(qryValida)
  End;
End;

function fGravaPcmDet(Var intQtdConCol: Integer;
                       qryColeta: TUniQuery;
                       blnUsaColeta: Boolean;
                       strEmpDes,
                       strCampoSaldoSub,
                       strCampoSaldoAdd: String;
                       intDeqTpc: Integer;
                       strNumPed,
                       strCodEmp,
                       strEspDoc,
                       strCodFor,
                       strCodIte: String;
                       strCodUni: String;
                       dtaDtaEnt,
                       horHorPed,
                       dtaDtaPed: TDateTime;
                       strConPag,
                       strDesIte: String;
                       fltQtdIte,
                       fltUnitar,
                       fltDesUni,
                       fltDesUn2,
                       fltDesUn3,
                       fltDesUn4,
                       fltDesUn5,
                       fltDesUn6,
                       fltTotIte,
                       fltPerIpi,
                       fltTotIpi,
                       fltPerSub,
                       fltTotSub,
                       fltTotDar,
                       fltPerFCP,
                       fltSubFCP,
                       fltQtdBai,
                       fltTotBai,
                       fltIpiBai,
                       fltSubBai,
                       fltDarBai,
                       fltFCPBai,
                       fltFreBai,
                       fltAceBai,
                       fltValFre,
                       fltDesAce: Double;
                       intBaixad: Integer;
                       strDocOri: String;
                       intNumCtn: Integer;
                       strPedImp,
                       strPedInt,
                       strPedTxt: String;
                       fltQTDINC: Double;
                       fltTRAINC: Double;
                       Var strAutIncPcd: String;
                       strCodAca,
                       strEmpAca,
                       strProAca: String;
                       fltQtdCon,
                       fltBasSub,
                       fltBasIPI,
                       fltBasIcm,
                       fltPerBas,
                       fltAlqIcm,
                       fltValIcm: Double;
                       blnIncPis: Boolean;
                       strAutIncIRQ_comma: String;
                       fltAlqPis,
                       fltAlqCof,
                       fltAlqImp,
                       fltValImp,
                       fltValSis,
                       fltValMar: Double;
                       strFatDor: string;
                       fltEmbala: Double;
                       fltALPISP,
                       fltALCOFP: Double;
                       strSubUsu: String;
                       fltDesPis: Double;
                       blnTabRestaura: Boolean = False;
                       strSeqGer: String = '';
                       blnInsere: Boolean = True;
                       strAutoin: String = '';
                       blnVeioAutIncPcdInclusao: Boolean = False;
                       fltQtdOrc: Double = -1;
                       dtaDatEdt: TDateTime = 0;
                       fltUniLiq: Double = 0;
                       fltAlqCbs: Double = 0;
                       fltAlqIbs: Double = 0;
                       fltAlq_Is: Double = 0;
                       fltValCbs: Double = 0;
                       fltValIbs: Double = 0;
                       fltVal_Is: Double = 0): string;
  Var
    strSQL: String;
    qryColetaAux: TUniQuery;
    objMontaSQLPedidoCompra : TMontaSQLPedidoCompra;

  procedure pGravarIRQ(strAutIncPCMDET: String);
    Var
      qryMovRcd: TUniQuery;
  Begin

    If fEmptyStr(strAutIncIRQ_comma) Then
    Begin

      If blnTabRestaura Then
      Begin
        If Not blnInsere Then
          Result := Result + ' DELETE FROM PCMIRQ_RES WHERE PCM_SEQDET = ' + strAutIncPCMDET + '; ';
      End;

      If Not blnTabRestaura Then
      Begin

        qryMovRcd := fCriaQuery();
        Try
          qryMovRcd.SQL.Add('SELECT AUTOINCREM FROM MOVRCD WHERE RCD_SEQPCD = :SEQPCD');
          qryMovRcd.ParamByName('SEQPCD').AsString := strAutIncPCMDET;
          qryMovRcd.Open();

          While (Not qryMovRcd.Eof) Do
          Begin
            Result := Result + 'UPDATE MOVRCD SET RCD_SEQPCD = NULL '+
                      'WHERE AUTOINCREM = ' + QuotedStr(qryMovRcd.FieldByName('AUTOINCREM').AsString) +
                      '  AND RCD_SEQPCD = ' + QuotedStr(strAutIncPCMDET) + ';';

            If blnUsaColeta Then
              Result := Result + TMontaSQLPedidoCompra.fRemoveControleDeColeta(strAutIncPCMDET, qryMovRcd.FieldByName('AUTOINCREM').AsString);

            qryMovRcd.Next();
          End;

          Result := Result + 'DELETE FROM PCMIRQ WHERE PCM_SEQDET = ' + QuotedStr(strAutIncPCMDET) + '; ';

        Finally
          FreeAndNil(qryMovRcd);
        End;

      End;

    End Else If (Not blnTabRestaura) Or (Not blnInsere) Then
    Begin
      Result := Result + fSQLGravaRequisicao(blnTabRestaura, strAutIncIRQ_comma, strAutIncPCMDET, strSeqGer);
    End;
  End;

  Procedure pAdicionaCampos;
  Begin
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_NUMPED', strNumPed, ftString   );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_CODEMP', strCodEmp, ftString   );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_ESPDOC', strEspDoc, ftString   );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_CODFOR', strCodFor, ftString   );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_CODITE', strCodIte, ftString   );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_CODUNI', strCodUni, ftString   );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_DTAENT', dtaDtaEnt, ftDateTime );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_HORPED', horHorPed, ftDateTime );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_DTAPED', dtaDtaPed, ftDateTime );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_CONPAG', strConPag, ftString   );

    If Not(blnInsere) Then
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_DTAEDT', dtaDatEdt, ftDateTime );

    objMontaSQLPedidoCompra.pAdicionaString('PCD_DESITE', strDesIte);

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_QTDITE', fltQtdIte, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_UNITAR', fltUnitar, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_DESUNI', fltDesUni, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_DESUN2', fltDesUn2, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_DESUN3', fltDesUn3, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_DESUN4', fltDesUn4, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_DESUN5', fltDesUn5, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_DESUN6', fltDesUn6, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_TOTITE', fltTotIte, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_PERIPI', fltPerIpi, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_TOTIPI', fltTotIpi, ftFloat    );

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_ALQCBS', fltAlqCbs, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_ALQIBS', fltAlqIbs, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_ALQ_IS', fltAlq_Is, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_VALCBS', fltValCbs, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_VALIBS', fltValIbs, ftFloat    );
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_VAL_IS', fltVal_Is, ftFloat    );

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_PERSUB', fltPerSub, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_TOTSUB', fltTotSub, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_TOTDAR', fltTotDar, ftFloat);

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_PERFCP', fltPerFCP, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_SUBFCP', fltSubFCP, ftFloat);

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_QTDBAI', fltQtdBai, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_TOTBAI', fltTotBai, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_IPIBAI', fltIpiBai, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_SUBBAI', fltSubBai, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_DARBAI', fltDarBai, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_FCPBAI', fltFCPBai, ftFloat);

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_FREBAI', fltFreBai, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_ACEBAI', fltAceBai, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_VALFRE', fltValFre, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_DESACE', fltDesAce, ftFloat);

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_BAIXAD', intBaixad, ftInteger);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_DOCORI', strDocOri, ftString);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_NUMCTN', intNumCtn, ftInteger);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_PEDIMP', strPedImp, ftString);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_PEDINT', strPedInt, ftString);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_PEDTXT', strPedTxt, ftString);

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_QTDINC', fltQTDINC, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_TRAINC', fltTRAINC, ftFloat);

    If blnTabRestaura Then
    Begin
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_SEQGER', strSeqGer,      ftString);
      objMontaSQLPedidoCompra.pAdicionaCampo('DTAALT',     VS_Date + fTime(), ftDateTime);
      objMontaSQLPedidoCompra.pAdicionaCampo('EXCLUIDO',   'N',            ftString);

      If blnInsere Then
        objMontaSQLPedidoCompra.pAdicionaCampo('AUTOINCREM' , '((NULL))', ftString);
    End Else
    Begin
      objMontaSQLPedidoCompra.pAdicionaCampo('AUTOINCREM' , strAutIncPcd, ftString);
    End;

    If Not fEmptyStr(strFatDor) Then
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_SEQFDO', strFatDor, ftString);

    If (fEmptyStr(strCodAca)) Then
    Begin
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_CODACA', '', ftString);
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_EMPACA' , '', ftString);
    End
    Else
    Begin
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_CODACA', strCodAca, ftString );
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_EMPACA', strEmpAca, ftString );
    End;

    If fEmptyStr(strProAca) Then
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_PROACA', '', ftString)
    Else
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_PROACA', strProAca, ftString );

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_QTDCON', fltQtdCon, ftFloat    );

    If fltTotSub > 0 Then
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_BASSUB', fltBasSub, ftFloat  )
    Else
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_BASSUB', 0, ftFloat  );

    If fltTotIpi > 0 Then
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_BASIPI', fltBasIPI, ftFloat  )
    Else
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_BASIPI', 0, ftFloat);

    If fltValIcm > 0 Then
    Begin
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_ALQICM', fltAlqIcm, ftFloat );
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_BASICM', fltBasIcm, ftFloat );
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_PERBAS', fltPerBas, ftFloat );

    End
    Else
    Begin
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_ALQICM', 0, ftFloat);
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_BASICM', 0, ftFloat);
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_PERBAS', 100, ftFloat );
    End;
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_VALICM', fltValIcm, ftFloat);

    If strPedImp <> 'S' Then
    Begin
      If blnIncPis Then
      Begin
        fltAlqPis := fltALPISP;
        fltAlqCof := fltALCOFP;
      End
      Else
      Begin
        fltAlqPis := 0;
        fltAlqCof := 0;
      End;
    End;

    If fltAlqPis > 0 Then
    Begin
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_BASPIS', fltTotIte, ftFloat);
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_ALQPIS', fltAlqPis, ftFloat);
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_VALPIS', RoundTo(fltTotIte * fltAlqPis/100, -2), ftFloat);
    End
    Else
    Begin
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_BASPIS', 0, ftFloat);
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_ALQPIS', 0, ftFloat);
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_VALPIS', 0, ftFloat);
    End;

    If fltAlqCof > 0 Then
    Begin
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_BASCOF', fltTotIte, ftFloat    );
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_ALQCOF', fltAlqCof, ftFloat    );
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_VALCOF', RoundTo(fltTotIte * fltAlqCof/100, -2),  ftFloat);
    End
    Else
    Begin
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_BASCOF', 0, ftFloat);
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_ALQCOF', 0, ftFloat);
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_VALCOF', 0, ftFloat);
    End;

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_ALQIMP', fltAlqImp, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_VALIMP', fltValImp, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_VALSIS', fltValSis, ftFloat);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_VALMAR', fltValMar, ftFloat);

    If fltEmbala = 0 Then
      fltEmbala := 1;

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_EMBALA', fltEmbala, ftFloat);

    If fltQtdOrc > -1 Then
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_QTDORC', fltQtdOrc, ftFloat);

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_DESPIS', fltDesPis, ftFloat);

    If fEmptyStr(strSubUsu) Then
      strSubUsu := 'N';

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_SUBUSU', strSubUsu, ftString);

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_UNILIQ', fltUniLiq, ftFloat, True);
  End;

begin

  objMontaSQLPedidoCompra := TMontaSQLPedidoCompra.Create(IIf(blnTabRestaura,'PCMDET_RES', 'PCMDET'), blnInsere);

  If Not blnTabRestaura Then
  Begin

    If (blnInsere) And (strAutIncPcd = '') And (Not blnVeioAutIncPcdInclusao) Then
      strAutIncPcd := fRetAutoIncrem('PCMDET' + IIF(blnTabRestaura, '_RES', ''), VS_strCodEmp)
    Else If fEmptyStr(strAutIncPcd) Then
      strAutIncPcd := strAutoin;

  End;

  If Not blnInsere Then
    strAutIncPcd := strAutoin;

  If (not blnTabRestaura) and (Not blnInsere) Then
    If Not fAutoincremPerteceAoNumPed(strAutIncPcd, strNumPed, strCodEmp, strEspDoc) Then
      Raise Exception.Create('O processo foi abortado, pois tentou atualizar registro inválido. Entre em contato com a Citel!');

  pAdicionaCampos;

  If blnInsere Then
  Begin
    Result := objMontaSQLPedidoCompra.fSQLInsert;
  End Else
  Begin
    Result := objMontaSQLPedidoCompra.fSQLUpdate;
    Result := Result + ' WHERE ';

    If blnTabRestaura Then
    Begin
     (*
      Result := Result + '       PCD_SEQGER =  ' + fQuotedStr(strSeqGer);
      Result := Result + '   AND PCD_CODITE =  ' + fQuotedStr(strCodIte);
      Result := Result + '   AND PCD_NUMCTN =  ' + IntToStr(intNumCtn);
      *)
      Result := Result + '   AUTOINCREM = '  + strAutIncPcd;

    End Else
      Result := Result + '   AUTOINCREM = '  + fQuotedStr(strAutIncPcd);
  End;

  Result := Result + ';';

  If blnInsere Then
    qryColetaAux := Nil
  Else
    qryColetaAux := qryColeta;

  If (Not blnTabRestaura) And blnUsaColeta Then
  Result := Result +
            TMontaSQLPedidoCompra.fSQLInsertColeta(intQtdConCol,
                                                   qryColeta,
                                                   strNumPed,
                                                   strCodEmp,
                                                   strEspDoc,
                                                   strEmpDes,
                                                   intNumCtn,
                                                   strCodIte,
                                                   strAutIncPcd,
                                                   '') +
            TMontaSQLPedidoCompra.fInsertControleDeColetaRequisicao(intQtdConCol,
                                                          qryColetaAux,
                                                          strNumPed,
                                                          strCodEmp,
                                                          strEspDoc,
                                                          strEmpDes,
                                                          intNumCtn,
                                                          strCodIte,
                                                          strAutIncPcd,
                                                          strAutIncIRQ_comma);


  If (Not blnTabRestaura) And SameText(strEspDoc, 'PD') Then
  Begin
    Result := IIF(blnInsere, '', fSQLEstornaSaldoItemPedidoCompra(strAutIncPcd, strCampoSaldoSub, intDeqTpc)) +
              Result +
              fSQLAtualizaSaldoItemPedidoCompra(strAutIncPcd, strCampoSaldoAdd, intDeqTpc);
  End;

  // Grava PCMIRQ (Ligação com a requisição de compras)
  pGravarIRQ(strAutIncPcd);
end;

function fGravarPcdDet(var strAutIncPcdDet: string;                         // Auto Incremento PCDDET Calculo Interno
                       strNumPed,
                       strEspDoc,
                       strCodEmp,
                       strCodIte,
                       strSeqGer: String;                                   // Autoincrem PCDDET
                       cdsItensMlj: TUniClientDataSet;
                       blnTabRestaura: Boolean = False;
                       strAutPcg: String = '';
                       blnGerarAutoincrem: Boolean = False;
                       blnFiltraItem: Boolean = True): string;
begin
  result := '';

  If blnFiltraItem Then
  Begin
    cdsItensMlj.Filtered := False;
    cdsItensMlj.Filter   := 'ITE_CODITE = ' + QuotedStr(strCodIte) + ' AND ITE_QTDITE > 0';
    cdsItensMlj.Filtered := True;
    cdsItensMlj.First;
  End Else
  Begin

    cdsItensMlj.First;
    cdsItensMlj.FindKey([strCodIte]);

  End;


  While (Not cdsItensMlj.Eof) And (strCodIte = cdsItensMlj.FieldByName('ITE_CODITE').AsString)Do
  Begin
    result := result + fGravarPcdDet(strAutIncPcdDet, //Incremento da PCDDET
                                    strCodEmp,
                                    strCodIte,
                                    cdsItensMlj.FieldByName('ITE_CODEMP').AsString,
                                    strEspDoc,
                                    strNumPed,
                                    cdsItensMlj.FieldByName('ITE_QTDITE').AsFloat,
                                    strSeqGer, //Autoincremento do PCMDET
                                    blnTabRestaura,
                                    strAutPcg);


    If blnGerarAutoincrem Then
       strAutIncPcdDet := fRetAutoIncrem('PCDDET', VS_strCodEmp)
    Else
      pIncrementaAutoIncrem(strAutIncPcdDet);

    cdsItensMlj.Next;
  End;

end;

function fGravarPcdDet( strAutIncPcdDet,
                        strCodEmp,
                        strCodIte,
                        strEmpDes,
                        strEspDoc,
                        strNumPed: String;
                        fltQtdIte: Double;
                        strSeqGer: String;
                        blnTabRestaura: Boolean = False;
                        strAutPcg: String = '';
                        strIncIRQ: String = ''): string;

  Var objMontaSQLPedidoCompra: TMontaSQLPedidoCompra;
begin

  objMontaSQLPedidoCompra := TMontaSQLPedidoCompra.Create(IIf(blnTabRestaura, 'PCDDET_RES','PCDDET'), True);
  Try
    if blnTabRestaura Then
      objMontaSQLPedidoCompra.blnReplaceInto := True;

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_NUMPED', strNumPed, ftString);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_CODEMP', strCodEmp, ftString);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_ESPDOC', strEspDoc, ftString);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_SEQGER', strSeqGer, ftString);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_CODITE', strCodIte, ftString);
    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_EMPDES', strEmpDes, ftString);

    If blnTabRestaura Then
    Begin
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_SEQPCG', strAutPcg, ftString);
      objMontaSQLPedidoCompra.pAdicionaCampo('PCD_INCIRQ', strIncIRQ, ftString);
      objMontaSQLPedidoCompra.pAdicionaCampo('DTAALT', VS_Date + fTime(), ftDateTime);
      objMontaSQLPedidoCompra.pAdicionaCampo('AUTOINCREM', '((NULL))', ftString);
    End
    Else
      objMontaSQLPedidoCompra.pAdicionaCampo('AUTOINCREM', strAutIncPcdDet, ftString);

    objMontaSQLPedidoCompra.pAdicionaCampo('PCD_QTDITE', fltQtdIte, ftFloat, True);

    Result := objMontaSQLPedidoCompra.fSQLInsert + ';';


  Finally
    FreeAndNil(objMontaSQLPedidoCompra);
  End;
end;

{********************************************}
{* RETORNA O SEQUENCIAL DO PEDIDO DE COMPRA *}
{*****************************************JB*}
function fSeqPedidoCompra(blnTabRestaura: Boolean = False; strCodEmp: String = ''): String;
  Var
    blnComita: Boolean;
    qryCfgSis: TUniQuery;

begin
  Try
    qryCfgSis := fCriaQuery;

    blnComita := False;

    If Not frmModulo.GetCurrentConnection.InTransaction Then
    Begin
      fStartTransaction;
      blnComita := True;
    End;

    Try

      With qryCfgSis Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT                     ');
        SQL.Add('  SIS_VALCFG               ');
        SQL.Add('FROM                       ');
        SQL.Add('  CFGSIS                   ');
        SQL.Add('WHERE                      ');
        SQL.Add('  SIS_CODEMP = :CODEMP AND ');
        SQL.Add('  SIS_CODCFG = :CODCFG     ');
        SQL.Add('FOR UPDATE                 ');

       ParamByName('CODEMP').Value := strCodEmp;
        If fEmptyStr(strCodEmp) Then
          ParamByName('CODEMP').Value := VS_strCodEmp;

        If blnTabRestaura Then
          ParamByName('CODCFG').Value := 'CFG_PEDRES'
        Else
          ParamByName('CODCFG').Value := 'CFG_PRXPCO';

        Open;

        pSetNaoReplicarConfig(ParamByName('CODCFG').Value);

        If Not fEmptyStr(FieldByName('SIS_VALCFG').AsString) Then
          Result := fStrZero(FieldByName('SIS_VALCFG').AsString, fTamNumPedCom)
        Else
          Result := fStrZero('1', fTamNumPedCom);

        If blnTabRestaura Then
          fAtuCfgSis('PEDRES', IntToStr(StrToInt64Def(Result, 0)+1), strCodEmp)
        Else
          fAtuCfgSis('PRXPCO', IntToStr(StrToInt64Def(Result, 0)+1), strCodEmp);

      End;

      If blnComita Then
        fCommit;

    Except
      On E: Exception Do
      Begin
        If blnComita Then
          fRollBack;

        Raise Exception.Create('Não consegui pegar o proximo sequencial de ' + IIF(blnTabRestaura , 'PEDRES', 'PRXPCO') + 'em CFGSIS. Tente novamente!');
      End;
    End;

  Finally
    FreeAndNil(qryCfgSis);
  End;

end;

{*****************************************}
{* RETORNA O SEQUENCIAL DO ORÇAMENTO     *}
{**************************************JB*}
function fSeqOrcamento(blnTabRestaura: Boolean = False; strCodEmp: String = ''): String;
  Var
    blnComita: Boolean;
    qryCfgSis: TUniQuery;

begin
  Try
    qryCfgSis := fCriaQuery;

    blnComita := False;

    If Not frmModulo.GetCurrentConnection.InTransaction Then
    Begin
      fStartTransaction;
      blnComita := True;
    End;

    Try
      With qryCfgSis Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT                     ');
        SQL.Add('  SIS_VALCFG               ');
        SQL.Add('FROM                       ');
        SQL.Add('  CFGSIS                   ');
        SQL.Add('WHERE                      ');
        SQL.Add('  SIS_CODEMP = :CODEMP AND ');
        SQL.Add('  SIS_CODCFG = :CODCFG     ');
        SQL.Add('FOR UPDATE                 ');

        ParamByName('CODEMP').Value := VS_strCodEmp;

        If blnTabRestaura Then
          ParamByName('CODCFG').Value := 'CFG_ORCRES'
        Else
          ParamByName('CODCFG').Value := 'CFG_PRXOCO';

        Open;

        pSetNaoReplicarConfig(ParamByName('CODCFG').Value);

        If Not fEmptyStr(FieldByName('SIS_VALCFG').AsString) Then
          Result := fStrZero(FieldByName('SIS_VALCFG').AsString, fTamNumPedCom)
        Else
          Result := fStrZero('1', fTamNumPedCom);

        If blnTabRestaura Then
          fAtuCfgSis('ORCRES', IntToStr(StrToInt(Result)+1))
        Else
          fAtuCfgSis('PRXOCO', IntToStr(StrToInt(Result)+1));

      End;

      If blnComita Then
        fCommit;

    Except
      On E: Exception Do
      Begin
        If blnComita Then
          fRollBack;

        Raise Exception.Create('Não consegui pegar o proximo sequencial de ' + IIF(blnTabRestaura , 'ORCRES', 'PRXOCO') + ' em CFGSIS. Tente novamente!');
      End;
    End;

  Finally
    FreeAndNil(qryCfgSis);
  End;

end;

Constructor TRecuperaExcluidos.Create(Owner: TComponent;
                                      bnlRecuperaPedido: Boolean;
                                      strSeqGer,
                                      strNumPed,
                                      strEspPed,
                                      strCodEmp: String);
Begin
  Inherited Create(Owner, fSQLDados(bnlRecuperaPedido,
                                    strSeqGer,
                                    strNumPed,
                                    strEspPed,
                                    strCodEmp));

  FNumPed := strNumPed;
  FCodEmp := strCodEmp;
  FEspPed := strEspPed;
  blnHeranca := False;

  fLeDados('TRecuperaExcluidos.Create');

  IndexFieldNames := 'PCD_CODITE';

  If bnlRecuperaPedido Then
    cdsExcluidos := TZClient.Create(Self, 'SELECT R.PCD_CODITE, PD.PCD_DESITE, PD.AUTOINCREM, 0 AS PCD_ESPECI FROM PCMDET_RES R ' +
                                          ' INNER JOIN PCMDET PD ON PD.PCD_NUMPED = R.PCD_NUMPED ' +
                                          '                     AND PD.PCD_CODEMP = R.PCD_CODEMP ' +
                                          '                     AND PD.PCD_CODITE =  R.PCD_CODITE AND PD.PCD_DESITE = R.PCD_DESITE ' +
                                          ' WHERE R.PCD_SEQGER = ' + QuotedStr(strSeqGer) +
                                          '   AND R.EXCLUIDO = "S" ')

  Else
    cdsExcluidos := TZClient.Create(Self, 'SELECT PCD_CODITE, PCD_DESITE, AUTOINCREM, 0 AS PCD_ESPECI FROM PCMDET WHERE FALSE');
  cdsExcluidos.fLeDados('TRecuperaExcluidos.Create');
  cdsExcluidos.IndexFieldNames := 'PCD_CODITE';

  FItensEspeciais := fGetItensEspeciais;
End;

Destructor TRecuperaExcluidos.Destroy;
Begin
  Inherited;

End;

Function TRecuperaExcluidos.fGetItensEspeciais: String;
  Var
    qryEspeciais: TUniQuery;
Begin
  qryEspeciais := fCriaQuery;
  qryEspeciais.SQL.Text := 'SELECT GROUP_CONCAT(ITE_CODITE) AS CODIGOS FROM CADITE WHERE ITE_DESITE LIKE "%ESPECIAL%"';
  qryEspeciais.Open;
  Result := qryEspeciais.FieldByName('CODIGOS').AsString;
  FreeAndNil(qryEspeciais);
End;

Function TRecuperaExcluidos.fSQLDados(bnlRecuperaPedido: Boolean;
                                      strSeqGer,
                                      strNumPed,
                                      strEspPed,
                                      strCodEmp: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + ' SELECT          ';
  strSQL := strSQL + '   D.PCD_CODITE, ';
  strSQL := strSQL + '   D.PCD_DESITE, ';
  strSQL := strSQL + '   D.PCD_QTDBAI, ';
  strSQL := strSQL + '   D.AUTOINCREM  ';
  strSQL := strSQL + ' FROM            ';
  strSQL := strSQL + '   PCMDET D      ';
  strSQL := strSQL + ' WHERE           ';

  If fEmptyStr(strNumPed) Then
  Begin
    strSQL := strSQL + '  FALSE ';
  End Else
  Begin
    strSQL := strSQL + '       PCD_NUMPED = ' + QuotedStr(strNumPed);
    strSQL := strSQL + '   AND PCD_CODEMP = ' + QuotedStr(strCodEmp);
    strSQL := strSQL + '   AND PCD_ESPDOC = ' + QuotedStr(strEspPed);
    strSQL := strSQL + '   AND PCD_NUMCTN = 0       ';
    strSQL := strSQL + '   AND PCD_BAIXAD           ';
  End;

  If bnlRecuperaPedido Then
  Begin
    strSQL := strSQL + ' UNION          ';

    strSQL := strSQL + ' SELECT          ';
    strSQL := strSQL + '   D.PCD_CODITE, ';
    strSQL := strSQL + '   D.PCD_DESITE, ';
    strSQL := strSQL + '   D.PCD_QTDBAI, ';
    strSQL := strSQL + '   D.AUTOINCREM  ';
    strSQL := strSQL + ' FROM            ';
    strSQL := strSQL + '   PCMDET D      ';

    strSQL := strSQL + ' INNER JOIN PCMDET_RES R ON           ';
    strSQL := strSQL + '        R.PCD_SEQGER = ' + strSeqGer;
    strSQL := strSQL + '    AND R.EXCLUIDO = "S"              ';
    strSQL := strSQL + '    AND R.PCD_CODITE = D.PCD_CODITE   ';
  End;

  Result := strSQL;
End;

Procedure TRecuperaExcluidos.pSalvaAutoincrem(strCodIte, strDesIte, strAutoincrem: String);
var blnItemEspecial: Boolean;
Begin
  If Not cdsExcluidos.Locate('PCD_CODITE;PCD_DESITE', VarArrayOf([strCodIte, strDesIte]), []) Then
  Begin
    blnItemEspecial := fIsItemEspecial(strCodIte);
    cdsExcluidos.Insert;
    cdsExcluidos.FieldByName('PCD_CODITE').AsString := strCodIte;
    cdsExcluidos.FieldByName('PCD_DESITE').AsString := strDesIte;
    cdsExcluidos.FieldByName('PCD_ESPECI').AsInteger := IIf(blnItemEspecial, 1, 0);
    cdsExcluidos.FieldByName('AUTOINCREM').AsString := strAutoincrem;
    cdsExcluidos.Post;
  End;

End;

Function TRecuperaExcluidos.fRetAutoincrem(strCodIte: String; Var strAutInc: String): Boolean;
Begin
  strAutInc := '';

  If FindKey([strCodIte]) Then
    strAutInc := FieldByName('AUTOINCREM').AsString

  Else If (cdsExcluidos.FindKey([strCodIte])) And (cdsExcluidos.FieldByName('PCD_ESPECI').AsInteger = 0) Then
    strAutInc := cdsExcluidos.FieldByName('AUTOINCREM').AsString;

  Result := Not fEmptyStr(strAutInc);
End;

Function TRecuperaExcluidos.fTemItensPedido(strNumPed, strEspPed, strCodEmp: String; Var strMsgErro: string): Boolean;
  Var
    qryPcmdet: TUniQuery;
Begin
  qryPcmdet := fCriaQuery;
  qryPcmdet.SQL.Text := 'SELECT COUNT(*) AS QTDITE FROM PCMDET WHERE PCD_NUMPED = :NUMPED AND PCD_CODEMP = :CODEMP AND PCD_ESPDOC = :ESPDOC ';
  qryPcmdet.ParamByName('NUMPED').AsString := strNumPed;
  qryPcmdet.ParamByName('ESPDOC').AsString := strEspPed;
  qryPcmdet.ParamByName('CODEMP').AsString := strCodEmp;
  qryPcmdet.Open;

  Result := qryPcmdet.FieldByName('QTDITE').AsInteger > 0;

  If Not Result Then
    strMsgErro := 'Houve um problema no processamento e pedido não será gravado para evitar a exclusão dos itens!';

  FreeAndNil(qryPcmdet);
End;

class function TRecuperaExcluidos.fPcmDetFicouVazio(strNumPed, strEspPed, strCodEmp: String): Boolean;
var qryConsulta: TUniQuery;
begin
  If strNumPed = '' Then
    Exit(False);
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD');
    qryConsulta.SQL.Add('  FROM PCMDET');
    qryConsulta.SQL.Add(' WHERE PCD_NUMPED = "' + strNumPed + '"');
    qryConsulta.SQL.Add('   AND PCD_CODEMP = "' + strCodEmp + '"');
    qryConsulta.SQL.Add('   AND PCD_ESPDOC = "' + strEspPed + '"');

    qryConsulta.Open;

    result := (qryConsulta.FieldByName('QTD').AsInteger = 0);
  Finally
    FreeAndNil(qryConsulta)
  End;
end;

Function TRecuperaExcluidos.fApagaExcluidos(cdsItensPedido: TUniClientDataSet; blnManterZerados: Boolean): Boolean;
  Var
    qryDelete: TUniQuery;
    strCampoSaldo,
    strForFil   : String;
    blnLibPcm   : Boolean;
    intDeqTpc   : Integer;
Begin
  Result := True;

  If blnHeranca Then
    Exit;

  If cdsItensPedido.IsEmpty Then
    Exit;

  If Not blnManterZerados Then
  Begin
    cdsItensPedido.Filter   := 'ITE_QTDITE = 0';
    cdsItensPedido.Filtered := True;
    cdsItensPedido.First;

    While Not cdsItensPedido.Eof Do
    Begin
      If (cdsItensPedido.FieldByName('ITE_GRAVAD').AsString = 'S') Then
        pSalvaAutoincrem(cdsItensPedido.FieldByName('ITE_CODITE').AsString,
                         cdsItensPedido.FieldByName('ITE_DESITE').AsString,
                         cdsItensPedido.FieldByName('AUTOINCREM').AsString);

      cdsItensPedido.Delete;
    End;

    cdsItensPedido.Filtered := False;
    cdsItensPedido.Filter   := '';
  End;

  strForFil := fRetForFilialTodos;
  blnLibPcm := fCfgSis('LIBPCM', varBoolean);
  intDeqTpc := fCfgSis('DEQTPC', varInteger);

  strCampoSaldo := fRetCampoAtualizaSaldoPedidoCompra('',
                                                      FNumPed,
                                                      FCodEmp,
                                                      blnLibPcm,
                                                      strForFil);

  qryDelete := fCriaQuery;
  // APAGA SE NÃO TEM BAIXA PARCIAL
  qryDelete.SQL.Add('DELETE FROM PCMDET WHERE AUTOINCREM = :AUTINC AND PCD_QTDBAI = 0;');
  // BAIXA TOTALMENTE SE TEM BAIXA PARCIAL
  qryDelete.SQL.Add('UPDATE PCMDET SET PCD_QTDITE = PCD_QTDBAI, PCD_BAIXAD = 1 WHERE AUTOINCREM = :AUTINC AND PCD_QTDBAI > 0;');

  cdsExcluidos.First;
  While Not cdsExcluidos.Eof Do
  Begin

    If fExcluiItem(cdsItensPedido) Then
    Begin
      pEstornaSaldoItemPedidoCompra(cdsExcluidos.FieldByName('AUTOINCREM').AsString, strCampoSaldo, intDeqTpc);

      qryDelete.Close;
      qryDelete.ParamByName('AUTINC').AsString := cdsExcluidos.FieldByName('AUTOINCREM').AsString;
      qryDelete.ExecSQL;
    End;

    cdsExcluidos.Next;
  End;

  FreeAndNil(qryDelete);

  
End;

function TRecuperaExcluidos.fExcluiItem(cdsItensPedido: TUniClientDataSet): Boolean;
begin

  If Pos(cdsExcluidos.FieldByName('PCD_CODITE').AsString, FItensEspeciais) > 0 Then
    Result := Not cdsItensPedido.Locate('ITE_CODITE;ITE_DESITE;AUTOINCREM',
                                     VarArrayOf([cdsExcluidos.FieldByName('PCD_CODITE').AsString ,
                                                 cdsExcluidos.FieldByName('PCD_DESITE').AsString,
                                                 cdsExcluidos.FieldByName('AUTOINCREM').AsString]), [])
  Else
    Result := Not cdsItensPedido.Locate('ITE_CODITE;AUTOINCREM',
                                     VarArrayOf([cdsExcluidos.FieldByName('PCD_CODITE').AsString ,
                                                 cdsExcluidos.FieldByName('AUTOINCREM').AsString]), []);


end;

end.
