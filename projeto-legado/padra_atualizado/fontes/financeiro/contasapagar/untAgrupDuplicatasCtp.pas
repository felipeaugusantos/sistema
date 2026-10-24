{**********************}
{* qryConEmp = CADEMP *}
{* qryConFor = CADFOR *}
{*******************JB*}
unit untAgrupDuplicatasCtp;

interface

uses
  Windows, Types, Classes, Controls, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids,
  Mask, untFuncoes, Uni, MaskEditFocus, EditFocus, ComCtrls, Buttons, ExtCtrls,
  DB, Menus, AppEvnts, UniClientDataSet, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untTCadPag, untTCadPagRepository, Math, System.IOUtils,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, 
  cxCheckBox, Vcl.DBCtrls, DBMemoFocus,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, System.StrUtils,cxProgressBar,
  untTypesSistema, System.Generics.Collections,untAgrupDuplicatasCtpBusca,
  untFrameCentroCustoEditFocus, Vcl.Forms, untFramePlanoDeContasMaskEdit, untCadPag;

type
  tmpRateio = record
     strCodCta: String;
     strCodEve: String;
     strCodEmp: String;
     fltFatCal: Double;
     fltValor: Double;
  end;

  TfrmAgrupDuplicatasCtp = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label20: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    pnlBotoesBaixa: TPanel;
    Panel1: TPanel;
    pnlAux2: TPanel;
    pnlTotais: TPanel;
    Label14: TLabel;
    edtHistor: TDBMemoFocus;
    btnConfirma: TBitBtnLocked;
    btnSairAgrup: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    btnMarca: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    btnCarrTitulos: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    dbgDuplicatasView: TcxGridDBTableView;
    dbgDuplicatasLevel1: TcxGridLevel;
    dbgDuplicatas: TcxGrid;
    NumDuplicata: TcxGridDBColumn;
    Fornecedor: TcxGridDBColumn;
    CodEmp: TcxGridDBColumn;
    DtaCad: TcxGridDBColumn;
    Vencimento: TcxGridDBColumn;
    Valor: TcxGridDBColumn;
    MARDES: TcxGridDBColumn;
    pnlTotal: TPanel;
    Label21: TLabel;
    Label9: TLabel;
    edtTotalDup: TEditFocus;
    edtTotalSelecionado: TEditFocus;
    btnIniciaBusca: TBitBtnLocked;
    btnLocalizaProx: TBitBtnLocked;
    chkFiltrarFiliais: TCheckBox;
    chkLimFil: TCheckBox;
    rgPeriodo: TRadioGroup;
    btnHistDocumentos: TBitBtnLocked;
    CTA_DESCTA: TcxGridDBColumn;
    CTP_DESEVE: TcxGridDBColumn;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    Label4: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    CTP_NOMPOR: TcxGridDBColumn;
    rdgLiberados: TRadioGroup;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnSairAgrupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtHistorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCarrTitulosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgDuplicatasViewDblClick(Sender: TObject);
    procedure dbgDuplicatasViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIniciaBuscaClick(Sender: TObject);
    procedure btnLocalizaProxClick(Sender: TObject);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure btnHistDocumentosClick(Sender: TObject);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaExit(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure dbgDuplicatasViewColumnSizeChanged(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
  private
    { Private declarations }
    frmAgrupDuplicatasCtpBusca : TfrmAgrupDuplicatasCtpBusca;
    arrDuplicata: TarrDuplicata;
    qryGenPag: TUniQuery;
    qryConEmp: TUniQuery;
    qryConFor: TUniQuery;
    qryConPor: TUniQuery;
    cdsCtaPag: TUniClientDataSet;
    dtsCtaPag: TDataSource;
    strCodVen: String;
    strCodEve: String;

    FCodBco: String;
    FValMor: Double;
    FCodPor: String;
    LHistorico01: String;
    strCNPJ: string;

    strPortador    : String;
    strFornecedorSelecionado: String;

    strValorFiltro : String;
    strCampoFiltro : String;

    strNumAgr: String;
    strEmpDuplic: String;
    stlAutIncDupMar: TStringList;
    strMensagemErro: String;

    arrRateio: array of tmpRateio;
    blnRateio: Boolean;
    intTotalMarcado: integer;

    arrEvento : TConsultasArray;
    arrCentCusto: TConsultasArray;
    arrPortador: TConsultasArray;

    function fMarcouMaisDeUmFonecedor: Boolean;
    procedure pRetornaTotal(strCodFor: String; Var fltTotFor: Double);
    procedure pLimpaDados;
    procedure pSelecionaDuplicata(intRecNo: Integer = 0);
    procedure pMarcaDuplicata(blnMarcar: Boolean; intRecNo: Integer = 0);
    procedure pAgruparDuplicatas;
    procedure GravaLogCtp(strNumeroDup, strParcela: String;
                          intSeqBai: Integer;
                          strCodEmp, strCodFor, strSerie_, strDescricaoLog: String);
    procedure pLiberaDupsMarcadas;

    function fVerificaContas(fltTotalAgr: Double): Boolean;

    procedure pCarrregaDescricaoEvento;
    procedure pCarrregaDescricaoPlanoDeConta;


    {*****************************************}
    {* PROCEDURES ATRIBUIDAS AOS EVENTOS DA  *}
    {* qryTemporaria                         *}
    {**************************************MV*}
    function fAtualizaValoresTemporaria(strCodFor, strValTot, strValDes: String):Boolean;
    function fChamaDesconto(strCodFor, strNomFor: String; fltTotFor: Double):Boolean;
    function fDeletaDuplicatas(arrDupSel: Array Of TDuplicataCtp): Boolean;
    function fGravaAgrupamentos( strCodFor: String; dtaDtaAgp: TDateTime ): Boolean;
    function fGravaDesmembramentos(strNumDup, strParcel, strSerie, strCodEmp, strCodFor, strCodEve: String): Boolean;

    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);

    procedure pConcluiBusca;
    procedure pLocalizaProximaDup;

    procedure pCarregaFornecedor;
    procedure pCarregaEmpresa;
    function fCriaClientCtaPag(strFiltro: String = ''): TUniClientDataSet;
    procedure pAdicionarArray(strCodCta, strCodeve, strCodEmp: String;fltValor, fltTotalAg: Double);
    function  fDesmarcarTodas(pgbStatus: TcxProgressBar): Boolean;
    function  fMarcarTodas(pgbStatus: TcxProgressBar): Boolean;
    procedure pStep(pgbStatus: TcxProgressBar);
    function fDocumentosComPendenciaCancelamento: Boolean;
  protected
    procedure pAtualizaTemporaria;

    procedure pCalculaTotalDuplicatas(edtTotal: TEditFocus; blnFiltrar: Boolean);
    procedure pCalculaTotalSelecionado;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    Function fGetSql: String;
    function fValidaDuplicatasRelacionadasComRomaneio : Boolean;
    {procedure pLog(Msg: String); para monitorias futuras}
  public
    { Public declarations }
  published
    {*****************************************}
    {* PROPRIEDADES QUE SERÃO USADAS PARA A  *}
    {* IMPRESSÃO DO BOLETO                   *}
    {**************************************MV*}
    property strCodBco: String read FCodBco write FCodBco;
    property fltValMor: Double read FValMor write FValMor;
    property strCodPor: String read FCodPor write FCodPor;
    property strHist01: String read LHistorico01 write LHistorico01;
  end;


implementation

uses SysUtils, Variants, Graphics, UniDataSetProvider, untFuncoesSimples,
  untPesqAux, untConsultas, untPai, untDigPortador, untDigCndPagamento, untConstantes,
  untCadConfRelatorios, untDigDesconto, untLogCtp, untDuplicatas, untGravando,
  untAgrupSelFornecedor, untFuncoesConsulta, UntTCadPagRomaneioRepository,
  UntTCadPagRomaneio, untRelCtpLogAcompDuplicNovo, untLogCanAgrupamento,
  untCancelamentoDocResumo, untDtoLogCan;

{$R *.dfm}

function TfrmAgrupDuplicatasCtp.fCriaClientCtaPag(strFiltro: String = ''): TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Self);
  With Result Do
  Begin
    Data := cdsCtaPag.Data;
    If Not fEmptyStr(strFiltro) Then
    Begin
      Filtered := False;
      Filter := strFiltro;
      Filtered := True;
    End;
  End;
End;

procedure TfrmAgrupDuplicatasCtp.pLiberaDupsMarcadas;
begin
  With cdsCtaPag Do
  Begin
    Filtered := False;
    Filter := 'CTP_MARDES = ''M''';
    Filtered := True;

    If Not IsEmpty Then
    Begin
      First;

      While Not Eof Do
      Begin
        fLock_Unlock(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString, False);
        Next;
      End;
    End;
  End;

  stlAutIncDupMar.Clear;
end;

procedure TfrmAgrupDuplicatasCtp.pLimpaDados;
var
  prcScroll: TprcScroll;
begin
  edtTotalDup.Clear;
  edtTotalSelecionado.Clear;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtCodPor.Clear;
  edtNomPor.Clear;
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  fraCentroCusto.edtCodEve.Clear;
  fraCentroCusto.edtDesEve.Clear;
  fraPlanoDeContas.MskCodCta.Clear;
  fraPlanoDeContas.edtDesCta.Clear;

  chkFiltrarFiliais.Checked := False;
  chkFiltrarFiliais.Enabled := False;

  rgPeriodo.ItemIndex := 0;
  rdgLiberados.ItemIndex := 2;

  blnRateio := False;
  SetLength(arrRateio, 0);
  SetLength(arrEvento, 0);
  SetLength(arrCentCusto, 0);

  pDisableControls(cdsCtaPag, prcScroll);
  pLiberaDupsMarcadas;
  cdsCtaPag.Filtered := False;
  cdsCtaPag.Close;
  edtHistor.Clear;
  pEnableControls(cdsCtaPag, prcScroll);
end;

procedure TfrmAgrupDuplicatasCtp.pLocalizaProximaDup;
begin
  If Not cdsCtaPag.FindNext Then
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&O k']);
end;

{procedure TfrmAgrupDuplicatasCtp.pLog(Msg: String);
 var
   txtLog: TextFile;
   LCaminho : String;
begin

  try
    Msg := Msg + '--> ' + FormatDateTime('hh:nn:ss', fTime());
    LCaminho := ExtractFilePath(Application.ExeName) + 'LOG_AGRUPAMENTO_CTP.txt';
    AssignFile(txtLog, LCaminho);

    If FileExists(LCaminho) Then
    Begin
      Reset(txtLog);
    End
    Else
    Begin
      Rewrite(txtLog);
    End;

    Append(txtLog);
    Writeln(txtLog, Msg);
    Flush(txtLog);
    CloseFile(txtLog);

  Except
    On E : Exception  Do
    Begin
       //
    End;
  End;

end;}

procedure TfrmAgrupDuplicatasCtp.pSelecionaDuplicata(intRecNo: Integer = 0);
begin
  If cdsCtaPag.IsEmpty Then
    Exit;

  pMarcaDuplicata(cdsCtaPag.FieldByName('CTP_MARDES').AsString <> 'M', intRecNo);
  pCalculaTotalDuplicatas(edtTotalSelecionado, True);
end;

procedure TfrmAgrupDuplicatasCtp.pStep(pgbStatus: TcxProgressBar);
begin
If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmAgrupDuplicatasCtp.pMarcaDuplicata(blnMarcar: Boolean; intRecNo: Integer = 0);
var
  prcScroll: TprcScroll;
begin
  With cdsCtaPag Do
  Begin
    pDisableControls(cdsCtaPag, prcScroll);

    If intRecNo > 0 Then
      RecNo := intRecNo;

    If blnMarcar Then
    Begin
      If Not fLock_Unlock(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString, True, False) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString), ['&Ok']);
        stlAutIncDupMar.Add(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString);
        pEnableControls(cdsCtaPag, prcScroll);
        Exit;
      End;
    End
    Else
      fLock_Unlock(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString, False);

    Edit;
    FieldByName('CTP_MARDES').AsString := IIF(blnMarcar, 'M', 'D');

    if (FieldByName('CTP_MARDES').AsString = 'D') and (intTotalMarcado > 0) then
    begin
      Dec(intTotalMarcado);
    end
    else
    begin
      Inc(intTotalMarcado);
    end;

    Post;
    pEnableControls(cdsCtaPag, prcScroll);
  End;
end;

procedure TfrmAgrupDuplicatasCtp.pAdicionarArray(strCodCta, strCodeve,
  strCodEmp: String; fltValor, fltTotalAg: Double);
var
  blnEncontrou: Boolean;
  i: Integer;
begin
  blnEncontrou := False;
  if not fEmptyStr(strCodCta) then
  begin
    for i := 0 to  Length(arrRateio)-1 do
    begin
      if ((arrRateio[i].strCodCta  = strCodCta) and
          (arrRateio[i].strCodEmp  = strCodEmp) and
          (arrRateio[i].strCodEve  = strCodeve)) then
      begin
        arrRateio[i].fltValor  := arrRateio[i].fltValor + fltValor;
        arrRateio[i].fltFatCal := arrRateio[i].fltValor/fltTotalAg;
        blnEncontrou := True;
      end;
    end;

    if not blnEncontrou then
    begin
      SetLength(arrRateio, Length(arrRateio)+1);

      arrRateio[Length(arrRateio)-1].strCodEmp := strCodEmp;
      arrRateio[Length(arrRateio)-1].strCodCta := strCodCta;
      arrRateio[Length(arrRateio)-1].strCodEve := strCodeve;
      arrRateio[Length(arrRateio)-1].fltValor  := fltValor;
      arrRateio[Length(arrRateio)-1].fltFatCal := arrRateio[Length(arrRateio)-1].fltValor/fltTotalAg;
    end;
  end;
end;

procedure TfrmAgrupDuplicatasCtp.pAgruparDuplicatas;
  Var
    blnConfirma: Boolean;
    strCndPag  : String;
    fltTotFor  : Double;
    blnDtaVen  : Boolean;
    dtaDtaCad  : TDateTime;
    intDiaVenc : Integer;
    intCont    : Integer;
    cdsGenCtp  : TUniClientDataSet;
    stlCodFor  : TStringList;
    frmDigCndPagamento : TfrmDigCndPagamento;

  {******************************************}
  {* CARREGA UM STRING LIST COM OS CODIGOS  *}
  {* DOS FORNECEDORES SELEC. NAS DUPLICATAS *}
  {***************************************AN*}
  function fCriaListaFornecedores: TStringList;
  var
    cdsGen: TUniClientDataSet;
    strCodFor: String;
  Begin

    If fEmptyStr(strFornecedorSelecionado) Then
    Begin
      cdsGen := fCriaClientCtaPag('CTP_MARDES = ' + QuotedStr('M'));
      With cdsGen Do
      Begin
        IndexFieldNames := 'CTP_CODFOR';
        Result := TStringList.Create;
        strCodFor := '';
        First;

        While Not Eof Do
        Begin
          If Not SameText(strCodFor, FieldByName('CTP_CODFOR').AsString) Then
          Begin
            strCodFor := FieldByName('CTP_CODFOR').AsString;
            Result.Add(strCodFor);
          End;

          Next;
        End;
      End;
      FreeAndNil(cdsGen);
    End
    Else
    Begin
      Result := TStringList.Create;
      Result.Add(strFornecedorSelecionado);
    End;
  End;

  procedure pCarregaInfDuplicatas(strCodFor: String);
  var
    cdsGen: TUniClientDataSet;
    fld1, fld2: TAggregateField;
    strFiltro: String;
  Begin
    strFiltro := 'CTP_MARDES = ''M'' ';

    cdsGen := TUniClientDataSet.Create(Self);
    fld1 := TAggregateField.Create(Self);
    fld2 := TAggregateField.Create(Self);

    With fld1 Do
    Begin
      {***************************************}
      {* CARREGANDO A MENOR DATA DE CADASTRO *}
      {************************************AN*}
      FieldName := 'CTP_GEN1';
      DataSet := cdsGen;
      Expression := 'MIN(CTP_DTACAD)';
      Active := True;
    End;

    With fld2 Do
    Begin
      {*****************************************}
      {* CARREGANDO A MAIOR DATA DE VENCIMENTO *}
      {**************************************AN*}
      FieldName := 'CTP_GEN2';
      DataSet := cdsGen;
      Expression := 'MAX(CTP_DTAVEN)';
      Active := True;
    End;

    With cdsGen Do
    Begin
      Data := cdsCtaPag.Data;
      Filtered := False;
      Filter := strFiltro;
      Filtered := True;
      AggregatesActive := True;
    End;

    dtaDtaCad  := fld1.Value;
    intDiaVenc := fFloatToInt(fld2.Value - VS_Date);

    FreeAndNil(fld1);
    FreeAndNil(fld2);
    FreeAndNil(cdsGen);
  End;

begin
  blnConfirma := False;

  {*********************************************************************}
  {* CRIANDO UMA LISTA COM OS FORNECEDORES DAS DUPLICATAS SELECIONADAS *}
  {* PARA QUE A LISTA SEJA PROCESSADA EM UM LOOP E SEJA FEITO O AGRUPA *}
  {* MENTO POR FORNECEDOR                                              *}
  {******************************************************************AN*}
  stlCodFor := fCriaListaFornecedores;

  For intCont := 0 To stlCodFor.Count-1 Do
  Begin
    {*******************************************}
    {* SOMA DOS DOCUMENTOS MARCADOS            *}
    {****************************************AC*}
    pRetornaTotal(stlCodFor[intCont], fltTotFor);

    {*******************************************************************************}
    {* CHAMA A TELA DE DESCONTO ESPECIAL.SE HOUVER DESCONTO ATUALIZA O VALOR TOTAL *}
    {****************************************************************************AC*}
    If fCfgSis('DESAGP', varBoolean) And (fltTotFor > 0) Then
    Begin
      If fChamaDesconto(stlCodFor[intCont], fRetNomFornecedor(stlCodFor[intCont]), fltTotFor) Then
      Begin
        pCalculaTotalDuplicatas(edtTotalSelecionado, True);
        pRetornaTotal(stlCodFor[intCont], fltTotFor);
      End
      Else
      Begin
        FreeAndNil(stlCodFor);
        Exit;
      End;
    End;

    if not fVerificaContas(fltTotFor) then
    begin
      FreeAndNil(stlCodFor);
      Exit;
    end;

    blnDtaVen := True;

    pCarregaInfDuplicatas(stlCodFor[intCont]);

    If (intDiaVenc <= 0) Then
      blnDtaVen := True;

    {*****************************************}
    {* PROCESSA DUPLICATAS                   *}
    {**************************************MV*}
    strNumAgr := '';
    strCodBco := '';
    fltValMor := 0.0;

    {********************************************************}
    {* SE A DATA DE VENCIMENTO DAS DUPLICATAS DO FORNECEDOR *}
    {* FOR DIFERENTE CHAMA A TELA CONDIÇÃO DE PAGAMENTO     *}
    {*****************************************************LB*}
    If blnDtaVen Then
    Begin
      {*****************************************}
      {* CHAMA A TELA DE CONDIÇÃO DE PAGAMENTO *}
      {**************************************MA*}
      Try
        pCriarFormularios(TfrmDigCndPagamento, frmDigCndPagamento);
        frmDigCndPagamento.Caption := 'Condição Pagto (Fornecedor: ' + fRetNomFornecedor(stlCodFor[intCont]) + ')';

        If (fCfgSis('USAFPG', varBoolean)) Then
        Begin
          frmDigCndPagamento.fraDigCndPagamento.pnlForPag.Visible := False;
          frmDigCndPagamento.Height := frmDigCndPagamento.Height - frmDigCndPagamento.fraDigCndPagamento.pnlForPag.Height;
        End;

        frmDigCndPagamento.fraDigCndPagamento.blnTamForm := True;
        frmDigCndPagamento.fraDigCndPagamento.edtTotDup.Text := FloatToStrF(fltTotFor,ffFixed,12,2);

        frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.Columns[0].Title.Caption := 'Duplicata';
        frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.Columns[0].FieldName     := 'CTP_NUMDUP';

        frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.Columns[1].Title.Caption := 'Empresa';
        frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.Columns[1].FieldName     := 'CTP_CODEMP';

        frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.Columns[2].Title.Caption := 'Emissão';
        frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.Columns[2].FieldName     := 'CTP_DTACAD';

        frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.Columns[3].Title.Caption := 'Vencimento';
        frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.Columns[3].FieldName     := 'CTP_DTAVEN';

        frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.Columns[4].Title.Caption   := 'Valor';
        frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.Columns[4].Title.Alignment := taRightJustify;
        frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.Columns[4].FieldName       := 'CTP_VALDUP';

        {**************************************************************}
        {* CARREGANDO UM CDS TEMPORARIO PARA EXIBIR OS ITENS MARCADOS *}
        {* PARA EXIBI-LOS NO TELA DE CONDICAO DE PAGAMENTO            *}
        {***********************************************************AN*}
        cdsGenCtp := fCriaClientCtaPag('CTP_MARDES = ''M'' ');
        TFloatField(cdsGenCtp.FieldByName('CTP_VALDUP')).DisplayFormat := '#,##0.00';

        frmDigCndPagamento.fraDigCndPagamento.dbgDupAgru.DataSource := fCriaDataSource(cdsGenCtp);
        frmDigCndPagamento.showModal;

        FreeAndNil(cdsGenCtp);

        strCndPag   := frmDigCndPagamento.fraDigCndPagamento.strCndPag;
        blnConfirma := frmDigCndPagamento.fraDigCndPagamento.blnConfirma;

      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pMensagensErro(E.Message, '[frmAgrupDuplicatasCtp.pAgruparDuplicatas]');
        End;
      End;
      pFreeAndNil(frmDigCndPagamento);

      If Not blnConfirma Then
      Begin
        FreeAndNil(stlCodFor);
        Exit;
      End;
    End
    Else
    Begin
      strCndPag   := '01'+ fPadL(IntToStr(intDiaVenc),3,'0');
      blnConfirma := True;
    End;

    {*****************************************}
    {* PEDE VALORES DAS PARCELAS             *}
    {**************************************MA*}
    If blnConfirma Then
    Begin
      fDigDuplic(arrDuplicata, strCndPag, 0, fltTotFor, blnDtaVen, True, False, VS_Date, True);

      blnConfirma := (arrDuplicata[0].strSequen <> '');
    End;

    {***********************************}
    {* GRAVA AGRUPAMENTO               *}
    {********************************LB*}
    If (blnConfirma) Then
    Begin
      blnConfirma := fGravaAgrupamentos(stlCodFor[intCont], dtaDtaCad);
    End;

    If Not blnConfirma Then
    Begin
      Screen.Cursor := crDefault;
      FreeAndNil(stlCodFor);
      Exit;
    End;

    Application.ProcessMessages;
  End;

  If (blnConfirma) And (Not fEmptyStr(strNumAgr)) Then
  Begin
    cdsCtaPag.Close;
    fMensagem('','Agrupamento n° ' + strNumAgr + ' gerado com sucesso!', ['&O k']);
  End;

  if chkLimFil.Checked then
     pLimpaDados;

  FreeAndNil(stlCodFor);
  pSetFocus(edtCodEmp);
end;

function TfrmAgrupDuplicatasCtp.fDeletaDuplicatas(arrDupSel: Array Of TDuplicataCtp): Boolean;
  Var
    intContador: Integer;
    strSQL     : String;
    qryGenCtp  : TUniQuery;
    blnTemDup  : Boolean;
begin
  Try
    blnTemDup  := False;

    qryGenCtp := fCriaQuery(Self);

    Try
      strSQL := '';
      strSQL := strSQL + ' DELETE FROM ';
      strSQL := strSQL + ' CADPAG ';
      strSQL := strSQL + ' WHERE ';

      For intContador := 0 To Length(arrDupSel) -1 Do
      Begin
        blnTemDup := True;
        strSQL := strSQL + '( CTP_NUMDUP = ' + QuotedStr(arrDupSel[intContador].strNumDup);
        strSQL := strSQL + ' AND CTP_PARCEL = ' + QuotedStr(arrDupSel[intContador].strParcel);
        strSQL := strSQL + ' AND CTP_SEQBAI = 0 ';
        strSQL := strSQL + ' AND CTP_CODEMP = ' + QuotedStr(arrDupSel[intContador].strCodEmp);
        strSQL := strSQL + ' AND CTP_SERIE_ = ' + QuotedStr(arrDupSel[intContador].strSerie_);
        strSQL := strSQL + ' AND CTP_CODFOR = ' + QuotedStr(arrDupSel[intContador].strCodFor) + ')';

        strSQL := strSQL + ' OR ';

        GravaLogCtp(arrDupSel[intContador].strNumDup,
                    arrDupSel[intContador].strParcel,
                    0,
                    arrDupSel[intContador].strCodEmp,
                    arrDupSel[intContador].strCodFor,
                    arrDupSel[intContador].strSerie_,
                    'EXCLUSAO DE DUPLICATA - AGRUPAMENTO');
      End;

      With qryGenCtp Do
      Begin
        If blnTemDup Then
        Begin
          system.Delete(strSQL,Length(strSQL)-3,4);
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ExecSQL;
          Close;
        End;
        
        Result := True;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fDeletaDuplicatas]');
      End;

    End;

  Finally
    FreeAndNil(qryGenCtp);
  End;

end;

function TfrmAgrupDuplicatasCtp.fDesmarcarTodas(
  pgbStatus: TcxProgressBar): Boolean;
Var
  prcScroll: TprcScroll;
begin
  Result := True;
  if (intTotalMarcado <= 0) then
    begin
      fMensagem('','É necessário selecionar ao menos uma duplicata para desmarcar!',['&O K']);
      Exit;
    end;
     If Not cdsCtaPag.IsEmpty Then
    Begin
      pgbStatus.Properties.Max := cdsCtaPag.RecordCount;
      With cdsCtaPag Do
      Begin
        pDisableControls(cdsCtaPag, prcScroll);
        //AggregatesActive := False;
        First;
        While Not Eof Do
        Begin
          If ((FieldByName('CTP_MARDES').AsString <> 'M') And (False)) Or
             ((FieldByName('CTP_MARDES').AsString = 'M') And (Not False)) Then
            pMarcaDuplicata(False);
          pStep(pgbStatus);
          Next;
        End;
        pEnableControls(cdsCtaPag, prcScroll);
        //AggregatesActive := True;
        pCalculaTotalDuplicatas(edtTotalSelecionado, True);
      End;
    End;
end;

function TfrmAgrupDuplicatasCtp.fGravaAgrupamentos( strCodFor: String; dtaDtaAgp: TDateTime ): Boolean;
  Var
    intContador : Integer;
    intTamAnt   : Integer;
    blnConfirma : Boolean;
    dagAgrup    : TDadosAgrup;
    arrDupSel   : Array Of TDuplicataCtp;
    strHistor   : String;
    cdsGenCtp   : TUniClientDataSet;
    arrAutInc   : Array of String;
    strVeioNF   : String;
    LVlrCtp     : Double; // Valor total dos contas a pagar participantes do agrupamento
    LVlrAgp     : Double; // Valor total dos agrupamentos que vão ser criados

  function fTemEmpresaDiferente: Boolean;
  var
    cdsGen: TUniClientDataSet;
    strFiltro: String;
    strCodEmp: String;
  Begin
    strFiltro := 'CTP_MARDES = ''M'' ';
    cdsGen := fCriaClientCtaPag(strFiltro);

    With cdsGen Do
    Begin
      strCodEmp := FieldByName('CTP_CODEMP').AsString;

      strFiltro := strFiltro + ' AND CTP_CODEMP <> ' + QuotedStr(strCodEmp);
      Filtered := False;
      Filter := strFiltro;
      Filtered := True;

      Result := Not IsEmpty;
    End;
    FreeAndNil(cdsGen);
  End;

  procedure pCopiaAnexos(strCodFor, strCodEmp, strAutInc, strAutAgp, ACodEmpAgrupamento: String);
    var
      strCaminhoPastaAntiga: String;
      strCaminhoNovaPasta: String;
  begin
    //Primeiro faço a correção de diretórios assim como a rotina do botão "Arquivos Anexos" do contas a pagar.
    strCaminhoPastaAntiga := ExtractFilePath(Application.ExeName)+ 'ANEXOS_CTP\' + strAutInc ;
    strCaminhoNovaPasta   := ExtractFilePath(Application.ExeName)+ 'ANEXOS_CTP\' +
                             fStrZero( strCodFor, 8  ) + '-' +
                             fStrZero( strCodEmp, 3  ) + '-' +
                             fStrZero( strAutInc, 20 ) ;

    if DirectoryExists( strCaminhoPastaAntiga ) then
    begin
       TDirectory.Move( strCaminhoPastaAntiga, strCaminhoNovaPasta );
       Sleep(500);
    end;

    //Depois copio os arquivos para a pasta do agrupamento.
    strCaminhoPastaAntiga := strCaminhoNovaPasta;
    strCaminhoNovaPasta   := ExtractFilePath(Application.ExeName)+ 'ANEXOS_CTP\' +
                             fStrZero( strCodFor, 8  ) + '-' +
                             fStrZero( ACodEmpAgrupamento, 3  ) + '-' +
                             fStrZero( strAutAgp, 20 ) ;

    if DirectoryExists( strCaminhoPastaAntiga ) then
    begin
       TDirectory.Copy( strCaminhoPastaAntiga, strCaminhoNovaPasta );
       Sleep(500);
    end;
  End;

begin
  LVlrCtp := 0;
  LVlrAgp := 0;

  Screen.Cursor := crHourGlass;

  If (fCfgSis('DTAAGP') = '2') Then
    dtaDtaAgp := VS_Date;

  strNumAgr   := 'AG' + fSeqAgrupamentoCtp;
  blnConfirma := False;

  {***************************************************}
  {* CRIANDO UM CLIENTDATASET COM OS DADOS DO PADRAO *}
  {* DO FORM PARA CONCLUIR O AGRUPAMENTO DE DUPLIC   *}
  {************************************************AN*}
  cdsGenCtp := fCriaClientCtaPag('CTP_MARDES = ' + QuotedStr('M'));

  If fCfgSis('AGRTPP', varInteger) = 1 Then
     strEmpDuplic := VS_strCodEmp
  Else
  Begin
    If fTemEmpresaDiferente Then
      strEmpDuplic := VS_strCodEmp
    Else
      strEmpDuplic := cdsGenCtp.FieldByName('CTP_CODEMP').AsString;
  End;

  //Pego os autoincrem's das duplicatas que vão ser geradas, pra poder efetuar a cópia dos anexos
  For intContador := 0 To Length(arrDuplicata) -1 Do
  Begin
    If fEmptyStr(arrDuplicata[intContador].strSequen) Then
      Break;

    intTamAnt := Length(arrAutInc);
    SetLength(arrAutInc, intTamAnt+1);

    arrAutInc[intTamAnt] := fRetAutoIncrem('CADPAG', strEmpDuplic);
    LVlrAgp := fFormataFloat(LVlrAgp + arrDuplicata[intContador].curValor,2);
  End;

  With cdsGenCtp Do
  Begin

    strVeioNF := FieldByName('CTP_VEIONF').AsString;
    First;
    While Not Eof Do
    Begin
      If FieldByName('CTP_VEIONF').AsString <> strVeioNF Then
      Begin
        strVeioNF := '';
        Break;
      End;
      Next;
    End;

    First;
    {*****************************************}
    {* INICIA A TRANSAÇÃO                    *}
    {**************************************MV*}
    fStartTransaction;

    strMensagemErro := '';

    strHistor := '';

    While Not Eof Do
    Begin

      {*****************************************}
      {* FORMATA AS OBSERVAÇÕES                *}
      {**************************************MV*}
      If fEmptyStr(dagAgrup.strObsAg1) Then
      Begin
        dagAgrup.strObsAg1 := 'REF. DOC. ' + FieldByName('CTP_NUMDUP').AsString;
      End
      Else If Length(dagAgrup.strObsAg1) < 72 Then
      Begin
        dagAgrup.strObsAg1 := dagAgrup.strObsAg1 + '/' + FieldByName('CTP_NUMDUP').AsString;
      End
      Else If Length(dagAgrup.strObsAg2) < 72 Then
      Begin
        dagAgrup.strObsAg2 := dagAgrup.strObsAg2 + '/' + FieldByName('CTP_NUMDUP').AsString;
      End
      Else If Length(dagAgrup.strObsAg3) < 72 Then
      Begin
        dagAgrup.strObsAg3 := dagAgrup.strObsAg3 + '/' + FieldByName('CTP_NUMDUP').AsString;
      End;

      {*****************************************}
      {* SALVA AS DUPLICATAS QUE SERÃO ATUALI- *}
      {* ZADAS                                 *}
      {**************************************MV*}
      intTamAnt := Length(arrDupSel);
      SetLength(arrDupSel, intTamAnt+1);

      arrDupSel[intTamAnt].strNumDup := FieldByName('NRODUP').AsString;
      arrDupSel[intTamAnt].strParcel := FieldByName('PARDUP').AsString;
      arrDupSel[intTamAnt].strCodEmp := FieldByName('CTP_CODEMP').AsString;
      arrDupSel[intTamAnt].strCodFor := FieldByName('CTP_CODFOR').AsString;
      arrDupSel[intTamAnt].strUsoCon := FieldByName('CTP_USOCON').AsString;
      arrDupSel[intTamAnt].strSerie_ := FieldByName('CTP_SERIE_').AsString;

      strHistor := strHistor + FieldByName('NRODUP').AsString + '/' +
                               FieldbyName('PARDUP').AsString + '/' +
                               FieldbyName('CTP_CODEMP').AsString + '-';

      LVlrCtp := fFormataFloat(LVlrCtp + FieldByName('CTP_VALDUP').AsFloat,2);

      If fEmptyStr(FieldByName('CTP_CODVEN').AsString) Then
        strCodVen := strLoginUsuarioLogado
      else
        strCodVen := FieldByName('CTP_CODVEN').AsString;

      {*************************}
      {* GRAVA A TABELA DUPAGP *}
      {**********************LU*}
      blnConfirma := fGravaDupAgp(strNumAgr,
                                  FieldByName('NRODUP').AsString,
                                  FieldbyName('PARDUP').AsString,
                                  FieldByName('CTP_SERIE_').AsString,
                                  FieldByName('CTP_PREVIS').AsString,
                                  FieldByName('CTP_SEQBAI').AsInteger,
                                  FieldByName('CTP_CODFOR').AsString,
                                  FieldByName('CTP_CODEMP').AsString,
                                  FieldByName('CTP_DTACAD').AsDateTime,
                                  FieldByName('CTP_DTAVEN').AsDateTime,
                                  FieldByName('CTP_VALORI').AsFloat,
                                  FieldByName('CTP_VALORI').AsFloat,
                                  FieldByName('CTP_HIST01').AsString,
                                  FieldByName('CTP_HIST02').AsString,
                                  strCodVen,
                                  FieldByName('CTP_CODVEL').AsString,
                                  FieldByName('CTP_CODCTA').AsString,
                                  strEmpDuplic,
                                  FieldByName('CTP_JURSUJ').AsFloat,
                                  FieldByName('CTP_DESSUJ').AsFloat,
                                  1,
                                  FieldByName('CTP_VENDOR').AsFloat,
                                  FieldByName('CTP_TIPDOC').AsInteger,
                                  FieldByName('CTP_Q_GUIA').AsString,
                                  FieldByName('CTP_CODREC').AsString,
                                  FieldByName('CTP_CODEVE').AsString,
                                  FieldByName('CTP_USACHQ').AsString = 'S',
                                  FieldByName('CTP_USOCON').AsString,
                                  FieldByName('CTP_NUMDDA').AsString,
                                  FieldByName('AUTOINCREM').AsString,
                                  FieldByName('CTP_DEPOSI').AsString,
                                  FieldByName('CTP_CODPOR').AsString,
                                  FieldByName('CTP_BCOFOR').AsString,
                                  FieldByName('CTP_VEIONF').AsString,
                                  FieldByName('CTP_MULSUJ').AsFloat,
                                  FieldByName('CTP_USAMCA').AsString = 'S');

      If Not blnConfirma Then
        Break;

      For intContador := 0 To Length(arrAutInc) -1 Do
      Begin
        pCopiaAnexos(FieldByName('CTP_CODFOR').AsString,
                     FieldByName('CTP_CODEMP').AsString,
                     FieldByName('AUTOINCREM').AsString,
                     arrAutInc[intContador],
                     strEmpDuplic);
      End;

      Next;
      Application.ProcessMessages;
    End;

    System.Delete(strHistor, Length(strHistor), 1);

    If blnConfirma And (fFormataFloat(LVlrCtp,2) <> fFormataFloat(LVlrAgp,2)) Then
    Begin
      fMensagem('ATENÇÃO', 'Há divergência entre o valor total das duplicatas a serem agrupadas com o agrupamento a ser criado, '+
                           'Recarregue os títulos. Operação cancelada.', ['&OK']);
      blnConfirma := False;
    End;

    If blnConfirma Then
    Begin
      {*****************************************}
      {* GRAVA AS DUPLICATAS AGRUPADAS         *}
      {**************************************MV*}
      For intContador := 0 To Length(arrDuplicata) -1 Do
      Begin

        {*****************************************}
        {* CHEGOU AO FIM DA MATRIZ.              *}
        {**************************************MV*}
        If fEmptyStr(arrDuplicata[intContador].strSequen) Then
          Break;

        With cdsGenCtp Do
        Begin

          blnConfirma := fGravaCadPag('frmAgrupDuplicatasCtp',                  // Nome Form LOGCTP
                                      'INCLUSAO DE DUPLICATA - AGRUPAMENTO',    // Descrição LOGCTP
                                      IIF(fEmptyStr(strFornecedorSelecionado),FieldByName('CTP_CODFOR').AsString,strFornecedorSelecionado),
                                      strNumAgr,
                                      arrDuplicata[intContador].strSequen,
                                      strEmpDuplic,
                                      IIF(blnRateio, fCfgSis('CTAPRI'), FieldByName('CTP_CODCTA').AsString), //Adicionado a conta de rateio, caso exista mais de uma conta para as duplicatas agrupadas e o usuário confirme o desmembramento
                                      'AG',
                                      0,
                                      dtaDtaAgp,
                                      StrToDate(arrDuplicata[intContador].dtaDtaVen),
                                      arrDuplicata[intContador].curValor,
                                      arrDuplicata[intContador].curValor,
                                      'N',
                                      'S',
                                      'N',                                            // Deposito
                                      Concat(strHistor,#13#10,strHist01),
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      0,
                                      0,
                                      0,
                                      0,
                                      VS_strCodEmp,
                                      IIF(blnRateio, fCfgSis('EVEPRI'), strCodEve), //Adicionado o evento de rateio, caso exista mais de uma conta para as duplicatas agrupadas e o usuário confirme o desmembramento
                                      '',
                                      strCodPor,
                                      '',
                                      0.0,
                                      0.0,
                                      0,
                                      False,
                                      0,
                                      '',
                                      0,
                                      strVeioNF,
                                      '',
                                      '',
                                      '',
                                      arrAutInc[intContador],
                                      '','','','', FieldByName('CTP_USOCON').AsString);

          {*******************************}
          {* Adicionada verificação do   *}
          {* blnConfirma, pois pode      *}
          {* ocorrer erro na instrução   *}
          {* acima.                      *}
          {****************************FS*}
          if blnRateio And blnConfirma then
          begin
            blnConfirma :=  fGravaDesmembramentos(strNumAgr,
                                                  arrDuplicata[intContador].strSequen,
                                                  'AG',
                                                  VS_strCodEmp,
                                                  FieldByName('CTP_CODFOR').AsString,
                                                  fCfgSis('EVEPRI'));
          end;

          If Not blnConfirma Then
            Break;

        End;
      End;

    End;

    If blnConfirma Then
    Begin
      {*****************************************}
      {* DELETA AS DUPLICATAS ORIGINAIS        *}
      {**************************************MV*}
      blnConfirma := fDeletaDuplicatas(arrDupSel);
    End;

  End;

  If blnConfirma Then
    fCommit
  else
    fRollBack;

  if strMensagemErro <> '' then
     fMensagem('ATENÇÃO!', 'Ocorreu um erro ao gerar o detalhamento do agrupamento[CTPDET]: ' + #13 + strMensagemErro, ['&Ok']);

  Result := blnConfirma;
  Screen.Cursor := crDefault;

  If Not Result Then
    strNumAgr := '';

  FreeAndNil(cdsGenCtp);
end;

function TfrmAgrupDuplicatasCtp.fGravaDesmembramentos(strNumDup, strParcel,
  strSerie, strCodEmp, strCodFor, strCodEve: String): Boolean;
var
  i: Integer;
  qryExec: TUniQuery;
  strSQL : String;
begin
  Result := False;
  Try
    for i := 0 to  Length(arrRateio)-1 do
    begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO CTPDET ( ';
      strSQL := strSQL + '  CTP_NUMDUP, ';
      strSQL := strSQL + '  CTP_PARCEL, ';
      strSQL := strSQL + '  CTP_SERIE_, ';
      strSQL := strSQL + '  CTP_CODEMP, ';
      strSQL := strSQL + '  CTP_CODFOR, ';
      strSQL := strSQL + '  CTP_CODCTA, ';
      strSQL := strSQL + '  CTP_EMPORI, ';
      strSQL := strSQL + '  CTP_FATCAL, ';
      strSQL := strSQL + '  CTP_CODEVE, ';
      strSQL := strSQL + '  AUTOINCREM ';
      strSQL := strSQL + ') VALUES ( ';
      strSQL := strSQL + '  :NUMDUP, ';
      strSQL := strSQL + '  :PARCEL, ';
      strSQL := strSQL + '  :SERIE_, ';
      strSQL := strSQL + '  :CODEMP, ';
      strSQL := strSQL + '  :CODFOR, ';
      strSQL := strSQL + '  :CODCTA, ';
      strSQL := strSQL + '  :EMPORI, ';
      strSQL := strSQL + '  :FATCAL, ';
      strSQL := strSQL + '  :CODEVE, ';
      strSQL := strSQL + '  :AUTINC) ';

      qryExec := fCriaQuery();
      qryExec.Close;
      qryExec.SQL.Clear;
      qryExec.SQL.Add(strSQL);

      with qryExec do
      begin
        ParamByName('NUMDUP').AsString  := strNumDup;
        ParamByName('PARCEL').AsString  := strParcel;

        If (fEmptyStr(strSerie)) Then
          ParamByName('SERIE_').AsString := ''
        Else
          ParamByName('SERIE_').AsString  := strSerie;

        ParamByName('CODEMP').AsString  := arrRateio[i].strCodEmp;
        ParamByName('CODFOR').AsString  := strCodFor;
        ParamByName('CODCTA').AsString  := arrRateio[i].strCodCta;
        ParamByName('EMPORI').AsString  := strCodEmp;
        ParamByName('FATCAL').AsFloat   := arrRateio[i].fltFatCal;

        If fEmptyStr(arrRateio[i].strCodEve) Then
          ParamByName('CODEVE').Value    := Null
        Else
          ParamByName('CODEVE').AsString := arrRateio[i].strCodEve;

        ParamByName('AUTINC').AsString  := fRetAutoIncrem('CTPDET', strCodEmp);
        ExecSQL;
      end;

      FreeAndNil(qryExec);
    end;
  except
    on e: Exception do
    begin
      strMensagemErro := e.Message;
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmAgrupDuplicatasCtp.pCarregaFornecedor;
begin
  strCNPJ := '';
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;

    If FieldByName('FOR_CGCCPF').AsString = '1' Then
      strCNPJ := FieldByName('FOR_C_G_C_').AsString;
  End;
end;

procedure TfrmAgrupDuplicatasCtp.pCarrregaDescricaoEvento;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEventoExiFat(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmAgrupDuplicatasCtp.pCarrregaDescricaoPlanoDeConta;
var SQuery : TUniQuery;
begin
  SQuery := fCriaQuery(self);
  try
    pPesquisaCadCta(SQuery, SQuery, fraPlanoDeContas.MskCodCta.Text);
    fraPlanoDeContas.edtDesCta.Text := SQuery.FieldByName('CTA_DESCTA').AsString;
  finally
    FreeAndNil(SQuery);
  end;
end;

procedure TfrmAgrupDuplicatasCtp.pConcluiBusca;
begin
  If (Not fEmptyStr(frmAgrupDuplicatasCtpBusca.strValorFiltro)) Then
  Begin
    cdsCtaPag.Filter := '';
    strValorFiltro := frmAgrupDuplicatasCtpBusca.strValorFiltro;
    strCampoFiltro := frmAgrupDuplicatasCtpBusca.strCampoFiltro;

    If Not cdsCtaPag.FindFirst Then
      fMensagem('ATENÇÃO!', 'Não há duplicatas para serem agrupadas!', ['&O k']);
  End;

end;

procedure TfrmAgrupDuplicatasCtp.pFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  If Not fEmptyStr(strCampoFiltro) Then
  Begin
    If Pos('_VALDUP', strCampoFiltro) > 0 Then
         Accept := FloatToStrF(fStrToFloat(strValorFiltro),ffFixed,15,2) = FloatToStrF(DataSet.FieldByName(strCampoFiltro).AsFloat,ffFixed,15,2)
    Else
      Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
  End;

end;

procedure TfrmAgrupDuplicatasCtp.GravaLogCtp(strNumeroDup, strParcela: String;
                                             intSeqBai: Integer;
                                             strCodEmp, strCodFor, strSerie_, strDescricaoLog: String);
  Var
    LAutoIncrem: String;
begin
  Try
    LAutoIncrem := fCampoTabela('AUTOINCREM',
                                'CADPAG',
                                ['CTP_NUMDUP', 'CTP_PARCEL', 'CTP_CODEMP', 'CTP_CODFOR', 'CTP_SERIE_', 'CTP_SEQBAI'],
                                [strNumeroDup, strParcela, strCodEmp, strCodFor, strSerie_, intSeqBai],
                                True);

    untLogCtp.GravaLogCtp(LAutoIncrem, strDescricaoLog, Self.Name);
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[frmAgrupDuplicatasCtp.GravaLogCtp]');
  End;
end;

procedure TfrmAgrupDuplicatasCtp.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

Function TfrmAgrupDuplicatasCtp.fGetSql: String;
  Var
    strSQL: String;
Begin
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CTP_NUMDUP AS NRODUP, ';
  strSQL := strSQL + '  CTP_PARCEL AS PARDUP, ';
  strSQL := strSQL + '  CONCAT(R.CTP_NUMDUP, R.CTP_PARCEL) AS CTP_NUMDUP, ';
  strSQL := strSQL + '  R.CTP_SEQBAI AS CTP_SEQBAI, ';
  strSQL := strSQL + '  R.CTP_CODFOR AS CTP_CODFOR, ';
  strSQL := strSQL + '  F.FOR_NOMFOR AS FOR_NOMFOR, ';
  strSQL := strSQL + '  CONCAT(R.CTP_CODFOR, "-", F.FOR_NOMFOR) AS CTP_NOMFOR, ';
  strSQL := strSQL + '  R.CTP_CODEMP AS CTP_CODEMP, ';
  strSQL := strSQL + '  R.CTP_DTACAD AS CTP_DTACAD, ';
  strSQL := strSQL + '  R.CTP_DTAVEN AS CTP_DTAVEN, ';
  strSQL := strSQL + '  R.CTP_VALDUP + IFNULL(CTP_JURSUJ, 0) +  IFNULL(CTP_MULSUJ, 0)  + IFNULL(CTP_VENDOR, 0) - IFNULL(CTP_DESSUJ, 0) AS CTP_VALDUP, ';
  strSQL := strSQL + '  R.CTP_VALORI AS CTP_VALORI, ';
  strSQL := strSQL + '  R.CTP_HIST01 AS CTP_HIST01, ';
  strSQL := strSQL + '  R.CTP_HIST02 AS CTP_HIST02, ';
  strSQL := strSQL + '  R.CTP_CODVEN AS CTP_CODVEN, ';
  strSQL := strSQL + '  R.CTP_CODVEL AS CTP_CODVEL, ';
  strSQL := strSQL + '  R.CTP_CODCTA AS CTP_CODCTA, ';
  strSQL := strSQL + '  R.CTP_SERIE_ AS CTP_SERIE_, ';
  strSQL := strSQL + '  R.CTP_JURSUJ AS CTP_JURSUJ, ';
  strSQL := strSQL + '  R.CTP_MULSUJ AS CTP_MULSUJ, ';
  strSQL := strSQL + '  R.CTP_VENDOR AS CTP_VENDOR, ';
  strSQL := strSQL + '  R.CTP_DESSUJ AS CTP_DESSUJ, ';
  strSQL := strSQL + '  R.CTP_PREVIS AS CTP_PREVIS, ';
  strSQL := strSQL + '  R.CTP_USOCON AS CTP_USOCON, ';
  strSQL := strSQL + '  R.CTP_CODPOR AS CTP_CODPOR, ';
  strSQL := strSQL + '  CTP_NUMDDA AS CTP_NUMDDA, ';
  strSQL := strSQL + '  0.00 AS CTP_VALDES, ';
  strSQL := strSQL + '  R.AUTOINCREM, ';
  strSQL := strSQL + '  F.FOR_CGCCPF, ';
  strSQL := strSQL + '  LEFT(F.FOR_C_G_C_, 8) AS CNPJ, ';
  strSQL := strSQL + '  "CADPAG" AS TABELA, ';
  strSQL := strSQL + '  "D" AS CTP_MARDES, ';
  strSQL := strSQL + '  R.CTP_CODEVE AS CTP_CODEVE, ';
  strSQL := strSQL + '  R.CTP_DEPOSI AS CTP_DEPOSI, ';
  strSQL := strSQL + '  R.CTP_BCOFOR AS CTP_BCOFOR, ';
  strSQL := strSQL + '  R.CTP_TIPDOC, ';
  strSQL := strSQL + '  R.CTP_Q_GUIA, ';
  strSQL := strSQL + '  R.CTP_CODREC, ';
  strSQL := strSQL + '  R.CTP_USACHQ, ';
  strSQL := strSQL + '  R.CTP_USAMCA, ';
  strSQL := strSQL + '  R.CTP_VEIONF, ';
  strSQL := strSQL + '  CONCAT(R.CTP_CODPOR, "-", P.POR_NOMPOR) AS CTP_NOMPOR, ';
  strSQL := strSQL + '  IF(C.CTA_CODCTA IS NULL,"",CONCAT(C.CTA_CODCTA, "-", C.CTA_DESCTA)) CTA_DESCTA, ';
  strSQL := strSQL + '  IF(E.EVE_CODEVE IS NULL,"",CONCAT(E.EVE_CODEVE, "-", E.EVE_DESEVE)) CTP_DESEVE  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFOR F, ';
  strSQL := strSQL + '  CADPAG R ';
  strSQL := strSQL + '  LEFT JOIN CADCTA C ON C.CTA_CODCTA = R.CTP_CODCTA ';
  strSQL := strSQL + '  LEFT JOIN CADEVE E ON E.EVE_CODEVE = R.CTP_CODEVE ';
  strSQL := strSQL + '  LEFT JOIN CADPOR P ON P.POR_CODPOR = R.CTP_CODPOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  R.CTP_CODFOR = F.FOR_CODFOR AND ';
  strSQL := strSQL + '  R.CTP_DTAPAG IS NULL AND ';
  strSQL := strSQL + '  R.CTP_DTACAD IS NOT NULL AND ';
  strSQL := strSQL + '  LEFT(R.CTP_NUMDUP,2) <> "AG" AND ';
  strSQL := strSQL + '  R.CTP_SEQBAI = 0 ';

  If (Not fEmptyStr(edtCodEmp.Text)) Then
  Begin
    strSQL := strSQL + '  AND R.CTP_CODEMP = :CODEMP ';
  End;

  If Not fEmptyStr(edtCodFor.Text) Then
  Begin
    strSQL := strSQL + '  AND (R.CTP_CODFOR = :CODFOR ';

    If (chkFiltrarFiliais.Checked) And (Not fEmptyStr(strCNPJ)) Then
    Begin
      strSQL := strSQL + '  OR R.CTP_CODFOR IN (';
      strSQL := strSQL + '     SELECT FOR_CODFOR FROM CADFOR WHERE FOR_C_G_C_ LIKE "' + LeftStr(strCNPJ, 8) + '%") ';
    End;

    strSQL := strSQL + '  ) ';
  End;

  If Not fEmptyStr(edtCodPor.Text) Then
    strSQL := strSQL + fStrLocate(edtCodPor, arrPortador, 'R.CTP_CODPOR', 'CODPOR')
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + '  AND (IFNULL(R.CTP_CODPOR, "") = "" ';
    strSQL := strSQL + '  OR LOCATE(R.CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  if not fEmptyStr(fraCentroCusto.edtCodEve.Text) then
    strSQL := strSQL + fStrLocate(fraCentroCusto.edtCodEve, arrEvento, 'R.CTP_CODEVE', 'CODEVE');

  if not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) then
    strSQL := strSQL + fStrLocateLinGru(fraPlanoDeContas.MskCodCta, arrCentCusto, 'R.CTP_CODCTA', 'CODCTA');

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    case rgPeriodo.ItemIndex of
      0 : strSQL := strSQL + '  AND R.CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
      1 : strSQL := strSQL + '  AND R.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';
    end;
  End;

  If (rdgLiberados.Visible) Then
  Begin
    Case rdgLiberados.ItemIndex Of
      0: strSQL := strSQL + '  AND R.CTP_DTALIB IS NOT NULL ';
      1: strSQL := strSQL + '  AND R.CTP_DTALIB IS NULL ';
    End;
  End;

  If Not fCfgSis('PRECTP', varBoolean) Then
    strSQL := strSQL +  ' AND CTP_PREVIS <> "S" ';


  Result := strSQL;
End;

procedure TfrmAgrupDuplicatasCtp.pAtualizaTemporaria;
  Var
    qryCtaPag: TUniQuery;
    dspCtaPag: TUniDataSetProvider;
    strEvento,
    strCentCusto : String;
    prcScroll: TprcScroll;
begin
  pDisableControls(cdsCtaPag, prcScroll);
  pLiberaDupsMarcadas;

  cdsCtaPag.Filtered := False;
  cdsCtaPag.Close;
  qryCtaPag := fCriaQuery(Self);
  dspCtaPag:= TUniDataSetProvider.Create(Self);
  dspCtaPag.DataSet := qryCtaPag;
  cdsCtaPag.SetProvider(dspCtaPag);

  With qryCtaPag Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fGetSql);

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    If Not fEmptyStr(edtCodFor.Text) Then
      ParamByName('CODFOR').AsString := edtCodFor.Text;

    If Not (fCfgSis('DACPOR', varBoolean)) Or
       (fCfgSis('DACPOR', varBoolean)      And
        Not (fEmptyStr(edtCodPor.Text)))   Then
      pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryCtaPag);

    pSetaParam(fraCentroCusto.edtCodEve.Text, arrEvento,strEvento,'CODEVE',qryCtaPag);
    pSetaParam(fraPlanoDeContas.MskCodCta.Text, arrCentCusto ,strCentCusto ,'CODCTA',qryCtaPag);

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    Open;

    If Not IsEmpty then
    Begin
      pSetaClient(qryCtaPag);
      cdsCtaPag.Open;
      TFloatField(cdsCtaPag.FieldByName('CTP_VALDUP')).DisplayFormat := '#,##0.00';
      cdsCtaPag.IndexFieldNames := 'FOR_NOMFOR;CTP_DTAVEN';
      cdsCtaPag.First;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Não há duplicatas para serem agrupadas!', ['&O k']);
      if chkLimFil.Checked then
        pLimpaDados;
      pSetFocus(edtCodEmp);
      blnMudarFoco := False;
    End;

    Close;
  End;

  pEnableControls(cdsCtaPag, prcScroll);

  cdsCtaPag.SetProvider(nil);
  FreeAndNil(dspCtaPag);
  FreeAndNil(qryCtaPag);
end;

procedure TfrmAgrupDuplicatasCtp.pCalculaTotalDuplicatas(edtTotal: TEditFocus; blnFiltrar: Boolean);
  Var
    cdsGen: TUniClientDataSet;
    fldGen: TAggregateField;
begin

  Try
    Application.ProcessMessages;
    cdsGen := TUniClientDataSet.Create(Nil);
    fldGen := fCriaAggregateField(cdsGen, 'FLDGEN', 'SUM(CTP_VALDUP)');
    cdsGen.Data := cdsCtaPag.Data;

    If blnFiltrar Then
    Begin
      cdsGen.Filtered := False;
      cdsGen.Filter := 'CTP_MARDES = ' + QuotedStr('M');
      cdsGen.Filtered := True;
    End;

    cdsGen.AggregatesActive := True;

    If Not cdsGen.IsEmpty Then
      edtTotal.Text := FormatFloat(',0.00', IIF(fldGen.Value = Null, 0, fldGen.Value))
    Else
      edtTotal.Text := '0,00';

    FreeAndNil(fldGen);
    FreeAndNil(cdsGen);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmAgrupDuplicatasCtp.pCalculaTotalDuplicatas]');
    End;
  End;
end;

procedure TfrmAgrupDuplicatasCtp.pCalculaTotalSelecionado;
begin

end;

procedure TfrmAgrupDuplicatasCtp.fraCentroCustoedtCodEveExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Centro de Custos');
end;

procedure TfrmAgrupDuplicatasCtp.fraPlanoDeContasMskCodCtaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, arrCentCusto, fRetNomeConta, Nil, 'da Conta');
  fraPlanoDeContas.MskCodCtaExit(Sender);

end;

procedure TfrmAgrupDuplicatasCtp.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentCusto, False) Then
  Begin
    If fValidaCampos(fraPlanoDeContas.MskCodCta, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmAgrupDuplicatasCtp.fValidaCampos(Sender: TWinControl;blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodEmp) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaEmpresa;
        If (qryConEmp.FieldByName('EMP_CODEMP').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodFor) Then
    Begin
      If Not fEmptyStr(edtCodFor.Text) Then
      Begin
        pCarregaFornecedor;
        If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        edtNomFor.Text := 'TODOS';
        Result := True;
      End;
      chkFiltrarFiliais.Enabled := Not fEmptyStr(edtCodFor.Text);
    End

    Else If (Sender = edtCodPor) Then
    Begin
      if fEmptyStr(edtNomPor.Text) then
      Begin
        edtNomPor.Text := 'TODOS';
        Result := True;
      End;
    End

    {*****************************************}
    {* VALIDA O CAMPO PORTADOR               *}
    {**************************************RV*}
    Else If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        pDesmarcaLista(edtCodPor, arrPortador, 'TMP_PORTADOR');

        {*REQ*145940**********RP*}
        If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Você não tem permissão para utilizar este portador!', ['&O k']);
            Result := False;
          End;
        End;

      End
      Else
      Begin
        edtNomPor.Text := 'TODOS';
        Result := True;
      End;
    End

    {*****************************************}
    {* VALIDA A DATA INICIAL                 *}
    {**************************************MV*}
    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;
    End

    {*****************************************}
    {* VALIDA A DATA FINAL                   *}
    {**************************************MV*}
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
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser digitada!', ['&Ok']);
        Result := False;
        blnMudarFoco := False;
        pSetFocus(mskDtaIni);
      End;
    End

    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        If fraCentroCusto.edtCodEve.Text <> '00000' Then
           pCarrregaDescricaoEvento;

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End;

      End
      Else
      Begin
        fraCentroCusto.edtDesEve.Text := 'TODOS';
        Result := True;
      End
    end

    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin
        If fraPlanoDeContas.MskCodCta.Text <> '0' Then
          pCarrregaDescricaoPlanoDeConta;

        if fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
          Result := False;
        End;

      End
      Else
      Begin
        fraPlanoDeContas.edtDesCta.Text := 'TODOS';
        Result := True;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmAgrupDuplicatasCtp.fValidaDuplicatasRelacionadasComRomaneio: Boolean;
Var ScdsDuplicatas : TUniClientDataSet;
    SDuplicatas    : String;
    SCadPagRomaneioRepository : TCadPagRomaneioRepository;
    SList : TList<TCadPagRomaneio>;
Begin
  Result := True;

  ScdsDuplicatas             := TUniClientDataSet.Create(Self);
  SCadPagRomaneioRepository  := TCadPagRomaneioRepository.Create;
  SDuplicatas                := '';

  try
    ScdsDuplicatas.Data     := cdsCtaPag.Data;
    ScdsDuplicatas.Filtered := False;
    ScdsDuplicatas.Filter   := 'CTP_MARDES = ' + QuotedStr('M');
    ScdsDuplicatas.Filtered := True;

    ScdsDuplicatas.First;
    while not ScdsDuplicatas.eof do
    begin
      SList := SCadPagRomaneioRepository.fGetContasPagarVinculadasComRomaneio(
                  ScdsDuplicatas.FieldByName('NRODUP').AsString,
                  ScdsDuplicatas.FieldByName('CTP_SERIE_').AsString,
                  ScdsDuplicatas.FieldByName('CTP_CODFOR').AsString,
                  ScdsDuplicatas.FieldByName('CTP_CODEMP').AsString);

      if SList.Count > 0 then
        SDuplicatas := SDuplicatas + IIF(SDuplicatas = '',
                                    '"'+ScdsDuplicatas.FieldByName('NRODUP').AsString+'"',
                                    ', "'+ScdsDuplicatas.FieldByName('NRODUP').AsString+'"');

      ScdsDuplicatas.Next;
    end;

    if not fEmptyStr(SDuplicatas) then
      Result := fPergunta('Duplicata(s) '+SDuplicatas+' relacionada(s) com romaneio.'+
      'Se continuar com o agrupamento esses vinculos serão perdidos. Deseja continuar?', True);

  finally
    FreeAndNil(ScdsDuplicatas);
    FreeAndNil(SCadPagRomaneioRepository);
  end;
end;

function TfrmAgrupDuplicatasCtp.fVerificaContas(fltTotalAgr: Double): Boolean;
var
  intRecNo: Integer;
  blnControlsDisabled: Boolean;
  qryCtpDet: TUniQuery;
  fltValorDet: Double;
begin
  Result    := False;
  blnRateio := False;
  SetLength(arrRateio, 0);

  blnControlsDisabled := cdsCtaPag.ControlsDisabled;

  if blnControlsDisabled = False then
     cdsCtaPag.DisableControls;

  intRecNo := cdsCtaPag.RecNo;

  cdsCtaPag.First;
  while not cdsCtaPag.Eof do
  begin
    if cdsCtaPag.FieldByName('CTP_MARDES').AsString = 'M' then
    begin
      qryCtpDet := fCriaQuery();

      with qryCtpDet do
      begin
        Sql.Clear;
        Sql.Text := ' SELECT * ' +
                    '   FROM   ' +
                    ' CTPDET   ' +
                    ' WHERE    ' +
                    '   CTP_NUMDUP = :NUMDUP AND ' +
                    '   CTP_CODFOR = :CODFOR AND ' +
                    '   CTP_PARCEL = :PARCEL AND ' +
                    '   CTP_EMPORI = :CODEMP AND ' +
                    '   CTP_SERIE_ = :SERIE_';

        ParamByName('NUMDUP').AsString :=  cdsCtaPag.FieldByName('NRODUP').AsString;
        ParamByName('CODFOR').AsString :=  cdsCtaPag.FieldByName('CTP_CODFOR').AsString;
        ParamByName('CODEMP').AsString :=  cdsCtaPag.FieldByName('CTP_CODEMP').AsString;
        ParamByName('PARCEL').AsString :=  cdsCtaPag.FieldByName('PARDUP').AsString;
        ParamByName('SERIE_').AsString :=  cdsCtaPag.FieldByName('CTP_SERIE_').AsString;

        Open;
      end;

      if not qryCtpDet.IsEmpty then
      begin
        while not qryCtpDet.Eof do
        begin
          fltValorDet := RoundTo((cdsCtaPag.FieldByName('CTP_VALDUP').AsFloat*qryCtpDet.FieldByName('CTP_FATCAL').AsFloat), -2);
          pAdicionarArray(qryCtpDet.FieldByName('CTP_CODCTA').AsString,
                          qryCtpDet.FieldByName('CTP_CODEVE').AsString,
                          qryCtpDet.FieldByName('CTP_CODEMP').AsString ,
                          fltValorDet,
                          fltTotalAgr);

          qryCtpDet.Next;
        end;
      end
      else
      begin
        pAdicionarArray(cdsCtaPag.FieldByName('CTP_CODCTA').AsString,
                          cdsCtaPag.FieldByName('CTP_CODEVE').AsString,
                          cdsCtaPag.FieldByName('CTP_CODEMP').AsString,
                          cdsCtaPag.FieldByName('CTP_VALDUP').AsFloat,
                          fltTotalAgr);
      end;

      FreeAndNil(qryCtpDet);
    end;

    cdsCtaPag.Next;
  end;

  cdsCtaPag.RecNo :=  intRecNo;

  if blnControlsDisabled = False then
     cdsCtaPag.EnableControls;

  if Length(arrRateio) > 1 then
  begin
    If (fMensagem('', 'As duplicatas agrupadas possuem planos de contas e/ou empresas diferentes. ' +
                      'Realizar o desmembramento automático dos planos de contas/empresas na ' +
                      'nova duplicata gerada pelo agrupamento ?', ['&Sim', '&Não']) = 1) Then
    begin
      If (fEmptyStr(fCfgSis('CTAPRI')) Or fEmptyStr(fCfgSis('EVEPRI'))) Then
      Begin
        fMensagem('', 'As configurações: "Plano de Contas principal para rateio de duplicatas" e "Centro de Custos principal para rateio de duplicatas" devem estar preenchidas nas configurações do sistema!', ['&Ok']);
        Exit;
      End
      Else If (fEmptyStr(fRetNomEvento(fCfgSis('EVEPRI')))) Or
        (fEmptyStr(fRetNomeConta(fCfgSis('CTAPRI')))) Then
      Begin
        fMensagem('', 'Os códigos informados nas configurações: "Plano de Contas principal para rateio de duplicatas" e "Centro de Custos principal para rateio de duplicatas" devem estar cadastrados no sistema!', ['&Ok']);
        Exit;
      End;

      blnRateio := True;
    end
    else
      blnRateio := False;
  end;

  Result := True;
end;

procedure TfrmAgrupDuplicatasCtp.edtCodEmpExit(Sender: TObject);
Var
  arrEmp: TConsultasArray;

begin
  inherited;
   pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, Nil,fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmAgrupDuplicatasCtp.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAgrupDuplicatasCtp.edtCodForExit(Sender: TObject);
Var
  arrFornec: TConsultasArray;
begin
  inherited;
   pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmAgrupDuplicatasCtp.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAgrupDuplicatasCtp.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtNomPor, arrPortador, nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmAgrupDuplicatasCtp.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtNomPor,
                   nil,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text) Then
  Begin
    If (fValidaCampos(edtCodPor, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAgrupDuplicatasCtp.dbgDuplicatasViewColumnSizeChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  If dbgDuplicatasView.DataController.DataSet.Active Then
     fGetFuncoesCxGrid.pSalvarView(dbgDuplicatasView,
                                   Self.Name + '.' + dbgDuplicatasView.Name,
                                   dbgDuplicatasView.DataController.DataSet);

end;

procedure TfrmAgrupDuplicatasCtp.dbgDuplicatasViewDblClick(
  Sender: TObject);
begin
  inherited;
  pSelecionaDuplicata;
 // pSetFocus(Self);
end;

procedure TfrmAgrupDuplicatasCtp.dbgDuplicatasViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  {*****************************************}
  {* MARCA / DESMARCA CHEQUE               *}
  {**************************************MV*}

  If (Key = VK_Return) And (Not cdsCtaPag.IsEmpty) Then
  Begin
    If cdsCtaPag.FieldByName('CTP_MARDES').AsString <> 'M' Then
    Begin
      Try
        pSelecionaDuplicata(cdsCtaPag.RecNo);
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmAgrupDuplicatasCtp.dbgDuplicatasKeyDown]');
        End;
      End;
    End
    Else
      pSelecionaDuplicata;

    pSetFocus(Self);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(edtCodEmp);
  End;

end;


function TfrmAgrupDuplicatasCtp.fMarcarTodas(
  pgbStatus: TcxProgressBar): Boolean;
Var
  prcScroll: TprcScroll;
begin
 Result := True;
 if cdsCtaPag.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  end;
   If Not cdsCtaPag.IsEmpty Then
  Begin
    pgbStatus.Properties.Max := cdsCtaPag.RecordCount;
    With cdsCtaPag Do
    Begin
      pDisableControls(cdsCtaPag, prcScroll);
      //AggregatesActive := False;
      First;
      While Not Eof Do
      Begin
        If ((FieldByName('CTP_MARDES').AsString <> 'M') And (True)) Or
           ((FieldByName('CTP_MARDES').AsString = 'M') And (Not True)) Then
          pMarcaDuplicata(True);
        pStep(pgbStatus);
        Next;
      End;
      pEnableControls(cdsCtaPag, prcScroll);
      //AggregatesActive := True;
      pCalculaTotalDuplicatas(edtTotalSelecionado, True);
    End;
  End;
end;

function TfrmAgrupDuplicatasCtp.fMarcouMaisDeUmFonecedor: Boolean;
  Var
    cdsGen    : TUniClientDataSet;
    strCodFor : String;
Begin
  Result := False;
  cdsGen := TUniClientDataSet.Create(Self);
  With cdsGen Do
  Begin
    Data := cdsCtaPag.Data;

    Filtered := False;
    Filter := 'CTP_MARDES = ' + QuotedStr('M');
    Filtered := True;

    If RecordCount > 1 Then
    Begin
      strCodFor := FieldByName('CTP_CODFOR').AsString;

      Filtered := False;
      Filter := 'CTP_MARDES = ' + QuotedStr('M') + ' AND CTP_CODFOR <> ' + QuotedStr(strCodFor);
      Filtered := True;

      Result := Not IsEmpty;
    End;
  End;
  FreeAndNil(cdsGen);
End;

procedure TfrmAgrupDuplicatasCtp.btnConfirmaClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
    cdsClone,
    cdsGenCtp : TUniClientDataSet;
    frmDigPortador : TfrmDigPortador;
    frmAgrupSelFornecedor: TfrmAgrupSelFornecedor;
    strEmpSemAcesso: String;

  function fValidaFornecedor: Boolean;
    Var
      cdsGen    : TUniClientDataSet;
      strFiliais: String;
  Begin
    {**********************************}
    {* VALIDA SE EXISTE DUPLICATAS    *}
    {* COM FORNECEDORES QUE NÃO SEJAM *}
    {* FILIAIS                        *}
    {*******************************AJ*}
    cdsGen := TUniClientDataSet.Create(Self);
    With cdsGen Do
    Begin
      Data := cdsCtaPag.Data;

      Filtered := False;
      Filter := 'CTP_MARDES = ' + QuotedStr('M');
      Filtered := True;

      If RecordCount > 1 Then
      Begin
        //Valida Fornecedores filiais
        strFiliais := FieldByName('CNPJ').AsString;

        Filtered := False;
        Filter := 'CTP_MARDES = ' + QuotedStr('M') + ' AND CNPJ <> ' + QuotedStr(strFiliais);
        Filtered := True;

        Result := IsEmpty;
      End
      Else Result := True;
    End;
    FreeAndNil(cdsGen);
  End;

  procedure pClonaDuplicatasMarcadas;
  Begin
    cdsClone := TUniClientDataSet.Create(Self);

    pCloneDataSet(cdsClone, cdsCtaPag);

    With cdsClone Do
    Begin
      Filtered := False;
      Filter := 'CTP_MARDES = ''M''';
      Filtered := True;
    End;
  End;

  function fDuplicatasJaUtilizadasPorOutrosUsuarios: Boolean;
  Begin
    Result := True;

    With cdsClone Do
    Begin
      First;

      While Not Eof Do
      Begin
        If stlAutIncDupMar.IndexOf(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString) <> -1 Then
        Begin
          Result := False;
          Break;
        End;

        Next;
      End;
    End;
  End;

  function fVerificaDuplicatasExcluidas: Boolean;
    Var
      strSQL: String;
      qryTmp: TUniQuery;
  Begin
    Result := True;

    With cdsClone Do
    Begin
      First;
      qryTmp := fCriaQuery;

      While Not Eof Do
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   COUNT(*) AS QTD ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + FieldByName('TABELA').AsString;
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   AUTOINCREM = :AUTINC';

        qryTmp.Params.Clear;
        qryTmp.SQL.Clear;
        qryTmp.SQL.Add(strSQL);
        qryTmp.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
        qryTmp.Open;

        If Not qryTmp.IsEmpty Then
        Begin
          If qryTmp.FieldByName('QTD').AsInteger = 0 Then
          begin
            Result := False;
            Break;
          end;
        End
        Else
        begin
          Result := False;
          Break;
        end;

        Next;
      End;

      FreeAndNil(qryTmp);
    End;
  End;

  function fVerificaEventosDuplicatas: String;
  Begin
    result := '';

    With cdsClone Do
    Begin

      Filtered := False;
      Filter := 'CTP_MARDES = ''M''';
      Filtered := True;

      If Not cdsClone.IsEmpty Then
      Begin
         result := cdsClone.FieldByName('CTP_CODEVE').AsString;

         Filtered := False;
         Filter := 'CTP_MARDES = ''M'' AND CTP_CODEVE <> ' + QuotedStr(result);
         Filtered := True;

         If Not cdsClone.IsEmpty Then
            result := '';
      End;
    End;

  End;

begin
  inherited;

  if (cdsCtaPag.IsEmpty) then
  begin
    fMensagem('Aviso', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  end;

  If (Not fVerificaCampos) Then
    Exit;

  {***************************************************}
  {* VERIFICANDO SE FOI SELECIONADA ALGUMA DUPLICATA *}
  {************************************************AN*}
  cdsGenCtp := TUniClientDataSet.Create(Self);
  With cdsGenCtp Do
  Begin
    Data     := cdsCtaPag.Data;
    Filtered := False;
    Filter   := 'CTP_MARDES = ' + QuotedStr('M');
    Filtered := True;

    If IsEmpty Then
    Begin
      fMensagem('Aviso', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
      FreeAndNil(cdsGenCtp);
      Exit;
    End;
  End;
  FreeAndNil(cdsGenCtp);

  {**********************************************************}
  {* VERIFICA SE FORAM SELECIONADOS FORNECEDORES DIFERENTES *}
  {*******************************************************AN*}
  If Not fValidaFornecedor Then
  Begin
    fMensagem('ATENÇÃO!', 'Para agrupamento não é permitido escolher Fornecedores que não sejam da mesma filial!', ['&Ok']);
    Exit;
  End;

  If Not fValidaDuplicatasRelacionadasComRomaneio Then
    Exit;

  pClonaDuplicatasMarcadas;

  If Not fDuplicatasJaUtilizadasPorOutrosUsuarios Then
  Begin
    fMensagem('ATENÇÃO!', 'Existem duplicatas que estão sendo agrupadas e as mesma foram utilizadas por outro usuário. Realize a pesquisa novamente para efetuar o agrupamento corretamente!', ['&OK']);
    FreeAndNil(cdsClone);
    Exit;
  End;

  {********************************************************************}
  {* REALIZADO ESSE TRATAMENTO DEVIDO AO DESAGRUPAMENTO DE DUPLICATAS *}
  {********************************************************************}
  If Not fVerificaDuplicatasExcluidas Then
  Begin
    fMensagem('ATENÇÃO!', 'Existem duplicatas que foram excluídas por outro usuário. Realize a pesquisa novamente para efetuar o agrupamento corretamente!', ['&OK']);
    FreeAndNil(cdsClone);
    Exit;
  End;

  If fDocumentosComPendenciaCancelamento Then
  Begin
    FreeAndNil(cdsClone);
    Exit;
  End;

  strFornecedorSelecionado := '';
  If fMarcouMaisDeUmFonecedor Then
  Begin
    pCriarFormularios(TfrmAgrupSelFornecedor, frmAgrupSelFornecedor);
    frmAgrupSelFornecedor.strCNPJ := cdsclone.FieldByName('CNPJ').Asstring;
    frmAgrupSelFornecedor.ShowModal;

    strFornecedorSelecionado := frmAgrupSelFornecedor.strCodFor;
    blnConfirma := frmAgrupSelFornecedor.ModalResult = mrOK;

    pFreeAndNil(frmAgrupSelFornecedor);
    If Not blnConfirma Then
      Exit;
  End;

  If (fMensagem('', 'Confirma agrupamento?', ['&Sim', '&Não']) = 1) Then
  Begin
    Try
      strCodPor := '';
      strCodEve := '';
      pCriarFormularios(TfrmDigPortador, frmDigPortador);
      frmDigPortador.pnlCentroCusto.Visible := True;
      frmDigPortador.pnlHistorico.Visible := True;
      frmDigPortador.blnVeioAgrupCTP := True;
      frmDigPortador.strCodEveSugAgrup := fVerificaEventosDuplicatas;
      frmDigPortador.ShowModal;

      blnConfirma := frmDigPortador.blnConfirma;
      If (blnConfirma) Then
      Begin
        {*REQ*145940**********RP*}
        If Not fEmpresasTemAcessoPortador(frmDigPortador.strCodPor,
                                          cdsClone,
                                          'CTP_CODEMP',
                                          strEmpSemAcesso,
                                          'CTP_MARDES = ''M''') Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do Portador informado: '+ strEmpSemAcesso +'. Operação abortada!', ['&OK']);
          Exit;
        End;

        strCodPor := frmDigPortador.strCodPor;
        strHist01 := frmDigPortador.LHistorico01;
        strCodEve := frmDigPortador.strEvento;
      End;
    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message, '[frmAgrupDuplicatasCtp.btnConfirmaClick]');
      End;
    End;
    pFreeAndNil(frmDigPortador);

    If blnConfirma Then
      pAgruparDuplicatas;

    If Assigned(cdsClone) Then
    Begin
      With cdsClone Do
      Begin
        First;

        While Not Eof Do
        Begin
          fLock_Unlock(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString, False);
          Next;
        End;
      End;

      FreeAndNil(cdsClone);
    End;
  End;
end;

procedure TfrmAgrupDuplicatasCtp.btnDesmarcaClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fDesmarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Duplicatas!';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure TfrmAgrupDuplicatasCtp.btnHistDocumentosClick(Sender: TObject);
  Var
    frmRelCtpLogAcompDuplicNovo: TfrmRelCtpLogAcompDuplicNovo;
begin
  inherited;
  Try
    pCriarFormularios(TfrmRelCtpLogAcompDuplicNovo, frmRelCtpLogAcompDuplicNovo);
    frmRelCtpLogAcompDuplicNovo.blnVeioAgrupamento := True;
    frmRelCtpLogAcompDuplicNovo.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmAgrupDuplicatasCtp.btnHistDocumentos]');
  End;
  pFreeAndNil(frmRelCtpLogAcompDuplicNovo);
end;

procedure TfrmAgrupDuplicatasCtp.btnIniciaBuscaClick(Sender: TObject);
begin
  inherited;

  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('', 'É necessário filtrar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;


  Try
    pCriarFormularios(TfrmAgrupDuplicatasCtpBusca, frmAgrupDuplicatasCtpBusca);
    frmAgrupDuplicatasCtpBusca.ShowModal;

    TfrmGravando.fExecutarModal(pConcluiBusca,'Aguarde... Localizando Duplicata.','');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmAgrupDuplicatasCtp.btnIniciaBusca]');
    End;
  End;

  pSetFocus(dbgDuplicatas);
  pFreeAndNil(frmAgrupDuplicatasCtpBusca);
end;

procedure TfrmAgrupDuplicatasCtp.btnLocalizaProxClick(Sender: TObject);
begin
  inherited;

  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('AVISO', 'É necessário filtrar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    TfrmGravando.fExecutarModal(pLocalizaProximaDup,'Aguarde... Localizando Título.','');
    pSetFocus(dbgDuplicatas);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);

end;

procedure TfrmAgrupDuplicatasCtp.btnMarcaClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Checando e Marcando Duplicatas!';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure TfrmAgrupDuplicatasCtp.btnCarrTitulosClick(Sender: TObject);
Var
    intRecNo : Integer;
begin
  inherited;
  if fVerificaCampos then
  begin
    TfrmGravando.fExecutarModal(pAtualizaTemporaria,'Aguarde... Carregando Títulos.','');

    fGetFuncoesCxGrid.fCarregarView(dbgDuplicatasView,
                                    Self.Name + '.' + dbgDuplicatasView.Name,
                                    cdsCtaPag,
                                    intRecNo);

    pCalculaTotalDuplicatas(edtTotalDup, False);
    pCalculaTotalDuplicatas(edtTotalSelecionado, True);
    If (Not cdsCtaPag.IsEmpty) Then
      pSetFocus(dbgDuplicatas);
  end;
end;

procedure TfrmAgrupDuplicatasCtp.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);
    frmCadConfRelatorios.strNomeForm   := Self.Name;
    frmCadConfRelatorios.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmAgrupDuplicatasCtp.btnConfigurarClick]');
    End;
  End;
  pFreeAndNil(frmCadConfRelatorios);

  If cdsCtaPag.Active Then
    pSetFocus(dbgDuplicatas)
  Else
    pSetFocus(edtCodEmp);
end;

procedure TfrmAgrupDuplicatasCtp.btnSairAgrupClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAgrupDuplicatasCtp.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodEmp);

end;

procedure TfrmAgrupDuplicatasCtp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  fGetFuncoesCxGrid.pSalvarView(dbgDuplicatasView,
                                Self.Name + '.' + dbgDuplicatasView.Name,
                                dbgDuplicatasView.DataController.DataSet);

  pLimpaDados;
end;

procedure TfrmAgrupDuplicatasCtp.FormCreate(Sender: TObject);
begin
  inherited;
  qryGenPag := fCriaQuery(Self);
  pZeraDigDuplic(arrDuplicata);

  stlAutIncDupMar := TStringList.Create;
  stlAutIncDupMar.Sorted := True;

  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);

  cdsCtaPag := TUniClientDataSet.Create(Self);
  cdsCtaPag.OnFilterRecord := pFilterRecord;

  dtsCtaPag := fCriaDataSource(cdsCtaPag);
  dbgDuplicatasView.DataController.DataSource :=  dtsCtaPag;
  edtHistor.DataSource :=  dtsCtaPag;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
end;

procedure TfrmAgrupDuplicatasCtp.FormDestroy(Sender: TObject);
begin
  pLiberaDupsMarcadas;
  inherited;
  FreeAndNil(stlAutIncDupMar);
end;

procedure TfrmAgrupDuplicatasCtp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F5) Then
  Begin
    btnIniciaBusca.Click;
  End
  Else If (Key = VK_F6) Then
  Begin
    btnLocalizaProx.Click;
  End
  Else
  If (Key = VK_F7) Then
  Begin
    btnMarca.Click;
  End
  Else If (Key = VK_F8) Then
  Begin
    btnDesmarca.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;

end;

procedure TfrmAgrupDuplicatasCtp.FormShow(Sender: TObject);
Var
    IntRecNo : Integer;
begin
  inherited;
  intTotalMarcado := 0;
  psetFocus(edtCodEmp);
  rdgLiberados.Visible := fCfgSis('CTPLBB', varBoolean);

  fGetFuncoesCxGrid.fCarregarView(dbgDuplicatasView, Self.Name + '.' + dbgDuplicatasView.Name, dbgDuplicatasView.DataController.DataSet, intRecNo);

end;

procedure TfrmAgrupDuplicatasCtp.edtHistorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Key := 0;
end;

procedure TfrmAgrupDuplicatasCtp.pRetornaTotal(strCodFor: String; Var fltTotFor: Double);
var
  cdsGen: TUniClientDataSet;
  fldGen: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  fldGen := TAggregateField.Create(Self);
  With fldGen Do
  Begin
    FieldName := 'CTP_VALTOT';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(CTP_VALDUP)';
    Active := True;
  End;

  With cdsGen Do
  Begin
    Data := cdsCtaPag.Data;

    Filtered := False;
    Filter := 'CTP_MARDES = ' + QuotedStr('M');
    Filtered := True;

    AggregatesActive := True;
    fltTotFor := fldGen.Value;
  End;

  FreeAndNil(fldGen);
  FreeAndNil(cdsGen);
end;

function TfrmAgrupDuplicatasCtp.fChamaDesconto(strCodFor, strNomFor: String; fltTotFor: Double):Boolean;
  Var
    strValDes: String;
begin
  Result := True;

  If fltTotFor <= 0 Then
    Exit;

  {*******************************************}
  {* CHAMA O FORM DE DESCONTO                *}
  {****************************************AC*}
  Try
    pCriarFormularios(TfrmDigDesconto, frmDigDesconto);
    frmDigDesconto.lblCliente.Caption := strCodFor + ' - ' + strNomFor;
    frmDigDesconto.edtTotGer.Text := FloatToStrF(fltTotFor, ffNumber, 12, 2);
    frmDigDesconto.blnPermiteAcrescimo := True;
    frmDigDesconto.blnAgrDup := True;
    frmDigDesconto.ShowModal;

    If frmDigDesconto.ModalResult = mrOk Then
    Begin
      strValDes := IIF(fEmptyStr(frmDigDesconto.edtDesEsp.Text),'0,00',frmDigDesconto.edtDesEsp.Text);
      strValDes := FloatToStrF(fStrToFloat(strValDes), ffNumber, 12, 2);
    End
    Else
    Begin
      strValDes := '0,00';
      Result    := False;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      strValDes := '0,00';
      pMensagensErro(E.Message, '[frmAgrupDuplicatas.fChamaDesconto]');
    End;
  End;

  pFreeAndNil(frmDigDesconto);

  {*******************************************}
  {* CHAMA O DESCONTO SE HOUVER              *}
  {****************************************AC*}
  If fStrToFloat(strValDes) <> 0 Then
  Begin

    If Not fAtualizaValoresTemporaria(strCodFor, FloatToStrF(fltTotFor, ffNumber, 12, 2),strValDes) Then
      Result := False;

  End;

end;

function TfrmAgrupDuplicatasCtp.fAtualizaValoresTemporaria(strCodFor, strValTot, strValDes: String):Boolean;
  Var
    fltValDes: Double;
    fltTotDes: Double;
    fltTmpDes: Double;
    fltTmpDup: Double;
    intRecNo: Integer;
    cdsGen: TUniClientDataSet;
begin
  Try
    Result := True;
    cdsGen := TUniClientDataSet.Create(Self);
    With cdsGen Do
    Begin
      intRecNo := cdsCtaPag.RecNo;
      Data := cdsCtaPag.Data;

      Filtered := False;
      Filter := 'CTP_MARDES = ''M'' AND CTP_CODFOR = ' + QuotedStr(strCodFor);
      Filtered := True;

      First;
      While Not Eof Do
      Begin
        fltValDes := fFormataFloat((fStrToFloat(FloatToStrF(FieldByName('CTP_VALDUP').AsFloat, ffNumber, 12, 2)) / fStrToFloat(strValTot)) * fStrToFloat(strValDes),2);

        Edit;
        FieldByName('CTP_VALDUP').AsFloat := FieldByName('CTP_VALDUP').AsFloat - fltValDes;
        FieldByName('CTP_VALDES').AsFloat := fltValDes;
        Post;

        Next;
      End;

      {**************************************}
      {* VERIFICA DIFERENÇA DE CENTAVOS     *}
      {***********************************AF*}
      First;
      fltTotDes := 0;
      While Not Eof Do
      Begin
        fltTotDes := fltTotDes + FieldByName('CTP_VALDES').AsFloat;
        Next;
      End;

      If fFormataFloat(fltTotDes, 2) <> fFormataFloat(fStrToFloat(strValDes), 2) Then
      Begin
        fltTmpDes := fFormataFloat(fStrToFloat(strValDes),2) - fFormataFloat(fltTotDes,2);
        fltTmpDup := fFormataFloat(fltTotDes,2) - fFormataFloat(fStrToFloat(strValDes),2);

        If fFormataFloat(fltTmpDes, 2) <> 0 Then
        Begin
          First;

          fltTmpDes := fltTmpDes + FieldByName('CTP_VALDES').AsFloat;
          fltTmpDup := fltTmpDup + FieldByName('CTP_VALDUP').AsFloat;

          Edit;
          FieldByName('CTP_VALDUP').AsFloat  := fltTmpDup;
          FieldByName('CTP_VALDES').AsFloat  := fltTmpDes;
          Post;
        End;
      End;

      {**************************************}
      {* ATUALIZANDO OS REGISTROS DO CLIENT *}
      {* COM AS ALTERACOES REALIZADAS       *}
      {***********************************AN*}
      cdsCtaPag.Data := Data;
      TFloatField(cdsCtaPag.FieldByName('CTP_VALDUP')).DisplayFormat := '#,##0.00';
      cdsCtaPag.RecNo := intRecNo;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmAgrupDuplicatasCtp.fAtualizaValoresTemporaria]');
    End; 
  End;
  FreeAndNil(cdsGen);
end;

function TfrmAgrupDuplicatasCtp.fDocumentosComPendenciaCancelamento: Boolean;
  Var
    stlPendencias : TStringList;
    frmCancelamentoDocResumo : TfrmCancelamentoDocResumo;
Begin
  stlPendencias := TLogCanAgrupamento.VerificarPendencias(
    cdsCtaPag,
    function(ADataSet: TUniClientDataSet; const APendencia: TDtoLogCan): String
    Begin
      ADataSet.Filtered := False;
      ADataSet.Filter := Format('CTP_MARDES = %s AND NRODUP = %s AND CTP_CODEMP = %s AND CTP_CODFOR = %s AND CTP_SERIE_ = %s',
        [QuotedStr('M'), QuotedStr(APendencia.strNumDoc), QuotedStr(APendencia.strCodEmp), QuotedStr(APendencia.strCliFor), QuotedStr(APendencia.strSerie)]);
      ADataSet.Filtered := True;
      If Not ADataSet.IsEmpty Then
        Result := APendencia.strNumDoc + '-' + APendencia.strCodEmp + ' - Fornecedor: ' + APendencia.strCliFor
      Else
        Result := '';
    End,
    'F'
  );
  Try
    Result := stlPendencias.Count > 0;
    If Result Then
    Begin
      pCriarFormularios(TfrmCancelamentoDocResumo, frmCancelamentoDocResumo);
      Try
        frmCancelamentoDocResumo.Caption := 'Duplicatas com pendencia no cancelamento nao podem ser agrupadas';
        frmCancelamentoDocResumo.memResumo.Lines.Text := stlPendencias.Text;
        frmCancelamentoDocResumo.memResumo.Lines.Insert(0, 'Duplicatas com pendencia no cancelamento nao podem ser agrupadas');
        frmCancelamentoDocResumo.memResumo.Lines.Insert(1, '');
        frmCancelamentoDocResumo.memResumo.Lines.Insert(2, '');
        frmCancelamentoDocResumo.ShowModal;
      Finally
        pFreeAndNil(frmCancelamentoDocResumo);
      End;
    End;
  Finally
    FreeAndNil(stlPendencias);
  End;
end;

end.

