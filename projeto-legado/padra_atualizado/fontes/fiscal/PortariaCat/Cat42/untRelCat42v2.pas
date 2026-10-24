unit untRelCat42v2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiRelatorio, frxDesgn, frxClass,
  frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS,
  frxExportRTF, Vcl.AppEvnts, Vcl.StdCtrls, EditFocus, QColorLabel,
  Vcl.ExtCtrls, BitBtnLockedIncrem, Vcl.Buttons, Vcl.Mask, MaskEditFocus,
  Data.DB, Datasnap.DBClient, UniClientDataSet, DateUtils, untTypesSistema,
  Vcl.ComCtrls, untExcel, untGeraExcel, madExcept, DASQLMonitor, UniSQLMonitor,
  untTDadosLogCat42, untTDadosRegistraLogCat42, System.Generics.Collections,
  frxExportCSVTestabilidade, RLFilters, RLDraftFilter, Vcl.Menus;

type
  TfrmRelCat42v2 = class(TfrmPaiRelatorio)
    frxReportJ: TfrxReport;
    cdsRelatorio: TUniClientDataSet;
    cdsRelatorioCampo02: TDateField;
    cdsRelatorioCampo03: TStringField;
    cdsRelatorioCampo04: TStringField;
    cdsRelatorioCampo05: TStringField;
    cdsRelatorioCampo06: TStringField;
    cdsRelatorioCampo07: TStringField;
    cdsRelatorioCampo08: TStringField;
    cdsRelatorioCampo09: TStringField;
    cdsRelatorioCampo10: TStringField;
    cdsRelatorioCampo11: TFloatField;
    cdsRelatorioCampo12: TFloatField;
    cdsRelatorioCampo13: TFloatField;
    cdsRelatorioCampo14: TFloatField;
    cdsRelatorioCampo15: TFloatField;
    cdsRelatorioCampo17: TFloatField;
    cdsRelatorioCampo18: TFloatField;
    cdsRelatorioCampo19: TFloatField;
    cdsRelatorioCampo20: TFloatField;
    cdsRelatorioCampo21: TFloatField;
    cdsRelatorioCampo22: TFloatField;
    cdsRelatorioCampo23: TFloatField;
    cdsRelatorioCampo24: TFloatField;
    cdsRelatorioCampo25: TFloatField;
    cdsRelatorioCampo26: TFloatField;
    cdsRelatorioCampo27: TFloatField;
    cdsRelatorioCampo16: TFloatField;
    cdsRelatorioMERCADORIA: TStringField;
    btnDeletarPeriodo: TBitBtnLocked;
    cdsRelatorioCODITE: TStringField;
    cdsRelatorioUNIDADE: TStringField;
    cdsRelatorioNOMEMP: TStringField;
    cdsRelatorioIES: TStringField;
    cdsRelatorioALIQUOTA: TFloatField;
    cdsRelatorioCampo01: TIntegerField;
    cdsRelatorioINCVEN: TStringField;
    lblOperacao: TLabel;
    pgbProgresso: TProgressBar;
    pnlDadosSelecao: TPanel;
    lblCodEmp: TLabel;
    lblCodProd: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodPro: TEditFocus;
    edtNomPro: TEditFocus;
    gpbEnquadramento: TGroupBox;
    chkSaidaConsumidor: TCheckBox;
    chkFatorGerador: TCheckBox;
    chkSaidaSubsequente: TCheckBox;
    chkSaidaOutroEstado: TCheckBox;
    chkSaidaParaComercializacao: TCheckBox;
    gpbSelecionarTabelaInventario: TGroupBox;
    btnEscolherTabela: TSpeedButton;
    lblTabInventario: TLabel;
    gpbValorIVANFX60Inventario: TGroupBox;
    Label5: TLabel;
    edtValIva: TEditFocus;
    chkCalcularST: TCheckBox;
    gpbDataEntrada: TGroupBox;
    lblDtaInicial: TLabel;
    lblDtaFinal: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    chkUtilizarConfigCfopCstEnquadramentos: TCheckBox;
    chkSomaIcmsRetido: TCheckBox;
    btnCriarTabelas: TSpeedButton;
    pnlInconsistencia: TPanel;
    gpbInconsistencias: TGroupBox;
    chkInvSemSaldoSemSubstTributSemMovtoMes: TCheckBox;
    chkInvSemSaldoComSubstTributSemMovtoMes: TCheckBox;
    chkInvComSaldoSemSubstTributSemMovtoMes: TCheckBox;
    chkInvComSaldoSemSubstTributComMovtoMes: TCheckBox;
    chkSaldoInicialQuantidadInicialNegativa: TCheckBox;
    chkSldFinalQtFinalNegQtVendaMaiorCompra: TCheckBox;
    chkNotasEntradaSemSubstituicaTributaria: TCheckBox;
    pnlButtonInconsistencia: TPanel;
    spdMarcarDesmarcarTodos: TButton;
    pnlApuracao: TPanel;
    Panel1: TPanel;
    gpbApuracao: TGroupBox;
    Panel3: TPanel;
    Panel2: TPanel;
    btnSugestao: TSpeedButton;
    TimerPnlInformacao: TTimer;
    pnlInformacao: TPanel;
    lblInformacao_1: TLabel;
    gpbConsiderarInconsistencia: TGroupBox;
    chkConsiderarInconsistenciaQuatro: TCheckBox;
    chkGerarApuracao: TCheckBox;
    chkConsiderarInconsistenciaCincoEntradaSemSt: TCheckBox;
    chkConsiderarInconsistenciaCincoTransfSemSt: TCheckBox;
    Button1: TButton;
    chkTotalizarValorContabil: TCheckBox;
    cdsRelatorioVALORCONTABIL: TFloatField;
    cdsRelContabil: TUniClientDataSet;
    FloatField19: TFloatField;
    cdsRelContabilCST: TStringField;
    cdsRelContabilCFOP: TStringField;
    frxDBDataset1: TfrxDBDataset;
    chkConsiderarDataEmissaoEntradasTransferencia: TCheckBox;
    chkSaldoMovimentacao: TCheckBox;
    chkUtilizarPrecoCompraCalcICMSSuportado: TCheckBox;
    lblUtilizarPrecoCompraCalcICMSSuportado: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pnlUtilizarPrecoCompraCalcICMSSuportado: TPanel;
    Button2: TButton;
    mmUtilizarPrecoCompraCalcICMSSuportado: TMemo;
    chkGerarComSaldoZero: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnDeletarPeriodoClick(Sender: TObject);
    procedure btnImprimirErro(Sender: TWinControl; strMsgErro: string; E: Exception);
    procedure btnEscolherTabelaClick(Sender: TObject);
    procedure btnCriarTabelasClick(Sender: TObject);
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProExit(Sender: TObject);
    procedure chkEnquadramentoClick(Sender: TObject);
    procedure chkUtilizarConfigCfopCstEnquadramentosClick(Sender: TObject);
    procedure btnMarcarDesmarcarTodosClick(Sender: TObject);
    procedure chkInvSemSaldoSemSubstTributSemMovtoMesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSugestaoClick(Sender: TObject);
    procedure TimerPnlInformacaoTimer(Sender: TObject);
    procedure mskDtaIniExit(Sender: TObject);
    procedure btnImprimirExit(Sender: TObject);
    procedure chkGerarApuracaoClick(Sender: TObject);
    procedure mskDtaFinExit(Sender: TObject);
    procedure chkConsiderarInconsistenciaQuatroClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure chkUtilizarPrecoCompraCalcICMSSuportadoMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure lblUtilizarPrecoCompraCalcICMSSuportadoClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfigurarClick(Sender: TObject);
  private
    strTabelaInventario: string;
    tmeHoraInicioProcessamento: TTime;
    tmeHoraFinalProcessamento: TTime;
    arrEmpresa: TConsultasArray;
    arrProduto: TConsultasArray;
    arrLinhaGrupo: TConsultasArray;
    stlEnquadramento: TStringList;
    stlInconsistencia: TStringList;

    dadosRegistraLogCat42: TDadosRegistraLogCat42;

    function fRetTabelaInventario: string;
    function fRepositorioDadosLogCAT42(lstDadosLogCat42: TObjectList<TDadosLogCat42>): TObjectList<TDadosLogCat42>;
    function fLeituraOpcoesSelecionadoTexto(gpbGroupBox: TGroupBox): string;

    procedure pCriarTabelasCat;
    procedure pPreparaLayoutImpressao;
    procedure pCarregaPeriodoMesAtual;
    procedure pValidacoes(blnUtilizarConfigCfopCstEnquadramentos: Boolean = False);
    procedure pDadosGravados_CAT42DADOS_CAT42SALDOS;
    procedure pAjutaHeight_CAT42DADOS_CAT42SALDOS(blnAjustaHeight: Boolean);
    procedure pHabilitaDesabilitaOpcaoProcessamento(blnVerificaOpcoesSelecionadas: Boolean = False);
    procedure pGeraLogConfiguracaoSelecionadaCAT42;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmRelCat42v2: TfrmRelCat42v2;

implementation

uses untTDadosAberturaExportacaoCat42, untTReImpressaoRelatorioCat42, untConsultas, untFuncoes, Uni,
     untExportaSpedFiscalInventario, untTipo, untTUtilidadeCat42, untTCat42, untTConstantesCfop;

{$R *.dfm}

procedure TfrmRelCat42v2.btnConfigurarClick(Sender: TObject);
  var
    qryAux: TUniQuery;
begin
  {inherited;}
  if fMensagem('CONFIRMAÇÃO',
               'Deseja mesmo modificar o campo CODITE de 5 p/ 60 caracteres tabela CAT_42 DADOS/SALDOS'
               + chr(13) +
               'Continuar' + '?', ['&Sim','&Não'], 2) = 2 then
  Exit;

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('ALTER TABLE CAT_42_DADOS MODIFY CAT_CODITE VARCHAR(60) DEFAULT NULL');
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Add('ALTER TABLE CAT_42_SALDOS MODIFY CAT_CODITE VARCHAR(60) DEFAULT NULL');
      ExecSQL;
    end;

    fMensagem('AVISO', 'Modificação realizada com sucesso!', ['Ok']);
    btnConfigurar.Visible := false;
  finally
    qryAux.Free;
  end;
end;

procedure TfrmRelCat42v2.btnCriarTabelasClick(Sender: TObject);
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE IF NOT EXISTS CAT_42_DADOS (');
      SQL.Add('  AUTOINCREM VARCHAR(20) NOT NULL,');
      SQL.Add('  CAT_CAMP01 INT(11) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP02 VARCHAR(10) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP03 VARCHAR(44) DEFAULT "",');
      SQL.Add('  CAT_CAMP04 VARCHAR(20) DEFAULT "",');
      SQL.Add('  CAT_CAMP05 CHAR(1) DEFAULT "",');
      SQL.Add('  CAT_CAMP06 CHAR(3) DEFAULT "",');
      SQL.Add('  CAT_CAMP07 VARCHAR(12) DEFAULT "",');
      SQL.Add('  CAT_CAMP08 VARCHAR(8) DEFAULT "",');
      SQL.Add('  CAT_CAMP09 CHAR(4) DEFAULT "",');
      SQL.Add('  CAT_CAMP10 VARCHAR(5) DEFAULT "",');
      SQL.Add('  CAT_CAMP11 DECIMAL(12,4) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP12 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP13 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP14 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP15 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP16 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP17 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP18 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP19 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP20 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP21 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP22 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP23 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP24 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP25 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP26 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP27 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_MESANO VARCHAR(7) DEFAULT NULL,');
      SQL.Add('  CAT_CODEMP CHAR(3) DEFAULT NULL,');
      SQL.Add('  CAT_CODITE VARCHAR(5) DEFAULT NULL,');
      SQL.Add('  CAT_INCVEN VARCHAR(20) DEFAULT NULL,');
      SQL.Add('  VALORCONTABIL DECIMAL(12,2) DEFAULT NULL');
      SQL.Add('  PRIMARY KEY (AUTOINCREM),');
      SQL.Add('  KEY FK_CAT42_DADOS_01 (CAT_CODEMP),');
      SQL.Add('  KEY IDX_CAT42_02 (CAT_MESANO, CAT_CODEMP),');
      SQL.Add('  KEY IDX_CAT42_03 (CAT_CODEMP, CAT_MESANO),');
      SQL.Add('  CONSTRAINT FK_CAT42_DADOS_01 FOREIGN KEY (CAT_CODEMP) REFERENCES CADEMP (EMP_CODEMP)');
      SQL.Add(') ENGINE=INNODB DEFAULT CHARSET=latin1');
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE IF NOT EXISTS CAT_42_SALDOS (');
      SQL.Add('  AUTOINCREM VARCHAR(20) NOT NULL,');
      SQL.Add('  CAT_MESANO VARCHAR(7) DEFAULT NULL,');
      SQL.Add('  CAT_CODEMP CHAR(3) DEFAULT NULL,');
      SQL.Add('  CAT_CODITE VARCHAR(5) DEFAULT NULL,');
      SQL.Add('  CAT_QTDINI DECIMAL(12,2) DEFAULT 0.00,');
      SQL.Add('  CAT_QTDFIN DECIMAL(12,2) DEFAULT 0.00,');
      SQL.Add('  CAT_SALINI DECIMAL(12,2) DEFAULT 0.00,');
      SQL.Add('  CAT_SALFIN DECIMAL(12,2) DEFAULT 0.00,');
      SQL.Add('  PRIMARY KEY (AUTOINCREM),');
      SQL.Add('  KEY FK_CAT_42_SALDOS_01 (CAT_CODEMP),');
      SQL.Add('  KEY IDX_CAT42_02 (CAT_MESANO, CAT_CODEMP),');
      SQL.Add('  KEY IDX_CAT42_03 (CAT_CODEMP, CAT_MESANO),');
      SQL.Add('  CONSTRAINT FK_CAT_42_SALDOS_02 FOREIGN KEY (CAT_CODEMP) REFERENCES CADEMP (EMP_CODEMP)');
      SQL.Add(') ENGINE=INNODB DEFAULT CHARSET=latin1');
      ExecSQL;
    end;
  finally
    qryAux.Free;
  end;
end;

procedure TfrmRelCat42v2.btnDeletarPeriodoClick(Sender: TObject);
  function fValidaEmpresaInformada(strEmpresa: string): boolean;
    var
      qryAux: TUniQuery;
  begin
    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'SELECT COUNT(1) AS QTD FROM CADEMP WHERE EMP_CODEMP = :CODEMP ';
        ParamByName('CODEMP').AsString := strEmpresa;
        Open;

        Result := FieldByName('QTD').AsInteger > 0;
      end;
    finally
      qryAux.Free;
    end;
  end;


  function fValidaPeriodoDigitado(strMesAno: string): boolean;
  begin
    Result := False;
    try
      StrToDate('01/' + strMesAno);
    except
      Result := True;
    end;
  end;

  var
    blnRetpDeletarPeriodoEmpresa: Boolean;
    strMesanoExcluir, strEmpresaExcluir: string;
    abertura: TDadosAberturaExportacaoCat42;
    objUtilidadeCat42: TUtilidadeCat42;
begin
  pnlInfo.Caption := 'Deletando dados do período...';
  btnDeletarPeriodo.Enabled := False;
  btnImprimir.Enabled := False;
  pnlInfo.Repaint;

  if InputQuery('Aviso', 'Informe um período para exclusão, ex: "MM/YYYY"', strMesanoExcluir) then
  begin
    if (Length(strMesanoExcluir) <> 7) or (fValidaPeriodoDigitado(strMesanoExcluir)) then
    begin
      fMensagem('', 'Período Inválido, Favor Digitar nas Normas "MM/YYYY"!', ['&Ok']);
      btnDeletarPeriodo.Enabled := True;
      btnImprimir.Enabled := True;
      pnlInfo.Caption := '';
      pnlInfo.Repaint;
      Exit;
    end;

    if InputQuery('Aviso', 'Informe a empresa para exclusão, ex: "001"', strEmpresaExcluir) then
    begin
      if not fValidaEmpresaInformada(strEmpresaExcluir) then
      begin
        fMensagem('', 'Código de Empresa Inválido!', ['&Ok']);
        btnDeletarPeriodo.Enabled := True;
        btnImprimir.Enabled := True;
        pnlInfo.Caption := '';
        pnlInfo.Repaint;
        Exit;
      end;

      abertura := TDadosAberturaExportacaoCat42.Create(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), edtCodEmp.Text);
      objUtilidadeCat42 := TUtilidadeCat42.Create;
      try
        try
          objUtilidadeCat42.pDeletarPeriodoEmpresa(blnRetpDeletarPeriodoEmpresa, strMesanoExcluir, strEmpresaExcluir);

          if blnRetpDeletarPeriodoEmpresa then
          begin

            dadosRegistraLogCat42:= TDadosRegistraLogCat42.Create;
            try
              dadosRegistraLogCat42.pRegistraLogCat42PeriodoDeletado(strMesanoExcluir, strEmpresaExcluir);
            finally
              dadosRegistraLogCat42.Free;
            end;

            fMensagem('AVISO', 'Registros do Período Deletados com Sucesso!', ['Ok']);
            pDadosGravados_CAT42DADOS_CAT42SALDOS;

          end else
            fMensagem('AVISO', 'Não Existe Movimentação Parcial ou Total Gravadas na Base de Dados para Período Informado: ' + strMesanoExcluir + ' na Empresa: ' + strEmpresaExcluir + '!', ['Ok']);

          btnDeletarPeriodo.Enabled := True;
          btnImprimir.Enabled := True;
          pgbProgresso.Position := 0;
          pnlInfo.Caption := '';
          pnlInfo.Repaint;

        except
          on e: Exception do
          begin
            pDadosGravados_CAT42DADOS_CAT42SALDOS;
            fMensagem('AVISO', e.Message, ['Ok']);
            btnDeletarPeriodo.Enabled := True;
            btnImprimir.Enabled := True;
            pgbProgresso.Position := 0;
            pnlInfo.Caption := '';
            pnlInfo.Repaint;
          end;
        end;
      finally
        abertura.Free;
        objUtilidadeCat42.Free;
      end;
    end;
  end;
end;

procedure TfrmRelCat42v2.btnEscolherTabelaClick(Sender: TObject);
begin
  strTabelaInventario := '';

  pCriarFormularios(TfrmExportaSpedFiscalInventario, frmExportaSpedFiscalInventario);
  try
    if frmExportaSpedFiscalInventario.ShowModal = mrOk then
      strTabelaInventario := frmExportaSpedFiscalInventario.fTabela;

    if fEmptyStr(strTabelaInventario) then
      lblTabInventario.Caption := 'TABELA PADRÃO'
    else
      lblTabInventario.Caption := strTabelaInventario;
  finally
    pFreeAndNil(frmExportaSpedFiscalInventario);
  end;
end;

procedure TfrmRelCat42v2.btnImprimirClick(Sender: TObject);
  var
    strCfopDupl: string;
    verificaCfopDuplicado: TConstantesCfop;
    objReImpressao: TReImpressaoRelatorioCat42;
    abertura: TDadosAberturaExportacaoCat42;
    objCat42: TCat42;
begin
  inherited;
  verificaCfopDuplicado := TConstantesCfop.Create;
  try
    strCfopDupl := verificaCfopDuplicado.fRetEnquadramentosCfopDuplicado('', '');
    if not fEmptyStr(strCfopDupl) then
    begin
      fMensagem('Atenção', 'O(s) CFOP(s): ' + chr(13) +
                           strCfopDupl + chr(13) + chr(13) +
                           ' constam como duplicados nos Enquadramentos!', ['&Ok']);
      pSetFocus(mskDtaIni);
      Abort;
    end;
  finally
    verificaCfopDuplicado.Free;
  end;

  pValidacoes;
  cdsRelatorio.EmptyDataSet;
  cdsRelContabil.EmptyDataSet;

  if blnImprime then
  begin
    pnlInfo.Caption := 'Carregando Relatório...';
    btnDeletarPeriodo.Enabled := False;
    btnImprimir.Enabled := False;
    pnlInfo.Repaint;

    arrLinhaGrupo := fArrLinhaGrupoExcluir(edtCodEmp.Text, '5');

    abertura := TDadosAberturaExportacaoCat42.Create(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), edtCodEmp.Text);
    abertura.blnUtilizarConfigCfopCstEnquadramentos := chkUtilizarConfigCfopCstEnquadramentos.Checked;

    objReImpressao := TReImpressaoRelatorioCat42.Create(cdsRelatorio, cdsRelContabil, abertura);
    objCat42 := TCat42.Create(abertura, arrProduto, stlEnquadramento, arrLinhaGrupo);
    try
      try
        abertura.tipoConferencia := IIF(chkGerarApuracao.Checked, tccSim, tccConf);
        abertura.blnEnviaNfCredSemSubsti := False;
        abertura.blnSomarIcmsRetido := chkSomaIcmsRetido.Checked; //caso seja marcado ao campo Retido_N_CRED é somado o icms do xml
        abertura.blnGerarComSaldoZero := chkGerarComSaldoZero.Checked;
        abertura.strTabelaInventario := strTabelaInventario;
        abertura.fltValorIVA := fStrToFloat(edtValIva.Text);
        abertura.blnCalculaST := chkCalcularST.Checked;
        abertura.progressoTela := pgbProgresso;
        abertura.lblOperacao := lblOperacao;

        abertura.strVersaoExecutada:= 'v2';
        abertura.blnInvSemSaldoSemSubstTributSemMovtoMes := chkInvSemSaldoSemSubstTributSemMovtoMes.checked;
        abertura.blnInvSemSaldoComSubstTributSemMovtoMes := chkInvSemSaldoComSubstTributSemMovtoMes.checked;
        abertura.blnInvComSaldoSemSubstTributSemMovtoMes := chkInvComSaldoSemSubstTributSemMovtoMes.checked;
        {abertura.blnInvComSaldoComSubstTributSemMovtoMes := chkInvComSaldoComSubstTributSemMovtoMes.checked;}
        abertura.blnInvComSaldoSemSubstTributComMovtoMes := chkInvComSaldoSemSubstTributComMovtoMes.checked;
        abertura.blnSaldoInicialQuantidadInicialNegativa := chkSaldoInicialQuantidadInicialNegativa.checked;
        abertura.blnSldFinalQtFinalNegQtVendaMaiorCompra := chkSldFinalQtFinalNegQtVendaMaiorCompra.checked;
        abertura.blnNotasEntradaSemSubstituicaTributaria := chkNotasEntradaSemSubstituicaTributaria.checked;
        abertura.blnConsiderarInconsistenciaQuatro := chkConsiderarInconsistenciaQuatro.checked;
        abertura.blnConsiderarInconsistenciaCincoEntradaSemSt := chkConsiderarInconsistenciaCincoEntradaSemSt.checked;
        abertura.blnConsiderarInconsistenciaCincoTransfSemSt := chkConsiderarInconsistenciaCincoTransfSemSt.checked;
        abertura.blnConsiderarDataEmissaoEntradasTransferencia := chkConsiderarDataEmissaoEntradasTransferencia.checked;
        abertura.blnSaldoMovimentacao := chkSaldoMovimentacao.checked;
        abertura.blnUtilizarPrecoCompraCalcICMSSuportado := chkUtilizarPrecoCompraCalcICMSSuportado.Checked;
        abertura.blnSaidaOutroEstado := chkSaidaOutroEstado.Checked;
        abertura.blnSaidaConsumidor  := chkSaidaConsumidor.Checked;

       if objReImpressao.fReImpressao(arrProduto, arrLinhaGrupo) then
          pPreparaLayoutImpressao
        else if fEmptyStr(strTabelaInventario) then
        begin
          fMensagem('ATENÇÃO!', 'É Necessário Informar uma Tabela de Inventário!', ['&Ok']);
          btnDeletarPeriodo.Enabled := True;
          btnImprimir.Enabled := True;
          pnlInfo.Caption := '';
          pnlInfo.Repaint;
          Exit;
        end
        else if objCat42.fCarregaDadosControleEstoque(cdsRelatorio, cdsRelContabil) then
        begin
          cdsRelContabil.Open;
          If (Not chkTotalizarValorContabil.Checked) Or
             (Not chkUtilizarConfigCfopCstEnquadramentos.Checked) Or
             (cdsRelContabil.isEmpty) Then
          Begin
            cdsRelContabil.EmptyDataSet;
          End;
          pPreparaLayoutImpressao;

          //Verifica se vai ser gravado no banco as notas fiscais de entradas já utilizadas para crédito
          if chkGerarApuracao.Checked then
          begin
            if fMensagem('ATENÇÃO', 'Confirma a Utilização dos Créditos do Relatório Apresentado?', ['&Sim', '&Não'], 2) = 1 then
            begin
              pnlInfo.Caption := 'Aguarde, gravando utilização de créditos...';
              lblOperacao.Caption := '';
              Application.ProcessMessages;

              objCat42.pGravarDados(cdsRelatorio);
              fMensagem('Aviso', 'Dados Gravados com Sucesso!', ['Ok']);

              pGeraLogConfiguracaoSelecionadaCAT42;
              pDadosGravados_CAT42DADOS_CAT42SALDOS;
            end;
          end;

        end
        else
          pTabelaVazia;

        lblOperacao.Caption:= '';
        lblOperacao.Visible:= False;
        pgbProgresso.Position:= 0;
        btnDeletarPeriodo.Enabled := True;
        btnImprimir.Enabled := True;
        pnlInfo.Caption := '';
        pnlInfo.Repaint;
      except
        on e: Exception do
        begin
          HandleException;
          lblOperacao.Caption:= '';
          lblOperacao.Visible:= False;
          pgbProgresso.Position:= 0;
          btnDeletarPeriodo.Enabled := True;
          btnImprimir.Enabled := True;
          pnlInfo.Caption := '';
          pnlInfo.Repaint;
        end;
      end;
    finally
      abertura.Free;
      objCat42.Free;
    end;
  end;
end;

procedure TfrmRelCat42v2.btnImprimirErro(Sender: TWinControl; strMsgErro: string;
  E: Exception);
begin
  inherited;
  HandleException();
end;

procedure TfrmRelCat42v2.btnImprimirExit(Sender: TObject);
begin
  inherited;
  pDadosGravados_CAT42DADOS_CAT42SALDOS;
end;

procedure TfrmRelCat42v2.btnMarcarDesmarcarTodosClick(Sender: TObject);
  var
    i: Integer;
begin
  inherited;
  for i := 0 to gpbInconsistencias.ControlCount -1 do
  begin
    if gpbInconsistencias.Controls[i] is TCheckBox then
      TCheckBox(gpbInconsistencias.Controls[i]).Checked := (not(TCheckBox(gpbInconsistencias.Controls[i]).Checked));
  end;
end;

procedure TfrmRelCat42v2.btnSugestaoClick(Sender: TObject);
begin
  inherited;

  lblTabInventario.Caption:= '';
  if (fTabelaExiste(fRetTabelaInventario)) then
    lblTabInventario.Caption:= fRetTabelaInventario;

  strTabelaInventario:= lblTabInventario.Caption;

end;

procedure TfrmRelCat42v2.Button1Click(Sender: TObject);
begin
  inherited;
  tmeHoraInicioProcessamento:= fTime(True);
  pGeraLogConfiguracaoSelecionadaCAT42;
end;

procedure TfrmRelCat42v2.Button2Click(Sender: TObject);
begin
  pnlUtilizarPrecoCompraCalcICMSSuportado.Top := 604;
end;

procedure TfrmRelCat42v2.chkConsiderarInconsistenciaQuatroClick(Sender: TObject);
begin
  inherited;
  pHabilitaDesabilitaOpcaoProcessamento
end;

procedure TfrmRelCat42v2.chkEnquadramentoClick(Sender: TObject);
  var
    strEnquadramento: String;
begin
  inherited;
  //# gpbEnquadramento
  strEnquadramento := IntToStr(TCheckBox(Sender).Tag);
  if strEnquadramento <> '55' then
  begin
    if (stlEnquadramento.IndexOf(strEnquadramento) = -1) then
      stlEnquadramento.Add(strEnquadramento)
    else
      stlEnquadramento.Delete(stlEnquadramento.IndexOf(strEnquadramento));
  end;
end;

procedure TfrmRelCat42v2.chkGerarApuracaoClick(Sender: TObject);
begin
  inherited;
  pHabilitaDesabilitaOpcaoProcessamento;
end;

procedure TfrmRelCat42v2.chkInvSemSaldoSemSubstTributSemMovtoMesClick(Sender: TObject);
  var
    strInconsistencia: string;
begin
  inherited;
  pHabilitaDesabilitaOpcaoProcessamento;

  strInconsistencia := IntToStr(TCheckBox(Sender).Tag);
  if (stlInconsistencia.IndexOf(strInconsistencia) = -1) then
    stlInconsistencia.Add(strInconsistencia)
  else
    stlInconsistencia.Delete(stlInconsistencia.IndexOf(strInconsistencia));

end;

procedure TfrmRelCat42v2.chkUtilizarConfigCfopCstEnquadramentosClick(Sender: TObject);
begin
  pValidacoes(True);
end;

procedure TfrmRelCat42v2.chkUtilizarPrecoCompraCalcICMSSuportadoMouseMove(
  Sender: TObject; Shift: TShiftState; X, Y: Integer);
  var
    strHint: string;
begin
  inherited;

  strHint := 'Configuração terá efeito quando as configurações:' + chr(13);
  strHint := strHint + '(Preço Inventário sem ST (Adjudicação e CAT42)): for igual = "Última compra mais impostos (IMPULT)" para ICMS' + chr(13);
  strHint := strHint + '(Preço Inventário com ST (CAT42)): for igual = "Última compra mais impostos (IMPULT)" para ICMS ST' + chr(13) + chr(13);
  strHint := strHint + 'Efeito:' + chr(13);
  strHint := strHint + 'o "Preço de Compra" somente será utilizado quando selecionado na configuração (Preço Inventário sem ST (Adjudicação e CAT42)) a opção' + chr(13);
  strHint := strHint + '"Última compra mais impostos (IMPULT)", caso o (IMPULT) for igual 0 será recuperado o (PRECOM).' + chr(13) + chr(13);
  strHint := strHint + 'o "Preço de Compra" somente será utilizado quando selecionado na configuração (Preço Inventário com ST (CAT42)) a opção' + chr(13);
  strHint := strHint + '"Última compra mais impostos (IMPULT)", caso o (IMPULT) for igual 0 será recuperado o (PRECOM).' + chr(13) + chr(13);
  strHint := strHint + 'A PRIORIDADE É IMPULT (QUE E A CONFIGURAÇÃO SELECIONADA NESTE CASO)' + chr(13);
  strHint := strHint + 'SE (IMPULT IGUAL FOR 0) E ((SALDOS MAIOR QUE 0) E (SUBSTI MAIOR QUE 0)) RECUPERA (PRECOM) SENÃO (IMPULT)';

  //# chkUtilizarPrecoCompraCalcICMSSuportado.ShowHint:= True;
  chkUtilizarPrecoCompraCalcICMSSuportado.Hint := strHint;
end;

procedure TfrmRelCat42v2.edtCodProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPro, edtNomPro, arrProduto, nil, fRetNomeProdutoSelec, 'do Produto');
end;

procedure TfrmRelCat42v2.edtCodProKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqProduto(Self, edtCodPro, edtNomPro, nil, Key, arrProduto, False) then
    Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelCat42v2.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pDadosGravados_CAT42DADOS_CAT42SALDOS;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpresa, nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmRelCat42v2.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, nil, Key, arrEmpresa, True) then
    Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelCat42v2.FormCreate(Sender: TObject);
begin
  inherited;

  pVerificaProCod;
  pValidaProCod('CAT_42_DADOS');
  pValidaProCod('CAT_42_SALDOS');

  cdsRelatorio.CreateDataSet;
  cdsRelContabil.CreateDataSet;
  stlEnquadramento := TStringList.Create;
  stlEnquadramento.Sorted := true;

  stlInconsistencia := TStringList.Create;
  stlInconsistencia.Sorted := true;

  if (not fTabelaExiste('CAT_42_DADOS')) or (not fTabelaExiste('CAT_42_SALDOS')) then
    pCriarTabelasCat;
end;

procedure TfrmRelCat42v2.FormDestroy(Sender: TObject);
begin
  inherited;
  stlEnquadramento.Free;
  stlInconsistencia.Free;
end;

procedure TfrmRelCat42v2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key of   //SHIFT + CTRL + ALT + F3
     VK_F3    : If (Shift = [ssShift, ssAlt, ssCtrl]) And ( Pos(strLoginUsuarioLogado, '998_997') > 0 ) Then
                Begin
                  if (btnConfigurar.Visible) then
                    btnConfigurar.Visible := false
                  else btnConfigurar.Visible := true;
                End;
   End;

end;

procedure TfrmRelCat42v2.FormShow(Sender: TObject);
begin
  inherited;

  pCarregaPeriodoMesAtual;

  pSetFocus(mskDtaIni);

  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
  pDadosGravados_CAT42DADOS_CAT42SALDOS;

end;

function TfrmRelCat42v2.fRepositorioDadosLogCAT42(lstDadosLogCat42: TObjectList<TDadosLogCat42>): TObjectList<TDadosLogCat42>;
  procedure parametrosProcessamento(dadosLogCat42: TDadosLogCat42);
  begin
    dadosLogCat42.strEmpresaProcessamento:= edtCodEmp.Text;
    dadosLogCat42.strUsuarioProcessamento:= strLoginUsuarioLogado + ' - ' + strDescriUsuarioLogado;
    dadosLogCat42.dteDataProcessamento:= Date();
    dadosLogCat42.dteDataInicial:= StrToDate(mskDtaIni.Text);
    dadosLogCat42.dteDataFinal:= StrToDate(mskDtaFin.Text);
    dadosLogCat42.tmeHoraInicial:= tmeHoraInicioProcessamento;
    dadosLogCat42.tmeHoraFinal:= tmeHoraFinalProcessamento;
    dadosLogCat42.strOrigem:= Self.Caption + ' (' + Self.Name + ') ';
  end;

  var
    i: Integer;
    dadosLogCat42: TDadosLogCat42;
    strPreInvCat: String;
begin
  tmeHoraFinalProcessamento:= fTime(True);
  Result:= lstDadosLogCat42;
  try
    for i := 0 to ComponentCount -1 do
    begin
      if (Components[i] is TMaskEditFocus) then
      begin
        dadosLogCat42:= TDadosLogCat42.Create;
        dadosLogCat42.strDescr:= (Components[i] as TMaskEditFocus).Hint;
        dadosLogCat42.strValor:= (Components[i] as TMaskEditFocus).Text;
        parametrosProcessamento(dadosLogCat42);
        Result.add(dadosLogCat42);

        if ((Components[i] as TMaskEditFocus).Name = 'mskDtaIni') then
          dadosLogCat42.intOrder:= 3
        else if ((Components[i] as TMaskEditFocus).Name = 'mskDtaFin') then
          dadosLogCat42.intOrder:= 4;
      end;

      if (Components[i] is TGroupBox) then
      begin
        if ((Components[i] as TGroupBox).Name = 'gpbEnquadramento') or
          ((Components[i] as TGroupBox).Name = 'gpbConsiderarInconsistencia') or
          ((Components[i] as TGroupBox).Name = 'gpbInconsistencias') then
        begin
          dadosLogCat42:= TDadosLogCat42.Create;
          dadosLogCat42.intOrder:= 12;
          dadosLogCat42.strDescr:= (Components[i] as TGroupBox).Hint;
          dadosLogCat42.strValor:= fLeituraOpcoesSelecionadoTexto((Components[i] as TGroupBox));
          parametrosProcessamento(dadosLogCat42);
          Result.add(dadosLogCat42);

          if ((Components[i] as TGroupBox).Name = 'gpbEnquadramento') then
            dadosLogCat42.intOrder:= 5
          else if ((Components[i] as TGroupBox).Name = 'gpbInconsistencias') then
            dadosLogCat42.intOrder:= 13;

        end;
      end;

      if (Components[i] is TEditFocus) then
      begin
        if ((Components[i] as TEditFocus).Name = 'edtCodEmp') or
          ((Components[i] as TEditFocus).Name = 'edtCodPro') or
          ((Components[i] as TEditFocus).Name = 'edtValIva') then
        begin
          dadosLogCat42:= TDadosLogCat42.Create;
          dadosLogCat42.intOrder:= 6;
          dadosLogCat42.strDescr:= (Components[i] as TEditFocus).Hint;

          if ((Components[i] as TEditFocus).Name = 'edtValIva') then
            dadosLogCat42.strValor:= IIF(fEmptyStr((Components[i] as TEditFocus).Text ), '0,00', (Components[i] as TEditFocus).Text)
          else if ((Components[i] as TEditFocus).Name = 'edtCodPro') then
            dadosLogCat42.strValor:= IIF(fEmptyStr((Components[i] as TEditFocus).Text ), 'TODOS', (Components[i] as TEditFocus).Text)
          else
            dadosLogCat42.strValor:= (Components[i] as TEditFocus).Text;

          parametrosProcessamento(dadosLogCat42);
          Result.add(dadosLogCat42);
        end;
      end;

      if (Components[i] is TLabel) then
      begin
        if ((Components[i] as TLabel).Name = 'lblTabInventario') then
        begin
          dadosLogCat42:= TDadosLogCat42.Create;
          dadosLogCat42.intOrder:= 8;
          dadosLogCat42.strDescr:= (Components[i] as TLabel).Hint;
          dadosLogCat42.strValor:= (Components[i] as TLabel).Caption;
          parametrosProcessamento(dadosLogCat42);
          Result.add(dadosLogCat42);
        end;
      end;

      if (Components[i] is TCheckBox) then
      begin
        if ((Components[i] as TCheckBox).Name = 'chkCalcularST') or
          ((Components[i] as TCheckBox).Name = 'chkGerarComSaldoZero') or
          ((Components[i] as TCheckBox).Name = 'chkUtilizarConfigCfopCstEnquadramentos') or
          ((Components[i] as TCheckBox).Name = 'chkGerarApuracao') or
          ((Components[i] as TCheckBox).Name = 'chkConsiderarDataEmissaoEntradasTransferencia') or
          ((Components[i] as TCheckBox).Name = 'chkSomaIcmsRetido') then
        begin
          dadosLogCat42:= TDadosLogCat42.Create;

          if ((Components[i] as TCheckBox).Name = 'chkCalcularST') then
            dadosLogCat42.intOrder:= 7
          else if ((Components[i] as TCheckBox).Name = 'chkUtilizarConfigCfopCstEnquadramentos') then
            dadosLogCat42.intOrder:= 9
          else if ((Components[i] as TCheckBox).Name = 'chkSomaIcmsRetido') then
            dadosLogCat42.intOrder:= 10
          else if ((Components[i] as TCheckBox).Name = 'chkGerarApuracao') then
            dadosLogCat42.intOrder:= 11
          else if ((Components[i] as TCheckBox).Name = 'chkConsiderarDataEmissaoEntradasTransferencia') then
            dadosLogCat42.intOrder:= 15
          else if ((Components[i] as TCheckBox).Name = 'chkGerarComSaldoZero') then
            dadosLogCat42.intOrder:= 16;

          dadosLogCat42.strDescr:= (Components[i] as TCheckBox).Hint;
          dadosLogCat42.strValor:= IIF((Components[i] as TCheckBox).Checked, 'S', 'N') ;
          dadosLogCat42.strEmpresaProcessamento:= edtCodEmp.Text;
          parametrosProcessamento(dadosLogCat42);
          Result.add(dadosLogCat42);
        end;
      end;
    end;

    dadosLogCat42:= TDadosLogCat42.Create;
    dadosLogCat42.intOrder:= 1;
    dadosLogCat42.strDescr:= 'Usúario Processamento: ';
    dadosLogCat42.strValor:= strLoginUsuarioLogado + ' - ' + strDescriUsuarioLogado;
    parametrosProcessamento(dadosLogCat42);
    Result.add(dadosLogCat42);

    dadosLogCat42:= TDadosLogCat42.Create;
    dadosLogCat42.intOrder:= 2;
    dadosLogCat42.strDescr:= 'Data Processamento: ';
    dadosLogCat42.strValor:= DateToStr(Date());
    parametrosProcessamento(dadosLogCat42);
    Result.add(dadosLogCat42);

    dadosLogCat42:= TDadosLogCat42.Create;
    dadosLogCat42.intOrder:= 14;
    dadosLogCat42.strDescr:= 'Preço Inventário: ';

    strPreInvCat := fCfgSpd('PRECO_INV_CAT42');

    if Pos(strPreInvCat, '0_') > 0 then
      dadosLogCat42.strValor:= 'Compra líquido (PRECOM líquido)'//'Compra liquído'
    else if Pos(strPreInvCat, '1_') > 0 then
      dadosLogCat42.strValor:= 'Última Compra mais impostos líquido (IMPULT líquido)'//'Última Compra liquído'
    else if Pos(strPreInvCat, '2_') > 0 then
      dadosLogCat42.strValor:= 'Compra (PRECOM)'//'Compra inventário'
    else if Pos(strPreInvCat, '3_') > 0 then
      dadosLogCat42.strValor:= 'Última Compra mais impostos (IMPULT)'//'Última Compra inventário'
    else if Pos(strPreInvCat, '4_') > 0 then
      dadosLogCat42.strValor:= 'Última Compra mais impostos (PREULT)'//'Última Compra inventário'
    else dadosLogCat42.strValor:= '';
    parametrosProcessamento(dadosLogCat42);
    Result.add(dadosLogCat42);

  finally
  end;
end;

function TfrmRelCat42v2.fRetTabelaInventario: string;
  var
    intDia, intMes, intAno: word;
    dataMesAnterior: TDateTime;
begin
  dataMesAnterior := IncMonth(StrToDate(mskDtaIni.Text), -1);
  DecodeDate(dataMesAnterior, intAno, intMes, intDia);

  Result := 'I_' + FormatDateTime('YYYYMM', dataMesAnterior);
end;

function TfrmRelCat42v2.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = mskDtaIni) or (Sender = mskDtaFin) then
  begin
    if fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) then
    begin
      fMensagem('', 'O Campo Data Inicial deve ser Preenchido!', ['&Ok']);
      Result := False;

      if (Sender = mskDtaFin) then
        Sender := mskDtaIni;
    end
    else
    begin
      mskDtaIni.Text := DateToStr(StrToDate(mskDtaIni.Text));

      if (Sender = mskDtaFin) then
      begin
        if fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) then
        begin
          fMensagem('', 'O Campo Data Final deve ser Preenchido!', ['&Ok']);
          Result := False;
        end
        else
        begin
          if StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) then
          begin
            fMensagem('','A Data Inicial deve ser Menor que a Data Final!',['&Ok']);
            Result := False;
          end
          else
            mskDtaFin.Text := DateToStr(StrToDate(mskDtaFin.Text));
        end;
      end
    end;
  end;

  if (Sender = edtCodEmp) then
  begin
    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'É Necessário Informar um Código de Empresa!', ['&Ok']);
      pSetFocus(edtCodEmp);
      Result := False;
    End;
  end;

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmRelCat42v2.lblUtilizarPrecoCompraCalcICMSSuportadoClick(Sender: TObject);
begin
  pnlUtilizarPrecoCompraCalcICMSSuportado.Top := 304;
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Clear;

  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('Configuração terá efeito quando as configurações:');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('(Preço Inventário sem ST (Adjudicação e CAT42)): for igual');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('     "Última compra mais impostos (IMPULT)" para ICMS');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('(Preço Inventário com ST (CAT42)): for igual');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('     "Última compra mais impostos (IMPULT)" para ICMS ST');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('Efeito:');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('1. o "Preço de Compra" somente será utilizado quando selecionado na configuração');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('(Preço Inventário sem ST (Adjudicação e CAT42))');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('com a opção "Última compra mais impostos (IMPULT)",');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('caso o (IMPULT) for igual 0 será recuperado o (PRECOM).');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('2. o "Preço de Compra" somente será utilizado quando selecionado na configuração');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('(Preço Inventário com ST (CAT42))');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('com a opção "Última compra mais impostos (IMPULT)",');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('caso o (IMPULT) for igual 0 será recuperado o (PRECOM).');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('A PRIORIDADE É IMPULT (QUE E A CONFIGURAÇÃO SELECIONADA NESTE CASO)');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('SE (IMPULT FOR IGUAL 0) E ((SALDOS MAIOR QUE 0) E (SUBSTI MAIOR OU IGUAL QUE 0))');
  mmUtilizarPrecoCompraCalcICMSSuportado.Lines.Add('RECUPERA (PRECOM) SENÃO (IMPULT)');
end;

procedure TfrmRelCat42v2.mskDtaFinExit(Sender: TObject);
begin
  inherited;
  pDadosGravados_CAT42DADOS_CAT42SALDOS;
end;

procedure TfrmRelCat42v2.mskDtaIniExit(Sender: TObject);
begin
  inherited;
  pDadosGravados_CAT42DADOS_CAT42SALDOS;
end;

procedure TfrmRelCat42v2.pHabilitaDesabilitaOpcaoProcessamento(blnVerificaOpcoesSelecionadas: Boolean);
  var
    i: Integer;
begin
  if not blnVerificaOpcoesSelecionadas then
  begin
    if (ActiveControl = chkGerarApuracao) or
      (ActiveControl = chkConsiderarInconsistenciaQuatro) or
      (ActiveControl = chkConsiderarInconsistenciaCincoTransfSemSt) or
      (ActiveControl = chkConsiderarInconsistenciaCincoEntradaSemSt) then
    begin
      for i := 0 to gpbInconsistencias.ControlCount -1 do
        if gpbInconsistencias.Controls[i] is TCheckBox then
          TCheckBox(gpbInconsistencias.Controls[i]).State:= cbUnchecked;
    end
    else
    begin
      chkGerarApuracao.State:= cbUnchecked;
      chkConsiderarInconsistenciaQuatro.State:= cbUnchecked;
      chkConsiderarInconsistenciaCincoTransfSemSt.State:= cbUnchecked;
      chkConsiderarInconsistenciaCincoEntradaSemSt.State:= cbUnchecked;
    end;
  end
  else
  begin
    for i := 0 to gpbInconsistencias.ControlCount -1 do
      if gpbInconsistencias.Controls[i] is TCheckBox then
        if (TCheckBox(gpbInconsistencias.Controls[i]).State = cbChecked) then
          blnVerificaOpcoesSelecionadas:= False;

    if (blnVerificaOpcoesSelecionadas) and
      (chkGerarApuracao.State = cbChecked) then
      blnVerificaOpcoesSelecionadas:= False;

    if blnVerificaOpcoesSelecionadas then
    begin
      fMensagem('ATENÇÃO!', 'Selecionar entre as Opções Apuração ou Inconsistência(s)!', ['&Ok']);
      Abort;
    end;

  end;
end;

function TfrmRelCat42v2.fLeituraOpcoesSelecionadoTexto(gpbGroupBox: TGroupBox): string;
  var
    i: Integer;
begin
  Result:= '';
  for i := 0 to gpbGroupBox.ControlCount -1 do
  begin
    if gpbGroupBox.Controls[i] is TCheckBox then
      if (TCheckBox(gpbGroupBox.Controls[i]).State = cbChecked) then
        Result:= Result + TCheckBox(gpbGroupBox.Controls[i]).Caption + ', ';
  end;
  Result:= Copy(Result, 0, length(Result) -2);
end;

procedure TfrmRelCat42v2.pPreparaLayoutImpressao;
begin
  frxReportJ.Script.Variables['MESANO'] := FormatDateTime('MM/YYYY', StrToDate(mskDtaIni.Text));

  cdsRelatorio.IndexFieldNames := 'CODITE;CAMPO01';

  if frxReportJ.PrepareReport then
  begin
    frxReportJ.PrintOptions.PrintMode:= pmScale;
    frxReportJ.PrintOptions.PrintOnSheet := 9;

    if edtDestino.Text = 'V' then
      frxReportJ.ShowReport
    else
      frxReportJ.Print;
  end;
end;

procedure TfrmRelCat42v2.pValidacoes(blnUtilizarConfigCfopCstEnquadramentos: Boolean = False);
  var
    i: Integer;
    strEnquadramentoAux, strInconsistenciaAux: String;
begin
  if blnUtilizarConfigCfopCstEnquadramentos then
  begin
    if (not(fTabelaExiste('CADENQ'))) then
    begin
      chkUtilizarConfigCfopCstEnquadramentos.Checked:= False;
      fMensagem('ATENÇÃO!', 'Acesse as Configuração de Enquadramento e Realize o Cadastro!', ['&Ok']);
      Abort;
    end;
  end
  else
  begin
    if (stlEnquadramento.Count = 0) then
    begin
      fMensagem('ATENÇÃO!', 'É Necessário Selecionar ao Menos um Enquadramento!', ['&Ok']);
      Abort;
    end
    else
    begin
      pHabilitaDesabilitaOpcaoProcessamento(True);
      for i := 0 to stlEnquadramento.Count - 1 do
        strEnquadramentoAux := strEnquadramentoAux + stlEnquadramento.Strings[i] + ',';

      if (Copy(strEnquadramentoAux, 1, 1) = '0') then
        strEnquadramentoAux := Copy(strEnquadramentoAux, 3, strEnquadramentoAux.Length) + '0'
      else
        strEnquadramentoAux := Copy(strEnquadramentoAux, 1, strEnquadramentoAux.Length - 1);

      if chkGerarApuracao.Checked then
      begin
        if fMensagem('ATENÇÃO', 'Você Confirma o(s) Enquadramento(s) Selecionado(s) para Gravação? ' + chr(13) + 'Enquadramento(s): ' + strEnquadramentoAux, ['&Sim', '&Não'], 2) = 2 then
          Abort;
        tmeHoraInicioProcessamento:= fTime(True);
      end
      else
      begin

        for i := 0 to stlInconsistencia.Count - 1 do
          strInconsistenciaAux := strInconsistenciaAux + stlInconsistencia.Strings[i] + ',';

        if (Copy(strInconsistenciaAux, 1, 1) = '0') then
          strInconsistenciaAux := Copy(strInconsistenciaAux, 3, strInconsistenciaAux.Length) + '0'
        else
          strInconsistenciaAux := Copy(strInconsistenciaAux, 1, strInconsistenciaAux.Length - 1);

        if fMensagem('ATENÇÃO', 'Você Confirma o(s) Enquadramento(s) Selecionado(s): ' + strEnquadramentoAux + chr(13) + 'Conferir Inconsistência(s): ' + strInconsistenciaAux + '?', ['&Sim', '&Não'], 2) = 2 then
          Abort;

      end;

    end;
  end;
end;

procedure TfrmRelCat42v2.TimerPnlInformacaoTimer(Sender: TObject);
begin
  inherited;
  lblInformacao_1.Caption:= 'Existe Movimentação Parcial ou Total Gravadas na Base de Dados no Período Informado.';
  lblInformacao_1.Visible:= (not(lblInformacao_1.Visible));
end;

procedure TfrmRelCat42v2.pAjutaHeight_CAT42DADOS_CAT42SALDOS(blnAjustaHeight: Boolean);
begin
  if blnAjustaHeight then
  begin
    Self.Height:= 620;
    pnlInformacao.Visible:= True;
    TimerPnlInformacao.Enabled:= True;
  end
  else
  begin
    Self.Height:= 600;
    pnlInformacao.Visible:= False;
    TimerPnlInformacao.Enabled:= False;
  end;
end;

procedure TfrmRelCat42v2.pCarregaPeriodoMesAtual;
  var
    intDia, intMes, intAno: word;
begin
  DecodeDate(date, intAno, intMes, intDia);
  intDia := DaysInMonth(date);
  mskDtaIni.Text := DateToStr(EncodeDate(intAno, intMes, 1));
  mskDtaFin.Text := DateToStr(EncodeDate(intAno, intMes, intDia));
end;

procedure TfrmRelCat42v2.pDadosGravados_CAT42DADOS_CAT42SALDOS;
  var
    qryAux: TUniQuery;
begin
  if ((Length(Trim(edtCodEmp.Text)) > 0) and
    (Length(Trim(mskDtaIni.Text))+Length(Trim(mskDtaFin.Text)) = 20)) and
    (fTabelaExiste('CAT_42_DADOS')) then
  begin
    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Text:= ' SELECT CAT_CODEMP '
                 + '   FROM CAT_42_DADOS '
                 + '  WHERE CAT_CODEMP=:CODEMP '
                 + '    AND CAT_MESANO=:MESANO '
                 + '  LIMIT 1 '
                 + ' ;';

        ParamByName('CODEMP').AsString := edtCodEmp.Text;
        ParamByName('MESANO').AsString := FormatDateTime('MM/YYYY', StrToDate(mskDtaIni.Text));

        try

          Open;

          if not IsEmpty then
            pAjutaHeight_CAT42DADOS_CAT42SALDOS(True)
          else
            pAjutaHeight_CAT42DADOS_CAT42SALDOS(False);

        except
          pAjutaHeight_CAT42DADOS_CAT42SALDOS(False);
        end;
      end;
    finally
      qryAux.Free;
    end;
  end
  else
  begin
    pAjutaHeight_CAT42DADOS_CAT42SALDOS(False);
  end;
end;

procedure TfrmRelCat42v2.pGeraLogConfiguracaoSelecionadaCAT42;
  var
    lstDadosLogCat42: TObjectList<TDadosLogCat42>;
begin
  dadosRegistraLogCat42:= TDadosRegistraLogCat42.Create;
  lstDadosLogCat42 := TObjectList<TDadosLogCat42>.Create;
  try
    dadosRegistraLogCat42.pRegistraLogCat42(fRepositorioDadosLogCAT42(lstDadosLogCat42));
  finally
    dadosRegistraLogCat42.Free;
  end;
end;

procedure TfrmRelCat42v2.pCriarTabelasCat;
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE IF NOT EXISTS CAT_42_DADOS (');
      SQL.Add('  AUTOINCREM VARCHAR(20) NOT NULL,');
      SQL.Add('  CAT_CAMP01 INT(11) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP02 VARCHAR(10) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP03 VARCHAR(44) DEFAULT "",');
      SQL.Add('  CAT_CAMP04 VARCHAR(20) DEFAULT "",');
      SQL.Add('  CAT_CAMP05 CHAR(1) DEFAULT "",');
      SQL.Add('  CAT_CAMP06 CHAR(3) DEFAULT "",');
      SQL.Add('  CAT_CAMP07 VARCHAR(12) DEFAULT "",');
      SQL.Add('  CAT_CAMP08 VARCHAR(8) DEFAULT "",');
      SQL.Add('  CAT_CAMP09 CHAR(4) DEFAULT "",');
      SQL.Add('  CAT_CAMP10 VARCHAR(5) DEFAULT "",');
      SQL.Add('  CAT_CAMP11 DECIMAL(12,4) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP12 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP13 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP14 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP15 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP16 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP17 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP18 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP19 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP20 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP21 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP22 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP23 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP24 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP25 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP26 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_CAMP27 DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  CAT_MESANO VARCHAR(7) DEFAULT NULL,');
      SQL.Add('  CAT_CODEMP CHAR(3) DEFAULT NULL,');
      SQL.Add('  CAT_CODITE VARCHAR(5) DEFAULT NULL,');
      SQL.Add('  CAT_INCVEN VARCHAR(20) DEFAULT NULL,');
      SQL.Add('  VALORCONTABIL DECIMAL(12,2) DEFAULT NULL,');
      SQL.Add('  PRIMARY KEY (AUTOINCREM),');
      SQL.Add('  KEY FK_CAT42_DADOS_01 (CAT_CODEMP),');
      SQL.Add('  CONSTRAINT FK_CAT42_DADOS_01 FOREIGN KEY (CAT_CODEMP) REFERENCES CADEMP (EMP_CODEMP)');
      SQL.Add(') ENGINE=INNODB DEFAULT CHARSET=latin1');
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE IF NOT EXISTS CAT_42_SALDOS (');
      SQL.Add('  AUTOINCREM VARCHAR(20) NOT NULL,');
      SQL.Add('  CAT_MESANO VARCHAR(7) DEFAULT NULL,');
      SQL.Add('  CAT_CODEMP CHAR(3) DEFAULT NULL,');
      SQL.Add('  CAT_CODITE VARCHAR(5) DEFAULT NULL,');
      SQL.Add('  CAT_QTDINI DECIMAL(12,2) DEFAULT 0.00,');
      SQL.Add('  CAT_QTDFIN DECIMAL(12,2) DEFAULT 0.00,');
      SQL.Add('  CAT_SALINI DECIMAL(12,2) DEFAULT 0.00,');
      SQL.Add('  CAT_SALFIN DECIMAL(12,2) DEFAULT 0.00,');
      SQL.Add('  PRIMARY KEY (AUTOINCREM),');
      SQL.Add('  KEY FK_CAT_42_SALDOS_01 (CAT_CODEMP),');
      SQL.Add('  CONSTRAINT FK_CAT_42_SALDOS_02 FOREIGN KEY (CAT_CODEMP) REFERENCES CADEMP (EMP_CODEMP)');
      SQL.Add(') ENGINE=INNODB DEFAULT CHARSET=latin1');
      ExecSQL;
    end;
  finally
    qryAux.Free;
  end;
end;

end.
