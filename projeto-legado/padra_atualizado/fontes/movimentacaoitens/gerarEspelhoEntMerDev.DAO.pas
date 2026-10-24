unit gerarEspelhoEntMerDev.DAO;

interface
uses untFuncoesSimples, Uni, gerarEspelhoEntMerDev.DTO;

type

  TEspelhoEntMerDevDAO = class
  private

  public
    function ObterDadosConsumidor(aInput: TInputDadosConsumidorDTO): TUniQuery;
  end;

implementation


{ TEspelhoEntMerDevDAO }

function TEspelhoEntMerDevDAO.ObterDadosConsumidor(
  aInput: TInputDadosConsumidorDTO): TUniQuery;
begin
  Result := fCriaQuery();

  Result.SQL.Add(' SELECT ');
  Result.SQL.Add('   GAG_NUMENT,');
  Result.SQL.Add('   COALESCE(GAG_CODCLI, GER_CODCLI) AS GER_CODCLI,');
  Result.SQL.Add('   COALESCE(GAG_NOMCON, GER_NOMCON) AS GAG_NOMCON,');
  Result.SQL.Add('   COALESCE(GAG_ENDCON, GER_ENDCON) AS GAG_ENDCON,');
  Result.SQL.Add('   COALESCE(GAG_BAICON, GER_BAICON) AS GAG_BAICON,');
  Result.SQL.Add('   COALESCE(GAG_CEPCON, GER_CEPCON) AS GAG_CEPCON,');
  Result.SQL.Add('   COALESCE(GAG_CIDCON, GER_CIDCON) AS GAG_CIDCON,');
  Result.SQL.Add('   CID_NOMCID,');
  Result.SQL.Add('   COALESCE(GAG_ESTCON, GER_ESTCON) AS GAG_ESTCON,');
  Result.SQL.Add('   COALESCE(GAG_TELCON, GER_TELCON) AS GAG_TELCON,');
  Result.SQL.Add('   COALESCE(GAG_CGCCPF, GER_CGCCPF) AS GAG_CGCCPF,');
  Result.SQL.Add('   COALESCE(GAG_CGCCON, GER_CGCCON) AS GAG_CGCCON,');
  Result.SQL.Add('   COALESCE(GAG_IESCON, GER_IESCON) AS GAG_IESCON,');
  Result.SQL.Add('   COALESCE(GAG_R_GCON, GER_R_GCON) AS GAG_R_GCON,');
  Result.SQL.Add('   COALESCE(GAG_EMLCON, GER_EMLCON) AS GAG_EMLCON,');
  Result.SQL.Add('   GAG_CODATI,');
  Result.SQL.Add('   ATI_DESATI,');
  Result.SQL.Add('   CLI_NOMCLI');
  Result.SQL.Add(' FROM MOVGER');
  Result.SQL.Add(' LEFT JOIN MOVGAD ON MOVGER.GER_NUMDOC = MOVGAD.GAD_NUMDOC AND ');
  Result.SQL.Add('                MOVGER.GER_ESPDOC = MOVGAD.GAD_ESPDOC AND ');
  Result.SQL.Add('                MOVGER.GER_CODEMP = MOVGAD.GAD_CODEMP');
  Result.SQL.Add(' LEFT JOIN MOVGAG ON MOVGAD.GAD_SEQGAG = MOVGAG.AUTOINCREM');
  Result.SQL.Add(' LEFT JOIN CADCID ON CADCID.CID_CODCID = COALESCE(GAG_CIDCON, GER_CIDCON)');
  Result.SQL.Add(' LEFT JOIN CADCLI ON CADCLI.CLI_CODCLI = COALESCE(GAG_CODCLI, GER_CODCLI)');
  Result.SQL.Add(' LEFT JOIN CADATI ON CADATI.ATI_CODATI = GAG_CODATI');
  Result.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC AND');
  Result.SQL.Add('       GER_CODEMP = :CODEMP AND');
  Result.SQL.Add('       GER_ESPDOC = :ESPDOC');

  Result.ParamByName('NUMDOC').AsString := aInput.NumDoc;
  Result.ParamByName('ESPDOC').AsString := aInput.EspDoc;
  Result.ParamByName('CODEMP').AsString := aInput.CodEmp;
  Result.Open;
end;

end.
