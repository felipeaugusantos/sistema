unit Login.View.FMXLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  System.ImageList, FMX.ImgList, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Platform.Win, Winapi.Windows, FMX.Edit, FMX.Layouts, FMX.Ani,
  Login.View.Interfaces, FMX.ListBox, FMX.Effects, System.Actions, FMX.ActnList,
  StrUtils;

type
  TAcao = (typIn, typOut);

type
  TfmxLogin = class(TForm)
    lblUser: TLabel;
    edtSenha: TEdit;
    lblSenha: TLabel;
    edtEmpresa: TEdit;
    lblEmpresa: TLabel;
    layFundo: TLayout;
    imgUser: TImage;
    imgSenha: TImage;
    imgEmpresa: TImage;
    linUser: TLine;
    linSenha: TLine;
    linEmpresa: TLine;
    lblErro: TLabel;
    StyleBook1: TStyleBook;
    edtUser: TEdit;
    LinhaVermelha: TBrushObject;
    LinhaPadrao: TBrushObject;
    imgUserRed: TImage;
    imgSenhaRed: TImage;
    imgEmpresaRed: TImage;
    cheVersaoClassica: TCheckBox;
    btnFechar: TSpeedButton;
    imgFecharLine: TImage;
    imgFecharFull: TImage;
    btnLogin: TButton;
    lblNomeEmpresa: TLabel;
    ActionList1: TActionList;
    actConsultarEmpresas: TAction;
    linUserCursor: TLine;
    Timer: TTimer;
    linSenhaCursor: TLine;
    linEmpresaCursor: TLine;
    recFundo: TRectangle;  
    procedure btnFecharClick(Sender: TObject);
    procedure edtUserEnter(Sender: TObject);
    procedure edtUserExit(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtUserChangeTracking(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtEmpresaExit(Sender: TObject);
    procedure edtEmpresaEnter(Sender: TObject);
    procedure btnFecharMouseEnter(Sender: TObject);
    procedure btnFecharMouseLeave(Sender: TObject);
    procedure imgEmpresaClick(Sender: TObject);
    procedure lblNomeEmpresaMouseEnter(Sender: TObject);
    procedure edtEmpresaChange(Sender: TObject);
    procedure actConsultarEmpresasExecute(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtUserClick(Sender: TObject);
    procedure edtUserKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cheVersaoClassicaEnter(Sender: TObject);
    procedure cheVersaoClassicaExit(Sender: TObject);
  private
    { Private declarations }

    procedure pAnimacaoEdit(Sender: TEdit; labelAni: TLabel; imgAni: TImage;
      linAni: TLine; typAcao: TAcao);
    procedure pColoreEdit(Sender:TEdit);

    procedure SetFocus(const Value: IControl);

    procedure EscondeCursor(Sender: TObject);
    procedure MoveCursor(Sender: TObject; Key: Word);
    procedure PiscaCursor(Sender: TObject);
    procedure ValidarEmpresasDoUsuario;

    function RetornaCursorDoEditFocado: TLine;
    function UsuarioTemApenasUmaEmpresaDeAcesso: Boolean;
  public
    { Public declarations }
    objLogin: ILogin;
  end;

function ExecutarLogin(AObjLogin: ILogin; RunningInTSPlus: Boolean = False): Boolean;

implementation

{$R *.fmx}

uses Login.View.FMXConsultaEmpresa, FMX.Citel.Platform.Services;

function ExecutarLogin(AObjLogin: ILogin; RunningInTSPlus: Boolean = False): Boolean;
var
  fmxLogin: TfmxLogin;
begin
  fmxLogin := TfmxLogin.Create(nil);

  Try
    fmxLogin.objLogin := AObjLogin;

    If RunningInTSPlus Then
    Begin
      fmxLogin.Transparency              := False;
      fmxLogin.recFundo.Corners          := [];
      fmxLogin.recFundo.Stroke.Thickness := 0;
      fmxLogin.btnFechar.Visible         := False;
    End
    Else
    Begin
      fmxLogin.Transparency              := True;
      fmxLogin.recFundo.Corners          := [TCorner.TopLeft,
                                             TCorner.TopRight,
                                             TCorner.BottomLeft,
                                             TCorner.BottomRight];
      fmxLogin.recFundo.Stroke.Thickness := 2;
      fmxLogin.btnFechar.Visible         := True;
    End;

    fmxLogin.ShowModal;
    Result := AObjLogin.LoginRealizado;
  Finally
    FreeAndNil(fmxLogin);
  End;

  FMXTimerServiceCitel.ClearAllTimers;
end;

procedure TfmxLogin.actConsultarEmpresasExecute(Sender: TObject);
begin
  If (edtEmpresa.IsFocused) Then
    imgEmpresaClick(imgEmpresa);
end;

procedure TfmxLogin.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfmxLogin.edtEmpresaChange(Sender: TObject);
begin
  If (edtEmpresa.Text <> EmptyStr) Then
  Begin
    try
      try
        objLogin.SetEmpresa(FormatFloat('000',StrToInt(edtEmpresa.Text)));
        objLogin.ValidarEmpresa(False);
      finally
        lblNomeEmpresa.Text := objLogin.NomeEmpresa(FormatFloat('000',StrToInt(edtEmpresa.Text)));
        lblErro.Text        := EmptyStr;
      end;
    except
      On E: ELoginEmpresaException Do
      Begin
        lblErro.Text := E.Message;
        Self.SetFocus(edtEmpresa);
      End;
    end;
  End;
end;

procedure TfmxLogin.edtEmpresaEnter(Sender: TObject);
begin
  lblNomeEmpresa.Visible := False;
  If (TEdit(Sender).Text <> EmptyStr) Then
    TEdit(Sender).Text := FormatFloat('000',StrToInt(TEdit(Sender).Text));

  edtUserEnter(Sender);
end;

procedure TfmxLogin.edtEmpresaExit(Sender: TObject);
begin
  If (TEdit(Sender).Text <> EmptyStr) Then
  Begin
    TEdit(Sender).Text := FormatFloat('000',StrToInt(TEdit(Sender).Text));
    lblNomeEmpresa.Visible := True;
  End;

  edtUserExit(Sender);
end;

procedure TfmxLogin.edtUserChangeTracking(Sender: TObject);
begin
  TEdit(Sender).Text := AnsiUpperCase(TEdit(Sender).Text);
  MoveCursor(Sender, vkRight);
end;

procedure TfmxLogin.edtUserClick(Sender: TObject);
begin
  MoveCursor(Sender, vkNone);
end;

procedure TfmxLogin.edtUserEnter(Sender: TObject);
begin
  If (TEdit(Sender).Name = 'edtUser') Then
    pAnimacaoEdit(edtUser, lblUser, imgUser, linUser, typIn)

  Else If (TEdit(Sender).Name = 'edtSenha') Then   
    pAnimacaoEdit(edtSenha, lblSenha, imgSenha, linSenha, typIn)

  Else
    pAnimacaoEdit(edtEmpresa, lblEmpresa, imgEmpresa, linEmpresa, typIn);

  PiscaCursor(Sender);
end;

procedure TfmxLogin.edtUserExit(Sender: TObject);
begin
  If (TEdit(Sender).Name = 'edtUser') Then
  Begin
    pColoreEdit(edtUser);
    pAnimacaoEdit(edtUser, lblUser, imgUser, linUser, typOut);

    If Not TEdit(Sender).Text.IsEmpty Then
      ValidarEmpresasDoUsuario;
  End
  Else If (TEdit(Sender).Name = 'edtSenha') Then
  Begin
    pColoreEdit(edtSenha);
    pAnimacaoEdit(edtSenha, lblSenha, imgSenha, linSenha, typOut);
  End
  Else
  Begin
    pColoreEdit(edtEmpresa);
    pAnimacaoEdit(edtEmpresa, lblEmpresa, imgEmpresa, linEmpresa, typOut);
  End;

  EscondeCursor(Sender);

  if cheVersaoClassica.Visible Then
    cheVersaoClassica.IsChecked := objLogin.UtilizaModoClassico(edtUser.Text);
end;

procedure TfmxLogin.edtUserKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  If (TEdit(Sender).Name = 'edtEmpresa') Then
    If (KeyChar = '/') Then
      actConsultarEmpresasExecute(Nil);

  If (TEdit(Sender).Text <> EmptyStr) Then
  Begin
    Case Key Of
      vkLeft, vkHome, vkRight, vkEnd : MoveCursor(Sender, Key);
    End;
  End;
end;

procedure TfmxLogin.EscondeCursor(Sender: TObject);
Var
  LCursor: TLine;
begin
  LCursor := TLine(FindComponent('lin' + Copy(TEdit(Sender).Name,4,20) + 'Cursor'));
  LCursor.Visible := False;
  LCursor.Tag := 0;
end;

procedure TfmxLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if cheVersaoClassica.IsChecked Then
    ShowWindow(ApplicationHWND, SW_HIDE);
end;

procedure TfmxLogin.FormCreate(Sender: TObject);
begin
  EscondeCursor(edtUser);
  EscondeCursor(edtSenha);
  EscondeCursor(edtEmpresa);
  Timer.Enabled := True;
end;

procedure TfmxLogin.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    VK_RETURN:
      Begin
        Key := vkTab;
        KeyDown(Key, KeyChar, Shift);
      End;
  End;
end;

procedure TfmxLogin.FormShow(Sender: TObject);
Var
  LUserLogado, LEmpresaDefault: String;
begin
  lblErro.Text := EmptyStr;

  LEmpresaDefault := objLogin.EmpresaDefault;

  If Not (LEmpresaDefault.IsEmpty) Then
  Begin
    pAnimacaoEdit(edtEmpresa, lblEmpresa, imgEmpresa, linEmpresa, typIn);
    edtEmpresa.Enabled  := False;
    edtEmpresa.Text     := LEmpresaDefault;
    lblNomeEmpresa.Text := objLogin.NomeEmpresa(FormatFloat('000',StrToInt(edtEmpresa.Text)));
  End;

  layFundo.Opacity := 1;
  Sleep(100);

  Self.SetFocus(edtUser);

  cheVersaoClassica.Visible := (Not objLogin.RealizandoLogoff);

  If Not cheVersaoClassica.Visible Then
  Begin
    LUserLogado := objLogin.UsuarioLogado;
    cheVersaoClassica.IsChecked := objLogin.UtilizaModoClassico(LUserLogado);
  End;
end;

procedure TfmxLogin.imgEmpresaClick(Sender: TObject);
Var
  LEmpresa: String;
  LEmpresas: TArray<String>;
begin
  Timer.Enabled := False;
  Try
    edtEmpresa.SetFocus;

    LEmpresas := objLogin.ListaEmpresas(edtUser.Text);

    If (Length(LEmpresas) = 0) Then
    Begin
      If (edtUser.Text.IsEmpty) Then
        lblErro.Text := 'Nenhuma empresa cadastrada para seleção.'
      Else
        lblErro.Text := 'Nenhuma empresa vinculada ao usuário informado.';

      Self.SetFocus(edtUser);
    End
    Else
    Begin
      fmxConsultaEmpresa := TfmxConsultaEmpresa.Create(Self);
      Try
        For LEmpresa in LEmpresas do
          fmxConsultaEmpresa.lstEmpresas.Add(LEmpresa + '|' +
                                             objLogin.NomeEmpresa(LEmpresa) + '|' +
                                             objLogin.NomeFantasia(LEmpresa));

        fmxConsultaEmpresa.ShowModal;

        If (fmxConsultaEmpresa.ModalResult = mrOk) Then
        Begin
          lblErro.Text    := EmptyStr;
          edtEmpresa.Text := fmxConsultaEmpresa.strCodEmp;
          edtEmpresaChange(edtEmpresa);
          btnLogin.SetFocus;
        End;
      Finally
        FreeAndNil(fmxConsultaEmpresa);
      End;
    End;
  Finally
    Timer.Enabled := True;
  End;
end;

procedure TfmxLogin.lblNomeEmpresaMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Hint := TLabel(Sender).Text;
end;

procedure TfmxLogin.MoveCursor(Sender: TObject; Key: Word);
Var
  LText: String;
  LEdit: TEdit;
  LCursor: TLine;
  LFatorAjuste: Double;
begin
  LEdit   := TEdit(Sender);
  LCursor := TLine(FindComponent('lin' + Copy(TEdit(Sender).Name,4,20) + 'Cursor'));
  LFatorAjuste := 2.5;

  LEdit.Canvas.Font.Family := LEdit.Font.Family;
  LEdit.Canvas.Font.Size   := Ledit.Font.Size;

  PiscaCursor(LEdit);

  Case Key Of
    vkEnd  : LCursor.Position.X := LEdit.Canvas.TextWidth(String(LEdit.Text).Replace(' ', '.')) + LFatorAjuste;
    vkHome : LCursor.Position.X := LFatorAjuste;

    vkLeft, vkRight, vkNone:
    Begin
      If Key = vkLeft Then
        LText := Copy(String(LEdit.Text).Replace(' ', '.'), 1, (LEdit.CaretPosition - 1))
      Else If Key = vkRight Then
        LText := Copy(String(LEdit.Text).Replace(' ', '.'), 1, (LEdit.CaretPosition + 1))
      Else
        LText := Copy(String(LEdit.Text).Replace(' ', '.'), 1, (LEdit.CaretPosition));

      LCursor.Position.X := LEdit.Canvas.TextWidth(LText) + LFatorAjuste;
    End;
  End;
end;

procedure TfmxLogin.pAnimacaoEdit(Sender: TEdit; labelAni: TLabel; imgAni: TImage;
  linAni: TLine; typAcao: TAcao);
begin
  Case typAcao Of
    typIn:
    Begin
      If TEdit(Sender).text = EmptyStr Then
      Begin
        labelAni.TextSettings.Font.Size := 13;
        labelAni.Position.Y             := -23;
      End;

      TEdit(Sender).Opacity           := 1;
    End;

    typOut:
    Begin
      If TEdit(Sender).text = EmptyStr Then
      Begin
        labelAni.TextSettings.Font.Size := 23;
        labelAni.Position.Y             := 0;
      End;

      TEdit(Sender).Opacity           := 0.6;
    End;
  End;
end;

procedure TfmxLogin.pColoreEdit(Sender: TEdit);
begin
  If (TEdit(Sender).Name = 'edtUser') Then
  Begin
    If (TEdit(Sender).Text = EmptyStr) Then
    Begin
      linUser.Stroke.Resource.StyleResource := LinhaVermelha;
      linUser.Stroke.Kind                   := TBrushKind.Resource;
      //lblUser.StyleLookup                   := 'LabelVermelho';
      imgUser.Visible                       := False;
      imgUserRed.Visible                    := True;
    End
    Else
    Begin
      linUser.Stroke.Resource.StyleResource := LinhaPadrao;
      linUser.Stroke.Kind                   := TBrushKind.Resource;
      //lblUser.StyleLookup                   := 'LabelPadrao';
      imgUser.Visible                       := True;
      imgUserRed.Visible                    := False;
    End;
  End;

  If (TEdit(Sender).Name = 'edtSenha') Then
  Begin
    If (TEdit(Sender).Text = EmptyStr) Then
    Begin
      linSenha.Stroke.Resource.StyleResource := LinhaVermelha;
      linSenha.Stroke.Kind                   := TBrushKind.Resource;
      //lblSenha.StyleLookup                   := 'LabelVermelho';
      imgSenha.Visible                       := False;
      imgSenhaRed.Visible                    := True;
    End
    Else
    Begin
      linSenha.Stroke.Resource.StyleResource := LinhaPadrao;
      linSenha.Stroke.Kind                   := TBrushKind.Resource;
      //lblSenha.StyleLookup                   := 'LabelPadrao';
      imgSenha.Visible                       := True;
      imgSenhaRed.Visible                    := False;
    End;
  End;

  If (TEdit(Sender).Name = 'edtEmpresa') Then
  Begin
    If (TEdit(Sender).Text = EmptyStr) Then
    Begin
      linEmpresa.Stroke.Resource.StyleResource := LinhaVermelha;
      linEmpresa.Stroke.Kind                   := TBrushKind.Resource;
      //lblEmpresa.StyleLookup                   := 'LabelVermelho';
      imgEmpresa.Visible                       := False;
      imgEmpresaRed.Visible                    := True;
    End
    Else
    Begin
      linEmpresa.Stroke.Resource.StyleResource := LinhaPadrao;
      linEmpresa.Stroke.Kind                   := TBrushKind.Resource;
      //lblEmpresa.StyleLookup                   := 'LabelPadrao';
      imgEmpresa.Visible                       := True;
      imgEmpresaRed.Visible                    := False;
    End;
  End;
end;

procedure TfmxLogin.PiscaCursor(Sender: TObject);
Var
  LCursor: TLine;
begin
  LCursor := TLine(FindComponent('lin' + Copy(TEdit(Sender).Name,4,20) + 'Cursor'));
  LCursor.Tag := 1;
end;

function TfmxLogin.RetornaCursorDoEditFocado: TLine;
Var
  LContador: Integer;
begin
  Result := Nil;

  For LContador := 0 to Self.ComponentCount - 1 do
  Begin
    If (Self.Components[LContador].ClassNameIs('TEdit')) Then
      If (TEdit(Self.Components[LContador]).IsFocused) Then
        Result := TLine(FindComponent('lin' + Copy(TEdit(Self.Components[LContador]).Name,4,20) + 'Cursor'));
  End;
end;

procedure TfmxLogin.SetFocus(const Value: IControl);
begin
  Try
    Self.SetFocused(Value);
  Except
    On E: Exception Do
    Begin
      If Not E.Message.ToLower.Contains('Cannot focus this control'.ToLower) Then
        Raise;
    End;
  End;
end;

procedure TfmxLogin.TimerTimer(Sender: TObject);
Var
  LCursor: TLine;
begin
  LCursor := RetornaCursorDoEditFocado;

  If Assigned(LCursor) Then
  Begin
    If (LCursor.Tag = 0) Then
      LCursor.Visible := False

    Else If (LCursor.Tag = 1) Then
      LCursor.Visible := Not LCursor.Visible;
  End;
end;

function TfmxLogin.UsuarioTemApenasUmaEmpresaDeAcesso: Boolean;
begin
  Result := False;

  If (Length(objLogin.EmpresasLoginUsuario) = 4) Then
    If (edtEmpresa.Enabled) Then
      Result := True;
end;

procedure TfmxLogin.ValidarEmpresasDoUsuario;
begin
  objLogin.SetUsuario(edtUser.Text);
  objLogin.ValidarUsuario();

  If (objLogin.EmpresaDefault.IsEmpty) Then
  Begin
    If UsuarioTemApenasUmaEmpresaDeAcesso Then
    Begin
      pAnimacaoEdit(edtEmpresa, lblEmpresa, imgEmpresa, linEmpresa, typIn);
      edtEmpresa.Enabled  := False;
      edtEmpresa.Text     := LeftStr(objLogin.EmpresasLoginUsuario,3);
      lblNomeEmpresa.Text := objLogin.NomeEmpresa(FormatFloat('000',StrToInt(edtEmpresa.Text)));
    End
    Else
      edtEmpresa.Enabled := True;
  End;
end;

procedure TfmxLogin.btnFecharMouseEnter(Sender: TObject);
begin
  imgFecharLine.Opacity := 0;
  imgFecharFull.Opacity := 1;
end;

procedure TfmxLogin.btnFecharMouseLeave(Sender: TObject);
begin
  imgFecharLine.Opacity := 0.5;
  imgFecharFull.Opacity := 0;
end;

procedure TfmxLogin.btnLoginClick(Sender: TObject);
begin
  Try
    Try
      Timer.Enabled := False;

      edtUser.Text := Trim(edtUser.Text);
      edtEmpresa.Text := Trim(edtEmpresa.Text);

      objLogin.SetUsuario(edtUser.Text);
      objLogin.SetPassword(edtSenha.Text);
      objLogin.SetEmpresa(edtEmpresa.Text);

      If Not objLogin.ExecutarLogin() Then
        Exit;

      objLogin.SetUtilizaModoClassico(edtUser.Text, cheVersaoClassica.IsChecked);
      Self.Close;
    Finally
      lblErro.Text := EmptyStr;
    End;
  Except
    On E: ELoginEmpresaException Do
    Begin
      lblErro.Text := E.Message;
      Self.SetFocus(edtEmpresa);
    End;

    On E: ELoginUsuarioException Do
    Begin
      lblErro.Text := E.Message;
      Self.SetFocus(edtUser);
    End;

    On E: Exception Do
      Raise;
  End;
end;

procedure TfmxLogin.cheVersaoClassicaEnter(Sender: TObject);
begin
  cheVersaoClassica.Opacity := 1;
end;

procedure TfmxLogin.cheVersaoClassicaExit(Sender: TObject);
begin
  cheVersaoClassica.Opacity := 0.4;
end;

exports
  ExecutarLogin;

end.
