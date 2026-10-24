unit untImportacaoSfaMobAndroid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Gauges, StdCtrls, CheckLst, Mask, UniClientDataSet, DB,
  DirectoryEditFocus, AppEvnts, Menus, Buttons, ExtCtrls, untArquivosExportar,
  Uni, ComCtrls, Grids, DBGridCitel, DBGrids,
  frxClass, frxDBSet, FilenameEditFocus, BitBtnLockedIncrem,
  untZClient, cxControls, cxContainer, cxEdit, cxProgressBar, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, untGravaMovCar,
  frxExportCSVTestabilidade, untFuncFat, untFuncFatTypes, untEnderecoEntrega,
  untFuncoesSimples, untTypesSistema, untAdiantamentoClienteGenerico, System.ImageList,
  Vcl.ImgList, untLiberacao, Datasnap.DBClient, untCadCid, untRcxDigCartoes,
  Faturamento.Origem.TOrigemFaturamento, untLogAltCadCli;

type
  TDocPck = record
    blnExiste: Boolean;
    strNumDoc,
    strEspDoc,
    strCodCli,
    strNumPok: String;
  end;

type
  TDadosAdicCartao = record
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
    strNumPok: String;
    dtaDtaCar: TDateTime;
    dtaDtaCup: TDateTime;
    fltTotVen: Double;
    fltTxDsGe: Double;
    fltTxDsPa: Double;
    strTxDsGe: String;
    strTxDsPa: String;
    intQtdPar: Integer;
  end;

type
  TImportaEmpresaSfa = (iesNaoUtilizarMultiEmpresa, iesMultiEmpresaCD, iesEmpresaDaTabelaFS);

type
  TfrmImportacaoSfaMobAndroid = class(TfrmPai)
    btnImporta: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    pgcDados: TPageControl;
    tbDados: TTabSheet;
    pnl2: TPanel;
    mmoLogImp: TMemo;
    pnlProgressoGeral: TPanel;
    lblProgressoGeral: TLabel;
    pnlProgressoDetalhes: TPanel;
    lblProgressoDetalhes: TLabel;
    pnl3: TPanel;
    grp3: TGroupBox;
    chkLstItensExportar: TCheckListBox;
    pnl4: TPanel;
    pgbProgressoDetalhes: TcxProgressBar;
    pgbProgressoGeral: TcxProgressBar;
    imgLista: TImageList;
    pnl1: TPanel;
    pgcPainel: TPageControl;
    tbsPedidos: TTabSheet;
    grpPedidos: TGroupBox;
    dbgPedidos: TDBGridCitel;
    grpItens: TGroupBox;
    dbgPedidosItens: TDBGridCitel;
    tbsClientes: TTabSheet;
    tbsCartoes: TTabSheet;
    grpClientes: TGroupBox;
    dbgClientes: TDBGridCitel;
    grpCartoes: TGroupBox;
    dbgCartoes: TDBGridCitel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnExcluir: TBitBtnLocked;
    btnCorrigeCep: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnImportaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgPedidosKeyPress(Sender: TObject; var Key: Char);
    procedure dbgPedidosItensKeyPress(Sender: TObject; var Key: Char);
    procedure dbgPedidosDrawColumnCell(Sender: TObject; const [Ref] Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgPedidosCellClick(Column: TColumn);
    procedure pgcPainelChange(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCorrigeCepClick(Sender: TObject);
  private
    { Private declarations }
    frmRcxDigCartoes : TfrmRcxDigCartoes;
    fatVenda   : TFatVenda;
    arquivosExportar: TArquivosExportar;
    intSemaforo: Integer;

    cdsPedidos: TZClient;
    cdsPedidosItens: TZClient;
    cdsClientes: TZClient;
    cdsCartoes: TZClient;

    qryImportados: TUniQuery;
    qryCadIte: TUniQuery;

    blnEmpFat: Boolean;
    blnSfaPag: Boolean;

    blnAmzSfa: Boolean;
    blnTabIte: Boolean;

    blnTemNaoVendaNaoVisita: Boolean;

    strAuxTra: String;

    strFTPFRE: String;
    strDecUni: String;
    strDecQtd: String;

    strTpdCex : String;

    strUMTEMP: String;

    strSCLNVT : String;

    cdsEndEnt : TUniClientDataSet;

    recDocPck : TDocPck;

    objLiberacao : TLiberacao;

    intPedidosAImportar: integer;

    strEspDoc: String;

    blnImportaEmpresaDaTabelaFS : Boolean;

    procedure pCalculaTotalItens;

    procedure pInicializaTela;
    procedure pDisparaMsgErro;
    procedure pSetaStatusImp(strTabela, strCampoChave, strValorChave, strStatus: String);
    procedure pSetaParaAguardandoTodosItensComErro;
    procedure pGravaLogImp(strTabe, strChav, strMens: String);
    procedure pGravaLogImpCartoes(strMsgErro, strNumPed: String);
    procedure pGravaLogImpNaoVenda(strMsgErro, strCodCli: String);
    procedure pGravaLogImpNaoVisita(strMsgErro, strCodCli: String);
    procedure pGravaLogImpClientes(strMsgErro, strCodCli: String);
    procedure pGravaLogImpAlteraStatusCdsPedido(strMsgErro: String);
    procedure pMarcaPedidoComoImportado(strNumPed: String);
    procedure pMarcaEndEntregaComoImportado(strNumPed: String);

    function fGetSQLPedidos: String;
    function fGetSQLPedidosItens: String;
    function fGetSQLClientes: String;
    function fGetSQLCartoes: String;
    function fGetConPagPedido: String;
    function fEntRet(strCliRet: String): String;
    function fEntFat(strCliRet: String): String;

    procedure pIncrementaMsgErro(Var varMsgErro: String; strTextoErro: String; blnRegistrarLogImp : Boolean = true);

    procedure pAtualizarTabelasAuxiliares;
    function fMsgCPFCNPJ(strTexto: String): String;
    procedure pAtivaScrolls(blnAtiva: Boolean);
    procedure pAfterScrollCds(DataSet: TDataSet);
    procedure pAjustaMascaraClientes;
    procedure pAjustaMascaraCartoes;
    procedure pAjustaMascaraPedidos;
    procedure pAjustaMascaraPedidosItens;
    function fRetCodTra:String;
    function fRetCodCliAutComPeloCPFCNPJ(strCPFCNPJ: String): String;
    function fRetLoteProduto(strCodIte, strNumLot: String): String;
    procedure pProcessarEnderecoPedido(blnCliNovo: Boolean; recFsCli, recCadCli: TRecEnderecoEntrega; blnCliNovoOuMesmoUF: Boolean = False);
    procedure pProcessarEnderecoEntregaPedido(recFsEndEnt: TRecEnderecoEntrega);
    Function fRetCodCid(strCEP, strLocal: String; Out strMsg: String): String;
    function fDocumentoBonificado(strCodTipoPedido: String): Boolean;
    function fGetRegraCodTipoPedido(strCodTipoPedido: String): String;
    function fInserirSubItens(cdsDados, cdsClone: TUniClientDataSet): Boolean;
    procedure pCriaEndEntCli;
    procedure pInsereOuEditaEndEnt(strCodCli, strAutEnt: String);
    procedure pRateiaValores(fltValFre: Double);
    procedure pAtivarMasterSourceItens;
    procedure pDesativarMasterSourceItens;
    procedure pAssociarItens;
    procedure pCriarDataSets;
    procedure pLigaDataSet;
    procedure pRegistrarProgresso(strTexto: String; lblInformacao: TLabel; pgbProgresso: TCxProgressBar; intInicio, intAtual, intFinal: Integer);
    procedure pRegistraLogImp(strTexto: String);
    procedure pDefineEmpresaImportação;

    function fCarregaItem(strCodIte: String): Boolean;

    function fGerarPedidosLiberacao: Boolean;
    function fCarregarPedidos: Boolean;
    function fCarregarPedidosItens: Boolean;
    procedure pAtualizandoLocalizacaoClientes;
    procedure pValidaVendedor;
    procedure pValidaTransportadora;
    procedure pRetTransportadoraEFrete(strCodRot: String; var strCodTra: String; var fltTotFre: Double);
    function fValidaMotivoBaixaPedidosNaoAprovados: Boolean;
    function fValidaMotivoBaixaPedidosComPrazoExcedido: Boolean;
    function fInsereCidade(strCEP, strLocal: String; Out strMsg: String): String;

    function fAlerta(strMsg:String): Boolean;
    procedure pValidaDadosBasicosPedidos;
    function fInsereAtualizaClienteRetCodCli(strCPFCNPJ: String; qryFs_CliRef: TUniQuery; Out strMSG: String): String;
    procedure pProcessarClientesTabFSCLIENTE;
    procedure pProcessarClientesTabFSPEDIDOCAB;
    function fAtualizaClienteTabFSPEDIDOCAB(strCpfCnp, strCodCli: String): Boolean;
    function fGravaPedidoComoEntregaPeloCd(strCodEmp: String): Boolean;
    function fTipoPedido(strTipPed: String): String;
    function fTipoFrete(strTipFre: String): String;
    function fProcessarTintaDeMaquina(strIdePro, strMd5Key, strDesIte, strCodEmp,
      strCodBasEmb: String; fltQtdEmb, fltQtdIte: Double; var recForTin: TForTin;
      recInfAut: TInfAut; dicRetorno: TDicionario): Boolean;
    procedure pAtualizarCodigoBase(cdsDados: TUniClientDataSet);
    function fProcessarEnderecoClientesTabFSENDENTREGA(Out strMsg: String): Boolean;
    function fPedidoJaImportadoNaTabelaFS(strNumPok: String): Boolean;
    function fPedidoJaImportadoNaTabelaFatGor(strNumPok: String): TDocPck;
    procedure pTratamentoItemEstrutura(cdsDados: TUniClientDataSet);
    function fEmpMob: String;
    function fImportaEmpresaDaTabelaFS: Boolean;
    function fVerificaPedidosComStatusDePagamentoAprovadoReprovado: TArrDadosImpressoesVenda;
    procedure pVerificaPedidosComStatusDePagamentoAguardando;
    function fGetStsPagto(strNumPok: String): TSfaStatusPagamento;
    procedure pImportarCartoes;
    procedure pImportaNaoVendaNaoVisita;
    function fGravarCartoes(arrCartoes: TCartoesResumoCaixaArray; recDadAdCar: TDadosAdicCartao): Boolean;
    procedure pMarcaCartaoComoImportado(strNumPed: String);
    function fPedidoTemMovCar(strNumPok: String): Boolean;
    function fGravarAdtCliCartao(strNumDoc, strEspDoc, strCodEmp, strCodCli, strNumPok: String; fltValCar: Double; intSeqConRcx: Integer): Boolean;
    procedure pImprimirDocumentosAprovados(arrDocsAprov: TArrDadosImpressoesVenda);
    function fCarregaMatrizDeItens(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): TMatrizFechamento;
    function fGetSQLNVenda: String;
    function fGetSQLNVisita: String;
    function fTemNaoVendaNaoVisita: Boolean;
    procedure pAcrescentaTentativaGravacao(strNumeroPedido: string);

    function fConfiguracoesDoPixPreenchidas: Boolean;
    function fPermissaoCorrigirCEP: Boolean;
    procedure pCorrigeCepCliente;
    procedure pCorrigeCepEntrega;
    procedure pAlteraCep(strTabela, strValorCampo, strValorChave: String; vrtValorCampoAnt: Variant);
    function fPedidoContemEnderecoDeEntrega(strNumPed: String): Boolean;
    procedure pAtualizarTabelasPedido;
    procedure pGravaLogAlteracaoCEP(strTabela, strChave, strCepNov: String; vrtCepAnt: Variant);
    procedure pAtualizaMovMod(ANumDoc, AEspDoc, ACodEmp, ACodCli, ACodCar, APixS_N: string);
    function fRetornaLoteComVerificacoes(strCodIte, strNumLot: String): String;
  protected
    function fGetCodCli(strCodCli, strCPFCNPJ: String): String;
    function fInsereCliente(strCPFCNPJ: String): String;
  public
    { Public declarations }
    objLogAltCadCli : TLogAltCadCli;
    blnModoRobo: Boolean;
  end;

procedure pMensagemOrcamentoCompra(strPed, strOrc: String; dtaDtaPed: TDateTime);
function fRetUnitarioSugestaoCompra(strCodIte, strCodEmp, strCodFor: String): Double;


const
  IMPORTA_EMPRESA_SFA : Array[TImportaEmpresaSfa] Of String = ('1', '2', '3');

implementation

uses
  {$IFNDEF LINUX}
    untArredondaParcelasCartoes,
  {$ENDIF LINUX}
  StrUtils, untFatGor, Faturamento.Classes.TEmitirPedido, untCadLote, untReimpressao,
  untTipoTinta, untImportaTintometricosTerceirosTabelas, untTMatrizSaldosColorantes,
  untFuncTinta, untFuncoes, untMovCar, untDuplicatas,
  untFuncFatImp, untConstantes, untMsgInterna, untArredondaParcelaImpl,
  untValidacoesRotasRegiao, untLibExt, untGerarOrcamentoCompraAuto,
  untTConsultaCadastroFit, untCadClientes, untAltCepImpostacaoSfa;

{$R *.dfm}

procedure pMensagemOrcamentoCompra(strPed, strOrc: String; dtaDtaPed: TDateTime);
  Var
    msgMensagem: TMsgInterna;
    qryCadOpe  : TUniQuery;
    stlMensagem: TStringList;
Begin
  qryCadOpe   := fCriaQuery;
  Try
    With qryCadOpe Do
    Begin
      SQL.Text := 'SELECT OPE_CODOPE AS CODOPE FROM CADOPE WHERE OPE_MSGOCD = "S"';
      Open;

      If Not IsEmpty Then
      Begin
        msgMensagem := TMsgInterna.Create(Nil);
        stlMensagem := TStringList.Create;
        Try
          stlMensagem.Add('ORÇAMENTO Nº: ' + strOrc);
          stlMensagem.Add('PEDIDO DO SITE Nº: ' + strPed);
          stlMensagem.Add('DATA: ' + FormatDateTime('dd/mm/yyyy', dtaDtaPed));

          While Not Eof Do
          Begin
            msgMensagem.fEnviaMensagem('Novo Orçamento de Compra gerado via importação de Pedidos Vindos do Site.',
                                       stlMensagem.Text,
                                       strLoginUsuarioLogado,
                                       FieldByName('CODOPE').AsString,
                                       'N',
                                       '');
            Next;
          End;
        Finally
          FreeAndNil(msgMensagem);
          FreeAndNil(stlMensagem);
        End;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryCadOpe);
  End;
end;

function fRetUnitarioSugestaoCompra(strCodIte, strCodEmp, strCodFor: String): Double;
  Var
    qryGen : TUniQuery;
    strSQL,
    strUniPcg : String;
Begin
  Result    := 0;
  qryGen    := fCriaQuery;
  strUniPcg := fCfgSis('UNIPCG');
  Try
    With qryGen Do
    Begin
      strSQL := 'SELECT ';

      {****************************************************}
      {* CASO NAO POSSUA PRECO ESPECIAL PARA O FORNECEDOR *}
      {* IRA PEGAR O PRECO DE SUGESTAO DA CONFIGURACAO    *}
      {*************************************************JC*}
      strSQL := strSQL + '  IFNULL( (SELECT              ';
      strSQL := strSQL + '              FPR_VALITE        ';
      strSQL := strSQL + '            FROM                ';
      strSQL := strSQL + '              FORPRE            ';
      strSQL := strSQL + '            WHERE               ';
      strSQL := strSQL + '              FPR_CODFOR = :CODFOR AND ';
      strSQL := strSQL + '              FPR_CODITE = :CODITE),   ';

      {******************************************}
      {* SE NAO ESTIVER CONFIGURADO O "UNIPCG"  *}
      {* ENTAO SERÁ UTILIZADO O VALOR DE COMPRA *}
      {* CONFIGURACAO UNIPCG = 1                *}
      {***************************************AN*}
      Case strUniPcg[1] Of
         '2',
         '6',
         '7': Begin
                strSQL := strSQL + ' IF(F.ITE_CODITE IS NULL, G.ITE_PRECOM, D.ITE_PRECOM / IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1)) * ';
                strSQL := strSQL + ' ( 1 - (IF(F.ITE_CODITE IS NULL, G.ITE_DESF01, D.ITE_DESF01) / 100) ) * ';
                strSQL := strSQL + ' ( 1 - (IF(F.ITE_CODITE IS NULL, G.ITE_DESF02, D.ITE_DESF02) / 100) ) * ';
                strSQL := strSQL + ' ( 1 - (IF(F.ITE_CODITE IS NULL, G.ITE_DESF03, D.ITE_DESF03) / 100) ) * ';
                strSQL := strSQL + ' ( 1 - (IF(F.ITE_CODITE IS NULL, G.ITE_DESF04, D.ITE_DESF04) / 100) ) * ';
                strSQL := strSQL + ' ( 1 - (IF(F.ITE_CODITE IS NULL, G.ITE_DESF05, D.ITE_DESF05) / 100) ) * ';
                strSQL := strSQL + ' ( 1 - (IF(F.ITE_CODITE IS NULL, G.ITE_DESF06, D.ITE_DESF06) / 100) ) ) AS ITE_UNIORI ';
              End;

         '3': Begin
                strSQL := strSQL + ' IF(F.ITE_CODITE IS NULL, G.ITE_PRECUS, D.ITE_PRECUS) ) AS ITE_UNIORI ';
              End;

         '4': Begin
                strSQL := strSQL + ' IF(F.ITE_CODITE IS NULL, G.ITE_PRECOM, D.ITE_PRECOM / IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1)) * ';
                strSQL := strSQL + ' ( 1 - (IF(F.ITE_CODITE IS NULL, G.ITE_DESF01, D.ITE_DESF01) / 100) ) * ';
                strSQL := strSQL + ' ( 1 - (IF(F.ITE_CODITE IS NULL, G.ITE_DESF02, D.ITE_DESF02) / 100) ) * ';
                strSQL := strSQL + ' ( 1 - (IF(F.ITE_CODITE IS NULL, G.ITE_DESF03, D.ITE_DESF03) / 100) ) * ';
                strSQL := strSQL + ' ( 1 - (IF(F.ITE_CODITE IS NULL, G.ITE_DESF04, D.ITE_DESF04) / 100) ) * ';
                strSQL := strSQL + ' ( 1 - (IF(F.ITE_CODITE IS NULL, G.ITE_DESF05, D.ITE_DESF05) / 100) ) * ';
                strSQL := strSQL + ' ( 1 - (IF(F.ITE_CODITE IS NULL, G.ITE_DESF06, D.ITE_DESF06) / 100) ) * ';
                strSQL := strSQL + ' ( 1 + (IF(F.ITE_CODITE IS NULL, G.ITE_ACRFIN, D.ITE_ACRFIN) / 100) ) ) AS ITE_UNIORI ';
              End;

         Else Begin
                { QUANDO UNIPCG = ' ' OU = 1 }
                strSQL := strSQL + ' IF(F.ITE_CODITE IS NULL, G.ITE_PRECOM, D.ITE_PRECOM) ) AS ITE_UNIORI ';
              End;
      End;

      strSQL := strSQL + ' FROM ITEGER G ';

      strSQL := strSQL + ' LEFT JOIN ITEFOR F ON F.ITE_CODITE = G.ITE_CODITE AND ';
      strSQL := strSQL + '                       F.ITE_CODFOR = :CODFOR AND ';
      strSQL := strSQL + '                      (SELECT COUNT(*) FROM TABPRE WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S") > 0 ';

      strSQL := strSQL + ' LEFT JOIN TABDET D ON D.ITE_CODTAB = F.ITE_CODTAB ';
      strSQL := strSQL + '                   AND D.ITE_CODITE = F.ITE_CODITE ';
      strSQL := strSQL + '                   AND D.ITE_CODEMP = G.ITE_CODEMP  ';

      strSQL := strSQL + ' WHERE G.ITE_CODITE = :CODITE AND G.ITE_CODEMP = :CODEMP ';

      SQL.Text := strSQL;

      ParamByName('CODITE').AsString  := strCodIte;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODFOR').AsString  := strCodFor;

      Open;
      If Not IsEmpty Then
        Result := qryGen.Fields[0].Value;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

{ TfrmImportacaoSfaMobAndroid }

procedure TfrmImportacaoSfaMobAndroid.pAjustaMascaraCartoes;
begin
  With cdsCartoes Do
  Begin
    TFloatField(FieldByName('VALORVENDA')).currency := True;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pAjustaMascaraClientes;
begin
  With cdsClientes Do
  Begin
    TStringField(FieldByName('CLI_C_E_P_')).EditMask := '99999-999;0;';
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pAjustaMascaraPedidos;
begin
  With cdsPedidos Do
  Begin
    TFloatField(FieldByName('TOTALPRODUTOS')).currency := True;
    TFloatField(FieldByName('TOTALBRUTO')).currency := True;
    TFloatField(FieldByName('TOTALLIQUIDO')).currency := True;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pAjustaMascaraPedidosItens;
begin
  With cdsPedidosItens Do
  Begin
    TFloatField(FieldByName('PRECOLIQUIDO')).currency := True;
    TFloatField(FieldByName('DESCONTOITEM')).currency := True;
    TFloatField(FieldByName('TOTALITEM')).currency := True;
    TFloatField(FieldByName('TOTALFINAL')).currency := True;
    TFloatField(FieldByName('VALFREITE')).currency := True;
    TFloatField(FieldByName('QTDEVENDA')).DisplayFormat := '0.00';
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pAlteraCep(strTabela, strValorCampo,
  strValorChave: String; vrtValorCampoAnt: Variant);
var
  qryCep: TUniQuery;
  strCampo: String;
  strChave: String;
begin
  qryCep := fCriaQuery;

  try
    strCampo := IIF(strTabela = 'FSCLIENTE', 'CLI_C_E_P_', 'ENT_CEPENT');
    strChave := IIF(strTabela = 'FSCLIENTE', 'CLI_CODIGOCLIENTE', 'ENT_NUMEROPEDIDO');

    qryCep.Close;
    qryCep.SQL.Clear;
    qryCep.SQL.Add('UPDATE '+strTabela+'');
    qryCep.SQL.Add('SET '+strCampo+' = :VALOR');
    qryCep.SQL.Add('WHERE '+strChave+' = :CHAVE');

    qryCep.ParamByName('VALOR').AsString := strValorCampo;
    qryCep.ParamByName('CHAVE').AsString := strValorChave;

    qryCep.ExecSQL;

    if (strTabela = 'FSCLIENTE') then
      pSetaStatusImp(strTabela, strChave, strValorChave, 'A')
    else
      pSetaStatusImp('FSPEDIDOCAB', 'NUMEROPEDIDO', strValorChave, 'A');

    pGravaLogAlteracaoCEP(strTabela, strValorChave, strValorCampo, vrtValorCampoAnt);
  finally
    FreeAndNil(qryCep);
  end;
end;

procedure TfrmImportacaoSfaMobAndroid.pAssociarItens;
begin
  arquivosExportar.fAdicionarItem('Dados do Pedido', fCarregarPedidos, True);
  arquivosExportar.fAdicionarItem('Itens do Pedido', fCarregarPedidosItens, True);
end;

procedure TfrmImportacaoSfaMobAndroid.pAtualizarCodigoBase(
  cdsDados: TUniClientDataSet);
begin
  cdsDados.First;
  While Not cdsDados.Eof Do
  Begin
    If (cdsDados.FieldByName('CODIGOPRODUTO').AsString = 'TINTA') Then
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('CODIGOPRODUTO').AsString := TImportaTintometrico.fGetCodIteBaseImobiliaria(cdsDados.FieldByName('IDEPRO').AsString,
                                                                                                       cdsDados.FieldByName('MD5KEY').AsString);
      cdsDados.Post;
    End;
    cdsDados.Next;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pAtualizarTabelasAuxiliares;
begin
  cdsClientes.fAbreClient(True, '[pCriarDataSets.cdsClientes]');
  pAjustaMascaraClientes;

  cdsCartoes.fAbreClient(True, '[pCriarDataSets.cdsCartoes]');
  pAjustaMascaraCartoes;
end;

procedure TfrmImportacaoSfaMobAndroid.pAtualizarTabelasPedido;
begin
  cdsPedidos.fAbreClient(True, '[pCriarDataSets.cdsPedidos]');
  pAjustaMascaraPedidos;

  cdsPedidosItens.fAbreClient(True, '[pCriarDataSets.cdsPedidosItens]');
end;

procedure TfrmImportacaoSfaMobAndroid.FormCreate(Sender: TObject);
begin
  inherited;
  fatVenda := TFatVenda.CreateInstance('VN');
  objLiberacao := TLiberacao.Create;

  blnModoRobo := False;
  objLogAltCadCli := TLogAltCadCli.Create(Self);

  blnSfaPag := fCfgSis('SFAPAG', varBoolean);
  blnEmpFat := fCfgSis('EMPFAT', varBoolean);
  blnAmzSfa := fCfgSis('AMZSFA', varBoolean);
  blnTabIte := fCfgSis('TABITE', varBoolean);
  strAuxTra := fCfgSis('TRASUG', varString);
  strFTPFRE := fCfgSis('FTPFRE');
  strDecUni := fCfgSis('DECUNI', VarString);
  strDecQtd := fCfgSis('DECQTD', VarString);
  strTpdCex := fCfgSis('TPDCEX');
  strUMTEMP := fCfgSis('UMTEMP', varString);
  strSCLNVT := fCfgSis('SCLNVT');
  blnImportaEmpresaDaTabelaFS := fImportaEmpresaDaTabelaFS;

  strEspDoc := fCfgSis('TPDSFM');

  If fEmptyStr(strEspDoc) Then
    strEspDoc := 'PD';

  arquivosExportar := TArquivosExportar.Create(chkLstItensExportar);
  intSemaforo := 0;
  pCriarDataSets;
  pCriaEndEntCli;
  pgcPainel.TabIndex := 0;
end;

procedure TfrmImportacaoSfaMobAndroid.FormDestroy(Sender: TObject);
begin
  If Assigned(cdsPedidos) Then
  Begin
    cdsPedidos.First;
    While not cdsPedidos.eof Do
    Begin
      fLock_Unlock('IMPSFA_' +cdsPedidos.FieldByName('NUMEROPEDIDO').AsString,
        False, False, False, '', False);

      cdsPedidos.Next;
    End;
  End;

  Try
    If (Assigned(cdsPedidosItens)) Then
    Begin
      If (Not blnModoRobo) Then
      Begin
        If cdsPedidosItens.Active Then
          cdsPedidosItens.Close;
      End;

      pDesativarMasterSourceItens;
    End;
  Except
    //
  End;

  If Assigned(qryImportados) Then
  Begin
    If qryImportados.Active Then
      qryImportados.Close;
    FreeAndNil(qryImportados);
  End;

  If Assigned(qryCadIte) Then
  Begin
    If qryCadIte.Active Then
      qryCadIte.Close;
    FreeAndNil(qryCadIte);
  End;

  If Assigned(cdsPedidos) Then
  Begin
    If cdsPedidos.Active Then
      cdsPedidos.Close;
    FreeAndNil(cdsPedidos);
  End;

  If Assigned(cdsPedidosItens) Then
  Begin
    If cdsPedidosItens.Active Then
      cdsPedidosItens.Close;
    FreeAndNil(cdsPedidosItens);
  End;

  If Assigned(cdsClientes) Then
  Begin
    If cdsClientes.Active Then
      cdsClientes.Close;
    FreeAndNil(cdsClientes);
  End;

  If Assigned(cdsCartoes) Then
  Begin
    If cdsCartoes.Active Then
      cdsCartoes.Close;
    FreeAndNil(cdsCartoes);
  End;

  If Assigned(cdsEndEnt) Then
  Begin
    If cdsEndEnt.Active Then
      cdsEndEnt.Close;
    FreeAndNil(cdsEndEnt);
  End;

  If Assigned(arquivosExportar) Then
  Begin
    FreeAndNil(arquivosExportar);
  End;

  If Assigned(fatVenda) Then
  Begin
    FreeAndNil(fatVenda);
  End;

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  if Assigned(objLogAltCadCli) then
    FreeAndNil(objLogAltCadCli);

  inherited;
end;

function TfrmImportacaoSfaMobAndroid.fGerarPedidosLiberacao: Boolean;
Var
  dadosItem       : TDadosProduto;
  dadosPedido     : TDadosPedido;
  objEmitirPedido : TEmitirPedido;
  dicRetorno      : TDicionario;

  strMsg,
  strEmpAnt,
  strInfAdiTinta : String;
  strMensagemErro: String;

  blnGravaPedidoComoEntregaPeloCd : Boolean;

  objLibExt : TLibExt;
  fltSaldoDisponivel : Double;

begin
  Result := cdsPedidos.RecordCount > 0;

  If Result Then
  Begin
    Try
      cdsPedidos.First;
      cdsPedidosItens.First;

      pnlProgressoDetalhes.Visible := True;
      pnlProgressoGeral.Visible    := True;

      While Not cdsPedidos.Eof Do
      Begin
        If (cdsPedidos.FieldByName('STATUSIMP').AsString <> 'I') Then
        Begin
          cdsPedidos.Next;
          Continue;
        End;

        strMsg := '';

        If (fPedidoJaImportadoNaTabelaFS(cdsPedidos.FieldByName('NUMEROPEDIDO').AsString)) Then
        Begin
          pIncrementaMsgErro(strMSG, 'O Pedido ' + cdsPedidos.FieldByName('NUMEROPEDIDO').AsString + ' já foi importado anteriormente, portando o mesmo não será importado!');
          pGravaLogImpAlteraStatusCdsPedido(strMSG);

          cdsPedidos.Next;
          Continue;
        End;

        recDocPck := fPedidoJaImportadoNaTabelaFatGor(cdsPedidos.FieldByName('NUMEROPEDIDO').AsString);
        If (recDocPck.blnExiste) Then
        Begin
          pIncrementaMsgErro(strMSG, 'O Pedido ' + recDocPck.strNumPok + ' já foi importado por outra estação sob o número: ' + '(' + recDocPck.strNumDoc + '-' + recDocPck.strEspDoc + '), portando o mesmo não será importado!');
          pGravaLogImpAlteraStatusCdsPedido(strMSG);

          cdsPedidos.Next;
          Continue;
        End;

        If (blnImportaEmpresaDaTabelaFS) And
           (fEmptyStr(cdsPedidos.FieldByName('CODIGOEMPRESA').AsString)) Then
        Begin
          pIncrementaMsgErro(strMSG, 'Código da empresa em branco no pedido [' + cdsPedidos.FieldByName('NUMEROPEDIDO').AsString + '], portando o mesmo não será importado!');
          pGravaLogImpAlteraStatusCdsPedido(strMSG);

          cdsPedidos.Next;
          Continue;
        End;

        pRegistrarProgresso('Aguarde, Gravando Pedidos...', lblProgressoGeral, pgbProgressoGeral, 0, cdsPedidos.RecNo, cdsPedidos.RecordCount);

        strEmpAnt := VS_strCodEmp;
        Try
          If (blnImportaEmpresaDaTabelaFS) Then
          Begin
            pSetaEmpresaLogada(cdsPedidos.FieldByName('CODIGOEMPRESA').AsString);
            blnTabIte    := fCfgSis('TABITE', varBoolean);
          End;

          objEmitirPedido := TEmitirPedido.Create(Nil);
          objEmitirPedido.blnModoRobo := blnModoRobo;
          objEmitirPedido.blnIgnorarValidacaoCest := True;
          objEmitirPedido.blnImportacaoSfaMobAndroid := True;

          objEmitirPedido.mmoInformacao := mmoLogImp;
          objEmitirPedido.lblInformacao := lblProgressoDetalhes;
          objEmitirPedido.pgbProgresso  := pgbProgressoDetalhes;

          dadosPedido.blnSfaPag := blnSfaPag;
          dadosPedido.strEmpLogSfa := strEmpAnt;

          With dadosPedido Do
          Begin
            strCodCli := cdsPedidos.FieldByName('CODIGOCLIENTE').AsString;
            strCodVen := cdsPedidos.FieldByName('CODIGOVENDEDOR').AsString;

            If fCfgSis('USADIG', varBoolean) Then
              strCodDig := cdsPedidos.FieldByName('CODIGOVENDEDOR').AsString
            Else
              strCodDig := strLoginUsuarioLogado;

            sfaStsPagto := fGetStsPagto(cdsPedidos.FieldByName('NUMEROPEDIDO').AsString);
            strConPag := fGetConPagPedido;
            strCodCnd := cdsPedidos.FieldByName('CODCONDPGTO').AsString;
            strCodFpg := cdsPedidos.FieldByName('CODFORMAPGTO').AsString;
            fltDesEsp := cdsPedidos.FieldByName('DESCONTOESPECIAL').AsFloat;
            strMen001 := cdsPedidos.FieldByName('ORDEMCOMPRA').AsString;
            strMen002 := cdsPedidos.FieldByName('OBSERVACAO2').AsString;
            strMenExp := cdsPedidos.FieldByName('OBSERVACAO1').AsString;
            strTipPed := fTipoPedido(cdsPedidos.FieldByName('CODTIPOPEDIDO').AsString);
            fltDesOpeGor := cdsPedidos.FieldByName('DESPESASOPERACIONAIS').AsFloat;
            strCodDiv := cdsPedidos.FieldByName('CODPROFISSIONAL').AsString;

            If fDocumentoBonificado(cdsPedidos.FieldByName('CODTIPOPEDIDO').AsString) Then
              strTipOpe := 'B'
            Else
              strTipOpe := 'V';

            strTipFre := fTipoFrete(cdsPedidos.FieldByName('TIPOFRETE').AsString);
            strTabPre := cdsPedidos.FieldByName('CODTABELAPRECO').AsString;
            strTipFin := 'P';
            strEntFat := fEntFat(cdsPedidos.FieldByName('CLIENTERETIRA').AsString);
            strNumPok := cdsPedidos.FieldByName('NUMEROPEDIDO').AsString;
            strNumCmp := cdsPedidos.FieldByName('NUMPEDCOMPRA').AsString;
            fltValFre := cdsPedidos.FieldByName('VALORFRETE').AsFloat;
            strCodTra := fRetCodTra;
            dtaHorImp := 0;
            dtaDtaTra := 0;
            dtaHorTra := 0;
            strCodRot := cdsPedidos.FieldByName('CODIGOROTA').AsString;
            dtaPreVis := VS_Date;
            OrigemFaturamento := TOrigemFaturamento.GetByCodigo(cdsPedidos.FieldByName('CODORIGEM').AsString);

            If (fCfgSis('SFADTA', varInteger) = 1) Then
            Begin
              dtaGraPed := cdsPedidos.FieldByName('DATAPEDIDO').AsDateTime;
              dtaDtaOri := cdsPedidos.FieldByName('DATAPEDIDO').AsDateTime;
              dtaHorPed := cdsPedidos.FieldByName('HORAFINAL').AsDateTime;
            End
            Else
            Begin
              dtaGraPed := VS_Date;
              dtaDtaOri := VS_Date;
              dtaHorPed := fTime();
            End;

            If fCfgSis('REGCID', varBoolean) Then
              pRetTransportadoraEFrete(cdsPedidos.FieldByName('CODIGOROTA').AsString, strCodTra, fltValFre);

            dadosPedido.strEspDoc := UpperCase(cdsPedidos.FieldByName('ESPECIE').AsString);

            If cdsEndEnt.FindKey([cdsPedidos.FieldByName('CODIGOCLIENTE').AsString]) Then
              strAutEnt := cdsEndEnt.FieldByName('AUTENT').AsString
            Else
              strAutEnt := '';

            blnGravaPedidoComoEntregaPeloCd := fGravaPedidoComoEntregaPeloCd(cdsPedidos.FieldByName('CODIGOEMPRESA').AsString);

            if not fEmptyStr(cdsPedidos.FieldByName('CODTIPOATENDIMENTO').AsString) then
              strCodTpA := cdsPedidos.FieldByName('CODTIPOATENDIMENTO').AsString
            else
              strCodTpA := fCfgSis('SFATPA', varString);

            strEnvLib := fCfgSis('SFALBP', varString);

            If (blnGravaPedidoComoEntregaPeloCd) Then
            Begin
              strEmp_CD := cdsPedidos.FieldByName('CODIGOEMPRESA').AsString;
              blnEnt_CD := True;
            End
            Else
            Begin
              strEmp_CD := '';
              blnEnt_CD := False;
            End;

            blnGravarDavPv := False;
            If (fCfgSis('PAFECF', varBoolean)) Then
              blnGravarDavPv := (dadosPedido.strTipPed = 'C');

            if fDataValida(cdsPedidos.FieldByName('DATAENTREGA').AsDateTime) then
              dtaEntrega := cdsPedidos.FieldByName('DATAENTREGA').AsDateTime;
          End;

          Result := objEmitirPedido.fIniciarPedido(dadosPedido);

          objEmitirPedido.objFatVenda.blnApenasLevantaExcecao := True;

          objEmitirPedido.objFatVenda.DadosPixDaVenda.GerarPixDaVenda := False;
          If objEmitirPedido.objFatVenda.strEspDoc = 'PD' Then
          Begin
            If fConfiguracoesDoPixPreenchidas Then
              objEmitirPedido.objFatVenda.DadosPixDaVenda.GerarPixDaVenda := fCampoTabela('CND_RECPIX',
                                                                                         'CADCND',
                                                                                         ['CND_CODIGO'],
                                                                                         [objEmitirPedido.objFatVenda.strCodCnd]) = 'S';

            If objEmitirPedido.objFatVenda.DadosPixDaVenda.GerarPixDaVenda Then
              objEmitirPedido.objFatVenda.DadosPixDaVenda.ValorDoPix := fFormataFloat(cdsPedidos.FieldByName('TOTALLIQUIDO').AsFloat, 2);
          End;

          If Not Result Then
          Begin
            pIncrementaMsgErro(strMSG, 'Não foi possível importar o Pedido ' + dadosPedido.strNumPok, false);
            pRegistraLogImp(strMSG);
            pGravaLogImpAlteraStatusCdsPedido(strMSG);
          End;

          if Assigned(objEmitirPedido.objFatVenda) then
            objEmitirPedido.objFatVenda.strOpcDocTrue := 'MO';

          If Result Then
          Begin
            cdsPedidosItens.First;
            Result := cdsPedidosItens.RecordCount > 0;

            While Not cdsPedidosItens.Eof And Result Do
            Begin
              pRegistrarProgresso('Aguarde, Inserindo Itens do Pedido...', lblProgressoDetalhes, pgbProgressoDetalhes, 0, cdsPedidosItens.RecNo, cdsPedidosItens.RecordCount);

              With dadosItem Do
              Begin
                dtaDtaPed := cdsPedidos.FieldByName('DATAPEDIDO').AsDateTime;
                fltDesCnd := cdsPedidosItens.FieldByName('DESCONTOCONDICAOPGTO').AsFloat;
                strNumLot := fRetLoteProduto(cdsPedidosItens.FieldByName('CODIGOPRODUTO').AsString, cdsPedidosItens.FieldByName('NUMEROLOTE').AsString);
                strCodIte := cdsPedidosItens.FieldByName('CODIGOPRODUTO').AsString;
                strIdePro := cdsPedidosItens.FieldByName('IDEPRO').AsString;
                strDesIte := cdsPedidosItens.FieldByName('DESCRICAOESPECIAL').AsString;
                fltQtdIte := cdsPedidosItens.FieldByName('QTDEVENDA').AsFloat;
                fltUniOri := cdsPedidosItens.FieldByName('PRECOTABELA').AsFloat;
                fltUnitar := cdsPedidosItens.FieldByName('PRECOLIQUIDO').AsFloat;

                If fCfgSis('IMPPRE') = '1' then
                Begin
                  fltDescon := 0.00;
                End
                Else
                  fltDescon := cdsPedidosItens.FieldByName('DESCONTO').AsFloat;

                strEntRet := fEntRet(cdsPedidosItens.FieldByName('CLIENTERETIRA').AsString);
                strMd5Key := Trim(cdsPedidosItens.FieldByName('MD5KEY').AsString);
                strPromoc := cdsPedidosItens.FieldByName('PROMOCAO').AsString;
                blnBxSbIt := (cdsPedidosItens.FieldByName('BXSBIT').AsString = 'S');
                strNumCmp := cdsPedidosItens.FieldByName('NUMEROORDEMCOMPRA').AsString;
                intNItCmp := cdsPedidosItens.FieldByName('NUMEROITEMNOPEDIDO').AsString;
                strIteEst := cdsPedidosItens.FieldByName('ITEMESTRUTURA').AsString;
                intSeqEst := cdsPedidosItens.FieldByName('SEQITEMESTRUTURA').AsInteger;
                fltUniEst := cdsPedidosItens.FieldByName('PRECOITEMESTRUTURA').AsFloat;
                fltQtdSbi := cdsPedidosItens.FieldByName('QUANTIDADESUBITEMESTRUTURA').AsFloat;
                fltUniSbi := cdsPedidosItens.FieldByName('PRECOSUBITEMESTRUTURA').AsFloat;
                strCodDiv := cdsPedidosItens.FieldByName('CODPROFISSIONAL').AsString;

                If (blnTabIte) And (Not fEmptyStr(cdsPedidosItens.FieldByName('CODTABELAPRECO').AsString)) Then
                  strTabIte := cdsPedidosItens.FieldByName('CODTABELAPRECO').AsString
                Else
                  strTabIte := cdsPedidos.FieldByName('CODTABELAPRECO').AsString;

                If (blnGravaPedidoComoEntregaPeloCd) Then
                  strEmpIte := cdsPedidos.FieldByName('CODIGOEMPRESA').AsString
                Else
                  strEmpIte := '';

                //Informacoes especificas a uma tinta automotiva
                FillChar(recInfAut, SizeOf(recInfAut), #0);
                recInfAut.strTipPre := cdsPedidosItens.FieldByName('TIPOPRECO').AsString;
                recInfAut.fltVolume := cdsPedidosItens.FieldByName('VOLUME').AsFloat;
                recInfAut.strTipCor := cdsPedidosItens.FieldByName('TIPOCOR').AsString;
                recInfAut.strCodDil := cdsPedidosItens.FieldByName('CODDILUENTE').AsString;
                recInfAut.fltPorDil := cdsPedidosItens.FieldByName('PORDILUICAO').AsFloat;
                recInfAut.strCodEmb := cdsPedidosItens.FieldByName('CODEMBALAGEM').AsString;
                recInfAut.fltPreEmb := cdsPedidosItens.FieldByName('PRECOEMBALAGEM').AsFloat;

                If strIdePro = 'WCP' Then
                  recInfAut.fltPrcTin := cdsPedidosItens.FieldByName('PRECOFINAL').AsFloat
                Else
                  recInfAut.fltPrcTin := 0;

                If strIdePro <> 'KIL' Then
                  recInfAut.strTipEmb := cdsPedidosItens.FieldByName('TIPOEMBALAGEM').AsString
                Else
                  recInfAut.strTipEmb := '';

                recInfAut.strLinha_ := cdsPedidosItens.FieldByName('LINHATINTA').AsString;
                recInfAut.fltQtdEmb := 0;
                If (strIdePro <> 'NOR') Then
                  If (fTipoTinta(strIdePro) = ttAutomotiva) Then
                     recInfAut.fltQtdEmb := fltQtdIte;

                FillChar(recForTin, SizeOf(recForTin), #0);
                recForTin.strTipCor := recInfAut.strTipCor;

                dicRetorno := TDicionario.Create();

                If (strIdePro <> 'NOR') Then
                Begin
                  strInfAdiTinta := 'MD5KEY: ' + strMd5Key;
                  Result := fProcessarTintaDeMaquina(strIdePro, strMd5Key, strDesIte,
                    cdsPedidos.FieldByName('CODIGOEMPRESA').AsString, strCodIte,
                    recInfAut.fltQtdEmb, fltQtdIte, recForTin, recInfAut, dicRetorno);
                End
                Else
                  strInfAdiTinta := '';
              End;

              fltSaldoDisponivel := fRetornaSaldoDisponivel(dadosItem.strCodIte,  // strCodIte: String;
                                                            False,                // blnCnvMl : Boolean = False;
                                                            True,                 // blnFaturamento: Boolean = True;
                                                            dadosItem.strNumLot,  // strNumLot : String = '';
                                                            True,                 // blnConsiderarPedidos : Boolean = True;
                                                            dadosItem.strEmpIte,  // strCodEmp: String = '';
                                                            '',
                                                            False,
                                                            True,
                                                            True,
                                                            IIf(dadosItem.strNumLot = 'A DEFINIR', True, False));
              dadosItem.strSemEst := '';
              if (fCfgSis('LIBSFA', varBoolean)) and (fltSaldoDisponivel <= 0) then
                dadosItem.strSemEst := 'S';

              Result := Result And objEmitirPedido.fInserirProduto(dadosItem, dicRetorno);

              If Not Result Then
              Begin
                pIncrementaMsgErro(strMSG, 'Não foi possível importar o produto [' + dadosItem.strCodIte + '] ' +
                                           'do Pedido [' + dadosPedido.strNumPok + '] ' + strInfAdiTinta);

                pIncrementaMsgErro(strMSG, objEmitirPedido.fGetMensagemErro);
              End;

              cdsPedidosItens.Next;
            End;

            If Result Then
            begin
              if fGetTempoDuracaoLock('IMPSFA_' +cdsPedidos.FieldByName('NUMEROPEDIDO').AsString) > StrToTime(TEMPO_UNLOCK_SFAMOB) then
                pDestravaLockForcado('IMPSFA_' +cdsPedidos.FieldByName('NUMEROPEDIDO').AsString, 0);

              if fLock_Unlock('IMPSFA_' +cdsPedidos.FieldByName('NUMEROPEDIDO').AsString,
                True, False, False, '', False) then
              begin
                pAcrescentaTentativaGravacao(cdsPedidos.FieldByName('NUMEROPEDIDO').AsString);

                Result := objEmitirPedido.fCalcularTotais And
                          objEmitirPedido.fValidarPedido  And
                          objEmitirPedido.fGravarPedido   And
                          objEmitirPedido.fGravarNumCmp;

                {Liberação de Pedidos Externos}
                If (Result) And fCfgSis('LIBEXT', varBoolean) Then
                Begin

                  If (Not fEmptyStr(cdsPedidos.FieldByName('NUMEROPEDIDO').AsString)) Then
                  Begin

                    {Bloqueado}
                    If (cdsPedidos.FieldByName('LIBPOK').AsString = 'N') Then
                    Begin

                      {No .create já insere a "LIBEXT" LIBPOK default = "N"}
                      objLibExt := TLibExt.Create(Self, cdsPedidos.FieldByName('NUMEROPEDIDO').AsString);

                      Try
                        objLibExt.strOpeBlo := cdsPedidos.FieldByName('LIBPOKOPERADOR').AsString;
                        objLibExt.strMotBlo := cdsPedidos.FieldByName('LIBPOKMOTIVO').AsString;
                        objLibExt.pBloquear;
                      Finally
                        objLibExt.Destroy;
                      End;

                    End;

                  End;

                End;

                fLock_Unlock('IMPSFA_' +cdsPedidos.FieldByName('NUMEROPEDIDO').AsString,
                  False, False, False, '', False);
              end
            end;

            If (Result) And (fCampoTabela('COUNT(*)', 'FATGOR', ['FGO_NUMPOK'], [dadosPedido.strNumPok]) > 0) Then
            Begin
              pMarcaPedidoComoImportado(dadosPedido.strNumPok);
              pIncrementaMsgErro(strMSG, 'Importou o pedido ' + dadosPedido.strNumPok + ' -> ' + objEmitirPedido.strDocEmitido +
                                 IIF(fEmptyStr(objEmitirPedido.fGetLisOrcCrosDock), '', ' -> Orçamento de Cross Docking -> '+objEmitirPedido.fGetLisOrcCrosDock));

              If Not fEmptyStr(objEmitirPedido.fGetLisOrcCrosDock) Then
                pMensagemOrcamentoCompra(dadosPedido.strNumPok, objEmitirPedido.fGetLisOrcCrosDock, dadosPedido.dtaDtaOri);

              pGravaLogImpAlteraStatusCdsPedido('');

              If (fCfgSis('LIBPED', varBoolean)) And (fCfgSis('LIBSFA', varBoolean)) And
                 (objEmitirPedido.fPedidoBloqueadoNaLiberacao) Then
              Begin
                fatVenda.strEspDoc := 'PD';
                fatVenda.strTipOpe := dadosPedido.strTipOpe;
                fatVenda.strCodCli := dadosPedido.strCodCli;
                fatVenda.strCliNom := fRetNomCliente(dadosPedido.strCodCli);
                fatVenda.strCodVen := dadosPedido.strCodVen;
                fatVenda.strConPag := dadosPedido.strConPag;

                fatVenda.fltTotGer := 0;
                fatVenda.strNumDoc := objEmitirPedido.strDocEmitido;

                If Assigned(objEmitirPedido.objFatVenda) Then
                Begin
                  fatVenda.fltTotGer := objEmitirPedido.objFatVenda.fltTotGer;
                  fatVenda.strNumDoc := objEmitirPedido.objFatVenda.strNumDoc;
                End;

                fatVenda.pMensagemOrcamentoPedido(True);
              End;

            End
            Else
            Begin
              pIncrementaMsgErro(strMSG, 'Não foi possível importar o pedido ' + dadosPedido.strNumPok, false);
              pRegistraLogImp(strMSG);
              pGravaLogImpAlteraStatusCdsPedido(strMSG);
              fAlerta(strMSG);
            End;

          End;
        Finally
          If (blnImportaEmpresaDaTabelaFS) Then
            pSetaEmpresaLogada(strEmpAnt);

          If Assigned(dicRetorno) Then
            FreeAndNil(dicRetorno);

          If Assigned(objEmitirPedido) Then
            FreeAndNil(objEmitirPedido);

        End;

        cdsPedidos.Next;

      End;

      pnlProgressoGeral.Visible := False;
      pnlProgressoDetalhes.Visible := False;

    Except
      On E: Exception Do
      Begin
        Result := False;
        strMensagemErro := E.Message;
        fRollBack;
        pIncrementaMsgErro(strMensagemErro,'', false);
        pRegistraLogImp(strMensagemErro);
        pGravaLogImpAlteraStatusCdsPedido(strMensagemErro);
        fMensagem('', strMensagemErro, ['&Ok']);
      End;
    End;
  End;

end;

procedure TfrmImportacaoSfaMobAndroid.btnImportaClick(Sender: TObject);
  Var
    stlLogImp: TStringList;
begin
  inherited;
  If blnModoRobo Then
    pInicializaTela;

  pgcPainel.TabIndex  := 0;
  intPedidosAImportar := 0;

  mmoLogImp.Clear;
  cdsEndEnt.EmptyDataSet;

  pAtivaScrolls(False);
  Try
    If InterlockedIncrement(intSemaforo) = 1 Then
    Begin
      blnTemNaoVendaNaoVisita := fTemNaoVendaNaoVisita;

      pSetaParaAguardandoTodosItensComErro;

      arquivosExportar.fGerarArquivos;

      chkLstItensExportar.Enabled := False;

      cdsPedidos.Filtered := False;
      cdsPedidos.Filter   := 'STATUSIMP = ''I''';
      cdsPedidos.Filtered := True;
      intPedidosAImportar := cdsPedidos.RecordCount;

      If (blnTemNaoVendaNaoVisita) Then
        pRegistraLogImp('Registros "Não Venda/Não Visita" identificados!');

      If (cdsPedidos.RecordCount > 0) Or (blnTemNaoVendaNaoVisita) Then
      Begin
        fAlerta('Importação concluída. Pronto para Gravar!');
        btnGravar.Enabled  := True;
        pnlInfo.Caption    := '';
        btnImporta.Enabled := False;
      End
      Else
      Begin
        fAlerta('Importação não realizada!');
      End;

      InterlockedDecrement(intSemaforo);

    End
    Else
      InterlockedDecrement(intSemaforo);
  Finally
    stlLogImp := TStringList.Create;
    stlLogImp.AddStrings(mmoLogImp.Lines);

    pAtivaScrolls(True);
    cdsPedidos.Filter := '';
    cdsPedidos.Filtered := False;

    mmoLogImp.Lines.Clear;
    mmoLogImp.Lines.Add(stlLogImp.Text);
    FreeAndNil(stlLogImp);

    pAtualizarTabelasAuxiliares;

    If Not(btnGravar.Enabled) and (intPedidosAImportar > 0) Then
    Begin
      If blnModoRobo Then
        pDisparaMsgErro;
    End;
  End
end;

procedure TfrmImportacaoSfaMobAndroid.pCriaEndEntCli;
begin
  cdsEndEnt := TUniClientDataSet.Create(Nil);

  With cdsEndEnt.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODCLI';
    DataType := ftString;
    Size := 8;
  End;

  With cdsEndEnt.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUTENT';
    DataType := ftString;
    Size := 20;
  End;

  cdsEndEnt.CreateDataSet;
  cdsEndEnt.IndexFieldNames := 'CODCLI';
end;

procedure TfrmImportacaoSfaMobAndroid.pCriarDataSets;
begin
  qryCadIte := fCriaQuery(Nil);
  qryCadIte.SQL.Add(' SELECT  ');
  qryCadIte.SQL.Add('   ITE_CODMAR, ');
  qryCadIte.SQL.Add('   ITE_DESITE, ');
  qryCadIte.SQL.Add('   ITE_REFERE, ');
  qryCadIte.SQL.Add('   ITE_CODUNI, ');
  qryCadIte.SQL.Add('   ITE_CODFOR, ');
  qryCadIte.SQL.Add('   ITE_PRECUS, ');
  qryCadIte.SQL.Add('   ITE_PREMED, ');
  qryCadIte.SQL.Add('   ITE_PESOIT  ');
  qryCadIte.SQL.Add(' FROM CADITE   ');
  qryCadIte.SQL.Add('   INNER JOIN ITEGER ');
  qryCadIte.SQL.Add(' ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ');
  qryCadIte.SQL.Add('     AND ITEGER.ITE_CODEMP = :CODEMP ');
  qryCadIte.SQL.Add('     AND CADITE.ITE_CODITE = :CODITE ');

  cdsPedidos := TZClient.Create(Nil, fGetSQLPedidos);
  cdsPedidos.fAbreClient(True, '[pCriarDataSets.cdsPedidos]');
  pAjustaMascaraPedidos;

  cdsPedidosItens := TZClient.Create(Nil, fGetSQLPedidosItens);
  cdsPedidosItens.fAbreClient(True, '[pCriarDataSets.cdsPedidosItens]');

  cdsClientes := TZClient.Create(Nil, fGetSQLClientes);
  cdsCartoes := TZClient.Create(Nil, fGetSQLCartoes);
  pAtualizarTabelasAuxiliares;

  pDesativarMasterSourceItens;
  pTratamentoItemEstrutura(cdsPedidosItens);
  pAtualizarCodigoBase(cdsPedidosItens);
  pAtivarMasterSourceItens;
  pAjustaMascaraPedidosItens;
end;

procedure TfrmImportacaoSfaMobAndroid.pDesativarMasterSourceItens;
begin
  cdsPedidosItens.MasterSource := nil;
  cdsPedidosItens.MasterFields := '';
  cdsPedidosItens.IndexFieldNames := '';
end;

procedure TfrmImportacaoSfaMobAndroid.pInicializaTela;
begin
  pDefineEmpresaImportação;
  pAssociarItens;
end;

procedure TfrmImportacaoSfaMobAndroid.pDisparaMsgErro;
  Var
    msgMensagem: TMsgInterna;
    qryCadOpe  : TUniQuery;
    stlMensagem: TStringList;
    strMsg: String;
Begin
  qryCadOpe := fCriaQuery;
  Try
    With qryCadOpe Do
    Begin
      SQL.Text := 'SELECT OPE_CODOPE AS CODOPE FROM CADOPE WHERE OPE_MSGSFA = "S"';
      Open;

      If Not IsEmpty Then
      Begin
        msgMensagem := TMsgInterna.Create(Nil);
        stlMensagem := TStringList.Create;
        Try
          strMsg := '';
          cdsPedidos.First;
          While Not cdsPedidos.Eof Do
          Begin
            If cdsPedidos.FieldByName('STATUSIMP').Text = 'E' Then
              pIncrementaListaStr(cdsPedidos.FieldByName('NUMEROPEDIDO').Text, strMsg);

            cdsPedidos.Next;
          End;
          If Not fEmptyStr(strMsg) Then
            stlMensagem.Add('PEDIDOS DO SITE Nº: ' + strMsg);

          strMsg := '';
          cdsClientes.First;
          While Not cdsClientes.Eof Do
          Begin
            If cdsClientes.FieldByName('STATUSIMP').Text = 'E' Then
              pIncrementaListaStr(cdsClientes.FieldByName('CLI_CODIGOCLIENTE').Text, strMsg);

            cdsClientes.Next;
          End;
          If Not fEmptyStr(strMsg) Then
            stlMensagem.Add('CLIENTES DO SITE: ' + strMsg);

          strMsg := '';
          cdsCartoes.First;
          While Not cdsCartoes.Eof Do
          Begin
            If cdsCartoes.FieldByName('STATUSIMP').Text = 'E' Then
              pIncrementaListaStr(cdsCartoes.FieldByName('NUMEROPEDIDO').Text, strMsg);

            cdsCartoes.Next;
          End;
          If Not fEmptyStr(strMsg) Then
            stlMensagem.Add('CARTÕES DO SITE: ' + strMsg);

          If stlMensagem.Count > 0 Then
            While Not qryCadOpe.Eof Do
            Begin
              msgMensagem.fEnviaMensagem('Há itens com erro na importação do Site/Tablet. Favor verificar!',
                                         stlMensagem.Text,
                                         strLoginUsuarioLogado,
                                         FieldByName('CODOPE').AsString,
                                         'N',
                                         '');
              qryCadOpe.Next;
            End;

        Finally
          FreeAndNil(msgMensagem);
          FreeAndNil(stlMensagem);
        End;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryCadOpe);
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pgcPainelChange(Sender: TObject);
begin
  inherited;
  btnExcluir.Enabled := False;
  btnCorrigeCep.Visible := False;
end;

procedure TfrmImportacaoSfaMobAndroid.pInsereOuEditaEndEnt(strCodCli,
  strAutEnt: String);
begin
  If (fEmptyStr(strCodCli)) Or (fEmptyStr(strAutEnt)) Then
    Exit;

  If Not cdsEndEnt.FindKey([strCodCli]) Then
  Begin
    cdsEndEnt.Append;
    cdsEndEnt.FieldByName('CODCLI').AsString := strCodCli;
  End
  Else
    cdsEndEnt.Edit;

  cdsEndEnt.FieldByName('AUTENT').AsString := strAutEnt;
  cdsEndEnt.Post;
end;

procedure TfrmImportacaoSfaMobAndroid.pAtivarMasterSourceItens;
begin
  cdsPedidosItens.MasterFields := 'NUMEROPEDIDO';
  cdsPedidosItens.IndexFieldNames := 'NUMEROPEDIDO';
  cdsPedidosItens.MasterSource := cdsPedidos.dtsSource;
end;

function TfrmImportacaoSfaMobAndroid.fCarregarPedidos: Boolean;
  Var
    strMSG: String;
begin
  Result := True;

  pnlProgressoGeral.Visible := True;
  pnlProgressoDetalhes.Visible := False;
  Try
    Try
      {*************************************************************************}
      {* PROCESSAMENTO DA TABELA FSCLIENTE É INDEPENDENTE DA TABELA DE PEDIDOS *}
      {**********************************************************************VA*}
      pRegistraLogImp('Inserindo/Atualizando dados de clientes!');
      pProcessarClientesTabFSCLIENTE;

      With cdsPedidos Do
      Begin
        fAbreClient(True, 'TfrmImportacaoSfaMobAndroid.fCarregarPedidos');
        pAjustaMascaraPedidos;

        If IsEmpty Then
        Begin
          If blnTemNaoVendaNaoVisita Then
          Begin
             Result := False;
             pRegistraLogImp('Não há pedidos para importar!');
          End
          Else
          Begin
            Result := False;
            fAlerta('Não há pedidos para importar!');
          End;
        End
        Else
        Begin
          pRegistraLogImp('Iniciou a importação dos pedidos!');

          If Result Then
          Begin
            pRegistraLogImp('Validando preenchimento do motivo da baixa dos pedidos não aprovados!');
            Result := fValidaMotivoBaixaPedidosNaoAprovados;
          End;

          If Result Then
          Begin
            pRegistraLogImp('Validando preenchimento do motivo para baixa dos pedidos com prazo para regularização excedido!');
            Result := fValidaMotivoBaixaPedidosComPrazoExcedido;
          End;

          If Result Then
          Begin
            First;
            While Not Eof Do
            Begin
              strMSG := '';

              pRegistrarProgresso('Aguarde, Importando Pedidos...', lblProgressoGeral, pgbProgressoGeral, 0, RecNo, RecordCount);

              recDocPck := fPedidoJaImportadoNaTabelaFatGor(FieldByName('NUMEROPEDIDO').AsString);
              If (recDocPck.blnExiste) Then
              Begin
                pIncrementaMsgErro(strMSG, 'Não foi possível importar o Pedido ' + recDocPck.strNumPok + ' do cliente ' + recDocPck.strCodCli + ', pois o mesmo já foi importado. ' +
                                           '(' + recDocPck.strNumDoc + '-' + recDocPck.strEspDoc + ')');
                pGravaLogImpAlteraStatusCdsPedido(strMSG);

                Delete;
                Continue;
              End;

              Next;
            End;

            pRegistraLogImp('Associando código de novos clientes!');
            pProcessarClientesTabFSPEDIDOCAB;

            pRegistraLogImp('Verificando consistência de dados dos pedidos!');
            pValidaDadosBasicosPedidos;

            pRegistraLogImp('Atualizando localização geográfica dos clientes!');
            pAtualizandoLocalizacaoClientes;

            pRegistraLogImp('Validando vendedores dos pedidos!');
            pValidaVendedor;

            pRegistraLogImp('Validando transportadoras dos pedidos!');
            pValidaTransportadora;
          End;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        fAlerta('Não foi possível carregar os Pedidos!. Erro: ' + E.Message);
      End;
    End;
  Finally
    pnlProgressoGeral.Visible := False;
    pnlProgressoDetalhes.Visible := False;
  End;
end;

function TfrmImportacaoSfaMobAndroid.fCarregarPedidosItens: Boolean;
begin
  Result := True;

  pnlProgressoGeral.Visible := False;
  pnlProgressoDetalhes.Visible := True;

  Try
    With cdsPedidosItens Do
    Begin
      fAbreClient(True, 'TfrmImportacaoSfaMobAndroid.fCarregarPedidosItens');
      pAjustaMascaraPedidosItens;

      pDesativarMasterSourceItens;
      pTratamentoItemEstrutura(cdsPedidosItens);
      pAtualizarCodigoBase(cdsPedidosItens);
      pAtivarMasterSourceItens;
    End;

  Except
    Result := False;
    fAlerta('Não foi possível importar os pedidos!');
  End;

  pnlProgressoGeral.Visible := False;
  pnlProgressoDetalhes.Visible := False;

  pCalculaTotalItens;
end;

function TfrmImportacaoSfaMobAndroid.fConfiguracoesDoPixPreenchidas: Boolean;
begin
  Result := fCfgSis('USAPIX', varBoolean);

  If Result Then
    Result := fCfgSis('CHAPIX', varString) <> '';
end;

function TfrmImportacaoSfaMobAndroid.fEmpMob: String;
begin
  If (blnModoRobo) Then
    Result := fArqIni(0, 'GERAL', 'EMPMOB', '')
  Else
    Result := '';
end;

function TfrmImportacaoSfaMobAndroid.fEntFat(strCliRet: String): String;
begin
  If (Trim(strCliRet) = 'S') Then
    Result := 'N'
  Else
    Result := 'S';
end;

function TfrmImportacaoSfaMobAndroid.fEntRet(strCliRet: String): String;
begin
  If (Trim(strCliRet) = 'S') Then
    Result := 'R'
  Else
    Result := 'E';
end;

procedure TfrmImportacaoSfaMobAndroid.pRateiaValores(fltValFre: Double);
  Var
   blnCalcula : Boolean;
   itens      : TMatrizFechamento;
   intPosicao : Integer;
begin
  blnCalcula := (Not cdsPedidosItens.IsEmpty) And
                (fltValFre > 0) {or fltDesAce ect};

  If blnCalcula Then
  Begin
    With cdsPedidosItens Do
    Begin
      //SETA VARIAVEIS QUE DEVER SER RATEADAS;
      If fltValFre > 0 Then
        fatVenda.fltValFre := fltValFre;
      //SETA VARIAVEIS QUE DEVER SER RATEADAS;

      First;
      SetLength(Itens, 0);
      While Not Eof Do
      Begin
        SetLength(Itens, Length(Itens) + 1);
        intPosicao := Length(Itens) - 1;

        Edit;
        FieldByName('AUTINCAUX').AsInteger := intPosicao;
        Post;

        Itens[intPosicao].intAutInc := intPosicao;
        Itens[intPosicao].strCodIte := FieldByName('CODIGOPRODUTO').AsString;
        Itens[intPosicao].fltTotIte := FieldByName('TOTALITEM').AsFloat;
        Itens[intPosicao].strPromoc := FieldByName('PROMOCAO').AsString;

        Next;
      End;

      fatVenda.arrMatItens := Itens;
      fatVenda.pRateiaValores;

      For intPosicao := Low(Itens) To High(Itens) Do
      Begin
        If Locate('AUTINCAUX', Itens[intPosicao].intAutInc, []) Then
        Begin
          Edit;
          //RETORNAR AO CLIENT VALORES RATEADOS
          If fltValFre > 0 Then
            FieldByName('VALFREITE').AsFloat := Itens[intPosicao].fltValFre;

          //RETORNAR AO CLIENT VALORES RATEADOS
          FieldByName('TOTALFINAL').AsFloat := fFormataFloat(FieldByName('TOTALFINALORI').AsFloat, 2) +
                                               fFormataFloat(FieldByName('VALFREITE').AsFloat, 2);

          Post;
        End;
      End;
    End;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pRegistraLogImp(strTexto: String);
begin
  mmoLogImp.Lines.Add(FormatDateTime('hh:mm:ss', fTime()) + ' - ' + strTexto);
end;

procedure TfrmImportacaoSfaMobAndroid.pDefineEmpresaImportação;
begin
  {************************************************}
  {* SE FOR IMPORTAÇÃO AUTOMÁTICA, SETA A EMPRESA *}
  {* QUE FOI DEFINIDA PARA IMPORTAÇÃO.            *}
  {*********************************************PZ*}
  If (blnModoRobo) Then
  Begin
    If (Not fEmptyStr(fEmpMob)) Then
      pSetaEmpresaLogada(fEmpMob);
  End;
end;

function TfrmImportacaoSfaMobAndroid.fGravarAdtCliCartao(strNumDoc, strEspDoc, strCodEmp, strCodCli, strNumPok: String; fltValCar: Double; intSeqConRcx: Integer): Boolean;
  Var
    documento: TDocAdiantamento;
    dadosAdiantamento: TDadosAdiantamento;
    totModalidades: TTotaisAdiantamento;
begin
  FillChar(dadosAdiantamento, SizeOf(dadosAdiantamento), #0);
  FillChar(totModalidades, SizeOf(totModalidades), #0);

  documento.strNumDoc := strNumDoc;
  documento.strEspDoc := strEspDoc;
  documento.strCodEmp := strCodEmp;
  documento.strCodCli := strCodCli;
  documento.fltValLan := fltValCar;

  dadosAdiantamento.AddDocumento(documento);

  dadosAdiantamento.strTipLan := 'C';
  dadosAdiantamento.dtaDtaLan := VS_Date;
  dadosAdiantamento.horHorLan := fTime();
  dadosAdiantamento.strOpeLan := strLoginUsuarioLogado;
  dadosAdiantamento.strEmpLan := IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);//Deve gravar a empresa do resumo de caixa
  dadosAdiantamento.intSeqCon := intSeqConRcx;
  dadosAdiantamento.strDescri := 'CREDITO ADIANTAMENTO PEDIDO: ' + strNumDoc + '-' + strEspDoc + ' - NUMPOK: ' + strNumPok;
  dadosAdiantamento.fltValDin := 0.00;
  dadosAdiantamento.fltValChV := 0.00;
  dadosAdiantamento.fltValChP := 0.00;
  dadosAdiantamento.fltValOrd := 0.00;
  dadosAdiantamento.fltValFin := 0.00;
  dadosAdiantamento.fltValCre := 0.00;
  dadosAdiantamento.fltValCar := fltValCar;
  dadosAdiantamento.fltValLan := fltValCar;

  dadosAdiantamento.RecebidoPorPix := False;

  Result := TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosAdiantamento);
end;

function TfrmImportacaoSfaMobAndroid.fGravarCartoes(
  arrCartoes: TCartoesResumoCaixaArray; recDadAdCar: TDadosAdicCartao): Boolean;
  Var
    intCnt  : Integer;
    intCnt2 : Integer;
    intCnt3 : Integer;
    strNumDupCartao : String;
    strHisCar : String;
    arrDigDup: TArrDigDuplic;
    arrDigFat: TArrDigDuplic;
    arrDuplicata,
    arrDuplicFat : TArrDigDuplicArray;
    intSeqConRcx : Integer;
    qryFsCartoes : TUniQuery;
    fltTotDig : Double;
    fltVlTxGe : Double;
    fltVlTxPc : Double;
    objArredondaParcela: IArredondaParcela;
    LTipoParcelamento: String;
begin
  Result := True;

  If (Not fPedidoTemMovCar(recDadAdCar.strNumPok)) Then
  Begin
    qryFsCartoes := fCriaQuery(Self);

    intSeqConRcx := StrToInt(fRetRcxCon);

    fStartTransaction;
    Try
      With qryFsCartoes Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT SQL_NO_CACHE * ');
        SQL.Add('   FROM FSCARTOES ');
        SQL.Add('  WHERE NUMEROPEDIDO = :NUMPED ');
        SQL.Add('    FOR UPDATE ');
        ParamByName('NUMPED').AsString := recDadAdCar.strNumPok;
        Open;
      End;

      For intCnt := 0 To Length(arrCartoes) -1 Do
      Begin
        If (Not Result) Then
          Break;

        LTipoParcelamento := '';

        {$IFNDEF LINUX}
          LTipoParcelamento := fCampoTabela('CAR_ARRPAR', 'CADCAR', ['CAR_CODCAR'], [arrCartoes[intCnt].strCodCar]);

          If (arrCartoes[intCnt].strTipCar = 'POS') And (LTipoParcelamento <> 'N') Then
            objArredondaParcela := TArredondaParCartaoPos.fArredondamentoParcelas(arrCartoes[intCnt].strCodCar)
          Else
            objArredondaParcela := fArredondamentoParcelas(arrCartoes[intCnt].strCodCar);
        {$ELSE}
          objArredondaParcela := fArredondamentoParcelas(arrCartoes[intCnt].strCodCar);
        {$ENDIF LINUX}

        fDigDuplicVar(arrCartoes[intCnt].strCndPag, 0, arrCartoes[intCnt].fltValDig, False, False, False, recDadAdCar.dtaDtaCar, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);
        SetLength(arrDuplicFat, Length(arrDuplicata));
        
        For intCnt3 := 0 To Length(arrDuplicata) - 1 Do
          arrDuplicFat[intCnt3] := arrDuplicata[intCnt3];

        {**********************************************************************}
        {* HIERARQUIA: CASO MANDOU TAXA NA FSCARTOES, IGNORA A CALCULADA NA   *}
        {* TELA: frmRcxDigCartoes                                             *}
        {*******************************************************************RN*}
        fltVlTxGe := 0;
        fltVlTxPc := 0;
        If (fFormataFloat(recDadAdCar.fltTxDsGe + recDadAdCar.fltTxDsPa, 2) > 0) Then
        Begin
          fltTotDig := arrCartoes[intCnt].fltValDig;

          If (fFormataFloat(recDadAdCar.fltTxDsGe, 2) > 0) Then
          Begin
            If (recDadAdCar.strTxDsGe = 'V') Then
              fltVlTxGe := recDadAdCar.fltTxDsGe
            Else If (recDadAdCar.strTxDsGe = 'P') Then
              fltVlTxGe := fFormataFloat(( fltTotDig * ( recDadAdCar.fltTxDsGe / 100 ) ), 2);

            fltTotDig := fltTotDig - fltVlTxGe;
            fltVlTxGe := fFormataFloat(fltVlTxGe / recDadAdCar.intQtdPar, 2);
          End;

          If (fFormataFloat(recDadAdCar.fltTxDsPa, 2) > 0) Then
          Begin
            If (recDadAdCar.strTxDsPa = 'V') Then
              fltVlTxPc := (recDadAdCar.fltTxDsPa * recDadAdCar.intQtdPar)
            Else If (recDadAdCar.strTxDsPa = 'P') Then
              fltVlTxPc := fFormataFloat(( fltTotDig * ( recDadAdCar.fltTxDsPa / 100 ) ), 2);

            fltTotDig := fltTotDig - fltVlTxPc;
            fltVlTxPc := fFormataFloat(fltVlTxPc / recDadAdCar.intQtdPar, 2);
          End;

          arrCartoes[intCnt].fltValDes := fltTotDig;
        End;

        fDigDuplicVar(arrCartoes[intCnt].strCndPag, 0, arrCartoes[intCnt].fltValDes, False, False, False, recDadAdCar.dtaDtaCar, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);

        strNumDupCartao := fRetSequencialMovCar('MOVCAR', VS_strCodEmp);

        intCnt2 := 0;

        While (fEmptyStr(arrCartoes[intCnt].strCodFin) And (intCnt2 < Length(arrDuplicata)) And
               (Not fEmptyStr(arrDuplicata[intCnt2].strSequen))) Do
        Begin
          arrDigDup := arrDuplicata[intCnt2];
          arrDigFat := arrDuplicFat[intCnt2];

          strHisCar := 'REF. AO DOC. E-COMMERCE: ' + recDadAdCar.strNumPok;

          pRegistraLogImp('Aguarde... Gravando Movimentação de Cartões: ' + fDocumeCar(recDadAdCar.strNumDoc, recDadAdCar.strEspDoc, recDadAdCar.strCodEmp, intCnt2));

          Result := Result And fGravaMovCar(Self.Name,
                                            'INCLUSÃO',
                                            strNumDupCartao,
                                            recDadAdCar.strCodCli,
                                            arrDigDup.strSequen,
                                            recDadAdCar.strCodEmp,
                                            arrCartoes[intCnt].strCodCar,
                                            recDadAdCar.dtaDtaCar,
                                            StrToDate(arrDigDup.dtaDtaVen),
                                            arrDigDup.curValor, // fltValOri
                                            arrDigDup.curValor, // fltValDup
                                            arrCartoes[intCnt].strObsCar,
                                            strHisCar,
                                            arrCartoes[intCnt].strCndPag,
                                            0,
                                            0.0,
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            arrCartoes[intCnt].fltPerDes,
                                            arrDigFat.curValor,
                                            arrDigFat.curValor - arrDigDup.curValor,
                                            arrCartoes[intCnt].strNumCcd,
                                            fDocumeCar(recDadAdCar.strNumDoc, recDadAdCar.strEspDoc, recDadAdCar.strCodEmp, intCnt2),
                                            '',
                                            intSeqConRcx,
                                            VS_strCodEmp,
                                            strLoginUsuarioLogado,
                                            False,
                                            '',
                                            'F',
                                            arrCartoes[intCnt].strCodFin,
                                            arrCartoes[intCnt].strTipCar,
                                            0,
                                            0,
                                            0,
                                            0,
                                            arrCartoes[intCnt].strNumNsu,
                                            recDadAdCar.strNumPok,
                                            recDadAdCar.dtaDtaCup,
                                            fltVlTxGe,
                                            fltVlTxPc,
                                            recDadAdCar.dtaDtaCar);

          If Result Then
          Begin
            pAtualizaMovMod(recDadAdCar.strNumDoc,
                            recDadAdCar.strEspDoc,
                            recDadAdCar.strCodEmp,
                            recDadAdCar.strCodCli,
                            arrCartoes[intCnt].strCodCar,
                            arrCartoes[intCnt].strPixS_N);
          End;

          Inc(intCnt2);

          If (Not Result) Then
            Break;
        End;

        If (Not Result) Then
          Break;
      End;

      If (Result) And
         (fGravarAdtCliCartao(recDadAdCar.strNumDoc, recDadAdCar.strEspDoc,
                              recDadAdCar.strCodEmp, recDadAdCar.strCodCli,
                              recDadAdCar.strNumPok, recDadAdCar.fltTotVen,
                              intSeqConRcx)) Then
      Begin
        If (Not qryFsCartoes.IsEmpty) Then
        Begin
          qryFsCartoes.Edit;
          qryFsCartoes.FieldByName('IMPORTADO').AsString := 'S';
          qryFsCartoes.FieldByName('DATAIMPORTACAO').AsDateTime := VS_Date;
          qryFsCartoes.FieldByName('HORAIMPORTACAO').AsDateTime := fTime();
          qryFsCartoes.Post;
        End;
        fCommit;
      End
      Else
        fRollBack;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        raise;
      End;
    End;

    FreeAndNil(qryFsCartoes);
  End
  Else
    pMarcaCartaoComoImportado(recDadAdCar.strNumPok);
end;

procedure TfrmImportacaoSfaMobAndroid.pImportaNaoVendaNaoVisita;
  Var
    qryNVenda,
    qryNVisita,
    qryAux : TUniQuery;
    strMSG: String;

  function fGetSQLInsNVenda: String;
  begin
    Result := '';
    Result := Result + ' INSERT INTO NVENDA (';
    Result := Result + ' NVE_CODCLI, NVE_DTAENT, NVE_HORENT, NVE_CODVEN, ';
    Result := Result + ' NVE_CODMOT, NVE_DESMOT, NVE_OBSERV) ';
    Result := Result + ' VALUES (:CODCLI, :DTAENT, :HORENT, :CODVEN, ';
    Result := Result + ' :CODMOT, :DESMOT, :OBSERV) ';
  end;

  function fGetSQLInsNVisita: String;
  begin
    Result := '';
    Result := Result + ' INSERT INTO NVISIT (';
    Result := Result + ' NVI_CODCLI, NVI_DTAENT, NVI_HORENT, NVI_CODVEN, ';
    Result := Result + ' NVI_CODMOT, NVI_DESMOT, NVI_OBSERV) ';
    Result := Result + ' VALUES (:CODCLI, :DTAENT, :HORENT, :CODVEN, ';
    Result := Result + ' :CODMOT, :DESMOT, :OBSERV) ';
  end;

  procedure pMarcaComoImportado(strTabela, strCodCli, strCodMot: String; dtaDtaReg: TDate; strHraReg, strCodVen: String);
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery();
    Try
      qryGen.SQL.Text := 'UPDATE '+strTabela+
                         '    SET IMPORTADO      = :IMPORTADO, '+
                         '        DATAIMPORTACAO = :DATAIMPORTACAO, '+
                         '        HORAIMPORTACAO = :HORAIMPORTACAO '+
                         ' WHERE CODIGOCLIENTE  = :CODIGOCLIENTE '+
                         '   AND CODIGOMOTIVO   = :CODIGOMOTIVO '+
                         '   AND DATA           = :DATA '+
                         '   AND HORARIO        = :HORARIO '+
                         '   AND CODIGOVENDEDOR = :CODIGOVENDEDOR '+
                         '   AND IMPORTADO = "N" '+
                         '   AND LIBERADO  = "S" ';

      qryGen.ParamByName('CODIGOCLIENTE').AsString  := strCodCli;
      qryGen.ParamByName('CODIGOMOTIVO').AsString   := strCodMot;
      qryGen.ParamByName('DATA').AsDateTime         := dtaDtaReg;
      qryGen.ParamByName('HORARIO').AsString        := strHraReg;
      qryGen.ParamByName('CODIGOVENDEDOR').AsString := strCodVen;

      qryGen.ParamByName('IMPORTADO').AsString := 'S';
      qryGen.ParamByName('DATAIMPORTACAO').AsDateTime := VS_Date;
      qryGen.ParamByName('HORAIMPORTACAO').AsString   := TimeToStr(fTime());

      qryGen.ExecSQL;
    Finally
      FreeAndNil(qryGen);
    End;
  end;

begin
  qryNVenda  := fCriaQuery(Self);
  qryNVisita := fCriaQuery(Self);
  qryAux     := fCriaQuery(Self);
  pnlProgressoGeral.Visible := True;
  Try
    With qryNVenda Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLNVenda);
      Open;

      If RecordCount > 0 Then
      Begin
        First;
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(fGetSQLInsNVenda);

        While Not Eof Do
        Begin
          pRegistrarProgresso('Aguarde, Importando Não Venda...', lblProgressoGeral, pgbProgressoGeral, 0, RecNo, RecordCount);

          strMsg := '';

          Try

            qryAux.ParamByName('CODCLI').AsString   := FieldByName('CODIGOCLIENTE').AsString;
            qryAux.ParamByName('DTAENT').AsDateTime := FieldByName('DATA').AsDateTime;
            qryAux.ParamByName('HORENT').AsString   := FieldByName('HORARIO').AsString;
            qryAux.ParamByName('CODVEN').AsString   := FieldByName('CODIGOVENDEDOR').AsString;
            qryAux.ParamByName('CODMOT').AsString   := FieldByName('CODIGOMOTIVO').AsString;
            qryAux.ParamByName('DESMOT').AsString   := FieldByName('DESCRICAOMOTIVO').AsString;
            qryAux.ParamByName('OBSERV').AsString   := FieldByName('OBSERVACAO').AsString;

            qryAux.ExecSQL;

          Except
            On E: Exception Do
              pIncrementaMsgErro(strMSG, 'Ocorreu um erro ao processar a não venda do cliente ' + FieldByName('CODIGOCLIENTE').AsString + sLineBreak + 'Erro: ' + E.Message);
          End;

          pGravaLogImpNaoVenda(strMSG, FieldByName('CODIGOCLIENTE').AsString);

          pMarcaComoImportado('FSNAOVENDA',
                              FieldByName('CODIGOCLIENTE').AsString,
                              FieldByName('CODIGOMOTIVO').AsString,
                              FieldByName('DATA').AsDateTime,
                              FieldByName('HORARIO').AsString,
                              FieldByName('CODIGOVENDEDOR').AsString);

          Next;
        End;
      End;

    End;

    With qryNVisita Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLNVisita);
      Open;

      If RecordCount > 0 Then
      Begin
        First;
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(fGetSQLInsNVisita);

        While Not Eof Do
        Begin
          pRegistrarProgresso('Aguarde, Importando Não Visita...', lblProgressoGeral, pgbProgressoGeral, 0, RecNo, RecordCount);

          strMsg := '';

          Try

            qryAux.ParamByName('CODCLI').AsString   := FieldByName('CODIGOCLIENTE').AsString;
            qryAux.ParamByName('DTAENT').AsDateTime := FieldByName('DATA').AsDateTime;
            qryAux.ParamByName('HORENT').AsString   := FieldByName('HORARIO').AsString;
            qryAux.ParamByName('CODVEN').AsString   := FieldByName('CODIGOVENDEDOR').AsString;
            qryAux.ParamByName('CODMOT').AsString   := FieldByName('CODIGOMOTIVO').AsString;
            qryAux.ParamByName('DESMOT').AsString   := FieldByName('DESCRICAOMOTIVO').AsString;
            qryAux.ParamByName('OBSERV').AsString   := FieldByName('OBSERVACAO').AsString;

            qryAux.ExecSQL;

          Except
            On E: Exception Do
              pIncrementaMsgErro(strMSG, 'Ocorreu um erro ao processar a não visita do cliente ' + FieldByName('CODIGOCLIENTE').AsString + sLineBreak + 'Erro: ' + E.Message);
          End;

          pGravaLogImpNaoVisita(strMSG, FieldByName('CODIGOCLIENTE').AsString);

          pMarcaComoImportado('FSNAOVISITA',
                              FieldByName('CODIGOCLIENTE').AsString,
                              FieldByName('CODIGOMOTIVO').AsString,
                              FieldByName('DATA').AsDateTime,
                              FieldByName('HORARIO').AsString,
                              FieldByName('CODIGOVENDEDOR').AsString);

          Next;
        End;
      End;

    End;
  Finally
    FreeAndNil(qryNVenda);
    FreeAndNil(qryNVisita);
    FreeAndNil(qryAux);
    pnlProgressoGeral.Visible := False;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pImportarCartoes;
  Var
    qryFsCart : TUniQuery;
    arrCartoes: TCartoesResumoCaixaArray;
    recDadAdCar: TDadosAdicCartao;
    intPosCar : Integer;
    blnRegistrouLog : Boolean;
    strMSG: String;

  procedure pRegistraLogCartao;
  begin
    If Not blnRegistrouLog Then
    Begin
      If fEmptyStr(frmRcxDigCartoes.strUltMsgCamposCartao) Then
        pIncrementaMsgErro(strMSG, 'Falha ao processar os dados do cartão - Pedido: ' + qryFsCart.FieldByName('NUMEROPEDIDO').AsString)
      Else
        pIncrementaMsgErro(strMSG, frmRcxDigCartoes.strUltMsgCamposCartao + ' - Pedido: ' + qryFsCart.FieldByName('NUMEROPEDIDO').AsString);

      blnRegistrouLog := True;
    End;
  end;

begin
  blnRegistrouLog := False;
  qryFsCart := fCriaQuery(Self);
  pnlProgressoGeral.Visible := True;
  Try
    With qryFsCart Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT SQL_NO_CACHE FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, ');
      SQL.Add('        FGO_CODCLI, DATACARTAO, DATATRANSACAO, ');
      SQL.Add('        VALORVENDA, NUMEROPEDIDO, NUMERONSU, ');
      SQL.Add('        CODIGOCARTAO, QTDPARCELAS, NUMEROLIBERACAO, ');
      SQL.Add('        TAXADESCONTOGERAL, TIPTAXADESCONTOGERAL, TAXADESCONTOPARCELA, ');
      SQL.Add('        TIPOTAXADESCONTOPARC, OBSERVACOES ');
      SQL.Add('   FROM FSCARTOES ');
      SQL.Add('   JOIN FATGOR ON FGO_NUMPOK = NUMEROPEDIDO ');
      SQL.Add('  WHERE IMPORTADO = "N" ');
      SQL.Add('    AND LIBERADO = "S" ');
      Open;

      First;
      While Not Eof Do
      Begin
        pRegistrarProgresso('Aguarde, Importando Cartões...', lblProgressoGeral, pgbProgressoGeral, 0, RecNo, RecordCount);

        strMsg := '';

        If (Not FieldByName('DATACARTAO').IsNull) And
           (Not fEmptyStr(FieldByName('CODIGOCARTAO').AsString)) And
           (fFormataFloat(FieldByName('VALORVENDA').AsFloat, 2) > 0) And
           (FieldByName('QTDPARCELAS').AsInteger >= 1)  Then
        Begin
          pCriarFormularios(TfrmRcxDigCartoes, frmRcxDigCartoes);
          Try
            frmRcxDigCartoes.edtTotCar.ReadOnly := True;
            frmRcxDigCartoes.edtTotCar.TabStop := False;

            frmRcxDigCartoes.edtCodCar.ReadOnly := True;
            frmRcxDigCartoes.edtCodCar.TabStop := False;

            frmRcxDigCartoes.edtQtdPar.ReadOnly := True;

            frmRcxDigCartoes.fltTotDig := 0.0;
            frmRcxDigCartoes.fltTotGer := FieldByName('VALORVENDA').AsFloat;
            frmRcxDigCartoes.fltMaxDig := FieldByName('VALORVENDA').AsFloat;
            frmRcxDigCartoes.strNumNsu := FieldByName('NUMERONSU').AsString;
            frmRcxDigCartoes.strCodCar := FieldByName('CODIGOCARTAO').AsString;
            frmRcxDigCartoes.intQtdPar := FieldByName('QTDPARCELAS').AsInteger;
            frmRcxDigCartoes.intQtdNeg := FieldByName('QTDPARCELAS').AsInteger;
            frmRcxDigCartoes.strNumCcd := FieldByName('NUMEROLIBERACAO').AsString;

            frmRcxDigCartoes.blnTraVal := True;
            frmRcxDigCartoes.blnSairComEsc := True;
            frmRcxDigCartoes.blnSemMensagem := True;
            frmRcxDigCartoes.OnShow(frmRcxDigCartoes);

            If (Not frmRcxDigCartoes.fVerificaCamposCartao) Then
            Begin
              If (Not blnModoRobo) Then
                frmRcxDigCartoes.ShowModal
              Else
              Begin
                frmRcxDigCartoes.blnConfirma := False;

                pRegistraLogCartao;
              End;
            End
            Else
              frmRcxDigCartoes.btnConfirma.Click;

            If (frmRcxDigCartoes.blnConfirma) Then
            Begin
              SetLength(arrCartoes, 1);
              intPosCar := 0;

              FillChar(arrCartoes[intPosCar], SizeOf(arrCartoes[intPosCar]), #0);

              arrCartoes[intPosCar].intCodSeq := intPosCar;
              arrCartoes[intPosCar].strCodCar := FieldByName('CODIGOCARTAO').AsString;
              arrCartoes[intPosCar].strDesCar := frmRcxDigCartoes.edtDesCar.Text;
              arrCartoes[intPosCar].fltValDig := frmRcxDigCartoes.fltValDig;
              arrCartoes[intPosCar].strCndPag := frmRcxDigCartoes.mskCndPag.Text;
              arrCartoes[intPosCar].strObsCar := FieldByName('OBSERVACOES').AsString;
              arrCartoes[intPosCar].fltValDes := frmRcxDigCartoes.fltValDes;
              arrCartoes[intPosCar].strNumCcd := frmRcxDigCartoes.edtNumCcd.Text;
              arrCartoes[intPosCar].fltPerDes := frmRcxDigCartoes.fltPerDes;
              arrCartoes[intPosCar].strCodFin := '';
              arrCartoes[intPosCar].strTipCar := 'TEF';
              arrCartoes[intPosCar].strNumNsu := fPadL(frmRcxDigCartoes.strNumNsu, 14, '0');
              arrCartoes[intPosCar].strConteudoArquivo := '';

              FillChar(recDadAdCar, SizeOf(recDadAdCar), #0);

              recDadAdCar.strNumDoc := FieldByName('FGO_NUMDOC').AsString;
              recDadAdCar.strEspDoc := FieldByName('FGO_ESPDOC').AsString;
              recDadAdCar.strCodEmp := FieldByName('FGO_CODEMP').AsString;
              recDadAdCar.strCodCli := FieldByName('FGO_CODCLI').AsString;
              recDadAdCar.dtaDtaCar := FieldByName('DATACARTAO').AsDateTime;
              recDadAdCar.dtaDtaCup := FieldByName('DATATRANSACAO').AsDateTime;
              recDadAdCar.fltTotVen := FieldByName('VALORVENDA').AsFloat;
              recDadAdCar.strNumPok := FieldByName('NUMEROPEDIDO').AsString;
              recDadAdCar.fltTxDsGe := FieldByName('TAXADESCONTOGERAL').AsFloat;
              recDadAdCar.fltTxDsPa := FieldByName('TAXADESCONTOPARCELA').AsFloat;
              recDadAdCar.strTxDsGe := FieldByName('TIPTAXADESCONTOGERAL').AsString;
              recDadAdCar.strTxDsPa := FieldByName('TIPOTAXADESCONTOPARC').AsString;
              recDadAdCar.intQtdPar := FieldByName('QTDPARCELAS').AsInteger;

              If Not fGravarCartoes(arrCartoes, recDadAdCar) Then
                pIncrementaMsgErro(strMSG, 'Ocorreu um erro ao gravar o cartão do pedido ' + FieldByName('NUMEROPEDIDO').AsString);
            End
            Else
              pRegistraLogCartao;

          Except
            On E: Exception Do
              pIncrementaMsgErro(strMSG, 'Ocorreu um erro ao processar o cartão do pedido ' + FieldByName('NUMEROPEDIDO').AsString + sLineBreak + 'Erro: ' + E.Message);
          End;

          pFreeAndNil(frmRcxDigCartoes);
        End
        Else
        Begin
          If (fEmptyStr(FieldByName('CODIGOCARTAO').AsString)) Then
            pIncrementaMsgErro(strMSG, 'O código do cartão não foi informado - Pedido: ' + FieldByName('NUMEROPEDIDO').AsString);

          If (fFormataFloat(FieldByName('VALORVENDA').AsFloat, 2) <= 0) Then
            pIncrementaMsgErro(strMSG, 'O "valor da venda" do cartão não foi informado corretamente - Pedido: ' + FieldByName('NUMEROPEDIDO').AsString);

          If (FieldByName('QTDPARCELAS').AsInteger < 1) Then
            pIncrementaMsgErro(strMSG, 'A quantidade de parcelas não foi informada corretamente - Pedido: ' + FieldByName('NUMEROPEDIDO').AsString);
        End;

        pGravaLogImpCartoes(strMSG, FieldByName('NUMEROPEDIDO').AsString);

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryFsCart);
    pnlProgressoGeral.Visible := False;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pRegistrarProgresso(strTexto: String;
  lblInformacao: TLabel; pgbProgresso: TCxProgressBar; intInicio, intAtual, intFinal: Integer);
begin
  pgbProgresso.properties.Max := intFinal;
  pgbProgresso.properties.Min := intInicio;
  pgbProgresso.Position := intAtual;
  lblInformacao.Caption := Format('%s %d / %d',  [strTexto ,intAtual, intFinal]);
  Application.ProcessMessages;
end;

procedure TfrmImportacaoSfaMobAndroid.pRetTransportadoraEFrete(strCodRot: String;
                                                           var strCodTra: String;
                                                           var fltTotFre: Double);
Var
  objRotReg : TRotReg;
begin
  fltTotFre := 0;
  strCodTra := cdsPedidos.FieldByName('CODTRANSPORTADORA').AsString;

  If Not fEmptyStr(strCodTra) Then
    fltTotFre := cdsPedidos.FieldByName('VALORFRETE').AsFloat
  Else If (Not fEmptyStr(strCodRot)) Then
  Begin
    objRotReg := TRotReg.Create(Self);
    Try
      objRotReg.strCodRot := strCodRot;
      strCodTra := objRotReg.fRetTranspRota;
      fltTotFre := 0;
    Finally
      FreeAndNil(objRotReg);
    End;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pTratamentoItemEstrutura(
  cdsDados: TUniClientDataSet);
  Var
    cdsClone : TUniClientDataSet;
    intCnt : Integer;
    strFieldName : String;
begin
  If (fCfgSis('SFAEST') = 'P') Then
  Begin
    If (fCfgSis('BXSBIT') <> '1') Then
    Begin
      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin
        If fItemEstrutura(cdsDados.FieldByName('CODIGOPRODUTO').AsString) Then
        Begin
          cdsDados.Edit;
          cdsDados.FieldByName('BXSBIT').AsString := 'S';
          cdsDados.Post;
        End;
        cdsDados.Next;
      End;
    End;
  End
  Else
  Begin
    cdsClone := TUniClientDataSet.Create(Self);
    Try
      pCloneDataSet(cdsClone, cdsDados);
      cdsClone.EmptyDataSet;

      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin

        If Not fItemEstrutura(cdsDados.FieldByName('CODIGOPRODUTO').AsString) Then
        Begin
          cdsDados.Next;
          Continue;
        End;

        If (cdsDados.FieldByName('SUBITEM').AsString = 'S') Then
        Begin
          cdsDados.Next;
          Continue;
        End;

        If fInserirSubItens(cdsDados, cdsClone) Then
        Begin
          cdsDados.Delete;
          Continue;
        End;

        cdsDados.Next;
      End;

      cdsClone.First;
      While Not cdsClone.Eof Do
      Begin
        cdsDados.Append;
        For intCnt := 0 To cdsClone.FieldCount-1 Do
        Begin
          strFieldName := cdsClone.Fields[intCnt].FieldName;
          If Not cdsClone.FieldByName(strFieldName).IsNull Then
            cdsDados.FieldByName(strFieldName).Value := cdsClone.FieldByName(strFieldName).Value;
        End;
        cdsDados.Post;

        cdsClone.Next;
      End;
    Finally
      FreeAndNil(cdsClone);
    End;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.FormShow(Sender: TObject);
begin
  inherited;

  pLigaDataSet;
  pAtivaScrolls(True);

  pInicializaTela;
end;

procedure TfrmImportacaoSfaMobAndroid.pLigaDataSet;
begin
  If (Not blnModoRobo) Then
  Begin
    dbgPedidos.DataSource      := cdsPedidos.dtsSource;
    dbgPedidosItens.DataSource := cdsPedidosItens.dtsSource;
    dbgClientes.DataSource     := cdsClientes.dtsSource;
    dbgCartoes.DataSource      := cdsCartoes.dtsSource;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.dbgPedidosCellClick(Column: TColumn);
begin
  inherited;

  If Not Column.Field.DataSet.IsEmpty Then
    pAfterScrollCds(Column.Field.DataSet);
end;

procedure TfrmImportacaoSfaMobAndroid.dbgPedidosDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  If (blnModoRobo) Or (Column.Field.DataSet.IsEmpty) Then
    Exit;

  inherited;

  If SameText(Column.Field.FieldName, 'STATUSIMP') Then
  Begin
    TDBGridCitel(Sender).Canvas.FillRect(Rect);
    Case Trim(Column.Field.Text)[1] Of
      'G':imgLista.Draw(TDBGridCitel(Sender).Canvas, Rect.Left+1, Rect.Top+1, 3);
      'E':imgLista.Draw(TDBGridCitel(Sender).Canvas, Rect.Left+1, Rect.Top+1, 2);
      'I':imgLista.Draw(TDBGridCitel(Sender).Canvas, Rect.Left+1, Rect.Top+1, 1);
      Else
       imgLista.Draw(TDBGridCitel(Sender).Canvas, Rect.Left+1, Rect.Top+1, 0)
    End;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.dbgPedidosItensKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #27 Then
    pSetFocus(btnSair);
end;

procedure TfrmImportacaoSfaMobAndroid.btnCorrigeCepClick(Sender: TObject);
begin
  inherited;

  If Not fPermissaoCorrigirCEP Then
  Begin
    fAlerta('Usuário sem permissão para alterar o CEP.');
    Exit;
  End;

  If pgcPainel.ActivePage = tbsPedidos Then
  Begin
    pCorrigeCepEntrega;
  End
  Else If pgcPainel.ActivePage = tbsClientes Then
  Begin
    pCorrigeCepCliente;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.btnExcluirClick(Sender: TObject);

  procedure pBaixaItem;
    Var
      strCampo_: String;
      strChave_: String;
      strTabela: String;
      strPrefix: String;
  begin
    strPrefix := '';
    If (pgcPainel.ActivePage = tbsPedidos) Then
    Begin
      strChave_ := cdsPedidos.FieldByName('NUMEROPEDIDO').Text;
      strTabela := 'FSPEDIDOCAB';
      strCampo_ := 'NUMEROPEDIDO';
    End
    Else If (pgcPainel.ActivePage = tbsClientes) Then
    Begin
      strChave_ := cdsClientes.FieldByName('CLI_CODIGOCLIENTE').Text;
      strTabela := 'FSCLIENTE';
      strCampo_ := 'CLI_CODIGOCLIENTE';
      strPrefix := 'CLI_';
    End
    Else If (pgcPainel.ActivePage = tbsCartoes) Then
    Begin
      strChave_ := cdsCartoes.FieldByName('NUMEROPEDIDO').Text;
      strTabela := 'FSCARTOES';
      strCampo_ := 'NUMEROPEDIDO';
    End;

    With fCriaQuery Do
    Begin
      Close;
      SQL.Text := 'UPDATE '+strTabela+' SET '+strPrefix+'OPEBAI = "'+strLoginUsuarioLogado+'", '+strPrefix+'IMPORTADO = "S", '+strPrefix+'DATAIMPORTACAO = :DTAIMP, '+strPrefix+'HORAIMPORTACAO = :HORIMP WHERE '+strCampo_+' = :CHAVE_';
      ParamByName('DTAIMP').AsDateTime := VS_Date;
      ParamByName('HORIMP').AsString   := TimeToStr(fTime());
      ParamByName('CHAVE_').AsString   := strChave_;
      ExecSQL;
      Destroy;
    End;
  end;

  function fPermissaoBaixarItemComErro: Boolean;
    Var
      intIdx: Integer;
  begin
    Result := True;

    If (Not fVerificaAcessoSistema('LIBERSF')) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Liberar item com erro na importação do Site/Tablet.');
      objLiberacao.objMsgLibera.pAddTextoCaption('Opção', pgcPainel.Pages[pgcPainel.TabIndex].Caption, 13);
      objLiberacao.objMsgLibera.pAddTexto('Mensagem:');

      For intIdx:=0 To mmoLogImp.Lines.Count-1 Do
      Begin
        objLiberacao.objMsgLibera.pAddTexto(mmoLogImp.Lines[intIdx]);
      End;

      objLiberacao.strDirAce := 'LIBERSF';
      objLiberacao.strMsgSen := 'Liberar item com erro na importação do Site/Tablet.';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;


      Result := objLiberacao.fLibera;
    End;
  End;

begin
  inherited;

  If fMensagem('Atenção', 'Deseja excluir esse item da lista de importação?', ['&Sim', '&Não'], 2) = 1 Then
  Begin
    If fPermissaoBaixarItemComErro Then
    Begin
      pBaixaItem;
      cdsPedidos.fAbreClient(True, 'TfrmImportacaoSfaMobAndroid.btnExcluirClick');
      pAjustaMascaraPedidos;
      pAtualizarTabelasAuxiliares;

      btnExcluir.Enabled := False;
      btnGravar.Enabled := False;
      btnImporta.Enabled := True;
    End
    Else
    Begin
      fAlerta('Usuário sem permissão para baixar itens com erro.');
    End;
  End;

end;

procedure TfrmImportacaoSfaMobAndroid.btnGravarClick(Sender: TObject);
  Var
    stlLogImp: TStringList;
begin
  inherited;
  pgcPainel.TabIndex := 0;
  pgcDados.Enabled   := False;
  pnlBotoes.Enabled  := False;

  stlLogImp := TStringList.Create;
  stlLogImp.AddStrings(mmoLogImp.Lines);

  pAtivaScrolls(False);
  Try    
    If (fGerarPedidosLiberacao) Then
    Begin
      If (blnSfaPag) Then
      Begin
        pImprimirDocumentosAprovados(fVerificaPedidosComStatusDePagamentoAprovadoReprovado);
        pVerificaPedidosComStatusDePagamentoAguardando;
      End;

      pImportarCartoes;

      btnGravar.Enabled  := False;
      btnImporta.Enabled := True;

      If blnTemNaoVendaNaoVisita Then
        pImportaNaoVendaNaoVisita;

      fAlerta('Processo de Gravação Concluído!');
      stlLogImp.AddStrings(mmoLogImp.Lines);
    End
    Else
    Begin
      If blnTemNaoVendaNaoVisita Then
      Begin
        pImportaNaoVendaNaoVisita;
        fAlerta('Processo de Gravação Concluído!');
        stlLogImp.AddStrings(mmoLogImp.Lines);
      End;
    End;
  Finally
    pAtivaScrolls(True);
    cdsPedidos.Filter   := '';
    cdsPedidos.Filtered := False;

    pAtualizarTabelasAuxiliares;

    If (btnGravar.Enabled) and (intPedidosAImportar > 0) Then
    Begin
      If blnModoRobo Then
        pDisparaMsgErro;
    End;

    mmoLogImp.Clear;
    mmoLogImp.Lines.Add(stlLogImp.Text);
    FreeAndNil(stlLogImp);

    pgcDados.Enabled  := True;
    pnlBotoes.Enabled := True;

    btnGravar.Enabled  := False;
    btnImporta.Enabled := True;
  End;
end;

function TfrmImportacaoSfaMobAndroid.fAtualizaClienteTabFSPEDIDOCAB(strCpfCnp,
  strCodCli: String): Boolean;
Var
  strSQL: String;
  qryCab: TUniQuery;
begin

  Result := False;

  Try

    qryCab := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE                     ';
    strSQL := strSQL + '  FSPEDIDOCAB              ';
    strSQL := strSQL + 'SET                        ';
    strSQL := strSQL + '  CODIGOCLIENTE = :CODCLI  ';
    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '  CPFCNPJ   = :CPFCNP AND  ';
    strSQL := strSQL + '  LIBERADO  = "S"     AND  ';
    strSQL := strSQL + '  IMPORTADO = "N"          ';

    With qryCab Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CPFCNP').AsString := strCpfCnp;
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro('Houve um erro ao atualizar o código do cliente na tabela FSPEDIDOCAB.', e.Message);
  End;

  FreeAndNil(qryCab);

end;

function TfrmImportacaoSfaMobAndroid.fGravaPedidoComoEntregaPeloCd(strCodEmp: String): Boolean;
begin
  Result := (fCampoExiste('FSPEDIDOCAB', 'CODIGOEMPRESA', True)) And
            (Not fEmptyStr(strCodEmp)) And
            (Not ((blnModoRobo) And (Not fEmptyStr(fEmpMob)))) And
            (strUMTEMP = IMPORTA_EMPRESA_SFA[iesMultiEmpresaCD]) And
            (fCfgSis('ENT_CD', varBoolean)) And
            (fCfgSis('EMP_CD', varString, strCodEmp) = strCodEmp) And
            (strCodEmp <> VS_strCodEmp);
end;

function TfrmImportacaoSfaMobAndroid.fCarregaItem(strCodIte: String): Boolean;
begin

  Try
    Result := True;

    qryCadIte.Close;
    If blnImportaEmpresaDaTabelaFS Then
      qryCadIte.ParamByName('CODEMP').AsString := cdsPedidos.FieldByName('CODIGOEMPRESA').AsString
    Else
      qryCadIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadIte.ParamByName('CODITE').AsString := strCodIte;
    qryCadIte.Open;

    If qryCadIte.IsEmpty Then
      Result := False;

  Except
    Result := False;
  End;

end;

function TfrmImportacaoSfaMobAndroid.fRetCodCid(strCEP, strLocal: String; Out strMsg: String): String;
begin
  Result := fCampoTabela('IFNULL(CID_CODCID, "")', 'CADCID', ['CID_C_E_P_'], [Copy(strCEP,1,5)]);

  If fEmptyStr(Result) Then
    Result := fInsereCidade(strCEP, strLocal, strMsg);
end;

function TfrmImportacaoSfaMobAndroid.fRetCodCliAutComPeloCPFCNPJ(strCPFCNPJ: String): String;
begin
  Result := '';
  If Not fEmptyStr(strCPFCNPJ) Then
    Result := fCampoTabela('IFNULL(CLI_CODCLI, "")', 'CADCLI', ['CLI_C_G_C_'], [strCPFCNPJ]);
end;

function TfrmImportacaoSfaMobAndroid.fRetCodTra: String;
begin
  Result := cdsPedidos.FieldByName('CODTRANSPORTADORA').AsString;
  Result := IIF(Not fEmptyStr(Result), Result, strAuxTra);
end;

function TfrmImportacaoSfaMobAndroid.fAlerta(strMsg: String): Boolean;
begin
  Result := False;

  If Not fEmptyStr(strMSG) Then
  Begin
    pRegistraLogImp(strMSG);

    If (Not blnModoRobo) Then
      pMensagemOk(strMSG);

    Result := True;
  End;
end;

function TfrmImportacaoSfaMobAndroid.fTipoPedido(strTipPed: String): String;
begin
  If (fEmptyStr(strTipPed)) And (Not fCfgSis('PEDTPA', varBoolean)) Then
    Result := ''
  Else
    Result := fGetRegraCodTipoPedido(strTipPed);
end;

function TfrmImportacaoSfaMobAndroid.fTipoFrete(strTipFre: String): String;
begin
  // Mantendo compatibilidade de quem ainda não configurou "CFG_FTPFRE";
  Result := IIF(strTipFre = 'C', '2', '1');

  If SameText(strFTPFRE, 'TABLET') Then
  Begin
    Result := '2';

    If UpperCase(strTipFre) = 'C' Then
      Result := '1'
    Else If UpperCase(strTipFre) = 'F' Then
      Result := '2'
    Else If strTipFre = '3' Then
      Result := '3'
    Else If strTipFre = '9' Then
      Result := '9'
    Else If strTipFre = '4' Then
      Result := '4'
    Else If strTipFre = '5' Then
      Result := '5';
  End
  Else If SameText(strFTPFRE, 'CIF') Then
    Result := '1'
  Else If SameText(strFTPFRE, 'FOB') Then
    Result := '2';
end;

procedure TfrmImportacaoSfaMobAndroid.dbgPedidosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = #27 Then
  Begin
    pSetFocus(btnSair);
  End;

end;

procedure TfrmImportacaoSfaMobAndroid.pCalculaTotalItens;
  Var
    fltTotIte: Double;
    fltDesEsp: Double;
begin

  Try

    With cdsPedidosItens Do
    Begin
      cdsPedidos.First;

      While Not cdsPedidos.Eof Do
      Begin
        fltTotIte := 0.0;
        fltDesEsp := 0.0;

        Filtered := False;
        Filter   := 'NUMEROPEDIDO = ' + QuotedStr(cdsPedidos.FieldByName('NUMEROPEDIDO').AsString);
        Filtered := True;

        First;
        While Not Eof Do
        Begin
          fltTotIte := fltTotIte + FieldByName('TOTALITEM').AsFloat;
          fltDesEsp := fltDesEsp + IIF(FieldByName('DESCONTOITEM').AsFloat <= 0, 0, FieldByName('DESCONTOITEM').AsFloat);
          Next;
        End;

        cdsPedidos.Edit;
        cdsPedidos.FieldByName('TOTALBRUTO').AsFloat       := fFormataFloat(fltTotIte, 2);
        cdsPedidos.FieldByName('DESCONTOESPECIAL').AsFloat := fFormataFloat(fltDesEsp, 2);
        cdsPedidos.FieldByName('TOTALLIQUIDO').AsFloat     := (fFormataFloat(fltTotIte, 2) - fFormataFloat(fltDesEsp, 2)) +
                                                              (fFormataFloat(cdsPedidos.FieldByName('VALORFRETE').AsFloat, 2));
        cdsPedidos.Post;

        pRateiaValores(cdsPedidos.FieldByName('VALORFRETE').AsFloat);

        cdsPedidos.Next;
      End;

      Filtered := False;
      Filter   := '';
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

end;

procedure TfrmImportacaoSfaMobAndroid.pCorrigeCepCliente;
var
  frmCepCliente: TfrmAltCepImpostacaoSfa;
begin
  if (not Assigned(cdsClientes)) then
    Exit;

  if (not cdsClientes.Active) then
    Exit;

  if cdsClientes.RecordCount <= 0 then
    Exit;

  pCriarFormularios(TfrmAltCepImpostacaoSfa, frmCepCliente);

  try
    frmCepCliente.pConfiguraGradeCliente;
    cdsClientes.First;

    while not cdsClientes.Eof do
    begin
      if cdsClientes.FieldByName('STATUSIMP').AsString = 'E' Then
      begin
        frmCepCliente.cdsCep.Append;
        frmCepCliente.cdsCep.FieldByName('CODIGO').AsString := cdsClientes.FieldByName('CLI_CODIGOCLIENTE').AsString;
        frmCepCliente.cdsCep.FieldByName('NOMCLI').AsString := cdsClientes.FieldByName('CLI_NOMCLI').AsString;
        frmCepCliente.cdsCep.FieldByName('DOCCLI').AsString := cdsClientes.FieldByName('CLI_C_G_C_').AsString;
        frmCepCliente.cdsCep.FieldByName('CIDCLI').AsString := cdsClientes.FieldByName('CLI_CIDADE').AsString;
        frmCepCliente.cdsCep.FieldByName('CEPCLI').AsString := cdsClientes.FieldByName('CLI_C_E_P_').AsString;
        frmCepCliente.cdsCep.Post;
      end;
      cdsClientes.Next;
    end;

    frmCepCliente.ShowModal;

    if frmCepCliente.ModalResult = mrOk then
    begin
      frmCepCliente.cdsCep.First;

      while not frmCepCliente.cdsCep.Eof do
      begin
        if frmCepCliente.cdsCep.FieldByName('CEPCLI').OldValue <> frmCepCliente.cdsCep.FieldByName('CEPCLI').NewValue then
          pAlteraCep('FSCLIENTE', frmCepCliente.cdsCep.FieldByName('CEPCLI').AsString, frmCepCliente.cdsCep.FieldByName('CODIGO').AsString, frmCepCliente.cdsCep.FieldByName('CEPCLI').OldValue);

        frmCepCliente.cdsCep.Next;
      end;
    end;

    pAtualizarTabelasAuxiliares;
  finally
    pFreeAndNil(frmCepCliente);
  end;
end;

procedure TfrmImportacaoSfaMobAndroid.pCorrigeCepEntrega;
var
  frmCepEntrega: TfrmAltCepImpostacaoSfa;
  intContador: integer;
begin
  if (not Assigned(cdsPedidos)) then
    Exit;

  if (not cdsPedidos.Active) then
    Exit;

  if cdsPedidos.RecordCount <= 0 then
    Exit;

  pCriarFormularios(TfrmAltCepImpostacaoSfa, frmCepEntrega);

  try
    intContador := 0;
    frmCepEntrega.pConfiguraGradeEntrega;
    cdsPedidos.First;

    while not cdsPedidos.Eof do
    begin
      if (cdsPedidos.FieldByName('STATUSIMP').AsString = 'E') and (fPedidoContemEnderecoDeEntrega(cdsPedidos.FieldByName('NUMEROPEDIDO').AsString)) Then
      begin
        frmCepEntrega.cdsCep.Append;
        frmCepEntrega.cdsCep.FieldByName('NUMPED').AsString := cdsPedidos.FieldByName('NUMEROPEDIDO').AsString;
        frmCepEntrega.cdsCep.FieldByName('DTAPED').AsDateTime := cdsPedidos.FieldByName('DATAPEDIDO').AsDateTime;
        frmCepEntrega.cdsCep.FieldByName('CODCLI').AsString := cdsPedidos.FieldByName('CODIGOCLIENTE').AsString;
        frmCepEntrega.cdsCep.FieldByName('ENDENT').AsString := fCampoTabela('ENT_ENDENT', 'FSENDENTREGA', ['ENT_NUMEROPEDIDO'], [frmCepEntrega.cdsCep.FieldByName('NUMPED').AsString]);
        frmCepEntrega.cdsCep.FieldByName('CEPENT').AsString := fCampoTabela('ENT_CEPENT', 'FSENDENTREGA', ['ENT_NUMEROPEDIDO'], [frmCepEntrega.cdsCep.FieldByName('NUMPED').AsString]);
        frmCepEntrega.cdsCep.Post;
        Inc(intContador);
      end;
      cdsPedidos.Next;
    end;

    if (intContador = 0) then
    begin
      fMensagem('Atenção', 'Os pedidos com erro não tem endereço vinculado, não é possível corrigir CEP.', ['&Ok']);
      Exit;
    end;

    frmCepEntrega.ShowModal;

    if frmCepEntrega.ModalResult = mrOk then
    begin
      frmCepEntrega.cdsCep.First;

      while not frmCepEntrega.cdsCep.Eof do
      begin
        if frmCepEntrega.cdsCep.FieldByName('CEPENT').OldValue <> frmCepEntrega.cdsCep.FieldByName('CEPENT').NewValue then
          pAlteraCep('FSENDENTREGA', frmCepEntrega.cdsCep.FieldByName('CEPENT').AsString, frmCepEntrega.cdsCep.FieldByName('NUMPED').AsString, frmCepEntrega.cdsCep.FieldByName('CEPENT').OldValue);

        frmCepEntrega.cdsCep.Next;
      end;
    end;

    pAtualizarTabelasPedido;
  finally
    pFreeAndNil(frmCepEntrega);
  end;
end;

procedure TfrmImportacaoSfaMobAndroid.pAtualizandoLocalizacaoClientes;
  Var
    qryAux: TUniQuery;
    qryUpd: TUniQuery;
begin

  With cdsPedidos Do
  Begin
    Try
      qryAux := fCriaQuery(Self);

      qryAux.SQL.Clear;
      qryAux.SQL.Add(' SELECT                          ');
      qryAux.SQL.Add('   *                             ');
      qryAux.SQL.Add(' FROM                            ');
      qryAux.SQL.Add('   FSLOCCLIENTE                  ');
      qryAux.SQL.Add(' WHERE                           ');
      qryAux.SQL.Add('   IFNULL(LOC_IMPORT, "N") = "N" ');

      qryAux.Open;
      qryAux.First;

      qryUpd := fCriaQuery(Self);

      While Not qryAux.Eof Do
      Begin
        pRegistrarProgresso('Aguarde, Atualizando Localização Geográfica dos Clientes...', lblProgressoGeral, pgbProgressoGeral, 0, RecNo, RecordCount);

        If Locate('CODIGOCLIENTE', qryAux.FieldByName('LOC_CODCLI').AsString, []) Then
        Begin
          qryUpd.SQL.Clear;
          qryUpd.Params.Clear;
          qryUpd.SQL.Add('UPDATE ');
          qryUpd.SQL.Add('  CADCLI ');
          qryUpd.SQL.Add('SET ');
          qryUpd.SQL.Add('  CLI_LATITU = :LATITU, ');
          qryUpd.SQL.Add('  CLI_LONGIT = :LONGIT, ');
          qryUpd.SQL.Add('  CLI_RAIO__ = :RAIO__  ');
          qryUpd.SQL.Add('WHERE ');
          qryUpd.SQL.Add('  CLI_CODCLI = :CODCLI  ');

          qryUpd.ParamByName('LATITU').AsString := qryAux.FieldByName('LOC_LATITU').AsString;
          qryUpd.ParamByName('LONGIT').AsString := qryAux.FieldByName('LOC_LONGIT').AsString;
          qryUpd.ParamByName('RAIO__').AsString := qryAux.FieldByName('LOC_RAIO__').AsString;
          qryUpd.ParamByName('CODCLI').AsString := qryAux.FieldByName('LOC_CODCLI').AsString;
          qryUpd.ExecSQL;

          qryAux.Edit;
          qryAux.FieldByName('LOC_IMPORT').AsString := 'S';
          qryAux.Post;
        End;

        qryAux.Next;
      End;
    Finally
      FreeAndNil(qryAux);
      FreeAndNil(qryUpd);
    End;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pValidaDadosBasicosPedidos;

  function fRetStrPedidoAlerta: String;
  begin
    Result := '[PEDIDO: "'+cdsPedidos.FieldByName('NUMEROPEDIDO').AsString+'"]';
  end;

  Var
    strCodCli,
    strCPFCNPJ,
    strMSG,
    strCodProfissional: String;
    strMsgRetorno: String;
    strCodTpA: String;
begin

  With cdsPedidos Do
  Begin
    First;

    While Not Eof Do
    Begin
      strMSG := '';

      pRegistrarProgresso('Aguarde, Validando detalhes do pedido...', lblProgressoGeral, pgbProgressoGeral, 0, RecNo, RecordCount);

      cdsPedidosItens.First;

      If (cdsPedidosItens.RecordCount = 0) Then
      Begin
        pIncrementaMsgErro(strMSG, fRetStrPedidoAlerta + ' sem itens!');

        pGravaLogImpAlteraStatusCdsPedido(strMSG);

        Next;
        Continue;
      End
      Else
      Begin
        While Not cdsPedidosItens.Eof Do
        Begin
          If Not fCarregaItem(cdsPedidosItens.FieldByName('CODIGOPRODUTO').AsString) Then
          Begin
            pIncrementaMsgErro(strMSG, 'Não encontrado o item ' + cdsPedidosItens.FieldByName('CODIGOPRODUTO').AsString + ' do Pedido ' + cdsPedidosItens.FieldByName('NUMEROPEDIDO').AsString + ' na base do Autcom!');

            pGravaLogImpAlteraStatusCdsPedido(strMSG);
          End;

          cdsPedidosItens.Next;
        End;

        If Not fEmptyStr(strMSG) Then
        Begin
          Next;
          Continue;
        End;
      End;

      pRegistrarProgresso('Aguarde, Validando CPF/CNPJ/Cadastro do Cliente...', lblProgressoGeral, pgbProgressoGeral, 0, RecNo, RecordCount);

      strCodCli           := FieldByName('CODIGOCLIENTE').AsString;
      strCPFCNPJ          := FieldByName('CPFCNPJ').AsString;
      strCodProfissional  := FieldByName('CODPROFISSIONAL').AsString;
      if not fEmptyStr(cdsPedidos.FieldByName('CODTIPOATENDIMENTO').AsString) then
        strCodTpA := cdsPedidos.FieldByName('CODTIPOATENDIMENTO').AsString
      else
        strCodTpA := fCfgSis('SFATPA', varString);

      If Not fEmptyStr(strCodCli) Then
      Begin
        {*************************************************************************}
        {* SE O CÓDIGO DO CLIENTE TIVER PREENCHIDO, VERIFICA SE EXISTE NA CADCLI *}
        {**********************************************************************VA*}
        If fEmptyStr(strMSG) And (fEmptyStr(fRetNomCliente(strCodCli))) Then
          pIncrementaMsgErro(strMSG, 'Cliente ' + strCodCli + ' não encontrado no sistema! '+fRetStrPedidoAlerta);

        If fEmptyStr(strMSG) And (Not TConsultaCadastroFit.VerificaSituacaoRegular(strCodCli, False, strMsgRetorno)) Then
          pIncrementaMsgErro(strMSG, 'CPF/CNPJ ' + fMsgCPFCNPJ(strCPFCNPJ) + ' ' + strMsgRetorno + fRetStrPedidoAlerta);
      End
      Else
      Begin
        {*************************************************************************}
        {* VERIFICA CPF/CPNJ DO PEDIDO DE CLIENTE NOVO É VÁLIDO E FOI            *}
        {* DISPONIBILIZADO NA FSCLIENTE                                          *}
        {**********************************************************************VA*}
        If fEmptyStr(strMSG) And (Not fValidaCnpjCpf(strCPFCNPJ)) Then
          pIncrementaMsgErro(strMSG, 'CPF/CNPJ ' + fMsgCPFCNPJ(strCPFCNPJ) + ' inválido! '+fRetStrPedidoAlerta);

        If fEmptyStr(strMSG) And (fCampoTabela('IFNULL(CLI_C_G_C_, "")', 'FSCLIENTE', ['CLI_C_G_C_'], [strCPFCNPJ]) = '') Then
          pIncrementaMsgErro(strMSG, 'CPF/CNPJ ' + fMsgCPFCNPJ(strCPFCNPJ) + ' não encontrado na tabela "FSCLIENTE"! '+fRetStrPedidoAlerta);
      End;

      If Not fEmptyStr(strCodProfissional) Then
      Begin
        {******************************************************************************}
        {* SE O CÓDIGO DO PROFISSIONAL TIVER PREENCHIDO, VERIFICA SE EXISTE NA CADDIV *}
        {**********************************************************************VA******}
        If fEmptyStr(strMSG) And (fEmptyStr(fRetNomProfissional(strCodProfissional))) Then
          pIncrementaMsgErro(strMSG, 'Profissional ' + strCodProfissional + ' não encontrado no sistema! '+fRetStrPedidoAlerta);
      End;

      if Not fEmptyStr(strCodTpA) THen
      begin
        {*************************************************************************************}
        {* SE O CÓDIGO DO TIPO DE ATENDIMENTO TIVER PREENCHIDO, VERIFICA SE EXISTE NA CADTPA *}
        {*************************************************************************************}
        If fEmptyStr(strMSG) And (fEmptyStr(fRetNomTipoAtend(strCodTpA))) then
          pIncrementaMsgErro(strMSG, 'Tipo de atendimento ' + strCodTpA + ' não encontrado no sistema! '+fRetStrPedidoAlerta);
      end;

      pGravaLogImpAlteraStatusCdsPedido(strMSG);

      Next;
    End;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pValidaTransportadora;
  Var
    strAux: String;
    strMSG: String;
begin

  With cdsPedidos Do
  Begin
    First;
    While Not Eof Do
    Begin
      pRegistrarProgresso('Aguarde, Validando Transportadora dos Pedidos...', lblProgressoGeral, pgbProgressoGeral, 0, RecNo, RecordCount);

      strAux := fRetCodTra;
      strMSG := '';

      If (Not fEmptyStr(strAux)) And fEmptyStr(fRetNomTransportadora(strAux)) Then
        pIncrementaMsgErro(strMSG, 'Transportadora ' + strAux + ' não encontrada no sistema!');

      pGravaLogImpAlteraStatusCdsPedido(strMSG);

      Next;
    End;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pValidaVendedor;
  Var
    strMSG: String;
begin

  With cdsPedidos Do
  Begin
    First;
    While Not Eof Do
    Begin
      pRegistrarProgresso('Aguarde, Validando Vendedor dos Pedidos...', lblProgressoGeral, pgbProgressoGeral, 0, RecNo, RecordCount);

      strMSG := '';

      If fEmptyStr(fRetNomVendRep(FieldByName('CODIGOVENDEDOR').AsString)) Then
        pIncrementaMsgErro(strMSG, 'Vendedor ' + FieldByName('CODIGOVENDEDOR').AsString + ' não encontrado no sistema!');

      pGravaLogImpAlteraStatusCdsPedido(strMSG);

      Next;
    End;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pSetaParaAguardandoTodosItensComErro;
begin
  cdsPedidos.First;
  While Not cdsPedidos.Eof Do
  Begin
    If cdsPedidos.FieldByName('STATUSIMP').Text = 'E' Then
    Begin
      pSetaStatusImp('FSPEDIDOCAB', 'NUMEROPEDIDO', cdsPedidos.FieldByName('NUMEROPEDIDO').Text, 'A');
      cdsPedidos.Edit;
      cdsPedidos.FieldByName('STATUSIMP').Text := 'A';
      cdsPedidos.Post;
    End;

    cdsPedidos.Next;
  End;
  cdsPedidos.First;

  cdsClientes.First;
  While Not cdsClientes.Eof Do
  Begin
    If cdsClientes.FieldByName('STATUSIMP').Text = 'E' Then
    Begin
      pSetaStatusImp('FSCLIENTE', 'CLI_CODIGOCLIENTE', cdsClientes.FieldByName('CLI_CODIGOCLIENTE').Text, 'A');
      cdsClientes.Edit;
      cdsClientes.FieldByName('STATUSIMP').Text := 'A';
      cdsClientes.Post;
    End;

    cdsClientes.Next;
  End;
  cdsClientes.First;

  cdsCartoes.First;
  While Not cdsCartoes.Eof Do
  Begin
    If cdsCartoes.FieldByName('STATUSIMP').Text = 'E' Then
    Begin
      pSetaStatusImp('FSCARTOES', 'NUMEROPEDIDO', cdsCartoes.FieldByName('NUMEROPEDIDO').Text, 'A');
      cdsCartoes.Edit;
      cdsCartoes.FieldByName('STATUSIMP').Text := 'A';
      cdsCartoes.Post;
    End;

    cdsCartoes.Next;
  End;
  cdsCartoes.First;
end;

procedure TfrmImportacaoSfaMobAndroid.pSetaStatusImp(strTabela, strCampoChave, strValorChave, strStatus: String);
begin
  With fCriaQuery Do
  Begin
    Close;
    SQL.Text := 'UPDATE '+strTabela+' SET '+IIF(strTabela='FSCLIENTE','CLI_STATUSIMP','STATUSIMP')+' = "'+strStatus+'" WHERE '+strCampoChave+' = :ID';
    ParamByName('ID').AsString := strValorChave;
    ExecSQL;
    Destroy;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pMarcaEndEntregaComoImportado(
  strNumPed: String);
begin
  With fCriaQuery Do Begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE FSENDENTREGA SET ENT_IMPORTADO = "S", ENT_DATAIMPORTACAO = :DTAIMP, ENT_HORAIMPORTACAO = :HORIMP WHERE ENT_NUMEROPEDIDO = :NUMPED ');
    ParamByName('DTAIMP').AsDateTime := VS_Date;
    ParamByName('HORIMP').AsString   := TimeToStr(fTime());
    ParamByName('NUMPED').AsString   := strNumPed;
    ExecSQL;
    Destroy;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pMarcaCartaoComoImportado(strNumPed: String);
  Var
    qryFsCartoes : TUniQuery;
begin
  qryFsCartoes := fCriaQuery(Self);
  Try
    With qryFsCartoes Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE FSCARTOES ');
      SQL.Add('    SET IMPORTADO = :IMPORT, ');
      SQL.Add('        DATAIMPORTACAO = :DTAIMP, ');
      SQL.Add('        HORAIMPORTACAO = :HORIMP ');
      SQL.Add('  WHERE NUMEROPEDIDO = :NUMPED ');
      ParamByName('IMPORT').AsString := 'S';
      ParamByName('DTAIMP').AsDateTime := VS_Date;
      ParamByName('HORIMP').AsDateTime := fTime();
      ParamByName('NUMPED').AsString := strNumPed;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryFsCartoes);
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pMarcaPedidoComoImportado(strNumPed: String);
begin
  With fCriaQuery Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE FSPEDIDOCAB SET IMPORTADO = "S", DATAIMPORTACAO = :DTAIMP, HORAIMPORTACAO = :HORIMP WHERE NUMEROPEDIDO = :NUMPED ');
    ParamByName('DTAIMP').AsDateTime := VS_Date;
    ParamByName('HORIMP').AsString   := TimeToStr(fTime());
    ParamByName('NUMPED').AsString   := strNumPed;
    ExecSQL;
    Destroy;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pGravaLogImpAlteraStatusCdsPedido(strMsgErro: String);
begin
  If fEmptyStr(strMsgErro) Then
  Begin
    If (cdsPedidos.FieldByName('STATUSIMP').Text <> 'E') Then
    Begin
      cdsPedidos.Edit;
      cdsPedidos.FieldByName('STATUSIMP').Text := IIF(btnImporta.Enabled, 'I', 'G');//"I" DE IMPORTADO //"G" DE GRAVADO
      cdsPedidos.Post;
    End;
  End
  Else
  Begin
    pSetaStatusImp('FSPEDIDOCAB', 'NUMEROPEDIDO', cdsPedidos.FieldByName('NUMEROPEDIDO').AsString, 'E');
    pGravaLogImp('FSPEDIDOCAB', cdsPedidos.FieldByName('NUMEROPEDIDO').AsString, strMsgErro);

    cdsPedidos.Edit;
    cdsPedidos.FieldByName('STATUSIMP').Text := 'E';
    cdsPedidos.Post;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pGravaLogAlteracaoCEP(strTabela, strChave,
  strCepNov: String; vrtCepAnt: Variant);
var
  qryLog: TUniQuery;
begin
  qryLog := fCriaQuery;

  try
    qryLog.Close;
    qryLog.SQL.Clear;
    qryLog.SQL.Add('INSERT INTO LOGCEP(AUTOINCREM, CEP_CODOPE, CEP_DTACEP, CEP_HORCEP, CEP_TABELA, CEP_CODIGO, CEP_CEPANT, CEP_CEPNOV)');
    qryLog.SQL.Add('VALUES(:AUTINC, :CODOPE, :DTACEP, :HORCEP, :TABELA, :CODIGO, :CEPANT, :CEPNOV)');

    qryLog.ParamByName('AUTINC').AsString := fRetAutoIncrem('LOGCEP', VS_strCodEmp);
    qryLog.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryLog.ParamByName('DTACEP').AsDate := fRetDataServidor;
    qryLog.ParamByName('HORCEP').AsTime := fRetHoraServidor;
    qryLog.ParamByName('TABELA').AsString := strTabela;
    qryLog.ParamByName('CODIGO').AsString := strChave;
    qryLog.ParamByName('CEPANT').AsString := VarToStr(vrtCepAnt);
    qryLog.ParamByName('CEPNOV').AsString := strCepNov;

    qryLog.ExecSQL;
  finally
    FreeAndNil(qryLog);
  end;
end;

procedure TfrmImportacaoSfaMobAndroid.pGravaLogImp(strTabe, strChav, strMens: String);
begin
  With fCriaQuery Do
  Begin
    Close;
    SQL.Text := 'INSERT INTO FSLOGIMP(CHAVE, DATA, HORA, MENSAGEM, TABELA) VALUES(:CHAV, :DATA, :HORA, :MENS, :TABE)';
    ParamByName('CHAV').AsString := strChav;
    ParamByName('DATA').Value := fNow;
    ParamByName('HORA').Value := fNow;
    ParamByName('MENS').AsString := strMens;
    ParamByName('TABE').AsString := strTabe;
    ExecSQL;
    Destroy;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pGravaLogImpCartoes(strMsgErro, strNumPed: String);
begin
  If Not fEmptyStr(strMsgErro) Then
  Begin
    pSetaStatusImp('FSCARTOES','NUMEROPEDIDO',strNumPed, 'E');
    pGravaLogImp('FSCARTOES', strNumPed, strMsgErro);
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pGravaLogImpClientes(strMsgErro, strCodCli: String);
begin
  If Not fEmptyStr(strMsgErro) Then
  Begin
    pSetaStatusImp('FSCLIENTE', 'CLI_CODIGOCLIENTE', strCodCli, 'E');
    pGravaLogImp('FSCLIENTE', strCodCli, strMsgErro);
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pGravaLogImpNaoVenda(strMsgErro, strCodCli: String);
begin
  If Not fEmptyStr(strMsgErro) Then
  Begin
    pGravaLogImp('FSNAOVENDA', strCodCli, strMsgErro);
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pGravaLogImpNaoVisita(strMsgErro,
  strCodCli: String);
begin
  If Not fEmptyStr(strMsgErro) Then
  Begin
    pGravaLogImp('FSNAOVISITA', strCodCli, strMsgErro);
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pProcessarEnderecoEntregaPedido(
  recFsEndEnt: TRecEnderecoEntrega);
  Var
    strAutEnt : String;
begin
  strAutEnt := '';

  If (fEnderecoJaExiste(recFsEndEnt)) Then
  Begin
    //se endereço de entrega informado já existe:
    //  define como o endereço da entrega

    strAutEnt := fRetEndereco(recFsEndEnt);
  End
  Else
  Begin  //endereço de entrega não existe
    //cliente não possui nenhum endereço de entrega:
    //  insere endereço como padrão faturamento
    If (Not fClientePossuiEnderecoEntrega(recFsEndEnt.strCodCli, False)) Then
      strAutEnt := fIncluirEnderecoEntrega(recFsEndEnt, 'S')

    //cliente não possui endereço de entrega padrão do faturamento:
    //  somente insere o endereço e define como padrão do faturamento
    Else If (Not fClientePossuiEnderecoEntrega(recFsEndEnt.strCodCli, True))
      And (Not fEnderecoJaExiste(recFsEndEnt)) Then
      strAutEnt := fIncluirEnderecoEntrega(recFsEndEnt, 'S')

    //cliente já possui endereço de entrega padrão do faturamento
    Else If (fClientePossuiEnderecoEntrega(recFsEndEnt.strCodCli, True))
      And (Not fEnderecoJaExiste(recFsEndEnt)) Then
      strAutEnt := fIncluirEnderecoEntrega(recFsEndEnt, 'N');
  End;

  pInsereOuEditaEndEnt(recFsEndEnt.strCodCli, strAutEnt);
end;

procedure TfrmImportacaoSfaMobAndroid.pProcessarEnderecoPedido(blnCliNovo: Boolean; recFsCli, recCadCli: TRecEnderecoEntrega; blnCliNovoOuMesmoUF: Boolean = False);

  Function fAlterouEndereco: Boolean;
  Begin
    Result := (recFsCli.strEndEnt <> recCadCli.strEndEnt) Or
              (recFsCli.strCodCli <> recCadCli.strCodCli) Or
              (recFsCli.strCliAnt <> recCadCli.strCliAnt) Or
              (recFsCli.strBaiEnt <> recCadCli.strBaiEnt) Or
              (recFsCli.strCepEnt <> recCadCli.strCepEnt) Or
              (recFsCli.strTelEnt <> recCadCli.strTelEnt) Or
              (recFsCli.strConEnt <> recCadCli.strConEnt) Or
              (recFsCli.strRefEnt <> recCadCli.strRefEnt) Or
              (recFsCli.strCidEnt <> recCadCli.strCidEnt) Or
              (recFsCli.strCodCid <> recCadCli.strCodCid) Or
              (recFsCli.strNomCid <> recCadCli.strNomCid) Or
              (recFsCli.strConCli <> recCadCli.strConCli) Or
              (recFsCli.strCobIss <> recCadCli.strCobIss) Or
              (recFsCli.strEstEnt <> recCadCli.strEstEnt) Or
              (recFsCli.strCodReg <> recCadCli.strCodReg) Or
              (recFsCli.strCodObr <> recCadCli.strCodObr) Or
              (recFsCli.strCodArt <> recCadCli.strCodArt) Or
              (recFsCli.strCodCno <> recCadCli.strCodCno) Or
              (recFsCli.strInsImo <> recCadCli.strInsImo) Or
              (recFsCli.strCodCib <> recCadCli.strCodCib) Or
              (recFsCli.strCodTra <> recCadCli.strCodTra) Or
              (recFsCli.blnAltera <> recCadCli.blnAltera);
  End;

  Var
    strAutEnt : String;
begin
  strAutEnt := '';

  If (blnCliNovo) Then
  Begin
    strAutEnt := fIncluirEnderecoEntrega(recFsCli, 'S');
    pInsereOuEditaEndEnt(recFsCli.strCodCli, strAutEnt);
  End
  Else
  Begin
    //endereço já existe, mas houve alteração:
    //  atualiza ENTCLI
    If (fAlterouEndereco()) And (fEnderecoJaExiste(recCadCli)) Then
    Begin
      strAutEnt := fRetEndereco(recCadCli);
      fAtualizarEnderecoEntrega(recFsCli, strAutEnt);

    //cliente não possui nenhum endereço de entrega:
    //  insere endereço como padrão faturamento
    End
    Else If (Not fClientePossuiEnderecoEntrega(recCadCli.strCodCli, False)) Then
      strAutEnt := fIncluirEnderecoEntrega(recFsCli, 'S', blnCliNovoOuMesmoUF)

    //cliente não possui endereço de entrega padrão do faturamento:
    //  somente insere o endereço e define como padrão do faturamento
    Else If (Not fClientePossuiEnderecoEntrega(recCadCli.strCodCli, True))
      And (Not fEnderecoJaExiste(recFsCli)) Then
      strAutEnt := fIncluirEnderecoEntrega(recFsCli, 'S', blnCliNovoOuMesmoUF)

    //cliente já possui endereço de entrega padrão do faturamento
    Else If (fClientePossuiEnderecoEntrega(recCadCli.strCodCli, True))
      And (Not fEnderecoJaExiste(recFsCli)) Then
      strAutEnt := fIncluirEnderecoEntrega(recFsCli, 'N', blnCliNovoOuMesmoUF)

    //retorna o endereço de entrega do cliente
    Else
      strAutEnt := fRetEnderecoPadraoFat(recCadCli.strCodCli);

    pInsereOuEditaEndEnt(recCadCli.strCodCli, strAutEnt);
  End;
End;

function TfrmImportacaoSfaMobAndroid.fGetSQLCartoes: String;
begin
  Result := '';
  Result := Result + '';
  Result := Result + ' SELECT  ';
  Result := Result + '   NUMEROPEDIDO,     ';
  Result := Result + '   NUMEROLIBERACAO,  ';
  Result := Result + '   NUMERONSU,        ';
  Result := Result + '   CODIGOCARTAO,     ';
  Result := Result + '   QTDPARCELAS,      ';
  Result := Result + '   VALORVENDA,       ';
  Result := Result + '   IF(TRIM(IFNULL(STATUSIMP,""))="", "A", STATUSIMP) AS STATUSIMP ';
  Result := Result + ' FROM ';
  Result := Result + '   FSCARTOES ';
  Result := Result + ' WHERE ';
  Result := Result + '   LIBERADO = "S" AND IMPORTADO = "N" ';
end;

function TfrmImportacaoSfaMobAndroid.fGetSQLClientes: String;
begin
  Result := '';
  Result := Result + '';
  Result := Result + ' SELECT  ';
  Result := Result + '   CLI_CODIGOCLIENTE,';
  Result := Result + '   CLI_NOMCLI,       ';
  Result := Result + '   CLI_C_G_C_,       ';
  Result := Result + '   CLI_CIDADE,       ';
  Result := Result + '   CLI_C_E_P_,       ';
  Result := Result + '   IF(TRIM(IFNULL(CLI_STATUSIMP,""))="", "A", CLI_STATUSIMP) AS STATUSIMP ';
  Result := Result + ' FROM ';
  Result := Result + '   FSCLIENTE ';
  Result := Result + ' WHERE ';
  Result := Result + '   CLI_LIBERADO = "S" AND CLI_IMPORTADO = "N" ';
end;

function TfrmImportacaoSfaMobAndroid.fGetSQLPedidos: String;
begin
  Result := '';
  Result := Result + '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '   NUMEROPEDIDO,     ';
  Result := Result + '   DATAPEDIDO,       ';
  Result := Result + '   CODIGOCLIENTE,    ';
  Result := Result + '   CAST(CONCAT( MID(REPLACE(HORAINICIAL,":",""), 1, 2), ":", MID(REPLACE(HORAINICIAL,":",""), 3,2), ":", IF(MID(REPLACE(HORAINICIAL,":",""), 5,2)="","00", MID(REPLACE(HORAINICIAL,":",""), 5,2)) ) AS TIME) AS HORAINICIAL, ';
  Result := Result + '   CAST(CONCAT( MID(REPLACE(HORAFINAL  ,":",""), 1, 2), ":", MID(REPLACE(HORAFINAL  ,":",""), 3,2), ":", IF(MID(REPLACE(HORAFINAL  ,":",""), 5,2)="","00", MID(REPLACE(HORAFINAL  ,":",""), 5,2)) ) AS TIME) AS HORAFINAL,   ';
  Result := Result + '   DATAFATURAMENTO,  ';
  Result := Result + '   CODTIPOPEDIDO,    ';
  Result := Result + '   CODCONDPGTO,      ';
  Result := Result + '   CODFORMAPGTO,     ';
  Result := Result + '   PRAZOSFLEXIVEIS,  ';
  Result := Result + '   CODTABELAPRECO,   ';
  Result := Result + '   TIPOFRETE,        ';
  Result := Result + '   ORDEMCOMPRA,      ';
  Result := Result + '   OBSERVACAO1,      ';
  Result := Result + '   OBSERVACAO2,      ';
  Result := Result + '   TOTALBRUTO,       ';
  Result := Result + '   TOTALLIQUIDO,     ';
  Result := Result + '   TOTALLIQUIDO AS TOTALPRODUTOS, ';
  Result := Result + '   TOTALBONIFICACAO, ';
  Result := Result + '   DESCONTOGERAL,    ';
  Result := Result + '   DESCONTOESPECIAL, ';
  Result := Result + '   EMAILCOPIAPEDIDO, ';
  Result := Result + '   CODIGOVENDEDOR,   ';
  Result := Result + '   FATORFLEX,        ';
  Result := Result + '   VALORFLEX,        ';
  Result := Result + '   SENHAAUTORIZACAO, ';
  Result := Result + '   LIBERADO,         ';
  Result := Result + '   IMPORTADO,        ';
  Result := Result + '   IF(TRIM(IFNULL(STATUSIMP,""))="", "A", STATUSIMP) AS STATUSIMP, ';
  Result := Result + '   DATAIMPORTACAO,   ';
  Result := Result + '   HORAIMPORTACAO,   ';
  Result := Result + '   MOTIVOAUTORIZACAO,';
  Result := Result + '   CODIGOROTA,       ';
  Result := Result + '   CPFCNPJ,          ';
  Result := Result + '   CLIENTERETIRA,    ';
  Result := Result + '   IFNULL(CODTRANSPORTADORA, "") AS CODTRANSPORTADORA,';
  Result := Result + '   IFNULL(VALORFRETE, 0) AS VALORFRETE,               ';
  Result := Result + '   NUMPEDCOMPRA,               ';

  If fCampoExiste('FSPEDIDOCAB', 'CODIGOEMPRESA', True) Then
    Result := Result + ' CODIGOEMPRESA, '
  Else
    Result := Result + ' "' + VS_strCodEmp + '" AS CODIGOEMPRESA, ';

  If fCampoExiste('FSPEDIDOCAB', 'ESPECIE', True) Then
    Result := Result + '   IFNULL(ESPECIE, "") AS ESPECIE, '
  Else
    Result := Result + '   " " AS ESPECIE, ';

  If fCampoExiste('FSPEDIDOCAB', 'CODTIPOATENDIMENTO', True) Then
    Result := Result + '   CODTIPOATENDIMENTO, '
  Else
    Result := Result + '   "" AS CODTIPOATENDIMENTO, ';

  Result := Result + '   LATITUDE,             ';
  Result := Result + '   LONGITUDE,            ';
  Result := Result + '   RAIO,                 ';
  Result := Result + '   DESPESASOPERACIONAIS, ';
  Result := Result + '   CODPROFISSIONAL,      ';
  Result := Result + '   CODORIGEM,  ';

  Result := Result + '   LIBPOK,               ';
  Result := Result + '   LIBPOKOPERADOR,       ';
  Result := Result + '   LIBPOKMOTIVO,         ';

  If fCampoExiste('FSPEDIDOCAB', 'DATAENTREGA', True) Then
    Result := Result + '   DATAENTREGA '
  Else
    Result := Result + '   "0" AS DATAENTREGA   ';

  Result := Result + ' FROM ';
  Result := Result + '   FSPEDIDOCAB ';
  Result := Result + ' WHERE ';
  Result := Result + '   LIBERADO = "S" AND IMPORTADO = "N" ';
  Result := Result + ' ORDER BY ';
  Result := Result + '   TENTATIVASGRAVACAO ';
end;

function TfrmImportacaoSfaMobAndroid.fGetSQLPedidosItens: String;

  function fPrecoTabela: String;
  begin
    Result := '';
    {*************************************************************************}
    {* ESTA CONFIGURAÇÃO IRÁ DEFINIR SE O VALOR ORIGINAL SERÁ O CAMPO        *}
    {* PRECOORIGINAL OU PRECOTABELA. ISSO PORQUE O CAMPO PRECOTABELA PODE    *}
    {* VIR COM VALOR DE TABELA OU O VALOR DE TABELA JÁ DEDUZIDO O DESCONTO.  *}
    {**********************************************************************PZ*}
    If (fCfgSis('PREORI', VarString) = '2') Then
    Begin
      If fCampoExiste('FSPEDIDOITENS', 'PROMOCAO', True) Then
        Result := Result + ' IF(I.PROMOCAO = "S", I.PRECOTABELA, I.PRECOORIGINAL) AS PRECOTABELA,  '
      Else
        Result := Result + '   I.PRECOORIGINAL AS PRECOTABELA,  ';
    End
    Else
      Result := Result + '   I.PRECOTABELA,                   ';
  end;

  function fPrecoVenda: String;
  begin
    Result := Result + '   ROUND(I.PRECOVENDA * (1 - DESCONTOPEDIDO / 100), ' + strDecUni + ') AS PRECOLIQUIDO, '
  end;

  function fTotalItem: String;
  begin
    Result := Result + '   I.QTDEVENDA * ROUND( I.PRECOVENDA * (1 - DESCONTOPEDIDO / 100), ' + strDecUni + ') AS TOTALITEM, '
  end;

  function fValorDesconto: String;
  begin
    Result := Result + '   (I.QTDEVENDA * ROUND(I.PRECOVENDA * (1 - DESCONTOPEDIDO / 100), ' + strDecUni + ')) - (I.QTDEVENDA * I.PRECOFINAL) AS DESCONTOITEM, '
  end;

begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE                  ';
  Result := Result + '   I.NUMEROPEDIDO,                    ';
  Result := Result + '   I.CODIGOPRODUTO,                   ';
  Result := Result + '   I.QTDEVENDA,                       ';
  Result := Result + fPrecoTabela;
  Result := Result + fPrecoVenda;
  Result := Result + '   I.CLIENTERETIRA,                   ';
  Result := Result + '   I.PRECOFINAL,                      ';
  Result := Result + '   I.FATORFLEX,                       ';
  Result := Result + '   I.VERBAITEM,                       ';
  Result := Result + '   I.PRECOCUSTO,                      ';
  Result := Result + '   I.OBSERVACAO,                      ';
  Result := Result + '   I.TIPO,                            ';
  Result := Result + '   P.DATAPEDIDO,                      ';
  Result := Result + '   P.CODIGOCLIENTE,                   ';
  Result := Result + '   P.CODCONDPGTO,                     ';
  Result := Result + '   P.CODIGOVENDEDOR,                  ';
  Result := Result + fTotalItem;
  Result := Result + '   I.QTDEVENDA * I.PRECOFINAL  AS TOTALFINAL, ';
  Result := Result + '   I.QTDEVENDA * I.PRECOFINAL  AS TOTALFINALORI, ';
  Result := Result + '   (SELECT IFNULL(ITE_CRODOC,"N") FROM DESSIT WHERE ITE_CODITE=I.CODIGOPRODUTO) AS CROSDOCK, ';

  If fCampoExiste('FSPEDIDOITENS', 'PROMOCAO', True) Then
    Result := Result + '   I.PROMOCAO, '
  Else
    Result := Result + ' "N" AS PROMOCAO, ';

  If fCampoExiste('FSPEDIDOITENS', 'DESCRICAOESPECIAL', True) Then
    Result := Result + '   I.DESCRICAOESPECIAL, '
  Else
    Result := Result + ' " " AS DESCRICAOESPECIAL, ';

  If fCampoExiste('FSPEDIDOITENS', 'CODTABELAPRECO', True) Then
    Result := Result + '   IFNULL(I.CODTABELAPRECO, " ") AS CODTABELAPRECO, '
  Else
    Result := Result + ' " " AS CODTABELAPRECO, ';

  If fCampoExiste('FSPEDIDOITENS', 'NUMEROORDEMCOMPRA', True) Then
    Result := Result + '   IFNULL(I.NUMEROORDEMCOMPRA, " ") AS NUMEROORDEMCOMPRA, '
  Else
    Result := Result + ' " " AS NUMEROORDEMCOMPRA, ';

  If fCampoExiste('FSPEDIDOITENS', 'NUMEROITEMNOPEDIDO', True) Then
    Result := Result + '   IFNULL(I.NUMEROITEMNOPEDIDO, " ") AS NUMEROITEMNOPEDIDO, '
  Else
    Result := Result + ' " " AS NUMEROITEMNOPEDIDO, ';

  Result := Result + ' 0.00 AS VALFREITE, ';
  Result := Result + ' 0    AS AUTINCAUX, ';
  Result := Result + fValorDesconto;
  Result := Result + '   I.DESCONTO, ';
  Result := Result + '   I.DESCONTOESPECIAL, ';
  Result := Result + '  "NOR" AS IDEPRO, ';
  Result := Result + '  " " AS MD5KEY, ';
  Result := Result + '   IFNULL(I.NUMEROLOTE, "") AS NUMEROLOTE, ';
  Result := Result + '   CAST(NULL AS CHAR(5)) AS ITEMESTRUTURA, ';
  Result := Result + '   CAST(NULL AS UNSIGNED) AS SEQITEMESTRUTURA, ';
  Result := Result + '   0.0000 AS PRECOITEMESTRUTURA, ';
  Result := Result + '   0.0000 AS QUANTIDADESUBITEMESTRUTURA, ';
  Result := Result + '   0.0000 AS PRECOSUBITEMESTRUTURA, ';
  Result := Result + '   "N" AS SUBITEM, ';
  Result := Result + '   "N" AS BXSBIT,  ';
  Result := Result + '   I.DESCONTOCONDICAOPGTO, ';
  Result := Result + '   P.CODPROFISSIONAL,  ';

  //Informacoes referentes tinta automotiva
  Result := Result + '   " "  AS TIPOPRECO,      '; //(C = CONCENTRADO / D = DILUIDO)
  Result := Result + '   0.00 AS VOLUME,         '; //(VOLUME VENDIDO. EX = 900 ML)
  Result := Result + '   " "  AS TIPOCOR,        '; //(TIPO DE COR. EX = DELFLEET)
  Result := Result + '   " "  AS CODDILUENTE,    '; //(CODIGO DO DILUENTE)
  Result := Result + '   0.00 AS PORDILUICAO,    '; //(PORCENTAGEM DILUICAO)
  Result := Result + '   " "  AS CODEMBALAGEM,   '; //(CODIGO DA EMBALAGEM)
  Result := Result + '   0.00 AS PRECOEMBALAGEM, '; //(PRECO DA EMBALAGEM)
  Result := Result + '   " "  AS TIPOEMBALAGEM,  '; //(TIPO DE EMBALAGEM = EX: LT, GL, LA E ETC)
  Result := Result + '   " "  AS LINHATINTA      '; //(LINHA DA TINTA)

  Result := Result + ' FROM                                 ';
  Result := Result + '   FSPEDIDOITENS I                    ';
  Result := Result + '   JOIN FSPEDIDOCAB P                 ';
  Result := Result + '   ON P.NUMEROPEDIDO = I.NUMEROPEDIDO ';
  Result := Result + '   AND P.LIBERADO = "S"               ';
  Result := Result + '   AND P.IMPORTADO = "N"              ';

  If fTabelaExiste('FSPEDIDOITENSTINTA', True) Then
  Begin
    // PRECOTABELA  DESCONTO  DESCONTOESPECIAL  CODIGOEMPRESA  PRECOORIGINAL
    Result := Result + ' UNION ALL ';
    Result := Result + ' SELECT SQL_NO_CACHE                  ';
    Result := Result + '   I.NUMEROPEDIDO,                    ';
    Result := Result + '   "TINTA" AS CODIGOPRODUTO,          ';
    Result := Result + '   I.QTDEVENDA,                       ';
    Result := Result + fPrecoTabela;
    Result := Result + '   ROUND(I.PRECOVENDA * (1 - I.DESCONTOPEDIDO / 100), ' + strDecUni + ') AS PRECOLIQUIDO, ';
    Result := Result + '   I.CLIENTERETIRA,                   ';
    Result := Result + '   I.PRECOFINAL,                      ';
    Result := Result + '   P.FATORFLEX,                       ';
    Result := Result + '   0.00 AS VERBAITEM,                 ';
    Result := Result + '   0.00 AS PRECOCUSTO,                ';
    Result := Result + '   I.OBSERVACAO,                      ';
    Result := Result + '   "V" AS TIPO,                       ';
    Result := Result + '   P.DATAPEDIDO,                      ';
    Result := Result + '   P.CODIGOCLIENTE,                   ';
    Result := Result + '   P.CODCONDPGTO,                     ';
    Result := Result + '   P.CODIGOVENDEDOR,                  ';
    Result := Result + '   I.QTDEVENDA * ROUND(I.PRECOVENDA * (1 - I.DESCONTOPEDIDO / 100), ' + strDecUni + ') AS TOTALITEM, ';
    Result := Result + '   I.QTDEVENDA * I.PRECOFINAL AS TOTALFINAL, ';
    Result := Result + '   I.QTDEVENDA * I.PRECOFINAL  AS TOTALFINALORI, ';
    Result := Result + '   "N" AS CROSDOCK, ';
    Result := Result + '   I.PROMOCAO, ';
    Result := Result + '   I.DESCRICAOTINTA AS DESCRICAOESPECIAL, ';
    Result := Result + ' " " AS CODTABELAPRECO, ';
    Result := Result + ' " " AS NUMEROORDEMCOMPRA, ';
    Result := Result + ' " " AS NUMEROITEMNOPEDIDO, ';
    Result := Result + ' 0.00 AS VALFREITE, ';
    Result := Result + ' 0    AS AUTINCAUX, ';
    Result := Result + '   (I.QTDEVENDA * ROUND(I.PRECOVENDA * (1 - I.DESCONTOPEDIDO / 100), ' + strDecUni + ')) - (I.QTDEVENDA * I.PRECOFINAL) AS DESCONTOITEM, ';
    Result := Result + '   I.DESCONTO, ';
    Result := Result + '   I.DESCONTOESPECIAL, ';
    Result := Result + '   I.IDEPRO, ';
    Result := Result + '   I.MD5KEY, ';
    Result := Result + '   " " AS NUMEROLOTE, ';
    Result := Result + '   CAST(NULL AS CHAR(5)) AS ITEMESTRUTURA, ';
    Result := Result + '   CAST(NULL AS UNSIGNED) AS SEQITEMESTRUTURA, ';
    Result := Result + '   0.0000 AS PRECOITEMESTRUTURA, ';
    Result := Result + '   0.0000 AS QUANTIDADESUBITEMESTRUTURA, ';
    Result := Result + '   0.0000 AS PRECOSUBITEMESTRUTURA, ';
    Result := Result + '   "N" AS SUBITEM, ';
    Result := Result + '   "N" AS BXSBIT,  ';
    Result := Result + '  0.00 AS DESCONTOCONDICAOPGTO, ';
    Result := Result + '   P.CODPROFISSIONAL,  ';

    //Informacoes referentes tinta automotiva
    Result := Result + '   I.TIPOPRECO,      '; //(C = CONCENTRADO / D = DILUIDO)
    Result := Result + '   I.VOLUME,         '; //(VOLUME VENDIDO. EX = 900 ML)
    Result := Result + '   I.TIPOCOR,        '; //(TIPO DE COR. EX = DELFLEET)
    Result := Result + '   I.CODDILUENTE,    '; //(CODIGO DO DILUENTE)
    Result := Result + '   I.PORDILUICAO,    '; //(PORCENTAGEM DILUICAO)
    Result := Result + '   I.CODEMBALAGEM,   '; //(CODIGO DA EMBALAGEM)
    Result := Result + '   I.PRECOEMBALAGEM, '; //(PRECO DA EMBALAGEM)
    Result := Result + '   I.TIPOEMBALAGEM,  '; //(TIPO DE EMBALAGEM = EX: LT, GL, LA E ETC)
    Result := Result + '   I.LINHATINTA      '; //(LINHA DA TINTA)

    Result := Result + ' FROM FSPEDIDOITENSTINTA I ';
    Result := Result + ' JOIN FSPEDIDOCAB P ON P.NUMEROPEDIDO = I.NUMEROPEDIDO ';
    Result := Result + '                   AND P.LIBERADO = "S" ';
    Result := Result + '                   AND P.IMPORTADO = "N" ';
  End;

  Result := Result + ' ORDER BY   ';
  Result := Result + '     1 DESC ';
end;

function TfrmImportacaoSfaMobAndroid.fImportaEmpresaDaTabelaFS: Boolean;
begin
  Result := (Not ((blnModoRobo) And (Not fEmptyStr(fEmpMob)))) And
            (strUMTEMP = IMPORTA_EMPRESA_SFA[iesEmpresaDaTabelaFS]);
end;

function TfrmImportacaoSfaMobAndroid.fInsereAtualizaClienteRetCodCli(strCPFCNPJ: String; qryFs_CliRef: TUniQuery; Out strMSG: String): String;
  Var
    qryFs_Cli,
    qryCadCli: TUniQuery;
    strCodCliAux,
    strCodCidAux,
    strCobCidAux: String;
    blnPassouFs_Cli: Boolean;
    blnEhCliNovo: Boolean;
    recEndCadCli, recEndFsCli: TRecEnderecoEntrega;
    strMsgRetorno: string;
    blnCliNovoOuMesmoUF: Boolean;

    Procedure pInicializaDadosEnderecoFsCliente;
      Var
        strEndere: String;
    begin
      strEndere := qryFs_Cli.FieldByName('CLI_ENDERE').AsString +
                     IIF(qryFs_Cli.FieldByName('CLI_ENDNUM').AsString = '', '', ', ') +
                         qryFs_Cli.FieldByName('CLI_ENDNUM').AsString +
                     IIF(qryFs_Cli.FieldByName('CLI_ENDCOM').AsString = '', '', ' - ') +
                         qryFs_Cli.FieldByName('CLI_ENDCOM').AsString;

      recEndFsCli.strEndEnt := strEndere;
      recEndFsCli.strCodCli := qryCadCli.FieldByName('CLI_CODCLI').AsString;
      recEndFsCli.strCliAnt := qryCadCli.FieldByName('CLI_CODCLI').AsString;
      recEndFsCli.strBaiEnt := qryFs_Cli.FieldByName('CLI_BAIRRO').AsString;
      recEndFsCli.strCepEnt := qryFs_Cli.FieldByName('CLI_C_E_P_').AsString;
      recEndFsCli.strTelEnt := qryFs_Cli.FieldByName('CLI_FONE01').AsString;
      recEndFsCli.strConEnt := qryFs_Cli.FieldByName('CLI_ENDCOM').AsString;
      recEndFsCli.strRefEnt := qryFs_Cli.FieldByName('CLI_REFENT').AsString;
      recEndFsCli.strCidEnt := strCodCidAux;
      recEndFsCli.strCodCid := strCodCidAux;
      recEndFsCli.strNomCid := fRetNomCidade(strCodCidAux);
      recEndFsCli.strConCli := '';
      recEndFsCli.strCobIss := '';
      recEndFsCli.strEstEnt := '';
      recEndFsCli.strCodReg := '';
      recEndFsCli.strCodObr := '';
      recEndFsCli.strCodArt := '';
      recEndFsCli.strCodCno := '';
      recEndFsCli.strInsImo := '';
      recEndFsCli.strCodCib := '';
      recEndFsCli.strCodTra := '';
      recEndFsCli.blnAltera := False;
    End;

    Procedure pInicializaDadosEnderecoCadCli;
      Var
        strEndere: String;
    begin
      strEndere := qryCadCli.FieldByName('CLI_ENDERE').AsString +
                     IIF(qryCadCli.FieldByName('CLI_ENDNUM').AsString = '', '', ', ') +
                         qryCadCli.FieldByName('CLI_ENDNUM').AsString +
                     IIF(qryCadCli.FieldByName('CLI_ENDCOM').AsString = '', '', ' - ') +
                         qryCadCli.FieldByName('CLI_ENDCOM').AsString;

      recEndCadCli.strEndEnt := strEndere;
      recEndCadCli.strCodCli := qryCadCli.FieldByName('CLI_CODCLI').AsString;
      recEndCadCli.strCliAnt := qryCadCli.FieldByName('CLI_CODCLI').AsString;
      recEndCadCli.strBaiEnt := qryCadCli.FieldByName('CLI_BAIRRO').AsString;
      recEndCadCli.strCepEnt := qryCadCli.FieldByName('CLI_C_E_P_').AsString;
      recEndCadCli.strTelEnt := qryCadCli.FieldByName('CLI_FONE01').AsString;
      recEndCadCli.strConEnt := qryCadCli.FieldByName('CLI_ENDCOM').AsString;
      recEndCadCli.strRefEnt := qryCadCli.FieldByName('CLI_REFENT').AsString;
      recEndCadCli.strCidEnt := strCodCidAux;
      recEndCadCli.strCodCid := strCodCidAux;
      recEndCadCli.strNomCid := fRetNomCidade(strCodCidAux);
      recEndCadCli.strConCli := '';
      recEndCadCli.strCobIss := '';
      recEndCadCli.strEstEnt := '';
      recEndCadCli.strCodReg := '';
      recEndCadCli.strCodObr := '';
      recEndCadCli.strCodArt := '';
      recEndCadCli.strCodCno := '';
      recEndCadCli.strInsImo := '';
      recEndCadCli.strCodCib := '';
      recEndCadCli.strCodTra := '';
      recEndCadCli.blnAltera := False;
    End;

begin
  Result              := '';
  strCodCidAux        := '';
  strCobCidAux        := '';
  blnPassouFs_Cli     := Assigned(qryFs_CliRef);
  blnCliNovoOuMesmoUF := False;

  if Assigned(objLogAltCadCli) then
    objLogAltCadCli.LogVar.Clear;
  If (Not fValidaCnpjCpf(strCPFCNPJ)) Then
  Begin
    pIncrementaMsgErro(strMSG, 'CPF/CNPJ ' + fMsgCPFCNPJ(strCPFCNPJ) + ' inválido!');
    Exit;
  End;

  strCodCliAux := fRetCodCliAutComPeloCPFCNPJ(strCPFCNPJ);

  Try
    If blnPassouFs_Cli Then
    Begin
      qryFs_Cli := qryFs_CliRef;
    End
    Else
    Begin
      qryFs_Cli := fCriarQuery('SELECT * FROM FSCLIENTE WHERE ' + 'CLI_C_G_C_ = '+QuotedStr(strCPFCNPJ) + ' ORDER BY CLI_CODIGOCLIENTE');
      qryFs_Cli.Open;
    End;

    qryCadCli := fCriarQuery('SELECT * FROM CADCLI WHERE ' + IfThen(fEmptyStr(strCodCliAux), 'FALSE', 'CLI_CODCLI = '+QuotedStr(strCodCliAux)));
    qryCadCli.Open;

    objLogAltCadCli.pLogAdd('CADCLI', ['AUTOINCREM'], 'CLI_CODCLI = ' + QuotedStr(strCodCliAux), pSetaDisplayLabelCadCli);

    blnEhCliNovo := qryCadCli.IsEmpty;

    If (Not qryFs_Cli.IsEmpty) Then
    Begin
      Try
        With qryCadCli Do
        Begin

          If blnEhCliNovo Then
          Begin
            Insert;
            TfrmCadClientes.pSetaCamposDefaultCliente(qryCadCli);
          End
          Else Edit;

          If Not fEmptyStr(fTiraCaracEspeciais(qryFs_Cli.FieldByName('CLI_C_E_P_').AsString)) Then
          Begin
            strCodCidAux := fRetCodCid(fTiraCaracEspeciais(qryFs_Cli.FieldByName('CLI_C_E_P_').AsString), 'FSCLIENTE->CLI_C_E_P_', strMSG);

            If fEmptyStr(strCodCidAux) Then
              Exit;
          End;

          if (not strCodCliAux.IsEmpty) then
          begin
            if (not TConsultaCadastroFit.VerificaSituacaoRegular(strCodCliAux, False, strMsgRetorno)) then
            begin
              pIncrementaMsgErro(strMSG, 'CPF/CNPJ ' + fMsgCPFCNPJ(strCPFCNPJ) + ' ' + strMsgRetorno);
              Exit;
            end;
          end
          else if not TConsultaCadastroFit.VerificaSituacaoRegular(qryFs_Cli.FieldByName('CLI_C_G_C_').AsString,
                                                                   fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [strCodCidAux]),
                                                                   qryFs_Cli.FieldByName('CLI_I_E_S_').AsString,
                                                                   strMsgRetorno) then
          begin
            pIncrementaMsgErro(strMSG, 'CPF/CNPJ ' + fMsgCPFCNPJ(strCPFCNPJ) + ' ' + strMsgRetorno);
            Exit;
          end;

          If blnEhCliNovo Then
          Begin
            If Not fEmptyStr(fTiraCaracEspeciais(qryFs_Cli.FieldByName('CLI_CEPCOB').AsString)) Then
            Begin
              strCobCidAux := fRetCodCid(fTiraCaracEspeciais(qryFs_Cli.FieldByName('CLI_CEPCOB').AsString), 'FSCLIENTE->CLI_CEPCOB', strMSG);

              If fEmptyStr(strCobCidAux) Then
                Exit;
            End;

            strCodCliAux := fAtualizaProCod('CADCLI', 'CLI_CODCLI');

            FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADCLI', VS_strCodEmp);
            FieldByName('CLI_CODEMP').AsString   := VS_strCodEmp;
            FieldByName('CLI_CODCLI').AsString   := strCodCliAux;

            If Not fEmptyStr(qryFs_Cli.FieldByName('CLI_OBSERV').AsString) Then
              FieldByName('CLI_OBSERV').AsString   := qryFs_Cli.FieldByName('CLI_OBSERV').AsString;

            FieldByName('CLI_CGCCPF').AsString   := qryFs_Cli.FieldByName('CLI_CGCCPF').AsString;
            FieldByName('CLI_C_G_C_').AsString   := qryFs_Cli.FieldByName('CLI_C_G_C_').AsString;

            If Not fEmptyStr(qryFs_Cli.FieldByName('CLI_FANSOB').AsString) Then
              FieldByName('CLI_FANSOB').AsString   := qryFs_Cli.FieldByName('CLI_FANSOB').AsString;

            FieldByName('CLI_DTACAD').AsDateTime := qryFs_Cli.FieldByName('CLI_DTACAD').AsDateTime;
            FieldByName('CLI_FONE02').AsString   := qryFs_Cli.FieldByName('CLI_FONE02').AsString;
            FieldByName('CLI_CONTAT').AsString   := qryFs_Cli.FieldByName('CLI_CONTAT').AsString;

            If Not fEmptyStr(strCobCidAux) Then
              FieldByName('CLI_CIDCOB').AsString := strCobCidAux;

            FieldByName('CLI_ENDCOB').AsString   := qryFs_Cli.FieldByName('CLI_ENDCOB').AsString;
            FieldByName('CLI_BAICOB').AsString   := qryFs_Cli.FieldByName('CLI_BAICOB').AsString;
            FieldByName('CLI_CEPCOB').AsString   := fTiraCaracEspeciais(qryFs_Cli.FieldByName('CLI_CEPCOB').AsString);
            FieldByName('CLI_TELCOB').AsString   := qryFs_Cli.FieldByName('CLI_TELCOB').AsString;
            FieldByName('CLI_EMCOB1').AsString   := qryFs_Cli.FieldByName('CLI_EMCOB1').AsString;
            FieldByName('CLI_REFENT').AsString   := qryFs_Cli.FieldByName('CLI_REFENT').AsString;
            FieldByName('CLI_CONSUM').AsString   := qryFs_Cli.FieldByName('CLI_CONSUM').AsString;
            FieldByName('CLI_CODREP').AsString   := qryFs_Cli.FieldByName('CLI_CODREP').AsString;
            FieldByName('CLI_CODVEN').AsString   := qryFs_Cli.FieldByName('CLI_CODVEN').AsString;

            If Not fEmptyStr(qryFs_Cli.FieldByName('CLI_ZONFRA').AsString) Then
              FieldByName('CLI_ZONFRA').AsString   := qryFs_Cli.FieldByName('CLI_ZONFRA').AsString;

            If Not fEmptyStr(qryFs_Cli.FieldByName('CLI_TABPRE').AsString) Then
              FieldByName('CLI_TABPRE').AsString   := qryFs_Cli.FieldByName('CLI_TABPRE').AsString;

            If Not fEmptyStr(qryFs_Cli.FieldByName('CLI_SEGSOC').AsString) Then
              FieldByName('CLI_SEGSOC').AsString   := qryFs_Cli.FieldByName('CLI_SEGSOC').AsString;

            If Not fEmptyStr(qryFs_Cli.FieldByName('CLI_ORGPUB').AsString) Then
              FieldByName('CLI_ORGPUB').AsString   := qryFs_Cli.FieldByName('CLI_ORGPUB').AsString;

            if (fCfgSis('SIMPAU', varBoolean) and fCfgSis('RETIMP', varBoolean)) then
            begin
              FieldByName('CLI_RETPCO').AsString   := 'N';
              FieldByName('CLI_RETIRF').AsString   := 'N';
            end
            else
            begin
              If Not fEmptyStr(qryFs_Cli.FieldByName('CLI_RETPCO').AsString) Then
                FieldByName('CLI_RETPCO').AsString   := qryFs_Cli.FieldByName('CLI_RETPCO').AsString;

              If Not fEmptyStr(qryFs_Cli.FieldByName('CLI_RETIRF').AsString) Then
                FieldByName('CLI_RETIRF').AsString   := qryFs_Cli.FieldByName('CLI_RETIRF').AsString;
            end;

            If Not fEmptyStr(qryFs_Cli.FieldByName('CLI_ENVBOL').AsString) Then
              FieldByName('CLI_ENVBOL').AsString   := qryFs_Cli.FieldByName('CLI_ENVBOL').AsString;

            If Not fEmptyStr(qryFs_Cli.FieldByName('CLI_ISEIPI').AsString) Then
              FieldByName('CLI_ISEIPI').AsString   := qryFs_Cli.FieldByName('CLI_ISEIPI').AsString;

            If Not fEmptyStr(qryFs_Cli.FieldByName('CLI_RETISS').AsString) Then
              FieldByName('CLI_RETISS').AsString   := qryFs_Cli.FieldByName('CLI_RETISS').AsString;

            If Not fEmptyStr(qryFs_Cli.FieldByName('CLI_CLUFID').AsString) Then
              FieldByName('CLI_CLUFID').AsString   := qryFs_Cli.FieldByName('CLI_CLUFID').AsString;

            If Not fEmptyStr(qryFs_Cli.FieldByName('CLI_CODEAC').AsString) Then
              FieldByName('CLI_CODEAC').AsString   := qryFs_Cli.FieldByName('CLI_CODEAC').AsString;

            If Not fEmptyStr(qryFs_Cli.FieldByName('CLI_LIMCRE').AsString) Then
              FieldByName('CLI_LIMCRE').AsFloat    := qryFs_Cli.FieldByName('CLI_LIMCRE').AsFloat;

            FieldByName('CLI_EMAIL3').AsString   := qryFs_Cli.FieldByName('CLI_EMAIL3').AsString;

            If (strSCLNVT = 'T') Then
              FieldByName('CLI_STATUS').AsString := qryFs_Cli.FieldByName('CLI_STATUS').AsString
            Else
              FieldByName('CLI_STATUS').AsString := strSCLNVT;

            If (fEmptyStr(FieldByName('CLI_STATUS').AsString)) Or
               (Not MatchStr(FieldByName('CLI_STATUS').AsString, ['A', 'I'])) Then
              FieldByName('CLI_STATUS').AsString := 'I';

            FieldByName('CLI_CODSIT').AsString   := qryFs_Cli.FieldByName('CLI_CODSIT').AsString;
            FieldByName('CLI_LATITU').AsString   := qryFs_Cli.FieldByName('CLI_LATITU').AsString;
            FieldByName('CLI_LONGIT').AsString   := qryFs_Cli.FieldByName('CLI_LONGIT').AsString;
            FieldByName('CLI_RAIO__').AsString   := qryFs_Cli.FieldByName('CLI_RAIO__').AsString;

            FieldByName('CLI_CONCOB').AsString   := qryFs_Cli.FieldByName('CLI_CONCOB').AsString;
            FieldByName('CLI_OBS_01').AsString   := qryFs_Cli.FieldByName('CLI_OBS_01').AsString;
            FieldByName('CLI_OBS_02').AsString   := qryFs_Cli.FieldByName('CLI_OBS_02').AsString;
            FieldByName('CLI_OBS_03').AsString   := qryFs_Cli.FieldByName('CLI_OBS_03').AsString;
            FieldByName('CLI_OBS_04').AsString   := qryFs_Cli.FieldByName('CLI_OBS_04').AsString;
            FieldByName('CLI_CELULA').AsString   := qryFs_Cli.FieldByName('CLI_CELULA').AsString;
            FieldByName('CLI_ENDNUM').AsString   := qryFs_Cli.FieldByName('CLI_ENDNUM').AsString;
            FieldByName('CLI_ENDCOM').AsString   := qryFs_Cli.FieldByName('CLI_ENDCOM').AsString;
            FieldByName('CLI_OPECAD').AsString   := strLoginUsuarioLogado;

            If fEmptyStr(qryFs_Cli.FieldByName('CLI_CODATI').AsString) Then
              FieldByName('CLI_CODATI').Value := Null
            Else
              FieldByName('CLI_CODATI').AsString := qryFs_Cli.FieldByName('CLI_CODATI').AsString;
          End;

          if (blnEhCliNovo) or (fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [FieldByName('CLI_CODCID').AsString]) = fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [strCodCidAux]))  then
          begin
            If Not fEmptyStr(strCodCidAux) Then
              FieldByName('CLI_CODCID').AsString  := strCodCidAux;

            FieldByName('CLI_C_E_P_').AsString   := fTiraCaracEspeciais(qryFs_Cli.FieldByName('CLI_C_E_P_').AsString);
            FieldByName('CLI_ENDERE').AsString   := qryFs_Cli.FieldByName('CLI_ENDERE').AsString;
            FieldByName('CLI_ENDNUM').AsString   := qryFs_Cli.FieldByName('CLI_ENDNUM').AsString;
            FieldByName('CLI_ENDCOM').AsString   := qryFs_Cli.FieldByName('CLI_ENDCOM').AsString;
            FieldByName('CLI_BAIRRO').AsString   := qryFs_Cli.FieldByName('CLI_BAIRRO').AsString;

            blnCliNovoOuMesmoUF := True;
          end;

          //CAMPOS QUE SEMPRE SERÃO INSERIDOS/EDITADOS
          FieldByName('CLI_I_E_S_').AsString   := qryFs_Cli.FieldByName('CLI_I_E_S_').AsString;
          FieldByName('CLI_NUMR_G').AsString   := qryFs_Cli.FieldByName('CLI_NUMR_G').AsString;
          FieldByName('CLI_NOMCLI').AsString   := qryFs_Cli.FieldByName('CLI_NOMCLI').AsString;

          FieldByName('CLI_FONE01').AsString   := qryFs_Cli.FieldByName('CLI_FONE01').AsString;
          FieldByName('CLI_CELULA').AsString   := qryFs_Cli.FieldByName('CLI_CELULA').AsString;
          FieldByName('CLI_NASCIM').AsDateTime := qryFs_Cli.FieldByName('CLI_NASCIM').AsDateTime;
          FieldByName('CLI_EMAIL_').AsString   := qryFs_Cli.FieldByName('CLI_EMAIL_').AsString;
          FieldByName('CLI_EMAIL3').AsString   := qryFs_Cli.FieldByName('CLI_EMAIL3').AsString;
          FieldByName('CLI_IESUNI').AsString   := qryFs_Cli.FieldByName('CLI_IESUNI').AsString;
          FieldByName('CLI_MICEMP').AsString   := IIF(qryFs_Cli.FieldByName('CLI_MICEMP').AsString = 'S', 'S', 'N');

          If (Not blnEhCliNovo) And
             (Not fEmptyStr(qryFs_Cli.FieldByName('CLI_OBSERV').AsString)) And
             (Not FieldByName('CLI_OBSERV').AsString.Contains(qryFs_Cli.FieldByName('CLI_OBSERV').AsString)) Then
            FieldByName('CLI_OBSERV').AsString := qryFs_Cli.FieldByName('CLI_OBSERV').AsString + sLineBreak + FieldByName('CLI_OBSERV').AsString;

          //CAMPOS QUE SEMPRE SERÃO INSERIDOS/EDITADOS

          If (qryCadCli.State In [dsEdit, dsInsert]) Then
          Begin
            qryCadCli.Post;

            if Assigned(objLogAltCadCli) then
            begin
             if (qryCadCli.State in [dsInsert]) then
               objLogAltCadCli.pProcessarLogs(' = ' + QuotedStr(qryCadCli.FieldByName('CLI_CODCLI').AsString))
             else
               objLogAltCadCli.pProcessarLogs;
            end;
            qryFs_Cli.Edit;
            qryFs_Cli.FieldByName('CLI_IMPORTADO').AsString := 'S';
            qryFs_Cli.Post;

            Result := FieldByName('CLI_CODCLI').AsString;
          End;

          //Inicializa os dados para cadastro do endereço padrão do faturamento
          pInicializaDadosEnderecoCadCli();

          //Inicializa os dados para cadastro do endereço padrão do faturamento
          pInicializaDadosEnderecoFsCliente();

          pProcessarEnderecoPedido(blnEhCliNovo, recEndFsCli, recEndCadCli, blnCliNovoOuMesmoUF);

        End;

      Except
        On E: Exception Do
          pMensagensErro(E.message, '');
      End;
    End;
  Finally
    If (qryCadCli.State In [dsEdit, dsInsert]) Then
      qryCadCli.Cancel;

    If Assigned(qryCadCli) Then
      FreeAndNil(qryCadCli);

    If Assigned(qryFs_Cli) And (Not blnPassouFs_Cli) Then
      FreeAndNil(qryFs_Cli);
  End;
end;

function TfrmImportacaoSfaMobAndroid.fInsereCidade(strCEP, strLocal: String; Out strMsg: String): String;
Var
  qryCadCid,
  qryDadCid : TUniQuery;
  strCodCid,
  strEndere,
  strBairro,
  strEstado,
  strNomCid,
  strCodIbge : String;
  blnAchouCidade,
  blnTemCodIBGE : Boolean;

  LCodigoCorreio: String;
begin

  Result    := '';
  strCodCid := '';
  strEndere := '';
  strBairro := '';
  strNomCid := '';
  strEstado := '';

  If fCfgSis('CEPSIG', varBoolean) Then
  Begin
    If (fCadCepDadosCep(strCEP, strCodCid, strEndere, strBairro, strNomCid, strEstado, LCodigoCorreio, '', '')) Then
      Result := strCodCid;
  End
  Else
  Begin

    Try

      qryDadCid := fCriaQuery(Self);

      Try

        With qryDadCid Do
        Begin
          SQL.Clear;
          SQL.Add('SELECT e.id_uf,              ');
          SQL.Add('       e.id_cidade,          ');
          SQL.Add('       e.cep,                ');
          SQL.Add('       c.nome AS cidade,     ');
          SQL.Add('       I.IBG_CODMUN AS IBGE, ');
          SQL.Add('       D.CID_CODCID          ');
          SQL.Add('FROM   endereco e INNER JOIN cidade c ON e.id_cidade = c.id_cidade                        ');
          SQL.Add('                  LEFT  JOIN IBG_CADIBG I ON c.nome = I.IBG_NOMMUN AND e.id_uf = I.IBG_UF ');
          SQL.Add('                  LEFT  JOIN CADCID D    ON e.id_cidade = D.CID_CODCOR ');
          SQL.Add('WHERE  e.cep = :CEP ');
          ParamByName('CEP').AsString := strCEP;
          Open;
        End;

        If (Not qryDadCid.IsEmpty) Then
        Begin
          strCodIbge := qryDadCid.FieldByName('IBGE').AsString;
          strCodCid  := qryDadCid.FieldByName('CID_CODCID').AsString;
        End
        Else
        Begin
          strCodIbge := '';
          If fCampoExiste('cidade', 'ibge', True) Then
          Begin
            qryDadCid.Close;
            qryDadCid.SQL.Text := 'SELECT id_cidade, id_uf, nome as cidade, cep, ibge AS IBGE FROM cidade WHERE cep = :cep AND ibge IS NOT NULL AND TRIM(ibge) <> "" ';
            qryDadCid.ParamByName('cep').AsString := strCEP;
            qryDadCid.Open;

            If (Not qryDadCid.IsEmpty) Then
              strCodIbge := qryDadCid.FieldByName('IBGE').AsString;
          End;
        End;

        blnAchouCidade := Not fEmptyStr(strCodCid);
        blnTemCodIBGE  := Not fEmptyStr(strCodIbge);

        If (Not blnAchouCidade) And (blnTemCodIBGE) Then
        Begin

          {Tenta localizar por IBGE}
          qryCadCid := fCriarQuery('SELECT * FROM CADCID WHERE CID_COIBGE = ' + QuotedStr(strCodIbge));
          qryCadCid.Open;

          If (Not qryCadCid.IsEmpty) Then
            strCodCid := qryCadCid.FieldByName('CID_CODCID').AsString
          Else
          Begin

            {Cadastra Cidade}
            If Not qryDadCid.IsEmpty Then
            Begin

              strCodCid := fAtualizaProCod('CADCID', 'CID_CODCID');

              With qryCadCid Do
              Begin
                Append;
                FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADCID', VS_strCodEmp);
                FieldByName('CID_CODCID').AsString   := strCodCid;
                FieldByName('CID_CODEMP').AsString   := VS_strCodEmp;
                FieldByName('CID_NOMCID').AsString   := UpperCase(fRemoveAcento(qryDadCid.FieldByName('cidade').AsString));
                FieldByName('CID_C_E_P_').AsString   := UpperCase(qryDadCid.FieldByName('cep').AsString);
                FieldByName('CID_CODCOR').AsString   := UpperCase(qryDadCid.FieldByName('id_cidade').AsString);
                FieldByName('CID_ESTADO').AsString   := UpperCase(qryDadCid.FieldByName('id_uf').AsString);
                FieldByName('CID_COIBGE').AsString   := UpperCase(qryDadCid.FieldByName('IBGE').AsString);
                FieldByName('CID_CODPAI').AsString   := '1058';
                FieldByName('CID_ORIGEM').AsString   := 'IMP.ANDROID';
                Post;
              End;

            End;

          End;

        End;

        If Not fEmptyStr(strCodCid) Then
        Begin
          Result := strCodCid;
        End
        Else
        Begin
          pIncrementaMsgErro(strMSG, 'O CEP ' + fFormataCEP(strCEP) + IIF(fEmptyStr(strLocal), ' ', ' '+strLocal+' ')  +
                                     'não foi encontrado ou se refere a um distrito ou município sem código de IBGE. ' +
                                     'Cadastre a cidade antes de importar o cliente!');
        End;

      Finally

        If Assigned(qryDadCid) Then
          FreeAndNil(qryDadCid);

        If Assigned(qryCadCid) Then
          FreeAndNil(qryCadCid);

      End;

    Except
      On E: Exception Do
        pMensagensErro(E.message, '');
    End;

  End;

end;

function TfrmImportacaoSfaMobAndroid.fInsereCliente(strCPFCNPJ: String): String;
Var
    qryAux,
    qryCadCli: TUniQuery;
    strCodCli,
    strCodCid,
    strCobCid: String;

    Function fRetCodCid(strCEP: String): String;
      Var
        strMsg: String;
        qryCid : TUniQuery;
    Begin
      Result := '';

      Try
        qryCid := fCriaQuery;

        With qryCid Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT        ');
          SQL.Add('  CID_CODCID  ');
          SQL.Add('FROM          ');
          SQL.Add('  CADCID      ');
          SQL.Add('WHERE         ');
          SQL.Add('  CID_C_E_P_ = '+ QuotedStr(Copy(strCEP,1,5)));
          SQL.Add('LIMIT 1       ');
          Open;

          If Not IsEmpty Then
            Result := FieldByName('CID_CODCID').AsString
          Else
            Result := fInsereCidade(strCEP, 'FSCLIENTE->CLI_C_E_P_', strMsg);
        End;

      Finally
        FreeAndNil(qryCid);
      End;
    End;

begin
  Result := '';
  qryAux := fCriaQuery;

  strCodCid := '';
  strCobCid := '';

  With qryAux Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT                 ');
    SQL.Add('  *                    ');
    SQL.Add('FROM                   ');
    SQL.Add('  FSCLIENTE            ');
    SQL.Add('WHERE                  ');
    SQL.Add('  CLI_C_G_C_ = :CPFCNP ');
    ParamByName('CPFCNP').AsString := strCPFCNPJ;
    Open;

    If Not IsEmpty Then
    Begin

      Try
        If Not fEmptyStr(fTiraCaracEspeciais(qryAux.FieldByName('CLI_C_E_P_').AsString)) Then
        Begin
          strCodCid := fRetCodCid(fTiraCaracEspeciais(qryAux.FieldByName('CLI_C_E_P_').AsString));

          If fEmptyStr(strCodCid) Then
            Exit;
        End;

        If Not fEmptyStr(fTiraCaracEspeciais(qryAux.FieldByName('CLI_CEPCOB').AsString)) Then
        Begin
          strCobCid := fRetCodCid(fTiraCaracEspeciais(qryAux.FieldByName('CLI_CEPCOB').AsString));

          If fEmptyStr(strCobCid) Then
            Exit;
        End;

        qryCadCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE');
        strCodCli := fAtualizaProCod('CADCLI', 'CLI_CODCLI');

        if not TConsultaCadastroFit.VerificaSituacaoRegular(qryAux.FieldByName('CLI_C_G_C_').AsString,
                                                            fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [strCobCid]),
                                                            qryAux.FieldByName('CLI_I_E_S_').AsString) then
        begin
          Exit;
        end;

        With qryCadCli Do
        Begin
          Open;
          Append;

          FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADCLI', VS_strCodEmp);
          FieldByName('CLI_CODCLI').AsString   := strCodCli;
          FieldByName('CLI_CODEMP').AsString   := VS_strCodEmp;
          FieldByName('CLI_DTACAD').AsDateTime := qryAux.FieldByName('CLI_DTACAD').AsDateTime;
          FieldByName('CLI_NOMCLI').AsString   := qryAux.FieldByName('CLI_NOMCLI').AsString;

          If Not fEmptyStr(strCodCid) Then
            FieldByName('CLI_CODCID').AsString := strCodCid;

          FieldByName('CLI_CODCID').AsString   := strCodCid;
          FieldByName('CLI_ENDERE').AsString   := qryAux.FieldByName('CLI_ENDERE').AsString;
          FieldByName('CLI_BAIRRO').AsString   := qryAux.FieldByName('CLI_BAIRRO').AsString;
          FieldByName('CLI_C_E_P_').AsString   := fTiraCaracEspeciais(qryAux.FieldByName('CLI_C_E_P_').AsString);
          FieldByName('CLI_CGCCPF').AsString   := qryAux.FieldByName('CLI_CGCCPF').AsString;
          FieldByName('CLI_C_G_C_').AsString   := qryAux.FieldByName('CLI_C_G_C_').AsString;
          FieldByName('CLI_I_E_S_').AsString   := qryAux.FieldByName('CLI_I_E_S_').AsString;
          FieldByName('CLI_FONE01').AsString   := qryAux.FieldByName('CLI_FONE01').AsString;
          FieldByName('CLI_FONE02').AsString   := qryAux.FieldByName('CLI_FONE02').AsString;
          FieldByName('CLI_CONTAT').AsString   := qryAux.FieldByName('CLI_CONTAT').AsString;
          FieldByName('CLI_EMAIL_').AsString   := qryAux.FieldByName('CLI_EMAIL_').AsString;

          If Not fEmptyStr(strCobCid) Then
            FieldByName('CLI_CIDCOB').AsString := strCobCid;

          FieldByName('CLI_ENDCOB').AsString   := qryAux.FieldByName('CLI_ENDCOB').AsString;
          FieldByName('CLI_BAICOB').AsString   := qryAux.FieldByName('CLI_BAICOB').AsString;
          FieldByName('CLI_CEPCOB').AsString   := fTiraCaracEspeciais(qryAux.FieldByName('CLI_CEPCOB').AsString);
          FieldByName('CLI_TELCOB').AsString   := qryAux.FieldByName('CLI_TELCOB').AsString;
          FieldByName('CLI_EMCOB1').AsString   := qryAux.FieldByName('CLI_EMCOB1').AsString;
          FieldByName('CLI_REFENT').AsString   := qryAux.FieldByName('CLI_REFENT').AsString;
          FieldByName('CLI_NASCIM').AsDateTime := qryAux.FieldByName('CLI_NASCIM').AsDateTime;
          FieldByName('CLI_NUMR_G').AsString   := qryAux.FieldByName('CLI_NUMR_G').AsString;
          FieldByName('CLI_CONSUM').AsString   := qryAux.FieldByName('CLI_CONSUM').AsString;
          FieldByName('CLI_CODREP').AsString   := qryAux.FieldByName('CLI_CODREP').AsString;
          FieldByName('CLI_CODVEN').AsString   := qryAux.FieldByName('CLI_CODVEN').AsString;
          FieldByName('CLI_ZONFRA').AsString   := qryAux.FieldByName('CLI_ZONFRA').AsString;
          FieldByName('CLI_TABPRE').AsString   := qryAux.FieldByName('CLI_TABPRE').AsString;
          FieldByName('CLI_SEGSOC').AsString   := qryAux.FieldByName('CLI_SEGSOC').AsString;
          FieldByName('CLI_ORGPUB').AsString   := qryAux.FieldByName('CLI_ORGPUB').AsString;
          FieldByName('CLI_RETPCO').AsString   := qryAux.FieldByName('CLI_RETPCO').AsString;
          FieldByName('CLI_RETIRF').AsString   := qryAux.FieldByName('CLI_RETIRF').AsString;
          FieldByName('CLI_RETISS').AsString   := qryAux.FieldByName('CLI_RETISS').AsString;
          FieldByName('CLI_CLUFID').AsString   := qryAux.FieldByName('CLI_CLUFID').AsString;
          FieldByName('CLI_CODEAC').AsString   := qryAux.FieldByName('CLI_CODEAC').AsString;
          FieldByName('CLI_LIMCRE').AsFloat    := qryAux.FieldByName('CLI_LIMCRE').AsFloat;
          FieldByName('CLI_EMAIL3').AsString   := qryAux.FieldByName('CLI_EMAIL3').AsString;
          FieldByName('CLI_STATUS').AsString   := qryAux.FieldByName('CLI_STATUS').AsString;
          FieldByName('CLI_CODSIT').AsString   := qryAux.FieldByName('CLI_CODSIT').AsString;

          FieldByName('CLI_OBSERV').AsString:=qryAux.FieldByName('CLI_OBSERV').AsString;
          FieldByName('CLI_FANSOB').AsString:=qryAux.FieldByName('CLI_FANSOB').AsString;
          FieldByName('CLI_ENDNUM').AsString:=qryAux.FieldByName('CLI_ENDNUM').AsString;
          FieldByName('CLI_ENDCOM').AsString:=qryAux.FieldByName('CLI_ENDCOM').AsString;
          FieldByName('CLI_IESUNI').AsString:=qryAux.FieldByName('CLI_IESUNI').AsString;
          FieldByName('CLI_CELULA').AsString:=qryAux.FieldByName('CLI_CELULA').AsString;
          FieldByName('CLI_ENVBOL').AsString:=qryAux.FieldByName('CLI_ENVBOL').AsString;
          FieldByName('CLI_ISEIPI').AsString:=qryAux.FieldByName('CLI_ISEIPI').AsString;
          FieldByName('CLI_CONCOB').AsString:=qryAux.FieldByName('CLI_CONCOB').AsString;
          FieldByName('CLI_OBS_01').AsString:=qryAux.FieldByName('CLI_OBS_01').AsString;
          FieldByName('CLI_OBS_02').AsString:=qryAux.FieldByName('CLI_OBS_02').AsString;
          FieldByName('CLI_OBS_03').AsString:=qryAux.FieldByName('CLI_OBS_03').AsString;
          FieldByName('CLI_OBS_04').AsString:=qryAux.FieldByName('CLI_OBS_04').AsString;
          FieldByName('CLI_CODATI').AsString:=qryAux.FieldByName('CLI_CODATI').AsString;
          FieldByName('CLI_MICEMP').AsString:=IIF(qryAux.FieldByName('CLI_MICEMP').AsString = 'S', 'S', 'N');
          FieldByName('CLI_OPECAD').AsString := strLoginUsuarioLogado;

          Post;
        End;

        Result := strCodCli;

      Except
        On E: Exception Do
          pMensagensErro(E.message, '');
      End;

      FreeAndNil(qryCadCli);
    End;
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmImportacaoSfaMobAndroid.pProcessarClientesTabFSCLIENTE;
  Var
    qryFs_Cli: TUniQuery;
    strCodCliOri,
    strCodCli,
    strCPFCNPJ,
    strMSG: String;
begin
  {***************************************************************************}
  {* INSERE/ATUALIZA CLIENTES DISPONÍVEIS NA TABELA FSCLIENTE                *}
  {************************************************************************VA*}
  qryFs_Cli := fCriarQuery('SELECT * FROM FSCLIENTE WHERE CLI_LIBERADO = "S" AND CLI_IMPORTADO = "N" ORDER BY CLI_CODIGOCLIENTE');
  Try
    With qryFs_Cli Do
    Begin
      Open;

      While Not Eof Do
      Begin
        strMSG       := '';
        strCPFCNPJ   := FieldByName('CLI_C_G_C_').AsString;
        strCodCliOri := FieldByName('CLI_CODIGOCLIENTE').AsString;

        pRegistrarProgresso('Aguarde, Atualizando/Cadastrando Cliente CPF/CPNJ '+strCPFCNPJ+'...', lblProgressoGeral, pgbProgressoGeral, 0, RecNo, RecordCount);

        If fEmptyStr(strMSG) Then
        Begin
          strCodCli := fInsereAtualizaClienteRetCodCli(strCPFCNPJ, qryFs_Cli, strMSG);

          If fEmptyStr(strCodCli) Then
          Begin
            pIncrementaMsgErro(strMSG, 'Não foi possível criar/atualizar cliente de CPF/CNPJ ' + fMsgCPFCNPJ(strCPFCNPJ) + ', contido na tabela FSCLIENTE!')
          End
          Else
          Begin
            {******************************************************}
            {* ATUALIZA O CÓDIGO DO CLIENTE NA TABELA FSPEDIDOCAB *}
            {***************************************************PZ*}
            If (Not fAtualizaClienteTabFSPEDIDOCAB(strCPFCNPJ, strCodCli)) Then
              pIncrementaMsgErro(strMSG, 'Não foi possível atualizar o código do cliente de CPF/CNPJ ' + fMsgCPFCNPJ(strCPFCNPJ) + ',  na tabela FSPEDIDOCAB!');
          End;

          If Not fEmptyStr(strMSG) Then
          Begin
            pGravaLogImpClientes(strMSG, strCodCliOri);

            cdsPedidos.First;
            While Not cdsPedidos.Eof Do
            Begin
              If (cdsPedidos.FieldByName('CODIGOCLIENTE').Text = strCodCliOri) Or (cdsPedidos.FieldByName('CPFCNPJ').Text = strCPFCNPJ) Then
                pGravaLogImpAlteraStatusCdsPedido(strMSG);

              cdsPedidos.Next;
            End;
          End;
        End;

        Next;
      End;

    End;
  Finally
    FreeAndNil(qryFs_Cli);
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pProcessarClientesTabFSPEDIDOCAB;

  function fRetStrPedidoAlerta: String;
  begin
    Result := '[PEDIDO: "'+cdsPedidos.FieldByName('NUMEROPEDIDO').AsString+'"]';
  end;

  Var
    strCodCli,
    strCPFCNPJ,
    strMSG: String;
begin
  {***************************************************************************}
  {* ATUALIZA O CÓDIGO DO CLIENTE DOS PEDIDOS DE EVENTUAIS NOVOS CLIENTES    *}
  {* INSERIDOS PELA ROTINA fProcessarClientesTabFSCLIENTE                    *}
  {************************************************************************VA*}
  With cdsPedidos Do
  Begin
    First;

    While Not Eof Do
    Begin
      pRegistrarProgresso('Aguarde, Associando novos códigos de clientes...', lblProgressoGeral, pgbProgressoGeral, 0, RecNo, RecordCount);

      strMSG     := '';
      strCodCli  := FieldByName('CODIGOCLIENTE').AsString;
      strCPFCNPJ := FieldByName('CPFCNPJ').AsString;

      If (fEmptyStr(strCodCli)) Or (LeftStr(strCodCli, 1) = 'C') Then
      Begin
        strCodCli := fRetCodCliAutComPeloCPFCNPJ(strCPFCNPJ);

        If fEmptyStr(strCodCli) Then
        Begin
          {*****************************************************************************}
          {* FORÇA TENTATIVA DE CRIAÇÃO DO CLIENTE CASO TENHA HAVIDO ALGUM PROBLEMA    *}
          {* EM ROTINAS ANTERIORES OU O CLIENTE TENHA SIDO EXCLUIDO E SEU STATUS NA    *}
          {* FSCLIENTE ESTEJA CLI_IMPORTADO = 'S'                                      *}
          {**************************************************************************VA*}
          strCodCli := fInsereAtualizaClienteRetCodCli(strCPFCNPJ, NIL, strMSG);

          If fEmptyStr(strCodCli) Then
            pIncrementaMsgErro(strMSG, 'Não foi possível criar/atualizar cliente de CPF/CNPJ ' + fMsgCPFCNPJ(strCPFCNPJ) +'! '+fRetStrPedidoAlerta);
        End
        Else
        Begin
          {*****************************************************************************}
          {* ATRIBUI CÓDIGO DO CLIENTE RECEM CRIADO NO AUTCOM                          *}
          {**************************************************************************VA*}
          Edit;
          cdsPedidos.FieldByName('CODIGOCLIENTE').AsString := strCodCli;
          Post;

          If (Not fAtualizaClienteTabFSPEDIDOCAB(strCPFCNPJ, strCodCli)) Then
            pIncrementaMsgErro(strMSG, 'Não foi possível atualizar o código do cliente de CPF/CNPJ ' + fMsgCPFCNPJ(strCPFCNPJ) + ', na tabela FSPEDIDOCAB!');
        End;
      End;

      If (Not fProcessarEnderecoClientesTabFSENDENTREGA(strMSG)) Then
        pIncrementaMsgErro(strMSG, 'Não foi possível processar o endereço de entrega do cliente de CPF/CNPJ ' + fMsgCPFCNPJ(strCPFCNPJ) + ', na tabela FSENDENTREGA!');

      pGravaLogImpAlteraStatusCdsPedido(strMSG);

      Next;
    End;
  End;
end;

function TfrmImportacaoSfaMobAndroid.fProcessarEnderecoClientesTabFSENDENTREGA(Out strMsg: String): Boolean;
  Var
    qryFs_EndCli: TUniQuery;
    recFsEndEnt: TRecEnderecoEntrega;
    strCodCli, strPedido: String;

  function fRetCodCidEndEntregaPrincipal(ACodCli : String) : String;
    Const
      SQL = 'SELECT ETC_CIDENT FROM ENTCLI WHERE (ETC_CODCLI = :CODCLI) AND (ETC_ENDFAT = "S") AND (ETC_CIDENT IS NOT NULL)';
    Var
      qryAux : TUniQuery;
  begin

    Result := '';

    If ACodCli.IsEmpty Then
      Exit;

    qryAux := fCriaQuery();

    Try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(SQL);
      qryAux.ParamByName('CODCLI').AsString := ACodCli;
      qryAux.Open;

      If Not qryAux.IsEmpty Then
        Result := qryAux.FieldByName('ETC_CIDENT').AsString;

    Finally
      FreeAndNil(qryAux);
    End;

  end;

  Function fInicializaDadosFsEndEntregaCADCLI: Boolean;
    Var
      strEndere, strCodCidAux, strCodCid: String;
      qryCadCli: TUniQuery;
  begin
    Result := True;

    qryCadCli := fCriarQuery('SELECT * FROM CADCLI WHERE CLI_CODCLI = :CODCLI');
    qryCadCli.ParamByName('CODCLI').AsString := strCodCli;
    qryCadCli.Open;

    If Not qryCadCli.IsEmpty Then
    Begin

      strCodCidAux := fRetCodCidEndEntregaPrincipal(strCodCli);

      If fEmptyStr(strCodCidAux) And (Not fEmptyStr(fTiraCaracEspeciais(qryCadCli.FieldByName('CLI_CODCID').AsString))) Then
      Begin
        strCodCid := fTiraCaracEspeciais(qryCadCli.FieldByName('CLI_CODCID').AsString);

        if (not fEmptyStr(fRetNomCidade(strCodCid))) then
          strCodCidAux := strCodCid;
      End;

      If fEmptyStr(strCodCidAux) And (Not fEmptyStr(fTiraCaracEspeciais(qryCadCli.FieldByName('CLI_C_E_P_').AsString))) Then
      Begin
        strCodCidAux := fRetCodCid(fTiraCaracEspeciais(qryCadCli.FieldByName('CLI_C_E_P_').AsString), 'CADCLI->CLI_C_E_P_', strMsg);

        If fEmptyStr(strCodCidAux) Then
          Result := False;
      End;

      If (Result) Then
      Begin
        strEndere := qryCadCli.FieldByName('CLI_ENDERE').AsString +
                     IIF(qryCadCli.FieldByName('CLI_ENDNUM').AsString = '', '', ', ') +
                         qryCadCli.FieldByName('CLI_ENDNUM').AsString +
                     IIF(qryCadCli.FieldByName('CLI_ENDCOM').AsString = '', '', ' - ') +
                         qryCadCli.FieldByName('CLI_ENDCOM').AsString;

        recFsEndEnt.strEndEnt := strEndere;
        recFsEndEnt.strCodCli := strCodCli;
        recFsEndEnt.strCliAnt := strCodCli;
        recFsEndEnt.strBaiEnt := qryCadCli.FieldByName('CLI_BAIRRO').AsString;
        recFsEndEnt.strCepEnt := qryCadCli.FieldByName('CLI_C_E_P_').AsString;
        recFsEndEnt.strTelEnt := qryCadCli.FieldByName('CLI_FONE01').AsString;
        recFsEndEnt.strConEnt := qryCadCli.FieldByName('CLI_ENDCOM').AsString;
        recFsEndEnt.strRefEnt := qryCadCli.FieldByName('CLI_REFENT').AsString;
        recFsEndEnt.strCidEnt := strCodCidAux;
        recFsEndEnt.strCodCid := strCodCidAux;
        recFsEndEnt.strNomCid := fRetNomCidade(strCodCidAux);
        recFsEndEnt.strConCli := '';
        recFsEndEnt.strCobIss := '';
        recFsEndEnt.strEstEnt := '';
        recFsEndEnt.strCodReg := '';
        recFsEndEnt.strCodObr := '';
        recFsEndEnt.strCodArt := '';
        recFsEndEnt.strCodCno := '';
        recFsEndEnt.strInsImo := '';
        recFsEndEnt.strCodCib := '';
        recFsEndEnt.strCodTra := '';
        recFsEndEnt.blnAltera := False;
      End;
    End;

    qryCadCli.Close;
    FreeAndNil(qryCadCli);
  End;

  Function fInicializaDadosFsEndEntrega: Boolean;
    Var
      strEndere, strCodCidAux, strCodCid: String;
  begin
    Result := True;

    If (Not fEmptyStr(fTiraCaracEspeciais(qryFs_EndCli.FieldByName('ENT_CIDENT').AsString))) Then
    Begin
      strCodCid := fTiraCaracEspeciais(qryFs_EndCli.FieldByName('ENT_CIDENT').AsString);

      if (not fEmptyStr(fRetNomCidade(strCodCid))) then
        strCodCidAux := strCodCid;
    End;

    If fEmptyStr(strCodCidAux) And (Not fEmptyStr(fTiraCaracEspeciais(qryFs_EndCli.FieldByName('ENT_CEPENT').AsString))) Then
    Begin
      strCodCidAux := fRetCodCid(fTiraCaracEspeciais(qryFs_EndCli.FieldByName('ENT_CEPENT').AsString), 'FSENDENTREGA->ENT_CEPENT', strMsg);

      If fEmptyStr(strCodCidAux) Then
        Result := False;
    End;

    If (Result) Then
    Begin
      strEndere := qryFs_EndCli.FieldByName('ENT_ENDENT').AsString;

      recFsEndEnt.strEndEnt := strEndere;
      recFsEndEnt.strCodCli := strCodCli;
      recFsEndEnt.strCliAnt := strCodCli;
      recFsEndEnt.strBaiEnt := qryFs_EndCli.FieldByName('ENT_BAIENT').AsString;
      recFsEndEnt.strCepEnt := qryFs_EndCli.FieldByName('ENT_CEPENT').AsString;
      recFsEndEnt.strTelEnt := qryFs_EndCli.FieldByName('ENT_TELENT').AsString;
      recFsEndEnt.strConEnt := qryFs_EndCli.FieldByName('ENT_CONENT').AsString;
      recFsEndEnt.strRefEnt := qryFs_EndCli.FieldByName('ENT_REFENT').AsString;
      recFsEndEnt.strCidEnt := strCodCidAux;
      recFsEndEnt.strCodCid := strCodCidAux;
      recFsEndEnt.strNomCid := fRetNomCidade(strCodCidAux);
      recFsEndEnt.strConCli := '';
      recFsEndEnt.strCobIss := '';
      recFsEndEnt.strEstEnt := '';
      recFsEndEnt.strCodReg := '';
      recFsEndEnt.strCodObr := '';
      recFsEndEnt.strCodArt := '';
      recFsEndEnt.strCodCno := '';
      recFsEndEnt.strInsImo := '';
      recFsEndEnt.strCodCib := '';
      recFsEndEnt.strCodTra := '';
      recFsEndEnt.blnAltera := False;
    End;
  End;
begin
  {***************************************************************************}
  {* INSERE ENDEREÇOS DE CLIENTES DISPONÍVEIS NA TABELA FSENDENTREGA         *}
  {************************************************************************DF*}
  Result := True;

  Try
    strMSG    := '';
    strPedido := cdsPedidos.FieldByName('NUMEROPEDIDO').AsString;
    strCodCli := cdsPedidos.FieldByName('CODIGOCLIENTE').AsString;

    pRegistrarProgresso('Aguarde, Processando endereço de entrega Pedido: ' + strPedido + ' ...', lblProgressoGeral, pgbProgressoGeral, 0, cdsPedidos.RecNo, cdsPedidos.RecordCount);

    qryFs_EndCli := fCriarQuery('SELECT * FROM FSENDENTREGA WHERE ENT_LIBERADO = "S" ' +
                                'AND ENT_IMPORTADO = "N" AND ENT_NUMEROPEDIDO = ' + QuotedStr(strPedido));
    qryFs_EndCli.Open;

    If (Not qryFs_EndCli.IsEmpty) Then
    Begin

      If (qryFs_EndCli.RecordCount > 1) Then
      Begin
        //possui mais de 1 endereço de entrega
        //não deve processar o pedido

        pIncrementaMsgErro(strMSG, 'Pedido: ' + strPedido + ' não pode ser importado. Existem dois endereços de entrega informados. Verifique!');
      End Else If (qryFs_EndCli.RecordCount = 1) Then
      Begin
        //possui somente 1 endereço de entrega para ser processado

        If (fInicializaDadosFsEndEntrega()) Then
        Begin
          pProcessarEnderecoEntregaPedido(recFsEndEnt);
          pMarcaEndEntregaComoImportado(strPedido);
        End Else
          pIncrementaMsgErro(strMSG, 'Pedido: ' + strPedido + ' não pode ser importado. Endereço de entrega informado é inválido. Verifique!');
      End;

    End
    Else
    Begin
      If fCfgSis('ENDCLI', varBoolean) Then
      Begin
        If (fInicializaDadosFsEndEntregaCADCLI()) Then
        Begin
          pProcessarEnderecoEntregaPedido(recFsEndEnt);
        End
        Else
          pIncrementaMsgErro(strMSG, 'Pedido: ' + strPedido + ' não pode ser importado. Endereço de entrega informado é inválido. Verifique!');
      End;
    End;

    If Not fEmptyStr(strMSG) Then
    Begin
      pGravaLogImpAlteraStatusCdsPedido(strMSG);
      Result := False;
    End;

  Finally
    FreeAndNil(qryFs_EndCli);
  End;
end;

function TfrmImportacaoSfaMobAndroid.fPedidoContemEnderecoDeEntrega(
  strNumPed: String): Boolean;
begin
  Result := (Not fEmptyStr(fCampoTabela('ENT_NUMEROPEDIDO', 'FSENDENTREGA', ['ENT_NUMEROPEDIDO'], [strNumPed])));
end;

function TfrmImportacaoSfaMobAndroid.fPedidoJaImportadoNaTabelaFatGor(
  strNumPok: String): TDocPck;
begin
  Result.blnExiste := False;
  Result.strNumDoc := '';
  Result.strEspDoc := '';
  Result.strNumPok := '';
  Result.strCodCli := '';

  If Not Assigned(qryImportados) Then
  Begin
    qryImportados := fCriaQuery(Nil);
    qryImportados.SQL.Text := 'SELECT ' +
                              '  FGO_NUMPOK,   ' +
                              '  FGO_CODEMP,   ' +
                              '  FGO_CODCLI,   ' +
                              '  FGO_NUMDOC,   ' +
                              '  FGO_ESPDOC,   ' +
                              '  FGO_JAFATU    ' +
                              'FROM            ' +
                              '  FATGOR        ' +
                              'WHERE           ' +
                              '  FGO_NUMPOK = :NUMPOK';
  End;
  qryImportados.Close;
  qryImportados.ParamByName('NUMPOK').AsString := strNumPok;
  qryImportados.Open;
  If (Not qryImportados.IsEmpty) Then
  Begin
    Result.blnExiste := True;
    Result.strNumDoc := qryImportados.FieldByName('FGO_NUMDOC').AsString;
    Result.strEspDoc := qryImportados.FieldByName('FGO_ESPDOC').AsString;
    Result.strCodCli := qryImportados.FieldByName('FGO_CODCLI').AsString;
    Result.strNumPok := strNumPok;
  End;
end;

function TfrmImportacaoSfaMobAndroid.fPedidoJaImportadoNaTabelaFS(strNumPok: String): Boolean;
Var
  qryPedido: TUniQuery;
  strSQL: String;
Begin

  Try

    qryPedido := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT         ';
    strSQL := strSQL + '  NUMEROPEDIDO ';
    strSQL := strSQL + 'FROM           ';
    strSQL := strSQL + '  FSPEDIDOCAB  ';
    strSQL := strSQL + 'WHERE          ';
    strSQL := strSQL + '  NUMEROPEDIDO = :NUMPOK AND ';
    strSQL := strSQL + '  IMPORTADO    = "S"';

    With qryPedido Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPOK').AsString := strNumPok;
      Open;
    End;

    Result := qryPedido.RecordCount > 0;

  Finally
    FreeAndNil(qryPedido);
  End;

End;

function TfrmImportacaoSfaMobAndroid.fProcessarTintaDeMaquina(strIdePro, strMd5Key, strDesIte, strCodEmp,
      strCodBasEmb: String; fltQtdEmb, fltQtdIte: Double; var recForTin: TForTin;
      recInfAut: TInfAut; dicRetorno: TDicionario): Boolean;
  Var
    qryTinAux : TUniQuery;
    arrFormul : TForMulTinDetArray;
    arrBaixaPigmentos : TBaixaPigmentosArray;
    stlItensTraMl : TStringList;
    intCont : Integer;
    tipoTinta : TTipoTinta;
    strTipoBaseEmbalagem : String;
    intIndexForm : Integer;
begin
  Result := False;

  If (VS_strUsaTmq = 'N') Then
    Exit;

  If (Not Assigned(fGTinForGeral)) Then
    Exit;

  qryTinAux := fCriaQuery(Self);
  stlItensTraMl := TStringList.Create;

  Try
    Try
      tipoTinta := fTipoTinta(strIdePro);

      dicRetorno['idepro'] := strIdePro;
      dicRetorno['itetin'] := strMd5Key;
      dicRetorno['tippre'] := recInfAut.strTipPre;
      dicRetorno['lintin'] := recInfAut.strLinha_;
      dicRetorno['catali'] := '';
      dicRetorno['lazqua'] := 0;
      dicRetorno['qtdemb'] := fltQtdEmb;
      dicRetorno['qtdite'] := fltQtdIte;
      dicRetorno['desite'] := strDesIte;
      dicRetorno['volpro'] := recInfAut.fltVolume;
      dicRetorno['coddil'] := recInfAut.strCodDil;
      dicRetorno['pordil'] := recInfAut.fltPorDil;
      dicRetorno['dilcon'] := '';
      dicRetorno['porcat'] := 0;
      dicRetorno['tipcor'] := recInfAut.strTipCor;
      dicRetorno['textbase'] := '';
      dicRetorno['moddil'] := 0;
      dicRetorno['complementob'] := '';
      dicRetorno['empite'] := strCodEmp;
      dicRetorno['itebas'] := strCodBasEmb;

      If fGTinForGeral(fRetornaSiglaTinta(IfNull(dicRetorno['idepro'], '')),
                       IfNull(dicRetorno['itetin'], ''),
                       IfNull(dicRetorno['tippre'], ''),
                       IfNull(dicRetorno['lintin'], ''),
                       IfNull(dicRetorno['catali'], ''),
                       IfNull(dicRetorno['lazqua'], 0),
                       IfNull(dicRetorno['qtdemb'], 0),
                       IfNull(dicRetorno['qtdite'], 0),
                       IfNull(dicRetorno['descri'], ''),
                       qryTinAux,
                       IfNull(dicRetorno['volpro'], ''),
                       arrFormul,
                       arrBaixaPigmentos,
                       stlItensTraML,
                       IfNull(dicRetorno['coddil'], ''),
                       IfNull(dicRetorno['pordil'], 0),
                       IfNull(dicRetorno['dilcon'], ''),
                       IfNull(dicRetorno['porcat'], 0),
                       IfNull(dicRetorno['tipcor'], ''),
                       IfNull(dicRetorno['textbas'], ''),
                       IfNull(dicRetorno['moddil'], 0),
                       IfNull(dicRetorno['complementob'], ''),
                       IfNull(dicRetorno['empite'], VS_strCodEmp)) Then
      Begin
        For intCont := Low(arrBaixaPigmentos) To High(arrBaixaPigmentos) Do
        Begin
          dicRetorno['codBaixaPigs'  + IntToStr(intCont)] := arrFormul[intCont + 1].strFormul;
          dicRetorno['strBaixaPigs'  + IntToStr(intCont)] := arrBaixaPigmentos[intCont].strCodIte;
          dicRetorno['qtdBaixaPigs'  + IntToStr(intCont)] := arrBaixaPigmentos[intCont].fltQtdBaixa;
          dicRetorno['strTipComp'    + IntToStr(intCont)] := IIF(arrBaixaPigmentos[intCont].strTipComp = '', 'C', arrBaixaPigmentos[intCont].strTipComp);
          dicRetorno['strPesGraPigs' + IntToStr(intCont)] := IIF(fEmptyStr(arrBaixaPigmentos[intCont].strPesGra), 'N', arrBaixaPigmentos[intCont].strPesGra);
          dicRetorno['qtdEmbalaPigs' + IntToStr(intCont)] := arrBaixaPigmentos[intCont].fltEmbBas;

          dicRetorno['base' + fStrZero(intCont + 1, 2)] := arrFormul[intCont + 1].strFormul;
          dicRetorno['qtdb' + fStrZero(intCont + 1, 2)] := arrFormul[intCont + 1].fltQtdbas;
        End;

        dicRetorno['qtdcols'] := High(arrBaixaPigmentos) - Low(arrBaixaPigmentos);

        recForTin.Formulas := TClassMatrizSaldosColorantes.Create;

        intIndexForm := 0;

        For intCont := 0 To dicRetorno['qtdcols'] Do
        Begin
          intIndexForm := intIndexForm + 1;
//fAdicionar(intIDTinta: Integer; strDescTinta, strCodIte, strDesIte, strCodCol: String; fltQtdFormula: Double; strBasCol: String; strPesGra: String; fltEmbala: Double): TSaldosColorantes; overload;
          recForTin.Formulas.fAdicionar(intIndexForm,
                                        dicRetorno['desite'],
                                        dicRetorno['strBaixaPigs' + IntToStr(intCont)],
                                        fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', dicRetorno['strBaixaPigs' + IntToStr(intCont)]),
                                        dicRetorno['codBaixaPigs' + IntToStr(intCont)],
                                        dicRetorno['qtdBaixaPigs' + IntToStr(intCont)],
                                        IfThen(tipoTinta in [ttImobiliaria, ttIndustrial], IIF(dicRetorno['strTipComp' + IntToStr(intCont)] = 'CT', CATALISADOR, COLORANTE), BASE_AUTOMOTIVA),
                                        dicRetorno['strPesGraPigs' + IntToStr(intCont)],  //Peso em gramas base
                                        dicRetorno['qtdEmbalaPigs' + IntToStr(intCont)]); //Embalagem da base
        End;

        // CASO SEJA IMOBILIARIA, ACRESCENTAR A BASE
        If tipoTinta in [ttImobiliaria, ttIndustrial] Then
          strTipoBaseEmbalagem := BASE_IMOBILIARIA
        Else
        Begin
          // CASO SEJA AUTOMOTIVA, ACRESCENTAR EMBALAGEM
          strTipoBaseEmbalagem := EMBALAGEM;
          strCodBasEmb := recInfAut.strCodEmb;
          dicRetorno['iteemb'] := strCodBasEmb;
        End;

        If Not fEmptyStr(strCodBasEmb) Then
        Begin
          recForTin.Formulas.fAdicionar(intIndexForm + 1,
                                        dicRetorno['desite'],
                                        strCodBasEmb,
                                        fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', strCodBasEmb),
                                        strCodBasEmb,
                                        fltQtdIte, //qryGenDor.FieldByName('FDO_QTDITE').AsFloat
                                        strTipoBaseEmbalagem,
                                        'N',  //Peso em gramas base
                                        0.0); //Embalagem da base
        End;

        pTintaRetornaTabelaPreco(dicRetorno, fGetFatorML(strIdePro));

        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmImportacaoSfaMobAndroid.fProcessarTintaDeMaquina]');
      End;
    End;
  Finally
    FreeAndNil(qryTinAux);
    FreeAndNil(stlItensTraMl);
  End;
end;

function TfrmImportacaoSfaMobAndroid.fGetCodCli(strCodCli,
  strCPFCNPJ: String): String;
Var
    qryAux: TUniQuery;
begin
  Result := strCodCli;

  {***********************************************************************}
  {* SE O CÓDIGO CLIENTE DO PEDIDO ESTIVER VAZIO, SIGNIFICA              *}
  {* QUE É UM CLIENTE QUE AINDA NÃO FOI CADASTRADO NO AUTCOM.            *}
  {* CONFIRMA SE O CLIENTE NÃO ESTÁ CADASTRADO ATRAVÉS DE SEU CPF,       *}
  {* SE NÃO ESTIVER, CADASTRA O NOVO CLIENTE ATRAVÉS DA TABELA FSCLIENTE *}
  {********************************************************************MM*}
  If fEmptyStr(strCodCli) Then
  Begin
    qryAux := fCriaQuery;

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT                 ');
      SQL.Add('  CLI_CODCLI           ');
      SQL.Add('FROM                   ');
      SQL.Add('  CADCLI               ');
      SQL.Add('WHERE                  ');
      SQL.Add('  CLI_C_G_C_ = :CPFCNP ');
      ParamByName('CPFCNP').AsString := strCPFCNPJ;
      Open;

      If IsEmpty Then
        Result := fInsereCliente(strCPFCNPJ)
      Else
        Result := FieldByName('CLI_CODCLI').AsString;
    End;

    FreeAndNil(qryAux);
  End;
end;

function TfrmImportacaoSfaMobAndroid.fGetConPagPedido: String;
begin
  If (fRetTipoForaConPag(cdsPedidos.FieldByName('CODCONDPGTO').AsString) = 'OUTROS') And
     (Not fEmptyStr(cdsPedidos.FieldByName('PRAZOSFLEXIVEIS').AsString)) Then
  Begin
    Result := cdsPedidos.FieldByName('PRAZOSFLEXIVEIS').AsString;
  End
  Else
    Result := fRetConPag(cdsPedidos.FieldByName('CODCONDPGTO').AsString);
end;

function TfrmImportacaoSfaMobAndroid.fRetLoteProduto(strCodIte,
  strNumLot: String): String;
begin
  Result := '';

  If blnAmzSfa Then
  Begin
    Result := strNumLot;

    If fEmptyStr(Result) Then
      Result := TCadLot.fRetornaLoteAtivo(strCodIte, VS_strCodEmp);
  End
  Else
    Result := fRetornaLoteComVerificacoes(strCodIte, strNumLot);
end;

function TfrmImportacaoSfaMobAndroid.fRetornaLoteComVerificacoes(strCodIte, strNumLot: String): String;
begin
  Result := strNumLot;

  If strNumLot = 'A DEFINIR' Then
    Exit;

  If Not fCfgSis('UTIWMS', varBoolean) Then
    Exit('');

  If Not fCfgSis('GLTFSP', varBoolean) Then
    Exit('A DEFINIR');

  If fExisteLote(strNumLot, strCodIte, VS_strCodEmp, True, True) Then
    Result := strNumLot
  Else
    Result := 'A DEFINIR';
end;

function TfrmImportacaoSfaMobAndroid.fDocumentoBonificado(
  strCodTipoPedido: String): Boolean;
begin
  Result := MatchStr(strCodTipoPedido, ['03', '04', '05', '06']);
end;

function TfrmImportacaoSfaMobAndroid.fGetRegraCodTipoPedido(
  strCodTipoPedido: String): String;
begin
  If (strTpdCex = '2') And MatchStr(strCodTipoPedido, ['03', '04', '05', '06']) Then
    Result := ''
  Else If (strCodTipoPedido = '08') And (fCfgSis('PMCPTB', varBoolean)) Then
    Result := 'C'
  Else If MatchStr(strCodTipoPedido, ['01', '03', '04', '05', '06']) Then
    Result := 'B'
  Else
    Result := 'A';
end;

function TfrmImportacaoSfaMobAndroid.fInserirSubItens(cdsDados, cdsClone: TUniClientDataSet): Boolean;

  type
    recSubItem = Record
      intAutInc: INteger;
      strCodIte: String;
      fltPrecoTabela: Double;
      fltPrecoLiquido: Double;
      fltPrecoFinal: Double;
      fltQtdIte : Double;
      fltDescontoItem: Double;
    end;

type
    TMatrizSubItem = Array Of recSubItem;

  Var
    qryDetMat : TUniquery;
    itens : TMatrizFechamento;
    intPosicao : Integer;
    intCnt : Integer;
    strItemEstrutura: String;
    intSeqItemEstrutura: Integer;
    fltPrecoItemEstrutura: Double;
    strFieldName : String;
    arrSubItem : TMatrizSubItem;

Begin
  qryDetMat := fCriaQuery;

  Try
    With qryDetMat Do
    Begin
      SQL.Clear;
      SQL.Add(' SELECT DMT_QTDITE, ');
      SQL.Add('        DMT_ITESUB, ');
      SQL.Add('        ITE_PREVE1  ');
      SQL.Add('   FROM DETMAT ');
      SQL.Add('  INNER JOIN GERMAT G ON DMT_SEQGER = G.AUTOINCREM ');
      SQL.Add('  INNER JOIN ITEGER I ON DMT_ITESUB = I.ITE_CODITE ');
      SQL.Add('                     AND I.ITE_CODEMP = :CODEMP ');
      SQL.Add('  WHERE GMT_CODITE = :CODITE ');

      strItemEstrutura := cdsDados.FieldByName('CODIGOPRODUTO').AsString;
      intSeqItemEstrutura := fRetornaSequencialUnico('SINCPD');
      fltPrecoItemEstrutura := cdsDados.FieldByName('PRECOLIQUIDO').AsFloat;

      ParamByName('CODITE').AsString := strItemEstrutura;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      First;
      SetLength(Itens, 0);
      While Not Eof Do
      Begin
        SetLength(Itens, Length(Itens) + 1);
        SetLength(arrSubItem, Length(arrSubItem) + 1);
        intPosicao := Length(Itens) - 1;

        Itens[intPosicao].intAutInc := intPosicao;
        Itens[intPosicao].strCodIte := FieldByName('DMT_ITESUB').AsString;

        Itens[intPosicao].fltTotIte := fFormataFloat(FieldByName('ITE_PREVE1').AsFloat *
          fFormataFloat(cdsDados.FieldByName('QTDEVENDA').AsFloat * FieldByName('DMT_QTDITE').AsFloat, strDecQtd.ToInteger), 2);

        Itens[intPosicao].strPromoc := cdsDados.FieldByName('PROMOCAO').AsString;

        arrSubItem[Length(arrSubItem)-1].intAutInc := intPosicao;
        arrSubItem[Length(arrSubItem)-1].strCodIte := FieldByName('DMT_ITESUB').AsString;
        arrSubItem[Length(arrSubItem)-1].fltPrecoTabela := 0;
        arrSubItem[Length(arrSubItem)-1].fltPrecoLiquido := 0;
        arrSubItem[Length(arrSubItem)-1].fltPrecoFinal := 0;
        arrSubItem[Length(arrSubItem)-1].fltDescontoItem := 0;
        arrSubItem[Length(arrSubItem)-1].fltQtdIte := cdsDados.FieldByName('QTDEVENDA').AsFloat * FieldByName('DMT_QTDITE').AsFloat;

        Next;
      End;

      // PRECOTABELA
      fatVenda.fltValFre := fFormataFloat(cdsDados.FieldByName('PRECOTABELA').AsFloat * cdsDados.FieldByName('QTDEVENDA').AsFloat, 2);
      fatVenda.arrMatItens := Itens;
      fatVenda.pRateiaValores;

      For intPosicao := Low(Itens) To High(Itens) Do
      Begin
        For intCnt := Low(arrSubItem) To High(arrSubItem) Do
        Begin
          If (arrSubItem[intCnt].intAutInc = Itens[intPosicao].intAutInc) Then
          Begin
            arrSubItem[intCnt].fltPrecoTabela := Itens[intPosicao].fltValFre;
            Break;
          End;
        End;
      End;

      // PRECOLIQUIDO
      fatVenda.fltValFre := fFormataFloat(cdsDados.FieldByName('PRECOLIQUIDO').AsFloat * cdsDados.FieldByName('QTDEVENDA').AsFloat, 2);
      fatVenda.arrMatItens := Itens;
      fatVenda.pRateiaValores;

      For intPosicao := Low(Itens) To High(Itens) Do
      Begin
        For intCnt := Low(arrSubItem) To High(arrSubItem) Do
        Begin
          If (arrSubItem[intCnt].intAutInc = Itens[intPosicao].intAutInc) Then
          Begin
            arrSubItem[intCnt].fltPrecoLiquido := Itens[intPosicao].fltValFre;
            Break;
          End;
        End;
      End;

      //PRECOFINAL
      fatVenda.fltValFre := fFormataFloat(cdsDados.FieldByName('PRECOFINAL').AsFloat * cdsDados.FieldByName('QTDEVENDA').AsFloat, 2);
      fatVenda.arrMatItens := Itens;
      fatVenda.pRateiaValores;

      For intPosicao := Low(Itens) To High(Itens) Do
      Begin
        For intCnt := Low(arrSubItem) To High(arrSubItem) Do
        Begin
          If (arrSubItem[intCnt].intAutInc = Itens[intPosicao].intAutInc) Then
          Begin
            arrSubItem[intCnt].fltPrecoFinal := Itens[intPosicao].fltValFre;
            Break;
          End;
        End;
      End;

      //DESCONTOITEM
      fatVenda.fltValFre := cdsDados.FieldByName('DESCONTOITEM').AsFloat; // Já foi multiplicado no Select!
      fatVenda.arrMatItens := Itens;
      fatVenda.pRateiaValores;

      For intPosicao := Low(Itens) To High(Itens) Do
      Begin
        For intCnt := Low(arrSubItem) To High(arrSubItem) Do
        Begin
          If (arrSubItem[intCnt].intAutInc = Itens[intPosicao].intAutInc) Then
          Begin
            arrSubItem[intCnt].fltDescontoItem := Itens[intPosicao].fltValFre;
            Break;
          End;
        End;
      End;

      For intPosicao := Low(arrSubItem) To High(arrSubItem) Do
      Begin
        cdsClone.Append;

        For intCnt := 0 To cdsClone.FieldCount-1 Do
        Begin
          strFieldName := cdsClone.Fields[intCnt].FieldName;
          If Not cdsDados.FieldByName(strFieldName).IsNull Then
            cdsClone.FieldByName(strFieldName).Value := cdsDados.FieldByName(strFieldName).Value;
        End;

        cdsClone.FieldByName('DESCONTOITEM').AsFloat := arrSubItem[intPosicao].fltDescontoItem;
        cdsClone.FieldByName('CODIGOPRODUTO').AsString := arrSubItem[intPosicao].strCodIte;
        cdsClone.FieldByName('QTDEVENDA').AsFloat := arrSubItem[intPosicao].fltQtdIte;
        cdsClone.FieldByName('PRECOLIQUIDO').AsFloat := fFormataFloat(arrSubItem[intPosicao].fltPrecoLiquido / arrSubItem[intPosicao].fltQtdIte, strDecUni.ToInteger);
        cdsClone.FieldByName('PRECOTABELA').AsFloat := fFormataFloat(arrSubItem[intPosicao].fltPrecoTabela / arrSubItem[intPosicao].fltQtdIte, strDecUni.ToInteger);
        cdsClone.FieldByName('PRECOFINAL').AsFloat := fFormataFloat(arrSubItem[intPosicao].fltPrecoFinal / arrSubItem[intPosicao].fltQtdIte, strDecUni.ToInteger);
        cdsClone.FieldByName('TOTALITEM').AsFloat := fFormataFloat(cdsClone.FieldByName('PRECOLIQUIDO').AsFloat * arrSubItem[intPosicao].fltQtdIte, 2);
        cdsClone.FieldByName('TOTALFINAL').AsFloat := fFormataFloat(arrSubItem[intPosicao].fltQtdIte * cdsClone.FieldByName('PRECOFINAL').AsFloat, 2);
        cdsClone.FieldByName('TOTALFINALORI').AsFloat := fFormataFloat(arrSubItem[intPosicao].fltQtdIte * cdsClone.FieldByName('PRECOFINAL').AsFloat, 2);
        cdsClone.FieldByName('ITEMESTRUTURA').AsString := strItemEstrutura;
        cdsClone.FieldByName('SEQITEMESTRUTURA').AsInteger := intSeqItemEstrutura;
        cdsClone.FieldByName('PRECOITEMESTRUTURA').AsFloat := fltPrecoItemEstrutura;
        If qryDetMat.Locate('DMT_ITESUB', arrSubItem[intPosicao].strCodIte, []) Then
          cdsClone.FieldByName('QUANTIDADESUBITEMESTRUTURA').AsFloat := qryDetMat.FieldByName('DMT_QTDITE').AsFloat;
        cdsClone.FieldByName('PRECOSUBITEMESTRUTURA').AsFloat := cdsClone.FieldByName('PRECOLIQUIDO').AsFloat;
        cdsClone.FieldByName('SUBITEM').AsString := 'S';

        cdsClone.Post;
      End;

    End;
  Finally
    FreeAndNil(qryDetMat);
  End;

  Result := True;
End;

function TfrmImportacaoSfaMobAndroid.fGetStsPagto(strNumPok: String): TSfaStatusPagamento;
  Var
    qryStsPgto : TUniQuery;
begin
  If Not blnSfaPag Then
  Begin
    Result := sspBranco;
    Exit;
  End;

  qryStsPgto := fCriaQuery(Self);
  Try
    With qryStsPgto Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT STATUS ');
      SQL.Add('   FROM FSSTATUSPEDIDO ');
      SQL.Add('  WHERE NUMEROPEDIDO = :NUMPOK ');
      ParamByName('NUMPOK').AsString := strNumPok;
      Open;
      Result := fStrToSfaStsPagto(FieldByName('STATUS').AsString);
      Close;
    End;
  Finally
    FreeAndNil(qryStsPgto);
  End;
end;

function TfrmImportacaoSfaMobAndroid.fValidaMotivoBaixaPedidosComPrazoExcedido: Boolean;
  Var
    strMSG: String;
begin
  Result := True;
  If (blnSfaPag) And
     (fEmptyStr(fCfgSis('MTSFEX'))) Then
  Begin
    strMSG := 'Ao utilizar controle de Status de Pagamento (CFG_SFAPAG), o motivo para baixa dos pedidos com prazo para regularização excedido deve ser preenchido (CFG_MTSFEX)';
    fAlerta(strMSG);
    pGravaLogImpAlteraStatusCdsPedido(strMSG);
    Result := False;
  End;
end;

function TfrmImportacaoSfaMobAndroid.fValidaMotivoBaixaPedidosNaoAprovados: Boolean;
  Var
    strMSG: String;
begin
  Result := True;
  If (blnSfaPag) And
     (fEmptyStr(fCfgSis('SFAMOT'))) Then
  Begin
    strMSG := 'Ao utilizar controle de Status de Pagamento (CFG_SFAPAG), o motivo para baixa dos pedidos não aprovados deve ser preenchido (CFG_SFAMOT)';
    fAlerta(strMSG);
    pGravaLogImpAlteraStatusCdsPedido(strMSG);
    Result := False;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pVerificaPedidosComStatusDePagamentoAguardando;
  Var
    qryPedido : TUniQuery;
begin
  qryPedido := fCriaQuery(Self);
  pnlProgressoGeral.Visible := True;
  Try
    With qryPedido Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_NUMPOK ');
      SQL.Add('   FROM FATGOR ');
      SQL.Add('   JOIN FSSTATUSPEDIDO ON NUMEROPEDIDO = FGO_NUMPOK ');
      SQL.Add('  WHERE VERIFICADO = "N" ');
      SQL.Add('    AND STATUS = "AG" ');
      SQL.Add('    AND ' + fCurrentDate + ' >= FGO_DTAENT + INTERVAL 7 DAY ');
      Open;

      First;
      While Not Eof Do
      Begin
        pRegistrarProgresso('Aguarde, Verificando pedidos com o status de pagamento: "Aguardando Pagamento"...', lblProgressoGeral, pgbProgressoGeral, 0, RecNo, RecordCount);

        fStartTransaction;
        Try
          pBaixaPedido(FieldByName('FGO_NUMDOC').AsString,
                       FieldByName('FGO_ESPDOC').AsString,
                       FieldByName('FGO_CODEMP').AsString,
                       fCfgSis('MTSFEX'));

          pSetaStatusPagamentoVerificado(FieldByName('FGO_NUMPOK').AsString);

          fCommit;
        Except
          On E: Exception Do
          Begin
            fRollBack;
            pRegistraLogImp('Erro ao alterar o status do pedido [' + FieldByName('FGO_NUMPOK').AsString + ']: ' + E.Message);
          End;
        End;

        Next;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryPedido);
    pnlProgressoGeral.Visible := False;
  End;
end;

function TfrmImportacaoSfaMobAndroid.fVerificaPedidosComStatusDePagamentoAprovadoReprovado: TArrDadosImpressoesVenda;
  Var
    qryPedido : TUniQuery;
    sfaStsPagto : TSfaStatusPagamento;
begin
  qryPedido := fCriaQuery(Self);
  pnlProgressoGeral.Visible := True;
  SetLength(Result, 0);
  Try
    With qryPedido Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_NUMPOK, FGO_CODCLI, ');
      SQL.Add('        FGO_ENT_CD, FGO_VLRCON, STATUS ');
      SQL.Add('   FROM FATGOR ');
      SQL.Add('   JOIN FSSTATUSPEDIDO ON NUMEROPEDIDO = FGO_NUMPOK ');
      SQL.Add('  WHERE VERIFICADO = "N" ');

      If (Not fCfgSis('LIBPED', varBoolean)) Then
        SQL.Add('    AND STATUS IN ("AP", "RP") ')
      Else
        SQL.Add('    AND STATUS = "RP" ');

      Open;

      First;
      While Not Eof Do
      Begin
        pRegistrarProgresso('Aguarde, Verificando status de pagamento para os pedidos que já foram importados...', lblProgressoGeral, pgbProgressoGeral, 0, RecNo, RecordCount);

        sfaStsPagto := fStrToSfaStsPagto(FieldByName('STATUS').AsString);

        fStartTransaction;
        Try
          Case sfaStsPagto Of
            sspPagamentoAprovado:
            Begin
              If (Not fCfgSis('LIBPED', varBoolean)) Then
              Begin
                pLiberaPedido(FieldByName('FGO_NUMDOC').AsString,
                              FieldByName('FGO_ESPDOC').AsString,
                              FieldByName('FGO_CODEMP').AsString);
              End;

              SetLength(Result, Length(Result) + 1);
              FillChar(Result[Length(Result)-1], SizeOf(Result[Length(Result)-1]), #0);
              Result[Length(Result)-1].strCodCli := qryPedido.FieldByName('FGO_CODCLI').AsString;
              Result[Length(Result)-1].strNumDoc := qryPedido.FieldByName('FGO_NUMDOC').AsString;
              Result[Length(Result)-1].strEspDoc := qryPedido.FieldByName('FGO_ESPDOC').AsString;
              Result[Length(Result)-1].strEmpDoc := qryPedido.FieldByName('FGO_CODEMP').AsString;
              Result[Length(Result)-1].strOpcDoc := qryPedido.FieldByName('FGO_ESPDOC').AsString;
              Result[Length(Result)-1].blnEnt_CD := (qryPedido.FieldByName('FGO_ENT_CD').AsString = 'S');
              Result[Length(Result)-1].fltTotGer := qryPedido.FieldByName('FGO_VLRCON').AsFloat;

              If ((Not fCfgSis('IMSESI', varBoolean)) And (SameText(ParamStr(1), PARAM_EXEC_SFAMOB))) Then
                Result[Length(Result)-1].blnImprimeSep := False
              Else
                Result[Length(Result)-1].blnImprimeSep := True;

              Result[Length(Result)-1].arrMatItens := fCarregaMatrizDeItens(qryPedido.FieldByName('FGO_NUMDOC').AsString,
                                                                            qryPedido.FieldByName('FGO_ESPDOC').AsString,
                                                                            qryPedido.FieldByName('FGO_CODEMP').AsString,
                                                                            qryPedido.FieldByName('FGO_CODCLI').AsString);

              If (Length(Result[Length(Result)-1].arrMatItens) > 0) Then
              Begin
                fatVenda.strClaFis := Result[Length(Result)-1].arrMatItens[0].strClaFis;
                fatVenda.pCalculaPesBruLiq(Result[Length(Result)-1].arrMatItens);
                Result[Length(Result)-1].fltPesBru := fatVenda.fltPesBru;
              End;
            End;
            sspPagamentoReprovado:
            Begin
              pBaixaPedido(FieldByName('FGO_NUMDOC').AsString,
                           FieldByName('FGO_ESPDOC').AsString,
                           FieldByName('FGO_CODEMP').AsString,
                           fCfgSis('SFAMOT'));
            End;
          End;

          pSetaStatusPagamentoVerificado(FieldByName('FGO_NUMPOK').AsString);

          fCommit;
        Except
          On E: Exception Do
          Begin
            fRollBack;
            pRegistraLogImp('Erro ao alterar o status do pedido [' + FieldByName('FGO_NUMPOK').AsString + ']: ' + E.Message);
          End;
        End;

        Next;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryPedido);
    pnlProgressoGeral.Visible := False;
  End;
end;

function TfrmImportacaoSfaMobAndroid.fPedidoTemMovCar(strNumPok: String): Boolean;
  Var
    qryMovCar : TUniQuery;
begin
  qryMovCar := fCriaQuery(Nil);
  Try
    With qryMovCar Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT COUNT(*) CNT ');
      SQL.Add('   FROM MOVCAR ');
      SQL.Add('  WHERE MCA_NUMPOK = :NUMPOK ');
      ParamByName('NUMPOK').AsString := strNumPok;
      Open;
      Result := (FieldByName('CNT').AsInteger > 0);
      Close;
    End;
  Finally
    FreeAndNil(qryMovCar);
  End;
end;

function TfrmImportacaoSfaMobAndroid.fPermissaoCorrigirCEP: Boolean;
var
  intIndex: integer;
begin
  Result := True;

  If fVerificaAcessoSistema('ALTCEPIMPTABLET') Then
    Exit;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Alterar CEP no registro com erro na importação do Site/Tablet.');
  objLiberacao.objMsgLibera.pAddTextoCaption('Opção', pgcPainel.Pages[pgcPainel.TabIndex].Caption, 13);
  objLiberacao.objMsgLibera.pAddTexto('Mensagem:');

  For intIndex:=0 To mmoLogImp.Lines.Count-1 Do
  Begin
    objLiberacao.objMsgLibera.pAddTexto(mmoLogImp.Lines[intIndex]);
  End;

  objLiberacao.strDirAce := 'ALTCEPIMPTABLET';
  objLiberacao.strMsgSen := 'Alterar CEP no registro com erro na importação do Site/Tablet.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;


  Result := objLiberacao.fLibera;
end;

procedure TfrmImportacaoSfaMobAndroid.pImprimirDocumentosAprovados(
  arrDocsAprov: TArrDadosImpressoesVenda);
  Var
    intCnt : Integer;
    objFatVendaImp : TFatVendaImp;
begin
  If Length(arrDocsAprov) <= 0 Then
    Exit;

  objFatVendaImp := TFatVendaImp.Create;
  pnlProgressoGeral.Visible := True;
  Try
    For intCnt := Low(arrDocsAprov) To High(arrDocsAprov) Do
      objFatVendaImp.Add(arrDocsAprov[intCnt]);

    objFatVendaImp.blnImpSfa := True;
    objFatVendaImp.blnVeriPgto := True;
    objFatVendaImp.sfaStsPagto := sspPagamentoAprovado;
    objFatVendaImp.pImprimirDocumentos(pgbProgressoGeral, lblProgressoGeral, nil, nil);
  Finally
    FreeAndNil(objFatVendaImp);
    pnlProgressoGeral.Visible := False;
  End;
end;

function TfrmImportacaoSfaMobAndroid.fCarregaMatrizDeItens(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): TMatrizFechamento;
  Var
    intPosicao : Integer;
    qryFatDor : TUniQuery;
begin
  SetLength(Result, 0);
  qryFatDor := fCriaQuery(Self);
  Try
    qryFatDor.Close;
    qryFatDor.SQL.Clear;
    qryFatDor.SQL.Add(' SELECT FDO_CODITE, FDO_QTDITE, ITE_PESOIT, FDO_PESLIQ, ');
    qryFatDor.SQL.Add('        FDO_ENTRET, FDO_ENTFUT, FDO_CLAFIS ');
    qryFatDor.SQL.Add('   FROM FATDOR ');
    qryFatDor.SQL.Add('   JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ');
    qryFatDor.SQL.Add('   JOIN CADITE ON CADITE.ITE_CODITE = FATDOR.FDO_CODITE ');
    qryFatDor.SQL.Add('  WHERE FDO_NUMDOC = :NUMDOC ');
    qryFatDor.SQL.Add('    AND FDO_ESPDOC = :ESPDOC ');
    qryFatDor.SQL.Add('    AND FDO_CODEMP = :CODEMP ');
    qryFatDor.SQL.Add('    AND FDO_CODCLI = :CODCLI ');
    qryFatDor.ParamByName('NUMDOC').AsString := strNumDoc;
    qryFatDor.ParamByName('ESPDOC').AsString := strEspDoc;
    qryFatDor.ParamByName('CODEMP').AsString := strCodEmp;
    qryFatDor.ParamByName('CODCLI').AsString := strCodCli;
    qryFatDor.Open;

    qryFatDor.First;
    While Not qryFatDor.Eof Do
    Begin
      SetLength(Result, Length(Result) + 1);
      intPosicao := Length(Result) - 1;
      Result[intPosicao].strCodIte := qryFatDor.FieldByName('FDO_CODITE').AsString;
      Result[intPosicao].fltQtdIte := qryFatDor.FieldByName('FDO_QTDITE').AsFloat;
      Result[intPosicao].strEntRet := qryFatDor.FieldByName('FDO_ENTRET').AsString;
      Result[intPosicao].strEntFut := qryFatDor.FieldByName('FDO_ENTFUT').AsString;
      Result[intPosicao].fltPesoIt := qryFatDor.FieldByName('ITE_PESOIT').AsFloat;
      Result[intPosicao].fltPesLiq := qryFatDor.FieldByName('FDO_PESLIQ').AsFloat;
      Result[intPosicao].strClaFis := qryFatDor.FieldByName('FDO_CLAFIS').AsString;

      qryFatDor.Next;
    End;

    qryFatDor.Close;
  Finally
    FreeAndNil(qryFatDor);
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pIncrementaMsgErro(Var varMsgErro: String; strTextoErro: String; blnRegistrarLogImp : Boolean = true);
begin
  If Not fEmptyStr(strTextoErro) Then
  Begin
    If blnRegistrarLogImp Then
      pRegistraLogImp(strTextoErro);

    varMsgErro := varMsgErro + IIF(fEmptyStr(varMsgErro), '', ' -> ') + strTextoErro;
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pAtivaScrolls(blnAtiva: Boolean);
begin
  If (Not blnModoRobo) Then
  Begin
    If blnAtiva Then
    Begin
      cdsPedidos.AfterScroll  := pAfterScrollCds;
      cdsClientes.AfterScroll := pAfterScrollCds;
      cdsCartoes.AfterScroll  := pAfterScrollCds;
    End
    Else
    Begin
      cdsPedidos.AfterScroll  := Nil;
      cdsClientes.AfterScroll := Nil;
      cdsCartoes.AfterScroll  := Nil;
    End;
  End;
end;

function TfrmImportacaoSfaMobAndroid.fMsgCPFCNPJ(strTexto: String): String;
begin
  Result := IIF(fEmptyStr(strTexto),'<EM BRANCO>',strTexto);
end;

procedure TfrmImportacaoSfaMobAndroid.pAcrescentaTentativaGravacao(strNumeroPedido: string);
var
  qryTemp: TUniQuery;
begin
  qryTemp := fCriaQuery();
  try
    qryTemp.SQL.Text := 'UPDATE FSPEDIDOCAB SET TENTATIVASGRAVACAO = (TENTATIVASGRAVACAO + 1) WHERE NUMEROPEDIDO = :ID AND TENTATIVASGRAVACAO < 100';
    qryTemp.ParamByName('ID').AsString := strNumeroPedido;
    qryTemp.ExecSQL;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TfrmImportacaoSfaMobAndroid.pAfterScrollCds(DataSet: TDataSet);
  Var
    strChave: String;
begin
  If (Not DataSet.IsEmpty) Then
  Begin
    If ((pgcPainel.ActivePage = tbsPedidos) And (DataSet <> cdsPedidos)) Or
       ((pgcPainel.ActivePage = tbsClientes) And (DataSet <> cdsClientes)) Or
       ((pgcPainel.ActivePage = tbsCartoes) And (DataSet <> cdsCartoes)) Then
    Begin
       Exit;
    End;

    mmoLogImp.Clear;
    btnExcluir.Enabled := False;
    btnCorrigeCep.Visible := False;

    If (pgcPainel.ActivePage = tbsClientes) Then
      strChave := DataSet.FieldByName('CLI_CODIGOCLIENTE').Text
    Else
      strChave := DataSet.FieldByName('NUMEROPEDIDO').Text;

    If (DataSet.FieldByName('STATUSIMP').Text = 'E') Then
    Begin
      btnExcluir.Enabled := True;
      btnCorrigeCep.Visible := (pgcPainel.ActivePage <> tbsCartoes);

      With fCriaQuery Do
      Begin
        SQL.Text := 'SELECT * FROM FSLOGIMP WHERE CHAVE = "'+strChave+'" ORDER BY DATA, HORA';
        Open;

        If Not IsEmpty Then
        Begin
          First;

          While Not Eof Do
          Begin
            If Not Bof Then
              mmoLogImp.Lines.Add('');

            mmoLogImp.Lines.Add(FormatDateTime('dd/mm/yyyy', FieldByName('DATA').AsDateTime)+' - '+FormatDateTime('hh:mm:ss', FieldByName('HORA').AsDateTime)+' - '+FieldByName('MENSAGEM').Text);
            Next;
          End;
        End;

        Destroy;
      End;
    End;
  End;
end;

function TfrmImportacaoSfaMobAndroid.fGetSQLNVenda: String;
begin
  Result := '';
  Result := Result + ' SELECT CODIGOCLIENTE, CODIGOMOTIVO, DATA, HORARIO, CODIGOVENDEDOR, ';
  Result := Result + '        LATITUDE, LONGITUDE, PRECISAO, PROVEDOR, VELOCIDADE, STATUSGPS, IMPORTADO, ';
  Result := Result + '        ALTITUDE, DATAIMPORTACAO, HORAIMPORTACAO, OBSERVACAO, DESCRICAOMOTIVO ';
  Result := Result + ' FROM FSNAOVENDA ';
  Result := Result + ' WHERE IMPORTADO = "N" ';
  Result := Result + '   AND LIBERADO = "S" ';
end;

function TfrmImportacaoSfaMobAndroid.fGetSQLNVisita: String;
begin
  Result := '';
  Result := Result + ' SELECT CODIGOCLIENTE, CODIGOMOTIVO, DATA, HORARIO, CODIGOVENDEDOR, ';
  Result := Result + '        LATITUDE, LONGITUDE, PRECISAO, PROVEDOR, VELOCIDADE, STATUSGPS, IMPORTADO, ';
  Result := Result + '        ALTITUDE, DATAIMPORTACAO, HORAIMPORTACAO, OBSERVACAO, DESCRICAOMOTIVO ';
  Result := Result + ' FROM FSNAOVISITA ';
  Result := Result + ' WHERE IMPORTADO = "N" ';
  Result := Result + '   AND LIBERADO = "S" ';
end;

function TfrmImportacaoSfaMobAndroid.fTemNaoVendaNaoVisita: Boolean;
  Var
    qryNVenda,
    qryNVisita: TUniQuery;
begin
  qryNVenda  := fCriaQuery(Self);
  qryNVisita := fCriaQuery(Self);

  Try
    With qryNVenda Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLNVenda);
      Open;

      Result := RecordCount > 0;

      If Not Result Then
      Begin
        With qryNVisita Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(fGetSQLNVisita);
          Open;

          Result := RecordCount > 0;

          Close;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryNVenda);
    FreeAndNil(qryNVisita);
  End;
end;

procedure TfrmImportacaoSfaMobAndroid.pAtualizaMovMod(ANumDoc, AEspDoc, ACodEmp, ACodCli, ACodCar, APixS_N: string);
var
  qryTemp: TUniQuery;
  LTipCar: String;
  LCodRed: String;
begin
  If fEmptyStr(ACodCar) Then
    Exit;

  LTipCar := fRetTipoCartao(ACodCar);
  LCodRed := fRetOperadoraCartao(ACodCar);

  qryTemp := fCriaQuery();

  try
    qryTemp.SQL.Text := 'UPDATE '+
                        '  MOVMOD '+
                        'SET '+
                        '  MOD_TIPCAR = :TIPCAR, '+
                        '  MOD_PIXS_N = :PIXS_N, '+
                        '  MOD_CODRED = :CODRED '+
                        'WHERE MOD_CODMOD = "007" '+
                        '  AND MOD_NUMDOC = :NUMDOC '+
                        '  AND MOD_ESPDOC = :ESPDOC '+
                        '  AND MOD_CODEMP = :CODEMP '+
                        '  AND MOD_CODCLI = :CODCLI ';

    qryTemp.ParamByName('TIPCAR').AsString := LTipCar;
    qryTemp.ParamByName('PIXS_N').AsString := APixS_N;
    qryTemp.ParamByName('CODRED').AsString := LCodRed;
    qryTemp.ParamByName('NUMDOC').AsString := ANumDoc;
    qryTemp.ParamByName('ESPDOC').AsString := AEspDoc;
    qryTemp.ParamByName('CODEMP').AsString := ACodEmp;
    qryTemp.ParamByName('CODCLI').AsString := ACodCli;

    qryTemp.ExecSQL;
  finally
    FreeAndNil(qryTemp);
  end;
end;

end.

