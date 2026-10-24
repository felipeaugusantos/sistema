unit untFatMostraMargem;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, EditFocus, {Qt,} Menus, AppEvnts, UniClientDataSet, DB,
  untFuncoesSimples, BitBtnLockedIncrem, untFuncFat, Uni, untTypesSistema,
  Mask, DBCtrls, DBEditFocus, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, untFuncFatTypes, System.Generics.Collections, untTypesMargem;

type
  TfrmFatMostraMargem = class(TfrmPaiSimples)
    pnlBotoesMarg: TPanel;
    btnFechar: TBitBtnLocked;
    pnlTotais: TPanel;
    edtProVen: TEditFocus;
    lblProVen: TLabel;
    lbl1: TLabel;
    lblUltVen: TLabel;
    dbeDesIte: TDBEditFocus;
    edtUltVen: TEditFocus;
    pnlFrete: TPanel;
    edtTotFrete: TEditFocus;
    lblFrete: TLabel;
    lblFreSuges: TLabel;
    edtFreSuges: TEditFocus;
    chkAcuFreteCobPrecoUni: TCheckBox;
    chkAcuFreteSugPrecoCus: TCheckBox;
    pnlBtnConfirma: TPanel;
    btnConfirma: TBitBtnLocked;
    pnlDesconto: TPanel;
    btnDesconto: TBitBtnLocked;
    pnlCustosMargemTintas: TPanel;
    btnCustosMargemTintas: TBitBtnLocked;
    pnlTravasMinimas: TPanel;
    btnTravasMinimas: TBitBtnLocked;
    pnlMargemSobreItens: TPanel;
    btnMargemSobreItens: TBitBtnLocked;
    pnlVenCli: TPanel;
    btnVenCli: TBitBtnLocked;
    pnlUltCompraEmp: TPanel;
    btnUltCompraEmp: TBitBtnLocked;
    pnlDeseja: TPanel;
    btnDeseja: TBitBtnLocked;
    popGrid: TPopupMenu;
    ImprimirF4: TMenuItem;
    pnlGrids: TPanel;
    dbgItens: TDBGridCitel;
    pnlGridTotais: TPanel;
    dbgTotais: TDBGridCitel;
    splGridTotais: TSplitter;
    chkUltVen: TCheckBox;
    procedure btnFecharClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgItensKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkAcuFreteCobPrecoUniClick(Sender: TObject);
    procedure btnDescontoClick(Sender: TObject);
    procedure btnCustosMargemTintasClick(Sender: TObject);
    procedure btnTravasMinimasClick(Sender: TObject);
    procedure btnMargemSobreItensClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnVenCliClick(Sender: TObject);
    procedure btnUltCompraEmpClick(Sender: TObject);
    procedure btnDesejaClick(Sender: TObject);
    procedure ImprimirF4Click(Sender: TObject);
    procedure popGridPopup(Sender: TObject);
    procedure splGridTotaisCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure dbgTotaisDrawColumnCell(Sender: TObject; const [Ref] Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure chkUltVenClick(Sender: TObject);
  private
    intDecUni : Integer;
    blnSomenteUnitarioAcimaDoSugerido : Boolean;
    cdsDados: TUniClientDataSet;
    cdsTotais: TUniClientDataSet;
    blnCanculandoTotal: Boolean;

    fltTotalG: Double;
    strMarPra: String;

    dicUltVen: TDicionario;

    blnPermiteEditarPrecoUnitario: Boolean;

    dicColunasF4 : TDictionary<String, Boolean>;

    const MSG_ITENS_NAO_DEDUTIVEIS: String = 'Não é possível alterar o valor da ' +
                                             'venda pois os itens inseridos não são dedutiveis!';

    const STR_TEXTO_TOTAL_S_DESC : String  = 'TOTAL S/ DESCONTO';
    const STR_TEXTO_TOTAL_C_DESC : String  = 'TOTAL C/ DESCONTO';

    function fRealizandoConfirmacao: Boolean;
    function fEhConfirmacaoDeDocumentosEPermiteEditarUnitario: Boolean;
    Function fValidaUnitario(DataSet: TDataSet; fltUnitar: Double): Boolean;

    procedure pPosicionarRegistroVenda(DataSet: TDataSet);    

    procedure pCalculaTotais;
    procedure pBeforeEdit(DataSet: TDataSet);
    procedure pBeforePost(DataSet: TDataSet);
    procedure pAfterPost(DataSet: TDataSet);
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pOnSetText(Sender: TField; const Text: string);
    procedure pFormataCamposGrid; overload;
    procedure pFormataCamposGrid(DataSet: TDataSet; blnSetText: Boolean); overload;
    function fTemTinta(): Boolean;
    procedure pVerificaBotoes(pnlPanel: TPanel; blnHabilita: Boolean);

    procedure pCarregaQryConIte;

    procedure pAtualizaLiberacaoUnitario(stlAutInc: TStringList);
    procedure pDescontoMajoramento(fltPerVal: Double; tipPorVal: TPorcentagemValor; cdsDestin: TUniClientDataSet; blnUsaPreIni: Boolean = true);
    function fPegaTotalParaDesconto(blnAplicarRestricoes: Boolean; cdsDestin: TUniClientDataSet): Double;
    function fItemEntraRateio(strPromoc: String; cdsDestin: TUniClientDataSet): Boolean;
    procedure pAplicarDesconto(cdsComDes: TUniClientDataSet);
    procedure pImprimirF4(DataSet: TDataSet; dicColunas : TDictionary<String, Boolean>; fncUserFunction: TUserFunction; blnTinta: Boolean; stlFunctions: TStringList);
    procedure pGerarDicionarioColunas;
    function fTotalDouble(strNomeCampo: String): Double;
    function fUserFunction(const MethodName: string; var Params: Variant): Variant;
    procedure pAjustaColunasTotal;
  public
    fltDesEsp : Double;
    blnTabPreIte: Boolean;

    cdsItens : TUniClientDataSet;
    dtsItens : TDataSource;
    dtsTotais : TDataSource;
    fatVenda : TFatVenda;
    qryTinta: TUniQuery;
    strCcnAnt: String;
    stlIteLib: TStringList;

    blnApenasVerificandoMargemComFrete: Boolean;

    fltUnitarAnt  : Double;
    fltPreCusAnt  : Double;
    fltMarLucAnt  : Double;

    recTotMarLuc : TRecTotaisMargemLucro;
    recTotMarLucTotIte : TRecTotaisMargemLucro;

    fltTotMarkup  : Double;

    pCalculaMargemLucro: TpCalcularMargemLucro;

    { Public declarations }
  end;

var
  frmFatMostraMargem: TfrmFatMostraMargem;

implementation

uses untPesqAux, untFuncoes, untFatMostraMargemTinta, untDadosFechamentoDadosTinta,
     untFatVendasCalculadorWrapper, untConstantes, untTConfiguracao,
     untParCalculaPrecoCusto, untFuncTinta, untFatMostraTravaMinimaHelper,
     untFuncFatTelasHelper, untFatMostraUltComEmpresas, untModuloFatMostraMargem,
     Winapi.Messages, untIcmsSTParteVenda;

{$R *.dfm}

procedure TfrmFatMostraMargem.btnConfirmaClick(Sender: TObject);
begin
  If stlIteLib.Count > 0 Then
    pAtualizaLiberacaoUnitario(stlIteLib);

  inherited;
end;

procedure TfrmFatMostraMargem.btnCustosMargemTintasClick(Sender: TObject);
begin
  Try
    Try
      if pnlCustosMargemTintas.Visible then
      begin
        frmFatMostraMargemTinta := TfrmFatMostraMargemTinta.Create(Self, fatVenda, cdsVenda, cdsItens, pImprimirF4);
        frmFatMostraMargemTinta.ShowModal;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmFatMostraMargemTinta) then FreeAndNil(frmFatMostraMargemTinta);
  End;
end;

procedure TfrmFatMostraMargem.btnDescontoClick(Sender: TObject);
  Var
    fltPerDes : Double;
begin
  inherited;
  If Not pnlDesconto.Visible Then
    Exit;

  If (fPegaTotalParaDesconto(True, cdsItens) = 0) Then
  Begin
    fMensagem('ATENÇÃO!', MSG_ITENS_NAO_DEDUTIVEIS, ['&OK']);
    Exit;
  End;

  If Not fDigitaValor(fltPerDes, 'Percentual de Desconto/Majoramento', '#,##0.00', True, True) Then
    Exit;

  pDescontoMajoramento(fltPerDes, tpvPorcentagem, cdsItens);
End;

procedure TfrmFatMostraMargem.btnDesejaClick(Sender: TObject);
  Var
    fltTotGerOri : Double;
    fltTotGerAtu : Double;
    fltDescAcres : Double;
    intCnt : Integer;
    cdsClone : TUniClientDataSet;
begin
  inherited;

  Try
    pnlInfo.Caption := 'Processando, por favor aguarde...';

    If Not pnlDeseja.Visible Then
      Exit;

    If Not btnDeseja.Visible Then
      Exit;

    If Not Assigned(fatVenda) Then
      Exit;

    If fFormataFloat(fatVenda.fltTotGer, 2) = 0 Then
      Exit;

    If (fPegaTotalParaDesconto(True, cdsItens) = 0) Then
    Begin
      fMensagem('ATENÇÃO!', MSG_ITENS_NAO_DEDUTIVEIS, ['&OK']);
      Exit;
    End;

    fltTotGerOri := fPegaTotalParaDesconto(False, cdsItens);
    fltTotGerAtu := fltTotGerOri;

    If Not fDigitaValor(fltTotGerAtu, 'Total Desejado da Venda', '#,##0.00') Then
      Exit;

    fltDesEsp := 0;

    // se for igual, não tem necessidade de mudar nada!
    If (fFormataFloat(fltTotGerAtu, 2) = fFormataFloat(fltTotGerOri, 2)) Then
      Exit;

    // If (fltDescAcres > 0) Then "DESCONTO" ELSE "ACRÉSCIMO" ;
    fltDescAcres := (fltTotGerOri - fltTotGerAtu);

    fltDescAcres := fFormataFloat(fltDescAcres, 2);

    // Cálcula o desconto, sobre o total, ou sobre o montante que pode se deduzido
    fltDescAcres := (fltDescAcres / fPegaTotalParaDesconto(True, cdsItens)) * 100;

    // Clono o Client pra não pedir a trava duas vezes
    cdsClone := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsClone, cdsItens);

    // Aplica o desconto, sobre o total, ou sobre o montante que pode se deduzido
    pDescontoMajoramento(fltDescAcres, tpvPorcentagem, cdsClone, False);

    // Pega a diferença pra ver se precisará ajustar algo
    fltDescAcres := fFormataFloat(fltTotGerAtu, 2) - fPegaTotalParaDesconto(False, cdsClone);

    //Faz ajuste pra mais ou pra menos
    If fFormataFloat(fltDescAcres, 2) <> 0 Then
    Begin
      If fFormataFloat(fltDescAcres, 2) <= 0 Then
        fltDesEsp := fFormataFloat(Abs(fltDescAcres), 2)
      Else
      Begin
        For intCnt := 1 To 5 Do
        Begin
          pDescontoMajoramento(fFormataFloat(fltDescAcres, 2), tpvValor, cdsClone, False);
          fltDescAcres := fFormataFloat(fltTotGerAtu, 2) - fPegaTotalParaDesconto(False, cdsClone);

          If (fFormataFloat(fltDescAcres, 2) <= 0) Then
          Begin
            fltDesEsp := fFormataFloat(Abs(fltDescAcres), 2);
            Break;
          End;
        End;
      End;
    End;

    // Pega as alterações do Clone e joga na principal, agora olhando as trava de unitário
    cdsItens.DisableControls();
    pAplicarDesconto(cdsClone);
    pMensagemOk('Operação concluída com sucesso!');
  Finally
    cdsItens.EnableControls();
    FreeAndNil(cdsClone);

    pnlInfo.Caption := '';
  End;
end;

procedure TfrmFatMostraMargem.pOnSetText(Sender: TField; const Text: string);
begin
  Try
    Sender.Value := fStrToFloat(Text);
  Except
    pMensagemOk(Text + ' não é um número válido. Verifique!');
  End;
end;

procedure TfrmFatMostraMargem.popGridPopup(Sender: TObject);
begin
  inherited;
  ImprimirF4.Enabled := (Assigned(cdsItens)) And (cdsItens.Active) And (Not cdsItens.IsEmpty) And fVerificaAcessoSistema('IMPRF4', strLoginUsuarioLogado);
end;

procedure TfrmFatMostraMargem.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraMargem.btnMargemSobreItensClick(Sender: TObject);
  Var
    fltMarIte : Double;
begin
  inherited;
  If Not pnlMargemSobreItens.Visible Then
    Exit;

  If Not fDigitaValor(fltMarIte, 'Percentual margem praticada', '#,##0.00', True, True) Then
    Exit;

  Try
    pVerificaBotoes(pnlBotoesMarg, False);
    pnlInfo.Caption := 'Aguarde...';
    Application.ProcessMessages;
    With cdsItens Do
    Begin
      First;
      While Not Eof Do
      Begin
        If blnPermiteEditarPrecoUnitario Then
        Begin
          Try
            dbgItens.SelectedField := FieldByName('ITE_MARLUC');
            Edit;
            FieldByName('ITE_MARLUC').AsFloat := fltMarIte;
            Post;
          Except
            On E: EAbort Do
            Begin
              //Deve continuar o processamento dos produtos
            End;

            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '');
            End;
          End;
        End;
        Next;
      End;
      First;
    End;
  Finally
    pnlInfo.Caption := '';
    pVerificaBotoes(pnlBotoesMarg, True);
    Application.ProcessMessages;
  End;
end;

procedure TfrmFatMostraMargem.btnTravasMinimasClick(Sender: TObject);
begin
  inherited;
  If Not pnlTravasMinimas.Visible Then
    Exit;

  If TMostraTravaMinimaHelper.fExibeTravaMinima Then
    TMostraTravaMinimaHelper.pExibeDados(fatVenda.cdsTravaMinima, fatVenda);
end;

procedure TfrmFatMostraMargem.btnUltCompraEmpClick(Sender: TObject);
begin
  If (Not Assigned(cdsItens)) Or
     (Not cdsItens.Active) Or
     (cdsItens.IsEmpty) Then
    Exit;

  Try
    Try
      if (pnlUltCompraEmp.Visible) And (btnUltCompraEmp.Enabled) And (btnUltCompraEmp.Visible) then
      begin
        frmFatMostraUltComEmpresas := TfrmFatMostraUltComEmpresas.Create(Self, cdsItens.FieldByName('ITE_CODITE').AsString);
        frmFatMostraUltComEmpresas.ShowModal;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmFatMostraUltComEmpresas) then
      FreeAndNil(frmFatMostraUltComEmpresas);
  End;
end;

procedure TfrmFatMostraMargem.btnVenCliClick(Sender: TObject);
  Var
    intConfirmando : Integer;
begin
  inherited;

  intConfirmando := -1;

  If (pnlVenCli.Visible) And (btnVenCli.Visible) And (btnVenCli.Enabled) And (Assigned(fatVenda)) Then
    fatVenda.pVendasPorCliente(True, intConfirmando, fatVenda.strCodCli, fatVenda.strCliOri);
end;

procedure TfrmFatMostraMargem.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  With cdsItens Do
  Case Key Of
    VK_Escape: btnFechar.Click;
    VK_RETURN: If State = dsEdit Then
                 Post;
  End;
end;

procedure TfrmFatMostraMargem.FormCreate(Sender: TObject);
begin
  inherited;
  fltDesEsp := 0;

  blnCanculandoTotal := False;
  blnApenasVerificandoMargemComFrete := False;

  strMarPra := fCfgSis('MARPRA');

  dtsItens := TDataSource.Create(Self);
  dtsTotais:= TDataSource.Create(Self);
  cdsItens := TUniClientDataSet.Create(Self);
  cdsTotais:= TUniClientDataSet.Create(Self);

  dicUltVen := TDicionario.Create;
  blnSomenteUnitarioAcimaDoSugerido := False;
  stlIteLib := TStringList.Create;

  FillChar(recTotMarLuc, SizeOf(recTotMarLuc), #0);
  FillChar(recTotMarLucTotIte, SizeOf(recTotMarLucTotIte), #0);

  dicColunasF4 := TDictionary<String, Boolean>.Create;

  {$IFDEF TESTABILIDADE_AUTCOM}
    dbgTotais.Enabled := True;
  {$ELSE}
    dbgTotais.Enabled := False;
  {$ENDIF}
end;

procedure TfrmFatMostraMargem.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsTotais);
  FreeAndNil(dtsTotais);
end;

procedure TfrmFatMostraMargem.pCalculaTotais;
  Var
    fltTotPreCus : Double;
    calcCustoReal : TCalcCustoReal;
    intRecNo : Integer;
    strCodSit,
    strCodAbf: String;
Begin
  cdsTotais.DisableControls;
  Try
    If (Not cdsTotais.Active) Then
      pCloneDataSet(cdsTotais, cdsItens, True);

    cdsTotais.EmptyDataSet;

    cdsTotais.Append;
    cdsTotais.FieldByName('ITE_SEQUEN').AsInteger := 1;
    cdsTotais.FieldByName('ITE_CODITE').AsString := '';
    cdsTotais.FieldByName('ITE_DESITE').AsString := STR_TEXTO_TOTAL_S_DESC;
    cdsTotais.FieldByName('ITE_UNIORI').AsFloat  := recTotMarLuc.fltTotUniOri;
    cdsTotais.FieldByName('ITE_UNITAR').AsFloat  := recTotMarLuc.fltTotUnitar;
    cdsTotais.FieldByName('ITE_PRECUS').AsFloat  := recTotMarLuc.fltTotCusto;
    cdsTotais.FieldByName('ITE_PREMED').AsFloat  := recTotMarLuc.fltTotMedio;
    cdsTotais.FieldByName('ITE_CUSIMP').AsFloat  := recTotMarLuc.fltTotCusImp;
    cdsTotais.FieldByName('ITE_MARLUC').AsFloat  := recTotMarLuc.fltTotMarPrat;
    cdsTotais.FieldByName('ITE_MARKUP').AsFloat  := fltTotMarkup;
    cdsTotais.FieldByName('ITE_MARITE').AsFloat  := recTotMarLuc.fltTotMarItem;
    cdsTotais.FieldByName('ITE_MARMED').AsFloat  := recTotMarLuc.fltTotMarMedio;
    cdsTotais.FieldByName('ITE_MARIMP').AsFloat  := recTotMarLuc.fltTotMarImpUlt;
    cdsTotais.FieldByName('ITE_RESULT').AsFloat := recTotMarLuc.fltTotUnitar - recTotMarLuc.fltTotCusto;
    cdsTotais.FieldByName('ITE_PREIDE').AsFloat := recTotMarLuc.fltTotPreIde;
    cdsTotais.FieldByName('ITE_MARIDE').AsFloat := recTotMarLuc.fltTotMarIde;
    cdsTotais.FieldByName('ITE_MCAT17').AsFloat := recTotMarLuc.fltTotMCat17;
    If fFormataFloat(recTotMarLuc.fltTotUniOri*recTotMarLuc.fltTotQtdIte, 2) <> 0.00 Then
      cdsTotais.FieldByName('ITE_PERDES').AsFloat := fFormataFloat((((recTotMarLuc.fltTotUniOri*recTotMarLuc.fltTotQtdIte) - (recTotMarLuc.fltTotUnitar*recTotMarLuc.fltTotQtdIte))/(recTotMarLuc.fltTotUniOri*recTotMarLuc.fltTotQtdIte))*100, 2)
    Else
      cdsTotais.FieldByName('ITE_PERDES').AsFloat := 0;
    cdsTotais.Post;

    If (fltDesEsp > 0) Then
    Begin
      cdsTotais.Append;
      cdsTotais.FieldByName('ITE_SEQUEN').AsInteger := 2;
      cdsTotais.FieldByName('ITE_CODITE').AsString := '';
      cdsTotais.FieldByName('ITE_DESITE').AsString := 'DESCONTO: ' + FormatFloat('#,##0.00', fltDesEsp);
      cdsTotais.Post;

      fltTotPreCus := recTotMarLucTotIte.fltTotCusto;

      If (Assigned(fatVenda)) Then
      Begin
        calcCustoReal := TCalcCustoReal.Create;
        cdsItens.DisableControls;
        intRecNo := cdsItens.RecNo;
        Try
          fltTotPreCus := 0;

          cdsItens.First;
          While Not cdsItens.Eof Do
          Begin
            calcCustoReal.fltUnitar := (fFormataFloat(cdsItens.FieldByName('ITE_UNITAR').AsFloat - ((fltDesEsp * cdsItens.FieldByName('ITE_UNITAR').AsFloat) / (recTotMarLucTotIte.fltTotUnitar + fltDesEsp)), 2));
            calcCustoReal.fltPreCus := cdsItens.FieldByName('ITE_CUSITE').AsFloat;
            calcCustoReal.fltOutVal := cdsItens.FieldByName('ITE_OUTVAL').AsFloat;
            calcCustoReal.fltIcmSai := IIF(fCfgSis('IMPCF4', varBoolean) And (cdsItens.FieldByName('ITE_IDEPRO').AsString = 'NOR'),
                                       fatVenda.fCalculaAliquota(cdsItens.FieldByName('ITE_CODITE').AsString, cdsItens.FieldByName('ITE_IMPDIR').AsString),
                                       cdsItens.FieldByName('ITE_ICMSAI').AsFloat);

            If (fCfgSis('MARMKP') = '4') And (fatVenda.fDentroDoEstado) And
                (Assigned(cdsItens.FindField('ITE_ICMCAL'))) And (fCfgSis('IMPCF4', varBoolean)) Then
              calcCustoReal.fltIcmSai := cdsItens.FieldByName('ITE_ICMCAL').AsFloat;

            calcCustoReal.fltImpFed := cdsItens.FieldByName('ITE_IMPFED').AsFloat;
            calcCustoReal.fltDesOpe := cdsItens.FieldByName('ITE_DESOPE').AsFloat + fatVenda.fltDesOpeCli;

            If (Assigned(cdsItens.findField('ITE_CALCST'))) Then
            Begin
              calcCustoReal.blnCalcST := cdsItens.FieldByName('ITE_CALCST').AsBoolean;
              calcCustoReal.fltIcmPav := cdsItens.FieldByName('ITE_ICMPAV').AsFloat;
            End;

            If (cdsItens.FieldByName('ITE_VAL_ST').AsFloat = 0) Then
            Begin
              strCodSit := '';
              strCodAbf := fGetCodAbf(cdsItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp);
              If (Not fEmptyStr(fatVenda.strTpAbre)) And (fatVenda.fBuscaAbfIcm(cdsItens.FieldByName('ITE_CODITE').AsString, strCodAbf, fatVenda.fTrocaUFEndEntrega)) Then
                strCodSit := fatVenda.cdsAbfIcm.FieldByName('ABF_CODSIT' + fatVenda.strTpAbre).AsString;

              calcCustoReal.fltDifal := fatVenda.fGetValorDifalIcms(cdsItens.FieldByName('ITE_CODITE').AsString,
                                                                    strCodAbf,
                                                                    strCodSit,
                                                                    calcCustoReal.fltIcmSai,
                                                                    calcCustoReal.fltUnitar);

              calcCustoReal.fltFcp   := fatVenda.fGetValorFcpIcms(cdsItens.FieldByName('ITE_CODITE').AsString,
                                                                  strCodAbf,
                                                                  strCodSit,
                                                                  calcCustoReal.fltIcmSai,
                                                                  calcCustoReal.fltUnitar);
            End;

            fltTotPreCus := fltTotPreCus + ((fatVenda.fRetornaPrecoCusto(Preco_de_Custo_Real,
                                             cdsItens.FieldByName('ITE_CODITE').AsString,
                                             cdsItens.FieldByName('ITE_CUSITE').AsFloat,
                                             '',
                                             calcCustoReal,
                                             (Pos('ITEM ESPECIAL', cdsItens.FieldByName('ITE_DESITE').AsString) > 0))) * cdsItens.FieldByName('ITE_QTDITE').AsFloat);

            cdsItens.Next;
          End;
        Finally
          cdsItens.RecNo := intRecNo;
          cdsItens.EnableControls;
          FreeAndNil(calcCustoReal);
        End;
      End;

      With recTotMarLucTotIte Do
      Begin
        cdsTotais.Append;
        cdsTotais.FieldByName('ITE_SEQUEN').AsInteger := 3;
        cdsTotais.FieldByName('ITE_CODITE').AsString := '';
        cdsTotais.FieldByName('ITE_DESITE').AsString := STR_TEXTO_TOTAL_C_DESC;
        cdsTotais.FieldByName('ITE_UNIORI').AsFloat  := fltTotUniOri;
        cdsTotais.FieldByName('ITE_UNITAR').AsFloat  := fltTotUnitar;
        cdsTotais.FieldByName('ITE_PRECUS').AsFloat  := fltTotPreCus;
        cdsTotais.FieldByName('ITE_PREMED').AsFloat  := fltTotMedio;
        cdsTotais.FieldByName('ITE_CUSIMP').AsFloat  := fltTotCusImp;
        cdsTotais.FieldByName('ITE_MARLUC').AsFloat  := fCalculaPrecoVenda(2, fltTotPreCus, fltTotUnitar, 0, 0, 0, 0, 0);
        cdsTotais.FieldByName('ITE_MARKUP').AsFloat  := fltTotMarkup;
        cdsTotais.FieldByName('ITE_MARITE').AsFloat  := fltTotMarItem;
        cdsTotais.FieldByName('ITE_MARMED').AsFloat  := fltTotMarMedio;
        cdsTotais.FieldByName('ITE_MARIMP').AsFloat  := fltTotMarImpUlt;
        cdsTotais.FieldByName('ITE_RESULT').AsFloat  := fltTotUnitar - fltTotPreCus;
        cdsTotais.FieldByName('ITE_PREIDE').AsFloat  := fltTotPreIde;
        cdsTotais.FieldByName('ITE_MARIDE').AsFloat  := fltTotMarIde;
        cdsTotais.FieldByName('ITE_MCAT17').AsFloat  := fltTotMCat17;
        If fFormataFloat(fltTotUniOri * fltTotQtdIte, 2) <> 0.00 Then
          cdsTotais.FieldByName('ITE_PERDES').AsFloat := fFormataFloat((((fltTotUniOri * fltTotQtdIte) - (fltTotUnitar * fltTotQtdIte))/(fltTotUniOri * fltTotQtdIte))*100, 2)
        Else
          cdsTotais.FieldByName('ITE_PERDES').AsFloat := 0;
        cdsTotais.Post;
      End;
    End;
  Finally
    cdsTotais.EnableControls;
  End;
End;

procedure TfrmFatMostraMargem.pCarregaQryConIte;
  Var
    strItens: String;
begin
  strItens := '';

  cdsItens.First;

  While Not cdsItens.Eof Do
  Begin
    If strItens <> '' Then
      strItens := strItens + ', ';

    strItens := strItens + QuotedStr(cdsItens.FieldByName('ITE_CODITE').AsString);

    fatVenda.pArmazenarItemNaListaDeItemForaPromo(cdsItens.FieldByName('ITE_CODITE').AsString, VS_strCodEmp);

    cdsItens.Next;
  End;

  cdsItens.First;

  If strItens = '' Then
    strItens := '""';

  fatVenda.qryConIte.Close;
  fatVenda.qryConIte.SQL.Clear;

  fatVenda.qryConIte.SQL.Add(' SELECT * FROM ITEGER ');
  fatVenda.qryConIte.SQL.Add(' WHERE ITEGER.ITE_CODEMP = :CODEMP AND ');
  fatVenda.qryConIte.SQL.Add(' ITEGER.ITE_CODITE IN (' + strItens + ') ');

  fatVenda.qryConIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
  fatVenda.qryConIte.Open;
end;

procedure TfrmFatMostraMargem.pDescontoMajoramento(fltPerVal: Double; tipPorVal: TPorcentagemValor; cdsDestin: TUniClientDataSet; blnUsaPreIni: Boolean = true);
  Var
    fltValDil : Double;
    fltUniSav : Double;
    strCampoPreIni : String;
begin
  If blnUsaPreIni Then
    strCampoPreIni := 'ITE_PREINI'
  Else
    strCampoPreIni := 'ITE_UNITAR';

  With cdsDestin Do
  Begin
    fltValDil := fltPerVal;

    First;
    While Not Eof Do
    Begin
      If (fItemEntraRateio(FieldByName('ITE_PROMOC').AsString, cdsDestin)) Then
      Begin
        Try
          dbgItens.SelectedField := FieldByName('ITE_UNITAR');
          Edit;
          Case tipPorVal Of
            tpvPorcentagem: FieldByName('ITE_UNITAR').AsFloat := fFormataFloat(FieldByName(strCampoPreIni).AsFloat *
                                               (1 - fltPerVal / 100), intDecUni);
            tpvValor:
            Begin
              fltUniSav := FieldByName('ITE_UNITAR').AsFloat;
              FieldByName('ITE_UNITAR').AsFloat := FieldByName('ITE_UNITAR').AsFloat + fltValDil;
              If (fFormataFloat(FieldByName('ITE_UNITAR').AsFloat, intDecUni)) <= 0 Then
                FieldByName('ITE_UNITAR').AsFloat := fltUniSav
              Else
                fltValDil := 0;
            End;
          End;
          Post;

          If (tipPorVal = tpvValor) And
             (fFormataFloat(fltValDil, 2) = 0) Then
            Break;

        Except
          On E: EAbort Do
          Begin
            //Deve continuar o processamento dos produtos
          End;
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '');
          End;
        End;
      End;
      Next;
    End;
    First;
  End;
end;

procedure TfrmFatMostraMargem.pFormataCamposGrid(DataSet: TDataSet;
  blnSetText: Boolean);
begin
  TFloatField(DataSet.FieldByName('ITE_UNITAR')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(DataSet.FieldByName('ITE_UNIORI')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(DataSet.FieldByName('ITE_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(DataSet.FieldByName('ITE_PERDES')).DisplayFormat := '##,#0.00';
  TFloatField(DataSet.FieldByName('ITE_PRECUS')).DisplayFormat := '##,#0.00';
  TFloatField(DataSet.FieldByName('ITE_MARLUC')).DisplayFormat := '##,#0.00';
  TFloatField(DataSet.FieldByName('ITE_MARITE')).DisplayFormat := '##,#0.00';
  TFloatField(DataSet.FieldByName('ITE_MARMIN')).DisplayFormat := '##,#0.00';
  TFloatField(DataSet.FieldByName('ITE_PREMED')).DisplayFormat := '##,#0.00';
  TFloatField(DataSet.FieldByName('ITE_MARMED')).DisplayFormat := '##,#0.00';
  TFloatField(DataSet.FieldByName('ITE_CUSIMP')).DisplayFormat := '##,#0.00';
  TFloatField(DataSet.FieldByName('ITE_MARIMP')).DisplayFormat := '##,#0.00';
  TFloatField(DataSet.FieldByName('ITE_MARKUP')).DisplayFormat := '##,#0.00';
  TFloatField(DataSet.FieldByName('ITE_RESULT')).DisplayFormat := '##,#0.00';
  TFloatField(DataSet.FieldByName('ITE_MARIDE')).DisplayFormat := '##,#0.00';
  TFloatField(DataSet.FieldByName('ITE_MCAT17')).DisplayFormat := '##,#0.00';
  TFloatField(DataSet.FieldByName('ITE_PREIDE')).DisplayFormat := '##,#0.00';

  If (blnSetText) Then
  Begin
    DataSet.FieldByName('ITE_UNITAR').OnSetText := pOnSetText;
    DataSet.FieldByName('ITE_PRECUS').OnSetText := pOnSetText;
    DataSet.FieldByName('ITE_MARLUC').OnSetText := pOnSetText;
  End;
end;

procedure TfrmFatMostraMargem.pVerificaBotoes(pnlPanel: TPanel; blnHabilita: Boolean);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To pnlPanel.ControlCount-1 Do
  Begin
    If (pnlPanel.Controls[intCnt] Is TPanel) Then
    Begin
      pVerificaBotoes((pnlPanel.Controls[intCnt] As TPanel), blnHabilita);
    End
    Else If (pnlPanel.Controls[intCnt] Is TBitBtnLocked) Then
    Begin
      If ((pnlPanel.Controls[intCnt] As TBitBtnLocked).Visible) Then
      Begin
        (pnlPanel.Controls[intCnt] As TBitBtnLocked).Enabled := blnHabilita;
      End;
    End;
  End;
end;

procedure TfrmFatMostraMargem.splGridTotaisCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
  Accept := (NewSize >= 100);
end;

procedure TfrmFatMostraMargem.pFormataCamposGrid;
begin
  pFormataCamposGrid(cdsItens, True);
  pFormataCamposGrid(cdsTotais, False);
end;

procedure TfrmFatMostraMargem.pGerarDicionarioColunas;
  Var
    intCnt : Integer;
    strNomeCol : String;
begin
  dicColunasF4.Clear;

  For intCnt := 0 To dbgItens.Columns.Count -1 Do
  Begin
    If (Not fEmptyStr(dbgItens.Columns[intCnt].FieldName)) And
       (Length(dbgItens.Columns[intCnt].FieldName) > 5) Then
    Begin
      strNomeCol := 'rll' + Copy(dbgItens.Columns[intCnt].FieldName, 5, Length(dbgItens.Columns[intCnt].FieldName));
      dicColunasF4.AddOrSetValue(strNomeCol, dbgItens.Columns[intCnt].Visible);
    End;
  End;
end;

procedure TfrmFatMostraMargem.pImprimirF4(DataSet: TDataSet; dicColunas : TDictionary<String, Boolean>; fncUserFunction: TUserFunction; blnTinta: Boolean; stlFunctions: TStringList);
  Var
    strDestino : String;
begin
  If fMensagem('','Saída', ['&Video', '&Imprimir']) = 1 Then
    strDestino := 'V'
  Else
    strDestino := 'I';

  frmModuloFatMostraMargem := TfrmModuloFatMostraMargem.Create(nil);
  Try
    frmModuloFatMostraMargem.dicColunas := dicColunas;
    frmModuloFatMostraMargem.blnTinta := blnTinta;
    frmModuloFatMostraMargem.fncUserFunction := fncUserFunction;
    frmModuloFatMostraMargem.stlFunctions := stlFunctions;
    frmModuloFatMostraMargem.pImprimir(DataSet, strDestino);
  Finally
    FreeAndNil(frmModuloFatMostraMargem);
  End;
end;

procedure TfrmFatMostraMargem.FormShow(Sender: TObject);
begin
  inherited;

  if Assigned(fatVenda) then
    intDecUni := fatVenda.VS_intDecUni
  else
    intDecUni := fCfgSis('DECUNI', varInteger);

  pCalculaTotais;
  pFormataCamposGrid;

  chkUltVen.Visible := False;

  If Assigned(fatVenda) Then
  Begin
    pCarregaQryConIte;

    fatVenda.blnAbriuF4 := True;
    edtTotFrete.Text := FormatFloat('#,##0.00', fatVenda.fltValFre);
    edtFreSuges.Text := FormatFloat('#,##0.00', fatVenda.fltFreSug);

    If (Not fClienteConsumidor(fRetNomCliente(fatVenda.strCodCli), True, True)) Then
    Begin
      chkUltVen.Visible := True;
    End;
  End;

  cdsItens.BeforeEdit  := pBeforeEdit;
  cdsItens.BeforePost  := pBeforePost;
  cdsItens.AfterPost   := pAfterPost;
  cdsItens.AfterScroll := pAfterScroll;
  cdsItens.First;

  If Assigned(fatVenda) Then
    fltTotalG := fatVenda.fltTotGer;

  cdsDados := TUniClientDataSet.Create(Self);

  fFindColumnByName(dbgItens, 'ITE_PREMED').Visible := fCfgSis('MARUIM') = MARUIM_PRECO_MEDIO;
  fFindColumnByName(dbgItens, 'ITE_MARMED').Visible := fCfgSis('MARUIM') = MARUIM_PRECO_MEDIO;
  fFindColumnByName(dbgItens, 'ITE_CUSIMP').Visible := fCfgSis('MARUIM') = MARUIM_PRECO_IMPULT;
  fFindColumnByName(dbgItens, 'ITE_MARIMP').Visible := fCfgSis('MARUIM') = MARUIM_PRECO_IMPULT;
  fFindColumnByName(dbgItens, 'ITE_MARKUP').Visible := (fCfgSis('MARMKP') = '99');
  fFindColumnByName(dbgItens, 'ITE_MARIDE').Visible := fCfgSis('MARIDE', varBoolean);
  fFindColumnByName(dbgItens, 'ITE_PREIDE').Visible := fCfgSis('MARIDE', varBoolean);
  fFindColumnByName(dbgItens, 'ITE_MCAT17').Visible := fCfgSis('MCAT17', varBoolean);

  If Not Assigned(fatVenda) Then
  Begin
    fltTotalG := 0;

    pnlFrete.Visible := False;

    fFindColumnByName(dbgItens, 'ITE_DESITE').Width := fFindColumnByName(dbgItens, 'ITE_DESITE').Width +
                                                       fFindColumnByName(dbgItens, 'ITE_PREMED').Width +
                                                       fFindColumnByName(dbgItens, 'ITE_MARMED').Width;

    fFindColumnByName(dbgItens, 'ITE_PREMED').Visible := False;
    fFindColumnByName(dbgItens, 'ITE_MARMED').Visible := False;
    fFindColumnByName(dbgItens, 'ITE_CUSIMP').Visible := False;
    fFindColumnByName(dbgItens, 'ITE_MARIMP').Visible := False;
    fFindColumnByName(dbgItens, 'ITE_MARKUP').Visible := False;
    fFindColumnByName(dbgItens, 'ITE_MCAT17').Visible := False;
    fFindColumnByName(dbgItens, 'ITE_PERDES').Visible := False;
    fFindColumnByName(dbgItens, 'ITE_RESULT').Visible := False;

    cdsItens.FieldByName('ITE_PREMED').Visible := False;
    cdsItens.FieldByName('ITE_MARMED').Visible := False;
    cdsItens.FieldByName('ITE_CUSIMP').Visible := False;
    cdsItens.FieldByName('ITE_MARIMP').Visible := False;
    cdsItens.FieldByName('ITE_MCAT17').Visible := False;
    cdsItens.FieldByName('ITE_PERDES').Visible := False;
    cdsItens.FieldByName('ITE_RESULT').Visible := False;

    dbgItens.ReadOnly := True;
  End;

  pnlDeseja.Visible := Assigned(fatVenda) And (Not blnApenasVerificandoMargemComFrete) And (Not fRealizandoConfirmacao);
  pnlDesconto.Visible := Assigned(fatVenda) And (Not blnApenasVerificandoMargemComFrete) And ((Not fRealizandoConfirmacao) Or (fEhConfirmacaoDeDocumentosEPermiteEditarUnitario));
  pnlMargemSobreItens.Visible := (Not fRealizandoConfirmacao) Or (fEhConfirmacaoDeDocumentosEPermiteEditarUnitario);

  If Pos(VS_strTRADES, '3_') <= 0 Then
  Begin
    fFindColumnByName(dbgItens, 'ITE_DESITE').Width := fFindColumnByName(dbgItens, 'ITE_DESITE').Width +
                                                       fFindColumnByName(dbgItens, 'ITE_MARMIN').Width;
    fFindColumnByName(dbgItens, 'ITE_MARMIN').Visible := False;
  End;

  If (blnApenasVerificandoMargemComFrete) Or ((fRealizandoConfirmacao) And (Not fEhConfirmacaoDeDocumentosEPermiteEditarUnitario)) Then
    dbgItens.ReadOnly := True;

  If Not blnApenasVerificandoMargemComFrete Then
  Begin
    lblFreSuges.Visible := False;
    edtFreSuges.Visible := False;
    chkAcuFreteCobPrecoUni.Visible := False;
    chkAcuFreteSugPrecoCus.Visible := False;
    pnlFrete.Height := pnlFrete.Height - edtFreSuges.Height;
  End;

  dtsItens.DataSet    := cdsItens;
  dbgItens.DataSource := dtsItens;
  dbeDesIte.DataSource := dtsItens;

  dtsTotais.DataSet := cdsTotais;
  dbgTotais.DataSource := dtsTotais;

  pnlCustosMargemTintas.Visible := fTemTinta;
  pnlTravasMinimas.Visible := Assigned(fatVenda) And TMostraTravaMinimaHelper.fExibeTravaMinima;
  pnlVenCli.Visible := Assigned(fatVenda);

  If fAplicarTaxaJurosPrecoDigitado Then
  Begin
    pnlDeseja.Visible := False;
    pnlDesconto.Visible := False;
    pnlMargemSobreItens.Visible := False;
  End;

  pAjustaColunasTotal;

  {Se resolução disponível for inferior à (1024 x 768), maximiza tela!}
  If (Screen.Width < 1024) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.WindowState := wsMaximized;

end;

procedure TfrmFatMostraMargem.chkAcuFreteCobPrecoUniClick(Sender: TObject);
begin
  inherited;
  If Assigned(pCalculaMargemLucro) Then
  Begin
    pCalculaMargemLucro(chkAcuFreteSugPrecoCus.Checked, chkAcuFreteCobPrecoUni.Checked);
    pCalculaTotais;
    pFormataCamposGrid;
  End;
end;

procedure TfrmFatMostraMargem.chkUltVenClick(Sender: TObject);
begin
  inherited;
  pAfterScroll(cdsItens);
  pSetFocus(dbgItens);
end;

procedure TfrmFatMostraMargem.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  Var
    intPosScroll1, intPosScroll2 : Integer;
begin
  inherited;

  If SameText(cdsItens.FieldByName('ITE_PROMOC').AsString, 'S') Then
  Begin
    If gdFocused In State Then
      dbgItens.Canvas.Font.Color := clYellow
    Else
      dbgItens.Canvas.Font.Color := clGreen;

    dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

  intPosScroll1 := GetScrollPos(dbgItens.Handle, SB_HORZ);
  intPosScroll2 := GetScrollPos(dbgTotais.Handle, SB_HORZ);

  If (intPosScroll1 <> intPosScroll2) Then
    dbgTotais.Perform(WM_HSCROLL, MakeLong(SB_THUMBPOSITION, intPosScroll1), 0);
end;

procedure TfrmFatMostraMargem.pBeforeEdit(DataSet: TDataSet);
begin
  cdsDados.Data := cdsItens.Data;
  fltUnitarAnt := DataSet.FieldByName('ITE_UNITAR').AsFloat;
  fltPreCusAnt := DataSet.FieldByName('ITE_PRECUS').AsFloat;
  fltMarLucAnt := DataSet.FieldByName('ITE_MARLUC').AsFloat;
end;

function TfrmFatMostraMargem.fPegaTotalParaDesconto(blnAplicarRestricoes: Boolean; cdsDestin: TUniClientDataSet): Double;
  Var
    blnItemEntraRateio : Boolean;
    cdsClone : TUniClientDataSet;
begin
  Result := 0;

  cdsClone := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsClone, cdsDestin);

  With cdsClone Do
  Begin
    First;
    While Not Eof Do
    Begin
      If (Not blnAplicarRestricoes) Then
        blnItemEntraRateio := True
      Else
        blnItemEntraRateio := fItemEntraRateio(FieldByName('ITE_PROMOC').AsString, cdsClone);

      If (blnItemEntraRateio) Then
      Begin
        Result := Result + fFormataFloat(FieldByName('ITE_UNITAR').AsFloat * FieldByName('ITE_QTDITE').AsFloat, 2);
      End;
      Next;
    End;
  End;

  FreeAndNil(cdsClone);
end;

function TfrmFatMostraMargem.fRealizandoConfirmacao: Boolean;
begin
  Result := False;
  If Assigned(fatVenda) Then
    Result := (Pos(fatVenda.strOpcDoc,'CF_CI_CT_CP_OV_') > 0);
end;

function TfrmFatMostraMargem.fEhConfirmacaoDeDocumentosEPermiteEditarUnitario: Boolean;
begin
  Result := False;
  If Assigned(fatVenda) Then
    Result := (fatVenda.strOpcDoc = 'CF') And (fCfgSis('DESCFF', varBoolean)) And (fCfgSis('EDUNF4', varBoolean));
end;

function TfrmFatMostraMargem.fTemTinta: Boolean;
var
  strBookMark: TBookmark;
begin
  Result := False;

  If not Assigned(cdsVenda) Then Exit;
  If not Assigned(fGTinForGeral) Then Exit;

  Try
    Try
      cdsVenda.DisableConstraints;
      cdsVenda.DisableControls;
      strBookMark := cdsVenda.Bookmark;
      cdsVenda.First;
      while not cdsVenda.Eof do
      begin
        if Assigned(fGetITintadeMaquina(TDadosFechamentoDadosTinta.Create(cdsVenda),
          TFatVendasCalculadorWrapper.Create(fatVenda))) then
        begin
          Result := True;
          Exit;
        end;
        cdsVenda.Next;
      end;
    Except
      on E: Exception do
      begin
        Result := False;
      end;
    End;
  Finally
    cdsVenda.Bookmark := strBookMark;
    cdsVenda.EnableConstraints;
    cdsVenda.EnableControls;
  End;
end;

function TfrmFatMostraMargem.fTotalDouble(strNomeCampo: String): Double;
  Var
    intRecNo : Integer;
begin
  intRecNo := cdsTotais.RecNo;
  Try
    If (cdsTotais.FindField(strNomeCampo) <> Nil) And (cdsTotais.Locate('ITE_DESITE', STR_TEXTO_TOTAL_S_DESC, [])) Then
      Result := cdsTotais.FieldByName(strNomeCampo).AsFloat
    Else
      Result := 0;
  Finally
    cdsTotais.RecNo := intRecNo;
  End;
end;

function TfrmFatMostraMargem.fUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  If (MethodName = AnsiUpperCase('fTotalDouble')) Then
  Begin
    Result := fTotalDouble(Params[0]);
  End;
end;

Function TfrmFatMostraMargem.fValidaUnitario(DataSet: TDataSet; fltUnitar: Double): Boolean;
  Var
    fltDesMGe: Double;
    fltDesMSu: Double;
    fltQtdJaDig: Double;
    fltQtdJaEmPromoc: Double;
    strOldOpcDoc : String;

  procedure pCalculaQtdJaDigitada;
  begin
    fltQtdJaDig := 0;
    fltQtdJaEmPromoc := 0;

    With cdsVenda, fatVenda Do
    Begin
      pArmazenarItemNaListaDeItemForaPromo(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_EMPITE').AsString);

      If (fItemPassivelDeVerificacaoPromo(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_EMPITE').AsString)) Then
      Begin
        fltQtdJaDig := fRetQtdDigitada(FieldByName('ITE_CODITE').AsString,
                                       FieldByName('ITE_NUMLOT').AsString,
                                       FieldByName('AUTOINCREM').AsString,
                                       FieldByName('ITE_CODACA').AsString,
                                       FieldByName('ITE_EMPACA').AsString,
                                       FieldByName('ITE_EMPITE').AsString,
                                       False);

        fltQtdJaEmPromoc := fRetQtdDigitada(FieldByName('ITE_CODITE').AsString,
                                            FieldByName('ITE_NUMLOT').AsString,
                                            FieldByName('AUTOINCREM').AsString,
                                            FieldByName('ITE_CODACA').AsString,
                                            FieldByName('ITE_EMPACA').AsString,
                                            FieldByName('ITE_EMPITE').AsString,
                                            False,
                                            False,
                                            fDesconsiderarNaQtdLimDaPromoItensUnitarMaior,
                                            True {Somente em promocao});
      End;
    End;
  end;

Begin
  pPosicionarRegistroVenda(DataSet);
  pCalculaQtdJaDigitada;

  If Not fCfgSis('ITETBP', VarBoolean) Then
  Begin
    fltDesMSu := DataSet.FieldByName('ITE_DESMSU').AsFloat;
    fltDesMGe := DataSet.FieldByName('ITE_DESMGE').AsFloat;
  End
  Else
  Begin
    fltDesMSu := fatVenda.fGetDesMaxTabPre(DataSet.FieldByName('ITE_CODITE').AsString,
                                           VS_strCodEmp,
                                           IIF(fEmptyStr(DataSet.FieldByName('ITE_TABPRE').AsString),
                                                         fatVenda.strTabPre,
                                                         DataSet.FieldByName('ITE_TABPRE').AsString),
                                           'ITE_DESMSU');

    fltDesMGe := fatVenda.fGetDesMaxTabPre(DataSet.FieldByName('ITE_CODITE').AsString,
                                           VS_strCodEmp,
                                           IIF(fEmptyStr(DataSet.FieldByName('ITE_TABPRE').AsString),
                                                         fatVenda.strTabPre,
                                                         DataSet.FieldByName('ITE_TABPRE').AsString),
                                           'ITE_DESMGE');
  End;

  strOldOpcDoc := fatVenda.strOpcDoc;
  Try
    If (fEhConfirmacaoDeDocumentosEPermiteEditarUnitario) Then
      fatVenda.strOpcDoc := 'VN';

    With DataSet Do
    Begin
      Result := fatVenda.fValidaUnitario(fltUnitar,
                                       fltTotalG,
                                       strCcnAnt,
                                       FieldByName('ITE_QTDITE').AsFloat,
                                       fltQtdJaDig, fltQtdJaEmPromoc,
                                       FieldByName('ITE_UNIORI').AsFloat,
                                       fltDesMGe,
                                       FieldByName('ITE_PREEMB').AsFloat,
                                       FieldByName('ITE_UNIDEV').AsFloat,
                                       FieldByName('ITE_EMBALA').AsFloat,
                                       0,
                                       FieldByName('ITE_PRCTIN').AsFloat,
                                       FieldByName('ITE_PRVTIN').AsFloat,
                                       FieldByName('ITE_CUSITE').AsFloat,
                                       FieldByName('ITE_QTDEMB').AsInteger,
                                       FieldByName('ITE_TOTITE').AsFloat,
                                       cdsVenda.FieldByName('ITE_EMPITE').AsString,//Empresa do item esta somente no cdsVenda
                                       IIF(blnTabPreIte, FieldByName('ITE_TABPRE').AsString, fatVenda.strTabPre),
                                       FieldByName('ITE_CODITE').AsString,
                                       FieldByName('ITE_DESITE').AsString,
                                       FieldByName('ITE_IDEPRO').AsString,
                                       FieldByName('ITE_TIPPRE').AsString,
                                       FieldByName('ITE_ITETIN').AsString,
                                       FieldByName('ITE_CATALI').AsString,
                                       FieldByName('ITE_PROMOC').AsString,
                                       FieldByName('ITE_ENTSAI').AsString,
                                       FieldByName('ITE_BRINDE').AsString,
                                       True,
                                       cdsDados,
                                       fatVenda.qryConCit,
                                       qryTinta,
                                       cdsDados,
                                       FieldByName('ITE_PRELOT').AsFloat,
                                       FieldByName('ITE_SIGUNI').AsString,
                                       FieldByName('ITE_PREMED').AsFloat,
                                       FieldByName('ITE_IMPULT').AsFloat,
                                       True,
                                       False,
                                       False,
                                       fltDesMSu,
                                       FieldByName('ITE_BAREMB').AsString,
                                       stlIteLib,
                                       FieldByName('ITE_PROACA').AsInteger = 1);
    End;
  Finally
    fatVenda.strOpcDoc := strOldOpcDoc;
  End;
End;

procedure TfrmFatMostraMargem.ImprimirF4Click(Sender: TObject);
  Var
    stlFunctions : TStringList;
begin
  inherited;

  stlFunctions := TStringList.Create;

  Try
    stlFunctions.Add('function fTotalDouble(strNomeCampo: String): Double;');
    pGerarDicionarioColunas;

    pImprimirF4(cdsItens, dicColunasF4, fUserFunction, False, stlFunctions);
  Finally
    FreeAndNil(stlFunctions);
  End;
end;

procedure TfrmFatMostraMargem.pBeforePost(DataSet: TDataSet);
  Var
    fltUnitar: Double;
    calcCustoReal: TCalcCustoReal;
    fltIcmCal : Double;
    fltImcSTPV : Double;
    blnCalcST : Boolean;
    strCodSit : String;
    strCodAbf : String;

   Procedure pPosicionaItem;
   Begin
     With DataSet Do
     Begin
       //Precisamos posicionar a temporaria da venda para atualizar as variaveis utilizadas na trava de Preco
       pPosicionarRegistroVenda(DataSet);

       //Variavies utilizadas na trava de preco
       fatVenda.strIdePro := cdsVenda.FieldByName('ITE_IDEPRO').AsString;
       fatVenda.fltCusIte := cdsVenda.FieldByName('ITE_CUSITE').AsFloat;
       fatVenda.fltPreCus := cdsVenda.FieldByName('ITE_PRECUS').AsFloat;
       fatVenda.fltIcmSai := cdsVenda.FieldByName('ITE_ICMSAI').AsFloat;
       fatVenda.fltImpFed := cdsVenda.FieldByName('ITE_IMPFED').AsFloat;
       fatVenda.fltOutVal := cdsVenda.FieldByName('ITE_OUTVAL').AsFloat;
       fatVenda.fltDesOpe := cdsVenda.FieldByName('ITE_DESOPE').AsFloat;
       fatVenda.fltPreCu2 := cdsVenda.FieldByName('ITE_PRECU2').AsFloat;
       fatVenda.fltPreVe1 := cdsVenda.FieldByName('ITE_PREVE1').AsFloat;
       fatVenda.fltPreVe2 := cdsVenda.FieldByName('ITE_PREVE2').AsFloat;
       fatVenda.fltPreVe3 := cdsVenda.FieldByName('ITE_PREVE3').AsFloat;
       fatVenda.fltPreVe4 := cdsVenda.FieldByName('ITE_PREVE4').AsFloat;
       fatVenda.fltPreVe5 := cdsVenda.FieldByName('ITE_PREVE5').AsFloat;
       fatVenda.fltPreVe6 := cdsVenda.FieldByName('ITE_PREVE6').AsFloat;
       fatVenda.fltPreVe7 := cdsVenda.FieldByName('ITE_PREVE7').AsFloat;

       pPesquisaCadSem(fatVenda.qryConCit, fatVenda.qryConCit, FieldByName('ITE_CODITE').AsString, '',
                       False{blnBuscaCodBar}, False);

       {Os itens sao carregados na inicializacao deste tela, caso nao encontre o item nao deve prosseguir }
       If Not fatVenda.qryConIte.Locate('ITE_CODITE', FieldByName('ITE_CODITE').AsString, []) Then
         Raise Exception.Create('Não foi encontrado o produto ' + FieldByName('ITE_CODITE').AsString + '!');
     End;
   End;

   function fValidaMargem: Double;
   Begin
     Result := (cdsItens.FieldByName('ITE_IMPFED').AsFloat +
                cdsItens.FieldByName('ITE_ICMSAI').AsFloat +
                cdsItens.FieldByName('ITE_DESOPE').AsFloat + fatVenda.fltDesOpeCli +
                cdsItens.FieldByName('ITE_MARLUC').AsFloat +
                cdsItens.FieldByName('ITE_COMTBL').AsFloat);
   End;

   Function fValorSuperiorAoUnitarioMaximo : Boolean;
     Var
       fltVlrFtr,
       fltFator : Double;
   Begin
    Result   := True;
    fltFator := fCfgSis('FTPRVE', varDouble);
    If (fltFator > 0) Then
    Begin
      fltVlrFtr := DataSet.FieldByName('ITE_UNIORI').AsFloat * fltFator;
      If (fltUnitar > fltVlrFtr) Then
        Result := False;
    End;
  End;

  function fUnitarioMinimo: Double;
  begin
    With DataSet Do
    Begin
      Result := fatVenda.fUnitarioMinimo(FieldByName('ITE_CODITE').AsString,
                                         IIF(blnTabPreIte, FieldByName('ITE_TABPRE').AsString, fatVenda.strTabPre),
                                         FieldByName('ITE_QTDITE').AsFloat,
                                         FieldByName('ITE_UNIORI').AsFloat);
    End;
  end;

  function fUFBuscaAbreviacao: String;
  begin
    If fatVenda.fDentroDoEstado Then
      Result := fRetUFEmpresa
    Else
      Result := fatVenda.fTrocaUFEndEntrega;
  end;

begin
  Try

    With DataSet Do
    Begin
      If fEmptyStr(FieldByName('ITE_CODITE').AsString) Then
        Exit;

      {Desconto por item}
      If SameText(dbgItens.SelectedField.FieldName, 'ITE_PERDES') Then
      begin

        if (FieldByName('ITE_PERDES').AsFloat > 0) then
          FieldByName('ITE_UNITAR').AsFloat := FieldByName('ITE_UNIORI').AsFloat - ((FieldByName('ITE_UNIORI').AsFloat * FieldByName('ITE_PERDES').AsFloat) / 100)
        else
        if (FieldByName('ITE_PERDES').AsFloat = 0) then
          FieldByName('ITE_UNITAR').AsFloat := FieldByName('ITE_UNIORI').AsFloat;

      end;

      If SameText(dbgItens.SelectedField.FieldName, 'ITE_UNITAR') or SameText(dbgItens.SelectedField.FieldName, 'ITE_PERDES') Then
      Begin

        If (fltUnitarAnt <> FieldByName('ITE_UNITAR').AsFloat) Then
        Begin
          fltUnitar := FieldByName('ITE_UNITAR').AsFloat;

          If fltUnitar <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Valor Unitário deve ser maior que Zero!', ['&O k']);
            Cancel;
            Abort;
          End
          Else If (fatVenda.strOpcDoc = 'DV') And (FieldByName('ITE_UNIDEV').AsFloat > 0.0) Then
          Begin

            If fFormataFloat(fltUnitar, intDecUni) > fFormataFloat(FieldByName('ITE_UNIDEV').AsFloat, intDecUni) Then
            Begin
              fMensagem('ATENÇÃO!', 'O Unitário deve ser menor ou igual a ' + FloatToStr(FieldByName('ITE_UNIDEV').AsFloat) + '!', ['&O k']);
              Cancel;
              Abort;
            End;

          End;

          If (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_') > 0) And
             (Not fValorSuperiorAoUnitarioMaximo) Then
          Begin
            fMensagem('ATENÇÃO!','O valor digitado está superior ao valor de teto máximo permitido.' + #13 +
                                 'Esta operação não será permitida! Para ajustar esta configuração,' + #13 +
                                 'procure nas configurações do sistema o código CFG_FTPRVE',['&OK']);
            Cancel;
            Abort;
          End;

          If (blnSomenteUnitarioAcimaDoSugerido) Then
          Begin
            If fFormataFloat(fltUnitar, intDecUni) < fFormataFloat(fUnitarioMinimo, intDecUni) Then
            Begin
              fMensagem('ATENÇÃO!', 'O Unitário deve ser maior ou igual a ' + FloatToStr(fFormataFloat(fUnitarioMinimo, intDecUni)) + '!', ['&OK']);
              Cancel;
              Abort;
            End;
          End;

          pPosicionaItem;

          If Not fValidaUnitario(DataSet, fltUnitar) Then
          Begin
            Cancel;
            Abort;
          End;

          FieldByName('ITE_TOTITE').AsFloat := fatVenda.fCalculaTotalItem(FieldByName('ITE_IDEPRO').AsString,
                                                                      FieldByName('ITE_UNITAR').AsFloat,
                                                                      FieldByName('ITE_QTDITE').AsFloat,
                                                                      FieldByName('ITE_PREEMB').AsFloat,
                                                                      FieldByName('ITE_QTDEMB').AsFloat);


          calcCustoReal := TCalcCustoReal.Create;
          calcCustoReal.fltUnitar := FieldByName('ITE_UNITAR').AsFloat;
          calcCustoReal.fltPreCus := FieldByName('ITE_CUSITE').AsFloat;
          calcCustoReal.fltOutVal := FieldByName('ITE_OUTVAL').AsFloat;
          calcCustoReal.fltIcmSai := IIF(fCfgSis('IMPCF4', varBoolean) And (FieldByName('ITE_IDEPRO').AsString = 'NOR'),
                                     fatVenda.fCalculaAliquota(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_IMPDIR').AsString),
                                     FieldByName('ITE_ICMSAI').AsFloat);

          If (fCfgSis('MARMKP') = '4') And (fatVenda.fDentroDoEstado) And
             (Assigned(DataSet.FindField('ITE_ICMCAL'))) And (fCfgSis('IMPCF4', varBoolean)) Then
            calcCustoReal.fltIcmSai := DataSet.FieldByName('ITE_ICMCAL').AsFloat;

          calcCustoReal.fltImpFed := FieldByName('ITE_IMPFED').AsFloat;
          calcCustoReal.fltDesOpe := FieldByName('ITE_DESOPE').AsFloat + fatVenda.fltDesOpeCli;

          If (Assigned(findField('ITE_CALCST'))) Then
          Begin
            calcCustoReal.blnCalcST := FieldByName('ITE_CALCST').AsBoolean;
            calcCustoReal.fltIcmPav := FieldByName('ITE_ICMPAV').AsFloat;
          End;

          If (FieldByName('ITE_VAL_ST').AsFloat = 0) Then
          Begin
            strCodSit := '';
            strCodAbf := fGetCodAbf(FieldByName('ITE_CODITE').AsString, VS_strCodEmp);
            If (Not fEmptyStr(fatVenda.strTpAbre)) And (fatVenda.fBuscaAbfIcm(FieldByName('ITE_CODITE').AsString, strCodAbf, fatVenda.fTrocaUFEndEntrega)) Then
              strCodSit := fatVenda.cdsAbfIcm.FieldByName('ABF_CODSIT' + fatVenda.strTpAbre).AsString;

            calcCustoReal.fltDifal := fatVenda.fGetValorDifalIcms(FieldByName('ITE_CODITE').AsString,
                                                                  strCodAbf,
                                                                  strCodSit,
                                                                  calcCustoReal.fltIcmSai,
                                                                  calcCustoReal.fltUnitar);

            calcCustoReal.fltFcp   := fatVenda.fGetValorFcpIcms(FieldByName('ITE_CODITE').AsString,
                                                                strCodAbf,
                                                                strCodSit,
                                                                calcCustoReal.fltIcmSai,
                                                                calcCustoReal.fltUnitar);
          End;

          FieldByName('ITE_PRECUS').AsFloat :=
             fatVenda.fRetornaPrecoCusto(Preco_de_Custo_Real,
                                         FieldByName('ITE_CODITE').AsString,
                                         FieldByName('ITE_CUSITE').AsFloat,
                                         '',
                                         calcCustoReal,
                                        (Pos('ITEM ESPECIAL', FieldByName('ITE_DESITE').AsString) > 0));

          FreeAndNil(calcCustoReal);

          pPosicionarRegistroVenda(DataSet);

          fatVenda.pCalculaMargemDataSet(fatVenda, cdsItens, cdsVenda,
                                         fCfgSis('IMPCF4'), fCfgSis('MARPRA'),
                                         fCfgSis('MARMKP'), False, False, False, 0, False);

        End {If (fltUnitarAnt <> FieldByName('UNITAR').AsFloat) And...}

        Else Exit;

      End {If SameText(dbgItens.SelectedField.FieldName, 'UNITAR') Then}

      Else If SameText(dbgItens.SelectedField.FieldName, 'ITE_PRECUS') Then
      Begin

        If (fltPreCusAnt <> FieldByName('ITE_PRECUS').AsFloat) Then
        Begin
          If FieldByName('ITE_PRECUS').AsFloat <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Preço de Custo deve ser maior que Zero!', ['&O k']);
            Cancel;
            Abort;
          End;

          pPosicionaItem;

          pPosicionarRegistroVenda(DataSet);

          fatVenda.pCalculaMargemDataSet(fatVenda, cdsItens, cdsVenda,
                                         fCfgSis('IMPCF4'), fCfgSis('MARPRA'),
                                         fCfgSis('MARMKP'), False, False, False, 0, False);

        End

        Else Exit;

      End

      Else If SameText(dbgItens.SelectedField.FieldName, 'ITE_MARLUC') Then
      Begin

        If (fltMarLucAnt <> FieldByName('ITE_MARLUC').AsFloat) Then
        Begin

          If Pos(fCfgSis('MARMKP'), '1_5_') > 0 Then
          Begin
            If (FieldByName('ITE_MARLUC').AsFloat >= 100) Then
            Begin
              fMensagem('ATENÇÃO!', 'Margem não permitida: maior ou igual a 100!', ['&Ok']);
              Cancel;
              Abort;
            End
            Else If fValidaMargem >= 100 Then
            Begin
              fMensagem('ATENÇÃO', 'A soma do ( ICMS Saída + Impostos Federais + Despesas Operacionais + Margem Bruta ' + IIF(fCfgSis('PCMPRO') = '2', '+ Comissão ', '') + ' ) não pode ser maior ou igual 100%.', ['&Ok']);
              Cancel;
              Abort;
            End;
          End;

          pPosicionaItem;

          if fCfgSis('IMPCF4', varBoolean) and (FieldByName('ITE_IDEPRO').AsString = 'NOR') then
            fltIcmCal := fatVenda.fCalculaAliquota(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_IMPDIR').AsString)
          else
            fltIcmCal := cdsItens.FieldByName('ITE_ICMSAI').AsFloat;

          strCodSit := '';
          strCodAbf := fGetCodAbf(FieldByName('ITE_CODITE').AsString);
          If (Not fEmptyStr(fatVenda.strTpAbre)) And (fatVenda.fBuscaAbfIcm(FieldByName('ITE_CODITE').AsString,
                                                                            strCodAbf,
                                                                            fUFBuscaAbreviacao)) Then

            strCodSit := fatVenda.cdsAbfIcm.FieldByName('ABF_CODSIT' + fatVenda.strTpAbre).AsString;

          If (fCfgSis('MARMKP') = '4') And (fatVenda.fDentroDoEstado) And
             (Assigned(DataSet.FindField('ITE_ICMCAL'))) And (fCfgSis('IMPCF4', varBoolean)) Then
            fltIcmCal := DataSet.FieldByName('ITE_ICMCAL').AsFloat;

          fatVenda.objIcStPv.pAdd(FieldByName('ITE_CODITE').AsString,
                                  VS_strCodEmp,
                                  fatVenda.strTpAbre,
                                  fatVenda.fUFDestTrib,
                                  strCodSit,
                                  fltImcSTPV,
                                  blnCalcST);

          fltUnitar := fCalculaPrecoVenda(1,
                         cdsItens.FieldByName('ITE_CUSITE').AsFloat + cdsItens.FieldByName('ITE_OUTVAL').AsFloat,
                         0,
                         cdsItens.FieldByName('ITE_MARLUC').AsFloat,
                         fltIcmCal + fatVenda.fGetAlqDifIcms(FieldByName('ITE_CODITE').AsString, strCodAbf, strCodSit, fltIcmCal),
                         cdsItens.FieldByName('ITE_IMPFED').AsFloat,
                         cdsItens.FieldByName('ITE_DESOPE').AsFloat + fatVenda.fltDesOpeCli,
                         cdsItens.FieldByName('ITE_COMTBL').AsFloat,
                         '',
                         '',
                         -1,
                         fltImcSTPV,
                         blnCalcST);

          If Not fValidaUnitario(DataSet, fltUnitar) Then
          Begin
            Cancel;
            Abort;
          End;

          FieldByName('ITE_UNITAR').AsFloat := fltUnitar;

          calcCustoReal := TCalcCustoReal.Create;
          calcCustoReal.fltUnitar := FieldByName('ITE_UNITAR').AsFloat;
          calcCustoReal.fltPreCus := FieldByName('ITE_CUSITE').AsFloat;
          calcCustoReal.fltOutVal := FieldByName('ITE_OUTVAL').AsFloat;
          calcCustoReal.fltIcmPav := fltImcSTPV;
          calcCustoReal.blnCalcST := blnCalcST;
          calcCustoReal.fltIcmSai := IIF(fCfgSis('IMPCF4', varBoolean) And (FieldByName('ITE_IDEPRO').AsString = 'NOR'),
                                     fatVenda.fCalculaAliquota(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_IMPDIR').AsString),
                                     FieldByName('ITE_ICMSAI').AsFloat);

          If (fCfgSis('MARMKP') = '4') And (fatVenda.fDentroDoEstado) And
             (Assigned(DataSet.FindField('ITE_ICMCAL'))) And (fCfgSis('IMPCF4', varBoolean)) Then
            calcCustoReal.fltIcmSai := DataSet.FieldByName('ITE_ICMCAL').AsFloat;

          calcCustoReal.fltImpFed := FieldByName('ITE_IMPFED').AsFloat;
          calcCustoReal.fltDesOpe := FieldByName('ITE_DESOPE').AsFloat + fatVenda.fltDesOpeCli;

          If (FieldByName('ITE_VAL_ST').AsFloat = 0) Then
          Begin
            strCodSit := '';
            strCodAbf := fGetCodAbf(FieldByName('ITE_CODITE').AsString, VS_strCodEmp);
            If (Not fEmptyStr(fatVenda.strTpAbre)) And (fatVenda.fBuscaAbfIcm(FieldByName('ITE_CODITE').AsString, strCodAbf, fatVenda.fTrocaUFEndEntrega)) Then
              strCodSit := fatVenda.cdsAbfIcm.FieldByName('ABF_CODSIT' + fatVenda.strTpAbre).AsString;

            calcCustoReal.fltDifal := fatVenda.fGetValorDifalIcms(FieldByName('ITE_CODITE').AsString,
                                                                  strCodAbf,
                                                                  strCodSit,
                                                                  calcCustoReal.fltIcmSai,
                                                                  calcCustoReal.fltUnitar);

            calcCustoReal.fltFcp   := fatVenda.fGetValorFcpIcms(FieldByName('ITE_CODITE').AsString,
                                                                strCodAbf,
                                                                strCodSit,
                                                                calcCustoReal.fltIcmSai,
                                                                calcCustoReal.fltUnitar);
          End;

          FieldByName('ITE_PRECUS').AsFloat :=
             fatVenda.fRetornaPrecoCusto(Preco_de_Custo_Real,
                                         FieldByName('ITE_CODITE').AsString,
                                         FieldByName('ITE_CUSITE').AsFloat,
                                         '',
                                         calcCustoReal,
                                        (Pos('ITEM ESPECIAL', FieldByName('ITE_DESITE').AsString) > 0));

          FreeAndNil(calcCustoReal);

          pPosicionarRegistroVenda(DataSet);
          
          fatVenda.pCalculaMargemDataSet(fatVenda, cdsItens, cdsVenda,
                                         fCfgSis('IMPCF4'), fCfgSis('MARPRA'),
                                         fCfgSis('MARMKP'), False, False, False, 0, False);

          FieldByName('ITE_TOTITE').AsFloat := fatVenda.fCalculaTotalItem(FieldByName('ITE_IDEPRO').AsString,
                                                                      FieldByName('ITE_UNITAR').AsFloat,
                                                                      FieldByName('ITE_QTDITE').AsFloat,
                                                                      FieldByName('ITE_PREEMB').AsFloat,
                                                                      FieldByName('ITE_QTDEMB').AsFloat);

        End;

      End;

    End; {With DataSet Do}

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFatMostraMargem.pBeforePost]');
      Abort;
    End;

  End;

end;

procedure TfrmFatMostraMargem.pAfterPost(DataSet: TDataSet);
  Var
    intRecNo: Integer;
begin
  With DataSet Do
  If (Not blnCanculandoTotal) Then
  Begin

    fatVenda.pCalculaTotaisMargemLucro(cdsItens.Data,
                                       recTotMarLuc);

    If (fltDesEsp > 0) Then
      fatVenda.pCalculaTotaisMargemLucro(cdsItens.Data,
                                         recTotMarLucTotIte,
                                         fltDesEsp);

    fatVenda.pCalculaTotalMarkup(cdsItens.Data, fltTotMarkup);

    DisableControls;
    blnCanculandoTotal := True;
    intRecNo := DataSet.RecNo;
    pCalculaTotais;
    DataSet.RecNo := intRecNo;
    blnCanculandoTotal := False;
    EnableControls;


  End;
end;

procedure TfrmFatMostraMargem.pAfterScroll(DataSet: TDataSet);
  Var
    strCodIte: String;
begin
  blnSomenteUnitarioAcimaDoSugerido := False;

  If Not blnCanculandoTotal Then
  Begin
    With DataSet Do
    If fEmptyStr(FieldByName('ITE_CODITE').AsString) Then
      dbgItens.Options := dbgItens.Options - [dgEditing]
    Else
      dbgItens.Options := dbgItens.Options + [dgEditing];
  End;

  blnPermiteEditarPrecoUnitario := False;
  
  If Assigned(fatVenda) Then
    With fatVenda, DataSet Do
      blnPermiteEditarPrecoUnitario :=
        fPermiteEditarPrecoUnitario( strOpcDoc, strCodCnd, strCodCli,
                                     FieldByName('ITE_PROMOC').AsString,
                                     FieldByName('ITE_TABPRE').AsString, True,
                                     FieldByName('ITE_CODITE').AsString = fCfgSis('ITEVID'),
                                     fEhDevolucaoEspelhoOuParaFornecedor,
                                     blnSomenteUnitarioAcimaDoSugerido );

  If (fRealizandoConfirmacao) Then
    blnPermiteEditarPrecoUnitario := fEhConfirmacaoDeDocumentosEPermiteEditarUnitario;

  If fAplicarTaxaJurosPrecoDigitado Then
    blnPermiteEditarPrecoUnitario := False;

  fFindColumnByName(dbgItens, 'ITE_PERDES').ReadOnly := Not blnPermiteEditarPrecoUnitario;
  fFindColumnByName(dbgItens, 'ITE_UNITAR').ReadOnly := Not blnPermiteEditarPrecoUnitario;
  fFindColumnByName(dbgItens, 'ITE_MARLUC').ReadOnly := Not blnPermiteEditarPrecoUnitario;

  With DataSet Do
  Begin
    lblProVen.Visible := (FieldByName('ITE_PROMOC').AsString = 'S');
    edtProVen.Visible := (FieldByName('ITE_PROMOC').AsString = 'S');
    edtProVen.Text    := FloatToStrF(FieldByName('ITE_PROVEN').AsFloat, ffNumber, 12, 2);

    strCodIte := FieldByName('ITE_CODITE').AsString;

    lblUltVen.Visible := chkUltVen.Checked;
    edtUltVen.Visible := chkUltVen.Checked;

    If (chkUltVen.Checked) Then
    Begin
      If dicUltVen[strCodIte] = Null Then
      Begin
        pnlInfo.Caption := 'Aguarde...Consultando data da última venda!';
        application.ProcessMessages;

        If Not Assigned(fatVenda) Then
          dicUltVen[strCodIte] := fDataUltimaVendaProduto(strCodIte)
        Else
          dicUltVen[strCodIte] := fDataUltimaVendaProduto(strCodIte, fatVenda.strCodCli);

        pnlInfo.Caption := '';
        application.ProcessMessages;
      End;
    End;

    If dicUltVen[strCodIte] > 0 Then
      edtUltVen.Text := FormatDateTime('dd/MM/yyyy', dicUltVen[strCodIte])
    Else
      edtUltVen.Text := '';
  End;

  btnUltCompraEmp.Enabled := Not fEmptyStr(strCodIte);
end;

procedure TfrmFatMostraMargem.pAjustaColunasTotal;
  Var
    intCnt : Integer;
    //Column : TColumn;
begin
  dbgTotais.Columns := dbgItens.Columns;

  For intCnt := 0 To dbgTotais.Columns.Count-1 Do
  Begin
    dbgTotais.Columns[intCnt].Width := dbgItens.Columns[intCnt].Width;

//    Column := fFindColumnByName(dbgItens, dbgTotais.Columns[intCnt].FieldName);
//    dbgTotais.Columns[intCnt].Visible := (Assigned(Column)) And (Column.Visible);
//    If (dbgTotais.Columns[intCnt].Visible) Then
//    Begin
//      dbgTotais.Columns[intCnt].Width := Column.Width;
//      dbgTotais.Columns[intCnt].Index := Column.Index;
//    End;
  End;
end;

procedure TfrmFatMostraMargem.pAplicarDesconto(cdsComDes: TUniClientDataSet);
begin
  Try
    cdsComDes.DisableControls();
    cdsComDes.First;
    While Not cdsComDes.Eof Do
    Begin
      If (fItemEntraRateio(cdsComDes.FieldByName('ITE_PROMOC').AsString, cdsComDes)) And
         (cdsItens.Locate('AUTOINCREM', cdsComDes.FieldByName('AUTOINCREM').AsString, [])) Then
      Begin
        Try
          dbgItens.SelectedField := cdsItens.FieldByName('ITE_UNITAR');
          cdsItens.Edit;
          cdsItens.FieldByName('ITE_UNITAR').AsFloat := cdsComDes.FieldByName('ITE_UNITAR').AsFloat;
          cdsItens.Post;
        Except
          On E: EAbort Do
          Begin
            //Deve continuar o processamento dos produtos
          End;
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '');
          End;
        End;
      End;
      cdsComDes.Next;
    End;
  Finally
    cdsComDes.EnableControls();
  End;
end;

procedure TfrmFatMostraMargem.pAtualizaLiberacaoUnitario(
  stlAutInc: TStringList);
  Var
    prcScroll: TprcScroll;
    strIncIni : String;
    intCnt : Integer;
begin
  If Not Assigned(fatVenda) Then
    Exit;

  With fatVenda Do
  Begin
    Try
      strIncIni := cdsVenda.FieldByName('AUTOINCREM').AsString;
      pDisableControls(cdsVenda, prcScroll);

      For intCnt := 0 To stlAutInc.Count-1 Do
      Begin
        If cdsVenda.Locate('AUTOINCREM', stlAutInc[intCnt], []) Then
        Begin
          cdsVenda.Edit;
          cdsVenda.FieldByName('ITE_LIBUNI').AsString := 'S';
          cdsVenda.Post;
        End;
      End;

      cdsVenda.Locate('AUTOINCREM', strIncIni, []);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatMostraMargem.pAtualizaLiberacaoUnitario]');
    End;

    pEnableControls(cdsVenda, prcScroll);
  End;
end;

procedure TfrmFatMostraMargem.dbgItensKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  Case Key Of
    '-' : If Not (dbgItens.SelectedField.FieldName = 'ITE_MARLUC') Then
            Key := #0;
  End;

end;

procedure TfrmFatMostraMargem.dbgTotaisDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  dbgTotais.Canvas.Font.Color := clBlue;
  dbgTotais.Canvas.FillRect(Rect);
  dbgTotais.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

function TfrmFatMostraMargem.fItemEntraRateio(strPromoc: String; cdsDestin: TUniClientDataSet): Boolean;
begin
  If Assigned(fatVenda) Then
    Result := (blnPermiteEditarPrecoUnitario) And
              (fatVenda.fItemEntraRateio(cdsDestin)) And
              (IIF(fatVendas.fRegraPrecoSugestaoAtiva = TRegraPrecoSugestao.PrecoDePromocao, True, (strPromoc <> 'S')))
  Else
    Result := (blnPermiteEditarPrecoUnitario) And
              (IIF(fatVendas.fRegraPrecoSugestaoAtiva = TRegraPrecoSugestao.PrecoDePromocao, True, (strPromoc <> 'S')));
end;

procedure TfrmFatMostraMargem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: Begin
              btnConfirma.Click;
              Key := 0;
            End;

    VK_F2 : Begin
              btnMargemSobreItens.Click;
              Key := 0;
            End;

    VK_F3 : Begin
              btnDesconto.Click;
              Key := 0;
            End;


    VK_F4: begin
             btnCustosMargemTintas.Click;
             Key := 0;
           end;

    VK_F5: begin
             btnTravasMinimas.Click;
             Key := 0;
           end;

    VK_Escape: btnFechar.Click;

    VK_F8 : btnUltCompraEmp.Click;
    VK_F9 : btnVenCli.Click;
    VK_F6 : btnDeseja.Click;
  End;


end;

procedure TfrmFatMostraMargem.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgItens);
end;

procedure TfrmFatMostraMargem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  With cdsItens Do
  If State = dsEdit Then
  Begin
    Action := caNone;
    Post;
  End;

  If (Action <> caNone) Then
    FreeAndNil(dicUltVen);

  If (Action <> caNone) Then
  Begin
    If Assigned(stlIteLib) Then
      FreeAndNil(stlIteLib);
  End;

  If (Action <> caNone) And Assigned(fatVenda) Then
  Begin
    cdsVenda.EnableConstraints;
    cdsVenda.EnableControls;

    fatVenda.qryConIte.Close;
    fatVenda.qryConIte.SQL.Clear;

    fatVenda.qryConIte.SQL.Add(' SELECT * FROM ITEGER ');
    fatVenda.qryConIte.SQL.Add(' WHERE ITEGER.ITE_CODEMP = :CODEMP AND ');
    fatVenda.qryConIte.SQL.Add(' ITEGER.ITE_CODITE = :CODITE ');
  End;
end;

procedure TfrmFatMostraMargem.pPosicionarRegistroVenda(DataSet: TDataSet);
begin
  cdsVenda.Locate('AUTOINCREM', DataSet.FieldByName('AUTOINCREM').AsInteger, []);
  cdsDados.Locate('AUTOINCREM', DataSet.FieldByName('AUTOINCREM').AsInteger, []);
end;

end.


