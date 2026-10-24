unit untClasseSTCustoAquisicao;

interface

uses untAbstractConsulta, untIConsulta, untFatCalcularImpostos, untFatRegrasImpostos,
  untAbstractGerarTeste,
  Uni, untIGerarTeste, untICasosTestesLog, untCasosTestesLog, untFuncoes,
  Shared.Functions.Configuracoes, Shared.Functions.Funcoes.Faturamento, Forms,
  untCasosTestesLogImpl, Faturamento.Impostos.Calculos.TesteUnitarioLog,
  System.SysUtils, Vcl.Dialogs, Shared.Functions.Constantes, Shared.Functions.Types,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Tipos.Model, System.Math, System.Types, Shared.Functions.FloatUtils,
  UniClientDataSet, UniDataSetProvider, System.Variants, untParametrosResultadoSTCustoAquisicao,
  Faturamento.Impostos.Interfaces.STCustoAquisicao, Faturamento.Impostos.Tipos.STCustoAquisicao,
  Data.DB, StrUtils, untTypes;

type
  TConsultaSTCustoAquisicao = class(TAbstractConsulta)
  public
    Class function New : IConsulta;
    function fRetornarSQLStCustoAquisicao : String; override;
  end;

type
  TGerarTesteSTCustoAquisicao = class(TAbstractGerarTeste)
  private
    FModeloCalculoSubstituicaoDeOperacoesProprias: String;
//    function PercetualBaseIcmsDoFornecedor(const ADados: TUniClientDataSet): Double;
//    function AliquotaDeSubstituicaoTributaria(const ADados: TUniClientDataSet): Double;
//    function RetornarSubstituicaoTributaria(
//      const ACodigoFiscal: string; const ABaseRetidoSP: double): boolean;
//    function RetornarPrecoCompraComDesconto(const ABaseRetidoSP, AValorIcmsOperacoesProprias: double): double;
//    function RetornarPercentualBaseSTFornecedor(const ABaseRetidoSP, AValorIcmsOperacoesProprias: double): double;
//    function ValidarSeDeveCalcularIcmsOperacoesProprias(const ABaseRetidoSP, AValorIcmsOperacoesProprias: double): Boolean;
//    function RetornarDentroEstadoFaturamento(
//      const AClassificacaoFiscal: string): Boolean;
  public
    Class function New : IGerarTeste;

    Constructor Create;
    Destructor Destroy; override;

    function fGerarTesteStCustoAquisicao(const ADados: OleVariant) : Boolean; override;
  end;

const
  PrecoEscolhidoPartePositivaEParteNegativa = '1';
  DecimaisComparacao = 2;
  DiferencaComparacao = '0,01';

implementation

uses
  untModulo;


{ TConsultaSTCustoAquisicao }

function TConsultaSTCustoAquisicao.fRetornarSQLStCustoAquisicao: String;
begin
  Result := 'SELECT                                                           ' +
            '  D.DET_NUMDOC,                                                  ' +
            '  D.DET_ESPDOC,                                                  ' +
            '  D.DET_CODEMP,                                                  ' +
            '  D.DET_CODFIS,                                                  ' +
            '  G.GER_CONSUM,                                                  ' +
            '  G.GER_IESCON,                                                  ' +
            '  D.DET_TIP_FC,                                                  ' +
            '  D.DET_CODITE,                                                  ' +
            '  D.DET_CLAFIS,                                                  ' +
            '  D.DET_CODFOR,                                                  ' +
            '  D.DET_CODCLI,                                                  ' +
            '  D.DET_ENTFUT,                                                  ' +
            '  D.DET_ESTADO,                                                  ' +
            '  "N" AS AUX_COMVAL,                                             ' +
            '  CASE                                                           ' +
            '    WHEN (AUXMOV.AUX_OPCDOC = "11")                              ' +
            '    THEN "VN"                                                    ' +
            '    WHEN (AUXMOV.AUX_OPCDOC = "EX")                              ' +
            '    THEN "CP"                                                    ' +
            '    ELSE AUXMOV.AUX_OPCDOC                                       ' +
            '  END AUX_OPCDOC,                                                ' +
            '  CADCLI.CLI_REGFIS,                                             ' +
            '  C.ITE_COMLUB,                                                  ' +
            '  C.ITE_IMPDIR,                                                  ' +
            '  CADCLI.CLI_CODATI,                                             ' +
            '  CADCLI.CLI_MICEMP,                                             ' +
            '  CADCLI.CLI_CODCID,                                             ' +
            '  CADCLI.CLI_ZONFRA,                                             ' +
            '  CADCLI.CLI_I_E_S_,                                             ' +
            '  CADCLI.CLI_PRORUR,                                             ' +
            '  CADCLI.CLI_IESUNI,                                             ' +
            '  CADCLI.CLI_DESPIS,                                             ' +
            '  CADCLI.CLI_ORGPUB,                                             ' +
            '  CADCLI.CLI_CALICM,                                             ' +
            '  ENTCLI.ETC_CIDENT,                                             ' +
            '  AUXMOV.AUX_VENPRE,                                             ' +
            '  AUXMOV.AUX_CONEQU,                                             ' +
            '  D.DET_CODEMP AS FDO_EMPITE,                                    ' +
            '  IFNULL(FATGOR.FGO_ORIGEM, "AUTCOM") AS FGO_ORIGEM,             ' +
            '  FATGOR.FGO_TIPOPE,                                             ' +
            '  EXTGOR.FGO_EMP_TE,                                             ' +
            '  C.ITE_ITECCR,                                                  ' +
            '  CID.CID_ESTADO AS CID_ESTADO_CLIENTE,                          ' +
            '  CIDEMP.CID_ESTADO AS CID_ESTADO_EMPRESA,                       ' +
            '  DET_ALQICM,                                                    ' +
            '  DET_BASICM,                                                    ' +
            '  DET_VALICM,                                                    ' +
            '  DET_PERBAS,                                                    ' +
            '  DET_VALIPI,                                                    ' +
            '  DET_TOTITE,                                                    ' +
            '  DET_DESESP,                                                    ' +
            '  DET_TOTFRE,                                                    ' +
            '  DET_PERRED,                                                    ' +
            '  DET_DTAENT,                                                    ' +
            '  EXTGOR.FGO_INDCOM,                                             ' +
            '  G.GER_ESTADO,                                                  ' +
            '  G.GER_ORIDOC,                                                  ' +
            '  T.DET_RICMPR,                                                  ' +
            '  IFNULL(T.DET_VALDIF, 0) AS DET_VALDIF,                         ' +
            '  T.DET_PEBAST,                                                  ' +
            '  C.ITE_UTIAMP,                                                  ' +
            '  T.DET_VALIVA,                                                  ' +
            '  D.DET_TOTCUS,                                                  ' +
            '  T.DET_TOTULT,                                                  ' +
            '  T.DET_IMPULT,                                                  ' +
            '  T.DET_PFCPST,                                                  ' +
            '  T.DET_VFCPST,                                                  ' +
            '  T.DET_ITEABF,                                                  ' +
            '  D.DET_BASRET,                                                  ' +
            '  D.DET_VALRET,                                                  ' +
            '  D.DET_ALQRET,                                                  ' +
            '  T.DET_BARTSP,                                                  ' +
            '  T.DET_VLRTSP,                                                  ' +
            '  T.DET_ICOPPR,                                                  ' +
            '  IG.ITE_FREENT,                                                 ' +
            '  IG.ITE_IPIENT                                                  ' +
            'FROM                                                             ' +
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
            '    )                                                            ' +
            '  WHERE G.GER_CODEMP = :CODEMP                                   ' +
//            '    AND G.GER_NUMDOC = "000000202062"                            ' +
//            '    AND D.DET_CODITE = "96596"                                   ' +
            '    AND G.GER_DTAENT BETWEEN :DTAINI                             ' +
            '    AND :DTAFIM                                                  ' +

            '  UNION                                                          ' +
            '  ALL                                                            ' +
            '  SELECT                                                         ' +
            '    D.DET_NUMDOC,                                                ' +
            '    D.DET_ESPDOC,                                                ' +
            '    D.DET_CODEMP,                                                ' +
            '    D.DET_CODFIS,                                                ' +
            '    G.GER_CONSUM,                                                ' +
            '    G.GER_IESCON,                                                ' +
            '    D.DET_TIP_FC,                                                ' +
            '    D.DET_CODITE,                                                ' +
            '    D.DET_CLAFIS,                                                ' +
            '    D.DET_CODFOR,                                                ' +
            '    D.DET_CODCLI,                                                ' +
            '    D.DET_ENTFUT,                                                ' +
            '    D.DET_ESTADO,                                                ' +
            '    AUXNOT.AUX_COMVAL,                                           ' +
            '    CASE                                                         ' +
            '      WHEN (AUXNOT.AUX_OPCDOC = "11")                            ' +
            '      THEN "VN"                                                  ' +
            '      WHEN (AUXNOT.AUX_OPCDOC = "EX")                            ' +
            '      THEN "CP"                                                  ' +
            '      ELSE AUXNOT.AUX_OPCDOC                                     ' +
            '    END AUX_OPCDOC,                                              ' +
            '    CADCLI.CLI_REGFIS,                                           ' +
            '    C.ITE_COMLUB,                                                ' +
            '    C.ITE_IMPDIR,                                                ' +
            '    CADCLI.CLI_CODATI,                                           ' +
            '    CADCLI.CLI_MICEMP,                                           ' +
            '    CADCLI.CLI_CODCID,                                           ' +
            '    CADCLI.CLI_ZONFRA,                                           ' +
            '    CADCLI.CLI_I_E_S_,                                           ' +
            '    CADCLI.CLI_PRORUR,                                           ' +
            '    CADCLI.CLI_IESUNI,                                           ' +
            '    CADCLI.CLI_DESPIS,                                           ' +
            '    CADCLI.CLI_ORGPUB,                                           ' +
            '    CADCLI.CLI_CALICM,                                           ' +
            '    ENTCLI.ETC_CIDENT,                                           ' +
            '    AUXNOT.AUX_VENPRE,                                           ' +
            '    "N" AS AUX_CONEQU,                                           ' +
            '    DET_CODEMP AS FDO_EMPITE,                                    ' +
            '    "AUTCOM" AS FGO_ORIGEM,                                      ' +
            '    "V" AS FGO_TIPOPE,                                           ' +
            '    "" AS FGO_EMP_TE,                                            ' +
            '    C.ITE_ITECCR,                                                ' +
            '    CID.CID_ESTADO AS CID_ESTADO_CLIENTE,                        ' +
            '    CIDEMP.CID_ESTADO AS CID_ESTADO_EMPRESA,                     ' +
            '    DET_ALQICM,                                                  ' +
            '    DET_BASICM,                                                  ' +
            '    DET_VALICM,                                                  ' +
            '    DET_PERBAS,                                                  ' +
            '    DET_VALIPI,                                                  ' +
            '    DET_TOTITE,                                                  ' +
            '    DET_DESESP,                                                  ' +
            '    DET_TOTFRE,                                                  ' +
            '    DET_PERRED,                                                  ' +
            '    DET_DTAENT,                                                  ' +
            '    "" AS FGO_INDCOM,                                            ' +
            '    G.GER_ESTADO,                                                ' +
            '    G.GER_ORIDOC,                                                ' +
            '    T.DET_RICMPR,                                                ' +
            '    IFNULL(T.DET_VALDIF, 0) AS DET_VALDIF,                       ' +
            '    T.DET_PEBAST,                                                ' +
            '    C.ITE_UTIAMP,                                                ' +
            '    T.DET_VALIVA,                                                ' +
            '    D.DET_TOTCUS,                                                ' +
            '    T.DET_TOTULT,                                                ' +
            '    T.DET_IMPULT,                                                ' +
            '    T.DET_PFCPST,                                                ' +
            '    T.DET_VFCPST,                                                ' +
            '    "" AS DET_ITEABF,                                            ' +
            '    D.DET_BASRET,                                                ' +
            '    D.DET_VALRET,                                                ' +
            '    D.DET_ALQRET,                                                ' +
            '    T.DET_BARTSP,                                                ' +
            '    T.DET_VLRTSP,                                                ' +
            '    T.DET_ICOPPR,                                                ' +
            '    IG.ITE_FREENT,                                               ' +
            '    IG.ITE_IPIENT                                                ' +
            '  FROM                                                           ' +
            '    NOTGER G                                                     ' +
            '    JOIN NOTDET D                                                ' +
            '      ON D.DET_SEQGER = G.AUTOINCREM                             ' +
            '    INNER JOIN CADITE C                                          ' +
            '      ON C.ITE_CODITE = D.DET_CODITE                             ' +
            '    INNER JOIN ITEGER IG                                         ' +
            '      ON IG.ITE_CODITE = D.DET_CODITE AND                        ' +
            '         IG.ITE_CODEMP = DET_CODEMP                              ' +
            '    INNER JOIN CADCLI                                            ' +
            '      ON CLI_CODCLI = D.DET_CODCLI                               ' +
            '    INNER JOIN CADEMP EMP                                        ' +
            '      ON EMP.EMP_CODEMP = DET_CODEMP                             ' +
            '    INNER JOIN CADCID CID                                        ' +
            '      ON CID.CID_CODCID = CADCLI.CLI_CODCID                      ' +
            '    INNER JOIN CADCID CIDEMP                                     ' +
            '      ON CIDEMP.CID_CODCID = EMP.EMP_CODCID                      ' +
            '    LEFT JOIN AUXNOT                                             ' +
            '      ON AUXNOT.AUX_SEQGER = D.DET_SEQGER                        ' +
            '    LEFT JOIN NOTTRI T  ON T.DET_SEQGER = D.AUTOINCREM           ' +
            '    LEFT JOIN ENTCLI                                             ' +
            '      ON ETC_CODCLI = D.DET_CODCLI                               ' +
            '      AND IF(                                                    ' +
            '        AUXNOT.AUX_ENTGER IS NOT NULL,                           ' +
            '        ENTCLI.AUTOINCREM = AUXNOT.AUX_ENTGER,                   ' +
            '        ETC_SEQIND =                                             ' +
            '        (SELECT                                                  ' +
            '          MIN(ETC_SEQIND)                                        ' +
            '        FROM                                                     ' +
            '          ENTCLI                                                 ' +
            '        WHERE ETC_CODCLI = CLI_CODCLI)                           ' +
            '      )                                                          ' +
            '  WHERE G.GER_CODEMP = :CODEMP                                   ' +
//            '    AND G.GER_NUMDOC = "000000202062"                            ' +
//            '    AND D.DET_CODITE = "96596"                                   ' +
            '    AND G.GER_DTAENT BETWEEN :DTAINI                             ' +
            '    AND :DTAFIM                                                  ';
end;

class function TConsultaSTCustoAquisicao.New: IConsulta;
begin
  Result := Self.Create;
end;

{ TGerarTesteST }

//function TGerarTesteSTCustoAquisicao.AliquotaDeSubstituicaoTributaria(
//  const ADados: TUniClientDataSet): Double;
//begin
//  Result := ADados.FieldByName('DET_VLRTSP').AsFloat;
//
//  If (ADados.FieldByName('DET_VLRTSP').AsFloat > 0) Then
//  Begin
//    Result := ((ADados.FieldByName('DET_VLRTSP').AsFloat / ADados.FieldByName('DET_BARTSP').AsFloat) * 100);
//  End;
//end;

constructor TGerarTesteSTCustoAquisicao.Create;
begin

end;

destructor TGerarTesteSTCustoAquisicao.Destroy;
begin

  inherited;
end;

//function TGerarTesteSTCustoAquisicao.RetornarPercentualBaseSTFornecedor(const ABaseRetidoSP,
//  AValorIcmsOperacoesProprias: double): double;
//begin
//  result := 100;
//
//  if (not ValidarSeDeveCalcularIcmsOperacoesProprias(ABaseRetidoSP, AValorIcmsOperacoesProprias)) then
//    Exit;
//
//  result := 0;
//end;

//function TGerarTesteSTCustoAquisicao.RetornarPrecoCompraComDesconto(
//  const ABaseRetidoSP, AValorIcmsOperacoesProprias: double): double;
//begin
//  result := ABaseRetidoSP;
//
//  if (not ValidarSeDeveCalcularIcmsOperacoesProprias(ABaseRetidoSP, AValorIcmsOperacoesProprias)) then
//    Exit;
//
//  result := AValorIcmsOperacoesProprias;
//end;

//function TGerarTesteStCustoAquisicao.RetornarSubstituicaoTributaria(const ACodigoFiscal: string; const ABaseRetidoSP: double): boolean;
//begin
//  result := True;
//
//  If (Pos(ACodigoFiscal, objConstantes.fGetCstSubstituicao) > 0) then
//    Exit;
//
//  If (ABaseRetidoSP > 0) then
//    Exit;
//
//  result := False;
//end;

//function TGerarTesteSTCustoAquisicao.ValidarSeDeveCalcularIcmsOperacoesProprias(
//  const ABaseRetidoSP, AValorIcmsOperacoesProprias: double): Boolean;
//begin
//  result := False;
//
//  if (ABaseRetidoSP > 0) then
//    Exit;
//
//  if (AValorIcmsOperacoesProprias <= 0) then
//    Exit;
//
//  result := true;
//end;

//function TGerarTesteSTCustoAquisicao.RetornarDentroEstadoFaturamento(const AClassificacaoFiscal: string): Boolean;
//Begin
//  result := True;
//
//  if (LeftStr(AClassificacaoFiscal, 1) = '1') Then
//    Exit;
//
//  if (LeftStr(AClassificacaoFiscal, 1) = '5') Then
//    Exit;
//
//  result := False;
//End;

function TGerarTesteStCustoAquisicao.fGerarTesteSTCustoAquisicao(const ADados: OleVariant): Boolean;
var
  LCasosTestesLog: ICasosTestesLog;
  LResultadoCalculoSTCustoAquisicao: IResultadoCalculoSTCustoAquisicao;
  LParametrosResultadoSTCustoAquisicao: IParametrosResultadoSTCustoAquisicao;
  LResultadoComparacao: TResultadoComparacao;
  LDados: TUniClientDataSet;

  //LVendaPresencial: Boolean;
  LClienteEstadoBD: String;
  LTrocaUFEndEntrega: String;
  //LDentroDoEstado: Boolean;
//  LDentroDoEstadoFaturamento: Boolean;
//  LCalcSTCliConNCOEspSto: Boolean;
  LTipoAbfCliente: String;
  LCodigoClienteFilial: String;
  LCodigoAtividade: String;
  LCodigoAtividadeBD: String;
  LAtividadeConstrutora: Boolean;
  LClientesFiliais: String;
//  LAliquotaDeOperacoesProprias: Double;
//  LAliquotaDeSubstituicaoTributaria: Double;
//  LSubstituicaoTributaria: boolean;
//  LPrecoCompraComDesconto: double;
//  LPercentualBaseSTFornecedor: double;

  function fGetTipoAbfCliente(const ACodigoCliente, AConsumidor, AInscricao: String): String;
    Var
      qryCliente: TUniQuery;
  begin
    qryCliente := fCriaQuery;

    qryCliente.SQL.Text := TFunctionFuncoesFaturamento.fGetSelectTipoAbfCliente;
    qryCliente.ParamByName('CODCLI').AsString := ACodigoCliente;
    qryCliente.Open;

    Result :=
      TFunctionFuncoesFaturamento.
        fGetTipoAbfCliente(ACodigoCliente,
                           qryCliente.FieldByName('FISJUR').AsString,
                           AInscricao,
                           AConsumidor,
                           qryCliente.FieldByName('CODATI').AsString,
                           qryCliente.FieldByName('PRORUR').AsString,
                           qryCliente.FieldByName('MICEMP').AsString,
                           qryCliente.FieldByName('REGTRI').AsString,
                           '',
                           qryCliente.FieldByName('INDUST').AsString,
                           LCodigoClienteFilial,
                           LAtividadeConstrutora);

    FreeAndNil(qryCliente);
  end;

begin
  Result := True;

  FModeloCalculoSubstituicaoDeOperacoesProprias := fGetValorConfiguracao(CFG_MENSAGEM_IMPOSTO_RETIDO_INDUSTRIA_MODELO_CALCULO_SUBST_OPERACOES_PROPRIAS);
  LClientesFiliais := fCampoTabela('GROUP_CONCAT(EMP_CLIFIL)', 'CADEMP', [], [], False, '', Nil);

  LCasosTestesLog := TCasosTestesLog.New();
  LDados := TUniClientDataSet.Create(Nil);

  Try
    LDados.Data := ADados;
    LDados.Open;
    LDados.First;

    Try
      While Not LDados.Eof Do
      Begin
        if (ValidarPararProcessamento) then
          Break;

        frmModulo.IncrementarRegistrosProcessados;

        pExecutarProgresso(LDados.RecordCount, LDados.RecNo);

        //LVendaPresencial := LDados.FieldByName('AUX_VENPRE').AsString = 'S';

        LClienteEstadoBD := LDados.FieldByName('CID_ESTADO_EMPRESA').AsString;

        LTrocaUFEndEntrega := LDados.FieldByName('DET_ESTADO').AsString;

        LCodigoAtividade := LDados.FieldByName('CLI_CODATI').AsString;

        LCodigoAtividadeBD := fCampoTabela('ATI_CODATI', 'CLIATI', ['ATI_CODATI', 'ATI_CODEMP'], [LCodigoAtividade, LDados.FieldByName('DET_CODEMP').AsString], False);

        LCodigoClienteFilial := EmptyStr;
        If (LDados.FieldByName('DET_CODCLI').AsString <> EmptyStr) Then
          LCodigoClienteFilial := fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_CLIFIL'], [LDados.FieldByName('DET_CODCLI').AsString], False);

        LAtividadeConstrutora :=
          TFunctionFuncoesFaturamento.
            fAtividadeConstrutora(LCodigoAtividade,
                                  LCodigoAtividadeBD);

        //LDentroDoEstado :=
        //  TFunctionFuncoesFaturamento.fDentroDoEstado(LTrocaUFEndEntrega, LClienteEstadoBD);

        //LDentroDoEstadoFaturamento :=
        //  TFunctionFuncoesFaturamento.
        //    fDentroDoEstadoFaturamento(LDentroDoEstado, LVendaPresencial);


//        LDentroDoEstadoFaturamento := RetornarDentroEstadoFaturamento(LDados.FieldByName('DET_CLAFIS').AsString);

        LTipoAbfCliente :=
          fGetTipoAbfCliente(LDados.FieldByName('DET_CODCLI').AsString,
                             LDados.FieldByName('GER_CONSUM').AsString,
                             LDados.FieldByName('GER_IESCON').AsString);


//        LCalcSTCliConNCOEspSto :=
//          TFunctionFuncoesFaturamento.
//            CalcSTCliConNCOEspSto(LDados.FieldByName('CID_ESTADO_EMPRESA').AsString,
//                                  LTipoAbfCliente,
//                                  (LDados.FieldByName('GER_CONSUM').AsString = 'S'),
//                                  LDentroDoEstadoFaturamento,
//                                  (LDados.FieldByName('ITE_IMPDIR').AsString = 'S'),
//                                  LDados.FieldByName('DET_CODFIS').AsString);

//        LAliquotaDeOperacoesProprias := PercetualBaseIcmsDoFornecedor(LDados);

//        LPrecoCompraComDesconto := RetornarPrecoCompraComDesconto(LDados.FieldByName('DET_BARTSP').AsFloat,
//                                                                  LDados.FieldByName('DET_ICOPPR').AsFloat);

//        LPercentualBaseSTFornecedor := RetornarPercentualBaseSTFornecedor(LDados.FieldByName('DET_BARTSP').AsFloat,
//                                                                          LDados.FieldByName('DET_ICOPPR').AsFloat);

        LParametrosResultadoSTCustoAquisicao :=
          TParametrosResultadoSTCustoAquisicao.New()
            .BaseDaSTCustoAquisicao(LDados.FieldByName('DET_BARTSP').AsFloat)
            .ValorDaSTCustoAquisicao(LDados.FieldByName('DET_VLRTSP').AsFloat)
            .ValorDoIcmsOperacoesProprias(LDados.FieldByName('DET_ICOPPR').AsFloat)
            .FatorPositivo(LDados.FieldByName('DET_VLRTSP').AsFloat)
            .FatorNegativo(0);

//        LAliquotaDeSubstituicaoTributaria := AliquotaDeSubstituicaoTributaria(LDados);

//        LSubstituicaoTributaria := RetornarSubstituicaoTributaria(LDados.FieldByName('DET_CODFIS').AsString,
//                                                                  LDados.FieldByName('DET_BARTSP').AsFloat);

//        LResultadoCalculoSTCustoAquisicao :=
//          CalcularValorSTCustoAquisicao(
//            TParametrosCalculoSTCustoAquisicao.New()
//              .VendaDentroDoEstado(LDentroDoEstadoFaturamento)
//              .SubstituicaoTributaria(LSubstituicaoTributaria)
//              .ClienteConsumidorFinal(LDados.FieldByName('GER_CONSUM').AsString = 'S')
//              .PrecoDeCompraComDescontos(LPrecoCompraComDesconto)
//              .ModeloCalculoSubstituicaoDeOperacoesProprias(FModeloCalculoSubstituicaoDeOperacoesProprias)
//              .PercetualBaseIcmsDoFornecedor(100)
//              .IvaDoFornecedor(1)
//              .PercetualBaseSTDoFornecedor(LPercentualBaseSTFornecedor)
//              .AliquotaDeSubstituicaoTributaria(LAliquotaDeSubstituicaoTributaria)
//              .AliquotaDeIcms(0)
//              .AliquotaDeOperacoesProprias(LAliquotaDeOperacoesProprias)
//              .IpiDeEntrada(0)
//              .FreteDeEntrada(0)
//              .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(LCalcSTCliConNCOEspSto),
//              LParametrosResultadoSTCustoAquisicao
//            );

        LResultadoComparacao := rcoFalse;

        if(CompararValores(LResultadoCalculoSTCustoAquisicao.BaseDaSTCustoAquisicao, LDados.FieldByName('DET_BARTSP').AsFloat) And
           CompararValores(LResultadoCalculoSTCustoAquisicao.ValorDaSTCustoAquisicao, LDados.FieldByName('DET_VLRTSP').AsFloat) And
           CompararValores(LResultadoCalculoSTCustoAquisicao.ValorDoIcmsOperacoesProprias, LDados.FieldByName('DET_ICOPPR').AsFloat) And
           CompararValores(LResultadoCalculoSTCustoAquisicao.FatorPositivo, LDados.FieldByName('DET_VLRTSP').AsFloat) And
           CompararValores(LResultadoCalculoSTCustoAquisicao.FatorNegativo, 0)) Then
        begin
          LResultadoComparacao := rcoTrue;
        end;

        LCasosTestesLog.Add(
          TParametrosCasosTestesLog.New()
            .ResultadoComparacao(LResultadoComparacao)
            .RetornarNomeOperacao('CALCULO_ST_CUSTOAQUISICAO')
            .NumeroDoDocumento(LDados.FieldByName('DET_NUMDOC').AsString)
            .EspecieDoDocumento(LDados.FieldByName('DET_ESPDOC').AsString)
            .CodigoDaEmpresa(LDados.FieldByName('DET_CODEMP').AsString)
            .CodigoDoItem(LDados.FieldByName('DET_CODITE').AsString)
            .CodigoDoCliente(LDados.FieldByName('DET_CODCLI').AsString)
            .OpcaoDocumento(LDados.FieldByName('AUX_OPCDOC').AsString)
            .DataEntrada(LDados.FieldByName('DET_DTAENT').AsDateTime)
            .CodigoFiscal(LDados.FieldByName('DET_CODFIS').AsString)
            .EstadoDoDocumento(LDados.FieldByName('DET_ESTADO').AsString)
            .Log(fGetVariavelLogSTCustoAquisicao));

        pLimparVariaveisTesteUnitario;

        LDados.Next;
      End;

      LCasosTestesLog.GerarLog('STCustoAquisicao');

    Except
      On E : Exception do
        ShowMessage('Documento:'+ LDados.FieldByName('DET_NUMDOC').AsString +
                    '| Especie:'+ LDados.FieldByName('DET_ESPDOC').AsString +
                    '| Item:'+ LDados.FieldByName('DET_CODITE').AsString +
                    '| Empresa:'+ LDados.FieldByName('DET_CODEMP').AsString + #13#10 + E.Message);
    End;
  Finally

  End;
end;

class function TGerarTesteSTCustoAquisicao.New: IGerarTeste;
begin
  Result := Self.Create;
end;

//function TGerarTesteSTCustoAquisicao.PercetualBaseIcmsDoFornecedor(
//  const ADados: TUniClientDataSet): Double;
//begin
//  Result := ADados.FieldByName('DET_ICOPPR').AsFloat;
//
//  If ADados.FieldByName('DET_ICOPPR').AsFloat <= 0 Then
//    Exit;
//
//  if (ADados.FieldByName('DET_BARTSP').AsFloat = 0) Then
//  Begin
//    result := 100;
//    Exit;
//  End;
//
//  Result := ((ADados.FieldByName('DET_ICOPPR').AsFloat / ADados.FieldByName('DET_BARTSP').AsFloat) * 100);
//end;

end.
