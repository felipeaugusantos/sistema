unit untClasseST;

interface

uses untAbstractConsulta, untIConsulta, untFatCalcularImpostos, untFatRegrasImpostos,
  untAbstractGerarTeste,
  Uni, untIGerarTeste, untICasosTestesLog, untCasosTestesLog, untFuncoes,
  Shared.Functions.Configuracoes, Shared.Functions.Funcoes.Faturamento, Forms,
  untCasosTestesLogImpl, Faturamento.Impostos.Calculos.TesteUnitarioLog,
  System.SysUtils, Vcl.Dialogs, Shared.Functions.Constantes, Shared.Functions.Types,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Tipos.Model, System.Math, System.Types, Shared.Functions.FloatUtils,
  UniClientDataSet, UniDataSetProvider, System.Variants, untParametrosResultadoST,
  Faturamento.Impostos.Interfaces.ST, Faturamento.Impostos.Tipos.ST, Data.DB, untTypes;

type
  TConsultaST = class(TAbstractConsulta)
  public
    Class function New : IConsulta;
    function fRetornarSQLSt : String; override;
  end;

type
  TGerarTesteST = class(TAbstractGerarTeste)
  private
    cdsAbfIcm: TUniClientDataSet;
    dspAbfIcm: TUniDataSetProvider;
    qryAbfIcm: TUniQuery;

    procedure pInicializarObjetoCliente(const ADados: TUniClientDataSet);

    function fBuscaAbfIcm(ACodigoDoItem, ACodigoAbreviacaoFiscal,
      AEstado, ACodigoDaEmpresaTE, ACodigoDaEmpresa: String): Boolean;
    procedure pAbreClientAbf(ACodigoDaEmpresaTE, ACodigoDaEmpresa: String);
    procedure pCriaClientAbf;
    function RetornarEstadoEntrega(const ACodigoCidadeEntrega, AEstadoDoDocumento: string): String;
    function ValidarSePodeAdicionarLog(const AResultadoComparacao: TResultadoComparacao; const AEspecieDocumento: string): boolean;
    function RetornarBaseCalculoImpostosDecreto44498(const ADados: TUniClientDataSet; const AValorDoIva: double; const AUtilizarReducaoDeBaseDeCalculoDeSTNaVenda: boolean): double;
    function ValidarBaseCalculoImpostosDecreto44498(
      const ADados: TUniClientDataSet; const AValorDoIva: double;
      const AUtilizarReducaoDeBaseDeCalculoDeSTNaVenda: boolean;
      const ANomeCampo: string): Boolean;
  public
    Class function New : IGerarTeste;

    Constructor Create;
    Destructor Destroy; override;

    function fGerarTesteSt(const ADados: OleVariant) : Boolean; override;
  end;

implementation

uses
  untModulo;

const
  DET_TOTCUS = 'DET_TOTCUS';
  DET_TOTULT = 'DET_TOTULT';
  DET_IMPULT = 'DET_IMPULT';

{ TConsultaST }

function TConsultaST.fRetornarSQLSt: String;
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
            '  D.DET_ALQRET                                                   ' +
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
//            '    AND G.GER_NUMDOC = "000000068837"                            ' +
//            '    AND D.DET_CODITE = "17171"                                   ' +
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
            '    D.DET_ALQRET                                                 ' +
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
//            '    AND G.GER_NUMDOC = "000000068837"                            ' +
//            '    AND D.DET_CODITE = "17171"                                   ' +
            '    AND G.GER_DTAENT BETWEEN :DTAINI                             ' +
            '    AND :DTAFIM                                                  ';
end;

class function TConsultaST.New: IConsulta;
begin
  Result := Self.Create;
end;

{ TGerarTesteST }

constructor TGerarTesteST.Create;
begin

end;

destructor TGerarTesteST.Destroy;
begin

  inherited;
end;

function TGerarTesteST.fBuscaAbfIcm(ACodigoDoItem, ACodigoAbreviacaoFiscal,
  AEstado, ACodigoDaEmpresaTE, ACodigoDaEmpresa: String): Boolean;
  Var
    qryAbfGen: TUniquery;
    intIndice: Integer;
Begin
  Result := True;

  With cdsAbfIcm Do
  If Not Locate('ITE_CODITE;ABF_CODABF;ABF_ESTADO', VarArrayOf([ACodigoDoItem, ACodigoAbreviacaoFiscal, AEstado]), []) Then
  Begin
    qryAbfGen := fCriaQuery(Nil);

    With qryAbfGen, SQL Do
    Begin
      Close;

      Add(TFunctionFuncoesFaturamento.SqlBuscaAbfIcm(ACodigoDaEmpresaTE, ACodigoDaEmpresa));

      ParamByName('CODITE').AsString := ACodigoDoItem;
      ParamByName('CODABF').AsString := ACodigoAbreviacaoFiscal;
      ParamByName('ESTADO').AsString := AEstado;

      Open;

      Result := Not IsEmpty;

      If Result Then
      Begin
        cdsAbfIcm.Insert;

        For intIndice := 0 To qryAbfGen.Fields.count - 1 Do
          cdsAbfIcm.Fields[intIndice].Value := qryAbfGen.Fields[intIndice].Value;

        cdsAbfIcm.Post;
      End;
    End;

    FreeAndNil(qryAbfGen);
  End;
end;

function TGerarTesteSt.fGerarTesteST(const ADados: OleVariant): Boolean;
var
  LCasosTestesLog: ICasosTestesLog;
  LResultadoCalculoST: IResultadoCalculoST;
  LParametrosResultadoST: IParametrosResultadoST;
  LResultadoComparacao: TResultadoComparacao;
  LDados: TUniClientDataSet;
  LCalculaBeneficioReducaoBaseIcmsST: Boolean;
  LTipoAbfCliente: String;
  LCodigoClienteFilial: String;
  LAtividadeConstrutora: Boolean;
  LCodigoEmpresa: String;
  LCodigoAtividade: String;
  LCodigoAtividadeBD: String;
  LClienteIVAEspecialMT: Boolean;
  LClienteIVAESP: Double;
  LCliIVAEspMT: Double;
  LNotaEEspecialFornecedor: Boolean;
  LDocumentoParaFornecedor: Boolean;
  LTrocaUFEndEntrega: String;
  LVendaPresencial: Boolean;
  LClienteEstadoBD: String;
  LDentroDoEstado: Boolean;
  LDentroDoEstadoFaturamento: Boolean;
  LCalculaSubsTribSimples: Boolean;
  LSimplesNacional: String;
  LUtilizaImportacaoDireta: Boolean;
  LReducaoBaseCalculoImpostosDecreto44498: String;
  LCodigoAbreviacaoEmpresa: String;
  LEstadoEntrega: String;
  LCodigoDaEmpresaTE: String;
  LCodigoDaEmpresa: String;
  LCalcularSTSomenteParaNaoConsumidorFinal: Boolean;
  LUtilizarReducaoDeBaseDeCalculoDeSTNaVenda: Boolean;
  LPercentualMinimoReducaoDeBaseDeCalculoDosImpostos: Double;
  LContribuinteDeIpi: Boolean;
  LUtilizarAmpara: Boolean;
  LInscricaoEstadual: String;
  LRetornaIesUni: String;
  LCodigoAbreviacaoTodasEmpresas: String;
  LCodigoAbreviacaoPorEmpresas: String;
  LTotalGeralItem: Double;
  LTotalGeralItemPreUlt: Double;
  LValorIcmsEstado: Double;
  LUtilizaAmpara: Boolean;
  LAmparaAliquotaFCP: Double;
  LEncontrouAbfIcm: Boolean;
  LCalcSTCliConNCOEspSto: Boolean;
  LCalculaSubTributariaPorDentro: Boolean;
  LValorDoIva: Double;

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
                           // IIF(fEmptyStr(AConsumidor), qryCliente.FieldByName('CONSUM').AsString, AConsumidor),
                           AConsumidor,
                           qryCliente.FieldByName('CODATI').AsString, // GER
                           qryCliente.FieldByName('PRORUR').AsString,
                           qryCliente.FieldByName('MICEMP').AsString,
                           qryCliente.FieldByName('REGTRI').AsString,
                           '',
                           qryCliente.FieldByName('INDUST').AsString,
                           LCodigoClienteFilial,
                           LAtividadeConstrutora);

    FreeAndNil(qryCliente);
  end;

  function TotalGeralItemPreUlt: Double;
  begin
    Result := RetornarBaseCalculoImpostosDecreto44498(LDados, LValorDoIva, LUtilizarReducaoDeBaseDeCalculoDeSTNaVenda);

    if (Result <> -1) then
      Exit;

    If LReducaoBaseCalculoImpostosDecreto44498 = CUSTO_DE_VENDA Then
      Result := LDados.FieldByName(DET_TOTCUS).AsFloat
    Else If LReducaoBaseCalculoImpostosDecreto44498 = CUSTO_DA_ULTIMA_COMPRA Then
      Result := LDados.FieldByName(DET_TOTULT).AsFloat
    Else
      Result := LDados.FieldByName(DET_IMPULT).AsFloat;

    Result := Result - LDados.FieldByName('DET_DESESP').AsFloat + LDados.FieldByName('DET_TOTFRE').AsFloat;
  end;

  function CalculaSubTributariaPorDentro: Boolean;
    Var
      LAbreviacaoFiscalICM : Boolean;
  Begin
    LAbreviacaoFiscalICM :=
      fBuscaAbfIcm(LDados.FieldByName('DET_ITEABF').AsString, LCodigoAbreviacaoEmpresa, LEstadoEntrega, LCodigoDaEmpresaTE,LCodigoDaEmpresa);

    Result :=
      TFunctionFuncoesFaturamento.
        CalculaSubTributariaPorDentro(LTipoAbfCliente,  LAbreviacaoFiscalICM , cdsAbfIcm.FieldByName('ABF_CAL_ST_SAI_CCO').AsString)
  End;

  function fUtilizaAmpara: Boolean;
  var
    LItemAmpara: Boolean;
  begin
    LItemAmpara := TFunctionFuncoesFaturamento.ItemAmpara(LDados.FieldByName('ITE_UTIAMP').AsString);

    Result :=  TFunctionFuncoesFaturamento.UtilizaAmpara(LDados.FieldByName('DET_ESTADO').AsString, LItemAmpara);
  end;

begin
  Result := True;

  LCalcularSTSomenteParaNaoConsumidorFinal := fGetValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOMENTE_PARA_NAO_CONSUMIDOR_FINAL, varBoolean);
  LUtilizaImportacaoDireta := fGetValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, varBoolean);
  LUtilizarReducaoDeBaseDeCalculoDeSTNaVenda := fGetValorConfiguracao(CFG_UTILIZAR_REDUCAO_BASE_CALCULO_SUBSTITUICAO_TRIBUTARIA_NA_VENDA, varBoolean);
  LPercentualMinimoReducaoDeBaseDeCalculoDosImpostos := fGetValorConfiguracao(CFG_PERCENTUAL_MINIMO_DECRETO_44498_2013_REDUCAO_BASE_CALCULO_IMPOSTOS, varDouble);
  LContribuinteDeIpi := fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean);
  LSimplesNacional := fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, varString);
  LReducaoBaseCalculoImpostosDecreto44498 := fGetValorConfiguracao(CFG_CAMPO_PRECO_DECRETO_44498_2013_REDUCAO_BASE_CALCULO_IMPOSTOS, varString);

  LCasosTestesLog := TCasosTestesLog.New();
  LDados := TUniClientDataSet.Create(Nil);

  Try
    LDados.Data := ADados;
    LDados.Open;
    LDados.First;

    Try
      pCriaClientAbf;
      pAbreClientAbf('', LDados.FieldByName('DET_CODEMP').AsString);

      While Not LDados.Eof Do
      Begin
        if (ValidarPararProcessamento) then
          Break;

        frmModulo.IncrementarRegistrosProcessados;

        pExecutarProgresso(LDados.RecordCount, LDados.RecNo);

        pInicializarObjetoCliente(LDados);

        LVendaPresencial := LDados.FieldByName('AUX_VENPRE').AsString = 'S';

        LNotaEEspecialFornecedor :=
          ((LDados.FieldByName('AUX_OPCDOC').AsString = 'NE') And
            (LDados.FieldByName('DET_TIP_FC').AsString = 'F'));

        LDocumentoParaFornecedor :=
          TFunctionFuncoesFaturamento.
            fDocumentoParaFornecedor(LDados.FieldByName('AUX_OPCDOC').AsString,
                                     LDados.FieldByName('AUX_OPCDOC').AsString = 'OF', // blnNCFornecedor
                                     LNotaEEspecialFornecedor,
                                     LDados.FieldByName('AUX_OPCDOC').AsString = 'IN',
                                     LDados.FieldByName('DET_CODCLI').AsString,
                                     LDados.FieldByName('DET_CODFOR').AsString);

        LClienteEstadoBD := LDados.FieldByName('CID_ESTADO_EMPRESA').AsString;

        LTrocaUFEndEntrega := LDados.FieldByName('DET_ESTADO').AsString;

        LDentroDoEstado :=
          TFunctionFuncoesFaturamento.fDentroDoEstado(LTrocaUFEndEntrega, LClienteEstadoBD);

        LDentroDoEstadoFaturamento :=
          TFunctionFuncoesFaturamento.
            fDentroDoEstadoFaturamento(LDentroDoEstado, LVendaPresencial);

        LCodigoAtividade := LDados.FieldByName('CLI_CODATI').AsString;

        LCodigoAtividadeBD :=
            fCampoTabela('ATI_CODATI', 'CLIATI', ['ATI_CODATI', 'ATI_CODEMP'], [LCodigoAtividade, LDados.FieldByName('DET_CODEMP').AsString], False);

        LAtividadeConstrutora :=
          TFunctionFuncoesFaturamento.
            fAtividadeConstrutora(LCodigoAtividade,
                                  LCodigoAtividadeBD);

        LTipoAbfCliente :=
          fGetTipoAbfCliente(LDados.FieldByName('DET_CODCLI').AsString,
                             LDados.FieldByName('GER_CONSUM').AsString,
                             LDados.FieldByName('GER_IESCON').AsString);

        LInscricaoEstadual := LDados.FieldByName('CLI_IESUNI').AsString;

        LRetornaIesUni := TFunctionFuncoesFaturamento.fRetornaIesUni(LInscricaoEstadual);

        LParametrosResultadoST :=
          TParametrosResultadoST.New()
            .BaseDeCalculoDaSubstituicaoTributariaDoItem(LDados.FieldByName('DET_BASRET').AsFloat)
            .ValorDaSubstituicaoTributariaDoItem(LDados.FieldByName('DET_VALRET').AsFloat)
            .PercentualDoFCPDoItem(LDados.FieldByName('DET_PFCPST').AsFloat)
            .ValorDoFCPDoItem(LDados.FieldByName('DET_VFCPST').AsFloat);


        LCodigoAbreviacaoTodasEmpresas :=
          fCampoTabela('ITE_CODABF', 'CADITE', ['ITE_CODITE'], [LDados.FieldByName('DET_CODITE').AsString], False);

        LCodigoAbreviacaoPorEmpresas   :=
          fCampoTabela('ITE_CODABF','ITEGER',['ITE_CODITE', 'ITE_CODEMP'],
            [LDados.FieldByName('DET_CODITE').AsString,
            LDados.FieldByName('DET_CODEMP').AsString], False);

        LCodigoAbreviacaoEmpresa :=
          TFunctionFuncoesFaturamento.
            fGetCodAbf(LCodigoAbreviacaoTodasEmpresas,
                       LCodigoAbreviacaoPorEmpresas);

        LEstadoEntrega :=
          RetornarEstadoEntrega(LDados.FieldByName('ETC_CIDENT').AsString,
                                LDados.FieldByName('DET_ESTADO').AsString);

        LCodigoDaEmpresaTE :=
          IIF(fEmptyStr(LDados.FieldByName('FGO_EMP_TE').AsString),
            LDados.FieldByName('DET_CODEMP').AsString,
              LDados.FieldByName('FGO_EMP_TE').AsString);

        LCodigoDaEmpresa := LDados.FieldByName('DET_CODEMP').AsString;

        LValorDoIva := 0;
        If LDados.FieldByName('DET_VALIVA').AsFloat > 0 Then
          LValorDoIva := ((LDados.FieldByName('DET_VALIVA').AsFloat / 100) + 1);

        LCalculaBeneficioReducaoBaseIcmsST :=
          TFunctionFuncoesFaturamento.
            fCalcBeneficioReducaoBaseIcmsST(LTipoAbfCliente, LDados.FieldByName('DET_CODFIS').AsString, LDentroDoEstadoFaturamento);

        LTotalGeralItem := LDados.FieldByName('DET_TOTITE').AsFloat - LDados.FieldByName('DET_DESESP').AsFloat + LDados.FieldByName('DET_TOTFRE').AsFloat;
        LTotalGeralItemPreUlt := TotalGeralItemPreUlt;

        LValorIcmsEstado := objFloatUtils.fFormataFloat((((LTotalGeralItem * LDados.FieldByName('DET_PERBAS').AsFloat) / 100) * LDados.FieldByName('DET_ALQICM').AsFloat) / 100, 2);  //tem que isolor ?
        LUtilizaAmpara := fUtilizaAmpara;  //tem que isolor ?

        LAmparaAliquotaFCP := LDados.FieldByName('DET_PFCPST').AsFloat;
        LEncontrouAbfIcm := LAmparaAliquotaFCP > 0;

        LClienteIVAESP := fCampoTabela('CLI_IVAESP', 'CADCLI', ['CLI_CODCLI'], [LDados.FieldByName('DET_CODCLI').AsString], False);

        LCliIVAEspMT :=
          TFunctionFuncoesFaturamento.
            GetCliIVAEspMT(LDocumentoParaFornecedor, LDados.FieldByName('GER_IESCON').AsString, LDados.FieldByName('DET_ESTADO').AsString, LClienteIVAESP);

        LClienteIVAEspecialMT :=
          TFunctionFuncoesFaturamento.
            ClienteIVAEspecialMT(LDados.FieldByName('DET_ESTADO').AsString, LDados.FieldByName('CID_ESTADO_EMPRESA').AsString, LCliIVAEspMT);

        LCalculaSubsTribSimples := TFunctionFuncoesFaturamento.CalculaSubsTribSimples;

        LCalcSTCliConNCOEspSto :=
          TFunctionFuncoesFaturamento.
            CalcSTCliConNCOEspSto(LDados.FieldByName('CID_ESTADO_EMPRESA').AsString,
                                  LTipoAbfCliente,
                                  (LDados.FieldByName('GER_CONSUM').AsString = 'S'),
                                  LDentroDoEstadoFaturamento,
                                  (LDados.FieldByName('ITE_IMPDIR').AsString = 'S'),
                                  LDados.FieldByName('DET_CODFIS').AsString);

        LCalculaSubTributariaPorDentro := CalculaSubTributariaPorDentro;


        LResultadoCalculoST :=
          CalcularValorST(
            TParametrosCalculoST.New
              .VendaDentroDoEstado(LDentroDoEstadoFaturamento)
              .SubstituicaoTributariaDoItem(Pos(LDados.FieldByName('DET_CODFIS').AsString, objConstantes.fGetCstSubstituicao) > 0)
              .CalculaSubstituicaoTributariaSimples(LCalculaSubsTribSimples)
              .CalcularSTSomenteParaNaoConsumidorFinal(LCalcularSTSomenteParaNaoConsumidorFinal)
              .ClienteConsumidor(LDados.FieldByName('GER_CONSUM').AsString = 'S')
              .CalculaSTClienteConsumidorNCOEspiritoSanto(LCalcSTCliConNCOEspSto)
              .UtilizaImportacaoDireta(LUtilizaImportacaoDireta)
              .ItemImportacaoDireta(LDados.FieldByName('ITE_IMPDIR').AsString = 'S')
              .CalculaBeneficioReducaoBaseIcmsST(LCalculaBeneficioReducaoBaseIcmsST)
              .SimplesNacional(LSimplesNacional = 'S')
              .ValorDoIcmsDoItem(LDados.FieldByName('DET_VALICM').AsFloat)
              .ValorDoIcmsDoEstado(LValorIcmsEstado)
              .AliquotaDaSubstituicaoTributariaDoItem(LDados.FieldByName('DET_ALQRET').AsFloat)
              .ValorDoIpiDoItem(LDados.FieldByName('DET_VALIPI').AsFloat)
              .ValorDoIva(LValorDoIva)
              .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(LUtilizarReducaoDeBaseDeCalculoDeSTNaVenda)
              .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(LPercentualMinimoReducaoDeBaseDeCalculoDosImpostos)
              .PercentualDaBaseDeCalculoDaSTDoItem(LDados.FieldByName('DET_PEBAST').AsFloat)
              .TotalGeralDoItemPreUlt(LTotalGeralItemPreUlt)
              .TotalGeralDoItem(LTotalGeralItem)
              .UtilizaAmpara(LUtilizaAmpara)  //ampara
              .EncontrouAbreviacaoDeIcms(LEncontrouAbfIcm) //ampara
              .AmparaAliquotaFCP(LAmparaAliquotaFCP)  //ampara
              .TipoDeAbreviacaoFiscal(LTipoAbfCliente)
              .PercentualDoFCPDoItem(LDados.FieldByName('DET_PFCPST').AsFloat) //Valor para iniciar variavel de retorno DifalFCP/Ampara
              .ValorDoFCPDoItem(LDados.FieldByName('DET_VFCPST').AsFloat) //Valor para iniciar variavel de retorno DifalFCP/Ampara
              .CalculaSubstituicaoTributariaPorDentro(LCalculaSubTributariaPorDentro)
              .ContribuinteDeIpi(LContribuinteDeIpi)
              .ClienteIVAEspecialMT(LClienteIVAEspecialMT)
              .AliquotaDeIcmsDoItem(LDados.FieldByName('DET_ALQICM').AsFloat),
              LParametrosResultadoST
          );

        LResultadoComparacao := rcoFalse;

        if (CompararValores(LResultadoCalculoST.BaseDeCalculoDaSubstituicaoTributariaDoItem, LDados.FieldByName('DET_BASRET').AsFloat) And
            CompararValores(LResultadoCalculoST.ValorDaSubstituicaoTributariaDoItem, LDados.FieldByName('DET_VALRET').AsFloat) And
            CompararValores(LResultadoCalculoST.PercentualDoFCPDoItem, LDados.FieldByName('DET_PFCPST').AsFloat) And
            CompararValores(LResultadoCalculoST.ValorDoFCPDoItem, LDados.FieldByName('DET_VFCPST').AsFloat)) then
        begin
          LResultadoComparacao := rcoTrue;
        end;

        if not (ValidarSePodeAdicionarLog(LResultadoComparacao, LDados.FieldByName('DET_ESPDOC').AsString)) then
          LResultadoComparacao := rcoIgnorado;

        LCasosTestesLog.Add(
          TParametrosCasosTestesLog.New()
            .ResultadoComparacao(LResultadoComparacao)
            .RetornarNomeOperacao('CALCULO_ST_')
            .NumeroDoDocumento(LDados.FieldByName('DET_NUMDOC').AsString)
            .EspecieDoDocumento(LDados.FieldByName('DET_ESPDOC').AsString)
            .CodigoDaEmpresa(LDados.FieldByName('DET_CODEMP').AsString)
            .CodigoDoItem(LDados.FieldByName('DET_CODITE').AsString)
            .CodigoDoCliente(LDados.FieldByName('DET_CODCLI').AsString)
            .OpcaoDocumento(LDados.FieldByName('AUX_OPCDOC').AsString)
            .DataEntrada(LDados.FieldByName('DET_DTAENT').AsDateTime)
            .Log(fGetVariavelLogST));

        pLimparVariaveisTesteUnitario;

        LDados.Next;
      End;

      LCasosTestesLog.GerarLog('ST');

    Except
      On E : Exception do
        ShowMessage('Documento:'+ LDados.FieldByName('DET_NUMDOC').AsString +
                    '| Especie:'+ LDados.FieldByName('DET_ESPDOC').AsString +
                    '| Item:'+ LDados.FieldByName('DET_CODITE').AsString +
                    '| Empresa:'+ LDados.FieldByName('DET_CODEMP').AsString + #13#10 + E.Message);
    End;
  Finally
    FreeAndNil(LDados);
    FreeAndNil(cdsAbfIcm);
    FreeAndNil(dspAbfIcm);
    FreeAndNil(qryAbfIcm);
  End;
end;

class function TGerarTesteST.New: IGerarTeste;
begin
  Result := Self.Create;
end;

procedure TGerarTesteST.pAbreClientAbf(ACodigoDaEmpresaTE,
  ACodigoDaEmpresa: String);
begin
  With qryAbfIcm, SQL Do
  Begin
    Close;
    cdsAbfIcm.Close;

    Clear;
    Add(TFunctionFuncoesFaturamento.SqlAbfIcm(ACodigoDaEmpresaTE, ACodigoDaEmpresa));

    Add('WHERE ');
    Add(' FALSE ');

    Open;

    pSetaClient(qryAbfIcm);

    cdsAbfIcm.SetProvider(dspAbfIcm);
    cdsAbfIcm.Open;
  End;
end;

procedure TGerarTesteST.pCriaClientAbf;
begin
  dspAbfIcm := TUniDataSetProvider.Create(Nil);
  cdsAbfIcm := TUniClientDataSet.Create(Nil);
  qryAbfIcm := fCriaQuery(Nil);
  dspAbfIcm.DataSet := qryAbfIcm;
  cdsAbfIcm.SetProvider(dspAbfIcm);
end;

procedure TGerarTesteST.pInicializarObjetoCliente(const ADados: TUniClientDataSet);
begin
  SetObjCliente(
    TModelCliente.New()
      .ClienteZonaFranca(ADados.FieldByName('CLI_ZONFRA').AsString = 'S')
      .CalcularDescontoIcmsOrgaoPublico(ADados.FieldByName('CLI_CALICM').AsString = 'S')
      .ClienteOrgaoPublico(ADados.FieldByName('CLI_ORGPUB').AsString = 'S')
      .ClienteConsumidorFinal(ADados.FieldByName('GER_CONSUM').AsString = 'S'));
end;

function TGerarTesteST.RetornarEstadoEntrega(const ACodigoCidadeEntrega,
  AEstadoDoDocumento: string): String;
begin
  Result := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [ACodigoCidadeEntrega], False);

  If (not fEmptyStr(result)) Then
    Exit;

  Result := AEstadoDoDocumento;
end;

function TGerarTesteST.ValidarSePodeAdicionarLog(
  const AResultadoComparacao: TResultadoComparacao; const AEspecieDocumento: string): boolean;
const
  TROCA = 'TR';
begin
  result := True;

  if (AResultadoComparacao = rcoTrue) then
    Exit;

  if (AEspecieDocumento <> TROCA) then
    Exit;

  result := False;
end;

function TGerarTesteST.ValidarBaseCalculoImpostosDecreto44498(const ADados: TUniClientDataSet; const AValorDoIva: double; const AUtilizarReducaoDeBaseDeCalculoDeSTNaVenda: boolean; const ANomeCampo: string): Boolean;
var
  LValorBase: double;
begin
  LValorBase := (ADados.FieldByName(ANomeCampo).AsFloat + ADados.FieldByName('DET_VALIPI').AsFloat);
  LValorBase := objFloatUtils.fFormataFloat((LValorBase * AValorDoIva),2);
  LValorBase := objFloatUtils.fFormataFloat(((LValorBase * objFloatUtils.IfThen(AUtilizarReducaoDeBaseDeCalculoDeSTNaVenda, ADados.FieldByName('DET_PEBAST').AsFloat, 100)) / 100), 2);
  result := CompararValores(LValorBase, ADados.FieldByName('DET_BASRET').AsFloat);
end;

function TGerarTesteST.RetornarBaseCalculoImpostosDecreto44498(const ADados: TUniClientDataSet; const AValorDoIva: double; const AUtilizarReducaoDeBaseDeCalculoDeSTNaVenda: boolean): double;
begin
  result := -1;

  if (ValidarBaseCalculoImpostosDecreto44498(ADados, AValorDoIva, AUtilizarReducaoDeBaseDeCalculoDeSTNaVenda, DET_TOTCUS)) then
  begin
    result := ADados.FieldByName(DET_TOTCUS).AsFloat;
    exit;
  end;

  if (ValidarBaseCalculoImpostosDecreto44498(ADados, AValorDoIva, AUtilizarReducaoDeBaseDeCalculoDeSTNaVenda, DET_TOTULT)) then
  begin
    result := ADados.FieldByName(DET_TOTULT).AsFloat;
    exit;
  end;

  if (ValidarBaseCalculoImpostosDecreto44498(ADados, AValorDoIva, AUtilizarReducaoDeBaseDeCalculoDeSTNaVenda, DET_IMPULT)) then
  begin
    result := ADados.FieldByName(DET_IMPULT).AsFloat;
    exit;
  end;
end;

end.
