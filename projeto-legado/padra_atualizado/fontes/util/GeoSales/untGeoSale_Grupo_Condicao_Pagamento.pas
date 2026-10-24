unit untGeoSale_Grupo_Condicao_Pagamento;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Grupo_Condicao_Pagamento = Class(TGeoSale_Base)
  Private
    FDesMax: Double;
    FDesCnd: String;
    FParcel: String;
    FDias  : String;
    FTabPre: String;
    FQtdDia: Integer;
    FCodCnd: Integer;

  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoInteger]
    [TNomeCampo('CND_CODIGO')]
    Property CD_COND_PGTO     : Integer Read FCodCnd Write FCodCnd;

    [TCampoString]
    [TNomeCampo('CND_DESCRI')]
    Property DS_COND_PGTO     : String  Read FDesCnd Write FDesCnd;

    [TCampoInteger]
    [TNomeCampo('QTDDIA')]
    Property QT_DIAS_TOTAL    : Integer Read FQtdDia Write FQtdDia;

    [TCampoDouble]
    [TNomeCampo('CND_DESMAX')]
    Property PR_DESCONTO      : Double  Read FDesMax Write FDesMax;

    [TCampoString]
    [TNomeCampo('PRAZO')]
    Property DS_DIAS_PARCELAS : String  Read FDias   Write FDias;

    [TCampoString]
    [TNomeCampo('PERPAR')]
    Property DS_PR_PARCELAS   : String  Read FParcel Write FParcel;

    [TCampoString]
    [TNomeCampo('TABPRE')]
    Property NR_PRECO         : String Read FTabPre Write FTabPre;
  End;

implementation

{ TGeoSale_Grupo_Condicao_Pagamento }

uses untFuncoesSimples;

function TGeoSale_Grupo_Condicao_Pagamento.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Condicao_Pagamento.TXT';
end;

function TGeoSale_Grupo_Condicao_Pagamento.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT CND_CODIGO,                                                                      ';
  Result := Result + '        CND_DESCRI,                                                                      ';
  Result := Result + '        LEFT(CND_CNDPAG,2) AS QTDDIA,                                                    ';
  Result := Result + '        CND_DESMAX,                                                                      ';
  Result := Result + '        CONCAT(IF( MID(CND_CNDPAG,03,3) <> "", MID(CND_CNDPAG,03,3), ""),                ';
  Result := Result + '        IF( MID(CND_CNDPAG,06,3) <> "", CONCAT(";", MID(CND_CNDPAG,06,3)), ""),          ';
  Result := Result + '        IF( MID(CND_CNDPAG,09,3) <> "", CONCAT(";", MID(CND_CNDPAG,09,3)), ""),          ';
  Result := Result + '        IF( MID(CND_CNDPAG,12,3) <> "", CONCAT(";", MID(CND_CNDPAG,12,3)), ""),          ';
  Result := Result + '        IF( MID(CND_CNDPAG,15,3) <> "", CONCAT(";", MID(CND_CNDPAG,15,3)), ""),          ';
  Result := Result + '        IF( MID(CND_CNDPAG,18,3) <> "", CONCAT(";", MID(CND_CNDPAG,18,3)), ""),          ';
  Result := Result + '        IF( MID(CND_CNDPAG,21,3) <> "", CONCAT(";", MID(CND_CNDPAG,21,3)), ""),          ';
  Result := Result + '        IF( MID(CND_CNDPAG,24,3) <> "", CONCAT(";", MID(CND_CNDPAG,24,3)), ""),          ';
  Result := Result + '        IF( MID(CND_CNDPAG,27,3) <> "", CONCAT(";", MID(CND_CNDPAG,27,3)), ""),          ';
  Result := Result + '        IF( MID(CND_CNDPAG,30,3) <> "", CONCAT(";", MID(CND_CNDPAG,30,3)), ""),          ';
  Result := Result + '        IF( MID(CND_CNDPAG,33,3) <> "", CONCAT(";", MID(CND_CNDPAG,33,3)), ""),          ';
  Result := Result + '        IF( MID(CND_CNDPAG,36,3) <> "", CONCAT(";", MID(CND_CNDPAG,36,3)), "")) AS PRAZO,';
  Result := Result + '        NULL AS PERPAR,                                                                  ';
  Result := Result + '        NULL AS TABPRE                                                                   ';
  Result := Result + ' FROM CADCND                                                                             ';
  Result := Result + ' WHERE LOCATE(' + QuotedStr(VS_strCodEmp) + ', CND_EMPACE)                               ';
end;

procedure TGeoSale_Grupo_Condicao_Pagamento.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
