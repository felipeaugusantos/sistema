unit untObservacaoCRM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Menus, Buttons, ExtCtrls, AppEvnts, MemoFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, StrUtils, EditFocus,
  untTypesSistema;

type
  TfrmObservacaoCRM = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnlObs: TPanel;
    memObs: TMemoFocus;
    lblMensagem: TLabel;
    pnlOperadorDestino: TPanel;
    lblOperadorDestino: TLabel;
    edtCodOpe: TEditFocus;
    edtDesCodOpe: TEditFocus;
    procedure memObsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure pCarregaUsuarioDestino;
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; Override;
  public
    blnFinaliza : Boolean;
  end;

var
  frmObservacaoCRM: TfrmObservacaoCRM;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas;

procedure TfrmObservacaoCRM.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If not btnConfirma.Visible Then
    Exit;

  If fMensagem('ATENÇÃO!', IfThen(blnFinaliza, 'Finalizar a Ocorrência?', 'Confirma reabertura da ocorrência?' ), ['&Sim', '&Não']) = 1 Then
    ModalResult := mrOK
  Else
    pSetFocus(memObs);

end;

procedure TfrmObservacaoCRM.edtCodOpeKeyPress(Sender: TObject; var Key: Char);
Var
  arrOpe: TConsultasArray;
begin
  inherited;

  If (fPesqOperador(Self, edtCodOpe, edtDesCodOpe, nil, Key, arrOpe)) Then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmObservacaoCRM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If not btnConfirma.Visible Then
    Exit;

  If ModalResult <> mrOK Then
  Begin
    If fMensagem('ATENÇÃO', 'Deseja realmente sair?', ['&Sim', '&Não'], 2) = 2 Then
    Begin
      Action := caNone;
      pSetFocus(memObs);
    End;
  End;
end;

procedure TfrmObservacaoCRM.FormCreate(Sender: TObject);
begin
  inherited;
  blnFinaliza := True;

  If fCfgSis('OPEFOC', varBoolean) Then
  Begin
    pnlOperadorDestino.Visible := True;
    edtCodOpe.Text := strLoginUsuarioLogado;
  End
  Else
    pnlOperadorDestino.Visible := False;
end;

procedure TfrmObservacaoCRM.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;

  If Not fEmptyStr(edtCodOpe.Text) Then
    pCarregaUsuarioDestino;
end;

function TfrmObservacaoCRM.fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtCodOpe) Then
    Begin
      If (Not fEmptyStr(edtCodOpe.Text)) Then
      Begin
        pCarregaUsuarioDestino;
        If fEmptyStr(edtDesCodOpe.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Operador Destino não encontrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmObservacaoCRM.memObsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_ESCAPE Then
    pEscapePressed;

end;

procedure TfrmObservacaoCRM.pCarregaUsuarioDestino;
begin
  edtDesCodOpe.Text := fRetNomeOperador(edtCodOpe.Text);
end;

end.
