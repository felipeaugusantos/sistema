unit untCadProspectos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls,
  frxClass, Uni, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  StrUtils, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, ComboBoxFocus,
  untHelperCitel, EditFocus, QColorLabel, Vcl.Mask, Vcl.DBCtrls, DBEditFocus,
  DBMemoFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, untZClient, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDBData, Vcl.Graphics, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView,   cxGridCitel, cxClasses, cxGridLevel,
  cxGrid, cxProgressBar, cxCustomData,
  cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.OleCtrls, SHDocVw,
  untConsultaEndereco, Navegador.Classes.TNavegador, Navegador.View.Help;

type
  TRegLogCat = record
    CodCatAnt: String;
    CodCatAtu: String;
    GravarLog: Boolean;
    StaProAnt: String;
    StaProAtu: String;
  End;

  TfrmCadProspectos = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    btnCadCli: TBitBtnLocked;
    pnlGeral: TPanel;
    Label1: TLabel;
    Label37: TLabel;
    ColorLabel1: TColorLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label5: TLabel;
    Label189: TLabel;
    Label190: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    Label62: TLabel;
    Label11: TLabel;
    Label60: TLabel;
    Label10: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label14: TLabel;
    Label18: TLabel;
    Label16: TLabel;
    Label20: TLabel;
    lbl7: TLabel;
    Label24: TLabel;
    Label23: TLabel;
    Label200: TLabel;
    Label192: TLabel;
    Label25: TLabel;
    Label40: TLabel;
    lblAtivo1: TLabel;
    lblAtivo2: TLabel;
    lblAtivo3: TLabel;
    Label36: TLabel;
    dbeCodPro: TDBEditFocus;
    dbeStatus: TDBEditFocus;
    dbeDtaCad: TDBEditFocus;
    dbeNomCli: TDBEditFocus;
    dbeFanSob: TDBEditFocus;
    dbeCodCid: TDBEditFocus;
    edtNomCid: TEditFocus;
    edtEstado: TEditFocus;
    dbeNumCep: TDBEditFocus;
    dbeEndere: TDBEditFocus;
    dbeEndNum: TDBEditFocus;
    dbeEndCom: TDBEditFocus;
    dbeBairro: TDBEditFocus;
    dbeCgcCpf: TDBEditFocus;
    dbeNuCnpj: TDBEditFocus;
    edtEstEmiCpf: TEditFocus;
    dbeNumRg: TDBEditFocus;
    edtRgExp: TEditFocus;
    cbxRgEst: TComboBoxFocus;
    dbeNumIes: TDBEditFocus;
    dbeDtaNas: TDBEditFocus;
    dbeCaiPos: TDBEditFocus;
    dbeFone01: TDBEditFocus;
    dbeNumFax: TDBEditFocus;
    dbeFone02: TDBEditFocus;
    dbeNumCel: TDBEditFocus;
    dbeNEXTEL: TDBEditFocus;
    dbeEmail: TDBEditFocus;
    dbeContat: TDBEditFocus;
    dbeEmailNFe: TDBEditFocus;
    dbeEmailNfe2: TDBEditFocus;
    dbeHomPag: TDBEditFocus;
    dbeCodAti: TDBEditFocus;
    edtAtividade: TEditFocus;
    dbeCodVen: TDBEditFocus;
    edtVendedor: TEditFocus;
    tbsIntVen: TTabSheet;
    Label47: TLabel;
    dbeObserv: TDBMemoFocus;
    Label13: TLabel;
    dbeCodRed: TDBEditFocus;
    edtDesRed: TEditFocus;
    Label15: TLabel;
    dbeCrmFre: TDBEditFocus;
    edtDesFre: TEditFocus;
    Label17: TLabel;
    dbeCrmPor: TDBEditFocus;
    edtDesPor: TEditFocus;
    Label19: TLabel;
    dbeCrmFai: TDBEditFocus;
    edtDesFai: TEditFocus;
    cxgProForLevel: TcxGridLevel;
    cxgProForTableView: TcxGridDBTableViewCitel;
    cxgProFor: TcxGridCitel;
    Panel1: TPanel;
    Label26: TLabel;
    edtCrmFor: TEditFocus;
    edtDesFor: TEditFocus;
    btnAddCrmFor: TBitBtnLocked;
    Label27: TLabel;
    cxgProForTableViewColumn1: TcxGridDBColumn;
    cxgProForTableViewColumn2: TcxGridDBColumn;
    lblCategoria: TLabel;
    dbeCrmCat: TDBEditFocus;
    edtDesCat: TEditFocus;
    btnImportarCadastrosProspecto: TBitBtnLocked;
    tsConsultaEndereco: TTabSheet;
    pnlConsultaEndereco: TPanel;
    btnConsultarEndereco: TBitBtnLocked;
    btnVincularProspCli: TBitBtnLocked;
    cbStatusProspe: TComboBoxFocus;
    lblStatusProspe: TLabel;
    Label38: TLabel;
    dbeCodRep: TDBEditFocus;
    edtNomRep: TEditFocus;
    lblRegiao: TLabel;
    dbeCodReg: TDBEditFocus;
    edtDesReg: TEditFocus;
    pnlCanalAcesso: TPanel;
    lblCanalAcesso: TLabel;
    dbeCodCac: TDBEditFocus;
    edtDesCadCac: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure dbeNumCepKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCgcCpfExit(Sender: TObject);
    procedure dbeNuCnpjExit(Sender: TObject);
    procedure edtRgExpKeyPress(Sender: TObject; var Key: Char);
    procedure dbeObservKeyPress(Sender: TObject; var Key: Char);
    function dbeCodAtiChamaCadastro(Key: Word): String;
    function dbeCodCidChamaCadastro(Key: Word): string;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCadCliClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbeCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCrmFreKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCrmPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCrmForKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddCrmForClick(Sender: TObject);
    procedure cxgProForTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeCrmFaiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCrmCatKeyPress(Sender: TObject; var Key: Char);
    procedure btnImportarCadastrosProspectoClick(Sender: TObject);
    procedure btnConsultarEnderecoClick(Sender: TObject);
    procedure btnVincularProspCliClick(Sender: TObject);
    procedure dbeCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCacKeyPress(Sender: TObject; var Key: Char);
  private
    cdsProFor : TZClient;

    strCepAnt : String;
    blnValidaCadCli : Boolean;
    blnContemRedColor : Boolean;
    strMsgValidacao : String;
    objRegLogCat: TRegLogCat;

    {VARIAVEIS CRM}
    blnUtilizarCrm: Boolean;
    strCliCRM     : String;
    strCampoCRM   : String;
    strRegraCRM   : String;
    strDesCamCRM  : String;

    ObjConsulta  : TConsultaEndereco;
    objNavegador : TNavegador;
    qryConOpe: TUniQuery;
    strCodRepAnt: String;
    strRepInc    : String;

    FCliNavegador : TfrmNavegadorViewHelp;

    procedure pLimpaCampos;
    procedure pSetMascaras;
    procedure pCarregaDados;
    procedure pRemoveCorCamposComErro;
    procedure pAfterOpenTabela(DataSet : TDataSet);

    function fSQLProFor : String;
    function fGravaFornecedorProgresso(cxProgressBar : TcxProgressBar):Boolean;
    function fGravaFornecedor : Boolean;
    procedure pAplicarRegrasCrm;
    procedure pProcuraCampoClienteCRM;
    procedure pBuscaProspecto(strCodPro: String);
    procedure pVincularProspectoCliente;
    procedure pCarregarCompoStatusPro;
    procedure pCarregaRepr_Vend(strCodigo: String; edtDescricao: TEditFocus);
    procedure pCarregaRegiao;
    procedure pCriaCadCliNavegador;

    Const strPermiCadCid = 'frmCadCidades';
  public
    strCodIniciarCadastro: String;

    procedure pSetaParametrosCRM(strNomCampoCRM, strCodCliCRM, strNomRegraCRM, strDesCampoCRM: String);
    class function fAlteraCadProspecto(const strCodProLocal: String): String;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean;override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCadCidades, untCadCid, untFuncoesGenerica,
  untTypesSistema, untConsultas, untFuncIns, untFuncIns2, untCadClientes,
  untGravando, DateUtils, ImportacaoDados.Interfaces, ImportacaoDados.View.ImportarArquivo,
  untPesqAux, ImportacaoDados.Controller.Prospecto, untCrmSelCliente, untTypesCRM,
  untFuncoesOcorrenciasCRM, untLiberacao,untAtualizaOcorrenciasCRM;

{ TfrmCadProspectos }

procedure TfrmCadProspectos.dbeCodAtiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrAtiv: TConsultasArray;
Begin
  inherited;
  { ******************************* }
  { * NOVA CONSULTA DE ATIVIDADES * }
  { ****************************RV* }
  If fPesqAtividade(Self, dbeCodAti, edtAtividade, Nil, Key, arrAtiv) Then
  Begin
    if fValidaCampos(dbeCodAti, True) then
      SelectNext(ActiveControl, True, True);
  End;
End;

procedure TfrmCadProspectos.dbeCodCidKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  { **************************** }
  { * NOVA CONSULTA DE CIDADES * }
  { *************************RV* }
  If fPesqCidade(Self, dbeCodCid, edtNomCid, edtEstado, Nil, Key,
    arrCidade) Then
  Begin
    If fValidaCampos(dbeCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadProspectos.dbeCodRedKeyPress(Sender: TObject; var Key: Char);
  Var
    arrRed: TConsultasArray;
begin
  inherited;
  if fPesqRedeLojas(Self, dbeCodRed, edtDesRed, nil, Key, arrRed) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadProspectos.dbeCodRegKeyPress(Sender: TObject; var Key: Char);
Var
  arrRegiao : TConsultasArray;
begin
  inherited;

  If fPesqRegiao(Self, dbeCodReg, edtDesReg, Nil, Key, arrRegiao) Then
  Begin
    if fValidaCampos(dbeCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProspectos.dbeCodRepKeyPress(Sender: TObject; var Key: Char);
Var
  arrRep: TConsultasArray;
begin
  inherited;

  if fPesqOperador(Self, dbeCodRep, nil, qryConOpe, Key, arrRep) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProspectos.dbeCodVenKeyPress(Sender: TObject; var Key: Char);
  Var
    arrVen: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, dbeCodVen, edtVendedor, nil, Key, arrVen) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProspectos.dbeCrmCatKeyPress(Sender: TObject; var Key: Char);
Var
  arrFre: TConsultasArray;
begin
  inherited;
  if fPesqCategoriaCRM(Self, dbeCrmCat, edtDesCat, nil, Key, arrFre) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProspectos.dbeCrmFaiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFai: TConsultasArray;
begin
  inherited;
  If fPesqFaixaFaturamentoCRM(Self, dbeCrmFai, edtDesFai, Nil, Key, arrFai) Then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProspectos.dbeCrmFreKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFre: TConsultasArray;
begin
  inherited;
  if fPesqFrequenciaCRM(Self, dbeCrmFre, edtDesFre, nil, Key, arrFre) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProspectos.dbeCrmPorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFre: TConsultasArray;
begin
  inherited;
  if fPesqPorteCRM(Self, dbeCrmPor, edtDesPor, nil, Key, arrFre) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProspectos.dbeNuCnpjExit(Sender: TObject);
begin
  inherited;
  edtEstEmiCpf.Text := fCpfToEstadoEmissao(dbeCgcCpf.Text, dbeNuCnpj.Text);
end;

procedure TfrmCadProspectos.dbeNumCepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Key := #0;
    dbeNumCep.Text := fConsultarCep(Self, dbeNumCep.Text, dbeNumCep);
  End;
end;

procedure TfrmCadProspectos.dbeObservKeyPress(Sender: TObject; var Key: Char);
  Var
    strKey: String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key := strKey[1];
end;

procedure TfrmCadProspectos.edtCrmForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFor: TConsultasArray;
begin
  inherited;
  if fPesqFornecedorAtualCRM(Self, edtCrmFor, edtDesFor, nil, Key, arrFor) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProspectos.edtRgExpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Not CharInSet(Key, ['a' .. 'z', 'A' .. 'Z', '0' .. '9', #8]) Then
    Key := #0;
end;

function TfrmCadProspectos.fGravaFornecedor: Boolean;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravaFornecedorProgresso;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

function TfrmCadProspectos.fGravaFornecedorProgresso(cxProgressBar: TcxProgressBar): Boolean;
  Var
    qryInsert : TUniQuery;
begin
  Try
    Result := True;
    cdsProFor.DisableControls;
    cdsProFor.First;

    qryInsert := fCriaQuery;
    With qryInsert, SQL Do
    Begin
      Close;
      Clear;
      Add('DELETE FROM PROFOR WHERE PRF_CODPRO = :CODPRO');
      ParamByName('CODPRO').AsString := qryTabela.FieldByName('PRO_CODPRO').AsString;
      Try
        ExecSQL;
      Except
        On E : Exception Do
        Begin
          pMensagensErro(E.Message, 'TfrmCadProspectos.fGravaFornecedorProgresso');
          Result := False;
          Exit;
        End;
      End;

      cxProgressBar.pSetMax(cdsProFor.RecordCount);

      Close;
      Clear;
      Add(' INSERT INTO PROFOR (PRF_CODPRO, PRF_CRMFOR) ');
      Add('             VALUES (:CODPRO, :CRMFOR)       ');

      ParamByName('CODPRO').AsString := qryTabela.FieldByName('PRO_CODPRO').AsString;

      While Not cdsProFor.Eof Do
      Begin
        ParamByName('CRMFOR').AsString := cdsProFor.FieldByName('PRF_CRMFOR').AsString;

        Try
          ExecSQL;
        Except
          On E : Exception Do
          Begin
            pMensagensErro(E.Message, 'TfrmCadProspectos.fGravaFornecedorProgresso');
            Result := False;
            Exit;
          End;
        End;

        cdsProFor.Next;

        cxProgressBar.pStep;
        Application.ProcessMessages;
      End;

    End;

  Finally
    cdsProFor.EnableControls;
    FreeAndNil(qryInsert);
  End;

end;

procedure TfrmCadProspectos.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'PROSPE';
  strNomeCampo      := 'PRO_CODPRO';
  qryTabela         := fCriarQuery(' SELECT * FROM PROSPE', Self);
  dtsTabela.DataSet := qryTabela;
  blnValidaCadCli   := False;
  blnContemRedColor := False;
  intPaginasAtivas  := pgcDados.PageCount;

  blnUtilizarCrm := False;
  strCliCRM      := '';
  strCampoCRM    := '';
  strRegraCRM    := '';
  strDesCamCRM   := '';

  cdsProFor := TZClient.Create(Self, fSQLProFor);
  cxgProForTableView.DataController.DataSource := cdsProFor.dtsSource;

  pSetMascaras;

  ObjConsulta := TConsultaEndereco.Create(Self);
  ObjConsulta.PanelExibicao := pnlConsultaEndereco;

  pCarregarCompoStatusPro;

  strCodIniciarCadastro := EmptyStr;
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);

  objNavegador := TNavegador.New;
  objNavegador.setParent(pnlConsultaEndereco);

  pnlCanalAcesso.Visible := fCfgSis('SOLCAP', varBoolean);
  pCarregarCompoStatusPro;
  SendMessage(cbStatusProspe.Handle, CB_SETDROPPEDWIDTH, 650, 0);
end;

procedure TfrmCadProspectos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsProFor);
  FreeAndNil(ObjConsulta);
  FreeAndNil(qryConOpe);
  FreeAndNil(objNavegador);

  inherited;
end;

procedure TfrmCadProspectos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F4: btnCadCli.Click;
    VK_F5: btnVincularProspCli.Click;
  End;
end;

procedure TfrmCadProspectos.FormShow(Sender: TObject);
begin
  inherited;
  pgcDados.TabIndex := 0;

  If blnUtilizarCrm Then
    pAplicarRegrasCrm;

  tsConsultaEndereco.TabVisible := False;

  If Not fEmptyStr(strCodIniciarCadastro) Then
  Begin
    pBuscaProspecto(strCodIniciarCadastro);
  End;

end;

function TfrmCadProspectos.fSQLProFor: String;
begin
  Result := '';
  Result := Result + ' SELECT PRF_CODPRO,                           ';
  Result := Result + '        PRF_CRMFOR,                           ';
  Result := Result + '        CRF_NOMFOR                            ';
  Result := Result + ' FROM PROFOR                                  ';
  Result := Result + ' INNER JOIN CRMFOR ON CRF_CODIGO = PRF_CRMFOR ';
  Result := Result + ' WHERE PRF_CODPRO = :CODPRO                   ';
end;

function TfrmCadProspectos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    objDadosNFe  : TValidacaoDadosNFe;
    strCodCid    : String;
    strEndere    : String;
    strBairro    : String;
    strNomCid    : String;
    strEstado    : String;
    strCodCliC   : String;
    blnAtualizar : Boolean;

    LCodigoCorreio: String;
    objLiberacao  : TLiberacao;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  blnAtualizar := False;

  If Result Then
  Begin
    If (Sender = dbeStatus) Then
    Begin
      If fEmptyStr(dbeStatus.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Situação do Cliente deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If (dbeStatus.Text <> 'A') And (dbeStatus.Text <> 'I') Then
        Result := False

    End

    Else If (Sender = dbeNomCli) Then
    Begin
      If fEmptyStr(dbeNomCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome do Cliente deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = dbeCodCid) Then
    Begin
      If fEmptyStr(dbeCodCid.Text)Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Cidade deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtNomCid.Text := fRetNomCidadeSemOpc(dbeCodCid.Text);
        edtEstado.Text := fRetNomCidade(dbeCodCid.Text,1);
        If fEmptyStr(edtNomCid.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeNumCep) Then
    Begin

      If (Length(Trim(fTiraCaracEspeciais(dbeNumCep.Text))) < 8) And blnValidaCadCli Then
      Begin
        strMsgValidacao := strMsgValidacao + 'O Cep deve conter 8 digitos.' + #13;
        Result := False;
      End;

      If (Length(Trim(fTiraCaracEspeciais(dbeNumCep.Text))) = 8) And (fCfgSis('USACEP', varBoolean)) And (edtEstado.Text <> 'EX') Then
      Begin

        If (Not fCadCepDadosCep(dbeNumCep.Text, strCodCid, strEndere, strBairro, strNomCid, strEstado, LCodigoCorreio,
                                                '' {qryConCid.FieldByName('CID_ESTADO').AsString},
                                                '' {qryConCid.FieldByName('CID_CODCOR').AsString})) Then
        Begin
          Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
        End
        Else
        Begin

          If (fEmptyStr(strCodCid)) Then
          Begin

            If Not fVerificaAcessoSistema(strPermiCadCid) Then
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
          End;

          If (Result) Then
          Begin

            blnAtualizar := False;
            If fTiraCaracEspeciais(strCepAnt) <> fTiraCaracEspeciais(dbeNumCep.Text) Then
            Begin

              If fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1 Then
              Begin
                blnAtualizar := True;
              End

            End;

            If qryTabela.State In dsEditModes Then
            Begin
              If fEmptyStr(dbeCodCid.Text) Or ((blnAtualizar) And (Not fEmptyStr(strCodCid))) Then
              Begin
                dbeCodCid.Field.AsString := strCodCid;
                edtNomCid.Text := fRetNomCidade(dbeCodCid.Text);
                edtEstado.Text := fRetNomCidade(dbeCodCid.Text, 1);
              End;

              If fEmptyStr(dbeEndere.Text) Or (blnAtualizar) Then
                dbeEndere.Field.AsString := strEndere;

              If fEmptyStr(dbeBairro.Text) Or (blnAtualizar) Then
                dbeBairro.Field.AsString := strBairro;

              {***********************************}
              {* CASO O CEP NÃO POSSUIR ENDERECO *}
              {********************************JB*}
              If (Not fEmptyStr(strNomCid)) And (fEmptyStr(dbeEndere.Field.AsString)) Then
              Begin
                If qryTabela.State In dsEditModes Then
                  dbeEndere.Field.AsString := fTiraCaracEspeciais(strNomCid);
                strEndere                := dbeEndere.Field.AsString;
              End;
            End;

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
            pSetFocus(dbeEndNum);
            blnMudarFoco := False;
          End;
        End;

      End;

    End

    Else If (Sender = dbeDtaNas) Then
    Begin

      If (fEmptyStr(fTiraCaracEspeciais(dbeDtaNas.Text))) And blnValidaCadCli Then
      Begin

        If (Not fEmptyStr(dbeNuCnpj.Text)) Then
        Begin
          If (fCfgSis('DTANSC', varBoolean)) And (Length(fTiraCaracEspeciais(dbeNuCnpj.Text)) = 11) Then
          Begin
            strMsgValidacao := strMsgValidacao + 'A Data de Nascimento deve ser informada quando for Pessoa Física!' + #13;
            Result := False;
          End;


          If (fCfgSis('DTAFND', varBoolean)) And (Length(fTiraCaracEspeciais(dbeNuCnpj.Text)) = 14) Then
          Begin
            strMsgValidacao := strMsgValidacao + 'A Data de Fundação deve ser informada quando for Pessoa Jurídica!' + #13;
            Result := False;
          End;
        End;

      End;

      If Result Then
      Begin

        If (fEmptyStr(fTiraCaracEspeciais(dbeDtaNas.Text))) Then
        Begin
          If qryTabela.State in DsEditModes Then
            dbeDtaNas.Field.Value := Null;
        End;

      End;

    End

    Else If (Sender = dbeCgcCpf) Then
    Begin
      If blnValidaCadCli Then
      Begin
        If (fEmptyStr(dbeCgcCpf.Text)) Or (dbeCgcCpf.Text = '0') Then
        Begin
          strMsgValidacao := strMsgValidacao + 'O CNPJ / CPF deve ser preenchido!' + #13;
          Result := False;
        End
        Else
        Begin
          If (dbeCgcCpf.Text <> '1') And (dbeCgcCpf.Text <> '2') Then
            Result := False;
        End;
      End;
    End

    Else If (Sender = dbeNuCnpj) Then
    Begin
      If fEmptyStr(dbeNuCnpj.Text) Then
      Begin
        If blnValidaCadCli Then
        Begin
          strMsgValidacao := strMsgValidacao + 'O CNPJ / CPF deve ser preenchido!' + #13;
          Result := False;
        End;
      End
      Else
      Begin
        Result := fValidaCampos(dbeCgcCpf, True);
        If (Result) Then
          Result := fValidaCnpjCpf(dbeCgcCpf.Text, dbeNuCnpj.Text, False, True);

        If (Result) Then
        Begin
          strCodCliC := fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_C_G_C_'], [dbeNuCnpj.Text] );
          If (Not fEmptyStr(strCodCliC)) Then
          Begin
            Result := False;
            fMensagem('','Já existe um registro no cadastro de clientes com o CPF/CNPJ ' + dbeNuCnpj.Text + ' com o código ' + strCodCliC + '!', ['&OK']);
          End;

          If (Result) Then
          Begin
            strCodCliC := fCampoTabela('PRO_CODPRO', 'PROSPE', ['PRO_C_G_C_', 'PRO_CODPRO <> '], [dbeNuCnpj.Text, dbeCodPro.Text] );
            If (Not fEmptyStr(strCodCliC)) Then
            Begin
              Result := False;
              fMensagem('','Já existe um registro no cadastro de prospectos com o CPF/CNPJ ' + dbeNuCnpj.Text + ' com o código ' + strCodCliC + '!', ['&OK']);
            End;
          End;

        End;

        If Not Result Then
          Sender := dbeCgcCpf;

      End;
    End

    Else If (Sender = dbeEndere) Then
    Begin
      If fEmptyStr(dbeEndere.Text) Then
      Begin
        If blnValidaCadCli Then
        Begin
          strMsgValidacao := strMsgValidacao + 'O Endereço do Cliente deve ser preenchido!' + #13;
          Result := False;
        End;
      End
      Else
      Begin
        objDadosNFe := TValidacaoDadosNFe.Create(nil);
        objDadosNFe.strEndere := dbeEndere.Text;
        objDadosNFe.strEspDoc := 'NF';
        objDadosNFe.ovOrigem  := ovCadCli;
        objDadosNFe.blnCliCons := False;
        objDadosNFe.blnSomenteItensRetira := False;

        Result := fValidaDadosClienteNFe(objDadosNFe);

        FreeAndNil(objDadosNFe);
      End;
    End

    Else If (Sender = dbeEndNum) Then
    Begin
      If fEmptyStr(dbeEndNum.Text) And blnValidaCadCli Then
      Begin
        strMsgValidacao := strMsgValidacao + 'Digite o número do endereço!' + #13;
        Result := False
      End;
    End

    Else If (Sender = dbeBairro) Then
    Begin
      If fEmptyStr(dbeBairro.Text) Then
      Begin
        If blnValidaCadCli Then
        Begin
          strMsgValidacao := strMsgValidacao + 'Informe o bairro do cliente!' + #13;
          Result := False;
        End;
      End
      Else
      Begin
        objDadosNFe := TValidacaoDadosNFe.Create(nil);
        objDadosNFe.strBairro := dbeBairro.Text;
        objDadosNFe.strEspDoc := 'NF';
        objDadosNFe.ovOrigem  := ovCadCli;
        objDadosNFe.blnCliCons := False;
        objDadosNFe.blnSomenteItensRetira := False;

        Result := fValidaDadosClienteNFe(objDadosNFe);

        FreeAndNil(objDadosNFe);
      End;
    End

    Else
    If (Sender = edtRgExp) And edtRgExp.Enabled Then
    Begin
      cbxRgEst.Enabled := True;
      If (fEmptyStr(edtRgExp.Text)) Then
      Begin
        cbxRgEst.Enabled := False;
        cbxRgEst.ItemIndex := -1;
      End;
    End

    Else
    If (Sender = dbeNumIes) Then
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

    Else
    If (Sender = dbeFone01) Or (Sender = dbeFone02) Or
       (Sender = dbeNumFax) Or (Sender = dbeNumCel)  Then
    Begin
      If (Sender = dbeFone01) And
         (fEmptyStr(dbeFone01.Text)) Then
      Begin
        fMensagem('','Informe o Telefone 1!', ['&Ok']);
        Result := False;
      End;

      If (Not fEmptyStr(TDBEditFocus(Sender).Text)) And
         (Not fValidaTelefone(TDBEditFocus(Sender).Text)) Then
      Begin
        fMensagem('','Informe o telefone corretamente!', ['&Ok']);
        Result := False;
      End
      Else
        TDBEditFocus(Sender).Text := fAcertaMaskTel(TDBEditFocus(Sender).Text);
    End

    Else If (Sender = dbeEmail) Then
    Begin
      If blnValidaCadCli Then
      Begin
        Result := fEmailValido(dbeEmail.Text, False, 'E-Mail - 1', False, False);
        If Not Result Then
          strMsgValidacao := strMsgValidacao + 'Informe o E-mail - 1 corretamente!' + #13;
      End
      Else
        Result := fEmailValido(dbeEmail.Text, True, 'E-Mail - 1', False, False);
    End

    Else
    If (Sender = dbeEmailNFe) Then
    Begin
      If blnValidaCadCli Then
      Begin
        Result := fEmailValido(dbeEmailNFe.Text, False);
        If Result Then
        Begin
          objDadosNFe := TValidacaoDadosNFe.Create(nil);
          objDadosNFe.strEmaNfe   := dbeEmailNFe.Text;
          objDadosNFe.tcTipoCampo := tcEmail1;
          objDadosNFe.strEspDoc   := 'NF';
          objDadosNFe.ovOrigem    := ovCadCli;
          objDadosNFe.blnCliCons  := False;
          objDadosNFe.blnSomenteItensRetira := False;

          Result := fValidaDadosClienteNFe(objDadosNFe);

          FreeAndNil(objDadosNFe);
        End
        Else
          strMsgValidacao := strMsgValidacao + 'Informe o E-mail NF-e para envio da NFe corretamente!' + #13;
      End
      Else
        Result := fEmailValido(dbeEmailNFe.Text, True);
    End

    Else If (Sender = dbeEmailNfe2) And blnValidaCadCli Then
    Begin
      Result := fEmailValido(dbeEmailNfe2.Text, False, 'E-mail 2', True);
      If Result And (Not fEmptyStr(dbeEmailNfe2.Text)) Then
      Begin
        objDadosNFe := TValidacaoDadosNFe.Create(nil);
        objDadosNFe.strEmaNfe   := dbeEmailNfe2.Text;
        objDadosNFe.tcTipoCampo := tcEmail2;
        objDadosNFe.strEspDoc   := 'NF';
        objDadosNFe.ovOrigem    := ovCadCli;
        objDadosNFe.blnCliCons  := False;
        objDadosNFe.blnSomenteItensRetira := False;

        Result := fValidaDadosClienteNFe(objDadosNFe);

        FreeAndNil(objDadosNFe);
      End
      Else
      If (Not fEmptyStr(dbeEmailNfe2.Text)) Then
        strMsgValidacao := strMsgValidacao + 'Informe o E-mail NF-e 2 para envio da NFe corretamente!' + #13;
    End

    Else
    If (Sender = dbeCodAti) Then
    Begin
      If Not fEmptyStr(dbeCodAti.Text) Then
      Begin
        edtAtividade.Text := fRetNomAtividade(dbeCodAti.Text);
        If fEmptyStr(edtAtividade.Text) Then
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

    Else
    If (Sender = dbeCodVen) Then
    Begin

      If Not fEmptyStr(dbeCodVen.Text) Then
      Begin
        edtVendedor.Text := fRetNomVendRep(dbeCodVen.Text);
        If fEmptyStr(edtVendedor.Text) Then
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

    Else
    If (Sender = dbeCodRed) Then
    Begin
      if Not fEmptyStr(dbeCodRed.Text) Then
      Begin
        edtDesRed.Text := fRetNomeRedeLojaSelect(dbeCodRed.Text);
        If fEmptyStr(edtDesRed.Text) Then
        Begin
          Result := False;
          fMensagem('', 'O Código da Rede de Lojas digitado não existe!', ['&OK']);
        End;
      End
      Else
        edtDesRed.Clear;
    End

    Else
    If (Sender = dbeCrmFre) Then
    Begin
      if Not fEmptyStr(dbeCrmFre.Text) Then
      Begin
        edtDesFre.Text := fRetDesCrmFre(dbeCrmFre.Text);
        If fEmptyStr(edtDesFre.Text) Then
        Begin
          Result := False;
          fMensagem('', 'O Código de Frenquência digitado não existe!', ['&OK']);
        End;
      End
      Else
        edtDesFre.Clear;
    End

    Else
    If (Sender = dbeCrmPor) Then
    Begin
      if Not fEmptyStr(dbeCrmPor.Text) Then
      Begin
        edtDesPor.Text := fRetDesCrmPor(dbeCrmPor.Text);
        If fEmptyStr(edtDesPor.Text) Then
        Begin
          Result := False;
          fMensagem('', 'O Código de Porte digitado não existe!', ['&OK']);
        End;
      End
      Else
        edtDesPor.Clear;
    End

    {Categoria}
    Else
    If (Sender = dbeCrmCat) Then
    Begin
      if Not fEmptyStr(dbeCrmCat.Text) Then
      Begin
        edtDesCat.Text := fRetDesCrmCat(dbeCrmCat.Text);
        If fEmptyStr(edtDesCat.Text) Then
        Begin
          Result := False;
          fMensagem('', 'O Código da Categoria digitado não existe!', ['&OK']);
        End;
      End
      Else
        edtDesCat.Clear;

    End

    Else
    If (Sender = dbeCrmFai) Then
    Begin
      if Not fEmptyStr(dbeCrmFai.Text) Then
      Begin
        edtDesFai.Text := fRetDesCrmFai(dbeCrmFai.Text);
        If fEmptyStr(edtDesFai.Text) Then
        Begin
          Result := False;
          fMensagem('', 'O Código da Faixa de Faturamento Estimado digitado não existe!', ['&OK']);
        End;
      End
      Else
        edtDesFai.Clear;
    End

    Else
    If (Sender = edtCrmFor) Then
    Begin
      if Not fEmptyStr(edtCrmFor.Text) Then
      Begin
        edtDesFor.Text := fRetDesCrmFor(edtCrmFor.Text);
        If fEmptyStr(edtDesFor.Text) Then
        Begin
          Result := False;
          fMensagem('', 'O Código do Fornecedor Atual digitado não existe!', ['&OK']);
        End;
      End
      Else
        edtDesFor.Clear;

    End

    Else If (Sender = dbeCodRep) Then
    Begin
      If Not fEmptyStr(dbeCodRep.Text) Then
      Begin
        pCarregaRepr_Vend(dbeCodRep.Text, edtNomRep);
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse representante não está cadastrado!', ['&Ok']);
          Result := False;
        End

        Else If ((qryTabela.State = dsEdit) And (strCodRepAnt <> dbeCodRep.Text)) Or
                ((qryTabela.State = dsInsert) And (strRepInc <> dbeCodRep.Text) And (Not fEmptyStr(strRepInc))) Then
        Begin
          objLiberacao := TLiberacao.create;
          Try
            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'ALTVPR';
            objLiberacao.strSenLib    := fCfgSis('SENVEN');
            objLiberacao.strMsgSen    := 'Representante';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.strCodDig    := strLoginUsuarioLogado;
            objLiberacao.strCliente   := (dbeCodPro.Text + '-' + dbeNomCli.Text);
            objLiberacao.strCpfCnpj   := dbeNuCnpj.Text;
            objLiberacao.objMsgLibera.pAddTexto('Troca de Representante no Cadastro de Prospecto.');
            objLiberacao.objMsgLibera.pAddTextoCaption('Representante Anterior', strCodRepAnt   + '-' + fRetNomVendRep(strCodRepAnt)  , 22);
            objLiberacao.objMsgLibera.pAddTextoCaption('Representante Atual'   , dbeCodRep.Text + '-' + fRetNomVendRep(dbeCodRep.Text), 22);

            If objLiberacao.fLibera Then
            Begin
              strCodRepAnt := dbeCodRep.Text;
              strRepInc    := dbeCodRep.Text;
            End
            Else
            Begin
              If qryTabela.State = dsInsert Then
                dbeCodRep.Text := strRepInc
              Else
                dbeCodRep.Text := strCodRepAnt;
              Result := False;
            End;
          Finally
            FreeAndNil(objLiberacao);
          End;

        End;
      End
      Else
      Begin
        If qryTabela.State In dsEditModes Then
        Begin
          dbeCodRep.Field.Clear;
          edtNomRep.Clear;
        End;
      End;
    End

    Else If (Sender = dbeCodCac) And (pnlCanalAcesso.Visible) Then
    Begin
      If (Not fEmptyStr(dbeCodCac.Text)) Then
      Begin
        edtDesCadCac.Text := fRetNomCanalAcesso(dbeCodCac.Text);
        If (fEmptyStr(edtDesCadCac.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Canal de Acesso não cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesCadCac.Text := EmptyStr;
        fMensagem('ATENÇÃO!', 'Canal de Acesso deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodReg) Then
    Begin
      If Not fEmptyStr(dbeCodReg.Text) Then
      Begin
        edtDesReg.Clear;
        pCarregaRegiao;
        If (fEmptyStr(edtDesReg.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Região não cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtDesReg.Text := EmptyStr;

      If Result And BlnBuscaPorChave Then
          pProximaPagina;
    End
    Else If (Sender = dbeContat) And (fCfgSis('COOBPR', varBoolean)) Then
    Begin
      If fEmptyStr(dbeContat.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Contato deve ser informado!', ['&Ok']);
        Result := False;
      End
    End;

  End;

  If Not Result Then
  Begin
    If blnValidaCadCli Then
    Begin
      If Sender Is TDBEditFocus Then
      Begin
        TDBEditFocus(Sender).Color := $008484FF;
        blnContemRedColor := True;
      End;
    End
    Else
      pSetFocus(Sender);
  End;
end;

procedure TfrmCadProspectos.pInicializaIndices;
begin
  inherited;
  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodPro;
end;

procedure TfrmCadProspectos.pSetMascaras;
  Var
    intIndex : Integer;
Begin
  With qryTabela Do
  Begin
    For intIndex := 0 To Fields.Count-1 Do
    Begin
      Case Fields[intIndex].DataType Of
        ftFloat, ftCurrency, ftBCD: TFloatField(Fields[intIndex]).DisplayFormat := '#,##0.00';
        ftDate: TDateField(Fields[intIndex]).EditMask := '99/99/9999';
      End;
      Application.ProcessMessages;
    End;

    TStringField(FieldByName('PRO_FONE01')).EditMask := fRetMascaraFonePais;
    TStringField(FieldByName('PRO_FONE02')).EditMask := fRetMascaraFonePais;
    TStringField(FieldByName('PRO_F_A_X_')).EditMask := fRetMascaraFonePais;
    TStringField(FieldByName('PRO_CELULA')).EditMask := fRetMascaraFonePais;
    TStringField(FieldByName('PRO_C_E_P_')).EditMask := '99999-999;0;_';
  End;
End;

procedure TfrmCadProspectos.pVincularProspectoCliente;
var
  strCodCliPro: String;
  ObjProspectoCrt: TProspectoController;
  frmCrmSelCliente: TfrmCrmSelCliente;
begin
  strCodCliPro := '';

  If (fEmptyStr(dbeCodPro.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Código do prospecto deve ser preenchido!', ['&Ok']);
    Exit;
  End;

  If (fMensagem('AVISO', 'Confirma a vinculação de Cliente ao Prospecto?', ['&Sim', '&Não']) = 2) Then
    Exit;

  ObjProspectoCrt := TProspectoController.Create;
  Try
    ObjProspectoCrt.Prospecto.strCodPro(qryTabela.FieldByName('PRO_CODPRO').AsString)
                             .strCPFCGC(qryTabela.FieldByName('PRO_C_G_C_').AsString)
                             .strEndere(qryTabela.FieldByName('PRO_ENDERE').AsString)
                             .strNumEnd(qryTabela.FieldByName('PRO_ENDNUM').AsString)
                             .strBairro(qryTabela.FieldByName('PRO_BAIRRO').AsString)
                             .strCodCid(qryTabela.FieldByName('PRO_CODCID').AsString)
                             .strNumCep(qryTabela.FieldByName('PRO_C_E_P_').AsString)
                             .strFone01(qryTabela.FieldByName('PRO_FONE01').AsString)
                             .strCelula(qryTabela.FieldByName('PRO_CELULA').AsString)
                             .strNum_Rg(qryTabela.FieldByName('PRO_NUMR_G').AsString)
                             .strInsEst(qryTabela.FieldByName('PRO_I_E_S_').AsString)
                             .strEmail1(qryTabela.FieldByName('PRO_EMAIL_').AsString)
                             .strEmail3(qryTabela.FieldByName('PRO_EMAIL3').AsString)
                             .strCPFCGC(qryTabela.FieldByName('PRO_C_G_C_').AsString)
                             .strCodVen(qryTabela.FieldByName('PRO_CODVEN').AsString)
                             .dtaDatCad(qryTabela.FieldByName('PRO_DTACAD').AsDateTime)
                             .dtaDatNas(qryTabela.FieldByName('PRO_NASCIM').AsDateTime)
                             .strFone02(qryTabela.FieldByName('PRO_FONE02').AsString)
                             .strNRgExp(qryTabela.FieldByName('PRO_RG_EXP').AsString)
                             .strCodAti(qryTabela.FieldByName('PRO_CODATI').AsString)
                             .strCodReg(qryTabela.FieldByName('PRO_CODREG').AsString);

    If ObjProspectoCrt.Validacao.fVerificaPodeVincularCliente(True) Then
    Begin
      pCriarFormularios(TfrmCrmSelCliente, frmCrmSelCliente);
      Try
        frmCrmSelCliente.ShowModal;
        If frmCrmSelCliente.ModalResult = mrOk Then
        Begin
          strCodCliPro := frmCrmSelCliente.edtCodCli.Text;

          If Not fEmptyStr(strCodCliPro) Then
          Begin
            If fRetCgcCpf(strCodCliPro) <> qryTabela.FieldByName('PRO_C_G_C_').AsString Then
            Begin
              fMensagem('ATENÇÃO!', 'O CNPJ/CPF do cliente informado não é igual ao do prospecto. ' +
                                    'Sendo assim, não é permitido realizar o vínculo entre os cadastros.', ['&Ok']);
              Exit;
            End;

            ObjProspectoCrt.pExecutarVinculoCadCli(strCodCliPro);
            fMensagem('ATENÇÃO!', 'Processo concluído com sucesso!' + #13 +
                                  'Cadastro de Prospecto vinculado ao código: ' + strCodCliPro, ['&Ok']);

          End;
        End;
      Finally
        pFreeAndNil(frmCrmSelCliente);
      End;
    End;
  Finally
    FreeAndNil(ObjProspectoCrt);
  End;
end;

procedure TfrmCadProspectos.btnAddCrmForClick(Sender: TObject);
begin
  inherited;
  If (Not fValidaCampos(edtCrmFor, True)) Or (fEmptyStr(edtCrmFor.Text)) Then
    Exit;

  Try
    If cdsProFor.Locate('PRF_CRMFOR', edtCrmFor.Text, []) Then
    Begin
      fMensagem('', 'Este Fornecedor já foi Incluído!', ['&Ok']);
      edtCrmFor.Clear;
      edtDesFor.Clear;
      Exit;
    End;

    cdsProFor.Append;
    cdsProFor.FieldByName('PRF_CRMFOR').AsString := edtCrmFor.Text;
    cdsProFor.FieldByName('CRF_NOMFOR').AsString := edtDesFor.Text;
    cdsProFor.Post;

    edtCrmFor.Clear;
    edtDesFor.Clear;
  Finally
    pSetFocus(edtCrmFor);
  End;
end;

procedure TfrmCadProspectos.btnAlterarClick(Sender: TObject);
begin
  If not fEmptyStr(qryTabela.FieldByName('PRO_CODCLI').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'O registro atual já esta ativo no cadastro de clientes, efetue as alterações pelo cadastro de clientes!', ['&Ok']);
    Exit;
  End;

  inherited;
  pHabilitaCodigo(dbeCodPro, dbeNomCli, False);
  strCepAnt := qryTabela.FieldByName('PRO_C_E_P_').AsString;
  objRegLogCat.CodCatAnt := dbeCrmCat.Text;
  objRegLogCat.StaProAnt := fTStatusProspeToStr(TStatusProspe(cbStatusProspe.ItemIndex));
  btnImportarCadastrosProspecto.Enabled := False;
end;

procedure TfrmCadProspectos.btnCadCliClick(Sender: TObject);
  Var
    strCodCli: String;

    procedure pExecutaVinculo;
      Var
        qryUpdate : TUniQuery;
    Begin
      Try
        qryTabela.Edit;
        qryTabela.FieldByName('PRO_CODCLI').AsString := strCodCli;
        qryTabela.FieldByName('PRO_STATUS').AsString := 'I';
        qryTabela.Post;
        pCarregaDados;

        qryUpdate := fCriaQuery(Self);

        With qryUpdate, SQL Do
        Begin
          Close;
          Clear;
          Add(' UPDATE MOVOCO SET OCO_CODCLI = :CODCLI, OCO_TIP_FC = "C" ');
          Add(' WHERE OCO_CODCLI = :CODPRO AND OCO_TIP_FC = "P"          ');
          ParamByName('CODCLI').AsString := qryTabela.FieldByName('PRO_CODCLI').AsString;
          ParamByName('CODPRO').AsString := qryTabela.FieldByName('PRO_CODPRO').AsString;
          ExecSQL;

          Close;
          Clear;
          Add(' UPDATE FATGOR                                  ');
          Add('   INNER JOIN EXTGOR ON FGO_SEQFGO = AUTOINCREM ');
          Add(' SET FGO_CODCLI = :CODCLI,                      ');
          Add('     FGO_PROSPE = NULL                          ');
          Add(' WHERE FGO_PROSPE = :CODPRO                     ');
          Add('   AND FGO_JAFATU = 0                           ');
          ParamByName('CODCLI').AsString := qryTabela.FieldByName('PRO_CODCLI').AsString;
          ParamByName('CODPRO').AsString := qryTabela.FieldByName('PRO_CODPRO').AsString;
          ExecSQL;

        End;

        {Fornecedores}
        If Not cdsProFor.IsEmpty Then
        Begin
          cdsProFor.DisableControls;
          Try
            cdsProFor.First;
            While Not cdsProFor.Eof Do
            Begin
              qryUpdate.Close;
              qryUpdate.SQL.Clear;
              qryUpdate.SQL.Add(' INSERT INTO CLIFOR (CLF_CODCLI, CLF_CRMFOR) VALUES (:CODCLI, :CRMFOR) ');
              qryUpdate.ParamByName('CODCLI').AsString := strCodCli;
              qryUpdate.ParamByName('CRMFOR').AsString := cdsProFor.FieldByName('PRF_CRMFOR').AsString;
              qryUpdate.ExecSQL;
              cdsProFor.Next;
            End;
          Finally
            cdsProFor.EnableControls;
          End;
        End;

      Finally
        FreeAndNil(qryUpdate);
      End;
    End;

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
              Result := True;
              strCodCli := FieldByName('CLI_CODCLI').AsString;
              If (fMensagem('ATENÇÃO','Já existe o CNPJ / CPF cadastrado para o Código: ' + #13 +
                                      strCodCli + '-' + fRetNomCliente(strCodCli) + ' no Cadastro de Clientes!' + #13+
                                      'Deseja vincular os registros?',['&Sim', '&Não'],2) = 1) Then
                pExecutaVinculo;
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

  If (not btnCadCli.Visible) or (not btnCadCli.Enabled) Then
    Exit;

  If (qryTabela.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um registro!', ['&Ok']);
    Exit;
  End;

  If (qryTabela.State in dsEditModes) Then
  Begin
    fMensagem('ATENÇÃO!', 'Grave o registro para ativa-lo para o cadastro de clientes!', ['&Ok']);
    Exit;
  End;

  If not fEmptyStr(qryTabela.FieldByName('PRO_CODCLI').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'O registro atual já esta ativo no cadastro de clientes!', ['&Ok']);
    Exit;
  End;

  If (fEmptyStr(dbeCodPro.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
    Exit;
  End;

  Try
    strMsgValidacao := '';
    blnValidaCadCli := True;
    If Not fValidaPanel(pnlGeral, False, False) Then
    Begin
      If Not fEmptyStr(strMsgValidacao) Then
        fMensagem('', strMsgValidacao, ['&Ok']);
      Exit;
    End;

  Finally
    blnValidaCadCli := False;
  End;

  If (Not fExisteCnpjCpfCliente(strCodCli, dbeNuCnpj.Text, edtEstado.Text)) Then
  Begin
    If (fMensagem('AVISO', 'Confirma a Geração do Cadastro de Clientes?', ['&Sim', '&Não']) = 2) Then
      Exit;

    If TfrmCadClientes.fCadastroRapidoCliente(strCodCli,
                                              dbeNomCli.Text,
                                              dbeFanSob.Text,
                                              dbeEndere.Text,
                                              dbeEndNum.Text,
                                              dbeEndCom.Text,
                                              dbeBairro.Text,
                                              dbeCodCid.Text,
                                              dbeNumCep.Text,
                                              dbeFone01.Text,
                                              dbeNumCel.Text,
                                              dbeNumRg.Text,
                                              dbeNumIes.Text,
                                              dbeEmail.Text,
                                              dbeEmailNFe.Text,
                                              'A',
                                              dbeContat.Text,
                                              StrToInt(dbeCgcCpf.Text),
                                              dbeNuCnpj.Text,
                                              dbeCodRep.Text,
                                              dbeCodVen.Text,
                                              StrToDateDef(dbeDtaCad.Text,0),
                                              StrToDateDef(dbeDtaNas.Text,0),
                                              dbeFone02.Text,
                                              dbeHomPag.Text,
                                              dbeCodAti.Text,
                                              dbeEmailNfe2.Text,
                                              dbeNumFax.Text,
                                              dbeObserv.Text,
                                              qryTabela.FieldByName('PRO_RG_EXP').AsString,
                                              False,
                                              dbeCrmFre.Text,
                                              dbeCrmPor.Text,
                                              dbeCrmFai.Text,
                                              dbeCrmCat.Text,
                                              dbeCodReg.Text,
                                              dbeCodCac.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Geração concluída com sucesso!' + #13 +
                            'Cadastro de Clientes criado com o Código: ' + strCodCli, ['&Ok']);
      pExecutaVinculo;
    End;
  End;

end;

procedure TfrmCadProspectos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaDados;
  btnImportarCadastrosProspecto.Enabled := True;
end;

procedure TfrmCadProspectos.btnExcluirClick(Sender: TObject);
begin
  If not fEmptyStr(qryTabela.FieldByName('PRO_CODCLI').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'O registro atual já esta ativo no cadastro de clientes!', ['&Ok']);
    Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadProspectos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;


  pCarregaDados;
  If qryTabela.IsEmpty And blnContemRedColor Then
    pRemoveCorCamposComErro;
end;

procedure TfrmCadProspectos.btnGravarClick(Sender: TObject);
begin
  If fEmptyStr(edtRgExp.Text) Then
    qryTabela.FieldByName('PRO_RG_EXP').Clear
  Else
    qryTabela.FieldByName('PRO_RG_EXP').AsString := edtRgExp.Text + '-' + cbxRgEst.Text;

  If fEmptyStr(qryTabela.FieldByName('PRO_CRMFRE').AsString) Then
    qryTabela.FieldByName('PRO_CRMFRE').Clear;

  If fEmptyStr(qryTabela.FieldByName('PRO_CRMFAI').AsString) Then
    qryTabela.FieldByName('PRO_CRMFAI').Clear;

  If fEmptyStr(qryTabela.FieldByName('PRO_CRMPOR').AsString) Then
    qryTabela.FieldByName('PRO_CRMPOR').Clear;

  If fEmptyStr(qryTabela.FieldByName('PRO_CODRED').AsString) Then
    qryTabela.FieldByName('PRO_CODRED').Clear;

    If cbStatusProspe.ItemIndex >= 0 Then
      qryTabela.FieldByName('PRO_STAPRO').AsString := fTStatusProspeToStr(TStatusProspe(cbStatusProspe.ItemIndex))
  Else
    qryTabela.FieldByName('PRO_STAPRO').Clear;

  objRegLogCat.GravarLog := False;
  If qryTabela.State in [dsEdit] Then
    Begin
      objRegLogCat.CodCatAtu := qryTabela.FieldByName('PRO_CRMCAT').AsString;
      objRegLogCat.StaProAtu := fTStatusProspeToStr(TStatusProspe(cbStatusProspe.ItemIndex));
      objRegLogCat.GravarLog := (objRegLogCat.CodCatAtu <> objRegLogCat.CodCatAnt) Or
                                (objRegLogCat.StaProAnt <> objRegLogCat.StaProAtu) ;
    End;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;

    If Not blnGravou Then
    Begin
      fRollback;
      Exit;
    End;

    blnGravou := fGravaFornecedor;

    If blngravou Then
    Begin
      If objRegLogCat.GravarLog Then

        TLogCatProspecto.fNew
                        .strSeqPro(qryTabela.FieldByName('AUTOINCREM').AsString)
                        .strCatAnt(objRegLogCat.CodCatAnt)
                        .strCatAtu(objRegLogCat.CodCatAtu)
                        .strStaPro(qryTabela.FieldByName('PRO_STAPRO').AsString)
                        .strEmpDoc(VS_strCodEmp)
                        .pGravaLogAlteracaoCategoria;

      pgcDados.TabIndex := 0;
      fCommit;
    End
    Else
    Begin
      fRollback;
      btnCancela.Click;
    End;

  Except
    On E : Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '[untCadProspectos.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadProspectos.btnImportarCadastrosProspectoClick(Sender: TObject);
begin
  inherited;

  TfrmImportaArquivoCadastro.pAbreTelaImportacaoArquivo(tpCadastroProspecto);
end;

procedure TfrmCadProspectos.btnIncluirClick(Sender: TObject);
begin
  If blnContemRedColor Then
    pRemoveCorCamposComErro;

  inherited;
  pHabilitaCodigo(dbeCodPro, dbeNomCli, False);
  qryTabela.FieldByName('PRO_STATUS').AsString   := 'A';
  qryTabela.FieldByName('PRO_DTACAD').AsDateTime := VS_Date;
  qryTabela.FieldByName('PRO_CRMCAT').AsString   := fCfgSis('CATPRO', varString);
  pLimpaCampos;
  pCarregaDados;
end;

procedure TfrmCadProspectos.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    chrKey: Char;
begin
  inherited;
  chrKey := '/';
  If fPesqProspecto(Self, dbeCodPro, dbeNomCli, qryTabela, chrKey, arrSel) Then
  Begin
    pSetFocus(btnAlterar);
    If blnContemRedColor Then
      pRemoveCorCamposComErro;
  End;

  If qryTabela.Active Then
  Begin
    pSetMascaras;
    pCarregaDados;
  End;
end;

procedure TfrmCadProspectos.btnVincularProspCliClick(Sender: TObject);
begin
  inherited;

  pVincularProspectoCliente;
end;

procedure TfrmCadProspectos.btnConsultarEnderecoClick(Sender: TObject);
begin
  inherited;

  If Not objConsulta.fRetUrlConsultaEnderecoGoogleMaps(dbeEndere.Text, dbeEndNum.Text, dbeBairro.Text, edtNomCid.Text, edtEstado.Text) Then
  Begin
    tsConsultaEndereco.TabVisible := False;
    fMensagem('ATENÇÃO!', ObjConsulta.MensagemRetorno, ['&Ok']);
    Exit;
  End;

  If Not objNavegador.NavegadorAtivo Then
  Begin
    pCriaCadCliNavegador;
    tsConsultaEndereco.Caption    := 'Atenção';
    tsConsultaEndereco.TabVisible := True;
    pgcDados.ActivePage           := tsConsultaEndereco;
    Exit;
  End;

  If objNavegador.NavegadorAtivo Then
  Begin
    objNavegador.Navigate(objConsulta.UrlConsulta);

    tsConsultaEndereco.Caption    := 'Consultar Endereço no Google MAPS';
    tsConsultaEndereco.TabVisible := True;
    pgcDados.ActivePage           := tsConsultaEndereco;
  End;
end;

procedure TfrmCadProspectos.cxgProForTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_DELETE Then
  Begin
    If cdsProFor.Active And (cdsProFor.RecordCount > 0) And (qryTabela.State in dsEditModes) And
       (fMensagem('', 'Deseja Remover o Forncedor Selecionado?', ['&Sim', '&Não'], 2) = 1) Then
      cdsProFor.Delete;
  End;
end;

procedure TfrmCadProspectos.dbeCodCacKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCanal : TConsultasArray;
begin
  inherited;
  If fPesqCanalAcesso(Self, dbeCodCac, edtDesCadCac, Nil, Key, arrCanal) Then
  Begin
    if fValidaCampos(dbeCodCac, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProspectos.dbeCgcCpfExit(Sender: TObject);
begin
  inherited;
  If (dbeCgcCpf.Text = '1') Then
  Begin
    qryTabela.FieldByName('PRO_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
    edtRgExp.Clear;
    cbxRgEst.ItemIndex := -1;

    If qryTabela.State in [dsEdit, dsInsert] Then
      dbeNumRg.Field.Clear;
  End
  Else
    qryTabela.FieldByName('PRO_C_G_C_').EditMask := '999.999.999-99;0;';

  edtRgExp.Enabled := Not((qryTabela.State = dsBrowse) Or (dbeCgcCpf.Text = '1'));
  cbxRgEst.Enabled := Not((qryTabela.State = dsBrowse) Or (dbeCgcCpf.Text = '1'));
  dbeNumRg.Enabled := Not((qryTabela.State = dsBrowse) Or (dbeCgcCpf.Text = '1'));

end;

function TfrmCadProspectos.dbeCodAtiChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadAti(Key);
end;

function TfrmCadProspectos.dbeCodCidChamaCadastro(Key: Word): string;
begin
  inherited;
  If fVerificaAcessoSistema(strPermiCadCid) Then
  Begin
    Result := fChamaCadCid(Key);
  End;
end;

procedure TfrmCadProspectos.pLimpaCampos;
Begin
  edtNomCid.Clear;
  edtEstado.Clear;
  edtEstEmiCpf.Clear;
  edtAtividade.Clear;
  edtRgExp.Clear;
  cbxRgEst.ItemIndex := -1;
  strCepAnt := '';

  lblAtivo1.Visible := False;
  lblAtivo2.Visible := False;
  lblAtivo3.Visible := False;

End;

procedure TfrmCadProspectos.pRemoveCorCamposComErro;
  Var
    intContador: Integer;
begin
  For intContador := 0 To pnlGeral.ControlCount -1 Do
  Begin
    If (pnlGeral.Controls[intContador].Tag = 99) And (pnlGeral.Controls[intContador] Is TDBEditFocus) Then
      TDBEditFocus(pnlGeral.Controls[intContador]).Color := clWindow;
  End;

  blnContemRedColor := False;
End;

procedure TfrmCadProspectos.pAfterOpenTabela(DataSet: TDataSet);
begin
  cdsProFor.qryQuery.Close;
  cdsProFor.qryQuery.ParamByName('CODPRO').AsString := qryTabela.FieldByName('PRO_CODPRO').AsString;
  cdsProFor.fAbreClient(True, 'pAfterOpenTabela');

  If qryTabela.FieldByName('PRO_CGCCPF').AsString = '1' Then
    qryTabela.FieldByName('PRO_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else
    qryTabela.FieldByName('PRO_C_G_C_').EditMask := '999.999.999-99;0;';


  cbStatusProspe.ItemIndex := Integer(fStrToTStatusProspe(qryTabela.FieldByName('PRO_STAPRO').AsString));
end;

procedure TfrmCadProspectos.pCarregaDados;
  Var
    strRgExp : String;
Begin
  strCepAnt := dbeNumCep.Text;
  edtNomCid.Text    := fRetNomCidade(dbeCodCid.Text);
  edtEstado.Text    := fRetNomCidade(dbeCodCid.Text, 1);
  edtAtividade.Text := fRetNomAtividade(dbeCodAti.Text);
  dbeNuCnpjExit(dbeNuCnpj);

  strRgExp := qryTabela.FieldByName('PRO_RG_EXP').AsString;
  edtRgExp.Text := MidStr(strRgExp, 1, Pos('-', strRgExp) -1);
  cbxRgEst.ItemIndex := cbxRgEst.Items.IndexOf(MidStr(strRgExp, Pos('-', strRgExp) + 1, 2));

  edtDesRed.Text   := fRetNomeRedeLojaSelect(dbeCodRed.Text);
  edtVendedor.Text := fRetNomVendRep(dbeCodVen.Text);
  edtDesFre.Text   := fRetDesCrmFre(dbeCrmFre.Text);
  edtDesPor.Text   := fRetDesCrmPor(dbeCrmPor.Text);
  edtDesCat.Text   := fRetDesCrmCat(dbeCrmCat.Text);
  edtDesFai.Text   := fRetDesCrmFai(dbeCrmFai.Text);
  edtNomRep.Text   := fRetNomVendRep(dbeCodRep.Text);
  edtDesFor.Clear;
  edtCrmFor.Clear;

  If (pnlCanalAcesso.Visible) Then
    edtDesCadCac.Text := fRetNomCanalAcesso(dbeCodCac.Text);

  lblAtivo1.Visible := not fEmptyStr(qryTabela.FieldByName('PRO_CODCLI').AsString);
  lblAtivo2.Visible := not fEmptyStr(qryTabela.FieldByName('PRO_CODCLI').AsString);
  lblAtivo3.Visible := not fEmptyStr(qryTabela.FieldByName('PRO_CODCLI').AsString);
  lblAtivo3.Caption := 'Código do Cadastro de Clientes: ' +
                       qryTabela.FieldByName('PRO_CODCLI').AsString + ' - ' +
                       fRetNomCliente(qryTabela.FieldByName('PRO_CODCLI').AsString);

  strCodRepAnt := dbeCodRep.Text;



  edtDesReg.Text := fRetNomRegiao(dbeCodReg.Text);

  pgcDados.TabIndex := 0;

  qryTabela.AfterOpen := pAfterOpenTabela;
  pAfterOpenTabela(Nil);
End;

procedure TfrmCadProspectos.pCarregarCompoStatusPro;
var
  aStatus: TStatusProspe;
begin
  cbStatusProspe.Clear;
  For aStatus := Low( TStatusProspe ) To High( TStatusProspe ) Do
  Begin
    If aStatus <> tstNenhum Then
      cbStatusProspe.Items.Add(arrDescStatPro[aStatus]);
  End;
end;

procedure TfrmCadProspectos.pCarregaRegiao;
begin
  If Not fEmptyStr(dbeCodReg.Text) Then
    edtDesReg.Text := fRetNomRegiao(dbeCodReg.Text)
  Else
    edtDesReg.Text := EmptyStr;
end;

procedure TfrmCadProspectos.pCarregaRepr_Vend(strCodigo: String;
  edtDescricao: TEditFocus);
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, strCodigo);
  edtDescricao.Text := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
end;

procedure TfrmCadProspectos.pCriaCadCliNavegador;
begin
  pCriarFormularios(TfrmNavegadorViewHelp, FCliNavegador);
  FCliNavegador.Align := alClient;
  FCliNavegador.Dock(pnlConsultaEndereco, pnlConsultaEndereco.BoundsRect);
  FCliNavegador.show;
end;

procedure TfrmCadProspectos.pSetaParametrosCRM(strNomCampoCRM, strCodCliCRM, strNomRegraCRM, strDesCampoCRM: String);
begin
  blnUtilizarCrm := True;
  strCliCRM      := strCodCliCRM;
  strCampoCRM    := strNomCampoCRM;
  strRegraCRM    := strNomRegraCRM;
  strDesCamCRM   := strDesCampoCRM;
end;

procedure TfrmCadProspectos.pAplicarRegrasCrm;
Begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add('SELECT *    ');
  qryTabela.SQL.Add('FROM PROSPE ');
  qryTabela.SQL.Add('WHERE PRO_CODPRO = :CODCLI ');
  qryTabela.ParamByName('CODCLI').AsString := strCliCRM;
  qryTabela.Open;

  pAfterOpenTabela(Nil);
  btnAlterarClick(Self);
  pProcuraCampoClienteCRM;

End;

procedure TfrmCadProspectos.pProcuraCampoClienteCRM;
var
  intCont: Integer;
  intTabs: Integer;
begin
  For intCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intCont] is TDBEditFocus Then
    Begin
      If (Self.Components[intCont] as TDBEditFocus).DataField = strCampoCRM Then
      Begin
        For intTabs := 0 to pgcDados.PageCount - 1 Do
        Begin
          pgcDados.ActivePageIndex := intTabs;
          If TDBEditFocus(Self.Components[intCont]).CanFocus Then
          Begin
            If TDBEditFocus(Self.Components[intCont]).Enabled And TDBEditFocus(Self.Components[intCont]).Visible Then
            Begin
              pSetFocus(TDBEditFocus(Self.Components[intCont]));
              TDBEditFocus(Self.Components[intCont]).SelectAll;
            End;
            Exit;
          End
          Else if (intTabs = pgcDados.PageCount - 1) then
          Begin
            pgcDados.ActivePageIndex := 0;
            fMensagem('Informação !','Esse campo no momento, encontra-se indisponível para alteração !',['&Ok']);
          End;
        End;
      End;
    End;
  End;
end;

class function TfrmCadProspectos.fAlteraCadProspecto(const strCodProLocal: String): String;
var
  frmCadProspectos: TfrmCadProspectos;
begin
  If Not fVerificaAcessoSistema('frmCadProspectos') Then
    Exit;

  pCriarFormularios(TfrmCadProspectos, frmCadProspectos);
  Try
    Try
      frmCadProspectos.strCodIniciarCadastro := strCodProLocal;
      frmCadProspectos.ShowModal;
      Result := frmCadProspectos.strUltimoCodigo;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    pFreeAndNil(frmCadProspectos);
  End;
end;

procedure TfrmCadProspectos.pBuscaProspecto(strCodPro: String);
begin
  If fEmptyStr(strCodPro) Then
    Exit;

  pPesquisaCadProspe(qryTabela, qryTabela, strCodPro);

  If qryTabela.Active Then
  Begin
    pSetMascaras;
    pCarregaDados;
  End;
end;

end.
