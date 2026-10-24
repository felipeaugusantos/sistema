unit untConfirmaEspelho;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, StrUtils,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, System.UITypes,
  cxDataStorage, cxEdit, cxNavigator, untZClient, Uni, cxProgressBar, untHelperCitel,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxImageComboBox,
  System.ImageList, Vcl.ImgList, dxGDIPlusClasses, untFuncFat, untConstantesNfe,
  untTypesSistema,
  untTControlaReservaDevolucaoVenda,
  untTDistribuicaoConferencia;

type
{$SCOPEDENUMS ON}
  TenuEstado = (Pronto, Carregando, Confirmando, Editando);
{$SCOPEDENUMS OFF}

type
  TfrmConfirmaEspelho = class(TfrmPai)
    cxgDocumentosDBTableView: TcxGridDBTableViewCitel;
    cxgDocumentosLevel: TcxGridLevel;
    cxgDocumentos: TcxGridCitel;
    cxgDocumentosDBTableViewNUMESP: TcxGridDBColumn;
    cxgDocumentosDBTableViewCODFOR: TcxGridDBColumn;
    cxgDocumentosDBTableViewNOMFOR: TcxGridDBColumn;
    cxgDocumentosDBTableViewCLAFIS: TcxGridDBColumn;
    cxgDocumentosDBTableViewTOTPRO: TcxGridDBColumn;
    cxgDocumentosDBTableViewTOTIPI: TcxGridDBColumn;
    cxgDocumentosDBTableViewTOTRET: TcxGridDBColumn;
    cxgDocumentosDBTableViewTOTFRE: TcxGridDBColumn;
    cxgDocumentosDBTableViewDESACE: TcxGridDBColumn;
    cxgDocumentosDBTableViewVLRCON: TcxGridDBColumn;
    cxgDocumentosDBTableViewQTDITE: TcxGridDBColumn;
    cxgDocumentosDBTableViewTIPESP: TcxGridDBColumn;
    ImageList: TImageList;
    Panel1: TPanel;
    Image3: TImage;
    Image4: TImage;
    Label1: TLabel;
    Label2: TLabel;
    btnManFis: TBitBtnLocked;
    btnExpedicao: TBitBtnLocked;
    btnEmitirNF: TBitBtnLocked;
    btnImpressao: TBitBtnLocked;
    btnDelete: TBitBtnLocked;
    cxgDocumentosDBTableViewOPEEXP: TcxGridDBColumn;
    shpLegExp: TShape;
    lblLegExp: TLabel;
    mnuManutencao: TPopupMenu;
    mnuManFis: TMenuItem;
    mnuManFrete: TMenuItem;
    procedure btnManFisClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnImpressaoClick(Sender: TObject);
    procedure btnExpedicaoClick(Sender: TObject);
    procedure btnEmitirNFClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cxgDocumentosDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure mnuManFisClick(Sender: TObject);
    procedure mnuManFreteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    strClaGae: String;
    fatVenda : TFatVenda;
    cdsDocumentos : TZClient;

    blnDelEsp,
    blnExpEsp,
    blnManEsp,
    blnFreEsp,
    blnEmiEsp : Boolean;
    FenuEstado: TenuEstado;

    function fGetSql : String;
    function fManutencaoFiscalProgresso(cxProgress: TcxProgressBar): Boolean;
    procedure pManutencaoFrete();
    procedure pCarregaDados;
    procedure pCdsDocumentosAfterScroll(DataSet : TDataSet);
    procedure pCdsDocumentosBeforeScroll(DataSet: tdataset);
    procedure pCarregaDadosFornecedor(strCodFor: String);
    function fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
    function fIncluiItens: Boolean;
    function fEmitirNF: Boolean;
    function fBaixaEspelho: Boolean;
    procedure pAjustaDespesaAcessoria;
    function fValorIPI: Double;
    function fLiberaReservaDeEstoque(const AutIncVen: String) : Boolean;
    function fConfirmandoEspelhoEnvioFornecedor: Boolean;
    procedure pSetEstado(enuEstado: TenuEstado);
    function fCarregaEspelhoFatVendas: boolean ;
    function fObterCodFab(pstrIncGad: String): String;
  public
  end;

implementation

uses
  untFuncoesSimples, untEspelhoImpressao, untFatDadosFiscaisImpostos,
  UniClientDataSet, untEspelhoOutrasSaidasFornecedor, untGravando,
  untConfirmaEspelhoConferencia, untFuncFatTypes, untFuncoes,
  untFatDadosFiscais, untDuplicatas, untGarant, untFuncoesLibNfe,
  untFatRemessaDevolucaoClasse,
  untConstantes, untAlteraFreteEspelho;

{$R *.dfm}

function TfrmConfirmaEspelho.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT GER_NUMESP AS NUMESP, ';
  Result := Result + '        GER_CODEMP AS CODEMP, ';
  Result := Result + '        FOR_CODFOR AS CODFOR, ';
  Result := Result + '        FOR_NOMFOR AS NOMFOR, ';
  Result := Result + '        GER_CLAFIS AS CLAFIS, ';
  Result := Result + '        GER_TOTPRO AS TOTPRO, ';
  Result := Result + '        GER_TOTIPI AS TOTIPI, ';
  Result := Result + '        GER_TOTRET AS TOTRET, ';
  Result := Result + '        GER_TOTFRE AS TOTFRE, ';
  Result := Result + '        GER_DESACE AS DESACE, ';
  Result := Result + '        GER_DESESP AS DESESP, ';
  Result := Result + '        GER_VLRCON AS VLRCON, ';
  Result := Result + '        GER_QTDITE AS QTDITE, ';
  Result := Result + '        GER_OPEEXP AS OPEEXP, ';
  Result := Result + '        GER_CONPAG AS CONPAG, ';
  Result := Result + '        GER_CODTRA AS CODTRA, ';
  Result := Result + '        GER_TIPFRE AS TIPFRE, ';
  Result := Result + '        GER_CODCND AS CODCND, ';
  Result := Result + '        GER_CODFPG AS CODFPG, ';
  Result := Result + '        GER_BASICM AS BASICM, ';
  Result := Result + '        GER_TOTICM AS TOTICM, ';
  Result := Result + '        GER_BASIPI AS BASIPI, ';
  Result := Result + '        GER_BASRET AS BASRET, ';
  Result := Result + '        GER_PESBRU AS PESBRU, ';
  Result := Result + '        GER_PESLIQ AS PESLIQ, ';
  Result := Result + '        GER_VOLUME AS VOLUME, ';
  Result := Result + '        GER_ESPECI AS ESPECI, ';
  Result := Result + '        GER_MARCA_ AS MARCA_, ';
  Result := Result + '        GER_NUMERA AS NUMERA, ';
  Result := Result + '        GER_MEN001 AS MEN001, ';
  Result := Result + '        GER_MEN002 AS MEN002, ';
  Result := Result + '        GER_MEN003 AS MEN003, ';
  Result := Result + '        GER_MEN004 AS MEN004, ';
  Result := Result + '        GER_MEN005 AS MEN005, ';
  Result := Result + '        GER_CHVNFE AS CHVNFE, ';

  Result := Result + '        GER_DESACE AS ORI_DESACE, ';
  Result := Result + '        GER_TOTRET AS ORI_TOTRET, ';
  Result := Result + '        GER_TOTIPI AS ORI_TOTIPI, ';

  Result := Result + '        GER_TIP_FC AS TIP_FC, ';

  Result := Result + '        (SELECT GROUP_CONCAT(DET_CODFIS) FROM ESPDET ';
  Result := Result + '         WHERE DET_SEQGER = ESPGER.AUTOINCREM) AS CODFIS, ';

  Result := Result + '        (SELECT AVG(IFNULL(DET_PERFCP,0)) FROM ESPDET ';
  Result := Result + '         WHERE ESPDET.DET_SEQGER = ESPGER.AUTOINCREM) AS PERFCP, ';

  Result := Result + '        (SELECT SUM(IFNULL(DET_VALFCP,0)) FROM ESPDET ';
  Result := Result + '         WHERE ESPDET.DET_SEQGER = ESPGER.AUTOINCREM) AS VALFCP, ';

  Result := Result + '        (SELECT AVG(IFNULL(DET_PFCPST,0)) FROM ESPDET ';
  Result := Result + '         WHERE ESPDET.DET_SEQGER = ESPGER.AUTOINCREM) AS PFCPST, ';

  Result := Result + '        (SELECT SUM(IFNULL(DET_VFCPST,0)) FROM ESPDET ';
  Result := Result + '         WHERE ESPDET.DET_SEQGER = ESPGER.AUTOINCREM) AS VFCPST, ';

  Result := Result + '        IF(                   ';
  Result := Result + '        (SELECT COUNT(0)      ';
  Result := Result + '         FROM ESPDET          ';
Result := Result + '           INNER JOIN ESPDEG ON DEG_SEQGER = ESPDET.AUTOINCREM ';
  Result := Result + '         WHERE DET_SEQGER = ESPGER.AUTOINCREM ) = 0, "O", "G") AS TIPESP, ';

  Result := Result + '        IF(                   ';
  Result := Result + '        (SELECT COUNT(0)      ';
  Result := Result + '         FROM ESPDET          ';
  Result := Result + '         WHERE DET_SEQGER = ESPGER.AUTOINCREM ';
  Result := Result + '           AND DET_SEQDET IS NULL ';
  Result := Result + '           AND DET_DESESP = 0) > 0, "S", "N") AS UNIEDI, ';

  Result := Result + '        ESPGER.AUTOINCREM AS AUTINC, ';
  Result := Result + '        GER_NATOPE AS NATOPE, ';
  Result := Result + '        GER_NUMREM AS NUMREM, ';
  Result := Result + '        GER_PLAFAT AS PLAFAT ';

  Result := Result + '        ,(SELECT AUX_ENTSIM FROM ESPDET  ';
  Result := Result + '        JOIN MOVDET ON MOVDET.AUTOINCREM  = DET_SEQDET';
  Result := Result + '        JOIN AUXMOV ON AUXMOV.AUX_SEQGER  = MOVDET.DET_SEQGER';
  Result := Result + '        WHERE ESPDET.DET_SEQGER = ESPGER.AUTOINCREM';
  Result := Result + '        LIMIT 1) ENTSIM ';

  Result := Result + ' FROM ESPGER ';
  Result := Result + '   INNER JOIN CADFOR ON FOR_CODFOR = GER_CODFOR ';
  Result := Result + ' WHERE GER_MOVGER IS NULL ';
  Result := Result + '   AND GER_CODEMP = :CODEMP ';
  Result := Result + '   AND GER_TIP_FC = "F" ';
end;

procedure TfrmConfirmaEspelho.FormCreate(Sender: TObject);
begin
  inherited;
  pSetEstado(tenuEstado.Pronto);
  strClaGae := fTransform(fCfgSis('CLAGAE'), 4);
end;

procedure TfrmConfirmaEspelho.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = Vk_F6 Then
  Begin
    If btnImpressao.Enabled Then
      btnImpressao.Click;
  End
  Else
  If Key = VK_F7 Then
  Begin
    Key := 0;
    If mnuManFis.Enabled Then
      mnuManFis.Click
  End
  Else
  If Key = VK_F8 Then
  Begin
    Key := 0;
    If mnuManFrete.Enabled Then
      mnuManFrete.Click
  End
  Else
  If Key = VK_F2 Then
  Begin
    Key := 0;
    If btnExpedicao.Enabled Then
      btnExpedicao.Click
  End
  Else
  If Key = VK_F10 Then
  Begin
    Key := 0;
    If btnEmitirNF.Enabled Then
      btnEmitirNF.Click;
  End
  Else
  If Key = VK_Delete Then
  Begin
    Key := 0;
    If btnDelete.Enabled Then
      btnDelete.Click;
  End;

end;

procedure TfrmConfirmaEspelho.FormShow(Sender: TObject);
begin
  inherited;
  blnExpEsp := fVerificaAcessoSistema('EXPESP');
  blnManEsp := fVerificaAcessoSistema('MANESP');
  blnFreEsp := fVerificaAcessoSistema('FREESP');
  blnEmiEsp := fVerificaAcessoSistema('EMIESP');
  blnDelEsp := fVerificaAcessoSistema('DELESP');
  btnImpressao.Enabled := fVerificaAcessoSistema('IMPESP');

  btnExpedicao.Visible := fCfgSis('CONESP',varBoolean);
  shpLegExp.Visible    := btnExpedicao.Visible;
  lblLegExp.Visible    := btnExpedicao.Visible;
  btnExpedicao.Enabled := blnExpEsp;
  mnuManFis.Enabled    := blnManEsp;
  mnuManFrete.Enabled  := blnFreEsp;
  btnEmitirNF.Enabled  := blnEmiEsp;
  btnDelete.Enabled    := blnDelEsp;

  pCarregaDados;
  pSetFocus(btnSair);
end;

procedure TfrmConfirmaEspelho.pCarregaDados;
Begin
  Try
    pSetEstado(TenuEstado.Carregando);

    If Not Assigned(cdsDocumentos) Then
      cdsDocumentos := TZClient.Create(Self, fGetSql);

    cdsDocumentos.qryQuery.Close;
    cdsDocumentos.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
    cdsDocumentos.fAbreClient(True,'', False, True);

    pAjustaDespesaAcessoria;

    cdsDocumentos.AfterScroll := pCdsDocumentosAfterScroll;
    cdsDocumentos.BeforeScroll := pCdsDocumentosBeforeScroll;

    TFloatField(cdsDocumentos.FieldByName('TOTPRO')).DisplayFormat := fDisplayFormat(2);
    TFloatField(cdsDocumentos.FieldByName('TOTIPI')).DisplayFormat := fDisplayFormat(2);
    TFloatField(cdsDocumentos.FieldByName('TOTRET')).DisplayFormat := fDisplayFormat(2);
    TFloatField(cdsDocumentos.FieldByName('TOTFRE')).DisplayFormat := fDisplayFormat(2);
    TFloatField(cdsDocumentos.FieldByName('DESACE')).DisplayFormat := fDisplayFormat(2);
    TFloatField(cdsDocumentos.FieldByName('VLRCON')).DisplayFormat := fDisplayFormat(2);

    cxgDocumentosDBTableView.DataController.DataSource := cdsDocumentos.dtsSource;
    cxgDocumentosDBTableView.ApplyBestFit();
    pSetFocus(cxgDocumentos);
  Finally
    pSetEstado(TenuEstado.Pronto);
  End;
End;

function TfrmConfirmaEspelho.fValorIPI: Double;
var
  fltIpiDev: Double;
begin
  fltIpiDev := fEspelhoValorIpiDevolvido(cdsDocumentos.FieldByName('NUMESP').AsString,
                                         cdsDocumentos.FieldByName('CODEMP').AsString);

  Result := cdsDocumentos.FieldByName('TOTIPI').AsFloat - fltIpiDev;

End;

procedure TfrmConfirmaEspelho.pAjustaDespesaAcessoria;
var
  strForcaSubTributariaEmDadosPropriosLocal: String;
Begin
  Try
    cdsDocumentos.DisableControls;
    cdsDocumentos.First;
    While Not cdsDocumentos.Eof Do
    Begin
      If Not fImprimeIPIDadosProprios(cdsDocumentos.FieldByName('CLAFIS').AsString,
                                      VS_strClaVen,
                                      fCfgSis('IVLIPI', varString),
                                      fCfgSis('CONIPI', varBoolean)) Then
      Begin
        cdsDocumentos.Edit;
        cdsDocumentos.FieldByName('DESACE').AsFloat := cdsDocumentos.FieldByName('DESACE').AsFloat + fValorIPI;
        cdsDocumentos.FieldByName('TOTIPI').AsFloat := 0;
        cdsDocumentos.Post;
      End;

      strForcaSubTributariaEmDadosPropriosLocal := IIF(fForcaSubTributariaEmDadosPropriosRegraEspecial('OF',
                                                                                                       cdsDocumentos.FieldByName('TIP_FC').AsString,
                                                                                                       cdsDocumentos.FieldByName('CLAFIS').AsString,
                                                                                                       cdsDocumentos.FieldByName('CODFIS').AsString,
                                                                                                       fCfgSis('SIMPAU', varBoolean),
                                                                                                       cdsDocumentos.FieldByName('TOTRET').AsFloat,
                                                                                                       cdsDocumentos.FieldByName('VALFCP').AsFloat,
                                                                                                       cdsDocumentos.FieldByName('VFCPST').AsFloat), 'S', 'N');

      If Not fImprimeSubTributariaDadosProprios(cdsDocumentos.FieldByName('CLAFIS').AsString,
                                                VS_strClaVen,
                                                fRegimeSubstituicaoTributaria('', 'OF'),
                                                fCfgSis('SIMPAU', varBoolean),
                                                strForcaSubTributariaEmDadosPropriosLocal) Then
      Begin
        cdsDocumentos.Edit;
        cdsDocumentos.FieldByName('DESACE').AsFloat := cdsDocumentos.FieldByName('DESACE').AsFloat + cdsDocumentos.FieldByName('TOTRET').AsFloat;
        cdsDocumentos.FieldByName('TOTRET').AsFloat := 0;
        cdsDocumentos.Post;
      End;

      cdsDocumentos.Next;
    End;
  Finally
    cdsDocumentos.First;
    cdsDocumentos.EnableControls;
  End;


End;

procedure TfrmConfirmaEspelho.pCdsDocumentosBeforeScroll(DataSet: tdataset);
begin
  if FenuEstado in [TenuEstado.Confirmando, TenuEstado.Editando] then
    Abort;
end;

procedure TfrmConfirmaEspelho.pCdsDocumentosAfterScroll(DataSet: TDataSet);
begin
  if DataSet.IsEmpty Then
  Begin
    btnDelete.Enabled    := False;
    btnImpressao.Enabled := False;
    mnuManFis.Enabled    := False;
    mnuManFrete.Enabled  := False;
    btnExpedicao.Enabled := False;
    btnEmitirNF.Enabled  := False;


    Exit;
  End;

  btnDelete.Enabled    := blnDelEsp;
  mnuManFis.Enabled    := blnManEsp And (fEmptyStr(DataSet.FieldByName('OPEEXP').AsString)) Or (not btnExpedicao.Visible);
  mnuManFrete.Enabled  := blnFreEsp And (fEmptyStr(DataSet.FieldByName('OPEEXP').AsString)) Or (not btnExpedicao.Visible);
  btnEmitirNF.Enabled  := blnEmiEsp And (not fEmptyStr(DataSet.FieldByName('OPEEXP').AsString)) Or (not btnExpedicao.Visible);
  btnExpedicao.Enabled := blnExpEsp And fEmptyStr(DataSet.FieldByName('OPEEXP').AsString);
end;

procedure TfrmConfirmaEspelho.pSetEstado(enuEstado: TenuEstado);
begin
  FenuEstado := enuEstado;
end;

procedure TfrmConfirmaEspelho.btnDeleteClick(Sender: TObject);
begin
  inherited;
  If fMensagem('', 'Deseja Realmente excluir o espelho de Número: ' + cdsDocumentos.FieldByName('NUMESP').AsString + ' ?', ['&Sim', '&Não'], 2) = 1 Then
  Begin
    If TEspelhoCapa.fApagarEspelho(cdsDocumentos.FieldByName('AUTINC').AsString, Self.Name) Then
      pCarregaDados;
  End;
end;

procedure TfrmConfirmaEspelho.btnEmitirNFClick(Sender: TObject);
  Var
    strIncFat : String;
begin
  inherited;
  Try
    strIncFat := cdsDocumentos.FieldByName('AUTINC').AsString;
    If Not fLock_Unlock('ESPGER_MANUT_' + strIncFat, True, False) Then
    Begin
      fMensagem('', 'Este cadastro está sendo utilizado em Outra Estação por ' +
                     fGetHostLock('ESPGER_MANUT_' + cdsDocumentos.FieldByName('AUTINC').AsString) + '!', ['&Ok']);
      Exit;
    End;

    If fMensagem('', 'Deseja confirmar o espelho de Número: ' + cdsDocumentos.FieldByName('NUMESP').AsString + ' ?', ['&Sim', '&Não'], 2 )= 1 Then
    Begin
      If fEmitirNF Then
        pCarregaDados;
    End;

  Finally
    fLock_Unlock('ESPGER_MANUT_' + strIncFat, False, False);
  End;
end;

procedure TfrmConfirmaEspelho.btnExpedicaoClick(Sender: TObject);
  Var
    strIncConf : String;
begin
  inherited;
  Try
    pSetEstado(TenuEstado.Editando);
    strIncConf := cdsDocumentos.FieldByName('AUTINC').AsString;
    If TfrmConfirmaEspelhoConferencia.fConfereEspelho(strIncConf) Then
    Begin
      If TEspelhoCapa.fMarcaComoExpedido(strIncConf) Then
      Begin
        pCarregaDados;
        cdsDocumentos.Locate('AUTINC', strIncConf, []);
      End;
    End;
  Finally
    pSetEstado(TenuEstado.Pronto);
  End;
end;

procedure TfrmConfirmaEspelho.btnImpressaoClick(Sender: TObject);
  Var
    strOpcDoc : String;
begin
  inherited;
  fCarregaEspelhoFatVendas ;
  try
    strOpcDoc := IIF(cdsDocumentos.FieldByName('TIPESP').AsString = 'O', 'OF', 'GF');
    TfrmEspelhoImpressao.pImprimeEspelho(strOpcDoc, cdsDocumentos.FieldByName('CODEMP').AsString,
                                         cdsDocumentos.FieldByName('NUMESP').AsString,
                                         '',
                                         fatVenda);
  finally
    if Assigned(fatVenda) then
      FreeAndNil(fatVenda) ;
  end ;
end;

procedure TfrmConfirmaEspelho.cxgDocumentosDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgDocumentosDBTableViewOPEEXP.Index]) <> '' Then
  Begin
    ACanvas.Brush.Color := shpLegExp.Brush.Color;
    If AViewInfo.Selected Then
      ACanvas.Font.Color  := clBlue
    Else
      ACanvas.Font.Color  := clBlack;
  End;
end;

procedure TfrmConfirmaEspelho.mnuManFisClick(Sender: TObject);
begin
  inherited;
  Try
    pSetEstado(TenuEstado.Editando);
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fManutencaoFiscalProgresso;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
    pSetEstado(TenuEstado.Pronto);
  End
end;

procedure TfrmConfirmaEspelho.mnuManFreteClick(Sender: TObject);
begin
  inherited;

  pManutencaoFrete;
end;

procedure TfrmConfirmaEspelho.btnManFisClick(Sender: TObject);
Var
    x,y : Integer;
begin
  inherited;

  x := Self.Left + btnManFis.Left;
  y := Self.Top + Self.Height - (pnlBotoes.Height + pnlInfo.Height);

  mnuManutencao.Popup(x,y);
End;

function TfrmConfirmaEspelho.fManutencaoFiscalProgresso(cxProgress : TcxProgressBar) : Boolean;
  Var
    cdsItens : TZClient;
    qryCadIte : TUniQuery;
    cdsImpostosDigitadosItens : TUniClientDataSet;
    objEspGer : TEspelhoCapa;
    objEspDet : TEspelhoDetalhe;
    strIncEdit : String;
    blnPrint : Boolean;
    fltVrdIcm : Double;
    strOpcDoc : String;
begin
  inherited;
  Result := True;
  blnPrint := False;
  Try
    Try
      pCriarFormularios(TfrmFatDadosFiscaisImpostos, frmFatDadosFiscaisImpostos);
      cdsItens := TZClient.Create(nil);
      strIncEdit := '';

      If Not fLock_Unlock('ESPGER_MANUT_' + cdsDocumentos.FieldByName('AUTINC').AsString, True, False) Then
      Begin
        fMensagem('', 'Este cadastro está sendo utilizado em Outra Estação por ' +
                       fGetHostLock('ESPGER_MANUT_' + cdsDocumentos.FieldByName('AUTINC').AsString) + '!', ['&Ok']);
        Result := False;
        Exit;
      End;

      strIncEdit := cdsDocumentos.FieldByName('AUTINC').AsString;

      With cdsItens.qryQuery, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT * FROM ESPDET WHERE DET_SEQGER = :SEQGER ');
        ParamByName('SEQGER').AsString := cdsDocumentos.FieldByName('AUTINC').AsString;
        cdsItens.fAbreClient(True, 'TfrmConfirmaEspelho.mnuManFisClick');
      End;

      qryCadIte := fCriaQuery;
      With qryCadIte, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT ITE_DESITE, ');
        Add('        ITE_REFERE, ');
        Add('        ITE_CLAIPI, ');
        Add('        UNI_SIGUNI  ');
        Add(' FROM CADITE        ');
        Add('   LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ');
        Add(' WHERE ITE_CODITE = :CODITE ');
      End;

      frmFatDadosFiscaisImpostos.blnConfirmacaoEspelho := True;
      frmFatDadosFiscaisImpostos.strCodigoFornecedor   := cdsDocumentos.FieldByName('CODFOR').AsString;
      frmFatDadosFiscaisImpostos.blnAlteraValorDoItem  := cdsDocumentos.FieldByName('UNIEDI').AsString = 'S';
      frmFatDadosFiscaisImpostos.blnNotaFornecedor     := True;
      frmFatDadosFiscaisImpostos.blnIcmsDesonerado     := True;
      frmFatDadosFiscaisImpostos.blnTrocaCFOP          := True;

      frmFatDadosFiscaisImpostos.strCliOrg := 'N';
      frmFatDadosFiscaisImpostos.strZonFra := 'N';
      frmFatDadosFiscaisImpostos.Caption := 'Manutenção do Espelho: ' +
                                            cdsDocumentos.FieldByName('NUMESP').AsString + ' Fonecedor: ' +
                                            cdsDocumentos.FieldByName('CODFOR').AsString + ' - ' +
                                            cdsDocumentos.FieldByName('NOMFOR').AsString;

      frmFatDadosFiscaisImpostos.pnlMensagem.visible := True;
      frmFatDadosFiscaisImpostos.fraDadosFechamentoVendaMSGFatFrame.edtMens01.Text := cdsDocumentos.FieldByName('MEN001').AsString;
      frmFatDadosFiscaisImpostos.fraDadosFechamentoVendaMSGFatFrame.edtMens02.Text := cdsDocumentos.FieldByName('MEN002').AsString;
      frmFatDadosFiscaisImpostos.fraDadosFechamentoVendaMSGFatFrame.edtMens03.Text := cdsDocumentos.FieldByName('MEN003').AsString;
      frmFatDadosFiscaisImpostos.fraDadosFechamentoVendaMSGFatFrame.edtMens04.Text := cdsDocumentos.FieldByName('MEN004').AsString;
      frmFatDadosFiscaisImpostos.fraDadosFechamentoVendaMSGFatFrame.edtMens05.Text := cdsDocumentos.FieldByName('MEN005').AsString;

      if cdsDocumentos.FieldByName('TIPESP').AsString = 'G' then
        frmFatDadosFiscaisImpostos.pConfigurarConfirmacaoEspelho;

      cxProgress.pSetMax(cdsItens.RecordCount);

      cdsItens.First;

      While (not cdsItens.Eof) Do
      Begin
        qryCadIte.Close;
        qryCadIte.ParamByName('CODITE').AsString := cdsItens.FieldByName('DET_CODITE').AsString;
        qryCadIte.Open;

        frmFatDadosFiscaisImpostos.pAdicionaRegistro(cdsItens.RecNo,                               //fatVenda.arrMatItens[intCont].intAutInc,
                                                     cdsItens.FieldByName('DET_CODITE').AsString,  //fatVenda.arrMatItens[intCont].strCodIte,
                                                     VS_strCodEmp,                                 //fatVenda.arrMatItens[intCont].strEmpIte,
                                                     IIF(fEmptyStr(cdsItens.FieldByName('DET_DESCRI').AsString),qryCadIte.FieldByName('ITE_DESITE').AsString, cdsItens.FieldByName('DET_DESCRI').AsString), //fatVenda.arrMatItens[intCont].strDesIte,
                                                     qryCadIte.FieldByName('ITE_REFERE').AsString, //fatVenda.arrMatItens[intCont].strRefere,
                                                     qryCadIte.FieldByName('UNI_SIGUNI').AsString, //fatVenda.arrMatItens[intCont].strSigUni,
                                                     cdsItens.FieldByName('DET_CODFIS').AsString,  //fatVenda.arrMatItens[intCont].strCodFis,
                                                     qryCadIte.FieldByName('ITE_CLAIPI').AsString, //fatVenda.arrMatItens[intCont].strClaIpi,
                                                     cdsItens.FieldByName('DET_CODFIS').AsString,  //fatVenda.arrMatItens[intCont].strFisAnt,
                                                     cdsItens.FieldByName('DET_CODABF').AsString,   //fatVenda.arrMatItens[intCont].strCodAbf,
                                                     cdsItens.FieldByName('DET_QTDITE').AsFloat,
                                                     cdsItens.FieldByName('DET_TOTITE').AsFloat -
                                                     cdsItens.FieldByName('DET_DESESP').AsFloat,   //fatVenda.arrMatItens[intCont].fltTotIte - fatVenda.arrMatItens[intCont].fltDesEsp,
                                                     cdsItens.FieldByName('DET_BASICM').AsFloat,   //fatVenda.arrMatItens[intCont].fltBasIcm,
                                                     cdsItens.FieldByName('DET_ALQICM').AsFloat,   //fatVenda.arrMatItens[intCont].fltAlqIcm,
                                                     cdsItens.FieldByName('DET_VALICM').AsFloat,   //fatVenda.arrMatItens[intCont].fltValIcm,
                                                     cdsItens.FieldByName('DET_BASIPI').AsFloat,   //fatVenda.arrMatItens[intCont].fltBasIpi,
                                                     cdsItens.FieldByName('DET_ALQIPI').AsFloat,   //fatVenda.arrMatItens[intCont].fltAlqIpi,
                                                     cdsItens.FieldByName('DET_VALIPI').AsFloat,   //fatVenda.arrMatItens[intCont].fltValipi,
                                                     cdsItens.FieldByName('DET_BASRET').AsFloat,   //fatVenda.arrMatItens[intCont].fltBasRet,
                                                     cdsItens.FieldByName('DET_VALRET').AsFloat,   //fatVenda.arrMatItens[intCont].fltValRet,
                                                     cdsItens.FieldByName('DET_ALQPIS').AsFloat,   //fatVenda.arrMatItens[intCont].fltAlqPis,
                                                     cdsItens.FieldByName('DET_BASPIS').AsFloat,   //fatVenda.arrMatItens[intCont].fltBasPis,
                                                     cdsItens.FieldByName('DET_VALPIS').AsFloat,   //fatVenda.arrMatItens[intCont].fltValPis,
                                                     cdsItens.FieldByName('DET_ALQCOF').AsFloat,   //fatVenda.arrMatItens[intCont].fltAlqCof,
                                                     cdsItens.FieldByName('DET_BASCOF').AsFloat,   //fatVenda.arrMatItens[intCont].fltBasCof,
                                                     cdsItens.FieldByName('DET_VALCOF').AsFloat,   //fatVenda.arrMatItens[intCont].fltValCof,

                                                     cdsItens.FieldByName('DET_BFCPST').AsFloat,  // BASFCPST
                                                     cdsItens.FieldByName('DET_PFCPST').AsFloat,  // PERFCPST
                                                     cdsItens.FieldByName('DET_VFCPST').AsFloat,  // VALFCPST

                                                     cdsItens.FieldByName('DET_BASFCP').AsFloat,  // BASFCP
                                                     cdsItens.FieldByName('DET_PERFCP').AsFloat,  // PERFCP
                                                     cdsItens.FieldByName('DET_VALFCP').AsFloat,  // VALFCP

                                                     cdsItens.FieldByName('DET_CLAFIS').AsString,  //edtClaFis.Text,
                                                     cdsItens.FieldByName('DET_INCPIS').AsString,  //fatVenda.arrMatItens[intCont].strIncPis,
                                                     cdsItens.FieldByName('DET_CSTPIS').AsString,  //fatVenda.arrMatItens[intCont].strCstPis,
                                                     cdsItens.FieldByName('DET_CSTCOF').AsString,  //fatVenda.arrMatItens[intCont].strCstCof,
                                                     cdsItens.FieldByName('DET_BASVRD').AsFloat,   //fatVenda.arrMatItens[intCont].fltBasVrd,
                                                     cdsItens.FieldByName('DET_VRDICM').AsFloat,   //fatVenda.arrMatItens[intCont].fltVrdIcm,
                                                     cdsItens.FieldByName('DET_MTDICM').AsString,  //fatVenda.arrMatItens[intCont].strMtdIcm);
                                                     cdsItens.FieldByName('AUTOINCREM').AsString,  //strAutInc
                                                     cdsDocumentos.FieldByName('TIPESP').AsString, //strGarant
                                                     '',
                                                     '',
                                                     '',
                                                     cdsItens.FieldByName('DET_VALIVA').AsFloat,  // fatVenda.arrMatItens[intCont].fltValIva
                                                     cdsItens.FieldByName('DET_ALQRET').AsFloat,  // fatVenda.arrMatItens[intCont].fltAlqRet
                                                     cdsItens.FieldByName('DET_PERRED').AsFloat,  // fatVenda.arrMatItens[intCont].fltPerRed
                                                     cdsItens.FieldByName('DET_PEBAST').AsFloat, // fatVenda.arrMatItens[intCont].fltPeBaST
                                                     cdsItens.FieldByName('DET_VALCBS').AsFloat,
                                                     cdsItens.FieldByName('DET_VALIBS').AsFloat,
                                                     cdsItens.FieldByName('DET_VAL_IS').AsFloat);

        cdsItens.Next;
        cxProgress.pStep;
      End;

      If Not frmFatDadosFiscaisImpostos.cdsItens.IsEmpty Then
        frmFatDadosFiscaisImpostos.ShowModal
      Else
        fMensagem('','Não foram encontrados produtos neste documento!', ['&Ok']);

      If frmFatDadosFiscaisImpostos.ModalResult = mrOk Then
      Begin
        cdsImpostosDigitadosItens := TUniClientDataSet.Create(Self);
        cdsImpostosDigitadosItens.Data := frmFatDadosFiscaisImpostos.cdsItens.Data;
        cdsImpostosDigitadosItens.First;

        cxProgress.Position := 0;
        cxProgress.pSetMax(cdsImpostosDigitadosItens.RecordCount + 1);
        fltVrdIcm := 0;

        Try
          objEspGer := TEspelhoCapa.Create;
          objEspDet := TEspelhoDetalhe.Create;
          If objEspGer.fCarregaRegistro(cdsDocumentos.FieldByName('AUTINC').AsString) Then
          Begin
            blnPrint := True;
            fStartTransaction;

            If (cdsDocumentos.FieldByName('UNIEDI').AsString = 'S') Then
              objEspGer.fltTotPro := 0;

            While Not cdsImpostosDigitadosItens.Eof Do
            Begin
              If objEspDet.fCarregaRegistro(cdsImpostosDigitadosItens.FieldByName('DET_AUTINC').AsString) Then
              Begin
                objEspDet.strClaFis := cdsImpostosDigitadosItens.FieldByName('ITE_CLAFIS').AsString;
                objEspDet.strCodFis := cdsImpostosDigitadosItens.FieldByName('ITE_CODSIT').AsString;
                //objEspDet.strCodFis := cdsImpostosDigitadosItens.FieldByName('ITE_CSTTB2').AsString;

                objEspDet.fltBasIcm := cdsImpostosDigitadosItens.FieldByName('ITE_BASICM').AsFloat;
                objEspDet.fltAlqIcm := cdsImpostosDigitadosItens.FieldByName('ITE_ALQICM').AsFloat;
                objEspDet.fltValIcm := cdsImpostosDigitadosItens.FieldByName('ITE_VALICM').AsFloat;

                objEspDet.fltBasIpi := cdsImpostosDigitadosItens.FieldByName('ITE_BASIPI').AsFloat;
                objEspDet.fltAlqIpi := cdsImpostosDigitadosItens.FieldByName('ITE_ALQIPI').AsFloat;
                objEspDet.fltValipi := cdsImpostosDigitadosItens.FieldByName('ITE_VALIPI').AsFloat;

                objEspDet.fltBasRet := cdsImpostosDigitadosItens.FieldByName('ITE_BASRET').AsFloat;
                objEspDet.fltValRet := cdsImpostosDigitadosItens.FieldByName('ITE_VALRET').AsFloat;
                objEspDet.fltValCBS := cdsImpostosDigitadosItens.FieldByName('ITE_VALCBS').AsFloat;
                objEspDet.fltValIBS := cdsImpostosDigitadosItens.FieldByName('ITE_VALIBS').AsFloat;
                objEspDet.fltVal_IS := cdsImpostosDigitadosItens.FieldByName('ITE_VAL_IS').AsFloat;

                objEspDet.fltBFcpST := cdsImpostosDigitadosItens.FieldByName('ITE_BASFCP').AsFloat;
                objEspDet.fltPFcpST := cdsImpostosDigitadosItens.FieldByName('ITE_PERFCP').AsFloat;
                objEspDet.fltVFcpST := cdsImpostosDigitadosItens.FieldByName('ITE_VALFCP').AsFloat;

                objEspDet.fltBasPis := cdsImpostosDigitadosItens.FieldByName('ITE_BASPIS').AsFloat;
                objEspDet.fltAlqPis := cdsImpostosDigitadosItens.FieldByName('ITE_ALQPIS').AsFloat;
                objEspDet.fltValPis := cdsImpostosDigitadosItens.FieldByName('ITE_VALPIS').AsFloat;
                objEspDet.strCstPis := cdsImpostosDigitadosItens.FieldByName('ITE_CSTPIS').AsString;

                objEspDet.fltBasCof := cdsImpostosDigitadosItens.FieldByName('ITE_BASCOF').AsFloat;
                objEspDet.fltAlqCof := cdsImpostosDigitadosItens.FieldByName('ITE_ALQCOF').AsFloat;
                objEspDet.fltValCof := cdsImpostosDigitadosItens.FieldByName('ITE_VALCOF').AsFloat;
                objEspDet.strCstCof := cdsImpostosDigitadosItens.FieldByName('ITE_CSTCOF').AsString;

                objEspDet.fltBasVrd := cdsImpostosDigitadosItens.FieldByName('ITE_BASVRD').AsFloat;
                objEspDet.fltVrdIcm := cdsImpostosDigitadosItens.FieldByName('ITE_VRDICM').AsFloat;
                objEspDet.strMtdIcm := cdsImpostosDigitadosItens.FieldByName('ITE_MTDICM').AsString;

                fltVrdIcm := fltVrdIcm + objEspDet.fltVrdIcm;

                If (cdsDocumentos.FieldByName('UNIEDI').AsString = 'S') Then
                Begin
                  objEspDet.fltUnitar := cdsImpostosDigitadosItens.FieldByName('ITE_TOTITE').AsFloat / objEspDet.fltQtdIte;
                  objEspDet.fltUniDig := objEspDet.fltUnitar;
                  objEspDet.fltTotIte := cdsImpostosDigitadosItens.FieldByName('ITE_TOTITE').AsFloat;
                  objEspGer.fltTotPro := objEspGer.fltTotPro + objEspDet.fltTotIte;
                End;

                objEspDet.fSalva;
              End;

              cxProgress.pStep;
              cdsImpostosDigitadosItens.Next;
            End;

            objEspGer.fltBasIcm := fStrToFloat(frmFatDadosFiscaisImpostos.edtBasIcm.Text);
            objEspGer.fltTotIcm := fStrToFloat(frmFatDadosFiscaisImpostos.edtValIcm.Text);
             objEspGer.fltBasIpi := fStrToFloat(frmFatDadosFiscaisImpostos.edtBasIpi.Text);
             objEspGer.fltTotIpi := fStrToFloat(frmFatDadosFiscaisImpostos.edtValIpi.Text);
            objEspGer.fltBasRet := fStrToFloat(frmFatDadosFiscaisImpostos.edtBasRet.Text);
            objEspGer.fltTotRet := fStrToFloat(frmFatDadosFiscaisImpostos.edtValRet.Text);
            objEspGer.fltTotCBS := fStrToFloat(frmFatDadosFiscaisImpostos.edtTotCBS.Text);
            objEspGer.fltTotIBS := fStrToFloat(frmFatDadosFiscaisImpostos.edtTotIBS.Text);
            objEspGer.fltTotIS  := fStrToFloat(frmFatDadosFiscaisImpostos.edtTotIS.Text);
            objEspGer.fltBasFcpST := fStrToFloat(frmFatDadosFiscaisImpostos.edtBasFCPST.Text);
            objEspGer.fltTotFcpST := fStrToFloat(frmFatDadosFiscaisImpostos.edtValFCPST.Text);

            objEspGer.strClaFis := cdsImpostosDigitadosItens.FieldByName('ITE_CLAFIS').AsString;

            objEspGer.fltVlrCon := objEspGer.fltTotPro +
                                   objEspGer.fltTotIpi +
                                   objEspGer.fltTotRet +
                                   objEspGer.fltTotCBS +
                                   objEspGer.fltTotIBS +
                                   objEspGer.fltTotIS +
                                   objEspGer.fltDesAce +
                                   objEspGer.fltTotFre -
                                   objEspGer.fltDesEsp -
                                   fltVrdIcm;

            if frmFatDadosFiscaisImpostos.pnlMensagem.visible then
            begin
              objEspGer.strMen001 := frmFatDadosFiscaisImpostos.fraDadosFechamentoVendaMSGFatFrame.edtMens01.Text;
              objEspGer.strMen002 := frmFatDadosFiscaisImpostos.fraDadosFechamentoVendaMSGFatFrame.edtMens02.Text;
              objEspGer.strMen003 := frmFatDadosFiscaisImpostos.fraDadosFechamentoVendaMSGFatFrame.edtMens03.Text;
              objEspGer.strMen004 := frmFatDadosFiscaisImpostos.fraDadosFechamentoVendaMSGFatFrame.edtMens04.Text;
              objEspGer.strMen005 := frmFatDadosFiscaisImpostos.fraDadosFechamentoVendaMSGFatFrame.edtMens05.Text;
            end;

            objEspGer.fSalva;

            cxProgress.pStep;

            fCommit;
          End;
        Except
          On E : Exception Do
          Begin
            fRollback;
            Result := False;
            pMensagensErro(E.Message, '');
          End;
        End;

        FreeAndNil(cdsImpostosDigitadosItens);

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;

  Finally
    FreeAndNil(cdsItens);
    pFreeAndNil(frmFatDadosFiscaisImpostos);
    pSetEstado(TenuEstado.Pronto);

    if Assigned(objEspGer) Then
      FreeAndNil(objEspGer);

    If not fEmptyStr(strIncEdit)  Then
    Begin
      fLock_Unlock('ESPGER_MANUT_' + strIncEdit, False, False);
      If blnPrint Then
      Begin
        pCarregaDados;
        If cdsDocumentos.Locate('AUTINC', strIncEdit, []) Then
        Begin
          strOpcDoc := IIF(cdsDocumentos.FieldByName('TIPESP').AsString = 'O', 'OF', 'GF');
          TfrmEspelhoImpressao.pImprimeEspelho(strOpcDoc, cdsDocumentos.FieldByName('CODEMP').AsString, cdsDocumentos.FieldByName('NUMESP').AsString);
        End;
      End;
    End;

  End;
end;

function TfrmConfirmaEspelho.fObterCodFab(pstrIncGad: String): String;
Var
  qryAux: TUniQuery;
begin
  Result := EmptyStr;

  if fEmptyStr(pstrIncGad) then
    Exit;

  qryAux := fCriaQuery(Self);
  Try
    QryAux.Close;
    QryAux.Sql.Add(' SELECT GAD_CODFAB FROM MOVGAD WHERE AUTOINCREM = :INCGAD ');
    QryAux.ParamByName('INCGAD').AsString := pstrIncGad;
    Try
      QryAux.Open;
      if QryAux.IsEmpty then
        Exit;

      QryAux.First;
      Result := QryAux.Fields[0].AsString;
    Except
      On E: Exception do
      begin
        pMensagensErro(E.Message, '[TfrmConfirmaEspelho.fObterCodFab]');
      end
    End;
  Finally
    FreeAndNil(QryAux);
  End;
end;

procedure TfrmConfirmaEspelho.pManutencaoFrete();
Var
  frmAlteraFreteEspelho : TfrmAlteraFreteEspelho;
  intRecNo : integer;
begin
  pSetEstado(TenuEstado.Editando);
  pCriarFormularios(TfrmAlteraFreteEspelho, frmAlteraFreteEspelho);
  Try
    frmAlteraFreteEspelho.strAutIncEspelho := cdsDocumentos.FieldByName('AUTINC').AsString;
    frmAlteraFreteEspelho.ShowModal;
  Finally
    pSetEstado(TenuEstado.Pronto);
    pFreeAndNil(frmAlteraFreteEspelho);

    If (Not cdsDocumentos.IsEmpty) Then
    Begin
      {cdsDocumentos.Refresh;}

      intRecNo := cdsDocumentos.RecNo;
      pCarregaDados;
      cdsDocumentos.RecNo := intRecNo;
    End;
  End;
end;

procedure TfrmConfirmaEspelho.pCarregaDadosFornecedor(strCodFor:String);
  Var
    strSQL: String;
    qryDados: TUniQuery;
begin
  qryDados := fCriaQuery(Self);

  Try
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   FOR_CODCID, ';
    strSQL := strSQL + '   FOR_I_E_S_, ';
    strSQL := strSQL + '   FOR_CODATI, ';
    strSQL := strSQL + '   FOR_CODFOR, ';
    strSQL := strSQL + '   FOR_CODCID, ';
    strSQL := strSQL + '   FOR_NOMFOR, ';
    strSQL := strSQL + '   FOR_ENDERE, ';
    strSQL := strSQL + '   FOR_ENDNUM, ';
    strSQL := strSQL + '   FOR_ENDCOM, ';
    strSQL := strSQL + '   FOR_BAIRRO, ';
    strSQL := strSQL + '   FOR_C_E_P_, ';
    strSQL := strSQL + '   FOR_CODCID, ';
    strSQL := strSQL + '   FOR_FONE01, ';
    strSQL := strSQL + '   FOR_C_G_C_, ';
    strSQL := strSQL + '   FOR_CGCCPF, ';
    strSQL := strSQL + '   FOR_CGCCPF, ';
    strSQL := strSQL + '   FOR_EMAIL_  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADFOR      ';
    strSQL := strSQL + ' WHERE         ';
    strSQL := strSQL + '   FOR_CODFOR = :CODFOR ';

    With qryDados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
      Open;
    End;

    fatVenda.strCodForTe := strCodFor;
    fatVenda.strCliEst := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliIes := qryDados.FieldByName('FOR_I_E_S_').AsString;
    fatVenda.strCliAti := qryDados.FieldByName('FOR_CODATI').AsString;
    fatVenda.strCodCli := qryDados.FieldByName('FOR_CODFOR').AsString;
    fatVenda.strCodVen := strLoginUsuarioLogado;
    fatVenda.strCliEst := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliNom := qryDados.FieldByName('FOR_NOMFOR').AsString;
    fatVenda.strCliOri := qryDados.FieldByName('FOR_NOMFOR').AsString;
    fatVenda.strCliEnd := qryDados.FieldByName('FOR_ENDERE').AsString;
    fatVenda.strCliNum := qryDados.FieldByName('FOR_ENDNUM').AsString;
    fatVenda.strCliCom := qryDados.FieldByName('FOR_ENDCOM').AsString;
    fatVenda.strCliBai := qryDados.FieldByName('FOR_BAIRRO').AsString;
    fatVenda.strCliCep := qryDados.FieldByName('FOR_C_E_P_').AsString;
    fatVenda.strCodCid := qryDados.FieldByName('FOR_CODCID').AsString;
    fatVenda.strCliCid := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 0);
    fatVenda.strCliEst := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliTel := qryDados.FieldByName('FOR_FONE01').AsString;
    fatVenda.strCliCgc := qryDados.FieldByName('FOR_C_G_C_').AsString;
    fatVenda.intCgcCpf := qryDados.FieldByName('FOR_CGCCPF').AsInteger;
    fatVenda.strCliIes := qryDados.FieldByName('FOR_I_E_S_').AsString;
    fatVenda.strCliEma := qryDados.FieldByName('FOR_EMAIL_').AsString;
    fatVenda.strCliEm2 := '';
    fatVenda.strCliCon := 'N';

    qryDados.Close;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCarregaDadosFornecedor]');
      FreeAndNil(qryDados);
      Exit;
    End;
  End;

  FreeAndNil(qryDados);
end;

function TfrmConfirmaEspelho.fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
  Var
    strSQL: String;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_PESOIT, ';
    strSQL := strSQL + '  I.ITE_PESLIQ, ';
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  I.ITE_DESITE, ';
    strSQL := strSQL + '  I.ITE_DESFAB, ';
    strSQL := strSQL + '  I.ITE_COMLUB, ';
    strSQL := strSQL + '  I.ITE_CLAIPI, ';
    strSQL := strSQL + '  I.ITE_CODFAB, ';
    strSQL := strSQL + '  I.ITE_CODBAR, ';
    strSQL := strSQL + '  G.ITE_PRECOM, ';
    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE7, ';
    strSQL := strSQL + '  G.ITE_PREULT, ';
    strSQL := strSQL + '  G.ITE_IMPULT, ';
    strSQL := strSQL + '  G.ITE_QTDUCO, ';
    strSQL := strSQL + '  G.ITE_IPISAI, ';
    strSQL := strSQL + '  G.ITE_DESMAX, ';
    strSQL := strSQL + '  G.ITE_SALDOS, ';
    strSQL := strSQL + '  G.ITE_PREMED, ';
    strSQL := strSQL + '  G.ITE_COMVAR, ';
    strSQL := strSQL + '  G.ITE_COMATA, ';
    strSQL := strSQL + '  G.ITE_COMDIS, ';
    strSQL := strSQL + '  G.ITE_MARMIN, ';
    strSQL := strSQL + '  G.ITE_MARMSG, ';
    strSQL := strSQL + '  G.ITE_MARMGE, ';

    strSQL := strSQL + '  G.ITE_DESMVM, ';
    strSQL := strSQL + '  G.ITE_DESMSM, ';
    strSQL := strSQL + '  G.ITE_DESMGM, ';

    strSQL := strSQL + '  G.ITE_MARMMV, ';
    strSQL := strSQL + '  G.ITE_MARMMS, ';
    strSQL := strSQL + '  G.ITE_MARMMG, ';

    strSQL := strSQL + '  G.ITE_IPIENT, ';
    strSQL := strSQL + '  G.ITE_FREENT, ';
    strSQL := strSQL + '  G.ITE_QTPPRO, ';
    strSQL := strSQL + '  A.ABF_CODABF, ';
    strSQL := strSQL + '  M.MAR_DESMAR, ';
    strSQL := strSQL + '  I.ITE_OBRCPF, ';
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  U.UNI_CODUNI, ';
    strSQL := strSQL + '  U.UNI_DESUNI, ';
    strSQL := strSQL + '  I.ITE_CODMAR, ';
    strSQL := strSQL + '  I.ITE_REFERE, ';
    strSQL := strSQL + '  G.ITE_PRECUS, ';
    strSQL := strSQL + '  G.ITE_DESF01, ';
    strSQL := strSQL + '  G.ITE_DESF02, ';
    strSQL := strSQL + '  G.ITE_DESF03, ';
    strSQL := strSQL + '  G.ITE_DESF04, ';
    strSQL := strSQL + '  G.ITE_DESF05, ';
    strSQL := strSQL + '  G.ITE_DESF06, ';
    strSQL := strSQL + '  G.ITE_PREDOL, ';

    strSQL := strSQL + '  IFNULL(  '+
                          ' (SELECT LOT_NUMLOT FROM CADLOT '+
                          '        WHERE '+
                          '            LOT_GARPRI = "S" '+
                          '        AND LOT_STATUS = "S" '+
                          '        AND LOT_CODITE = :CODITE '+
                          '        AND LOT_CODEMP = :CODEMP '+
                          ' ),"") AS ITE_NUMLOT, ';

    If fCfgSis('IMPDIG') = '1' Then
      strSQL := strSQL + '  I.ITE_IMPDIR  '
    Else
      strSQL := strSQL + '  G.ITE_IMPDIR  ';

    strSQL := strSQL + 'FROM ITEGER G ';
    strSQL := strSQL + '  INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';
    strSQL := strSQL + '  LEFT  JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR ';
    strSQL := strSQL + '  LEFT  JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';

    If fCfgSis('TIPABF', VarString) = '1' Then
      strSQL := strSQL + '  INNER JOIN ABFICM A ON A.ABF_CODABF = I.ITE_CODABF '
    Else
      strSQL := strSQL + '  INNER JOIN ABFICM A ON A.ABF_CODABF = G.ITE_CODABF ';

    strSQL := strSQL + ' WHERE G.ITE_CODITE = :CODITE ';
    strSQL := strSQL + '   AND G.ITE_CODEMP = :CODEMP ';
    strSQL := strSQL + '   AND A.ABF_ESTADO = :ESTADO ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
      Open;
    End;

    Result := TRUE;

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmGarantiaEnvFornecedor.fGetItem]');
    End;

  End;

end;

function TfrmConfirmaEspelho.fIncluiItens: Boolean;
  Var
    blnFabNFE   : Boolean;
    strCodFab   : String;
    qryGenIte   : TUniQuery;
    qryEspDet   : TUniQuery;
    recForTin   : TForTin;
    recMadeira  : TDadosMadeira;
    strDesNes   : String;
    strCampoDocDev, strCampoEspDev, strCampoEmpDev: String;

  function fSubstituido(strCodFis: String): Boolean;
  begin
    Result := (Pos(strCodFis, CST_SUBSTITUICAO + CST_ANTECIPACAO_ICMS) > 0);
  end;

  function fTributado(strCodFis: String): Boolean;
  begin
    Result := (Not fSubstituido(strCodFis));
  end;

Begin
  blnFABNFE := fCfgSis('FABNFE', varString) = 'S';
  Try
    qryGenIte := fCriaQuery;
    qryEspDet := fCriaQuery;

    With qryEspDet, SQL Do
    Begin
      Close;
      Clear;

      Add(' SELECT E.DET_CODITE,                               ');
      Add('        E.DET_DESCRI,                               ');
      Add('        E.DET_QTDITE,                               ');
      Add('        E.DET_UNITAR,                               ');
      Add('        E.DET_CODFIS,                               ');
      Add('        E.DET_TOTITE,                               ');
      Add('        E.DET_BASICM,                               ');
      Add('        E.DET_ALQICM,                               ');
      Add('        E.DET_VALICM,                               ');
      Add('        E.DET_BASIPI,                               ');
      Add('        E.DET_ALQIPI,                               ');
      Add('        E.DET_VALIPI,                               ');
      Add('        E.DET_BASRET,                               ');
      Add('        E.DET_VALRET,                               ');
      Add('        E.DET_BASPIS,                               ');
      Add('        E.DET_ALQPIS,                               ');
      Add('        E.DET_VALPIS,                               ');
      Add('        E.DET_CSTPIS,                               ');
      Add('        E.DET_BASCOF,                               ');
      Add('        E.DET_ALQCOF,                               ');
      Add('        E.DET_VALCOF,                               ');
      Add('        E.DET_CSTCOF,                               ');
      Add('        E.DET_CLAFIS,                               ');
      Add('        E.DET_BASVRD,                               ');
      Add('        E.DET_VRDICM,                               ');
      Add('        E.DET_MTDICM,                               ');

      if blnFABNfe and
        (cdsDocumentos.FieldByName('TIPESP').AsString = 'G') then
      begin

        Add('      COALESCE(E.DET_SEQGAD,                      ');
        Add('               (SELECT EG.DEG_SEQGAD              ');
        Add('                FROM ESPDEG EG                    ');
        Add('                JOIN MOVGAD GD                    ');
        Add('                ON GD.AUTOINCREM = EG.DEG_SEQGAD  ');
        Add('                WHERE DEG_SEQGER = E.AUTOINCREM   ');
        Add('                LIMIT 1)) AS DET_SEQGAD,          ');
      end
      else
        Add('      E.DET_SEQGAD,                               ');

      Add('        E.DET_SEQDET,                               ');
      Add('        E.DET_DESCON,                               ');
      Add('        E.DET_DESESP,                               ');
      Add('        E.DET_UNIORI,                               ');
      Add('        E.DET_UNIDIG,                               ');
      Add('        E.DET_INCPIS,                               ');
      Add('        E.DET_CODABF,                               ');
      Add('        D.DET_NUMDOC AS DOCDEV,                     ');
      Add('        D.DET_CODEMP AS EMPDEV,                     ');
      Add('        D.DET_ESPDOC AS ESPDEV,                     ');
      Add('        D.DET_SERIE_ AS SERDEV,                     ');
      Add('        E.DET_NUMLOT,                               ');
      Add('        E.DET_DOCDEV AS DOCDEV_ESP,                 ');
      Add('        E.DET_EMPDEV AS EMPDEV_ESP,                 ');
      Add('        E.DET_ESPDEV AS ESPDEV_ESP,                 ');
      Add('        IFNULL(A.AGEITE,0) AS AGEITE                ');
      Add(' FROM ESPDET E                                      ');
      Add('  LEFT JOIN MOVDET D ON D.AUTOINCREM = E.DET_SEQDET ');

      ADD('  LEFT JOIN (SELECT ADC_NUMDOC, ADC_ESPDOC, ADC_CODEMP, ');
      Add('                    AIT_CODITE, COUNT(1) AS AGEITE ');
      Add('             FROM AGEDOC ');
      Add('             JOIN AGEITE ON AIT_SEQGER = ADC_SEQGER ');
      Add('             GROUP BY ADC_NUMDOC, ADC_ESPDOC, ADC_CODEMP, AIT_CODITE) A  ');
      Add('  ON A.ADC_NUMDOC = E.DET_DOCDEV AND A.ADC_ESPDOC = E.DET_ESPDEV ');
      Add('     AND A.ADC_CODEMP = E.DET_EMPDEV AND A.AIT_CODITE = E.DET_CODITE ');
      Add(' WHERE E.DET_SEQGER = :SEQGER                       ');

      ParamByName('SEQGER').AsString := cdsDocumentos.FieldByName('AUTINC').AsString;
      Open;

      First;

      While Not Eof Do
      Begin
        If (not fEmptyStr(FieldByName('DOCDEV').AsString)) Then
        Begin
          fatVenda.objItensNotaEspelho := TItensNotaEspelho.Create(fatVenda);
          fatVenda.blnDvComDta := True;
          Break;
        End;

        Next;
      End;

      First;

      If (cdsDocumentos.FieldByName('TIPESP').AsString = 'G') Then
      Begin
        fatVenda.strOpcDocTrue := 'NG';
        fatVenda.strOpcDoc     := 'GF';
        fatVenda.strClaFisEnvGarantia   := cdsDocumentos.FieldByName('CLAFIS').AsString;
        fatVenda.strClaFisEnvGarantiaST := cdsDocumentos.FieldByName('CLAFIS').AsString;
      End
      Else
      Begin
        fatVenda.strOpcDocTrue := 'OF';
        fatVenda.strOpcDoc     := 'OF';
      End;

      While Not Eof Do
      Begin
        If (cdsDocumentos.FieldByName('TIPESP').AsString = 'G') Then
        Begin
          If fTributado(FieldByName('DET_CODFIS').AsString) Then
            fatVenda.strClaFisEnvGarantia := FieldByName('DET_CLAFIS').AsString
          Else
            fatVenda.strClaFisEnvGarantiaST := FieldByName('DET_CLAFIS').AsString;
        End;

        fGetItem(qryGenIte,FieldByName('DET_CODITE').AsString);

        strDesNes := fPadR(qryGenIte.FieldByName('ITE_REFERE').AsString, 20) +
                     fStrZero(RightStr(FieldByName('DOCDEV').AsString, 9), 9) +
                     fStrZero(FieldByName('SERDEV').AsString, 3);



        if blnFABNFE and (cdsDocumentos.FieldByName('TIPESP').AsString = 'G') then
        begin
          strCodFab := fObterCodFab(qryEspDet.FieldByName('DET_SEQGAD').AsString);

          if fEmptyStr(strCodFab) then
            strCodFab := qryGenIte.FieldByName('ITE_CODFAB').AsString;
        end
        else
          strCodFab := qryGenIte.FieldByName('ITE_CODFAB').AsString;

        if (fatVenda.strOpcDoc = 'OF') AND (FieldByName('AGEITE').AsInteger > 0) then
        begin
          strCampoDocDev := 'DOCDEV_ESP';
          strCampoEspDev := 'ESPDEV_ESP';
          strCampoEmpDev := 'EMPDEV_ESP';
        end
        else begin
          strCampoDocDev := 'DOCDEV';
          strCampoEspDev := 'ESPDEV';
          strCampoEmpDev := 'EMPDEV';
        end;

        fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                             Nil,
                                             'NOR',
                                             qryGenIte.FieldByName('ITE_CODGRU').AsString,
                                             FieldByName('DET_CODITE').AsString,
                                             qryGenIte.FieldByName('ITE_DESITE').AsString,
                                             IIF(fEmptyStr(FieldByName('DET_DESCRI').AsString), qryGenIte.FieldByName('ITE_DESITE').AsString, FieldByName('DET_DESCRI').AsString),
                                             qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                             qryGenIte.FieldByName('UNI_CODUNI').AsString,
                                             qryGenIte.FieldByName('UNI_CODUNI').AsString,
                                             qryGenIte.FieldByName('ITE_CODMAR').AsString,

                                             cdsDocumentos.FieldByName('CODFOR').AsString,

                                             qryGenIte.FieldByName('ITE_REFERE').AsString,

                                             FieldByName('DET_UNIORI').AsFloat,  // fltUniOri
                                             FieldByName('DET_UNITAR').AsFloat,  // fltUniVis
                                             FieldByName('DET_UNITAR').AsFloat,  // fltUniTar
                                             0.0,
                                             0.0,
                                             FieldByName('DET_QTDITE').AsFloat,
                                             FieldByName('DET_TOTITE').AsFloat, // fltTotIte
                                             'S',
                                             qryGenIte.FieldByName('ITE_PRECUS').AsFloat,
                                             qryGenIte.FieldByName('ITE_PRECUS').AsFloat * FieldByName('DET_QTDITE').AsFloat, // fltTotCus
                                             qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                             FieldByName('DET_ALQIPI').AsFloat,
                                             qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE1').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE2').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE3').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE4').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE5').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE6').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE7').AsFloat,
                                             0.0,
                                             qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                             'N',
                                             qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                             qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                             qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                             FieldByName(strCampoDocDev ).AsString,
                                             FieldByName(strCampoEspDev ).AsString,
                                             FieldByName(strCampoEmpDev ).AsString,
                                             0,
                                             0,
                                             FieldByName('DET_SEQDET').AsString,
                                             qryGenIte.FieldByName('ITE_PREULT').AsFloat * FieldByName('DET_QTDITE').AsFloat,
                                             qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREMED').AsFloat,
                                             qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                             '',
                                             '',
                                             '',
                                             '',
                                             0,
                                             '',
                                             0,
                                             0,
                                             0.00,
                                             0.00,
                                             0.00,
                                             'N',
                                             '',
                                             0,
                                             0,
                                             FieldByName('DET_CODABF').AsString,
                                             qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                             qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                             'N',
                                             0,
                                             0,
                                             0,
                                             0,
                                             '',
                                             fatVenda.fRetPerComGrupo(qryGenIte.FieldByName('ITE_CODGRU').AsString),
                                             strCodFab,
                                             -1,
                                             0,
                                             '',
                                             '',
                                             '',
                                             qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                             qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                             qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                             fRetNomMarca(qryGenIte.FieldByName('ITE_CODMAR').AsString),
                                             '',
                                             0,
                                             0,
                                             '',
                                             '',
                                             '',
                                             0,
                                             strDesNes,
                                             '',
                                             '',
                                             qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                             FieldByName('DET_UNIDIG').AsFloat, // fltUniDig
                                             qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                             '',
                                             '',
                                             qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                             '',
                                             '',
                                             fRetSiglaUnidade(qryGenIte.FieldByName('UNI_CODUNI').AsString),
                                             0.00,
                                             RecNo,
                                             '',
                                             '',
                                             '',
                                             False,
                                             '',
                                             '',
                                             '',
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             '',
                                             '',
                                             '',
                                             '1',
                                             FieldByName('DET_ALQIPI').AsFloat,
                                             qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                             '',
                                             0.0,
                                             '',
                                             0.0,
                                             'R',
                                             '',
                                             'N',
                                             '',
                                             0,
                                             FieldByName('DET_QTDITE').AsFloat,
                                             0.0,
                                             0,
                                             qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                             '',
                                             0.00,
                                             0.00,
                                             0.00,
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             recForTin,
                                             '',
                                             '',
                                             IIF(cdsDocumentos.FieldByName('TIPESP').AsString <> 'G',
                                               IIF(not fEmptyStr(FieldByName('DET_NUMLOT').AsString),
                                                                 FieldByName('DET_NUMLOT').AsString,
                                                                 qryGenIte.FieldByName('ITE_NUMLOT').AsString),
                                               qryGenIte.FieldByName('ITE_NUMLOT').AsString),
                                             '',
                                             '',
                                             False,
                                             'N',
                                             'NOR',
                                             0,
                                             '',
                                             qryGenIte.FieldByName('ITE_CODBAR').AsString,
                                             '',
                                             0,
                                             0,
                                             0,
                                             '',
                                             1,
                                             True,
                                             '',
                                             '',
                                             '',
                                             0,
                                             qryGenIte.FieldByName('ITE_PRECUS').AsFloat, // fltCusIte
                                             '',
                                             '',
                                             recMadeira,
                                             qryGenIte.FieldByName('ITE_IMPULT').AsFloat * FieldByName('DET_QTDITE').AsFloat,
                                             0,
                                             0,
                                             FieldByName('DET_SEQGAD').AsString,
                                             0,
                                             '',
                                             '',
                                             0,
                                             0,
                                             '',
                                             '',
                                             0,
                                             '',
                                             'N',
                                             0,
                                             0,
                                             0,
                                             False,
                                             False,
                                             'N',
                                             '',
                                             0,
                                             0,
                                             '',
                                             'N',
                                             0,
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             0.00,
                                             '',
                                             '',
                                             '',
                                             'S',
                                             'N',
                                             '',
                                             '',
                                             '',
                                             '',
                                             False,
                                             -1,
                                             -1,
                                             'N',
                                             '',
                                             'N',
                                             0,
                                             0,
                                             0,
                                             '',
                                             0,
                                             0,
                                             0,
                                             '',
                                             0,
                                             0,
                                             0,
                                             '',
                                             '',
                                             0,
                                             0,
                                             0,
                                             False,
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             '',
                                             '',
                                             0,
                                             0,
                                             '',
                                             '',
                                             'N',
                                             'N',
                                             '',
                                             0,
                                             0,
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             0,
                                             0,
                                             0,
                                             qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                             qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                             qryGenIte.FieldByName('ITE_MARMMG').AsFloat);

        Next;

      End;

    End;

    Result := True;

    FreeAndNil(qryGenIte);
    FreeAndNil(qryEspDet);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmConfirmaEspelho.fIncluiItens]');
    End;
  End;

end;

function TfrmConfirmaEspelho.fLiberaReservaDeEstoque(const AutIncVen: String) : Boolean;
Var
    qryFatDor : TUniQuery;
    qryMovDetDev: TUniQuery;
    qryAuxili : TUniQuery;
    qryItens : TUniQuery;
    qryFatDorReserva: TUniQuery;
    qryExtDorReserva: TUniQuery;
    strIncFgo : String;
    fltQtdEnvBai : Double;
    blnSemWms: Boolean;
    objControlaReservaDevolucaoVenda: TControlaReservaDevolucaoVenda;

Begin
  (*  Essa rotina é passada como parametro para o faturamento, para ser executada na mesma transação da venda,
      pois caso der algum erro, todo o processo é abortado e executa o Rollback ! *)
  Try
    Result := True;
    qryFatDor := fCriaQuery;
    qryFatDorReserva := fCriaQuery;
    qryExtDorReserva := fCriaQuery;
    qryMovDetDev := fCriaQuery;
    qryAuxili := fCriaQuery;
    qryItens  := fCriaQuery;
    objControlaReservaDevolucaoVenda := TControlaReservaDevolucaoVenda.Create(AutIncVen, '');
    objControlaReservaDevolucaoVenda.LimparItens;

    qryItens.Close;
    qryItens.SQL.clear;

    blnSemWms := ((Not fCfgSis('UTIWMS', VarBoolean) And fCfgSis('UDEVME', VarBoolean)));
    qryItens.SQL.Add(' SELECT ESPDET.DET_CODITE AS CODITE, ');
    qryItens.SQL.Add('     ESPDET.DET_QTDITE AS QTDENV, ');
    If Not blnSemWms then
    begin
      qryItens.SQL.Add('     R.AUTOINCREM AS RECINC, ');
      qryItens.SQL.Add('     T.AUTOINCREM AS INCAIT, ');
    End;
    qryItens.SQL.Add('     ESPDET.DET_SEQDET ');
    If blnSemWms then
      qryItens.SQL.Add('     ,D.DET_SEQGER');
    qryItens.SQL.Add(' FROM ');
    qryItens.SQL.Add('  ESPGER ');
    qryItens.SQL.Add('   INNER JOIN ESPDET    ON ESPDET.DET_SEQGER = ESPGER.AUTOINCREM ');
    If Not blnSemWms then
    begin
      qryItens.SQL.Add('   INNER JOIN AGEDOC G  ON ADC_NUMDOC = ESPDET.DET_DOCDEV AND ADC_CODFOR = GER_CODFOR AND ADC_CODEMP = ESPDET.DET_EMPDEV ');
      qryItens.SQL.Add('   INNER JOIN AGEREC R  ON G.ADC_SEQGER = R.AUTOINCREM  ');
      qryItens.SQL.Add('   INNER JOIN AGEITE T  ON R.AUTOINCREM = AIT_SEQGER AND AIT_CODITE = DET_CODITE ');
    End
    Else
      qryItens.SQL.Add('   INNER JOIN MOVDET D ON D.AUTOINCREM = ESPDET.DET_SEQDET ');

    qryItens.SQL.Add(' WHERE TRUE ');
    qryItens.SQL.Add(' AND GER_NUMESP = :NUMESP ');
    qryItens.SQL.Add(' AND GER_CODEMP = :CODEMP ');
    qryItens.SQL.Add(' AND GER_CODFOR = :CODFOR ');

    qryItens.ParamByName('NUMESP').AsString := cdsDocumentos.FieldByName('NUMESP').AsString;
    qryItens.ParamByName('CODEMP').AsString := cdsDocumentos.FieldByName('CODEMP').AsString;
    qryItens.ParamByName('CODFOR').AsString := cdsDocumentos.FieldByName('CODFOR').AsString;

    qryItens.Open;


    qryItens.First;
    Try
      While Not qryItens.Eof Do
      Begin
        If (qryItens.FieldByName('QTDENV').AsFloat > 0) Then
        Begin
          With qryFatDor, SQL Do
          Begin
            Close;
            Clear;


            If blnSemWms Then
            Begin
              add('SELECT FATDOR.* FROM EXTDOR');
              add(' INNER JOIN FATDOR ON  FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO');
              add(' WHERE FDO_AUTDET = :AUTINC');
              ParamByName('AUTINC').AsString := qryItens.FieldByName('DET_SEQDET').AsString;
            End
            Else
            Begin
              Add('SELECT FATDOR.* ');
              Add('FROM AGEDOC     ');
              Add('    INNER JOIN EXTGOR ON FGO_DOCEND = CONCAT(ADC_NUMDOC, ADC_ESPDOC, RPAD( ADC_SERIE_, 3, " " ), ADC_CODEMP, ADC_CODFOR, "F") ');
              Add('    INNER JOIN FATGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
              Add('    INNER JOIN FATDOR ON FDO_SEQGER = FATGOR.AUTOINCREM ');
              Add('WHERE ADC_SEQGER = :RECINC ');
              Add('  AND FDO_CODITE = :CODITE ');
              ParamByName('RECINC').AsString := qryItens.FieldByName('RECINC').AsString;
              ParamByName('CODITE').AsString := qryItens.FieldByName('CODITE').AsString;
            End;
            Open;
            //Se eh item que não tem enderecamento
            If blnSemWms and qryFatDor.IsEmpty then
            Begin
              strIncFgo := '';
              objControlaReservaDevolucaoVenda.IncFatGor := strIncFgo;
              objControlaReservaDevolucaoVenda.AdicionarItem('',
                                                             qryItens.FieldByName('DET_SEQDET').AsString,
                                                             qryItens.FieldByName('QTDENV').AsFloat);
            End
            Else
            Begin
              If Not IsEmpty Then
              Begin
                If blnSemWms then
                Begin
                  strIncFgo := FieldByName('FDO_SEQGER').AsString;

                  objControlaReservaDevolucaoVenda.IncFatGor := strIncFgo;
                  objControlaReservaDevolucaoVenda.AdicionarItem(qryFatDor.FieldByName('AUTOINCREM').AsString,
                                                                 qryItens.FieldByName('DET_SEQDET').AsString,
                                                                 qryItens.FieldByName('QTDENV').AsFloat);

                  TDevolucaoRetornaEstoque.fAtualizaReservaEnderecamento(qryFatDor.FieldByName('AUTOINCREM').AsString,
                                                                         qryItens.FieldByName('QTDENV').AsFloat);

                End
                Else
                Begin
                  fltQtdEnvBai := qryItens.FieldByName('QTDENV').AsFloat;

                  While (Not Eof) And (fltQtdEnvBai > 0) Do
                  Begin

                    //Se o que tem para endereçar é menor ou igual ao que vai devolver, pode apagar a FATDOR, se Apagou a fatDor Verifica se ainda tem intes no PEDIDO, se nao tiver apaga a FATGOR TBM;
                    If ((FieldByName('FDO_QTDITE').AsFloat - FieldByName('FDO_QTDBAI').AsFloat) <= fltQtdEnvBai) Then
                    Begin
                      fltQtdEnvBai := fltQtdEnvBai - (FieldByName('FDO_QTDITE').AsFloat - FieldByName('FDO_QTDBAI').AsFloat);

                      fVerificaIntegridade(Self.ClassName, 'FATDOR', qryFatDor, True, False, 'DEVOLUÇÃO DE MERCADORIAS - PRÉ NOTA');
                      strIncFgo := FieldByName('FDO_SEQGER').AsString;

                      qryAuxili.Close;
                      qryAuxili.SQL.Clear;
                      qryAuxili.SQL.Add(' DELETE FROM FATDOR WHERE AUTOINCREM = :AUTINC ');
                      qryAuxili.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
                      qryAuxili.ExecSQL;


                      qryAuxili.Close;
                      qryAuxili.SQL.Clear;
                      qryAuxili.SQL.Add('SELECT COUNT(0) AS QTD FROM FATDOR WHERE FDO_SEQGER = :SEQGER ');
                      qryAuxili.ParamByName('SEQGER').AsString := strIncFgo;
                      qryAuxili.Open;

                      //Se nao tem mais itens no Pedido, pode apagar a ExtGor E FatGor
                      If (qryAuxili.FieldByName('QTD').AsInteger = 0) Then
                      Begin
                        qryAuxili.Close;
                        qryAuxili.SQL.Clear;
                        qryAuxili.SQL.Add('SELECT * FROM EXTGOR WHERE FGO_SEQFGO = :SEQFGO ');
                        qryAuxili.ParamByName('SEQFGO').AsString := strIncFgo;
                        qryAuxili.Open;

                        fVerificaIntegridade(Self.ClassName, 'EXTGOR', qryAuxili, True, False, 'DEVOLUÇÃO DE MERCADORIAS - PRÉ NOTA');

                        qryAuxili.Delete;

                        qryAuxili.Close;
                        qryAuxili.SQL.Clear;
                        qryAuxili.SQL.Add('SELECT * FROM FATGOR WHERE AUTOINCREM = :AUTINC');
                        qryAuxili.ParamByName('AUTINC').AsString := strIncFgo;
                        qryAuxili.Open;

                        fVerificaIntegridade(Self.ClassName, 'FATGOR', qryAuxili, True, False, 'DEVOLUÇÃO DE MERCADORIAS - PRÉ NOTA');

                        qryAuxili.Delete;
                      End;

                    End
                    Else
                    // Se nao for deletar a FATDOR Apenas baixa a Qtde que foi Devolvida
                    Begin
                      Edit;
                      FieldByName('FDO_QTDBAI').AsFloat := FieldByName('FDO_QTDBAI').AsFloat + qryItens.FieldByName('QTDENV').AsFloat;
                      Post;
                      fltQtdEnvBai := fltQtdEnvBai - qryItens.FieldByName('QTDENV').AsFloat;
                    End;
                    Next;
                  End;

                  //Marca a DetEle como diferença já devolvida.
                  Close;
                  If Not blnSemWms then
                  begin
                    Clear;
                    Add(' UPDATE AGEITE SET AIT_QTDDEV = IFNULL(AIT_QTDDEV,0) + :QTDENV WHERE AUTOINCREM = :AUTINC');
                    ParamByName('AUTINC').AsString := qryItens.FieldByName('INCAIT').AsString;
                    ParamByName('QTDENV').AsFloat  := qryItens.FieldByName('QTDENV').AsFloat;
                    ExecSQL;

                    qryMovDetDev.Close;
                    qryMovDetDev.Sql.Clear;
                    qryMovDetDev.Sql.Add(' SELECT DET_SEQGER ');
                    qryMovDetDev.Sql.Add(' FROM AGEITE ');
                    qryMovDetDev.Sql.Add(' JOIN AGEDOC ON ADC_SEQGER = AIT_SEQGER ');
                    qryMovDetDev.Sql.Add(' JOIN MOVDET ON DET_DOCDEV = ADC_NUMDOC AND DET_ESPDEV = ADC_ESPDOC AND DET_EMPDEV =  ADC_CODEMP  AND DET_CODITE = AIT_CODITE ');
                    qryMovDetDev.Sql.Add(' WHERE AGEITE.AUTOINCREM = :AUTINC ');
                    qryMovDetDev.Sql.Add(' GROUP BY DET_SEQGER ');

                    qryMovDetDev.ParamByName('AUTINC').AsString := qryItens.FieldByName('INCAIT').AsString;
                    qryMovDetDev.Open;

                    If Not qryMovDetDev.IsEmpty Then
                    Begin
                      qryMovDetDev.First;
                      While Not qryMovDetDev.Eof do
                      Begin
                        Close;
                        Clear;
                        Add(' UPDATE AUXMOV SET AUX_DEVWMS = "S" ');
                        Add(' WHERE AUX_SEQGER = :AUTINC_SEQGER ');
                        ParamByName('AUTINC_SEQGER').AsString := qryMovDetDev.FieldByName('DET_SEQGER').AsString;
                        ExecSQL;
                        qryMovDetDev.Next;
                      End;
                    End;
                  End;
                End;
              End;
            End;
          End;
          If blnSemWms Then
          begin
            If Not TDevolucaoRetornaEstoque.fnsereDevDigitado(qryItens.FieldByName('DET_SEQGER').AsString,
                                                              qryItens.FieldByName('DET_SEQDET').AsString,
                                                              '',
                                                              qryItens.FieldByName('QTDENV').AsFloat) Then
            Begin
              Result := False;
              Exit;
            End;
          end;
        End;

        qryItens.Next;
      End;

      If blnSemWms Then
        If objControlaReservaDevolucaoVenda.Count > 0 Then
          objControlaReservaDevolucaoVenda.PersistirItens;

    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmEntConferPreNotaWMSDevolucao.fLiberaReservaDeEstoque');
      End;

    End;

  Finally
    FreeAndNil(qryFatDor);
    FreeAndNil(qryAuxili);
    FreeAndNil(qryItens);
    FreeAndNil(qryFatDorReserva);
    FreeAndNil(qryExtDorReserva);
    FreeAndNil(qryMovDetDev);
    FreeAndNil(objControlaReservaDevolucaoVenda);
  End;


end;

function TfrmConfirmaEspelho.fEmitirNF:Boolean;
  Var
    cdsItens : TZClient;
    qryCadIte : TUniQuery;
    strNumRem: String;
    strItens: String;
Begin
  Try
    pSetEstado(TenuEstado.Confirmando);
    Result := True;
    pCriarFormularios(TfrmFatDadosFiscaisImpostos, frmFatDadosFiscaisImpostos);

    If fCarregaEspelhoFatVendas Then
    Begin
      //Carrega os valores Digitados na ESPDET.
      cdsItens := TZClient.Create(nil);
      With cdsItens.qryQuery, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT * FROM ESPDET WHERE DET_SEQGER = :SEQGER ');
        ParamByName('SEQGER').AsString := cdsDocumentos.FieldByName('AUTINC').AsString;
        cdsItens.fAbreClient(True, 'TfrmConfirmaEspelho.mnuManFisClick');
      End;

      qryCadIte := fCriaQuery;
      With qryCadIte, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT ITE_DESITE, ');
        Add('        ITE_REFERE, ');
        Add('        ITE_CLAIPI, ');
        Add('        UNI_SIGUNI  ');
        Add(' FROM CADITE        ');
        Add('   LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ');
        Add(' WHERE ITE_CODITE = :CODITE ');
      End;

      frmFatDadosFiscaisImpostos.blnConfirmacaoEspelho := True;
      frmFatDadosFiscaisImpostos.strCodigoFornecedor   := cdsDocumentos.FieldByName('CODFOR').AsString;
      frmFatDadosFiscaisImpostos.blnNotaFornecedor     := True;
      frmFatDadosFiscaisImpostos.blnIcmsDesonerado     := True;
      frmFatDadosFiscaisImpostos.blnTrocaCFOP          := True;

      frmFatDadosFiscaisImpostos.strCliOrg := 'N';
      frmFatDadosFiscaisImpostos.strZonFra := 'N';

      strItens := EmptyStr;
      strNumRem := EmptyStr;

      If (cdsDocumentos.FieldByName('TIP_FC').AsString = 'F') And
         (cdsDocumentos.FieldByName('NATOPE').AsString = 'OUTRAS SAIDAS') And
         (Not fEmptyStr(cdsDocumentos.FieldByName('NUMREM').AsString)) Then
      Begin
        strNumRem := cdsDocumentos.FieldByName('NUMREM').AsString;
      End;

      cdsItens.First;

      While (not cdsItens.Eof) Do
      Begin
        qryCadIte.Close;
        qryCadIte.ParamByName('CODITE').AsString := cdsItens.FieldByName('DET_CODITE').AsString;
        qryCadIte.Open;

        frmFatDadosFiscaisImpostos.pAdicionaRegistro(cdsItens.RecNo,                               //fatVenda.arrMatItens[intCont].intAutInc,
                                                     cdsItens.FieldByName('DET_CODITE').AsString,  //fatVenda.arrMatItens[intCont].strCodIte,
                                                     VS_strCodEmp,                                 //fatVenda.arrMatItens[intCont].strEmpIte,
                                                     IIF(fEmptyStr(cdsItens.FieldByName('DET_DESCRI').AsString),qryCadIte.FieldByName('ITE_DESITE').AsString, cdsItens.FieldByName('DET_DESCRI').AsString), //fatVenda.arrMatItens[intCont].strDesIte,
                                                     qryCadIte.FieldByName('ITE_REFERE').AsString, //fatVenda.arrMatItens[intCont].strRefere,
                                                     qryCadIte.FieldByName('UNI_SIGUNI').AsString, //fatVenda.arrMatItens[intCont].strSigUni,
                                                     cdsItens.FieldByName('DET_CODFIS').AsString,  //fatVenda.arrMatItens[intCont].strCodFis,
                                                     qryCadIte.FieldByName('ITE_CLAIPI').AsString, //fatVenda.arrMatItens[intCont].strClaIpi,
                                                     cdsItens.FieldByName('DET_CODFIS').AsString,  //fatVenda.arrMatItens[intCont].strFisAnt,
                                                     cdsItens.FieldByName('DET_CODABF').AsString,   //fatVenda.arrMatItens[intCont].strCodAbf,
                                                     cdsItens.FieldByName('DET_QTDITE').AsFloat,
                                                     cdsItens.FieldByName('DET_TOTITE').AsFloat -
                                                     cdsItens.FieldByName('DET_DESESP').AsFloat,   //fatVenda.arrMatItens[intCont].fltTotIte - fatVenda.arrMatItens[intCont].fltDesEsp,
                                                     cdsItens.FieldByName('DET_BASICM').AsFloat,   //fatVenda.arrMatItens[intCont].fltBasIcm,
                                                     cdsItens.FieldByName('DET_ALQICM').AsFloat,   //fatVenda.arrMatItens[intCont].fltAlqIcm,
                                                     cdsItens.FieldByName('DET_VALICM').AsFloat,   //fatVenda.arrMatItens[intCont].fltValIcm,
                                                     cdsItens.FieldByName('DET_BASIPI').AsFloat,   //fatVenda.arrMatItens[intCont].fltBasIpi,
                                                     cdsItens.FieldByName('DET_ALQIPI').AsFloat,   //fatVenda.arrMatItens[intCont].fltAlqIpi,
                                                     cdsItens.FieldByName('DET_VALIPI').AsFloat,   //fatVenda.arrMatItens[intCont].fltValipi,
                                                     cdsItens.FieldByName('DET_BASRET').AsFloat,   //fatVenda.arrMatItens[intCont].fltBasRet,
                                                     cdsItens.FieldByName('DET_VALRET').AsFloat,   //fatVenda.arrMatItens[intCont].fltValRet,
                                                     cdsItens.FieldByName('DET_ALQPIS').AsFloat,   //fatVenda.arrMatItens[intCont].fltAlqPis,
                                                     cdsItens.FieldByName('DET_BASPIS').AsFloat,   //fatVenda.arrMatItens[intCont].fltBasPis,
                                                     cdsItens.FieldByName('DET_VALPIS').AsFloat,   //fatVenda.arrMatItens[intCont].fltValPis,
                                                     cdsItens.FieldByName('DET_ALQCOF').AsFloat,   //fatVenda.arrMatItens[intCont].fltAlqCof,
                                                     cdsItens.FieldByName('DET_BASCOF').AsFloat,   //fatVenda.arrMatItens[intCont].fltBasCof,
                                                     cdsItens.FieldByName('DET_VALCOF').AsFloat,   //fatVenda.arrMatItens[intCont].fltValCof,

                                                     cdsItens.FieldByName('DET_BFCPST').AsFloat,   // BASFCP
                                                     cdsItens.FieldByName('DET_PFCPST').AsFloat,   // PERFCP
                                                     cdsItens.FieldByName('DET_VFCPST').AsFloat,   // VALFCP

                                                     cdsItens.FieldByName('DET_BASFCP').AsFloat,  // BASFCP
                                                     cdsItens.FieldByName('DET_PERFCP').AsFloat,  // PERFCP
                                                     cdsItens.FieldByName('DET_VALFCP').AsFloat,  // VALFCP

                                                     cdsItens.FieldByName('DET_CLAFIS').AsString,  //edtClaFis.Text,
                                                     cdsItens.FieldByName('DET_INCPIS').AsString,  //fatVenda.arrMatItens[intCont].strIncPis,
                                                     cdsItens.FieldByName('DET_CSTPIS').AsString,  //fatVenda.arrMatItens[intCont].strCstPis,
                                                     cdsItens.FieldByName('DET_CSTCOF').AsString,  //fatVenda.arrMatItens[intCont].strCstCof,
                                                     cdsItens.FieldByName('DET_BASVRD').AsFloat,   //fatVenda.arrMatItens[intCont].fltBasVrd,
                                                     cdsItens.FieldByName('DET_VRDICM').AsFloat,   //fatVenda.arrMatItens[intCont].fltVrdIcm,
                                                     cdsItens.FieldByName('DET_MTDICM').AsString,  //fatVenda.arrMatItens[intCont].strMtdIcm);
                                                     cdsItens.FieldByName('AUTOINCREM').AsString,  //strAutInc
                                                     cdsDocumentos.FieldByName('TIPESP').AsString, //strGarant
                                                     '',
                                                     '',
                                                     '',
                                                     cdsItens.FieldByName('DET_VALIVA').AsFloat,  // fatVenda.arrMatItens[intCont].fltValIva
                                                     cdsItens.FieldByName('DET_ALQRET').AsFloat,  // fatVenda.arrMatItens[intCont].fltAlqRet
                                                     cdsItens.FieldByName('DET_PERRED').AsFloat,  // fatVenda.arrMatItens[intCont].fltPerRed
                                                     cdsItens.FieldByName('DET_PEBAST').AsFloat, // fatVenda.arrMatItens[intCont].fltPeBaST
                                                     cdsItens.FieldByName('DET_VALCBS').AsFloat,
                                                     cdsItens.FieldByName('DET_VALIBS').AsFloat,
                                                     cdsItens.FieldByName('DET_VAL_IS').AsFloat);

        If Not fEmptyStr(strNumRem) Then
        Begin
          pIncrementaListaStr(cdsItens.FieldByName('DET_CODITE').AsString, strItens, True);
        End;

        cdsItens.Next;
      End;

      Try
        pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);

        frmFatDadosFiscais.fraDadosFechamentoVendaTransportadoraFrame.edtNomTra.Text := fRetNomTransportadora(fatVenda.strCodTra);
        frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text         := fatVenda.strClafis;
        //frmFatDadosFiscais.edtDesCla.Text    := fatVenda.strDesCla;
        frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
        //frmFatDadosFiscais.edtDesCla.Enabled := False;
        frmFatDadosFiscais.blnConfirmacaoEspelho := True;
        frmFatDadosFiscais.fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Enabled := False;
        frmFatDadosFiscais.fraDadosFechamentoVendaTransportadoraFrame.cmbTipFre.Enabled := False;
        frmFatDadosFiscais.blnForcaEdiBas    := True;
        If cdsDocumentos.FieldByName('ENTSIM').AsString = 'S' Then
        Begin
          if fFornecedorFilial(cdsDocumentos.FieldByName('CODFOR').AsString) Then
          Begin
            fatVenda.blnCliFil   := True;
            fatVenda.strCodForTe := cdsDocumentos.FieldByName('CODFOR').AsString;
            fatVenda.strTEPPRO   := fGetTEPPRO(VS_strCodEmp, cdsDocumentos.FieldByName('CODFOR').AsString, True);
            fatVenda.strTEPREV   := fGetTEPREV(VS_strCodEmp, cdsDocumentos.FieldByName('CODFOR').AsString, True);
          End;
        End;
        fatVenda.strEspTra := cdsDocumentos.FieldByName('ESPECI').AsString;
        fatVenda.strMarTra := cdsDocumentos.FieldByName('MARCA_').AsString;
        fatVenda.strNumera := cdsDocumentos.FieldByName('NUMERA').AsString;
        fatVenda.strPlaFat := cdsDocumentos.FieldByName('PLAFAT').AsString;
        fatVenda.intQtdTra := cdsDocumentos.FieldByName('VOLUME').AsInteger;
        fatVenda.fltPesBru := cdsDocumentos.FieldByName('PESBRU').AsFloat;
        fatVenda.fltPesLiq := cdsDocumentos.FieldByName('PESLIQ').AsFloat;

        frmFatDadosFiscais.fatVenda := fatVenda;
        frmFatDadosFiscais.blnPodeCancelar := True;

        frmFatDadosFiscais.strDesAceAnt := frmFatDadosFiscais.fraDadosFechamentoVendaTransportadoraFrame.edtDesAce.Text;
        frmFatDadosFiscais.strValFreAnt := frmFatDadosFiscais.fraDadosFechamentoVendaTransportadoraFrame.edtValFre.Text;
        frmFatDadosFiscais.strClaFisAnt := frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text;

        frmFatDadosFiscais.cdsImpostosDigitadosItens := TUniClientDataSet.Create(Self);
        frmFatDadosFiscais.cdsImpostosDigitadosItens.Data := frmFatDadosFiscaisImpostos.cdsItens.Data;

        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtBasIcm.Text := frmFatDadosFiscaisImpostos.edtBasIcm.Text;
        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtValIcm.Text := frmFatDadosFiscaisImpostos.edtValIcm.Text;
        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtBasIpi.Text := frmFatDadosFiscaisImpostos.edtBasIpi.Text;
        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtValIpi.Text := frmFatDadosFiscaisImpostos.edtValIpi.Text;
        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtBasRet.Text := frmFatDadosFiscaisImpostos.edtBasRet.Text;
        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtValRet.Text := frmFatDadosFiscaisImpostos.edtValRet.Text;

        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtVlrFCP.Text   := frmFatDadosFiscaisImpostos.edtValFCP.Text;
        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtBasFcpST.Text := frmFatDadosFiscaisImpostos.edtBasFcpST.Text;
        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtValFcpST.Text := frmFatDadosFiscaisImpostos.edtValFcpST.Text;
        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtPerFcp.Text   := cdsDocumentos.FieldByName('PERFCP').AsString;
        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtAlqFcpST.Text := cdsDocumentos.FieldByName('PFCPST').AsString;

        frmFatDadosFiscais.fraDadosFechamentoVendaTransportadoraFrame.edtQtdTra.Text := cdsDocumentos.FieldByName('VOLUME').AsString;
        frmFatDadosFiscais.blnEspelhoEnvioParaOFornecedor := True;

        frmFatDadosFiscais.pAtualizarImpostosDigitadosParaMatrizItens;
        fatVenda.pRecalcularReformaTributariaDosItens;

        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtBaseCBS.Text  := FormatFloat('#,##0.00', fatVenda.fltTotBasCBS);
        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtValorCBS.Text := FormatFloat('#,##0.00', fatVenda.fltTotCBS);
        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtBaseIBS.Text  := FormatFloat('#,##0.00', fatVenda.fltTotBasIBS);
        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtValorIBS.Text := FormatFloat('#,##0.00', fatVenda.fltTotIBS);
        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtBaseIS.Text   := FormatFloat('#,##0.00', fatVenda.fltTotBasIS);
        frmFatDadosFiscais.fraDadosFechamentoVendaTotaisFrame.edtValorIS.Text  := FormatFloat('#,##0.00', fatVenda.fltTotIS);

        fatVenda.pSintetizaClassificacoes(False);
        frmFatDadosFiscais.pRateiaValorTaxaSiscomexNosItens;
        frmFatDadosFiscais.pAtualizaRodape;
        frmFatDadosFiscais.blnFatDadosFiscaisImpostosExterno := True;
        frmFatDadosFiscais.ShowModal;

        Result := frmFatDadosFiscais.blnConfirma;

        pFreeAndNil(frmFatDadosFiscais);

      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '');
        End;
      End;

      If (Not Result) Then
      Begin
        fRollBack;
        Exit;
      End;

      fatVenda.pCalculaTotalParaCadRec;
      fatVenda.pRateiaValores;
      fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fatVenda.fltTotCadRec,
                                             False, False, False, VS_Date, False, fatVenda.fltImpFre,
                                             'N', fCfgSis('DUPRED', varBoolean), False, 0, False,
                                             Nil, '', fCfgSis('FSDUDP', varBoolean), True, Nil, '', False, True, '', '', Nil, fatVenda.fFaturandoPedido);

      Try
        pCriarFormularios(TfrmGravando,frmGravando);
        frmGravando.strChave            := 'FATFATURA';
        frmGravando.fExecutarAcao       := fatVenda.fGravaArquivos;
        frmGravando.lblGravando.Caption := 'Aguarde, Gravando Retorno...';
        frmGravando.ShowModal;
        Result := frmGravando.blnConfirma;

        If (Result) And (Not fEmptyStr(strItens)) And (Not fEmptyStr(strNumRem)) Then
        Begin
          pVinculaRemessaDevolucao('OF', strNumRem, fatVenda.strAutInc, strItens);
        End;

        pFreeAndNil(frmGravando);

      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[fConfirmaVenda - frmGravando]');
          pFreeAndNil(frmGravando);
        End;
      End;

    End;

  Finally
    if Assigned(fatVenda) then
      FreeAndNil(fatVenda);
    FreeAndNil(frmFatDadosFiscaisImpostos);
    pSetEstado(TenuEstado.Pronto);
  End;

End;

function TfrmConfirmaEspelho.fBaixaEspelho : Boolean;
Begin
  Try
    Result := TEspelhoCapa.fMarcaComoEmitido(cdsDocumentos.FieldByName('AUTINC').AsString, fatVenda.strAutInc);
    if Result And (cdsDocumentos.FieldByName('TIPESP').AsString = 'G') Then
      Result := TMovGad.fAtualizaProdutosTrocaEspelhoConfirmacao(cdsDocumentos.FieldByName('AUTINC').AsString, fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strSerFsc, VS_strCodEmp, fatVenda.enuTipoEnvioFornecedorGarantia);
  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
End;

function TfrmConfirmaEspelho.fCarregaEspelhoFatVendas: boolean;
  Var
    objEspelhoChaveReferenciada : TEspelhoChaveReferenciada;
begin
  Result := False ;
  pCriarCdsVenda(Self);
  cdsVenda.EmptyDataSet;

  fatVenda                := TFatVenda.CreateInstance('VN');
  fatVenda.blnConfirmacaoEspelho := True;
  fatVenda.strNomeForm    := 'frmFatVendas';
  fatVenda.blnVerEstOrc   := False;

  FreeAndNil(fatVenda.objDespesasFaturamento);

  pCarregaDadosFornecedor(cdsDocumentos.FieldByName('CODFOR').AsString);

  fatVenda.strOriDoc := 'V';
  fatVenda.strEspDoc := 'NF';
  fatVenda.strCodVen := strLoginUsuarioLogado;
  fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
  fatVenda.strConPag := cdsDocumentos.FieldByName('CONPAG').AsString;
  fatVenda.strCodTra := cdsDocumentos.FieldByName('CODTRA').AsString;
  fatVenda.strTipFre := cdsDocumentos.FieldByName('TIPFRE').AsString;
  fatVenda.strCodCnd := cdsDocumentos.FieldByName('CODCND').AsString;
  fatVenda.strCodFpg := cdsDocumentos.FieldByName('CODFPG').AsString;
  fatVenda.fltValFre := cdsDocumentos.FieldByName('TOTFRE').AsFloat;
  fatVenda.fltFreDig := cdsDocumentos.FieldByName('TOTFRE').AsFloat;
  fatVenda.fltFreSug := cdsDocumentos.FieldByName('TOTFRE').AsFloat;
  fatVenda.fltDesAce := cdsDocumentos.FieldByName('ORI_DESACE').AsFloat;
  fatVenda.fltBasIcm := cdsDocumentos.FieldByName('BASICM').AsFloat;
  fatVenda.fltTotIcm := cdsDocumentos.FieldByName('TOTICM').AsFloat;
  fatVenda.fltBasIpi := cdsDocumentos.FieldByName('BASIPI').AsFloat;
  fatVenda.fltTotIpi := cdsDocumentos.FieldByName('ORI_TOTIPI').AsFloat;
  fatVenda.fltBasRet := cdsDocumentos.FieldByName('BASRET').AsFloat;
  fatVenda.fltTotRet := cdsDocumentos.FieldByName('ORI_TOTRET').AsFloat;
  fatVenda.strMen001 := cdsDocumentos.FieldByName('MEN001').AsString;
  fatVenda.strMen002 := cdsDocumentos.FieldByName('MEN002').AsString;
  fatVenda.strMen003 := cdsDocumentos.FieldByName('MEN003').AsString;
  fatVenda.strMen004 := cdsDocumentos.FieldByName('MEN004').AsString;
  fatVenda.strMen005 := cdsDocumentos.FieldByName('MEN005').AsString;
  fatVenda.strChaveNFeRefDevolucao := cdsDocumentos.FieldByName('CHVNFE').AsString;
  fatVenda.fLiberaReservaDeEstoqueDevolucaoWMS := fLiberaReservaDeEstoque;
  fatVenda.DigImp.blnOperadorDigitouImpostos := True;

  fatVenda.fBaixaEspelho := fBaixaEspelho;

  if (Pos(cdsDocumentos.FieldByName('CLAFIS').AsString, strClaGae) > 0) then
      fatVenda.enuTipoEnvioFornecedorGarantia := tefDevolucao
  else
    fatVenda.enuTipoEnvioFornecedorGarantia := tefConserto;

  objEspelhoChaveReferenciada := TEspelhoChaveReferenciada.Create;
  Try
    objEspelhoChaveReferenciada.pCarregaRegistro(cdsDocumentos.FieldByName('AUTINC').AsString, fatVenda.arrChaveNFReferenciaDocumentos);
  Finally
    FreeAndNil(objEspelhoChaveReferenciada);
  End;

  If fIncluiItens Then
  Begin
    fatVenda.blnBloquearRestaurarValoresEspeplhoGF := cdsDocumentos.FieldByName('TIPESP').AsString = 'G';
    fatVenda.pCarregaAliquotasRetencao;

    fatVenda.pPreencheMatrizFechamento;

    fatVenda.pCalculaPesBruLiq;

    fatVenda.pCalculaTotGer(False, False);

    fatVenda.fltDesEsp := cdsDocumentos.FieldByName('DESESP').AsFloat;
    If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
    Begin
      If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
        fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
    End;

    fatVenda.pDestacaRetencoes;
    fatVenda.pRetemImpostosNoDescontoEspecial;

    fatVenda.pCalculaTotGer(False, False);

    fatVenda.pCalculaTotGer;
    fatVenda.strClaFis := cdsDocumentos.FieldByName('CLAFIS').AsString;

    if fConfirmandoEspelhoEnvioFornecedor then
      fatVenda.strDesCla := cdsDocumentos.FieldByName('NATOPE').AsString;

    if (Not fConfirmandoEspelhoEnvioFornecedor) or (fEmptyStr(fatVenda.strDesCla) and fConfirmandoEspelhoEnvioFornecedor)   then
      fatVenda.strDesCla := fRetDesCla(cdsDocumentos.FieldByName('CLAFIS').AsString);

    Result := True ;
  end ;
end;

function TfrmConfirmaEspelho.fConfirmandoEspelhoEnvioFornecedor: Boolean;
begin
  Result := (Pos(fatVenda.strOpcDoc, 'GF_OF_') > 0) AND fatVenda.blnConfirmacaoEspelho;
end;

end.
