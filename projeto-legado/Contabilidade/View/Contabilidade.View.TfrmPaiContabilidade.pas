unit Contabilidade.View.TfrmPaiContabilidade;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Menus, StdCtrls, Buttons, Controls,
  ExtCtrls, Graphics, Forms, Dialogs, ComCtrls, DBCtrls, DBEditFocus, TypInfo,
  EditFocus, DBGridCitel, DBGrids, Grids, DBComboBoxFocus, ComboBoxFocus, MaskEditFocus,
  Uni, DB, Mask, FilenameEditFocus, DirectoryEditFocus, AppEvnts, cxGridCitel,
  Messages, CurrencyEditFocus, untFuncoesGenerica, untLabelRg, untLabelCgcCpf,
  untMskC_G_C_, untMskTelefone, untLabelCgc, untLabelCpf, untDBECgcCpf,
  untDBETipoCgcCpf, untEditTipoCgcCpf, BitBtnLockedIncrem, DBLookupComboBoxFocus,
  ShellAPI, frxClass, frxExportCSVTestabilidade, DateUtils, cxCheckBox, strUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, frxExportPDF, untTypesSistema,
  cxControls, cxGroupBox, cxCustomListBox, cxCheckListBox, Vcl.Themes,
  Contabilidade.View.TFrameDirectoryEditFocus, cxGrid, cxGridTableView, cxFilter, UxTheme,
  cxCheckComboBox, cxDBCheckComboBox, Contabilidade.FuncoesFormPai, Contabilidade.InterfaceTrace;

type
  TfrmPaiContabilidade = class(TForm)
    pnlBotoes: TPanel;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    mnuAuxiliar: TPopupMenu;
    mnuConfigurarRel: TMenuItem;
    mnuHabilitarSQLTrace: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    btnSair: TBitBtnLocked;
    frxCSVExportTestabilidade: TfrxCSVExportTestabilidade;
    FlwBotoes: TFlowPanel;
    pnlBotoesTrace: TPanel;
    btnIniciarTrace: TSpeedButton;
    btnPausarTrace: TSpeedButton;
    btnSalvarTrace: TSpeedButton;
    btnViewerTrace: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mnuConfigurarRelClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnIniciarTraceClick(Sender: TObject);
    procedure btnPausarTraceClick(Sender: TObject);
    procedure btnSalvarTraceClick(Sender: TObject);
    procedure btnViewerTraceClick(Sender: TObject);
    procedure mnuHabilitarSQLTraceClick(Sender: TObject);
  private
    { Private declarations }
    FPais: TPais;
    FPrimeiraVez: Boolean;
    FOriginalCaption: String;

    function fDataMuitoAntiga(Sender: TObject): Boolean;
    procedure pSetarQueryTraceViewerEvents;
    procedure pIniTraceForms;
    procedure pAtualizaControlsTrace;
    procedure pFinalizarSQLTrace;
    procedure pSetaCaseInsensitiveCXGrid;
    procedure pDesligarTemaBotoes;
    procedure pAjustarTema(AParent: TWinControl);
    function fVersaoSistema(): String;
    procedure pAjustaControl(AControl: TControl);
    procedure pAjustaControlTEdit(AControl: TControl);
    procedure pAjustaCxControl(AControl: TcxControl);
    function fValidaCamposFrameDirectoryEditFocus(Sender: TWinControl;
      blnBuscaPorChave: Boolean): Boolean;
    procedure pSetaEventoTLabelRg(const AComponente: TComponent) ;
    procedure pSetaEventoTLabelCgcCpf(const AComponente: TComponent) ;
    procedure pSetaEventoTLabelCgc(const AComponente: TComponent) ;
    procedure pSetaEventoTLabelCpf(const AComponente: TComponent) ;
    procedure pSetaEventoTDBEditCgcCpf(const AComponente: TComponent) ;
    procedure pSetaEventoTDBEditTipoCgcCpf(const AComponente: TComponent) ;
    procedure pSetaEventoTEditTipoCgcCpf(const AComponente: TComponent) ;
    procedure pSetaEventoTDBEditFocus(const AComponente: TComponent) ;
    procedure pSetaEventoTcxDBDateEdit(const AComponente: TComponent) ;
    procedure pSetaEventoTDBCheckBox(const AComponente: TComponent) ;
    procedure pSetaEventoTCheckBox(const AComponente: TComponent) ;
    procedure pSetaEventoTcxCheckBox(const AComponente: TComponent) ;
    procedure pSetaEventoTcxDBCheckBox(const AComponente: TComponent) ;
    procedure pSetaEventoTRadioButton(const AComponente: TComponent) ;
    procedure pSetaEventoTDBComboBoxFocus(const AComponente: TComponent) ;
    procedure pSetaEventoTDBLookupComboBox(const AComponente: TComponent) ;
    procedure pSetaEventoTEditFocus(const AComponente: TComponent) ;
    procedure pSetaEventoTcxCustomRadioGroupButton(const AComponente: TComponent) ;
    procedure pSetaEventoTcxDBRadioGroup(const AComponente: TComponent) ;
    procedure pSetaEventoTMaskEditTelefone(const AComponente: TComponent) ;
    procedure pSetaEventoTMaskEditFocus(const AComponente: TComponent) ;
    procedure pSetaEventoTFilenameEditFocus(const AComponente: TComponent) ;
    procedure pSetaEventoTfraDirectoryEditFocusContabilidade(const AComponente: TComponent) ;
    procedure pSetaEventoTComboBoxFocus(const AComponente: TComponent) ;
    procedure pSetaEventoTcxCheckComboBox(const AComponente: TComponent) ;
    procedure pSetaEventoTcxDBCheckComboBox(const AComponente: TComponent) ;
    procedure pSetaEventoTcxDateEdit(const AComponente: TComponent) ;
    procedure pSetaEventoTcxDBMaskEdit(const AComponente: TComponent) ;
    procedure pSetaEventoTcxComboBox(const AComponente: TComponent) ;
    procedure pSetaEventoTCurrencyEditFocus(const AComponente: TComponent) ;
    procedure pSetaEventoTDBGridCitel(const AComponente: TComponent) ;
    procedure pSetaEventoTcxGridDBTableViewCitel(const AComponente: TComponent) ;
    procedure pSetaEventoTcxGridDBBandedTableViewCitel(const AComponente: TComponent) ;
    procedure pSetaEventoTfrxReport(const AComponente: TComponent) ;
    procedure pSetaEventoTfrxPDFExport(const AComponente: TComponent) ;
    procedure pSetaEventoTBitBtnLocked(const AComponente: TComponent; const blnAutBan:boolean) ;
    procedure pSetaEventoTFrame(const AComponente: TComponent) ;
    procedure pActivateModoClassico ;
  protected
    stlCampos: TStringList;
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    qryTabela: TUniQuery;
    qryCfgRel: TUniQuery;
    blnLibCnf: Boolean;
    strSenha : String;
    blnValidaDataMuitoAntiga: Boolean;
    blnValidarComTAB: Boolean;

    intSemaforoKeyDown: Integer;

    procedure pOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;

    procedure pProximoControle(Sender: TObject); virtual;
    procedure pEscapePressed; virtual;

    //*************************************************//
    // FUNCOES ESPECIFICAS PARA O AUTBAN               //
    //**********************************************ED*//
    procedure pCarKeyAutBan;
    procedure pOnKeyDownAutBan(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure pOnKeyDownEditsAutBan(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure pCriaFormCfgAtb(strNomCam: String);
    
    procedure pOnBitBtnErro(Sender: TWinControl; strMsgErro: string;
      E: Exception);

    {*******************************************}
    {* FUNÇÕES DE VALIDAÇÃO!                   *}
    {****************************************MV*}
    function fVerificaCampos: Boolean;
    function fValidaPanel(pnlPanel: TPanel; blnBuscaPorChave: Boolean = False; blnStopOnError : Boolean = True): Boolean;
    function fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
    function fVerificaSubControl(objObjeto: TWinControl): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; virtual;

    function HandleCreateException: Boolean; override;

    procedure pSelNext;

    procedure pSetaEventos(SelfWin: TWinControl);

    function IsWindows7Classic: Boolean;

  public
    { Public declarations }
    {*****************************************}
    {* REPRESENTA O ÚLIMO REGISTRO INSERIDO  *}
    {* OU ALTERADO NA SESSÃO                 *}
    {**************************************MV*}
    {*****************************************}
    {* ESTA VARIAVEL VEIO PARA O PAI DEVIDO  *}
    {* AO CADASTRO DE ABREVIAÇÃO DO PIS/CONF.*}
    {*************************************GB**}
    strUltimoCodigo: String;

    strFilRel: String;
    blnFecharComEscape: Boolean;
    blnFecharFormPai: Boolean;
    blnMudarFoco: Boolean;

    objTracePai: ISQLTraceContabilidade;

    procedure pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TDBEdit; blnHabilitar: Boolean); overload;
    procedure pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TEditFocus; blnHabilitar: Boolean); overload;
    procedure pHabilitaCodigo(dbeCampoEnable: TDBEdit; dbeCampoFocus: TWinControl; blnHabilitar: Boolean); overload;
    procedure pSQLTrace(Sender: TObject; blnAuth: Boolean = False; blnCabecalho: Boolean = False);

  published
    property OriginalCaption: String Read FOriginalCaption;
  end;

implementation

uses untConstantes, untFuncoesSimples, untCfgAtb, untCadConfRelatorios, cxCalendar,
  cxDbEdit, Contabilidade.TSQLTrace, cxRadioGroup, untVersaoProg, cxCheckGroup;

{$R *.dfm}

procedure TfrmPaiContabilidade.pActivateModoClassico;
Var
  LMonitor: TMonitor;
begin
  If (Not blnUsuarioLogadoUtilizaModoClassico) Then
  Begin
    LMonitor := TMonitor(Screen.MonitorFromWindow(Application.Handle));

    If (fUsaDoisMonitores) And
       (Self.Height > LMonitor.WorkareaRect.Height) Then
      Self.WindowState := wsMaximized;

    If (IsWindows7Classic) Then
    Begin
      If (Self.WindowState = wsMaximized) And
         (Self.Height > Screen.WorkAreaRect.Height) Then
      Begin
        Self.BorderIcons := [biSystemMenu];
        Self.Height := Screen.WorkAreaRect.Height + 3;
        Self.Repaint;
      End;
    End;
  End;
end;

procedure TfrmPaiContabilidade.pAjustaControl(AControl: TControl);
begin
  If IsPublishedProp(AControl, 'ParentBackground') Then
    SetPropValue(AControl, 'ParentBackground', False);

  If IsPublishedProp(AControl, 'Color') Then
    If GetPropValue(AControl, 'Color') = $00FFE4D5 Then
      SetPropValue(AControl, 'Color', TStyleManager.ActiveStyle.GetStyleColor(scPanel));

  If AControl Is TPanel Then
    If TPanel(AControl).Color = clGray Then
       TPanel(AControl).Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);

  If AControl Is TLabel Then
    If TLabel(AControl).Font.Color <> clBlack Then
      If TLabel(AControl).Font.Color <> clWhite Then
        TLabel(AControl).StyleElements :=
          TLabel(AControl).StyleElements - [seFont];

  pAjustaControlTEdit(AControl) ;

  If AControl Is TBitBtn Then
    TBitBtn(AControl).StyleElements := [];
end;

procedure TfrmPaiContabilidade.pAjustaControlTEdit(AControl: TControl);
begin
  If AControl Is TEdit Then
    If TEdit(AControl).Font.Color <> clBlack Then
      If TEdit(AControl).Font.Color <> clWhite Then
        TEdit(AControl).StyleElements :=
          TEdit(AControl).StyleElements - [seFont];
end;

procedure TfrmPaiContabilidade.pAjustaCxControl(AControl: TcxControl);
begin
  If IsPublishedProp(AControl, 'ParentBackground') Then
    SetPropValue(AControl, 'ParentBackground', False);

  If (AControl Is TcxGroupBox) Then
  Begin
    TcxGroupBox(AControl).Style.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);
    TcxGroupBox(AControl).Transparent := True;
  End;

  If (AControl Is TcxCheckListBox) Then
    TcxCheckListBox(AControl).Style.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);
end;

procedure TfrmPaiContabilidade.FormActivate(Sender: TObject);
begin
  If (Assigned(VS_TraceContabilidade)) and (VS_TraceContabilidade.GetAutenticado()) And (Assigned(VS_objTraceViewerContabilidade)) Then
    pIniTraceForms;

  If fUsaLayoutNovo And fUsaDoisMonitores Then
    pCentralizarForm(Self);

  If Not blnUsuarioLogadoUtilizaModoClassico Then
    If TStyleManager.ActiveStyle.Name = AUTCOM_STYLE_NAME Then
      pAjustarTema(Self);

  VS_strTituloVersao := '   -   ' + fVersaoSistema();

  If String(Caption).Contains(VS_strTituloVersao) Then
    Caption := AnsiReplaceStr(Caption, VS_strTituloVersao, '');

  Caption := Caption + VS_strTituloVersao;

  pActivateModoClassico ;

  If Self.AlphaBlend Then
  Begin
    Self.AlphaBlendValue := 255;
    Self.AlphaBlend := False;
  End;

  If FPrimeiraVez Then
  Begin
    If Assigned(VS_objTraceViewerContabilidade) And VS_objTraceViewerContabilidade.Visible Then
    Begin
      VS_objTraceViewerContabilidade.Show;
      SetForegroundWindow(Self.Handle);
    End;
  End;

  FPrimeiraVez := False;
end;

function TfrmPaiContabilidade.fVersaoSistema: String;
begin
  Result := TVersaoExecutavel.GetTituloVersao + ' - Emp: ' + VS_strCodEmp;
end;

procedure TfrmPaiContabilidade.pAjustarTema(AParent: TWinControl);
Var
  I: Integer;
begin
  If Self.Color = $00FFE4D5 Then
    Self.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);

  pnlBotoes.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);

  For I := 0 To AParent.ComponentCount -1 Do
  Begin
    If (AParent.Components[I] Is TControl) Then
      pAjustaControl(TControl(AParent.Components[I]));

    If (AParent.Components[I] Is TFrame) Then
      pAjustarTema(TWinControl(AParent.Components[I]));
  End;

  For I := 0 To AParent.ControlCount -1 Do
  Begin
    pAjustaControl(AParent.Controls[I]);

    If (AParent.Controls[I] Is TWinControl) Then
      pAjustarTema(TWinControl(AParent.Controls[I]));
  End;

  For I := 0 To AParent.ControlCount -1 Do
  Begin
    If (AParent.Controls[I] Is TcxControl) Then
      pAjustaCxControl(TcxControl(AParent.Controls[I]));
  End;

end;

procedure TfrmPaiContabilidade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//
end;

procedure TfrmPaiContabilidade.FormCreate(Sender: TObject);
begin
  FPrimeiraVez := True;

  pDesligarTemaBotoes;

  pSetarQueryTraceViewerEvents;

  If fUsaLayoutNovo Then
    If fUsaDoisMonitores Then
    Begin
      Self.Position := poDesigned;
      Self.AlphaBlendValue := 0;
      Self.AlphaBlend := True;
    End
    Else
      Self.Position := poDesktopCenter;

  blnValidaDataMuitoAntiga := True;
  blnValidarComTAB := False;

  strFilRel := '';

  If (Not fEmptyStr(VS_strCodEmp)) Then
    FPais := fSetaPais;

  {For intContador := 0 To Self.ComponentCount -1 Do
  Begin
    If (Self.Components[intContador] Is TLabelRg) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelRg(Self.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelRg(Self.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (Self.Components[intContador] Is TLabelCgcCpf) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelCgcCpf(Self.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelCgcCpf(Self.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (Self.Components[intContador] Is TLabelCgc) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelCgc(Self.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelCgc(Self.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (Self.Components[intContador] Is TLabelCpf) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelCpf(Self.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelCpf(Self.Components[intContador]).pSetaPais(opcParaguai);
    End;

  End;}

  intSemaforoKeyDown := -1;

  blnFecharComEscape := True;

  blnFecharFormPai := False;
  
  qryCfgRel := fCriaQuery(Self);

  If Not Assigned(utcRegistros) Then
    utcRegistros := TUltConsultas.Create;

  {*****************************************}
  {* PARA NAO DEIXAR O FORM AUMENTAR       *}
  {**************************************MV*}

  pnlNomeForm.Caption := Self.Name;
  blnMudarFoco := True;

  pSetaEventos(Self);

  FOriginalCaption := Self.Caption;

  //if Assigned(dmContabilidadeModuloLog) then
  //  if not dmContabilidadeModuloLog.sqlMonitor.Active then
  //     dmContabilidadeModuloLog.sqlMonitor.Active := True ;

End;

procedure TfrmPaiContabilidade.pSetaCaseInsensitiveCXGrid;
var
  intPai: Integer;
  intFilho: integer;
  objCxGrid: TcxGrid;
  objCxGridCitel: TcxGridCitel;
begin
  try
    for intPai := 0 to Self.ComponentCount - 1 do
    begin
      if (Self.Components[intPai] is TcxGrid) then
      begin
        objCxGrid := TcxGrid(Self.Components[intPai]);

        for intFilho := 0 to objCxGrid.ViewCount - 1 do
        begin
          TcxGridTableView(objCxGrid.Views[intFilho]).DataController.Filter.Options := TcxGridTableView(objCxGrid.Views[intFilho]).DataController.Filter.Options + [fcoCaseInsensitive];   
        end;
      end
      else if (Self.Components[intPai] is TcxGridCitel) then
      begin     
        objCxGridCitel := TcxGridCitel(Self.Components[intPai]);

        for intFilho := 0 to objCxGridCitel.ViewCount - 1 do
        begin
          TcxGridTableView(objCxGridCitel.Views[intFilho]).DataController.Filter.Options := TcxGridTableView(objCxGridCitel.Views[intFilho]).DataController.Filter.Options + [fcoCaseInsensitive];
        end;
      end;
    end;
  except
    // Foi deixado vazio porque como é o form pai e caso de um erro em algum cast o usuário continua seu procedimento normalmente,
    // só que a pesquisa dos componentes cxgrid e cxgridcitel estarão case sensitive.
  end;
end;

procedure TfrmPaiContabilidade.pSetaEventos(SelfWin: TWinControl);
  Var
    intContador: Integer;
    blnAutBan  : Boolean;
Begin
  blnAutBan := Pos('AUTBAN', UpperCase(Application.Title)) > 0;

  {*****************************************}
  {* ATRIBUI OS METODOS REFERENTES AO      *}
  {* EVENTO 'OnKeyDown' DOS COMPONENTES    *}
  {**************************************MV*}
  For intContador := 0 To SelfWin.ComponentCount -1 Do
  Begin

    pSetaEventoTLabelRg(SelfWin.Components[intContador]) ;

    pSetaEventoTLabelCgcCpf(SelfWin.Components[intContador]) ;

    pSetaEventoTLabelCgc(SelfWin.Components[intContador]) ;

    pSetaEventoTLabelCpf(SelfWin.Components[intContador]) ;

    pSetaEventoTDBEditCgcCpf(SelfWin.Components[intContador]) ;

    pSetaEventoTDBEditTipoCgcCpf(SelfWin.Components[intContador]) ;

    pSetaEventoTEditTipoCgcCpf(SelfWin.Components[intContador]) ;

    pSetaEventoTDBEditFocus(SelfWin.Components[intContador]) ;

    pSetaEventoTcxDBDateEdit(SelfWin.Components[intContador]) ;

    pSetaEventoTDBCheckBox(SelfWin.Components[intContador]) ;

    pSetaEventoTCheckBox(SelfWin.Components[intContador]) ;

    pSetaEventoTcxCheckBox(SelfWin.Components[intContador]) ;

    pSetaEventoTcxDBCheckBox(SelfWin.Components[intContador]) ;

    pSetaEventoTRadioButton(SelfWin.Components[intContador]) ;

    pSetaEventoTDBComboBoxFocus(SelfWin.Components[intContador]) ;

    pSetaEventoTDBLookupComboBox(SelfWin.Components[intContador]) ;

    pSetaEventoTEditFocus(SelfWin.Components[intContador]) ;

    pSetaEventoTcxCustomRadioGroupButton(SelfWin.Components[intContador]) ;

    pSetaEventoTcxDBRadioGroup(SelfWin.Components[intContador]) ;

    pSetaEventoTMaskEditTelefone(SelfWin.Components[intContador]) ;

    pSetaEventoTMaskEditFocus(SelfWin.Components[intContador]) ;

    pSetaEventoTFilenameEditFocus(SelfWin.Components[intContador]) ;

    pSetaEventoTfraDirectoryEditFocusContabilidade(SelfWin.Components[intContador]) ;

    pSetaEventoTComboBoxFocus(SelfWin.Components[intContador]) ;

    pSetaEventoTcxCheckComboBox(SelfWin.Components[intContador]) ;

    pSetaEventoTcxDBCheckComboBox(SelfWin.Components[intContador]) ;

    pSetaEventoTcxDateEdit(SelfWin.Components[intContador]) ;

    pSetaEventoTcxDBMaskEdit(SelfWin.Components[intContador]) ;

    pSetaEventoTcxComboBox(SelfWin.Components[intContador]) ;

    pSetaEventoTCurrencyEditFocus(SelfWin.Components[intContador]) ;

    pSetaEventoTDBGridCitel(SelfWin.Components[intContador]) ;

    pSetaEventoTcxGridDBTableViewCitel(SelfWin.Components[intContador]) ;

    pSetaEventoTcxGridDBBandedTableViewCitel(SelfWin.Components[intContador]) ;

    pSetaEventoTfrxReport(SelfWin.Components[intContador]) ;

    pSetaEventoTfrxPDFExport(SelfWin.Components[intContador]) ;

    pSetaEventoTBitBtnLocked(SelfWin.Components[intContador], blnAutBan) ;

    pSetaEventoTFrame(SelfWin.Components[intContador]) ;
  End;

end;

procedure TfrmPaiContabilidade.pSetaEventoTBitBtnLocked(
  const AComponente: TComponent; const blnAutBan:boolean);
begin
  If (blnAutBan) And (AComponente Is TBitBtnLocked) Then
  Begin
    If Not Assigned(TBitBtnLocked(AComponente).OnErro) Then
      TBitBtnLocked(AComponente).OnErro := pOnBitBtnErro;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTCheckBox(
  const AComponente: TComponent);
begin
  If (AComponente Is TCheckBox) Then
  Begin
    (AComponente As TCheckBox).OnKeyDown := pOnKeyDown;
  End;
end;

procedure TfrmPaiContabilidade.pSetaEventoTComboBoxFocus(
  const AComponente: TComponent);
begin
  If (AComponente Is TComboBoxFocus) Then
  Begin

    If (AComponente As TComboBoxFocus).Tag = 99 Then
      (AComponente As TComboBoxFocus).OnKeyDown := pOnKeyDownEdits
    Else
      (AComponente As TComboBoxFocus).OnKeyDown := pOnKeyDown;

  End
end;

procedure TfrmPaiContabilidade.pSetaEventoTCurrencyEditFocus(
  const AComponente: TComponent);
begin
  If (AComponente Is TCurrencyEditFocus) Then
  Begin
    If (AComponente As TCurrencyEditFocus).Tag = 99 Then
      (AComponente As TCurrencyEditFocus).OnKeyDown := pOnKeyDownEdits
    Else
      (AComponente As TCurrencyEditFocus).OnKeyDown := pOnKeyDown;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTcxCheckBox(
  const AComponente: TComponent);
begin
  If (AComponente Is TcxCheckBox) Then
  Begin
    (AComponente As TcxCheckBox).OnKeyDown := pOnKeyDown;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTcxCheckComboBox(
  const AComponente: TComponent);
begin
  If (AComponente Is TcxCheckComboBox) Then
  begin
    If (AComponente As TcxCheckComboBox).Tag = 99 Then
      (AComponente As TcxCheckComboBox).OnKeyDown := pOnKeyDownEdits
    Else
      (AComponente As TcxCheckComboBox).OnKeyDown := pOnKeyDown;
  end ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTcxComboBox(
  const AComponente: TComponent);
begin
  If (AComponente Is TcxComboBox) Then
  Begin

    If (AComponente As TcxComboBox).Tag = 99 Then
      (AComponente As TcxComboBox).OnKeyDown := pOnKeyDownEdits
    Else
      (AComponente As TcxComboBox).OnKeyDown := pOnKeyDown;

  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTcxCustomRadioGroupButton(
  const AComponente: TComponent);
begin
  If (AComponente Is TcxCustomRadioGroupButton) then
  begin
    If (AComponente As TcxCustomRadioGroupButton).Tag = 99 Then
      (AComponente As TcxCustomRadioGroupButton).OnKeyDown := pOnKeyDownEdits
    Else
      (AComponente As TcxCustomRadioGroupButton).OnKeyDown := pOnKeyDown;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTcxDateEdit(
  const AComponente: TComponent);
begin
  If (AComponente Is TcxDateEdit) Then
  Begin
    (AComponente As TcxDateEdit).ParentFont := False;
    If (AComponente As TcxDateEdit).Tag = 99 Then
      (AComponente As TcxDateEdit).OnKeyDown := pOnKeyDownEdits
    Else
      (AComponente As TcxDateEdit).OnKeyDown := pOnKeyDown;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTcxDBCheckBox(
  const AComponente: TComponent);
begin
  If (AComponente Is TcxDBCheckBox) Then
  Begin
    (AComponente As TcxDBCheckBox).OnKeyDown := pOnKeyDown;
  End;
end;

procedure TfrmPaiContabilidade.pSetaEventoTcxDBCheckComboBox(
  const AComponente: TComponent);
begin
  If (AComponente Is TcxDBCheckComboBox) Then
  begin
    If (AComponente As TcxDBCheckComboBox).Tag = 99 Then
      (AComponente As TcxDBCheckComboBox).OnKeyDown := pOnKeyDownEdits
    Else
      (AComponente As TcxDBCheckComboBox).OnKeyDown := pOnKeyDown;
  end ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTcxDBDateEdit(
  const AComponente: TComponent);
begin
  If (AComponente Is TcxDBDateEdit) Then
  Begin
    (AComponente As TcxDBDateEdit).OnKeyDown := pOnKeyDownEdits;

    (AComponente As TcxDBDateEdit).ParentFont := False;
      If (AComponente As TcxDBDateEdit).Tag = 99 Then
        (AComponente As TcxDBDateEdit).OnKeyDown := pOnKeyDownEdits
      Else
        (AComponente As TcxDBDateEdit).OnKeyDown := pOnKeyDown;

  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTcxDBMaskEdit(
  const AComponente: TComponent);
begin
  If (AComponente Is TcxDBMaskEdit) Then
  Begin

    If (AComponente As TcxDBMaskEdit).Tag = 99 Then
      (AComponente As TcxDBMaskEdit).OnKeyDown := pOnKeyDownEdits
    Else
      (AComponente As TcxDBMaskEdit).OnKeyDown := pOnKeyDown;

  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTcxDBRadioGroup(
  const AComponente: TComponent);
begin
  If (AComponente Is TcxDBRadioGroup) then
  begin
    If (AComponente As TcxDBRadioGroup).Tag = 99 Then
      (AComponente As TcxDBRadioGroup).OnKeyDown := pOnKeyDownEdits
    Else
      (AComponente As TcxDBRadioGroup).OnKeyDown := pOnKeyDown;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTcxGridDBBandedTableViewCitel(
  const AComponente: TComponent);
begin
  If (AComponente Is TcxGridDBBandedTableViewCitel) Then
  Begin
    TcxGridDBTableViewCitel(AComponente).CorZebra := fCfgSis('CORZEB', varInteger);
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTcxGridDBTableViewCitel(
  const AComponente: TComponent);
begin
  If (AComponente Is TcxGridDBTableViewCitel) Then
  Begin
    TcxGridDBTableViewCitel(AComponente).CorZebra := fCfgSis('CORZEB', varInteger);
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTDBCheckBox(
  const AComponente: TComponent);
begin
  If (AComponente Is TDBCheckBox) Then
  Begin
    (AComponente As TDBCheckBox).OnKeyDown := pOnKeyDown;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTDBComboBoxFocus(
  const AComponente: TComponent);
begin
  If (AComponente Is TDBComboBoxFocus) Then
  Begin
    (AComponente As TDBComboBox).OnKeyDown := pOnKeyDownEdits;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTDBEditCgcCpf(
  const AComponente: TComponent);
begin
  If (AComponente Is TDBEditCgcCpf) And (Not fPodeValidarCgcCpf(FPais)) Then
  Begin
    TDBEditCgcCpf(AComponente).OnKeyDown := pOnKeyDownEdits;
    TDBEditCgcCpf(AComponente).Tag := 0
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTDBEditFocus(
  const AComponente: TComponent);
begin
  If (AComponente Is TDBEditFocus) Then
  Begin
    (AComponente As TDBEditFocus).OnKeyDown := pOnKeyDownEdits;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTDBEditTipoCgcCpf(
  const AComponente: TComponent);
begin
  If (AComponente Is TDBEditTipoCgcCpf) Then
  Begin
    TDBEditTipoCgcCpf(AComponente).OnKeyDown := pOnKeyDownEdits;
    TDBEditTipoCgcCpf(AComponente).Visible   := fMostraTipoCgcCpf(FPais);

    If (Not TDBEditTipoCgcCpf(AComponente).Visible) Then
      TDBEditTipoCgcCpf(AComponente).Tag := 0;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTDBGridCitel(
  const AComponente: TComponent);
begin
  If (AComponente Is TDBGridCitel) Then
  Begin
    TDBGridCitel(AComponente).DrawingStyle := gdsClassic;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTDBLookupComboBox(
  const AComponente: TComponent);
begin
  If (AComponente Is TDBLookupComboBox) Then
  begin
    TDBLookupComboBox(AComponente).OnKeyDOwn := pOnKeyDownEdits
  end ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTEditFocus(
  const AComponente: TComponent);
begin
  If (AComponente Is TEditFocus) Then
  Begin
    (AComponente As TEditFocus).OnKeyDown := pOnKeyDownEdits;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTEditTipoCgcCpf(
  const AComponente: TComponent);
begin
  If (AComponente Is TEditTipoCgcCpf) Then
  Begin
    TEditTipoCgcCpf(AComponente).OnKeyDown := pOnKeyDownEdits;
    TEditTipoCgcCpf(AComponente).Visible   := fMostraTipoCgcCpf(FPais);

    If (Not TEditTipoCgcCpf(AComponente).Visible) Then
      TEditTipoCgcCpf(AComponente).Tag := 0;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTFilenameEditFocus(
  const AComponente: TComponent);
begin
  If (AComponente Is TFilenameEditFocus) Then
  Begin
    If (AComponente As TFilenameEditFocus).Tag = 99 Then
      (AComponente As TFilenameEditFocus).OnKeyDown := pOnKeyDownEdits
    Else
      (AComponente As TFilenameEditFocus).OnKeyDown := pOnKeyDown;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTfraDirectoryEditFocusContabilidade(
  const AComponente: TComponent);
begin
  If (AComponente Is TfraDirectoryEditFocusContabilidade) Then
  Begin
    If (AComponente As TfraDirectoryEditFocusContabilidade).Tag = 99 Then
      (AComponente As TfraDirectoryEditFocusContabilidade).edtDirectory.OnKeyDown := pOnKeyDownEdits
    Else
      (AComponente As TfraDirectoryEditFocusContabilidade).edtDirectory.OnKeyDown := pOnKeyDown;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTFrame(const AComponente: TComponent);
begin
  If (AComponente Is TFrame) Then
    pSetaEventos(TFrame(AComponente));
end;

procedure TfrmPaiContabilidade.pSetaEventoTfrxPDFExport(
  const AComponente: TComponent);
begin
  If (AComponente Is TfrxPDFExport) Then
  Begin
    TfrxPDFExport(AComponente).EmbeddedFonts         := True;
    TfrxPDFExport(AComponente).EmbedFontsIfProtected := True;
    TfrxPDFExport(AComponente).ExportNotPrintable    := True;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTfrxReport(
  const AComponente: TComponent);
begin
  If (AComponente Is TfrxReport) Then
  Begin
    TfrxReport(AComponente).PreviewOptions.Buttons :=
    TfrxReport(AComponente).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTLabelCgc(
  const AComponente: TComponent);
begin
  If (AComponente Is TLabelCgc) Then
  Begin
    If (FPais = opcBrasil) Then
      TLabelCgc(AComponente).pSetaPais(opcBrasil)
    Else
      TLabelCgc(AComponente).pSetaPais(opcParaguai);
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTLabelCgcCpf(
  const AComponente: TComponent);
begin
  If (AComponente Is TLabelCgcCpf) Then
  Begin
    If (FPais = opcBrasil) Then
      TLabelCgcCpf(AComponente).pSetaPais(opcBrasil)
    Else
      TLabelCgcCpf(AComponente).pSetaPais(opcParaguai);
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTLabelCpf(
  const AComponente: TComponent);
begin
  If (AComponente Is TLabelCpf) Then
  Begin
    If (FPais = opcBrasil) Then
      TLabelCpf(AComponente).pSetaPais(opcBrasil)
    Else
      TLabelCpf(AComponente).pSetaPais(opcParaguai);
  End;
end;

procedure TfrmPaiContabilidade.pSetaEventoTLabelRg(
  const AComponente: TComponent);
begin
  If (AComponente Is TLabelRg) Then
  Begin
    If (FPais = opcBrasil) Then
      TLabelRg(AComponente).pSetaPais(opcBrasil)
    Else
      TLabelRg(AComponente).pSetaPais(opcParaguai);
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTMaskEditFocus(
  const AComponente: TComponent);
begin
  If (AComponente Is TMaskEditFocus) Then
  Begin
    If (AComponente As TMaskEditFocus).Tag = 99 Then
      (AComponente As TMaskEditFocus).OnKeyDown := pOnKeyDownEdits
    Else
      (AComponente As TMaskEditFocus).OnKeyDown := pOnKeyDown;
  End ;
end;

procedure TfrmPaiContabilidade.pSetaEventoTMaskEditTelefone(
  const AComponente: TComponent);
begin
  If (AComponente Is TMaskEditTelefone) Then
  Begin
    TMaskEditTelefone(AComponente).pSetTelefo(FPais);

    If (AComponente As TMaskEditTelefone).Tag = 99 Then
      (AComponente As TMaskEditTelefone).OnKeyDown := pOnKeyDownEdits
    Else
      (AComponente As TMaskEditTelefone).OnKeyDown := pOnKeyDown;
  End
end;

procedure TfrmPaiContabilidade.pSetaEventoTRadioButton(
  const AComponente: TComponent);
begin
  If (AComponente Is TRadioButton) Then
  Begin
    (AComponente As TRadioButton).OnKeyDown := pOnKeyDown;
  End ;
end;

procedure TfrmPaiContabilidade.pSetarQueryTraceViewerEvents;
Var
  I: Integer;
begin
  If Assigned(VS_objTraceViewerContabilidade) Then
    For I := 0 To Self.ComponentCount -1 Do
      If Self.Components[I] Is TUniQuery Then
        VS_objTraceViewerContabilidade.SetQueryEvents(TUniQuery(Self.Components[I]));
end;

procedure TfrmPaiContabilidade.btnPausarTraceClick(Sender: TObject);
begin
  inherited;
  if (Assigned(objTracePai)) then
  begin
    objTracePai.pPausaTrace();
    pAtualizaControlsTrace();
  end;
end;

procedure TfrmPaiContabilidade.btnIniciarTraceClick(Sender: TObject);
begin
  if (Assigned(objTracePai)) then
  begin
    objTracePai.pIniciaTrace();
    pAtualizaControlsTrace();
  end;
end;

procedure TfrmPaiContabilidade.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPaiContabilidade.btnSalvarTraceClick(Sender: TObject);
begin
  inherited;
  if (Assigned(objTracePai)) then
  begin
    objTracePai.pSalvaTrace();
    pAtualizaControlsTrace();
  end;
end;

procedure TfrmPaiContabilidade.btnViewerTraceClick(Sender: TObject);
begin
  If Not Assigned(objTracePai) Then
    Exit;

  If Not Assigned(VS_objTraceViewerContabilidade) Then
    Exit;

  If VS_objTraceViewerContabilidade.Visible Then
    Exit;

  VS_objTraceViewerContabilidade.Show;
end;

procedure TfrmPaiContabilidade.pOnBitBtnErro(Sender: TWinControl; strMsgErro: string;
  E: Exception);
begin
  inherited;
  Raise Exception.Create(E.Message);
end;

function TfrmPaiContabilidade.fDataMuitoAntiga(Sender: TObject): Boolean;
  Var
    mskData: TMaskEditFocus;
begin
  Result := False;
  Try
    If Sender.ClassNameIs('TMaskEditFocus') And blnValidaDataMuitoAntiga Then
    Begin
      mskData := TMaskEditFocus(Sender);
      If (mskData.ValidaData) And
         (StrToDate(mskData.Text) < IncYear(VS_Date, -1)) Then
      Begin
        Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). Deseja continuar?',
          ['&Sim', '&Não']) = 2;
      End;
    End;
  Except
    //
  End;

end;

procedure TfrmPaiContabilidade.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_Escape: If (ActiveControl Is TBitBtnLocked) Then
               Begin
                pEscapePressed;
               End;

    VK_F1    : Begin
                 If ActiveControl <> nil Then
                   pAjudaAutcom(Handle, ActiveControl.HelpContext);
               End;

    VK_F2    : If (Shift = [ssShift, ssAlt, ssCtrl]) And (Assigned(VS_objTraceViewerContabilidade)) Then
                 pSQLTrace(Sender);

    VK_Return: begin
                 If ((ActiveControl Is TRadioButton) And (ActiveControl.Parent <> Nil) And (ActiveControl.Parent Is TRadioGroup)) Then
                 begin
                   SelectNext(ActiveControl, True, True);
                 end
                 else If ((ActiveControl <> nil) and (ActiveControl.Parent <> Nil) And (ActiveControl.Parent Is TcxCheckGroup)) Then
                 begin
                   SelectNext(ActiveControl, True, True);
                 end;
               end;
  End;
end;

procedure TfrmPaiContabilidade.FormPaint(Sender: TObject);
begin
  If blnFecharFormPai Then
    Close;
end;

procedure TfrmPaiContabilidade.pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TDBEdit;
  blnHabilitar: Boolean);
begin
  If (Not blnHabilitar) Then
  Begin
    dbeCampoEnable.Enabled := blnHabilitar;
    dbeCampoEnable.Color := $00FFDFB8;
  End;
  If dbeCampoFocus.Enabled Then
    pSetFocus(dbeCampoFocus);
end;

procedure TfrmPaiContabilidade.pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TEditFocus;
  blnHabilitar: Boolean);
begin
  If (Not blnHabilitar) Then
  Begin
    dbeCampoEnable.Enabled := blnHabilitar;
    dbeCampoEnable.Color := $00FFDFB8;
  End;
  If dbeCampoFocus.Enabled Then
    pSetFocus(dbeCampoFocus);
end;

procedure TfrmPaiContabilidade.pHabilitaCodigo(dbeCampoEnable:TDBEdit;
  dbeCampoFocus: TWinControl; blnHabilitar: Boolean);
begin
  If (Not blnHabilitar) Then
  Begin
    dbeCampoEnable.Enabled := blnHabilitar;
    dbeCampoEnable.Color := $00FFDFB8;
  End;
  If dbeCampoFocus.Enabled Then
    pSetFocus(dbeCampoFocus);
end;

procedure TfrmPaiContabilidade.mnuConfigurarRelClick(Sender: TObject);
begin
  Try
    if (Not fVerificaAcessoSistema('FrmCadConfRelatorios', strLoginUsuarioLogado)) then
    begin
      pMensagemOk('Usuário sem direito de acesso a esta opção!');
      Exit;
    end;

    pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);
    If fEmptyStr(strFilRel) Then
      frmCadConfRelatorios.strNomeForm   := Self.Name
    Else
      frmCadConfRelatorios.strNomeForm   := strFilRel;

    frmCadConfRelatorios.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmPai.mnuConfigurarRelClick]');
    End;
  End;
  pFreeAndNil(frmCadConfRelatorios);
end;

procedure TfrmPaiContabilidade.mnuHabilitarSQLTraceClick(Sender: TObject);
begin
  pSQLTrace(Sender);
end;

function TfrmPaiContabilidade.fValidaCamposFrameDirectoryEditFocus(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  if (Assigned(Sender)) And ((not Assigned(Sender.Owner)) or
     (not (Sender.Owner is TfraDirectoryEditFocusContabilidade)) or
     ((TfraDirectoryEditFocusContabilidade(Sender.Owner).Tag <> 99) and (TfraDirectoryEditFocusContabilidade(Sender.Owner).edtDirectory.Tag <> 99))) then
  begin
    exit(True);
  end;
  If Assigned(Sender) And Assigned(Sender.Owner) And (Sender.Owner is TfraDirectoryEditFocusContabilidade) Then
    result := fValidaCampos((Sender.Owner as TfraDirectoryEditFocusContabilidade), blnBuscaPorChave)
  Else
    Result := True;
end;

function TfrmPaiContabilidade.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := fValidaCamposFrameDirectoryEditFocus(Sender, blnBuscaPorChave);
end;


function TfrmPaiContabilidade.fValidaPanel(pnlPanel: TPanel;
  blnBuscaPorChave: Boolean; blnStopOnError : Boolean): Boolean;
  Var
    intContador: Integer;
    blnResult  : Boolean;
begin
  blnResult := True;
  Result    := True;

  For intContador := 0 To pnlPanel.ControlCount -1 Do
  Begin

    If pnlPanel.Controls[intContador].Tag = 99 Then
      Result := fValidaCampos(TWinControl(pnlPanel.Controls[intContador]), blnBuscaPorChave);

    If blnStopOnError Then
    Begin
      If Not Result Then
        Break;
    End
    Else
      If Not Result Then
        blnResult := False;
  End;

  If not blnStopOnError Then
    Result := blnResult;

end;

{******************************************}
{* FUNÇÃO QUE REVALIDA TODOS OS CAMPOS    *}
{* VERIFICA TODOS OS CAMPOS E CASO OCORRA *}
{* ALGUMA FALHA NA VERIFICAÇÃO, FOCA TAL  *}
{* CAMPO.                                 *}
{***************************************MV*}
function TfrmPaiContabilidade.fVerificaCampos: Boolean;
begin
  Result := fVerificaSubObjeto(Self);
end;

{*********************************}
{* VERIFICA TODOS OS COMPONENTES *}
{* DENTRO DE PANEL OU SCROLLBOX  *}
{* (RECURSIVO)                   *}
{******************************AF*}
function TfrmPaiContabilidade.fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := 0 To objObjeto.ComponentCount -1 Do
  Begin
    {**********************************}
    {* SE O COMPONETE FOR UM PANEL,   *}
    {* UM SCROLLBOX OU TABSHEET       *}
    {*******************************AF*}
    If (objObjeto.Components[intContador] Is TPanel)     Or
       (objObjeto.Components[intContador] Is TScrollBox) Or
       (objObjeto.Components[intContador] Is TGroupBox)  Or
       (objObjeto.Components[intContador] Is TFrame)     Or
       (objObjeto.Components[intContador] Is TTabSheet)  Then
    Begin

      If (objObjeto.Components[intContador] Is TPanel)     Or
         (objObjeto.Components[intContador] Is TTabSheet) Then
      Begin
        {*******************************************}
        {* CASO NÃO QUERIA VALIDA UM TABSHEET, USE *}
        {* O VALOR -1 EM SEU TAG                   *}
        {****************************************MV*}
        If (objObjeto.Components[intContador].Tag = -1) Then
        Begin
          Exit
        End;
        //(objObjeto.Components[intContador] As TTabSheet).PageControl.ActivePage := (objObjeto.Components[intContador] As TTabSheet);
      End;

      Result := fVerificaSubObjeto((objObjeto.Components[intContador] As TWinControl));

      If Not Result Then
        Exit;

    End
    Else
    Begin
      {**************************************}
      {* SE A TAG DO COMPONENTES = 99 ENTÃO *}
      {***********************************AF*}
      If objObjeto.Components[intcontador].Tag = 99 Then
        If (objObjeto.Components[intContador] Is TWinControl) Then
        Begin
          Try
            Result := fValidaCampos((objObjeto.Components[intContador] As TWinControl), False);
          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message,'[TfrmPaiContabilidade.fVerificaSubObjeto]');
              pGravarErro(True, E.Message + ' - ' + Self.Name + '.' + (objObjeto.Components[intContador] As TWinControl).Name);
              Result := False;
            End;
          End;
        End;

        If Not Result Then
          Exit;
    End;

  End;

end;

function TfrmPaiContabilidade.fVerificaSubControl(objObjeto: TWinControl): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := 0 To objObjeto.ControlCount -1 Do
  Begin
    {**********************************}
    {* SE O COMPONETE FOR UM PANEL,   *}
    {* UM SCROLLBOX OU TABSHEET       *}
    {*******************************AF*}
    If (objObjeto.Controls[intContador] Is TPanel)     Or
       (objObjeto.Controls[intContador] Is TScrollBox) Or
       (objObjeto.Controls[intContador] Is TGroupBox)  Or
       (objObjeto.Controls[intContador] Is TFrame)     Or
       (objObjeto.Controls[intContador] Is TTabSheet)  Then
    Begin

      If (objObjeto.Controls[intContador] Is TTabSheet) Then
      Begin
        {*******************************************}
        {* CASO NÃO QUERIA VALIDA UM TABSHEET, USE *}
        {* O VALOR -1 EM SEU TAG                   *}
        {****************************************MV*}
        If ((objObjeto.Controls[intContador] As TTabSheet).Tag = -1) Then
        Begin
          Exit
        End;
        (objObjeto.Controls[intContador] As TTabSheet).PageControl.ActivePage := (objObjeto.Controls[intContador] As TTabSheet);
      End;

      Result := fVerificaSubControl((objObjeto.Controls[intContador] As TWinControl));

      If Not Result Then
        Exit;

    End
    Else
    Begin
      {**************************************}
      {* SE A TAG DO COMPONENTES = 99 ENTÃO *}
      {***********************************AF*}
      If objObjeto.Controls[intcontador].Tag = 99 Then
        If (objObjeto.Controls[intContador] Is TWinControl) Then
        Begin
          Try
            Result := fValidaCampos((objObjeto.Controls[intContador] As TWinControl), False);
          Except
            On E: Exception Do
            Begin
							pMensagensErro(E.Message,'[TfrmPaiContabilidade.fVerificaSubControl]');
              pGravarErro(True, E.Message + ' - ' + Self.Name + '.' + (objObjeto.Controls[intContador] As TWinControl).Name);
              Result := False;
            End;
          End;
        End;

        If Not Result Then
          Exit;
    End;

  End;

end;

procedure TfrmPaiContabilidade.pProximoControle(Sender: TObject);
begin
  If (Sender As TWinControl).Tag = 99 Then
  Begin
    If (fValidaCampos(TWinControl(Sender))) And (blnMudarFoco) Then
      SelectNext(ActiveControl, True, True);
  End
  Else
    SelectNext(ActiveControl, True, True);
  blnMudarFoco := True;
end;

procedure TfrmPaiContabilidade.pEscapePressed;
begin
  If blnFecharComEscape Then
    Close;
end;

procedure TfrmPaiContabilidade.pOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If InterlockedIncrement(intSemaforoKeyDown) = 0 Then
  Begin
    Try
      If (Key = VK_Return) Then
      Begin
        If Not fDataMuitoAntiga(Sender) Then
          pProximoControle(Sender);
      End
      Else If (Key = VK_Escape) Then
      Begin
        pEscapePressed;
      End;
    Finally
      InterlockedDecrement(intSemaforoKeyDown);
    End;
  End
  Else
    InterlockedDecrement(intSemaforoKeyDown);
end;

{*****************************************}
{* FUNÇÃO QUE É ATRIBUIDA NO EVENTO      *}
{* 'OnKeyDown' DOS Edits. (continua...)  *}
{**************************************MV*}
procedure TfrmPaiContabilidade.pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If InterlockedIncrement(intSemaforoKeyDown) = 0 Then
  Begin
    Try
      If (Key = VK_Return) Then
      Begin
        If Not fDataMuitoAntiga(Sender) Then
          pProximoControle(Sender);
      End
      Else If (Key = VK_Escape) Then
      Begin
        pEscapePressed;
      End;
    Finally
      InterlockedDecrement(intSemaforoKeyDown);
    End;
  End
  Else
    InterlockedDecrement(intSemaforoKeyDown);
end;

procedure TfrmPaiContabilidade.pCarKeyAutBan;
  Var
    intContador : Integer;

Begin

  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TEditFocus) Then
    Begin
      (Self.Components[intContador] As TEditFocus).OnKeyDown := pOnKeyDownEditsAutBan;
    End

    Else If (Self.Components[intContador] Is TFilenameEditFocus) Then
    Begin
      If (Self.Components[intContador] As TFilenameEditFocus).Tag = 99 Then
        (Self.Components[intContador] As TFilenameEditFocus).OnKeyDown := pOnKeyDownEditsAutBan
      Else
        (Self.Components[intContador] As TFilenameEditFocus).OnKeyDown := pOnKeyDownAutBan;
    End

    Else If (Self.Components[intContador] Is TfraDirectoryEditFocusContabilidade) Then
    Begin
      If (Self.Components[intContador] As TfraDirectoryEditFocusContabilidade).Tag = 99 Then
        (Self.Components[intContador] As TfraDirectoryEditFocusContabilidade).edtDirectory.OnKeyDown := pOnKeyDownEditsAutBan
      Else
        (Self.Components[intContador] As TfraDirectoryEditFocusContabilidade).edtDirectory.OnKeyDown := pOnKeyDownAutBan;
    End;

  End;


End;



procedure TfrmPaiContabilidade.pOnKeyDownAutBan(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If (Key = VK_Return) Then
  Begin
    pProximoControle(Sender);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pEscapePressed;
  End
  Else If (Key = VK_F1) Then
  Begin
    pCriaFormCfgAtb(ActiveControl.Name);
  End
  Else If (Shift = [ssShift]) And (Key = VK_F7) Then
  Begin
    If blnLibCnf Then
    Begin
      blnLibCnf       := False;
      pnlBotoes.Color := clGray;
    End
    Else
    Begin
      If ffrmSenha(strSenha) Then
      Begin
        If strSenha = SEN_CNF Then
        Begin
          blnLibCnf       := True;
          pnlBotoes.Color := clNavy;
        End;
      End;
    End;
  End;

end;

procedure TfrmPaiContabilidade.pOnKeyDownEditsAutBan(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If (Key = VK_Return) Then
  Begin
    pProximoControle(Sender);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pEscapePressed;
  End
  Else If (Key = VK_F1) Then
  Begin
    pCriaFormCfgAtb(ActiveControl.Name);
  End
  Else If (Shift = [ssShift]) And (Key = VK_F7) Then
  Begin
    If blnLibCnf Then
    Begin
      blnLibCnf       := False;
      pnlBotoes.Color := clGray;
    End
    Else
    Begin
      If ffrmSenha(strSenha) Then
      Begin
        If strSenha = SEN_CNF Then
        Begin
          blnLibCnf       := True;
          pnlBotoes.Color := clNavy;
        End;
      End;
    End;
  End;

end;

procedure TfrmPaiContabilidade.pCriaFormCfgAtb(strNomCam: String);
  Var
    frmCfgAtb : TfrmCfgAtb;
begin

  Try
    pCriarFormularios(tfrmCfgAtb, frmCfgAtb);
    frmCfgAtb.strNomCam := strNomCam;
    frmCfgAtb.strNomFor := Self.Name;
    frmCfgAtb.blnCfgAtb := blnLibCnf;
    frmCfgAtb.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmPai.pCriaFormCfgAtb]');
    End;
  End;
  pFreeAndNil(frmCfgAtb);

end;

procedure TfrmPaiContabilidade.pDesligarTemaBotoes;
Var
  I: Integer;
begin
  For I := 0 To Self.ComponentCount -1 Do
    If Self.Components[I] Is TBitBtn Then
      TBitBtn(Self.Components[I]).StyleElements := [];
end;

procedure TfrmPaiContabilidade.ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
  var i: SmallInt;
begin

  Try
    If (ActiveControl is TDBGridCitel) Then
    begin
      If Msg.message = WM_MOUSEWHEEL Then
      Begin
        Msg.message := WM_KEYDOWN;
        Msg.lParam := 0;
        i := HiWord(Msg.wParam);
        If i > 0 Then
          Msg.wParam := VK_UP
        Else
          Msg.wParam := VK_DOWN;
        Handled := False;
      End;
    End;
  Except
    //Ocorre de disparar "mensagens de eventos" quando
    //esta destruindo o formulario e seus componentes. Isto provoca
    //access violation quando tenta verificar o controle ativo (ActiveControl)
  End;

end;

procedure TfrmPaiContabilidade.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  inherited;
  If Not blnValidarComTAB Then
    Exit;

  If (Not Assigned(ActiveControl)) Then
    Exit;

  If Not ( (ActiveControl Is TDBEditCgcCpf) Or
           (ActiveControl Is TDBEditTipoCgcCpf) Or
           (ActiveControl Is TEditTipoCgcCpf) Or
           (ActiveControl Is TDBEditFocus) Or
           (ActiveControl Is TcxDBDateEdit) Or
           (ActiveControl Is TDBCheckBox) Or
           (ActiveControl Is TCheckBox) Or
           (ActiveControl Is TcxCheckBox) Or
           (ActiveControl Is TcxDBCheckBox) Or
           (ActiveControl Is TRadioButton) Or
           (ActiveControl Is TDBComboBoxFocus) Or
           (ActiveControl Is TDBLookupComboBox) Or
           (ActiveControl Is TEditFocus) Or
           (ActiveControl Is TMaskEditTelefone) Or
           (ActiveControl Is TMaskEditFocus) Or
           (ActiveControl Is TFilenameEditFocus) Or
           (ActiveControl Is TfraDirectoryEditFocusContabilidade) Or
           (ActiveControl Is TComboBoxFocus) Or
           (ActiveControl Is TcxDateEdit) Or
           (ActiveControl Is TcxDBMaskEdit) Or
           (ActiveControl Is TcxComboBox) Or
           (ActiveControl Is TcxCheckComboBox) Or
           (ActiveControl Is TcxDBCheckComboBox) Or
           (ActiveControl Is TCurrencyEditFocus) ) Then
  Begin
    Exit;
  End;

  If (Msg.CharCode <> VK_TAB) Then
    Exit;

  {Caso ALT pressionado}
  If fKeyIsDown(VK_MENU) Then
    Exit;

  If fKeyIsDown(VK_SHIFT) Then
    Exit;

  If fKeyIsDown(VK_CONTROL) Then
    Exit;

  Msg.CharCode := 0;

  {Ao pressionar o TAB estava limpando o valor do campo de Data TMaskEditFocus}
  If ActiveControl Is TCustomEdit Then
    If TCustomEdit(ActiveControl).Text <> '' Then
    Begin
      TCustomEdit(ActiveControl).SelStart  := 1;
      TCustomEdit(ActiveControl).SelLength := 1;
    End;

  ActiveControl.Perform(WM_KEYDOWN, VK_RETURN, 0);
end;

procedure TfrmPaiContabilidade.FormShow(Sender: TObject);
begin
  If fsModal In FormState Then
    Contabilidade.FuncoesFormPai.fRegistraCallStackSeEstiverEmTransacao(Nil, 'Formulário onde aconteceu: Name: '+Self.Name+' Caption: '+Self.Caption);

  SetForegroundWindow(Self.Handle);
  pSetaCaseInsensitiveCXGrid;
end;

function TfrmPaiContabilidade.HandleCreateException: Boolean;
begin
  Result := False;
end;

function TfrmPaiContabilidade.IsWindows7Classic: Boolean;
Var
  Windows7, Windows2008Server: Boolean;
begin
  Windows7 := Pos('Windows 7'.ToUpper, TOSVersion.ToString.ToUpper) > 0;

  Windows2008Server := (Pos('Windows'.ToUpper, TOSVersion.ToString.ToUpper) > 0) and
                       (Pos('Server'.ToUpper, TOSVersion.ToString.ToUpper) > 0) and
                       (Pos('2008', TOSVersion.ToString) > 0);

  {*************************************************************************}
  {* Se for Windows 7 ou Server 2008 e estiver utilizando tema Clássico    *}
  {* do Windows, obrigatoriamente deve entrar na versão clássica do Autcom *}
  {**********************************************************************MM*}
  Result := (Windows7 Or Windows2008Server) And
            (Not IsThemeActive);
end;

procedure TfrmPaiContabilidade.pSelNext;
begin
  SelectNext(ActiveControl, True, True);
end;

procedure TfrmPaiContabilidade.pSQLTrace(Sender: TObject; blnAuth: Boolean = False; blnCabecalho: Boolean = False);
  Var
    strSenha: String;
begin
  If (Assigned(VS_TraceContabilidade)) And (VS_TraceContabilidade.GetAutenticado()) Then
  Begin
    btnPausarTrace.Click();
    pFinalizarSQLTrace;
  End
  // Não está efetuando trace, então começa efetuar
  Else
  Begin

    VS_TraceContabilidade := TSQLTrace.Create();
    VS_TraceContabilidade.Autenticado := blnAuth;
    VS_TraceContabilidade.Cabecalho := blnCabecalho;

    if (not VS_TraceContabilidade.GetAutenticado()) then
    begin
      ffrmSenha(strSenha, 'Início de SQL Trace');

      If strSenha <> SEN_CNF Then
      begin
      ///  FreeAndNil(VS_Trace);
        Exit;
      end;
    end;

    If (blnAuth) Then
    Begin
      objTracePai := VS_TraceContabilidade;
      objTracePai.pIniciaTrace();
    End
    Else
    Begin
      pIniTraceForms();
      btnIniciarTrace.Click();
    End;
  End;

  VS_objTraceViewerContabilidade.SetSQLTrace(VS_TraceContabilidade);
end;

procedure TfrmPaiContabilidade.pAtualizaControlsTrace;
begin
  btnIniciarTrace.Width  := IIF(objTracePai.Status = stPausado , 23, 0);
  btnPausarTrace.Width   := IIF(objTracePai.Status = stIniciado, 23, 0);
  btnViewerTrace.Width   := IIF(Assigned(VS_objTraceViewerContabilidade)    , 23, 0);
  btnSalvarTrace.Enabled := True;
end;

procedure TfrmPaiContabilidade.pFinalizarSQLTrace;
begin
  pnlBotoesTrace.Visible := False;
  pnlBotoesTrace.Width   := 0;
  objTracePai.SetAutenticado(False);
end;

procedure TfrmPaiContabilidade.pIniTraceForms;
begin
  pnlBotoesTrace.Visible := True;
  pnlBotoesTrace.Width   := 70;
  objTracePai            := VS_TraceContabilidade;
  pAtualizaControlsTrace();
  VS_objTraceViewerContabilidade.SetSQLTrace(VS_TraceContabilidade);
end;

end.
