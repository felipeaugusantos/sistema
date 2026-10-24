unit untFatManPedCortadoFaltaEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Uni, UniClientDataSet;

type
  TfrmFatManPedCortadoFaltaEstoque = class(TfrmPaiEdit)
    dbgGrid: TcxGrid;
    dbgGridTBV: TcxGridDBTableView;
    dbgMensagensPEDMKT: TcxGridDBColumn;
    dbgMensagensDTAENT: TcxGridDBColumn;
    dbgMensagensNUMDOC: TcxGridDBColumn;
    dbgMensagensESPDOC: TcxGridDBColumn;
    dbgMensagensVENDED: TcxGridDBColumn;
    dbgMensagensREMSEP: TcxGridDBColumn;
    dbgMensagensREMPED: TcxGridDBColumn;
    dbgMensagensMARDES: TcxGridDBColumn;
    dbgGridLevel1: TcxGridLevel;
    dtsGrid: TDataSource;
    pnlLegenda: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgGridTBVCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dbgGridTBVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FPedCor: TUniClientDataSet;

    procedure pCriaDataSet;
    procedure pCarregaPedidosCortados;
    procedure pCarregarItens;

    function fGetSQL: String;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untFatManItensPedCortado, untFatDefineLotesPedidoWMS;

{$R *.dfm}

{ TfrmFatManPedCortadoFaltaEstoque }

procedure TfrmFatManPedCortadoFaltaEstoque.dbgGridTBVCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pCarregarItens;
end;

procedure TfrmFatManPedCortadoFaltaEstoque.dbgGridTBVKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_RETURN) then
    pCarregarItens;
end;

function TfrmFatManPedCortadoFaltaEstoque.fGetSQL: String;
begin
  Result := '';
  Result := Result + 'SELECT    ';
  Result := Result + '  DTAENT, ';
  Result := Result + '  PEDMKT, ';
  Result := Result + '  NUMDOC, ';
  Result := Result + '  ESPDOC, ';
  Result := Result + '  CODCLI, ';
  Result := Result + '  EMPDOC, ';
  Result := Result + '  CODVEN, ';
  Result := Result + '  REMSEP, ';
  Result := Result + '  REMPED  ';
  Result := Result + 'FROM (       ';
  Result := Result + '      SELECT ';
  Result := Result + '        A.FGO_DTAENT      AS DTAENT, ';
  Result := Result + '        A.FGO_NUMPOK      AS PEDMKT, ';
  Result := Result + '        A.FGO_NUMDOC      AS NUMDOC, ';
  Result := Result + '        A.FGO_ESPDOC      AS ESPDOC, ';
  Result := Result + '        A.FGO_CODEMP      AS EMPDOC, ';
  Result := Result + '        A.FGO_CODCLI      AS CODCLI, ';
  Result := Result + '        O.OPE_NOMOPE      AS CODVEN, ';
  Result := Result + '        B.FGO_SEQOND      AS REMSEP, ';
  Result := Result + '        B.FGO_SEQSEP      AS REMPED, ';
  Result := Result + '        C.FDO_CODITE      AS CODITE, ';
  Result := Result + '        C.FDO_DESCRI      AS DESITE, ';
  Result := Result + '        U.UNI_SIGUNI      AS SIGUNI, ';
  Result := Result + '        SUM(C.FDO_QTDITE) AS QTDITE, ';
  Result := Result + '        SUM(D.LDO_QTDITE) AS QTLDOR  ';
  Result := Result + '      FROM FATGOR A ';
  Result := Result + '      LEFT JOIN EXTGOR B ON A.AUTOINCREM = B.FGO_SEQFGO ';
  Result := Result + '      LEFT JOIN FATDOR C ON A.AUTOINCREM = C.FDO_SEQGER ';
  Result := Result + '      LEFT JOIN CADOPE O ON A.FGO_CODVEN = O.OPE_CODOPE ';
  Result := Result + '      LEFT JOIN CADUNI U ON C.FDO_UNIDAD = U.UNI_CODUNI ';
  Result := Result + '      LEFT JOIN (SELECT LDO_SEQFDO, SUM(LDO_QTDITE) LDO_QTDITE ';
  Result := Result + '                 FROM LOTDOR ';
  Result := Result + '                 GROUP BY LDO_SEQFDO) D ON C.AUTOINCREM = D.LDO_SEQFDO ';
  Result := Result + '      WHERE A.FGO_ESPDOC = :ESPDOC   ';
  Result := Result + '        AND A.FGO_CODEMP = :CODEMP   ';
  Result := Result + '        AND A.FGO_JAFATU = 0         ';
  Result := Result + '        AND A.FGO_VLRCON > 0         ';
  Result := Result + '        AND IFNULL(B.FGO_SEQOND, "") <> "" ';
  Result := Result + '      GROUP BY A.AUTOINCREM, C.FDO_CODITE ';
  Result := Result + '      HAVING QTDITE > IFNULL(QTLDOR, 0)   ';
  Result := Result + '      ORDER BY A.FGO_DTAENT, A.FGO_CODEMP, A.FGO_ESPDOC, A.FGO_NUMDOC ';
  Result := Result + '     ) AS T ';
  Result := Result + 'GROUP BY NUMDOC, ESPDOC, EMPDOC         ';
  Result := Result + 'ORDER BY DTAENT, EMPDOC, ESPDOC, NUMDOC ';
end;

procedure TfrmFatManPedCortadoFaltaEstoque.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSet;
end;

procedure TfrmFatManPedCortadoFaltaEstoque.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(FPedCor) then
    FreeAndNil(FPedCor);
end;

procedure TfrmFatManPedCortadoFaltaEstoque.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaPedidosCortados;
end;

procedure TfrmFatManPedCortadoFaltaEstoque.pCarregaPedidosCortados;
var
  LQry: TUniQuery;
  LCont: Integer;
begin
  LQry := fCriaQuery;

  try
    FPedCor.DisableControls;

    LQry.SQL.Text := fGetSQL;
    LQry.ParamByName('ESPDOC').AsString := 'PD';
    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.Open;

    if LQry.IsEmpty then
      Exit;

    FPedCor.EmptyDataSet;

    while not LQry.Eof do
    begin
      FPedCor.Append;

      for LCont := 0 to Pred(LQry.FieldCount) do
        FPedCor.Fields[LCont].Value := LQry.Fields[LCont].Value;

      FPedCor.Post;

      LQry.Next;
    end;

    FPedCor.First;
  finally
    FreeAndNil(LQry);
    FPedCor.EnableControls;
  end;
end;

procedure TfrmFatManPedCortadoFaltaEstoque.pCarregarItens;
var
  LFatManItensPedCortado: TfrmFatManItensPedCortado;
begin
  pCriarFormularios(TfrmFatManItensPedCortado, LFatManItensPedCortado);

  try
    LFatManItensPedCortado.strNumDoc := FPedCor.FieldByName('NUMDOC').AsString;
    LFatManItensPedCortado.strEspDoc := FPedCor.FieldByName('ESPDOC').AsString;
    LFatManItensPedCortado.strEmpDoc := FPedCor.FieldByName('EMPDOC').AsString;
    LFatManItensPedCortado.strCodCli := FPedCor.FieldByName('CODCLI').AsString;
    LFatManItensPedCortado.strOndSep := FPedCor.FieldByName('REMSEP').AsString;
    LFatManItensPedCortado.ShowModal;

    pCarregaPedidosCortados;
  finally
    pFreeAndNil(LFatManItensPedCortado);
  end;
end;

procedure TfrmFatManPedCortadoFaltaEstoque.pCriaDataSet;
begin
  FPedCor := TUniClientDataSet.Create(Nil);
  FPedCor.FieldDefs.Add('DTAENT', ftDateTime  );
  FPedCor.FieldDefs.Add('PEDMKT', ftString, 12);
  FPedCor.FieldDefs.Add('NUMDOC', ftString, 12);
  FPedCor.FieldDefs.Add('ESPDOC', ftString,  2);
  FPedCor.FieldDefs.Add('CODCLI', ftString,  8);
  FPedCor.FieldDefs.Add('EMPDOC', ftString,  3);
  FPedCor.FieldDefs.Add('CODVEN', ftString, 40);
  FPedCor.FieldDefs.Add('REMSEP', ftString, 12);
  FPedCor.FieldDefs.Add('REMPED', ftString, 12);

  FPedCor.CreateDataSet;

  dtsGrid.DataSet := FPedCor;
end;

end.
