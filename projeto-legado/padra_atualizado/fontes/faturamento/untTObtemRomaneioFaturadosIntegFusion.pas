unit untTObtemRomaneioFaturadosIntegFusion;

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

  sqlPedido                                = 'SELECT G.AUTOINCREM AUTINC, ' +
                                             '  GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_CODCLI, GER_NOMCON, ' +
                                             '  GER_DTAENT, GER_HORENT, GER_CONPAG, GER_ENDCON, GER_BAICON, ' +
                                             '  GER_CEPCON, GER_CIDCON, GER_ESTCON, GER_TELCON, GER_CGCCPF, ' +

                                             '  IF(TR.TRA_CODTRA IS NULL,  '+
                                             '     GER_ENDCON, ' +
                                             '     TR.TRA_ENDERE) AS ENDENT,  '+

                                             '  IF(TR.TRA_CODTRA IS NULL,  '+
                                             '     GER_CEPCON, '+
                                             '     TR.TRA_C_E_P_ ) AS CEPENT, ' +

                                             '  IF(TR.TRA_CODTRA IS NULL,  '+
                                             '     GER_BAICON, '+
                                             '     TR.TRA_BAIRRO) AS BAIENT, ' +

                                             '  IF(TR.TRA_CODTRA IS NULL,  '+
                                             '     GER_CIDCON, '+
                                             '     CTR.CID_NOMCID) AS CIDENT, ' +

                                             '  IF(TR.TRA_CODTRA IS NULL,  '+
                                             '     CLI_REFENT, '+
                                             '     "") AS REFENT, ' +

                                             '  GER_CGCCON, GER_IESCON, GER_R_GCON, GER_ROMIMP, GER_VLRCON, ' +
                                             '  GER_BASSIM, GER_BASIPI, GER_ALQIPI, GER_TOTIPI, GER_BASICM, ' +
                                             '  GER_ALQICM, GER_TOTICM, GER_TOTRET, GER_ALQRET, GER_BASRET, ' +
                                             '  GER_DESESP, GER_TOTCUS, GER_TOTMED, GER_TIPFRE, GER_TOTFRE, ' +
                                             '  GER_PESBRU, GER_PESLIQ, GER_VOLUME, GER_ESPECI, GER_MARCA_, ' +
                                             '  GER_MEN001, GER_MEN002, GER_TIPFAT, GER_NUMFAT, GER_DTAFAT, ' +
                                             '  GER_VENFAT, GER_CNDFAT, GER_VALFAT, GER_VPAR01, GER_VPAR02, ' +
                                             '  GER_VPAR03, GER_VPAR04, GER_VPAR05, GER_VPAR06, GER_VPAR07, ' +
                                             '  GER_VPAR08, GER_VPAR09, GER_VPAR10, GER_VPAR11, GER_VPAR12, ' +
                                             '  GER_SERIE_, "N" AS GER_NOTESP, 0 AS GER_CLAFIS, GER_PORDES, ' +
                                             '  GER_CODDIG, GER_CODCND, GER_CODFPG, GER_TOTPRO, CLI_REFENT, ' +
                                             '  GER_CODVEN, GER_ESTADO, GER_CODTRA, GER_NUMROM ' +
                                             'FROM MOVGER G ' +
                                             'INNER JOIN CADCLI C ON G.GER_CODCLI = C.CLI_CODCLI ' +
                                             'INNER JOIN AUXMOV A ON G.AUTOINCREM = A.AUX_SEQGER ' +
                                             'INNER JOIN MOVDET D ON G.AUTOINCREM = D.DET_SEQGER ' +
                                             'LEFT JOIN CADTRA TR ON A.AUX_TRARDP = TR.TRA_CODTRA AND TR.TRA_INTFUS = "S" ' +
                                             'LEFT JOIN CADCID CTR ON TR.TRA_CODCID = CTR.CID_CODCID ' +
                                             'WHERE G.GER_NUMDOC = :NUMDOC ' +
                                             '  AND G.GER_ESPDOC = :ESPDOC ' +
                                             '  AND G.GER_CODEMP = :CODEMP ' +
                                             'GROUP BY G.AUTOINCREM ';

  sqlItensPedido                           = 'SELECT D.AUTOINCREM AUTINC, D.*, T.DET_PESLIQ, I.ITE_EMBALA /*<<REFORMA>>*/ ' +
                                             'FROM MOVDET D ' +
                                             'INNER JOIN CADITE I ON D.DET_CODITE = I.ITE_CODITE ' +
                                             'LEFT JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER ' +
                                             'WHERE D.DET_SEQGER = :SEQGER ';

  sqlAtualizaIntFus                        = 'UPDATE AUXMOV ' +
                                             'SET AUX_INTFUS = :INTFUS ' +
                                             'WHERE AUX_SEQGER = :SEQGER ';

  sqlAtualizaQtdRom                        = 'UPDATE MOVDET ' +
                                             'SET DET_QTDROM = DET_QTDITE ' +
                                             'WHERE DET_SEQGER = :SEQGER ';

  sqlAtualizaMovGer                        = 'UPDATE MOVGER ' +
                                             'SET GER_VALROM = GER_VLRCON, ' +
                                             'GER_DTAROM = :DTAROM, ' +
                                             'GER_HORROM = :HORROM, ' +
                                             'GER_OPEROM = :OPEROM, ' +
                                             'GER_NUMROM = :NUMROM, ' +
                                             'GER_EMPROM = :EMPROM, ' +
                                             'GER_PRVIMP = "N" ' +
                                             'WHERE AUTOINCREM = :AUTINC ';

type
  TObtemRomaneioFaturadosIntegFusion = class sealed(TInterfacedObject,
    {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX})
  private
    FFusTra: String;
    class var FLastProcessamento: TDateTime;
    function fGravarRomDet(AAutIncMovGer, ANumRom, ASeqGer: String): Boolean;
    procedure pAtualizaDocumento(ASeqGER, ANumRom: String; ADataRom: TDateTime; AHoraRom: TTime);
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

constructor TObtemRomaneioFaturadosIntegFusion.Create;
begin
  FFusTra := fCfgSis('FUSTRA', varString);
end;

destructor TObtemRomaneioFaturadosIntegFusion.Destroy;
begin

  inherited;
end;

procedure TObtemRomaneioFaturadosIntegFusion.pAtualizaDocumento(ASeqGER, ANumRom: String; ADataRom: TDateTime; AHoraRom: TTime);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQry := fCriaQuery();

  try
    LQry.SQL.Add(sqlAtualizaQtdRom);
    LQry.ParamByName('SEQGER').AsString := ASeqGER;
    LQry.ExecSQL();

    LQry.Close();
    LQry.SQL.Clear();
    LQry.SQL.Add(sqlAtualizaIntFus);
    LQry.ParamByName('INTFUS').AsString := 'R';
    LQry.ParamByName('SEQGER').AsString := ASeqGER;
    LQry.ExecSQL();

    LQry.Close();
    LQry.SQL.Clear();
    LQry.SQL.Add(sqlAtualizaMovGer);
    LQry.ParamByName('DTAROM').AsDateTime := ADataRom;
    LQry.ParamByName('HORROM').AsDateTime := AHoraRom;
    LQry.ParamByName('OPEROM').AsString   := strLoginUsuarioLogado;
    LQry.ParamByName('NUMROM').AsString   := ANumRom;
    LQry.ParamByName('EMPROM').AsString   := VS_strCodEmp;
    LQry.ParamByName('AUTINC').AsString   := ASeqGER;
    LQry.ExecSQL();
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

function TObtemRomaneioFaturadosIntegFusion.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

function TObtemRomaneioFaturadosIntegFusion.fGravarRomDet(AAutIncMovGer, ANumRom, ASeqGer: String): Boolean;
var
  LQryItensDoc: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LVolume: Double;
begin
  Result := True;
  LQryItensDoc := fCriaQuery();

  try
    LQryItensDoc.SQL.Add(sqlItensPedido.Replace('/*<<REFORMA>>*/', ', ' + fSqlValoresReformaTributariaRomaneio('MOVDET', 'D')));

    LQryItensDoc.Close();
    LQryItensDoc.ParamByName('SEQGER').AsString := AAutIncMovGer;
    LQryItensDoc.Open();

    while not LQryItensDoc.Eof do
    begin
      LVolume := fCalcVolumes(LQryItensDoc.FieldByName('DET_CODITE').AsString,
                              LQryItensDoc.FieldByName('DET_QTDITE').AsFloat,
                              LQryItensDoc.FieldByName('ITE_EMBALA').AsFloat);

      Result := fGravaRomDet(ANumRom,                                   // Romaneio
                   ASeqGer,                                   // Sequencial do Arquivo Geral
                   LQryItensDoc.FieldByName('DET_NUMDOC').AsString,   // Numero do Documento
                   LQryItensDoc.FieldByName('DET_ESPDOC').AsString,   // Espécie
                   LQryItensDoc.FieldByName('DET_CODEMP').AsString,   // Empresa
                   LQryItensDoc.FieldByName('DET_CODITE').AsString,   // Cód. Item
                   LQryItensDoc.FieldByName('DET_CODVEN').AsString,   // Vendedor
                   LQryItensDoc.FieldByName('DET_CODDIV').AsString,   // Código Diversos
                   LQryItensDoc.FieldByName('DET_CODMAR').AsString,   // Código da Marca
                   '',                                          // Fornecedor
                   LQryItensDoc.FieldByName('DET_CODCLI').AsString,   // Cliente
                   LQryItensDoc.FieldByName('DET_DTAENT').AsDateTime, // Data da Entrada
                   LQryItensDoc.FieldByName('DET_HORENT').AsDateTime, // Hora da Entrada
                   0,                                           // Data do Documento
                   LQryItensDoc.FieldByName('DET_CONPAG').AsString,   // Condição de Pagamento
                   'C',                                         // Tipo: (C)liente / (F) Fornecedor
                   '',                                          // Estado do Fornecedor
                   LQryItensDoc.FieldByName('DET_DESCRI').AsString,   // Descrição do Item
                   LQryItensDoc.FieldByName('DET_REFERE').AsString,   // Referência do Item
                   LQryItensDoc.FieldByName('DET_UNIDAD').AsString,   // Cód. Unidade
                   LQryItensDoc.FieldByName('DET_FORITE').AsString,   // Fornecedor Item
                   LQryItensDoc.FieldByName('DET_QTDITE').AsFloat,    // Quantidade do Item
                   LQryItensDoc.FieldByName('DET_UNITAR').AsFloat,    // Valor Unitario
                   LQryItensDoc.FieldByName('DET_UNIORI').AsFloat,    // Valor Unitário Original
                   fFormataFloat(LQryItensDoc.FieldByName('DET_UNITAR').AsFloat * LQryItensDoc.FieldByName('DET_QTDITE').AsFloat, 2), // Total do Item
                   LQryItensDoc.FieldByName('DET_VLRCON').AsFloat,    // Valor Contábil do Item
                   LQryItensDoc.FieldByName('DET_TOTCUS').AsFloat,    // Valor Total de Custo
                   LQryItensDoc.FieldByName('DET_TOTMED').AsFloat,    // Valor Total Medio
                   LQryItensDoc.FieldByName('DET_DESCON').AsFloat,    // % Desconto do Item
                   LQryItensDoc.FieldByName('DET_TOTFRE').AsFloat,    // Valor do Frete
                   LQryItensDoc.FieldByName('DET_DESESP').AsFloat,    // Valor do Desconto Especial
                   LQryItensDoc.FieldByName('DET_CODREP').AsString,   // Código do Representante
                   LQryItensDoc.FieldByName('DET_PERCOM').AsFloat,    // Percentual de Comissão do Vendedor
                   LQryItensDoc.FieldByName('DET_TOTCOM').AsFloat,    // Total de Comissão do Vendedor
                   LQryItensDoc.FieldByName('DET_CLAFIS').AsString,   // Classificação Fiscal
                   LQryItensDoc.FieldByName('DET_CODFIS').AsString,   // Código Fiscal
                   LQryItensDoc.FieldByName('DET_VALIPI').AsFloat,    // Valor IPI
                   LQryItensDoc.FieldByName('DET_ALQIPI').AsFloat,    // Aliquota IPI
                   LQryItensDoc.FieldByName('DET_BASIPI').AsFloat,    // Base IPI
                   LQryItensDoc.FieldByName('DET_VALICM').AsFloat,    // Valor de ICMS
                   LQryItensDoc.FieldByName('DET_ALQICM').AsFloat,    // Aliquota de ICMS
                   LQryItensDoc.FieldByName('DET_BASICM').AsFloat,    // Base de ICMS
                   LQryItensDoc.FieldByName('DET_VALRET').AsFloat,    // Valor de Substituição
                   LQryItensDoc.FieldByName('DET_ALQRET').AsFloat,    // Aliquota de Substituição
                   LQryItensDoc.FieldByName('DET_BASRET').AsFloat,    // Base de Substituição
                   LQryItensDoc.FieldByName('DET_TOTPES').AsFloat,                                   // Total de Peso
                   LQryItensDoc.FieldByName('DET_PERBAS').AsFloat,    // Percentual de Base de ICMS
                   LQryItensDoc.FieldByName('DET_PERRED').AsFloat,    // Percentual de Redução de Base
                   False,  // Indica se ja esta Faturado
                   LQryItensDoc.FieldByName('DET_TIPFAT').AsString,   // Tipo de Faturamento
                   LQryItensDoc.FieldByName('DET_NUMFAT').AsString,   // Número do Faturamento
                   LQryItensDoc.FieldByName('DET_DTAFAT').AsDateTime, // Data do Faturamento
                   LQryItensDoc.FieldByName('DET_VENFAT').AsString,   // Vendedor do Faturamento
                   LQryItensDoc.FieldByName('DET_CNDFAT').AsString,   // Condição de Pagamento Faturamento
                   LQryItensDoc.FieldByName('DET_VALFAT').AsFloat,    // Valor do Faturamento
                   LQryItensDoc.FieldByName('DET_IDEPRO').AsString,   // Identificação Produto ( Normal / Outros )
                   LQryItensDoc.FieldByName('DET_INCPIS').AsString,   // Indice se incide Pis
                   LQryItensDoc.FieldByName('DET_SERIE_').AsString,   // Série
                   LQryItensDoc.FieldByName('DET_DESACE').AsFloat,    // Valor de Despesa Acessória
                   '',                                          // Nota Especial
                   '',                                          // Documento da Devolução
                   '',                                          // Espécie da Devolução
                   '',                                          // Empresa da Devolução
                   LQryItensDoc.FieldByName('DET_ITECHA').AsString,   // Item de Chamada (TINTA DE MAQUINA)
                   LQryItensDoc.FieldByName('DET_ITETIN').AsString,   // Item da Tinta (TINTA DE MAQUINA)
                   LQryItensDoc.FieldByName('DET_DESCOR').AsString,   // Descrição da Cor (TINTA DE MAQUINA)
                   LQryItensDoc.FieldByName('DET_TIPEMB').AsString,   // Tipo de Embalagem (TINTA DE MAQUINA)
                   LQryItensDoc.FieldByName('DET_QTDEMB').AsFloat,    // Quantidade de Embalagem (TINTA DE MAQUINA)
                   LQryItensDoc.FieldByName('DET_PREEMB').AsFloat,    // Preço da Embalagem (TINTA DE MAQUINA)
                   LQryItensDoc.FieldByName('DET_TIPPRE').AsString,   // Tipo de Preço (TINTA DE MAQUINA)
                   LQryItensDoc.FieldByName('DET_PRVTIN').AsFloat,    // Preço de Venda da Tinta (TINTA DE MAQUINA)
                   LQryItensDoc.FieldByName('DET_PRCTIN').AsFloat,    // Preço de Compra da Tinta (TINTA DE MAQUINA)
                   LQryItensDoc.FieldByName('DET_FATTIN').AsFloat,    // Fator da Tinta (TINTA DE MAQUINA)
                   LQryItensDoc.FieldByName('DET_PROEMB').AsString,   // Produto Embalagem (TINTA DE MAQUINA)
                   LQryItensDoc.FieldByName('DET_CODDIG').AsString,   // Código do Digitador
                   LQryItensDoc.FieldByName('DET_CODCND').AsString,   // Codigo da Condição
                   LQryItensDoc.FieldByName('DET_CODFPG').AsString,   // Forma de Pagamento
                   LQryItensDoc.FieldByName('DET_QTDITE').AsFloat,                                   // Quantidade de Baixa ********
                   '', //cdsTmp.FieldByName('DET_INFITE').AsString,   // Informações do item ********
                   'N', //cdsTmp.FieldByName('DET_SEPIMP').AsString,   // Separacao Impressa (S/N)
                   LQryItensDoc.FieldByName('AUTINC').AsString,   // Autoincremento do fatdor *******
     {VERIFICAR}   LQryItensDoc.FieldByName('DET_NUMLOT').AsString,                                   // NUMERO DO LOTE
                   LQryItensDoc.FieldByName('DET_PESLIQ').AsFloat,                                   // Peso Liquido
                   LVolume,                                   // Volume do item
                   LQryItensDoc.FieldByName('REF_CBSVAL').AsFloat,    // Valor CBS
                   LQryItensDoc.FieldByName('REF_VALIBS').AsFloat,    // Valor IBS
                   LQryItensDoc.FieldByName('REF_SELVAL').AsFloat,    // Valor IS
                   '');                                         // Empresa Origem

      LQryItensDoc.Next;
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQryItensDoc);
{$ENDIF LINUX}
  end;
end;

class function TObtemRomaneioFaturadosIntegFusion.New:
      {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
begin
  Result := TObtemRomaneioFaturadosIntegFusion.Create;
end;

procedure TObtemRomaneioFaturadosIntegFusion.pExecute;
var
  LQryDoc: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LOpenedTransaction: Boolean;
  LarrRomaneio: TArray<TFusionRomaneio>;
  LobjRomaneio: TFusionRomaneio;
  LobjEntregas: TFusionEntregas;
  LRetorno: Boolean;
  LNumRom: String;
  LAutIncRomGerX: String;
  LEmpLogada: String;
  arrDuplicataCND: TarrDuplicata;
  LDataRom: TDateTime;
  LHoraRom: TTime;
  arrAjudantes: TArray<String>;
begin
  LQryDoc := fCriaQuery;

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
          LQryDoc.Close;
          LQryDoc.SQL.Clear;

          LQryDoc.SQL.Add(sqlPedido);
          LQryDoc.ParamByName('NUMDOC').AsString := Trim(Copy(LobjEntregas.T32PedidoOriginal, 0, 12));
          LQryDoc.ParamByName('ESPDOC').AsString := Trim(Copy(LobjEntregas.T32PedidoOriginal, 13, 2));
          LQryDoc.ParamByName('CODEMP').AsString := Trim(Copy(LobjEntregas.T32PedidoOriginal, 15, 3));

          LQryDoc.Open;

          if LQryDoc.IsEmpty then
            Continue;

          pCarregaDuplicatasCND(1, LQryDoc.FieldByName('AUTINC').AsString, arrDuplicataCND);

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
                         LAutIncRomGerX,   // Auto Incremento (Referência)
                         LQryDoc.FieldByName('GER_NUMDOC').AsString,   // Documento
                         LQryDoc.FieldByName('GER_ESPDOC').AsString,   // Espécie
                         LQryDoc.FieldByName('GER_CODEMP').AsString,   // Empresa
                         IIF(fEmptyStr(FFusTra), LQryDoc.FieldByName('GER_CODTRA').AsString, FFusTra),   // Transportadora
                         LQryDoc.FieldByName('GER_CODVEN').AsString,   // Vendedor
                         '',   // Fornecedor
                         LQryDoc.FieldByName('GER_CODCLI').AsString,   // Cliente
                         'C',   // Tipo (Cliente / Fornecedor)
                         LQryDoc.FieldByName('GER_DTAENT').AsDateTime,   // Data de Entrada
                         LQryDoc.FieldByName('GER_HORENT').AsDateTime,   // Hora de Entrada
                         LQryDoc.FieldByName('GER_DTAENT').AsDateTime,   // Data do Documento
                         LQryDoc.FieldByName('GER_CONPAG').AsString,   // Condição de Pagamento
                         LQryDoc.FieldByName('GER_ESTADO').AsString,   // Estado
                         LQryDoc.FieldByName('GER_NOMCON').AsString,   // Nome Cliente Consumidor
                         LQryDoc.FieldByName('GER_ENDCON').AsString,   // Endereço Cliente Consumidor
                         LQryDoc.FieldByName('GER_BAICON').AsString,   // Bairro Cliente Consumidor
                         LQryDoc.FieldByName('GER_CEPCON').AsString,   // CEP Cliente Consumidor
                         LQryDoc.FieldByName('GER_CIDCON').AsString,   // Cidade Cliente Consumidor
                         LQryDoc.FieldByName('GER_ESTCON').AsString,   // Estado Cliente Consumidor
                         LQryDoc.FieldByName('GER_TELCON').AsString,   // Telefone Cliente Consumidor
                         LQryDoc.FieldByName('GER_CGCCPF').AsString,   // CGC/CPF Cliente Consumidor
                         LQryDoc.FieldByName('GER_CGCCON').AsString,   // CNPJ Cliente Consumidor
                         LQryDoc.FieldByName('GER_IESCON').AsString,   // Inscrição Estadual Cliente Consumidor
                         LQryDoc.FieldByName('GER_R_GCON').AsString,   // RG Cliente Consumidor
                         'N',   // Romaneio já impresso?
                         LQryDoc.FieldByName('GER_BASSIM').AsFloat,   // Base Simples Paulista
                         LQryDoc.FieldByName('GER_BASIPI').AsFloat,   // Base IPI
                         LQryDoc.FieldByName('GER_ALQIPI').AsFloat,   // Aliquota IPI
                         LQryDoc.FieldByName('GER_TOTIPI').AsFloat,   // Total de IPI
                         LQryDoc.FieldByName('GER_BASICM').AsFloat,   // Base de ICMS
                         LQryDoc.FieldByName('GER_ALQICM').AsFloat,   // Aliquota de ICMS
                         LQryDoc.FieldByName('GER_TOTICM').AsFloat,   // Total de ICMS
                         LQryDoc.FieldByName('GER_TOTRET').AsFloat,   // Total Retido
                         LQryDoc.FieldByName('GER_ALQRET').AsFloat,   // Aliquota Retido
                         LQryDoc.FieldByName('GER_BASRET').AsFloat,   // Base Retido
                         LQryDoc.FieldByName('GER_DESESP').AsFloat,   // Desconto Especial
                         {*}LQryDoc.FieldByName('GER_VLRCON').AsFloat,   // Valor Contabil
                         {*}LQryDoc.FieldByName('GER_TOTPRO').AsFloat,   // Total dos Produtos
                         LQryDoc.FieldByName('GER_TOTCUS').AsFloat,   // Total de Custo
                         LQryDoc.FieldByName('GER_TOTMED').AsFloat,   // Total Médio
                         LQryDoc.FieldByName('GER_TIPFRE').AsString,   // Tipo de Frete
                         LQryDoc.FieldByName('GER_TOTFRE').AsFloat,   // Total do Frete
                         LQryDoc.FieldByName('GER_PESBRU').AsFloat,   // Peso Bruto
                         LQryDoc.FieldByName('GER_PESLIQ').AsFloat,   // Peso Líquido
                         LQryDoc.FieldByName('GER_VOLUME').AsFloat,   // Volume
                         LQryDoc.FieldByName('GER_ESPECI').AsString,   // Espécie
                         LQryDoc.FieldByName('GER_MARCA_').AsString,   // Marca
                         LQryDoc.FieldByName('GER_MEN001').AsString,   // Mensagem 01
                         LQryDoc.FieldByName('GER_MEN002').AsString,   // Mensagem 02
                         False,       // Ja Faturado?
                         LQryDoc.FieldByName('GER_TIPFAT').AsString,   // Tipo de Faturamento
                         LQryDoc.FieldByName('GER_NUMFAT').AsString,   // Numero do Faturamento
                         LQryDoc.FieldByName('GER_DTAFAT').AsDateTime,   // Data do Faturamento
                         LQryDoc.FieldByName('GER_VENFAT').AsString,   // Vendedor do Faturamento
                         LQryDoc.FieldByName('GER_CNDFAT').AsString,   // Condição do Faturamento
                         LQryDoc.FieldByName('GER_VALFAT').AsFloat,   // Valor do Faturamento
                         LQryDoc.FieldByName('GER_VPAR01').AsFloat,   // Valor da Parcela 01
                         LQryDoc.FieldByName('GER_VPAR02').AsFloat,   // Valor da Parcela 02
                         LQryDoc.FieldByName('GER_VPAR03').AsFloat,   // Valor da Parcela 03
                         LQryDoc.FieldByName('GER_VPAR04').AsFloat,   // Valor da Parcela 04
                         LQryDoc.FieldByName('GER_VPAR05').AsFloat,   // Valor da Parcela 05
                         LQryDoc.FieldByName('GER_VPAR06').AsFloat,   // Valor da Parcela 06
                         LQryDoc.FieldByName('GER_VPAR07').AsFloat,   // Valor da Parcela 07
                         LQryDoc.FieldByName('GER_VPAR08').AsFloat,   // Valor da Parcela 08
                         LQryDoc.FieldByName('GER_VPAR09').AsFloat,   // Valor da Parcela 09
                         LQryDoc.FieldByName('GER_VPAR10').AsFloat,   // Valor da Parcela 10
                         LQryDoc.FieldByName('GER_VPAR11').AsFloat,   // Valor da Parcela 11
                         LQryDoc.FieldByName('GER_VPAR12').AsFloat,   // Valor da Parcela 12
                         arrDuplicataCND,
                         LQryDoc.FieldByName('GER_SERIE_').AsString,   // Série
                         LQryDoc.FieldByName('GER_NOTESP').AsString,   // Nota Especial
                         LQryDoc.FieldByName('GER_CLAFIS').AsString,   // Classificação Fiscal
                         LQryDoc.FieldByName('GER_PORDES').AsFloat,   //
                         LQryDoc.FieldByName('GER_CODDIG').AsString,   // Digitador
                         LQryDoc.FieldByName('GER_CODCND').AsString,   // Código da Condição de Pagamento
                         LQryDoc.FieldByName('GER_CODFPG').AsString,   // Código da Forma de Pagamento
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
                         LQryDoc.FieldByName('GER_TOTPRO').AsFloat,   // Valor original do
                         strLoginUsuarioLogado,   // Operador Solicitante
                         '', //strAutEnt,   // Ref de Endereco de Entrega
                         0, //fltVlrFre,
                         0, //fltVlrAdi,
                         0, //fltPerFre,
                         '', //strMsgExp,
                         '', //strPalet,
                         'A', //strStatus,
                         '', //strNumBox,
                         'MOVGER', //strNomTab,
                         'S', //strEntSai,
                         LQryDoc.FieldByName('AUTINC').AsString,
                         '', //strMenExp,
                         '', //strMenEx2,
                         '', //strMenEx3,
                         '', //strMenEx4,
                         '', //strLocali,
                         fCfgSis('FUSTAE'), //strLibApp,
                         '', //strEvitar,
                         0, //fltDistan,
                         0, //fltTmpEnt,
                         LQryDoc.FieldByName('ENDENT').AsString,
                         LQryDoc.FieldByName('BAIENT').AsString,
                         LQryDoc.FieldByName('CEPENT').AsString,
                         LQryDoc.FieldByName('CIDENT').AsString,
                         LQryDoc.FieldByName('REFENT').AsString,
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

          LRetorno := LRetorno and fGravarRomDet(LQryDoc.FieldByName('AUTINC').AsString, LNumRom, LAutIncRomGerX);

          if LRetorno then
          begin
            pAtualizaDocumento(LQryDoc.FieldByName('AUTINC').AsString, LNumRom, LDataRom, LHoraRom);

            TUpdateStatus.New(TParamStatus.New()
                          .NumDoc(LQryDoc.FieldByName('GER_NUMDOC').AsString)
                          .EspDoc(LQryDoc.FieldByName('GER_ESPDOC').AsString)
                          .CodEmp(LQryDoc.FieldByName('GER_CODEMP').AsString)).pExecute();

            if VS_strHabilitarCRM then
              TUpdateOccurrenceCRM.New()
                .NumDoc(LQryDoc.FieldByName('GER_NUMDOC').AsString)
                .EspDoc(LQryDoc.FieldByName('GER_ESPDOC').AsString)
                .CodEmp(LQryDoc.FieldByName('GER_CODEMP').AsString)
                .CodCli(LQryDoc.FieldByName('GER_CODCLI').AsString)
                .AcaFat(IIF((not fEmptyStr(LQryDoc.FieldByName('GER_CODCLI').AsString)), afcRomaneioAlteracao, afcRomaneioInclusao))
                .NumRom(LNumRom)
                .CodMot(LobjRomaneio.T05CodigoErp)
                .CodTra(IIF(fEmptyStr(FFusTra), LQryDoc.FieldByName('GER_CODTRA').AsString, FFusTra))
                .strNomFrm('[TObtemRomaneioFaturadosIntegFusion.pExecute]')
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

procedure TObtemRomaneioFaturadosIntegFusion.pExecuteAll;
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
    TObtemRomaneioFaturadosIntegFusion.New.pExecute();
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

end.
