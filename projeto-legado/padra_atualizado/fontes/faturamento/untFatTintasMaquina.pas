unit untFatTintasMaquina;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls, AppEvnts,
  BitBtnLockedIncrem;

type
  TfrmFatTintasMaquina = class(TfrmPai)
    Panel1: TPanel;
    btnConfirma: TBitBtn;
    pnlLista: TPanel;
    trvTintas: TTreeView;
    pnlImagem: TPanel;
    imgTinta: TImage;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure trvTintasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure trvTintasChange(Sender: TObject; Node: TTreeNode);
    procedure trvTintasDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregaImagem(intIndice: Integer);
  public
    { Public declarations }
    lstTintas: TStringList;
    strIdePro: String;
  end;

var
  frmFatTintasMaquina: TfrmFatTintasMaquina;

implementation

uses untfuncoesSimples;

{$R *.dfm}

procedure TfrmFatTintasMaquina.FormShow(Sender: TObject);
  Var
    intContador: Integer;
    intLetra: Byte;
begin
  inherited;
  intLetra  := 65;
  strIdePro := 'NOR';
  For intContador := 0 To lstTintas.Count -1 Do
  Begin
    trvTintas.Items.AddChild(Nil, Chr(intLetra) + ' - ' + lstTintas[intContador]);
    Inc(intLetra);
  End;
  trvTintas.Selected := trvTintas.Items[0];
end;

procedure TfrmFatTintasMaquina.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  strIdePro := fRetornaSiglaTinta(lstTintas[trvTintas.Selected.AbsoluteIndex]);
  Close;
end;

procedure TfrmFatTintasMaquina.trvTintasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End;
end;

procedure TfrmFatTintasMaquina.trvTintasChange(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
  pCarregaImagem(Node.AbsoluteIndex);
end;

procedure TfrmFatTintasMaquina.pCarregaImagem(intIndice: Integer);
  Var
    strNomArq: String;
begin

  strNomArq := ExtractFilePath(Application.ExeName) + '\auttin\' + lstTintas[intIndice] + '.jpg';
  If (Not FileExists(strNomArq)) Then
  Begin
    imgTinta.Picture := Nil;
    Exit;
  End;

  imgTinta.Picture.LoadFromFile(strNomArq);

end;

procedure TfrmFatTintasMaquina.trvTintasDblClick(Sender: TObject);
begin
  inherited;
  btnConfirma.Click;
end;

end.

