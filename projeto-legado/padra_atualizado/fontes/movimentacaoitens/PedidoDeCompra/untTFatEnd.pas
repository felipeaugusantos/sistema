unit untTFatEnd;

interface

uses
  Uni,
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core;
{$ELSE}
  untFuncoesSimples;
{$ENDIF}

type
  IFatEnd = interface
  ['{F92527FA-23E3-4AD9-854F-90FAB869958E}']
    function fSeqGer(strAutoIncrem: String): IFatEnd;
    function fQtdIte(curQtdIte: Double): IFatEnd;
    function fCodIte(strCodIte: String): IFatEnd;
    function fExecutar: IFatEnd;
    function fSetSequencia(var ASequencia: string): IFatEnd;
    function fGetSequenciaGerada: string;
  end;

  TFatEnd = class(TInterfacedObject,  IFatEnd)
  private
    FqryDB: TUniQuery;
    FstrSeqGer: String;
    FcurQtdIte: Double;
    FstrCodIte: String;
    FSequencia: String;
  public
    function fSeqGer(strSeqGer: String): IFatEnd;
    function fCodIte(strCodIte: String): IFatEnd;
    function fQtdIte(curQtdIte: Double): IFatEnd;
    function fSetSequencia(var ASequencia: string): IFatEnd;
    function fExecutar: IFatEnd;
    function fGetSequenciaGerada: string;

    constructor Create;
    destructor Destroy; override;
    class function fNew: IFatEnd;
  end;

implementation

uses
  untTEnderecamentoConferenciaParcial;

{ TFatEnd }

constructor TFatEnd.Create;
begin
  FqryDB := fCriaQuery;
end;

destructor TFatEnd.Destroy;
begin
  FqryDB.Free;
  inherited;
end;

function TFatEnd.fCodIte(strCodIte: String): IFatEnd;
begin
  Result := Self;
  FstrCodIte := strCodIte;
end;

function TFatEnd.fExecutar: IFatEnd;
begin
  FSequencia := TEnderecamentoConferenciaParcial.GerarCodigoUnico(strLoginUsuarioLogado);
  Result := Self;
  FqryDB.SQL.Clear;
  FqryDB.SQL.Add('INSERT INTO FATEND (AUTOINCREM, FTE_SEQGER, FTE_CODITE, FTE_QTDITE, FTE_SEQUEN) ');
  FqryDB.SQL.Add('VALUES (:AUTOINCREM, :FTE_SEQGER, :FTE_CODITE, :FTE_QTDITE, :FTE_SEQUEN)');
  FqryDB.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('FATEND', VS_StrCodEmp);;
  FqryDB.ParamByName('FTE_SEQGER').AsString := FstrSeqGer;
  FqryDB.ParamByName('FTE_CODITE').Value := FstrCodIte;
  FqryDB.ParamByName('FTE_QTDITE').Value := FcurQtdIte;
  FqryDB.ParamByName('FTE_SEQUEN').Value := FSequencia;

  FqryDB.ExecSQL;
end;

function TFatEnd.fGetSequenciaGerada(): string;
begin
  Result := FSequencia;
end;

class function TFatEnd.fNew: IFatEnd;
begin
  result := TFatEnd.Create;
end;

function TFatEnd.fQtdIte(curQtdIte: Double): IFatEnd;
begin
  Result := Self;
  FcurQtdIte := curQtdIte;
end;

function TFatEnd.fSeqGer(strSeqGer: String): IFatEnd;
begin
  Result := Self;
  FstrSeqGer := strSeqGer;
end;

function  TFatEnd.fSetSequencia(var ASequencia: string): IFatEnd;
begin
  If fEmptyStr(ASequencia) Then
    FSequencia := TEnderecamentoConferenciaParcial.GerarCodigoUnico(strLoginUsuarioLogado)
  Else
    FSequencia := ASequencia;

  ASequencia := FSequencia;
  Result := Self;
end;

end.
