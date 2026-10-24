unit untTObtemRomaneioIntegFusion;

interface

uses
  Data.DB,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  untFuncoesGenerica,
{$ELSE }
  Uni,
  CRAccess,
  untUtilMonitor,
//  untLegenda,
  Vcl.ExtCtrls,
  UniClientDataSet,
  untFuncoesSimples,
{$ENDIF LINUX}
  System.Generics.Collections,
  System.DateUtils;

const
  spIdMonitorRomaneioIntegFusion           = 'MONITOR_ROMANEIO_INTEG_FUSION_%s';
  spIdInactivityMonitorRomaneioIntegFusion = 'TESTE_INATIVIDADE_ROMANEIO_INTEG_FUSION_%s';
  spRomaneioIntegMonitorExeName            = 'RomaneioIntegFusion.exe';
  spTimeLimitMonitorRomaneioIntegFusion    = 30;
  spAttemptsLockMonitorRomaneioIntegFusion = 30;

  sqlPedidoOld                             = 'SELECT F.AUTOINCREM AUTINC, ' +
                                             '  FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_CODCLI, FGO_NOMCON, ' +
                                             '  FGO_DTAENT, FGO_HORENT, FGO_CONPAG, FGO_ESTCON, FGO_TELCON, ' +
                                             '  FGO_ENDCON, FGO_BAICON, FGO_CEPCON, FGO_CIDCON, FGO_CGCCPF, ' +

                                             '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                             '     FGO_ENDCON, ' +
                                             '     TR.TRA_ENDERE) AS ENDENT,  ' +

                                             '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                             '     FGO_CEPCON, ' +
                                             '     TR.TRA_C_E_P_ ) AS CEPENT, ' +

                                             '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                             '     FGO_BAICON, ' +
                                             '     TR.TRA_BAIRRO) AS BAIENT, ' +

                                             '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                             '     FGO_CIDCON, ' +
                                             '     CTR.CID_NOMCID) AS CIDENT, ' +

                                             '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                             '     CLI_REFENT, ' +
                                             '     "") AS REFENT, ' +

                                             '  FGO_CGCCON, FGO_IESCON, FGO_R_GCON, FGO_ROMIMP, FGO_VLRCON, ' +
                                             '  FGO_BASSIM, FGO_BASIPI, FGO_ALQIPI, FGO_TOTIPI, FGO_BASICM, ' +
                                             '  FGO_ALQICM, FGO_TOTICM, FGO_TOTRET, FGO_ALQRET, FGO_BASRET, ' +
                                             '  FGO_DESESP, FGO_TOTCUS, FGO_TOTMED, FGO_TIPFRE, FGO_TOTFRE, ' +
                                             '  FGO_PESBRU, FGO_PESLIQ, FGO_VOLUME, FGO_ESPECI, FGO_MARCA_, ' +
                                             '  FGO_MEN001, FGO_MEN002, FGO_TIPFAT, FGO_NUMFAT, FGO_DTAFAT, ' +
                                             '  FGO_VENFAT, FGO_CNDFAT, FGO_VALFAT, FGO_VPAR01, FGO_VPAR02, ' +
                                             '  FGO_VPAR03, FGO_VPAR04, FGO_VPAR05, FGO_VPAR06, FGO_VPAR07, ' +
                                             '  FGO_VPAR08, FGO_VPAR09, FGO_VPAR10, FGO_VPAR11, FGO_VPAR12, ' +
                                             '  FGO_SERIE_, "N" AS FGO_NOTESP, 0 AS FGO_CLAFIS, FGO_PORDES, ' +
                                             '  FGO_CODDIG, FGO_CODCND, FGO_CODFPG, FGO_TOTPRO, FGO_CODVEN, ' +
                                             '  FGO_ESTADO, FGO_CODTRA, FGO_NUMROM ' +
                                             'FROM FATGOR F ' +
                                             'INNER JOIN CADCLI C ON F.FGO_CODCLI = C.CLI_CODCLI ' +
                                             'INNER JOIN EXTGOR E ON F.AUTOINCREM = FGO_SEQFGO ' +
                                             'INNER JOIN FATDOR ON F.AUTOINCREM = FDO_SEQGER ' +
                                             'LEFT JOIN CADTRA TR ON E.FGO_TRARDP = TR.TRA_CODTRA AND TR.TRA_INTFUS = "S" ' +
                                             'LEFT JOIN CADCID CTR ON TR.TRA_CODCID = CTR.CID_CODCID ' +
                                             'WHERE F.AUTOINCREM = :AUTINC ' +
                                             'GROUP BY F.AUTOINCREM ';

  sqlPedido                                = 'SELECT F.AUTOINCREM AUTINC, ' +
                                             '  FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_CODCLI, FGO_NOMCON, ' +
                                             '  FGO_DTAENT, FGO_HORENT, FGO_CONPAG, FGO_ESTCON, FGO_TELCON, ' +
                                             '  FGO_ENDCON, FGO_BAICON, FGO_CEPCON, FGO_CIDCON, FGO_CGCCPF, ' +

                                             '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                             '     FGO_ENDCON, ' +
                                             '     TR.TRA_ENDERE) AS ENDENT,  ' +

                                             '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                             '     FGO_CEPCON, ' +
                                             '     TR.TRA_C_E_P_ ) AS CEPENT, ' +

                                             '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                             '     FGO_BAICON, ' +
                                             '     TR.TRA_BAIRRO) AS BAIENT, ' +

                                             '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                             '     FGO_CIDCON, ' +
                                             '     CTR.CID_NOMCID) AS CIDENT, ' +

                                             '  IF(TR.TRA_CODTRA IS NULL,  ' +
                                             '     CLI_REFENT, ' +
                                             '     "") AS REFENT, ' +

                                             '  FGO_CGCCON, FGO_IESCON, FGO_R_GCON, FGO_ROMIMP, FGO_VLRCON, ' +
                                             '  FGO_BASSIM, FGO_BASIPI, FGO_ALQIPI, FGO_TOTIPI, FGO_BASICM, ' +
                                             '  FGO_ALQICM, FGO_TOTICM, FGO_TOTRET, FGO_ALQRET, FGO_BASRET, ' +
                                             '  FGO_DESESP, FGO_TOTCUS, FGO_TOTMED, FGO_TIPFRE, FGO_TOTFRE, ' +
                                             '  FGO_PESBRU, FGO_PESLIQ, FGO_VOLUME, FGO_ESPECI, FGO_MARCA_, ' +
                                             '  FGO_MEN001, FGO_MEN002, FGO_TIPFAT, FGO_NUMFAT, FGO_DTAFAT, ' +
                                             '  FGO_VENFAT, FGO_CNDFAT, FGO_VALFAT, FGO_VPAR01, FGO_VPAR02, ' +
                                             '  FGO_VPAR03, FGO_VPAR04, FGO_VPAR05, FGO_VPAR06, FGO_VPAR07, ' +
                                             '  FGO_VPAR08, FGO_VPAR09, FGO_VPAR10, FGO_VPAR11, FGO_VPAR12, ' +
                                             '  FGO_SERIE_, "N" AS FGO_NOTESP, 0 AS FGO_CLAFIS, FGO_PORDES, ' +
                                             '  FGO_CODDIG, FGO_CODCND, FGO_CODFPG, FGO_TOTPRO, FGO_CODVEN, ' +
                                             '  FGO_ESTADO, FGO_CODTRA, FGO_NUMROM ' +
                                             'FROM FATGOR F ' +
                                             'INNER JOIN CADCLI C ON F.FGO_CODCLI = C.CLI_CODCLI ' +
                                             'INNER JOIN EXTGOR E ON F.AUTOINCREM = FGO_SEQFGO ' +
                                             'INNER JOIN FATDOR ON F.AUTOINCREM = FDO_SEQGER ' +
                                             'LEFT JOIN CADTRA TR ON E.FGO_TRARDP = TR.TRA_CODTRA AND TR.TRA_INTFUS = "S" ' +
                                             'LEFT JOIN CADCID CTR ON TR.TRA_CODCID = CTR.CID_CODCID ' +
                                             'WHERE FGO_NUMDOC = :NUMDOC ' +
                                             '  AND FGO_ESPDOC = :ESPDOC ' +
                                             '  AND FGO_CODEMP = :CODEMP ' +
                                             'GROUP BY F.AUTOINCREM ';

  sqlItensPedido                           = 'SELECT F.AUTOINCREM AUTINC, F.*, E.FDO_PESLIQ, I.ITE_EMBALA /*<<REFORMA>>*/ ' +
                                             'FROM FATDOR F ' +
                                             'INNER JOIN CADITE I ON F.FDO_CODITE = I.ITE_CODITE ' +
                                             'LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = F.AUTOINCREM ' +
                                             'WHERE FDO_SEQGER = :SEQGER ';

  sqlAtualizaIntFus                        = 'UPDATE EXTGOR ' +
                                             'SET FGO_INTFUS = :INTFUS ' +
                                             'WHERE FGO_SEQFGO = :SEQFGO ';

  sqlAtualizaQtdRom                        = 'UPDATE FATDOR ' +
                                             'SET FDO_QTDROM = FDO_QTDITE ' +
                                             'WHERE FDO_SEQGER = :SEQFGO ';

  sqlAtualizaFatGor                        = 'UPDATE FATGOR ' +
                                             'SET FGO_VALROM = FGO_VLRCON, ' +
                                             'FGO_DTAROM = :DTAROM, ' +
                                             'FGO_HORROM = :HORROM, ' +
                                             'FGO_OPEROM = :OPEROM, ' +
                                             'FGO_NUMROM = :NUMROM, ' +
                                             'FGO_EMPROM = :EMPROM, ' +
                                             'FGO_PRVIMP = "N" ' +
                                             'WHERE AUTOINCREM = :SEQFGO ';

type
  TObtemRomaneioIntegFusion = class sealed(TInterfacedObject,
    {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX})
  private
    FFusTra: String;
    class var FLastProcessamento: TDateTime;
    function fGravarRomDet(ASeqFGO, ANumRom, ASeqGer: String): Boolean;
    procedure pAtualizaPedido(ASeqFGO, ANumRom: String; ADataRom: TDateTime; AHoraRom: TTime);
  protected
    constructor Create;
  public
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute: TResultExecute;

    destructor Destroy; Override;

    class function New:
      {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX}; overload;
  end;

implementation

uses
  untFusionIntegWS, untFusionRomaneio, untGravaRomaneio, untTypesSistema,
  untAtualizaOcorrenciasCRM, untTypesCRM, untTSituacaoPedidoVenda;

{ TObtemRomaneioIntegFusion }

constructor TObtemRomaneioIntegFusion.Create;
begin
  FFusTra := fCfgSis('FUSTRA', varString);
end;

destructor TObtemRomaneioIntegFusion.Destroy;
begin

  inherited;
end;

procedure TObtemRomaneioIntegFusion.pAtualizaPedido(ASeqFGO, ANumRom: String; ADataRom: TDateTime; AHoraRom: TTime);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQry := fCriaQuery();

  try
    LQry.SQL.Add(sqlAtualizaQtdRom);
    LQry.ParamByName('SEQFGO').AsString := ASeqFGO;
    LQry.ExecSQL();

    LQry.Close();
    LQry.SQL.Clear();
    LQry.SQL.Add(sqlAtualizaIntFus);
    LQry.ParamByName('INTFUS').AsString := 'R';
    LQry.ParamByName('SEQFGO').AsString := ASeqFGO;
    LQry.ExecSQL();

    LQry.Close();
    LQry.SQL.Clear();
    LQry.SQL.Add(sqlAtualizaFatGor);
    LQry.ParamByName('DTAROM').AsDateTime := ADataRom;
    LQry.ParamByName('HORROM').AsDateTime := AHoraRom;
    LQry.ParamByName('OPEROM').AsString   := strLoginUsuarioLogado;
    LQry.ParamByName('NUMROM').AsString   := ANumRom;
    LQry.ParamByName('EMPROM').AsString   := VS_strCodEmp;
    LQry.ParamByName('SEQFGO').AsString   := ASeqFGO;
    LQry.ExecSQL();
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

function TObtemRomaneioIntegFusion.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

function TObtemRomaneioIntegFusion.fGravarRomDet(ASeqFGO, ANumRom, ASeqGer: String): Boolean;
var
  LQryItensPed: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LVolume: Double;
begin
  Result := True;
  LQryItensPed := fCriaQuery();

  try
    LQryItensPed.SQL.Add(sqlItensPedido.Replace('/*<<REFORMA>>*/', ', ' + fSqlValoresReformaTributariaRomaneio('FATDOR', 'F')));

    LQryItensPed.Close();
    LQryItensPed.ParamByName('SEQGER').AsString := ASeqFGO;
    LQryItensPed.Open();

    while not LQryItensPed.Eof do
    begin
      LVolume := fCalcVolumes(LQryItensPed.FieldByName('FDO_CODITE').AsString,
                              LQryItensPed.FieldByName('FDO_QTDITE').AsFloat,
                              LQryItensPed.FieldByName('ITE_EMBALA').AsFloat);

      Result := fGravaRomDet(ANumRom,                                   // Romaneio
                   ASeqGer,                                   // Sequencial do Arquivo Geral
                   LQryItensPed.FieldByName('FDO_NUMDOC').AsString,   // Numero do Documento
                   LQryItensPed.FieldByName('FDO_ESPDOC').AsString,   // Espécie
                   LQryItensPed.FieldByName('FDO_CODEMP').AsString,   // Empresa
                   LQryItensPed.FieldByName('FDO_CODITE').AsString,   // Cód. Item
                   LQryItensPed.FieldByName('FDO_CODVEN').AsString,   // Vendedor
                   LQryItensPed.FieldByName('FDO_CODDIV').AsString,   // Código Diversos
                   LQryItensPed.FieldByName('FDO_CODMAR').AsString,   // Código da Marca
                   '',                                          // Fornecedor
                   LQryItensPed.FieldByName('FDO_CODCLI').AsString,   // Cliente
                   LQryItensPed.FieldByName('FDO_DTAENT').AsDateTime, // Data da Entrada
                   LQryItensPed.FieldByName('FDO_HORENT').AsDateTime, // Hora da Entrada
                   0,                                           // Data do Documento
                   LQryItensPed.FieldByName('FDO_CONPAG').AsString,   // Condição de Pagamento
                   'C',                                         // Tipo: (C)liente / (F) Fornecedor
                   '',                                          // Estado do Fornecedor
                   LQryItensPed.FieldByName('FDO_DESCRI').AsString,   // Descrição do Item
                   LQryItensPed.FieldByName('FDO_REFERE').AsString,   // Referência do Item
                   LQryItensPed.FieldByName('FDO_UNIDAD').AsString,   // Cód. Unidade
                   LQryItensPed.FieldByName('FDO_FORITE').AsString,   // Fornecedor Item
                   LQryItensPed.FieldByName('FDO_QTDITE').AsFloat,    // Quantidade do Item
                   LQryItensPed.FieldByName('FDO_UNITAR').AsFloat,    // Valor Unitario
                   LQryItensPed.FieldByName('FDO_UNIORI').AsFloat,    // Valor Unitário Original
                   fFormataFloat(LQryItensPed.FieldByName('FDO_UNITAR').AsFloat * LQryItensPed.FieldByName('FDO_QTDITE').AsFloat, 2), // Total do Item
                   LQryItensPed.FieldByName('FDO_VLRCON').AsFloat,    // Valor Contábil do Item
                   LQryItensPed.FieldByName('FDO_TOTCUS').AsFloat,    // Valor Total de Custo
                   LQryItensPed.FieldByName('FDO_TOTMED').AsFloat,    // Valor Total Medio
                   LQryItensPed.FieldByName('FDO_DESCON').AsFloat,    // % Desconto do Item
                   LQryItensPed.FieldByName('FDO_TOTFRE').AsFloat,    // Valor do Frete
                   LQryItensPed.FieldByName('FDO_DESESP').AsFloat,    // Valor do Desconto Especial
                   LQryItensPed.FieldByName('FDO_CODREP').AsString,   // Código do Representante
                   LQryItensPed.FieldByName('FDO_PERCOM').AsFloat,    // Percentual de Comissão do Vendedor
                   LQryItensPed.FieldByName('FDO_TOTCOM').AsFloat,    // Total de Comissão do Vendedor
                   LQryItensPed.FieldByName('FDO_CLAFIS').AsString,   // Classificação Fiscal
                   LQryItensPed.FieldByName('FDO_CODFIS').AsString,   // Código Fiscal
                   LQryItensPed.FieldByName('FDO_VALIPI').AsFloat,    // Valor IPI
                   LQryItensPed.FieldByName('FDO_ALQIPI').AsFloat,    // Aliquota IPI
                   LQryItensPed.FieldByName('FDO_BASIPI').AsFloat,    // Base IPI
                   LQryItensPed.FieldByName('FDO_VALICM').AsFloat,    // Valor de ICMS
                   LQryItensPed.FieldByName('FDO_ALQICM').AsFloat,    // Aliquota de ICMS
                   LQryItensPed.FieldByName('FDO_BASICM').AsFloat,    // Base de ICMS
                   LQryItensPed.FieldByName('FDO_VALRET').AsFloat,    // Valor de Substituição
                   LQryItensPed.FieldByName('FDO_ALQRET').AsFloat,    // Aliquota de Substituição
                   LQryItensPed.FieldByName('FDO_BASRET').AsFloat,    // Base de Substituição
                   LQryItensPed.FieldByName('FDO_TOTPES').AsFloat,                                   // Total de Peso
                   LQryItensPed.FieldByName('FDO_PERBAS').AsFloat,    // Percentual de Base de ICMS
                   LQryItensPed.FieldByName('FDO_PERRED').AsFloat,    // Percentual de Redução de Base
                   False,  // Indica se ja esta Faturado
                   LQryItensPed.FieldByName('FDO_TIPFAT').AsString,   // Tipo de Faturamento
                   LQryItensPed.FieldByName('FDO_NUMFAT').AsString,   // Número do Faturamento
                   LQryItensPed.FieldByName('FDO_DTAFAT').AsDateTime, // Data do Faturamento
                   LQryItensPed.FieldByName('FDO_VENFAT').AsString,   // Vendedor do Faturamento
                   LQryItensPed.FieldByName('FDO_CNDFAT').AsString,   // Condição de Pagamento Faturamento
                   LQryItensPed.FieldByName('FDO_VALFAT').AsFloat,    // Valor do Faturamento
                   LQryItensPed.FieldByName('FDO_IDEPRO').AsString,   // Identificação Produto ( Normal / Outros )
                   LQryItensPed.FieldByName('FDO_INCPIS').AsString,   // Indice se incide Pis
                   LQryItensPed.FieldByName('FDO_SERIE_').AsString,   // Série
                   LQryItensPed.FieldByName('FDO_DESACE').AsFloat,    // Valor de Despesa Acessória
                   '',                                          // Nota Especial
                   '',                                          // Documento da Devolução
                   '',                                          // Espécie da Devolução
                   '',                                          // Empresa da Devolução
                   LQryItensPed.FieldByName('FDO_ITECHA').AsString,   // Item de Chamada (TINTA DE MAQUINA)
                   LQryItensPed.FieldByName('FDO_ITETIN').AsString,   // Item da Tinta (TINTA DE MAQUINA)
                   LQryItensPed.FieldByName('FDO_DESCOR').AsString,   // Descrição da Cor (TINTA DE MAQUINA)
                   LQryItensPed.FieldByName('FDO_TIPEMB').AsString,   // Tipo de Embalagem (TINTA DE MAQUINA)
                   LQryItensPed.FieldByName('FDO_QTDEMB').AsFloat,    // Quantidade de Embalagem (TINTA DE MAQUINA)
                   LQryItensPed.FieldByName('FDO_PREEMB').AsFloat,    // Preço da Embalagem (TINTA DE MAQUINA)
                   LQryItensPed.FieldByName('FDO_TIPPRE').AsString,   // Tipo de Preço (TINTA DE MAQUINA)
                   LQryItensPed.FieldByName('FDO_PRVTIN').AsFloat,    // Preço de Venda da Tinta (TINTA DE MAQUINA)
                   LQryItensPed.FieldByName('FDO_PRCTIN').AsFloat,    // Preço de Compra da Tinta (TINTA DE MAQUINA)
                   LQryItensPed.FieldByName('FDO_FATTIN').AsFloat,    // Fator da Tinta (TINTA DE MAQUINA)
                   LQryItensPed.FieldByName('FDO_PROEMB').AsString,   // Produto Embalagem (TINTA DE MAQUINA)
                   LQryItensPed.FieldByName('FDO_CODDIG').AsString,   // Código do Digitador
                   LQryItensPed.FieldByName('FDO_CODCND').AsString,   // Codigo da Condição
                   LQryItensPed.FieldByName('FDO_CODFPG').AsString,   // Forma de Pagamento
                   LQryItensPed.FieldByName('FDO_QTDITE').AsFloat,                                   // Quantidade de Baixa ********
                   '', //cdsTmp.FieldByName('DET_INFITE').AsString,   // Informações do item ********
                   'N', //cdsTmp.FieldByName('DET_SEPIMP').AsString,   // Separacao Impressa (S/N)
                   LQryItensPed.FieldByName('AUTINC').AsString,   // Autoincremento do fatdor *******
     {VERIFICAR}   LQryItensPed.FieldByName('FDO_NUMLOT').AsString,                                   // NUMERO DO LOTE
                   LQryItensPed.FieldByName('FDO_PESLIQ').AsFloat,                                   // Peso Liquido
                   LVolume,                                   // Volume do item
                   LQryItensPed.FieldByName('REF_CBSVAL').AsFloat,    // Valor CBS
                   LQryItensPed.FieldByName('REF_VALIBS').AsFloat,    // Valor IBS
                   LQryItensPed.FieldByName('REF_SELVAL').AsFloat,    // Valor IS
                   '');                                         // Empresa Origem

      LQryItensPed.Next;
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQryItensPed);
{$ENDIF LINUX}
  end;
end;

class function TObtemRomaneioIntegFusion.New:
      {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
begin
  Result := TObtemRomaneioIntegFusion.Create;
end;

procedure TObtemRomaneioIntegFusion.pExecute;
var
  LQryPed: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LOpenedTransaction: Boolean;
  LarrRomaneio: TArray<TFusionRomaneio>;
  LobjRomaneio: TFusionRomaneio;
  LobjEntregas: TFusionEntregas;
  LRetorno: Boolean;
  LNumRom: String;
  LAutInc: String;
  LEmpLogada: String;
  arrDuplicataCND: TarrDuplicata;
  LDataRom: TDateTime;
  LHoraRom: TTime;
  arrAjudantes: TArray<String>;
begin
  LQryPed := fCriaQuery;

  try
    LOpenedTransaction := fInTransaction();

    try
      LEmpLogada := VS_strCodEmp;
      if fCfgSis('FUSIEC', varBoolean) then
        TFusionIntegWS.New.fGetRomaneioFilial(VS_strCodEmp).pCarregaRetorno(LarrRomaneio)
      else
        TFusionIntegWS.New.fGetRomaneio.pCarregaRetorno(LarrRomaneio);

      if (Length(LarrRomaneio) = 0) then
        Exit;

      for LobjRomaneio in LarrRomaneio do
      begin
        if LobjRomaneio.TIPOINT = 'T10_ROMANEIO_FINALIZADO' then // Não vamos processar esse retorno
          Continue;

        if not fCfgSis('FUSIEC', varBoolean) then
        begin
          {$IFDEF LINUX}
                  pSetaEmpresaLogada(LobjRomaneio.T43CodigoFilialErp);
          {$ELSE}
            {$IFDEF FUSION}
                  VS_strCodEmp := LobjRomaneio.T43CodigoFilialErp;
                  pIniciarVariaveis;
            {$ELSE}
                  pSetaEmpresaLogada(LobjRomaneio.T43CodigoFilialErp);
            {$ENDIF FUSION}
          {$ENDIF LINUX}

        end;

        LNumRom := '';

        if (not LOpenedTransaction) then
          fStartTransaction();

        LRetorno := True;

        if (not fEmptyStr(LobjRomaneio.T10CargaFormadaErp)) and (LobjRomaneio.T10CargaFormadaErp <> 'null') then
        begin
          LNumRom := LobjRomaneio.T10CargaFormadaErp;
          pDeletaRomaneio(LobjRomaneio.T10CargaFormadaErp, False);
        end;

        for LobjEntregas in LobjRomaneio.ENTREGAS do
        begin
          LQryPed.Close;
          LQryPed.SQL.Clear;

          if Length(LobjEntregas.T32PedidoOriginal) = 20 then
          begin
            LQryPed.SQL.Add(sqlPedidoOld);
            LQryPed.ParamByName('AUTINC').AsString := LobjEntregas.T32PedidoOriginal;
          end
          else
          begin
            LQryPed.SQL.Add(sqlPedido);
            LQryPed.ParamByName('NUMDOC').AsString := Trim(Copy(LobjEntregas.T32PedidoOriginal, 0, 12));
            LQryPed.ParamByName('ESPDOC').AsString := 'PD';
            LQryPed.ParamByName('CODEMP').AsString := Trim(Copy(LobjEntregas.T32PedidoOriginal, 15, 3));
          end;

          LQryPed.Open;

          if LQryPed.IsEmpty then
            Continue;

          pCarregaDuplicatasCND(1, LQryPed.FieldByName('AUTINC').AsString, arrDuplicataCND);

          LDataRom := VS_Date;
          LHoraRom := fTime();

          if (not fEmptyStr(LobjRomaneio.T10DataSaida)) then
          begin
            LDataRom := StrToDateTime(Copy(LobjRomaneio.T10DataSaida, 9,2) + '/' +
                                      Copy(LobjRomaneio.T10DataSaida, 6,2) + '/' +
                                      Copy(LobjRomaneio.T10DataSaida, 1,4));
            LHoraRom := StrToTime(Copy(LobjRomaneio.T10DataSaida, 12,8));
          end;

          arrAjudantes := LobjRomaneio.Codajudantes.Split([',']);
          if Length(arrAjudantes) < 4 then
            SetLength(arrAjudantes, Length(arrAjudantes) + (4 - Length(arrAjudantes)));

          LRetorno := LRetorno and
            fGravaRomGer(LNumRom,   // Número do Romaneio (Referencia)
                         LAutInc,   // Auto Incremento (Referência)
                         LQryPed.FieldByName('FGO_NUMDOC').AsString,   // Documento
                         LQryPed.FieldByName('FGO_ESPDOC').AsString,   // Espécie
                         LQryPed.FieldByName('FGO_CODEMP').AsString,   // Empresa
                         IIF(fEmptyStr(FFusTra), LQryPed.FieldByName('FGO_CODTRA').AsString, FFusTra),   // Transportadora
                         LQryPed.FieldByName('FGO_CODVEN').AsString,   // Vendedor
                         '',   // Fornecedor
                         LQryPed.FieldByName('FGO_CODCLI').AsString,   // Cliente
                         'C',   // Tipo (Cliente / Fornecedor)
                         LQryPed.FieldByName('FGO_DTAENT').AsDateTime,   // Data de Entrada
                         LQryPed.FieldByName('FGO_HORENT').AsDateTime,   // Hora de Entrada
                         LQryPed.FieldByName('FGO_DTAENT').AsDateTime,   // Data do Documento
                         LQryPed.FieldByName('FGO_CONPAG').AsString,   // Condição de Pagamento
                         LQryPed.FieldByName('FGO_ESTADO').AsString,   // Estado
                         LQryPed.FieldByName('FGO_NOMCON').AsString,   // Nome Cliente Consumidor
                         LQryPed.FieldByName('FGO_ENDCON').AsString,   // Endereço Cliente Consumidor
                         LQryPed.FieldByName('FGO_BAICON').AsString,   // Bairro Cliente Consumidor
                         LQryPed.FieldByName('FGO_CEPCON').AsString,   // CEP Cliente Consumidor
                         LQryPed.FieldByName('FGO_CIDCON').AsString,   // Cidade Cliente Consumidor
                         LQryPed.FieldByName('FGO_ESTCON').AsString,   // Estado Cliente Consumidor
                         LQryPed.FieldByName('FGO_TELCON').AsString,   // Telefone Cliente Consumidor
                         LQryPed.FieldByName('FGO_CGCCPF').AsString,   // CGC/CPF Cliente Consumidor
                         LQryPed.FieldByName('FGO_CGCCON').AsString,   // CNPJ Cliente Consumidor
                         LQryPed.FieldByName('FGO_IESCON').AsString,   // Inscrição Estadual Cliente Consumidor
                         LQryPed.FieldByName('FGO_R_GCON').AsString,   // RG Cliente Consumidor
                         'N',   // Romaneio já impresso?
                         LQryPed.FieldByName('FGO_BASSIM').AsFloat,   // Base Simples Paulista
                         LQryPed.FieldByName('FGO_BASIPI').AsFloat,   // Base IPI
                         LQryPed.FieldByName('FGO_ALQIPI').AsFloat,   // Aliquota IPI
                         LQryPed.FieldByName('FGO_TOTIPI').AsFloat,   // Total de IPI
                         LQryPed.FieldByName('FGO_BASICM').AsFloat,   // Base de ICMS
                         LQryPed.FieldByName('FGO_ALQICM').AsFloat,   // Aliquota de ICMS
                         LQryPed.FieldByName('FGO_TOTICM').AsFloat,   // Total de ICMS
                         LQryPed.FieldByName('FGO_TOTRET').AsFloat,   // Total Retido
                         LQryPed.FieldByName('FGO_ALQRET').AsFloat,   // Aliquota Retido
                         LQryPed.FieldByName('FGO_BASRET').AsFloat,   // Base Retido
                         LQryPed.FieldByName('FGO_DESESP').AsFloat,   // Desconto Especial
                         {*}LQryPed.FieldByName('FGO_VLRCON').AsFloat,   // Valor Contabil
                         {*}LQryPed.FieldByName('FGO_TOTPRO').AsFloat,   // Total dos Produtos
                         LQryPed.FieldByName('FGO_TOTCUS').AsFloat,   // Total de Custo
                         LQryPed.FieldByName('FGO_TOTMED').AsFloat,   // Total Médio
                         LQryPed.FieldByName('FGO_TIPFRE').AsString,   // Tipo de Frete
                         LQryPed.FieldByName('FGO_TOTFRE').AsFloat,   // Total do Frete
                         LQryPed.FieldByName('FGO_PESBRU').AsFloat,   // Peso Bruto
                         LQryPed.FieldByName('FGO_PESLIQ').AsFloat,   // Peso Líquido
                         LQryPed.FieldByName('FGO_VOLUME').AsFloat,   // Volume
                         LQryPed.FieldByName('FGO_ESPECI').AsString,   // Espécie
                         LQryPed.FieldByName('FGO_MARCA_').AsString,   // Marca
                         LQryPed.FieldByName('FGO_MEN001').AsString,   // Mensagem 01
                         LQryPed.FieldByName('FGO_MEN002').AsString,   // Mensagem 02
                         False,       // Ja Faturado?
                         LQryPed.FieldByName('FGO_TIPFAT').AsString,   // Tipo de Faturamento
                         LQryPed.FieldByName('FGO_NUMFAT').AsString,   // Numero do Faturamento
                         LQryPed.FieldByName('FGO_DTAFAT').AsDateTime,   // Data do Faturamento
                         LQryPed.FieldByName('FGO_VENFAT').AsString,   // Vendedor do Faturamento
                         LQryPed.FieldByName('FGO_CNDFAT').AsString,   // Condição do Faturamento
                         LQryPed.FieldByName('FGO_VALFAT').AsFloat,   // Valor do Faturamento
                         LQryPed.FieldByName('FGO_VPAR01').AsFloat,   // Valor da Parcela 01
                         LQryPed.FieldByName('FGO_VPAR02').AsFloat,   // Valor da Parcela 02
                         LQryPed.FieldByName('FGO_VPAR03').AsFloat,   // Valor da Parcela 03
                         LQryPed.FieldByName('FGO_VPAR04').AsFloat,   // Valor da Parcela 04
                         LQryPed.FieldByName('FGO_VPAR05').AsFloat,   // Valor da Parcela 05
                         LQryPed.FieldByName('FGO_VPAR06').AsFloat,   // Valor da Parcela 06
                         LQryPed.FieldByName('FGO_VPAR07').AsFloat,   // Valor da Parcela 07
                         LQryPed.FieldByName('FGO_VPAR08').AsFloat,   // Valor da Parcela 08
                         LQryPed.FieldByName('FGO_VPAR09').AsFloat,   // Valor da Parcela 09
                         LQryPed.FieldByName('FGO_VPAR10').AsFloat,   // Valor da Parcela 10
                         LQryPed.FieldByName('FGO_VPAR11').AsFloat,   // Valor da Parcela 11
                         LQryPed.FieldByName('FGO_VPAR12').AsFloat,   // Valor da Parcela 12
                         arrDuplicataCND,
                         LQryPed.FieldByName('FGO_SERIE_').AsString,   // Série
                         LQryPed.FieldByName('FGO_NOTESP').AsString,   // Nota Especial
                         LQryPed.FieldByName('FGO_CLAFIS').AsString,   // Classificação Fiscal
                         LQryPed.FieldByName('FGO_PORDES').AsFloat,   //
                         LQryPed.FieldByName('FGO_CODDIG').AsString,   // Digitador
                         LQryPed.FieldByName('FGO_CODCND').AsString,   // Código da Condição de Pagamento
                         LQryPed.FieldByName('FGO_CODFPG').AsString,   // Código da Forma de Pagamento
                         fTiraCaracEspeciaisPonto(LobjRomaneio.Placa),   //Placa do veiculo
                         AnsiReplaceStr(AnsiReplaceStr(LobjRomaneio.T05CodigoErp, 'M', ''), 'A', ''),   // Motorista
                         AnsiReplaceStr(AnsiReplaceStr(arrAjudantes[0], 'M', ''), 'A', ''),   // Ajudante 1
                         AnsiReplaceStr(AnsiReplaceStr(arrAjudantes[1], 'M', ''), 'A', ''),   // Ajudante 2
                         AnsiReplaceStr(AnsiReplaceStr(arrAjudantes[2], 'M', ''), 'A', ''),   // Ajudante 3
                         AnsiReplaceStr(AnsiReplaceStr(arrAjudantes[3], 'M', ''), 'A', ''),   // Ajudante 4
                         LobjRomaneio.T10Obs,   // Observação do Fechamento Romaneio
                         '',   // Região
                         LDataRom,   // Data do Romaneio
                         LHoraRom,   // Hora do Romaneio
                         strLoginUsuarioLogado,  // Operador que realizou o romaneio
                         StrToInt(LobjEntregas.T12OrdemEntrega),//intOrdemI,   // Ordem de Impressao
                         LQryPed.FieldByName('FGO_TOTPRO').AsFloat,   // Valor original do
                         strLoginUsuarioLogado,   // Operador Solicitante
                         '', //strAutEnt,   // Ref de Endereco de Entrega
                         0, //fltVlrFre,
                         0, //fltVlrAdi,
                         0, //fltPerFre,
                         '', //strMsgExp,
                         '', //strPalet,
                         'A', //strStatus,
                         '', //strNumBox,
                         'FATGOR', //strNomTab,
                         'S', //strEntSai,
                         LQryPed.FieldByName('AUTINC').AsString,
                         '', //strMenExp,
                         '', //strMenEx2,
                         '', //strMenEx3,
                         '', //strMenEx4,
                         '', //strLocali,
                         fCfgSis('FUSTAE'), //strLibApp,
                         '', //strEvitar,
                         0, //fltDistan,
                         0, //fltTmpEnt,
                         LQryPed.FieldByName('ENDENT').AsString,
                         LQryPed.FieldByName('BAIENT').AsString,
                         LQryPed.FieldByName('CEPENT').AsString,
                         LQryPed.FieldByName('CIDENT').AsString,
                         LQryPed.FieldByName('REFENT').AsString,
                         '', //strFilial,
                         '', //strIniPar,
                         '', //IIF(strTipEnt = 'R', strCodFil, ''),
                         '', //strSeqTra,
                         '', //strAltEnd);
                         nil,
                         LobjEntregas.T32Latitude + ',' + LobjEntregas.T32Longitude,
                         0,
                         'S',
                         LobjRomaneio.T10Id);

          LRetorno := LRetorno and fGravarRomDet(LQryPed.FieldByName('AUTINC').AsString, LNumRom, LAutInc);

          if LRetorno then
          begin
            pAtualizaPedido(LQryPed.FieldByName('AUTINC').AsString, LNumRom, LDataRom, LHoraRom);

            TUpdateStatus.New(TParamStatus.New()
                          .NumDoc(LQryPed.FieldByName('FGO_NUMDOC').AsString)
                          .EspDoc(LQryPed.FieldByName('FGO_ESPDOC').AsString)
                          .CodEmp(LQryPed.FieldByName('FGO_CODEMP').AsString)).pExecute();

            if VS_strHabilitarCRM then
              TUpdateOccurrenceCRM.New()
                .NumDoc(LQryPed.FieldByName('FGO_NUMDOC').AsString)
                .EspDoc(LQryPed.FieldByName('FGO_ESPDOC').AsString)
                .CodEmp(LQryPed.FieldByName('FGO_CODEMP').AsString)
                .CodCli(LQryPed.FieldByName('FGO_CODCLI').AsString)
                .AcaFat(IIF((not fEmptyStr(LQryPed.FieldByName('FGO_CODCLI').AsString)), afcRomaneioAlteracao, afcRomaneioInclusao))
                .NumRom(LNumRom)
                .CodMot(LobjRomaneio.T05CodigoErp)
                .CodTra(IIF(fEmptyStr(FFusTra), LQryPed.FieldByName('FGO_CODTRA').AsString, FFusTra))
                .strNomFrm('[TObtemRomaneioIntegFusion.pExecute]')
                .pRun();
          end;
        end;

        if (not LOpenedTransaction) and LRetorno then
          fCommit()
        else if (not LRetorno) then
          fRollback();

        if LRetorno then
        begin
          if fCfgSis('FUSIEC', varBoolean) then
            TFusionIntegWS.New.fSetRomaneioImportadoFilial(LobjRomaneio.CODIGOINT, LNumRom, 'Carga Gerada', VS_strCodEmp)
          else
            TFusionIntegWS.New.fSetRomaneioImportado(LobjRomaneio.CODIGOINT, LNumRom, 'Carga Gerada', 'S');
        end
        else
        begin
          if fCfgSis('FUSIEC', varBoolean) then
            TFusionIntegWS.New.fSetRomaneioImportadoFilial(LobjRomaneio.CODIGOINT, '', 'Erro ao importar carga', VS_strCodEmp)
          else
            TFusionIntegWS.New.fSetRomaneioImportado(LobjRomaneio.CODIGOINT, '', 'Erro ao importar carga', 'N');
        end;
      end;
    except
      on E: Exception do
      begin
        if (not LOpenedTransaction) then
          fRollBack();
        raise;
      end;
    end;
  finally
{$IFDEF LINUX}
    pSetaEmpresaLogada(LEmpLogada);
{$ELSE}
  {$IFDEF FUSION}
    pIniciarVariaveis;
    VS_strCodEmp := LEmpLogada;
  {$ELSE}
    pSetaEmpresaLogada(LEmpLogada);
  {$ENDIF FUSION}
{$ENDIF LINUX}

    for LobjRomaneio in LarrRomaneio do
      LobjRomaneio.Free;

{$IFNDEF LINUX}
    FreeAndNil(LQryPed);
{$ENDIF LINUX}
  end;
end;

procedure TObtemRomaneioIntegFusion.pExecuteAll;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LTempoReprocessar: Integer;
begin
  if (not fCfgSis('FUSUSA', varBoolean)) then
    Exit;

  if (fEmptyStr(fCfgSis('FUSUSR', varString)) or fEmptyStr(fCfgSis('FUSSEN', varString))) then
    Exit;

  try
    LTempoReprocessar := fCfgSis('FUSINT', VarInteger);
  except
    LTempoReprocessar := 10;
  end;

  if MinutesBetween(VS_Date + fTime(True), FLastProcessamento) <= LTempoReprocessar then
    Exit;

  FLastProcessamento := VS_Date + fTime(True);
  LQry := fCriaQuery();

  try
    TObtemRomaneioIntegFusion.New.pExecute();
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

end.
