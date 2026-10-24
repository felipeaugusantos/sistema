unit untCadCliEndEntrega;

interface

uses
  Windows, Classes, Controls, Forms, DB, UniClientDataSet, Uni, AppEvnts, Menus,
  StdCtrls, Mask, Grids, DBGridCitel, DBGrids, ComCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls,
  DBCtrls, DBEditFocus, untPaiOrdenaEdit, untModulo, untFuncoesSimples, MemDS, DBAccess,
  Provider, UniDataSetProvider, EditFocus, MaskEditFocus, frxClass, strUtils,untTypesSistema,
  frxExportCSVTestabilidade, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons, Datasnap.DBClient,
  ComboBoxFocus, DBComboBoxFocus, QColorLabel, Winapi.Messages;

Type
  TfDireitoDeAcessoBairro = reference to function(strCodCli, strNomCli, strCEP, strBaiDig: String; Var strBaiLib: String): Boolean;

type
  TfrmCadCliEndEntrega = class(TfrmPaiOrdenaEdit)
    cdsConsultaETC_CODCLI: TStringField;
    cdsConsultaETC_SEQIND: TIntegerField;
    cdsConsultaETC_CIDENT: TStringField;
    cdsConsultaETC_ENDENT: TStringField;
    cdsConsultaETC_BAIENT: TStringField;
    cdsConsultaETC_CEPENT: TStringField;
    cdsConsultaETC_TELENT: TStringField;
    cdsConsultaETC_CONENT: TStringField;
    cdsConsultaETC_REFENT: TStringField;
    cdsConsultaETC_CODTRA: TStringField;
    Label57: TLabel;
    Label58: TLabel;
    Label60: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label149: TLabel;
    Label157: TLabel;
    dbeEndEnt: TDBEditFocus;
    dbeCidEnt: TDBEditFocus;
    dbeCepEnt: TDBEditFocus;
    dbeBaiEnt: TDBEditFocus;
    dbeConEnt: TDBEditFocus;
    dbeTelEnt: TDBEditFocus;
    dbeRefEnt: TDBEditFocus;
    dbeTraEnt: TDBEditFocus;
    dbeEstado: TDBEditFocus;
    dbeNomCid: TDBEditFocus;
    dbeNomTra: TDBEditFocus;
    btnConfAlteracoes: TBitBtnLocked;
    cdsConsultaAUTOINCREM: TStringField;
    qryCadCid: TUniQuery;
    qryCadTra: TUniQuery;
    qryCadTraTRA_CODTRA: TStringField;
    qryCadTraTRA_NOMTRA: TStringField;
    cdsConsultaTRA_NOMTRA: TStringField;
    pnlAviso: TPanel;
    cdsConsultaETC_ENDFAT: TStringField;
    Shape1: TShape;
    Label2: TLabel;
    grpServico: TGroupBox;
    lbl11: TLabel;
    dbeCodART: TDBEditFocus;
    lbl10: TLabel;
    dbeCodObr: TDBEditFocus;
    cdsConsultaETC_CODOBR: TStringField;
    cdsConsultaETC_CODART: TStringField;
    cdsConsultaCID_NOMCID: TStringField;
    cdsConsultaCID_ESTADO: TStringField;
    rdgCobIss: TRadioGroup;
    cdsConsultaETC_COBISS: TStringField;
    pnlOrdVis: TPanel;
    cdsConsultaETC_SEQVIS: TIntegerField;
    btnOrdBaixo: TBitBtnLocked;
    btnOrdCima: TBitBtnLocked;
    Label3: TLabel;
    dbeRegEnt: TDBEditFocus;
    dbeDesReg: TDBEditFocus;
    cdsConsultaETC_CODREG: TStringField;
    cdsConsultaREG_DESREG: TStringField;
    qryCadReg: TUniQuery;
    qryCadRegREG_CODREG: TStringField;
    qryCadRegREG_DESREG: TStringField;
    lblTipFre: TLabel;
    cdsConsultaETC_TIPFRE: TStringField;
    cmbTipFre: TComboBoxFocus;
    cdsConsultaETC_SITUAC: TStringField;
    lblSituacao: TLabel;
    dbeSituac: TDBEditFocus;
    lblAtivoInativo: TColorLabel;
    Shape2: TShape;
    Label4: TLabel;
    pnlTraRedesp: TPanel;
    Label6: TLabel;
    dbeTraRed: TDBEditFocus;
    dbeNomTrd: TDBEditFocus;
    cdsConsultaETC_TRARED: TStringField;
    cdsConsultaTRA_NOMTRD: TStringField;
    cdsConsultaETC_NUCNPJ: TStringField;
    lblCNPJEntrega: TLabel;
    dbeNuCnpjEntrega: TDBEditFocus;
    pnlLatLon: TPanel;
    lblLatLon: TLabel;
    edtLatLon: TEditFocus;
    btnConsultarEndereco: TBitBtnLocked;
    cdsConsultaETC_LATLON: TStringField;
    Label9: TLabel;
    dbeCodCno: TDBEditFocus;
    cdsConsultaETC_CODCNO: TStringField;
    Label7: TLabel;
    dbeInsImo: TDBEditFocus;
    Label8: TLabel;
    dbeCodCib: TDBEditFocus;
    cdsConsultaETC_INSIMO: TStringField;
    cdsConsultaETC_CODCIB: TStringField;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbeCidEntKeyPress(Sender: TObject; var Key: Char);
    procedure dbeTraEntKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCepEntKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfAlteracoesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure btnCancelaClick(Sender: TObject);
    procedure cdsConsultaCID_NOMCIDGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsConsultaCID_ESTADOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    function dbeCidEntChamaCadastro(Key: Word): string;
    function dbeTraEntChamaCadastro(Key: Word): string;
    procedure cdsConsultaTRA_NOMTRAGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure btnOrdBaixoClick(Sender: TObject);
    procedure btnOrdCimaClick(Sender: TObject);
    procedure dbeRegEntKeyPress(Sender: TObject; var Key: Char);
    procedure cdsConsultaREG_DESREGGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cmbTipFreChange(Sender: TObject);
    procedure cdsConsultaETC_TIPFREGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure cdsConsultaNewRecord(DataSet: TDataSet);
    procedure cdsConsultaReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure dbeTraRedKeyPress(Sender: TObject; var Key: Char);
    procedure cdsConsultaTRA_NOMTRDGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure edtLatLonKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsultarEnderecoClick(Sender: TObject);
  private
    { Private declarations }
    strSeqInd   : String;
    blnLiberou  : Boolean;
    strCidEnt   : String;
    strRefEnt   : String;
    strEndEnt   : String;
    strBaiEnt   : String;
    strEstado   : String;
    strNomCidEnt: String;
    strCepEntAnt: String;
    strBaiEntLib: String;

    qryConCiE: TUniQuery;

    qryFacImg: TUniQuery;
    cdsClone : TUniClientDataSet;

    blnNovoClienteComCNPJ : Boolean;
    strCNPJCadastroPrincipal : String;
    strUFCadastroPrincipal : String;
    Function fRetSeqIndEndereco(strCodCli: String; strCampo: String): Integer;
    Function fTemAcesso: Boolean;
    function fPodeExcluirEndereco: Boolean;
    procedure pCarregaCidade(qryConsulta: TUniQuery; dbeNomCid, dbeEstado, dbeCidade,
      dbeCep: TDBEditFocus; Var strCepAnt: String);
    procedure pRetornaEndereco;
    procedure pLimpaEndereco;
    procedure pAtualizarSeqVis(blnCima: Boolean);
    function fRetProxSeqVis: Integer;
    function fRetProxSeqInd: Integer;
    function fExisteTransp(strCodTra: String): Boolean;
    function fRetornarCodRegiao(strCEP : String) : String;
    function  fVerificaPossuiEnderecoAtivo: Boolean;
    function fTemPermissaoAlterarEndereco: Boolean;
    function fValidaBairro: Boolean;
    function fValidaCnpjEntrega(const Sender : TObject): Boolean;
    function fJaTemEsseCNPJEmAlgumCadastro (const strCNPJ : String) : Boolean;
    function fMesmaRaizDeCNPJCliente(const strCNPJ : String) : Boolean;
    function fValidouEstadoCNPJs : Boolean;
  protected
    function fGetSql(blnLike: Boolean): String;override;
    function fGetOrderBy: String; override;
    function fSetParametros: Boolean; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
    procedure pPreencherPnlInfo;

  public
    { Public declarations }
    blnOcultaInativos,
    blnConfirma,
    blnSomenteSelecao,
    blnAlteraSelecionado,
    blnAviso: Boolean;
    strPermiCadCid: String;

    blnVendas: Boolean;
    blnDockPanel: Boolean;
    recEndEnt: TrecEnderecoEntrega;
    strEspDoc: String;
    blnOrigemCadCli: Boolean;
    fValidaDireitoDeAcessoAltBairro: TfDireitoDeAcessoBairro;

    function fValidaTransportadora:Boolean;
    function fValidaRegiao:Boolean;
    function fExisteAlgumEnderecoNoEstado(const strEstado: String): Boolean;

    function fGravarEnderecosEntregaCliente: Boolean;
    procedure pCancelaAlteracoes;
    procedure pAtualizaEnderecoPadrao(qryCadCli: TUniQuery); overload;
    procedure pAtualizaEnderecoPadrao(strCodCli,
                                      strCodCid,
                                      strEndere,
                                      strEndNum,
                                      strEndCom,
                                      strBairro,
                                      strC_E_P_,
                                      strCobIss,
                                      strCodObr,
                                      strCodArt,
                                      strCodCno,
                                      strFone01,
                                      strCodReg,
                                      strContat,
                                      strInsImo,
                                      strCodCib: String); overload;
    procedure pSetaVisibilidadeDadosCNPJEntrega;
    procedure pSetaDadosClienteNovo(const ANovoClienteComCnpj : Boolean; const ACNPJCadastroPrincipal, AUFCadastroPrincipal : String);
  end;

implementation

uses SysUtils, Variants, Graphics, untPaiOrdena, untFuncoesGenerica, untPai,
  untCadCidades, untPesqAux, untCadCid, untConsultas, untFuncIns2,
  untConstantes, untTipoFreteAtc, untCadProFoto, untFuncoesImagem, System.Math,
  untTEntCli, untLiberacao, untConsultaMapaGoogleMaps;

{$R *.dfm}

function TfrmCadCliEndEntrega.fGetSql(blnLike: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT        ';
  Result := Result + '  REPEAT(" ", 40) AS CID_NOMCID,  ';
  Result := Result + '  REPEAT(" ", 2)  AS CID_ESTADO,  ';
  Result := Result + '  REPEAT(" ", 40) AS TRA_NOMTRA,  ';
  Result := Result + '  REPEAT(" ", 40) AS TRA_NOMTRD,  ';
  Result := Result + '  REPEAT(" ", 40) AS REG_DESREG,  ';
  Result := Result + '  ENTCLI.*     ';
  Result := Result + ' FROM          ';
  Result := Result + '   ENTCLI      ';
  Result := Result + ' WHERE         ';
  Result := Result + '   ETC_CODCLI = :CODCLI ';

  If (blnOcultaInativos) Then
    Result := Result + '   AND (ETC_SITUAC = "A") ';

end;

function TfrmCadCliEndEntrega.fGetOrderBy: String;
begin
  Result := '';
  Result := Result + ' ORDER BY      ';
  Result := Result + '   ETC_CODCLI, ';
  Result := Result + '   ETC_SEQVIS  ';
end;

function TfrmCadCliEndEntrega.fSetParametros: Boolean;
begin
  Result := inherited fSetParametros;

  qryConsulta.ParamByName('CODCLI').AsString := recEndEnt.strCodCli;
end;

procedure TfrmCadCliEndEntrega.btnGravarClick(Sender: TObject);
begin
  If (cdsConsulta.State in [dsInsert,dsEdit]) Then
  Begin
    cdsConsulta.FieldByName('ETC_CODCLI').AsString := recEndEnt.strCodCli;
    cdsConsulta.FieldByName('ETC_TIPFRE').AsString := recEndEnt.strTipFre;
    If fEmptyStr(dbeCidEnt.Text) Then
      dbeCidEnt.Field.Value := Null;
    Case rdgCobIss.ItemIndex Of
      0: cdsConsulta.FieldByname('ETC_COBISS').AsString := 'T';
      1: cdsConsulta.FieldByname('ETC_COBISS').AsString := 'S';
      Else cdsConsulta.FieldByname('ETC_COBISS').AsString := '';
    End;

    If fEmptyStr(dbeTraEnt.Text) Then
      dbeTraEnt.Field.Value := Null;

    cdsConsultaETC_LATLON.AsString := edtLatLon.Text;
  End;
  inherited;
end;

procedure TfrmCadCliEndEntrega.FormShow(Sender: TObject);
  Var
    strDireitos : String;
begin
  inherited;
  blnLiberou := False;

  Caption := Caption + ' ' + fRetNomCliente(recEndEnt.strCodCli);

  If blnDockPanel Then
  Begin
    pnlTail.Visible   := False;
    btnSair.Visible   := False;
  End;

  If blnVendas Then
  Begin
    pnlOrdVis.Visible := False;
    btnConfAlteracoes.Caption := '[ F10 ] Confirmar / Transferir';
    pSetFocus(dbgConsulta);
  End
  Else
    pSetFocus(btnIncluir);

  If Not fEmptyStr(recEndEnt.strIncrem) Then
  Begin
    cdsConsulta.Locate('AUTOINCREM', recEndEnt.strIncrem, []);
  End;

  If (Not fCfgSis('USASER', varBoolean)) Then
  begin
    grpServico.Visible := False;
    pnlHeader.Height := pnlHeader.Height - grpServico.Height;
  End;

  If Not (fCfgSis('USACCR', VarBoolean) And MatchStr(fCfgSis('TPNFCR'),[PRESTCON,SECOL])) Then
  Begin
    rdgCobIss.Visible := False;
    pnlHeader.Height := pnlHeader.Height - rdgCobIss.Height;
  End;

  If Not blnAlteraSelecionado Then
    btnConfAlteracoes.Enabled := False;

  pnlAviso.Visible := blnAviso And fEmptyStr(recEndEnt.strIncrem);

  If fEmptyStr(strPermiCadCid) Then
    strPermiCadCid := 'frmCadCidades';

  If ((blnOrigemCadCli)     And fValidarDirEspecificos(strDireitos, strLoginUsuarioLogado, 'CLENET')) Or
     ((Not blnOrigemCadCli) And fValidarDirEspecificos(strDireitos, strLoginUsuarioLogado, 'ENENC')) Then
  Begin
    btnIncluir.Visible := (Pos('I', strDireitos) > 0);
    btnAlterar.Visible := (Pos('A', strDireitos) > 0);
    btnExcluir.Visible := (Pos('E', strDireitos) > 0);
  End;

  pSetaVisibilidadeDadosCNPJEntrega;

  pnlTraRedesp.Visible := fCfgSis('UTTRDP', varBoolean);
  if not pnlTraRedesp.Visible then
  begin
    pnlHeader.Height := pnlHeader.Height
                      - pnlTraRedesp.Height;
  end;

  pnlLatLon.Visible := fCfgSis('MATDIS', varBoolean);
  If Not pnlLatLon.Visible Then
    pnlHeader.Height := pnlHeader.Height - pnlLatLon.Height;
end;

procedure TfrmCadCliEndEntrega.FormCreate(Sender: TObject);
Var
  intTipFre: Integer;
begin
  inherited;
  blnNovoClienteComCNPJ := False;
  strCNPJCadastroPrincipal := EmptyStr;
  strUFCadastroPrincipal := EmptyStr;
  blnSomenteSelecao := False;
  blnOcultaInativos := False;
  blnConfirma       := False;
  blnVendas         := False;
  blnDockPanel      := False;
  strCamChave       := 'ETC_SEQIND';
  qryConCiE         := qryCadCid;
  blnTemSelecao     := False;
  blnSelecionaComEspaco := False;

  With qryCadCid, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT CID_CODCID, CID_NOMCID, CID_ESTADO, CID_C_E_P_, CID_CODCOR FROM CADCID');
    Open;
  End;

  With qryCadTra, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT TRA_CODTRA, TRA_NOMTRA FROM CADTRA');
    Open;
  End;

  With qryCadReg, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT REG_CODREG, REG_DESREG FROM CADREG');
    Open;
  End;

  qryFacImg := fCriaQuery(Self);
  qryFacImg.SQL.Add('SELECT * FROM FACIMG WHERE IMG_SEQENT = :SEQENT');

  cmbTipFre.Clear;
  cmbTipFre.Items.Add('');
  For intTipFre In TiposFrete Do
    cmbTipFre.Items.Add(fDescricaoFrete(IntToStr(intTipFre)));

  cdsClone    := TUniClientDataSet.Create(Self);
  blnOrigemCadCli := False;
end;

procedure TfrmCadCliEndEntrega.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryFacImg);
  FreeAndNil(cdsClone);
  inherited;
end;

function TfrmCadCliEndEntrega.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    blnAtualizar: Boolean;
    objDadosNFe: TValidacaoDadosNFe;
    objLiberacao : TLiberacao;

    LCodigoCorreio: String;
    strCodRegiao : String;
    strEstCli : String;
    strEstEmp : String;
begin
  Result := True;
  blnAtualizar := False;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    {*****************************************}
    {* VALIDA A CIDADE DE ENTREGA            *}
    {**************************************MV*}
    If (Sender = dbeCidEnt) Then
    Begin
      If Not fEmptyStr(dbeCidEnt.Text) Then
      Begin
        pCarregaCidade(qryConCiE, dbeNomCid, dbeEstado, dbeCidEnt, dbeCepEnt, strCepEntAnt);
        If qryConCiE.FieldByName('CID_CODCID').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Not fEmptyStr(dbeEndEnt.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A cidade de entrega deve ser preenchida, pois ' +
                              'o endereço de entrega foi preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        dbeNomCid.Clear;
        dbeEstado.Clear;
      End;
    End

    Else If (Sender = dbeEstado) Then
    Begin
      strEstCli := fRetEstadoCliente(recEndEnt.strCodCli);
      If (Not fEmptyStr(dbeEstado.Text)) And (dbeEstado.Text <> strEstCli) Then
      Begin
        If (Not fVerificaAcessoSistema('PERMCADENDENTUFDIF')) Then
        Begin
          objLiberacao := TLiberacao.Create;
          Try
            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'PERMCADENDENTUFDIF';
            objLiberacao.strMsgSen    := 'Estado do endereço de entrega';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.strCodDig    := strLoginUsuarioLogado;
            objLiberacao.strCliente   := recEndEnt.strCodCli + '-' + recEndEnt.strNomCli;
            objLiberacao.strCpfCnpj   := fRetCgcCpf(recEndEnt.strCodCli);
            objLiberacao.objMsgLibera.pAddTexto('Estado do endereço de entrega diferente do endereço principal do cliente.');
            objLiberacao.objMsgLibera.pAddTextoCaption('UF de Entrega'       , dbeEstado.Text, 20);
            objLiberacao.objMsgLibera.pAddTextoCaption('UF do end. principal', strEstCli,      20);

            Result := objLiberacao.fLibera;

            If Result Then
              pGeraLogLiberacao('', '', '')
            Else
              fMensagem('ATENÇÃO!', 'Você não tem permissão para preencher um Estado '+
                                    'do endereço de entrega diferente do Estado do endereço principal!', ['&Ok']);
          Finally
            FreeAndNil(objLiberacao);
          End;
        End;
      End;

      If Result Then
      Begin
        strEstEmp := fRetUFEmpresa(VS_strCodEmp);
        If (Not fEmptyStr(dbeEstado.Text)) And (dbeEstado.Text <> strEstEmp) Then
        Begin
          If (Not fVerificaAcessoSistema('PERENTUFDIFEL')) Then
          Begin
            objLiberacao := TLiberacao.Create;
            Try
              objLiberacao.Clear;
              objLiberacao.strDirAce    := 'PERENTUFDIFEL';
              objLiberacao.strMsgSen    := 'Estado do endereço de entrega diferente do endereço da Empresa';
              objLiberacao.objMsgLibera.pAddTextoCaption('Estado do endereço de entrega diferente do endereço da Empresa: ', VS_strCodEmp, 70);
              objLiberacao.strCodOpe    := strLoginUsuarioLogado;
              objLiberacao.strCodDig    := strLoginUsuarioLogado;
              objLiberacao.objMsgLibera.pAddTextoCaption('UF de Entrega', dbeEstado.Text, 20);
              objLiberacao.objMsgLibera.pAddTextoCaption('UF da Empresa', strEstEmp,      20);
              objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ: ', fFormataCpfCgc(fRetCgcCpf(recEndEnt.strCodCli), fSetaPais), 20);
              objLiberacao.objMsgLibera.pAddTextoCaption('Cliente: ', recEndEnt.strCodCli + '-' + recEndEnt.strNomCli, 20);
              objLiberacao.objMsgLibera.pAddTextoCaption('Nome Fantasia', fRetNomFantasia(recEndEnt.strCodCli), 20);

              Result := objLiberacao.fLibera;

              If Not Result Then
              Begin
                fMensagem('ATENÇÃO!', 'Você não tem permissão para preencher um Estado '+
                                      'do endereço de entrega diferente do Estado da Empresa!', ['&Ok']);
              End;
            Finally
              FreeAndNil(objLiberacao);
            End;
          End;
        End;
      End;
    End

    Else If (Sender = dbeEndEnt) Then
    Begin
      If fEmptyStr(dbeEndEnt.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o endereço de entrega!', ['&Ok']);
        Result := False;
      End
      else if fCfgSis('ENDSTR', varBoolean) then
      begin
        If (dbeEndEnt.Text <> '') Then
          dbeEndEnt.Text := fRemoverEspacosQuebrasETabs(dbeEndEnt.Text);

        if length(dbeEndEnt.Text) > 60 then
        begin
          fMensagem('ATENÇÃO!', 'Sefaz autoriza notas fiscais com apenas 60 caracteres no endereço de entrega. Ajuste o tamanho do campo "Endereço" '+
                                'e efetue a gravação do cadastro.', ['&Ok']);
          Result := False;
        end;
      end
      Else
      Begin
        If (dbeEndEnt.Text <> '') Then
          dbeEndEnt.Text := fRemoverEspacosQuebrasETabs(dbeEndEnt.Text);

        objDadosNFe := TValidacaoDadosNFe.Create(nil);
        objDadosNFe.strEndEnt  := dbeEndEnt.Text;
        objDadosNFe.strEspDoc  := strEspDoc;
        objDadosNFe.ovOrigem   := ovCadEndEnt;
        objDadosNFe.blnCliCons := False;
        objDadosNFe.blnSomenteItensRetira := False;

        Result := fValidaDadosClienteNFe(objDadosNFe);

        FreeAndNil(objDadosNFe);
      End;
    End

    Else If (Sender = dbeBaiEnt) Then
    Begin
      If fEmptyStr(dbeBaiEnt.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o bairro!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        objDadosNFe := TValidacaoDadosNFe.Create(nil);
        objDadosNFe.strBaiEnt  := dbeBaiEnt.Text;
        objDadosNFe.strEspDoc  := strEspDoc;
        objDadosNFe.ovOrigem   := ovCadEndEnt;
        objDadosNFe.blnCliCons := False;
        objDadosNFe.blnSomenteItensRetira := False;

        Result := fValidaDadosClienteNFe(objDadosNFe);

        If (Result) And (strBaiEntLib <> dbeBaiEnt.Text) Then
          Result := fValidaBairro;

        FreeAndNil(objDadosNFe);
      End;
    End

    {******************************************}
    {   VALIDA O CAMPO REFERENCIA NA ENTREGA   }
    {     CONFORME CONFIGURACAO "CFG_REFCLO    }
    {****************************************RL}

    Else If (Sender = dbeRefEnt) Then
    Begin
      If fCfgSis('REFCLO') = 'S' Then
      Begin
        If (fEmptyStr(dbeRefEnt.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe a Referência do endereço de entrega!', ['&Ok']);
          Result := False;
        End;
      End;

      If Result Then
      Begin
        objDadosNFe := TValidacaoDadosNFe.Create(nil);
        objDadosNFe.strRefere := dbeRefEnt.Text;
        objDadosNFe.strEspDoc := strEspDoc;
        objDadosNFe.ovOrigem  := ovCadEndEnt;
        objDadosNFe.blnCliCons := False;
        objDadosNFe.blnSomenteItensRetira := False;

        Result := fValidaDadosClienteNFe(objDadosNFe);

        FreeAndNil(objDadosNFe);
      End;
    End

    Else If (Sender = dbeCepEnt) Then
    Begin

      If fCfgSis('CEPOBR', varBoolean) And fEmptyStr(fTiraCaracEspeciais(dbeCepEnt.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o CEP!', ['&Ok']);
        Result := False;
      End

      Else If (Not fEmptyStr(fTiraCaracEspeciais(dbeCepEnt.Text))) Then
      Begin
        If Length(Trim(fTiraCaracEspeciais(dbeCepEnt.Text))) < 8 Then
        Begin
          If fCfgSis('CEPOBR', varBoolean) Then
            fMensagem('ATENÇÃO!', 'O Cep deve conter 8 dígitos.', ['&Ok'])
          Else
            fMensagem('ATENÇÃO!', 'O Cep deve ser vazio ou com 8 dígitos.', ['&Ok']);
          Result := False;
        End;
      End;

      If (Result) And (Not fEmptyStr(dbeCepEnt.Text)) And (fCfgSis('USACEP', varBoolean)) Then
      Begin

        If (Not fCadCepDadosCep(dbeCepEnt.Text, strCidEnt, strEndEnt, strBaiEnt, strNomCidEnt,  strEstado, LCodigoCorreio,
                                                ''{qryConCiE.FieldByName('CID_ESTADO').AsString},
                                                ''{qryConCiE.FieldByName('CID_CODCOR').AsString})) Then
        Begin
          if (fCfgSis('INVCEP', varInteger) = 1) then
            Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1
          Else
          Begin
            fMensagem('ATENÇÃO!', 'CEP não encontrado! Verifique o cadastro de cidades e depois tente novamente.', ['&Ok']);
            Result := False;
          End;
        End
        Else
        Begin

          If (fEmptyStr(strCidEnt)) Then
          Begin

            If Not fVerificaAcessoSistema(strPermiCadCid) Then
            Begin
              fMensagem('ATENÇÃO!', fMensagemTravaAcessoCadCid(dbeCidEnt.Text, dbeNomCid.Text), ['&Ok']);

              Result := False;

            End

            Else

            If Not fEmptyStr(fRetNomCidade(dbeCidEnt.Text)) Then
            Begin

              If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + dbeNomCid.Text + ' está em branco.' + #13#10 +
                           'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?', ['&Sim', '&Não']) = 1 Then
              Begin
                pAtualizaCodigoCorreios(dbeCidEnt.Text, dbeCepEnt.Text);
                strCidEnt := dbeCidEnt.Text;
              End

              Else Result := False;

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
          Else If (Not fEmptyStr(strNomCidEnt)) And (fEmptyStr(dbeEndEnt.Field.AsString)) Then
            dbeEndEnt.Field.AsString := strNomCidEnt;

          If Result Then
          Begin
            blnAtualizar := False;
            If (strCepEntAnt <> dbeCepEnt.Text) Then
            Begin
              If fTiraCaracEspeciais(strCepEntAnt) = '' Then
              Begin
                blnAtualizar := True;
              End
              Else
              If fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1 Then
              Begin
                blnAtualizar := True;
              End;
            End;

            if fCfgSis('CEPREG', varBoolean) And ((strCepEntAnt <> dbeCepEnt.Text) Or (fEmptyStr(dbeRegEnt.Text)))  then
            begin
              strCodRegiao := fRetornarCodRegiao(dbeCepEnt.Text);

              if Not fEmptyStr(strCodRegiao) then
              begin
                dbeRegEnt.Field.AsString := strCodRegiao;
                dbeRegEnt.Enabled := false;
                dbeDesReg.Field.AsString := fRetNomRegiao(dbeRegEnt.Text);
              end
              Else
              Begin
                dbeRegEnt.Field.Clear;
                dbeDesReg.Field.Clear;
                dbeRegEnt.Enabled := true;
              End;
            end;

            If fEmptyStr(dbeCidEnt.Text) Or (blnAtualizar) Then
            Begin
              dbeCidEnt.Field.AsString := strCidEnt;
              pCarregaCidade(qryConCiE, dbeNomCid, dbeEstado, dbeCidEnt, Nil, strCepEntAnt);
            End;

            If fEmptyStr(dbeEndEnt.Text) Or (blnAtualizar) Then
              dbeEndEnt.Field.AsString := strEndEnt;

            If fEmptyStr(dbeBaiEnt.Text) Or (blnAtualizar) Then
              dbeBaiEnt.Field.AsString := strBaiEnt;

            If fEmptyStr(dbeRefEnt.Text) Or (blnAtualizar) Then
              dbeRefEnt.Field.AsString := strRefEnt;

          End;

        End;


        If (Result) Then
        Begin
          strCepEntAnt := dbeCepEnt.Text;
          If blnAtualizar Then
          Begin
            pSetFocus(dbeEndEnt);
            blnMudarFoco := False;
          End;
        End;

      End;

    End

    Else If (Sender = dbeRegEnt) Then
    Begin
      Result := fValidaRegiao;
    End

    Else If (Sender = dbeTraEnt) Then
    Begin
      Result := fValidaTransportadora;
    End

    Else If (Sender = dbeTelEnt) Then
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

    {Situação do Endereço}
    Else If (Sender = dbeSituac) Then
    Begin

      If fEmptyStr(dbeSituac.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A situação do endereço deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      If (dbeSituac.Text <> 'A') And (dbeSituac.Text <> 'I') Then
        Result := False;

      If (Result) Then
      Begin
        If (dbeSituac.Text = 'I') Then
        Begin
          If (cdsConsultaETC_ENDFAT.AsString = 'S') Then
          Begin
            If (Not fCfgSis('INAEND', varBoolean)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é permitido inativar o endereço padrão!', ['&Ok']);
              Result := False;
            End
            Else
            Begin
              If fMensagem('ATENÇÃO!', 'O endereço selecionado é o endereço padrão do cliente.' + #13 +
                                       'Deseja realmente inativá-lo?', ['&Sim', '&Não'], 2) = 2 Then
                Result := False
            End;
          End;
          If (Result) Then
          Begin
            If (not fVerificaPossuiEnderecoAtivo) Then
            Begin
              fMensagem('ATENÇÃO!', 'Pelo menos um endereço de entrega tem que estar ativo no cadastro!', ['&Ok']);
              Result := False;
            End;
          End;
        End;
      End;
    End

    Else If (Sender = dbeTraRed) and
            (fCfgSis('UTTRDP', varBoolean)) Then
    Begin
      If (fEmptyStr(dbeTraRed.Text)) Then
        dbeNomTrd.Clear
      Else
      Begin
        dbeNomTrd.Text := fRetNomTransportadora(dbeTraRed.Text);

        If fEmptyStr(dbeNomTrd.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Transportadora não está cadastrada!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeNuCnpjEntrega) And
            (dbeNuCnpjEntrega.Visible) Then
    Begin
      Result := fValidaCnpjEntrega(Sender);
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender)

  Else If blnDockPanel And blnMudarFoco Then
  Begin
    blnMudarFoco := False;
    SelectNext(Sender, True, True);
  End;

end;

function TfrmCadCliEndEntrega.fValidaCnpjEntrega(const Sender : TObject): Boolean;
begin
  Result := False;

  If (fEmptyStr(TDBEditFocus(Sender).Text)) Then
    Exit(True);

  If Not fValidaCnpjCpf('1', TDBEditFocus(Sender).Text, False, False) Then
    Exit;

  If (fJaTemEsseCNPJEmAlgumCadastro(TDBEditFocus(Sender).Text)) Then
    Exit;

  If (Not fMesmaRaizDeCNPJCliente(TDBEditFocus(Sender).Text)) Then
    Exit;

  If (Not fValidouEstadoCNPJs) Then
    Exit;

  Result := True;
end;

function TfrmCadCliEndEntrega.fValidouEstadoCNPJs : Boolean;
  Var
    strUFPrincipal : String;
begin
  Result := False;
  If fEmptyStr(dbeEstado.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário preencher a cidade de entrega com uma UF válida!', ['&OK']);
    Exit;
  End;

  If (blnNovoClienteComCNPJ) Then
  Begin
    If fEmptyStr(strUFCadastroPrincipal) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário preencher a cidade do cadastro principal com uma UF válida!', ['&OK']);
      Exit;
    End;
  End;

  If (blnNovoClienteComCNPJ) Then
    strUFPrincipal := strUFCadastroPrincipal
  Else
    strUFPrincipal := fRetEstadoCliente(recEndEnt.strCodCli);

  If (strUFPrincipal <> dbeEstado.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Permitido informar CNPJ apenas para endereços de entrega com mesma UF do endereço principal!' + sLineBreak +
                          'UF Principal: ' + strUFPrincipal + sLineBreak +
                          'UF Entrega: ' + dbeEstado.Text, ['&OK']);
    Exit;
  End;
  Result := True;
end;

function TfrmCadCliEndEntrega.fMesmaRaizDeCNPJCliente(const strCNPJ : String) : Boolean;
  Var
    strCNPJCliente : String;
begin
  Result := False;

  If (blnNovoClienteComCNPJ) Then
  Begin
    If (fEmptyStr(strCNPJCadastroPrincipal)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário preencher o CNPJ do cadastro principal antes de cadastrar um novo CNPJ de Entrega!', ['&OK']);
      Exit;
    End;
  End;

  If (blnNovoClienteComCNPJ) Then
    strCNPJCliente := strCNPJCadastroPrincipal
  Else
    strCNPJCliente := fRetCgcCpf(recEndEnt.strCodCli);

  Result := (LeftStr(fTiraCaracEspeciaisPonto(strCNPJ),8) = LeftStr(fTiraCaracEspeciaisPonto(strCNPJCliente),8));
  If (Not Result) Then
    fMensagem('ATENÇÃO!', 'Estabelecimento da entrega deverá estar na mesma raiz de CNPJ do cliente principal!', ['&OK']);
end;

function TfrmCadCliEndEntrega.fJaTemEsseCNPJEmAlgumCadastro(const strCNPJ : String) : Boolean;
  Var
    cdsCloneConsulta : TUniClientDataSet;
    strChave : String;
    strCodCli : String;
    strClienteQueContemCNPJ : String;
begin
  Result := False;

  If (Not cdsConsulta.Active) Then
    Exit;

  If (Not cdsClone.Active) Then
    Exit;

  If (blnNovoClienteComCNPJ) Then
  Begin
    If (strCNPJ = strCNPJCadastroPrincipal) Then
    Begin
      Result := True;
      fMensagem('ATENÇÃO!', 'CNPJ já informado no cadastro principal do cliente!', ['&OK']);
      Exit;
    End;
  End;

  strChave := cdsClone.FieldByName('AUTOINCREM').AsString;
  strCodCli := cdsClone.FieldByName('ETC_CODCLI').AsString;

  cdsCloneConsulta := TUniClientDataSet.Create(Self);
  Try
    cdsCloneConsulta.Data := cdsClone.Data;
    cdsCloneConsulta.Filter := 'AUTOINCREM <> ' + QuotedStr(strChave) + ' AND ETC_NUCNPJ = ' + QuotedStr(strCNPJ);
    cdsCloneConsulta.Filtered := True;
    Result := (Not cdsCloneConsulta.IsEmpty);

    If (Result) Then
    Begin
      fMensagem('ATENÇÃO!', 'CNPJ já informado em outro endereço de entrega deste cliente!', ['&OK']);
      Exit;
    End;

    Result := TClienteEnderecoEntregaRepositorio.fExisteCnpjEntrega(strCNPJ, strCodCli, strChave, strClienteQueContemCNPJ);
    If (Result) Then
    Begin
      fMensagem('ATENÇÃO!', 'CNPJ já informado no endereço de entrega do cliente:' + sLineBreak +
                            'Cliente: ' + strClienteQueContemCNPJ + '-' + fRetNomCliente(strClienteQueContemCNPJ), ['&OK']);
      Exit;
    End;

    If (Not blnNovoClienteComCNPJ) And (strCNPJ = fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli])) Then
    Begin
      Result := True;
      fMensagem('ATENÇÃO!', 'CNPJ já informado no cadastro principal do cliente!', ['&OK']);
      Exit;
    End;
  Finally
    FreeAndNil(cdsCloneConsulta);
  End;
end;

function TfrmCadCliEndEntrega.fValidaRegiao: Boolean;
begin
  Result := True;

  If (Not fEmptyStr(dbeRegEnt.Text)) Then
  Begin
    dbeDesReg.Text := fRetNomRegiao(dbeRegEnt.Text);
    If (fEmptyStr(dbeDesReg.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa região não está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End
  Else
  Begin
    If fCfgSis('REGCLO', varBoolean) and (dbeRegEnt.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe a região do endereço de entrega!', ['&Ok']);
      Result := False;
    End;
  End;
end;

function TfrmCadCliEndEntrega.fValidaTransportadora: Boolean;
begin
  Result := True;

  If (Not fEmptyStr(dbeTraEnt.Text)) Then
  Begin
    dbeNomTra.Text := fRetNomTransportadora(dbeTraEnt.Text);
    If (fEmptyStr(dbeNomTra.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa transportadora não está cadastrada!', ['&Ok']);
      Result := False;
    End;

    if blnVendas and (not fRetTransportadoraAtiva(dbeTraEnt.Text)) then
    begin
      fMensagem('', 'Essa transportadora está inativada!', ['&Ok']);
      Result := False;
    end;
  End
  Else
  Begin
    dbeNomTra.Clear;
  End;
end;

function TfrmCadCliEndEntrega.fExisteAlgumEnderecoNoEstado(const strEstado: String): Boolean;
begin
  Result := False;
  If fEmptyStr(strEstado) Then
    Exit;
  If Not cdsConsulta.Active Then
    Exit;

  cdsConsulta.DisableControls;
  Try
    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      If SameText(fRetNomCidade(cdsConsultaETC_CIDENT.AsString, 1), strEstado) Then
      Begin
        Result := True;
        Break;
      End;
      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.EnableControls;
  End;
end;

function TfrmCadCliEndEntrega.fExisteTransp(strCodTra: String): Boolean;
Var
  qryAux: TUniQuery;
begin
  Result := False;

  qryAux := fCriaQuery;
  Try
    qryAux.Close;
    qryAux.SQL.Text := ' SELECT       '+
                       '   TRA_CODTRA '+
                       ' FROM         '+
                       '   CADTRA     '+
                       ' WHERE        '+
                       '   TRA_CODTRA = :CODTRA ';
    qryAux.ParamByName('CODTRA').AsString := strCodTra;
    qryAux.Open;

    If not qryAux.IsEmpty Then
      Result := True;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmCadCliEndEntrega.pCarregaCidade(qryConsulta: TUniQuery; dbeNomCid,
  dbeEstado, dbeCidade, dbeCep: TDBEditFocus; Var strCepAnt: String);
begin
  If cdsConsulta.State In [dsInsert, dsEdit] Then
  Begin
    pPesquisaCadCid(qryCadCid, qryConsulta, dbeCidade.Text);
    With qryConsulta Do
    Begin
      dbeNomCid.Field.AsString := FieldByName('CID_NOMCID').AsString;
      dbeEstado.Field.AsString := FieldByName('CID_ESTADO').AsString;

      If (Assigned(dbeCep)) And (dbeCep.Field <> Nil) And (dbeCep.Field.IsNull) Then
      Begin
        dbeCep.Field.AsString := FieldByName('CID_C_E_P_').AsString;
        strCepAnt := FieldByName('CID_C_E_P_').AsString;
      End;
    End;
  End;
end;

function TfrmCadCliEndEntrega.dbeCidEntChamaCadastro(Key: Word): string;
begin
  inherited;
  If fVerificaAcessoSistema('frmCadCidades') Then
    Result := fChamaCadCid(Key)
  Else
    fMensagem('','Sem permissão para Cadastro de Cidades!',['&Ok']);
end;

procedure TfrmCadCliEndEntrega.dbeCidEntKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If Not dbeCidEnt.ReadOnly Then
  Begin
    If fPesqCidade(Self, dbeCidEnt, nil, nil, qryCadCid, Key, arrSel) Then
    Begin
      If fValidaCampos(dbeCidEnt, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCliEndEntrega.dbeRegEntKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrReg: TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If (not dbeRegEnt.ReadOnly) and fPesqRegiao(Self, dbeRegEnt, Nil, Nil, Key, arrReg) Then
  Begin
    If fValidaCampos(dbeRegEnt, True) Then
      SelectNext(dbeRegEnt, True, True);
  End;
end;

function TfrmCadCliEndEntrega.dbeTraEntChamaCadastro(Key: Word): string;
begin
  inherited;
  If fVerificaAcessoSistema('frmCadTransportadoras') Then
    Result := fChamaCadTra(Key)
  Else
    fMensagem('','Sem permissão para Cadastro de Transportadora!',['&Ok']);
end;

procedure TfrmCadCliEndEntrega.dbeTraEntKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTransp: TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If fPesqTransportadora(conTraSimples, Self, dbeTraEnt, Nil, Nil, Key, arrTransp, True, '', IfThen(blnVendas, 'S')) Then
  Begin
    If fValidaCampos(dbeTraEnt, True) Then
      SelectNext(dbeTraEnt, True, True);
  End;

end;

procedure TfrmCadCliEndEntrega.dbeTraRedKeyPress(Sender: TObject;
  var Key: Char);
var
  arrTra : TConsultasArray;
begin
  inherited;
  if fPesqTransportadora(conTraCompleta, Self, dbeTraRed, Nil, Nil, Key, arrTra, True, '', 'S') then
  begin
    if fValidaCampos(dbeTraRed, True) then
      SelectNext(dbeTraRed, True, True);
  end;
end;

procedure TfrmCadCliEndEntrega.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Column.Index <> lflLastField.intIndCol then
  Begin

    If cdsConsultaETC_ENDFAT.AsString = 'S' then
    Begin
      dbgConsulta.Canvas.Brush.Color := clYellow;
      dbgConsulta.Canvas.Font.Color  := clBlack;
      dbgConsulta.Canvas.FillRect(Rect);
    End;

    {Situação A-Ativo / I-Inativo}
    If cdsConsultaETC_SITUAC.AsString = 'I' then
    Begin
      dbgConsulta.Canvas.Brush.Color := clRed;
      dbgConsulta.Canvas.Font.Color  := clBlack;
      dbgConsulta.Canvas.FillRect(Rect);
    End;

  End;

  If cdsConsultaAUTOINCREM.AsString = recEndEnt.strIncrem Then
  Begin
    dbgConsulta.Canvas.Font.Style := [fsBold];
  End;

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  
end;

procedure TfrmCadCliEndEntrega.edtLatLonKeyPress(Sender: TObject;
  var Key: Char);
Const
  arrKeys = ['0'..'9', '-', '.', ',', #8, #32];
begin
  inherited;
  If Not CharInset(Key, arrKeys) Then
    Key:= #0;
end;

procedure TfrmCadCliEndEntrega.dbeCepEntKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (not dbeCepEnt.ReadOnly) and (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Key := #0;

    dbeCepEnt.Field.AsString := fConsultarCep(Self, dbeCepEnt.Text, dbeCepEnt);




  End;
end;

procedure TfrmCadCliEndEntrega.pLimpaEndereco;
Begin
  With recEndEnt Do
  Begin
    strIncrem := '';
    strEndEnt := '';
    strTelEnt := '';
    strBaiEnt := '';
    strCepEnt := '';
    strCidEnt := '';
    strCodCid := '';    
    strEstEnt := '';
    strRefEnt := '';
    strCodTra := '';
    strCobIss := '';    
    strCodObr := '';
    strCodReg := '';
    strCodArt := '';
    strCodCno := '';
    strInsImo := '';
    strCodCib := '';
    strTipFre := '';
    strTraRed := '';
  End;
End;

procedure TfrmCadCliEndEntrega.pPreencherPnlInfo;
begin
  if cdsConsulta.FieldByName('ETC_ENDFAT').AsString = 'S' then
    pnlInfo.Caption := 'O endereço principal deve ser alterado nas abas "Geral" e "Complementos" do cadastro de clientes.'
  else
    pnlInfo.Caption := EmptyStr;
end;

procedure TfrmCadCliEndEntrega.pRetornaEndereco;
Begin
  With cdsConsulta Do
  Begin
    With recEndEnt Do
    Begin
      strIncrem := FieldByName('AUTOINCREM').AsString;
      strEndEnt := FieldByName('ETC_ENDENT').AsString;
      strBaiEnt := FieldByName('ETC_BAIENT').AsString;
      strCepEnt := FieldByName('ETC_CEPENT').AsString;
      strCidEnt := FieldByName('ETC_CIDENT').AsString;
      strCodCid := FieldByName('ETC_CIDENT').AsString;
      strEstEnt := fRetNomCidade(FieldByName('ETC_CIDENT').AsString, 1);
      strRefEnt := FieldByName('ETC_REFENT').AsString;
      strCodTra := FieldByName('ETC_CODTRA').AsString;
      strCobIss := FieldByName('ETC_COBISS').AsString;
      strCodObr := FieldByName('ETC_CODOBR').AsString;
      strCodArt := FieldByName('ETC_CODART').AsString;
      strCodCno := FieldByName('ETC_CODCNO').AsString;
      strInsImo := FieldByName('ETC_INSIMO').AsString;
      strCodCib := FieldByName('ETC_CODCIB').AsString;
      strTelEnt := FieldByName('ETC_TELENT').AsString;
      strConEnt := FieldByName('ETC_CONENT').AsString;
      strCodReg := FieldByName('ETC_CODREG').AsString;
      strTipFre := FieldByName('ETC_TIPFRE').AsString;
      strTraRed := FieldByName('ETC_TRARED').AsString;
    End;
  End;
End;

procedure TfrmCadCliEndEntrega.pSetaVisibilidadeDadosCNPJEntrega;
  Var
    colCNPJ : TColumn;
    blnVisible : Boolean;
begin
  If (blnNovoClienteComCNPJ) Then
    blnVisible := (fCfgSis('CNPENT', varString) = 'S')
  Else
    blnVisible := (Not fEmptyStr(recEndEnt.strCodCli)) And (fCfgSis('CNPENT', varString) = 'S') And (fClientePessoaJuridica(recEndEnt.strCodCli));
  lblCNPJEntrega.Visible := blnVisible;
  dbeNuCnpjEntrega.Visible := blnVisible;
  colCNPJ := fFindColumnByName(dbgConsulta, 'ETC_NUCNPJ');
  If Assigned(colCNPJ) Then
    colCNPJ.Visible := blnVisible;
end;

function TfrmCadCliEndEntrega.fGravarEnderecosEntregaCliente: Boolean;
  Var
    strIndex: String;
begin
  btnCancela.Click;
  pSetFilterDefault;

  With cdsConsulta Do
  Begin
    DisableControls;
    try
      strIndex := IndexFieldNames;
      IndexFieldNames := 'ETC_SEQIND';
      First;
      While Not Eof Do
      Begin
        Edit;
        FieldByName('ETC_CODCLI').AsString  := recEndEnt.strCodCli;

        If (FieldByName('AUTOINCREM').IsNull) or (FieldByName('AUTOINCREM').AsString = '') Then
          FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ENTCLI', VS_strCodEmp);

        If fEmptyStr(FieldByName('ETC_CODTRA').AsString) Then
          FieldByName('ETC_CODTRA').Value  := Null;

        If fEmptyStr(FieldByName('ETC_CODREG').AsString) Then
          FieldByName('ETC_CODREG').Value  := Null;

        Post;
        Next;
      End;

      if ApplyUpdates(0) <> 0 then
        Exit(False);

      IndexFieldNames := strIndex;
      First;

      If Not blnDockPanel Then
      Begin
        If (Not fEmptyStr(strSeqInd)) And Locate('ETC_SEQIND', strSeqInd, []) Then
          pRetornaEndereco
        Else
          pLimpaEndereco;
      End;

      if ApplyUpdates(0) <> 0 then
        Exit(False);
    finally
      EnableControls;
    end;
  End;

  pSetFilterDefault;
  Result := True;
end;

Function TfrmCadCliEndEntrega.fRetSeqIndEndereco(strCodCli: String; strCampo: String): Integer;
Begin
  Result := untFuncoesSimples.fRetSeqIndEndereco(strCodCli, strCampo);
End;

procedure TfrmCadCliEndEntrega.pAtualizaEnderecoPadrao(qryCadCli: TUniQuery);
  Var
    qryEntEnt: TUniQuery;
    strEndere: String;
Begin
  With qryCadCli do
  strEndere := FieldByName('CLI_ENDERE').AsString +
               IIF(FieldByName('CLI_ENDNUM').AsString = '', '', ', ') +
               FieldByName('CLI_ENDNUM').AsString +
               IIF(FieldByName('CLI_ENDCOM').AsString = '', '', ' - ') +
               FieldByName('CLI_ENDCOM').AsString;

  qryEntEnt := fCriaQuery;
  With qryEntEnt, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM ENTCLI');
    Add('WHERE ');
    Add('  ETC_CODCLI = :CODCLI AND ');
    Add('  ETC_ENDFAT = "S"         ');
    ParamByName('CODCLI').AsString := qryCadCli.FieldByName('CLI_CODCLI').AsString;
    Open;

    If Not IsEmpty Then
    Begin
      Edit;
    End Else
    Begin

      Clear;
      Add('SELECT * FROM ENTCLI');
      Add('WHERE ');
      Add('  ETC_CODCLI = :CODCLI AND ');
      Add('  ETC_CIDENT = :CIDENT AND ');
      Add('  ETC_ENDENT = :ENDENT AND ');
      Add('  ETC_BAIENT = :BAIENT AND ');
      Add('  ETC_CEPENT = :CEPENT     ');

      ParamByName('CODCLI').AsString := qryCadCli.FieldByName('CLI_CODCLI').AsString;
      ParamByName('CIDENT').AsString := qryCadCli.FieldByName('CLI_CODCID').AsString;
      ParamByName('ENDENT').AsString := strEndere;
      ParamByName('BAIENT').AsString := qryCadCli.FieldByName('CLI_BAIRRO').AsString;
      ParamByName('CEPENT').AsString := qryCadCli.FieldByName('CLI_C_E_P_').AsString;

      Open;

      If Not IsEmpty Then
      Begin
        Edit;
      End Else
      Begin
        qryEntEnt.Insert;
        FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ENTCLI', VS_strCodEmp);
        FieldByName('ETC_SEQIND').AsInteger := fRetSeqIndEndereco(qryCadCli.FieldByName('CLI_CODCLI').AsString, 'ETC_SEQIND');
        FieldByName('ETC_SEQVIS').AsInteger := fRetSeqIndEndereco(qryCadCli.FieldByName('CLI_CODCLI').AsString, 'ETC_SEQVIS');
      End;

    End;

    FieldByName('ETC_ENDFAT').AsString := 'S';
    FieldByName('ETC_CODCLI').AsString := qryCadCli.FieldByName('CLI_CODCLI').AsString;
    FieldByName('ETC_CIDENT').AsString := qryCadCli.FieldByName('CLI_CODCID').AsString;
    FieldByName('ETC_ENDENT').AsString := strEndere;
    FieldByName('ETC_BAIENT').AsString := qryCadCli.FieldByName('CLI_BAIRRO').AsString;
    FieldByName('ETC_CEPENT').AsString := qryCadCli.FieldByName('CLI_C_E_P_').AsString;
    FieldByName('ETC_COBISS').AsString := qryCadCli.FieldByName('CLI_COBISS').AsString;
    FieldByName('ETC_CODOBR').AsString := qryCadCli.FieldByName('CLI_CODOBR').AsString;
    FieldByName('ETC_CODART').AsString := qryCadCli.FieldByName('CLI_CODART').AsString;
    FieldByName('ETC_CODCNO').AsString := qryCadCli.FieldByName('CLI_CODCNO').AsString;
    FieldByName('ETC_INSIMO').AsString := qryCadCli.FieldByName('CLI_INSIMO').AsString;
    FieldByName('ETC_CODCIB').AsString := qryCadCli.FieldByName('CLI_CODCIB').AsString;
    FieldByName('ETC_TELENT').AsString := qryCadCli.FieldByName('CLI_FONE01').AsString;
    FieldByName('ETC_CONENT').AsString := qryCadCli.FieldByName('CLI_CONTAT').AsString;

    If fEmptyStr(FieldByName('ETC_CODTRA').AsString) Then
    Begin
      FieldByName('ETC_CODTRA').Value := Null;

      If (cdsConsulta.State = dsInsert) And (fCfgSis('ENTRBR', varString) = 'N') Then
      Begin
        If Assigned(cdsConsulta) And (Not fEmptyStr(cdsConsulta.FieldByName('ETC_CODTRA').AsString)) Then
          FieldByName('ETC_CODTRA').AsString := cdsConsulta.FieldByName('ETC_CODTRA').AsString
        Else If Not fEmptyStr(fCfgSis('TRASUG')) Then
        Begin
          If fExisteTransp(fCfgSis('TRASUG')) Then
            FieldByName('ETC_CODTRA').AsString := fCfgSis('TRASUG')
          Else
          Begin
            fMensagem('ATENÇÃO!', '"Transportadora Sugestão" está inválida nas configurações do sistema. Favor corrigir!', ['&Ok']);
            FieldByName('ETC_CODTRA').Value := Null;
          End;
        End
        Else
          FieldByName('ETC_CODTRA').Value := Null;
      End;
    End;

    If fCfgSis('UTTRDP',varBoolean) Then
    Begin
      If fEmptyStr(FieldByName('ETC_TRARED').AsString) Then
      Begin
        If Assigned(cdsConsulta) And (Not fEmptyStr(cdsConsulta.FieldByName('ETC_TRARED').AsString)) Then
          FieldByName('ETC_TRARED').AsString := cdsConsulta.FieldByName('ETC_TRARED').AsString
        Else
          FieldByName('ETC_TRARED').Value := Null;
      End;
    End;

    If fEmptyStr(FieldByName('ETC_CODREG').AsString) Then
    Begin
      If Assigned(cdsConsulta) And (Not fEmptyStr(cdsConsulta.FieldByName('ETC_CODREG').AsString)) Then
        FieldByName('ETC_CODREG').AsString := cdsConsulta.FieldByName('ETC_CODREG').AsString
      Else
        FieldByName('ETC_CODREG').Value := Null;
    End;

    Post;
  End;
  FreeAndNil(qryEntEnt);
End;

procedure TfrmCadCliEndEntrega.pAtualizaEnderecoPadrao(strCodCli,
                                                       strCodCid,
                                                       strEndere,
                                                       strEndNum,
                                                       strEndCom,
                                                       strBairro,
                                                       strC_E_P_,
                                                       strCobIss,
                                                       strCodObr,
                                                       strCodArt,
                                                       strCodCno,
                                                       strFone01,
                                                       strCodReg,
                                                       strContat,
                                                       strInsImo,
                                                       strCodCib: String);
  Var
    strEndereN : String;
    intSeqVis : Integer;
    intSeqInd : Integer;
Begin
  if cdsConsulta.Locate('ETC_ENDFAT', 'S',[]) Then
    cdsConsulta.Edit
  Else
  Begin
    intSeqVis := fRetProxSeqVis;
    intSeqInd := fRetProxSeqInd;

    cdsConsulta.Insert;
    cdsConsulta.FieldByName('ETC_ENDFAT').AsString := 'S';
    cdsConsulta.FieldByName('ETC_SEQIND').AsInteger := intSeqInd;
    cdsConsulta.FieldByName('ETC_SEQVIS').AsInteger := intSeqVis;
    cdsConsulta.FieldByName('ETC_TIPFRE').AsString := '';
  End;

  strEndereN := strEndere +
               IIF(strEndNum = '', '', ', ')  +
                   strEndNum +
               IIF(strEndCom = '', '', ' - ') +
                   strEndCom;

  With cdsConsulta Do
  Begin

    FieldByName('ETC_CODCLI').AsString := strCodCli;
    FieldByName('ETC_CIDENT').AsString := strCodCid;
    FieldByName('ETC_ENDENT').AsString := strEndereN;
    FieldByName('ETC_BAIENT').AsString := strBairro;
    FieldByName('ETC_CEPENT').AsString := strC_E_P_;
    FieldByName('ETC_COBISS').AsString := strCobIss;
    FieldByName('ETC_CODOBR').AsString := strCodObr;
    FieldByName('ETC_CODART').AsString := strCodArt;
    FieldByName('ETC_CODCNO').AsString := strCodCno;
    FieldByName('ETC_INSIMO').AsString := strInsImo;
    FieldByName('ETC_CODCIB').AsString := strCodCib;
    FieldByName('ETC_TELENT').AsString := strFone01;
    FieldByName('ETC_CONENT').AsString := strContat;
    FieldByName('ETC_CODREG').AsString := strCodReg;

    If fEmptyStr(FieldByName('ETC_CODTRA').AsString) Then
    Begin
      FieldByName('ETC_CODTRA').Value := Null;

      If (cdsConsulta.State = dsInsert) And (fCfgSis('ENTRBR', varString) = 'N') Then
      Begin
        If Not fEmptyStr(fCfgSis('TRASUG')) Then
        Begin
          If fExisteTransp(fCfgSis('TRASUG')) Then
            FieldByName('ETC_CODTRA').AsString := fCfgSis('TRASUG')
          Else
          Begin
            fMensagem('ATENÇÃO!', '"Transportadora Sugestão" está inválida nas configurações do sistema. Favor corrigir!', ['&Ok']);
            FieldByName('ETC_CODTRA').Value := Null;
          End;
        End
        Else
          FieldByName('ETC_CODTRA').Value := Null;
      End;
    End;

    If fCfgSis('UTTRDP',varBoolean) Then
    Begin
      If fEmptyStr(FieldByName('ETC_TRARED').AsString) Then
      Begin
        If Assigned(cdsConsulta) And (Not fEmptyStr(cdsConsulta.FieldByName('ETC_TRARED').AsString)) Then
          FieldByName('ETC_TRARED').AsString := cdsConsulta.FieldByName('ETC_TRARED').AsString
        Else
          FieldByName('ETC_TRARED').Value := Null;
      End;
    End;

    Post;

    cdsConsultaAfterScroll(cdsConsulta);
  End;
End;

procedure TfrmCadCliEndEntrega.pAtualizarSeqVis(blnCima: Boolean);

  Var
    prcScroll: TprcScroll;
    strAutInc: String;
    stlListag: TStringList;
    blnAltera: Boolean;
    intCnt : Integer;

  function fIndiceAceitavel(intIndice: Integer): Boolean;
    Var
      intCount : Integer;
  begin
    intCount := stlListag.Count;
    Result := Not ((intIndice < 0) Or (intIndice >= intCount));
  end;

begin
  stlListag := TStringList.Create;
  strAutInc := cdsConsulta.FieldByName('AUTOINCREM').AsString;
  blnAltera := False;
  pDisableControls(cdsConsulta, prcScroll);

  Try
    With cdsConsulta Do
    Begin
      stlListag.Clear;

      First;
      While Not Eof Do
      Begin
        stlListag.Add(FieldByName('AUTOINCREM').AsString);
        Next;
      End;

      If (blnCima) And (fIndiceAceitavel(stlListag.IndexOf(strAutInc)-1)) Then
      Begin
        stlListag.Exchange(stlListag.IndexOf(strAutInc), stlListag.IndexOf(strAutInc)-1);
        blnAltera := True;
      End
      Else If (Not blnCima) And (fIndiceAceitavel(stlListag.IndexOf(strAutInc)+1)) Then
      Begin
        stlListag.Exchange(stlListag.IndexOf(strAutInc), stlListag.IndexOf(strAutInc)+1);
        blnAltera := True;
      End;

      If blnAltera Then
      Begin
        For intCnt := 0 To (stlListag.Count -1) Do
        Begin
          If cdsConsulta.Locate('AUTOINCREM', stlListag.Strings[intCnt], []) Then
          Begin
            Edit;
            FieldByName('ETC_SEQVIS').AsInteger := intCnt;
            Post;
          End;
        End;
      End;

      cdsConsulta.Locate('AUTOINCREM', strAutInc, []);
    End;
  Finally
    pEnableControls(cdsConsulta, prcScroll);
  End;

  FreeAndNil(stlListag);
end;

procedure TfrmCadCliEndEntrega.btnCancelaClick(Sender: TObject);
begin
  inherited;
  cdsConsultaAfterScroll(cdsConsulta);
end;

procedure TfrmCadCliEndEntrega.btnConfAlteracoesClick(Sender: TObject);
begin
  inherited;
  If cdsConsulta.IsEmpty Then
    strSeqInd := ''
  Else
    strSeqInd := cdsConsulta.FieldByName('ETC_SEQIND').AsString;

  If blnDockPanel Then Exit;
  pSetFilterDefault;
  If (cdsConsulta.ChangeCount = 0) Or (fMensagem('','Confirma alterações?', ['','']) = 1)  Then
  Begin
    If fValidaCampos(dbeEndEnt) And
       fValidaCampos(dbeBaiEnt) And
       fValidaCampos(dbeRefEnt) And
       fValidaCampos(dbeTraEnt) Then
    Begin
      blnConfirma := True;

      if not fValidaCodigoIBGE(cdsConsulta.FieldByName('ETC_CIDENT').AsString) then
      begin
        blnConfirma := False;
        Exit;
      end;

      if not fGravarEnderecosEntregaCliente then
        Exit;

      If blnVendas Then
        Close
      Else
        pIniciaPesquisa;
    End;
  End;
end;

procedure TfrmCadCliEndEntrega.btnConsultarEnderecoClick(Sender: TObject);
var
  frmConsultaMapaGoogleMaps : TfrmConsultaMapaGoogleMaps;
begin
  inherited;
  pCriarFormularios(TfrmConsultaMapaGoogleMaps, frmConsultaMapaGoogleMaps);
  Try
    frmConsultaMapaGoogleMaps.strEndere := dbeEndEnt.Text;
    frmConsultaMapaGoogleMaps.strBairro := dbeBaiEnt.Text;
    frmConsultaMapaGoogleMaps.strEstado := dbeEstado.Text;
    frmConsultaMapaGoogleMaps.strCodCid := dbeCidEnt.Text;
    frmConsultaMapaGoogleMaps.strNomCid := dbeNomCid.Text;
    frmConsultaMapaGoogleMaps.strEndNum := '';
    frmConsultaMapaGoogleMaps.ShowModal;
  Finally
    pFreeAndNil(frmConsultaMapaGoogleMaps);
  End;
end;

procedure TfrmCadCliEndEntrega.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If (Key = VK_F4) And (Shift = [ssAlt]) And blnDockPanel Then
  Begin
    Key := 0;
    //PARA NAO FECHAR O FORM COM ALT + F4
  End
  Else

  If (Key = VK_ESCAPE) And (Not (cdsConsulta.State In [dsInsert, dsEdit])) And blnDockPanel Then
  Begin
    Key := 0;
    //PARA NAO FECHAR O FORM COM ESC...
  End
  Else
    inherited;

  If Key = VK_F10 Then
  Begin
    Key := 0; 
    btnConfAlteracoes.Click;
  End;  
end;

procedure TfrmCadCliEndEntrega.btnSairClick(Sender: TObject);
begin
  If blnDockPanel Then Exit;
  inherited;
end;

procedure TfrmCadCliEndEntrega.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If cdsConsulta.IsEmpty Then
  Begin
    recEndEnt.strIncrem := ''
  End Else
  Begin
    If fEmptyStr(recEndEnt.strIncrem) Then
      pRetornaEndereco;
  End;

  If blnDockPanel Then Action := caNone else inherited;
end;

procedure TfrmCadCliEndEntrega.cdsConsultaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cdsConsulta.FieldByName('ETC_TELENT').EditMask := fRetMascaraFonePais;
end;

procedure TfrmCadCliEndEntrega.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  pPreencherPnlInfo;

  With DataSet Do
  Begin
    strCepEntAnt := FieldByName('ETC_CEPENT').AsString;

    dbeCidEnt.ReadOnly := (FieldByName('ETC_ENDFAT').AsString = 'S');
    dbeCepEnt.ReadOnly := (FieldByName('ETC_ENDFAT').AsString = 'S');
    dbeEndEnt.ReadOnly := (FieldByName('ETC_ENDFAT').AsString = 'S');
    dbeBaiEnt.ReadOnly := (FieldByName('ETC_ENDFAT').AsString = 'S');
    dbeCodObr.ReadOnly := (FieldByName('ETC_ENDFAT').AsString = 'S');
    dbeCodArt.ReadOnly := (FieldByName('ETC_ENDFAT').AsString = 'S');
    dbeCodCno.ReadOnly := (FieldByName('ETC_ENDFAT').AsString = 'S');
    dbeInsImo.ReadOnly := (FieldByName('ETC_ENDFAT').AsString = 'S');
    dbeCodCib.ReadOnly := (FieldByName('ETC_ENDFAT').AsString = 'S');
    dbeConEnt.ReadOnly := (FieldByName('ETC_ENDFAT').AsString = 'S');
    dbeTelEnt.ReadOnly := (FieldByName('ETC_ENDFAT').AsString = 'S');
    rdgCobIss.Enabled  := (FieldByName('ETC_ENDFAT').AsString <> 'S');
    cmbTipFre.Enabled  := (FieldByName('ETC_ENDFAT').AsString = 'S');
    dbeRegEnt.ReadOnly := (FieldByName('ETC_ENDFAT').AsString = 'S');

    dbeCidEnt.TabStop := Not dbeCidEnt.ReadOnly;
    dbeCepEnt.TabStop := Not dbeCepEnt.ReadOnly;
    dbeEndEnt.TabStop := Not dbeEndEnt.ReadOnly;
    dbeBaiEnt.TabStop := Not dbeBaiEnt.ReadOnly;
    dbeCodObr.TabStop := Not dbeCodObr.ReadOnly;
    dbeCodArt.TabStop := Not dbeCodArt.ReadOnly;
    dbeCodCno.TabStop := Not dbeCodCno.ReadOnly;
    dbeInsImo.TabStop := Not dbeInsImo.ReadOnly;
    dbeCodCib.TabStop := Not dbeCodCib.ReadOnly;
    dbeConEnt.TabStop := Not dbeConEnt.ReadOnly;
    dbeTelEnt.TabStop := Not dbeTelEnt.ReadOnly;
    dbeRegEnt.TabStop := Not dbeRegEnt.ReadOnly;

    dbeNomCid.Text := fRetNomCidade(dbeCidEnt.Text);

    dbeCidEnt.Enabled := Not (DataSet.State = dsBrowse);
    dbeCepEnt.Enabled := Not (DataSet.State = dsBrowse);
    dbeEndEnt.Enabled := Not (DataSet.State = dsBrowse);
    cmbTipFre.Enabled := Not (DataSet.State = dsBrowse);
    dbeBaiEnt.Enabled := Not (DataSet.State = dsBrowse);
    dbeCodObr.Enabled := Not (DataSet.State = dsBrowse);
    dbeCodArt.Enabled := Not (DataSet.State = dsBrowse);
    dbeCodCno.Enabled := Not (DataSet.State = dsBrowse);
    dbeInsImo.Enabled := Not (DataSet.State = dsBrowse);
    dbeCodCib.Enabled := Not (DataSet.State = dsBrowse);
    dbeConEnt.Enabled := Not (DataSet.State = dsBrowse);
    dbeTelEnt.Enabled := Not (DataSet.State = dsBrowse);
    rdgCobIss.Enabled := Not (DataSet.State = dsBrowse) And rdgCobIss.Enabled;
    dbeRegEnt.Enabled := Not (DataSet.State = dsBrowse) And (Not fCfgSis('CEPREG', varBoolean));

    pnlOrdVis.Enabled := Not (DataSet.State In [dsInsert, dsEdit]);

    If DataSet.FieldByname('ETC_COBISS').AsString = 'T' Then
      rdgCobIss.ItemIndex := 0
    Else If DataSet.FieldByname('ETC_COBISS').AsString = 'S' Then
      rdgCobIss.ItemIndex := 1
    Else
      rdgCobIss.ItemIndex := 2;

    cmbTipFre.ItemIndex := cmbTipFre.Items.IndexOf(fDescricaoFrete(DataSet.FieldByname('ETC_TIPFRE').AsString));

    qryFacImg.Close;
    qryFacImg.ParamByName('SEQENT').AsString := DataSet.FieldByName('AUTOINCREM').AsString;
    qryFacImg.Open;

    edtLatLon.Text := FieldByName('ETC_LATLON').AsString;
  End;
end;

procedure TfrmCadCliEndEntrega.cdsConsultaCID_ESTADOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := fRetNomCidade(cdsConsultaETC_CIDENT.AsString, 1);
end;

procedure TfrmCadCliEndEntrega.cdsConsultaCID_NOMCIDGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := fRetNomCidade(cdsConsultaETC_CIDENT.AsString);
end;

procedure TfrmCadCliEndEntrega.cdsConsultaETC_TIPFREGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := fDescricaoFrete(cdsConsultaETC_TIPFRE.AsString);

  If (Text = 'Inválido') Then Text := '';
end;

procedure TfrmCadCliEndEntrega.cdsConsultaNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsConsulta.FieldByName('ETC_SITUAC').AsString := 'A';
end;

procedure TfrmCadCliEndEntrega.cdsConsultaReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  Raise Exception.Create(E.Message);
end;

procedure TfrmCadCliEndEntrega.cdsConsultaREG_DESREGGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := fRetNomRegiao(cdsConsultaETC_CODREG.AsString);
end;

procedure TfrmCadCliEndEntrega.cdsConsultaTRA_NOMTRAGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := fRetNomTransportadora(cdsConsultaETC_CODTRA.AsString);
end;

procedure TfrmCadCliEndEntrega.cdsConsultaTRA_NOMTRDGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if not fEmptyStr(cdsConsultaETC_TRARED.AsString) then
    Text := fRetNomTransportadora(cdsConsultaETC_TRARED.AsString);
end;

procedure TfrmCadCliEndEntrega.cmbTipFreChange(Sender: TObject);
begin
  inherited;

  recEndEnt.strTipFre := fTipoFrete(cmbTipFre.Text);

  If (cdsConsulta.State in [dsInsert,dsEdit]) Then
    cdsConsulta.FieldByName('ETC_TIPFRE').AsString := recEndEnt.strTipFre;
end;

procedure TfrmCadCliEndEntrega.pEscapePressed;
begin
  If Not blnDockPanel Then Inherited;
end;

procedure TfrmCadCliEndEntrega.pCancelaAlteracoes;
Begin
  With cdsConsulta Do
  If Active And (ChangeCount > 0) Then
    CancelUpdates;
End;

function TfrmCadCliEndEntrega.fPodeExcluirEndereco: Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Result:=True;

  If Not fEmptyStr(cdsConsulta.FieldByName('AUTOINCREM').AsString) Then
  Begin
    qryGen := fCriaQuery(Self);
    Try
      With qryGen, SQL Do
      Begin
        Clear;
        Add('SELECT AUX_ENTGER FROM AUXMOV ');
        Add('WHERE AUX_ENTGER = :ENTGER ');
        Add('UNION ');
        Add('SELECT AUX_ENTGER FROM AUXNOT');
        Add('WHERE AUX_ENTGER = :ENTGER ');
        Add('UNION ');
        Add('SELECT AUX_ENTGER FROM AUXGOR');
        Add('WHERE AUX_ENTGER = :ENTGER ');

        ParamByName('ENTGER').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
        Open;

        Result := IsEmpty;

        Close;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  End;
End;

procedure TfrmCadCliEndEntrega.btnExcluirClick(Sender: TObject);
begin
  If fTemAcesso Then
  Begin
    If cdsConsultaETC_ENDFAT.AsString = 'S' Then
    Begin
      pMensagemOk('Endereço padrão de entrega não pode ser excluido!');
      Exit;
    End;
    
    If fPodeExcluirEndereco Then
      inherited
    Else
      pMensagemOk('Há vendas/orçamentos para esse endereço de entrega!');
  End;
end;

Function TfrmCadCliEndEntrega.fTemAcesso: Boolean;
Begin
  Result := (Not blnSomenteSelecao) Or blnLiberou Or fTemPermissaoAlterarEndereco;

  blnLiberou := Result;
End;

function TfrmCadCliEndEntrega.fTemPermissaoAlterarEndereco: Boolean;
var
  strCodOpe: String;
begin
  Result := False;

  if (not ffrmSenha(strSenha)) then
    Exit;

  strCodOpe := fRetCodVendedor(strSenha);

  if fEmptyStr(strCodOpe) then
  begin
    pMensagemOk('Operador não encontrado!');
    Exit;
  end;

  if (not fVerificaAcessoSistema('ENENC', strCodOpe)) then
  begin
    pMensagemOk('Operador não tem direito de acesso para alterar o endereço de entrega!');
    Exit;
  end;

  Result := True;
end;

procedure TfrmCadCliEndEntrega.btnIncluirClick(Sender: TObject);
Var
  intSeqVis : Integer;
  intSeqInd : Integer;
begin
  If fTemAcesso Then
  Begin
    If fClienteConsumidor(fRetNomCliente(recEndEnt.strCodCli), True) Then
    Begin
      pMensagemOk('Não é permitido incluir novos endereços para este cliente!');
      Exit;
    End;
    pCloneDataSet(cdsClone, cdsConsulta);

    intSeqVis := fRetProxSeqVis;
    intSeqInd := fRetProxSeqInd;

    inherited;
    If (cdsConsulta.State in [dsInsert]) Then
    Begin
      rdgCobIss.ItemIndex := 2; //cadastro do cliente
      cdsConsulta.FieldByName('ETC_SEQVIS').AsInteger := intSeqVis;
      cdsConsulta.FieldByName('ETC_SEQIND').AsInteger := intSeqInd;
      cdsConsulta.FieldByName('ETC_TIPFRE').AsString := '';
    End;
  End;
end;

procedure TfrmCadCliEndEntrega.btnOrdCimaClick(Sender: TObject);
begin
  inherited;
  pAtualizarSeqVis(True);
end;

procedure TfrmCadCliEndEntrega.btnOrdBaixoClick(Sender: TObject);
begin
  inherited;
  pAtualizarSeqVis(False);
end;

procedure TfrmCadCliEndEntrega.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
  If (dbeCepEnt.Focused) Then
  Begin
    Case Msg.Message Of
      WM_KEYDOWN:
      Begin
        If (Msg.wParam = VK_TAB) Then
          Msg.wParam :=  VK_RETURN
      End;
    End;
  End;

end;

procedure TfrmCadCliEndEntrega.btnAlterarClick(Sender: TObject);
begin
  If fTemAcesso Then
  Begin
    pCloneDataSet(cdsClone, cdsConsulta);
    inherited;
  End;
  cdsConsultaAfterScroll(cdsConsulta);
end;

function TfrmCadCliEndEntrega.fRetornarCodRegiao(strCEP: String): String;
Var
  qryAux : TUniQuery;
begin
  Result := '';
  Try
    qryAux := fCriaQuery;
    qryAux.SQL.Text :=
      'SELECT VIN_CODREG '+
      '  FROM VINREG '+
      ' WHERE VIN_C_E_P_ = :C_E_P_';
    qryAux.Close;
    qryAux.ParamByName('C_E_P_').AsString := strCEP;
    qryAux.Open;

    Result := qryAux.fieldByName('VIN_CODREG').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmCadCliEndEntrega.fRetProxSeqInd: Integer;
var
  cdsTemp: TUniClientDataSet;
  intSeqCds: Integer;
  intSeqDB: Integer;
begin
  cdsTemp := TUniClientDataSet.Create(Self);
  cdsTemp.Data := cdsConsulta.Data;
  cdsTemp.IndexFieldNames := 'ETC_SEQIND';
  cdsTemp.Last;
  intSeqCds := cdsTemp.FieldByName('ETC_SEQIND').AsInteger + 1;
  FreeAndNil(cdsTemp);

  intSeqDB  := fRetSeqIndEndereco(recEndEnt.strCodCli, 'ETC_SEQIND');

  Result := Max(intSeqCds, intSeqDB);
end;

function TfrmCadCliEndEntrega.fRetProxSeqVis: Integer;
var
  cdsTemp: TUniClientDataSet;
  intSeqCds: Integer;
  intSeqDB: Integer;
begin
  cdsTemp := TUniClientDataSet.Create(Self);
  cdsTemp.Data := cdsConsulta.Data;
  cdsTemp.IndexFieldNames := 'ETC_SEQVIS';
  cdsTemp.Last;
  intSeqCds := cdsTemp.FieldByName('ETC_SEQVIS').AsInteger + 1;
  FreeAndNil(cdsTemp);

  intSeqDB := fRetSeqIndEndereco(recEndEnt.strCodCli, 'ETC_SEQVIS');

  Result := Max(intSeqCds, intSeqDB);
end;

function TfrmCadCliEndEntrega.fVerificaPossuiEnderecoAtivo: Boolean;
{ ****************************************************************** }
{ ** VERIFICA SE HÁ OUTRO ENDEREÇO DE ENTREGA ATIVO PARA O CLIENTE** }
{ ****************************************************************KM }
Begin
  cdsClone.Open;
  cdsClone.Filtered := False;
  cdsClone.Filter   := 'ETC_SITUAC = '  + QuotedStr('A') +
                       ' AND AUTOINCREM <> ' + QuotedStr(cdsConsulta.FieldByName('AUTOINCREM').asString);
  cdsClone.Filtered := True;

  Result := (not cdsClone.IsEmpty);
End;

function TfrmCadCliEndEntrega.fValidaBairro: Boolean;
begin
  Result := True;

  If (Not blnOrigemCadCli) Then
    Exit;

  If (dbeBaiEnt.ReadOnly) Then
    Exit;

  If (fValidaDireitoDeAcessoAltBairro(recEndEnt.strCodCli, recEndEnt.strNomCli, dbeCepEnt.Text, dbeBaiEnt.Text, strBaiEntLib)) Then
    Exit;

  Result := False;
end;

procedure TfrmCadCliEndEntrega.pSetaDadosClienteNovo(
  const ANovoClienteComCnpj: Boolean; const ACNPJCadastroPrincipal,
  AUFCadastroPrincipal: String);
begin
  blnNovoClienteComCNPJ := ANovoClienteComCnpj;
  strCNPJCadastroPrincipal := ACNPJCadastroPrincipal;
  strUFCadastroPrincipal := AUFCadastroPrincipal;
end;

end.
