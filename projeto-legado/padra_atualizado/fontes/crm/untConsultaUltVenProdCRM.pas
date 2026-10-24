unit untConsultaUltVenProdCRM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, UniClientDataSet, UniDataSetProvider, UITypes,
  Uni, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  DateUtils, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmConsultaUltVenProdCRM = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    dbgUltimasVendas: TcxGrid;
    dbgUltimasVendasDBTableView1: TcxGridDBTableView;
    dbgUltimasVendasLevel1: TcxGridLevel;
    dspUltVendas: TUniDataSetProvider;
    dtsUltVendas: TDataSource;
    qryUltVendas: TUniQuery;    
    dbgUltimasVendasDBTableView1QTDITE: TcxGridDBColumn;
    dbgUltimasVendasDBTableView1PR_TOTAL: TcxGridDBColumn;
    dbgUltimasVendasDBTableView1DTA_MOV: TcxGridDBColumn;
    dbgUltimasVendasDBTableView1HOR_MOV: TcxGridDBColumn;
    dbgUltimasVendasDBTableView1NUMDOC: TcxGridDBColumn;
    dbgUltimasVendasDBTableView1ESPDOC: TcxGridDBColumn;
    dbgUltimasVendasDBTableView1CODEMP: TcxGridDBColumn;
    dbgUltimasVendasDBTableView1CLIENTE: TcxGridDBColumn;
    dbgUltimasVendasDBTableView1CODITE: TcxGridDBColumn;
    dbgUltimasVendasDBTableView1CODGRU: TcxGridDBColumn;
    dbgUltimasVendasDBTableView1PR_UNITARIO: TcxGridDBColumn;
    dbgUltimasVendasDBTableView1VENDEDOR: TcxGridDBColumn;
    pnlBotoesInferiores: TPanel;
    cdsUltVendas: TUniClientDataSet;
    cdsUltVendasQTDITE: TFloatField;
    cdsUltVendasPR_TOTAL: TFloatField;
    cdsUltVendasDTA_MOV: TDateField;
    cdsUltVendasHOR_MOV: TTimeField;
    cdsUltVendasNUMDOC: TStringField;
    cdsUltVendasESPDOC: TStringField;
    cdsUltVendasCODEMP: TStringField;
    cdsUltVendasCLIENTE: TStringField;
    cdsUltVendasCODITE: TStringField;
    cdsUltVendasCODGRU: TStringField;
    cdsUltVendasPR_UNITARIO: TFloatField;
    cdsUltVendasVENDEDOR: TStringField;
    cdsUltVendasFORCLI: TStringField;
    cdsUltVendasTIP_FC: TStringField;
    cdsUltVendasSERIE_: TStringField;
    shpMais12: TShape;
    Label7: TLabel;
    shpVencida: TShape;
    Label11: TLabel;
    btnSairBaixa: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    shpOk: TShape;
    Label1: TLabel;
    cdsUltVendasQTDORI: TFloatField;
    cdsUltVendasSEQORI: TStringField;
    cdsUltVendasQTDCNV: TFloatField;
    cdsUltVendasQTDDEV: TFloatField;
    cdsUltVendasQTDADE: TFloatField;
    cdsUltVendasQTDFIS: TFloatField;
    procedure btnSairBaixaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgUltimasVendasDBTableView1DblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsUltVendasAfterScroll(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgUltimasVendasDBTableView1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure dbgUltimasVendasDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    FCodIte: String;
    FCodEmp: String;
    FCodCli: String;
    FDiasGa: Integer;

    procedure pConfirma;
    procedure pOcultaObjetos(const Value:Boolean);
    function fQuantidadeTotalIteDocumento: Double;
    procedure pCalculaTotaisQuantidadePorItem;
    function fRetornaQtdAde(): Double;
    function fRetornaQtdGarantia(): Double;
    function fRetornaQtdDev: Double;
  protected
    function getCodIte: String;
    function getCodEmp: String;
    function getCodCli: String;
    function getDiasGa: Integer;

    procedure setCodIte(const Value: String);
    procedure setCodEmp(const Value: String);
    procedure setCodCli(const Value: String);
    procedure setDiasGa(const Value: Integer);

  public
    { Public declarations }
    strNumDoc: String;
    strEspDoc: String;
    dtaDtaMov: TDate;
    fltQtdDev: Double;
    fltUniDev: Double;
    strForCli: String;
    strTip_FC: String;
    strSerie_: String;
    fltQtdDoc: Double;
    strSeqOri: String;

    procedure pConsultaUltimasVendas(strNomCol: String);

    property strCodIte: String Read getCodIte Write setCodIte;
    property strCodEmp: String Read getCodEmp Write setCodEmp;
    property strCodCli: String Read getCodCli Write setCodCli;
    property strDiasGa: Integer Read getDiasGa Write setDiasGa;
  end;

var
  frmConsultaUltVenProdCRM: TfrmConsultaUltVenProdCRM;

implementation

uses untFuncoesSimples, untFuncoesCRM, untGarant;

{$R *.dfm}

{ TfrmConsultaUltVenProdCRM }

procedure TfrmConsultaUltVenProdCRM.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pConfirma;
  Close;
end;

procedure TfrmConsultaUltVenProdCRM.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConsultaUltVenProdCRM.cdsUltVendasAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnConfirma.Enabled := Not DataSet.IsEmpty;
end;

procedure TfrmConsultaUltVenProdCRM.dbgUltimasVendasDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  dDtaMov: TDate;
  objGar : TMovGad;
begin
  inherited;

  try
    if ( objGar = nil ) then
      objGar := TMovGad.Create(Self);  // cria o objeto

    dDtaMov := VarAsType( IIF(dbgUltimasVendasDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgUltimasVendasDBTableView1DTA_MOV.Index] = null,0,dbgUltimasVendasDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgUltimasVendasDBTableView1DTA_MOV.Index]), varDate );

    objGar.pCarregaDadosGarantia(qryUltVendas.FieldByName('CODITE').AsString, dDtaMov);

    if ( objGar.blnTemGarantia ) then
    begin
      if ( Date < objGar.dtaLimite ) and (Not objGar.blnMaisDeUmAno ) then
      begin
        If (Not AViewInfo.Selected) Then
          ACanvas.Font.Color := shpOk.Brush.Color
        Else
          ACanvas.Font.Color := clWhite;
      end
      else if ( Date > objGar.dtaLimite ) and (Not objGar.blnMaisDeUmAno ) then
      begin
        If (Not AViewInfo.Selected) Then
          ACanvas.Font.Color := shpVencida.Brush.Color
        Else
          ACanvas.Font.Color := clWhite;
      end
      else if ( Date > objGar.dtaLimite ) and (objGar.blnMaisDeUmAno ) then
      begin
        If (Not  AViewInfo.Selected) Then
          ACanvas.Font.Color := shpMais12.Brush.Color
        Else
          ACanvas.Font.Color := clWhite;
      end;
    end
    else if (Not objGar.blnTemGarantia ) then
    begin
      If (Not AViewInfo.Selected) Then
        ACanvas.Font.Color := clBlack
      Else
        ACanvas.Font.Color := clWhite;
    end;
  finally
    FreeAndNil(objGar); // destroy o objeto
  end;
end;

procedure TfrmConsultaUltVenProdCRM.dbgUltimasVendasDBTableView1DblClick(
  Sender: TObject);
begin
  inherited;
  btnConfirma.Click;
end;

procedure TfrmConsultaUltVenProdCRM.dbgUltimasVendasDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: btnConfirma.Click;
  End;  
end;

procedure TfrmConsultaUltVenProdCRM.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qryUltVendas.Close;
  cdsUltVendas.Close;
end;

procedure TfrmConsultaUltVenProdCRM.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(cdsUltVendasCODITE);
  strNumDoc := '';
  strEspDoc := '';
  dtaDtaMov := 0;
  fltQtdDev := 0;
  fltUniDev := 0;
  strForCli := '';
  strTip_FC := '';
  strSerie_ := '';
  strSeqOri := '';
end;

procedure TfrmConsultaUltVenProdCRM.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: btnSairBaixa.Click;
    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmConsultaUltVenProdCRM.FormShow(Sender: TObject);
begin
  inherited;
  if ( fCfgSis('GARANT') <> 'S' )  then
    pOcultaObjetos(False);

  pSetFocus(dbgUltimasVendas);
end;

function TfrmConsultaUltVenProdCRM.getCodCli: String;
begin
  Result := FCodCli;
end;

function TfrmConsultaUltVenProdCRM.getCodEmp: String;
begin
  Result := FCodEmp;
end;

function TfrmConsultaUltVenProdCRM.getCodIte: String;
begin
  Result := FCodIte;
end;

function TfrmConsultaUltVenProdCRM.getDiasGa: Integer;
begin
  Result := FDiasGa;
end;

function TfrmConsultaUltVenProdCRM.fRetornaQtdAde(): Double;
var
  qry: TUniQuery;
  strSQL: String;
Begin
  Result := 0;

  strSQL := strSQL + '  SELECT IFNULL(SUM(AD.DET_QTDDEV), 0) AS QTDADE  ';
  strSQL := strSQL + '       FROM ADEDET AD                             ';
  strSQL := strSQL + '       INNER JOIN ADEGER AG ON AD.DET_SEQGER = AG.AUTOINCREM  ';
  strSQL := strSQL + '       WHERE                                      ';
  strSQL := strSQL + '         AD.DET_CODEMP = :CODEMP                  ';
  strSQL := strSQL + '         AND AD.DET_NUMDOC = :NUMDOC              ';
  strSQL := strSQL + '         AND AD.DET_ESPDOC = :ESPDOC              ';
  strSQL := strSQL + '         AND AD.DET_CODITE = :CODITE              ';
  strSQL := strSQL + '         AND AD.DET_FORCLI = :CODCLI              ';
  strSQL := strSQL + '         AND AD.DET_SEQORI = :SEQORI              ';
  strSQL := strSQL + '         AND AG.GER_DOCDEV IS NULL                ';
  strSQL := strSQL + '         AND AD.DET_TIP_FC = "C"                  ';

  qry := fCriaQuery(Self);
  Try
    qry.SQL.Clear;
    qry.SQL.Add(strSQL);

    qry.ParamByName('NUMDOC').AsString := cdsUltVendasNUMDOC.AsString;
    qry.ParamByName('CODEMP').AsString := cdsUltVendasCODEMP.AsString;
    qry.ParamByName('ESPDOC').AsString := cdsUltVendasESPDOC.AsString;
    qry.ParamByName('CODITE').AsString := cdsUltVendasCODITE.AsString;
    qry.ParamByName('CODCLI').AsString := cdsUltVendasFORCLI.AsString;
    qry.ParamByName('SEQORI').AsString := cdsUltVendasSEQORI.AsString;

    qry.Open;
    If Not qry.IsEmpty Then
    Begin
      Result := qry.FieldByName('QTDADE').AsFloat;
    End;
  Finally
    qry.Close;
    FreeAndNil(qry);
  End;
End;

function TfrmConsultaUltVenProdCRM.fRetornaQtdDev: Double;
var
  qry: TUniQuery;
  strSQL: String;
Begin
  Result := 0;

  strSQL := '';
  strSQL := strSQL + '  SELECT IFNULL(SUM(DET_QTDITE),0) AS QTDDEV ';
  strSQL := strSQL + '       FROM MOVDET DET                       ';
  strSQL := strSQL + '       INNER JOIN MOVTRI TRI ON DET.AUTOINCREM = TRI.DET_SEQGER ';
  strSQL := strSQL + '       WHERE DET.DET_DOCDEV = :NUMDOC        ';
  strSQL := strSQL + '         AND DET.DET_ESPDEV = :ESPDOC        ';
  strSQL := strSQL + '         AND DET.DET_EMPDEV = :CODEMP        ';
  strSQL := strSQL + '         AND DET.DET_CODITE = :CODITE        ';
  strSQL := strSQL + '         AND DET.DET_CODCLI = :CODCLI        ';
  strSQL := strSQL + '         AND (((TRI.DET_INCDEV IS NOT NULL) AND (TRI.DET_INCDEV = :SEQORI)) OR (TRI.DET_INCDEV IS NULL)) ';

  qry := fCriaQuery(Self);
  Try
    qry.SQL.Clear;
    qry.SQL.Add(strSQL);

    qry.ParamByName('NUMDOC').AsString := cdsUltVendasNUMDOC.AsString;
    qry.ParamByName('CODEMP').AsString := cdsUltVendasCODEMP.AsString;
    qry.ParamByName('ESPDOC').AsString := cdsUltVendasESPDOC.AsString;
    qry.ParamByName('CODITE').AsString := cdsUltVendasCODITE.AsString;
    qry.ParamByName('CODCLI').AsString := cdsUltVendasFORCLI.AsString;
    qry.ParamByName('SEQORI').AsString := cdsUltVendasSEQORI.AsString;

    qry.Open;
    If Not qry.IsEmpty Then
    Begin
      Result := qry.FieldByName('QTDDEV').AsFloat;
    End;
  Finally
    qry.Close;
    FreeAndNil(qry);
  End;
End;

function TfrmConsultaUltVenProdCRM.fRetornaQtdGarantia(): Double;
  Var
    qryGad : TUniQuery;
    strSQL : String;
Begin
  Result := 0.00;

  strSQL := '';
  strSQL := strSQL + '  SELECT SUM(IFNULL(GAD_QTDREQ - GAD_QTDDEV,0)) AS QTDGAR ';
  strSQL := strSQL + '       FROM MOVGAD D                              ';
  strSQL := strSQL + '       INNER JOIN MOVGAG G ON G.AUTOINCREM = D.GAD_SEQGAG  ';
  strSQL := strSQL + '       WHERE D.GAD_CODEMP = :CODEMP              ';
  strSQL := strSQL + '         AND D.GAD_NUMDOC = :NUMDOC              ';
  strSQL := strSQL + '         AND D.GAD_ESPDOC = :ESPDOC              ';
  strSQL := strSQL + '         AND D.GAD_CODITE = :CODITE              ';
  strSQL := strSQL + '         AND D.GAD_SEQDOC = :SEQORI              ';

  qryGad := fCriaQuery(Self);
  Try
    qryGad.SQL.Clear;
    qryGad.SQL.Add(strSQL);
    qryGad.ParamByName('NUMDOC').AsString := cdsUltVendasNUMDOC.AsString;
    qryGad.ParamByName('CODEMP').AsString := cdsUltVendasCODEMP.AsString;
    qryGad.ParamByName('ESPDOC').AsString := cdsUltVendasESPDOC.AsString;
    qryGad.ParamByName('CODITE').AsString := cdsUltVendasCODITE.AsString;
    qryGad.ParamByName('SEQORI').AsString := cdsUltVendasSEQORI.AsString;
    qryGad.Open;

    If (Not qryGad.IsEmpty) Then
      Result := qryGad.FieldByName('QTDGAR').AsFloat;
  Finally
    FreeAndNil(qryGad);
  End;
end;

procedure TfrmConsultaUltVenProdCRM.pCalculaTotaisQuantidadePorItem;
begin
  cdsUltVendas.Edit;

  cdsUltVendas.FieldByName('QTDADE').AsFloat   := fRetornaQtdAde;
  cdsUltVendas.FieldByName('QTDDEV').AsFloat   := fRetornaQtdDev;
  cdsUltVendas.FieldByName('QTDITE').AsFloat   := cdsUltVendas.FieldByName('QTDCNV').AsFloat -
                                                  cdsUltVendas.FieldByName('QTDDEV').AsFloat -
                                                  cdsUltVendas.FieldByName('QTDADE').AsFloat;
  cdsUltVendas.FieldByName('QTDORI').AsFloat   := cdsUltVendas.FieldByName('QTDFIS').AsFloat -
                                                  cdsUltVendas.FieldByName('QTDDEV').AsFloat -
                                                  cdsUltVendas.FieldByName('QTDADE').AsFloat -
                                                  fRetornaQtdGarantia;
  cdsUltVendas.Post;
end;

procedure TfrmConsultaUltVenProdCRM.pConfirma;
begin
  if not cdsUltVendas.IsEmpty then
  begin
    strNumDoc := cdsUltVendasNUMDOC.AsString;
    strEspDoc := cdsUltVendasESPDOC.AsString;
    dtaDtaMov := cdsUltVendasDTA_MOV.AsDateTime;
    fltQtdDev := cdsUltVendasQTDITE.AsFloat;
    fltUniDev := cdsUltVendasPR_UNITARIO.AsFloat;
    strForCli := cdsUltVendasFORCLI.AsString;
    strTip_FC := cdsUltVendasTIP_FC.AsString;
    strSerie_ := cdsUltVendasSERIE_.AsString;
    fltQtdDoc := fQuantidadeTotalIteDocumento;
    strSeqOri := cdsUltVendasSEQORI.AsString;
  end;
end;

procedure TfrmConsultaUltVenProdCRM.pConsultaUltimasVendas(strNomCol: String);
begin
  try
    cdsUltVendas.CreateDataSet;
    cdsUltVendas.Close;

    qryUltVendas.Close;
    qryUltVendas.SQL.Clear;
    qryUltVendas.SQL.Add(fRetornaSQLUltimasVendasProduto(strNomCol));
    qryUltVendas.ParamByName('CODITE').AsString := FCodIte;
    qryUltVendas.ParamByName('CLAFIS').AsString := VS_strClaVen;
    qryUltVendas.ParamByName('CLADEV').AsString := VS_strClaDev;
    qryUltVendas.ParamByName('CODEMP').AsString := FCodEmp;
    qryUltVendas.ParamByName('CODCLI').AsString := FCodCli;

    qryUltVendas.Open;
    cdsUltVendas.Open;

    cdsUltVendas.DisableControls;
    cdsUltVendas.Open;
    Try
      cdsUltVendas.First;
      While Not cdsUltVendas.Eof Do
      Begin
        pCalculaTotaisQuantidadePorItem;
        cdsUltVendas.Next;
      End;

    Finally
     cdsUltVendas.EnableControls;
    End;

    cdsUltVendas.Filtered := False;
    cdsUltVendas.Filter   := '(QTDITE > 0) AND (QTDORI > 0)';
    cdsUltVendas.Filtered := True;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[error]');
    End;
  end
end;

procedure TfrmConsultaUltVenProdCRM.pOcultaObjetos(const Value:Boolean);
  var
    intObj : integer;
begin
  // ocultar objetos quanto não utilizar Garantia (CFG_GARANT=S)
  for intObj := 0 to ComponentCount -1 do
  begin
    if ( Components[intObj] is TLabel ) then
      if ( TLabel(Components[intobj]).Tag = 66 ) then
        TLabel(Components[intobj]).Visible := Value;

    if ( Components[intObj] is TShape ) then
      if ( TShape(Components[intobj]).Tag = 66 ) then
        TShape(Components[intobj]).Visible := Value;
  end;
end;

procedure TfrmConsultaUltVenProdCRM.setCodCli(const Value: String);
begin
  If (FCodCli <> Value) Then
    FCodCli := Value;
end;

procedure TfrmConsultaUltVenProdCRM.setCodEmp(const Value: String);
begin
  If (FCodEmp <> Value) Then
    FCodEmp := Value;
end;

procedure TfrmConsultaUltVenProdCRM.setCodIte(const Value: String);
begin
  If (FCodIte <> Value) Then
    FCodIte := Value;
end;

procedure TfrmConsultaUltVenProdCRM.setDiasGa(const Value: Integer);
begin
  If (FDiasGa <> Value) Then
    FDiasGa := Value;
end;

function TfrmConsultaUltVenProdCRM.fQuantidadeTotalIteDocumento: Double;
Var
  cdsClone: TUniClientDataSet;
begin
  Result := 0;
  try
    cdsClone := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsClone, cdsUltVendas);

    cdsClone.Filter := 'NUMDOC=' + QuotedStr(cdsUltVendasNUMDOC.AsString) +' AND '+
                       'ESPDOC=' + QuotedStr(cdsUltVendasESPDOC.AsString) +' AND '+
                       'CODEMP=' + QuotedStr(cdsUltVendasCODEMP.AsString) +' AND '+
                       'SEQORI=' + QuotedStr(cdsUltVendasSEQORI.AsString) +' AND '+
                       'CODITE=' + QuotedStr(cdsUltVendasCODITE.AsString);
    cdsClone.Filtered := True;
    cdsClone.First;
    while not cdsClone.Eof do
    begin
      Result := Result + cdsClone.FieldByName('QTDORI').AsFloat;
      cdsClone.Next;
    end;
  finally
    FreeAndNil(cdsClone);
  end;
end;

end.
