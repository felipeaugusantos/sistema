unit untPai;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Menus, StdCtrls, Buttons, Controls,
  ExtCtrls, {QTypes,} Graphics, Forms, Dialogs, ComCtrls, DBCtrls, DBEditFocus,
  {Qt,} EditFocus, DBGrids, Grids, DBComboBoxFocus, ComboBoxFocus, MaskEditFocus, Uni, DB,
  Mask, FilenameEditFocus, DirectoryEditFocus, AppEvnts, Messages, untFuncoes,
  untITSQLTrace, untTSQLTrace, untFuncoesSimples, untSQLTraceOpcoes, untPaiSQLTrace,
  Vcl.Themes, Vcl.Styles, Vcl.SysStyles, TypInfo, cxControls, cxGroupBox, cxCustomListBox,
  cxCheckListBox;

type
  TfrmPai = class(TfrmPaiSQLTrace)
    pnlBotoes: TPanel;
    btnSair: TBitBtn;
    ApplicationEvents: TApplicationEvents;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    btnShowTrace: TSpeedButton;
    btnHideTrace: TSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure btnShowTraceClick(Sender: TObject);
    procedure btnHideTraceClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure pFinalizar;
    procedure pIniTraceForms;
    procedure pAjustarTema(AParent: TWinControl);
  protected
    stlCampos: TStringList;
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    qryTabela: TUniQuery;

    blnIniTraceForms: Boolean;

    procedure pOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;

    procedure pProximoControle(Sender: TObject);
    procedure pEscapePressed; virtual;

    {*******************************************}
    {* FUNÇÕES DE VALIDAÇÃO!                   *}
    {****************************************MV*}
    function fVerificaCampos: Boolean;
    function fValidaPanel(pnlPanel: TPanel; blnBuscaPorChave: Boolean = False): Boolean;
    function fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; virtual;

  public
    strUltimoCodigo: String;
    blnMudarFoco: Boolean;

    procedure pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TDBEdit; blnHabilitar: Boolean);
    procedure pSQLTrace(Sender: TObject; blnAuth: Boolean = False; blnCabecalho: Boolean = False);
  end;

var
  frmPai: TfrmPai;

implementation

uses cxDBEdit;

{$R *.dfm}

procedure TfrmPai.FormActivate(Sender: TObject);
begin
  If (Assigned(VS_Trace)) and (VS_Trace.GetAutenticado()) And (blnIniTraceForms) Then
    pIniTraceForms;

  If Not blnUsuarioLogadoUtilizaModoClassico Then
    If TStyleManager.ActiveStyle.Name = 'Sapphire Kamri' Then
      pAjustarTema(Self);
end;

procedure TfrmPai.FormCreate(Sender: TObject);
  Var
    intContador: Integer;
begin

  {*****************************************}
  {* PARA NAO DEIXAR O FORM AUMENTAR       *}
  {**************************************MV*}

  pnlNomeForm.Caption := Self.Name;
  blnMudarFoco := True;

  {*****************************************}
  {* ATRIBUI OS METODOS REFERENTES AO      *}
  {* EVENTO 'OnKeyDown' DOS COMPONENTES    *}
  {**************************************MV*}
  For intContador := 0 To Self.ComponentCount -1 Do
  begin
    if (Self.Components[intContador] Is TDBEditFocus) then
    begin
      (Self.Components[intContador] As TDBEditFocus).OnKeyDown := pOnKeyDownEdits;
    end

    else if (Self.Components[intContador] Is TDBCheckBox) then
    begin
      (Self.Components[intContador] As TDBCheckBox).OnKeyDown := pOnKeyDown;
    end

    else if (Self.Components[intContador] Is TCheckBox) then
    begin
      (Self.Components[intContador] As TCheckBox).OnKeyDown := pOnKeyDown;
    end

    else if (Self.Components[intContador] Is TRadioButton) then
    begin
      (Self.Components[intContador] As TRadioButton).OnKeyDown := pOnKeyDown;
    end

    else if (Self.Components[intContador] Is TDBComboBoxFocus) then
    begin
      (Self.Components[intContador] As TDBComboBox).OnKeyDown := pOnKeyDownEdits;
    end

    else if (Self.Components[intContador] Is TEditFocus) then
    begin
      (Self.Components[intContador] As TEditFocus).OnKeyDown := pOnKeyDownEdits;
    end

    else if (Self.Components[intContador] Is TMaskEditFocus) then
    begin
      if (Self.Components[intContador] As TMaskEditFocus).Tag = 99 then
        (Self.Components[intContador] As TMaskEditFocus).OnKeyDown := pOnKeyDownEdits
      else
        (Self.Components[intContador] As TMaskEditFocus).OnKeyDown := pOnKeyDown;
    end

    else if (Self.Components[intContador] Is TcxDBMaskEdit) then
    begin
      if (Self.Components[intContador] As TcxDBMaskEdit).Tag = 99 then
        (Self.Components[intContador] As TcxDBMaskEdit).OnKeyDown := pOnKeyDownEdits
      else
        (Self.Components[intContador] As TcxDBMaskEdit).OnKeyDown := pOnKeyDown;
    end

    else if (Self.Components[intContador] Is TFilenameEditFocus) then
    begin
      if (Self.Components[intContador] As TFilenameEditFocus).Tag = 99 then
        (Self.Components[intContador] As TFilenameEditFocus).OnKeyDown := pOnKeyDownEdits
      else
        (Self.Components[intContador] As TFilenameEditFocus).OnKeyDown := pOnKeyDown;
    end

    else if (Self.Components[intContador] Is TDirectoryEditFocus) then
    begin
      if (Self.Components[intContador] As TDirectoryEditFocus).Tag = 99 then
        (Self.Components[intContador] As TDirectoryEditFocus).OnKeyDown := pOnKeyDownEdits
      else
        (Self.Components[intContador] As TDirectoryEditFocus).OnKeyDown := pOnKeyDown;
    end

    else if (Self.Components[intContador] Is TComboBoxFocus) then
    begin

      if (Self.Components[intContador] As TComboBoxFocus).Tag = 99 then
        (Self.Components[intContador] As TComboBoxFocus).OnKeyDown := pOnKeyDownEdits
      else
        (Self.Components[intContador] As TComboBoxFocus).OnKeyDown := pOnKeyDown;

    end;

  end;

  //****

  blnIniTraceForms := (Not fIniciaLogTrace);

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



  {*****************************************}
  {* PARA NAO DEIXAR O FORM AUMENTAR       *}
  {**************************************MV*}

  pnlNomeForm.Caption := Self.Name;
  blnMudarFoco := True;


end;

procedure TfrmPai.btnHideTraceClick(Sender: TObject);
begin
  pnlBotoesSQLTrace.Height  := 0;
  pnlBotoesSQLTrace.Visible := False;

  Refresh;

  btnShowTrace.Visible := True;
  btnHideTrace.Visible := False;
end;

procedure TfrmPai.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPai.btnShowTraceClick(Sender: TObject);
begin
  pnlBotoesSQLTrace.Top     := Self.Height;
  pnlBotoesSQLTrace.Height  := 26;
  pnlBotoesSQLTrace.Visible := True;

  Refresh;

  btnShowTrace.Visible := False;
  btnHideTrace.Visible := True;
end;

procedure TfrmPai.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_Escape) then
  begin
    if (ActiveControl Is TBitBtn) then
    begin
      pEscapePressed;
    end;
  end;

  If Key = VK_Return Then
  Begin
    If (ActiveControl Is TRadioButton) And
       (ActiveControl.Parent <> Nil) And
       (ActiveControl.Parent Is TRadioGroup) Then
      SelectNext(ActiveControl, True, True);
  End;

  Case Key of
    VK_F2    : If (Shift = [ssShift, ssAlt, ssCtrl]) And (Not fIniciaLogTrace) Then
                 pSQLTrace(Sender);
  End;
end;

procedure TfrmPai.pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TDBEdit;
  blnHabilitar: Boolean);
begin
	if (Not blnHabilitar) then
  begin
		dbeCampoEnable.Enabled := blnHabilitar;
    dbeCampoEnable.Color := $00FFDFB8;
  end;
  if dbeCampoFocus.Enabled then
    dbeCampoFocus.SetFocus;
end;

procedure TfrmPai.pIniTraceForms;
begin
  btnShowTrace.Width := 16;
  btnShowTrace.BringToFront;
//  btnShowTrace.Click;

  pnlBotoesSQLTrace.Top     := Self.Height;
  pnlBotoesSQLTrace.Height  := 26;
  pnlBotoesSQLTrace.Visible := True;

  Self.Height := Self.Height + 26;

  Refresh;

  btnShowTrace.Visible := False;
  btnHideTrace.Visible := True;


//

  btnHideTrace.Width := 16;
  btnHideTrace.BringToFront;

  tmrSQLTrace.Enabled := (True);

  objTracePai := VS_Trace;
  pAtualizaControls();
end;

procedure TfrmPai.pSQLTrace(Sender: TObject; blnAuth: Boolean = False; blnCabecalho: Boolean = False);
  Var
    strSenha: String;
begin
  If (Assigned(VS_Trace)) And (VS_Trace.GetAutenticado()) Then
  Begin
    btnPausarSQLTrace.Click();
    pFinalizar;
  End
  // Não está efetuando trace, então começa efetuar
  Else
  Begin
    VS_Trace := TSQLTrace.Create();
    VS_Trace.Autenticado := blnAuth;
    VS_Trace.Cabecalho := blnCabecalho;

    if (not VS_Trace.GetAutenticado()) then
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
      objTracePai := VS_Trace;
      objTracePai.pIniciaTrace();
    End
    Else
    Begin
      pIniTraceForms();
      btnIniciarSQLTrace.Click();
    End;
  End;
end;

function TfrmPai.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
end;

function TfrmPai.fValidaPanel(pnlPanel: TPanel;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intContador: Integer;
begin

  Result := True;
  
  For intContador := 0 To pnlPanel.ControlCount -1 Do
  begin

    if pnlPanel.Controls[intContador].Tag = 99 then
      Result := fValidaCampos(TWinControl(pnlPanel.Controls[intContador]), blnBuscaPorChave);

    if Not Result then
      Break;

  end;

end;

{******************************************}
{* FUNÇÃO QUE REVALIDA TODOS OS CAMPOS    *}
{* VERifICA TODOS OS CAMPOS E CASO OCORRA *}
{* ALGUMA FALHA NA VERifICAÇÃO, FOCA TAL  *}
{* CAMPO.                                 *}
{***************************************MV*}
function TfrmPai.fVerificaCampos: Boolean;
begin
  Result := fVerificaSubObjeto(Self);
end;

{*********************************}
{* VERifICA TODOS OS COMPONENTES *}
{* DENTRO DE PANEL OU SCROLLBOX  *}
{* (RECURSIVO)                   *}
{******************************AF*}
function TfrmPai.fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
  Var
    intContador: Integer;
begin
  Result := True;

  For intContador := 0 To objObjeto.ComponentCount -1 Do
  begin
    {**********************************}
    {* SE O COMPONETE FOR UM PANEL,   *}
    {* UM SCROLLBOX OU TABSHEET       *}
    {*******************************AF*}
    if (objObjeto.Components[intContador] Is TPanel)     Or
       (objObjeto.Components[intContador] Is TScrollBox) Or
       (objObjeto.Components[intContador] Is TTabSheet)  then
    begin

      if (objObjeto.Components[intContador] Is TTabSheet) then
      begin
        {*******************************************}
        {* CASO NÃO QUERIA VALIDA UM TABSHEET, USE *}
        {* O VALOR -1 EM SEU TAG                   *}
        {****************************************MV*}
        if ((objObjeto.Components[intContador] As TTabSheet).Tag = -1) then
        begin
          Exit
        end;
        (objObjeto.Components[intContador] As TTabSheet).PageControl.ActivePage := (objObjeto.Components[intContador] As TTabSheet);
      end;

      Result := fVerificaSubObjeto((objObjeto.Components[intContador] As TWinControl));

      if Not Result then
        Exit;

    end
    else
    begin
      {**************************************}
      {* SE A TAG DO COMPONENTES = 99 ENTÃO *}
      {***********************************AF*}
      if objObjeto.Components[intcontador].Tag = 99 then
        if (objObjeto.Components[intContador] Is TWinControl) then
        begin
          Try
            Result := fValidaCampos((objObjeto.Components[intContador] As TWinControl), False);
          Except
            On E: Exception Do
            begin
              fMensagem('AVISO', E.Message, ['OK']);
              Result := False;
            end;
          end;
        end;

        if Not Result then
          Exit;
    end;

  end;

end;

procedure TfrmPai.pProximoControle(Sender: TObject);
begin
  if (Sender As TWinControl).Tag = 99 then
  begin
    if (fValidaCampos(TWinControl(Sender))) And (blnMudarFoco) then
      SelectNext(ActiveControl, True, True);
  end
  else
    SelectNext(ActiveControl, True, True);
  blnMudarFoco := True;
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
      TcxGroupBox(AControl).Transparent := True;
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


procedure TfrmPai.pEscapePressed;
begin
  Close;
end;

procedure TfrmPai.pFinalizar;
begin
//  btnHideTrace.Click;

  pnlBotoesSQLTrace.Height  := 0;
  pnlBotoesSQLTrace.Visible := False;

  Self.Height := Self.Height - 26;

  Refresh;

  btnShowTrace.Visible := True;
  btnHideTrace.Visible := False;


  btnHideTrace.Visible := False;

  btnShowTrace.Visible := False;

  tmrSQLTrace.Enabled := (False);

  objTracePai.SetAutenticado(False);
end;

procedure TfrmPai.pOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if (Key = VK_Return) then
  begin
    pProximoControle(Sender);
  end
  else if (Key = VK_Escape) then
  begin
    pEscapePressed;
  end;
end;

{*****************************************}
{* FUNÇÃO QUE É ATRIBUIDA NO EVENTO      *}
{* 'OnKeyDown' DOS Edits. (continua...)  *}
{**************************************MV*}
procedure TfrmPai.pOnKeyDownEdits(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if (Key = VK_Return) then
  begin
    pProximoControle(Sender);
  end
  else if (Key = VK_Escape) then
  begin
    pEscapePressed;
  end;
end;


procedure TfrmPai.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
  var i: SmallInt;
begin

  if (ActiveControl is TDBGrid) then
  begin
    with TDBGrid(ActiveControl) do
    begin
      if Msg.message = WM_MOUSEWHEEL then
      begin
        Msg.message := WM_KEYDOWN;
        Msg.lParam := 0;
        i := HiWord(Msg.wParam);
        if i > 0 then
          Msg.wParam := VK_UP
        else
          Msg.wParam := VK_DOWN;
        Handled := False;
      end;
    end;
  end;

end;

end.






