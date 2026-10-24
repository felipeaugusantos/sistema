unit Contabilidade.Funcoes.LucroPresumido;

interface

uses Data.DB, MemDS, DBAccess, Uni, Datasnap.DBClient, UniClientDataSet,
     Contabilidade.Interfaces.ConfigLucroPresumido,
     Contabilidade.Interfaces.SharedLucroPresumido, System.Generics.Collections,
     Contabilidade.Interfaces.ApuracaoLucroPresumido;

procedure pCarregaEstruturaConfig(var AcdsGeral, AcdsGeralLancon, AcdsDetalhe, AcdsDetalhePlanco: TUniClientDataSet) ;
procedure pConverteInterfacesToDataSetConfig(const ADadosConfig: IDadosConfigLucroPresumidoCfg; var AcdsGeral, AcdsGeralLancon, AcdsDetalhe, AcdsDetalhePlanco: TUniClientDataSet) ;
function fCarregaDadosLancon(const AdtsPlancoConfig: TDataSet; const AstrCodEmp: String; const AintExercicio: Integer; const AblnProcessaLanCon: Boolean): TUniClientDataSet ;
function fSelecionaCadastroTabelaApuracaoBC(const ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoCadastroTabelaApuracaoBC ;
procedure pAjustaDescricaoParametros(const ALstDados: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>; const AcdsDetalhe, AcdsDetalhePlanco: TUniClientDataSet) ;
function fCarregaApuracaoLucroPresumido(const ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoCarrega;
function fProcessaApuracaoLucroPresumido(
  const AtlpTipoApuracao: TTipoLucroPresumido;
  const AObjDadosApuracao: IDadosApuracaoLucroPresumido;
  var AcdsApuracaoBaseCalculo, AcdsApuracaoValor: TUniClientDataSet;
  const AobjLinhaSemDados: ITipoLinhasSemInformacao): Boolean;
procedure pCriarEstruturaCDSLucroPresumido(var AcdsEstrutura: TUniClientDataSet);


implementation

uses Contabilidade.Classes.ConfigLucroPresumidoComum,
     untFuncoesSimples, Contabilidade.Classes.ApuracaoLucroPresumidoComum,
     SysUtils, Contabilidade.Classes.ConfigLucroPresumidoFactory,
     Contabilidade.Consultas, Contabilidade.Classes.ApuracaoLucroPresumidoFactory ;

procedure pCriarEstruturaCDSLucroPresumido(var AcdsEstrutura: TUniClientDataSet);
begin
  AcdsEstrutura.FieldDefs.Add('AUTOINCREM', ftInteger, 0);
  AcdsEstrutura.FieldDefs.Add('CODIGO', ftString, 6);
  AcdsEstrutura.FieldDefs.Add('DESCRI', ftString, 512);
  AcdsEstrutura.FieldDefs.Add('PERIOD_01', ftFloat, 0);
  AcdsEstrutura.FieldDefs.Add('PERIOD_02', ftFloat, 0);
  AcdsEstrutura.FieldDefs.Add('PERIOD_03', ftFloat, 0);
  AcdsEstrutura.FieldDefs.Add('PERIOD_04', ftFloat, 0);
  AcdsEstrutura.FieldDefs.Add('PERIOD_TOT', ftFloat, 0);
  AcdsEstrutura.FieldDefs.Add('BLOQUE', ftString, 1);
  AcdsEstrutura.FieldDefs.Add('PORCEN', ftFloat, 0);
  AcdsEstrutura.CreateDataSet ;
end;

function fProcessaApuracaoLucroPresumido(
  const AtlpTipoApuracao: TTipoLucroPresumido;
  const AObjDadosApuracao: IDadosApuracaoLucroPresumido;
  var AcdsApuracaoBaseCalculo, AcdsApuracaoValor: TUniClientDataSet;
  const AobjLinhaSemDados: ITipoLinhasSemInformacao): Boolean;
var
  LobjProcessa: ITipoApuracaoLucroPresumidoProcessaCalculos ;
begin
  LobjProcessa := TFactoryApuracaoLucroPresumidoProcessaCalculos.New.fConfigura(AtlpTipoApuracao) ;

  Result := LobjProcessa
              .CdsBaseCalculo(AcdsApuracaoBaseCalculo)
              .CdsApuracao(AcdsApuracaoValor)
              .fLinhaSemDados(AobjLinhaSemDados)
              .fProcessar(AObjDadosApuracao) ;
end;

function fCarregaApuracaoLucroPresumido(const ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoCarrega;
begin
  Result := TFactoryApuracaoLucroPresumidoCarrega
              .New
              .fConfigura(ATipo) ;
end;

function fCarregaDadosLancon(const AdtsPlancoConfig: TDataSet; const AstrCodEmp: String; const AintExercicio: Integer; const AblnProcessaLanCon: Boolean): TUniClientDataSet ;
var
  LqryLancon : TUniQuery ;
  LqryCadEmp : TUniQuery ;
  LdtaApartirDe: TDateTime ;
begin

  LdtaApartirDe := fCampoTabela('TRI_INIATV', 'EPREGT', ['TRI_CODEMP', 'TRI_ANOEXE'], [AstrCodEmp, AintExercicio], False) ;

  LqryLancon := fCriaQuery() ;
  LqryCadEmp := fCriaQuery() ;
  try
    LqryCadEmp.Close ;
    LqryCadEmp.SQL.Clear ;
    LqryCadEmp.SQL.Add(' SELECT F.EMP_CODEMP ') ;
    LqryCadEmp.SQL.Add(' FROM CADEMP AS M INNER JOIN CADEMP AS F ON SUBSTR(M.EMP_C_G_C_, 1, 8) = SUBSTR(F.EMP_C_G_C_, 1, 8) ') ;
    LqryCadEmp.SQL.Add(' WHERE M.EMP_CODEMP = :CODEMP ') ;
    LqryCadEmp.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqryCadEmp.Open ;

    LqryLancon.Close ;
    LqryLancon.SQL.Clear ;
    LqryLancon.SQL.Add(' SELECT PLANO_CONTAS, TRIMESTRE, SUM(CREDITO) AS CREDITO, SUM(DEBITO) AS DEBITO FROM ( ') ;
    LqryLancon.SQL.Add(' 	SELECT CON_CONCRE AS PLANO_CONTAS, ') ;
    LqryLancon.SQL.Add(' 	       (CASE WHEN EXTRACT(MONTH FROM CON_DTALAN) IN (1,2,3) THEN 1 WHEN  EXTRACT(MONTH FROM CON_DTALAN) IN (4,5,6) THEN 2 WHEN  EXTRACT(MONTH FROM CON_DTALAN) IN (7,8,9) THEN 3 ELSE 4 END ) AS TRIMESTRE, ') ;
    LqryLancon.SQL.Add(' 	       CASE WHEN COALESCE(CON_CONCRE, "") <> "" THEN CON_VALLAN ELSE 0.00 END AS CREDITO, ') ;
    LqryLancon.SQL.Add(' 	        0.00 AS DEBITO ') ;
    LqryLancon.SQL.Add(' 	FROM LANCON ') ;
    LqryLancon.SQL.Add(' 	WHERE CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqryLancon.SQL.Add(' 	      AND CON_TIPLAN <> "FEC" ') ;

    if LdtaApartirDe > 0 then
    begin
      LqryLancon.SQL.Add(' AND CON_DTALAN >= :APARTIR ') ;
      LqryLancon.ParamByName('APARTIR').AsDate := LdtaApartirDe ;
    end ;

    TTipoFiltroLancon
      .New
      .fCadEmp(LqryCadEmp)
      .fPlanco(AdtsPlancoConfig)
      .fColunaPlanoContas('CON_CONCRE')
      .ProcessaLanCon(AblnProcessaLanCon)
      .pGeraFiltro(LqryLancon);

    LqryLancon.SQL.Add(' 	UNION ALL ') ;
    LqryLancon.SQL.Add(' 	SELECT CON_CONDEB AS PLANO_CONTAS, ') ;
    LqryLancon.SQL.Add(' 	       (CASE WHEN EXTRACT(MONTH FROM CON_DTALAN) IN (1,2,3) THEN 1 WHEN  EXTRACT(MONTH FROM CON_DTALAN) IN (4,5,6) THEN 2 WHEN  EXTRACT(MONTH FROM CON_DTALAN) IN (7,8,9) THEN 3 ELSE 4 END ) AS TRIMESTRE, ') ;
    LqryLancon.SQL.Add(' 	       0.00 AS CREDITO, ') ;
    LqryLancon.SQL.Add(' 	       CASE WHEN COALESCE(CON_CONDEB, "") <> "" THEN CON_VALLAN ELSE 0.00 END AS DEBITO ') ;
    LqryLancon.SQL.Add(' 	FROM LANCON ') ;
    LqryLancon.SQL.Add(' 	WHERE CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqryLancon.SQL.Add(' 	      AND CON_TIPLAN <> "FEC" ') ;

    if LdtaApartirDe > 0 then
    begin
      LqryLancon.SQL.Add(' AND CON_DTALAN >= :APARTIR ') ;
      LqryLancon.ParamByName('APARTIR').AsDate := LdtaApartirDe ;
    end ;

    TTipoFiltroLancon
      .New
      .fCadEmp(LqryCadEmp)
      .fPlanco(AdtsPlancoConfig)
      .fColunaPlanoContas('CON_CONDEB')
      .ProcessaLanCon(AblnProcessaLanCon)
      .pGeraFiltro(LqryLancon);

    LqryLancon.SQL.Add(' ) AS SEL ') ;
    LqryLancon.SQL.Add(' GROUP BY PLANO_CONTAS, TRIMESTRE ; ') ;
    LqryLancon.ParamByName('DTAINI').AsDateTime := EncodeDate(AintExercicio, 1, 1) ;
    LqryLancon.ParamByName('DTAFIN').AsDateTime := EncodeDate(AintExercicio, 12, 31) ;
    LqryLancon.Open ;

    Result := fCriaClientDatset(LqryLancon) ;

  finally
    FreeAndNil(LqryLancon) ;
    FreeAndNil(LqryCadEmp) ;
  end ;
end ;

procedure pCarregaEstruturaConfig(var AcdsGeral, AcdsGeralLancon, AcdsDetalhe, AcdsDetalhePlanco: TUniClientDataSet) ;
var
  LInfoColuna: IInfoColunaDataSet ;
  LInfoColunas: IInfoColunasDataSet ;
  LlstColunas: TList<IInfoColunaDataSet> ;
begin

  LInfoColunas := TInfoColunasDataSetConfigGeral.New ;
  LlstColunas := LInfoColunas.fColunas ;
  AcdsGeral.Close ;
  for LInfoColuna in LlstColunas do
    AcdsGeral.FieldDefs.Add(LInfoColuna.NomeColuna, LInfoColuna.TipoColuna, LInfoColuna.TamanhoColuna);

  LInfoColunas := TInfoColunasDataSetConfigGeralLancon.New ;
  LlstColunas := LInfoColunas.fColunas ;
  AcdsGeralLancon.Close ;
  for LInfoColuna in LlstColunas do
    AcdsGeralLancon.FieldDefs.Add(LInfoColuna.NomeColuna, LInfoColuna.TipoColuna, LInfoColuna.TamanhoColuna);

  LInfoColunas := TInfoColunasDataSetConfigDetalhe.New ;
  LlstColunas := LInfoColunas.fColunas ;
  AcdsDetalhe.Close ;
  for LInfoColuna in LlstColunas do
    AcdsDetalhe.FieldDefs.Add(LInfoColuna.NomeColuna, LInfoColuna.TipoColuna, LInfoColuna.TamanhoColuna);
  AcdsDetalhe.FieldDefs.Add('DESCRI', ftString, 512);
  AcdsDetalhe.FieldDefs.Add('GRUPO_', ftString, 35);
  AcdsDetalhe.FieldDefs.Add('SEQUEN', ftString, 3);
  AcdsDetalhe.FieldDefs.Add('DESCOD', ftString, 6);
  AcdsDetalhe.FieldDefs.Add('PLANCO', ftString, 1);
  AcdsDetalhe.FieldDefs.Add('CODPAR', ftString, 6);
  AcdsDetalhe.FieldDefs.Add('PORCEN', ftFloat, 0);

  LInfoColunas := TInfoColunasDataSetConfigDetalhePlanco.New ;
  LlstColunas := LInfoColunas.fColunas ;
  AcdsDetalhePlanco.Close ;
  for LInfoColuna in LlstColunas do
    AcdsDetalhePlanco.FieldDefs.Add(LInfoColuna.NomeColuna, LInfoColuna.TipoColuna, LInfoColuna.TamanhoColuna);
  AcdsDetalhePlanco.FieldDefs.Add('DESCRI', ftString, 100);

end ;

procedure pConverteInterfacesToDataSetConfig(
  const ADadosConfig: IDadosConfigLucroPresumidoCfg; var AcdsGeral, AcdsGeralLancon, AcdsDetalhe, AcdsDetalhePlanco: TUniClientDataSet);
var
  LlstDetalhe: TList<IDadosConfigLucroPresumidoCfgDetalhe> ;
  LItem: IDadosConfigLucroPresumidoCfgDetalhe ;
  LlstDetalhePlanco: TList<IDadosConfigLucroPresumidoCfgDetalheContas> ;
  LItemPlanco: IDadosConfigLucroPresumidoCfgDetalheContas ;
begin
  if not Assigned(ADadosConfig) then
    Exit ;

  AcdsGeral.EmptyDataSet ;
  AcdsGeralLancon.EmptyDataSet ;
  AcdsDetalhe.EmptyDataSet ;
  AcdsDetalhePlanco.EmptyDataSet ;

  AcdsGeral.Append ;
  AcdsGeral.FieldByName('AUTOINCREM').AsString := ADadosConfig.Geral.Autoincrem ;
  AcdsGeral.FieldByName('CODIGO').AsString := ADadosConfig.Geral.Codigo ;
  AcdsGeral.FieldByName('CODEMP').AsString := ADadosConfig.Geral.CodEmp ;
  AcdsGeral.FieldByName('EXERCI').AsInteger := ADadosConfig.Geral.Exerci ;
  AcdsGeral.Post ;

  if Assigned(ADadosConfig.GeralLanCon) then
  begin
    AcdsGeralLancon.Append ;
    AcdsGeralLancon.FieldByName('AUTOINCREM').AsString := ADadosConfig.GeralLanCon.Autoincrem ;
    AcdsGeralLancon.FieldByName('SEQGER').AsString := ADadosConfig.GeralLanCon.SeqGer ;
    if ADadosConfig.GeralLanCon.HisPad > 0 then
      AcdsGeralLancon.FieldByName('HISPAD').AsInteger := ADadosConfig.GeralLanCon.HisPad ;
    AcdsGeralLancon.FieldByName('HISTOR').AsString := ADadosConfig.GeralLanCon.Histor ;
    AcdsGeralLancon.FieldByName('CODCON').AsString := ADadosConfig.GeralLanCon.CodCon ;
    AcdsGeralLancon.Post ;
  end
  else
  begin
    AcdsGeralLancon.Append ;
    AcdsGeralLancon.Post ;
  end ;

  LlstDetalhe := ADadosConfig.Detalhe ;
  for LItem in LlstDetalhe do
  begin
    AcdsDetalhe.Append ;
    AcdsDetalhe.FieldByName('AUTOINCREM').AsString := LItem.Autoincrem ;
    AcdsDetalhe.FieldByName('CODIGO').AsString := LItem.Codigo ;
    AcdsDetalhe.FieldByName('SEQGER').AsString := LItem.SeqGer ;
    AcdsDetalhe.FieldByName('PRNIRP').AsInteger := LItem.Config ;
    AcdsDetalhe.Post ;

    LlstDetalhePlanco := LItem.Contas ;
    for LItemPlanco in LlstDetalhePlanco do
    begin
      AcdsDetalhePlanco.Append ;
      AcdsDetalhePlanco.FieldByName('AUTOINCREM').AsString := LItemPlanco.Autoincrem ;
      AcdsDetalhePlanco.FieldByName('SEQGER').AsString := LItemPlanco.SeqGer ;
      AcdsDetalhePlanco.FieldByName('CODCON').AsString := LItemPlanco.CodCon ;
      AcdsDetalhePlanco.FieldByName('TPLACO').AsString := LItemPlanco.TpLaCo ;
      AcdsDetalhePlanco.Post ;
    end ;
  end ;


end;

function fSelecionaCadastroTabelaApuracaoBC(
  const ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoCadastroTabelaApuracaoBC;
begin
  Result := TFactoryConfigLucroPresumidoCadastroTabelaApuracaoBC
              .New
              .fConfigura(ATipo)
end;

procedure pAjustaDescricaoParametros(
  const ALstDados: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>;
  const AcdsDetalhe, AcdsDetalhePlanco: TUniClientDataSet);
var
  LObjItem: IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC ;
begin

  AcdsDetalhe.DisableControls ;
  AcdsDetalhePlanco.DisableControls ;
  try
    for LObjItem in ALstDados do
    begin
      if AcdsDetalhe.Locate('PRNIRP', LObjItem.Autoincrem, [loCaseInsensitive]) then
      begin
        AcdsDetalhe.Edit ;
        AcdsDetalhe.FieldByName('DESCRI').AsString := LObjItem.Descri ;
        AcdsDetalhe.FieldByName('DESCOD').AsString := LObjItem.Codigo ;
        AcdsDetalhe.FieldByName('GRUPO_').AsString := LObjItem.Grupo_ ;
        AcdsDetalhe.FieldByName('SEQUEN').AsString := LObjItem.Sequen ;
        AcdsDetalhe.Post ;
      end
      else
      begin
        AcdsDetalhe.Append ;
        AcdsDetalhe.FieldByName('PRNIRP').AsInteger := LObjItem.Autoincrem ;
        AcdsDetalhe.FieldByName('DESCRI').AsString := LObjItem.Descri ;
        AcdsDetalhe.FieldByName('DESCOD').AsString := LObjItem.Codigo ;
        AcdsDetalhe.FieldByName('GRUPO_').AsString := LObjItem.Grupo_ ;
        AcdsDetalhe.FieldByName('SEQUEN').AsString := LObjItem.Sequen ;
        AcdsDetalhe.Post ;
      end ;

      if AcdsDetalhePlanco.FindKey([AcdsDetalhe.FieldByName('CODIGO').AsString]) then
      begin
        AcdsDetalhe.Edit ;
        AcdsDetalhe.FieldByName('PLANCO').AsString := 'S' ;
        AcdsDetalhe.Post ;
      end ;

    end ;
    AcdsDetalhe.First ;

    AcdsDetalhePlanco.First ;
    while not AcdsDetalhePlanco.Eof do
    begin
      AcdsDetalhePlanco.Edit ;
      AcdsDetalhePlanco.FieldByName('DESCRI').AsString := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [AcdsDetalhePlanco.FieldByName('CODCON').AsString], False) ;
      AcdsDetalhePlanco.Post ;
      AcdsDetalhePlanco.Next ;
    end ;
    AcdsDetalhePlanco.First ;

  finally
    AcdsDetalhe.EnableControls ;
    AcdsDetalhePlanco.EnableControls ;
  end ;

end;



end.
