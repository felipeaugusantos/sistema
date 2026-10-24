unit untDigDataHoraSWBasico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls, EditFocus, cxTextEdit, cxMemo, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmDigDataHoraSWBasico = class(TfrmPai)
    cxMemo1: TcxMemo;
    pnlDados: TPanel;
    btnImprimir: TBitBtnLocked;
    edtDataHora: TEditFocus;
    btnGravar: TBitBtnLocked;
    Label1: TLabel;
    procedure btnImprimirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    pProcedureLMF: TNotifyEvent;
  end;

var
  frmDigDataHoraSWBasico: TfrmDigDataHoraSWBasico;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmDigDataHoraSWBasico.btnGravarClick(Sender: TObject);
  Var
    stlValores: TStringList;
begin
  inherited;
  If fEmptyStr(edtDataHora.Text) Then
  Begin
    pMensagemOk('É necessário o preenchimento da data e hora.');
    Exit;
  End;

  stlValores := TStringList.Create;
  Try
    ExtractStrings([' '], [], PChar(edtDataHora.Text), stlValores);

    If stlValores.Count < 2 Then
    Begin
      pMensagemOk('Formato informado inválido. Por favor revise de acordo com o formato especificado: DD/MM/AAAA HH:MM:SS.');
      Exit;
    End;

    If StrToDateDef(stlValores[0], -1) = -1 Then
    Begin
      pMensagemOk('Data informada inválida');
      Exit;
    End;

    If StrToTimeDef(stlValores[1], -1) = -1 Then
    Begin
      pMensagemOk('Hora informada inválida');
      Exit;
    End;

    If FormatDateTime('dd/mm/yyyy', StrToDate(stlValores[0])) <> stlValores[0] Then
    Begin
      pMensagemOk('Formato da data informada inválido. Por favor revise com o formato especificado: DD/MM/AAAA HH:MM:SS.');
      Exit;
    End;

    If FormatDateTime('hh:nn:ss', StrToTime(stlValores[1])) <> stlValores[1] Then
    Begin
      pMensagemOk('Formato da hora informada inválido. Por favor revise com o formato especificado: DD/MM/AAAA HH:MM:SS.');
      Exit;
    End;

    If fMensagem('', 'Confirma valores?', ['&Sim', '&Não']) = 1 Then
    Begin
      ModalResult := mrOk;
    End;
  Finally
    FreeAndNil(stlValores);
  End;
  FreeAndNil(stlValores);
end;

procedure TfrmDigDataHoraSWBasico.btnImprimirClick(Sender: TObject);
begin
  inherited;
  btnImprimir.Caption := 'Aguarde....';
  btnImprimir.Enabled := False;
  Application.ProcessMessages;

  pProcedureLMF(Self);
  pSetFocus(edtDataHora);

  btnImprimir.Caption := '&Imprimir LMF';
  btnImprimir.Enabled := True;
  Application.ProcessMessages;
end;

procedure TfrmDigDataHoraSWBasico.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDataHora);
end;

end.
