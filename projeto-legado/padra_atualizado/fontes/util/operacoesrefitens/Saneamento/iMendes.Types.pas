unit iMendes.Types;

interface

uses  Rtti, TypInfo, Classes,
      StrUtils, SysUtils, System.SyncObjs,
      System.JSON, REST.Json, REST.Types, DateUtils;



  Type

  TConsultasIMendes = Record
    strCodigo: String;
    strDescri: String;
  End;

  TConsultasArrayIMendes = Array Of TConsultasIMendes;


    TModoApi = (tmaHomologacao, tmaProducao);

    TPerfil = (cjpPEF, cjpPEJ, cjpPER, cjpPES, cjpPSI, cjpPII, cjpNCO, cjpCCO, cjpCNC, cjpSNA, cjpCTA, cjpPRU ,cjpIND, cjpTRS, cjpIndef);

    TEstadoProcessamento = (epPendente, epIniciaprocesso, epCriandoEstruturaBanco, epProcessando, epRecriaTabelaResultado, epRecriaTabelaResultadoParcial,
                            epFinalizadoOk, epFinalizadoSemItem, epFinalizadoComErro, epFinalizadoPeloAutcom, epFalhaAutenticacao, epFinalizadoItemNaoEncontradoNaImendes,
                            epAlterados, epIndefinido, epReprocessaItensParcialmente);

    TFiltroDivergencia = (fdICMS, fdIPI, fdPISCOfins, fdInfGerais, fdSemImendes, fdRetornoParcialImendes, fdSemImeCodbarValidoComSaldo, fdCodbarrInvalidoComSaldo, fdCodbarrInvalido, fdSemCst, fdSemImeCodbarValido);

    TConjFiltroDivergencia = set of TFiltroDivergencia ;

    TUnidadesFederativas = (ufAC, ufAL, ufAM, ufAP, ufBA, ufCE, ufDF, ufES, ufGO, ufMA, ufMG, ufMS, ufMT, ufPA, ufPB, ufPE, ufPI, ufPR, ufRJ, ufRN, ufRO, ufRR, ufRS, ufSC, ufSE, ufSP, ufTO);


    TConjUnidadesFederativas = set of TUnidadesFederativas;

    TConjPerfis = set of TPerfil ;

    TArrOfString =  array of string;





  TRecLayoutEntidadeEmit = Record
    amb: integer;
    cnpj: String;
    crt: integer;
    regimeTrib: String;
    uf: String;
    cnae: String;
    substICMS: String;
    Dia: String;
    Mes: String;
    Ano: String;
    interdependente: String;
    RegimeEspecial: String;
    function fRetJson: TJSONObject;
  End;

  TRecLayoutEntidadePerfil = Record
    Uf: TArrOfString;
    ConjUF: TConjUnidadesFederativas;
    cfop   : string;
    caracTrib: TArrOfString;
    finalidade: integer;
    simplesN: string;
    origem: String;
    substICMS: String;
    function fRetJson: TJSONObject;
  end;

  TRecLayoutEntidadeProduto = record
    codigo: string;
    codInterno: string;
    descricao: string;
    codImendes: string;
    ncm: string;
    chave_retorno: String;
    imeItensSeqen: integer;
    function fRetJson: TJSONArray;
  end;


  ArrLayoutEntidadeProduto = array of TRecLayoutEntidadeProduto;

  TRecDadosPIS = Record
    strCSTEnt,
    strCSTSai,
    strAlq: String;
  End;

  TRecDadosCOFINS = Record
    strCSTEnt,
    strCSTSai,
    strAlq: String;
  End;

  TRecDadosProtocolo= Record
    protNome,
    descricao: String
  End;


  TRecDadosConvenio = Record
    convNome,
    descricao: String
  End;



  TRecDadosICMS = Record
    strUF,
    codigo,
    finalidade,
    codRegra,
    codExcecao,
    cFOP,
    cST,
    cSOSN,
    aliqIcmsInterna,
    aliqIcmsInterestadual,
    reducaoBcIcms,
    reducaoBcIcmsSt,
    aliqIcmsSt,

    aliqIcmsInterna_original,
    reducaoBcIcms_original,
    aliqIcmsInterestadual_original,

    iVA,
    iVAAjust,
    fCP,
    codBenef,
    pDifer,
    pIsencao,
    antecipado,
    desonerado,
    isento,
    ampLegal,
    redBcInterestadual,
    redBcICMsInterestadual,
    difalAlqIntEtadoDestino,
    tpCalcDifal: String;
    blnEncontrou: Boolean;
    RecDadosProtocolo: TRecDadosProtocolo;
    RecDadosConvenio: TRecDadosConvenio;
  End;

  TRecDadosIPI = Record
    strCSTEnt,
    strCSTSai,
    strCEX,
    strCENQ,
    strAlq: String;
  End;

  TArrRecICMS = array  of TRecDadosICMS;

  TRecDadosRetorno = Record
    strNCM,
    strCEST,
    strANP: String;
    pfPerfil: TConjPerfis;
    recPIS: TRecDadosPIS;
    recCOF: TRecDadosCOFINS;
    recIPI: TRecDadosIPI;
    ArrRecICMS: TArrRecICMS;
    blnErro: Boolean;
  End;


  TRecFiltrosApiSaneamento = Record
    FilterDescricaoDoItem: String;
    strCodEan: String;
    strCstOrigem: String;
    blnIncluindo: Boolean;
    FilterArrItem: TConsultasArrayIMendes;
    FIlterCodItem: String;
    FilterCodFornecedor: String;
    FilterArrFornecedor: TConsultasArrayIMendes;
    FilterArrLinhaGrupo: TConsultasArrayIMendes;
    FilterCodLinhaGrupo: String;
    FilterNCM: String;
    FilterArrNCM: TConsultasArrayIMendes;
    FilterAbvPis:String;
    FilterArrAbvPis: TConsultasArrayIMendes;
    FilterAbvCofins:String;
    FilterArrAbvCofins: TConsultasArrayIMendes;
    FilterAbvIpi:String;
    FilterArrAbvIpi: TConsultasArrayIMendes;
    FilterCodEmpresa: String;
    FilterArrEmpresa: TConsultasArrayIMendes;
    FilterAbvICMS: String;
    FilterArrAbvICMS: TConsultasArrayIMendes;
    FilterUFOrigem: String;
    FilterUFDestino: String;
    FilterPerfis: TConjPerfis;

  End;

  TRecComparativosApiSaneamento = record
    blnIpi,
    blnIcms,
    blnPis,
    blnCofins,
    blnNCMCest: Boolean;
  end;

  TRecParametrosApiSaneamento = Record
    StrCampoOrdenacao: String;
    ProdutosAlterados : Boolean;
    Filtros: TRecfiltrosApiSaneamento;
    Comparativos: TRecComparativosApiSaneamento;
    function fConvertToString: String;
    procedure pResetaValores;
    procedure pConvertoToRecord(AText: TStringList);
  End;

  TParamsComunicador = Record
    intTimeout: integer;
    strURL,
    strUrlAlterados,
    strDiretorioJson: string;
    strUsuario,
    strSenha: String;
  End;


  TVariaveisDeControle =  class
    intQtdThreadAtivas: integer;
    SessaoCritica : TCriticalSection;
    modApi     :TModoApi;
    blnFinalizaComoItemNaoEncontradoImendes: Boolean;
    blnFinalizacaoExterna: Boolean;
    intQtdRegistros,
    intQtdRegistrosProcessados: integer;

    DataHoraIncio: TDateTime;
    DataHoraUltimaAtualizacao: TDateTime;
    TempoExtimado: TDateTime;
    FinalizaTemporizador: Boolean;
  public

    function fTrataTextoTempo(segundos: Integer): String;


    constructor create(strCodEmp: String);
    destructor Destroy; override;
  End;

  TArrRecDadosRetorno = array of TRecDadosRetorno;


    var  IDUnicoExeImendesIntegra: String;
    var  intMaxThreadAtivas: integer;
    var IMendes_Usuario: String;
    var IMendes_Senha: String;
    var blnNotificaExecucao: Boolean;
    var VS_MacAddress: string;
    var VS_IPAddressAsString: string;
    var VS_UserFromWindows: string;
    var VS_ComputerNetName: string;
    var blnControlaTempoExecucao: Boolean;
    var TempoUltimaExecucao: TDateTime;
    var ContadorDeRequisicaoAtivado: Boolean;
    var opcFCP: integer;
    var PrefixosValidosCodigoBarra: string;

implementation

uses iMendes.Functions;

{ TRecParametrosApiSaneamento }



function TRecParametrosApiSaneamento.fConvertToString: String;
var ListaParametros: TStringList;
begin
  ListaParametros :=  TStringList.Create;
  Try

    ListaParametros.Add('TRecParametrosApiSaneamento.StrCampoOrdenacao=' + StrCampoOrdenacao);
    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.strCodEan=' + Filtros.strCodEan);
    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.strCstOrigem=' + Filtros.strCstOrigem);
    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.blnIncluindo=' + IfThen(Filtros.blnIncluindo, 'True', 'False'));

    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterDescricaoDoItem=' + Filtros.FilterDescricaoDoItem);
    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterArrItem');
    pMontaTextoTConsultasArray(ListaParametros,Filtros.FilterArrItem);

    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FIlterCodItem=' + Filtros.FIlterCodItem);

    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterCodFornecedor=' + Filtros.FilterCodFornecedor);
    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterArrFornecedor');
    pMontaTextoTConsultasArray(ListaParametros,Filtros.FilterArrFornecedor);

    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterCodLinhaGrupo=' + Filtros.FilterCodLinhaGrupo);
    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterArrLinhaGrupo');
    pMontaTextoTConsultasArray(ListaParametros,Filtros.FilterArrLinhaGrupo);

    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterNCM=' + Filtros.FilterNCM);
    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterArrNCM');
    pMontaTextoTConsultasArray(ListaParametros,Filtros.FilterArrNCM);

    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterAbvPis=' + Filtros.FilterAbvPis);
    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterArrAbvPis');
    pMontaTextoTConsultasArray(ListaParametros,Filtros.FilterArrAbvPis);

    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterAbvCofins=' + Filtros.FilterAbvCofins);
    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterArrAbvCofins');
    pMontaTextoTConsultasArray(ListaParametros,Filtros.FilterArrAbvCofins);

    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterAbvIpi=' + Filtros.FilterAbvIpi);
    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterArrAbvIpi');
    pMontaTextoTConsultasArray(ListaParametros,Filtros.FilterArrAbvIpi);

    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterCodEmpresa=' + Filtros.FilterCodEmpresa);
    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterArrEmpresa');
    pMontaTextoTConsultasArray(ListaParametros,Filtros.FilterArrEmpresa);

    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterAbvICMS=' + Filtros.FilterAbvICMS);
    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterArrAbvICMS');
    pMontaTextoTConsultasArray(ListaParametros,Filtros.FilterArrAbvICMS);

    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterUFOrigem=' + Filtros.FilterUFOrigem);
    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterUFDestino=' + Filtros.FilterUFDestino);


    ListaParametros.Add('TRecParametrosApiSaneamento.Filtros.FilterPerfis=' + PerfilToString(Filtros.FilterPerfis));

    ListaParametros.Add('TRecParametrosApiSaneamento.Comparativos.blnIpi=' + IfThen(Comparativos.blnIpi, '1', '0'));
    ListaParametros.Add('TRecParametrosApiSaneamento.Comparativos.blnIcms=' + IfThen(Comparativos.blnIcms, '1', '0'));
    ListaParametros.Add('TRecParametrosApiSaneamento.Comparativos.blnPis=' + IfThen(Comparativos.blnPis, '1', '0'));
    ListaParametros.Add('TRecParametrosApiSaneamento.Comparativos.blnCofins=' + IfThen(Comparativos.blnCofins, '1', '0'));
    ListaParametros.Add('TRecParametrosApiSaneamento.Comparativos.blnNCMCest=' + IfThen(Comparativos.blnNCMCest, '1', '0'));

    Result := ListaParametros.Text;
  Finally
    FreeAndNil(ListaParametros)
  End;
end;


procedure TRecParametrosApiSaneamento.pResetaValores;
Begin

  StrCampoOrdenacao := '';
  Filtros.FilterDescricaoDoItem := '';
  SetLength(Filtros.FilterArrItem, 0);
  Filtros.strCodEan := '';
  Filtros.strCstOrigem := '';


  Filtros.FIlterCodItem  := '';
  Filtros.FilterCodFornecedor  := '';
  SetLength(Filtros.FilterArrFornecedor, 0);

  SetLength(Filtros.FilterArrLinhaGrupo, 0);

  Filtros.FilterNCM  := '';
  SetLength(Filtros.FilterArrNCM, 0);


  Filtros.FilterAbvPis := '';
  SetLength(Filtros.FilterArrAbvPis, 0);


  Filtros.FilterAbvCofins := '';
  SetLength(Filtros.FilterArrAbvCofins, 0);

  Filtros.FilterAbvIpi := '';
  SetLength(Filtros.FilterArrAbvIpi, 0);

  Filtros.FilterCodEmpresa := '';
  SetLength(Filtros.FilterArrEmpresa, 0);

  Filtros.FilterAbvICMS := '';
  SetLength(Filtros.FilterArrAbvICMS, 0);

  Filtros.FilterUFOrigem := '';
  Filtros.FilterUFDestino := '';

  Filtros.FilterPerfis := [];

  Comparativos.blnIpi     := False;
  Comparativos.blnIcms    := False;
  Comparativos.blnPis     := False;
  Comparativos.blnCofins  := False;
  Comparativos.blnNCMCest := False;
End;

procedure TRecParametrosApiSaneamento.pConvertoToRecord(AText: TStringList);
begin
  pResetaValores;


  StrCampoOrdenacao := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.StrCampoOrdenacao');
  Filtros.FilterDescricaoDoItem := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.FilterDescricaoDoItem');
  Filtros.strCodEan := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.strCodEan');
  Filtros.strCstOrigem := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.strCstOrigem');
  Filtros.blnIncluindo := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.blnIncluindo') = 'True';
  Filtros.FilterArrItem := fLocalizaConsultaArray(AText, 'TRecParametrosApiSaneamento.Filtros.FilterArrItem');

  Filtros.FIlterCodItem  := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.FIlterCodItem');
  Filtros.FilterCodFornecedor := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.FilterCodFornecedor');

  Filtros.FilterCodLinhaGrupo := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.FilterCodLinhaGrupo');
  Filtros.FilterArrFornecedor := fLocalizaConsultaArray(AText, 'TRecParametrosApiSaneamento.Filtros.FilterArrFornecedor');
  Filtros.FilterArrLinhaGrupo := fLocalizaConsultaArray(AText, 'TRecParametrosApiSaneamento.Filtros.FilterArrLinhaGrupo');

  Filtros.FilterNCM  := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.FilterNCM');
  Filtros.FilterArrNCM := fLocalizaConsultaArray(AText, 'TRecParametrosApiSaneamento.Filtros.FilterArrNCM');

  Filtros.FilterAbvPis  := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.FilterAbvPis');
  Filtros.FilterArrAbvPis := fLocalizaConsultaArray(AText, 'TRecParametrosApiSaneamento.Filtros.FilterArrAbvPis');

  Filtros.FilterAbvCofins  := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.FilterAbvCofins');
  Filtros.FilterArrAbvCofins := fLocalizaConsultaArray(AText, 'TRecParametrosApiSaneamento.Filtros.FilterArrAbvCofins');

  Filtros.FilterAbvIpi  := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.FilterAbvIpi');
  Filtros.FilterArrAbvIpi := fLocalizaConsultaArray(AText, 'TRecParametrosApiSaneamento.Filtros.FilterArrAbvIpi');

  Filtros.FilterCodEmpresa  := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.FilterCodEmpresa');
  Filtros.FilterArrEmpresa := fLocalizaConsultaArray(AText, 'TRecParametrosApiSaneamento.Filtros.FilterArrEmpresa');

  Filtros.FilterAbvICMS  := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.FilterAbvICMS');
  Filtros.FilterArrAbvICMS := fLocalizaConsultaArray(AText, 'TRecParametrosApiSaneamento.Filtros.FilterArrAbvICMS');


  Filtros.FilterUFOrigem := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.FilterUFOrigem');
  Filtros.FilterUFDestino := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Filtros.FilterUFDestino');

  Filtros.FilterPerfis := fLocalizaValorConjPerfil(AText, 'TRecParametrosApiSaneamento.Filtros.FilterPerfis');

  Comparativos.blnIpi     := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Comparativos.blnIpi') = '1';
  Comparativos.blnIcms    := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Comparativos.blnIcms') = '1';
  Comparativos.blnPis     := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Comparativos.blnPis') = '1';
  Comparativos.blnCofins  := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Comparativos.blnCofins') = '1';
  Comparativos.blnNCMCest := fLocalizaValor(AText, 'TRecParametrosApiSaneamento.Comparativos.blnNCMCest') = '1';

End;



{ TVariaveisDeControle }

constructor TVariaveisDeControle.create(strCodEmp: String);
begin
  intQtdThreadAtivas := 0;
  FinalizaTemporizador := False;
  blnFinalizacaoExterna := False;
  SessaoCritica := TCriticalSection.Create;
  If (iMendesfCfgSis('MODSAN', varBoolean, strCodEmp)) Then
    modApi := tmaHomologacao
  Else
    modApi     := tmaProducao;
  blnFinalizaComoItemNaoEncontradoImendes := False;
end;

destructor TVariaveisDeControle.Destroy;
begin
  FreeAndNil(SessaoCritica);
  inherited;
end;

function TVariaveisDeControle.fTrataTextoTempo(segundos: Integer): String;
var
  Seg, Min, Hora: Cardinal;
begin
  Result := '';
  Hora := Segundos div 3600;
  Seg := Segundos mod 3600;
  Min := Seg div 60;
  Seg := Seg mod 60;
  If Hora > 0 Then
    Result := FormatFloat('00', Hora) + 'hs. ';
  If Min > 0 Then
     Result :=  Result + FormatFloat('00', Min) + 'min. '
  Else
     Result :=  Result + FormatFloat('00', 0) + 'min. ';
  Result :=  Result + FormatFloat('00', Seg) + 'seg.'
end;

{ TRecLayoutEntidadeEmit }

function TRecLayoutEntidadeEmit.fRetJson: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('amb', TJSONNumber.Create(amb));
  Result.AddPair('cnpj', fGetNumbers(cnpj));
  Result.AddPair('crt', TJSONNumber.Create(crt));
  Result.AddPair('regimeTrib', regimeTrib);
  If RegimeEspecial <> '' Then
    Result.AddPair('regimeEspecial', RegimeEspecial);


  Result.AddPair('substICMS', substICMS);

  Result.AddPair('uf', uf);
  Result.AddPair('cnae', cnae);
end;

{ TRecLayoutEntidadeProduto }

function TRecLayoutEntidadeProduto.fRetJson: TJSONArray;
var
  jsnProdutos: TJSONArray;
  jsnObj: TJSONObject;
  jsnText: string;
begin
  jsnProdutos := TJSONArray.Create;
  jsnObj := TJSONObject.Create;
  Try
    jsnObj.AddPair('codigo', codigo);
    jsnObj.AddPair('codInterno', 'N');
    jsnObj.AddPair('descricao', descricao);
    jsnObj.AddPair('ncm', ncm);
    jsnProdutos.Add(jsnObj);

    jsnText := TJSON.Format(jsnProdutos);

    Result := TJSONObject.ParseJSONValue(jsnText) As TJSONArray;
  Finally
    jsnProdutos.Remove(0);
    FreeAndNil(jsnProdutos);
    FreeAndNil(jsnObj);
  End;


end;

{ TRecLayoutEntidadePerfil }

function TRecLayoutEntidadePerfil.fRetJson: TJSONObject;
var
  jsnArrUF,
  jsnArrCaracTrib: TJSONArray;
  i: integer;
begin
  Result := TJSONObject.Create;

  jsnArrUF := TJSONArray.Create;
  ConjUF := [];
  For i := 0 To Length(Uf) -1 do
    If Not Uf[i].IsEmpty Then
    Begin
        jsnArrUF.Add(Uf[i]);
        ConjUF := ConjUF + fRetConUF(Uf[i]);
    End;

  jsnArrCaracTrib := TJSONArray.Create;
  For i := 0 To Length(caracTrib) -1 do
    If Not caracTrib[i].IsEmpty Then
      jsnArrCaracTrib.Add(StrToIntDef(caracTrib[i], 0));

  Result.AddPair('uf', jsnArrUF);
  Result.AddPair('cfop', cfop);
  Result.AddPair('caracTrib', jsnArrCaracTrib);
  Result.AddPair('finalidade', TJSONNumber.Create(finalidade));
  Result.AddPair('simplesN', simplesN);
  Result.AddPair('origem', origem);
  if substICMS <> '' then
    Result.AddPair('substICMS', substICMS);

end;

end.
