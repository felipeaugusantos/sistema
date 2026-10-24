{*****************************************}
{* frmModuloCons.qryCon001 -> CADCID     *}
{* frmModuloCons.qryCon002 -> CADOPE(VEN)*}
{* frmModuloCons.qryCon003 -> CADOPE(REP)*}
{* frmModuloCons.qryCon004 -> CADATI     *}
{* frmModuloCons.qryCon005 -> CADCID(COB)*}
{* frmModuloCons.qryCon006 -> CADCID(ENT)*}
{* frmModuloCons.qryCon007 -> CADCND     *}
{* frmModuloCons.qryCon008 -> CADFPG     *}
{* frmModuloCons.qryCon009 -> TIPCLG     *}
{* frmModuloCons.qryCon010 -> CADPOR     *}
{**************************************MV*}
unit untCadClientes;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, Uni, EditFocus, DB, untConstantes,
  QColorLabel, Menus, StrUtils, DBMemoFocus;

type
  TfrmCadClientes = class(TfrmPaiCad)
    tbsObservacoes: TTabSheet;
    tbsCbrEnt: TTabSheet;
    tbsQuadSoc: TTabSheet;
    tbsRefBan: TTabSheet;
    tbsRefCom: TTabSheet;
    tbsDadPro: TTabSheet;
    Label48: TLabel;
    dbeEndCob: TDBEditFocus;
    Label49: TLabel;
    dbeCidCob: TDBEditFocus;
    Label51: TLabel;
    dbeCepCob: TDBEditFocus;
    Label53: TLabel;
    Label54: TLabel;
    dbeBaiCob: TDBEditFocus;
    Label55: TLabel;
    dbeConCob: TDBEditFocus;
    Label56: TLabel;
    dbeTelCob: TDBEditFocus;
    Label57: TLabel;
    dbeEndEnt: TDBEditFocus;
    Label58: TLabel;
    dbeCidEnt: TDBEditFocus;
    Label60: TLabel;
    dbeCepEnt: TDBEditFocus;
    Label62: TLabel;
    Label63: TLabel;
    dbeBaiEnt: TDBEditFocus;
    Label64: TLabel;
    dbeConEnt: TDBEditFocus;
    Label65: TLabel;
    dbeTelEnt: TDBEditFocus;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    dbeNomSc1: TDBEditFocus;
    Label69: TLabel;
    dbeCgCpS1: TDBEditFocus;
    dbeCgcSc1: TDBEditFocus;
    Label70: TLabel;
    dbeDtaNS1: TDBEditFocus;
    Label71: TLabel;
    dbeValPs1: TDBEditFocus;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    dbeNomSc2: TDBEditFocus;
    Label75: TLabel;
    dbeCgCpS2: TDBEditFocus;
    dbeCgcSc2: TDBEditFocus;
    Label76: TLabel;
    dbeDtaNS2: TDBEditFocus;
    Label77: TLabel;
    dbeValPs2: TDBEditFocus;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    dbeNomSc3: TDBEditFocus;
    Label81: TLabel;
    dbeCgCpS3: TDBEditFocus;
    dbeCgcSc3: TDBEditFocus;
    Label82: TLabel;
    dbeDtaNS3: TDBEditFocus;
    Label83: TLabel;
    dbeValPs3: TDBEditFocus;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    dbeNomBc1: TDBEditFocus;
    dbeAgeBc1: TDBEditFocus;
    Label88: TLabel;
    Label89: TLabel;
    dbeTelBc1: TDBEditFocus;
    dbeConBc1: TDBEditFocus;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    dbeNomBc2: TDBEditFocus;
    dbeAgeBc2: TDBEditFocus;
    Label93: TLabel;
    Label94: TLabel;
    dbeTelBc2: TDBEditFocus;
    dbeConBc2: TDBEditFocus;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    dbeNomBc3: TDBEditFocus;
    dbeAgeBc3: TDBEditFocus;
    Label98: TLabel;
    Label99: TLabel;
    dbeTelBc3: TDBEditFocus;
    dbeConBc3: TDBEditFocus;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    dbeNomEm1: TDBEditFocus;
    dbeCgcPf1: TDBEditFocus;
    Label105: TLabel;
    dbeCgcEm1: TDBEditFocus;
    Label104: TLabel;
    dbeTelEm1: TDBEditFocus;
    Label106: TLabel;
    dbeConEm1: TDBEditFocus;
    Label107: TLabel;
    Label108: TLabel;
    dbeNomEm2: TDBEditFocus;
    dbeCgcPf2: TDBEditFocus;
    Label109: TLabel;
    dbeCgcEm2: TDBEditFocus;
    Label110: TLabel;
    dbeTelEm2: TDBEditFocus;
    Label111: TLabel;
    dbeConEm2: TDBEditFocus;
    Label112: TLabel;
    Label113: TLabel;
    dbeNomEm3: TDBEditFocus;
    dbeCgcPf3: TDBEditFocus;
    Label114: TLabel;
    dbeCgcEm3: TDBEditFocus;
    Label115: TLabel;
    dbeTelEm3: TDBEditFocus;
    Label116: TLabel;
    dbeConEm3: TDBEditFocus;
    Label117: TLabel;
    dbeNomPai: TDBEditFocus;
    Label118: TLabel;
    dbeNomMae: TDBEditFocus;
    Label119: TLabel;
    dbeConjug: TDBEditFocus;
    Label120: TLabel;
    dbeNasCon: TDBEditFocus;
    Label121: TLabel;
    dbeProfis: TDBEditFocus;
    Label122: TLabel;
    dbeTrabal: TDBEditFocus;
    Label123: TLabel;
    dbeEndSer: TDBEditFocus;
    Label124: TLabel;
    Label125: TLabel;
    dbeTemSer: TDBEditFocus;
    Label126: TLabel;
    dbeTelSer: TDBEditFocus;
    Label127: TLabel;
    dbeSalari: TDBEditFocus;
    Label128: TLabel;
    dbeOutRen: TDBEditFocus;
    Label129: TLabel;
    dbeVrAlug: TDBEditFocus;
    Label130: TLabel;
    dbeC_Prof: TDBEditFocus;
    Label131: TLabel;
    Label132: TLabel;
    dbeEndIm1: TDBEditFocus;
    dbeValIm1: TDBEditFocus;
    Label133: TLabel;
    Label134: TLabel;
    dbeEndIm2: TDBEditFocus;
    dbeValIm2: TDBEditFocus;
    Label135: TLabel;
    Label136: TLabel;
    dbeVeicul: TDBEditFocus;
    dbeValVei: TDBEditFocus;
    Label137: TLabel;
    Label138: TLabel;
    dbeObs_Fc: TDBEditFocus;
    dbeTotRen: TDBEditFocus;
    Label59: TLabel;
    dbeEstCs1: TDBEditFocus;
    Label146: TLabel;
    Label155: TLabel;
    dbeEstCs2: TDBEditFocus;
    dbeEstCs3: TDBEditFocus;
    dbeEstCiv: TDBEditFocus;
    Label164: TLabel;
    Label173: TLabel;
    dbeMoradia: TDBEditFocus;
    ColorLabel4: TColorLabel;
    ColorLabel5: TColorLabel;
    ColorLabel6: TColorLabel;
    ColorLabel7: TColorLabel;
    ColorLabel8: TColorLabel;
    edtCidCob: TEditFocus;
    edtEstCob: TEditFocus;
    edtEstEnt: TEditFocus;
    edtCidEnt: TEditFocus;
    btnHisDeb: TBitBtn;
    btnResFin: TBitBtn;
    Panel1: TPanel;
    Label47: TLabel;
    Panel2: TPanel;
    Label29: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label44: TLabel;
    dbeUltCom: TDBEditFocus;
    Label30: TLabel;
    Label46: TLabel;
    dbeVlrUco: TDBEditFocus;
    Label32: TLabel;
    dbeVrmCom: TDBEditFocus;
    dbeDtmCom: TDBEditFocus;
    Label33: TLabel;
    dbeDouCom: TDBEditFocus;
    Label34: TLabel;
    dbeDomCom: TDBEditFocus;
    pnlFundo1: TPanel;
    pnlForPag: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label31: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    Label40: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label37: TLabel;
    ColorLabel1: TColorLabel;
    ColorLabel2: TColorLabel;
    ColorLabel3: TColorLabel;
    Label27: TLabel;
    Label28: TLabel;
    ColorLabel9: TColorLabel;
    dbeCodCli: TDBEditFocus;
    dbeDtaCad: TDBEditFocus;
    dbeNomCli: TDBEditFocus;
    dbeFanSob: TDBEditFocus;
    dbeEndere: TDBEditFocus;
    dbeBairro: TDBEditFocus;
    dbeNumCep: TDBEditFocus;
    dbeNumRg: TDBEditFocus;
    dbeCgcCpf: TDBEditFocus;
    dbeNuCpnj: TDBEditFocus;
    dbeNumIes: TDBEditFocus;
    dbeNumImp: TDBEditFocus;
    dbeFone01: TDBEditFocus;
    dbeRamal1: TDBEditFocus;
    dbeFone02: TDBEditFocus;
    dbeRama2: TDBEditFocus;
    dbeNumFax: TDBEditFocus;
    dbeRama3: TDBEditFocus;
    dbeNumCel: TDBEditFocus;
    dbeDtaNas: TDBEditFocus;
    dbeCaiPos: TDBEditFocus;
    dbeContat: TDBEditFocus;
    dbeEmail: TDBEditFocus;
    dbeHomPag: TDBEditFocus;
    dbeConsum: TDBEditFocus;
    dbeOrgPub: TDBEditFocus;
    dbeCodVen: TDBEditFocus;
    dbeCodRep: TDBEditFocus;
    dbeCodAti: TDBEditFocus;
    dbeLimCre: TDBEditFocus;
    dbeUltAlt: TDBEditFocus;
    dbeCodCid: TDBEditFocus;
    dbeStatus: TDBEditFocus;
    edtNomCid: TEditFocus;
    edtEstado: TEditFocus;
    edtVendedor: TEditFocus;
    edtAtividade: TEditFocus;
    edtRepresentante: TEditFocus;
    dbeTabPre: TDBEditFocus;
    dbeCodCnd: TDBEditFocus;
    edtCndPag: TMaskEdit;
    dbeCndPag: TDBEditFocus;
    lblForPag: TLabel;
    dbeCodFpg: TDBEditFocus;
    edtDesFpg: TEditFocus;
    pnlTipCli: TPanel;
    Label35: TLabel;
    edtDesCndPag: TEditFocus;
    Label39: TLabel;
    ColorLabel10: TColorLabel;
    dbeZonFra: TDBEditFocus;
    Label41: TLabel;
    dbeTipCli: TDBEditFocus;
    edtDesTpc: TEditFocus;
    Label45: TLabel;
    pnlCadPor: TPanel;
    Label50: TLabel;
    Label52: TLabel;
    dbeCodPor: TDBEditFocus;
    edtDesPor: TEditFocus;
    dbeObserv: TDBMemoFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCidCobKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCidEntKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    function dbeCodCidChamaCadastro(Key: Word): String;
    function dbeCodVenChamaCadastro(Key: Word): String;
    function dbeCodAtiChamaCadastro(Key: Word): String;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnHisDebClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeCodCndKeyPress(Sender: TObject; var Key: Char);
    function dbeCodCndChamaCadastro(Key: Word): String;
    procedure btnResFinClick(Sender: TObject);
    procedure dbeCodFpgKeyPress(Sender: TObject; var Key: Char);
    function dbeCodFpgChamaCadastro(Key: Word): String;
    procedure dbeTipCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure dbeObservExit(Sender: TObject);
  private
    { Private declarations }
    fltLimCreAnt: Double;
//    qryCadFic: TUniQuery;
    blnRefCom: Boolean;
    blnCobEnt: Boolean;
    blnDadPro: Boolean;
    procedure pCarregaDadosAdicionais;
    procedure pCarregaCidade(qryConsulta: TUniQuery; edtCidade, edtEstado: TEdit;
      dbeCidade, dbeCep: TDBEditFocus);
    procedure pCarregaVendedor;
    procedure pCarregaRepresentante;
    procedure pCarregaAtividade;
    procedure pCarregaCondicao;
    procedure pCarregaFormaPag;
    procedure pAtualizaCadFic;
    procedure pCarregaPortador;
    procedure pInicializaCampos;
    procedure pLimpaEdits;
    procedure pAtribuiTabelas;

    function fValidaEstadoCivil(strEstCiv: String): Boolean;

  protected
    blnPodeDig: Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadClientes: TfrmCadClientes;

implementation

uses untModulo, untFuncoes, untfuncoesSimples, untModuloCons, untConfiguracoes, untPai,
  untConsulta, untConsultaComp, untModuloSPR, untFuncIns,
  untCadProdutos, untPesqAux, untPedidoCompra, untModuloCadMar,
  untModuloCadAti, untModuloCadCid, untModuloCadOpe, untModuloCadCli,
  untModuloCadCnd, untModuloCadFpg, untResFinanceiro, untModuloTipClg,
  untModuloCadPor;

{$R *.dfm}

procedure TfrmCadClientes.FormCreate(Sender: TObject);
begin

  inherited;
  intPaginasAtivas := 2;
  strNomeTabela := 'CADCLI';
  strNomeCampo  := 'CLI_CODCLI';

  qryTabela := frmModuloCadCli.qryCadCli;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCli;

  fltLimCreAnt := -1;
  blnRefCom := VS_strRefCom = 'S';
  blnCobEnt := VS_strTelCbr = 'S';
  blnDadPro := VS_strProTes = 'S';

  If blnRefCom Then
    Inc(intPaginasAtivas);

  tbsCbrEnt.TabVisible  := blnCobEnt;

  If blnCobEnt Then
    Inc(intPaginasAtivas, 3);

  tbsQuadSoc.TabVisible := blnRefCom;
  tbsRefBan.TabVisible  := blnRefCom;
  tbsRefCom.TabVisible  := blnRefCom;

  If blnDadPro Then
    Inc(intPaginasAtivas);

  tbsDadPro.TabVisible  := blnDadPro;
  pAtribuiTags;

end;

function TfrmCadClientes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strSenLinCre: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*****************************************}
    {* VALIDA O CÓDIGO DO CLIENTE            *}
    {**************************************MV*}
    If (Sender = dbeCodCli) Then
    Begin
      If (fEmptyStr(dbeCodCli.Text)) And (dbeCodCli.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Cliente deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos
        Else
        Begin
          pCarregaDadosAdicionais;
        End;
      End
    End

    {*****************************************}
    {* VALIDA A SITUAÇÃO DO CLIENTE          *}
    {**************************************MV*}
    Else If (Sender = dbeStatus) Then
    Begin
      If fEmptyStr(dbeStatus.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Situação do Cliente deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (dbeStatus.Text <> 'A') And (dbeStatus.Text <> 'I') Then
        Begin
          Result := False;
        End;
      End
    End

    {*****************************************}
    {* VALIDA O NOME / RAZÃO SOCIAL          *}
    {**************************************MV*}
    Else If (Sender = dbeNomCli) Then
    Begin
      If fEmptyStr(dbeNomCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome do Cliente deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O ENDEREÇO                     *}
    {**************************************MV*}
    Else If (Sender = dbeEndere) Then
    Begin
      If fEmptyStr(dbeEndere.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Endereço do Cliente deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DA CIDADE             *}
    {**************************************MV*}
    Else If (Sender = dbeCodCid) Then
    Begin
      If fEmptyStr(dbeCodCid.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Cidade deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaCidade(frmModuloCons.qryCon001, edtNomCid, edtEstado, dbeCodCid, dbeNumCep);
        If frmModuloCons.qryCon001.FieldByName('CID_CODCID').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
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
    Else If (Sender = dbeNuCpnj) Then
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
          Result := (Not fExisteCnpjCpf('CADCLI','CLI_CODCLI',dbeCodCli.Text,'CLI_C_G_C_',dbeNuCpnj.Text));

        If Not Result Then
          Sender := dbeCgcCpf;

      End;
    End

    {*****************************************}
    {* VALIDA INSCRIÇÃO ESTADUAL             *}
    {**************************************MV*}
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
        End;
      End
      Else
      Begin
        dbeNumIes.Clear;
      End;
    End

    {*****************************************}
    {* VALIDA INSCRIÇÃO MUNICIPAL DO PRODUTOR*}
    {**************************************MV*}
    Else If (Sender = dbeNumImp) Then
    Begin
      If (Not fEmptyStr(dbeNumImp.Text))                                And
         (Not frmModuloCons.qryCon001.FieldByName('CID_CODCID').IsNull) Then
      Begin
        If Not fValidaIES(dbeNumImp.Text, frmModuloCons.qryCon001.FieldByName('CID_ESTADO').AsString) Then
        Begin
          fMensagem('ATENÇÃO', dbeNumImp.Text + ' não é uma Inscrição Municipal do Produtor válida!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        dbeNumImp.Clear;
      End;
    End

    {*****************************************}
    {* VALIDA CONSUMIDOR FINAL               *}
    {**************************************MV*}
    Else If (Sender = dbeConsum) Then
    Begin
      If fEmptyStr(dbeConsum.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Consumidor Final deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (dbeConsum.Text <> 'S') And (dbeConsum.Text <> 'N') Then
      Begin
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA ORGÃO PÚBLICO                  *}
    {**************************************MV*}
    Else If (Sender = dbeOrgPub) Then
    Begin
      If fEmptyStr(dbeOrgPub.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Orgão Público deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (dbeOrgPub.Text <> 'S') And (dbeOrgPub.Text <> 'N') Then
      Begin
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA ZONA FRANCA                    *}
    {**************************************AF*}
    Else If (Sender = dbeZonFra) Then
    Begin
      If fEmptyStr(dbeZonFra.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Zona Franca deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Pos(dbeZonFra.Text,'S_N_') <= 0 Then
      Begin
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO VENDEDOR           *}
    {**************************************MV*}
    Else If (Sender = dbeCodVen) Then
    Begin
      If Not fEmptyStr(dbeCodVen.Text) Then
      Begin
        pCarregaVendedor;
        If frmModuloCons.qryCon002.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O código do vendedor deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO REPRESENTANTE      *}
    {**************************************MV*}
    Else If (Sender = dbeCodRep) Then
    Begin
      If Not fEmptyStr(dbeCodRep.Text) Then
      Begin
        pCarregaRepresentante;
        If frmModuloCons.qryCon003.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse representante não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O código do representante deve ser preenchido!', ['&Ok']);
        Result := False;
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
        If frmModuloCons.qryCon004.FieldByName('ATI_CODATI').IsNull Then
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

    {*****************************************}
    {* VALIDA A TABELA DE PRECO              *}
    {**************************************MA*}
    Else If (Sender = dbeTabPre) Then
    Begin
      If Not fEmptyStr(dbeTabPre.Text) Then
      Begin

        If Pos( dbeTabPre.Text, '12' ) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'A Tabela de Preço deve ser "1" ou "2" !', ['&Ok']);
          Result := False;
        End;

      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'A Tabela de Preço deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O LIMITE DE CREDITO            *}
    {**************************************MV*}
    Else If (Sender = dbeLimCre) Then
    Begin
      If (fEmptyStr(dbeLimCre.Text)) Or (fStrToFloat(dbeLimCre.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Limite de Crédito deve ser maior ou igual Zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(dbeLimCre.Text) > MAX_VALMON Then
      Begin
        fMensagem('ATENÇÃO!', 'O Limite de Crédito deve estar entre 0 e 999999,99!', ['&Ok']);
        Result := False;
      End
      Else If (qryTabela.State = dsEdit) And (FloatToStrF(fltLimCreAnt, ffFixed, 15, 2) <> FloatToStrF(fStrToFloat(dbeLimCre.Text), ffFixed, 15, 2)) Then
      Begin
        If ffrmSenha(strSenLinCre) Then
        Begin
          If strSenLinCre <> VS_strSenCre Then
          Begin
            dbeLimCre.Field.AsFloat := fltLimCreAnt;
          End
          Else
          Begin
            fltLimCreAnt := fStrToFloat(dbeLimCre.Text);
          End;
          dbeLimCre.SetFocus;
          blnMudarFoco := False;
        End
        Else
        Begin
          dbeLimCre.Field.AsFloat := fltLimCreAnt;
          blnMudarFoco := False;
          dbeLimCre.SetFocus;
        End;
      End
      Else If blnBuscaPorChave Then
      Begin
        If ( VS_strUsaFpg <> 'S' ) And (VS_strUsaTpc <> 'S') Then
          pProximaPagina;
      End;
    End

    {*****************************************}
    {* VALIDA  A OBSERVAÇÃO 4, PARA IR PARA  *}
    {  A PROXIMA PAGINA                      *}
    {**************************************MV*}
//    Else If (Sender = dbeObse04) Then
//    Begin
//      pProximaPagina;
//    End

    {*****************************************}
    {* VALIDA A CIDADE DE COBRANÇA           *}
    {**************************************MV*}
    Else If (Sender = dbeCidCob) Then
    Begin
      If Not fEmptyStr(dbeCidCob.Text) Then
      Begin
        pCarregaCidade(frmModuloCons.qryCon005, edtCidCob, edtEstCob, dbeCidCob, dbeCepCob);
        If frmModuloCons.qryCon005.FieldByName('CID_CODCID').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtCidCob.Clear;
        edtEstCob.Clear;
      End;
    End

    {*****************************************}
    {* VALIDA A CIDADE DE ENTREGA            *}
    {**************************************MV*}
    Else If (Sender = dbeCidEnt) Then
    Begin
      If Not fEmptyStr(dbeCidEnt.Text) Then
      Begin
        pCarregaCidade(frmModuloCons.qryCon006, edtCidEnt, edtEstEnt, dbeCidEnt, dbeCepEnt);
        If frmModuloCons.qryCon006.FieldByName('CID_CODCID').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;          
        End;
      End
      Else
      Begin
        edtCidEnt.Clear;
        edtEstEnt.Clear;
      End;
    End

    {*****************************************}
    {* VALIDA O FONE DE ENTREGA PARA IR PARA *}
    {* A PRÓXIMA PAGINA                      *}
    {**************************************MV*}
    Else If (Sender = dbeTelEnt) Then
    Begin
      If blnBuscaPorChave Then
        pProximaPagina;
    End

    {*****************************************}
    {* VALIDA O CAMPO CNPJ / CPF             *}
    {**************************************MV*}
    Else If (Sender = dbeCgCpS1) Then
    Begin
      If (fEmptyStr(dbeCgCpS1.Text)) Or (dbeCgCpS1.Text = '0') Then
      Begin
        dbeCgCpS1.Clear;
        dbeCgcSc1.Clear;
      End
      Else If (dbeCgCpS1.Text <> '1') And (dbeCgCpS1.Text <> '2') Then
      Begin
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O VALOR DO CNPJ / CPF          *}
    {**************************************MV*}
    Else If (Sender = dbeCgcSc1) Then
    Begin
      If fEmptyStr(dbeCgcSc1.Text) Then
      Begin
        dbeCgCpS1.Clear;
      End
      Else
      Begin
        Result := fValidaCnpjCpf(dbeCgCpS1.Text, dbeCgcSc1.Text);

        If (Result) Then
          Result := (Not fExisteCnpjCpf('CADCLI','CLI_CODCLI',dbeCodCli.Text,'FIC_CGCSC1',dbeCgcSc1.Text));

      End;

    End

    {*****************************************}
    {* VALIDA O CAMPO CNPJ / CPF             *}
    {**************************************MV*}
    Else If (Sender = dbeCgCpS2) Then
    Begin
      If (fEmptyStr(dbeCgCpS2.Text)) Or (dbeCgCpS2.Text = '0') Then
      Begin
        dbeCgCpS2.Clear;
        dbeCgcSc2.Clear;
      End
      Else If (dbeCgCpS2.Text <> '1') And (dbeCgCpS2.Text <> '2') Then
      Begin
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O VALOR DO CNPJ / CPF          *}
    {**************************************MV*}
    Else If (Sender = dbeCgcSc2) Then
    Begin
      If fEmptyStr(dbeCgcSc2.Text) Then
      Begin
        dbeCgCpS2.Clear;
      End
      Else
      Begin
        Result := fValidaCnpjCpf(dbeCgCpS2.Text, dbeCgcSc2.Text);

        If (Result) Then
          Result := (Not fExisteCnpjCpf('CADCLI','CLI_CODCLI',dbeCodCli.Text,'FIC_CGCSC2',dbeCgcSc2.Text));

      End;
    End

    {*****************************************}
    {* VALIDA O CAMPO CNPJ / CPF             *}
    {**************************************MV*}
    Else If (Sender = dbeCgCpS3) Then
    Begin
      If (fEmptyStr(dbeCgCpS3.Text)) Or (dbeCgCpS3.Text = '0') Then
      Begin
        dbeCgCpS3.Clear;
        dbeCgcSc3.Clear;
      End
      Else If (dbeCgCpS3.Text <> '1') And (dbeCgCpS3.Text <> '2') Then
      Begin
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O VALOR DO CNPJ / CPF          *}
    {**************************************MV*}
    Else If (Sender = dbeCgcSc3) Then
    Begin
      If fEmptyStr(dbeCgcSc3.Text) Then
      Begin
        dbeCgCpS3.Clear;
      End
      Else
      Begin
        Result := fValidaCnpjCpf(dbeCgCpS3.Text, dbeCgcSc3.Text);

        If (Result) Then
          Result := (Not fExisteCnpjCpf('CADCLI','CLI_CODCLI',dbeCodCli.Text,'FIC_CGCSC3',dbeCgcSc3.Text));

      End;
    End

    {*****************************************}
    {* VALIDA O CAMPO CNPJ / CPF             *}
    {**************************************MV*}
    Else If (Sender = dbeCgcPf1) Then
    Begin
      If (fEmptyStr(dbeCgcPf1.Text)) Or (dbeCgcPf1.Text = '0') Then
      Begin
        dbeCgcPf1.Clear;
        dbeCgcEm1.Clear;
      End
      Else If (dbeCgcPf1.Text <> '1') And (dbeCgcPf1.Text <> '2') Then
      Begin
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O VALOR DO CNPJ / CPF          *}
    {**************************************MV*}
    Else If (Sender = dbeCgcEm1) Then
    Begin
      If fEmptyStr(dbeCgcEm1.Text) Then
      Begin
        dbeCgcPf1.Clear;
      End
      Else
      Begin
        Result := fValidaCnpjCpf(dbeCgcPf1.Text, dbeCgcEm1.Text);

        If (Result) Then
          Result := (Not fExisteCnpjCpf('CADCLI','CLI_CODCLI',dbeCodCli.Text,'FIC_CGCEM1',dbeCgcEm1.Text));

      End;
    End

    {*****************************************}
    {* VALIDA O CAMPO CNPJ / CPF             *}
    {**************************************MV*}
    Else If (Sender = dbeCgcPf2) Then
    Begin
      If (fEmptyStr(dbeCgcPf2.Text)) Or (dbeCgcPf2.Text = '0') Then
      Begin
        dbeCgcPf2.Clear;
        dbeCgcEm2.Clear;
      End
      Else If (dbeCgcPf2.Text <> '1') And (dbeCgcPf2.Text <> '2') Then
      Begin
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O VALOR DO CNPJ / CPF          *}
    {**************************************MV*}
    Else If (Sender = dbeCgcEm2) Then
    Begin
      If fEmptyStr(dbeCgcEm2.Text) Then
      Begin
        dbeCgcPf2.Clear;
      End
      Else
      Begin
        Result := fValidaCnpjCpf(dbeCgcPf2.Text, dbeCgcEm2.Text);

        If (Result) Then
          Result := (Not fExisteCnpjCpf('CADCLI','CLI_CODCLI',dbeCodCli.Text,'FIC_CGCEM2',dbeCgcEm2.Text));

      End;
    End

    {*****************************************}
    {* VALIDA O CAMPO CNPJ / CPF             *}
    {**************************************MV*}
    Else If (Sender = dbeCgcPf3) Then
    Begin
      If (fEmptyStr(dbeCgcPf3.Text)) Or (dbeCgcPf3.Text = '0') Then
      Begin
        dbeCgcPf3.Clear;
        dbeCgcEm3.Clear;
      End
      Else If (dbeCgcPf3.Text <> '1') And (dbeCgcPf3.Text <> '2') Then
      Begin
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O VALOR DO CNPJ / CPF          *}
    {**************************************MV*}
    Else If (Sender = dbeCgcEm3) Then
    Begin
      If fEmptyStr(dbeCgcEm3.Text) Then
      Begin
        dbeCgcPf3.Clear;
      End
      Else
      Begin
        Result := fValidaCnpjCpf(dbeCgcPf3.Text, dbeCgcEm3.Text);

        If (Result) Then
          Result := (Not fExisteCnpjCpf('CADCLI','CLI_CODCLI',dbeCodCli.Text,'FIC_CGCEM3',dbeCgcEm3.Text));

      End;
    End

    {*****************************************}
    {* VALIDA O ESTADO CIVIL DO SOCIOS       *}
    {**************************************MV*}
    Else If (Sender = dbeEstCs1) Or
            (Sender = dbeEstCs2) Or
            (Sender = dbeEstCs3) Then
    Begin
      Result := fValidaEstadoCivil((Sender As TDBEditFocus).Text);
    End

    {*****************************************}
    {* VALIDA A PARTICIPAÇÃO DOS LUCROS DO   *}
    {* SÓCIO 3, PARA IR PARA PRÓXIMA PAGINA  *}
    {**************************************MV*}
    Else If (Sender = dbeValPs3) Then
    Begin
      If blnBuscaPorChave Then
        pProximaPagina;
    End

    {*****************************************}
    {* VALIDA A CONTATO DO BANCO 3, PARA IR  *}
    {* PARA A PRÓXIMA PAGINA                 *}
    {**************************************MV*}
    Else If (Sender = dbeConBc3) Then
    Begin
      If blnBuscaPorChave Then
        pProximaPagina;
    End

    {*****************************************}
    {* VALIDA A CONTATO DA REFERENCIA COMER- *}
    {* CIAL 3, PARA IR PARA A PRÓXIMA PAGINA *}
    {**************************************MV*}
    Else If (Sender = dbeConEm3) Then
    Begin
      If blnBuscaPorChave Then
        pProximaPagina;
    End

    {*****************************************}
    {* VALIDA O SALARIO                      *}
    {**************************************MV*}
    Else If (Sender = dbeSalari) Then
    Begin
      If Not fEmptyStr(dbeSalari.Text) Then
      Begin
        If fStrToFloat(dbeSalari.Text) > MAX_VALMON Then
        Begin
          fMensagem('ATENÇÃO!', 'O Salário deve estar entre 0 e 999999,99!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA CAMPO OUTRAS RENDAS            *}
    {**************************************MV*}
    Else If (Sender = dbeOutRen) Then
    Begin
      If Not fEmptyStr(dbeOutRen.Text) Then
      Begin
        If fStrToFloat(dbeOutRen.Text) > MAX_VALMON Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Outras Rendas deve estar entre 0 e 999999,99!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA VALOR DO ALUGUEL               *}
    {**************************************MV*}
    Else If (Sender = dbeVrAlug) Then
    Begin
      If Not fEmptyStr(dbeVrAlug.Text) Then
      Begin
        If fStrToFloat(dbeVrAlug.Text) > MAX_VALMON Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor do Aluguel deve estar entre 0 e 999999,99!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O ESTADO CIVIL DO CONJUGE      *}
    {**************************************MV*}
    Else If (Sender = dbeEstCiv) Then
    Begin
      Result := fValidaEstadoCivil(dbeEstCiv.Text);
    End

    {*****************************************}
    {* VALIDA O CAMPO MORADIA                *}
    {**************************************MV*}
    Else If (Sender = dbeMoradia) Then
    Begin
      If Not fEmptyStr(dbeMoradia.Text) Then
      Begin
        If (dbeMoradia.Text <> 'P') And (dbeMoradia.Text <> 'A') Then
        Begin
          Result := False;
        End;
      End
    End

    {*****************************************}
    {* VALIDA A OBSERVAÇÃO DOS DADOS PARA    *}
    {* PROTESTO, PARA IR PARA A PRÓXIMA PÁ - *}
    {* GINA                                  *}
    {**************************************MV*}
    Else If (Sender = dbeObs_Fc) Then
    Begin
      If blnBuscaPorChave Then
        pProximaPagina;
    End

    {*****************************************}
    {* VALIDA A CONDICAO DE PAGAMENTO        *}
    {**************************************MA*}
    Else If (Sender = dbeCndPag) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(dbeCndPag.Text)) Then
      Begin
        If Not fValidaCndPag(dbeCndPag.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CODIGO DA COND.DE PAGAMENTO  *}
    {**************************************MA*}
    Else If (Sender = dbeCodCnd) Then
    Begin

      If fEmptyStr(dbeCodCnd.Text) Then
      Begin
        edtCndPag.Text := '';
        Result := True;
      End
      Else
      Begin
        pCarregaCondicao;
        If frmModuloCons.qryCon007.FieldByName('CND_CODIGO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa condição não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CODIGO DA CONDICAO DA FORMA  *}
    {* DE PAGAMENTO                          *}
    {**************************************MA*}
    Else If (Sender = dbeCodFpg) And (pnlForPag.Visible) Then
    Begin

      If fEmptyStr(dbeCodFpg.Text) Then
      Begin
        edtDesFpg.Text := '';
        Result := True;
      End
      Else
      Begin
        pCarregaFormaPag;
        If frmModuloCons.qryCon008.FieldByName('FPG_CODIGO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa forma não está cadastrada!', ['&Ok']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeTipCli) And (pnlTipCli.Visible) Then
    Begin

      If (fEmptyStr(dbeTipCli.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O tipo de cliente deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesTpc.Text := frmModuloTipClg.fRetDescricaoTipoCli(dbeTipCli.Text);
        If (fEmptyStr(edtDesTpc.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse tipo de cliente não está cadastrado!', ['&Ok']);
          Result := False;
        End
      End;

    End

    Else If (Sender = dbeCodPor) Then
    Begin

      If (fEmptyStr(dbeCodPor.Text)) Then
      Begin
        edtDesPor.Clear;
      End
      Else
      Begin
        pCarregaPortador;
        If (frmModuloCons.qryCon010.FieldByName('POR_CODPOR').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;

      If (Result) Then
      Begin
        pProximaPagina;
      End;

    End;

  End;

  If Not (Result) Then
    Sender.SetFocus;

end;

procedure TfrmCadClientes.pCarregaAtividade;
begin
  pPesquisaCadAti(frmModuloCadAti.qryCadAti, frmModuloCons.qryCon004, dbeCodAti.Text);
  With frmModuloCons.qryCon004 Do
  Begin
    edtAtividade.Text := FieldByName('ATI_DESATI').AsString;
  End;
end;

procedure TfrmCadClientes.pCarregaCidade(qryConsulta: TUniQuery; edtCidade,
  edtEstado: TEdit; dbeCidade, dbeCep: TDBEditFocus);
begin
  pPesquisaCadCid(frmModuloCadCid.qryCadCid, qryConsulta, dbeCidade.Text);
  With qryConsulta Do
  Begin
    edtCidade.Text := FieldByName('CID_NOMCID').AsString;
    edtEstado.Text := FieldByName('CID_ESTADO').AsString;

    If (dbeCep.Field <> Nil) And (dbeCep.Field.IsNull) Then
      dbeCep.Text := FieldByName('CID_C_E_P_').AsString;
  End;
end;

procedure TfrmCadClientes.pCarregaDadosAdicionais;
begin
  pCarregaCidade(frmModuloCons.qryCon001, edtNomCid, edtEstado, dbeCodCid, dbeNumCep);
  pCarregaVendedor;
  pCarregaRepresentante;
  pCarregaAtividade;
  pCarregaCidade(frmModuloCons.qryCon005, edtCidCob, edtEstCob, dbeCidCob, dbeCepCob);
  pCarregaCidade(frmModuloCons.qryCon006, edtCidEnt, edtEstEnt, dbeCidEnt, dbeCepEnt);
  pCarregaPortador;

  If ( VS_strUsaCnd = 'S' ) Then
    pCarregaCondicao;

  If ( VS_strUsaFpg = 'S' ) Then
    pCarregaFormaPag;

  edtDesTpc.Text := frmModuloTipClg.fRetDescricaoTipoCli(dbeTipCli.Text);

  pAtualizaCadFic;
end;

procedure TfrmCadClientes.pCarregaRepresentante;
begin
  pPesquisaCadOpe(frmModuloCadOpe.qryCadOpe, frmModuloCons.qryCon003, dbeCodRep.Text);
  With frmModuloCons.qryCon003 Do
  Begin
    edtRepresentante.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmCadClientes.pCarregaVendedor;
begin
  pPesquisaCadOpe(frmModuloCadOpe.qryCadOpe, frmModuloCons.qryCon002, dbeCodVen.Text);
  With frmModuloCons.qryCon002 Do
  Begin
    edtVendedor.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmCadClientes.pCarregaCondicao;
begin
  pPesquisaCadCnd(frmModuloCadCnd.qryCadCnd, frmModuloCons.qryCon007, dbeCodCnd.Text);
  With frmModuloCons.qryCon007 Do
  Begin
    edtCndPag.Text := FieldByName('CND_CNDPAG').AsString;
    edtDesCndPag.Text := FieldByName('CND_DESCRI').AsString;
  End;
end;

procedure TfrmCadClientes.pCarregaFormaPag;
begin
  pPesquisaCadFpg(frmModuloCadFpg.qryCadFpg, frmModuloCons.qryCon008, dbeCodFpg.Text);
  With frmModuloCons.qryCon008 Do
  Begin
    edtDesFpg.Text := FieldByName('FPG_DESCRI').AsString;
  End;
end;

procedure TfrmCadClientes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CLI_NOMCLI');
  stlCampos.Add('CLI_CODCLI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CLI_NOMCLI+CLI_ENDERE+CID_NOMCID');
  stlCamInd.Add('CLI_FANSOB+CLI_ENDERE+CID_NOMCID');
  stlCamInd.Add('CID_NOMCID');
  stlCamInd.Add('CLI_CODCLI');
  stlCamInd.Add('CLI_C_G_C_');

  stlDesInd.Add('Nome / Endereço / Cidade');
  stlDesInd.Add('Fantasia / Endereço / Cidade');
  stlDesInd.Add('Cidade');
  stlDesInd.Add('Código');
  stlDesInd.Add('CNPJ - CPF');

  pAtribuiTabelas;
end;

procedure TfrmCadClientes.btnIncluirClick(Sender: TObject);
begin

//  If(fRetornaQtdRegistros(strNomeTabela) > 15) Then
//  Begin
//    fMensagem('', 'O sistema excedeu o limite máximo de registros!', ['&Ok']);
//    Exit;
//  End;

  inherited;

  edtCndPag.Enabled := False;
  edtDesFpg.Enabled := False;

  frmModuloCadCli.qryCadFic.Insert;
  pInicializaCampos;
  pLimpaEdits;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodCli, dbeStatus, False)
  Else
    pHabilitaCodigo(dbeCodCli, dbeCodCli, True);

end;

procedure TfrmCadClientes.btnGravarClick(Sender: TObject);
begin
  qryTabela.FieldByName('CLI_ULTALT').AsDateTime := VS_Date;

  If (fEmptyStr(dbeUltCom.Text)) Then
    qryTabela.FieldByName('CLI_ULTCOM').AsVariant := Null;

  If (fEmptyStr(dbeDtaNas.Text)) Then
    qryTabela.FieldByName('CLI_NASCIM').AsVariant := Null;

  If (fEmptyStr(dbeDtmCom.Text)) Then
    qryTabela.FieldByName('CLI_DTMCOM').AsVariant := Null;

  If (fEmptyStr(dbeNasCon.Text)) Then
    qryTabela.FieldByName('CLI_NASCON').AsVariant := Null;

  If (Not frmModuloCons.qryCon007.IsEmpty) And (Not frmModuloCons.qryCon007.Active) Then
    dbeCndPag.Field.Value := frmModuloCons.qryCon007.FieldByName('CND_CNDPAG').AsString;

  If fEmptyStr(dbeCidCob.Text) Then
    dbeCidCob.Field.Value := Null;

  If fEmptyStr(dbeCidEnt.Text) Then
    dbeCidEnt.Field.Value := Null;

  inherited;
  If blnGravou Then
  Begin
    frmModuloCadCli.qryCadFic.FieldByName('FIC_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
    frmModuloCadCli.qryCadFic.Post;
    pgcDados.ActivePageIndex := 0;
    blnGravou := False;
  End;
end;

procedure TfrmCadClientes.btnAlterarClick(Sender: TObject);
begin
  inherited;

  edtCndPag.Enabled := False;
  edtDesFpg.Enabled := False;

  If (blnAlterou) Then
  Begin
    fltLimCreAnt := qryTabela.FieldByName('CLI_LIMCRE').AsFloat;
    frmModuloCadCli.qryCadFic.Edit;
    pgcDados.ActivePageIndex := 0;
    pHabilitaCodigo(dbeCodCli, dbeNomCli, False);
    blnAlterou := False;
  End;
end;

procedure TfrmCadClientes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  frmModuloCadCli.qryCadFic.CancelUpdates;
  pCarregaDadosAdicionais;
end;

procedure TfrmCadClientes.pInicializaCampos;
begin
  dbeStatus.Field.AsString := 'A';
  dbeZonFra.Field.AsString := 'N';
  dbeDtaCad.Field.AsString := FormatDateTime('dd/mm/yyyy', VS_Date);
  dbeTabPre.Field.AsString := '1';
  dbeLimCre.Field.AsFloat  := 0.0;
end;

procedure TfrmCadClientes.FormShow(Sender: TObject);
begin

  pAtualizaCadFic;

  inherited;

  pgcDados.ActivePageIndex := 0;
  pCarregaDadosAdicionais;

  {*****************************************}
  {* VERIFICA SE USA CADASTRO DE CONDICAO  *}
  {* DE PAGAMENTO                          *}
  {**************************************MA*}
  If VS_strUsaCnd = 'S' Then
  Begin

    dbeCndPag.Visible := False;
    dbeCndPag.Tag     := 0;
    dbeCodCnd.Visible := True;
    edtCndPag.Visible := True;

  End
  Else
  Begin

    dbeCndPag.Visible := True;
    dbeCodCnd.Visible := False;
    edtCndPag.Visible := False;
    dbeCodCnd.Tag     := 0;

  End;

  {**************************************}
  {* VERIFICA SE USA CADASTRO DE FORMA  *}
  {* DE PAGAMENTO                       *}
  {***********************************MA*}
  If VS_strUsaFpg = 'S' Then
    pnlForPag.Visible := True
  Else
    pnlForPag.Visible := False;

  {*******************************************}
  {* VERIFICA SE USA O TIPO DE CLIENTE       *}
  {****************************************MV*}
  If VS_strUsaTpc = 'S' Then
    pnlTipCli.Visible := True
  Else
    pnlTipCli.Visible := False;

  If (VS_strUsaCnd = 'S') Then
  Begin
    edtDesCndPag.Visible := True;
    dbeCndPag.Visible    := False;
  End;

end;

procedure TfrmCadClientes.dbeCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndiceCid, stlDesIndCid, stlCamposCid: TStringList;
begin
  inherited;
  Try
    stlIndiceCid := TStringList.Create;
    stlDesIndCid := TStringList.Create;
    stlCamposCid := TStringList.Create;

    If fEntraCons(Key) Then
    Begin
      Key := #0;

      stlCamposCid.Add('CID_CODCID');
      stlCamposCid.Add('CID_NOMCID');
      stlCamposCid.Add('CID_ESTADO');
      stlCamposCid.Add('AUTOINCREM');

      stlIndiceCid.Add('CID_NOMCID');
      stlIndiceCid.Add('CID_CODCID');
      stlDesIndCid.Add('Nome da Cidade');
      stlDesIndCid.Add('Código da Cidade');

      If pConsultaRapida(Self, frmModuloCons.qryCon001, 'CADCID', stlIndiceCid, stlDesIndCid, stlCamposCid) Then
      Begin
        dbeCodCid.Text := frmModuloCons.qryCon001.FieldByName('CID_CODCID').AsString;
        Self.SelectNext(ActiveControl, True, True);
      End;
      pCarregaCidade(frmModuloCons.qryCon001, edtNomCid, edtEstado, dbeCodCid, dbeNumCep);

    End;
    FreeAndNil(stlIndiceCid);
    FreeAndNil(stlDesIndCid);
    FreeAndNil(stlCamposCid);

  Except
    On E: Exception Do
    Begin
      fMensagem('', 'Erro na busca rápida: ' + E.Message, ['&Ok']);
      If pConsultaRapida(Self, frmModuloCons.qryCon001, 'CADCID', stlIndiceCid, stlDesIndCid, stlCamposCid) Then
      Begin
        dbeCodCid.Text := frmModuloCons.qryCon001.FieldByName('CID_CODCID').AsString;
        Self.SelectNext(ActiveControl, True, True);
      End;
      pCarregaCidade(frmModuloCons.qryCon001, edtNomCid, edtEstado, dbeCodCid, dbeNumCep);
    End;
  End;
end;

procedure TfrmCadClientes.dbeCodAtiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndiceAti, stlDesIndAti, stlCamposAti: TStringList;
begin
  inherited;
  stlIndiceAti := TStringList.Create;
  stlDesIndAti := TStringList.Create;
  stlCamposAti := TStringList.Create;


  If fEntraCons(Key) Then
  Begin
    Key := #0;

    stlCamposAti.Add('ATI_CODATI');
    stlCamposAti.Add('ATI_DESATI');
    stlCamposAti.Add('AUTOINCREM');

    stlIndiceAti.Add('ATI_DESATI');
    stlIndiceAti.Add('ATI_CODATI');
    stlDesIndAti.Add('Descrição');
    stlDesIndAti.Add('Código');

    If pConsultaRapida(Self, frmModuloCons.qryCon004, 'CADATI', stlIndiceAti, stlDesIndAti, stlCamposAti) Then
    Begin
      dbeCodAti.Text := frmModuloCons.qryCon004.FieldByName('ATI_CODATI').AsString;
      Self.SelectNext(ActiveControl, True, True);
    End;
    pCarregaAtividade;
  End;

  FreeAndNil(stlIndiceAti);
  FreeAndNil(stlDesIndAti);
  FreeAndNil(stlCamposAti);
end;

procedure TfrmCadClientes.dbeCodVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamposVen, stlCamIndVen, stlDesIndVen: TStringList;
begin
  inherited;
  stlCamposVen := TStringList.Create;
  stlCamIndVen := TStringList.Create;
  stlDesIndVen := TStringList.Create;

  If fEntraCons(Key) Then
  Begin
    Key := #0;
    stlCamposVen.Add('OPE_NOMOPE');
    stlCamposVen.Add('OPE_CODOPE');
    stlCamposVen.Add('AUTOINCREM');

    stlCamIndVen.Add('OPE_NOMOPE');
    stlCamIndVen.Add('OPE_CODOPE');

    stlDesIndVen.Add('Nome');
    stlDesIndVen.Add('Código');

    If pConsultaRapida(Self, frmModuloCons.qryCon002, 'CADOPE', stlCamIndVen, stlDesIndVen, stlCamposVen) Then
    Begin
      dbeCodVen.Text := frmModuloCons.qryCon002.FieldByName('OPE_CODOPE').AsString;
      Self.SelectNext(ActiveControl, True, True);
      pCarregaVendedor;
    End;
  End;

  FreeAndNil(stlCamposVen);
  FreeAndNil(stlCamIndVen);
  FreeAndNil(stlDesIndVen);
end;

procedure TfrmCadClientes.dbeCodRepKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamposVen, stlCamIndVen, stlDesIndVen: TStringList;
begin
  inherited;
  stlCamposVen := TStringList.Create;
  stlCamIndVen := TStringList.Create;
  stlDesIndVen := TStringList.Create;

  If fEntraCons(Key) Then
  Begin
    Key := #0;
    stlCamposVen.Add('OPE_NOMOPE');
    stlCamposVen.Add('OPE_CODOPE');
    stlCamposVen.Add('AUTOINCREM');

    stlCamIndVen.Add('OPE_NOMOPE');
    stlCamIndVen.Add('OPE_CODOPE');

    stlDesIndVen.Add('Nome');
    stlDesIndVen.Add('Código');

    If pConsultaRapida(Self, frmModuloCons.qryCon003, 'CADOPE', stlCamIndVen, stlDesIndVen, stlCamposVen) Then
    Begin
      dbeCodRep.Text := frmModuloCons.qryCon003.FieldByName('OPE_CODOPE').AsString;
      SelectNext(ActiveControl, True, True);
      pCarregaRepresentante;
    End;

  End;

  FreeAndNil(stlCamposVen);
  FreeAndNil(stlCamIndVen);
  FreeAndNil(stlDesIndVen);
end;

procedure TfrmCadClientes.pLimpaEdits;
begin
  edtNomCid.Clear;
  edtEstado.Clear;
  edtVendedor.Clear;
  edtRepresentante.Clear;
  edtAtividade.Clear;

  edtCidCob.Clear;
  edtEstCob.Clear;

  edtCidEnt.Clear;
  edtEstEnt.Clear;
end;

procedure TfrmCadClientes.dbeCidCobKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndiceCid, stlDesIndCid, stlCamposCid: TStringList;
begin
  inherited;
  stlIndiceCid := TStringList.Create;
  stlDesIndCid := TStringList.Create;
  stlCamposCid := TStringList.Create;

  If fEntraCons(Key) Then
  Begin
    Key := #0;

    stlCamposCid.Add('CID_CODCID');
    stlCamposCid.Add('CID_NOMCID');
    stlCamposCid.Add('CID_ESTADO');
    stlCamposCid.Add('AUTOINCREM');

    stlIndiceCid.Add('CID_NOMCID');
    stlIndiceCid.Add('CID_CODCID');
    stlDesIndCid.Add('Nome da Cidade');
    stlDesIndCid.Add('Código da Cidade');

    If pConsultaRapida(Self, frmModuloCons.qryCon005, 'CADCID', stlIndiceCid, stlDesIndCid, stlCamposCid) Then
    Begin
      dbeCidCob.Text := frmModuloCons.qryCon005.FieldByName('CID_CODCID').AsString;
      pCarregaCidade(frmModuloCons.qryCon005, edtCidCob, edtEstCob, dbeCidCob, dbeCepCob);
      SelectNext(ActiveControl, True, True);
    End;
  End;

  FreeAndNil(stlIndiceCid);
  FreeAndNil(stlDesIndCid);
  FreeAndNil(stlCamposCid);
end;

procedure TfrmCadClientes.dbeCidEntKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndiceCid, stlDesIndCid, stlCamposCid: TStringList;
begin
  inherited;
  stlIndiceCid := TStringList.Create;
  stlDesIndCid := TStringList.Create;
  stlCamposCid := TStringList.Create;

  If fEntraCons(Key) Then
  Begin
    Key := #0;
    stlCamposCid.Add('CID_CODCID');
    stlCamposCid.Add('CID_NOMCID');
    stlCamposCid.Add('CID_ESTADO');
    stlCamposCid.Add('AUTOINCREM');

    stlIndiceCid.Add('CID_NOMCID');
    stlIndiceCid.Add('CID_CODCID');
    stlDesIndCid.Add('Nome da Cidade');
    stlDesIndCid.Add('Código da Cidade');

    If pConsultaRapida(Self, frmModuloCons.qryCon006, 'CADCID', stlIndiceCid, stlDesIndCid, stlCamposCid) Then
    Begin
      dbeCidEnt.Text := frmModuloCons.qryCon006.FieldByName('CID_CODCID').AsString;
      pCarregaCidade(frmModuloCons.qryCon006, edtCidEnt, edtEstEnt, dbeCidEnt, dbeCepEnt);
      SelectNext(ActiveControl, True, True);
    End;
  End;

  FreeAndNil(stlIndiceCid);
  FreeAndNil(stlDesIndCid);
  FreeAndNil(stlCamposCid);
end;

procedure TfrmCadClientes.pAtualizaCadFic;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FIC_CODCLI = :CODCLI ';

  With frmModuloCadCli.qryCadFic Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
    Open;
  End;
end;

procedure TfrmCadClientes.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaDadosAdicionais;
end;

function TfrmCadClientes.fValidaEstadoCivil(strEstCiv: String): Boolean;
begin
  Result := False;
  If fEmptyStr(strEstCiv) Then
    Result := True
  Else
  Begin
    If (strEstCiv[1] In ['S','C','M','O']) Then
      Result := True;
  End;
end;

procedure TfrmCadClientes.btnPesquisaClick(Sender: TObject);
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CLI_CODCLI AS "Código", ';
  strSQL := strSQL + '  CLI_NOMCLI AS "Nome", ';
  strSQL := strSQL + '  CLI_FANSOB AS "Fantasia", ';
  strSQL := strSQL + '  CLI_ENDERE AS "Endereço", ';
  strSQL := strSQL + '  CID_NOMCID AS "Cidade", ';
  strSQL := strSQL + '  CID_ESTADO AS "Estado", ';
  strSQL := strSQL + '  CLI_C_G_C_ AS "CNPJ - CPF", ';
  strSQL := strSQL + '  CLI_I_E_S_ AS "Inscrição Estadual", ';
  strSQL := strSQL + '  CADCLI.AUTOINCREM AS "AUTOINCREM" ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI, ';
  strSQL := strSQL + '  CADCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CLI_CODCID = CID_CODCID ';

  If vs_intConCli = 1 Then
    pConsultaComp(Self, qryTabela, strNomeTabela, strSQL, stlCamInd, stlDesInd)
  Else
  Begin
    Application.CreateForm(TfrmConsultaComp, frmConsultaComp);
    pConsultaEspecifica(Self,frmConsultaComp, qryTabela, strNomeTabela, strSQL, stlCamInd, stlDesInd,'', False, True, 1, True);
    FreeAndNil(frmConsultaComp);
  End;

  pCarregaDadosAdicionais;

  If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
    btnAlterar.SetFocus;

end;

function TfrmCadClientes.dbeCodCidChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadCid(Key);
  pAtribuiTabelas;
end;

function TfrmCadClientes.dbeCodVenChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadOpe(Key);
  pAtribuiTabelas;
end;

function TfrmCadClientes.dbeCodAtiChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadAti(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmModuloCadCli.qryCadFic.Close;
  SetLength(arrCamposChave, 0);
  inherited;
end;

procedure TfrmCadClientes.pAtribuiTabelas;
begin
  frmModuloCons.qryCon001 := frmModuloCadCid.qryCadCid;
  frmModuloCons.qryCon002 := frmModuloCadOpe.qryCadOpe;
  frmModuloCons.qryCon003 := frmModuloCadOpe.qryCadOpe;
  frmModuloCons.qryCon004 := frmModuloCadAti.qryCadAti;
  frmModuloCons.qryCon005 := frmModuloCadCid.qryCadCid;
  frmModuloCons.qryCon006 := frmModuloCadCid.qryCadCid;
  frmModuloCons.qryCon007 := frmModuloCadCnd.qryCadCnd;
  frmModuloCons.qryCon008 := frmModuloCadFpg.qryCadFpg;
  frmModuloCons.qryCon009 := frmModuloTipClg.qryTipClg;
  frmModuloCons.qryCon010 := frmModuloCadPor.qryCadPor;
end;

procedure TfrmCadClientes.btnHisDebClick(Sender: TObject);
begin
  inherited;
  frmModuloCadCli.pMostraContaCorrente(dbeCodCli.Text);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F6) Then
    btnHisDeb.Click;

  If (Key = VK_F7) Then
    btnResFin.Click;  
end;

procedure TfrmCadClientes.dbeCodCndKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndiceCid, stlDesIndCid, stlCamposCid: TStringList;
begin
  inherited;
  stlIndiceCid := TStringList.Create;
  stlDesIndCid := TStringList.Create;
  stlCamposCid := TStringList.Create;

  If fEntraCons(Key) Then
  Begin
    Key := #0;

    stlCamposCid.Add('CND_CODIGO');
    stlCamposCid.Add('CND_DESCRI');
    stlCamposCid.Add('CND_CNDPAG');
    stlCamposCid.Add('CND_TIPFOR');
    stlCamposCid.Add('CND_CODPOR');
    stlCamposCid.Add('AUTOINCREM');

    stlIndiceCid.Add('CND_DESCRI');
    stlIndiceCid.Add('CND_CNDPAG');
    stlIndiceCid.Add('CND_CODIGO');
    stlIndiceCid.Add('CND_TIPFOR');
    stlDesIndCid.Add('Descrição');
    stlDesIndCid.Add('Condição');
    stlDesIndCid.Add('Código');
    stlDesIndCid.Add('Fora');

    If pConsultaRapida(Self, frmModuloCons.qryCon007, 'CADCND', stlIndiceCid, stlDesIndCid, stlCamposCid) Then
    Begin
      dbeCodCnd.Text := frmModuloCons.qryCon007.FieldByName('CND_CODIGO').AsString;
      pCarregaCondicao;
      SelectNext(ActiveControl, True, True);
    End;
  End;

  FreeAndNil(stlIndiceCid);
  FreeAndNil(stlDesIndCid);
  FreeAndNil(stlCamposCid);
end;

function TfrmCadClientes.dbeCodCndChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadCnd(Key);
  pAtribuiTabelas;

end;

procedure TfrmCadClientes.btnResFinClick(Sender: TObject);
begin
  inherited;
  Try
    Application.CreateForm(TfrmResFinanceiro,frmResFinanceiro);

    If Not fEmptyStr(dbeCodCli.Text) Then
      frmResFinanceiro.strCodCli := dbeCodCli.Text;



    frmResFinanceiro.ShowModal;
  Except
  End;

  FreeAndNil(frmResFinanceiro);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.dbeCodFpgKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndiceFpg, stlDesIndFpg, stlCamposFpg: TStringList;
begin
  inherited;
  stlIndiceFpg := TStringList.Create;
  stlDesIndFpg := TStringList.Create;
  stlCamposFpg := TStringList.Create;

  If fEntraCons(Key) Then
  Begin
    Key := #0;

    stlCamposFpg.Add('FPG_CODIGO');
    stlCamposFpg.Add('FPG_DESCRI');
    stlCamposFpg.Add('AUTOINCREM');

    stlIndiceFpg.Add('FPG_DESCRI');
    stlIndiceFpg.Add('FPG_CODIGO');
    stlDesIndFpg.Add('Descrição');
    stlDesIndFpg.Add('Condição');

    If pConsultaRapida(Self, frmModuloCons.qryCon008, 'CADFPG', stlIndiceFpg, stlDesIndFpg, stlCamposFpg) Then
    Begin
      dbeCodFpg.Text := frmModuloCons.qryCon008.FieldByName('FPG_CODIGO').AsString;
      pCarregaFormaPag;

      If ( VS_strUsaFpg = 'S' ) Then
        pProximaPagina;

      //SelectNext(ActiveControl, True, True);

    End;
  End;

  FreeAndNil(stlIndiceFpg);
  FreeAndNil(stlDesIndFpg);
  FreeAndNil(stlCamposFpg);

end;

function TfrmCadClientes.dbeCodFpgChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadFpg(Key);
  pAtribuiTabelas;

end;

procedure TfrmCadClientes.dbeTipCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamposTip: TStringList;
    stlCamIndTip: TStringList;
    stlDesIndTip: TStringList;
begin

  If (fEntraCons(Key)) Then
  Begin

    stlCamposTip := TStringList.Create;
    stlCamIndTip := TStringList.Create;
    stlDesIndTip := TStringList.Create;

    stlCamposTip.Add('TIP_CODTIP');
    stlCamposTip.Add('TIP_DESTIP');
    stlCamposTip.Add('AUTOINCREM');

    stlCamIndTip.Add('TIP_CODTIP');
    stlCamIndTip.Add('TIP_DESTIP');

    stlDesIndTip.Add('Código');
    stlDesIndTip.Add('Descrição');

    If (pConsultaRapida(Self, frmModuloCons.qryCon009, 'TIPCLG', stlCamIndTip, stlDesIndTip,
      stlCamposTip)) Then
    Begin
      dbeTipCli.Text := frmModuloCons.qryCon009.FieldByName('TIP_CODTIP').AsString;
      If (fValidaCampos(dbeTipCli, True)) Then
        SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(stlCamposTip);
    FreeAndNil(stlCamIndTip);
    FreeAndNil(stlDesIndTip);

  End;
end;

procedure TfrmCadClientes.pCarregaPortador;
begin
  pPesquisaCadPor(frmModuloCadPor.qryCadPor, frmModuloCons.qryCon010, dbeCodPor.Text);
  With frmModuloCons.qryCon010 Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

procedure TfrmCadClientes.dbeCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamposPor: TStringList;
    stlCamIndPor: TStringList;
    stlDesIndPor: TStringList;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin

    stlCamposPor := TStringList.Create;
    stlCamIndPor := TStringList.Create;
    stlDesIndPor := TStringList.Create;

    Key := #0;

    stlCamposPor.Add('POR_CODPOR');
    stlCamposPor.Add('POR_NOMPOR');
    stlCamposPor.Add('AUTOINCREM');

    stlCamIndPor.Add('POR_CODPOR');
    stlCamIndPor.Add('POR_NOMPOR');

    stlDesIndPor.Add('Código');
    stlDesIndPor.Add('Nome');

    If pConsultaRapida(Self, frmModuloCons.qryCon010, 'CADPOR', stlCamIndPor, stlDesIndPor, stlCamposPor) Then
    Begin
      dbeCodPor.Text := frmModuloCons.qryCon010.FieldByName('POR_CODPOR').AsString;
      fValidaCampos(dbeCodPor, True);
    End;
    pCarregaPortador;

    FreeAndNil(stlCamposPor);
    FreeAndNil(stlCamIndPor);
    FreeAndNil(stlDesIndPor);

  End;
end;

procedure TfrmCadClientes.dbeObservExit(Sender: TObject);
begin
  inherited;
  pProximaPagina;

  If (blnCobEnt) Then
    dbeEndCob.SetFocus
  Else If (blnRefCom) Then
    dbeNomSc1.SetFocus
  Else If (blnDadPro) Then
    dbeNomPai.SetFocus;

end;

end.

