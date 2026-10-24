unit untGNREGuiasPorApuracaoDatas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.DateUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxDropDownEdit, cxTextEdit, cxMaskEdit, cxImageComboBox;

type
  TfrmGNREGuiasPorApuracaoDatas = class(TfrmPai)
    Label2: TLabel;
    mskDtaVen: TMaskEditFocus;
    Label3: TLabel;
    mskDtaPag: TMaskEditFocus;
    btnConfirma: TBitBtnLocked;
    Label1: TLabel;
    icbMes: TcxImageComboBox;
    cbxAno: TcxComboBox;
    procedure btnConfirmaClick(Sender: TObject);
    procedure icbMesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbxAnoPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    FMesGnr: String;
    FAnoGnr: String;
    FDtaIni: TDateTime;
    FDtaFin: TDateTime;
    FDtaVen: TDateTime;
    FDtaPag: TDateTime;
    { Public declarations }
  end;

var
  frmGNREGuiasPorApuracaoDatas: TfrmGNREGuiasPorApuracaoDatas;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmGNREGuiasPorApuracaoDatas.cbxAnoPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If fEmptyStr(DisplayValue) Then
    DisplayValue := '2024';
end;

procedure TfrmGNREGuiasPorApuracaoDatas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
  Begin
    Key := 0;
    btnSair.Click;
  End;
end;

procedure TfrmGNREGuiasPorApuracaoDatas.FormShow(Sender: TObject);
begin
  inherited;
  cbxAno.Text := IntToStr(YearOf(VS_Date));
end;

procedure TfrmGNREGuiasPorApuracaoDatas.icbMesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN then
    keybd_event(Vk_Tab,0, 0, 0);
end;

procedure TfrmGNREGuiasPorApuracaoDatas.btnConfirmaClick(Sender: TObject);
begin
  If fEmptyStr(VarToStr(icbMes.EditValue)) Then
  Begin
    pMensagemOk('Informe um mês válido!');
    Exit;
  End;

  If fEmptyStr(VarToStr(cbxAno.EditValue)) Then
  Begin
    pMensagemOk('Informe um ano válido!');
    Exit;
  End;

  If not TryStrToDate(mskDtaVen.Text, FDtaVen) Then
  Begin
    pMensagemOk('Data de vencimento inválida!');
    Exit;
  End;

  If (YearsBetween(VS_Date, FDtaVen) > 2) Then
  Begin
    pMensagemOk('Data de vencimento inválida!');
    Exit;
  End;

  If (MonthsBetween(VS_Date, FDtaVen) > 12) Then
  Begin
    pMensagemOk('Data de vencimento superior a 12 meses!');
    Exit;
  End;

  If not TryStrToDate(mskDtaPag.Text, FDtaPag) Then
  Begin
    pMensagemOk('Data de pagamento inválida!');
    Exit;
  End;

  If (FDtaPag < VS_Date) Then
  Begin
    pMensagemOk('Data de pagamento menor que a data de hoje!');
    Exit;
  End;

  If (FDtaPag < FDtaVen) Then
  Begin
    pMensagemOk('Data de pagamento menor que a data de vencimento!');
    Exit;
  End;

  FMesGnr := UpperCase(icbMes.Text);
  FAnoGnr := cbxAno.Text;

  TryStrToDate('01/'+VarToStr(icbMes.EditValue)+'/'+VarToStr(cbxAno.EditValue), FDtaIni);
  FDtaFin := EndOfTheMonth(FDtaIni);

  inherited;
  ModalResult := mrOk;
end;

end.
