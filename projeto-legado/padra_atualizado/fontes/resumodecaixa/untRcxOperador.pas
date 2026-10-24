{*****************************}
{* qryConOpe -> CADOPE       *}
{**************************JB*}

unit untRcxOperador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  StrUtils;

type
  TfrmRcxOperador = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCodOpe: TEditFocus;
    edtDesOpe: TEditFocus;
    edtSenOpe: TEditFocus;
    btnConfirma: TBitBtnLocked;
    lblCaixa: TLabel;
    edtCodigoCaixa: TEditFocus;
    edtDescricaoCaixa: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeChange(Sender: TObject);
  private
    { Private declarations }
    qryConOpe: TUniQuery;

    blnAlteraCaixa: Boolean;

    strTipoFechamentoCaixa: String;

    procedure pCarregaOperador;
    procedure pCarregaCaixa;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnRetorno: Boolean;
  end;


implementation

uses untfuncoesSimples, untPai, untPesqAux, untConsultas, untTypesSistema,
     untRcxTResumoDeCaixa, untLiberacao;

{$R *.dfm}

procedure TfrmRcxOperador.FormCreate(Sender: TObject);
begin
  inherited;
  qryConOpe  := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  blnRetorno := False;

  strTipoFechamentoCaixa := fCfgSis('TPFCCX');
end;

procedure TfrmRcxOperador.FormShow(Sender: TObject);
begin
  inherited;

  Self.Height := 160;

  If strTipoFechamentoCaixa = 'C' Then
  Begin
    Self.Height := 200;

    lblCaixa.Visible          := True;
    edtCodigoCaixa.Visible    := True;
    edtDescricaoCaixa.Visible := True;
  End;

  pSetFocus(edtCodOpe);
end;

function TfrmRcxOperador.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCodOpe) Then
  Begin

    If (fEmptyStr(edtCodOpe.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do operador deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaOperador;
      If (qryConOpe.FieldByName('OPE_CODOPE').IsNull) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse operador não está cadastrado!', ['&Ok']);
        Result := False;
      End
      Else If (strTipoFechamentoCaixa = 'C') And
              (blnAlteraCaixa) Then
      Begin
        blnAlteraCaixa := False;
        If Not qryConOpe.FieldByName('OPE_CODCAX').IsNull Then
        Begin
          edtCodigoCaixa.Text := qryConOpe.FieldByName('OPE_CODCAX').Text;
          pCarregaCaixa;
        End;
      End;
    End;

  End

  Else If (Sender = edtCodigoCaixa) And
          (strTipoFechamentoCaixa = 'C') Then
  Begin

    If (fEmptyStr(edtCodigoCaixa.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código do caixa deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaCaixa;
      If (fEmptyStr(edtDescricaoCaixa.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse caixa não está cadastrado, está inativo ou não faz parte da empresa atual!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmRcxOperador.pCarregaOperador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodOpe.Text, False);
  With qryConOpe Do
  Begin
    edtDesOpe.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmRcxOperador.pCarregaCaixa;
begin
  edtDescricaoCaixa.Text := fCampoTabela('CAX_DESCRI',
                                         'CADCAX',
                                         ['CAX_CODCAX', 'CAX_CODEMP', 'CAX_STATUS'],
                                         [edtCodigoCaixa.Text, VS_strCodEmp, 'A']);
end;

procedure TfrmRcxOperador.btnConfirmaClick(Sender: TObject);
  Var
    objLiberacao:  TLiberacao;
    blnLiberado : Boolean;
    arrOperadores: TStringArray;
    strOperadores: String;
    objResumoDeCaixa: TResumoDeCaixa;
begin
  inherited;

  If (Not fVerificaCampos) Then
    Exit;

  If fCfgSis('UEMPCA', varBoolean) Then
  Begin
    If (Pos(VS_strCodEmp, fRetEmpLoginUsuario(edtCodOpe.Text)) <= 0) Then
    Begin
       fMensagem('', 'Operador sem acesso a essa Empresa!', ['&O k']);
       pSetFocus(edtCodOpe);
       Exit;
    End;
  End;

  If (fSenhaPermitida(edtSenOpe.Text)) And
     (qryConOpe.FieldByName('OPE_SENOPE').AsString = fCrypt(edtSenOpe.Text)) Then
  Begin

    If qryConOpe.FieldByName('OPE_STATUS').AsString = 'I' Then
    Begin
      fMensagem('', 'Usuário inativo!', ['&Ok']);
      pSetFocus(edtCodOpe);
      Exit;
    End;

    If Not fVerificaAcessoSistema('mnuFatResumoCaixa', edtCodOpe.Text) Then
    Begin
      pMensagemOk('Usuário sem direito de acesso!');
      pSetFocus(edtCodOpe);
      Exit;
    End;

    If (strTipoFechamentoCaixa = 'C') Then
    Begin
      objResumoDeCaixa := TResumoDeCaixa.Create('C');
      Try
        arrOperadores := objResumoDeCaixa.fRetornaUsuarioDoCaixa(edtCodigoCaixa.Text, VS_strCodEmp, edtCodOpe.Text);
      Finally
        FreeAndNil(objResumoDeCaixa);
      End;

      strOperadores := arrOperadores.ToString(sLineBreak);

      If Not fEmptyStr(strOperadores) Then
      Begin
        objLiberacao := TLiberacao.Create;
        Try
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto(IIF(Length(arrOperadores) = 1,
                                              'Caixa aberto por outro operador (Resumo de Caixa): ',
                                              'Caixa aberto por outros operadores (Resumo de Caixa): ') + sLineBreak + strOperadores);

          objLiberacao.strDirAce := 'LIBLANCXOPE';
          objLiberacao.strMsgSen := 'Caixa aberto por outro operador (Resumo de Caixa)';
          objLiberacao.blnMosMen := True;
          objLiberacao.strCodOpe := edtCodOpe.Text;
          objLiberacao.strCodDig := edtCodOpe.Text;

          blnLiberado := objLiberacao.fLibera;
        Finally
          FreeAndNil(objLiberacao);
        End;

        If Not blnLiberado Then
          Exit;
      End;
    End;

    blnRetorno := True;
    Close;

  End
  Else
  Begin
    fMensagem('', 'Senha Incorreta!', ['&Ok']);
    pSetFocus(edtCodOpe);
  End;

end;

procedure TfrmRcxOperador.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRcxOperador.edtCodigoCaixaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCaixa: TConsultasArray;
begin
  inherited;
  If fPesqCaixas(Self, edtCodigoCaixa, edtDescricaoCaixa, Nil, Key, arrCaixa, True, VS_strCodEmp, True) Then
  Begin
    If fValidaCampos(edtCodigoCaixa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRcxOperador.edtCodOpeChange(Sender: TObject);
begin
  inherited;
  blnAlteraCaixa := True;
end;

end.

