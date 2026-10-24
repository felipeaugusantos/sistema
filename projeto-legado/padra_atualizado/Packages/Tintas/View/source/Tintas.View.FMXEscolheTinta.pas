unit Tintas.View.FMXEscolheTinta;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.TabControl,
  FMX.StdCtrls, System.Actions, FMX.ActnList, FMX.Effects, FMX.Filter.Effects,
  FMX.Layouts, FMX.Ani, FMX.ListBox, System.StrUtils, System.ImageList,
  FMX.ImgList, FMX.Edit, FMX.MultiResBitmap,
  FMX.Citel.Platform.Services;

Type
  TDirecao = (Direita, Esquerda);

type
  TfmxEscolheTintaNovo = class(TForm)
    imgFoto: TImage;
    layFundo: TLayout;
    rec4: TRectangle;
    rec1: TRectangle;
    layCarrossel: TLayout;
    rec5: TRectangle;
    refefe4: TReflectionEffect;
    refefe1: TReflectionEffect;
    refefe5: TReflectionEffect;
    rec3: TRectangle;
    refefe3: TReflectionEffect;
    rec6: TRectangle;
    refefe6: TReflectionEffect;
    Rectangle6: TRectangle;
    rec2: TRectangle;
    refefe2: TReflectionEffect;
    rec7: TRectangle;
    refefe7: TReflectionEffect;
    btnFechar: TSpeedButton;
    imgFecharLine: TImage;
    imgFecharFull: TImage;
    TrackBar1: TTrackBar;
    lblTintaEscolhida: TLabel;
    edtPesquisa: TEdit;
    Timer1: TTimer;
    lblCaptionForm: TLabel;
    btnSetaEsquerda: TSpeedButton;
    patSetaEsquerda: TPath;
    btnSetaDireita: TSpeedButton;
    patSetaDireita: TPath;
    imglstTintas: TImageList;
    linPesquisa: TLine;
    imgPesquisa: TImage;
    tmrForceClose: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnFecharMouseEnter(Sender: TObject);
    procedure btnFecharMouseLeave(Sender: TObject);
    procedure rec4Click(Sender: TObject);
    procedure rec4MouseEnter(Sender: TObject);
    procedure rec4MouseLeave(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure edtPesquisaChangeTracking(Sender: TObject);
    procedure btnSetaEsquerdaClick(Sender: TObject);
    procedure btnSetaDireitaClick(Sender: TObject);
    procedure btnSetaEsquerdaMouseEnter(Sender: TObject);
    procedure btnSetaEsquerdaMouseLeave(Sender: TObject);
    procedure edtPesquisaClick(Sender: TObject);
    procedure tmrForceCloseTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    strPathImagens : String;
    MoverIcones    : Boolean;
    DirecaoTrackBar: TDirecao;

    {*****************************************}
    {* FUN«’ES E PROCEDURES DA CAMADA VISUAL *}
    {*****************************************}
    procedure StopAllAnimations(Target: TFmxObject);
    procedure AjustaTamanho(TintaIcone: TRectangle; Direcao: TDirecao);
    procedure GiraLista(Direcao: TDirecao);
    procedure AjustaLogoPrincipal(TintaIcone: TRectangle);
    procedure AjustaLogoLista(TintaIcone: TRectangle);
    procedure AjustaLogoTransparente(TintaIcone: TRectangle);
    procedure AnimaDeslocamento(Target: TFMXObject; NewValue: Single);
    procedure LoadPNGProximo(TintaIcone: TRectangle);
    procedure LoadPNGAnterior(TintaIcone: TRectangle);
    procedure FindTinta(Filtro: String);
    procedure AnimaPercorreLista(PosicaoAtual, NovaPosicao: Integer; Duracao: Single = 2);
    procedure LoadLogoTinta(TintaIcone: TRectangle; Index: Integer);
    procedure SelecionaTinta(Sender: TRectangle);
    procedure AjustaTag(TintaIcone: TRectangle; Direcao: TDirecao);
    procedure MostrarPesquisa;
    procedure EsconderPesquisa;
    procedure PreCarregarTintas;
    procedure CarregaUnicaTinta;
    procedure CarregaDuasTintas;
    procedure CarregaTresTintas;

    function GetLogoPrincipal: TRectangle;
    function GetLogoByTag(TagIndex: Integer): TRectangle;
    function GetPosicaoByTag(TagIndex: Integer; Direcao: TDirecao): Single;
    function IsRectangleTintaIcone(Objeto: TComponent): Boolean;
    function GetNomeTinta(Tinta: String): String;
    function GetIdePro(Tinta: String): ShortString;

  public
    { Public declarations }
    lstTintas: TStringList;
    strIdeProSelecionada : ShortString;

  end;

Const
  Pos1: Single = -85;
  Pos2: Single = 0;
  Pos3: Single = 85;
  Pos4: Single = 170;
  Pos5: Single = 305;
  Pos6: Single = 390;
  Pos7: Single = 475;

function SelecionaTinta(lstTintas: TStringList): ShortString;

implementation

{$R *.fmx}

function SelecionaTinta(lstTintas: TStringList): ShortString;
var
  fmxEscolheTinta: TfmxEscolheTintaNovo;
begin
  fmxEscolheTinta := TfmxEscolheTintaNovo.Create(nil);
  Try
    fmxEscolheTinta.lstTintas := lstTintas;
    fmxEscolheTinta.ShowModal;
    Result := fmxEscolheTinta.strIdeProSelecionada;
  Finally
    FreeAndNil(fmxEscolheTinta);
  End;
End;

function fRemoveAcento(Str: String): String;
Const
  ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹"¥';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
Var
  x: Integer;
Begin
  For x := 1 to Length(Str) do
    If Pos(Str[x], ComAcento) <> 0 Then
      Str[x] := SemAcento[Pos(Str[x], ComAcento)];
  Result := Str;
end;

procedure TfmxEscolheTintaNovo.GiraLista(Direcao: TDirecao);
Var
  LContador: Integer;
  TagIndex : Single;
  LRecLogo : TRectangle;
begin
  For LContador := 0 to Self.ComponentCount - 1 do
  Begin
    If IsRectangleTintaIcone(Self.Components[LContador]) Then
    Begin
      LRecLogo := TRectangle(Self.Components[LContador]);
      TagIndex := GetPosicaoByTag(LRecLogo.Tag, Direcao);

      AjustaTamanho(LRecLogo, Direcao);
      AnimaDeslocamento(LRecLogo, TagIndex);
    End;
  End;
end;

function TfmxEscolheTintaNovo.IsRectangleTintaIcone(Objeto: TComponent): Boolean;
begin
  Result := False;

  If (Objeto.ClassNameIs('TRectangle')) Then
    If (TRectangle(Objeto).Parent.Name = 'layCarrossel') Then
      Result := True;
end;

procedure TfmxEscolheTintaNovo.AjustaTag(TintaIcone: TRectangle; Direcao: TDirecao);
begin
  If (Direcao = Esquerda) Then
  Begin
    TintaIcone.Tag := TintaIcone.Tag - 1;

    If (TintaIcone.Tag = 0) Then
    Begin
      LoadPNGProximo(TintaIcone);
      TintaIcone.Tag := 7;
    End;
  End
  Else If (Direcao = Direita) Then
  Begin
    TintaIcone.Tag := TintaIcone.Tag + 1;

    If (TintaIcone.Tag = 8) Then
    Begin
      LoadPNGAnterior(TintaIcone);
      TintaIcone.Tag := 1;
    End
  End;
end;

procedure TfmxEscolheTintaNovo.AjustaTamanho(TintaIcone: TRectangle; Direcao: TDirecao);
begin
  If (Direcao = Esquerda) Then
  Begin
    Case TintaIcone.Tag Of
      2: AjustaLogoTransparente(TintaIcone);
      5: AjustaLogoPrincipal(TintaIcone);
      3,4,6,
      7: AjustaLogoLista(TintaIcone);
    End;
  End
  Else If (Direcao = Direita) Then
  Begin
    Case TintaIcone.Tag Of
      1,2,4,
      5: AjustaLogoLista(TintaIcone);
      3: AjustaLogoPrincipal(TintaIcone);
      6: AjustaLogoTransparente(TintaIcone);
    End;
  End;

  AjustaTag(TintaIcone, Direcao);
end;

procedure TfmxEscolheTintaNovo.AnimaDeslocamento(Target: TFMXObject; NewValue: Single);
begin
  TRectangle(Target).Position.x := NewValue;
end;

procedure TfmxEscolheTintaNovo.AnimaPercorreLista(PosicaoAtual, NovaPosicao: Integer; Duracao: Single = 2);
begin
  If (PosicaoAtual < NovaPosicao) Then
  begin
    while PosicaoAtual < NovaPosicao do
    begin
      btnSetaDireitaClick(btnSetaDireita);
      Inc(PosicaoAtual);
    end;
  end
  else
  begin
    while PosicaoAtual > NovaPosicao do
    begin
      btnSetaEsquerdaClick(btnSetaEsquerda);
      Dec(PosicaoAtual);
    end;
  end;
end;

procedure TfmxEscolheTintaNovo.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfmxEscolheTintaNovo.btnFecharMouseEnter(Sender: TObject);
begin
  imgFecharLine.Opacity := 0;
  imgFecharFull.Opacity := 1;
end;

procedure TfmxEscolheTintaNovo.btnFecharMouseLeave(Sender: TObject);
begin
  imgFecharLine.Opacity := 0.5;
  imgFecharFull.Opacity := 0;
end;

procedure TfmxEscolheTintaNovo.LoadPNGAnterior(TintaIcone: TRectangle);
Var
  Index: Integer;
begin
  Index := Round(TrackBar1.Value) - 4;

  If (Index < 0) Then
    Index := lstTintas.Count + Index;

  If (Index >= 0) Then
    LoadLogoTinta(TintaIcone, Index);
end;

procedure TfmxEscolheTintaNovo.LoadPNGProximo(TintaIcone: TRectangle);
Var
  Index: Integer;
begin
  Index := Round(TrackBar1.Value) + 2;

  If (Index > (lstTintas.Count - 1)) Then
    Index := Index - lstTintas.Count;

  If ((Index + 1) <= lstTintas.Count) Then
    LoadLogoTinta(TintaIcone, Index);
end;

procedure TfmxEscolheTintaNovo.MostrarPesquisa;
begin
  If lblTintaEscolhida.Visible Then
  Begin
    lblTintaEscolhida.Visible := False;
    If (imgPesquisa.Opacity < 0.9) Then
    Begin
      imgPesquisa.Opacity := 0.9;
      linPesquisa.Opacity := 0.9;
    End;
  End;
end;

procedure TfmxEscolheTintaNovo.PreCarregarTintas;
Const
  QtdTintas = [1, 2, 3];
begin
  If (Round(TrackBar1.Max) In QtdTintas) Then
  Begin
    Case Round(TrackBar1.Max) Of
     1: CarregaUnicaTinta;
     2: CarregaDuasTintas;
     3: CarregaTresTintas;
    End;
  End
  Else
  Begin
    LoadLogoTinta(rec1, lstTintas.Count - 3);
    LoadLogoTinta(rec2, lstTintas.Count - 2);
    LoadLogoTinta(rec3, lstTintas.Count - 1);
    LoadLogoTinta(rec4, 0);
    LoadLogoTinta(rec5, 1);
    LoadLogoTinta(rec6, 2);
    LoadLogoTinta(rec7, 3);
  End;
end;

procedure TfmxEscolheTintaNovo.edtPesquisaChange(Sender: TObject);
Var
  Filtro: String;
begin
  If (edtPesquisa.Text <> EmptyStr) Then
  Begin
    Filtro                    := edtPesquisa.Text;
    edtPesquisa.Text          := EmptyStr;
    lblTintaEscolhida.Visible := True;
    FindTinta(Filtro);
  End
  Else
    lblTintaEscolhida.Visible := True;
end;

procedure TfmxEscolheTintaNovo.edtPesquisaChangeTracking(Sender: TObject);
begin
  If (edtPesquisa.Text <> EmptyStr) Then
  Begin
    MostrarPesquisa;
  End
  Else
  Begin
    EsconderPesquisa;
  End;
end;

procedure TfmxEscolheTintaNovo.edtPesquisaClick(Sender: TObject);
begin
  MostrarPesquisa;
end;

procedure TfmxEscolheTintaNovo.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  If (Length(TEdit(Sender).Text) = 0) Then
    KeyChar := UpCase(KeyChar);

  Case Key Of
    vkLeft  : btnSetaEsquerdaClick(btnSetaEsquerda);
    vkRight : btnSetaDireitaClick(btnSetaDireita);
    vkEscape: btnFecharClick(btnFechar);
    vkReturn:
    Begin
      If lblTintaEscolhida.Visible Then
        rec4Click(GetLogoPrincipal);
    End;
  End;
end;

procedure TfmxEscolheTintaNovo.EsconderPesquisa;
begin
  If Not lblTintaEscolhida.Visible Then
  Begin
    lblTintaEscolhida.Visible := True;
    edtPesquisa.Text := EmptyStr;
    If (imgPesquisa.Opacity > 0.3) Then
    Begin
      imgPesquisa.Opacity := 0.3;
      linPesquisa.Opacity := 0.3;
    End;
  End;
end;

procedure TfmxEscolheTintaNovo.FindTinta(Filtro: String);
Var
  i: Integer;
  LPalavra, LPalavras: String;
  LEncontrou: Boolean;
begin
  For i := 0 To (lstTintas.Count - 1) Do
  Begin
    LEncontrou := True;
    LPalavras  := Trim(Filtro);

    While Pos('  ', LPalavras) > 0 Do
      LPalavras := AnsiReplaceStr(LPalavras, '  ', ' ');

    If LPalavras.IsEmpty Then
      Exit;

    For LPalavra In LPalavras.Split([' ']) Do
      LEncontrou := LEncontrou And UpperCase(fRemoveAcento(GetNomeTinta(lstTintas[i]))).Contains(UpperCase(fRemoveAcento(LPalavra)));

    If LEncontrou Then
    Begin
      AnimaPercorreLista(Round(TrackBar1.Value), i + 1);
      Exit;
    End;
  End;
end;

procedure TfmxEscolheTintaNovo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FMXTimerServiceCitel.ClearAllTimers;
end;

procedure TfmxEscolheTintaNovo.FormCreate(Sender: TObject);
begin
  strPathImagens := ExtractFilePath(ParamStr(0));
  strPathImagens := strPathImagens + '\auttin\Novas\';

  TrackBar1.Min := 1;
  strIdeProSelecionada := '';
end;

procedure TfmxEscolheTintaNovo.FormShow(Sender: TObject);
begin
  TrackBar1.Max := lstTintas.Count;

  PreCarregarTintas;

  TrackBar1.Value        := 1;
  lblTintaEscolhida.Text := AnsiReplaceStr(GetNomeTinta(lstTintas[Round(TrackBar1.Value - 1)]), '_', ' ');

  MoverIcones := True;
  strIdeProSelecionada := '';

  edtPesquisa.SetFocus;

  tmrForceClose.Enabled := True;
end;

function TfmxEscolheTintaNovo.GetIdePro(Tinta: String): ShortString;
begin
  Result := ShortString(AnsiReplaceStr(AnsiReplaceStr(RightStr(Tinta, 5), '[', ''), ']', ''));
end;

function TfmxEscolheTintaNovo.GetLogoByTag(TagIndex: Integer): TRectangle;
Var
  LContador: Integer;
begin
  Result := Nil;

  For LContador := 0 to Self.ComponentCount - 1 do
  Begin
    If (Self.Components[LContador].ClassNameIs('TRectangle')) Then
    Begin
      If (TRectangle(Self.Components[LContador]).Tag = TagIndex) Then
      Begin
        Result := TRectangle(Self.Components[LContador]);
        Exit;
      End;
    End;
  End;
end;

function TfmxEscolheTintaNovo.GetLogoPrincipal: TRectangle;
begin
  Result := GetLogoByTag(4);
end;

function TfmxEscolheTintaNovo.GetNomeTinta(Tinta: String): String;
Var
  strIdePro: ShortString;
begin
  strIdePro := GetIdePro(Tinta);
  Result    := AnsiReplaceStr(Tinta, '[' + String(strIdePro) + ']', '');
end;

function TfmxEscolheTintaNovo.GetPosicaoByTag(TagIndex: Integer;
  Direcao: TDirecao): Single;
begin
  Result := 0;

  If (Direcao = Esquerda) Then
  Begin
    Case TagIndex Of
      1: Result := Pos7;
      2: Result := Pos1;
      3: Result := Pos2;
      4: Result := Pos3;
      5: Result := Pos4;
      6: Result := Pos5;
      7: Result := Pos6;
    End;
  End
  Else If (Direcao = Direita) Then
  Begin
    Case TagIndex Of
      1: Result := Pos2;
      2: Result := Pos3;
      3: Result := Pos4;
      4: Result := Pos5;
      5: Result := Pos6;
      6: Result := Pos7;
      7: Result := Pos1;
    End;
  End;
end;

procedure TfmxEscolheTintaNovo.LoadLogoTinta(TintaIcone: TRectangle;
  Index: Integer);
Var
  Item   : TCustomBitmapItem;
  Size   : TSize;
begin
  If Index < 0 Then
    Index := 0
  Else
  If (Index > (Trackbar1.Max - 1)) Then
    Index := Round(Trackbar1.Max - 1);

  If imglstTintas.BitmapItemByName(String(GetIdePro(lstTintas[Index])), Item, Size) Then
  Begin
    TintaIcone.Fill.Bitmap.Bitmap := Item.MultiResBitmap.Bitmaps[1.0];
  End
  Else
  Begin
    imglstTintas.BitmapItemByName('ACA', Item, Size);
    TintaIcone.Fill.Bitmap.Bitmap := Item.MultiResBitmap.Bitmaps[1.0];
  End;
  TintaIcone.UpdateEffects;
end;

procedure TfmxEscolheTintaNovo.rec4Click(Sender: TObject);
begin
  If (TRectangle(Sender).Opacity <> 0) Then
  Begin
    Case TRectangle(Sender).Tag Of
      2: Begin
           btnSetaEsquerdaClick(btnSetaEsquerda);
           btnSetaEsquerdaClick(btnSetaEsquerda);
         End;

      3: Begin
           btnSetaEsquerdaClick(btnSetaEsquerda);
         End;

      4: Begin
           SelecionaTinta(TRectangle(Sender));
         End;

      5: Begin
           btnSetaDireitaClick(btnSetaDireita);
         End;

      6: Begin
           btnSetaDireitaClick(btnSetaDireita);
           btnSetaDireitaClick(btnSetaDireita);
         End;
    End;
  End;
end;

procedure TfmxEscolheTintaNovo.rec4MouseEnter(Sender: TObject);
begin
  If (TRectangle(Sender).Opacity > 0) Then
  Begin
    TRectangle(Sender).Cursor := crHandPoint;
    If (TRectangle(Sender).Tag = 4) Then
      TRectangle(Sender).Stroke.Color := TAlphaColorRec.Aqua;
  End;
end;

procedure TfmxEscolheTintaNovo.rec4MouseLeave(Sender: TObject);
begin
  If (TRectangle(Sender).Opacity > 0) Then
  Begin
    TRectangle(Sender).Cursor := crDefault;
    If (TRectangle(Sender).Tag = 4) Then
      TRectangle(Sender).Stroke.Color := TAlphaColorRec.White;
  End;
end;

procedure TfmxEscolheTintaNovo.SelecionaTinta(Sender: TRectangle);
Var
  LReflection: TReflectionEffect;
Begin
  tmrForceClose.Enabled  := False;
  tmrForceClose.Interval := 5000;
  tmrForceClose.Enabled  := True;

  LReflection := TReflectionEffect(FindComponent('refefe' + RightStr(TRectangle(Sender).Name, 1)));

  LReflection.Opacity := 0;
  LReflection.Opacity := 0.4;

  strIdeProSelecionada := GetIdePro(lstTintas[Round(TrackBar1.Value - 1)]);

  Close;
end;

procedure TfmxEscolheTintaNovo.StopAllAnimations(Target: TFmxObject);
var
  I: Integer;
  E: TAnimation;
begin
  if Target.Children <> nil then
    for I := Target.Children.Count - 1 downto 0 do
      if TFmxObject(Target.Children[I]) is TAnimation then
        begin
          E := TAnimation(Target.Children[I]);
          E.Stop;
        end;
end;

procedure TfmxEscolheTintaNovo.btnSetaEsquerdaClick(Sender: TObject);
begin
  If Not btnSetaEsquerda.Visible Then
    Exit;

  If Not lblTintaEscolhida.Visible Then
    lblTintaEscolhida.Visible := True;

  DirecaoTrackBar := Direita;

  If ((TrackBar1.Value - 1) < TrackBar1.Min) Then
    TrackBar1.Value := TrackBar1.Max
  Else
    TrackBar1.Value := TrackBar1.Value - 1;

  If (TrackBar1.Max = 2) Then
  Begin
    If (TrackBar1.Value = 1) Then
    Begin
      btnSetaEsquerda.Visible := False;
      btnSetaDireita.Visible  := True;
    End;
  End;
end;

procedure TfmxEscolheTintaNovo.btnSetaEsquerdaMouseEnter(Sender: TObject);
Var
  LPath: TPath;
begin
  LPath := TPath(FindComponent('pat' + Copy(TSpeedButton(Sender).Name, 4, 30)));
  LPath.Fill.Color := TAlphaColor($FF003E5A);
  LPath.Stroke.Color := TAlphaColor($FF003E5A);
end;

procedure TfmxEscolheTintaNovo.btnSetaEsquerdaMouseLeave(Sender: TObject);
Var
  LPath: TPath;
begin
  LPath := TPath(FindComponent('pat' + Copy(TSpeedButton(Sender).Name, 4, 30)));
  LPath.Fill.Color := TAlphaColorRec.White;
  LPath.Stroke.Color := TAlphaColorRec.White;
end;

procedure TfmxEscolheTintaNovo.CarregaDuasTintas;
Var
  LRecIndex : Integer;
  LRec : TRectangle;
begin
  For LRecIndex := 1 To 7 Do
  Begin
    LRec := TRectangle(FindComponent('rec' + LRecIndex.ToString));

    If (LRecIndex In [4,5]) Then
      LoadLogoTinta(LRec, LRecIndex - 4)
    Else
      LRec.Visible := False;
  End;

  btnSetaEsquerda.Visible := False;
end;

procedure TfmxEscolheTintaNovo.CarregaTresTintas;
Var
  LListIndex, LRecIndex: Integer;
  LRec : TRectangle;
begin
  LListIndex := 0;
  For LRecIndex := 1 To 7 Do
  Begin
    LRec := TRectangle(FindComponent('rec' + LRecIndex.ToString));
    LoadLogoTinta(LRec, LListIndex);

    Inc(LListIndex);

    If (LListIndex >= TrackBar1.Max) Then
      LListIndex := 0;
  End;
end;

procedure TfmxEscolheTintaNovo.CarregaUnicaTinta;
Var
  LRecIndex : Integer;
  LRec : TRectangle;
begin
  For LRecIndex := 1 To 7 Do
  Begin
    LRec := TRectangle(FindComponent('rec' + LRecIndex.ToString));

    If LRecIndex <> 4 Then
      LRec.Visible := False
    Else
      LoadLogoTinta(LRec, 0);
  End;
end;

procedure TfmxEscolheTintaNovo.btnSetaDireitaClick(Sender: TObject);
begin
  If Not btnSetaDireita.Visible Then
    Exit;

  If Not lblTintaEscolhida.Visible Then
    lblTintaEscolhida.Visible := True;

  DirecaoTrackBar := Esquerda;

  If ((TrackBar1.Value + 1) > TrackBar1.Max) Then
    TrackBar1.Value := TrackBar1.Min
  Else
    TrackBar1.Value := TrackBar1.Value + 1;

  If (TrackBar1.Max = 2) Then
  Begin
    If (TrackBar1.Value = 2) Then
    Begin
      btnSetaEsquerda.Visible := True;
      btnSetaDireita.Visible  := False;
    End;
  End;
end;

procedure TfmxEscolheTintaNovo.AjustaLogoPrincipal(TintaIcone: TRectangle);
begin
  TintaIcone.Width          := 125;
  TintaIcone.Height         := 125;
  TintaIcone.Position.Y     := 0;
  TintaIcone.Opacity        := 1;
  TintaIcone.Margins.Top    := 0;
  TintaIcone.Margins.Bottom := 0;
  TintaIcone.YRadius        := 15;
  TintaIcone.XRadius        := 15;
end;

procedure TfmxEscolheTintaNovo.AjustaLogoLista(TintaIcone: TRectangle);
begin
  TintaIcone.Width          := 75;
  TintaIcone.Height         := 75;
  TintaIcone.Position.Y     := 25;
  TintaIcone.Opacity        := 0.4;
  TintaIcone.Margins.Top    := 25;
  TintaIcone.Margins.Bottom := 25;
  TintaIcone.YRadius        := 9;
  TintaIcone.XRadius        := 9;
end;

procedure TfmxEscolheTintaNovo.AjustaLogoTransparente(TintaIcone: TRectangle);
begin
  TintaIcone.Width          := 75;
  TintaIcone.Height         := 75;
  TintaIcone.Position.Y     := 25;
  TintaIcone.Opacity        := 0;
  TintaIcone.Margins.Top    := 25;
  TintaIcone.Margins.Bottom := 25;
  TintaIcone.YRadius        := 9;
  TintaIcone.XRadius        := 9;
end;

procedure TfmxEscolheTintaNovo.Timer1Timer(Sender: TObject);
begin
  If Not edtPesquisa.IsFocused Then
    edtPesquisa.SetFocus;
end;

procedure TfmxEscolheTintaNovo.tmrForceCloseTimer(Sender: TObject);
Var
  LContador: Integer;
begin
  for LContador := 0 to Self.ComponentCount - 1 do
    if Self.Components[LContador] is TFmxObject then
      StopAllAnimations(TFmxObject(Self.Components[LContador]));
  Self.Close;
end;

procedure TfmxEscolheTintaNovo.TrackBar1Change(Sender: TObject);
begin
  lblTintaEscolhida.Text := AnsiReplaceStr(GetNomeTinta(lstTintas[Round(TrackBar1.Value - 1)]), '_', ' ');
  If MoverIcones Then
    GiraLista(DirecaoTrackBar);
end;

end.
