unit untTControlaReservaDevolucaoVenda;

interface

uses
  System.SysUtils, System.Classes, Generics.Collections, Uni, untFuncoesSimples;

type
  TItemReserva = record
    IncFatDor: string;  // Corresponde a DEV_INCFDO
    Quantidade: Double;    // Corresponde a DEV_QTDBAI
    IncMovDetEntrada: string;
  end;

  TItemReservaDB = record
    IncMovGer: string;       // DEV_INCVEN
    IncFatGor: string;     // DEV_INCRES
    IncFatDor: string; // DEV_INCFDO
    Quantidade: Double;    // DEV_QTDBAI
  end;

  TControlaReservaDevolucaoVenda = class
  private
    FListaItens: TList<TItemReserva>;
    FIncMovGer: string;
    FIncFatGor: string;
    qryConsulta: TUniQuery;
    function GetCount: Integer;
    function ConsultarDevVen(IncMovDet: String): Boolean;
  public
    constructor Create(AIncMovGer, AIncFatGor: string);
    destructor Destroy; override;

    // Métodos para manipulação de itens
    procedure AdicionarItem(const AItem: TItemReserva); overload;
    procedure AdicionarItem(const AIncFatDor, AIncMovDetEntrada: string; Quantidade: Double); overload;
    function BuscarPorIncFatDor(const AIncFatdor: string; out Item: TItemReserva): Boolean;
    function ContemFatDor(const AIncFatDor: string): Boolean;
    procedure LimparItens;

    // Métodos de persistência
    procedure PersistirItens;
    function ConsultarPorVenda(const AIncMovGer: string): TArray<TItemReservaDB>;

    // Propriedades
    property IncMovGer: string read FIncMovGer write FIncMovGer;
    property IncFatGor: string read FIncFatGor write FIncFatGor;
    property Count: Integer read GetCount;
  end;
  TTabelaEncontrada = (tteIndefinida, tteDelFatgor, tteFatgor);

  TGestorReservaDevolucao = class
  private
    FTabelaEncontrada: TTabelaEncontrada;
    FDadosItens: TArray<TItemReservaDB>;
    FAntesDeAtualizarRestauraFatDor: Boolean;
    qryConsulta: TUniquery;
    function ExisteNaTabela(const Tabela, AAutInc: string): Boolean;
    procedure ObterTabela(const AIncFatGor: string);
    procedure AtualizarQuantidades;
    procedure pRestauraFatdorSePreciso(AIncFatDor: String);
    procedure pCarregaItens(const AIncMovGer: string);
  public
    constructor Create();
    destructor Destroy; override;
    procedure pRemoveDEVVEN(const AIncMovGer: string);
    procedure Restaurar(const AIncMovGer: string);
    class procedure ExecuteRestauracaoReservaDevolucaoSemWms(AIncMovGer: String);
    class function TemDevolucaoRealizada(AIncMovGer: String): Boolean;
    class procedure RemoverDevVen(AIncMovGer: String);
  end;

implementation

uses
  untTRestauraDel;

{ TControlaReservaDevolucaoVenda }

constructor TControlaReservaDevolucaoVenda.Create(AIncMovGer, AIncFatGor: string);
begin
  inherited Create;
  FListaItens := TList<TItemReserva>.Create;
  FIncMovGer := AIncMovGer;
  FIncFatGor := AIncFatGor;
  qryConsulta := fCriaQuery;
end;

destructor TControlaReservaDevolucaoVenda.Destroy;
begin
  FreeAndNil(FListaItens);
  FreeAndNil(qryConsulta);
  inherited;
end;

procedure TControlaReservaDevolucaoVenda.AdicionarItem(const AItem: TItemReserva);
begin
  FListaItens.Add(AItem);
end;

procedure TControlaReservaDevolucaoVenda.AdicionarItem(const AIncFatDor, AIncMovDetEntrada: string; Quantidade: Double);
var
  Item: TItemReserva;
begin
  Item.IncFatDor := AIncFatDor;
  Item.Quantidade := Quantidade;
  Item.IncMovDetEntrada := AIncMovDetEntrada;
  FListaItens.Add(Item);
end;

function TControlaReservaDevolucaoVenda.BuscarPorIncFatDor(const AIncFatDor: string; out Item: TItemReserva): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FListaItens.Count - 1 do
  begin
    if SameText(FListaItens[I].IncFatDor, AIncFatDor) then
    begin
      Item := FListaItens[I];
      Exit(True);
    end;
  end;
end;

function TControlaReservaDevolucaoVenda.ContemFatDor(const AIncFatDor: string): Boolean;
var
  Item: TItemReserva;
begin
  Result := BuscarPorIncFatDor(AIncFatDor, Item);
end;

procedure TControlaReservaDevolucaoVenda.LimparItens;
begin
  FListaItens.Clear;
end;

function TControlaReservaDevolucaoVenda.GetCount: Integer;
begin
  Result := FListaItens.Count;
end;

procedure TControlaReservaDevolucaoVenda.PersistirItens;
var
  qryComand: TUniQuery;
  Item: TItemReserva;
begin

  if FListaItens.Count = 0 then
    Exit;

  if (FIncMovGer = '')  then
    raise Exception.Create('Precisa Definir o identificador da venda e da reserva antes de persistir');

  qryComand := fCriaQuery;
  try
    try
      for Item in FListaItens do
      begin
        If ConsultarDevVen(Item.IncMovDetEntrada) Then
        Begin
          qryComand.SQL.Text :=
            'UPDATE DEVVEN SET DEV_INCVEN = :VENDA' +
            ' WHERE DEV_SEQDET = :DEV_SEQDET';
        End
        Else
        Begin
          qryComand.SQL.Text :=
            'INSERT INTO DEVVEN (DEV_INCVEN, DEV_INCRES, DEV_QTDBAI, DEV_INCFDO, DEV_SEQDET) ' +
            'VALUES (:VENDA, :RESERVA, :QUANTIDADE, :DEV_INCFDO, :DEV_SEQDET)';
          qryComand.ParamByName('RESERVA').Clear;
          If not fEmptyStr(FIncFatGor) Then
            qryComand.ParamByName('RESERVA').AsString := FIncFatGor;

          qryComand.ParamByName('QUANTIDADE').AsFloat := Item.Quantidade;

          qryComand.ParamByName('DEV_INCFDO').Clear;
          If not fEmptyStr(Item.IncFatDor) Then
            qryComand.ParamByName('DEV_INCFDO').AsString := Item.IncFatDor;
        End;

        qryComand.ParamByName('VENDA').AsString := FIncMovGer;
        qryComand.ParamByName('DEV_SEQDET').AsString := Item.IncMovDetEntrada;
        qryComand.ExecSQL;
      end;
    except
      on E: Exception do
        raise Exception.Create('TControlaReservaDevolucaoVenda.PersistirItens: ' + E.Message);
    end;
  finally
    FreeAndNIl(qryComand);
  end;
end;

function TControlaReservaDevolucaoVenda.ConsultarDevVen(IncMovDet: String): Boolean;
var
  qryComand: TUniQuery;
begin
  Result := False;
  qryComand := fCriaQuery;
   try
    try
      qryComand.SQl.Text := 'SELECT 1 FROM DEVVEN WHERE ' +
        ' DEV_SEQDET = :DEV_SEQDET';
      qryComand.ParamByName('DEV_SEQDET').AsString := IncMovDet;
      qryComand.Open;
      Result := Not qryComand.IsEmpty;
    except
      on E: Exception do
        raise Exception.Create('TControlaReservaDevolucaoVenda.ConsultarDevVen: ' + E.Message);
    end;
  Finally
    FreeAndNIl(qryComand);
  end;
End;

function TControlaReservaDevolucaoVenda.ConsultarPorVenda(const AIncMovGer: string): TArray<TItemReservaDB>;
var
  Itens: TArray<TItemReservaDB>;
  I: Integer;
begin
  qryConsulta.Close;
  qryConsulta.SQL.Text :=
    'SELECT DEV_INCVEN, DEV_INCRES, DEV_QTDBAI, DEV_INCFDO ' +
    'FROM DEVVEN WHERE DEV_INCVEN = :ID_VENDA';
  qryConsulta.ParamByName('ID_VENDA').AsString := AIncMovGer;
  qryConsulta.Open;

  SetLength(Itens, qryConsulta.RecordCount);
  I := 0;

  while not qryConsulta.Eof do
  begin
    Itens[I].IncMovGer := qryConsulta.FieldByName('DEV_INCVEN').AsString;
    Itens[I].IncFatGor := qryConsulta.FieldByName('DEV_INCRES').AsString;
    Itens[I].Quantidade := qryConsulta.FieldByName('DEV_QTDBAI').AsFloat;
    Itens[I].IncFatDor := qryConsulta.FieldByName('DEV_INCFDO').AsString;

    qryConsulta.Next;
    Inc(I);
  end;

  Result := Itens;
end;

{ TGestorReservaDevolucao }

constructor TGestorReservaDevolucao.Create();
begin
  inherited Create;
  qryConsulta := fCriaQuery;
  FTabelaEncontrada := TTabelaEncontrada.tteIndefinida;
end;

destructor TGestorReservaDevolucao.Destroy;
begin
  FreeAndNil(qryConsulta);
  inherited;
end;

class procedure TGestorReservaDevolucao.ExecuteRestauracaoReservaDevolucaoSemWms(AIncMovGer: String);
var GestorReservaDevolucao: TGestorReservaDevolucao;
begin
  If AIncMovGer = '' Then
    Exit;
  GestorReservaDevolucao := TGestorReservaDevolucao.Create;
  Try
    GestorReservaDevolucao.Restaurar(AIncMovGer);

  Finally
    FreeAndNil(GestorReservaDevolucao);
  End;

end;

function TGestorReservaDevolucao.ExisteNaTabela(const Tabela, AAutInc: string): Boolean;
begin
  qryConsulta.Close;
  qryConsulta.SQL.Text := 'SELECT 1 FROM ' + Tabela + ' WHERE AUTOINCREM = :AUTINC';
  qryConsulta.ParamByName('AUTINC').AsString := AAutInc;
  qryConsulta.Open;
  Result := not qryConsulta.IsEmpty;
end;

procedure TGestorReservaDevolucao.ObterTabela(const AIncFatGor: string);
begin
  // Primeiro tenta na FATGOR
  if ExisteNaTabela('FATGOR', AIncFatGor) then
    FTabelaEncontrada := TTabelaEncontrada.tteFatgor
  // tenta na DEL_FATGOR
  Else if ExisteNaTabela('DEL_FATGOR', AIncFatGor) then
    FTabelaEncontrada := TTabelaEncontrada.tteDelFatgor;
end;

procedure TGestorReservaDevolucao.pCarregaItens(const AIncMovGer: string);
var  lControlador: TControlaReservaDevolucaoVenda;
begin
  lControlador := TControlaReservaDevolucaoVenda.Create(AIncMovGer, '');
  Try
    SetLength(FDadosItens, 0);
    FDadosItens := lControlador.ConsultarPorVenda(AIncMovGer);
  Finally
    FreeAndNil(lControlador);
  End;
End;

procedure TGestorReservaDevolucao.pRemoveDEVVEN(const AIncMovGer: string);
begin
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('DELETE FROM DEVVEN WHERE DEV_INCVEN = "'+AIncMovGer+'"');
  qryConsulta.ExecSQL;
end;

procedure TGestorReservaDevolucao.pRestauraFatdorSePreciso(AIncFatDor: String);
begin
  qryConsulta.Close;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.add('SELECT * FROM FATDOR WHERE AUTOINCREM = "'+AIncFatDor+'"');
  qryConsulta.Open;
  If qryConsulta.IsEmpty Then
  Begin
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.add('SELECT * FROM DEL_FATDOR WHERE AUTOINCREM = "'+AIncFatDor+'"');
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
      TRestauraDel.pRestauraTabela('FATDOR', AIncFatDor);
  End;
end;

procedure TGestorReservaDevolucao.AtualizarQuantidades();
var
  I: Integer;
  qryComand: TUniQuery;

begin

  qryComand := fCriaQuery;

  try
    try
      qryComand.SQL.Text :=
        'UPDATE FATDOR ' +
        'SET FDO_QTDBAI = FDO_QTDBAI - :QUANTIDADE ' +
        'WHERE AUTOINCREM = :AUTINC';

      for I := 0 to High(FDadosItens) do
      begin
        If FAntesDeAtualizarRestauraFatDor then
          pRestauraFatdorSePreciso(FDadosItens[I].IncFatDor);

        qryComand.ParamByName('QUANTIDADE').AsFloat := FDadosItens[I].Quantidade;
        qryComand.ParamByName('AUTINC').AsString := FDadosItens[I].IncFatDor;
        qryComand.ExecSQL;
      end;
    except
      on E: Exception do
        raise Exception.Create('Erro ao atualizar quantidades: ' + E.Message);
    end;
  finally
    FreeAndNil(qryComand);
  end;
end;

procedure TGestorReservaDevolucao.Restaurar(const AIncMovGer: string);
begin
  pCarregaItens(AIncMovGer);
  If High(FDadosItens) = -1 Then
    Exit;
  ObterTabela(FDadosItens[0].IncFatGor);
  If FTabelaEncontrada = tteIndefinida then
    Exit;
  FAntesDeAtualizarRestauraFatDor := false;
  If FTabelaEncontrada = tteDelFatgor then
    TRestauraDel.pRestauraTabela('FATGOR', FDadosItens[0].IncFatGor);
  If FTabelaEncontrada = tteFatgor then
    FAntesDeAtualizarRestauraFatDor := True;

  AtualizarQuantidades;
  pRemoveDEVVEN(AIncMovGer);
end;

class function TGestorReservaDevolucao.TemDevolucaoRealizada(AIncMovGer: String): Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
  qryConsulta.sql.Add('SELECT  COUNT(1) QTD');
  qryConsulta.sql.Add('  FROM DEVVEN');
  qryConsulta.sql.Add(' WHERE DEV_SEQDET IN (SELECT MOVDET.AUTOINCREM');
  qryConsulta.sql.Add('                        FROM MOVDET');
  qryConsulta.sql.Add('                       WHERE MOVDET.DET_SEQGER =  "'+AIncMovGer+'" )');
    qryConsulta.Open;
    Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
  finally
    FreeAndNil(qryConsulta);
  End;
end;


class procedure TGestorReservaDevolucao.RemoverDevVen(AIncMovGer: String);
var
  GestorReservaDevolucao: TGestorReservaDevolucao;
begin
  GestorReservaDevolucao := TGestorReservaDevolucao.Create;
  Try
    GestorReservaDevolucao.pRemoveDEVVEN(AIncMovGer);
  Finally
    FreeAndNil(GestorReservaDevolucao);
  End;
end;



end.

