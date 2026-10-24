unit Contabilidade.View.CheckListImportacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  cxGridBandedTableView, cxGridDBBandedTableView, EditFocus, cxContainer,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, Datasnap.DBClient, UniClientDataSet, MemDS, DBAccess, Uni,
  System.Types, cxProgressBar, Contabilidade.Interfaces, ComboBoxFocus,
  Contabilidade.Classes.CheckListImportacao, Vcl.CheckLst, untGeraExcel, untExcel,
  cxGroupBox, cxCheckGroup;

type
  TInfoTipo = class
  public
    Tipo: TTiposContabeis ;
  end ;

  TfrmCheckListImportacao = class(TfrmPaiContabilidade)
    gbFiltro: TGroupBox;
    GridLevel1: TcxGridLevel;
    Grid: TcxGridCitel;
    GridTab: TcxGridDBBandedTableView;
    dsCheckList: TDataSource;
    edtNomEmp: TEditFocus;
    edtEmpLan: TEditFocus;
    Label15: TLabel;
    btnGerarCheckList: TBitBtnLocked;
    GridTabDESCRI: TcxGridDBBandedColumn;
    cmbAnoFechamento: TComboBoxFocus;
    pnlEmpresa: TPanel;
    Label1: TLabel;
    pnlAnoFechamento: TPanel;
    pnlDta: TPanel;
    lblPeriodo: TLabel;
    mskDtaLanFin: TcxDateEdit;
    mskDtaLanIni: TcxDateEdit;
    gbTipo: TGroupBox;
    cklListaTipos: TCheckListBox;
    RGFiltroTipo: TRadioGroup;
    btnExportar: TBitBtnLocked;
    procedure edtEmpLanKeyPress(Sender: TObject; var Key: Char);
    procedure btnGerarCheckListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RGFiltroTipoClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
  private
    { Private declarations }
    FcdsCheckList: TUniClientDataSet ;
    FTipoCheckList: TTipoCheckList ;
    FecFechamento: TEncerramentoContabil ;
    function fValidaFiltroObrigatorio:Boolean;
    procedure pCriaColunasCds(const AdtaIni, AdtaFin: TDateTime; const AstrCodEmp: String) ;
    procedure pCriaColunasGrid;
    procedure pLimpaBandas;
    procedure pCarregaDados;
    function fTipLanChecado(const AstrTipLan: String; const AdtaImp: TDateTime; const AcdsCheckList: TUniClientDataSet): boolean ;
    function fConfirmarCheckList(pgbProgresso: TcxProgressBar): Boolean;
    procedure pAjustaCampos ;
    function fCheckListFechamento: boolean ;
    procedure pRetornaPeriodoDataByTipo(var AdtaInicial, AdtaFinal: TDateTime) ;
    procedure pCarregaAnoFechamentoComboBox ;
    function fRetornaFechamento(const AlstDias: TDateDynArray): TEncerramentoContabil ;
    function fMontaCaptionBanda(const AstrNomeBanda: String): String ;
    function fMesParaTrimestre(const AintMes: Integer): String ;
    function fAnoFechamentoSelecionado: Boolean;
    function fRegimeTributarioPreenchido: Boolean;
    procedure pPopularTiposCheckListBox;
    procedure pLimpaObjCheck;
    function fCheckedByTipoContabil(const ATipo: TTiposContabeis): Boolean ;
    function fTemTipoMarcado: boolean;
    procedure SetarTipoMarcado(AMarcar: boolean);
    procedure OnGeraExcel(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
  public
    { Public declarations }
    property TipoCheckList: TTipoCheckList read FTipoCheckList write FTipoCheckList ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples,
     untConsultas, untTypesSistema, DateUtils,
     Contabilidade.Funcoes, Contabilidade.Consultas ;

const
  PREFIXO_FIELD_DIA = 'DIA_' ;
  TIPO_CHECK_ = '_CHECK' ;
  TIPO_ULTGER = '_ULTGER' ;
  TIPO_CODEOP = '_CODOPE' ;
  TIPO_REPROC = '_REPROC' ;



procedure TfrmCheckListImportacao.btnExportarClick(Sender: TObject);
var LintIndex : Integer;
    LobjExcel : TGeraExcel;
    LDescCol : String;

begin
  inherited;

  Try
    FcdsCheckList.DisableControls;
    FcdsCheckList.First;
    LobjExcel := TGeraExcel.Create(FcdsCheckList, Nil);
    Try
      With LobjExcel, GridTab Do
      Begin
        OnImpDetalhes := OnGeraExcel;

        strNomRel := 'CHECKLIST DE IMPORTAÇÕES';

        For LintIndex := 0 To ColumnCount -1 Do
        Begin
          If (Not(Columns[LintIndex].Visible)) Then
            Continue;

          If trim(Columns[LintIndex].Caption) = '' Then
            Continue;

          If Columns[LintIndex].Caption = 'Ult.Geração' then
            LDescCol := copy(Columns[LintIndex].DataBinding.FieldName,1,3) + '_' + Columns[LintIndex].Caption
          else
            LDescCol := Columns[LintIndex].Caption;

          AddCampo( Columns[LintIndex].DataBinding.FieldName, LDescCol);
        End;

        if fGerarRelatorio Then
          pMensagemOk('Arquivo Gerado com Sucesso!');
      End;
    Finally
      FreeAndNil(LobjExcel);
    End;
  Finally
    FcdsCheckList.EnableControls;
  End;
end;

procedure TfrmCheckListImportacao.btnGerarCheckListClick(Sender: TObject);
begin
  inherited;
  if not fValidaFiltroObrigatorio then
    exit ;

  fChamaTelaGravando(fConfirmarCheckList) ;
end;

procedure TfrmCheckListImportacao.edtEmpLanKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmpSel: TConsultasArray;
begin
  inherited;

  if fCheckListFechamento then
  begin
    if not fAnoFechamentoSelecionado then
    begin
      Key := #0;
      exit ;
    end;

    If fPesqEmpresaComForTri(Self, edtEmpLan, edtNomEmp, Nil, Key, arrEmpSel, False, cmbAnoFechamento.Text) Then
    Begin
      If fValidaCampos(edtEmpLan) Then
        SelectNext(ActiveControl, True, True);
    End;
  end
  else
  begin
    If fPesqEmpresa(conEmpSimples, Self, edtEmpLan, edtNomEmp, Nil, Key, arrEmpSel, False) Then
    Begin
      If fValidaCampos(edtEmpLan) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

function TfrmCheckListImportacao.fAnoFechamentoSelecionado: Boolean;
begin
  Result := True;
  if fEmptyStr(cmbAnoFechamento.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Ano fechamento não selecionado!', ['&Ok']);
    Result := False;
  end;
end;

function TfrmCheckListImportacao.fCheckedByTipoContabil(
  const ATipo: TTiposContabeis): Boolean;
var
  LCnt: Integer ;
  LObj: TObject ;
  LInfo: TInfoTipo ;
begin
  Result := False ;
  for LCnt := 0 to cklListaTipos.Items.Count-1 do
  begin
    LObj := cklListaTipos.Items.Objects[LCnt] ;
    if Assigned(LObj) then
    begin
      LInfo := LObj as TInfoTipo ;
      if (LInfo.Tipo = ATipo) and (cklListaTipos.Checked[LCnt]) then
      begin
        Result := True ;
        Break ;
      end ;
    end ;
  end
end;

function TfrmCheckListImportacao.fCheckListFechamento: boolean;
begin
  result := (FTipoCheckList = tclFechamentoContabil) or (FTipoCheckList = tclFechamentoContabilMes) ;
end;

function TfrmCheckListImportacao.fConfirmarCheckList(
  pgbProgresso: TcxProgressBar): Boolean;
var
  LdtaInicial, LdtaFinal: TDateTime ;
begin
  pnlInfo.Caption := 'Aguarde, gerando dados...';
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;
  try
    pRetornaPeriodoDataByTipo(LdtaInicial, LdtaFinal) ;
    pCriaColunasCds(LdtaInicial, LdtaFinal, edtEmpLan.Text) ;
    pCriaColunasGrid ;
    pCarregaDados ;
  finally
    pnlInfo.Caption := '';
    Screen.Cursor := crDefault
  end ;
  result := True ;
end;

function TfrmCheckListImportacao.fMesParaTrimestre(
  const AintMes: Integer): String;
begin
  if (AintMes >= 1) and (AintMes <= 3) then
    Result := '1'
  else if (AintMes >= 4) and (AintMes <= 6) then
    Result := '2'
  else if (AintMes >= 7) and (AintMes <= 9) then
    Result := '3'
  else
    Result := '4' ;
end;

function TfrmCheckListImportacao.fMontaCaptionBanda(
  const AstrNomeBanda: String): String;
begin
  result := fRetMes(strtoint(copy(AstrNomeBanda,5,2)))+'/'+copy(AstrNomeBanda,1,4) ;
  if fCheckListFechamento then
  begin
    if FecFechamento = ecAnual then
      result := 'Anual: '+copy(AstrNomeBanda,1,4)
    else if FecFechamento = ecTrimestral then
      result := fMesParaTrimestre(strtoint(copy(AstrNomeBanda,5,2))) + 'º Trimestre' ;
  end ;
end;

procedure TfrmCheckListImportacao.FormCreate(Sender: TObject);
begin
  inherited;
  FTipoCheckList := tclGeracaoLancamentoContabil ;
  FcdsCheckList := TUniClientDataSet.Create(Nil) ;
  FecFechamento := ecNada ;
  pPopularTiposCheckListBox ;
end;

procedure TfrmCheckListImportacao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FcdsCheckList) ;
  pLimpaObjCheck;
end;

procedure TfrmCheckListImportacao.FormShow(Sender: TObject);
begin
  inherited;
  pAjustaCampos ;
  if fCheckListFechamento then
    pSetFocus(cmbAnoFechamento)
  else
    pSetFocus(edtEmpLan);
end;

function TfrmCheckListImportacao.fRegimeTributarioPreenchido: Boolean;
begin
  Result := True;
  if fCampoTabela('COUNT(*)', 'EPREGT', ['TRI_CODEMP', 'TRI_ANOEXE'], [edtEmpLan.Text, cmbAnoFechamento.Text], True) = 0 then
  begin
    fMensagem('ATENÇÃO!', 'Não há Parâmetros da "Forma de Tributação" para essa Empresa/Exercício.', ['&Ok']);
    Result := False;
  end;
end;

function TfrmCheckListImportacao.fRetornaFechamento(const AlstDias: TDateDynArray): TEncerramentoContabil;
begin
  result := ecNada ;
  if fCheckListFechamento then
  begin
    if Length(AlstDias) = 1 then
      result := ecAnual
    else if Length(AlstDias) = 4 then
      result := ecTrimestral
    else
      result := ecMensal ;
  end ;
end;

function TfrmCheckListImportacao.fTemTipoMarcado: boolean;
var
  LintCnt : Integer;
begin
  Result := False;
  for LintCnt := 0 to Pred(cklListaTipos.Items.Count) do
  begin
    if cklListaTipos.Checked[LintCnt] then
    begin
      Result := True;
      break;
    end;
  end;
end;

procedure TfrmCheckListImportacao.SetarTipoMarcado(AMarcar: boolean);
var
  LintCnt : Integer;
begin
  for LintCnt := 0 to Pred(cklListaTipos.Items.Count) do
  begin
    cklListaTipos.Checked[LintCnt] := AMarcar;
  end;
end;

procedure TfrmCheckListImportacao.OnGeraExcel(Excel: TExcel;
  Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
  Var
    LintCnt   : Integer;
    LfldCampo : TField;
    LstrValor : String;
begin
  // Reescreve colunas datetime como string para evitar o problema de exibicao
  // ao abrir a planilha (o motor aplica NumberFormat 'dd/mm/aaaa' que quebra
  // em locais diferentes do Excel em portugues).
  For LintCnt := 1 To Campos.Colunas.Count Do
  Begin
    If Not (Campos.ColunaPorIndice[LintCnt].Tipo In [ftDate, ftDateTime]) Then
      Continue;

    LfldCampo := Dados.FindField(Campos.ColunaPorIndice[LintCnt].NomeCampo);

    If Not Assigned(LfldCampo) Then
      Continue;

    If LfldCampo.IsNull Then
      LstrValor := ''
    Else
    Begin
      if Campos.ColunaPorIndice[LintCnt].NomeCampo.Contains('ULTGER') then
        // O . na formatação da data e hora impede o Excel COM de auto-parsear a string como TDateTime.
        // Se usar espaço, o Excel tentea converter automaticamente para data e gera exceção no metodo escrever porque não é uma data válida,
        // mostrando a coluna totalmente desformatada.
        LstrValor := FormatDateTime('dd/mm/yyyy.hh:nn:ss', LfldCampo.AsDateTime)
      else
        LstrValor := FormatDateTime('dd/mm/yyyy', LfldCampo.AsDateTime);
    End;

    Excel.Escrever(Excel.LinhaAtual, LintCnt, LstrValor);
  End;
end;


function TfrmCheckListImportacao.fTipLanChecado(const AstrTipLan: String;
  const AdtaImp: TDateTime; const AcdsCheckList: TUniClientDataSet): boolean;
begin
  result := AcdsCheckList.FindKey([AdtaImp, AstrTipLan]) ;
end;

function TfrmCheckListImportacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtEmpLan) Then
    Begin
      if fEmptyStr(edtEmpLan.Text) then
      begin
        edtNomEmp.Clear;
        Result := True;
      end
      else
      Begin
        edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpLan.Text], False);
        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        end;
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmCheckListImportacao.fValidaFiltroObrigatorio: Boolean;
begin
  result := False ;
  if fEmptyStr(edtEmpLan.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Empresa não selecionada!', ['&Ok']);
    pSetFocus(edtEmpLan);
    exit ;
  end ;

  if fCheckListFechamento then
  begin
    if not fAnoFechamentoSelecionado then
    begin
      pSetFocus(cmbAnoFechamento);
      exit ;
    end ;

    if not fRegimeTributarioPreenchido then
    begin
      pSetFocus(edtEmpLan);
      exit ;
    end ;
  end
  else
  begin
    if datetostr(mskDtaLanIni.Date) = '00/00/0000' then
    begin
      fMensagem('ATENÇÃO!', 'Data importação não selecionada!', ['&Ok']);
      pSetFocus(mskDtaLanIni);
      exit ;
    end ;

    if datetostr(mskDtaLanFin.Date) = '00/00/0000' then
    begin
      fMensagem('ATENÇÃO!', 'Data importação não selecionada!', ['&Ok']);
      pSetFocus(mskDtaLanFin);
      exit ;
    end ;
  end ;

  if mskDtaLanFin.Date < mskDtaLanIni.Date then
  begin
    fMensagem('ATENÇÃO!', 'Data importação inválida!', ['&Ok']);
    pSetFocus(mskDtaLanIni);
    exit ;
  end ;

  if not fTemTipoMarcado then
  begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um tipo contábil para geração!', ['&OK']);
    Exit;
  end ;

  result := True ;
end;

procedure TfrmCheckListImportacao.pAjustaCampos;
begin
  if fCheckListFechamento then
  begin
    pnlDTa.TabStop := False;
    pnlDTa.Visible := False;
    pnlDTa.Left := 690;
    pnlDTa.Top := 15;

    pnlEmpresa.TabStop := True;
    pnlEmpresa.Visible := True;
    pnlEmpresa.Left := 23;
    pnlEmpresa.Top := 43;

    btnGerarCheckList.TabStop := True;
    btnGerarCheckList.Visible := True;
    btnGerarCheckList.Left := 700;
    btnGerarCheckList.Top := 42;

    pnlAnoFechamento.TabStop := True;
    pnlAnoFechamento.Visible := True;
    pnlAnoFechamento.Left := 19;
    pnlAnoFechamento.Top := 17;

    pCarregaAnoFechamentoComboBox ;

    gbFiltro.Height := 73 ;
    gbTipo.Visible := False ;

    btnGerarCheckList.Top := 42 ;
    btnGerarCheckList.Left := 554 ;
  end
  else
  begin
    pnlDTa.TabStop := True;
    pnlDTa.Visible := True;
    pnlDTa.Left := 14;
    pnlDTa.Top := 43;

    pnlEmpresa.TabStop := True;
    pnlEmpresa.Visible := True;
    pnlEmpresa.Left := 23;
    pnlEmpresa.Top := 17;

    pnlAnoFechamento.TabStop := False;
    pnlAnoFechamento.Visible := False;
    pnlAnoFechamento.Left := 443;
    pnlAnoFechamento.Top := 43;

  end;
end;

procedure TfrmCheckListImportacao.pCarregaAnoFechamentoComboBox;
var
  LqryVer: TUniQuery ;
  LstrAnoAtual: String ;
begin
  LqryVer := fCriaQuery() ;
  try
    LqryVer.Close ;
    LqryVer.SQL.Clear ;
    if FTipoCheckList = tclFechamentoContabil then
    begin
      LqryVer.SQL.Add('SELECT DISTINCT EXTRACT(YEAR FROM CON_FECINI) AS ANO FROM FECCON ORDER BY 1') ;
    end
    else if FTipoCheckList = tclFechamentoContabilMes then
    begin
      LqryVer.SQL.Add('SELECT DISTINCT EXTRACT(YEAR FROM MES_MESDTA) AS ANO FROM FECMES ORDER BY 1') ;
    end ;
    LqryVer.Open ;
    cmbAnoFechamento.Items.Clear ;
    while not LqryVer.Eof do
    begin
      cmbAnoFechamento.Items.Add(LqryVer.FieldByName('ANO').AsString) ;
      LqryVer.Next ;
    end ;

    LstrAnoAtual := IntToStr(YearOf(VS_Date)) ;
    if cmbAnoFechamento.Items.IndexOf(LstrAnoAtual) = -1 then
      cmbAnoFechamento.Items.Add(LstrAnoAtual) ;

  finally
    FreeAndNil(LqryVer) ;
  end ;
end;

procedure TfrmCheckListImportacao.pCarregaDados;
var
  LlstDias: TDateDynArray ;
  LdtaDia: TDateTime ;
  LstrDia: String ;
  LcdsCheck, LcdsCheckClonado: TUniClientDataSet ;
  LdtaInicial, LdtaFinal: TDateTime ;
  LTipo: TTiposContabeis;
  LControlaDatas: TStringList;
  LDataConvertida: String ;
  LDescriTipo: String ;
  LIncValor: Integer ;
begin
  pRetornaPeriodoDataByTipo(LdtaInicial, LdtaFinal) ;
  LlstDias := TProcessaCheckList.fRetornaDatas(LdtaInicial, LdtaFinal, FTipoCheckList, edtEmpLan.Text) ;
  LcdsCheck := TProcessaCheckList.fSelecionar(edtEmpLan.Text, LdtaInicial, LdtaFinal, FTipoCheckList) ;
  if not Assigned(LcdsCheck) then
  begin
    fMensagem('ATENÇÃO!', 'Check list inválido!', ['&Ok']);
    exit ;
  end ;

  FcdsCheckList.DisableControls ;
  LControlaDatas := TStringList.Create;
  LcdsCheckClonado := TUniClientDataSet.Create(Nil);
  try
    pCloneDataSet(LcdsCheckClonado, LcdsCheck);
    LcdsCheckClonado.IndexFieldNames := 'CHK_DTALAN;CHK_TIPLAN' ;

    LControlaDatas.Sorted := True ;
    if not fCheckListFechamento then
    begin
      LIncValor := 0 ;
      LcdsCheck.First ;
      while not LcdsCheck.Eof do
      begin
        LDataConvertida := LcdsCheck.FieldByName('CHK_DTALAN').AsString ;
        if LControlaDatas.IndexOf(LDataConvertida) = -1 then
        begin
          LControlaDatas.Add(LDataConvertida) ;
          Inc(LIncValor) ;
          FcdsCheckList.Append ;
          FcdsCheckList.FieldByName('ID').AsInteger := LIncValor ;
          FcdsCheckList.FieldByName('DATA').AsDateTime := LcdsCheck.FieldByName('CHK_DTALAN').AsDateTime ;
          for LTipo := Low(TTiposContabeis) to High(TTiposContabeis) do
          begin
            if fPodeUsarTiposContabeisAgrupamento(LTipo) then
            begin
              LDescriTipo := DES_CONTABIL_SIGLA[LTipo] ;
              FcdsCheckList.FieldByName(LDescriTipo+TIPO_CHECK_).AsBoolean := False ;
              if LcdsCheckClonado.FindKey([LcdsCheck.FieldByName('CHK_DTALAN').AsDateTime, LDescriTipo]) then
              begin
                if LDescriTipo = LcdsCheck.FieldByName('CHK_TIPLAN').AsString then
                begin
                  FcdsCheckList.FieldByName(LDescriTipo+TIPO_CHECK_).AsBoolean := True ;
                  FcdsCheckList.FieldByName(LDescriTipo+TIPO_ULTGER).AsDateTime := LcdsCheck.FieldByName('CHK_DTAGER').AsDateTime ;
                  FcdsCheckList.FieldByName(LDescriTipo+TIPO_CODEOP).AsString := LcdsCheck.FieldByName('CHK_CODOPE').AsString ;
                  FcdsCheckList.FieldByName(LDescriTipo+TIPO_REPROC).AsBoolean := Assigned(LcdsCheck.FindField('CHK_REPROC')) and (LcdsCheck.FieldByName('CHK_REPROC').AsString = 'S') ;
                end;
              end ;
            end ;
          end ;
          FcdsCheckList.Post ;
        end
        else
        begin
          FcdsCheckList.Edit ;
          LDescriTipo := LcdsCheck.FieldByName('CHK_TIPLAN').AsString ;
          FcdsCheckList.FieldByName(LDescriTipo+TIPO_CHECK_).AsBoolean := True ;
          FcdsCheckList.FieldByName(LDescriTipo+TIPO_ULTGER).AsDateTime := LcdsCheck.FieldByName('CHK_DTAGER').AsDateTime ;
          FcdsCheckList.FieldByName(LDescriTipo+TIPO_CODEOP).AsString := LcdsCheck.FieldByName('CHK_CODOPE').AsString ;
          FcdsCheckList.FieldByName(LDescriTipo+TIPO_REPROC).AsBoolean := Assigned(LcdsCheck.FindField('CHK_REPROC')) and (LcdsCheck.FieldByName('CHK_REPROC').AsString = 'S') ;

          FcdsCheckList.Post ;
        end;
        LcdsCheck.Next ;
      end ;
    end
    else // fechamento
    begin
      FcdsCheckList.Append ;
      FcdsCheckList.FieldByName('ID').AsInteger := 1 ;
      FcdsCheckList.FieldByName('DESCRI').AsString := 'FEC' ;
      for LdtaDia in LlstDias do
      begin
        LstrDia := fstrZero(YearOf(LdtaDia),4)+fstrZero(MonthOf(LdtaDia),2)+fstrZero(DayOf(LdtaDia),2) ;
        FcdsCheckList.FieldByName(PREFIXO_FIELD_DIA+LstrDia).AsBoolean := fTipLanChecado(copy(FcdsCheckList.FieldByName('DESCRI').AsString,1,3),
                                                                                         LdtaDia,
                                                                                         LcdsCheck) ;
      end ;
      FcdsCheckList.Post ;
    end ;

  finally
    FcdsCheckList.EnableControls ;
    FreeAndNil(LcdsCheck) ;
    FreeAndNil(LControlaDatas) ;
    FreeAndNil(LcdsCheckClonado) ;
  end ;
  dsCheckList.DataSet := FcdsCheckList ;
end;

procedure TfrmCheckListImportacao.pCriaColunasCds(const AdtaIni,
  AdtaFin: TDateTime; const AstrCodEmp: String);
var
  LlstDias: TDateDynArray ;
  LdtaDia: TDateTime ;
  LstrDia: String ;
  LTipo: TTiposContabeis;
  LDescriTipo: String ;
begin
  LlstDias := TProcessaCheckList.fRetornaDatas(AdtaIni, AdtaFin, FTipoCheckList, AstrCodEmp) ;
  FecFechamento := fRetornaFechamento(LlstDias) ;
  dsCheckList.DataSet := Nil ;

  FcdsCheckList.Close ;
  FcdsCheckList.FieldDefs.Clear ;
  if fCheckListFechamento then
  begin
    FcdsCheckList.FieldDefs.Add('ID',ftInteger, 0, True); ///campo virtual, chave primaria.
    FcdsCheckList.FieldDefs.Add('DESCRI',ftString, 35, False);
    for LdtaDia in LlstDias do
    begin
      LstrDia := fstrZero(YearOf(LdtaDia),4)+fstrZero(MonthOf(LdtaDia),2)+fstrZero(DayOf(LdtaDia),2) ;
      FcdsCheckList.FieldDefs.Add(PREFIXO_FIELD_DIA+LstrDia, ftBoolean, 0, False);
    end ;
  end
  else
  begin
    FcdsCheckList.FieldDefs.Add('ID',ftAutoInc, 0, True);
    FcdsCheckList.FieldDefs.Add('DATA',ftDate, 0, True);
    for LTipo := Low(TTiposContabeis) to High(TTiposContabeis) do
    begin
      if fPodeUsarTiposContabeisAgrupamento(LTipo) then
      begin
        LDescriTipo := Trim(DES_CONTABIL_SIGLA[LTipo]) ;
        FcdsCheckList.FieldDefs.Add(LDescriTipo+TIPO_CHECK_, ftBoolean, 0, False);
        FcdsCheckList.FieldDefs.Add(LDescriTipo+TIPO_ULTGER, ftDateTime, 0, False);
        FcdsCheckList.FieldDefs.Add(LDescriTipo+TIPO_CODEOP, ftString, 3, False);
        FcdsCheckList.FieldDefs.Add(LDescriTipo+TIPO_REPROC, ftBoolean, 0, False);
      end ;
    end ;
  end ;
  FcdsCheckList.CreateDataSet;
  FcdsCheckList.IndexFieldNames := 'ID';

end;

procedure TfrmCheckListImportacao.pCriaColunasGrid;
var
  LintCnt: integer ;
  LcolGrid : TcxGridDBBandedColumn ;
  LstrNomeBanda : String ;
  LbandMes, LBandTipo : TcxGridBand ;
  LstrFieldMesAno : string ;
  LintCountColByBand : integer ;
  LTipo: TTiposContabeis;
  LDescriTipo: String ;
begin
  GridTab.BeginUpdate;
  try
    ////limpa todas as colunas da grid
    GridTab.ClearItems ;
    pLimpaBandas ;

    if fCheckListFechamento then
    begin
      LcolGrid := GridTab.CreateColumn ;
      LcolGrid.DataBinding.FieldName := 'DESCRI' ;
      LcolGrid.Caption := 'Tipo' ;
      LcolGrid.Position.BandIndex := 0;
      LcolGrid.Name := GridTab.Name+LcolGrid.DataBinding.FieldName;

      LstrNomeBanda := '' ;
      LbandMes := Nil ;
      LintCountColByBand := 0 ;
      for LintCnt := 0 to FcdsCheckList.Fields.Count-1 do
      begin
        if pos(PREFIXO_FIELD_DIA, FcdsCheckList.Fields.Fields[LintCnt].FieldName) <= 0 then
          continue ;

        LstrFieldMesAno := StringReplace(FcdsCheckList.Fields.Fields[LintCnt].FieldName, PREFIXO_FIELD_DIA, '', [rfReplaceAll]) ;
        if LstrNomeBanda <> copy(LstrFieldMesAno, 1, 6) then
        begin
          LstrNomeBanda := copy(LstrFieldMesAno, 1, 6) ;

          LbandMes := GridTab.Bands.Add ;
          LbandMes.Caption := fMontaCaptionBanda(LstrNomeBanda);
          LbandMes.Width := 100 ;
          LintCountColByBand := 1 ;
        end ;

        if Assigned(LbandMes) then
        begin
          LcolGrid := GridTab.CreateColumn ;
          LcolGrid.DataBinding.FieldName := FcdsCheckList.Fields.Fields[LintCnt].FieldName ;

          LcolGrid.Caption := '' ;
          if not fCheckListFechamento then
            LcolGrid.Caption := copy(LstrFieldMesAno,7,2) ;
          LcolGrid.Position.BandIndex := LbandMes.Index ;
          LcolGrid.Name := GridTab.Name+FcdsCheckList.Fields.Fields[LintCnt].FieldName;
          LcolGrid.Width := 20 ;
          if LintCountColByBand > 5 then
            LbandMes.Width := LbandMes.Width + 20 ;
          inc(LintCountColByBand) ;
        end ;
      end ;
    end
    else
    begin
      GridTab.Bands.Items[0].Width := 60 ;

      LcolGrid := GridTab.CreateColumn ;
      LcolGrid.DataBinding.FieldName := 'DATA' ;
      LcolGrid.Caption := 'Datas' ;
      LcolGrid.Position.BandIndex := 0;
      LcolGrid.Width := 60 ;
      LcolGrid.Name := GridTab.Name+LcolGrid.DataBinding.FieldName;

      for LTipo := Low(TTiposContabeis) to High(TTiposContabeis) do
      begin
        if fPodeUsarTiposContabeisAgrupamento(LTipo) then
        begin
          if fCheckedByTipoContabil(LTipo) then
          begin
            LDescriTipo := Trim(DES_CONTABIL_SIGLA[LTipo]) ;

            LbandTipo := GridTab.Bands.Add ;
            LbandTipo.Caption := LDescriTipo;
            LbandTipo.Width := 200 ;

            LcolGrid := GridTab.CreateColumn ;
            LcolGrid.Caption := ' ' ;
            LcolGrid.DataBinding.FieldName := LDescriTipo+TIPO_CHECK_ ;
            LcolGrid.Position.BandIndex := LbandTipo.Index ;
            LcolGrid.Name := GridTab.Name+LcolGrid.DataBinding.FieldName;
            LcolGrid.Width := 21 ;

            LcolGrid := GridTab.CreateColumn ;
            LcolGrid.Caption := 'Ult.Geração' ;
            LcolGrid.DataBinding.FieldName := LDescriTipo+TIPO_ULTGER ;
            LcolGrid.Position.BandIndex := LbandTipo.Index ;
            LcolGrid.Name := GridTab.Name+LcolGrid.DataBinding.FieldName;
            LcolGrid.Width := 107 ;

            LcolGrid := GridTab.CreateColumn ;
            LcolGrid.Caption := 'Operador' ;
            LcolGrid.DataBinding.FieldName := LDescriTipo+TIPO_CODEOP ;
            LcolGrid.Position.BandIndex := LbandTipo.Index ;
            LcolGrid.Name := GridTab.Name+LcolGrid.DataBinding.FieldName;
            LcolGrid.Width := 72 ;

            if TProcessaCheckList.fTemCampoReprocesso then
            begin
              LcolGrid := GridTab.CreateColumn ;
              LcolGrid.Caption := 'Reproc.' ;
              LcolGrid.DataBinding.FieldName := LDescriTipo+TIPO_REPROC ;
              LcolGrid.Position.BandIndex := LbandTipo.Index ;
              LcolGrid.Name := GridTab.Name+LcolGrid.DataBinding.FieldName;
              LcolGrid.Width := 50 ;
            end ;
          end ;
        end ;
      end ;
    end ;

  finally
    GridTab.EndUpdate;
  end;
end;

procedure TfrmCheckListImportacao.pLimpaBandas;
var
  LintCnt: integer ;
begin
  for LintCnt := GridTab.Bands.Count-1 downto 1 do
  begin
    GridTab.Bands.Delete(LintCnt);
  end ;
end;

procedure TfrmCheckListImportacao.pLimpaObjCheck;
var
  LCnt: Integer ;
  LObj: TObject ;
begin
  for LCnt := 0 to cklListaTipos.Items.Count-1 do
  begin
    LObj := cklListaTipos.Items.Objects[LCnt] ;
    if Assigned(LObj) then
      FreeAndNil(lObj);
  end
end;

procedure TfrmCheckListImportacao.pPopularTiposCheckListBox;
var
  LintCnt : Integer;
  LLastItem: Integer;
  LListaParamConf: TStringList ;
  LInfo: TInfoTipo ;
begin

  LListaParamConf := fCarregaListaParametrosConfigurados ;
  try
    cklListaTipos.Items.Clear;
    for LintCnt := Ord(Low(TTiposContabeis)) to Ord(High(TTiposContabeis)) Do
    begin
      if (TTiposContabeis(LintCnt) = tcANT) and (not fTabelaExiste('PAGANT')) then
        Continue;

      if not fPodeUsarTiposContabeisAgrupamento(TTiposContabeis(LintCnt)) then
        Continue;

      if (TTiposContabeis(LintCnt) = tcAJI) and (not fCfgSis('AJUICM', varBoolean)) then
        Continue;

      if fTemParametroConfigurado(LListaParamConf, DES_CONTABIL_SIGLA[TTiposContabeis(LintCnt)]) then
      begin
        LInfo := TInfoTipo.Create ;
        LInfo.Tipo := TTiposContabeis(LintCnt) ;
        LLastItem := cklListaTipos.Items.AddObject(DES_CONTABIL[TTiposContabeis(LintCnt)], LInfo);
        cklListaTipos.Checked[LLastItem] := True ;
      end ;
    end;
  finally
    FreeAndNil(LListaParamConf) ;
  end ;
end;

procedure TfrmCheckListImportacao.pRetornaPeriodoDataByTipo(var AdtaInicial,
  AdtaFinal: TDateTime);
var
  LdtaInicial, LdtaFinal: TDateTime ;
begin
  if fCheckListFechamento then
  begin
    LdtaInicial := EncodeDate(StrToInt(cmbAnoFechamento.Text), 1, 1) ;
    LdtaFinal := EncodeDate(StrToInt(cmbAnoFechamento.Text), 12, 31) ;
    AdtaInicial := LdtaInicial ;
    AdtaFinal := LdtaFinal ;
  end
  else
  begin
    AdtaInicial := mskDtaLanIni.Date ;
    AdtaFinal := mskDtaLanFin.Date ;
  end ;
end;

procedure TfrmCheckListImportacao.RGFiltroTipoClick(Sender: TObject);
begin
  inherited;
  if RGFiltroTipo.ItemIndex = 0 then
    SetarTipoMarcado(true)
  else
    SetarTipoMarcado(false);
end;

end.
