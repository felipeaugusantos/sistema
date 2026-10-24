unit iMendes.TProcessando;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar, dxGDIPlusClasses,
  cxImage, Uni, ShellApi;

type
  TepResultado = (epConcluido, epAbotado, epConcluidoSemItensParaProcessar, epConcluidComErro, epSemProcesso);

  TfProcessa = function (pgbStatus: TcxProgressBar; var lblCaption: TLabel; var lblTempoEstimado: TLabel): TepResultado  of object;

  TfrmiMendesProcessando = class(Tform)
    pgbStatus: TcxProgressBar;
    lblGravando: TLabel;
    imgGravando: TcxImage;
    shaFundo: TShape;
    AppEvents: TApplicationEvents;
    Image1: TImage;
    imgServicoParador: TImage;
    imgServicoConectado: TImage;
    tmrValidaServico: TTimer;
    lblMonitoramento: TLabel;
    lblTempoEstimado: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure tmrValidaServicoTimer(Sender: TObject);
  public
    epResultado: TepResultado;
  private
    FqryMonitoramento : TUnIQuery;
    blnServicoComOrdemParaSubir: Boolean;
    { Private declarations }
  public
    fProcessa: TfProcessa;
    class var blnMarcadoParaFechar: Boolean;
    class function fExecutaProcesso(AProcessa: TfProcessa; qryMonitoramento: TUniQuery): TepResultado;
    { Public declarations }

  end;

var
  frmiMendesProcessando: TfrmiMendesProcessando;

implementation

uses
  iMendes.Functions;

{$R *.dfm}

{ TfrmiMendesProcessando }

class function TfrmiMendesProcessando.fExecutaProcesso(AProcessa: TfProcessa; qryMonitoramento: TUniQuery): TepResultado;
begin
  frmiMendesProcessando := TfrmiMendesProcessando.Create(nil);
  Try
    frmiMendesProcessando.blnServicoComOrdemParaSubir := False;
    frmiMendesProcessando.pgbStatus.Position := 0;
    frmiMendesProcessando.blnMarcadoParaFechar := False;
    frmiMendesProcessando.imgServicoParador.Visible := False;
    frmiMendesProcessando.imgServicoConectado.Visible := False;

    frmiMendesProcessando.FqryMonitoramento := qryMonitoramento;
    frmiMendesProcessando.tmrValidaServicoTimer(frmiMendesProcessando.tmrValidaServico);

    frmiMendesProcessando.fProcessa := AProcessa;

    frmiMendesProcessando.ShowModal;
    Result := frmiMendesProcessando.epResultado;
  Finally
    FreeAndNil(frmiMendesProcessando);
  End;
end;

procedure TfrmiMendesProcessando.FormActivate(Sender: TObject);
begin
  epResultado := fProcessa(frmiMendesProcessando.pgbStatus,
                           frmiMendesProcessando.lblGravando,
                           frmiMendesProcessando.lblTempoEstimado);
  PostMessage(Self.Handle, WM_CLOSE, 0, 0);

end;

procedure TfrmiMendesProcessando.Image1Click(Sender: TObject);
begin
  blnMarcadoParaFechar := True;
end;

procedure TfrmiMendesProcessando.tmrValidaServicoTimer(Sender: TObject);
var strImendesIntegraExe: String;
begin
  strImendesIntegraExe := ExtractFilePath(Application.ExeName) + '\iMendesItegra.exe';
  if fServicoUP(FqryMonitoramento) then
  Begin
    frmiMendesProcessando.imgServicoConectado.Visible := True;
    frmiMendesProcessando.imgServicoParador.Visible := False;
    lblMonitoramento.Caption := 'Serviço de comunicação com iMendes "Executando".' ;
    tmrValidaServico.Interval := 5000;
  End
  Else
  Begin
    frmiMendesProcessando.imgServicoConectado.Visible := False;
    frmiMendesProcessando.imgServicoParador.Visible := True;
    lblMonitoramento.Caption := 'Serviço de comunicação com iMendes "Parado". Verifique!';
  End;
  Application.ProcessMessages;


end;

end.
