unit untAlteracaoGlobalDescontoProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus;

type
  TfrmAlteracaoGlobalDescontoProdutos = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    lblQuantidade: TLabel;
    edtPercentualDesconto: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FPercentualDesconto : Double;
  public
    { Public declarations }
    property fltPercDesconto: Double read FPercentualDesconto;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmAlteracaoGlobalDescontoProdutos }

procedure TfrmAlteracaoGlobalDescontoProdutos.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  FPercentualDesconto := fStrToFloat(edtPercentualDesconto.Text);
  Self.Close;
end;

procedure TfrmAlteracaoGlobalDescontoProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  FPercentualDesconto := 0;
end;

procedure TfrmAlteracaoGlobalDescontoProdutos.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtPercentualDesconto);
end;

end.
