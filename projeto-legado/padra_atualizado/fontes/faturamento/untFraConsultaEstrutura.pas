unit untFraConsultaEstrutura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCurrencyEdit, cxImageComboBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxClasses,
  cxGridCustomView, cxGrid, cxTL, cxMaskEdit, cxTLdxBarBuiltInMenu,
  cxInplaceContainer, cxDBTL, cxTLData, System.Math, untFuncoesSimples, MemDS,
  DBAccess, Uni, Datasnap.DBClient, UniClientDataSet;

type
  TfraConsultaEstrutura = class(TFrame)
    cxDBTreeEstru: TcxDBTreeList;
    CODITE: TcxDBTreeListColumn;
    DESITE: TcxDBTreeListColumn;
    SALDIS: TcxDBTreeListColumn;
    procedure SALDISGetDisplayText(Sender: TcxTreeListColumn;
      ANode: TcxTreeListNode; var Value: string);
  private
    { Private declarations }
    qryGerMat : TUniQuery;
    qryDetMat : TUniQuery;
    cdsItens  : TUniClientDataSet;
    dtsItens  : TUniDataSource;

    FstrCodEmp: String;

    procedure pCriacdsItens;
    function fGetDetMat(strCodEmp: String): String;
    procedure pCarregarEstruturaCds(strCodItem: string);
    procedure pCriaQry;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure pCarregarEstrutura(strCodItem, strCodEmp: string);
  end;

implementation

{$R *.dfm}

procedure TfraConsultaEstrutura.SALDISGetDisplayText(Sender: TcxTreeListColumn;
  ANode: TcxTreeListNode; var Value: string);
Var
  mskSaldo: String;
  intDecQtd: Integer;
begin
  if not fEmptyStr(Value) then
  begin
    intDecQtd := Max(3, fCfgSis('DECQTD', varInteger));
    mskSaldo := fMskDigitos(intDecQtd);

    Value := FormatFloat(' #,##0.0000', StrToFloatDef(StringReplace(Value, '.', ',',[rfReplaceAll]), 0));
  end;
end;

procedure TfraConsultaEstrutura.pCriacdsItens;
begin
  cdsItens := TUniClientDataSet.Create(Self);
  cdsItens.Close;
  cdsItens.FieldDefs.Clear;
  cdsItens.FieldDefs.Add('CODITE', ftString, 10);
  cdsItens.FieldDefs.Add('DESITE', ftString, 255);
  cdsItens.FieldDefs.Add('CODPAI', ftString, 10);
  cdsItens.FieldDefs.Add('SALDIS', ftFloat);
  cdsItens.CreateDataSet;
  cdsItens.Open;
  cdsItens.EmptyDataSet;

  dtsItens := TUniDataSource.Create(Self);
  dtsItens.DataSet := cdsItens;

  cxDBTreeEstru.DataController.DataSource := dtsItens;
end;

procedure TfraConsultaEstrutura.pCriaQry;
begin
  qryGerMat := fCriaQuery;
  qryDetMat := fCriaQuery;
end;

constructor TfraConsultaEstrutura.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  if not Assigned(cdsItens) then
    pCriacdsItens;

  if not Assigned(qryGerMat) then
    pCriaQry;
end;

function TfraConsultaEstrutura.fGetDetMat(strCodEmp: String): String;
begin
  Result := '';
  Result := Result + ' SELECT C.ITE_CODITE,                               ';
  Result := Result + '        ITE_DESITE,                                 ';
  Result := Result + '        ITE_CODFAB,                                 ';
  Result := Result + '        DMT_QTDITE,                                 ';
  Result := Result + '        ITE_CODSIM,                                 ';
  Result := Result + '        ITE_PRECUS,                                 ';
  Result := Result + '        ITE_ICMSAI,                                 ';
  Result := Result + '        ITE_IMPFED,                                 ';
  Result := Result + '        ITE_DESOPE,                                 ';
  Result := Result + '        ITE_OUTVAL,                                 ';
  Result := Result + '        G.ITE_CODEMP,                               ';
  Result := Result + '        ITE_SALDOS + IF(IFNULL(C.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / C.ITE_CNV_ML, 0) + ' +  IIf(fUsaQtdPendenteEntregaFutura, fGetSQLSomaCamposEntregaFutura('G'), '0') + ' AS SALITE, ';

  Result := Result + '      ' + fSQLSaldoDisponivel('G', True, False, True) + ' AS  SALDIS, ';

  Result := Result + '        IF(IFNULL(C.ITE_CNV_ML, 0) <= 0, 1, C.ITE_CNV_ML) AS CNV_ML,';
  Result := Result + '        IFNULL(G.ITE_SAL_ML, 0) AS SAL_ML           ';
  Result := Result + ' FROM DETMAT                                        ';
  Result := Result + '   INNER JOIN CADITE C ON C.ITE_CODITE = DMT_ITESUB ';
  Result := Result + '   INNER JOIN ITEGER G ON G.ITE_CODITE = DMT_ITESUB ';
  Result := Result + '                      AND G.ITE_CODEMP = ' + QuotedStr(strCodEmp);
  Result := Result + ' WHERE DMT_SEQGER = :SEQGER                         ';
end;

procedure TfraConsultaEstrutura.pCarregarEstruturaCds(strCodItem: string);
begin
  cdsItens.EmptyDataSet;
  cxDBTreeEstru.FullCollapse;

  if not fEhOuCompoeEstrutura(strCodItem).blnPrincipal then
    exit;

  qryGerMat.Close;
  qryGerMat.Sql.Clear;
  qryGerMat.Sql.Add(fGetSQLEstruturaPai(FstrCodEmp));

  qryDetMat.Close;
  qryDetMat.Sql.Clear;
  qryDetMat.Sql.Add(fGetDetMat(FstrCodEmp));

  cdsItens.DisableControls;
  Try
    qryGerMat.Close;
    qryGerMat.ParamByName('CODITE').AsString := strCodItem;
    qryGerMat.Open;

    if qryGerMat.recordcount > 0 then
    begin
      While Not qryGerMat.Eof Do
      Begin
        cdsItens.Append;
        cdsItens.FieldByName('CODITE').AsString := qryGerMat.FieldByName('ITE_CODITE').AsString;
        cdsItens.FieldByName('DESITE').AsString := qryGerMat.FieldByName('ITE_DESITE').AsString;
        cdsItens.Post;

        qryDetMat.Close;
        qryDetMat.ParamByName('SEQGER').AsString := qryGerMat.FieldByName('AUTOINCREM').AsString;
        qryDetMat.Open;

        While Not qryDetMat.Eof Do
        Begin
          cdsItens.Append;
          cdsItens.FieldByName('CODPAI').AsString := qryGerMat.FieldByName('ITE_CODITE').AsString;
          cdsItens.FieldByName('CODITE').AsString := qryDetMat.FieldByName('ITE_CODITE').AsString;
          cdsItens.FieldByName('DESITE').AsString := qryDetMat.FieldByName('ITE_DESITE').AsString;
          cdsItens.FieldByName('SALDIS').AsFloat := qryDetMat.FieldByName('SALDIS').AsFloat;
          cdsItens.Post;

          qryDetMat.Next;
        End;

        qryGerMat.Next;
      End;
    end;
  Finally
    cdsItens.EnableControls;
  End;

  cxDBTreeEstru.FullExpand;
  cxDBTreeEstru.ApplyBestFit;
  cxDBTreeEstru.AdjustColumnsWidth;
end;

procedure TfraConsultaEstrutura.pCarregarEstrutura(strCodItem, strCodEmp: string);
begin
  FstrCodEmp := strCodEmp;
  pCarregarEstruturaCds(strCodItem);
end;

end.
