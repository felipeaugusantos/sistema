unit untDigitaCodigoBarras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, DirectoryEditFocus,
  strUtils, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, EditFocus;

type
  TfrmDigitaCodigoBarras = class(TfrmPai)
    pnlCabecalho: TPanel;
    btnConfirmar: TBitBtnLocked;
    lblCodBar: TLabel;
    edtCodBar: TEditFocus;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FCodBar: String;
    FConfirmou: Boolean;
  public
    { Public declarations }
    function GetCodBar: String;
    function GetConfirmou: Boolean;
  end;

var
  frmDigitaCodigoBarras: TfrmDigitaCodigoBarras;

implementation

uses untfuncoesSimples;

{$R *.dfm}

procedure TfrmDigitaCodigoBarras.btnConfirmarClick(Sender: TObject);
Begin
  inherited;
  If fEmptyStr(edtCodBar.Text) Then
  Begin
    fMensagem('ATENÇÃO!','Favor digitar um código de barras.',['&O K']);
    pSetFocus(edtCodBar);
    Exit;
  End;

  FCodBar := edtCodBar.Text;
  FConfirmou := True;
  Close;
End;

procedure TfrmDigitaCodigoBarras.FormCreate(Sender: TObject);
begin
  inherited;
  FCodBar := '';
  FConfirmou := False;
end;

procedure TfrmDigitaCodigoBarras.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodBar);
end;

function TfrmDigitaCodigoBarras.GetCodBar: String;
begin
  Result := FCodBar;
end;

function TfrmDigitaCodigoBarras.GetConfirmou: Boolean;
begin
  Result := FConfirmou;
end;

end.

