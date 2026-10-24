unit untCadAutGeraArquivo;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, AppEvnts, DB, Gauges, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadAutGeraArquivo = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    Gauge1: TGauge;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    chkBases: TRadioButton;
    chkTintas: TRadioButton;
    chkDilu: TRadioButton;
    btnConfirmaGeracao: TBitBtnLocked;
    btnSairGeracao: TBitBtnLocked;
    procedure btnSairGeracaoClick(Sender: TObject);
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    
    procedure pRegistraProgresso(intInicio, intAtual, intMaximo: Integer);
    procedure pRegistraAcao(strAcao: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadAutGeraArquivo: TfrmCadAutGeraArquivo;

implementation

uses untPai, untFuncoesSimples,
     untAutocolorDinamica;

{$R *.dfm}

procedure TfrmCadAutGeraArquivo.btnSairGeracaoClick(Sender: TObject);
begin
  inherited;
  Close;
end;


procedure TfrmCadAutGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    autoColorDinamica : TAutoColorDinamica;
    intOpcao : Integer;
begin
  inherited;
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin
    pnlInfo.Caption := 'Gerando arquivo (AUTOCOLOR), aguarde...';

    btnConfirmaGeracao.Enabled := False;
    btnSairGeracao.Enabled     := False;

    If chkBases.Checked Then
      intOpcao := 1
    Else If chkTintas.Checked Then
      intOpcao := 2
    Else
      intOpcao := 3;

    autoColorDinamica := TAutoColorDinamica.Create(intOpcao, True, True);
    autoColorDinamica.RegistraAcao := pRegistraAcao;
    autoColorDinamica.RegistraProgresso := pRegistraProgresso;

    If (autoColorDinamica.fProcessarArquivos) Then
      fMensagem('', 'Arquivo gerado com sucesso!', ['&O k']);

    pnlInfo.Caption := '';
    Close;
  End;
end;

procedure TfrmCadAutGeraArquivo.pRegistraProgresso(intInicio, intAtual,
  intMaximo: Integer);
begin
  Gauge1.MinValue := intInicio;
  Gauge1.MaxValue := intMaximo;
  Gauge1.Progress := intAtual;
  pnlInfo.Caption := Format('Gerando arquivo (AUTOCOLOR) (%d / %d)', [intAtual, intMaximo]);
end;

procedure TfrmCadAutGeraArquivo.pRegistraAcao(strAcao: String);
begin
  Memo1.Lines.Add(strAcao);
end;

end.
