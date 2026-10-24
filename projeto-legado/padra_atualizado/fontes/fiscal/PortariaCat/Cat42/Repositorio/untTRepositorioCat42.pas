unit untTRepositorioCat42;

interface

uses untTRetRegistroCatConfiguradoCfop,
     untTDadosAberturaExportacaoCat42,
     System.Generics.Collections,
     untTItemNotaUtilizadoCat,
     untIRepositorioCat,
     untTItemNotaFiscal,
     untIRetRegistroCat,
     untTEnquadramento,
     untTEstoqueCat42,
     untTRegistroCat,
     untTNotaFiscal,
     SysUtils,
     StrUtils,
     Dialogs,
     Uni,
     Classes;

type
  TRepositorioCat42 = class
  private
    FNotas: TObjectList<TNotaFiscal>;
    FRetRegistroCat: IRetRegistroCat;
    FAbertura: TDadosAberturaExportacaoCat42;
    FQryAux: TUniQuery;
    FQryAuxCompra: TUniQuery;
    FStlEnquadramento: TStringList;
    FExisteMovAux: boolean;
    FListaEnquadramentosConfigurado: TObjectList<TEnquadramento>;

    function fRetSqlNotasPeriodoProduto: string;
    procedure pCarregaSQL;

    function fRetSqlNotasPeriodoProdutoCompra: string;
    procedure pCarregaSQLCompra;

    function fRetValorRetido(qryAux: TUniQuery): double;
  public

    //Enquadramento
    {$Region 'Rotina Enquadramento'}
    function fRetCfopEnquadramento(strEnquadramento: string): string;
    function fRetCstEnquadramento(strEnquadramento: string): string;
    procedure pCarregarEnquadramentosConfigurados;
    {$EndRegion}
    // Fim:Enquadramento

    function fRetListaNotasCat42: TObjectList<TRegistroCat>;
    function fSaldoNegativo(strCodIte: string; fltSaldoInicial: Double): Boolean;
    procedure pCarregaNotasPeriodoProduto(strCodIte: string);

    procedure pCarregaNotaProdutoCompra(strCodIte: string; estoque: TEstoqueCat42);

    constructor Create(abertura: TDadosAberturaExportacaoCat42; stlEnquadramento: TStringList);
    destructor Destroy; override;
  end;

implementation

uses untTRetRegistroCat,
     untFuncoes,
     untTipo,
     untTRetRegistroCatTransferencia;

{ TRepositorioCat42 }

constructor TRepositorioCat42.Create(abertura: TDadosAberturaExportacaoCat42; stlEnquadramento: TStringList);
begin
  inherited create;

  if abertura.blnUtilizarConfigCfopCstEnquadramentos then
    FRetRegistroCat := TRetRegistroCatConfiguradoCfop.Create
  else
    FRetRegistroCat := TRetRegistroCat.Create;

  FNotas := TObjectList<TNotaFiscal>.Create;
  FStlEnquadramento := stlEnquadramento;
  FQryAux := fCriaQuery(nil);
  FQryAuxCompra := fCriaQuery(nil);
  FAbertura := abertura;
  FExisteMovAux := fTabelaExiste('MOVAUX');

  //carrega sql das nf de venda por produto parametrizado
  pCarregaSQL;
  pCarregaSQLCompra;

  //Enquadramento
  FListaEnquadramentosConfigurado := TObjectList<TEnquadramento>.Create;
  pCarregarEnquadramentosConfigurados;

end;

destructor TRepositorioCat42.Destroy;
begin
  FQryAux.Free;
  FQryAuxCompra.Free;
  FNotas.Free;

  inherited;
end;

procedure TRepositorioCat42.pCarregaNotaProdutoCompra(
  strCodIte: string; estoque: TEstoqueCat42);
begin

  try
    with FQryAuxCompra do
    begin
      Close;
      ParamByName('CODEMP').AsString := FAbertura.empresa.strCodigo;
      ParamByName('DTAFIN').AsDateTime := FAbertura.dtaDataFinal;
      ParamByName('CLACOM').AsString := VS_strClaCom;
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      if (FieldByName('DET_QTDITE').AsFloat > 0) then
      begin
        estoque.fltSubstiCompra := FieldByName('DET_VAERET').AsFloat / FieldByName('DET_QTDITE').AsFloat;
        estoque.strClafisCompra := FieldByName('DET_CLAFIS').AsString;
        estoque.strCodSitCompra := FieldByName('DET_CODFIS').AsString;
      end;

    end;
  except
    on E: Exception do
    begin
      fMensagem('Atenção', E.Message, ['OK']);
    end;
  end;
end;

function TRepositorioCat42.fRetCfopEnquadramento(
  strEnquadramento: string): string;
  var
    enquad: TEnquadramento;
begin
  Result := '';

  for enquad in FListaEnquadramentosConfigurado do
  begin
    if strEnquadramento = enquad.strEnquadramento then
    begin
      Result := enquad.strCfops;
      Exit;
    end;
  end;
end;

function TRepositorioCat42.fRetCstEnquadramento(
  strEnquadramento: string): string;
  var
    enquad: TEnquadramento;
begin
  Result := '';

  for enquad in FListaEnquadramentosConfigurado do
  begin
    if strEnquadramento = enquad.strEnquadramento then
    begin
      Result := enquad.strCsts;
      Exit;
    end;
  end;
end;

function TRepositorioCat42.fRetListaNotasCat42: TObjectList<TRegistroCat>;
begin
  Result := FRetRegistroCat.fCarregaRegistrosCat(FNotas, FAbertura, FStlEnquadramento);
end;

function TRepositorioCat42.fRetSqlNotasPeriodoProduto: string;
  function fRetCalcIcmsAbreviacao: string;
  begin
    Result := '';
    Result := Result + ' ((DET_TOTITE - DET_DESESP) * IF(IFNULL(A1.FOR_I_E_S_, "") = "" OR A1.FOR_CGCCPF = "2", B1.ABF_ALQICM_ENT_PEF, ';
    Result := Result + '  IF(A1.FOR_MATREV = "I", B1.ABF_ALQICM_ENT_PEJ, B1.ABF_ALQICM_ENT_PER))) / 100 ';
  end;

  var
    strSQL: string;

begin
  strSQL := '';

  strSQL := strSQL + 'SELECT DISTINCT ';
  strSQL := strSQL + '  IFNULL(FIS_ACESSO, "") AS FIS_ACESSO, ';
  strSQL := strSQL + '  IFNULL(FIS_HISTOR, "") AS FIS_HISTOR, ';
  strSQL := strSQL + '  FIS_ESTADO, ';
  strSQL := strSQL + '  FIS_NUMDOC, ';
  strSQL := strSQL + '  FIS_CODEMP, ';
  strSQL := strSQL + '  FIS_SERIE_, ';
  strSQL := strSQL + '  FIS_ESPDOC, ';
  strSQL := strSQL + '  FIS_FORCLI, ';
  strSQL := strSQL + '  FIS_TIP_FC, ';

  if (FAbertura.blnConsiderarDataEmissaoEntradasTransferencia) then
  begin
    strSQL := strSQL + '  IF( CASE WHEN IFNULL(FIS_CLFSC1,"") LIKE "%409%" THEN FIS_CLFSC1 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC2,"") LIKE "%409%" THEN FIS_CLFSC2 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC3,"") LIKE "%409%" THEN FIS_CLFSC3 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC4,"") LIKE "%409%" THEN FIS_CLFSC4 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC5,"") LIKE "%409%" THEN FIS_CLFSC5 ';
    strSQL := strSQL + '          END IN ("1409","2409"), ';
    strSQL := strSQL + '          FIS_DTADOC, FIS_DTAENT ) AS FIS_DTAENT, ';
  end
  else
    strSQL := strSQL + '  FIS_DTAENT, ';

  strSQL := strSQL + '  FIS_DTADOC, ';
  strSQL := strSQL + '  G.GER_HORENT, ';
  strSql := strSql + '   IF( (FIS_ESPDOC = "NF") AND (IFNULL(FIS_ACESSO,"") = "") , "01",     ';
  strSql := strSql + '     IF( ( (FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(FIS_ACESSO,"") <> "") ) OR   ';
  strSql := strSql + '           (FIS_ESPDOC = "EL"),  "55",                                  ';
  strSql := strSql + '       IF( FIS_ESPDOC IN ("IF", "IV"), IF(((IFNULL(FIS_ACESSO,"")="") AND (IFNULL(FIS_HISTOR, "") NOT LIKE "%INUTILI%")), "2D", "65"), "01" ) ) ) AS FIS_DOCMOD, ';
  strSQL := strSQL + '  IF(IFNULL(FIS_HISTOR, "") = "CANCELADO", "02", "00") AS FIS_SITDOC, ';

  strSQL := strSQL + '  IFNULL(FIS_CLFSC1, "") AS FIS_CLFSC1, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC2, "") AS FIS_CLFSC2, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC3, "") AS FIS_CLFSC3, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC4, "") AS FIS_CLFSC4, ';
  strSQL := strSQL + '  IFNULL(FIS_CLFSC5, "") AS FIS_CLFSC5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLCON1, 0) AS FIS_VLCON1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON2, 0) AS FIS_VLCON2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON3, 0) AS FIS_VLCON3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON4, 0) AS FIS_VLCON4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON5, 0) AS FIS_VLCON5, ';

  strSQL := strSQL + '  IFNULL(FIS_OUTRA1, 0) AS FIS_OUTRA1, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA2, 0) AS FIS_OUTRA2, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA3, 0) AS FIS_OUTRA3, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA4, 0) AS FIS_OUTRA4, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA5, 0) AS FIS_OUTRA5, ';

  strSQL := strSQL + '  IFNULL(FIS_BCRET1, 0) AS FIS_BCRET1, ';
  strSQL := strSQL + '  IFNULL(FIS_BCRET2, 0) AS FIS_BCRET2, ';
  strSQL := strSQL + '  IFNULL(FIS_BCRET3, 0) AS FIS_BCRET3, ';
  strSQL := strSQL + '  IFNULL(FIS_BCRET4, 0) AS FIS_BCRET4, ';
  strSQL := strSQL + '  IFNULL(FIS_BCRET5, 0) AS FIS_BCRET5, ';

  strSQL := strSQL + '  IFNULL(FIS_RETID1, 0) AS FIS_RETID1, ';
  strSQL := strSQL + '  IFNULL(FIS_RETID2, 0) AS FIS_RETID2, ';
  strSQL := strSQL + '  IFNULL(FIS_RETID3, 0) AS FIS_RETID3, ';
  strSQL := strSQL + '  IFNULL(FIS_RETID4, 0) AS FIS_RETID4, ';
  strSQL := strSQL + '  IFNULL(FIS_RETID5, 0) AS FIS_RETID5, ';

  strSQL := strSQL + '  IFNULL(FIS_ISENT1, 0) AS FIS_ISENT1, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT2, 0) AS FIS_ISENT2, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT3, 0) AS FIS_ISENT3, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT4, 0) AS FIS_ISENT4, ';
  strSQL := strSQL + '  IFNULL(FIS_ISENT5, 0) AS FIS_ISENT5, ';

  strSQL := strSQL + '  IFNULL(FIS_BASIC1, 0) AS FIS_BASIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC2, 0) AS FIS_BASIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC3, 0) AS FIS_BASIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC4, 0) AS FIS_BASIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIC5, 0) AS FIS_BASIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_ALQIC1, 0) AS FIS_ALQIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC2, 0) AS FIS_ALQIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC3, 0) AS FIS_ALQIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC4, 0) AS FIS_ALQIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_ALQIC5, 0) AS FIS_ALQIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLRIC1, 0) AS FIS_VLRIC1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC2, 0) AS FIS_VLRIC2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC3, 0) AS FIS_VLRIC3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC4, 0) AS FIS_VLRIC4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIC5, 0) AS FIS_VLRIC5, ';

  strSQL := strSQL + '  IFNULL(FIS_BASIP1, 0) AS FIS_BASIP1, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIP2, 0) AS FIS_BASIP2, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIP3, 0) AS FIS_BASIP3, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIP4, 0) AS FIS_BASIP4, ';
  strSQL := strSQL + '  IFNULL(FIS_BASIP5, 0) AS FIS_BASIP5, ';

  strSQL := strSQL + '  IFNULL(FIS_VLRIP1, 0) AS FIS_VLRIP1, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIP2, 0) AS FIS_VLRIP2, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIP3, 0) AS FIS_VLRIP3, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIP4, 0) AS FIS_VLRIP4, ';
  strSQL := strSQL + '  IFNULL(FIS_VLRIP5, 0) AS FIS_VLRIP5, ';

  strSql := strSql + '  IF(G.GER_CONPAG = "01000", "0", "1") AS FIS_COND_PG, ';
  strSql := strSql + '  G.GER_TIPFRE AS GER_TIPO_FRETE, ';
  strSQL := strSQL + '  G.GER_TOTFRE, ';
  strSQL := strSQL + '  G.GER_DESESP, ';
  strSQL := strSQL + '  D.AUTOINCREM AS INCREM_ITEM, ';
  strSQL := strSQL + '  D.DET_CODITE, ';
  strSQL := strSQL + '  DET_DESCRI, ';
  strSQL := strSQL + '  DET_UNIDAD, ';

  if (FAbertura.blnConsiderarDataEmissaoEntradasTransferencia) then
  begin
    strSQL := strSQL + '  IF( CASE WHEN IFNULL(FIS_CLFSC1,"") LIKE "%409%" THEN FIS_CLFSC1 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC2,"") LIKE "%409%" THEN FIS_CLFSC2 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC3,"") LIKE "%409%" THEN FIS_CLFSC3 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC4,"") LIKE "%409%" THEN FIS_CLFSC4 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC5,"") LIKE "%409%" THEN FIS_CLFSC5 ';
    strSQL := strSQL + '          END IN ("1409","2409"), ';
    strSQL := strSQL + '          FIS_DTADOC, FIS_DTAENT ) AS DET_DTAENT, ';
  end
  else
    strSQL := strSQL + '  DET_DTAENT, ';

  strSQL := strSQL + '  DET_QTDITE, ';
  strSQL := strSQL + '  DET_VLRCON, ';
  strSQL := strSQL + '  DET_TOTITE, ';
  strSQL := strSQL + '  DET_TOTFRE, ';
  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_CLAFIS, ';
  strSQL := strSQL + '  DET_DESESP, ';
  strSQL := strSQL + '  DET_PERRED, ';
  strSQL := strSQL + '  DET_CODFIS, ';
  strSQL := strSQL + '  DET_BASICM, ';
  strSQL := strSQL + '  DET_ALQICM, ';
  strSQL := strSQL + '  DET_VALICM, ';
  strSQL := strSQL + '  DET_BASIPI, ';
  strSQL := strSQL + '  DET_ALQIPI, ';
  strSQL := strSQL + '  DET_VALIPI, ';
  strSQL := strSQL + '  DET_BASRET, ';
  strSQL := strSQL + '  DET_VALRET, ';
  strSQL := strSQL + '  DET_DESACE, ';
  strSQL := strSQL + '  B1.ABF_ALQICM_ENT_PEJ AS ABF_ALQICM_ENT_PEJ, ';
  strSQL := strSQL + '  B1.ABF_ALQICM_ENT_PEJ AS ABF_ALQICM_ENT_PEJ_FOR, ';
  strSQL := strSQL + '  B.ABF_ALQICM_ENT_PEJ AS ABF_ALQICM_ENT_PEJ_EMP, ';
  strSQL := strSQL + '  IF(IFNULL(DLE.N17_VICMS, IFNULL(DET_VALICM, 0)) > 0, IFNULL(DLE.N17_VICMS, IFNULL(DET_VALICM, 0)), ' + fRetCalcIcmsAbreviacao + ') AS VALOR_ICMS, ';
  strSQL := strSQL + '  (DET_TOTITE - DET_DESESP) AS VALOR_PRODUTO, ';
  strSQL := strSQL + '  IFNULL(DET_DOCDEV, "") AS DET_DOCDEV, ';
  strSQL := strSQL + '  IFNULL(DET_ESPDEV, "") AS DET_ESPDEV, ';
  strSQL := strSQL + '  IFNULL(DET_EMPDEV, "") AS DET_EMPDEV, ';
  strSQL := strSQL + '  ROUND(D.DET_VALIPI + IFNULL(T.DET_VAEIPI, 0), 2) AS IPI_ENTRADA, ';
  strSQL := strSQL + '  T.DET_OUTICM, ';
  strSQL := strSQL + '  T.DET_ISEICM, ';
  strSQL := strSQL + '  T.DET_NR_PIS, ';
  strSQL := strSQL + '  T.DET_NR_COF, ';

  strSQL := StrSQL + '  IFNULL(T.DET_VLR158, 0) AS VLR158, ';
  strSQL := StrSQL + '  IFNULL(T.DET_VLGNRE, 0) AS VLGNRE, ';
  strSQL := StrSQL + '  IFNULL(T.DET_VAERET, 0) AS VAERET, ';

  if not (FExisteMovAux) then
  begin
    if FAbertura.blnSomarIcmsRetido then
    begin
      //# strSQL := strSQL + '  IFNULL(T.DET_VLR158, 0) + IFNULL(T.DET_VLGNRE, 0) + IFNULL(T.DET_VAERET, 0) + IFNULL(N27_VICMSSTRET, 0) + IFNULL(N17_VICMS, 0) AS DET_VAERET, '
      strSQL := strSQL + '  IF(IFNULL(T.DET_VLR158, 0) > 0, IFNULL(T.DET_VLR158, 0), IF(IFNULL(T.DET_VLGNRE, 0) > 0, IFNULL(T.DET_VLGNRE, 0), ';
      strSQL := strSQL + '  IF(IFNULL(T.DET_VAERET, 0) > 0, IFNULL(T.DET_VAERET, 0), IF(IFNULL(N27_VICMSSTRET, 0) > 0, IFNULL(N27_VICMSSTRET, 0), 0)))) + IFNULL(N17_VICMS, 0) AS DET_VAERET ';
    end
    else
    begin
      //# strSQL := strSQL + '  IFNULL(T.DET_VLR158, 0) + IFNULL(T.DET_VLGNRE, 0) + IFNULL(T.DET_VAERET, 0) + IFNULL(N27_VICMSSTRET, 0) AS DET_VAERET, ';
      strSQL := strSQL + '  IF(IFNULL(T.DET_VLR158, 0) > 0, IFNULL(T.DET_VLR158, 0), IF(IFNULL(T.DET_VLGNRE, 0) > 0, IFNULL(T.DET_VLGNRE, 0), ';
      strSQL := strSQL + '  IF(IFNULL(T.DET_VAERET, 0) > 0, IFNULL(T.DET_VAERET, 0), IF(IFNULL(N27_VICMSSTRET, 0) > 0, IFNULL(N27_VICMSSTRET, 0), 0)))) AS DET_VAERET ';
    end;
  end else
  begin
    strSQL := StrSQL + '  IFNULL(MA.DET_VSTANT, 0) AS VSTANT, ';

    if FAbertura.blnSomarIcmsRetido then
    begin
      strSQL := strSQL + '  IF(IFNULL(MA.DET_VSTANT, 0) <= 0, ';
      //# strSQL := strSQL + '    IFNULL(T.DET_VLR158, 0) + IFNULL(T.DET_VLGNRE, 0) + IFNULL(T.DET_VAERET, 0) + IFNULL(N27_VICMSSTRET, 0) + IFNULL(N17_VICMS, 0) ';
      strSQL := strSQL + '    IF(IFNULL(T.DET_VLR158, 0) > 0, IFNULL(T.DET_VLR158, 0), IF(IFNULL(T.DET_VLGNRE, 0) > 0, IFNULL(T.DET_VLGNRE, 0), ';
      strSQL := strSQL + '    IF(IFNULL(T.DET_VAERET, 0) > 0, IFNULL(T.DET_VAERET, 0), IF(IFNULL(N27_VICMSSTRET, 0) > 0, IFNULL(N27_VICMSSTRET, 0), 0)))) + IFNULL(N17_VICMS, 0) ';
      strSQL := strSQL + '  , ';
      strSQL := strSQL + '    IFNULL(MA.DET_VSTANT, 0) + IFNULL(N17_VICMS, 0) ';
      strSQL := strSQL + '  ) AS DET_VAERET, ';
    end else
    begin
      strSQL := strSQL + '  IF(IFNULL(MA.DET_VSTANT, 0) <= 0, ';
      //# strSQL := strSQL + '    IFNULL(T.DET_VLR158, 0) + IFNULL(T.DET_VLGNRE, 0) + IFNULL(T.DET_VAERET, 0) + IFNULL(N27_VICMSSTRET, 0) ';
      strSQL := strSQL + '    IF(IFNULL(T.DET_VLR158, 0) > 0, IFNULL(T.DET_VLR158, 0), IF(IFNULL(T.DET_VLGNRE, 0) > 0, IFNULL(T.DET_VLGNRE, 0), ';
      strSQL := strSQL + '    IF(IFNULL(T.DET_VAERET, 0) > 0, IFNULL(T.DET_VAERET, 0), IF(IFNULL(N27_VICMSSTRET, 0) > 0, IFNULL(N27_VICMSSTRET, 0), 0)))) ';
      strSQL := strSQL + '  , ';
      strSQL := strSQL + '    IFNULL(MA.DET_VSTANT, 0) ';
      strSQL := strSQL + ' ) AS DET_VAERET, ';
    end;
  end;

  strSQL := strSQL + '  T.DET_VAEIPI, ';
  strSQL := strSQL + '  T.DET_CSTIPI, ';
  strSQL := strSQL + '  T.DET_CSTPIS, ';
  strSQL := strSQL + '  T.DET_BASPIS, ';
  strSQL := strSQL + '  T.DET_ALQPIS, ';
  strSQL := strSQL + '  T.DET_VALPIS, ';
  strSQL := strSQL + '  T.DET_CSTCOF, ';
  strSQL := strSQL + '  T.DET_BASCOF, ';
  strSQL := strSQL + '  T.DET_ALQCOF, ';
  strSQL := strSQL + '  T.DET_VALCOF, ';
  strSQL := strSQL + '  IFNULL(ICD_BCUFDE, 0) AS ICD_BCUFDE, ';
  strSQL := strSQL + '  IFNULL(ICD_PERFCP, 0) AS ICD_PERFCP, ';
  strSQL := strSQL + '  IFNULL(ICD_ALQUFD, 0) AS ICD_ALQUFD, ';
  strSQL := strSQL + '  IFNULL(ICD_ALQINE, 0) AS ICD_ALQINE, ';
  strSQL := strSQL + '  IFNULL(ICD_PERPAR, 0) AS ICD_PERPAR, ';
  strSQL := strSQL + '  IFNULL(ICD_VALFCP, 0) AS ICD_VALFCP, ';
  strSQL := strSQL + '  IFNULL(ICD_VALDES, 0) AS ICD_VALDES, ';
  strSQL := strSQL + '  IFNULL(ICD_VALORI, 0) AS ICD_VALORI, ';
  strSQL := strSQL + '  UNI_SIGUNI, ';
  strSQL := strSQL + '  ITE.ITE_CLAIPI, ';
  strSQL := strSQL + '  ITE.ITE_CDCEST, ';
  strSQL := strSQL + '  TRA_C_G_C_, ';
  strSQL := strSQL + '  TRA_I_E_S_, ';
  strSQL := strSQL + '  TRA_NUMPLA, ';
  strSql := strSql + '  CIDTRA.CID_ESTADO AS TRA_UF, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_E_P_, A1.FOR_C_E_P_) AS CEP, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_G_C_, A1.FOR_C_G_C_) AS CNPJ, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_NOMCLI, A1.FOR_NOMFOR) AS NOME, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_BAIRRO, A1.FOR_BAIRRO) AS BAIRRO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_ENDERE, A1.FOR_ENDERE) AS ENDERECO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_FONE01, A1.FOR_FONE01) AS TELEFONE, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_ESTADO, CF.CID_ESTADO) AS UF, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_NOMCID, CF.CID_NOMCID) AS MUNICIPIO, ';
  strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CC.CID_COIBGE, CF.CID_COIBGE) AS CODIGO_IBGE, ';
  strSQL := strSQL + '  IFNULL(FIS_OUTRA1, 0) + IFNULL(FIS_OUTRA2, 0) + IFNULL(FIS_OUTRA3, 0) + IFNULL(FIS_OUTRA4, 0) + IFNULL(FIS_OUTRA5, 0) AS FIS_OUTRAS, ';
  strSQL := strSQL + '  IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0) AS FIS_VLRCON ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS ';

  strSQL := strSQL + '  LEFT JOIN MOVGER G ';
  strSQL := strSQL + '   ON G.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '   AND G.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '   AND G.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(G.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND G.GER_TIP_FC = FIS_TIP_FC ';
  strSQL := strSQL + '   AND IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN MOVDET D ';
  strSQL := strSQL + '   ON D.DET_NUMDOC = G.GER_NUMDOC ';
  strSQL := strSQL + '   AND D.DET_ESPDOC = G.GER_ESPDOC ';
  strSQL := strSQL + '   AND D.DET_CODEMP = G.GER_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(D.DET_SERIE_, "") = IFNULL(G.GER_SERIE_, "") ';
  strSQL := strSQL + '   AND D.DET_TIP_FC = G.GER_TIP_FC ';
  strSQL := strSQL + '   AND IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) ';

  strSQL := strSQL + '  LEFT JOIN MOVTRI T ';
  strSQL := strSQL + '   ON T.DET_SEQGER = D.AUTOINCREM ';

  if (FExisteMovAux) then
  begin
    strSQL := strSQL + '  LEFT JOIN MOVAUX MA ';
    strSQL := strSQL + '   ON MA.DET_SEQGER = D.AUTOINCREM ';
  end;

  if fTabelaExiste('MOVICD') then
  begin
    strSQL := strSQL + '  LEFT JOIN MOVICD ';
    strSQL := strSQL + '   ON ICD_SEQGER = D.AUTOINCREM ';
  end;

  strSQL := strSQL + '  LEFT JOIN GERELE GLE ';
  strSQL := strSQL + '   ON GLE.B08_NNF = FIS_NUMDOC ';
  strSQL := strSQL + '   AND IFNULL(GLE.B07_SERIE, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND GLE.GER_CODFOR = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN DETELE DLE ';
  strSQL := strSQL + '   ON DLE.DET_SEQGER = GLE.AUTOINCREM ';
  strSQL := strSQL + '   AND DLE.DET_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '   AND DLE.I11_VPROD = D.DET_TOTITE ';

  strSQL := strSQL + '  LEFT JOIN ITEGER GER ';
  strSQL := strSQL + '   ON GER.ITE_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '   AND GER.ITE_CODEMP = D.DET_CODEMP ';

  strSQL := strSQL + '  LEFT JOIN CADITE ITE ';
  strSQL := strSQL + '    ON ITE.ITE_CODITE = D.DET_CODITE ';

  strSQL := strSQL + '  LEFT JOIN CADUNI ';
  strSQL := strSQL + '    ON UNI_CODUNI = D.DET_UNIDAD ';

  strSQL := strSQL + '  LEFT JOIN CADTRA TRA ';
  strSQL := strSQL + '    ON TRA.TRA_CODTRA = G.GER_CODTRA ';

  strSQL := strSQL + '  LEFT JOIN CADCLI ';
  strSQL := strSQL + '   ON CLI_CODCLI = IF(FIS_TIP_FC = "C", FIS_FORCLI, NULL) ';

  strSQL := strSQL + '  LEFT JOIN CADFOR A1';
  strSQL := strSQL + '   ON A1.FOR_CODFOR = IF(FIS_TIP_FC = "F", FIS_FORCLI, NULL) ';

  strSQL := strSQL + '  LEFT JOIN CADFOR A2 ';
  strSQL := strSQL + '  ON A2.FOR_CODFOR = ITE.ITE_CODFOR ';

  strSQL := strSQL + '  LEFT JOIN CADCID CC ';
  strSQL := strSQL + '   ON CC.CID_CODCID = CLI_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CF ';
  strSQL := strSQL + '   ON CF.CID_CODCID = A1.FOR_CODCID ';

  if fTabelaExiste('ABFICM') then
    strSQL := strSQL + '  LEFT JOIN ABFICM B '
  else
    strSQL := strSQL + '  LEFT JOIN CADABF B ';

  if fCfgSis('TIPABF') = '1' then
    strSQL := strSQL + '  ON B.ABF_CODABF = ITE.ITE_CODABF '
  else
    strSQL := strSQL + '  ON B.ABF_CODABF = GER.ITE_CODABF ';
  strSQL := strSQL + '  AND B.ABF_ESTADO = "SP" ';
  //******************************************************************************************** FS

  strSQL := strSQL + '  LEFT JOIN CADCID CIDTRA ';
  strSQL := strSQL + '    ON CIDTRA.CID_CODCID = TRA_CODCID ';

  if fTabelaExiste('ABFICM') then
    strSQL := strSQL + '  LEFT JOIN ABFICM B1 '
  else
    strSQL := strSQL + '  LEFT JOIN CADABF B1 ';

  if fCfgSis('TIPABF') = '1' then
    strSQL := strSQL + '  ON B1.ABF_CODABF = ITE.ITE_CODABF '
  else
    strSQL := strSQL + '  ON B1.ABF_CODABF = GER.ITE_CODABF ';
  strSQL := strSQL + '  AND B1.ABF_ESTADO = IFNULL(CF.CID_ESTADO, CC.CID_ESTADO) ';
  //******************************************************************************************** FS

  if (FAbertura.blnConsiderarDataEmissaoEntradasTransferencia) then
  begin
    strSQL := strSQL + 'WHERE IF( CASE WHEN IFNULL(FIS_CLFSC1,"") LIKE "%409%" THEN FIS_CLFSC1 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC2,"") LIKE "%409%" THEN FIS_CLFSC2 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC3,"") LIKE "%409%" THEN FIS_CLFSC3 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC4,"") LIKE "%409%" THEN FIS_CLFSC4 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC5,"") LIKE "%409%" THEN FIS_CLFSC5 ';
    strSQL := strSQL + '          END IN ("1409", "2409"), ';
    strSQL := strSQL + '          FIS_DTADOC BETWEEN :DTAINI AND :DTAFIN, ';
    strSQL := strSQL + '          FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ) ';
  end
  else
  begin
    strSQL := strSQL + 'WHERE FIS_DTAENT BETWEEN :DTAINI ';
    strSQL := strSQL + '  AND :DTAFIN ';
  end;

  strSQL := strSQL + '  AND LOCATE(DET_ESPDOC, "NF_NV_IF_IV_EL") > 0 ';
  strSQL := strSQL + '  AND IFNULL(DET_PROEMB, "") <> "S" ';
  strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND D.DET_CODITE = :CODITE';
  strSQL := strSQL + '  AND D.DET_IDEPRO = "NOR" ';
  strSQL := strSQL + '  AND D.DET_CLAFIS NOT IN ("5922","6922") ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceText(AnsiReplaceText(AnsiReplaceText(AnsiReplaceText(strSQL, 'LEFT JOIN MOVDET', 'INNER JOIN NOTDET'),
                                                                                                             'LEFT JOIN MOVTRI', 'INNER JOIN NOTTRI'),
                                                                                                             'LEFT JOIN MOVGER', 'INNER JOIN NOTGER'),
                                                                                                             'LEFT JOIN MOVICD', 'INNER JOIN NOTICD');
  strSQL := strSQL + ' ORDER BY FIS_DTAENT, GER_HORENT ';

  Result := strSQL;

end;

function TRepositorioCat42.fRetSqlNotasPeriodoProdutoCompra: string;
  function fRetCalcIcmsAbreviacao: string;
  begin
    Result := '';
    Result := Result + ' ((DET_TOTITE - DET_DESESP) * IF(IFNULL(A1.FOR_I_E_S_, "") = "" OR A1.FOR_CGCCPF = "2", B1.ABF_ALQICM_ENT_PEF, ';
    Result := Result + '  IF(A1.FOR_MATREV = "I", B1.ABF_ALQICM_ENT_PEJ, B1.ABF_ALQICM_ENT_PER))) / 100 ';
  end;

  var
    strSQL: string;

begin
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADFIS.AUTOINCREM AS CF_AUTOINCREM, ';
  strSQL := strSQL + '  D.AUTOINCREM AS MD_AUTOINCREM, ';
  strSQL := strSQL + '  D.DET_CLAFIS, ';
  strSQL := strSQL + '  D.DET_CODFIS, ';

  if (FAbertura.blnConsiderarDataEmissaoEntradasTransferencia) then
  begin
    strSQL := strSQL + '  IF( CASE WHEN IFNULL(FIS_CLFSC1,"") LIKE "%409%" THEN FIS_CLFSC1 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC2,"") LIKE "%409%" THEN FIS_CLFSC2 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC3,"") LIKE "%409%" THEN FIS_CLFSC3 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC4,"") LIKE "%409%" THEN FIS_CLFSC4 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC5,"") LIKE "%409%" THEN FIS_CLFSC5 ';
    strSQL := strSQL + '          END IN ("1409","2409"), ';
    strSQL := strSQL + '          FIS_DTADOC, FIS_DTAENT ) AS FIS_DTAENT, ';
  end
  else
    strSQL := strSQL + '  FIS_DTAENT, ';

  if (FAbertura.blnConsiderarDataEmissaoEntradasTransferencia) then
  begin
    strSQL := strSQL + '  IF( CASE WHEN IFNULL(FIS_CLFSC1,"") LIKE "%409%" THEN FIS_CLFSC1 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC2,"") LIKE "%409%" THEN FIS_CLFSC2 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC3,"") LIKE "%409%" THEN FIS_CLFSC3 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC4,"") LIKE "%409%" THEN FIS_CLFSC4 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC5,"") LIKE "%409%" THEN FIS_CLFSC5 ';
    strSQL := strSQL + '          END IN ("1409","2409"), ';
    strSQL := strSQL + '          FIS_DTADOC, FIS_DTAENT ) AS DET_DTAENT, ';
  end
  else
    strSQL := strSQL + '  DET_DTAENT, ';

  strSQL := strSQL + '  G.GER_HORENT, ';
  strSQL := strSQL + '  DET_QTDITE, ';

  if not (FExisteMovAux) then
  begin
    if FAbertura.blnSomarIcmsRetido then
    begin
      //# strSQL := strSQL + '  IFNULL(T.DET_VLR158, 0) + IFNULL(T.DET_VLGNRE, 0) + IFNULL(T.DET_VAERET, 0) + IFNULL(N27_VICMSSTRET, 0) + IFNULL(N17_VICMS, 0) AS DET_VAERET, '
      strSQL := strSQL + '  IF(IFNULL(T.DET_VLR158, 0) > 0, IFNULL(T.DET_VLR158, 0), IF(IFNULL(T.DET_VLGNRE, 0) > 0, IFNULL(T.DET_VLGNRE, 0), ';
      strSQL := strSQL + '  IF(IFNULL(T.DET_VAERET, 0) > 0, IFNULL(T.DET_VAERET, 0), IF(IFNULL(N27_VICMSSTRET, 0) > 0, IFNULL(N27_VICMSSTRET, 0), 0)))) + IFNULL(N17_VICMS, 0) AS DET_VAERET ';
    end
    else
    begin
      //# strSQL := strSQL + '  IFNULL(T.DET_VLR158, 0) + IFNULL(T.DET_VLGNRE, 0) + IFNULL(T.DET_VAERET, 0) + IFNULL(N27_VICMSSTRET, 0) AS DET_VAERET ';
      strSQL := strSQL + '  IF(IFNULL(T.DET_VLR158, 0) > 0, IFNULL(T.DET_VLR158, 0), IF(IFNULL(T.DET_VLGNRE, 0) > 0, IFNULL(T.DET_VLGNRE, 0), ';
      strSQL := strSQL + '  IF(IFNULL(T.DET_VAERET, 0) > 0, IFNULL(T.DET_VAERET, 0), IF(IFNULL(N27_VICMSSTRET, 0) > 0, IFNULL(N27_VICMSSTRET, 0), 0)))) AS DET_VAERET ';
    end;
  end else
  begin
    if FAbertura.blnSomarIcmsRetido then
    begin
      strSQL := strSQL + '  IF(IFNULL(MA.DET_VSTANT, 0) <= 0, ';
      //# strSQL := strSQL + '    IFNULL(T.DET_VLR158, 0) + IFNULL(T.DET_VLGNRE, 0) + IFNULL(T.DET_VAERET, 0) + IFNULL(N27_VICMSSTRET, 0) + IFNULL(N17_VICMS, 0) ';
      strSQL := strSQL + '    IF(IFNULL(T.DET_VLR158, 0) > 0, IFNULL(T.DET_VLR158, 0), IF(IFNULL(T.DET_VLGNRE, 0) > 0, IFNULL(T.DET_VLGNRE, 0), ';
      strSQL := strSQL + '    IF(IFNULL(T.DET_VAERET, 0) > 0, IFNULL(T.DET_VAERET, 0), IF(IFNULL(N27_VICMSSTRET, 0) > 0, IFNULL(N27_VICMSSTRET, 0), 0)))) + IFNULL(N17_VICMS, 0) ';
      strSQL := strSQL + '  , ';
      strSQL := strSQL + '    IFNULL(MA.DET_VSTANT, 0) + IFNULL(N17_VICMS, 0) ';
      strSQL := strSQL + '  ) AS DET_VAERET ';
    end else
    begin
      strSQL := strSQL + '  IF(IFNULL(MA.DET_VSTANT, 0) <= 0, ';
      //# strSQL := strSQL + '    IFNULL(T.DET_VLR158, 0) + IFNULL(T.DET_VLGNRE, 0) + IFNULL(T.DET_VAERET, 0) + IFNULL(N27_VICMSSTRET, 0) ';
      strSQL := strSQL + '    IF(IFNULL(T.DET_VLR158, 0) > 0, IFNULL(T.DET_VLR158, 0), IF(IFNULL(T.DET_VLGNRE, 0) > 0, IFNULL(T.DET_VLGNRE, 0), ';
      strSQL := strSQL + '    IF(IFNULL(T.DET_VAERET, 0) > 0, IFNULL(T.DET_VAERET, 0), IF(IFNULL(N27_VICMSSTRET, 0) > 0, IFNULL(N27_VICMSSTRET, 0), 0)))) ';
      strSQL := strSQL + '  , ';
      strSQL := strSQL + '    IFNULL(MA.DET_VSTANT, 0) ';
      strSQL := strSQL + ' ) AS DET_VAERET ';
    end;
  end;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS ';

  strSQL := strSQL + '  LEFT JOIN MOVGER G ';
  strSQL := strSQL + '   ON G.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '   AND G.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '   AND G.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(G.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND G.GER_TIP_FC = FIS_TIP_FC ';
  strSQL := strSQL + '   AND IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN MOVDET D ';
  strSQL := strSQL + '   ON D.DET_NUMDOC = G.GER_NUMDOC ';
  strSQL := strSQL + '   AND D.DET_ESPDOC = G.GER_ESPDOC ';
  strSQL := strSQL + '   AND D.DET_CODEMP = G.GER_CODEMP ';
  strSQL := strSQL + '   AND IFNULL(D.DET_SERIE_, "") = IFNULL(G.GER_SERIE_, "") ';
  strSQL := strSQL + '   AND D.DET_TIP_FC = G.GER_TIP_FC ';
  strSQL := strSQL + '   AND IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) ';

  strSQL := strSQL + '  LEFT JOIN MOVTRI T ';
  strSQL := strSQL + '   ON T.DET_SEQGER = D.AUTOINCREM ';

  if (FExisteMovAux) then
  begin
    strSQL := strSQL + '  LEFT JOIN MOVAUX MA ';
    strSQL := strSQL + '   ON MA.DET_SEQGER = D.AUTOINCREM ';
  end;

  if fTabelaExiste('MOVICD') then
  begin
    strSQL := strSQL + '  LEFT JOIN MOVICD ';
    strSQL := strSQL + '   ON ICD_SEQGER = D.AUTOINCREM ';
  end;

  strSQL := strSQL + '  LEFT JOIN GERELE GLE ';
  strSQL := strSQL + '   ON GLE.B08_NNF = FIS_NUMDOC ';
  strSQL := strSQL + '   AND IFNULL(GLE.B07_SERIE, "") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '   AND GLE.GER_CODFOR = FIS_FORCLI ';

  strSQL := strSQL + '  LEFT JOIN DETELE DLE ';
  strSQL := strSQL + '   ON DLE.DET_SEQGER = GLE.AUTOINCREM ';
  strSQL := strSQL + '   AND DLE.DET_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '   AND DLE.I11_VPROD = D.DET_TOTITE ';

  if (FAbertura.blnConsiderarDataEmissaoEntradasTransferencia) then
  begin
    strSQL := strSQL + 'WHERE IF( CASE WHEN IFNULL(FIS_CLFSC1,"") LIKE "%409%" THEN FIS_CLFSC1 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC2,"") LIKE "%409%" THEN FIS_CLFSC2 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC3,"") LIKE "%409%" THEN FIS_CLFSC3 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC4,"") LIKE "%409%" THEN FIS_CLFSC4 ';
    strSQL := strSQL + '               WHEN IFNULL(FIS_CLFSC5,"") LIKE "%409%" THEN FIS_CLFSC5 ';
    strSQL := strSQL + '          END IN ("1409", "2409"), ';
    strSQL := strSQL + '          FIS_DTADOC <= :DTAFIN, ';
    strSQL := strSQL + '          FIS_DTAENT <= :DTAFIN ) ';
  end
  else
  begin
    strSQL := strSQL + 'WHERE D.DET_DTAENT <= :DTAFIN ';
  end;

  strSQL := strSQL + '  AND LOCATE(RIGHT(D.DET_CODFIS, 2), "10_30_60_70") > 0 ';
  strSQL := strSQL + '  AND LOCATE(D.DET_ESPDOC, "NF_NV_IF_IV_EL") > 0 ';
  strSQL := strSQL + '  AND IFNULL(D.DET_PROEMB, "") <> "S" ';
  strSQL := strSQL + '  AND D.DET_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND LOCATE(D.DET_CLAFIS, :CLACOM) > 0 ';
  strSQL := strSQL + '  AND D.DET_CODITE = :CODITE';
  strSQL := strSQL + '  AND D.DET_IDEPRO = "NOR" ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceText(AnsiReplaceText(AnsiReplaceText(AnsiReplaceText(strSQL, 'LEFT JOIN MOVDET', 'INNER JOIN NOTDET'),
                                                                                                             'LEFT JOIN MOVTRI', 'INNER JOIN NOTTRI'),
                                                                                                             'LEFT JOIN MOVGER', 'INNER JOIN NOTGER'),
                                                                                                             'LEFT JOIN MOVICD', 'INNER JOIN NOTICD');

  strSQL := strSQL + ' ORDER BY MD_AUTOINCREM DESC, CF_AUTOINCREM DESC, ';
  strSQL := strSQL + '          FIS_DTAENT DESC, DET_DTAENT DESC, GER_HORENT DESC ';
  strSQL := strSQL + ' LIMIT 1';

  Result := strSQL;
end;

function TRepositorioCat42.fRetValorRetido(qryAux: TUniQuery): double;
begin
  with qryAux do
  begin
    Result := qryAux.FieldByName('DET_VAERET').AsFloat;

    //se a nota não tiver ST e estiver parametrizado para calcular
    if (Result <= 0) and (FAbertura.blnCalculaST) then
    begin
      //TOTAL DO PRODUTO (TOTITE - DESESP) + IPI * FATOR DE IVA INFORMADO NA TELA * ALIQUOTA INTERNA DO ESTADO - ICMS
      Result := ((((qryAux.FieldByName('VALOR_PRODUTO').AsFloat + qryAux.FieldByName('IPI_ENTRADA').AsFloat) *
                    FAbertura.fltValorIVA) * qryAux.FieldByName('ABF_ALQICM_ENT_PEJ_EMP').AsFloat) / 100) -
                  ((qryAux.FieldByName('VALOR_PRODUTO').AsFloat * qryAux.FieldByName('ABF_ALQICM_ENT_PEJ_FOR').AsFloat) / 100);

      //SOMANDO NOVAMENTE O ICMS CASO O MESMO PEÇA NA TELA PRINCIPAL
      if FAbertura.blnSomarIcmsRetido then
        Result := Result + ((qryAux.FieldByName('VALOR_PRODUTO').AsFloat * qryAux.FieldByName('ABF_ALQICM_ENT_PEJ_FOR').AsFloat) / 100);
    end;
  end;
end;

//Verifica se o saldo ficou negativo em um algum dia do período
function TRepositorioCat42.fSaldoNegativo(strCodIte: string; fltSaldoInicial: Double): Boolean;
  var
    nota: TNotaFiscal;
    item: TItemNotaFiscal;
    fltSaldo: Double;
    blnProcessaRotinaSaldoNegativo: Boolean;
    strMovimentacaoCfop: string;
    registroTransferencia: TRegistroCat;
    objTransferencia: TRetRegistroCatTransferencia;

  function fRetNotaFiscalTransferencia(strCfop: string): Boolean;
  begin
    Result := False;

    if Pos(item.strCfop, '1409_2409') > 0 then
    begin
      objTransferencia := TRetRegistroCatTransferencia.Create;
      try
        objTransferencia.abertura := FAbertura;
        registroTransferencia := objTransferencia.fRetRegistro(item);

        if Assigned(registroTransferencia) then
          Result := True;
      finally
        objTransferencia.Free;
      end;
    end else Result := True;
  end;

begin
  strMovimentacaoCfop := '';
  fltSaldo := fltSaldoInicial;

  For nota in FNotas Do
  Begin
    For item in nota.itensNota Do
    Begin

      {$Region 'Rotina de Enquadramento'}
      if (FAbertura.blnUtilizarConfigCfopCstEnquadramentos) then
      begin
        blnProcessaRotinaSaldoNegativo := False;

        {$Region 'Enquadramento 0'}
        //Enquadramento 0
        if (Pos(item.strCfop, fRetCfopEnquadramento('0')) > 0) then
          blnProcessaRotinaSaldoNegativo := True
        {$EndRegion}

        {$Region 'Enquadramento 1'}
        //Enquadramento 1
        else
        if (Pos(item.strCfop, fRetCfopEnquadramento('1')) > 0) then
          blnProcessaRotinaSaldoNegativo := True
        {$EndRegion}

        {$Region 'Enquadramento 2'}
        //Enquadramento 2
        else
        if (Pos(item.strCfop, fRetCfopEnquadramento('2')) > 0) then
          blnProcessaRotinaSaldoNegativo := True
        {$EndRegion}

        {$Region 'Enquadramento 3'}
        //Enquadramento 3
        else
        if (Pos(RightStr(item.strCstIcm, 2), fRetCstEnquadramento('3')) > 0) and
          (Pos(item.strCfop, fRetCfopEnquadramento('3')) > 0) then
          blnProcessaRotinaSaldoNegativo := True
        {$EndRegion}

        {$Region 'Enquadramento 4'}
        //Enquadramento 4
        else
        if (Pos(RightStr(item.strCstIcm, 2), fRetCstEnquadramento('4')) > 0) and
          (Pos(item.strCfop, fRetCfopEnquadramento('4')) > 0) then
          blnProcessaRotinaSaldoNegativo := True
        {$EndRegion}

        {$Region 'Enquadramento 5'}
        //Enquadramento 5
        else
        if (Pos(item.strCfop, fRetCfopEnquadramento('5')) > 0) then
        begin
          if (Pos(RightStr(item.strCstIcm, 2), fRetCstEnquadramento('5')) > 0) then
            blnProcessaRotinaSaldoNegativo := True
        end
        {$EndRegion}

        {$Region 'Enquadramento 6'}
        //Enquadramento 6
        else
        if (Pos(RightStr(item.strCstIcm, 2), fRetCstEnquadramento('6')) > 0) and
          (Pos(item.strCfop, fRetCfopEnquadramento('6')) > 0) then
        begin
          if FAbertura.tipoConferencia = tccsim  then
            blnProcessaRotinaSaldoNegativo := fRetNotaFiscalTransferencia(item.strCfop)
          else if IIF(FAbertura.strVersaoExecutada = 'v1', FAbertura.blnEnviaNfCredSemSubsti, true) then
            blnProcessaRotinaSaldoNegativo := fRetNotaFiscalTransferencia(item.strCfop)
          else if item.fltValorRetidoNaoCreditado > 0 then
            blnProcessaRotinaSaldoNegativo := fRetNotaFiscalTransferencia(item.strCfop);
        end;
        {$EndRegion}
      end else blnProcessaRotinaSaldoNegativo := True;
      {$EndRegion}

      If (blnProcessaRotinaSaldoNegativo) then
      begin

        {$Region 'Data Compra x Data Venda x Saldo Inicial e Movimentação de Saldo'}
        if (fltSaldoInicial = 0) then
        begin
          If Pos(item.strCfop, VS_strClaDev) > 0 Then
          Begin
            if (Pos(LeftStr(item.strCfop, 1), '1_2_3') > 0) then
            begin
              if (not(fEmptyStr(item.strDocDev))) then
                strMovimentacaoCfop := item.strCfop;
            end else strMovimentacaoCfop := item.strCfop;
          End Else strMovimentacaoCfop := item.strCfop;

          if (Pos(LeftStr(strMovimentacaoCfop, 1), '5_6_7') > 0) then
          begin
            if (fltSaldo <= 0) then
            begin
              fltSaldo := -1;
              Break;
            end;
          end;
        end;
        {$EndRegion}

        {$Region 'Atualiza saldo para Devolução'}
        If Pos(item.strCfop, VS_strClaDev) > 0 Then
        Begin
          //De entrada
          If (StrToInt(item.strCfop) > 5000) Then
          Begin
            fltSaldo := fltSaldo - item.fltQuantidade;
          End
          //De saída
          Else
          Begin
            if (not(fEmptyStr(item.strDocDev))) then
              fltSaldo := fltSaldo + item.fltQuantidade;
          End;

        End
        {$EndRegion}

        {$Region 'Atualiza saldo Compra e Venda'}
        Else
        Begin
          //De venda
          If (StrToInt(item.strCfop) > 5000) Then
          Begin
            fltSaldo := fltSaldo - item.fltQuantidade;
          End
          //De compra
          Else
            fltSaldo := fltSaldo + item.fltQuantidade;
        End;
        {$EndRegion}

      End;

    End;

    If (fltSaldo < 0) then
      Break;

  End;

  Result := fltSaldo >= 0;
end;

procedure TRepositorioCat42.pCarregaNotasPeriodoProduto(strCodIte: string);
  var
    notaFiscalDetalhada: TNotaFiscalDetalhada;
    strChaveAtual, strChaveNotaNormal: string;
    ItemNota: TItemNotaFiscal;
    notaNormal: TNotaFiscal;
    intContador: integer;
begin
  FNotas.Clear;

  strChaveNotaNormal := '';
  strChaveAtual := '';
  notaNormal := nil;
  try
    with FQryAux do
    begin
      Close;
      ParamByName('CODEMP').AsString := FAbertura.empresa.strCodigo;
      ParamByName('DTAINI').AsDateTime := FAbertura.dtaDataInicial;
      ParamByName('DTAFIN').AsDateTime := FAbertura.dtaDataFinal;
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      First;
      while not Eof do
      begin
        strChaveAtual := fRetChaveAtual(FieldByName('FIS_SERIE_').AsString,
                                        FieldByName('FIS_TIP_FC').AsString,
                                        FieldByName('FIS_ESPDOC').AsString,
                                        FieldByName('FIS_NUMDOC').AsString,
                                        FieldByName('FIS_CODEMP').AsString,
                                        FieldByName('FIS_FORCLI').AsString);

        if strChaveAtual <> strChaveNotaNormal then
        begin
          strChaveNotaNormal := strChaveAtual;

          notaNormal := TNotaFiscal.Create;

          notaNormal.strSerie := FieldByName('FIS_SERIE_').AsString;
          notaNormal.strTipFc := FieldByName('FIS_TIP_FC').AsString;
          notaNormal.strNumero := FieldByName('FIS_NUMDOC').AsString;
          notaNormal.strEspecie := FieldByName('FIS_ESPDOC').AsString;
          notaNormal.strEmpresa := FieldByName('FIS_CODEMP').AsString;
          notaNormal.participante.strCodigo := FieldByName('FIS_FORCLI').AsString;
          notaNormal.participante.strNome := FieldByName('NOME').AsString;
          notaNormal.participante.strCgcCpf := FieldByName('CNPJ').AsString;
          notaNormal.participante.intCgcCpfInt := StrToInt64Def(FieldByName('CNPJ').AsString, 0);
          notaNormal.participante.cidade.strCodigoIbge := FieldByName('CODIGO_IBGE').AsString;
          notaNormal.strChaveAcesso := FieldByName('FIS_ACESSO').AsString;
          notaNormal.strEstado := FieldByName('FIS_ESTADO').AsString;
          notaNormal.strHistorico := FieldByName('FIS_HISTOR').AsString;
          notaNormal.strModelo := FieldByName('FIS_DOCMOD').AsString;
          notaNormal.strSituacaoDocumento := FieldByName('FIS_SITDOC').AsString;
          notaNormal.strCfop1 := FieldByName('FIS_CLFSC1').AsString;
          notaNormal.strCfop2 := FieldByName('FIS_CLFSC2').AsString;
          notaNormal.strCfop3 := FieldByName('FIS_CLFSC3').AsString;
          notaNormal.strCfop4 := FieldByName('FIS_CLFSC4').AsString;
          notaNormal.strCfop5 := FieldByName('FIS_CLFSC5').AsString;
          notaNormal.strCondicaoPagamento := FieldByName('FIS_COND_PG').AsString;
          notaNormal.strTipoFrete := FieldByName('GER_TIPO_FRETE').AsString;
          notaNormal.fltVlrIcm1 := FieldByName('FIS_VLRIC1').AsFloat;
          notaNormal.fltVlrIcm2 := FieldByName('FIS_VLRIC2').AsFloat;
          notaNormal.fltVlrIcm3 := FieldByName('FIS_VLRIC3').AsFloat;
          notaNormal.fltVlrIcm4 := FieldByName('FIS_VLRIC4').AsFloat;
          notaNormal.fltVlrIcm5 := FieldByName('FIS_VLRIC5').AsFloat;
          notaNormal.fltBasIss := 0.00;
          notaNormal.fltAlqIss := 0.00;
          notaNormal.fltValIss := 0.00;
          notaNormal.fltBasPis := 0.00;
          notaNormal.fltAlqPis := 0.00;
          notaNormal.fltValPis := 0.00;
          notaNormal.fltBasCof := 0.00;
          notaNormal.fltAlqCof := 0.00;
          notaNormal.fltValCof := 0.00;
          notaNormal.fltFrete := FieldByName('GER_TOTFRE').AsFloat;
          notaNormal.fltOutras := FieldByName('FIS_OUTRAS').AsFloat;
          notaNormal.fltDesconto := FieldByName('GER_DESESP').AsFloat;
          notaNormal.fltValorContabil := FieldByName('FIS_VLRCON').AsFloat;
          notaNormal.dtaDtaDoc := FieldByName('FIS_DTADOC').AsDateTime;
          notaNormal.dtaDtaEnt := FieldByName('FIS_DTAENT').AsDateTime;
          notaNormal.transportadora.strInscricaoEstadual := FieldByName('TRA_I_E_S_').AsString;
          notaNormal.transportadora.strUFPlaca := FieldByName('GER_TOTFRE').AsString;
          notaNormal.transportadora.strPlaca := FieldByName('TRA_NUMPLA').AsString;
          notaNormal.transportadora.strCnpj := FieldByName('TRA_C_G_C_').AsString;
          notaNormal.transportadora.cidade.strEstado := FieldByName('TRA_UF').AsString;

          FNotas.Add(notaNormal);

          for intContador := 1 to 5 do
          begin
            if not fEmptyStr(FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString) then
            begin
              notaFiscalDetalhada := TnotaFiscalDetalhada.Create;
              notaFiscalDetalhada.strCfop := FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString;
              notaFiscalDetalhada.fltValorContabil := FieldByName('FIS_VLCON' + IntToStr(intContador)).AsFloat;
              notaFiscalDetalhada.fltBaseIcms := FieldByName('FIS_BASIC' + IntToStr(intContador)).AsFloat;
              notaFiscalDetalhada.fltAliquotaIcms := FieldByName('FIS_ALQIC' + IntToStr(intContador)).AsFloat;
              notaFiscalDetalhada.fltValorIcms := FieldByName('FIS_VLRIC' + IntToStr(intContador)).AsFloat;
              notaFiscalDetalhada.fltValorOutras := FieldByName('FIS_OUTRA' + IntToStr(intContador)).AsFloat;
              notaFiscalDetalhada.fltValorIsentas := FieldByName('FIS_ISENT' + IntToStr(intContador)).AsFloat;
              notaFiscalDetalhada.fltBaseIcmsST := FieldByName('FIS_BCRET' + IntToStr(intContador)).AsFloat;
              notaFiscalDetalhada.fltValorIcmsST := FieldByName('FIS_RETID' + IntToStr(intContador)).AsFloat;
              notaFiscalDetalhada.fltBaseIpi := FieldByName('FIS_BASIP' + IntToStr(intContador)).AsFloat;
              notaFiscalDetalhada.fltValorIpi := FieldByName('FIS_VLRIP' + IntToStr(intContador)).AsFloat;

              notaNormal.notaFiscalDetalhada.Add(NotaFiscalDetalhada);
            end;
          end;
        end;

        if not fEmptyStr(FieldByName('DET_CODITE').AsString) then
        begin
          itemNota := TItemNotaFiscal.Create;

          itemNota.strAutoIncrem := FieldByName('INCREM_ITEM').AsString;
          itemNota.strSerie := FieldByName('FIS_SERIE_').AsString;
          itemNota.strNumDoc := FieldByName('FIS_NUMDOC').AsString;

          itemNota.strDocDev:= FieldByName('DET_DOCDEV').AsString;
          itemNota.strEspDev := FieldByName('DET_ESPDEV').AsString;
          itemNota.strEmpDev := FieldByName('DET_EMPDEV').AsString;

          itemNota.participante.strCodigo := FieldByName('FIS_FORCLI').AsString;
          itemNota.participante.strNome := FieldByName('NOME').AsString;
          itemNota.participante.strCgcCpf := FieldByName('CNPJ').AsString;
          itemNota.participante.intCgcCpfInt := StrToInt64Def(FieldByName('CNPJ').AsString, 0);
          itemNota.participante.cidade.strCodigoIbge := FieldByName('CODIGO_IBGE').AsString;

          itemNota.strCodIte := FieldByName('DET_CODITE').AsString;
          itemNota.strDesIte := FieldByName('DET_DESCRI').AsString;
          itemNota.strUnidade := FieldByName('DET_UNIDAD').AsString;
          itemNota.dtaDtaEnt := FieldByName('DET_DTAENT').AsDateTime;
          itemNota.strChaveAcesso := FieldByName('FIS_ACESSO').AsString;
          itemNota.fltValorContabil := FieldByName('DET_VLRCON').AsFloat;
          itemNota.fltValBru := FieldByName('DET_TOTITE').AsFloat;
          itemNota.fltValFre := FieldByName('DET_TOTFRE').AsFloat;
          itemNota.fltQuantidade := FieldByName('DET_QTDITE').AsFloat;
          itemNota.fltValorUnitario := FieldByName('DET_UNITAR').AsFloat;
          itemNota.strCFOP := FieldByName('DET_CLAFIS').AsString;
          itemNota.fltValorIpi := FieldByName('DET_VALIPI').AsFloat;
          itemNota.fltDesconto := FieldByName('DET_DESESP').AsFloat;
          itemNota.fltDesAce := FieldByName('DET_DESACE').AsFloat;
          itemNota.strCstIcm := FieldByName('DET_CODFIS').AsString;
          itemNota.fltBasIcm := FieldByName('DET_BASICM').AsFloat;
          itemNota.fltAlqIcm := FieldByName('DET_ALQICM').AsFloat;
          itemNota.fltValIcm := FieldByName('DET_VALICM').AsFloat;
          itemNota.strCstIpi := FieldByName('DET_CSTIPI').AsString;
          itemNota.fltBasIpi := FieldByName('DET_BASIPI').AsFloat;
          itemNota.fltAlqIpi := FieldByName('DET_ALQIPI').AsFloat;
          itemNota.fltValIpi := FieldByName('DET_VALIPI').AsFloat;
          itemNota.fltValorIpiNaoCreditado := FieldByName('DET_VAEIPI').AsFloat;
          itemNota.fltBasRet := FieldByName('DET_BASRET').AsFloat;
          itemNota.fltValRet := FieldByName('DET_VALRET').AsFloat;
          itemNota.fltValorRetidoNaoCreditado := fRetValorRetido(FQryAux);
          itemNota.fltOutIcm := FieldByName('DET_OUTICM').AsFloat;
          itemNota.strCstPis := FieldByName('DET_CSTPIS').AsString;
          itemNota.fltBasPis := FieldByName('DET_BASPIS').AsFloat;
          itemNota.fltAlqPis := FieldByName('DET_ALQPIS').AsFloat;
          itemNota.fltValPis := FieldByName('DET_VALPIS').AsFloat;
          itemNota.strCstCof := FieldByName('DET_CSTCOF').AsString;
          itemNota.fltBasCof := FieldByName('DET_BASCOF').AsFloat;
          itemNota.fltAlqCof := FieldByName('DET_ALQCOF').AsFloat;
          itemNota.fltValCof := FieldByName('DET_VALCOF').AsFloat;
          itemNota.fltIsentas := FieldByName('DET_ISEICM').AsFloat;
          itemNota.strNaturezaReceitaPis := FieldByName('DET_NR_PIS').AsString;
          itemNota.strNaturezaReceitaCof := FieldByName('DET_NR_COF').AsString;
          itemNota.strReducaoBaseIcms := FieldByName('DET_PERRED').AsString;
          itemNota.fltBaseCalculoDestino := FieldByName('ICD_BCUFDE').AsFloat;
          itemNota.fltAlqFcpDestino := FieldByName('ICD_PERFCP').AsFloat;
          itemNota.fltAlqIcmsDestino := FieldByName('ICD_ALQUFD').AsFloat;
          itemNota.fltAqlIcmsInterEstadual := FieldByName('ICD_ALQINE').AsFloat;
          itemNota.fltPercentualPartilhaIcms := FieldByName('ICD_PERPAR').AsFloat;
          itemNota.fltValorFcpDestino := FieldByName('ICD_VALFCP').AsFloat;
          itemNota.fltValorIcmsDestino := FieldByName('ICD_VALDES').AsFloat;
          itemNota.fltValorIcmsOrigem := FieldByName('ICD_VALORI').AsFloat;

          itemNota.item.strCodigo := FieldByName('DET_CODITE').AsString;
          itemNota.item.strNcm := FieldByName('ITE_CLAIPI').AsString;
          itemNota.item.strCodigoCest := FieldByName('ITE_CDCEST').AsString;
          itemNota.item.unidade.strSigla := FieldByName('UNI_SIGUNI').AsString;

          notaNormal.pAdicionarItem(itemNota);
        end;

        Next;
      end;
    end;
  except
    on E: Exception do
    begin
      fMensagem('Atenção', E.Message, ['OK']);
    end;
  end;
end;

procedure TRepositorioCat42.pCarregarEnquadramentosConfigurados;
  var
    enquadramento: TEnquadramento;
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);

  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT ' +
                  '  LEFT(ENQ_DESENQ, 1) AS CODIGO, ' +
                  '  ENQ_CLAFIS, ' +
                  '  ENQ_CODFIS ' +
                  'FROM ' +
                  '  CADENQ' +
                  '  LEFT JOIN DESENQ' +
                  '    ON DESENQ.AUTOINCREM = ENQ_CODENQ ';
      Open;

      First;
      while not Eof do
      begin
        enquadramento := TEnquadramento.Create;
        enquadramento.strEnquadramento := FieldByName('CODIGO').AsString;
        enquadramento.strCfops := FieldByName('ENQ_CLAFIS').AsString;
        enquadramento.strCsts := FieldByName('ENQ_CODFIS').AsString;
        FListaEnquadramentosConfigurado.Add(enquadramento);

        Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

procedure TRepositorioCat42.pCarregaSQL;
begin
  with FQryAux do
  begin
    Close;
    SQL.Clear;
    SQL.Text := fRetSqlNotasPeriodoProduto;

    //# SAVE DO SQL PARA ANALISE 19122019 1135
    //# FQryAux.SQL.SaveToFile('C:\Users\fabio.silvaprg\Documents\REQUISITOS\SQLDelphi\untTRepositorioCat42.txt');

  end;
end;

procedure TRepositorioCat42.pCarregaSQLCompra;
begin
  with FQryAuxCompra do
  begin
    Close;
    SQL.Clear;
    SQL.Text := fRetSqlNotasPeriodoProdutoCompra;

    //# SAVE DO SQL PARA ANALISE 19122019 1135
    //# FQryAux.SQL.SaveToFile('C:\Users\fabio.silvaprg\Documents\REQUISITOS\SQLDelphi\untTRepositorioCat42.txt');

  end;
end;

end.
