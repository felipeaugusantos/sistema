{*********************************************************}
{* ITENS AGREGADOS                                       *}
{*                                                       *}
{* DATA......: 19/03/2008                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI "FALTA MUITO???" *}
{*                                                       *}
{******************************************************AF*}
unit untFatProdAgregados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, Uni,
  UniClientDataSet, UniDataSetProvider, DB, AppEvnts, untFuncFat, Math, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, untFuncFatTypes, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, untSalvaConfiguracaoGrid;

type
  TfrmFatProdAgregados = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    lblLegenda: TLabel;
    pnlDescricaoItem: TPanel;
    lblDesIteTit: TLabel;
    lblDesIte: TLabel;
    shpInfLot: TShape;
    lblInfLot: TLabel;
    cxgItens: TcxGridCitel;
    cxgItensTableView: TcxGridDBTableViewCitel;
    CODITE: TcxGridDBColumn;
    DESITE: TcxGridDBColumn;
    REFERE: TcxGridDBColumn;
    DESMAR: TcxGridDBColumn;
    CODFAB: TcxGridDBColumn;
    SALDOS: TcxGridDBColumn;
    SALDIS: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    NUMLOT: TcxGridDBColumn;
    UNIDAD: TcxGridDBColumn;
    QTDITE: TcxGridDBColumn;
    UNITAR: TcxGridDBColumn;
    PERDES: TcxGridDBColumn;
    TOTITE: TcxGridDBColumn;
    PAIFIL: TcxGridDBColumn;
    SITUAC: TcxGridDBColumn;
    COMPLE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cxgItensTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgItensTableViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxgItensTableViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensTableViewKeyPress(Sender: TObject; var Key: Char);
    procedure cxgItensTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    blnSomenteUnitarioAcimaDoSugerido: Boolean;
    intRecNo : Integer;
    fltUnitarAnt : Double;
    blnUtiWms: Boolean;
    blnExiLot: Boolean;

    blnPermiteEditarDesconto: Boolean;
    blnPermiteEditarPrecoUnitario: Boolean;
    procedure pAfterScroll(Dataset: TDataset);
    procedure pBeforePost(Dataset: TDataset);
    procedure pDataChange(Sender: TObject; Field: TField);
    function fPegaPrecoVendaAgregado: Double;
    procedure pBeforeEdit(DataSet: TDataSet);
    procedure pAjustaTamanhoDescricaoItemGrid;
  public
    { Public declarations }
    strCodIte: String;
    strDesIte: String;
    strTabPre: String;
    strQtdIte: String;
    strIdePro: String;
    strCodEmp: String;
    qryProAgr: TUniQuery;
    dtsProAgr: TDataSource;
    cdsProAgr: TUniClientDataSet;
    cpvProAgr: TUniDataSetProvider;
    blnExiCompl: Boolean;
    fatVenda: TFatVenda;
    blnfValidaMultiploVenda: Boolean;

    function fCarregaItensAgregados : Boolean;
    class function fGetSQLItensAgregados(strCodIte, strCodEmp: String; strTabPre: String; fatVenda: TFatVenda = nil): String;
  end;

var
  frmFatProdAgregados: TfrmFatProdAgregados;

implementation

uses  untfuncoesSimples, untCadPro, untIFatEntregaFutura, untTFatEntregaFutura,
      untTypesSistema, untConsultas, untCadLote;

{$R *.dfm}

procedure TfrmFatProdAgregados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxgItensTableView, Self.Name);
end;

procedure TfrmFatProdAgregados.FormCreate(Sender: TObject);
begin
  inherited;
  blnSomenteUnitarioAcimaDoSugerido := False;

  blnUtiWms := fUsaRotinaWMS(VS_strCodEmp);
  blnExiLot := False;

  qryProAgr := fCriaQuery(Self);

  cpvProAgr := TUniDataSetProvider.Create(Self);
  cpvProAgr.DataSet := qryProAgr;

  cdsProAgr := TUniClientDataSet.Create(Self);
  cdsProAgr.SetProvider(cpvProAgr);
  cdsProAgr.BeforePost  := pBeforePost;
  cdsProAgr.BeforeEdit := pBeforeEdit;

  dtsProAgr := fCriaDataSource(cdsProAgr);
  dtsProAgr.OnDataChange:=pDataChange;
  cxgItensTableView.DataController.DataSource := dtsProAgr;
  blnfValidaMultiploVenda := False;
  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxgItensTableView, Self.Name);
end;

procedure TfrmFatProdAgregados.FormResize(Sender: TObject);
begin
  inherited;
  pAjustaTamanhoDescricaoItemGrid;
end;

{**************************************}
{* CARREGA ITENS AGREGADOS            *}
{***********************************AF*}
function TfrmFatProdAgregados.fCarregaItensAgregados : Boolean;
  Var
    objCadLot   : TCadLot;
begin
  objCadLot := TCadLot.Create(Self);

  Try
    cdsProAgr.Close;

    With qryProAgr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLItensAgregados(strCodIte, strCodEmp, strTabPre, fatVenda));
      Open;
      Result := not IsEmpty;
    End;

    pSetaClient(qryProAgr);

    cdsProAgr.SetProvider(cpvProAgr);
    cdsProAgr.Open;

    cdsProAgr.First;
    While Not cdsProAgr.Eof Do
    Begin
      cdsProAgr.Edit;

      {********************************************}
      {*CONFIGURADO PARA TRAZER A MESMA QUANTIDADE*}
      {*DE PRODUTOS INFORMADOS NA TELA PRINCIPAL  *}
      {*****************************************PZ*}
      If (fCfgSis('PROAGR') = '1') Then
        cdsProAgr.FieldByName('QTDITE').AsString := strQtdIte;

      cdsProAgr.FieldByName('UNITAR').AsFloat  := fPegaPrecoVendaAgregado;
      cdsProAgr.FieldByName('PROMOC').AsString := fatVenda.strPromoc;

      If (fatVenda.strPromoc = 'S') Then
        cdsProAgr.FieldByName('SITUAC').AsString := 'PROMO'
      Else
        cdsProAgr.FieldByName('SITUAC').AsString := '';

      If fUsaQtdPendenteEntregaFutura Then
        cdsProAgr.FieldByName('SALDOS').AsFloat := cdsProAgr.FieldByName('SALDOS').AsFloat +
          TEntregaFutura.New(
            TParamEF.New()
              .CodIte(cdsProAgr.FieldByName('CODITE').AsString)
              .CodEmp(strCodEmp)
              .Faturamento(True)
            ).Total();

      cdsProAgr.FieldByName('SALDIS').AsFloat := fRetornaSaldoDisponivel(cdsProAgr.FieldByName('CODITE').AsString,
                                                                         True,
                                                                         True,
                                                                         '',
                                                                         True,
                                                                         strCodEmp);

      cdsProAgr.FieldByName('NUMLOT').AsString := '';
      If (Not blnUtiWms) And
         (cdsProAgr.FieldByName('TEMLOT').AsString = 'S') And
         (fCfgSis('LOTPAG', varBoolean)) Then
      Begin
        cdsProAgr.FieldByName('NUMLOT').AsString := objCadLot.fRetArmazemPrincipalOrcamentoPedidoVenda(cdsProAgr.FieldByName('CODITE').AsString) ;
      End
      Else If blnUtiWms And (cdsProAgr.FieldByName('TEMLOT').AsString = 'S') Then
        cdsProAgr.FieldByName('NUMLOT').AsString := 'A DEFINIR';

      cdsProAgr.FieldByName('COMPLE').AsString := '';

      If (Not blnUtiWms) And (cdsProAgr.FieldByName('TEMLOT').AsString = 'S') Then
        blnExiLot := True;

      cdsProAgr.Post;
      cdsProAgr.Next;
    End;

    cdsProAgr.AfterScroll := pAfterScroll;

    cdsProAgr.First;

    pAfterScroll(cdsProAgr);

    cxgItensTableView.GetColumnByFieldName('CODITE').Options.Editing := False;
    cxgItensTableView.GetColumnByFieldName('DESITE').Options.Editing := False;
    cxgItensTableView.GetColumnByFieldName('UNIDAD').Options.Editing := False;
    cxgItensTableView.GetColumnByFieldName('SALDOS').Options.Editing := False;
    cxgItensTableView.GetColumnByFieldName('SALDIS').Options.Editing := False;

    (cdsProAgr.FieldByName('SALDOS') As TFloatField).DisplayFormat := '#,##0.000';

    (cdsProAgr.FieldByName('QTDITE') AS TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (cdsProAgr.FieldByName('QTDITE') AS TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECQTD', varInteger));

    (cdsProAgr.FieldByName('UNITAR') AS TFloatField).DisplayFormat := '#,##0.00';
    (cdsProAgr.FieldByName('UNITAR') AS TFloatField).EditFormat    := '#,##0.00';

    (cdsProAgr.FieldByName('TOTITE') AS TFloatField).DisplayFormat := '#,##0.00';
    (cdsProAgr.FieldByName('TOTITE') AS TFloatField).EditFormat    := '#,##0.00';

    (cdsProAgr.FieldByName('PERDES') AS TFloatField).DisplayFormat := '#,##0.00';
    (cdsProAgr.FieldByName('PERDES') AS TFloatField).EditFormat    := '#,##0.00';

    (cdsProAgr.FieldByName('SALDIS') AS TFloatField).DisplayFormat := '#,##0.000';
    (cdsProAgr.FieldByName('SALDIS') AS TFloatField).EditFormat    := '#,##0.000';

  Finally
    FreeAndNil(objCadLot);
  End;
end;

class function TfrmFatProdAgregados.fGetSQLItensAgregados(strCodIte, strCodEmp: String; strTabPre: String; fatVenda: TFatVenda = nil): String;
Var
  strSQL: String;
  strSQLInner: String;
begin
  {**********************************************}
  {* CARREGA ITENS FILHOS DOS AGRUPAMENTOS CUJO *}
  {* ITEM INCLUIDO SEJA PAI                     *}
  {*******************************************VA*}
  strSQLInner := ' SELECT AGR_CODITE, '+
                 '        "Filho" AS PAIFIL '+
                 '   FROM CADAGR ' +
                 '  INNER JOIN (SELECT AGR_CODAGR '+
                 '                FROM CADAGR '+
                 '               WHERE AGR_CODITE = '+QuotedStr(strCodIte)+
                 '                 AND AGR_ITEPAI = ''S'') AS TAB001 ON (TAB001.AGR_CODAGR = CADAGR.AGR_CODAGR) '+
                 '  WHERE AGR_ITEPAI = ''N'' ';

  {**********************************************}
  {* CARREGA ITENS PAIS DOS AGRUPAMENTOS CUJO   *}
  {* ITEM INCLUIDO SEJA FILHO                   *}
  {*******************************************VA*}

  {
    CFG_AGRPRO =
    1-) Se for informado um PAI, sugere todos os filhos. Se for informado um FILHO, sugere todos os pais.
    2-) Se for informado um PAI, sugere todos os filhos. Se for informado um FILHO, não sugere nenhum produto.
  }

  If fCfgSis('AGRPRO', varInteger) = 1 then
  begin
    strSQLInner := strSQLInner + ' UNION ALL '+
                                 'SELECT AGR_CODITE, '+
                                 '       "Pai" AS PAIFIL '+
                                 '  FROM CADAGR ' +
                                 ' INNER JOIN (SELECT AGR_CODAGR '+
                                 '               FROM CADAGR '+
                                 '              WHERE AGR_CODITE = '+ QuotedStr(strCodIte)+
                                 '                AND AGR_ITEPAI = ''N'') AS TAB002 ON (TAB002.AGR_CODAGR = CADAGR.AGR_CODAGR) '+
                                 ' WHERE AGR_ITEPAI = ''S'' ';
  end;

  strSQLInner:=' INNER JOIN ('+strSQLInner+') AS A ON (A.AGR_CODITE=I.ITE_CODITE) ';

  strSQL := '';
  strSQL := strSQL + 'SELECT DISTINCT ';
  strSQL := strSQL + '  IF((SELECT COUNT(*) FROM CADLOT WHERE LOT_CODITE = I.ITE_CODITE AND LOT_CODEMP = G.ITE_CODEMP) > 0, "S", "N") AS TEMLOT, ';
  strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '  M.MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '  G.ITE_SALDOS AS SALDOS, ';
  strSQL := strSQL + '  0.000        AS SALDIS, ';
  strSQL := strSQL + '  CAST("" AS CHAR(8)) AS SITUAC, ';

  strSQL := strSQL + '  I.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  U.UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '  0.00         AS QTDITE, ';
  strSQL := strSQL + '  0.00         AS QTDANT, ';

  If Assigned(fatVenda) Then
  Begin
    If (Pos(fatVenda.strOpcDoc, 'OU_OF_')) > 0 then
    Begin
      If (fCfgSis('PROSOE') = 'C') then
      Begin
        strSQL := strSQL + '  G.ITE_PRECUS AS UNIORI, '
      End
      Else If (fCfgSis('PROSOE') = 'M') then
      Begin
        strSQL := strSQL + '  G.ITE_PREMED AS UNIORI, '
      End
      Else
      Begin
        strSQL := strSQL + '  G.ITE_PREVE' + strTabPre + ' AS UNIORI, ';
      End;
    End
    Else If (Pos(fatVenda.strOpcDoc, 'OE_EF_')) > 0 then
    Begin
      If (fCfgSis('PROENT') = 'C') then
      Begin
        strSQL := strSQL + '  G.ITE_PRECUS AS UNIORI, '
      End
      Else If (fCfgSis('PROENT') = 'M') then
      Begin
        strSQL := strSQL + '  G.ITE_PREMED AS UNIORI, '
      End
      Else
      Begin
        strSQL := strSQL + '  G.ITE_PREVE' + strTabPre + ' AS UNIORI, ';
      End;
    End
    Else
    Begin
      strSQL := strSQL + '  G.ITE_PREVE' + strTabPre + ' AS UNIORI, ';
    End;
  End
  Else
    strSQL := strSQL + '  G.ITE_PREVE' + strTabPre + ' AS UNIORI, ';

  strSQL := strSQL + '  0.0000       AS UNITAR, ';

  strSQL := strSQL + '  0.00         AS PERDES, ';
  strSQL := strSQL + '  0.00         AS TOTITE, ';
  strSQL := strSQL + '  A.PAIFIL,               ';
  strSQL := strSQL + '  "N"          AS PROMOC, ';
  strSQL := strSQL + '  CAST("" AS CHAR(20)) AS NUMLOT, ';
  strSQL := strSQL + '  CAST("" AS CHAR(60)) AS COMPLE, ';
  strSQL := strSQL + '  I.ITE_MLTVEN            ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + '  INNER JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND G.ITE_CODEMP = "' + strCodEmp + '" ';
  strSQL := strSQL + '  LEFT  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';

  strSQL := strSQL + strSQLInner;

  strSQL := strSQL + '  ORDER BY A.PAIFIL DESC, I.ITE_DESITE  ';

  Result := strSQL;
end;

procedure TfrmFatProdAgregados.pDataChange(Sender: TObject; Field: TField);
begin
  inherited;

  If Not cdsProAgr.IsEmpty Then
  Begin
    lblLegenda.Caption :='(*) = Item '+dtsProAgr.DataSet.FieldByName('PAIFIL').AsString+' de: '+strCodIte+' - '+strDesIte;
    lblDesIte.Caption := dtsProAgr.DataSet.FieldByName('CODITE').AsString + ' - ' +
       dtsProAgr.DataSet.FieldByName('DESITE').AsString;
  End;
end;

procedure TfrmFatProdAgregados.cxgItensTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
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

  If cdsProAgr.FieldByName('QTDITE').AsFloat > 0 Then
  Begin
    ACanvas.Font.Color := clBlue;
  End;

  If AViewInfo.Item.Caption = 'Situação' Then
  Begin

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, SITUAC.Index]) = 'PROMO' Then
    Begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.FillRect(AViewInfo.Bounds);
    End;

  End;

  If (AViewInfo.Item.Caption = 'Lote') Then
  begin
    If (cdsProAgr.FieldByName('TEMLOT').AsString = 'S') Then
    Begin
      If (fEmptyStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, NUMLOT.Index]))) Then
      Begin
        ACanvas.Brush.Color := shpInfLot.Brush.Color;
        ACanvas.FillRect(AViewInfo.Bounds);
      End;
    End;
  End;

end;

procedure TfrmFatProdAgregados.cxgItensTableViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  cxgItensTableViewKeyDown(Sender, Key, Shift);
end;

procedure TfrmFatProdAgregados.cxgItensTableViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  cxgItensTableViewKeyPress(Sender, Key);
end;

procedure TfrmFatProdAgregados.cxgItensTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Var
    blnTemLote: Boolean;
begin
  inherited;

  Case Key Of

    VK_Insert : Key := 0;
    VK_Delete : Key := 0;
    VK_Escape : btnSair.Click;
    VK_F10    : btnGravar.Click;
    VK_Return : Begin

                  blnTemLote := (blnUtiWms Or (blnExiLot And (cdsProAgr.FieldByName('TEMLOT').AsString = 'S')));

                  If cdsProAgr.State = dsEdit Then
                  Begin
                    cdsProAgr.Post;
                    If (blnTemLote) And
                       (cxgItensTableView.Controller.FocusedColumn.Name = 'NUMLOT') And
                       (cxgItensTableView.GetColumnByFieldName('QTDITE').Options.Editing) Then
                    Begin
                      cdsProAgr.Edit;
                      cxgItensTableView.GetColumnByFieldName('QTDITE').Focused := True;
                    End
                    Else If (cxgItensTableView.Controller.FocusedColumn.Name = 'QTDITE') And
                            (cxgItensTableView.GetColumnByFieldName('PERDES').Options.Editing) Then
                    Begin
                      cxgItensTableView.Controller.FocusedColumn.Options.Editing:= True;
                      cdsProAgr.Edit;
                      cxgItensTableView.GetColumnByFieldName('PERDES').Focused := True;
                    End
                    Else If (blnExiCompl) And
                            (cxgItensTableView.Controller.FocusedColumn.Name = 'PERDES') And
                            (cxgItensTableView.GetColumnByFieldName('COMPLE').Options.Editing) Then
                    Begin
                      cxgItensTableView.Controller.FocusedColumn.Options.Editing := True;
                      cdsProAgr.Edit;
                      cxgItensTableView.GetColumnByFieldName('COMPLE').Focused := True;
                     End;
                  End
                  Else
                  Begin
                    cdsProAgr.Edit;
                    If (blnTemLote) Then
                       cxgItensTableView.GetColumnByFieldName('NUMLOT').Focused := True
                    Else
                      cxgItensTableView.GetColumnByFieldName('QTDITE').Focused := True;
                  End;

                End;

  End;

end;

procedure TfrmFatProdAgregados.cxgItensTableViewKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel  : TConsultasArray;
  qryLote : TUniQuery;
  fltValor: Double;
begin

  inherited;

  Key := UpCase(key);

  If (blnUtiWms Or (blnExiLot And (cdsProAgr.FieldByName('TEMLOT').AsString = 'S'))) Then
  Begin
    If (cxgItensTableView.Controller.FocusedColumn.Name <> 'NUMLOT') Then
      Exit;

    If Not fEntraCons(Key) Then
      Exit;

    qryLote := fCriaQuery();

    Try

      If fPesqLoteFat(Self,
                      Nil,
                      fCfgSis('DECUNI'),
                      cdsProAgr.FieldByName('CODITE').AsString,
                      False,
                      False,
                      qryLote,
                      Key,
                      arrSel,
                      strCodEmp) Then
      Begin

        If cdsProAgr.State <> dsEdit Then
          cdsProAgr.Edit;

        cdsProAgr.FieldByName('NUMLOT').AsString := qryLote.FieldByName('LOT_NUMLOT').AsString;
        cdsProAgr.Post;

      End;

    Finally
      FreeAndNil(qryLote);
    End;
  End;

  If (Ord(Key) = VK_RETURN) And blnfValidaMultiploVenda And (cdsProAgr.FieldByName('QTDITE').AsFloat > 0) Then
  Begin
    If cdsProAgr.FieldByName('QTDITE').AsFloat < cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat Then
    Begin
      fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3), ['&OK']);
      cdsProAgr.Edit;
      cdsProAgr.FieldByName('QTDITE').AsFloat := fFormataFloat(cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat, fCfgSis('DECQTD', VarInteger));
      cdsProAgr.Post;
    End
    Else
    Begin
      fltValor := fFormataFloatInterna(cdsProAgr.FieldByName('QTDITE').AsFloat / cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat, 4);

      If (fltValor - Int(fltValor)) > 0 Then
      Begin
        fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3), ['&OK']);

        fltValor  := cdsProAgr.FieldByName('QTDITE').AsFloat;
        fltValor  := Int( ( ( fltValor + cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat ) / cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat ) ) * cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat;
        cdsProAgr.Edit;
        cdsProAgr.FieldByName('QTDITE').AsFloat := fFormataFloat(fltValor, fCfgSis('DECQTD', varInteger));
        cdsProAgr.Post;
      End;
    End;
  End;


end;

procedure TfrmFatProdAgregados.pAfterScroll(Dataset: TDataset);
begin
  blnSomenteUnitarioAcimaDoSugerido := False;
  blnPermiteEditarDesconto := False;
  blnPermiteEditarPrecoUnitario := False;

  If Assigned(fatVenda) Then
    With fatVenda, DataSet Do
    Begin
      blnPermiteEditarDesconto      := fPermiteEditarDesconto( strOpcDoc, FieldByName('PROMOC').AsString, blnCliFil,
                                                               FieldByName('CODITE').AsString = fCfgSis('ITEVID'),
                                                               fEhDevolucaoEspelhoOuParaFornecedor, False );

      blnPermiteEditarPrecoUnitario := fPermiteEditarPrecoUnitario( strOpcDoc, strCodCnd, strCodCli, FieldByName('PROMOC').AsString,
                                                                    strTabPre, False, FieldByName('CODITE').AsString = fCfgSis('ITEVID'),
                                                                    fEhDevolucaoEspelhoOuParaFornecedor,
                                                                    blnSomenteUnitarioAcimaDoSugerido );
    End;

  cxgItensTableView.GetColumnByFieldName('PERDES').Options.Editing := blnPermiteEditarDesconto;
  cxgItensTableView.GetColumnByFieldName('UNITAR').Options.Editing := blnPermiteEditarPrecoUnitario;

  intRecNo := Dataset.RecNo;
end;

procedure TfrmFatProdAgregados.pBeforeEdit(DataSet: TDataSet);
begin
  fltUnitarAnt := DataSet.FieldByName('UNITAR').AsFloat;
end;

procedure TfrmFatProdAgregados.pBeforePost(Dataset: TDataset);
  Var
    fltTotDes: Double;
begin
  If Dataset.FieldByName('CODITE').AsString = '' Then
  Begin
    Dataset.Cancel;
    Abort;
  End;

  If Dataset.FieldByName('QTDITE').AsString = '' Then
    Dataset.FieldByName('QTDITE').AsFloat := 0.0;

  If Dataset.FieldByName('QTDITE').AsFloat <> Dataset.FieldByName('QTDANT').AsFloat Then
  Begin
    Dataset.FieldByName('QTDANT').AsFloat  := Dataset.FieldByName('QTDITE').AsFloat;
    Dataset.FieldByName('UNITAR').AsFloat  := fPegaPrecoVendaAgregado;
    Dataset.FieldByName('PROMOC').AsString := fatVenda.strPromoc;
  End;

  If (SameText(cxgItensTableView.Controller.FocusedColumn.Name, 'UNITAR')) And
     (blnSomenteUnitarioAcimaDoSugerido) And
     (fltUnitarAnt <> Dataset.FieldByName('UNITAR').AsFloat) Then
  Begin
    If fFormataFloat(Dataset.FieldByName('UNITAR').AsFloat, fCfgSis('DECUNI', varInteger)) < fFormataFloat(fltUnitarAnt, fCfgSis('DECUNI', varInteger)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Unitário deve ser maior ou igual a ' + FloatToStr(fltUnitarAnt) + '!', ['&OK']);
      Dataset.Cancel;
      Abort;
    End;
  End;

  fltTotDes := ((Dataset.FieldByName('UNITAR').AsFloat * Dataset.FieldByName('PERDES').AsFloat) / 100) * Dataset.FieldByName('QTDITE').AsFloat;
  Dataset.FieldByName('TOTITE').AsFloat := Dataset.FieldByName('QTDITE').AsFloat * Dataset.FieldByName('UNITAR').AsFloat - fltTotDes;
end;

procedure TfrmFatProdAgregados.FormShow(Sender: TObject);
 Var
   intCont : Integer;
begin
  inherited;

  For intCont := 0 to cxgItensTableView.ColumnCount -1 do
  Begin
    If (cxgItensTableView.Columns[intCont].DataBinding.FieldName = 'NUMLOT') Then
      cxgItensTableView.Columns[intCont].Visible := (blnUtiWms Or blnExiLot);

    If (cxgItensTableView.Columns[intCont].DataBinding.FieldName = 'DESITE') And (Not (blnUtiWms Or blnExiLot)) Then
      cxgItensTableView.Columns[intCont].Width := (cxgItensTableView.Columns[intCont].Width + 64);

    If (cxgItensTableView.Columns[intCont].DataBinding.FieldName = 'COMPLE') Then
      cxgItensTableView.Columns[intCont].Visible := (blnExiCompl);
  End;

  shpInfLot.Visible := blnUtiWms Or blnExiLot;
  lblInfLot.Visible := blnUtiWms Or blnExiLot;

  cxgItensTableView.Zebra := False;
  cxgItensTableView.CorZebra := strToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
  cxgItensTableView.Destaque := False;

  pAjustaTamanhoDescricaoItemGrid;
  pSetFocus(cxgItens);
end;

procedure TfrmFatProdAgregados.btnGravarClick(Sender: TObject);
var
  fltValor: Double;
begin
  inherited;

  If (blnUtiWms Or blnExiLot) Then
  Begin
    cdsProAgr.DisableControls;
    Try
      cdsProAgr.First;
      While Not cdsProAgr.Eof Do
      Begin

        If ((blnUtiWms) Or (blnExiLot And (cdsProAgr.FieldByName('TEMLOT').AsString = 'S'))) And ((cdsProAgr.FieldByName('QTDITE').AsFloat) > 0)  Then
        Begin
          If fEmptyStr(cdsProAgr.FieldByName('NUMLOT').AsString) Then
          Begin
            fMensagem('ATENÇÃO!', 'Informe os lotes para todos os produtos agregados!', ['&OK']);
            Exit;
          End
          Else
          Begin
            If Not fExisteLote(cdsProAgr.FieldByName('NUMLOT').AsString,
                               cdsProAgr.FieldByName('CODITE').AsString,
                               strCodEmp) Then
            Begin
              fMensagem('ATENÇÃO!', 'Lote: ' + cdsProAgr.FieldByName('NUMLOT').AsString + ' não cadastrado para o item: ' + cdsProAgr.FieldByName('CODITE').AsString, ['&OK']);
              Exit;
            End;
          End;
        End;

        If blnfValidaMultiploVenda And (cdsProAgr.FieldByName('QTDITE').AsFloat > 0) Then
        Begin
          If cdsProAgr.FieldByName('QTDITE').AsFloat < cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat Then
          Begin
            fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3), ['&OK']);
            cdsProAgr.Edit;
            cdsProAgr.FieldByName('QTDITE').AsFloat := fFormataFloat(cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat, fCfgSis('DECQTD', VarInteger));
            cdsProAgr.Post;
            Break;
            Exit;
          End
          Else
          Begin
            fltValor := fFormataFloatInterna(cdsProAgr.FieldByName('QTDITE').AsFloat / cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat, 4);

            If (fltValor - Int(fltValor)) > 0 Then
            Begin
              fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3), ['&OK']);

              fltValor  := cdsProAgr.FieldByName('QTDITE').AsFloat;
              fltValor  := Int( ( ( fltValor + cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat ) / cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat ) ) * cdsProAgr.FieldByName('ITE_MLTVEN').AsFloat;
              cdsProAgr.Edit;
              cdsProAgr.FieldByName('QTDITE').AsFloat := fFormataFloat(fltValor, fCfgSis('DECQTD', varInteger));
              cdsProAgr.Post;

              Break;
              Exit;
            End;
          End;
        End;

        cdsProAgr.Next;
      End;
    Finally
      cdsProAgr.EnableControls;
    End;
  End;

  Close;
  ModalResult := mrOk;
end;

function TfrmFatProdAgregados.fPegaPrecoVendaAgregado: Double;
  Var
    blnParticiona: Boolean;
    blnPromo     : Boolean;
    fltQtdDis    : Double;
    qryConIte    : TUniQuery;
    fltDesMax    : Double;
begin

  blnParticiona := False;
  blnPromo      := False;
  fatVenda.strPromoc := 'N';

  Result := cdsProAgr.FieldByName('UNIORI').AsFloat;

  If (Not fatVenda.blnCliFil) Then
  Begin

    If (fRetornaPrecosPromocao(cdsProAgr.FieldByName('CODITE').AsString,
                               fatVenda.strCodCli,
                               VS_Date,
                               Max(cdsProAgr.FieldByName('QTDITE').AsFloat, 1),
                               0,
                               0,
                               fatVenda.intPrzMed,
                               fatVenda.fltProPreCus,
                               fatVenda.fltProPreVen,
                               fatVenda.fltProComVar,
                               fatVenda.fltProComAta,
                               fatVenda.fltProComDis,
                               fltQtdDis,
                               fatVenda.fltProDesF07,
                               fatVenda.strComPro,
                               fatVenda.strCodPro,
                               blnParticiona,
                               blnPromo,
                               fatVenda.strTabPre,
                               fatVenda.strCodCnd)) Then
    Begin
      If Not blnParticiona Then
        fatVenda.strPromoc := 'S';
    End;

  End
  Else
  Begin
    qryConIte := fCriarQueryIteGer(Self);
    qryConIte.ParamByName('CODITE').AsString := cdsProAgr.FieldByName('CODITE').AsString;
    qryConIte.ParamByName('CODEMP').AsString := strCodEmp;
    qryConIte.Open;

    If Not qryConIte.IsEmpty Then
    Begin
      Result := fFormataFloat(fatVenda.fPegaPrecoVenda(qryConIte,
                                                       qryConIte.ParamByName('CODEMP').AsString,
                                                       'S',
                                                       fatVenda.fltMargem,
                                                       False,
                                                       fatVenda.strIdePro,
                                                       strTabPre),
                                                       fCfgSis('DECUNI', varInteger));
    End;

    FreeAndNil(qryConIte);
  End;

  If (strIdePro = 'NOR') And
     (fatVenda.strPromoc = 'S') And
     (fatVenda.fRegraPrecoSugestaoAtiva = TRegraPrecoSugestao.PrecoDePromocao) Then
  begin
    Result := fatVenda.fltProPreVen;
  end;

  If (fatVenda.fAplicaTaxaJuros And fAplicarTaxaJurosPrecoSugestao) Then
    Result := Result + fFormataFloat(Result * (fatVenda.fGetTaxVprItem(cdsProAgr.FieldByName('CODITE').AsString) / 100.0), fCfgSis('DECUNI', varInteger));

  If (fatVenda.strCAbDes = 'S') And
     (fCfgSis('CNDVEN') = 'I') And
     ((fatVenda.strPromoc <> 'S') Or (fatVenda.fRegraPrecoSugestaoAtiva = TRegraPrecoSugestao.PrecoDeTabela)) And
     (Not fAplicarTaxaJurosPrecoDigitado) Then
  Begin
    fltDesMax := fatVenda.fRetornaDescLinGru(cdsProAgr.FieldByName('CODITE').AsString, fatVenda.strCodCnd);

    If (fatVenda.strCodFpg = '007') Then
    Begin
      If (fatVenda.strAbDeCc = 'S') Then
        Result := Result - fatVenda.fRetornaVrDesconto(2, Result, fltDesMax);
    End
    Else
      Result := Result - fatVenda.fRetornaVrDesconto(2, Result, fltDesMax);
  End;

end;

procedure TfrmFatProdAgregados.pAjustaTamanhoDescricaoItemGrid;
var
  intColumn: Integer;
  intTamUti: Integer;
const
  intValMin: Integer = 100;
begin

  intTamUti := 0;
  For intColumn := 0 To cxgItensTableView.ColumnCount -1 Do
    With cxgItensTableView.Columns[intColumn] Do
      If Visible And (DataBinding.FieldName <> 'DESITE') Then
        Inc(intTamUti, Width);

  {Obrigatório tamanho mínimo, senão deixa barra de rolagem horizontal}
  If (cxgItens.Width - intTamUti - 60) >= intValMin Then
    cxgItensTableView.GetColumnByFieldName('DESITE').Width := (cxgItens.Width - intTamUti - 60)
  Else
    cxgItensTableView.GetColumnByFieldName('DESITE').Width  := intValMin;
end;

end.
