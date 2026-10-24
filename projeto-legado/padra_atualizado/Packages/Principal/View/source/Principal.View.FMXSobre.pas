unit Principal.View.FMXSobre;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.TabControl,
  FMX.StdCtrls, System.Actions, FMX.ActnList, FMX.Effects, FMX.Filter.Effects,
  FMX.Layouts, FMX.Ani, FMX.ListBox, System.StrUtils;

type
  TfmxSobre = class(TForm)
    imgFoto: TImage;
    recFundo: TRectangle;
    estilos: TStyleBook;
    tabControl: TTabControl;
    tabInfo: TTabItem;
    tabTelefones: TTabItem;
    tabMails: TTabItem;
    btnInfo: TSpeedButton;
    btnMails: TSpeedButton;
    btnFones: TSpeedButton;
    layInfo: TLayout;
    layMails: TLayout;
    layTelefones: TLayout;
    memSobre: TMemo;
    imgLogo: TImage;
    lblVersao: TLabel;
    lblRevisao: TLabel;
    lblConexao: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    lblCidade1: TLabel;
    lblFone1: TLabel;
    lblCidade2: TLabel;
    lblFone2: TLabel;
    lblCidade3: TLabel;
    lblFone3: TLabel;
    lblCidade4: TLabel;
    lblFone4: TLabel;
    lblCidade5: TLabel;
    lblFone5: TLabel;
    lblCidade6: TLabel;
    lblFone6: TLabel;
    lblCidade7: TLabel;
    lblFone7: TLabel;
    lblCidade8: TLabel;
    lblFone8: TLabel;
    lstMail: TListBox;
    lstgrpDiretoria: TListBoxGroupHeader;
    lstDiretoria: TListBoxItem;
    lstgrpEquipes: TListBoxGroupHeader;
    lstEquipe1: TListBoxItem;
    lstEquipe2: TListBoxItem;
    lstEquipe3: TListBoxItem;
    lstEquipe4: TListBoxItem;
    lstEquipe5: TListBoxItem;
    lstEquipe6: TListBoxItem;
    lstgrpAtendimento: TListBoxGroupHeader;
    lstAtendimento: TListBoxItem;
    imgSetaEquipes: TImage;
    imgSetaAtendimento: TImage;
    imgSetaDiretoria: TImage;
    Line1: TLine;
    patMails: TPath;
    patInfo: TPath;
    patFones: TPath;
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure btnInfoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lstgrpDiretoriaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFonesMouseEnter(Sender: TObject);
    procedure btnFonesMouseLeave(Sender: TObject);
  private
    { Private declarations }
    btnTabAberto: TSpeedButton;

    procedure PintarPaths;
    procedure AbrirListBox(Sender: TObject);
    procedure FecharListBox(Sender: TObject);
    procedure AnimaListBoxItem(Sender: TObject; LItem: TListBoxItem);
    procedure AnimaListBoxHeader(Sender: TObject; LIndex: Integer; LImagemClicada:TImage);

  public
    { Public declarations }
  end;

var
  fmxSobre: TfmxSobre;

Const
  AzulClaro = TAlphaColor($FF00aae4);
  AzulEscuro = TAlphaColor($FF3b6887);
  CinzaEscuro = TAlphaColor($FFa8a8a8);

implementation


{$R *.fmx}

procedure TfmxSobre.btnFonesMouseEnter(Sender: TObject);
VAR
  LPath: TPath;
begin
  If (btnTabAberto <> TSpeedButton(Sender)) Then
  Begin
    LPath := TPath(FindComponent('pat' + Copy(TSpeedButton(Sender).Name,4,20)));
    LPath.Fill.Color := AzulClaro;
  End;
end;

procedure TfmxSobre.btnFonesMouseLeave(Sender: TObject);
VAR
  LPath: TPath;
begin
  If (btnTabAberto <> TSpeedButton(Sender)) Then
  Begin
    LPath := TPath(FindComponent('pat' + Copy(TSpeedButton(Sender).Name,4,20)));
    LPath.Fill.Color := CinzaEscuro;
  End;
end;

procedure TfmxSobre.btnInfoClick(Sender: TObject);
Var
  LPath: TPath;
  LTab: TTabItem;
begin
  btnTabAberto := TSpeedButton(Sender);
  PintarPaths;

  LPath := TPath(FindComponent('pat' + Copy(TSpeedButton(Sender).Name,4,30)));
  LPath.Fill.Color := AzulClaro;

  LTab := TTabItem(FindComponent('tab' + Copy(TSpeedButton(Sender).Hint,4,30)));
  tabControl.ActiveTab := LTab;
end;

procedure TfmxSobre.AbrirListBox(Sender: TObject);
Var
  LContador: Integer;
  LItem    : TListBoxItem;
  LImageClicada: TImage;
begin
  LImageClicada := TImage(FindComponent('imgSeta' + Copy(TListBoxGroupHeader(Sender).Name,7,60)));

  For LContador := 0 to Self.ComponentCount - 1 do
  Begin
    If Self.Components[LContador].ClassNameIs('TListBoxItem') Then
    begin
      LItem := TListBoxItem(Self.Components[LContador]);
      AnimaListBoxItem(Sender, LItem);
    End
    Else If Self.Components[LContador].ClassNameIs('TListBoxGroupHeader') Then
      AnimaListBoxHeader(Sender, LContador, LImageClicada);
  End;
end;

procedure TfmxSobre.AnimaListBoxHeader(Sender: TObject; LIndex: Integer; LImagemClicada:TImage);
Var
  LImageOutras: TImage;
begin
  If (TListBoxGroupHeader(Sender).Tag = Self.Components[LIndex].Tag) Then
    LImagemClicada.RotationAngle := 180
  Else
  Begin
    LImageOutras := TImage(FindComponent('imgSeta' + Copy(TListBoxGroupHeader(Self.Components[LIndex]).Name,7,60)));
    LImageOutras.RotationAngle := 0;
  End;
end;

procedure TfmxSobre.AnimaListBoxItem(Sender: TObject; LItem: TListBoxItem);
begin
  If (TListBoxGroupHeader(Sender).Tag = LItem.Tag) Then
    LItem.Height := 20
  Else
    LItem.Height := 0;
end;

procedure TfmxSobre.FecharListBox(Sender: TObject);
Var
  LContador: Integer;
  LItem    : TListBoxItem;
  LImageClicada: TImage;
begin
  LImageClicada := TImage(FindComponent('imgSeta' + Copy(TListBoxGroupHeader(Sender).Name,7,60)));
  LImageClicada.RotationAngle := 0;

  For LContador := 0 to Self.ComponentCount - 1 do
  Begin
    If (Self.Components[LContador].ClassNameIs('TListBoxItem')) And
       (TListBoxItem(Self.Components[LContador]).Tag = TListBoxItem(Sender).Tag) Then
    begin
      LItem := TListBoxItem(Self.Components[LContador]);
      LItem.Height := 0;
    End;
  End;
end;

procedure TfmxSobre.FormCreate(Sender: TObject);
Var
  LContador : Integer;
begin
  For LContador := 0 to Self.ComponentCount - 1 do
    If Self.Components[LContador].ClassNameIs('TListBoxItem') Then
      TListBoxItem(Self.Components[LContador]).Height := 0;
end;

procedure TfmxSobre.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
Begin
  Case Key Of
    vkEscape : Close;
  End;
end;

procedure TfmxSobre.FormShow(Sender: TObject);
begin
  tabControl.ActiveTab := tabTelefones;
  tabControl.ActiveTab := tabMails;
  tabControl.ActiveTab := tabInfo;
  patInfo.Fill.Color   := AzulClaro;
  btnTabAberto         := btnInfo;

  lstgrpDiretoriaClick(lstgrpEquipes);
end;

procedure TfmxSobre.lstgrpDiretoriaClick(Sender: TObject);
Var
  LImageClicada: TImage;
begin
  LImageClicada := TImage(FindComponent('imgSeta' + Copy(TListBoxGroupHeader(Sender).Name,7,60)));

  If (LImageClicada.RotationAngle = 0) Then
    AbrirListBox(Sender)
  Else
    FecharListBox(Sender);
end;

procedure TfmxSobre.PintarPaths;
Var
  LContador: Integer;
begin
  For LContador := 0 to Self.ComponentCount - 1 do
    If (Self.Components[LContador].ClassNameIs('TPath')) Then
      TPath(Self.Components[LContador]).Fill.Color := CinzaEscuro;
end;

end.
