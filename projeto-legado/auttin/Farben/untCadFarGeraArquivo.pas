unit untCadFarGeraArquivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  untFarbenAutomotiva, DB, UniClientDataSet, UniDataSetProvider, BitBtnLockedIncrem,
  Vcl.Samples.Gauges, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadFarGeraArquivo = class(TfrmPai)
    pnlCabecalho: TPanel;
    memSaida: TMemo;
    GroupBox1: TGroupBox;
    chkBases: TRadioButton;
    chkTintas: TRadioButton;
    btnConfirmaGeracao: TBitBtnLocked;
    Gauge1: TGauge;
    Panel1: TPanel;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseProcesso(Sender: TObject; var Action: TCloseAction);

  private
    farbenAutomotiva : TFarbenAutomotiva;
    { Private declarations }
  public
    { Public declarations }
    procedure pRegistraAcao(strAcao: String);
    procedure pRegistraProgresso(intInicio, intAtual, intFinal: Integer);
  end;

var
  frmCadFarGeraArquivo: TfrmCadFarGeraArquivo;

implementation

uses Math, untFuncoesSimples, untModulo;

{$R *.dfm}

procedure TfrmCadFarGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
begin
  inherited;
  farbenAutomotiva := TFarbenAutomotiva.Create;

  farbenAutomotiva.CancelarProcesso := false;

  fStartTransaction;

  GroupBox1.Enabled          := false;
  btnConfirmaGeracao.Enabled := false;


  farbenAutomotiva.RegistraAcao      := pRegistraAcao;
  farbenAutomotiva.RegistraProgresso := pRegistraProgresso;

  If farbenAutomotiva.fProcessarArquivoFdb(chkBases.Checked) Then
  Begin
    fMensagem('', 'O arquivo foi processado com sucesso!', ['&OK']);

    GroupBox1.Enabled          := true;
    btnConfirmaGeracao.Enabled := true;

  End;

  Gauge1.Progress := 0;
  memSaida.Clear;
  pRegistraProgresso(0,0,0);

  blnFecharFormPai   := false;
  blnFecharComEscape := false;

  FreeAndNil(farbenAutomotiva);
end;


procedure TfrmCadFarGeraArquivo.btnSairClick(Sender: TObject);
begin
  try
    if Assigned(farbenAutomotiva) then
      farbenAutomotiva.CancelarProcesso := true;
  finally
    Self.Close;
  end;
end;

procedure TfrmCadFarGeraArquivo.FormClose(Sender: TObject; var Action: TCloseAction);
var
  strTipo : String;
begin

  if Assigned(farbenAutomotiva) then
    farbenAutomotiva.CancelarProcesso := true;

  if not(btnConfirmaGeracao.Enabled)then
  begin
    strTipo := IIF(chkBases.Checked, 'Bases (Matéria Prima)', 'Tintas' );

    fRollback;

    If fMensagem('ATENÇÃO!', 'Deseja cancelar o processo de geração das '+ strTipo+ ' ?', ['&Sim', '&Não']) <> 1 Then
    begin
      Action := CaNone;
      btnConfirmaGeracao.Click;
    end
    else
    begin
      Action             := CaFree;
      blnFecharFormPai   := true;
      blnFecharComEscape := true;
    end;

    if Assigned(farbenAutomotiva) then
      FreeAndNil(farbenAutomotiva);
  end
  else
    Action := CaFree;

  if (Action <> CaFree)then
    FormClose(Sender, Action);
end;

procedure TfrmCadFarGeraArquivo.FormCloseProcesso(Sender: TObject;var Action: TCloseAction);
begin
  FormClose(Sender, Action);
end;

procedure TfrmCadFarGeraArquivo.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnConfirmaGeracao);
end;

procedure TfrmCadFarGeraArquivo.pRegistraAcao(strAcao: String);
begin
  memSaida.Lines.Add(DateTimeToStr(fNow()) + ' - ' + strAcao);
  Application.ProcessMessages;
end;

procedure TfrmCadFarGeraArquivo.pRegistraProgresso(intInicio, intAtual,
  intFinal: Integer);
begin
  Gauge1.MaxValue := intFinal;
  Gauge1.MinValue := intInicio;
  Gauge1.Progress := intAtual;
  pnlInfo.Caption := Format('Processando... %d / %d', [intAtual, intFinal]);
  Application.ProcessMessages;

end;

end.

