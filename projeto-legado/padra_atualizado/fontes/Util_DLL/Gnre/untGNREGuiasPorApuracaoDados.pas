unit untGNREGuiasPorApuracaoDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.DateUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, EditFocus;

type
  TfrmGNREGuiasPorApuracaoDados = class(TfrmPai)
    Label2: TLabel;
    mskDtaVen: TMaskEditFocus;
    mskDtaPag: TMaskEditFocus;
    Label3: TLabel;
    btnConfirma: TBitBtnLocked;
    Label168: TLabel;
    edtEstado: TEditFocus;
    Label1: TLabel;
    edtTipRec: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    FDtaVen: TDateTime;
    FDtaPag: TDateTime;
    { Public declarations }
  end;

var
  frmGNREGuiasPorApuracaoDados: TfrmGNREGuiasPorApuracaoDados;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmGNREGuiasPorApuracaoDados.btnConfirmaClick(Sender: TObject);
begin

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

  inherited;
  ModalResult := mrOk;

end;

procedure TfrmGNREGuiasPorApuracaoDados.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
  Begin
    Key := 0;
    btnSair.Click;
  End;
end;

end.
