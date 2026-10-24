{****************************************}
{* Nova forma de Conciliação de Cartões *}
{* KONCILIA                             *}
{*************************************AJ*}
unit untConciliacaoKoncilia;

interface

Uses Classes, Forms, Uni, UniClientDataSet, untFuncoesSimples, untFuncoes,
     UniDataSetProvider, cxProgressBar, Types, System.Sysutils, StrUtils,
     System.Variants, DB, untTypesSistema, frxClass, frxDBSet, untFuncFat,
     Graphics, untMovCar, untConciliacaoCartoes;


type TConcilKoncilia = class(TConciliacaoCartoes)
  private
    intQtdReg     : Integer;
    lstConcil     : TStringList;

    FFiltrarTodosAjustes: Boolean;
    FVincularAjustesNasVendas:Boolean;

    FPeriodoFiltro,
    FListaDePedidos,
    FCartoesKoncili,
    FPedidosDevolvidos: String;

    procedure pFiltraCartoesKoncilia;
    procedure pFiltraCartoesBaixadosKoncilia;
    procedure FilterDataSetComissaoFrete(Var AClientADataSet: TUniClientDataSet);
    function RetornaCampoSQLValorLiquido:String;
    function CorrigeValorBruto: Double;

    function fBuscaCartaoKoncilia(strID_Ped, strNumPed, strParcel: String): Boolean;
    function fBuscaCartaoBaixadoKoncilia(strID_Ped, strNumPed, strParcel: String): Boolean;
    procedure pMarcaResolverAPI(strID_Ped, strNumPed, strParcel: String);

    procedure pGravarCancelado;
    procedure pSetaLabelsRelatorio;

    function fProcessaKonciliaPag(pgbStatus: TcxProgressBar = Nil): Boolean;

    function fConciliaKoncilia: Boolean;

    procedure pCorrigeAutorizacaoMarketPlaceMovCar;
    procedure pCorrigeComissaoEFrete(cdsComissaoEFrete: TUniClientDataSet;
                                     Var pgbStatus: TcxProgressBar);
    function fRetornaNumeroPedidoMarketPlace(strNumPOK: String): String;
    function fRetornaMarketPlaceMovCar(strNumPOK: String): String;
    function fRetornaDescricaoCancelamento: String;

    procedure FiltraCancelamentosKoncilia(ASQLCondicao,
                                          ATipoAjuste,
                                          AAjusteCredito: String;
                                          ADatasetFretesAjustes: TUniClientDataset;
                                          Var pgbStatus: TcxProgressBar);

    function AjusteJaAdicionadoNoRegistroDeVenda(ADatasetAjuste, ADatasetAdicionados: TDataset): Boolean;

    function RetornaListaDePedidos: String;
    function PedidoDevolvido(AValorLiquido:Double):Boolean;
    function RetornaTipoCartao:String;

    function ValorBrutoNaMovCarPossuiFrete(var AValorBrutoAtual: Double): Boolean;
    function VendaCancelada:Boolean;
  public
    function fConciliaCartoes: Boolean; override;

  protected

  end;

implementation
Uses untGravando;

function TConcilKoncilia.AjusteJaAdicionadoNoRegistroDeVenda(
  ADatasetAjuste, ADatasetAdicionados: TDataset): Boolean;
begin
  Try
    ADatasetAdicionados.Filter := 'KON_CODEST=' + ADatasetAjuste.FieldByName('KON_CODEST').AsString.QuotedString + ' AND ' +
                                  ' KON_NUMPED=' + ADatasetAjuste.FieldByName('KON_NUMPED').AsString.QuotedString + ' AND ' +
                                  ' KON_ID_KON=' + ADatasetAjuste.FieldByName('KON_ID_KON').AsString.QuotedString + ' AND ' +
                                  ' KON_STATUS=' + ADatasetAjuste.FieldByName('KON_STATUS').AsString.QuotedString + ' AND ' +
                                  ' KON_DTATRA=' + FormatDateTime('dd/mm/yyyy', ADatasetAjuste.FieldByName('KON_DTATRA').AsDateTime).QuotedString + ' AND ' +
                                  ' KON_DTAPAG=' + FormatDateTime('dd/mm/yyyy', ADatasetAjuste.FieldByName('KON_DTAPAG').AsDateTime).QuotedString + ' AND ' +
                                  ' KON_MARKET=' + ADatasetAjuste.FieldByName('KON_MARKET').AsString.QuotedString + ' AND ' +
                                  ' KON_TIPREG=' + ADatasetAjuste.FieldByName('KON_TIPREG').AsString.QuotedString + ' AND ' +
                                  ' KON_NUMPAR=' + ADatasetAjuste.FieldByName('KON_NUMPAR').AsString.QuotedString + ' AND ' +
                                  ' RETIRAR_AJUSTES=''S'' ';
    ADatasetAdicionados.Filtered := True;

    Result := Not ADatasetAdicionados.IsEmpty;
  Finally
    ADatasetAdicionados.Filtered := False;
  End;
end;

function TConcilKoncilia.RetornaCampoSQLValorLiquido: String;
begin
  Result := ' SUM(A.KON_VALBRU) AS KON_VALPAR  ';
end;

function TConcilKoncilia.CorrigeValorBruto: Double;
  Var
    LDiferenca: Double;
begin
  Result := cdsConCar.FieldByName('KON_VALPAR').Value;

  If Not FVincularAjustesNasVendas Then
    Exit;

  If Not fCfgSis('KONBRU', varBoolean) Then
    Exit;

  LDiferenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - cdsConCar.FieldByName('KON_VALPAR').Value;

  If Not (fBetween(LDiferenca, -0.0299999, 0.029999)) Then
  Begin
    cdsConCar.Edit;
    cdsConCar.FieldByName('KON_VALPAR').AsFloat :=  cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
    cdsConCar.Post;
    Result := cdsConCar.FieldByName('KON_VALPAR').Value;
  End;

end;

function TConcilKoncilia.fBuscaCartaoBaixadoKoncilia(strID_Ped, strNumPed, strParcel: String): Boolean;
begin
  Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                             VarArrayOf([UpperCase(strID_Ped),
                                         strParcel]),[]);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                               VarArrayOf([UpperCase(strNumPed),
                                           strParcel]),[]);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                               VarArrayOf([UpperCase(strNumPed),
                                           strParcel]),[]);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                               VarArrayOf([UpperCase(strID_Ped),
                                           strParcel]),[]);

  blnAutomatica := (Result) And
                   (Not cdsBaixad.FieldByName('MCA_CHACON').AsString.IsEmpty);
end;

function TConcilKoncilia.fBuscaCartaoKoncilia(strID_Ped, strNumPed, strParcel: String): Boolean;
begin
  Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                             VarArrayOf([UpperCase(strID_Ped),
                                         strParcel, 'D']),[]);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                               VarArrayOf([UpperCase(strNumPed),
                                           strParcel, 'D']),[]);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                               VarArrayOf([UpperCase(strNumPed),
                                           strParcel, 'D']),[]);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                               VarArrayOf([UpperCase(strID_Ped),
                                           strParcel, 'D']),[]);

   If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                               VarArrayOf([fPadL(UpperCase(strNumPed), 14, '0'),
                                           strParcel, 'D']),[]);
end;

function TConcilKoncilia.fConciliaCartoes: Boolean;
begin
  Result := fConciliaKoncilia;
end;

function TConcilKoncilia.fConciliaKoncilia: Boolean;
Begin
  Result       := False;
  blnInconsist := False;

  FFiltrarTodosAjustes := fCfgSis('KONAJU', varBoolean);
  FVincularAjustesNasVendas :=  fCfgSis('AJUVEN', varBoolean);

  Try
    pCriaClientInconsist;
    cdsInconsistencia.Open;
    cdsInconsistencia.EmptyDataSet;

    //Para conciliação por Ponto de Venda
    objConcil.strTabCon := 'KON_KOPGTO';
    objConcil.strCamCon := 'KON_CODEST';
    objConcil.strNomCon := 'KONCILI';
    objConcil.strConfEs := 'CFG_KONKEY';
    objConcil.strValBru := 'KON_VALBRU';
    objConcil.strValLiq := 'KON_VALBRU';
    objConcil.strCodAut := 'KON_ID_PED';
    objConcil.strNumNSU := 'KON_NUMPED';
    objConcil.strDtaTra := 'KON_DTATRA';
    objConcil.strNumPar := 'KON_NUMPAR';
    objConcil.strTotPar := 'KON_TOTPAR';
    objConcil.strNumCar := 'KON_MARKET';
    objConcil.strDtaRec := 'KON_DTAPAG';
    objConcil.strTipReg := 'KON_TIPREG';
    objConcil.strConfPr := 'KONPOR';
    objConcil.strConfCt := 'KONCTA';
    objConcil.strConfFo := 'KONFOR';
    objConcil.strEventoCancelamentoAjuste := 'KONEVE';

    {**************************************}
    {* PEGANDO O PERÍODO PARA CONCILIAÇÃO *}
    {***********************************AJ*}
    If Not fDigPeriodo Then
      Exit;

    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := fProcessaKonciliaPag;
    frmGravando.lblGravando.Caption := 'Aguarde... Selecionando registros para conciliação (' + objConcil.strNomCon + ').';
    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmBaixaCartoes.fConciliaKoncilia]');
    End;
  End;

  blnInconsist := (Not cdsInconsistencia.IsEmpty);
  If Not cdsInconsistencia.IsEmpty Then
    fMensagem('','Foram encontradas inconsistências na conciliação!',['&OK']);
  If ((Assigned(cdsConCar)) And (cdsConCar.Active) And (Not cdsConCar.IsEmpty)) Or blnInconsist Then
  Begin
    pSetaLabelsRelatorio;

    Result := fExibeRelatIncons('EXTRATO ELETRÔNICO ' + objConcil.strNomCon + ' - RELATÓRIO DE CONCILIAÇÃO',
                                True,
                                'Núm. Pedido',
                                True,
                                'KONCILI');

    blnReabre := (Not Result) Or ((intQtdReg = 0) And Not blnInconsist);
    If Result Then
    Begin
      Result := ((intQtdReg > 0) Or blnInconsist);
      If ((intQtdReg = 0)  And Not blnInconsist) Then
        fMensagem('ATENÇÃO','Nenhum pagamento foi conciliado no período selecionado!',['&OK'])
      Else
        fMensagem('AVISO','Conciliação da ' + objConcil.strNomCon + ' realizada com sucesso.',['&OK']);
    End;
  End;
  FreeAndNil(cdsConCar);
End;

procedure TConcilKoncilia.FilterDataSetComissaoFrete(
  var AClientADataSet: TUniClientDataSet);
begin
  AClientADataSet.Filter :=' (KON_ID_PED=' + cdsConCar.FieldByName('KON_ID_PED').AsString.QuotedString + ' OR ' +
                           ' KON_NUMPED=' + cdsConCar.FieldByName('KON_NUMPED').AsString.QuotedString  + ') AND ' +
                           ' KON_MARKET=' + cdsConCar.FieldByName('KON_MARKET').AsString.QuotedString  +
                           ' AND KON_NUMPAR=' + cdsConCar.FieldByName('KON_NUMPAR').AsString.QuotedString;

end;

procedure TConcilKoncilia.FiltraCancelamentosKoncilia(ASQLCondicao, ATipoAjuste,
  AAjusteCredito: String; ADatasetFretesAjustes: TUniClientDataset; Var pgbStatus: TcxProgressBar);
  Var
    strSQL,
    strConfEm: String;
    qryCanc  : TUniQuery;
    objIncons: TInconsist;
    blnAjuCre: Boolean;
    strCodEmpresa: String;

    LSairWhile: Boolean;
begin
  Try
    qryCanc := fCriaQuery;

    strSQL := 'SELECT * FROM (';
    strSQL := strSQL + 'SELECT *, ';
    If Not fEmptyStr(ATipoAjuste) Then
       strSQL := strSQL + ATipoAjuste + ' AS TIPAJU, ';
    If Not fEmptyStr(AAjusteCredito) Then
       strSQL := strSQL + AAjusteCredito + ' AS AJUCRE, ';
    strSQL := strSQL + ' A.KON_CODEST AS EMPRESA, ';
    strSQL := strSQL + ' "N" AS MARCADO ';
    strSQL := strSQL + ' FROM ' + objConcil.strTabCon + ' A ';
    strSQL := strSQL + ' WHERE ' + ASQLCondicao ;

    strSQL := strSQL + ') AS TMP ';

    strSQL := strSQL + ' ORDER BY KON_DTAPAG, KON_NUMPED';

    qryCanc.Close;
    qryCanc.SQL.Text := strSQL;
    qryCanc.Open;

    If (blnGraAju) Then
    Begin
      cdsResolverAPICanc := CriarClientDataSet(qryCanc);
      cdsResolverAPICanc.Open;
    End;

    cdsAjustes := CriarClientDataSet(qryCanc);
    cdsAjustes.Open;

    strCodEmpresa := cdsAjustes.FieldByName(objConcil.strCamCon).AsString;
    strConfEm := cdsAjustes.FieldByName(objConcil.strCamCon).AsString;

    cdsAjustes.First;
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsAjustes.RecordCount;
    While Not cdsAjustes.Eof Do
    Begin
      pStepStatusGravacao(pgbStatus);
      LSairWhile := cdsAjustes.RecNo = cdsAjustes.RecordCount;

      If FVincularAjustesNasVendas Then
      Begin
        If AjusteJaAdicionadoNoRegistroDeVenda(cdsAjustes, ADatasetFretesAjustes) Then
        Begin
          cdsAjustes.Delete;

          If LSairWhile Then
            Break;

          Continue;
        End;
      End;

      objIncons := TInconsist.Create;
      blnAjuCre := (cdsAjustes.FindField('AJUCRE') <> Nil) And
                   (cdsAjustes.FieldByName('AJUCRE').Value <> 0);

      Inc(objTotCan.intQtdCar);
      If blnAjuCre Then
      Begin
        objTotCan.fltValCar := objTotCan.fltValCar + cdsAjustes.FieldByName('AJUCRE').Value *
                                                     IIF(cdsAjustes.FieldByName('AJUCRE').Value > 0, 1, -1);
        objTotCan.fltValLiq := objTotCan.fltValLiq + cdsAjustes.FieldByName('AJUCRE').Value *
                                                     IIF(cdsAjustes.FieldByName('AJUCRE').Value > 0, 1, -1);
      End
      Else
      Begin
        objTotCan.fltValCar := objTotCan.fltValCar + cdsAjustes.FieldByName(objConcil.strValBru).Value *
                                                     IIF(cdsAjustes.FieldByName(objConcil.strValBru).Value < 0, 1, -1);
        objTotCan.fltValLiq := objTotCan.fltValLiq + cdsAjustes.FieldByName(objConcil.strValLiq).Value *
                                                     IIF(cdsAjustes.FieldByName(objConcil.strValLiq).Value < 0, 1, -1);
      End;

      objIncons.strDescri := 'Cancelamentos/Ajustes';

      If cdsAjustes.FieldByName('KON_TIPREG').AsString = 'DEVOLUTION' Then
        objIncons.strDescri := 'Devoluções';

      objIncons.strNomCli := IIF(cdsAjustes.FindField('TIPAJU') <> Nil, cdsAjustes.FieldByName('TIPAJU').AsString, '');
      objIncons.strNumDup := fStrZero('0', 12);
      objIncons.strAutori := cdsAjustes.FieldByName(objConcil.strNumNsu).AsString;

      objIncons.strNumNSU := cdsAjustes.FieldByName(objConcil.strNumNSU).AsString;
      
      objIncons.strNum_PV := cdsAjustes.FieldByName(objConcil.strCamCon).AsString;
      objIncons.strNumCar := cdsAjustes.FieldByName('KON_MARKET').AsString;

      objIncons.strTipCar := 'CANCELAMENTOS/AJUSTES';
      objIncons.strDta_CV := FormatDateTime('dd/mm/yyyy', IIF(cdsAjustes.FieldByName(objConcil.strDtaTra).IsNull,
                                                              cdsAjustes.FieldByName(objConcil.strDtaRec).Value,
                                                              cdsAjustes.FieldByName(objConcil.strDtaTra).Value));

      objIncons.strParcel := IIF(cdsAjustes.FieldByName(objConcil.strNumPar).AsInteger = 0, '01', fStrZero(cdsAjustes.FieldByName(objConcil.strNumPar).AsString, 2)) + '/' +
                             IIF(cdsAjustes.FieldByName(objConcil.strTotPar).AsInteger = 0, '01', fStrZero(cdsAjustes.FieldByName(objConcil.strTotPar).AsString, 2));


      objIncons.strNumCCD := Trim(cdsAjustes.FieldByName(objConcil.strCodAut).AsString);

      If blnAjuCre Then
      Begin
        objIncons.strValOri := FormatFloat('#,##0.00', cdsAjustes.FieldByName('AJUCRE').Value *
                                                       IIF(cdsAjustes.FieldByName('AJUCRE').Value > 0, 1, -1));
        objIncons.strValLiq := FormatFloat('#,##0.00', cdsAjustes.FieldByName('AJUCRE').Value *
                                                       IIF(cdsAjustes.FieldByName('AJUCRE').Value > 0, 1, -1));

        objIncons.BrutoMarketPlace := cdsAjustes.FieldByName('AJUCRE').Value;
        objIncons.LiquidoMarketPlace := cdsAjustes.FieldByName('AJUCRE').Value;
      End
      Else
      Begin
        objIncons.strValori := FormatFloat('#,##0.00', cdsAjustes.FieldByName(objConcil.strValBru).Value *
                                                       IIF(cdsAjustes.FieldByName(objConcil.strValBru).Value < 0, 1, -1));
        objIncons.strValLiq := FormatFloat('#,##0.00', cdsAjustes.FieldByName(objConcil.strValLiq).Value *
                                                       IIF(cdsAjustes.FieldByName(objConcil.strValLiq).Value < 0, 1, -1));

        objIncons.BrutoMarketPlace := cdsAjustes.FieldByName(objConcil.strValBru).Value;
        objIncons.LiquidoMarketPlace := cdsAjustes.FieldByName(objConcil.strValLiq).Value;
      End;

      objIncons.strDtaRec := FormatDateTime('dd/mm/yyyy', cdsAjustes.FieldByName('KON_DTAPAG').Value);
      objIncons.strNomEmp := strConfEm + '-' + fRetNomeEmpresaSelec(strConfEm);
      objIncons.strPorBai := fCfgSis(objConcil.strConfPr);
      objIncons.strCtaBai := fCfgSis(objConcil.strConfCt);
      objIncons.strForTax := fCfgSis(objConcil.strConfFo, varString);
      objIncons.intConcil := cdsAjustes.FieldByName(LeftStr(objConcil.strCodAut, 4) + 'CONCIL').AsInteger;
      objIncons.HistoricoBaixa := cdsAjustes.FieldByName('KON_CODCON').Value;

      objIncons.strEventoCancelamentoAjuste := fCfgSis(objConcil.strEventoCancelamentoAjuste);

      objIncons.Operadora := 'KONCILI';

      If (fCfgSis('BAIDEB') = 'S') Then
      Begin
        If fEmptyStr(strCodEmpresa) Then
          objIncons.strSituacaoCadastro :=  'INCOMPLETO'
        Else
        Begin
          If (fEmptyStr(fCfgSis(objConcil.strConfPr, varString, strCodEmpresa))) Or
             (fEmptyStr(fCfgSis(objConcil.strConfCt, varString, strCodEmpresa))) Or
             (fEmptyStr(fCfgSis(objConcil.strConfFo, varString, strCodEmpresa))) Or
             (fCfgSis('CTPOBE', varBoolean) and
              fEmptyStr(fCfgSis(objConcil.strEventoCancelamentoAjuste, varString, strCodEmpresa))) Then
            objIncons.strSituacaoCadastro :=  'INCOMPLETO'
          Else
            objIncons.strSituacaoCadastro :=  'COMPLETO';
        End;
      End;

      //Gravando na cdsBaiCar caso seja Ajuste
      If blnGraAju And (Pos(cdsAjustes.FieldByName('KON_ID_PED').AsString,FPedidosDevolvidos) <= 0) Then
      Begin
        pGravaAjustes(objIncons);

        If cdsResolverAPICanc.Locate('KON_CODEST;KON_DTAPAG;KON_DTATRA;KON_ID_KON;KON_MARKET;KON_NUMPAR;KON_NUMPED;KON_STATUS;KON_TIPREG',
                                     VarArrayOf([cdsAjustes.FieldByName('KON_CODEST').Value,
                                                 cdsAjustes.FieldByName('KON_DTAPAG').Value,
                                                 cdsAjustes.FieldByName('KON_DTATRA').Value,
                                                 cdsAjustes.FieldByName('KON_ID_KON').Value,
                                                 cdsAjustes.FieldByName('KON_MARKET').Value,
                                                 cdsAjustes.FieldByName('KON_NUMPAR').Value,
                                                 cdsAjustes.FieldByName('KON_NUMPED').Value,
                                                 cdsAjustes.FieldByName('KON_STATUS').Value,
                                                 cdsAjustes.FieldByName('KON_TIPREG').Value]),
                                    []) Then
        Begin
          cdsResolverAPICanc.Edit;
          cdsResolverAPICanc.FieldByname('MARCADO').AsString := 'S';
          cdsResolverAPICanc.Post;
        End;
      End;

      pGravaInconsistencia(objIncons);
      FreeAndNil(objIncons);

      cdsAjustes.Next;
    End;

    qryCanc.Close;

  Finally
    FreeAndNil(qryCanc);
  End;
end;

function TConcilKoncilia.fProcessaKonciliaPag(pgbStatus: TcxProgressBar): Boolean;
Var
  fltValor   : Double;
  fltDifere  : Double;
  strSQL     : String;
  strTmpLog  : String;
  strIndAnt  : String;
  qryConCar  : TUniQuery;
  intRecNo   : Integer;
  fltValMar  : Double;
  blnBusca   : Boolean;
  strTipo    : String;
  objIncons  : TInconsist;
  strID_Ped  : String;
  strParcela : String;

  strCancelado: String;

  cdsComissaoEFrete: TUniClientDataSet;
  LChaCon:String;
begin
  strRcxTcc := fCfgSis('RCXTCC');
  qryConCar := fCriaQuery(Nil);
  lstConcil := TStringList.Create;
  fltValSem := 0;

  Application.ProcessMessages;

  FPeriodoFiltro := ' ((A.KON_DTAPAG BETWEEN :DTAIN AND :DTAFIM) OR  '+
                       'A.KON_DTAFIN BETWEEN (SELECT MIN(B.KON_DTAFIN) FROM KON_KOPGTO B WHERE B.KON_DTAPAG BETWEEN :DTAIN AND :DTAFIM) AND '+
                                            '(SELECT MAX(B.KON_DTAFIN) FROM KON_KOPGTO B WHERE B.KON_DTAPAG BETWEEN :DTAIN AND :DTAFIM))    ';

   If fEmptyStr(strIDConciliacao) Then
     FPeriodoFiltro := ' A.KON_DTAPAG BETWEEN :DTAIN AND :DTAFIM ';

  If blnConciliarDataImportacao Then
    FPeriodoFiltro := ' A.KON_DTAFIN BETWEEN :DTAIN AND :DTAFIM ';

  strCancelado := '  (SELECT COUNT(*) FROM KON_KOPGTO C WHERE                     ' +
                  '   C.KON_CODEST=A.KON_CODEST AND C.KON_NUMPED=A.KON_NUMPED AND ' +
                  '   C.KON_ID_PED=A.KON_ID_PED AND C.KON_MARKET=A.KON_MARKET AND ' +
                  '   C.KON_NUMPAR=A.KON_NUMPAR AND C.KON_STATUS="CANCELED" AND   ' +
                  '   C.KON_DTAPAG >= A.KON_DTAPAG) AS CANCELADO,                 ' +

                  '(SELECT                                           '+
                  '   SUM(KON_VALBRU)                                '+
                  ' FROM                                             '+
                  '   KON_KOPGTO C                                   '+
                  ' WHERE C.KON_CODEST = A.KON_CODEST                '+
                  '   AND C.KON_NUMPED = A.KON_NUMPED                '+
                  '   AND C.KON_ID_PED = A.KON_ID_PED                '+
                  '   AND C.KON_MARKET = A.KON_MARKET                '+
                  '   AND C.KON_NUMPAR = A.KON_NUMPAR                '+
                  '   AND C.KON_STATUS = "CANCELED"                  '+
                  '   AND C.KON_TIPREG = "DEVOLUTION"                '+
                  '   AND C.KON_DTAPAG >= A.KON_DTAPAG) AS DEVOLVIDO ';

  //Selecionando a tabela de importação de pagamentos da KONCILIA
  strSQL := '';
  strSQL := strSQL + ' SELECT '+RetornaCampoSQLValorLiquido+',';
  strSQL := strSQL + '        A.*, A.KON_CODEST AS CODEMP, EMP_NOMEMP,';

  strSQL := strSQL + '    IF(                                         ';
  strSQL := strSQL + '      A.KON_MARKET IN ("MERCADOLIVRE")          ';
  strSQL := strSQL + '      AND A.KON_TIPREG = "SALE",                ';
  strSQL := strSQL + '      IF(                                       ';
  strSQL := strSQL + '        A.KON_VALBRU < A.KON_VALPAR,            ';
  strSQL := strSQL + '        "AJUSTE MERCADO LIVRE",                 ';
  strSQL := strSQL + '        A.KON_TIPREG                            ';
  strSQL := strSQL + '      ),                                        ';
  strSQL := strSQL + '      A.KON_TIPREG                              ';
  strSQL := strSQL + '    ) AS TIPO_REGISTRO,                         ';

  strSQL := strSQL + '        "N" AS MARCADO, "N" AS RETIRAR_AJUSTES, ';
  strSQL := strSQL + strCancelado;
  strSQL := strSQL + ' FROM KON_KOPGTO A                              ';
  strSQL := strSQL + ' LEFT JOIN CADEMP E ON                          ';
  strSQL := strSQL + '           EMP_CODEMP=A.KON_CODEST              ';

  strSQL := strSQL + ' WHERE ' + FPeriodoFiltro;

  strSQL := strSQL + '   AND A.KON_STATUS <> "CANCELED"               ';
  strSQL := strSQL + '   AND A.KON_DTATRA IS NOT NULL                 ';

  If Not fEmptyStr(strIDConciliacao) Then
  Begin
    strSQL := strSQL + ' AND A.KON_CODCON LIKE "' + strIDConciliacao + '%"';

    FPeriodoFiltro := FPeriodoFiltro + ' AND A.KON_CODCON LIKE "' + strIDConciliacao + '%"';
  End;

  strSQL := strSQL + StringReplace(fRetPesqPonVen(0), objConcil.strCamCon,
                                   'A.' +  objConcil.strCamCon, [rfReplaceAll]);
  strSQL := strSQL + ' GROUP BY A.KON_MARKET, A.KON_DTAPAG, A.KON_TIPREG, A.KON_ID_PED, A.KON_NUMPAR ';
  strSQL := strSQL + ' ORDER BY A.KON_MARKET, A.KON_DTAPAG            ';

  //Verifica antes se a tabela de importação já foi criada
  qryConCar.Close;
  qryConCar.SQL.Text := 'SHOW TABLES LIKE "KON_KOPGTO"';
  qryConCar.Open;
  If qryConCar.IsEmpty Then
  Begin
    qryConCar.Close;
    fMensagem('ATENÇÃO','Não existem arquivos importados para a conciliação da KONCILIA!',['&OK']);
    Result := False;
    Exit;
  End;

  qryConCar.Close;
  qryConCar.SQL.Clear;
  qryConCar.SQL.Add(strSQL);

  qryConCar.ParamByName('DTAIN').AsString  := FormatDateTime('yyyy/MM/dd', StrToDate(strDtaIni));
  qryConCar.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy/MM/dd', StrToDate(strDtaFim));

  qryConCar.Open;

  If qryConCar.RecordCount = 0 Then
  Begin
    fMensagem('ATENÇÃO','Não existem arquivos importados nesse período de recebimento!',['&OK']);
    qryConCar.Close;
    Result := False;
    blnReabre := True;
    Exit;
  End;

  qryConCar.Filter   := 'TIPO_REGISTRO<>''SALE'' ';
  qryConCar.Filtered := True;
  cdsComissaoEFrete  := CriarClientDataSet(qryConCar);
  qryConCar.Filtered := False;

  cdsResolverAPI     := CriarClientDataSet(qryConCar);
  blnResolverAPI     := True;

  cdsConCar := CriarClientDataSet(qryConCar);
  cdsConCar.Open;
  cdsConCar.Filter   := 'TIPO_REGISTRO=''SALE'' ';
  cdsConCar.Filtered := True;

  pCalculaPeriodoFiltro('KON_DTATRA');

  //Filtrando Cartões na MOVCAR
  TfrmGravando.fExecutarModal(pFiltraCartoesKoncilia,'Aguarde... Filtrando registros.','');

  //Selecionando cartões já baixados/cadastrados no período
  pFiltraCartoesBaixadosKoncilia;

  //Corrigindo importação dos registros sem mca_numccd
  pCorrigeAutorizacaoMarketPlaceMovCar;

  //Corrigindo registros importados
  If FVincularAjustesNasVendas Then
   pCorrigeComissaoEFrete(cdsComissaoEFrete,pgbStatus);

  //Filtrando Cancelamentos/Ajustes
  strCondicao := strCondicao + StringReplace(fRetPesqPonVen(1), objConcil.strCamCon, 'A.' + objConcil.strCamCon, [rfReplaceAll]);

  If blnConciliarDataImportacao Then
    strCondicao := strCondicao +' A.KON_DTAFIN BETWEEN ' + FormatDateTime('yyyy-mm-dd', StrToDate(strDtaIni)).QuotedString + ' AND ' +
                                                           FormatDateTime('yyyy-mm-dd', StrToDate(strDtaFim)).QuotedString
  Else If Not fEmptyStr(strIDConciliacao) Then
  Begin
    strCondicao := strCondicao +
     '((A.KON_DTAPAG BETWEEN :DTAIN AND :DTAFIM) OR  '+
       'A.KON_DTAFIN BETWEEN (SELECT MIN(B.KON_DTAFIN) FROM KON_KOPGTO B WHERE B.KON_DTAPAG BETWEEN :DTAIN AND :DTAFIM) AND '+
                             '(SELECT MAX(B.KON_DTAFIN) FROM KON_KOPGTO B WHERE B.KON_DTAPAG BETWEEN :DTAIN AND :DTAFIM)) ';

     strCondicao := strCondicao.Replace(':DTAIN',FormatDateTime('yyyy-mm-dd', StrToDate(strDtaIni)).QuotedString).
                                Replace(':DTAFIM',FormatDateTime('yyyy-mm-dd', StrToDate(strDtaFim)).QuotedString);
  End
  Else
  Begin
    strCondicao := strCondicao +' A.KON_DTAPAG BETWEEN ' + FormatDateTime('yyyy-mm-dd', StrToDate(strDtaIni)).QuotedString + ' AND ' +
                                                           FormatDateTime('yyyy-mm-dd', StrToDate(strDtaFim)).QuotedString
  End;



  If Not strIDConciliacao.IsEmpty Then
    strCondicao := strCondicao + ' AND A.KON_CODCON LIKE "' + strIDConciliacao + '%" ';

  If FFiltrarTodosAjustes Then
    strCondicao := strCondicao +    'AND (                                '+
                                    '  (A.KON_TIPREG <> "SALE")           '+
                                    '  OR (                               '+
                                    '    A.KON_TIPREG = "SALE"            '+
                                    '    AND (                            '+
                                    '      A.KON_VALBRU < 0               '+
                                    '      OR A.KON_STATUS = "CANCELED"   '+
                                    '    )                                '+
                                    '  )                                  '+
                                    '  OR (                               '+
                                    '    A.KON_MARKET IN ("MERCADOLIVRE") '+
                                    '    AND A.KON_TIPREG = "SALE"        '+
                                    '    AND (A.KON_VALBRU < A.KON_VALPAR)'+
                                    '  )                                  '+
                                    ')                                    '+
                                    'AND A.KON_VALBRU <> 0                '+
                                    'AND IF(                              '+
                                    '  A.KON_MARKET = "MAGALU",           '+
                                    '  A.KON_TIPREG NOT IN ("TRANSFER"),  '+
                                    '  TRUE                               '+
                                    ')                                    '
  Else
    strCondicao := strCondicao + ' AND ((A.KON_TIPREG="SALE" AND A.KON_VALBRU < 0) OR ' +
                                 '      ((A.KON_TIPREG NOT IN ("SALE", "INITIAL_AVAILABLE_BALANCE", "WITHDRAWAL", "MONEY_TRANSFER",' +
                                 ' "UNKNOWN", "PREVIOUS_AMOUNT", "CURRENT_AMOUNT", "INITIAL_AVAILABLE_BALANCE", "SHIP", "COMISSION")) AND ' +
                                 ' ((A.KON_CODCON, A.KON_MARKET, A.KON_NUMPED) NOT IN ' +
                                 '      (SELECT R.KON_CODCON, R.KON_MARKET, R.KON_NUMPED FROM KON_KOPGTO R WHERE R.KON_TIPREG= "SALE")) )) ' +
                                 ' AND A.KON_VALBRU <> 0';

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := cdsConCar.RecordCount;
  intQtdReg   := 0;

  cdsConCar.First;
  While Not cdsConCar.EOF do
  Begin
    pStepStatusGravacao(pgbStatus);
    Application.ProcessMessages;
    strTmpLog := '';

    strTipo := 'CRÉDITO ROTATIVO';
    If (cdsConCar.FieldByName('KON_TOTPAR').Value > 1) Then
        strTipo := 'CRÉDITO PARCELADO';

    fltValor  := cdsConCar.FieldByName('KON_VALPAR').Value;
    fltValMar := cdsConCar.FieldByName('KON_VALPAR').Value +
                 cdsConCar.FieldByName('KON_VALCOM').Value +
                 cdsConCar.FieldByName('KON_VALFRE').Value;

    strID_Ped := IIF(cdsConCar.FieldByName('KON_MARKET').AsString <> 'B2W',
                     cdsConCar.FieldByName('KON_ID_PED').AsString,
                     Copy(cdsConCar.FieldByName('KON_ID_PED').AsString, 4, Length(cdsConCar.FieldByName('KON_ID_PED').AsString)));

    strParcela := fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('KON_NUMPAR').AsString = '00', '1', cdsConCar.FieldByName('KON_NUMPAR').AsString)));

    blnBusca := fBuscaCartaoKoncilia(strID_Ped,
                                     cdsConCar.FieldByName('KON_NUMPED').AsString,
                                     strParcela);


    If FFiltrarTodosAjustes Then
    Begin
      If VendaCancelada Then
      Begin
        pGravarCancelado;
        cdsConCar.Next;
        Continue;
      End;
    End;

    If blnBusca Then
    Begin
      fltValor := CorrigeValorBruto;
      fltDifere := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - fltValor;

      If (fBetween(fltDifere, -0.0299999, 0.029999)) Or
         (fBetween(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - fltValMar, -0.0299999, 0.029999)) Or
         (fBetween(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - (fltValor + cdsConCar.FieldByName('KON_VALFRE').Value), -0.0299999, 0.029999)) Or
         (fBetween(cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat - fltValMar, -0.0299999, 0.029999)) Or
         (ValorBrutoNaMovCarPossuiFrete(fltValor)) Then
      Begin

        If PedidoDevolvido(fltValMar) Then
        Begin
          cdsConCar.Next;
          Continue;
        End;

        dtaDtaPag := cdsConCar.FieldByName('KON_DTAPAG').Value;

        strBloqPV := cdsConCar.FieldByName('KON_CODEST').Value;
        strBloqPa := strParcela;
        strBloqCa := '0000000000000000';
        strBloqRV := RightStr(cdsConCar.FieldByName('KON_NUMPED').AsString, 12);
        strBloqEm := cdsConCar.FieldByName('CODEMP').AsString;

        LChaCon := 'KON_' +
                    cdsConCar.FieldByName('KON_ID_PED').Value +'_' +
                    strParcela +'_'+
                    cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                    cdsConCar.FieldByName('KON_ID_KON').Value + '_' +
                    FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('KON_DTATRA').Value);

        pMarcaCartao(fltValMar,
                     False,
                     LChaCon,
                     0,0,0,0,0,0,0,'',
                     cdsConCar.FieldByName('KON_CODCON').Value);

        If cdsBaiCar.FieldByName('MCA_MARDES').AsString = 'M' Then
        Begin
          pGravaTotal(strTipo, fltValMar, fltValor);
          Inc(intQtdReg);

          pMarcaResolverAPI(cdsConCar.FieldByName('KON_ID_PED').AsString,
                            cdsConCar.FieldByName('KON_NUMPED').AsString,
                            cdsConCar.FieldByName('KON_NUMPAR').AsString);
        End;

      End
      Else
      Begin
        //Verificando outras liberações com a mesma data
        intRecNo := cdsBaiCar.RecNo;
        cdsBaiCar.Next;

        While (cdsBaiCar.FieldByName('MCA_NUMCCD').AsString = strID_Ped) And
              (cdsBaiCar.FieldByName('PARDUP').AsString = strParcela) And
              (IIF(Not fEmptyStr(cdsConCar.FieldByName('CODEMP').AsString), cdsBaiCar.FieldByName('MCA_EMPRCX').AsString = cdsConCar.FieldByName('CODEMP').AsString, True)) And
              (cdsBaiCar.FieldByName('MCA_MARDES').AsString = 'D') Do
        Begin
          fltDifere := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - fltValor;
          If (fBetween(fltDifere, -0.0299999, 0.029999)) Or
             (fBetween(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - fltValMar, -0.0299999, 0.029999)) Or
             (fBetween(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - (fltValor + cdsConCar.FieldByName('KON_VALFRE').Value), -0.0299999, 0.029999)) Or
             (fBetween(cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat - fltValMar, -0.0299999, 0.029999)) Or
             (ValorBrutoNaMovCarPossuiFrete(fltValor)) Then
          Begin

            If PedidoDevolvido(fltValMar) Then
            Begin
              cdsConCar.Next;
              Continue;
            End;
            dtaDtaPag := cdsConCar.FieldByName('KON_DTAPAG').Value;

            strBloqPV := cdsConCar.FieldByName('KON_CODEST').Value;
            strBloqPa := strParcela;
            strBloqCa := '0000000000000000';
            strBloqEm := cdsConCar.FieldByName('CODEMP').AsString;
            strBloqRV := RightStr(cdsConCar.FieldByName('KON_ID_KON').AsString, 12);


            LChaCon := 'KON_' +
                        cdsConCar.FieldByName('KON_ID_PED').Value +'_' +
                        strParcela +'_'+
                        cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                        cdsConCar.FieldByName('KON_ID_KON').Value + '_' +
                        FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('KON_DTATRA').Value);

            pMarcaCartao(fltValMar,
                         False,
                         LChaCon,
                         0,0,0,0,0,0,0,'',
                         cdsConCar.FieldByName('KON_CODCON').Value);

            If cdsBaiCar.FieldByName('MCA_MARDES').AsString = 'M' Then
            Begin
              pGravaTotal(strTipo, fltValMar, fltValor);
              Inc(intQtdReg);

              pMarcaResolverAPI(cdsConCar.FieldByName('KON_ID_PED').AsString,
                                cdsConCar.FieldByName('KON_NUMPED').AsString,
                                cdsConCar.FieldByName('KON_NUMPAR').AsString);
            End;

             Break;
          End;

          cdsBaiCar.Next;

          If cdsBaiCar.Eof Then
            Break;
        End;

        If (Not fBetween(fltDifere, -0.0299999, 0.029999)) And
           (Not fBetween(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - fltValMar, -0.0299999, 0.029999)) And
           (Not fBetween(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - (fltValor + cdsConCar.FieldByName('KON_VALFRE').Value), -0.0299999, 0.029999)) And
           (Not fBetween(cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat - fltValMar, -0.0299999, 0.029999)) Or
           (ValorBrutoNaMovCarPossuiFrete(fltValor)) Then
        Begin
          cdsBaiCar.RecNo := intRecNo;
          strTmpLog := 'Valor do cartão diferente do registrado no sistema ou Autorização duplicada';

        End;
      End;
    End
    Else
    Begin
      //verifica se está cadastrado ou já foi baixado no período
      blnAutomatica := cdsConCar.FieldByName('KON_CONCIL').Value = 1;

      cdsBaixad.First;
      blnBusca := fBuscaCartaoBaixadoKoncilia(strID_Ped,
                                              cdsConCar.FieldByName('KON_NUMPED').AsString,
                                              strParcela);

      If Not blnBusca Then
      Begin
        if (Not FFiltrarTodosAjustes) And (cdsConCar.FieldByName('CANCELADO').AsInteger > 0) Then
          pGravarCancelado
        Else
        Begin
          If (cdsConCar.FieldByName('DEVOLVIDO').AsFloat <> 0) Then
          Begin
            strTmpLog := 'Pedidos devolvidos não encontrado nos lançamentos do sistema' ;
            FPedidosDevolvidos := FPedidosDevolvidos + '"' + cdsConCar.FieldByName('KON_ID_PED').AsString + '",';
          End
          Else
            strTmpLog := 'Registro do arquivo não encontrado nos lançamentos do sistema';
        End;
      End
      Else
      Begin
        strTmpLog := 'Cartão já foi baixado';

        pMarcaResolverAPI(cdsConCar.FieldByName('KON_ID_PED').AsString,
                          cdsConCar.FieldByName('KON_NUMPED').AsString,
                          cdsConCar.FieldByName('KON_NUMPAR').AsString);
      End;

    End;

    //Grava inconsistência se houver
    If Not fEmptyStr(strTmpLog) Then
    Begin
      objIncons := TInconsist.Create;

      objIncons.strDescri := strTmpLog;
      objIncons.strValori := FormatFloat('#,##0.00', fltValor);
      objIncons.strAutori := 'VENDA';
      objIncons.strNum_PV := cdsConCar.FieldByName('KON_CODEST').Value;
      objIncons.strNum_RV := cdsConCar.FieldByName('KON_NUMPED').AsString;
      objIncons.strNumCar := cdsConCar.FieldByName('KON_MARKET').AsString;
      objIncons.strTipCar := strTipo;
      objIncons.strDta_CV := FormatDateTime('dd/mm/yyyy', cdsConCar.FieldByName('KON_DTATRA').Value);
      objIncons.strDtaVen := FormatDateTime('dd/mm/yyyy', cdsConCar.FieldByName('KON_DTAPAG').Value);
      objIncons.strParcel := strParcela;
      objIncons.strNumCCD := strID_Ped;
      objIncons.strValLiq := FormatFloat('#,##0.00', fltValMar);
      If (Not fEmptyStr(cdsConCar.FieldByName('CODEMP').AsString)) Then
        objIncons.strDesEmp := cdsConCar.FieldByName('CODEMP').AsString + ' - ' + cdsConCar.FieldByName('EMP_NOMEMP').AsString;
      objIncons.strBandei := fRetNomBandeira(objIncons.strNumCar);

      pGravaInconsistencia(objIncons);
      FreeAndNil(objIncons);
    End;

    cdsConCar.Next;
  End;

  FiltraCancelamentosKoncilia(strCondicao,
                              fRetornaDescricaoCancelamento,
                              ' IF(KON_VALBRU > 0, KON_VALBRU, 0) ',
                              cdsComissaoEFrete,
                              pgbStatus);

  If Assigned(cdsComissaoEFrete) Then
    FreeAndNil(cdsComissaoEFrete);

  cdsInconsistencia.IndexFieldNames := 'NUMCAR;DESCRI;DTAVEN';

  FreeAndNil(cdsBaixad);
  cdsBaiCar.IndexFieldNames := strIndAnt;
  Result := True;
end;

function TConcilKoncilia.fRetornaNumeroPedidoMarketPlace(
  strNumPOK: String): String;
begin
  Result := strNumPOK;
  Result := Result.Replace('BWW-Lojas_Americanas-', EmptyStr);
  Result := Result.Replace('BWW-Submarino-', EmptyStr);
  Result := Result.Replace('BWW-Shoptime-', EmptyStr);
  Result := Result.Replace('MLB-', EmptyStr);
  Result := Result.Replace('MLZ-', EmptyStr);
  Result := Result.Replace('MZN-', EmptyStr);
  Result := Result.Replace('shp-', EmptyStr);
end;

function TConcilKoncilia.fRetornaMarketPlaceMovCar(strNumPOK: String): String;
Begin
  Result := 'OUTROS';
  If (strNumpOK.Contains('MLB-')) Or (strNumpOK.Contains('MERCADO_LIVRE')) Then
    Result := 'MERCADOLIVRE'
  Else If (strNumpOK.Contains('BWW-')) Or (strNumpOK.Contains('shp-')) Then
    Result := 'B2W'
  Else If (strNumpOK.Contains('MLZ-')) Or (strNumpOK.Contains('MZN-')) Then
    Result := 'MAGAZINELUIZA';
End;

procedure TConcilKoncilia.pCorrigeAutorizacaoMarketPlaceMovCar;
begin
  cdsBaiCar.Filter   := '(MCA_NUMCCD IS NULL OR MCA_NUMCCD='''') AND  ' +
                        '(MCA_NUMPOK IS NOT NULL AND MCA_NUMPOK<>'''')';
  cdsBaiCar.Filtered := True;
  While Not cdsBaiCar.Eof Do
  Begin
    cdsBaiCar.Edit;
    cdsBaiCar.FieldByName('MCA_NUMCCD').AsString  := fRetornaNumeroPedidoMarketPlace(cdsBaiCar.FieldByName('MCA_NUMPOK').AsString);
    cdsBaiCar.FieldByName('MARKETPLACE').AsString := fRetornaMarketPlaceMovCar(cdsBaiCar.FieldByName('MCA_NUMPOK').AsString);
    cdsBaiCar.Post;
  End;

  cdsBaiCar.Filter   := '';
  cdsBaiCar.Filtered := False;

  //Baixados
  cdsBaixad.Filter   := '(MCA_NUMCCD IS NULL OR MCA_NUMCCD='''') AND  ' +
                        '(MCA_NUMPOK IS NOT NULL AND MCA_NUMPOK<>'''')';
  cdsBaixad.Filtered := True;
  While Not cdsBaixad.Eof Do
  Begin
    cdsBaixad.Edit;
    cdsBaixad.FieldByName('MCA_NUMCCD').AsString := fRetornaNumeroPedidoMarketPlace(cdsBaixad.FieldByName('MCA_NUMPOK').AsString);
    cdsBaixad.FieldByName('MARKETPLACE').AsString  := fRetornaMarketPlaceMovCar(cdsBaixad.FieldByName('MCA_NUMPOK').AsString);
    cdsBaixad.Post;
  End;

  cdsBaixad.Filter   := '';
  cdsBaixad.Filtered := False;
end;

procedure TConcilKoncilia.pCorrigeComissaoEFrete(cdsComissaoEFrete: TUniClientDataSet; Var pgbStatus: TcxProgressBar);
begin
  cdsConcar.First;
  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := cdsConCar.RecordCount;
  While Not cdsConCar.Eof Do
  Begin
    pStepStatusGravacao(pgbStatus);
    FilterDataSetComissaoFrete(cdsComissaoEFrete);

    cdsComissaoEFrete.Filtered := True;

    If Not cdsComissaoEFrete.IsEmpty Then
    Begin
      cdsConCar.Edit;
      While Not cdsComissaoEFrete.Eof Do
      Begin
        If (cdsComissaoEFrete.FieldByName('KON_TIPREG').AsString = 'ADDITIONAL_FEE') Then
        Begin
          cdsComissaoEFrete.Next;
          Continue;
        End;

        If (cdsComissaoEFrete.FieldByName('KON_TIPREG').AsString = 'CAMPAIGN_REFUND') Then
        Begin
          cdsConCar.FieldByName('KON_VALBRU').AsFloat := cdsConCar.FieldByName('KON_VALBRU').AsFloat +
                                                         cdsComissaoEFrete.FieldByName('KON_VALBRU').AsFloat;

          cdsConCar.FieldByName('KON_VALPAR').AsFloat := cdsConCar.FieldByName('KON_VALPAR').AsFloat +
                                                         cdsComissaoEFrete.FieldByName('KON_VALPAR').AsFloat;
        End
        Else If cdsComissaoEFrete.FieldByName('KON_VALCOM').AsFloat <> 0 Then
          cdsConCar.FieldByName('KON_VALCOM').AsFloat := cdsConCar.FieldByName('KON_VALCOM').AsFloat +
                                                         cdsComissaoEFrete.FieldByName('KON_VALCOM').AsFloat
        Else If cdsComissaoEFrete.FieldByName('KON_VALFRE').AsFloat <> 0 Then
          cdsConCar.FieldByName('KON_VALFRE').AsFloat := cdsConCar.FieldByName('KON_VALFRE').AsFloat +
                                                         cdsComissaoEFrete.FieldByName('KON_VALFRE').AsFloat
        Else
          cdsConCar.FieldByName('KON_VALCOM').AsFloat := cdsConCar.FieldByName('KON_VALCOM').AsFloat +
                                                         cdsComissaoEFrete.FieldByName('KON_VALBRU').AsFloat;

        cdsComissaoEFrete.Edit;
        cdsComissaoEFrete.FieldByName('RETIRAR_AJUSTES').AsString := 'S';
        cdsComissaoEFrete.Post;

        cdsComissaoEFrete.Next;
      End;
      cdsConCar.Post;
    End;

    cdsConCar.Next;
  End;
end;

function TConcilKoncilia.PedidoDevolvido(AValorLiquido:Double): Boolean;
  Var
    objIncons  : TInconsist;
begin
  Result := False;

  If Not (cdsConCar.FieldByName('DEVOLVIDO').AsFloat <> 0) Then
    Exit;

  Try
    objIncons := TInconsist.Create;
    objIncons.strDescri := 'Pedidos devolvidos';

    If (fFormataFloat(AValorLiquido + cdsConCar.FieldByName('DEVOLVIDO').AsFloat,2) <> 0) Then
     objIncons.strDescri := 'Pedidos devolvidos parcialmente';

    objIncons.strValori := FormatFloat('#,##0.00', CorrigeValorBruto);
    objIncons.strAutori := 'VENDA';
    objIncons.strNum_PV := cdsConCar.FieldByName('KON_CODEST').Value;
    objIncons.strNum_RV := cdsConCar.FieldByName('KON_NUMPED').AsString;
    objIncons.strNumCar := cdsConCar.FieldByName('KON_MARKET').AsString;
    objIncons.strTipCar := RetornaTipoCartao;
    objIncons.strDta_CV := FormatDateTime('dd/mm/yyyy', cdsConCar.FieldByName('KON_DTATRA').Value);
    objIncons.strDtaVen := FormatDateTime('dd/mm/yyyy', cdsConCar.FieldByName('KON_DTAPAG').Value);
    objIncons.strParcel := fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('KON_NUMPAR').AsString = '00', '1', cdsConCar.FieldByName('KON_NUMPAR').AsString)));
    objIncons.strNumCCD := cdsConCar.FieldByName('KON_ID_PED').AsString;
    objIncons.strValLiq := FormatFloat('#,##0.00', AValorLiquido);
    If (Not fEmptyStr(cdsConCar.FieldByName('CODEMP').AsString)) Then
      objIncons.strDesEmp := cdsConCar.FieldByName('CODEMP').AsString + ' - ' + cdsConCar.FieldByName('EMP_NOMEMP').AsString;
    objIncons.strBandei := fRetNomBandeira(objIncons.strNumCar);

    Result := True;
    FPedidosDevolvidos := FPedidosDevolvidos + '"' + cdsConCar.FieldByName('KON_ID_PED').AsString + '",';

    pGravaInconsistencia(objIncons);
  Finally
    FreeAndNil(objIncons);
  End;
end;

procedure TConcilKoncilia.pFiltraCartoesBaixadosKoncilia;
  Var
    strSQL   : String;
    qryBaixad: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT MCA_NUMCCD, MCA_PARCEL, MCA_DTAREC, MCA_NUMNSU, ';
  strSQL := strSQL + ' MCA_NUMDUP, MCA_DTACUP, MCA_NUMPOK,                    ';
  strSQL := strSQL + ' MCA_CODEMP, MCA_DTAVEN, MCA_EMPRCX, MCA_CHACON,        ';
  strSQL := strSQL+ '  CAST(" " AS CHAR(50)) AS MARKETPLACE                   ';
  strSQL := strSQL + ' FROM MOVCAR                                            ';

  If FCartoesKoncili.IsEmpty Then
  Begin
    strSQL := strSQL + ' WHERE MCA_DTACUP BETWEEN "' + FormatDateTime('yyyy-mm-dd',dtaDtaIni);
    strSQL := strSQL + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '" ';
  End
  Else
  Begin
    strSQL := strSQL + ' WHERE MCA_CODCAR IN (' + fRetStrToSQLIn(FCartoesKoncili) + ') ';
    strSQL := strSQL + ' AND (MCA_NUMNSU IN (' + FListaDePedidos + ') OR MCA_NUMCCD IN (' + FListaDePedidos + ')) ';
  End;

  strSQL := strSQL + ' AND MCA_DTAREC IS NOT NULL ';
  strSQL := strSQL + ' ORDER BY MCA_NUMCCD, MCA_PARCEL,MCA_CODEMP ';

  qryBaixad := fCriaQuery(Application);
  qryBaixad.SQL.Add(strSQL);
  qryBaixad.Open;
  cdsBaixad := CriarClientDataSet(qryBaixad);
  
  cdsBaixad.IndexFieldNames := 'MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_CODEMP';
  cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;EMPLOC;MCA_DTACUP;PARDUP';
end;

procedure TConcilKoncilia.pFiltraCartoesKoncilia;
  Var
    strSQL : String;
begin
  FCartoesKoncili := fCfgSis('KONCAR');

  FListaDePedidos := RetornaListaDePedidos;

  strSQL := fGetSQLCartoes(objConcil);

  If FCartoesKoncili.IsEmpty Then
  Begin
    strSQL := strSQL + ' AND MCA_DTACUP BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    strSQL := strSQL + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '" '
  End
  Else
  Begin
    strSQL := strSQL + ' AND MCA_CODCAR IN (' + fRetStrToSQLIn(FCartoesKoncili) + ') ';
    strSQL := strSQL + ' AND (MCA_NUMNSU IN (' + FListaDePedidos + ') OR MCA_NUMCCD IN (' + FListaDePedidos + ')) ';
  End;

  strSQL := strSQL + ' ORDER BY MCA_DTAVEN, MCA_NUMDUP, MCA_CODEMP, MCA_NUMCCD, MCA_NUMNSU, MCA_PARCEL) AS TMP ';

  qryBaiCar := fCriaQuery(Nil);

  qryBaiCar.SQL.Text := strSQL;

  qryBaiCar.Options.SetFieldsReadOnly := False;

  qryBaiCar.Open;

  cdsBaiCar := TUniClientDataSet.Create(Application);
  pSetaClientDataSet(qryBaiCar, cdsBaiCar);
  cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;MCA_CODEMP;PARDUP;MCA_DTACUP;MCA_NUMDUP';
end;

procedure TConcilKoncilia.pGravarCancelado;
begin
  SetLength(arrSemReg, Length(arrSemReg) + 1);
  arrSemReg[Length(arrSemReg) - 1].strNum_Pv := cdsConCar.FieldByName('KON_NUMPED').AsString;
  arrSemReg[Length(arrSemReg) - 1].strNum_Rv := cdsConCar.FieldByName('KON_MARKET').AsString;
  arrSemReg[Length(arrSemReg) - 1].dtaDta_Cv := cdsConCar.FieldByName('KON_DTATRA').Value;
  arrSemReg[Length(arrSemReg) - 1].fltValSta := cdsConCar.FieldByName('KON_VALBRU').Value;
  arrSemReg[Length(arrSemReg) - 1].strParcel := cdsConCar.FieldByName('KON_NUMPAR').AsString + '/' +
                                                cdsConCar.FieldByName('KON_TOTPAR').AsString;

  Inc(intQtdSem);
  fltValSem := fltValSem + cdsConCar.FieldByName('KON_VALBRU').Value;
end;

procedure TConcilKoncilia.pMarcaResolverAPI(strID_Ped, strNumPed,
  strParcel: String);
begin
  cdsResolverAPI.Filter   := ' KON_ID_PED = ' + strID_Ped.QuotedString + ' AND ' +
                             ' KON_NUMPED = ' + strNumPed.QuotedString + ' AND ' +
                             ' KON_NUMPAR = ' + strParcel.QuotedString;
  cdsResolverAPI.Filtered := True;

  cdsResolverAPI.First;
  While Not cdsResolverAPI.Eof Do
  Begin
    cdsResolverAPI.Edit;
    cdsResolverAPI.FieldByName('MARCADO').AsString := 'S';
    cdsResolverAPI.Post;

    cdsResolverAPI.Next;
  End;

  cdsResolverAPI.Filter   := '';
  cdsResolverAPI.Filtered := False;
end;

procedure TConcilKoncilia.pSetaLabelsRelatorio;
begin
  TfrxMemoView(frxPagina.FindObject('Memo59')).Text     := 'Tipo';
  TfrxMemoView(frxPagina.FindObject('Memo59')).HAlign   := TfrxHAlign.haLeft;
  TfrxMemoView(frxPagina.FindObject('Memo15')).HAlign   := TfrxHAlign.haLeft;
  TfrxMemoView(frxPagina.FindObject('Memo15')).Width    := TfrxMemoView(frxPagina.FindObject('Memo15')).Width - 50;
  TfrxMemoView(frxPagina.FindObject('Memo59')).Width    := TfrxMemoView(frxPagina.FindObject('Memo59')).Width - 50;

  TfrxMemoView(frxPagina.FindObject('Memo104')).Text    := 'ID Pedido';
  TfrxMemoView(frxPagina.FindObject('Memo97')).Text     := 'Market Place';

  TfrxMemoView(frxPagina.FindObject('Memo104')).Left    := TfrxMemoView(frxPagina.FindObject('Memo104')).Left - 50;
  TfrxMemoView(frxPagina.FindObject('Memo60')).Left     := TfrxMemoView(frxPagina.FindObject('Memo60')).Left - 50;
  TfrxMemoView(frxPagina.FindObject('Memo104')).Width   := TfrxMemoView(frxPagina.FindObject('Memo104')).Width + 40;
  TfrxMemoView(frxPagina.FindObject('Memo60')).Width    := TfrxMemoView(frxPagina.FindObject('Memo60')).Width + 40;

  TfrxMemoView(frxPagina.FindObject('Memo103')).Left    := TfrxMemoView(frxPagina.FindObject('Memo103')).Left - 20;
  TfrxMemoView(frxPagina.FindObject('Memo16')).Left     := TfrxMemoView(frxPagina.FindObject('Memo16')).Left - 20;
  TfrxMemoView(frxPagina.FindObject('Memo16')).HAlign   := TfrxHAlign.haCenter;

  TfrxMemoView(frxPagina.FindObject('Memo96')).Left     := TfrxMemoView(frxPagina.FindObject('Memo96')).Left - 15;
  TfrxMemoView(frxPagina.FindObject('Memo30')).Left     := TfrxMemoView(frxPagina.FindObject('Memo30')).Left - 15;
  TfrxMemoView(frxPagina.FindObject('Memo96')).Width    := TfrxMemoView(frxPagina.FindObject('Memo96')).Width + 30;
  TfrxMemoView(frxPagina.FindObject('Memo30')).Width    := TfrxMemoView(frxPagina.FindObject('Memo30')).Width + 30;

  TfrxMemoView(frxPagina.FindObject('Memo143')).Visible := False;
  TfrxMemoView(frxPagina.FindObject('Memo149')).Visible := False;
  TfrxMemoView(frxPagina.FindObject('Memo151')).Text    := 'ID Pedido';
  TfrxMemoView(frxPagina.FindObject('Memo146')).Text    := 'Market Place';
  TfrxMemoView(frxPagina.FindObject('rllQtdSem')).Text  := intQtdSem.ToString;
  TfrxMemoView(frxPagina.FindObject('rllTotSem')).Text  := FormatFloat('#,##0.00;-#,##0.00', fltValSem);

  TfrxMemoView(frxPagina.FindObject('Memo120')).Text    := 'Núm. Pedido';
  TfrxMemoView(frxPagina.FindObject('Memo123')).Text    := 'Market';
  TfrxMemoView(frxPagina.FindObject('Memo112')).Text    := 'Pedidos já cancelados';
  TfrxMemoView(frxPagina.FindObject('Memo145')).Text    := 'Motivo';

  TfrxMemoView(frxPagina.FindObject('Memo158')).Left := 302.181082830000000000;
  TfrxMemoView(frxPagina.FindObject('Memo158')).Width := 100.267682360000000000;


  If Not strIDConciliacao.Trim.IsEmpty Then
  Begin
    TfrxMemoView(frxPagina.FindObject('rllCodigoConciliacao')).Visible := True;
    TfrxMemoView(frxPagina.FindObject('rllCodigoConciliacao')).Text    := 'Cód. Conciliação: ' + strIDConciliacao;

    TfrxPageHeader(frxPagina.FindObject('PageHeader1')).Height := TfrxPageHeader(frxPagina.FindObject('PageHeader1')).Height +
                                                                  TfrxMemoView(frxPagina.FindObject('rllCodigoConciliacao')).Height;
  End;
end;

function TConcilKoncilia.RetornaListaDePedidos: String;
  Var
    LSQL: String;

    LConsulta: TUniQuery;
begin
  Try
    FPeriodoFiltro := FPeriodoFiltro.Replace('A.KON_', 'KON_')
                                    .Replace(':DTAIN', '"' + FormatDateTime('yyyy/MM/dd', StrToDate(strDtaIni)) + '"')
                                    .Replace(':DTAFIM', '"' + FormatDateTime('yyyy/MM/dd', StrToDate(strDtaFim)) + '"');

    LSQL := 'SELECT DISTINCT KON_ID_PED FROM KON_KOPGTO WHERE ' + FPeriodoFiltro +
            ' UNION ' +
            'SELECT DISTINCT KON_NUMPED AS KON_ID_PED FROM KON_KOPGTO WHERE ' + FPeriodoFiltro;

    LConsulta := fCriarQuery(LSQL);
    LConsulta.Open;

    Result := '';

    While Not LConsulta.Eof Do
    Begin
      Result := Result + '"' + LConsulta.FieldByName('KON_ID_PED').AsString + '",';

      LConsulta.Next;
    End;

    If Not Result.IsEmpty Then
      Result := LeftStr(Result, Result.Length - 1)
    Else
      Result := '" "';
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TConcilKoncilia.RetornaTipoCartao: String;
begin
  Result := 'CRÉDITO ROTATIVO';
  If (cdsConCar.FieldByName('KON_TOTPAR').Value > 1) Then
      Result := 'CRÉDITO PARCELADO';
end;

function TConcilKoncilia.ValorBrutoNaMovCarPossuiFrete(
  var AValorBrutoAtual: Double): Boolean;
begin
  Result := fBetween(AValorBrutoAtual - cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat, -0.0299999, 0.0299999);
  If Result Then
    Exit;

  Result := fBetween((AValorBrutoAtual + cdsBaiCar.FieldByName('MCA_FREPED').AsFloat) - cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat, -0.0299999, 0.0299999);
  If Result Then
  Begin
    AValorBrutoAtual := fFormataFloat(AValorBrutoAtual + cdsBaiCar.FieldByName('MCA_FREPED').AsFloat, 2);

    cdsConCar.Edit;
    cdsConCar.FieldByName('KON_VALPAR').AsFloat := fFormataFloat(cdsConCar.FieldByName('KON_VALPAR').AsFloat + cdsBaiCar.FieldByName('MCA_FREPED').AsFloat, 2);
    cdsConCar.Post;
  End;
end;

function TConcilKoncilia.VendaCancelada: Boolean;
begin
  Result := False;

  If cdsConCar.FieldByName('CANCELADO').AsInteger = 0 Then
    Exit;

  If cdsConCar.FieldByName('KON_MARKET').AsString <> 'MERCADOLIVRE' Then
    Exit;

  If cdsConCar.FieldByName('KON_STATUS').AsString <> 'CONCLUDED' Then
    Exit;

  Result := True;
end;

function TConcilKoncilia.fRetornaDescricaoCancelamento: String;
begin
  Result := '';
  Result := Result + ' CASE A.KON_TIPREG ';
  Result := Result + ' WHEN "ADJUSTMENT" THEN "Ajuste"';
  Result := Result + ' WHEN "NON_SUBSCRIPTION_FEE_ADJUST" THEN "Ajuste - Sem assinatura"';
  Result := Result + ' WHEN "CREDIT_OR_DEBIT_ADJUST" THEN "Ajuste Manual de Crédito ou Débito"';
  Result := Result + ' WHEN "SHOPKEEPER_CANCELLATION_ADJUSTMENT" THEN "Ajuste do cancelamento do lojista"';
  Result := Result + ' WHEN "MISC_ADJUSTMENT" THEN "Ajustes Diversos"';
  Result := Result + ' WHEN "AMAZON_CAPITAL_SERVICES" THEN "Amazon Capital Services"';
  Result := Result + ' WHEN "ADVANCE_COST" THEN "Antecipação de Custo"';
  Result := Result + ' WHEN "INSURANCE_ANTICIPATION" THEN "Antecipação de Seguro"';
  Result := Result + ' WHEN "BLOCK_DEBT_RESERVE" THEN "Bloqueio Reserva de crédito"';
  Result := Result + ' WHEN "BLOCK_CHARGE_BACK_RESERVE" THEN "Bloqueio de Valor Reservado por chargeback"';
  Result := Result + ' WHEN "BLOCK_RESERVE_BPP_SHIP_RET" THEN "Bloqueio de reserva de devolução de frete"';
  Result := Result + ' WHEN "BLOCK_RESERVE_FOR_DISPUTE" THEN "Bloqueio de reserva de valor disputado"';
  Result := Result + ' WHEN "BLOCK_CHECK_DEBT_RESERVE" THEN "Bloqueio de reserva de valor para pagamento"';
  Result := Result + ' WHEN "BLOCK_RESERVE_FOR_PAYOUT" THEN "Bloqueio de reserva para saque em dinheiro no MP"';
  Result := Result + ' WHEN "BLOCK_BY_RESTRICTION" THEN "Bloqueio por restrição"';
  Result := Result + ' WHEN "BONUS" THEN "Bônus"';
  Result := Result + ' WHEN "LEGAL_BONUS" THEN "Bônus Jurídico"';
  Result := Result + ' WHEN "CHARGE_BACK_CANCEL_COMISSION" THEN "Cancelamento de Reembolso de Comissão"';
  Result := Result + ' WHEN "CHARGE_BACK_CANCEL_SHIP" THEN "Cancelamento de Reembolso de Frete"';
  Result := Result + ' WHEN "CHARGE_BACK_CANCEL_SALE" THEN "Cancelamento de Reembolso de Venda"';
  Result := Result + ' WHEN "CANCELED_WITHOUT_TAX" THEN "Cancelamento de venda conciliada"';
  Result := Result + ' WHEN "SHOPKEEPER_CANCELLATION" THEN "Cancelamento do lojista"';
  Result := Result + ' WHEN "CANCELED_WITH_TAX" THEN "Cancelamento sem Repasse"';
  Result := Result + ' WHEN "RELEASE_RECEIVABLE_LOCK_CANCELLATION" THEN "Cancelamento trava de recebível"';
  Result := Result + ' WHEN "CASHBACK" THEN "Cashback"';
  Result := Result + ' WHEN "SHOPEE_CASHBACK" THEN "Cashback Shopee"';
  Result := Result + ' WHEN "CHARGEBACK" THEN "Chargeback"';
  Result := Result + ' WHEN "ORDER_GIFT_WRAP_CHARGEBACK" THEN "Cobrança Embalagem para Presente"';
  Result := Result + ' WHEN "CHARGE_SHIP_COMMERCIAL_DEAL" THEN "Cobrança de Frete - Acordo Comercial"';
  Result := Result + ' WHEN "BIT_SUBSIDIARY" THEN "Cobrança subsidiaria BIT"';
  Result := Result + ' WHEN "COMISSION" THEN "Comissão"';
  Result := Result + ' WHEN "WITHDRAWAL_COMISSION" THEN "Comissão Retirada"';
  Result := Result + ' WHEN "WITHDRAWAL_COMMISSION_PAGARME" THEN "Comissão de Retirada Pagar.me"';
  Result := Result + ' WHEN "MAX_COMMISSION" THEN "Comissão máxima"';
  Result := Result + ' WHEN "COMISSION_SALE_CANCELED" THEN "Comissão por Cancelamento"';
  Result := Result + ' WHEN "FREIGHT_DIFFERENCE_COMMISSION" THEN "Comissão sobre Diferença de Frete"';
  Result := Result + ' WHEN "PROMOTION_REFUND_COMISSION" THEN "Comissão sobre ressarcimento de promoção"';
  Result := Result + ' WHEN "PURCHASE" THEN "Compra"';
  Result := Result + ' WHEN "RETURN_SHIPPING" THEN "Concessão de envio de devolução"';
  Result := Result + ' WHEN "CONSTITUTION_RESERVE_BALANCE" THEN "Constituição de Reserva de Saldo"';
  Result := Result + ' WHEN "FREIGHT_COPAYMENT" THEN "Coparticipação de frete"';
  Result := Result + ' WHEN "ASSET_MANAGEMENT_RETENTION" THEN "Correção Imposto de Renda Mercado Pago"';
  Result := Result + ' WHEN "COMMISSION_CORRECTION" THEN "Correção de Comissão"';
  Result := Result + ' WHEN "DISBURSEMENT_CORRECTION" THEN "Correção de Desembolso"';
  Result := Result + ' WHEN "CAMPAIGN_CREDIT" THEN "Crédito de Campanha"';
  Result := Result + ' WHEN "COMMISSION_CREDIT" THEN "Crédito de Comissão"';
  Result := Result + ' WHEN "BLOCK_CREDIT_PAYMENT" THEN "Crédito de Pagamento Bloqueado"';
  Result := Result + ' WHEN "UNBLOCK_CREDIT_PAYMENT" THEN "Crédito de Pagamento Desbloqueado"';
  Result := Result + ' WHEN "SHIPPING_COST" THEN "Custo de envio pago pelo seller"';
  Result := Result + ' WHEN "SHIPPING_CHARGEBACK" THEN "Dedução de frete"';
  Result := Result + ' WHEN "UNBLOCK_CHARGE_BACK_RESERVE" THEN "Desbloqueio Reserva de Chargeback"';
  Result := Result + ' WHEN "UNBLOCK_DEBT_RESERVE" THEN "Desbloqueio Reserva de crédito"';
  Result := Result + ' WHEN "UNBLOCK_RESERVE_BPP_SHIP_RET" THEN "Desbloqueio de reserva de devolução de frete"';
  Result := Result + ' WHEN "UNBLOCK_RESERVE_FOR_DISPUTE" THEN "Desbloqueio de reserva de valor disputado"';
  Result := Result + ' WHEN "UNBLOCK_RESERVE_FOR_PAYOUT" THEN "Desbloqueio de reserva para saque em dinheiro no MP"';
  Result := Result + ' WHEN "UNBLOCK_BY_RESTRICTION" THEN "Desbloqueio por restrição solucionada"';
  Result := Result + ' WHEN "UNKNOWN" THEN "Desconhecido"';
  Result := Result + ' WHEN "DISCOUNT_BIWEEKLY_ANTICIPATION_PAYMENT" THEN "Desconto Antecipação Pagamento Quinzenal"';
  Result := Result + ' WHEN "DISCOUNT_COMISSION" THEN "Desconto da Comissão"';
  Result := Result + ' WHEN "VOUCHER" THEN "Desconto de cupom"';
  Result := Result + ' WHEN "PROMOTIONAL_DISCOUNT" THEN "Desconto de promoção"';
  Result := Result + ' WHEN "PROMOTIONAL_DISCOUNT_CONC" THEN "Desconto total"';
  Result := Result + ' WHEN "UNBLOCK_CHECK_DEBT_RESERVE" THEN "Desloqueio de reserva de valor para pagamento"';
  Result := Result + ' WHEN "INITIAL_EXPENSE" THEN "Despesa Judicial Inicial"';
  Result := Result + ' WHEN "LEGAL_EXPENDITURE" THEN "Despesa Jurídica"';
  Result := Result + ' WHEN "FEE_RELEASE_ADVANCE" THEN "Despesa de Antecipação"';
  Result := Result + ' WHEN "SERVICE_EXPENSE" THEN "Despesas de Serviços"';
  Result := Result + ' WHEN "DEVOLUTION" THEN "Devolução"';
  Result := Result + ' WHEN "COMMISSION_RETURN" THEN "Devolução da Comissão"';
  Result := Result + ' WHEN "MAGALU_DEVOLUTION_REFUND_DUP" THEN "Devolução do estorno feito em duplicidade"';
  Result := Result + ' WHEN "DIFFERENCE_CREDIT_DISCOUNT" THEN "Diferença de Crédito"';
  Result := Result + ' WHEN "DIFFERENCE_DEBIT_DISCOUNT" THEN "Diferença de Débito"';
  Result := Result + ' WHEN "DIFFERENCE_FREIGHT" THEN "Diferença de Frete"';
  Result := Result + ' WHEN "DISPUTE" THEN "Disputa"';
  Result := Result + ' WHEN "ACCOUNT_MATCH" THEN "Encontro de contas"';
  Result := Result + ' WHEN "LATE_DELIVERY" THEN "Entrega atrasada"';
  Result := Result + ' WHEN "REFUND_GIFT_WRAP_CHARGEBACK" THEN "Estorno Cobrança Embalagem para Presente"';
  Result := Result + ' WHEN "ICMS_CHARGEBACK" THEN "Estorno ICMS"';
  Result := Result + ' WHEN "PARTIAL_REVERSAL" THEN "Estorno Parcial"';
  Result := Result + ' WHEN "REFUND_GIFT_WRAP" THEN "Estorno Receita Embalagem para Presente"';
  Result := Result + ' WHEN "CHARGEBACK_TAX_SIRTAC" THEN "Estorno Retenção de imposto retido na fonte - SIRTAC"';
  Result := Result + ' WHEN "CHARGEBACK_TAX_OTHER_CITIES" THEN "Estorno Retenção de imposto sobre o IIBB de outras cidades"';
  Result := Result + ' WHEN "CHARGEBACK_TAX_ADDED_VALUE" THEN "Estorno Retenção de imposto sobre valor agregado"';
  Result := Result + ' WHEN "CHARGEBACK_TAX_INCOME_TAX" THEN "Estorno Retenção do Imposto de Renda"';
  Result := Result + ' WHEN "CHARGEBACK_TAX_BUENOS_AIRES" THEN "Estorno Retenção do Imposto sobre o IIBB de Buenos Aires"';
  Result := Result + ' WHEN "CHARGEBACK_TAX_ENTRE_RIOS" THEN "Estorno Retenção do Imposto sobre o IIBB de Entre Rios"';
  Result := Result + ' WHEN "CHARGEBACK_TAX_SANTA_FE" THEN "Estorno Retenção do Imposto sobre o IIBB de Santa Fé"';
  Result := Result + ' WHEN "RETURN_INSTALLMENT_FEE" THEN "Estorno da Taxa de Parcelamento"';
  Result := Result + ' WHEN "RETURN_PENALTY" THEN "Estorno da penalidade/multa"';
  Result := Result + ' WHEN "RETURN_ANTICIPATION" THEN "Estorno de Antecipação de Seguro"';
  Result := Result + ' WHEN "RETURN_COMISSION" THEN "Estorno de Comissão"';
  Result := Result + ' WHEN "REVERSAL_PROMOTION_REIMBURSEMENT_COMMISSION" THEN "Estorno de Comissão de Ressarcimento de Promoção"';
  Result := Result + ' WHEN "RETURN_PURCHASE" THEN "Estorno de Compra"';
  Result := Result + ' WHEN "PROMOTIONAL_DISCOUNT_CHARGEBACK" THEN "Estorno de Desconto de Promoção"';
  Result := Result + ' WHEN "RETURN_SHIP" THEN "Estorno de Frete"';
  Result := Result + ' WHEN "RETURN_INCOME_TAX" THEN "Estorno de Imposto de Renda"';
  Result := Result + ' WHEN "RETURN_AME_PAYMENT" THEN "Estorno de Pagamento Ame Digital"';
  Result := Result + ' WHEN "RETURN_EXPENSE" THEN "Estorno de Pagamento de Despesas"';
  Result := Result + ' WHEN "ORDER_RETURN_LOST_POSTAL_FLOW" THEN "Estorno de Pedido Extraviado"';
  Result := Result + ' WHEN "RETURN_PROMOTION" THEN "Estorno de Promoção"';
  Result := Result + ' WHEN "RETURN_PROMO_FREIGHT" THEN "Estorno de Promoção de Frete"';
  Result := Result + ' WHEN "RETURN_TAX" THEN "Estorno de Tarifa"';
  Result := Result + ' WHEN "RETURN_ADDITIONAL_FEE" THEN "Estorno de Tarifa Adicional"';
  Result := Result + ' WHEN "RETURN_TAXES_AMOUNT" THEN "Estorno de Taxa de imposto"';
  Result := Result + ' WHEN "RETURN_SALE" THEN "Estorno de Venda"';
  Result := Result + ' WHEN "RETURN_SHIP_PARTICIPATION" THEN "Estorno de participação de frete"';
  Result := Result + ' WHEN "CHARGEBACK_TAX_CORRIENTES" THEN "Estorno de retenção de imposto sobre o IIBB de Corrientes"';
  Result := Result + ' WHEN "RETURN_FIXED_TAX" THEN "Estorno de taxa fixa"';
  Result := Result + ' WHEN "RETURN_LOST_ORDER" THEN "Estorno do Pedido Perdido"';
  Result := Result + ' WHEN "RETURN_CAMPAIGN_REFUND" THEN "Estorno do Reembolso de Campanha"';
  Result := Result + ' WHEN "MAGALU_PROMO_REFUND_REVERSAL" THEN "Estorno do Reembolso de Promoção Magalu"';
  Result := Result + ' WHEN "RETURN_OPERATIONAL_ERROR" THEN "Estorno por Erro Operacional"';
  Result := Result + ' WHEN "NEGATIVE_EVENT_WITH_OBS" THEN "Evento negativo com observações"';
  Result := Result + ' WHEN "POSITIVE_EVENT_WITH_OBS" THEN "Evento positivo com observações"';
  Result := Result + ' WHEN "SHIP_FULLFILMENT" THEN "FBA - Frete Fullfilment"';
  Result := Result + ' WHEN "TRANSFER_FAIL" THEN "Falha na Transferência"';
  Result := Result + ' WHEN "SHIP" THEN "Frete"';
  Result := Result + ' WHEN "SHIP_INTEGRATION" THEN "Frete - Integração"';
  Result := Result + ' WHEN "DAFITI_SHIPPING" THEN "Frete Dafiti Envios"';
  Result := Result + ' WHEN "DAFITI_SHIPPING_PRICED" THEN "Frete Dafiti Envios Precificado"';
  Result := Result + ' WHEN "FREE_SHIPPING" THEN "Frete Grátis Amazon"';
  Result := Result + ' WHEN "PROMOTIONAL_FREIGHT" THEN "Frete Promocional"';
  Result := Result + ' WHEN "INCOME_TAX" THEN "Imposto de Renda"';
  Result := Result + ' WHEN "COMMODITY_CIRCULATION_TAX" THEN "Imposto sobre Circulação de Mercadoria"';
  Result := Result + ' WHEN "CHARGEBACK_TAX_COLLECTOR" THEN "Imposto sobre Créditos e Débitos"';
  Result := Result + ' WHEN "TAX_COLLECTOR" THEN "Imposto sobre Créditos e Débitos"';
  Result := Result + ' WHEN "POSTAGE_FEE_TAX" THEN "Imposto sobre Taxa de Postagem"';
  Result := Result + ' WHEN "SUBSCRIPTION_TAX" THEN "Imposto sobre a assinatura"';
  Result := Result + ' WHEN "MANUAL_CREDIT_TAX" THEN "Imposto sobre crédito manual"';
  Result := Result + ' WHEN "MANUAL_INVOICE_TAX" THEN "Imposto sobre fatura manual"';
  Result := Result + ' WHEN "HANDLE_CREATED" THEN "Inclusão manual"';
  Result := Result + ' WHEN "INTERMEDIATION_COMMERCIAL_PARTNERSHIP" THEN "Intermediação parceria comercial"';
  Result := Result + ' WHEN "RELEASE_RESERVE_BALANCE" THEN "Liberação de Reserva de Saldo"';
  Result := Result + ' WHEN "REVERSE_LOGISTIC" THEN "Logística Reversa"';
  Result := Result + ' WHEN "MEDIATION" THEN "Mediação"';
  Result := Result + ' WHEN "MEDIATION_CANCEL" THEN "Mediação Cancelada"';
  Result := Result + ' WHEN "COMMERCIAL_PENALTY" THEN "Multa Comercial"';
  Result := Result + ' WHEN "OTHERS_CREDITS" THEN "Outros Créditos"';
  Result := Result + ' WHEN "OTHERS_DEBITS" THEN "Outros Débitos"';
  Result := Result + ' WHEN "AME_PAYMENT" THEN "Pagamento Ame Digital"';
  Result := Result + ' WHEN "NEXOOS_INSTALLMENT_PAYMENT" THEN "Pagamento Parcela Nexoos"';
  Result := Result + ' WHEN "EXPENSE" THEN "Pagamento de Despesas"';
  Result := Result + ' WHEN "INSTALLMENT_PAYMENT" THEN "Pagamento de Parcela de Crédito"';
  Result := Result + ' WHEN "OVERPAYMENT" THEN "Pagamento indevido"';
  Result := Result + ' WHEN "SELLER_CREDIT_INSTALLMENT" THEN "Parcela de Crédito Seller"';
  Result := Result + ' WHEN "SHIP_PARTICIPATION" THEN "Participação de frete"';
  Result := Result + ' WHEN "PENALTY" THEN "Penalidade/Multa"';
  Result := Result + ' WHEN "REVERSE_POST" THEN "Postagem Reversa"';
  Result := Result + ' WHEN "ADVERTISEMENT" THEN "Propaganda"';
  Result := Result + ' WHEN "CELLPHONE_RECHARGE" THEN "Recarga de celular"';
  Result := Result + ' WHEN "ORDER_GIFT_WRAP" THEN "Receita Embalagem para Presente"';
  Result := Result + ' WHEN "ATOZ_GUARANTEE_RECOVERY" THEN "Recuperação Garantia A-Z"';
  Result := Result + ' WHEN "CHARGE_BACK_FREIGHT_REFUND" THEN "Recuperação de Reembolso de Frete"';
  Result := Result + ' WHEN "SUBSCRIPTION_FEE_REFUND" THEN "Reembolso da Taxa de Assinatura"';
  Result := Result + ' WHEN "CAMPAIGN_REFUND" THEN "Reembolso de Campanha"';
  Result := Result + ' WHEN "CHARGE_BACK_COMISSION" THEN "Reembolso de Comissão"';
  Result := Result + ' WHEN "BACK_COMMISSION_COMMERCIAL_DEAL" THEN "Reembolso de Comissão - Acordo Comercial"';
  Result := Result + ' WHEN "BLOCK_CHARGE_BACK_COMISSION" THEN "Reembolso de Comissão Bloqueado"';
  Result := Result + ' WHEN "UNBLOCK_CHARGE_BACK_COMISSION" THEN "Reembolso de Comissão Desbloqueado"';
  Result := Result + ' WHEN "CHARGE_BACK_SHIP" THEN "Reembolso de Frete"';
  Result := Result + ' WHEN "BACK_SHIP_COMMERCIAL_DEAL" THEN "Reembolso de Frete - Acordo Comercial"';
  Result := Result + ' WHEN "CHARGE_BACK_FREIGHT" THEN "Reembolso de Frete Amazon"';
  Result := Result + ' WHEN "BLOCK_CHARGE_BACK_SHIP" THEN "Reembolso de Frete Bloqueado"';
  Result := Result + ' WHEN "UNBLOCK_CHARGE_BACK_SHIP" THEN "Reembolso de Frete Desbloqueado"';
  Result := Result + ' WHEN "MAGALU_PROMO_REFUND" THEN "Reembolso de Promoção Magalu"';
  Result := Result + ' WHEN "SHOPEE_REBATE" THEN "Reembolso de Promoção Shopee"';
  Result := Result + ' WHEN "ASSET_MANAGEMENT_RETURN" THEN "Reembolso de Rendimento Bruto"';
  Result := Result + ' WHEN "CHARGE_BACK_SALE" THEN "Reembolso de Venda"';
  Result := Result + ' WHEN "BLOCK_CHARGE_BACK_SALE" THEN "Reembolso de Venda Bloqueado"';
  Result := Result + ' WHEN "UNBLOCK_CHARGE_BACK_SALE" THEN "Reembolso de Venda Desbloqueado"';
  Result := Result + ' WHEN "REIMBURSEMENT_SALE" THEN "Reembolso de Venda Leroy"';
  Result := Result + ' WHEN "REFUND_COMISSION" THEN "Reembolso de comissão Amazon"';
  Result := Result + ' WHEN "REIMBURSEMENT_COMISSION" THEN "Reembolso de comissão Leroy"';
  Result := Result + ' WHEN "CHARGE_BACK_OF_FREIGHT_RETURN" THEN "Reembolso de estorno indevido do frete"';
  Result := Result + ' WHEN "REIMBURSEMENT_SHIP" THEN "Reembolso de frete Leroy"';
  Result := Result + ' WHEN "CHARGE_BACK_INSTALLMENT_FEE" THEN "Reembolso de taxa de parcelamento"';
  Result := Result + ' WHEN "BUYER_RECHARGE" THEN "Reembolso por Contestação"';
  Result := Result + ' WHEN "REFUND_PAWS_V2" THEN "Reembolso/PAWS-V2"';
  Result := Result + ' WHEN "REFUND_GOODWILL" THEN "Reembolso/Patrimônio de marca"';
  Result := Result + ' WHEN "ASSET_MANAGEMENT" THEN "Rendimento Bruto"';
  Result := Result + ' WHEN "RESERVE_VALUE" THEN "Reserva de valor"';
  Result := Result + ' WHEN "REIMBURSEMENT_FREIGHT_PARTICIPATION" THEN "Ressarcimento Participação de Frete"';
  Result := Result + ' WHEN "REIMBURSEMENT_FREIGHT_FEE" THEN "Ressarcimento Taxa de Frete"';
  Result := Result + ' WHEN "SHIP_REFUND" THEN "Ressarcimento avarias no pedido"';
  Result := Result + ' WHEN "PROMOTION_REFUND" THEN "Ressarcimento de Promoção"';
  Result := Result + ' WHEN "DEBTOR_BALANCE_REFUND" THEN "Ressarcimento de Saldo Devedor"';
  Result := Result + ' WHEN "REFUND_DUPLICATED" THEN "Ressarcimento de frete duplicado"';
  Result := Result + ' WHEN "REIMBURSEMENT_OF_VALUE" THEN "Ressarcimento de valor"';
  Result := Result + ' WHEN "TAX_INCOME_TAX" THEN "Retenção de imposto de Renda"';
  Result := Result + ' WHEN "TAX_SIRTAC" THEN "Retenção de imposto retido na fonte - SIRTAC"';
  Result := Result + ' WHEN "TAX_BUENOS_AIRES" THEN "Retenção de imposto sobre o IIBB de Buenos Aires"';
  Result := Result + ' WHEN "TAX_CORRIENTES" THEN "Retenção de imposto sobre o IIBB de Corrientes"';
  Result := Result + ' WHEN "TAX_ENTRE_RIOS" THEN "Retenção de imposto sobre o IIBB de Entre Rios"';
  Result := Result + ' WHEN "TAX_SANTA_FE" THEN "Retenção de imposto sobre o IIBB de Santa Fé"';
  Result := Result + ' WHEN "TAX_OTHER_CITIES" THEN "Retenção de imposto sobre o IIBB de outras cidades"';
  Result := Result + ' WHEN "TAX_ADDED_VALUE" THEN "Retenção de imposto sobre valor agregado"';
  Result := Result + ' WHEN "WITHDRAWAL" THEN "Retirada"';
  Result := Result + ' WHEN "PAYMENT_RETRACTION_NON_ITEMIZED" THEN "Retirada de pagamento"';
  Result := Result + ' WHEN "RETURN_COMMISSION_CHARGEBACK" THEN "Retorno Estorno de Comissão"';
  Result := Result + ' WHEN "RETURN_SALE_CHARGEBACK" THEN "Retorno Estorno de Venda"';
  Result := Result + ' WHEN "CANCELLATION_REVERSAL" THEN "Reversão de Cancelamento"';
  Result := Result + ' WHEN "REVERSAL_REIMBURSEMENT" THEN "Reversão de estorno"';
  Result := Result + ' WHEN "PREVIOUS_AMOUNT" THEN "Saldo Anterior"';
  Result := Result + ' WHEN "CURRENT_AMOUNT" THEN "Saldo Atual"';
  Result := Result + ' WHEN "SUCCESSFUL_CHARGE" THEN "Saldo Devedor Cobrado no Cartão de Crédito"';
  Result := Result + ' WHEN "PAYABLE_TO_AMAZON" THEN "Saldo Devedor da Conta"';
  Result := Result + ' WHEN "INITIAL_AVAILABLE_BALANCE" THEN "Saldo Inicial"';
  Result := Result + ' WHEN "PRE_PAYOUT" THEN "Saldo antes do saque ou transferência"';
  Result := Result + ' WHEN "POST_PAYOUT" THEN "Saldo após o saque ou transferência"';
  Result := Result + ' WHEN "BALANCE_PAGARME_ACCOUNT" THEN "Saldo em Conta Pagar.me"';
  Result := Result + ' WHEN "SAKE" THEN "Saque"';
  Result := Result + ' WHEN "RELEASE_PAYOUT" THEN "Saque do saldo disponível"';
  Result := Result + ' WHEN "TAX" THEN "Tarifa"';
  Result := Result + ' WHEN "ADDITIONAL_FEE" THEN "Tarifa Adicional"';
  Result := Result + ' WHEN "SHIPPING_FEE" THEN "Tarifa de envio"';
  Result := Result + ' WHEN "ADM_FEE_REFUND" THEN "Taxa Administrativa de Reembolso"';
  Result := Result + ' WHEN "SUBSCRIPTION_FEE" THEN "Taxa de Assinatura"';
  Result := Result + ' WHEN "CANCELATION_FEE" THEN "Taxa de Cancelamento"';
  Result := Result + ' WHEN "SHIPPING_CHARGEBACK_TAX" THEN "Taxa de Dedução de Frete"';
  Result := Result + ' WHEN "SHIPPING_HB" THEN "Taxa de Operação Amazon"';
  Result := Result + ' WHEN "INSTALLMENT_FEE" THEN "Taxa de Parcelamento"';
  Result := Result + ' WHEN "BLOCK_INSTALLMENT_FEE" THEN "Taxa de Parcelamento Bloqueado"';
  Result := Result + ' WHEN "UNBLOCK_INSTALLMENT_FEE" THEN "Taxa de Parcelamento Desbloqueado"';
  Result := Result + ' WHEN "PERMANENCE_FEE" THEN "Taxa de Permanencia Marketplace"';
  Result := Result + ' WHEN "POSTAGE_FEE" THEN "Taxa de Postagem"';
  Result := Result + ' WHEN "SERVICE_FEE" THEN "Taxa de Serviço"';
  Result := Result + ' WHEN "LOGISTICS_SERVICE_FEE" THEN "Taxa de Serviço Logístico"';
  Result := Result + ' WHEN "TRANSACTION_FEE" THEN "Taxa de Transação"';
  Result := Result + ' WHEN "TRANSFER_FEE" THEN "Taxa de Transferência"';
  Result := Result + ' WHEN "TAXES_AMOUNT" THEN "Taxa de imposto"';
  Result := Result + ' WHEN "FIXED_TAX" THEN "Taxa fixa"';
  Result := Result + ' WHEN "TRANSFER" THEN "Transferência"';
  Result := Result + ' WHEN "TRANSFER_WITH_OBSERVATION_NEG" THEN "Transferência com Observação Negativa"';
  Result := Result + ' WHEN "TRANSFER_WITH_OBSERVATION_POS" THEN "Transferência com Observação Positiva"';
  Result := Result + ' WHEN "MONEY_TRANSFER" THEN "Transferência de Dinheiro"';
  Result := Result + ' WHEN "TRANSFER_FUNDS_UNSUCCESSFUL" THEN "Transferência de fundos sem sucesso"';
  Result := Result + ' WHEN "RELEASE_RECEIVABLE_LOCK" THEN "Trava de recebível"';
  Result := Result + ' WHEN "BLOCK_RESERVE_FOR_REFUND" THEN "Valor bloqueado para estorno"';
  Result := Result + ' WHEN "BLOCK_RESERVE_FOR_PAYMENT" THEN "Valor bloqueado para pagamentos."';
  Result := Result + ' WHEN "BLOCK_AMOUNT_BY_DISPUTE" THEN "Valor bloqueado por contestação"';
  Result := Result + ' WHEN "BLOCK_BACEN_JUD" THEN "Valor bloqueado por ordem judicial BACEN."';
  Result := Result + ' WHEN "BLOCK_COMISSION" THEN "Valor de Comissão Bloqueado"';
  Result := Result + ' WHEN "BLOCK_COMISSION_INCIDENT" THEN "Valor de Comissão Bloqueado devido à incidente"';
  Result := Result + ' WHEN "UNBLOCK_COMISSION" THEN "Valor de Comissão Desbloqueado"';
  Result := Result + ' WHEN "UNBLOCK_COMISSION_INCIDENT" THEN "Valor de Comissão Desbloqueado devido à incidente"';
  Result := Result + ' WHEN "BLOCK_SHIP" THEN "Valor de Frete Bloqueado"';
  Result := Result + ' WHEN "BLOCK_SHIP_INCIDENT" THEN "Valor de Frete Bloqueado devido à incidente"';
  Result := Result + ' WHEN "UNBLOCK_SHIP" THEN "Valor de Frete Desbloqueado"';
  Result := Result + ' WHEN "UNBLOCK_SHIP_INCIDENT" THEN "Valor de Frete Desbloqueado devido à incidente"';
  Result := Result + ' WHEN "BLOCK_SALE" THEN "Valor de Venda Bloqueado"';
  Result := Result + ' WHEN "BLOCK_SALE_INCIDENT" THEN "Valor de Venda Bloqueado devido à incidente"';
  Result := Result + ' WHEN "UNBLOCK_SALE" THEN "Valor de Venda Desbloqueado"';
  Result := Result + ' WHEN "UNBLOCK_SALE_INCIDENT" THEN "Valor de Venda Desbloqueado devido à incidente"';
  Result := Result + ' WHEN "UNBLOCK_RESERVE_FOR_REFUND" THEN "Valor desbloqueado para estorno"';
  Result := Result + ' WHEN "UNBLOCK_RESERVE_FOR_PAYMENT" THEN "Valor desbloqueado para pagamentos."';
  Result := Result + ' WHEN "UNBLOCK_AMOUNT_BY_DISPUTE" THEN "Valor desbloqueado por contestação"';
  Result := Result + ' WHEN "UNBLOCK_BACEN_JUD" THEN "Valor desbloqueado por ordem judicial BACEN."';
  Result := Result + ' WHEN "SALE" THEN "Venda"';
  Result := Result + ' ELSE A.KON_TIPREG END ';
end;

end.
