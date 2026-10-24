unit untCadReiGeraArquivoD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Gauges,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadReiGerarArquivosD = class(TfrmPai)
    pnlFundo: TPanel;
    Gauge1: TGauge;
    pnlCabecalho: TPanel;
    memSaida: TMemo;
    btnConfirmaGeracao: TBitBtnLocked;
    grbTipos: TGroupBox;
    rdbBases: TRadioButton;
    rdbTintas: TRadioButton;
    rdbColorantes: TRadioButton;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pRegistraAcao(strAcao: String);
    procedure pRegistraProgresso(intInicio, intAtual, intFinal: Integer);
  public
    { Public declarations }
  end;

var
  frmCadReiGerarArquivosD: TfrmCadReiGerarArquivosD;

implementation

uses untRennerImobiliariaDinamica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadReiGerarArquivosD.btnConfirmaGeracaoClick(
  Sender: TObject);
  function fIntOpcao: Integer;
  Begin
  	Result := 0;
    If rdbBases.Checked Then
      Result := 0
    Else If rdbTintas.Checked Then
      Result := 1
    Else If rdbColorantes.Checked Then
      Result := 2;
  End;
  Var
    tinta: TRennerImobiliariaDinamica;
begin
  tinta := TRennerImobiliariaDinamica.Create(Self);
  tinta.RegistraAcao := pRegistraAcao;
  tinta.RegistraProgresso := pRegistraProgresso;

  If tinta.fProcessaArquivos(fIntOpcao) Then
    fMensagem('', 'Tintas cadastradas com sucesso!', ['OK']);

  FreeAndNil(tinta);
end;

procedure TfrmCadReiGerarArquivosD.FormShow(Sender: TObject);
begin
  inherited;
  rdbBases.Checked := True;
end;

procedure TfrmCadReiGerarArquivosD.pRegistraAcao(strAcao: String);
begin
  memSaida.Lines.Add(DateTimeToStr(fNow()) + ' - ' + strAcao);
  Application.ProcessMessages;
end;

procedure TfrmCadReiGerarArquivosD.pRegistraProgresso(intInicio, intAtual,
  intFinal: Integer);
begin
  Gauge1.MaxValue := intFinal;
  Gauge1.MinValue := intInicio;
  Gauge1.Progress := intAtual;
  pnlInfo.Caption := Format('Processando... %d / %d', [intAtual, intFinal]);
  Application.ProcessMessages;
end;

end.
