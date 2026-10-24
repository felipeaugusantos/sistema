unit untFatExpSeparacaoItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxTextEdit,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Datasnap.DBClient,
  UniClientDataSet, MemDS, DBAccess, Uni, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid,untIteBar, untFatGor, untMovCdb, System.UITypes, cxImageList,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.Grids,
  cxButtons, Vcl.ImgList, System.ImageList;

type
  TcxViewInfoAcess = class(TcxGridTableDataCellViewInfo);
  TcxPainterAccess = class(TcxGridTableDataCellPainter);  

type
  TfrmFatExpSeparacaoItens = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    btnExpAut: TBitBtnLocked;
    btnLimpaExp: TBitBtnLocked;
    pnlRodape: TPanel;
    lblCodBar: TLabel;
    lblQtde: TLabel;
    shpSemSal: TShape;
    lblSemSal: TLabel;
    edtCodIte: TEditFocus;
    edtQtdIte: TEditFocus;
    dtsItens: TDataSource;
    qryItens: TUniQuery;
    cdsItens: TUniClientDataSet;
    grdItensLevel: TcxGridLevel;
    grdItensView: TcxGridDBTableViewCitel;
    grdItens: TcxGridCitel;
    grdItensCODITE: TcxGridDBColumn;
    grdItensDESITE: TcxGridDBColumn;
    grdItensUNIDAD: TcxGridDBColumn;
    grdItensQTDITE: TcxGridDBColumn;
    grdItensQTDSEP: TcxGridDBColumn;
    grdItensSALEST: TcxGridDBColumn;
    cdsItensCODITE: TStringField;
    cdsItensDESITE: TStringField;
    cdsItensUNIDAD: TStringField;
    cdsItensQTDITE: TFloatField;
    cdsItensQTDSEP: TFloatField;
    cdsItensAUTOINCREM: TStringField;
    cdsItensENTFUT: TStringField;
    cdsItensENTRET: TStringField;
    cdsItensSALDOS: TFloatField;
    cdsItensSALEST: TFloatField;
    cdsItensCODACA: TStringField;
    cdsItensEMPACA: TStringField;
    cdsItensIDEPRO: TStringField;
    cdsItensOPRFLJ: TStringField;
    cdsItensENT_CD: TStringField;
    cdsItensEMPPRD: TStringField;
    cdsItensMODDIL: TStringField;
    cdsItensTEXBAS: TStringField;
    cdsItensTIPCOR: TStringField;
    cdsItensCATALI: TStringField;
    cdsItensTIPBUS: TStringField;
    cdsItensBAREMB: TMemoField;
    cdsItensCODBAR: TStringField;
    cdsItensCODBAT: TStringField;
    btnQuantidade: TBitBtnLocked;
    grdItensDESLOC: TcxGridDBColumn;
    cdsItensDESLOC: TStringField;
    grdItensQTDLDO: TcxGridDBColumn;
    cdsItensQTDLDO: TFloatField;
    grdItensNUMLOT: TcxGridDBColumn;
    cdsItensNUMLOT: TStringField;
    grdItensAUTINC: TcxGridDBColumn;
    grdItensIMGICO: TcxGridDBColumn;
    imgIndica: TcxImageList;
    grdItensQTDREP: TcxGridDBColumn;
    cdsItensQTDREP: TIntegerField;
    pnlPedWms: TPanel;
    btnExp: TcxButton;
    btnAle: TcxButton;
    cdsItensSEPORI: TFloatField;
    cdsItensQTDBAI: TFloatField;
    grdItensDESMAR: TcxGridDBColumn;
    grdItensQTDPEN: TcxGridDBColumn;
    cdsItensDESMAR: TStringField;
    cdsItensQTDPEN: TFloatField;
    cdsItensEMP_CD: TStringField;
    procedure grdItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnLimpaExpClick(Sender: TObject);
    procedure btnExpAutClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure btnQuantidadeClick(Sender: TObject);
    procedure grdItensViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnAleClick(Sender: TObject);
    procedure btnExpClick(Sender: TObject);
  private
    { Private declarations }
    strCamBus   : String;
    strCodIteFor: String;
    strCodIte   : String;
    strCodDig   : String;
    strBarBal   : String;
    intDecQtd   : Integer;
    bln2CodBar  : Boolean;
    blnAutSer   : Boolean;
    objIteBar   : TIteBar;
    VS_strTipExpInterna: String;
    objCodBar   : TCodigoBarras;
    strAutInc   : String;

    procedure pInicializarGrid;
    procedure pExpedeItem(blnExpAut: Boolean = False);
    procedure pOnFilter(DataSet: TDataSet; var Accept: Boolean);
    function fEncontraItem(Var strMensagem: String; blnAtualizaQtde: Boolean = True): Boolean;
    function fProcuraSemelhante(strCodBar: String; Var strCodSem: String): Boolean;
    function fExcedeLimiteItensNFe: Boolean;
    function fTodosSeparados: Boolean;
    function fGetSQLPedido: String;
    function fGetSQLDocVen: String;
    function fPedidoWms: Boolean;
    procedure pRepassaQuantidadeSeparadaParaTodosOsItemsComMesmoAutoIncrem;
    function fSepararSomenteAteQuantidadeImpressaNaSeparacaoWMS: Boolean;
    function fQtdIteDisponivelParaSeparacao(blnSomaQuantidadeSeparadaAnteriormente: Boolean=False): Double;
    function fValidarQuantidade(): Boolean;
  public
    { Public declarations }
    strNumDoc: String;
    strEspDoc: String;
    strCodCli: String;
    strCodLse: String;
    strCodEmp: String;
    blnConfir: Boolean;
    blnSepPorArmazem: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFatExpSeparacaoItens: TfrmFatExpSeparacaoItens;

implementation

{$R *.dfm}

uses untModulo, untFuncoesSimples, untConstantes, untTypesSistema,
  untFuncFatTypes, untProdAcabado, untFuncoes, untFuncFat, 
  untFuncoesRel, untFuncoesRel2;

{ TfrmFatExpSeparacaoItens }

procedure TfrmFatExpSeparacaoItens.btnAleClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(226, 7768, [],
                        ['MOSMEN'],
                        [IIf(fSepararSomenteAteQuantidadeImpressaNaSeparacaoWMS,'1','2')],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmFatExpSeparacaoItens.btnExpClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(227, 7769, [],
                        ['MOSMEN'],
                        [IIf(fSepararSomenteAteQuantidadeImpressaNaSeparacaoWMS,'1','2')],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmFatExpSeparacaoItens.pRepassaQuantidadeSeparadaParaTodosOsItemsComMesmoAutoIncrem;
  Var 
    cdsClone : TUniClientDataSet;

  function fRepassaQuantidadeSeparadaDeItensComEsseAutoIncrem(strAutInc: String): Double;
  begin
    Result := 0;
    
    cdsClone.Filtered := False;
    cdsClone.Filter   := '(AUTOINCREM = ' + QuotedStr(strAutInc) + ')';
    cdsClone.Filtered := True;

    cdsClone.First;
    While Not cdsClone.Eof Do
    Begin
      Result := Result + cdsClone.FieldByName('QTDSEP').AsFloat;
      cdsClone.Next;
    End
  end;
  
begin
  cdsClone := TUniClientDataSet.Create(Nil);
  pCloneDataSet(cdsClone, cdsItens);
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('QTDSEP').AsFloat := fRepassaQuantidadeSeparadaDeItensComEsseAutoIncrem(cdsItens.FieldByName('AUTOINCREM').AsString);
      cdsItens.Post;

      cdsItens.Next;
    End
  Finally
    FreeAndNil(cdsClone);
  End;
end;

procedure TfrmFatExpSeparacaoItens.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not fTodosSeparados()) Then
    blnConfir := (fMensagem('ATENÇÃO', 'Existem produtos que não foram separados totalmente. Deseja continuar?', ['&Sim', '&Não']) = 1)
  Else
    blnConfir := True;

  If (blnConfir) Then 
  Begin
    If (fPedidoWms) Then
    Begin
      pRepassaQuantidadeSeparadaParaTodosOsItemsComMesmoAutoIncrem;
    End;
      
    btnSair.Click();
  End;
end;

procedure TfrmFatExpSeparacaoItens.btnExpAutClick(Sender: TObject);

  function fPermiteSepararAutomaticamente():Boolean;
  begin
    Result := True;
    If (cdsItens.FieldByName('QTDSEP').AsFloat > 0) Then
      Result := (fQtdIteDisponivelParaSeparacao >= fQtdIteDisponivelParaSeparacao(True));
  end;
begin
  inherited;

  Try
    cdsItens.DisableControls();
    cdsItens.First();

    Try
      While (Not cdsItens.Eof) Do
      Begin
        If (Not fPermiteSepararAutomaticamente) Then
        Begin
          pMensagemOk('Produto (' + cdsItens.FieldByName('CODITE').AsString +
                      ') já foi expedido por outro operador!' + #10+#13 +
                      'Recarregue o documento e tente novamente.');
          Exit;
        End;

        cdsItens.Next();
      End;

      cdsItens.First();
      While (Not cdsItens.Eof) Do
      Begin
        cdsItens.Edit();
        cdsItens.FieldByName('QTDSEP').AsFloat := fQtdIteDisponivelParaSeparacao(True);
        cdsItens.Post();

        cdsItens.Next();
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatExpSeparacaoItens.btnExpAutClick]');
    End;
  Finally
    cdsItens.EnableControls();
    cdsItens.First();
  End;
end;

procedure TfrmFatExpSeparacaoItens.btnLimpaExpClick(Sender: TObject);
begin
  inherited;

  Try
    cdsItens.DisableControls();
    cdsItens.First();

    Try
      While (Not cdsItens.Eof) Do Begin
        cdsItens.Edit();
        If (pnlPedWms.Visible) Then
        Begin
          If (cdsItens.FieldByName('SEPORI').AsFloat > 0) And 
             (cdsItens.FieldByName('SEPORI').AsFloat = cdsItens.FieldByName('QTDBAI').AsFloat) Then
          Begin   
            cdsItens.FieldByName('QTDSEP').AsFloat := cdsItens.FieldByName('SEPORI').AsFloat;
          End
          Else
          Begin
            cdsItens.FieldByName('QTDSEP').AsFloat := 0;
          End;
        End
        Else
        Begin
          cdsItens.FieldByName('QTDSEP').AsFloat := 0;
        End;
        cdsItens.Post();

        cdsItens.Next();
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatExpSeparacaoItens.btnLimpaExpClick]');
    End;
  Finally
    cdsItens.EnableControls();
  End;
end;

procedure TfrmFatExpSeparacaoItens.btnQuantidadeClick(Sender: TObject);
begin
  inherited;

  If (Not btnQuantidade.Enabled) Then
    Exit;

  edtQtdIte.Enabled := True;
  pSetFocus(edtQtdIte);
end;

function TfrmFatExpSeparacaoItens.fQtdIteDisponivelParaSeparacao(blnSomaQuantidadeSeparadaAnteriormente: Boolean=False): Double;
begin  
  If (fSepararSomenteAteQuantidadeImpressaNaSeparacaoWMS) Then
    Result := cdsItens.FieldByName('QTDLDO').AsFloat + IIF(blnSomaQuantidadeSeparadaAnteriormente, cdsItens.FieldByName('SEPORI').AsFloat, 0.0000)
  Else  
    Result := cdsItens.FieldByName('QTDITE').AsFloat;

  Result := fFormataFloat(Result, intDecQtd);
end;

function TfrmFatExpSeparacaoItens.fSepararSomenteAteQuantidadeImpressaNaSeparacaoWMS: Boolean;
begin
  Result := False;

  If (pnlPedWms.Visible) Then
  Begin
    Result := (Not fPermiteExpedirQuantidadeDiferenteSeparadaWMS) Or (fCfgSis('EXBWMS', VarBoolean));
  End
end;

function TfrmFatExpSeparacaoItens.fEncontraItem(var strMensagem: String;
  blnAtualizaQtde: Boolean): Boolean;
  Var
    fltQtdIte,
    fltEmbala: Double;
    blnBusNormalOuExp2CodBarCompleta: Boolean;
    strEmpSaldoBaseImobiliaria: String;
    intDecQtd: Integer;

  function fRetornaSaldoVerificaoEstoqueBaseImobiliaria(strEmpPrdBase: String; fltSaldoBase: Double; strCodIteBase: String): Double;
      function fRetornaSaldoEstoqueEmpresa(strCodEmpBase: String): Double;
      begin
        Result := fCampoTabela('ITE_SALDOS',
                               'ITEGER',
                               ['ITE_CODITE', 'ITE_CODEMP'],
                               [strCodIteBase, strCodEmpBase]);
      end;
  begin
    Result := fltSaldoBase;

    If strEmpPrdBase <> VS_strCodEmp Then
      Result := fRetornaSaldoEstoqueEmpresa(strEmpPrdBase);
  end;
begin
  cdsItens.First;
  Result    := False;

  intDecQtd := fCfgSis('DECQTD', VarInteger);

  blnBusNormalOuExp2CodBarCompleta :=((Not bln2CodBar) Or (strCamBus = 'CODITE')) Or (bln2CodBar And (Not fEmptyStr(strCodIteFor)));

  If (cdsItens.FindFirst) Then Begin
    Result := True;

    Repeat
      If Not fEmptyStr(strAutInc) Then
      Begin
        If (cdsItens.FieldByName('AUTOINCREM').AsString <> strAutInc) Then
          Continue;
      End;
    
      If SameText(strCamBus, 'BAREMB') Then
        fltEmbala := objIteBar.fQuantidadeEmbalagem(cdsItens.FieldByName('CODITE').AsString, strCodDig)
      Else
        fltEmbala := 1;

      fltQtdIte := cdsItens.FieldByName('QTDSEP').AsFloat + fltEmbala * fStrToFloat(edtQtdIte.Text);

      If (fFormataFloat(fQtdIteDisponivelParaSeparacao, intDecQtd) >= fFormataFloat(fltQtdIte, intDecQtd)) Then
      Begin
        If (blnBusNormalOuExp2CodBarCompleta) Then 
        Begin
          If fExcedeLimiteItensNFe Then
            blnAtualizaQtde := False

          Else If (VS_strTipExpInterna = '3') Or (VS_strTipExpInterna = '4') Then
          Begin
            If (cdsItens.FieldByName('IDEPRO').AsString <> 'NOR') Then Begin
              If (cdsItens.FieldByName('OPRFLJ').AsString = 'N') And
                 (cdsItens.FieldByName('ENT_CD').AsString = 'S') Then
                strEmpSaldoBaseImobiliaria := cdsItens.FieldByName('EMP_CD').AsString
              Else
                strEmpSaldoBaseImobiliaria := cdsItens.FieldByName('EMPPRD').AsString;
            End;
          End;

          If blnAtualizaQtde Then
          Begin
            If (Frac(fStrToFloat(edtQtdIte.Text)) <> 0) And
               fItemNaoFracionavel('VN', cdsItens.FieldByName('UNIDAD').AsString) Then
            Begin
              {**********************************************************************}
              { CHECAGEM ADICIONAL, CASO O USUÁRIO TENTE DIGITAR UM VALOR FRACIONADO }
              { SEM APAGAR A VÍRGULA DA MÁSCARA                                      }
              {*******************************************************************VA*}
              strMensagem := 'Não é permitido informar valor fracionado para esse item!';
              Break;
            End
            Else
            Begin
              cdsItens.Edit;
              cdsItens.FieldByName('QTDSEP').AsFloat := cdsItens.FieldByName('QTDSEP').AsFloat +
                                                        fltEmbala * fStrToFloat(edtQtdIte.Text);

              If (strCamBus = 'CODITE') Then
                cdsItens.FieldByName('TIPBUS').AsString := 'C';

              cdsItens.Post;
            End;

            If Assigned(objCodBar) Then
              objCodBar.pAddCodBar(strCodDig, cdsItens.FieldByName('CODITE').AsString, fltEmbala * fStrToFloat(edtQtdIte.Text));

          End;

          edtQtdIte.Text := FloatToStrF(1, ffFixed, 12, intDecQtd);
          strMensagem := '';
          Break;
        End;
      End
      Else
      Begin
        If fFormataFloat(cdsItens.FieldByName('QTDSEP').AsFloat, intDecQtd) >=
           fFormataFloat(fQtdIteDisponivelParaSeparacao, intDecQtd) Then
          strMensagem := 'Produto (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') já foi totalmente expedido!'
        Else
          strMensagem := 'Quantidade não permitida para o produto (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ').';
      End;

    Until (Not cdsItens.FindNext);

  End;
end;

function TfrmFatExpSeparacaoItens.fExcedeLimiteItensNFe: Boolean;
  Var
    strEntRet, strEntFut: String;
    strInformacao: String;
    intQtdItens: Integer;
begin
  With TUniClientDataSet.Create(nil) Do
  Begin
    Data := cdsItens.Data;

    Filter := cdsItens.Filter;

    If Not fEmptyStr(Filter) Then
      Filter := Filter  + ' AND ';

    strEntRet := cdsItens.FieldByName('ENTRET').AsString;
    strEntFut := cdsItens.FieldByName('ENTFUT').AsString;

    Filter := Filter + 'QTDSEP > 0 AND ';
    Filter := Filter + 'ENTRET = ' + QuotedStr(strEntRet) + ' AND ';
    Filter := Filter + 'ENTFUT = ' + QuotedStr(strEntFut);

    Filtered := True;

    If cdsItens.FieldByName('QTDSEP').AsInteger > 0 Then
      intQtdItens := RecordCount
    Else
      intQtdItens := RecordCount + 1;

    If strEntRet = 'R' Then
      Result := TFatVenda.fUltrapassouLimiteItensNFe(intQtdItens, 'Retira', strInformacao)

    Else If strEntFut = 'N' Then
      Result := TFatVenda.fUltrapassouLimiteItensNFe(intQtdItens, 'Entrega Imediata', strInformacao)

    Else
      Result := TFatVenda.fUltrapassouLimiteItensNFe(intQtdItens, 'Entrega Futura', strInformacao);

    Destroy;
  End;

  If Result Then
    pMensagemSonora(strInformacao);
end;

function TfrmFatExpSeparacaoItens.fGetSQLDocVen: String;
begin
  Result := 'SELECT ';
  Result := Result + '  MOVDET.AUTOINCREM, ';
  Result := Result + '  I.ITE_CODITE AS CODITE, ';
  Result := Result + IIF(fCfgSis('CADLOC', VarBoolean), 'CONCAT(I.ITE_DESITE, " - LT: ", IFNULL(DET_NUMLOT,"")) ', 'I.ITE_DESITE') + ' AS DESITE, ';
  Result := Result + '  DET_QTDITE AS QTDITE, ';
  Result := Result + '  UNI_CODUNI AS UNIDAD, ';
  Result := Result + '  IFNULL(DET_QTDSEP, 0.0000) AS QTDSEP, ';
  Result := Result + '  IFNULL(DET_QTDSEP, 0.0000) AS SEPORI, ';
  Result := Result + '  0.000                      AS QTDBAI, ';
  Result := Result + '  "" AS ENTRET, ';
  Result := Result + '  DET_ENTFUT AS ENTFUT, ';
  Result := Result + '  ITE_SALDOS AS SALDOS, ';
  Result := Result + '  ITE_SALDOS AS SALEST, ';
  Result := Result + '  DET_CODACA AS CODACA, ';
  Result := Result + '  DET_EMPACA AS EMPACA, ';
  Result := Result + '  DET_IDEPRO AS IDEPRO, ';
  Result := Result + '  GER_OPRFLJ AS OPRFLJ, ';
  Result := Result + '  "" AS ENT_CD, ';
  Result := Result + '  "" AS EMPPRD, ';
  Result := Result + '  "" AS EMP_CD, ';
  Result := Result + '  FOR_MODDIL AS MODDIL, ';
  Result := Result + '  FOR_TEXBAS AS TEXBAS, ';
  Result := Result + '  FOR_TIPCOR AS TIPCOR, ';
  Result := Result + '  FOR_CATALI AS CATALI, ';
  Result := Result + '  0.00       AS QTDLDO, ';
  Result := Result + '  DET_NUMLOT AS NUMLOT, ';
  Result := Result + '  0.00       AS QTDREP, ';
  Result := Result + '  (SELECT GROUP_CONCAT(CONCAT("-", BAR_CODBAR, "-")) FROM ';
  Result := Result + '  ITEBAR WHERE I.ITE_CODITE = BAR_CODITE) AS BAREMB,      ';
  Result := Result + '  MAR_DESMAR AS DESMAR, ';
  Result := Result + '  COALESCE(DET_QTDITE, 0.0000) - COALESCE(DET_QTDSEP, 0.0000) AS QTDPEN, ';

  If (fCfgSis('EXPTIN',varString) = '1') Then
    Result := Result + '  IF(DET_CODACA IS NOT NULL AND DET_CODACA <> "", ACA_CODBAR, I.ITE_CODBAR) AS CODBAR, '
  Else
  Begin
    Result := Result + '  I.ITE_CODBAR AS CODBAR, ';
    Result := Result + '  ACA_CODBAR   AS CODBAT, ';
  End;

  If (blnSepPorArmazem) Then
    Result := Result + ' (SELECT AMZ_DESCRI FROM CADAMZ WHERE AMZ_CODAMZ = DET_NUMLOT AND AMZ_CODEMP = DET_CODEMP) AS DESLOC, '
  Else
  begin
    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      Result := Result + ' IF(IFNULL(DET_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) AS DESLOC, '
    else
      Result := Result + ' (SELECT LSE_DESCRI FROM CADLSE WHERE LSE_CODIGO = ITE_CODLSE) AS DESLOC, ';
  end;
  Result := Result + '  "" AS TIPBUS ';

  Result := Result + 'FROM ';
  Result := Result + '  MOVGER ';
  Result := Result + '   LEFT JOIN AUXMOV ';
  Result := Result + '     ON MOVGER.AUTOINCREM = AUXMOV.AUX_SEQGER ';
  Result := Result + '  INNER JOIN MOVDET ';
  Result := Result + '     ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';
  Result := Result + '  INNER JOIN MOVTRI ';
  Result := Result + '     ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
  Result := Result + '  INNER JOIN CADITE I ';
  Result := Result + '     ON I.ITE_CODITE = DET_CODITE ';
  Result := Result + '  INNER JOIN ITEGER G ';
  Result := Result + '     ON G.ITE_CODITE = DET_CODITE ';
  Result := Result + '    AND G.ITE_CODEMP = DET_CODEMP ';
  Result := Result + '  INNER JOIN CADUNI ';
  Result := Result + '     ON I.ITE_CODUNI = UNI_CODUNI ';
  Result := Result + '  LEFT JOIN FORTIN ';
  Result := Result + '     ON MOVDET.DET_CODACA = FORTIN.FOR_CODACA ';
  Result := Result + '    AND FORTIN.FOR_EMPACA = MOVDET.DET_EMPACA ';
  Result := Result + '   LEFT JOIN CADACA ON ACA_CODACA = MOVDET.DET_CODACA AND ';
  Result := Result + '                       ACA_CODEMP = MOVDET.DET_EMPACA ';
  Result := Result + '   LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';

  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
  begin
    Result := Result + ' LEFT JOIN CADLOT LT ON LT.LOT_CODITE = DET_CODITE AND LT.LOT_CODEMP = DET_CODEMP AND LT.LOT_NUMLOT = DET_NUMLOT ';
    Result := Result + ' LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LT.LOT_LOCFIS AND CL1.LOC_CODEMP = LT.LOT_CODEMP ';
    Result := Result + ' LEFT JOIN CADLOC CL2 ON CL2.LOC_CODLOC = G.ITE_LOCFIS AND CL2.LOC_CODEMP = G.ITE_CODEMP ';
    Result := Result + ' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ';
    Result := Result + ' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = CL2.LOC_CODLSE ';
  end;

  Result := Result + 'WHERE DET_NUMDOC = :NUMDOC ';
  Result := Result + '  AND DET_ESPDOC = :ESPDOC ';
  Result := Result + '  AND DET_CODEMP = :CODEMP ';
  Result := Result + '  AND DET_CODCLI = :CODCLI ';

  If fCfgSis('EXBXTO', varBoolean) Then
  begin
    If Not strCodLse.IsEmpty Then
    Begin
      If (blnSepPorArmazem) Then
        Result := Result + '  AND DET_NUMLOT = :CODLSE '
      Else
      begin
        if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
          Result := Result + '  AND IF(IFNULL(DET_NUMLOT, "") = "", LS2.LSE_CODIGO, LS1.LSE_CODIGO) = :CODLSE '
        else
          Result := Result + '  AND ITE_CODLSE = :CODLSE '
      end;
    End;
  end
  else
  begin
    If (blnSepPorArmazem) Then
      Result := Result + '  AND DET_NUMLOT = :CODLSE '
    Else
      Result := Result + '  AND ITE_CODLSE = :CODLSE ';
  end;
  Result := Result + 'ORDER BY DET_CODITE ';
end;

function TfrmFatExpSeparacaoItens.fGetSQLPedido: String;
begin
  Result := 'SELECT ';
  Result := Result + '  FATDOR.AUTOINCREM, ';
  Result := Result + '  I.ITE_CODITE AS CODITE, ';
  Result := Result + IIF(fCfgSis('CADLOC', VarBoolean), 'CONCAT(I.ITE_DESITE, " - LT: ", COALESCE(LDO_NUMLOT, FDO_NUMLOT,""), IF(IFNULL(FDO_PEGOU_, "N") = "S", " - JÁ PEGOU", "")) ', 'I.ITE_DESITE') + ' AS DESITE, ';
  Result := Result + '  COALESCE(LDO_QTDITE, FDO_QTDITE) AS QTDITE, ';
  Result := Result + '  UNI_CODUNI AS UNIDAD, ';
  Result := Result + '  IF(LDO_NUMLOT IS NULL, FDO_QTDSEP, 0.0000) AS QTDSEP, ';
  Result := Result + '  IFNULL(FDO_QTDSEP, 0.0000) AS SEPORI, ';
  Result := Result + '  IFNULL(FDO_QTDBAI, 0.0000) AS QTDBAI, ';
  Result := Result + '  FDO_ENTRET AS ENTRET, ';
  Result := Result + '  FDO_ENTFUT AS ENTFUT, ';
  Result := Result + '  COALESCE(LOT_SALDOS, ITE_SALDOS, 0.0000) AS SALDOS, ';
  Result := Result + '  COALESCE(LOT_SALDOS, ITE_SALDOS, 0.0000) AS SALEST, ';
  Result := Result + '  FDO_CODACA AS CODACA, ';
  Result := Result + '  FDO_EMPACA AS EMPACA, ';
  Result := Result + '  FDO_IDEPRO AS IDEPRO, ';
  Result := Result + '  FGO_OPRFLJ AS OPRFLJ, ';
  Result := Result + '  FGO_ENT_CD AS ENT_CD, ';
  Result := Result + '  FDO_EMPPRD AS EMPPRD, ';
  Result := Result + '  FGO_EMP_CD AS EMP_CD, ';
  Result := Result + '  FOR_MODDIL AS MODDIL, ';
  Result := Result + '  FOR_TEXBAS AS TEXBAS, ';
  Result := Result + '  FOR_TIPCOR AS TIPCOR, ';
  Result := Result + '  FOR_CATALI AS CATALI, ';
  Result := Result + '  LDO_QTDITE AS QTDLDO, ';
  Result := Result + '  LDO_NUMLOT AS NUMLOT, ';
  Result := Result + '  (SELECT COUNT(*) FROM FATDOR FA WHERE FA.FDO_SEQGER = FATDOR.FDO_SEQGER and FA.FDO_CODITE = FATDOR.FDO_CODITE) AS QTDREP, ';
  Result := Result + '  (SELECT GROUP_CONCAT(CONCAT("-", BAR_CODBAR, "-")) FROM ';
  Result := Result + '  ITEBAR WHERE I.ITE_CODITE = BAR_CODITE) AS BAREMB,      ';
  Result := Result + '  MAR_DESMAR AS DESMAR, ';
  Result := Result + '  COALESCE(FDO_QTDITE, 0.0000) -  COALESCE(FDO_QTDSEP, 0.0000) AS QTDPEN, ';

  If (fCfgSis('EXPTIN',varString) = '1') Then
    Result := Result + '  IF(FDO_CODACA IS NOT NULL AND FDO_CODACA <> "", ACA_CODBAR, I.ITE_CODBAR) AS CODBAR, '
  Else
  Begin
    Result := Result + '  I.ITE_CODBAR AS CODBAR, ';
    Result := Result + '  ACA_CODBAR   AS CODBAT, ';
  End;
   
  If (blnSepPorArmazem) Then
    Result := Result + ' (SELECT AMZ_DESCRI FROM CADAMZ WHERE AMZ_CODAMZ = COALESCE(LDO_NUMLOT, FDO_NUMLOT) AND AMZ_CODEMP = FDO_CODEMP) AS DESLOC, '
  Else
  begin
    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      Result := Result + ' IF(IFNULL(FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) AS DESLOC, '
    else
      Result := Result + ' (SELECT LSE_DESCRI FROM CADLSE WHERE LSE_CODIGO = ITE_CODLSE) AS DESLOC, ';
  end;

  Result := Result + '  FDO_TIPBUS AS TIPBUS ';

  Result := Result + 'FROM ';
  Result := Result + '  FATGOR ';
  Result := Result + '   LEFT JOIN EXTGOR ';
  Result := Result + '     ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';
  Result := Result + '  INNER JOIN FATDOR ';
  Result := Result + '     ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ';
  Result := Result + '  INNER JOIN EXTDOR ';
  Result := Result + '     ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ';
  Result := Result + '  LEFT JOIN LOTDOR ';
  Result := Result + '     ON FATDOR.AUTOINCREM = LOTDOR.LDO_SEQFDO ';
  Result := Result + '  LEFT JOIN CADLOT ';
  Result := Result + '     ON CADLOT.LOT_CODEMP = FATDOR.FDO_CODEMP ';
  Result := Result + '    AND CADLOT.LOT_CODITE = FATDOR.FDO_CODITE ';
  Result := Result + '    AND CADLOT.LOT_NUMLOT = COALESCE(LOTDOR.LDO_NUMLOT, FATDOR.FDO_NUMLOT) ';
  Result := Result + '  INNER JOIN CADITE I ';
  Result := Result + '     ON I.ITE_CODITE = FDO_CODITE ';
  Result := Result + '  INNER JOIN ITEGER G ';
  Result := Result + '     ON G.ITE_CODITE = FDO_CODITE ';
  Result := Result + '    AND G.ITE_CODEMP = IF(TRIM(IFNULL(EXTGOR.FGO_EMPEXP, "")) <> "", EXTGOR.FGO_EMPEXP, FATDOR.FDO_CODEMP) ';
  Result := Result + '  INNER JOIN CADUNI ';
  Result := Result + '     ON I.ITE_CODUNI = UNI_CODUNI ';
  Result := Result + '   LEFT JOIN FORTIN ';
  Result := Result + '     ON FATDOR.FDO_CODACA = FORTIN.FOR_CODACA ';
  Result := Result + '    AND FORTIN.FOR_EMPACA = FATDOR.FDO_EMPACA ';
  Result := Result + '   LEFT JOIN CADACA ON ACA_CODACA = FATDOR.FDO_CODACA AND ';
  Result := Result + '                       ACA_CODEMP = FATDOR.FDO_EMPACA     ';
  Result := Result + '   LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';

  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
  begin
    Result := Result + ' LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LOT_LOCFIS AND CL1.LOC_CODEMP = LOT_CODEMP ';
    Result := Result + ' LEFT JOIN CADLOC CL2 ON CL2.LOC_CODLOC = G.ITE_LOCFIS AND CL2.LOC_CODEMP = G.ITE_CODEMP ';
    Result := Result + ' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ';
    Result := Result + ' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = CL2.LOC_CODLSE ';
  end;

  Result := Result + 'WHERE FDO_NUMDOC = :NUMDOC ';
  Result := Result + '  AND FDO_ESPDOC = :ESPDOC ';
  Result := Result + '  AND FDO_CODEMP = :CODEMP ';
  Result := Result + '  AND FDO_CODCLI = :CODCLI ';

  If fUsaRotinaExpedicaoConferenciaRetiraCaixa Then
    If fCfgSis('EMPFAT', VarBoolean) Then
      Result := Result + '  AND FDO_EMPITE = "' + VS_strCodEmp + '" ';

  If fCfgSis('EXBXTO', varBoolean) Then
  begin
    If Not strCodLse.IsEmpty Then
    Begin
      If (blnSepPorArmazem) Then
        Result := Result + '  AND FDO_NUMLOT = :CODLSE '
      Else
      begin
        if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
          Result := Result + '  AND IF(IFNULL(FDO_NUMLOT, "") = "", LS2.LSE_CODIGO, LS1.LSE_CODIGO) = :CODLSE '
        else
          Result := Result + '  AND ITE_CODLSE = :CODLSE '
      end;
    End;
  end
  else
  begin
    If (blnSepPorArmazem) Then
      Result := Result + '  AND FDO_NUMLOT = :CODLSE '
    Else
      Result := Result + '  AND ITE_CODLSE = :CODLSE ';
  end;
  Result := Result + 'ORDER BY FDO_CODITE ';
end;

procedure TfrmFatExpSeparacaoItens.FormActivate(Sender: TObject);
begin
  inherited;
  If (edtCodIte.Visible) And (edtCodIte.Enabled) And (Not edtCodIte.ReadOnly) Then
    pSetFocus(edtCodIte);
end;

procedure TfrmFatExpSeparacaoItens.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(objIteBar);
  FreeAndNil(objCodBar);
end;

procedure TfrmFatExpSeparacaoItens.FormCreate(Sender: TObject);
begin
  inherited;
  intDecQtd    := fCfgSis('DECQTD', varInteger);
  edtQtdIte.EditFormat := fMskDigitos(intDecQtd);

  pnlPedWms.Visible := False;

  strNumDoc := '';
  strEspDoc := '';
  strCodCli := '';
  strCodLse := '';
  strCodEmp := '';
  blnConfir := False;
  blnSepPorArmazem := False;
  
  objIteBar := TIteBar.Create(opcFuncoes);
  objCodBar := TCodigoBarras.Create();

  cdsItens.CreateDataSet();

  If fCfgSis('TIPBAR', varString) = '2' Then
   edtCodIte.MaxLength := 43;
end;

procedure TfrmFatExpSeparacaoItens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then Begin
    If (fMensagem('', 'Deseja sair?', ['&Sim', '&Não']) = 1) Then
      btnSair.Click()
    Else
      Key := 0;
  End;

  If (Key = VK_F10) Then
  Begin
    Key := 0;
    btnConfirma.Click();
  End;

  If (Key = VK_F7) And (btnExpAut.Visible) Then btnExpAut.Click();
  If (Key = VK_F11) Then btnLimpaExp.Click();
  If (Key = VK_F6) Then btnQuantidade.Click;
end;

procedure TfrmFatExpSeparacaoItens.FormShow(Sender: TObject);
begin
  inherited;

  edtQtdIte.Text := FloatToStrF(1, ffFixed, 12, intDecQtd);

  If fEmptyStr(VS_strTipExpInterna) Then
    VS_strTipExpInterna := VS_strTipExp;

  shpSemSal.Visible := (VS_strTipExpInterna = '2');
  lblSemSal.Visible := (VS_strTipExpInterna = '2');
  btnExpAut.Visible := (fVerificaAcessoSistema('SEPAUT'));

  If (blnSepPorArmazem) Then
  Begin
    Self.Caption := 'Separação por Armazém';
    grdItensDESLOC.Caption := 'Armazém'
  End
  Else
  Begin
    Self.Caption := 'Separação por Local de Separação';
    grdItensDESLOC.Caption := 'Loc. Sep.'
  End;

  pInicializarGrid();

  pSetFocus(edtCodIte);
  edtQtdIte.Enabled := False;
end;

function TfrmFatExpSeparacaoItens.fPedidoWms: Boolean;
begin
  Result := (fUsaRotinaWMS) And (strEspDoc = 'PD');
end;

function TfrmFatExpSeparacaoItens.fProcuraSemelhante(strCodBar: String;
  var strCodSem: String): Boolean;
  Var
    qryCadSem: TUniQuery;
Begin
  Try
    Result := False;
    qryCadSem := fCriaQuery(Self);

    Try
      With qryCadSem, SQL Do Begin
        Clear;
        Add('SELECT');
        Add('  SEM_CODITE ');
        Add('FROM ');
        Add('  CADSEM ');
        Add('WHERE ');
        Add('  SEM_CODBAR = :CODBAR ');

        ParamByName('CODBAR').AsString := strCodBar;
        Open;

        If IsEmpty Then Begin
          strCodSem := '';
          Result := False;
        End Else Begin
          strCodSem := FieldByName('SEM_CODITE').AsString;
          Result := True;
        End;

      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatExpSeparacaoItens.fProcuraSemelhante]');
    End;
  Finally
    FreeAndNil(qryCadSem);
  End;
end;

function TfrmFatExpSeparacaoItens.fTodosSeparados: Boolean;
begin
  Try
    Result := True;

    cdsItens.DisableControls();
    cdsItens.First();

    Try
      While (Not cdsItens.Eof) Do 
      Begin
        If (fFormataFloat(cdsItens.FieldByName('QTDSEP').AsFloat, intDecQtd) < fQtdIteDisponivelParaSeparacao) Then
        Begin
          Result := False;
          Break;
        End;

        cdsItens.Next();
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatExpSeparacaoItens.fTodosSeparados]');
    End;
  Finally
    cdsItens.EnableControls();
    cdsItens.First();
  End;
end;

function TfrmFatExpSeparacaoItens.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  blnMudarFoco := False;

  If (Sender = edtQtdIte) Then
  Begin
    If Not fValidarQuantidade Then
      Result := False
    Else
    Begin
      pSetFocus(edtCodIte);
      edtQtdIte.Enabled := False;
    End;
  End

  Else If (Sender = edtCodIte) Then
  Begin
    If Not fValidarQuantidade Then
      Result := False
    Else
    Begin
      pExpedeItem;
      edtQtdIte.Text := FloatToStrF(1, ffFixed, 12, intDecQtd);
      blnMudarFoco := False;
      pSetFocus(edtCodIte);
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmFatExpSeparacaoItens.fValidarQuantidade: Boolean;
begin
  Result := True;
  If (fEmptyStr(edtQtdIte.Text)) Then
  Begin
    pMensagemSonora('A quantidade deve ser preenchida!');
    Result := False;
  End
  Else If (fStrToFloat(edtQtdIte.Text) <= 0.0) Then
  Begin
    pMensagemSonora('A quantidade deve ser maior que zero!');
    Result := False;
  End
  Else If (Frac(fStrToFloat(edtQtdIte.Text)) <> 0) And Assigned(edtQtdIte.OnKeyPress) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido informar valor fracionado para esse item!', ['&O k']);
    Result := False;
  End;
end;

procedure TfrmFatExpSeparacaoItens.grdItensViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);

  procedure pSetaAutInc;
  begin
    If (strAutInc = cdsItens.FieldByName('AUTOINCREM').AsString) Then
      strAutInc := ''
    Else  
      strAutInc := cdsItens.FieldByName('AUTOINCREM').AsString;
  end;

  function fSeparadoPorCompleto: Boolean;
  begin
    Result := (cdsItens.FieldByName('QTDSEP').Value > 0) And (cdsItens.FieldByName('QTDSEP').Value = fQtdIteDisponivelParaSeparacao); 
  end;
  
begin
  inherited;

  If (pnlPedWms.Visible) Then
  Begin
    If (cdsItens.FieldByName('QTDREP').AsInteger > 1) Then 
    Begin
      If (Not fSeparadoPorCompleto) Then
      Begin
        If (fSepararSomenteAteQuantidadeImpressaNaSeparacaoWMS) Then
        Begin
          If (cdsItens.FieldByName('QTDLDO').AsInteger > 0) Then
            pSetaAutInc
          Else
            pMensagemSonora('Somente podem ser marcados itens com separação impressa!');
        End
        Else
        Begin
          pSetaAutInc;
        End;
      End;
    End;
  End;
end;

procedure TfrmFatExpSeparacaoItens.grdItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
 Var
   fltQTDSEP,
   fltQTDITE,
   fltSALEST: Double;
   strIncAtu: String;
   APainter: TcxPainterAccess;   

 procedure pDesenhaIndicador(intIndex: Integer);  
 begin
   APainter := TcxPainterAccess(TcxViewInfoAcess(AViewInfo).GetPainterClass.Create(ACanvas, AViewInfo));
   with APainter do
   begin
     try
      with TcxCustomTextEditViewInfo(AViewInfo.EditViewInfo).TextRect do  
        Left := Left + imgIndica.Width + 1;  

      DrawContent;  
      DrawBorders;  

      with AViewInfo.ClientBounds do  
        imgIndica.Draw(ACanvas.Canvas, Left + 1, Top + 1, intIndex, dsTransparent, itMask); 
     finally
       Free;
     end;
   end;
   ADone := True;
 end;
   
begin
  inherited;

  If Assigned(grdItensView.DataController.DataSource.DataSet) And
    (Not grdItensView.DataController.DataSource.DataSet.IsEmpty) Then 
  Begin

    fltQTDSEP := VarAsType(IfNull(grdItensView.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdItensQTDSEP.Index], 0), varDouble);
    If (fSepararSomenteAteQuantidadeImpressaNaSeparacaoWMS) Then
      fltQTDITE := VarAsType(IfNull(grdItensView.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdItensQTDLDO.Index], 0), varDouble)
    Else  
      fltQTDITE := VarAsType(IfNull(grdItensView.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdItensQTDITE.Index], 0), varDouble);
    strIncAtu := VarAsType(IfNull(grdItensView.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdItensAUTINC.Index], 0), varString);

    If (fFormataFloat(fltQTDSEP, intDecQtd) >= fFormataFloat(fltQTDITE, intDecQtd)) And (fltQTDITE > 0) And (fltQTDSEP > 0) Then
    Begin
      If (ACanvas.Brush.Color = clHighlight) Then
        ACanvas.Font.Color := clWhite;

      ACanvas.Brush.Color := $0096CFA7;

      If (strIncAtu = strAutInc) Then
        strAutInc := '';
    End Else If (fltQTDSEP > 0) And (fFormataFloat(fltQTDSEP, intDecQtd) < fFormataFloat(fltQTDITE, intDecQtd)) Then
    Begin
      If (ACanvas.Brush.Color = clHighlight) Then
        ACanvas.Font.Color := clBlack;

      ACanvas.Brush.Color := $00CCFFFF;
    End;

    fltSALEST := VarAsType(IfNull(grdItensView.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdItensSALEST.Index], 0), varDouble);

    If (shpSemSal.Visible) Then Begin
      If (fltSALEST <= 0) Then
        ACanvas.Font.Color := shpSemSal.Brush.Color;
    End;

    //::ATENÇÃO:: SEMPRE DEIXAR ESSE BLOCO POR ÚLTIMO
    If (pnlPedWms.Visible) Then
    Begin
      If (AViewInfo.Item = grdItensIMGICO) Then
      Begin
        If (AViewInfo.EditViewInfo Is TcxCustomTextEditViewInfo) Then
        Begin   
          If (strAutInc = strIncAtu) Then
          Begin
            pDesenhaIndicador(1);
          End
          Else If (VarAsType(IfNull(grdItensView.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdItensQTDREP.Index], 0), varInteger) > 1) Then
          Begin
            pDesenhaIndicador(0);
          End;
        End;
      End;
    End;
  End;
end;

procedure TfrmFatExpSeparacaoItens.pExpedeItem(blnExpAut: Boolean);
  Var
    strMensagem  : String;
    blnAchou,
    blnBarExp    : Boolean;
    strCodSem    : String;
    strCodIteUni : String;
    strCodGruUni : String;
    fltQtdIteUni : Double;
    strTxtCap    : String;

    strCodIteAux : String;
    strCodDigAux : String;
    strCamBusAux : String;

    fltQtdBal : Double;
    intQtdBal : Integer;

  procedure SetaCampoProcurar(const strCaption: string); begin
    If Not bln2CodBar Then
      lblCodBar.Caption := strCaption;

    If bln2CodBar And (strCaption = CAP_CODBAR_EMB) Then
      strCamBus := 'CODBAR'
    Else
    If bln2CodBar And (strCaption = CAP_CODBAR_FOR) Then
      strCamBus := 'CODBAT'
    Else
      strCamBus := 'CODBAR';
  end;

  procedure pInverteBusca; begin
    If (strCamBus='BAREMB') Then Begin
      strCamBus:='CODBAT';
      strTxtCap:=CAP_CODBAR_FOR;
      lblCodBar.Caption:=CAP_CODBAR_EMB;
    End Else Begin
      strCamBus:='BAREMB';
      strTxtCap:=CAP_CODBAR_EMB;
      lblCodBar.Caption:=CAP_CODBAR_FOR;
    End;
  end;

  function fBuscaSegundoCodBar:Boolean; begin
    pInverteBusca;

    strCodIteFor := Trim(InputBox('AutCom', strTxtCap,''));

    strCodIte    := strCodIteFor;
    strCodDig    := strCodIteFor;

    Result := fEncontraItem(strMensagem);
  end;

  procedure pArmazenaCondicaoBusca(chrAcao:char); begin
    Case chrAcao Of
    'A':Begin
          strCodIteAux := strCodIte;
          strCodDigAux := strCodDig;
          strCamBusAux := strCamBus;
        End;

    'V':Begin
          strCodIte := strCodIteAux;
          strCodDig := strCodDigAux;
          strCamBus := strCamBusAux;
        End;
    End;
  end;

begin

  bln2CodBar   := (fCfgSis('EXPTIN') = '2') And (cdsItens.FieldByName('IDEPRO').AsString <> 'NOR');
  strCodIteFor := '';

  If ((Length(edtCodIte.Text) > fTamCodIte) Or (blnAutSer)) And (Not fBarrasBalanca(edtCodIte.Text, strBarBal)) Then
    strCamBus := 'BAREMB'
  Else Begin
    strCamBus := 'CODITE';

    If fBarrasBalanca(edtCodIte.Text, strBarBal) Then Begin
      intQtdBal := StrToIntDef(Copy(edtCodIte.Text, 8, 5),0);
      edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, intQtdBal);
      edtCodIte.Text := Copy(edtCodIte.Text, 3, 5);

      If fCfgSis('DVQBAL') = 'S' Then Begin
        fltQtdBal := intQtdBal / 1000;
        edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, fltQtdBal);
      End;
    End Else
      edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);

    blnBarExp := (fCampoTabela('ITE_BAREXP', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]) = 'S') and fCfgSis('BAREXP', varBoolean);

    If (blnBarExp) And (Not blnExpAut) Then Begin
      edtCodIte.Clear;
      pMensagemSonora('Para expedir o produto '+cdsItens.FieldByName('CODITE').AsString+' é necessário informar o código de barras. Esta informação é obrigatória para este item. '+
                      'Verifique o cadastro de produtos - Aba "Dados de Saída" - Campo "Obrig. Cód. Barras Expedição"');
      Exit;
    End;
  End;

  strMensagem := '';

  strCodIte := edtCodIte.Text;
  strCodDig := edtCodIte.Text;
  cdsItens.IndexFieldNames := 'AUTOINCREM';
  cdsItens.DisableControls;

  pArmazenaCondicaoBusca('A');

  If (Not bln2CodBar) Or (strCamBus = 'CODITE') Then Begin
    blnAchou := fEncontraItem(strMensagem);
  End Else Begin
    blnAchou := fEncontraItem(strMensagem);

    If (Not blnAchou) Then Begin
      pInverteBusca;
      blnAchou := fEncontraItem(strMensagem);
    End;

    If blnAchou Then Begin
      blnAchou := fBuscaSegundoCodBar;
    End;
  End;

  pArmazenaCondicaoBusca('V');

  If (Not blnAchou) And fCfgSis('ETIDIF', varBoolean) And (strCamBus = 'BAREMB') Then Begin
    If objIteBar.fLerCodigoBarrasUnidades(edtCodIte.Text, strCodIteUni, strCodGruUni, fltQtdIteUni) Then Begin
      strCamBus := 'CODITE';
      strCodIte := strCodIteUni;
      edtCodIte.Text := strCodIteUni;
      edtQtdIte.Text := FloatToStrF(fltQtdIteUni, ffFixed, 12, fCfgSis('DECQTD', varInteger));
      blnAchou := fEncontraItem(strMensagem);
    End;
  End;

  If (Not bln2CodBar) And (Not blnAchou) And (Length(edtCodIte.Text) > fTamCodIte) Then Begin
    SetaCampoProcurar(CAP_CODBAR_EMB);
    blnAchou := fEncontraItem(strMensagem);

    If (Not blnAchou) Then Begin
      SetaCampoProcurar(CAP_CODBAR_FOR);
      blnAchou := fEncontraItem(strMensagem);

      If (Not blnAchou) And fProcuraSemelhante(edtCodIte.Text, strCodSem) Then Begin
        strCamBus := 'CODITE';
        edtCodIte.Text := strCodSem;
        strCodIte      := strCodSem;
        blnAchou := fEncontraItem(strMensagem);
      End;
    End;
  End;

  cdsItens.EnableControls;

  If (Not blnAchou) Then 
  Begin
    If (fEmptyStr(strAutInc)) Then
    Begin
      strMensagem := 'Produto (' + edtCodIte.Text
             + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') não encontrado!';
    End
    Else
    Begin
      strMensagem := 'Produto (' + edtCodIte.Text
             + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') difere do código de item marcado para separação exclusiva!' + #10#13 
             + 'Desmarque o mesmo com um duplo clique para poder separar este!';

      cdsItens.Locate('AUTOINCREM', strAutInc, []);       
    End       
  End;

  If (Not fEmptyStr(strMensagem)) Then Begin
    pMensagemSonora(strMensagem);
  End;

  edtCodIte.Clear;
  lblCodBar.Caption:=CAP_CODBAR_EMB;
end;

procedure TfrmFatExpSeparacaoItens.pInicializarGrid;
  Var
    sSQL: String;
begin
  Try
    If (strEspDoc = 'PD') Then
      sSQL := fGetSQLPedido()
    Else
      sSQL := fGetSQLDocVen();

    qryItens.Close();
    qryItens.SQL.Clear();
    qryItens.SQL.Text := sSQL;

    qryItens.ParamByName('CODEMP').AsString := strCodEmp;
    qryItens.ParamByName('NUMDOC').AsString := strNumDoc;
    qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
    qryItens.ParamByName('CODCLI').AsString := strCodCli;

    If (Assigned(qryItens.FindParam('CODLSE'))) Then
      qryItens.ParamByName('CODLSE').AsString := strCodLse;

    qryItens.Open();
    qryItens.First();

    If (Not fUsaRotinaExpedicaoConferenciaRetiraCaixa) Then
      pnlPedWms.Visible := fPedidoWms;

    grdItensNUMLOT.Visible := pnlPedWms.Visible;
    grdItensQTDLDO.Visible := pnlPedWms.Visible;
    grdItensIMGICO.Visible := pnlPedWms.Visible;

    cdsItens.EmptyDataSet();

    If (qryItens.RecordCount > 0) Then Begin
      cdsItens.DisableControls();

      While (Not qryItens.Eof) Do Begin
        cdsItens.Append();

        cdsItens.FieldByName('AUTOINCREM').AsString := qryItens.FieldByName('AUTOINCREM').AsString;

        cdsItens.FieldByName('CODITE').AsString := qryItens.FieldByName('CODITE').AsString;
        cdsItens.FieldByName('DESITE').AsString := qryItens.FieldByName('DESITE').AsString;
        cdsItens.FieldByName('ENTFUT').AsString := qryItens.FieldByName('ENTFUT').AsString;
        cdsItens.FieldByName('ENTRET').AsString := qryItens.FieldByName('ENTRET').AsString;
        cdsItens.FieldByName('UNIDAD').AsString := qryItens.FieldByName('UNIDAD').AsString;
        cdsItens.FieldByName('QTDITE').AsFloat  := qryItens.FieldByName('QTDITE').AsFloat;
        cdsItens.FieldByName('QTDSEP').AsFloat  := qryItens.FieldByName('QTDSEP').AsFloat;
        cdsItens.FieldByName('SEPORI').AsFloat  := qryItens.FieldByName('SEPORI').AsFloat;
        cdsItens.FieldByName('QTDBAI').AsFloat  := qryItens.FieldByName('QTDBAI').AsFloat;
        cdsItens.FieldByName('SALDOS').AsFloat  := qryItens.FieldByName('SALDOS').AsFloat;
        cdsItens.FieldByName('SALEST').AsFloat  := qryItens.FieldByName('SALEST').AsFloat;
        cdsItens.FieldByName('CODACA').AsString := qryItens.FieldByName('CODACA').AsString;
        cdsItens.FieldByName('EMPACA').AsString := qryItens.FieldByName('EMPACA').AsString;
        cdsItens.FieldByName('IDEPRO').AsString := qryItens.FieldByName('IDEPRO').AsString;
        cdsItens.FieldByName('OPRFLJ').AsString := qryItens.FieldByName('OPRFLJ').AsString;
        cdsItens.FieldByName('ENT_CD').AsString := qryItens.FieldByName('ENT_CD').AsString;
        cdsItens.FieldByName('EMPPRD').AsString := qryItens.FieldByName('EMPPRD').AsString;
        cdsItens.FieldByName('EMP_CD').AsString := qryItens.FieldByName('EMP_CD').AsString;
        cdsItens.FieldByName('MODDIL').AsString := qryItens.FieldByName('MODDIL').AsString;
        cdsItens.FieldByName('TEXBAS').AsString := qryItens.FieldByName('TEXBAS').AsString;
        cdsItens.FieldByName('TIPCOR').AsString := qryItens.FieldByName('TIPCOR').AsString;
        cdsItens.FieldByName('CATALI').AsString := qryItens.FieldByName('CATALI').AsString;
        cdsItens.FieldByName('TIPBUS').AsString := qryItens.FieldByName('TIPBUS').AsString;
        cdsItens.FieldByName('BAREMB').Value    := qryItens.FieldByName('BAREMB').Value;
        cdsItens.FieldByName('QTDLDO').AsFloat  := qryItens.FieldByName('QTDLDO').AsFloat;
        cdsItens.FieldByName('NUMLOT').AsString := qryItens.FieldByName('NUMLOT').AsString;
        cdsItens.FieldByName('QTDREP').Value    := qryItens.FieldByName('QTDREP').Value;
        If (fCfgSis('EXPTIN',varString) = '1') Then
          cdsItens.FieldByName('CODBAR').AsString := qryItens.FieldByName('CODBAR').AsString
        Else
        Begin
          cdsItens.FieldByName('CODBAR').AsString := qryItens.FieldByName('CODBAR').AsString;
          cdsItens.FieldByName('CODBAT').AsString := qryItens.FieldByName('CODBAT').AsString;
        End;
        cdsItens.FieldByName('DESLOC').Value    := qryItens.FieldByName('DESLOC').Value;
        cdsItens.FieldByName('DESMAR').Value    := qryItens.FieldByName('DESMAR').Value;
        cdsItens.FieldByName('QTDPEN').Value    := qryItens.FieldByName('QTDPEN').Value;

        cdsItens.Post();
        qryItens.Next();
      End;

      cdsItens.OnFilterRecord := pOnFilter;
      cdsItens.EnableControls();
    End Else Begin
      fMensagem('ALERTA', 'Nenhum registro encontrado!', ['&OK']);
      pSetFocus(edtCodIte);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatExpSeparacaoItens.pInicializarGrid]');
  End;
end;

procedure TfrmFatExpSeparacaoItens.pOnFilter(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If SameText(strCamBus, 'BAREMB') Then
    Accept := Pos('-' + strCodIte + '-', DataSet.FieldByName(strCamBus).AsString) > 0
  Else
    Accept := (DataSet.FieldByName(strCamBus).AsString = strCodIte)
end;

end.
