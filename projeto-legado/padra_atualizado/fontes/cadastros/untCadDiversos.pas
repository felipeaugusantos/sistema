{***************************}
{* qryConCid -> CADCID     *}
{* qryConAti -> CADATI     *}
{************************JB*}
{***************************}
{* qryCadAti -> CADATI     *}
{* qryCadCid -> CADCID     *}
{************************RV*}
unit untCadDiversos;

interface

uses
  Windows, Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, Menus, EditFocus, Uni, AppEvnts, DB,
  ComboBoxFocus, untLabelRg, untLabelCgcCpf, untFuncoesGenerica, untDBECgcCpf,
  untDBETipoCgcCpf, QColorLabel, BitBtnLockedIncrem, DBMemoFocus, CheckLst,
  frxClass, frxExportCSVTestabilidade, Variants, untLiberacaoFactory, untLiberacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxImage, Vcl.Graphics, untTypesSistema;

type
  TfrmCadDiversos = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodDiv: TDBEditFocus;
    dbeNomDiv: TDBEditFocus;
    Label2: TLabel;
    dbeEndere: TDBEditFocus;
    Label3: TLabel;
    dbeBairro: TDBEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    dbeDtaNas: TDBEditFocus;
    Label6: TLabel;
    dbeCodCid: TDBEditFocus;
    Label7: TLabel;
    Label9: TLabel;
    dbeNumCep: TDBEditFocus;
    dbeNumRg: TDBEditFocus;
    Label12: TLabel;
    dbeDesFun: TDBEditFocus;
    Label13: TLabel;
    dbeFone01: TDBEditFocus;
    Label14: TLabel;
    dbeEmail: TDBEditFocus;
    Label15: TLabel;
    dbeHomPag: TDBEditFocus;
    dbeCodAti: TDBEditFocus;
    Label16: TLabel;
    Label8: TLabel;
    dbeRazSoc: TDBEditFocus;
    Label17: TLabel;
    edtCidade: TEditFocus;
    edtAtividade: TEditFocus;
    edtEstado: TEditFocus;
    pnlFundo: TPanel;
    Label19: TLabel;
    dbeCodCli: TDBEditFocus;
    edtNomCli: TEditFocus;
    lbl1: TLabel;
    dbeDIV_FONE01: TDBEditFocus;
    lbl2: TLabel;
    dbeDIV_FONE1: TDBEditFocus;
    pnlDtaCad: TPanel;
    Label20: TLabel;
    dbeDtaCad: TDBEditFocus;
    dtsCadDiv: TDataSource;
    lbl3: TLabel;
    dbeNumCre: TDBEditFocus;
    lblTipCom: TLabel;
    cbxTipCom: TComboBoxFocus;
    lbl4: TLabel;
    DBEditFocus1: TDBEditFocus;
    LabelCgcCpf1: TLabelCgcCpf;
    LabelRg1: TLabelRg;
    lbl5: TLabel;
    lbl6: TColorLabel;
    dbeStatus: TDBEditFocus;
    btnComAti: TBitBtnLocked;
    btnCadCli: TBitBtnLocked;
    btnAtiGru: TBitBtnLocked;
    dbeObserv: TDBMemoFocus;
    btnFaixa: TBitBtnLocked;
    pnlEmpDiv: TPanel;
    gpbEmpDiv: TGroupBox;
    clbEmpDiv: TCheckListBox;
    pnlPerCom: TPanel;
    lblPerCopPro: TLabel;
    lblPerCop: TLabel;
    lblPerComPro: TLabel;
    lblPerCom: TLabel;
    dbePerCop: TDBEditFocus;
    dbePerCom: TDBEditFocus;
    dbeNumCgc: TDBEditCgcCpf;
    dbeCgcCpf: TDBEditFocus;
    Label10: TLabel;
    dbeCodFor: TDBEditFocus;
    edtNomFor: TEditFocus;
    DBEDTAALT: TDBEditFocus;
    lblDtaAlt: TLabel;
    pnlImgDiv: TPanel;
    lblErrImg: TLabel;
    imgDiv: TcxImage;
    Label11: TLabel;
    dbeNumIes: TDBEditFocus;
    chkCartaoProfissional: TDBCheckBox;
    lblOpcoesSelecaoEmpresa: TLabel;
    popOpSele: TPopupMenu;
    MarcarTodos1: TMenuItem;
    DesmarcarTodos1: TMenuItem;
    N1: TMenuItem;
    InverterSeleo1: TMenuItem;
    dbeNomeMae: TDBEditFocus;
    lblNomeMae: TLabel;
    lblOpeAlt: TLabel;
    dbeOpeAlt: TDBEditFocus;
    edtOperador: TEditFocus;
    Label18: TLabel;
    dbeCodTfu: TDBEditFocus;
    edtNomTfu: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    function dbeCodCidChamaCadastro(Key: Word): String;
    function dbeCodAtiChamaCadastro(Key: Word): String;
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    function dbeCodCliChamaCadastro(Key: Word): String;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnComAtiClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCadCliClick(Sender: TObject);
    procedure dbeCgcCpfExit(Sender: TObject);
    procedure btnAtiGruClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnFaixaClick(Sender: TObject);
    function dbeCodForChamaCadastro(Key: Word): string;
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure dbeNumCepKeyPress(Sender: TObject; var Key: Char);
    procedure imgDivDblClick(Sender: TObject);
    procedure lblOpcoesSelecaoEmpresaClick(Sender: TObject);
    procedure MarcarTodos1Click(Sender: TObject);
    procedure DesmarcarTodos1Click(Sender: TObject);
    procedure InverterSeleo1Click(Sender: TObject);
    procedure dbeCodTfuKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    objLiberacao  : TLiberacao;

    strDivCom: String;

    qryConAti: TUniQuery;
    qryConCid: TUniQuery;
    qryConCli: TUniQuery;
    qryCadAti: TUniQuery;
    qryCadCid: TUniQuery;
    qryConFor: TUniQuery;
    qryConTfu: TUniQuery;

    FPais: TPais;
    blnEmpDiv : Boolean;
    blnCadastroModificado: Boolean;

    strCepAnt: String;
    clbSelecionado     : TCheckListBox;

    procedure pCarregaCidade;
    procedure pAtualizaCidade(qryConsulta: TUniQuery; edtCidade, edtEstado: TEdit;
      dbeCidade, dbeCep: TDBEditFocus; Var strCepAnt: String);
    procedure pCarregaAtividade;
    procedure pCarregaOperador;
    procedure pCarregaCliente;
    procedure pLimpaEdits;
    procedure pCarregaFornecedor;
    procedure pAfterScroll(DataSet: TDataSet);

    procedure pAtribuiTabelas;

    procedure pHabilitarBotoes;
    procedure pCarregaLstEmpresa(strEmpresas: String = '');
    function fGetEmpSelecao: String;
    procedure pAtualizaCodCliDiversos(strCodCli: String);
    function fValidaPercentualComissoes: Boolean;
    procedure pDataSourceDataChange(Sender: TObject; Field: TField);
    procedure pDefinirDataSourceDataChange;
    procedure pCadastroFoiAlterado(Field: TField);
    function fFieldAlterado(Field: TField): Boolean;
    procedure pLimpaImagem;
    procedure pCarregaImagem;
    procedure pBuscaDiversos(strCodDiversos: String = '');
    procedure pSetaCheckList(CheckListBox: TCheckListBox);
    procedure pAbrirPoup;
    procedure pExecutarSelecao(Opcao: TOpcSelecao);
    procedure pMarcaDesmarca(Opcao: Boolean);
    procedure pInverteSelecao;
    function fBloqueiaVinculacaoFornecedor(strCodFor: String): Boolean;
    procedure pCarregaTimeFut;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
    strCodDiversosIniciarCadastro: String;
    class procedure pSetaCamposDefaultDiverso(qryCadDiv: TUniQuery);
    class function fCadastroRapidoDiverso(Var strCodDiv: String;
                                          strNomDiv,
                                          strEndere,
                                          strBairro,
                                          strCodCid,
                                          strCep,
                                          strFone01,
                                          strNum_Rg,
                                          strCodCli,
                                          strEmail,
                                          strCodAti: String;
                                          intCgcCpf: Integer;
                                          strC_G_C_: String;
                                          strI_E_S_: String;
                                          strStatus: String = 'A';
                                          dta_DtaCad: TDate = 0;
                                          dta_DtaNas: TDate = 0;
                                          str_Fone02: String = '';
                                          str_Celula: String = '';
                                          str_HomePa: String = '';
                                          fltPerCom: Double = 0;
                                          fltPerCoP: Double = 0;
                                          strRazSoc: String = '';
                                          strEndNum: String = '';
                                          strObserv: String = '';
                                          strF_A_X_: String = ''): Boolean;
  end;

const
  ARR_TIPCOM: Array[0..3] Of Array[0..1] of String = (('CAD. DE PRODUTOS     ', 'I'),
                                                      ('CAD. DE PROFISSIONAIS', 'P'),
                                                      ('FAIXA DA FATURAMENTO ', 'F'),
                                                      ('CAD. DE CLIENTES     ', 'C'));

implementation

uses SysUtils, untFuncoesSimples, untPai, untFuncIns, untPesqAux, StrUtils,
  untConsultas, untFuncIns2, untCadDivAltComis, untCadClientes, untCadAtividadesGrupos, 
  untCadFaixasComProfissional, untModulo, untConstantes, untCadCid,
  untCadCidades, untImagens, untFuncoesImagem;

{$R *.dfm}

procedure TfrmCadDiversos.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadDiversos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If (Action <> caNone) Then
  Begin
    FreeAndNil(qryCadAti);
    FreeAndNil(qryCadCid);
    FreeAndNil(qryConTfu);
    FreeAndNil(qryConFor);
  End;
end;

procedure TfrmCadDiversos.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;
  objLiberacao := TLiberacao.create;

  strNomeTabela         := 'CADDIV';
  strNomeCampo          := 'DIV_CODDIV';
  qryTabela             := fCriarQuery('SELECT * FROM CADDIV', Self);
  qryTabela.AfterScroll := pAfterScroll;
  dtsCadDiv.DataSet     := qryTabela;

  blnCadastroModificado := False;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodDiv;

  If (fCfgSis('TIPCOM') = 'P') And (fCfgSis('TCOPRO') <> '4') Then
  Begin
    lblTipCom.Visible := fVerificaAcessoSistema('DIVTCO');
    cbxTipCom.Visible := fVerificaAcessoSistema('DIVTCO');
  End
  Else
  Begin
    lblTipCom.Visible := False;
    cbxTipCom.Visible := False;
  End;

  If ((fCfgSis('ORIPRO', varInteger) = 2) And (fCfgSis('TIPCOM') = 'G')) And
     (fCfgSis('TCOPRO') <> '4') Then
  Begin
    lblPerCom.Visible    := False;
    dbePerCom.Visible    := False;
    lblPerComPro.Visible := False;

    lblPerCop.Visible    := False;
    dbePerCop.Visible    := False;
    lblPerCopPro.Visible := False;
  End;

  If (fCfgSis('TIPCOM') = 'G') Then
    btnFaixa.Visible := (Pos(fCfgSis('TCOPRO'),'1_2_') > 0) And
                        (fCfgSis('ORIPRO', varInteger) = 3);

  cbxTipCom.Items.Clear;
  For intCont := 0 To Length(ARR_TIPCOM) -1 Do
    cbxTipCom.Items.Add(ARR_TIPCOM[intCont][0]);

  FPais     := fSetaPais;
  blnEmpDiv := (fCfgSis('EMPDIV', varBoolean));

  strCodDiversosIniciarCadastro := '';
end;

procedure TfrmCadDiversos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objLiberacao);
end;

function TfrmCadDiversos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strCodFor: String;
    blnAtualizar: Boolean;
    strCodCid: string;
    strEndere: string;
    strBairro: string;
    strNomCid: string;
    strEstado: string;

    LCodigoCorreio: String;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA  O CÓDIGO                      *}
    {**************************************MV*}
    If (Sender = dbeCodDiv) Then
    Begin
      If (fEmptyStr(dbeCodDiv.Text)) And (dbeCodDiv.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
        Begin
          pLimparCampos;
          pLimpaImagem;
        End
        Else
        Begin
          pCarregaCidade;
          pCarregaAtividade;
          pCarregaOperador;
          pCarregaCliente;
          pCarregaImagem;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA A SITUAÇÃO                     *}
    {**************************************MM*}
    Else If (Sender = dbeStatus) Then
    Begin
      If fEmptyStr(dbeStatus.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Situação deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If Pos(dbeStatus.Text,'AI') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Situação deve ser (A)tivo ou (I)nativo!', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA  O NOME                        *}
    {**************************************MV*}
    Else If (Sender = dbeNomDiv) Then
    Begin
      If fEmptyStr(dbeNomDiv.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeDtaNas) Then
    Begin
      If (fCfgSis('DTNSDV', varBoolean)) And (fEmptyStr(dbeDtaNas.Text) Or (dbeDtaNas.Text = '  /  /    ')) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data de nascimento deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA  O CODIGO DA CIDADE            *}
    {**************************************MV*}
    Else If (Sender = dbeCodCid) Then
    Begin
      If Not fEmptyStr(dbeCodCid.Text) Then
      Begin
        pCarregaCidade;
        If qryConCid.FieldByName('CID_CODCID').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Cidade deve ser preenchido!', ['&Ok']);
        Result := False;
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

        If (Not fCadCepDadosCep(dbeNumCep.Text,
                                strCodCid,
                                strEndere,
                                strBairro,
                                strNomCid,
                                strEstado,
                                LCodigoCorreio,
                                '',
                                '')) Then
        Begin
          Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
        End
        Else
        Begin

          If (fEmptyStr(dbeCodCid.Text)) Then
          Begin

            If Not fEmptyStr(fRetNomCidade(strCodCid)) Then
            Begin

              If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + edtCidade.Text + ' está em branco.' + #13#10 +
                           'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?', ['&Sim', '&Não']) = 1 Then
              Begin
                pAtualizaCodigoCorreios(dbeCodCid.Text, dbeNumCep.Text);
              End

              Else
                Result := False;

            End
            Else
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
          Else If (Not fEmptyStr(edtCidade.Text)) And (fEmptyStr(dbeEndere.Field.AsString)) Then
          Begin
            dbeEndere.Field.AsString := fTiraCaracEspeciais(edtCidade.Text);
            strEndere                := dbeEndere.Field.AsString;
          End;

          If (Result) Then
          Begin

            blnAtualizar := False;
            If fTiraCaracEspeciais(strCepAnt) <> fTiraCaracEspeciais(dbeNumCep.Text) Then
            Begin
              If fTiraCaracEspeciais(strCepAnt) = '' Then
              Begin
                blnAtualizar := True;
              End
              Else
              If fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1 Then
              Begin
                blnAtualizar := True;
              End

            End;

            If fEmptyStr(dbeCodCid.Text) Or (blnAtualizar) Then
            Begin
              dbeCodCid.Field.AsString := strCodCid;
              pAtualizaCidade(qryConCid, edtCidade, edtEstado, dbeCodCid, Nil, strCepAnt);
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
          strCepAnt := dbeNumCep.Text;

      End;

    End

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
    {* VALIDA O CNPJ OU CGC                  *}
    {**************************************MV*}
    Else If (Sender = dbeNumCgc) Then
    Begin
      If (fEmptyStr(dbeNumCgc.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        Result := fValidaCampos(dbeCgcCpf, True);
        If Result Then
          Result := fValidaCnpjCpf(dbeCgcCpf.Text, dbeNumCgc.Text, False);

        if Result then
        begin
          Result := (Not fExisteCnpjCpf('CADDIV','DIV_CODDIV',dbeCodDiv.Text,'DIV_C_G_C_',dbeNumCgc.Text,edtEstado.Text));

          If (Not Result) And (fCfgSis('VERCGC') = 'L') Then
          Begin
            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'VERCPF';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.objMsgLibera.pAddTexto('Já existe um outro cliente com o CPF ' + TDBEditFocus(Sender).Text + ' cadastrado!');

            Result := objLiberacao.fLibera;
          end;
        end;

        If Not Result Then
          Sender := dbeCgcCpf;

      End;
    End

    Else If (Sender = dbeNumIes) Then
    Begin
      If (Not fEmptyStr(dbeNumIes.Text)) And
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

    {*****************************************}
    {* VALIDA O PERCENTUAL DA COMISSÃO       *}
    {**************************************LU*}
    Else If (Sender = dbePerCom)     And
            (Not dbePerCom.ReadOnly) And
            (dbePerCom.Visible)      And
            (pnlPerCom.Visible)      Then
    Begin

      If fEmptyStr(dbePerCom.Text) Then
      Begin
        fMensagem('','Informar o Percentual de Comissão (sem promoção)!',['&OK']);
        Result := False;
      End
      Else
      Begin
        If fStrToFloat(dbePerCom.Text) < 0 Then
        Begin
          fMensagem('','O Campo Percentual de Comissão (sem promoção) deve ser maior ou igual a zero!',['&OK']);
          Result := False;
        End;
      End;

    End

    {*****************************************}
    {* VALIDA O PERCENTUAL DA COMISSÃO       *}
    {**************************************LU*}
    Else If (Sender = dbePerCop)     And
            (Not dbePerCop.ReadOnly) And
            (dbePerCop.Visible)      And
            (pnlPerCom.Visible)      Then
    Begin

      If fEmptyStr(dbePerCop.Text) Then
      Begin
        fMensagem('','Informar o Percentual de Comissão (com promoção)!',['&OK']);
        Result := False;
      End
      Else
      Begin
        If fStrToFloat(dbePerCop.Text) < 0 Then
        Begin
          fMensagem('','O Campo Percentual de Comissão (com promoção) deve ser maior ou igual a zero!',['&OK']);
          Result := False;
        End;
      End;

    End

    {*****************************************}
    {* VALIDA O CÓDIGO DA ATIVIDADE          *}
    {**************************************MV*}
    Else If (Sender = dbeCodAti) Then
    Begin
      If Not fEmptyStr(dbeCodAti.Text) Then
      Begin
        pCarregaAtividade;
        If qryConAti.FieldByName('ATI_CODATI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa atividade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Atividade deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

      If Result And (strDivCom = '2') And (qryTabela.State In [dsEdit, dsInsert]) Then
      Begin
        If qryConAti.FieldByName('ATI_PERCOM').IsNull Then
          qryTabela.FieldByName('DIV_PERCOM').AsFloat := 0
        Else
          qryTabela.FieldByName('DIV_PERCOM').AsFloat := qryConAti.FieldByName('ATI_PERCOM').AsFloat;

        If qryConAti.FieldByName('ATI_PERCOP').IsNull Then
          qryTabela.FieldByName('DIV_PERCOP').AsFloat := 0
        Else
          qryTabela.FieldByName('DIV_PERCOP').AsFloat := qryConAti.FieldByName('ATI_PERCOP').AsFloat;
      End;

    End

    {*****************************************}
    {* VALIDA O CÓDIGO DE CLIENTE            *}
    {**************************************LU*}
    Else If (Sender = dbeCodCli) Then
    Begin
      If Not fEmptyStr(dbeCodCli.Text) Then
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        If (fCfgSis('CPRODV', varBoolean)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O cód. do Profissional no Cad. Cliente deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          edtNomCli.Text := '';
          dbeCodCli.Field.Value := Null;
        End;
      End;
    End

    Else If (Sender = cbxTipCom) Then
    Begin
      If cbxTipCom.Visible Then
      Begin
        If (cbxTipCom.ItemIndex < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Tipo de Comissão deve ser escolhido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (fCfgSis('TIPCOM') = 'P') Then
            btnFaixa.Visible := (Pos(fCfgSis('TCOPRO'),'1_2_') > 0) And
                                (cbxTipCom.ItemIndex = 2);
        end;
      End;
    End

    Else If (Sender = dbeFone01) Or (Sender = dbeDIV_FONE01) Or (Sender = dbeDIV_FONE1) Then
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

    Else If (Sender = dbeEmail) Then Begin
      If (Not fEmptyStr(dbeEmail.Text)) And (Pos('@', dbeEmail.Text) <= 0) And (Pos(' ', dbeEmail.Text) > 0) Then Begin
        fMensagem('ATENÇÃO!', 'Informe o E-Mail corretamente!', ['&Ok']);
        Result := False;
      End Else Begin
        dbeEmail.Text := Trim(dbeEmail.Text);
      End;
    End

    Else If (Sender = dbeCodFor) Then Begin
      If (Not fEmptyStr(dbeCodFor.Text)) Then Begin
        pCarregaFornecedor;

        If qryConFor.FieldByName('FOR_CODFOR').IsNull Then Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End Else Begin
          strCodFor := fCampoTabela('DIV_CODDIV', 'CADDIV', ['DIV_CODFOR'], [dbeCodFor.Text]);

          If fBloqueiaVinculacaoFornecedor(strCodFor) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Fornecedor já está vinculado a outro cadastro de Profissional!', ['&Ok']);
            Result := False;
          End;
        End;
      End Else Begin
        If (qryTabela.State In [dsInsert, dsEdit]) Then Begin
          qryTabela.FieldByName('DIV_CODFOR').Value := Null;
          edtNomFor.Clear();
        End;
      End;
    End

    Else If (Sender = dbeCodTfu) Then
    Begin
      If (Not fEmptyStr(dbeCodTfu.Text)) Then
      Begin
        pCarregaTimeFut;

        If qryConTfu.FieldByName('TFU_CODTFU').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Time de Futebol não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        If (qryTabela.State In [dsInsert, dsEdit]) Then Begin
          qryTabela.FieldByName('DIV_CODTFU').Value := Null;
          edtNomTfu.Clear();
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadDiversos.fValidaPercentualComissoes: Boolean;
  function fMensagemComissao: Boolean;
  Begin
    Result := True;

    If dbePerCom.Visible And fEmptyStr(dbePerCom.Text) Then
      qryTabela.FieldByName('DIV_PERCOM').AsFloat := 0.00;

    If dbePerCop.Visible And fEmptyStr(dbePerCop.Text) Then
      qryTabela.FieldByName('DIV_PERCOP').AsFloat := 0.00;

    With qryTabela Do
    Begin
      If (FieldByName('DIV_PERCOM').AsFloat = 0) And
         (FieldByName('DIV_PERCOP').AsFloat = 0) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O percentual da comissão para itens sem e com promoção estão zerados. Deseja continuar?', ['&Sim', '&Não']) = 1;
        pSetFocus(dbePerCom);
      End
      Else If (FieldByName('DIV_PERCOM').AsFloat = 0) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O percentual da comissão para itens sem promoção estão zerados. Deseja continuar?', ['&Sim', '&Não']) = 1;
        pSetFocus(dbePerCom);
      End
      Else If (FieldByName('DIV_PERCOP').AsFloat = 0) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'O percentual da comissão para itens com promoção estão zerados. Deseja continuar?', ['&Sim', '&Não']) = 1;
        pSetFocus(dbePerCop);
      End;
    End;
  End;
begin
  Result := True;

  If pnlPerCom.Visible Then
  Begin
    If ((Not cbxTipCom.Visible) And
        (fCfgSis('ORIPRO', varInteger) = 1)) Or
       ((cbxTipCom.Visible)     And
        (SameText(cbxTipCom.Text, ARR_TIPCOM[1][0]))) Then
      Result := fMensagemComissao;
  End;
end;

procedure TfrmCadDiversos.pCarregaOperador;
begin
  edtOperador.Text := '';
  If (Not fEmptyStr(dbeOpeAlt.Text)) Then
    edtOperador.Text := fRetNomeOperador(dbeOpeAlt.Text);
end;

function TfrmCadDiversos.fBloqueiaVinculacaoFornecedor(strCodFor: String): Boolean;
begin
  Result := False;

  If (fCfgSis('PVMFVP', varBoolean)) Then
    Exit;

  If (fEmptyStr(strCodFor)) Then
    Exit;

  If (strCodFor = qryTabela.FieldByName('DIV_CODDIV').AsString) Then
    Exit;

  Result := True;
end;

procedure TfrmCadDiversos.imgDivDblClick(Sender: TObject);
begin
  inherited;
  If qryTabela.State = dsInsert Then
  Begin
    fMensagem('', 'Salve o cadastro antes de inserir a imagem!', ['&Ok']);
    Exit;
  End;

  If qryTabela.isEmpty Then
  Begin
    fMensagem('', 'Selecione um cadastro para continuar!', ['&Ok']);
    Exit;
  End;

  if qryTabela.Active then
  begin
    TfrmImagens.pAbrirImagens(tiDiverso, qryTabela.FieldByName('DIV_CODDIV').AsString);
    pCarregaImagem;
  end;
end;

procedure TfrmCadDiversos.InverterSeleo1Click(Sender: TObject);
begin
  inherited;

  pExecutarSelecao(opcInverter);
end;

procedure TfrmCadDiversos.lblOpcoesSelecaoEmpresaClick(Sender: TObject);
begin
  inherited;

  pSetaCheckList(clbEmpDiv);
  pAbrirPoup;
end;

procedure TfrmCadDiversos.MarcarTodos1Click(Sender: TObject);
begin
  inherited;

  pExecutarSelecao(opcMarcar);
end;

procedure TfrmCadDiversos.pCadastroFoiAlterado(Field: TField);
begin
  If (Not Assigned(dtsCadDiv.DataSet)) Then
    Exit;

  If (dtsCadDiv.DataSet.State = dsInsert) Then
    blnCadastroModificado := True;

  If (dtsCadDiv.DataSet.State <> dsEdit) Then
    Exit;

  If (blnCadastroModificado) Then
    Exit;

  blnCadastroModificado := (fFieldAlterado(Field));
end;

procedure TfrmCadDiversos.pCarregaAtividade;
begin
  pPesquisaCadAti(qryCadAti, qryConAti, dbeCodAti.Text);
  With qryConAti Do
  Begin
    edtAtividade.Text := FieldByName('ATI_DESATI').AsString;
  End;
end;

procedure TfrmCadDiversos.pAbrirPoup;
begin
  popOpSele.Popup(Mouse.CursorPos.X + 2, Mouse.CursorPos.Y + 2);
end;

procedure TfrmCadDiversos.pAfterScroll(DataSet: TDataSet);
  Var
    intIndex: Integer;
Begin

  qryTabela.FieldByName('DIV_C_G_C_').EditMask := fRetMascaraC_G_C_(FPais, fSetaCgcCpf(dbeCGCCPF.Text));

  TDateField(qryTabela.FieldByName('DIV_DTANAS')).EditMask := '99/99/9999';
  TStringField(qryTabela.FieldByName('DIV_FONE01')).EditMask := fRetMascaraFonePais;
  TStringField(qryTabela.FieldByName('DIV_FONE02')).EditMask := fRetMascaraFonePais;
  TStringField(qryTabela.FieldByName('DIV_CELULA')).EditMask := fRetMascaraFonePais;

  TFloatField(qryTabela.FieldByName('DIV_PERCOM')).DisplayFormat := fMskDigitos(2);
  TFloatField(qryTabela.FieldByName('DIV_PERCOP')).DisplayFormat := fMskDigitos(2);

  cbxTipCom.ItemIndex := -1;

  For intIndex := 0 To Length(ARR_TIPCOM) -1 Do
    If (qryTabela.FieldByName('DIV_TIPCOM').AsString = ARR_TIPCOM[intIndex][1]) Then
      cbxTipCom.ItemIndex := intIndex;

  If (fCfgSis('TIPCOM') = 'P') Then
    btnFaixa.Visible := (Pos(fCfgSis('TCOPRO'),'1_2_') > 0) And
                        (cbxTipCom.ItemIndex = 2);

  pHabilitarBotoes;
End;

procedure TfrmCadDiversos.pHabilitarBotoes;
begin
  btnCadCli.Enabled := Not (qryTabela.State In [dsEdit, dsInsert]);
  btnComAti.Enabled := Not (qryTabela.State In [dsEdit, dsInsert]);
  btnAtiGru.Enabled := Not (qryTabela.State In [dsEdit, dsInsert]);
  btnFaixa.Enabled  := Not (qryTabela.State In [dsEdit, dsInsert]);

  cbxTipCom.Enabled := (qryTabela.State In [dsEdit, dsInsert]);

  If (blnEmpDiv) Then
  Begin
    clbEmpDiv.Enabled := (qryTabela.State In [dsEdit, dsInsert]);
    lblOpcoesSelecaoEmpresa.Enabled := (qryTabela.State In [dsEdit, dsInsert]);
  End;

end;

procedure TfrmCadDiversos.pCarregaLstEmpresa(strEmpresas: String = '');
  Var
    qryGen: TUniQuery;
    intLin: Integer;
Begin
  Try
    qryGen := fCriaQuery(Self);
    With qryGen, SQL Do
    Begin
      clbEmpDiv.Items.Clear;
      Clear;
      Add(' SELECT EMP_CODEMP CODEMP, ');
      Add('        CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM ');
      Add('   FROM CADEMP ');
      Open;
      First;
      While Not Eof Do
      Begin

        intLin := clbEmpDiv.Items.Add(FieldByName('EMPNOM').AsString);

        If (Not fEmptyStr(strEmpresas)) Then
          clbEmpDiv.Checked[intLin] := (Pos(FieldByName('CODEMP').AsString, strEmpresas) > 0);

        Next;
      End;

      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadDiversos.pCarregaLstEmpresa]');
    End;
  End;
  If Assigned(qryGen) Then
    FreeAndNil(qryGen);
End;

procedure TfrmCadDiversos.pDataSourceDataChange(Sender: TObject; Field: TField);
Begin
  pCadastroFoiAlterado(Field);
end;

procedure TfrmCadDiversos.pDefinirDataSourceDataChange;
  Var
    i, j, k: Integer;
begin
  Try
    For i := 0 To Self.ComponentCount - 1 Do Begin
      If (Self.Components[i] Is TDataSource) Then Begin
        If (Assigned(TDataSource(Self.Components[i]).DataSet)) Then
          TDataSource(Self.Components[i]).OnDataChange := pDataSourceDataChange;
      End Else If (Self.Components[i] Is TPanel) Then Begin
        For j := 0 To TPanel(Self.Components[i]).ControlCount - 1 Do Begin
          If (TPanel(Self.Components[i]).Controls[j] Is TForm) Then Begin
            For k := 0 To TForm(TPanel(Self.Components[i]).Controls[j]).ComponentCount - 1 Do Begin
              If (TForm(TPanel(Self.Components[i]).Controls[j]).Components[k] Is TDataSource) Then Begin
                If (Assigned(TDataSource(TForm(TPanel(Self.Components[i]).Controls[j]).Components[k]).DataSet)) Then
                  TDataSource(TDataSource(TForm(TPanel(Self.Components[i]).Controls[j]).Components[k])).OnDataChange := pDataSourceDataChange;
              End;
            End;
          End;
        End;
      End
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmCadDiversos.pDefinirDataSourceDataChange]');
  End;
end;

procedure TfrmCadDiversos.pExecutarSelecao(Opcao: TOpcSelecao);
begin
  case Opcao of
    opcMarcar:    pMarcaDesmarca(True);
    opcDesmarcar: pMarcaDesmarca(False);
    opcInverter:  pInverteSelecao;
  End;
end;

procedure TfrmCadDiversos.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, dbeCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldByName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmCadDiversos.pCarregaCidade;
begin
  pPesquisaCadCid(qryCadCid, qryConCid, dbeCodCid.Text);
  With qryConCid Do
  Begin
    edtCidade.Text := FieldByName('CID_NOMCID').AsString;
    edtEstado.Text := FieldByName('CID_ESTADO').AsString;
    If (dbeNumCep.Field <> Nil) And (dbeNumCep.Field.IsNull) Then
      dbeNumCep.Text := FieldByName('CID_C_E_P_').AsString;
  End;
end;

procedure TfrmCadDiversos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('DIV_CODDIV');
  stlCampos.Add('DIV_NOMDIV');
  stlCampos.Add('DIV_RAZSOC');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('DIV_CODDIV');
  stlCamInd.Add('DIV_NOMDIV');

  stlDesInd.Add('Código');
  stlDesInd.Add('Nome');

  qryCadAti := fCriaQuery(Self);
  qryCadCid := fCriaQuery(Self);
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);

  pAtribuiTabelas;
end;

procedure TfrmCadDiversos.pInverteSelecao;
var
  intCount: Integer;
begin
  If Assigned(clbSelecionado) Then
  Begin
    For intCount := 0 to clbSelecionado.Items.Count - 1 Do
    Begin
      If clbSelecionado.Checked [intCount] = True then
        clbSelecionado.Checked [intCount] := False
      Else
        clbSelecionado.Checked [intCount] := True;
    End;
  End;
end;

procedure TfrmCadDiversos.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodDiv, dbeNomDiv, False)
  Else
    pHabilitaCodigo(dbeCodDiv, dbeCodDiv, True);
  pLimpaEdits;

  qryTabela.FieldByName('DIV_DTACAD').AsDateTime := VS_Date;
  qryTabela.FieldByName('DIV_STATUS').AsString   := 'A';
  qryTabela.FieldByName('DIV_CARPRO').AsString   := 'N';
  qryTabela.FieldByName('DIV_OPECAD').AsString   := strLoginUsuarioLogado;

  If pnlPerCom.Visible Then
  Begin
    If dbePerCom.Visible Then
      qryTabela.FieldByName('DIV_PERCOM').AsFloat := 0.00;

    If dbePerCop.Visible Then
      qryTabela.FieldByName('DIV_PERCOP').AsFloat := 0.00;
  End;

  pHabilitarBotoes;

  If (blnEmpDiv) Then
    pCarregaLstEmpresa;

  pLimpaImagem;
end;

procedure TfrmCadDiversos.btnPesquisaClick(Sender: TObject);
  Var
    arrDiversos : TConsultasArray;
    chrKey      : Char;
begin
  {*****************************}
  {* NOVA CONSULTA DE DIVERSOS *}
  {**************************DP*}
  chrKey := '/';
  If fPesqDiversos(Self, Nil, Nil, qryTabela, chrKey, arrDiversos) Then
  Begin
    pCarregaCidade;
    pCarregaAtividade;
    pCarregaOperador;
    pCarregaCliente;
    pHabilitarBotoes;
    pCarregaFornecedor;
    pCarregaImagem;
    pCarregaTimeFut;
    If (blnEmpDiv) Then
      pCarregaLstEmpresa(fGetEmpAceCadDiv(qryTabela.FieldByName('DIV_CODDIV').AsString));
    pSetFocus(btnAlterar);
    blnCadastroModificado := False;
  End;
end;

procedure TfrmCadDiversos.btnCadCliClick(Sender: TObject);
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

  If Not (btnCadCli.Visible And btnCadCli.Enabled) Then
    Exit;

  If (qryTabela.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um registro!', ['&Ok']);
    Exit;
  End;

  If (fEmptyStr(dbeCodDiv.Text)) And (dbeCodDiv.Enabled) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
    Exit;
  End;

  If fEmptyStr(dbeNomDiv.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Nome deve ser preenchido!', ['&Ok']);
    Exit;
  End;

  If (fEmptyStr(dbeCgcCpf.Text)) Or (dbeCgcCpf.Text = '0') Then
  Begin
    fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
    Exit;
  End
  Else If Not fValidaCnpjCpf(dbeCgcCpf.Text, dbeNumCgc.Text, False, True) Then
  Begin
    fMensagem('ATENÇÃO!', 'CNPJ / CPF inválido!', ['&Ok']);
    Exit;
  End;

  If (Not fExisteCnpjCpfCliente(strCodCli, dbeNumCgc.Text, edtEstado.Text)) Then
  Begin
    If (fMensagem('AVISO', 'Confirma a Geração do Cadastro de Clientes?', ['&Sim', '&Não']) = 2) Then
      Exit;

    If TfrmCadClientes.fCadastroRapidoCliente(strCodCli,
                                              dbeNomDiv.Text,
                                              dbeNomDiv.Text,
                                              dbeEndere.Text,
                                              '',
                                              '',
                                              dbeBairro.Text,
                                              dbeCodCid.Text,
                                              dbeNumCep.Text,
                                              dbeFone01.Text,
                                              dbeDIV_FONE1.Text,
                                              dbeNumRg.Text,
                                              '',
                                              dbeEmail.Text,
                                              '',
                                              'A',
                                              '',
                                              StrToInt(dbeCgcCpf.Text),
                                              dbeNumCgc.Text,
                                              '',
                                              '',
                                              StrToDateDef(dbeDtaCad.Text,0),
                                              StrToDateDef(dbeDtaNas.Text,0),
                                              dbeDIV_FONE01.Text,
                                              dbeHomPag.Text,
                                              dbeCodAti.Text) Then
    fMensagem('ATENÇÃO!', 'Geração concluída com sucesso!' + #13 +
                          'Cadastro de Clientes criado com o Código: ' + strCodCli, ['&Ok']);
  End
  Else
  Begin
    If (fMensagem('AVISO', 'Confirma a Atualização do Cadastro de Clientes?', ['&Sim', '&Não']) = 2) Then
      Exit;

    If TfrmCadClientes.fCadastroRapidoCliente(strCodCli,
                                              dbeNomDiv.Text,
                                              dbeNomDiv.Text,
                                              dbeEndere.Text,
                                              '',
                                              '',
                                              dbeBairro.Text,
                                              dbeCodCid.Text,
                                              dbeNumCep.Text,
                                              dbeFone01.Text,
                                              dbeDIV_FONE1.Text,
                                              dbeNumRg.Text,
                                              '',
                                              dbeEmail.Text,
                                              '',
                                              'A',
                                              '',
                                              StrToInt(dbeCgcCpf.Text),
                                              dbeNumCgc.Text,
                                              '',
                                              '',
                                              StrToDateDef(dbeDtaCad.Text,0),
                                              StrToDateDef(dbeDtaNas.Text,0),
                                              dbeDIV_FONE01.Text,
                                              dbeHomPag.Text,
                                              dbeCodAti.Text) Then
    fMensagem('ATENÇÃO!', 'Atualização concluída com sucesso!', ['&Ok']);
  End;

  If Not fEmptyStr(strCodCli) Then
    pAtualizaCodCliDiversos(strCodCli);

  qryTabela.Refresh;
end;

procedure TfrmCadDiversos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  blnCadastroModificado := False;
  pCarregaCidade;
  pCarregaAtividade;
  pCarregaOperador;
  pCarregaCliente;
  pHabilitarBotoes;
  pCarregaFornecedor;
  pCarregaImagem;
  pCarregaTimeFut;
  If (blnEmpDiv) Then
    pCarregaLstEmpresa(fGetEmpAceCadDiv(qryTabela.FieldByName('DIV_CODDIV').AsString));  
end;

procedure TfrmCadDiversos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadDiversos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  blnCadastroModificado := False;
  pCarregaCidade;
  pCarregaAtividade;
  pCarregaOperador;
  pCarregaCliente;
  pCarregaImagem;
  pHabilitarBotoes;
  If (blnEmpDiv) Then
    pCarregaLstEmpresa(fGetEmpAceCadDiv(qryTabela.FieldByName('DIV_CODDIV').AsString));    
end;

procedure TfrmCadDiversos.btnFaixaClick(Sender: TObject);
var
  frmCadFaixasComProfissional: TfrmCadFaixasComProfissional;
begin
  inherited;

  If (Not (btnFaixa.Visible And btnFaixa.Enabled))Then
    Exit;

  If (qryTabela.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um registro!', ['&Ok']);
    Exit;
  End;

  pMensagemOk(btnFaixa.Hint);

  Try
    pCriarFormularios(TfrmCadFaixasComProfissional, frmCadFaixasComProfissional);
    frmCadFaixasComProfissional.strCodDiv := qryTabela.FieldByName('DIV_CODDIV').AsString;
    frmCadFaixasComProfissional.ShowModal;
  Except
    On E: Exception do
      pErro(E.Message);
  End;

  pFreeAndNil(frmCadFaixasComProfissional);
end;

procedure TfrmCadDiversos.btnGravarClick(Sender: TObject);
begin
  If (fCfgSis('TIPCOM') = 'P') Then
  Begin
    If (cbxTipCom.ItemIndex > -1) Then
      qryTabela.FieldByName('DIV_TIPCOM').AsString := ARR_TIPCOM[cbxTipCom.ItemIndex][1];

    If ((fCfgSis('ORIPRO', varInteger) = 2) And (fCfgSis('TIPCOM') = 'G')) And
       (fCfgSis('TCOPRO') <> '4') Then
    Begin
      lblPerCom.Visible    := False;
      dbePerCom.Visible    := False;
      lblPerComPro.Visible := False;

      lblPerCop.Visible    := False;
      dbePerCop.Visible    := False;
      lblPerCopPro.Visible := False;
    End
    Else
    Begin
      lblPerCom.Visible    := True;
      dbePerCom.Visible    := True;
      lblPerComPro.Visible := True;

      lblPerCop.Visible    := True;
      dbePerCop.Visible    := True;
      lblPerCopPro.Visible := True;
    End;
  End;

  If (blnEmpDiv) Then
    qryTabela.FieldByName('DIV_EMPACE').AsString := fGetEmpSelecao;

  If blnCadastroModificado Then
  Begin
    qryTabela.FieldByName('DIV_DTAALT').AsDateTime := VS_Date;
    qryTabela.FieldByName('DIV_OPEALT').AsString   := strLoginUsuarioLogado;
    pCarregaOperador;
  End;

  If (qryTabela.State In [dsInsert, dsEdit]) Then
  Begin
    If fValidacoesBotaoGravarPai And
       fValidaPercentualComissoes Then
    Begin
      blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

      Try
        inherited;
      Except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[untCadDiversos.btnGravarClick]');
        End;
      End;

      If blngravou Then
      Begin
        blnCadastroModificado := False;
        fCommit
      End
      Else
        fRollBack;
    End;
  End;

  pHabilitarBotoes;
end;

procedure TfrmCadDiversos.FormShow(Sender: TObject);
begin
  inherited;
  strOrderOpc := 'DIV_RAZSOC';
  pCarregaCidade;
  pCarregaAtividade;
  pCarregaOperador;
  pCarregaCliente;
  pCarregaImagem;
  pHabilitarBotoes;

  btnComAti.Visible := fVerificaAcessoSistema('COMDIV');
  btnCadCli.Visible := fVerificaAcessoSistema('GERCLI');
  btnAtiGru.Visible := fVerificaAcessoSistema('ATLGDV');

  strDivCom := fCfgSis('DIVCOM');

  pnlPerCom.Enabled := strDivCom = '1';
  pnlPerCom.Visible := pnlPerCom.Enabled;

  If dbePerCom.Visible Then
  Begin
    If fVerificaAcessoSistema('ALTCDV') Then
    Begin
      dbePerCom.ReadOnly    := False;
      dbePerCom.TabStop     := True;
      dbePerCom.Color       := clWindow;
      dbePerCom.NormalColor := clWindow;
      dbePerCom.FocusColor  := clInfoBk;
    End
    Else
    Begin
      dbePerCom.ReadOnly    := True;
      dbePerCom.TabStop     := False;
      dbePerCom.Color       := $00FFDFB8;
      dbePerCom.NormalColor := $00FFDFB8;
      dbePerCom.FocusColor  := $00FFDFB8;
    End;

    dbePerCop.ReadOnly    := dbePerCom.ReadOnly;
    dbePerCop.TabStop     := dbePerCom.TabStop;
    dbePerCop.Color       := dbePerCom.Color;
    dbePerCop.NormalColor := dbePerCom.NormalColor;
    dbePerCop.FocusColor  := dbePerCom.FocusColor;
  End;

  If Not (blnEmpDiv) Then
  Begin
    pnlEmpDiv.Visible := False;
    //Self.Width := Self.Width - pnlEmpDiv.Width;
  End;

  pDefinirDataSourceDataChange();

//  blnUsaVerificaCamposPai := False;

  if not fEmptyStr(strCodDiversosIniciarCadastro) Then
  begin
    pBuscaDiversos(strCodDiversosIniciarCadastro);
  end;

end;

procedure TfrmCadDiversos.dbeCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, dbeCodCid, edtCidade, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadDiversos.dbeCodAtiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrAtiv: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, dbeCodAti, edtAtividade, Nil, Key, arrAtiv) Then
  Begin
    If fValidaCampos(dbeCodAti, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadDiversos.btnAtiGruClick(Sender: TObject);
begin
  inherited;
  If Not (btnAtiGru.Visible And btnAtiGru.Enabled) Then
    Exit;

  pMensagemOk(btnAtiGru.Hint);
  pCriarForm(TfrmCadAtividadesGrupos);
  qryTabela.Refresh;
end;

procedure TfrmCadDiversos.btnAlterarClick(Sender: TObject);
begin
  inherited;

  strCepAnt := qryTabela.FieldByName('DIV_C_E_P_').AsString;

  pHabilitaCodigo(dbeCodDiv, dbeNomDiv, False);
  pHabilitarBotoes;
end;

procedure TfrmCadDiversos.pLimpaEdits;
begin
  edtOperador.Clear;
  edtCidade.Clear;
  edtEstado.Clear;
  edtAtividade.Clear;
  edtNomCli.Clear;
  edtNomFor.Clear;
  dbePerCom.Text := '0,00';
  dbePerCop.Text := '0,00';  
end;

procedure TfrmCadDiversos.pLimpaImagem;
begin
  imgDiv.Picture := Nil;
  imgDiv.Visible := False;
  lblErrImg.Visible := False;
end;

procedure TfrmCadDiversos.pMarcaDesmarca(Opcao: Boolean);
var
  intCount: Integer;
begin
  If Assigned(clbSelecionado) Then
  Begin
    for intCount := 0 to clbSelecionado.Items.Count - 1 do
      clbSelecionado.Checked [intCount] := Opcao;
  End;
end;

class procedure TfrmCadDiversos.pSetaCamposDefaultDiverso(qryCadDiv: TUniQuery);
begin
  qryCadDiv.FieldByName('DIV_CODEMP').AsString   := VS_strCodEmp;
  qryCadDiv.FieldByName('DIV_PERCOM').AsFloat    := 0;
  qryCadDiv.FieldByName('DIV_PERCOP').AsFloat    := 0;  
  qryCadDiv.FieldByName('DIV_DTACAD').AsDateTime := VS_Date;
  If (fCfgSis('EMPDIV', varBoolean)) Then
    qryCadDiv.FieldByName('DIV_EMPACE').AsString := VS_strCodEmp + '_';

  qryCadDiv.FieldByName('DIV_CARPRO').AsString   := 'N';
end;

procedure TfrmCadDiversos.pSetaCheckList(CheckListBox: TCheckListBox);
begin
  clbSelecionado := CheckListBox;
end;

function TfrmCadDiversos.dbeCodCidChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadCid(Key);
  pAtribuiTabelas;
end;

function TfrmCadDiversos.dbeCodAtiChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadAti(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadDiversos.pAtribuiTabelas;
begin
  qryConCid := qryCadCid;
  qryConAti := qryCadAti;

  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConTfu := fCriarQuery('SELECT * FROM CADTFU WHERE FALSE', Self);
end;

procedure TfrmCadDiversos.pAtualizaCidade(qryConsulta: TUniQuery; edtCidade, edtEstado: TEdit; dbeCidade, dbeCep: TDBEditFocus; var strCepAnt: String);
begin
  pPesquisaCadCid(qryCadCid, qryConsulta, dbeCidade.Text);

  edtCidade.Text := qryConsulta.FieldByName('CID_NOMCID').AsString;
  edtEstado.Text := qryConsulta.FieldByName('CID_ESTADO').AsString;

  If (Assigned(dbeNumCEp)) And (dbeNumCEp.Field <> Nil) And (dbeNumCEp.Field.IsNull) And (fEmptyStr(dbeNumCEp.Text)) Then
  Begin
    dbeNumCEp.Text := qryConsulta.FieldByName('CID_C_E_P_').AsString;
    strCepAnt   := qryConsulta.FieldByName('CID_C_E_P_').AsString;
  End;

end;

procedure TfrmCadDiversos.pAtualizaCodCliDiversos(strCodCli: String);
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  fStartTransaction;
  Try
    qryTmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' UPDATE CADDIV ';
    strSQL := strSQL + '   SET DIV_CODCLI = :CODCLI ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   DIV_CODDIV = :CODDIV ';

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODDIV').AsString := dbeCodDiv.Text;
      ExecSQL;
    End;

    FreeAndNil(qryTmp);
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pAtualizaCodCliDiversos]');
      FreeAndNil(qryTmp);
    End;
  End;
end;

procedure TfrmCadDiversos.pBuscaDiversos(strCodDiversos: String);
begin
  pPesquisaCadDiv(qryTabela, qryTabela, strCodDiversos);
  if not qryTabela.IsEmpty then
  begin
    pCarregaCidade;
    pCarregaAtividade;
    pCarregaOperador;
    pCarregaCliente;
    pHabilitarBotoes;
    pCarregaFornecedor;
    pCarregaImagem;
    pCarregaTimeFut;
    if (blnEmpDiv) then
      pCarregaLstEmpresa(fGetEmpAceCadDiv(qryTabela.FieldByName('DIV_CODDIV').AsString));
    blnCadastroModificado := False;
    btnAlterar.Click;
  end;
end;

procedure TfrmCadDiversos.dbeCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, dbeCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(dbeCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadDiversos.dbeCodForChamaCadastro(Key: Word): string;
begin
  inherited;

  If fVerificaAcessoSistema('frmCadFornecedores') Then Begin
    TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
    Result := untFuncIns.fChamaCadFor(Key);
  End Else
    fMensagem('','Sem permissão para Cadastro de Fornecedores',['&Ok']);
end;

procedure TfrmCadDiversos.dbeCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, dbeCodFor, Nil, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbeCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadDiversos.dbeCodTfuKeyPress(Sender: TObject; var Key: Char);
  Var
    arrTimeFut: TConsultasArray;
begin
  inherited;

  If fPesqTimesFutebolCliCon(Self, dbeCodTfu, edtNomTfu, qryConTfu, Key, arrTimeFut) Then
  Begin
    If fValidaCampos(dbeCodTfu, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadDiversos.dbeNumCepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Key := #0;

    dbeNumCep.Text := fConsultarCep(Self, dbeNumCep.Text, dbeNumCep);

  End;
end;

procedure TfrmCadDiversos.DesmarcarTodos1Click(Sender: TObject);
begin
  inherited;

  pExecutarSelecao(opcDesmarcar);
end;

procedure TfrmCadDiversos.dbeCgcCpfExit(Sender: TObject);
begin
  inherited;
  qryTabela.FieldByName('DIV_C_G_C_').EditMask := fRetMascaraC_G_C_(FPais, fSetaCgcCpf(dbeCGCCPF.Text));
end;

function TfrmCadDiversos.dbeCodCliChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadCli(Key);
  pAtribuiTabelas;
end;

class function TfrmCadDiversos.fCadastroRapidoDiverso(Var strCodDiv: String;
                                                      strNomDiv,
                                                      strEndere,
                                                      strBairro,
                                                      strCodCid,
                                                      strCep,
                                                      strFone01,
                                                      strNum_Rg,
                                                      strCodCli,
                                                      strEmail,
                                                      strCodAti: String;
                                                      intCgcCpf: Integer;
                                                      strC_G_C_: String;
                                                      strI_E_S_: String;
                                                      strStatus: String = 'A';
                                                      dta_DtaCad: TDate = 0;
                                                      dta_DtaNas: TDate = 0;
                                                      str_Fone02: String = '';
                                                      str_Celula: String = '';
                                                      str_HomePa: String = '';
                                                      fltPerCom: Double = 0;
                                                      fltPerCoP: Double = 0;
                                                      strRazSoc: String = '';
                                                      strEndNum: String = '';
                                                      strObserv: String = '';
                                                      strF_A_X_: String = ''): Boolean;
  Var
    qryCadDiv: TUniQuery;
    blnTransacaoExterna : Boolean;

  function fProximoCodigo: String;
  begin
    Result := fAtualizaProCod('CADDIV', 'DIV_CODDIV');
  end;

begin
  Result := False;

  Try
    If fEmptyStr(strCodDiv) Then
      qryCadDiv := fCriarQuery('SELECT * FROM CADDIV WHERE FALSE')
    Else
      qryCadDiv := fCriarQuery('SELECT * FROM CADDIV WHERE DIV_CODDIV = ' + QuotedStr(strCodDiv));

    qryCadDiv.Open;

    blnTransacaoExterna := frmModulo.GetCurrentConnection.InTransaction;

    If Not blnTransacaoExterna Then
      fStartTransaction;

    If fEmptyStr(strCodDiv) Then
    Begin
      If fUsaProCodigo('CADDIV') Then
        strCodDiv := fProximoCodigo;
      qryCadDiv.Append;
      pSetaCamposDefaultDiverso(qryCadDiv);
      qryCadDiv.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('CADDIV', VS_strCodEmp);
      qryCadDiv.FieldByName('DIV_PERCOM').AsFloat := fltPerCom;
      qryCadDiv.FieldByName('DIV_PERCOP').AsFloat := fltPerCoP;
      qryCadDiv.FieldByName('DIV_OPECAD').AsString := strLoginUsuarioLogado;
    End
    Else
    Begin
      qryCadDiv.Edit;
      qryCadDiv.FieldByName('DIV_DTAALT').AsDateTime := VS_Date;
      qryCadDiv.FieldByName('DIV_OPEALT').AsString   := strLoginUsuarioLogado;
    End;

    qryCadDiv.FieldByName('DIV_CODDIV').AsString  := strCodDiv;
    qryCadDiv.FieldByName('DIV_NOMDIV').AsString  := strNomDiv;
    qryCadDiv.FieldByName('DIV_BAIRRO').AsString  := strBairro;
    qryCadDiv.FieldByName('DIV_CODCID').AsString  := strCodCid;
    qryCadDiv.FieldByName('DIV_C_E_P_').AsString  := fTiraCaracEspeciais(strCep);
    qryCadDiv.FieldByName('DIV_FONE01').AsString  := fTiraCaracEspeciais(strFone01);
    qryCadDiv.FieldByName('DIV_NUMR_G').AsString  := strNum_Rg;
    qryCadDiv.FieldByName('DIV_CODCLI').AsString  := strCodCli;
    qryCadDiv.FieldByName('DIV_EMAIL_').AsString  := strEmail;
    qryCadDiv.FieldByName('DIV_CGCCPF').AsInteger := intCgcCpf;
    qryCadDiv.FieldByName('DIV_C_G_C_').AsString  := strC_G_C_;

    If Not fEmptyStr(strI_E_S_) Then
      qryCadDiv.FieldByName('DIV_I_E_S_').AsString  := strI_E_S_
    Else
      qryCadDiv.FieldByName('DIV_I_E_S_').Value := Null;

    If Not fEmptyStr(strCodAti) Then
      qryCadDiv.FieldByName('DIV_CODATI').AsString := strCodAti
    Else
      qryCadDiv.FieldByName('DIV_CODATI').Value := Null;

    qryCadDiv.FieldByName('DIV_STATUS').AsString  := strStatus;

    If (fEmptyStr(strEndNum)) Then
      qryCadDiv.FieldByName('DIV_ENDERE').AsString := strEndere
    Else
      qryCadDiv.FieldByName('DIV_ENDERE').AsString := strEndere + ', ' + strEndNum;

    qryCadDiv.FieldByName('DIV_DTACAD').AsDateTime  := dta_DtaCad;
    qryCadDiv.FieldByName('DIV_FONE02').AsString    := str_Fone02;
    qryCadDiv.FieldByName('DIV_CELULA').AsString    := str_Celula;
    qryCadDiv.FieldByName('DIV_DTANAS').AsDateTime  := dta_DtaNas;
    qryCadDiv.FieldByName('DIV_HOMEPA').AsString    := str_HomePa;

    if qryCadDiv.FieldByName('DIV_DTANAS').AsDateTime <= 0 Then
      qryCadDiv.FieldByName('DIV_DTANAS').Clear;

    if qryCadDiv.FieldByName('DIV_DTACAD').AsDateTime <= 0 Then
      qryCadDiv.FieldByName('DIV_DTACAD').AsDateTime := fNow();

    qryCadDiv.FieldByName('DIV_RAZSOC').AsString := strRazSoc;
    qryCadDiv.FieldByName('DIV_F_A_X_').AsString := strF_A_X_;
    qryCadDiv.FieldByName('DIV_OBSERV').AsString := strObserv;

    qryCadDiv.Post;

    FreeAndNil(qryCadDiv);

    Result := True;
    fCommit;

  Except

    On E: EUniError Do
    Begin
      If E.ErrorCode = ERROR_PRIMARY_KEY_INSERT Then
      Begin
        fRollBack;
        pMensagensErro(E.Message,'Já existe um registro com esses Dados!', '[ Gravar registro ]');
      End
      Else
      Begin
        fRollBack;
        pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[ Gravar registro ]');
      End;
    End;

    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, 'Gravar Registro');
    End;

  End;
end;

function TfrmCadDiversos.fFieldAlterado(Field: TField): Boolean;
begin
  Result := False;

  If (Not Assigned(Field)) Then
    Exit;

  Try
    If (Field.OldValue <> Field.NewValue) And
       (Field.FieldName <> 'DIV_DTAALT') Then
    Begin

      If (Field.DataType = ftString) And
         (
           (
             (Field.OldValue = '') And
             (Field.NewValue = Null)
           )
             Or
           (
             (Field.OldValue = Null) And
             (Field.NewValue = '')
           )
         ) Then
        Result := False
      Else Begin
        Result := True;
        Exit;
      End;

    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmCadDiversos.fFieldAlterado]');
  End;
end;

function TfrmCadDiversos.fGetEmpSelecao: String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := 0 To clbEmpDiv.Count -1 Do
  Begin
    If (clbEmpDiv.Checked[intCnt]) Then
      Result := Result + LeftStr(clbEmpDiv.Items.Strings[intCnt], 3) + '_';
  End;
end;

procedure TfrmCadDiversos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F4) Then
    btnCadCli.Click

  Else If (Key = VK_F5) Then
    btnComAti.Click

  Else If (Key = VK_F6) Then
    btnAtiGru.Click

  Else If (Key = VK_F7) Then
    btnFaixa.Click;

end;

procedure TfrmCadDiversos.btnComAtiClick(Sender: TObject);
begin
  inherited;
  If Not (btnComAti.Visible And btnComAti.Enabled) Then
    Exit;

  pMensagemOk(btnComAti.Hint);
  pCriarForm(TfrmCadDivAltComis);
  qryTabela.Refresh;
end;

procedure TfrmCadDiversos.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, dbeCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmCadDiversos.pCarregaImagem;
begin
  if (qryTabela.Active) And (Not fEmptyStr(qryTabela.FieldByName('DIV_CODDIV').AsString)) Then
  Begin
    imgDiv.Picture := nil;
    Application.ProcessMessages;

    Case fCarregaImagemDiverso(qryTabela.FieldByName('DIV_CODDIV').AsString, imgDiv.Picture) of
      riOk   :
      Begin
        imgDiv.Visible := True;
        lblErrImg.Visible := False;
      End;
      riErro :
      Begin
        imgDiv.Visible := False;
        lblErrImg.Visible := True;
      End;
      riNulo :
      Begin
        imgDiv.Visible := False;
        lblErrImg.Visible := False;
      End;
    End;
  End
  Else
    imgDiv.Picture := nil;

  Application.ProcessMessages;
end;

procedure TfrmCadDiversos.pCarregaTimeFut;
begin
  pPesquisaCadTfu(qryConTfu, qryConTfu, dbeCodTfu.Text);
  edtNomTfu.Text := qryConTfu.FieldByName('TFU_DESTFU').AsString;
end;

end.
