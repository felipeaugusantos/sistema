unit untManGerAutCtaPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Mask, MaskEditFocus,
  EditFocus, UniClientDataSet, Uni, untFuncoesSimples, untTypesSistema,
  Data.DB, untPaiSimples, cxProgressBar, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxGridCitel, untTLock,
  untFrameCentroCustoEditFocus, untFramePlanoDeContasMaskEdit, untPaiCad;

type
  TfrmManGerAutCtaPagar = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label5: TLabel;
    Label3: TLabel;
    edtNomFor: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodFor: TEditFocus;
    edtCodEmp: TEditFocus;
    Label8: TLabel;
    edtNumDup: TEditFocus;
    btnConsultar: TBitBtnLocked;
    Label2: TLabel;
    Label11: TLabel;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    pnlAux1: TPanel;
    dbgDuplicatas: TcxGridCitel;
    dbgDuplicatasView: TcxGridDBTableViewCitel;
    dbgDuplicatasCTP_NUMDUP: TcxGridDBColumn;
    dbgDuplicatasCTP_CODEMP: TcxGridDBColumn;
    dbgDuplicatasCTP_CODFOR: TcxGridDBColumn;
    dbgDuplicatasFOR_NOMFOR: TcxGridDBColumn;
    dbgDuplicatasCTP_CODPOR: TcxGridDBColumn;
    dbgDuplicatasCTP_DTAVEN: TcxGridDBColumn;
    dbgDuplicatasCTP_DESSUJ: TcxGridDBColumn;
    dbgDuplicatasCTP_JURSUJ: TcxGridDBColumn;
    dbgDuplicatasCTP_MULSUJ: TcxGridDBColumn;
    dbgDuplicatasLevel1: TcxGridLevel;
    Label1: TLabel;
    edtSerie: TEditFocus;
    dbgDuplicatasCTP_SERIE_: TcxGridDBColumn;
    dbgDuplicatasCTP_COMPET: TcxGridDBColumn;
    dbgDuplicatasCTP_VALDUP: TcxGridDBColumn;
    dbgDuplicatasCTP_CODEVE: TcxGridDBColumn;
    dbgDuplicatasEVE_DESEVE: TcxGridDBColumn;
    dbgDuplicatasCTP_MARDES: TcxGridDBColumn;
    dbgDuplicatasTOTDUP: TcxGridDBColumn;
    Label26: TLabel;
    Label25: TLabel;
    mskDtaCadIni: TcxDateEdit;
    mskDtaCadFin: TcxDateEdit;
    btnAlterar: TBitBtnLocked;
    dbgDuplicatasCTP_CODCTA: TcxGridDBColumn;
    dbgDuplicatasCTA_DESCTA: TcxGridDBColumn;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    dbgDuplicatasCTP_PREVIS: TcxGridDBColumn;
    dbgDuplicatasCTP_VEIONF: TcxGridDBColumn;
    dbgDuplicatasCTP_USOCON: TcxGridDBColumn;
    dbgDuplicatasCTP_PAGANT: TcxGridDBColumn;
    btnExcluir: TBitBtnLocked;
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsultarClick(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure dbgDuplicatasViewDblClick(Sender: TObject);
    procedure dbgDuplicatasViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDuplicatasViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbgDuplicatasViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    stlSeqCon: TStringList;
    qryConEmp: TUniQuery;
    qryConFor: TUniQuery;
    qryCadPag: TUniQuery;
    qryConCta: TUniQuery;
    cdsCtaPag: TUniClientDataSet;
    dtsCtaPag: TDataSource;


    strAceCtp: String;
    strValorFiltro : String;
    strCampoFiltro : String;
    strNomeTabela: String;

    objLock: TLock;

    arrEmp: TConsultasArray;
    arrFornec: TConsultasArray;
    arrEvento: TConsultasArray;
    arrCentCusto: TConsultasArray;

    lstFornecedor:TStringList;
    blnUsaLiberacaoDePrevisao,
    blnGravaApenasPrevisao   : Boolean;

    FDatasetCtpDet,
    FDatasetCtpDetClone: TUniClientDataset;

    procedure pAtualizaTemporaria;
    procedure pFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure pLiberaDupsMarcadas;
    procedure GravaLogCtp(AAutoIncrem, strDescricaoLog: String);
    procedure pCarregaCentroCusto;
    procedure pMarcaDuplicata(blnMarcar: Boolean);
    procedure pSelecionaDuplicata;
    procedure pCarregaFornecedor;
    procedure pCarregaEmpresa;
    procedure pCarregaEventos;
    procedure pLimpaEdits;
    function fGetEmpAceCtp: String;
    procedure pMarcaFornecedor(chave, marcaDesmarca: String);
    function fSalvarAlteracoes(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fAtualizaCtpDet(strNumDup, strParcel, strCodEmp, strCodFor, strSerie: String): Boolean;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
  public
    { Public declarations }
    cdsCtaPagNovo: TUniClientDataSet;
    dtsCtaPagNovo : TDataSource;
  end;


implementation

uses StrUtils, untFuncoes, UniDataSetProvider,
  untPesqAux, untConsultas, untFuncoesGenerica,
  untConstantes, untFuncoesConsulta, untCadPag,
  untGravando, untObjectManager, untLogCtp, untCadCtaPagar,
  untCtpDigGerAut, untCtpAltGerAut, untExclusaoAutCtaPagar, untLogCtpDet;

{$R *.dfm}

procedure TfrmManGerAutCtaPagar.btnExcluirClick(Sender: TObject);
  Var
    frmExclusaoAutCtaPagar : TfrmExclusaoAutCtaPagar;
    strAutoincrem: String;
begin
  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&O k']);
    Exit;
  End;

  If (Not fVerificaAcessoSistema('CTPALTGERAUT', strLoginUsuarioLogado)) then
  begin
    pMensagemOk('Usuário sem direito de acesso para utilizar a função.');
    Exit;
  end;

  If Not ExcluirDuplicataGeradaDeKMRodados(cdsCtaPag.FieldByName('NRODUP').AsString + '-' +
                                           cdsCtaPag.FieldByName('PARDUP').AsString + '-' +
                                           cdsCtaPag.FieldByName('CTP_CODEMP').AsString + '-' +
                                           cdsCtaPag.FieldByName('CTP_CODFOR').AsString + '-' +
                                           cdsCtaPag.FieldByName('CTP_SERIE_').AsString,
                                           cdsCtaPag.FieldByname('CTP_SEQBAI').AsInteger) Then
    Exit;

  fLock_Unlock(strNomeTabela + cdsCtaPag.FieldByName('AUTOINCREM').AsString, False);
  strAutoincrem  := cdsCtaPag.FieldByName('AUTOINCREM').AsString;
  Try
    pCriarFormularios(TfrmExclusaoAutCtaPagar, frmExclusaoAutCtaPagar);
    try
      frmExclusaoAutCtaPagar.strNumDup := cdsCtaPag.FieldByName('NRODUP').AsString;
      frmExclusaoAutCtaPagar.strCodEmp := cdsCtaPag.FieldByName('CTP_CODEMP').AsString;
      frmExclusaoAutCtaPagar.strCodFor := cdsCtaPag.FieldByName('CTP_CODFOR').AsString;
      frmExclusaoAutCtaPagar.pAtualizaTemporaria;
      If Not frmExclusaoAutCtaPagar.blnIsEmpty Then
        frmExclusaoAutCtaPagar.ShowModal;
    finally
      pFreeAndNil(frmExclusaoAutCtaPagar);
    end;
  except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmManGerAutCtaPagar.btnExcluirClick]');
  end;
  btnConsultar.Click;
end;

procedure TfrmManGerAutCtaPagar.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicata;

end;

procedure TfrmManGerAutCtaPagar.btnConsultarClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(mskDtaFin, TRUE) Then
    pSetFocus(mskDtaFin)
  Else
  Begin
    TfrmGravando.fExecutarModal(pAtualizaTemporaria, 'Aguarde... Carregando Títulos.', '');
    If pnlCabecalho.Visible Then
      pSetFocus(dbgDuplicatas);
  End;

end;

procedure TfrmManGerAutCtaPagar.dbgDuplicatasViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  btnExcluir.Visible := (Pos('G',cdsCtaPag.FieldByName('NRODUP').AsString) > 0);
end;

procedure TfrmManGerAutCtaPagar.dbgDuplicatasViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  With cdsCtaPag Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_MARDES.Index]) = 'M' Then
    Begin
      If AViewInfo.Selected Then
        ACanvas.Font.Color := clLime
      Else
        ACanvas.Font.Color := clBlue;
    End;
  End;
end;

procedure TfrmManGerAutCtaPagar.dbgDuplicatasViewDblClick(Sender: TObject);
begin
  inherited;
  btnAlterarClick(btnAlterar);

end;

procedure TfrmManGerAutCtaPagar.dbgDuplicatasViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    pSelecionaDuplicata;
end;

procedure TfrmManGerAutCtaPagar.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
end;

procedure TfrmManGerAutCtaPagar.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManGerAutCtaPagar.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmManGerAutCtaPagar.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmManGerAutCtaPagar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO DO FORNECEDOR         *}
    {**************************************MV*}

    If (Sender = edtCodFor) Then
    Begin
      If (Not fEmptyStr(edtCodFor.Text)) Then
      Begin

        If edtCodFor.Text <> '00000000' Then
           pCarregaFornecedor;

        If fEmptyStr(edtNomFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtNomFor.Clear;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO EVENTO             *}
    {**************************************LB*}
    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin

        If fraCentroCusto.edtCodEve.Text <> '00000' Then
           pCarregaEventos;

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End;

      End
      Else
      Begin
        fraCentroCusto.edtDesEve.Clear;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
        edtNomEmp.Clear
      Else
      Begin

        If edtCodEmp.Text <> '000' Then
           pCarregaEmpresa;

        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) And (edtNomEmp.Text <> '+1') Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
          Result := False;
        End
        Else If (Pos(LeftStr(edtCodEmp.Text,3), strAceCtp) <= 0) And (edtNomEmp.Text <> '+1') Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão no Manutenção coletiva das duplicatas de Geração Automática do contas a pagar desta empresa!', ['&Ok']);
          Result := False;
        End;
      End;
    End
        {*****************************************}
    {* VALIDA AS DATAS INICIAIS              *}
    {**************************************MV*}
    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        mskDtaFin.Enabled := False
      Else
        mskDtaFin.Enabled := True;
    End
    Else If (Sender = MskDtaCadIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
        mskDtaCadFin.Enabled:= False
      Else
        mskDtaCadFin.Enabled:= True;
    End


    {*****************************************}
    {* VALIDA AS DATAS FINAIS                *}
    {**************************************MV*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End;
      End;

    End
    Else if (Sender = mskDtaCadFin) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final de cadastro deve ser preenchida!', ['&O k']);
          Result:=False;
        End
        Else If Not fValidaPeriodo(mskDtaCadIni.Text, mskDtaCadFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final de cadastro deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result:=False;
        End
      End;
    End
    {***************************************}
    {* VALIDA CENTRO DE CUSTO              *}
    {************************************JU*}
    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin

        If fraPlanoDeContas.MskCodCta.Text <> '0' Then
           pCarregaCentroCusto;

        if fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
           fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
           Result := False;
        End;
      End
      Else
      Begin
        fraPlanoDeContas.edtDesCta.Clear;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmManGerAutCtaPagar.pAtualizaTemporaria;
Var
  qryCtaPag: TUniQuery;
  dspCtaPag: TUniDataSetProvider;
begin

  pLiberaDupsMarcadas;

  cdsCtaPag.Filtered := False;
  cdsCtaPag.Close;
  qryCtaPag := fCriaQuery(Self);
  dspCtaPag := TUniDataSetProvider.Create(Self);
  dspCtaPag.DataSet := qryCtaPag;
  cdsCtaPag.SetProvider(dspCtaPag);
  Try
    With qryCtaPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  P.CTP_NUMDUP AS NRODUP, ');
      SQL.Add('  P.CTP_PARCEL AS PARDUP, ');
      SQL.Add('  CONCAT(P.CTP_NUMDUP, P.CTP_PARCEL) AS CTP_NUMDUP, ');
      SQL.Add('  P.CTP_CODFOR, ');
      SQL.Add('  F.FOR_NOMFOR, ');
      SQL.Add('  F.FOR_FONE01, ');
      SQL.Add('  F.FOR_F_A_X_, ');
      SQL.Add('  CONCAT(P.CTP_CODFOR ,"-", F.FOR_NOMFOR) AS CTP_NOMFOR, ');
      SQL.Add('  F.FOR_C_G_C_, ');
      SQL.Add('  P.CTP_CODEMP, ');
      SQL.Add('  P.CTP_SERIE_, ');
      SQL.Add('  E.EMP_NOMEMP, ');
      SQL.Add('  P.CTP_CODCTA, ');
      SQL.Add('  C.CTA_DESCTA, ');
      SQL.Add('  P.CTP_HIST01, ');
      SQL.Add('  P.CTP_HIST02, ');
      SQL.Add('  IF(P.CTP_PREVIS = "S", "SIM", "NÃO") AS CTP_PREVIS, ');
      SQL.Add('  P.CTP_DTACAD, ');
      SQL.Add('  P.CTP_DTAVEN, ');
      SQL.Add('  P.CTP_VALORI, ');
      SQL.Add('  P.CTP_VALDUP, ');
      SQL.Add('  P.CTP_VALPAG, ');
      SQL.Add('  P.CTP_DTAPAG, ');
      SQL.Add('  P.CTP_JURSUJ, ');
      SQL.Add('  P.CTP_MULSUJ, ');
      SQL.Add('  P.CTP_DESSUJ, ');
      SQL.Add('  P.CTP_CODEVE, ');
      SQL.Add('  P.CTP_TIPDOC, ');
      SQL.Add('  P.CTP_CODVEL, ');
      SQL.Add('  P.CTP_CODPOR, ');
      SQL.Add('  R.POR_NOMPOR, ');
      SQL.Add('  CONCAT(P.CTP_CODPOR ,"-", R.POR_NOMPOR) AS CTP_NOMPOR, ');
      SQL.Add('  P.CTP_PORBAI, ');
      SQL.Add('  IF(P.CTP_USACHQ = "S", "SIM", "NÃO") AS CTP_USACHQ, ');
      SQL.Add('  V.EVE_DESEVE, ');
      SQL.Add('  IFNULL(P.CTP_VENDOR, 0) AS CTP_VENDOR, ');
      SQL.Add('  (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_MULSUJ,0) + IFNULL(P.CTP_VENDOR,0)) -IFNULL(P.CTP_DESSUJ,0) AS TOTDUP, ');
      SQL.Add('  " " AS CTP_MARDES, ');
      SQL.Add('  " " AS CTP_TIPBAI, ');
      SQL.Add('  " " AS CTP_TIPDES, ');
      SQL.Add('  P.AUTOINCREM, ');
      SQL.Add('  "CADPAG" AS TABELA, ');
      SQL.Add('  CTP_COMPET,         ');
      SQL.Add('  P.CTP_DINHEI, ');
      SQL.Add('  P.CTP_CHQAVI, ');
      SQL.Add('  P.CTP_ORDPAG, ');
      SQL.Add('  P.CTP_REPCHQ, ');
      SQL.Add('  P.CTP_SEQBAI, ');
      SQL.Add('  P.CTP_DTALIB, ');
      SQL.Add('  IF(P.CTP_VEIONF = "S", "SIM", "NÃO") AS CTP_VEIONF, ');
      SQL.Add('  IF(P.CTP_PAGANT = "S", "SIM", "NÃO") AS CTP_PAGANT, ');
      SQL.Add('  IF(P.CTP_USOCON = "S", "SIM", "NÃO") AS CTP_USOCON, ');
      SQL.Add('  P.CTP_OPEAPR,');
      SQL.Add('  P.CTP_OPEREP');
      SQL.Add('FROM ');
      SQL.Add('  CADPAG P ');
      SQL.Add('  JOIN CADFOR F ON P.CTP_CODFOR = F.FOR_CODFOR ');
      SQL.Add('  JOIN CADEMP E ON P.CTP_CODEMP = E.EMP_CODEMP ');
      SQL.Add('  JOIN CADCTA C ON P.CTP_CODCTA = C.CTA_CODCTA ');
      SQL.Add(' LEFT JOIN CADEVE V ON P.CTP_CODEVE = V.EVE_CODEVE ');
      SQL.Add(' LEFT JOIN CADPOR R ON P.CTP_CODPOR = R.POR_CODPOR ');
      SQL.Add('WHERE ');
      SQL.Add('  (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_MULSUJ,0) + IFNULL(P.CTP_VENDOR,0)) -IFNULL(P.CTP_DESSUJ,0) <> 0 ');
      SQL.Add(' AND P.CTP_DTAPAG IS NULL ');
      SQL.Add(' AND P.CTP_SEQBAI = 0 ');
      SQL.Add(' AND SUBSTR(P.CTP_NUMDUP,1,1) = :SIGLA ');
      ParamByName('SIGLA').AsString := 'G';
      SQL.Add(' AND (SELECT COUNT(1) QTD ');
      SQL.Add(' 		FROM CADPAG P1 ');
      SQL.Add(' 		WHERE P1.CTP_NUMDUP = P.CTP_NUMDUP ');
      SQL.Add(' 		AND P1.CTP_PARCEL = P.CTP_PARCEL ');
      SQL.Add(' 		AND P1.CTP_CODFOR = P.CTP_CODFOR ');
      SQL.Add(' 		AND P1.CTP_SERIE_ = P.CTP_SERIE_ ');
      SQL.Add(' 		AND P1.CTP_CODEMP = P.CTP_CODEMP) = 1 ');

      If Not fEmptyStr(fTiraCaracEspeciais(edtCodFor.Text)) Then
      begin
        SQL.Add('  AND P.CTP_CODFOR = :CTP_CODFOR ');
        ParamByName('CTP_CODFOR').AsString := edtCodFor.Text;
      end;

      If Not fEmptyStr(fTiraCaracEspeciais(fraCentroCusto.edtCodEve.Text)) Then
      begin
        SQL.Add('  AND P.CTP_CODEVE = :CTP_CODEVE ');
        ParamByName('CTP_CODEVE').AsString := fraCentroCusto.edtCodEve.Text;
      end;

      If Not fEmptyStr(fTiraCaracEspeciais(edtCodEmp.Text)) Then
      begin
        SQL.Add('  AND P.CTP_CODEMP = :CTP_CODEMP ');
        ParamByName('CTP_CODEMP').AsString := edtCodEmp.Text;
      end;

      If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      begin
        SQL.Add('  AND P.CTP_CODCTA = :CTP_CODCTA ');
        ParamByName('CTP_CODCTA').AsString := fraPlanoDeContas.MskCodCta.Text;
      end;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      begin
        SQL.Add('  AND P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ');
        ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
      end;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      begin
        SQL.Add('  AND P.CTP_DTACAD BETWEEN :DTACADINI AND :DTACADFIN ');
        ParamByName('DTACADINI').AsDateTime := StrToDate(mskDtaCadIni.Text);
        ParamByName('DTACADFIN').AsDateTime := StrToDate(mskDtaCadFin.Text);
      end;

      If Not fEmptyStr(fTiraCaracEspeciais(edtNumDup.Text)) Then
      begin
        SQL.Add('  AND P.CTP_NUMDUP = :CTP_NUMDUP ');
        ParamByName('CTP_NUMDUP').AsString := edtNumDup.Text;
      end;

      If Not fEmptyStr(fTiraCaracEspeciais(edtSerie.Text)) Then
      begin
        SQL.Add('  AND P.CTP_SERIE_ = :CTP_SERIE_ ');
        ParamByName('CTP_SERIE_').AsString := edtSerie.Text;
      end;
      Open;
      Application.ProcessMessages;

      If Not IsEmpty Then
      Begin
        pSetaClient(qryCtaPag);
        cdsCtaPag.Open;
        With cdsCtaPag Do
        Begin
          (FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_DESSUJ') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_JURSUJ') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_MULSUJ') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_VENDOR') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('TOTDUP')     As TFloatField).DisplayFormat := '#,##0.00';
          IndexFieldNames := 'CTP_DTAVEN;CTP_CODFOR;CTP_NUMDUP;CTP_CODEMP';
          First;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Nenhuma duplicata foi encontrada!', ['&Ok']);
        blnMudarFoco := False;
        pSetFocus(edtCodFor);
      End;

      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmManGerAutCtaPagar.pAtualizaTemporaria]');
    End;
  End;

  Application.ProcessMessages;
  objLock.pDestravarTodos;
  cdsCtaPag.SetProvider(nil);
  FreeAndNil(dspCtaPag);
  FreeAndNil(qryCtaPag);
end;

procedure TfrmManGerAutCtaPagar.pLiberaDupsMarcadas;
begin
  With cdsCtaPag Do
  Begin
    Filtered := False;
    Filter := 'CTP_MARDES = ''M''';
    Filtered := True;

    If Not IsEmpty Then
    Begin
      First;

      While Not Eof Do
      Begin
        objLock.fLock_Unlock(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString, False);
        Next;
      End;
    End;
  End;
end;

procedure TfrmManGerAutCtaPagar.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If Not fEmptyStr(strCampoFiltro) Then
    Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

procedure TfrmManGerAutCtaPagar.GravaLogCtp(AAutoIncrem,
                                            strDescricaoLog: String);
begin
  Try
    untLogCtp.GravaLogCtp(AAutoIncrem, strDescricaoLog, Self.Name);
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[frmManGerAutCtaPagar.GravaLogCtp]');
  End;
end;



procedure TfrmManGerAutCtaPagar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If cdsCtaPagNovo.Active Then
  begin
    cdsCtaPagNovo.EmptyDataSet;
    cdsCtaPagNovo.Close;
  end;
  If Assigned(cdsCtaPag) Then
    FreeAndNil(cdsCtaPag);

  If Assigned(cdsCtaPagNovo) Then
    FreeAndNil(cdsCtaPagNovo);

  FreeAndNil(objLock);

  FDatasetCtpDet := Nil;
  FDatasetCtpDetClone := Nil;
end;

procedure TfrmManGerAutCtaPagar.FormCreate(Sender: TObject);
begin
  inherited;
  lstFornecedor := TStringList.Create;
  strAceCtp:= fGetEmpAceCtp;
  objLock  := TLock.Create;
  strNomeTabela := 'CADPAG';

  stlSeqCon := TStringList.Create;
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);

  qryCadPag := fCriarQuery('SELECT * FROM CADPAG WHERE FALSE', Self);
  qryCadPag.Open;

  blnUsaLiberacaoDePrevisao := fCfgSis('CTPPRE', varBoolean);
  blnGravaApenasPrevisao    := (blnUsaLiberacaoDePrevisao) And
                               (Not fVerPermissaoOperador('LIBCTPPREV', strLoginUsuarioLogado));


  cdsCtaPag := TUniClientDataSet.Create(Self);
  cdsCtaPag.OnFilterRecord := pFilterRecord;
  dtsCtaPag := fCriaDataSource(cdsCtaPag);
  dbgDuplicatasView.DataController.DataSource := dtsCtaPag;

  pCriaClientTemporariaCtpDet('', '', '', '', '', FDatasetCtpDet, FDatasetCtpDetClone);

  cdsCtaPagNovo := TUniClientDataSet.Create(Self);
  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUTOINCREM';
    DataType := ftString;
    Size := 20;
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_DTAVEN';
    DataType := ftDateTime;
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_DTACAD';
    DataType := ftDateTime;
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_VALDUP';
    DataType := ftFloat;
    Precision := 2
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_JURSUJ';
    DataType := ftFloat;
    Precision := 2
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_MULSUJ';
    DataType := ftFloat;
    Precision := 2
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_DESSUJ';
    DataType := ftFloat;
    Precision := 2
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_VALORI';
    DataType := ftFloat;
    Precision := 2
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_CODPOR';
    DataType := ftString;
    Size := 5
  End;
  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_NOMPOR';
    DataType := ftString;
    Size := 60
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_CODEVE';
    DataType := ftString;
    Size := 5
  End;
  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'EVE_DESEVE';
    DataType := ftString;
    Size := 50
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_CODCTA';
    DataType := ftString;
    Size := 7
  End;
  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTA_DESCTA';
    DataType := ftString;
    Size := 50
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_COMPET';
    DataType := ftString;
    Size := 7
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_NUMDUP';
    DataType := ftString;
    Size := 20
  End;
  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NRODUP';
    DataType := ftString;
    Size := 12
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_PARCEL';
    DataType := ftString;
    Size := 7
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_SEQBAI';
    DataType := ftInteger;
  End;
  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_CODEMP';
    DataType := ftString;
    Size := 3
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_CODFOR';
    DataType := ftString;
    Size := 8
  End;

  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_SERIE_';
    DataType := ftString;
    Size := 3
  End;
  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_PREVIS';
    DataType := ftString;
    Size := 3
  End;
  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_VEIONF';
    DataType := ftString;
    Size := 3
  End;
  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_USOCON';
    DataType := ftString;
    Size := 3
  End;
  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_PAGANT';
    DataType := ftString;
    Size := 3
  End;
  With cdsCtaPagNovo.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTDUP';
    DataType := ftFloat;
    Precision := 2
  End;
  cdsCtaPagNovo.CreateDataSet;
  cdsCtaPagNovo.LogChanges := False;
  (cdsCtaPagNovo.FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
  (cdsCtaPagNovo.FieldByName('CTP_DESSUJ') As TFloatField).DisplayFormat := '#,##0.00';
  (cdsCtaPagNovo.FieldByName('CTP_JURSUJ') As TFloatField).DisplayFormat := '#,##0.00';
  (cdsCtaPagNovo.FieldByName('CTP_MULSUJ') As TFloatField).DisplayFormat := '#,##0.00';
  (cdsCtaPagNovo.FieldByName('CTP_VALORI') As TFloatField).DisplayFormat := '#,##0.00';
  (cdsCtaPagNovo.FieldByName('TOTDUP') As TFloatField).DisplayFormat := '#,##0.00';

end;

procedure TfrmManGerAutCtaPagar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin

    If pnlCabecalho.Visible Then
    Begin
      pLimpaEdits;
      blnMudarFoco := False;
      pSetFocus(edtCodFor);
    End
    Else
      btnSair.Click;
  End;

end;

procedure TfrmManGerAutCtaPagar.FormShow(Sender: TObject);
begin
  inherited;
  btnExcluir.Visible := fVerificaAcessoSistema('CTPEXCGERAUT', strLoginUsuarioLogado);

  edtCodEmp.Text := IfThen((Pos(LeftStr(VS_strCodEmp,3), strAceCtp) > 0),VS_strCodEmp, '' ); //VS_strCodEmp;
  edtNomEmp.Text := IfThen((Pos(LeftStr(VS_strCodEmp,3), strAceCtp) > 0),fRetNomeEmpresa, '' ); //fRetNomeEmpresa;

  if Not pnlCabecalho.Visible Then
    pSetFocus(dbgDuplicatas);

end;


procedure TfrmManGerAutCtaPagar.pMarcaDuplicata(blnMarcar: Boolean);
begin

{  if (not fVerificaDireitoBaixa) then
	begin
    pMensagemOk('Usuário não tem permissão para fazer baixa nesta empresa.');
  	Exit;
	end;
}
  With cdsCtaPag Do
  Begin
    If blnMarcar Then
    Begin
      If Not objLock.fLock_Unlock(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString, True, False) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString), ['&Ok']);
        Exit;
      End;
    End
    Else
      objLock.fLock_Unlock(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString, False);

    Edit;
    FieldByName('CTP_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
    Post;
    pMarcaFornecedor(FieldByName('AUTOINCREM').AsString+'|'+FieldByName('CTP_CODFOR').AsString,IIF(blnMarcar, 'M', 'D'));
  End;

end;

{*****************************************}
{* SELECIONA UMA DUPLICATA               *}
{**************************************MV*}
procedure TfrmManGerAutCtaPagar.pSelecionaDuplicata;
begin
  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&O k']);
    Exit;
  End;

  If (Not fVerificaAcessoSistema('CTPALTGERAUT', strLoginUsuarioLogado)) then
  begin
    pMensagemOk('Usuário sem direito de acesso para utilizar a função.');
    Exit;
  end;

  If cdsCtaPag.FieldByName('CTP_MARDES').AsString <> 'M' Then
  Begin
    if fCfgSis('CTPLBB', varBoolean) And (cdsCtaPag.FieldByName('CTP_DTALIB').IsNull) then
    begin
      pMensagemOk('Esta duplicata ainda não foi liberada para ser alterada.');
      Exit;
    end;

    If cdsCtaPag.FieldByName('NRODUP').IsNull then
    begin
      pMensagemOk('Nenhuma duplicata foi selecionada.');
      Exit;
    end;

    {*****************************************}
    {* CHAMA O FORM DE DIGITAÇÃO             *}
    {**************************************MV*}

    pCriarFormularios(TfrmCtpDigGerAut, frmCtpDigGerAut);
    try
      frmCtpDigGerAut.strCodFor := cdsCtaPag.FieldByName('CTP_CODFOR').AsString;
      frmCtpDigGerAut.strNomFor := cdsCtaPag.FieldByName('FOR_NOMFOR').AsString;
      frmCtpDigGerAut.strDtaCad := cdsCtaPag.FieldByName('CTP_DTACAD').AsString;
      frmCtpDigGerAut.strNumDup := cdsCtaPag.FieldByName('NRODUP').AsString;
      frmCtpDigGerAut.strParcel := cdsCtaPag.FieldByName('PARDUP').AsString;
      frmCtpDigGerAut.strSerie  := cdsCtaPag.FieldByName('CTP_SERIE_').AsString;
      frmCtpDigGerAut.strCodEmp := cdsCtaPag.FieldByName('CTP_CODEMP').AsString;
      frmCtpDigGerAut.strCompet := cdsCtaPag.FieldByName('CTP_COMPET').AsString;
      frmCtpDigGerAut.strDtaVen := cdsCtaPag.FieldByName('CTP_DTAVEN').AsString;
      frmCtpDigGerAut.strValDup := FloatToStrF(cdsCtaPag.FieldByName('CTP_VALDUP').AsFloat, ffFixed, 12, 2);
      frmCtpDigGerAut.strDesSuj := FloatToStrF(cdsCtaPag.FieldByName('CTP_DESSUJ').AsFloat, ffFixed, 12, 2);
      frmCtpDigGerAut.strJurSuj := FloatToStrF(cdsCtaPag.FieldByName('CTP_JURSUJ').AsFloat, ffFixed, 12, 2);
      frmCtpDigGerAut.strMulSuj := FloatToStrF(cdsCtaPag.FieldByName('CTP_MULSUJ').AsFloat, ffFixed, 12, 2);
      frmCtpDigGerAut.strCodPor := cdsCtaPag.FieldByName('CTP_CODPOR').AsString;
      frmCtpDigGerAut.strCodEve := cdsCtaPag.FieldByName('CTP_CODEVE').AsString;
      frmCtpDigGerAut.strCodCta := cdsCtaPag.FieldByName('CTP_CODCTA').AsString;
      frmCtpDigGerAut.edtNumDup.Text := cdsCtaPag.FieldByName('CTP_NUMDUP').AsString;
      frmCtpDigGerAut.edtSerie.Text  := cdsCtaPag.FieldByName('CTP_SERIE_').AsString;
      frmCtpDigGerAut.edtNomPor.Text := cdsCtaPag.FieldByName('POR_NOMPOR').AsString;
      frmCtpDigGerAut.fraPlanoDeContas.edtDesCta.Text := cdsCtaPag.FieldByName('CTA_DESCTA').AsString;
      frmCtpDigGerAut.fraCentroCusto.edtDesEve.Text := cdsCtaPag.FieldByName('EVE_DESEVE').AsString;
      frmCtpDigGerAut.strPrevis := IfThen(cdsCtaPag.FieldByName('CTP_PREVIS').AsString = 'SIM','S','N');
      frmCtpDigGerAut.strVeioNF := IfThen(cdsCtaPag.FieldByName('CTP_VEIONF').AsString = 'SIM','S','N');
      frmCtpDigGerAut.strUsoCon := IfThen(cdsCtaPag.FieldByName('CTP_USOCON').AsString = 'SIM','S','N');
      frmCtpDigGerAut.strPagAnt := IfThen(cdsCtaPag.FieldByName('CTP_PAGANT').AsString = 'SIM','S','N');
      frmCtpDigGerAut.srtDtaPag := cdsCtaPag.FieldByName('CTP_DTAPAG').AsString;
      frmCtpDigGerAut.blnHabilitaPrevis := (Not blnUsaLiberacaoDePrevisao) Or
                                           ((Not blnGravaApenasPrevisao) And
                                            (cdsCtaPag.FieldByName('CTP_OPEAPR').IsNull) And
                                            (cdsCtaPag.FieldByName('CTP_OPEREP').IsNull) And
                                            (cdsCtaPag.FieldByName('CTP_PREVIS').AsString = 'NÃO'));
      frmCtpDigGerAut.blnGravaApenasPrevisao := blnGravaApenasPrevisao;

      frmCtpDigGerAut.ShowModal;

      FDatasetCtpDet := frmCtpDigGerAut.cdsCtpDet;//MF: 281423 - 26/04/2023  - DESMEMBRAMENTO
      FDatasetCtpDetClone := frmCtpDigGerAut.cdsCtpDetClone;

      If frmCtpDigGerAut.blnConfirma Then
      Begin
        pCriarFormularios(TfrmCtpAltGerAut, frmCtpAltGerAut);
        try
          dtsCtaPagNovo := fCriaDataSource(cdsCtaPagNovo);
          frmCtpAltGerAut.dbgDuplicatasNovoView.DataController.DataSource := dtsCtaPagNovo;

          frmCtpAltGerAut.blnAlt_strCompet := (frmCtpDigGerAut.edtCompet.Text <> frmCtpDigGerAut.Old_strCompet);
          frmCtpAltGerAut.blnAlt_strDtaVen := (frmCtpDigGerAut.edtDtaVen.Text <> frmCtpDigGerAut.Old_strDtaVen);
          frmCtpAltGerAut.blnAlt_strDtaCad := (frmCtpDigGerAut.edtDtaCad.Text <> frmCtpDigGerAut.Old_strDtaCad);
          frmCtpAltGerAut.blnAlt_strValDup := (frmCtpDigGerAut.edtValDup.Text <> frmCtpDigGerAut.Old_strValDup);
          frmCtpAltGerAut.blnAlt_strDesSuj := (frmCtpDigGerAut.edtDesSuj.Text <> frmCtpDigGerAut.Old_strDesSuj);
          frmCtpAltGerAut.blnAlt_strJurSuj := (frmCtpDigGerAut.edtJurSuj.Text <> frmCtpDigGerAut.Old_strJurSuj);
          frmCtpAltGerAut.blnAlt_strMulSuj := (frmCtpDigGerAut.edtMulSuj.Text <> frmCtpDigGerAut.Old_strMulSuj);
          frmCtpAltGerAut.blnAlt_strCodPor := (frmCtpDigGerAut.edtCodPor.Text <> frmCtpDigGerAut.Old_strCodPor);
          frmCtpAltGerAut.blnAlt_strCodEve := (frmCtpDigGerAut.fraCentroCusto.edtCodEve.Text   <> frmCtpDigGerAut.Old_strCodEve);
          frmCtpAltGerAut.blnAlt_strCodCta := (frmCtpDigGerAut.fraPlanoDeContas.MskCodCta.Text <> frmCtpDigGerAut.Old_strCodCta);
          frmCtpAltGerAut.blnAlt_strPrevis := (frmCtpDigGerAut.edtPrevis.Text <> frmCtpDigGerAut.Old_strPrevis);
          frmCtpAltGerAut.blnAlt_strVeioNF := (frmCtpDigGerAut.edtVeioNF.Text <> frmCtpDigGerAut.Old_strVeioNF);
          frmCtpAltGerAut.blnAlt_strUsoCon := (frmCtpDigGerAut.edtUsoCon.Text <> frmCtpDigGerAut.Old_strUsoCon);
          frmCtpAltGerAut.blnAlt_strPagant := (frmCtpDigGerAut.edtPagAnt.Text <> frmCtpDigGerAut.Old_strPagAnt);

          frmCtpAltGerAut.strDtaVen       := frmCtpDigGerAut.strDtaVen;
          frmCtpAltGerAut.strDtaCad       := frmCtpDigGerAut.edtDtaCad.Text;

          frmCtpAltGerAut.edtDtaVen.Date  := frmCtpDigGerAut.edtDtaVen.Date;
          frmCtpAltGerAut.strNumDup       := frmCtpDigGerAut.strNumDup;
          frmCtpAltGerAut.strParcel       := frmCtpDigGerAut.strParcel;
          frmCtpAltGerAut.strSerie        := frmCtpDigGerAut.strSerie;
          frmCtpAltGerAut.strCodEmp       := frmCtpDigGerAut.strCodEmp;
          frmCtpAltGerAut.strCompet       := frmCtpDigGerAut.edtCompet.Text;
          frmCtpAltGerAut.fltValDup       := fStrToFloat(frmCtpDigGerAut.edtValDup.Text);
          frmCtpAltGerAut.fltDesSuj       := fStrToFloat(frmCtpDigGerAut.edtDesSuj.Text);
          frmCtpAltGerAut.fltJurSuj       := fStrToFloat(frmCtpDigGerAut.edtJurSuj.Text);
          frmCtpAltGerAut.fltMulSuj       := fStrToFloat(frmCtpDigGerAut.edtMulSuj.Text);
          frmCtpAltGerAut.strCodFor       := frmCtpDigGerAut.strCodFor;
          frmCtpAltGerAut.strCodEve       := frmCtpDigGerAut.fraCentroCusto.edtCodEve.Text;
          frmCtpAltGerAut.strDesEve       := frmCtpDigGerAut.fraCentroCusto.edtDesEve.Text;
          frmCtpAltGerAut.strCodPor       := frmCtpDigGerAut.edtCodPor.Text;
          frmCtpAltGerAut.strNomPor       := frmCtpDigGerAut.edtNomPor.Text;
          frmCtpAltGerAut.strCodCta       := frmCtpDigGerAut.fraPlanoDeContas.MskCodCta.Text;
          frmCtpAltGerAut.strDesCta       := frmCtpDigGerAut.fraPlanoDeContas.edtDesCta.Text;
          frmCtpAltGerAut.strPrevis       := frmCtpDigGerAut.edtPrevis.Text;
          frmCtpAltGerAut.strVeioNF       := frmCtpDigGerAut.edtVeioNF.Text;
          frmCtpAltGerAut.strUsoCon       := frmCtpDigGerAut.edtUsoCon.Text;
          frmCtpAltGerAut.strPagAnt       := frmCtpDigGerAut.edtPagAnt.Text;

          frmCtpAltGerAut.ShowModal;

          If frmCtpAltGerAut.blnConfirma Then
          Begin
            pCriarFormularios(TfrmGravando,frmGravando);
            Try
              frmGravando.fExecutarAcao := fSalvarAlteracoes;
              frmGravando.lblGravando.Caption := 'Aguarde... Salvando as alterações dos títulos.';
              frmGravando.ShowModal;

              fMensagem('ATENÇÃO!', 'Os registros foram alterados com sucesso.', ['&Ok']);
              pLimpaEdits;
            Finally
              pFreeAndNil(frmGravando);
            End;
          End;
        finally
          pFreeAndNil(frmCtpAltGerAut);
        end;
      End;

    finally
      pFreeAndNil(frmCtpDigGerAut);
      pSetFocus(edtCodFor);
    end;

  End
  Else
  Begin
    pMarcaDuplicata(False);
  End;
end;

procedure TfrmManGerAutCtaPagar.fraCentroCustoedtCodEveExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Evento');
end;

procedure TfrmManGerAutCtaPagar.fraPlanoDeContasMskCodCtaExit(Sender: TObject);
begin
  inherited;
  fraPlanoDeContas.MskCodCtaExit(Sender);

  pEdtCodSelectExit(fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, arrCentCusto, fRetNomeConta, Nil, 'da Conta');

end;

procedure TfrmManGerAutCtaPagar.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentCusto, False) Then
  Begin
    If fValidaCampos(fraPlanoDeContas.MskCodCta, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmManGerAutCtaPagar.fSalvarAlteracoes(pgbStatus: TcxProgressBar = Nil): Boolean;
Var
  qryUpd: TUniQuery;
  prcScroll  : TprcScroll;
begin
  Result := False;
  qryUpd := fCriaQuery(Self);
  try
    Try
      fStartTransaction;

      pgbStatus.Position := 0;
      pgbStatus.Properties.Max :=  cdsCtaPagNovo.RecordCount;

      pDisableControls(cdsCtaPagNovo, prcScroll);
      cdsCtaPagNovo.AggregatesActive := False;

      cdsCtaPagNovo.First;
      While Not cdsCtaPagNovo.Eof Do
      Begin
        qryUpd.SQL.Clear;
        qryUpd.SQL.Add('UPDATE CADPAG SET ');
        qryUpd.SQL.Add(' CTP_DTAVEN = :CTP_DTAVEN, ');
        qryUpd.SQL.Add(' CTP_DTACAD = :CTP_DTACAD, ');
        qryUpd.SQL.Add(' CTP_VALDUP = IFNULL(:CTP_VALDUP,0), ');
        qryUpd.SQL.Add(' CTP_JURSUJ = IFNULL(:CTP_JURSUJ,0), ');
        qryUpd.SQL.Add(' CTP_MULSUJ = IFNULL(:CTP_MULSUJ,0), ');
        qryUpd.SQL.Add(' CTP_DESSUJ = IFNULL(:CTP_DESSUJ,0), ');
        qryUpd.SQL.Add(' CTP_VALORI = IFNULL(:CTP_VALORI,0), ');
        qryUpd.SQL.Add(' CTP_CODPOR = IF(:CTP_CODPOR = '''', NULL, :CTP_CODPOR), ');
        qryUpd.SQL.Add(' CTP_CODEVE = IF(:CTP_CODEVE = '''', NULL, :CTP_CODEVE), ');
        qryUpd.SQL.Add(' CTP_CODCTA = IF(:CTP_CODCTA = '''', NULL, :CTP_CODCTA), ');
        qryUpd.SQL.Add(' CTP_COMPET = IF(:CTP_COMPET = '''', NULL, :CTP_COMPET), ');
        qryUpd.SQL.Add(' CTP_PREVIS = IF(:CTP_PREVIS = '''', NULL, :CTP_PREVIS), ');
        qryUpd.SQL.Add(' CTP_VEIONF = IF(:CTP_VEIONF = '''', NULL, :CTP_VEIONF), ');
        qryUpd.SQL.Add(' CTP_USOCON = IF(:CTP_USOCON = '''', NULL, :CTP_USOCON), ');
        qryUpd.SQL.Add(' CTP_PAGANT = IF(:CTP_PAGANT = '''', NULL, :CTP_PAGANT) ');
        qryUpd.SQL.Add('WHERE ');
        qryUpd.SQL.Add('	AUTOINCREM = :AUTOINCREM ');
        qryUpd.ParamByName('CTP_DTAVEN').AsDateTime := cdsCtaPagNovo.FieldByName('CTP_DTAVEN').AsDateTime;
        qryUpd.ParamByName('CTP_DTACAD').AsDateTime := cdsCtaPagNovo.FieldByName('CTP_DTACAD').AsDateTime;
        qryUpd.ParamByName('CTP_VALDUP').AsFloat := cdsCtaPagNovo.FieldByName('CTP_VALDUP').AsFloat;
        qryUpd.ParamByName('CTP_JURSUJ').AsFloat := cdsCtaPagNovo.FieldByName('CTP_JURSUJ').AsFloat;
        qryUpd.ParamByName('CTP_MULSUJ').AsFloat := cdsCtaPagNovo.FieldByName('CTP_MULSUJ').AsFloat;
        qryUpd.ParamByName('CTP_DESSUJ').AsFloat := cdsCtaPagNovo.FieldByName('CTP_DESSUJ').AsFloat;
        qryUpd.ParamByName('CTP_VALORI').AsFloat := cdsCtaPagNovo.FieldByName('CTP_VALORI').AsFloat;
        qryUpd.ParamByName('CTP_CODPOR').AsString := cdsCtaPagNovo.FieldByName('CTP_CODPOR').AsString;
        qryUpd.ParamByName('CTP_CODEVE').AsString := cdsCtaPagNovo.FieldByName('CTP_CODEVE').AsString;
        qryUpd.ParamByName('CTP_CODCTA').AsString := cdsCtaPagNovo.FieldByName('CTP_CODCTA').AsString;
        qryUpd.ParamByName('CTP_COMPET').AsString := cdsCtaPagNovo.FieldByName('CTP_COMPET').AsString;
        qryUpd.ParamByName('CTP_PREVIS').AsString := cdsCtaPagNovo.FieldByName('CTP_PREVIS').AsString;
        qryUpd.ParamByName('CTP_VEIONF').AsString := cdsCtaPagNovo.FieldByName('CTP_VEIONF').AsString;
        qryUpd.ParamByName('CTP_USOCON').AsString := cdsCtaPagNovo.FieldByName('CTP_USOCON').AsString;
        qryUpd.ParamByName('CTP_PAGANT').AsString := cdsCtaPagNovo.FieldByName('CTP_PAGANT').AsString;
        qryUpd.ParamByName('AUTOINCREM').AsString := cdsCtaPagNovo.FieldByName('AUTOINCREM').AsString;
        qryUpd.ExecSQL;

        {**********************************************}
        {* CASO GRAVOU, GRAVA A TABELA CTPDET, LOGCTP *}
        {****************************************MV,BB*}
        GravaLogCtp(cdsCtaPagNovo.FieldByName('AUTOINCREM').AsString,
                    'ALTERACAO - GERACAO AUTOMATICA');

        If (Not fAtualizaCtpDet(cdsCtaPagNovo.FieldByName('NRODUP').AsString,
                                cdsCtaPagNovo.FieldByName('CTP_PARCEL').AsString,
                                cdsCtaPagNovo.FieldByName('CTP_CODEMP').AsString,
                                cdsCtaPagNovo.FieldByName('CTP_CODFOR').AsString,
                                cdsCtaPagNovo.FieldByName('CTP_SERIE_').AsString)) Then
        Begin
          fRollBack;
          Exit;
        End;

        pStepStatusGravacao(pgbStatus);

        cdsCtaPagNovo.Next;
      end;

      fCommit;
      Result := True;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[dbgDuplicatasViewDblClick]');
      End;
    End;
  finally
    FreeAndNil(qryUpd);
    cdsCtaPagNovo.AggregatesActive := True;
    pEnableControls(cdsCtaPagNovo, prcScroll);
  end;
end;

procedure TfrmManGerAutCtaPagar.pCarregaCentroCusto;
begin
  pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text);
  With qryConCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmManGerAutCtaPagar.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmManGerAutCtaPagar.pCarregaEventos;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmManGerAutCtaPagar.pCarregaEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  End
  Else
    edtNomEmp.Clear;
end;

procedure TfrmManGerAutCtaPagar.pLimpaEdits;
begin

  edtNomFor.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  fraCentroCusto.edtDesEve.Clear;
  edtNomEmp.Clear;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  mskDtaCadIni.Clear;
  mskDtaCadFin.Clear;
  fraPlanoDeContas.MskCodCta.Clear;
  edtCodFor.Clear;
  fraCentroCusto.edtCodEve.Clear;
  edtCodEmp.Clear;
  edtNumDup.Clear;
  edtSerie.Clear;

  cdsCtaPag.AfterScroll := nil;
  pLiberaDupsMarcadas;
  cdsCtaPag.Filtered := False;
  cdsCtaPag.Close;
end;

function TfrmManGerAutCtaPagar.fGetEmpAceCtp: String;
begin
  Result:= fCampoTabela('OPE_EMPCTP', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);

  Result := Copy(Result, 0, (Length(Result) -1));

  If Not fEmptyStr(Result) Then
    Result := AnsiReplaceStr(Result,'_', ',');

end;


procedure TfrmManGerAutCtaPagar.pMarcaFornecedor(chave, marcaDesmarca:String);
  Var
    i: integer;
begin

  if marcaDesmarca = 'M' then
    lstFornecedor.Add(chave)
  else
  begin
    for i:= 0 to lstFornecedor.count -1 do
      if chave = lstFornecedor[i] then
      begin
        lstFornecedor.Delete(i);
        Break;
      end;
  end;
end;

//MF: 281423 - 27/04/2023  - DESMEMBRAMENTO
function TfrmManGerAutCtaPagar.fAtualizaCtpDet(strNumDup, strParcel, strCodEmp, strCodFor, strSerie: String): Boolean;
Var
  LCtpDetDuplicata: TUniQuery;

  LExcluirTodos: Boolean;

  LCTPDetTemp: TUniClientDataSet;
begin
  Result := False;
  LCtpDetDuplicata := fCriaQuery;
  LCtpDetDuplicata.SQL.Text := 'SELECT * ' +
                               'FROM CTPDET ' +
                               'WHERE CTP_NUMDUP=:NUMDUP ' +
                               '  AND CTP_PARCEL=:PARCEL ' +
                               '  AND CTP_EMPORI=:CODEMP ' +
                               '  AND CTP_CODFOR=:CODFOR ';
  If strSerie.isEmpty Then
    LCtpDetDuplicata.SQL.Add('  AND (CTP_SERIE_ IS NULL OR CTP_SERIE_="") ')
  Else
    LCtpDetDuplicata.SQL.Add('  AND (CTP_SERIE_= "' + strSerie + '") ');

  LCTPDetTemp := TUniClientDataset.Create(Nil);


  Try
    Try
      If FDatasetCtpDet.IsEmpty Then
        Exit(True);

      FDatasetCtpDet.Filter := 'TIPOACAO<>''0'' ';
      FDatasetCtpDet.Filtered := True;

      If FDatasetCtpDet.IsEmpty Then
        Exit(True);

      FDatasetCtpDet.Filtered := False;
      LCTPDetTemp := fCriaClientDatSet(FDatasetCtpDet);
      LCTPDetTemp.Open;

      LCTPDetTemp.Filter := 'TIPOACAO=''3'' ';
      LCTPDetTemp.Filtered := True;

      LExcluirTodos := False;
      If Not FDatasetCtpDetClone.IsEmpty Then
        LExcluirTodos := LCTPDetTemp.RecordCount = FDatasetCtpDetClone.RecordCount;

      LCTPDetTemp.Filtered := False;

      LCTPDetTemp.First;
      While not LCTPDetTemp.EOF do
      Begin
        If LCTPDetTemp.FieldByname('TIPOACAO').AsString.Equals('3') Then
        Begin
          LCTPDetTemp.Delete;

          Continue;
        End;

        LCTPDetTemp.Edit;
        LCTPDetTemp.FieldByName('INCREMENTO').AsString := '';
        LCTPDetTemp.FieldByName('TIPOACAO').AsString := '1';
        LCTPDetTemp.Post;

        LCTPDetTemp.Next;
      End;

      LCtpDetDuplicata.Close;
      LCtpDetDuplicata.ParamByName('NUMDUP').AsString := strNumDup;
      LCtpDetDuplicata.ParamByName('PARCEL').AsString := strParcel;
      LCtpDetDuplicata.ParamByName('CODEMP').AsString := strCodEmp;
      LCtpDetDuplicata.ParamByName('CODFOR').AsString := strCodFor;
      LCtpDetDuplicata.Open;

      While Not LCtpDetDuplicata.Eof Do
      Begin
        untLogCtpDet.GravaLogCtpDet(LCtpDetDuplicata.FieldByName('AUTOINCREM').AsString,
                                    'EXCLUSÃO',
                                    Self.Name);

        LCtpDetDuplicata.Delete;
      End;
      LCtpDetDuplicata.Close;

      If LExcluirTodos Then
        Exit(True);

      Result := fGravaFatorCalculado(strNumDup,
                                     strParcel,
                                     strCodEmp,
                                     strCodFor,
                                     strSerie,
                                     LCTPDetTemp,
                                     Self.Name,
                                     True);

      If (Not Result) Then
        Raise Exception.Create('Ocorreu um erro ao gravar o desmembramento das duplicatas');
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message + ' - [TfrmManGerAutCtaPagar.fAtualizaCtpDet]');
    End;
  Finally
    FDatasetCtpDet.Filtered := False;

    FreeAndNil(LCTPDetTemp);

    FreeAndNil(LCtpDetDuplicata);
    Application.ProcessMessages;
  end;

end;

end.
