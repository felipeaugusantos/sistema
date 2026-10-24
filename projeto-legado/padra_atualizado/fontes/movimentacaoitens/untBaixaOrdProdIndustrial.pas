unit untBaixaOrdProdIndustrial;

interface

uses
  Windows, Classes, Controls, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, EditFocus, Mask, MaskEditFocus, ComCtrls, DBEditFocus, untOrdProIndustrial,
  Uni, DB, BitBtnLockedIncrem, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxCurrencyEdit,
  cxLookAndFeels, cxLookAndFeelPainters, DateUtils, StrUtils, cxNavigator, DBCtrls, frxClass,
  frxExportCSVTestabilidade, cxButtonEdit, System.Actions, Vcl.ActnList, Vcl.Forms,
  SysUtils, Variants, Graphics, cxLabel,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao,
  untTypesSistema, untMsgLiberacao, Math, cxTextEdit,
  OrdemProducaoIndustrial.TSQLOrdProdIndustrial,
  OrdemProducaoIndustrial.TProdutoGranel, untOrdProIndCorrecoes, UniClientDataSet,
  cxGridCitel;


type
  TfrmBaixaOrdProdIndustrial = class(TfrmPaiConfirma)
    prgProgre: TProgressBar;
    dtsOrdPro: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblDtaBai: TLabel;
    Label5: TLabel;
    mskDtaCad: TMaskEditFocus;
    edtNumOrd: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskHorIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    mskHorFin: TMaskEditFocus;
    mskDtaBai: TMaskEditFocus;
    dbeCodIte: TDBEditFocus;
    dbeDesIte: TDBEditFocus;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label6: TLabel;
    Shape2: TShape;
    Label7: TLabel;
    Shape3: TShape;
    Label8: TLabel;
    Panel2: TPanel;
    splEnvasado: TSplitter;
    ActionList1: TActionList;
    LoteRapido: TAction;
    PesqLotes: TAction;
    rdgTipBai: TRadioGroup;
    lblDtaVal: TLabel;
    mskDtaVal: TMaskEditFocus;
    Action1: TAction;
    lblComFra: TLabel;
    pnlEnvase: TPanel;
    Panel3: TPanel;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensORDITE: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensQTDPRO: TcxGridDBColumn;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxgItensPESUNI: TcxGridDBColumn;
    cxgItensQtdBai: TcxGridDBColumn;
    cxgItensQTDENV: TcxGridDBColumn;
    cxgItensNUMLOT: TcxGridDBColumn;
    cxgItensViewSITFRA: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    cxgItensSIGUNI: TcxGridDBColumn;
    Label11: TLabel;
    pnlModel9: TPanel;
    Label12: TLabel;
    edtCodQui: TEditFocus;
    edtNomQui: TEditFocus;
    Label13: TLabel;
    edtCodEnc: TEditFocus;
    edtNomEnc: TEditFocus;
    edtNomQua: TEditFocus;
    edtCodQua: TEditFocus;
    Label14: TLabel;
    edtNomLim: TEditFocus;
    edtCodLim: TEditFocus;
    Label15: TLabel;
    PesqLotesMP: TAction;
    pnlLocFis: TPanel;
    Label9: TLabel;
    edtLocFis: TEditFocus;
    edtDesLocFis: TEditFocus;
    sltLotesDistribuidos: TSplitter;
    Panel7: TPanel;
    pnlCorrecao: TPanel;
    btnIncluir: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    pnlLotesDistribuidos: TPanel;
    Panel6: TPanel;
    Label10: TLabel;
    Label16: TLabel;
    dtsLotes: TDataSource;
    cxgCorrecoes: TcxGrid;
    cxgCorrecoesViewMATBOPNao: TcxGridDBTableView;
    cxgCorrecoesViewMATBOPNaoColumn1: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPNaoColumn2: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPNaoColumn3: TcxGridDBColumn;
    cxgCorrecoesQTDITE: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPNaoColumn5: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSim: TcxGridDBTableView;
    cxgCorrecoesViewMATBOPSimIT: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSimDESCRICAO: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSimREFERENCIA: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSimQTDOP: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSimQTDUTILIZADA: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSimCORRECAO: TcxGridDBColumn;
    cxgCorrecoesViewMATBOPSimExcluir: TcxGridDBColumn;
    cxgCorrecoesLevel1: TcxGridLevel;
    cxgLotes: TcxGridCitel;
    cxvLotes: TcxGridDBTableViewCitel;
    cxvItens: TcxGridDBColumn;
    cxvDescri: TcxGridDBColumn;
    cxvNumLot: TcxGridDBColumn;
    cxvSaldos: TcxGridDBColumn;
    cxvSaldis: TcxGridDBColumn;
    cxvQuantidade: TcxGridDBColumn;
    cxlLotes: TcxGridLevel;
    cxvLotesITEACA: TcxGridDBColumn;
    cxvLotesDESACA: TcxGridDBColumn;
    cxvLotesORIFDO: TcxGridDBColumn;
    Shape4: TShape;
    Label17: TLabel;
    lblInfoLotesAuto: TLabel;
    btnHisBai: TBitBtnLocked;
    procedure PesqLotesExecute(Sender: TObject);
    procedure LoteRapidoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtNumOrdKeyPress(Sender: TObject; var Key: Char);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocFisEnter(Sender: TObject);
    procedure edtLocFisExit(Sender: TObject);
    procedure edtLocFisKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgTipBaiClick(Sender: TObject);
    procedure cxgItensViewSITFRAGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure Action1Execute(Sender: TObject);
    procedure cxgItensViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodEncKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodQuiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodLimKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodQuaKeyPress(Sender: TObject; var Key: Char);
    procedure cxgCorrecoesViewMATBOPSimCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgCorrecoesViewMATBOPSimExcluirPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure cxgCorrecoesViewMATBOPSimQTDUTILIZADAPropertiesEditValueChanged(
      Sender: TObject);
    procedure cxgCorrecoesViewMATBOPNaoColumn5GetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure cxgCorrecoesViewMATBOPNaoColumn5GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxgCorrecoesViewMATBOPSimCORRECAOPropertiesEditValueChanged(
      Sender: TObject);
    procedure mskDtaIniDblClick(Sender: TObject);
    procedure cxgCorrecoesViewMATBOPSimLotePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgItensNUMLOTPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvLotesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxvQuantidadeCustomDrawFooterCell(Sender: TcxGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo;
      var ADone: Boolean);
    procedure cxvQuantidadePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvNumLotPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvLotesCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvLotesCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);
    procedure cxvLotesKeyPress(Sender: TObject; var Key: Char);
    procedure cxvLotesEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxgItensViewFocusedItemChanged(Sender: TcxCustomGridTableView;
      APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure cxgItensViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnHisBaiClick(Sender: TObject);


  private
    { Private declarations }
    qryOrdPro: TUniQuery;
    blnBxOpHr: Boolean;
    blnFecharTela: Boolean;
    objLiberacao : TLiberacao;
    arrVen : TConsultasArray;
    blnTrabalhaComLoteMP: Boolean;
    FDataCad: String;
    FDataValidade: String;
    FOrdProInd: String;
    FPossuiLote: Boolean;
    FValidaBaixaChamadaExterna: Boolean;
    FChamadaDeRotinaExterna: Boolean;
    FPropCodResiduo: String;
    FPropLoteResiduo: String;
    FPropQtdResiduo: Double;
    FPropTipoBaixa : TTipoBaixa;
    FTipoBaixaJaDefinido: Boolean;
    FValidacaoOK: Boolean;
    FBaixaRealizada: Boolean;
    strHistoricoBaixa : String;
    blnBaiVef: Boolean;
    blnPerOsa: Boolean;

    procedure pLimpaCampos;
    procedure pLocalizaLoteMatOpe;

    procedure pCarregaLotes(strTipoItem: String); //PA = Prod. Acabado, PM = Prod. Mat Prima
    function fRtornaNumLoteAtivo(strCodIte: String): String;

    function fVerificaCorrecaoOpiConcluida: Boolean;
    function fLiberaBaixaSemCorrecao : boolean;
    function fValidaLoteMateriaPrimaCorrecao: Boolean;

    function fValidaSaldoCorrecoes: Boolean;
    // function fLoteTemSaldo(strCodIte, strNumLot: String; fltQuantidade: Double): Boolean;
    procedure pCarregaNumLoteSeHouver;
    function fExisteLoteADefinir: Boolean;
    procedure AfterScrollLotes(DataSet: TDataSet);
    procedure pInsert;
    procedure pProcessaInsercao(qryConsu: TUniQuery; strCodIte, strDesIte, strAutIncFDO, strIteAca, strSEQUEN, strACADES: String);
    procedure pDelete;
  public
    { Public declarations }

    objOrdPro: TOrdProIndustrial;

    procedure pInicializaOnShowDaTela;

    property strOrdProInd:             String   read FOrdProInd           write FOrdProInd;
    property strDataCad:               String   read FDataCad             write FDataCad;
    property strDataValidade:          String   read FDataValidade        write FDataValidade;
    property blnPossuiLote:            Boolean  read FPossuiLote          write FPossuiLote;
    property blnChamadaDeRotinaExterna:Boolean  read FChamadaDeRotinaExterna write FChamadaDeRotinaExterna;
    property blnValidaBaixaChamadaExterna:Boolean  read FValidaBaixaChamadaExterna write FValidaBaixaChamadaExterna;

    property blnValidacaoOK:           Boolean  read FValidacaoOK         write FValidacaoOK;
    property blnBaixaRealizada:        Boolean  read FBaixaRealizada      write FBaixaRealizada;


    property strPropCodResiduo :     String     read FPropCodResiduo      write FPropCodResiduo;
    property strPropLoteResiduo:     String     read FPropLoteResiduo     write FPropLoteResiduo;
    property fltPropQtdResiduo:      Double     read FPropQtdResiduo      write FPropQtdResiduo;
    property enuPropTipoBaixa:       TTipoBaixa read FPropTipoBaixa       write FPropTipoBaixa;
    property blnTipoBaixaJaDefinido: Boolean    read FTipoBaixaJaDefinido write FTipoBaixaJaDefinido;



  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, untConsultas,
  untFuncIns, untFuncIns2, untCadLoteItens, untFuncFat,
  untBaixaOrdProdIndustrialTipoBaixa, untFuncoesConsulta, untCadLote,
  untBaixaInformaOrdProd, untTLog, untObservacao;

{$R *.dfm}

procedure TfrmBaixaOrdProdIndustrial.Action1Execute(Sender: TObject);
begin
  inherited;
  fMensagem('','', ['']);
end;

procedure TfrmBaixaOrdProdIndustrial.AfterScrollLotes(DataSet: TDataSet);
begin
  If Not objOrdPro.blnUtilizaDistribuiLote Then
    Exit;
  objOrdPro.cdsLotesDefinidosPedido.Filtered := False;
  objOrdPro.cdsLotesDefinidosPedido.Filter := 'ITESUB = ' + QuotedStr(objOrdPro.objCorrOP.FieldByName('DMT_ITESUB').AsString);
  objOrdPro.cdsLotesDefinidosPedido.Filtered := True;

  cxvLotes.ViewData.Expand(True);
end;

procedure TfrmBaixaOrdProdIndustrial.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If not TBitBtnLocked(Sender).Visible Then
    Exit;
  objOrdPro.objCorrOP.fAlteraCorrecao;
end;

function TfrmBaixaOrdProdIndustrial.fVerificaCorrecaoOpiConcluida: Boolean;
CONST

  SQL_CONSULTA_CORRECOES_CONCLUIDA = ' SELECT ORD_CRRFIN FROM ORDGER ';

  SQL_CONSULTA_CORRECOES_CONCLUIDA_WHERE = ' WHERE AUTOINCREM = :AUTINC AND ORD_CRRFIN = "1" ';

  SQL_CONSULTA_CORRECOES_CONFERIDAS = ' SELECT * FROM DEICOR ';

  SQL_CONSULTA_CORRECOES_CONFERIDAS_WHERE = ' WHERE DMT_SEQORD = :AUTINC AND  '+
                                            '       DMT_DTACON IS NOT NULL AND '+
                                            '       DMT_HRACON IS NOT NULL AND '+
                                            '       DMT_OPECON IS NOT NULL';


var
  qryConsulta: TUniQuery;
begin
  qryConsulta:= fCriaQuery(Nil);
  Try

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(SQL_CONSULTA_CORRECOES_CONCLUIDA);
    qryConsulta.SQL.Add(SQL_CONSULTA_CORRECOES_CONCLUIDA_WHERE);
    qryConsulta.ParamByName('AUTINC').AsString:= qryOrdPro.FieldByName('AUTINC').AsString;
    qryConsulta.Open;

    result:= Not(qryConsulta.IsEmpty); //Retorna a informação se concluído

    //Se a condição acima retornou true informando que a correção foi concluida
    //Eu verifico a flag individual de cada correção. se todas estiverem marcadas o sistema segue
    {If result Then
    Begin
      qryConsulta.Close;        Aguardando carioca campos
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add(SQL_CONSULTA_CORRECOES_CONFERIDAS);
      qryConsulta.SQL.Add(SQL_CONSULTA_CORRECOES_CONFERIDAS_WHERE);
      qryConsulta.ParamByName('AUTINC').AsString:= qryOrdPro.FieldByName('AUTINC').AsString;
      qryConsulta.Open;

      result:= Not(qryConsulta.IsEmpty); //Retorna a informação se concluído
    End;}

  Finally
    FreeAndNil(qryConsulta);
  End;

end;

function TfrmBaixaOrdProdIndustrial.fLiberaBaixaSemCorrecao : boolean;
begin
  Result := False;

  If Not(AsSigned(objLiberacao)) then
    objLiberacao:= TLiberacao.Create;

  if not Result then
  begin
    objLiberacao.Clear;
    //Título
    objLiberacao.objMsgLibera.pAddTexto('Baixa de Ordem de Produção sem concluir a conferência de correção');


    objLiberacao.objMsgLibera.pAddSeparador;

    //Ordem de Produção
    objLiberacao.objMsgLibera.pAddTextoCaption('N.Ordem de Produção', edtNumOrd.Text + '-' + mskDtaCad.Text , 20);
    objLiberacao.objMsgLibera.pAddTextoCaption('Produto Granel'     , dbeCodIte.Text + '-' + dbeDesIte.Text , 20);
    objLiberacao.objMsgLibera.pAddSeparador;

    objLiberacao.strDirAce := 'PBOPIC';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.blnUsarSenhaFixa := False;
    objLiberacao.blnSempreVariavelUsuario := True;

    Result := objLiberacao.fLibera;
  end;
end;


{
function TfrmBaixaOrdProdIndustrial.fLoteTemSaldo(strCodIte, strNumLot: String; fltQuantidade: Double): Boolean;
CONST
  SQL_CONSULTA_MATERIA_PRIMA_SALDO = ' SELECT '+
                                     '   LOT_SALDOS '+
                                     ' FROM CADLOT L '+
                                     '   WHERE LOT_CODITE = :CODITE AND '+
                                     '         LOT_NUMLOT = :NUMLOT AND '+
                                     '         LOT_CODEMP = :CODEMP AND '+
                                     '         LOT_STATUS = "S" ';
var
  qryConsulta: TUniQuery;
begin
  qryConsulta:= fCriaQuery(Nil);
  Try

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(SQL_CONSULTA_MATERIA_PRIMA_SALDO);
    qryConsulta.ParamByName('CODITE').AsString:= strCodIte;
    qryConsulta.ParamByName('NUMLOT').AsString:= strNumLot;
    qryConsulta.ParamByName('CODEMP').AsString:= VS_strCodEmp;
    qryConsulta.Open;

    If qryConsulta.FieldByName('LOT_SALDOS').AsFloat < fltQuantidade Then
      result:= False
    Else
      result:= True;

  Finally
    FreeAndNil(qryConsulta);
  End;

End;
}

function TfrmBaixaOrdProdIndustrial.fValidaLoteMateriaPrimaCorrecao: Boolean;
var fltTotLot: Double;
begin
  result:= True;

  If Not objOrdPro.blnUtilizaDistribuiLote Then
    Exit;



  If (blnTrabalhaComLoteMP) Then
  Begin
    objOrdPro.objCorrOP.DisableControls;
    Begin
      objOrdPro.objCorrOP.First;
      While Not(objOrdPro.objCorrOP.eof) do
      Begin
        If (objOrdPro.objCorrOP.FieldByName('DMT_QTDITE').AsFloat > 0) And (objOrdPro.objCorrOP.FieldByName('ORI_FORAORDEM').AsString <> 'S')  Then
        Begin
          If objOrdPro.cdsLotesDefinidosPedido.IsEmpty Then
          Begin
            fMensagem('', 'Não é possível baixar uma ordem de produção sem informar '+#13 +
                          'o lote das matérias primas com correções positivas!', ['&OK']);
            Exit(False);
          End;
         objOrdPro.objCorrOP.Next;
        End
        Else
        Begin
          fltTotLot := 0;
          while not objOrdPro.cdsLotesDefinidosPedido.Eof do
          begin
            fltTotLot := fltTotLot + objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat;
            objOrdPro.cdsLotesDefinidosPedido.Next;
          End;

          If  RoundTo(fltTotLot, -4) <>  RoundTo(objOrdPro.objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat, -4) then
          Begin
            fMensagem('', 'Não é possível baixar uma ordem de produção sem informar '+#13 +
                          'os lote das matérias primas com as respectivas quantidades!', ['&OK']);
            Exit(False);
          End;
         objOrdPro.objCorrOP.Next;
        End;
      End;
    End;
    objOrdPro.objCorrOP.EnableControls;
  End;


end;

function TfrmBaixaOrdProdIndustrial.fValidaSaldoCorrecoes: Boolean;
var
  objTabela : TRegistroMsgLiberaTabela;
	objLinha  : TLinhaMsgLibera;
  fltSaldoDisponivel,
  fltQtdUtilizada: Double;
  blnTemSaldoNegativo: Boolean;
  cdsSaldoTemp: TUniClientDataSet;
begin

  cdsSaldoTemp := TUniClientDataSet.Create(Self);
  cdsSaldoTemp.FieldDefs.Add('DMT_ITESUB', ftString, 7);
  cdsSaldoTemp.FieldDefs.Add('DMT_QTDITE', ftFloat);
  cdsSaldoTemp.FieldDefs.Add('DMT_DESCRI', ftString, 120);
  cdsSaldoTemp.FieldDefs.Add('NUMLOT', ftString, VS_Size_NumLot);
  cdsSaldoTemp.FieldDefs.Add('QTD_UTILIZADA', ftFloat);
  cdsSaldoTemp.FieldDefs.Add('DMT_NUMLOT', ftString, 20);
  cdsSaldoTemp.CreateDataSet;
  cdsSaldoTemp.Open;

  objOrdPro.objCorrOP.DisableControls;
  Begin
    objOrdPro.objCorrOP.First;

    While Not(objOrdPro.objCorrOP.eof) do
    Begin
      If (objOrdPro.objCorrOP.FieldByName('DMT_QTDITE').AsFloat > 0)and (objOrdPro.objCorrOP.FieldByName('ORI_FORAORDEM').AsString <> 'S') Then
      Begin

        If cdsSaldoTemp.Locate('DMT_ITESUB', objOrdPro.objCorrOP.FieldByName('DMT_ITESUB').AsString,[]) Then
        Begin
          cdsSaldoTemp.Edit;
          cdsSaldoTemp.FieldByName('DMT_QTDITE').AsFloat := cdsSaldoTemp.FieldByName('DMT_QTDITE').AsFloat + objOrdPro.objCorrOP.FieldByName('DMT_QTDITE').AsFloat;
          cdsSaldoTemp.FieldByName('QTD_UTILIZADA').AsFloat:= cdsSaldoTemp.FieldByName('QTD_UTILIZADA').AsFloat + objOrdPro.objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat;
          cdsSaldoTemp.Post;
        End

        Else

        Begin
          cdsSaldoTemp.Insert;
          cdsSaldoTemp.FieldByName('DMT_QTDITE').AsFloat:= objOrdPro.objCorrOP.FieldByName('DMT_QTDITE').AsFloat;
          cdsSaldoTemp.FieldByName('DMT_ITESUB').AsString:= objOrdPro.objCorrOP.FieldByName('DMT_ITESUB').AsString;
          cdsSaldoTemp.FieldByName('DMT_DESCRI').AsString:= objOrdPro.objCorrOP.FieldByName('DMT_DESCRI').AsString;
          cdsSaldoTemp.FieldByName('NUMLOT').AsString:= objOrdPro.objCorrOP.FieldByName('NUMLOT').AsString;
          cdsSaldoTemp.FieldByName('DMT_NUMLOT').AsString:= objOrdPro.objCorrOP.FieldByName('DMT_NUMLOT').AsString;
          cdsSaldoTemp.FieldByName('QTD_UTILIZADA').AsFloat:= objOrdPro.objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat;
          cdsSaldoTemp.Post;

        End;

      End;

      objOrdPro.objCorrOP.Next;
    End;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Liberação para Ordem de Produção com correções sem Saldo em Estoque');


    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Código'           , fTamCodIte, alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Descrição'        , 45 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Saldo Disponível' , 18 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'Correção OP'      , 12 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'Numero Lote'      , 30 , alEsquerda , teAutcom);

    objTabela.lstLinhas.Add(objLinha);

    blnTemSaldoNegativo := False;
    cdsSaldoTemp.First;

    While Not(cdsSaldoTemp.eof) do
    Begin
      If (cdsSaldoTemp.FieldByName('DMT_QTDITE').AsFloat > 0) And (objOrdPro.objCorrOP.FieldByName('ORI_FORAORDEM').AsString <> 'S') Then
      Begin
        fltSaldoDisponivel := fRetornaSaldoDisponivel(cdsSaldoTemp.FieldByName('DMT_ITESUB').AsString,
                                   False,
                                   True,
                                   cdsSaldoTemp.FieldByName('NUMLOT').AsString,
                                   True,
                                   VS_strCodEmp);
        fltQtdUtilizada :=  cdsSaldoTemp.FieldByName('QTD_UTILIZADA').AsFloat;
        If (fltSaldoDisponivel - fltQtdUtilizada)  < 0 Then
        begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('Código'           , cdsSaldoTemp.FieldByName('DMT_ITESUB').AsString , fTamCodIte, alEsquerda );
          objLinha.pAddColuna('Descrição'        , cdsSaldoTemp.FieldByName('DMT_DESCRI').AsString , 45 , alEsquerda );
          objLinha.pAddColuna('Saldo Disponível' , FormatFloat('#,##0.00', fltSaldoDisponivel), 18 , alDireita  );
          objLinha.pAddColuna('Correção OP'      , FormatFloat('#,##0.00', fltQtdUtilizada)   , 12 , alDireita  );
          objLinha.pAddColuna('Numero Lote'      , cdsSaldoTemp.FieldByName('DMT_NUMLOT').AsString  , 30 , alDireita  );
          objTabela.lstLinhas.Add(objLinha);
          blnTemSaldoNegativo := True;
        End;
      End;
      cdsSaldoTemp.Next;
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'SLD_COR';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.blnUsarSenhaFixa := False;
    objLiberacao.blnSempreVariavelUsuario := True;

    If Not blnTemSaldoNegativo Then
      Exit(True);
    Result := objLiberacao.fLibera;
  End;
  objOrdPro.objCorrOP.EnableControls;

  If Assigned(cdsSaldoTemp) Then
    FreeAndNil(cdsSaldoTemp);
End;

procedure TfrmBaixaOrdProdIndustrial.btnConfirmaClick(Sender: TObject);

  Var
    blnValidacao  : Boolean;
    strSeqGer     : String;
    strAutInc     : String;
    qryCadIte     : TUniQuery;
    enuTipoBaixa  :  TTipoBaixa;
    strCodResiduo : String;
    strLoteResiduo: String;
    fltQtdResiduo : Real;
    strMensagem   : String;
    blnBaixou     : boolean;
    objCadLot     : TCadLot;
    strLotesErro  : String;
    strLotesErroGarantia : String;
    strLotesErroADefinir : String;
    frmBaixaOrdProdIndustrialTipoBaixa: TfrmBaixaOrdProdIndustrialTipoBaixa;
    objSQLOrdProdIndustrial:TSQLOrdProdIndustrial;
    objProdutoGranel: TProdutoGranel;
    qryConsulta: TUniQuery;
    strSeqProdPrinc: String;
    obListaErro: TStringList;
    strAgrupadorPreAlt: String;
    blnPermiteBaixarComponenteA: Boolean;
    qryConOpe: TUniQuery;
    blnConfirmaBaixaOPI: Boolean;
    qryGenSQL: TUniQuery;
    strLoteADefinir: String;

  function fLiberaResiduo : boolean;
  var
    objTabela : TRegistroMsgLiberaTabela;
  	objLinha  : TLinhaMsgLibera;
  begin
    Result := enuTipoBaixa in [tpbAcabado, tpbParcial];

    if not Result then
    begin
      objLiberacao.Clear;
      //Título
      case enuTipoBaixa of
        tpbResiduo        : objLiberacao.objMsgLibera.pAddTexto('Baixa de Ordem de Produção na opção Envase totalmente em resíduo');
        tpbAcabadoResiduo : objLiberacao.objMsgLibera.pAddTexto('Baixa de Ordem de Produção na opção Envase parte produto acabado e parte resíduo');
      end;

      objLiberacao.objMsgLibera.pAddSeparador;

      //Ordem de Produção
      objLiberacao.objMsgLibera.pAddTextoCaption('N.Ordem de Produção', edtNumOrd.Text + '-' + mskDtaCad.Text , 20);
      objLiberacao.objMsgLibera.pAddTextoCaption('Produto Granel'     , dbeCodIte.Text + '-' + dbeDesIte.Text , 20);
      objLiberacao.objMsgLibera.pAddSeparador;

      if enuTipoBaixa = tpbAcabadoResiduo then
      begin
        objLiberacao.objMsgLibera.pAddTexto('Produtos Envasados:');

        objTabela := TRegistroMsgLiberaTabela.Create;
        try
          objOrdPro.DisableControls;
          objOrdPro.First;

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'Cod.'       , fTamCodIte  , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'Descrição'  , 75 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'Quantidade' , 12 , alDireita  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);


          While Not objOrdPro.Eof Do
          Begin


            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('Cod.'       , objOrdPro.FieldByName('ORD_CODITE').AsString                         , fTamCodIte  , alEsquerda);
            objLinha.pAddColuna('Descrição'  , objOrdPro.FieldByName('DESITE').AsString                             , 75 , alEsquerda);
            objLinha.pAddColuna('Quantidade' , FormatFloat('#,##0.00', objOrdPro.FieldByName('ORD_QTDENV').AsFloat) , 12 , alDireita );
            objTabela.lstLinhas.Add(objLinha);

            objOrdPro.Next;
          End;

        finally
          objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
          objOrdPro.EnableControls;
        end;
      end;

      //Resíduo

      objLiberacao.objMsgLibera.pAddTextoCaption('Produto Resíduo', strCodResiduo + '-' + fRetNomProduto(strCodResiduo) , 20);
      if not fEmptyStr(strLoteResiduo) then
        objLiberacao.objMsgLibera.pAddTextoCaption('Lote', strLoteResiduo                                               , 20);

      objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade'     , FormatFloat('#,##0.00', fltQtdResiduo)              , 20);

      objLiberacao.strDirAce := 'RESIOI';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.blnUsarSenhaFixa := False;
      objLiberacao.blnSempreVariavelUsuario := True;


      Result := objLiberacao.fLibera;

    end;
  end;

begin
//  inherited;
  blnBaixou    := False;
  If objOrdPro.blnUtilizaDistribuiLote Then
    cxgItensNUMLOT.Focused := True;
  strLoteADefinir:= 'N';
  Try
    objOrdPro.pBackupOPI;
    strAutInc := '';
    strCodResiduo := '';
    strLoteResiduo := '';
    fltQtdResiduo := 0;
    blnValidacao := False;
    strSeqProdPrinc:= '';

    If not fVerificaCampos then
      exit;

    If (fCfgSis('SOLSEN', varString) = 'S') And (Not(FChamadaDeRotinaExterna)) Then
    Begin
      If ffrmSenha(strSenha, 'Digite a Senha') Then
      Begin
        qryConOpe:= fCriaQuery;
        Try

          qryConOpe.Close;
          qryConOpe.SQL.Clear;
          qryConOpe.SQL.Add('SELECT * FROM CADOPE WHERE OPE_CODOPE = :CODOPE AND OPE_STATUS <> "I"');
          qryConOpe.ParamByName('CODOPE').AsString:= strLoginUsuarioLogado;
          qryConOpe.Open;

          If (strSenha <> fDecrypt(qryConOpe.FieldByName('OPE_SENOPE').AsString)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Senha Invalida!', ['&O k']);
            Exit;
          End;

        Finally
          FreeAndNil(qryConOpe);
        End;
      End;
    End;

    If fCfgSis('CORROP', varString) = 'N' Then
    Begin
      If Not(fVerificaAcessoSistema('PBOPIC', strLoginUsuarioLogado)) And
        (Not(fVerificaCorrecaoOpiConcluida)) Then
      Begin
        If Not(fLiberaBaixaSemCorrecao) Then
          Exit;
      End;
    End;

    If Not(fValidaLoteMateriaPrimaCorrecao) Then
      Exit;
    If Not(objOrdPro.blnUtilizaDistribuiLote) Then
      If Not(fValidaSaldoCorrecoes) Then
        Exit;

    If Not blnPerOsa Then
    Begin
      If (TOrdProIndustrial.fDeveGerarAnalise(qryOrdPro.FieldByName('AUTINC').AsString)) And (TOrdProIndustrial.fTodasAnalisesReprovadas(qryOrdPro.FieldByName('AUTINC').AsString)) Then
      Begin
        If Not TOrdProIndustrial.fLiberaOrdemTodasAnalisesReprovadas(qryOrdPro.FieldByName('AUTINC').AsString) Then
          Exit;
      End;
    End;

    //configura o tipo de baixa
    if rdgTipBai.ItemIndex = 1 then
      enuTipoBaixa := tpbParcial
    else
    begin
      pCriarFormularios(TfrmBaixaOrdProdIndustrialTipoBaixa, frmBaixaOrdProdIndustrialTipoBaixa);
      frmBaixaOrdProdIndustrialTipoBaixa.rdbResiduo.Enabled := (objOrdPro.fRetQtdeBaixaParcial('') = 0);
      frmBaixaOrdProdIndustrialTipoBaixa.fltPesoProducao := objOrdPro.fRetSoma('PESO');

      If FChamadaDeRotinaExterna Then
      Begin
        If FTipoBaixaJaDefinido Then
          frmBaixaOrdProdIndustrialTipoBaixa.ModalResult:= mrOk
        Else
          frmBaixaOrdProdIndustrialTipoBaixa.ShowModal;
      End
      Else
      Begin
        frmBaixaOrdProdIndustrialTipoBaixa.ShowModal;
      End;


      if frmBaixaOrdProdIndustrialTipoBaixa.ModalResult = mrOk then
      begin

        If FChamadaDeRotinaExterna And FTipoBaixaJaDefinido Then
        Begin

          strCodResiduo:= FPropCodResiduo;
          strLoteResiduo:= FPropLoteResiduo;
          fltQtdResiduo:= FPropQtdResiduo;
          enuTipoBaixa:= FPropTipoBaixa;

        End
        Else
        Begin

          enuTipoBaixa := frmBaixaOrdProdIndustrialTipoBaixa.enuTipoBaixa;
          if enuTipoBaixa in [tpbAcabadoResiduo, tpbResiduo] then
          begin
            strCodResiduo  := frmBaixaOrdProdIndustrialTipoBaixa.edtProdutoResiduo.Text;
            strLoteResiduo := frmBaixaOrdProdIndustrialTipoBaixa.edtLote.Text;
            fltQtdResiduo  := fStrToFloat(frmBaixaOrdProdIndustrialTipoBaixa.edtQtdResiduo.Text);
          end;

          If FChamadaDeRotinaExterna Then
          Begin
            FPropCodResiduo:= strCodResiduo;
            FPropLoteResiduo:= strLoteResiduo;
            FPropQtdResiduo:= fltQtdResiduo;
            FPropTipoBaixa:= enuTipoBaixa;
            FTipoBaixaJaDefinido:= True;
          End;
        End;
      end
      else
        exit;

      pFreeAndNil(frmBaixaOrdProdIndustrialTipoBaixa);
    end;


    objOrdPro.objCorrOP.AfterScroll :=  nil;
    objOrdPro.DisableControls;
    objOrdPro.First;
    While Not objOrdPro.Eof Do
    Begin
      case enuTipoBaixa of
        tpbResiduo,
        tpbAcabadoResiduo:
        Begin
          blnValidacao := True;
          objOrdPro.Edit;

          if objOrdPro.FieldByName('ORD_CODITE').AsString = strCodResiduo Then
          begin
            objOrdPro.FieldByName('ORD_QTDENV').AsFloat := fltQtdResiduo;

            if not fEmptyStr(strLoteresiduo) then
              objOrdPro.FieldByName('NUMLOT').AsString := strLoteResiduo;
          end
          else if enuTipoBaixa = tpbResiduo then
            objOrdPro.FieldByName('ORD_QTDENV').AsFloat := 0;

          objOrdPro.Post;
        End;

        tpbAcabado,
        tpbParcial:
        Begin
          If (objOrdPro.FieldByName('ORD_QTDENV').AsFloat > 0) Then
          Begin
            blnValidacao := True;
            Break;
          End;
        End;
      End;

      objOrdPro.Next;
    End;

    objOrdPro.First;

    If Not blnValidacao Then
    Begin
      fMensagem('', 'Não é possível baixar a ordem de produção sem informar as quantidades envasadas!', ['&OK']);
      Exit;
    End;

    If fCfgSis('COMFRA', varString) = '?' Then
    Begin
      Try
        blnValidacao := True;
        objOrdPro.DisableControls;
        objOrdPro.First;
        While Not objOrdPro.Eof Do
        Begin
          objOrdPro.pAcertaEmbalagens;
          objOrdPro.Next;
        End;
        objOrdPro.First;
        While Not objOrdPro.Eof Do
        Begin

          If (objOrdPro.FieldByName('SITFRA').AsString = 'N') Then
          Begin
            blnValidacao := False;
            Break;
          End;

          objOrdPro.Next;
        End;

        If Not blnValidacao Then
        Begin
          fMensagem('', 'Não é possível baixar a ordem de produção sem informar as quantidades das embalagens que não pode ser fracionadas!', ['&OK']);
          Exit;
        End;

      Finally
        objOrdPro.First;
        objOrdPro.EnableControls;
      End;
    End;


    blnValidacao := True;
    If (fUsaRotinaWMS) Or (cxgItensNUMLOT.Visible) Then
    Begin
      strLotesErro := '';
      strLotesErroGarantia := '';
      strLotesErroADefinir := '';
      objCadLot := TCadLot.Create(Nil);
      Try
        objOrdPro.DisableControls;
        objOrdPro.First;
        While Not objOrdPro.Eof Do
        Begin
          If (objOrdPro.FieldByName('ORD_QTDENV').AsFloat > 0) Then
          Begin
            If (fEmptyStr(objOrdPro.FieldByName('NUMLOT').AsString) And Not objOrdPro.blnGerarLotesPelaProcedure) Then
            Begin
              blnValidacao := False;
              objOrdPro.Last;
            End
            Else
            Begin
              if not objCadLot.fExisteLote(objOrdPro.FieldByName('ORD_CODITE').AsString, VS_strCodEmp, objOrdPro.FieldByName('NUMLOT').AsString) Then
              Begin
                If not fEmptyStr(strLotesErro) Then
                  strLotesErro := strLotesErro + #13;

                strLotesErro := strLotesErro + objOrdPro.FieldByName('ORD_CODITE').AsString + ' - ' + objOrdPro.FieldByName('NUMLOT').AsString;

              End
              else if objCadLot.fEhPrincipalGarantia(objOrdPro.FieldByName('ORD_CODITE').AsString, objOrdPro.FieldByName('NUMLOT').AsString) Then
              Begin
                If not fEmptyStr(strLotesErroGarantia) Then
                  strLotesErroGarantia := strLotesErroGarantia + #13;

                strLotesErroGarantia := strLotesErroGarantia + objOrdPro.FieldByName('ORD_CODITE').AsString + ' - ' + objOrdPro.FieldByName('NUMLOT').AsString;

              End
              else if objOrdPro.FieldByName('NUMLOT').AsString = 'A DEFINIR' Then
              Begin
                If not fEmptyStr(strLotesErroADefinir) Then
                  strLotesErroADefinir := strLotesErroADefinir + #13;

                strLotesErroADefinir := strLotesErroADefinir + objOrdPro.FieldByName('ORD_CODITE').AsString;

              End;

            End;

          End;

          objOrdPro.Next;
        End;

        strMensagem := '';

        If not fEmptyStr(strLotesErro) then
          strMensagem := strMensagem + 'O lote do(s) produto(s) abaixo não existe ou está inativo.'+ #13 + strLotesErro + #13;

        If not fEmptyStr(strLotesErroGarantia) then
          strMensagem := strMensagem + 'O lote do(s) produto(s) abaixo é prinicpal de garantia.'+ #13 + strLotesErroGarantia + #13;

        If not fEmptyStr(strLotesErroADefinir) And Not(fCfgSis('ENDBAI', varBoolean))  then
          strMensagem := strMensagem + 'O lote do(s) produto(s) abaixo é A Definir.'+ #13 + strLotesErroADefinir+ #13;

        If not fEmptyStr(strMensagem) then
        Begin
          fMensagem('', strMensagem + 'Escolha lotes válidos!', ['&OK']);
          Exit;
        End;

        strMensagem := '';

      Finally
        FreeAndNil(objCadLot);
        objOrdPro.First;
        objOrdPro.EnableControls;
      End;
    End;

    If not blnValidacao Then
    Begin
      pMensagemOK('Informe todos os lotes antes de realizar a baixa!');
      Exit;
    End;

    If fEmptyStr(fCfgSis('CLIOPI')) Then
    Begin
      pMensagemOk('Configure o Código do Cliente para geração dos documentos que movimentarão o estoque para a OP em ' +
                  'Configurações do Sistema / Industrial!');
      Exit;
    End;

    objSQLOrdProdIndustrial:=TSQLOrdProdIndustrial.Create;
    objProdutoGranel:= TProdutoGranel.Create;
    Try

      objProdutoGranel.blnCfgUsaComponente:=  fCfgSis('ULTCMP', varBoolean);

      if objProdutoGranel.blnCfgUsaComponente then
      Begin

        qryConsulta:= fCriaQuery;
        Try
          qryConsulta.Close;
          qryConsulta.SQL.Clear;
          qryConsulta.SQL.Add(objSQLOrdProdIndustrial.fRetornaSQLComponenteItem);
          qryConsulta.ParamByName('CODITE').AsString:= dbeCodIte.Text;

          qryConsulta.Open;

          objProdutoGranel.strComponenteA:= qryConsulta.FieldByName('ITE_COMPNA').AsString;
          objProdutoGranel.strComponenteB:= qryConsulta.FieldByName('ITE_COMPNB').AsString;

          blnPermiteBaixarComponenteA:= qryConsulta.FieldByName('ITE_COMPNA').AsString = 'S';

          objProdutoGranel.strCodigoItemPrincipal := dbeCodIte.Text;
          objProdutoGranel.strCodigoItemSecundario:= qryConsulta.FieldByName('ITE_CODITB').AsString;

          If objProdutoGranel.strComponenteB = 'S' Then
          Begin
            qryConsulta.Close;
            qryConsulta.SQL.Clear;
            qryConsulta.SQL.Add(objSQLOrdProdIndustrial.fRetornaSQLComponenteB);
            qryConsulta.ParamByName('CODITE').AsString:= dbeCodIte.Text;
            qryConsulta.Open;

            If qryConsulta.IsEmpty Then
            Begin
              fMensagem('ATENÇÃO!', 'O Item Informado está definido como componente "B" na formulação, '+#13
                        +' porém, não possui componente "A" na formulação vinculado!', ['&Ok']);
              Exit;
            End;

          End;

          If (objProdutoGranel.fUsaComponenteAB) Then
          Begin
            pCriarFormularios(TfrmBaixaInformaOrdProd, frmBaixaInformaOrdProd);
            Try
              frmBaixaInformaOrdProd.strComponenteA:= objProdutoGranel.strComponenteA;
              frmBaixaInformaOrdProd.strComponenteB:= objProdutoGranel.strComponenteB;
              frmBaixaInformaOrdProd.strCodigoItem := objProdutoGranel.fRetornaCodigoItem;
              frmBaixaInformaOrdProd.ShowModal;
              if frmBaixaInformaOrdProd.ModalResult = mrOk then
              begin
                qryConsulta.Close;
                qryConsulta.SQL.Clear;
                qryConsulta.SQL.Add(objSQLOrdProdIndustrial.fRetornaSQLAutoIncremOrdPro);
                qryConsulta.SQL.Add(objSQLOrdProdIndustrial.fRetornaSQLFiltroDiferenteDaAtual);

                qryConsulta.ParamByName('CODORD').AsString:= frmBaixaInformaOrdProd.edtNumOP.Text;
                qryConsulta.ParamByName('DTACAD').AsDate  := StrToDate(frmBaixaInformaOrdProd.edDataOP.Text);
                qryConsulta.ParamByName('ID').AsString  := objOrdPro.FieldByName('ORD_SEQGER').AsString;

                qryConsulta.Open;

                If qryConsulta.IsEmpty Then
                Begin
                  fMensagem('ATENÇÃO!', 'Ordem de Produção Informada não existe!', ['&Ok']);
                  Exit;
                End
                Else
                  strSeqProdPrinc:= qryConsulta.FieldByName('AUTOINCREM').AsString;
              End
              Else
              if Not(blnPermiteBaixarComponenteA) then
                Exit;

            Finally
              FreeAndNil(frmBaixaInformaOrdProd);
            End;

          End;
        Finally
          FreeAndNil(qryConsulta);
        End;
      End;

    Finally
      FreeAndNil(objSQLOrdProdIndustrial);
      FreeAndNil(objProdutoGranel);
    End;


    Case enuTipoBaixa of
      tpbParcial        : strMensagem := 'Parcial ';
      tpbAcabado        : strMensagem := '';
      tpbResiduo        : strMensagem := 'Residual ';
      tpbAcabadoResiduo : strMensagem := 'Acabado/Residual ';
    end;

    If FChamadaDeRotinaExterna Then
      blnConfirmaBaixaOPI:= True
    Else
      blnConfirmaBaixaOPI:= fPergunta('Confirma a baixa ' + strMensagem + 'da Ordem de Produção ' + edtNumOrd.Text + '-' + mskDtaCad.Text + ' ?');

    if blnConfirmaBaixaOPI Then
    Begin
      if not fLiberaResiduo then
        exit;

      If fCfgSis('COMFRA', varString) = '?' Then
      Begin
        objOrdPro.BeforePost := Nil;
        objOrdPro.cdsOrdCom.CheckBrowseMode;
        objOrdPro.cdsOrdCom.fSalva; //Salva por vai recarregar a composição.
      End;

      //Se for Baixa residuo, inclui o residuo na ORDDET como se fosse um produto acabado.
      If (enuTipoBaixa in [tpbResiduo, tpbAcabadoResiduo]) and (not objOrdPro.Locate('ORD_CODITE', strCodResiduo, [])) Then
      Begin
        strSeqGer := objOrdPro.FieldByName('ORD_SEQGER').AsString;
        strAutInc := fRetAutoIncrem('ORDDET', VS_strCodEmp);
        objOrdPro.Insert;
        objOrdPro.FieldByName('AUTOINCREM').AsString := strAutInc;
        objOrdPro.FieldByName('ORD_SEQGER').AsString := strSeqGer;
        objOrdPro.FieldByName('ORD_CODITE').AsString := strCodResiduo;
        objOrdPro.FieldByName('ORD_RESIDU').AsString := 'S';

        if not fEmptyStr(strLoteResiduo) then
          objOrdPro.FieldByName('NUMLOT').AsString := strLoteResiduo;
        objOrdPro.FieldByName('ORD_QTDPRO').AsFloat  := 0.00;
        objOrdPro.FieldByName('ORD_QTDENV').AsFloat  := fltQtdResiduo;

        qryCadIte := fCriaQuery;
        qryCadIte.SQL.Add(' SELECT UNI_KILLIT, UNI_PESLIT                ');
        qryCadIte.SQL.Add(' FROM CADITE                                  ');
        qryCadIte.SQL.Add(' INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ');
        qryCadIte.SQL.Add(' WHERE ITE_CODITE = :CODITE                   ');

        qryCadIte.ParamByName('CODITE').AsString := strCodResiduo;
        qryCadIte.Open;
        objOrdPro.FieldByName('PESLIT').AsFloat := qryCadIte.FieldByName('UNI_PESLIT').AsFloat;

        If qryCadIte.FieldByName('UNI_KILLIT').AsString = 'K' Then
        Begin
          objOrdPro.FieldByName('ORD_PESACA').AsFloat := (objOrdPro.FieldByName('ORD_QTDENV').AsFloat * qryCadIte.FieldByName('UNI_PESLIT').AsFloat);
          objOrdPro.FieldByName('ORD_VOLACA').AsFloat := (objOrdPro.FieldByName('ORD_QTDENV').AsFloat * qryCadIte.FieldByName('UNI_PESLIT').AsFloat) / objOrdPro.fltPesoReal;
        End
        Else
        Begin
          objOrdPro.FieldByName('ORD_PESACA').AsFloat := objOrdPro.FieldByName('ORD_QTDENV').AsFloat * qryCadIte.FieldByName('UNI_PESLIT').AsFloat * objOrdPro.fltPesoReal;
          objOrdPro.FieldByName('ORD_VOLACA').AsFloat := objOrdPro.FieldByName('ORD_QTDENV').AsFloat * qryCadIte.FieldByName('UNI_PESLIT').AsFloat;
        End;
        qryCadIte.Close;
        FreeAndNil(qryCadIte);

        objOrdPro.FieldByName('ORD_CUSACA').AsFloat  := fCampoTabela('ITE_PRECUS', 'ITEGER', ['ITE_CODEMP', 'ITE_CODITE'], [VS_strCodEmp, strCodResiduo]);
        objOrdPro.FieldByName('ORD_CUSCOM').AsFloat  := 0;
        objOrdPro.FieldByName('ORD_IMPETI').AsString := 'N';
        objOrdPro.FieldByName('ORD_DTBXCF').Clear;
        objOrdPro.FieldByName('ORD_HRBXCF').Clear;
        objOrdPro.FieldByName('ORD_OPBXCF').Clear;
        objOrdPro.FieldByName('ORD_QTDECF').Clear;
        objOrdPro.FieldByName('PESREA').AsFloat  := objOrdPro.fltPesoReal;
        objOrdPro.Post;
      End;

      //So valida estoque na baixa total
      If ((not rdgTipBai.Visible) Or (enuTipoBaixa <> tpbParcial)) And (not objOrdPro.fVerificaQuantidadeEstoque(qryOrdPro, False, True)) Then
        Exit;

      If Not(objOrdPro.blnUtilizaDistribuiLote) then
      Begin
        If Not  objOrdPro.fVerificaSaldoParaBaixaEvazadaAcimaComSaldo(qryOrdPro.FieldByName('AUTINC').AsString, obListaErro, enuTipoBaixa = tpbParcial ) Then
        Begin
          objOrdPro.pMostraMemo(obListaErro);
          pnlBotoes.Enabled := True;
          Exit;
        End;
      End
      Else
      Begin
        strMensagem := '';
        If Not objOrdPro.fValidaSaldoLotesDefindos Then
          Exit
        Else
          objOrdPro.pDefineCdsLotesComponentes;
      End;

      If Not FChamadaDeRotinaExterna Then
      Begin
        If Not objOrdPro.fGerarLotesPelaProcedure(enuTipoBaixa, StrToDate(mskDtaVal.Text)) Then
          Exit;
      End;

      pnlBotoes.Enabled := False;

      blnBaixou := objOrdPro.fBaixaOrdemProducao(qryOrdPro.FieldByName('AUTINC').AsString,
                                                 qryOrdPro.FieldByName('CODITE').AsString,
                                                 qryOrdPro.FieldByName('CODCOR').AsString,
                                                 StrToDateDef(mskDtaIni.Text, 0),
                                                 StrToTimeDef(mskHorIni.Text, 0),
                                                 StrToDateDef(mskDtaFin.Text, 0),
                                                 StrToTimeDef(mskHorFin.Text, 0),
                                                 StrToDateDef(mskDtaBai.Text, 0),
                                                 prgProgre,
                                                 edtLocFis.Text,
                                                 enuTipoBaixa = tpbParcial,
                                                 StrToDateDef(mskDtaVal.Text,0),
                                                 edtCodQui.Text,
                                                 edtCodEnc.Text,
                                                 edtCodLim.Text,
                                                 edtCodQua.Text,
                                                 strSeqProdPrinc,
                                                 strAgrupadorPreAlt,
                                                 strHistoricoBaixa);

      if blnBaixou Then
      Begin
        if fCfgSis('RASIND', varInteger) = 2 then
        begin
          If fCfgSis('PERETQ', varBoolean) Then
          Begin
            if fMensagem('','Deseja imprimir as etiquetas dos produtos acabados?', ['&Sim', '&Não']) = 1 then
              objOrdPro.pImprimeEtiqueta;
          End;
        end;

        If fCfgSis('ENDBAI', varBoolean) And fUsaEnderecamento Then
        Begin
          qryGenSQL:= fCriaQuery;
          Try
            qryGenSQL.Close;
            qryGenSQL.SQL.Clear;
            qryGenSQL.SQL.Add('UPDATE ORDGER SET ORD_PENEND = :PENEND ');
            qryGenSQL.SQL.Add( 'WHERE AUTOINCREM = :AUTINC AND ');
            qryGenSQL.SQL.Add('  ORD_CODEMP = :CODEMP      ');
            qryGenSQL.ParamByName('AUTINC').AsString:= objOrdPro.FieldByName('ORD_SEQGER').AsString;
            qryGenSQL.ParamByName('CODEMP').AsString:= VS_strCodEmp;

            If fExisteLoteADefinir Then
              strLoteADefinir:= 'S'
            Else
              strLoteADefinir:= 'N';

            qryGenSQL.ParamByName('PENEND').AsString:= strLoteADefinir;
            qryGenSQL.ExecSQL;

            If strLoteADefinir = 'N' Then
            Begin
              qryGenSQL.Close;
              qryGenSQL.SQL.Clear;
              qryGenSQL.SQL.Add(' DELETE FROM FATGOR ');
              qryGenSQL.SQL.Add('  WHERE FGO_CODEMP = :CODEMP AND ');
              qryGenSQL.SQL.Add('  (SELECT FGO_ORDIND FROM EXTGOR E ');
              qryGenSQL.SQL.Add('    WHERE E.FGO_SEQFGO = FATGOR.AUTOINCREM) = :AUTINC AND ');
              qryGenSQL.SQL.Add('      FGO_MEN001 LIKE "%PEDIDO DE ENDERECAMENTO DE PRODUTO ACABADO%" ');
              qryGenSQL.ParamByName('AUTINC').AsString:= objOrdPro.FieldByName('ORD_SEQGER').AsString;
              qryGenSQL.ParamByName('CODEMP').AsString:= VS_strCodEmp;
              qryGenSQL.ExecSQL;
            End

          Finally
            FreeAndNil(qryGenSQL);
          End;
        End;

        If FChamadaDeRotinaExterna Then
          FBaixaRealizada:= blnBaixou
        Else
          pMensagemOk('Ordem de Produção baixada com sucesso!');

        strAgrupadorPreAlt := '';
        pLimpaCampos;

        If (blnFecharTela) Then
          btnSair.Click();
      End
      Else
      Begin
        strAgrupadorPreAlt := '';
        If not fEmptyStr(strAutInc) Then
        Begin
          qryCadIte := fCriaQuery;
          qryCadIte.SQL.Text := 'DELETE FROM ORDDET WHERE AUTOINCREM = :AUTINC';
          qryCadIte.ParamByName('AUTINC').AsString := strAutInc;
          qryCadIte.ExecSQL;
          FreeAndNil(qryCadIte)
        End;
      End;

      pnlBotoes.Enabled := True;
    End;

  Finally
    if not blnBaixou then
    Begin
      FBaixaRealizada:= blnBaixou;
      objOrdPro.pRestoreOPI;
    End;

    objOrdPro.pLimpaCdsLotesComponentes;
    If Assigned(obListaErro) Then
      FreeAndNil(obListaErro);

    objOrdPro.LimparcdsLotesGeradosProcedure;

    While objOrdPro.ControlsDisabled Do
      objOrdPro.EnableControls;

    objOrdPro.objCorrOP.AfterScroll :=  AfterScrollLotes;

    While objOrdPro.objCorrOP.ControlsDisabled Do
      objOrdPro.objCorrOP.EnableControls;

    if blnBaixou then
    Begin
      If objOrdPro.blnUtilizaDistribuiLote then
      Begin
        while not objOrdPro.cdsLotesDefinidosPedido.IsEmpty do
          objOrdPro.cdsLotesDefinidosPedido.Delete;
        while not objOrdPro.cdsLotesDefinidosPedidoSaldos.IsEmpty do
          objOrdPro.cdsLotesDefinidosPedidoSaldos.Delete;
      End;
    End;

  End;

end;

function TfrmBaixaOrdProdIndustrial.fExisteLoteADefinir: Boolean;
Begin
  result:= False;

  objOrdPro.First;
  while not(objOrdPro.eof) do
  Begin

    If objOrdPro.FieldByName('NUMLOT').AsString = 'A DEFINIR' Then
    Begin
      If objOrdPro.FieldByName('ORD_QTDENV').AsFloat > 0 Then
      Begin
        result:= True;
        Break;
      End;
    End;

    objOrdPro.Next;
  End;
End;

procedure TfrmBaixaOrdProdIndustrial.btnExcluirClick(Sender: TObject);
var strNumLot: String; strCodIte: String;
begin
  inherited;
  If not TBitBtnLocked(Sender).Visible Then
    Exit;

  If objOrdPro.objCorrOP.FieldByName('DIGITADO').AsString <> 'S' Then
  Begin
    pMensagemOk('É possível excluir somente correção adicionada durante a baixa!');
    Exit;
  End;

  strNumLot := objOrdPro.objCorrOP.FieldByName('NUMLOT').AsString;
  strCodIte := objOrdPro.objCorrOP.FieldByName('DMT_ITESUB').AsString;

  If objOrdPro.objCorrOP.fExcluiCorrecao Then
    objOrdPro.pExcluirCorrecao(strNumLot, strCodIte);
end;

procedure TfrmBaixaOrdProdIndustrial.btnHisBaiClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmObservacao, frmObservacao);
    frmObservacao.lblMensagem.caption := 'Digite o histórico da baixa:';
    frmObservacao.memObs.Texto := strHistoricoBaixa;
    frmObservacao.blnUtilizarConfirmacao := True;
    frmObservacao.ShowModal;
    if (frmobservacao.blnconfirmou) Then
      strHistoricoBaixa := frmObservacao.memObs.Texto;
  Finally
    FreeAndNil(frmObservacao);
  End;
end;

procedure TfrmBaixaOrdProdIndustrial.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If not TBitBtnLocked(Sender).Visible Then
    Exit;

  If blnTrabalhaComLoteMP Then
    objOrdPro.objCorrOP.blnPesquisaLoteApenasComLocalizacao:= True;

  If objOrdPro.objCorrOP.fIncluiCorrecao Then
    objOrdPro.pInsereCorrecaoLote;
end;

procedure TfrmBaixaOrdProdIndustrial.cxgCorrecoesViewMATBOPSimCORRECAOPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if not objOrdPro.objCorrOP.Active then
    exit;

                        //
  If objOrdPro.objCorrOP.State in [dsEdit] then
  begin
    if (objOrdPro.objCorrOP.FieldByName('QTD_OP').AsFloat = 0) and (TcxCurrencyEdit(Sender).Value <= 0) then
    begin
      pMensagemOk('A quantidade da correção deve ser maior que Zero!');
      objOrdPro.objCorrOP.Cancel;
    end
    else If (objOrdPro.objCorrOP.FieldByName('QTD_OP').AsFloat > 0) and ( RoundTo(TcxCurrencyEdit(Sender).Value, -objOrdPro.intCasasDecimaisMateriaPrima )< (-1 * RoundTo(objOrdPro.objCorrOP.FieldByName('QTD_OP').AsFloat, -objOrdPro.intCasasDecimaisMateriaPrima) )) Then
    begin
      pMensagemOk('A quantidade da correção não pode ser menor que a quantidade da OP!');
      objOrdPro.objCorrOP.Cancel;
    end
    else
    begin
      objOrdPro.objCorrOP.FieldByName('DMT_QTDITE').AsFloat := TcxCurrencyEdit(Sender).Value;
      objOrdPro.objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat := RoundTo(objOrdPro.objCorrOP.FieldByName('QTD_OP').AsFloat + objOrdPro.objCorrOP.FieldByName('DMT_QTDITE').AsFloat, -objOrdPro.intCasasDecimaisMateriaPrima);


      If objOrdPro.objCorrOP.State in [dsEdit] then
        objOrdPro.objCorrOP.Post;
    end;
  end;
end;

procedure TfrmBaixaOrdProdIndustrial.cxgCorrecoesViewMATBOPSimCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgCorrecoesViewMATBOPSimQTDOP.Index])) = 0 then
  begin
    ACanvas.Brush.Color := $00C4FFC4;
    ACanvas.Font.Color  := clWindowText;
  end
  else if AViewInfo.Item = cxgCorrecoesViewMATBOPSimCORRECAO then
  begin
    if fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgCorrecoesViewMATBOPSimCORRECAO.Index])) < 0 then
    begin
      ACanvas.Brush.Color := $00CCFFFF;
      ACanvas.Font.Color  := clWindowText;
    end
    else  if fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgCorrecoesViewMATBOPSimCORRECAO.Index])) > 0 then
    begin
      ACanvas.Brush.Color := $00B3B3FF;
      ACanvas.Font.Color  := clWindowText;
    end;
  end;
end;

procedure TfrmBaixaOrdProdIndustrial.cxgCorrecoesViewMATBOPSimExcluirPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if objOrdPro.objCorrOP.FieldByName('QTD_OP').AsFloat = 0 then
    pMensagemOk('É permitido zerar apenas Matérias Primas da fórmula!')
  else
  begin

    objOrdPro.objCorrOP.Edit;
    objOrdPro.objCorrOP.FieldByName('DMT_QTDITE').AsFloat := objOrdPro.objCorrOP.FieldByName('QTD_OP').AsFloat * -1;
    objOrdPro.objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat := 0;
    objOrdPro.objCorrOP.Post;
    If Not objOrdPro.blnUtilizaDistribuiLote Then
      Exit;

    objOrdPro.cdsLotesDefinidosPedido.First;
    while not objOrdPro.cdsLotesDefinidosPedido.Eof do
    Begin
      objOrdPro.cdsLotesDefinidosPedido.Edit;
      objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat := 0;
      objOrdPro.cdsLotesDefinidosPedido.Post;
      objOrdPro.cdsLotesDefinidosPedido.Next;
    End;
  end;
end;

procedure TfrmBaixaOrdProdIndustrial.cxgCorrecoesViewMATBOPSimLotePropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  strNumLote: String;
  fltQtdLoteAtual,
  fltQtdUtilizadaNoLote: Double;
begin
  inherited;
  If blnTrabalhaComLoteMP Then
  Begin
    If objOrdPro.objCorrOP.FieldByName('DMT_QTDITE').AsFloat < 0 Then
    Begin
      If objOrdPro.objCorrOP.State in [dsEdit] then
      Begin
        objOrdPro.pRetornaNumeroLoteFatDor(fltQtdUtilizadaNoLote,
                                 strNumLote,
                                 fltQtdLoteAtual,
                                 qryOrdPro.FieldByName('AUTINC').AsString,
                                 objOrdPro.objCorrOP.FieldByName('DMT_ITESUB').AsString(*,
                                 objOrdPro.objCorrOP.FieldByName('NUMLOT').AsString,
                                 objOrdPro.objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat*));

        objOrdPro.objCorrOP.FieldByName('NUMLOT').AsString:= strNumLote;  
      End;
    End;
  End;
end;

procedure TfrmBaixaOrdProdIndustrial.cxgCorrecoesViewMATBOPSimQTDUTILIZADAPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if not objOrdPro.objCorrOP.Active then
    exit;

  If objOrdPro.objCorrOP.State in [dsEdit] then
  begin
    If ( TcxCurrencyEdit(Sender).Value < 0 ) Then
    begin
      pMensagemOk('A quantidade utilizada não pode ser menor que Zero!');
      objOrdPro.objCorrOP.Cancel;
    end
    else if (objOrdPro.objCorrOP.FieldByName('QTD_OP').AsFloat = 0) and  (TcxCurrencyEdit(Sender).Value = 0) then
    begin
      pMensagemOk('É permitido zerar apenas Matérias Primas da fórmula!');
      objOrdPro.objCorrOP.Cancel;
    end
    else
    begin
      objOrdPro.objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat := TcxCurrencyEdit(Sender).Value;
      objOrdPro.objCorrOP.FieldByName('DMT_QTDITE').AsFloat    := RoundTo(objOrdPro.objCorrOP.FieldByName('QTD_UTILIZADA').AsFloat - objOrdPro.objCorrOP.FieldByName('QTD_OP').AsFloat, -4);
      objOrdPro.objCorrOP.Post;

    end;
  end;

end;

procedure TfrmBaixaOrdProdIndustrial.cxgCorrecoesViewMATBOPNaoColumn5GetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  AText := ReplaceStr(AText, '<<csq>>', ' ');
end;

procedure TfrmBaixaOrdProdIndustrial.cxgCorrecoesViewMATBOPNaoColumn5GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := ReplaceStr(AText, '<<csq>>', ' ');
end;

procedure TfrmBaixaOrdProdIndustrial.cxgItensNUMLOTPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fCfgSis('ENDBAI', varBoolean) And fUsaEnderecamento Then
  Begin

    If (objOrdPro.dtsSource.DataSet.FieldByName('ITE_REAEND').AsString = 'S') Then
    Begin

      If objOrdPro.State = DsEdit Then
      Begin

        If DisplayValue <> 'A DEFINIR' Then
        Begin
          If Not(fProdutoIntermediario(objOrdPro.FieldByName('ORD_CODITE').AsString)) Then
            objOrdPro.dtsSource.DataSet.Cancel;
        End;

      End;

    End;

  End;

end;

procedure TfrmBaixaOrdProdIndustrial.cxgItensViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  blnLoteADEFINIR: Boolean;
begin
  inherited;
  If objOrdPro.blnGerarLotesPelaProcedure Then
  Begin
    blnLoteADEFINIR := objOrdPro.FieldByName('NUMLOT').AsString = 'A DEFINIR';
    TcxButtonEditProperties(cxgItensNUMLOT.Properties).Buttons.Items[0].Visible := blnLoteADEFINIR;
    TcxButtonEditProperties(cxgItensNUMLOT.Properties).Buttons.Items[1].Visible := blnLoteADEFINIR;
    cxgItensNUMLOT.Options.Editing := blnLoteADEFINIR;
  End;
end;

procedure TfrmBaixaOrdProdIndustrial.cxgItensViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (ACellViewInfo.Item.Index = cxgItensViewSITFRA.Index) And
     (VarToStr(Sender.DataController.Values[ACellViewInfo.GridRecord.RecordIndex, cxgItensViewSITFRA.Index]) = 'N') Then
  Begin
    objOrdPro.BeforePost := Nil;
    objOrdPro.pAcertaEmbalagens;
    objOrdPro.BeforePost := objOrdPro.pBeforePost_AcertoEmbalagem;
  End;
end;

procedure TfrmBaixaOrdProdIndustrial.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    fltQtdTot : Double;
begin
  inherited;

  If (rdgTipBai.ItemIndex = 1) Then
    Exit;

  fltQtdTot := (fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensQTDENV.Index])) +
                fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgItensQtdBai.Index])));

  If fltQtdTot = fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgItensQTDPRO.Index])) Then
  Begin

    ACanvas.Brush.Color := clWindow;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;

  End

  Else If fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgItensQTDPRO.Index])) > fltQtdTot Then
  Begin

    ACanvas.Brush.Color := clYellow;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;

  End

  Else
  Begin

    ACanvas.Brush.Color := clRed;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;

  End

  //If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,cxgItensSitFra.Index]) = 'N' Then

end;

procedure TfrmBaixaOrdProdIndustrial.cxgItensViewFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  If cxgItensView.DataController.DataSource.DataSet.State in dsEditModes Then
    objOrdPro.blnAlterandoQtd := (APrevFocusedItem = cxgItensQTDENV) Or (AFocusedItem = cxgItensQTDENV)
  Else
    objOrdPro.blnAlterandoQtd := (AFocusedItem = cxgItensQTDENV);
end;

procedure TfrmBaixaOrdProdIndustrial.cxgItensViewSITFRAGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If AText = 'S' Then AText := 'OK'
  Else AText := 'ACERTAR COMPOSIÇÃO';
end;

procedure TfrmBaixaOrdProdIndustrial.cxvLotesCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  cxvNumLot.Options.Editing :=  VarToStr(Sender.DataController.Values[ARecord.RecordIndex, cxvLotesORIFDO.Index]) <> 'S';
end;

procedure TfrmBaixaOrdProdIndustrial.cxvLotesCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvLotesORIFDO.Index]) = 'S' Then
    ACanvas.Brush.Color := clMoneyGreen;
end;

procedure TfrmBaixaOrdProdIndustrial.cxvLotesEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
var
    arrLotes : TConsultasArray;
    qryConsu : TUniQuery;
    ErrorText : TCaption;
    blnErro: Boolean;
    Value: Variant;
    recNo: integer;
begin
  If fEntraCons(Key) Then
    If AItem = cxvNumLot then
      If AnsiReplaceStr(TcxCustomTextEdit(AEdit).Text, '/','') = '' Then
      Begin

        If VarToStr(Sender.DataController.Values[TcxGridTableDataCellViewInfo(AItem).GridRecord.RecordIndex, cxvLotesORIFDO.Index]) = 'S' then
          Exit;

        qryConsu := fCriaQuery(Self);
        Key := '/';
        Try
          If fPesqLoteItens(Self,
                            Nil,
                            nil,
                            fCfgSis('DECUNI', varInteger),
                            qryConsu,
                            Key,
                            arrLotes,
                            True,
                            objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                            VS_strCodEmp,
                            True, False, nil, False, False, True) Then
          Begin
            recNo := objOrdPro.cdsLotesDefinidosPedido.RecNo;
            Value := qryConsu.FieldByName('LOT_NUMLOT').AsString;
            AItem.EditValue := Value;
            objOrdPro.cdsLotesDefinidosPedido.RecNo := recNo;

            cxvNumLotPropertiesValidate(Sender, Value, ErrorText, blnErro);
{
            objOrdPro.cdsLotesDefinidosPedido.Edit;
            objOrdPro.cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString :=  qryConsu.FieldByName('LOT_NUMLOT').AsString;
            objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALLOT').AsFloat  := fRetSaldosEmpresa(objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                                                                                                  VS_strCodEmp,
                                                                                                  qryConsu.FieldByName('LOT_NUMLOT').AsString);
           objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat  := fRetornaSaldoDisponivel(objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                                                                                                       False,
                                                                                                       True,
                                                                                                       qryConsu.FieldByName('LOT_NUMLOT').AsString,
                                                                                                       True,
                                                                                                       VS_strCodEmp);
            objOrdPro.cdsLotesDefinidosPedido.Post;
}
          End;
        Finally
          FreeAndNil(qryConsu);
        End;
      End;
end;

procedure TfrmBaixaOrdProdIndustrial.cxvLotesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Not objOrdPro.blnUtilizaDistribuiLote Then
    Exit;

  If objOrdPro.cdsLotesDefinidosPedido.FieldByName('ORICOR').AsString = 'S' Then
  Begin
    pMensagemOk('Esta é uma correção, não pode ser inserido ou exluída aqui apenas exibe o lote utilizado, por favor utilize os botões [Incluir, Excluir]!');
    Exit;
  End;
  If Key = VK_INSERT Then
    pInsert
  Else If Key = VK_DELETE Then
    pDelete;




end;


procedure TfrmBaixaOrdProdIndustrial.pLocalizaLoteMatOpe;
var
    arrLotes : TConsultasArray;
    qryConsu : TUniQuery;
    Key: Char;
Begin
  qryConsu := fCriaQuery(Self);
  Key := '/';
  Try
    If objOrdPro.cdsLotesDefinidosPedido.FieldByName('ORIFDO').AsString = 'S' then
       Exit;


    If fPesqLoteItens(Self,
                      Nil,
                      nil,
                      fCfgSis('DECUNI', varInteger),
                      qryConsu,
                      Key,
                      arrLotes,
                      True,
                      objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                      VS_strCodEmp,
                      True, False, nil, False, False, True) Then
    Begin
      objOrdPro.cdsLotesDefinidosPedido.Edit;
      objOrdPro.cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString :=  qryConsu.FieldByName('LOT_NUMLOT').AsString;
      objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALLOT').AsFloat  := fRetSaldosEmpresa(objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                                                                                            VS_strCodEmp,
                                                                                            qryConsu.FieldByName('LOT_NUMLOT').AsString);
      If blnBaiVef Then
        objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat  := fRetornaSaldoFisico(objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                                                                                                True,
                                                                                                qryConsu.FieldByName('LOT_NUMLOT').AsString,
                                                                                                VS_strCodEmp)
      Else
        objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat  := fRetornaSaldoDisponivel(objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                                                                                                    False,
                                                                                                    True,
                                                                                                    qryConsu.FieldByName('LOT_NUMLOT').AsString,
                                                                                                    True,
                                                                                                    VS_strCodEmp);
      objOrdPro.cdsLotesDefinidosPedido.Post;
    End;
  Finally
    FreeAndNil(qryConsu);
  End;

End;

procedure TfrmBaixaOrdProdIndustrial.cxvLotesKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Not fEntraCons(Key) Then
    Exit;
  If Not (cxvNumLot.Focused) Then
    Exit;
  pLocalizaLoteMatOpe;

end;

procedure TfrmBaixaOrdProdIndustrial.cxvNumLotPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  var blnEdicao: Boolean;
     recNo: integer;
begin
  inherited;
  If Not objOrdPro.blnUtilizaDistribuiLote Then
    Exit;

  If DisplayValue = '' Then
  Begin
    DisplayValue := objOrdPro.cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString;
    pMensagemOk('O Lote deve ser definido!');
  End
  Else
  Begin
    If Not fExisteLote(DisplayValue,
                       objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                       VS_strCodEmp,
                       True) Then
    Begin
      pMensagemOk('O Lote informado é inválido!');
      Exit;
    End;

    If fCampoTabela('LOT_LOCFIS', 'CADLOT', ['LOT_CODEMP', 'LOT_NUMLOT'], [VS_strCodEmp, DisplayValue]) = '' Then
    Begin
      DisplayValue := '';
      pMensagemOk('O Lote sem localização fisica!');
      Exit;
    End;

    blnEdicao := False;
    If Not (objOrdPro.cdsLotesDefinidosPedido.State in dsEditModes) then
    begin
      objOrdPro.cdsLotesDefinidosPedido.Edit;
      blnEdicao := True;
    End;
    Try
      If (Not fEmptyStr(objOrdPro.cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString)) And
         (objOrdPro.cdsLotesDefinidosPedido.FieldByName('ORI_FORAORDEM').AsString = 'S') And
         (DisplayValue <>  objOrdPro.cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString) Then
      begin
        recNo := objOrdPro.cdsLotesDefinidosPedido.RecNo;
        objOrdPro.pAjustacdsLotesDefinidosPedidoSaldos(False,
                                                       objOrdPro.cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString,
                                                       objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                                                       - objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat,
                                                       Error);
         objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat  := 0;
         objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDORI').AsFloat  := 0;
         objOrdPro.cdsLotesDefinidosPedido.Post;
         objOrdPro.cdsLotesDefinidosPedido.RecNo := RecNo;
         objOrdPro.cdsLotesDefinidosPedido.Edit;
      End;


      objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALLOT').AsFloat  := fRetSaldosEmpresa(objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                                                                                            VS_strCodEmp,
                                                                                            DisplayValue);

      If (objOrdPro.cdsLotesDefinidosPedido.FieldByName('ORI_FORAORDEM').AsString = 'S') And
         (objOrdPro.cdsLotesDefinidosPedidoSaldos.Locate('NUMLOT;ITESUB', VarArrayOf([DisplayValue, objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString]), [])) Then
      Begin
          objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat  := objOrdPro.cdsLotesDefinidosPedidoSaldos.FieldByName('SALDIS').AsFloat;
          objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat  := 0;
          objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDORI').AsFloat  := 0;
      End
      Else
      Begin
        If blnBaiVef Then
        	objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat  := fRetornaSaldoFisico(objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
            	                                                                                    True,
                	                                                                                DisplayValue,
                    	                                                                            VS_strCodEmp)
        Else
          objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat  := fRetornaSaldoDisponivel(objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                                                                                                      False,
                                                                                                      True,
                                                                                                      DisplayValue,
                                                                                                      True,
                                                                                                      VS_strCodEmp);
      End;
      objOrdPro.cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString := DisplayValue;
      If Not(objOrdPro.cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString = objOrdPro.cdsLotesDefinidosPedido.FieldByName('LOTORI').AsString) Then
        objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat := 0;
    finally
      If blnEdicao Then
        objOrdPro.cdsLotesDefinidosPedido.Post;
    End;

  End;
end;

procedure TfrmBaixaOrdProdIndustrial.cxvQuantidadeCustomDrawFooterCell(
  Sender: TcxGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
var value: String;
begin
  value := varToStr(cxvLotes.DataController.Summary.FooterSummaryValues[0]);
  If value = '' Then
    Exit;

  If objOrdPro.objCorrOP.FieldByName('QTD_UTILIZADA').AsString <> value Then
    ACanvas.FillRect(AViewInfo.Bounds, clRed)    // fill
  Else
    ACanvas.FillRect(AViewInfo.Bounds, clSkyBlue);    // fill

ADone := True;
ACanvas.DrawTexT(AViewInfo.Text, AViewInfo.TextAreaBounds, AViewInfo.AlignmentHorz, AViewInfo.AlignmentVert,  AViewInfo.MultiLine, false);



end;

procedure TfrmBaixaOrdProdIndustrial.cxvQuantidadePropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If Not objOrdPro.blnUtilizaDistribuiLote Then
    Exit;

  If DisplayValue = '' Then
    DisplayValue := '0';

  If fEmptyStr(objOrdPro.cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString) Then
  Begin
    DisplayValue := 0;
    pMensagemOk('Antes de informar a quantidade defina um lote!');
  End  
  Else If (objOrdPro.cdsLotesDefinidosPedido.FieldByName('ORIFDO').AsString <> 'S') And
          (objOrdPro.cdsLotesDefinidosPedido.FieldByName('ORI_FORAORDEM').AsString <> 'S')   Then
  Begin
    If DisplayValue > objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat Then
      Error := True;
  End
  Else
    objOrdPro.pAjustacdsLotesDefinidosPedidoSaldos(False,
                                                   objOrdPro.cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString,
                                                   objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                                                   DisplayValue - objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDORI').AsFloat,
                                                   Error);

  If Error Then
  Begin
    Error := False;
    If (objOrdPro.cdsLotesDefinidosPedido.FieldByName('ORIFDO').AsString <> 'S') Then
      DisplayValue := 0
    Else
      DisplayValue := objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDORI').AsFloat;
    If blnBaiVef Then
      pMensagemOk('Quantidade digitada maior do que o saldo físico disponível')
    Else
      pMensagemOk('Quantidade digitada maior do que o disponível.');
  End
end;

procedure TfrmBaixaOrdProdIndustrial.pLimpaCampos;
Begin
  edtNumOrd.Clear;
  mskDtaCad.Clear;
  qryOrdPro.Close;
  mskDtaIni.Clear;
  mskHorIni.Clear;
  mskDtaFin.Clear;
  mskHorFin.Clear;
  edtLocFis.Clear;
  edtDesLocFis.Clear;
  edtCodQui.Clear;
  edtCodEnc.Clear;
  edtCodLim.Clear;
  edtCodQua.Clear;
  edtNomQui.Clear;
  edtNomEnc.Clear;
  edtNomLim.Clear;
  edtNomQua.Clear;
  objOrdPro.Close;
  objOrdPro.objCorrOP.EmptyDataSet;

  blnMudarFoco := False;

  If Not (FChamadaDeRotinaExterna) Then
    pSetFocus(edtNumOrd);

  rdgTipBai.ItemIndex := 0;
  
  objOrdPro.blnAlterandoQtd := False;
  cxgItensORDITE.Focused := True;
End;

procedure TfrmBaixaOrdProdIndustrial.rdgTipBaiClick(Sender: TObject);
begin
  inherited;
  cxgCorrecoes.Enabled        := (rdgTipBai.ItemIndex <> 1);
  pnlCorrecao.Enabled         := (rdgTipBai.ItemIndex <> 1);
  btnIncluir.Enabled         := (rdgTipBai.ItemIndex <> 1);
  btnAlterar.Enabled         := (rdgTipBai.ItemIndex <> 1);
  btnExcluir.Enabled         := (rdgTipBai.ItemIndex <> 1);
end;

procedure TfrmBaixaOrdProdIndustrial.edtLocFisKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqLocFisAmostraProducao(Self, edtLocFis, edtDesLocFis, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtLocFis, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBaixaOrdProdIndustrial.edtNumOrdKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTabela : TConsultasArray;
begin
  inherited;

  If fPesqOrdProIndustrial(Self, edtNumOrd, mskDtaCad, Nil, Key, arrTabela, poiCodigo, True, staAbertas) Then
  Begin
    If fValidaCampos(edtNumOrd, True) And
       fValidaCampos(mskDtaCad, True) Then
    Begin
      pSetFocus(mskDtaIni);
    End;
  End;

end;

procedure TfrmBaixaOrdProdIndustrial.PesqLotesExecute(Sender: TObject);
begin
  pCarregaLotes('PA');
end;

procedure TfrmBaixaOrdProdIndustrial.pCarregaLotes(strTipoItem: String);
  Var
    chrKey   : Char;
    arrLotes : TConsultasArray;
    qryConsu : TUniQuery;
    edtCodite: TEditFocus;
    blnPermiteInformarLotePoisEItermediario: Boolean;
Begin
  qryConsu := fCriaQuery(Self);
  edtCodite:= TEditFocus.Create(Self);
  blnPermiteInformarLotePoisEItermediario:= fProdutoIntermediario(objOrdPro.FieldByName('ORD_CODITE').AsString);

  chrKey := '/';

  if strTipoItem = 'PA' Then
  Begin
    If (objOrdPro.FieldByName('NUMLOT').AsString <> 'A DEFINIR') AND
       (objOrdPro.FieldByName('ORD_RESIDU').AsString = 'N') Or blnPermiteInformarLotePoisEItermediario Then
    Begin

      edtCodite.Text := objOrdPro.FieldByName('ORD_CODITE').AsString;

      If fPesqLoteItens(Self, Nil, edtCodite, fCfgSis('DECUNI', varInteger), qryConsu, chrKey, arrLotes, True, objOrdPro.FieldByName('ORD_CODITE').AsString, VS_strCodEmp, True, False, nil, False, False) Then
      Begin
        objOrdPro.Edit;
        objOrdPro.FieldByName('NUMLOT').AsString := qryConsu.FieldByName('LOT_NUMLOT').AsString;
        objOrdPro.Post;
      End;

    End;
  End;
  

  FreeAndNil(qryConsu);
End;

procedure TfrmBaixaOrdProdIndustrial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (objOrdPro.Active) And (not objOrdPro.IsEmpty) Then
  Begin
    Action := caNone;
    If fMensagem('', 'Deseja cancelar a baixa da ordem de produção?', ['&Sim', '&Não']) = 1 Then
      pLimpaCampos;

  End;

end;

procedure TfrmBaixaOrdProdIndustrial.FormCreate(Sender: TObject);
  Var
    strDireitos : String;
begin
  inherited;

  FDataCad:= '';
  FOrdProInd:= '';
  FDataValidade:= '';
  FChamadaDeRotinaExterna:= False;
  FValidaBaixaChamadaExterna:= False;
  FPossuiLote:= False;
  FPropCodResiduo:= '';
  FPropLoteResiduo:= '';
  FPropQtdResiduo:= 0;
  FTipoBaixaJaDefinido:= False;
  FValidacaoOK:= False;
  FBaixaRealizada:= False;

  blnBxOpHr:= fCfgSis('BXOPHR', varBoolean);


  objOrdPro := TOrdProIndustrial.Create(Self, Nil, Nil, False, True);
  qryOrdPro := fCriaQuery(Self);
  dtsOrdPro.DataSet := qryOrdPro;

  lblInfoLotesAuto.Visible := objOrdPro.blnGerarLotesPelaProcedure;

  objLiberacao := TLiberacao.Create;

  cxgItensView.DataController.DataSource := objOrdPro.dtsSource;

  mskDtaBai.Text := DateToStr(VS_Date);

  if Not(fCfgSis('CORROP', varBoolean)) Then //Habilita correções na mesma tela
  Begin
    pnlCorrecao.Visible:=False;
  End;

  pnlLocFis.Visible := fCfgSis('ARMAMO', varBoolean);


  //Esta Fixo "frmBaiOrdPro" pois no menu principal esta com esse form na permissão
  //e essa baixa é da OP Industrial (Outro Form)
  If fValidarDirEspecificos(strDireitos, strLoginUsuarioLogado, 'frmCadCorrecaoOrdProducaoIndustrial') Then
  Begin
    {* INSERÇÃO *}
      btnIncluir.Visible := Pos('I', strDireitos) > 0;

    {* ALTERAÇÃO *}
      btnAlterar.Visible := Pos('A', strDireitos) > 0;

    {* EXCLUIR *}
      btnExcluir.Visible := Pos('E', strDireitos) > 0;
  End;

  if objOrdPro.objCorrOP.blnMATBOP then
  begin
    cxgCorrecoesViewMATBOPSim.DataController.DataSource := objOrdPro.objCorrOP.dtsSource;
    cxgCorrecoesLevel1.GridView := cxgCorrecoesViewMATBOPSim;
    btnAlterar.Visible := False;
  end
  else
  begin
    cxgCorrecoesViewMATBOPNao.DataController.DataSource := objOrdPro.objCorrOP.dtsSource;
    cxgCorrecoesLevel1.GridView := cxgCorrecoesViewMATBOPNao;
  end;

  if objOrdPro.objCorrOP.blnMATBOP then
  begin
    cxgCorrecoesViewMATBOPSim.DataController.DataSource := objOrdPro.objCorrOP.dtsSource;
    cxgCorrecoesLevel1.GridView := cxgCorrecoesViewMATBOPSim;
    btnAlterar.Visible := False;
  end
  else
  begin
    cxgCorrecoesViewMATBOPNao.DataController.DataSource := objOrdPro.objCorrOP.dtsSource;
    cxgCorrecoesLevel1.GridView := cxgCorrecoesViewMATBOPNao;
  end;


  objOrdPro.objCorrOP.AfterScroll :=  AfterScrollLotes;

  cxgItensViewSITFRA.Visible := (fCfgSis('COMFRA', varString) = '?');
  lblComFra.Visible := (fCfgSis('COMFRA', varString) = '?');

  lblDtaVal.Visible := fCfgSis('VALIND', varBoolean);
  mskDtaVal.Visible := lblDtaVal.Visible;

  blnFecharTela := False;

  blnTrabalhaComLoteMP:= (fUsaRotinaWMS);
  blnTrabalhaComLoteMP:= blnTrabalhaComLoteMP And (fCfgSis('CORROP', varString) = 'S');


  If Not ((fCfgSis('MATBOP') = 'S') And (fUsaRotinaWMS) And (fCfgSis('OPINLT') = 'S')) Then
  Begin
    pnlLotesDistribuidos.Visible := False;
    sltLotesDistribuidos.Visible := False;
  End;

  blnBaiVef := fCfgSis('BAIVEF', varBoolean);
  Case blnBaiVef Of
     True: cxvSaldis.Caption := 'Saldo Físico Disponível';
    False: cxvSaldis.Caption := 'Saldo Disponível';
  End;

  blnPerOsa := fCfgSis('PEROSA', varBoolean);

end;

procedure TfrmBaixaOrdProdIndustrial.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;

end;

procedure TfrmBaixaOrdProdIndustrial.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If fCheckParent(ActiveControl, cxgItens) And
                  (objOrdPro.State = dsEdit) And cxgItensQTDENV.Focused Then
               Begin
                 cxgItensView.NavigatorButtons.Next.Click;
                 If (objOrdPro.State = dsEdit) Then
                 Begin
                   objOrdPro.Post;
                   pSetFocus(btnConfirma);
                 End;
               End;

     VK_F5: If fCfgSis('CORROP', varBoolean) Then
       btnIncluir.Click;
     VK_F6: If fCfgSis('CORROP', varBoolean) Then
       btnAlterar.Click;
     VK_F7: If fCfgSis('CORROP', varBoolean) Then
       btnExcluir.Click;
     VK_DELETE: If fCheckParent(ActiveControl, cxgCorrecoes) And fCfgSis('CORROP', varBoolean) Then
       btnExcluir.Click;
  End;

end;

procedure TfrmBaixaOrdProdIndustrial.pInicializaOnShowDaTela;
Var
  Key : Char;
begin
  inherited;

  If Not (FChamadaDeRotinaExterna) Then
    pSetFocus(edtNumOrd);



  If (mskDtaCad.Text <> '  /  /    ') And (Not fEmptyStr(edtNumOrd.Text)) Then
  Begin
    If (fValidaCampos(mskDtaCad, True)) Then
    Begin
      blnFecharTela := True;

      If Not (FChamadaDeRotinaExterna) Then
        pSetFocus(mskDtaIni);

    End;
  End;

  If (Not(fCfgSis('CONTMP', varBoolean))) then
  Begin
    Label2.Visible    := False;
    Label3.Visible    := False;
    mskDtaIni.Visible := False;
    mskHorIni.Visible := False;
    mskDtaFin.Visible := False;
    mskHorFin.Visible := False;
    Panel1.Height     := 124;
    rdgTipBai.Left    := 167;
    rdgTipBai.Top     := 60;
    lblDtaBai.Top     := 99;
    lblDtaVal.Top     := 99;
    mskDtaVal.Top     := 95;
    mskDtaBai.Top     := 95;
  End;

  If Not fEmptyStr(FOrdProInd) And blnChamadaDeRotinaExterna Then
  Begin
    edtNumOrd.Text := FOrdProInd;
    mskDtaCad.Text := FDataCad;
    If fValidaCampos(mskDtaCad, True) Then
    Begin
      edtNumOrd.Enabled := False;
      edtNumOrd.onKeyPress(edtNumOrd, Key);

      If Not (FChamadaDeRotinaExterna) Then
        pSetFocus(mskDtaIni);

    End
  End;


  rdgTipBai.Visible      := fCfgSis('OIBXPA', varBoolean);
  cxgItensQtdBai.Visible := fCfgSis('OIBXPA', varBoolean);
  pnlModel9.Visible      := (fCfgSis('MDORIN', varInteger) = 9) Or (fCfgSis('MDORIN', varInteger) = 31);
end;


procedure TfrmBaixaOrdProdIndustrial.FormShow(Sender: TObject);
begin
  inherited;

  pInicializaOnShowDaTela;

end;

function TfrmBaixaOrdProdIndustrial.fRtornaNumLoteAtivo(strCodIte: String): String;
var
  qryConsulta: TUniQuery;
Begin
  result:= '';

  qryConsulta:= fCriaQuery();
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT LOT_NUMLOT, IFNULL(LOT_PRIIND,"N") AS LOT_PRIIND FROM CADLOT ');
    qryConsulta.SQL.Add('     WHERE LOT_CODITE = "'+strCodIte+'"    AND ');
    qryConsulta.SQL.Add('           LOT_CODEMP = "'+VS_strCodEmp+'" AND ');
    qryConsulta.SQL.Add('           LOT_NUMLOT <> "A DEFINIR"       AND ');
    qryConsulta.SQL.Add('           LOT_NUMLOT <> "GARANTIA"        AND ');
    qryConsulta.SQL.Add('           LOT_STATUS = "S"                    ');
    qryConsulta.SQL.Add('    ORDER BY IFNULL(LOT_PRIIND,"N") DESC       ');
    qryConsulta.Open;

    If qryConsulta.RecordCount = 1 Then
      result:= qryConsulta.FieldByName('LOT_NUMLOT').AsString
    Else If qryConsulta.Locate('LOT_PRIIND','S',[]) Then
      result := qryConsulta.FieldByName('LOT_NUMLOT').AsString
    Else
      result:= '';

  Finally
    FreeAndNil(qryConsulta);
  End;

End;

procedure TfrmBaixaOrdProdIndustrial.pCarregaNumLoteSeHouver;
var
  strNumeroLote: String;
  objCadLot    : TCadLot;
  blnTemLote   : boolean;
begin
  blnTemLote := False;
  FPossuiLote:= True;
  Try
    objCadLot := TCadLot.Create(Nil);
    strNumeroLote:= '';
    objOrdPro.dtsSource.DataSet.First;
    While Not(objOrdPro.dtsSource.DataSet.eof) do
    Begin

      If fCfgSis('ENDBAI', varBoolean) And fUsaEnderecamento Then
      Begin

        If (objOrdPro.dtsSource.DataSet.FieldByName('ITE_REAEND').AsString = 'S') Then
        Begin

          blnTemLote := True;

          objOrdPro.dtsSource.DataSet.Edit;
          objOrdPro.dtsSource.DataSet.FieldByName('NUMLOT').AsString:= 'A DEFINIR';

          If Not(cxgItensNUMLOT.Visible) Then
          Begin
            cxgItensNUMLOT.Visible:= True;
          End;

          objOrdPro.dtsSource.DataSet.Post;

        End;

      End;


      If (objOrdPro.dtsSource.DataSet.FieldByName('NUMLOT').AsString <> 'A DEFINIR') And objCadLot.fExisteLote(objOrdPro.dtsSource.DataSet.FieldByName('ORD_CODITE').AsString, VS_strCodEmp, '', False, False, False) Then
      Begin
         blnTemLote := True;
        {Caso o produto tenha lote torna visivel o campo lote}
        If Not cxgItensNUMLOT.Visible Then
        Begin
          cxgItensDESITE.Width := cxgItensDESITE.Width - cxgItensNUMLOT.Width;
          cxgItensNUMLOT.Visible := True;
        End;

        strNumeroLote:= fRtornaNumLoteAtivo(objOrdPro.dtsSource.DataSet.FieldByName('ORD_CODITE').AsString);

        If Not(fEmptyStr(strNumeroLote)) Then
        Begin

          objOrdPro.dtsSource.DataSet.Edit;
          objOrdPro.dtsSource.DataSet.FieldByName('NUMLOT').AsString:= strNumeroLote;

          If Not(cxgItensNUMLOT.Visible) Then
          Begin
            cxgItensNUMLOT.Visible:= Not(fEmptyStr(objOrdPro.dtsSource.DataSet.FieldByName('NUMLOT').AsString));
          End;

          If objOrdPro.dtsSource.DataSet.State = DsEdit Then
            objOrdPro.dtsSource.DataSet.Post;

        End
        Else

        If blnChamadaDeRotinaExterna Then
        Begin
          If (objOrdPro.dtsSource.DataSet.FieldByName('ORD_QTDPRO').AsFloat > 0) And FPossuiLote Then
            FPossuiLote:= False;
        End;

      End
      Else
      Begin
        If blnChamadaDeRotinaExterna Then
        Begin
          If (objOrdPro.dtsSource.DataSet.FieldByName('ORD_QTDPRO').AsFloat > 0) And FPossuiLote Then
            FPossuiLote:= False;
        End;
      End;

      objOrdPro.dtsSource.DataSet.Next;

    End;
  Finally
    If (not blnTemLote) And (cxgItensNUMLOT.Visible) Then
    Begin
      cxgItensDESITE.Width := cxgItensDESITE.Width + cxgItensNUMLOT.Width;
      cxgItensNUMLOT.Visible := False;
    End;
    FreeAndNil(objCadLot);
  End;
end;


function TfrmBaixaOrdProdIndustrial.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  CONST

  SQL_CORRECAO = ' SELECT *,                             '+
                 '        0.0000 AS QTD_OP ,             '+
                 '        0.0000 AS QTD_UTILIZADA,       '+
                 '        "" AS REFERENCIA FROM DEICOR D ';

  SQL_CORRECAO_WHERE = ' WHERE DMT_SEQORD = :SEQORD ';
Var
  blnValidaBaixa: Boolean;
  strAnalisesAberto: String;

begin
  Result := True;

  If blnChamadaDeRotinaExterna Then
    FValidacaoOK:= Result;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumOrd) Then
    Begin

      If fEmptyStrEspeciais(edtNumOrd.Text) Then
      Begin
        pMensagemOk('Informe o Número da Ordem de Produção!');
        Result := False;
      End

    End

    Else If (Sender = mskDtaCad) Then
    Begin

      If fEmptyDate(mskDtaCad.Text) Then
      Begin
        pMensagemOk('Informe a Data de Cadastro da Ordem de Produção!');
        Result := False;
      End

      Else If Not objOrdPro.fExisteLoteOP(qryOrdPro, edtNumOrd.Text, StrToDateDef(mskDtaCad.Text, 0)) Then
      Begin
        Result := False;
        pMensagemOk('Ordem de Produção não encontrada!');
      End

      Else If Not qryOrdPro.FieldByName('DTABAI').IsNull Then
      Begin
        Result := False;
        pMensagemOk('Ordem de Produção já baixada!');
      End

      Else
      Begin
        mskDtaCad.Text := FormatDateTime('DD/MM/YYYY', StrToDateDef(mskDtaCad.Text, 0));

        If Not blnPerOsa Then
        Begin
          strAnalisesAberto := '';
          If TOrdProIndustrial.fDeveGerarAnalise(qryOrdPro.FieldByName('AUTINC').AsString) And TOrdProIndustrial.fNenhumaAnaliseGerada(qryOrdPro.FieldByName('AUTINC').AsString) Then
          Begin
            Result := False;
            pMensagemOk('A ordem de produção possui análise de amostras em sua fórmula e nenhuma análise foi criada!' + #13#10 + 'Não será possível prosseguir!');
            Exit;
          End
          Else If TOrdProIndustrial.fExisteAnaliseAberto(qryOrdPro.FieldByName('AUTINC').AsString, strAnalisesAberto) Then
          Begin
            Result := False;
            pMensagemOk('Existem análises de amostra em aberto para esta ordem de produção!' + #13#10 + strAnalisesAberto + #13#10 + 'Não será possível prosseguir!');
            Exit;
          End;
        End;

        If objOrdPro.IsEmpty Or
             (qryOrdPro.FieldByName('AUTINC').AsString <> objOrdPro.FieldByName('ORD_SEQGER').AsString) Then
        Begin
          If FValidaBaixaChamadaExterna Then
          Begin
            blnValidaBaixa := objOrdPro.fValidaBaixa(qryOrdPro.FieldByName('AUTINC').AsString);
            If Not blnValidaBaixa Then
            Begin
              Result:= False;
              blnValidacaoOK:= False;
              Exit;
            End;
          End
          Else
            blnValidaBaixa := True;
            objOrdPro.CarregandoItens := True;
            Try
              Result := blnValidaBaixa
                      And
                      objOrdPro.fCarregaItens(qryOrdPro.FieldByName('AUTINC').AsString,
                                              qryOrdPro.FieldByName('CODITE').AsString,
                                              qryOrdPro.FieldByName('CODCOR').AsString,
                                              False,
                                              True, False)
                      And
                      objOrdPro.fPodeBaixarOP(qryOrdPro.FieldByName('AUTINC').AsString);
            Finally
              objOrdPro.CarregandoItens := False;
            End;

          pCarregaNumLoteSeHouver;
          If objOrdPro.blnUtilizaDistribuiLote Then
          Begin
            dtsLotes.DataSet := objOrdPro.cdsLotesDefinidosPedido;
            cxvLotes.ViewData.Expand(True);
          End;


          if Result then
            Result := objOrdPro.fValidaUnidadesItens;

          If Result Then
          Begin
            strHistoricoBaixa := fCampoTabela('ORD_HISTOR', 'ORDHIS', ['ORD_SEQGER'], [qryOrdPro.FieldByName('AUTINC').AsString]);

            if blnBuscaPorChave then
            begin
              if not qryOrdPro.FieldByName('ORD_DTAVAL').IsNull then
                mskDtaVal.Text := FormatDateTime('DD/MM/YYYY', qryOrdPro.FieldByName('ORD_DTAVAL').AsDateTime)
              else
                mskDtaVal.Text := '';
            end;


            If fCfgSis('COMFRA', varString) = '?' Then
            Begin
              Try
                objOrdPro.DisableControls;
                objOrdPro.First;
                While Not objOrdPro.Eof Do
                Begin
                  objOrdPro.Edit;
                  If objOrdPro.fTemComposicaoParaCorrecao(True) Then
                    objOrdPro.FieldByName('SITFRA').AsString := 'N'
                  Else
                    objOrdPro.FieldByName('SITFRA').AsString := 'S';
                  objOrdPro.Post;

                  objOrdPro.Next;
                End;

                objOrdPro.BeforePost := objOrdPro.pBeforePost_AcertoEmbalagem;

              Finally
                objOrdPro.First;
                objOrdPro.EnableControls;
              End;
            End;

            If fExisteCorrecao(qryOrdPro.FieldByName('AUTINC').AsString) Then
            Begin
              FreeAndNil(objOrdPro.objCorrOP);
              objOrdPro.objCorrOP := TOrdProIndCorrecoes.Create(objOrdPro, True, qryOrdPro.FieldByName('AUTINC').AsString);
              objOrdPro.pCompletaCorrecoes;
              objOrdPro.objCorrOP.AfterScroll :=  AfterScrollLotes;
              If objOrdPro.objCorrOP.blnMATBOP then
              begin
                cxgCorrecoesViewMATBOPSim.DataController.DataSource := objOrdPro.objCorrOP.dtsSource;
                cxgCorrecoesLevel1.GridView := cxgCorrecoesViewMATBOPSim;
                btnAlterar.Visible := False;
              end
              Else
              begin
                cxgCorrecoesViewMATBOPNao.DataController.DataSource := objOrdPro.objCorrOP.dtsSource;
                cxgCorrecoesLevel1.GridView := cxgCorrecoesViewMATBOPNao;
              end;

            End;

            If objOrdPro.blnUtilizaDistribuiLote And
               Assigned(objOrdPro.objCorrOP) And
               objOrdPro.blnBaiVef And
               objOrdPro.objCorrOP.blnMATBOP Then
              objOrdPro.pRedistribuiQtdUtiPorSaldoFisico;

            cxgItensView.ApplyBestFit();
            cxgItensView.NavigatorButtons.First.Click;
            cxgItensNUMLOT.Width := 215;

          End
          else
            pLimpaCampos;
        End;

      End;
    End

    Else If (Sender = mskDtaIni) and fCfgSis('CONTMP', varBoolean) Then
    Begin

      If (fEmptyDate(mskDtaIni.Text)) Then
      Begin
        pMensagemOk('Informe a Data de início da Produção!');
        Result := False;
      End

      Else If (StrToDateDef(mskDtaIni.Text, 0) > VS_Date)  Then
      Begin
        pMensagemOk('A Data de início da Produção maior que atual!');
        Result := False;
      End

      Else If (StrToDateDef(mskDtaIni.Text, 0) < StrToDateDef(mskDtaCad.Text, 0) ) Then
      Begin
        pMensagemOk('A Data de início da Produção deve ser maior ou igual a data de cadastro!');
        Result := False;
      End

      Else mskDtaIni.Text := FormatDateTime('DD/MM/YYYY', StrToDateDef(mskDtaIni.Text, 0));

    End

    Else If ((Sender = mskHorIni) and fCfgSis('CONTMP', varBoolean)) and blnBxOpHr Then
    Begin

      If (fEmptyDate(mskHorIni.Text)) Then
      Begin
        pMensagemOk('Informe a Hora de início da Produção!');
        Result := False;
      End

      Else If StrToTimeDef(mskHorIni.Text, -1) < 0 Then
      Begin
        pMensagemOk('Hora de início inválida');
        Result := False;
      End;

    End

    Else If (Sender = mskDtaFin) And fCfgSis('CONTMP', varBoolean) Then
    Begin

      If (fEmptyDate(mskDtaFin.Text)) Then
      Begin
        pMensagemOk('Informe a Data final da Produção!');
        Result := False;
      End

      Else If StrToDateDef(mskDtaFin.Text, 0) > VS_Date Then
      Begin
        pMensagemOk('A Data final da Produção maior que atual!');
        Result := False;
      End

      Else If (StrToDateDef(mskDtaFin.Text, 0) < StrToDateDef(mskDtaIni.Text, 0)) Then
      Begin
        pMensagemOk('A Data final da Produção deve ser maior ou igual a data de início!');
        Result := False;
      End

      Else mskDtaFin.Text := FormatDateTime('DD/MM/YYYY', StrToDateDef(mskDtaFin.Text, 0));

    End

    Else If ((Sender = mskHorFin) And fCfgSis('CONTMP', varBoolean)) and blnBxOpHr Then
    Begin

      If fEmptyDate(mskHorFin.Text) Then
      Begin
        pMensagemOk('Informe a Hora final da Produção!');
        Result := False;
      End

      Else If StrToTimeDef(mskHorFin.Text, -1) < 0 Then
      Begin
        pMensagemOk('Hora final inválida');
        Result := False;
      End

      Else If StrToDateDef(mskDtaFin.Text, 0) + StrToTimeDef(mskHorFin.Text, 0) <
              StrToDateDef(mskDtaIni.Text, 0) + StrToTimeDef(mskHorIni.Text, 0) Then
      Begin
        pMensagemOk('A Data/Hora final da Produção deve ser maior ou igual a Data/Hora de início!');
        Result := False;
      End;

    End

    Else If (Sender = mskDtaBai) Then
    Begin

      If fEmptyDate(mskDtaBai.Text) Then
      Begin
        pMensagemOk('Informe a Data da baixa da Produção!');
        Result := False;
      End

      Else If StrToDateDef(mskDtaBai.Text, 0) > VS_Date Then
      Begin
        pMensagemOk('A Data da baixa maior que atual!');
        Result := False;
      End

      Else If StrToDateDef(mskDtaBai.Text, 0) < StrToDateDef(mskDtaFin.Text, 0) Then
      Begin
        pMensagemOk('A Data da baixa da Produção deve ser maior ou igual a data final!');
        Result := False;
      End Else
      Begin
        mskDtaBai.Text := FormatDateTime('DD/MM/YYYY', StrToDateDef(mskDtaBai.Text, 0));

        If blnBuscaPorChave then
        begin
          if (qryOrdPro.FieldByName('ORD_DTAVAL').IsNull) Or (StrToDateDef(mskDtaVal.Text, 0) <> qryOrdPro.FieldByName('ORD_DTAVAL').AsDateTime) Then
            mskDtaVal.Text := FormatDateTime('DD/MM/YYYY', IncMonth(StrToDateDef(mskDtaBai.Text, 0), fCampoTabela('ITE_PRAVAL', 'CADITE', ['ITE_CODITE'], [dbeCodIte.Text])));
        end;

      End;

    End

    Else If (Sender = mskDtaVal) and mskDtaVal.Visible Then
    Begin

      If FChamadaDeRotinaExterna Then
        mskDtaVal.Text:= FDataValidade;

      If fEmptyDate(mskDtaVal.Text) Then
      Begin
        pMensagemOk('Informe a Data de Validade!');
        Result := False;
      End

      Else If StrToDateDef(mskDtaVal.Text, 0) < VS_Date Then
      Begin
        pMensagemOk('A Data de Validade Menor que a Data Atual!');
        Result := False;
      End

      Else
      Begin
        mskDtaVal.Text := FormatDateTime('DD/MM/YYYY', StrToDateDef(mskDtaVal.Text, 0));

        If blnBuscaPorChave Then
          cxgItensQTDENV.Focused := True;
      End;

    End

    Else
    If (Sender = edtLocFis) And pnlLocFis.Visible Then
    Begin
      If fEmptyStr(edtLocFis.Text) then
      Begin
        Result := False;
        fMensagem('','A localização física da amostra é obrigatória!', ['&OK']);
      End
      Else
      Begin
        edtDesLocFis.Text := fRetNomeLocFisAmostraProducao(edtLocFis.Text);
        If fEmptyStr(edtDesLocFis.Text) Then
        Begin
          Result := False;
          fMensagem('','A localização física da amostra não existe!' + #13 + 'Utilize a tecla INSERT para cadastrar uma localização nova.', ['&OK']);
        End;
      End;

    End

    Else
    If (Sender = edtCodQui) and pnlModel9.Visible And Not(FChamadaDeRotinaExterna) Then
    Begin
      edtNomQui.Text := fRetNomVendRep(edtCodQui.Text);
      Result := not fEmptyStr(edtNomQui.Text);
      If not Result Then
        fMensagem('', 'Preencha o Químico Responsável!', ['&OK']);
    End

    Else
    If (Sender = edtCodEnc) and pnlModel9.Visible And Not(FChamadaDeRotinaExterna) Then
    Begin
      edtNomEnc.Text := fRetNomVendRep(edtCodEnc.Text);
      Result := not fEmptyStr(edtNomEnc.Text);
      If not Result Then
        fMensagem('', 'Preencha o Encarregado da Produção!', ['&OK']);
    End

    Else
    If (Sender = edtCodLim) and pnlModel9.Visible And Not(FChamadaDeRotinaExterna) Then
    Begin
      edtNomLim.Text := fRetNomVendRep(edtCodLim.Text);
      Result := not fEmptyStr(edtNomLim.Text);
      If not Result Then
        fMensagem('', 'Preencha o Responsável pela Limpeza/Sanitização!', ['&OK']);
    End

    Else
    If (Sender = edtCodQua) and pnlModel9.Visible And Not(FChamadaDeRotinaExterna) Then
    Begin
      edtNomQua.Text := fRetNomVendRep(edtCodQua.Text);
      Result := not fEmptyStr(edtNomQua.Text);
      If not Result Then
        fMensagem('', 'Preencha o Responsável pelo Controle de Qualidade!', ['&OK']);
    End


  End;

  If blnChamadaDeRotinaExterna Then
    FValidacaoOK:= Result;

  If Not Result Then
  begin
    if blnMudarFoco then
    begin
      blnMudarFoco := False;
      pSetFocus(Sender);
    end;
  end;
end;

procedure TfrmBaixaOrdProdIndustrial.edtLocFisKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If fIsInsert(Key) Then
  Begin
    edtLocFis.Text := fChamaCadLocFisAmostraProducao(Key);
  End;
end;

procedure TfrmBaixaOrdProdIndustrial.edtCodEncKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fPesqOperador(Self, edtCodEnc, edtNomEnc, nil, Key, arrVen)) Then
  Begin
    If fValidaCampos(edtCodEnc, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaOrdProdIndustrial.edtCodLimKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fPesqOperador(Self, edtCodLim, edtNomLim, nil, Key, arrVen)) Then
  Begin
    If fValidaCampos(edtCodLim, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaOrdProdIndustrial.edtCodQuaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fPesqOperador(Self, edtCodQua, edtNomQua, nil, Key, arrVen)) Then
  Begin
    If fValidaCampos(edtCodQua, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaOrdProdIndustrial.edtCodQuiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fPesqOperador(Self, edtCodQui, edtNomQui, nil, Key, arrVen)) Then
  Begin
    If fValidaCampos(edtCodQui, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaOrdProdIndustrial.edtLocFisEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmBaixaOrdProdIndustrial.edtLocFisExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmBaixaOrdProdIndustrial.LoteRapidoExecute(Sender: TObject);
  Var
    frmCadLoteItens: TfrmCadLoteItens;
    qryGen: TUniQuery;
    strLotCad : String;
    intMesVal : Integer;
begin
  inherited;
  If Not fVerificaAcessoSistema('frmCadLoteItensRapido') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso ao cadastro de Lotes!', ['&O k']);
    Exit;
  End;

  Try
    intMesVal := fCampoTabela('ITE_PRAVAL', 'CADITE', ['ITE_CODITE'], [objOrdPro.FieldByName('ORD_CODITE').AsString]);

    pCriarFormularios(TfrmCadLoteItens, frmCadLoteItens);
    frmCadLoteItens.strCodigoItemCadastroRapidoWMS   := objOrdPro.FieldByName('ORD_CODITE').AsString;
    frmCadLoteItens.strDataValidadeCadastroRapidoWMS := DateToStr(IncMonth(VS_Date, intMesVal));
    frmCadLoteItens.strNumLotProdAca:= FormatDateTime('DDMMYY', objOrdPro.FieldByName('ORD_DTACAD').AsDateTime)+'-'+objOrdPro.FieldByName('ORD_CODORD').AsString;
    frmCadLoteItens.blnBaixaOPI:= True;

    frmCadLoteItens.tipoCadastro := tclOrdemProducaoIndustrial;
    frmCadLoteItens.ShowModal;
    strLotCad := frmCadLoteItens.strNumeroLoteCadastroRapidoWMS;

    If (fCfgSis('LOTEND', varString) = '2') And fUsaRotinaWMS Then
    Begin
      qryGen:= fCriaQuery();
      Try
        qryGen.SQL.Add(' UPDATE CADLOT SET LOT_CODBAR = :NUMLOT ');
        qryGen.SQL.Add('   WHERE LOT_CODEMP = :CODEMP AND       ');
        qryGen.SQL.Add('         LOT_CODITE = :CODITE AND       ');
        qryGen.SQL.Add('         LOT_NUMLOT = :NUMLOT           ');

        qryGen.ParamByName('CODEMP').AsString:= VS_strCodEmp;
        qryGen.ParamByName('NUMLOT').AsString:= strLotCad;
        qryGen.ParamByName('CODITE').AsString:= objOrdPro.FieldByName('ORD_CODITE').AsString;
        qryGen.ExecSQL;
      Finally
        FreeAndNil(qryGen);
      End;
    End;

    If fCfgSis('ENDBAI', varBoolean) And fUsaEnderecamento Then
    Begin
      If fProdutoIntermediario(objOrdPro.FieldByName('ORD_CODITE').AsString) Then
      Begin
        If (objOrdPro.dtsSource.DataSet.FieldByName('ITE_REAEND').AsString = 'S') Then
        Begin
          objOrdPro.Edit;
          objOrdPro.FieldByName('NUMLOT').AsString := strLotCad;
          objOrdPro.Post;
        End;
      End;
    End
    Else
    If Not fEmptyStr(strLotCad) Then
    Begin
      objOrdPro.Edit;
      objOrdPro.FieldByName('NUMLOT').AsString := strLotCad;
      objOrdPro.Post;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmCadLoteItens);

end;

procedure TfrmBaixaOrdProdIndustrial.mskDtaIniDblClick(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text  := DateToStr(fNow);
  mskDtaFin.Text  := DateToStr(fNow);
  mskDtaBai.Text  := DateToStr(fNow);
  mskDtaVal.Text  := DateToStr(fNow);
end;

procedure TfrmBaixaOrdProdIndustrial.pInsert;
  var
    qryConsu : TUniQuery;
    arrLotes : TConsultasArray;
    strCodIte: String;
    strDesIte: String;
    strFatDor: String;
    strIteAti: String;
    strSEQUEN: String;
    strACADES: String;
    chrKey: Char;
begin
  If Not objOrdPro.blnUtilizaDistribuiLote Then
    Exit;

  objOrdPro.cdsLotesDefinidosPedido.DisableControls;
  qryConsu := fCriaQuery;
  Try
    strCodIte := objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString;
    strDesIte := objOrdPro.cdsLotesDefinidosPedido.FieldByName('DESITE').AsString;
    strFatDor := objOrdPro.cdsLotesDefinidosPedido.FieldByName('SEQFDO').AsString;
    strIteAti := objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITEACA').AsString;
    strSEQUEN := objOrdPro.cdsLotesDefinidosPedido.FieldByName('SEQUEN').AsString;
    strACADES := objOrdPro.cdsLotesDefinidosPedido.FieldByName('ACADES').AsString;

    chrKey := '/';

    If fPesqLoteItens(Self,
                      Nil,
                      nil,
                      fCfgSis('DECUNI', varInteger),
                      qryConsu,
                      chrKey,
                      arrLotes,
                      True,
                      strCodIte,
                      VS_strCodEmp,
                      True,
                      False,
                      nil,
                      False,
                      False,
                      True) Then
      pProcessaInsercao(qryConsu, strCodIte, strDesIte, strFatDor, strIteAti, strSEQUEN, strACADES);

  Finally
    objOrdPro.cdsLotesDefinidosPedido.EnableControls;
    FreeAndNil(qryConsu);
  End;
End;

procedure TfrmBaixaOrdProdIndustrial.pProcessaInsercao(qryConsu: TUniQuery; strCodIte, strDesIte, strAutIncFDO, strIteAca, strSEQUEN, strACADES: String);
begin
  If Not objOrdPro.blnUtilizaDistribuiLote Then
    Exit;

  objOrdPro.cdsLotesDefinidosPedido.Filtered := False;
  objOrdPro.cdsLotesDefinidosPedido.Filter := 'ITESUB = ' + QuotedStr(strCodIte);
  objOrdPro.cdsLotesDefinidosPedido.Filtered := True;
  Try

    If objOrdPro.cdsLotesDefinidosPedido.Locate('NUMLOT;ITESUB', VarArrayOf([qryConsu.FieldByName('LOT_NUMLOT').AsString, strCodIte]), []) Then
    Begin
      pMensagemOk('Lote ' + qryConsu.FieldByName('LOT_NUMLOT').AsString + ' já definido!');
      Exit;

    End;

    objOrdPro.cdsLotesDefinidosPedido.Insert;
    objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString := strCodIte;
    objOrdPro.cdsLotesDefinidosPedido.FieldByName('DESITE').AsString := strDesIte;
    objOrdPro.cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString := qryConsu.FieldByName('LOT_NUMLOT').AsString;
    objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat  := 0.0000;
    objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALLOT').AsFloat  := fRetSaldosEmpresa(strCodIte, VS_strCodEmp,  qryConsu.FieldByName('LOT_NUMLOT').AsString);
    If blnBaiVef Then
      objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat  := fRetornaSaldoFisico(strCodIte,
                                                                                              True,
                                                                                              qryConsu.FieldByName('LOT_NUMLOT').AsString,
                                                                                              VS_strCodEmp)
	  Else
      objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat  := fRetornaSaldoDisponivel(strCodIte,
                                                                                                  False,
                                                                                                  True,
                                                                                                   qryConsu.FieldByName('LOT_NUMLOT').AsString,
                                                                                                  True,
                                                                                                  VS_strCodEmp);

    objOrdPro.cdsLotesDefinidosPedido.FieldByName('SEQFDO').AsString := strAutIncFDO;
    objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITEACA').AsString := strIteAca;
    objOrdPro.cdsLotesDefinidosPedido.FieldByName('SEQUEN').AsString := strSequen;
    objOrdPro.cdsLotesDefinidosPedido.FieldByName('ACADES').AsString := strACADES;


    objOrdPro.cdsLotesDefinidosPedido.FieldByName('ORIFDO').AsString := 'N';
    objOrdPro.cdsLotesDefinidosPedido.Post;
  Finally
    objOrdPro.cdsLotesDefinidosPedido.Filtered := False;
    objOrdPro.cdsLotesDefinidosPedido.Filter := 'ITESUB = ' + QuotedStr(strCodIte);
    objOrdPro.cdsLotesDefinidosPedido.Filtered := True;
    objOrdPro.cdsLotesDefinidosPedido.First;
    objOrdPro.cdsLotesDefinidosPedido.Locate('NUMLOT;ITESUB', VarArrayOf([qryConsu.FieldByName('LOT_NUMLOT').AsString, strCodIte]), [])
  End;
End;

procedure TfrmBaixaOrdProdIndustrial.pDelete;
var
  blnError: Boolean;
begin
  If Not objOrdPro.blnUtilizaDistribuiLote Then
    Exit;

  if fPergunta('Excluir o lote ' + objOrdPro.cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString + '?') then
  Begin
    If objOrdPro.cdsLotesDefinidosPedido.FieldByName('ORI_FORAORDEM').AsString = 'S' Then
    Begin
      objOrdPro.cdsLotesDefinidosPedido.Edit;
      objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat  := 0;
      objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALLOT').AsFloat  := 0;
      objOrdPro.cdsLotesDefinidosPedido.FieldByName('SALDIS').AsFloat  := 0;
      objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDORI').AsFloat  := 0;
      objOrdPro.cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString := '';
      objOrdPro.cdsLotesDefinidosPedido.Post;
      pMensagemOk('Este registro não será removido, pois é preciso ter ao menos um lote para itens fora da Ordem Original, a quantidade será zerada e não movimentará estoque.');
    End
    Else If objOrdPro.cdsLotesDefinidosPedido.FieldByName('ORIFDO').AsString = 'N' Then
      objOrdPro.cdsLotesDefinidosPedido.Delete
    Else
    Begin
      objOrdPro.pAjustacdsLotesDefinidosPedidoSaldos(False,
                                                     objOrdPro.cdsLotesDefinidosPedido.FieldByName('NUMLOT').AsString,
                                                     objOrdPro.cdsLotesDefinidosPedido.FieldByName('ITESUB').AsString,
                                                    -objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDORI').AsFloat,
                                                     blnError);
      If Not blnError Then
      Begin
        objOrdPro.cdsLotesDefinidosPedido.Edit;
        objOrdPro.cdsLotesDefinidosPedido.FieldByName('QTDUTI').AsFloat := 0;
        objOrdPro.cdsLotesDefinidosPedido.Post;
        pMensagemOk('Lotes sugeridos pelo Autcom não podem ser removidos, a quantidade será zerada e não movimentará estoque.');
      End
      Else
      Begin
        blnError := False;
        If blnBaiVef Then
          pMensagemOk('Quantidade digitada maior do que o saldo físico disponível')
        Else
          pMensagemOk('Quantidade digitada maior do que o disponível.');
      End;
    End;
  End;
End;

end.
