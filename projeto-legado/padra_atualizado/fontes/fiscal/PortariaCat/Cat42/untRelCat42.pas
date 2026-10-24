unit untRelCat42;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiRelatorio, frxDesgn, frxClass,
  frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS,
  frxExportRTF, Vcl.AppEvnts, Vcl.StdCtrls, EditFocus, QColorLabel,
  Vcl.ExtCtrls, BitBtnLockedIncrem, Vcl.Buttons, Vcl.Mask, MaskEditFocus,
  Data.DB, Datasnap.DBClient, UniClientDataSet, DateUtils, untTypesSistema,
  Vcl.ComCtrls, untExcel, untGeraExcel, madExcept, untTUtilidadeCat42;

type
  TfrmRelCat42 = class(TfrmPaiRelatorio)
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
    lbl1: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    lblCodEmp: TLabel;
    lblOperacao: TLabel;
    btnEscolherTabela: TSpeedButton;
    lblTabInventario: TLabel;
    btnCriarTabelas: TSpeedButton;
    Label5: TLabel;
    Label3: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtValIva: TEditFocus;
    chkCalcularST: TCheckBox;
    edtCodPro: TEditFocus;
    edtNomPro: TEditFocus;
    gpbEnquadramento: TGroupBox;
    chkSaidaConsumidor: TCheckBox;
    chkFatorGerador: TCheckBox;
    chkSaidaSubsequente: TCheckBox;
    chkSaidaOutroEstado: TCheckBox;
    chkSaidaParaComercializacao: TCheckBox;
    chkSomaIcmsRetido: TCheckBox;
    pgbProgresso: TProgressBar;
    chkUtilizarConfigCfopCstEnquadramentos: TCheckBox;
    rdgTipConferencia: TRadioGroup;
    chkEnviaNfCredSemSubsti: TCheckBox;
    cdsRelContabil: TUniClientDataSet;
    FloatField19: TFloatField;
    cdsRelContabilCST: TStringField;
    cdsRelContabilCFOP: TStringField;
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
    procedure rdgTipConferenciaClick(Sender: TObject);
    procedure chkUtilizarConfigCfopCstEnquadramentosClick(Sender: TObject);
  private
    strTabelaInventario: string;
    arrEmpresa: TConsultasArray;
    arrProduto: TConsultasArray;
    arrLinhaGrupo: TConsultasArray;
    stlEnquadramento: TStringList;
//    function fRetTabelaInventario: string;

    procedure pCriarTabelasCat;

    procedure pPreparaLayoutImpressao;
    procedure pCarregaPeriodoMesAtual;
    procedure pValidacoes(blnIncializa: Boolean = False);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmRelCat42: TfrmRelCat42;

implementation

uses untTDadosAberturaExportacaoCat42, untTReImpressaoRelatorioCat42, untConsultas, untTCat42, untFuncoes, Uni,
     untExportaSpedFiscalInventario, untTipo;

{$R *.dfm}

procedure TfrmRelCat42.btnCriarTabelasClick(Sender: TObject);
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

procedure TfrmRelCat42.btnDeletarPeriodoClick(Sender: TObject);
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
      fMensagem('', 'Período inválido, favor digitar nas normas "MM/YYYY"!', ['&Ok']);
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
        fMensagem('', 'Código de empresa inválido!', ['&Ok']);
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
          fMensagem('AVISO', 'Registros do período deletados com sucesso!', ['OK']);

          btnDeletarPeriodo.Enabled := True;
          btnImprimir.Enabled := True;
          pgbProgresso.Position := 0;
          pnlInfo.Caption := '';
          pnlInfo.Repaint;
        except
          on e: Exception do
          begin
            fMensagem('AVISO', e.Message, ['OK']);
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

procedure TfrmRelCat42.btnEscolherTabelaClick(Sender: TObject);
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

procedure TfrmRelCat42.btnImprimirClick(Sender: TObject);
  function fRetTipoConferencia: TTipoConferenciaCat;
  begin
    Result := tccNao;

    case rdgTipConferencia.ItemIndex of
      0: Result := tccSim;
      1: Result := tccNao;
      2: Result := tccConf;
    end;
  end;

  var
    objReImpressao: TReImpressaoRelatorioCat42;
    abertura: TDadosAberturaExportacaoCat42;
    objCat42: TCat42;
begin
  inherited;

  pValidacoes;
  cdsRelatorio.EmptyDataSet;
  cdsRelContabil.EmptyDataSet;

  if blnImprime then
  begin
    pnlInfo.Caption := 'Carregando Relatório...';
    btnDeletarPeriodo.Enabled := False;
    btnImprimir.Enabled := False;
    pnlInfo.Repaint;

    abertura := TDadosAberturaExportacaoCat42.Create(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), edtCodEmp.Text);
    objReImpressao := TReImpressaoRelatorioCat42.Create(cdsRelatorio, cdsRelContabil, abertura);
    objCat42 := TCat42.Create(abertura, arrProduto, stlEnquadramento, arrLinhaGrupo);
    try
      try
        abertura.blnUtilizarConfigCfopCstEnquadramentos := chkUtilizarConfigCfopCstEnquadramentos.Checked;
        abertura.tipoConferencia := fRetTipoConferencia;
        abertura.blnEnviaNfCredSemSubsti := chkEnviaNfCredSemSubsti.Checked;
        abertura.blnSomarIcmsRetido := chkSomaIcmsRetido.Checked; //caso seja marcado ao campo Retido_N_CRED é somado o icms do xml
        abertura.strTabelaInventario := strTabelaInventario;
        abertura.fltValorIVA := fStrToFloat(edtValIva.Text);
        abertura.blnCalculaST := chkCalcularST.Checked;
        abertura.progressoTela := pgbProgresso;
        abertura.lblOperacao := lblOperacao;
        abertura.strVersaoExecutada:= 'v1';

        if objReImpressao.fReImpressao then
          pPreparaLayoutImpressao
        else if fEmptyStr(strTabelaInventario) then
        begin
          fMensagem('ATENÇÃO!', 'É necessário informar uma tabela de inventário!', ['&OK']);
          btnDeletarPeriodo.Enabled := True;
          btnImprimir.Enabled := True;
          pnlInfo.Caption := '';
          pnlInfo.Repaint;
          Exit;
        end
        else if objCat42.fCarregaDadosControleEstoque(cdsRelatorio, cdsRelContabil) then
        begin
          pPreparaLayoutImpressao;

          //Verifica se vai ser gravado no banco as notas fiscais de entradas já utilizadas para crédito
          if fMensagem('ATENÇÃO', 'Confirma a utilização dos créditos do relatório apresentado?',
             ['&Sim', '&Não'], 2) = 1 then
          begin
            pnlInfo.Caption := 'Aguarde, gravando utilização de créditos...';
            lblOperacao.Caption := '';
            Application.ProcessMessages;

            objCat42.pGravarDados(cdsRelatorio);
            fMensagem('Aviso', 'Dados gravados com sucesso!', ['OK']);
          end;
        end
        else
          pTabelaVazia;

        btnDeletarPeriodo.Enabled := True;
        btnImprimir.Enabled := True;
        pnlInfo.Caption := '';
        pnlInfo.Repaint;
      except
        on e: Exception do
        begin
          HandleException;
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

procedure TfrmRelCat42.btnImprimirErro(Sender: TWinControl; strMsgErro: string;
  E: Exception);
begin
  inherited;
  HandleException();
end;

procedure TfrmRelCat42.chkEnquadramentoClick(Sender: TObject);
var strEnquadramento: String;
begin
  inherited;

  strEnquadramento := IntToStr(TCheckBox(Sender).Tag);

  if (stlEnquadramento.IndexOf(strEnquadramento) = -1) then
    stlEnquadramento.Add(strEnquadramento)
  else
    stlEnquadramento.Delete(stlEnquadramento.IndexOf(strEnquadramento));

end;

procedure TfrmRelCat42.chkUtilizarConfigCfopCstEnquadramentosClick(Sender: TObject);
begin
  inherited;
  pValidacoes(True);
end;

procedure TfrmRelCat42.edtCodProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPro, edtNomPro, arrProduto, nil, fRetNomeProdutoSelec, 'do Produto');
end;

procedure TfrmRelCat42.edtCodProKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqProduto(Self, edtCodPro, edtNomPro, nil, Key, arrProduto, False) then
    Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelCat42.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpresa, nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmRelCat42.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, nil, Key, arrEmpresa, True) then
    Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelCat42.FormCreate(Sender: TObject);
begin
  inherited;

  pVerificaProCod;
  pValidaProCod('CAT_42_DADOS');
  pValidaProCod('CAT_42_SALDOS');

  cdsRelatorio.CreateDataSet;
  cdsRelContabil.CreateDataSet;
  stlEnquadramento := TStringList.Create;
  stlEnquadramento.Sorted := true;

  if (not fTabelaExiste('CAT_42_DADOS')) or (not fTabelaExiste('CAT_42_SALDOS')) then
    pCriarTabelasCat;
end;

procedure TfrmRelCat42.FormShow(Sender: TObject);
begin
  inherited;

  pCarregaPeriodoMesAtual;

  pSetFocus(mskDtaIni);

  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
end;

//function TfrmRelCat42.fRetTabelaInventario: string;
//  var
//    intDia, intMes, intAno: word;
//    dataMesAnterior: TDateTime;
//begin
//  dataMesAnterior := IncMonth(StrToDate(mskDtaIni.Text), -1);
//  DecodeDate(dataMesAnterior, intAno, intMes, intDia);
//
//  Result := 'I_' + FormatDateTime('YYYYMM', dataMesAnterior);
//end;

function TfrmRelCat42.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = mskDtaIni) or (Sender = mskDtaFin) then
  begin
    if fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) then
    begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
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
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        end
        else
        begin
          if StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) then
          begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
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
      fMensagem('ATENÇÃO!', 'É necessário informar um código de empresa!', ['&OK']);
      pSetFocus(edtCodEmp);
      Result := False;
    End;
  end;

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmRelCat42.pPreparaLayoutImpressao;
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

procedure TfrmRelCat42.pValidacoes(blnIncializa: Boolean = False);
  var
    i: Integer;
    strEnquadramentoAux: String;
begin
  if blnIncializa then
  begin
    if (not(fTabelaExiste('CADENQ'))) then
    begin
      chkUtilizarConfigCfopCstEnquadramentos.Checked:= False;
      fMensagem('ATENÇÃO!', 'Acesse as Configuração de Enquadramento e realize o cadastro!', ['&OK']);
      Abort;
    end;
  end
  else
  begin
    if (stlEnquadramento.Count = 0) then
    begin
      fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um enquadramento!', ['&OK']);
      Abort;
    end
    else
    begin
      for i := 0 to stlEnquadramento.Count - 1 do
        strEnquadramentoAux := strEnquadramentoAux + stlEnquadramento.Strings[i] + ',';

      if (Copy(strEnquadramentoAux, 1, 1) = '0') then
        strEnquadramentoAux := Copy(strEnquadramentoAux, 3, strEnquadramentoAux.Length) + '0'
      else
        strEnquadramentoAux := Copy(strEnquadramentoAux, 1, strEnquadramentoAux.Length - 1);

      if fMensagem('ATENÇÃO', 'Você confirma o(s) enquadramento(s) selecionado(s) para gravação? Enquadramento(s):' + strEnquadramentoAux,
        ['&Sim', '&Não'], 2) = 2 then
        Abort;
    end;
  end;
end;

procedure TfrmRelCat42.rdgTipConferenciaClick(Sender: TObject);
begin
  inherited;
  chkEnviaNfCredSemSubsti.Enabled := rdgTipConferencia.ItemIndex = 2;

  if rdgTipConferencia.ItemIndex <> 2 then
    chkEnviaNfCredSemSubsti.Checked := False;
end;

procedure TfrmRelCat42.pCarregaPeriodoMesAtual;
  var
    intDia, intMes, intAno: word;
begin
  DecodeDate(date, intAno, intMes, intDia);
  intDia := DaysInMonth(date);
  mskDtaIni.Text := DateToStr(EncodeDate(intAno, intMes, 1));
  mskDtaFin.Text := DateToStr(EncodeDate(intAno, intMes, intDia));
end;

procedure TfrmRelCat42.pCriarTabelasCat;
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
