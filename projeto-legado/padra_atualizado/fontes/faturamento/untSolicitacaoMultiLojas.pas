unit untSolicitacaoMultiLojas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untLiberacao, untMsgLiberacao, untCadLote, untSolicitacaoTE,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGridCitel, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, MemDS, DBAccess, Uni, untObservacao;

type
  TRecAnterior = Record
    intRecNo : Integer;
    strCodIte,
    strCodEmp,
    strNumLot: String;
    fltQtdIte: Double;
  End;

  TfrmSolicitacaoMultiLojas = class(TfrmPai)
    dbgEstoque: TcxGridCitel;
    dbgEstoqueDBTableViewCitel: TcxGridDBTableViewCitel;
    EMP_NOMEMP: TcxGridDBColumn;
    ITE_SALDOS: TcxGridDBColumn;
    ITE_SAL_ML: TcxGridDBColumn;
    ITE_SALRES: TcxGridDBColumn;
    ITE_SALREG: TcxGridDBColumn;
    ITE_SALEXT: TcxGridDBColumn;
    ITE_SALDIS: TcxGridDBColumn;
    ITE_ENTFUT: TcxGridDBColumn;
    dbgEstoqueLevel1: TcxGridLevel;
    dbgItensLoja: TcxGridCitel;
    dbgItensLojaDBTableViewCitel: TcxGridDBBandedTableViewCitel;
    CODITE: TcxGridDBBandedColumn;
    CODGRU: TcxGridDBBandedColumn;
    DESCRI: TcxGridDBBandedColumn;
    NUMLOT: TcxGridDBBandedColumn;
    SALLOC: TcxGridDBBandedColumn;
    SALOUT: TcxGridDBBandedColumn;
    TEMSLD: TcxGridDBBandedColumn;
    dbgItensLojaLevel1: TcxGridLevel;
    dtsEstoque: TDataSource;
    dtsItens: TDataSource;
    dtsUsado: TDataSource;
    pnlIteSld: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Label2: TLabel;
    chkIteSld: TCheckBox;
    btnConfirma: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkIteSldClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgItensLojaDBTableViewCitelEditKeyPress(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Char);
    procedure dbgItensLojaDBTableViewCitelCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    recAnteri: TRecAnterior;
    objCadLot: TCadLot;
    blnSaiTsl: Boolean;
    strNTrava: String;
    blnSenha: Boolean;
    strOpcTra: String;
    blnTravaSemPedirSenha: Boolean;
    qryEstoque: TUniQuery;
    objLiberacao : TLiberacao;
    qryEmpresas: TUniQuery;
    strIndices: string;
    strIndQtd: string;
    strFieldQtd: string;

    Function fVerificaLojas: Boolean;


    Function fFaltaSaldoLoja(    strCodIte,
                                 strCodEmp,
                                 strNumLot: String;
                                 fltQtdIte: Double;
                             Var fltSaldos: Double): Boolean;

    Function fGetSaldoLoja(strCodIte, strCodEmp, strNumLot: String): Double;

    procedure pCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    function fTravar(blnTemSld: Boolean): Boolean;
    function fSenhaLiberaProdutosAbastecimento: Boolean;
    function fRetCodItens(): String;
    function fRetSqlEstoque(): String;
    procedure pProcessaEstoque();
    procedure pCarregaSaldosEmpresas();
    procedure pCriaAbstEmp;
    function fTemLoteInformado: Boolean;
    function fTravaQuantidade(fltDiferenca: Double): Boolean;
    function fQuantidadeCorreta: Boolean;
    function fRetWord(Shift: TShiftState; Key: Word): integer;
    function fValidaBeforePost(DataSet: TDataSet; strQtdEmp, strLotEmp: string; intIndice: integer): Boolean;
    function fRetQtdAnt(recAnteri: TRecAnterior; DataSet: TDataSet; strLotEmp: string; blnLoteIgual: Boolean): Double;
    function fExecutaBeforePost(strQtdEmp, strLotEmp: string; intIndice: integer; DataSet: TDataSet; fltQtdAnt: Double; strLotUti: string; blnRealizaValidacao, blnSomaAndSubt, blnLoteIgual: Boolean): Boolean;
    procedure pRealizaValidacao(recAnteri: TRecAnterior; DataSet: TDataSet; blnRealizaValidacao, blnSomaAndSubt: Boolean; strLotEmp, strLotUti, strQtdEmp: string);
    procedure pSomaUtilizadoAposLibLoja(blnLiberou: Boolean; strCodEmp, strLotUti, strQtdEmp: string; intIndice: integer);
    procedure pLimpaLote(DataSet: TDataSet);
    procedure pMostraMsgLote(DataSet: TDataSet; blnTravaSemPedirSenha: Boolean; fltSaldos, fltQtdUsa: Double; strLotEmp, strLotUti, strTitLab: string);
  public
    { Public declarations }
    objSoliTE: TSolicitacaoTE;

    procedure pItensLojaBeforePost(DataSet: TDataSet);
    procedure pItensLojaBeforeEdit(DataSet: TDataSet);
    procedure pItensLojaAfterInsert(DataSet: TDataSet);
    procedure pItensLojaAfterScroll(DataSet: TDataSet);
  end;


implementation

uses untFuncFat, untFuncoesSimples, untConsultas,
     untConsultaLoteEmp, untIFatReservaSaldo, untTFatReservaSaldo,
     untIFatEntregaFutura, untTFatEntregaFutura;

{$R *.dfm}

{ TfrmSolicitacaoMultiLojas }

procedure TfrmSolicitacaoMultiLojas.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if fQuantidadeCorreta then
    ModalResult := mrOk;
end;

procedure TfrmSolicitacaoMultiLojas.chkIteSldClick(Sender: TObject);
begin
  inherited;
  try
    dtsEstoque.DataSet.DisableControls;

    If TCheckBox(Sender).Checked Then
    Begin
      dtsItens.DataSet.Filter := 'TEMSLD = FALSE';
      dtsItens.DataSet.Filtered := True;
    End
    Else
    Begin
      dtsItens.DataSet.Filter := '';
      dtsItens.DataSet.Filtered := False;
    End;
  finally
    dtsEstoque.DataSet.EnableControls;
  end;
end;

procedure TfrmSolicitacaoMultiLojas.dbgItensLojaDBTableViewCitelCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (blnSaiTsl) Then
  Begin
    if not dbgItensLojaDBTableViewCitel.DataController.DataSource.DataSet.Active then
      Exit;

    if dbgItensLojaDBTableViewCitel.DataController.Values[AViewInfo.GridRecord.RecordIndex, TEMSLD.Index] then
      ACanvas.Font.Color := clBlue
    else
      ACanvas.Font.Color := clRed;

  End;
end;

procedure TfrmSolicitacaoMultiLojas.dbgItensLojaDBTableViewCitelEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
var
  strKey: string;
begin
  If fCheckParent(ActiveControl, dbgItensLoja) Then 
  Begin
    inherited;
    If fEntraCons(Key) Then
    Begin
      If (Pos('_'+IntToStr(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex)+'_', strIndices) > 0) Then
      Begin
        dbgItensLojaDBTableViewCitel.GetColumnByFieldName(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name).Focused := True;
        dbgItensLojaDBTableViewCitel.Controller.EditingController.ShowEdit();

        pCodEmpresaKeyPress(Sender, Key);

        dbgItensLojaDBTableViewCitel.GetColumnByFieldName(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name).Focused := True;
        dbgItensLojaDBTableViewCitel.Controller.EditingController.ShowEdit();
      End;
    End
    Else
    Begin
      If (Pos('_'+IntToStr(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex)+'_', strIndices) > 0) And
         (fEmptyStr(dbgItensLojaDBTableViewCitel.DataController.DataSource.DataSet.FieldByName('NUMLOT').AsString)) Then
        Key := #0
      Else
      Begin
        strKey := Key;
        strKey := AnsiUpperCase(strKey);
        Key    := strKey[1];
      End;
    End;
  End;
end;

function TfrmSolicitacaoMultiLojas.fExecutaBeforePost(strQtdEmp,
  strLotEmp: string; intIndice: integer; DataSet: TDataSet; fltQtdAnt: Double;
  strLotUti: string; blnRealizaValidacao, blnSomaAndSubt,
  blnLoteIgual: Boolean): Boolean;
var
  fltSaldos: Double;
begin
  Result := True;

  If blnRealizaValidacao And
    fFaltaSaldoLoja(DataSet.FieldByName('CODITE').AsString,
                    Copy(strLotEmp,4,3),
                    strLotUti,
                    DataSet.FieldByName(strQtdEmp).AsFloat,
                    fltSaldos) Then
  Begin
    if (Pos(strOpcTra, 'T_A_') > 0) then
    begin
      If(blnTravaSemPedirSenha) Then
      Begin
        pMostraMsgLote(DataSet, blnTravaSemPedirSenha, fltSaldos, DataSet.FieldByName(strQtdEmp).AsFloat, strLotEmp, strLotUti, objCadLot.strTitLab);

        pSetFocus(dbgItensLoja);
        dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := intIndice;

        Result := False;
        Exit;
      End
      Else If (Not blnTravaSemPedirSenha) Then
      Begin
        pRealizaValidacao(recAnteri, DataSet, blnTravaSemPedirSenha, blnSomaAndSubt, strLotEmp, strLotUti, strQtdEmp);
      End;
    end;
  End
  Else
  Begin
    pRealizaValidacao(recAnteri, DataSet, blnTravaSemPedirSenha, blnSomaAndSubt, strLotEmp, strLotUti, strQtdEmp);
  End;
end;

function TfrmSolicitacaoMultiLojas.fFaltaSaldoLoja(strCodIte, strCodEmp,
  strNumLot: String; fltQtdIte: Double; var fltSaldos: Double): Boolean;
begin
  fltSaldos := fGetSaldoLoja(strCodIte, strCodEmp, strNumLot);
  Result := (fltSaldos  < fltQtdIte);
end;

function TfrmSolicitacaoMultiLojas.fGetSaldoLoja(strCodIte, strCodEmp,
  strNumLot: String): Double;
  Var
    qryGen: TUniQuery;
Begin

  Try
    If Not fEmptyStr(strNumLot) Then
    Begin
      Result := objCadLot.fSaldoLote(strCodIte, strCodEmp, strNumLot);
    End
    Else
    Begin
      qryGen := fCriaQuery;

      qryGen.SQL.Clear;
      qryGen.SQL.Add('SELECT ITE_SALDOS FROM ITEGER');
      qryGen.SQL.Add('WHERE ITE_CODITE = :CODITE AND');
      qryGen.SQL.Add('      ITE_CODEMP = :CODEMP');

      qryGen.ParamByName('CODITE').AsString := strCodIte;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;

      qryGen.Open;

      If qryGen.IsEmpty Then
        Result := 0
      Else
        Result := qryGen.FieldByName('ITE_SALDOS').AsFloat;

      FreeAndNil(qryGen);
    End;

    If fUsaQtdPendenteEntregaFutura Then
      Result := Result + TEntregaFutura.New(
                           TParamEF.New()
                             .CodIte(strCodIte)
                             .CodEmp(strCodEmp)
                             .Lote(strNumLot)
                             .Faturamento(True)
                           ).Total();

    Result := Result - TSaldoReservado.New(
                         TReservaParametros.New()
                           .EmpresaItem(strCodEmp)
                           .CodigoItem(strCodIte)
                           .CodEmpresa(strCodEmp)
                           .NumeroLote(strNumLot)
                         ).fGetQuantidade();
  Except

    On E: Exception Do
    Begin
      Result := 0;
			pMensagensErro(E.Message,'[TfrmSolicitacaoLojas.fGetSaldoLoja]');
    End;

  End;

End;

procedure TfrmSolicitacaoMultiLojas.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgItensLoja);
end;

procedure TfrmSolicitacaoMultiLojas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If ModalResult = mrOk Then
  Begin
    If Not fSenhaLiberaProdutosAbastecimento Then
      Action := caNone;
  End;
end;

procedure TfrmSolicitacaoMultiLojas.FormCreate(Sender: TObject);
begin
  inherited;
  blnSaiTsl := (fCfgSis('SAITSL') = '2');

  recAnteri.intRecNo  := -1;
  recAnteri.strCodIte := '';
  recAnteri.strCodEmp := '';
  recAnteri.strNumLot := '';
  recAnteri.fltQtdIte := 0;

  objCadLot := TCadLot.Create(Self);
  objLiberacao := TLiberacao.Create;

  NUMLOT.Caption := objCadLot.strTitLab + ' do Produto';
  pnlIteSld.Visible := blnSaiTsl;

  qryEstoque := fCriaQuery(Self);
  dtsEstoque.DataSet := qryEstoque;

  dbgEstoqueDBTableViewCitel.Columns[5].Visible := fCfgSis('ESTEXT', varBoolean);
end;

procedure TfrmSolicitacaoMultiLojas.FormDestroy(Sender: TObject);
begin
  If Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;

end;

procedure TfrmSolicitacaoMultiLojas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: If dtsItens.DataSet.State = dsEdit Then
                 dtsItens.DataSet.Cancel
               Else
                 Close;
    VK_RETURN: Begin
                 If Not (dtsItens.DataSet.State = dsEdit) Then
                   dtsItens.DataSet.Edit;

                 dtsItens.DataSet.Post;
               End;
    VK_F10   : btnConfirma.Click;
    VK_Delete: begin
                  Key := fRetWord(Shift, Key);
               end;
  End;
end;

procedure TfrmSolicitacaoMultiLojas.FormShow(Sender: TObject);
var
  strIndex: string;
begin
  inherited;

  strNTrava := 'NNNNNNNNNNNNNNNNNNNN';
  blnSenha  := fCfgSisL('SOLSTE', varBoolean);
  strOpcTra := fCfgSisL('TRASTE', VarString );

  qryEmpresas := fCriaQuery(Self);
  qryEmpresas.Close;
  qryEmpresas.SQL.Clear;
  qryEmpresas.SQL.Add('SELECT DISTINCT E.EMP_CODEMP ');
  qryEmpresas.SQL.Add('FROM CADEMP E');
  qryEmpresas.SQL.Add('INNER JOIN ITEGER G');
  qryEmpresas.SQL.Add('ON(E.EMP_CODEMP = G.ITE_CODEMP)');
  qryEmpresas.SQL.Add('INNER JOIN CADITE C');
  qryEmpresas.SQL.Add('ON(C.ITE_CODITE = G.ITE_CODITE)');
  qryEmpresas.SQL.Add('WHERE LOCATE(EMP_CODEMP, '+QuotedStr(strEmpAcessoUsuarioLogado)+') > 0');
  qryEmpresas.SQL.Add('AND G.ITE_CODITE IN (' + fRetCodItens() + ')');
  qryEmpresas.Open;

  pCriaAbstEmp;

  strIndex := strIndices;
  Delete(strIndex, 1, 1);
  strIndex := Copy(strIndex, 1, Pos('_', strIndex) - 1);
  dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := StrToIntDef(strIndex, 0) - 1;

  blnTravaSemPedirSenha := False;
  if (Not blnSenha) then
    if strOpcTra = 'T' then
      blnTravaSemPedirSenha := True;

  pCarregaSaldosEmpresas();
  pItensLojaAfterScroll(dtsItens.DataSet);
end;

function TfrmSolicitacaoMultiLojas.fQuantidadeCorreta: Boolean;
begin
  Result := True;
  dtsItens.DataSet.First;

  while not dtsItens.DataSet.Eof do
  begin
    Result := not fTravaQuantidade(dtsItens.DataSet.FieldByName('QTDITE').AsFloat - dtsItens.DataSet.FieldByName('TOTQTD').AsFloat);

    if not Result then
      Exit;

    dtsItens.DataSet.Next;
  end;
end;

function TfrmSolicitacaoMultiLojas.fRetCodItens: String;
var
  intRecNo: Integer;
begin
  Result := '';
  dtsItens.DataSet.DisableControls;
  intRecNo := dtsItens.DataSet.RecNo;
  dtsItens.DataSet.First;
  Try
    While Not dtsItens.DataSet.Eof Do
    Begin
      If Not fEmptyStr(Result) then
        Result := Result + ',';

      Result := Result + QuotedStr(dtsItens.DataSet.FieldByName('CODITE').AsString);

      dtsItens.DataSet.Next;
    End;
  Finally
    dtsItens.DataSet.RecNo := intRecNo;
    dtsItens.DataSet.EnableControls;
  End;

end;

function TfrmSolicitacaoMultiLojas.fRetQtdAnt(recAnteri: TRecAnterior;
  DataSet: TDataSet; strLotEmp: string; blnLoteIgual: Boolean): Double;
begin
  Result := 0;
  if (recAnteri.intRecNo = DataSet.RecNo) then
    if (recAnteri.strCodEmp = Copy(strLotEmp,4,3)) then
      if blnLoteIgual then
        Result := recAnteri.fltQtdIte;
end;

function TfrmSolicitacaoMultiLojas.fRetSqlEstoque: String;
begin
  Result := '';
  Result := Result + 'SELECT                           ';
  Result := Result + '  E.EMP_CODEMP,                  ';
  Result := Result + '  G.ITE_CODITE,                  ';
  Result := Result + '  C.ITE_CNV_ML,                  ';
  Result := Result + '  CONCAT(                        ';
  Result := Result + '    E.EMP_CODEMP,                ';
  Result := Result + '    "-",                         ';
  Result := Result + '    E.EMP_NOMFAN                 ';
  Result := Result + '  ) AS EMP_NOMEMP,               ';
  Result := Result + '  G.ITE_SALDOS,                  ';
  Result := Result + '  G.ITE_SAL_ML,                  ';
  Result := Result + '  0.00 AS ITE_SALRES,            ';
  Result := Result + '  0.00 AS ITE_SALREG,            ';
  Result := Result + '  0.00 AS ITE_SALEXT,            ';
  Result := Result + '  0.00 AS ITE_SALDIS,            ';
  Result := Result + '  0.00 AS ITE_ENTFUT             ';
  Result := Result + 'FROM                             ';
  Result := Result + '  ITEGER G                       ';
  Result := Result + 'INNER JOIN CADITE C              ';
  Result := Result + '  ON C.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + 'INNER JOIN CADEMP E              ';
  Result := Result + '  ON E.EMP_CODEMP = G.ITE_CODEMP ';
  Result := Result + 'WHERE G.ITE_CODITE IN (' + fRetCodItens() + ')';
  Result := Result + ' AND LOCATE(E.EMP_CODEMP, '+QuotedStr(strEmpAcessoUsuarioLogado)+') > 0 ';
end;

function TfrmSolicitacaoMultiLojas.fRetWord(Shift: TShiftState;
  Key: Word): integer;
begin
  Result := Key;

  If (Shift= [ssCtrl]) Then
    Exit(0);
  If (Shift = [ssAlt]) Then
    Exit(0);
  If (Shift = [ssAlt, ssShift]) Then
    Exit(0);
  If (Shift = [ssAlt, ssCtrl]) Then
    Exit(0);
  If (Shift= [ssShift,ssCtrl]) Then
    Exit(0);
  If (Shift= [ssAlt,ssShift,ssCtrl]) Then
    Exit(0);
end;

function TfrmSolicitacaoMultiLojas.fSenhaLiberaProdutosAbastecimento: Boolean;
  Var
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    intRecNo: Integer;
Begin
  If Not fCfgSis('LIBABS', varBoolean) Then
  Begin
    Result := True;
    Exit
  End;


  intRecNo := dtsItens.DataSet.RecNo;
  dtsItens.DataSet.DisableControls;
  dtsItens.DataSet.First;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Itens que foram solicitados as lojas para realizar o abastecimento');
  objLiberacao.objMsgLibera.pAddQuebra;

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'Código'                           , fTamCodIte  , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Grupo'                            , 5  , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'Descrição'                        , 33 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , objCadLot.strTitLab + ' do Produto', 30 , alCentro   , teAutcom);
  objTabela.lstLinhas.Add(objLinha);


  While Not dtsItens.DataSet.Eof Do
  Begin
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('Código'                           , dtsItens.DataSet.FieldByName('CODITE').AsString                             , fTamCodIte  , alEsquerda );
    objLinha.pAddColuna('Grupo'                            , dtsItens.DataSet.FieldByName('CODGRU').AsString                             , 5  , alEsquerda );
    objLinha.pAddColuna('Descrição'                        , dtsItens.DataSet.FieldByName('DESCRI').AsString                             , 33 , alEsquerda );
    objLinha.pAddColuna(objCadLot.strTitLab + ' do Produto', dtsItens.DataSet.FieldByName('NUMLOT').AsString                             , 30 , alCentro   );
    objTabela.lstLinhas.Add(objLinha);

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('', '---------------------------------------------------------------------',  67  , alCentro);
    objTabela.lstLinhas.Add(objLinha);

    qryEmpresas.First;
    while not qryEmpresas.Eof do
    begin
      if dtsItens.DataSet.FieldByName('QTD'+qryEmpresas.FieldByName('EMP_CODEMP').AsString).AsFloat > 0 then
      begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna(''  , 'Quantidade para empresa '+qryEmpresas.FieldByName('EMP_CODEMP').AsString+'' , 36 , alEsquerda  , teAutcom);
        objLinha.pAddColuna(''  , objCadLot.strTitLab + ' Transf. Emp. '+qryEmpresas.FieldByName('EMP_CODEMP').AsString+''   , 29 , alDireita  , teAutcom);
        objTabela.lstLinhas.Add(objLinha);
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.pAddColuna('Quantidade para empresa '+qryEmpresas.FieldByName('EMP_CODEMP').AsString+'', FloatToStrF(dtsItens.DataSet.FieldByName('QTD'+qryEmpresas.FieldByName('EMP_CODEMP').AsString).AsFloat, ffFixed, 10, 2) , 36 , alEsquerda  );
        objLinha.pAddColuna(objCadLot.strTitLab + ' Transf. Emp. '+qryEmpresas.FieldByName('EMP_CODEMP').AsString+''   , dtsItens.DataSet.FieldByName('LOT' + qryEmpresas.FieldByName('EMP_CODEMP').AsString).AsString                             , 29 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);
      end;
      qryEmpresas.Next;
    end;

    dtsItens.DataSet.Next;
  End;

  dtsItens.DataSet.RecNo := intRecNo;
  dtsItens.DataSet.EnableControls;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := 'SENABA';
  objLiberacao.strSenLib := fCfgSis('SENABA');
  objLiberacao.strMsgSen := 'Liberação de abastecimento';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;

  Result :=  objLiberacao.fLibera;
end;

function TfrmSolicitacaoMultiLojas.fTemLoteInformado: Boolean;
begin
  Result := False;

  qryEmpresas.First;
  while not qryEmpresas.Eof do
  begin
    if not fEmptyStr(dtsItens.DataSet.FieldByName('LOT' + qryEmpresas.FieldByName('EMP_CODEMP').AsString).AsString) then
    begin
      Result := True;
      Exit;
    end;
    qryEmpresas.Next;
  end;
end;

function TfrmSolicitacaoMultiLojas.fTravaQuantidade(
  fltDiferenca: Double): Boolean;
var
  frmObservacaoLocal: TfrmObservacao;
  strMensagem: string;
begin
  Result := False;

  if fltDiferenca = 0 then
    Exit;

  pCriarFormularios(TfrmObservacao, frmObservacaoLocal);

  try
    frmObservacaoLocal.Height := 588;
    frmObservacaoLocal.Width := 918;
    frmObservacaoLocal.lblMensagem.Caption := 'Existe diferença na quantidade informada';
    frmObservacaoLocal.lblMensagem.Alignment := taCenter;
    frmObservacaoLocal.memObs.CharCase := ecNormal;
    frmObservacaoLocal.memObs.Clear;
    frmObservacaoLocal.memObs.Lines.Add('-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');

    strMensagem := 'Atenção! A soma das quantidades informadas ultrapassou a quantidade do documento. Ajuste as quantidades para continuar.                                                                  ';

    if fltDiferenca > 0 then
      strMensagem := 'Atenção! A soma das quantidades informadas está inferior à quantidade do documento. Ajuste as quantidades para continuar.                                                                ';

    frmObservacaoLocal.memObs.Lines.Add(strMensagem);

    frmObservacaoLocal.memObs.Lines.Add('-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
    frmObservacaoLocal.memObs.Lines.Add('Quantidade do documento:  '+FloatToStrf(dtsItens.DataSet.FieldByName('QTDITE').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger))+'');
    frmObservacaoLocal.memObs.Lines.Add('Quantidade informada...:  '+FloatToStrf(dtsItens.DataSet.FieldByName('TOTQTD').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger))+'');
    frmObservacaoLocal.memObs.Lines.Add('');

    qryEmpresas.First;
    while not qryEmpresas.Eof do
    begin
      if dtsItens.DataSet.FieldByName('QTD' + qryEmpresas.FieldByName('EMP_CODEMP').AsString).AsFloat > 0 then
      begin
        frmObservacaoLocal.memObs.Lines.Add('Quantidade empresa '+qryEmpresas.FieldByName('EMP_CODEMP').AsString+'.:  '+FloatToStrf(dtsItens.DataSet.FieldByName('QTD' + qryEmpresas.FieldByName('EMP_CODEMP').AsString).AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger))+'');
      end;
      qryEmpresas.Next;
    end;

    frmObservacaoLocal.memObs.Lines.Add('-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
    Result := True;

    frmObservacaoLocal.ShowModal;
  finally
    pFreeAndNil(frmObservacaoLocal);
  end;
end;

function TfrmSolicitacaoMultiLojas.fTravar(blnTemSld: Boolean): Boolean;
begin
  Result := Not blnTemSld;
end;

function TfrmSolicitacaoMultiLojas.fValidaBeforePost(DataSet: TDataSet;
  strQtdEmp, strLotEmp: string; intIndice: integer): Boolean;
Var
  fltQtdAnt: Double;
  strLotUti: String;
  blnRealizaValidacao: Boolean;
  blnSomaAndSubt: Boolean;
  blnLoteIgual: Boolean;
begin
  If (Not fEmptyStr(DataSet.FieldByName('NUMLOT').AsString)) And
          (Not fEmptyStr(DataSet.FieldByName(strLotEmp).AsString)) And
          (Not fExisteLote(DataSet.FieldByName(strLotEmp).AsString,
                           DataSet.FieldByName('CODITE').AsString,
                           Copy(strLotEmp,4,3))) Then
  Begin
    fMensagem('ATENÇÃO!', IIF(fCfgSis('CTLEST') = '1', 'Lote', 'Armazém') + ' não cadastrado.', ['&Ok']);
    pSetFocus(dbgItensLoja);
    dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := intIndice;

    Result := False;
    Exit;
  End

  Else If (Not fEmptyStr(DataSet.FieldByName('NUMLOT').AsString)) And
           fEmptyStr(DataSet.FieldByName(strLotEmp).AsString)      And
           (DataSet.FieldByName('INFLOT').AsString = 'S')         And
          (fTravar(DataSet.FieldByName('TEMSLD').AsBoolean))      Then
  Begin
    fMensagem('ATENÇÃO!', Format('Informe o ' + IIF(fCfgSis('CTLEST') = '1', 'Lote', 'Armazém') + ' que fornecerá o item [%s].', [DataSet.FieldByName('CODITE').AsString]), ['&OK']);
    pSetFocus(dbgItensLoja);
    dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := intIndice;

    Result := False;
    Exit;
  End

  Else If (Not fPermiteTransfEntreEmps(Copy(strLotEmp,4,3), VS_strCodEmp)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A empresa '+Copy(strLotEmp,4,3)+' não permite transferência de estoque.'+#13+
                          'Verificar nas configurações de "Transferência de Estoque" no "Cadastro de Empresa"', ['&Ok']);
    pSetFocus(dbgItensLoja);
    dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := intIndice;

    Result := False;
    Exit;
  End
  Else
  Begin

    blnLoteIgual := IIF(fEmptyStr(DataSet.FieldByName('NUMLOT').AsString), True,
                    IIF((recAnteri.strNumLot = DataSet.FieldByName(strLotEmp).AsString), True, False));

    fltQtdAnt := fRetQtdAnt(recAnteri, DataSet, strLotEmp, blnLoteIgual);

    strLotUti := IIF(Not fEmptyStr(DataSet.FieldByName(strLotEmp).AsString), DataSet.FieldByName(strLotEmp).AsString, '');

    blnRealizaValidacao := (Not fEmptyStr(Copy(strLotEmp,4,3))) And
                           (IIF(fEmptyStr(DataSet.FieldByName('NUMLOT').AsString), True, Not fEmptyStr(strLotUti)));

    blnSomaAndSubt := IIF(fEmptyStr(DataSet.FieldByName('NUMLOT').AsString), True,
                      IIF(Not fEmptyStr(DataSet.FieldByName(strLotEmp).AsString), True, False));

    Result := fExecutaBeforePost(strQtdEmp, strLotEmp, intIndice, DataSet, fltQtdAnt, strLotUti, blnRealizaValidacao, blnSomaAndSubt, blnLoteIgual);

  End;
end;

function TfrmSolicitacaoMultiLojas.fVerificaLojas: Boolean;
Var
  fltSaldos: Double;
  strLotUti  : String;
  objTabela  : TRegistroMsgLiberaTabela;
  objLinha   : TLinhaMsgLibera;
  intAgrupador : Integer;
  intIndice: integer;
  strLotEmp: string;
  strQtdEmp: string;
  strCodEmp: string;

Begin
  Result := TRUE;

  intIndice := dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex;
  strLotEmp := 'LOT' + Copy(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name, 4,3);
  strQtdEmp := 'QTD' + Copy(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name, 4,3);
  strCodEmp := Copy(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name, 4,3);

  If (Not blnTravaSemPedirSenha) Then
  Begin

    objLiberacao.Clear;
    objTabela := TRegistroMsgLiberaTabela.Create;
    intAgrupador := -1;
    If fTravar(dtsItens.DataSet.FieldByName('TEMSLD').AsBoolean) Then
    Begin

      strLotUti := IIF(Not fEmptyStr(dtsItens.DataSet.FieldByName(strLotEmp).AsString), dtsItens.DataSet.FieldByName(strLotEmp).AsString, '');

      If fFaltaSaldoLoja(dtsItens.DataSet.FieldByName('CODITE').AsString,
                         strCodEmp,
                         strLotUti,
                         dtsItens.DataSet.FieldByName(strQtdEmp).AsFloat,
                         fltSaldos) Then
      Begin
        If objTabela.isEmpty Then
        Begin
          objLiberacao.objMsgLibera.pAddTexto('ITENS SEM SALDO NA SOLICITAÇÃO ENTRE LOJAS');
          objLiberacao.objMsgLibera.pAddTextoCaption('EMP. SOLICITANTE', Copy(VS_strCodEmp+' - '+fRetNomeEmpresaSelec(VS_strCodEmp),1,50));
          objLiberacao.objMsgLibera.pAddQuebra;

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'CÓD.'                 , fTamCodIte  , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'DESCRIÇÃO'            , 35 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'QTDE. À LIBE.'        , 15 , alDireita  , teAutcom);
          objLinha.pAddColuna(''  , 'EMPRESA ABASTECEDORA' , 25 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'SALDO EMP. ABAST.'    , 17 , alDireita  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

        End;

        inc(intAgrupador);

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.intAgrupador := intAgrupador;
        objLinha.pAddColuna('CÓD.'                 , dtsItens.DataSet.FieldByName('CODITE').AsString                                                            , fTamCodIte  , alEsquerda );
        objLinha.pAddColuna('DESCRIÇÃO'            , dtsItens.DataSet.FieldByName('DESCRI').AsString                                                            , 35 , alEsquerda );
        objLinha.pAddColuna('QTDE. À LIBE.'        , FloatToStrF(dtsItens.DataSet.FieldByName(strQtdEmp).AsFloat, ffFixed, 12, 2)                                , 15 , alDireita  );
        objLinha.pAddColuna('EMPRESA ABASTECEDORA' , strCodEmp+' - '+fRetNomeEmpresaSelec(strCodEmp) , 25 , alEsquerda );
        objLinha.pAddColuna('SALDO EMP. ABAST.'    , FloatToStrF(fltSaldos, ffFixed, 12, 2)                                                    , 17 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);


        If Not fEmptyStr(strLotUti) Then
        begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.intAgrupador := intAgrupador;
          objLinha.pAddColuna(objCadLot.strTitLab, strLotUti,  105  , alCentro);
          objTabela.lstLinhas.Add(objLinha);
        end;

        dtsItens.DataSet.FieldByName('TRAVOU').AsBoolean:=True;
      End;
    End;

    If objTabela.isEmpty Then
    Begin
      FreeAndNil(objTabela);
      Exit;
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'LBSDVN';
    objLiberacao.blnTraTel := (strOpcTra = 'T');
    objLiberacao.strSenLib := fCfgSisL('SESDVN');
    objLiberacao.strMsgSen := 'Liberação de produto sem saldo - Venda Normal';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;

    pSomaUtilizadoAposLibLoja(Result, strCodEmp, strLotUti, strQtdEmp, intIndice);

  End;

End;

procedure TfrmSolicitacaoMultiLojas.pCarregaSaldosEmpresas;
begin
  qryEstoque.SQL.Text := fRetSqlEstoque();
  qryEstoque.Open;

  (qryEstoque.FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat := '#,##0.00';
  (qryEstoque.FieldByName('ITE_SAL_ML') As TFloatField).DisplayFormat := '#,###0.000';
  (qryEstoque.FieldByName('ITE_SALRES') As TFloatField).DisplayFormat := '#,##0.00';
  (qryEstoque.FieldByName('ITE_SALREG') As TFloatField).DisplayFormat := '#,##0.00';
  (qryEstoque.FieldByName('ITE_SALEXT') As TFloatField).DisplayFormat := '#,##0.00';
  (qryEstoque.FieldByName('ITE_SALDIS') As TFloatField).DisplayFormat := '#,##0.00';
  (qryEstoque.FieldByName('ITE_ENTFUT') As TFloatField).DisplayFormat := '#,##0.00';

  pSetaClient(qryEstoque);
  pProcessaEstoque();
end;

procedure TfrmSolicitacaoMultiLojas.pCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  Try
    Key := #0;

    frmConsultaLoteEmp := TfrmConsultaLoteEmp.Create(Nil);
    frmConsultaLoteEmp.strCodIte := dtsItens.DataSet.FieldByName('CODITE').AsString;
    frmConsultaLoteEmp.strEmpCons := Copy(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name,4,3);
    frmConsultaLoteEmp.cxgConsultaView.Bands[1].Visible := Not fEmptyStr(dtsItens.DataSet.FieldByName('NUMLOT').AsString);
    frmConsultaLoteEmp.ShowModal;


    If (Not fEmptyStr(frmConsultaLoteEmp.strLotAba)) Then
    Begin
      If Not (dtsItens.DataSet.State = dsEdit) Then
        dtsItens.DataSet.Edit;

      If Not fEmptyStr(frmConsultaLoteEmp.strLotAba) Then
        dtsItens.DataSet.FieldByName(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name).AsString := frmConsultaLoteEmp.strLotAba;

      dtsItens.DataSet.Post;
    End;
  Except
    On E: Exception Do
	    pMensagensErro(E.Message,'[TfrmSolicitacaoLojas.pCodEmpresaKeyPress]');
  End;

  pFreeAndNil(frmConsultaLoteEmp);
end;

procedure TfrmSolicitacaoMultiLojas.pCriaAbstEmp;
var
  BandaEmp: TcxGridBand;
  cxItem: TcxCustomGridTableItem;
begin
  strIndices := '_';
  strFieldQtd := '_';
  strIndQtd := '_';

  qryEmpresas.First;
  while not qryEmpresas.Eof do
  begin
    BandaEmp := dbgItensLojaDBTableViewCitel.Bands.Add;
    BandaEmp.Caption := qryEmpresas.FieldByName('EMP_CODEMP').AsString;

    cxItem := dbgItensLojaDBTableViewCitel.DataController.CreateItemByField(dtsItens.DataSet.FieldByName('QTD'+qryEmpresas.FieldByName('EMP_CODEMP').AsString));
    TcxGridDBColumn(cxItem).HeaderAlignmentHorz := taCenter;
    cxItem.Caption := 'Qtd';
    cxItem.Name := 'QTD' + qryEmpresas.FieldByName('EMP_CODEMP').AsString;
    TcxGridDBBandedColumn(cxItem).Position.BandIndex := BandaEmp.Index;
    strFieldQtd := strFieldQtd + cxItem.Name + '_';
    strIndQtd := strIndQtd + IntToStr(cxItem.Index - 1) + '_';

    cxItem := dbgItensLojaDBTableViewCitel.DataController.CreateItemByField(dtsItens.DataSet.FieldByName('LOT'+qryEmpresas.FieldByName('EMP_CODEMP').AsString));
    TcxGridDBColumn(cxItem).HeaderAlignmentHorz := taCenter;
    cxItem.Caption := 'Lote Abast.';
    cxItem.Name := 'LOT' + qryEmpresas.FieldByName('EMP_CODEMP').AsString;
    TcxGridDBBandedColumn(cxItem).Position.BandIndex := BandaEmp.Index;
    strIndices := strIndices + IntToStr(cxItem.Index - 1) + '_';

    qryEmpresas.Next;
  end;
end;
procedure TfrmSolicitacaoMultiLojas.pItensLojaAfterInsert(DataSet: TDataSet);
begin
  DataSet.Cancel;
end;

procedure TfrmSolicitacaoMultiLojas.pItensLojaAfterScroll(DataSet: TDataSet);
begin
  qryEstoque.Filtered := False;
  qryEstoque.Filter := 'ITE_CODITE = ' + QuotedStr(DataSet.FieldByName('CODITE').AsString);
  qryEstoque.Filtered := True;

  If qryEstoque.Active Then
  Begin
    If qryEstoque.FieldByName('ITE_CNV_ML').AsFloat <= 0 Then
    Begin
      dbgEstoqueDBTableViewCitel.Columns[2].Visible := False;
      dbgEstoqueDBTableViewCitel.Columns[1].Width := 90;
      dbgEstoqueDBTableViewCitel.Columns[5].Width := 120;
      dbgEstoqueDBTableViewCitel.Columns[6].Width := 120;
    End
    Else
    Begin
      dbgEstoqueDBTableViewCitel.Columns[2].Visible := True;
      dbgEstoqueDBTableViewCitel.Columns[1].Width := 60;
      dbgEstoqueDBTableViewCitel.Columns[5].Width := 90;
      dbgEstoqueDBTableViewCitel.Columns[6].Width := 90;
    End;
  End;
end;

procedure TfrmSolicitacaoMultiLojas.pItensLojaBeforeEdit(DataSet: TDataSet);
var
  strQtdEmp: string;
  strLotEmp: string;
begin
  strLotEmp := 'LOT' + Copy(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name, 4,3);
  strQtdEmp := 'QTD' + Copy(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name, 4,3);

  recAnteri.intRecNo  := DataSet.RecNo;
  recAnteri.strCodIte := DataSet.FieldByName('CODITE').AsString;
  recAnteri.strCodEmp := Copy(strLotEmp,4,3);
  recAnteri.strNumLot := DataSet.FieldByName(strLotEmp).AsString;
  recAnteri.fltQtdIte := DataSet.FieldByName(strQtdEmp).AsFloat;

end;

procedure TfrmSolicitacaoMultiLojas.pItensLojaBeforePost(DataSet: TDataSet);
Var
  strQtdEmp: string;
  strLotEmp: string;
  intIndice: integer;
begin
  inherited;

  if not fVerificaLojas then
  begin
    While DataSet.ControlsDisabled Do
      DataSet.EnableControls;
    DataSet.FieldByName('LOT' + Copy(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name, 4,3)).Clear;
    DataSet.FieldByName('QTD' + Copy(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name, 4,3)).Clear;
    Exit;
  end;

  intIndice := dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex;
  strLotEmp := 'LOT' + Copy(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name, 4,3);
  strQtdEmp := 'QTD' + Copy(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name, 4,3);

  pLimpaLote(DataSet);

  if not fValidaBeforePost(DataSet, strQtdEmp, strLotEmp, intIndice) then
  begin
    While DataSet.ControlsDisabled Do
      DataSet.EnableControls;

    DataSet.FieldByName('LOT' + Copy(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name, 4,3)).Clear;
    DataSet.FieldByName('QTD' + Copy(dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItem.Name, 4,3)).Clear;
    Exit;
  end;

  DataSet.FieldByName('INFLOT').AsString := 'S';

  if DataSet.State = dsEdit then
  begin
    DataSet.FieldByName('TOTQTD').AsFloat := 0;
    qryEmpresas.First;
    while not qryEmpresas.Eof do
    begin
      DataSet.FieldByName('TOTQTD').AsFloat := DataSet.FieldByName('TOTQTD').AsFloat + DataSet.FieldByName('QTD'+qryEmpresas.FieldByName('EMP_CODEMP').AsString).AsFloat;
      qryEmpresas.Next;
    end;
  end;

end;

procedure TfrmSolicitacaoMultiLojas.pLimpaLote(DataSet: TDataSet);
begin
  if (not fTemLoteInformado) then
    DataSet.FieldByName('INFLOT').AsString := 'N';

  if (DataSet.State = dsEdit) then
    DataSet.FieldByName('INFLOT').AsString := 'N';

  if fEmptyStr(DataSet.FieldByName('NUMLOT').AsString) then
  begin
    qryEmpresas.First;
    while not qryEmpresas.Eof do
    begin
      DataSet.FieldByName('LOT' + qryEmpresas.FieldByName('EMP_CODEMP').AsString).Clear;
      qryEmpresas.Next;
    end;
  end;
end;

procedure TfrmSolicitacaoMultiLojas.pMostraMsgLote(DataSet: TDataSet;
  blnTravaSemPedirSenha: Boolean; fltSaldos, fltQtdUsa: Double; strLotEmp,
  strLotUti, strTitLab: string);
var
  strMensag: String;
begin
  strMensag := 'Saldo de estoque do item ' +
               DataSet.FieldByName('CODITE').AsString + '-' + DataSet.FieldByName('DESCRI').AsString + ', na Loja ' +
               Copy(strLotEmp,4,3) + ' = ' + FloatToStrF(fltSaldos, ffFixed, 12, 2);

  If Not fEmptyStr(strLotUti) Then
    strMensag := strMensag + #13#10 + strTitLab + ': ' + strLotUti;

  If fltQtdUsa > 0 Then
    strMensag := strMensag + #13#10 + 'Quantidade informada: ' + FloatToStrF(fltQtdUsa, ffFixed, 12, 2);

  If blnTravaSemPedirSenha Then
    fMensagem('', strMensag, ['&Ok']);
end;

procedure TfrmSolicitacaoMultiLojas.pProcessaEstoque;
Var
  fltCNV_ML: Double;
begin
  qryEstoque.Filtered := False;
  Try
    qryEstoque.First;
    While Not qryEstoque.Eof Do
    Begin
      qryEstoque.Edit;
      fltCNV_ML := IIF(qryEstoque.FieldByName('ITE_CNV_ML').AsFloat <= 0, 1, qryEstoque.FieldByName('ITE_CNV_ML').AsFloat);

      qryEstoque.FieldByName('ITE_SALRES').AsFloat := TSaldoReservado.New(
                                                       TReservaParametros.New()
                                                         .EmpresaItem(qryEstoque.FieldByName('EMP_CODEMP').AsString)
                                                         .CodigoItem(qryEstoque.FieldByName('ITE_CODITE').AsString)
                                                         .CodEmpresa(qryEstoque.FieldByName('EMP_CODEMP').AsString)
                                                         .TipoReserva(trsPedidoVenda)
                                                         .ConverterML(True)
                                                       ).fGetQuantidade();

      qryEstoque.FieldByName('ITE_SALREG').AsFloat := TSaldoReservado.New(
                                                       TReservaParametros.New()
                                                         .EmpresaItem(qryEstoque.FieldByName('EMP_CODEMP').AsString)
                                                         .CodigoItem(qryEstoque.FieldByName('ITE_CODITE').AsString)
                                                         .CodEmpresa(qryEstoque.FieldByName('EMP_CODEMP').AsString)
                                                         .TipoReserva(trsGarantia)
                                                         .ConverterML(True)
                                                       ).fGetQuantidade();

      qryEstoque.FieldByName('ITE_SALEXT').AsFloat := TSaldoReservado.New(
                                                       TReservaParametros.New()
                                                         .EmpresaItem(qryEstoque.FieldByName('EMP_CODEMP').AsString)
                                                         .CodigoItem(qryEstoque.FieldByName('ITE_CODITE').AsString)
                                                         .CodEmpresa(qryEstoque.FieldByName('EMP_CODEMP').AsString)
                                                         .TipoReserva(trsExterno)
                                                         .ConverterML(True)
                                                       ).fGetQuantidade();

      qryEstoque.FieldByName('ITE_SALDIS').AsFloat := ((qryEstoque.FieldByName('ITE_SALDOS').AsFloat * fltCNV_ML) + qryEstoque.FieldByName('ITE_SAL_ML').AsFloat) -
                                           qryEstoque.FieldByName('ITE_SALRES').AsFloat -
                                           qryEstoque.FieldByName('ITE_SALREG').AsFloat - qryEstoque.FieldByName('ITE_SALEXT').AsFloat;

      qryEstoque.FieldByName('ITE_ENTFUT').AsFloat := TEntregaFutura.New(
                                                       TParamEF.New()
                                                         .CodIte(qryEstoque.FieldByName('ITE_CODITE').AsString)
                                                         .CodEmp(qryEstoque.FieldByName('EMP_CODEMP').AsString)
                                                         .ConverteML(True)
                                                         .TipoTE(tteTodas)
                                                       ).Total();
      qryEstoque.Post;

      qryEstoque.Next;
    End;
  Finally
    qryEstoque.Filtered := True;
  End;
end;
procedure TfrmSolicitacaoMultiLojas.pRealizaValidacao(recAnteri: TRecAnterior;
  DataSet: TDataSet; blnRealizaValidacao, blnSomaAndSubt: Boolean; strLotEmp,
  strLotUti, strQtdEmp: string);
begin
  If blnRealizaValidacao Then
  Begin
    objSoliTE.pSubtUtilizado(recAnteri.strCodIte,
                             recAnteri.strCodEmp,
                             recAnteri.strNumLot,
                             recAnteri.fltQtdIte,
                             blnSomaAndSubt);

    objSoliTE.pSomaUtilizado(DataSet.FieldByName('CODITE').AsString,
                             Copy(strLotEmp,4,3),
                             strLotUti,
                             DataSet.FieldByName(strQtdEmp).AsFloat,
                             blnSomaAndSubt);
  End;
end;

procedure TfrmSolicitacaoMultiLojas.pSomaUtilizadoAposLibLoja(
  blnLiberou: Boolean; strCodEmp, strLotUti, strQtdEmp: string;
  intIndice: integer);
begin
  If blnLiberou Then
  Begin
    If (dtsItens.DataSet.FieldByName('TRAVOU').AsBoolean) Then
    Begin
       objSoliTE.pSomaUtilizado(dtsItens.DataSet.FieldByName('CODITE').AsString,
                                strCodEmp,
                                strLotUti,
                                dtsItens.DataSet.FieldByName(strQtdEmp).AsFloat,
                                True);
    End;
  End
  Else
  Begin
    pSetFocus(dbgItensLoja);
    dbgItensLojaDBTableViewCitel.DataController.Controller.FocusedItemIndex := intIndice;
  End;
end;

end.
