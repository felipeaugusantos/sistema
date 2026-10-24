{***************************}
{* qryConPor -> CADPOR     *}
{* qryConBco -> CADBCO     *}
{************************JB*}
{***************************}
{* qryCadBco -> CADBCO     *}
{************************RV*}
unit untFatDigBancoBoleto;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Uni,
  ExtCtrls, EditFocus, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatDigBancoBoleto = class(TfrmPaiSimples)
    edtCodPor: TEditFocus;
    Label5: TLabel;
    Label3: TLabel;
    edtCodBco: TEditFocus;
    Label4: TLabel;
    edtNosNum: TEditFocus;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    edtNomPor: TEditFocus;
    edtNomBan: TEditFocus;
    pnlFundo: TPanel;
    chkBolPdf: TCheckBox;
    chkEnvMai: TCheckBox;
    procedure edtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCodBcoExit(Sender: TObject);
    procedure chkBolPdfClick(Sender: TObject);
  private
    { Private declarations }
    qryCadBco    : TUniQuery;
    qryConBco    : TUniQuery;
    qryConPor    : TUniQuery;
    strPathAutban: String;

    procedure pCarregaBanco;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strBanRet  : String;
    intCarRet  : Integer;
    blnBolPdf  : Boolean;
    blnEnvMai  : Boolean;
    blnMsmCli  : Boolean;
    
    procedure pCarregaPortador;
    procedure pOnCodBcoExit;
  end;


implementation

uses  untFuncoes, untPesqAux, untTypesSistema,
      untConstantes,untFuncoesSimples, untConsultas;

{$R *.dfm}

procedure TfrmFatDigBancoBoleto.edtCodBcoExit(Sender: TObject);
begin
  inherited;
  pOnCodBcoExit;
end;

procedure TfrmFatDigBancoBoleto.pOnCodBcoExit;
  Var
    strNosNum: String;
begin
  pCarregaBanco;

  {***************************************************}
  {* FUNCAO QUE VERIFICA SE O CLIENTE POSSUI MAIS DE *}
  {* UM BANCO CONFIGURADO, SE SIM ENTAO DEVE CHAMAR  *}
  {* UM GET MENU PARA QUE O CLIENTE O SELECIONE.     *}
  {************************************************ED*}
  If (Pos(edtCodBco.Text,'999_888_777') <= 0) Then
  Begin
    If  fVer_Banco_Carteira(edtCodBco.Text, '', strBanRet, intCarRet) Then
    Begin

      If edtCodBco.Text = '001' Then
      Begin
        strNosNum := fCfgSis('NOSNUM', varString);

        If (fEmptyStr(strNosNum)) Or (strNosNum = '1') Then
          edtNosNum.Text := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,11)
        Else
          edtNosNum.Text := fStrZero(qryConBco.FieldByName('BCO_PRONU7').AsString,11);
      End
      Else If (edtCodBco.Text = '104') Or
              (edtCodBco.Text = '041') Then
      Begin

        If fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBanRet + '-' + IntToStr(intCarRet), 'NUMNOSS', '')) Or
                    (fGetBancoConfig(0, 'CONFIG' + strBanRet + '-' + IntToStr(intCarRet), 'NUMNOSS', '') = '1') Then
          edtNosNum.Text := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,11)
        Else
          edtNosNum.Text := fStrZero(qryConBco.FieldByName('BCO_PRONU7').AsString,11);

      End

      Else If (edtCodBco.Text = '756') Then
      Begin

        If fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBanRet + '-' + IntToStr(intCarRet), 'NUMNOSS', '')) Or
                    (fGetBancoConfig(0, 'CONFIG' + strBanRet + '-' + IntToStr(intCarRet), 'NUMNOSS', '') = '1') Then
          edtNosNum.Text := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,7)
        Else
          edtNosNum.Text := fStrZero(qryConBco.FieldByName('BCO_PRONU7').AsString,7);

      End

      Else
        edtNosNum.Text := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,11);

    End;
  End
  Else
    edtNosNum.Text := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,11);
end;

procedure TfrmFatDigBancoBoleto.edtCodBcoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrBancos: TConsultasArray;

begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  If fPesqBanco(Self, edtCodBco, edtNomBan, qryTabela, Key, arrBancos) Then
  Begin
    if fValidaCampos(edtCodBco, True) then
      SelectNext(ActiveControl, True, True);
    pCarregaBanco;
  End;

end;

procedure TfrmFatDigBancoBoleto.pCarregaBanco;
begin
  pPesquisaCadBco(qryCadBco, qryConBco, edtCodBco.Text);
  With qryConBco Do
  Begin
    edtNomBan.Text := FieldByName('BCO_NOMBCO').AsString;
  End;
end;

procedure TfrmFatDigBancoBoleto.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtNomPor.Text := FieldByName('POR_NOMPOR').AsString;

    If Not fEmptyStr(FieldByName('POR_CODBCO').AsString) Then
    Begin
      edtCodBco.Text := FieldByName('POR_CODBCO').AsString;
      edtCodBco.ReadOnly := True;
      pCarregaBanco;
    End
    Else
      edtCodBco.ReadOnly := False;
  End;
end;

procedure TfrmFatDigBancoBoleto.FormCreate(Sender: TObject);
begin

  inherited;
  qryConPor := fCriaQuery(Self);
  qryCadBco := fCriaQuery(Self);
  qryConBco := qryCadBco;

  blnConfirma := False;

  edtCodBco.Text := fCfgSis('BANBOL');

  If Not fEmptyStr(edtCodBco.Text) Then
    pCarregaBanco;

  strPathAutban := ExtractFilePath(Application.ExeName) + 'Autban\' + ARQCNFBCO;
end;

procedure TfrmFatDigBancoBoleto.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigBancoBoleto.btnConfirmaDadosClick(Sender: TObject);
  Var
    strNosNumAtu: String;
begin
  If Not fValidaCampos(edtCodBco, True) Then
    Exit;

  strNosNumAtu := edtNosNum.Text;

  If fVerificaCampos Then
  Begin
    blnBolPdf := chkBolPdf.Checked;
    blnEnvMai := chkEnvMai.Checked;

    If (intCarRet <= 0)          And
       (edtCodBco.Text <> '999') And
       (edtCodBco.Text <> '888') And
       (edtCodBco.Text <> '778') Then
    Begin
      blnConfirma    := False;
      pMensagemOk('Não foi escolhida nenhuma carteira. Será necessário realizar a impressão individual do boleto.');
    End
    Else
    Begin
      edtNosNum.Text := strNosNumAtu;
      blnConfirma    := True;
    End;
    Close;
  End;
end;

procedure TfrmFatDigBancoBoleto.chkBolPdfClick(Sender: TObject);
begin
  inherited;

  If chkBolPdf.Checked Then
  Begin
    If (blnMsmCli) Then
      chkEnvMai.Enabled := True
    Else
      chkEnvMai.Enabled := False;
  End
  Else
    chkEnvMai.Enabled := False;
end;

function TfrmFatDigBancoBoleto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
  strRetBco: String;
  intRetCar: Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O PORTADOR                     *}
    {**************************************MV*}
    If (Sender = edtCodPor) Then
    Begin
      If fEmptyStr(edtCodPor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Portador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaPortador;
        If qryConPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If Not fPortadorPermiteBoletoFaturamento(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não é permitido para impressão de boletos no Faturamento!', ['&O k']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O BANCO                        *}
    {**************************************MV*}
    Else If (Sender = edtCodBco) Then
    Begin
      If fEmptyStr(edtCodBco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Banco deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (edtCodBco.Text <> '778') And (fCfgSisL('BOLFAT') = 'M') And (Not fValidaBancoCnf(edtCodBco.Text, 'CNFBOL')) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse banco não está preparado para a impressão de Boleto!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If (edtCodBco.Text <> '778') And (fCfgSisL('BOLFAT') = 'L') And (Pos(edtCodBco.Text, BANCOS_LASER) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse banco não está preparado para a impressão de Boleto Laser!', ['&O k']);
            Result := False;
          End
          Else
          Begin

            If (edtCodBco.Text <> '999') And (edtCodBco.Text <> '888') And (edtCodBco.Text <> '778') Then
            Begin
              If (edtCodBco.Text = '777') Or fVer_Banco_Carteira(edtCodBco.Text, '', strRetBco, intRetCar, False) Then
              Begin
                If fGetBancoConfig(0,'CONFIG' + strRetBco + '-1','RESPONS', strPathAutban) = 'B' Then
                Begin
                  fMensagem('ATENÇÃO','Esse banco está configurado como responsável pela impressão dos boletos!',['&O K'] );
                  Result := False;
                End
                Else
                Begin
                  pCarregaBanco;
                  If qryConBco.FieldByName('BCO_CODBCO').IsNull Then
                  Begin
                    fMensagem('ATENÇÃO!', 'Esse Banco não está cadastrado!', ['&O k']);
                    Result := False;
                  End;
                End;
              End;
            End;

          End;
        End;
      End;

    End

    {*****************************************}
    {* VALIDA O NOSSO NÚMERO                 *}
    {**************************************MV*}
    Else If (Sender = edtNosNum) Then
    Begin
      If fEmptyStr(edtNosNum.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nosso Número deve ser preenchido!', ['&O k']);
        Result := False;
      End

    End

    Else If (Sender = chkBolPdf) Then
    Begin
      If chkBolPdf.Checked And (Pos(edtCodBco.Text, BANCOS_PDFMAIL) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A geração para PDF do banco ' + edtCodBco.Text + ' está em construção!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = chkEnvMai) Then
    Begin
      If chkEnvMai.Checked And (Pos(edtCodBco.Text, BANCOS_PDFMAIL) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O envio de E-Mail do banco ' + edtCodBco.Text + ' está em construção!', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigBancoBoleto.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, qryConPor, Key, arrSel,
    True, 'Consulta de Portadores', 'S') Then
  Begin
    If fValidaCampos(edtCodPor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatDigBancoBoleto.FormShow(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(edtCodPor.Text) Or (Not fCfgSis('PORPED', VarBoolean))) Then
    If Not fEmptyStr(fRetNomPortador(fCfgSis('PORBOL'))) Then
      edtCodPor.Text := fCfgSis('PORBOL');

  If (Not fEmptyStr(edtCodPor.Text)) Then
    pCarregaPortador;

  If (Not fCfgSis('ALPTBL', varBoolean)) Then
  Begin
    edtCodPor.Enabled := False;
    If edtCodBco.Enabled Then
      pSetFocus(edtCodBco)
    Else
      pSetFocus(edtNosNum);  
  End;

  If fCfgSis('NROBOL', varBoolean) Then
    edtNosNum.Enabled := True
  Else
    edtNosNum.Enabled := False;

  If (Not fEmptyStr(edtCodPor.Text)) And
     (Not fEmptyStr(edtCodBco.Text)) And
          fEmptyStr(edtNosNum.Text) Then
  Begin
    pOnCodBcoExit;
  End;

end;

end.

