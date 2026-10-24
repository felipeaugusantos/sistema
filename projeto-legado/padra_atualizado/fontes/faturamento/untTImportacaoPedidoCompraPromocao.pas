unit untTImportacaoPedidoCompraPromocao;

interface

uses
  Uni,
  Data.DB,
  System.Classes,
  System.SysUtils,
  UniClientDataSet;

resourcestring
  sqlCarregaPedidoCompra = 'SELECT                                            '+
                           '  P.PCG_DTAENT,                                   '+
                           '  P.PCG_NUMPED,                                   '+
                           '  P.PCG_CODEMP,                                   '+
                           '  P.PCG_NUMCTN,                                   '+
                           '  CONCAT(P.PCG_CODFOR, " - ", F.FOR_NOMFOR) FORNEC'+
                           '  FROM PCMGER P                                   '+
                           '  JOIN CADFOR F ON F.FOR_CODFOR = P.PCG_CODFOR    '+
                           ' WHERE P.PCG_NUMPED = :NUMPED                     '+
                           '   AND P.PCG_CODEMP = :CODEMP                     ';

type
  TImportacaoPedidoCompraPromocao = Class
  private
    FdtsPedidos: TDataSource;
    FcdsPedidos: TUniClientDataSet;

    function fCriaCdsPedidos: TUniClientDataSet;
    function getStlPedidos: TStringList;
  public
    constructor Create;
    destructor Destroy; Override;

    property dtsPedidos: TDataSource read FdtsPedidos;
    property stlPedidos: TStringList read getStlPedidos;

    function fAdicionaPedido(Const strNumPed, strCodEmp: String;
      Const blnExibeAviso: Boolean = True): Boolean;
    procedure pRemovePedido(Const strNumPed, strCodEmp: String);
  End;

implementation

uses
  System.Variants,
  untFuncoesSimples;

{ TImportacaoPedidoCompraPromocao }

constructor TImportacaoPedidoCompraPromocao.Create;
begin
  FcdsPedidos := fCriaCdsPedidos();
  FdtsPedidos := fCriaDataSource(FcdsPedidos);
end;

destructor TImportacaoPedidoCompraPromocao.Destroy;
begin
  FreeAndNil(FdtsPedidos);
  FreeAndNil(FcdsPedidos);
  inherited;
end;

function TImportacaoPedidoCompraPromocao.fAdicionaPedido(Const strNumPed, strCodEmp: String;
  Const blnExibeAviso: Boolean = True): Boolean;
var
  qryGen: TUniQuery;
begin
  Result := True;

  If FcdsPedidos.Locate('PCG_NUMPED;PCG_CODEMP', VarArrayOf([strNumPed, strCodEmp]), []) Then
  Begin
    If blnExibeAviso Then
      fMensagem('', 'Pedido já adicionado!', ['&OK']);

    Result := False;
  End
  Else
  Begin
    qryGen := fCriaQuery();

    Try
      qryGen.SQL.Clear();
      qryGen.SQL.Add(sqlCarregaPedidoCompra);
      qryGen.ParamByName('NUMPED').AsString := strNumPed;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.Open();

      If qryGen.IsEmpty Then
      Begin
        If blnExibeAviso Then
          fMensagem('', 'Pedido não encontrado para a empresa informada!', ['&OK']);

        Result := False;
      End;

      If Result Then
      Begin
        FcdsPedidos.AppendRecord([qryGen.FieldByName('PCG_DTAENT').AsDateTime,
                                  qryGen.FieldByName('PCG_NUMPED').AsString,
                                  qryGen.FieldByName('PCG_CODEMP').AsString,
                                  qryGen.FieldByName('PCG_NUMCTN').AsString,
                                  qryGen.FieldByName('FORNEC').AsString]);
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

function TImportacaoPedidoCompraPromocao.fCriaCdsPedidos: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PCG_DTAENT';
    DataType := ftDateTime;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PCG_NUMPED';
    DataType := ftString;
    Size     := 12;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PCG_CODEMP';
    DataType := ftString;
    Size     := 10;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PCG_NUMCTN';
    DataType := ftInteger;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FORNEC';
    DataType := ftString;
    Size     := 100;
    Required := False;
  End;

  Result.CreateDataSet;
end;

function TImportacaoPedidoCompraPromocao.getStlPedidos: TStringList;
begin
  Result := TStringList.Create;

  FcdsPedidos.First();
  While (Not FcdsPedidos.Eof) Do
  Begin
    Result.Add(Concat(FcdsPedidos.FieldByName('PCG_NUMPED').AsString, ';',
                      FcdsPedidos.FieldByName('PCG_CODEMP').AsString, ';',
                      FcdsPedidos.FieldByName('PCG_NUMCTN').AsString));

    FcdsPedidos.Next();
  End;
end;

procedure TImportacaoPedidoCompraPromocao.pRemovePedido(const strNumPed,
  strCodEmp: String);
begin
  If FcdsPedidos.Locate('PCG_NUMPED;PCG_CODEMP', VarArrayOf([strNumPed, strCodEmp]), []) Then
    FcdsPedidos.Delete();
end;

end.
