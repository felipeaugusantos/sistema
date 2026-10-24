unit untLegenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, System.Generics.Collections, untFuncoesSimples;

type
  TLegenda = TDictionary<String, Integer>;

  TfrmLegenda = class(TForm)
    pnlBotoes: TPanel;
    btnSair: TBitBtnLocked;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  const
    INCREM = 20;
    MARGEM = 24;
  private
    FTop: Integer;
    FWidth: Integer;
  public
    procedure pAddLegenda(strTexto: String; idxCor: Integer);
  end;

procedure pShowLegenda(Owner: TComponent = Nil; dctLegenda: TLegenda = Nil);

implementation

procedure pShowLegenda(Owner: TComponent = Nil; dctLegenda: TLegenda = Nil);
  Var
    frmLegenda: TFrmLegenda;
    strKey: String;
begin
  If Not Assigned(dctLegenda) Then
    Exit;

  frmLegenda := TFrmLegenda.Create(Owner);
  Try
    for strKey in dctLegenda.Keys do
      frmLegenda.pAddLegenda(strKey, dctLegenda.Items[strKey]);

    frmLegenda.ShowModal;
  Finally
    FreeAndNil(frmLegenda);
  End;
end;

{$R *.dfm}

procedure TfrmLegenda.btnSairClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmLegenda.FormCreate(Sender: TObject);
begin
  inherited;
  FTop := 5;

  pCriarModuloLegenda;
end;

procedure TfrmLegenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Escape Then
    Close;
end;

procedure TfrmLegenda.FormShow(Sender: TObject);
begin
  inherited;
  Self.ClientHeight := FTop + pnlBotoes.Height + 15;
  Self.ClientWidth  := FWidth;
end;

procedure TfrmLegenda.pAddLegenda(strTexto: String; idxCor: Integer);
  Var
    intWidth: Integer;
begin
  With TImage.Create(Self) Do
  Begin
    Parent      := Self;
    Left        := 4;
    Top         := FTop;
    Transparent := True;
    Width       := frmModuloLegenda.imglLegenda.Width;
    Height      := frmModuloLegenda.imglLegenda.Height;
    frmModuloLegenda.imglLegenda.GetBitmap(idxCor, Picture.Bitmap);
  End;

  With TLabel.Create(Self) Do
  Begin
    Parent  := Self;
    Left    := MARGEM;
    Top     := FTop + 2;
    Caption := strTexto;
    Visible := True;
  End;

  Inc(FTop, INCREM);

  intWidth := MARGEM + Self.Canvas.TextWidth(strTexto) + MARGEM;

  If intWidth > FWidth Then
    FWidth := intWidth;
end;

end.
