unit untObservacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, MemoFocus;

type
  TInputMod = (tpimNormal,     //tpimNormal = Não atera a tela,
               tpiInputQuery); //tpiInputQuery = simula a função InputQuery;}

  TfrmObservacao = class(TForm)
    pnlMensagem: TPanel;
    lblMensagem: TLabel;
    pnlTexto: TPanel;
    memObs: TMemoFocus;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    btnShowTrace: TSpeedButton;
    btnHideTrace: TSpeedButton;
    pnlBotoes: TPanel;
    FlwBotoes: TFlowPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnClipBoard: TBitBtnLocked;
    btnSair: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnClipBoardClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure memObsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FUtilizarConfirmacao: Boolean;
    FConfirmou: Boolean;
    FInputMod: TInputMod;
  public
    property blnUtilizarConfirmacao: Boolean read FUtilizarConfirmacao write FUtilizarConfirmacao;
    property blnConfirmou: Boolean read FConfirmou write FConfirmou;
    class function fObservacao(strTitulo: string; strTexto: string;
                   intMaxLength: integer = 0; InputMod: TInputMod = tpimNormal; tamHeight: integer = 0; blnForcaBtnConfirma : Boolean = False; strTituloForm: string = ''): string;
  end;

var
  frmObservacao: TfrmObservacao;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmObservacao.btnClipBoardClick(Sender: TObject);
begin
  memObs.SelectAll;
  memObs.CopyToClipboard;
  pnlInfo.Caption := 'Texto copiado! Cole através do CTRL + V';
end;

procedure TfrmObservacao.btnConfirmaDadosClick(Sender: TObject);
begin
  FConfirmou := True;
  Close;
end;

procedure TfrmObservacao.btnSairClick(Sender: TObject);
begin
  If (FInputMod = tpiInputQuery) and (FUtilizarConfirmacao) Then
    memObs.Clear;
end;

class function TfrmObservacao.fObservacao(strTitulo, strTexto: string;
  intMaxLength: integer; InputMod: TInputMod; tamHeight: integer;
  blnForcaBtnConfirma: Boolean; strTituloForm: string): string;
  procedure pPreparaTelaInputQuery;
  Begin
    If tamHeight = 0 Then
       frmObservacao.Height := 115 + (Trunc(intMaxLength/65) * 15)
    Else
      frmObservacao.Height := 115 + tamHeight;

    frmObservacao.FUtilizarConfirmacao := blnForcaBtnConfirma;
    If blnForcaBtnConfirma Then


  End;
begin
  Application.CreateForm(TfrmObservacao, frmObservacao);
  //pCriarFormularios(TfrmObservacao, frmObservacao);
  Try
    frmObservacao.memObs.MaxLength := intMaxLength;
    frmObservacao.memObs.Lines.Text := strTexto;
    frmObservacao.lblMensagem.Caption := strTitulo;
    frmObservacao.FInputMod := InputMod;
    If strTituloForm <> '' Then
      frmObservacao.Caption  := strTituloForm;

    If InputMod = tpiInputQuery Then
      pPreparaTelaInputQuery;
    frmObservacao.ShowModal;
  Finally
    fObservacao := frmObservacao.memObs.Lines.Text;
    FreeAndNil(frmObservacao);
  End;
end;

procedure TfrmObservacao.FormCreate(Sender: TObject);
begin
  FConfirmou := False;
  FUtilizarConfirmacao := False;
  FInputMod := tpimNormal;
end;

procedure TfrmObservacao.FormShow(Sender: TObject);
begin
  SelectFirst;
  If FInputMod = tpiInputQuery Then
    pSetFocus(memObs);
  btnConfirmaDados.Visible := FUtilizarConfirmacao;
  memObs.ReadOnly := (Not FUtilizarConfirmacao) And (FInputMod = tpimNormal);
end;

procedure TfrmObservacao.memObsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_RETURN) And
     ((FInputMod = tpiInputQuery) And (Not FUtilizarConfirmacao)) And
     (Length(memObs.Lines.Text) >= memObs.MaxLength) Then
    pSetFocus(btnSair);

  If Key = VK_ESCAPE Then
    Close;
end;

end.
