unit untTMovIcdRepository;

interface

uses System.Generics.Collections;

type
  TEvGrvCtp = function(Soma: Double; Historico: String): boolean of object;

  TMovIcdParametros = record
    strNumDoc: String;
    strEspDoc: String;
    strEmpDoc: String;
    strCodCli: String;
    strOpcDoc: String;
  End;

  IMovIcdSoma = interface
    ['{C7C5FD8D-BA01-4D3A-B778-DF2DF4261342}']
    function Soma : Double;
    function Historico : String;
  end;

  IMovIcdGravaCtp = interface
    ['{C41E6301-562D-4112-A8D0-4F874CDA1222}']
    function Add(Soma : IMovIcdSoma) : IMovIcdGravaCtp;
    function SetGravador(Value: TEvGrvCtp): IMovIcdGravaCtp;
    function Gravar: Boolean;
  end;

  TMovIcdGravaCtp = Class(TInterfacedObject, IMovIcdGravaCtp)
  private
    FLista : TList<IMovIcdSoma>;
    FEvGrvCtp : TEvGrvCtp;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IMovIcdGravaCtp;
    function Add(Soma : IMovIcdSoma) : IMovIcdGravaCtp;
    function SetGravador(Value: TEvGrvCtp): IMovIcdGravaCtp;
    function Gravar: Boolean;
  End;

  TMovIcdSomaIcmsDifalDestino = Class(TInterfacedObject, IMovIcdSoma)
  private
    FblnZerar : Boolean;
    FrecPar : TMovIcdParametros;
    FstrHistor : String;
  public
    constructor Create(recPar: TMovIcdParametros; blnZerar: Boolean; strHistor: String);
    destructor Destroy; override;
    class function New(recPar: TMovIcdParametros; blnZerar : Boolean; strHistor: String): IMovIcdSoma;
    function Soma: Double;
    function Historico : String;
  end;

  TMovIcdSomaIcmsFCP = Class(TInterfacedObject, IMovIcdSoma)
  private
    FblnZerar : Boolean;
    FrecPar: TMovIcdParametros;
    FstrHistor : String;
  public
    constructor Create(recPar: TMovIcdParametros; blnZerar: Boolean; strHistor : String);
    destructor Destroy; override;
    class function New(recPar: TMovIcdParametros; blnZerar: Boolean; strHistor : String): IMovIcdSoma;
    function Soma: Double;
    function Historico : String;
  end;

implementation

uses
  System.SysUtils, Uni, untFuncoesSimples;

{ TMovIcdGravaCtp }

function TMovIcdGravaCtp.Add(Soma : IMovIcdSoma) : IMovIcdGravaCtp;
begin
  Result := Self;
  FLista.Add(Soma);
end;

constructor TMovIcdGravaCtp.Create;
begin
  FLista := TList<IMovIcdSoma>.Create;
end;

destructor TMovIcdGravaCtp.Destroy;
begin
  FreeAndNil(FLista);
  inherited;
end;

function TMovIcdGravaCtp.Gravar: Boolean;
  var
    intCnt : Integer;
begin
  Result := True;
  for intCnt := 0 To Pred(FLista.Count) do
  begin
    Result := FEvGrvCtp(FLista[intCnt].Soma, FLista[intCnt].Historico);
    if not Result then
      break;
  end;
end;

class function TMovIcdGravaCtp.New: IMovIcdGravaCtp;
begin
  Result := Self.Create;
end;

function TMovIcdGravaCtp.SetGravador(Value: TEvGrvCtp): IMovIcdGravaCtp;
begin
  Result := Self;
  FEvGrvCtp := Value;
end;

{ TMovIcdSomaIcmsDifalDestino }

constructor TMovIcdSomaIcmsDifalDestino.Create(recPar: TMovIcdParametros; blnZerar: Boolean; strHistor: String);
begin
  FrecPar := recPar;
  FblnZerar := blnZerar;
  FstrHistor := strHistor;
end;

destructor TMovIcdSomaIcmsDifalDestino.Destroy;
begin

  inherited;
end;

function TMovIcdSomaIcmsDifalDestino.Historico: String;
begin
  Result := FstrHistor;
end;

class function TMovIcdSomaIcmsDifalDestino.New(recPar: TMovIcdParametros; blnZerar : Boolean; strHistor: String): IMovIcdSoma;
begin
  Result := Self.Create(recPar, blnZerar, strHistor);
end;

function TMovIcdSomaIcmsDifalDestino.Soma: Double;
  var
    qryAux : TUniQuery;
begin
  if FblnZerar then
    Exit(0);

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Clear;

    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  SUM(ICD_VALDES) AS ICMS_DIFAL_DESTINO ');
    qryAux.SQL.Add('FROM ');

    If Pos(FrecPar.strOpcDoc, 'CF_CI_CT_CN_') <= 0 Then
    Begin
      qryAux.SQL.Add('  MOVDET ');
      qryAux.SQL.Add('  INNER JOIN MOVICD ');
      qryAux.SQL.Add('    ON ICD_SEQGER = MOVDET.AUTOINCREM ');
    End
    Else
    Begin
      qryAux.SQL.Add('  NOTDET ');
      qryAux.SQL.Add('  INNER JOIN NOTICD ');
      qryAux.SQL.Add('    ON ICD_SEQGER = NOTDET.AUTOINCREM ');
    End;

    qryAux.SQL.Add('WHERE DET_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND DET_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND DET_CODEMP = :CODEMP ');
    qryAux.SQL.Add('  AND DET_CODCLI = :CODCLI ');

    qryAux.Close;
    qryAux.ParamByName('NUMDOC').AsString := FrecPar.strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FrecPar.strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FrecPar.strEmpDoc;
    qryAux.ParamByName('CODCLI').AsString := FrecPar.strCodCli;

    qryAux.Open;
    Result := qryAux.FieldByName('ICMS_DIFAL_DESTINO').AsFloat;
    qryAux.Close;
  Finally
    FreeAndNil(qryAux);
  End;
end;

{ TMovIcdSomaIcmsFCP }

constructor TMovIcdSomaIcmsFCP.Create(recPar: TMovIcdParametros; blnZerar: Boolean; strHistor : String);
begin
  FblnZerar := blnZerar;
  FrecPar := recPar;
  FstrHistor := strHistor;
end;

destructor TMovIcdSomaIcmsFCP.Destroy;
begin

  inherited;
end;

function TMovIcdSomaIcmsFCP.Historico: String;
begin
  Result := FstrHistor;
end;

class function TMovIcdSomaIcmsFCP.New(recPar: TMovIcdParametros; blnZerar: Boolean; strHistor : String): IMovIcdSoma;
begin
  Result := Self.Create(recPar, blnZerar, strHistor);
end;

function TMovIcdSomaIcmsFCP.Soma: Double;
  var
    qryAux : TUniQuery;
begin
  if FblnZerar then
    Exit(0);

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Clear;

    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  SUM(ICD_VALFCP) AS FCP_ICMS ');
    qryAux.SQL.Add('FROM ');

    If Pos(FrecPar.strOpcDoc, 'CF_CI_CT_CN_') <= 0 Then
    Begin
      qryAux.SQL.Add('  MOVDET ');
      qryAux.SQL.Add('  INNER JOIN MOVICD ');
      qryAux.SQL.Add('    ON ICD_SEQGER = MOVDET.AUTOINCREM ');
    End
    Else
    Begin
      qryAux.SQL.Add('  NOTDET ');
      qryAux.SQL.Add('  INNER JOIN NOTICD ');
      qryAux.SQL.Add('    ON ICD_SEQGER = NOTDET.AUTOINCREM ');
    End;

    qryAux.SQL.Add('WHERE DET_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND DET_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND DET_CODEMP = :CODEMP ');
    qryAux.SQL.Add('  AND DET_CODCLI = :CODCLI ');
    qryAux.SQL.Add('  AND DET_VALRET = 0 ');

    qryAux.Close;
    qryAux.ParamByName('NUMDOC').AsString := FrecPar.strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FrecPar.strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FrecPar.strEmpDoc;
    qryAux.ParamByName('CODCLI').AsString := FrecPar.strCodCli;

    qryAux.Open;
    Result := qryAux.FieldByName('FCP_ICMS').AsFloat;
    qryAux.Close;
  Finally
    FreeAndNil(qryAux);
  End;
end;

end.
