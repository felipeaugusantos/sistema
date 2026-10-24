unit untReimpressaoBorderoTelecheque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, Uni,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, UniDataSetProvider, UniClientDataSet, StrUtils, untFuncoesGenerica,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxContainer, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmReimpressaoBorderoTelecheque = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    edtCodBor: TEditFocus;
    lbl13: TLabel;
    edtDesEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    lblEmpresa: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl1: TLabel;
    grdBorderosDBTableView1: TcxGridDBTableView;
    grdBorderosLevel1: TcxGridLevel;
    grdBorderos: TcxGrid;
    pnl2: TPanel;
    grdBorderosCHQ_SEQTEL: TcxGridDBColumn;
    grdBorderosCHQ_QTDCHQ: TcxGridDBColumn;
    grdBorderosCHQ_DTAENV: TcxGridDBColumn;
    grdBorderosCHQ_CODEMP: TcxGridDBColumn;
    dtsTemp: TDataSource;
    grdBorderosCHQ_MARDES: TcxGridDBColumn;
    btnSair1: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    mskEnvIni: TcxDateEdit;
    mskEnvFin: TcxDateEdit;
    btnConsultar: TBitBtnLocked;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdBorderosDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure grdBorderosDBTableView1DblClick(Sender: TObject);
    procedure grdBorderosDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
  private
    { Private declarations }
    qryTemp   : TUniQuery;
    cpvTemp   : TUniDataSetProvider;
    cdsTemp   : TUniClientDataSet;
    qryRel    : TUniQuery;
    cpvRel    : TUniDataSetProvider;
    cdsRel    : TUniClientDataSet;

    FPais     : TPais;

    procedure pLimpaDados;
    procedure pCriaTemporaria;
    procedure pImprimeBordero;
    procedure pSelecionaCheque;
    procedure pMarcaCheque(blnMarcar: Boolean; blnAtuGrid: Boolean = True);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untModuloBaixaChequesTelecheque, untTypesSistema, untIFuncoes, untFuncoesSimples,
     untConsultas, untFuncoes, untCfgRel;

{$R *.dfm}

{ TfrmReimpressaoBorderoTelecheque }

procedure TfrmReimpressaoBorderoTelecheque.btnConsultarClick(Sender: TObject);
begin
  inherited;
  if (fValidaCampos(mskEnvIni))  then
  begin
    if (not mskEnvFin.Enabled) or ((mskEnvFin.Enabled) and (fValidaCampos(mskEnvFin))) then
    begin
      if fValidaCampos(edtCodEmp) then
      begin
        pCriaTemporaria;
      end;
    end;
  end;
end;

procedure TfrmReimpressaoBorderoTelecheque.btnImprimirClick(Sender: TObject);
begin
  inherited;
  If Assigned(cdsTemp) And cdsTemp.Active And (Not cdsTemp.IsEmpty) Then
  Begin
    pImprimeBordero;
    pLimpaDados;
  End
  Else
    fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);

  pSetFocus(mskEnvIni);
end;

procedure TfrmReimpressaoBorderoTelecheque.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmReimpressaoBorderoTelecheque.FormCreate(Sender: TObject);
begin
  inherited;
  FPais := fSetaPais;
end;

procedure TfrmReimpressaoBorderoTelecheque.FormShow(Sender: TObject);
begin
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  inherited;
end;

function TfrmReimpressaoBorderoTelecheque.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskEnvIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskEnvIni.Text)) Then
      Begin
        mskEnvFin.Enabled := False;
        mskEnvFin.Clear;
      End

      Else
        mskEnvFin.Enabled := True;
    End

    Else If (Sender = mskEnvFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskEnvFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Digite a data Final!', ['&O k']);
        Result := False;
      End

      Else If Not (fValidaPeriodo(mskEnvIni.Text, mskEnvFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        If (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End;

  End;
  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmReimpressaoBorderoTelecheque.grdBorderosDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strMarDes: String;
begin
  inherited;
  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdBorderosCHQ_MARDES.Index]);
  If (strMarDes = 'M') Then
  Begin
    ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmReimpressaoBorderoTelecheque.grdBorderosDBTableView1DblClick(
  Sender: TObject);
begin
  inherited;
  pSelecionaCheque;
  pSetFocus(Self);
end;

procedure TfrmReimpressaoBorderoTelecheque.grdBorderosDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    pSelecionaCheque;
    pSetFocus(Self);
  End

  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(mskEnvIni);
  End;
end;

procedure TfrmReimpressaoBorderoTelecheque.pCriaTemporaria;
  Var
    strSQL: String;
begin
  qryTemp         := fCriaQuery(Self);
  cdsTemp         := TUniClientDataSet.Create(Self);
  cpvTemp         := TUniDataSetProvider.Create(Self);
  cpvTemp.DataSet := qryTemp;
  dtsTemp.DataSet := cdsTemp;

  strSQL := '';
  strSQL := strSQL + 'SELECT        ';
  strSQL := strSQL + '  CHQ_SEQTEL, ';
  strSQL := strSQL + '  CHQ_DOCUME, ';
  strSQL := strSQL + '  COUNT(CHQ_SEQTEL) AS CHQ_QTDCHQ, ';
  strSQL := strSQL + '  CHQ_DTAENV, ';
  strSQL := strSQL + '  CHQ_CODEMP, ';
  strSQL := strSQL + '  " " AS CHQ_MARDES ';
  strSQL := strSQL + 'FROM          ';
  strSQL := strSQL + '  CHQTEL      ';
  strSQL := strSQL + 'WHERE         ';
  strSQL := strSQL + '  TRUE        ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskEnvIni.Text)) Then
    strSQL := strSQL + '  AND CHQ_DTAENV BETWEEN :ENVINI AND :ENVFIN ';

  If Not fEmptyStr(edtCodBor.Text) Then
    strSQL := strSQL + '  AND CHQ_SEQTEL = :CODBOR ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    strSQL := strSQL + '  AND CHQ_CODEMP = :CODEMP ';

  strSQL := strSQL + ' GROUP BY CHQ_SEQTEL ';


  With qryTemp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(fTiraCaracEspeciais(mskEnvIni.Text)) Then
    Begin
      ParamByName('ENVINI').AsDateTime := StrToDateTime(mskEnvIni.Text);
      ParamByName('ENVFIN').AsDateTime := StrToDateTime(mskEnvFin.Text);
    End;

    If Not fEmptyStr(edtCodBor.Text) Then
      ParamByName('CODBOR').AsString := edtCodBor.Text;

    If Not fEmptyStr(edtCodEmp.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    Open;
    pSetaClient(qryTemp);

    cdsTemp.Close;
    cdsTemp.SetProvider(cpvTemp);
    cdsTemp.Open;
  End;
end;

procedure TfrmReimpressaoBorderoTelecheque.pImprimeBordero;
  Var
    intCont   : Integer;
    strSQL    : String;
    strDirImg : String;
begin
  Try
    qryRel         := fCriaQuery(Self);
    cdsRel         := TUniClientDataSet.Create(Self);
    cpvRel         := TUniDataSetProvider.Create(Self);
    cpvRel.DataSet := qryRel;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  Q.AUTOINCREM, ';
    strSQL := strSQL + '  Q.CHQ_CODPOR, ';
    strSQL := strSQL + '  Q.CHQ_CODBCO, ';
    strSQL := strSQL + '  Q.CHQ_C_G_C_, ';
    strSQL := strSQL + '  Q.CHQ_NUMAGE, ';
    strSQL := strSQL + '  Q.CHQ_CONCOR, ';
    strSQL := strSQL + '  Q.CHQ_NUMCHQ, ';
    strSQL := strSQL + '  Q.CHQ_CODEMP, ';
    strSQL := strSQL + '  Q.CHQ_CODCLI, ';
    strSQL := strSQL + '  Q.CHQ_NOMEMI, ';
    strSQL := strSQL + '  Q.CHQ_ENDERE, ';
    strSQL := strSQL + '  Q.CHQ_TELEMI, ';
    strSQL := strSQL + '  Q.CHQ_NUMNOT, ';
    strSQL := strSQL + '  Q.CHQ_DTAVEN, ';
    strSQL := strSQL + '  Q.CHQ_VALCHQ, ';
    strSQL := strSQL + '  Q.CHQ_DTACUS, ';
    strSQL := strSQL + '  Q.CHQ_PORCUS, ';
    strSQL := strSQL + '  Q.CHQ_CDPRSV, ';
    strSQL := strSQL + '  IF(Q.CHQ_MOTDV2 IS NULL, Q.CHQ_MOTDEV, Q.CHQ_MOTDV2) AS CHQ_MOTDEV, ';
    strSQL := strSQL + '  LEFT(Q.CHQ_DUPDEV, 12) AS CHQ_DUPDEV, ';
    strSQL := strSQL + '  CAST(IF(Q.CHQ_DTADP2 IS NULL, Q.CHQ_DTADEP, Q.CHQ_DTADP2) AS DATE) AS CHQ_DTADEP, ';
    strSQL := strSQL + '  Q.CHQ_OBSREP, ';
    strSQL := strSQL + '  Q.CHQ_TELNUM, ';
    strSQL := strSQL + '  T.CHQ_DTAENV, ';
    strSQL := strSQL + '  T.CHQ_SEQTEL, ';
    strSQL := strSQL + '  T.CHQ_DOCUME, ';
    strSQL := strSQL + '  0 AS CONTADOR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ Q ';
    strSQL := strSQL + '  LEFT JOIN CHQTEL T ON Q.AUTOINCREM = T.CHQ_SEQCHQ ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  T.CHQ_SEQTEL = :SEQTEL ';

    qryRel.Close;
    qryRel.SQL.Clear;
    qryRel.SQL.Add(strSQL);
    qryRel.ParamByName('SEQTEL').AsInteger := -1;
    qryRel.Open;

    pSetaClient(qryRel);
    cdsRel.Close;
    cdsRel.SetProvider(cpvRel);
    cdsRel.Open;
    cdsRel.EmptyDataSet;

    cdsTemp.First;
    While Not cdsTemp.Eof Do
    Begin
      intCont := 0;
      If (cdsTemp.FieldByName('CHQ_MARDES').AsString = 'M') Then
      Begin
        qryRel.Close;
        qryRel.ParamByName('SEQTEL').AsInteger := cdsTemp.FieldByName('CHQ_SEQTEL').AsInteger;
        qryRel.Open;
        qryRel.First;
        While Not qryRel.Eof Do
        Begin
          Inc(intCont);
          cdsRel.Append;
          cdsRel.FieldByName('CONTADOR').AsInteger   := intCont;
          cdsRel.FieldByName('CHQ_C_G_C_').AsString  := fFormataCpfCgc(qryRel.FieldByName('CHQ_C_G_C_').AsString, FPais);
          cdsRel.FieldByName('CHQ_TELNUM').AsString  := qryRel.FieldByName('CHQ_TELNUM').AsString;
          cdsRel.FieldByName('CHQ_CODBCO').AsString  := qryRel.FieldByName('CHQ_CODBCO').AsString;
          cdsRel.FieldByName('CHQ_NUMAGE').AsString  := qryRel.FieldByName('CHQ_NUMAGE').AsString;
          cdsRel.FieldByName('CHQ_NUMCHQ').AsString  := qryRel.FieldByName('CHQ_NUMCHQ').AsString;
          cdsRel.FieldByName('CHQ_MOTDEV').AsString  := qryRel.FieldByName('CHQ_MOTDEV').AsString;
          cdsRel.FieldByName('CHQ_VALCHQ').AsFloat   := qryRel.FieldByName('CHQ_VALCHQ').AsFloat;
          cdsRel.FieldByName('CHQ_SEQTEL').AsInteger := qryRel.FieldByName('CHQ_SEQTEL').AsInteger;
          cdsRel.FieldByName('CHQ_DOCUME').AsString  := qryRel.FieldByName('CHQ_DOCUME').AsString;
          cdsRel.Post;

          qryRel.Next;
        End;

      End;
      cdsTemp.Next;
    End;
    cdsRel.First;

    If FileExists(fCfgSis('PATLOG')) Then
      strDirImg := fCfgSis('PATLOG')
    Else
      strDirImg := '';

    pCriarFormularios(TfrmModuloBaixaChequesTelecheque,frmModuloBaixaChequesTelecheque);
    With frmModuloBaixaChequesTelecheque Do
    Begin
      strImagem            := strDirImg;
      strNomeEmp           := fRetNomeEmpresa;
      frxRelatorio.DataSet := cdsRel;
      If cdsRel.RecordCount > 0 Then
        pPreviewReport(Self.Name, Self.Caption + ' (Bordero)', frxBordero)
      Else
        pMensagemOK('Marque pelo menos um borderô!');
    End;
  Finally
    FreeAndNil(frmModuloBaixaChequesTelecheque);
    FreeAndNil(cdsRel);
  End;
end;

procedure TfrmReimpressaoBorderoTelecheque.pLimpaDados;
begin
  edtCodBor.Clear;
  edtCodEmp.Clear;
  edtDesEmp.Clear;

  mskEnvIni.Clear;
  mskEnvFin.Clear;

  cdsTemp.Close;
end;

procedure TfrmReimpressaoBorderoTelecheque.pMarcaCheque(blnMarcar,
  blnAtuGrid: Boolean);
begin
  Try
    cdsTemp.Edit;
    cdsTemp.FieldByName('CHQ_MARDES').AsString := IfThen(blnMarcar, 'M', 'D');
    cdsTemp.Post;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmReimpressaoBorderoTelecheque.pSelecionaCheque;
  Var
    intRecNo: Integer;
begin
  If (Not cdsTemp.Active) Or
     (cdsTemp.IsEmpty)    Then
  Begin
    Exit;
  End;

  intRecNo := cdsTemp.RecNo;
  If (cdsTemp.FieldByName('CHQ_MARDES').AsString <> 'M') Then
  Begin
    pMarcaCheque(True);
  End
  Else
  Begin
    pMarcaCheque(False);
  End;
  cdsTemp.RecNo := intRecNo;
end;

end.
