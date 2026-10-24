unit untConsultaFatDocumentosCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, Uni,
  UniClientDataSet, Vcl.Grids, Vcl.DBGrids, DBGridCitel, untFuncoesSimples,
  System.StrUtils;

type
  TfrmConsultaFatDocumentosCliente = class(TfrmPai)
    dbgItens: TDBGridCitel;
    dtsDados: TDataSource;
    btnConfirmar: TBitBtnLocked;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgItensDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    strCodEmp : String;
    strCodCli : String;
    strEspDoc : String;
    strJaFatu : String;
    strPedImp : String;
    cdsDados  : TUniClientDataSet;

    procedure pConfigurarCampos;
    procedure pCarregarDados;

  public
    { Public declarations }
    function SetNomCli(const Value: String): TfrmConsultaFatDocumentosCliente;
    function SetCodEmp(const Value: String): TfrmConsultaFatDocumentosCliente;
    function SetCodCli(const Value: String): TfrmConsultaFatDocumentosCliente;
    function SetEspDoc(const Value: String): TfrmConsultaFatDocumentosCliente;
    function SetJaFatu(const Value: String): TfrmConsultaFatDocumentosCliente;
    function SetPedImp(const Value: String): TfrmConsultaFatDocumentosCliente;

    function fAbrirConsultaFatDocumentosCliente(var strNumDoc: String;
      var strEspDoc: String): TfrmConsultaFatDocumentosCliente;

    function fQuantidadePedidoEmAbertoParaCliente: Integer;

  end;

implementation

{$R *.dfm}

{ TfrmConsultaFatDocumentosCliente }

procedure TfrmConsultaFatDocumentosCliente.dbgItensDblClick(Sender: TObject);
begin
  inherited;
  btnConfirmar.Click;
end;

function TfrmConsultaFatDocumentosCliente.fAbrirConsultaFatDocumentosCliente(
  var strNumDoc: String; var strEspDoc: String): TfrmConsultaFatDocumentosCliente;
begin
  Result := Self;

  if (not Assigned(cdsDados)) or
     (cdsDados.RecordCount = 0) then
    pCarregarDados;

  pConfigurarCampos;

  strNumDoc := '';
  strEspDoc := '';

  if (fQuantidadePedidoEmAbertoParaCliente = 1) or
     (Self.ShowModal = mrOk) then
  begin
    strNumDoc := cdsDados.FieldByName('FGO_NUMDOC').AsString;
    strEspDoc := cdsDados.FieldByName('FGO_ESPDOC').AsString;
  end;
end;

procedure TfrmConsultaFatDocumentosCliente.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados  := nil;
  strJaFatu := EmptyStr;
  strPedImp := EmptyStr;
end;

procedure TfrmConsultaFatDocumentosCliente.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(cdsDados) then
    FreeAndNil(cdsDados);
end;

procedure TfrmConsultaFatDocumentosCliente.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F10 then
  begin
    Key := 0;
    btnConfirmar.Click;
  end
  else
    inherited;
end;

function TfrmConsultaFatDocumentosCliente.fQuantidadePedidoEmAbertoParaCliente: Integer;
begin
  Result := 0;

  if (not Assigned(cdsDados)) or
     (cdsDados.RecordCount = 0) then
    pCarregarDados;

  if Assigned(cdsDados) then
    Result := cdsDados.RecordCount;
end;

procedure TfrmConsultaFatDocumentosCliente.pCarregarDados;
var
  strSelect : String;
  qryDados  : TUniQuery;
begin
  strSelect := '';
  qryDados := fCriaQuery(Self);

  try
    strSelect := 'SELECT SQL_NO_CACHE '
               + '       F.AUTOINCREM '
               + '     , F.FGO_NUMDOC '
               + '     , F.FGO_ESPDOC '
               + '     , F.FGO_CODEMP '
               + '     , F.FGO_DTAENT '
               + '     , F.FGO_TOTPRO '
               + '     , F.FGO_CODVEN '
               + '     , O.OPE_NOMOPE '
               + '     , F.FGO_JAFATU '
               + '     , F.FGO_PEDIMP '
               + '  FROM FATGOR F '
               + ' INNER JOIN CADOPE O ON O.OPE_CODOPE = F.FGO_CODVEN '
               + ' WHERE F.FGO_CODEMP = :CODEMP '
               + '   AND F.FGO_CODCLI = :CODCLI '
               + '   AND F.FGO_ESPDOC = :ESPDOC ';

    if not fEmptyStr(strJaFatu) then
    begin
      strSelect := strSelect
                 + '   AND F.FGO_JAFATU = :JAFATU ';
    end;

    if not fEmptyStr(strPedImp) then
    begin
      strSelect := strSelect
                 + '   AND F.FGO_PEDIMP = :PEDIMP ';
    end;

    strSelect := strSelect
               + ' ORDER BY '
               + '       F.FGO_DTAENT '
               + '     , F.FGO_CODEMP '
               + '     , F.FGO_NUMDOC ';

    qryDados.SQL.Text := strSelect;
    qryDados.ParamByName('CODEMP').AsString := strCodEmp;
    qryDados.ParamByName('CODCLI').AsString := strCodCli;
    qryDados.ParamByName('ESPDOC').AsString := strEspDoc;

    if not fEmptyStr(strJaFatu) then
      qryDados.ParamByName('JAFATU').AsString := strJaFatu;

    if not fEmptyStr(strPedImp) then
      qryDados.ParamByName('PEDIMP').AsString := strPedImp;

    qryDados.Open;

    cdsDados := fCriaClientDatset(qryDados);
    cdsDados.First;

    dtsDados.DataSet := cdsDados;
  finally
    FreeAndNil(qryDados)
  end;
end;

procedure TfrmConsultaFatDocumentosCliente.pConfigurarCampos;
var
  clnItem : TColumn;
begin
  try
    clnItem := TColumn.Create(dbgItens.Columns);
    clnItem.FieldName     := 'FGO_DTAENT';
    clnItem.Title.Caption := 'Dt. Emissão';
    clnItem.Width         := 75;

    clnItem := TColumn.Create(dbgItens.Columns);
    clnItem.FieldName     := 'FGO_NUMDOC';
    clnItem.Title.Caption := 'Documento';
    clnItem.Width         := 90;

    clnItem := TColumn.Create(dbgItens.Columns);
    clnItem.FieldName     := 'FGO_ESPDOC';
    clnItem.Title.Caption := 'Esp.';
    clnItem.Width         := 35;

    clnItem := TColumn.Create(dbgItens.Columns);
    clnItem.FieldName     := 'FGO_CODEMP';
    clnItem.Title.Caption := 'Cd. Emp.';
    clnItem.Width         := 50;

    clnItem := TColumn.Create(dbgItens.Columns);
    clnItem.FieldName     := 'FGO_CODVEN';
    clnItem.Title.Caption := 'Cd. Vend.';
    clnItem.Width         := 50;

    clnItem := TColumn.Create(dbgItens.Columns);
    clnItem.FieldName     := 'OPE_NOMOPE';
    clnItem.Title.Caption := 'Vendedor';
    clnItem.Width         := 250;

    clnItem := TColumn.Create(dbgItens.Columns);
    clnItem.FieldName     := 'FGO_TOTPRO';
    clnItem.Title.Caption := 'Vr. Pedido';
    clnItem.Width         := 80;

    if Assigned(cdsDados.FindField('FGO_TOTPRO')) Then
      TFloatField(cdsDados.FieldByName('FGO_TOTPRO')).DisplayFormat := '#,##0.00';
  except
    raise;
  end;
end;

function TfrmConsultaFatDocumentosCliente.SetCodCli(
  const Value: String): TfrmConsultaFatDocumentosCliente;
begin
  Result    := Self;
  strCodCli := Value;
end;

function TfrmConsultaFatDocumentosCliente.SetCodEmp(
  const Value: String): TfrmConsultaFatDocumentosCliente;
begin
  Result    := Self;
  strCodEmp := Value;
end;

function TfrmConsultaFatDocumentosCliente.SetEspDoc(
  const Value: String): TfrmConsultaFatDocumentosCliente;
begin
  Result    := Self;
  strEspDoc := Value;
end;

function TfrmConsultaFatDocumentosCliente.SetJaFatu(
  const Value: String): TfrmConsultaFatDocumentosCliente;
begin
  try
    Result    := Self;
    strJaFatu := Value;
  except
    raise Exception.Create('As opções só podem ser [0] Não faturado ou [1] Faturado.');
  end;
end;

function TfrmConsultaFatDocumentosCliente.SetNomCli(
  const Value: String): TfrmConsultaFatDocumentosCliente;
begin
  Result       := Self;
  Self.Caption := Self.Caption
                + ' - '
                + Copy(Value,1,25);
end;

function TfrmConsultaFatDocumentosCliente.SetPedImp(
  const Value: String): TfrmConsultaFatDocumentosCliente;
begin
  try
    Result    := Self;
    strPedImp := Value;
  except
    raise Exception.Create('As opções só podem ser [S]im ou [N]ão.');
  end;
end;

end.
