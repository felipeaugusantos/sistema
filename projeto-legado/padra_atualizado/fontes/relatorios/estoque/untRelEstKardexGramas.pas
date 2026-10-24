unit untRelEstKardexGramas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Mask, MaskEditFocus, frxDesgn, frxClass,
  frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS,
  frxExportRTF, RLFilters, RLDraftFilter, AppEvnts, Menus, untTypesSistema,
  StdCtrls, EditFocus, QColorLabel, ExtCtrls, Buttons, Uni, DB,untClassPanelCx,
  UniClientDataSet, BitBtnLockedIncrem, frxExportCSVTestabilidade, untIFuncoes,
  Datasnap.DBClient;

type
  TfrmRelEstKardexGramas = class(TfrmPaiRelatorio)
    pnlTopo: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label1: TLabel;
    edtProdutos: TEditFocus;
    edtDesProduto: TEditFocus;
    edtDesMarca: TEditFocus;
    edtEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Panel1: TPanel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    cdsMovBas: TUniClientDataSet;
    cdsMovBasNUMDOC: TStringField;
    cdsMovBasESPDOC: TStringField;
    cdsMovBasCODEMP: TStringField;
    cdsMovBasDTAENT: TDateField;
    cdsMovBasNOMCLI: TStringField;
    cdsMovBasQTDITE: TFloatField;
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtEmpresaExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function fRetCodBas(strCodIte: String): String;
    function fRetSalMl(strCodIte: String): Double;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl;
      blnValidaIndividual: Boolean): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmRelEstKardexGramas: TfrmRelEstKardexGramas;

implementation

uses untFuncoesFactory, StrUtils, untQckEstKardexGramas;

{$R *.dfm}

procedure TfrmRelEstKardexGramas.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGenIte   : TUniQuery;
    arrSel : TConsultasArray;

begin
  inherited;

  qryGenIte := fCriaQuery(nil);

    If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryGenIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
      Self.SelectNext(ActiveControl, True, True);

    FreeAndNil(qryGenIte);

end;

procedure TfrmRelEstKardexGramas.edtEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstKardexGramas.edtProdutosExit(Sender: TObject);
begin
  inherited;
  edtDesProduto.Text := fRetNomProduto(edtProdutos.Text);
  edtDesMarca.Text   := fRetMarcaItem(edtProdutos.Text);

  If fEmptyStr(edtDesProduto.Text) And (Not fEmptyStr(edtProdutos.Text))  Then
  Begin
    fMensagem('AVISO','Código do produto não encontrado.', ['&O K']);
    edtProdutos.Clear;
    pSetFocus(edtProdutos);
  End
  Else
    fValidaCampos(edtProdutos,False);
end;

procedure TfrmRelEstKardexGramas.edtEmpresaExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtEmpresa.Text) Then
  Begin
    pSetFocus(edtEmpresa);
    edtEmpresa.SelectAll;
  End
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtEmpresa.Clear;
    pSetFocus(edtEmpresa);
  End
  Else
    fValidaCampos(edtEmpresa,False);
end;

function TfrmRelEstKardexGramas.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    qryGenIte: TUniQuery;
begin
  Result := True;

  qryGenIte := fCriaQuery(Self);

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End;

    {*****************************}
    {* VERIFICA CAMPO DO PRODUTO *}
    {**************************AF*}
    If (Sender = edtProdutos) Then
    Begin

      If fEmptyStr(edtProdutos.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Produto deve ser preenchido!',['&O K']);
        Result := False;
      End;
    End;
    {*****************************}
    {* VERIFICA CAMPO DA EMPRESA *}
    {**************************AF*}
    If (Sender = edtEmpresa) Then
    Begin

      If fEmptyStr(edtEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Empresa deve ser preenchido!',['&O K']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

  FreeAndNil(qryGenIte);

end;

function TfrmRelEstKardexGramas.fRetCodBas(strCodIte: String): String;
  Var
    qryCadBas: TUniQuery;
begin
  qryCadBas := fCriaQuery(Self);
  qryCadBas.SQL.Add('SELECT SQL_NO_CACHE BAS_CODBAS FROM DUP_CADBAS WHERE BAS_CODITE = :CODITE');
  qryCadBas.ParamByName('CODITE').AsString := edtProdutos.Text;
  qryCadBas.Open;

  Result := qryCadBas.FieldByName('BAS_CODBAS').AsString;

  qryCadBas.Close;
  FreeAndNil(qryCadBas);
end;

procedure TfrmRelEstKardexGramas.btnImprimirClick(Sender: TObject);
  Var
    strCodBas: String;
    qryTinDet: TUniQuery;
    strSQL: String;
    intIndex: Integer;
begin
  inherited;

  If blnImprime Then
  Begin

    cdsMovBas.EmptyDataSet;

    strCodBas := fRetCodBas(edtProdutos.Text);
    qryTinDet := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  TINDET.*, ';
    strSQL := strSQL + '  CONCAT(DET_CODCLI, "-", CLI_NOMCLI) AS NOMCLI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TINDET ';
    strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  DET_IDEPRO = "DUP" ';

    qryTinDet.SQL.Add(strSQL);
    qryTinDet.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    qryTinDet.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    qryTinDet.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    qryTinDet.Open;

    While (Not qryTinDet.Eof) Do
    Begin

      For intIndex := 1 To 15 Do
      Begin

        If fEmptyStr(qryTinDet.FieldByName('DET_FORM' + fSTrZero(intIndex, 2)).AsString) Then
          Break;

        If qryTinDet.FieldByName('DET_FORM' + fSTrZero(intIndex, 2)).AsString <> strCodBas Then
          Continue;

        cdsMovBas.Append;
        cdsMovBas.FieldByName('NUMDOC').AsString   := qryTinDet.FieldByName('DET_NUMDOC').AsString;
        cdsMovBas.FieldByName('ESPDOC').AsString   := qryTinDet.FieldByName('DET_ESPDOC').AsString;
        cdsMovBas.FieldByName('CODEMP').AsString   := qryTinDet.FieldByName('DET_CODEMP').AsString;
        cdsMovBas.FieldByName('DTAENT').AsDateTime := qryTinDet.FieldByName('DET_DTAENT').AsDateTime;
        cdsMovBas.FieldByName('NOMCLI').AsString   := qryTinDet.FieldByName('NOMCLI').AsString;
        cdsMovBas.FieldByName('QTDITE').AsFloat    := qryTinDet.FieldByName('DET_QTDB' + fSTrZero(intIndex, 2)).AsFloat;
        cdsMovBas.Post;

      End;
      qryTinDet.Next;

    End;

    If Not cdsMovBas.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmQckEstKardexGramas, frmQckEstKardexGramas);
        frmQckEstKardexGramas.qckPagina.DataSource.Dataset := cdsMovBas;
        frmQckEstKardexGramas.rllSalML.Caption := 'SALDO EM ML: ' + FloatToStrF(fRetSalMl(edtProdutos.Text), ffFixed, 12, 4);
        frmQckEstKardexGramas.rllOrdem.Caption := 'PERÍODO: ' + mskDtaIni.Text + ' a ' + mskDtaFin.Text;
        frmQckEstKardexGramas.qckPagina.DefaultFilter := rldFiltro;
        frmQckEstKardexGramas.rllItem.Caption := edtProdutos.Text + '-' + edtDesProduto.Text;
        frmQckEstKardexGramas.qckPagina.PreviewModal;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[frmRelEstKardexGramas.btnImprimirClick]');
      End;

      pFreeAndNil(frmQckEstKardexGramas);
      
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Não há dados para gerar o relatório!', ['&Ok']);
    End;

    qryTinDet.Close;
    FreeAndNil(qryTinDet);
    
  End;

  btnImprimir.Enabled := True;
end;

procedure TfrmRelEstKardexGramas.FormCreate(Sender: TObject);
begin
  inherited;
  cdsMovBas.CreateDataSet;
end;

function TfrmRelEstKardexGramas.fRetSalMl(strCodIte: String): Double;
  Var
    qryIteGer: TUniQuery;
begin

  qryIteGer := fCriaQuery(Self);
  qryIteGer.SQL.Add('SELECT SQL_NO_CACHE ITE_SAL_ML FROM ITEGER WHERE ITE_CODITE = :CODITE ');
  qryIteGer.SQL.Add('AND ITE_CODEMP = :CODEMP ');

  qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryIteGer.ParamByName('CODITE').AsString := strCodIte;

  qryIteGer.Open;
  Result := qryIteGer.FieldByName('ITE_SAL_ML').AsFloat;
  qryIteGer.Close;

  FreeAndNil(qryIteGer);

end;

end.

