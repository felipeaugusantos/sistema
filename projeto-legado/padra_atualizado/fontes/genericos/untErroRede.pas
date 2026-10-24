unit untErroRede;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, cxControls, cxContainer, cxEdit,
  cxProgressBar, StrUtils, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  ClipBrd, BitBtnLockedIncrem, Vcl.Buttons, dxGDIPlusClasses, cxImage;

type
  TfrmErroRede = class(TForm)
    Panel1: TPanel;
    memStack: TMemo;
    Panel3: TPanel;
    btnFechar: TBitBtnLocked;
    Splitter1: TSplitter;
    Panel4: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    lblTentativas: TLabel;
    memErro: TMemo;
    cxImage1: TcxImage;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    btnCopy: TSpeedButton;
    procedure btnFecharClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    class var frmErroRede: TfrmErroRede;
  public
    class function fExibindoMensagemErroRede: Boolean;
    class procedure pMensagemErroRede(strTrace: String);
  end;

implementation

uses untModulo, untFuncoesSimples, untLogAut, untThreadUtils, untFuncoes;

{$R *.dfm}

procedure TfrmErroRede.btnFecharClick(Sender: TObject);
begin
  try
    TLogAut.New().pLogout();
    pFinalizaLibrarys;
  finally
    If Not TerminateProcess(GetCurrentProcess, 0) Then
      Application.Terminate;
  end;
end;

procedure TfrmErroRede.btnCopyClick(Sender: TObject);
begin
  Clipboard.AsText := memStack.Text;
end;

class function TfrmErroRede.fExibindoMensagemErroRede: Boolean;
begin
  Result := Assigned(frmErroRede);
end;

procedure TfrmErroRede.FormCreate(Sender: TObject);
begin
  TThreadFinalizarAutcomMonitor.Monitorar;
end;

class procedure TfrmErroRede.pMensagemErroRede(strTrace: String);
begin
  If fExibindoMensagemErroRede Then
    Exit;
  Try
    Application.CreateForm(TfrmErroRede, frmErroRede);
    frmErroRede.memStack.Text := strTrace;
    if VS_AutoatendimentoPagueFacil then
      frmErroRede.FormStyle := fsStayOnTop;
    frmErroRede.ShowModal;
  Finally
    FreeAndNil(frmErroRede);
  End;
end;

initialization

untModulo.ProcMensagemErroRede := TfrmErroRede.pMensagemErroRede;

end.
