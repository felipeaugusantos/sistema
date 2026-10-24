unit untFatDocsPendentesRemessaDevolucao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untTypesSistema, StrUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, MaskEditFocus, Uni,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxButtonEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, DateUtils,
  Datasnap.DBClient, Vcl.ComCtrls;

type
  TfrmFatDocsPendentesRemessaDevolucao = class(TfrmPai)
    pnlCabecalho: TPanel;
    btnPesquisar: TBitBtnLocked;
    lblDataInicial: TLabel;
    lblDataFinal: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    lblEmp: TLabel;
    edtNomEmp: TEditFocus;
    Label4: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    grdDocumentos: TcxGrid;
    grdDocumentosDBTvDoc: TcxGridDBTableView;
    grdDocumentosDBTvDocDTAENT: TcxGridDBColumn;
    grdDocumentosDBTvDocHORENT: TcxGridDBColumn;
    grdDocumentosDBTvDocDOCUMENTO: TcxGridDBColumn;
    grdDocumentosDBTvDocCLIENTE: TcxGridDBColumn;
    grdDocumentosDBTvDocFIS_ACESSO: TcxGridDBColumn;
    grdDocumentosDBTableView1: TcxGridDBTableView;
    grdDocumentosDBTvItens: TcxGridDBTableView;
    grdDocumentosDBTvItensPRODUTO: TcxGridDBColumn;
    grdDocumentosDBTvItensDET_QTDITE: TcxGridDBColumn;
    grdDocumentosDBTvItensDET_CLAFIS: TcxGridDBColumn;
    grdDocumentosLevel1: TcxGridLevel;
    grdDocumentosLevel2: TcxGridLevel;
    cdsDocumentos: TUniClientDataSet;
    dtsDocumentos: TDataSource;
    cdsDocumentosDET_DTAENT: TDateField;
    cdsDocumentosDET_HORENT: TTimeField;
    cdsDocumentosDOCUMENTO: TStringField;
    cdsDocumentosDET_CODCLI: TStringField;
    cdsDocumentosCLI_NOMCLI: TStringField;
    cdsDocumentosFIS_ACESSO: TStringField;
    cdsDocumentosCLIENTE: TStringField;
    cdsDocumentosDET_NUMDOC: TStringField;
    cdsDocumentosDET_ESPDOC: TStringField;
    cdsDocumentosDET_CODEMP: TStringField;
    cdsItens: TUniClientDataSet;
    dtsItens: TDataSource;
    cdsItensPRODUTO: TStringField;
    cdsItensDET_QTDITE: TFloatField;
    cdsItensDET_CLAFIS: TStringField;
    cdsItensDET_CODITE: TStringField;
    cdsItensDOCUMENTO: TStringField;
    pgbStatus: TProgressBar;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FstrChavesJaInclusas: String;
    procedure pConsultaDocumentos;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
  public
    { Public declarations }
    property strChavesJaInclusas: String read FstrChavesJaInclusas write FstrChavesJaInclusas;
  end;

implementation

uses
  untFuncoesSimples,
  untGravando,
  untConsultas;

{$R *.dfm}

procedure TfrmFatDocsPendentesRemessaDevolucao.btnPesquisarClick(
  Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
    TfrmGravando.fExecutarModal(pConsultaDocumentos, 'Aguarde... Carregando documentos.','');
end;

procedure TfrmFatDocsPendentesRemessaDevolucao.pConsultaDocumentos;
  Var
    strDocumento: string;
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  Try
    cdsDocumentos.DisableControls;
    cdsItens.DisableControls;

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT ');
    qryGen.SQL.Add('   DET_DTAENT, DET_HORENT, DET_NUMDOC, DET_ESPDOC, DET_CODEMP, ');
    qryGen.SQL.Add('   DET_CODCLI, CLI_NOMCLI, FIS_ACESSO, ');
    qryGen.SQL.Add('   CONCAT(DET_CODCLI, "-", CLI_NOMCLI) AS CLIENTE, ');
    qryGen.SQL.Add('   CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP) AS DOCUMENTO, ');
    qryGen.SQL.Add('   CONCAT(DET_CODITE, "-", DET_DESCRI) AS PRODUTO, ');
    qryGen.SQL.Add('   DET_CODITE, DET_DESCRI, DET_QTDITE, DET_CLAFIS ');
    qryGen.SQL.Add(' FROM MOVDET A ');
    qryGen.SQL.Add('   LEFT JOIN MOVAUX B ON A.AUTOINCREM = B.DET_SEQGER  ');
    qryGen.SQL.Add('   INNER JOIN MOVTRI C ON A.AUTOINCREM = C.DET_SEQGER ');
    qryGen.SQL.Add('   LEFT JOIN REMDEV D ON A.AUTOINCREM = D.RMV_AUTDEV  ');
    qryGen.SQL.Add('   INNER JOIN CADCLI E ON A.DET_CODCLI = E.CLI_CODCLI ');
    qryGen.SQL.Add('   INNER JOIN CADFIS F ON A.DET_NUMDOC = F.FIS_NUMDOC AND ');
    qryGen.SQL.Add('                          A.DET_ESPDOC = F.FIS_ESPDOC AND ');
    qryGen.SQL.Add('                          A.DET_CODEMP = F.FIS_CODEMP AND ');
    qryGen.SQL.Add('                          A.DET_CODCLI = F.FIS_FORCLI AND ');
    qryGen.SQL.Add('                          A.DET_SERIE_ = F.FIS_SERIE_     ');
    qryGen.SQL.Add(' WHERE ');
    qryGen.SQL.Add('   DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND  ');
    qryGen.SQL.Add('   DET_CODEMP = :CODEMP AND ');

    If (Not fEmptyStr(edtCodIte.Text)) Then
      qryGen.SQL.Add('   DET_CODITE = :CODITE AND ');

    qryGen.SQL.Add('   DET_TIP_FC = "C" AND ');
    qryGen.SQL.Add('   (LOCATE(DET_CLAFIS, :CLAFIS) > 0)  AND ');

    If (Not fEmptyStr(Self.strChavesJaInclusas)) Then
      qryGen.SQL.Add('   (LOCATE(FIS_ACESSO, :CHAVES) <= 0)  AND ');

    qryGen.SQL.Add('   DET_CODEXT IS NOT NULL AND ');
    qryGen.SQL.Add('   RMV_AUTDEV IS NULL AND ');
    qryGen.SQL.Add('   DET_FILFUL = 0; ');
    qryGen.ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    qryGen.ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    qryGen.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryGen.ParamByName('CLAFIS').AsString := '1949_2949_' + VS_strClaDev;

    If (Not fEmptyStr(edtCodIte.Text)) Then
      qryGen.ParamByName('CODITE').AsString := edtCodIte.Text;

    If (Not fEmptyStr(Self.strChavesJaInclusas)) Then
      qryGen.ParamByName('CHAVES').AsString := Self.strChavesJaInclusas;
    qryGen.Open;

    cdsDocumentos.Open;
    cdsDocumentos.EmptyDataSet;

    cdsItens.Open;
    cdsItens.EmptyDataSet;

    pgbStatus.Visible := True;
    pgbStatus.Max     := qryGen.RecordCount;

    strDocumento := EmptyStr;
    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      If (strDocumento <> qryGen.FieldByName('DOCUMENTO').AsString) Then
      Begin
        cdsDocumentos.Append;
        cdsDocumentosDET_DTAENT.AsDateTime := qryGen.FieldByName('DET_DTAENT').AsDateTime;
        cdsDocumentosDET_HORENT.AsString := qryGen.FieldByName('DET_HORENT').AsString;
        cdsDocumentosDOCUMENTO.AsString  := qryGen.FieldByName('DOCUMENTO').AsString;
        cdsDocumentosDET_CODCLI.AsString := qryGen.FieldByName('DET_CODCLI').AsString;
        cdsDocumentosCLI_NOMCLI.AsString := qryGen.FieldByName('CLI_NOMCLI').AsString;
        cdsDocumentosFIS_ACESSO.AsString := EmptyStr;

        If (Not fEmptyStr(qryGen.FieldByName('FIS_ACESSO').AsString)) Then
          cdsDocumentosFIS_ACESSO.AsString := LeftStr(qryGen.FieldByName('FIS_ACESSO').AsString, 10) + StringOfChar('*', 24) + RightStr(qryGen.FieldByName('FIS_ACESSO').AsString, 10);

        cdsDocumentosCLIENTE.AsString    := qryGen.FieldByName('CLIENTE').AsString;
        cdsDocumentosDET_NUMDOC.AsString := qryGen.FieldByName('DET_NUMDOC').AsString;
        cdsDocumentosDET_ESPDOC.AsString := qryGen.FieldByName('DET_ESPDOC').AsString;
        cdsDocumentosDET_CODEMP.AsString := qryGen.FieldByName('DET_CODEMP').AsString;;
        cdsDocumentos.Post;
        Application.ProcessMessages;
      End;

      cdsItens.Append;
      cdsItensPRODUTO.AsString    := qryGen.FieldByName('PRODUTO').AsString;
      cdsItensDET_QTDITE.AsString := qryGen.FieldByName('DET_QTDITE').AsString;
      cdsItensDET_CLAFIS.AsString := qryGen.FieldByName('DET_CLAFIS').AsString;
      cdsItensDET_CODITE.AsString := qryGen.FieldByName('DET_CODITE').AsString;
      cdsItensDOCUMENTO.AsString  := qryGen.FieldByName('DOCUMENTO').AsString;
      cdsItens.Post;

      strDocumento := qryGen.FieldByName('DOCUMENTO').AsString;
      qryGen.Next;

      pgbStatus.Position := qryGen.RecNo;
    End;
  Finally
    pgbStatus.Visible := False;
    cdsDocumentos.EnableControls;
    cdsitens.EnableControls;
    FreeAndNil(qryGen);
  End;

  If (Not grdDocumentosDBTvDoc.DataController.DataSource.DataSet.IsEmpty) Then
    grdDocumentosDBTvDoc.ViewData.Collapse(True);
end;

procedure TfrmFatDocsPendentesRemessaDevolucao.edtCodEmpKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDocsPendentesRemessaDevolucao.edtCodIteKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
      If (fValidaCampos(edtCodIte, True)) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmFatDocsPendentesRemessaDevolucao.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDocumentos.CreateDataSet;
  cdsItens.CreateDataSet;
end;

procedure TfrmFatDocsPendentesRemessaDevolucao.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
end;

function TfrmFatDocsPendentesRemessaDevolucao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Sender = mskDtaIni) Then
  Begin
    If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = mskDtaFin) Then
  Begin
    If (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else
    If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
    Begin
      fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
      Result := False;
    End
    Else
    If DaysBetween(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text)) > 30 Then
    Begin
      fMensagem('','A Data Final superior a 30 dias em relação a Data Inicial!',['&O K']);
      Result := False;
    End;
  End

  Else If (Sender = edtCodEmp) And (edtCodEmp.Visible) Then
  Begin
    edtNomEmp.Clear;
    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código da empresa deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
      If fEmptyStr(edtNomEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Empresa não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodIte) then
  Begin
    If (blnBuscaPorChave) And (Not fEmptyStr(edtCodIte.Text)) Then
    Begin
      edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
      edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

      If fEmptyStr(edtDesIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
