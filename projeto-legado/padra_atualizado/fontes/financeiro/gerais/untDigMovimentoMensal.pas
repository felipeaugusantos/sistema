Unit untDigMovimentoMensal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridCitel, DBGrids, AppEvnts, Menus, StdCtrls, untCtaDet,
  Buttons, ExtCtrls, Mask, MaskEditFocus, untControlePagtoFunc, UniDataSetProvider,
  DB, UniClientDataSet, EditFocus, untPai, BitBtnLockedIncrem, Provider,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxButtons, cxControls, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCurrencyEdit, Uni, frxExportPDF,
  frxDMPExport, frxDBSet, Aurelius.Types.Nullable, untHerdarMesBase,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGridCitel, dxScreenTip,
  dxCustomHint, cxHint;

type
  TfrmDigMovimentoMensal = class(TfrmPai)
    pnlFiltro: TPanel;
    Label1: TLabel;
    cdsMovMen: TUniClientDataSet;
    dtsMovMen: TDataSource;
    mskMesBas: TMaskEditFocus;
    edtTipMov: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label3: TLabel;
    btnConfirma: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    btnIniBus: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    btnGerarPagar: TBitBtnLocked;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    frxRelatorioJ: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    frxDsErros: TfrxDBDataset;
    cxStyle6: TcxStyle;
    cdsErros: TUniClientDataSet;
    cdsErrosNOMFUN: TStringField;
    cdsErrosDESCRICAO: TStringField;
    dbgMovMen: TcxGridCitel;
    dbgMovMenLevel1: TcxGridLevel;
    btnHerdarMesBase: TBitBtnLocked;
    dbgMovMenDBBandedTableView: TcxGridDBBandedTableViewCitel;
    btnCarregar: TcxButton;
    btnImportarTese: TcxButton;
    btnHlpImp: TcxButton;
    btnExcluirMovimento: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    frxHelp: TfrxReport;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cdsMovMenBeforePost(DataSet: TDataSet);
    procedure dbgMovMenKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure mskMesBasClick(Sender: TObject);
    procedure dbgMovMenKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure cdsMovMenBeforeDelete(DataSet: TDataSet);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure mskMesBasExit(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure btnImportarTeseClick(Sender: TObject);
    procedure btnGerarPagarClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnHerdarMesBaseClick(Sender: TObject);
    procedure dbgMovMenDBBandedTableViewEditing(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      var AAllow: Boolean);
    procedure dbgMovMenDBBandedTableViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure dbgMovMenDBBandedTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnExcluirMovimentoClick(Sender: TObject);
    procedure btnExcluirMovimentoMouseLeave(Sender: TObject);
    procedure btnExcluirMovimentoMouseEnter(Sender: TObject);
  private
    objCadFun: TCadFun;
    objCtrPag: TCtrPag;
    objCadVer: TCadVer;
    objLiberacao : TLiberacao;
    frmHerdarMesBase: TfrmHerdarMesBase;
    FCodVerbaDebito: String;

    strValorFiltro : String;
    strCampoFiltro : String;
    procedure pCarregaGrid(blnZerado: Boolean; blnVerbasUtilizadas : Boolean = False);
    procedure pCalculaLiqReceber(blnEditar: Boolean);
    procedure pCalculaTotal(blnEditar: Boolean);
    procedure pHabilita(blnHabili: Boolean);
    procedure pImportaArquivoTese;
    procedure OnGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);

    function fVerificaSeTemValorLiquidoReceber: Boolean;
    function fConfirmaSaida: Boolean;
    function fGeraContasPagar(strCodEmp, strCompet, strHist01, aStrCodCta,
      aStrCodPor: String; dteDtaVen: TDateTime): Boolean;
    function fGravaLancamentos(blnSemMensagem:Boolean = False): Boolean;
    function fRelacionaArquivo(strArqInc: String): Boolean;
    function fTravaGeraPagar(strCodEmp, strCompet: String; dteDtaVen: TDateTime): Boolean;
    function fVerificaMovimento: Boolean;
    function fRatearDuplicata(strCodCta: String): Boolean;
    function fVerificaDadosGerPag(AAutoIncremFuncionario: String): Boolean;
    function fContaBancariaPagaPagamento(strCodFor: String): Nullable<string>;
    procedure pRetornaStatusCTP(const strAutCtp: String; var strDupCtp: String; var blnBaixada: Boolean; var strHistorico: String);
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure pConcluiBusca;
    procedure pLocalizaProxima;
    procedure pSetFocusGrid;
    procedure pCriaTemporaria(Var strCodCta, strCodPor: String);
    function CarregaArquivoImportacao(AFile: String): TStringList;
    function fVerificaSeTemFuncionariosSemPlanoContas: Boolean;
    function RetornaDelimitador(AText: String): Char;
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fVerificaCTPBaixado: Boolean;
    function fVerificaCTPEnviado: Boolean;
    function fExcluirCadPag: Boolean;

    function VerificaCTPBaixadoSelecionado: Boolean;
    function VerificaCTPEnviadoSelecionado: Boolean;
    function VerificaSeOFuncionarioFazParteDaEmpresa: Boolean;
    function ExcluirCadPagSelecionado: Boolean;
  public
    { Public declarations }
  end;


implementation

uses DateUtils, untFuncoesSimples, StrUtils, untConsultas, untTypesSistema,
  untGravandoObs, untSubjectIntf, untSubjectClass, untSelVenc, untFuncFat,
  untTCadPag, untTCadPagRepository, untUtilRepository, untTCadForRepository,
  untTCadFor, untCadPag, untLogCtp, untDigMensalFPBusca, untGravando,
  untMsgLiberacao,untTDesmembramentoPgtoFuncionarios;

{$R *.dfm}

procedure TfrmDigMovimentoMensal.pCarregaGrid(blnZerado: Boolean; blnVerbasUtilizadas : Boolean = False);
Var
  intQtdCol: Integer;
  intIndCol: Integer;
  intQtdReg: Integer;
  fltValLan: Double;
  strCodVer: String;
  strNomCam: String;
  strMesBas,
  strAutCtp,
  strDupCtp: String;
  strHist01: String;
  blnBaixad: Boolean;
  stlNomCam: TStringList;
  FGravando: IObserver_;
  FSubject_: ISubject_;
  strParam_: Array of String;

  LAutoIncremFuncionario: String;
begin
  objCadVer.fMontaGrid(mskMesBas.Text, edtCodEmp.Text, edtTipMov.Text);
  If Assigned(cdsMovMen) Then
    FreeAndNil(cdsMovMen);
  cdsMovMen := fCriaClientDatSet(objCadVer.qryGenVer);
  cdsMovMen.BeforeDelete := cdsMovMenBeforeDelete;
  cdsMovMen.BeforePost := cdsMovMenBeforePost;
  cdsMovMen.OnFilterRecord := pFilterRecord;
  dbgMovMenDBBandedTableView.DataController.DataSource := dtsMovMen;
  dtsMovMen.DataSet    := cdsMovMen;
  cdsMovMen.OnFilterRecord := pFilterRecord;
  cdsMovMen.Open;
  pSetaClient(cdsMovMen);

  FGravando := TGravandoObs.Create;
  FSubject_ := TSubject.Create;
  FSubject_.pAddObserver(FGravando);
  SetLength(strParam_, 4);

  strParam_[0] := 'TcxProgressBar';
  strParam_[1] := IntToStr(cdsMovMen.RecordCount); //IntToStr(dbgMovMenDBTableView1.DataController.GetSelectedCount);
  strParam_[2] := 'Carregando Registros...';
  FSubject_.pNotify(strParam_);

  If (cdsMovMen.IsEmpty) And (Not fEmptyStr(fTiraCaracEspeciais(mskMesBas.Text))) Then
  Begin
    fMensagem('ATENÇÃO!','É necessário cadastrar os Funcionários antes de abrir o Movimento Mensal!',['&O k']);
    Exit;
  End;

  If Not blnZerado then
  begin
    If dbgMovMenDBBandedTableView.Bands.Count > 0 Then
      dbgMovMenDBBandedTableView.Bands.Clear;

    dbgMovMenDBBandedTableView.Bands.Add.Caption  := 'FUNCIONÁRIO';
    dbgMovMenDBBandedTableView.Bands.Add.Caption  := 'VERBAS';
    dbgMovMenDBBandedTableView.Bands[0].FixedKind := fkLeft;
    dbgMovMenDBBandedTableView.Bands[0].Options.HoldOwnColumnsOnly := True;
  end;

  With cdsMovMen Do
  Begin
    DisableControls;
    Open;

    First;
    strMesBas := '01/' + mskMesBas.Text;

    {******************************************************}
    {* INSERE MASCARA EM SALÁRIO BASE E LIQUIDO A RECEBER *}
    {***************************************************PZ*}
    strNomCam := Fields.Fields[2].FieldName;
    TFloatField(cdsMovMen.FieldByName(strNomCam)).DisplayFormat := '#,##0.00';
    intQtdCol := cdsMovMen.FieldCount;
    strNomCam := Fields.Fields[intQtdCol-5].FieldName;
    TFloatField(cdsMovMen.FieldByName(strNomCam)).DisplayFormat := '#,##0.00';

    intQtdReg := 0;
    While Not Eof Do
    Begin
      If (intQtdReg < cdsMovMen.RecordCount) Then
      Begin
        {*****************************************}
        {* PERCORRE SOMENTE AS COLUNAS DE VERBAS *}
        {**************************************PZ*}
        strAutCtp := '';
        For intIndCol := 2 To intQtdCol -5 Do
        Begin
          Edit;

          {****************************************}
          {* PEGA OS CÓDIGOS CHAVES PARA CONSULTA *}
          {*************************************PZ*}
          strCodVer := LeftStr(Fields.Fields[intIndCol].FieldName,3);
          strNomCam := Fields.Fields[intIndCol].FieldName;

          LAutoIncremFuncionario := cdsMovMen.FieldByName('AUTFUN').AsString;

          {*****************************}
          {* COLOCA MASCARA NOS CAMPOS *}
          {**************************PZ*}
          TFloatField(cdsMovMen.FieldByName(strNomCam)).DisplayFormat := '#,##0.00';

          FieldByName(strNomCam).ReadOnly := False;

          {****************************************************}
          {* VERIFICA SE A COLUNA JÁ POSSUI VALORES GRAVADOS, *}
          {* CASO CONTRÁRIO ATRIBUI ZERO.                     *}
          {*************************************************PZ*}
          If (Not blnZerado) And (objCtrPag.fVerificaLancamento(LAutoIncremFuncionario, strCodVer, edtTipMov.Text, edtCodEmp.Text, strToDate(strMesBas), fltValLan, strAutCtp)) Then
          Begin
            FieldByName(strNomCam).AsFloat := IIF(fltValLan < 0, (-1) * fltValLan, fltValLan);
          End
          Else
          Begin
            {****************************************}
            {* SE FOR UMA PLANILHA NOVA IRÁ PEGAR O *}
            {* SALARIO BASE DO CADASTRO DO FUNC.    *}
            {*************************************PZ*}
            If (Not blnZerado) And (strCodVer = '001') And objCtrPag.fEhPlanilhaNova(LAutoIncremFuncionario,edtTipMov.Text, edtCodEmp.Text, strToDate(strMesBas)) Then
              FieldByName(strNomCam).AsFloat := objCadFun.fRetornaSalarioBasePeloAutoIncrem(LAutoIncremFuncionario)
            Else
              FieldByName(strNomCam).AsFloat := 0.00;

            If Not fEmptyStr(FCodVerbaDebito) And (edtTipMov.Text = 'P') Then
            Begin
               If FCodVerbaDebito = strCodVer Then
                FieldByName(strNomCam).AsFloat := objCtrPag.fRetValorLiquidoAntecipacaoFuncionario(LAutoIncremFuncionario, StrToDate(strMesBas), edtCodEmp.Text);
            End;
          End;

          Post;
        End;
      End;

      If (strAutCtp <> '') and (not assigned(frmHerdarMesBase)) Then
      Begin
        strDupCtp := '';
        blnBaixad := False;

        pRetornaStatusCTP(strAutCtp, strDupCtp, blnBaixad, strHist01);

        If strDupCtp <> '' Then
        Begin
          Edit;
          FieldByName('CTAPAG').AsString := strDupCtp;
          FieldByName('STATUS').AsString := iif(blnBaixad, 'BAIXADO', 'ABERTO');
          FieldByName('HISTORICO').AsString := strHist01;
          Post;
        End;
      End;

      Inc(intQtdReg);
	    strParam_[3] := IntToStr(cdsMovMen.RecNo);
      FSubject_.pNotify(strParam_);
      Next;
    End;

    dbgMovMenDBBandedTableView.BeginUpdate;
    dbgMovMenDBBandedTableView.ClearItems;
    dbgMovMenDBBandedTableView.DataController.CreateAllItems;

    For intIndCol := 0 To dbgMovMenDBBandedTableView.ColumnCount -5 Do
    Begin
      If intIndCol = 0 Then
      Begin
        dbgMovMenDBBandedTableView.Columns[intIndCol].Caption            := 'CÓDIGO';
        dbgMovMenDBBandedTableView.Columns[intIndCol].Width              := 60;
        dbgMovMenDBBandedTableView.Columns[intIndCol].Options.Editing    := False;
		    dbgMovMenDBBandedTableView.Columns[intIndCol].Position.BandIndex := 0;
      End
      Else If intIndCol = 1 Then
      Begin
        dbgMovMenDBBandedTableView.Columns[intIndCol].Caption            := 'NOME';
        dbgMovMenDBBandedTableView.Columns[intIndCol].Options.Editing    := False;
		    dbgMovMenDBBandedTableView.Columns[intIndCol].Position.BandIndex := 0;
      End
      Else If intIndCol = 2 Then
      Begin
        dbgMovMenDBBandedTableView.Columns[intIndCol].Caption              := 'SALÁRIO BASE';
        dbgMovMenDBBandedTableView.Columns[intIndCol].Width                := 120;
        dbgMovMenDBBandedTableView.Columns[intIndCol].PropertiesClass      := TcxCurrencyEditProperties;
        dbgMovMenDBBandedTableView.Columns[intIndCol].OnGetDisplayText     := OnGetDisplayText;
        dbgMovMenDBBandedTableView.Columns[intIndCol].Summary.Footerkind   := skSum;
        dbgMovMenDBBandedTableView.Columns[intIndCol].Summary.FooterFormat := 'R$ ###,###,##0.00';
        dbgMovMenDBBandedTableView.Columns[intIndCol].Position.BandIndex   := 1;
      End
      Else
      Begin
        dbgMovMenDBBandedTableView.Columns[intIndCol].Width                := 120;
        dbgMovMenDBBandedTableView.Columns[intIndCol].PropertiesClass      := TcxCurrencyEditProperties;
        dbgMovMenDBBandedTableView.Columns[intIndCol].OnGetDisplayText     := OnGetDisplayText;
        dbgMovMenDBBandedTableView.Columns[intIndCol].Summary.Footerkind   := skSum;
        dbgMovMenDBBandedTableView.Columns[intIndCol].Summary.FooterFormat := 'R$ ###,###,##0.00';
	    	dbgMovMenDBBandedTableView.Columns[intIndCol].Position.BandIndex   := 1;
      End;
    End;

    dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 5].Options.Editing    := False;
    dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 5].Caption            := 'LÍQUIDO A RECEBER';
	  dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 5].Position.BandIndex := 1;
    dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 4].Caption            := 'DUPLICATA CTP';
    dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 4].Width              := 180;
    dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 4].Options.Editing    := False;
	  dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 4].Position.BandIndex := 1;
    dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 3].Caption            := 'STATUS';
    dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 3].Options.Editing    := False;
    dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 3].Width              := 70;
   	dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 3].Position.BandIndex := 1;
    dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 2].Caption            := 'HISTÓRICO';
    dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 2].Options.Editing    := False;
    dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 2].Width              := 600;
	  dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 2].Position.BandIndex := 1;
    dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 1].Caption            := 'AUTFUN';
    dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 1].Options.Editing    := False;
    dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 1].Visible            := False;
	  dbgMovMenDBBandedTableView.Columns[dbgMovMenDBBandedTableView.ColumnCount - 1].Position.BandIndex := 1;
    dbgMovMenDBBandedTableView.EndUpdate;

    First;
    EnableControls;
  End;

//  cdsMovMen.First;

  FreeAndNil(stlNomCam);
end;

procedure TfrmDigMovimentoMensal.pConcluiBusca;
begin
  If (Not fEmptyStr(frmDigMensalFPBusca.strValorFiltro)) Then
  Begin
    cdsMovMen.Filter := '';
    strValorFiltro := frmDigMensalFPBusca.strValorFiltro;
    strCampoFiltro := frmDigMensalFPBusca.strCampoFiltro;
    If Not cdsMovMen.FindFirst Then
      fMensagem('ATENÇÃO!', 'Não há funcionários para esse filtro!', ['&O k']);
  End;

end;

procedure TfrmDigMovimentoMensal.pCriaTemporaria(var strCodCta,
  strCodPor: String);
Var
  strSQL   : String;
  qryCadFun: TUniQuery;
begin
  Try
    qryCadFun := fCriaQuery(Self);

    strSQL := 'SELECT ';
    strSQL := strSQL + 'FUN_CODCTA AS CODCTA, ';
    strSQL := strSQL + 'FUN_CODPOR AS CODPOR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + 'CADFUN ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + 'AUTOINCREM = :AUTFUN';

    With qryCadFun Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTFUN').AsString := cdsMovMen.FieldByName('AUTFUN').AsString;
      Open;
      If RecordCount > 0 Then
      Begin
        strCodCta := FieldByName('CODCTA').AsString;
        strCodPor := FieldByName('CODPOR').AsString;
      End;
      Application.ProcessMessages;
      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  Application.ProcessMessages;
  FreeAndNil(qryCadFun);
end;

procedure TfrmDigMovimentoMensal.FormCreate(Sender: TObject);
begin
  inherited;
  objCadFun := TCadFun.Create(Self);
  objCadVer := TCadVer.Create(Self);
  objCtrPag := TCtrPag.Create(Self);
  objLiberacao := TLiberacao.Create;
  btnHerdarMesBase.Enabled  := fVerificaAcessoSistema('FPHERDARMESBASE', strLoginUsuarioLogado);
  FCodVerbaDebito := fCfgSis('PAGVER');
end;

procedure TfrmDigMovimentoMensal.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  If Assigned(cdsMovMen) Then
    FreeAndNil(cdsMovMen);
  inherited;
end;

procedure TfrmDigMovimentoMensal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If (edtCodEmp.Focused) Then
  Begin
    inherited;
    FreeAndNil(objCadFun);
    FreeAndNil(objCadVer);
    FreeAndNil(objCtrPag);
  End;
end;

procedure TfrmDigMovimentoMensal.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(TCadFun.CriaNovosRegistrosDeFuncoes, 'Aguarde... Atualizando registros de versões  anteriores.', '');
  If TCadFun.ExistemFuncoesCadastradasNaFormaAntiga Then
    TfrmGravando.fExecutarModal(TCadFun.CorrigeCadastroDeFuncoes, 'Aguarde... Atualizando registros de versões anteriores.', '');

  objCadVer.fGravaVerbaSalBase;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;
  mskMesBas.Clear;
  edtTipMov.Clear;
  //pCarregaGrid(True);
  pHabilita(False);
  pSetFocus(edtCodEmp);
end;

function TfrmDigMovimentoMensal.fRelacionaArquivo(strArqInc: String): Boolean;
var
  qryAuxSQL: TUniQuery;
  fltValVer,
  fltValLan: Double;
  strMesBas,
  strCreDeb,
  strNomFun,
  strAutCtp: String;
  blnGrava_: Boolean;
  LTotalGeralSalarioBase: Double;
  LFuncionario: String;
begin
  Result := False;
  LTotalGeralSalarioBase := 0;
  If  strArqInc <> '' Then
  Begin
    try
      strMesBas := '01/' + mskMesBas.Text;
      qryAuxSQL := fCriaQuery;
      With qryAuxSQL Do
      Begin
        Sql.Clear;
        Sql.Text := ' SELECT  ' +
                    '   F.FUN_CODFUN, F.AUTOINCREM AS AUTFUN, V.VER_CODVER, V.VER_SALBAS, T.* ' +
                    ' FROM ' +
                    '   DETTES T ' +
                    ' LEFT JOIN CADVER V                                                         '+
                    '    ON IFNULL(V.VER_CODTES, "") <> ""                                       '+
                    '    AND TRIM(LEADING 0 FROM V.VER_CODTES) = TRIM(LEADING 0 FROM TES_CODVER) '+
                    ' LEFT JOIN  ' +
                    '   CADFUN F ON F.FUN_CODTES = T.TES_CODFUN AND ' +
                    '        IFNULL(F.FUN_DIGTES, "") = T.TES_DIGITO AND ' +
                    '   LPAD(RIGHT(F.FUN_EMPTES,3),3,"0") = T.TES_CODEMP ' +
                    ' WHERE T.TES_ARQINC = :ARQINC  '+
                    'ORDER BY F.AUTOINCREM ';

        ParamByName('ARQINC').AsString := strArqInc;

        Open;
        If RecordCount > 0 Then
        Begin
          While Not Eof Do
          Begin
            blnGrava_ := True;

            If LFuncionario <> FieldByName('AUTFUN').AsString  Then
              LTotalGeralSalarioBase := 0;

            LFuncionario :=  FieldByName('AUTFUN').AsString;

            strNomFun := FieldByName('TES_CODFUN').AsString + ' - ' + FieldByName('TES_DIGITO').AsString + ': ' + FieldByName('TES_NOMFUN').AsString;

            If FieldByName('FUN_CODFUN').IsNull Then
            Begin
              If (Not cdsErros.Locate('DESCRICAO', '01 - Código do funcionário não relacionado', [])) Or
                 (Not cdsErros.Locate('NOMFUN', strNomFun, [])) Then
              Begin
                cdsErros.Append;
                cdsErrosNOMFUN.AsString    := strNomFun;
                cdsErrosDESCRICAO.AsString := '01 - Código do funcionário não relacionado';
                cdsErros.Post;
              End;

              blnGrava_ := False;
            End;

            If FieldByName('VER_CODVER').IsNull Then
            Begin
              If (Not cdsErros.Locate('DESCRICAO', '02 - Verba Não Relacionada', [])) Or
                 (Not cdsErros.Locate('NOMFUN', FieldByName('TES_CODVER').AsString + ' - ' + FieldByName('TES_DESVER').AsString, [])) Then
              Begin
                cdsErros.Append;
                cdsErrosNOMFUN.AsString    := FieldByName('TES_CODVER').AsString + ' - ' + FieldByName('TES_DESVER').AsString;
                cdsErrosDESCRICAO.AsString := '02 - Verba Não Relacionada';
                cdsErros.Post;
              End;

              blnGrava_ := False;
            End;

            If Not blnGrava_ Then
            Begin

              Next;
              Continue;
            End;

            strAutCtp := '';
            fltValVer := 0;
            if objCtrPag.fVerificaLancamento(FieldByName('AUTFUN').AsString,
                                             IIF(FieldByName('VER_SALBAS').AsString = 'S', '001', FieldByName('VER_CODVER').AsString),
                                             edtTipMov.Text,
                                             edtCodEmp.Text,
                                             strToDate(strMesBas),
                                             fltValVer,
                                             strAutCtp) then
            begin
              If strAutCtp <> '' Then
              Begin
                Next;
                Continue;
              end;
            End;

            If FieldByName('VER_SALBAS').AsString = 'S' Then
            Begin
              LTotalGeralSalarioBase := LTotalGeralSalarioBase + FieldByName('TES_VALLAN').AsFloat;
              fltValLan := LTotalGeralSalarioBase;
            End
            Else
              fltValLan := FieldByName('TES_VALLAN').AsFloat;

            If fltValLan <> 0 Then
            Begin
              If fltValLan > 0 Then
              Begin
                fltValVer := fltValLan;
                strCreDeb := 'C';
              End
              Else
              Begin
                fltValVer := (fltValLan * (-1));
                strCreDeb := 'D';
              End;

              objCtrPag.fGravaLancamentos(FieldByName('FUN_CODFUN').AsString,
                                          edtCodEmp.Text,
                                          IIF(FieldByName('VER_SALBAS').AsString = 'S', '001', FieldByName('VER_CODVER').AsString),
                                          strCreDeb,
                                          edtTipMov.Text,
                                          fltValVer,
                                          strToDate(strMesBas),
                                          FieldByName('AUTFUN').AsString);
              Result := True;
            End;

            Next;
          End;
        End;

        Close;
      End;

      FreeAndNil(qryAuxSQL);
    Except
      On E : Exception Do
      Begin
        Raise Exception.Create('Ocorreu um erro ao efetuar o relacionamento: ' + E.Message);
      End;
    End;
  End;
end;

function TfrmDigMovimentoMensal.fTravaGeraPagar(strCodEmp, strCompet: String;
  dteDtaVen: TDateTime): Boolean;
var
  i,
  ARowIndex,
  ARecordIndex: Integer;
  fltTotGer : Double;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
  LNomeFuncionario: String;
begin
  inherited;
  objLiberacao.Clear;

  fltTotGer := 0;
  LNomeFuncionario := '';

  objLiberacao.objMsgLibera.pAddSeparador(98);
  objLiberacao.objMsgLibera.pAddTexto('GERAÇÃO DO CONTAS A PAGAR - FOLHA DE PAGAMENTO', alCentro, teAmbos, '', 98);
  objTabela := TRegistroMsgLiberaTabela.Create;

  For i := 0 To dbgMovMenDBBandedTableView.DataController.GetSelectedCount - 1 Do
  Begin
    ARowIndex    := dbgMovMenDBBandedTableView.DataController.GetSelectedRowIndex(i);
    ARecordIndex := dbgMovMenDBBandedTableView.Controller.SelectedRecords[i].RecordIndex;

    If dbgMovMenDBBandedTableView.DataController.GetRowInfo(ARowIndex).Level = dbgMovMenDBBandedTableView.DataController.Groups.GroupingItemCount Then
      ARecordIndex     := dbgMovMenDBBandedTableView.DataController.GetRowInfo(ARowIndex).RecordIndex;

    if (dbgMovMenDBBandedTableView.DataController.GetSelectedCount = 1)  and (dbgMovMenDBBandedTableView.DataController.Values[ARecordIndex, cdsMovMen.FieldCount-3] <> '')  then
    begin
      fMensagem('Aviso', 'Já foi gerado contas a pagar para o registro selecionado!', ['&O k']);
      Result := True;
      FreeAndNil(objTabela);
      exit;
    end;

    if dbgMovMenDBBandedTableView.DataController.Values[ARecordIndex, cdsMovMen.FieldCount-3] <> '' Then
      Continue;

    fltTotGer := fltTotGer + dbgMovMenDBBandedTableView.DataController.Values[ARecordIndex, cdsMovMen.FieldCount-5];

    if  objTabela.isEmpty then
    begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'EMPRESA'           , 7  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'FUNCIONÁRIO'       , 31 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'VENCIMENTO'        , 12 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'COMPETÊNCIA'       , 12 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'LÍQUIDO A RECEBER' , 25 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);
    end;

    LNomeFuncionario  := dbgMovMenDBBandedTableView.DataController.Values[ARecordIndex, 0] + ' - ' +
                         dbgMovMenDBBandedTableView.DataController.Values[ARecordIndex, 1];

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('EMPRESA'           , strCodEmp                                                                                                      , 7  , alCentro  );
    objLinha.pAddColuna('FUNCIONÁRIO'       , LNomeFuncionario                                                                                               , 31 , alEsquerda);
    objLinha.pAddColuna('VENCIMENTO'        , DateToStr(dteDtaVen)                                                                                           , 12 , alCentro  );
    objLinha.pAddColuna('COMPETÊNCIA'       , strCompet                                                                                                      , 12 , alCentro  );
    objLinha.pAddColuna('LÍQUIDO A RECEBER' , FloatToStrF(dbgMovMenDBBandedTableView.DataController.Values[ARecordIndex, cdsMovMen.FieldCount-5], ffFixed, 11, 2) , 25 , alDireita );
    objTabela.lstLinhas.Add(objLinha);
  End;

  If objTabela.isEmpty Then
  begin
    FreeAndNil(objTabela);
    fMensagem('Aviso', 'Não foram encontrados lançamentos marcados para gerar contas a pagar!', ['&O k']);
    Result := True;
  end
  else
  Begin

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlTotal;
    objLinha.pAddColuna(''                  , 'TOTAL'                                , 68  , alDireita, teAutcom);
    objLinha.pAddColuna('LÍQUIDO A RECEBER' , FloatToStrF(fltTotGer, ffFixed, 11, 2) , 25  , alDireita );
    objTabela.lstLinhas.Add(objLinha);

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'FPGERAPAGAR';
    objLiberacao.strMsgSen := 'Gerar Contas a Pagar - Folha de Pagamento';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := Not objLiberacao.fLibera;

  End;
end;

function TfrmDigMovimentoMensal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    {*****************************}
    {* VALIDA MES/ANO REFERENCIA *}
    {**************************PZ*}
    If (Sender = edtCodEmp) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O código da empresa deve ser preenchido!',['&O k']);
        Result := False;
      End
    End

    Else If (Sender = mskMesBas) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskMesBas.Text))) Then
      Begin
        fMensagem('ATENÇÃO!','O Mês Base deve ser preenchido!',['&O k']);
        Result := False;
      End
      Else If (StrToInt(LeftStr(mskMesBas.Text,2)) > 12) Or
              (StrToInt(LeftStr(mskMesBas.Text,2)) = 0) Then
      Begin
        fMensagem('ATENÇÃO!','O mês base é inválido!',['&O k']);
        Result := False;
      End;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmDigMovimentoMensal.fVerificaCTPBaixado: Boolean;
var
  intRecNo_: Integer;
begin
  Result := False;

  If Not cdsMovMen.IsEmpty Then
  Begin
    cdsMovMen.DisableControls;
    intRecNo_ := cdsMovMen.RecNo;

    If cdsMovMen.Locate('STATUS', 'BAIXADO', []) Then
    Begin
      fMensagem('Aviso', 'Existem documentos baixados do contas a pagar, para excluir o mês base é necessário estornar esses documentos!', ['&O K']);
      Result := True;
    End;

    cdsMovMen.RecNo := intRecNo_;
    cdsMovMen.EnableControls;
  End;
end;

function TfrmDigMovimentoMensal.fVerificaCTPEnviado: Boolean;
var
  intRecNo_: Integer;
  qryConsul: TUniQuery;
  strNumDup: String;
  arrChave_: TArray<String>;
begin
  Result    := False;
  strNumDup := '';

  If Not cdsMovMen.IsEmpty Then
  Begin
    cdsMovMen.DisableControls;
    intRecNo_ := cdsMovMen.RecNo;
    cdsMovMen.First;

    While Not cdsMovMen.Eof Do
    Begin
      If cdsMovMen.FieldByName('STATUS').AsString = 'ABERTO' Then
      Begin
        qryConsul := fCriaQuery;

        With qryConsul Do
        Begin
          Sql.Clear;
          Sql.Text := ' SELECT  ' +
                      '   CTP_DTAENV, CTP_BCOENV ' +
                      ' FROM ' +
                      '   CADPAG ' +
                      ' WHERE    ' +
                      '   CTP_NUMDUP = :NUMDUP AND ' +
                      '   CTP_PARCEL = :PARCEL AND ' +
                      '   CTP_CODEMP = :CODEMP AND ' +
                      '   CTP_SERIE_ = :SERIE_ AND ' +
                      '   CTP_CODFOR = :CODFOR ';

          arrChave_ := cdsMovMen.FieldByName('CTAPAG').AsString.Split(['-']);

          ParamByName('NUMDUP').AsString := arrChave_[0];
          ParamByName('PARCEL').AsString := arrChave_[1];
          ParamByName('CODEMP').AsString := arrChave_[2];
          ParamByName('SERIE_').AsString := arrChave_[3];
          ParamByName('CODFOR').AsString := arrChave_[4];

          Open;

          If Not IsEmpty Then
          Begin
            If (FieldByName('CTP_DTAENV').Value <> Null) Or
               (FieldByName('CTP_BCOENV').AsString <> '') Then
            Begin
              strNumDup := strNumDup + '/' + cdsMovMen.FieldByName('CTAPAG').AsString;
            End;
          End;

          Close;
        End;

        FreeAndNil(qryConsul);
      End;

      cdsMovMen.Next;
    End;

    If strNumDup <> '' Then
    Begin
      Result := True;
      fMensagem('Aviso', 'Existem duplicatas com informação de envio ao banco para pagamento. Para excluir o mês base é necessário cancelar o envio dessas duplicatas!', ['&O K']);
    End;

    cdsMovMen.RecNo := intRecNo_;
    cdsMovMen.EnableControls;
  End;
end;

function TfrmDigMovimentoMensal.fVerificaDadosGerPag(
  AAutoIncremFuncionario: String): Boolean;
var
  qryCons: TUniQuery;
begin
  Result := True;
  If AAutoIncremFuncionario <> '' Then
  Begin
    qryCons := fCriaQuery;
    With qryCons Do
    Begin
      Sql.Clear;
      Sql.Text :=  ' SELECT  ' +
                      '   *     ' +
                      ' FROM    ' +
                      '   CADFUN ' +
                      ' JOIN CADFOR ON FOR_CODFOR = FUN_CODFOR '+
                      ' WHERE CADFUN.AUTOINCREM=:AUTFUN';

      ParamByName('AUTFUN').AsString := AAutoIncremFuncionario;

      Open;

      If fEmptyStr(qryCons.FieldByName('FUN_CODFOR').AsString) Then
        Result := False;

      Close;
    End;
    FreeAndNil(qryCons);
  End;
end;

function TfrmDigMovimentoMensal.fVerificaMovimento: Boolean;
var
  qryAuxil_: TUniQuery;
  strMesBas: String;
begin
  qryAuxil_ := fCriaQuery;
  Result    := True;

  With qryAuxil_ Do
  Begin
    Sql.Clear;
    Sql.Text := ' SELECT   ' +
                '   *      ' +
                ' FROM     ' +
                '   CTRPAG ' +
                ' WHERE    ' +
                '   PAG_CODEMP = :CODEMP AND ' +
                '   PAG_MESBAS = :MESBAS AND ' +
                '   PAG_TIPMOV = :TIPMOV ';

    strMesBas := fTiraCaracEspeciais(mskMesBas.Text);
    ParamByName('CODEMP').AsString := edtCodEmp.Text;
    ParamByName('MESBAS').AsString := Copy(strMesBas, 3, 4)+ Copy(strMesBas, 1, 2) + '01';
    ParamByName('TIPMOV').AsString := edtTipMov.Text;

    Open;

    If Not IsEmpty Then
    Begin
      If fMensagem('ATENÇÃO!','Já existem lançamentos para o movimento "' + mskMesBas.Text + '". Deseja atualizar os lançamentos?' , ['&S i m', '&N ã o']) =  1 Then
      Begin
        Result := True;
        FreeAndNil(qryAuxil_);
        Exit;
      End
      Else
      Begin
        Result := False;
        FreeAndNil(qryAuxil_);
        Exit;
      End;
    End;

    Close;

    Sql.Clear;
    Sql.Text := ' SELECT   ' +
                '   *      ' +
                ' FROM     ' +
                '   CTRPAG ' +
                ' WHERE    ' +
                '   PAG_CODEMP =  :CODEMP AND ' +
                '   PAG_MESBAS =  :MESBAS AND ' +
                '   PAG_TIPMOV <> :TIPMOV ';

    strMesBas := fTiraCaracEspeciais(mskMesBas.Text);
    ParamByName('CODEMP').AsString := edtCodEmp.Text;
    ParamByName('MESBAS').AsString := Copy(strMesBas, 3, 4)+ Copy(strMesBas, 1, 2) + '01';
    ParamByName('TIPMOV').AsString := edtTipMov.Text;

    Open;

    If Not IsEmpty Then
    Begin
      If fMensagem('ATENÇÃO!','Já existem lançamentos para o movimento "' + mskMesBas.Text + '". Deseja lançar novo movimento?' , ['&S i m', '&N ã o']) =  1 Then
      Begin
        Result := True;
        FreeAndNil(qryAuxil_);
        Exit;
      End
      Else
      Begin
        Result := False;
        FreeAndNil(qryAuxil_);
        Exit;
      End;
    End;
  End;
  FreeAndNil(qryAuxil_);
end;

function TfrmDigMovimentoMensal.fVerificaSeTemValorLiquidoReceber: Boolean;
Var
  intQtdCol: Integer;
  intIndCol: Integer;
  fltLiqRec: Double;
begin
  inherited;
  fltLiqRec := 0.0;
  Result    := False;

  intQtdCol := cdsMovMen.FieldCount;

  {*************************************************************}
  {* PERCORRE AS COLUNAS QUE IRÃO CALCULAR O LIQUIDO A RECEBER *}
  {**********************************************************PZ*}
  For intIndCol := 2 To intQtdCol - 6 Do
  Begin
    {***********************************************}
    {* VERIFICA SE A COLUNA É DE CRÉDITO OU DÉBITO *}
    {********************************************PZ*}
    If (Copy(cdsMovMen.Fields.Fields[intIndCol].FieldName,5,1) = 'C') Then
      fltLiqRec := fltLiqRec + cdsMovMen.Fields.Fields[intIndCol].AsFloat
    Else
      fltLiqRec := fltLiqRec - cdsMovMen.Fields.Fields[intIndCol].AsFloat;
  End;

  If Not (fltLiqRec <= 0.0) Then
    Result := True;
end;

function TfrmDigMovimentoMensal.fRatearDuplicata(strCodCta: String): Boolean;
begin
  Result := False;

  if TCtaDet.fContaPossuiRateios(strCodCta) then
  begin
    Result := fCfgSis('DESPFU', varBoolean);
    If Not Result Then
      Result := fMensagem('ATENÇÃO!', 'Deseja ativar o rateio?', ['&Sim', '&Não']) = 1;
  end;
end;

procedure TfrmDigMovimentoMensal.btnCarregarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  pCarregaGrid(False,True);
  pHabilita(True);
  pSetFocusGrid;
end;

procedure TfrmDigMovimentoMensal.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (fGravaLancamentos) Then
  Begin
    mskMesBas.Clear;
    edtTipMov.Clear;
    pCarregaGrid(True);
    pHabilita(False);
    dbgMovMen.Refresh;
  End;
end;

procedure TfrmDigMovimentoMensal.btnDesmarcarTodasClick(Sender: TObject);
Var
  i: Integer;
Begin
  inherited;
  If dbgMovMenDBBandedTableView.DataController.GetSelectedCount > 0 Then
  Begin
    With dbgMovMenDBBandedTableView Do
    Begin
      BeginUpdate();
      Controller.ClearSelection;

      For I := 0 To ViewData.RecordCount - 1 Do
        ViewData.Records[I].Selected := False;

      EndUpdate();
    End;
    pSetFocus(dbgMovMen);
  End
  Else
    fMensagem('Aviso', 'Não existem lançamentos para desmarcar!', ['&O k']);
End;

function TfrmDigMovimentoMensal.fGeraContasPagar(strCodEmp, strCompet, strHist01, aStrCodCta,
      aStrCodPor: String; dteDtaVen: TDateTime): Boolean;
var
  intCount_,
  intRowIdx,
  intRecIdx: Integer;
  ADupPagar: TCadPag;
  ARepForn_: TCadForRepository;
  ARepPagar: TCadPagRepository;
  qryAuxil_,
  qrySqlEx_: TUniQuery;
  cdsRateio: TUniClientDataSet;
  blnRatear: Boolean;
  FGravando: IObserver_;
  FSubject_: ISubject_;
  strParam_: Array of String;
  oParametros: TParametrosDesmembraValoresCtaDet;
  fltTotal: Double;
  strCodFor,
  strCodCta,
  strCodPor,
  strCodEve: String;
  LDesmembramentoPgtoFuncionarios : TDesmembramentoPgtoFuncionarios;
begin
  LDesmembramentoPgtoFuncionarios := TDesmembramentoPgtoFuncionarios.Create(cdsMovMen, strCodEmp);
  intRecIdx:=0;
  blnRatear   := False;
  ARepPagar   := TCadPagRepository.Create;
  ARepForn_   := TCadForRepository.Create;

  FGravando := TGravandoObs.Create;
  FSubject_ := TSubject.Create;
  FSubject_.pAddObserver(FGravando);
  SetLength(strParam_, 4);

  strParam_[0] := 'TcxProgressBar';
  strParam_[1] := IntToStr(dbgMovMenDBBandedTableView.DataController.GetSelectedCount);
  strParam_[2] := 'Gerando Contas a Pagar...';
  FSubject_.pNotify(strParam_);

  If fCfgSis('FUNCPG') = 'A' Then
  Begin
    blnRatear := fRatearDuplicata(aStrCodCta);
  End
  Else If fCfgSis('FUNCPG') = 'S' Then
  Begin
    strCodFor := fCfgSis('FUNFOR');
    strCodCta := fCfgSis('FUNCTA');
    strCodPor := fCfgSis('FUNPOR');
    strCodEve := fCfgSis('FUNEVE');

    If fEmptyStr(strCodFor) Then
    Begin
      fMensagem('ATENÇÃO', 'Fornecedor não preenchido. Por favor, verifique a Configuração CFG_FUNFOR!', ['&Ok']);
      fRollBack;
      Exit(False);
    End
    Else If fEmptyStr(fRetNomFornecedor(strCodFor)) Then
    Begin
      fMensagem('ATENÇÃO', 'Fornecedor "'+ strCodFor +'" não encontrado. Por favor, verifique a Configuração CFG_FUNFOR!', ['&Ok']);
      fRollBack;
      Exit(False);
    End;

    If fEmptyStr(strCodCta) Then
    Begin
      fMensagem('ATENÇÃO', 'Plano de Contas não preenchido. Por favor, verifique a Configuração CFG_FUNCTA!', ['&Ok']);
      fRollBack;
      Exit(False);
    End
    Else If fEmptyStr(fRetNomeConta(strCodCta)) Then
    Begin
      fMensagem('ATENÇÃO', 'Plano de Contas "'+ strCodCta +'" não encontrado. Por favor, verifique a Configuração CFG_FUNCTA!', ['&Ok']);
      fRollBack;
      Exit(False);
    End;

    If fEmptyStr(strCodPor) Then
    Begin
      fMensagem('ATENÇÃO', 'Portador não preenchido. Por favor, verifique a Configuração CFG_FUNPOR!', ['&Ok']);
      fRollBack;
      Exit(False);
    End
    Else If fEmptyStr(fRetNomPortador(strCodPor)) Then
    Begin
      fMensagem('ATENÇÃO', 'Portador "'+ strCodPor +'" não encontrado. Por favor, verifique a Configuração CFG_FUNPOR!', ['&Ok']);
      fRollBack;
      Exit(False);
    End;

    If Not fEmptyStr(strCodEve) Then
      If fEmptyStr(fRetNomEvento(strCodEve)) Then
      Begin
        fMensagem('ATENÇÃO', 'Centro de Custos "'+ strCodEve +'" não encontrado. Por favor, verifique a Configuração CFG_FUNEVE!', ['&Ok']);
        fRollBack;
        Exit(False);
      End;

    blnRatear := fRatearDuplicata(strCodCta);
  End;

  fStartTransaction;
  Try
    {*********************************************}
    {* ANALÍTICO: GERA UM TÍTULO POR FUNCIONÁRIO *}
    {*REQ*149867*******************************RP*}
    If fCfgSis('FUNCPG') = 'A' Then
    Begin
      For intCount_ := 0 To dbgMovMenDBBandedTableView.DataController.GetSelectedCount - 1 Do
      Begin
        strParam_[3] := IntToStr(intCount_ +1);
        FSubject_.pNotify(strParam_);

        intRowIdx := dbgMovMenDBBandedTableView.DataController.GetSelectedRowIndex(intCount_);
        intRecIdx := dbgMovMenDBBandedTableView.Controller.SelectedRecords[intCount_].RecordIndex;

        If dbgMovMenDBBandedTableView.DataController.GetRowInfo(intRowIdx).Level = dbgMovMenDBBandedTableView.DataController.Groups.GroupingItemCount Then
          intRecIdx := dbgMovMenDBBandedTableView.DataController.GetRowInfo(intRowIdx).RecordIndex;

        If dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, cdsMovMen.FieldCount-3] <> '' Then
          Continue;


        If Not fVerificaDadosGerPag(dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, cdsMovMen.FieldCount-1]) Then
        Begin
          Raise Exception.Create('AVISO-O funcionário com código ' + Copy(dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, 0], 1, 6) +
                                 ' não possui informações necessárias para gerar o Contas a Pagar!' + #13 +
                                 'Realize o preenchimento das informações na aba "6 - Geração Contas à Pagar" no Cadastro de Funcionários.' + #13 +
                                 'A Operação foi cancelada!');
        End;


        If dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, cdsMovMen.FieldCount-5] > 0 Then
        Begin
          qryAuxil_ := fCriaQuery;
          With qryAuxil_  Do
          Begin
            Sql.Clear;
            Sql.Text := ' SELECT  ' +
                        '   *     ' +
                        ' FROM    ' +
                        '   CADFUN ' +
                        ' WHERE AUTOINCREM = :AUTFUN' ;
            ParamByName('AUTFUN').AsString := dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, cdsMovMen.FieldCount-1];
            Open;

            If Not IsEmpty Then
            Begin
              ADupPagar := TCadPag.Create;
              ADupPagar.strAutInc := fRetAutoIncrem(TUtil.fRetTableName(ADupPagar), strCodEmp);
              ADupPagar.strNumDup := fRetSequencialCadPag;
              ADupPagar.objCodFor := ARepForn_.fRetCadFor(FieldByName('FUN_CODFOR').AsString);
              ADupPagar.strParcel := 'A';
              ADupPagar.strCodEmp := strCodEmp;
              ADupPagar.strEmpGer := strCodEmp;
              ADupPagar.strCompet := strCompet;
              ADupPagar.dtaDtaVen := dteDtaVen;
              ADupPagar.dtaDtaCad := VS_Date;
              ADupPagar.strCodOpe := strLoginUsuarioLogado;
              ADupPagar.strCodVen := strLoginUsuarioLogado;
              ADupPagar.strSerie  := '';
              ADupPagar.strHist01 := 'Ref. Pagto Salarial ' + strHist01;

              // VERIFICA SE TEM PLANO DE CONTAS NO CAD. FUNCIONARIOS, SE TIVER USA O PLANO DE CONTAS DE LÁ,
              // CASO NAO TENHA, TERA SOLICITADO PARA INFORMAR NA TELA DE FRMSELVEN

              If fCfgSis('FCTAIN') = 'S' Then
              Begin
                If Not fEmptyStr(FieldByName('FUN_CODCTA').AsString) Then
                   ADupPagar.strCodCta := FieldByName('FUN_CODCTA').AsString
                Else
                   ADupPagar.strCodCta := aStrCodCta; // Informado na tela;
              End
              Else
              Begin
                If fEmptyStr( aStrCodCta) Then
                   ADupPagar.strCodCta := FieldByName('FUN_CODCTA').AsString
                Else
                   ADupPagar.strCodCta := aStrCodCta; // Informado na tela;
              End;

              ADupPagar.strCodPor := aStrCodPor;
              ADupPagar.strBcoFor := fContaBancariaPagaPagamento(FieldByName('FUN_CODFOR').AsString);

              If Not fEmptyStr(FieldByName('FUN_CODEVE').AsString) then
                ADupPagar.strCodEve := FieldByName('FUN_CODEVE').AsString
              Else
                ADupPagar.strCodEve := SNull;

              ADupPagar.fltValDup   := dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, cdsMovMen.FieldCount-5];
              ADupPagar.fltValOri   := dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, cdsMovMen.FieldCount-5];

              ADupPagar.strVeioBo := 'N';
              ADupPagar.strVeioNF := 'N';
              ADupPagar.strPrevis := 'N';
              ADupPagar.strUsaChq := 'N';
              ADupPagar.strDeposi := IIF((ADupPagar.strBcoFor = SNull),'N','S');
              ADupPagar.strPagAnt := 'N';
              ADupPagar.strUsoCon := 'N';

              Try
                ARepPagar.pGravaCadPag(ADupPagar, 'INCLUSÃO CONTAS A PAGAR - FOLHA DE PAGAMENTO', self.Name);
              Except
                On E: Exception Do
                Begin
                  Raise Exception.Create('Ocorreu o seguinte erro ao gravar o pagamento:' + E.Message);
                  Break;
                End;
              End;

              If LDesmembramentoPgtoFuncionarios.LUtilizaRateioPorVerbas Then
              Begin

                If Not fEmptyStr(LDesmembramentoPgtoFuncionarios.VerbaSemPlanoDeContas) Then
                Begin
                  fRollBack;
                  strParam_[0] := 'Esconder';
                  FSubject_.pNotify(strParam_);
                  Finalize(strParam_);
                  Result := False;
                  FreeAndNil(ARepPagar);
                  FreeAndNil(ARepForn_);
                  LDesmembramentoPgtoFuncionarios.CadastrarPlanoDeContaVerbas;
                  Exit;
                End;

                cdsRateio := LDesmembramentoPgtoFuncionarios.CriaClientRateio(dbgMovMenDBBandedTableView,
                                                                                               intRecIdx,
                                                                      FieldByName('FUN_CODEVE').AsString,
                                                                                     ADupPagar.fltValDup);

                If not fGravaFatorCalculado(ADupPagar.strNumDup, ADupPagar.strParcel, ADupPagar.strCodEmp, ADupPagar.strCodFor, ADupPagar.strSerie, cdsRateio, Self.Name, True) Then
                Begin
                  //cdsMovMen.First;
                  Raise Exception.Create('Ocorreu um erro ao gravar o desmembramento do pagamento ao funcionário: ' + #13 + dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, 0]);
                  Break;
                End;

              End
              Else If blnRatear Then
              Begin
                If Assigned(cdsRateio) Then
                  FreeAndNil(cdsRateio);

                pCriaClientTemporariaCtpDet('', '', '', '', '', cdsRateio);
                oParametros := TParametrosDesmembraValoresCtaDet.Create;
                try
                  oParametros.strNumCta := aStrCodCta;
                  oParametros.strCodEve := FieldByName('FUN_CODEVE').AsString;
                  oParametros.frmCadPag := Self;
                  oParametros.fltValDup := ADupPagar.fltValDup;
                  oParametros.strCodEmp := edtCodEmp.Text;
                  oParametros.blnDireto := True;

                  if fDesmembraValoresCtaDet(oParametros) then
                  Begin
                    If not fGravaFatorCalculado(ADupPagar.strNumDup, ADupPagar.strParcel, ADupPagar.strCodEmp, ADupPagar.strCodFor, ADupPagar.strSerie, oParametros.cdsTemp, Self.Name, True) Then
                    Begin
                      Raise Exception.Create('Ocorreu um erro ao gravar o desmembramento do pagamento ao funcionário: ' + #13 + dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, 0]);
                      Break;
                    End;

                    cdsRateio.Data := oParametros.cdsTemp.Data;
                  End
                  Else
                  Begin
                    Raise Exception.Create('Ocorreu um erro ao desmembrar o pagamento do funcionário: ' + #13 + dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, 0]);
                    Break;
                  End;
                finally
                  oParametros.Free;
                end;
              End;

              Try
                qrySqlEx_ := fCriaQuery;
                With qrySqlEx_ Do
                Begin
                  Sql.Clear;
                  Sql.Text := ' UPDATE   ' +
                              '   CTRPAG ' +
                              ' SET      ' +
                              '   PAG_AUTCTP = :AUTCTP ' +
                              ' WHERE ' +
                              '   PAG_CODEMP = :CODEMP AND ' +
                              '   PAG_AUTFUN = :AUTFUN AND ' +
                              '   PAG_MESBAS = :MESBAS AND ' +
                              '   PAG_TIPMOV = :TIPMOV ';

                  ParamByName('AUTCTP').AsString := ADupPagar.strAutInc;
                  ParamByName('CODEMP').AsString := edtCodEmp.Text;
                  ParamByName('AUTFUN').AsString := dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, cdsMovMen.FieldCount-1];
                  ParamByName('MESBAS').AsDateTime   := StrToDate('01/'+mskMesBas.Text);
                  ParamByName('TIPMOV').AsString := edtTipMov.Text;

                  ExecSql;
                End;

                FreeAndNil(qrySqlEx_);

                If Assigned(cdsRateio) Then
                  FreeAndNil(cdsRateio);

              Except
                On E: Exception Do
                Begin
                  Raise Exception.Create('Ocorreu o seguinte erro ao gravar o pagamento:' + E.Message);
                  Break;
                End;
              End;
            End //end not IsEmpty
            Else
              Raise Exception.Create('O funcionário com código ' + Copy(dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, 0], 1, 6) +
                                     ' não possui informações necessárias para gerar o Contas a Pagar!' + #13 +
                                     'Realize o preenchimento das informações na aba "5 - Integração Citel" no Cadastro de Funcionários.' + #13 +
                                     'A Operação foi cancelada!');

          End; //end with
        End; //end > 0

      End; //end for
      cdsMovMen.EnableControls;

    End //end analítico

    {******************************************************}
    {* SINTÉTICO: GERA SOMENTE UM TÍTULO, NO VALOR TOTAL  *}
    {*REQ*149867****************************************RP*}
    Else If fCfgSis('FUNCPG') = 'S' Then
    Begin
      fltTotal := 0;

      qrySqlEx_ := fCriaQuery;
      With qrySqlEx_ Do
      Begin
        Sql.Text := ' UPDATE   ' +
                    '   CTRPAG ' +
                    ' SET      ' +
                    '   PAG_AUTCTP = :AUTCTP ' +
                    ' WHERE ' +
                    '   PAG_CODEMP = :CODEMP AND ' +
                    '   PAG_AUTFUN = :AUTFUN AND ' +
                    '   PAG_MESBAS = :MESBAS AND ' +
                    '   PAG_TIPMOV = :TIPMOV ';
      End;

      ADupPagar := TCadPag.Create;
      ADupPagar.strAutInc := fRetAutoIncrem(TUtil.fRetTableName(ADupPagar), strCodEmp);

      For intCount_ := 0 To dbgMovMenDBBandedTableView.DataController.GetSelectedCount - 1 Do
      Begin
        strParam_[3] := IntToStr(intCount_ +1);
        FSubject_.pNotify(strParam_);

        intRowIdx := dbgMovMenDBBandedTableView.DataController.GetSelectedRowIndex(intCount_);
        intRecIdx := dbgMovMenDBBandedTableView.Controller.SelectedRecords[intCount_].RecordIndex;

        If dbgMovMenDBBandedTableView.DataController.GetRowInfo(intRowIdx).Level = dbgMovMenDBBandedTableView.DataController.Groups.GroupingItemCount Then
          intRecIdx := dbgMovMenDBBandedTableView.DataController.GetRowInfo(intRowIdx).RecordIndex;

        If dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, cdsMovMen.FieldCount-3] = '' Then //cpg
          If dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, cdsMovMen.FieldCount-5] > 0 Then //valor
          Begin
            fltTotal := fltTotal + dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, cdsMovMen.FieldCount-5];

            Try
              With qrySqlEx_ Do
              Begin
                //atualiza a tabela CTRPAG para cada funcionário, para manter a rastreabilidade
                Close;
                ParamByName('AUTCTP').AsString   := ADupPagar.strAutInc;
                ParamByName('CODEMP').AsString   := edtCodEmp.Text;
                ParamByName('AUTFUN').AsString   := dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, cdsMovMen.FieldCount-1];
                ParamByName('MESBAS').AsDateTime := StrToDate('01/'+mskMesBas.Text);
                ParamByName('TIPMOV').AsString   := edtTipMov.Text;
                ExecSql;
              End;
            Except
              On E: Exception Do
              Begin
                Raise Exception.Create('Ocorreu o seguinte erro ao gravar o pagamento:' + E.Message);
                Exit(False);
              End;
            End;
          End; //end > 0
      End; //end for

      FreeAndNil(qrySqlEx_);

      ADupPagar.strNumDup := fRetSequencialCadPag;
      ADupPagar.objCodFor := ARepForn_.fRetCadFor(strCodFor);
      ADupPagar.strParcel := 'A';
      ADupPagar.strCodEmp := strCodEmp;
      ADupPagar.strEmpGer := strCodEmp;
      ADupPagar.strCompet := strCompet;
      ADupPagar.dtaDtaVen := dteDtaVen;
      ADupPagar.dtaDtaCad := VS_Date;
      ADupPagar.strCodOpe := strLoginUsuarioLogado;
      ADupPagar.strCodVen := strLoginUsuarioLogado;
      ADupPagar.strSerie  := '';
      ADupPagar.strHist01 := 'Ref. Pagto Salarial ' + strHist01;
      ADupPagar.strCodCta := strCodCta;
      ADupPagar.strCodPor := strCodPor;

      If Not fEmptyStr(strCodEve) then
        ADupPagar.strCodEve := strCodEve
      Else
        ADupPagar.strCodEve := SNull;

      ADupPagar.fltValDup := fltTotal;
      ADupPagar.fltValOri := fltTotal;
      ADupPagar.strVeioBo := 'N';
      ADupPagar.strVeioNF := 'N';
      ADupPagar.strPrevis := 'N';
      ADupPagar.strUsaChq := 'N';
      ADupPagar.strDeposi := 'N';
      ADupPagar.strPagAnt := 'N';
      ADupPagar.strUsoCon := 'N';

      Try
        ARepPagar.pGravaCadPag(ADupPagar, 'INCLUSÃO CONTAS A PAGAR - FOLHA DE PAGAMENTO', self.Name);
      Except
        On E: Exception Do
        Begin
          Raise Exception.Create('Ocorreu o seguinte erro ao gravar o pagamento:' + E.Message);
          Exit(False);
        End;
      End;

      If LDesmembramentoPgtoFuncionarios.LUtilizaRateioPorVerbas Then
      Begin

        If Not fEmptyStr(LDesmembramentoPgtoFuncionarios.VerbaSemPlanoDeContas) Then
        Begin
          fRollBack;
          strParam_[0] := 'Esconder';
          FSubject_.pNotify(strParam_);
          Finalize(strParam_);
          Result := False;
          FreeAndNil(ARepPagar);
          FreeAndNil(ARepForn_);
          LDesmembramentoPgtoFuncionarios.CadastrarPlanoDeContaVerbas;
          Exit;
        End;

        cdsRateio := LDesmembramentoPgtoFuncionarios.CriaClientRateio(dbgMovMenDBBandedTableView,
                                                                                       strCodEve,
                                                                                       ADupPagar.fltValDup);

        If not fGravaFatorCalculado(ADupPagar.strNumDup, ADupPagar.strParcel, ADupPagar.strCodEmp, ADupPagar.strCodFor, ADupPagar.strSerie, cdsRateio, Self.Name, True) Then
        Begin
          //cdsMovMen.First;
          Raise Exception.Create('Ocorreu um erro ao gravar o desmembramento do pagamento ao funcionário: ' + #13 + dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, 0]);
        //  Break;
        End;

      End
      Else If blnRatear Then
      Begin
        cdsRateio := TUniClientDataSet.Create(Nil);
        oParametros := TParametrosDesmembraValoresCtaDet.Create;
        try
          oParametros.strNumCta := strCodCta;
          oParametros.strCodEve := strCodEve;
          oParametros.frmCadPag := Self;
          oParametros.fltValDup := ADupPagar.fltValDup;
          oParametros.strCodEmp := edtCodEmp.Text;
          oParametros.blnDireto := True;

          if fDesmembraValoresCtaDet(oParametros) then
          Begin
            If not fGravaFatorCalculado(ADupPagar.strNumDup, ADupPagar.strParcel, ADupPagar.strCodEmp, ADupPagar.strCodFor, ADupPagar.strSerie, oParametros.cdsTemp, Self.Name, True) Then
            Begin
              Raise Exception.Create('Ocorreu um erro ao gravar o desmembramento do pagamento');
              Exit(False);
            End;

            cdsRateio.Data := oParametros.cdsTemp.Data;
          End
          Else
          Begin
            Raise Exception.Create('Ocorreu um erro ao desmembrar o pagamento');
            Exit(False);
          End;
        finally
          oParametros.Free;
          FreeAndNil(cdsRateio);
        end;
      End; //end blnRatear

    End; //end sintético

  Except
    On E: Exception Do
    Begin
      fRollBack;

      strParam_[0] := 'Esconder';
      FSubject_.pNotify(strParam_);
      Finalize(strParam_);

      If Assigned(cdsRateio) Then
        FreeAndNil(cdsRateio);

      If Assigned(LDesmembramentoPgtoFuncionarios) Then
        FreeAndNil(LDesmembramentoPgtoFuncionarios);

      Result := False;

      if E.Message.StartsWith('AVISO-', True) then
      Begin
        fMensagem('AVISO',Copy(E.Message, 7, Length(E.Message)),['&O k']);
        Exit;
      End;

      pMensagensErro(E.Message,'[TfrmDigMovimentoMensal.fGeraContasPagar]');
      Exit;
    End;
  End;

  fCommit;

  strParam_[0] := 'Esconder';
  FSubject_.pNotify(strParam_);
  Finalize(strParam_);
  Result := True;

  FreeAndNil(ARepPagar);
  FreeAndNil(ARepForn_);

  If Assigned(cdsRateio) Then
    FreeAndNil(cdsRateio);

  If Assigned(LDesmembramentoPgtoFuncionarios) Then
    FreeAndNil(LDesmembramentoPgtoFuncionarios);

  cdsMovMen.First;
  fMensagem('Aviso', 'Contas a Pagar Gerado com Sucesso!', ['&O k']);
end;

function TfrmDigMovimentoMensal.fGravaLancamentos(blnSemMensagem:Boolean = False): Boolean;
Var
  intQtdCol: Integer;
  intIndCol: Integer;
  intPosReg: Integer;
  strMesBas: String;
  strCodFun: String;
  strCodVer: String;
  strNomCam: String;
  strDebCre: String;
  blnGravar: Boolean;
  fltValVer: Double;
  strAutCtp: String;

  LAutoIncremFuncionario: String;
begin
  Result := false;

  if cdsMovMen.State in dsEditModes then
    cdsMovMen.Post;

  cdsMovMen.DisableControls;
  try
    try
      cdsMovMen.First;
      blnGravar := True;
      intQtdCol := cdsMovMen.FieldCount;
      strMesBas := '01/' + mskMesBas.Text;
      intPosReg := 0;
      fStartTransaction;

      While Not cdsMovMen.Eof Do
      Begin
        {*****************************************************}
        {* ESSE IF É PARA NÃO GRAVAR OS DADOS DA LINHA TOTAL *}
        {**************************************************PZ*}
        If (intPosReg < cdsMovMen.RecordCount) Then
        Begin
          strCodFun := cdsMovMen.FieldByName('FUN_CODFUN').AsString;

          LAutoIncremFuncionario := cdsMovMen.FieldByName('AUTFUN').AsString;

          {********************************************}
          {* PERCORRE OS CAMPOS QUE IRÃO SER GRAVADOS *}
          {*****************************************PZ*}
          For intIndCol := 2 To intQtdCol - 6 Do
          Begin
            strCodVer := LeftStr(cdsMovMen.Fields.Fields[intindCol].FieldName,3);
            strNomCam := cdsMovMen.Fields.Fields[intIndCol].FieldName;
            strDebCre := Copy(cdsMovMen.Fields.Fields[intindCol].FieldName,5,1);

            If (cdsMovMen.FieldByName(strNomCam).AsFloat > 0) Then
              blnGravar := objCtrPag.fGravaLancamentos(strCodFun,
                                                       edtCodEmp.Text,
                                                       strCodVer,
                                                       strDebCre,
                                                       edtTipMov.Text,
                                                       cdsMovMen.FieldByName(strNomCam).AsFloat,
                                                       strToDate(strMesBas),
                                                       LAutoIncremFuncionario)
            Else
            Begin
              fltValVer := 0;
              strAutCtp := '';
              If objCtrPag.fVerificaLancamento(LAutoIncremFuncionario, strCodVer, edtTipMov.Text, edtCodEmp.Text, strToDate(strMesBas), fltValVer, strAutCtp) Then
              Begin
                If (fltValVer <> 0) And (strAutCtp = '') Then
                   blnGravar := objCtrPag.fApagaLancamento(strCodFun,
                                                           edtCodEmp.Text,
                                                           strCodVer,
                                                           edtTipMov.Text,
                                                           strToDate(strMesBas),
                                                           LAutoIncremFuncionario);
              End;
            End;
          End;
        End;

        Inc(intPosReg);
        cdsMovMen.Next;
      End;

      If (blnGravar) Then
      Begin
        fCommit;
        If Not blnSemMensagem Then
          fMensagem('','Arquivo gravado com Sucesso!',['&O k']);
        Result := True;
      End
      Else
        fRollBack;
    except on E: Exception do
      begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmDigMovimentoMensal.fGravaLancamentos]');
      end;
    end;
  finally
    cdsMovMen.First;
    cdsMovMen.EnableControls;
  end;

end;

procedure TfrmDigMovimentoMensal.pCalculaLiqReceber(blnEditar: Boolean);
Var
  intQtdCol: Integer;
  intIndCol: Integer;
  fltLiqRec: Double;
begin
  inherited;

  fltLiqRec := 0.0;

  With cdsMovMen do
  Begin
    intQtdCol := cdsMovMen.FieldCount;

    {*************************************************************}
    {* PERCORRE AS COLUNAS QUE IRÃO CALCULAR O LIQUIDO A RECEBER *}
    {**********************************************************PZ*}
    For intIndCol := 3 To intQtdCol - 6 Do
    Begin
      {***********************************************}
      {* VERIFICA SE A COLUNA É DE CRÉDITO OU DÉBITO *}
      {********************************************PZ*}
      If (Copy(Fields.Fields[intIndCol].FieldName,5,1) = 'C') Then
        fltLiqRec := fltLiqRec + Fields.Fields[intIndCol].AsFloat
      Else
        fltLiqRec := fltLiqRec - Fields.Fields[intIndCol].AsFloat;
    End;

    If (blnEditar) Then
    Begin
      Edit;
    End;

    Fields.Fields[intQtdCol-6].ReadOnly := False;
    FieldByName('LIQUIDO_RECEBER').AsFloat := Fields.Fields[2].AsFloat + fltLiqRec;

    If (blnEditar) Then
    Begin
      Post;
    End;

  End;
End;

procedure TfrmDigMovimentoMensal.cdsMovMenBeforePost(DataSet: TDataSet);
begin
  inherited;

  pCalculaLiqReceber(False);
end;

procedure TfrmDigMovimentoMensal.dbgMovMenKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  {*******************}
  {* SE TECLAR ENTER *}
  {****************PZ*}
  If (Key = VK_RETURN) Then
  Begin
    If (dbgMovMenDBBandedTableView.Controller.EditingController.Edit <> nil) And
       (cdsMovMen.State = dsEdit) Then
    Begin
      cdsMovMen.Post;
      pCalculaLiqReceber(True);
      pCalculaTotal(True);
    End;
  End
  {******************************************}
  {* SE TECLAR SETA PARA CIMA OU PARA BAIXO *}
  {***************************************PZ*}
  Else If ((Key = 38) Or (Key = 40)) Then
    pCalculaTotal(True);
end;

procedure TfrmDigMovimentoMensal.pCalculaTotal(blnEditar: Boolean);
Var
  intPosReg: Integer;
  intColAtu: Integer;
  intGriAtu: Integer;
  fltTotCol: Double;
  strNomCam: String;
begin
  With cdsMovMen Do
  Begin
    intColAtu := dbgMovMenDBBandedTableView.Controller.FocusedItemIndex;
    strNomCam := Fields.Fields[intColAtu].FieldName;
    fltTotCol := 0;
    intPosReg := 0;
    intGriAtu := RecNo;
    First;
    DisableControls;

    While Not Eof Do
    Begin
      {**********************************************}
      {* CONTROLE PARA NÃO SOMAR A LINHA DOS TOTAIS *}
      {*******************************************PZ*}
      If (intPosReg < RecordCount) Then
        fltTotCol := fltTotCol + FieldByName(strNomCam).AsFloat;

      Inc(intPosReg);
      Next;
    End;

    If (blnEditar) Then
      Edit;

    FieldByName(strNomCam).ReadOnly := False;
    FieldByName(strNomCam).AsFloat  := fltTotCol;

    If (blnEditar) Then
      Post;

    RecNo := intGriAtu;
    EnableControls;
  End;
end;

procedure TfrmDigMovimentoMensal.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If fVerificaCTPBaixado Then
    Exit;

  If fVerificaCTPEnviado Then
    Exit;

  If (fMensagem('ATENÇÃO!','Deseja realmente excluir essa Planilha?',['&SIM','&NÃO'],2,True) = 1) Then
  Begin
    If (fExcluirCadPag) And
       (objCtrPag.fExcluiPlanilha(mskMesBas.Text, edtTipMov.Text, edtCodEmp.Text)) Then
    Begin
      fMensagem('','Planilha excluída com Sucesso!',['&O k']);
      mskMesBas.Clear;
      edtTipMov.Clear;
      pCarregaGrid(True);
      pHabilita(False);
      dbgMovMen.Refresh;
    End;
  End;
end;

procedure TfrmDigMovimentoMensal.btnExcluirMovimentoClick(Sender: TObject);
  Var
    LLancamento: Boolean;

    LDireitos: String;
begin
  inherited;
  If VerificaCTPBaixadoSelecionado Then
    Exit;

  If VerificaCTPEnviadoSelecionado Then
    Exit;

  If VerificaSeOFuncionarioFazParteDaEmpresa Then
    Exit;

  If cdsMovMen.FieldByName('CTAPAG').AsString <> '' Then
  Begin
    If fValidarDirEspecificos(LDireitos, strLoginUsuarioLogado, 'frmCadCtaPagar') Then
    Begin
      if Pos('E', LDireitos) <= 0 Then
      Begin
        fMensagem('Aviso', 'Usuário sem permissão para exclusão do contas a pagar!', ['&O K']);
        Exit;
      End;
    End;
  End;

  If (fMensagem('ATENÇÃO!','Deseja realmente excluir esse movimento?',['&SIM','&NÃO'],2,True) = 2) Then
    Exit;

  fStartTransaction;

  Try
    LLancamento := ExcluirCadPagSelecionado;

    If LLancamento Then
      LLancamento := objCtrPag.ExcluiLancamentoPlanilha(mskMesBas.Text,
                                                        edtTipMov.Text,
                                                        edtCodEmp.Text,
                                                        cdsMovMen.FieldByName('FUN_CODFUN').AsString,
                                                        cdsMovMen.FieldByName('AUTFUN').AsString);

    If LLancamento Then
    Begin
      fCommit;
      pCarregaGrid(False);
      fMensagem('AVISO','Lançamento excluído com sucesso!',['&Ok']);
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmDigMovimentoMensal.btnExcluirMovimentoClick]');
  End;

  pSetFocus(dbgMovMen);
end;

procedure TfrmDigMovimentoMensal.btnExcluirMovimentoMouseEnter(Sender: TObject);
begin
  inherited;
  HintControler.ShowHint(Self.Left + btnExcluirMovimento.Left + 5,
  Self.Top + pnlBotoes.Top + 25, 'Excluir Movimento', 'É possível excluir movimentos de funcionários que não fazem parte ' + #13 +
                                                      'da empresa filtrada ou que não estão ativos no mês selecionado.');
end;

procedure TfrmDigMovimentoMensal.btnExcluirMovimentoMouseLeave(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

function TfrmDigMovimentoMensal.fVerificaSeTemFuncionariosSemPlanoContas: Boolean;
Var
    strAut : String;
    strSQL   : String;
    qryCadFun: TUniQuery;
    intCount_,
    intRecIdx : Integer;
begin
  inherited;
  result := False;

  Try

    For intCount_ := 0 To dbgMovMenDBBandedTableView.DataController.GetSelectedCount - 1 Do
    Begin
        intRecIdx := dbgMovMenDBBandedTableView.Controller.SelectedRecords[intCount_].RecordIndex;
        strAut := strAut + '"' + dbgMovMenDBBandedTableView.DataController.Values[intRecIdx, cdsMovMen.FieldCount-1] + '",';
    End;

    strAut := Copy(strAut, 1, (length(strAut) -1));

    Application.ProcessMessages;
    //  busca funcionarios sem plano de contas;
    Try
      qryCadFun := fCriaQuery(Self);

      strSQL := 'SELECT ';
      strSQL := strSQL + 'FUN_CODCTA ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + 'CADFUN ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + 'AUTOINCREM IN (' + strAut +  ') ';
      strSQL := strSQL + 'AND (IFNULL(FUN_CODCTA, "") = "") ';

      With qryCadFun Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        If Not qryCadFun.IsEmpty Then
           Result := true;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  Finally
    FreeAndNil(qryCadFun);
  End;

end;

procedure TfrmDigMovimentoMensal.btnGerarPagarClick(Sender: TObject);
var
  blnGerPag: Boolean;
  strCodEmp,
  StrCompet,
  strCodCta,
  strCodPor: String;
  dteDtaVen: TDateTime;
  strHistorico: String;
  frmSelVen: TfrmSelVen;
begin
  inherited;
  If Not fEmptyStr(cdsMovMen.Fields.FieldByName('CTAPAG').AsString) Then
    fMensagem('','Já existe contas a pagar para esse funcionário!',['&O k'])
  Else
  Begin

    If dbgMovMenDBBandedTableView.DataController.GetSelectedCount = 0 Then
    Begin
      fMensagem('Aviso',
                'Selecione ao menos um lançamento para gerar o contas a pagar.',
                ['&O k']);
      Exit;
    End;

    If fVerificaSeTemValorLiquidoReceber Then
    Begin
      pCriarFormularios(TfrmSelVen, frmSelVen);
      frmSelVen.mskCompet.Text    := mskMesBas.Text;
      frmSelVen.mskCompet.Enabled := False;
      frmSelVen.mskDtaVen.Date    := StrToDate('01/'+ mskMesBas.Text);

      frmSelVen.strCodCta := EmptyStr;
      frmSelVen.strCodPor := EmptyStr;
      frmSelVen.strFUNCPG := fCfgSis('FUNCPG', varString, VS_strCodEmp);

      frmSelVen.blnValFun := fVerificaSeTemFuncionariosSemPlanoContas;

      If frmSelVen.strFUNCPG = 'A' then
      Begin
        pCriaTemporaria(strCodCta, strCodPor);
        If frmSelVen.blnValFun Then
           frmSelVen.strCodCta := strCodCta;
        frmSelVen.strCodPor := strCodPor;
      End;

      Try
        frmSelVen.ShowModal;
      Finally
        blnGerPag := frmSelVen.blnGerPag;
        strCompet := frmSelVen.mskCompet.Text;
        strCodEmp := frmSelVen.edtCodEmp.Text;
        dteDtaVen := frmSelVen.mskDtaVen.Date;
        strCodCta := frmSelVen.strCodCta;
        strCodPor := frmSelVen.strCodPor;
        strHistorico := frmSelVen.memHistorico.Text;
        FreeAndNil(frmSelVen);
      End;

      If blnGerPag Then
      Begin
        If fTravaGeraPagar(strCodEmp, strCompet, dteDtaVen) Then
          Exit;

        If fGravaLancamentos(True) Then
        Begin
          if fGeraContasPagar(strCodEmp, strCompet, strHistorico, strCodCta,
            strCodPor, dteDtaVen) Then
          Begin
            pCarregaGrid(False);
            pHabilita(True);
          End;
        End;
      End;
    End
    Else
      fMensagem('','Não existe valor líquido a receber ou o mesmo está negativo, portanto não poderá ser gravado contas a pagar!',['&O k']);
  End;
end;

procedure TfrmDigMovimentoMensal.btnHerdarMesBaseClick(Sender: TObject);
begin
  inherited;

  mskMesBas.Clear;
  edtTipMov.Clear;
  dbgMovMenDBBandedTableView.ClearItems;
  cdsMovMen.Close;
  pHabilita(False);

  pCriarFormularios(TfrmHerdarMesBase, frmHerdarMesBase);
  frmHerdarMesBase.bolValidaMesmaEmpresa := True;
  if frmHerdarMesBase.showmodal = mrOk then
  begin
    edtCodEmp.Text := frmHerdarMesBase.edtCodEmpOrig.text;
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    mskMesBas.Text := frmHerdarMesBase.mskMesOrig.text;
    edtTipMov.Text := frmHerdarMesBase.edtTipMovOrig.Text;

    pCarregaGrid(False);
    pHabilita(True);
    pSetFocus(dbgMovMen);
    edtCodEmp.Text := frmHerdarMesBase.edtCodEmpDest.text;
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    mskMesBas.Text := frmHerdarMesBase.mskMesDest.text;
    edtTipMov.Text := frmHerdarMesBase.edtTipMovDest.Text;
  end;
  FreeAndNil(frmHerdarMesBase);
end;

procedure TfrmDigMovimentoMensal.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp)
end;

procedure TfrmDigMovimentoMensal.btnImportarTeseClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  pImportaArquivoTese;
  pSetFocus(dbgMovMen);
end;

procedure TfrmDigMovimentoMensal.btnIniBusClick(Sender: TObject);
begin
  inherited;
  If Not btnIniBus.Visible Then
    Exit;

  If cdsMovMen.IsEmpty Then
  Begin
    fMensagem('', 'É necessário cadastrar ao menos um funcionário!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmDigMensalFPBusca, frmDigMensalFPBusca);
    frmDigMensalFPBusca.ShowModal;
    pConcluiBusca;
    pSetFocusGrid;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmDigMovimentoMensal.btnIniBusClick]');
    End;
  End;

  pFreeAndNil(frmDigMensalFPBusca);
  pSetFocus(Self);
end;

procedure TfrmDigMovimentoMensal.btnLocProxClick(Sender: TObject);
begin
  inherited;
  If Not btnLocProx.Visible Then
    Exit;

  If cdsMovMen.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário cadastrar ao menos um funcionário!', ['&Ok']);
    Exit;
  End;

  If (Not cdsMovMen.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    pLocalizaProxima;
    pSetFocusGrid;
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);
end;

procedure TfrmDigMovimentoMensal.btnMarcarTodasClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  If dbgMovMenDBBandedTableView.DataController.RecordCount > 0 Then
  Begin
    With dbgMovMenDBBandedTableView Do
    Begin
      BeginUpdate();
      Controller.SelectAll;

      For I := 0 To ViewData.RecordCount - 1 Do
        ViewData.Records[I].Selected := True;

      EndUpdate();
    End;
    pSetFocus(dbgMovMen);
  End
  Else
    fMensagem('Aviso', 'Não existem lançamentos para serem marcados!', ['&O k']);

end;

procedure TfrmDigMovimentoMensal.mskMesBasClick(Sender: TObject);
begin
  inherited;
  dbgMovMen.Enabled := False;
end;

procedure TfrmDigMovimentoMensal.mskMesBasExit(Sender: TObject);
  Var
    strTmp : String;
    dtaTmp : TDate;
begin
  inherited;
  If Not fEmptyStr(fTiraCaracEspeciais(mskMesBas.Text)) Then
  Begin
    strTmp := Copy(mskMesBas.Text, 4, Length(mskMesBas.Text));
    dtaTmp := StrToDate('01/01/'+strTmp);
    mskMesBas.Text := Copy(mskMesBas.Text, 1, 3) + FormatDateTime('yyyy', dtaTmp);
  End;
end;

procedure TfrmDigMovimentoMensal.OnGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  If (ARecord.Values[Sender.Index] = 0) Or (ARecord.Values[Sender.Index] = Null) Then
    AText := '0,00';
end;

procedure TfrmDigMovimentoMensal.pHabilita(blnHabili: Boolean);
begin
  btnConfirma.Enabled         := blnHabili;
  btnExcluir.Enabled          := blnHabili;
  dbgMovMen.Enabled           := blnHabili;
  btnIniBus.Enabled           := blnHabili;
  btnLocProx.Enabled          := blnHabili;
  btnMarcarTodas.Enabled      := blnHabili;
  btnDesmarcarTodas.Enabled   := blnHabili;
  btnGerarPagar.Enabled       := blnHabili;
  btnExcluirMovimento.Enabled := blnHabili;
  mskMesBas.Enabled           := Not blnHabili;
  edtCodEmp.Enabled           := Not blnHabili;
  btnCarregar.Enabled         := Not blnHabili;
  btnImportarTese.Enabled     := Not blnHabili;
  edtTipMov.Enabled           := Not blnHabili;

  If (edtCodEmp.Enabled) Then
  Begin
    pSetFocus(edtCodEmp);
  End
  Else
    pSetFocus(dbgMovMen);
end;

function TfrmDigMovimentoMensal.RetornaDelimitador(AText: String): Char;
begin
  Result := ',';

  If Pos(';',AText) > 0 Then
    Result := ';';
end;

procedure TfrmDigMovimentoMensal.pImportaArquivoTese;
var
  opdArquiv: TOpenDialog;
  strNomArq,
  strAutoIn: String;
  arrLinha_: TArray<String>;
  stlArquiv: TStringList;
  intConta_: Integer;
  qryGrava_: TUniQuery;
  blnIniTra: Boolean;
  FGravando: IObserver_;
  FSubject_: ISubject_;
  strParam_: Array of String;
  AEmpresasDiferentes: Boolean;
  LReferencia : Integer;
  LCodigoEmpresa : String;
  LDelimitador : Char;
begin
  If Not fVerificaMovimento Then
    Exit;

  strNomArq := '';
  blnIniTra := False;
  opdArquiv := TOpenDialog.Create(nil);
  cdsErros.EmptyDataSet;
  AEmpresasDiferentes := False;

  Try
    With opdArquiv Do
    Begin
      IF fCfgSis('IMPTES') <> '' Then
        InitialDir := fCfgSis('IMPTES')
      Else
        InitialDir := ExtractFileDir(Application.ExeName);

      Filter     := 'Arquivos do Tipo CSV (*.CSV)|*.csv';
      If Execute Then
        strNomArq := FileName;
    End;

  Finally

    FreeAndNil(opdArquiv);
  End;

  If strNomArq <> '' Then
  Begin
    Try

      FGravando := TGravandoObs.Create;
      FSubject_ := TSubject.Create;
      FSubject_.pAddObserver(FGravando);
      SetLength(strParam_, 4);

      stlArquiv  := CarregaArquivoImportacao(strNomArq);

      If stlArquiv.Count > 1 Then
      Begin
        fStartTransaction;
        blnIniTra := True;

        strAutoIn := '';
        qryGrava_ := fCriaQuery();

        //Preparando array de parametros que será responsavel pelas notificações com o objeto observador.
        strParam_[2] := 'Salvando Informações do Arquivo CSV...';

        //Enviando notificação que vai atualizar os observadores.
        FSubject_.pNotify(strParam_);

        QryGrava_.Sql.Clear;
        QryGrava_.Sql.Text := ' INSERT INTO ' +
                              '   IMPTES    ' +
                              ' SET         ' +
                              '   TES_NOMARQ = :NOMARQ, ' +
                              '   TES_DTAIMP = :DTAIMP, ' +
                              '   TES_OPEIMP = :OPEIMP, ' +
                              '   TES_HORIMP = :HORIMP, ' +
                              '   TES_CODEMP = :CODEMP, ' +
                              '   TES_MESBAS = :MESBAS, ' +
                              '   TES_TIPMOV = :TIPMOV, ' +
                              '   AUTOINCREM = :AUTOIN ';

        strAutoIn := fRetAutoIncrem('IMPTES', edtCodEmp.Text);
        QryGrava_.ParamByName('NOMARQ').AsString := ExtractFileName(strNomArq);
        QryGrava_.ParamByName('DTAIMP').AsDate   := VS_Date;
        QryGrava_.ParamByName('OPEIMP').AsString := strLoginUsuarioLogado;
        QryGrava_.ParamByName('HORIMP').AsTime   := fTime();
        QryGrava_.ParamByName('CODEMP').AsString := edtCodEmp.Text;
        QryGrava_.ParamByName('MESBAS').AsString := fTiraCaracEspeciais(mskMesBas.Text);
        QryGrava_.ParamByName('TIPMOV').AsString := edtTipMov.Text;
        QryGrava_.ParamByName('AUTOIN').AsString := strAutoIn;

        QryGrava_.ExecSql;
        QryGrava_.Close;

        SetLength(arrLinha_, 0);
        If strAutoIn <> '' Then
        Begin
          strParam_[0] := 'TcxProgressBar';
          strParam_[1] := IntToStr(stlArquiv.Count);
          strParam_[2] := 'Salvando Informações do Arquivo CSV...';

          For intConta_ := 0 To stlArquiv.Count-1 Do
          Begin
            //Atualizando os observadores
            strParam_[3] := IntToStr(intConta_);
            FSubject_.pNotify(strParam_);

            LDelimitador := RetornaDelimitador(stlArquiv.Strings[intConta_]);
            arrLinha_ := stlArquiv.Strings[intConta_].Split([LDelimitador]);

            If Pos('EMPRESA',arrLinha_[0].ToUpper) > 0 Then
              Continue;

            LCodigoEmpresa := fStrZero(RightStr(arrLinha_[0],3),3);
            AEmpresasDiferentes := not LCodigoEmpresa.Equals(edtCodEmp.Text);

            if AEmpresasDiferentes then
              Continue;

            QryGrava_.Close;
            QryGrava_.Sql.Clear;
            QryGrava_.Sql.Text := ' INSERT INTO ' +
                                  '   DETTES    ' +
                                  ' SET         ' +
                                  '   TES_CODEMP = :CODEMP, ' +
                                  '   TES_CODFUN = :CODFUN, ' +
                                  '   TES_DIGITO = :DIGITO, ' +
                                  '   TES_NOMFUN = :NOMFUN, ' +
                                  '   TES_CENCUS = :CENCUS, ' +
                                  '   TES_CODVER = :CODVER, ' +
                                  '   TES_DESVER = :DESVER, ' +
                                  '   TES_VALLAN = :VALLAN, ' +
                                  '   TES_REFERE = :REFERE, ' +
                                  '   TES_ARQINC = :ARQINC, ' +
                                  '   AUTOINCREM = :AUTOIN ';

            QryGrava_.ParamByName('CODEMP').AsString := fStrZero(RightStr(LCodigoEmpresa,3),3);
            QryGrava_.ParamByName('CODFUN').AsString := arrLinha_[1];
            QryGrava_.ParamByName('DIGITO').AsString := arrLinha_[2];
            QryGrava_.ParamByName('NOMFUN').AsString := arrLinha_[3];
            QryGrava_.ParamByName('CENCUS').AsString := arrLinha_[4];
            QryGrava_.ParamByName('CODVER').AsString := arrLinha_[5];
            QryGrava_.ParamByName('DESVER').AsString := arrLinha_[6];

            QryGrava_.ParamByName('VALLAN').Value := 0.00;
            If arrLinha_[7] <> '' Then
              QryGrava_.ParamByName('VALLAN').Value := fStrToFloat(arrLinha_[7]);

            QryGrava_.ParamByName('REFERE').AsInteger := 0;
            If arrLinha_[8] <> '' Then
            begin
              if TryStrToInt(arrLinha_[8], LReferencia) Then
              begin
                QryGrava_.ParamByName('REFERE').AsInteger := LReferencia;
              end
              else
              begin
                fMensagem('Aviso', 'Campo de REFERENCIA preenchido de forma incorreta, por favor verifique.', ['&O k']);
                raise EConvertError.CreateFmt('''%s'' is not a valid integer value.', [arrLinha_[8]])
              end;
            end;

            QryGrava_.ParamByName('ARQINC').AsString  := strAutoIn;
            QryGrava_.ParamByName('AUTOIN').AsString  := fRetAutoIncrem('DETTES', edtCodEmp.Text);

            QryGrava_.ExecSql;

            QryGrava_.Close;

            SetLength(arrLinha_, 0);

          End;
        End
        Else
        Begin
          If blnIniTra Then
            fRollBack;

          strParam_[0] := 'Esconder';
          FSubject_.pNotify(strParam_);
          Finalize(strParam_);

          FreeAndNil(stlArquiv);
          FreeAndNil(qryGrava_);

          fMensagem('ATENÇÃO','Arquivo sem movimentação ou corrompido!' +#13+ 'Verifique o layout esperado no botão [?]', ['&O k']);

          Exit;

        End;

        FreeAndNil(qryGrava_);
      End
      Else
      Begin
        If blnIniTra Then
          fRollBack;

        strParam_[0] := 'Esconder';
        FSubject_.pNotify(strParam_);
        Finalize(strParam_);

        FreeAndNil(stlArquiv);
        FreeAndNil(qryGrava_);

        fMensagem('ATENÇÃO','Arquivo sem movimentação ou corrompido!' +#13+ 'Verifique o layout esperado no botão [?]', ['&O k']);
        Exit;

      End;

      FreeAndNil(stlArquiv);

      strParam_[0] := '';
      strParam_[1] := '0';
      strParam_[2] := 'Relacionando lançamentos...';
      FSubject_.pNotify(strParam_);

      If fRelacionaArquivo(strAutoIn) Then
        RenameFile(strNomArq, StringReplace(strNomArq.ToUpper, '.CSV', '.IMP', []));

      If blnIniTra Then
          fCommit;

      pCarregaGrid(False);
      pHabilita(True);

      strParam_[0] := 'Esconder';
      FSubject_.pNotify(strParam_);

      if cdsErros.RecordCount > 0 then
      begin
        fMensagem('','Ocorreram erros na importação do arquivo, clique em Ok para emitir o relatório de inconsistências!', ['&O k']);
        frxRelatorioJ.Script.Variables['NOMEMP'] := fRetNomeEmpresaSelec(edtCodEmp.Text);
        pPreviewReport(Self.Name, Self.Caption + ' (Relatório de inconsistências)', frxRelatorioJ);
      end;

      if AEmpresasDiferentes Then
        fMensagem('ATENÇÃO! ','Alguns registros que contém no arquivo não foram importados.'  + #13 +
                              'Motivo: empresa informada no arquivo diferente da empresa de importação.' + #13 +
                              'Empresa esperada: ' + edtCodEmp.Text + ' Empresa encontrada: ' + LCodigoEmpresa + '.', ['&O k']);

      fMensagem('','Arquivo importado com sucesso!', ['&O k']);

      Finalize(strParam_);
    Except
      On e: Exception Do
      Begin
        If blnIniTra Then
          fRollBack;

        strParam_[0] := 'Esconder';
        FSubject_.pNotify(strParam_);
        Finalize(strParam_);

        FreeAndNil(stlArquiv);
        FreeAndNil(qryGrava_);

        pMensagensErro(E.Message,'[pImportaArquivoTese]');
      End;
    End;
  End;
end;

procedure TfrmDigMovimentoMensal.pSetFocusGrid;
begin
  dbgMovMenDBBandedTableView.OptionsSelection.MultiSelect:=False;
  pSetFocus(dbgMovMen);
  dbgMovMenDBBandedTableView.OptionsSelection.MultiSelect:=True;
end;

function TfrmDigMovimentoMensal.VerificaCTPBaixadoSelecionado: Boolean;
begin
  Result := False;

  If Not cdsMovMen.IsEmpty Then
  Begin
    If cdsMovMen.FieldByName('STATUS').AsString = 'BAIXADO' Then
    Begin
      fMensagem('ATENÇÃO', 'Existem documentos baixados do contas a pagar, para excluir o o movimento é necessário estornar o documento!', ['&OK']);
      Result := True;
    End;
  End;
end;

function TfrmDigMovimentoMensal.VerificaCTPEnviadoSelecionado: Boolean;
  var
    LConsulta: TUniQuery;
    strNumDup: String;
    arrChave_: TArray<String>;
begin
  Result    := False;
  strNumDup := '';

  If Not cdsMovMen.IsEmpty Then
  Begin
    If cdsMovMen.FieldByName('STATUS').AsString = 'ABERTO' Then
    Begin
      LConsulta := fCriaQuery;

      LConsulta.Sql.Text := ' SELECT  ' +
                            '   CTP_DTAENV, CTP_BCOENV ' +
                            ' FROM ' +
                            '   CADPAG ' +
                            ' WHERE    ' +
                            '   CTP_NUMDUP = :NUMDUP AND ' +
                            '   CTP_PARCEL = :PARCEL AND ' +
                            '   CTP_CODEMP = :CODEMP AND ' +
                            '   CTP_SERIE_ = :SERIE_ AND ' +
                            '   CTP_CODFOR = :CODFOR ';

      arrChave_ := cdsMovMen.FieldByName('CTAPAG').AsString.Split(['-']);

      LConsulta.ParamByName('NUMDUP').AsString := arrChave_[0];
      LConsulta.ParamByName('PARCEL').AsString := arrChave_[1];
      LConsulta.ParamByName('CODEMP').AsString := arrChave_[2];
      LConsulta.ParamByName('SERIE_').AsString := arrChave_[3];
      LConsulta.ParamByName('CODFOR').AsString := arrChave_[4];

      LConsulta.Open;

      If Not LConsulta.IsEmpty Then
      Begin
        If (LConsulta.FieldByName('CTP_DTAENV').Value <> Null) Then
        Begin
          If (LConsulta.FieldByName('CTP_BCOENV').AsString <> '') Then
            strNumDup := strNumDup + '/' + cdsMovMen.FieldByName('CTAPAG').AsString;
        End;
      End;

      LConsulta.Close;
      FreeAndNil(LConsulta);
    End;

  End;

  If strNumDup <> '' Then
  Begin
    Result := True;
    fMensagem('ATENÇÃO', 'A duplicata do contas a pagar possui informação de envio ao banco para pagamento. ' +
                         'Para excluir o lançamento, é necessário cancelar o envio dessas duplicatas!', ['&OK']);
  End;
end;

function TfrmDigMovimentoMensal.VerificaSeOFuncionarioFazParteDaEmpresa: Boolean;
  Var
    LRegistro: TUniQuery;
begin
  LRegistro := fCriarQuery('SELECT FUN_CODEMP, FUN_DTAADM, FUN_DTADEM FROM CADFUN WHERE ' +
                           ' AUTOINCREM="' + cdsMovMen.FieldByName('AUTFUN').AsString + '"');
  LRegistro.Open;

  Result := LRegistro.FieldByName('FUN_CODEMP').AsString = edtCodEmp.Text;

  If Result Then
  Begin
    Result := LRegistro.FieldByName('FUN_DTAADM').AsDateTime <= StrToDate('01/' + mskMesBas.Text);

    If Result Then
      Result := (LRegistro.FieldByName('FUN_DTADEM').IsNull) Or
                (LRegistro.FieldByName('FUN_DTADEM').AsDateTime >= StrToDate('01/' + mskMesBas.Text));
  End;

  FreeAndNil(LRegistro);

  If Result Then
    fMensagem('ATENÇÃO', 'Não é possível excluir o movimento de um funcionário da empresa ativo no mês selecionado.', ['&OK']);
end;

procedure TfrmDigMovimentoMensal.pLocalizaProxima;
begin
  If Not cdsMovMen.FindNext Then
    fMensagem('ATENÇÃO!', 'Não há funcionários para localizar!', ['&O k']);
end;

procedure TfrmDigMovimentoMensal.pRetornaStatusCTP(const strAutCtp: String;
  var strDupCtp: String; var blnBaixada: Boolean; var strHistorico: String);
var
  qryCons: TUniQuery;
begin
  If strAutCtp <> '' Then
  Begin
    qryCons := fCriaQuery;

    strDupCtp  := '';
    blnBaixada := False;

    With qryCons Do
    Begin
      Sql.Clear;
      Sql.Text := ' SELECT ' +
                  '   CONCAT(CTP_NUMDUP,"-",CTP_PARCEL,"-",CTP_CODEMP,"-",CTP_SERIE_,"-",CTP_CODFOR) AS NUMDUP, ' +
                  '   CTP_HIST01, ' +
                  '   CTP_DTAPAG ' +
                  ' FROM CADPAG ' +
                  ' WHERE AUTOINCREM = :AUTCTP ';

      ParamByName('AUTCTP').AsString := strAutCtp;

      Open;

      If Not IsEmpty Then
      Begin
        strDupCtp  := FieldByName('NUMDUP').AsString;
        blnBaixada := FieldByName('CTP_DTAPAG').Value <> Null;
        strHistorico := StringReplace(FieldByName('CTP_HIST01').AsString, #13#10, ' ', [rfReplaceAll]);
      End;

      Close;

    End;

    FreeAndNil(qryCons);
  End;
end;

procedure TfrmDigMovimentoMensal.dbgMovMenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {******************************************}
  {* NÃO PERMITE INFORMAR VALORES NEGATIVOS *}
  {***************************************PZ*}
  If (Key = '-') Then
    Key := #0;
end;

procedure TfrmDigMovimentoMensal.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
end;

procedure TfrmDigMovimentoMensal.edtCodEmpKeyPress(Sender: TObject;
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
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmDigMovimentoMensal.ExcluirCadPagSelecionado: Boolean;
  Var
    repCadPag: TCadPagRepository;
    ctpDuplic: TCadPag;
    arrChave_: TArray<String>;
begin
  Result := True;

  If Not cdsMovMen.IsEmpty Then
  Begin
    repCadPag := TCadPagRepository.Create;

    Try
      If cdsMovMen.FieldByName('STATUS').AsString = 'ABERTO' Then
      Begin
        arrChave_ := cdsMovMen.FieldByName('CTAPAG').AsString.Split(['-']);
        ctpDuplic :=  repCadPag.fRetDuplicata(arrChave_[0], arrChave_[1], 0, arrChave_[2], arrChave_[4], arrChave_[3]);
        If Assigned(ctpDuplic) Then
        Begin
          repCadPag.pGravaDelCadPag(ctpDuplic, Self.Name);
          pGravaLogCtp(ctpDuplic, 'EXCLUSAO', Self.Name);
          repCadPag.pDeletar(ctpDuplic);
        End;
      End;
      FreeAndNil(repCadPag);
    Except
      On e: Exception Do
        Raise Exception.Create('Ocorreu o seguinte erro ao excluir o contas a pagar gerado: ' + e.Message);
    End;
  End;
end;

procedure TfrmDigMovimentoMensal.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  //inherited;
  Case Key Of
    VK_ESCAPE: pEscapePressed;

    VK_F4:
    Begin
      If btnHerdarMesBase.Enabled Then
        btnHerdarMesBase.Click;
    End;

    VK_F5:
    Begin
      If btnIniBus.Enabled Then
        btnIniBus.Click;
    End;

    VK_F6:
    Begin
      If btnLocProx.Enabled Then
        btnLocProx.Click;
    End;

    VK_F7:
    Begin
      If btnMarcarTodas.Enabled Then
        btnMarcarTodas.Click;
    End;

    VK_F8:
    Begin
      If btnDesmarcarTodas.Enabled Then
        btnDesmarcarTodas.Click;
    End;

    VK_F10:
    Begin
      If btnConfirma.Enabled Then
        btnConfirma.Click;
    End;

    VK_F11:
    Begin
      If btnGerarPagar.Enabled Then
        btnGerarPagar.Click;
    End;

    VK_F12:
    Begin
      If btnExcluir.Enabled Then
        btnExcluir.Click;
    End;
  End;

  If (Shift = [ssCtrl]) And (Chr(Key) = 'R') Then
  Begin
    If btnExcluirMovimento.Enabled Then
      btnExcluirMovimento.Click;
  End;
end;

procedure TfrmDigMovimentoMensal.pEscapePressed;
begin
  If edtCodEmp.Focused Then
    inherited
  Else
  Begin
    If (fConfirmaSaida) Then
    Begin
      mskMesBas.Clear;
      edtTipMov.Clear;
      dbgMovMenDBBandedTableView.ClearItems;
      cdsMovMen.Close;
      pHabilita(False);
      dbgMovMenDBBandedTableView.Bands.Clear;
    End;
  End;
end;

procedure TfrmDigMovimentoMensal.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If Not fEmptyStr(strCampoFiltro) Then
    Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

function TfrmDigMovimentoMensal.fConfirmaSaida: Boolean;
begin
  Result := False;

  If (fMensagem('ATENÇÃO!','Ao abandonar a Planilha, os dados alterados serão perdidos, deseja realmente continuar?',['&SIM','&NÃO'],2,True) = 1) Then
  Begin
    Result := True;
  End;
end;

function TfrmDigMovimentoMensal.fContaBancariaPagaPagamento(
  strCodFor: String): Nullable<string>;
Var
  qryAux: TUniQuery;
begin

  Result := '';

  Try
    qryAux := fCriaQuery;

    qryAux.SQL.Text := 'SELECT AUTOINCREM FROM BCOFOR WHERE BCF_CODFOR = :CODFOR AND BCF_CTAPAG = "S"';
    qryAux.ParamByName('CODFOR').AsString := strCodFor;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
      Result := qryAux.FieldByName('AUTOINCREM').AsString
    Else
      Result := SNull;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmDigMovimentoMensal.fExcluirCadPag: Boolean;
Var
  repCadPag: TCadPagRepository;
  ctpDuplic: TCadPag;
  blnIniTra: Boolean;
  arrChave_: TArray<String>;
  strDireitos  : String;
begin
  Result    := True;
  blnIniTra := False;
  If Not cdsMovMen.IsEmpty Then
  Begin
    If fValidarDirEspecificos(strDireitos, strLoginUsuarioLogado, 'frmCadCtaPagar') Then
    Begin
      if Pos('E', strDireitos) <= 0 Then
      Begin
        fMensagem('Aviso', 'Usuário sem permissão para exclusão do contas a pagar!', ['&O K']);
        Result := False;
        Exit;
      End;
    End;

    cdsMovMen.DisableControls;
    cdsMovMen.First;

    repCadPag := TCadPagRepository.Create;

    Try
      fStartTransaction;
      blnIniTra := True;

      While Not cdsMovMen.Eof Do
      Begin
        If cdsMovMen.FieldByName('STATUS').AsString = 'ABERTO' Then
        Begin
          arrChave_ := cdsMovMen.FieldByName('CTAPAG').AsString.Split(['-']);
          ctpDuplic :=  repCadPag.fRetDuplicata(arrChave_[0], arrChave_[1], 0, arrChave_[2], arrChave_[4], arrChave_[3]);
          If Assigned(ctpDuplic) Then
          Begin
            repCadPag.pGravaDelCadPag(ctpDuplic, Self.Name);
            pGravaLogCtp(ctpDuplic, 'EXCLUSAO', Self.Name);
            repCadPag.pDeletar(ctpDuplic);
          End;
        End;

        cdsMovMen.Next;
      End;

      fCommit;
    Except
      On e: Exception Do
      Begin
        if blnIniTra Then
          fRollBack;

        fMensagem('Aviso', 'Ocorreu o seguinte erro ao excluir o contas a pagar gerado: ' + e.Message, ['&O K']);

        Result := False;
      End;
    End;

    FreeAndNil(repCadPag);

    cdsMovMen.First;
    cdsMovMen.EnableControls;
  End;
end;

procedure TfrmDigMovimentoMensal.btnSairClick(Sender: TObject);
begin
  If Not (edtCodEmp.Focused) Then
  Begin
    If (fConfirmaSaida) Then
    Begin
      mskMesBas.Clear;
      edtTipMov.Clear;
      pCarregaGrid(True);
      pHabilita(False);
      Close;
    End;
  End
  Else
    inherited;
end;

function TfrmDigMovimentoMensal.CarregaArquivoImportacao(AFile: String): TStringList;
  Var
    LCopia: String;
begin
  Try
    Result := TStringList.Create;
    Try
      Result.LoadFromFile(AFile);
    Except
      On E: Exception Do
      Begin

        If ((Pos('o arquivo já está sendo usado por outro processo', LowerCase(E.Message)) > 0)) then
        Begin
          Try
            LCopia := ExtractFilePath(AFile) + ExtractFileName(AFile) + '_Copia' + FormatDateTime('DDMMYYYYHHNNSS', Date + fTime()) + '.csv' ;
            CopyFile(pChar(AFile), pChar(LCopia), False);
            Result.LoadFromFile(LCopia);
          Except
            On E: Exception Do
            Begin
              Result := Nil;
              Raise Exception.Create(E.Message);
            End;
          End;
        End;

      End;
    End;
  Finally
    If FileExists(LCopia) Then
      DeleteFile(LCopia);
  End;
end;

procedure TfrmDigMovimentoMensal.dbgMovMenDBBandedTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (AViewInfo.Item.DataBinding.FilterFieldName = 'CTAPAG') Or
     (AViewInfo.Item.DataBinding.FilterFieldName = 'STATUS') Or
     (AViewInfo.Item.DataBinding.FilterFieldName = 'LIQUIDO_RECEBER') Or
     (AViewInfo.Item.DataBinding.FilterFieldName = 'HISTORICO') Then
  Begin
    ACanvas.Brush.Color:= clSilver;
  End;

End;

procedure TfrmDigMovimentoMensal.dbgMovMenDBBandedTableViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  If cdsMovMen.FieldByName('CTAPAG').AsString <> '' Then
    AAllow := False;
end;

procedure TfrmDigMovimentoMensal.dbgMovMenDBBandedTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  AColumn: TcxGridDBBandedColumn;
begin
  inherited;
  AColumn := dbgMovMenDBBandedTableView.GetColumnByFieldName('CTAPAG');
  If AColumn <> Nil Then
  Begin
    if (ARecord is TcxGridDataRow) And (ARecord.Values[AColumn.Index] <> '') then
      AStyle := CxStyle6;
  End;

end;

procedure TfrmDigMovimentoMensal.cdsMovMenBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

end.
