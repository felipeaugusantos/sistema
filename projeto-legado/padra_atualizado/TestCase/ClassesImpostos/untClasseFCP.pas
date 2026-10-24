unit untClasseFCP;

interface

uses System.SysUtils, System.Variants, Vcl.Dialogs, System.StrUtils,
  untAbstractConsulta, untIConsulta, untAbstractGerarTeste, untIGerarTeste,
  untFuncoes, UniClientDataSet, Shared.Functions.Funcoes.Faturamento,
  Shared.Functions.Types, Uni, UniDataSetProvider, untICasosTestesLog,
  untCasosTestesLog, untModulo, Faturamento.Impostos.Interfaces.FCP,
  Faturamento.Impostos.Tipos.FCP, untFatCalcularImpostos,
  Shared.Functions.Constantes, Data.DB, untCasosTestesLogImpl,
  Faturamento.Impostos.Calculos.TesteUnitarioLog, untParametrosResultadoFcp, untTypes,

  Shared.Functions.DataSet,
  Faturamento.Impostos.Interfaces.Difal,
  Faturamento.Impostos.Tipos.Difal,


  Faturamento.Impostos.Interfaces.FcpDifal,
  Faturamento.Impostos.Tipos.FcpDifal,
  Faturamento.Impostos.Interfaces.Model, Faturamento.Impostos.Tipos.Model,
  Shared.Functions.FloatUtils, Shared.Functions.Configuracoes,
  untFatCalcularImpostosService, untParametrosComparacaoFcp,
  untParametrosComparacaoDifal,
  Shared.Functions.Core;

type
  TConsultaFcp = class(TAbstractConsulta)
  private
    function RetornarColunasSQL(const ADoctosConfirmacao: boolean) : String;
    function RetornarTabelasSQL(const ADoctosConfirmacao: boolean): string;
    function RetornarFiltrosSQL: string;
    function AjustaTabelasDocumentoConfirmacao(const ASQLTabelas: string): string;

    function RetornarColunaAUX_TPOPER(Const ADoctosConfirmacao : Boolean): string;
    function RetornarColunaAUX_CODATI(Const ADoctosConfirmacao : Boolean): string;
    function RetornarColunaITEGER_ITE_INDREV: string;
    function RetornarColunaDET_ITEABF(Const ADoctosConfirmacao: Boolean): String;
    function RetornarColunaFGO_EMP_TE(Const ADoctosConfirmacao: Boolean): string;
  public
    Class function New : IConsulta;
    function fRetornarSQLFcp : String; override;
  end;

type
  TGerarTesteFcp = class(TAbstractGerarTeste)
  private
    FDados: TUniClientDataSet;
    FAliquotaDifalDoItem : Double;
    FParametrosFcpDifal: IParametrosServicoFcpDifal;
    FResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal;
    FTipoAbfCliente: String;
    FEhClienteFilial: Boolean;
    FRecordDifalFCP: TRecDifalFCP;
    FEstadoCliente: String;

    FQuantidadeRegistro : Integer;
    FProcessados        : Integer;

    FQtdeRegistrosFcpProcessados : integer;
    FQtdeRegistrosFcpAcerto      : integer;
    FQtdeRegistrosFcpErro        : integer;
    FQtdeRegistrosFcpDuplicados  : Integer;
    FQtdeRegistrosFcpIgnorados   : integer;


    FQtdeRegistrosDifalFcpProcessados : integer;
    FQtdeRegistrosDifalFcpAcerto      : integer;
    FQtdeRegistrosDifalFcpErro        : integer;
    FQtdeRegistrosDifalFcpDuplicados  : Integer;
    FQtdeRegistrosDifalFcpIgnorados   : integer;

    FQtdeRegistrosDifalProcessados : integer;
    FQtdeRegistrosDifalAcerto      : integer;
    FQtdeRegistrosDifalErro        : integer;
    FQtdeRegistrosDifalDuplicados  : Integer;
    FQtdeRegistrosDifalIgnorados   : integer;



    FCodigoAbreviacaoEmpresa       : String;
    FNotaEEspecialFornecedor       : Boolean;
    FCfgClassificacaoReposicaoGarantiaCliente: string;

    // METODOS - FCP
    function CalculouFCP(AResultadoServicosClasseFcpDifal : IResultadoServicosClasseFcpDifal) : Boolean;

    function RetornarResultadoComparacaoFcp(Const ADados : TUniClientDataSet): TResultadoComparacao;

    function AdicionarLogEspeciesIgnoradasFcp(
      const ADados: TUniClientDataSet;
      const AResultadoComparacao: TResultadoComparacao;
      const AResultadoCalculoFcp: IResultadoCalculoFcp): Boolean;

    function PodeAdicionarLogIgnoradasFcp(
      const ADados: TUniClientDataSet;
      const AResultadoCalculoFCP: IResultadoCalculoFCP): Boolean;

    function ResultadoComparacaoFcp(const ADados: TUniClientDataSet): TResultadoComparacao;

    procedure pTesteUnitarioLogFCP(const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal; ADados: TUniClientDataSet);

    function CompararResultadoFcp(Const AResultadoCalculoFcp: IResultadoCalculoFcp; Const ADados: TUniClientDataSet) : Boolean;

    // METODOS - DIFAL_FCP

    function CalculouDifalFCP(AResultadoServicosClasseFcpDifal : IResultadoServicosClasseFcpDifal) : Boolean;

    function RetornarResultadoComparacaoDifalFcp(Const ADados : TUniClientDataSet): TResultadoComparacao;

    {function AdicionarLogEspeciesIgnoradasDifalFcp(const ADados: TUniClientDataSet;
      const AResultadoComparacao: TResultadoComparacao;
      const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFcp): Boolean;}


    function ResultadoComparacaoDifalFCP(const ADados: TUniClientDataSet): TResultadoComparacao;

    procedure pTesteUnitarioLogDifalFCP(const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal; ADados: TUniClientDataSet);

    function CompararResultadoDifalFcp(Const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFcp; Const ADados: TUniClientDataSet) : Boolean;

    function ValidarResultadosFCPDifalCamposComuns(
      const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP;
      const ADados: TUniClientDataSet): boolean;

    function ValidarResultadosFCPDifalDevolucao(
      const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP;
      const ADados: TUniClientDataSet): boolean;

    function ValidarResultadosFCPDifalVenda(
      const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP;
      const ADados: TUniClientDataSet): boolean;
    // METODOS - DIFAL

    function CalculouDifal(AResultadoServicosClasseFcpDifal : IResultadoServicosClasseFcpDifal) : Boolean;

    function RetornarResultadoComparacaoDifal(Const ADados : TUniClientDataSet): TResultadoComparacao;

    function AdicionarLogEspeciesIgnoradasDifal(const ADados: TUniClientDataSet;
      const AResultadoComparacao: TResultadoComparacao;
      const AResultadoCalculoDifal: IResultadoCalculoDifal): Boolean;


    function ResultadoComparacaoDifal(const ADados: TUniClientDataSet): TResultadoComparacao;

    procedure pTesteUnitarioLogDifal(const AResultadoServicosClasseDifal: IResultadoServicosClasseFcpDifal; ADados: TUniClientDataSet);

    function CompararResultadoDifal(
      Const AResultadoCalculoDifal: IResultadoCalculoDifal ;
      Const ADados: TUniClientDataSet) : Boolean;

    function ValidarResultadosDifalCamposComuns(const AResultadoCalculoDifal: IResultadoCalculoDifal; const ADados: TUniClientDataSet): boolean;


    function ValidarResultadosDifalDevolucao(const AResultadoCalculoDifal: IResultadoCalculoDifal; const ADados: TUniClientDataSet): boolean;

    function ValidarResultadosDifalVenda(const AResultadoCalculoDifal: IResultadoCalculoDifal; const ADados: TUniClientDataSet): boolean;
    // FIM

    function RetornarTabelaAbreviacao : IMyCampoTabela;
    function RetornarEstadoEntrega(const ACodigoCidadeEntrega, AEstadoDoDocumento: string): String;
    function RetornarEstadoCliente(Const AEstadoClienteConsumidor, AEstadoCliente : String): String;
    function ValidarClienteIndustria(const ATipoDeOperacao, AClienteIndustriaCadastro: string): boolean;
    function RetornaClassificacaoFiscal(const ADados: TUniClientDataSet; AValorConfiguracao: String): String;

    Function RetornarParametrosFcpDifal(Const ADados : TUniClientDataSet): IParametrosServicoFcpDifal;

    function RetornarInterfaceClienteConsumidor(Const ADados : TUniClientDataSet) : IParametrosFaturamentoImpostosClienteConsumidor;

    procedure ZerarRegistrosDoProcessamento;

    procedure CasosTestesLogFCP(
      ACasosTestesLogFcp: ICasosTestesLog;
      AResultadoComparacaoFcp: TResultadoComparacao;
      ADados: TUniClientDataSet;
      const ATipoDaAbreviacaoFiscal: String);

    procedure CasosTestesLogDifalFCP(
      ACasosTestesLogDifalFCP: ICasosTestesLog;
      AResultadoComparacaoFcp: TResultadoComparacao;
      ADados: TUniClientDataSet;
      const ATipoDaAbreviacaoFiscal: String);

    procedure CasosTestesLogDifal(
      ACasosTestesLogDifal: ICasosTestesLog;
      AResultadoComparacaoFcp: TResultadoComparacao;
      ADados: TUniClientDataSet;
      const ATipoDaAbreviacaoFiscal: String);

    procedure TotalizarRegistrosProcessamentoFcp;
    procedure TotalizarRegistrosProcessamentoDifalFcp;
    procedure TotalizarRegistrosProcessamentoDifal;
    procedure TotalizarRegistrosProcessamentoGeral;

    procedure SetarTotaisDoProcessamentoDoFcp;
    procedure SetarTotaisDoProcessamentoDoDifalFcp;
    procedure SetarTotaisDoProcessamentoDoDifal;

    procedure InicializarVariaveisRegistros;

    procedure SetarTotaisDoProcessamentoFinal;

    function BaseDeCalculoDoIcmsDoItemSemAliquotaFcp(const ADados: TUniClientDataSet; const AResultadoCalculoFCP: IResultadoCalculoFCP): Boolean;
    function BaseDeCalculoDeIcmsEBaseDeCalculoDaSubstituicaoTributariaZerados(const ADados: TUniClientDataSet): Boolean;

    function RetornarOpcoesDeItemNotaEspiritoSanto(
      AClassificacaoFiscal: String): TOpcItensNFespTinta;

//    function RetornouResultado(AResultadoServicosClasseFcpDifal : IResultadoServicosClasseFcpDifal) : Boolean;

    function DiferencaFCPST(const ADados: TUniClientDataSet): Boolean;
    function ValidarNotaEspecialFornecedor: Boolean;
    procedure ZerarValoresFCP;
    function fGetTipoAbfCliente(const ACodigoCliente, AConsumidor,
      AInscricao: String; const AClienteIndustria: Boolean): String;
    function RetornarTipoAbreviacaoCliente: String;
    function retornarValidacaoClienteIndustria: boolean;
    function RetornarEmpresaTE: String;

    function AjustarValoresOrigem(const AOpcaoDocumento: string;
      const AValorOrigem, AValorDestino: double): double;

    function AjustarValoresDestino(const AOpcaoDocumento: string;
      const AValorOrigem, AValorDestino: double): double;
    function NotaComplementoParaFornecedores(
      const ADados: TUniClientDataSet): Boolean;
    function ValidarDiferencaFCPST(const ADados: TUniClientDataSet): Boolean;
    function ValidarBaseDestinoDifal(
      const AResultadoCalculoDifal: IResultadoCalculoDifal;
      const AValorBaseDestinoGravada: Double): boolean;
    function RetornarValorBaseDestinoDifal(
      const AResultadoCalculoDifal: IResultadoCalculoDifal): double;

    function ResultadoCalculoDifal: IResultadoCalculoDifal;
    function ResultadoCalculoDifalFcp: IResultadoCalculoDifalFcp;
    function CalculaAliquotaInterestadual: Double;
    function IgnorarRegistrosMercadoLivreSemMOVICD(const ADados: TUniClientDataSet; const AResultadoComparacao: TResultadoComparacao): Boolean;
    function VerificarMensagensMercadoLivre(const ADados: TUniClientDataSet): Boolean;

    function ParametrosCalculoDifal: IParametrosCalculoDifal;

  public
    Class function New : IGerarTeste;

    Constructor Create;
    Destructor Destroy; override;

    function fGerarTesteFcp(const ADados: OleVariant) : Boolean; override;

  end;


implementation

{ TConsultaFcp }

function TConsultaFcp.AjustaTabelasDocumentoConfirmacao(
  const ASQLTabelas: string): string;
begin
  result := ASQLTabelas;
  result := AnsiReplaceStr(result, 'MOVGER', 'NOTGER');
  result := AnsiReplaceStr(result, 'MOVDET', 'NOTDET');
  result := AnsiReplaceStr(result, 'AUXMOV', 'AUXNOT');
  result := AnsiReplaceStr(result, 'MOVTRI', 'NOTTRI');
  result := AnsiReplaceStr(result, 'MOVAUX', 'NOTAUX');
end;

function TConsultaFcp.fRetornarSQLFcp: String;
const
  UNION_ALL = ' UNION ALL ';
begin
  result := EmptyStr;
  Result := Result + RetornarColunasSQL(False);
  Result := Result + RetornarTabelasSQL(False);
  Result := Result + RetornarFiltrosSQL;
  Result := Result + UNION_ALL;
  Result := Result + RetornarColunasSQL(True);
  Result := Result + RetornarTabelasSQL(True);
  Result := Result + RetornarFiltrosSQL;
end;



class function TConsultaFcp.New: IConsulta;
begin
  Result := Self.Create;
end;

function TConsultaFcp.RetornarColunaFGO_EMP_TE(Const ADoctosConfirmacao: Boolean): string;
begin
  Result := ' "" AS FGO_EMP_TE, ' ;

  If ADoctosConfirmacao Then
    Exit;

  Result := '  EXTGOR.FGO_EMP_TE, ';
end;

function TConsultaFcp.RetornarColunaAUX_CODATI(Const ADoctosConfirmacao : Boolean): string;
begin
  Result := ' "" AS AUX_CODATI, ';

  If ADoctosConfirmacao Then
    Exit;

  If Not (objCore.fCampoExiste('AUXMOV', 'AUX_CODATI')) Then
    Exit;

  Result := ' AUXMOV.AUX_CODATI, ';

end;

function TConsultaFcp.RetornarColunaAUX_TPOPER(Const ADoctosConfirmacao: Boolean): string;
begin
  Result := ' "" AS AUX_TPOPER, ';

  If ADoctosConfirmacao Then
    Exit;

  If Not (objCore.fCampoExiste('AUXMOV', 'AUX_TPOPER')) Then
    Exit;

  Result := ' AUXMOV.AUX_TPOPER, ';
end;

function TConsultaFcp.RetornarColunaDET_ITEABF(Const ADoctosConfirmacao: Boolean) : String;
begin
  result := 'T.DET_ITEABF, ';

  If Not ADoctosConfirmacao Then
    Exit;

  result := ' D.DET_CODITE AS DET_ITEABF, ';
end;

function TConsultaFcp.RetornarColunaITEGER_ITE_INDREV: string;
begin
  result := '"" AS ITEGER_INDREV, ';

  if not objCore.fCampoExiste('ITEGER','ITE_INDREV') then
    Exit;

  result := 'IG.ITE_INDREV AS ITEGER_INDREV, ';
end;

function TConsultaFcp.RetornarColunasSQL(
  const ADoctosConfirmacao: boolean): String;
begin
  Result := 'SELECT          ' +
            '  D.DET_NUMDOC, ' +
            '  D.DET_ESPDOC, ' +
            '  D.DET_CODEMP, ' +
            '  D.DET_CODFIS, ' +
            '  G.GER_CONSUM, ' +
            '  G.GER_IESCON, ' +
            '  G.GER_ESTCON, ' +
            '  G.GER_CGCCPF, ' +
            '  G.GER_MEN002, ' +
            '  D.DET_TIP_FC, ' +
            '  D.DET_CODITE, ' +
            '  D.DET_CODFOR, ' +
            '  D.DET_CODCLI, ' +
            '  D.DET_ESTADO, ' +
            '  D.DET_IDEPRO, ' +
            '  AUX_OPCDOC,   ' +
            '  CADCLI.CLI_CODATI, ' +
            '  CADCLI.CLI_INDUST, '+
            '  CADCLI.CLI_CALICM, ' +
            '  ENTCLI.ETC_CIDENT, ' +
            '  ENTCLI.AUTOINCREM AS SEQUENCIAL_ENDERECO, ' +
            '  AUXMOV.AUX_VENPRE, ' +
               RetornarColunaAUX_TPOPER(ADoctosConfirmacao) +
               RetornarColunaAUX_CODATI(ADoctosConfirmacao) +
               RetornarColunaFGO_EMP_TE(ADoctosConfirmacao)+
            '  CIDEMP.CID_ESTADO AS CID_ESTADO_EMPRESA,  ' +
            '  DET_BASICM, ' +
            '  DET_DTAENT, ' +
            '  DET_BASRET, ' +
            '  C.ITE_INDREV AS CADITE_INDREV, ' +
               RetornarColunaITEGER_ITE_INDREV +
            '  D.DET_CLAFIS, ' +
            '  D.DET_ALQICM, ' +
            '  D.DET_VALRET, ' +
            '  D.DET_ENTFUT, ' +
            '  D.DET_VALIPI, '+
            '  D.DET_TOTFRE, '+
            '  D.DET_TOTITE, '+
            '  D.DET_DESESP, '+
            '  D.DET_DESACE, '+
            '  D.DET_QTDITE, '+
            '  D.DET_CODITE, '+
            '  D.DET_DOCDEV, '+
            '  D.DET_ESPDEV, '+
            '  D.DET_EMPDEV, '+
            '  C.ITE_CODABF AS CADITE_CODABF,  ' +
            '  IG.ITE_CODABF AS ITEGER_CODABF, ' +
            RetornarColunaDET_ITEABF(ADoctosConfirmacao) +
            '  ICD_SEQGER, ' +
            '  ICD_PERFCP, ' +
            '  ICD_VALFCP, ' +
            '  ICD_BASFCP, ' +
            '  ICD_ALQUFD, ' +
            '  ICD_ALQINE, ' +
            '  ICD_BCUFDE, ' +
            '  ICD_PERPAR, ' +
            '  ICD_VALDES, ' +
            '  ICD_VALORI  ' ;

  If Not ADoctosConfirmacao Then
    Exit;

  Result := AjustaTabelasDocumentoConfirmacao(Result);

end;

function TConsultaFcp.RetornarFiltrosSQL: string;
begin
  result :=
    '  WHERE G.GER_CODEMP = :CODEMP       ' +
    '    AND G.GER_DTAENT BETWEEN :DTAINI ' +
    '                         AND :DTAFIM ';
end;

function TConsultaFcp.RetornarTabelasSQL(
  const ADoctosConfirmacao: boolean): string;
begin
  Result := 'FROM                                                             ' +
            '  MOVGER G                                                       ' +
            '  JOIN MOVDET D                                                  ' +
            '    ON D.DET_SEQGER = G.AUTOINCREM                               ' +
            '  INNER JOIN CADITE C                                            ' +
            '    ON C.ITE_CODITE = D.DET_CODITE                               ' +
            '  INNER JOIN ITEGER IG                                           ' +
            '    ON IG.ITE_CODITE = D.DET_CODITE AND                          ' +
            '       IG.ITE_CODEMP = DET_CODEMP                                ' +
            '  INNER JOIN CADCLI                                              ' +
            '    ON CLI_CODCLI = D.DET_CODCLI                                 ' +
            '  INNER JOIN CADEMP EMP                                          ' +
            '    ON EMP.EMP_CODEMP = DET_CODEMP                               ' +
            '  INNER JOIN CADCID CID                                          ' +
            '    ON CID.CID_CODCID = CADCLI.CLI_CODCID                        ' +
            '  INNER JOIN CADCID CIDEMP                                       ' +
            '    ON CIDEMP.CID_CODCID = EMP.EMP_CODCID                        ' +
            ' LEFT JOIN MOVICD                                                ' +
            '    ON ICD_SEQGER = D.AUTOINCREM                                 ' +
            '  LEFT JOIN AUXMOV                                               ' +
            '    ON AUXMOV.AUX_SEQGER = D.DET_SEQGER                          ' +
            '  LEFT JOIN MOVTRI T  ON T.DET_SEQGER = D.AUTOINCREM             ' +
            '  LEFT JOIN FATDOR                                               ' +
            '     ON FATDOR.FDO_NUMDOC = D.DET_NUM_PD                         ' +
            '    AND FATDOR.FDO_ESPDOC = D.DET_ESP_PD                         ' +
            '    AND FATDOR.FDO_CODEMP = D.DET_EMP_PD                         ' +
            '    AND FATDOR.FDO_CODITE = D.DET_CODITE                         ' +
            '  LEFT JOIN FATGOR                                               ' +
            '    ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER                     ' +
            '  LEFT JOIN EXTGOR                                               ' +
            '    ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM                     ' +
            '  LEFT JOIN ENTCLI                                               ' +
            '    ON ETC_CODCLI = D.DET_CODCLI                                 ' +
            '    AND IF(                                                      ' +
            '      AUXMOV.AUX_ENTGER IS NOT NULL,                             ' +
            '      ENTCLI.AUTOINCREM = AUXMOV.AUX_ENTGER,                     ' +
            '      ETC_SEQIND =                                               ' +
            '      (SELECT                                                    ' +
            '        MIN(ETC_SEQIND)                                          ' +
            '      FROM                                                       ' +
            '        ENTCLI                                                   ' +
            '      WHERE ETC_CODCLI = CLI_CODCLI)                             ' +
            '    )                                                            ' ;

  If Not ADoctosConfirmacao Then
    Exit;

  Result := AjustaTabelasDocumentoConfirmacao(Result);

end;

{ TGerarTesteFcp }

function TGerarTesteFcp.AdicionarLogEspeciesIgnoradasDifal(
  const ADados: TUniClientDataSet;
  const AResultadoComparacao: TResultadoComparacao;
  const AResultadoCalculoDifal: IResultadoCalculoDifal): Boolean;
begin
//  Result := False;
//
//  If (AResultadoComparacao = rcoTrue) Then
//    Exit;
//
//  Result := True;

  Result := True;

  If IgnorarRegistrosMercadoLivreSemMOVICD(ADados, AResultadoComparacao) Then
    Exit;

  Result := False;
end;

function TGerarTesteFcp.AjustarValoresDestino(const AOpcaoDocumento: string;
  const AValorOrigem, AValorDestino: double): double;
begin
  result := AValorDestino;

  if (AOpcaoDocumento = 'DV') then
    result := AValorOrigem;
end;

function TGerarTesteFcp.AjustarValoresOrigem(const AOpcaoDocumento: string;
  const AValorOrigem, AValorDestino: double): double;
begin
  result := AValorOrigem;

  if (AOpcaoDocumento = 'DV') then
    result := AValorDestino;
end;


{function TGerarTesteFcp.AdicionarLogEspeciesIgnoradasDifalFcp(
  const ADados: TUniClientDataSet;
  const AResultadoComparacao: TResultadoComparacao;
  const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFcp): Boolean;
begin
  Result := False;

  If (AResultadoComparacao = rcoTrue) Then
    Exit;

  Result := True;
end;}

function TGerarTesteFcp.AdicionarLogEspeciesIgnoradasFcp(
  const ADados: TUniClientDataSet;
  const AResultadoComparacao: TResultadoComparacao;
  const AResultadoCalculoFcp: IResultadoCalculoFcp): Boolean;
begin
  Result := False;

  If (AResultadoComparacao = rcoTrue) Then
    Exit;

  If Not PodeAdicionarLogIgnoradasFcp(ADados, AResultadoCalculoFcp) Then
    Exit;

  Result := True;
end;

function TGerarTesteFcp.BaseDeCalculoDeIcmsEBaseDeCalculoDaSubstituicaoTributariaZerados(
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := False;

  If ADados.FieldByName('DET_BASRET').AsFloat <> 0 Then
    Exit;

  If ADados.FieldByName('DET_BASICM').AsFloat <> 0 Then
    Exit;

  Result := True;
end;

function TGerarTesteFcp.BaseDeCalculoDoIcmsDoItemSemAliquotaFcp(
  const ADados: TUniClientDataSet;
  const AResultadoCalculoFCP: IResultadoCalculoFCP): Boolean;
begin
  Result := False;

  If BaseDeCalculoDeIcmsEBaseDeCalculoDaSubstituicaoTributariaZerados(ADados) Then
    Exit;

  If AResultadoCalculoFCP.AliquotaDoFCPDoItem <> 0 Then
    Exit;

  If (AResultadoCalculoFCP.BaseDestino <= 0) Then
    Exit;

  If (AResultadoCalculoFCP.BaseFCP <= 0) Then
    Exit;

  If (AResultadoCalculoFCP.RecordDifalFCP.fltBasFcp <= 0) Then
    Exit;

  If (AResultadoCalculoFCP.GravarOsRegistros) Then
    Exit;

  Result := True;
end;

function TGerarTesteFcp.CalculaAliquotaInterestadual: Double;
var
  LEstadoEmpresa: String;
begin
  LEstadoEmpresa := objCore.fCampoTabela(['CID_ESTADO'], 'CADEMP INNER JOIN CADCID ON CID_CODCID = EMP_CODCID', ['EMP_CODEMP'], [FDados.FieldByName('DET_CODEMP').AsString], False).Fields(0);

  LEstadoEmpresa :=
    TFunctionFuncoesFaturamento.fRetUFEmpresa(LEstadoEmpresa);

  Result :=
    TFunctionFuncoesFaturamento.
      fCalculaAliquotaInterestadual(FDados.FieldByName('DET_CODFIS').AsString, //  FParametros.CodigoDaSubstituicaoTributariaDoItem
                                    LEstadoEmpresa, //FModelEmpresa.EmpresaEstado,
                                    FDados.FieldByName('DET_ESTADO').AsString); //RetornarTrocaUFEndEntrega);
end;

function TGerarTesteFcp.CalculouDifal(
  AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal): Boolean;
begin
  Result := true;

  If (AResultadoServicosClasseFcpDifal.ResultadoCalculoDifal <> Nil) Then
    Exit;

  If (AResultadoServicosClasseFcpDifal.ParametrosCalculoDifal <> Nil) Then
    Exit;

//  Inc(FQtdeRegistrosDifalIgnorados);

  Result := false;
end;

function TGerarTesteFcp.CalculouDifalFCP(
  AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal): Boolean;
begin
  Result := true;

  If (AResultadoServicosClasseFcpDifal.ResultadoCalculoDifalFcp <> Nil) Then
    Exit;

  If (AResultadoServicosClasseFcpDifal.ParametrosCalculoDifalFcp <> Nil) And (AResultadoServicosClasseFcpDifal.ResultadoCalculoFcp = nil) Then
    Exit;

//  Inc(FQtdeRegistrosDifalFCPIgnorados);


  Result := false;
end;

function TGerarTesteFcp.CalculouFCP(
  AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal): Boolean;
begin
  Result := true;

  If (AResultadoServicosClasseFcpDifal.ResultadoCalculoFcp <> Nil) Then
    Exit;

//  Inc(FQtdeRegistrosFCPIgnorados);

  Result := false;
end;

procedure TGerarTesteFcp.CasosTestesLogDifal(
  ACasosTestesLogDifal: ICasosTestesLog;
  AResultadoComparacaoFcp: TResultadoComparacao; ADados: TUniClientDataSet;
  const ATipoDaAbreviacaoFiscal: String);
begin

  ACasosTestesLogDifal.Add(
    TParametrosCasosTestesLog.New()
      .ResultadoComparacao(AResultadoComparacaoFcp)
      .RetornarNomeOperacao('Difal')
      .NumeroDoDocumento(ADados.FieldByName('DET_NUMDOC').AsString)
      .EspecieDoDocumento(ADados.FieldByName('DET_ESPDOC').AsString)
      .CodigoDaEmpresa(ADados.FieldByName('DET_CODEMP').AsString)
      .CodigoDoItem(ADados.FieldByName('DET_CODITE').AsString)
      .CodigoDoCliente(ADados.FieldByName('DET_CODCLI').AsString)
      .OpcaoDocumento(ADados.FieldByName('AUX_OPCDOC').AsString)
      .DataEntrada(ADados.FieldByName('DET_DTAENT').AsDateTime)
      .ClassificacaoFiscal(ADados.FieldByName('DET_CLAFIS').AsString)
      .CodigoFiscal(ADados.FieldByName('DET_CODFIS').AsString)
      .EstadoDoDocumento(ADados.FieldByName('DET_ESTADO').AsString)
      .TipoDaAbreviacaoFiscal(ATipoDaAbreviacaoFiscal)
      .IdentificacaoDoProduto(ADados.FieldByName('DET_IDEPRO').AsString)
      .Log(fGetVariavelLogDifal));

end;

procedure TGerarTesteFcp.CasosTestesLogDifalFCP(
  ACasosTestesLogDifalFCP: ICasosTestesLog;
  AResultadoComparacaoFcp: TResultadoComparacao; ADados: TUniClientDataSet;
  const ATipoDaAbreviacaoFiscal: String);
begin
  ACasosTestesLogDifalFCP.Add(
    TParametrosCasosTestesLog.New()
      .ResultadoComparacao(AResultadoComparacaoFcp)
      .RetornarNomeOperacao('DifalFCP')
      .NumeroDoDocumento(ADados.FieldByName('DET_NUMDOC').AsString)
      .EspecieDoDocumento(ADados.FieldByName('DET_ESPDOC').AsString)
      .CodigoDaEmpresa(ADados.FieldByName('DET_CODEMP').AsString)
      .CodigoDoItem(ADados.FieldByName('DET_CODITE').AsString)
      .CodigoDoCliente(ADados.FieldByName('DET_CODCLI').AsString)
      .OpcaoDocumento(ADados.FieldByName('AUX_OPCDOC').AsString)
      .DataEntrada(ADados.FieldByName('DET_DTAENT').AsDateTime)
      .ClassificacaoFiscal(ADados.FieldByName('DET_CLAFIS').AsString)
      .CodigoFiscal(ADados.FieldByName('DET_CODFIS').AsString)
      .EstadoDoDocumento(ADados.FieldByName('DET_ESTADO').AsString)
      .TipoDaAbreviacaoFiscal(ATipoDaAbreviacaoFiscal)
      .IdentificacaoDoProduto(ADados.FieldByName('DET_IDEPRO').AsString)
      .Log(fGetVariavelLogFCPDifal));

end;

procedure TGerarTesteFcp.CasosTestesLogFCP(ACasosTestesLogFcp: ICasosTestesLog;
  AResultadoComparacaoFcp: TResultadoComparacao; ADados: TUniClientDataSet;
  const ATipoDaAbreviacaoFiscal: String);
begin
  ACasosTestesLogFCP.Add(
    TParametrosCasosTestesLog.New()
      .ResultadoComparacao(AResultadoComparacaoFcp)
      .RetornarNomeOperacao('FCP')
      .NumeroDoDocumento(ADados.FieldByName('DET_NUMDOC').AsString)
      .EspecieDoDocumento(ADados.FieldByName('DET_ESPDOC').AsString)
      .CodigoDaEmpresa(ADados.FieldByName('DET_CODEMP').AsString)
      .CodigoDoItem(ADados.FieldByName('DET_CODITE').AsString)
      .CodigoDoCliente(ADados.FieldByName('DET_CODCLI').AsString)
      .OpcaoDocumento(ADados.FieldByName('AUX_OPCDOC').AsString)
      .DataEntrada(ADados.FieldByName('DET_DTAENT').AsDateTime)
      .ClassificacaoFiscal(ADados.FieldByName('DET_CLAFIS').AsString)
      .CodigoFiscal(ADados.FieldByName('DET_CODFIS').AsString)
      .EstadoDoDocumento(ADados.FieldByName('DET_ESTADO').AsString)
      .TipoDaAbreviacaoFiscal(ATipoDaAbreviacaoFiscal)
      .IdentificacaoDoProduto(ADados.FieldByName('DET_IDEPRO').AsString)
      .Log(fGetVariavelLogFCP));

end;

function TGerarTesteFcp.CompararResultadoDifalFcp(
  const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFcp;
  const ADados: TUniClientDataSet): Boolean;
begin
  result := ValidarResultadosFCPDifalCamposComuns(AResultadoCalculoDifalFcp, ADados);

  if (ADados.FieldByName('AUX_OPCDOC').AsString = 'DV') then
  begin
    result := result And ValidarResultadosFCPDifalDevolucao(AResultadoCalculoDifalFcp, ADados);
    exit;
  end;

  result := result and ValidarResultadosFCPDifalVenda(AResultadoCalculoDifalFcp, ADados);
end;


function TGerarTesteFcp.CompararResultadoFcp(
  const AResultadoCalculoFcp: IResultadoCalculoFcp;
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := False;

  If Not CompararValores(AResultadoCalculoFCP.AliquotaDoFCPDoItem, ADados.FieldByName('ICD_PERFCP').AsFloat) Then
    Exit;
  If Not CompararValores(AResultadoCalculoFCP.BaseDestino, ADados.FieldByName('ICD_BCUFDE').AsFloat) Then
    Exit;
  If Not CompararValores(AResultadoCalculoFCP.BaseFCP, ADados.FieldByName('ICD_BASFCP').AsFloat) Then
    Exit;
  If Not CompararValores(AResultadoCalculoFCP.ValorFCP, ADados.FieldByName('ICD_VALFCP').AsFloat) Then
    Exit;

  Result := True;
end;

function TGerarTesteFcp.ValidarNotaEspecialFornecedor : Boolean;
begin
  Result := false;

  if (FDados.FieldByName('AUX_OPCDOC').AsString <> 'NE') Then
    Exit;

  If (FDados.FieldByName('DET_TIP_FC').AsString <> 'F') Then
    Exit;

  Result := true;
end;

function TGerarTesteFcp.CompararResultadoDifal(
  const AResultadoCalculoDifal: IResultadoCalculoDifal;
  const ADados: TUniClientDataSet): boolean;
begin
  result := ValidarResultadosDifalCamposComuns(AResultadoCalculoDifal, ADados);

  if (ADados.FieldByName('AUX_OPCDOC').AsString = 'DV') then
  begin
    result := result And ValidarResultadosDifalDevolucao(AResultadoCalculoDifal, ADados);
    exit;
  end;

  result := result and ValidarResultadosDifalVenda(AResultadoCalculoDifal, ADados);
end;

function TGerarTesteFcp.RetornarValorBaseDestinoDifal(const AResultadoCalculoDifal: IResultadoCalculoDifal): double;
begin
  result := 0;

  If (AResultadoCalculoDifal.ValorIcmsDestino = 0) Then
    Exit;

  result := AResultadoCalculoDifal.ValorBaseDestino;
end;

function TGerarTesteFcp.ValidarBaseDestinoDifal(const AResultadoCalculoDifal: IResultadoCalculoDifal; const AValorBaseDestinoGravada: Double):boolean;
var
  LValorBaseDestino: double;
begin
  result := True;
  LValorBaseDestino := RetornarValorBaseDestinoDifal(AResultadoCalculoDifal);

  if CompararValores(LValorBaseDestino, AValorBaseDestinoGravada) then
    Exit;

  Result := False;
end;

function TGerarTesteFcp.ValidarResultadosDifalCamposComuns(
  const AResultadoCalculoDifal: IResultadoCalculoDifal;
  const ADados: TUniClientDataSet): boolean;
begin
  result := False;

  //if not CompararValores(AResultadoCalculoDifal.ValorBaseDestino, ADados.FieldByName('ICD_BCUFDE').AsFloat) then
  if not ValidarBaseDestinoDifal(AResultadoCalculoDifal, ADados.FieldByName('ICD_BCUFDE').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifal.AliquotaInterestadualCalc, ADados.FieldByName('ICD_ALQINE').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifal.RecordDifalFCP.fltAlDifa, FAliquotaDifalDoItem) then
    Exit;
  if not CompararValores(AResultadoCalculoDifal.RecordDifalFCP.fltAlqIne, ADados.FieldByName('ICD_ALQINE').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifal.RecordDifalFCP.fltAlqUfd, ADados.FieldByName('ICD_ALQUFD').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifal.RecordDifalFCP.fltBcuFde, ADados.FieldByName('ICD_BCUFDE').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifal.RecordDifalFCP.fltPerPar, ADados.FieldByName('ICD_PERPAR').AsFloat) then
    Exit;

  result := true;
end;

function TGerarTesteFcp.ValidarResultadosDifalDevolucao(
  const AResultadoCalculoDifal: IResultadoCalculoDifal;
  const ADados: TUniClientDataSet): boolean;
begin
  result := False;

  if not CompararValores(AResultadoCalculoDifal.ValorIcmsDestino, ADados.FieldByName('ICD_VALORI').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifal.ValorIcmsOrigem, ADados.FieldByName('ICD_VALDES').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifal.RecordDifalFCP.fltDifDes, ADados.FieldByName('ICD_VALORI').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifal.RecordDifalFCP.fltDifOri, ADados.FieldByName('ICD_VALDES').AsFloat) then
    Exit;

  result := True;

end;

function TGerarTesteFcp.ValidarResultadosDifalVenda(
  const AResultadoCalculoDifal: IResultadoCalculoDifal;
  const ADados: TUniClientDataSet): boolean;
begin
  result := False;

  if not CompararValores(AResultadoCalculoDifal.ValorIcmsDestino, ADados.FieldByName('ICD_VALDES').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifal.ValorIcmsOrigem, ADados.FieldByName('ICD_VALORI').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifal.RecordDifalFCP.fltDifDes, ADados.FieldByName('ICD_VALDES').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifal.RecordDifalFCP.fltDifOri, ADados.FieldByName('ICD_VALORI').AsFloat) then
    Exit;

  result := True;
end;

function TGerarTesteFcp.ValidarResultadosFCPDifalCamposComuns(
  const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP;
  const ADados: TUniClientDataSet): boolean;
begin
  result := False;

  if not CompararValores(AResultadoCalculoDifalFcp.AliquotaDifalDoItem, FAliquotaDifalDoItem) then
    Exit;
  if not CompararValores(AResultadoCalculoDifalFcp.BaseFCP, ADados.FieldByName('ICD_BASFCP').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifalFcp.ValorFCP, ADados.FieldByName('ICD_VALFCP').AsFloat) then
    Exit;

  result := True;

end;

function TGerarTesteFcp.ValidarResultadosFCPDifalDevolucao(
  const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP;
  const ADados: TUniClientDataSet): boolean;
begin
  result := False;

  if not CompararValores(AResultadoCalculoDifalFcp.IcmsDeOrigem, ADados.FieldByName('ICD_VALDES').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifalFcp.IcmsDeDestino, ADados.FieldByName('ICD_VALORI').AsFloat) then
    Exit;

  result := True;
end;

function TGerarTesteFcp.ValidarResultadosFCPDifalVenda(
  const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP;
  const ADados: TUniClientDataSet): boolean;
begin
  result := False;

  if not CompararValores(AResultadoCalculoDifalFcp.IcmsDeOrigem, ADados.FieldByName('ICD_VALORI').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifalFcp.IcmsDeDestino, ADados.FieldByName('ICD_VALDES').AsFloat) then
    Exit;

  result := True;
end;

constructor TGerarTesteFcp.Create;
begin

end;

destructor TGerarTesteFcp.Destroy;
begin

  inherited;
end;

procedure TGerarTesteFCP.ZerarValoresFCP;
begin
  FRecordDifalFCP.fltPerFcp := 0;
  FRecordDifalFCP.fltValFcp := 0;
  FRecordDifalFCP.fltBasFcp := 0;
end;

function TGerarTesteFcp.NotaComplementoParaFornecedores(const ADados: TUniClientDataSet): Boolean;
begin
  Result := False;

  If (ADados.FieldByName('AUX_OPCDOC').AsString <> 'OF') Then
    Exit;

  If (ADados.FieldByName('DET_TIP_FC').AsString <> 'F') Then
    Exit;

  Result := true;
end;

function TGerarTesteFcp.ValidarDiferencaFCPST(const ADados: TUniClientDataSet): Boolean;
begin
  Result := false;

  If Not NotaComplementoParaFornecedores(ADados) Then
    Exit;

  If Not(fCampoTabela('FOR_MATREV', 'CADFOR', ['FOR_CODFOR'], [ADados.FieldByName('DET_FORCLI').AsString], False, '', Nil) = 'I') Then
    Exit;

  Result := true;
end;

function TGerarTesteFcp.DiferencaFCPST(const ADados: TUniClientDataSet): Boolean;
begin
  Result := False;

  If ValidarDiferencaFCPST(ADados)Then
    Result := fExisteMovICD(ADados.FieldByName('DET_NUMDOC').AsString,
                            ADados.FieldByName('DET_ESPDOC').AsString,
                            ADados.FieldByName('DET_CODEMP').AsString);
end;


function TGerarTesteFcp.fGetTipoAbfCliente(const ACodigoCliente, AConsumidor, AInscricao: String; const AClienteIndustria: Boolean): String;
  Var
    qryCliente            : TUniQuery;
    LCodigoClienteFilial  : String;
    LAtividadeConstrutora : Boolean;
    LCodigoAtividade      : String;
    LCodigoAtividadeBD    : String;

begin
  qryCliente := fCriaQuery;

  qryCliente.SQL.Text := TFunctionFuncoesFaturamento.fGetSelectTipoAbfCliente;
  qryCliente.ParamByName('CODCLI').AsString := ACodigoCliente;
  qryCliente.Open;


  LCodigoAtividade := FDados.FieldByName('CLI_CODATI').AsString;

  LCodigoAtividadeBD :=
      fCampoTabela('ATI_CODATI', 'CLIATI', ['ATI_CODATI', 'ATI_CODEMP'], [LCodigoAtividade, FDados.FieldByName('DET_CODEMP').AsString], False);

  LAtividadeConstrutora :=
    TFunctionFuncoesFaturamento.
      fAtividadeConstrutora(LCodigoAtividade,
                            LCodigoAtividadeBD);



  Result :=
    TFunctionFuncoesFaturamento.
      fGetTipoAbfCliente(ACodigoCliente,
                         qryCliente.FieldByName('FISJUR').AsString,
                         AInscricao,
                         // IIF(fEmptyStr(AConsumidor), qryCliente.FieldByName('CONSUM').AsString, AConsumidor),
                         AConsumidor,
                         qryCliente.FieldByName('CODATI').AsString, // GER
                         qryCliente.FieldByName('PRORUR').AsString,
                         qryCliente.FieldByName('MICEMP').AsString,
                         qryCliente.FieldByName('REGTRI').AsString,
                         '',
                         IIF(AClienteIndustria, 'S', 'N'), //qryCliente.FieldByName('INDUST').AsString,
                         LCodigoClienteFilial,
                         LAtividadeConstrutora);

  FreeAndNil(qryCliente);
end;

function TGerarTesteFcp.retornarValidacaoClienteIndustria: boolean;
begin
  Result :=
    ValidarClienteIndustria(
      FDados.FieldByName('AUX_TPOPER').AsString,
      FDados.FieldByName('CLI_INDUST').AsString);

end;

function TGerarTesteFcp.RetornarTipoAbreviacaoCliente : String;
begin
  Result :=
      fGetTipoAbfCliente(FDados.FieldByName('DET_CODCLI').AsString,
                         FDados.FieldByName('GER_CONSUM').AsString,
                         FDados.FieldByName('GER_IESCON').AsString,
                         retornarValidacaoClienteIndustria);

end;


function TGerarTesteFcp.RetornarEmpresaTE : String;
begin
 Result := IIF(fEmptyStr(FDados.FieldByName('FGO_EMP_TE').AsString),
            FDados.FieldByName('DET_CODEMP').AsString,
              FDados.FieldByName('FGO_EMP_TE').AsString);
end;


function TGerarTesteFcp.fGerarTesteFcp(const ADados: OleVariant): Boolean;
var

  LCasosTestesLogFcp: ICasosTestesLog;
  LCasosTestesLogDifal: ICasosTestesLog;
  LCasosTestesLogDifalFcp: ICasosTestesLog;

//  LCodigoAtividade: String;
//  LCodigoAtividadeBD: String;
  LClientesFiliais: String;
  LEstadoEntrega: String;
  LCodigoDaEmpresa: String;

  LResultadoComparacaoFcp: TResultadoComparacao;
  LResultadoComparacaoDifalFcp: TResultadoComparacao;
  LResultadoComparacaoDifal: TResultadoComparacao;

begin
  Result := True;

  LClientesFiliais := fCampoTabela('GROUP_CONCAT(EMP_CLIFIL)', 'CADEMP', [], [], False, '', Nil);
  FCfgClassificacaoReposicaoGarantiaCliente := fGetValorConfiguracao(CFG_CLASSIF_REPOSICAO_GARANTIA_CLIENTE);

  LCasosTestesLogFcp     := TCasosTestesLog.New();
  LCasosTestesLogDifal   := TCasosTestesLog.New();
  LCasosTestesLogDifalFcp:= TCasosTestesLog.New();


  FDados := TUniClientDataSet.Create(Nil);

  InicializarVariaveisRegistros;

  Try
    FDados.Data := ADados;
    FDados.Open;
    FDados.First;

    FQuantidadeRegistro := frmModulo.Registros;
    FProcessados := 0;

    Try

      frmModulo.Registros(frmModulo.Registros * 3);

      While Not FDados.Eof Do
      Begin
        if (ValidarPararProcessamento) then
          Break;

        frmModulo.IncrementarRegistrosProcessados;

        Inc(FQtdeRegistrosDifalProcessados);
        Inc(FQtdeRegistrosDifalFcpProcessados);
        Inc(FQtdeRegistrosFcpProcessados);


        FProcessados := FProcessados + 3;

        frmModulo.RegistrosProcessados(FProcessados);

        pExecutarProgresso(FDados.RecordCount, FDados.RecNo);

        FNotaEEspecialFornecedor := ValidarNotaEspecialFornecedor;

        FEhClienteFilial := ValidarClienteFilial(FDados.FieldByName('DET_CODCLI').AsString, LClientesFiliais);

        FCodigoAbreviacaoEmpresa :=
          TFunctionFuncoesFaturamento.
            fGetCodAbf(FDados.FieldByName('CADITE_CODABF').AsString,
                       FDados.FieldByName('ITEGER_CODABF').AsString);

        LEstadoEntrega :=
          RetornarEstadoEntrega(FDados.FieldByName('ETC_CIDENT').AsString,
                                FDados.FieldByName('DET_ESTADO').AsString);


        LCodigoDaEmpresa := FDados.FieldByName('DET_CODEMP').AsString;

        ZerarValoresFCP;

        FEstadoCliente :=
          RetornarEstadoCliente( FDados.FieldByName('GER_ESTCON').AsString,
                                 FDados.FieldByName('DET_ESTADO').AsString );

        FTipoAbfCliente := RetornarTipoAbreviacaoCliente;
        FParametrosFcpDifal := RetornarParametrosFcpDifal(FDados);

        FResultadoServicosClasseFcpDifal := GetFaturamentoImpostosService.FcpDifal.CalcularValorFcpDifalFinal(FParametrosFcpDifal);

//        If Not RetornouResultado(FResultadoServicosClasseFcpDifal) Then
//        begin
//          // frmModulo.IncrementarRegistrosProcessadosIgnorados;
//
//          Inc(FQtdeRegistrosDifalIgnorados);
//          Inc(FQtdeRegistrosDifalFCPIgnorados);
//          Inc(FQtdeRegistrosFCPIgnorados);
//
//          FDados.Next;
//          Continue;
//        end;

        If CalculouFCP(FResultadoServicosClasseFcpDifal) Then
        begin
          frmModulo.IncrementarRegistrosProcessados;
          LResultadoComparacaoFcp := ResultadoComparacaoFcp(FDados);

          pTesteUnitarioLogFCP(FResultadoServicosClasseFcpDifal, FDados);

          ZerarRegistrosDoProcessamento;

          CasosTestesLogFCP(LCasosTestesLogFcp, LResultadoComparacaoFcp, FDados, FTipoAbfCliente);
          TotalizarRegistrosProcessamentoFcp;
        end;

        If CalculouDifalFCP(FResultadoServicosClasseFcpDifal) Then
        begin
          frmModulo.IncrementarRegistrosProcessados;
          LResultadoComparacaoDifalFCP := ResultadoComparacaoDifalFCP(FDados);

          pTesteUnitarioLogDifalFCP(FResultadoServicosClasseFcpDifal, FDados);
          ZerarRegistrosDoProcessamento;

          CasosTestesLogDifalFCP(LCasosTestesLogDifalFcp, LResultadoComparacaoDifalFcp, FDados, FTipoAbfCliente);
          TotalizarRegistrosProcessamentoDifalFcp;
        end;


        If CalculouDifal(FResultadoServicosClasseFcpDifal) Then
        begin
          frmModulo.IncrementarRegistrosProcessados;
          LResultadoComparacaoDifal := ResultadoComparacaoDifal(FDados);

          pTesteUnitarioLogDifal(FResultadoServicosClasseFcpDifal, FDados);
          ZerarRegistrosDoProcessamento;

          CasosTestesLogDifal(LCasosTestesLogDifal, LResultadoComparacaoDifal, FDados, FTipoAbfCliente);
          TotalizarRegistrosProcessamentoDifal;
        end;

        TotalizarRegistrosProcessamentoGeral;

        pLimparVariaveisTesteUnitario;

        FDados.Next;
      End;
      SetarTotaisDoProcessamentoDoFcp;
      LCasosTestesLogFcp.GerarLog('Fcp');

      SetarTotaisDoProcessamentoDoDifal;
      LCasosTestesLogDifal.GerarLog('Difal');

      SetarTotaisDoProcessamentoDoDifalFcp;
      LCasosTestesLogDifalFcp.GerarLog('FCPDifal');

      SetarTotaisDoProcessamentoFinal;

      frmModulo.Registros(FQuantidadeRegistro * 3);

    Except
      On E : Exception do
        pFinalizarProcessamentoComErro(FDados, E.Message);
    End;
  Finally
    FreeAndNil(FDados);
  End;
end;

function TGerarTesteFcp.RetornarOpcoesDeItemNotaEspiritoSanto(
  AClassificacaoFiscal: String): TOpcItensNFespTinta;
begin
  Result := opcProdutoAcabado;

  If AClassificacaoFiscal = '1926' Then
    Exit;

  Result := opcColorantesTributados;

  If AClassificacaoFiscal = '5926' Then
    Exit;

  Result := opcVazio;
end;

function TGerarTesteFcp.RetornarParametrosFcpDifal(
  const ADados: TUniClientDataSet): IParametrosServicoFcpDifal;
Var
  LProdutoIndustrializacao : Boolean;
begin

  LProdutoIndustrializacao :=
    TFunctionFuncoesFaturamento
      .fItemRevInd(FDados.FieldByName('CADITE_INDREV').AsString, FDados.FieldByName('ITEGER_INDREV').AsString) = 'I';

  FAliquotaDifalDoItem := (FDados.FieldByName('ICD_ALQUFD').AsFloat - FDados.FieldByName('ICD_ALQINE').AsFloat);

  FRecordDifalFCP.fltAlDifa := FAliquotaDifalDoItem;

  FRecordDifalFCP.fltDifDes :=
    AjustarValoresDestino(
      ADados.FieldByName('AUX_OPCDOC').AsString,
      ADados.FieldByName('ICD_VALORI').AsFloat,
      ADados.FieldByName('ICD_VALDES').AsFloat);

  FRecordDifalFCP.fltDifOri :=
    AjustarValoresOrigem(
      ADados.FieldByName('AUX_OPCDOC').AsString,
      ADados.FieldByName('ICD_VALORI').AsFloat,
      ADados.FieldByName('ICD_VALDES').AsFloat);

  FRecordDifalFCP.fltAlqIne := ADados.FieldByName('ICD_ALQINE').AsFloat;
  FRecordDifalFCP.fltAlqUfd := ADados.FieldByName('ICD_ALQUFD').AsFloat;
  FRecordDifalFCP.fltBcuFde := ADados.FieldByName('ICD_BCUFDE').AsFloat;
  FRecordDifalFCP.fltPerPar := ADados.FieldByName('ICD_PERPAR').AsFloat;


  Result :=
    TParametrosServicoFcpDifal.New
      .CodigoDoItemDaAbreviacaoFiscal(ADados.FieldByName('DET_ITEABF').AsString)
      .CodigoDaAbreviacaoFiscal(FCodigoAbreviacaoEmpresa)
      .SequencialEnderecoEntrega(ADados.FieldByName('SEQUENCIAL_ENDERECO').AsString)
      .TipoDaAbreviacaoFiscal(FTipoAbfCliente)
      .VendaPresencial(ADados.FieldByName('AUX_VENPRE').AsString = 'S')
      .ClienteConsumidorFinal(ADados.FieldByName('GER_CONSUM').AsString = 'S')
      .NotaComplementoFornecedor(ADados.FieldByName('AUX_OPCDOC').AsString = 'OF')
      .NotaEspecialFornecedor(FNotaEEspecialFornecedor)
      .CodigoDoCliente(ADados.FieldByName('DET_CODCLI').AsString)
      .CodigoDoFornecedor(ADados.FieldByName('DET_CODFOR').AsString)
      .ClienteFilial(FEhClienteFilial)
      .OpcaoDeDocumento(ADados.FieldByName('AUX_OPCDOC').AsString)
      .CodigoDaSituacaoTributaria(ADados.FieldByName('DET_CODFIS').AsString) // Verificar
      .BaseDeCalculoDoIcmsDoItem(ADados.FieldByName('DET_BASICM').AsFloat)
      .DocumentoDeDevolucao(Not fEmptyStr(ADados.FieldByName('DET_DOCDEV').AsString))
      .DiferencaFCPST(DiferencaFCPST(ADados))
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(ADados.FieldByName('DET_BASRET').AsFloat)
      .CodigoDaSubstituicaoTributariaDoItem(ADados.FieldByName('DET_CODFIS').AsString)
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoIndustrializado(LProdutoIndustrializacao)
      .ParametrosClienteConsumidor(RetornarInterfaceClienteConsumidor(ADados))
      .CodigoDaEmpresa(ADados.FieldByName('DET_CODEMP').AsString)
      .ClassificacaoFiscalDoItem(ADados.FieldByName('DET_CLAFIS').AsString)
      .GerandoCasosTestes(True)
      .CodigoDaEmpresaTE(ADados.FieldByName('FGO_EMP_TE').AsString)
      .AliquotaDeIcmsDoItem(ADados.FieldByName('DET_ALQICM').AsFloat)
      .DataDoSistema(ADados.FieldByName('DET_DTAENT').AsDateTime)
      .ClienteIndustria(retornarValidacaoClienteIndustria)
      .ClassificacaoFiscalRecebimentoGarantia(RetornaClassificacaoFiscal(FDados, FCfgClassificacaoReposicaoGarantiaCliente))
      .AliquotaFCPST(0)
      .BaixaDeEntregaFutura(ADados.FieldByName('AUX_OPCDOC').AsString = 'BF')
      .EspecieDoDocumento(ADados.FieldByName('DET_ESPDOC').AsString)
      .ValorDaSubstituicaoTributariaDoItem(ADados.FieldByName('DET_VALRET').AsFloat)
      .EntregaFuturaDoItem(ADados.FieldByName('DET_ENTFUT').AsString = 'S')
      .NumeroDoDocumentoDeDevolucao(ADados.FieldByName('DET_DOCDEV').AsString)
      .EspecieDoDocumentoDeDevolucao(ADados.FieldByName('DET_ESPDEV').AsString)
      .EmpresaDoDocumentoDeDevolucao(ADados.FieldByName('DET_EMPDEV').AsString)
      .CodigoDoItem(ADados.FieldByName('DET_CODITE').AsString)
      .QuantidadeDoItem(ADados.FieldByName('DET_QTDITE').AsFloat)
      .OpcaoDeItemNfEspiritoSanto(RetornarOpcoesDeItemNotaEspiritoSanto(ADados.FieldByName('DET_CLAFIS').AsString))
      .ValorDoIpi(ADados.FieldByName('DET_VALIPI').AsFloat )
      .ValorDoFrete(ADados.FieldByName('DET_TOTFRE').AsFloat )
      .ValorTotalDoItem(ADados.FieldByName('DET_TOTITE').AsFloat)
      .DescontoEspecial(ADados.FieldByName('DET_DESESP').AsFloat )
      .DespesasAcessorias(ADados.FieldByName('DET_DESACE').AsFloat)
      .PercentualBaseDoIcmsDoItem(RetornarTabelaAbreviacao.FieldByName('ABF_BASICM' + FTipoAbfCliente).AsFloat);
end;


function TGerarTesteFcp.IgnorarRegistrosMercadoLivreSemMOVICD(
  const ADados: TUniClientDataSet;
  const AResultadoComparacao: TResultadoComparacao): Boolean;
begin
  Result := False;

  If (Not VerificarMensagensMercadoLivre(ADados)) Then
    Exit;

  If (ADados.FieldByName('ICD_SEQGER').AsString <> '') Then
    Exit;

  If (Not (AResultadoComparacao = rcoTrue)) Then
    Exit;

  Result := True;
end;

procedure TGerarTesteFcp.InicializarVariaveisRegistros;
begin
  FQuantidadeRegistro          := 0;

  FQtdeRegistrosFcpDuplicados  := 0;
  FQtdeRegistrosFcpAcerto      := 0;
  FQtdeRegistrosFcpProcessados := 0;
  FQtdeRegistrosFcpErro        := 0;
  FQtdeRegistrosFcpIgnorados   := 0;

  FQtdeRegistrosDifalFcpDuplicados  := 0;
  FQtdeRegistrosDifalFcpAcerto      := 0;
  FQtdeRegistrosDifalFcpProcessados := 0;
  FQtdeRegistrosDifalFcpErro        := 0;
  FQtdeRegistrosDifalFcpIgnorados   := 0;

  FQtdeRegistrosDifalDuplicados  := 0;
  FQtdeRegistrosDifalAcerto      := 0;
  FQtdeRegistrosDifalProcessados := 0;
  FQtdeRegistrosDifalErro        := 0;
  FQtdeRegistrosDifalIgnorados   := 0;
end;

function TGerarTesteFcp.VerificarMensagensMercadoLivre(
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := True;

  If (ADados.FieldByName('GER_MEN002').AsString = 'Envio: Normal - Origem: mercadolivre - DDMAQUINAS') Then
    Exit;

  If (ADados.FieldByName('GER_MEN002').AsString = 'Envio: Prioritário - Origem: mercadolivre - DDMAQUINAS') Then
    Exit;

  If (ADados.FieldByName('GER_MEN002').AsString = 'Envio: SEDEX - Origem: magazineluiza - MagazineLuiza') Then
    Exit;

  If (ADados.FieldByName('GER_MEN002').AsString = 'Envio: Normal - Origem: mercadolivre - GETPOWER.GP') Then
    Exit;

  If (ADados.FieldByName('GER_MEN002').AsString = 'Envio: Courier - Origem: b2wskyhub - Lojas Americanas') Then
    Exit;

  If (ADados.FieldByName('GER_MEN002').AsString = 'Envio: Courier - Origem: b2wskyhub - Submarino') Then
    Exit;

  If (ADados.FieldByName('GER_MEN002').AsString = 'Envio: Courier - Origem: b2wskyhub - Shoptime') Then
    Exit;

  If (ADados.FieldByName('GER_MEN002').AsString = 'Envio: Rodo - Origem: b2wskyhub - Lojas Americanas') Then
    Exit;

  If (ADados.FieldByName('GER_MEN002').AsString = 'Envio: Normal - Origem: mercadolivre - DDPSHOP') Then
    Exit;

  If (ADados.FieldByName('GER_MEN002').AsString = 'Envio: Correios - Origem: MercadoLivre - DDMAQUINAS') Then
    Exit;

  If (ADados.FieldByName('GER_MEN002').AsString = 'ENVIO: RODO - ORIGEM: B2WSKYHUB - SHOPTIME') Then
    Exit;

  If (ADados.FieldByName('GER_MEN002').AsString = 'ENVIO: MAGALU ENTREGAS - ORIGEM: MAGAZINELUIZA - MAGAZINELUIZA') Then
    Exit;

  If (ADados.FieldByName('GER_MEN002').AsString = 'ENVIO: B2W_DIRECT - ORIGEM: B2WSKYHUB - LOJAS AMERICANAS') Then
    Exit;


  Result := False;
end;

class function TGerarTesteFcp.New: IGerarTeste;
begin
  Result := Self.Create;
end;

function TGerarTesteFcp.ParametrosCalculoDifal: IParametrosCalculoDifal;
begin
  If Assigned(FResultadoServicosClasseFcpDifal.ResultadoCalculoFCP) And
     Assigned(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal) Then
  Begin
    Result :=
      TParametrosCalculoDifal.New
        .ValorIpiDoItem(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.ValorIpiDoItem)
        .ValorFreteDoItem(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.ValorFreteDoItem)
        .AliquotaInterestadualCalc(0)
        .ValorIcmsBase(0)
        .TotalDoItem(0)
        .DescontoEspecialDoItem(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.DescontoEspecialDoItem)
        .DespesaAcessoriaDoItem(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.DespesaAcessoriaDoItem)
        .PercentualBaseOrigem(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.PercentualBaseOrigem)
        .PercentualBaseDestino(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.PercentualBaseDestino)
        .PercentualBaseDifalOrigem(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.PercentualBaseDifalOrigem)
        .PercentualBaseDifalDestino(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.PercentualBaseDifalDestino)
        .CalculaAliquotaInterestadual(FDados.FieldByName('ICD_ALQINE').AsFloat)
        .CalculaAliquotaEfetivaOrigem(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.CalculaAliquotaEfetivaOrigem)
        .AliquotaInternaEstadoDestino(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.AliquotaInternaEstadoDestino)
        .PercentualProvisorioPartilha(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.PercentualProvisorioPartilha)
        .ProdutoSt(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.ProdutoST)
        .SimplesNacional(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.SimplesNacional)
        .AbreviacaoIcmsProduto(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.AbreviacaoIcmsProduto)
        .AbreviacaoIcmsProdutoUfEmpresa(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.AbreviacaoIcmsProdutoUfEmpresa)
        .HabilitarPercentualBase(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.HabilitarPercentualBase)
        .CodigoSituacaoTributaria(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.CodigoSituacaoTributaria)
        .CalculaTipoDeAbreviacaoFiscal(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.CalculaTipoDeAbreviacaoFiscal)
        .SituacaoReducaoBaseCalculo(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.SituacaoReducaoBaseCalculo)
        .CalculaBaseReduzidaAliquotaEfetiva(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.CalculaBaseReduzidaAliquotaEfetiva)
        .CalculaDiferencialAliquotaProdutosSt(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.CalculaDiferencialAliquotaProdutosSt)
        .ProdutoDeOrigemEstrangeira(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.ProdutoDeOrigemEstrangeira)
        .ConsiderarAliquotaEfetivaProdutosImportados(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.ConsiderarAliquotaEfetivaProdutosImportados)
        .RecordDifalFCP(FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal.RecordDifalFCP);
    Exit;
  End;

  Result := FResultadoServicosClasseFcpDifal.ParametrosCalculoDifal;
end;

function TGerarTesteFcp.PodeAdicionarLogIgnoradasFcp(
  const ADados: TUniClientDataSet;
  const AResultadoCalculoFCP: IResultadoCalculoFCP): Boolean;
begin
  Result := True;

  If BaseDeCalculoDoIcmsDoItemSemAliquotaFcp(ADados, AResultadoCalculoFCP) Then
    Exit;

  Result := False;
end;

procedure TGerarTesteFcp.pTesteUnitarioLogDifal(
  const AResultadoServicosClasseDifal: IResultadoServicosClasseFcpDifal;
  ADados: TUniClientDataSet);
Var
  LResultadoCalculoDifal : IResultadoCalculoDifal;
begin
  {Setando os Valores de DIFAL}
  LResultadoCalculoDifal := ResultadoCalculoDifal; //AResultadoServicosClasseDifal.ResultadoCalculoDifal;

  SetarResultadosComparacao(LResultadoCalculoDifal);

  SetarParametrosComparacao(
    TParametrosComparacaoDifal.New()
     .ValorBaseDestino(LResultadoCalculoDifal.ValorBaseDestino)
     .ValorIcmsDestino(LResultadoCalculoDifal.ValorIcmsDestino)
     .ValorIcmsOrigem(LResultadoCalculoDifal.ValorIcmsOrigem)
     .AliquotaInterestadualCalc(LResultadoCalculoDifal.AliquotaInterestadualCalc)
     .RecordDifalFCP(FRecordDifalFCP));

  pGerarLogTesteUnitario((ParametrosCalculoDifal as TObject), (ResultadoCalculoDifal as TObject), Nil, 'CalcularValorDifal');

end;

procedure TGerarTesteFcp.pTesteUnitarioLogDifalFCP(
  const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal;
  ADados: TUniClientDataSet);
var
  LResultadoCalculoDifalFcp: IResultadoCalculoDifalFcp;
begin
  {Setando os Valores de DIFAL_FCP}
  LResultadoCalculoDifalFcp := ResultadoCalculoDifalFcp;

  SetarResultadosComparacao(LResultadoCalculoDifalFcp);

  SetarParametrosComparacao(
    TParametrosComparacaoDifalFCP.New()
      .AliquotaDifalDoItem(FAliquotaDifalDoItem )
      .IcmsDeOrigem(LResultadoCalculoDifalFcp.IcmsDeOrigem) //ADados.FieldByName('ICD_VALORI').AsFloat
      .IcmsDeDestino(LResultadoCalculoDifalFcp.IcmsDeDestino) //ADados.FieldByName('ICD_VALDES').AsFloat
      .BaseFCP(ADados.FieldByName('ICD_BASFCP').AsFloat)
      .ValorFCP(ADados.FieldByName('ICD_VALFCP').AsFloat));

  pGerarLogTesteUnitario((AResultadoServicosClasseFcpDifal.ParametrosCalculoDifalFcp as TObject),
                         (ResultadoCalculoDifalFcp as TObject),
                         Nil,
                         'CalcularValorDifalFCP');
end;

procedure TGerarTesteFcp.pTesteUnitarioLogFCP(
  const AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal;
  ADados: TUniClientDataSet);
var
  FRecordDifalFCP: TRecDifalFCP;
begin
  {Setando os Valores de FCP}
  SetarResultadosComparacao(AResultadoServicosClasseFcpDifal.ResultadoCalculoFcp);

  FRecordDifalFCP.fltPerFcp := ADados.FieldByName('ICD_PERFCP').AsFloat;
  FRecordDifalFCP.fltValFcp := ADados.FieldByName('ICD_VALFCP').AsFloat;
  FRecordDifalFCP.fltBasFcp := ADados.FieldByName('ICD_BASFCP').AsFloat;

  SetarParametrosComparacao(
    TParametrosComparacaoFcp.New()
      .BaseDestino(ADados.FieldByName('ICD_BCUFDE').AsFloat)
      .BaseFCP(ADados.FieldByName('ICD_BASFCP').AsFloat)
      .ValorFCP(ADados.FieldByName('ICD_VALFCP').AsFloat)
      .AliquotaDoFCPDoItem(ADados.FieldByName('ICD_PERFCP').AsFloat)
      .RecordDifalFCP(FRecordDifalFCP));


  pGerarLogTesteUnitario((AResultadoServicosClasseFcpDifal.ParametrosCalculoFcp as TObject),
                         (AResultadoServicosClasseFcpDifal.ResultadoCalculoFcp as TObject),
                         Nil,
                         'CalcularValorFCP');
end;

function TGerarTesteFcp.ResultadoCalculoDifal: IResultadoCalculoDifal;
var
  LRecordDifalFCP: TRecDifalFCP;
  LAliquotaInterestadualCalc: Double;
  LBaseUfDestino: Double;
  LValorDestino: Double;
  LValorOrigem: Double;
begin
  If Assigned(FResultadoServicosClasseFcpDifal.ResultadoCalculoDifal) Then
  Begin
    Result := FResultadoServicosClasseFcpDifal.ResultadoCalculoDifal;
    Exit;
  End;

  LRecordDifalFCP.fltAlDifa := FRecordDifalFCP.fltAlDifa;
  LRecordDifalFCP.fltDifDes := FRecordDifalFCP.fltDifDes;
  LRecordDifalFCP.fltDifOri := FRecordDifalFCP.fltDifOri;
  LRecordDifalFCP.fltAlqIne := FRecordDifalFCP.fltAlqIne;
  LRecordDifalFCP.fltAlqUfd := FRecordDifalFCP.fltAlqUfd;
  LRecordDifalFCP.fltBcuFde := FRecordDifalFCP.fltBcuFde;
  LRecordDifalFCP.fltPerPar := FRecordDifalFCP.fltPerPar;

  LAliquotaInterestadualCalc := LRecordDifalFCP.fltAlqIne;

  If LAliquotaInterestadualCalc > 0 Then
    LAliquotaInterestadualCalc := CalculaAliquotaInterestadual;

  LBaseUfDestino := 0;
  LValorDestino := 0;
  LValorOrigem := 0;

  If FDados.FieldByName('AUX_OPCDOC').AsString = 'DV' Then
  Begin
    LBaseUfDestino := FDados.FieldByName('ICD_BCUFDE').AsFloat;
    LValorDestino := FDados.FieldByName('ICD_VALORI').AsFloat;
    LValorOrigem := FDados.FieldByName('ICD_VALDES').AsFloat;
  End;

  Result :=
    TResultadoCalculoDifal.New
      .ValorBaseDestino(LBaseUfDestino)
      .ValorIcmsDestino(LValorDestino)
      .ValorIcmsOrigem(LValorOrigem)
      .AliquotaInterestadualCalc(LAliquotaInterestadualCalc)
      .RecordDifalFCP(LRecordDifalFCP);
end;

function TGerarTesteFcp.ResultadoCalculoDifalFcp: IResultadoCalculoDifalFcp;
var
  LValorDestino: Double;
  LValorOrigem: Double;
begin
  If Assigned(FResultadoServicosClasseFcpDifal.ResultadoCalculoDifalFcp) Then
  Begin
    Result := FResultadoServicosClasseFcpDifal.ResultadoCalculoDifalFcp;
    Exit;
  End;

  LValorDestino := 0;
  LValorOrigem := 0;

  If FDados.FieldByName('AUX_OPCDOC').AsString = 'DV' Then
  Begin
    LValorDestino := FDados.FieldByName('ICD_VALORI').AsFloat;
    LValorOrigem := FDados.FieldByName('ICD_VALDES').AsFloat;
  End;

  Result :=
    TResultadoCalculoDifalFcp.New
      .AliquotaDifalDoItem(FAliquotaDifalDoItem)
      .IcmsDeOrigem(LValorOrigem)
      .IcmsDeDestino(LValorDestino)
      .BaseFCP(0)
      .ValorFCP(0);
end;

function TGerarTesteFcp.ResultadoComparacaoDifal(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := RetornarResultadoComparacaoDifal(ADados);

  If AdicionarLogEspeciesIgnoradasDifal(ADados,
                                        Result,
                                        FResultadoServicosClasseFcpDifal.ResultadoCalculoDifal) Then
  Begin
    Result := rcoIgnorado;
  End;
end;

function TGerarTesteFcp.ResultadoComparacaoDifalFCP(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := RetornarResultadoComparacaoDifalFcp(ADados);


  {If AdicionarLogEspeciesIgnoradasDifalFcp(ADados,
                                           Result,
                                           FResultadoServicosClasseFcpDifal.ResultadoCalculoDifalFcp) Then
  Begin
    Result := rcoIgnorado;
  End;}

end;

function TGerarTesteFcp.ResultadoComparacaoFcp(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := RetornarResultadoComparacaoFcp(ADados);


  If AdicionarLogEspeciesIgnoradasFcp(ADados,
                                      Result,
                                      FResultadoServicosClasseFcpDifal.ResultadoCalculoFcp) Then
  Begin
    Result := rcoIgnorado;
  End;
end;

function TGerarTesteFcp.RetornaClassificacaoFiscal(
  const ADados: TUniClientDataSet; AValorConfiguracao: String): String;
begin
  Result := '';

  If (Pos(ADados.FieldByName('DET_CLAFIS').AsString, AValorConfiguracao) <= 0) Then
    Exit;

  Result := ADados.FieldByName('DET_CLAFIS').AsString;
end;


function TGerarTesteFcp.RetornarEstadoCliente(const AEstadoClienteConsumidor,
  AEstadoCliente: String): String;
begin
  Result := AEstadoClienteConsumidor;

  If Not objFloatUtils.fEmptyStr(Result) Then
    Exit;

  Result := AEstadoCliente;
end;

function TGerarTesteFcp.RetornarEstadoEntrega(const ACodigoCidadeEntrega,
  AEstadoDoDocumento: string): String;
begin
  Result := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [ACodigoCidadeEntrega], False);

  If (Not fEmptyStr(Result)) Then
    Exit;

  Result := AEstadoDoDocumento;
end;

function TGerarTesteFcp.RetornarInterfaceClienteConsumidor(
  const ADados: TUniClientDataSet): IParametrosFaturamentoImpostosClienteConsumidor;
begin

  Result :=
    TParametrosFaturamentoImpostosClienteConsumidor.New
      .ClienteEstado(FEstadoCliente)
      .ClienteInscricaoEstadual(ADados.FieldByName('GER_IESCON').AsString)
      .ClienteAtividade(ADados.FieldByName('CLI_CODATI').AsString)
      .CalcularDescontoIcmsOrgaoPublico(
        TFunctionFuncoesFaturamento.
          ValidarDescontoDeICMSOrgaoPublico(
            ADados.FieldByName('AUX_OPCDOC').AsString,
            ADados.FieldByName('CLI_CALICM').AsString) = 'S')
      .ClienteFisicoOuJuridico(
        TFunctionFuncoesFaturamento
          .RetornarClienteFisicoOuJuridico(ADados.FieldByName('GER_CGCCPF').AsInteger));
end;

function TGerarTesteFcp.RetornarResultadoComparacaoDifal(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := rcoFalse;

  If Not CompararResultadoDifal(ResultadoCalculoDifal, ADados) Then
    Exit;

  Result := rcoTrue;
end;

function TGerarTesteFcp.RetornarResultadoComparacaoDifalFcp(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := rcoFalse;

  If Not CompararResultadoDifalFcp(ResultadoCalculoDifalFcp, ADados) Then
    Exit;

  Result := rcoTrue;
end;

function TGerarTesteFcp.RetornarResultadoComparacaoFcp(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := rcoFalse;

  If Not CompararResultadoFcp(FResultadoServicosClasseFcpDifal.ResultadoCalculoFcp, ADados) Then
    Exit;

  Result := rcoTrue;
end;

function TGerarTesteFcp.RetornarTabelaAbreviacao: IMyCampoTabela;
Var
  LSQL        : String;
  LParametros : ArrOfString;
  LValores    : ArrOfVariant;
begin
  LParametros := ['CODITE', 'CODABF', 'ESTADO'];

  LValores := [FDados.FieldByName('DET_CODITE').AsString,
               FCodigoAbreviacaoEmpresa,
               FEstadoCliente];

  LSQL := TFunctionFuncoesFaturamento
            .SqlBuscaAbfIcm(RetornarEmpresaTE,
                            FDados.FieldByName('DET_CODEMP').AsString);

  result := objCore.fCampoTabelaDados(LSQL, LParametros, LValores);
end;

//function TGerarTesteFcp.RetornouResultado(
//  AResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal): Boolean;
//begin
//  Result := true;
//
//  If (AResultadoServicosClasseFcpDifal.ResultadoCalculoFcp <> Nil) Then
//    Exit;
//
//  If (AResultadoServicosClasseFcpDifal.ResultadoCalculoDifal <> Nil) Then
//    Exit;
//
//  If (AResultadoServicosClasseFcpDifal.ResultadoCalculoDifalFcp <> Nil) Then
//    Exit;
//
//  Result := false;
//end;

function TGerarTesteFcp.ValidarClienteIndustria(const ATipoDeOperacao,
  AClienteIndustriaCadastro: string): boolean;
begin
  result := AClienteIndustriaCadastro = 'S';

  if (not objConfiguracoes.fGetValorConfiguracao('USOREV', varBoolean)) then
    Exit;

  result := (ATipoDeOperacao = INDUSTRIALIZACAO);
end;

procedure TGerarTesteFcp.SetarTotaisDoProcessamentoDoDifal;
begin
  frmModulo.Registros(FQuantidadeRegistro);
  frmModulo.RegistrosProcessados(FQtdeRegistrosDifalProcessados);
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosDifalAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosDifalErro);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosDifalIgnorados);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosDifalDuplicados);
end;

procedure TGerarTesteFcp.SetarTotaisDoProcessamentoDoDifalFcp;
begin
  frmModulo.Registros(FQuantidadeRegistro);
  frmModulo.RegistrosProcessados(FQtdeRegistrosDifalFcpProcessados);
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosDifalFcpAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosDifalFcpErro);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosDifalFcpIgnorados);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosDifalFcpDuplicados);
end;

procedure TGerarTesteFcp.SetarTotaisDoProcessamentoDoFcp;
begin
  frmModulo.Registros(FQuantidadeRegistro);
  frmModulo.RegistrosProcessados(FQtdeRegistrosFcpProcessados);
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosFcpAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosFcpErro);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosFcpIgnorados);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosFcpDuplicados);
end;

procedure TGerarTesteFcp.SetarTotaisDoProcessamentoFinal;
begin
  frmModulo.RegistrosProcessados(FProcessados);
  frmModulo.Registros(FQuantidadeRegistro * 3);
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosFcpAcerto + FQtdeRegistrosDifalFcpAcerto + FQtdeRegistrosDifalAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosFcpErro + FQtdeRegistrosDifalFcpErro + FQtdeRegistrosDifalErro);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosFcpIgnorados + FQtdeRegistrosDifalFcpIgnorados+ FQtdeRegistrosDifalIgnorados);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosFcpDuplicados + FQtdeRegistrosDifalFcpDuplicados + FQtdeRegistrosDifalDuplicados);
end;

procedure TGerarTesteFcp.TotalizarRegistrosProcessamentoDifal;
begin
  FQtdeRegistrosDifalAcerto     := FQtdeRegistrosDifalAcerto     + frmModulo.RegistrosProcessadosAcerto;
  FQtdeRegistrosDifalErro       := FQtdeRegistrosDifalErro       + frmModulo.RegistrosProcessadosErro;
  FQtdeRegistrosDifalDuplicados := FQtdeRegistrosDifalDuplicados + frmModulo.RegistrosProcessadosDuplicados;
  FQtdeRegistrosDifalIgnorados  := FQtdeRegistrosDifalIgnorados  + frmModulo.RegistrosProcessadosIgnorados;
end;

procedure TGerarTesteFcp.TotalizarRegistrosProcessamentoDifalFcp;
begin
  FQtdeRegistrosDifalFcpAcerto     := FQtdeRegistrosDifalFcpAcerto     + frmModulo.RegistrosProcessadosAcerto;
  FQtdeRegistrosDifalFcpErro       := FQtdeRegistrosDifalFcpErro       + frmModulo.RegistrosProcessadosErro;
  FQtdeRegistrosDifalFcpDuplicados := FQtdeRegistrosDifalFcpDuplicados + frmModulo.RegistrosProcessadosDuplicados;
  FQtdeRegistrosDifalFcpIgnorados  := FQtdeRegistrosDifalFcpIgnorados  + frmModulo.RegistrosProcessadosIgnorados;
end;

procedure TGerarTesteFcp.TotalizarRegistrosProcessamentoFcp;
begin
  FQtdeRegistrosFcpAcerto     := FQtdeRegistrosFcpAcerto     + frmModulo.RegistrosProcessadosAcerto;
  FQtdeRegistrosFcpErro       := FQtdeRegistrosFcpErro       + frmModulo.RegistrosProcessadosErro;
  FQtdeRegistrosFcpDuplicados := FQtdeRegistrosFcpDuplicados + frmModulo.RegistrosProcessadosDuplicados;
  FQtdeRegistrosFcpIgnorados  := FQtdeRegistrosFcpIgnorados  + frmModulo.RegistrosProcessadosIgnorados;
end;

procedure TGerarTesteFcp.TotalizarRegistrosProcessamentoGeral;
begin
  frmModulo.RegistrosProcessados(FQtdeRegistrosFcpProcessados + FQtdeRegistrosDifalFcpProcessados + FQtdeRegistrosDifalProcessados );
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosFcpAcerto + FQtdeRegistrosDifalFcpAcerto + FQtdeRegistrosDifalAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosFcpErro + FQtdeRegistrosDifalFcpErro + FQtdeRegistrosDifalErro);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosFcpDuplicados + FQtdeRegistrosDifalFcpDuplicados + FQtdeRegistrosDifalDuplicados);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosFcpIgnorados + FQtdeRegistrosDifalFcpIgnorados + FQtdeRegistrosDifalIgnorados );
end;

procedure TGerarTesteFcp.ZerarRegistrosDoProcessamento;
begin
  frmModulo.RegistrosProcessadosAcerto(0);
  frmModulo.RegistrosProcessadosErro(0);
  frmModulo.RegistrosProcessadosDuplicados(0);
  frmModulo.RegistrosProcessadosIgnorados(0);
end;

end.
