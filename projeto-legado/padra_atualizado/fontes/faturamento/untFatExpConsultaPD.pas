unit untFatExpConsultaPD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, UniClientDataSet,
  Uni, UniDataSetProvider, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, EditFocus, untFuncFatImp, untFuncFatTypes,
  System.UITypes, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatExpConsultaPD = class(TfrmPai)
    cxDadosDBTableView1: TcxGridDBTableView;
    cxDadosLevel1: TcxGridLevel;
    cxDados: TcxGrid;
    colDtaEnt: TcxGridDBColumn;
    colDocume: TcxGridDBColumn;
    colNomCli: TcxGridDBColumn;
    colNomOpe: TcxGridDBColumn;
    colQtdIte: TcxGridDBColumn;
    btnAlterar: TBitBtnLocked;
    pnlBusca: TPanel;
    lbl2: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    btnImprimir: TBitBtnLocked;
    colImprim: TcxGridDBColumn;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxDadosDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxDadosDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxDadosDBTableView1DblClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    qryDados : TUniQuery;
    dtsDados : TDataSource;
    cdsDados : TUniClientDataSet;

    procedure pAfterOpen(DataSet: TDataSet);
    procedure pCriaClient;
    procedure pSelecionaDocumento;

    function fRomaneioParcial: Boolean;

  public
    { Public declarations }
    strNumRom : String;
    blnFiltrarPorItem: Boolean;
    blnReimpressao : Boolean;

    procedure pCarregaPD;
  end;

var
  frmFatExpConsultaPD: TfrmFatExpConsultaPD;

implementation

uses untFuncoesSimples, untModulo, untFatAltQtdeItensPedido, untFuncoes;

{$R *.dfm}

procedure TfrmFatExpConsultaPD.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(dtsDados);
  FreeAndNil(cdsDados);
  FreeAndNil(qryDados);
end;

procedure TfrmFatExpConsultaPD.FormCreate(Sender: TObject);
begin
  inherited;

  blnReimpressao := True;

  pCriaClient;

  dtsDados := fCriaDataSource(cdsDados);
  cxDadosDBTableView1.DataController.DataSource := dtsDados;

  qryDados := fCriaQuery(Self);
  cdsDados.AfterOpen := pAfterOpen;

  blnFiltrarPorItem := True;
end;

procedure TfrmFatExpConsultaPD.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F2     : btnImprimir.Click;
    VK_F3     : btnMarcarTodos.Click;
    VK_F4     : btnDesmarcarTodos.Click;
    VK_F10    : btnAlterar.Click;
    VK_ESCAPE : btnSair.Click
  End;
end;

procedure TfrmFatExpConsultaPD.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaPD;

  pnlBusca.Visible    := blnFiltrarPorItem;
  btnAlterar.Visible  := blnFiltrarPorItem;

  btnImprimir.Visible       := Not blnFiltrarPorItem;
  btnMarcarTodos.Visible    := Not blnFiltrarPorItem;
  btnDesmarcarTodos.Visible := Not blnFiltrarPorItem;
end;

function TfrmFatExpConsultaPD.fRomaneioParcial: Boolean;
begin
  Result := True;
  if not fCfgSis('USPRRO', varBoolean) then
    Exit(False);

  if not fCfgSis('RMPDPA', varBoolean) then
    Exit(False);
end;

procedure TfrmFatExpConsultaPD.btnAlterarClick(Sender: TObject);
  Var
    strEmpAnt : String;
begin
  inherited;


  {If fPedidoBaixaEntregaFutura(cdsDados.FieldByName('FDO_NUMDOC').AsString,
                               cdsDados.FieldByName('FDO_ESPDOC').AsString,
                               cdsDados.FieldByName('FDO_CODEMP').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'Pedidos de Baixa de Entrega Futura não podem ser alterados!', ['&Ok']);
    Exit;
  End;}
  Try

    pCriarFormularios(TfrmFatAltQtdeItensPedido, frmFatAltQtdeItensPedido);
    frmFatAltQtdeItensPedido.edtNumDoc.Text := cdsDados.FieldByName('FDO_NUMDOC').AsString;
    frmFatAltQtdeItensPedido.edtEspDoc.Text := cdsDados.FieldByName('FDO_ESPDOC').AsString;
    frmFatAltQtdeItensPedido.edtCodEmp.Text := cdsDados.FieldByName('FDO_CODEMP').AsString;
    frmFatAltQtdeItensPedido.edtDesEmp.Text := fRetNomeEmpresa;
    frmFatAltQtdeItensPedido.strNumRom      := strNumRom;
    frmFatAltQtdeItensPedido.blnCarregaQtdSepOriginal := True;

    strEmpAnt := VS_strCodEmp;
    Try
      pSetaEmpresaLogada(cdsDados.FieldByName('FDO_CODEMP').AsString);
      frmFatAltQtdeItensPedido.ShowModal;
    Finally
      pSetaEmpresaLogada(strEmpAnt);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pCarregaPD;
  pFreeAndNil(frmFatAltQtdeItensPedido);
end;

procedure TfrmFatExpConsultaPD.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  With cdsDados Do
  Begin
    DisableControls;

    First;
    While Not EOF Do
    Begin
      Edit;
      FieldByName('FDO_IMPRIM').AsString := 'N';
      Post;

      Next;
    End;

    First;
    EnableControls;
  End;
end;

procedure TfrmFatExpConsultaPD.btnImprimirClick(Sender: TObject);
  Var
    ArrDocsImp : TDocumentos;

    procedure pAddDocs(strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
      Var
        intCnt : Integer;
        blnTem : Boolean;
    begin
      blnTem := False;
      For intCnt := Low(ArrDocsImp) To High(ArrDocsImp) Do
      Begin
        If (ArrDocsImp[intCnt].strNumDoc = strNumDoc) And
           (ArrDocsImp[intCnt].strEspDoc = strEspDoc) And
           (ArrDocsImp[intCnt].strCodEmp = strCodEmp) And
           (ArrDocsImp[intCnt].strCodCLi = strCodCLi) Then
        Begin
          blnTem := True;
          Break;
        End;
      End;

      If (Not blnTem) Then
      Begin
        SetLength(ArrDocsImp, Length(ArrDocsImp) + 1);
        ArrDocsImp[Length(ArrDocsImp) - 1].strNumDoc := strNumDoc;
        ArrDocsImp[Length(ArrDocsImp) - 1].strEspDoc := strEspDoc;
        ArrDocsImp[Length(ArrDocsImp) - 1].strCodEmp := strCodEmp;
        ArrDocsImp[Length(ArrDocsImp) - 1].strCodCli := strCodCLi;
      End;
    end;

begin
  With cdsDados Do
  Begin
    DisableControls;
    Filtered := False;
    Filter   := ' FDO_IMPRIM = ' + QuotedStr('S');
    Filtered := True;

    If IsEmpty Then
    Begin
      pMensagemOk('Marque pelo menos 1 pedido para ser impresso');
      Filter   := '';
      Filtered := False;
      EnableControls;
      Exit;
    End
    Else
    Begin
      SetLength(ArrDocsImp, 0);

      First;
      While (Not EOF) Do
      Begin
        pAddDocs(cdsDados.FieldByName('FDO_NUMDOC').AsString,
                 cdsDados.FieldByName('FDO_ESPDOC').AsString,
                 cdsDados.FieldByName('FDO_CODEMP').AsString,
                 cdsDados.FieldByName('FDO_CODCLI').AsString);

        Next;
      End;

      TFatVendaImp.pImprimirSeparacaoFina(strNumRom, ArrDocsImp);
    End;

    Filter   := '';
    Filtered := False;
    EnableControls;
  End;
end;

procedure TfrmFatExpConsultaPD.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;

  With cdsDados Do
  Begin
    DisableControls;

    First;
    While Not EOF Do
    Begin
      Edit;
      FieldByName('FDO_IMPRIM').AsString := 'S';
      Post;

      Next;
    End;

    First;
    EnableControls;
  End;
end;

procedure TfrmFatExpConsultaPD.cxDadosDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  With cdsDados Do
  Begin
    If Not Active Then
      Exit;

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, colImprim.Index]) = 'S' Then
    Begin
      ACanvas.Font.Color := clBlue;

      If (ACanvas.Brush.Color = clHighlight) Then
        ACanvas.Font.Color := clYellow;
    End;
  End;
end;

procedure TfrmFatExpConsultaPD.cxDadosDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDocumento;
end;

procedure TfrmFatExpConsultaPD.cxDadosDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Escape: btnSair.Click;
    VK_Return: pSelecionaDocumento;
  End;

end;

procedure TfrmFatExpConsultaPD.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('FDO_QTDITE') <> nil Then
      TFloatField(FieldByName('FDO_QTDITE')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TfrmFatExpConsultaPD.pCarregaPD;
begin
  Try
    With qryDados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT D.FDO_DTAENT, ');
      SQL.Add('       D.FDO_CODEMP, ');
      SQL.Add('       D.FDO_ESPDOC, ');
      SQL.Add('       D.FDO_NUMDOC, ');
      SQL.Add('       D.FDO_CODCLI, ');
      SQL.Add('       CONCAT(D.FDO_NUMDOC, "-", D.FDO_ESPDOC, "-", D.FDO_CODEMP) AS FDO_DOCUME, ');
      SQL.Add('       CONCAT(D.FDO_CODCLI, "-", C.CLI_NOMCLI) AS CLI_NOMCLI, ');
      SQL.Add('       CONCAT(D.FDO_CODVEN, "-", O.OPE_NOMOPE) AS OPE_NOMOPE, ');
      SQL.Add('       SUM(D.FDO_QTDITE) AS FDO_QTDITE, ');
      SQL.Add('       SUM(R.DET_QTDITE) AS DET_QTDITE ');
      SQL.Add('FROM   FATDOR D INNER JOIN CADCLI C  ON D.FDO_CODCLI = C.CLI_CODCLI ');
      SQL.Add('                INNER JOIN CADOPE O  ON D.FDO_CODVEN = O.OPE_CODOPE ');
      SQL.Add('                INNER JOIN ROMDETX R ON R.DET_CODEMP = D.FDO_CODEMP ');
      SQL.Add('                                    AND R.DET_NUMDOC = D.FDO_NUMDOC ');
      SQL.Add('                                    AND R.DET_ESPDOC = D.FDO_ESPDOC ');
      SQL.Add('                                    AND R.DET_CODCLI = D.FDO_CODCLI ');
      SQL.Add('                                    AND R.DET_AUTINC = D.AUTOINCREM ');
      SQL.Add('WHERE  IFNULL(D.FDO_ENTFUT,"N")  = "N"     ');
      SQL.Add('  AND  ' + fSQLQtde + '          > FDO_QTDBAI ');
      SQL.Add('  AND  FDO_JAFATU                = 0       ');
      SQL.Add('  AND  IFNULL(FDO_PROEMB,"N")   <> "S"     ');
      SQL.Add('  AND  R.DET_NUMROM              = :NUMROM ');
      SQL.Add('  AND  R.DET_EMPROM              = :EMPROM ');

      If blnFiltrarPorItem Then
        SQL.Add('  AND  D.FDO_CODITE              = :CODITE ')
      Else
      Begin
        SQL.Add('GROUP BY ');
        SQL.Add('  D.FDO_NUMDOC ');
      End;

      SQL.Add('ORDER BY ');

      If (fCfgSis('TPSPFN') = '1') Then
        SQL.Add('  D.FDO_DTAENT, D.FDO_CODCLI, D.FDO_CODEMP, D.FDO_ESPDOC, D.FDO_NUMDOC ')
      Else
        SQL.Add('  D.FDO_DTAENT, D.FDO_CODEMP, D.FDO_ESPDOC, D.FDO_NUMDOC ');

      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := VS_strCodEmp;

      If blnFiltrarPorItem Then
        ParamByName('CODITE').AsString := edtCodIte.Text;

      Open;
      First;

      cdsDados.EmptyDataSet;
      While Not EOF Do
      Begin
        cdsDados.Append;
        cdsDados.FieldByName('FDO_DTAENT').AsDateTime := FieldByName('FDO_DTAENT').AsDateTime;
        cdsDados.FieldByName('FDO_CODEMP').AsString   := FieldByName('FDO_CODEMP').AsString;
        cdsDados.FieldByName('FDO_ESPDOC').AsString   := FieldByName('FDO_ESPDOC').AsString;
        cdsDados.FieldByName('FDO_NUMDOC').AsString   := FieldByName('FDO_NUMDOC').AsString;
        cdsDados.FieldByName('FDO_CODCLI').AsString   := FieldByName('FDO_CODCLI').AsString;
        cdsDados.FieldByName('FDO_DOCUME').AsString   := FieldByName('FDO_DOCUME').AsString;
        cdsDados.FieldByName('CLI_NOMCLI').AsString   := FieldByName('CLI_NOMCLI').AsString;
        cdsDados.FieldByName('OPE_NOMOPE').AsString   := FieldByName('OPE_NOMOPE').AsString;
        if fRomaneioParcial then
          cdsDados.FieldByName('FDO_QTDITE').AsFloat    := FieldByName('DET_QTDITE').AsFloat
        else
          cdsDados.FieldByName('FDO_QTDITE').AsFloat    := FieldByName('FDO_QTDITE').AsFloat;
        cdsDados.FieldByName('FDO_IMPRIM').AsString   := IIF(blnReimpressao, 'N', 'S');
        cdsDados.Post;

        Next;
      End;

      cdsDados.Close;
      cdsDados.Open;
    End;
  Except
    pMensagensErro('','');
  End;
end;

procedure TfrmFatExpConsultaPD.pCriaClient;
begin
  cdsDados := TUniClientDataSet.Create(Self);

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FDO_DTAENT';
    DataType := ftDateTime;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FDO_CODEMP';
    DataType := ftString;
    Size     := 03;
    Required := False;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FDO_ESPDOC';
    DataType := ftString;
    Size     := 02;
    Required := False;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FDO_NUMDOC';
    DataType := ftString;
    Size     := 12;
    Required := False;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FDO_CODCLI';
    DataType := ftString;
    Size     := 8;
    Required := False;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FDO_DOCUME';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CLI_NOMCLI';
    DataType := ftString;
    Size     := 100;
    Required := False;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'OPE_NOMOPE';
    DataType := ftString;
    Size     := 100;
    Required := False;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FDO_QTDITE';
    DataType := ftFloat;
    Precision:= 2;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FDO_IMPRIM';
    DataType := ftString;
    Size     := 01;
    Required := False;
  End;

  cdsDados.CreateDataSet;

  If (fCfgSis('TPSPFN') = '1') Then
    cdsDados.IndexFieldNames := 'FDO_DTAENT;FDO_CODCLI;FDO_CODEMP;FDO_ESPDOC;FDO_NUMDOC'
  Else
    cdsDados.IndexFieldNames := 'FDO_DTAENT;FDO_CODEMP;FDO_ESPDOC;FDO_NUMDOC';
end;

procedure TfrmFatExpConsultaPD.pSelecionaDocumento;
begin
  If Not blnFiltrarPorItem Then
  Begin
    With cdsDados Do
    Begin
      DisableControls;

      Edit;
      FieldByName('FDO_IMPRIM').AsString := IIF(FieldByName('FDO_IMPRIM').AsString = 'S', 'N', 'S');
      Post;

      EnableControls;
    End;
  End;
end;

end.
