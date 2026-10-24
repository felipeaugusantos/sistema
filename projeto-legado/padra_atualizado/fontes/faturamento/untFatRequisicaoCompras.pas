unit untFatRequisicaoCompras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, System.DateUtils,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, DBCtrls, DBEditFocus,
  untConstantes,
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade, untTLock, untTCdsVinculosRequisicoes;

type

  TRegistroConsumidor = Record
    strCliNom,
    strCliEnd,
    strCliBai,
    strCliCep,
    strCodCid,
    strCliCid,
    strCliEst,
    strCliTel,
    strCliCgc,
    strCliIes,
    strCli_Rg: String;
    intCgcCpf: Integer;
  End;




  TfrmFatRequisicaoCompras = class(TfrmPaiOrdena)
    Panel1: TPanel;
    pnlDadosItens: TPanel;
    Label3: TLabel;
    lblCliFor: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    Label6: TLabel;
    lblIncluir: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtSenVen: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodigo: TEditFocus;
    btnExcluir: TBitBtnLocked;
    Label8: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtQtdIte: TEditFocus;
    btnExcVen: TBitBtnLocked;
    lblDtaCad: TLabel;
    lblDtaUlt: TLabel;
    GroupBox1: TGroupBox;
    Shape2: TShape;
    Label9: TLabel;
    btnCopiarPdv: TBitBtnLocked;
    lblFatVendaRequisicao1: TLabel;
    lblFatVendaRequisicao2: TLabel;
    Label4: TLabel;
    edtDocPdv: TEditFocus;
    edtEspPdv: TEditFocus;
    edtEmpPdv: TEditFocus;
    Label10: TLabel;
    edtObserv: TEditFocus;
    Label11: TLabel;
    Shape1: TShape;
    lblEmpIte: TLabel;
    edtEmpIte: TEditFocus;
    edtAtiCom: TEditFocus;
    lblDtPrevEst: TLabel;
    edtPrevisaoEstoque: TMaskEditFocus;
    btnEstLoj: TBitBtnLocked;
    edtEmpOSe: TEditFocus;
    edtNumOSe: TEditFocus;
    lblOrdSer: TLabel;
    pnlMsg: TPanel;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    lblDigita: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure edtCodCliEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExcVenClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnCopiarPdvClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnEstLojClick(Sender: TObject);
  private
    { Private declarations }
    regConsum: TRegistroConsumidor;

    blnConfirmando,
    blnPodeAlterar,
    blnPodeIncluir,
    blnPodeExcluir: Boolean;

    qryMovRcg,
    qryConCli,
    qryCadIte: TUniQuery;

    strIteAnt,
    strCliAnt: String;

    intDecQtd : Integer;
    objLock: TLock;

    blnRefPed : Boolean;
    blnSolicitarSenhaVendedor: Boolean; //CFG_PSVRPC

    function fCarregaRequisicaoCompra(strCodigo: String): Boolean;

    Class Procedure pUpdateQtdRcd(strAutInc: String; fltQtdIte: Double);

    class function fIncluiRequisicaoCompra(Var strCodSeq: String; strCodCli, strCodVen, strCliCgc: String; cdsDados: TUniClientDataSet; blnComTransacao: Boolean = True; strCodEmpGrv: String=''; strCodDig: String=''): Boolean;
    class function fAlteraRequisicaoCompra(strCodSeq, strCodCli, strCodVen, strCliCgc: String; cdsDados: TUniClientDataSet; blnComTransacao: Boolean = True; AstrCodEmp: String = ''; strCodDig: String=''): Boolean;
    class procedure pRemoveMovRcdNaoProcessado(AListaProcessados: String; strCodSeq: String);

    function fTemItemVenda: Boolean;
    function fDigDadosConsumidor: Boolean;
    function fPermiteApagarRequisicao(): Boolean;
    function fTemPedidoDeCompraVinculado(): Boolean;

    Procedure pHabilitaCampos(blnInclusao: Boolean);

    procedure pIniciaVenda(blnLimpaTela: Boolean = True);
    procedure pLimpaTela;
    procedure pCarregaCabec;
    procedure pTravaItemFracionadoKey(Sender: TObject; var Key: Char);
    procedure pCarregaItem(strCodIte: String);
    procedure pExcluiItem;
    class procedure pAlteraMovRcg(strCodigo, strCodCli, strCodVen, strCliCgc: String; dtaDtaAlt: TDate; strCodEmp: String = ''; strCodDig: String ='');
    {class procedure pApagaMovRcd(strCodigo, strCodEmp: String; strAutInc: String ='');}
    procedure pMostraItem;
    procedure pLimpaItem;
    procedure pGravaItem;
    procedure pEditaItem;
    procedure pCarregaDadosConsumidor(strCodCli: String);

    procedure pAdicionarItensDaVendaSemEstoque;

    procedure pGravar;

    procedure pTravaItensRequisicao;

    function fSolicitaLiberacao: Boolean;
    function fQuantidadeDeItemEhMaiorQueQuantidadeDigitada(var fltQtdeItem: Double): Boolean;
    function fRetObservacaoMovRcd(strCodIte, strDocPdv, strEspPdv, strEmpPdv: String): String;

    procedure pMostraEstoqueLojas;
    procedure pConfigurarEdtSenVen;
    procedure pConfigurarColunas;
    procedure pCarregaOrdemServico;
    class function fBuscaDadosRequisicao: String;
    class procedure pEnviaMensagemNovaRequisicao(strCodigoReq, strCodEmpGrv: String);
    class procedure pEnviaMsgRequisicaoIncluida(const strSeqGer: String);
    class procedure pMontaQryRequisicao(var qryReq: TUniQuery; const strSeqGer: String);
    class procedure pMontaMensagemInclusaoRequisicao(qryReq: TUniQuery; blnMontaCabecalho: Boolean; var stlMsg: TStringList);
    class procedure pEnviarMensagemInclusaoRequisicao(strOpeAtu: String; stlMsg: TStringList);
    class procedure pCarregarOperadoresParaEnvioDeMensagem(var qryOperadores: TUniQuery);
    function fQuantidadeDeItemEhMenorQueQuantidadeDigitada(var fltQtdeItem: Double): Boolean;
    function fRetornaDescricaoItemVenda(strCodIte: String): String;
    function fCarregarItemEspecialRotinaReqCompras(strCodIte: String): Boolean;
    function fHabilitaDigitaVendedor : Boolean;
  public
    { Public declarations }
    blnConfirma : Boolean;
    blnVaiGravarComFaturamento : Boolean;
    blnShowModalConsulta: Boolean;
    cdsVenda: TUniClientDataSet;

    blnLimparTela: Boolean;

    strCodUsu,
    strCodigo,
    strNumOrc,
    strEspOrc,
    strCodVen,
    strCodDig,
    strCodCnd,
    strCodFpg,
    strCodEmp: String;

    blnEntCD: Boolean;
    strEmpCD: String;
    strEmpTE: String;
    blnFaltaProduto: Boolean;
    blnReqTudo: Boolean;
    blnConEqu: Boolean;
    blnCfgReqAut: Boolean;

    class function fProcessarRequisicoesAvulsas(Var AstrCodigo: String; ACdsVinculos, ACdsItensPedido: TUniClientDataSet; AstrCodVen, AstrCodCli, AstrCliCgc, AstrNumDoc, AStrEspDoc, AstrEmpDoc, AstrCodDig: String; ABlnComTransacao: Boolean): Boolean;
    class function fIncluiMovRcd(strCodigo, strCodIte, strDesIte, strObserv, strDocPdv, strEspPdv, strEmpPdv: String; fltQtdIte: Double; dtPrev: TDateTime; strCodEmpGrv: String=''; strSeqPCD: String=''): String;
    class procedure pIncluiMovRcg(strCodigo, strCodCli, strCodVen, strCliCgc : String; dtaDtaCad: TDate; strNumDoc, strEspDoc, strSerie: String; strCodEmpGrv: String=''; strCodDig: String='');

    class function fGravaRequisicaoCompra(Var strCodSeq: String; strCodCli, strCodVen, strCliCgc: String; cdsDados: TUniClientDataSet; blnComTransacao: Boolean = True; strCodEmpGrv: String=''; strCodDig: String=''): Boolean;
    class procedure pExibe(strCodIte, strDesIte: String);
    class procedure pExibeRequisicao(strCodigo, strCodEmp: String);

    class procedure pExibeRequisicaoCompra(strCodigo: String; strCodEmp: String);

    function fAbreConsulta(blnLike: Boolean = True): Boolean; Override;
    function fObterDescricaoItemPedido: Boolean;
    function fPesquisarDescricaoItemEspecialNoPedido: Boolean;
    class function fApagaMovRcd(strAutInc: String): Boolean;
    class procedure pCarregaRequisicoesCompra(stlReqComp: TStringList; strNumDoc, strEspDoc, strCodEmp: String);

    function fSolicitarSenhaVendedor():Boolean;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;


implementation

uses untPai, untPesqAux, untPanelCxClientes, untConsultas, untTypesSistema, untRequisicaoPedidoCompra,
     untFuncoesSimples, untFatDadosCliConsumidor,untPnlDadosCliente, untFuncoes, untMemo,
     untFuncFat, untMovRcd, untFuncoesGenerica, untLiberacao, untMsgLiberacao,
     untPcmGer, untFatMostraEstoqueEmp, UntMsgInterna, System.StrUtils, untFatReqCompraSelItemVenda;

{$R *.dfm}

procedure TfrmFatRequisicaoCompras.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirmando := False;
  blnSolicitarSenhaVendedor := fCfgSis('PSVRPC', varBoolean);
  pConfigurarEdtSenVen;

  blnLimparTela := true;

  pSetaCodIte(edtCodIte);

  blnShowModalConsulta := False;

  strCodUsu := strLoginUsuarioLogado;

  qryMovRcg := fCriaQuery(Self);
  qryConCli := fCriaQuery(Self);
  QRYCADITE := fCriaQuery(Self);

  blnSempreRelerBanco := False;
  blnTemSelecao       := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  intDecQtd := fCfgSis('DECQTD', varInteger);

  blnRefPed := fCfgSis('REFPED', varBoolean);

  edtQtdIte.EditFormat := fMskDigitos(intDecQtd);

  blnVaiGravarComFaturamento := False;
  blnConfirma := False;
  Self.cdsVenda := Nil;
  strNumOrc := '';
  strEspOrc := '';
  blnFaltaProduto := False;
  blnReqTudo := False;
  blnConEqu := False;

  objLock := TLock.Create;

  edtPrevisaoEstoque.Visible := fCfgSis('PRVEST', varBoolean);
  lblDtPrevEst.Visible := fCfgSis('PRVEST', varBoolean);

  lblOrdSer.Visible := fCfgSis('CONEQU', varBoolean);
  edtNumOSe.Visible := lblOrdSer.Visible;
  edtEmpOSe.Visible := lblOrdSer.Visible;
  strEmpTE := EmptyStr;
end;

procedure TfrmFatRequisicaoCompras.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(objLock);
end;

procedure TfrmFatRequisicaoCompras.FormShow(Sender: TObject);
  Var
    strDireitos: String;
begin
  inherited;

  if blnLimparTela then
    pIniciaVenda(Not blnVaiGravarComFaturamento);

  If (blnVaiGravarComFaturamento) Then
  Begin
    pAdicionarItensDaVendaSemEstoque;
    lblFatVendaRequisicao1.Visible := True;
    lblFatVendaRequisicao2.Visible := True;
    cdsConsulta.Filtered := False;
  End;

  If blnCfgReqAut Then
  Begin
    blnFecharFormPai := True;
    blnConfirma := True;
    Exit;
  End;

  blnFecharFormPai := (cdsConsulta.IsEmpty) And blnVaiGravarComFaturamento;

  blnShowModalConsulta := False;

  If cdsConsulta.IsEmpty Then
    blnConfirma := True;

  If blnFecharFormPai Then
    Exit;

  If fValidarDirEspecificos(strDireitos, strCodUsu, Self.Name) Then
  Begin
    blnPodeAlterar := (Pos('A', strDireitos) > 0);
    blnPodeIncluir := (Pos('I', strDireitos) > 0);
    blnPodeExcluir := (Pos('E', strDireitos) > 0);

    {* INCLUSÃO *}
    lblIncluir.Enabled     := blnPodeIncluir;

    {* ALTERAÇÃO *}
    pnlDadosItens.Enabled  := blnPodeAlterar Or
                              blnPodeIncluir;

    edtCodCli.ReadOnly     := Not (blnPodeAlterar Or
                                   blnPodeIncluir);

    edtSenVen.ReadOnly     := Not (blnPodeAlterar Or
                                   blnPodeIncluir);
    {* EXCLUIR *}
    btnExcVen.Enabled      := blnPodeExcluir;

    btnGravar.Enabled      := blnPodeAlterar Or
                              blnPodeIncluir;
  End Else
  Begin
    blnPodeAlterar := True;
    blnPodeIncluir := True;
    blnPodeExcluir := True;
  End;

  edtEmpIte.Visible := fCfgSis('EMPFAT', varBoolean);
  lblEmpIte.Visible := fCfgSis('EMPFAT', varBoolean);
  dbgConsulta.Columns[2].Visible := fCfgSis('EMPFAT', varBoolean);

  edtSenDig.Visible := fCfgSis('SOLDIG', varString) = 'S';

  If Not (edtSenDig.Visible) Then
  Begin
    lblDigita.Visible := False;
    Panel1.Height     := Panel1.Height - edtSenDig.Height;
    pnlHeader.Height  := pnlHeader.Height - edtSenDig.Height;
  End;

  if Not blnLimparTela then
    if Not fEmptyStr(edtCodigo.Text) then
      fValidaCampos(edtCodigo, True);

  btnEstLoj.Visible := VS_blnTemFil;

  pConfigurarColunas;
end;

function TfrmFatRequisicaoCompras.fGetSql(blnLike: Boolean): String;
Begin
  Result := '';
  Result := Result + 'SELECT                                               ';
  Result := Result + '  SQL_NO_CACHE RCD_CODITE,                           ';
  Result := Result + '  IF(                                                ';
  Result := Result + '    LOCATE("ITEM ESPECIAL", ITE_DESITE),             ';
  Result := Result + '    RCD_DESITE,                                      ';
  if blnRefPed then
    Result := Result + '    CAST(CONCAT(ITE_DESITE," ",IFNULL(ITE_REFERE, "")) AS CHAR(90)) '
  else
    Result := Result + '    ITE_DESITE                                     ';
  Result := Result + '  ) AS RCD_DESITE,                                   ';
  Result := Result + '  RCD_QTDITE,                                        ';
  Result := Result + '  @QTDBAI := (SELECT COALESCE(SUM(BAI_QTDREQ), 0)    ';
  Result := Result + '    FROM BAIREQ WHERE BAI_AUTREQ = M.AUTOINCREM)     ';
  Result := Result + '  AS QTDBAI,                                         ';
  Result := Result + '  RCD_QTDITE - @QTDBAI AS QTDPEN,                    ';
  Result := Result + '  COALESCE(RCD_SEQCOT, "") AS RCD_SEQCOT,            ';
  Result := Result + '  COALESCE(RCD_SEQPCD, "") AS RCD_SEQPCD,            ';
  Result := Result + '  RCD_OBSERV,                                        ';
  Result := Result + '  RCD_DOCPDV,                                        ';
  Result := Result + '  RCD_ESPPDV,                                        ';
  Result := Result + '  RCD_EMPPDV,                                        ';
  Result := Result + '  M.AUTOINCREM,                                      ';
  Result := Result + '  RCD_CODEMP AS RCD_EMPITE,                          ';
  Result := Result + '  ITE_ATICOM AS RCD_ATICOM,                          ';
  Result := Result + '  (SELECT GROUP_CONCAT(CONCAT(D.DET_ESPDOC, "-", D.DET_NUMDOC, "-", D.DET_CODEMP)) FROM BAIREQ         ';
  Result := Result + '    INNER JOIN MOVDET D ON D.AUTOINCREM = BAI_AUTDET WHERE BAI_AUTREQ = M.AUTOINCREM) AS NOTAS,   ';
  Result := Result + '  RCD_DTPREV,                                        ';
  Result := Result + '  ITE_CODFAB,                                        ';
  Result := Result + '  ITE_CODMAR                                         ';
  Result := Result + 'FROM                                                 ';
  Result := Result + '  MOVRCD M                                           ';
  Result := Result + 'INNER JOIN CADITE                                    ';
  Result := Result + '  ON ITE_CODITE = RCD_CODITE                         ';
  Result := Result + 'WHERE RCD_CODEMP = :CODEMP                           ';
  Result := Result + '  AND RCD_CODIGO = :CODIGO                           ';
End;

function TfrmFatRequisicaoCompras.fPermiteApagarRequisicao(): Boolean;
begin
  Result := (Not fTemPedidoDeCompraVinculado()) And (Not fTemCotacaoVinculada(strCodigo));
end;

function TfrmFatRequisicaoCompras.fPesquisarDescricaoItemEspecialNoPedido: Boolean;
begin
  Result := False;

  if blnConfirmando then
    Exit;

  if Not fEhItemEspecial(edtCodIte.Text) then
    Exit;

  if fEmptyStr(edtCodCli.Text) then
    Exit;

  if fEmptyStr(edtCodIte.Text) then
    Exit;

  if fEmptyStr(edtDocPdv.Text) then
    Exit;

  if fEmptyStr(edtEspPdv.Text) then
    Exit;

  if fEmptyStr(edtEmpPdv.Text) then
    Exit;

  Result := True;

end;

function TfrmFatRequisicaoCompras.fSetParametros: Boolean;
Begin
  With qryConsulta Do
  Begin
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    if Not fEmptyStr(strCodEmp) then
      ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODIGO').AsString := strCodigo;
  End;
  Result := True;
End;

function TfrmFatRequisicaoCompras.fSolicitaLiberacao: Boolean;
  Var
    objLiberacao: TLiberacao;
begin
  objLiberacao := TLiberacao.Create;

  Try
    Try
      objLiberacao.strDirAce  := 'PERMITEREQCOM';
      objLiberacao.strMsgSen  := 'Solicitação de Requisição de Compra';
      objLiberacao.strCodOpe  := strCodVen;
      objLiberacao.strCodDig  := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('SOLICITAÇÃO DE REQUISIÇÃO DE COMPRA', alCentro);
      objLiberacao.objMsgLibera.pAddSeparador;
      objLiberacao.objMsgLibera.pAddTexto('Cliente        : ' + edtCodCli.Text +'-'+ edtNomCli.Text);
      objLiberacao.objMsgLibera.pAddTexto('CPF/CNPJ       : ' + fFormataCpfCgc(fRetCgcCpf(edtCodCli.Text), fSetaPais));

      If Not fEmptyStr(strCodCnd) Then
      Begin
        objLiberacao.objMsgLibera.pAddTexto('Cond.Pagamento : ' + strCodCnd + '-' + fRetDesConPag(strCodCnd));
        objLiberacao.objMsgLibera.pAddTexto('                 ' + fFormataCondPag(fRetConPag(strCodCnd)));
      End;

      If Not fEmptyStr(strCodFpg) Then
        objLiberacao.objMsgLibera.pAddTexto('Forma Pagamento: ' + strCodFpg + '-' + fRetDescFpg(strCodFpg));

      objLiberacao.objMsgLibera.pAddTexto('Vendedor       : ' + strCodVen +'-'+ fRetNomVendRep(strCodVen));
      objLiberacao.objMsgLibera.pAddSeparador;

      If (Self.cdsVenda <> nil) And Self.cdsVenda.Active Then
      Begin
        If fCfgSis('PRVEST',varBoolean) Then
           objLiberacao.objMsgLibera.pAddTexto('Código | Descrição                                | UN |   Quantidade |     Pr.Unit. |      Pr.Total | Previsão Estoque |Observação')
        Else
           objLiberacao.objMsgLibera.pAddTexto('Código | Descrição                                | UN |   Quantidade |     Pr.Unit. |      Pr.Total | Observação')
      End
      Else
      Begin
        If fCfgSis('PRVEST',varBoolean) Then
           objLiberacao.objMsgLibera.pAddTexto('Código | Descrição                                |    Quantidade | Previsão Estoque |Observação')
        Else
           objLiberacao.objMsgLibera.pAddTexto('Código | Descrição                                |    Quantidade | Observação');
      End;

      objLiberacao.objMsgLibera.pAddSeparador;

      cdsConsulta.First;
      While Not cdsConsulta.Eof Do
      Begin
        If (Self.cdsVenda <> nil) And Self.cdsVenda.Active Then
        Begin
          //locate para buscar a unidade e o preço unitário
          Self.cdsVenda.Locate('ITE_CODITE', cdsConsulta.FieldByName('RCD_CODITE').AsString, []);

          If fCfgSis('PRVEST',varBoolean) Then
            objLiberacao.objMsgLibera.pAddTexto(fPadR(cdsConsulta.FieldByName('RCD_CODITE').AsString, 7) +'| '+
                                              fPadR(cdsConsulta.FieldByName('RCD_DESITE').AsString, 41) +'| '+
                                              Self.cdsVenda.FieldByName('ITE_SIGUNI').AsString +' |'+
                                              fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsConsulta.FieldByName('RCD_QTDITE').AsFloat), 14) +'|'+
                                              fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), Self.cdsVenda.FieldByName('ITE_UNITAR').AsFloat), 14) +'|'+
                                              fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), cdsConsulta.FieldByName('RCD_QTDITE').AsFloat *
                                                                                                            Self.cdsVenda.FieldByName('ITE_UNITAR').AsFloat), 14) +' | '+
                                              fPadL(cdsConsulta.FieldByName('RCD_DTPREV').AsString,15)+' | '+
                                              fPadR(cdsConsulta.FieldByName('RCD_OBSERV').AsString, 255) +' ')
          Else
            objLiberacao.objMsgLibera.pAddTexto(fPadR(cdsConsulta.FieldByName('RCD_CODITE').AsString, 7) +'| '+
                                              fPadR(cdsConsulta.FieldByName('RCD_DESITE').AsString, 41) +'| '+
                                              Self.cdsVenda.FieldByName('ITE_SIGUNI').AsString +' |'+
                                              fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsConsulta.FieldByName('RCD_QTDITE').AsFloat), 14) +'|'+
                                              fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), Self.cdsVenda.FieldByName('ITE_UNITAR').AsFloat), 14) +'|'+
                                              fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), cdsConsulta.FieldByName('RCD_QTDITE').AsFloat *
                                                                                                            Self.cdsVenda.FieldByName('ITE_UNITAR').AsFloat), 14) +' | '+
                                              fPadR(cdsConsulta.FieldByName('RCD_OBSERV').AsString, 255) +' ');

        End
        Else
        Begin
          If fCfgSis('PRVEST',varBoolean) Then
            objLiberacao.objMsgLibera.pAddTexto(fPadR(cdsConsulta.FieldByName('RCD_CODITE').AsString, 7) +'| '+
                                              fPadR(cdsConsulta.FieldByName('RCD_DESITE').AsString, 41) +'|'+
                                              fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsConsulta.FieldByName('RCD_QTDITE').AsFloat), 14) +' | '+
                                              fPadL(cdsConsulta.FieldByName('RCD_DTPREV').AsString,15)+' | '+
                                              fPadR(cdsConsulta.FieldByName('RCD_OBSERV').AsString, 255) +' ')
          Else
            objLiberacao.objMsgLibera.pAddTexto(fPadR(cdsConsulta.FieldByName('RCD_CODITE').AsString, 7) +'| '+
                                              fPadR(cdsConsulta.FieldByName('RCD_DESITE').AsString, 41) +'|'+
                                              fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsConsulta.FieldByName('RCD_QTDITE').AsFloat), 14) +' | '+
                                              fPadR(cdsConsulta.FieldByName('RCD_OBSERV').AsString, 255) +' ');
        End;

        cdsConsulta.Next;
      End;

      objLiberacao.objMsgLibera.pAddSeparador;

      Result := objLiberacao.fLibera;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fSolicitaLiberacao]');
      End;
    End;

  Finally
    FreeAndNil(objLiberacao);
  End;
end;

function TfrmFatRequisicaoCompras.fSolicitarSenhaVendedor: Boolean;
begin
  Result := Self.blnSolicitarSenhaVendedor;
end;

procedure TfrmFatRequisicaoCompras.pLimpaTela;
Begin
  FillChar(regConsum, SizeOf(regConsum), #0);

  strCodigo := '';
  strCliAnt := '';

  edtCodigo.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtSenVen.Clear;
  edtNomVen.Clear;
  edtSenDig.Clear;
  edtNomDig.Clear;
  lblDtaCad.Caption  := FormatDateTime('dd/mm/yyyy', VS_Date);
  lblDtaUlt.Caption  := FormatDateTime('dd/mm/yyyy', VS_Date);
  edtCodigo.Enabled  := True;
  edtCodigo.TabStop  := True;

  pLimpaItem;
End;

class procedure TfrmFatRequisicaoCompras.pExibeRequisicaoCompra(strCodigo: String; strCodEmp: String);
begin
  TfrmFatRequisicaoCompras.pExibeRequisicao(strCodigo, strCodEmp)
end;

procedure TfrmFatRequisicaoCompras.pCarregaCabec;
Begin
  With qryMovRcg Do
  Begin

    edtCodigo.Text    := FieldByName('RCG_CODIGO').AsString;
    edtCodCli.Text    := FieldByName('RCG_CODCLI').AsString;
    edtNomCli.Text    := fRetNomCliente(FieldByName('RCG_CODCLI').AsString);
    lblDtaCad.Caption := FormatDateTime('dd/mm/yyyy', FieldByName('RCG_DTACAD').AsDateTime);
    lblDtaUlt.Caption := FormatDateTime('dd/mm/yyyy', FieldByName('RCG_DTAALT').AsDateTime);

    If (fCfgSis('SOLDIG', varString) = 'S') Then
    Begin
      edtSenDig.Clear;
      edtNomDig.Clear;

      edtSenVen.Text     := FieldByName('RCG_CODVEN').AsString;
      edtNomVen.Text     := fRetNomVendRep(FieldByName('RCG_CODVEN').AsString);
    End
    Else
    Begin
      edtSenVen.Clear;
      edtNomVen.Clear;
    End;

    edtCodigo.Enabled  := False;
    edtCodigo.TabStop  := False;

    strCodigo := FieldByName('RCG_CODIGO').AsString;

    With regConsum Do
    Begin


      If (Not fEmptyStr(FieldByName('CON_C_P_F_').AsString)) Then
      Begin
        strCliNom := FieldByName('CON_NOMCON').AsString;
        strCliEnd := FieldByName('CON_ENDERE').AsString;
        strCliBai := FieldByName('CON_BAIRRO').AsString;
        strCliCep := FieldByName('CON_C_E_P_').AsString;
        strCodCid := FieldByName('CON_CODCID').AsString;
        strCliCid := fRetNomCidade(strCodCid);
        strCliEst := fRetNomCidade(strCodCid, 1);
        strCliTel := FieldByName('CON_FONE01').AsString;
        intCgcCpf := FieldByName('CON_CGCCPF').AsInteger;
        strCliCgc := FieldByName('CON_C_P_F_').AsString;
        strCliIes := FieldByName('CON_I_E_S_').AsString;
        strCli_Rg := FieldByName('CON_NUMR_G').AsString;

        edtNomCli.Text := strCliNom;
      End

      Else If fClienteConsumidor(edtNomCli.Text, False, True) Then
             pCarregaDadosConsumidor(edtCodCli.Text);

    End;

    If fAbreConsulta Then
      pSetFocus(edtSenVen);

  End;
End;

function TfrmFatRequisicaoCompras.fCarregaRequisicaoCompra(strCodigo: String): Boolean;
  Var
    strSQL: String;
Begin
  if fEmptyStr(strCodEmp) then
    strCodEmp := VS_strCodEmp;

  strSQL := '';
  strSQL := strSQL + ' SELECT  SQL_NO_CACHE ';
  strSQL := strSQL + '   RCG_CODIGO, ';
  strSQL := strSQL + '   RCG_DTAALT, ';
  strSQL := strSQL + '   RCG_DTACAD, ';
  strSQL := strSQL + '   RCG_CODVEN, ';
  strSQL := strSQL + '   RCG_CODCLI, ';
  strSQL := strSQL + '   RCG_CODCON, ';
  strSQL := strSQL + '   RCG_CODDIG, ';
  strSQL := strSQL + '   C.*         ';
  strSQL := strSQL + ' FROM   ';
  strSQL := strSQL + '   MOVRCG  ';
  strSQL := strSQL + ' LEFT JOIN CLICON C ON CON_C_P_F_ = RCG_CPFCON ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   RCG_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   RCG_CODIGO = :CODIGO     ';

  With qryMovRcg, SQL Do
  Begin
    Close;

    Clear;

    Add(strSQL);

    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODIGO').AsString := strCodigo;

    Open;

    Result := Not IsEmpty;

    If IsEmpty Then
    Begin
      pIniciaVenda;
    End Else
    Begin
      pCarregaCabec;
    End;

    pHabilitaCampos(IsEmpty);

    btnExcVen.Visible := (Not IsEmpty) And blnPodeExcluir;
  End;
End;

function TfrmFatRequisicaoCompras.fCarregarItemEspecialRotinaReqCompras(strCodIte: String): Boolean;
begin
  Result := False;

  If Not fCfgSis('SLRQPV', VarBoolean) Then
    Exit;

  If Not fCfgSis('CIERCE', VarBoolean) Then
    Exit;

  If Not fEhItemEspecial(strCodIte) Then
    Exit;

  Result := True;
end;

Procedure TfrmFatRequisicaoCompras.pHabilitaCampos(blnInclusao: Boolean);
Begin
  If blnInclusao Then
  Begin
    edtCodCli.ReadOnly    := Not blnPodeIncluir;
    edtSenVen.ReadOnly    := Not blnPodeIncluir;

    pnlDadosItens.Enabled := blnPodeIncluir;
    btnGravar.Enabled     := blnPodeIncluir;
  End Else
  Begin
    edtCodCli.ReadOnly    := Not blnPodeAlterar;

    If not (edtSenDig.Visible) Then
      edtSenVen.ReadOnly    := Not blnPodeAlterar
    Else
      edtSenVen.ReadOnly    := True;

    pnlDadosItens.Enabled := blnPodeAlterar;
    btnGravar.Enabled     := blnPodeAlterar;
  End;
End;

function TfrmFatRequisicaoCompras.fHabilitaDigitaVendedor;
begin
  Result := True;

  If (edtSenDig.Visible) Then
    Result := False;
end;

procedure TfrmFatRequisicaoCompras.pCarregaDadosConsumidor(strCodCli: String);
  Var
    qryCadCli: TUniQuery;
Begin
  qryCadCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCli.Text);
  With regConsum, qryCadCli Do
  Begin
    strCliEnd := FieldByName('CLI_ENDERE').AsString + ', ' +
                          FieldByName('CLI_ENDNUM').AsString + '  ' +  //         - Endereco
                          FieldByName('CLI_ENDCOM').AsString;

    strCliBai := FieldByName('CLI_BAIRRO').AsString;                   //         - Bairro
    strCliCep := FieldByName('CLI_C_E_P_').AsString;                   //         - Cep
    strCodCid := FieldByName('CLI_CODCID').AsString;                   //         - Cód. Cidade
    strCliTel := FieldByName('CLI_FONE01').AsString;                   //         - Telefone
    strCliCid := fRetNomCidade(strCodCid);                             // - Cidade
    strCliEst := fRetNomCidade(strCodCid, 1);                          // - Estado

    strCliNom := FieldByName('CLI_NOMCLI').AsString;                   //         - Nome
    strCliCgc := FieldByName('CLI_C_G_C_').AsString;                   //         - CNPJ
    strCliIes := FieldByName('CLI_I_E_S_').AsString;                   //         - Ins.Estadual
    strCli_Rg := FieldByName('CLI_NUMR_G').AsString;                   //         - RG

    If fEmptyStr(FieldByName('CLI_CGCCPF').AsString) Then
      intCgcCpf := 0
    Else
      intCgcCpf := FieldByName('CLI_CGCCPF').AsInteger;                //         - CGC/CPF
  End;
  FreeAndNil(qryCadCli);
End;

function TfrmFatRequisicaoCompras.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    strCliOri: String;

Begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    blnMudarFoco := True;

    If (Sender = edtCodigo) Then
    Begin

      If (edtCodigo.Enabled) Then
      Begin
        If fEmptyStr(edtCodigo.Text) Then
          btnExcVen.Enabled := False;

        If (Not SameText(edtCodigo.Text, strCodigo)) And
           (Not blnVaiGravarComFaturamento) And
           fCarregaRequisicaoCompra(edtCodigo.Text) Then
        Begin
          blnMudarFoco := False;
        End

        Else If Not fEmptyStr(edtCodigo.Text) Then
        Begin
          pMensagemOk('Sequencial não encontrado!');
          Result := False;
        End

        Else blnMudarFoco := True;

      End;

      pHabilitaCampos(fEmptyStr(edtCodigo.Text));

      If Result And (Not blnPodeIncluir) And fEmptyStr(edtCodigo.Text) Then
      Begin
        pMensagemOk('Informe o código da requisição. Usuário sem permissão para inclusão!');
        Result := False;
      End;

    End

    Else If Sender = edtCodCli Then
    Begin

      If fEmptyStr(edtCodCli.Text) Then
      Begin
        pMensagemOk('O Cliente deve ser preenchido!');
        Result := False;
      End Else
      Begin
        strCliOri := fRetNomCliente(edtCodCli.Text);

        If Not SameText(strCliAnt, edtCodCli.Text) Then
          edtNomCli.Text := strCliOri;

        If fEmptyStr(edtNomCli.Text) Then
        Begin
          pMensagemOk('Cliente não encontrado!');
          Result := False;
        End

        Else If blnBuscaPorChave Then
        Begin
          If fClienteConsumidor(strCliOri, False, True) Then
          Begin
            If Not SameText(strCliAnt, edtCodCli.Text) Then
              pCarregaDadosConsumidor(edtCodCli.Text);
            fDigDadosConsumidor;
          End;
        End;

        If Result Then
          strCliAnt := edtCodCli.Text;

      End

    End

    Else If Sender = edtSenVen Then
    Begin

      If fEmptyStr(edtSenVen.Text) Then
      Begin
        strCodVen := '';
        pMensagemOk('O vendedor deve ser preenchido!');
        Result := False;
      End
      Else
      Begin
        if blnSolicitarSenhaVendedor then
          strCodVen := fRetCodVendedor(edtSenVen.Text)
        else
          strCodVen := edtSenVen.Text;

        edtNomVen.Text := fRetNomVendRep(strCodVen);

        If fEmptyStr(edtNomVen.Text) Then
        Begin
          pMensagemOk('Vendedor não encontrado!');
          Result := False;
        End;

      End;

    End

    Else If Sender = edtCodIte Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
        If (blnBuscaPorChave) Then
        Begin
          pSetFocus(dbgConsulta);
          blnMudarFoco := False;
        End
        Else
        Begin
          pMensagemOk('O Item deve ser informado!');
          Result := False;
        End;
      End

      Else
      With qryCadIte Do
      Begin

        pCarregaItem(edtCodIte.Text);

        If IsEmpty Then
        Begin
          pMensagemOk('Item não encontrado!');
          Result := False;
        End

        Else If Not SameText(FieldByName('ITE_ITEATI').AsString, 'S') Then
        Begin
          pMensagemOk('Item inativo!');
          Result := False;
        End

        Else If Not SameText(FieldByName('ITE_ATICOM').AsString, 'S') Then
        Begin
          pMensagemOk('Item não está ativo para compras!');
          Result := False;
        End

        Else
        Begin

           If (strIteAnt <> FieldByName('ITE_CODITE').AsString) Or fEmptyStr(edtDesIte.Text) Then
           begin
             edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
             edtPrevisaoEstoque.Text := DateToStr(IncDay(Date, FieldByName('ITE_DIAFOR').AsInteger));
           end;

           strIteAnt := FieldByName('ITE_CODITE').AsString;

        End;

        if Result and fPesquisarDescricaoItemEspecialNoPedido then
          Result := fObterDescricaoItemPedido;

      End;

    End

    Else If Sender = edtDesIte Then
    Begin

      If Not edtDesIte.ReadOnly Then
      Begin

        If fEmptyStr(edtDesIte.Text) Then
        Begin
          pMensagemOk('A descrição do item deve ser preenchida!');
          Result := False;
        End;

      End;

    End

    Else If Sender = edtQtdIte Then
    Begin

      If fStrToFloat(edtQtdIte.Text) <= 0 Then
      Begin
        pMensagemOk('A quantidade deve ser maior que zero!');
        Result := False;
      End;

      If Result And
         (Not cdsConsulta.IsEmpty) And
         (cdsConsulta.FieldByName('RCD_CODITE').AsString = edtCodIte.Text) And
         (cdsConsulta.FieldByName('QTDBAI').AsFloat > 0) And
         (cdsConsulta.FieldByName('QTDBAI').AsFloat > fStrToFloat(edtQtdIte.Text)) Then
       Begin
         pMensagemOk('A quantidade não pode ser menor que a quantidade já baixada!');
         Result := False;
       End;

    End

    Else If (Sender = edtDocPdv) Then
    Begin
      If fEmptyStr(edtDocPdv.Text) Then
      Begin
        edtEmpPdv.Enabled := False;
        edtEspPdv.Text := '';
        edtEmpPdv.Text := '';
      End
      Else
      Begin
        edtEmpPdv.Enabled := True;
        edtEspPdv.Text := 'PD';

        If fEmptyStr(edtEmpPdv.Text) Then
        Begin
          edtEmpPdv.Text := VS_strCodEmp;
          If Not fEmptyStr(strCodEmp) Then
            edtEmpPdv.Text := strCodEmp;
        End;

        pCarregaOrdemServico;
      End;
    End

    Else If (Sender = edtEmpPdv) And (edtEmpPdv.Enabled) Then
    Begin
      If (fEmptyStr(edtDocPdv.Text)) Then
      Begin
        pMensagemOk('O Documento do Pedido de Venda deve ser preenchido!');
        Result := False;
      End
      Else If (fEmptyStr(edtEmpPdv.Text)) Then
      Begin
        pMensagemOk('A Empresa do Pedido de Venda deve ser preenchida!');
        Result := False;
      End
      Else If (fCampoTabela('COUNT(*)', 'FATGOR', ['FGO_NUMDOC',   'FGO_ESPDOC',   'FGO_CODEMP'],
                                                  [edtDocPdv.Text, edtEspPdv.Text, edtEmpPdv.Text]) = 0) Then
      Begin
        pMensagemOk('Pedido de Venda não foi encontrado!');
        Result := False;
      End;

      If (Result) And (fEmptyStr(edtEmpIte.Text)) Then
        edtEmpIte.Text := edtEmpPdv.Text;

      if Result and fPesquisarDescricaoItemEspecialNoPedido then
        Result := fObterDescricaoItemPedido;

      pCarregaOrdemServico;
    End

    Else If (Sender = edtSenDig) And (edtSenDig.Visible) Then
    Begin

      If fEmptyStr(edtSenDig.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Digitador deve ser preeenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        strCodDig      := fRetCodVendedor(edtSenDig.Text);

        edtNomDig.Text := fRetNomVendRep(strCodDig);

        If fEmptyStr(edtNomDig.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&O k']);
          Result := False;
        End;

      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

End;

function TfrmFatRequisicaoCompras.fQuantidadeDeItemEhMaiorQueQuantidadeDigitada(var fltQtdeItem: Double): Boolean;
begin
  Result := False;
  if Self.cdsVenda.Locate('ITE_CODITE;ITE_EMPITE', VarArrayOf([edtCodIte.Text, edtEmpIte.Text]), []) then
  begin
    fltQtdeItem := 0;
    while not Self.cdsVenda.Eof do
    begin
      if (Self.cdsVenda.FieldByName('ITE_CODITE').AsString = edtCodIte.Text)
         and (Self.cdsVenda.FieldByName('ITE_EMPITE').AsString = edtEmpIte.Text) then
        fltQtdeItem := fltQtdeItem + Self.cdsVenda.FieldByName('ITE_QTDITE').AsFloat;

      Self.cdsVenda.Next;
    end;

    if (fStrToFloat(edtQtdIte.Text) > fltQtdeItem) then
      Result := True;
  end;

end;

function TfrmFatRequisicaoCompras.fQuantidadeDeItemEhMenorQueQuantidadeDigitada(var fltQtdeItem: Double): Boolean;
var
  prcScroll: TprcScroll;
begin
  pDisableControls(cdsConsulta, prcScroll);

  try
    Result := False;
    if cdsConsulta.Locate('RCD_CODITE;RCD_EMPITE', VarArrayOf([edtCodIte.Text, edtEmpIte.Text]), []) then
    begin
      fltQtdeItem := 0;
      cdsConsulta.First;
      while not cdsConsulta.Eof do
      begin
        if (cdsConsulta.FieldByName('RCD_CODITE').AsString = edtCodIte.Text)
           and (cdsConsulta.FieldByName('RCD_EMPITE').AsString = edtEmpIte.Text) then
          fltQtdeItem := fltQtdeItem + cdsConsulta.FieldByName('RCD_QTDITE').AsFloat;

        cdsConsulta.Next;
      end;

      If (fFormataFloat(fStrToFloat(edtQtdIte.Text), fCfgSis('DECQTD', varInteger)) <
          fFormataFloat(fltQtdeItem, fCfgSis('DECQTD', varInteger))
         ) Then
        Result := True;
    end;
  finally
    pEnableControls(cdsConsulta, prcScroll);
  end;
end;

procedure TfrmFatRequisicaoCompras.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
    objfrmPnl  : TPanelCxClientes;
begin
  inherited;

  If edtCodCli.ReadOnly Then
    Exit;

  objfrmPnl := TPanelCxClientes.Create(TfrmPnlDadosCliente);

  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliEmpresaIdent, Self, edtCodCli, edtNomCli, qryTabela, Key, arrClientes, True, objfrmPnl) And (Not edtCodCli.ReadOnly) Then
  Begin
    If (fValidaCampos(edtCodCli, True)) and (blnMudarFoco) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(objfrmPnl);
end;

procedure TfrmFatRequisicaoCompras.pTravaItemFracionadoKey(Sender: TObject; var Key: Char);
Begin

  If CharInSet(Key, [',','.','-']) Then
    Key := #0;

End;

procedure TfrmFatRequisicaoCompras.pTravaItensRequisicao;
var
  blnContinue: Boolean;
begin
  blnContinue := True;
  cdsConsulta.First;

  While (Not cdsConsulta.Eof) Do
  Begin
    If Not (objLock.fLock_Unlock('REQUISICAO_' + cdsConsulta.FieldByName('AUTOINCREM').AsString, True, False)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Há item(ns) dessa requisição sendo utilizado(s) por outra estação: ' +
                fGetHostLock('REQUISICAO_' + cdsConsulta.FieldByName('AUTOINCREM').AsString), ['&Ok']);
      blnContinue := False;
      Break;
    End;

    cdsConsulta.Next;
  End;

  cdsConsulta.First;

  If (Not blnContinue) Then
    pIniciaVenda();
end;

function TfrmFatRequisicaoCompras.fAbreConsulta(blnLike: Boolean = True): Boolean;
Begin
  Result := inherited fAbreConsulta;
  cdsConsulta.Tag := 1;
  pTravaItensRequisicao();
End;

procedure TfrmFatRequisicaoCompras.pCarregaItem(strCodIte: String);
Begin
  With qryCadIte, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT ');
    Add('  ITE_CODITE, ');
    Add('  ITE_DESITE, ');
    Add('  ITE_CODUNI, ');
    Add('  ITE_ITEATI, ');
    Add('  ITE_ATICOM, ');
    Add('  ITE_DIAFOR,  ');
    Add('  ITE_CODFAB,  ');
    Add('  ITE_CODMAR  ');
    Add('FROM CADITE');
    Add('WHERE ITE_CODITE = :CODITE');

    ParamByName('CODITE').AsString := strCodIte;

    Open;
    edtAtiCom.Clear;
    If Not IsEmpty Then
    Begin
      If Not fItemFracionado(FieldByName('ITE_CODUNI').AsString) Then
        edtQtdIte.OnKeyPress := pTravaItemFracionadoKey
      Else
        edtQtdIte.OnKeyPress := Nil;

      edtDesIte.ReadOnly := Pos('ITEM ESPECIAL', FieldByName('ITE_DESITE').AsString) = 0;
      edtDesIte.TabStop  := Not edtDesIte.ReadOnly;

      edtAtiCom.Text := FieldByName('ITE_ATICOM').AsString;
    End;

  End;
End;

procedure TfrmFatRequisicaoCompras.pCarregaOrdemServico;
var
  strSQL: String;
  qryConEqu: TUniQuery;
begin
  qryConEqu := fCriaQuery;

  try
    strSQL := '';
    strSQL := strSQL + 'SELECT EQU_NUMOSE, EQU_CODEMP ';
    strSQL := strSQL + 'FROM EQUGER ';
    strSQL := strSQL + 'WHERE EQU_NUMPED = :NUMDOC ';
    strSQL := strSQL + '  AND EQU_TIPPED = :ESPDOC ';
    strSQL := strSQL + '  AND EQU_EMPPED = :EMPDOC ';
    strSQL := strSQL + 'UNION ';
    strSQL := strSQL + 'SELECT EQU_NUMOSE, EQU_CODEMP ';
    strSQL := strSQL + 'FROM EQUGER ';
    strSQL := strSQL + 'INNER JOIN EQUGOR ON EQUGER.AUTOINCREM = FGO_SEQEQU ';
    strSQL := strSQL + 'INNER JOIN FATGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ';
    strSQL := strSQL + 'WHERE FGO_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '  AND FGO_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '  AND FGO_CODEMP = :EMPDOC ';

    qryConEqu.SQL.Text := strSQL;
    qryConEqu.ParamByName('NUMDOC').AsString := edtDocPdv.Text;
    qryConEqu.ParamByName('ESPDOC').AsString := edtEspPdv.Text;
    qryConEqu.ParamByName('EMPDOC').AsString := edtEmpPdv.Text;
    qryConEqu.Open;

    if (not qryConEqu.IsEmpty) then
    begin
      edtNumOSe.Text := qryConEqu.FieldByName('EQU_NUMOSE').AsString;
      edtEmpOSe.Text := qryConEqu.FieldByName('EQU_CODEMP').AsString;
    end;
  finally
    FreeAndNil(qryConEqu);
  end;
end;

procedure TfrmFatRequisicaoCompras.btnAdicionarClick(Sender: TObject);
begin
  blnConfirmando := True;
  Try
    If fVerificaCampos Then
      pGravaItem;
  Finally
    if blnConfirmando then
      blnConfirmando := False;
  End;
end;

procedure TfrmFatRequisicaoCompras.pExcluiItem;
Var
  objLiberacao: TLiberacao;
Begin
  With cdsConsulta Do
  Begin
    If IsEmpty Then
      Exit;

    If Not fEmptyStr(FieldByName('RCD_SEQPCD').AsString) Then
    Begin
      pMensagemOk('Este item não pode ser excluído pois está vinculado a um pedido de compra!');
      Exit;
    End;

    If Not fEmptyStr(FieldByName('RCD_SEQCOT').AsString) Then
    Begin
      pMensagemOk('Este item não pode ser excluído pois está vinculado a uma cotação!');
      Exit;
    End;


    If (cdsVenda = nil) or (fCfgSis('RCPEPS', varBoolean)) Then
    Begin
      If fPergunta('Deseja excluir o item?') Then
      begin
        objLiberacao := TLiberacao.Create;

        Try
          Try
            objLiberacao.strDirAce  := 'PERMITEEXCPRODREQCOM';
            objLiberacao.strMsgSen  := 'Permitir excluir produtos na requisição de compra';
            objLiberacao.strCodOpe  := strCodVen;
            objLiberacao.strCodDig  := strLoginUsuarioLogado;
            objLiberacao.objMsgLibera.pAddTexto('Permitir excluir produtos na requisição de compra');
            objLiberacao.objMsgLibera.pAddTexto('Produto   : ' + cdsConsulta.FieldByName('RCD_CODITE').AsString + ' - '+ cdsConsulta.FieldByName('RCD_DESITE').AsString);
            objLiberacao.objMsgLibera.pAddTexto('Quantidade: ' + FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsConsulta.FieldByName('RCD_QTDITE').AsFloat));

            if objLiberacao.fLibera then
              Delete;

          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '[pExcluiItem]');
            End;
          End;

        Finally
          FreeAndNil(objLiberacao);
        End;
      end;
    End
    Else
    Begin
      pMensagemOk('Este Item não pode ser excluído!');
      Exit;
    End;

    pLimpaItem;
  End;
End;

procedure TfrmFatRequisicaoCompras.btnEstLojClick(Sender: TObject);
begin
  inherited;


  If VS_blnTemFil Then
  Begin
    if (not fVerificaAcessoSistema('PVISPF')) then
    begin
      fMensagem('ATENÇÃO','Operador não possui acesso para visualizar informações de saldo de produtos no faturamento.',['&OK']);
      Exit;
    end;

    If Not fVerificaAcessoSistema('CPELOJ', strLoginUsuarioLogado) Then
      fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
    Else
      pMostraEstoqueLojas;
  End;

end;

procedure TfrmFatRequisicaoCompras.btnExcluirClick(Sender: TObject);
begin
  inherited;

  pExcluiItem;

end;

procedure TfrmFatRequisicaoCompras.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
Var
  strTexto: String;
begin
  inherited;

  If cdsConsulta.FieldByName('RCD_SEQCOT').AsString <> '' Then
    dbgConsulta.Canvas.Font.Color := clGreen;

  If cdsConsulta.FieldByName('RCD_SEQPCD').AsString <> '' Then
    dbgConsulta.Canvas.Font.Color := clBlue;

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if fEmptyStr(edtCodigo.Text) then
  Begin
    If (Column.FieldName = 'RCD_DESITE') Then
    Begin
       if blnRefPed then
       Begin
         strTexto := Column.Field.DataSet.FieldByName('RCD_DESITE').AsString+' '+
                     fRetReferenciaProd(Column.Field.DataSet.FieldByName('RCD_CODITE').AsString);
         With dbgConsulta.Canvas, Rect Do
         Begin
           FillRect(Rect);
           dbgConsulta.Canvas.TextOut(Rect.Left + 3, Rect.Top + 1, strTexto);
         End;
       End;
    End;
  End;

end;

procedure TfrmFatRequisicaoCompras.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: pEditaItem;
    VK_DELETE: pExcluiItem;
    VK_F4: btnCopiarPdv.Click;
    VK_F6: btnEstLoj.Click;
  End;

end;

procedure TfrmFatRequisicaoCompras.pIniciaVenda(blnLimpaTela: Boolean = True);
Begin
  If (blnLimpaTela) then
    pLimpaTela;

  objLock.pDestravarTodos;

  btnCopiarPdv.Enabled := False;
  fAbreConsulta;
  pSetFocus(edtCodigo);

  edtSenVen.ReadOnly := fHabilitaDigitaVendedor;
End;

function TfrmFatRequisicaoCompras.fTemItemVenda: Boolean;
Begin
  With cdsConsulta Do
  Begin
    Result := Not IsEmpty;
    If Not Result Then
      pMensagemOk('Informe os itens da requisição!');
  End;
End;

function TfrmFatRequisicaoCompras.fTemPedidoDeCompraVinculado: Boolean;
  Var
    qryPed: TUniQuery;
    stlMsg: TStringList;
    strDtaCad: String;
begin
  qryPed := fCriaQuery;
  Try
    qryPed.SQL.Add('SELECT                                          ');
    qryPed.SQL.Add('  PCG_DTAENT,                                   ');
    qryPed.SQL.Add('  CONCAT(                                       ');
    qryPed.SQL.Add('    PCG_NUMPED,                                 ');
    qryPed.SQL.Add('    "-",                                        ');
    qryPed.SQL.Add('    PCG_ESPDOC,                                 ');
    qryPed.SQL.Add('    "-",                                        ');
    qryPed.SQL.Add('    PCG_CODEMP                                  ');
    qryPed.SQL.Add('  ) AS NUMPED,                                  ');
    qryPed.SQL.Add('  CONCAT(PCG_CODFOR, "-", FOR_NOMFOR) AS FORNEC ');
    qryPed.SQL.Add('FROM                                            ');
    qryPed.SQL.Add('  PCMGER                                        ');
    qryPed.SQL.Add('INNER JOIN CADFOR                               ');
    qryPed.SQL.Add('  ON FOR_CODFOR = PCG_CODFOR                    ');
    qryPed.SQL.Add('INNER JOIN PCMDET                               ');
    qryPed.SQL.Add('  ON PCD_NUMPED = PCG_NUMPED                    ');
    qryPed.SQL.Add('  AND PCD_CODEMP = PCG_CODEMP                   ');
    qryPed.SQL.Add('  AND PCD_ESPDOC = PCG_ESPDOC                   ');
    qryPed.SQL.Add('  AND PCD_NUMCTN = PCG_NUMCTN                   ');
    qryPed.SQL.Add('INNER JOIN MOVRCD                               ');
    qryPed.SQL.Add('  ON RCD_SEQPCD = PCMDET.AUTOINCREM             ');
    qryPed.SQL.Add('WHERE RCD_CODEMP = :CODEMP                      ');
    qryPed.SQL.Add('  AND RCD_CODIGO = :CODIGO                      ');
    qryPed.SQL.Add('GROUP BY PCG_NUMPED,                            ');
    qryPed.SQL.Add('  PCG_CODEMP,                                   ');
    qryPed.SQL.Add('  PCG_ESPDOC,                                   ');
    qryPed.SQL.Add('  PCG_NUMCTN                                    ');

    qryPed.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryPed.ParamByName('CODIGO').AsString := strCodigo;

    qryPed.Open;

    Result := Not qryPed.IsEmpty;

    If Result Then
    Begin
      stlMsg := TStringList.Create;
      Try
        stlMsg.Add('Esta Requisição de Compra não poderá ser excluída porque está vinculada aos seguintes Pedidos de Compra:');
        stlMsg.Add('');
        stlMsg.Add('Data-------Núm. Ped. compra----Fornecedor--------------------------------------------');
        While Not qryPed.Eof Do
        Begin
          strDtaCad := FormatDateTime('dd/mm/yyyy', qryPed.FieldByName('PCG_DTAENT').AsDateTime);

          stlMsg.Add(strDtaCad
              + ' '+ fPadR(qryPed.FieldByName('NUMPED').AsString, 19, ' ')
              + ' '+ qryPed.FieldByName('FORNEC').AsString);
          qryPed.Next;
        End;
        stlMsg.Add('-------------------------------------------------------------------------------------');

        TfrmMemo.pShowMessage(stlMsg, 9);
      Finally
        stlMsg.Free;
      End;
    End;
  Finally
    FreeAndNil(qryPed);
  End;
end;

procedure TfrmFatRequisicaoCompras.btnGravarClick(Sender: TObject);
begin
  pGravar;
  If blnConfirma And (Self.cdsVenda <> nil) Then
    Self.Close;
end;

procedure TfrmFatRequisicaoCompras.btnSairClick(Sender: TObject);
begin
  objLock.pDestravarTodos;

  edtSenVen.ReadOnly := fHabilitaDigitaVendedor;

  inherited;
end;

procedure TfrmFatRequisicaoCompras.pGravar;
begin
  inherited;

  If Not btnGravar.Enabled Then
    Exit;

  If (Not blnPodeAlterar) And (Not fEmptyStr(edtCodigo.Text)) Then
    Exit;

  If (Not blnPodeIncluir) And fEmptyStr(edtCodigo.Text) Then
  Begin
    pMensagemOk('Usuário ' + strCodUsu + ' sem direito a inclusão.' + #13#10 +
                'Configure os direitos de acesso em Principal > Manutenção de Cadastros > Segurança > Direitos de Acesso (AutCom)' + #13#10 +
                'alterando os direitos da opção Principal > Faturamento > Requisição de Compras > Digitação de Requisição de Compras.');

    Exit;
  End;

  If pnlPesquisa.Visible Then
    pLimpaPesquisa;

  With cdsConsulta Do
  If fValidaCampos(edtCodCli, False) And
     fValidaCampos(edtSenVen, False) And
     fValidaCampos(edtSenDig, False) And
     fTemItemVenda Then
  Begin
    If State in [dsEdit, dsInsert] Then
      Post;

    // validar se ha itens que estão ativos para compras.
    if not TFatVenda.fValidaItemAtivoCompra(cdsConsulta, False) then
      Exit;

    {*REQ*150979**********RP*}
    If fCfgSis('SENRQC', varBoolean) Then
    Begin
      If Not fSolicitaLiberacao Then
        Exit;
    End;

    If (Not blnVaiGravarComFaturamento) Then
    Begin
      DisableControls;

      strCodigo := edtCodigo.Text;

      If fGravaRequisicaoCompra(strCodigo, edtCodCli.Text, strCodVen, regConsum.strCliCgc, cdsConsulta, True, strCodEmp, strCodDig) Then
      Begin
        pIniciaVenda;
        pMensagemOk('Requisição salva com sucesso!');
      End;

      EnableControls;
    End
    Else
      blnConfirma := True;
  End;

end;

class function TfrmFatRequisicaoCompras.fGravaRequisicaoCompra(Var strCodSeq: String; strCodCli, strCodVen, strCliCgc: String; cdsDados: TUniClientDataSet; blnComTransacao: Boolean = True; strCodEmpGrv: String=''; strCodDig: String=''): Boolean;
Begin
  If fEmptyStr(strCodSeq) Then
  begin
    Result := fIncluiRequisicaoCompra(strCodSeq, strCodCli, strCodVen, strCliCgc, cdsDados, blnComTransacao, strCodEmpGrv, strCodDig);

    if Result then
      pEnviaMensagemNovaRequisicao(strCodSeq, strCodEmpGrv);
  end
  Else
    Result := fAlteraRequisicaoCompra(strCodSeq, strCodCli, strCodVen, strCliCgc, cdsDados, blnComTransacao, strCodEmpGrv, strCodDig);
End;

procedure TfrmFatRequisicaoCompras.pAdicionarItensDaVendaSemEstoque;
  Const
    cnsEntFutFalPro: String = 'EFFP';
    
  Var
    pAfterScroll: TDataSetNotifyEvent;
    dicQuantidades: TDicionario;
    dicMotivEntFut: TDicionario;
    strCodIte,
    strCodEmp,
    strDesIte: String;
    fltQtdIte, fltQtdReq, fltSalDis, fltQtdIteTmp: Double;
    blnAlterar: Boolean;
    intIdx: Integer;
    blnItemEspecial: boolean;

    procedure pRemoveItensSemCotacao_Pedido;
    begin
      Try
        cdsConsulta.Filtered := False;
        cdsConsulta.Filter   := 'RCD_SEQCOT = '''' AND RCD_SEQPCD = ''''';
        cdsConsulta.Filtered := True;

        While Not cdsConsulta.IsEmpty Do
          cdsConsulta.Delete;
      Finally
        cdsConsulta.Filtered := False;
        cdsConsulta.Filter := '';
      End;
    end;

    procedure pProcessaQuantidades();
    Begin
      With cdsConsulta Do
      Begin
        First;
        While Not Eof Do
        Begin
          strCodIte := FieldByName('RCD_CODITE').AsString + FieldByName('RCD_EMPITE').AsString;

          if blnConEqu or fCarregarItemEspecialRotinaReqCompras(FieldByName('RCD_CODITE').AsString) then
            strCodIte := strCodIte + FieldByName('RCD_DESITE').AsString;

          If dicQuantidades.Chaves.IndexOf(strCodIte) >= 0 Then
            dicQuantidades.Items[strCodIte] := dicQuantidades.Items[strCodIte] - FieldByName('RCD_QTDITE').AsFloat
          Else
            dicQuantidades.Adicionar(strCodIte, - FieldByName('RCD_QTDITE').AsFloat);

          Next;
        End;
      End;
      blnItemEspecial := False;
      With Self.cdsVenda Do
      Begin
        First;
        While Not Eof Do
        Begin
          blnItemEspecial := fCarregarItemEspecialRotinaReqCompras(FieldByName('ITE_CODITE').AsString);
          If (((FieldByName('ITE_SEMEST').AsString = 'S') And (FieldByName('ITE_BXSBIT').AsString <> 'S'))) or
             (blnFaltaProduto And (FieldByName('ITE_ENTFUT').AsString = 'S') And (FieldByName('ITE_MOTFUT').AsString = 'F')) or
             (blnReqTudo) Or (blnItemEspecial) Then
          Begin
            strCodIte := FieldByName('ITE_CODITE').AsString
                         + IIF(blnEntCD And Not strEmpCD.IsEmpty,
                               strEmpCD,
                               IIF(fCfgSis('EMPFAT', varBoolean),
                                   FieldByName('ITE_EMPITE').AsString,
                                   IIF(fEmptyStr(strEmpTE), VS_strCodEmp, strEmpTE)));

            if blnConEqu or blnItemEspecial then
              strCodIte := strCodIte + FieldByName('ITE_DESITE').AsString;

            fltQtdReq := FieldByName('ITE_QTDITE').AsFloat;

            If (fltQtdReq < 0) Then fltQtdReq := fltQtdReq * (-1);

            If dicQuantidades.Chaves.IndexOf(strCodIte) >= 0 Then
            Begin
              dicQuantidades.Items[strCodIte] := dicQuantidades.Items[strCodIte] + fltQtdReq
            End
            Else
            Begin
              dicQuantidades.Adicionar(strCodIte, fltQtdReq);
              If (blnFaltaProduto And (FieldByName('ITE_ENTFUT').AsString = 'S') And (FieldByName('ITE_MOTFUT').AsString = 'F')) Then
                dicMotivEntFut.Adicionar(strCodIte, cnsEntFutFalPro);
            End;
          End;

          Next;
        End;
      End;
    End;

begin
  If Self.cdsVenda = nil Then
    Exit;

  If Not Self.cdsVenda.Active Then
    Exit;

  If Self.cdsVenda.IsEmpty Then
    Exit;

  pAfterScroll := cdsConsulta.AfterScroll;
  cdsConsulta.AfterScroll := Nil;
  dicQuantidades := TDicionario.Create();
  dicMotivEntFut := TDicionario.Create();
  Try
    pRemoveItensSemCotacao_Pedido();
    pProcessaQuantidades();

    cdsConsulta.Filtered := False;
    cdsConsulta.Filter   := 'RCD_SEQCOT = '''' AND RCD_SEQPCD = ''''';
    cdsConsulta.Filtered := True;

    For intIdx := 0 to dicQuantidades.Chaves.Count - 1 Do
    Begin
      strCodIte := Copy(dicQuantidades.Chaves[intIdx], 1, fTamCodIte);
      blnItemEspecial := fCarregarItemEspecialRotinaReqCompras(strCodIte);
      if fTamCodIte = 5 then
      begin
        strCodEmp := Copy(dicQuantidades.Chaves[intIdx], 6 , 3);
        strDesIte := IIF((blnConEqu or blnItemEspecial), Copy(dicQuantidades.Chaves[intIdx], 9 , Length(dicQuantidades.Chaves[intIdx])), '');
      end
      else
      begin
        strCodEmp := Copy(dicQuantidades.Chaves[intIdx], 8 , 3);
        strDesIte := IIF((blnConEqu or blnItemEspecial), Copy(dicQuantidades.Chaves[intIdx], 11 , Length(dicQuantidades.Chaves[intIdx])), '');
      end;

      if not (blnConEqu or blnItemEspecial) then
      begin
        If cdsConsulta.Locate('RCD_CODITE;RCD_EMPITE', VarArrayOf([strCodIte, strCodEmp]), []) Then
        Begin
          fltQtdIte := cdsConsulta.FieldByName('RCD_QTDITE').AsFloat + dicQuantidades.Retorna(strCodIte + strCodEmp);
          blnAlterar := True;
        End
        Else
        Begin
          fltQtdIte := dicQuantidades.Retorna(strCodIte + strCodEmp);
          blnAlterar := False;
        End;
      end
      else
      begin
        If cdsConsulta.Locate('RCD_CODITE;RCD_EMPITE;RCD_DESITE', VarArrayOf([strCodIte, strCodEmp, strDesIte]), []) Then
        Begin
          fltQtdIte := cdsConsulta.FieldByName('RCD_QTDITE').AsFloat + dicQuantidades.Retorna(strCodIte + strCodEmp + strDesIte);
          blnAlterar := True;
        End
        Else
        Begin
          fltQtdIte := dicQuantidades.Retorna(strCodIte + strCodEmp + strDesIte);
          blnAlterar := False;
        End;
      end;

      if (not blnReqTudo) then
      begin
        fltSalDis := fRetornaSaldoDisponivel(strCodIte, False, True, '', True, strCodEmp, strNumOrc);

        fltQtdIteTmp := fltQtdIte;

        If (VarToStr(dicMotivEntFut.Retorna(strCodIte + strCodEmp)) <> cnsEntFutFalPro) Then
          If (fltSalDis > 0) Then
            fltQtdIte := fltQtdIte - fltSalDis;

        if (blnFaltaProduto) and (fltQtdIte <= 0) then
        begin
          fltQtdIte := fltQtdIteTmp;
        end;
      end;

      If fltQtdIte > 0 Then
      Begin
        If blnAlterar Then
          cdsConsulta.Edit
        Else
          cdsConsulta.Insert;

        cdsConsulta.FieldByName('RCD_CODITE').AsString := strCodIte;

        if blnConEqu or fCarregarItemEspecialRotinaReqCompras(strCodIte) then
          cdsConsulta.FieldByName('RCD_DESITE').AsString := strDesIte
        else
          cdsConsulta.FieldByName('RCD_DESITE').AsString := fRetornaDescricaoItemVenda(strCodIte);

        cdsConsulta.FieldByName('RCD_EMPITE').AsString := strCodEmp;
        cdsConsulta.FieldByName('RCD_QTDITE').AsFloat  := fltQtdIte;
        cdsConsulta.FieldByName('RCD_ATICOM').AsString := fRetAtiComItem(strCodIte);

        if (fDataValida(StrToDateDef(edtPrevisaoEstoque.Text, 0))) then
           cdsConsulta.FieldByName('RCD_DTPREV').AsDateTime := StrToDate(edtPrevisaoEstoque.Text);

        cdsConsulta.FieldByName('RCD_OBSERV').AsString := fRetObservacaoMovRcd(strCodIte,
                                                                               strNumOrc,
                                                                               strEspOrc,
                                                                               strCodEmp);

        cdsConsulta.Post;
      End
      Else If blnAlterar Then
        cdsConsulta.Delete;
    End;

    pLimpaItem;
  Finally
    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := '';
    cdsConsulta.AfterScroll := pAfterScroll;
    FreeAndNil(dicQuantidades);
    FreeAndNil(dicMotivEntFut);
  End;
end;

class procedure TfrmFatRequisicaoCompras.pAlteraMovRcg(strCodigo, strCodCli, strCodVen, strCliCgc: String; dtaDtaAlt: TDate; strCodEmp: String = ''; strCodDig: String='');
  Var
    qryGen: TUniQuery;
Begin
  if fEmptyStr(strCodEmp) then
    strCodEmp := VS_strCodEmp;

  qryGen := fCriaQuery;

  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT * FROM MOVRCG WHERE');
    qryGen.SQL.Add('RCG_CODIGO = :CODIGO AND');
    qryGen.SQL.Add('RCG_CODEMP = :CODEMP    ');

    qryGen.ParamByName('CODIGO').AsString   := strCodigo;
    qryGen.ParamByName('CODEMP').AsString   := strCodEmp;
    qryGen.Open;

    qryGen.Edit;
    qryGen.FieldByName('RCG_CODCLI').AsString   := strCodCli;
    qryGen.FieldByName('RCG_CODVEN').AsString   := strCodVen;
    qryGen.FieldByName('RCG_CODDIG').AsString   := strCodDig;
    qryGen.FieldByName('RCG_DTAALT').AsDateTime := dtaDtaAlt;

    If fEmptyStr(strCliCgc) Then
      qryGen.FieldByName('RCG_CPFCON').Clear
    Else
      qryGen.FieldByName('RCG_CPFCON').AsString   := strCliCgc;

    qryGen.Post;
  Finally
    FreeAndNil(qryGen);
  End;
End;

{class procedure TfrmFatRequisicaoCompras.pApagaMovRcd(strCodigo, strCodEmp: String; strAutInc: String ='');
  Var
    qryGen: TUniQuery;
Begin
  if fEmptyStr(strCodEmp) then
    strCodEmp := VS_strCodEmp;

  qryGen := fCriaQuery;

  With qryGen Do
  Begin

    SQL.Clear;
    SQL.Add('DELETE                             ');
    SQL.Add('FROM                               ');
    SQL.Add('  MOVRCD                           ');
    SQL.Add('WHERE RCD_CODIGO = :CODIGO         ');
    SQL.Add('  AND RCD_CODEMP = :CODEMP         ');
    SQL.Add('  AND COALESCE(RCD_SEQCOT, "") = ""');
    SQL.Add('  AND COALESCE(RCD_SEQPCD, "") = ""');
    If strAutInc <> '' Then
      SQL.Add('  AND AUTOINCREM = "'+strAutInc+'"');

    ParamByName('CODIGO').AsString   := strCodigo;
    ParamByName('CODEMP').AsString   := strCodEmp;
    ExecSQL;

  End;

  FreeAndNil(qryGen);
End;   }

class function TfrmFatRequisicaoCompras.fIncluiRequisicaoCompra(Var strCodSeq: String; strCodCli, strCodVen, strCliCgc: String; cdsDados: TUniClientDataSet; blnComTransacao: Boolean = True; strCodEmpGrv: String=''; strCodDig: String=''): Boolean;
Begin
  With cdsDados Do
  Try
    If (blnComTransacao) Then
      fStartTransaction;

    strCodSeq := fAtualizaProCod('MOVRCG', 'RCG_CODIGO');

    pIncluiMovRcg(strCodSeq, strCodCli, strCodVen, strCliCgc, VS_Date, '', '', '', strCodEmpGrv, strCodDig);

    First;
    While Not Eof Do
    Begin
      fIncluiMovRcd(strCodSeq,
                    FieldByName('RCD_CODITE').AsString,
                    FieldByName('RCD_DESITE').AsString,
                    FieldByName('RCD_OBSERV').AsString,
                    FieldByName('RCD_DOCPDV').AsString,
                    FieldByName('RCD_ESPPDV').AsString,
                    FieldByName('RCD_EMPPDV').AsString,
                    FieldByName('RCD_QTDITE').AsFloat,
                    FieldByName('RCD_DTPREV').AsDateTime,
                    strCodEmpGrv);

      Next;
    End;

    If (blnComTransacao) Then
      fCommit;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fIncluiRequisicaoCompra]');
    End;
  End;
End;

Class Procedure TfrmFatRequisicaoCompras.pUpdateQtdRcd(strAutInc: String; fltQtdIte: Double);
  Var
    qryMovRcd: TUniQuery;
Begin
  qryMovRcd := fCriaQuery;
  qryMovRcd.SQL.Text := 'UPDATE MOVRCD SET RCD_QTDITE = :QTDITE WHERE AUTOINCREM = :AUTINC';
  qryMovRcd.ParamByName('QTDITE').AsFloat  := fltQtdIte;
  qryMovRcd.ParamByName('AUTINC').AsString := strAutInc;
  qryMovRcd.ExecSQL;

  FreeAndNil(qryMovRcd);
End;

class function TfrmFatRequisicaoCompras.fAlteraRequisicaoCompra(strCodSeq, strCodCli, strCodVen, strCliCgc: String; cdsDados: TUniClientDataSet; blnComTransacao: Boolean = True; AstrCodEmp: String = ''; strCodDig: String=''): Boolean;
var ListaItensProcessados: string;
    strAutInc: String;
Begin
  With cdsDados Do
  Try
    If (blnComTransacao) Then
      fStartTransaction;

    pAlteraMovRcg(strCodSeq, strCodCli, strCodVen, strCliCgc, VS_Date, AstrCodEmp, strCodDig);

    First;
    ListaItensProcessados := '';
    While Not Eof Do
    Begin

      If fEmptyStr(FieldByName('RCD_SEQCOT').AsString) And
         fEmptyStr(FieldByName('RCD_SEQPCD').AsString) And
         fEmptyStr(FieldByName('NOTAS').AsString)      Then
      Begin
        strAutInc := fIncluiMovRcd(strCodSeq,
                      FieldByName('RCD_CODITE').AsString,
                      FieldByName('RCD_DESITE').AsString,
                      FieldByName('RCD_OBSERV').AsString,
                      FieldByName('RCD_DOCPDV').AsString,
                      FieldByName('RCD_ESPPDV').AsString,
                      FieldByName('RCD_EMPPDV').AsString,
                      FieldByName('RCD_QTDITE').AsFloat,
                      FieldByName('RCD_DTPREV').AsDateTime,
                      AstrCodEmp);

        If ListaItensProcessados <> '' Then
          ListaItensProcessados := ListaItensProcessados + ',"'+ strAutInc +'"'
        Else
          ListaItensProcessados := ListaItensProcessados + '"' + strAutInc + '"';
      End
      Else
      Begin
        pUpdateQtdRcd(FieldByName('AUTOINCREM').AsString,
                         FieldByName('RCD_QTDITE').AsFloat);

        If ListaItensProcessados <> '' Then
          ListaItensProcessados := ListaItensProcessados + ',"'+ cdsDados.FieldByName('AUTOINCREM').AsString +'"'
        Else
          ListaItensProcessados := ListaItensProcessados + '"' + cdsDados.FieldByName('AUTOINCREM').AsString + '"';
      End;

      Next;
    End;

    pRemoveMovRcdNaoProcessado(ListaItensProcessados, strCodSeq);

    If (blnComTransacao) Then
      fCommit;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fAlteraRequisicaoCompra]');
    End;
  End;
End;

procedure TfrmFatRequisicaoCompras.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqRequisicaoCompra(Self, edtCodigo, Key) Then
    fValidaCampos(edtCodigo, True);
end;

procedure TfrmFatRequisicaoCompras.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If blnVaiGravarComFaturamento And (Key = VK_ESCAPE) Then
    btnSair.Click
  Else
    inherited;

  Case Key Of
    VK_F10: btnGravar.Click;
    VK_ESCAPE: edtSenVen.ReadOnly := fHabilitaDigitaVendedor;
  End;
end;

procedure TfrmFatRequisicaoCompras.edtCodIteKeyPress(Sender: TObject;
 var Key: Char);
  Var
    qryConGen: TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;

  If (fEntraCons(Key)) And (Not edtCodIte.ReadOnly) Then
  Begin

    qryConGen    := fCriaQuery;
    Try

      if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConGen, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
      Begin
        If fValidaCampos(edtCodIte, True) Then
          Self.SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmPrincipal.pConsultaItem]');
      End;
    End;
    FreeAndNil(qryConGen);
  End;
end;

procedure TfrmFatRequisicaoCompras.pMostraEstoqueLojas;
  Var
    frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
begin

  If Not fValidaCampos(edtCodIte, True) Then
    Exit;

  pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);

  Try

    Try

      frmFatMostraEstoqueEmp.blnFaturamento := True;
      frmFatMostraEstoqueEmp.strCodIte      := cdsConsulta.FieldByName('RCD_CODITE').AsString;
      frmFatMostraEstoqueEmp.strTabPre      := IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD'));
      frmFatMostraEstoqueEmp.edtItem.Text   := cdsConsulta.FieldByName('RCD_CODITE').AsString + ' - ' +
                                               cdsConsulta.FieldByName('RCD_DESITE').AsString;
      frmFatMostraEstoqueEmp.blnEstrutura   := fItemEstrutura(cdsConsulta.FieldByName('RCD_CODITE').AsString);
      frmFatMostraEstoqueEmp.showModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[pMostraEstoqueLojas]');
    End;

  Finally
    pFreeAndNil(frmFatMostraEstoqueEmp);
  End;

end;

procedure TfrmFatRequisicaoCompras.pMostraItem;
Begin
  With cdsConsulta Do
  Begin
    If State In [dsEdit, dsInsert] Then
      Exit;

    If Not IsEmpty Then
    Begin
      pCarregaItem(FieldByName('RCD_CODITE').AsString);

      edtCodIte.Text := FieldByName('RCD_CODITE').AsString;
      edtDesIte.Text := FieldByName('RCD_DESITE').AsString;
      edtDocPdv.Text := FieldByName('RCD_DOCPDV').AsString;
      edtEspPdv.Text := FieldByName('RCD_ESPPDV').AsString;
      edtEmpPDv.Text := FieldByName('RCD_EMPPDV').AsString;
      edtObserv.Text := IIF(fEmptyStr(edtObserv.Text), FieldByName('RCD_OBSERV').AsString, edtObserv.Text);
      edtEmpIte.Text := FieldByName('RCD_EMPITE').AsString;
      edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, FieldByName('RCD_QTDITE').AsFloat);
      strIteAnt := FieldByName('RCD_CODITE').AsString;
      edtAtiCom.Text := FieldByName('RCD_ATICOM').AsString;
      edtPrevisaoEstoque.Text := FieldByName('RCD_DTPREV').AsString;

      edtCodIte.Enabled := fEmptyStr(FieldByName('RCD_SEQCOT').AsString) And
                           fEmptyStr(FieldByName('RCD_SEQPCD').AsString);

      edtEmpIte.Enabled := edtCodIte.Enabled;

      edtQtdIte.Enabled := edtCodIte.Enabled;

      pCarregaOrdemServico;
    End;

  End;
End;

function TfrmFatRequisicaoCompras.fObterDescricaoItemPedido: Boolean;
  Var
    strDesIteFdo,
    strMsg: String;
    lResultSelecionarDescricao: TResultSelecionarDescricao;
begin
  Result := True;

  if Not fEhItemEspecial(edtCodIte.Text) then
    Exit;

  strDesIteFdo := TfrmFatReqCompraSelItemEspecialVenda.fObterDescricaoItemVenda(edtCodIte.Text,
                                                                                edtCodCli.Text,
                                                                                edtDocPdv.Text,
                                                                                edtEspPdv.Text,
                                                                                edtEmpPdv.Text,
                                                                                lResultSelecionarDescricao);


  Case lResultSelecionarDescricao of
    TResultSelecionarDescricao.trItemNaoEncontradoNoPedido: strMsg := 'Item especial não encontrado no pedido informado!';
    TResultSelecionarDescricao.trNaoSelecionado: strMsg := 'É obrigatório selecionar o item do pedido!';
    TResultSelecionarDescricao.trSelecionado: edtDesIte.text := strDesIteFdo;
  end;

  if lResultSelecionarDescricao in [trItemNaoEncontradoNoPedido, trNaoSelecionado] then
  begin
    fMensagem('Atenção!', strMsg, ['&Ok']);
    Result := False;
  end;

end;

class procedure TfrmFatRequisicaoCompras.pRemoveMovRcdNaoProcessado(
  AListaProcessados: String; strCodSeq: String);
Var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;
  try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('DELETE');
    qryGen.SQL.Add('FROM MOVRCD');
    qryGen.SQL.Add('WHERE AUTOINCREM NOT IN ('+AListaProcessados+')');
    qryGen.SQL.Add(' AND RCD_CODIGO = "'+strCodSeq+'" '  );
    qryGen.SQL.Add('  AND COALESCE(RCD_SEQCOT, "") = ""');
    qryGen.SQL.Add('  AND COALESCE(RCD_SEQPCD, "") = ""');

    qryGen.ExecSQL;
  finally
    FreeAndNil(qryGen);
  end;
end;

procedure TfrmFatRequisicaoCompras.pLimpaItem;
Begin
  strIteAnt := '';
  if not blnShowModalConsulta Then
  begin
    edtCodIte.Clear;
    edtDesIte.Clear;
  end;
  edtQtdIte.Text := FormatFloat(edtQtdIte.EditFormat, 0);
  edtDocPdv.Clear;
  edtEspPdv.Clear;
  edtEmpPDv.Clear;
  edtEmpIte.Clear;
  edtObserv.Clear;
  edtAtiCom.Clear;
  edtPrevisaoEstoque.Clear;

  edtCodIte.Enabled := True;
  edtQtdIte.Enabled := True;

  edtNumOSe.Clear;
  edtEmpOSe.Clear;

  pSetFocus(edtCodIte);
End;

procedure TfrmFatRequisicaoCompras.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  pMostraItem;
  btnCopiarPdv.Enabled := (Not cdsConsulta.IsEmpty) And (Not fEmptyStr(cdsConsulta.FieldByName('RCD_DOCPDV').AsString));
end;

procedure TfrmFatRequisicaoCompras.pGravaItem;
  Var
    pAfterScroll: TDataSetNotifyEvent;
    fltQtdeItem: Double;
    blnEditarItem: Boolean;
    objLiberacao: TLiberacao;
begin
  fltQtdeItem := 0;
  if (Self.cdsVenda <> nil) and (Self.cdsVenda.Active) then
  begin
    if fQuantidadeDeItemEhMaiorQueQuantidadeDigitada(fltQtdeItem) then
    begin
      pMensagemOk('A quantidade não pode ser maior que '+ FloatToStr(fltQtdeItem) +' !' );
      pSetFocus(edtQtdIte);
      Exit;
    end;
  end;

  If (Self.cdsVenda <> nil) And (Self.cdsVenda.Active) Then
  begin
    If fQuantidadeDeItemEhMenorQueQuantidadeDigitada(fltQtdeItem) Then
    Begin
      If (fCfgSis('RCPDQP', varBoolean)) Then
      Begin
        objLiberacao := TLiberacao.Create;

        Try
          objLiberacao.strDirAce  := 'PERMITEDIMQTDPRODREQCOM';
          objLiberacao.strMsgSen  := 'Permitir diminuir a quantidade de produtos na requisição de compra';
          objLiberacao.strCodOpe  := strCodVen;
          objLiberacao.strCodDig  := strLoginUsuarioLogado;
          objLiberacao.objMsgLibera.pAddTexto('Permitir diminuir a quantidade de produtos na requisição de compra');
          objLiberacao.objMsgLibera.pAddTexto('Produto   : ' + cdsConsulta.FieldByName('RCD_CODITE').AsString + ' - '+ cdsConsulta.FieldByName('RCD_DESITE').AsString);
          objLiberacao.objMsgLibera.pAddTexto('Quantidade Original: ' + FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsConsulta.FieldByName('RCD_QTDITE').AsFloat));
          objLiberacao.objMsgLibera.pAddTexto('Quantidade Digitada: ' + FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), fStrToFloat(edtQtdIte.Text)));

          If (Not objLiberacao.fLibera) Then
          Begin
            edtQtdIte.Text := FloatToStr(fltQtdeItem);
            pSetFocus(edtQtdIte);
            Exit;
          End;

        Finally
          FreeAndNil(objLiberacao);
        End;
      End
      Else
      Begin
        pMensagemOk('A quantidade não pode ser menor que '+ FloatToStr(fltQtdeItem) +' !' );
        pSetFocus(edtQtdIte);
        Exit;
      End;
    end;
  end;

  With cdsConsulta Do
  Begin
    pAfterScroll := AfterScroll;
    AfterScroll := Nil;
    Filter := 'RCD_SEQCOT = '''' AND ((RCD_SEQPCD = '''') OR (QTDBAI > 0)) ';
    Filtered := True;

    Try
      if blnConEqu or (fEhItemEspecial(edtCodIte.Text))then
        blnEditarItem := ((FieldByName('RCD_CODITE').AsString = edtCodIte.Text) And (FieldByName('RCD_EMPITE').AsString = edtEmpIte.Text) And
          (FieldByName('RCD_DESITE').AsString = edtDesIte.Text)) Or
          (Locate('RCD_CODITE;RCD_EMPITE;RCD_DESITE', VarArrayOf([edtCodIte.Text, edtEmpIte.Text, edtDesIte.Text]), []))
      else
        blnEditarItem := ((FieldByName('RCD_CODITE').AsString = edtCodIte.Text) And (FieldByName('RCD_EMPITE').AsString = edtEmpIte.Text)) Or
          (Locate('RCD_CODITE;RCD_EMPITE', VarArrayOf([edtCodIte.Text, edtEmpIte.Text]), []));

      If blnEditarItem Then
        Edit
      Else
      Begin
        Insert;
        FieldByName('RCD_CODITE').AsString := edtCodIte.Text;
        FieldByName('ITE_CODFAB').AsString := qryCadIte.FieldByName('ITE_CODFAB').AsString;
        FieldByName('ITE_CODMAR').AsString := qryCadIte.FieldByName('ITE_CODMAR').AsString;
      End;

      FieldByName('RCD_DESITE').AsString := edtDesIte.Text;
      FieldByName('RCD_OBSERV').AsString := edtObserv.Text;
      FieldByName('RCD_DOCPDV').AsString := edtDocPdv.Text;
      FieldByName('RCD_ESPPDV').AsString := edtEspPdv.Text;
      FieldByName('RCD_EMPPDV').AsString := edtEmpPdv.Text;
      FieldByName('RCD_EMPITE').AsString := edtEmpIte.Text;
      FieldByName('RCD_QTDITE').AsFloat  := fStrToFloat(edtQtdIte.Text);
      FieldByName('RCD_ATICOM').AsString  := edtAtiCom.Text;

      if (fDataValida(StrToDateDef(edtPrevisaoEstoque.Text, 0))) then
        FieldByName('RCD_DTPREV').AsDateTime := StrToDate(edtPrevisaoEstoque.Text);

      Post;

      pLimpaItem;
    Finally
      Filtered := False;
      Filter := '';
      AfterScroll := pAfterScroll;
    End;
  End;
end;

procedure TfrmFatRequisicaoCompras.pEditaItem;
Begin
  pMostraItem;

  If edtCodIte.Enabled Then
    pSetFocus(edtCodIte)
  Else
    pSetFocus(edtQtdIte);
End;

procedure TfrmFatRequisicaoCompras.btnCancelaItemClick(Sender: TObject);
begin
  inherited;

  pLimpaItem;


end;

procedure TfrmFatRequisicaoCompras.btnCopiarPdvClick(Sender: TObject);
  Var
    intRecNo : Integer;
    strDocPdv : String;
    strEspPdv : String;
    strEmpPdv : String;
begin
  inherited;
  If Not (btnCopiarPdv.Visible And btnCopiarPdv.Enabled) Then
    Exit;

  intRecNo := cdsConsulta.RecNo;
  cdsConsulta.DisableControls;
  Try
    strDocPdv := cdsConsulta.FieldByName('RCD_DOCPDV').AsString;
    strEspPdv := cdsConsulta.FieldByName('RCD_ESPPDV').AsString;
    strEmpPdv := cdsConsulta.FieldByName('RCD_EMPPDV').AsString;

    cdsConsulta.First;
    While (Not cdsConsulta.Eof) Do
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('RCD_DOCPDV').AsString := strDocPdv;
      cdsConsulta.FieldByName('RCD_ESPPDV').AsString := strEspPdv;
      cdsConsulta.FieldByName('RCD_EMPPDV').AsString := strEmpPdv;
      cdsConsulta.Post;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.RecNo := intRecNo;
    cdsConsulta.EnableControls;
  End;
end;

function TfrmFatRequisicaoCompras.fDigDadosConsumidor: Boolean;
begin

  With regConsum Do
  Try
    pCriarFormularios(TfrmFatDadosCliConsumidor, frmFatDadosCliConsumidor);

    {*******************************************}
    {* CARREGANDO DADOS                        *}
    {****************************************AF*}
    frmFatDadosCliConsumidor.strCodCli      := edtCodCli.Text;      // - Código
    frmFatDadosCliConsumidor.edtNomCli.Text := strCliNom;           // - Nome
    frmFatDadosCliConsumidor.edtEndere.Text := strCliEnd;           // - Endereco
    frmFatDadosCliConsumidor.edtBairro.Text := strCliBai;           // - Bairro
    frmFatDadosCliConsumidor.mskNumCep.Text := strCliCep;           // - Cep
    frmFatDadosCliConsumidor.edtCodCid.Text := strCodCid;           // - Cod. Cidade
    frmFatDadosCliConsumidor.edtNomCid.Text := strCliCid;           // - Cidade
    frmFatDadosCliConsumidor.edtEstado.Text := strCliEst;           // - Estado
    frmFatDadosCliConsumidor.mskTelCon.Text := strCliTel;           // - Telefone
    frmFatDadosCliConsumidor.mskNumCgc.Text := strCliCgc;           // - CNPJ
    frmFatDadosCliConsumidor.edtCgcCpf.Text := IntToStr(intCgcCpf); // - CGC/CPF
    frmFatDadosCliConsumidor.edtInsEst.Text := strCliIes;           // - Ins.Estadual
    frmFatDadosCliConsumidor.edtRgCli.Text  := strCli_Rg;           // - Rg
    frmFatDadosCliConsumidor.strEstado      := strCliEst;           // - Estado

    frmFatDadosCliConsumidor.showModal;

    Result := frmFatDadosCliConsumidor.blnConfirma;

    {*******************************************}
    {* DADOS ALTERADOS                         *}
    {****************************************AF*}
    If frmFatDadosCliConsumidor.blnConfirma Then
    Begin
      strCliNom := frmFatDadosCliConsumidor.edtNomCli.Text; // - Nome
      strCliEnd := frmFatDadosCliConsumidor.edtEndere.Text; // - Endereco
      strCliBai := frmFatDadosCliConsumidor.edtBairro.Text; // - Bairro
      strCliCep := frmFatDadosCliConsumidor.mskNumCep.Text; // - Cep
      strCodCid := frmFatDadosCliConsumidor.edtCodCid.Text; // - Cód. Cidade
      strCliCid := frmFatDadosCliConsumidor.edtNomCid.Text; // - Cidade
      strCliEst := frmFatDadosCliConsumidor.edtEstado.Text; // - Estado
      strCliTel := frmFatDadosCliConsumidor.mskTelCon.Text; // - Telefone
      strCliCgc := frmFatDadosCliConsumidor.mskNumCgc.Text; // - CNPJ
      strCli_Rg := frmFatDadosCliConsumidor.edtRgCli.Text;  // - RG

      If fEmptyStr(frmFatDadosCliConsumidor.edtCgcCpf.Text) Then
        intCgcCpf := 0
      Else
        intCgcCpf := StrToInt(frmFatDadosCliConsumidor.edtCgcCpf.Text); // - CGC/CPF

      strCliIes := frmFatDadosCliConsumidor.edtInsEst.Text;             // - Ins.Estadual

      edtNomCli.Text := strCliNom;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fDigDadosConsumidor]');
    End;
  End;

  pFreeAndNil(frmFatDadosCliConsumidor);
end;

procedure TfrmFatRequisicaoCompras.edtCodCliEnter(Sender: TObject);
begin
  inherited;

  strCliAnt := edtCodCli.Text;
end;

procedure TfrmFatRequisicaoCompras.FormActivate(Sender: TObject);
begin
  inherited;
  If (Not blnVaiGravarComFaturamento) Then
    pSetFocus(edtCodigo)
  Else
    pSetFocus(edtSenVen);
end;

procedure TfrmFatRequisicaoCompras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If blnVaiGravarComFaturamento Then
  Begin
    If (blnConfirma = False) And (Not blnFecharFormPai) Then
      If (fMensagem('ATENÇÃO!', 'Deseja realmente abortar a requisição?', ['&S i m', '&N ã o'], 2) = 2) Then
        Action := caNone;
  End
  Else
  Begin
    With cdsConsulta Do
    Begin
      If (ModalResult <> mrOk) And (Not edtCodigo.Enabled Or (Active And (not IsEmpty))) Then
      Begin
        Action := caNone;

        If (fEmptyStr(edtCodIte.Text)) Then
        Begin
          If (fMensagem('ATENÇÃO!', 'Deseja realmente cancelar a operação?', ['&S i m', '&N ã o'], 2) = 1) Then
            pIniciaVenda;
        End
        Else
          btnCancelaItem.Click;

      End;
    End;
  End;

end;

class procedure TfrmFatRequisicaoCompras.pExibe(strCodIte, strDesIte: String);
  Var
    frmFatRequisicaoCompras : TfrmFatRequisicaoCompras;
begin
  pCriarFormularios(TfrmFatRequisicaoCompras, frmFatRequisicaoCompras);
  Try
    frmFatRequisicaoCompras.edtCodite.Text := strCodIte;
    frmFatRequisicaoCompras.edtDesIte.Text := strDesIte;

    frmFatRequisicaoCompras.blnShowModalConsulta := True;
    frmFatRequisicaoCompras.ShowModal;
  Finally
    FreeAndNil(frmFatRequisicaoCompras);
  End;
end;

class procedure TfrmFatRequisicaoCompras.pExibeRequisicao(strCodigo, strCodEmp: String);
  Var
    frmFatRequisicaoCompras : TfrmFatRequisicaoCompras;
begin
  If Not fVerificaAcessoSistema('frmFatRequisicaoCompras') then
  Begin
    fMensagem('', 'Esse usuário não tem direito a acessar esse módulo!', ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmFatRequisicaoCompras, frmFatRequisicaoCompras);
  Try
    frmFatRequisicaoCompras.blnLimparTela := false;
    frmFatRequisicaoCompras.strCodEmp := strCodEmp;
    frmFatRequisicaoCompras.edtCodigo.Text := strCodigo;
    frmFatRequisicaoCompras.blnShowModalConsulta := True;
    frmFatRequisicaoCompras.ShowModal;
  Finally
    FreeAndNil(frmFatRequisicaoCompras);
  End;
end;

procedure TfrmFatRequisicaoCompras.btnExcVenClick(Sender: TObject);
begin
  If (blnVaiGravarComFaturamento) Then
  Begin
    pMensagemOk('Não é possível excluir a requisição de compra vínculada ao Pedido de venda!');
    Exit;
  End;

  If Not fPermiteApagarRequisicao Then
    Exit;

  If fPergunta('Deseja excluir a Requisição de Compra?') Then
  Begin
    pExcluiRequisicaoCompra(strCodigo, VS_strCodEmp, Self.Name);
    pIniciaVenda;
  End;
end;

class procedure TfrmFatRequisicaoCompras.pIncluiMovRcg(strCodigo, strCodCli, strCodVen, strCliCgc : String; dtaDtaCad: TDate; strNumDoc, strEspDoc, strSerie: String; strCodEmpGrv: String=''; strCodDig: String='');
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  If fEmptyStr(strCodEmpGrv) Then
    strCodEmpGrv := VS_strCodEmp;

  With qryGen Do
  Begin

    SQL.Clear;
    SQL.Add('SELECT * FROM MOVRCG WHERE FALSE');
    Open;

    Insert;
    FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('MOVRCG', strCodEmpGrv);
    FieldByName('RCG_CODEMP').AsString   := strCodEmpGrv;
    FieldByName('RCG_CODIGO').AsString   := strCodigo;
    FieldByName('RCG_CODCLI').AsString   := strCodCli;
    FieldByName('RCG_CODVEN').AsString   := strCodVen;
    FieldByName('RCG_DTACAD').AsDateTime := dtaDtaCad;
    FieldByName('RCG_DTAALT').AsDateTime := dtaDtaCad;
    FieldByName('RCG_CPFCON').AsString   := strCliCgc;
    if fEmptyStr(strCliCgc) then
      FieldByName('RCG_CPFCON').Clear;

    FieldByName('RCG_NUMDOC').AsString   := strNumDoc;
    FieldByName('RCG_ESPDOC').AsString   := strEspDoc;
    FieldByName('RCG_SERIE_').AsString   := strSerie;
    FieldByName('RCG_CODDIG').AsString   := strCodDig;

    Post;

  End;

  FreeAndNil(qryGen);
end;

class function TfrmFatRequisicaoCompras.fIncluiMovRcd(strCodigo, strCodIte, strDesIte, strObserv, strDocPdv, strEspPdv, strEmpPdv: String; fltQtdIte: Double; dtPrev: TDateTime; strCodEmpGrv: String=''; strSeqPCD: String=''): String;
  Var
    qryGen: TUniQuery;
    strAutInc: String;
begin
  strAutInc := '';
  qryGen := fCriaQuery;

  If fEmptyStr(strCodEmpGrv) Then
    strCodEmpGrv := VS_strCodEmp;

  Try
    With qryGen Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT * FROM MOVRCD WHERE FALSE');
      Open;

      Insert;
      strAutInc := fRetAutoIncrem('MOVRCD', strCodEmpGrv);
      FieldByName('AUTOINCREM').AsString  := strAutInc;
      FieldByName('RCD_CODEMP').AsString  := strCodEmpGrv;
      FieldByName('RCD_CODIGO').AsString  := strCodigo;
      FieldByName('RCD_CODITE').AsString  := strCodIte;
      FieldByName('RCD_DESITE').AsString  := strDesIte;

      FieldByName('RCD_OBSERV').AsString  := strObserv;
      FieldByName('RCD_DOCPDV').AsString  := strDocPdv;
      FieldByName('RCD_ESPPDV').AsString  := strEspPdv;

      If Not fEmptyStr(strEmpPdv) Then
        FieldByName('RCD_EMPPDV').AsString := strEmpPdv;

      FieldByName('RCD_QTDITE').AsFloat   := fltQtdIte;

      if (fDataValida(dtPrev)) then
         FieldByName('RCD_DTPREV').AsDateTime := dtPrev;

      if (not fEmptyStr(strSeqPCD)) then
        FieldByName('RCD_SEQPCD').AsString := strSeqPCD;

      Post;

    End;
  Finally
    Result := strAutInc;
    FreeAndNil(qryGen);
  End;
end;

class function TfrmFatRequisicaoCompras.fApagaMovRcd(strAutInc: String): Boolean;
Var
  qryGen: TUniQuery;
  strCodEmp, strCodigo: String;
  blnMovRcgOrfao: Boolean;
Begin
  qryGen := fCriaQuery;
  try
    try
      qryGen.SQL.Clear;
      qryGen.SQL.Add('SELECT RCD_CODEMP, RCD_CODIGO');
      qryGen.SQL.Add('  FROM MOVRCD');
      qryGen.SQL.Add(' WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := strAutInc;
      qryGen.Open;
      strCodEmp := qryGen.FieldByName('RCD_CODEMP').AsString;
      strCodigo := qryGen.FieldByName('RCD_CODIGO').AsString;
      qryGen.Close;

      qryGen.SQL.Clear;
      qryGen.SQL.Add('DELETE FROM MOVRCD');
      qryGen.SQL.Add('WHERE AUTOINCREM = :AUTINC');
      qryGen.SQL.Add('  AND COALESCE(RCD_SEQCOT, "") = ""');

      If Not fCfgSis('REQAUT', varBoolean ) Then
        qryGen.SQL.Add('  AND COALESCE(RCD_SEQPCD, "") = ""');

      qryGen.ParamByName('AUTINC').AsString := strAutInc;
      qryGen.ExecSQL;

      qryGen.SQL.Clear;
      qryGen.SQL.Add('SELECT AUTOINCREM');
      qryGen.SQL.Add('  FROM MOVRCD');
      qryGen.SQL.Add(' WHERE RCD_CODEMP = :CODEMP');
      qryGen.SQL.Add('   AND RCD_CODIGO = :CODIGO');
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.ParamByName('CODIGO').AsString := strCodigo;
      qryGen.Open;
      blnMovRcgOrfao := qryGen.IsEmpty;
      qryGen.Close;

      if blnMovRcgOrfao then
      begin
        qryGen.SQL.Clear;
        qryGen.SQL.Add('DELETE FROM MOVRCG');
        qryGen.SQL.Add('WHERE RCG_CODEMP = :CODEMP');
        qryGen.SQL.Add('  AND RCG_CODIGO = :CODIGO');
        qryGen.ParamByName('CODEMP').AsString := strCodEmp;
        qryGen.ParamByName('CODIGO').AsString := strCodigo;
        qryGen.ExecSQL;
      end;

      Result := True;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fApagaMovRcd]');
        Result := False;
      End;
    End;

  finally
    FreeAndNil(qryGen);
  end;
End;

class procedure TfrmFatRequisicaoCompras.pCarregaRequisicoesCompra(stlReqComp: TStringList; strNumDoc, strEspDoc, strCodEmp: String);
Var
  qryGen: TUniQuery;
Begin
  stlReqComp.Clear;

  qryGen := fCriaQuery;
  try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT AUTOINCREM');
    qryGen.SQL.Add('FROM MOVRCD');
    qryGen.SQL.Add('WHERE RCD_DOCPDV = :DOCPDV');
    qryGen.SQL.Add('  AND RCD_ESPPDV = :ESPPDV');
    qryGen.SQL.Add('  AND RCD_EMPPDV = :EMPPDV');

    qryGen.ParamByName('DOCPDV').AsString := strNumDoc;
    qryGen.ParamByName('ESPPDV').AsString := strEspDoc;
    qryGen.ParamByName('EMPPDV').AsString := strCodEmp;
    qryGen.Open;

    while not qryGen.Eof do
    begin
      stlReqComp.Add(qryGen.Fields[0].AsString);
      qryGen.Next;
    end;
  finally
    FreeAndNil(qryGen);
  end;
End;

function TfrmFatRequisicaoCompras.fRetObservacaoMovRcd(strCodIte, strDocPdv, strEspPdv, strEmpPdv: String): String;
begin
  Result := fCampoTabela('RCD_OBSERV', 'MOVRCD', ['RCD_CODITE', 'RCD_DOCPDV', 'RCD_ESPPDV', 'RCD_EMPPDV'],
                                                 [ strCodIte  ,  strDocPdv  ,  strEspPdv  ,  strEmpPdv]);
end;

function TfrmFatRequisicaoCompras.fRetornaDescricaoItemVenda(strCodIte: String): String;
begin
  If (fEhItemEspecial(strCodIte)) And (Assigned(Self.cdsVenda)) Then
  Begin
    Self.cdsVenda.Locate('ITE_CODITE', strCodIte, []);

    Result := Self.cdsVenda.FieldByName('ITE_DESITE').AsString;
  End
  Else
    Result := fRetNomProduto(strCodIte);
end;

class procedure TfrmFatRequisicaoCompras.pEnviaMensagemNovaRequisicao(strCodigoReq, strCodEmpGrv: String);
var
  strInRqCp,
  strCodEmp: String;
begin
  if fEmptyStr(strCodEmpGrv) then
    strCodEmp := VS_strCodEmp
  else
    strCodEmp := strCodEmpGrv;

  strInRqCp := fCampoTabela('AUTOINCREM', 'MOVRCG', ['RCG_CODIGO', 'RCG_CODEMP'], [strCodigoReq, strCodEmp]);
  pEnviaMsgRequisicaoIncluida(strInRqCp);
end;

class procedure TfrmFatRequisicaoCompras.pEnviaMsgRequisicaoIncluida(const strSeqGer: String);
var
  qryReq: TUniQuery;
  stlMsg: TStringList;
  strOpeAtu: String;
  blnNovoOpe: Boolean;
begin
  qryReq := fCriaQuery;
  stlMsg := TStringList.Create;
  try
    strOpeAtu := '';
    pMontaQryRequisicao(qryReq, strSeqGer);

    while not qryReq.Eof do
    begin
      blnNovoOpe := strOpeAtu <> qryReq.FieldByName('CODVEN').AsString;

      if blnNovoOpe then
        strOpeAtu := qryReq.FieldByName('CODVEN').AsString;

      pMontaMensagemInclusaoRequisicao(qryReq, blnNovoOpe, stlMsg);

      qryReq.Next;

      if (qryReq.Eof) or (strOpeAtu <> qryReq.FieldByName('CODVEN').AsString) then
        pEnviarMensagemInclusaoRequisicao(strOpeAtu, stlMsg);
    end;

  finally
    FreeAndNil(qryReq);
    FreeAndNil(stlMsg);
  end;
end;

class procedure TfrmFatRequisicaoCompras.pMontaQryRequisicao(var qryReq: TUniQuery;
  const strSeqGer: String);
begin
  qryReq.Close;
  qryReq.SQL.Clear;
  qryReq.SQl.Text := fBuscaDadosRequisicao;
  qryReq.ParamByName('AUTOINCREM').AsString := strSeqGer;
  qryReq.open;
end;

class function TfrmFatRequisicaoCompras.fBuscaDadosRequisicao: String;
begin
  Result :=
    ' SELECT                                                                '+
    '   RCG_CODVEN AS CODVEN,                                               '+
    '   OPE_NOMOPE AS NOMOPE,                                               '+
    '   RCG_CODIGO AS NUMREQ,                                               '+
    '   RCG_DTACAD AS DTACAD,                                               '+
    '   CLI_NOMCLI AS NOMCLI,                                               '+
    '   CONCAT(ITE_CODITE, " - ", ITE_DESITE) AS DESITE,                    '+
    '   ITE_REFERE AS REFERE,                                               '+
    '   UNI_SIGUNI AS SIGUNI,                                               '+
    '   RCD_QTDITE AS QTDREQ,                                               '+
    '   CONCAT(                                                             '+
    '     RCD_DOCPDV,                                                       '+
    '     "-",                                                              '+
    '     RCD_EMPPDV,                                                       '+
    '     "-",                                                              '+
    '     RCD_ESPPDV                                                        '+
    '   ) AS DOCPDV,                                                        '+
    '   IFNULL(EQUGER.EQU_NUMOSE, EQ.EQU_NUMOSE) AS EQU_NUMOSE,             '+
    '   IFNULL(EQUGER.EQU_PROTOC, EQ.EQU_PROTOC) AS EQU_PROTOC,             '+
    '   IFNULL(EQUGER.EQU_CODEMP, EQ.EQU_CODEMP) AS EQU_CODEMP,             '+
    '   CASE IFNULL(EQUGER.EQU_GARANT, EQ.EQU_GARANT)                       '+
    '     WHEN "N" THEN "Não"                                               '+
    '     WHEN "L" THEN "Garantia Loja"                                     '+
    '     WHEN "F" THEN "Garantia Fábrica"                                  '+
    '     WHEN "R" THEN "Retorno de Garantia"                               '+
    '   END AS GARANT,                                                      '+
    '   IFNULL(EQUGER.EQU_GARANT, EQ.EQU_GARANT) AS EQU_GARANT,             '+
    '   IF(C.EQU_CODIGO IS NULL, CONCAT(CE.EQU_CODIGO, "-", CE.EQU_DESCRI), '+
    '     CONCAT(C.EQU_CODIGO, "-", C.EQU_DESCRI)) AS DESEQU,               '+
    '   (SELECT                                                             '+
    '     CONCAT(OPE_CODOPE, "-", OPE_NOMOPE)                               '+
    '   FROM                                                                '+
    '     CADOPE                                                            '+
    '   WHERE OPE_CODOPE =                                                  '+
    '         IFNULL(EQUGER.EQU_CODVEN, EQ.EQU_CODVEN)) AS OSVEND,          '+
    '   RCD_QTDITE AS QTDREC                                                '+
    ' FROM                                                                  '+
    '   MOVRCG G                                                            '+
    '   INNER JOIN MOVRCD                                                   '+
    '     ON RCG_CODIGO = RCD_CODIGO                                        '+
    '   inner JOIN CADOPE                                                   '+
    '     ON OPE_CODOPE = RCG_CODVEN                                        '+
    '   INNER JOIN CADITE                                                   '+
    '     ON ITE_CODITE = RCD_CODITE                                        '+
    '   INNER JOIN CADUNI                                                   '+
    '     ON UNI_CODUNI = ITE_CODUNI                                        '+
    '   INNER JOIN CADCLI                                                   '+
    '     ON CLI_CODCLI = RCG_CODCLI                                        '+
    '   LEFT JOIN FATGOR                                                    '+
    '     ON FGO_NUMDOC = RCD_DOCPDV                                        '+
    '     AND FGO_CODEMP = RCD_EMPPDV                                       '+
    '     AND FGO_ESPDOC = RCD_ESPPDV                                       '+
    '   LEFT JOIN EQUGER ON (EQUGER.EQU_TIPPED = FATGOR.FGO_ESPDOC          '+
    '                    AND EQUGER.EQU_EMPPED = FATGOR.FGO_CODEMP          '+
    '                    AND EQUGER.EQU_NUMPED = FATGOR.FGO_NUMDOC)         '+
    '   LEFT JOIN EQUGOR ON EQUGOR.FGO_SEQFGO = FATGOR.AUTOINCREM           '+
    '   LEFT JOIN EQUGER EQ ON (EQ.AUTOINCREM = EQUGOR.FGO_SEQEQU)          '+
    '   LEFT JOIN CADEQU C ON EQUGER.EQU_CODEQU = C.EQU_CODIGO              '+
    '   LEFT JOIN CADEQU CE ON EQ.EQU_CODEQU = CE.EQU_CODIGO                '+
    ' WHERE G.AUTOINCREM = :AUTOINCREM                                      '+
    ' ORDER BY RCG_CODVEN,                                                  '+
    '   RCG_CODIGO,                                                         '+
    '   RCD_CODITE                                                          ';
end;

class procedure TfrmFatRequisicaoCompras.pCarregarOperadoresParaEnvioDeMensagem(var qryOperadores: TUniQuery);
begin
  qryOperadores.Close;
  qryOperadores.SQL.Clear;
  qryOperadores.SQL.Text := 'SELECT OPE_CODOPE AS CODOPE FROM CADOPE WHERE OPE_MSGRCI  = "S" AND IFNULL(OPE_RCITDS,"S") = "S"';
  qryOperadores.Open;
end;

procedure TfrmFatRequisicaoCompras.pConfigurarColunas;
  Var
    intIndex: Integer;

begin
  for intIndex := 0 to dbgConsulta.Columns.Count -1 do
  begin
    if IndexStr(dbgConsulta.Columns[intIndex].FieldName, ['ITE_CODFAB', 'ITE_CODMAR']) >= 0 Then
     dbgConsulta.Columns[intIndex].Width := 80;
  end;
end;

procedure TfrmFatRequisicaoCompras.pConfigurarEdtSenVen;
begin
  if blnSolicitarSenhaVendedor then
  begin
    edtSenVen.MaxLength := 10;
    edtSenVen.PasswordChar := '*';
    edtSenVen.CompZeros := False;
    edtSenVen.TamCampo := 0;
  end
  else
  begin
    edtSenVen.PasswordChar := #0;
    edtSenVen.MaxLength := 3;
    edtSenVen.TamCampo := 3;
    edtSenVen.CompZeros := True;
  end;
end;

class procedure TfrmFatRequisicaoCompras.pEnviarMensagemInclusaoRequisicao(strOpeAtu: String;
  stlMsg: TStringList);
var
  qryOperadores: TUniQuery;
  msgInt: TMsgInterna;
begin
  qryOperadores := fCriaQuery(nil);
  msgInt := TMsgInterna.Create(nil);
  try
    msgInt.fEnviaMensagem(MSG_ASSUNTO_REQUISICAO_INCLUIDA, stlMsg.Text,
      strLoginUsuarioLogado, strOpeAtu, 'N', '');

    pCarregarOperadoresParaEnvioDeMensagem(qryOperadores);

    while not qryOperadores.Eof do
    begin
      if qryOperadores.FieldByName('CODOPE').AsString <> strOpeAtu then
      begin
        msgInt.fEnviaMensagem(MSG_ASSUNTO_REQUISICAO_INCLUIDA, stlMsg.Text,
          strLoginUsuarioLogado, qryOperadores.FieldByName('CODOPE').AsString,
          'N','');
      end;
      qryOperadores.Next;
    end;

  finally
    FreeAndNil(qryOperadores);
    FreeAndNil(msgInt);
  end;
end;

class procedure TfrmFatRequisicaoCompras.pMontaMensagemInclusaoRequisicao(qryReq: TUniQuery;
  blnMontaCabecalho: Boolean; var stlMsg: TStringList);
var
  strDtaCad,
  strQtdReq: String;
begin
  if blnMontaCabecalho then
  begin
    stlMsg.Clear;
    stlMsg.Add('Caro Sr(a). '+ qryReq.FieldByName('NOMOPE').AsString);
    stlMsg.Add('');
    stlMsg.Add('Em '+ FormatDateTime('dd/mm/yyyy', VS_Date) +
      ' ocorreu inclusão de Requisição de Compra, conforme segue abaixo:');

    if not fEmptyStr(qryReq.FieldByname('EQU_NUMOSE').AsString) Then
    begin
      stlMsg.Add('Numero da Ordem de Serviço: ' + qryReq.FieldByName('EQU_NUMOSE').AsString + '-' + qryReq.FieldByName('EQU_CODEMP').AsString);
      stlMsg.Add('Protocolo.................: ' + qryReq.FieldByName('EQU_PROTOC').AsString);
      stlMsg.Add('Garantia..................: ' + qryReq.FieldByName('GARANT').AsString);
      stlMsg.Add('Vendedor..................: ' + qryReq.FieldByName('OSVEND').AsString);
      stlMsg.Add('Equipamento...............: ' + qryReq.FieldByName('DESEQU').AsString);
    end;

    stlMsg.Add('-----------------------------------------------------------------------------------------------------------------------------------------');
    stlMsg.Add('Requisição Data Cad.  Cliente                 Item                                          Ref        Un. Qtd.Requi. Pedido de Venda    ');
    stlMsg.Add('-----------------------------------------------------------------------------------------------------------------------------------------');
  end;

  strDtaCad := FormatDateTime('dd/mm/yyyy', qryReq.FieldByName('DTACAD').AsDateTime);
  strQtdReq := FormatFloat('#,##0.00', qryReq.FieldByName('QTDREQ').AsFloat);

  stlMsg.Add(fPadL(qryReq.FieldByName('NUMREQ').AsString, 10, ' ') + ' ' +
    strDtaCad  + ' ' +
    fPadR(qryReq.FieldByName('NOMCLI').AsString, 23, ' ') + ' ' +
    fPadR(qryReq.FieldByName('DESITE').AsString, 45, ' ') + ' ' +
    fPadR(qryReq.FieldByName('REFERE').AsString, 10, ' ') + ' ' +
    fPadR(qryReq.FieldByName('SIGUNI').AsString,  3, ' ') + ' ' +
    fPadL(strQtdReq, 10, ' ') + ' ' +
    fPadR(qryReq.FieldByName('DOCPDV').AsString, 19, ' '));
end;

class function TfrmFatRequisicaoCompras.fProcessarRequisicoesAvulsas(Var AstrCodigo: String; ACdsVinculos, ACdsItensPedido: TUniClientDataSet; AstrCodVen, AstrCodCli, AstrCliCgc, AstrNumDoc, AStrEspDoc, AstrEmpDoc, AStrCodDig: String; ABlnComTransacao: Boolean): Boolean;

  function fAtualizarMovRcg(AStrCodigo: String): Boolean;
  var
    qryUpd: TUniQuery;
  begin
    qryUpd := fCriaQuery;
    Try
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add('UPDATE MOVRCG SET RCG_CODCLI = :CODCLI,');
      qryUpd.SQL.Add('                  RCG_CODVEN = :CODVEN,');
      qryUpd.SQL.Add('                  RCG_DTAALT = :DTAALT ');
      qryUpd.SQL.Add('                  RCG_CODDIG = :CODDIG ');
      qryUpd.SQL.Add('            WHERE RCG_CODIGO = :CODSEQ ');
      qryUpd.SQL.Add('              AND RCG_CODEMP = :CODEMP ');

      qryUpd.ParamByName('CODCLI').AsString   := AStrCodCli;
      qryUpd.ParamByName('CODVEN').AsString   := AStrCodVen;
      qryUpd.ParamByName('DTAALT').AsDateTime := VS_Date;
      qryUpd.ParamByName('CODVEN').AsString   := AStrEspDoc;
      qryUpd.ParamByName('CODSEQ').AsString   := AStrCodigo;
      qryUpd.ParamByName('CODDIG').AsString   := AStrCodDig;

      Try
        If ABlnComTransacao Then
          fStartTransaction;

        qryUpd.ExecSQL;

        If ABlnComTransacao Then
          fCommit;

        Result := True;
      Except On
        E:Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[TfrmFatRequisicaoCompras.fProcessarRequisicoesAvulsas.fAtualizarMovRcg]');
          fRollBack;
        End;
      End;
    Finally
      FreeAndNil(qryUpd);
    End;
  End;

  function fGerarMovRcg: String;
  var
    qryIns: TUniQuery;
    strAut,
    strSeq: String;
  begin
    qryIns := fCriaQuery;
    Try
      qryIns.SQL.Clear;
      qryIns.SQL.Add('INSERT INTO MOVRCG (AUTOINCREM, ');
      qryIns.SQL.Add('                    RCG_CODIGO, ');
      qryIns.SQL.Add('                    RCG_CODEMP, ');
      qryIns.SQL.Add('                    RCG_DTACAD, ');
      qryIns.SQL.Add('                    RCG_CODVEN, ');
      qryIns.SQL.Add('                    RCG_CODCLI, ');
      qryIns.SQL.Add('                    RCG_DTAALT, ');
      qryIns.SQL.Add('                    RCG_CPFCON, ');
      qryIns.SQL.Add('                    RCG_NUMDOC, ');
      qryIns.SQL.Add('                    RCG_ESPDOC, ');
      qryIns.SQL.Add('                    RCG_SERIE_, ');
      qryIns.SQL.Add('                    RCG_CODDIG) ');
      qryIns.SQL.Add('             VALUES(:AUTOINCREM, ');
      qryIns.SQL.Add('                    :RCG_CODIGO, ');
      qryIns.SQL.Add('                    :RCG_CODEMP, ');
      qryIns.SQL.Add('                    :RCG_DTACAD, ');
      qryIns.SQL.Add('                    :RCG_CODVEN, ');
      qryIns.SQL.Add('                    :RCG_CODCLI, ');
      qryIns.SQL.Add('                    :RCG_DTAALT, ');
      qryIns.SQL.Add('                    :RCG_CPFCON, ');
      qryIns.SQL.Add('                    :RCG_NUMDOC, ');
      qryIns.SQL.Add('                    :RCG_ESPDOC, ');
      qryIns.SQL.Add('                    :RCG_SERIE_, ');
      qryIns.SQL.Add('                    :RCG_CODDIG) ');

      strAut := fRetAutoIncrem('MOVRCG', VS_StrCodEmp);
      strSeq := fAtualizaProCod('MOVRCG', 'RCG_CODIGO');
      qryIns.ParamByName('AUTOINCREM').AsString := strAut;
      qryIns.ParamByName('RCG_CODIGO').AsString := strSeq;
      qryIns.ParamByName('RCG_CODEMP').AsString := VS_strCodEmp;
      qryIns.ParamByName('RCG_DTACAD').AsDateTime := fNow;
      qryIns.ParamByName('RCG_CODVEN').AsString := AstrCodVen;
      qryIns.ParamByName('RCG_CODCLI').AsString := AstrCodCli;
      qryIns.ParamByName('RCG_DTAALT').AsDateTime := fNow;
      qryIns.ParamByName('RCG_CPFCON').AsString := AstrCliCgc;
      qryIns.ParamByName('RCG_NUMDOC').AsString := AstrNumDoc;
      qryIns.ParamByName('RCG_ESPDOC').AsString := AstrEspDoc;
      qryIns.ParamByName('RCG_SERIE_').Clear;
      qryIns.ParamByName('RCG_CODDIG').AsString := AstrCodDig;

      Try
        If ABlnComTransacao Then
          fStartTransaction;

        qryIns.ExecSQL;

        If ABlnComTransacao Then
          fCommit;

        Result := strSeq;
      Except On
        E:Exception Do
        Begin
          Result := '';
          pMensagensErro(E.Message, '[TfrmFatRequisicaoCompras.fProcessarRequisicoesAvulsas.fGerarMovRcg]');
          fRollBack;
        End;
      End;
    Finally
      FreeAndNil(qryIns);
    End;
  End;

  function fGerarMovRcd(AStrRcgCodigo, AStrAutIncPcmDet, AStrCodIte, AstrDesIte: String; AFltQtd: Double): Boolean;
  var
    qryIns: TUniQuery;
    strAut: String;
  begin
    qryIns := fCriaQuery;
    Try
      qryIns.SQL.Clear;
      qryIns.SQL.Add(' INSERT INTO MOVRCD (AUTOINCREM, ');
      qryIns.SQL.Add('                     RCD_CODIGO, ');
      qryIns.SQL.Add('                     RCD_CODEMP, ');
      qryIns.SQL.Add('                     RCD_QTDITE, ');
      qryIns.SQL.Add('                     RCD_CODITE, ');
      qryIns.SQL.Add('                     RCD_DESITE, ');
      qryIns.SQL.Add('                     RCD_SEQCOT, ');
      qryIns.SQL.Add('                     RCD_SEQPCD, ');
      qryIns.SQL.Add('                     RCD_DOCPDV, ');
      qryIns.SQL.Add('                     RCD_EMPPDV, ');
      qryIns.SQL.Add('                     RCD_ESPPDV, ');
      qryIns.SQL.Add('                     RCD_OBSERV, ');
      qryIns.SQL.Add('                     RCD_EMPDES, ');
      qryIns.SQL.Add('                     RCD_ATETRA, ');
      qryIns.SQL.Add('                     RCD_REQNEG, ');
      qryIns.SQL.Add('                     RCD_DTPREV) ');
      qryIns.SQL.Add('             VALUES(:AUTOINCREM, ');
      qryIns.SQL.Add('                    :RCD_CODIGO, ');
      qryIns.SQL.Add('                    :RCD_CODEMP, ');
      qryIns.SQL.Add('                    :RCD_QTDITE, ');
      qryIns.SQL.Add('                    :RCD_CODITE, ');
      qryIns.SQL.Add('                    :RCD_DESITE, ');
      qryIns.SQL.Add('                    :RCD_SEQCOT, ');
      qryIns.SQL.Add('                    :RCD_SEQPCD, ');
      qryIns.SQL.Add('                    :RCD_DOCPDV, ');
      qryIns.SQL.Add('                    :RCD_EMPPDV, ');
      qryIns.SQL.Add('                    :RCD_ESPPDV, ');
      qryIns.SQL.Add('                    :RCD_OBSERV, ');
      qryIns.SQL.Add('                    :RCD_EMPDES, ');
      qryIns.SQL.Add('                    :RCD_ATETRA, ');
      qryIns.SQL.Add('                    :RCD_REQNEG, ');
      qryIns.SQL.Add('                    :RCD_DTPREV) ');

      strAut := fRetAutoincrem('MOVRCD', VS_strCodEmp);
      qryIns.ParamByName('AUTOINCREM').AsString := strAut;
      qryIns.ParamByName('RCD_CODIGO').AsString := AStrRcgCodigo;
      qryIns.ParamByName('RCD_CODEMP').AsString := VS_strCodEmp;
      qryIns.ParamByName('RCD_QTDITE').AsFloat  := AFltQtd;
      qryIns.ParamByName('RCD_CODITE').AsString := AStrCodIte;
      qryIns.ParamByName('RCD_DESITE').AsString := AstrDesIte;
      qryIns.ParamByName('RCD_SEQCOT').Clear;
      qryIns.ParamByName('RCD_SEQPCD').AsString := AStrAutIncPcmDet;

      If fEmptyStr(AStrAutIncPcmDet) Then
        qryIns.ParamByName('RCD_SEQPCD').Clear;

      qryIns.ParamByName('RCD_DOCPDV').AsString := AstrNumDoc;
      qryIns.ParamByName('RCD_EMPPDV').AsString := AstrEmpDoc;
      qryIns.ParamByName('RCD_ESPPDV').AsString := AstrEspDoc;
      qryIns.ParamByName('RCD_OBSERV').Clear;
      qryIns.ParamByName('RCD_EMPDES').Clear;
      qryIns.ParamByName('RCD_ATETRA').AsInteger := 0;
      qryIns.ParamByName('RCD_REQNEG').AsString := 'N';
      qryIns.ParamByName('RCD_DTPREV').Clear;

      Try
        If ABlnComTransacao Then
          fStartTransaction;

        qryIns.ExecSQL;

        If ABlnComTransacao Then
          fCommit;
        Result := True;

        If Result Then
        Begin
          ACdsVinculos.Edit;
          ACdsVinculos.FieldByName('PCD_AUTINC').AsString := strAut;
          ACdsVinculos.Post;
        End;
      Except On
        E:Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[TfrmFatRequisicaoCompras.fProcessarRequisicoesAvulsas.fGerarMovRcd]');
          fRollBack;
        End;
      End;
    Finally
      FreeAndNil(qryIns);
    End;
  End;

var
  strRcgCodigo: String;
  strKeyFields: String;
  arrKeyValuesVariant: Variant;
begin
  Result := True;
  Try
    If fEmptyStr(AStrCodigo) Then
    Begin
      strRcgCodigo := fGerarMovRcg;
      AStrCodigo := strRcgCodigo;
    End
    Else
    Begin
      strRcgCodigo := AStrCodigo;
      fAtualizarMovRcg(strRcgCodigo);
    End;

    If (Not Assigned(ACdsVinculos)) Then
      Exit;

    ACdsVinculos.First;
    While Not ACdsVinculos.Eof Do
    Begin
      VarClear(arrKeyValuesVariant);
      if fEmptyStr(ACdsVinculos.FieldByName('DESITE').AsString) then
      begin
        strKeyFields := 'ITE_CODITE';
        arrKeyValuesVariant := VarArrayOf([ACdsVinculos.FieldByName('ITE_CODITE').AsString]);
      end
      else begin
        strKeyFields := 'ITE_CODITE;ITE_DESITE';
        arrKeyValuesVariant := VarArrayOf([ACdsVinculos.FieldByName('ITE_CODITE').AsString,
                                                  ACdsVinculos.FieldByName('DESITE').AsString]);
      end;

      If Not ACdsItensPedido.Locate(strKeyFields, arrKeyValuesVariant, []) Then
      Begin
        ACdsVinculos.Next;
        Continue;
      End;

      If Not fGerarMovRcd(strRcgCodigo,
                          ACdsVinculos.FieldByName('AUTINC').AsString,
                          ACdsVinculos.FieldByName('ITE_CODITE').AsString,
                          ACdsVinculos.FieldByName('DESITE').AsString,
                          ACdsVinculos.FieldByName('QTDITE').AsFloat) Then
        Exit(False);

      ACdsVinculos.Next;
    End;
  Finally
    If (Assigned(ACdsVinculos)) Then
    Begin
      VarClear(arrKeyValuesVariant);
      ACdsVinculos.Filtered := False;
      TCdsVinculosRequisicoes.pSalvarClientDataSet(AstrNumDoc, AStrEspDoc, AStrCodCli);
    End;
  End;
end;


End.


