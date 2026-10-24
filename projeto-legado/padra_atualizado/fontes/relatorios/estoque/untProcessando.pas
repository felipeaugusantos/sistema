unit untProcessando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, cxControls, cxContainer, cxEdit, cxLabel, ComCtrls,
  Uni, DB, UniClientDataSet, StrUtils, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters;

type
  TfrmProcessando = class(TForm)
    stbStatus: TStatusBar;
    lblProc: TcxLabel;
    imgGravando: TImage;
    tmrControle: TTimer;
    procedure tmrControleTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FHraIni : TTime;

  public
    Class Function fAguardaProcessamento(Var FrmProcessando: TfrmProcessando) : Boolean;
    Procedure pSetModalOK;
  end;


implementation

{$R *.dfm}

class function TfrmProcessando.fAguardaProcessamento(Var FrmProcessando: TfrmProcessando) : Boolean;
begin
  FrmProcessando := TfrmProcessando.Create(Application);
  With FrmProcessando Do
  Begin
    Result := (ShowModal = MrOk) ;
    tmrControle.Enabled := False;

  End;
  FreeAndNil(FrmProcessando);

end;

procedure TfrmProcessando.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE Then
    ModalResult := mrCancel;
end;

procedure TfrmProcessando.FormShow(Sender: TObject);
begin
  FHraIni := Now;
  tmrControle.Enabled := True;

end;

procedure TfrmProcessando.pSetModalOK;
begin
  ModalResult := MrOk;

end;

procedure TfrmProcessando.tmrControleTimer(Sender: TObject);
begin
  lblProc.Tag := lblProc.Tag + 1;
  If lblProc.Tag > 3 then
    lblProc.Tag := 0;

  Case lblProc.Tag of
    0: lblProc.Caption := 'Processando Dados, Aguarde';
    1: lblProc.Caption := 'Processando Dados, Aguarde.';
    2: lblProc.Caption := 'Processando Dados, Aguarde..';
    3: lblProc.Caption := 'Processando Dados, Aguarde...';
  End;

  Case lblProc.Tag of
    0: Caption := 'Aguarde';
    1: Caption := 'Aguarde.';
    2: Caption := 'Aguarde..';
    3: Caption := 'Aguarde...';
  End;

  stbStatus.Panels[0].Text := 'Tempo de Execução ' + FormatDateTime('hh:nn:ss', Now - FHraIni);

  Application.ProcessMessages;

end;

end.
