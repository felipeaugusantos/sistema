unit Contabilidade.View.ImportacaoContabil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, ComboBoxFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxCurrencyEdit, CurrencyEditFocus, EditFocus, Contabilidade.View.TfrmPaiContabilidade, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, UniClientDataSet,
  cxMaskEdit, cxButtonEdit, FilenameEditFocus, cxProgressBar, Contabilidade.Interfaces;

type
  TfrmImportacaoContabil = class(TfrmPaiContabilidade)
    pnlFundo: TPanel;
    rdgLancto: TRadioGroup;
    btnGerar: TBitBtnLocked;
    cxgDadosDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgDadosLevel1: TcxGridLevel;
    cxgDados: TcxGridCitel;
    dtsDados: TDataSource;
    cxgDadosDBTableViewCitel1CON_DTALAN: TcxGridDBColumn;
    cxgDadosDBTableViewCitel1CON_EMPLAN: TcxGridDBColumn;
    cxgDadosDBTableViewCitel1CON_CONDEB: TcxGridDBColumn;
    cxgDadosDBTableViewCitel1CON_CONCRE: TcxGridDBColumn;
    cxgDadosDBTableViewCitel1CON_VALLAN: TcxGridDBColumn;
    cxgDadosDBTableViewCitel1CON_HISTOR: TcxGridDBColumn;
    cxgDadosDBTableViewCitel1CON_CCUSTO: TcxGridDBColumn;
    cxgDadosDBTableViewCitel1CON_CCUSCR: TcxGridDBColumn;
    cxgDadosDBTableViewCitel1CON_C_G_C_: TcxGridDBColumn;
    edtArquivo: TFilenameEditFocus;
    lbl1: TLabel;
    btnCarregarDados: TBitBtnLocked;
    cxgDadosDBTableViewCitel1CON_VALIDO: TcxGridDBColumn;
    cxgDadosDBTableViewCitel1Column1: TcxGridDBColumn;
    Shape1: TShape;
    Shape2: TShape;
    Label1: TLabel;
    Label2: TLabel;
    lblInfoDetal: TLabel;
    cxgDadosDBTableViewCitel1CON_CODHIP: TcxGridDBColumn;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgDadosDBTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure edtArquivoPropertiesChange(Sender: TObject);
    procedure btnCarregarDadosClick(Sender: TObject);
    procedure cxgDadosDBTableViewCitel1Column1PropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
  private
    type
      TrecDados = record
        strContaDebito : string;
        blnContaDebitoRed: boolean ;
        strContaCredito: string;
        blnContaCreditoRed: boolean ;
        strCodEmp: string;
        strCentroDeCustoDebito : string;
        strCentroDeCustoCredito: string;
        dtaDtaLan: TDate;
        strCnpj: string;
        strHistorico: string;
        strValor: string;
        strCodigoHistoricoPadrao: string;
      end;
  private
    { Private declarations }
    cdsPlancoVigencia: TUniClientDataSet;
    FValidarVigenciaCta : boolean;
    blnExisteTabelaLYCONT : boolean;
    cdsDados : TUniClientDataSet;
    blnExisteCampoCON_VERSIS : boolean ;
    blnExisteCampoCON_EMPLOG : boolean ;
    function fCriaCdsDados: TUniClientDataSet;
    function fValidaConta(strConta: string; AStrCodEmp: string; const ABlnContaReduzida: boolean): boolean;
    function fValidaEmpresa(strCodEmp: string): boolean;
    function fValidaCentroDeCusto(strCCusto: string): boolean;
    function fValidarDados(recDados: TrecDados; var strMotivo: string): boolean;
    function fProcessarDados(pgbProgresso: TcxProgressBar): Boolean;
    function fGravarDados(pgbProgresso: TcxProgressBar): Boolean;
    procedure pProcessarValores(const AValor: string; var recDados: TrecDados; const ALayoutSelecionado: TLayoutImportacaoContabil);
    function fTemLayoutConfigurado(const ALayout: TLayoutImportacaoContabil): boolean;
    function fgetLayoutSelecionado: TLayoutImportacaoContabil;
    function fLerValorDoLayout(const ALayoutSelecionado: TLayoutImportacaoContabil; const AChave, AValor: string): string;
    function fDataLayToDate(const ADataStr: string): TDate;
    procedure pLimpaValorSeZerado(var AValor: string);
    function fValidaHistoricoPadrao(strCHistoricoPadrao, strCodEmp: string): boolean;
    procedure pLiberaPlancoVigencia;
    function fGetTipLan(AOpcao:integer): string;
    function fParametroSelecionado(const ALayoutSelecionado: TLayoutImportacaoContabil; const AChave: string): boolean ;
    function fTemParametroSelecionado(const ALayoutSelecionado: TLayoutImportacaoContabil): boolean ;
    function fTemContaReduzida(const ALayoutSelecionado: TLayoutImportacaoContabil; const AChave: string): boolean ;
    function fContaContabilPelaReduzida(const AStrContaReduzida, AStrEmpresa: string; const ABlnReduzida: boolean): string ;
  public
    { Public declarations }
  end;


implementation

uses
  Uni, StrUtils, untTypesSistema, untFuncoesSimples, Contabilidade.Funcoes,
  untConsultas, DateUtils, untObservacao, Contabilidade.Classes.Helpers,
  Contabilidade.Consultas; 

{$R *.dfm}

{ TfrmImportacaoContabil }

procedure TfrmImportacaoContabil.btnCarregarDadosClick(Sender: TObject);
begin
  if (fEmptyStr(edtArquivo.Text)) then
  begin
    fMensagem('ATENÇÃO!', 'É necessário informar um arquivo válido!', ['&OK']);
    pSetFocus(edtArquivo);
    exit;
  end;

  if (not FileExists(edtArquivo.Text)) then
  begin
    fMensagem('ATENÇÃO!', 'É necessário informar um arquivo válido!', ['&OK']);
    pSetFocus(edtArquivo);
    exit;
  end;

  if rdgLancto.ItemIndex < 0 then
  begin
    fMensagem('ATENÇÃO!', 'É necessário informar o tipo de informação!', ['&OK']);
    pSetFocus(rdgLancto);
    exit;
  end;

  if not fTemParametroSelecionado(fgetLayoutSelecionado) then
  begin
    fMensagem('ATENÇÃO!', 'Nenhum parâmetro selecionado!'+#13+'Configure o layout na CFG_LYCONT', ['&OK']);
    pSetFocus(rdgLancto);
    exit;
  end;

  fChamaTelaGravando(fProcessarDados);
end;

procedure TfrmImportacaoContabil.btnGerarClick(Sender: TObject);
begin
  if rdgLancto.ItemIndex < 0 then
  begin
    fMensagem('ATENÇÃO!', 'É necessário informar o tipo de informação!', ['&OK']);
    pSetFocus(rdgLancto);
    exit;
  end;

  fChamaTelaGravando(fGravarDados);
end;

procedure TfrmImportacaoContabil.cxgDadosDBTableViewCitel1Column1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if not Assigned(cdsDados) then
    exit;

  if not cdsDados.Active then
    exit;

  If fEmptyStr(cdsDados.FieldByName('CON_MOTIVO').AsString) Then
  Begin
    fMensagem('', 'Não há detalhes para esse registro!', ['&OK']);
    Exit;
  End;

  pCriarFormularios(TfrmObservacao, frmObservacao);
  Try
    frmObservacao.Caption := 'Detalhes';
    frmObservacao.btnClipBoard.Visible := True;
    frmObservacao.lblMensagem.Caption := '';
    frmObservacao.memObs.Texto := Trim(cdsDados.FieldByName('CON_MOTIVO').AsString);
    frmObservacao.BorderIcons := [biSystemMenu, biMaximize];
    frmObservacao.ClientWidth := 800;
    frmObservacao.ClientHeight := 600;
    frmObservacao.ShowModal;
  Finally
    pFreeAndNil(frmObservacao);
  End;
end;

procedure TfrmImportacaoContabil.cxgDadosDBTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Not cdsDados.Active) Or (cdsDados.IsEmpty) Then
    Exit;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxgDadosDBTableViewCitel1CON_VALIDO.Index]) = 'S' Then
    ACanvas.Font.Color := clBlue
  Else
    ACanvas.Font.Color := clRed;
end;

procedure TfrmImportacaoContabil.edtArquivoPropertiesChange(Sender: TObject);
begin
  inherited;
  btnCarregarDados.Enabled := (not fEmptyStr(edtArquivo.Text)) and (FileExists(edtArquivo.Text));
end;

function TfrmImportacaoContabil.fContaContabilPelaReduzida(
  const AStrContaReduzida, AStrEmpresa: string;
  const ABlnReduzida: boolean): string;
var
  strTplAco: string ;
begin
  result := AStrContaReduzida ;
  if ABlnReduzida then
  begin
    strTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [AStrEmpresa], False);
    result := fCampoTabelaPlanco('NCO_CODCON', ['NCO_CONRED', 'NCO_TPLACO'], [AStrContaReduzida, strTplAco], False) ;
  end;
end;

function TfrmImportacaoContabil.fCriaCdsDados: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Self);
  With Result, FieldDefs Do
  Begin
    With AddFieldDef Do
    Begin
      Name     := 'CON_DTALAN';
      DataType := ftDate;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_EMPLAN';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_CONCRE';
      DataType := ftString;
      Size     := 20;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_CTRDCR';
      DataType := ftBoolean;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_CONDEB';
      DataType := ftString;
      Size     := 20;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_CTRDDB';
      DataType := ftBoolean;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_VALLAN';
      DataType := ftFloat;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_HISTOR';
      DataType := ftString;
      Size     := 200;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_CCUSTO';
      DataType := ftString;
      Size     := 5;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_CCUSCR';
      DataType := ftString;
      Size     := 5;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_C_G_C_';
      DataType := ftString;
      Size     := 18;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_VALIDO';
      DataType := ftString;
      Required := False;
      Size := 1;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_MOTIVO';
      DataType := ftString;
      Size := 255;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'detalh';
      DataType := ftString;
      Size     := 3;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CON_CODHIP';
      DataType := ftString;
      Size     := 5;
      Required := False;
    End;

    IndexFieldNames := 'CON_DTALAN';
    CreateDataSet;
    Open;

    TFloatField(Result.FieldByName('CON_VALLAN')).DisplayFormat := '##,#0.00';
  End;
end;

function TfrmImportacaoContabil.fDataLayToDate(const ADataStr: string): TDate;
  var
    Ano, Mes, Dia: Word;
begin
  Ano := StrToIntDef(Copy(ADataStr, 1, 4), 0);
  Mes := StrToIntDef(Copy(ADataStr, 5, 2), 0);
  Dia := StrToIntDef(Copy(ADataStr, 7, 2), 0);
  Result := EncodeDate(Ano, Mes, Dia);
end;

function TfrmImportacaoContabil.fgetLayoutSelecionado: TLayoutImportacaoContabil;
begin
  Result := TLayoutImportacaoContabil(rdgLancto.ItemIndex);
end;

function TfrmImportacaoContabil.fGetTipLan(AOpcao: integer): string;
begin
  if AOpcao = 0 then
  begin
    result := 'FOL' ;
  end
  else if AOpcao = 1 then
  begin
    result := 'PAT' ;
  end
  else ///Dimob
  begin
    result := 'MOB' ;
  end;
end;

function TfrmImportacaoContabil.fGravarDados(
  pgbProgresso: TcxProgressBar): Boolean;
  var
    qryLanCon : TUniQuery;
    sHistoricoPadrao: string ;
    LstrCodEveDeb, LstrCodEveCre: string ;
    LcdsPlancoInfo: TUniClientDataSet;
begin
  qryLanCon := fCriaQuery(Self);
  LcdsPlancoInfo := fCarregaPlancoInfo ;
  try
    cdsDados.DisableControls;

    qryLanCon.SQL.Text := 'SELECT * FROM LANCON WHERE FALSE';
    qryLanCon.Open;

    fStartTransaction;
    try
      if Assigned(pgbProgresso) then
        pgbProgresso.Properties.Max := cdsDados.RecordCount;

      cdsDados.First;
      while not cdsDados.Eof do
      begin
        if Assigned(pgbProgresso) then
        begin
          pgbProgresso.Position := cdsDados.RecNo;
          Application.ProcessMessages;
        end;

        if cdsDados.FieldByName('CON_VALIDO').AsString = 'N' then
        begin
          cdsDados.Next;
          Continue;
        end;

        qryLanCon.Insert;
        qryLanCon.FieldByName('CON_EMPLAN').AsString := cdsDados.FieldByName('CON_EMPLAN').AsString;
        qryLanCon.FieldByName('CON_DTALAN').AsDateTime := cdsDados.FieldByName('CON_DTALAN').AsDateTime;
        qryLanCon.FieldByName('CON_TIPLAN').AsString := fGetTipLan(rdgLancto.ItemIndex);

        if not fEmptyStr(cdsDados.FieldByName('CON_CONCRE').AsString) then
          qryLanCon.FieldByName('CON_CONCRE').AsString := fContaContabilPelaReduzida(cdsDados.FieldByName('CON_CONCRE').AsString, cdsDados.FieldByName('CON_EMPLAN').AsString, cdsDados.FieldByName('CON_CTRDCR').AsBoolean);

        if not fEmptyStr(cdsDados.FieldByName('CON_CONDEB').AsString) then
          qryLanCon.FieldByName('CON_CONDEB').AsString := fContaContabilPelaReduzida(cdsDados.FieldByName('CON_CONDEB').AsString, cdsDados.FieldByName('CON_EMPLAN').AsString, cdsDados.FieldByName('CON_CTRDDB').AsBoolean);

        if not fEmptyStr(cdsDados.FieldByName('CON_CODHIP').AsString) then
        begin
          ///busca os dados do historico padrão para concatenar
          sHistoricoPadrao := fRetDescHistoricoPadrao(cdsDados.FieldByName('CON_CODHIP').AsString, cdsDados.FieldByName('CON_EMPLAN').AsString);
          qryLanCon.FieldByName('CON_HISTOR').AsString := sHistoricoPadrao +' '+trim(cdsDados.FieldByName('CON_HISTOR').AsString);
        end
        else
        begin
          qryLanCon.FieldByName('CON_HISTOR').AsString := cdsDados.FieldByName('CON_HISTOR').AsString;
        end;
        qryLanCon.FieldByName('CON_VALLAN').AsFloat := cdsDados.FieldByName('CON_VALLAN').AsFloat;
        qryLanCon.FieldByName('CON_CODOPE').AsString := strLoginUsuarioLogado;

        LstrCodEveDeb := fRetornaCentroCusto(LcdsPlancoInfo, qryLanCon.FieldByName('CON_CONDEB').AsString, cdsDados.FieldByName('CON_CCUSTO').AsString, cdsDados.FieldByName('CON_EMPLAN').AsString) ;
        LstrCodEveCre := fRetornaCentroCusto(LcdsPlancoInfo, qryLanCon.FieldByName('CON_CONCRE').AsString, cdsDados.FieldByName('CON_CCUSCR').AsString, cdsDados.FieldByName('CON_EMPLAN').AsString) ;
        if not fEmptyStr(LstrCodEveDeb) then
          qryLanCon.FieldByName('CON_CCUSTO').AsString := LstrCodEveDeb;
        if not fEmptyStr(LstrCodEveCre) then
          qryLanCon.FieldByName('CON_CCUSCR').AsString := LstrCodEveCre;

        qryLanCon.FieldByName('CON_C_G_C_').AsString := cdsDados.FieldByName('CON_C_G_C_').AsString;
        qryLanCon.FieldByName('CON_INCDOC').AsString := fGerarIncDocLanConManual ;

        if blnExisteCampoCON_VERSIS then
          qryLanCon.FieldByName('CON_VERSIS').AsString := VC_StrVersaoContabilidade;

        if blnExisteCampoCON_EMPLOG then
          qryLanCon.FieldByName('CON_EMPLOG').AsString := VS_strCodEmp;

        qryLanCon.Post;

        cdsDados.Next;
      end;

      fCommit;
      fMensagem('ATENÇÃO!', 'Gravação efetuada com sucesso!', ['&OK']);

      Result := true;
    except
      on E: Exception do
      begin
        Result := false;
        fRollBack;
        fMensagem('ATENÇÃO!', 'Erro ao efetuar gravação: ' + E.Message, ['&OK']);
      end;
    end;
  finally
    cdsDados.First;
    cdsDados.EnableControls;
    FreeAndNil(qryLanCon);
    FreeAndNil(LcdsPlancoInfo);
  end;
end;

function TfrmImportacaoContabil.fLerValorDoLayout(const ALayoutSelecionado: TLayoutImportacaoContabil; const AChave, AValor: string): string;
  var
    LPosicaoInicial : Integer;
    LTamanho : integer;
    LCodigoLayout : string;
    LLstChave: TStringList ;
    LIntCnt: integer ;
    LBlnSelecionado: boolean ;
    LChave: string ;
begin
  LCodigoLayout := ALayoutSelecionado.toCodigo;
  LChave := AChave ;
  LPosicaoInicial := 0 ;
  LTamanho := 0 ;
  /// verifica se há separador
  if pos(';',LChave) = 0 then
  begin
    LPosicaoInicial := fCampoTabela('LAY_POSINI', 'LYCONT', ['LAY_CODLAY', 'LAY_CODEMP', 'LAY_CODCAM'], [LCodigoLayout, VS_strCodEmp, LChave], False);
    LTamanho := fCampoTabela('LAY_TAMANH', 'LYCONT', ['LAY_CODLAY', 'LAY_CODEMP', 'LAY_CODCAM'], [LCodigoLayout, VS_strCodEmp, LChave], False);

    if not fParametroSelecionado(ALayoutSelecionado, LChave) then
    begin
      Exit('') ;
    end;

  end
  else
  begin
    LBlnSelecionado := False ;
    LLstChave := TStringList.Create ;
    try
      LLstChave.Delimiter := ';' ;
      LLstChave.StrictDelimiter := True ;
      LLstChave.DelimitedText := LChave ;
      for LIntCnt := 0 to LLstChave.Count-1 do
      begin

        LPosicaoInicial := fCampoTabela('LAY_POSINI', 'LYCONT', ['LAY_CODLAY', 'LAY_CODEMP', 'LAY_CODCAM'], [LCodigoLayout, VS_strCodEmp, LLstChave.Strings[LIntCnt]], False);
        LTamanho := fCampoTabela('LAY_TAMANH', 'LYCONT', ['LAY_CODLAY', 'LAY_CODEMP', 'LAY_CODCAM'], [LCodigoLayout, VS_strCodEmp, LLstChave.Strings[LIntCnt]], False);

        if fParametroSelecionado(ALayoutSelecionado, LLstChave.Strings[LIntCnt]) then
        begin
          LBlnSelecionado := True ;
          LChave := LLstChave.Strings[LIntCnt] ;
          break ;
        end;

      end;

      if not LBlnSelecionado then
      begin
        Exit('') ;
      end;

    finally
      FreeAndNil(LLstChave) ;
    end;
  end;

  if LPosicaoInicial = 0 then
    raise Exception.Create(Format('Posição inicial do campo %s não foi devidamente preenchido!', [LChave]));

  if LTamanho = 0 then
    raise Exception.Create(Format('Tamanho do campo %s não foi devidamente preenchido!', [LChave]));

  Result := Copy(AValor, LPosicaoInicial, LTamanho);
end;

procedure TfrmImportacaoContabil.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtArquivo);
end;

procedure TfrmImportacaoContabil.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados := fCriaCdsDados;
  dtsDados.DataSet := cdsDados;
  blnExisteTabelaLYCONT := fTabelaExiste('LYCONT');
  FValidarVigenciaCta := fTemVigencia;
  /////carrega as contas em uma tabela de memoria para verificação
  cdsPlancoVigencia := fCarregaPlancoVigencia ;

  blnExisteCampoCON_VERSIS := fCampoExiste('LANCON', 'CON_VERSIS');
  blnExisteCampoCON_EMPLOG := fCampoExiste('LANCON', 'CON_EMPLOG');
end;

procedure TfrmImportacaoContabil.FormDestroy(Sender: TObject);
begin
  pLiberaPlancoVigencia ;
  FreeAndNil(cdsDados);
  inherited;
end;

function TfrmImportacaoContabil.fParametroSelecionado(
  const ALayoutSelecionado: TLayoutImportacaoContabil; const AChave: string): boolean;
var
  LCodigoLayout : string;
begin
  if not fColunaExisteSeleci then
  begin
    Exit(True) ;
  end;
  LCodigoLayout := ALayoutSelecionado.toCodigo;
  Result := fCampoTabela('LAY_SELECI', 'LYCONT', ['LAY_CODLAY', 'LAY_CODEMP', 'LAY_CODCAM'], [LCodigoLayout, VS_strCodEmp, AChave], False) = 1;
end;

function TfrmImportacaoContabil.fProcessarDados(
  pgbProgresso: TcxProgressBar): Boolean;
  var
    stlArquivo : TStringList;
    intCnt : Integer;
    blnValidou : boolean;
    strMotivo : string;
    recDados: TrecDados;
begin
  stlArquivo := TStringList.Create;
  try
    btnGerar.Enabled := False;

    stlArquivo.LoadFromFile(edtArquivo.Text);

    if Assigned(pgbProgresso) then
      pgbProgresso.Properties.Max := stlArquivo.Count;

    cdsDados.EmptyDataSet;

    for intCnt := 0 to Pred(stlArquivo.Count) do
    begin
      if Assigned(pgbProgresso) then
      begin
        pgbProgresso.Position := intCnt+1;
        Application.ProcessMessages;
      end;

      pProcessarValores(stlArquivo.Strings[intCnt], recDados, fgetLayoutSelecionado);

      // --------------------------------------------------------------------- //

      pLimpaValorSeZerado(recDados.strContaDebito);
      pLimpaValorSeZerado(recDados.strContaCredito);
      pLimpaValorSeZerado(recDados.strCentroDeCustoDebito);
      pLimpaValorSeZerado(recDados.strCentroDeCustoCredito);
      pLimpaValorSeZerado(recDados.strCodigoHistoricoPadrao);

      blnValidou := fValidarDados(recDados, strMotivo);

      cdsDados.Insert;

      if fDataValida(recDados.dtaDtaLan) then
        cdsDados.FieldByName('CON_DTALAN').AsDateTime := recDados.dtaDtaLan;

      cdsDados.FieldByName('CON_EMPLAN').AsString := recDados.strCodEmp;
      cdsDados.FieldByName('CON_CONDEB').AsString := recDados.strContaDebito;
      cdsDados.FieldByName('CON_CTRDDB').AsBoolean := recDados.blnContaDebitoRed ;
      cdsDados.FieldByName('CON_CONCRE').AsString := recDados.strContaCredito;
      cdsDados.FieldByName('CON_CTRDCR').AsBoolean := recDados.blnContaCreditoRed ;
      cdsDados.FieldByName('CON_VALLAN').AsFloat  := StrToFloatDef(recDados.strValor, 0) / 100;
      cdsDados.FieldByName('CON_HISTOR').AsString := recDados.strHistorico;
      cdsDados.FieldByName('CON_CCUSTO').AsString := recDados.strCentroDeCustoDebito;
      cdsDados.FieldByName('CON_CCUSCR').AsString := recDados.strCentroDeCustoCredito;
      cdsDados.FieldByName('CON_C_G_C_').AsString := recDados.strCnpj;
      cdsDados.FieldByName('CON_VALIDO').AsString := IIF(blnValidou, 'S', 'N');
      cdsDados.FieldByName('CON_MOTIVO').AsString := strMotivo;
      cdsDados.FieldByName('CON_CODHIP').AsString := recDados.strCodigoHistoricoPadrao;
      cdsDados.Post;

      if (blnValidou) and (not btnGerar.Enabled) then
        btnGerar.Enabled := True;

      if (not blnValidou) and (not lblInfoDetal.Visible) then
        lblInfoDetal.Visible := True;
    end;

    cdsDados.First;

    Result := true;
  finally
    FreeAndNil(stlArquivo);
  end;
end;

function TfrmImportacaoContabil.FTemContaReduzida(
  const ALayoutSelecionado: TLayoutImportacaoContabil;
  const AChave: string): boolean;
begin
  Result := False ;
  if fCfgRpCtRd = 'S' then
  begin
    exit ;
  end;

  Result := fParametroSelecionado(ALayoutSelecionado, AChave) ;
end;

function TfrmImportacaoContabil.fTemLayoutConfigurado(const ALayout: TLayoutImportacaoContabil): boolean;
begin
  Result := True;

  if not blnExisteTabelaLYCONT then
    Exit(False);

  if (fCampoTabela('COUNT(*)', 'LYCONT', ['LAY_CODLAY', 'LAY_CODEMP'], [ALayout.toCodigo, VS_strCodEmp], False) = 0) then
    Exit(False);
end;

function TfrmImportacaoContabil.fTemParametroSelecionado(
  const ALayoutSelecionado: TLayoutImportacaoContabil): boolean;
begin
  if not fColunaExisteSeleci then
  begin
    Exit(True) ;
  end;

  result := fCampoTabela('COUNT(*)', 'LYCONT', ['LAY_CODLAY', 'LAY_CODEMP', 'LAY_SELECI'], [ALayoutSelecionado.toCodigo, VS_strCodEmp, 1], False) > 0 ;
end;

function TfrmImportacaoContabil.fValidaCentroDeCusto(
  strCCusto: string): boolean;
begin
  Result := True;

  if fEmptyStr(strCCusto) then
    exit;

  Result := not fEmptyStr(fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [strCCusto], False));
end;

function TfrmImportacaoContabil.fValidaHistoricoPadrao(
  strCHistoricoPadrao, strCodEmp: string): boolean;
begin
  Result := True;

  if fEmptyStr(strCHistoricoPadrao) then
    exit;

  Result := not fEmptyStr(fRetDescHistoricoPadrao(strCHistoricoPadrao, strCodEmp));
end;

function TfrmImportacaoContabil.fValidaConta(strConta: string; AStrCodEmp: string; const ABlnContaReduzida: boolean): boolean;
var
  strTplAco: string ;
begin
  Result := True;

  if fEmptyStr(strConta) then
    exit;

  strTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [AStrCodEmp], False);
  if ABlnContaReduzida then
  begin
    Result := not fEmptyStr(fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CONRED', 'NCO_TPLACO'], [strConta, strTplAco], False));
  end
  else
  begin
    Result := not fEmptyStr(fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON', 'NCO_TPLACO'], [strConta, strTplAco], False));
  end;
end;

function TfrmImportacaoContabil.fValidaEmpresa(strCodEmp: string): boolean;
begin
  Result := False;

  if fEmptyStr(strCodEmp) then
    exit;

  Result := not fEmptyStr(fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [strCodEmp], False));
end;

function TfrmImportacaoContabil.fValidarDados(recDados: TrecDados; var strMotivo: string): boolean;
var
  strMensagemValidacao : String ;
  blnData : Boolean ;
  blnEmpresa : Boolean ;
begin
  Result := True;
  strMotivo := '';

  blnEmpresa := fValidaEmpresa(recDados.strCodEmp) ;
  if not blnEmpresa then
  begin
    Result := False;
    strMotivo := strMotivo + 'Código da Empresa inválido' + sLineBreak;
  end;

  if not fValidaConta(recDados.strContaDebito, recDados.strCodEmp, recDados.blnContaDebitoRed) then
  begin
    Result := False;
    strMotivo := strMotivo + iif(recDados.blnContaDebitoRed, 'Conta reduzida de débito inválida', 'Conta de débito inválida') + sLineBreak;
  end;

  if not fValidaConta(recDados.strContaCredito, recDados.strCodEmp, recDados.blnContaCreditoRed) then
  begin
    Result := False;
    strMotivo := strMotivo + iif(recDados.blnContaCreditoRed, 'Conta reduzida de crédito inválida', 'Conta de crédito inválida') + sLineBreak;
  end;

  if fEmptyStr(recDados.strContaDebito + recDados.strContaCredito) then
  begin
    Result := False;
    strMotivo := strMotivo + 'Ao menos uma conta precisa ser preenchida (crédito/débito em branco)' + sLineBreak;
  end;

  if not fValidaCentroDeCusto(recDados.strCentroDeCustoDebito) then
  begin
    Result := False;
    strMotivo := strMotivo + 'Centro de custo de débito inválido' + sLineBreak;
  end;

  if not fValidaCentroDeCusto(recDados.strCentroDeCustoCredito) then
  begin
    Result := False;
    strMotivo := strMotivo + 'Centro de custo de crédito inválido' + sLineBreak;
  end;

  blnData := True ;
  if not fDataValida(recDados.dtaDtaLan) then
  begin
    blnData := False ;
    Result := False;
    strMotivo := strMotivo + 'Data de lançamento inválida' + sLineBreak;
  end;

  if (blnData) and (not fVerificaPlancoVigencia(cdsPlancoVigencia,
                                 recDados.dtaDtaLan,
                                 recDados.strContaCredito,
                                 strMensagemValidacao,
                                 recDados.strCodEmp)) then
  begin
    Result := False;
    strMotivo := strMotivo + strMensagemValidacao + sLineBreak;
  end ;

  if (blnData) and (not fVerificaPlancoVigencia(cdsPlancoVigencia,
                                 recDados.dtaDtaLan,
                                 recDados.strContaDebito,
                                 strMensagemValidacao,
                                 recDados.strCodEmp)) then
  begin
    Result := False;
    strMotivo := strMotivo + strMensagemValidacao + sLineBreak;
  end ;

  if (blnData) and (blnEmpresa) and (fLancamentoAnteriorFechamento(recDados.dtaDtaLan, recDados.strCodEmp, strMensagemValidacao)) then
  begin
    Result := False;
    strMotivo := strMotivo + strMensagemValidacao + sLineBreak;
  end ;

  if (not fEmptyStr(recDados.strCNPJ)) and (not fValidaCnpjCpf(recDados.strCNPJ, False)) then
  begin
    Result := False;
    strMotivo := strMotivo + 'CNPJ inválido' + sLineBreak;
  end;

  if not fValidaHistoricoPadrao(recDados.strCodigoHistoricoPadrao, recDados.strCodEmp) then
  begin
    Result := False;
    strMotivo := strMotivo + 'Código histórico padrão inválido' + sLineBreak;
  end;

end;

procedure TfrmImportacaoContabil.pLimpaValorSeZerado(var AValor: string);
begin
  if fStringZerada(AValor) then
    AValor := '';
end;

procedure TfrmImportacaoContabil.pProcessarValores(const AValor: string; var recDados: TrecDados; const ALayoutSelecionado: TLayoutImportacaoContabil);
begin
  FillChar(recDados, SizeOf(recDados), #0);

  if (not fTemLayoutConfigurado(ALayoutSelecionado)) then
  begin
    recDados.dtaDtaLan := fDataLayToDate(AValor);

    recDados.strCodEmp := Trim(Copy(AValor, 10, 3));

    recDados.strContaDebito := Trim(Copy(AValor, 13, 12));
    recDados.blnContaDebitoRed := False ;
    recDados.strCentroDeCustoDebito := fStrZero(Trim(Copy(AValor, 29, 4)), 5);

    recDados.strContaCredito := Trim(Copy(AValor, 33, 12));
    recDados.blnContaCreditoRed := False ;
    recDados.strCentroDeCustoCredito := fStrZero(Trim(Copy(AValor, 48, 4)), 5);

    recDados.strHistorico := Trim(Copy(AValor, 54, 200));
    recDados.strValor := Trim(Copy(AValor, 254, 16));
    recDados.strCnpj := Trim(Copy(AValor, 270, 14));
    recDados.strCodigoHistoricoPadrao := Trim(Copy(AValor, 284, 5));
  end
  else
  begin
    recDados.dtaDtaLan := fDataLayToDate(fLerValorDoLayout(ALayoutSelecionado, 'DTALAN', AValor));
    recDados.strCodEmp := Trim(fLerValorDoLayout(ALayoutSelecionado, 'CODEMP', AValor));
    recDados.strContaDebito := Trim(fLerValorDoLayout(ALayoutSelecionado, 'CONDEB;CTRDDB', AValor));
    recDados.blnContaDebitoRed := FTemContaReduzida(ALayoutSelecionado, 'CTRDDB') ;
    recDados.strCentroDeCustoDebito := fStrZero(Trim(fLerValorDoLayout(ALayoutSelecionado, 'CCUDEB', AValor)), 5);
    recDados.strContaCredito := Trim(fLerValorDoLayout(ALayoutSelecionado, 'CONCRE;CTRDCR', AValor));
    recDados.blnContaCreditoRed := FTemContaReduzida(ALayoutSelecionado, 'CTRDCR') ;
    recDados.strCentroDeCustoCredito := fStrZero(Trim(fLerValorDoLayout(ALayoutSelecionado, 'CCUCRE', AValor)), 5);
    recDados.strHistorico := Trim(fLerValorDoLayout(ALayoutSelecionado, 'HISTOR', AValor));
    recDados.strValor := Trim(fLerValorDoLayout(ALayoutSelecionado, 'VALLAN', AValor));
    ///caso não encontre o campo configurado será ignorado a leitura do campo
    if fTemLinhaCodHpd(ALayoutSelecionado) then
      recDados.strCodigoHistoricoPadrao := fStrZero(Trim(fLerValorDoLayout(ALayoutSelecionado, 'CODHPD', AValor)), 5);
  end;
end;

procedure TfrmImportacaoContabil.pLiberaPlancoVigencia;
begin
  if not FValidarVigenciaCta then
  begin
    exit ;
  end;

  if assigned(cdsPlancoVigencia) then
    FreeAndNil(cdsPlancoVigencia);
end;

end.
