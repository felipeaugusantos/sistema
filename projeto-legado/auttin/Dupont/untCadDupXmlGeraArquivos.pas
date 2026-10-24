unit untCadDupXmlGeraArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Gauges, AppEvnts, Menus, Buttons, ExtCtrls,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadDupXmlGeraArquivos = class(TfrmPai)
    pnlFundo: TPanel;
    Gauge1: TGauge;
    pnlCabecalho: TPanel;
    memSaida: TMemo;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    procedure pRegistraAcao(strAcao: String);
    procedure pRegistraProgresso(intInicio, intAtual, intFinal: Integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadDupXmlGeraArquivos: TfrmCadDupXmlGeraArquivos;

implementation

uses untDupont, StdConvs, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadDupXmlGeraArquivos.btnConfirmaGeracaoClick(
  Sender: TObject);
  Var
    dupont: TDuponAutomotiva;
begin
  dupont := TDuponAutomotiva.Create(Self);
  dupont.RegistraAcao := pRegistraAcao;
  dupont.RegistraProgresso := pRegistraProgresso;

  If dupont.fGravaArquivos Then
    fMensagem('', 'Cadastros realizados com sucesso!', ['OK']);

  FreeAndNil(dupont);
end;

procedure TfrmCadDupXmlGeraArquivos.pRegistraAcao(strAcao: String);
begin
  memSaida.Lines.Add(DateTimeToStr(fNow()) + ' - ' + strAcao);
  Application.ProcessMessages;
end;

procedure TfrmCadDupXmlGeraArquivos.pRegistraProgresso(intInicio, intAtual,
  intFinal: Integer);
begin
  Gauge1.MaxValue := intFinal;
  Gauge1.MinValue := intInicio;
  Gauge1.Progress := intAtual;
  pnlInfo.Caption := Format('Processando arquivo (%d/%d)', [intAtual, intFinal]);
  Application.ProcessMessages;
end;

end.
