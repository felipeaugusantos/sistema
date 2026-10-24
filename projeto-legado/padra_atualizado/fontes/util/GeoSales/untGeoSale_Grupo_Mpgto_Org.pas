unit untGeoSale_Grupo_Mpgto_Org;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Grupo_Mpgto_Org = Class(TGeoSale_Base)
  Private
    FCodEmp: String;
    FGruMpg: Integer;

  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoInteger]
    [TNomeCampo('EMP_CODEMP')]
    Property CD_GRUPO_MPGTO : Integer Read FGruMpg Write FGruMpg;

    [TCampoString]
    [TNomeCampo('EMP_CODEMP')]
    Property CD_ORG_VENDA   : String  Read FCodEmp Write FCodEmp;

  End;

implementation

{ TGeoSale_Grupo_Mpgto_Org }

uses untFuncoesSimples;

function TGeoSale_Grupo_Mpgto_Org.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Grupo_Mpgto_Org.TXT';
end;

function TGeoSale_Grupo_Mpgto_Org.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT EMP_CODEMP ';
  Result := Result + ' FROM CADEMP       ';
  Result := Result + ' WHERE LOCATE(EMP_CODEMP," '+ FEmpresas + '") > 0 ';

end;

procedure TGeoSale_Grupo_Mpgto_Org.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
