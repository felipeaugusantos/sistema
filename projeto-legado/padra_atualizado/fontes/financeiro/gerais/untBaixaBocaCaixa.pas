unit untBaixaBocaCaixa;

interface

uses
  Windows, Classes, Controls, untPaiSimples, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Uni, DB, Grids, DBGridCitel, DBGrids, EditFocus, untBocaCaixa, AppEvnts, UniClientDataSet,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmBaixaBocaCaixa = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    lblVen: TLabel;
    edtCodVendedor: TEditFocus;
    edtNomVendedor: TEditFocus;
    pnlBotoesBaixa: TPanel;
    pnlAux1: TPanel;
    pnlTotais: TPanel;
    dbgDocumentos: TDBGridCitel;
    dtsGrid: TDataSource;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    edtQtdSel: TEditFocus;
    Label21: TLabel;
    edtValorSel: TEditFocus;
    Label23: TLabel;
    edtComSel: TEditFocus;
    Label2: TLabel;
    edtQtdGer: TEditFocus;
    edtValorGer: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    edtComGer: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    FlwBotoesBaixa: TFlowPanel;
    btnSairBaixa: TBitBtnLocked;
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure dbgDocumentosDblClick(Sender: TObject);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    objBcaCai: TBcaCai;
    qryGen   : TUniQuery;
    qryCadOpe: TUniQuery;
    cdsTotal : TUniClientDataSet;
    procedure pCarregaDadosGrid(strCodVen: String);
    procedure pSelecionaDocumento;
    procedure pMarcaDocumento(blnMarcar: Boolean);
    procedure pCalculaTotais;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    intRecAtu: Integer;
  end;


implementation

uses SysUtils, Graphics, Forms, untFuncoesSimples, untCfgRel, untConsultas,
  System.UITypes, untTypesSistema;

{$R *.dfm}

function TfrmBaixaBocaCaixa.fValidaCampos(Sender: TWinControl;blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {********************************}
    {* VALIDA O CÓDIGO DO VENDEDOR  *}
    {*****************************LU*}
    If (Sender = edtCodVendedor) Then
    Begin

      If fEmptyStr(edtCodVendedor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O vendedor deve ser informado!', ['&Ok']);
        Result := False;
        objBcaCai.cdsBaixaBcaCai.Close;
        edtNomVendedor.Clear;
        pSetFocus(edtCodVendedor);
      End
      Else
      Begin
        edtNomVendedor.Text := fRetNomVendRep(edtCodVendedor.Text);

        If fEmptyStr(edtNomVendedor.Text) Then
        Begin
          fMensagem('AVISO','Código do vendedor não encontrado.', ['&O K']);
          edtCodVendedor.Clear;
          pSetFocus(edtCodVendedor);
        End
        Else
          pCarregaDadosGrid(edtCodVendedor.Text);
      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaBocaCaixa.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodVendedor, edtNomVendedor, qryCadOpe, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodVendedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaBocaCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  objBcaCai := TBcaCai.Create(Self);
  qryGen := fCriaQuery(Self);
  qryCadOpe := fCriaQuery(Self);

  cdsTotal := TUniClientDataSet.Create(Self);
  cdsTotal.AggregatesActive := True;

  {***************************************}
  {* CRIA OS AGGREGATES                  *}
  {************************************LU*}
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VLRTOT';
    FieldName     := 'TOT_VLRTOT';
    DataSet       := cdsTotal;
    Expression    := 'SUM(VLRTOT)';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VLRCOM';
    FieldName     := 'TOT_VLRCOM';
    DataSet       := cdsTotal;
    Expression    := 'SUM(VLRCOM)';
    Active        := True;
  End;

  dtsGrid.DataSet := objBcaCai.cdsBaixaBcaCai;
  dbgDocumentos.DataSource := dtsGrid;
  pSetFocus(edtCodVendedor);
end;

procedure TfrmBaixaBocaCaixa.dbgDocumentosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  With objBcaCai.cdsBaixaBcaCai Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If (FindField('MARDES') = Nil) Then
      Exit;

    If FieldByName('MARDES').AsString = 'M' Then
    Begin
      dbgDocumentos.Canvas.Font.Color := clBlue;

      If dbgDocumentos.Canvas.Brush.Color = clHighLight Then
        dbgDocumentos.Canvas.Font.Color := clHighlightText;
    End;

  End;

  dbgDocumentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmBaixaBocaCaixa.pCarregaDadosGrid(strCodVen: String);
Begin
  Try
    objBcaCai.cdsBaixaBcaCai.DisableControls;

    objBcaCai.pCarregaDadosBaixa(strCodVen);

    edtQtdGer.Text := objBcaCai.strQtdIte;
    edtValorGer.Text := objBcaCai.strVlrTot;
    edtComGer.Text := objBcaCai.strVlrCom;    

    pCalculaTotais;

    objBcaCai.cdsBaixaBcaCai.EnableControls;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

  dbgDocumentos.Enabled := True;
  dbgDocumentos.Refresh;

End;

procedure TfrmBaixaBocaCaixa.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  close;
end;


procedure TfrmBaixaBocaCaixa.dbgDocumentosDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDocumento;
end;

procedure TfrmBaixaBocaCaixa.pSelecionaDocumento;
  Var
    intRecNo: Integer;
begin

  intRecNo := objBcaCai.cdsBaixaBcaCai.RecNo;

  If objBcaCai.cdsBaixaBcaCai.FieldByName('MARDES').AsString <> 'M' Then
    pMarcaDocumento(True)
  Else
    pMarcaDocumento(False);

  objBcaCai.cdsBaixaBcaCai.RecNo := intRecNo;

  pCalculaTotais;  

end;

procedure TfrmBaixaBocaCaixa.pMarcaDocumento(blnMarcar: Boolean);
begin

  With objBcaCai.cdsBaixaBcaCai Do
  Begin

    If (Not Active) Or (RecordCount <= 0) Then
      Exit;

    Edit;

    If blnMarcar Then
      FieldByName('MARDES').AsString := 'M'
    Else
      FieldByName('MARDES').AsString := 'D';

    Post;
  End;

end;

procedure TfrmBaixaBocaCaixa.btnMarcarTodasClick(Sender: TObject);
begin
  inherited;
  If (Not objBcaCai.cdsBaixaBcaCai.Active) Or (objBcaCai.cdsBaixaBcaCai.IsEmpty) Then
    Exit;

  Try
    objBcaCai.cdsBaixaBcaCai.DisableControls;
    objBcaCai.cdsBaixaBcaCai.IndexFieldNames := '';

    objBcaCai.cdsBaixaBcaCai.First;
    While Not objBcaCai.cdsBaixaBcaCai.Eof Do
    Begin
      pMarcaDocumento(True);
      objBcaCai.cdsBaixaBcaCai.Next;
    End;
  Finally
    objBcaCai.cdsBaixaBcaCai.EnableControls;
  End;

  pCalculaTotais;

end;

procedure TfrmBaixaBocaCaixa.pCalculaTotais;
begin

  cdsTotal.Data := objBcaCai.cdsBaixaBcaCai.Data;

  cdsTotal.Filter := ' MARDES = ''M'' ';
  cdsTotal.Filtered := True;

  edtQtdSel.Text := IntToStr(cdsTotal.RecordCount);

  If Not cdsTotal.IsEmpty Then
  Begin
    edtValorSel.Text := FormatFloat('#,##0.00', TAggregateField(cdsTotal.FieldByName('TOT_VLRTOT')).Value);
    edtComSel.Text   := FormatFloat('#,##0.00', TAggregateField(cdsTotal.FieldByName('TOT_VLRCOM')).Value);
  End
  Else
  Begin
    edtValorSel.Text := '0,00';
    edtComSel.Text   := '0,00';
  End;

end;

procedure TfrmBaixaBocaCaixa.FormShow(Sender: TObject);
begin
  inherited;
  edtQtdSel.Text := '0';
  edtValorSel.Text := '0,00';
  edtComSel.Text   := '0,00';

  edtQtdGer.Text := '0';
  edtValorGer.Text := '0,00';
  edtComGer.Text   := '0,00';

  lblVen.Caption := IIF(fCfgSis('BCAVEN', varString) = '1', 'Vendedor 1:', 'Vendedor 2:');
end;

procedure TfrmBaixaBocaCaixa.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    pSelecionaDocumento;
  End
  Else If (Key = VK_Escape) Then
  Begin
    blnMudarFoco := False;
    objBcaCai.cdsBaixaBcaCai.Close;
    edtCodVendedor.Clear;
    edtNomVendedor.Clear;
    pSetFocus(edtCodVendedor);
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_F8) Then
  Begin
    btnMarcarTodas.Click;
  End
  Else If (Key = VK_F7) Then
  Begin
    btnDesmarcarTodas.Click;
  End;
end;

procedure TfrmBaixaBocaCaixa.btnDesmarcarTodasClick(Sender: TObject);
begin
  inherited;
  If (Not objBcaCai.cdsBaixaBcaCai.Active) Or (objBcaCai.cdsBaixaBcaCai.IsEmpty) Then
    Exit;

  Try
    objBcaCai.cdsBaixaBcaCai.DisableControls;
    objBcaCai.cdsBaixaBcaCai.IndexFieldNames := '';

    objBcaCai.cdsBaixaBcaCai.First;
    While Not objBcaCai.cdsBaixaBcaCai.Eof Do
    Begin
      pMarcaDocumento(False);
      objBcaCai.cdsBaixaBcaCai.Next;
    End;
  Finally
    objBcaCai.cdsBaixaBcaCai.EnableControls;
  End;

  pCalculaTotais;
end;

procedure TfrmBaixaBocaCaixa.btnConfirmaClick(Sender: TObject);
var
  stlSeqGer: TStringList;
  intQtdBai: Integer;
begin
  inherited;
  If (Not objBcaCai.cdsBaixaBcaCai.Active) Or (objBcaCai.cdsBaixaBcaCai.IsEmpty) Then
    Exit;

  If edtQtdSel.Text = '0' Then
  Begin
    fMensagem('','Nenhum documento foi selecionado para baixa.', ['&O K']);
    exit;
  End;

  stlSeqGer := nil;
  intQtdBai := 0;

  Try
    try
      fStartTransaction;

      objBcaCai.cdsBaixaBcaCai.DisableControls;
      objBcaCai.cdsBaixaBcaCai.IndexFieldNames := '';
      objBcaCai.strDocImp := '';
      objBcaCai.strIteImp := '';
      stlSeqGer := TStringList.Create;

      objBcaCai.cdsBaixaBcaCai.First;
      While Not objBcaCai.cdsBaixaBcaCai.Eof Do
      Begin
        If objBcaCai.cdsBaixaBcaCai.FieldByName('MARDES').AsString = 'M' Then
        Begin
          objBcaCai.strEmpBai := objBcaCai.cdsBaixaBcaCai.FieldByName('CODEMP').AsString;
          objBcaCai.strCodVen := objBcaCai.cdsBaixaBcaCai.FieldByName('CODVEN').AsString;
          objBcaCai.strNumDoc := objBcaCai.cdsBaixaBcaCai.FieldByName('NRODOC').AsString;
          objBcaCai.strEspDoc := objBcaCai.cdsBaixaBcaCai.FieldByName('ESPDOC').AsString;
          objBcaCai.strCodIte := objBcaCai.cdsBaixaBcaCai.FieldByName('CODITE').AsString;
          objBcaCai.strNomTab := objBcaCai.cdsBaixaBcaCai.FieldByName('NOMTAB').AsString;
          objBcaCai.strSeqGer := objBcaCai.cdsBaixaBcaCai.FieldByName('SEQGER').AsString;
          objBcaCai.strDocImp := objBcaCai.strDocImp + QuotedStr(objBcaCai.cdsBaixaBcaCai.fieldbyname('NRODOC').AsString) + ',';
          objBcaCai.strIteImp := objBcaCai.strIteImp + QuotedStr(objBcaCai.cdsBaixaBcaCai.fieldbyname('CODITE').AsString) + ',';

          if stlSeqGer.IndexOf(objBcaCai.strSeqGer) = -1 then
          begin
            stlSeqGer.Append(objBcaCai.strSeqGer);
            objBcaCai.pGravaCodOperAuxMov;
          end;

          objBcaCai.pGravaBaixaBcaCaixa;

          Inc(intQtdBai);
        End;
        objBcaCai.cdsBaixaBcaCai.Next;
      End;

      If intQtdBai = 0 Then
      Begin
        fRollBack;
        fMensagem('AVISO','Nenhum documento marcado para baixa. Marque ao menos um documento e confirme novamente.', ['&O K']);
      End
      Else
      Begin
        fCommit;
        fMensagem('AVISO','Baixa efetuada com sucesso! Aguarde a impressão do recibo.', ['&O K']);
      End;
    except
      on E: Exception do
      begin
        fRollback;
        intQtdBai := 0;
        pMensagensErro(E.Message, '[untBaixaBocaCaixa]');
      end;
    end;

  Finally
    objBcaCai.cdsBaixaBcaCai.EnableControls;
    objBcaCai.cdsBaixaBcaCai.Close;

    edtCodVendedor.Clear;
    edtNomVendedor.Clear;
    edtQtdSel.Text := '0';
    edtValorSel.Text := '0,00';
    edtComSel.Text   := '0,00';
    edtQtdGer.Text := '0';
    edtValorGer.Text := '0,00';
    edtComGer.Text   := '0,00';
    pSetFocus(edtCodVendedor);

    pCarregaConfImpr(qryCfgRel, Self.name);
    objBcaCai.strNomFrm := Self.Name;
    objBcaCai.strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
    objBcaCai.strFilImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

    If intQtdBai > 0 Then
    Begin
      objBcaCai.strDocImp := COPY(objBcaCai.strDocImp, 1, Length(objBcaCai.strDocImp) - 1);
      objBcaCai.strIteImp := COPY(objBcaCai.strIteImp, 1, Length(objBcaCai.strIteImp) - 1);

      objBcaCai.pImprimeReciboVendedor;
    End;
    FreeAndNil(stlSeqGer);
  End;
end;

end.
