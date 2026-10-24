unit untFatBaixaPedidoDev;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, strUtils,
  untFuncFat, untTypesSistema,
  BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, untTLock, untLiberacao;

type
  TfrmFatBaixaPedidoDev = class(TfrmPaiOrdena)
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label3: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label1: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label4: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure mskDtaIniEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fatVenda : TFatVenda;
    qryCadCli: TUniQuery;
    strEspSel: String;
    objLock: TLock;
    objLiberacao: TLiberacao;
    Function fSqlFatDor: String;
    Procedure pSetTipoFaturamento(fatVenda: TFatVenda);

    procedure pCarregaCliente;
    procedure pInicializaTemporaria;
    procedure pConfirma;
    function fRetCndDocOriginal(strDoc, strEsp, strEmp, strIte: String): String;
    function fValidaCndDocsSelecionados : Boolean;
    procedure pCarregaDadosClienteConsumidor;
    function fRetAlqOrgDemaisImpostos(strIncDev, strDocDev, strEspDev, strEmpDev, strCodIte: String): TAlqOrgDemaisImpostos;

    procedure pVerificaTrocaCliente;
    procedure pGeracaoEntradaMercadoriaDevolucao;
    procedure pBaixaFatGor(strNumFat, strEspFat: String);
    function fDesconsiderarFreteNoTotalCadRec: Boolean;
    function fRetItensEntradaMercadoriaDev: String;
    function fSQLItensPedidoDev: String;
    function fSQLCadastroItem: String;
    procedure pDestruirCdsVenda;
    procedure pRetornaValoresImpostos(strAutIncVenda, strTabelaVenda: String; AfltQtdEntrada: Double; out AfltBFCPST, AfltPFCPST, AfltVFCPST: Double);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    Function fIncluiItens(fatVenda: TFatVenda; var strTipFre: string; var fltValFre: Double; var fltDesAce: Double; var fltDesEsp: Double): Boolean;
    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
    function fSetParametros: Boolean; Override;
    procedure pAddListaQuery; Override;
    function fTravaPedido: Boolean;
    function fPedidosJaFaturados: Boolean;

  end;


implementation

uses untFatTipoFaturamento, untFuncoesSimples, untGravando,
     untConsultas,untPesqAux, untFuncFatTypes, untFuncoes, untMadeireira,
     untDuplicatas, untFatDadosFiscais, untFatTrocaCliente, untEntMercadorias,
     untDigOcorrencia;

{$R *.dfm}

procedure TfrmFatBaixaPedidoDev.pConfirma;
  Var
    blnConfirma: Boolean;
    strTipFre: String;
    fltValFre,
    fltDesAce,
    fltDesEsp: Double;
    fltVlrDup: Double;
    intConfirmando: Integer;
    intOpcao: Integer;
    strPermiteAltCliente: String;
begin
  Try
    If Not cdsConsulta.Active Then
      Exit;

    If (stlListSelecao.Count = 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Selecione os documentos para baixa!', ['&Ok']);
      exit;
    End;

    If Not fClientePessoaFisica(edtCodCliente.Text) Then
    Begin
      intOpcao := fGetMenu('Escolha o Tipo de Devolução', ['Devolução', 'Entrada de Mercadoria - Devolução', 'Sair'], 1);

      If (intOpcao In [2, 3]) Then
      Begin
        If intOpcao = 2 Then
          pGeracaoEntradaMercadoriaDevolucao;

        Exit;
      End;
    End;

    fltValFre:=0;
    fltDesAce:=0;
    fltDesEsp:=0;

    pnlHeader.Enabled := False;

    cdsConsulta.DisableControls;

    fatVenda.pCarregaDadosClienteBaixa(edtCodCliente.Text);

    cdsConsulta.First;
    cdsConsulta.Locate('AUTOINCREM', stlListSelecao.Strings[0], []);

    pCarregaInformacoesPedidoDevRetira(fatVenda,
                                       cdsConsulta.FieldByName('CODEMP').AsString,
                                       cdsConsulta.FieldByName('NUMDOC').AsString,
                                       cdsConsulta.FieldByName('ESPDOC').AsString);

    pInicializaTemporaria;

    fatVenda.blnBaiPedDev := True;

    fatVenda.strCodVen := fatVenda.strCodOpe;
    fatVenda.strCodDig := fatVenda.strCodOpe;
    fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
    fatVenda.strNomDig := fRetNomVendRep(fatVenda.strCodDig);
    fatVenda.blnDevolucaoEmpresaAbastecimento := (cdsConsulta.fieldbyname('PERDAD').asstring <> 'DEVOLUCAO');

    blnConfirma := fIncluiItens(fatVenda, strTipFre, fltValFre, fltDesAce, fltDesEsp);

    If fClienteConsumidor(edtDesCliente.Text) Then
      pCarregaDadosClienteConsumidor;

    If (blnConfirma) Then
    Begin

      If (fCfgSis('DVVORI', varBoolean)) And (Not fValidaCndDocsSelecionados) Then
      Begin
        pMensagemOk('Documentos devem ser da mesma data e com mesma condição de pagamento, ' +
                    'pois o sistema está configurado para gravar o contas a receber da devolução com mesmos ' +
                    'vencimentos do documento de venda!');
        pInicializaTemporaria;
        Exit;
      End;

      If (fatVenda.strOpcDoc = 'DV') And
         (fPessoaJuridicaComIES(edtCodCliente.Text)) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Não é permitido emitir devolução para pessoa jurídica com inscrição estadual cadastrada.');

        objLiberacao.strDirAce := 'DEVPJ';
        objLiberacao.strSenLib := fCfgSis('SEDVPJ');
        objLiberacao.strMsgSen := 'Devolução Para Pessoa Jurídica';
        objLiberacao.strCodOpe := fatVenda.strCodVen;
        objLiberacao.strCodDig := fatVenda.strCodDig;
        objLiberacao.strCliente := edtCodCliente.Text + '-' + edtDesCliente.Text;
        objLiberacao.strCpfCnpj := fatVenda.strCliCgc;

        If Not fatVenda.fFatMensagemLiberacao(objLiberacao) Then
        Begin
          InterlockedDecrement(intConfirmando);
          Exit;
        End;
      End;

      If (Not fVerificaAcessoSistema('DVPJSI')) Then
      Begin
        If (fatVenda.strOpcDoc = 'DV') And
           (fPessoaJuridicaSemIES(edtCodCliente.Text)) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Não é permitido emitir devolução para pessoa jurídica sem inscrição estadual cadastrada.');

          objLiberacao.strDirAce := 'DVPJSI';
          objLiberacao.strSenLib := fCfgSis('DVPJSI');
          objLiberacao.strMsgSen := 'Devolução Para Pessoa Jurídica';
          objLiberacao.strCodOpe := fatVenda.strCodVen;
          objLiberacao.strCodDig := fatVenda.strCodDig;
          objLiberacao.strCliente := edtCodCliente.Text + '-' + edtDesCliente.Text;
          objLiberacao.strCpfCnpj := fatVenda.strCliCgc;

          If Not fatVenda.fFatMensagemLiberacao(objLiberacao) Then
          Begin
            InterlockedDecrement(intConfirmando);
            Exit;
          End;
        End;
      End;

      fatVenda.pCarregaAliquotasRetencao;

      fatVenda.pPreencheMatrizFechamento;

      fatVenda.pCalculaPesBruLiq;

      fatVenda.pCalculaTotGer(False, False);

      fatVenda.fltDesEsp := fltDesEsp;
      
      If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
      Begin
        If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
          fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
      End;

      fatVenda.pDestacaRetencoes;
      fatVenda.pRetemImpostosNoDescontoEspecial;

      fatVenda.pCalculaFreteDespAcessDevolucaoFornecedor;
      fatVenda.pCalculaDescontoEspecialDevolucaoFornecedor;

      fatVenda.pCalculaTotGer(False, False);

      fatVenda.fltValFre := fltValFre;
      fatVenda.fltDesAce := fltDesAce;

      If (Not fEmptyStr(strTipFre)) Then
        fatVenda.strTipFre := strTipFre;

      fatVenda.pCalculaTotGer;

      If fCfgSis('DVVORI', varBoolean) Then
      Begin
        If (Not fEmptyStr(cdsVenda.FieldByName('ITE_DOCDEV').AsString)) Then
        Begin
          fatVenda.strConPag := fRetCndDocOriginal(cdsVenda.FieldByName('ITE_DOCDEV').AsString,
                                                   cdsVenda.FieldByName('ITE_ESPDEV').AsString,
                                                   cdsVenda.FieldByName('ITE_EMPDEV').AsString,
                                                   cdsVenda.FieldByName('ITE_CODITE').AsString);
        End;
      End;

      If (fEmptyStr(fatVenda.strConPag)) Or (Not fValidaCndPag(fatVenda.strConPag)) Then
        fatVenda.strConPag := '01000';

      fltVlrDup := fatVenda.fltTotGer;

      If (fDesconsiderarFreteNoTotalCadRec) Then
      Begin
        fatVenda.pCalculaTotalParaCadRec;
        fltVlrDup := fatVenda.fltTotCadRec;
      End;

      fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fltVlrDup,
                                               False, False, False, VS_Date, False);

      fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

      fatVenda.pCalculaTotalParaCadRec;

      If (fCfgSis('ZVFPDR', varBoolean)) Then
        fatVenda.pRateiaValores;

      pSetTipoFaturamento(fatVenda);

      strPermiteAltCliente := fatVenda.fPermiteTrocarClienteNaDevolucao(True);
      If strPermiteAltCliente = 'T' Then
        Exit;

      If strPermiteAltCliente = 'S' Then
        pVerificaTrocaCliente;

      If (Pos(fatVenda.strEspDoc, 'DV_NF_') > 0) Then
      Begin
        pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);
        Try
          frmDigOcorrencia.strCodOco := fatVenda.strMotDev;
          frmDigOcorrencia.blnInformarHisCom := True;
          frmDigOcorrencia.strOpcDoc := fatVenda.strOpcDoc;
          frmDigOcorrencia.ShowModal;
          If (frmDigOcorrencia.ModalResult = mrOk) Then
          Begin
            fatVenda.strMotDev := frmDigOcorrencia.strCodOco;
            fatVenda.strHisCom := frmDigOcorrencia.strHisCom;
            blnConfirma        := True;
          End
          Else
          Begin
            blnConfirma        := False;
          End;

          If Not (blnConfirma) Then
          Begin

            fMensagem('ATENÇÃO!', 'A ocorrência deve ser preenchida!', ['&O k']);
            pInicializaTemporaria;
            Exit;
          End;
        Finally
          If Assigned(frmDigOcorrencia) Then
            pFreeAndNil(frmDigOcorrencia);
        End;
      End;

      If fCfgSis('FISDVR', varBoolean) And (fatVenda.strEspDoc = 'NF') Then
      Begin

        Try
          Try
            pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
            frmFatDadosFiscais.fatVenda := fatVenda;
            frmFatDadosFiscais.blnPodeCancelar := True;
            frmFatDadosFiscais.blnFatBaixaPedidoDev := True;
            frmFatDadosFiscais.ShowModal;
            blnConfirma := frmFatDadosFiscais.blnConfirma;
          Finally
            pFreeAndNil(frmFatDadosFiscais);
          End;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '');
          End;
        End;

        If blnConfirma then
          blnConfirma := fatVenda.fValidaDevolucaoComFreteSuperiorAoDocumentoOriginal;

        if Not blnConfirma Then
        Begin
          pInicializaTemporaria;
          Exit;
        End;

        {Calcula aqui novamente, devido a possibilidade
         do operador alterar o valor do frete}
        fatVenda.pCalculaTotalParaCadRec;

        fDigDuplic(fatVenda.arrDuplicata,
                   fTiraCaracEspeciaisParenteses(fatVenda.strConPag),
                   0,
                   fatVenda.fltTotCadRec,
                   False,
                   False,
                   False,
                   VS_Date,
                   False,
                   0,
                   'N',
                   True,
                   False,
                   0,
                   False,
                   Nil,
                   '',
                   fCfgSis('FSDUDP', varBoolean),
                   True, Nil, '', False, True, '', '', Nil, False, False, Nil, False, False, 0, '', fatVenda.strCodCid);

        fatVenda.pRateiaValores;

      End;

      fatVenda.objFatVendaImp.pLimparDocumentos;

      Try
        Try
          pCriarFormularios(TfrmGravando,frmGravando);
          frmGravando.lblGravando.Caption := 'Aguarde... Carregando.';
          frmGravando.strChave := 'FATVENDAS';
          frmGravando.fExecutarAcao := fatVenda.fGravaArquivos;
          frmGravando.ShowModal;
          blnConfirma := frmGravando.blnConfirma;
        Finally
          pFreeAndNil(frmGravando);
        End;
      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pnlHeader.Enabled := True;
          cdsConsulta.EnableControls;
          pMensagensErro(E.Message, '[TfrmFatBaixaPedidoDev.pConfirma]');
          pInicializaTemporaria;
        End;
      End;

      pInicializaTemporaria;
    End;

    cdsConsulta.EnableControls;
    pnlHeader.Enabled := True;

    If blnConfirma Then
    Begin
      pMensagemOk('Operação realizada com sucesso!');
      pSetFocus(mskDtaIni);
    End;

  Except
    On E: Exception Do
    Begin
      pnlHeader.Enabled := True;
      cdsConsulta.EnableControls;
      pMensagensErro(E.Message, '[TfrmFatBaixaPedidoDev.pConfirma]');
      pInicializaTemporaria;
    End;
  End;

end;

procedure TfrmFatBaixaPedidoDev.pGeracaoEntradaMercadoriaDevolucao;
  Var
    frmEntMercadorias: TfrmEntMercadorias;
    qryItensDev: TUniQuery;
    qryPedidoDev: TUniQuery;
    intIndice: Integer;
    strTabDev,
    strIncDev: String;
    fltQtdEntrada,
    fltBFCPST,
    fltPFCPST,
    fltVFCPST: Double;
begin
  pnlHeader.Enabled := False;
  pCriarFormularios(TfrmEntMercadorias, frmEntMercadorias);
  Try
    Try
      frmEntMercadorias.blnSemInc      := False;
      frmEntMercadorias.strCodFor      := edtCodCliente.Text;
      frmEntMercadorias.blnDevolu      := True;
      frmEntMercadorias.edtEspDoc.Text := 'NF';
      frmEntMercadorias.blnAutomatico  := False;
      frmEntMercadorias.blnPresencial  := False;
      frmEntMercadorias.blnConEqu      := False;
      frmEntMercadorias.blnLocEqu      := False;
      frmEntMercadorias.strItensEntradaMercadoriaDev := fRetItensEntradaMercadoriaDev;
      frmEntMercadorias.blnBaixaPedidoDev := True;
      frmEntMercadorias.blnPrecoPraticado := True;
      pCriaTabelaEntradaMercadorias;

      cdsConsulta.DisableControls;
      cdsConsulta.First;
      cdsConsulta.Locate('AUTOINCREM', stlListSelecao.Strings[0], []);

      qryItensDev := fCriaQuery(Self);
      qryPedidoDev := fCriaQuery(Self);
      Try
        qryItensDev.Close;
        qryItensDev.SQL.Clear;
        qryItensDev.SQL.Add(fSQLCadastroItem);
        qryPedidoDev.Close;
        qryPedidoDev.SQL.Clear;
        qryPedidoDev.SQL.Add(fSQLItensPedidoDev);

        For intIndice := 0 To stlListSelecao.Count - 1 Do
        Begin
          cdsConsulta.Locate('AUTOINCREM', stlListSelecao[intIndice], []);

          qryPedidoDev.Close;
          qryPedidoDev.ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('CODEMP').AsString;
          qryPedidoDev.ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('NUMDOC').AsString;
          qryPedidoDev.ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('ESPDOC').AsString;
          qryPedidoDev.Open;

          qryPedidoDev.First;
          While Not qryPedidoDev.Eof Do
          Begin
            frmEntMercadorias.pCarregaItemDevolucao(qryPedidoDev.FieldByName('FDO_CODITE').AsString);

            qryItensDev.Close;
            qryItensDev.ParamByName('CODITE').AsString := qryPedidoDev.FieldByName('FDO_CODITE').AsString;
            qryItensDev.ParamByName('CODEMP').AsString := VS_strCodEmp;
            qryItensDev.Open;

            strTabDev := '';
            strIncDev := qryPedidoDev.FieldbyName('FDO_INCDEV').AsString;
            fltQtdEntrada := qryPedidoDev.FieldByName('FDO_QTDITE').AsFloat;
            If Not fEmptyStr(strIncDev) then
            Begin
              strTabDev := 'MOVDET';

              If fCampoTabela('CONCAT(DET_NUMDOC,DET_ESPDOC,DET_CODEMP)', 'NOTDET', ['AUTOINCREM'], [strIncDev]) =
                 Concat(qryPedidoDev.FieldByName('FDO_DOCDEV').AsString,qryPedidoDev.FieldByName('FDO_ESPDEV').AsString,qryPedidoDev.FieldByName('FDO_EMPDEV').AsString) Then
              Begin
                strTabDev := 'NOTDET';
              End;
            End;

            pRetornaValoresImpostos(strIncDev, strTabDev, fltQtdEntrada, fltBFCPST, fltPFCPST, fltVFCPST );

            frmEntMercadorias.pAdicionaItem(qryPedidoDev.FieldByName('FDO_UNITAR').AsFloat,
                                            fltQtdEntrada,
                                            qryPedidoDev.FieldByName('FDO_TOTITE').AsFloat,
                                            qryPedidoDev.FieldByName('FDO_ALQIPI').AsFloat,
                                            qryPedidoDev.FieldByName('FDO_BASIPI').AsFloat,
                                            qryPedidoDev.FieldByName('FDO_VALIPI').AsFloat,
                                            qryPedidoDev.FieldByName('FDO_ALQICM').AsFloat,
                                            qryPedidoDev.FieldByName('FDO_BASICM').AsFloat,
                                            qryPedidoDev.FieldByName('FDO_VALICM').AsFloat,
                                            qryPedidoDev.FieldByName('FDO_CODITE').AsString,
                                            qryItensDev.FieldbyName('ITE_CODGRU').AsString,
                                            qryItensDev.FieldbyName('ITE_DESITE').AsString,
                                            qryItensDev.FieldbyName('ITE_REFERE').AsString,
                                            qryPedidoDev.FieldByName('FDO_UNIDAD').AsString,
                                            qryItensDev.FieldbyName('ITE_CODABF').AsString,
                                            '',
                                            strIncDev,                                          //strAutVen,
                                            strTabDev,                                          //strTabVen,
                                            qryItensDev.FieldbyName('ITE_CODFAB').AsString,     //strCodFab,
                                            qryPedidoDev.FieldByName('FDO_DOCDEV').AsString,    //strNumPed,
                                            qryPedidoDev.FieldByName('FDO_ESPDEV').AsString,    //strEspDoc,
                                            qryPedidoDev.FieldByName('FDO_EMPDEV').AsString,    //strCodEmp,
                                            qryPedidoDev.FieldByName('FDO_CODCLI').AsString,    //strCodCli,
                                            qryPedidoDev.FieldByName('FDO_NUMLOT').AsString,    //strNumLot,
                                            qryItensDev.FieldByName('ITE_RPRENT').AsString,     //strRprEnt,
                                            qryPedidoDev.FieldByName('FDO_CODACA').AsString,    //strCodAca,
                                            qryPedidoDev.FieldByName('FDO_EMPACA').AsString,    //strEmpAca,
                                            qryPedidoDev.FieldByName('FDO_PROACA').AsString,    //strProAca,
                                            qryPedidoDev.FieldByName('FDO_DESCRI').AsString,    //strDesAca: String;
                                            qryPedidoDev.FieldByName('FDO_UNITAR').AsFloat,     //fltPreAca,
                                            0,                                                  //fltSalAca: Double;
                                            qryItensDev.FieldByName('ITE_CLAIPI').AsString,     //strClaIpi: String;
                                            1,                                                  //fltEmbala: Double;
                                            qryItensDev.FieldByName('ITE_UNICOM').AsString,     //strUniEmb: String;
                                            '',                                                 //strCodMot: String;
                                            '',                                                 //strCodDiv: String='';
                                            qryPedidoDev.FieldByName('FDO_DESESP').AsFloat,     //fltDEsUni: Double=0;
                                            '',                                                 //strEmp_Pd: String = '';
                                            '',                                                 //strCDCEST: string = '';
                                            '',                                                 //strIncPisDev: string = ''
                                            '',                                                 //strCstCofDev: string = ''
                                            '',                                                 //strCstPisDev: string = ''
                                            '',                                                 //strNR_PisDev: string = ''
                                            '',                                                 //strNR_CofDev: string = ''
                                            '',                                                 //strCodFisDev: string = ''
                                            qryPedidoDev.FieldByName('FDO_VALRET').AsFloat,     //fltValRetDev: Double = 0;
                                            qryPedidoDev.FieldByName('FDO_BASRET').AsFloat,     //fltBasRetDev: Double = 0;
                                            0,                                                  //fltVal_RtDev: Double = 0;
                                            0,                                                  //fltPerBasDev: Double = 0;
                                            0,                                                  //fltPeBaSTDev: Double = 0;
                                            0,                                                  //fltPerRedDev: Double = 0;
                                            qryPedidoDev.FieldByName('FDO_ALQRET').AsFloat,     //fltAlqRetDev: Double = 0;
                                            0,                                                  //fltValCofDev: Double = 0;
                                            0,                                                  //fltBasPisDev: Double = 0;
                                            0,                                                  //fltValPisDev: Double = 0;
                                            0,                                                  //fltBasCofDev: Double = 0;
                                            0,                                                  //fltDesAceDev: Double = 0;
                                            0,                                                  //fltAlqCofDev: Double = 0;
                                            0,                                                  //fltAlqPisDev: Double = 0;
                                            -1,                                                 //fltDesEsp   : Double = -1;
                                            -1,                                                 //fltValFre   : Double = -1;
                                            -1,                                                 //fltQtdOri   : Double = -1;
                                            'N',                                                //strProEmb: String = 'N';
                                            '',                                                 //strImpDir: String = '';
                                            fltBFCPST,                                          //fltBFCPST: Double = 0;
                                            fltPFCPST,                                          //fltPFCPST: Double = 0;
                                            fltVFCPST,                                          //fltVFCPST: Double = 0;
                                            0,                                                  //fltVBCFCP: Double = 0;
                                            0,                                                  //fltPERFCP: Double = 0;
                                            0,                                                  //fltVALFCP: Double = 0;
                                            '',                                                 //strIdePro: string = '';
                                            '',                                                 //strIteTin: String = '';
                                            qryPedidoDev.RecNo,                                 //intnItem: Integer = 0;
                                            '',                                                 //strDesMar: String = '';
                                            '');                                                //strIncFut: String = '');

            qryPedidoDev.Next;
          End;
        End;
      Finally
        FreeAndNil(qryItensDev);
        FreeAndNil(qryPedidoDev);
      End;

      frmEntMercadorias.ShowModal;

      If frmEntMercadorias.blnConfirma Then
      Begin
        pBaixaFatGor(frmEntMercadorias.edtNumDoc.Text,
                     frmEntMercadorias.edtEspDoc.Text);

        pMensagemOk('Operação realizada com sucesso!');
        pSetFocus(mskDtaIni);
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatBaixaPedidoDev.pGeracaoEntradaMercadoriaDevolucao]');
    End;
  Finally
    pFreeAndNil(frmEntMercadorias);
    pnlHeader.Enabled := True;
    cdsConsulta.EnableControls;
    pInicializaTemporaria;
  End;
end;

procedure TfrmFatBaixaPedidoDev.btnConfirmaClick(Sender: TObject);
begin
  If fPedidosJaFaturados Then
    Exit;

  inherited;

  pConfirma;

  objLock.pDestravarTodos;

  cdsConsulta.EnableControls;
  pnlHeader.Enabled := True;

end;

procedure TfrmFatBaixaPedidoDev.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  objLock.pDestravarTodos;
  pDesmarcaTodos;
end;

procedure TfrmFatBaixaPedidoDev.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  objLock.pDestravarTodos;
  pMarcaTodos;
end;

procedure TfrmFatBaixaPedidoDev.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      pSetFocus(dbgConsulta);
  End;
end;

procedure TfrmFatBaixaPedidoDev.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatBaixaPedidoDev.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmFatBaixaPedidoDev.FormCreate(Sender: TObject);
begin
  inherited;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

  blnSempreRelerBanco   := False;
  blnSelecionaComEspaco := True;
  blnQuoteLista := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftDateTime;

  qryCadCli := fCriaQuery(Self);
  objLock   := TLock.Create;

  pCriarCdsVenda(Self);
  fatVenda := TFatVenda.CreateInstance('DV');
  If (fCfgSis('ESPDEV',varBoolean)) Then
    fatVenda.objItensNotaEspelho := TItensNotaEspelho.Create(fatVenda);
  fatVenda.strOpcDocTrue:= 'BD';
  fatVenda.blnVerEstOrc := False;
  fatVenda.strNomeForm  := 'frmFatVendas';
  fatVenda.strCodTra    := fCfgSis('TRASUG');
  fatVenda.strEntFat    := fCfgSis('ROMEFT');
  objLiberacao          := TLiberacao.Create;
end;

procedure TfrmFatBaixaPedidoDev.FormDestroy(Sender: TObject);
begin
  pDestruirCdsVenda;
  FreeAndNil(fatVenda);
  FreeAndNil(objLock);
  If Assigned(objLiberacao) Then
    FreeAndNil(objLiberacao);
  inherited;
end;

procedure TfrmFatBaixaPedidoDev.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE: If ActiveControl <> mskDtaIni Then
               Begin
                 pSetFocus(mskDtaIni);
               End

               Else inherited;

    VK_F6 : btnMarcaTodos.Click;
    VK_F7 : btnDesmarcaTodos.Click;
    VK_F10: btnConfirma.Click;

    Else inherited;
  End;
end;

procedure TfrmFatBaixaPedidoDev.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

function TfrmFatBaixaPedidoDev.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      mskDtaFin.Clear;
      mskDtaFin.Enabled := Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text));

    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End
      End;

    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('','Digite o código da empresa !',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('','Empresa digitada não foi encontrada, verifique !',['&O K']);
          Result := False;
        End
      End;
    End

    Else If (Sender = edtCodCliente) Then
    Begin

      If fEmptyStr(edtCodCliente.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o código do cliente!', ['&Ok']);
        Result := FALSE;
      End

      Else
      Begin
        pCarregaCliente;
        If fEmptyStr(edtDesCliente.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Cliente não cadastrado!', ['&Ok']);
          Result := FALSE;
        End

        Else fAbreConsulta(TRUE);

      End

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFatBaixaPedidoDev.fValidaCndDocsSelecionados: Boolean;
  Var
    cdsTmp : TUniClientDataSet;
    cdsDev : TUniClientDataSet;
    dtaEmiDev : TDate;
    strCndDev : String;
    strCCndDv : String;

  Procedure pIniciaCdsTmp;
  Begin
    cdsTmp := TUniClientDataSet.Create(Self);
    With cdsTmp.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TMP_DTAENT';
      DataType := ftDate;
    End;

    With cdsTmp.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TMP_CONPAG';
      DataType := ftString;
      Size     := 50;
    End;

    With cdsTmp.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TMP_CODCND';
      DataType := ftString;
      Size     := 50;
    End;

    cdsTmp.CreateDataSet;
    cdsTmp.IndexFieldNames := 'TMP_DTAENT;TMP_CONPAG;TMP_CODCND';
    cdsTmp.EmptyDataSet;
  End;

  Procedure pRetCndDtaDev(strDoc, strEsp, strEmp, strIte: String);
    Var
      strSql : String;
      qryTmp : TUniQuery;
  begin
    qryTmp := fCriaQuery(Self);

    strSql :=          ' SELECT DET_CONPAG, DET_DTAENT, DET_CODCND ';
    strSql := strSql + '   FROM MOVDET ';
    strSql := strSql + '  WHERE DET_NUMDOC = :NUMDOC ';
    strSql := strSql + '    AND DET_ESPDOC = :ESPDOC ';
    strSql := strSql + '    AND DET_CODEMP = :CODEMP ';
    strSql := strSql + '    AND DET_CODITE = :CODITE ';

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSql);
      ParamByName('NUMDOC').AsString := strDoc;
      ParamByName('ESPDOC').AsString := strEsp;
      ParamByName('CODEMP').AsString := strEmp;
      ParamByName('CODITE').AsString := strIte;
      Open;

      If (Not IsEmpty) Then
      Begin
        dtaEmiDev := FieldByName('DET_DTAENT').AsDateTime;
        strCndDev := FieldByName('DET_CONPAG').AsString;
        strCCndDv := FieldByName('DET_CODCND').AsString;
      End
      Else
      Begin
        dtaEmiDev := 0;
        strCndDev := '';
        strCCndDv := '';
      End;

      Close;
    End;

    FreeAndNil(qryTmp);
  End; 

  Procedure pSintetizarDocsDevs;
  Begin
    cdsDev := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsDev, cdsVenda);
    cdsDev.EmptyDataSet;
    cdsDev.IndexFieldNames := 'ITE_DOCDEV;ITE_ESPDEV;ITE_EMPDEV';

    cdsVenda.First;
    While Not cdsVenda.Eof Do
    Begin

      If Not cdsDev.FindKey([cdsVenda.FieldByName('ITE_DOCDEV').AsString,
                             cdsVenda.FieldByName('ITE_ESPDEV').AsString,
                             cdsVenda.FieldByName('ITE_EMPDEV').AsString]) Then
      Begin
        cdsDev.Append;
        cdsDev.FieldByName('ITE_DOCDEV').AsString := cdsVenda.FieldByName('ITE_DOCDEV').AsString;
        cdsDev.FieldByName('ITE_ESPDEV').AsString := cdsVenda.FieldByName('ITE_ESPDEV').AsString;
        cdsDev.FieldByName('ITE_EMPDEV').AsString := cdsVenda.FieldByName('ITE_EMPDEV').AsString;
        cdsDev.FieldByName('ITE_CODITE').AsString := cdsVenda.FieldByName('ITE_CODITE').AsString;
        cdsDev.Post;
      End;

      cdsVenda.Next;
    End;
  End;

begin
  Result := True;
  pIniciaCdsTmp;
  pSintetizarDocsDevs;

  cdsDev.First;
  While Not cdsDev.Eof Do
  Begin

    pRetCndDtaDev(cdsDev.FieldByName('ITE_DOCDEV').AsString,
                  cdsDev.FieldByName('ITE_ESPDEV').AsString,
                  cdsDev.FieldByName('ITE_EMPDEV').AsString,
                  cdsDev.FieldByName('ITE_CODITE').AsString);

    If (cdsTmp.IsEmpty) Then
    Begin
      cdsTmp.Append;
      cdsTmp.FieldByName('TMP_DTAENT').AsDateTime := dtaEmiDev;
      cdsTmp.FieldByName('TMP_CONPAG').AsString   := strCndDev;
      cdsTmp.FieldByName('TMP_CODCND').AsString   := strCCndDv;
      cdsTmp.Post;
    End
    Else
    Begin
      If Not cdsTmp.FindKey([dtaEmiDev, strCndDev, strCCndDv]) Then
      Begin
        Result := False;
        Break;
      End;
    End;
    
    cdsDev.Next;
  End;
  cdsTmp.Close;
  cdsDev.Close;
  FreeAndNil(cdsTmp);
  FreeAndNil(cdsDev);
end;

procedure TfrmFatBaixaPedidoDev.mskDtaIniEnter(Sender: TObject);
begin
  inherited;

  cdsConsulta.Close;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodCliente.Clear;
  edtDesCliente.Clear;
end;

procedure TfrmFatBaixaPedidoDev.pAddListaQuery;
begin
  If (Not fEmptyStr(strEspSel)) And
     (Not SameText(cdsConsulta.FieldByName('ESPDEV').AsString, strEspSel)) then
  Begin
    fMensagem('ATENÇÃO', 'Só é permitido selecionar itens da mesma espécie de devolução!', ['&OK']);
    Exit;
  End;

  If Not fTravaPedido Then
    Exit;

  inherited;

  If (stlListSelecao.Count > 0) and fEmptyStr(strEspSel) Then
    strEspSel := cdsConsulta.FieldByName('ESPDEV').AsString;

  If (stlListSelecao.Count = 0) Then
    strEspSel := '';

end;

procedure TfrmFatBaixaPedidoDev.pBaixaFatGor(strNumFat, strEspFat: String);
  Var
    qryAux: TUniQuery;
    intIndice: Integer;
begin
  pnlHeader.Enabled := False;

  cdsConsulta.DisableControls;
  cdsConsulta.First;
  cdsConsulta.Locate('AUTOINCREM', stlListSelecao.Strings[0], []);

  qryAux := fCriaQuery(Self);
  Try
    For intIndice := 0 To stlListSelecao.Count - 1 Do
    Begin
      cdsConsulta.Locate('AUTOINCREM', stlListSelecao[intIndice], []);

      qryAux.Close;
      qryAux.SQL.Clear;

      qryAux.SQL.Add(' UPDATE FATGOR SET FGO_JAFATU = 1,       ');
      qryAux.SQL.Add('                   FGO_NUMFAT = :NUMFAT, ');
      qryAux.SQL.Add('                   FGO_TIPFAT = :TIPFAT, ');
      qryAux.SQL.Add('                   FGO_EMPFAT = :EMPFAT  ');
      qryAux.SQL.Add(' WHERE FGO_NUMDOC = :NUMDOC              ');
      qryAux.SQL.Add('   AND FGO_ESPDOC = :ESPDOC              ');
      qryAux.SQL.Add('   AND FGO_CODEMP = :CODEMP              ');

      qryAux.ParamByName('NUMFAT').AsString := strNumFat;
      qryAux.ParamByName('TIPFAT').AsString := strEspFat;
      qryAux.ParamByName('EMPFAT').AsString := VS_strCodEmp;
      qryAux.ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('NUMDOC').AsString;
      qryAux.ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('ESPDOC').AsString;
      qryAux.ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('CODEMP').AsString;

      qryAux.ExecSQL;
    End;
  Finally
    pnlHeader.Enabled := True;
    cdsConsulta.EnableControls;
    pInicializaTemporaria;
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmFatBaixaPedidoDev.pCarregaCliente;
Begin
  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCliente.Text);
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';

  fatVenda.strCodCli := edtCodCliente.Text; // Cliente - Codigo
  fatVenda.strCodReg := qryCadCli.FieldByName('CLI_CODREG').AsString;
End;

procedure TfrmFatBaixaPedidoDev.pCarregaDadosClienteConsumidor;
  Var
    strSQL : String;
    qryFgoTmp : TUniQuery;
begin
  qryFgoTmp := fCriaQuery(Self);

  strSQL :=          ' SELECT ';
  strSQL := strSQL + '  FGO_CGCCPF AS CGCCPF, ';
  strSQL := strSQL + '  FGO_NOMCON AS CLINOM, '; //
  strSQL := strSQL + '  FGO_ENDCON AS ENDERE, '; //
  strSQL := strSQL + '  FGO_BAICON AS BAIRRO, '; //
  strSQL := strSQL + '  FGO_CIDCON AS CODCID, '; //
  strSQL := strSQL + '  FGO_CEPCON AS C_E_P_, '; //
  strSQL := strSQL + '  FGO_TELCON AS FONE01, '; //
  strSQL := strSQL + '  FGO_NASCON AS NASCON, '; //
  strSQL := strSQL + '  FGO_R_GCON AS NUM_RG, '; //
  strSQL := strSQL + '  FGO_CGCCON AS C_G_C_, '; //
  strSQL := strSQL + '  FGO_IESCON AS I_E_S_, '; //
  strSQL := strSQL + '  FGO_ESTCON AS ESTCON, '; //
  strSQL := strSQL + '  FGO_EMLCON AS EMLCON  '; //
  strSQL := strSQL + ' FROM FATGOR           ';
  strSQL := strSQL + '  INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strSQL := strSQL + ' WHERE FGO_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '   AND FGO_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '   AND FGO_CODEMP = :CODEMP ';

  With qryFgoTmp Do
  Begin
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := fatVenda.arrPedidosDev[0].strNumPed;
    ParamByName('ESPDOC').AsString := fatVenda.arrPedidosDev[0].strEspPed;
    ParamByName('CODEMP').AsString := fatVenda.arrPedidosDev[0].strEmpPed;
    Open;

    If (RecordCount > 0) Then
    Begin
      fatVenda.strCliNom := FieldByName('CLINOM').AsString;                  //         - Nome
      fatVenda.strCliOri := FieldByName('CLINOM').AsString;                  //         - Nome Original
      fatVenda.strCliEnd := FieldByName('ENDERE').AsString;                  //         - Endereco
      fatVenda.strCliNum := '';                                              //         - Numero
      fatVenda.strCliBai := FieldByName('BAIRRO').AsString;                  //         - Bairro
      fatVenda.strCliCep := FieldByName('C_E_P_').AsString;                  //         - Cep
      fatVenda.strCodCid := FieldByName('CODCID').AsString;                  //         - Cód. Cidade
      fatVenda.strCliCid := fRetNomCidade(FieldByName('CODCID').AsString,0); //         - Cidade
      fatVenda.strCliEst := fRetNomCidade(FieldByName('CODCID').AsString,1); //         - Estado
      fatVenda.strCliTel := FieldByName('FONE01').AsString;                  //         - Telefone
      fatVenda.dtaNasCon := FieldByName('NASCON').AsDateTime;                //         - Nascimento
      fatVenda.strCli_Rg := FieldByName('NUM_RG').AsString;                  //         - RG
      fatVenda.strCliCgc := fTiraCaracEspeciais(FieldByName('C_G_C_').AsString);//      - CNPJ
      fatVenda.strCliCgc := AnsiReplaceStr(fatVenda.strCliCgc, '.', '');
      fatVenda.intCgcCpf := FieldByName('CGCCPF').AsInteger;                 //         - CGC/CPF
      fatVenda.strCliIes := FieldByName('I_E_S_').AsString;                  //         - Ins.Estadual
      fatVenda.strCliEma := FieldByName('EMLCON').AsString;                  //         - Email do Cliente
    End;

    Close;
  End;

  FreeAndNil(qryFgoTmp); 
end;

function TfrmFatBaixaPedidoDev.fGetSql(blnLike: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';

  strSQL := strSQL + '   G.AUTOINCREM, ';
  strSQL := strSQL + '   FGO_DTAENT AS DTAENT, ';
  strSQL := strSQL + '   FGO_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '   FGO_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '   FGO_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   CONCAT(FGO_CODVEN, "-", OPE_NOMOPE) AS CODVEN, ';
  strSQL := strSQL + '   FGO_VLRCON AS VLRCON,  ';
  strSQL := strSQL + '   E.FGO_PERDAD AS PERDAD,  ';

  {Utilizado para validações em código}
  strSQL := strSQL + '   (SELECT IF(LOCATE(FDO_ESPDEV, "NF_EL_IF_IV_NV_D1_") > 0, "NF", FDO_ESPDEV) ';
  strSQL := strSQL + '    FROM FATDOR ';
  strSQL := strSQL + '    WHERE ';
  strSQL := strSQL + '      FATDOR.FDO_ESPDOC = "PR" AND   ';
  strSQL := strSQL + '      FATDOR.FDO_SEQGER = G.AUTOINCREM LIMIT 1) AS ESPDEV,  ';

  {Mostra todas as espécies dos itens de devolução do documento em tela}
  strSQL := strSQL + '   (SELECT CAST(GROUP_CONCAT(DISTINCT FDO_ESPDEV) AS CHAR(100))';
  strSQL := strSQL + '    FROM FATDOR ';
  strSQL := strSQL + '    WHERE ';
  strSQL := strSQL + '      FATDOR.FDO_ESPDOC = "PR" AND   ';
  strSQL := strSQL + '      FATDOR.FDO_SEQGER = G.AUTOINCREM) AS TIPDEV  ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   FATGOR G ';
  strSQL := strSQL + ' INNER JOIN EXTGOR E ON G.AUTOINCREM = E.FGO_SEQFGO ';
  strSQL := strSQL + ' LEFT JOIN CADOPE ON OPE_CODOPE = FGO_CODVEN ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   FGO_ESPDOC = "PR" AND     ';
  strSQL := strSQL + '   FGO_JAFATU = 0    AND     ';
  strSQL := strSQL + '   FGO_CODCLI = :CODCLI AND  ';
  strSQL := strSQL + '   FGO_CODEMP = :CODEMP      ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    strSQL := strSQL + '  AND FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  Result := strSQL;
End;

function TfrmFatBaixaPedidoDev.fAbreConsulta(blnLike: Boolean): Boolean;
Begin

  stlListSelecao.Clear;
  objLock.pDestravarTodos;

  Result := inherited fAbreConsulta(blnLike);

End;

function TfrmFatBaixaPedidoDev.fRetCndDocOriginal(strDoc, strEsp, strEmp, strIte: String): String;
  Var
    strSql : String;
    qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery(Self);

  strSql :=          ' SELECT DET_CONPAG, DET_DTAENT ';
  strSql := strSql + '   FROM MOVDET ';
  strSql := strSql + '  WHERE DET_NUMDOC = :NUMDOC ';
  strSql := strSql + '    AND DET_ESPDOC = :ESPDOC ';
  strSql := strSql + '    AND DET_CODEMP = :CODEMP ';
  strSql := strSql + '    AND DET_CODITE = :CODITE ';

  strSql := strSql + ' UNION ALL ' + AnsiReplaceStr(strSql, 'MOVDET', 'NOTDET');

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSql);
    ParamByName('NUMDOC').AsString := strDoc;
    ParamByName('ESPDOC').AsString := strEsp;
    ParamByName('CODEMP').AsString := strEmp;
    ParamByName('CODITE').AsString := strIte;
    Open;
    Result := fRetCondicaoDevolucao(FieldByName('DET_DTAENT').AsDateTime, FieldByName('DET_CONPAG').AsString);
    Close;
  End;

  FreeAndNil(qryTmp);
end;

function TfrmFatBaixaPedidoDev.fRetItensEntradaMercadoriaDev: String;
var
  qryItens: TUniQuery;
  intIndice: Integer;
  strAutInc: String;
begin
  Result := EmptyStr;

  if stlListSelecao.Count <= 0  then
    Exit;

  strAutInc := EmptyStr;

  for intIndice := 0 to stlListSelecao.Count - 1 do
  begin
    pIncrementaListaStr(stlListSelecao[intIndice], strAutInc, True);
  end;

  if fEmptyStr(strAutInc) then
    Exit;

  qryItens := fCriaQuery;

  try
    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add('SELECT D.FDO_CODITE');
    qryItens.SQL.Add('FROM FATDOR D');
    qryItens.SQL.Add('INNER JOIN FATGOR G');
    qryItens.SQL.Add('ON(G.AUTOINCREM = D.FDO_SEQGER)');
    qryItens.SQL.Add('WHERE G.AUTOINCREM IN('+strAutInc+') ');
    qryItens.SQL.Add('GROUP BY D.FDO_CODITE');
    qryItens.Open;

    if qryItens.IsEmpty then
      Exit;

    while not qryItens.Eof do
    begin
      pIncrementaListaStr(qryItens.FieldByName('FDO_CODITE').AsString, Result, True);
      qryItens.Next;
    end;
  finally
    FreeAndNil(qryItens);
  end;
end;

function TfrmFatBaixaPedidoDev.fDesconsiderarFreteNoTotalCadRec: Boolean;
begin
  Result := False;

  If (Not fCfgSis('FREBAI', varBoolean)) Then
    Exit;

  If (fatVenda.fltValFre <= 0) Then
    Exit;

  If ((fCfgSis('FISDVR', varBoolean)) And (fatVenda.strEspDoc = 'NF')) Then
    Exit;

  Result := True;
end;

function TfrmFatBaixaPedidoDev.fRetAlqOrgDemaisImpostos(strIncDev, strDocDev,
  strEspDev, strEmpDev, strCodIte: String): TAlqOrgDemaisImpostos;
  Var
    qryImp: TUniQuery;
    fltTotIte: Double;
begin
  Result.fltImpFed := 0;
  Result.fltDesOpe := 0;
  Result.fltOutVal := 0;
  Result.fltIcmSai := 0;

  qryImp := fCriaQuery;
  Try
    With qryImp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT D.DET_TOTITE, ');
      SQL.Add('       D.DET_DESESP, ');
      SQL.Add('       D.DET_QTDITE, ');
      SQL.Add('       T.DET_IMPFED, ');
      SQL.Add('       T.DET_DESOPE, ');
      SQL.Add('       T.DET_OUTVAL, ');
      SQL.Add('       T.DET_ICMSAI  ');
      SQL.Add('FROM MOVDET D INNER JOIN MOVTRI T ON T.DET_SEQGER=D.AUTOINCREM');
      If Not fEmptyStr(strIncDev) Then
        SQL.Add('WHERE D.AUTOINCREM = '+QuotedStr(strIncDev))
      Else
      Begin
        SQL.Add('WHERE D.DET_NUMDOC = '+QuotedStr(strDocDev));
        SQL.Add('  AND D.DET_ESPDOC = '+QuotedStr(strEspDev));
        SQL.Add('  AND D.DET_CODEMP = '+QuotedStr(strEmpDev));
        SQL.Add('  AND D.DET_CODITE = '+QuotedStr(strCodIte));
      End;
      Open;

      If Not IsEmpty Then
      Begin
        fltTotIte := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat);

        If FieldByName('DET_OUTVAL').AsFloat > 0 Then
           Result.fltOutVal := (FieldByName('DET_OUTVAL').AsFloat / FieldByName('DET_QTDITE').AsFloat);
        If FieldByName('DET_IMPFED').AsFloat > 0 Then
           Result.fltImpFed := ((FieldByName('DET_IMPFED').AsFloat / fltTotIte) * 100);
        If FieldByName('DET_DESOPE').AsFloat > 0 Then
           Result.fltDesOpe := ((FieldByName('DET_DESOPE').AsFloat / fltTotIte) * 100);
        If FieldByName('DET_ICMSAI').AsFloat > 0 Then
           Result.fltIcmSai := ((FieldByName('DET_ICMSAI').AsFloat / fltTotIte) * 100);
      End;
    End;
  Finally
    FreeAndNil(qryImp);
  End;
end;

function TfrmFatBaixaPedidoDev.fSetParametros: Boolean;
Begin
  With qryConsulta Do
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    If Not fEmptyStr(edtCodEmp.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    ParamByName('CODCLI').AsString := edtCodCliente.Text;
  End;

  Result := True;
End;

procedure TfrmFatBaixaPedidoDev.pInicializaTemporaria;
begin
  cdsVenda.EmptyDataSet;
  fatVenda.strMen001 := '';
  fatVenda.strMen002 := '';
  fatVenda.blnApurouValFreDesAceDevolucaoEspelho := False;
End;

procedure TfrmFatBaixaPedidoDev.pRetornaValoresImpostos(strAutIncVenda,
  strTabelaVenda: String; AfltQtdEntrada: Double; out AfltBFCPST, AfltPFCPST, AfltVFCPST: Double);
Var qryAux: TUniQuery;
    NomeTabDet, NomeTabTri: string;
begin
  AfltBFCPST := 0;
  AfltPFCPST := 0;
  AfltVFCPST := 0;

  case AnsiIndexStr(strTabelaVenda, ['MOVDET', 'NOTDET']) of
    0: begin
         NomeTabDet := 'MOVDET';
         NomeTabTri := 'MOVTRI';
       end;
    1: begin
         NomeTabDet := 'NOTDET';
         NomeTabTri := 'NOTTRI';
       end;
  else
    raise Exception.Create('Tabela DET inválida: ' + strTabelaVenda);
  end;

  qryAux := fCriaQuery(Self);
  Try
    qryAux.SQL.Text := ' SELECT ' + sLineBreak +
                       '  DET_CODITE, DET_QTDITE, DET_BFCPST, DET_PFCPST,  DET_VFCPST ' + sLineBreak +
                       ' FROM ' + NomeTabDet + sLineBreak +
                       ' INNER JOIN ' + NomeTabTri +
                                    ' ON ' + NomeTabTri + '.DET_SEQGER = ' + NomeTabDet + '.AUTOINCREM' + sLineBreak +
                       ' WHERE ' + NomeTabDet + '.AUTOINCREM = :AUTINCVENDA';

    qryAux.ParamByName('AUTINCVENDA').AsString := strAutIncVenda;

    qryAux.Open;

    If Not qryAux.isEmpty Then
    Begin
      AfltBFCPST := fFormataFloat(AfltQtdEntrada * (qryAux.FieldByName('DET_BFCPST').AsFloat / qryAux.FieldByName('DET_QTDITE').AsFloat),02);
      AfltPFCPST := qryAux.FieldByName('DET_PFCPST').AsFloat;
      AfltVFCPST := fFormataFloat(AfltQtdEntrada * (qryAux.FieldByName('DET_VFCPST').AsFloat / qryAux.FieldByName('DET_QTDITE').AsFloat),02);;
    End;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmFatBaixaPedidoDev.pVerificaTrocaCliente;
  Var
    frmFatTrocaCliente: TfrmFatTrocaCliente;
begin
  pCriarFormularios(TfrmFatTrocaCliente, frmFatTrocaCliente);
  Try
    Try
      frmFatTrocaCliente.fatVenda := fatVenda;
      frmFatTrocaCliente.blnBaixaPedidoDev := True;
      frmFatTrocaCliente.ShowModal;

      If Not frmFatTrocaCliente.blnResult Then
        Exit;

      If frmFatTrocaCliente.edtCliFat.Text <> fatVenda.strCodCli Then
      Begin
        fatVenda.strCodCli := frmFatTrocaCliente.edtCliFat.Text;
        fatVenda.pCarregaDadosClienteBaixa(fatVenda.strCodCli, False, False);
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[pVerificaTrocaCliente]');
    End;
  Finally
    pFreeAndNil(frmFatTrocaCliente);
  End;
end;

Function TfrmFatBaixaPedidoDev.fSqlFatDor: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   FATDOR.*,  ';
  strSQL := strSQL + '   FDO_UNIVIS, ';
  strSQL := strSQL + '   FDO_TAXJUR, ';
  strSQL := strSQL + '   FDO_VAL_RT, ';
  strSQL := strSQL + '   FDO_INCDEV, ';
  strSQL := strSQL + '   FDO_PIGBAS  ';

  If fatVenda.fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
  Begin
    strSQL := strSQL + ' ,FDO_COMPEC, ';
    strSQL := strSQL + '  FDO_LARPEC, ';
    strSQL := strSQL + '  FDO_ESPPEC, ';

    strSQL := strSQL + '  FDO_APAREL, ';
    strSQL := strSQL + '  FDO_PERAPA, ';
    strSQL := strSQL + '  FDO_BENEFI, ';
    strSQL := strSQL + '  FDO_PERBEN  ';
  End;

  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + '   FATDOR ';
  strSQL := strSQL + '   LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = FATDOR.AUTOINCREM  ';

  If fatVenda.fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
    strSQL := strSQL + ' LEFT JOIN ORCMAD M ON M.FDO_SEQGER = FATDOR.AUTOINCREM  ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   FATDOR.FDO_ESPDOC = "PR" AND   ';
  strSQL := strSQL + '   FATDOR.FDO_SEQGER = :AUTINC    ';

  Result := strSQL;
End;

function TfrmFatBaixaPedidoDev.fTravaPedido: Boolean;
var
  intIndex: Integer;
  strChave: String;
begin
  Result := True;

  strChave := 'BAIXA_PEDIDO_DEVOLUCAO_' +
              cdsConsulta.FieldByName('NUMDOC').AsString + '-' +
              cdsConsulta.FieldByName('ESPDOC').AsString + '-' +
              cdsConsulta.FieldByName('CODEMP').AsString;

  intIndex := stlListSelecao.IndexOf(cdsConsulta.FieldByName('AUTOINCREM').AsString);
  If (intIndex < 0) Then
  Begin
    If Not objLock.fLock_Unlock(strChave, True, False) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'Este pedido está sendo baixado por outra estação: ' + fGetHostLock(strChave), ['&Ok']);
      Exit;
    End;
  End
  Else
    objLock.fLock_Unlock(strChave, False, False);
end;

Function TfrmFatBaixaPedidoDev.fIncluiItens(fatVenda: TFatVenda; var strTipFre: string; var fltValFre: Double; var fltDesAce: Double; var fltDesEsp: Double): Boolean;
  Var
    qryGenIte   : TUniQuery;
    qryFatDor   : TUniQuery;
    recForTin   : TForTin;
    intIndice   : Integer;

    recMadeira  : TDadosMadeira;
    recAlqOrgDemaisImpostos: TAlqOrgDemaisImpostos;

    strIncDev,
    strTabDev   : String;

    function fInsereComoBrinde: Boolean;
    begin
      Result := False;

      If (Not fEmptyStr(fRetComplementoStrClaDevBrinde('PR'))) Then
      Begin
        Result := (Pos(qryFatDor.FieldByName('FDO_CLAFIS').AsString, fRetComplementoStrClaDevBrinde('PR')) > 0);
      End;
    end;
    
Begin

  Try
    qryGenIte := fCriaQuery(Self);
    qryFatDor := fCriaQuery(Self);
    qryFatDor.SQL.Text := fSqlFatDor;

    SetLength(fatVenda.arrPedidosDev, stlListSelecao.Count);

    For intIndice := 0 To stlListSelecao.Count - 1 Do
    Begin
      With qryFatDor Do
      Begin
        cdsConsulta.Locate('AUTOINCREM', stlListSelecao[intIndice], []);
        With fatVenda.arrPedidosDev[intIndice] Do
        Begin
          strNumPed := cdsConsulta.FieldByName('NUMDOC').AsString;
          strEspPed := cdsConsulta.FieldByName('ESPDOC').AsString;
          strEmpPed := cdsConsulta.FieldByName('CODEMP').AsString;
        End;

        Close;
        ParamByName('AUTINC').AsString := stlListSelecao[intIndice];
        Open;

        While Not Eof Do
        Begin

          {Req.: 108201 - Se tabela de preço vazia pega do item, para não ocorrer falhas,
           no cálculo de comissão.}
          If fEmptyStr(fatVenda.strTabPre) Then
            fatVenda.strTabPre := FieldByName('FDO_TABPRE').AsString;

          fatVenda.fGetItem(qryGenIte,FieldByName('FDO_CODITE').AsString, FieldByName('FDO_EMPITE').AsString);

          fltValFre := fltValFre + FieldByName('FDO_TOTFRE').AsFloat;
          fltDesAce := fltDesAce + FieldByName('FDO_DESACE').AsFloat;
          fltDesEsp := fltDesEsp + FieldByName('FDO_DESESP').AsFloat;

          If fatVenda.fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
          Begin
            recMadeira.fltComPec := FieldByName('FDO_COMPEC').AsFloat;
            recMadeira.fltLarPec := FieldByName('FDO_LARPEC').AsFloat;
            recMadeira.fltEspPec := FieldByName('FDO_ESPPEC').AsFloat;

            recMadeira.fltQtdPec := fCalculaQuantidadePecas(FieldByName('FDO_QTDITE').AsFloat,
                                                            recMadeira.fltComPec,
                                                            recMadeira.fltLarPec,
                                                            recMadeira.fltEspPec,
                                                            fRetSiglaUnidade(FieldByName('FDO_UNIDAD').AsString));

            recMadeira.strAparel := FieldByName('FDO_APAREL').AsString;
            recMadeira.fltPerApa := FieldByName('FDO_PERAPA').AsFloat;
            recMadeira.strBenefi := FieldByName('FDO_BENEFI').AsString;
            recMadeira.fltPerBen := FieldByName('FDO_PERBEN').AsFloat;
          End;

          recAlqOrgDemaisImpostos := fRetAlqOrgDemaisImpostos(FieldByName('FDO_INCDEV').AsString,
                                                              FieldByName('FDO_DOCDEV').AsString,
                                                              FieldByName('FDO_ESPDEV').AsString,
                                                              FieldByName('FDO_EMPDEV').AsString,
                                                              FieldByName('FDO_CODITE').AsString);
          strIncDev := FieldByName('FDO_INCDEV').AsString;
          strTabDev := 'MOVDET';
          If fCampoTabela('CONCAT(DET_NUMDOC,DET_ESPDOC,DET_CODEMP)', 'NOTDET', ['AUTOINCREM'], [strIncDev]) = 
             Concat(FieldByName('FDO_DOCDEV').AsString,FieldByName('FDO_ESPDEV').AsString,FieldByName('FDO_EMPDEV').AsString) Then
          Begin
            strTabDev := 'NOTDET';
          End;                                                                     

          fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                               Nil,
                                               'NOR',
                                               qryGenIte.FieldByName('ITE_CODGRU').AsString,
                                               FieldByName('FDO_CODITE').AsString,
                                               qryGenIte.FieldByName('ITE_DESITE').AsString,
                                               FieldByName('FDO_DESCRI').AsString,
                                               qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                               FieldByName('FDO_UNIDAD').AsString,
                                               FieldByName('FDO_UNIDAD').AsString,
                                               FieldByName('FDO_CODMAR').AsString,
                                               FieldByName('FDO_FORITE').AsString,
                                               FieldByName('FDO_REFERE').AsString,
                                               FieldByName('FDO_UNIORI').AsFloat,
                                               FieldByName('FDO_UNIVIS').AsFloat,
                                               FieldByName('FDO_UNITAR').AsFloat,
                                               0.0,
                                               FieldByName('FDO_DESCON').AsFloat,
                                               FieldByName('FDO_QTDITE').AsFloat,

                                               FieldByName('FDO_UNITAR').AsFloat*FieldByName('FDO_QTDITE').AsFloat,

                                               'E',
                                               FieldByName('FDO_TOTCUS').AsFloat / FieldByName('FDO_QTDITE').AsFloat,
                                               FieldByName('FDO_TOTCUS').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                               qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                               qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE1').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE2').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE3').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE4').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE5').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE6').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREVE7').AsFloat,
                                               fCalculaPrecoVenda(2, FieldByName('FDO_TOTCUS').AsFloat, FieldByName('FDO_UNITAR').AsFloat, 0, 0, 0, 0, 0),
                                               qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                               FieldByName('FDO_INCPIS').AsString,
                                               qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                               FieldByName('FDO_DOCDEV').AsString,
                                               FieldByName('FDO_ESPDEV').AsString,
                                               FieldByName('FDO_EMPDEV').AsString,
                                               0,
                                               0,
                                               strIncDev,
                                               qryGenIte.FieldByName('ITE_PREULT').AsFloat * FieldByName('FDO_QTDITE').AsFloat,
                                               qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREMED').AsFloat,
                                               qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                               FieldByName('FDO_ITECHA').AsString,
                                               FieldByName('FDO_ITETIN').AsString,
                                               FieldByName('FDO_DESCOR').AsString,
                                               FieldByName('FDO_TIPPRE').AsString,
                                               FieldByName('FDO_LAZQUA').AsInteger,
                                               FieldByName('FDO_TIPEMB').AsString,
                                               0,
                                               0,
                                               FieldByName('FDO_PRVTIN').AsFloat,
                                               FieldByName('FDO_PRCTIN').AsFloat,
                                               FieldByName('FDO_FATTIN').AsFloat,
                                               'N',
                                               '',
                                               0,
                                               0,
                                               qryGenIte.FieldByName('ABF_CODABF').AsString,
                                               qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                               FieldByName('FDO_PROMOC').AsString,
                                               0,
                                               0,
                                               0,
                                               0,
                                               IIF(fEmptyStr(FieldByName('FDO_SEQTIN').AsString), '', '2'),
                                               fatVenda.fRetPerComGrupo(qryGenIte.FieldByName('ITE_CODGRU').AsString),
                                               qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                               -1,
                                               0,
                                               '',
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                               fRetNomMarca(FieldByName('FDO_CODMAR').AsString),
                                               '',
                                               0,
                                               0,
                                               strIncDev,
                                               '',
                                               '',
                                               0,
                                               '',
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                               FieldByName('FDO_UNITAR').AsFloat,
                                               qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                               '',
                                               FieldByName('FDO_CODDIV').AsString,
                                               qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                               '',
                                               '',
                                               fRetSiglaUnidade(FieldByName('FDO_UNIDAD').AsString),
                                               FieldByName('FDO_VOLPRO').AsFloat,
                                               Succ(intIndice),
                                               '',
                                               FieldByName('FDO_CODACA').AsString,
                                               FieldByName('FDO_EMPACA').AsString,
                                               FieldByName('FDO_PROACA').AsString = 'S',
                                               '',
                                               '',
                                               '',
                                               recAlqOrgDemaisImpostos.fltOutVal,
                                               0,
                                               recAlqOrgDemaisImpostos.fltDesOpe,
                                               recAlqOrgDemaisImpostos.fltIcmSai,
                                               recAlqOrgDemaisImpostos.fltImpFed,
                                               0,
                                               '',
                                               '',
                                               '',
                                               FieldByName('FDO_TABPRE').AsString,
                                               qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                               qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                               '',
                                               0.0,
                                               '',
                                               0.0,
                                               '',
                                               '',
                                               'N',
                                               '',
                                               0,
                                               FieldByName('FDO_QTDITE').AsFloat,
                                               0.0,
                                               0,
                                               qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                               '',

                                               FieldByName('FDO_TOTCU2').AsFloat / FieldByName('FDO_QTDITE').AsFloat,
                                               FieldByName('FDO_TOTCU2').AsFloat,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               recForTin,
                                               '',
                                               FieldByName('FDO_NUMLOT').AsString,
                                               FieldByName('FDO_NUMLOT').AsString,
                                               '',
                                               '',
                                               False,
                                               FieldByName('FDO_PIGBAS').AsString,
                                               FieldByName('FDO_IDEPRO').AsString,
                                               FieldByName('FDO_QTDITE').AsFloat,
                                               strTabDev,
                                               qryGenIte.FieldByName('ITE_CODBAR').AsString,
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               0,
                                               True,
                                               '',
                                               '',
                                               '',
                                               0,
                                               qryGenIte.FieldByName('ITE_PRECUS').AsFloat,
                                               '',
                                               '',
                                               recMadeira,
                                               qryGenIte.FieldByName('ITE_IMPULT').AsFloat * FieldByName('FDO_QTDITE').AsFloat,
                                               FieldByName('FDO_VAL_RT').AsFloat,
                                               FieldByName('FDO_TAXJUR').AsFloat,
                                               '',
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               FieldByName('FDO_CODVEN').AsString,
                                               'N',
                                               0,
                                               0,
                                               0,
                                               False,
                                               False,
                                               'N',
                                               '',
                                               0,
                                               0,
                                               '',
                                               'N',
                                               0,
                                               '',
                                               '',
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_EXCIPI').AsString,
                                               0,
                                               strIncDev,
                                               '',
                                               '',
                                               'S',
                                               IIF(fInsereComoBrinde, 'S', 'N'),
                                               '',
                                               '',
                                               '',
                                               '',
                                               False,
                                               -1,
                                               -1,
                                               'N',
                                               '',
                                               'N',
                                               0,
                                               0,
                                               0,
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               0,
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               False,
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               'N',
                                               'N',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               0,
                                               qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMMG').AsFloat,
                                               0,
                                               '',
                                               'S',
                                               '',
                                               0,
                                               '',
                                               0,
                                               0,
                                               '',
                                               False,
                                               0,
                                               '',
                                               '',
                                               '',
                                               '',
                                               0,
                                               False,
                                               0,
                                               0,
                                               True,
                                               True,
                                               'N',
                                               False,
                                               cdsConsulta.FieldByName('NUMDOC').AsString + '-' +
                                                cdsConsulta.FieldByName('ESPDOC').AsString + '-' +
                                                cdsConsulta.FieldByName('CODEMP').AsString);



          strTipFre:=fRetornaInformacaoVenda(FieldByName('FDO_DOCDEV').AsString,
                                             FieldByName('FDO_ESPDEV').AsString,
                                             FieldByName('FDO_EMPDEV').AsString,
                                             'TIPFRE');

          Next;
        End; {While}

      End; {With qryFatDor Do}

    End; {For}

    Result := TRUE;

    FreeAndNil(qryGenIte);
    FreeAndNil(qryFatDor);

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmFatBaixaPedidoDev.fIncluiItens]');
    End;

  End;

End;

Procedure TfrmFatBaixaPedidoDev.pSetTipoFaturamento(fatVenda: TFatVenda);
Begin
  If Pos(strEspSel, 'NF_EL_IF_IV_NV_D1_') > 0 Then
  Begin
    fatVenda.strEspDoc := 'NF';
    fatVenda.strTipFat := 'Nota Fiscal';
  End
  Else
  Begin
    fatVenda.strEspDoc := 'DV';
    fatVenda.strTipFat := 'Devolução';
  End;
End;

function TfrmFatBaixaPedidoDev.fPedidosJaFaturados: Boolean;
var
  intIndex: Integer;

  Function fPedidoJaFaturado(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  var
    qryAux: TUniQuery;
  Begin
    qryAux := fCriaQuery;
    Try
      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT FGO_JAFATU FROM FATGOR ');
        SQL.Add('WHERE FGO_NUMDOC = :NUMDOC AND ');
        SQL.Add('      FGO_ESPDOC = :ESPDOC AND ');
        SQL.Add('      FGO_CODEMP = :CODEMP ');
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;
        Result := FieldByName('FGO_JAFATU').AsInteger = 1;
        Close;
      End;
    Finally
      FreeAndNil(qryAux);
    End;

  End;

begin
  Result   := False;

  With cdsConsulta Do
  Begin

    DisableControls;
    First;

    While Not Eof Do
    Begin
      intIndex := stlListSelecao.IndexOf(cdsConsulta.FieldByName('AUTOINCREM').AsString);
      If (intIndex >= 0) Then
      Begin

        If fPedidoJaFaturado(cdsConsulta.FieldByName('NUMDOC').AsString,
                             cdsConsulta.FieldByName('ESPDOC').AsString,
                             cdsConsulta.FieldByName('CODEMP').AsString) Then
        Begin
          Result := True;
          fMensagem('ATENÇÃO!', 'Existem pedidos selecionados e já faturados. Refaça a seleção!', ['&Ok']);
          fValidaCampos(edtCodCliente);
          Break;
        End;

      End;

      Next;
    End;

    First;
    EnableControls;
  End;

end;

function TfrmFatBaixaPedidoDev.fSQLCadastroItem: String;
  Var
    strSQL: String;
    strCampoABF: String;
begin
  If fCfgSis('TIPABF') = '1' Then
    strCampoABF := 'C.ITE_CODABF'
  Else
    strCampoABF := 'I.ITE_CODABF';

  strSQL := '';
  strSQL := strSQL + '  SELECT                             ';
  strSQL := strSQL + '    C.ITE_CODGRU,                    ';
  strSQL := strSQL + '    C.ITE_DESITE,                    ';
  strSQL := strSQL + '    C.ITE_REFERE,                    ';
  strSQL := strSQL + '    C.ITE_CODFAB,                    ';
  strSQL := strSQL + '    C.ITE_RPRENT,                    ';
  strSQL := strSQL + '    C.ITE_CLAIPI,                    ';
  strSQL := strSQL + '    C.ITE_UNICOM,                    ';
  strSQL := strSQL + '  ' + strCampoABF + '                ';
  strSQL := strSQL + '  FROM                               ';
  strSQL := strSQL + '    CADITE C                         ';
  strSQL := strSQL + '    LEFT JOIN ITEGER I               ';
  strSQL := strSQL + '      ON C.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '  WHERE                              ';
  strSQL := strSQL + '        C.ITE_CODITE = :CODITE       ';
  strSQL := strSQL + '    AND I.ITE_CODEMP = :CODEMP       ';

  Result := strSQL;
end;

function TfrmFatBaixaPedidoDev.fSQLItensPedidoDev: String;
begin
  Result := EmptyStr;
  Result := Result + ' SELECT FDO_CODITE, FDO_UNITAR, FDO_QTDITE, FDO_TOTITE, FDO_ALQIPI, ';
  Result := Result + '        FDO_BASIPI, FDO_VALIPI, FDO_ALQICM, FDO_BASICM, FDO_VALICM, FDO_CODITE, FDO_UNIDAD, FDO_NUMDOC, ';
  Result := Result + '        FDO_ESPDOC, FDO_CODEMP, FDO_CODCLI, FDO_NUMLOT, FDO_CODACA, FDO_EMPACA, FDO_PROACA, FDO_DESCRI, ';
  Result := Result + '        FDO_VALRET, FDO_BASRET, FDO_ALQRET, FDO_DESESP, FATDOR.AUTOINCREM, ';
  Result := Result + '        FDO_INCDEV, ';
  Result := Result + '        FDO_DOCDEV, ';
  Result := Result + '        FDO_ESPDEV, ';
  Result := Result + '        FDO_EMPDEV ';
  Result := Result + 'FROM FATDOR ';
  Result := Result + 'LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = FATDOR.AUTOINCREM ';
  Result := Result + '  WHERE FDO_CODEMP = :CODEMP ';
  Result := Result + '    AND FDO_NUMDOC = :NUMDOC ';
  Result := Result + '    AND FDO_ESPDOC = :ESPDOC ';
end;

procedure TfrmFatBaixaPedidoDev.pDestruirCdsVenda;
begin
  If (cdsVenda = Nil) Then
    Exit;
  If cdsVenda.Active Then
    cdsVenda.Close;
  pFreeCdsVenda;
end;

end.

