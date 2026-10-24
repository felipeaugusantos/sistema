unit untFatMostraProdSimilar;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni, StrUtils,
  Grids, DBGridCitel, DBGrids, Menus, EditFocus, AppEvnts, DB, BitBtnLockedIncrem,
  UniClientDataSet, UniDataSetProvider, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGridCitel, cxClasses, cxGridLevel, cxGrid, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  untFatMostraEstoqueEmp, untSalvaConfiguracaoGrid;

type
  TfrmFatMostraProdSimilar = class(TfrmPaiSimples)
    pnlCabecalho     : TPanel;
    pnlBotoesMostra  : TPanel;
    btnFechar        : TBitBtnLocked;
    Label1           : TLabel;
    edtItem          : TEditFocus;
    dtsProSim        : TDataSource;
    cxgItensLevel1   : TcxGridLevel;
    cxgItensTableView: TcxGridDBTableViewCitel;
    cxgItens         : TcxGridCitel;
    ITE_CODITE       : TcxGridDBColumn;
    ITE_DESITE       : TcxGridDBColumn;
    ITE_REFERE       : TcxGridDBColumn;
    UNI_SIGUNI       : TcxGridDBColumn;
    MAR_DESMAR       : TcxGridDBColumn;
    ITE_CODFAB       : TcxGridDBColumn;
    ITE_SALDOS       : TcxGridDBColumn;
    ITE_SALDIS       : TcxGridDBColumn;
    ITE_PRECUS       : TcxGridDBColumn;
    ITE_PREVEN       : TcxGridDBColumn;
    ITE_MARBR1       : TcxGridDBColumn;
    ITE_PROMOC       : TcxGridDBColumn;
    ITE_PREPRO       : TcxGridDBColumn;
    pnlPromo         : TPanel;
    shpPromo         : TShape;
    Label6           : TLabel;
    Label2: TLabel;
    lblPrePro: TLabel;
    ITE_SITUAC: TcxGridDBColumn;
    ITE_ESTMIN: TcxGridDBColumn;
    ITE_ESTMAX: TcxGridDBColumn;
    btnMostraEstoque: TBitBtnLocked;
    btnCfgGri: TBitBtnLocked;
    procedure btnFecharClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cxgItensTableViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgItensTableViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnMostraEstoqueClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCfgGriClick(Sender: TObject);
  private
    { Private declarations }
    FEnter      : Boolean;
    FAutInc     : String;
    FCodFab     : String;
    FCodIte     : String;
    FFaturamento: Boolean;
    FTabPre     : String;
    procedure pAfterScroll(Dataset: TDataset);
    procedure pMostraEstoqueLojas;
  public
    { Public declarations }

    Class Function fMostraSimilar(strCodSim,
                                  strCodIteLocate,
                                  strDesIte,
                                  strTabPre: String;
                                  Var blnEnter    : Boolean;
                                  Var strAutInc,
                                  strCodFab,
                                  strCodIte       : String;
                                  blnExiCus       : Boolean = False;
                                  blnDiferente    : Boolean = False;
                                  blnFaturamento  : Boolean = False;
                                  blnMostrarMargem: Boolean = False;
                                  strOpcDoc       : String = '';
                                  strCodCli       : String = '';
                                  intPraMed       : Integer = 0;
                                  strCodEmp       : String = ''):Boolean; Overload;

    Class Function fMostraSimilar(strCodSim,
                                  strCodIteLocate,
                                  strDesIte,
                                  strTabPre     : String;
                                  blnFaturamento: Boolean = False;
                                  strCodCli     : String = '';
                                  intPraMed     : Integer = 0):Boolean; Overload;

  end;

implementation

uses untFuncoesSimples, untCadPro, untLegendasItem, untCfgGrid;

{$R *.dfm}

procedure TfrmFatMostraProdSimilar.btnCfgGriClick(Sender: TObject);
var
  objConfigGrid : TCfgGrid;
  arrTamCol : TColunasWidth;
  intContador : integer;
begin
  inherited;
  SetLength(arrTamCol, cxgItensTableView.ColumnCount);

  for intContador := 0 to Pred(Length(arrTamCol)) do
    arrTamCol[intContador] := cxgItensTableView.Columns[intContador].Width;

  objConfigGrid := TCfgGrid.Create(Self,
                                   cxgItensTableView,
                                   'Grid Produtos Similares',
                                   arrTamCol,
                                   strLoginUsuarioLogado,
                                   True,
                                   False);

  try
    objConfigGrid.pConfiguraColunas;
  finally
    FreeAndNil(objConfigGrid);
  end;
end;

procedure TfrmFatMostraProdSimilar.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraProdSimilar.btnMostraEstoqueClick(Sender: TObject);
begin
  inherited;
  If btnMostraEstoque.Visible Then
  Begin
    if (not fVerificaAcessoSistema('PVISPF')) then
    begin
      fMensagem('ATENÇÃO','Operador não possui acesso para visualizar informações de saldo de produtos no faturamento.',['&OK']);
      Exit;
    end;

    If Not fVerificaAcessoSistema('CPELOJ', strLoginUsuarioLogado) Then
      fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
    Else
      pMostraEstoqueLojas;
  End;
end;

procedure TfrmFatMostraProdSimilar.pMostraEstoqueLojas;
  Var
    frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
begin
  Try
    pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);

    frmFatMostraEstoqueEmp.blnFaturamento := FFaturamento;
    frmFatMostraEstoqueEmp.strCodIte      := dtsProSim.DataSet.FieldByName('ITE_CODITE').AsString;
    frmFatMostraEstoqueEmp.strTabPre      := FTabPre;
    frmFatMostraEstoqueEmp.edtItem.Text   := dtsProSim.DataSet.FieldByName('ITE_CODITE').AsString + ' - ' +
                                             dtsProSim.DataSet.FieldByName('ITE_DESITE').AsString;
    frmFatMostraEstoqueEmp.blnEstrutura   := fItemEstrutura(dtsProSim.DataSet.FieldByName('ITE_CODITE').AsString);
    frmFatMostraEstoqueEmp.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraEstoqueLojas]');
  End;

  pFreeAndNil(frmFatMostraEstoqueEmp);
end;


procedure TfrmFatMostraProdSimilar.cxgItensTableViewCustomDrawCell(Sender   : TcxCustomGridTableView;
                                                                   ACanvas  : TcxCanvas;
                                                                   AViewInfo: TcxGridTableDataCellViewInfo;
                                                                   var ADone: Boolean);
begin

  {Zebra}
  If Odd(AViewInfo.GridRecord.Index) Then
  Begin
    If (AViewInfo.GridRecord.Selected) Then
    Begin
      If AViewInfo.GridView.Site.Focused Then
      Begin
        If (AViewInfo.Item.Focused) Then
          ACanvas.Brush.Color := clWhite
        Else
          ACanvas.Font.Color := clBlack;
      End
      Else
        ACanvas.Brush.Color := strToIntDef(fCfgSis('CORZEB'), clMoneyGreen)
    End
    Else
      ACanvas.Brush.Color := strToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
  End;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, ITE_PROMOC.Index]) = 'S' Then
  Begin
    If (AViewInfo.GridRecord.Selected) Then
    Begin
      ACanvas.Font.Color := clWhite;
      ACanvas.Brush.Color := clHighlight;
    End
    Else
      ACanvas.Font.Color := shpPromo.Brush.Color;

    If Not pnlPromo.Visible Then
      pnlPromo.Visible := True;
  End;

  If AViewInfo.Item.Caption = 'Situação' Then
  Begin

    ACanvas.Font.Color := clBlack;

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, ITE_SITUAC.Index]) = 'PROMO' Then
    Begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.FillRect(AViewInfo.Bounds);
    End;

  End;

end;

procedure TfrmFatMostraProdSimilar.cxgItensTableViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    btnFechar.Click;

  If Key = VK_Return Then
  Begin
    FEnter  := True;
    FAutInc := cxgItensTableView.DataController.DataSource.DataSet.Fieldbyname('AUTOINCREM').asString;
    FCodFab := cxgItensTableView.DataController.DataSource.DataSet.Fieldbyname('ITE_CODFAB').asString;
    FCodIte := cxgItensTableView.DataController.DataSource.DataSet.Fieldbyname('ITE_CODITE').asString;
    btnFechar.Click;
  End;
end;

procedure TfrmFatMostraProdSimilar.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgItens);
end;

procedure TfrmFatMostraProdSimilar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxgItensTableView, Self.Name);
end;

procedure TfrmFatMostraProdSimilar.FormCreate(Sender: TObject);
begin
  inherited;

  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxgItensTableView, Self.Name);
end;

procedure TfrmFatMostraProdSimilar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F6:
    Begin
      btnMostraEstoque.Click;
      Key := 0;
    End;
  End;
end;

procedure TfrmFatMostraProdSimilar.FormShow(Sender: TObject);
  Var
    intCor: Integer;
begin
  inherited;
  btnCfgGri.Visible := fVerificaAcessoSistema('PSABCT', strLoginUsuarioLogado);

  intCor := fRetCorSituacaoItem(ARRDESC_SITUACAO_ITEM[sitPromocao]);
  If intCor > 0 Then
    shpPromo.Brush.Color := intCor
  Else
    shpPromo.Brush.Color := clTeal;
end;

procedure TfrmFatMostraProdSimilar.pAfterScroll(Dataset: TDataset);
begin
  With Dataset Do
  Begin
    If FieldByName('ITE_PROMOC').AsString = 'S' Then
    Begin
      Label2.Visible    := True;
      lblPrePro.Visible := True;
      lblPrePro.Caption := FloatToStrF(FieldByName('ITE_PREPRO').AsFloat, ffNumber, 12, 2);
    End
    Else
    Begin
      Label2.Visible    := False;
      lblPrePro.Visible := False;
      lblPrePro.Caption := '0,00';
    End;
  End;
end;

class function TfrmFatMostraProdSimilar.fMostraSimilar(strCodSim,
                                                       strCodIteLocate,
                                                       strDesIte,
                                                       strTabPre     : String;
                                                       blnFaturamento: Boolean = False;
                                                       strCodCli     : String = '';
                                                       intPraMed     : Integer = 0) : Boolean;
  Var
    blnEnter : Boolean;
    strAutInc,
    strCodFab,
    strCodIte: String;
begin
  Result := TfrmFatMostraProdSimilar.fMostraSimilar(strCodSim,
                                                    strCodIteLocate,
                                                    strDesIte,
                                                    strTabPre,
                                                    blnEnter,
                                                    strAutInc,
                                                    strCodFab,
                                                    strCodIte,
                                                    False,
                                                    False,
                                                    blnFaturamento,
                                                    False,
                                                    '',
                                                    strCodCli,
                                                    intPraMed);
end;

class function TfrmFatMostraProdSimilar.fMostraSimilar(strCodSim,
                                                       strCodIteLocate,
                                                       strDesIte,
                                                       strTabPre       : String;
                                                       var blnEnter    : Boolean;
                                                       var strAutInc,
                                                           strCodFab,
                                                           strCodIte   : String;
                                                       blnExiCus       : Boolean = False;
                                                       blnDiferente    : Boolean = False;
                                                       blnFaturamento  : Boolean = False;
                                                       blnMostrarMargem: Boolean = False;
                                                       strOpcDoc       : String = '';
                                                       strCodCli       : String = '';
                                                       intPraMed       : Integer = 0;
                                                       strCodEmp       : String = ''):Boolean;
  var
    frmFatMostraProdSimilar : TfrmFatMostraProdSimilar;
    strSql                  : String;
    qryProSim               : TUniQuery;
    dspDados                : TUniDataSetProvider;
    cdsDados                : TUniClientDataSet;
    fltPreCus               : Double;
    fltPreVen               : Double;
    fltComVar               : Double;
    fltComAta               : Double;
    fltComDis               : Double;
    fltQtdDis               : Double;
    blnParticiona           : Boolean;
    blnPromo                : Boolean;
    blnTodasEmpresasCalculadas: Boolean;
    strComPro               : String;
    strCodPro               : String;
    fltDesF07               : Double;
    strEmpTmp: String;
    intIndicador: integer;

  function fGetColumn(strNomCampo : String) : TcxGridDBColumn;
    Var
      intCorre : Integer;
  Begin
    With frmFatMostraProdSimilar Do
    Begin
      Result := Nil;
      For intCorre := 0 to cxgItensTableView.ColumnCount - 1 Do
      Begin
        If cxgItensTableView.Columns[intCorre].DataBinding.FieldName = strNomCampo Then
        Begin
          Result := cxgItensTableView.Columns[intCorre];
          Break;
        End;
      End;
    End;
  End;

begin
  Try
    frmFatMostraProdSimilar := TfrmFatMostraProdSimilar.Create(Application);
    With frmFatMostraProdSimilar Do
    Begin
      ITE_MARBR1.Visible := blnMostrarMargem;

      FEnter       := False;
      FAutInc      := '';
      FCodFab      := '';
      FCodIte      := '';
      FFaturamento := blnFaturamento;
      FTabPre      := strTabPre;
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  I.ITE_CODITE, ';
      strSQL := strSQL + '  I.ITE_DESITE, ';
      strSQL := strSQL + '  I.ITE_REFERE, ';
      strSQL := strSQL + '  U.UNI_SIGUNI, ';
      strSQL := strSQL + '  I.ITE_CODFAB, ';
      strSQL := strSQL + '  I.ITE_CODBAR, ';
      strSQL := strSQL + '  M.MAR_DESMAR, ';

      If fUsaQtdPendenteEntregaFutura Then
        strSQL := strSQL + '  SUM(G.ITE_SALDOS + ' + fGetSQLSomaCamposEntregaFutura('G', FFaturamento) + ') AS ITE_SALDOS, '
      Else
        strSQL := strSQL + '  SUM(G.ITE_SALDOS) AS ITE_SALDOS, ';

      If Not fEmptyStr(strTabPre) Then
        strSQL := strSQL + '  G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN, '
      Else
        strSQL := strSQL + '  G.ITE_PREVE1 AS ITE_PREVEN, ';

      strSQL := strSQL + '  G.ITE_PRECUS, ';
      strSQL := strSQL + '  0.000 AS ITE_SALDIS, ';
      strSQL := strSQL + '   ITE_SALEXT, ';
      strSQL := strSQL + '  G.ITE_MARBR1, ';
      strSQL := strSQL + '  G.ITE_ESTMIN, ';
      strSQL := strSQL + '  G.ITE_ESTMAX, ';
      strSQL := strSQL + '  "N"  AS ITE_PROMOC, ';
      strSQL := strSQL + '  CAST("" AS CHAR(8)) AS ITE_SITUAC, ';
      strSQL := strSQL + '  0.00 AS ITE_PREPRO, ';
      strSQL := strSQL + '  I.AUTOINCREM ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADITE I ';
      strSQL := strSQL + '  INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';
      strSQL := strSQL + '  LEFT  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';
      strSQL := strSQL + '  LEFT  JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';

      strSQL := strSQL + 'WHERE TRUE ';

      If strCodEmp = '' Then
         strCodEmp := VS_strCodEmp;

      If Length(strCodEmp) > 3 Then
      Begin
         strSQL := strSQL + '  AND G.ITE_CODEMP IN(' + strCodEmp + ') ';
         pnlInfo.Caption := 'Empresas Selecionadas: ' + strCodEmp;
      End
      Else
         strSQL := strSQL + '  AND G.ITE_CODEMP = :CODEMP ';

      strSQL := strSQL + '  AND I.ITE_CODSIM = :CODSIM ';
      strSQL := strSQL + '  AND I.ITE_ITEATI = ''S''   ';

      If (Not fCfgSis('ILIEMP', varBoolean)) Or
         ((Pos(strOpcDoc, 'OR_PD') > 0) And (Not fCfgSis('EMPFAT', varBoolean))) Or
         ((strOpcDoc = 'VN') And (Not fCfgSis('EMPFVN', varBoolean))) Then
        strSQL := strSQL + '  AND G.ITE_IMPLIS = ''S'' ';

      If blnDiferente Then
        strSQL := strSQL + '  AND I.ITE_CODITE <> :CODITE ';

      strSQL := strSQL + 'GROUP BY ';
      strSQL := strSQL + '  I.ITE_CODITE ';

      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  I.ITE_DESITE ';


      qryProSim := fCriarQuery(strSQL, frmFatMostraProdSimilar);
      cdsDados  := TUniClientDataSet.Create(frmFatMostraProdSimilar);
      dspDados  := TUniDataSetProvider.Create(frmFatMostraProdSimilar);

      dspDados.DataSet := qryProSim;
      cdsDados.SetProvider(dspDados);
      cdsDados.AfterScroll := pAfterScroll;
      With qryProSim Do
      Begin
        If Length(strCodEmp) <= 3 Then
          ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODSIM').AsString := strCodSim;

        If blnDiferente Then
          ParamByName('CODITE').AsString := strCodIteLocate;

        Open;
        pSetaClient(qryProSim);
      End;

      With cdsDados Do
      Begin
        Open;
        pSetaClient(cdsDados);

        dtsProSim.DataSet := cdsDados;

        (FieldByName('ITE_PREVEN') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat := '#,##0.000';
        (FieldByName('ITE_SALDIS') As TFloatField).DisplayFormat := '#,##0.000';
        (FieldByName('ITE_SALEXT') As TFloatField).DisplayFormat := '#,##0.000';
        (FieldByName('ITE_PRECUS') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARBR1') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_PREPRO') As TFloatField).DisplayFormat := '#,##0.00';

        Result := Not IsEmpty;

        If Result Then
        Begin
          Try
            DisableControls;
            First;
            While not Eof Do
            Begin
              Edit;
              strCodEmp := AnsiReplaceStr(AnsiReplaceStr(strCodEmp, '"', ''), ',', '');
              intIndicador := 1;
              blnTodasEmpresasCalculadas := False;
              While Not blnTodasEmpresasCalculadas do
              Begin
                strEmpTmp := Copy(strCodEmp, intIndicador, 3);
                intIndicador := intIndicador + 3;
                blnTodasEmpresasCalculadas :=  strEmpTmp = '';
                If strEmpTmp <> '' Then
                  FieldByName('ITE_SALDIS').AsFloat  := FieldByName('ITE_SALDIS').AsFloat + fRetornaSaldoDisponivel(FieldByName('ITE_CODITE').AsString,
                                                                              True,           // blnCnvMl
                                                                              FFaturamento,   // blnFaturamento
                                                                              '',
                                                                              True,           // blnConsiderarPedidos
                                                                              strEmpTmp);
                                                                                              // blnConsiderarPedidoCompraPendente = False
                                                                                              // blnConsiderarCfgCalSal = True
              End;

              If fRetornaPrecosPromocao(FieldByName('ITE_CODITE').AsString,
                                        strCodCli,
                                        VS_Date,
                                        1,
                                        0,
                                        0,
                                        intPraMed,
                                        fltPreCus,
                                        fltPreVen,
                                        fltComVar,
                                        fltComAta,
                                        fltComDis,
                                        fltQtdDis,
                                        fltDesF07,
                                        strComPro,
                                        strCodPro,
                                        blnParticiona,
                                        blnPromo,
                                        strTabPre,
                                        '',
                                        '',
                                        '',
                                        False) Then
              Begin
                FieldByName('ITE_PREPRO').AsFloat  := fltPreVen;
                FieldByName('ITE_PROMOC').AsString := IIF(blnPromo, 'S', 'N');

                if (FieldByName('ITE_PROMOC').AsString = 'S') then
                  FieldByName('ITE_SITUAC').AsString := 'PROMO';

              End;

              Post;
              Next;
            End;

          Finally
            Locate('ITE_CODITE', strCodIteLocate, []);
            EnableControls;
          End;

          edtItem.Text := strCodIteLocate + ' - ' + strDesIte;

          If fGetColumn('ITE_DESITE').Width > 450 Then
            fGetColumn('ITE_DESITE').Width := 450;

          fGetColumn('ITE_PRECUS').Visible := blnExiCus;
          
          If (RecordCount = 1) And (FieldByName('ITE_CODITE').AsString = strCodIteLocate) Then
          Begin
            FAutInc := Fieldbyname('AUTOINCREM').asString;
            FCodFab := Fieldbyname('ITE_CODFAB').asString;
            FCodIte := Fieldbyname('ITE_CODITE').asString;
          End
          Else
            ShowModal;

          blnEnter  := FEnter;
          strAutInc := FAutInc;
          strCodFab := FCodFab;
          strCodIte := FCodIte;
        End;
      End;
    End;
  Finally
    FreeAndNil(cdsDados);
    FreeAndNil(dspDados);
    FreeAndNil(qryProSim);
    FreeAndNil(frmFatMostraProdSimilar);
  End;
end;

end.
