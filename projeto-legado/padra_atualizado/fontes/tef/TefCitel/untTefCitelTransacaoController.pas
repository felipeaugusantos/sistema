unit untTefCitelTransacaoController;

interface

uses
  System.SysUtils, System.Classes,
  Data.Db, Uni, UniClientDataset,
  untTefCitelTransacaoInterfaces;

type
  TTransacaoTefController = class
  private
    FRepositorio: ITransacaoTefRepository;
    FViewControls: ITransacaoTefViewControls;
    FListaTransacoes: TTransacaoTefDadosLista;
    FCdsTransacoes: TUniClientDataset;

    procedure pLimparClientDataset;
    procedure pLimparLista;
    procedure pRenderizarClientDataset;
    procedure pCreateDataSet;
  public
    function fGetTrnStatus(const ASeq: Integer): TTransacaoTefStatus;
    function fGetTrn(const ASeq: Integer): TTransacaoTefDados;
    function fGetDataset: TDataset;
    function fGetViewControls: ITransacaoTefViewControls;

    function fBuscarTransacoesDia(const Adta: TDate): Boolean;
    function fBuscarTransacoesPendentes(const AdtaIni, AdtaFin: TDate): Boolean;
    function fBuscarTransacaoEspecifica(AParam: TTransacaoTefBuscaParam): Boolean;
    function fConfirmarTransacaoPendente(const ANSeq: Integer): Boolean;
    function fCancelarTransacaoPendente(const ANSeq: Integer): Boolean;

    procedure pClearDataSet;

    constructor Create();
    destructor Destroy; override;
  end;

implementation

uses
  untFuncoesSimples, untTefCitelTransacaoFactory;

{ TTransacaoTefController }

constructor TTransacaoTefController.Create;
var
  LFactory: ITransacaoTefFactory;
begin
  FListaTransacoes := nil;
  FCdsTransacoes := TUniClientDataset.Create(nil);
  LFactory := TTransacaoTefFactory.New;
  FRepositorio := LFactory.fRepository;
  FViewControls := LFactory.fViewControls;

  pCreateDataSet;
  FCdsTransacoes.Open;
end;

procedure TTransacaoTefController.pClearDataSet;
begin
  if FCdsTransacoes.Active then
    pLimparClientDataset;
end;

procedure TTransacaoTefController.pCreateDataSet;
var
  LField: TFieldDef;
begin
  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'SEQTRN';
  LField.DataType := ftInteger;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'DTAHRA';
  LField.DataType := ftDateTime;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'NUMNSU';
  LField.DataType := ftString;
  LField.Size := 16;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'CONTRO';
  LField.DataType := ftString;
  LField.Size := 16;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'TIPTRN';
  LField.DataType := ftString;
  LField.Size := 32;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'INFTRN';
  LField.DataType := ftString;
  LField.Size := 75;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'ESTADO';
  LField.DataType := ftString;
  LField.Size := 40;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'VALTRN';
  LField.DataType := ftFloat;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'CODSIT';
  LField.DataType := ftString;
  LField.Size := 16;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'CODRED';
  LField.DataType := ftString;
  LField.Size := 5;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'NOMRED';
  LField.DataType := ftString;
  LField.Size := 32;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'NOMBAN';
  LField.DataType := ftString;
  LField.Size := 32;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'NSUHOS';
  LField.DataType := ftString;
  LField.Size := 16;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'NUMCAR';
  LField.DataType := ftString;
  LField.Size := 20;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'CODLOJ';
  LField.DataType := ftString;
  LField.Size := 20;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'CODAUT';
  LField.DataType := ftString;
  LField.Size := 20;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'NUMPDV';
  LField.DataType := ftString;
  LField.Size := 20;

  LField := FCdsTransacoes.FieldDefs.AddFieldDef;
  LField.Name := 'QTDPAR';
  LField.DataType := ftInteger;

  FCdsTransacoes.CreateDataSet;
end;

destructor TTransacaoTefController.Destroy;
begin
  pLimparLista;
  FreeAndNil(FCdsTransacoes);
  inherited;
end;

function TTransacaoTefController.fBuscarTransacaoEspecifica(AParam: TTransacaoTefBuscaParam): Boolean;
var
  LTransTefDados: TTransacaoTefDados;
begin
  try
    pLimparLista;
    FListaTransacoes := TTransacaoTefDadosLista.Create;

    LTransTefDados := FRepositorio.fBuscarTransacao(AParam);
    FListaTransacoes.Add(LTransTefDados);

    pRenderizarClientDataset;
    Result := True;
  except
    pLimparLista;
    raise;
  end;
end;

function TTransacaoTefController.fBuscarTransacoesDia(const Adta: TDate): Boolean;
begin
  pLimparLista;
  try
    FListaTransacoes := FRepositorio.fBuscarTransacoesPorData(Adta);
    pRenderizarClientDataset;
    Result := True;
  except
    raise;
  end;
end;

function TTransacaoTefController.fBuscarTransacoesPendentes(const AdtaIni,
  AdtaFin: TDate): Boolean;
begin
  try
    pLimparLista;
    FListaTransacoes := FRepositorio.fBuscarTransacoesPendentes(AdtaIni, AdtaFin);
    pRenderizarClientDataset;
    Exit(True);
  except
    raise;
  end;
end;

function TTransacaoTefController.fCancelarTransacaoPendente(
  const ANSeq: Integer): Boolean;
begin
  try
    Result := FRepositorio.fCancelarTransacaoPendente(fGetTrn(ANSeq));
  except
    raise;
  end;
end;

function TTransacaoTefController.fConfirmarTransacaoPendente(
  const ANSeq: Integer): Boolean;
begin
  try
    Result := FRepositorio.fConfirmarTransacaoPendente(fGetTrn(ANSeq));
  except
    raise;
  end;
end;

function TTransacaoTefController.fGetDataset: TDataset;
begin
  Result := Self.FCdsTransacoes;
end;

function TTransacaoTefController.fGetTrn(
  const ASeq: Integer): TTransacaoTefDados;
begin
  if (ASeq <= 0) or ((FListaTransacoes.Count + 1) < ASeq) then
    raise TTrasacaoTefNotFoundException.Create('Dados da transação não encontrados.');

  Result := FListaTransacoes.Items[ASeq - 1];
end;

function TTransacaoTefController.fGetTrnStatus(
  const ASeq: Integer): TTransacaoTefStatus;
begin
  try
    Result := Self.fGetTrn(ASeq).Status;
  except
    on TENF: TTrasacaoTefNotFoundException do
      Result := stGenerico;

    on E: Exception do
      raise;
  end;
end;

function TTransacaoTefController.fGetViewControls: ITransacaoTefViewControls;
begin
  Result := Self.FViewControls;
end;

procedure TTransacaoTefController.pLimparClientDataset;
var
  LAfterScrollEvent: TDataSetNotifyEvent;
begin
  LAfterScrollEvent := FCdsTransacoes.AfterScroll ;
  FCdsTransacoes.AfterScroll := Nil ;
  try
    FCdsTransacoes.Filter := '';
    FCdsTransacoes.Filtered := False;
    if FCdsTransacoes.RecordCount > 0 then
      FCdsTransacoes.EmptyDataSet;
  finally
    FCdsTransacoes.AfterScroll := LAfterScrollEvent ;
  end ;
end;

procedure TTransacaoTefController.pLimparLista;
begin
  if Assigned(FListaTransacoes) then
    FreeAndNil(FListaTransacoes);

  FListaTransacoes := nil;

  pLimparClientDataset;
end;

procedure TTransacaoTefController.pRenderizarClientDataset;
var
  LTtrn: TTransacaoTefDados;
  LSeq: Integer;
  LAfterScroll: TDataSetNotifyEvent;
begin
  LAfterScroll := FCdsTransacoes.AfterScroll;
  FCdsTransacoes.AfterScroll := nil;
  FCdsTransacoes.DisableControls;

  try
    pLimparClientDataset;

    LSeq := 0;
    for LTtrn in FListaTransacoes do
    begin
      Inc(LSeq);

      FCdsTransacoes.Append;
      FCdsTransacoes.FieldByName('SEQTRN').AsInteger  := LSeq;
      FCdsTransacoes.FieldByName('DTAHRA').AsDateTime := LTtrn.DtaHra;
      FCdsTransacoes.FieldByName('NUMNSU').AsString   := LTtrn.NumNsu;
      FCdsTransacoes.FieldByName('CONTRO').AsString   := LTtrn.Contro;
      FCdsTransacoes.FieldByName('TIPTRN').AsString   := LTtrn.TipTrn;
      FCdsTransacoes.FieldByName('INFTRN').AsString   := LTtrn.InfTrn;
      FCdsTransacoes.FieldByName('ESTADO').AsString   := LTtrn.Estado;
      FCdsTransacoes.FieldByName('VALTRN').AsFloat    := LTtrn.ValTrn;
      FCdsTransacoes.FieldByName('CODSIT').AsString   := LTtrn.CodSit;
      FCdsTransacoes.FieldByName('CODRED').AsString   := LTtrn.CodRed;
      FCdsTransacoes.FieldByName('NOMRED').AsString   := LTtrn.NomRed;
      FCdsTransacoes.FieldByName('NOMBAN').AsString   := LTtrn.NomBan;
      FCdsTransacoes.FieldByName('NSUHOS').AsString   := LTtrn.NsuHos;
      FCdsTransacoes.FieldByName('NUMCAR').AsString   := LTtrn.NumCar;
      FCdsTransacoes.FieldByName('CODAUT').AsString   := LTtrn.CodAut;
      FCdsTransacoes.FieldByName('CODLOJ').AsString   := LTtrn.CodLoj;
      FCdsTransacoes.FieldByName('QTDPAR').AsInteger  := LTtrn.QtdPar;
      FCdsTransacoes.FieldByName('NUMPDV').AsString  :=  LTtrn.NumPdv;
      FCdsTransacoes.Post;
    end;

    FCdsTransacoes.First;
  finally
    FCdsTransacoes.EnableControls;
    FCdsTransacoes.AfterScroll := LAfterScroll;
  end;

end;

end.
