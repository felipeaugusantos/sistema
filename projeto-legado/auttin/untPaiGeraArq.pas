unit untPaiGeraArq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Gauges ,untTintadeMaquina,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type

  TfrmPaiGeraArq = class(TfrmPai)
    pnlCabecalho: TPanel;
    memSaida: TMemo;
    gProgresso: TGauge;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  protected
    tintaClasse: TTintadeMaquinaClasse;
    procedure pRegistrAcao(strAcao: String);
    procedure pRegistraProgresso(intInicio, intAtual, intFinal: Integer);
  public
    constructor Create(AOwner: TComponent; tintaClasse: TTintadeMaquinaClasse); reintroduce; overload; virtual;
    constructor Create(AOwner: TComponent); overload; override;
    { Public declarations }
  end;

var
  frmPaiGeraArq: TfrmPaiGeraArq;

implementation

uses untFuncoesSimples, IniFiles;

{$R *.dfm}



procedure TfrmPaiGeraArq.pRegistrAcao(strAcao: String);
begin
  memSaida.Lines.Add(TimeToStr(fNow()) + ' - ' + strAcao);
  Application.ProcessMessages;
end;

procedure TfrmPaiGeraArq.pRegistraProgresso(intInicio, intAtual,
  intFinal: Integer);
begin
  gProgresso.MaxValue := intFinal;
  gProgresso.MinValue := intInicio;
  gProgresso.Progress := intAtual;
  pnlInfo.Caption := Format('Processando... (%d/%d)', [intAtual, intFinal]);
  Application.ProcessMessages;
end;

procedure TfrmPaiGeraArq.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    tinta : TTintadeMaquina;
begin
  btnConfirmaGeracao.Enabled := False;

  Try
    tinta := tintaClasse.Create(Self);
  Except
    pMensagensErro('Não foi possivel gerar novas formulas', 'TfrmPaiGeraArq.btnConfirmaGeracaoClick');
    btnConfirmaGeracao.Enabled := True;
    Exit;
  End;

  tinta.RegistraAcao := pRegistrAcao;
  tinta.RegistraProgresso := pRegistraProgresso;

  If tinta.fGravarNovasFormulas Then
    fMensagem('', 'Novas formulas cadastradas com sucesso!', ['OK']);

  btnConfirmaGeracao.Enabled := True;
end;

constructor TfrmPaiGeraArq.Create(AOwner: TComponent;
  tintaClasse: TTintadeMaquinaClasse);
begin
  Create(AOwner);
  Self.tintaClasse := tintaClasse;
  pnlCabecalho.Caption := 'Gerar Cadastro de Novas Fórmulas - ' + TTintadeMaquina(tintaClasse.Create(Self)).NomeTinta;
  Self.Caption := pnlCabecalho.Caption;
end;

constructor TfrmPaiGeraArq.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

end.
