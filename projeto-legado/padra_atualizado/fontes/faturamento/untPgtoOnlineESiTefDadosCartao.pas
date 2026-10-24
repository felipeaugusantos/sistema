unit untPgtoOnlineESiTefDadosCartao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus;

type
  TFrmPgtoOnlineESiTefDadosCartao = class(TfrmPaiConfirma)
    Label1: TLabel;
    Label2: TLabel;
    edtNumCar: TMaskEditFocus;
    edtVenCar: TMaskEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FblnConfirma: Boolean ;
    function fSomenteNumero(const AstrValor: String): String ;
    function fValidaNumeroCartao(const AstrNumero: String): Boolean ;
    function fValidaValidadeCartao(const AstrMesAno: String): Boolean ;
  public
    { Public declarations }
    property Confirma: Boolean read FblnConfirma ;
  end;

implementation

uses untFuncoesSimples, DateUtils ;

{$R *.dfm}

procedure TFrmPgtoOnlineESiTefDadosCartao.btnConfirmaClick(Sender: TObject);
begin
  if not fValidaNumeroCartao(edtNumCar.Text) then
  begin
    pSetFocus(edtNumCar);
    exit ;
  end ;

  if not fValidaValidadeCartao(edtVenCar.Text) then
  begin
    pSetFocus(edtVenCar);
    exit ;
  end ;

  FblnConfirma := True ;

  close ;

end;

procedure TFrmPgtoOnlineESiTefDadosCartao.FormCreate(Sender: TObject);
begin
  inherited;
  FblnConfirma := False ;
end;

function TFrmPgtoOnlineESiTefDadosCartao.fSomenteNumero(
  const AstrValor: String): String;
var
  LchrDig: char ;
begin
  result := '' ;
  for LchrDig in AstrValor do
  begin
    if CharInSet(LchrDig, ['0'..'9']) then
      result := result + LchrDig ;
  end ;
end;

function TFrmPgtoOnlineESiTefDadosCartao.fValidaNumeroCartao(
  const AstrNumero: String): Boolean;
begin
  Result := False ;

  if fEmptyStr(trim(AstrNumero)) then
  begin
    fMensagem('ATENÇÃO!', 'Número cartão inválido!', ['&Ok']);
    exit ;
  end ;

  if Length(fSomenteNumero(AstrNumero)) < 16 then
  begin
    fMensagem('ATENÇÃO!', 'Número cartão deve ter 16 digitos!', ['&Ok']);
    exit ;
  end ;

  Result := True ;
end;

function TFrmPgtoOnlineESiTefDadosCartao.fValidaValidadeCartao(
  const AstrMesAno: String): Boolean;
var
  LstrMes, LstrAno: String ;
  LstrAnoMes: String ;
begin
  Result := False ;

  LstrAnoMes := fSomenteNumero(AstrMesAno) ;
  if Length(LstrAnoMes) < 4 then
  begin
    fMensagem('ATENÇÃO!', 'Vencimento cartão inválido!', ['&Ok']);
    exit ;
  end ;
  LstrMes := copy(LstrAnoMes, 1, 2) ;
  LstrAno := copy(LstrAnoMes, 3, 2) ;

  if strtoint(LstrMes) > 12 then
  begin
    fMensagem('ATENÇÃO!', 'Mês informado é inválido!'+#13+'Informar entre [01-12]', ['&Ok']);
    exit ;
  end ;

  if strtoint(LstrAno) < (YearOf(VS_Date)-2000) then
  begin
    fMensagem('ATENÇÃO!', 'Ano informado é inválido!', ['&Ok']);
    exit ;
  end ;

  Result := True ;
end;

end.
