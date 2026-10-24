unit untCadLkdGeraArquivosNovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Gauges,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadLkdGeraArquivosNovo = class(TfrmPai)
    pnlFundo: TPanel;
    gau: TGauge;
    pnlCabecalho: TPanel;
    Men: TMemo;
    rgOpcoes: TRadioGroup;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
    procedure pRegistrAcao(strAcao: String);
    procedure pRegistraProgresso(intInicio, intAtual, intFinal: Integer);
  public
    { Public declarations }
  end;

var
  frmCadLkdGeraArquivosNovo: TfrmCadLkdGeraArquivosNovo;

implementation

uses untLuksColorDinamicaNova, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadLkdGeraArquivosNovo.btnConfirmaGeracaoClick(
  Sender: TObject);
  Var
    lucksColor: TLuksColorDinamicaNova;
begin
  btnConfirmaGeracao.Enabled := False;

  lucksColor := TLuksColorDinamicaNova.Create(rgOpcoes.ItemIndex + 1);
  lucksColor.RegistraAcao := pRegistrAcao;
  lucksColor.RegistraProgresso := pRegistraProgresso;

  If lucksColor.fImportarArquivos Then
    fMensagem('', 'Arquivos impotados com exito!', ['OK']);

  FreeAndNil(lucksColor);
  btnConfirmaGeracao.Enabled := True;
end;

procedure TfrmCadLkdGeraArquivosNovo.pRegistrAcao(strAcao: String);
begin
  Men.Lines.Add(DateTimeToStr(fNow()) + ' - ' + strAcao);
  Application.ProcessMessages;
end;

procedure TfrmCadLkdGeraArquivosNovo.pRegistraProgresso(intInicio,
  intAtual, intFinal: Integer);
begin
  gau.MaxValue := intFinal;
  gau.MinValue := intInicio;
  gau.Progress := intAtual;
  pnlInfo.Caption := Format('Processando... (%d / %d)', [intAtual, intFinal]);
  Application.ProcessMessages;
end;

end.
