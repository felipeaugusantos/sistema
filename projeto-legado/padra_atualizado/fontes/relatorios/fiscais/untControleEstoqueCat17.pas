unit untControleEstoqueCat17;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiRelatorio, frxDesgn, frxClass,
  frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS,
  frxExportRTF, RLFilters, RLDraftFilter, Vcl.ExtCtrls, untIZClient,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus,
  QColorLabel, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ComCtrls, Vcl.Mask,
  MaskEditFocus, Data.DB, untClassPanelCx,
  Datasnap.DBClient, UniClientDataSet, untTypesSistema, Uni;

type
  TfrmControleEstoqueCat17 = class(TfrmPaiRelatorio)
    lbl1: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblCodEmp: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    pgbProgresso: TProgressBar;
    btnDeletarPeriodo: TBitBtnLocked;
    frxReportJ: TfrxReport;
    cdsRelatorio: TUniClientDataSet;
    cdsRelatorioDATA: TStringField;
    cdsRelatorioNFCOMPRA: TStringField;
    cdsRelatorioSERIECOMPRA: TStringField;
    cdsRelatorioQTDCOMPRA: TFloatField;
    cdsRelatorioBASESTCOMPRA: TFloatField;
    cdsRelatorioNFVENDA: TStringField;
    cdsRelatorioSERIEVENDA: TStringField;
    cdsRelatorioQTDVENDA: TFloatField;
    cdsRelatorioUNITARIOVENDA: TFloatField;
    cdsRelatorioSAIDACONSUMIDOR: TFloatField;
    cdsRelatorioFATOGERADOR: TFloatField;
    cdsRelatorioSAIDAISENTA: TFloatField;
    cdsRelatorioSAIDAOUTROESTADO: TFloatField;
    cdsRelatorioSAIDACOMERCIALIZACAO: TFloatField;
    cdsRelatorioQTDTOTAL: TFloatField;
    cdsRelatorioUNITARIOTOTAL: TFloatField;
    cdsRelatorioVALORTOTAL: TFloatField;
    lbl4: TLabel;
    edtProdutos: TEditFocus;
    edtDesProduto: TEditFocus;
    cdsRelatorioCODITE: TStringField;
    cdsRelatorioDESCRICAO: TStringField;
    cdsRelatorioCONTRIBUINTE: TStringField;
    cdsRelatorioINSCREST: TStringField;
    cdsRelatorioMESANO: TStringField;
    cdsRelatorioALQST: TFloatField;
    cdsRelatorioUNIDADE: TStringField;
    procedure btnImprimirClick(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    arrProduto : TConsultasArray;
    arrEmpresa : TConsultasArray;
    strProduto: string;
    strCodEmp: string;

    procedure pCarregaLayoutImpressao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmControleEstoqueCat17: TfrmControleEstoqueCat17;

implementation

uses untTRegraNegocioControleEstoque,
     untTDadosAbertura,
     untFuncoesSimples,
     untModuloSPR,
     untIFuncoes,
     StrUtils,
     untConsultas,
     untFuncoesConsulta;

{$R *.dfm}

procedure TfrmControleEstoqueCat17.btnImprimirClick(Sender: TObject);
  var
    obj: TRegraNegocioControleEstoque;
    dadosAbertura: TDadosAbertura;
begin
  inherited;

  if blnImprime then
  begin
    btnImprimir.Enabled := False;
    pnlInfo.Caption := 'Carregando Relatório...';
    pnlInfo.Repaint;

    dadosAbertura := TDadosAbertura.Create(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), edtCodEmp.Text);
    dadosAbertura.progresso := pgbProgresso;
    dadosAbertura.arrProduto := arrProduto;

    obj := TRegraNegocioControleEstoque.Create(dadosAbertura);
    try
      try
        obj.pCarregaClientImpressao(cdsRelatorio);

        if cdsRelatorio.RecordCount > 0 then
          pCarregaLayoutImpressao
        else
          pTabelaVazia;

        btnImprimir.Enabled := True;
        pgbProgresso.Position := 0;
        pnlInfo.Caption := '';
        pnlInfo.Repaint;
      except
        on e: Exception do
        begin
          pMensagensErro(E.Message, '');

          btnImprimir.Enabled := True;
          pgbProgresso.Position := 0;
          pnlInfo.Caption := '';
          pnlInfo.Repaint;
        end;
      end;
    finally
      dadosAbertura.Free;
      obj.Free;
    end;
  end;
end;

procedure TfrmControleEstoqueCat17.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmControleEstoqueCat17.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa, True, True) Then
  Begin
    fValidaCampos(edtCodEmp,False);
    self.SelectNext(ActiveControl, True, True);
  End
end;

procedure TfrmControleEstoqueCat17.edtProdutosExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtProdutos,edtDesProduto,arrProduto,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmControleEstoqueCat17.edtProdutosKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fValidaCampos(edtProdutos,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmControleEstoqueCat17.FormCreate(Sender: TObject);
begin
  inherited;
  cdsRelatorio.CreateDataSet;
  pSetaCodIte(edtProdutos);
end;

procedure TfrmControleEstoqueCat17.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

function TfrmControleEstoqueCat17.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
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
    if fEmptyStr(edtCodEmp.Text) then
    begin
      fMensagem('ATENÇÃO!', 'O campo código da empresa deve ser preenchido', ['&Ok']);
      pSetFocus(edtCodEmp);
      edtCodEmp.Clear;
      Result := False;
    end;
  end;

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmControleEstoqueCat17.pCarregaLayoutImpressao;
  var
    frxReport: TFrxReport;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  frxReport := frxReportJ;

  frxReport.Script.Variables['NOMEMP'] := fCadEmp('NOMEMP');
  frxReport.Script.Variables['REFERE'] := 'REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
  frxReport.Script.Variables['NOMREL'] := 'Relatório de Controle de estoque - CAT 17/99';
  frxReport.Script.Variables['CODEMP'] := fStrTitulo(edtCodEmp.Text, edtNomEmp, arrEmpresa, strCodEmp, 'EMPRESA', TRUE);
  frxReport.Script.Variables['PRODUTO'] := fStrTitulo(edtProdutos.Text, edtDesProduto, arrProduto, strProduto, 'PRODUTO', TRUE);

  if frxReport.PrepareReport then
  begin
    frxReport.PrintOptions.PrintMode:= pmScale;
    frxReport.PrintOptions.PrintOnSheet := 9;

    if edtDestino.Text = 'V' then
      pPreviewReport(Self.Name, Self.Caption, frxReport)
    else
      pPrintReport(Self.Name, Self.Caption, strNomImp, frxReport);
  end;
end;

end.
