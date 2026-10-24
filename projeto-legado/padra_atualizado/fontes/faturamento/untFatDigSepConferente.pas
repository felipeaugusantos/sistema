unit untFatDigSepConferente;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Uni,
  ExtCtrls, EditFocus, AppEvnts, QColorLabel, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFatDigSepConferente = class(TfrmPaiSimples)
    lblSeparador: TLabel;
    edtCodSeparador: TEditFocus;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    edtNomSeparador: TEditFocus;
    pnlFundo: TPanel;
    lblConferente: TLabel;
    edtSenhaConferente: TEditFocus;
    edtNomConferente: TEditFocus;
    lblObs: TColorLabel;
    edtObs: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtCodSeparadorKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FColetor: Boolean;
    FConferenteSenha: Boolean;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strCodConferente: String;
    property Coletor: Boolean read FColetor write FColetor;
    property ConferenteSenha: Boolean read FConferenteSenha write FConferenteSenha;
  end;

var
  frmFatDigSepConferente: TfrmFatDigSepConferente;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmFatDigSepConferente.FormCreate(Sender: TObject);
begin
  inherited;
  FColetor         := False;
  FConferenteSenha := True;
  strCodConferente := EmptyStr;
  blnConfirma      := False;
  lblObs.Visible := (VS_strTipExp = '4');
  edtObs.Visible := (VS_strTipExp = '4');
end;

procedure TfrmFatDigSepConferente.FormShow(Sender: TObject);
begin
  inherited;
  if FColetor then
  begin
    Self.Caption := 'Selecione o Separador e o Conferente para o Coletor';
    lblObs.Visible := False;
    edtObs.Visible := False;
    Self.Height := Self.Height - edtObs.Height;
  end;

  if FConferenteSenha then
  begin
    edtSenhaConferente.PasswordChar := '*';
    edtSenhaConferente.TamCampo := 13;
    edtSenhaConferente.MaxLength := 13;
    edtSenhaConferente.CompZeros := False;
  end
  else
  begin
    edtSenhaConferente.PasswordChar := #0;
    edtSenhaConferente.TamCampo := 3;
    edtSenhaConferente.MaxLength := 3;
    edtSenhaConferente.CompZeros := True;
  end;
end;

function TfrmFatDigSepConferente.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodSeparador) Then
    Begin

      If Not fEmptyStr(edtCodSeparador.Text) Then
      Begin
        edtNomSeparador.Text := fRetNomeOperador(edtCodSeparador.Text);
        Result := Not fEmptyStr(edtNomSeparador.Text);
        If (Result) And (Not fOperadorAtivo(edtCodSeparador.Text)) Then
        Begin
          pMensagemOK('Atenção! O Separador informado '+edtCodSeparador.Text+' está inativo. Peça para um responsável ajustar o cadastro ou informe um código válido.');
          Result := False;
        End
        Else If (Not Result) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Separador não está cadastrado!', ['&Ok']);
        End;
      End
      Else
      Begin
        edtNomSeparador.Text := '';
        If Not FColetor Then
        Begin
          fMensagem('ATENÇÃO!', 'O código do Separador deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End;

    End
    Else If (Sender = edtSenhaConferente) Then
    Begin
      strCodConferente := EmptyStr;

      If Not fEmptyStr(edtSenhaConferente.Text) Then
      Begin
        If (fValidaEan13(edtSenhaConferente.Text)) Then
          strCodConferente := fRetCodOperadorCodBarra(edtSenhaConferente.Text)
        Else If FConferenteSenha Then
          strCodConferente := fRetCodVendedor(edtSenhaConferente.Text)
        Else
          strCodConferente := edtSenhaConferente.Text;

        If Not fEmptyStr(strCodConferente) Then
          edtNomConferente.Text := fRetNomeOperador(strCodConferente)
        Else
        Begin
          fMensagem('ATENÇÃO!', 'Este Conferente não está cadastrado!', ['&Ok']);
          Result := False;
        End;

        If (Result) And (Not fOperadorAtivo(strCodConferente)) Then
        Begin
          pMensagemOK('Atenção! O Conferente informado '+strCodConferente+' está inativo. Peça para um responsável ajustar o cadastro ou informe um código válido.');
          Result := False;
        End;
      End
      Else
      Begin
        If Not FColetor Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Conferente deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmFatDigSepConferente.edtCodSeparadorKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodSeparador, edtNomSeparador, qryTabela, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodSeparador,False) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatDigSepConferente.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigSepConferente.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

end.

