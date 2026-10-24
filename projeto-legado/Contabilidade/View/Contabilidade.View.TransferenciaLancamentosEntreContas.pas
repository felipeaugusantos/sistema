unit Contabilidade.View.TransferenciaLancamentosEntreContas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  ComboBoxFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, untTypesSistema,
  Contabilidade.Classes.TransferenciaLancamentosEntreContas, Datasnap.DBClient,
  UniClientDataSet, untGeraExcel, untExcel, Contabilidade.Classes.FechamentoDiaMes,
  cxCurrencyEdit, System.Generics.Collections;

type
  TfrmTransfLancEntreContas = class(TfrmPaiConfirmaContabilidade)
    gbFiltros: TGroupBox;
    edtEmpLan: TEditFocus;
    Label15: TLabel;
    edtNomEmp: TEditFocus;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lbTipLan: TLabel;
    edtTipLan: TComboBoxFocus;
    rdgLancamentos: TRadioGroup;
    Label12: TLabel;
    mskContaOriginal: TMaskEditFocus;
    edtConOriRed: TEditFocus;
    edtDesContaOriginal: TEditFocus;
    pnlDados: TPanel;
    btnAbrir: TBitBtnLocked;
    pnlContaTransf: TPanel;
    GridTab: TcxGridDBTableViewCitel;
    GridLevel: TcxGridLevel;
    Grid: TcxGridCitel;
    dsTransferencia: TDataSource;
    Label1: TLabel;
    mskContaTransferida: TMaskEditFocus;
    edtConTraRed: TEditFocus;
    edtDesContaTransferida: TEditFocus;
    GridTabAUTOINCREM: TcxGridDBColumn;
    GridTabCON_EMPLAN: TcxGridDBColumn;
    GridTabCON_DTALAN: TcxGridDBColumn;
    GridTabCON_TIPLAN: TcxGridDBColumn;
    GridTabCON_DESVAL: TcxGridDBColumn;
    GridTabCON_CONCRE: TcxGridDBColumn;
    GridTabCON_DESCRE: TcxGridDBColumn;
    GridTabCON_CONDEB: TcxGridDBColumn;
    GridTabCON_DESDEB: TcxGridDBColumn;
    GridTabCON_HISTOR: TcxGridDBColumn;
    GridTabCON_VALLAN: TcxGridDBColumn;
    btnExportar: TBitBtnLocked;
    procedure edtEmpLanKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mskContaOriginalKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaTransferidaKeyPress(Sender: TObject; var Key: Char);
    procedure btnAbrirClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExportarClick(Sender: TObject);
  private
    { Private declarations }
    FblnExisteCampoNCO_NATURE: boolean ;
    FdsTransferenciaContas: TDataSet ;
    FarrEmp: TConsultasArray;
    FcdsPlancoVigencia: TUniClientDataSet;
    FDicAutoIncrem: TDictionary<string, Boolean>;
    procedure pCarregaTipoContabeisTransferencia ;
    procedure pSelecionaUltimoTipoContabil ;
    procedure pCarregaPlanoContabilOrigem(const AblnBuscaPorChave: Boolean=False; AblnCampoContaReduzida: Boolean=False);
    procedure pCarregaPlanoContabilTransferida(const AblnBuscaPorChave: Boolean=False; AblnCampoContaReduzida: Boolean=False);
    procedure pHabilitaTransferencia(const AblnHabilitar: Boolean) ;
    procedure pLimpaTransferencia ;
    function fCarregaDados: Boolean ;
    function fGravaDados: Boolean ;
    function fTrataTipLan: String ;
    function fPeriodoInformadoPertenceAoMesmoExercicio(const AdtaIni, AdtaFin: TDateTime): Boolean ;
    function fOutrasValidacoesContabilidade: Boolean ;
    procedure pAjustaArrayEmpresas ;
    function fRetornaListaAutoInc(const AstrPlanoContabilOriginal: String): TListInfoAutoIncTransf ;
    function fValidadosAntesGravar: Boolean ;
    function fValidaVigenciaPlanoContas: Boolean ;
    procedure OnGeraExcel(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    function fValidaContasIguais: Boolean;
    function fEhLancPartidaSimplesUtilizandoContraContrapartida(AAutoInc: string; AContaAlterada:string) : Boolean;
    function fValidaLancPartidaSimplesUtilizandoContraContrapartida: Boolean;
    function fValidaContaTransferida: boolean;
    procedure pFiltroContasIguais(DataSet: TDataSet; var Accept: Boolean);
    procedure pFiltroLancPartidaSimples(DataSet: TDataSet; var Accept: Boolean);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmTransfLancEntreContas: TfrmTransfLancEntreContas;

implementation

uses untFuncoesSimples, Contabilidade.Consultas, untConsultas,
     Contabilidade.Funcoes, DateUtils, Uni,
     Contabilidade.View.Lancamentoscontabeis ;

{$R *.dfm}

{ TfrmTransfLancEntreContas }

procedure TfrmTransfLancEntreContas.btnAbrirClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  if Not fOutrasValidacoesContabilidade then
    Exit ;

  if fCarregaDados then
  begin
    if FdsTransferenciaContas.IsEmpty then
    begin
      pMensagemOk('Nenhuma informação encontrada!');
      pSetFocus(edtEmpLan) ;
      exit ;
    end
    else
    begin
      pHabilitaTransferencia(True);
      pSetFocus(Grid) ;
    end ;
  end
  else
    pMensagemOk('Problemas ao realizar consulta!');
end;

procedure TfrmTransfLancEntreContas.btnConfirmaClick(Sender: TObject);
begin
  If Not fValidaContaTransferida Then
    Exit;

  if not fValidadosAntesGravar then
    Exit ;

  if fGravaDados then
  begin
    pMensagemOk('Transferência efetuada com sucesso!');
    pHabilitaTransferencia(False);
    pLimpaTransferencia ;
    pSetFocus(edtEmpLan) ;
  end
  else
    pMensagemOk('Problemas ao gravar dados!');

end;

procedure TfrmTransfLancEntreContas.btnExportarClick(Sender: TObject);
begin
  inherited;

  if (not Assigned(FdsTransferenciaContas)) or FdsTransferenciaContas.IsEmpty then
    Exit;

  if TGeraExcel.fGerarRelatorio(GridTab, 'Transferência de Lançamentos entre Contas', OnGeraExcel) then
    fMensagem('','Arquivo Salvo com Sucesso!', ['&OK']);
end;

procedure TfrmTransfLancEntreContas.btnSairClick(Sender: TObject);
begin
  pHabilitaTransferencia(False);
  pLimpaTransferencia ;
  pSetFocus(edtEmpLan) ;
end;

procedure TfrmTransfLancEntreContas.edtEmpLanKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpLan, edtNomEmp, Nil, Key, arrEmpSel, False) Then
  Begin
    If fValidaCampos(edtEmpLan) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmTransfLancEntreContas.fCarregaDados: Boolean;
var
  LParams: TParametrosTransferenciaLancamentosEntreContas ;
begin
  FillChar(LParams, SizeOf(TParametrosTransferenciaLancamentosEntreContas), #0);
  LParams.CodEmp := edtEmpLan.Text ;
  LParams.DataInicio := StrToDate(mskDtaIni.Text) ;
  LParams.DataFinal := StrToDate(mskDtaFin.Text) ;
  LParams.TipLan := fTrataTipLan ;
  LParams.FormaPesq := TFormaPesquisaLancon(rdgLancamentos.ItemIndex) ;
  LParams.Planco := fSemMascaraPlaNco(mskContaOriginal.Text) ;

  Result := TTransferenciaLancamentosEntreContas.fCarregarDados(FdsTransferenciaContas, LParams) ;

  if Result then
  begin
    dsTransferencia.Enabled := False ;
    try
      dsTransferencia.DataSet := Nil ;
      dsTransferencia.DataSet := FdsTransferenciaContas ;
    finally
      dsTransferencia.Enabled := True ;
    end ;

  end ;

end;

function TfrmTransfLancEntreContas.fGravaDados: Boolean;
var
  LstrContaContabil, LstrContaContabilOriginal: String;
  LListInfoLancon: TListInfoAutoIncTransf ;
begin
  LstrContaContabil := fSemMascaraPlaNco(mskContaTransferida.Text) ;
  LstrContaContabilOriginal := fSemMascaraPlaNco(mskContaOriginal.Text) ;
  LListInfoLancon   := fRetornaListaAutoInc(LstrContaContabilOriginal) ;
  try
    if LListInfoLancon.Count > 0 then
    begin
      Result := TTransferenciaLancamentosEntreContas.fGravaDados(LstrContaContabil,
                                                                 LstrContaContabilOriginal,
                                                                 LListInfoLancon);
    end
    else
      Result := False;

  finally
    FreeAndNil(LListInfoLancon) ;
  end ;
end;

procedure TfrmTransfLancEntreContas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(FdsTransferenciaContas) then
    FreeAndNil(FdsTransferenciaContas) ;

  FreeAndNil(FcdsPlancoVigencia) ;
end;

procedure TfrmTransfLancEntreContas.FormCreate(Sender: TObject);
var
  LstrMascara: String ;
begin
  inherited;
  FdsTransferenciaContas := Nil ;
  FcdsPlancoVigencia := fCarregaPlancoVigencia ;
  pCarregaTipoContabeisTransferencia ;
  FblnExisteCampoNCO_NATURE := fCampoExiste('PLANCO', 'NCO_NATURE');

  LstrMascara := fMskCon;
  mskContaOriginal.EditMask := LstrMascara;
  mskContaTransferida.EditMask := LstrMascara;
  pHabilitaTransferencia(False);
end;

procedure TfrmTransfLancEntreContas.FormShow(Sender: TObject);
begin
  inherited;
  pSelecionaUltimoTipoContabil ;
end;

function TfrmTransfLancEntreContas.fOutrasValidacoesContabilidade: Boolean;
var
  LdtaIni, LdtaFin: TDateTime ;
begin
  Result := False  ;
  LdtaIni := StrToDate(mskDtaIni.Text) ;
  LdtaFin := StrToDate(mskDtaFin.Text) ;

  if not fPeriodoInformadoPertenceAoMesmoExercicio(LdtaIni, LdtaFin) then
    Exit ;

  pAjustaArrayEmpresas ;
  if fTemFechamento(LdtaIni, LdtaFin, FarrEmp) then
    Exit ;

  if TVerificaFechamentoDiaMes.fTemFechamento(LdtaIni, LdtaFin, FarrEmp, False) then
    Exit;

  Result := True ;
end;

function TfrmTransfLancEntreContas.fPeriodoInformadoPertenceAoMesmoExercicio(
  const AdtaIni, AdtaFin: TDateTime): Boolean;
var
  LintAnoIni, LintAnoFin: Integer ;
begin
  LintAnoIni := YearOf(AdtaIni) ;
  LintAnoFin := YearOf(AdtaFin) ;
  Result := LintAnoIni = LintAnoFin ;
  if not Result then
    fMensagem('ATENÇÃO!', 'O período informado deve contemplar o mesmo ano!', ['&O k']);

end;

function TfrmTransfLancEntreContas.fRetornaListaAutoInc(const AstrPlanoContabilOriginal: String): TListInfoAutoIncTransf;
var
  LlstAutoInc: TListInfoAutoIncTransf ;
  LItem: TInfoAutoIncTransf ;
  LintCount, LintSelecionados: Integer;

begin

  FdsTransferenciaContas.DisableControls ;
  try
    LlstAutoInc := TListInfoAutoIncTransf.Create();

    if GridTab.DataController.GetSelectedCount > 0 then
    Begin
      LintSelecionados := GridTab.ViewData.DataController.GetSelectedCount;

      for LintCount := 0 to LintSelecionados - 1 do
      begin
        FdsTransferenciaContas.RecNo := GridTab.DataController.GetSelectedRowIndex(LintCount) + 1;

        LItem := TInfoAutoIncTransf.Create;
        try
          LItem.AutoIncrem := FdsTransferenciaContas.FieldByName('AUTOINCREM').AsString;
          if FdsTransferenciaContas.FieldByName('CON_CONDEB').AsString = AstrPlanoContabilOriginal then
            LItem.CreDeb := 'D'
          else if FdsTransferenciaContas.FieldByName('CON_CONCRE').AsString = AstrPlanoContabilOriginal then
            LItem.CreDeb := 'C';
          LlstAutoInc.Add(LItem);
        except
          FreeAndNil(LItem);
          raise;
        end;

      end;

    End;

  finally
    FdsTransferenciaContas.EnableControls ;
  end ;

  Result := LlstAutoInc ;
end;

function TfrmTransfLancEntreContas.fTrataTipLan: String;
begin
  if edtTipLan.ItemIndex = edtTipLan.Items.Count-1 then
    Result := ''
  else
    Result := copy(edtTipLan.Text, 1, 3) ;
end;

function TfrmTransfLancEntreContas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  LstrTplaco: String ;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End
      else if not fDataValida(StrToDate(mskDtaIni.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'Data Inicial inválida!', ['&O k']);
        Result := False;
      end;
    End

    Else If (Sender = mskDtaFin) Then
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
      else if not fDataValida(StrToDate(mskDtaFin.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'Data final inválida!', ['&O k']);
        Result := False;
      end;
    End

    Else If (Sender = edtEmpLan) Then
    Begin
      edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpLan.Text], False);
      If (fEmptyStr(edtNomEmp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = edtTipLan) Then
    Begin
      if fEmptyStr(edtTipLan.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Tipo de Lançamento deve ser preenchido!', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = mskContaOriginal) Then
    Begin
      pCarregaPlanoContabilOrigem(blnBuscaPorChave) ;
      If (Not fEmptyStr(fSemMascaraPlaNco(mskContaOriginal.Text))) And (fEmptyStr(edtDesContaOriginal.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Conta Contábil Original Inválida!',['&OK']);
        Result := False;
        exit;
      end
      else if (FblnExisteCampoNCO_NATURE) and (Not fEmptyStr(fSemMascaraPlaNco(mskContaOriginal.Text))) then
      begin
        LstrTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
        if (fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaOriginal.Text), LstrTplaco]) = 'S') then
        begin
          fMensagem('ATENÇÃO!','Conta de natureza sintética(Conta Original) não pode ser selecionada para o lançamento!',['&OK']);
          Result := False;
          exit;
        end;
      end;
      If (fEmptyStr(edtDesContaOriginal.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Conta contábil original não foi informada!', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = mskContaTransferida) Then
    Begin
      pCarregaPlanoContabilTransferida(blnBuscaPorChave) ;
      If (Not fEmptyStr(fSemMascaraPlaNco(mskContaTransferida.Text))) And (fEmptyStr(edtDesContaTransferida.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Conta Contábil Inválida!',['&OK']);
        Result := False;
      end
      else if (FblnExisteCampoNCO_NATURE) and (Not fEmptyStr(fSemMascaraPlaNco(mskContaTransferida.Text))) then
      begin
        LstrTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
        if (fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaTransferida.Text), LstrTplaco]) = 'S') then
        begin
          fMensagem('ATENÇÃO!','Conta de natureza sintética não pode ser selecionada para o lançamento!',['&OK']);
          Result := False;
        end;
      end;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmTransfLancEntreContas.fValidaContaTransferida: Boolean;
var
  LstrTplaco: String ;

begin
  Result := true;
  pCarregaPlanoContabilTransferida(true) ;
  If (Not fEmptyStr(fSemMascaraPlaNco(mskContaTransferida.Text))) And (fEmptyStr(edtDesContaTransferida.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','Conta Contábil transferida Inválida!',['&OK']);
    Result := False;
    exit;
  end
  else if (FblnExisteCampoNCO_NATURE) and (Not fEmptyStr(fSemMascaraPlaNco(mskContaTransferida.Text))) then
  begin
    LstrTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    if (fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaTransferida.Text), LstrTplaco]) = 'S') then
    begin
      fMensagem('ATENÇÃO!','Conta de natureza sintética(Conta Transferida) não pode ser selecionada para o lançamento!',['&OK']);
      Result := False;
      exit;
    end;
  end;
  If (fEmptyStr(edtDesContaTransferida.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Conta contábil transferida não foi informada!', ['&Ok']);
    Result := False;
  end;
end;

function TfrmTransfLancEntreContas.fValidaContasIguais: Boolean;
var
  LcdsTransferenciaContas: TUniClientDataset;
  LintCount, LintSelecionados: Integer;
begin
  FDicAutoIncrem := TDictionary<string, Boolean>.Create;
  try
    LcdsTransferenciaContas := nil;
    FdsTransferenciaContas.DisableControls;
    try
      LintSelecionados := GridTab.ViewData.DataController.GetSelectedCount;
      for LintCount := 0 to LintSelecionados - 1 do
      begin
        FdsTransferenciaContas.RecNo := GridTab.DataController.GetSelectedRowIndex(LintCount) + 1;
        FDicAutoIncrem.AddOrSetValue(
          FdsTransferenciaContas.FieldByName('AUTOINCREM').AsString, True);
      end;
    finally
      FdsTransferenciaContas.EnableControls;
    end;

    LcdsTransferenciaContas := fCriaClientDatset(FdsTransferenciaContas);
    LcdsTransferenciaContas.IndexFieldNames := 'AUTOINCREM';
    LcdsTransferenciaContas.Open;

    LcdsTransferenciaContas.OnFilterRecord := pFiltroContasIguais;
    LcdsTransferenciaContas.Filtered := True;

    Result := LcdsTransferenciaContas.IsEmpty;
    if Result then
      Exit;

    if fMensagem('ATENÇÃO!', 'A transferência não poderá ser efetuada, pois existem lançamentos que, ' +
      'após o processo, passariam a ter a mesma conta para crédito e débito.' + #13#10 +
      'Deseja visualizar os lançamentos ?', ['&Sim', '&Não']) = 1 then
      pMostraLancamentosContabeis(TDataset(LcdsTransferenciaContas),
        'Lançamentos Contábeis que passariam a ter a mesma Conta para Crédito e Débito');
  finally
    if Assigned(LcdsTransferenciaContas) then
      FreeAndNil(LcdsTransferenciaContas);
    FreeAndNil(FDicAutoIncrem);
  end;
end;

procedure TfrmTransfLancEntreContas.pFiltroContasIguais(
  DataSet: TDataSet; var Accept: Boolean);
var
  LConDeb, LConCre, LOrig, LTransf: string;
begin
  LOrig    := fSemMascaraPlaNco(mskContaOriginal.Text);
  LTransf  := fSemMascaraPlaNco(mskContaTransferida.Text);
  LConDeb  := DataSet.FieldByName('CON_CONDEB').AsString;
  LConCre  := DataSet.FieldByName('CON_CONCRE').AsString;

  Accept := Assigned(FDicAutoIncrem) and
    FDicAutoIncrem.ContainsKey(DataSet.FieldByName('AUTOINCREM').AsString)
    and
    ( ((LConDeb = LOrig)   and (LConCre = LTransf)) or
      ((LConCre = LOrig)   and (LConDeb = LTransf)) );
end;

function TfrmTransfLancEntreContas.fEhLancPartidaSimplesUtilizandoContraContrapartida(AAutoInc: string; AContaAlterada:string) : Boolean;
var LqryLan: TUniQuery;
begin
  Result := False;
  LqryLan := fCriaQuery ;
  Try
    LqryLan.Close;
    LqryLan.SQL.Clear;
    LqryLan.SQL.Add(' SELECT B.AUTOINCREM, B.CON_EMPLAN, B.CON_DTALAN, B.CON_TIPLAN, B.CON_DESVAL, B.CON_CONCRE, B.CON_CONDEB, B.CON_VALLAN, B.CON_HISTOR');
    LqryLan.SQL.Add(' FROM LANCON B,');
    LqryLan.SQL.Add('  (SELECT A.CON_EMPLAN, A.CON_TIPLAN, COALESCE(CON_TABELA,"") CON_TABELA, CON_INCDOC');
    LqryLan.SQL.Add('   FROM LANCON A');
    LqryLan.SQL.Add('   WHERE AUTOINCREM = :AUTOINCREM');
    LqryLan.SQL.Add('   AND (CON_CONCRE IS NULL OR CON_CONDEB IS NULL)) C');
    LqryLan.SQL.Add(' WHERE B.CON_INCDOC = C.CON_INCDOC');
    LqryLan.SQL.Add(' AND B.CON_TIPLAN = C.CON_TIPLAN');
    LqryLan.SQL.Add(' AND COALESCE(B.CON_TABELA,"")  = C.CON_TABELA');
    LqryLan.SQL.Add(' AND B.CON_EMPLAN = C.CON_EMPLAN');

    LqryLan.ParamByName('AUTOINCREM').AsString := AAutoInc ;
    LqryLan.Open ;

    if LqryLan.RecordCount > 1 then
    begin
      while not (LqryLan.Eof) do
      begin
        if (LqryLan.FieldByName('CON_CONCRE').AsString <> '') and (LqryLan.FieldByName('CON_CONCRE').AsString = AContaAlterada) then
        begin
          Result := true;
          break;
        end;
        if (LqryLan.FieldByName('CON_CONDEB').AsString <> '') and (LqryLan.FieldByName('CON_CONDEB').AsString = AContaAlterada) then
        begin
          Result := true;
          break;
        end;
        LqryLan.Next;
      end;
    end;
  Finally
    FreeAndNil(LqryLan);
  End;

end;

function TfrmTransfLancEntreContas.fValidaLancPartidaSimplesUtilizandoContraContrapartida: Boolean;
var
  LcdsTransferenciaContas: TUniClientDataset;
  LfrmLancamentosContabeis: TfrmLancamentosContabeis;
  LintCount, LintSelecionados: Integer;
  LstrAutoIncrem, LstrContaTransf: string;
begin
  Result := True;
  LcdsTransferenciaContas := nil;
  LfrmLancamentosContabeis := nil;
  FDicAutoIncrem := TDictionary<string, Boolean>.Create;
  try
    LstrContaTransf := fSemMascaraPlaNco(mskContaTransferida.Text);

    FdsTransferenciaContas.DisableControls;
    try
      LintSelecionados := GridTab.ViewData.DataController.GetSelectedCount;
      for LintCount := 0 to LintSelecionados - 1 do
      begin
        FdsTransferenciaContas.RecNo :=
          GridTab.DataController.GetSelectedRowIndex(LintCount) + 1;

        LstrAutoIncrem := FdsTransferenciaContas.FieldByName('AUTOINCREM').AsString;

        if fEhLancPartidaSimplesUtilizandoContraContrapartida(LstrAutoIncrem, LstrContaTransf) then
          FDicAutoIncrem.AddOrSetValue(LstrAutoIncrem, True);
      end;
    finally
      FdsTransferenciaContas.EnableControls;
    end;

    if FDicAutoIncrem.Count = 0 then
      Exit;

    LcdsTransferenciaContas := fCriaClientDatset(FdsTransferenciaContas);
    LcdsTransferenciaContas.IndexFieldNames := 'AUTOINCREM';
    LcdsTransferenciaContas.Open;

    LcdsTransferenciaContas.OnFilterRecord := pFiltroLancPartidaSimples;
    LcdsTransferenciaContas.Filtered := True;

    Result := LcdsTransferenciaContas.IsEmpty;
    if Result then
      Exit;

    if fMensagem('ATENÇÃO!',
      'A transferência não poderá ser efetuada, pois existem lançamentos de partida simples que, ' +
      'após o processo, passariam a ter a mesma conta para crédito ou débito do lançamento de contrapartida.' + #13#10 +
      'Deseja visualizar os lançamentos ?', ['&Sim', '&Não']) = 1 then
    begin
      try
        pCriarFormularios(TfrmLancamentosContabeis, LfrmLancamentosContabeis);
        LfrmLancamentosContabeis.Caption :=
          'Lançamentos Contábeis que passariam a ter a mesma Conta para Crédito e Débito do lançamento de contrapartida';
        LfrmLancamentosContabeis.pApontarDataset(TDataset(LcdsTransferenciaContas));
        LfrmLancamentosContabeis.ShowModal;
      finally
        if Assigned(LfrmLancamentosContabeis) then
          FreeAndNil(LfrmLancamentosContabeis);
      end;
    end;
  finally
    if Assigned(LcdsTransferenciaContas) then
      FreeAndNil(LcdsTransferenciaContas);
    FreeAndNil(FDicAutoIncrem);
  end;
end;

procedure TfrmTransfLancEntreContas.pFiltroLancPartidaSimples(
  DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := Assigned(FDicAutoIncrem) and
            FDicAutoIncrem.ContainsKey(DataSet.FieldByName('AUTOINCREM').AsString);
end;

function TfrmTransfLancEntreContas.fValidadosAntesGravar: Boolean;
begin
  Result := False ;

  if not Assigned(FdsTransferenciaContas) then
  begin
    fMensagem('ATENÇÃO!','Dados para transferência de contas não associado!',['&OK']);
    Exit ;
  end ;

  if FdsTransferenciaContas.IsEmpty then
  begin
    fMensagem('ATENÇÃO!','Dados para transferência de contas vazio!',['&OK']);
    Exit ;
  end ;

  if GridTab.DataController.GetSelectedCount = 0 then
  begin
    fMensagem('ATENÇÃO!','É necessário marcar pelo menos um lançamento!',['&OK']);
    Exit ;
  end ;

  if not fValidaVigenciaPlanoContas then
    Exit ;

  if not fValidaContasIguais then
    Exit;

  if not fValidaLancPartidaSimplesUtilizandoContraContrapartida then
    Exit;

  Result := True ;
end;

function TfrmTransfLancEntreContas.fValidaVigenciaPlanoContas: Boolean;
var
  LstrMensagemValidacao: String ;
  LintCount, LintSelecionados: Integer;

begin
  FdsTransferenciaContas.DisableControls ;
  try
    LintSelecionados := GridTab.ViewData.DataController.GetSelectedCount;
    for LintCount := 0 to LintSelecionados - 1 do
    begin
      FdsTransferenciaContas.RecNo := GridTab.DataController.GetSelectedRowIndex(LintCount) + 1;

      if not fVerificaPlancoVigencia(FcdsPlancoVigencia,
                                     FdsTransferenciaContas.FieldByName('CON_DTALAN').AsDateTime,
                                     fSemMascaraPlaNco(mskContaTransferida.Text),
                                     LstrMensagemValidacao,
                                     FdsTransferenciaContas.FieldByName('CON_EMPLAN').AsString,
                                     Nil) then
      begin
        pMensagemOk(LstrMensagemValidacao);
        Exit(False) ;
      end ;

    end;

  finally
    FdsTransferenciaContas.EnableControls ;
  end ;

  Result := True ;
end;

procedure TfrmTransfLancEntreContas.mskContaOriginalKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrPlan: TConsultasArray;
  strTplaco: String ;
begin
  If fEntraCons(Key) Then
  Begin
    strTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    If Contabilidade.Consultas.fPesqPlanoContabil(Self, mskContaOriginal, edtDesContaOriginal, Nil, Key, arrPlan, True, strTplaco, not FblnExisteCampoNCO_NATURE) Then
      SelectNext(ActiveControl, True, True);

    edtDesContaOriginal.Text := fCarregaDescricaoConta(mskContaOriginal.Text, edtEmpLan.Text) ;
    edtConOriRed.Text := fCarregaContaReduzida(mskContaOriginal.Text, edtEmpLan.Text) ;
  End;

end;

procedure TfrmTransfLancEntreContas.mskContaTransferidaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrPlan: TConsultasArray;
  strTplaco: String ;
begin
  If fEntraCons(Key) Then
  Begin
    strTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    If Contabilidade.Consultas.fPesqPlanoContabil(Self, mskContaTransferida, edtDesContaTransferida, Nil, Key, arrPlan, True, strTplaco, not FblnExisteCampoNCO_NATURE) Then
      SelectNext(ActiveControl, True, True);

    edtDesContaTransferida.Text := fCarregaDescricaoConta(mskContaTransferida.Text, edtEmpLan.Text) ;
    edtConTraRed.Text := fCarregaContaReduzida(mskContaTransferida.Text, edtEmpLan.Text) ;
  End;
end;

procedure TfrmTransfLancEntreContas.OnGeraExcel(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; CorFundo: TCorExcel);
begin
  //
end;

procedure TfrmTransfLancEntreContas.pAjustaArrayEmpresas;
var
  LreqEmpresa: TConsultas ;
begin
  SetLength(FarrEmp, 1);
  FillChar(LreqEmpresa, SizeOf(LreqEmpresa), #0);
  LreqEmpresa.strCodigo := edtEmpLan.Text ;
  FarrEmp[0] := LreqEmpresa ;
end;

procedure TfrmTransfLancEntreContas.pCarregaPlanoContabilOrigem(
  const AblnBuscaPorChave: Boolean; AblnCampoContaReduzida: Boolean);
var
  LstrTplaco : string ;
begin
  if AblnBuscaPorChave then
  begin
    edtDesContaOriginal.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaOriginal.Text)]);
    if not AblnCampoContaReduzida then
      edtConOriRed.Text := fCampoTabelaPlanco('NCO_CONRED', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaOriginal.Text)]);
  end
  else
  begin
    LstrTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    edtDesContaOriginal.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaOriginal.Text), LstrTplaco]);
    if not AblnCampoContaReduzida then
      edtConOriRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaOriginal.Text), LstrTplaco]);
  end;
end;

procedure TfrmTransfLancEntreContas.pCarregaPlanoContabilTransferida(
  const AblnBuscaPorChave: Boolean; AblnCampoContaReduzida: Boolean);
var
  LstrTplaco : string ;
begin
  if AblnBuscaPorChave then
  begin
    edtDesContaTransferida.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaTransferida.Text)]);
    if not AblnCampoContaReduzida then
      edtConTraRed.Text := fCampoTabelaPlanco('NCO_CONRED', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaTransferida.Text)]);
  end
  else
  begin
    LstrTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    edtDesContaTransferida.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaTransferida.Text), LstrTplaco]);
    if not AblnCampoContaReduzida then
      edtConTraRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaTransferida.Text), LstrTplaco]);
  end;
end;

procedure TfrmTransfLancEntreContas.pCarregaTipoContabeisTransferencia;
begin
  pCarregaTiposContabeis(edtTipLan, True, True);
  edtTipLan.Items.Add('Todos os Tipos de Lançamentos');
end;

procedure TfrmTransfLancEntreContas.pHabilitaTransferencia(
  const AblnHabilitar: Boolean);
begin
  Grid.Enabled := AblnHabilitar ;
  pnlContaTransf.Enabled := AblnHabilitar ;
  btnConfirma.Enabled := AblnHabilitar ;
  btnSair.Enabled := AblnHabilitar ;
  btnExportar.Enabled := AblnHabilitar ;
  btnAbrir.Enabled := not AblnHabilitar ;
  gbFiltros.Enabled := not AblnHabilitar ;

  if Assigned(FdsTransferenciaContas) then
  begin
   (FdsTransferenciaContas.FieldByName('CON_CONCRE') as TStringField).EditMask := fMskCon;
   (FdsTransferenciaContas.FieldByName('CON_CONDEB') as TStringField).EditMask := fMskCon;
  end;
end;

procedure TfrmTransfLancEntreContas.pLimpaTransferencia;
begin
  mskContaTransferida.Clear ;
  edtConTraRed.Clear ;
  edtDesContaTransferida.Clear ;

  if Assigned(FdsTransferenciaContas) then
    FdsTransferenciaContas.Close ;

end;

procedure TfrmTransfLancEntreContas.pSelecionaUltimoTipoContabil;
begin
  edtTipLan.ItemIndex := edtTipLan.Items.Count-1 ;
end;

end.
