unit untFatManItensPedCortado;

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
  cxClasses, cxGridCustomView, cxGrid, Uni, UniClientDataSet, EditFocus;

type
  TfrmFatManItensPedCortado = class(TfrmPaiEdit)
    pnlTopo: TPanel;
    dbgGrid: TcxGrid;
    dbgGridTBV: TcxGridDBTableView;
    dbgMensagensCODITE: TcxGridDBColumn;
    dbgMensagensDESITE: TcxGridDBColumn;
    dbgMensagensSIGUNI: TcxGridDBColumn;
    dbgMensagensQTDITE: TcxGridDBColumn;
    dbgMensagensQTLDOR: TcxGridDBColumn;
    dbgGridLevel1: TcxGridLevel;
    dtsGrid: TDataSource;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    lblCliFor: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label1: TLabel;
    btnDefinirLotes: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDefinirLotesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FItePed: TUniClientDataSet;

    procedure pCriaDataSet;
    procedure pCarregaInfoPedido;
    procedure pCarregaItensPedido;

    function fGetSQL: String;
  public
    { Public declarations }
    strNumDoc,
    strEspDoc,
    strEmpDoc,
    strCodCli,
    strOndSep: String;
  end;

implementation

uses
  untFuncoesSimples, untFatDefineLotesPedidoWMS;

{$R *.dfm}

{ TfrmFatManItensPedCortado }

procedure TfrmFatManItensPedCortado.btnDefinirLotesClick(Sender: TObject);
var
  LFatDefineLotesPedidoWMS: TfrmFatDefineLotesPedidoWMS;
begin
  inherited;
  pCriarFormularios(TfrmFatDefineLotesPedidoWMS, LFatDefineLotesPedidoWMS);

  try
    LFatDefineLotesPedidoWMS.TipoDefinicoesLotes := tdlPedido;

    LFatDefineLotesPedidoWMS.strNumPed := strNumDoc;
    LFatDefineLotesPedidoWMS.strEmpPed := strEmpDoc;
    LFatDefineLotesPedidoWMS.strCodCli := strCodCli;
    LFatDefineLotesPedidoWMS.blnAtualizaPedCortado := True;
    LFatDefineLotesPedidoWMS.ShowModal;

    if (LFatDefineLotesPedidoWMS.blnConfirma) then
    begin
      ModalResult := mrOk;
      Close;
    end;
  finally
    pFreeAndNil(LFatDefineLotesPedidoWMS);
  end;
end;

function TfrmFatManItensPedCortado.fGetSQL: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  C.FDO_CODITE AS CODITE,      ';
  Result := Result + '  C.FDO_DESCRI AS DESITE,      ';
  Result := Result + '  U.UNI_SIGUNI AS SIGUNI,      ';
  Result := Result + '  SUM(C.FDO_QTDITE) AS QTDITE, ';
  Result := Result + '  IFNULL(SUM(D.LDO_QTDITE), 0) AS QTLDOR  ';
  Result := Result + 'FROM FATGOR A ';
  Result := Result + 'LEFT JOIN EXTGOR B ON A.AUTOINCREM = B.FGO_SEQFGO ';
  Result := Result + 'LEFT JOIN FATDOR C ON A.AUTOINCREM = C.FDO_SEQGER ';
  Result := Result + 'LEFT JOIN CADOPE O ON A.FGO_CODVEN = O.OPE_CODOPE ';
  Result := Result + 'LEFT JOIN CADUNI U ON C.FDO_UNIDAD = U.UNI_CODUNI ';
  Result := Result + 'LEFT JOIN (SELECT LDO_SEQFDO, SUM(LDO_QTDITE) LDO_QTDITE ';
  Result := Result + '           FROM LOTDOR ';
  Result := Result + '           GROUP BY LDO_SEQFDO) D ON C.AUTOINCREM = D.LDO_SEQFDO ';
  Result := Result + 'WHERE A.FGO_NUMDOC = :NUMDOC   ';
  Result := Result + '  AND A.FGO_ESPDOC = :ESPDOC   ';
  Result := Result + '  AND A.FGO_CODEMP = :CODEMP   ';
  Result := Result + '  AND A.FGO_JAFATU = 0         ';
  Result := Result + '  AND A.FGO_VLRCON > 0         ';
  Result := Result + '  AND B.FGO_SEQOND IS NOT NULL ';
  Result := Result + 'GROUP BY A.AUTOINCREM, C.FDO_CODITE ';
  Result := Result + 'HAVING QTDITE > IFNULL(QTLDOR, 0) ';
  Result := Result + 'ORDER BY A.FGO_DTAENT, A.FGO_CODEMP, A.FGO_ESPDOC, A.FGO_NUMDOC ';
end;

procedure TfrmFatManItensPedCortado.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSet;
end;

procedure TfrmFatManItensPedCortado.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(FItePed) then
    FreeAndNil(FItePed);
end;

procedure TfrmFatManItensPedCortado.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if (Key = VK_F2) then
    btnDefinirLotes.Click;
end;

procedure TfrmFatManItensPedCortado.FormShow(Sender: TObject);
begin
  inherited;

  pCarregaInfoPedido;
  pCarregaItensPedido;
end;

procedure TfrmFatManItensPedCortado.pCarregaInfoPedido;
begin
  edtNumDoc.Text := strNumDoc;
  edtEspDoc.Text := strEspDoc;
  edtCodEmp.Text := strEmpDoc;
  edtCodCli.Text := strCodCli;
  edtNomCli.Text := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
end;

procedure TfrmFatManItensPedCortado.pCarregaItensPedido;
var
  LQry: TUniQuery;
  LCont: Integer;
begin
  LQry := fCriaQuery;

  try
    LQry.SQL.Text := fGetSQL;
    LQry.ParamByName('NUMDOC').AsString := strNumDoc;
    LQry.ParamByName('ESPDOC').AsString := strEspDoc;
    LQry.ParamByName('CODEMP').AsString := strEmpDoc;
    LQry.Open;

    if LQry.IsEmpty then
    begin
      Exit;
    end;

    while not LQry.Eof do
    begin
      FItePed.Append;

      for LCont := 0 to Pred(LQry.FieldCount) do
        FItePed.Fields[LCont].Value := LQry.Fields[LCont].Value;

      FItePed.Post;

      LQry.Next;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmFatManItensPedCortado.pCriaDataSet;
begin
  FItePed := TUniClientDataSet.Create(Nil);
  FItePed.FieldDefs.Add('CODITE', ftString,  10);
  FItePed.FieldDefs.Add('DESITE', ftString, 100);
  FItePed.FieldDefs.Add('SIGUNI', ftString,   7);
  FItePed.FieldDefs.Add('QTDITE', ftFloat);
  FItePed.FieldDefs.Add('QTLDOR', ftFloat);
  FItePed.CreateDataSet;

  (FItePed.FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (FItePed.FieldByName('QTDITE') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECQTD', varInteger));

  (FItePed.FieldByName('QTLDOR') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (FItePed.FieldByName('QTLDOR') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECQTD', varInteger));

  dtsGrid.DataSet := FItePed;
end;

end.
