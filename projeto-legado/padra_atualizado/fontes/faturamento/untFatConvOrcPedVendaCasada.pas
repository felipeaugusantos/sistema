unit untFatConvOrcPedVendaCasada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, untCadPro,
  cxDataStorage, cxEdit, cxNavigator, StrUtils, untParCalculaPrecoCusto,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, untTConfiguracao,
  cxGridTableView, cxGridDBTableView, cxGrid, EditFocus, MemDS, DBAccess, Uni,
  Datasnap.DBClient, UniClientDataSet, cxCheckBox, cxCurrencyEdit,
  cxProgressBar, untFatRequisicaoCompras, untGravarOrcamentoComoPedido, untGerarOrcamentoCompraAuto,
  untRequisicaoPedidoCompra, untLogGor, untLiberacao;

type
  TfrmFatConvOrcPedVendaCasada = class(TfrmPaiConfirma)
    pnlInformacao: TPanel;
    pnlTotais: TPanel;
    grdProdutosDBTableView: TcxGridDBTableView;
    grdProdutosLevel: TcxGridLevel;
    grdProdutos: TcxGrid;
    lblNumOrc: TLabel;
    lblCliente: TLabel;
    lblEmpresa: TLabel;
    lblDataEmissao: TLabel;
    lblValorContabil: TLabel;
    lblVendedor: TLabel;
    edtNumOrc: TEditFocus;
    lblTotalVenda: TLabel;
    cdsProdutos: TUniClientDataSet;
    dtsProdutos: TDataSource;
    cdsProdutosTEMPRO: TBooleanField;
    cdsProdutosTEMRQC: TBooleanField;
    cdsProdutosCODITE: TStringField;
    cdsProdutosDESITE: TStringField;
    cdsProdutosPRODUT: TStringField;
    cdsProdutosENTRET: TStringField;
    cdsProdutosENTFUT: TStringField;
    cdsProdutosMOTFUT: TStringField;
    cdsProdutosDESTIN: TStringField;
    cdsProdutosUNIDAD: TStringField;
    cdsProdutosTABPRE: TStringField;
    cdsProdutosQTDITE: TFloatField;
    cdsProdutosUNITAR: TFloatField;
    cdsProdutosTOTITE: TFloatField;
    cdsProdutosSALDOS: TFloatField;
    cdsProdutosSALDIS: TFloatField;
    cdsProdutosPRECOM: TFloatField;
    cdsProdutosCUSPRO: TFloatField;
    cdsProdutosAUTINC: TStringField;
    grdProdutosTEMPRO: TcxGridDBColumn;
    grdProdutosTEMRQC: TcxGridDBColumn;
    grdProdutosPRODUT: TcxGridDBColumn;
    grdProdutosDESTIN: TcxGridDBColumn;
    grdProdutosUNIDAD: TcxGridDBColumn;
    grdProdutosTABPRE: TcxGridDBColumn;
    grdProdutosQTDITE: TcxGridDBColumn;
    grdProdutosUNITAR: TcxGridDBColumn;
    grdProdutosTOTITE: TcxGridDBColumn;
    grdProdutosSALDOS: TcxGridDBColumn;
    grdProdutosSALDIS: TcxGridDBColumn;
    grdProdutosPRECOM: TcxGridDBColumn;
    grdProdutosCUSPRO: TcxGridDBColumn;
    Label3: TLabel;
    Shape1: TShape;
    cdsReqCom: TUniClientDataSet;
    cdsReqComRCD_CODITE: TStringField;
    cdsReqComRCD_DESITE: TStringField;
    cdsReqComRCD_OBSERV: TStringField;
    cdsReqComRCD_DOCPDV: TStringField;
    cdsReqComRCD_ESPPDV: TStringField;
    cdsReqComRCD_EMPPDV: TStringField;
    cdsReqComRCD_QTDITE: TFloatField;
    cdsReqComRCD_DTPREV: TDateField;
    cdsReqComITE_CODFOR: TStringField;
    btnGeraPromoc: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure edtNumOrcKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumOrcExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdProdutosPRECOMCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdProdutosCUSPROCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdProdutosPRECOMPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure grdProdutosCUSPROPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnGeraPromocClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FNomeCliente: String;
    FCodCli: String;
    FstlFornec: TStringList;
    FLiberacao : TLiberacao;
    procedure pCarregaInformacaoOrcamento(const ANumDoc: String);
    procedure pCarregaProdutosOrcamento(const AAutInc: String);
    function fRetornaDestino(const AEntRet, AEntFut, AMotFut: String): String;
    function fCalculaPrecoCusto(const ACodIte: String; const AVlrOri, AVlrPre: Double): Double;
    function fGravaProCli(const AAutInc, ACodCli: String): Boolean;
    function fGravaProEmp(const AAutInc: String): Boolean;
    function fGravaItensPromocao(const AAutInc: String): Boolean;
    function fGravaPromocao(var AAutInc, ACodPro: String; var AExistePromocao: Boolean): Boolean;
    function fGravaPromocaoVendaCasada(const AVaiGravarOrcamentoComoPedido: Boolean = True): Boolean;
    function fGravaReqCompra(const ANumPed: String; var ANumReq: String): Boolean;
    function fGravaOrcamentoComoPedido(var ANumPed: String): Boolean;
    procedure pConverteOrcamentoEmPedidoDeVenda;
    function fTemItemPraGerarPromocao: Boolean;
    function fTemItemPraGerarRequisicaoDeCompra: Boolean;
    function fGravaPedCompra(const AStrNumReq: String; var AStlListaPed: TStringList): Boolean;
    procedure pVincularRequisicaoPedidoCompra(const AStrNumReq, AStrAutIncPedGerado: String);
    procedure pAdicionarFornecedorNaLista(const AStrCodIte: String);
    function fPromocaoJaCadastrada(var AAutInc, ACodPro: String): Boolean;
    function fAlteraItensPromocao(const AAutInc: String): Boolean;
    procedure pInsereLog(const AStatus, AAutInc, AItens: String);
    function fAlteraCustoPromocaoNoOrcamento(const LCodPro: String): Boolean;
    function fCriaBackUpInformacoesOriginais(const AItens: String): Boolean;
    procedure pVoltaInformacoesOriginais;
    function fLiberaPrecoCustoMenorPrecoCompra: Boolean;
  public
    { Public declarations }
  end;

const
  NOME_CLIENTE_VENDA_CASADA = 'VENDA CASADA - CLIENTE';

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema, untFuncFat;

{$R *.dfm}

procedure TfrmFatConvOrcPedVendaCasada.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pConverteOrcamentoEmPedidoDeVenda;
end;

procedure TfrmFatConvOrcPedVendaCasada.btnGeraPromocClick(Sender: TObject);
begin
  inherited;

  if not Assigned(cdsProdutos) then
    exit;

  if not cdsProdutos.Active then
    exit;

  if cdsProdutos.RecordCount <= 0 then
    exit;

  if not fTemItemPraGerarPromocao then
    exit;

  If Not fLiberaPrecoCustoMenorPrecoCompra Then
    Exit;

  if fTemItemPraGerarRequisicaoDeCompra then
  begin

    if fMensagem('ATENÇÃO', 'A requisição não será gerada pois foi escolhido para atualizar o preço de custo do orçamento. Sendo assim, ainda ' + sLineBreak+
                     'não haverá efetivação em pedido para geração de requisição. Deseja realmente continuar?', ['&Sim', '&Não'], 1) = 2 then
      exit;
  end;

  fStartTransaction;

  try
    if (fGravaPromocaoVendaCasada(False)) Then
    begin
      fCommit;

      pMensagemOk('Promoção gerada com sucesso!');
      pCarregaInformacaoOrcamento(edtNumOrc.Text);
    end;

  except
    On E: Exception Do
    begin
      fRollBack;
      pMensagensErro(E.Message,'');
    end;
  end;

end;

procedure TfrmFatConvOrcPedVendaCasada.edtNumOrcExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtNumOrc.Text) then
    Exit;

  edtNumOrc.Text := fStrZero(edtNumOrc.Text, 12);
  pCarregaInformacaoOrcamento(edtNumOrc.Text);
end;

procedure TfrmFatConvOrcPedVendaCasada.edtNumOrcKeyPress(Sender: TObject;
  var Key: Char);
var
  LarrSel: TConsultasArray;
begin
  inherited;
  if fPesqOrcamentoNaoFaturado(Self, edtNumOrc, Nil, Key, LarrSel) then
  begin
    SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmFatConvOrcPedVendaCasada.fAlteraCustoPromocaoNoOrcamento(const LCodPro: String): Boolean;
var
  LQryPromocao: TUniQuery;
  LQryFatDor: TUniQuery;
  LItens: String;
begin
  LQryPromocao := fCriaQuery;

  try
    Result := False;
    LItens := EmptyStr;

    cdsProdutos.First;

    LQryPromocao.Close;
    LQryPromocao.SQL.Clear;
    LQryPromocao.SQL.Add('UPDATE FATDOR F                 ');
    LQryPromocao.SQL.Add('INNER JOIN EXTDOR E             ');
    LQryPromocao.SQL.Add('ON(F.AUTOINCREM = E.FDO_SEQFDO) ');
    LQryPromocao.SQL.Add('SET F.FDO_PROMOC = "S",         ');
    LQryPromocao.SQL.Add('    E.FDO_CODPRO = :CODPRO,     ');
    LQryPromocao.SQL.Add('    E.FDO_CUSCAS = :CUSCAS,     ');
    LQryPromocao.SQL.Add('    F.FDO_TOTCUS = :TOTCUS      ');
    LQryPromocao.SQL.Add('WHERE F.AUTOINCREM = :AUTINC    ');

    while not cdsProdutos.Eof do
    begin
      if cdsProdutosTEMPRO.AsBoolean = False then
      begin
        cdsProdutos.Next;
        continue;
      end;

      LQryPromocao.Close;
      LQryPromocao.ParamByName('CODPRO').AsString := LCodPro;
      LQryPromocao.ParamByName('AUTINC').AsString := cdsProdutosAUTINC.AsString;
      LQryPromocao.ParamByName('CUSCAS').AsFloat  := cdsProdutosCUSPRO.AsFloat;
      LQryPromocao.ParamByName('TOTCUS').AsFloat  := cdsProdutosCUSPRO.AsFloat * cdsProdutosQTDITE.AsFloat;
      LQryPromocao.ExecSQL;

      pIncrementaListaStr(cdsProdutosAUTINC.AsString, LItens, True);

      cdsProdutos.Next;
    end;

    if fEmptyStr(LItens) then
      exit;

    LQryFatDor := fCriarQuery('SELECT * FROM FATDOR WHERE AUTOINCREM IN('+LItens+')');

    try
      LQryFatDor.Open;

      TLogGor.strNumDoc := edtNumOrc.Text;
      TLogGor.strEspDoc := 'OR';
      TLogGor.strCodEmp := VS_strCOdEmp;
      TLogGor.pLog(LQryFatDor, 'FATDOR');
    finally
      FreeAndNil(LQryFatDor);
    end;

  finally
    FreeAndNil(LQryPromocao);
  end;
end;

function TfrmFatConvOrcPedVendaCasada.fAlteraItensPromocao(
  const AAutInc: String): Boolean;
var
  LQryPromocao: TUniQuery;
  LItens: String;
begin
  LQryPromocao := fCriaQuery;

  try
    Result := False;

    LQryPromocao.Close;
    LQryPromocao.SQL.Clear;
    LQryPromocao.SQL.Add('SELECT IPR_CODITE FROM ITEPRO WHERE IPR_SEQGER = :SEQGER');
    LQryPromocao.ParamByName('SEQGER').AsString := AAutInc;
    LQryPromocao.Open;

    if LQryPromocao.IsEmpty then
      exit;

    while not LQryPromocao.Eof do
    begin
      pIncrementaListaStr(LQryPromocao.FieldByName('IPR_CODITE').AsString, LItens, True);
      LQryPromocao.Next;
    end;

    pInsereLog('E', AAutInc, LItens);

    LQryPromocao.Close;
    LQryPromocao.SQL.Clear;
    LQryPromocao.SQL.Add('DELETE FROM ITEPRO');
    LQryPromocao.SQL.Add('WHERE IPR_SEQGER = :SEQGER');
    LQryPromocao.ParamByName('SEQGER').AsString := AAutInc;
    LQryPromocao.ExecSQL;

    Result := fGravaItensPromocao(AAutInc);
  finally
    FreeAndNil(LQryPromocao);
  end;
end;

function TfrmFatConvOrcPedVendaCasada.fCalculaPrecoCusto(
  const ACodIte: String; const AVlrOri, AVlrPre: Double): Double;
var
  qryPrecoCusto: TUniQuery;
  cpcParams: TParCalculaPrecoCusto;
begin
  qryPrecoCusto := fCriaQuery;
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao, True, True);

  try
    Result := AVlrOri;

    qryPrecoCusto.Close;
    qryPrecoCusto.SQL.Clear;
    qryPrecoCusto.SQL.Add('SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
    qryPrecoCusto.ParamByName('CODITE').AsString := ACodIte;
    qryPrecoCusto.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryPrecoCusto.Open;

    if qryPrecoCusto.IsEmpty then
      exit;

    cpcParams.curPreCom := AVlrPre;
    cpcParams.curDesF01 := qryPrecoCusto.FieldByName('ITE_DESF01').AsFloat;
    cpcParams.curDesF02 := qryPrecoCusto.FieldByName('ITE_DESF02').AsFloat;
    cpcParams.curDesF03 := qryPrecoCusto.FieldByName('ITE_DESF03').AsFloat;
    cpcParams.curDesF04 := qryPrecoCusto.FieldByName('ITE_DESF04').AsFloat;
    cpcParams.curDesF05 := qryPrecoCusto.FieldByName('ITE_DESF05').AsFloat;
    cpcParams.curDesF06 := qryPrecoCusto.FieldByName('ITE_DESF06').AsFloat;
    cpcParams.curICMSEnt:= qryPrecoCusto.FieldByName('ITE_ICMENT').AsFloat;
    cpcParams.curIPIEnt := qryPrecoCusto.FieldByName('ITE_IPIENT').AsFloat;
    cpcParams.curFrete  := qryPrecoCusto.FieldByName('ITE_FREENT').AsFloat;
    cpcParams.curAcrFin := qryPrecoCusto.FieldByName('ITE_ACRFIN').AsFloat;
    cpcParams.curSubsti := qryPrecoCusto.FieldByName('ITE_SUBSTI').AsFloat;
    cpcParams.curValFre := qryPrecoCusto.FieldByName('ITE_VALFRE').AsFloat;
    cpcParams.curDesAdb := qryPrecoCusto.FieldByName('ITE_DESADB').AsFloat;
    cpcParams.curSubFed := qryPrecoCusto.FieldByName('ITE_SUBFED').AsFloat;

    if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
    begin
      cpcParams.curTCIFCu := qryPrecoCusto.FieldByName('ITE_TCIFCU').AsFloat;
      cpcParams.curTSCust := qryPrecoCusto.FieldByName('ITE_TSCUST').AsFloat;
      cpcParams.curDePiCo := qryPrecoCusto.FieldByName('ITE_DEPICO').AsFloat;
      cpcParams.curDeICMS := qryPrecoCusto.FieldByName('ITE_DEICMS').AsFloat;
      cpcParams.curFatReg := qryPrecoCusto.FieldByName('ITE_FATREG').AsFloat;
    end
    else
    begin
      cpcParams.curTCIFCu := 0;
      cpcParams.curTSCust := 0;
      cpcParams.curDePiCo := 0;
      cpcParams.curDeICMS := 0;
      cpcParams.curFatReg := 0;
    end;

    Result := cpcParams.fCalculaPrecoCusto;
  finally
    FreeAndNil(qryPrecoCusto);
    FreeAndNil(cpcParams);
  end;
end;

procedure TfrmFatConvOrcPedVendaCasada.FormCreate(Sender: TObject);
begin
  inherited;
  cdsProdutos.CreateDataSet;
  cdsReqCom.CreateDataSet;
  FstlFornec := TStringList.Create;
  FLiberacao := TLiberacao.Create;
end;

procedure TfrmFatConvOrcPedVendaCasada.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FLiberacao);
end;

procedure TfrmFatConvOrcPedVendaCasada.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumOrc);
end;

function TfrmFatConvOrcPedVendaCasada.fPromocaoJaCadastrada(var AAutInc,
  ACodPro: String): Boolean;
var
  LQryPromocao: TUniQuery;
begin
  Result := False;
  AAutInc := EmptyStr;
  ACodPro := EmptyStr;

  LQryPromocao := fCriaQuery;

  try
    LQryPromocao.Close;
    LQryPromocao.SQL.Clear;
    LQryPromocao.SQL.Add('SELECT PRO.AUTOINCREM, PRO.PRO_CODPRO');
    LQryPromocao.SQL.Add('FROM CADPRO PRO');
    LQryPromocao.SQL.Add('INNER JOIN PROCLI CLI');
    LQryPromocao.SQL.Add('ON(PRO.AUTOINCREM = CLI.PRO_SEQGER)');
    LQryPromocao.SQL.Add('INNER JOIN PROEMP EMP');
    LQryPromocao.SQL.Add('ON(PRO.AUTOINCREM = EMP.PRO_SEQGER)');
    LQryPromocao.SQL.Add('WHERE CLI.PRO_CODCLI = :CODCLI');
    LQryPromocao.SQL.Add('AND EMP.PRO_CODEMP = :CODEMP');
    LQryPromocao.SQL.Add('AND PRO.PRO_DTAINI = CURRENT_DATE()');
    LQryPromocao.SQL.Add('AND PRO.PRO_DESPRO LIKE "'+NOME_CLIENTE_VENDA_CASADA+'%"');

    LQryPromocao.ParamByName('CODCLI').AsString := FCodCli;
    LQryPromocao.ParamByName('CODEMP').AsString := VS_strCodEmp;

    LQryPromocao.Open;

    if LQryPromocao.IsEmpty then
      Exit;

    AAutInc := LQryPromocao.FieldByName('AUTOINCREM').AsString;
    ACodPro := LQryPromocao.FieldByName('PRO_CODPRO').AsString;

    Result := True;
  finally
    FreeAndNil(LQryPromocao);
  end;
end;

function TfrmFatConvOrcPedVendaCasada.fRetornaDestino(const AEntRet, AEntFut,
  AMotFut: String): String;
begin
  Result := EmptyStr;

  if not fEmptyStr(AEntRet) then
  begin
    case AnsiIndexStr(AEntRet, ['E', 'R']) of
      0: Result := Result + 'E.';
      1: Result := Result + 'Retira';
    end;
  end;

  if AEntRet = 'E' then
  begin
    if not fEmptyStr(AEntFut) then
    begin
      case AnsiIndexText(AEntFut, ['S', 'N']) of
        0: Result := Result + 'F';
        1: Result := Result + 'I';
      end;
    end;

    if AEntFut = 'S' then
    begin
      if not fEmptyStr(AMotFut) then
      begin
        case AnsiIndexStr(AMotFut, ['F', 'A', 'P']) of
          0: Result := Result + '-FAL';
          1: Result := Result + '-A.CLI';
          2: Result := Result + '-P.ENT';
        end;
      end;
    end;
  end;

end;

function TfrmFatConvOrcPedVendaCasada.fTemItemPraGerarPromocao: Boolean;
begin
  Result := False;

  cdsProdutos.First;

  while not cdsProdutos.Eof do
  begin
    if cdsProdutosTEMPRO.AsBoolean then
    begin
      Result := True;
      exit;
    end;
    cdsProdutos.Next;
  end;
end;

function TfrmFatConvOrcPedVendaCasada.fTemItemPraGerarRequisicaoDeCompra: Boolean;
begin
  Result := False;

  cdsProdutos.First;

  while not cdsProdutos.Eof do
  begin
    if cdsProdutosTEMRQC.AsBoolean then
    begin
      Result := True;
      exit;
    end;
    cdsProdutos.Next;
  end;
end;

function TfrmFatConvOrcPedVendaCasada.fGravaItensPromocao(
  const AAutInc: String): Boolean;
Var
  objGravaItePro: TGravaItePro;
  intItensAdicionados: integer;
  LItens: String;
begin
  objGravaItePro := TGravaItePro.Create;
  intItensAdicionados := 0;
  LItens := EmptyStr;

  try
    Result := False;

    pVoltaInformacoesOriginais;

    cdsProdutos.First;

    while not cdsProdutos.Eof do
    begin
      if cdsProdutosTEMPRO.AsBoolean = False then
      begin
        cdsProdutos.Next;
        continue;
      end;

      objGravaItePro.AddItem(cdsProdutosCODITE.AsString,
                             '0',
                             cdsProdutosQTDITE.AsString,
                             cdsProdutosCUSPRO.AsFloat,
                             cdsProdutosUNITAR.AsFloat,
                             0,
                             0,
                             0,
                             0,
                             0,
                             cdsProdutosUNITAR.AsFloat,
                             cdsProdutosUNITAR.AsFloat,
                             cdsProdutosUNITAR.AsFloat,
                             cdsProdutosUNITAR.AsFloat,
                             cdsProdutosUNITAR.AsFloat,
                             cdsProdutosUNITAR.AsFloat,
                             0,
                             0,
                             0,
                             '',
                             0,
                             False);

      Inc(intItensAdicionados);

      pIncrementaListaStr(cdsProdutosCODITE.AsString, LItens, True);

      cdsProdutos.Next;
    end;

    objGravaItePro.SequencialPromocao := AAutInc;

    Result := ((intItensAdicionados > 0) and (objGravaItePro.Gravar));

    if Result then
      Result := fCriaBackUpInformacoesOriginais(LItens);

    if Result then
      pInsereLog('I', AAutInc, LItens);
  finally
    FreeAndNil(objGravaItePro);
  end;
end;

function TfrmFatConvOrcPedVendaCasada.fGravaOrcamentoComoPedido(var ANumPed: String): Boolean;
var
  objGravarDoc: TGravarOrcamentoComoPedido;
  intIndice: integer;
begin
  objGravarDoc := TGravarOrcamentoComoPedido.Create(Self);

  try
    Result := False;
    ANumPed := EmptyStr;

    objGravarDoc.objVenda.blnSolicitouFecharOREmPD := True;
    untFuncFat.blnExibeTravas := False;

    objGravarDoc.strNumOrc := edtNumOrc.Text;
    objGravarDoc.strEmpOrc := VS_strCodEmp;
    objGravarDoc.blnOrigemCrm := False;

    if not objGravarDoc.fCarregarOrcamento then
      exit;

    If objGravarDoc.fCarregarMatrizItens       And
       objGravarDoc.fCalcularTotalVenda(False) And
       objGravarDoc.fValidacoesFinanceiras     And
       objGravarDoc.fItensSemEstoqueParaCorte  And
       objGravarDoc.fPedeLojasTE               And
       objGravarDoc.fPedeLojasColorantesTE     And
       objGravarDoc.fDigitarDadosPedido        And
       objGravarDoc.fDigitarDadosPedidoCompra  And
       objGravarDoc.fValidarEstoque            And
       objGravarDoc.fDefineAbastecimentoItens  And
       objGravarDoc.fCalcularTotalVenda(False) Then
    begin
      for intIndice := 0 to Length(objGravarDoc.objVenda.arrMatItens) - 1 do
      begin
        if (cdsProdutos.Locate('CODITE', objGravarDoc.objVenda.arrMatItens[intIndice].strCodIte, [])) then
        begin
          if cdsProdutosTEMPRO.AsBoolean then
          begin
            objGravarDoc.objVenda.arrMatItens[intIndice].strPromoc := 'S';
            objGravarDoc.objVenda.arrMatItens[intIndice].fltPreCus := cdsProdutosCUSPRO.AsFloat;
          end;
        end;
      end;

      objGravarDoc.objVenda.blnEhPedidoVendaCasada := True;

      if (objGravarDoc.fCalcularTotalVenda(False)) and (objGravarDoc.fGravarPedido) then
      begin
        ANumPed := objGravarDoc.objVenda.strNumDoc;
        Result := True;
      end;
    end;
  finally
    FreeAndNil(objGravarDoc);
  end;
end;

function TfrmFatConvOrcPedVendaCasada.fGravaProCli(const AAutInc,
  ACodCli: String): Boolean;
var
  qryProCli: TUniQuery;
begin
  qryProCli := fCriaQuery;

  try
    Result := False;

    qryProCli.Close;
    qryProCli.SQL.Clear;
    qryProCli.SQL.Add('INSERT INTO PROCLI(PRO_SEQGER, PRO_CODCLI) VALUES(:SEQGER, :CODCLI)');
    qryProCli.ParamByName('SEQGER').AsString := AAutInc;
    qryProCli.ParamByName('CODCLI').AsString := ACodCli;
    qryProCli.ExecSQL;

    Result := True;
  finally
    FreeAndNil(qryProCli);
  end;
end;

function TfrmFatConvOrcPedVendaCasada.fGravaProEmp(const AAutInc: String): Boolean;
var
  qryProEmp: TUniQuery;
begin
  qryProEmp := fCriaQuery;

  try
    Result := False;

    qryProEmp.Close;
    qryProEmp.SQL.Clear;
    qryProEmp.SQL.Add('INSERT INTO PROEMP(PRO_SEQGER, PRO_CODEMP) VALUES(:SEQGER, :CODEMP)');
    qryProEmp.ParamByName('SEQGER').AsString := AAutInc;
    qryProEmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryProEmp.ExecSQL;

    Result := True;
  finally
    FreeAndNil(qryProEmp);
  end;
end;

function TfrmFatConvOrcPedVendaCasada.fGravaPromocao(var AAutInc, ACodPro: String; var AExistePromocao: Boolean): Boolean;
var
  qryPromocao: TUniQuery;
begin
  qryPromocao := fCriaQuery;

  try
    Result := False;

    AExistePromocao := fPromocaoJaCadastrada(AAutInc, ACodPro);

    if AExistePromocao then
    begin
      Result := True;
      Exit;
    end;

    qryPromocao.Close;
    qryPromocao.SQL.Clear;
    qryPromocao.SQL.Add('INSERT INTO CADPRO(AUTOINCREM, PRO_CODPRO, PRO_CODEMP, PRO_DTAINI, PRO_DTAFIN,');
    qryPromocao.SQL.Add('                   PRO_PREDES, PRO_DESADI, PRO_ENTIME, PRO_ENTFUT, PRO_AGUCLI,');
    qryPromocao.SQL.Add('                   PRO_PREVIS, PRO_FALPRO, PRO_ECOMME, PRO_TABPRE, PRO_COMPRO,');
    qryPromocao.SQL.Add('                   PRO_IDXQTD, PRO_UTILIM, PRO_LIMCLI, PRO_LIMVEN, PRO_DESPRO,');
    qryPromocao.SQL.Add('                   PRO_IDXPRO)');
    qryPromocao.SQL.Add('VALUES(:AUTINC, :CODPRO, :CODEMP, :DTAINI, :DTAFIN,');
    qryPromocao.SQL.Add('"P", "N", "S", "S", "S", ');
    qryPromocao.SQL.Add('"S", "S", "N", "SSSSSSS", "P",');
    qryPromocao.SQL.Add('0, "N", "N", "N", :DESPRO,');
    qryPromocao.SQL.Add('0)');

    AAutInc := fRetAutoIncrem('CADPRO', VS_strCodEmp);
    ACodPro := fAtualizaProCod('CADPRO', 'PRO_CODPRO', '', 1, Nil,
      function (const AValue : String) : String
      begin
        Result := Concat(VS_strCodEmp, AValue);
      end
    );

    qryPromocao.ParamByName('AUTINC').AsString := AAutInc;
    qryPromocao.ParamByName('CODPRO').AsString := ACodPro;
    qryPromocao.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryPromocao.ParamByName('DTAINI').AsDate := fRetDataServidor;
    qryPromocao.ParamByName('DTAFIN').AsDate := fRetDataServidor;
    qryPromocao.ParamByName('DESPRO').AsString := NOME_CLIENTE_VENDA_CASADA + ' ' + FNomeCliente;

    qryPromocao.ExecSQL;

    Result := True;
  finally
    FreeAndNil(qryPromocao);
  end;
end;

function TfrmFatConvOrcPedVendaCasada.fGravaPromocaoVendaCasada(const AVaiGravarOrcamentoComoPedido: Boolean = True): Boolean;
var
  LAutInc: String;
  LCodPro: String;
  LExistePromocao: Boolean;
begin
  Result := False;

  if not fTemItemPraGerarPromocao then
    exit(True);

  if not fGravaPromocao(LAutInc, LCodPro, LExistePromocao) then
    exit;

  if LExistePromocao then
  begin
    if not fAlteraItensPromocao(LAutInc) then
      exit;
  end
  else
  begin
    if not fGravaItensPromocao(LAutInc) then
      exit;

    if not fGravaProEmp(LAutInc) then
      exit;

    if not fGravaProCli(LAutInc, FCodCli) then
      exit;
  end;

  if not AVaiGravarOrcamentoComoPedido then
    fAlteraCustoPromocaoNoOrcamento(LCodPro);

  Result := True;
end;

function TfrmFatConvOrcPedVendaCasada.fGravaReqCompra(const ANumPed: String; var ANumReq: String): Boolean;
var
  strDocCli: String;
begin
  Result := False;

  ANumReq := EmptyStr;

  if not fTemItemPraGerarRequisicaoDeCompra then
    exit(True);

  if fEmptyStr(ANumPed) then
    exit;

  cdsReqCom.EmptyDataSet;
  cdsProdutos.First;

  while not cdsProdutos.Eof do
  begin
    if cdsProdutosTEMRQC.AsBoolean = False then
    begin
      cdsProdutos.Next;
      continue;
    end;

    cdsReqCom.Append;
    cdsReqCom.FieldByName('RCD_CODITE').AsString := cdsProdutosCODITE.AsString;
    cdsReqCom.FieldByName('RCD_DESITE').AsString := cdsProdutosDESITE.AsString;
    cdsReqCom.FieldByName('RCD_DOCPDV').AsString := ANumPed;
    cdsReqCom.FieldByName('RCD_ESPPDV').AsString := 'PD';
    cdsReqCom.FieldByName('RCD_EMPPDV').AsString := VS_strCodEmp;
    cdsReqCom.FieldByName('RCD_QTDITE').AsFloat  := cdsProdutosQTDITE.AsFloat;
    cdsReqCom.FieldByName('ITE_CODFOR').AsString := fCampoTabela('ITE_CODFOR','CADITE', ['ITE_CODITE'], [cdsProdutosCODITE.AsString]);
    cdsReqCom.Post;

    cdsProdutos.Next;
  end;

  if cdsReqCom.RecordCount <= 0 then
    exit;

  strDocCli := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [FCodCli], False);

  Result := TfrmFatRequisicaoCompras.fGravaRequisicaoCompra(ANumReq, FCodCli, strLoginUsuarioLogado, strDocCli, cdsReqCom, False);

end;

function TfrmFatConvOrcPedVendaCasada.fLiberaPrecoCustoMenorPrecoCompra: Boolean;
  Var
    blnLiberacao: Boolean;
begin
  blnLiberacao := False;

  FLiberacao.Clear;
  FLiberacao.objMsgLibera.pAddTexto('Valor do preço de custo menor que o preço de compra líquido!');
  FLiberacao.objMsgLibera.pAddSeparador(70);

  cdsProdutos.First;
  While Not cdsProdutos.Eof Do
  Begin
    If (cdsProdutos.FieldByName('TEMPRO').AsBoolean) And (cdsProdutos.FieldByName('CUSPRO').AsFloat < cdsProdutos.FieldByName('PRECOM').AsFloat) Then
    Begin
      blnLiberacao := True;

      FLiberacao.objMsgLibera.pAddTextoCaption('Produto'            , cdsProdutos.FieldByName('PRODUT').AsString                             , 12);
      FLiberacao.objMsgLibera.pAddTextoCaption('Pr. Ped. Compra'    , FloatToStrF(cdsProdutos.FieldByName('PRECOM').AsFloat, ffFixed, 12, 2) , 12);
      FLiberacao.objMsgLibera.pAddTextoCaption('Pr. Custo Promoção' , FloatToStrF(cdsProdutos.FieldByName('CUSPRO').AsFloat, ffFixed, 12, 2) , 12);
      FLiberacao.objMsgLibera.pAddSeparador(70);
    End;
    cdsProdutos.Next;
  End;

  FLiberacao.strDirAce := 'PVCPPC';
  FLiberacao.strMsgSen := 'Valor do preço de custo menor que o preço de compra líquido!';
  FLiberacao.strCodOpe := strLoginUsuarioLogado;

  If blnLiberacao Then
    Result := FLiberacao.fLibera
  Else
    Result := True;
end;

procedure TfrmFatConvOrcPedVendaCasada.grdProdutosCUSPROCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdProdutosTEMPRO.Index] = True then
  begin
    ACanvas.Font.Color := clBlack;
    ACanvas.Brush.Color := clYellow;
  end;
end;

procedure TfrmFatConvOrcPedVendaCasada.grdProdutosCUSPROPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if not Assigned(cdsProdutos) then
    exit;

  if cdsProdutos.RecordCount <= 0 then
    exit;

  if cdsProdutos.RecNo <= 0 then
    exit;

  if cdsProdutosTEMPRO.AsBoolean = False then
  begin
    DisplayValue := cdsProdutosCUSPRO.AsFloat;
    exit;
  end;
end;

procedure TfrmFatConvOrcPedVendaCasada.grdProdutosPRECOMCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdProdutosTEMRQC.Index] = True then
  begin
    ACanvas.Font.Color := clBlack;
    ACanvas.Brush.Color := clYellow;
  end;
end;

procedure TfrmFatConvOrcPedVendaCasada.grdProdutosPRECOMPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if not Assigned(cdsProdutos) then
    exit;

  if cdsProdutos.RecordCount <= 0 then
    exit;

  if cdsProdutos.RecNo <= 0 then
    exit;

  if cdsProdutosTEMRQC.AsBoolean = False then
  begin
    DisplayValue := cdsProdutosPRECOM.AsFloat;
    exit;
  end;

  cdsProdutos.Edit;
  cdsProdutosPRECOM.AsFloat := DisplayValue;
  cdsProdutosCUSPRO.AsFloat := fCalculaPrecoCusto(cdsProdutosCODITE.AsString, cdsProdutosCUSPRO.AsFloat, cdsProdutosPRECOM.AsFloat);
  cdsProdutos.Post;
end;

procedure TfrmFatConvOrcPedVendaCasada.pCarregaInformacaoOrcamento(const ANumDoc: String);
var
  LOrcamento: TUniQuery;
begin
  LOrcamento := fCriaQuery;

  try
    cdsProdutos.EmptyDataSet;

    LOrcamento.Close;
    LOrcamento.SQL.Clear;
    LOrcamento.SQL.Add('SELECT AUTOINCREM, FGO_NUMDOC, FGO_CODEMP, FGO_DTAENT, FGO_VLRCON, FGO_CODCLI, FGO_CODVEN, FGO_TOTPRO');
    LOrcamento.SQL.Add('FROM FATGOR');
    LOrcamento.SQL.Add('WHERE FGO_ESPDOC = "OR"');
    LOrcamento.SQL.Add('AND FGO_CODEMP = '+QuotedStr(VS_strCodEmp)+'');
    LOrcamento.SQL.Add('AND FGO_NUMDOC = :NUMDOC');
    LOrcamento.SQL.Add('AND FGO_DTAFAT IS NULL');
    LOrcamento.SQL.Add('AND IFNULL(FGO_JAFATU, 0) = 0');
    LOrcamento.SQL.Add('AND IFNULL(FGO_NUMFAT, "") = ""');
    LOrcamento.SQL.Add('AND IFNULL(FGO_TIPFAT, "") = ""');
    LOrcamento.ParamByName('NUMDOC').AsString := ANumDoc;
    LOrcamento.Open;


    if LOrcamento.RecordCount <= 0 then
    begin
      pMensagemOk('Orçamento não encontrado!');
      edtNumOrc.Clear;
      pSetFocus(edtNumOrc);
      Exit;
    end;

    FCodCli := LOrcamento.FieldByName('FGO_CODCLI').AsString;
    FNomeCliente := fRetNomCliente(FCodCli);

    lblEmpresa.Caption := 'Emp. : ' + LOrcamento.FieldByName('FGO_CODEMP').AsString;
    lblCliente.Caption :=  'Cliente: ' + FCodCli + ' - ' + FNomeCliente;
    lblDataEmissao.Caption := 'Dt. Emissão: ' + FormatDatetime('dd/mm/yyyy', LOrcamento.FieldByName('FGO_DTAENT').AsDateTime);
    lblValorContabil.Caption := 'Vr. Contábil: ' + FormatFloat('#,###,##0.00', LOrcamento.FieldByName('FGO_VLRCON').AsFloat);
    lblVendedor.Caption := 'Vendedor: ' + LOrcamento.FieldByName('FGO_CODVEN').AsString + ' - ' + fRetNomeOperador(LOrcamento.FieldByName('FGO_CODVEN').AsString);
    lblTotalVenda.Caption := 'Total Venda: ' + FormatFloat('#,###,##0.00', LOrcamento.FieldByName('FGO_TOTPRO').AsFloat);

    pCarregaProdutosOrcamento(LOrcamento.FieldByName('AUTOINCREM').AsString);
  finally
    FreeAndNil(LOrcamento);
  end;
end;

procedure TfrmFatConvOrcPedVendaCasada.pCarregaProdutosOrcamento(
  const AAutInc: String);
var
  LProdutos: TUniQuery;

begin
  LProdutos := fCriaQuery;

  try
    cdsProdutos.DisableControls;
    cdsProdutos.EmptyDataSet;

    LProdutos.Close;
    LProdutos.SQL.Clear;
    LProdutos.SQL.Add('SELECT F.AUTOINCREM, F.FDO_CODITE, F.FDO_DESCRI, F.FDO_QTDITE, F.FDO_UNITAR, F.FDO_TOTITE,');
    LProdutos.SQL.Add('       F.FDO_TABPRE, F.FDO_ENTFUT, F.FDO_MOTFUT, E.FDO_ENTRET, U.UNI_SIGUNI, F.FDO_NUMLOT, E.FDO_CUSCAS');
    LProdutos.SQL.Add('FROM FATDOR F');
    LProdutos.SQL.Add('INNER JOIN EXTDOR E');
    LProdutos.SQL.Add('ON(F.AUTOINCREM = E.FDO_SEQFDO)');
    LProdutos.SQL.Add('LEFT JOIN CADUNI U');
    LProdutos.SQL.Add('ON(F.FDO_UNIDAD = U.UNI_CODUNI)');
    LProdutos.SQL.Add('WHERE F.FDO_SEQGER = :AUTINC');

    LProdutos.ParamByName('AUTINC').AsString := AAutInc;

    LProdutos.Open;

    if LProdutos.IsEmpty then
    begin
      pMensagemOk('Orçamento não encontrado!');
      edtNumOrc.Clear;
      pSetFocus(edtNumOrc);
      Exit;
    end;

    while not LProdutos.Eof do
    begin
      cdsProdutos.Append;
      cdsProdutosTEMPRO.AsBoolean := IIF(LProdutos.FieldByName('FDO_CUSCAS').AsFloat > 0, True, False);
      cdsProdutosTEMRQC.AsBoolean := False;
      cdsProdutosCODITE.AsString := LProdutos.FieldByName('FDO_CODITE').AsString;
      cdsProdutosDESITE.AsString := LProdutos.FieldByName('FDO_DESCRI').AsString;
      cdsProdutosPRODUT.AsString := LProdutos.FieldByName('FDO_CODITE').AsString + '-' + LProdutos.FieldByName('FDO_DESCRI').AsString;
      cdsProdutosENTRET.AsString := LProdutos.FieldByName('FDO_ENTRET').AsString;
      cdsProdutosENTFUT.AsString := LProdutos.FieldByName('FDO_ENTFUT').AsString;
      cdsProdutosMOTFUT.AsString := LProdutos.FieldByName('FDO_MOTFUT').AsString;
      cdsProdutosDESTIN.AsString := fRetornaDestino(LProdutos.FieldByName('FDO_ENTRET').AsString, LProdutos.FieldByName('FDO_ENTFUT').AsString, LProdutos.FieldByName('FDO_MOTFUT').AsString);
      cdsProdutosUNIDAD.AsString := LProdutos.FieldByName('UNI_SIGUNI').AsString;
      cdsProdutosTABPRE.AsString := LProdutos.FieldByName('FDO_TABPRE').AsString;
      cdsProdutosQTDITE.AsFloat := LProdutos.FieldByName('FDO_QTDITE').AsFloat;
      cdsProdutosUNITAR.AsFloat := LProdutos.FieldByName('FDO_UNITAR').AsFloat;
      cdsProdutosTOTITE.AsFloat := LProdutos.FieldByName('FDO_TOTITE').AsFloat;
      cdsProdutosSALDOS.AsFloat := fRetornaSaldoFisico(LProdutos.FieldByName('FDO_CODITE').AsString);
      cdsProdutosSALDIS.AsFloat := fRetornaSaldoDisponivel(LProdutos.FieldByName('FDO_CODITE').AsString);
      cdsProdutosPRECOM.AsFloat := fCampoTabela('ITE_PRECOM', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [LProdutos.FieldByName('FDO_CODITE').AsString, VS_strCodEmp], False);
      cdsProdutosCUSPRO.AsFloat := IIF(LProdutos.FieldByName('FDO_CUSCAS').AsFloat > 0, LProdutos.FieldByName('FDO_CUSCAS').AsFloat, fCampoTabela('ITE_PRECUS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [LProdutos.FieldByName('FDO_CODITE').AsString, VS_strCodEmp], False));
      cdsProdutosAUTINC.AsString := LProdutos.FieldByName('AUTOINCREM').AsString;
      cdsProdutos.Post;

      pAdicionarFornecedorNaLista(cdsProdutosCODITE.AsString);

      LProdutos.Next;
    end;

    if not cdsProdutos.IsEmpty then
      cdsProdutos.First;
  finally
    FreeAndNil(LProdutos);
    cdsProdutos.EnableControls;
  end;
end;

procedure TfrmFatConvOrcPedVendaCasada.pConverteOrcamentoEmPedidoDeVenda;
var
  LNumPed: String;
  LNumReq: String;
  LStlNumPedCom: TStringList;
  LMensagem: String;
begin
  if not Assigned(cdsProdutos) then
    exit;

  if not cdsProdutos.Active then
    exit;

  if cdsProdutos.RecordCount <= 0 then
    exit;

  If Not fLiberaPrecoCustoMenorPrecoCompra Then
    Exit;

  fStartTransaction;

  LStlNumPedCom := TStringList.Create;

  try
    if (fGravaPromocaoVendaCasada) and
       (fGravaOrcamentoComoPedido(LNumPed)) and
       (fGravaReqCompra(LNumPed, LNumReq)) and
       (fGravaPedCompra(LNumReq, LStlNumPedCom)) then
    begin
      fCommit;
      LMensagem := 'Pedido '+LNumPed+' gravado com sucesso!';

      if not fEmptyStr(LNumReq) then
        LMensagem := LMensagem + sLineBreak + 'Requisição de compra Nº '+LNumReq+' gravado com sucesso!';

      if LStlNumPedCom.Count > 0 then
        LMensagem := LMensagem + sLineBreak + 'Pedido de compra Nº '+LStlNumPedCom.CommaText+' gravado com sucesso!';

      pMensagemOk(LMensagem);
    end
    else
    begin
      fRollBack;
      pMensagemOk('Erro ao gravar o pedido!');
    end;

  except
    On E: Exception Do
    begin
      fRollBack;
      pMensagensErro(E.Message,'');
    end;
  end;
end;

function TfrmFatConvOrcPedVendaCasada.fCriaBackUpInformacoesOriginais(
  const AItens: String): Boolean;
var
  LQryItens: TUniQuery;
  LQryBkp: TUniQuery;
  LAutInc: String;
begin
  Result := False;

  if fEmptyStr(AItens) then
    exit;

  LQryItens := fCriaQuery;
  LQryBkp := fCriaQuery;

  try
    LAutInc := fCampoTabela('FDO_SEQGER', 'FATDOR', ['AUTOINCREM'], [cdsProdutosAUTINC.AsString], False);

    LQryItens.Close;
    LQryItens.SQL.Clear;
    LQryItens.SQL.Add('SELECT F.AUTOINCREM, F.FDO_PROMOC, E.FDO_CODPRO');
    LQryItens.SQL.Add('FROM FATDOR F');
    LQryItens.SQL.Add('INNER JOIN EXTDOR E');
    LQryItens.SQL.Add('ON(F.AUTOINCREM = E.FDO_SEQFDO)');
    LQryItens.SQL.Add('WHERE F.FDO_SEQGER = :AUTINC');
    LQryItens.SQL.Add('AND F.FDO_CODITE IN('+AItens+')');
    LQryItens.ParamByName('AUTINC').AsString := LAutInc;
    LQryItens.Open;

    if LQryItens.IsEmpty then
      exit;

    LQryBkp.Close;
    LQryBkp.SQL.Clear;
    LQryBkp.SQL.Add('INSERT INTO PROORI(ORI_SEQFDO, ORI_PROMOC, ORI_CODPRO)');
    LQryBkp.SQL.Add('VALUES(:SEQFDO, :PROMOC, :CODPRO)');

    LQryItens.First;

    while not LQryItens.Eof do
    begin
      LQryBkp.Close;
      LQryBkp.ParamByName('SEQFDO').AsString := LQryItens.FieldByName('AUTOINCREM').AsString;
      LQryBkp.ParamByName('PROMOC').AsString := LQryItens.FieldByName('FDO_PROMOC').AsString;
      LQryBkp.ParamByName('CODPRO').AsString := LQryItens.FieldByName('FDO_CODPRO').AsString;
      LQryBkp.ExecSQL;

      LQryItens.Next;
    end;

    Result := True;
  finally
    FreeAndNil(LQryItens);
    FreeAndNil(LQryBkp);
  end;
end;

procedure TfrmFatConvOrcPedVendaCasada.pInsereLog(const AStatus, AAutInc,
  AItens: String);
var
  LQryPromocao: TUniQuery;
  LQryLog: TUniQuery;
begin
  LQryPromocao := fCriaQuery;
  LQryLog := fCriaQuery;

  try
    LQryPromocao.Close;
    LQryPromocao.SQL.Clear;
    LQryPromocao.SQL.Add('SELECT IPR_CODITE, IPR_PRECUS, IPR_PREVEN, IPR_COMVAR, IPR_PRZMED, IPR_COMATA,');
    LQryPromocao.SQL.Add('       IPR_QTDLIM, IPR_PERDES, IPR_QTDMIN, IPR_COMDIS, IPR_PREVE2, IPR_PREVE3,');
    LQryPromocao.SQL.Add('       IPR_PREVE4, IPR_PREVE5, IPR_PREVE6, IPR_PREVE7, IPR_PEREST,');
    LQryPromocao.SQL.Add('       PRO_CODPRO, PRO_TABPRE, PRO_DESPRO, PRO_DTAINI, PRO_DTAFIN,');
    LQryPromocao.SQL.Add('       PRO_COMPRO, PRO_IDXQTD, PRO_ENTIME, PRO_ENTFUT, PRO_TABLOI');
    LQryPromocao.SQL.Add('FROM CADPRO');
    LQryPromocao.SQL.Add('INNER JOIN ITEPRO');
    LQryPromocao.SQL.Add('ON(CADPRO.AUTOINCREM = IPR_SEQGER)');
    LQryPromocao.SQL.Add('WHERE CADPRO.AUTOINCREM = :AUTINC');
    LQryPromocao.SQL.Add('AND IPR_CODITE IN('+AItens+')');
    LQryPromocao.ParamByName('AUTINC').AsString := AAutInc;
    LQryPromocao.Open;

    if LQryPromocao.IsEmpty then
      exit;

    LQryLog.Close;
    LQryLog.SQL.Clear;
    LQryLog.SQL.Add('INSERT INTO LOGIPR(AUTOINCREM, IPR_CODPRO, IPR_DTALOG, IPR_HORLOG, IPR_CODVEN, IPR_STATUS, ');
    LQryLog.SQL.Add('                   IPR_CODEMP, IPR_CODITE, IPR_PRECUS, IPR_PREVEN, IPR_COMVAR, IPR_PRZMED, ');
    LQryLog.SQL.Add('                   IPR_COMATA, IPR_QTDLIM, IPR_PERDES, IPR_QTDMIN, IPR_COMDIS, IPR_TABPRE, ');
    LQryLog.SQL.Add('                   IPR_PREVE2, IPR_PREVE3, IPR_PREVE4, IPR_PREVE5, IPR_PREVE6, ');
    LQryLog.SQL.Add('                   IPR_PREVE7, IPR_PEREST, IPR_DESPRO, IPR_DTAINI, IPR_DTAFIN, ');
    LQryLog.SQL.Add('                   IPR_COMPRO, IPR_IDXQTD, IPR_ENTIME, IPR_ENTFUT, IPR_TABLOI)');
    LQryLog.SQL.Add('VALUES(:AUTINC, :CODPRO, :DTALOG, :HORLOG, :CODVEN, :STATUS, ');
    LQryLog.SQL.Add('       :CODEMP, :CODITE, :PRECUS, :PREVEN, :COMVAR, :PRZMED, ');
    LQryLog.SQL.Add('       :COMATA, :QTDLIM, :PERDES, :QTDMIN, :COMDIS, :TABPRE, ');
    LQryLog.SQL.Add('       :PREVE2, :PREVE3, :PREVE4, :PREVE5, :PREVE6, ');
    LQryLog.SQL.Add('       :PREVE7, :PEREST, :DESPRO, :DTAINI, :DTAFIN, ');
    LQryLog.SQL.Add('       :COMPRO, :IDXQTD, :ENTIME, :ENTFUT, :TABLOI)');

    LQryPromocao.First;

    while not LQryPromocao.Eof do
    begin
      LQryLog.Close;
      LQryLog.ParamByName('AUTINC').AsString := fRetAutoIncrem('LOGIPR', VS_strCodEmp);
      LQryLog.ParamByName('CODPRO').AsString := LQryPromocao.FieldByName('PRO_CODPRO').AsString;
      LQryLog.ParamByName('DTALOG').AsDate := fRetDataServidor;
      LQryLog.ParamByName('HORLOG').AsTime := fRetHoraServidor;
      LQryLog.ParamByName('CODVEN').AsString := strLoginUsuarioLogado;
      LQryLog.ParamByName('STATUS').AsString := AStatus;
      LQryLog.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQryLog.ParamByName('CODITE').AsString := LQryPromocao.FieldByName('IPR_CODITE').AsString;
      LQryLog.ParamByName('PRECUS').AsFloat := LQryPromocao.FieldByName('IPR_PRECUS').AsFloat;
      LQryLog.ParamByName('PREVEN').AsFloat := LQryPromocao.FieldByName('IPR_PREVEN').AsFloat;
      LQryLog.ParamByName('COMVAR').AsFloat := LQryPromocao.FieldByName('IPR_COMVAR').AsFloat;
      LQryLog.ParamByName('PRZMED').AsInteger := LQryPromocao.FieldByName('IPR_PRZMED').AsInteger;
      LQryLog.ParamByName('COMATA').AsFloat := LQryPromocao.FieldByName('IPR_COMATA').AsFloat;
      LQryLog.ParamByName('QTDLIM').AsFloat := LQryPromocao.FieldByName('IPR_QTDLIM').AsFloat;
      LQryLog.ParamByName('PERDES').AsFloat := LQryPromocao.FieldByName('IPR_PERDES').AsFloat;
      LQryLog.ParamByName('QTDMIN').AsFloat := LQryPromocao.FieldByName('IPR_QTDMIN').AsFloat;
      LQryLog.ParamByName('COMDIS').AsFloat := LQryPromocao.FieldByName('IPR_COMDIS').AsFloat;
      LQryLog.ParamByName('TABPRE').AsString := LQryPromocao.FieldByName('PRO_TABPRE').AsString;
      LQryLog.ParamByName('PREVE2').AsFloat := LQryPromocao.FieldByName('IPR_PREVE2').AsFloat;
      LQryLog.ParamByName('PREVE3').AsFloat := LQryPromocao.FieldByName('IPR_PREVE3').AsFloat;
      LQryLog.ParamByName('PREVE4').AsFloat := LQryPromocao.FieldByName('IPR_PREVE4').AsFloat;
      LQryLog.ParamByName('PREVE5').AsFloat := LQryPromocao.FieldByName('IPR_PREVE5').AsFloat;
      LQryLog.ParamByName('PREVE6').AsFloat := LQryPromocao.FieldByName('IPR_PREVE6').AsFloat;
      LQryLog.ParamByName('PREVE7').AsFloat := LQryPromocao.FieldByName('IPR_PREVE7').AsFloat;
      LQryLog.ParamByName('PEREST').AsFloat := LQryPromocao.FieldByName('IPR_PEREST').AsFloat;
      LQryLog.ParamByName('DESPRO').AsString := LQryPromocao.FieldByName('PRO_DESPRO').AsString;
      LQryLog.ParamByName('DTAINI').AsDate := LQryPromocao.FieldByName('PRO_DTAINI').AsDateTime;
      LQryLog.ParamByName('DTAFIN').AsDate := LQryPromocao.FieldByName('PRO_DTAFIN').AsDateTime;
      LQryLog.ParamByName('COMPRO').AsString := LQryPromocao.FieldByName('PRO_COMPRO').AsString;
      LQryLog.ParamByName('IDXQTD').AsInteger := LQryPromocao.FieldByName('PRO_IDXQTD').AsInteger;
      LQryLog.ParamByName('ENTIME').AsString := LQryPromocao.FieldByName('PRO_ENTIME').AsString;
      LQryLog.ParamByName('ENTFUT').AsString := LQryPromocao.FieldByName('PRO_ENTFUT').AsString;
      LQryLog.ParamByName('TABLOI').AsString := LQryPromocao.FieldByName('PRO_TABLOI').AsString;
      LQryLog.ExecSQL;

      LQryPromocao.Next;
    end;
  finally
    FreeAndNil(LQryPromocao);
    FreeAndNil(LQryLog);
  end;
end;

function TfrmFatConvOrcPedVendaCasada.fGravaPedCompra(const AStrNumReq: String; var AStlListaPed: TStringList): Boolean;
var
  strNumPed,
  strAutIncPedGerado,
  stlLisOrc: String;
  objGerOrc: TGeraOrcFor;
  item: TItem;
  I: Integer;
begin
  Result := False;

  if cdsReqCom.RecordCount <= 0 then
    exit(True);

  For I := 0 To Pred(FstlFornec.Count) Do
  Begin
    cdsReqCom.Filter := 'ITE_CODFOR = ' + QuotedStr(FstlFornec[I]);
    cdsReqCom.Filtered := True;

    stlLisOrc := '';
    objGerOrc := TGeraOrcFor.Create;
    Try
      cdsReqCom.First;
      while not cdsReqCom.Eof do
      begin
        item.strCodIte := cdsReqCom.FieldByName('RCD_CODITE').AsString;
        item.strDesIte := cdsReqCom.FieldByName('RCD_DESITE').AsString;
        item.fltQtdIte := cdsReqCom.FieldByName('RCD_QTDITE').AsFloat;
        item.strCodEmp := cdsReqCom.FieldByName('RCD_EMPPDV').AsString;
        item.strCodUni := fCampoTabela('ITE_CODUNI','CADITE', ['ITE_CODITE'], [item.strCodIte]);
        item.strCodFor := fCampoTabela('ITE_CODFOR','CADITE', ['ITE_CODITE'], [item.strCodIte]);
        cdsProdutos.Locate('CODITE', cdsReqCom.FieldByName('RCD_CODITE').AsString, []);
        item.fltPreCus := cdsProdutos.FieldByName('PRECOM').AsFloat;
        item.fltTotIte := item.fltPreCus * item.fltQtdIte;
        item.blnIgnCal := True;

        objGerOrc.pAddItem(item);

        cdsReqCom.Next;
      end;

      objGerOrc.fGerarOrcamento(stlLisOrc, Nil, '', True);

      strNumPed := SplitString(stlLisOrc,'-')[0];

      AStlListaPed.Add(strNumPed);

      strAutIncPedGerado := objGerOrc.fBuscaAutoincremPedidoGerado(strNumPed, VS_strCodEmp);

      pVincularRequisicaoPedidoCompra(AStrNumReq, strAutIncPedGerado);

    Finally
      FreeAndNil(objGerOrc);
    End;

    Result := True;
  End;
end;

procedure TfrmFatConvOrcPedVendaCasada.pVincularRequisicaoPedidoCompra(const AStrNumReq, AStrAutIncPedGerado: String);
var
  qryUpd,
  qryPcmDet,
  qryPcmGer: TUniQuery;
begin
  qryUpd := fCriaQuery;
  qryPcmGer := fCriaQuery;
  qryPcmDet := fCriaQuery;

  Try
    qryPcmGer.SQL.Clear;
    qryPcmGer.SQL.Add('SELECT PCG_NUMPED, ');
    qryPcmGer.SQL.Add('       PCG_CODEMP, ');
    qryPcmGer.SQL.Add('       PCG_ESPDOC, ');
    qryPcmGer.SQL.Add('       PCG_NUMCTN  ');
    qryPcmGer.SQL.Add(' FROM PCMGER       ');
    qryPcmGer.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    qryPcmGer.ParamByName('AUTINC').AsString := AStrAutIncPedGerado;
    qryPcmGer.Open;

    If qryPcmGer.IsEmpty Then
      Exit;

    qryPcmDet.SQL.Clear;
    qryPcmDet.SQL.Add('SELECT AUTOINCREM,            ');
    qryPcmDet.SQL.Add('       PCD_CODITE             ');
    qryPcmDet.SQL.Add('FROM PCMDET                   ');
    qryPcmDet.SQL.Add('   WHERE PCD_NUMPED = :NUMPED ');
    qryPcmDet.SQL.Add('     AND PCD_CODEMP = :CODEMP ');
    qryPcmDet.SQL.Add('     AND PCD_ESPDOC = :ESPDOC ');
    qryPcmDet.SQL.Add('     AND PCD_NUMCTN = :NUMCTN ');

    qryPcmDet.ParamByName('NUMPED').AsString := qryPcmGer.FieldByName('PCG_NUMPED').AsString;
    qryPcmDet.ParamByName('CODEMP').AsString := qryPcmGer.FieldByName('PCG_CODEMP').AsString;
    qryPcmDet.ParamByName('ESPDOC').AsString := qryPcmGer.FieldByName('PCG_ESPDOC').AsString;
    qryPcmDet.ParamByName('NUMCTN').AsString := qryPcmGer.FieldByName('PCG_NUMCTN').AsString;
    qryPcmDet.Open;

    If qryPcmDet.IsEmpty Then
      Exit;

    qryPcmDet.First;

    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('UPDATE MOVRCD SET          ');
    qryUpd.SQL.Add('  RCD_SEQPCD = :AUTINC     ');
    qryUpd.SQL.Add('WHERE RCD_CODITE = :CODITE ');
    qryUpd.SQL.Add('  AND RCD_CODIGO = :RCDCOD ');

    While Not qryPcmDet.Eof Do
    Begin
      qryUpd.ParamByname('RCDCOD').AsString := AStrNumReq;
      qryUpd.ParamByname('AUTINC').AsString := qryPcmDet.FieldByName('AUTOINCREM').AsString;
      qryUpd.ParamByname('CODITE').AsString := qryPcmDet.FieldByName('PCD_CODITE').AsString;

      qryUpd.ExecSQL;

      qryPcmDet.Next;
    End;

  Finally
    FreeAndNil(qryUpd);
    FreeAndNil(qryPcmGer);
    FreeAndNil(qryPcmDet);
  End;

end;

procedure TfrmFatConvOrcPedVendaCasada.pVoltaInformacoesOriginais;
var
  LQryBkp: TUniQuery;
  LQryFatDor: TUniQuery;
  LItens: String;
begin
  LQryBkp := fCriaQuery;

  try
    LItens := EmptyStr;

    LQryBkp.Close;
    LQryBkp.SQL.Clear;
    LQryBkp.SQL.Add('UPDATE FATDOR F');
    LQryBkp.SQL.Add('INNER JOIN EXTDOR E');
    LQryBkp.SQL.Add('ON(F.AUTOINCREM = E.FDO_SEQFDO)');
    LQryBkp.SQL.Add('SET F.FDO_PROMOC = :PROMOC, ');
    LQryBkp.SQL.Add('    E.FDO_CODPRO = :CODPRO,');
    LQryBkp.SQL.Add('    E.FDO_CUSCAS = 0.0000');
    LQryBkp.SQL.Add('WHERE F.AUTOINCREM = :AUTINC');

    cdsProdutos.First;

    while not cdsProdutos.Eof do
    begin
      if fEmptyStr(fCampoTabela('ORI_SEQFDO','PROORI',['ORI_SEQFDO'],[cdsProdutosAUTINC.AsString],False)) then
      begin
        cdsProdutos.Next;
        continue;
      end;

      LQryBkp.Close;
      LQryBkp.ParamByName('PROMOC').AsString := fCampoTabela('ORI_PROMOC','PROORI',['ORI_SEQFDO'],[cdsProdutosAUTINC.AsString],False);
      LQryBkp.ParamByName('CODPRO').AsString := fCampoTabela('ORI_CODPRO','PROORI',['ORI_SEQFDO'],[cdsProdutosAUTINC.AsString],False);
      LQryBkp.ParamByName('AUTINC').AsString := cdsProdutosAUTINC.AsString;
      LQryBkp.ExecSQL;

      pIncrementaListaStr(cdsProdutosAUTINC.AsString, LItens, True);

      cdsProdutos.Next;
    end;

    if fEmptyStr(LItens) then
      exit;

    LQryFatDor := fCriarQuery('SELECT * FROM FATDOR WHERE AUTOINCREM IN('+LItens+')');

    try
      LQryFatDor.Open;

      TLogGor.strNumDoc := edtNumOrc.Text;
      TLogGor.strEspDoc := 'OR';
      TLogGor.strCodEmp := VS_strCOdEmp;
      TLogGor.pLog(LQryFatDor, 'FATDOR');
    finally
      FreeAndNil(LQryFatDor);
    end;

    LQryBkp.Close;
    LQryBkp.SQL.Clear;
    LQryBkp.SQL.Add('DELETE FROM PROORI WHERE ORI_SEQFDO IN('+LItens+')');
    LQryBkp.ExecSQL;
  finally
    FreeAndNil(LQryBkp);
  end;
end;

procedure TfrmFatConvOrcPedVendaCasada.pAdicionarFornecedorNaLista(const AStrCodIte: String);
var
  strCodFor: String;
begin
  strCodFor := fCampoTabela('ITE_CODFOR','CADITE', ['ITE_CODITE'], [AStrCodIte]);

  If FstlFornec.IndexOf(strCodFor) = -1 Then
    FstlFornec.Add(strCodFor);
end;


end.
