unit Contabilidade.Classes.TAbreviacaoContabilRep;

interface

uses Uni, Classes;

type
  TAbreviacaoContabilRep = class(TComponent)
  strict private
    FqryDados : TUniQuery;
    FTipLan: string;
    function getConta(strValor, strClaFis, strSeqGer: string; strCreDeb: string): string;
    procedure pCarregarDados(AQuery: TUniQuery);
  public
    constructor Create(ATipLan: string); reintroduce;
    destructor Destroy; override;
    function getContaDebito(strValor, strClaFis, strSeqGer: string): string;
    function getContaCredito(strValor, strClaFis, strSeqGer: string): string;
  end;

implementation

uses untFuncoesSimples, SysUtils, DB;

{ TAbreviacaoContabilRep }

constructor TAbreviacaoContabilRep.Create(ATipLan: string);
begin
  FqryDados := fCriaQuery(nil);
  FTipLan := ATipLan;
end;

destructor TAbreviacaoContabilRep.Destroy;
begin
  FreeAndNil(FqryDados);
  inherited;
end;

function TAbreviacaoContabilRep.getConta(strValor, strClaFis, strSeqGer,
  strCreDeb: string): string;
  var
    arrCodAbf : TArray<String>;
    strCodAbf : string;
begin
  Result := '';
  pCarregarDados(FqryDados);
  arrCodAbf := strSeqGer.Split([',']);
  for strCodAbf in arrCodAbf do
  begin
    if not strCodAbf.IsEmpty then
    begin
      FqryDados.Filter := 'COD_SEQGER = ' + strCodAbf.QuotedString + ' AND COD_DESVAL = ' + strValor.QuotedString + ' AND COD_CLAFIS = ' + strClaFis.QuotedString;
      FqryDados.Filtered := True;
      try
        if (not FqryDados.IsEmpty) then
        begin
          Result := IIF(strCreDeb = 'C', FqryDados.FieldByName('COD_CONCRE').AsString, FqryDados.FieldByName('COD_CONDEB').AsString);
          Break;
        end;
      finally
        FqryDados.Filtered := False;
        FqryDados.Filter := '';
      end;
    end;
  end;
end;

function TAbreviacaoContabilRep.getContaCredito(strValor, strClaFis, strSeqGer: string): string;
begin
  Result := getConta(strValor, strClaFis, strSeqGer, 'C');
end;

function TAbreviacaoContabilRep.getContaDebito(strValor, strClaFis, strSeqGer: string): string;
begin
  Result := getConta(strValor, strClaFis, strSeqGer, 'D');
end;

procedure TAbreviacaoContabilRep.pCarregarDados(AQuery: TUniQuery);
begin
  if not AQuery.Active then
  begin
    AQuery.Close;
    AQuery.SQL.Clear;
    AQuery.SQL.Add(' SELECT COD_CONDEB, COD_CONCRE, COD_DESVAL, COD_CLAFIS, COD_SEQGER ');
    AQuery.SQL.Add('   FROM ABFCOD ');
    AQuery.SQL.Add('  WHERE TRUE ');
    if (FTipLan = 'ENT') then
      AQuery.SQL.Add('  AND LEFT(COD_CLAFIS, 1) < "5" ')
    else if (FTipLan = 'SAI') then
      AQuery.SQL.Add('  AND LEFT(COD_CLAFIS, 1) >= "5" ');
    AQuery.SQL.Add(' ORDER BY COD_DESVAL, COD_CLAFIS, COD_SEQGER ');
    AQuery.Open;
  end;
end;

end.
