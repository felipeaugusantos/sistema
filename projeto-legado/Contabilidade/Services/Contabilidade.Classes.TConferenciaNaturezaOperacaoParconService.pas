unit Contabilidade.Classes.TConferenciaNaturezaOperacaoParconService;

interface

uses
  Contabilidade.Interfaces.TConferenciaNaturezaOperacaoParconService, Data.DB,
  System.SysUtils;

type
  TConferenciaNaturezaOperacaoParconService = class(TInterfacedObject, IConferenciaNaturezaOperacaoParconService)
  public
    function fConferir(const AFiltro: string): TDataset;
    class function New: IConferenciaNaturezaOperacaoParconService;
  end;

implementation

uses
  untFuncoesSimples, UniClientDataSet, Uni, Classes, Contabilidade.Funcoes;

{ TConferenciaNaturezaOperacaoParconService }

function TConferenciaNaturezaOperacaoParconService.fConferir(
  const AFiltro: string): TDataset;
var
  LParconComNatureza: TUniQuery;
  LNatCfo: TUniQuery;
  LCdsNatCfo: TUniClientDataSet;
  LCdsRetorno: TUniClientDataSet;
  LCdsParconComNatureza: TUniClientDataSet;
  LSqlCds: string;
  LClaFis: string;
  LControle: TStringList;
  LChaveControle: string;
begin
  LParconComNatureza := fCriaQuery();
  LNatCfo := fCriaQuery();
  LCdsNatCfo := nil;
  LCdsParconComNatureza := nil;
  LCdsRetorno           := nil;
  LControle := TStringList.Create;
  try
    LControle.Sorted := True;
    // parcon com natureza
    LParconComNatureza.Close;
    LParconComNatureza.SQL.Clear;
    LParconComNatureza.SQL.Add(' SELECT CON_TIPLAN, CAST(CON_CLAFIS AS CHAR(4)) AS CON_CLAFIS, CON_NATCFO, CON_DESVAL FROM PARCON ');
    LParconComNatureza.SQL.Add(' WHERE CON_TIPLAN IN ("COE", "COS", "CMV", "ENT", "SAI") ');
    LParconComNatureza.SQL.Add('       AND TRIM(COALESCE(CON_NATCFO, "")) <> "" ');
    if not fEmptyStr(AFiltro) then
    begin
      LParconComNatureza.SQL.Add(' AND CON_TIPLAN IN (' + AFiltro + ') ');
    end;
    LParconComNatureza.SQL.Add(fFiltroVigenciaParcon);
    LParconComNatureza.SQL.Add(' ORDER BY CON_CLAFIS; ');
    LParconComNatureza.Open;

    LCdsParconComNatureza := fCriaClientDatset(LParconComNatureza);
    LCdsParconComNatureza.IndexFieldNames := 'CON_TIPLAN;CON_CLAFIS;CON_NATCFO;CON_DESVAL';
    LCdsParconComNatureza.First;

    LNatCfo.Close;
    LNatCfo.SQL.Clear;
    LNatCfo.SQL.Add(' SELECT AUTOINCREM, NAT_CODCFO, NAT_DESCRI FROM NATCFO; ');
    LNatCfo.Open;

    LCdsNatCfo := fCriaClientDatset(LNatCfo);
    LCdsNatCfo.IndexFieldNames := 'NAT_CODCFO';
    LCdsNatCfo.First;

    LSqlCds := 'SELECT CON_TIPLAN, CON_DESVAL, CAST(CON_CLAFIS AS CHAR(4)) AS CON_CLAFIS, CON_NATCFO, CAST(NULL AS CHAR(45)) DES_NATCFO ';
    LSqlCds := LSqlCds + ' FROM PARCON ';
    LSqlCds := LSqlCds + ' WHERE FALSE';
    LCdsRetorno := fCriaClientDataset(LSqlCds);

    LParconComNatureza.First;
    while not LParconComNatureza.Eof do
    begin
      LClaFis := Trim(LParconComNatureza.FieldByName('CON_CLAFIS').AsString);
      if LCdsNatCfo.FindKey([LClaFis]) then
      begin
        while (LClaFis = LCdsNatCfo.FieldByName('NAT_CODCFO').AsString) and (not LCdsNatCfo.Eof) do
        begin
          LChaveControle := Format('%s|%s|%s|%s', [LParconComNatureza.FieldByName('CON_TIPLAN').AsString,
            LParconComNatureza.FieldByName('CON_CLAFIS').AsString,
            LCdsNatCfo.FieldByName('AUTOINCREM').AsString,
            LParconComNatureza.FieldByName('CON_DESVAL').AsString
            ]);

          if LControle.IndexOf(LChaveControle) <> -1 then
          begin
            LCdsNatCfo.Next;
            Continue;
          end;

          if LCdsParconComNatureza.FindKey([
            LParconComNatureza.FieldByName('CON_TIPLAN').AsString,
            LParconComNatureza.FieldByName('CON_CLAFIS').AsString,
            LCdsNatCfo.FieldByName('AUTOINCREM').AsString,
            LParconComNatureza.FieldByName('CON_DESVAL').AsString
            ]) then
          begin
            LCdsNatCfo.Next;
            Continue;
          end;

          LCdsRetorno.Append;
          LCdsRetorno.FieldByName('CON_TIPLAN').AsString := LParconComNatureza.FieldByName('CON_TIPLAN').AsString;
          LCdsRetorno.FieldByName('CON_DESVAL').AsString := LParconComNatureza.FieldByName('CON_DESVAL').AsString;
          LCdsRetorno.FieldByName('CON_CLAFIS').AsString := LParconComNatureza.FieldByName('CON_CLAFIS').AsString;
          LCdsRetorno.FieldByName('CON_NATCFO').AsString := LCdsNatCfo.FieldByName('AUTOINCREM').AsString;
          LCdsRetorno.FieldByName('DES_NATCFO').AsString := LCdsNatCfo.FieldByName('NAT_DESCRI').AsString;
          LCdsRetorno.Post;
          LControle.Add(LChaveControle);
          LCdsNatCfo.Next;
        end;
      end;
      LParconComNatureza.Next;
    end;

    Result := LCdsRetorno;
    LCdsRetorno := nil;
  finally
    FreeAndNil(LParconComNatureza);
    FreeAndNil(LNatCfo);
    FreeAndNil(LControle);
    if Assigned(LCdsNatCfo) then
      FreeAndNil(LCdsNatCfo);
    if Assigned(LCdsParconComNatureza) then
      FreeAndNil(LCdsParconComNatureza);
    if Assigned(LCdsRetorno) then
      FreeAndNil(LCdsRetorno);
  end;
end;

class function TConferenciaNaturezaOperacaoParconService.New: IConferenciaNaturezaOperacaoParconService;
begin
  Result := Self.Create;
end;

end.
