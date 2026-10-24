unit untCadSuvSincronizar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Gauges,
  UniDataSetProvider, DB, UniClientDataSet,  BitBtnLockedIncrem;

type
  TfrmCadSuvSincronizar = class(TfrmPai)
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
    procedure FormCreate(Sender: TObject);
  private
    procedure pRegistraAcao(strAcao: String);
    procedure pRegistraProgresso(intInicio, intAtual, intFinal: Integer);
    procedure pRegistraProgressoDownload(intInicio, intAtual, intFinal: Int64);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadSuvSincronizar: TfrmCadSuvSincronizar;

implementation

uses untSuvinilSincronizacao, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadSuvSincronizar.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    suvinilSincronizacao: TSuvinilSincronizacao;
begin
  btnConfirmaGeracao.Enabled := False;

  suvinilSincronizacao := TSuvinilSincronizacao.Create(Self, rdgOpcao.ItemIndex + 1);
  suvinilSincronizacao.RegistraAcao := pRegistraAcao;
  suvinilSincronizacao.RegistraProgresso := pRegistraProgresso;
  suvinilSincronizacao.RegistraProgressoDownload := pRegistraProgressoDownload;

  If (suvinilSincronizacao.fProcessaArquivos) Then
  Begin
    fMensagem('', 'Os arquivos foram processados com sucesso!', ['OK']);
    pRegistraAcao('Os arquivos foram processados com sucesso!');
  End;

  memSaida.Lines.SaveToFile(ExtractFileDir(Application.ExeName) + '\SINCRONIZACAO\SUVLOG' + FormatDateTime('YYYYMMDD', Now()) + '.LOG');
  FreeAndNil(suvinilSincronizacao);
end;

procedure TfrmCadSuvSincronizar.pRegistraAcao(strAcao: String);
begin
  memSaida.Lines.Add(DateTimeToStr(Now) + ' - ' + strAcao);
  Application.ProcessMessages;
end;

procedure TfrmCadSuvSincronizar.pRegistraProgresso(intInicio, intAtual,
  intFinal: Integer);
begin
  Gauge1.MaxValue := intFinal;
  Gauge1.MinValue := intInicio;
  Gauge1.Progress := intAtual;

  pnlInfo.Caption := Format('Processando arquivo (%d/%d)', [intAtual, intFinal]);

  Application.ProcessMessages;
end;

procedure TfrmCadSuvSincronizar.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(rdgOpcao.Buttons[0]);
end;

procedure TfrmCadSuvSincronizar.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
  If (rdgOpcao.ContainsControl(FindControl(Msg.hwnd))) then
  Begin
    If (Msg.message = WM_KEYFIRST) And (Msg.wParam = 27) Then
      btnSair.Click;
    If (Msg.message = WM_KEYFIRST) And (Msg.wParam = 13)
                        And (btnConfirmaGeracao.Enabled) Then
      btnConfirmaGeracao.Click;
  End;


end;

procedure TfrmCadSuvSincronizar.pRegistraProgressoDownload(intInicio,
  intAtual, intFinal: Int64);
begin
  {*************************************************************}
  {* QUANDO SE FAZ O DOWNLOAD DE UM ARQUIVO EM UM SERVIDOR FTP *}
  {* ALGUMAS VEZES NAO SE CONSEGUE OBTER O TAMANHO DO ARQUIVO, *}
  {* RETORNANDO ZERO COMO TAMANHO                              *}
  {**********************************************************PH*}
  If intFinal = 0 Then //Tamanho desconhecido
  Begin
    Gauge1.MaxValue := 0;
    Gauge1.MinValue := 0;
    Gauge1.Progress := 0;
    pnlInfo.Caption := Format('Fazendo Download %d Bytes', [intAtual, intFinal]);
  End
  Else
  Begin
    Gauge1.MaxValue := intFinal;
    Gauge1.MinValue := intInicio;
    Gauge1.Progress := intAtual;
    pnlInfo.Caption := Format('Fazendo Download (%d/%d) Bytes', [intAtual, intFinal]);
  End;

  Application.ProcessMessages;
end;

procedure TfrmCadSuvSincronizar.FormCreate(Sender: TObject);
  Var
    dtaUltAtualizacao: TDateTime;
begin
  inherited;
  If TSuvinilSincronizacao(nil).fDataUltimaAtualizacao(dtaUltAtualizacao, 'SUV_CADSUV', GetCurrentDir + '\SINCRONIZACAO') Then
  Begin
    memSaida.Lines.Add('Ultima Atualização: ' + DateTimeToStr(dtaUltAtualizacao));
  End;
end;

end.

