unit untRelFatExtratoProfissional;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, RLFilters, RLDraftFilter,
  AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel, ExtCtrls, BitBtnLockedIncrem,
  Buttons, Mask, MaskEditFocus, CurrencyEditFocus, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxCurrencyEdit, untTypesSistema;

type
  TfrmRelFatExtratoProfissional = class(TfrmPaiRelatorio)
    lbl1: TLabel;
    mskDtaIni: TMaskEditFocus;
    lblDtaIni: TLabel;
    lbl2: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblDtaFin: TLabel;
    lbl3: TLabel;
    mskDtaBai: TMaskEditFocus;
    lbl4: TLabel;
    mskDtaBaf: TMaskEditFocus;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    edtCodPro: TEditFocus;
    edtNomPro: TEditFocus;
    lbl8: TLabel;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    lbl9: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lbl10: TLabel;
    edtCodRed: TEditFocus;
    edtNomRed: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    rdgOpcao: TRadioGroup;
    gpbFiltro: TGroupBox;
    ColorLabel3: TColorLabel;
    edtFiltro: TEditFocus;
    lbl11: TLabel;
    edtValMin: TCurrencyEditFocus;
    rdgTipCom: TRadioGroup;
    rdgOrdena: TRadioGroup;
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodProExit(Sender: TObject);
  private
    { Private declarations }
    arrAtividade: TConsultasArray;
    arrCliente: TConsultasArray;
    arrEmpresa: TConsultasArray;
    arrProfissional: TConsultasArray;
    arrRedeLojas: TConsultasArray;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelFatExtratoProfissional: TfrmRelFatExtratoProfissional;

implementation

uses untFuncoes, untFuncoesSimples, untConsultas,
     untIFastPrint, Uni, untClassPanelCx, untFuncoesRelatorios,
     untExtratoComissaoProfissional, untIFuncoes, untLayoutsImpressao,
     untFastPrintEditor, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmRelFatExtratoProfissional.btnImprimirClick(Sender: TObject);
  Var
    ExtratoPro: IFastPrintFile;
    editorFast: IFastPrintFileEditor;
    strTCoPro : String;
begin
  inherited;
  Try
    btnImprimir.Enabled := False;
    If blnImprime Then
    Begin
      pnlInfo.Caption := 'Gerando Relatório...';
      pnlInfo.Repaint;
      Application.ProcessMessages;

      strTCoPro := '';

      If rdgTipCom.Visible Then
      Begin
        Case rdgTipCom.ItemIndex Of
          0: strTCoPro := '1';//Valor
          1: strTCoPro := '3';//Pontos
        End;
      End;

      editorFast := TFastPrintFileEditor.Create(frmRelFatExtratoProfissional);
      ExtratoPro := TExtratoComissaoProfissional.CreateInstance( StrToDateDef(mskDtaIni.Text, 0),
                                                                 StrToDateDef(mskDtaFin.Text, 0),
                                                                 StrToDateDef(mskDtaBai.Text, 0),
                                                                 StrToDateDef(mskDtaBaf.Text, 0),
                                                                 edtCodPro,
                                                                 edtCodAti,
                                                                 edtCodCli,
                                                                 edtCodRed,
                                                                 edtCodEmp,
                                                                 arrProfissional,
                                                                 arrAtividade,
                                                                 arrCliente,
                                                                 arrRedeLojas,
                                                                 arrEmpresa,
                                                                 edtValMin.Value,
                                                                 rdgOpcao.ItemIndex + 1,
                                                                 edtFiltro.Text,
                                                                 strTCoPro,
                                                                 rdgOrdena.ItemIndex + 1);

      editorFast.pSetFastPrintFile(ExtratoPro);

      If Not ExtratoPro.IsEmpty Then
      Begin

        If editorFast.fLoadReport Then
        Begin
          If (edtDestino.Text = 'V') Then
            editorFast.pPreview
          Else
            editorFast.pPrint;
        End
        Else
        Begin
          fMensagem('', 'O layout para esse relatório não foi configurado para '
                       +'a empresa '+VS_strCodEmp+' - '+fRetNomeEmpresa+'.'+#13
                       +'Favor entrar em contato com o suporte da Citel.',
                       ['&O k']);
        End;
      End
      Else
        pTabelaVazia;

      //FreeAndNil(editorFast);

    End;
  Finally
    btnImprimir.Enabled := True;
    pnlInfo.Caption     := '';
    pSetFocus(mskDtaIni);
    ExtratoPro._Release;
    editorFast._Release;
  End;
end;

procedure TfrmRelFatExtratoProfissional.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtDesAti, arrAtividade, Nil, fRetNomAtividade, 'da Atividade', 0, False, 'Código', True);
end;

procedure TfrmRelFatExtratoProfissional.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrAtividade, False) Then
  Begin
    If fValidaCampos(edtCodAti, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatExtratoProfissional.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrCliente, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmRelFatExtratoProfissional.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatExtratoProfissional.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpresa, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
end;

procedure TfrmRelFatExtratoProfissional.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatExtratoProfissional.edtCodProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPro, edtNomPro, arrProfissional, fRetNomDiversos, Nil, 'do Profissional');
end;

procedure TfrmRelFatExtratoProfissional.edtCodProKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDiversos(Self, edtCodPro, edtNomPro, Nil, Key, arrProfissional, False) Then
  Begin
    If fValidaCampos(edtCodPro, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatExtratoProfissional.edtCodRedExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRed, edtNomRed, arrRedeLojas, Nil, fRetNomeRedeLoja, 'da Rede de Lojas', 0, False, 'Código', True);
end;

procedure TfrmRelFatExtratoProfissional.edtCodRedKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRedeLojas(Self, edtCodRed, edtNomRed, Nil, Key, arrRedeLojas, False) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatExtratoProfissional.FormCreate(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

  If fCfgSis('TCOPRO') <> '4' Then
  Begin
    rdgTipCom.Visible := False;
    rdgOrdena.Left := rdgTipCom.Left;
  End;

end;

procedure TfrmRelFatExtratoProfissional.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    If (ActiveControl.Parent = rdgOpcao) Or
       (ActiveControl.Parent = rdgTipCom) Then
      SelectNext(ActiveControl, True, True);
end;

function TfrmRelFatExtratoProfissional.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      mskDtaFin.Clear
    Else
    Begin
      If (Sender = mskDtaFin) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
            Result := False;
          End;
        End;
      End
    End;
  End
  Else If (Sender = mskDtaBai) Or (Sender = mskDtaBaf) Then
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaBai.Text)) Then
    Begin
      If (Sender = mskDtaBaf) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaBaf.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaBai.Text) > StrToDate(mskDtaBaf.Text) Then
          Begin
            fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
            Result := False;
          End;
        End;
      End
    End
    Else
      mskDtaBaf.Clear;
  End
  Else If (Sender = edtCodPro) Then
  Begin
    pDesmarcaLista(edtCodPro,arrProfissional);
  End
  Else If (Sender = edtCodAti) Then
  Begin
    pDesmarcaLista(edtCodAti,arrAtividade);
  End
  Else If (Sender = edtCodCli) Then
  Begin
    pDesmarcaLista(edtCodCli,arrCliente);
  End
  Else If (Sender = edtCodRed) Then
  Begin
    pDesmarcaLista(edtCodRed,arrRedeLojas);
  End
  Else If (Sender = edtCodEmp) Then
  Begin
    pDesmarcaLista(edtCodEmp,arrEmpresa);
  End
  Else If (Sender = edtFiltro) Then
  Begin
    If (Pos(edtFiltro.Text,'B_P_T_') <= 0) Then
    Begin
      fMensagem('','O campo Filtro deve ser P, B ou T!', ['&OK']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
