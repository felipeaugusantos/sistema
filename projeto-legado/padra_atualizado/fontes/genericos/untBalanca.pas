unit untBalanca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem;

type
  TfrmBalanca = class(TfrmPai)
    pnlRodape: TPanel;
    lblInf1: TLabel;
    lblInf2: TLabel;
    lblInf3: TLabel;
    edtInf1: TStaticText;
    edtInf2: TStaticText;
    edtInf3: TStaticText;
    btnConfirma: TBitBtnLocked;
    BitBtnLocked1: TBitBtnLocked;
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    fltPesoBruto,
    fltPesoLiquido,
    fltTara: Double;
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untMontagemCaixas, untFuncoesSimples;

procedure TfrmBalanca.BitBtnLocked1Click(Sender: TObject);
var FLePeso: TLePesoBalanca;
begin
  fltTara        := 0;
  fltPesoBruto   := 0;
  fltPesoLiquido := 0;

  Try
    FLePeso := TLePesoBalanca.Create;

    If FLePeso.fConectado Then
    Begin
      fltTara        := FLePeso.fltTara;
      fltPesoBruto   := FLePeso.fltPesoBruto;
      fltPesoLiquido := FLePeso.fltPesoLiquido;
    End;
  Finally
    FreeAndNil(FLePeso);
    edtInf1.Caption := FloatToStr( fltPesoBruto );
    edtInf2.Caption := FloatToStr( fltPesoLiquido );
    edtInf3.Caption := FloatToStr( fltTara );
  End;

end;

procedure TfrmBalanca.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (fltPesoBruto = 0) Or (fltPesoLiquido = 0) Then
  Begin
    pMensagemOK('Efetue a pesagem antes de confirmar!');
  End
  Else
  Begin
    Close;
    ModalResult := mrOk;
  End;

end;

procedure TfrmBalanca.FormCreate(Sender: TObject);
begin
  inherited;
  fltTara        := 0;
  fltPesoBruto   := 0;
  fltPesoLiquido := 0;
end;

end.
