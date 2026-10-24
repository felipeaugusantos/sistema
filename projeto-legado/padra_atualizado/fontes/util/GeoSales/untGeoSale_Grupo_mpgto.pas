unit untGeoSale_Grupo_mpgto;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Grupo_mpgto = Class(TGeoSale_Base)
  Private
    FCodGru: Integer;
    FNomGru: String;
  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoInteger]
    [TNomeCampo('CODGRU')]
    Property CD_GRUPO_MPGTO : Integer Read FCodGru Write FCodGru;

    [TCampoString]
    [TNomeCampo('NOMGRU')]
    Property DS_GRUPO : String Read FNomGru Write FNomGru;
  End;

implementation

{ TGeoSale_Grupo_mpgto }

function TGeoSale_Grupo_mpgto.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Grupo_mpgto.TXT';
end;

function TGeoSale_Grupo_mpgto.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT  EMP_CODEMP AS CODGRU,                  ';
  Result := Result + '         "GRUPO DE MEIO DE PAGAMENTO" AS NOMGRU ';
  Result := Result + ' FROM CADEMP                                    ';
  Result := Result + ' WHERE LOCATE(EMP_CODEMP,"' + FEmpresas + '") > 0 ';
end;

procedure TGeoSale_Grupo_mpgto.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
