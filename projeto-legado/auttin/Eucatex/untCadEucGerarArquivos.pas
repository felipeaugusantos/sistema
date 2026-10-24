unit untCadEucGerarArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Gauges,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadEucGerarArquivos = class(TfrmPai)
    pnlFundo: TPanel;
    Gauge1: TGauge;
    pnlCabecalho: TPanel;
    memSaida: TMemo;
    rdgOpcao: TRadioGroup;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
  private
    procedure pRegistraAcao(strAcao: String);
    procedure pRegistraProgresso(intInicio, intAtual, intFinal: Integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadEucGerarArquivos: TfrmCadEucGerarArquivos;

implementation

uses untEucatexImobiliariaDinamica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadEucGerarArquivos.btnConfirmaGeracaoClick(Sender: TObject);
  var
    eucatexImobiliariaDinamica: TEucatexImobiliariaDinamica;
begin
  btnConfirmaGeracao.Enabled := False;

  eucatexImobiliariaDinamica := TEucatexImobiliariaDinamica.Create(Self, rdgOpcao.ItemIndex + 1);
  eucatexImobiliariaDinamica.RegistraAcao := pRegistraAcao;
  eucatexImobiliariaDinamica.RegistraProgresso := pRegistraProgresso;

  If (eucatexImobiliariaDinamica.fProcessaArquivos) Then
    fMensagem('', 'Os arquivos foram processados com sucesso!', ['OK']);
  FreeAndNil(eucatexImobiliariaDinamica);


end;

procedure TfrmCadEucGerarArquivos.pRegistraAcao(strAcao: String);
begin
  memSaida.Lines.Add(DateTimeToStr(fNow()) + ' - ' + strAcao);
  Application.ProcessMessages;
end;

procedure TfrmCadEucGerarArquivos.pRegistraProgresso(intInicio, intAtual,
  intFinal: Integer);
begin
  Gauge1.MaxValue := intFinal;
  Gauge1.MinValue := intInicio;
  Gauge1.Progress := intAtual;
  pnlInfo.Caption := Format('Processando arquivo (%d/%d)', [intAtual, intFinal]);
  Application.ProcessMessages;
end;

procedure TfrmCadEucGerarArquivos.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(rdgOpcao.Buttons[0]);
end;

procedure TfrmCadEucGerarArquivos.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
  If (rdgOpcao.ContainsControl(FindControl(Msg.hwnd))) then
  Begin
    If (Msg.message = WM_KEYFIRST) And (Msg.wParam = 27) Then
      btnSair.Click;
    If (Msg.message = WM_KEYFIRST) And (Msg.wParam = 13) Then
      btnConfirmaGeracao.Click;
  End;
end;

end.

