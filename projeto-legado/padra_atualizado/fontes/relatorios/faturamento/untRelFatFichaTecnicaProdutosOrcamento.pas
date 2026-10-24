unit untRelFatFichaTecnicaProdutosOrcamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiRelatorio, Vcl.ExtCtrls,
  frxExportCSVTestabilidade, Vcl.AppEvnts, frxDesgn, frxClass, frxDBSet,
  frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, Vcl.Menus, Vcl.StdCtrls, EditFocus, QColorLabel,
  Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, Data.DB, MemDS,
  DBAccess, Uni, StrUtils, Datasnap.Provider, Datasnap.DBClient,
  UniClientDataSet, untTypesSistema, UniDataSetProvider;

type
  TfrmRelFatFichaTecnicaProdutosOrcamento = class(TfrmPaiRelatorio)
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label6: TLabel;
    Label1: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label2: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label3: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    Label12: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    Label11: TLabel;
    mskDtaFin: TMaskEditFocus;
    frxReport: TfrxReport;
    cdsReport: TUniClientDataSet;
    dspReport: TUniDataSetProvider;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    function frxReportUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
  private

    strCodVen    : String;

    arrEmp       : TConsultasArray;
    arrVendedor  : TConsultasArray;
    arrCliente   : TConsultasArray;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untCfgRel, untModulo, untFuncoesImagem, untFuncoesConsulta, untConsultas;

{$R *.dfm}

procedure TfrmRelFatFichaTecnicaProdutosOrcamento.btnImprimirClick(Sender: TObject);
var
  strSQL       : String;
  qryRelatorio : TUniQuery;
  strNomeFila  : String;
  strTipImp    : String;
Begin

  Screen.Cursor       := crHourGlass;
  btnImprimir.Enabled := False;

  Try

    strSQL := '';

    strSQL := strSQL + 'SELECT';
    strSQL := strSQL + '  CONCAT(FATDOR.FDO_CODCLI, "-", CADCLI.CLI_NOMCLI) AS CLIENTE, ';
    strSQL := strSQL + '  CONCAT(FATDOR.FDO_NUMDOC, "-", FATDOR.FDO_ESPDOC, "-", FATDOR.FDO_CODEMP) AS DOCUMENTO, ';
    strSQL := strSQL + '  CADITE.ITE_CODITE,               ';
    strSQL := strSQL + '  CONCAT(CADITE.ITE_CODITE, "-", CADITE.ITE_DESITE) AS NOME_ITEM,  ';
    strSQL := strSQL + '  REPLACE(DESSIT.ITE_DESITE, "<BR>", " ") AS DESCRICAO,  ';
    strSQL := strSQL + '  REPLACE(DESSIT.ITE_APLITE, "<BR>", " ") AS APLICACAO,  ';
    strSQL := strSQL + '  REPLACE(DESSIT.ITE_DADTEC, "<BR>", " ") AS DADTECNIC,  ';
    strSQL := strSQL + '  DESSIT.ITE_INCLUS AS ITEINCLUS,  ';
    strSQL := strSQL + '  DESSIT.ITE_EXPALT AS ALTU,       ';
    strSQL := strSQL + '  DESSIT.ITE_EXPLAR AS LARG,       ';
    strSQL := strSQL + '  DESSIT.ITE_EXPPRO AS PROF,       ';
    strSQL := strSQL + '  CADITE.ITE_PESOIT AS PESO        ';
    strSQL := strSQL + 'FROM                               ';
    strSQL := strSQL + '  FATDOR                           ';
    strSQL := strSQL + '  INNER JOIN CADITE ON (CADITE.ITE_CODITE = FATDOR.FDO_CODITE) ';
    strSQL := strSQL + '  LEFT  JOIN DESSIT ON (DESSIT.ITE_CODITE = FATDOR.FDO_CODITE) ';
    strSQL := strSQL + '  LEFT  JOIN CADCLI ON (CADCLI.CLI_CODCLI = FATDOR.FDO_CODCLI) ';
    strSQL := strSQL + 'WHERE                               ';
    strSQL := strSQL + '  FATDOR.FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  FATDOR.FDO_ESPDOC = "OR" ';

    If Not fEmptyStr(edtNumDoc.Text) Then
      strSQL := strSQL + '  AND FATDOR.FDO_NUMDOC = :NUMDOC ';

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND FATDOR.FDO_CODEMP = :CODEMP ';

    If Not fEmptyStr(edtCodCliente.Text) Then
      strSQL := strSQL + '  AND FATDOR.FDO_CODCLI = :CODCLI ';

    If Not fEmptyStr(edtCodVendedor.Text) Then
      strSQL := strSQL + '  AND FATDOR.FDO_CODVEN = :CODVEN ';

    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  FATDOR.FDO_CODCLI, ';
    strSQL := strSQL + '  FATDOR.FDO_NUMDOC, ';
    strSQL := strSQL + '  FATDOR.FDO_DTAENT  ';

    qryRelatorio := fCriaQuery;

    cdsReport.Close;
    qryRelatorio.Close;
    qryRelatorio.SQL.Clear;
    qryRelatorio.SQL.Add(strSQL);

    qryRelatorio.ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
    qryRelatorio.ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);

    If Not fEmptyStr(edtNumDoc.Text) Then
      qryRelatorio.ParamByName('NUMDOC').AsString := edtNumDoc.Text;

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      qryRelatorio.ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    If Not fEmptyStr(edtCodCliente.Text) Then
      qryRelatorio.ParamByName('CODCLI').AsString := edtCodCliente.Text;

    If Not fEmptyStr(edtCodVendedor.Text) Then
      qryRelatorio.ParamByName('CODVEN').AsString := edtCodVendedor.Text;

    qryRelatorio.Open;

    If qryRelatorio.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'Não há dados para gerar o relatório.', ['&Ok']);
      pSetFocus(mskDtaIni);
    End
    Else
    Begin

      dspReport.DataSet    := qryRelatorio;
      frxRelatorio.DataSet := cdsReport;

      pCarregaConfImpr(qryCfgRel, Self.Name);
      strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      strTipImp   := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

      frxReport.PrintOptions.Printer := AnsiReplaceText(strNomeFila, '\\' + fRetNomeRede + '\', '');
      frxReport.PrepareReport;

      If (edtDestino.Text = 'V') Then
        pPreviewReport(Self.Name, Self.Caption + ' (Relatório)', frxReport)
      Else
        pPrintReport(Self.Name, Self.Caption + ' (Relatório)', strNomeFila, frxReport);
    End;

  Finally
    Screen.Cursor       := crDefault;
    btnImprimir.Enabled := True;
  End;

end;

procedure TfrmRelFatFichaTecnicaProdutosOrcamento.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCliente,edtDesCliente,arrCliente,nil,fRetNomCliente,'do Cliente');
end;

procedure TfrmRelFatFichaTecnicaProdutosOrcamento.edtCodClienteKeyPress(Sender: TObject; var Key: Char);
begin

  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatFichaTecnicaProdutosOrcamento.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelFatFichaTecnicaProdutosOrcamento.edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa, False) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatFichaTecnicaProdutosOrcamento.edtCodVendedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVendedor, edtDesVendedor, arrVendedor, fRetNomVendRep,nil, IIF(fCfgSis('VENMET') = '1', 'do Vendedor', 'do Represent. (I)'));
end;

procedure TfrmRelFatFichaTecnicaProdutosOrcamento.edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If (fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrVendedor, False)) Then
  Begin
    fValidaCampos(edtCodVendedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatFichaTecnicaProdutosOrcamento.FormCreate(Sender: TObject);
begin
  inherited;
  frxReport.AddFunction('procedure pCarregarImagemProduto;');
end;

procedure TfrmRelFatFichaTecnicaProdutosOrcamento.FormShow(Sender: TObject);
begin

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := fTamDocCadRec;

  inherited;

  SelectFirst;

end;

function TfrmRelFatFichaTecnicaProdutosOrcamento.frxReportUserFunction(const MethodName: string; var Params: Variant): Variant;
begin

  inherited;

  If MethodName = UpperCase('pCarregarImagemProduto') Then
    Case untFuncoesImagem.fCarregaImagemProduto(cdsReport.FieldByName('ITE_CODITE').AsString,
                                                TfrxPictureView(frxReport.FindObject('ImgProduto'))) Of
      riErro,
      riNulo,
      riNaoConfig: TfrxPictureView(frxReport.FindObject('ImgProduto')).Picture := nil;
    End;

end;

function TfrmRelFatFichaTecnicaProdutosOrcamento.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&OK']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) And (edtCodEmpresa.Text <> '000') Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtDesEmpresa.Text := 'TODAS';
      End
    End

    Else If (Sender = edtCodVendedor) Then
    Begin

      If Not fEmptyStr(edtCodVendedor.Text) Then
      Begin

        If Not fEmptyStr(edtCodVendedor.Text) And (edtCodVendedor.Text <> '000') Then
        Begin

          strCodVen := fRetCodVendedor(edtCodVendedor.Text);

          If Not fEmptyStr(strCodVen) Then
            edtDesVendedor.Text := fRetNomVendRep(strCodVen)
          Else
          Begin
            Result := False;
            fMensagem('', IIF(fCfgSis('VENMET') = '1', 'Vendedor', 'Representante (I)') + ' não encontrado.', ['&OK']);
          End;
        End
      End
      else
      begin
        edtDesVendedor.Text := 'TODOS';
        strCodVen := '';
      end;
    End;

  end;

end;

end.
