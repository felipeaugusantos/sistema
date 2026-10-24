unit Contabilidade.View.ApuracaoLucroPresumidoRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox,
  cxCheckGroup, cxTextEdit, cxMaskEdit, cxDropDownEdit, EditFocus, cxLabel,
  Data.DB, Datasnap.DBClient, UniClientDataSet,
  Contabilidade.Interfaces.ApuracaoLucroPresumido, frxDBSet, frxExportPDF;

type
  TfrmApuracaoLucroPresumidoRelatorio = class(TfrmPaiContabilidade)
    btnConfirma: TBitBtnLocked;
    cxLabel1: TcxLabel;
    edtExercicio: TEditFocus;
    cxLabel4: TcxLabel;
    edtPeriodoInicial: TcxComboBox;
    cxLabel2: TcxLabel;
    edtPeriodoFinal: TcxComboBox;
    cckApuracao: TcxCheckGroup;
    cxLabel7: TcxLabel;
    edtEmpSel: TEditFocus;
    edtNomEmpSel: TEditFocus;
    cdsBaseCalculoCSLL: TUniClientDataSet;
    cdsValorApuradoCSLL: TUniClientDataSet;
    cdsBaseCalculoIRPJ: TUniClientDataSet;
    cdsValorApuradoIRPJ: TUniClientDataSet;
    cdsBaseCalculoCSLLAUTOINCREM: TLargeintField;
    cdsBaseCalculoCSLLCODIGO: TStringField;
    cdsBaseCalculoCSLLDESCRI: TStringField;
    cdsBaseCalculoCSLLTRIM01: TFloatField;
    cdsBaseCalculoCSLLTRIM02: TFloatField;
    cdsBaseCalculoCSLLTRIM03: TFloatField;
    cdsBaseCalculoCSLLTRIM04: TFloatField;
    cdsBaseCalculoCSLLTRIMTT: TFloatField;
    cdsValorApuradoCSLLAUTOINCREM: TLargeintField;
    cdsValorApuradoCSLLCODIGO: TStringField;
    cdsValorApuradoCSLLDESCRI: TStringField;
    cdsValorApuradoCSLLTRIM01: TFloatField;
    cdsValorApuradoCSLLTRIM02: TFloatField;
    cdsValorApuradoCSLLTRIM03: TFloatField;
    cdsValorApuradoCSLLTRIM04: TFloatField;
    cdsValorApuradoCSLLTRIMTT: TFloatField;
    cdsBaseCalculoIRPJAUTOINCREM: TLargeintField;
    cdsBaseCalculoIRPJCODIGO: TStringField;
    cdsBaseCalculoIRPJDESCRI: TStringField;
    cdsBaseCalculoIRPJTRIM01: TFloatField;
    cdsBaseCalculoIRPJTRIM02: TFloatField;
    cdsBaseCalculoIRPJTRIM03: TFloatField;
    cdsBaseCalculoIRPJTRIM04: TFloatField;
    cdsBaseCalculoIRPJTRIMTT: TFloatField;
    cdsValorApuradoIRPJAUTOINCREM: TLargeintField;
    cdsValorApuradoIRPJCODIGO: TStringField;
    cdsValorApuradoIRPJDESCRI: TStringField;
    cdsValorApuradoIRPJTRIM01: TFloatField;
    cdsValorApuradoIRPJTRIM02: TFloatField;
    cdsValorApuradoIRPJTRIM03: TFloatField;
    cdsValorApuradoIRPJTRIM04: TFloatField;
    cdsValorApuradoIRPJTRIMTT: TFloatField;
    frxDBBaseCalculoCSLL: TfrxDBDataset;
    frxDBValorApuradoCSLL: TfrxDBDataset;
    frxDBBaseCalculoIRPJ: TfrxDBDataset;
    frxDBValorApuradoIRPJ: TfrxDBDataset;
    frxPDFExport: TfrxPDFExport;
    RelatorioLucroPresumido: TfrxReport;
    cdsBaseCalculoCSLLGRUPO: TIntegerField;
    cdsValorApuradoCSLLGRUPO: TIntegerField;
    cdsBaseCalculoIRPJGRUPO: TIntegerField;
    cdsValorApuradoIRPJGRUPO: TIntegerField;
    procedure edtEmpSelKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtExercicioExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function fValidaBotaoConfirma: Boolean;
    function fProcessaLucroDados(const AdtaIni, AdtaFin: TDateTime;
                                 const AstrCodEmp: String;
                                 const AintExercicio: Integer;
                                 var   AstrMensagem: String): Boolean ;
    procedure pCopiaColaApuracao(const AcdsOrigem: TUniClientDataSet; var AcdsDestino: TUniClientDataSet; const AdtaIni, AdtaFin: TDateTime) ;
    function fPeriodoEmIntervaloDatas(const AintPeriodo: Integer; const AdtaIni, AdtaFin: TDateTime): Boolean ;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untConsultas, untTypesSistema, untFuncoesSimples,
     System.Generics.Collections, DateUtils, Contabilidade.Funcoes,
     Contabilidade.Classes.ApuracaoLucroRealLalurLacs, Contabilidade.Interfaces,
     Contabilidade.Interfaces.SharedLucroPresumido,
     Contabilidade.Funcoes.LucroPresumido,
     Contabilidade.Classes.ApuracaoLucroPresumidoFactory ;

{$R *.dfm}

const
  OPCAO_CSLL = 0 ;
  OPCAO_IRPJ = 1 ;


procedure TfrmApuracaoLucroPresumidoRelatorio.btnConfirmaClick(Sender: TObject);
var
  LDictSelecionadoInicial: TDictionary<string, TDateTime> ;
  LDictSelecionadoFinal: TDictionary<string, TDateTime> ;
  LstrCnpj, LstrRazaoSocial: string ;
  LdtaInicio, LdtaFinal: TDateTime ;
  LstrMensagem: String ;
begin
  inherited;
  if not fValidaCampos(edtExercicio) then
    exit ;

  if not fValidaCampos(edtEmpSel) then
    exit ;

  if not fValidaCampos(edtPeriodoInicial) then
    exit ;

  if not fValidaCampos(edtPeriodoFinal) then
    exit ;

  if not fValidaBotaoConfirma then
    Exit ;

  LDictSelecionadoInicial := edtPeriodoInicial.Properties.Items.Objects[edtPeriodoInicial.ItemIndex] as TDictionary<string, TDateTime> ;
  LDictSelecionadoFinal := edtPeriodoFinal.Properties.Items.Objects[edtPeriodoFinal.ItemIndex] as TDictionary<string, TDateTime> ;

  LdtaInicio := LDictSelecionadoInicial['inicio'] ;
  LdtaFinal := LDictSelecionadoFinal['final'] ;
  LstrCnpj := fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel.Text]) ;
  LstrRazaoSocial := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel.Text]) ;

  if not fProcessaLucroDados(LdtaInicio, LdtaFinal, edtEmpSel.Text, StrToInt(edtExercicio.Text), LstrMensagem) then
  begin
    fMensagem('ATENÇÃO!', LstrMensagem, ['&Ok']);
    exit ;
  end ;

  (RelatorioLucroPresumido.FindObject('pgBaseCalculoCsll') as TfrxReportPage).Visible := cckApuracao.States[OPCAO_CSLL] = cbsChecked ;
  (RelatorioLucroPresumido.FindObject('pgValorApuradoCsll') as TfrxReportPage).Visible := cckApuracao.States[OPCAO_CSLL] = cbsChecked ;

  (RelatorioLucroPresumido.FindObject('pgBaseCalculoIrpj') as TfrxReportPage).Visible := cckApuracao.States[OPCAO_IRPJ] = cbsChecked ;
  (RelatorioLucroPresumido.FindObject('pgValorApuradoIrpj') as TfrxReportPage).Visible := cckApuracao.States[OPCAO_IRPJ] = cbsChecked ;

  RelatorioLucroPresumido.Script.Variables['RepTitBaseCalculoCsll'] := 'APURAÇÃO DA CONTRIBUIÇÃO SOCIAL - LUCRO PRESUMIDO' ;
  RelatorioLucroPresumido.Script.Variables['RepTitBaseCalculoIrpj'] := 'APURAÇÃO DO IMPOSTO DE RENDA - LUCRO PRESUMIDO' ;
  RelatorioLucroPresumido.Script.Variables['DtaIni'] := DateToStr(LdtaInicio) ;
  RelatorioLucroPresumido.Script.Variables['DtaFin'] := DateToStr(LdtaFinal) ;

  RelatorioLucroPresumido.Script.Variables['VersaoDataHora'] := DateTimeToStr(fnow) ;

  RelatorioLucroPresumido.Script.Variables['EmpCnpj'] := LstrCnpj ;
  RelatorioLucroPresumido.Script.Variables['EmpNome'] := LstrRazaoSocial ;

  pExibirRelatorio(Self.Name, 'Relatório Apuração Lucro Presumido', RelatorioLucroPresumido);

end;

procedure TfrmApuracaoLucroPresumidoRelatorio.edtEmpSelKeyPress(Sender: TObject;
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

procedure TfrmApuracaoLucroPresumidoRelatorio.edtExercicioExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(TEditFocus(Sender).Text) then
  begin
    pLimparPeriodoEncerramento(edtPeriodoInicial) ;
    pLimparPeriodoEncerramento(edtPeriodoFinal) ;
    exit ;
  end ;
  pAjustaPeriodoEncerramento(edtExercicio.Text, ecTrimestral, edtPeriodoInicial) ;
  pAjustaPeriodoEncerramento(edtExercicio.Text, ecTrimestral, edtPeriodoFinal) ;

end;

procedure TfrmApuracaoLucroPresumidoRelatorio.FormCreate(Sender: TObject);
begin
  inherited;
  cdsBaseCalculoCSLL.CreateDataSet ;
  cdsValorApuradoCSLL.CreateDataSet ;
  cdsBaseCalculoIRPJ.CreateDataSet ;
  cdsValorApuradoIRPJ.CreateDataSet ;
end;

procedure TfrmApuracaoLucroPresumidoRelatorio.FormDestroy(Sender: TObject);
begin
  inherited;
  pLimparPeriodoEncerramento(edtPeriodoInicial) ;
  pLimparPeriodoEncerramento(edtPeriodoFinal) ;
end;

function TfrmApuracaoLucroPresumidoRelatorio.fValidaCampos(Sender: TWinControl;
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

procedure TfrmApuracaoLucroPresumidoRelatorio.pCopiaColaApuracao(
  const AcdsOrigem: TUniClientDataSet; var AcdsDestino: TUniClientDataSet;
  const AdtaIni, AdtaFin: TDateTime);
var
  LintPeriod: Integer ;
  LfltSoma: Double ;
begin
  AcdsOrigem.DisableControls ;
  AcdsDestino.DisableControls ;
  try
    AcdsOrigem.First ;
    while not AcdsOrigem.Eof do
    begin
      AcdsDestino.Append ;
      AcdsDestino.FieldByName('GRUPO').Value := 1 ;
      AcdsDestino.FieldByName('AUTOINCREM').Value := AcdsOrigem.FieldByName('AUTOINCREM').Value ;
      AcdsDestino.FieldByName('CODIGO').Value := AcdsOrigem.FieldByName('CODIGO').Value ;
      AcdsDestino.FieldByName('DESCRI').Value := AcdsOrigem.FieldByName('DESCRI').Value ;
      LfltSoma := 0.00 ;
      for LintPeriod := 1 to 4 do
      begin
        if fPeriodoEmIntervaloDatas(LintPeriod, AdtaIni, AdtaFin) then
        begin
          AcdsDestino.FieldByName('TRIM'+fStrZero(LintPeriod,2)).Value := AcdsOrigem.FieldByName('PERIOD_'+fStrZero(LintPeriod,2)).Value ;
          LfltSoma := LfltSoma + AcdsDestino.FieldByName('TRIM'+fStrZero(LintPeriod,2)).AsFloat ;
        end ;
      end ;

      if (not AcdsOrigem.FieldByName('PERIOD_01').IsNull) or
         (not AcdsOrigem.FieldByName('PERIOD_02').IsNull) or
         (not AcdsOrigem.FieldByName('PERIOD_03').IsNull) or
         (not AcdsOrigem.FieldByName('PERIOD_04').IsNull) then
        AcdsDestino.FieldByName('TRIMTT').Value := LfltSoma ;

      AcdsDestino.Post ;
      AcdsOrigem.Next ;
    end ;
    AcdsDestino.First ;
  finally
    AcdsOrigem.EnableControls ;
    AcdsDestino.EnableControls ;
  end ;
end;

function TfrmApuracaoLucroPresumidoRelatorio.fPeriodoEmIntervaloDatas(
  const AintPeriodo: Integer; const AdtaIni, AdtaFin: TDateTime): Boolean;
var
  AintAno: Integer ;
  AdtaCalc: TDateTime ;
  AarrMesInicial: array[1..4] of integer ;
begin
  AarrMesInicial[1] := 1 ;
  AarrMesInicial[2] := 4 ;
  AarrMesInicial[3] := 7 ;
  AarrMesInicial[4] := 10 ;

  AintAno := YearOf(AdtaIni) ;
  AdtaCalc := EncodeDate(AintAno, AarrMesInicial[AintPeriodo], 1) ;

  Result :=  (AdtaCalc >= AdtaIni) and (AdtaCalc <= AdtaFin) ;
end;

function TfrmApuracaoLucroPresumidoRelatorio.fProcessaLucroDados(
  const AdtaIni, AdtaFin: TDateTime;
  const AstrCodEmp: String;
  const AintExercicio: Integer;
  var   AstrMensagem: String): Boolean;
var
  LObjDadosApuracaoCsll: IDadosApuracaoLucroPresumido ;
  LObjDadosApuracaoIrpj: IDadosApuracaoLucroPresumido ;
  LcdsApuracaoBaseCalculoCsll : TUniClientDataSet ;
  LcdsApuracaoValorCsll : TUniClientDataSet ;
  LcdsApuracaoBaseCalculoIrpj : TUniClientDataSet ;
  LcdsApuracaoValorIrpj : TUniClientDataSet ;
  LobjLinhaSemDadosCsll: ITipoLinhasSemInformacao ;
  LobjLinhaSemDadosIrpj: ITipoLinhasSemInformacao ;
begin
  Result := False ;
  cdsBaseCalculoCSLL.EmptyDataSet ;
  cdsValorApuradoCSLL.EmptyDataSet ;
  cdsBaseCalculoIRPJ.EmptyDataSet ;
  cdsValorApuradoIRPJ.EmptyDataSet ;

  LcdsApuracaoBaseCalculoCsll := Nil ;
  LcdsApuracaoValorCsll := Nil ;
  LcdsApuracaoBaseCalculoIrpj := Nil ;
  LcdsApuracaoValorIrpj := Nil ;

  frxDBBaseCalculoCSLL.DataSet := Nil ;
  frxDBValorApuradoCSLL.DataSet := Nil ;
  frxDBBaseCalculoIRPJ.DataSet := Nil ;
  frxDBValorApuradoIRPJ.DataSet := Nil ;
  try
    if cckApuracao.States[OPCAO_CSLL] = cbsChecked then
    begin
      LobjLinhaSemDadosCsll := TFactoryLinhasSemInformacao.New.fConfigura(tlpCSLL) ;

      LcdsApuracaoBaseCalculoCsll := TUniClientDataSet.Create(Nil) ;
      LcdsApuracaoValorCsll := TUniClientDataSet.Create(Nil) ;

      pCriarEstruturaCDSLucroPresumido(LcdsApuracaoBaseCalculoCsll) ;
      pCriarEstruturaCDSLucroPresumido(LcdsApuracaoValorCsll) ;


      LObjDadosApuracaoCsll := fCarregaApuracaoLucroPresumido(tlpCSLL)
                                 .ProcessaLanCon(False)
                                 .fCarrega(AstrCodEmp, AintExercicio, AstrMensagem) ;

      if not Assigned(LObjDadosApuracaoCsll) then
        Exit ;

      fProcessaApuracaoLucroPresumido(tlpCSLL,
                                      LObjDadosApuracaoCsll,
                                      LcdsApuracaoBaseCalculoCsll,
                                      LcdsApuracaoValorCsll,
                                      LobjLinhaSemDadosCsll) ;

      pCopiaColaApuracao(LcdsApuracaoBaseCalculoCsll, cdsBaseCalculoCSLL, AdtaIni, AdtaFin);
      pCopiaColaApuracao(LcdsApuracaoValorCsll, cdsValorApuradoCSLL, AdtaIni, AdtaFin);
    end ;

    if cckApuracao.States[OPCAO_IRPJ] = cbsChecked then
    begin
      LobjLinhaSemDadosIrpj := TFactoryLinhasSemInformacao.New.fConfigura(tlpIRPJ) ;

      LcdsApuracaoBaseCalculoIrpj := TUniClientDataSet.Create(Nil) ;
      LcdsApuracaoValorIrpj := TUniClientDataSet.Create(Nil) ;

      pCriarEstruturaCDSLucroPresumido(LcdsApuracaoBaseCalculoIrpj) ;
      pCriarEstruturaCDSLucroPresumido(LcdsApuracaoValorIrpj) ;

      LObjDadosApuracaoIrpj := fCarregaApuracaoLucroPresumido(tlpIRPJ)
                                 .ProcessaLanCon(False)
                                 .fCarrega(AstrCodEmp, AintExercicio, AstrMensagem) ;

      if not Assigned(LObjDadosApuracaoIrpj) then
        Exit ;

      fProcessaApuracaoLucroPresumido(tlpIRPJ,
                                      LObjDadosApuracaoIrpj,
                                      LcdsApuracaoBaseCalculoIrpj,
                                      LcdsApuracaoValorIrpj,
                                      LobjLinhaSemDadosIrpj) ;

      pCopiaColaApuracao(LcdsApuracaoBaseCalculoIrpj, cdsBaseCalculoIrpj, AdtaIni, AdtaFin);
      pCopiaColaApuracao(LcdsApuracaoValorIrpj, cdsValorApuradoIrpj, AdtaIni, AdtaFin);
    end ;

    frxDBBaseCalculoCSLL.DataSet := cdsBaseCalculoCSLL ;
    frxDBValorApuradoCSLL.DataSet := cdsValorApuradoCSLL ;
    frxDBBaseCalculoIRPJ.DataSet := cdsBaseCalculoIRPJ ;
    frxDBValorApuradoIRPJ.DataSet := cdsValorApuradoIRPJ ;
  finally
    if Assigned(LcdsApuracaoBaseCalculoCsll) then
    begin
      FreeAndNil(LcdsApuracaoBaseCalculoCsll) ;
      FreeAndNil(LcdsApuracaoValorCsll) ;
    end ;

    if Assigned(LcdsApuracaoBaseCalculoIrpj) then
    begin
      FreeAndNil(LcdsApuracaoBaseCalculoIrpj) ;
      FreeAndNil(LcdsApuracaoValorIrpj) ;
    end ;
  end ;

  Result := True  ;
end;

function TfrmApuracaoLucroPresumidoRelatorio.fValidaBotaoConfirma: Boolean;
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
  for LintCnt := 0 to cckApuracao.Properties.Items.Count-1 do
  begin
    if cckApuracao.States[LintCnt] = cbsChecked then
    begin
      LblnSelecionado := True ;
      break
    end ;
  end ;

  if not LblnSelecionado then
  begin
    fMensagem('ATENÇÃO!', 'Pelo menos uma opção de apuração deve ser selecionada!', ['&Ok']);
    pSetFocus(cckApuracao) ;
    exit ;
  end ;

  result := True ;
end;

end.
