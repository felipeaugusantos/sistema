unit untObservacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Menus, Buttons, ExtCtrls, AppEvnts, MemoFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TInputMod = (tpimNormal,     //tpimNormal = Não atera a tela,
               tpiInputQuery); //tpiInputQuery = simula a função InputQuery;}
  TfrmObservacao = class(TfrmPai)
    pnlMensagem: TPanel;
    pnlTexto: TPanel;
    lblMensagem: TLabel;
    memObs: TMemoFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnClipBoard: TBitBtnLocked;
    procedure memObsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnClipBoardClick(Sender: TObject);
  private
    FUtilizarConfirmacao: Boolean;
    FConfirmou: Boolean;
    FInputMod: TInputMod;
    { Private declarations }
  public
    { Public declarations }
    property blnUtilizarConfirmacao: Boolean read FUtilizarConfirmacao write FUtilizarConfirmacao;
    property blnConfirmou: Boolean read FConfirmou write FConfirmou;
    class function fObservacao(strTitulo: string; strTexto: string;
                   intMaxLength: integer = 0; InputMod: TInputMod = tpimNormal; tamHeight: integer = 0; blnForcaBtnConfirma : Boolean = False; strTituloForm: string = ''): string;

  end;

var
  frmObservacao: TfrmObservacao;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmObservacao.btnClipBoardClick(Sender: TObject);
begin
  memObs.SelectAll;
  memObs.CopyToClipboard;
  pnlInfo.Caption := 'Texto copiado! Cole através do CTRL + V';
end;

procedure TfrmObservacao.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  FConfirmou := True;
  Close;
end;

procedure TfrmObservacao.FormCreate(Sender: TObject);
begin
  inherited;
  FConfirmou := False;
  FUtilizarConfirmacao := False;
  FInputMod := tpimNormal;
end;

procedure TfrmObservacao.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
  If FInputMod = tpiInputQuery Then
    pSetFocus(memObs);
  btnConfirmaDados.Visible := FUtilizarConfirmacao;
  memObs.ReadOnly := (Not FUtilizarConfirmacao) And (FInputMod = tpimNormal);
end;

procedure TfrmObservacao.memObsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And
     ((FInputMod = tpiInputQuery) And (Not FUtilizarConfirmacao)) And
     (Length(memObs.Lines.Text) >= memObs.MaxLength) Then
    pSetFocus(btnSair);

  If Key = VK_ESCAPE Then
    pEscapePressed;

end;

procedure TfrmObservacao.btnSairClick(Sender: TObject);
begin
  inherited;
  If (FInputMod = tpiInputQuery) and (FUtilizarConfirmacao) Then
    memObs.Clear;
end;

class function TfrmObservacao.fObservacao(strTitulo: string; strTexto: string; intMaxLength: integer = 0; InputMod: TInputMod = tpimNormal; tamHeight: integer = 0; blnForcaBtnConfirma : Boolean = False; strTituloForm: string = ''): string;
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
  pCriarFormularios(TfrmObservacao, frmObservacao);
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


end.
