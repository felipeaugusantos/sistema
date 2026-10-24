unit untFatDigCnpj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, Mask, MaskEditFocus, untMskC_G_C_, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFatDigCnpj = class(TfrmPai)
    pnlGeral: TPanel;
    Label9: TLabel;
    edtCgcCpf: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    edtNumCgc: TMaskEditC_G_C_;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCgcCpfChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FblnValidarCRMCVI : Boolean;
    FblnValidarCRMPVI : Boolean;
    FblnValidarCNSCRE : Boolean;
    FblnValidarCNSCCA : Boolean;

    procedure pCarregarCliente;
    procedure pCarregarProspecto;
    procedure pBuscaCliente;
    function fExisteMaisDeUmClienteComOMesmoCNPJ_CPF: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnCGCRep: Boolean;
    blnPermiteBranco: Boolean;
    blnValidaRepetidos: Boolean;
    blnCRM: Boolean;
    blnProspecto: Boolean;
    strCodCli: String;
    blnFocarNumCpf: Boolean;
    blnListarClientes: Boolean;
    blnForcaValidacaoCliente: Boolean;
  end;

var
  frmFatDigCnpj: TfrmFatDigCnpj;

implementation

uses  untfuncoesSimples, untFuncoesGenerica, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmFatDigCnpj }

function TfrmFatDigCnpj.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCgcCpf) Then
  Begin
    If (fEmptyStr(edtCgcCpf.Text)) Or (edtCgcCpf.Text = '0') Then
    Begin
      If fEmptyStr(edtNumCgc.Text, True) Then
      Begin
        Result := blnPermiteBranco;
      End
      Else
        Result := False;
    End
    Else If (edtCgcCpf.Text <> '1') And (edtCgcCpf.Text <> '2') Then
    Begin
      Result := False;
    End;


  End

  Else If (Sender = edtNumCgc) Then
  Begin

    If fEmptyStr(edtNumCgc.Text) Then
    Begin
      strCodCli := EmptyStr;
      edtCgcCpf.Clear;
    End
    Else
    Begin
      Result := fValidaCnpjCpf(edtCgcCpf.Text, edtNumCgc.Text, blnCGCRep, blnCGCRep);

      If (blnValidaRepetidos) Then
      Begin

        If (fReplicatorStr(edtNumCgc.Text[1], Length(edtNumCgc.Text)) = edtNumCgc.Text) Then
          Result := False;

        If Not Result Then
        Begin
          fMensagem('Atenção!', 'Informe um CPF/CNPJ válido!', ['&Ok']);
        End;

      End;

      If Result Then
      Begin
        If FblnValidarCRMCVI or FblnValidarCNSCRE or FblnValidarCNSCCA or blnForcaValidacaoCliente Then
        Begin
          If (fExisteMaisDeUmClienteComOMesmoCNPJ_CPF) And (blnListarClientes) Then
            pBuscaCliente
          Else
          Begin
            pCarregarCliente;

            If (strCodCli = EmptyStr) Then
            Begin
              fMensagem('Atenção!', 'Este CNPJ/CPF não existe no Cadastro de Clientes!', ['&Ok']);
              Result := False;
            End;
          End;
        End;

        If FblnValidarCRMPVI Then
        Begin
          pCarregarProspecto;

          If (strCodCli = EmptyStr) Then
          Begin
            fMensagem('Atenção!', 'Este CNPJ/CPF não existe no Cadastro de Prospecto!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End;
  End;
end;

procedure TfrmFatDigCnpj.pCarregarCliente;
begin
  strCodCli := fRetClientePorCgcCpf(StrToIntDef(edtCgcCpf.Text, 2), edtNumCgc.Text);
end;

procedure TfrmFatDigCnpj.pCarregarProspecto;
begin
  strCodCli := fRetProspectoPorCgcCpf(StrToIntDef(edtCgcCpf.Text, 2), edtNumCgc.Text);
end;

procedure TfrmFatDigCnpj.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmFatDigCnpj.edtCgcCpfChange(Sender: TObject);
begin
  inherited;

  edtNumCgc.EditMask := fRetMascaraC_G_C_(fSetaPais, IIF(edtCgcCpf.Text='1', C_G_C_, C_P_F_));
end;

procedure TfrmFatDigCnpj.FormCreate(Sender: TObject);
begin
  inherited;

  blnCGCRep := False;
  blnPermiteBranco := False;
  blnValidaRepetidos := False;
  blnFocarNumCpf := False;
  blnCRM := False;
  blnProspecto := False;
  blnListarClientes := False;
  blnForcaValidacaoCliente := False;
end;

procedure TfrmFatDigCnpj.FormShow(Sender: TObject);
begin
  inherited;

  FblnValidarCRMCVI := blnCRM And (fCfgSis('CRMCVI') = 'L') And (Not blnProspecto);
  FblnValidarCRMPVI := blnCRM And (fCfgSis('CRMPVI') = 'L') And blnProspecto;
  FblnValidarCNSCRE := (fCfgSis('CNSCRE', varString) = 'L') And (Not blnProspecto);
  FblnValidarCNSCCA := (fCfgSis('CNSCCA', varString) = 'L') And (Not blnProspecto);

  If blnFocarNumCpf Then
  Begin
    edtCgcCpf.Text := '2';
    pSetFocus(edtNumCgc);
  End
  Else
    pSetFocus(edtCgcCpf);
end;

procedure TfrmFatDigCnpj.pBuscaCliente;
  Var
    arrSelCli: TConsultasArray;
    chrKey: Char;
Begin
  chrKey := '/';
  arrSelCli := Nil;

  If (Not fEmptyStr(edtNumCgc.Text)) Then
  Begin
    If (Not fEmptyStr(strCodCli)) And (fRetCgcCpf(strCodCli) = edtNumCgc.Text) Then
      Exit;

    fPesqCliente(conCliSimples, Self, Nil, Nil, Nil, chrKey, arrSelCli, True, Nil,
      False, '', '', True, '', '', tfvNenhum, edtNumCgc.Text);
  End;

  If (arrSelCli <> Nil) Then
    strCodCli := arrSelCli[0].strCodigo
End;

function TfrmFatDigCnpj.fExisteMaisDeUmClienteComOMesmoCNPJ_CPF: Boolean;
  Var
    strCondicao: String;
Begin
  strCondicao := 'CLI_C_G_C_ = '+ QuotedStr(edtNumCgc.Text);
  Result := (fRetornaCountDados('CADCLI', 'CLI_CODCLI', strCondicao) > 1);
End;

end.

