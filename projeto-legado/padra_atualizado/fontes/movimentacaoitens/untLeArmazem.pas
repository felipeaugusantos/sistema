unit untLeArmazem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, EditFocus, untCadArmazemOperadores, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmLeArmazem = class(TfrmPaiConfirma)
    edtCodAmz: TEditFocus;
    edtDesAmz: TEditFocus;
    procedure edtCodAmzKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmLeArmazem: TfrmLeArmazem;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmLeArmazem.edtCodAmzKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqArmazem(Self, edtCodAmz, edtDesAmz, nil, Key, arrSel, True, '', '', False, fCfgSis('CTRAMZ', varBoolean)) Then
  Begin
    If fValidaCampos(edtCodAmz, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmLeArmazem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

   If ModalResult = mrOk Then
   Begin
     If Not fVerificaCampos Then
       Action := caNone;
   End;
   
end;

function TfrmLeArmazem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Try

      If (Sender = edtCodAmz) Then
      Begin

        If fEmptyStr(edtCodAmz.Text) Then
        Begin
          edtDesAmz.Clear;
          pMensagemOk('Informe o Armazém!');;
          Result := False;
        End Else
        Begin
          edtDesAmz.Text := fRetNomeArmazem(edtCodAmz.Text);

          If fEmptyStr(edtDesAmz.Text) Then
          Begin
            pMensagemOk('Armazém não encontrado!');
            Result := False;
          End
          Else If fCfgSis('CTRAMZ', varBoolean) Then
          Begin
            If Not TfrmCadArmazemOperadores.fOperadorComAcesso(edtCodAmz.Text) Then
            Begin
              pMensagemOk('Esse operador não possui acesso ao armazém ' + QuotedStr(edtCodAmz.Text) + ' nessa empresa, favor verificar o cadastro de controle de armazém por operadores');
              Result := False;
            End;
          End
        End;
      End;

    Except
      On E: Exception Do
      Begin
				pMensagensErro(E.Message,'[TfrmLeArmazem.fValidaCampos]');
        Result := False;
      End;
    End;

  End;

  If Not Result Then
  Begin
    pSetFocus(Sender);
  End;

end;

end.
