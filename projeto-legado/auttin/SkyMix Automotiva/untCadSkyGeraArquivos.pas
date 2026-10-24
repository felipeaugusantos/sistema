unit untCadSkyGeraArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Gauges, StdCtrls, AppEvnts, Menus, Buttons, ExtCtrls,
  CheckLst, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadSkyGeraArquivos = class(TfrmPai)
    memSaida: TMemo;
    Gauge1: TGauge;
    pnlCabecalho: TPanel;
    rgOpcoes: TRadioGroup;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
  private
    procedure pRegistraAcao(strAcao: String);
    procedure pRegistrProgresso(intInicio, intAtual, intFim: Integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadSkyGeraArquivos: TfrmCadSkyGeraArquivos;

implementation

uses untSkyMixAutomotivaDinamica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadSkyGeraArquivos.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    skymixAutomotivaDinamica: TSkyMixAutomotivaDinamica;
begin
  btnConfirmaGeracao.Enabled := False;
  skymixAutomotivaDinamica := TSkyMixAutomotivaDinamica.Create(Self, rgOpcoes.ItemIndex + 1);
  skymixAutomotivaDinamica.RegistraAcao := pRegistraAcao;
  skymixAutomotivaDinamica.RegistraProgresso := pRegistrProgresso;
  If skymixAutomotivaDinamica.fImportaArquivos Then
    fMensagem('', 'Os arquivos foram gerados com sucesso!', ['OK']);
end;

procedure TfrmCadSkyGeraArquivos.pRegistraAcao(strAcao: String);
begin
  memSaida.Lines.Add(DateTimeToStr(fNow()) + ' - ' + strAcao);
  Application.ProcessMessages;
end;

procedure TfrmCadSkyGeraArquivos.pRegistrProgresso(intInicio, intAtual,
  intFim: Integer);
begin
  Gauge1.MaxValue := intFim;
  Gauge1.MinValue := intInicio;
  Gauge1.Progress := intAtual;
  pnlInfo.Caption := Format('Processando... (%d / %d)', [intAtual, intFim]);
  Application.ProcessMessages;
end;

procedure TfrmCadSkyGeraArquivos.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
  If (rgOpcoes.ContainsControl(FindControl(Msg.hwnd))) then
  Begin
    If (Msg.message = WM_KEYFIRST) And (Msg.wParam = 27) Then
      btnSair.Click;
    If (Msg.message = WM_KEYFIRST) And (Msg.wParam = 13) Then
      btnConfirmaGeracao.Click;
  End;
end;

end.
