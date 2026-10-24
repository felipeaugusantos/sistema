unit untFatVendasPigmentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untFuncoesSimples;

type
  TfrmFatVendasPigmentos = class(TfrmPai)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtQuantidade: TEdit;
    edtFatorTintometrico: TEdit;
    edtQuantidadeTotal: TEdit;
    btnCopiarParaVendas: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure btnCopiarParaVendasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fltFatorTintometrico : Double;
    fltQuantidade        : Double;

    function fCalcularQuantidadeTotal : Double;
  public
    { Public declarations }
    blnConfirma : Boolean;
    procedure pCarregarInformacoesPigmentos(const AFatorTintometrico : Double; const AQuantidade: Double);
    function RetornarQuantidadeCalculada : Double;
  end;

implementation

{$R *.dfm}

procedure TfrmFatVendasPigmentos.btnCopiarParaVendasClick(Sender: TObject);
begin
  inherited;
  blnConfirma := true;
  Self.Close;
end;

procedure TfrmFatVendasPigmentos.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  Self.fltQuantidade :=  StrToFloatDef(edtQuantidade.Text, 0);
  edtQuantidadeTotal.Text := FloatToStrF(fCalcularQuantidadeTotal, ffFixed, 12, fCfgSis('DECQTD', varInteger));
end;

function TfrmFatVendasPigmentos.fCalcularQuantidadeTotal: Double;
begin
  Try
    Result := (Self.fltQuantidade / Self.fltFatorTintometrico);
  Except
    Result := 0;
  End;
end;

procedure TfrmFatVendasPigmentos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmFatVendasPigmentos.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := false;
  edtQuantidade.Text        :=  FloatToStrF(Self.fltQuantidade, ffFixed, 12, fCfgSis('DECQTD', varInteger));
  edtFatorTintometrico.Text :=  FloatToStrF(Self.fltFatorTintometrico, ffFixed, 12, fCfgSis('DECQTD', varInteger));
  edtQuantidadeTotal.Text   :=  FloatToStrF(fCalcularQuantidadeTotal, ffFixed, 12, fCfgSis('DECQTD', varInteger));
end;

procedure TfrmFatVendasPigmentos.pCarregarInformacoesPigmentos(
  const AFatorTintometrico: Double; const AQuantidade: Double);
begin
  Self.fltFatorTintometrico := AFatorTintometrico;
  Self.fltQuantidade        := AQuantidade;
end;

function TfrmFatVendasPigmentos.RetornarQuantidadeCalculada: Double;
begin
  Result := fCalcularQuantidadeTotal;
end;

end.
