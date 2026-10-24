unit untGeoSale_Item_Grupo_mpgto;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Item_Grupo_mpgto = Class(TGeoSale_Base)
  Private
    FCodGru: Integer;
    FCodFpg: String;
    FCodCnd: Integer;

  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoInteger]
    [TNomeCampo('GRU_CODGRU')]
    Property CD_GRUPO_MPGTO : Integer Read FCodGru Write FCodGru;

    [TCampoString]
    [TNomeCampo('FPG_CODIGO')]
    Property CD_MEIO_PGTO   : String  Read FCodFpg Write FCodFpg;

    [TCampoInteger]
    [TNomeCampo('CND_CODIGO')]
    Property CD_COND_PGTO   : Integer Read FCodCnd Write FCodCnd;

  End;

implementation

{ TGeoSale_Item_Grupo_mpgto }

function TGeoSale_Item_Grupo_mpgto.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Item_Grupo_mpgto.TXT';
end;

function TGeoSale_Item_Grupo_mpgto.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT EMP_CODEMP AS GRU_CODGRU,               ';
  Result := Result + '        FPG_CODIGO,                             ';
  Result := Result + '        CND_CODIGO                              ';
  Result := Result + ' FROM CADFPG                                    ';
  Result := Result + '   INNER JOIN CADCND ON CND_CODFPG = FPG_CODIGO ';
  Result := Result + '   INNER JOIN CADEMP ON LOCATE(EMP_CODEMP,"'+FEmpresas+'") > 0 ';
  Result := Result + ' WHERE FPG_STATUS = "A"                         ';
  Result := Result + ' ORDER BY EMP_CODEMP                            ';
end;

procedure TGeoSale_Item_Grupo_mpgto.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
