unit untDadosDeBaixaOtimizadaCartoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, EditFocus,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Uni, StrUtils;

type
  TfraDadosDeBaixaOtimizadaCartoes = class(TFrame)
    grpCreditoTaxa: TGroupBox;
    Label50: TLabel;
    Label11: TLabel;
    Label23: TLabel;
    Label12: TLabel;
    Label35: TLabel;
    Label18: TLabel;
    Label28: TLabel;
    dbePorBai: TDBEditFocus;
    edtPorBai: TEditFocus;
    edtPorTax: TEditFocus;
    dbePorTax: TDBEditFocus;
    dbeForTax: TDBEditFocus;
    edtForTax: TEditFocus;
    edtCtaTax: TEditFocus;
    dbeCtaTax: TDBEditFocus;
    dbeCtaCar: TDBEditFocus;
    edtCtaCar: TEditFocus;
    edtEventoBaixa: TEditFocus;
    dbeEventoBaixa: TDBEditFocus;
    edtEventoTaxaBaixa: TEditFocus;
    dbeEventoTaxaBaixa: TDBEditFocus;
    grpDebito: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label25: TLabel;
    edtPorBad: TEditFocus;
    dbePorBad: TDBEditFocus;
    dbeCtaBad: TDBEditFocus;
    edtCtaBad: TEditFocus;
    dbeEveDeb: TDBEditFocus;
    edtDesEve: TEditFocus;
    grpCancelamentos: TGroupBox;
    Label26: TLabel;
    dbeCtaAju: TDBEditFocus;
    edtCtaAju: TEditFocus;
    grpAntecipacao: TGroupBox;
    Label27: TLabel;
    dbeCtaAnt: TDBEditFocus;
    edtCtaAnt: TEditFocus;
    grpFretes: TGroupBox;
    lblPlanoDeContasFretes: TLabel;
    dbeCtaFrete: TDBEditFocus;
    edtDescricaoCtaFrete: TEditFocus;
    grpCupons: TGroupBox;
    lblPlanoDeContasCupons: TLabel;
    dbeCtaCup: TDBEditFocus;
    edtDescricaoCupons: TEditFocus;
    procedure OnFormCreate(Sender: TObject);
    procedure dbePorBaiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCtaCarKeyPress(Sender: TObject; var Key: Char);
    procedure dbePorTaxKeyPress(Sender: TObject; var Key: Char);
    procedure dbePorBadKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForTaxKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCtaBadKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCtaAjuKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCtaAntKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCtaTaxKeyPress(Sender: TObject; var Key: Char);
    procedure dbeEventoBaixaKeyPress(Sender: TObject; var Key: Char);
    procedure dbeEventoTaxaBaixaKeyPress(Sender: TObject; var Key: Char);
    procedure dbeEveDebKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCtaTaxEnter(Sender: TObject);
    procedure dbeCtaTaxExit(Sender: TObject);
    procedure dbeCtaCarEnter(Sender: TObject);
    procedure dbeCtaCarExit(Sender: TObject);
    procedure dbeCtaBadExit(Sender: TObject);
    procedure dbeCtaBadEnter(Sender: TObject);
    procedure dbeCtaAjuEnter(Sender: TObject);
    procedure dbeCtaAjuExit(Sender: TObject);
    procedure dbeCtaAntExit(Sender: TObject);
    procedure dbeCtaAntEnter(Sender: TObject);
    procedure dbeCtaFreteKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCtaCupKeyPress(Sender: TObject; var Key: Char);
    procedure OnFormShow(Sender: TObject);
  private
    qryCadPor,
    qryCadCta,
    qryCadFor,
    qryCadEve: TUniQuery;

    blnUsaCtf,
    blnDacPor,
    blnCtpObe: Boolean;

    strPlCtaOld,
    strPlCtaTxBaixOld,
    strPlCtaBaixOld,
    strPlCtaCancOld,
    strPlCtaAntOld,
    strPlCtaFreteOld : String;


    procedure pCarregaPortador(dbeCodPor: TDBEditFocus;
                               edtDesPor: TEditFocus);

    procedure pCarregaPlanoDeContas(dbeCodCta: TDBEditFocus;
                                    edtDesCta: TEditFocus;
                                    blnTaxa: Boolean = False);

    procedure pCarregaCentroDeCustos(dbeCodEve: TDBEditFocus;
                                     edtDesEve: TEditFocus);

    procedure pCarregaFornecedor;

    procedure pPesquisarPortador(dbeCodigoPortador: TDBEditFocus; edtDescricaoPortador: TEditFocus;
                                 var Key: Char);

    procedure pPesquisarPlanoDeContas(dbeCodigoPlanoDeContas: TDBEditFocus; edtDescricaoPlanoDeContas: TEditFocus;
                                      var Key: Char; blnTaxa: Boolean = False);

    procedure pPesquisarCentroDeCustos(dbeCodigoCentroDeCustos: TDBEditFocus; edtDescricaoCentroDeCustos: TEditFocus;
                                       var Key: Char);
  public
    { Public declarations }
    strEmpresa: String;

    procedure pCarregaDados;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;

    function fVerificaCampos: Boolean;
  end;

implementation
Uses untPesqAux, untConsultas, untTypesSistema, untFuncoesSimples;
{$R *.dfm}

{ TfraDadosDeBaixaOtimizadaCartoes }

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaAjuEnter(Sender: TObject);
begin
  dbeCtaAju.Field.EditMask := '';
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaAjuExit(Sender: TObject);
begin
  If (Length(Trim(dbeCtaAju.Text)) < 7) Then
    dbeCtaAju.Field.EditMask := ''
  Else
    dbeCtaAju.Field.EditMask := '99.99.999;0;_';
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaAjuKeyPress(Sender: TObject;
  var Key: Char);
begin
  pPesquisarPlanoDeContas(dbeCtaAju, edtCtaAju, Key);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaAntEnter(Sender: TObject);
begin
  dbeCtaAnt.Field.EditMask := '';
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaAntExit(Sender: TObject);
begin
  If (Length(Trim(dbeCtaAnt.Text)) < 7) Then
    dbeCtaAnt.Field.EditMask := ''
  Else
    dbeCtaAnt.Field.EditMask := '99.99.999;0;_';
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaAntKeyPress(Sender: TObject;
  var Key: Char);
begin
  pPesquisarPlanoDeContas(dbeCtaAnt, edtCtaAnt, Key);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaBadEnter(Sender: TObject);
begin
  dbeCtaBad.Field.EditMask := '';
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaBadExit(Sender: TObject);
begin
  If (Length(Trim(dbeCtaBad.Text)) < 7) Then
    dbeCtaBad.Field.EditMask := ''
  Else
    dbeCtaBad.Field.EditMask := '99.99.999;0;_';
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaBadKeyPress(Sender: TObject;
  var Key: Char);
begin
  pPesquisarPlanoDeContas(dbeCtaBad, edtCtaBad, Key);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaCarEnter(Sender: TObject);
begin
  dbeCtaCar.Field.EditMask := '';
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaCarExit(Sender: TObject);
begin
  If (Length(Trim(dbeCtaCar.Text)) < 7) Then
    dbeCtaCar.Field.EditMask := ''
  Else
    dbeCtaCar.Field.EditMask := '99.99.999;0;_';
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaCarKeyPress(Sender: TObject;
  var Key: Char);
begin
  pPesquisarPlanoDeContas(dbeCtaCar, edtCtaCar, Key);
  If (Key = #13) Then
    fValidaCampos(edtCtaCar);
end;


procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaTaxExit(Sender: TObject);
begin
  If (Length(Trim(dbeCtaTax.Text)) < 7) Then
    dbeCtaTax.Field.EditMask := ''
  Else
    dbeCtaTax.Field.EditMask := '99.99.999;0;_';
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaTaxEnter(Sender: TObject);
begin
  dbeCtaTax.Field.EditMask := '';
end;


procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaCupKeyPress(Sender: TObject;
  var Key: Char);
begin
  pPesquisarPlanoDeContas(dbeCtaCup, edtDescricaoCupons, Key);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaFreteKeyPress(Sender: TObject;
  var Key: Char);
begin
  pPesquisarPlanoDeContas(dbeCtaFrete, edtDescricaoCtaFrete, Key);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeCtaTaxKeyPress(Sender: TObject;
  var Key: Char);
begin
  pPesquisarPlanoDeContas(dbeCtaTax, edtCtaTax, Key, True);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeEveDebKeyPress(Sender: TObject;
  var Key: Char);
begin
  pPesquisarCentroDeCustos(dbeEveDeb, edtDesEve, Key);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeEventoBaixaKeyPress(
  Sender: TObject; var Key: Char);
begin
  pPesquisarCentroDeCustos(dbeEventoBaixa, edtEventoBaixa, Key);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeEventoTaxaBaixaKeyPress(
  Sender: TObject; var Key: Char);
begin
  pPesquisarCentroDeCustos(dbeEventoTaxaBaixa, edtEventoTaxaBaixa, Key);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbeForTaxKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  If fPesqFornecedor(conForSimples, GetParentForm(Self)as TForm, dbeForTax, edtForTax, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbeForTax, True) Then
      SelectNext(dbeForTax, True, True);
  End
  Else If Key = #$D Then
    fValidaCampos(dbeForTax, True);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbePorBadKeyPress(Sender: TObject;
  var Key: Char);
begin
  pPesquisarPortador(dbePorBad, edtPorBad, Key);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbePorBaiKeyPress(Sender: TObject;
  var Key: Char);
begin
  pPesquisarPortador(dbePorBai, edtPorBai, Key);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.dbePorTaxKeyPress(Sender: TObject;
  var Key: Char);
begin
  pPesquisarPortador(dbePorTax, edtPorTax, Key);
end;

function TfraDadosDeBaixaOtimizadaCartoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    SMensagem: String;
    SEditFocus: TEditFocus;

begin
  Result := True;
  If (Sender = dbePorBai) Then
  Begin

    If (fEmptyStr(dbePorBai.Text)) Then
    Begin
      dbePorBai.Field.Clear;
      fMensagem('ATENÇÃO!', 'O portador da baixa deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaPortador(dbePorBai, edtPorBai);
      If (qryCadPor.FieldByName('POR_CODPOR').IsNull) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
        Result := False;
      End
      {*REQ*145940**********RP*}
      Else If Not fEmpresaTemAcessoPortador(dbePorBai.Text, strEmpresa) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Result := False;
      End
      Else If blnDacPor And (Pos(dbePorBai.Text, strPortadoresOperador) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
        Result := False;
      End
      Else If (Not fPortadorPermiteBaixa(dbePorBai.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
        Result := False;
      End;
    End;

  End
  Else If (Sender = dbePorTax) Then
  Begin

    If (fEmptyStr(dbePorTax.Text)) Then
    Begin
      dbePorTax.Field.Clear;
      fMensagem('ATENÇÃO!', 'O portador da taxa deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaPortador(dbePorTax, edtPorTax);
      If (qryCadPor.FieldByName('POR_CODPOR').IsNull) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
        Result := False;
      End
      {*REQ*145940**********RP*}
      Else If Not fEmpresaTemAcessoPortador(dbePorTax.Text, strEmpresa) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Result := False;
      End
      Else If blnDacPor And (Pos(dbePorTax.Text, strPortadoresOperador) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
        Result := False;
      End
      Else If (Not fPortadorPermiteBaixa(dbePorTax.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
        Result := False;
      End;
    End;

  End
  Else If (Sender = dbePorBad) Then
  Begin

    If (fEmptyStr(dbePorBad.Text)) Then
    Begin
      edtPorBad.Clear;
      dbePorBad.Field.Clear;
    End
    Else
    Begin
      pCarregaPortador(dbePorBad, edtPorBad);
      If (qryCadPor.FieldByName('POR_CODPOR').IsNull) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
        Result := False;
      End
      {*REQ*145940**********RP*}
      Else If Not fEmpresaTemAcessoPortador(dbePorBad.Text, strEmpresa) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Result := False;
      End
      Else If blnDacPor  And (Pos(dbePorBad.Text, strPortadoresOperador) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
        Result := False;
      End
      Else If (Not fPortadorPermiteBaixa(dbePorBad.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
        Result := False;
      End
      Else If Not fEmptyStr(dbePorBai.Text) And (dbePorBai.Text = dbePorBad.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O portador do Grupo de Débito não pode ser o mesmo do Grupo de Crédito!',['&O K']);
        Result := False;
      End;
    End;

  End
  Else If (Sender = dbeCtaCar) Then
  Begin
    pCarregaPlanoDeContas(dbeCtaCar, edtCtaCar);

    If fEmptyStr(dbeCtaCar.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O plano de contas da baixa deve ser preenchido!', ['&Ok']);
      dbeCtaCar.Field.Clear;
      Result := False;
    End
    Else If RightStr(dbeCtaCar.Text, 3) = '000' Then
    Begin
      fMensagem('ATENÇÃO!', dbeCtaCar.Text + ' não é um Plano de Contas válido!', ['&Ok']);
      dbeCtaCar.Field.Clear;
      Result := False;
    End

    Else If Not fEmptyStr(fTiraCaracEspeciais(dbeCtaCar.Text)) Then
    Begin
//      dbeCtaCar.Text := fStrZero(dbeCtaCar.Text,7);

      If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
      Begin
        If Not blnUsaCtf Then
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok'])
        Else
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&Ok']);

        Result := False;
      End
      Else
      Begin
        If (strPlCtaOld <> dbeCtaCar.Text) then
          Result := PlanoDeContasAtivo(dbeCtaCar.Text,True);
      End;


    End

    Else
    Begin
      edtCtaCar.Clear;
      dbeCtaCar.Field.Clear;
    End;

  End
  Else If (Sender = dbeCtaTax) Then
  Begin
    pCarregaPlanoDeContas(dbeCtaTax, edtCtaTax, True);

    If fEmptyStr(dbeCtaTax.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O plano de contas da taxa deve ser preenchido!', ['&Ok']);
      dbeCtaTax.Field.Clear;
      Result := False;
    End
    Else If RightStr(dbeCtaTax.Text, 3) = '000' Then
    Begin
      fMensagem('ATENÇÃO!', dbeCtaTax.Text + ' não é um Plano de Contas válido!', ['&Ok']);
      dbeCtaTax.Field.Clear;
      Result := False;
    End

    Else If Not fEmptyStr(fTiraCaracEspeciais(dbeCtaTax.Text)) Then
    Begin
//      dbeCtaTax.Text := fStrZero(dbeCtaTax.Text,7);

      If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
      Begin
        If Not blnUsaCtf Then
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok'])
        Else
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&Ok']);

        Result := False;
      End
      Else
      Begin
        If (strPlCtaTxBaixOld <> dbeCtaTax.Text) then
          Result := PlanoDeContasAtivo(dbeCtaTax.Text,True);
      End;
    End

    Else
    Begin
      edtCtaTax.Clear;
      dbeCtaTax.Field.Clear;
    End;

  End
  Else If (Sender = dbeCtaBad) Then
  Begin
    pCarregaPlanoDeContas(dbeCtaBad, edtCtaBad);

    If RightStr(dbeCtaBad.Text, 3) = '000' Then
    Begin
      fMensagem('ATENÇÃO!', dbeCtaBad.Text + ' não é um Plano de Contas válido!', ['&Ok']);
      dbeCtaBad.Field.Clear;
      Result := False;
    End

    Else If Not fEmptyStr(fTiraCaracEspeciais(dbeCtaBad.Text)) Then
    Begin
//      dbeCtaBad.Text := fStrZero(dbeCtaBad.Text,7);

      If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
      Begin
        If Not blnUsaCtf Then
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok'])
        Else
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&Ok']);

        Result := False;
      End
      Else
      Begin
        If (strPlCtaBaixOld <> dbeCtaBad.Text) then
          Result := PlanoDeContasAtivo(dbeCtaBad.Text,True);
      End;
    End


    Else
    Begin
      edtCtaBad.Clear;
      dbeCtaBad.Field.Clear;
    End;

  End

  Else If (Sender = dbeCtaAju) Then
  Begin
    pCarregaPlanoDeContas(dbeCtaAju, edtCtaAju);

    If RightStr(dbeCtaAju.Text, 3) = '000' Then
    Begin
      fMensagem('ATENÇÃO!', dbeCtaAju.Text + ' não é um Plano de Contas válido!', ['&Ok']);
      dbeCtaAju.Field.Clear;
      Result := False;
    End

    Else If Not fEmptyStr(fTiraCaracEspeciais(dbeCtaAju.Text)) Then
    Begin
//      dbeCtaAju.Text := fStrZero(dbeCtaAju.Text,7);

      If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
      Begin
        If Not blnUsaCtf Then
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok'])
        Else
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&Ok']);

        Result := False;
      End
      Else
      Begin
        If (strPlCtaCancOld <> dbeCtaAju.Text) then
          Result := PlanoDeContasAtivo(dbeCtaAju.Text,True);
      End;


    End

    Else
    Begin
      edtCtaAju.Clear;
      dbeCtaAju.Field.Clear;
    End;

  End

  Else If (Sender = dbeCtaAnt) Then
  Begin
    pCarregaPlanoDeContas(dbeCtaAnt, edtCtaAnt);

    If RightStr(dbeCtaAnt.Text, 3) = '000' Then
    Begin
      fMensagem('ATENÇÃO!', dbeCtaAnt.Text + ' não é um Plano de Contas válido!', ['&Ok']);
      dbeCtaAju.Field.Clear;
      Result := False;
    End

    Else If Not fEmptyStr(fTiraCaracEspeciais(dbeCtaAnt.Text)) Then
    Begin
//      dbeCtaAnt.Text := fStrZero(dbeCtaAnt.Text,7);

      If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
      Begin
        If Not blnUsaCtf Then
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok'])
        Else
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&Ok']);

        Result := False;
      End
      Else
      Begin
        If (strPlCtaAntOld <> dbeCtaAnt.Text) then
          Result := PlanoDeContasAtivo(dbeCtaAnt.Text,True);
      End;

    End

    Else
    Begin
      edtCtaAnt.Clear;
      dbeCtaAnt.Field.Clear;
    End;

  End

  Else If (Sender = dbeCtaFrete) Then
  Begin
    If grpFretes.Visible Then
    Begin
      If RightStr(dbeCtaFrete.Text, 3) = '000' Then
      Begin
        fMensagem('ATENÇÃO!', dbeCtaFrete.Text + ' não é um Plano de Contas válido!', ['&Ok']);
        dbeCtaAju.Field.Clear;
        Result := False;
      End

      Else If Not fEmptyStr(fTiraCaracEspeciais(dbeCtaFrete.Text)) Then
      Begin
        dbeCtaFrete.Text := fStrZero(dbeCtaFrete.Text,7);

        pCarregaPlanoDeContas(dbeCtaFrete, edtDescricaoCtaFrete);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          If Not fCfgSis('USACTF', varBoolean) Then
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok'])
          Else
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&Ok']);

          Result := False;
        End
        Else
        Begin
          If (strPlCtaFreteOld <> dbeCtaFrete.Text) then
            Result := PlanoDeContasAtivo(dbeCtaFrete.Text,True);
        End;

      End

      Else
      Begin
        edtDescricaoCtaFrete.Clear;
        dbeCtaFrete.Field.Clear;
      End;
    End;

  End

  Else If (Sender = dbeCtaCup) Then
  Begin
    If grpCupons.Visible Then
    Begin
      If RightStr(dbeCtaCup.Text, 3) = '000' Then
      Begin
        fMensagem('ATENÇÃO!', dbeCtaCup.Text + ' não é um Plano de Contas válido!', ['&Ok']);
        dbeCtaAju.Field.Clear;
        Result := False;
      End

      Else If Not fEmptyStr(fTiraCaracEspeciais(dbeCtaCup.Text)) Then
      Begin
        dbeCtaCup.Text := fStrZero(dbeCtaCup.Text,7);

        pCarregaPlanoDeContas(dbeCtaCup, edtDescricaoCupons);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          If Not fCfgSis('USACTF', varBoolean) Then
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok'])
          Else
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&Ok']);

          Result := False;
        End;

      End

      Else
      Begin
        edtDescricaoCupons.Clear;
        dbeCtaCup.Field.Clear;
      End;
    End;

  End

  Else If (Sender = dbeForTax) Then
  Begin

    If (fEmptyStr(dbeForTax.Text)) Then
    Begin
      dbeForTax.Field.Clear;
      fMensagem('ATENÇÃO!','O fornecedor da taxa deve ser preenchido!',['&OK']);
      Result := False;
    End Else
    Begin
      pCarregaFornecedor;
      If qryCadFor.FieldByName('FOR_CODFOR').IsNull Then
      Begin
        fMensagem('ATENÇÃO!','Esse fornecedor não está cadastrado!',['&OK']);
        Result := False;
      End;
    End;

  End

  Else If ((Sender = dbeEventoBaixa) or (Sender = dbeEventoTaxaBaixa) or (sender =  dbeEveDeb)) then
  begin

    if fEmptyStr(TDBEditFocus(sender).Text) and blnCtpObe Then
    Begin
      SMensagem := '';
      if Sender = dbeEventoBaixa then
        SMensagem := 'O campo Centro de Custos do crédito deve ser preenchido.'
      else
      if Sender =  dbeEventoTaxaBaixa then
        SMensagem := 'O campo Centro de Custos da taxa deve ser preenchido.'
      else
      if not fEmptyStr(dbePorBad.text) then
        SMensagem := 'O campo Centro de Custos do débito deve ser preenchido.';

      if not fEmptyStr(SMensagem) then
      begin
        fMensagem('ATENÇÃO!', SMensagem, ['&Ok']);
        pSetFocus(Sender);
        Exit(False);
      end;
    End;

    if Sender = dbeEventoBaixa then
      SEditFocus := edtEventoBaixa
    else
    if Sender = dbeEventoTaxaBaixa then
      SEditFocus := edtEventoTaxaBaixa
    else
      SEditFocus := edtDesEve;

    If Not fEmptyStr(TDBEditFocus(sender).Text) Then
    Begin
      TDBEditFocus(sender).Text := fStrZero(TDBEditFocus(sender).Text,5);
      pCarregaCentroDeCustos(TDBEditFocus(sender), SEditFocus);

      If qryCadEve.FieldByName('EVE_CODEVE').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&Ok']);
        pSetFocus(sender);
        Exit(False);
      End;

      If (sender = dbeEveDeb) and (Result) And (fEmptyStr(edtPorBad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para utilizar o Centro de Custos de débito é necessário selecionar '+
          'Portador e Plano de Contas de débito!', ['&Ok']);
        Exit(False);
      End;

    End
    Else
    Begin
      SEditFocus.Clear;
      TDBEditFocus(sender).Field.Clear;
    End;

  end;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfraDadosDeBaixaOtimizadaCartoes.fVerificaCampos: Boolean;
  Var
    LContadorDBEdits: Integer;
begin
  Result := True;
  For LContadorDBEdits := 0 To Self.ComponentCount - 1 Do
  Begin
    If (Self.Components[LContadorDBEdits] Is TDBEditFocus) Then
      Result := fValidaCampos(TDBEditFocus(Self.Components[LContadorDBEdits]));

    If Not Result Then
      Exit;
  End;
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.OnFormCreate(Sender: TObject);
begin
  qryCadPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);
  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryCadFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryCadEve := fCriarQuery('SELECT * FROM CADEVE WHERE FALSE', Self);

  blnUsaCtf := fCfgSis('USACTF', varBoolean);
  blnDacPor := fCfgSis('DACPOR', varBoolean);
  blnCtpObe := fCfgSis('CTPOBE', varBoolean);
end;



procedure TfraDadosDeBaixaOtimizadaCartoes.OnFormShow(Sender: TObject);
begin
  strPlCtaOld        := dbeCtaCar.Text;
  strPlCtaTxBaixOld  := dbeCtaTax.Text;
  strPlCtaBaixOld    := dbeCtaBad.Text;
  strPlCtaCancOld    := dbeCtaAju.Text;
  strPlCtaAntOld     := dbeCtaAnt.Text;
  strPlCtaFreteOld   := dbeCtaFrete.Text;
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.pCarregaPlanoDeContas(
  dbeCodCta: TDBEditFocus; edtDesCta: TEditFocus; blnTaxa: Boolean = False);
begin
  dbeCodCta.Field.Text := IIF(fEmptyStr(dbeCodCta.Text),dbeCodCta.Text,fGetPlanoDeContas(dbeCodCta.Text));

  If (blnTaxa) Then
    pPesquisaCadCta(qryCadCta, qryCadCta, dbeCodCta.Text, blnUsaCtf, dbeForTax.Text)
  Else
    pPesquisaCadCta(qryCadCta, qryCadCta, dbeCodCta.Text);

  edtDesCta.Text := IIF(fEmptyStr(dbeCodCta.Text), '', qryCadCta.FieldByName('CTA_DESCTA').AsString);

  If (Length(Trim(dbeCodCta.Text)) < 7) Then
    dbeCodCta.Field.EditMask := ''
  Else
    dbeCodCta.Field.EditMask := '99.99.999;0;_';
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.pCarregaCentroDeCustos(dbeCodEve: TDBEditFocus;
  edtDesEve: TEditFocus);
begin
  pPesquisaCadEve(qryCadEve, qryCadEve, dbeCodEve.Text);

  edtDesEve.Text := IIF(fEmptyStr(dbeCodEve.Text), '', qryCadEve.FieldByName('EVE_DESEVE').AsString);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.pCarregaDados;
begin
  pCarregaFornecedor;
  pCarregaPortador(dbePorBai, edtPorBai);
  pCarregaPortador(dbePorTax, edtPorTax);
  pCarregaPortador(dbePorBad, edtPorBad);
  pCarregaPlanoDeContas(dbeCtaCar, edtCtaCar);
  pCarregaPlanoDeContas(dbeCtaTax, edtCtaTax);
  pCarregaPlanoDeContas(dbeCtaBad, edtCtaBad);
  pCarregaPlanoDeContas(dbeCtaAju, edtCtaAju);
  pCarregaPlanoDeContas(dbeCtaAnt, edtCtaAnt);
  pCarregaPlanoDeContas(dbeCtaFrete, edtDescricaoCtaFrete);
  pCarregaPlanoDeContas(dbeCtaCup, edtDescricaoCupons);
  pCarregaCentroDeCustos(dbeEveDeb, edtDesEve);
  pCarregaCentroDeCustos(dbeEventoBaixa, edtEventoBaixa);
  pCarregaCentroDeCustos(dbeEventoTaxaBaixa, edtEventoTaxaBaixa);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryCadFor,  qryCadFor, dbeForTax.Text);
  edtForTax.Text := IIF(fEmptyStr(dbeForTax.Text), '', qryCadFor.FieldByName('FOR_NOMFOR').AsString);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.pCarregaPortador(dbeCodPor: TDBEditFocus;
  edtDesPor: TEditFocus);
begin
  pPesquisaCadPor(Nil, qryCadPor, dbeCodPor.Text);
  edtDesPor.Text := IIF(fEmptyStr(dbeCodPor.Text), '', qryCadPor.FieldByName('POR_NOMPOR').AsString);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.pPesquisarCentroDeCustos(
  dbeCodigoCentroDeCustos: TDBEditFocus; edtDescricaoCentroDeCustos: TEditFocus; var Key: Char);
  Var
    arrEvento: TConsultasArray;
begin
  If fPesqEventos(GetParentForm(Self)as TForm,dbeCodigoCentroDeCustos, edtDescricaoCentroDeCustos, Nil, Key, arrEvento) Then
  Begin
    If fValidaCampos(dbeCodigoCentroDeCustos, True) Then
      SelectNext(dbeCodigoCentroDeCustos, True, True);
  End
  Else If Key = #$D Then
    fValidaCampos(dbeCodigoCentroDeCustos, True);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.pPesquisarPlanoDeContas(
  dbeCodigoPlanoDeContas: TDBEditFocus; edtDescricaoPlanoDeContas: TEditFocus; var Key: Char;
  blnTaxa: Boolean);
  Var
    arrCentroCusto : TConsultasArray;
begin
  If (blnTaxa) Then
    fPesqCentroCusto(GetParentForm(Self)as TForm, dbeCodigoPlanoDeContas, edtDescricaoPlanoDeContas, Nil, Key, arrCentroCusto, True, blnUsaCtf, dbeForTax.Field.AsString)
  Else
    fPesqCentroCusto(GetParentForm(Self)as TForm, dbeCodigoPlanoDeContas, edtDescricaoPlanoDeContas, Nil, Key, arrCentroCusto);

  If Key = #$D Then
    fValidaCampos(dbeCodigoPlanoDeContas, True);
end;

procedure TfraDadosDeBaixaOtimizadaCartoes.pPesquisarPortador(dbeCodigoPortador: TDBEditFocus; edtDescricaoPortador: TEditFocus;
                                                              var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqPortador(conSimples,
                   GetParentForm(Self)as TForm,
                   dbeCodigoPortador,
                   edtDescricaoPortador,
                   qryCadPor,
                   Key,
                   arrSel,
                   True,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   strEmpresa) Then
  Begin
    if fValidaCampos(dbeCodigoPortador, True) then
      Self.SelectNext(dbeCodigoPortador, True, True);
  End
  Else If Key = #$D Then
    fValidaCampos(dbeCodigoPortador, True);
end;

end.
