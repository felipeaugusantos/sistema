unit untLibContaBancariaPai;

interface

uses
  Winapi.Windows, System.SysUtils, System.Types, System.Classes, System.Variants,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, Vcl.Controls, Vcl.ExtCtrls, Vcl.Graphics,
  Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.DBCtrls, DBEditFocus, TypInfo,
  EditFocus, DBGridCitel, DBGrids, Grids, DBComboBoxFocus, ComboBoxFocus, MaskEditFocus,
  Uni, DB, Mask, FilenameEditFocus, DirectoryEditFocus, AppEvnts, cxGridCitel,
  Messages, CurrencyEditFocus, untFuncoesGenerica, untLabelRg, untLabelCgcCpf,
  untMskC_G_C_, untMskTelefone, untLabelCgc, untLabelCpf,cxButtons,untDBECgcCpf,
  untDBETipoCgcCpf, untEditTipoCgcCpf, BitBtnLockedIncrem, DBLookupComboBoxFocus,
  ShellAPI, frxClass, frxExportCSVTestabilidade, DateUtils, cxCheckBox,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, frxExportPDF,
  cxGrid, cxGridTableView, cxFilter, UxTheme,cxCheckComboBox,cxLabel,
  System.StrUtils, cxTimeEdit, untLibContaBancariaConstantes,
  Vcl.Themes, Vcl.SysStyles,cxControls,cxGroupBox,cxCheckListBox,
  untLibContaBancariaTelasAbertas, untLibContaBancariaInterfacesTipos, untILibContaBancariaFactory;

type
  TfrmPai = class(TForm)
    pnlBotoes: TPanel;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    mnuAuxiliar: TPopupMenu;
    mnuConfigurarRel: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    btnSair: TBitBtnLocked;
    frxCSVExportTestabilidade: TfrxCSVExportTestabilidade;
    FlwBotoes: TFlowPanel;
    pnlBotoesTrace: TPanel;
    btnIniciarTrace: TSpeedButton;
    btnPausarTrace: TSpeedButton;
    btnSalvarTrace: TSpeedButton;
    btnViewerTrace: TSpeedButton;
    mnuHabilitarSQLTrace: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FPais: TPais;
    FPrimeiraVez: Boolean;
    FTelas: ITelasAbertas;

    function fDataMuitoAntiga(Sender: TObject): Boolean;
    procedure pSetaCaseInsensitiveCXGrid;
    procedure pAjustarTema(AParent: TWinControl);
    procedure pEmpilharTelaAberta;
    procedure pRemoverTelaAberta;

    function fKeyIsDown(const Key: integer): boolean;
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

    procedure pOnBitBtnErro(Sender: TWinControl; strMsgErro: string; E: Exception);

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

    procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);

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
    strUltimoComponenteClicado: String;
    blnRegistraUltimoComponenteClicado: Boolean;

    strFilRel: String;
    blnFecharComEscape: Boolean;
    blnFecharFormPai: Boolean;
    blnMudarFoco: Boolean;


    procedure pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TDBEdit; blnHabilitar: Boolean); overload;
    procedure pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TEditFocus; blnHabilitar: Boolean); overload;
    procedure pHabilitaCodigo(dbeCampoEnable: TDBEdit; dbeCampoFocus: TWinControl; blnHabilitar: Boolean); overload;
  end;

var
  frmPai: TfrmPai;

implementation

uses  cxCalendar,cxDbEdit, cxRadioGroup, cxCheckGroup;

{$R *.dfm}

procedure TfrmPai.FormActivate(Sender: TObject);
begin
  FPrimeiraVez := False;

  If Not TLibContaBancariaFactory.Get.fIExecutandoModoClassico Then
    If TStyleManager.ActiveStyle.Name = AUTCOM_STYLE_NAME Then
      pAjustarTema(Self);
end;

procedure TfrmPai.FormCreate(Sender: TObject);
begin
  FPrimeiraVez := True;

  blnValidaDataMuitoAntiga := True;
  blnValidarComTAB := False;

  strFilRel := '';
  strUltimoComponenteClicado := '';
  blnRegistraUltimoComponenteClicado := False;

  intSemaforoKeyDown := -1;

  blnFecharComEscape := True;

  blnFecharFormPai := False;


  {*****************************************}
  {* PARA NAO DEIXAR O FORM AUMENTAR       *}
  {**************************************MV*}

  pnlNomeForm.Caption := Self.Name;
  blnMudarFoco := True;

  pEmpilharTelaAberta;

  pSetaEventos(Self);
End;

procedure TfrmPai.FormDestroy(Sender: TObject);
begin
  pRemoverTelaAberta;
end;

procedure TfrmPai.pSetaCaseInsensitiveCXGrid;
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

procedure TfrmPai.pSetaEventos(SelfWin: TWinControl);
  Var
    intContador: Integer;
Begin
  {*****************************************}
  {* ATRIBUI OS METODOS REFERENTES AO      *}
  {* EVENTO 'OnKeyDown' DOS COMPONENTES    *}
  {**************************************MV*}
  For intContador := 0 To SelfWin.ComponentCount -1 Do
  Begin

    If (SelfWin.Components[intContador] Is TLabelRg) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelRg(SelfWin.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelRg(SelfWin.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (SelfWin.Components[intContador] Is TLabelCgcCpf) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelCgcCpf(SelfWin.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelCgcCpf(SelfWin.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (SelfWin.Components[intContador] Is TLabelCgc) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelCgc(SelfWin.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelCgc(SelfWin.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (SelfWin.Components[intContador] Is TLabelCpf) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelCpf(SelfWin.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelCpf(SelfWin.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (SelfWin.Components[intContador] Is TDBEditCgcCpf) And (Not fPodeValidarCgcCpf(FPais)) Then
    Begin
      TDBEditCgcCpf(SelfWin.Components[intContador]).OnKeyDown := pOnKeyDownEdits;
      TDBEditCgcCpf(SelfWin.Components[intContador]).Tag := 0
    End

    Else If (SelfWin.Components[intContador] Is TDBEditTipoCgcCpf) Then
    Begin
      TDBEditTipoCgcCpf(SelfWin.Components[intContador]).OnKeyDown := pOnKeyDownEdits;
      TDBEditTipoCgcCpf(SelfWin.Components[intContador]).Visible   := fMostraTipoCgcCpf(FPais);

      If (Not TDBEditTipoCgcCpf(SelfWin.Components[intContador]).Visible) Then
        TDBEditTipoCgcCpf(SelfWin.Components[intContador]).Tag := 0;
    End

    Else If (SelfWin.Components[intContador] Is TEditTipoCgcCpf) Then
    Begin
      TEditTipoCgcCpf(SelfWin.Components[intContador]).OnKeyDown := pOnKeyDownEdits;
      TEditTipoCgcCpf(SelfWin.Components[intContador]).Visible   := fMostraTipoCgcCpf(FPais);

      If (Not TEditTipoCgcCpf(SelfWin.Components[intContador]).Visible) Then
        TEditTipoCgcCpf(SelfWin.Components[intContador]).Tag := 0;
    End

    Else If (SelfWin.Components[intContador] Is TDBEditFocus) Then
    Begin
      (SelfWin.Components[intContador] As TDBEditFocus).OnKeyDown := pOnKeyDownEdits;
    End

    Else If (SelfWin.Components[intContador] Is TDBCheckBox) Then
    Begin
      (SelfWin.Components[intContador] As TDBCheckBox).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TCheckBox) Then
    Begin
      (SelfWin.Components[intContador] As TCheckBox).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TcxCheckBox) Then
    Begin
      (SelfWin.Components[intContador] As TcxCheckBox).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TcxDBCheckBox) Then
    Begin
      (SelfWin.Components[intContador] As TcxDBCheckBox).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TRadioButton) Then
    Begin
      (SelfWin.Components[intContador] As TRadioButton).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TDBComboBoxFocus) Then
    Begin
      (SelfWin.Components[intContador] As TDBComboBox).OnKeyDown := pOnKeyDownEdits;
    End

    Else If (SelfWin.Components[intContador] Is TDBLookupComboBox) Then
      TDBLookupComboBox(SelfWin.Components[intContador]).OnKeyDOwn := pOnKeyDownEdits

    Else If (SelfWin.Components[intContador] Is TEditFocus) Then
    Begin
      (SelfWin.Components[intContador] As TEditFocus).OnKeyDown := pOnKeyDownEdits;
    End

    Else If (SelfWin.Components[intContador] Is TcxCustomRadioGroupButton) then
    begin
      If (SelfWin.Components[intContador] As TcxCustomRadioGroupButton).Tag = 99 Then
        (SelfWin.Components[intContador] As TcxCustomRadioGroupButton).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TcxCustomRadioGroupButton).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TcxDBRadioGroup) then
    begin
      If (SelfWin.Components[intContador] As TcxDBRadioGroup).Tag = 99 Then
        (SelfWin.Components[intContador] As TcxDBRadioGroup).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TcxDBRadioGroup).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TMaskEditTelefone) Then
    Begin
      TMaskEditTelefone(SelfWin.Components[intContador]).pSetTelefo(FPais);

      If (SelfWin.Components[intContador] As TMaskEditTelefone).Tag = 99 Then
        (SelfWin.Components[intContador] As TMaskEditTelefone).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TMaskEditTelefone).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TMaskEditFocus) Then
    Begin
      If (SelfWin.Components[intContador] As TMaskEditFocus).Tag = 99 Then
        (SelfWin.Components[intContador] As TMaskEditFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TMaskEditFocus).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TFilenameEditFocus) Then
    Begin
      If (SelfWin.Components[intContador] As TFilenameEditFocus).Tag = 99 Then
        (SelfWin.Components[intContador] As TFilenameEditFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TFilenameEditFocus).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TComboBoxFocus) Then
    Begin

      If (SelfWin.Components[intContador] As TComboBoxFocus).Tag = 99 Then
        (SelfWin.Components[intContador] As TComboBoxFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TComboBoxFocus).OnKeyDown := pOnKeyDown;

    End

    Else If (SelfWin.Components[intContador] Is TcxCheckComboBox) Then
    begin
      If (SelfWin.Components[intContador] As TcxCheckComboBox).Tag = 99 Then
        (SelfWin.Components[intContador] As TcxCheckComboBox).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TcxCheckComboBox).OnKeyDown := pOnKeyDown;
    end

//    Else If (SelfWin.Components[intContador] Is TcxDBCheckComboBox) Then
//    begin
//      If (SelfWin.Components[intContador] As TcxDBCheckComboBox).Tag = 99 Then
//        (SelfWin.Components[intContador] As TcxDBCheckComboBox).OnKeyDown := pOnKeyDownEdits
//      Else
//        (SelfWin.Components[intContador] As TcxDBCheckComboBox).OnKeyDown := pOnKeyDown;
//    end

    Else If (SelfWin.Components[intContador] Is TcxTimeEdit) Then
    begin
      If (SelfWin.Components[intContador] As TcxTimeEdit).Tag = 99 Then
        (SelfWin.Components[intContador] As TcxTimeEdit).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TcxTimeEdit).OnKeyDown := pOnKeyDown;
    end


    Else If (SelfWin.Components[intContador] Is TcxDateEdit) Then
    Begin
      (SelfWin.Components[intContador] As TcxDateEdit).ParentFont := False;
      If (SelfWin.Components[intContador] As TcxDateEdit).Tag = 99 Then
        (SelfWin.Components[intContador] As TcxDateEdit).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TcxDateEdit).OnKeyDown := pOnKeyDown;

    End

    Else If (SelfWin.Components[intContador] Is TcxButton) Then
    Begin
      (SelfWin.Components[intContador] As TcxButton).ParentFont := False;
      If (SelfWin.Components[intContador] As TcxButton).Tag = 99 Then
        (SelfWin.Components[intContador] As TcxButton).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TcxButton).OnKeyDown := pOnKeyDown;

    End

    Else If (SelfWin.Components[intContador] Is TcxDBDateEdit) Then
    Begin
      (SelfWin.Components[intContador] As TcxDBDateEdit).ParentFont := False;
      If (SelfWin.Components[intContador] As TcxDBDateEdit).Tag = 99 Then
        (SelfWin.Components[intContador] As TcxDBDateEdit).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TcxDBDateEdit).OnKeyDown := pOnKeyDown;

    End

    Else If (SelfWin.Components[intContador] Is TcxDBMaskEdit) Then
    Begin

      If (SelfWin.Components[intContador] As TcxDBMaskEdit).Tag = 99 Then
        (SelfWin.Components[intContador] As TcxDBMaskEdit).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TcxDBMaskEdit).OnKeyDown := pOnKeyDown;

    End

    Else If (SelfWin.Components[intContador] Is TcxComboBox) Then
    Begin

      If (SelfWin.Components[intContador] As TcxComboBox).Tag = 99 Then
        (SelfWin.Components[intContador] As TcxComboBox).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TcxComboBox).OnKeyDown := pOnKeyDown;

    End

    Else If (SelfWin.Components[intContador] Is TCurrencyEditFocus) Then
    Begin
      If (SelfWin.Components[intContador] As TCurrencyEditFocus).Tag = 99 Then
        (SelfWin.Components[intContador] As TCurrencyEditFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TCurrencyEditFocus).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TDBGridCitel) Then
    Begin
      TDBGridCitel(SelfWin.Components[intContador]).DrawingStyle := gdsClassic;
    End

    Else If (SelfWin.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(SelfWin.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(SelfWin.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End

    Else If (SelfWin.Components[intContador] Is TfrxPDFExport) Then
    Begin
      TfrxPDFExport(SelfWin.Components[intContador]).EmbeddedFonts         := True;
      TfrxPDFExport(SelfWin.Components[intContador]).EmbedFontsIfProtected := True;
      TfrxPDFExport(SelfWin.Components[intContador]).ExportNotPrintable    := True;
    End

    Else If (SelfWin.Components[intContador] Is TBitBtnLocked) Then
    Begin
      If Not Assigned(TBitBtnLocked(SelfWin.Components[intContador]).OnErro) Then
        TBitBtnLocked(SelfWin.Components[intContador]).OnErro := pOnBitBtnErro;
    End

    Else If (SelfWin.Components[intContador] Is TFrame) Then
      pSetaEventos(TFrame(SelfWin.Components[intContador]));
  End;

end;

procedure TfrmPai.pSetFocus(SenderUnico: TWinControl; Form: TCustomForm);
begin
  If Not Assigned(SenderUnico) Then
    Exit;

  If ((GetKeyState(VK_SHIFT) And 128) = 128) And
     ((GetKeyState(VK_TAB) And 128) = 128) Then
    Exit;

  Try
    if Form = Nil then
      Form := GetParentForm(SenderUnico);

    If (Form <> nil) And (Form.CanFocus) And SenderUnico.CanFocus Then
    Begin
      Try
        SenderUnico.SetFocus;

        if (SenderUnico is TCustomCheckBox) or (SenderUnico is TCustomCombo) then
          SenderUnico.Perform(WM_UPDATEUISTATE, MakeWParam(UIS_CLEAR, UISF_HIDEFOCUS), 0);

      Except

      End;
    End;
  Except

  End;
end;

procedure TfrmPai.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPai.pOnBitBtnErro(Sender: TWinControl; strMsgErro: string;
  E: Exception);
begin
  inherited;
  Raise Exception.Create(strMsgErro);
end;

function TfrmPai.fDataMuitoAntiga(Sender: TObject): Boolean;
  Var
    mskData: TMaskEditFocus;
begin
  Result := False;
  Try
    If Sender.ClassNameIs('TMaskEditFocus') And blnValidaDataMuitoAntiga Then
    Begin
      mskData := TMaskEditFocus(Sender);
      If (mskData.ValidaData) And
         (StrToDate(mskData.Text) < IncYear(Date, -1)) Then
      Begin
        Result :=  TLibContaBancariaFactory.Get.fIMensagem('', 'Data inferior a ' + DateToStr(IncYear(Date, -1)) + ' (1 ano). Deseja continuar?',
          ['&Sim', '&Não']) = 2;
      End;
    End;
  Except
    //
  End;
end;

function TfrmPai.fKeyIsDown(const Key: integer): boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
end;

procedure TfrmPai.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_Escape: If (ActiveControl Is TBitBtnLocked) Then
               Begin
                pEscapePressed;
               End;

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

procedure TfrmPai.FormPaint(Sender: TObject);
begin
  If blnFecharFormPai Then
    Close;
end;

procedure TfrmPai.pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TDBEdit;
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

procedure TfrmPai.pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TEditFocus;
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

procedure TfrmPai.pHabilitaCodigo(dbeCampoEnable:TDBEdit;
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

function TfrmPai.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
end;


function TfrmPai.fValidaPanel(pnlPanel: TPanel;
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
function TfrmPai.fVerificaCampos: Boolean;
begin
  Result := fVerificaSubObjeto(Self);
end;

{*********************************}
{* VERIFICA TODOS OS COMPONENTES *}
{* DENTRO DE PANEL OU SCROLLBOX  *}
{* (RECURSIVO)                   *}
{******************************AF*}
function TfrmPai.fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
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
       (objObjeto.Components[intContador] Is TFlowPanel) Or
       (objObjeto.Components[intContador] Is TScrollBox) Or
       (objObjeto.Components[intContador] Is TGroupBox)  Or
       (objObjeto.Components[intContador] Is TFrame)     Or
       (objObjeto.Components[intContador] Is TTabSheet)  Then
    Begin

      If (objObjeto.Components[intContador] Is TPanel)     Or
         (objObjeto.Components[intContador] Is TFlowPanel) Or
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
              TLibContaBancariaFactory.Get.pIMensagensErro(E.Message,'[TfrmPai.fVerificaSubObjeto]');
              TLibContaBancariaFactory.Get.pIGravarErro(True, E.Message + ' - ' + Self.Name + '.' + (objObjeto.Components[intContador] As TWinControl).Name);
              Result := False;
            End;
          End;
        End;

        If Not Result Then
          Exit;
    End;

  End;

end;

function TfrmPai.fVerificaSubControl(objObjeto: TWinControl): Boolean;
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
       (objObjeto.Components[intContador] Is TFlowPanel) Or
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
							TLibContaBancariaFactory.Get.pIMensagensErro(E.Message,'[TfrmPai.fVerificaSubControl]');
              TLibContaBancariaFactory.Get.pIGravarErro(True, E.Message + ' - ' + Self.Name + '.' + (objObjeto.Controls[intContador] As TWinControl).Name);
              Result := False;
            End;
          End;
        End;

        If Not Result Then
          Exit;
    End;

  End;

end;

procedure TfrmPai.pProximoControle(Sender: TObject);
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

procedure TfrmPai.pEmpilharTelaAberta;
begin
  FTelas := untLibContaBancariaTelasAbertas.objTelasAbertas;

  If Assigned(FTelas) Then
    FTelas.AddFormAndSetPopupMode(Self);
end;

procedure TfrmPai.pRemoverTelaAberta;
begin
  If Assigned(FTelas) Then
    FTelas.RemoveFormParent(Self);
end;

procedure TfrmPai.pEscapePressed;
begin
  If blnFecharComEscape Then
    Close;
end;

procedure TfrmPai.pOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
procedure TfrmPai.pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState);
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


procedure TfrmPai.ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
  var i: SmallInt;
  Var
    Target: TControl;
    Point: TPoint;
begin

  Try
    If (ActiveControl is TDBGridCitel) Then
    begin
      With TDBGridCitel(ActiveControl) do
      Begin
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
    End;

    If (blnRegistraUltimoComponenteClicado) Then
    Begin
      If Msg.Message = WM_LBUTTONDOWN Then
      Begin
        GetCursorPos(Point);
        Target := FindDragTarget(Point, False);
        If Assigned(Target) Then
          Self.strUltimoComponenteClicado := Target.Name;

        Handled := False;
      End;
    End;

  Except
    //Ocorre de disparar "mensagens de eventos" quando
    //esta destruindo o formulario e seus componentes. Isto provoca
    //access violation quando tenta verificar o controle ativo (ActiveControl)
  End;

end;

procedure TfrmPai.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
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
           (ActiveControl Is TComboBoxFocus) Or
           (ActiveControl Is TcxDateEdit) Or
           (ActiveControl Is TcxButton) Or
           (ActiveControl Is TcxDBMaskEdit) Or
           (ActiveControl Is TcxComboBox) Or
           (ActiveControl Is TcxCheckComboBox) Or
//           (ActiveControl Is TcxDBCheckComboBox) Or
           (ActiveControl Is TcxTimeEdit) Or
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

procedure TfrmPai.FormShow(Sender: TObject);
begin
  SetForegroundWindow(Self.Handle);
  pSetaCaseInsensitiveCXGrid;
end;

function TfrmPai.HandleCreateException: Boolean;
begin
  Result := False;
end;

procedure TfrmPai.pSelNext;
begin
  SelectNext(ActiveControl, True, True);
end;


procedure TfrmPai.pAjustarTema(AParent: TWinControl);
Var
  I: Integer;

  procedure pAjustaControl(AControl: TControl);
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

    If AControl Is TEdit Then
      If TEdit(AControl).Font.Color <> clBlack Then
        If TEdit(AControl).Font.Color <> clWhite Then
          TEdit(AControl).StyleElements :=
            TEdit(AControl).StyleElements - [seFont];

    If AControl Is TBitBtn Then
      TBitBtn(AControl).StyleElements := [];
  end;

  procedure pAjustaCxControl(AControl: TcxControl);
  begin
    If IsPublishedProp(AControl, 'ParentBackground') Then
      SetPropValue(AControl, 'ParentBackground', False);

   If (AControl Is TcxGroupBox) Then
    Begin
      TcxGroupBox(AControl).Style.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);
      //TcxGroupBox(AControl).Transparent := True;
    End;

    If (AControl Is TcxLabel) Then
    Begin
      TcxLabel(AControl).Style.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);
      TcxLabel(AControl).Transparent := True;
    End;

    If (AControl Is TcxCheckListBox) Then
      TcxCheckListBox(AControl).Style.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);
  end;

begin
  If Self.Color = $00FFE4D5 Then
    Self.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);

  pnlBotoes.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);

  For I := 0 To AParent.ComponentCount -1 Do
  Begin
    If (AParent.Components[I] Is TControl) Then
      pAjustaControl(TControl(AParent.Components[I]));

    If (AParent.Components[I] Is TFrame) Then
    Begin
      TFrame(AParent.Components[I]).Color :=  TStyleManager.ActiveStyle.GetStyleColor(scPanel);
      pAjustarTema(TWinControl(AParent.Components[I]));
    End;
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


end.
