unit Contabilidade.View.ApuracaoLucroRealRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, EditFocus, cxLabel, Contabilidade.Interfaces,
  cxGroupBox, cxCheckGroup, Contabilidade.Classes.ApuracaoLucroRealRelatorio,
  frxExportPDF, frxDBSet, Data.DB, Datasnap.DBClient, UniClientDataSet;

type
  TfrmApuracaoLucroRealRelatorio = class(TfrmPaiContabilidade)
    cxLabel1: TcxLabel;
    edtExercicio: TEditFocus;
    cxLabel4: TcxLabel;
    edtPeriodoInicial: TcxComboBox;
    cxLabel2: TcxLabel;
    edtPeriodoFinal: TcxComboBox;
    btnConfirma: TBitBtnLocked;
    checkLacsLalur: TcxCheckGroup;
    RelatorioLucroReal: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    frxDBAjustesLacsParteA: TfrxDBDataset;
    frxDBDemonstrativoLacsParteA: TfrxDBDataset;
    frxDBAjustesLalurParteA: TfrxDBDataset;
    frxDBDemonstrativoLalurParteA: TfrxDBDataset;
    cdsAjustesParteA: TUniClientDataSet;
    cdsAjustesParteAAUTOINCREM: TStringField;
    cdsAjustesParteAPRE_DTAINI: TDateField;
    cdsAjustesParteAPRE_DTAFIN: TDateField;
    cdsAjustesParteAARE_DTALAN: TDateField;
    cdsAjustesParteAHISTOR: TStringField;
    cdsAjustesParteAVAL_ADICAO: TFloatField;
    cdsAjustesParteAVAL_EXCLUSAO: TFloatField;
    cdsDemonstrativoParteA: TUniClientDataSet;
    cdsDemonstrativoParteACODIGO: TIntegerField;
    cdsDemonstrativoParteAAUTOINCREM: TStringField;
    cdsDemonstrativoParteADTAINI: TDateField;
    cdsDemonstrativoParteADTAFIN: TDateField;
    cdsDemonstrativoParteADESCRI: TStringField;
    cdsDemonstrativoParteAVALOR_: TFloatField;
    cdsDemonstrativoParteATOTAL_: TFloatField;
    cdsBaseNegativaParteB: TUniClientDataSet;
    cdsBaseNegativaParteBCODIGO: TIntegerField;
    cdsBaseNegativaParteBCTACON: TStringField;
    cdsBaseNegativaParteBDESCRI: TStringField;
    cdsBaseNegativaParteBDTALAN: TDateField;
    cdsBaseNegativaParteBHISTOR: TStringField;
    cdsBaseNegativaParteBDEBITO: TFloatField;
    cdsBaseNegativaParteBCREDIT: TFloatField;
    cdsBaseNegativaParteBSALDO_: TFloatField;
    cdsBaseNegativaParteBCREDEB: TStringField;
    frxDBBaseNegativaLacsParteB: TfrxDBDataset;
    frxDBBaseNegativaLalurParteB: TfrxDBDataset;
    cdsApuracaoMestre: TUniClientDataSet;
    cdsApuracaoDetalhe: TUniClientDataSet;
    cdsApuracaoMestreAUTOINCREM: TStringField;
    cdsApuracaoMestrePRE_DTAINI: TDateField;
    cdsApuracaoMestrePRE_DTAFIN: TDateField;
    cdsApuracaoMestreLUCRO_LIQUIDO: TFloatField;
    cdsApuracaoMestreVRE_VLADIC: TFloatField;
    cdsApuracaoMestreVRE_VLEXCL: TFloatField;
    cdsApuracaoMestreVRE_VLBCNG: TFloatField;
    cdsApuracaoMestreVRE_VLCOMP: TFloatField;
    cdsApuracaoMestreVRE_VLRBAS: TFloatField;
    cdsApuracaoDetalheCODIGO: TIntegerField;
    cdsApuracaoDetalheAUTOINCREM: TStringField;
    cdsApuracaoDetalheDTAINI: TDateField;
    cdsApuracaoDetalheDTAFIN: TDateField;
    cdsApuracaoDetalheDESCRI: TStringField;
    cdsApuracaoDetalheVLRBAL: TFloatField;
    cdsApuracaoDetalheVLRREC: TFloatField;
    frxDBApuracaoLacsMestre: TfrxDBDataset;
    frxDBApuracaoLalurMestre: TfrxDBDataset;
    frxDBApuracaoLacsDetalhe: TfrxDBDataset;
    frxDBApuracaoLalurDetalhe: TfrxDBDataset;
    cdsApuracaoDetalheTITULO: TIntegerField;
    cxLabel7: TcxLabel;
    edtEmpSel: TEditFocus;
    edtNomEmpSel: TEditFocus;
    cdsAjustesParteACREDEB_ADICAO: TStringField;
    cdsAjustesParteACREDEB_EXCLUSAO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure edtExercicioChange(Sender: TObject);
    procedure edtPeriodoInicialPropertiesChange(Sender: TObject);
    procedure edtPeriodoFinalPropertiesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtEmpSelKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpSelChange(Sender: TObject);
    procedure edtEmpSelExit(Sender: TObject);
  private
    { Private declarations }
    FBlnExercicioAlterado: Boolean ;
    FftForma: TFormaTributacao ;
    FecEncerramento: TEncerramentoContabil ;
    FalrrGerarDados: TApuracaoLucroRealRelatorio ;
    function fValidaBotaoConfirma: Boolean ;
    procedure pCarregaTiposGroupCheckBox ;
    function fRetornaTiposSelecionados: TTipoLucroRealRelatorios ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses Contabilidade.Classes.ApuracaoLucroRealLalurLacs, untFuncoesSimples,
     System.Generics.Collections, DateUtils, Contabilidade.Funcoes,
     untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmApuracaoLucroRealRelatorio.btnConfirmaClick(Sender: TObject);
var
  LDictSelecionadoInicial: TDictionary<string, TDateTime> ;
  LDictSelecionadoFinal: TDictionary<string, TDateTime> ;
  LstrCnpj, LstrRazaoSocial: string ;
begin
  inherited;

  if not fValidaCampos(edtExercicio) then
  begin
    exit ;
  end;

  if not fValidaCampos(edtPeriodoInicial) then
  begin
    exit ;
  end;

  if not fValidaCampos(edtPeriodoFinal) then
  begin
    exit ;
  end;

  if not fValidaBotaoConfirma then
  begin
    Exit ;
  end ;

  LDictSelecionadoInicial := edtPeriodoInicial.Properties.Items.Objects[edtPeriodoInicial.ItemIndex] as TDictionary<string, TDateTime> ;
  LDictSelecionadoFinal := edtPeriodoFinal.Properties.Items.Objects[edtPeriodoFinal.ItemIndex] as TDictionary<string, TDateTime> ;
  if FecEncerramento = ecTrimestral then
  begin
    FalrrGerarDados.PeriodoInicial := LDictSelecionadoInicial['inicio'] ;
    FalrrGerarDados.PeriodoFinal := LDictSelecionadoFinal['final'] ;
  end
  else // anual
  begin
    FalrrGerarDados.PeriodoInicial := EncodeDate(YearOf(LDictSelecionadoInicial['final']), MonthOf(LDictSelecionadoInicial['final']), 1) ;
    FalrrGerarDados.PeriodoFinal := LDictSelecionadoFinal['final'] ;
  end ;
  FalrrGerarDados.Exercicio := strToIntDef(edtExercicio.Text, 0) ;
  FalrrGerarDados.pSetEmpresa(edtEmpSel.Text) ;
  FalrrGerarDados.Encerramento := FecEncerramento ;
  FalrrGerarDados.Tipos := fRetornaTiposSelecionados ;
  if fChamaTelaGravando(FalrrGerarDados.fCarregaDados) then
  begin
    //direciona para os Datasets do Objeto
    frxDBAjustesLacsParteA.DataSet := Nil ;
    frxDBAjustesLacsParteA.DataSet := FalrrGerarDados.AjustesLacsParteA ;
    frxDBDemonstrativoLacsParteA.DataSet := Nil ;
    frxDBDemonstrativoLacsParteA.DataSet := FalrrGerarDados.DemonstrativoLacsParteA ;
    frxDBAjustesLalurParteA.DataSet := Nil ;
    frxDBAjustesLalurParteA.DataSet := FalrrGerarDados.AjustesLalurParteA ;
    frxDBDemonstrativoLalurParteA.DataSet := Nil ;
    frxDBDemonstrativoLalurParteA.DataSet := FalrrGerarDados.DemonstrativoLalurParteA ;
    frxDBBaseNegativaLacsParteB.DataSet := Nil ;
    frxDBBaseNegativaLacsParteB.DataSet := FalrrGerarDados.LancamentosCtaConLacsParteB ;
    frxDBBaseNegativaLalurParteB.DataSet := Nil ;
    frxDBBaseNegativaLalurParteB.DataSet := FalrrGerarDados.LancamentosCtaConLalurParteB ;
    frxDBApuracaoLacsMestre.DataSet := Nil ;
    frxDBApuracaoLacsMestre.DataSet := FalrrGerarDados.MestreLacsApuracao ;
    frxDBApuracaoLacsDetalhe.DataSet := Nil ;
    frxDBApuracaoLacsDetalhe.DataSet := FalrrGerarDados.DetalheLacsApuracao ;
    frxDBApuracaoLalurMestre.DataSet := Nil ;
    frxDBApuracaoLalurMestre.DataSet := FalrrGerarDados.MestreLalurApuracao ;
    frxDBApuracaoLalurDetalhe.DataSet := Nil ;
    frxDBApuracaoLalurDetalhe.DataSet := FalrrGerarDados.DetalheLalurApuracao ;

    try
      (RelatorioLucroReal.FindObject('pgAjustesLacsParteA') as TfrxReportPage).Visible := tlrrLacsParteA in FalrrGerarDados.Tipos ;
      (RelatorioLucroReal.FindObject('pgDemonstrativoLacsParteA') as TfrxReportPage).Visible := tlrrLacsParteA in FalrrGerarDados.Tipos ;
      RelatorioLucroReal.Script.Variables['RepTitAjustesLacsParteA'] := 'PARTE A: REGISTRO DOS AJUSTES DO LUCRO LÍQUIDO DO EXERCÍCIO - CONTRIBUIÇÃO SOCIAL' ;
      RelatorioLucroReal.Script.Variables['RepTitDemonstrativoLacsParteA'] := 'DEMONSTRAÇÃO DA BASE DE CÁLCULO DA CONTRIBUIÇÃO SOCIAL DO PERÍODO' ;

      (RelatorioLucroReal.FindObject('pgAjustesLalurParteA') as TfrxReportPage).Visible := tlrrLalurParteA in FalrrGerarDados.Tipos ;
      (RelatorioLucroReal.FindObject('pgDemonstrativoLalurParteA') as TfrxReportPage).Visible := tlrrLalurParteA in FalrrGerarDados.Tipos ;
      RelatorioLucroReal.Script.Variables['RepTitAjustesLalurParteA'] := 'PARTE A: REGISTRO DOS AJUSTES DO LUCRO LÍQUIDO DO EXERCÍCIO - IMPOSTO DE RENDA' ;
      RelatorioLucroReal.Script.Variables['RepTitDemonstrativoLalurParteA'] := 'DEMONSTRAÇÃO DA BASE DE CÁLCULO DO IMPOSTO DE RENDA DO PERÍODO' ;

      (RelatorioLucroReal.FindObject('pgLancamentosCtaConLacsParteB') as TfrxReportPage).Visible := tlrrLacsParteB in FalrrGerarDados.Tipos ;
      RelatorioLucroReal.Script.Variables['RepTitLancamentosCtaConLacsParteB'] := 'PARTE B: CONTROLE DA BASE DE CÁLCULO NEGATIVA DA CONTRIBUIÇÃO SOCIAL' ;

      (RelatorioLucroReal.FindObject('pgLancamentosCtaConLalurParteB') as TfrxReportPage).Visible := tlrrLalurParteB in FalrrGerarDados.Tipos ;
      RelatorioLucroReal.Script.Variables['RepTitLancamentosCtaConLalurParteB'] := 'PARTE B: CONTROLE DE PREJUÍZOS FISCAIS DO IRPJ' ;

      (RelatorioLucroReal.FindObject('pgLacsApuracao') as TfrxReportPage).Visible := tlrrLacsApuracao in FalrrGerarDados.Tipos ;
      RelatorioLucroReal.Script.Variables['RepTitLacsApuracao'] := 'APURAÇÃO - CONTRIBUIÇÃO SOCIAL' ;

      (RelatorioLucroReal.FindObject('pgLalurApuracao') as TfrxReportPage).Visible := tlrrLalurApuracao in FalrrGerarDados.Tipos ;
      RelatorioLucroReal.Script.Variables['RepTitLalurApuracao'] := 'APURAÇÃO - IMPOSTO DE RENDA' ;

      RelatorioLucroReal.Script.Variables['VersaoDataHora'] := DateTimeToStr(fnow) ;

      LstrCnpj := fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel.Text]) ;
      RelatorioLucroReal.Script.Variables['EmpCnpj'] := LstrCnpj ;
      LstrRazaoSocial := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel.Text]) ;
      RelatorioLucroReal.Script.Variables['EmpNome'] := LstrRazaoSocial ;

      pExibirRelatorio(Self.Name, 'Relatório Apuração Lucro Real', RelatorioLucroReal);

    finally
      frxDBAjustesLacsParteA.DataSet := Nil ;
      frxDBDemonstrativoLacsParteA.DataSet := Nil ;
      frxDBAjustesLalurParteA.DataSet := Nil ;
      frxDBDemonstrativoLalurParteA.DataSet := Nil ;
      frxDBBaseNegativaLacsParteB.DataSet := Nil ;
      frxDBBaseNegativaLalurParteB.DataSet := Nil ;
      frxDBApuracaoLacsMestre.DataSet := Nil ;
      frxDBApuracaoLacsDetalhe.DataSet := Nil ;
      frxDBApuracaoLalurMestre.DataSet := Nil ;
      frxDBApuracaoLalurDetalhe.DataSet := Nil ;
    end ;
  end ;

end;

procedure TfrmApuracaoLucroRealRelatorio.edtEmpSelChange(Sender: TObject);
begin
  inherited;
  FBlnExercicioAlterado := True ;
end;

procedure TfrmApuracaoLucroRealRelatorio.edtEmpSelExit(Sender: TObject);
begin
  inherited;
  if not FBlnExercicioAlterado then
    exit ;

  if (not fEmptyStr(edtExercicio.Text)) and (not fEmptyStr(edtEmpSel.Text)) then
  begin
    if fValidarExercicioInformado(edtExercicio.Text, edtEmpSel.Text, FftForma, FecEncerramento) then
    begin
      ////cria o periodo de com o parametro.
      pAjustaPeriodoEncerramento(edtExercicio.Text, FecEncerramento, edtPeriodoInicial) ;
      pAjustaPeriodoEncerramento(edtExercicio.Text, FecEncerramento, edtPeriodoFinal) ;
    end
    else
    begin
      pLimparPeriodoEncerramento(edtPeriodoInicial) ;
      pLimparPeriodoEncerramento(edtPeriodoFinal) ;
      pSetFocus(TEditFocus(Sender));
    end;
  end
  else
  begin
    pLimparPeriodoEncerramento(edtPeriodoInicial) ;
    pLimparPeriodoEncerramento(edtPeriodoFinal) ;
  end;
end;

procedure TfrmApuracaoLucroRealRelatorio.edtEmpSelKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel, edtNomEmpSel, Nil, Key, arrEmpSel, False) Then
  Begin
    If fValidaCampos(edtEmpSel) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmApuracaoLucroRealRelatorio.edtExercicioChange(Sender: TObject);
begin
  inherited;
  FBlnExercicioAlterado := True ;
end;

procedure TfrmApuracaoLucroRealRelatorio.edtPeriodoFinalPropertiesChange(
  Sender: TObject);
begin
  inherited;
  FBlnExercicioAlterado := False ;
end;

procedure TfrmApuracaoLucroRealRelatorio.edtPeriodoInicialPropertiesChange(
  Sender: TObject);
begin
  inherited;
  FBlnExercicioAlterado := False ;
end;

procedure TfrmApuracaoLucroRealRelatorio.FormCreate(Sender: TObject);
begin
  inherited;
  FBlnExercicioAlterado := False ;
  FftForma := ftNada ;
  FecEncerramento := ecNada ;
  FalrrGerarDados := TApuracaoLucroRealRelatorio.Create() ;
  pCarregaTiposGroupCheckBox ;
end;

procedure TfrmApuracaoLucroRealRelatorio.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FalrrGerarDados) ;
  pLimparPeriodoEncerramento(edtPeriodoInicial) ;
  pLimparPeriodoEncerramento(edtPeriodoFinal) ;
end;

function TfrmApuracaoLucroRealRelatorio.fRetornaTiposSelecionados: TTipoLucroRealRelatorios;
var
  LintCnt: integer ;
begin
  result := [] ;
  for LintCnt := 0 to checkLacsLalur.Properties.Items.Count-1 do
  begin
    if checkLacsLalur.States[LintCnt] = cbsChecked then
    begin
      result := result + [TTipoLucroRealRelatorio(checkLacsLalur.Properties.Items.Items[LintCnt].Tag)] ;
    end ;
  end ;
end;

function TfrmApuracaoLucroRealRelatorio.fValidaBotaoConfirma: Boolean;
var
  LDictSelecionadoInicial: TDictionary<string, TDateTime> ;
  LDictSelecionadoFinal: TDictionary<string, TDateTime> ;
  LintCnt: integer ;
  LblnSelecionado: boolean ;
begin
  result := False ;

  LDictSelecionadoInicial := edtPeriodoInicial.Properties.Items.Objects[edtPeriodoInicial.ItemIndex] as TDictionary<string, TDateTime> ;
  LDictSelecionadoFinal := edtPeriodoFinal.Properties.Items.Objects[edtPeriodoFinal.ItemIndex] as TDictionary<string, TDateTime> ;

  if LDictSelecionadoInicial['inicio'] > LDictSelecionadoFinal['inicio'] then
  begin
    fMensagem('ATENÇÃO!', 'Periodo inválido!', ['&Ok']);
    pSetFocus(edtPeriodoInicial) ;
    exit ;
  end ;

  ///verifica se algum check foi selecionado
  LblnSelecionado := False ;
  for LintCnt := 0 to checkLacsLalur.Properties.Items.Count-1 do
  begin
    if checkLacsLalur.States[LintCnt] = cbsChecked then
    begin
      LblnSelecionado := True ;
      break
    end ;
  end ;

  if not LblnSelecionado then
  begin
    fMensagem('ATENÇÃO!', 'Pelo menos uma opção do Lacs/Lalur deve ser selecionada!', ['&Ok']);
    pSetFocus(checkLacsLalur) ;
    exit ;
  end ;

  result := True ;
end;

function TfrmApuracaoLucroRealRelatorio.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtPeriodoInicial) Then
    Begin
      if edtPeriodoInicial.ItemIndex = -1 then
      begin
        fMensagem('ATENÇÃO!', 'Periodo Inicial não selecionado!', ['&Ok']);
        Result := false ;
      end;
    End
    else If (Sender = edtPeriodoFinal) Then
    Begin
      if edtPeriodoFinal.ItemIndex = -1 then
      begin
        fMensagem('ATENÇÃO!', 'Periodo Final não selecionado!', ['&Ok']);
        Result := false ;
      end;
    End
    else If (Sender = edtEmpSel) Then
    begin
      if not fEmptyStr(edtEmpSel.Text) then
      Begin
        edtNomEmpSel.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel.Text], False);
        if fEmptyStr(edtNomEmpSel.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      else
      Begin
        edtNomEmpSel.Clear;
        edtEmpSel.Clear;
        fMensagem('ATENÇÃO!', 'Empresa deve ser preenchida!', ['&OK']);
        Result := False;
      End ;
    end
    else If (Sender = edtExercicio) Then
    begin
      if fEmptyStr(edtExercicio.text) then
      begin
        fMensagem('ATENÇÃO!', 'Exercício não informado!', ['&Ok']);
        Result := false ;
      end;

    end;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmApuracaoLucroRealRelatorio.pCarregaTiposGroupCheckBox;
var
  LintCnt: integer ;
begin
  for LintCnt := 0 to checkLacsLalur.Properties.Items.Count-1 do
  begin
    checkLacsLalur.Properties.Items.Items[LintCnt].Tag := Integer(TTipoLucroRealRelatorio(LintCnt)) ;
  end ;
end;

end.
