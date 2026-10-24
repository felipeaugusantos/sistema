unit untGeoSale_Grupo_Meio_Pagamento;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Grupo_Meio_Pagamento = Class(TGeoSale_Base)
  Private
    FDescri: String;
    FCodigo: String;
    FMeio: String;
  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoString]
    [TNomeCampo('FPG_CODIGO')]
    Property CD_MEIO_PGTO : String Read FCodigo Write FCodigo;

    [TCampoString]
    [TNomeCampo('FPG_DESCRI')]
    Property DS_MEIO_PGTO : String Read FDescri Write FDescri;

    [TCampoString]
    [TNomeCampo('MEIO_PGTO')]
    Property TP_MEIO_PGTO : String Read FMeio   Write FMeio;

  End;

implementation

{ TGeoSale_Grupo_Meio_Pagamento }

uses untFuncoesSimples;

function TGeoSale_Grupo_Meio_Pagamento.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Meio_Pagamento.TXT';
end;

function TGeoSale_Grupo_Meio_Pagamento.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT FPG_CODIGO,           ';
  Result := Result + '        FPG_DESCRI,           ';
  Result := Result + '        CASE FPG_CODIGO       ';
  Result := Result + '          WHEN "001" THEN "D" ';
  Result := Result + '          WHEN "002" THEN "C" ';
  Result := Result + '          WHEN "006" THEN "C" ';
  Result := Result + '          WHEN "008" THEN "U" ';
  Result := Result + '          ELSE "O"            ';
  Result := Result + '         END MEIO_PGTO        ';
  Result := Result + ' FROM CADFPG                  ';
  Result := Result + ' WHERE FPG_STATUS = "A"       ';

end;

procedure TGeoSale_Grupo_Meio_Pagamento.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
