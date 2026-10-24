unit untVinculaItensImportacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, Vcl.Grids, Vcl.DBGrids, EditFocus, untTypesSistema,
  Datasnap.DBClient, UniClientDataSet, DBGridCitel, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, MemDS, DBAccess, Uni,
  cxTextEdit, untEntNfeXml, untTValidaNFeCapa;

type
  TfrmVinculaItensImportacao = class(TfrmPai)
    pnlVincula: TPanel;
    dtsImportXML: TDataSource;
    Label5: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    cdsImpotXML: TUniClientDataSet;
    cdsImpotXMLCodItemFor: TStringField;
    cdsImpotXMLDescItemFor: TStringField;
    cdsImpotXMLCodItemLoja: TStringField;
    cdsImpotXMLDescItemLoja: TStringField;
    btnVincular: TBitBtnLocked;
    cdsImpotXMLcodFabItemVin: TStringField;
    cxgDados: TcxGridDBTableViewCitel;
    cxlDados: TcxGridLevel;
    cxDados: TcxGridCitel;
    cxgDadosCodItemFor: TcxGridDBColumn;
    cxgDadosDescItemFor: TcxGridDBColumn;
    cxgDadosCodItemLoja: TcxGridDBColumn;
    cxgDadoscodFabItemVin: TcxGridDBColumn;
    cxgDadosDescItemLoja: TcxGridDBColumn;
    UniQuery1: TUniQuery;
    btnVinculaCodFab: TBitBtnLocked;
    btnVincularCodItem: TBitBtnLocked;
    cdsImpotXMLNumPedComp: TStringField;
    cxgDadosNumPedComp: TcxGridDBColumn;
    cdsImpotXMLIndice: TIntegerField;
    cdsImpotXMLMarca: TStringField;
    cdsImpotXMLFornecedor: TStringField;
    cxgDadosMarca: TcxGridDBColumn;
    cxgDadosFornecedor: TcxGridDBColumn;
    cxgDadosColumn1: TcxGridDBColumn;
    cdsImpotXMLImportacaoDireta: TStringField;
    cdsImpotXMLNITEM: TStringField;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodIteExit(Sender: TObject);
    procedure btnVincularClick(Sender: TObject);
    procedure cxgDadosEditKeyPress(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Char);
    procedure cxgDadosKeyPress(Sender: TObject;
      var Key: Char);
    procedure pConsultaItem(var Key: Char);
    procedure cxgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgDadosCodItemLojaPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cdsImpotXMLBeforePost(DataSet: TDataSet);
    procedure cxgDadoscodFabItemVinPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnVinculaCodFabClick(Sender: TObject);
    procedure btnVincularCodItemClick(Sender: TObject);
    procedure cxgDadosNumPedCompPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }

    stlItensSemCodBarras : TStringList;
    FObjEntNfeXml: TNFeXml;
    procedure pVincularItensComCodigoDeFabrica;
    procedure pConsultaPedComp(var Key: Char);
    function fValidaPedComp(strCodFor, strCodIte, strNumPed: String): String;
    procedure pVincularItensComCodigoItem;
    procedure pGravaBakImp;
    procedure pAtualizaCODFAB_CADITE(strCodIte, strCodFab: String; blnAtualizaCODFOR: Boolean = False);
    procedure pAjustaCadastroItemCodBarras;
    procedure pAtualizaCODFAB_ITEFOR(strCodIte, strCodFab: String; blnAtualizaCODFOR: Boolean = False);
    procedure PreencherListaDeDivergencia;
  public
    blnVinculouItens: Boolean;
    strCodFor,
    strNomArq: String;
    { Public declarations }
    procedure setNFeXML(aValue: TNFeXml);
  end;

const
  SQL_DELETE_BAKIMP = ' DELETE FROM BAKIMP ' +
                      ' WHERE IMP_ARQUIV = :ARQUIV AND ' +
                      '     IMP_CODFOR = :CODFOR AND ' +
                      '     IMP_ITEXML = :ITEXML AND ' +
                      '     IMP_INDICE = :INDICE ';

  SQL_INSERT_BAKIMP = ' REPLACE INTO BAKIMP ' +
                      '    (IMP_ARQUIV, IMP_CODFOR, IMP_CODEMP, IMP_INDICE, IMP_ITEXML, ' +
                      '     IMP_CODITE, IMP_DESITE, IMP_CODFAB, IMP_PEDCMP) ' +
                      ' VALUES ' +
                      '     (:ARQUIV, :CODFOR, :CODEMP, :INDICE, :ITEXML, :CODITE, ' +
                      '     :DESITE, :CODFAB, :PEDCMP)';

implementation

uses
  untNotaFiscalImport, untConsultas, untFuncoesSimples,
  untGenericSelecionaRegistro, untGravando, untListaProdutosFCIDivergenteNFE;

{$R *.dfm}

procedure TfrmVinculaItensImportacao.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  if (Trim(edtCodIte.Text) <> '') and (Trim(edtDesIte.Text) <> '') then
  begin
    if cdsImpotXML.RecNo > 0 then
    begin
      cdsImpotXML.Edit;

      if (cdsImpotXMLCodItemLoja.AsString <> Trim(edtCodIte.Text)) then
        cdsImpotXMLNumPedComp.AsString := '';

      cdsImpotXMLCodItemLoja.AsString := Trim(edtCodIte.Text);
      cdsImpotXMLDescItemLoja.AsString := Trim(edtDesIte.Text);
      cdsImpotXML.Post;
      cdsImpotXML.Next;
      edtDesIte.Clear;
      edtCodIte.Clear;
      pSetFocus(edtCodIte);
    end
    else
    begin
      pMensagemOk('Selecione um registro para vincular  o item.');
    end;
  end;
end;

procedure TfrmVinculaItensImportacao.btnVincularClick(Sender: TObject);
begin
  inherited;
  blnVinculouItens := True;

    if cdsImpotXML.IsEmpty then
    begin
      blnVinculouItens := False;
      Exit;
    end
    else
    begin
      cdsImpotXML.First;
      while not cdsImpotXML.Eof do
      begin
        if Trim(cdsImpotXMLCodItemLoja.AsString) = '' then
        begin
          pMensagemOk('Existe(m) item(ns) não vinculado(s).');
          blnVinculouItens := False;
          pSetFocus(edtCodIte);
          Exit;
        end;

        If (fEmptyStr(cdsImpotXMLcodFabItemVin.AsString)) Then
          stlItensSemCodBarras.Add(fPadR(cdsImpotXMLCodItemLoja.AsString  , 11, ' ') + '|'+
                                   fPadR(cdsImpotXMLDescItemLoja.AsString , 31, ' ')+  '|'+
                                   fPadR(cdsImpotXMLCodItemFor.AsString   , 22, ' '));

        cdsImpotXML.Next;
      end;
    end;

    PreencherListaDeDivergencia;

    if frmListaProdutosFCIDivergenteNFE.cdsConsulta.RecordCount> 0 then
      frmListaProdutosFCIDivergenteNFE.ShowModal;

  If (stlItensSemCodBarras.Count > 0) Then
    pAjustaCadastroItemCodBarras;

  if blnVinculouItens then
  begin
    Close;
  end;
end;

procedure TfrmVinculaItensImportacao.btnVincularCodItemClick(Sender: TObject);
begin
  if not cdsImpotXML.isEmpty then
  begin
    if TfrmGravando.fExecutarModalA(pVincularItensComCodigoItem, 'Vinculando itens com código do item . . .', '') then
    begin
      fMensagem('ATENÇÃO!', 'Processo realizado com sucesso!'+#13+
                            'Verifique os códigos sugeridos antes de confirmar.', ['&Ok']);
    end;
  end;
end;

procedure TfrmVinculaItensImportacao.cxgDadoscodFabItemVinPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    qryConIte: TUniQuery;
    strCodFab: String;
    ArrRecordFields: TArrRecordFields;
begin
  inherited;
  qryConIte := fCriaQuery(Self);
  Try
    strCodFab := DisplayValue;
    qryConIte.SQL.Text := 'SELECT CADITE.ITE_CODFAB, CADITE.ITE_CODITE, CADITE.ITE_DESITE, ' +
      ' CONCAT(ITE_CODMAR,"-",MAR_DESMAR) ITE_DESMAR, ' +
      ' CONCAT(ITE_CODFOR,"-",FOR_NOMFOR) ITE_NOMFOR, ' +
      ' IF( SIS_VALCFG = 1, IF(CADITE.ITE_IMPDIR = "S", "SIM", "NAO") ,IF(ITEGER.ITE_IMPDIR = "S", "SIM", "NAO")) AS ITE_IMPDIG  ' +
      ' FROM CADITE ' +
      '  INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ' +
      '                       ITEGER.ITE_CODEMP = "' + VS_strCodEmp + '"' +
      ' LEFT JOIN CADMAR ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR ' +
      ' LEFT JOIN CFGSIS ON SIS_CODEMP = ITEGER.ITE_CODEMP AND SIS_CODCFG = "CFG_IMPDIG" '+
      ' LEFT JOIN CADFOR F ON F.FOR_CODFOR = CADITE.ITE_CODFOR ' +
      ' WHERE CADITE.ITE_CODFAB = "'+ VarToStrDef(DisplayValue,'')+'"';
    qryConIte.Open;
    If qryConIte.IsEmpty Then
    Begin
      pMensagemOk('Código não encontrado!');
      DisplayValue := '';
      cdsImpotXML.FieldByName('codFabItemVin').AsString := '';
      cdsImpotXML.FieldByName('DescItemLoja').AsString  := '';
      cdsImpotXML.FieldByName('CodItemLoja').AsString   := '';
      cdsImpotXML.FieldByName('NumPedComp').AsString    := '';
      cdsImpotXML.FieldByName('Marca').AsString    := '';
      cdsImpotXML.FieldByName('Fornecedor').AsString    := '';
      cdsImpotXML.FieldByName('ImportacaoDireta').AsString    := '';
    End
    Else If qryConIte.RecordCount = 1 Then
    Begin
      cdsImpotXML.FieldByName('codFabItemVin').AsString := DisplayValue;
      cdsImpotXML.FieldByName('DescItemLoja').AsString  := qryConIte.FieldByName('ITE_DESITE').AsString;
      cdsImpotXML.FieldByName('CodItemLoja').AsString  := qryConIte.FieldByName('ITE_CODITE').AsString;
      cdsImpotXML.FieldByName('Marca').AsString    := qryConIte.FieldByName('ITE_DESMAR').AsString;
      cdsImpotXML.FieldByName('Fornecedor').AsString    := qryConIte.FieldByName('ITE_NOMFOR').AsString;
      cdsImpotXML.FieldByName('ImportacaoDireta').AsString    := qryConIte.FieldByName('ITE_IMPDIG').AsString;
    End
    Else
    Begin
      SetLength(ArrRecordFields, 2);

      ArrRecordFields[0].strFieldName    := 'ITE_CODITE';
      ArrRecordFields[0].strFieldCaption := 'Cód. Item';

      ArrRecordFields[1].strFieldName    := 'ITE_DESITE';
      ArrRecordFields[1].strFieldCaption := 'Descrição';

      If TfrmGenericSelecionaRegistro.fSelecionaRegistro(ArrRecordFields, qryConIte, 'Seleciona o Item') Then
      begin
        cdsImpotXML.FieldByName('codFabItemVin').AsString := DisplayValue;
        cdsImpotXML.FieldByName('DescItemLoja').AsString  := qryConIte.FieldByName('ITE_DESITE').AsString;
        cdsImpotXML.FieldByName('CodItemLoja').AsString  := qryConIte.FieldByName('ITE_CODITE').AsString;
        cdsImpotXML.FieldByName('Marca').AsString    := qryConIte.FieldByName('ITE_DESMAR').AsString;
        cdsImpotXML.FieldByName('Fornecedor').AsString    := qryConIte.FieldByName('ITE_NOMFOR').AsString;
        cdsImpotXML.FieldByName('ImportacaoDireta').AsString    := qryConIte.FieldByName('ITE_IMPDIG').AsString;

      End
      Else
      Begin
        cdsImpotXML.FieldByName('codFabItemVin').AsString := '';
        cdsImpotXML.FieldByName('DescItemLoja').AsString  := '';
        cdsImpotXML.FieldByName('CodItemLoja').AsString   := '';
        cdsImpotXML.FieldByName('NumPedComp').AsString    := '';
        cdsImpotXML.FieldByName('Marca').AsString    := '';
        cdsImpotXML.FieldByName('Fornecedor').AsString    := '';
        cdsImpotXML.FieldByName('ImportacaoDireta').AsString    := '';
      End;
    End;


  Finally
    FreeAndNil(qryConIte);
  End;
end;

procedure TfrmVinculaItensImportacao.cxgDadosCodItemLojaPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    qryConIte: TUniQuery;
    strCodIte: String;
begin
  inherited;
  qryConIte := fCriaQuery(Self);
  Try
    strCodIte := DisplayValue;
    DisplayValue := fStrZero(strCodIte, fTamCodIte);
    qryConIte.SQL.Text := 'SELECT ITE_CODFAB, ITE_DESITE FROM CADITE WHERE ITE_CODITE = "'+DisplayValue+'"';
    qryConIte.Open;
    If qryConIte.IsEmpty Then
    Begin
      pMensagemOk('Código não encontrado!');
      DisplayValue := '';
      cdsImpotXML.FieldByName('codFabItemVin').AsString := '';
      cdsImpotXML.FieldByName('DescItemLoja').AsString  := '';
      cdsImpotXML.FieldByName('NumPedComp').AsString  := '';
      cdsImpotXML.FieldByName('Marca').AsString    := '';
      cdsImpotXML.FieldByName('Fornecedor').AsString    := '';
      cdsImpotXML.FieldByName('ImportacaoDireta').AsString    := '';
    End
  Finally
    FreeAndNil(qryConIte);
  End;
end;

procedure TfrmVinculaItensImportacao.cxgDadosEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  If (AItem = cxgDadosCodItemLoja) Or (AItem = cxgDadoscodFabItemVin) then
  Begin
    If fEntraCons(Key) Then
      pConsultaItem(Key);
  End
  else If (AItem = cxgDadosNumPedComp) then
    pConsultaPedComp(Key);
end;

procedure TfrmVinculaItensImportacao.cxgDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If key = VK_RETURN then
    If cxgDadosCodItemLoja.Focused Then
       cxgDados.NavigatorButtons.Next.Click;
end;

procedure TfrmVinculaItensImportacao.cxgDadosKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If cxgDadosCodItemLoja.Focused Then
  begin
    If fEntraCons(Key) Then
      pConsultaItem(Key);
  end
  else if cxgDadosNumPedComp.Focused then
    If fEntraCons(Key) Then
      pConsultaPedComp(Key);
end;

procedure TfrmVinculaItensImportacao.cxgDadosNumPedCompPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  strCodIte,
  strNumPed: String;
begin
  inherited;

  strNumPed := DisplayValue;
  DisplayValue := fStrZero(strNumPed, fTamNumPedCom);
  strCodIte := cdsImpotXML.FieldByName('CodItemLoja').AsString;

  if fEmptyStr(strCodIte) then
  begin
    cdsImpotXML.FieldByName('NumPedComp').AsString := '';
    pMensagemOk('O item ainda não foi vinculado!');
    Exit;
  end;

  if fEmptyStr(fValidaPedComp(strCodFor, strCodIte, DisplayValue)) then
  begin
    pMensagemOk('Pedido de Compra não encontrado!');
    DisplayValue := '';
  end;
end;

procedure TfrmVinculaItensImportacao.edtCodIteExit(Sender: TObject);
begin
  inherited;
  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmVinculaItensImportacao.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
  Begin
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmVinculaItensImportacao.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  pSetaCodIte(cdsImpotXMLCodItemLoja);
  cdsImpotXML.CreateDataSet;
  cdsImpotXML.EmptyDataSet;
  blnVinculouItens := False;
  strCodFor := '';
  stlItensSemCodBarras := TStringList.Create;
  pCriarFormularios(TfrmListaProdutosFCIDivergenteNFE, frmListaProdutosFCIDivergenteNFE);
end;

procedure TfrmVinculaItensImportacao.FormDestroy(Sender: TObject);
begin

  FreeAndNil(stlItensSemCodBarras);
  FreeAndNil(frmListaProdutosFCIDivergenteNFE);
  inherited;

end;

procedure TfrmVinculaItensImportacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_DELETE) and (cdsImpotXML.RecNo > 0) then
  begin
    if fMensagem('AVISO', 'Deseja realmente desvincular o item?', ['&Sim', '&Não']) = 1 then
    begin
      cdsImpotXML.Edit;
      cdsImpotXMLCodItemLoja.Clear;
      cdsImpotXMLDescItemLoja.Clear;
      cdsImpotXML.Post;
    end;
  end;
end;

procedure TfrmVinculaItensImportacao.FormShow(Sender: TObject);
begin
  inherited;
  cdsImpotXML.First;
  pSetFocus(edtCodIte);
end;

function TfrmVinculaItensImportacao.fValidaPedComp(strCodFor, strCodIte,
  strNumPed: String): String;
var
  strSQL: String;
  qryConPed: TUniQuery;
begin
  Result := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PCG_NUMPED ';
  strSQL := strSQL + 'FROM PCMGER ';
  strSQL := strSQL + '  INNER JOIN CADFOR ON PCG_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '  INNER JOIN PCMDET ON PCG_NUMPED = PCD_NUMPED ';
  strSQL := strSQL + '    AND PCG_ESPDOC = PCD_ESPDOC AND PCG_CODEMP = PCD_CODEMP ';
  strSQL := strSQL + ' WHERE PCMGER.PCG_BAIXAD = "0" ';
  strSQL := strSQL + '    AND PCMGER.PCG_PEDIMP = "S" ';
  strSQL := strSQL + '    AND PCMGER.PCG_CODFOR = ' + fQuotedStr(strCodFor);
  strSQL := strSQL + '    AND PCMDET.PCD_CODITE = ' + fQuotedStr(strCodIte);
  strSQL := strSQL + '    AND PCMGER.PCG_NUMPED = ' + fQuotedStr(strNumPed);

  qryConPed := fCriaQuery(Self);

  try
    qryConPed.Close;
    qryConPed.SQL.Clear;
    qryConPed.SQL.Text := strSQL;
    qryConPed.Open;

    Result := qryConPed.FieldByName('PCG_NUMPED').AsString;
  finally
    FreeAndNil(qryConPed);
  end;
end;

procedure TfrmVinculaItensImportacao.pConsultaItem(var Key: char);
  Var
    qryConIte: TUniQuery;
    arrSel : TConsultasArray;
begin
  qryConIte := fCriaQuery(Self);

  Self.Name := 'frmFatVendas1';

  If fPesqItem(conIteSimples, Self, nil, nil, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens',
                   '1', '', 0, False, False, 0, cdrCodIte, '', False, '', '', True, False, False) then
  Begin
    If (Not (fEmptyStr(qryConIte.FieldByName('ITE_CODITE').AsString))) Then
    Begin
      If Not (cdsImpotXML.State In dsEditModes) Then
        cdsImpotXML.Edit;

      cdsImpotXML.FieldByName('CodItemLoja').AsString := qryConIte.FieldByName('ITE_CODITE').AsString;
      cdsImpotXML.FieldByName('codFabItemVin').AsString := qryConIte.FieldByName('ITE_CODFAB').AsString;
      cdsImpotXML.FieldByName('DescItemLoja').AsString  := qryConIte.FieldByName('ITE_DESITE').AsString;

    End;
  End;
  Key := #0;

  FreeAndNil(qryConIte);
end;

procedure TfrmVinculaItensImportacao.pConsultaPedComp(var Key: Char);
var
  strNumPed: String;
begin
  if not fEntraCons(Key) then
    Exit;

  Key := #0;

  if (fEmptyStr(cdsImpotXML.FieldByName('CodItemLoja').AsString)) then
    Exit;

  if fPesqPedidoCompraNFImportVincItem(Self, strNumPed, cdsImpotXML.FieldByName('CodItemLoja').AsString, strCodFor) then
  begin
    if (not (fEmptyStr(strNumPed))) Then
    Begin
      if not (cdsImpotXML.State In dsEditModes) then
        cdsImpotXML.Edit;

      cdsImpotXML.FieldByName('NumPedComp').AsString := strNumPed;
    end;
  end;
end;

procedure TfrmVinculaItensImportacao.pGravaBakImp;
var
  qryBakImp: TUniQuery;
begin
  qryBakImp := fCriaQuery(Self);

  try
    try
      fStartTransaction;

      if cdsImpotXML.FieldByName('CodItemLoja').AsString <> '' then
      begin
        qryBakImp.SQL.Text := SQL_INSERT_BAKIMP;
        qryBakImp.ParamByName('ARQUIV').AsString := strNomArq;
        qryBakImp.ParamByName('CODFOR').AsString := strCodFor;
        qryBakImp.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryBakImp.ParamByName('INDICE').AsInteger := cdsImpotXML.FieldByName('Indice').AsInteger;
        qryBakImp.ParamByName('ITEXML').AsString := cdsImpotXML.FieldByName('CodItemFor').AsString;
        qryBakImp.ParamByName('CODITE').AsString := cdsImpotXML.FieldByName('CodItemLoja').AsString;
        qryBakImp.ParamByName('DESITE').AsString := cdsImpotXML.FieldByName('DescItemLoja').AsString;
        qryBakImp.ParamByName('CODFAB').AsString := cdsImpotXML.FieldByName('CodFabItemVin').AsString;
        qryBakImp.ParamByName('PEDCMP').AsString := cdsImpotXML.FieldByName('NumPedComp').AsString;
        qryBakImp.ExecSQL;
      end
      else
      begin
        qryBakImp.SQL.Text := SQL_DELETE_BAKIMP;
        qryBakImp.ParamByName('ARQUIV').AsString := strNomArq;
        qryBakImp.ParamByName('CODFOR').AsString := strCodFor;
        qryBakImp.ParamByName('ITEXML').AsString := cdsImpotXML.FieldByName('CodItemFor').AsString;
        qryBakImp.ParamByName('INDICE').AsInteger := cdsImpotXML.FieldByName('Indice').AsInteger;
        qryBakImp.ExecSQL;
      end;

      fCommit;
    except
      fRollback;
    end;
  finally
    FreeAndNil(qryBakImp);
  end;
end;

procedure TfrmVinculaItensImportacao.cdsImpotXMLBeforePost(DataSet: TDataSet);
  Var
    qryConIte: TUniQuery;
    strCodIte,
    strNumPed: String;
begin
  inherited;
  If cdsImpotXML.FieldByName('CodItemLoja').AsString <> '' Then
  Begin
    qryConIte := fCriaQuery(Self);
    Try
      strCodIte := cdsImpotXML.FieldByName('CodItemLoja').AsString;
      strCodIte := fStrZero(strCodIte, fTamCodIte);

      qryConIte.SQL.Text := 'SELECT CADITE.ITE_CODFAB, CADITE.ITE_CODITE, CADITE.ITE_DESITE, ' +
        ' CONCAT(ITE_CODMAR,"-",MAR_DESMAR) ITE_DESMAR, ' +
        ' CONCAT(ITE_CODFOR,"-",FOR_NOMFOR) ITE_NOMFOR, ' +
        ' IF( SIS_VALCFG = 1, IF(CADITE.ITE_IMPDIR = "S", "SIM", "NAO") ,IF(ITEGER.ITE_IMPDIR = "S", "SIM", "NAO")) AS ITE_IMPDIG  ' +
        ' FROM CADITE ' +
        ' INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ' +
        '                       ITEGER.ITE_CODEMP = "' + VS_strCodEmp + '"' +
        ' LEFT JOIN CADMAR ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR ' +
        ' LEFT JOIN CFGSIS ON SIS_CODEMP = ITEGER.ITE_CODEMP AND SIS_CODCFG = "CFG_IMPDIG" ' +
        ' LEFT JOIN CADFOR F ON F.FOR_CODFOR = CADITE.ITE_CODFOR ' +
        ' WHERE CADITE.ITE_CODITE = "'+strCodIte+'"';

      qryConIte.Open;
      If qryConIte.IsEmpty Then
      Begin
        cdsImpotXML.FieldByName('CodItemLoja').AsString   := '';
        cdsImpotXML.FieldByName('codFabItemVin').AsString := '';
        cdsImpotXML.FieldByName('DescItemLoja').AsString  := '';
        cdsImpotXML.FieldByName('NumPedComp').AsString    := '';
        cdsImpotXML.FieldByName('Marca').AsString := '';
        cdsImpotXML.FieldByName('Fornecedor').AsString := '';
        cdsImpotXML.FieldByName('ImportacaoDireta').AsString := '';
        pMensagemOk('Código não encontrado!');

      End
      Else
      Begin
        cdsImpotXML.FieldByName('codFabItemVin').AsString := qryConIte.FieldByName('ITE_CODFAB').AsString;
        cdsImpotXML.FieldByName('DescItemLoja').AsString  := qryConIte.FieldByName('ITE_DESITE').AsString;

        if fEmptyStr(fValidaPedComp(strCodFor, strCodIte, cdsImpotXML.FieldByName('NumPedComp').AsString)) then
          cdsImpotXML.FieldByName('NumPedComp').AsString := '';
        cdsImpotXML.FieldByName('Marca').AsString := qryConIte.FieldByName('ITE_DESMAR').AsString;
        cdsImpotXML.FieldByName('Fornecedor').AsString := qryConIte.FieldByName('ITE_NOMFOR').AsString;
        cdsImpotXML.FieldByName('ImportacaoDireta').AsString := qryConIte.FieldByName('ITE_IMPDIG').AsString;
      End;
    Finally
      FreeAndNil(qryConIte);
    End;
  End;

  If cdsImpotXML.FieldByName('NumPedComp').AsString <> '' Then
  Begin
    if fEmptyStr(cdsImpotXML.FieldByName('CodItemLoja').AsString) then
    begin
      cdsImpotXML.FieldByName('NumPedComp').AsString := '';
      pMensagemOk('O item ainda não foi vinculado!');
      Exit;
    end;

    strCodIte := cdsImpotXML.FieldByName('CodItemLoja').AsString;
    strCodIte := fStrZero(strCodIte, fTamCodIte);

    strNumPed := cdsImpotXML.FieldByName('NumPedComp').AsString;
    strNumPed := fStrZero(strNumPed, fTamNumPedCom);

    strNumPed := fValidaPedComp(strCodFor, strCodIte, strNumPed);

    if (fEmptyStr(strNumPed)) then
    begin
      cdsImpotXML.FieldByName('NumPedComp').AsString := '';
      pMensagemOk('Pedido de Compra não encontrado!');
    end
    else
      cdsImpotXML.FieldByName('NumPedComp').AsString := strNumPed;
  End;

  if (cdsImpotXML.State <> dsInsert) then
    pGravaBakImp;
end;

procedure TfrmVinculaItensImportacao.pVincularItensComCodigoDeFabrica;
Var
  qryCadIte: TUniQuery;
begin
  cdsImpotXML.DisableControls;
  qryCadIte := fCriaQuery(Self);
  qryCadIte.SQL.Text := 'SELECT CADITE.ITE_CODFAB, CADITE.ITE_CODITE, CADITE.ITE_DESITE, ' +
    ' CONCAT(CADITE.ITE_CODMAR,"-",MAR_DESMAR) ITE_DESMAR, ' +
    ' CONCAT(CADITE.ITE_CODFOR,"-",FOR_NOMFOR) ITE_NOMFOR, ' +
    ' IF( SIS_VALCFG = 1, IF(CADITE.ITE_IMPDIR = "S", "SIM", "NAO") ,IF(ITEGER.ITE_IMPDIR = "S", "SIM", "NAO")) AS ITE_IMPDIG  ' +
    ' FROM CADITE ' +
    '  INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ' +
    '                       ITEGER.ITE_CODEMP = "' + VS_strCodEmp + '"' +
    ' LEFT JOIN CADMAR ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR ' +
    ' LEFT JOIN CFGSIS ON SIS_CODEMP = ITEGER.ITE_CODEMP AND SIS_CODCFG = "CFG_IMPDIG" ' +
    ' LEFT JOIN CADFOR F ON F.FOR_CODFOR = CADITE.ITE_CODFOR ' +
    ' WHERE REPLACE(REPLACE(REPLACE(REPLACE(CADITE.ITE_CODFAB,"-",""),"/",""),".","")," ","")  = :CODFAB';

  Try
    cdsImpotXML.First;
    while not cdsImpotXML.Eof do
    begin
      qryCadIte.Close;
      qryCadIte.ParamByName('CODFAB').AsString := fTiraCaracEspeciais(cdsImpotXML.FieldByName('CodItemFor').AsString, True, True, True);
      qryCadIte.Open;

      If not qryCadIte.IsEmpty Then
      Begin
        cdsImpotXML.Edit;
        cdsImpotXML.FieldByName('CodItemLoja').AsString   := qryCadIte.FieldByName('ITE_CODITE').AsString;
        cdsImpotXML.FieldByName('codFabItemVin').AsString := qryCadIte.FieldByName('ITE_CODFAB').AsString;
        cdsImpotXML.FieldByName('DescItemLoja').AsString  := qryCadIte.FieldByName('ITE_DESITE').AsString;
        cdsImpotXML.FieldByName('NumPedComp').AsString    := '';
        cdsImpotXML.FieldByName('Marca').AsString := qryCadIte.FieldByName('ITE_DESMAR').AsString;
        cdsImpotXML.FieldByName('Fornecedor').AsString := qryCadIte.FieldByName('ITE_NOMFOR').AsString;
        cdsImpotXML.FieldByName('ImportacaoDireta').AsString := qryCadIte.FieldByName('ITE_IMPDIG').AsString;
        cdsImpotXML.Post;
      End;

      cdsImpotXML.Next;
    end;

  Finally
    FreeAndNil(qryCadIte);
    cdsImpotXML.First;
    cdsImpotXML.EnableControls;
  End;
end;

procedure TfrmVinculaItensImportacao.pVincularItensComCodigoItem;
var
  strSQL: String;
  qryIteFor: TUniQuery;
begin
  cdsImpotXML.DisableControls;
  qryIteFor := fCriaQuery(Self);

  strSQL := 'SELECT ITEFOR.ITE_CODITE, CADITE.ITE_CODFAB, ITE_DESITE, ' +
    ' CONCAT(ITE_CODMAR,"-",MAR_DESMAR) ITE_DESMAR, ' +
    ' CONCAT(CADITE.ITE_CODFOR,"-",FOR_NOMFOR) ITE_NOMFOR, ' +
    ' IF( SIS_VALCFG = 1, IF(CADITE.ITE_IMPDIR = "S", "SIM", "NAO") ,IF(ITEGER.ITE_IMPDIR = "S", "SIM", "NAO")) AS ITE_IMPDIG ' +
    ' FROM ITEFOR ' +
    ' INNER JOIN CADITE ON ITEFOR.ITE_CODITE = CADITE.ITE_CODITE '+
    ' INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ' +
    '                       ITEGER.ITE_CODEMP = "' + VS_strCodEmp + '"' +
    ' LEFT JOIN CADMAR ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR ' +
    ' LEFT JOIN CFGSIS ON SIS_CODEMP = ITEGER.ITE_CODEMP AND SIS_CODCFG = "CFG_IMPDIG" '+
    ' LEFT JOIN CADFOR F ON F.FOR_CODFOR = CADITE.ITE_CODFOR ' +
    ' WHERE ITEFOR.ITE_CODFOR = :CODFOR AND ITE_CODITF = :CODITF';


  qryIteFor.SQL.Text := strSQL;

  try
    cdsImpotXML.First;

    while not cdsImpotXML.Eof do
    begin
      qryIteFor.Close;
      qryIteFor.ParamByName('CODFOR').AsString := strCodFor;
      qryIteFor.ParamByName('CODITF').AsString := cdsImpotXML.FieldByName('CodItemFor').AsString;
      qryIteFor.Open;

      if not qryIteFor.IsEmpty then
      begin
        cdsImpotXML.Edit;
        cdsImpotXML.FieldByName('CodItemLoja').AsString   := qryIteFor.FieldByName('ITE_CODITE').AsString;
        cdsImpotXML.FieldByName('codFabItemVin').AsString := qryIteFor.FieldByName('ITE_CODFAB').AsString;
        cdsImpotXML.FieldByName('DescItemLoja').AsString  := qryIteFor.FieldByName('ITE_DESITE').AsString;
        cdsImpotXML.FieldByName('NumPedComp').AsString    := '';
        cdsImpotXML.FieldByName('Marca').AsString    := qryIteFor.FieldByName('ITE_DESMAR').AsString;
        cdsImpotXML.FieldByName('Fornecedor').AsString    := qryIteFor.FieldByName('ITE_NOMFOR').AsString;
        cdsImpotXML.FieldByName('ImportacaoDireta').AsString    := qryIteFor.FieldByName('ITE_IMPDIG').AsString;
        cdsImpotXML.Post;
      end;
      cdsImpotXML.Next;
    end;

  finally
    FreeAndNil(qryIteFor);
    cdsImpotXML.First;
    cdsImpotXML.EnableControls;
  end;
end;

procedure TfrmVinculaItensImportacao.setNFeXML(aValue: TNFeXml);
begin
  FObjEntNfeXml := aValue;
end;

procedure TfrmVinculaItensImportacao.PreencherListaDeDivergencia;
var
  intIndice: Integer;
  recProdutoNota: TrecProdutoNota;
  RecDetEle: TRecDetEle;
begin
  if not Assigned(frmListaProdutosFCIDivergenteNFE) then
    Exit;

  for intIndice := 0 to FObjEntNfeXml.getQuantidadeItens - 1 do
  begin
    RecDetEle := FObjEntNfeXml.getItemNota[intIndice];

    if cdsImpotXML.Locate('NITEM',RecDetEle.I02_NITEM,[loCaseInsensitive,loPartialKey]) then
    begin
      recProdutoNota.strNumNfe := string(FObjEntNfeXml.recDadosNota.B08_NNF);
      recProdutoNota.strSerie  := string(FObjEntNfeXml.recDadosNota.B07_SERIE);
      recProdutoNota.strCodProdutoNota := cdsImpotXML.FieldByName('CodItemLoja').AsString;
      recProdutoNota.strDescProdutoNota := string(RecDetEle.I04_XPROD);
      recProdutoNota.strNumFCINota := string(RecDetEle.I70_NFCI);
      recProdutoNota.intPorcentagemFCINota := RecDetEle.ITE_PER_CI;
      recProdutoNota.strClassIPINota :=  string(RecDetEle.I05_NCM);
      recProdutoNota.strCodBarNota := string(RecDetEle.I03_CEAN);
      recProdutoNota.strCodForNota := string(FObjEntNfeXml.recDadosNota.GER_CODFOR);
      recProdutoNota.strCESTNota := string(RecDetEle.CODCEST);

      frmListaProdutosFCIDivergenteNFE.InserirItem(recProdutoNota);
    end;

  end;

end;

procedure TfrmVinculaItensImportacao.btnVinculaCodFabClick(Sender: TObject);
begin
  If not cdsImpotXML.isEmpty Then
  Begin
    If TfrmGravando.fExecutarModalA(pVincularItensComCodigoDeFabrica, 'Vinculando itens com código de fábrica . . .', '') Then
    Begin
      fMensagem('ATENÇÃO!', 'Processo realizado com sucesso!'+#13+
                            'Verifique os códigos sugeridos antes de confirmar.', ['&Ok']);
    End;
  End;
end;

procedure TfrmVinculaItensImportacao.pAjustaCadastroItemCodBarras;
  Var
    intRecNo : Integer;
    blnContinua : Boolean;
    intContador : Integer;
    arrMensagem: TStringArray;
begin

  SetLength(arrMensagem, 0);

  For intContador := 0 to stlItensSemCodBarras.Count - 1 Do
  Begin
    pAddDados(arrMensagem, stlItensSemCodBarras[intContador] );
  End;

  blnContinua := fMensagemTabela('Itens sem Código de Fábrica Principal no AUTCOM',
                                 'Cód. Item  |Descrição                      |Cód. Fábrica XML    ',
                                 arrMensagem,
                                 'Deseja atualizar o cadastro de produtos com os respectivos códigos de fábrica do xml importado?',
                                 ['&Sim', '&Não'],
                                 1,
                                 False,
                                 1,
                                 0,
                                 False,
                                 0,
                                 False,
                                 False,
                                 False,
                                 500,
                                 70) = 1;
  If (Not blnContinua) Then
    Exit;

  cdsImpotXML.DisableControls;
  intRecNo := cdsImpotXML.RecNo;

  cdsImpotXML.First;
  Try
    While (Not cdsImpotXML.Eof) do
    Begin
      If (fEmptyStr(cdsImpotXMLcodFabItemVin.AsString)) Then
      Begin
        cdsImpotXML.Edit;
        cdsImpotXMLcodFabItemVin.AsString := cdsImpotXMLCodItemFor.AsString;
        cdsImpotXML.Post;

        pAtualizaCODFAB_CADITE(cdsImpotXMLCodItemLoja.AsString, cdsImpotXMLCodItemFor.AsString);
        pAtualizaCODFAB_ITEFOR(cdsImpotXMLCodItemLoja.AsString, cdsImpotXMLCodItemFor.AsString);
      End;

      cdsImpotXML.Next;
    End;

  Finally
    cdsImpotXML.RecNo :=  intRecNo;
    cdsImpotXML.EnableControls;
  End;

end;

procedure TfrmVinculaItensImportacao.pAtualizaCODFAB_CADITE(strCodIte, strCodFab: String; blnAtualizaCODFOR: Boolean = False);
  Var
    qryConsulta: TUniQuery;
begin
  If (fEmptyStr(strCodFab)) Then
    Exit;

  qryConsulta := fCriaQuery;

  Try

    qryConsulta.SQL.Add('UPDATE CADITE');
    qryConsulta.SQL.Add('  SET ITE_CODFAB = :CODFAB ');
    qryConsulta.SQL.Add('WHERE ITE_CODITE = :CODITE');

    If (Not blnAtualizaCODFOR) Then
      qryConsulta.SQL.Add('   AND COALESCE(ITE_CODFAB, "") = ""');

    qryConsulta.ParamByName('CODFAB').AsString := strCodFab;
    qryConsulta.ParamByName('CODITE').AsString := strCodIte;
    qryConsulta.ExecSQL;

  Finally
    FreeAndNil(qryConsulta);
  End
end;

procedure TfrmVinculaItensImportacao.pAtualizaCODFAB_ITEFOR(strCodIte, strCodFab: String; blnAtualizaCODFOR: Boolean = False);
  Var
    qryConsulta: TUniQuery;
begin
  If (fEmptyStr(strCodFab)) Then
    Exit;

  qryConsulta := fCriaQuery;

  Try

    qryConsulta.SQL.Add('UPDATE ITEFOR');
    qryConsulta.SQL.Add('  SET ITE_CODITF = :CODFAB ');
    qryConsulta.SQL.Add('WHERE ITE_CODITE = :CODITE ');
    qryConsulta.SQL.Add('  AND ITE_CODFOR = :CODFOR ');
    qryConsulta.SQL.Add('  AND ITE_CODEMP = :CODEMP ');

    If (Not blnAtualizaCODFOR) Then
      qryConsulta.SQL.Add('   AND COALESCE(ITE_CODITF, "") = ""');

    qryConsulta.ParamByName('CODFAB').AsString := strCodFab;
    qryConsulta.ParamByName('CODITE').AsString := strCodIte;
    qryConsulta.ParamByName('CODFOR').AsString := strCodFor;
    qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryConsulta.ExecSQL;

  Finally
    FreeAndNil(qryConsulta);
  End
end;

end.
