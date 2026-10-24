unit untRecuperaPedido;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, Controls, untTypesSistema,
     UniClientDataSet, UniDataSetProvider, CxProgressBar, untZClient,
     untSalvaDadosGiro, untFuncoesPedidoSimples;

Type
  TfRetQtdConferida = Function (strCodIte: String; fltQtdIte: Double): Double Of Object;
  TAfterSetID_Restauracao = procedure  of object;

  TRecPcmger = Record
    blnSomaDescontoAdcionalFornecedor1: Boolean;
    strUsaGir,
    strNumPed,
    strCodEmp,
    strEspDoc,
    strCodFor,
    strCodTra,
    strCodTraRedespacho,
    strConPag: String;
    dtaDtaPed: TDate;
    horHorEnt: TTime;
    dtaDtaEnt: TDate; 
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
    strObs006,
    strObsPd1,
    strObsPd2,
    strObsPd3,
    strObsPd4,
    strObsPd5,
    strObsPd6,
    strPedVen,
    strAtenca,
    strTipFre,
    strTipFreRedespacho,
    strDocOri: String;
    intMoeda,
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
    strBStFre,
    strIpiFre,
    strBStAce: String;

    recNivEst: TRecOpcoesNivel;

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
    strAutInc: String;

    fltValCbs,
    fltValIbs,
    fltVal_Is: Double;

    blnUsaColeta,
    blnRecuperaPedido: Boolean;

    strTipFab: String;
  End;

  TRecuperaPedido = Class(TComponent)
  Private

    FDeqTpc: Integer;
    FLibPcm: Boolean;
    FForFil: String;


    qryPermanente: TUniQuery;

    qryBuscaItem: TUniQuery;

    qryRecupera: TUniQuery;

    qryRequisicao: TUniQuery;

    qryPcmDetInsert,
    qryPcmDetExcluidoUpdateAutInc,
    qryPcmDetExcluidoUpdate: TUniQuery;

  //  strTrava,
    strAutIncPcd: String;

    FItensMultiLojas: TUniClientDataSet;

    Function fSQLPcmDetExcluidoUpdateAutInc: String;
    Function fSQLPcmDetExcluidoUpdate: String;
    Function fSQLPcmDetInsert: String;

    Procedure pSetItensMultiLojas(Value: TUniClientDataSet);

    Procedure pSetFornecedor(Value :String);
    Procedure pSetPedImp(Value :String);
    Procedure pSetPedInt(Value :String);
    Procedure pSetPedBon(Value :String);
    Procedure pSetDesPdi(Value :String);
    Procedure pSetConPag(Value :String);
    Procedure pSetCompra(Value :String);
    Procedure pSetDtaPed(Value :TDate);
    Procedure pSetDtaEnt(Value :TDate);
    Procedure pSetDtaFat(Value :TDate);
    Procedure pSetTipFab(Value :String);
    Procedure pSetMoeda(Value :Integer);

    Procedure pIncluiCapa;
    Procedure pAtualizaCapa;
    Function fGravaCapa(blnTestarVazio: Boolean = True): Boolean;

    procedure pUpdatePcmDet(blnZeraConf: Boolean);
    Procedure pIncluiItem(blnZeraConf: Boolean);

//    Procedure pExecutaNaPermanente(qryDados: TUniQuery; strAutoincrem: String; blnIncNoNull: Boolean = False);

//    Function fTrocaTabelasParaPermanentes(strSQL: String): String;

    Function fAtualizaDadosMultilojaPrg(pgbProgresso: TcxProgressBar): Boolean;

    Function fSQLMultiloja: String;

    Function fJaGravouItem(Var blnExcluido: Boolean): Boolean;

    Function fSQLPedidos(strNumPed, strCodEmp, strEspDoc: String): String;

    Function fSQLBuscaItemAltPed: String;
    Function fSQLBuscaItemIncPed: String;

    Function fRecuperaCapaInclusaoAbortada: Boolean;
    procedure pSetDesAdi(const Value: Double);
    procedure pSetSomaDescontoAdicionalFornecedor1(const Value: Boolean);

    procedure pSetZeraSTP(const Value: String);

  Public

    blnCancelou: Boolean;

    objSalInt: TSalvaInterfaceGiro;

    blnGravacaoAtiva: Boolean;

    blnZerCon: Boolean;

    fRetQtdConferida: TfRetQtdConferida;

    recPcmger: TRecPcmger;

    cdsPedidos: TzClient;

    cdsItensPedido: TUniClientDataSet;

    blnGravar: Boolean;

    onAfterSetID_Restauracao: TAfterSetID_Restauracao;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor  Destroy; Override;

    Function fSelecionaRecuperaPedido(strNumPed, strCodEmp, strEspDoc: String): Boolean;

    Function fMarcaPedido: Boolean;

    Procedure pApagaPedido(strAutInc: String);
    Procedure pApagaCopiaSeguranca;

    Procedure pLimpaDados(blnZeraRef: Boolean = True);

    Procedure pAtualizaItem;
    procedure pSalvaDefinicaoTransferencia(DataSet: TDataSet);

    procedure pMarcaExcluido;

    Procedure pPcddetAfterPost(dataSet: TDataSet);

    Procedure pAtualizaDadosMultiloja;

  Published

     Property strCodForP: String Read recPcmger.strCodFor  Write pSetFornecedor;
     Property strPedImpP: String Read recPcmger.strPedImp  Write pSetPedImp;

     Property intMoedaP:  Integer Read recPcmger.intMoeda  Write pSetMoeda;

     Property strPedIntP: String Read recPcmger.strPedInt  Write pSetPedInt;
     Property strPedBonP: String Read recPcmger.strPedBon  Write pSetPedBon;
     property strZeraSTP: String Read recPcmger.strZeraST  Write pSetZeraSTP;
     Property strDesPdiP: String Read recPcmger.strDesPdi  Write pSetDesPdi;
     Property strConPagP: String Read recPcmger.strConPag  Write pSetConPag;
     Property strCompraP: String Read recPcmger.strCompra  Write pSetCompra;

     Property strTipFabP: String Read recPcmger.strTipFab  Write pSetTipFab;

     Property dtaDtaPedP: TDate Read recPcmger.dtaDtaPed  Write pSetDtaPed;
     Property dtaDtaEntP: TDate Read recPcmger.dtaDtaEnt  Write pSetDtaEnt;
     Property dtaDtaFatP: TDate Read recPcmger.dtaDtaFat  Write pSetDtaFat;
     Property fltDesAdi: Double  Read recPcmger.fltDesAdi Write pSetDesAdi;
     property blnSomaDescontoAdcionalFornecedor1: boolean read recPcmger.blnSomaDescontoAdcionalFornecedor1 write pSetSomaDescontoAdicionalFornecedor1;


     Property cdsItensMultiLojas: TUniClientDataSet Read FItensMultiLojas Write pSetItensMultiLojas;

  End;

implementation

uses
  untFuncoesSimples,
  untGravacaoPedido,
  untRecuperaPedidoSelec,
  untGravando;

Constructor TRecuperaPedido.Create(Owner: TComponent);
Begin

  blnGravar := True;

  cdsPedidos := TzClient.Create(Self);

  qryBuscaItem  := fCriaQuery(Self);
  qryPermanente := fCriaQuery(Self);
  qryRecupera   := fCriaQuery(Self);

  qryRequisicao := fCriaQuery(Self);


  qryPcmDetInsert := fCriaQuery(Self);
  qryPcmDetInsert.SQL.Text := fSQLPcmDetInsert;

  qryPcmDetExcluidoUpdateAutInc := fCriaQuery(Self);
  qryPcmDetExcluidoUpdateAutInc.SQL.Text := fSQLPcmDetExcluidoUpdateAutInc;

  qryPcmDetExcluidoUpdate := fCriaQuery(Self);
  qryPcmDetExcluidoUpdate.SQL.Text := fSQLPcmDetExcluidoUpdate;

  blnCancelou := False;

  objSalInt := Nil;

  pLimpaDados;


  FLibPcm := fCfgSis('LIBPCM', varBoolean);
  FDeqTpc := fCfgSis('DEQTPC', varInteger);

  FForFil := fRetForFilialTodos;
End;

Destructor TRecuperaPedido.Destroy;
Begin

End;

Procedure TRecuperaPedido.pLimpaDados(blnZeraRef: Boolean = True);
  Var
    strAutoIncrem: String;
    blnRecupera: Boolean;
Begin
  strAutoIncrem := recPcmger.strAutInc;
  blnRecupera   := recPcmger.blnRecuperaPedido;
  onAfterSetID_Restauracao := nil;

  FillChar(recPcmger, SizeOf(recPcmger), #0);

  If Not blnZeraRef Then
  Begin
    recPcmger.strAutInc := strAutoIncrem;
    recPcmger.blnRecuperaPedido := blnRecupera;
  End;

  blnGravacaoAtiva := False;
End;

Procedure TRecuperaPedido.pSetFornecedor(Value: String);
Begin
  If Value <> recPcmger.strCodFor Then
  Begin
    recPcmger.strCodFor := Value;
    fGravaCapa;
  End;
End;

Procedure TRecuperaPedido.pSetPedImp(Value: String);
Begin
  If Value <> recPcmger.strPedImp Then
  Begin
    recPcmger.strPedImp := Value;
    fGravaCapa;
  End;
End;

Procedure TRecuperaPedido.pSetMoeda(Value :Integer);
Begin
  If Value <> recPcmger.intMoeda Then
  Begin
    recPcmger.intMoeda := Value;
    fGravaCapa;
  End;
End;

Procedure TRecuperaPedido.pSetPedInt(Value: String);
Begin
  If Value <> recPcmger.strPedInt Then
  Begin
    recPcmger.strPedInt := Value;
    fGravaCapa;
  End;
End;

procedure TRecuperaPedido.pSetTipFab(Value: String);
begin
  If Value <> recPcmger.strTipFab Then
  Begin
    recPcmger.strTipFab := Value;
    fGravaCapa;
  End;
end;

procedure TRecuperaPedido.pSetZeraSTP(const Value: String);
begin
  If Value <> recPcmger.strZeraST Then
  Begin
    recPcmger.strZeraST := Value;
    fGravaCapa;
  End;
end;

Procedure TRecuperaPedido.pSetConPag(Value: String);
Begin
  If Value <> recPcmger.strConPag Then
  Begin
    recPcmger.strConPag := Value;
    fGravaCapa;
  End;
End;

procedure TRecuperaPedido.pSalvaDefinicaoTransferencia(DataSet: TDataSet);
var qryPCDTRA: TUniQuery;
begin
  fGravaCapa;
  qryPCDTRA := fCriaQuery;
  Try
    qryPCDTRA.SQL.Add('REPLACE INTO PCDTRA_RES(TRA_SEQGER, TRA_CODITE, TRA_EMPORI, TRA_EMPDES, TRA_QTDTRA)');
    qryPCDTRA.SQL.Add('VALUES');
    qryPCDTRA.SQL.Add('(:TRA_SEQGER, :TRA_CODITE, :TRA_EMPORI, :TRA_EMPDES, :TRA_QTDTRA)');
    DataSet.First;

    DataSet.First;
    while not DataSet.Eof do
    begin
      qryPCDTRA.ParamByName('TRA_SEQGER').Value := recPcmger.strAutInc;
      qryPCDTRA.ParamByName('TRA_CODITE').Value := DataSet.FieldByName('CODITE').Value;
      qryPCDTRA.ParamByName('TRA_EMPORI').Value := DataSet.FieldByName('CODEMP').Value;
      qryPCDTRA.ParamByName('TRA_EMPDES').Value := DataSet.FieldByName('EMPDES').Value;
      qryPCDTRA.ParamByName('TRA_QTDTRA').Value := DataSet.FieldByName('QTDITE').Value;
      qryPCDTRA.ExecSQL;
      DataSet.Next;
    End;
  Finally
    FreeAndNil(qryPCDTRA);
  End;
  {}
end;

Procedure TRecuperaPedido.pSetCompra(Value: String);
Begin
  If Value <> recPcmger.strCompra Then
  Begin
    recPcmger.strCompra := Value;
    fGravaCapa;
  End;
End;

Procedure TRecuperaPedido.pSetPedBon(Value: String);
Begin
  If Value <> recPcmger.strPedBon Then
  Begin
    recPcmger.strPedBon := Value;
    fGravaCapa;
  End;
End;

procedure TRecuperaPedido.pSetDesAdi(const Value: Double);
begin
 If Value <> recPcmger.fltDesAdi Then
  Begin
    recPcmger.fltDesAdi:= Value;
    fGravaCapa;
  End;
end;


procedure TRecuperaPedido.pSetSomaDescontoAdicionalFornecedor1(const Value: boolean);
begin
 If Value <> recPcmger.blnSomaDescontoAdcionalFornecedor1 Then
  Begin
    recPcmger.blnSomaDescontoAdcionalFornecedor1 := Value;
    fGravaCapa;
  End;
end;

Procedure TRecuperaPedido.pSetDesPdi(Value: String);
Begin
  If Value <> recPcmger.strDesPdi Then
  Begin
    recPcmger.strDesPdi := Value;
    fGravaCapa;
  End;
End;

Procedure TRecuperaPedido.pSetDtaPed(Value: TDate);
Begin
  If Value <> recPcmger.dtaDtaPed Then
  Begin
    recPcmger.dtaDtaPed := Value;
    fGravaCapa;
  End;
End;

Procedure TRecuperaPedido.pSetDtaEnt(Value: TDate);
Begin
  If Value <> recPcmger.dtaDtaEnt Then
  Begin
    recPcmger.dtaDtaEnt := Value;
    fGravaCapa;
  End;
End;

Procedure TRecuperaPedido.pSetDtaFat(Value: TDate);
Begin
  If Value <> recPcmger.dtaDtaFat Then
  Begin
    recPcmger.dtaDtaFat := Value;
    fGravaCapa;
  End;
End;

(*
Function TRecuperaPedido.fTrocaTabelasParaPermanentes(strSQL: String): String;
Begin
  strSQL := AnsiReplaceStr(strSQL, 'PCMGER_RES', 'PCMGERTUD');
  strSQL := AnsiReplaceStr(strSQL, 'PCMDET_RES', 'PCMDETTUD');
  strSQL := AnsiReplaceStr(strSQL, 'PCDDET_RES', 'PCDDETTUD');
  strSQL := AnsiReplaceStr(strSQL, 'PCMIRQ_RES', 'PCMIRQTUD');

  Result := strSQL;
End;

Procedure TRecuperaPedido.pExecutaNaPermanente(qryDados: TUniQuery; strAutoincrem: String; blnIncNoNull: Boolean = False);
  Var
    intContador: Integer;
    strSQL: String;
Begin
  strSQL := fTrocaTabelasParaPermanentes(qryDados.SQL.Text);

  If blnIncNoNull Then
  Begin
    strSQL := AnsiReplaceStr(strSQL, '((NULL))', strAutoincrem);
    strAutoincrem := '';
  End;

  qryPermanente.Close;
  qryPermanente.SQL.Text := strSQL;

  For intContador := 0 To qryDados.ParamCount - 1 Do
    qryPermanente.Params[intContador].Value := qryDados.Params[intContador].Value;

  If Not fEmptyStr(strAutoincrem) Then
    qryPermanente.ParamByName('AUTINC').AsString := strAutoincrem;;

  qryPermanente.ExecSQL;
End;
*)

Procedure TRecuperaPedido.pAtualizaCapa;
Begin
  If Not blnGravar Then
    Exit;

  With recPcmger Do
  pAtualizaPcmGer(blnSomaDescontoAdcionalFornecedor1,
                  qryRecupera,
                  Nil,
                  strNumPed,
                  strCodEmp,
                  strEspDoc,
                  strCodFor,
                  strCodTra,
                  strCodTraRedespacho,
                  strConPag,
                  dtaDtaPed,
                  horHorEnt,
                  dtaDtaEnt,
                  strCompra,
                  fltTotIpi,
                  fltTotSub,
                  fltTotDar,
                  fltSubFCP,
                  fltTotIte,
                  fltTotGer,
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
                  fltDesAdi,
                  fltValFre,
                  fltDesAce,
                  strPedImp,
                  strPedInt,
                  dtaDtaFat,
                  strCodEve,
                  strCodCta,
                  strNomEnt,
                  strEndEnt,
                  strCidEnt,
                  fltBasCof,
                  fltValCof,
                  fltBasPis,
                  fltValPis,
                  fltBasIcm,
                  fltValIcm,
                  fltBasIpi,
                  fltBasSub,
                  strPagVis,
                  strPedBon,
                  strZeraST,
                  strDesPdi,
                  fltValSis,
                  fltValMar,
                  fltDesPis,
                  True,
                  strAutInc,
                  strTipFab,
                  moeReal,
                  'S',
                  'S',
                  '',
                  '',
                  strObsPd4,
                  strObsPd5,
                  strObsPd6,
                  'N',
                  False,
                  strObs006,
                  fltValCbs,
                  fltValIbs,
                  fltVal_Is);

//  pExecutaNaPermanente(qryRecupera, '');
End;

Function TRecuperaPedido.fGravaCapa(blnTestarVazio: Boolean = True): Boolean;
Begin
  If Not blnGravar Then
  Begin
    Result := True;
    Exit;
  End;

  Result := False;

  If Not blnGravacaoAtiva Then
    Exit;

  If blnTestarVazio And cdsItensPedido.IsEmpty Then
    Exit;

  With recPcmger Do
  Begin
    If fEmptyStr(strCodFor) Then
      Exit;

    If fEmptyStr(strAutInc) Then
    Begin
      pIncluiCapa;
      If Assigned(onAfterSetID_Restauracao) Then
       onAfterSetID_Restauracao;
    End
    Else
      pAtualizaCapa;
  End;

  Result := True;
End;

Procedure TRecuperaPedido.pIncluiCapa;
Begin
  If Not blnGravar Then
    Exit;

  With recPcmger, recNivEst Do
  pGravaPcmGer(blnSomaDescontoAdcionalFornecedor1,
               qryRecupera,
               Nil,
               strNumPed,
               strCodEmp,
               strEspDoc,
               strCodFor,
               strCodTra,
               strCodTraRedespacho,
               strConPag,
               dtaDtaped,
               horHorEnt,
               dtaDtaEnt,
               strCompra,
               fltTotIpi,
               fltTotSub,
               fltTotDar,
               fltSubFCP,
               fltTotIte,
               fltTotGer,
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
               strDocOri,
               intNumCtn,
               strPedImp,
               strPedInt,
               strEmpDes,
               fltDesAdi,
               strPedMlj,
               fltValFre,
               fltDesAce,
               dtaDtaFat,
               strCodEve,
               strCodCta,
               strNomEnt,
               strEndEnt,
               strCidEnt,
               strNiveis,
               nivEstoque,
               intDiaComGer,
               intDiaComNvA,
               intDiaComNvB,
               intDiaComNvC,
               fltBasCof,
               fltValCof,
               fltBasPis,
               fltValPis,
               fltBasIcm,
               fltValIcm,
               fltBasIpi,
               fltBasSub,
               strPagVis,
               strNumCot,
               strEmpCot,
               strPedBon,
               strZeraST,
               strDesPdi,
               intMesGir,
               strMesAtu,
               strOrcOri,
               fltValSis,
               fltValMar,
               fltDesPis,
               strAutInc,
               strUsaGir,
               True,
               '',
               '',
               fRetTipoMoeda(intMoeda),
               strTipFab,
               'S',             // strBStFre
               'S',             // strBStAce
               '',              // strOrdCon
               '',              // strTipCodFabProd
               '',              // strObsPd4
               '',              // strObsPd5
               '',              // strObsPd6
               'N',             // strIpiFre
               False,           // blnPagamentoCartaoCredito
               '',              // strObs006
               fltValCbs,
               fltValIbs,
               fltVal_Is);

//  pExecutaNaPermanente(qryRecupera, recPcmger.strAutInc);

  If (recPcmger.strUsaGir = 'S') And fEmptyStr(recPcmger.strNumPed) And Assigned(objSalInt) Then
  Begin
    If (Not objSalInt.fSalvaDados(recPcmger.strAutInc)) Or
       (Not objSalInt.fSalvaDados(recPcmger.strAutInc,
                                  '',    // strNomFrm
                                  '',    // strCodOpe
                                  False, // blnAtualizaDados
                                  Nil,   // arrCampos
                                  'CADINTTUD'))  Then
      Raise Exception.Create('Erro ao gravar filtros do giro de estoque!');
  End;

End;

Procedure TRecuperaPedido.pIncluiItem(blnZeraConf: Boolean);
  Var
    fltQtdCon: Double;
    blnSalva: Boolean;
    nteBeforePost,
    nteAfterPost,
    nteAfterScroll: TDataSetNotifyEvent;
    intQtdConCol: Integer;
Begin
  If Not blnGravar Then
    Exit;

  Try
    intQtdConCol := 0;

    With recPcmger, cdsItensPedido Do
    Begin
      If blnZeraConf Or (Not Assigned(fRetQtdConferida)) Then
        fltQtdCon := 0
      Else
        fltQtdCon := fRetQtdConferida(FieldByName('ITE_CODITE').AsString,
                                      FieldByName('ITE_QTDITE').AsFloat);  // Conferencia de entrada

      qryRecupera.Close;
      qryRecupera.SQL.Text := fGravaPcmDet(intQtdConCol,
                                           Nil,
                                           False,
                                           strEmpDes,
                                           '',
                                           '',
                                           FDeqTpc,
                                           strNumPed,                                // Número do Pedido
                                           strCodEmp,                                // Empresa
                                           strEspDoc,                                // Espécie (PD / OR)
                                           strCodFor,                                // Fornecedor
                                           FieldByName('ITE_CODITE').AsString,       // Código Item
                                           FieldByName('ITE_CODUNI').AsString,       // Código da Unidade
                                           IIF(fCfgSis('ENTITE', VarBoolean), FieldByName('ITE_DTAENT').AsDateTime, dtaDtaEnt), // Data Entrega
                                           horHorEnt,                                // Hora do Pedido
                                           dtaDtaPed,                                // Data do Pedido
                                           strConPag,                                // Cond. Pagamento
                                           FieldByName('ITE_DESITE').AsString,       // Descrição Item
                                           FieldByName('ITE_QTDITE').AsFloat,        // Quantidade
                                           FieldByName('ITE_UNITAR').AsFloat,        // Preço Unitario
                                           FieldByName('ITE_DESUNI').AsFloat,        // % Desconto Unitario
                                           FieldByName('ITE_DESUN2').AsFloat,        // % Desconto Unitario
                                           FieldByName('ITE_DESUN3').AsFloat,        // % Desconto Unitario
                                           FieldByName('ITE_DESUN4').AsFloat,        // % Desconto Unitario
                                           FieldByName('ITE_DESUN5').AsFloat,        // % Desconto Unitario
                                           FieldByName('ITE_DESUN6').AsFloat,        // % Desconto Unitario
                                           FieldByName('ITE_TOTITE').AsFloat,        // Total Itens S
                                           FieldByName('ITE_PERIPI').AsFloat,        // Percentual IPI
                                           FieldByName('ITE_TOTIPI').AsFloat,        // Total IPI
                                           FieldByName('ITE_PERSUB').AsFloat,        // Percentual SUB
                                           FieldByName('ITE_TOTSUB').AsFloat,        // Total SUB
                                           FieldByName('ITE_TOTDAR').AsFloat,        // Total DARE
                                           FieldByName('ITE_PERFCP').AsFloat,        // Percentual SUB
                                           FieldByName('ITE_SUBFCP').AsFloat,        // Total SUB
                                           0,                                        // Quantidade Baixa
                                           0,                                        // Total Baixado
                                           0,                                        // IPI Baixado
                                           0,                                        // SUB Baixado
                                           0,                                        // DARE Baixado
                                           0,                                        // SUB FCP Baixado
                                           0,                                        // fltFreBai
                                           0,                                        // fltAceBai
                                           FieldByName('ITE_VALFRE').AsFloat,        // fltValFre
                                           FieldByName('ITE_DESACE').AsFloat,        // fltDesAce
                                           0,                                        // Baixado?
                                           '',                                       // Origem do Documento (Faturamento)
                                           0,                                        // Número do Container
                                           strPedImp,                                // Pedido de Importação?
                                           strPedInt,                                // Pedido Intrepostado
                                           FieldByName('ITE_PEDTXT').AsString,       // Proveninete de Importação?

                                           cdsItensPedido.FieldByName('ITE_QTDINC').AsFloat,       // Proveninete de Importação?
                                           cdsItensPedido.FieldByName('ITE_TRAINC').AsFloat,       // Proveninete de Importação?

                                           strAutIncPcd,                             // Auto Incremento
                                           FieldByName('ITE_CODACA').AsString,       // Código do produto acabado
                                           FieldByName('ITE_EMPACA').AsString,       // Empresa do produto acabado
                                           FieldByName('ITE_PROACA').AsString,       // Produto acabado? (S/N)

                                           fltQtdCon,

                                           FieldByName('ITE_BASSUB').AsFloat,
                                           FieldByName('ITE_BASIPI').AsFloat,
                                           FieldByName('ITE_BASICM').AsFloat,
                                           FieldByName('ITE_PERBAS').AsFloat,
                                           FieldByName('ITE_ALQICM').AsFloat,
                                           FieldByName('ITE_VALICM').AsFloat,
                                           FieldByName('ITE_INCPIS').AsString = 'S',
                                           FieldByName('ITE_INCIRQ').AsString,
                                           FieldByName('ITE_ALQPIS').AsFloat,
                                           FieldByName('ITE_ALQCOF').AsFloat,
                                           FieldByName('ITE_ALQIMP').AsFloat,
                                           FieldByName('ITE_VALIMP').AsFloat,
                                           FieldByName('ITE_VALSIS').AsFloat,
                                           FieldByName('ITE_VALMAR').AsFloat,
                                           FieldByName('ITE_SEQFDO').AsString,
                                           FieldByName('ITE_QTDEMB').AsFloat,
                                           FieldByName('ITE_ALQPIS').AsFloat,
                                           FieldByName('ITE_ALQCOF').AsFloat,
                                           FieldByName('ITE_SUBUSU').AsString,
                                           FieldByName('ITE_DESPIS').AsFloat,        // fltDesPis: Double;
                                           True,                                     // blnTabRestaura: Boolean = False;
                                           strAutInc,                                // strSeqGer: String = '';
                                           True,                                    // blnInsere: Boolean = True;
                                           '',                                       // strAutoin: String = '';
                                           False,                                    // blnVeioAutIncPcdInclusao: Boolean = False;
                                           -1,                                       // fltQtdOrc: Double = -1;
                                           0,                                        // dtaDatEdt: TDateTime = 0;
                                           FieldByName('ITE_UNILIQ').AsFloat,         // fltUniLiq: Double = 0
                                           FieldByName('ITE_ALQCBS').AsFloat,
                                           FieldByName('ITE_ALQIBS').AsFloat,
                                           FieldByName('ITE_ALQ_IS').AsFloat,
                                           FieldByName('ITE_VALCBS').AsFloat,
                                           FieldByName('ITE_VALIBS').AsFloat,
                                           FieldByName('ITE_VAL_IS').AsFloat);

      qryRecupera.ExecSQL;
      strAutIncPcd := fLastInsertID;

      If Not fEmptyStr(FieldByName('ITE_INCIRQ').AsString) Then
      Begin
        qryRequisicao.Close;
        qryRequisicao.SQL.Text := fSQLGravaRequisicao(True, FieldByName('ITE_INCIRQ').AsString, strAutIncPcd, recPcmger.strAutInc);
        qryRequisicao.ExecSQL;
      End

      Else qryRequisicao.SQL.Clear;

      nteBeforePost  := cdsItensPedido.BeforePost;
      nteAfterPost   := cdsItensPedido.AfterPost;
      nteAfterScroll := cdsItensPedido.AfterScroll;

      cdsItensPedido.AfterScroll := Nil;
      cdsItensPedido.AfterPost   := Nil;
      cdsItensPedido.BeforePost  := Nil;

      If Not (cdsItensPedido.State In dsEditModes) Then
      Begin
        blnSalva := True;
        cdsItensPedido.Edit;
      End

      Else blnSalva := False;

      cdsItensPedido.FieldByName('ITE_AUTRES').AsString := strAutIncPcd;

      If blnSalva Then
        cdsItensPedido.Post;

      cdsItensPedido.BeforePost  := nteBeforePost;
      cdsItensPedido.AfterPost   := nteAfterPost;
      cdsItensPedido.AfterScroll := nteAfterScroll;

    (*
      pExecutaNaPermanente(qryRecupera, strAutIncPcd, True);

      If Not fEmptyStr(qryRequisicao.SQL.Text) Then
        pExecutaNaPermanente(qryRequisicao, '');
        *)
    End;

  Finally
  End;
End;

Function TRecuperaPedido.fSQLPcmDetExcluidoUpdateAutInc: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL :=  strSQL + ' UPDATE PCMDET_RES SET EXCLUIDO = "S", DTAALT = :DTAALT ';
  strSQL :=  strSQL + ' WHERE ';
  strSQL :=  strSQL + '       PCD_CODITE = :CODITE ';
  strSQL :=  strSQL + '   AND PCD_SEQGER = :SEQGER ';

  Result := strSQL;
End;

Function TRecuperaPedido.fSQLPcmDetExcluidoUpdate: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL :=  strSQL + ' UPDATE PCMDET_RES SET EXCLUIDO = "S", DTAALT = :DTAALT ';
  strSQL :=  strSQL + ' WHERE ';
  strSQL :=  strSQL + '       PCD_CODITE = :CODITE ';
  strSQL :=  strSQL + '   AND PCD_NUMPED = :NUMPED ';
  strSQL :=  strSQL + '   AND PCD_CODEMP = :CODEMP ';
  strSQL :=  strSQL + '   AND PCD_ESPDOC = :ESPDOC ';
  strSQL :=  strSQL + '   AND PCD_NUMCTN = :NUMCTN ';

  Result := strSQL;
End;

Function TRecuperaPedido.fSQLPcmDetInsert: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL :=  strSQL + ' INSERT INTO PCMDET_RES (';
  strSQL :=  strSQL + '  PCD_SEQGER, ';
  strSQL :=  strSQL + '  PCD_CODITE, ';
  strSQL :=  strSQL + '  PCD_DESITE, ';
  strSQL :=  strSQL + '  PCD_NUMPED, ';
  strSQL :=  strSQL + '  PCD_CODEMP, ';
  strSQL :=  strSQL + '  PCD_ESPDOC, ';
  strSQL :=  strSQL + '  PCD_NUMCTN, ';
  strSQL :=  strSQL + '  AUTOINCREM, ';
  strSQL :=  strSQL + '  EXCLUIDO,   ';
  strSQL :=  strSQL + '  DTAALT      ';

  strSQL :=  strSQL + ') VALUES ( ';

  strSQL :=  strSQL + '  :SEQGER, ';
  strSQL :=  strSQL + '  :CODITE, ';
  strSQL :=  strSQL + '  :DESITE, ';
  strSQL :=  strSQL + '  :NUMPED, ';
  strSQL :=  strSQL + '  :CODEMP, ';
  strSQL :=  strSQL + '  :ESPDOC, ';
  strSQL :=  strSQL + '  :NUMCTN, ';
  strSQL :=  strSQL + '  :AUTINC, ';
  strSQL :=  strSQL + '   "S",    ';
  strSQL :=  strSQL + '  :DTAALT  ';

  strSQL :=  strSQL + ') ';

  Result := strSQL;
End;

procedure TRecuperaPedido.pMarcaExcluido;
  Var
    blnExcluido: Boolean;
begin
  With recPcmger Do
  Try
    If fEmptyStr(strAutInc) Then
      If Not fGravaCapa Then
        Exit;

    If fJaGravouItem(blnExcluido) Then
    Begin
      If fEmptyStr(strNumPed) Then
      Begin

        qryPcmDetExcluidoUpdateAutInc.Close;
        qryPcmDetExcluidoUpdateAutInc.ParamByName('SEQGER').AsString   := strAutInc;
        qryPcmDetExcluidoUpdateAutInc.ParamByName('CODITE').AsString   := cdsItensPedido.FieldByName('ITE_CODITE').AsString;
        qryPcmDetExcluidoUpdateAutInc.ParamByName('DTAALT').AsDateTime := VS_Date + fTime();
        qryPcmDetExcluidoUpdateAutInc.ExecSQL;

//        pExecutaNaPermanente(qryPcmDetExcluidoUpdateAutInc, '');

      End Else
      Begin

        qryPcmDetExcluidoUpdate.Close;
        qryPcmDetExcluidoUpdate.ParamByName('NUMPED').AsString   := strNumPed;
        qryPcmDetExcluidoUpdate.ParamByName('ESPDOC').AsString   := strEspDoc;
        qryPcmDetExcluidoUpdate.ParamByName('CODEMP').AsString   := strCodEmp;
        qryPcmDetExcluidoUpdate.ParamByName('NUMCTN').AsInteger  := intNumCtn;
        qryPcmDetExcluidoUpdate.ParamByName('CODITE').AsString   := cdsItensPedido.FieldByName('ITE_CODITE').AsString;
        qryPcmDetExcluidoUpdate.ParamByName('DTAALT').AsDateTime := VS_Date + fTime();
        qryPcmDetExcluidoUpdate.ExecSQL;

//        pExecutaNaPermanente(qryPcmDetExcluidoUpdate, '');
      End;

    End Else
    Begin
      qryPcmDetInsert.Close;
      qryPcmDetInsert.ParamByName('SEQGER').AsString  := recPcmger.strAutInc;
      qryPcmDetInsert.ParamByName('NUMPED').AsString  := strNumPed;
      qryPcmDetInsert.ParamByName('ESPDOC').AsString  := strEspDoc;
      qryPcmDetInsert.ParamByName('CODEMP').AsString  := strCodEmp;
      qryPcmDetInsert.ParamByName('NUMCTN').AsInteger := intNumCtn;
      qryPcmDetInsert.ParamByName('CODITE').AsString   := cdsItensPedido.FieldByName('ITE_CODITE').AsString;
      qryPcmDetInsert.ParamByName('DTAALT').AsDateTime := VS_Date + fTime();
      qryPcmDetInsert.ParamByName('DESITE').AsString   := cdsItensPedido.FieldByName('ITE_DESITE').AsString;
      qryPcmDetInsert.ExecSQL;

//      pExecutaNaPermanente(qryPcmDetInsert, fLastInsertID);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TRecuperaPedido.pMarcaExcluido]');
    End;
  End;
End;

procedure TRecuperaPedido.pUpdatePcmDet(blnZeraConf: Boolean);
  Var
    intQtdConCol: Integer;
begin
  If Not blnGravar Then
    Exit;

  With recPcmger, cdsItensPedido Do
  Begin
    intQtdConCol := 0;
    qryRecupera.Close;
    qryRecupera.SQL.Text := fGravaPcmDet(intQtdConCol,
                                         Nil,
                                         False,
                                         strEmpDes,
                                         '',
                                         '',
                                         FDeqTpc,
                                         strNumPed,                                // Número do Pedido
                                         strCodEmp,                                // Empresa
                                         strEspDoc,                                // Espécie (PD / OR)
                                         strCodFor,                                // Fornecedor
                                         FieldByName('ITE_CODITE').AsString,       // Código Item
                                         FieldByName('ITE_CODUNI').AsString,       // Código da Unidade
                                         IIF(fCfgSis('ENTITE', VarBoolean), FieldByName('ITE_DTAENT').AsDateTime, dtaDtaEnt), // Data Entrega
                                         horHorEnt,                                // Hora do Pedido
                                         dtaDtaPed,                                // Data do Pedido
                                         strConPag,                                // Cond. Pagamento
                                         FieldByName('ITE_DESITE').AsString,       // Descrição Item
                                         FieldByName('ITE_QTDITE').AsFloat,        // Quantidade
                                         FieldByName('ITE_UNITAR').AsFloat,        // Preço Unitario
                                         FieldByName('ITE_DESUNI').AsFloat,        // % Desconto Unitario
                                         FieldByName('ITE_DESUN2').AsFloat,        // % Desconto Unitario
                                         FieldByName('ITE_DESUN3').AsFloat,        // % Desconto Unitario
                                         FieldByName('ITE_DESUN4').AsFloat,        // % Desconto Unitario
                                         FieldByName('ITE_DESUN5').AsFloat,        // % Desconto Unitario
                                         FieldByName('ITE_DESUN6').AsFloat,        // % Desconto Unitario
                                         FieldByName('ITE_TOTITE').AsFloat,        // Total Itens S
                                         FieldByName('ITE_PERIPI').AsFloat,        // Percentual IPI
                                         FieldByName('ITE_TOTIPI').AsFloat,        // Total IPI
                                         FieldByName('ITE_PERSUB').AsFloat,        // Percentual SUB
                                         FieldByName('ITE_TOTSUB').AsFloat,        // Total SUB
                                         FieldByName('ITE_TOTDAR').AsFloat,        // Total DARE
                                         FieldByName('ITE_PERFCP').AsFloat,
                                         FieldByName('ITE_SUBFCP').AsFloat,
                                         FieldByName('ITE_QTDBAI').AsFloat,        // Quantidade Baixa
                                         FieldByName('ITE_TOTBAI').AsFloat,        // Total Baixado
                                         FieldByName('ITE_IPIBAI').AsFloat,        // IPI Baixado
                                         FieldByName('ITE_SUBBAI').AsFloat,        // SUB Baixado
                                         FieldByName('ITE_DARBAI').AsFloat,        // DARE Baixado
                                         0,                                        // SUB FCP Baixado
                                         0,                                        // fltFreBai
                                         0,                                        // fltAceBai
                                         FieldByName('ITE_VALFRE').AsFloat,        // fltValFre
                                         FieldByName('ITE_DESACE').AsFloat,        // fltDesAce
                                         0,                                        // Baixado?
                                         '',                                       // Origem do Documento (Faturamento)
                                         0,                                        // Número do Container
                                         strPedImp,                                // Pedido de Importação?
                                         strPedInt,                                // Pedido Intrepostado
                                         FieldByName('ITE_PEDTXT').AsString,       // Proveninete de Importação?
                                         FieldByName('ITE_QTDINC').AsFloat,       // Proveninete de Importação?
                                         FieldByName('ITE_TRAINC').AsFloat,       // Proveninete de Importação?

                                         strAutIncPcd,                             // Auto Incremento
                                         FieldByName('ITE_CODACA').AsString,       // Código do produto acabado
                                         FieldByName('ITE_EMPACA').AsString,       // Empresa do produto acabado
                                         FieldByName('ITE_PROACA').AsString,       // Produto acabado? (S/N)
                                         FieldByName('ITE_QTDCON').AsFloat,
                                         FieldByName('ITE_BASSUB').AsFloat,
                                         FieldByName('ITE_BASIPI').AsFloat,
                                         FieldByName('ITE_BASICM').AsFloat,
                                         FieldByName('ITE_PERBAS').AsFloat,
                                         FieldByName('ITE_ALQICM').AsFloat,
                                         FieldByName('ITE_VALICM').AsFloat,
                                         FieldByName('ITE_INCPIS').AsString = 'S',
                                         FieldByName('ITE_INCIRQ').AsString,
                                         FieldByName('ITE_ALQPIS').AsFloat,
                                         FieldByName('ITE_ALQCOF').AsFloat,
                                         FieldByName('ITE_ALQIMP').AsFloat,
                                         FieldByName('ITE_VALIMP').AsFloat,
                                         FieldByName('ITE_VALSIS').AsFloat,
                                         FieldByName('ITE_VALMAR').AsFloat,
                                         FieldByName('ITE_SEQFDO').AsString,
                                         FieldByName('ITE_QTDEMB').AsFloat,
                                         FieldByName('ITE_ALQPIS').AsFloat,
                                         FieldByName('ITE_ALQCOF').AsFloat,
                                         FieldByName('ITE_SUBUSU').AsString,
                                         FieldByName('ITE_DESPIS').AsFloat,        // fltDesPis: Double;
                                         True,                                     // blnTabRestaura: Boolean = False;
                                         strAutInc,                                // strSeqGer: String = '';
                                         False,                                    // blnInsere: Boolean = True;
                                         strAutIncPcd,                                       // strAutoin: String = '';
                                         False,                                    // blnVeioAutIncPcdInclusao: Boolean = False;
                                         -1,                                       // fltQtdOrc: Double = -1;
                                         0,                                        // dtaDatEdt: TDateTime = 0;
                                         FieldByName('ITE_UNILIQ').AsFloat,        // fltUniLiq: Double = 0
                                         FieldByName('ITE_ALQCBS').AsFloat,
                                         FieldByName('ITE_ALQIBS').AsFloat,
                                         FieldByName('ITE_ALQ_IS').AsFloat,
                                         FieldByName('ITE_VALCBS').AsFloat,
                                         FieldByName('ITE_VALIBS').AsFloat,
                                         FieldByName('ITE_VAL_IS').AsFloat);
      fStartTransaction();
      qryRecupera.ExecSQL;

//      pExecutaNaPermanente(qryRecupera, '');
      fCommit()
   End;

end;

Function TRecuperaPedido.fSQLBuscaItemAltPed: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   AUTOINCREM, EXCLUIDO ';
  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + '   PCMDET_RES ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   PCD_CODITE = :CODITE AND ';
  strSQL := strSQL + '   PCD_NUMPED = :NUMPED AND ';
  strSQL := strSQL + '   PCD_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   PCD_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   PCD_NUMCTN = :NUMCTN    ';

  Result := strSQL;
End;

Function TRecuperaPedido.fSQLBuscaItemIncPed: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   AUTOINCREM, EXCLUIDO ';
  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + '   PCMDET_RES ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   PCD_CODITE = :CODITE AND ';
  strSQL := strSQL + '   PCD_SEQGER = :SEQGER     ';

  Result := strSQL;
End;

Function TRecuperaPedido.fJaGravouItem(Var blnExcluido: Boolean): Boolean;
Begin
  With qryBuscaItem Do
  Begin
    Close;

    If fEmptyStr(recPcmger.strNumPed) Then
    Begin
      SQL.Text := fSQLBuscaItemIncPed;

      ParamByName('SEQGER').AsString := recPcmger.strAutInc;
      ParamByName('CODITE').AsString := cdsItensPedido.FieldByName('ITE_CODITE').AsString;
    End Else
    Begin
      SQL.Text := fSQLBuscaItemAltPed;

      ParamByName('CODITE').AsString  := cdsItensPedido.FieldByName('ITE_CODITE').AsString;
      ParamByName('NUMPED').AsString  := recPcmger.strNumPed;
      ParamByName('ESPDOC').AsString  := recPcmger.strEspDoc;
      ParamByName('CODEMP').AsString  := recPcmger.strCodEmp;
      ParamByName('NUMCTN').AsInteger := recPcmger.intNumCtn;
    End;

    Open;

    Result := Not IsEmpty;

    If Result Then
      strAutIncPcd := FieldByName('AUTOINCREM').AsString
    Else
      strAutIncPcd := '';

    blnExcluido := Result And (FieldByName('EXCLUIDO').AsString = 'S');
  End;
End;

Procedure TRecuperaPedido.pAtualizaItem;
  Var
    blnExcluido,
    blnGravouCapa,
    blnNovoItem: Boolean;
Begin
  If Not blnGravar Then
    Exit;

  blnGravouCapa := False;

  If fEmptyStr(recPcmger.strCodFor) Then
    Exit;

  Try
    fStartTransaction;

    If fEmptyStr(recPcmger.strAutInc) Then
    Begin
      blnGravouCapa := fGravaCapa;

      If Not blnGravouCapa Then
      Begin
        fRollBack;
        Exit;
      End;
    End;

    blnNovoItem := Not fJaGravouItem(blnExcluido);

    If Not blnNovoItem Then
      pUpdatePcmDet(blnZerCon)
    Else
      pIncluiItem(blnZerCon);

    If Assigned(cdsItensMultiLojas) And cdsItensMultiLojas.Filtered And
       (Pos('ITE_CODITE', cdsItensMultiLojas.Filter) > 0) And
       (cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString = cdsItensPedido.FieldByName('ITE_CODITE').AsString) Then
    Begin

      cdsItensMultiLojas.DisableControls;

      Try

        cdsItensMultiLojas.First;
        While Not cdsItensMultiLojas.Eof Do
        Begin

          If blnNovoItem Or
            (cdsItensMultiLojas.FieldByName('ITE_QTDTMP').AsFloat <> cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat) Then
            pPcddetAfterPost(cdsItensMultiLojas);

          cdsItensMultiLojas.Next;
        End;

      Finally
        cdsItensMultiLojas.EnableControls;
      End;

    End;

    fCommit;
  Except
    On E: Exception Do
    Begin
      If  blnGravouCapa Then
        pLimpaDados;

      fRollBack;
      pMensagensErro(E.Message, '[TRecuperaPedido.pAtualizaItem]');
    End;
  End;
End;

Procedure TRecuperaPedido.pApagaPedido(strAutInc: String);
  Var
    qryPcmger: TUniQuery;
Begin
  qryPcmger := fCriaQuery;

  With qryPcmger, SQL Do
  Begin
   (*
    Add('DELETE FROM PCMGER_RES WHERE AUTOINCREM = :AUTINC;');

    Add('DELETE FROM CADINT WHERE INT_VALKEY = :AUTINC;');
    *)

    Add('UPDATE PCMGER_RES SET PCG_EXCLUI = "S" WHERE AUTOINCREM = :AUTINC;');

    ParamByName('AUTINC').AsString := strAutInc;

    ExecSQL;
  End;

  FreeAndNil(qryPcmger);
End;

Procedure TRecuperaPedido.pApagaCopiaSeguranca;
Begin
  If fEmptyStr(recPcmger.strAutInc) Then
    Exit;

  pApagaPedido(recPcmger.strAutInc);

  pLimpaDados;
End;

Function TRecuperaPedido.fSQLPedidos(strNumPed, strCodEmp, strEspDoc: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT';

  strSQL := strSQL + '   P.*, ';

  strSQL := strSQL + '   P.AUTOINCREM AS AUTINC, ';
  strSQL := strSQL + '   PCG_CODCMP AS CODOPE, ';
  strSQL := strSQL + '   OPE_NOMOPE AS NOMOPE, ';
  strSQL := strSQL + '   PCG_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   PCG_NUMPED AS NUMPED, ';
  strSQL := strSQL + '   PCG_CODFOR AS CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR, ';
  strSQL := strSQL + '   PCG_DTAPED AS DTAPED, ';
  strSQL := strSQL + '   PCG_MOEDA_ AS MOEDA_  ';

  strSQL := strSQL + ' FROM ';

  strSQL := strSQL + ' PCMGER_RES P ';

  strSQL := strSQL + ' LEFT JOIN CADFOR ON FOR_CODFOR = PCG_CODFOR ';

  strSQL := strSQL + ' LEFT JOIN CADOPE ON OPE_CODOPE = PCG_CODCMP ';

  strSQL := strSQL + ' WHERE ';

  strSQL := strSQL + '   PCG_EXCLUI = "N" ';

  If fEmptyStr(strNumPed) Then
  Begin
    strSQL := strSQL + ' AND IFNULL(PCG_NUMPED, "") = "" ';

    strSQL := strSQL + ' AND ((IFNULL(PCG_CODCMP, "") = "") OR (PCG_CODCMP = ' + QuotedStr(strLoginUsuarioLogado) + ')) ';

  End Else
    strSQL := strSQL + ' AND PCG_NUMPED = ' + QuotedStr(strNumPed);

  If Not fEmptyStr(strEspDoc) Then
    strSQL := strSQL + ' AND PCG_ESPDOC = ' + QuotedStr(strEspDoc);

  If fEmptyStr(strCodEmp) Then
    strSQL := strSQL + ' AND PCG_CODEMP = ' + QuotedStr(VS_strCodEmp)
  Else
    strSQL := strSQL + ' AND PCG_CODEMP = ' + QuotedStr(strCodEmp);

  Result := strSQL;
End;

Function TRecuperaPedido.fSelecionaRecuperaPedido(strNumPed, strCodEmp, strEspDoc: String): Boolean;
Begin
  blnCancelou := False;

  Result := False;

  cdsPedidos.qryQuery.SQL.text := fSQLPedidos(strNumPed, strCodEmp, strEspDoc);
  cdsPedidos.fAbreClient(True);

  If Not cdsPedidos.IsEmpty Then
  Begin
    cdsPedidos.pAlinhaCampoCentro('CODOPE');
    cdsPedidos.pAlinhaCampoCentro('CODEMP');
    cdsPedidos.pAlinhaCampoCentro('NUMPED');
    cdsPedidos.pAlinhaCampoCentro('CODFOR');
    cdsPedidos.pAlinhaCampoCentro('DTAPED');

    pCriarFormularios(TfrmRecuperaPedidoSelec, frmRecuperaPedidoSelec);

    frmRecuperaPedidoSelec.cxvPedidos.DataController.DataSource := cdsPedidos.dtsSource;

    frmRecuperaPedidoSelec.objRecupera := Self;

    Result := frmRecuperaPedidoSelec.ShowModal = mrOk;

    blnCancelou := (Not Result) And (Not cdsPedidos.IsEmpty);

    FreeAndNil(frmRecuperaPedidoSelec);
  End;

End;

Function TRecuperaPedido.fMarcaPedido: Boolean;
Begin
  Result := False;

  recPcmger.blnRecuperaPedido := False;


  If cdsPedidos.IsEmpty Then
  Begin
    pMensagemOk('Nenhum pedido para recuperar!');
    Exit;
  End;

(*
  strTrava := 'RESTAURA_PEDIDO' + cdsPedidos.FieldByName('AUTINC').AsString;

  If (Not fLock_Unlock(strTrava, True, False)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strTrava), ['&Ok']);
    strTrava := '';
    Exit;
  End;
  *)

  Result := fRecuperaCapaInclusaoAbortada;

  recPcmger.blnRecuperaPedido := Result;
End;

Function TRecuperaPedido.fRecuperaCapaInclusaoAbortada: Boolean;
Begin
  With cdsPedidos, recPcmger Do
  Begin
    strAutInc := FieldByName('AUTOINCREM').AsString;  // Sequencial da tabela

    strNumPed := FieldByName('PCG_NUMPED').AsString;  // Número do Pedido
    blnSomaDescontoAdcionalFornecedor1 := FieldByName('PCG_ADAFO1').AsString = 'S';  // Número do Pedido
    strCodEmp := FieldByName('PCG_CODEMP').AsString;  // Empresa
    strEspDoc := FieldByName('PCG_ESPDOC').AsString;  // Espécie (PD / OR)
    strCodFor := FieldByName('PCG_CODFOR').AsString;  // Fornecedor

    strConPag := FieldByName('PCG_CONPAG').AsString;   // Cond. Pagamento
    dtaDtaPed := FieldByName('PCG_DTAPED').AsDateTime;

    dtaDtaEnt := FieldByName('PCG_DTAENT').AsDateTime;
    dtaDtaFat := FieldByName('PCG_DTAFAT').AsDateTime;

    strCompra := FieldByName('PCG_CODCMP').AsString; // Comprador

    intNumCtn := FieldByName('PCG_NUMCTN').AsInteger; // Número do Container

    intMoeda  := FieldByName('PCG_MOEDA_').AsInteger; // Moeda do Pedido

    strPedImp := FieldByName('PCG_PEDIMP').AsString; // Pedido de Importação?
    strPedInt := FieldByName('PCG_PEDINT').AsString; // Pedido Intrepostado?
    strPedBon := FieldByName('PCG_PEDBON').AsString; // Pedido Bonificação?
    strZeraST := FieldByName('PCG_ZERAST').AsString; // Zera Subst Tribut?
    strDesPdi := FieldByName('PCG_DESPDI').AsString; // Descrição do item no pedido de bonificação

    strCodCta := FieldByName('PCG_CODCTA').AsString;  // Centro de Custo
    strNomEnt := FieldByName('PCG_NOMENT').AsString;  // Nome p/ Entrega
    strEndEnt := FieldByName('PCG_ENDENT').AsString;  // Endereço p/ Entrega
    strCidEnt := FieldByName('PCG_CIDENT').AsString;  // Cidade p/ Entrega

    strPedMlj := FieldByName('PCG_PEDMLJ').AsString;  // PEDIDO MULTI-LOJA

    strUsaGir := FieldByName('PCG_USAGIR').AsString;

    fltValFre := FieldByName('PCG_VALFRE').AsFloat;
    fltDesAce := FieldByName('PCG_DESACE').AsFloat;
    fltDesAdi := FieldByName('PCG_DESADI').AsFloat;   // Desconto Adicional

    Result := True;
  End;
End;

Procedure TRecuperaPedido.pSetItensMultiLojas(Value: TUniClientDataSet);
Begin
  FItensMultiLojas := Value;
//  FItensMultiLojas.AfterPost := pPcddetAfterPost;
End;

Procedure TRecuperaPedido.pPcddetAfterPost(dataSet: TDataSet);
  Var
    strIncPCDDET: String;
Begin
  If Not blnGravar Then
    Exit;

  Try
    Try
      With dataSet, recPcmger Do
      Begin
        If IsEmpty Then
          Exit;

        If fEmptyStr(strAutInc) Then
          If Not fGravaCapa Then
            Exit;

        qryRecupera.Close;
        qryRecupera.SQL.Text := fGravarPcdDet('',
                      strCodEmp,
                      FieldbyName('ITE_CODITE').AsString,
                      FieldbyName('ITE_CODEMP').AsString,
                      strEspDoc,
                      strNumPed,
                      FieldByName('ITE_QTDITE').AsFloat,
                      strAutInc,
                      True,
                      strAutInc,
                      FieldbyName('ITE_INCIRQ').AsString);

        qryRecupera.ExecSQL;

        strIncPCDDET := fLastInsertID;

//        pExecutaNaPermanente(qryRecupera, strIncPCDDET, True);
      End;


    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TRecuperaPedido.pPcddetAfterPost');
      End;
    End;
  Finally
  End;

End;

Function TRecuperaPedido.fSQLMultiloja: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';

  strSQL := strSQL + '  D.*,      ';
  strSQL := strSQL + '  EXCLUIDO  ';

  strSQL := strSQL + ' FROM ';

  strSQL := strSQL + '   PCDDET_RES D ';

  strSQL := strSQL + '   INNER JOIN PCMDET_RES I ON I.PCD_SEQGER = D.PCD_SEQPCG AND ';
  strSQL := strSQL + '                              I.PCD_CODITE = D.PCD_CODITE     ';

  strSQL := strSQL + ' WHERE ';

  strSQL := strSQL + '   D.PCD_SEQPCG = :SEQPCG ';

  Result := strSQL;
End;

Procedure TRecuperaPedido.pAtualizaDadosMultiloja;
  Var
    frmGravando: TfrmGravando;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    With frmGravando Do
    Begin
      lblGravando.Caption := 'Recuperando dados multiloja, aguarde...';

      fExecutarAcao := fAtualizaDadosMultilojaPrg;

      ShowModal;

     // Result := blnConfirma;
    End;

    FreeAndNil(frmGravando);

  Except

    On E: Exception Do
    Begin
    //  Result := False;
      pMensagensErro(E.Message, '[pAtualizaDadosMultiloja]');
    End;

  End;
End;

Function TRecuperaPedido.fAtualizaDadosMultilojaPrg(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryMulLoj: TUniQuery;
Begin
  pgbProgresso.Properties.Max := 0;
  pgbProgresso.Position := 0;
  Application.ProcessMessages;

  cdsItensMultiLojas.Filtered := False;

  qryMulLoj := fCriaQuery;

  With qryMulLoj Do
  Begin
    SQL.Text := fSQLMultiloja;

    ParamByName('SEQPCG').AsInteger := StrToIntDef(recPcmger.strAutInc, 0);

    Open;

    pgbProgresso.Properties.Max := RecordCount;

    If Not SameText(cdsItensMultiLojas.IndexFieldNames, 'ITE_CODITE;ITE_CODEMP') Then
      cdsItensMultiLojas.IndexFieldNames := 'ITE_CODITE;ITE_CODEMP';

    While Not Eof Do
    Begin

      If cdsItensMultiLojas.FindKey([FieldByName('PCD_CODITE').AsString, FieldByName('PCD_EMPDES').AsString]) Then
      Begin

        If FieldByName('EXCLUIDO').AsString = 'S' Then
        Begin

          cdsItensMultiLojas.Delete;

        End Else
        Begin

          cdsItensMultiLojas.Edit;
          cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat := FieldByName('PCD_QTDITE').AsFloat;
          cdsItensMultiLojas.Post;

        End;

      End

      Else If FieldByName('EXCLUIDO').AsString <> 'S' Then
      Begin

        cdsItensMultiLojas.Insert;

        cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat  := FieldByName('PCD_QTDITE').AsFloat;
        cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString := FieldByName('PCD_CODITE').AsString;
        cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString := FieldByName('PCD_EMPDES').AsString;

        cdsItensMultiLojas.Post;

      End;

      Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;

    End;

  End;

  Result := True;
  FreeAndNil(qryMulLoj);
End;

end.



