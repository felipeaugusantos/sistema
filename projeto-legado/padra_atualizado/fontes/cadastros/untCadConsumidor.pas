{***************************}
{* qryConCid -> CADCID     *}
{* qryConCon -> CADCON     *}
{************************JB*}
unit untCadConsumidor;

interface

uses
  Windows, Classes, Controls, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, EditFocus, DBCtrls, DBEditFocus, Uni, DB, AppEvnts,
  untFuncoesGenerica, untLabelCgcCpf, untDBECgcCpf, untDBETipoCgcCpf, untLabelRg,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadConsumidor = class(TfrmPaiCad)
    pnlDadosCons: TPanel;
    Label8: TLabel;
    dbeCodCon: TDBEditFocus;
    Label10: TLabel;
    dbeNomCon: TDBEditFocus;
    Label11: TLabel;
    dbeEndere: TDBEditFocus;
    Label12: TLabel;
    dbeBairro: TDBEditFocus;
    Label13: TLabel;
    dbeCodCid: TDBEditFocus;
    Label14: TLabel;
    edtEstado: TEditFocus;
    Label15: TLabel;
    dbeNumCep: TDBEditFocus;
    dbeNumRg: TDBEditFocus;
    lblIncEst: TLabel;
    dbeNumIes: TDBEditFocus;
    Label19: TLabel;
    dbeFone02: TDBEditFocus;
    edtNomCid: TEditFocus;
    dtsTabela: TDataSource;
    LabelCgcCpf1: TLabelCgcCpf;
    lblRG: TLabelRg;
    Panel1: TPanel;
    dbeCgcCpf: TDBEditTipoCgcCpf;
    dbeNuCpnj: TDBEditCgcCpf;
    dbeEmail: TDBEditFocus;
    lbl1: TLabel;
    btnCadCli: TBitBtnLocked;
    btnAltPar: TBitBtnLocked;
    Label21: TLabel;
    dbeNasCon: TDBEditFocus;
    dbeCelula: TDBEditFocus;
    lblCelular: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    function dbeCodCidChamaCadastro(Key: Word): String;
    procedure dbeCgcCpfChange(Sender: TObject);
    procedure dbeCgcCpfExit(Sender: TObject);
    procedure dbeNumCepKeyPress(Sender: TObject; var Key: Char);
    procedure btnCadCliClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAltParClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryConCid: TUniQuery;
    strCepAnt: String;

    FPais: TPais;

    procedure pCarregaCidade(qryConsulta: TUniQuery; edtCidade, edtEstado: TEdit; dbeCidade, dbeCep: TDBEditFocus);
    procedure pCarregaConsumidor;
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pAfterOpen(DataSet: TDataSet);

  protected
    { Protected declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

implementation

Uses SysUtils, Forms, strUtils, untPai, untFuncoesSimples, untConsultas,
  untPesqAux, untCadCidades, untCadClientes, untCadCid, untFuncIns2,
  untLogAlteracaoParticipante, untCadAltPar, untTypesSistema;

{$R *.dfm}

procedure TfrmCadConsumidor.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CLICON';
  strNomeCampo := 'CON_CODCON';

  qryTabela := fCriarQuery('SELECT * FROM CLICON WHERE FALSE', Self);
  qryTabela.AfterOpen := pAfterOpen;
  qryTabela.AfterScroll := pAfterScroll;
  dtsTabela.DataSet := qryTabela;

//  SetLength(arrCamposChave, 1);
//  arrCamposChave[0] := dbeCodCon;

  strCepAnt := '';

  FPais := fSetaPais;

  If (FPais = opcParaguai) Then
    dbeNuCpnj.Tag := 99;

end;

procedure TfrmCadConsumidor.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    TStringField(FieldbyName('CON_C_E_P_')).EditMask := '99999-999;0;_';
    TStringField(FieldbyName('CON_FONE01')).EditMask := fRetMascaraFonePais;
    TStringField(FieldbyName('CON_CELULA')).EditMask := fRetMascaraFonePais;
    FieldByName('AUTOINCREM').Visible := False;
  End;
end;

procedure TfrmCadConsumidor.pAfterScroll(DataSet: TDataSet);
Begin
  If (dbeCgcCpf.Text = '1') Then
    qryTabela.FieldByName('CON_C_P_F_').EditMask := fRetMascaraC_G_C_(FPais, C_G_C_);

  If (dbeCgcCpf.Text = '2') Then
    qryTabela.FieldByName('CON_C_P_F_').EditMask := fRetMascaraC_G_C_(FPais, C_P_F_);
End;

procedure TfrmCadConsumidor.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CON_CODEMP');
  stlCampos.Add('CON_NOMCON');
  stlCampos.Add('CON_ENDERE');
  stlCampos.Add('CON_BAIRRO');
  stlCampos.Add('CON_C_E_P_');
  stlCampos.Add('CON_CODCID');
  stlCampos.Add('CON_FONE01');
  stlCampos.Add('CON_C_P_F_');
  stlCampos.Add('CON_NUMR_G');
  stlCampos.Add('CON_I_E_S_');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CON_NOMCON+CON_ENDERE+CID_NOMCID');
  stlCamInd.Add('CON_C_P_F_');

  stlDesInd.Add('Nome / Endereço / Cidade');
  stlDesInd.Add('CPF');

  qryConCid := fCriaQuery(Self);
end;

procedure TfrmCadConsumidor.btnAltParClick(Sender: TObject);
var
  frmCadAltPar : TfrmCadAltPar;
begin
  inherited;
  If (qryTabela.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um Consumidor!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadAltPar, frmCadAltPar);
    frmCadAltPar.strTipoPart := 'S';
    frmCadAltPar.strCodPart  := Copy(qryTabela.FieldByName('AUTOINCREM').AsString, 10, 8);

    frmCadAltPar.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmCadAltPar);
end;

procedure TfrmCadConsumidor.btnCadCliClick(Sender: TObject);
  Var
    strCodCli: String;

    function fExisteCnpjCpfCliente(Var strCodCli: String; strCodigo, strEstado: String): Boolean;
      Var
        strSQL   : String;
        qryGenTmp: TUniQuery;
    Begin
      Try
        Result := False;
        If (strEstado = 'EX') Then
          Exit;
        qryGenTmp := fCriaQuery;
        If Not fEmptyStr(strCodigo) Then
        Begin

          strSQL := '';
          strSQL := strSQL + ' SELECT                 ';
          strSQL := strSQL + '   CLI_CODCLI           ';
          strSQL := strSQL + ' FROM                   ';
          strSQL := strSQL + '   CADCLI               ';
          strSQL := strSQL + ' WHERE                  ';
          strSQL := strSQL + '   CLI_C_G_C_ = :CODIGO ';

          With qryGenTmp Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODIGO').AsString := strCodigo;
            Open;

            If Not IsEmpty Then
            Begin
              strCodCli := FieldByName('CLI_CODCLI').AsString;
              fMensagem('ATENÇÃO','Já existe o CNPJ / CPF cadastrado para o Código: ' + #13 +
                                  strCodCli + ' no Cadastro de Clientes!',['&OK']);
              Result := True;
            End;
            Close;
          End;
        End;
      Finally
        FreeAndNil(qryGenTmp);
      End;
    End;

begin
  inherited;
  strCodCli := '';
  If (Not btnCadCli.Enabled) Then
    Exit;

  If (qryTabela.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um registro!', ['&Ok']);
    Exit;
  End;

  If (fEmptyStr(dbeCodCon.Text)) And (dbeCodCon.Enabled) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
    Exit;
  End;

  If fEmptyStr(dbeNomCon.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Nome deve ser preenchido!', ['&Ok']);
    Exit;
  End;

  If (fEmptyStr(dbeCgcCpf.Text)) Or (dbeCgcCpf.Text = '0') Then
  Begin
    fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
    Exit;
  End
  Else If Not fValidaCnpjCpf(dbeCgcCpf.Text, dbeNuCpnj.Text, False, True) Then
  Begin
    fMensagem('ATENÇÃO!', 'CNPJ / CPF inválido!', ['&Ok']);
    Exit;
  End;

  If (Not fExisteCnpjCpfCliente(strCodCli, dbeNuCpnj.Text, edtEstado.Text)) Then
  Begin
    If (fMensagem('AVISO', 'Confirma a Geração do Cadastro de Clientes?', ['&Sim', '&Não']) = 2) Then
      Exit;

    If TfrmCadClientes.fCadastroRapidoCliente(strCodCli,
                                              dbeNomCon.Text,
                                              dbeNomCon.Text,
                                              dbeEndere.Text,
                                              '',
                                              '',
                                              dbeBairro.Text,
                                              dbeCodCid.Text,
                                              dbeNumCep.Text,
                                              dbeFone02.Text,
                                              dbeCelula.Text,
                                              dbeNumRg.Text,
                                              '',
                                              dbeEmail.Text,
                                              '',
                                              'A',
                                              '',
                                              StrToInt(dbeCgcCpf.Text),
                                              dbeNuCpnj.Text,
                                              '',
                                              '') Then
    fMensagem('ATENÇÃO!', 'Geração concluída com sucesso!' + #13 +
                          'Cadastro de Clientes criado com o Código: ' + strCodCli, ['&Ok']);
  End
  Else
  Begin
    If (fMensagem('AVISO', 'Confirma a Atualização do Cadastro de Clientes?', ['&Sim', '&Não']) = 2) Then
      Exit;

    If TfrmCadClientes.fCadastroRapidoCliente(strCodCli,
                                              dbeNomCon.Text,
                                              dbeNomCon.Text,
                                              dbeEndere.Text,
                                              '',
                                              '',
                                              dbeBairro.Text,
                                              dbeCodCid.Text,
                                              dbeNumCep.Text,
                                              dbeFone02.Text,
                                              dbeCelula.Text,
                                              dbeNumRg.Text,
                                              '',
                                              dbeEmail.Text,
                                              '',
                                              'A',
                                              '',
                                              StrToInt(dbeCgcCpf.Text),
                                              dbeNuCpnj.Text,
                                              '',
                                              '') Then
    fMensagem('ATENÇÃO!', 'Atualização concluída com sucesso!', ['&Ok']);
  End;
end;

procedure TfrmCadConsumidor.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadConsumidor.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadConsumidor.btnGravarClick(Sender: TObject);
  Var
    dtsEstado: TDataSetState;
    strNomAnt: String;
    strCidAnt: String;
    strCgcAnt: String;
    strIesAnt: String;
    strEndAnt: String;
    strBaiAnt: String;
begin
  dtsEstado := qryTabela.State;

  If dtsEstado = dsEdit Then
  Begin
    strNomAnt := IfNull(qryTabela.FieldByName('CON_NOMCON').OldValue, '');
    strCidAnt := IfNull(qryTabela.FieldByName('CON_CODCID').OldValue, '');
    strCgcAnt := IfNull(qryTabela.FieldByName('CON_C_P_F_').OldValue, '');
    strIesAnt := IfNull(qryTabela.FieldByName('CON_I_E_S_').OldValue, '');
    strEndAnt := IfNull(qryTabela.FieldByName('CON_ENDERE').OldValue, '');
    strBaiAnt := IfNull(qryTabela.FieldByName('CON_BAIRRO').OldValue, '');
  End;
    
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadConsumidor.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    blnGravou := False;

    Try
      If dtsEstado = dsEdit Then
      Begin
        pAlteracaoDadosParticipante(caNome, qryTabela.FieldByName('CON_CODCON').AsString, 'S',
          qryTabela.FieldByName('CON_NOMCON').AsString, strNomAnt);

        pAlteraCidade(qryTabela.FieldByName('CON_CODCON').AsString, 'S',
          qryTabela.FieldByName('CON_CODCID').AsString, strCidAnt);

        pAlteraCnpjOuCpf(qryTabela.FieldByName('CON_CODCON').AsString, 'S',
          qryTabela.FieldByName('CON_C_P_F_').AsString, strCgcAnt);

        pAlteracaoDadosParticipante(caIES, qryTabela.FieldByName('CON_CODCON').AsString, 'S',
          qryTabela.FieldByName('CON_I_E_S_').AsString, strIesAnt);

        pAlteracaoDadosParticipante(caEndereco, qryTabela.FieldByName('CON_CODCON').AsString, 'S',
          qryTabela.FieldByName('CON_ENDERE').AsString, strEndAnt);

        pAlteracaoDadosParticipante(caBairro, qryTabela.FieldByName('CON_CODCON').AsString, 'S',
          qryTabela.FieldByName('CON_BAIRRO').AsString, strBaiAnt);
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[btnGravarClick]');
      End;
    End;
  End
  Else
    fRollBack;
end;

procedure TfrmCadConsumidor.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
  Begin
    If (dbeCgcCpf.Visible) Then
      pHabilitaCodigo(dbeCodCon, dbeCgcCpf, False)
    Else
      pHabilitaCodigo(dbeCodCon, dbeNuCpnj, False);
  End
  Else
    pHabilitaCodigo(dbeCodCon, dbeCodCon, True);

  If (Not dbeCgcCpf.Visible) Then
    pSetFocus(dbeNuCpnj);

end;

procedure TfrmCadConsumidor.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodCon, dbeNomCon, False);

  dbeNuCpnj.Enabled := False;
  dbeCgcCpf.Enabled := False;
end;

procedure TfrmCadConsumidor.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

function TfrmCadConsumidor.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    strCodCid: String;
    strEndere: String;
    strBairro: String;
    strNomCid: String;
    strEstado: String;
    blnAtualizar: Boolean;

    LCodigoCorreio: String;
begin
  Result := True;
  blnAtualizar := False;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodCon) Then
    Begin
      If (fEmptyStr(dbeCodCon.Text)) And (dbeCodCon.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Consumidor deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    {*****************************************}
    {* VALIDA O NOME                         *}
    {**************************************JB*}
    Else If (Sender = dbeNomCon) Then
    Begin
      If fEmptyStr(dbeNomCon.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O nome do Consumidor deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O ENDEREÇO                     *}
    {**************************************JB*}
    Else If (Sender = dbeEndere) Then
    Begin
      If fEmptyStr(dbeEndere.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Endereço do Consumidor deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodCid) Then
    Begin

      If fEmptyStr(dbeCodCid.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Cidade deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        pCarregaCidade(qryConCid, edtNomCid, edtEstado, dbeCodCid, dbeNumCep);

        If qryConCid.FieldByName('CID_CODCID').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeNumCep) Then
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(dbeNumCep.Text))) Then
      Begin
        If Length(Trim(fTiraCaracEspeciais(dbeNumCep.Text))) < 8 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Cep deve ser vazio ou com 8 digitos.', ['&Ok']);
          Result := False;
        End;
      End;

      If (Result) And (fCfgSis('USACEP', varBoolean)) Then
      Begin

        If (Not fCadCepDadosCep(dbeNumCep.Text, strCodCid, strEndere, strBairro, strNomCid, strEstado, LCodigoCorreio,
                                                  {qryConCid.FieldByName('CID_ESTADO').AsString}'',
                                                  {qryConCid.FieldByName('CID_CODCOR').AsString}'')) Then
        Begin
          Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
        End
        Else
        Begin

          If (fEmptyStr(strCodCid)) Then
          Begin

            If Not fVerificaAcessoSistema('frmCadCidades') Then
            Begin
              fMensagem('ATENÇÃO!', fMensagemTravaAcessoCadCid(dbeCodCid.Text, edtNomCid.Text), ['&Ok']);

              Result := False;

            End

            Else

            If Not fEmptyStr(fRetNomCidade(dbeCodCid.Text)) Then
            Begin

              If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + edtNomCid.Text + ' está em branco.' + #13#10 +
                           'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?', ['&Sim', '&Não']) = 1 Then
              Begin
                pAtualizaCodigoCorreios(dbeCodCid.Text, dbeNumCep.Text);
              End

              Else Result := False;

            End Else
            Begin
              fMensagem('ATENÇÃO!', 'Esse CEP não tem nenhum endereço associado no cadastro do AutCom.' + #13#10 +
                                    'Será aberto o Cadastro de Cidades para o preenchimento do Código Correios.', ['&Ok']);
              pCriarForm(TfrmCadCidades);
              Result := False;
            End;

          End
          {***********************************}
          {* CASO O CEP NÃO POSSUIR ENDERECO *}
          {********************************JB*}
          Else If (Not fEmptyStr(strNomCid)) And (fEmptyStr(dbeEndere.Field.AsString)) Then
          Begin
            dbeEndere.Field.AsString := fTiraCaracEspeciais(strNomCid);
            strEndere                := dbeEndere.Field.AsString;
          End;

          If Result Then
          Begin

            blnAtualizar := False;
            If fTiraCaracEspeciais(strCepAnt) <> fTiraCaracEspeciais(dbeNumCep.Text) Then
            Begin
              If fTiraCaracEspeciais(strCepAnt) = '' Then
              Begin
                blnAtualizar := True;
              End
              Else
                blnAtualizar := fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1;
            End;

            If fEmptyStr(dbeCodCid.Text) Or (blnAtualizar) Then
            Begin
              dbeCodCid.Field.AsString := strCodCid;
              pCarregaCidade(qryConCid, edtNomCid, edtEstado, dbeCodCid, Nil);
            End;

            If fEmptyStr(dbeEndere.Text) Or (blnAtualizar) Then
              dbeEndere.Field.AsString := strEndere;

            If fEmptyStr(dbeBairro.Text) Or (blnAtualizar) Then
              dbeBairro.Field.AsString := strBairro;

            If (strCodCid <> dbeCodCid.Text) And (Not fEmptyStr(strCodCid)) Then
            Begin
              Result := False;
              pMensagemOk('O CEP informado não pertence a cidade de ' + fRetNomCidade(dbeCodCid.Text) + '!');
            End;

          End;

        End;

        If (Result) Then
        Begin
          strCepAnt := dbeNumCep.Text;
          If blnAtualizar Then
          Begin
            pSetFocus(dbeEndere);
            blnMudarFoco := False;
          End;
        End;

      End;

    End

    {*****************************************}
    {* VALIDA O CAMPO CNPJ / CPF             *}
    {**************************************MV*}
    Else If (Sender = dbeCgcCpf) Then
    Begin
      If (fEmptyStr(dbeCgcCpf.Text)) Or (dbeCgcCpf.Text = '0') Then
      Begin
        fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (dbeCgcCpf.Text <> '1') And (dbeCgcCpf.Text <> '2') Then
      Begin
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA CNPJ / CPF                     *}
    {**************************************MV*}
    Else If (Sender = dbeNuCpnj) And (FPais <> opcParaguai) Then
    Begin

      If fEmptyStr(dbeNuCpnj.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        Result := fValidaCampos(dbeCgcCpf, True);

        If (Result) Then
          Result := fValidaCnpjCpf(dbeCgcCpf.Text, dbeNuCpnj.Text, False);

        If (Result) Then
          pCarregaConsumidor;

        If Not Result Then
          Sender := dbeCgcCpf;
      End;

    End

    {*****************************************}
    {* VALIDA CNPJ / CPF                     *}
    {**************************************MV*}
    Else If (Sender = dbeNuCpnj) And (FPais = opcParaguai) Then
    Begin
      If fEmptyStr(dbeNuCpnj.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O RUC deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
        pCarregaConsumidor;
    End

    {*****************************************}
    {* VALIDA TELEFONE                       *}
    {**************************************JB*}
    Else If (Sender = dbeFone02) Or (Sender = dbeCelula) Then
    Begin
      If (Not fEmptyStr(TDBEditFocus(Sender).Text)) And
         (Not fValidaTelefone(TDBEditFocus(Sender).Text)) Then
      Begin
        fMensagem('','Informe o telefone corretamente!', ['&Ok']);
        Result := False;
      End
      Else
        TDBEditFocus(Sender).Text := fAcertaMaskTel(TDBEditFocus(Sender).Text);
    End

    Else If Sender = dbeNasCon Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(dbeNasCon.Text)) Then
        dbeNasCon.Field.Clear
      Else If StrToDateDef(dbeNasCon.Text, -1) = -1 Then
        dbeNasCon.Field.Clear;
    End

    {*****************************************}
    {* VALIDA INSCRIÇÃO ESTADUAL             *}
    {**************************************JB*}
    Else If (Sender = dbeNumIes) Then
    Begin
      If (Not fEmptyStr(dbeNumIes.Text))    And
         (Not fEmptyStr(edtEstado.Text)) Then
      Begin
        dbeNumIes.Text := AnsiReplaceStr(dbeNumIes.Text, ',', '.');
        If Not fValidaIES(dbeNumIes.Text, edtEstado.Text) Then
        Begin
          fMensagem('ATENÇÃO', dbeNumIes.Text + ' não é uma Inscrição Estadual válida!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If edtEstado.Text = 'RS' Then
          Begin
            dbeNumIes.Text := fRetornaZerosNumIes(dbeNumIes.Text) + dbeNumIes.Text;
          End;
        End;
      End
      Else
      Begin
        dbeNumIes.Clear;
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadConsumidor.pCarregaCidade(qryConsulta: TUniQuery; edtCidade,
  edtEstado: TEdit; dbeCidade, dbeCep: TDBEditFocus);
begin
  pPesquisaCadCid(qryConsulta, qryConsulta, dbeCidade.Text);
  With qryConsulta Do
  Begin
    edtCidade.Text := FieldByName('CID_NOMCID').AsString;
    edtEstado.Text := FieldByName('CID_ESTADO').AsString;

    If (Assigned(dbeCep)) And (dbeCep.Field <> Nil) And (dbeCep.Field.IsNull) Then
    Begin
      dbeCep.Text := FieldByName('CID_C_E_P_').AsString;
      strCepAnt   := FieldByName('CID_C_E_P_').AsString;
    End;
  End;
end;

procedure TfrmCadConsumidor.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrConsumidores: TConsultasArray;
begin
{ Alterada 06/07/2011 - O Alexandre disse para fazer somente a consulta simples.}

  {*********************************}
  {* NOVA CONSULTA DE CONSUMIDORES *}
  {******************************AC*}
  chrKey := '/';
  fPesqConsumidores(Self, dbeCodCon, dbeNomCon, Nil, Nil, qryTabela, chrKey, arrConsumidores);

  strCepAnt := dbeNumCep.Text;
  pCarregaCidade(qryConCid, edtNomCid, edtEstado, dbeCodCid, dbeNumCep);

  If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
    pSetFocus(btnAlterar);
    
end;

procedure TfrmCadConsumidor.dbeCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, dbeCodCid, edtNomCid, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadConsumidor.dbeCodCidChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadCid(Key);
end;

procedure TfrmCadConsumidor.pCarregaConsumidor;
  Var
    strNuCpf : String;
    qryGen : TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Self);
    strNuCpf := dbeNuCpnj.Text;

    If qryTabela.State = dsInsert Then
    Begin
      pPesquisaCadCliCon(qryGen, qryGen, strNuCpf);

      If Not qryGen.IsEmpty Then
      Begin
        btnCancelaClick(nil);
        pPesquisaCadCliCon(qryTabela, qryTabela, strNuCpf);
        btnAlterar.Enabled := True;
        btnAlterarClick(nil);
        blnMudarFoco := False;
        pSetFocus(dbeNomCon);
        pCarregaCidade(qryConCid, edtNomCid, edtEstado, dbeCodCid, dbeNumCep);
        strCepAnt := dbeNumCep.Text;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadConsumidor.dbeCgcCpfChange(Sender: TObject);
begin
  inherited;
  If dbeCgcCpf.Text = '1' Then
  Begin
    dbeNumRg.Clear;
    dbeNumRg.Enabled := False;
    dbeNumRg.Visible := False;
    lblRG.Visible    := False;

    dbeNumIes.Visible := True;
    dbeNumIes.Left    := dbeNumRg.Left;
    dbeNumIes.Width   := dbeNumRg.Width;
    lblIncEst.Visible := True;
    lblIncEst.Left    := 4;
  End
  Else
  Begin
    dbeNumIes.Clear;
    dbeNumIes.Enabled := False;
    dbeNumIes.Visible := False;
    lblIncEst.Visible := False;

    dbeNumRg.Visible  := True;
    lblRG.Visible     := True;

    If (qryTabela.State In [dsEdit, dsInsert]) Then
      dbeNumRg.Enabled := True
    Else
      dbeNumRg.Enabled := False;
  End;
end;

procedure TfrmCadConsumidor.dbeCgcCpfExit(Sender: TObject);
begin
  inherited;
  If (dbeCgcCpf.Text = '1') Then
    qryTabela.FieldByName('CON_C_P_F_').EditMask := fRetMascaraC_G_C_(FPais, C_G_C_)
  Else
    qryTabela.FieldByName('CON_C_P_F_').EditMask := fRetMascaraC_G_C_(FPais, C_P_F_);
end;

procedure TfrmCadConsumidor.dbeNumCepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Key := #0;

    dbeNumCep.Text := fConsultarCep(Self,
                                    dbeNumCep.Text,
                                    dbeNumCep,
                                    fRetNomCidade(qryTabela.FieldByName('CON_CODCID').AsString,1),
                                    fRetCodCorreio(qryTabela.FieldByName('CON_CODCID').AsString),
                                    fRetNomCidade(qryTabela.FieldByName('CON_CODCID').AsString,0));
  End;
end;

end.

