unit untRemessaMercadoriaFaltante;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus,
  Datasnap.DBClient, MemDS, DBAccess, Uni, StrUtils, UniClientDataSet;

type
  TfrmRemessaMercadoriaFaltante = class(TfrmPai)
    btnMarcarItem: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    pnlCabecalho: TPanel;
    edtCodEmp: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomEmp: TEditFocus;
    edtNomCli: TEditFocus;
    edtDocumento: TEditFocus;
    edtEspecie: TEditFocus;
    lblDocumento: TLabel;
    lblEspecie: TLabel;
    lblEmpresa: TLabel;
    lblCliente: TLabel;
    grdItensDBTableViewItens: TcxGridDBTableViewCitel;
    grdItensLevel1: TcxGridLevel;
    grdItens: TcxGridCitel;
    dtsItens: TDataSource;
    grdItensDESITE: TcxGridDBColumn;
    grdItensCODITE: TcxGridDBColumn;
    grdItensMARDES: TcxGridDBColumn;
    cdsItens: TUniClientDataSet;
    cdsItensAUTOINCREM: TStringField;
    cdsItensDESITE: TStringField;
    cdsItensMARDES: TStringField;
    cdsItensCODITE: TStringField;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnMarcarItemClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure grdItensDBTableViewItensCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure grdItensDBTableViewItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    intContMercMarcadas: integer;
    procedure pCarregaItensFaltantes(strNumDoc, strEspDoc, strCodEmp, strCodCli: string);
    function fSQLItenFaltantes: string;
    procedure pMarcaDesmarcaTodos(strComando: string);
  public
    stlMercadoriasFaltantes: TStringList;
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmRemessaMercadoriaFaltante.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if intContMercMarcadas <= 0 then
  begin
    fMensagem('','Selecione ao menos um registro!',['&OK']);
    Exit;
  end;

  cdsItens.DisableControls;
  cdsItens.First;

  while not cdsItens.Eof do
  begin
    if cdsItens.FieldByName('MARDES').AsString = 'M' then
    begin
      stlMercadoriasFaltantes.Add(cdsItens.FieldByName('AUTOINCREM').AsString);
    end;
    cdsItens.Next;
  end;

  cdsItens.EnableControls;

  Close;
  ModalResult := mrOk;
end;

procedure TfrmRemessaMercadoriaFaltante.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos('D');
end;

procedure TfrmRemessaMercadoriaFaltante.btnMarcarItemClick(Sender: TObject);
begin
  inherited;
  if cdsItens.IsEmpty then
    Exit;

  cdsItens.Edit;
  if cdsItens.FieldByName('MARDES').AsString = 'D' then
  begin
    cdsItens.FieldByName('MARDES').AsString := 'M';
    Inc(intContMercMarcadas);
  end
  else
  begin
    cdsItens.FieldByName('MARDES').AsString := 'D';
    Dec(intContMercMarcadas);
  end;
  cdsItens.Post;
end;

procedure TfrmRemessaMercadoriaFaltante.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos('M');
end;

procedure TfrmRemessaMercadoriaFaltante.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(grdItens);
end;

procedure TfrmRemessaMercadoriaFaltante.FormCreate(Sender: TObject);
begin
  inherited;
  cdsItens.CreateDataSet;
  stlMercadoriasFaltantes := TStringList.Create;
  intContMercMarcadas := 0;
end;

procedure TfrmRemessaMercadoriaFaltante.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(stlMercadoriasFaltantes);
end;

procedure TfrmRemessaMercadoriaFaltante.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaItensFaltantes(edtDocumento.Text, edtEspecie.Text, edtCodEmp.Text, edtCodCli.Text);
end;

function TfrmRemessaMercadoriaFaltante.fSQLItenFaltantes: string;
begin
  Result := EmptyStr;
  Result := Result + ' SELECT D.AUTOINCREM, D.DET_CODITE AS CODITE, I.ITE_DESITE AS DESITE ' + sLineBreak;
  Result := Result + ' FROM MOVDET D ' + sLineBreak;
  Result := Result + ' INNER JOIN CADITE I ' + sLineBreak;
  Result := Result + ' ON(D.DET_CODITE = I.ITE_CODITE) ' + sLineBreak;
  Result := Result + ' WHERE ' + sLineBreak;
  Result := Result + '  D.DET_NUMDOC = :NUMDOC AND ' + sLineBreak;
  Result := Result + '  D.DET_ESPDOC = :ESPDOC AND ' + sLineBreak;
  Result := Result + '  D.DET_CODEMP = :CODEMP AND ' + sLineBreak;
  Result := Result + '  D.DET_CODCLI = :CODCLI AND ' + sLineBreak;
  Result := Result + '  D.DET_ORIDOC = "V"         ' + sLineBreak;

  Result := Result + ' UNION ALL ' + sLineBreak + AnsiReplaceStr(Result,'MOVDET','NOTDET');
end;

procedure TfrmRemessaMercadoriaFaltante.grdItensDBTableViewItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strMarDes: string;
begin
  inherited;
  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdItensMARDES.Index]);

  if strMarDes = 'M' then
  begin
    if not AViewInfo.Selected then
    begin
      ACanvas.Font.Color := clBlue;
    end;
  end;
end;

procedure TfrmRemessaMercadoriaFaltante.grdItensDBTableViewItensKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if cdsItens.IsEmpty then
    Exit;

  case key of
    VK_RETURN : if cdsItens.RecNo > 0 then
                begin
                  btnMarcarItem.Click;
                end;
    VK_F2     : btnMarcarTodos.Click;
    VK_F3     : btnDesmarcarTodos.Click;
    VK_F10    : btnConfirmar.Click;
  end;
end;

procedure TfrmRemessaMercadoriaFaltante.pCarregaItensFaltantes(strNumDoc,
  strEspDoc, strCodEmp, strCodCli: string);
var
  qryItens: TUniQuery;
begin
  qryItens := fCriaQuery;

  try
    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add(fSQLItenFaltantes);
    qryItens.ParamByName('NUMDOC').AsString := strNumDoc;
    qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
    qryItens.ParamByName('CODEMP').AsString := strCodEmp;
    qryItens.ParamByName('CODCLI').AsString := strCodCli;
    qryItens.Open;

    if not qryItens.IsEmpty then
    begin
      cdsItens.EmptyDataSet;

      while not qryItens.Eof do
      begin
        cdsItens.Append;
        cdsItens.FieldByName('AUTOINCREM').AsString := qryItens.FieldByName('AUTOINCREM').AsString;
        cdsItens.FieldByName('DESITE').AsString := qryItens.FieldByName('DESITE').AsString;
        cdsItens.FieldByName('CODITE').AsString := qryItens.FieldByName('CODITE').AsString;
        cdsItens.FieldByName('MARDES').AsString := 'D';
        cdsItens.Post;
        qryItens.Next;
      end;
    end;
  finally
    FreeAndNil(qryItens);
  end;
end;

procedure TfrmRemessaMercadoriaFaltante.pMarcaDesmarcaTodos(strComando: string);
begin
  if cdsItens.IsEmpty then
    Exit;

  cdsItens.DisableControls;
  cdsItens.First;
  while not cdsItens.Eof do
  begin
    if (cdsItens.FieldByName('MARDES').AsString <> strComando) then
    begin
      cdsItens.Edit;
      cdsItens.FieldByName('MARDES').AsString := strComando;
      cdsItens.Post;

      if strComando = 'M' then
      begin
        Inc(intContMercMarcadas);
      end
      else
      begin
        Dec(intContMercMarcadas);
      end;
    end;
    cdsItens.Next;
  end;
  cdsItens.EnableControls;
end;

end.
