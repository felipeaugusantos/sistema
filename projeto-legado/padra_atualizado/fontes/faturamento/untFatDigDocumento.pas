unit untFatDigDocumento;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, Uni, AppEvnts, Windows, StrUtils,untFuncoesSimples,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, untLiberacao,
  UniClientDataset, untFuncFat;

type
  TfrmFatDigDocumento = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlDados: TPanel;
    pnlDocumento: TPanel;
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    pnlComanda: TPanel;
    lblComanda: TLabel;
    edtBarCom: TEditFocus;
    pnlHeranca: TPanel;
    chkHerOrc: TCheckBox;
    FlwPnlConfirma: TFlowPanel;
    pnlRemessaDevolucao: TPanel;
    Label2: TLabel;
    edtRemessaDevolucao: TEditFocus;
    procedure btnCancelaClick(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNumDocChange(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure tmrAbrirPedidoTimer(Sender: TObject);
    procedure edtEspDocChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtBarComKeyPress(Sender: TObject; var Key: Char);
    procedure edtRemessaDevolucaoExit(Sender: TObject);
    procedure edtRemessaDevolucaoKeyPress(Sender: TObject; var Key: Char);
  private

    blnBarCom_NovoPedido: Boolean;
    qryFatGor: TUniQuery;
    blnFecharForm: Boolean;
    intSemaforo: Integer;

    objLiberacao : TLiberacao;

    strAutoIncPedidosGerados: String;

    function fCodEmp(): String;

    procedure pMostrarEmpresa;
    procedure pEnableEdits(blnEnable: Boolean);
    procedure pInicializarQryFatGor;

    function fEhDocumentoParaClienteForaEstabelecimento(strNumDoc: string): string;

    function ValidacoesPedidoComPixGerado: Boolean;
    function fExibirCampoComanda: Boolean;
    function fValidaCodigoCaixa(strCodOpe: String; var strCodCax: String): Boolean;
    function fPermiteAlterarPedidoComLoteSeparacaoRomaneio: Boolean;
    function fTemMovimentacaoProgramadaVinculadaNoPedido(strNumDoc, strEspDoc, strEmpDoc: String): Boolean;
    procedure GeraDocumentoRemessaDevolucao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strOpcDoc: String;
    strAutInc: String;
    strCodEmp: String;
    blnGravarComo: Boolean;
    blnApenasPrazo: Boolean;
    blnApenasVista: Boolean;
    strCodCliDef: String;
    strCodCliGravado: String;
    strProspe: String; //Codigo do Prospecto Qndo passado por crm;
    strCgcCpf: String; //CNPJ-CPF do cliente consumidor passado por crm
    strNumOrcPedAbrir: String;
    strEspOrcPedAbrir: String;
    strNLeads : String;
    blnEstouNoCrm: Boolean;
    blnForcarAbrirDigDocumento: Boolean;

    procedure pIniciaTela;    
  end;

implementation

uses untFuncoes, untFatVendas, untTypesSistema, untRcxTResumoDeCaixa,
     DB, untConsultas, untFatMostraItemSalBal,untPanelCxPedOrc, untFuncoesRel, untFuncoesRel2,
     untEnderecamentoProduto, untPanelCxOU_TE, untPnlDadosOU_TE, untPnlDadosPedOrc,
     untFuncoesDiarias, untFatGor, untAdiantamentoCliente, untFatAltQtdeItensPedido,
     untFuncoesCRM, untConstantes, untFatDigCodBarrasComanda, untMsgLiberacao,
     untLibExt, untAdiantamentoClienteGenerico, Yapay.Api.Facade, untTPixDao, untFatRemessaDevolucaoClasse,
     untPgtOnlineApi, untTFuncoesPixAutcom, untTiposPix, untFatConfOrcamentos, untRomLge;

{$R *.dfm}

procedure TfrmFatDigDocumento.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigDocumento.edtBarComKeyPress(Sender: TObject; var Key: Char);
var
  Documento: TDocumento;
begin

  inherited;

  if (Key = #13) and (Length(edtBarCom.Text) = edtBarCom.MaxLength) then
  begin

    {Valida faixa permitida!}
    if not TfrmFatDigCodBarrasComanda.fComandaEstaDentroFaixa(edtBarCom.Text) then
    begin
      fMensagem('Atenção', 'Código da comanda esta fora da faixa permitida!', ['&Ok']);
      edtBarCom.Clear;
      pSetFocus(edtBarCom);
    end
    else
    begin

      Documento := TfrmFatDigCodBarrasComanda.fRetPDEmAberto_Comanda(edtBarCom.Text);

      if (not fEmptyStr(Documento.strNumDoc)) then
      begin
        edtNumDoc.Text := Documento.strNumDoc;
        edtEspDoc.Text := Documento.strEspDoc;
        edtCodEmp.Text := Documento.strCodEmp;
      end
      else
      begin

        if fMensagem('ATENÇÃO!', 'Não foi encontrado nenhum pedido em aberto vinculado a esta comanda!' + #13 +
                                 'Deseja gerar um novo pedido e vincular a comanda?', ['&Sim', '&Não'], 2) = 1 then
        begin
          blnBarCom_NovoPedido := True;
          btnConfirmaDadosClick(Self);
        end
        else
        begin
          blnBarCom_NovoPedido := False;
          edtBarCom.Clear;
          pSetFocus(edtBarCom);
        end;

      end;

    end;

  end;

end;

procedure TfrmFatDigDocumento.edtEspDocChange(Sender: TObject);
begin
  inherited;
  pMostrarEmpresa;
end;

procedure TfrmFatDigDocumento.edtNumDocChange(Sender: TObject);
begin
  inherited;
  chkHerOrc.Enabled := Not fEmptyStr(edtNumDoc.Text);
  If Not chkHerOrc.Enabled Then
    chkHerOrc.Checked := False;
end;

procedure TfrmFatDigDocumento.edtNumDocKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strEspDoc : String;
    arrDoc    : TConsultasArray;
    objfrmPnl : TPanelCxPedOrc;
    objfrmPnl2: TPanelCxOU_TE;
begin
  objfrmPnl := nil;
  objfrmPnl2:= nil;

  If InterlockedIncrement(intSemaforo) = 0 Then
  Begin
    Try
    inherited;

    If Pos(strOpcDoc, 'OR_PD_') > 0 Then
      strEspDoc := strOpcDoc
    Else If Pos(strOpcDoc, 'EM_ER_') > 0 then
      strEspDoc := 'PD'
    Else
      strEspDoc := 'OR';

    If fEntraCons(Key) Then
    Begin
      btnConfirmaDados.Enabled := False;
      btnCancelaDados.Enabled := False;

      If (fCfgSis('USAPDV', varBoolean)) Then
      Begin
        If (Pos(strOpcDoc,'VN_VS_CS_') > 0) Then
           If (fMensagem('', 'Escolha: ', ['&Orçamento', '&Pedido']) = 2) Then
             strEspDoc := 'PD'
           Else
             strEspDoc := 'OR';
      End;

      If (Pos(strOpcDoc, 'OU_TE_') > 0) Then
        objfrmPnl2 := TPanelCxOU_TE.Create(TfrmPnlDadosOU_TE)
      Else
        objfrmPnl  := TPanelCxPedOrc.Create(TfrmPnlDadosPedOrc, strEspDoc, not fEmptyStr(strCodCliDef));

      If (Pos(strOpcDoc, 'OU_TE_') > 0) Then
      Begin
        If fPesqPedOrc(conPedCompleta, Self, strEspDoc, strOpcDoc, VS_strCodEmp ,edtNumDoc, edtEspDoc, edtCodEmp, qryFatGor, Key, arrDoc, True, objfrmPnl2) Then
        Begin
          edtNumDoc.Text := qryFatGor.FieldByName('FGO_NUMDOC').AsString;
          edtEspDoc.Text := qryFatGor.FieldByName('FGO_ESPDOC').AsString;
          edtCodEmp.Text := qryFatGor.FieldByName('FGO_CODEMP').AsString;
          strCodEmp      := qryFatGor.FieldByName('FGO_CODEMP').AsString;
          strAutInc      := qryFatGor.FieldByName('AUTOINCREM').AsString;
        End;
      End
      Else
      Begin
        If fPesqPedOrc(conPedCompleta, Self, strEspDoc, strOpcDoc, VS_strCodEmp ,edtNumDoc, edtEspDoc, edtCodEmp, qryFatGor, Key, arrDoc, False, objfrmPnl, strCodCliDef) Then
        Begin
          If Length(arrDoc) > 1 Then
          Begin
            fMensagem('','Selecione apenas um pedido/orçamento para alterar!', ['&OK']);
            edtNumDoc.Clear;
            InterlockedDecrement(intSemaforo);
            Exit;
          End;
          edtNumDoc.Text := qryFatGor.FieldByName('FGO_NUMDOC').AsString;
          edtEspDoc.Text := qryFatGor.FieldByName('FGO_ESPDOC').AsString;
          edtCodEmp.Text := qryFatGor.FieldByName('FGO_CODEMP').AsString;
          strCodEmp      := qryFatGor.FieldByName('FGO_CODEMP').AsString;
          strAutInc      := qryFatGor.FieldByName('AUTOINCREM').AsString;
        End;
      End;

      if Assigned(objfrmPnl) then
        FreeAndNil(objfrmPnl);

      if Assigned(objfrmPnl2) then
        FreeAndNil(objfrmPnl2);

      btnConfirmaDados.Enabled := True;
      btnCancelaDados.Enabled := True;

      pInicializarQryFatGor;
    End;

    InterlockedDecrement(intSemaforo);

    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intSemaforo);
        btnConfirmaDados.Enabled := True;
        btnCancelaDados.Enabled := True;
        pMensagensErro(E.Message, '[ConsultaFaturamento]');
      End;
    End;
  End
  ELse
    InterlockedDecrement(intSemaforo);
end;

procedure TfrmFatDigDocumento.edtRemessaDevolucaoExit(Sender: TObject);
begin
  inherited;

  if not fEmptyStr(edtRemessaDevolucao.Text) then
    edtRemessaDevolucao.Text := fStrZero(edtRemessaDevolucao.Text, edtRemessaDevolucao.TamCampo);
end;

procedure TfrmFatDigDocumento.edtRemessaDevolucaoKeyPress(Sender: TObject;
  var Key: Char);
var
  qryConGen: TUniQuery;
  arrSel   : TConsultasArray;
begin
  inherited;

  qryConGen := fCriaQuery(Self);

  Try
    If fPesqRemessaDevolucao(Self, edtRemessaDevolucao, qryConGen, Key, arrSel, toTransferencia) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;

  Finally
    FreeAndNil(qryConGen);
  End;
end;
function TfrmFatDigDocumento.fCodEmp: String;
begin
  If (Pos(strOpcDoc, 'TE_OU_') > 0) Then
  Begin
    If Not fEmptyStr(qryFatGor.FieldByName('FGO_CODEMP').AsString) Then
      strCodEmp := qryFatGor.FieldByName('FGO_CODEMP').AsString
    Else
      strCodEmp := edtCodEmp.Text;
  End
  Else If (Pos(strOpcDoc, 'OR_VN_') > 0) And (fCfgSis('ALTORC') = 'S') And fVerificaAcessoSistema('ALTORC') And (edtEspDoc.Text = 'OR') Then
  Begin
    If Not fEmptyStr(qryFatGor.FieldByName('FGO_CODEMP').AsString) Then
      strCodEmp := qryFatGor.FieldByName('FGO_CODEMP').AsString
    Else
      strCodEmp := edtCodEmp.Text;
  End
  Else
  Begin
    strCodEmp := VS_strCodEmp;
  End;

  If strCodEmp.IsEmpty Then
    strCodEmp := VS_strCodEmp;

  Result := strCodEmp;
end;

function TfrmFatDigDocumento.fEhDocumentoParaClienteForaEstabelecimento(
  strNumDoc: string): string;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery();
  try
    Result := EmptyStr;

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT C.CLI_REMOUT');
    qryConsulta.SQL.Add('FROM FATGOR F');
    qryConsulta.SQL.Add('INNER JOIN CADCLI C');
    qryConsulta.SQL.Add('ON(F.FGO_CODCLI = C.CLI_CODCLI)');
    qryConsulta.SQL.Add('WHERE F.FGO_NUMDOC = :NUMDOC');
    qryConsulta.SQL.Add('AND F.FGO_ESPDOC = "PD"');
    qryConsulta.SQL.Add('AND F.FGO_CODEMP = :CODEMP');

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryConsulta.Open;

    if not qryConsulta.IsEmpty then
    begin
      Result := qryConsulta.FieldByName('CLI_REMOUT').AsString;
    end;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

procedure TfrmFatDigDocumento.btnConfirmaDadosClick(Sender: TObject);
  Var
    strSQL: String;
    strNumOrc: String;

    strCodTra: String;
    strTipFre: String;
    strOrcDoc: String;
    strOrcEsp: String;

    strEstoqueExterno: String;

    qryMovRcd: TUniQuery;
    qryGenDor: TUniQuery;
    dtsGenDor: TDataSource;

    blnContinua: Boolean;
    strDocTmp: String;

    strNumOrcRef,
    strEmpOrcRef: String;

    strNumOse: String;
    strStsPgto: String;

    strSeqRcp: String;
    strEmpRcp: String;
    LMensagem : string;
    blnItemEspecial: Boolean;

    stlItensOS: TStringList;
    arrMensagem: TStringArray;
    intCont: Integer;
    strEquip: String;

    strTipOpe: String;
    strCodDig: String;
    strCodVen: String;
    strCodCax: String;
    blnFaturarF11Finalizar : Boolean;
    objResumoDeCaixa : TResumoDeCaixa;
    qryFatDorGerados: TUniQuery;
    blnTravaFaturamentoF11 : Boolean;
    frmFatConfOrcamentos : TfrmFatConfOrcamentos;
begin
  inherited;
  strCodCax := '';
  blnFaturarF11Finalizar := False;
  blnTravaFaturamentoF11 := False;

  If InterlockedIncrement(intSemaforo) = 0 Then
  Begin
    Try
      pEnableEdits(False);

      If (fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(qryFatGor.FieldByName('FGO_NUMDOC').AsString)) Then
      Begin
        qryFatGor.Close;
        qryFatGor.SQL.Clear;
        qryFatGor.SQL.Add(fSelectFromFatgorLeftAuxiliares(False));
        qryFatGor.SQL.Add(' WHERE FALSE ');
        qryFatGor.Open;
      End;

      qryGenDor := fCriaQuery(Self);
      dtsGenDor := fCriaDataSource(qryGenDor);

      If (fEmptyStr(fCfgSis('CAMTB1')) And (VS_strTabVen[1] = 'S')) Or
         (fEmptyStr(fCfgSis('CAMTB2')) And (VS_strTabVen[2] = 'S')) Or
         (fEmptyStr(fCfgSis('CAMTB3')) And (VS_strTabVen[3] = 'S')) Or
         (fEmptyStr(fCfgSis('CAMTB4')) And (VS_strTabVen[4] = 'S')) Or
         (fEmptyStr(fCfgSis('CAMTB5')) And (VS_strTabVen[5] = 'S')) Or
         (fEmptyStr(fCfgSis('CAMTB6')) And (VS_strTabVen[6] = 'S')) Or
         (fEmptyStr(fCfgSis('CAMTB7')) And (VS_strTabVen[7] = 'S')) Then
      Begin
        fMensagem('ATENÇÃO!', 'Os parametros de trava de valor de venda não estão configurados corretamente.' + #13#10 +
                              'Configure-os em Configurações -> Trava de Venda por Preço.', ['&Ok']);
        Exit;
      End;

      If (fCfgSis('OPRFLJ', varBoolean)) And (fEmptyStr(VS_strEmpPrd)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O sistema está configurado para gerar ordem de produção fora da loja,' + #13#10 +
                              'porém não foi informado qual será a empresa para produção de tinta de máquina.' + #13#10 +
                              'Favor verificar.', ['&Ok']);
        Exit;
      End;

      If (fCfgSis('BADAUT', varBoolean)) And
         ((fEmptyStr(fCfgSis('PORAUT', varString))) Or
          (fEmptyStr(fCfgSis('CTAAUT', varString))) Or
          (fEmptyStr(fCfgSis('HISAUT', varString)))) Then
      Begin
        fMensagem('ATENÇÃO!', 'O sistema está configurado para baixa automática de créditos no pedido (CFG_BADAUT),' + #13#10 +
                              'porém existem configurações relacionadas não informadas.' + #13#10 +
                              'Favor verificar.', ['&Ok']);
        Exit;
      End;

      If (pnlRemessaDevolucao.Visible) And (Not fEmptyStr(edtRemessaDevolucao.Text)) Then
      Begin
        GeraDocumentoRemessaDevolucao;
        Exit;
      End;

      pnlInfo.Caption := 'Aguarde...';

      If (strOpcDoc = 'VN') And fCfgSis('EMPFAT', varBoolean) And
         (Not fCfgSis('EMPFVN', varBoolean)) And qryFatGor.Active Then
      Begin
        With qryFatGor Do
        If fEhPedOrcMultiloja(FieldByName('FGO_NUMDOC').AsString,
                              FieldByName('FGO_ESPDOC').AsString,
                              FieldByName('FGO_CODEMP').AsString) Then
        Begin
          fMensagem('ATENÇÃO!', 'Pedido/Orçamento Multiloja. Desmembre-o antes de faturar!', ['&Ok']);
          Exit;
        End;
      End;

      If strOpcDoc.Equals('PD') And fUsaOndaSeparacaoAgrupamento And
         fFoiSelecionadoPedidoDeRemessaDePedidoComRemessaDeSeparacaoJaGerada(edtNumDoc.text, 'PD', fCodEmp) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é possível editar um pedido pertencente a Remessa de Pedido/Separação!', ['&Ok']);
        Exit;
      End;

      If  (Pos(strOpcDoc,'PD_VN') > 0) Then
      Begin
        If fEhPedAdiantamentoContratoLocacao(edtNumDoc.text, 'PD', fCodEmp) Then
        Begin
          fMensagem('ATENÇÃO!', 'Utilize a rotina de Resumo de Caixa ou de Adiantamento para modificar um pedido de Adiantamento de Contrato!', ['&Ok']);
          Exit;
        End;
      End;

      If (Pos(strOpcDoc,'VN_VS_PD_') > 0) Then
      Begin

        If (fCfgSis('VNPOOR', varBoolean)) And fEmptyStr(edtNumDoc.text) Then
        Begin
          objLiberacao.Clear;
          If strOpcDoc = 'PD' Then
            objLiberacao.objMsgLibera.pAddTexto('Não é possível iniciar a emissão deste Pedido !')
          Else
            objLiberacao.objMsgLibera.pAddTexto('Não é possível iniciar a emissão desta Venda !');

          objLiberacao.objMsgLibera.pAddTexto('Documentos desta espécie, devem ser originados a partir de um Orçamento.');

          objLiberacao.strDirAce := 'LIBVPO';
          objLiberacao.strSenLib := fCfgSis('SENVPO');
          objLiberacao.strMsgSen := 'Iniciar nova Venda/Pedido sem Orçamento.';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;

          If not objLiberacao.fLibera  Then
          Begin
            Exit;
          End;
        End;

      End;

      If (SameText(edtEspDoc.Text, 'PD')) And (strOpcDoc = 'VN') Then
      Begin
        If Not fPermiteFaturamentoPedidoComItemEstruturaSemOrdemProducao(edtNumDoc.Text, fCodEmp, objLiberacao) Then
          Exit;
      End;

      {*********************************************************}
      {* ANTES DE CARREGAR UM PEDIDO É FEITO UMA PESQUISA      *}
      {* NA MOVPRO, ONDE VERIFICA SE EXISTE ALGUMA ORDEM DE    *}
      {* PRODUCAO GERADA A PARTIR DO PEDIDO DE VENDA, CASO     *}
      {* SIM ELE NAO DEIXA REALIZAR ALTERACOES NO PEDIDO       *}
      {******************************************************JC*}
      If strOpcDoc = 'PD' Then
      Begin
        blnContinua := True;

        If fCfgSis('UTIIND', varBoolean) Then
        Begin
          If fPedidoComOrdemDeProducao(edtNumDoc.Text, fCodEmp) Then
          Begin
            qryFatGor.Close;
            qryFatGor.SQL.Clear;
            qryFatGor.SQL.Add(fSelectFromFatgorLeftAuxiliares(False));
            qryFatGor.SQL.Add(' WHERE F.FGO_NUMDOC = :NUMDOC                      ');
            qryFatGor.SQL.Add('   AND F.FGO_ESPDOC = :ESPDOC                      ');
            qryFatGor.SQL.Add('   AND F.FGO_CODEMP = :CODEMP                      ');

            qryFatGor.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
            qryFatGor.ParamByName('ESPDOC').AsString := 'PD';
            qryFatGor.ParamByName('CODEMP').AsString := fCodEmp;
            qryFatGor.Open;

            fMensagem('', 'O pedido originou uma ordem de produção, não será possível edita-lo!', ['&OK']);

            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddSeparador(80);

            objLiberacao.objMsgLibera.pAddTexto('<<<  ALTERAÇÃO DE PEDIDO DE VENDA COM ORDEM DE PRODUÇÃO GERADA  >>>', alCentro, teAutcom, '', 80);
            objLiberacao.objMsgLibera.pAddSeparador(80);
            objLiberacao.objMsgLibera.pAddTextoCaption('Pedido'   ,  qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                                     qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                                                                     qryFatGor.FieldByName('FGO_CODEMP').AsString                                                                         , 9 );
            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'  ,  qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                                                                     fRetNomCliente(qryFatGor.FieldByName('FGO_CODCLI').AsString)                                                         , 9 );
            objLiberacao.objMsgLibera.pAddTextoCaption('Vr.Pedido',  FormatFloat('#,##0.00', qryFatGor.FieldByName('FGO_VLRCON').AsFloat)                                                 , 9 );
            objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor' ,  qryFatGor.FieldByName('FGO_CODVEN').AsString + '-' + fRetNomeOperador(qryFatGor.FieldByName('FGO_CODVEN').AsString)  , 9);
            objLiberacao.objMsgLibera.pAddSeparador(80);

            objLiberacao.strDirAce := 'PEDOPI';
            objLiberacao.strCodOpe := strLoginUsuarioLogado;
            objLiberacao.blnSempreVariavelUsuario := True;

            blnContinua :=  objLiberacao.fLibera;

          End;
        End;

        If (blnContinua) And (fCfgSis('SLRQPV', varBoolean)) And
           (Pos(fCfgSis('SLDPED'), 'A_T_') > 0) And (Not fEmptyStr(edtNumDoc.Text)) And
           (fPedidoTemRequisicaoDeCompras(edtNumDoc.Text,
                                          'PD',
                                          fCodEmp,
                                          strSeqRcp,
                                          strEmpRcp)) Then
        Begin
          qryFatGor.Close;
          qryFatGor.SQL.Clear;
          qryFatGor.SQL.Add(fSelectFromFatgorLeftAuxiliares(False));
          qryFatGor.SQL.Add(' WHERE F.FGO_NUMDOC = :NUMDOC ');
          qryFatGor.SQL.Add('   AND F.FGO_ESPDOC = :ESPDOC ');
          qryFatGor.SQL.Add('   AND F.FGO_CODEMP = :CODEMP ');
          qryFatGor.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
          qryFatGor.ParamByName('ESPDOC').AsString := 'PD';
          qryFatGor.ParamByName('CODEMP').AsString := fCodEmp;
          qryFatGor.Open;

          qryMovRcd := fCriaQuery(Self);
          Try
            With qryMovRcd Do
            Begin
              Close;
              SQL.Clear;
              SQL.Add(' SELECT RCD_CODITE, RCD_DESITE, RCD_QTDITE ');
              SQL.Add('   FROM MOVRCD ');
              SQL.Add('  WHERE RCD_CODIGO = :CODIGO ');
              SQL.Add('    AND RCD_CODEMP = :CODEMP ');
              SQL.Add('    AND RCD_REQNEG <> "S"    ');
              ParamByName('CODIGO').AsString := strSeqRcp;
              ParamByName('CODEMP').AsString := strEmpRcp;
              Open;
            End;

            If (Not qryMovRcd.IsEmpty) And
               (Not qryFatGor.IsEmpty) Then
            Begin

              objLiberacao.objMsgLibera.pAddTexto('<<<  PEDIDO DE VENDA COM REQUISIÇÃO DE COMPRA VINCULADA  >>>', alCentro, teAutcom, '', 109);
              objLiberacao.objMsgLibera.pAddSeparador(109);
              objLiberacao.objMsgLibera.pAddTextoCaption('Pedido'     ,  qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                                         qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                                                                         qryFatGor.FieldByName('FGO_CODEMP').AsString                                                                         , 11);

              objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'   ,   qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                                                                         fRetNomCliente(qryFatGor.FieldByName('FGO_CODCLI').AsString)                                                         , 11);

              objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'   ,  qryFatGor.FieldByName('FGO_CODVEN').AsString + '-' + fRetNomeOperador(qryFatGor.FieldByName('FGO_CODVEN').AsString)  , 11);

              objLiberacao.objMsgLibera.pAddTextoCaption('Cond.Pagto' ,  fFormataCondPag(qryFatGor.FieldByName('FGO_CONPAG').AsString)                                                        , 11);

              objLiberacao.objMsgLibera.pAddTextoCaption('Forma Pagto',  qryFatGor.FieldByName('FGO_CODFPG').AsString + '-' + fRetDescFpg(qryFatGor.FieldByName('FGO_CODFPG').AsString)       , 11);

              objLiberacao.objMsgLibera.pAddSeparador(109);
              objLiberacao.objMsgLibera.pAddTexto('** Ao liberar essa trava a requisição será gerada novamente com base no estoque atual dos itens desse pedido!');
              objLiberacao.objMsgLibera.pAddSeparador(109);

              qryMovRcd.First;
              While Not qryMovRcd.Eof Do
              Begin
                objLiberacao.objMsgLibera.pAddTexto('Produto: ' + qryMovRcd.FieldByName('RCD_CODITE').AsString + '-' + qryMovRcd.FieldByName('RCD_DESITE').AsString);
                objLiberacao.objMsgLibera.pAddTexto('Quantidade da Requisição: ' + FormatFloat('#,##0.00', qryMovRcd.FieldByName('RCD_QTDITE').AsFloat));
                objLiberacao.objMsgLibera.pAddSeparador(109);

                qryMovRcd.Next;
              End;
              qryMovRcd.Close;

              objLiberacao.strDirAce := 'SLRQPV';
              objLiberacao.strCodOpe := strLoginUsuarioLogado;
              objLiberacao.blnSempreVariavelUsuario := True;
              objLiberacao.pInformaNumDocEspDocCodEmp(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                                      qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                                      qryFatGor.FieldByName('FGO_CODEMP').AsString);

              blnContinua :=  objLiberacao.fLibera;
            End;
          Finally
            FreeAndNil(qryMovRcd);
          End;
        End;

        If Not blnContinua Then
        Begin
          pnlInfo.Caption := '';
          Exit;
        End;

      End;

      If fEhPedidoReservaEstoqueEnderecamento(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text) Then
      Begin
        pMensagemOk('Este pedido não pode ser utilizado pois o mesmo se refere à ' +
                    'uma reserva de estoque realizada pela Entrada de Mercadorias ou Devolução!');
        Exit;
      End;



      If (Pos(strOpcDoc, 'OR_PD_VN_') > 0)   And
         (Not fEmptyStr(edtNumDoc.Text))     And
         (TFatVenda.fTravaDocumentoBonificado(edtNumDoc.Text,
                                              edtEspDoc.Text,
                                              edtCodEmp.Text)) Then
      Begin
        Exit;
      End;

      if (not fEmptyStr(edtNumDoc.Text)) and (strOpcDoc = 'ER') and (fEhDocumentoParaClienteForaEstabelecimento(edtNumDoc.Text) <> 'S') then
      begin
        fMensagem('ATENÇÃO', 'Documento registrado para cliente que não é para fora do estabelecimento!', ['&O k']);
        Exit;
      end;

      if (not fEmptyStr(edtNumDoc.Text)) and (strOpcDoc = 'EM') and (fEhDocumentoParaClienteForaEstabelecimento(edtNumDoc.Text) <> 'N') then
      begin
        fMensagem('ATENÇÃO', 'Documento registrado para cliente fora do estabelecimento!', ['&O k']);
        Exit;
      end;

      {Verifica se orçamento esta fora do prazo de validade!}
      If (Pos(strOpcDoc, 'OR_VN_') > 0)                                         And
         (Not fEmptyStr(edtNumDoc.Text))                                        And
         ((fCfgSis('ORCVEN', varInteger) > 0) Or fCfgSis('IFVLOR', varBoolean)) And
         (fCfgSis('ORCVBL', varBoolean))                                        Then
      Begin

        if (not TFatVenda.fTravaOrcVenc(edtNumDoc.Text,
                                        edtEspDoc.Text,
                                        edtCodEmp.Text)) Then
        Begin
          Exit;
        End;

      End;

      If strOpcDoc = 'PD' Then
      Begin
        If Not fValidaSePedidoOriundoOSPodeSerAlterado(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text) Then
          Exit;
      End
      else if (not fPermiteCarregarPDOrdServico(edtNumDoc.Text, edtCodEmp.Text)) then
        Exit;

      If (strOpcDoc = 'VN') And (Not fCfgSis('FTPDOS', varBoolean)) Then 
      Begin
        if (Not fOSFinalizada(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                              qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                              qryFatGor.FieldByName('FGO_CODEMP').AsString,
                              strNumOse)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Pedido de Venda é oriundo da Ordem de Serviço ' + strNumOse + #13 +
                                'e a mesma ainda não foi finalizada. Procure o responsável' + #13 +
                                'pela rotina de Conserto de Equipamentos para realizar' + #13 +
                                'este procedimento e liberar o faturamento deste Pedido.', ['&OK']);
          Exit;
        End;
      End;

      if (strOpcDoc = 'VN') and
        (not fOSFinalizadaArmazenada(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                     qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                     qryFatGor.FieldByName('FGO_CODEMP').AsString,
                                     strNumOse, strEquip)) then
      begin
        fMensagem('ATENÇÃO!', 'Este pedido de venda é oriundo de Conserto de Equipamento através da Ordem de Serviço ' + strNumOse + '.' + #13 +
                              'Para permitir seu faturamento, é necessário que o Armazenamento do Equipamento tenha ' +
                              'sido realizado e esteja pronto pra ser retirado, porém isso ainda não ocorreu.' + #13 +
                              'Entre em contato com o departamento de Assitência Técnica para solicitar que isso seja feito.' + #13 +
                              'Equipamento: ' + strEquip, ['&OK'], 1, False, 1, 0, False, 0, False, False, False, 230, 560);
        Exit;
      end;

      stlItensOS := TStringList.Create;

      try
        if (Pos(strOpcDoc, 'OU_VN_') > 0) and (not fEmptyStr(edtNumDoc.Text))
          and (fOSItensNaoReservados(edtNumDoc.Text,
                                     edtEspDoc.Text,
                                     edtCodEmp.Text,
                                     '',
                                     strNumOse,
                                     stlItensOS)) then
        begin
          SetLength(arrMensagem, 0);

          pAddDados(arrMensagem, fPadR('|Cód.Item|Descrição', 57) + '|');
          pAddDados(arrMensagem, fPadR('-', 58, '-'));

          for intCont := 0 to Pred(stlItensOS.Count) do
          begin
            pAddDados(arrMensagem, '|' + fPadR(Copy(stlItensOS[intCont], 1, 56), 56) + '|');
          end;

          fMensagemTabela('ATENÇÃO!',
                          'Produtos',
                          arrMensagem,
                          'Não é permitido faturar o pedido ' + qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-PD-' + qryFatGor.FieldByName('FGO_CODEMP').AsString +
                            ' pois ele possui produtos que não estão reservando estoque (OS).' + #13 +
                            'OS: ' + strNumOse + #13 +
                            'Acesse a rotina "Liberação de Reserva de Estoque Itens de Pedido de Venda - OS", ' +
                            'realize a liberação da reserva do estoque e depois, tente novamente.',
                          ['&Ok'],
                          1,
                          False,
                          1,
                          0,
                          False,
                          0,
                          False,
                          False,
                          False,
                          400,
                          100);

          Exit;
        end;
      finally
        FreeAndNil(stlItensOS);
      end;

      If (Pos(strOpcDoc, 'PD_OR_') = 0) And Assigned(qryFatGor) And qryFatGor.Active And
         (Not TFatVenda.fValidarSeClienteEstoqueExternoPermiteFaturamento(qryFatGor.FieldByName('FGO_CODCLI').AsString, strEstoqueExterno)) Then
      Begin
        pMensagemOk(Format('O cliente do estoque externo "%s" não pode emitir faturamento pelo Autcom!', [strEstoqueExterno]));
        Exit;
      End;

      If (strOpcDoc = 'VN') Then
      Begin
        strTipOpe := fTipoOperacao(edtNumDoc.Text,
                                   edtEspDoc.Text,
                                   edtCodEmp.Text);

        If SameText(strTipOpe, 'U') Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é possível carregar um pedido com o tipo de operação "Uso/Consumo" pela Venda Normal.', ['&Ok']);
          Exit;
        End;
      End;

      If Not fPermiteAlterarPedidoComLoteSeparacaoRomaneio Then
      Begin
        fMensagem('ATENÇÃO', 'Não é possível alterar esse Pedido. '+ sLineBreak + 'Pedido já foi incluído em um Lote de Separação de Romaneio '+fRetornaLoteEmpresaSeparacaoRomaneio(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text)+' !', ['&O k']);
        Exit;
      End;

      If fTemMovimentacaoProgramadaVinculadaNoPedido(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Pedido não pode ser alterado pois possui movimentação programada em aberto.' +sLineBreak+
                              'Fale com o operador responsável pelos abastecimentos do estoque ou, limpe a separação do pedido, ' +sLineBreak+
                              'altere e depois imprima a separação novamente!', ['&Ok']);
        Exit;
      End;

      If Not fEmptyStr(qryFatGor.FieldByName('FGO_NUMDOC').AsString) Then
        strDocTmp := qryFatGor.FieldByName('FGO_NUMDOC').AsString
      Else
        strDocTmp := edtNumDoc.Text;

      If (Not fEmptyStr(strDocTmp)) Then
      Begin

        {*********************************************************}
        {* ANTES DE CARREGAR A VENDA NORMAL É FEITO UMA PESQUISA *}
        {* NA FATDOR, ONDE VERIFICA SE EXISTE ALGUM ITEM         *}
        {* COM A DATA DE BALANCO IGUAL A HOJE, SE HOUVER         *}
        {* ELE NAO DEIXA EFETUAR A VENDA E MOSTRA OS ITENS       *}
        {******************************************************LB*}
        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '	FDO_CODITE AS "Cód. Item",  ';
        strSQL := strSQL + '	C.ITE_DESITE AS "Nome do Item" , ';
        strSQL := strSQL + '	I.ITE_DTABAL AS "Data de Balanço" ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  FATDOR , ';
        strSQL := strSQL + '  ITEGER I, ';
        strSQL := strSQL + '	CADITE C ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '	FDO_NUMDOC   = :NUMDOC      AND ';
        strSQL := strSQL + '	FDO_ESPDOC   = :ESPDOC      AND ';
        strSQL := strSQL + '	I.ITE_CODEMP = :CODEMP      AND ';
        strSQL := strSQL + '	I.ITE_CODEMP = FDO_CODEMP   AND ';
        strSQL := strSQL + '	I.ITE_CODITE = FDO_CODITE   AND ';
        strSQL := strSQL + '	C.ITE_CODITE = I.ITE_CODITE AND ';
        strSQL := strSQL + '  I.ITE_DTABAL >= ' + fCurrentDate + ' ';
        strSQL := strSQL + 'GROUP BY ';
        strSQL := strSQL + '  FDO_CODITE ';

        With qryGenDor Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODEMP').AsString := fCodEmp;
          ParamByName('NUMDOC').AsString := strDocTmp;

          If Not fEmptyStr(qryFatGor.FieldByName('FGO_ESPDOC').AsString) Then
            ParamByName('ESPDOC').AsString := qryFatGor.FieldByName('FGO_ESPDOC').AsString
          Else ParamByName('ESPDOC').AsString := edtEspDoc.Text;

          Open;

          {*****************************************}
          {* TRANSFERENCIA DE ESTOQUE PERMITIDA    *}
          {* SOMENTE PARA CLIENTE FILIAL <> DA     *}
          {* PROPRIA EMPRESA                       *}
          {**************************************AF*}
          If (Pos(strOpcDoc,'TE_OU_') > 0) And (fClienteFilial(qryFatGor.FieldByName('FGO_CODCLI').AsString)) Then
          Begin
            If fRetornaClienteFilial(VS_strCodEmp) = qryFatGor.FieldByName('FGO_CODCLI').AsString Then
            Begin
              fMensagem('', 'Transferência de Estoque não permitida para a própria loja!', ['&O k']);
              pnlInfo.Caption := '';
              Exit;
            End;
          End

          Else If (fClienteFilial(qryFatGor.FieldByName('FGO_CODCLI').AsString)) And
                  (Pos( strOpcDoc, 'TE_VN_VS_CT_PD_OR_OU_CS_' ) <= 0)                               Then
          Begin
            fMensagem('ATENÇÃO!', 'A Utilização de Cliente Filial é permitido somente para Transferência de Estoque, Pedido e Orçamento!', ['&O k']);
            pnlInfo.Caption := '';
            Exit;
          End;

          If Not IsEmpty Then
          Begin
            Try
              fMensagem('ATENÇÃO!', 'Não é permitido vender um item com data de balanço maior ou igual a ' + DateToStr(VS_Date) + '. Verifique!', ['&O k']);

              pCriarFormularios(TfrmFatMostraItemSalBal, frmFatMostraItemSalBal);

              frmFatMostraItemSalBal.strPedOrc := qryFatGor.FieldByName('FGO_ESPDOC').AsString;
              frmFatMostraItemSalBal.strNumPed := qryFatGor.FieldByName('FGO_NUMDOC').AsString;
              frmFatMostraItemSalBal.dbgItens.DataSource := dtsGenDor;
              frmFatMostraItemSalBal.ShowModal;
            Except
              On E: Exception Do
                pMensagensErro(E.Message, '[btnConfirmaDadosClick]');
            End;

            pFreeAndNil(frmFatMostraItemSalBal);

            pnlInfo.Caption := '';
            Exit;
          End;

        End;

        If (Pos(strOpcDoc,'TE_') > 0) And
           (Not fClienteFilial(fCampoTabela('FGO_CODCLI', 'FATGOR', ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'], [strDocTmp, edtEspDoc.Text, strCodEmp]))) Then
        Begin
          fMensagem('ATENÇÃO!', 'Transferência de Estoque é permitida somente para documentos com cliente filial!', ['&O k']);
          pnlInfo.Caption := '';
          Exit;
        End;

      End;

      {*********************************************************}
      {* PESQUISA FATDOR E VERIFICA SE EXISTE ALGUM ITEM       *}
      {* ESPECIAL CADASTRADO, CASO TENHA                       *}
      {* ELE NAO DEIXA EFETUAR A VENDA E MOSTRA OS ITENS       *}
      {******************************************************LB*}
      If (Not fPermiteItemEspecial('VN')) And (Pos(strOpcDoc, 'PD_OR') <= 0) And (Not fEmptyStr(strDocTmp)) Then
      Begin
        strCodEmp := fCodEmp;
        blnItemEspecial := fncExecutaRelatorio(201, 7578, [],
                              ['NUMDOC','ESPDOC','CODEMP'],
                              [strDocTmp,
                              IfThen(Not fEmptyStr(qryFatGor.FieldByName('FGO_ESPDOC').AsString),qryFatGor.FieldByName('FGO_ESPDOC').AsString,edtEspDoc.Text),
                              strCodEmp],
                              nil,
                              nil,
                              True,
                              False);

        if blnItemEspecial then
        Begin
          fMensagem('', 'Existem Itens Especiais no Orçamento/Pedido. Verifique!', ['&O k']);
          pnlInfo.Caption := '';
          Exit;
        End;
      End;

      If fVerificaCampos Then
      Begin

        If (strOpcDoc = 'PD') And (Not fCfgSis('EDPDDS', varBoolean)) Then
        Begin
          If (edtEspDoc.Text='PD') And (fPedidoTemVinculo(edtNumDoc.Text, edtEspDoc.Text, fCodEmp)) Then
          Begin
            fMensagem('ATENÇÃO!', 'O sistema está configurado para não permitir alterar um pedido oriundo de desmembramento, '+
                                'você poderá apenas faturá-lo!', ['&Ok']);
            Exit;
          End;
        End;

        If (Pos(strOpcDoc, 'OR_PD_VN_') > 0) And
           (fCfgSis('SFAPAG', varBoolean))   And
           (Not fEmptyStr(qryFatGor.FieldByName('FGO_NUMPOK').AsString)) Then
        Begin
          strStsPgto := fCampoTabela('STATUS', 'FSSTATUSPEDIDO', ['NUMEROPEDIDO', 'VERIFICADO'], [qryFatGor.FieldByName('FGO_NUMPOK').AsString, 'N']);

          If (Not fEmptyStr(strStsPgto)) Then
          Begin
            If (fStrToSfaStsPagto(strStsPgto) = sspAguardandoPagamento) Or
               (fStrToSfaStsPagto(strStsPgto) = sspPagamentoReprovado)  Then
            Begin
              fMensagem('ATENÇÃO!', 'Este pedido é oriundo de E-commerce, e ainda não teve seu pagamento aprovado.' + sLineBreak +
                                    'Não será permitido nenhuma alteração no mesmo.', ['&OK']);
              Exit;
            End;
          End;
        End;

        {************************************}
        {* SENHA P\ ALTERAÇÃO DO PEDIDO     *}
        {*********************************JB*}
        {If (Not fEmptyStr(edtNumDoc.Text))                  And
           (Not (fEmptyStr(fCfgSis('SENPED', varString))))  Then
        Begin

          pAddDados(arrMenSag, 'Alteração de Pedido');

          If (Not fDig1SenVar(arrMenSag, 'SENPED', True, fCfgSis('SENPED', varString), 'Alteração de Pedido', False,
                      strLoginUsuarioLogado, '', strNTrava)) Then
            Exit;

        End;}

        strNumOrc := qryFatGor.FieldByName('FGO_NUMDOC').AsString;
        strCodTra := qryFatGor.FieldByName('FGO_CODTRA').AsString;
        strTipFre := qryFatGor.FieldByName('FGO_TIPFRE').AsString;

        If (edtEspDoc.Text = 'OR') And (Pos(strOpcDoc, 'OR_VN_') > 0) And (fCfgSis('ALTORC') = 'S') And fVerificaAcessoSistema('ALTORC') Then
        Begin
          If (Not chkHerOrc.Checked) And
             (Not fEmptyStr(qryFatGor.FieldByName('FGO_CODEMP').AsString)) And
             (qryFatGor.FieldByName('FGO_CODEMP').AsString <> VS_strCodEmp) And
             (fMensagem('','Você esta carregando um Orçamento de outra empresa. ' +
                           'Somente será permitido transformar em Pedido/Faturar este documento!' + #13#10 +
                           'Deseja continuar?', ['','']) = 2) Then
          Begin
            pnlInfo.Caption := '';
            pSetFocus(edtNumDoc);
            Exit;
          End;
        End;

        {************************************************************************************}
        {* NÃO É PERMITIDO ALTERAR UM PEDIDO NO QUAL ELE FOI REFERENCIADO EM UM ORÇAMENTO   *}
        {* DE TRANSFERÊNCIA. É NECESSÁRIO CANCELAR O ORÇAMENTO PARA PODER ALTERAR O PEDIDO. *}
        {*********************************************************************************FC*}
        strNumOrcRef := '';
        strEmpOrcRef := '';

        If SameText(edtEspDoc.Text, 'PD')                   And
           SameText(strOpcDoc, 'PD')                        And
           fEhPedidoRefenciadoHaUmOrcamento(edtNumDoc.Text,
                                            edtCodEmp.Text,
                                            strNumOrcRef,
                                            strEmpOrcRef)   Then
        Begin
          pMensagemOk('Não é possível alterar um pedido no qual ele foi referenciado à um orçamento de transferência. ' +
                      'Cancele a OR-' + strNumOrcRef + '-' + strEmpOrcRef + ', para depois alterar este pedido.');
          pnlInfo.Caption := '';
          pSetFocus(edtNumDoc);
          Exit;
        End;

        If (VS_strTipExp <> '1')                                       And
           SameText(edtEspDoc.Text, 'PD')                              And
           SameText(strOpcDoc, 'PD')                                   And
           (Not fEmptyStr(edtNumDoc.Text))                             And
           (Not chkHerOrc.Checked)                                     And
           fPedidoFoiExpedido(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                              qryFatGor.FieldByName('FGO_CODEMP').AsString,
                              qryFatGor.FieldByName('FGO_CODCLI').AsString,
                              False, False, False, '', True)  And
          (Not fPedidoPossuiSomenteItensEntregaFutura(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                                      qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                                      qryFatGor.FieldByName('FGO_CODEMP').AsString)) Then
        Begin

          objLiberacao.Clear;

          objLiberacao.objMsgLibera.pAddTexto('Permitir alterar um pedido no qual ele possui item expedido');
          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.objMsgLibera.pAddTexto('O pedido de venda ' + qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' + 'PD' + '-' + qryFatGor.FieldByName('FGO_CODEMP').AsString);
          objLiberacao.objMsgLibera.pAddTexto('possui item expedido.');


          objLiberacao.strSenFvu := 'V';

          objLiberacao.strDirAce := 'ALTPEDEXP';
          objLiberacao.strMsgSen := 'Permitir alterar um pedido no qual ele possui item expedido';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;

          If (Not objLiberacao.fLibera) Then
          Begin
            pnlInfo.Caption := '';
            pSetFocus(edtNumDoc);
            Exit;
          End;
        End;

        If ( Not SameText(strOpcDoc, 'PD') )                                And
           ( Not fEmptyStr( edtNumDoc.Text ) )                              And
           ( TAdiantamentoGenerico.fRetornaValorBoletosAdiantamento(
                              qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                              qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                              qryFatGor.FieldByName('FGO_CODEMP').AsString,
                              qryFatGor.FieldByName('FGO_CODCLI').AsString) > 0 ) Then
        Begin
          If qryFatGor.FieldByName('FGO_BOLVEN').AsString = 'S' Then
            fMensagem('ATENÇÃO!', 'Esse documento possui ' +
                                  'boleto(s) de adiantamento. '+ #13#10+
                                  'Utilizar rotina de Expedição para Faturar o mesmo!', ['&OK'])
          Else
            fMensagem('ATENÇÃO!', 'Esse documento possui ' +
                                  'boleto de adiantamento '+
                                  'que ainda não foi baixado pela '+
                                  'remessa bancária!', ['&OK']);
          pSetFocus(edtNumDoc);
          pnlInfo.Caption := '';
          Exit;
        End;

        If SameText(edtEspDoc.Text, 'PD')                                   And
           ( Not fEmptyStr( edtNumDoc.Text ) )                              And
           (TAdiantamentoGenerico.fRetornaValorBoletosAdiantamentoJaEnviados(
                              qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                              qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                              qryFatGor.FieldByName('FGO_CODEMP').AsString,
                              qryFatGor.FieldByName('FGO_CODCLI').AsString) > 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido alterar um pedido com boleto(s) '+
            'de adiantamento já enviado(s) para o banco!', ['&Ok']);
          pSetFocus(edtNumDoc);
          pnlInfo.Caption := '';
          Exit;
        End;

        If SameText(edtEspDoc.Text, 'PD')                                   And
           ( Not fEmptyStr( edtNumDoc.Text ) )                              And
           (fDocParcialmenteFat(edtNumDoc.Text, edtEspDoc.Text, strCodEmp)) And
           (TAdiantamentoGenerico.fRetornaValorBoletosAdiantamentoJaImpressos(
                              qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                              qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                              qryFatGor.FieldByName('FGO_CODEMP').AsString,
                              qryFatGor.FieldByName('FGO_CODCLI').AsString) > 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido alterar um pedido que possui faturamento '+
            'parcial e boleto(s) de adiantamento já impresso(s)!', ['&Ok']);
          pSetFocus(edtNumDoc);
          pnlInfo.Caption := '';
          Exit;
        End;

        If SameText(edtEspDoc.Text, 'PD')                                   And
           SameText(strOpcDoc, 'PD')                                        And
           ( Not fEmptyStr( edtNumDoc.Text ) )                              And
           ( TAdiantamentoGenerico.fRetornaValorBoletosAdiantamentoJaImpressos(
                              qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                              qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                              qryFatGor.FieldByName('FGO_CODEMP').AsString,
                              qryFatGor.FieldByName('FGO_CODCLI').AsString) > 0 ) Then
        Begin

          if not fCfgSis('ALPDBO', varBoolean) then
          Begin
            fMensagem('Atenção', 'Não é permitido alterar um pedido que possui boleto de adiantamento já impresso!', ['&Ok']);
            Exit;
          End;

          objLiberacao.Clear;

          objLiberacao.objMsgLibera.pAddTexto('Permitir alterar pedido com boleto de adiantamento já impresso');
          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.objMsgLibera.pAddTexto('O pedido de venda ' + qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                              'PD' + '-' + qryFatGor.FieldByName('FGO_CODEMP').AsString);
          objLiberacao.objMsgLibera.pAddTexto('possui boleto de adiantamento já impresso.');


          objLiberacao.strSenFvu := 'V';

          objLiberacao.strDirAce := 'ALTPEDBOLADT';
          objLiberacao.strMsgSen := 'Permitir alterar pedido com boleto de adiantamento já impresso';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;

          If (Not objLiberacao.fLibera) Then
          Begin
            pnlInfo.Caption := '';
            pSetFocus(edtNumDoc);
            Exit;
          End;
        End;

        If Not ValidacoesPedidoComPixGerado Then
        Begin
          pnlInfo.Caption := '';
          pSetFocus(edtNumDoc);
          Exit;
        End;

        {*****************************************}
        {* TRAVA O ORÇAMENTO PARA QUE OUTRA      *}
        {* ESTACAO NAO PEGUE                     *}
        {**************************************MA*}
        If ( Pos( strOpcDoc, 'PD_OR_VN_VS_TE_OU_CS_ER_' ) > 0 ) And ( Not fEmptyStr( edtNumDoc.Text ) ) Then
        Begin

          {***************************************************}
          {* SE O TIPO DE EXPEDIÇÃO FOR POR PEDIDO(OPÇÃO 4)  *}
          {* E O PEDIDO NÃO FOI EXPEDIDO, NÃO DEIXA FATURAR. *}
          {************************************************PZ*}
          If (VS_strTipExp = '4')                                                    And
             (strOpcDoc <> 'PD')                                                     And
             (qryFatGor.FieldByName('FGO_ESPDOC').AsString = 'PD')   And
             (Not fPedidoFoiExpedido(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                     qryFatGor.FieldByName('FGO_CODEMP').AsString,
                                     qryFatGor.FieldByName('FGO_CODCLI').AsString,
                                     True,
                                     (strOpcDoc = 'VN'))) Then
          Begin
            fMensagem('ATENÇÃO!', 'O pedido deve ser expedido antes de faturar!', ['&O k']);
            pnlInfo.Caption := '';

            pSetFocus(edtNumDoc);

            Exit;
          End;

          If Not fBloqueiaPedido(qryFatGor) Then
          Begin
            pSetFocus(edtNumDoc);
            Exit;
          End;

        End;

        If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtEspDoc.Text)) Then
        Begin
          If (Pos(edtEspDoc.Text, 'OR_PD_') > 0) Then
          Begin
            If fTravaFatDorMenor(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                 qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                 qryFatGor.FieldByName('FGO_CODEMP').AsString) Then
            Begin
              fMensagem('ATENÇÃO!','Ainda não é permitido realizar a alteração deste documento '+
                                   'pois os produtos não foram replicados totalmente. Por favor, '+
                                   'aguarde alguns minutos e tente novamente mais tarde.', ['&OK']);
              pSetFocus(edtNumDoc);
              pnlInfo.Caption := '';
              Exit;
            End;

            if fTemFatDorSemExtDor(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                   qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                   qryFatGor.FieldByName('FGO_CODEMP').AsString,
                                   LMensagem) then
            begin
              fMensagem('ATENÇÃO!', LMensagem, ['&OK']);
              pSetFocus(edtNumDoc);
              pnlInfo.Caption := '';
              Exit;
            end;

          End;
        End;

        If (strOpcDoc <> 'CS') and (fEhPedidoOriginadoPelaConsignacao(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text)) Then
        Begin
          pMensagemOk('Pedido criado a partir da rotina de envio de consignação. Para alterá-lo somente por esta rotina!');
          Exit;
        End;

        If (Not fVerificaSeTemAcessoVerCli(qryFatGor.FieldByName('FGO_CODCLI').AsString, strOpcDoc)) And (Not fPermiteSelecionarClienteDeOutroVendedor(strOpcDoc)) Then
        Begin
          pMensagemOk('O operador não tem direito de acesso às informações do cliente deste pedido (VERCLI)!');
          Exit;
        End;

        If Not fPermiteFaturarRemessaContaOrdem(False, qryFatGor.FieldByName('FGO_TIPOPE').AsString) Then
          Exit;

        If (qryFatGor.FieldByName('FGO_TIPOPE').AsString = 'C') Then
        Begin
          If fExisteDocumentoContaOrdemComRemessaNaoFaturada(qryFatGor.FieldByName('AUTOINCREM').AsString) Then
            Exit;
        End;

        {*****************************************}
        {* SE FOR VENDA NORMAL E ESTIVER         *}
        {* CARREGANDO UM PEDIDO, VERIFICA SE     *}
        {* O PEDIDO JA FOI LIBERADO. SE JA FOI   *}
        {* LIBERADO, NAO DEIXA CARREGAR          *}
        {**************************************MV*}
        Try
          if Assigned(frmFatVendas) then
            pFreeAndNil(frmFatVendas);

          pCriarFormularios(TfrmFatVendas, frmFatVendas);

          {Comanda}
          if (blnBarCom_NovoPedido) then
            frmFatVendas.strBarCom_NovoPedido := edtBarCom.Text
          else
            frmFatVendas.strBarCom_NovoPedido := '';

          If Not frmFatVendas.blnFecharForm Then
          Begin

            frmFatVendas.blnGravarDavPv := False;
            frmFatVendas.blnApenasPrazo := blnApenasPrazo;
            frmFatVendas.blnApenasVista := blnApenasVista;
            frmFatVendas.qryFatGor := qryFatGor;
            frmFatVendas.strOpcDoc := strOpcDoc;

            If (Pos(strOpcDoc, 'OR_PD_') > 0) And (Not fEmptyStr(strNumOrc)) Then
              frmFatVendas.strTitulo := Caption + ' - ' + strNumOrc + '-' + strOpcDoc
            Else
            Begin
              If (Pos(strOpcDoc ,'VN_VS_CS_ER_') > 0) And (Not fEmptyStr(strNumOrc)) Then
                frmFatVendas.strTitulo := Caption + ' - ' + strNumOrc + '-' + qryFatGor.FieldByName('FGO_ESPDOC').AsString
              Else
                frmFatVendas.strTitulo := Caption;
            End;

            If chkHerOrc.Checked Then
            Begin
              frmFatVendas.strTitulo := frmFatVendas.strTitulo + ' - HERANÇA DE ORÇAMENTO / PEDIDO';
              frmFatVendas.blnHerancaOrcamentoPedido := True;
            End;

            frmFatVendas.strNumOrc := strNumOrc;
            frmFatVendas.strEspOrc := qryFatGor.FieldByName('FGO_ESPDOC').AsString;
            frmFatVendas.strEmpOrc := IIF(fEmptyStr(strNumOrc),'',edtCodEmp.Text);
            frmFatVendas.blnGravarComo := blnGravarComo;

            strOrcDoc := strNumOrc;
            strOrcEsp := qryFatGor.FieldByName('FGO_ESPDOC').AsString;
            frmFatVendas.strCodCliDef := strCodCliDef;
            frmFatVendas.strProspe := strProspe;
            frmFatVendas.strNLeads := strNLeads;
            frmFatVendas.blnEstouNoCrm := blnEstouNoCrm;
            frmFatVendas.strCliCgc := strCgcCpf;

            //Quando vem atraves da rotina de CRM > Clientes
            If Not fEmptyStr(strCodCliDef) And fCfgSis('IDEEMP', VarBoolean) And fCfgSis('EMPFAT', VarBoolean) Then
            Begin
              //Define a empresa usada como sugestao no campo de empresa do produto
              frmFatVendas.strCodEmpDef := fCampoTabela('CLI_EMPIDE', 'CADCLI', ['CLI_CODCLI'], [strCodCliDef]);
            End;

            frmFatVendas.ShowModal;
          End;

          strNumOrcPedAbrir := frmFatVendas.strNumOrcPedAbrir;
          strEspOrcPedAbrir := frmFatVendas.strEspOrcPedAbrir;
          strCodCliDef      := frmFatVendas.strCodCliDef;
          strProspe         := frmFatVendas.strProspe;
          strCodCliGravado  := frmFatVendas.strCodCliGravado;
          strCodDig         := frmFatVendas.strCodDigGravado;
          strCodVen         := frmFatVendas.strCodVenGravado;
          blnFaturarF11Finalizar := frmFatVendas.blnFaturarF11Finalizar;
          strAutoIncPedidosGerados := frmFatVendas.strAutoIncPedidosGerados;
          blnTravaFaturamentoF11:= frmFatVendas.blnTravaFaturamentoF11;

          If blnFaturarF11Finalizar Then
          Begin
            strNumOrc := frmFatVendas.strNumDocGravado;
            strCodEmp := frmFatVendas.strCodEmpGravado;
          End;

          //blnNotaTrans := frmFatVendas.blnNotaTrans;
          //strDocume := frmFatVendas.strNumDocGra;
          //strEspeci := frmFatVendas.strEspDocGra;
          //fatVenda := frmFatVendas.fatVenda;

          pFreeAndNil(frmFatVendas);

          If Not fEmptyStr(strNumOrcPedAbrir) And
             Not fEmptyStr(strEspOrcPedAbrir) Then
          Begin
            Self.blnFecharForm := True;
            Self.Repaint;
          End;

        Except
          on E: ExceptionAutcom do
            pMensagemOk(E.Message);

          On E: Exception Do
            pMensagensErro(E.Message, '[btnConfirmaDadosClick]');
        End;

        If Pos(strOpcDoc, 'OR_PD_VN_TE_') > 0 Then
        Begin
          pGeraTransferencias;
          pGeraRequisicoesCompra;
        End;

      End;

    Finally
      {*****************************************}
      {* DESTRAVA O ORÇAMENTO                  *}
      {**************************************MA*}
      If ( Pos( strOpcDoc, 'PD_OR_VN_CS_VS_TE_OU_ER_' ) > 0 ) And ( Not fEmptyStr( edtNumDoc.Text ) ) Then
      Begin
        pLiberaBloqueioPedido(qryFatGor);
      End;

      edtBarCom.Clear;
      edtNumDoc.Clear;

      pInicializarQryFatGor;

      If (Pos(strOpcDoc,'VN_VS_CS_') > 0) And fCfgSis('USAPDV', varBoolean) Then
        edtEspDoc.Clear;

      pEnableEdits(True);

      if fExibirCampoComanda then
        pSetFocus(edtBarCom)
      else
        pSetFocus(edtNumDoc);

      blnMudarFoco := True;

      pnlInfo.Caption := '';

      if Assigned(qryGenDor) then
      begin
        qryGenDor.Close;
        FreeAndNil(dtsGenDor);
        FreeAndNil(qryGenDor);
      end;

      InterlockedDecrement(intSemaforo);

      {*************************}
      {* ROTINA USADA PELO CRM *}
      {**********************FS*}
      If not fEmptyStr(strCodCliDef) Then
      Begin
        Self.blnFecharForm := True;
        Self.Repaint;
      End;
    End;

  End
  Else
    InterlockedDecrement(intSemaforo);

  If blnFaturarF11Finalizar Then
  Begin
    If fValidaCodigoCaixa(IIF(fCfgSis('USADIG', varBoolean), strCodDig, strCodVen), strCodCax) Then
    Begin
      Self.Close;
      qryFatDorGerados := fCriaQuery(Self);
      qryFatDorGerados.Close;
      qryFatDorGerados.SQL.Clear;
      qryFatDorGerados.SQL.Text := 'SELECT F.FGO_CODEMP, F.FGO_NUMDOC FROM FATGOR F WHERE F.AUTOINCREM IN ('+strAutoIncPedidosGerados+')';
      qryFatDorGerados.Open;
      objResumoDeCaixa := TResumoDeCaixa.Create(fCfgSis('TPFCCX'));

      Try
        qryFatDorGerados.First;
        While Not qryFatDorGerados.Eof Do
        Begin
          pCriarFormularios(TfrmFatConfOrcamentos, frmFatConfOrcamentos);
          Try
            frmFatConfOrcamentos.strCodOpe  := strLoginUsuarioLogado;
            frmFatConfOrcamentos.objResumoDeCaixa := objResumoDeCaixa;
            frmFatConfOrcamentos.strNumDocImportadoPedOrc := qryFatDorGerados.FieldByName('FGO_NUMDOC').AsString;
            frmFatConfOrcamentos.strEmpres :=   qryFatDorGerados.FieldByName('FGO_CODEMP').AsString;
            frmFatConfOrcamentos.strCodigoCaixa := strCodCax;
            frmFatConfOrcamentos.blnRcxF11 := False;
            frmFatConfOrcamentos.blnObrigarExpedirAntesDeFaturar := (Not fCfgSis('F11FPD', varBoolean));
            frmFatConfOrcamentos.blnTravaFaturamentoF11 := blnTravaFaturamentoF11;
            frmFatConfOrcamentos.ShowModal;
          Finally
            pFreeAndNil(frmFatConfOrcamentos);
          End;

          qryFatDorGerados.Next;
        End;
      Finally

        FreeAndNil(qryFatDorGerados);
      End;

      FreeAndNil(objResumoDeCaixa);
    End;
  End;
end;

function TfrmFatDigDocumento.fValidaCodigoCaixa(strCodOpe: String; var strCodCax: String):Boolean;
begin
  Result := True;

  If (fCfgSis('TPFCCX') = 'C') Then
  Begin
    strCodCax := fCampoTabela('OPE_CODCAX', 'CADOPE', ['OPE_CODOPE'], [strCodOpe]);
    If (fEmptyStr(strCodCax)) Then
    Begin
      pMensagemOk('O operador '+strCodOpe+'-'+fRetNomVendRep(strCodOpe)+' '+sLineBreak+
                 'não possui caixa vinculado e por isso, não será possível '+sLineBreak+
                 'abrir o documento já carregado no F11 para faturamento '+sLineBreak+
                 'conforme configurado (CFG_F11FPD). Vincule o código do '+sLineBreak+
                 'caixa ao operador na aba "Geral" do cadastro e '+sLineBreak+
                 'depois tente novamente.');
      Result := False;
    End;
  End;
end;

procedure TfrmFatDigDocumento.GeraDocumentoRemessaDevolucao;
var
  FObjRemessaDevolucao: TRemessaDevolucao;
begin
  FObjRemessaDevolucao := TRemessaDevolucao.Create;

  try
    FObjRemessaDevolucao.pAbreTransferenciaEstoque(edtRemessaDevolucao.Text);
  finally
    FObjRemessaDevolucao.Free;
  end;
end;

procedure TfrmFatDigDocumento.FormShow(Sender: TObject);
begin
  inherited;
  pIniciaTela;

  SetForegroundWindow(Self.Handle);
end;

procedure TfrmFatDigDocumento.pInicializarQryFatGor;
  Var
    strSQLFatGor : String;
begin
  If Assigned(qryFatGor) Then
  Begin
    qryFatGor.Close;
    FreeAndNil(qryFatGor);
  End;

  strSQLFatGor := EmptyStr;
  strSQLFatGor := strSQLFatGor + fSelectFromFatgorLeftAuxiliares(False);
  strSQLFatGor := strSQLFatGor + ' WHERE FALSE';

  qryFatGor := fCriarQuery(strSQLFatGor, Self);
end;

procedure TfrmFatDigDocumento.pIniciaTela;
begin

  If Pos(strOpcDoc, 'OR_PD_VN_TE_') > 0 Then
  Begin
    pGeraTransferencias;
    pGeraRequisicoesCompra;
  End;

  edtCodEmp.Text := VS_strCodEmp;
  strCodEmp      := VS_strCodEmp;

  If SameText(strOpcDoc, 'OF') Then
    edtNumDoc.TamCampo := fTamNumDoc
  Else
    edtNumDoc.TamCampo := fTamDocCadRec;

  edtNumDoc.MaxLength := edtNumDoc.TamCampo;

  If Pos(strOpcDoc, 'VN_VS_TE_OU_OF_CS_ER_EM_') <= 0 Then
  Begin
    edtEspDoc.ReadOnly := True;
    edtEspDoc.TabStop  := False;
    edtEspDoc.Text     := strOpcDoc;
  End
  Else If (Not fCfgSis('USAPDV', varBoolean)) Then
  Begin
    edtEspDoc.ReadOnly := True;
    edtEspDoc.TabStop  := False;
    edtEspDoc.Text     := 'OR';
  End;

  If Pos(strOpcDoc, 'TE_') > 0 Then
  Begin
    edtEspDoc.ReadOnly := True;
    edtEspDoc.TabStop  := False;
    edtEspDoc.Text     := 'OR';
  End;

  If Pos(strOpcDoc, 'PR_') > 0 Then
  Begin
    edtEspDoc.ReadOnly := True;
    edtEspDoc.TabStop  := False;
    edtEspDoc.Text     := 'PR';
  End;

  If Pos(strOpcDoc, 'EM_ER_') > 0 Then
  Begin
    edtEspDoc.ReadOnly := True;
    edtEspDoc.TabStop  := False;
    edtEspDoc.Text     := 'PD';
  End;

  pMostrarEmpresa;

  {Herança}
  pnlHeranca.Visible := fCfgSis('HERORC', varBoolean) And ((strOpcDoc = 'OR') Or (strOpcDoc = 'PD'));

  If Not pnlHeranca.Visible Then
  Begin
    chkHerOrc.Checked := False;
    Self.Height := Self.Height - pnlHeranca.Height;
  End;

  {Remessa Devolucao}
  pnlRemessaDevolucao.Visible := ((fCfgSis('UTIRRD', varBoolean)) And (Pos(strOpcDoc, 'TE_') > 0));

  If Not pnlRemessaDevolucao.Visible then
    Self.Height := (Self.Height - pnlRemessaDevolucao.Height);

  {Comanda}
  if fExibirCampoComanda then
  begin
    pnlComanda.Visible := True;
  end
  else
  begin
    pnlComanda.Visible := False;
    Self.Height        := (Self.Height - pnlComanda.Height);
  end;

  If Not fEmptyStr(Self.strNumOrcPedAbrir) And
     Not fEmptyStr(Self.strEspOrcPedAbrir) Then
  Begin
    With TNewTimer.Get(Self.Name + '.tmrAbrirPedido') Do
    Begin
      Interval := 100;
      OnTimer  := tmrAbrirPedidoTimer;
      Enabled  := True;
    End;
  End
  {*************************}
  {* ROTINA USADA PELO CRM *}
  {**********************AC*}
  Else If (Pos(strOpcDoc, '_VN_') = 0) And (Not fEmptyStr(strCodCliDef)) And
          (Not blnForcarAbrirDigDocumento) Then
    btnConfirmaDadosClick(Self);
end;

function TfrmFatDigDocumento.fExibirCampoComanda: Boolean;
begin
  Result := fCfgSis('COMAND', varBoolean) And ((strOpcDoc = 'PD') Or (strOpcDoc = 'VN'));
end;

function TfrmFatDigDocumento.fPermiteAlterarPedidoComLoteSeparacaoRomaneio: Boolean;
begin
  Result := True;

  If fCfgSis('PAPAIL', varBoolean) Then
    Exit;

  If fEmptyStr(edtNumDoc.Text) Then
    Exit;

  If strOpcDoc <> 'PD' Then
    Exit;

  If fEmptyStr(fRetLoteSeparacao(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text)) Then
    Exit;

  Result := False;
end;

function TfrmFatDigDocumento.fTemMovimentacaoProgramadaVinculadaNoPedido(
  strNumDoc, strEspDoc, strEmpDoc: String): Boolean;
var
  QryMovimentacao: TUniQuery;
begin
  Result := False;

  if strEspDoc <> 'PD' then
    Exit;

  if fEmptyStr(strNumDoc) then
    Exit;

  if fEmptyStr(strEmpDoc) then
    Exit;

  QryMovimentacao := fCriaQuery;

  try
    QryMovimentacao.Close;
    QryMovimentacao.SQL.Clear;
    QryMovimentacao.SQL.Add('SELECT M.AUTOINCREM ');
    QryMovimentacao.SQL.Add('FROM FATGOR F');
    QryMovimentacao.SQL.Add('INNER JOIN MOVLOT M');
    QryMovimentacao.SQL.Add('ON(F.AUTOINCREM = M.MLT_SEQFGO)');
    QryMovimentacao.SQL.Add('WHERE F.FGO_NUMDOC = :NUMDOC');
    QryMovimentacao.SQL.Add('AND F.FGO_CODEMP = :EMPDOC');
    QryMovimentacao.SQL.Add('AND F.FGO_ESPDOC = :ESPDOC');
    QryMovimentacao.SQL.Add('AND M.MLT_DTAREA IS NULL');
    QryMovimentacao.SQL.Add('AND M.MLT_HRAREA IS NULL');

    QryMovimentacao.ParamByName('NUMDOC').AsString := strNumDoc;
    QryMovimentacao.ParamByName('EMPDOC').AsString := strEmpDoc;
    QryMovimentacao.ParamByName('ESPDOC').AsString := strEspDoc;

    QryMovimentacao.Open;

    Result := Not QryMovimentacao.IsEmpty;
  finally
    FreeAndNil(QryMovimentacao);
  end;
end;

function TfrmFatDigDocumento.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        If (Pos(strOpcDoc, 'VN_VS_TE_OU_CS_') > 0) And (blnBuscaPorChave) Then
        Begin
          btnConfirmaDados.Click;
          blnMudarFoco := False;
        End;
      End;
    End
    Else If (Sender = edtEspDoc) Then
    Begin
      pInicializarQryFatGor;
      Result := TFatVenda.fValidaUtilizarPedidoOrcamento(edtNumDoc.Text, edtEspDoc.Text, fCodEmp, strOpcDoc, qryFatGor, chkHerOrc);
      If (Not Result) And (edtEspDoc.ReadOnly) Then
         Sender := edtNumDoc;
    End;
  End;
  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigDocumento.pEnableEdits(blnEnable: Boolean);
begin
  edtNumDoc.Enabled := blnEnable;
  edtEspDoc.Enabled := blnEnable;
  edtBarCom.Enabled := blnEnable;
end;

procedure TfrmFatDigDocumento.pMostrarEmpresa;
begin
  edtCodEmp.Visible  := False;
  edtCodEmp.Enabled  := False;

  If Pos(strOpcDoc, 'TE_OU_PR_') > 0 Then
  Begin
    edtCodEmp.Visible  := True;
    edtCodEmp.Enabled  := True;
  End;

  If (Pos(strOpcDoc, 'OR_VN_') > 0) And fCfgSis('ALTORC', VarBoolean) And fVerificaAcessoSistema('ALTORC') Then
  Begin

    If (strOpcDoc = 'OR') Then
    Begin
      edtCodEmp.Visible  := True;
      edtCodEmp.Enabled  := True;
    End;

    If (strOpcDoc = 'VN') Then
    Begin
      edtCodEmp.Visible  := (edtEspDoc.Text = 'OR');
      edtCodEmp.Enabled  := (edtEspDoc.Text = 'OR');

      If (edtEspDoc.Text <> 'OR') Then
      Begin
        edtCodEmp.Text := VS_strCodEmp;
        strCodEmp      := VS_strCodEmp;
      End;
    End;

  End;
end;

procedure TfrmFatDigDocumento.tmrAbrirPedidoTimer(Sender: TObject);
begin
  inherited;
  TNewTimer.Del(Self.Name + '.tmrAbrirPedido');

  If Not fEmptyStr(Self.strNumOrcPedAbrir) And
     Not fEmptyStr(Self.strEspOrcPedAbrir) Then
  Begin
    edtNumDoc.Text := Self.strNumOrcPedAbrir;
    edtEspDoc.Text := Self.strEspOrcPedAbrir;

    Self.strNumOrcPedAbrir := '';
    Self.strEspOrcPedAbrir := '';

    btnConfirmaDadosClick(Self);
  End;
end;

function TfrmFatDigDocumento.ValidacoesPedidoComPixGerado: Boolean;
  Var
    LStatusPix: String;

    LDatasetPix: TUniClientDataset;
begin
  Result := True;

  LStatusPix :=  TPixDao.RetornaStatusSePedidoPossuirPix(qryFatGor.FieldByName('FGO_EMPPIX').AsString,
                                                         qryFatGor.FieldByName('FGO_TX_PIX').AsString);

  If LStatusPix.IsEmpty Then
    Exit;

  If MatchStr(LStatusPix, STATUS_PIX_PAGO) Then
  Begin
    if (fCfgSis('ALPDPX', varString) = 'N') or (strOpcDoc <> 'PD') then
    begin
      fMensagem('ATENÇÃO', 'Não é permitido alterar um pedido que possui Pix que já foi pago!', ['&Ok']);

      Exit(False);
    end
    else
    begin
      objLiberacao.Clear;

      objLiberacao.objMsgLibera.pAddTexto('Permitir Alterar Pedido de Venda com Adiantamento via PIX realizado');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTexto('Pedido............: ' + qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' + 'PD' + '-' + qryFatGor.FieldByName('FGO_CODEMP').AsString);
      objLiberacao.objMsgLibera.pAddTexto('Cliente...........: ' + qryFatGor.FieldByName('FGO_CODCLI').AsString + ' - ' + fRetNomCliente(qryFatGor.FieldByName('FGO_CODCLI').AsString));
      objLiberacao.objMsgLibera.pAddTexto('Total PIX: ' +  FormatFloat('#,##0.00', qryFatGor.FieldByName('FGO_VLRCON').AsFloat));
      objLiberacao.strSenFvu := 'V';
      objLiberacao.strDirAce := 'ALTPEDPIXADT';
      objLiberacao.strMsgSen := 'Permitir Alterar Pedido de Venda com Adiantamento via PIX realizado';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      If (Not objLiberacao.fLibera) Then
        Exit(False);
    end ;
  End
  Else If (strOpcDoc = 'VN') And
          (Not fCfgSis('BAIAVI', varBoolean))  Then
  Begin
    fMensagem('ATENÇÃO', 'Não é permitido faturar um pedido que possui Pix ativo quando a configuração CFG_BAIAVI estiver como "Não".' + #13 +
                         'O pedido só poderá ser aberto pela opção Venda Normal se sua condição de pagamento for modificada.', ['&Ok']);

    Exit(False);
  End
  Else
  Begin
    If TPixDao.PixGeradoEmPedidosDesmembrados(qryFatGor.FieldByName('FGO_EMPPIX').AsString,
                                              qryFatGor.FieldByName('FGO_TX_PIX').AsString) Then
    Begin
      fMensagem('ATENÇÃO', 'Não é permitido alterar um pedido desmembrado que possui Pix ativo.', ['&Ok']);

      Exit(False);
    End;

    If strOpcDoc <> 'VN' Then
    Begin
      If fMensagem('ATENÇÃO', 'Esse pedido possui um Pix gerado ao cliente e ainda ativo. ' + #13 +
                              'Deseja realizar a leitura do QRCode do Pix?', ['&Sim', '&Não'], 2) = 1 Then
      Begin
        If (Not fLock_Unlock('FATGOR' + qryFatGor.FieldByName('FGO_NUMDOC').AsString +
                                       qryFatGor.FieldByName('FGO_ESPDOC').AsString +
                                       qryFatGor.FieldByName('FGO_CODEMP').AsString,
                            True, False)) Or
           (Not fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + qryFatGor.FieldByName('FGO_TX_PIX').AsString,
                            True, False)) Then
        Begin
          fMensagem('ATENÇÃO', 'A leitura do QRCode do Pix não pode ser realizada pois o pedido está aberto em outra estação.', ['&Ok']);

          Exit(False);
        End;

        Try
          LDatasetPix := TPixDao.RetornaDadosDoPix(qryFatGor.FieldByName('FGO_TX_PIX').AsString,
                                                   qryFatGor.FieldByName('FGO_EMPPIX').AsString);

          If MatchStr(LDatasetPix.FieldByName('MPX_STATUS').AsString, STATUS_PIX_PAGO) Then
          Begin
            fMensagem('ATENÇÃO', 'Não é permitido alterar um pedido que possui Pix que já foi pago!', ['&Ok']);

            Exit(False);
          End;

          TFuncoesPixAutcom.PagarPixViaPorQRCode(LDatasetPix,
                                                 Self.Name,
                                                 False,
                                                 'CTR',
                                                 'FATGOR' + qryFatGor.FieldByName('FGO_NUMDOC').AsString +
                                                            qryFatGor.FieldByName('FGO_ESPDOC').AsString +
                                                            qryFatGor.FieldByName('FGO_CODEMP').AsString);

        Finally
          fLock_Unlock('FATGOR' + qryFatGor.FieldByName('FGO_NUMDOC').AsString +
                                  qryFatGor.FieldByName('FGO_ESPDOC').AsString +
                                  qryFatGor.FieldByName('FGO_CODEMP').AsString,
                       False, False);
          fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + qryFatGor.FieldByName('FGO_TX_PIX').AsString,
                       False, False);


          FreeAndNil(LDatasetPix);
        End;

        Exit(False);
      End;

      If fMensagem('ATENÇÃO', 'Esse pedido possui um Pix gerado ao cliente e ainda ativo. ' +
                              'O pedido só poderá ser alterado se sua condição de pagamento for modificada.' + #13 +
                              'Deseja continuar?', ['&Sim', '&Não'], 2) = 2 Then
        Exit(False);


      objLiberacao.Clear;

      objLiberacao.objMsgLibera.pAddTexto('Permitir alterar a condição de pagamento de um pedido com Pix gerado e ativo.');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTexto('O pedido de venda ' + qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                          'PD' + '-' + qryFatGor.FieldByName('FGO_CODEMP').AsString);
      objLiberacao.objMsgLibera.pAddTexto('possui um Pix gerado ao cliente e ainda ativo.');


      objLiberacao.strSenFvu := 'V';

      objLiberacao.strDirAce := 'ALTPEDPIXATV';
      objLiberacao.strMsgSen := 'Permitir alterar a condição de pagamento de um pedido com Pix gerado e ativo';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      If (Not objLiberacao.fLibera) Then
        Exit(False);
    End;
  End;
end;

procedure TfrmFatDigDocumento.FormCreate(Sender: TObject);
begin
  inherited;
  Self.blnFecharForm := False;

  objLiberacao := TLiberacao.Create;

  pInicializarQryFatGor;
  utcRegistros.Limpar(Self.Name + 'FATGOR');
  intSemaforo := -1;
  blnGravarComo := True;
  strProspe := '';
  blnEstouNoCrm := False;
  blnForcarAbrirDigDocumento := False;
end;

procedure TfrmFatDigDocumento.FormDestroy(Sender: TObject);
begin
  If Assigned(qryFatGor) Then
  Begin
    qryFatGor.Close;
    FreeAndNil(qryFatGor);
  End;

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited;  
end;

procedure TfrmFatDigDocumento.FormPaint(Sender: TObject);
begin
  inherited;
  If Self.blnFecharForm Then
    Close;
end;

end.


