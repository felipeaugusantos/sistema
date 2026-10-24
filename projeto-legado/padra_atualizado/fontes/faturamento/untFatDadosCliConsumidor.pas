unit untFatDadosCliConsumidor;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus, Menus, DB, untFuncFat,
  Uni, AppEvnts, untEditTipoCgcCpf, untMskC_G_C_, untFuncoesGenerica,
  untMskTelefone, untLabelCgcCpf, untLabelRg, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, dxScreenTip, cxClasses, dxCustomHint, cxHint,
  Vcl.DBCtrls, DBEditFocus, System.ImageList, Vcl.ImgList, cxImageList,
  cxGraphics, dxGDIPlusClasses;

type
  TfrmFatDadosCliConsumidor = class(TfrmPaiSimples)
    pnlDadosCons: TPanel;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlDadosSuperior: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    LabelCgcCpf1: TLabelCgcCpf;
    edtNomCli: TEditFocus;
    edtEndere: TEditFocus;
    Panel1: TPanel;
    edtCgcCpf: TEditTipoCgcCpf;
    mskNumCgc: TMaskEditC_G_C_;
    pnlEndNumCom: TPanel;
    Label8: TLabel;
    edtEndNum: TEditFocus;
    edtEndCom: TEditFocus;
    Label9: TLabel;
    pnlDadosInferior: TPanel;
    Label6: TLabel;
    mskNumCep: TMaskEditFocus;
    Label4: TLabel;
    Label7: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    edtEstado: TEditFocus;
    btnConsultaFit: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    pnlRegiao: TPanel;
    lblRegiao: TLabel;
    edtDesReg: TEditFocus;
    pnlDadosInferior2: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    lblIncEst: TLabel;
    lblEmail_: TLabel;
    lblRG: TLabelRg;
    Label10: TLabel;
    lblDtaNas: TLabel;
    edtBairro: TEditFocus;
    edtInsEst: TEditFocus;
    edtRgCli: TEditFocus;
    edtEmail_: TEditFocus;
    mskTelCon: TMaskEditTelefone;
    edtCodAtividade: TEditFocus;
    edtNomAtividade: TEditFocus;
    mskDtaNas: TMaskEditFocus;
    pnlUtiNps: TPanel;
    lblUtiNps: TLabel;
    edtCodReg: TEditFocus;
    ImageSefaz: TcxImageList;
    lblCanalAcesso: TLabel;
    edtDesCadCac: TEditFocus;
    edtCodCac: TEditFocus;
    imgWpp: TImage;
    lblCelular: TLabel;
    edtCelula: TMaskEditTelefone;
    edtEmail2: TEditFocus;
    Label11: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCgcCpfChange(Sender: TObject);
    procedure mskNumCgcKeyPress(Sender: TObject; var Key: Char);
    procedure mskNumCgcExit(Sender: TObject);
    procedure mskNumCepKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCgcCpfKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblUtiNpsClick(Sender: TObject);
    procedure btnConsultaFitClick(Sender: TObject);
    procedure edtCodAtividadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCacKeyPress(Sender: TObject; var Key: Char);
  strict private
    function fVerificaSituacaoRegular: boolean;
  private
    { Private declarations }
    qryConCid: TUniQuery;
    qryCliCon: TUniQuery;

    strCepAnt : String;

    strDescriCli: String;

    blnUtiNps : Boolean;

    blnUtilizaPreCadastroCupomFiscal: Boolean;
    blnTemDivergenciaSefaz: Boolean;

    FPais: TPais;

    procedure pCarregaCidade;
    procedure pCarregaConsumidor;
    procedure pGravarConsumidor;
    procedure pAlterarConsumidor;
    procedure pCarregaCanalAcesso;
    function fProximoCodigo(const strCampoBusca : String): String;

    function fCadastraClienteConsumidor: Boolean;
    function fValidaCgcCpf: Boolean;
    procedure pConfirmaClientePreCadastro(blnCarregar: Boolean);
    procedure pIncluiCondPagtoConsumidor(strCodCli: String);
    procedure pLimparCampos;

    function fVaiCadastrarNovoCliente: Boolean;
    procedure pCarregaRegiao;
    function fVerificaTamanhoEndereco: boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strCodCli  : String;
    strEstado  : String;
    blnCGCRep  : Boolean;
    blnNasCon  : Boolean;

    blnUtilizarPreCadastroConsumidor: Boolean;
    strCodCliPreCadastro: String;
    strOpcDoc: String;
    objVenda : TFatVenda;
  end;

var
  frmFatDadosCliConsumidor: TfrmFatDadosCliConsumidor;

implementation

uses untPesqAux, untFuncoes, untFuncoesSimples, untCadCid, untTypesSistema,
     untPai, untCadCidades, untConsultas, untCadClientes, untFatDigNetPoints,
     untIConsultaCadastroFit, untTConsultaCadastroFit, untCepNaoEncontrado;

{$R *.dfm}

procedure TfrmFatDadosCliConsumidor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Not blnUtilizarPreCadastroConsumidor) and (not blnUtilizaPreCadastroCupomFiscal) Then
    strCodCliPreCadastro := EmptyStr;
end;

procedure TfrmFatDadosCliConsumidor.FormCreate(Sender: TObject);
begin
  inherited;

  {Desabilita devido ao novo campo "Nascimento"}
  blnValidaDataMuitoAntiga := False;

  blnNasCon := False;

  objVenda := Nil;
  blnCGCRep   := False;
  blnConfirma := False;
  strCepAnt := '';

  qryConCid   := fCriarQuery('SELECT * FROM CADCID WHERE FALSE', Self);
  qryCliCon   := fCriarQuery('SELECT * FROM CLICON WHERE FALSE', Self);

  blnUtilizarPreCadastroConsumidor := False;

  FPais := fSetaPais;

  pnlRegiao.Visible := fCfgSis('REGCLO', varBoolean) And fCfgSis('PRECAD', varBoolean);
  blnUtiNps := fCfgSis('UTINPS', varBoolean);

  blnTemDivergenciaSefaz := False;

end;

procedure TfrmFatDadosCliConsumidor.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDadosCliConsumidor.btnConfirmaDadosClick(Sender: TObject);

  function fInserindoConsumidor: Boolean;
  begin
    Result := fCampoTabela('COUNT(*)', 'CLICON', ['CON_C_P_F_'], [fTiraCaracEspeciais(mskNumCgc.Text)]) = 0;
  end;

begin
  If fVerificaCampos Then
  Begin
    if not fVerificaSituacaoRegular then
      exit;

    If Not fVerificaTamanhoEndereco then
      Exit;

    If fValidaCgcCpf Then
    Begin
      If fInserindoConsumidor Then
        pGravarConsumidor
      Else
        pAlterarConsumidor;

      pCarregaConsumidor;

      If fVaiCadastrarNovoCliente() Then
      Begin
        If fCadastraClienteConsumidor Then
        Begin
          pConfirmaClientePreCadastro(False);
          Exit;
        End;
      End;

    End;

    blnConfirma := True;

    If (Assigned(objVenda)) And (Assigned(objVenda.objCopiaSegVenda)) Then
    Begin
      If objVenda.objCopiaSegVenda.Habilitado Then
        objVenda.objCopiaSegVenda.pGetDadosClienteConsumidor(Self);
    End;

    Close;
  End;
end;

procedure TfrmFatDadosCliConsumidor.btnConsultaFitClick(Sender: TObject);
var
  dicValoresAtuais, dicResultado: TDicionario;
begin
  inherited;

  if edtCgcCpf.Text <> '1' then
    Exit;

  If fEmptyStr(fTiraCaracEspeciais(mskNumCgc.Text)) Then
  Begin
    fMensagem('Atenção', 'Informe o CNPJ antes de realizar a consulta', ['&Ok']);
    pSetFocus(mskNumCgc);
    Exit;
  End;

  dicValoresAtuais := TDicionario.Create;
  dicResultado := TDicionario.Create;
  try
    dicValoresAtuais.Limpar;
    dicValoresAtuais.Adicionar(DESC_RAZAO_SOCIAL,  edtNomCli.Text);
    dicValoresAtuais.Adicionar(DESC_NOME_FANTASIA, '');
    dicValoresAtuais.Adicionar(DESC_INSC_EST,      edtInsEst.Text);
    dicValoresAtuais.Adicionar(DESC_ENDERECO,      edtEndere.Text);
    dicValoresAtuais.Adicionar(DESC_NUMERO,        edtEndNum.Text);
    dicValoresAtuais.Adicionar(DESC_COMPLEMENTO,   edtEndCom.Text);
    dicValoresAtuais.Adicionar(DESC_BAIRRO,        edtBairro.Text);
    dicValoresAtuais.Adicionar(DESC_CEP,           fTiraCaracEspeciais(mskNumCEP.Text));
    dicValoresAtuais.Adicionar(DESC_IBGE_CIDADE,   fRetornaCodIBGE(edtCodCid.Text));
    dicValoresAtuais.Adicionar(DESC_CNPJ,          fTiraCaracEspeciais(mskNumCgc.Text));

    objConsultaCadastroFit.pConsulta(dicValoresAtuais,
                                     dicResultado,
                                     fTiraCaracEspeciais(mskNumCgc.Text),
                                     False,
                                     blnTemDivergenciaSefaz,
                                     True);

    if dicResultado.Chaves.IndexOf(DESC_RAZAO_SOCIAL) > -1 then
      edtNomCli.Text := dicResultado.Retorna(DESC_RAZAO_SOCIAL);
    if dicResultado.Chaves.IndexOf(DESC_INSC_EST) > -1 then
      edtInsEst.Text := dicResultado.Retorna(DESC_INSC_EST);

    if dicResultado.Chaves.IndexOf(DESC_CEP) > -1 then
    begin
      mskNumCEP.Text := fTiraCaracEspeciaisPonto(dicResultado.Retorna(DESC_CEP));
      fValidaCampos(mskNumCEP);
    end;

    if dicResultado.Chaves.IndexOf(DESC_ENDERECO) > -1 then
      edtEndere.Text := dicResultado.Retorna(DESC_ENDERECO);
    if dicResultado.Chaves.IndexOf(DESC_NUMERO) > -1 then
      edtEndNum.Text := dicResultado.Retorna(DESC_NUMERO);
    if dicResultado.Chaves.IndexOf(DESC_COMPLEMENTO) > -1 then
      edtEndCom.Text := dicResultado.Retorna(DESC_COMPLEMENTO);
    if dicResultado.Chaves.IndexOf(DESC_BAIRRO) > -1 then
      edtBairro.Text := dicResultado.Retorna(DESC_BAIRRO);

    if dicResultado.Chaves.IndexOf(DESC_IBGE_CIDADE) > -1 then
    begin
      edtCodCid.Text := fRetornaCodCidIBGE(dicResultado.Retorna(DESC_IBGE_CIDADE), True);
      fValidaCampos(edtCodCid);
    end;

    if dicResultado.Chaves.IndexOf(DESC_CNPJ) > -1 then
      mskNumCgc.Text := fTiraCaracEspeciaisPonto(dicResultado.Retorna(DESC_CNPJ));

    if not blnTemDivergenciaSefaz then
      pSalvaDataConsultaSefaz('CLICON', 'CON_DTASEF', qryCliCon.FieldByName('AUTOINCREM').AsString, fRetDataServidor);
  finally
    FreeAndNil(dicValoresAtuais);
    FreeAndNil(dicResultado);
  end;
end;

function TfrmFatDadosCliConsumidor.fValidaCgcCpf: Boolean;
begin
  Result := (Not fEmptyStr(fTiraCaracEspeciais(mskNumCgc.Text))) And
            (Not fStringRepetida(fTiraCaracEspeciais(mskNumCgc.Text)));

  If (Not blnUtilizarPreCadastroConsumidor) And Result Then
    Result := (fRetCgcCpf(strCodCli) <> fTiraCaracEspeciais(mskNumCgc.Text));
end;

procedure TfrmFatDadosCliConsumidor.lblUtiNpsClick(Sender: TObject);
begin
  inherited;
  If (TfrmFatDigNetPoints.fCpfVendedorOK(objVenda.strCodVen)) Then
  Begin
    pCriarFormularios(TfrmFatDigNetPoints, frmFatDigNetPoints);
    If fEmptyStr(objVenda.objNetpoints.strCpfCli) Then
      objVenda.objNetpoints.strCpfCli := mskNumCgc.Text;
    frmFatDigNetPoints.objNetpoints := objVenda.objNetpoints;
    frmFatDigNetPoints.ShowModal;
    pFreeAndNil(frmFatDigNetPoints);
  End;
end;

function TfrmFatDadosCliConsumidor.fProximoCodigo(const strCampoBusca : String): String;
begin
  Result := fAtualizaProCod(strNomeTabela, strCampoBusca);
end;

function TfrmFatDadosCliConsumidor.fVaiCadastrarNovoCliente: Boolean;
begin
  Result := blnUtilizarPreCadastroConsumidor And
    fEmptyStr(fRetClientePorCgcCpf(StrToInt(edtCgcCpf.Text), fTiraCaracEspeciais(mskNumCgc.Text)));
end;

function TfrmFatDadosCliConsumidor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strCodCid: String;
    strEndere: String;
    strBairro: String;
    strNomCid: String;
    strEstadoInt: String;

    blnAtualizar: Boolean;

    LCodigoCorreio: String;
begin
  blnAtualizar := False;
  Result := True;

  strEstadoInt := Self.strEstado;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskNumCep) Then
    Begin
      If (Not fEmptyStr(mskNumCep.Text)) And (Length(mskNumCep.Text) < 8) Then
      Begin
        fMensagem('ATENÇÃO!', 'O CEP deve conter 8 digitos!', ['&O k']);
        Result := False;
      End;

      If (Result) And (fCfgSis('USACEP', varBoolean)) And (Not fEmptyStr(mskNumCep.Text)) Then
      Begin
        pCarregaCidade;
        If (Not fCadCepDadosCep(mskNumCep.Text, strCodCid, strEndere, strBairro,
                                strNomCid, strEstadoInt, LCodigoCorreio,'','')) Then
        Begin
          if (fCfgSis('INVCEP', varInteger) = 2) AND (fCfgSis('PRECAD', varBoolean)) then
          Begin
            fMensagem('ATENÇÃO!', 'CEP não encontrado! Verifique o cadastro de cidades e depois tente novamente.', ['&Ok']);
            Result := False;
          End
          Else
            Result := TfrmCepNaoEncontrado.fContinuarMesmoQueNaoTenhaEncontradoCep;
        End
        Else
        Begin

          If (fEmptyStr(strCodCid)) Then
          Begin

            If Not fVerificaAcessoSistema('frmCadCidades') Then
            Begin
              fMensagem('ATENÇÃO!', fMensagemTravaAcessoCadCid(edtCodCid.Text, edtNomCid.Text), ['&Ok']);

              Result := False;

            End

            Else

            If Not fEmptyStr(fRetNomCidade(edtCodCid.Text)) Then
            Begin

              If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + edtNomCid.Text + ' está em branco.' + #13#10 +
                           'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?', ['&Sim', '&Não']) = 1 Then
              Begin
                pAtualizaCodigoCorreios(edtCodCid.Text, mskNumCep.Text);
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
          Else If (fEmptyStr(strEndere)) And (Not fEmptyStr(strNomCid)) Then
          Begin
            If (strCepAnt <> mskNumCep.Text) Then
            Begin
              edtEndere.Text := fTiraCaracEspeciais(strNomCid);
              strEndere      := edtEndere.Text;
            End;
          End;

          If Result Then
          Begin

            blnAtualizar := False;

            If (fTiraCaracEspeciais(strCepAnt) <> fTiraCaracEspeciais(mskNumCep.Text)) Then
            Begin
              If (Not fEmptyStr(edtEndere.Text)) Then
              Begin
                If fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1 Then
                Begin
                  blnAtualizar := True;
                End;
              End
              Else
                blnAtualizar := True;
            End;

            If fEmptyStr(edtCodCid.Text) Or (blnAtualizar) Then
            Begin
              edtCodCid.Text := strCodCid;
              pCarregaCidade;
            End;

            If fEmptyStr(edtEndere.Text) Or (blnAtualizar) Then
              edtEndere.Text := strEndere;

            If fEmptyStr(edtBairro.Text) Or (blnAtualizar) Then
              edtBairro.Text := strBairro;
          End;

        End;

        If (Result) Then
        Begin
          strCepAnt := mskNumCep.Text;
          If blnAtualizar Then
          Begin
            If edtEndNum.CanFocus Then
              pSetFocus(edtEndNum)
            Else
              pSetFocus(edtEndere);
            blnMudarFoco := False;
          End;
        End;

      End;

    End

    Else If (Sender = edtCodCid) Then
    Begin

      If fEmptyStr(edtCodCid.Text) Then
      Begin
        edtNomCid.Clear;
        edtEstado.Clear;
        fMensagem('ATENÇÃO!', 'A cidade deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCidade;
        If qryConCid.FieldByName('CID_CODCID').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&O k']);
          Result := False;
        End

        Else If Not fValidaEstado(qryConCid.FieldByName('CID_ESTADO').AsString) Then
        Begin
          fMensagem('ATENÇÃO!', 'Estado inválido!', ['&O k']);
          Result := False;
        End
        Else If (Not fVaiCadastrarNovoCliente()) Then
        Begin
          If qryConCid.FieldByName('CID_ESTADO').AsString <> strEstadoInt Then
          Begin
            fMensagem('ATENÇÃO!', 'Estado inválido! O Estado do cliente ' + AnsiLowerCase(strDescriCli) + ' deve ser: ' + strEstado, ['&O k']);
            Result := False;
          End
          Else
            Self.strEstado := strEstadoInt;
        End;
      End;

    End

    Else If (Sender = edtCgcCpf) Then
    Begin
      If (Pos(edtCgcCpf.Text, '1_2_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe 1-CNPJ / 2-CPF!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(strOpcDoc, 'VN_PD_OR_') > 0) And (TFatVenda.fTravarVendaClientePessoaFisica(strCodCli, edtCgcCpf.Text)) Then
        Result := False;
    End

    Else If (Sender = mskNumCgc) Then
    Begin
      If (fCfgSis('OBCFCC', varBoolean) and (fEmptyStr(mskNumCgc.Text))) Then
      Begin
        if not (objVenda.fEhAutocenter and fCfgSis('EDCSIC', varBoolean)) then
        begin
          fMensagem('','O campo CPF/CNPJ deve ser preenchido!', ['&Ok']);
          Result := False;
        end;
      End;

      If Not fEmptyStr(mskNumCgc.Text) Then
      Begin
        if fCfgSis('OBCFCC', varBoolean) then
          Result := fValidaCnpjCpf(mskNumCgc.Text, True)
        else
          Result := fValidaCnpjCpf(edtCgcCpf.Text, mskNumCgc.Text, blnCGCRep, True);

        lblUtiNps.Visible := (Result) And (blnUtiNps) And (edtCgcCpf.Text = '2') And (Assigned(objVenda)) And (Pos(objVenda.strOpcDoc, 'OF_BR_TE_NC_DV_PR_OE_EP_UC_DD_CF_CI_CP_') <= 0);
      End;
    End

    Else If (Sender = edtCelula) Then
    Begin
      If (Not SameText(strOpcDoc, 'DV')) And (fCfgSis('OBGCEC', varBoolean)) Then
      Begin
        If (fEmptyStr(edtCelula.Text)) Then
        Begin
          fMensagem('','O campo Celular deve ser preenchido!', ['&Ok']);
          Result := False;
        End

        Else If (Not fValidaCelular(edtCelula.Text)) Then
        Begin
           fMensagem('','Informe o Celular corretamente!', ['&Ok']);
           Result := False;
        End;
      End;
    End

    Else If (Sender = edtInsEst) And (edtInsEst.Visible) Then
    Begin
      pCarregaCidade;        
      If (Not fEmptyStr(edtInsEst.Text))                  And
         (Not qryConCid.FieldByName('CID_CODCID').IsNull) Then
      Begin
        If Not fValidaIES(edtInsEst.Text, qryConCid.FieldByName('CID_ESTADO').AsString) Then
        Begin
          fMensagem('ATENÇÃO', edtInsEst.Text + ' não é uma Inscrição Estadual válida!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If qryConCid.FieldByName('CID_ESTADO').AsString = 'RS' Then
          Begin
            edtInsEst.Text := fRetornaZerosNumIes(edtInsEst.Text) + edtInsEst.Text;
          End;
        End;
      End
      Else
        edtInsEst.Clear;
    End

    Else If (Sender = edtNomCli) Then
    Begin
      If (fEmptyStr(edtNomCli.Text)) Then
      Begin
        If (edtCgcCpf.Text = '2') Then {CPF}
          edtNomCli.Text := 'CONSUMIDOR'
        else
        If (edtCgcCpf.Text = '1') Then
        Begin
          fMensagem('','O campo Nome deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        {Validação do SAT}
        If (Length(edtNomCli.Text) < 3) Then
        Begin
          fMensagem('', 'O campo Nome deve ter no mínimo 3 caracteres!', ['&Ok']);
          Result := False;
        End;
      End;

      If Result and fCfgSis('OBNMCC', varBoolean) and fClienteConsumidor(edtNomCli.Text) Then
      Begin
        fMensagem('','Informe o nome do consumidor!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtEndere) Then
    Begin

      If (edtCgcCpf.Text = '1') Then
      Begin
        If (fEmptyStr(edtEndere.Text)) Then
        Begin
          fMensagem('', 'O campo Endereço deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If (Not pnlEndNumCom.Visible) Then
          Begin
            If (fRetSomenteNumeros(edtEndere.Text).IsEmpty) And (Not fClienteConsumidor(edtNomCli.Text)) Then
            Begin
              Result := fMensagem('ATENÇÃO!', 'O campo Endereço não tem número informado!' + #13 + 
                                              'Deseja manter assim?', ['&Sim', '&Não'], 2) = 1;
            End;
          End;
        End;
      End;

    End

    Else If (Sender = edtEndNum) And pnlEndNumCom.Visible Then
    Begin

      If (edtCgcCpf.Text = '1') And
         (fEmptyStr(edtEndNum.Text)) Then
      Begin
        fMensagem('', 'O campo de número do endereço deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = edtBairro) Then
    Begin

      If (edtCgcCpf.Text = '1') And
         (fEmptyStr(edtBairro.Text)) Then
      Begin
        fMensagem('', 'O campo Bairro deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = edtEmail_) Then
    Begin

      IF blnUtilizarPreCadastroConsumidor Then
        Result := fEmailValido(edtEmail_.Text);

    End

    Else If (Sender = edtEmail2) Then
    Begin

      If blnUtilizarPreCadastroConsumidor Then
      Begin
        If Not fEmptyStr(edtEmail2.Text) Then
          Result := fEmailValido(edtEmail2.Text);
      End;
    End

    Else If (Sender = mskTelCon) Then
    Begin

      If fCfgSis('OBTLCC', varBoolean) Then
      Begin
        If (fEmptyStr(mskTelCon.Text)) Then
        Begin
          fMensagem('','O campo Telefone deve ser preenchido!', ['&Ok']);
          Result := False;
        End

        Else If (Not fValidaTelefone(mskTelCon.Text)) Then
        Begin
           fMensagem('','Informe o Telefone corretamente!', ['&Ok']);
           Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodAtividade) And (fCfgSis('PRECAD', varBoolean)) Then
    Begin
      If Not fEmptyStr(edtCodAtividade.Text) Then
      Begin
        edtNomAtividade.Text := fRetAtividade(edtCodAtividade.Text);
        If fEmptyStr(edtNomAtividade.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa atividade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O código da atividade deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodCac) And edtCodCac.Visible And edtCodCac.Enabled And (fCfgSis('PRECAD', varBoolean)) Then
    Begin
      If Not fEmptyStr(edtCodCac.Text) Then
      Begin
        pCarregaCanalAcesso;
        If (fEmptyStr(edtDesCadCac.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Canal de Acesso não cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        if fCfgSis('OBGCNA', varBoolean) Then
        Begin
          fMensagem('ATENÇÃO!', 'Canal de Acesso deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
        edtDesCadCac.Text := EmptyStr;
      End;
    End

    Else If (Sender = edtCodReg) and (pnlRegiao.Visible) Then
    Begin
      If Not fEmptyStr(edtCodReg.Text) Then
      Begin
        pCarregaRegiao;
        If (fEmptyStr(edtDesReg.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Região não cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else If fCfgSis('REGCLO', VarBoolean) and fValidaCgcCpf Then
      Begin
        fMensagem('ATENÇÃO!', 'A Região do cliente deve ser informada!', ['&Ok']);
        Result := False;
      End
      Else
        edtDesReg.Text := EmptyStr;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmFatDadosCliConsumidor.pCarregaCanalAcesso;
begin
  If Not fEmptyStr(edtCodCac.Text) Then
    edtDesCadCac.Text := fRetNomCanalAcesso(edtCodCac.Text)
  Else
    edtDesCadCac.Text := EmptyStr;
end;

procedure TfrmFatDadosCliConsumidor.pCarregaCidade;
begin
  pPesquisaCadCid(qryConCid, qryConCid, edtCodCid.Text);
  With qryConCid Do
  Begin
    edtNomCid.Text := FieldByName('CID_NOMCID').AsString;
    edtEstado.Text := FieldByName('CID_ESTADO').AsString;

    If fEmptyStr(mskNumCep.Text) Then
    Begin
      mskNumCep.Text := FieldByName('CID_C_E_P_').AsString;
      strCepAnt      := FieldByName('CID_C_E_P_').AsString;
    End;

  End;
end;

procedure TfrmFatDadosCliConsumidor.edtCodAtividadeKeyPress(Sender: TObject; var Key: Char);
  Var
    arrAtiv: TConsultasArray;
begin
  inherited;
  If fPesqAtividade(Self, edtCodAtividade, edtNomAtividade, Nil, Key, arrAtiv) Then
  Begin
    if fValidaCampos(edtCodAtividade, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDadosCliConsumidor.edtCodCacKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCanal : TConsultasArray;
begin
  inherited;
  If fPesqCanalAcesso(Self, edtCodCac, edtDesCadCac, Nil, Key, arrCanal) Then
  Begin
    if fValidaCampos(edtCodCac, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDadosCliConsumidor.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtNomCid, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(edtCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDadosCliConsumidor.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrRegiao : TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE REGIOES *}
  {*************************DP*}
  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrRegiao) Then
  Begin
    if fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDadosCliConsumidor.edtCgcCpfChange(Sender: TObject);
begin
  inherited;
  If edtCgcCpf.Text = '1' Then
  Begin
    edtRgCli.Clear;
    edtRgCli.Enabled := False;
    edtRgCli.Visible := False;
    lblRg.Visible    := False;

    edtInsEst.Enabled := True;
    edtInsEst.Visible := True;
    edtInsEst.Left    := edtRgCli.Left;
    edtInsEst.Width   := edtRgCli.Width;
    lblIncEst.Visible := True;
    lblIncEst.Left    := 4;

    mskNumCgc.Clear;
    mskNumCgc.EditMask := fRetMascaraC_G_C_(FPais, C_G_C_);

    lblDtaNas.Visible  := False;
    mskDtaNas.Visible  := False;

  End
  Else
  Begin
    edtInsEst.Clear;
    edtInsEst.Enabled := False;
    edtInsEst.Visible := False;
    lblIncEst.Visible := False;

    edtRgCli.Enabled := True;
    edtRgCli.Visible := True;
    lblRg.Visible    := True;

    mskNumCgc.Clear;
    mskNumCgc.EditMask := fRetMascaraC_G_C_(FPais, C_P_F_);

    lblDtaNas.Visible  := blnNasCon;
    mskDtaNas.Visible  := blnNasCon;

  End;

  btnConsultaFit.Enabled := (edtCgcCpf.Text = '1');
end;

procedure TfrmFatDadosCliConsumidor.mskNumCgcKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If ((edtCgcCpf.Text = '0') Or (fEmptyStr(edtCgcCpf.Text))) And (FPais = opcBrasil) Then
    Key := #0;
end;

procedure TfrmFatDadosCliConsumidor.pCarregaConsumidor;
var
  strDtaSef: string;
begin
  pPesquisaCadCliCon(qryCliCon, qryCliCon, mskNumCgc.Text);

  If (Not qryCliCon.IsEmpty) And (Not fEmptyStr(qryCliCon.FieldByName('CON_C_P_F_').AsString)) Then
  Begin
    mskNumCgc.Text := qryCliCon.FieldByName('CON_C_P_F_').AsString;
    edtCgcCpf.Text := qryCliCon.FieldByName('CON_CGCCPF').AsString;
    edtNomCli.Text := qryCliCon.FieldByName('CON_NOMCON').AsString;
    edtEndere.Text := qryCliCon.FieldByName('CON_ENDERE').AsString;
    edtBairro.Text := qryCliCon.FieldByName('CON_BAIRRO').AsString;
    mskNumCep.Text := qryCliCon.FieldByName('CON_C_E_P_').AsString;
    edtCodCid.Text := qryCliCon.FieldByName('CON_CODCID').AsString;
    mskTelCon.Text := qryCliCon.FieldByName('CON_FONE01').AsString;
    edtCelula.Text := qryCliCon.FieldByName('CON_CELULA').AsString;
    edtInsEst.Text := qryCliCon.FieldByName('CON_I_E_S_').AsString;
    edtRgCli.Text  := qryCliCon.FieldByName('CON_NUMR_G').AsString;
    edtEmail_.Text := qryCliCon.FieldByName('CON_EMLCON').AsString;
    edtEmail2.Text := qryCliCon.FieldByName('CON_EMAIL2').AsString;

    edtEndNum.Text := fRetParteEndereco(qryCliCon.FieldByName('CON_ENDERE').AsString, 2);
    edtEndCom.Text := fRetParteEndereco(qryCliCon.FieldByName('CON_ENDERE').AsString, 3);

    If (fCfgSis('PRECAD', varBoolean)) Then
    Begin
      edtCodAtividade.Text := qryCliCon.FieldByName('CON_CODATI').AsString;
      edtNomAtividade.Text := fRetAtividade(edtCodAtividade.Text);

      edtCodCac.Text := qryCliCon.FieldByName('CON_CODCAC').AsString;
      if not fEmptyStr(edtCodCac.Text) then
        pCarregaCanalAcesso;
    End;
    strCepAnt      := mskNumCep.Text;

    If qryCliCon.FieldByName('CON_NASCON').AsDateTime > 0 Then
      mskDtaNas.Text := qryCliCon.FieldByName('CON_NASCON').AsString
    Else
      mskDtaNas.Clear;

    If Not fCfgSis('NOMCON', varBoolean) Then
      edtNomCli.ReadOnly := Not fEmptyStr(edtNomCli.Text);

    if btnConsultaFit.Enabled then
    begin
      if fTeveConsultaSefaz('CLICON', 'CON_DTASEF', qryCliCon.FieldByName('AUTOINCREM').AsString, strDtaSef) then
      begin
        btnConsultaFit.Glyph := Nil;
        ImageSefaz.GetBitmap(1, btnConsultaFit.Glyph);
        btnConsultaFit.Hint := 'Consulta Dados Cadastrais do CNPJ.' + sLineBreak + 'Última consulta realizada em '+strDtaSef+'.';
      end
      else
      begin
        btnConsultaFit.Glyph := Nil;
        ImageSefaz.GetBitmap(0, btnConsultaFit.Glyph);
        btnConsultaFit.Hint := 'Consulta Dados Cadastrais do CNPJ.';
      end;
    end;

    edtCodReg.Text := qryCliCon.FieldByName('CON_CODREG').AsString;
    pCarregaRegiao;
  End
  Else
  Begin
    pLimparCampos;
    edtNomCli.ReadOnly := False;
  End;

  pCarregaCidade;
end;

procedure TfrmFatDadosCliConsumidor.pGravarConsumidor;
  Var
    strSQL : String;
    strAutoIncrem : String;

    qryGen: TUniQuery;
begin

  If fEmptyStr(fTiraCaracEspeciais(mskNumCgc.Text)) Then
    Exit;

  strNomeTabela := 'CLICON';

  strAutoIncrem := fRetAutoIncrem('CLICON', VS_strCodEmp);

  qryGen := fCriaQuery;

  Try
    strSQL := '';
    strSQL := strSQL + 'REPLACE INTO CLICON (';
    strSQL := strSQL + '  CON_CODCON, ';
    strSQL := strSQL + '  CON_CODEMP, ';
    strSQL := strSQL + '  CON_NOMCON, ';
    strSQL := strSQL + '  CON_ENDERE, ';
    strSQL := strSQL + '  CON_BAIRRO, ';
    strSQL := strSQL + '  CON_C_E_P_, ';
    strSQL := strSQL + '  CON_CODCID, ';
    strSQL := strSQL + '  CON_FONE01, ';
    strSQL := strSQL + '  CON_C_P_F_, ';
    strSQL := strSQL + '  CON_NUMR_G, ';
    strSQL := strSQL + '  CON_I_E_S_, ';
    strSQL := strSQL + '  CON_CGCCPF, ';
    strSQL := strSQL + '  CON_EMLCON, ';
    strSQL := strSQL + '  CON_EMAIL2, ';

    If (fCfgSis('PRECAD', varBoolean)) Then
    Begin
      strSQL := strSQL + '  CON_CODATI, ';
      strSQL := strSQL + '  CON_CODCAC, ';
    End;

    strSQL := strSQL + '  CON_NASCON, ';
    strSQL := strSQL + '  CON_CODREG, ';
    strSQL := strSQL + '  AUTOINCREM, ';
    strSQL := strSQL + '  CON_CELULA) ';
    strSQL := strSQL + 'VALUES ( ';
    strSQL := strSQL + '  :CODCON, ';
    strSQL := strSQL + '  :CODEMP, ';
    strSQL := strSQL + '  :NOMCON, ';
    strSQL := strSQL + '  :ENDERE, ';
    strSQL := strSQL + '  :BAIRRO, ';
    strSQL := strSQL + '  :C_E_P_, ';
    strSQL := strSQL + '  :CODCID, ';
    strSQL := strSQL + '  :FONE01, ';
    strSQL := strSQL + '  :C_P_F_, ';
    strSQL := strSQL + '  :NUMR_G, ';
    strSQL := strSQL + '  :I_E_S_, ';
    strSQL := strSQL + '  :CGCCPF, ';
    strSQL := strSQL + '  :EMLCON, ';
    strSQL := strSQL + '  :EMAIL2, ';

    If (fCfgSis('PRECAD', varBoolean)) Then
    Begin
      strSQL := strSQL + '  :CODATI,  ';
      strSQL := strSQL + '  :CODCAC,  ';
    End;

    strSQL := strSQL + '  :NASCON, ';
    strSQL := strSQL + '  :CODREG, ';
    strSQL := strSQL + '  :AUTOINCREM, ';
    strSQL := strSQL + '  :CELULA) ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);

    qryGen.ParamByName('CODCON').AsString      := fProximoCodigo('CON_CODCON');
    qryGen.ParamByName('CODEMP').AsString      := VS_strCodEmp;
    qryGen.ParamByName('NOMCON').AsString      := edtNomCli.Text;

    If pnlEndNumCom.Visible Then
    Begin
      qryGen.ParamByName('ENDERE').AsString := edtEndere.Text;
      If (Not fEmptyStr(edtEndNum.Text)) Then
        qryGen.ParamByName('ENDERE').AsString := Concat(qryGen.ParamByName('ENDERE').AsString, ', ', edtEndNum.Text);

      If (Not fEmptyStr(edtEndCom.Text)) Then
        qryGen.ParamByName('ENDERE').AsString := Concat(qryGen.ParamByName('ENDERE').AsString, ' - ', edtEndCom.Text);
    End
    Else
      qryGen.ParamByName('ENDERE').AsString := edtEndere.Text;

    qryGen.ParamByName('BAIRRO').AsString      := edtBairro.Text;
    qryGen.ParamByName('C_E_P_').AsString      := mskNumCep.Text;

    if Not fEmptyStr(edtCodCid.Text) then
      qryGen.ParamByName('CODCID').AsString    := edtCodCid.Text
    Else
      qryGen.ParamByName('CODCID').Value       := NULL;

    qryGen.ParamByName('FONE01').AsString      := mskTelCon.Text;
    qryGen.ParamByName('CELULA').AsString      := edtCelula.Text;
    qryGen.ParamByName('C_P_F_').AsString      := fTiraCaracEspeciais(mskNumCgc.Text);

    If (edtCgcCpf.Text = '2') Then
    Begin
      qryGen.ParamByName('NUMR_G').AsString      := edtRgCli.Text;
      qryGen.ParamByName('I_E_S_').AsString      := '';
    End
    Else
    Begin
      qryGen.ParamByName('NUMR_G').AsString      := '';
      qryGen.ParamByName('I_E_S_').AsString      := edtInsEst.Text;
    End;

    qryGen.ParamByName('CGCCPF').AsString      := edtCgcCpf.Text;

    qryGen.ParamByName('EMLCON').AsString      := edtEmail_.Text;
    qryGen.ParamByName('EMAIL2').AsString      := edtEmail2.Text;

    If (fCfgSis('PRECAD', varBoolean)) Then
    Begin
      qryGen.ParamByName('CODATI').AsString      := edtCodAtividade.Text;
      qryGen.ParamByName('CODCAC').AsString      := edtCodCac.Text;
    End;

    If mskDtaNas.Visible And (strToDateDef(mskDtaNas.Text, 0) > 0) Then
      qryGen.ParamByName('NASCON').AsDateTime  := strToDateDef(mskDtaNas.Text, 0);

    if not fEmptyStr(edtCodReg.Text) then
      qryGen.ParamByName('CODREG').AsString    := edtCodReg.Text
    else
      qryGen.ParamByName('CODREG').Clear;

    qryGen.ParamByName('AUTOINCREM').AsString  := strAutoIncrem;

    qryGen.ExecSQL;

    if blnTemDivergenciaSefaz then
      pSalvaDataConsultaSefaz('CLICON', 'CON_DTASEF', strAutoIncrem, fRetDataServidor);

  Except
    pMensagensErro('Falha na gravação do Consumidor!', '[ pGravarConsumidor ]');
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmFatDadosCliConsumidor.pIncluiCondPagtoConsumidor(
  strCodCli: String);
  Var
    strSQL   : String;
    qryGen,
    qryCliCnd: TUniQuery;
begin
  qryGen    := fCriaQuery;
  qryCliCnd := fCriaQuery;

  Try
    strSQL := '';
    strSQL := strSQL + 'INSERT INTO      ';
    strSQL := strSQL + '  CLICND (      ';
    strSQL := strSQL + '    AUTOINCREM, ';
    strSQL := strSQL + '    CND_CODCLI, ';
    strSQL := strSQL + '    CND_CODCND, ';
    strSQL := strSQL + '    CND_CNDPAG, ';
    strSQL := strSQL + '    CND_SUGEST  ';
    strSQL := strSQL + '  ) VALUES (    ';
    strSQL := strSQL + '    :AUTINC,    ';
    strSQL := strSQL + '    :CODCLI,    ';
    strSQL := strSQL + '    :CODCND,    ';
    strSQL := strSQL + '    :CNDPAG,    ';
    strSQL := strSQL + '    :SUGEST)    ';

    With qryCliCnd, SQL do
    Begin
      Clear;
      Add('SELECT * FROM CLICND       ');
      Add('WHERE CND_CODCLI = :CLICON ');
      If fCfgSis('USACND', varBoolean) Then
        Add('AND CND_CODCND NOT IN (SELECT CND_CODCND FROM CLICND WHERE CND_CODCLI = :CLICAD) ')
      Else
        Add('AND CND_CNDPAG NOT IN (SELECT CND_CNDPAG FROM CLICND WHERE CND_CODCLI = :CLICAD) ');
      Add('ORDER BY CND_CODCND, CND_CNDPAG ');
      ParamByName('CLICON').AsString := fRetClienteConsumidor(edtEstado.Text);
      ParamByName('CLICAD').AsString := strCodCli;
      Open;

      If Not IsEmpty Then
      Begin
        First;

        While Not EOF do
        Begin
          If fEmptyStr(FieldByName('CND_CODCND').AsString) And fEmptyStr(FieldByName('CND_CNDPAG').AsString) Then
          Begin
            Next;
            Continue;
          End;

          With qryGen Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);

            ParamByName('AUTINC').AsString := fRetAutoIncrem('CLICND', VS_strCodEmp);
            ParamByName('CODCLI').AsString := strCodCli;
            If Not fEmptyStr(qryCliCnd.FieldByName('CND_CODCND').AsString) Then
              ParamByName('CODCND').AsString := qryCliCnd.FieldByName('CND_CODCND').AsString
            Else
              ParamByName('CODCND').Clear;
            If Not fEmptyStr(qryCliCnd.FieldByName('CND_CNDPAG').AsString) Then
              ParamByName('CNDPAG').AsString := qryCliCnd.FieldByName('CND_CNDPAG').AsString
            Else
              ParamByName('CNDPAG').Clear;
            ParamByName('SUGEST').AsString := 'N';

            ExecSQL;
          End;

          Next;
        End;

      End;

    End;

  Except
    On E: Exception Do
      pMensagensErro('Falha no pré cadastro do cliente: '+ E.Message, '[pIncluiCondPagtoConsumidor]');
  End;

  FreeAndNil(qryGen);
  FreeAndNil(qryCliCnd);
end;

procedure TfrmFatDadosCliConsumidor.pAlterarConsumidor;
  Var
    strSQL : String;
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  Try
    strSQL := '';
    strSQL := strSQL + 'UPDATE CLICON SET ';
    strSQL := strSQL + '  CON_CODEMP = :CODEMP, ';
    strSQL := strSQL + '  CON_NOMCON = :NOMCON, ';
    strSQL := strSQL + '  CON_ENDERE = :ENDERE, ';
    strSQL := strSQL + '  CON_BAIRRO = :BAIRRO, ';
    strSQL := strSQL + '  CON_C_E_P_ = :C_E_P_, ';
    strSQL := strSQL + '  CON_CODCID = :CODCID, ';
    strSQL := strSQL + '  CON_FONE01 = :FONE01, ';
    strSQL := strSQL + '  CON_NUMR_G = :NUMR_G, ';
    strSQL := strSQL + '  CON_I_E_S_ = :I_E_S_, ';
    strSQL := strSQL + '  CON_EMLCON = :EMLCON, ';
    strSQL := strSQL + '  CON_EMAIL2 = :EMAIL2, ';
    strSQL := strSQL + '  CON_NASCON = :NASCON, ';

    If (fCfgSis('PRECAD', varBoolean)) Then
    Begin
      strSQL := strSQL + '  CON_CODATI = :CODATI, ';
      strSQL := strSQL + '  CON_CODCAC = :CODCAC, ';
    End;

    strSQL := strSQL + '  CON_CODREG = :CODREG, ';
    strSQL := strSQL + '  CON_CELULA = :CELULA  ';
    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '  CON_C_P_F_ = :C_P_F_ ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODEMP').AsString      := VS_strCodEmp;
      ParamByName('NOMCON').AsString      := edtNomCli.Text;
      ParamByName('ENDERE').AsString      := edtEndere.Text;
      ParamByName('BAIRRO').AsString      := edtBairro.Text;
      ParamByName('C_E_P_').AsString      := mskNumCep.Text;
      ParamByName('CODCID').AsString      := edtCodCid.Text;
      ParamByName('FONE01').AsString      := mskTelCon.Text;
      ParamByName('CELULA').AsString      := edtCelula.Text;
      ParamByName('C_P_F_').AsString      := fTiraCaracEspeciais(mskNumCgc.Text);

      If (edtCgcCpf.Text = '2') Then
      Begin
        ParamByName('NUMR_G').AsString      := edtRgCli.Text;
        ParamByName('I_E_S_').AsString      := '';
      End
      Else
      Begin
        ParamByName('NUMR_G').AsString      := '';
        ParamByName('I_E_S_').AsString      := edtInsEst.Text;
      End;

      ParamByName('EMLCON').AsString      := edtEmail_.Text;
      ParamByName('EMAIL2').AsString      := edtEmail2.Text;

      If (fCfgSis('PRECAD', varBoolean)) Then
      Begin
        ParamByName('CODATI').AsString      := edtCodAtividade.Text;
        ParamByName('CODCAC').AsString      := edtCodCac.Text;
      End;

      If mskDtaNas.Visible And (strToDateDef(mskDtaNas.Text, 0) > 0) Then
        ParamByName('NASCON').AsDateTime  := strToDateDef(mskDtaNas.Text, 0);

      ParamByName('CODREG').AsString      := edtCodReg.Text;

      if blnTemDivergenciaSefaz then
        pSalvaDataConsultaSefaz('CLICON', 'CON_DTASEF', qryCliCon.FieldByName('AUTOINCREM').AsString, fRetDataServidor);

      ExecSQL;
    End;
  Except
    pMensagensErro('Falha na Alteração do Consumidor!', '[ Altera registro ]');
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmFatDadosCliConsumidor.mskNumCgcExit(Sender: TObject);
  Var
    strCodCliAux: String;
begin
  inherited;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskNumCgc.Text))) And (fRetCgcCpf(strCodCli) <> fTiraCaracEspeciais(mskNumCgc.Text)) Then
    pCarregaConsumidor;

  pnlEndNumCom.Visible := False;
  lblDtaNas.Visible := blnNasCon And (edtCgcCpf.Text = '2');
  mskDtaNas.Visible := blnNasCon And (edtCgcCpf.Text = '2');

  If (blnUtilizarPreCadastroConsumidor or blnUtilizaPreCadastroCupomFiscal) And fValidaCgcCpf Then
  Begin
    strCodCliAux := fRetClientePorCgcCpf(StrToIntDef(edtCgcCpf.Text, 0), fTiraCaracEspeciais(mskNumCgc.Text));

    If (Not fEmptyStr(strCodCliAux)) And (Not fClienteConsumidor(fRetNomCliente(strCodCliAux))) Then
    Begin
      If fMensagem('','Já existe um cliente cadastrado com este documento, deseja utilizar o mesmo?', ['','']) = 1 Then
        pConfirmaClientePreCadastro(True)
      Else
      Begin
        pLimparCampos;
        mskNumCgc.Clear;
        pSetFocus(mskNumCgc);
      End;
    End;

    pnlEndNumCom.Visible := ((Not fClienteConsumidor(fRetNomCliente(strCodCliAux))) And fEmptyStr(edtEndere.Text));
    lblDtaNas.Visible    := (Not fClienteConsumidor(fRetNomCliente(strCodCliAux))) Or lblDtaNas.Visible;
    mskDtaNas.Visible    := (Not fClienteConsumidor(fRetNomCliente(strCodCliAux))) Or mskDtaNas.Visible;
  End;

end;

procedure TfrmFatDadosCliConsumidor.mskNumCepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
   Key := #0;

    mskNumCep.Text := fConsultarCep(Self,
                                    mskNumCep.Text,
                                    mskNumCep);
  End;
end;

procedure TfrmFatDadosCliConsumidor.FormShow(Sender: TObject);
begin
  inherited;

  If (Assigned(objVenda)) And (Assigned(objVenda.objCopiaSegVenda)) Then
  Begin
    If objVenda.objCopiaSegVenda.Habilitado Then
      objVenda.objCopiaSegVenda.pSetDadosClienteConsumidor(TForm(Self));
  End;

  pnlEndNumCom.Visible := False;
  lblDtaNas.Visible    := False;
  mskDtaNas.Visible    := False;
  strCepAnt := mskNumCep.Text;
  strDescriCli := IIF(fClienteSeguradora(fRetNomCliente(strCodCli)), 'Seguradora', 'Consumidor');

  btnConsultaFit.Glyph := Nil;
  ImageSefaz.GetBitmap(0, btnConsultaFit.Glyph);
  btnConsultaFit.Hint := 'Consulta Dados Cadastrais do CNPJ.';

  blnUtilizaPreCadastroCupomFiscal := (fCfgSis('PRECAD', varBoolean) and fCfgSis('PRPCCF', varBoolean));

  Caption := 'Dados referentes ao Cliente - ' + strDescriCli;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskNumCgc.Text))) And
     (fRetCgcCpf(strCodCli) <> fTiraCaracEspeciais(mskNumCgc.Text)) Then
  Begin
    pCarregaConsumidor;
  End;

  btnConsultaFit.Enabled := (edtCgcCpf.Text = '1');

  Label10.Visible := (fCfgSis('PRECAD', varBoolean));
  edtCodAtividade.Visible := (fCfgSis('PRECAD', varBoolean));
  edtNomAtividade.Visible := (fCfgSis('PRECAD', varBoolean));

  lblCanalAcesso.Visible := (fCfgSis('PRECAD', varBoolean));
  edtCodCac.Visible      := lblCanalAcesso.Visible;
  edtDesCadCac.Visible   := lblCanalAcesso.Visible;

  lblDtaNas.Visible := blnNasCon And (edtCgcCpf.Text = '2');
  mskDtaNas.Visible := blnNasCon And (edtCgcCpf.Text = '2');

  If (fCfgSis('UTIWPP', varBoolean)) Then
  Begin
    lblCelular.Caption := 'Cel/Whatsapp:';
    imgWpp.Visible := True;
  End;
end;

procedure TfrmFatDadosCliConsumidor.edtCgcCpfKeyPress(Sender: TObject;
  var Key: Char);

  Var
    chrKey: Char;
    arrConsumidores: TConsultasArray;
    qryConsum : TUniQuery;

begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE CONSUMIDORES *}
  {******************************AC*}
  Try
    qryConsum := fCriaQuery(Nil);

    chrKey := Key;
    fPesqConsumidores(Self, Nil, Nil, EdtCgcCpf, MskNumCgc, qryConsum, chrKey, arrConsumidores);
    If fEntraCons(Key) Then
      Self.SelectNext(ActiveControl, True, True);
  Finally
    FreeAndNil(qryConsum);
  End;
end;

procedure TfrmFatDadosCliConsumidor.pLimparCampos;
begin
  edtNomCli.Clear;
  edtEndere.Clear;
  edtBairro.Clear;
  mskNumCep.Clear;
  edtCodCid.Clear;
  mskTelCon.Clear;
  edtCelula.Clear;
  edtInsEst.Clear;
  edtRgCli.Clear;
  edtEmail_.Clear;
  edtEmail2.Clear;
  edtNomCid.Clear;
  edtEstado.Clear;
  edtEndNum.Clear;
  edtEndCom.Clear;
  mskDtaNas.Clear;
  edtCodAtividade.Clear;
  edtNomAtividade.Clear;
  edtCodCac.Clear;
  edtDesCadCac.Clear;
  edtCodReg.Clear;
  edtDesReg.Clear;
end;

procedure TfrmFatDadosCliConsumidor.pConfirmaClientePreCadastro(blnCarregar: Boolean);
begin
  If blnCarregar Then
    strCodCliPreCadastro := fRetClientePorCgcCpf(StrToIntDef(edtCgcCpf.Text, 0), fTiraCaracEspeciais(mskNumCgc.Text));

  If Not fEmptyStr(strCodCliPreCadastro) Then
  Begin
    pIncluiCondPagtoConsumidor(strCodCliPreCadastro);
    if not blnUtilizaPreCadastroCupomFiscal then
    begin
      pLimparCampos;
    end;
    blnConfirma := True;
    Close;
  End;
end;

function TfrmFatDadosCliConsumidor.fCadastraClienteConsumidor: Boolean;

  function fRetDtaDataNas : TDate;
  begin
    Result := 0;
    if (mskDtaNas.Visible) then
    begin
      if (mskDtaNas.Text <> '  /  /    ') then
        Result := StrToDate(mskDtaNas.Text)
      else
        Result := 0;
    end;
  end;

begin
  Result := TfrmCadClientes.fCadastroRapidoCliente( strCodCliPreCadastro,           //Var strCodCli: String;
                                                    edtNomCli.Text,                 //strNomCli,
                                                    edtNomCli.Text,                 //strFanSob,
                                                    fRetParteEndereco(edtEndere.Text, 1), //strEndere,
                                                    edtEndNum.Text,                 //strEndNum,
                                                    edtEndCom.Text,                 //strEndCom,
                                                    edtBairro.Text,                 //strBairro,
                                                    edtCodCid.Text,                 //strCodCid,
                                                    mskNumCep.Text,                 //strCep,
                                                    mskTelCon.Text,                 //strFone01,
                                                    edtCelula.Text,                 //strCelula,
                                                    edtRgCli.Text,                  //strNum_Rg,
                                                    edtInsEst.Text,                 //strI_E_S_,
                                                    edtEmail_.Text,                 //strEmail,
                                                    edtEmail_.Text,                 //strEmNfe,
                                                    'A',                            //strStatus,
                                                    '',                             //strContat: String;
                                                    StrToIntDef(edtCgcCpf.Text, 0), //intCgcCpf: Integer;
                                                    mskNumCgc.Text,                 //strC_G_C_,
                                                    '',                             //strCodRep,
                                                    '',                             //strCodVen: String;
                                                    0,                              //dta_DtaCad: TDate = 0;
                                                    fRetDtaDataNas,                 //dta_DtaNas: TDate = 0;
                                                    '',                             //str_Fone02: String = '';
                                                    '',                             //str_HomePa: String = '';
                                                    edtCodAtividade.Text,           //str_CodAti: String = '';
                                                    edtEmail2.Text,                 //strEmail2 : String = '';
                                                    '',                             //strNumFax : String = '';
                                                    '',                             //strObserva: String = '';
                                                    '',                             //strRgExp  : String = '';
                                                    True,                           //blnCadCliCon: Boolean = False;
                                                    '',                             //strCRMFre : String = '';
                                                    '',                             //strCRMPor : String = '';
                                                    '',                             //strCRMFai : String = '';
                                                    '',                             //strCRMCat : String = '';
                                                    edtCodReg.Text,                 //strCodReg: String = ''
                                                    edtCodCac.Text);                //strCodCac: String = ''
end;

function TfrmFatDadosCliConsumidor.fVerificaSituacaoRegular: boolean;
var
  strMsgRetorno: string;
const
  strTIPO_CNPJ = '1';
begin
  strMsgRetorno := String.Empty;
  result :=
    (Pos(strOpcDoc,'OR_PD_VN_') = 0) or
    (edtCgcCpf.Text <> strTIPO_CNPJ) or
    (TConsultaCadastroFit.VerificaSituacaoRegular(mskNumCgc.Text,
                                                  edtEstado.Text,
                                                  edtInsEst.Text,
                                                  strMsgRetorno));
  if (not result) and (not strMsgRetorno.IsEmpty) then
    fMensagem('ATENÇÃO!', strMsgRetorno, ['&Ok']);
end;

procedure TfrmFatDadosCliConsumidor.pCarregaRegiao;
Begin
  If Not fEmptyStr(edtCodReg.Text) Then
    edtDesReg.Text := fRetNomRegiao(edtCodReg.Text)
  Else
    edtDesReg.Text := EmptyStr;
End;

function TfrmFatDadosCliConsumidor.fVerificaTamanhoEndereco: boolean;
begin
  Result := True;
  If (Length(edtEndere.Text + edtEndNum.Text + edtEndCom.Text + '     ') > 60) Then
  Begin
    fMensagem('Atenção', 'Total de caracteres formatados para o end. de entrega para Nfe não pode ultrapassar 60 caracteres! Tente abreviar as informações!', ['&Ok']);
    Result := False;
  End;
end;

end.
