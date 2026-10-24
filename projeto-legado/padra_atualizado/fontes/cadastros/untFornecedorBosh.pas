unit untFornecedorBosh;

interface

uses sysutils, uni, untFuncoesSimples ,untZClient, Data.DB;

type

  TFornecedorBosh = class
  private
    FblnInsert: Boolean;
    FQryControle: TZClient;
    FCodFor: string;
    FblnPermiteEdicao: Boolean;
    function getState: TDataSetState;
    function getDivVenda: string;
    function getTipoPedido: string;
    function fColocarEmEdicao: boolean;
    procedure setDivVenda(const Value: string);
    procedure setTipoPedido(const Value: string);
    function getpathGeracao: string;
    procedure setPathGeracao(const Value: string);
    function getTipoEntrega: string;
    procedure setTipoEntrega(const Value: string);

  public
    constructor Create();
    destructor Destroy; override;
    procedure pCarregaFornecedor(strCodFor: string);
    procedure pSalvar(strCodFor: string = '');
    procedure pCancelar;
    property strCodFor: string Read FCodFor;
    property TipoPedido: String read getTipoPedido write setTipoPedido;
    property DivisaoVenda: string read getDivVenda write setDivVenda;
    property PathGeracao : string read getpathGeracao write setPathGeracao;
    property TipoEntrega : string read getTipoEntrega write setTipoEntrega;
    property state: TDataSetState read getState;
    property blnPermiteEdicao: Boolean read FblnPermiteEdicao write FblnPermiteEdicao;
  end;

implementation

{ TFornecedorBosh }


constructor TFornecedorBosh.Create();
begin
  FQryControle := TZClient.Create(nil, 'SELECT * FROM FORBOS WHERE FALSE');
  FQryControle.Open;
  blnPermiteEdicao := True;
end;

procedure TFornecedorBosh.pCancelar;
begin
  If (FQryControle.State in dsEditModes) then
    FQryControle.Cancel;
end;

procedure TFornecedorBosh.pCarregaFornecedor(strCodFor: string);
begin
  FCodFor := strCodFor;

  If fEmptyStr(FCodFor) Then
    FQryControle.qryQuery.SQL.Text := 'SELECT * FROM FORBOS WHERE FALSE;'
  Else
    FQryControle.qryQuery.SQL.Text := 'SELECT * FROM FORBOS WHERE BOS_CODFOR = ' + QuotedStr(FCodFor);
  FQryControle.fAbreClient(True, 'TFornecedorBosh.pCarregaFornecedor');
  FblnInsert := FQryControle.IsEmpty;
end;

function TFornecedorBosh.fColocarEmEdicao: Boolean;
begin
  Result := False;
  Try
    If Not blnPermiteEdicao Then
      Exit;
    If not (FQryControle.State in dsEditModes) then
    Begin
      If FblnInsert Then
      Begin
        FqryControle.Insert;
        FQryControle.FieldByName('BOS_CODFOR').AsString := FCodFor;
      End
      else
        FqryControle.Edit;
    End;
  Finally
    Result := (FQryControle.State in dsEditModes);
  End;
end;

procedure TFornecedorBosh.pSalvar(strCodFor: string = '');
begin
  If FCodFor = '' Then
     FCodFor :=  strCodFor;
  If (Not fEmptyStr(FCodFor)) And (FQryControle.State in dsEditModes) Then
  begin
    Try
       FQryControle.FieldByName('BOS_CODFOR').AsString := FCodFor;
       FQryControle.Post;
       FQryControle.fSalva;

    Except
      on E: exception do
         raise E;
    End;
  End;
end;

function TFornecedorBosh.getState: TDataSetState;
begin
  Result := FQryControle.State;
end;

destructor TFornecedorBosh.Destroy;
begin
  FreeAndNil(FQryControle);
  inherited;
end;

function TFornecedorBosh.getDivVenda: string;
begin
  If not FEmptyStr(FCodFor) Then
  Result := FQryControle.FieldByName('BOS_DIVVEN').AsString;
end;

procedure TFornecedorBosh.setDivVenda(const Value: string);
begin
  If FQryControle.FieldByName('BOS_DIVVEN').AsString = Value Then
     Exit;
  if fColocarEmEdicao Then
    FQryControle.FieldByName('BOS_DIVVEN').AsString := Value;
end;

procedure TFornecedorBosh.setPathGeracao(const Value: string);
begin
  If Value = FQryControle.FieldByName('BOS_PATARQ').AsString Then
     Exit;
  if fColocarEmEdicao Then
     FQryControle.FieldByName('BOS_PATARQ').AsString := Value;
end;

function TFornecedorBosh.getpathGeracao: string;
begin
  If not FEmptyStr(FCodFor) Then
    Result := FQryControle.FieldByName('BOS_PATARQ').AsString;
end;

procedure TFornecedorBosh.setTipoEntrega(const Value: string);
begin
  If Value = FQryControle.FieldByName('BOS_TIPENT').AsString Then
     Exit;

  if fColocarEmEdicao Then
     FQryControle.FieldByName('BOS_TIPENT').AsString := Value;
end;

function TFornecedorBosh.getTipoEntrega: string;
begin
  If not FEmptyStr(FCodFor) Then
    Result := FQryControle.FieldByName('BOS_TIPENT').AsString;
end;

procedure TFornecedorBosh.setTipoPedido(const Value: string);
begin
  If FQryControle.FieldByName('BOS_TIPPED').AsString = Value Then
    Exit;
  if fColocarEmEdicao Then
    FQryControle.FieldByName('BOS_TIPPED').AsString := Value;
end;

function TFornecedorBosh.getTipoPedido: string;
begin
  If not FEmptyStr(FCodFor) Then
    Result := FQryControle.FieldByName('BOS_TIPPED').AsString;
end;

end.

