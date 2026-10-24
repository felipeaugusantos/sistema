unit untCfgPais;

interface

uses
  Windows, Classes, Controls, Forms, untPaiConfirma, ExtCtrls, StdCtrls, AppEvnts,
  Menus, Buttons, BitBtnLockedIncrem, Graphics, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCfgPais = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Label3: TLabel;
    lblPaiSel: TLabel;
    GroupBox1: TGroupBox;
    imgBrasil: TImage;
    imgParagu: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure imgBrasilClick(Sender: TObject);
    procedure imgParaguClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    blnConfirma: Boolean;
    strSigPai  : String;
  end;

var
  frmCfgPais: TfrmCfgPais;

implementation

{$R *.dfm}

procedure TfrmCfgPais.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
end;

procedure TfrmCfgPais.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  strSigPai   := '';
end;

procedure TfrmCfgPais.FormShow(Sender: TObject);
begin
  inherited;
  If (strSigPai = 'PAR') Then
  Begin
    lblPaiSel.Caption := 'Paraguai';
  End
  Else
  Begin
    lblPaiSel.Caption := 'Brasil';
  End;
end;

procedure TfrmCfgPais.imgBrasilClick(Sender: TObject);
begin
  inherited;
  lblPaiSel.Caption := 'Brasil';
  strSigPai         := 'BRA';
end;

procedure TfrmCfgPais.imgParaguClick(Sender: TObject);
begin
  inherited;
  lblPaiSel.Caption := 'Paraguai';
  strSigPai         := 'PAR';
end;

end.
