unit untCadSolGeraArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Gauges,
  untSolBrazDinamica,  BitBtnLockedIncrem;

type
  TfrmCadSolGeraArquivos = class(TfrmPai)
    memProgresso: TMemo;
    gauProgresso: TGauge;
    rgOpcao: TRadioGroup;
    pnlCabecalho: TPanel;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure BitBtn1Click(Sender: TObject);
  private
    fltTempo: Double;
    solBrazDinamica : TSolBrazDinamica;
    { Private declarations }
  public
    procedure pRegistraAcao(strAcao: String);
    procedure pRegistraProgresso(intMinimo, intAtual, intMaximo: Integer);
    { Public declarations }
  end;

var
  frmCadSolGeraArquivos: TfrmCadSolGeraArquivos;

implementation

uses untFuncoesSimples;


{$R *.dfm}

procedure TfrmCadSolGeraArquivos.btnConfirmaGeracaoClick(Sender: TObject);
begin
  inherited;
  btnConfirmaGeracao.Enabled := False;
  fltTempo := Now();
  solBrazDinamica := TSolBrazDinamica.Create(Self, rgOpcao.ItemIndex + 1);
  solBrazDinamica.RegistraAcao := pRegistraAcao;
  solBrazDinamica.RegistraProgresso := pRegistraProgresso;
  If (solBrazDinamica.fProcessaArquivos) Then
    fMensagem('', 'Arquivos processados com sucesso!', ['OK']);
end;

procedure TfrmCadSolGeraArquivos.pRegistraAcao(strAcao: String);
begin
  memProgresso.Lines.Add(DateTimeToStr(Now()) + ' - ' + strAcao);
end;



procedure TfrmCadSolGeraArquivos.pRegistraProgresso(intMinimo, intAtual,
  intMaximo: Integer);
begin
  gauProgresso.MaxValue := intMaximo;
  gauProgresso.MinValue := intMinimo;
  gauProgresso.Progress := intAtual;

  pnlInfo.Caption := Format('processando arquivos (%d / %d) (%s)',
    [intAtual, intMaximo, TimeToStr((Now() - fltTempo) * (intMaximo - intAtual) / (1 + intAtual - intMinimo)) ]);
end;

procedure TfrmCadSolGeraArquivos.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(rgOpcao.Buttons[1]);
end;

procedure TfrmCadSolGeraArquivos.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
  If (rgOpcao.ContainsControl(FindControl(Msg.hwnd))) Then
  Begin
    If (Msg.message = WM_KEYFIRST) Then
    begin
      If (Msg.wParam = 27) Then
        pEscapePressed;
      If (Msg.wParam = 13) Then
        btnConfirmaGeracao.Click;
    end;
  End;
end;

procedure TfrmCadSolGeraArquivos.BitBtn1Click(Sender: TObject);
begin
  inherited;
  If (fMensagem('', 'Deseja cancelar a operação?', ['Sim', 'Não']) = 1) Then
    solBrazDinamica.pCancelar;
end;

end.

