unit untClasseDifal;

interface

Uses
  Forms,
  untAbstractConsulta, untIConsulta,
  untAbstractGerarTeste,
  untFuncoes,
  untIGerarTeste,
  Uni,
  Data.DB,
  Shared.Functions.Funcoes.Faturamento,
  Shared.Functions.Configuracoes,
  Shared.Functions.Constantes,
  Shared.Functions.Types,
  untFatRegrasImpostos, untCasosTestesLog,
  untCasosTestesLogImpl, System.SysUtils,
  System.StrUtils, Vcl.Dialogs,
  Faturamento.Impostos.Tipos.Model,
  untICasosTestesLog,
  Faturamento.Impostos.Interfaces.Difal,
  Faturamento.Impostos.Tipos.Difal,
  Faturamento.Impostos.Interfaces.FCP,
  Faturamento.Impostos.Tipos.FCP,
  Faturamento.Impostos.Calculos.TesteUnitarioLog,
  Faturamento.Impostos.Interfaces.Model,
  untParametrosResultadoDifal, untFatCalcularImpostos, UniClientDataSet,
  System.Variants, UniDataSetProvider, untTypes;

Type
  TConsultaDifal = class(TAbstractConsulta)

  public
    Class function New : IConsulta;
    function fRetornarSQLDifal : String; override;
  end;

Type
  TGerarTesteDifal = class(TAbstractGerarTeste)
  private
    cdsAbfIcm: TUniClientDataSet;
    dspAbfIcm: TUniDataSetProvider;
    qryAbfIcm: TUniQuery;
    FQtdeRegistrosDifalIgnorados: integer;
    FQtdeRegistrosFcpDifalIgnorados: integer;

    function fBuscaAbfIcm(ACodigoDoItem, ACodigoAbreviacaoFiscal,
      AEstado, ACodigoDaEmpresaTE, ACodigoDaEmpresa: String): Boolean;

    procedure pAbreClientAbf(ACodigoDaEmpresaTE, ACodigoDaEmpresa: String);
    procedure pCriaClientAbf;
    function ValidarResultadosDifalCamposComuns(const AResultadoCalculoDifal: IResultadoCalculoDifal; const ADados: TUniClientDataSet;
      const AAliquotaDifalDoItem: double): boolean;
    function ValidarResultadosDifal(const AResultadoCalculoDifal: IResultadoCalculoDifal; const ADados: TUniClientDataSet;
      const AAliquotaDifalDoItem: double): boolean;
    function ValidarResultadosDifalDevolucao(const AResultadoCalculoDifal: IResultadoCalculoDifal; const ADados: TUniClientDataSet): boolean;
    function ValidarResultadosDifalVenda(const AResultadoCalculoDifal: IResultadoCalculoDifal; const ADados: TUniClientDataSet): boolean;
    function ValidarResultadosFCPDifal(
      const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP;
      const ADados: TUniClientDataSet; const AAliquotaDifalDoItem: double): boolean;
    function ValidarResultadosFCPDifalCamposComuns(
      const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP;
      const ADados: TUniClientDataSet; const AAliquotaDifalDoItem: double): boolean;
    function ValidarResultadosFCPDifalDevolucao(
      const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP;
      const ADados: TUniClientDataSet): boolean;
    function ValidarResultadosFCPDifalVenda(
      const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP;
      const ADados: TUniClientDataSet): boolean;
    function RetornarEstadoEntrega(const ACodigoCidadeEntrega, AEstadoDoDocumento: string): String;
    function ValidarDataValidaDoDocumentoOriginalDaDevolucaoHidromar(
      const AOpcaoDocumento: string;
      const ADataDocOriginal: TDate): boolean;
    procedure AdicionarCasosTestesLogDifal(const ACasosTestesLogDifal: ICasosTestesLog; const ADados: TUniClientDataSet;
      const AResultadoComparacao: TResultadoComparacao);
    procedure AdicionarCasosTestesLogFcp(
      const ACasosTestesLogFcp: ICasosTestesLog; const ADados: TUniClientDataSet;
      const AResultadoComparacao: TResultadoComparacao);

    function AjustarValoresOrigem(const AOpcaoDocumento: string; const AValorOrigem, AValorDestino: double): double;
    function AjustarValoresDestino(const AOpcaoDocumento: string; const AValorOrigem, AValorDestino: double): double;
    //function RetornarPercentualPartilha(const ADados: TUniQuery): double;
    //function RetornarPercentualPartilhaDocumentoOriginal(
    //  const ADados: TUniQuery): double;
    //function CarregarDadosPercentualPartilhaDocumentoOriginal(
    //  const ADados: TUniQuery): TUniQuery;
    //function RetornarSQLDadosPercentualPartilhaDocumentoOriginal: string;
  public
    Class function New : IGerarTeste;

    Constructor Create;
    Destructor Destroy; override;

    function fGerarTesteDifal(const ADados: OleVariant) : Boolean; override;
  end;


implementation

uses
  untModulo;

{ TConsultaDifal }

function TConsultaDifal.fRetornarSQLDifal: String;
Var
  LSql : String;
begin
  LSql := 'SELECT '+
          '  G.GER_IESCON,   '+
          '  DET.DET_CODEMP, '+
          '  DET.DET_NUMDOC, '+
          '  DET.DET_ESPDOC, '+
          '  DET.DET_CODFIS, '+
          '  DET.DET_DTAENT, '+
          '  DET.DET_CODCLI, '+
          '  DET.DET_CODITE, '+
          '  DET.DET_ESTADO, '+
          '  DET.DET_VALIPI, '+
          '  DET.DET_TOTFRE, '+
          '  DET.DET_BASRET, '+
          '  DET.DET_CODFOR, '+
          '  DET.DET_CLAFIS, '+
          '  IFNULL(CLI_IESUNI, "N") AS CLI_IESUNI, '+
          '  CLI_PRORUR, '+
          '  CLI_CODATI, '+
          '  AUX_OPCDOC, ' +
          '  IFNULL(G.GER_CONSUM, "N") AS GER_CONSUM, '+
          '  T.DET_ITEABF, '+
          '  ETC_CIDENT, '+
          '  DET_BASICM, '+
          '  DET_TOTITE, '+
          '  DET_DESESP, '+
          '  DET_DESACE, '+
          '  DET_PERBAS, '+
          '  EX.FGO_EMP_TE, '+
          '  ICD_BCUFDE, '+
          '  ICD_VALDES, '+
          '  ICD_VALORI, '+
          '  ICD_VALFCP, '+
          '  ICD_BASFCP, '+
          '  ICD_ALQUFD, '+
          '  ICD_ALQINE, '+
          '  ICD_PERPAR, '+
          '  AUXMOV.AUX_VENPRE, ' +
          '  CADCID.CID_ESTADO AS ESTADO_EMPRESA, '+
          '  DV.GER_DTAENT AS GER_DTAENT_DOCORI,  '+
          '  DET.DET_DOCDEV,  '+
          '  DET.DET_ESPDEV,  '+
          '  DET.DET_EMPDEV,  '+
          '  ICD_PERFCP       '+
          ' FROM '+
          '  MOVGER G ' +
          '  JOIN MOVDET DET    ON DET.DET_SEQGER = G.AUTOINCREM ' +
          '  INNER JOIN CADITE C  ON C.ITE_CODITE = DET_CODITE '+
          '  LEFT JOIN ITEGER I  ON I.ITE_CODITE = DET_CODITE '+
          '                    AND I.ITE_CODEMP = DET_CODEMP '+
          '  LEFT JOIN MOVICD    ON ICD_SEQGER   = DET.AUTOINCREM '+
          '  LEFT JOIN MOVTRI T  ON T.DET_SEQGER = DET.AUTOINCREM '+

          '  LEFT JOIN CADCLI ON CLI_CODCLI = DET.DET_CODCLI '+
          '  JOIN CADEMP      ON EMP_CODEMP = DET.DET_CODEMP '+
          '  JOIN CADCID      ON CID_CODCID = EMP_CODCID '+

          '  LEFT JOIN FATDOR ON FATDOR.FDO_NUMDOC = DET.DET_NUM_PD '+
          '                  AND FATDOR.FDO_ESPDOC = DET.DET_ESP_PD '+
          '                  AND FATDOR.FDO_CODEMP = DET.DET_EMP_PD '+
          '                  AND FATDOR.FDO_CODITE = DET.DET_CODITE '+
          '  LEFT JOIN FATGOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER '+
          '  LEFT JOIN EXTGOR EX  ON EX.FGO_SEQFGO = FATGOR.AUTOINCREM '+
          '  LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = DET.DET_SEQGER '+
          '  LEFT JOIN ENTCLI ON ETC_CODCLI = DET.DET_CODCLI '+
          '                  AND IF( AUXMOV.AUX_ENTGER IS NOT NULL, '+
          '                   ENTCLI.AUTOINCREM = AUXMOV.AUX_ENTGER, '+
          '                   ETC_SEQIND = '+
          '                     (SELECT '+
          '                        MIN(ETC_SEQIND) '+
          '                     FROM '+
          '                       ENTCLI '+
          '                     WHERE ETC_CODCLI = DET_CODCLI))        '+
          '  LEFT JOIN MOVGER DV ON DV.GER_NUMDOC = DET.DET_DOCDEV AND '+
          '                         DV.GER_ESPDOC = DET.DET_ESPDEV AND '+
          '                         DV.GER_CODEMP = DET.DET_EMPDEV     '+
          ' WHERE DET_CODEMP = :CODEMP ' +
          '   AND DET_ESPDOC <> "TR"   '+
          '   AND DET_DTAENT BETWEEN :DTAINI '+
          '                      AND :DTAFIM ';

 LSql := LSql + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(LSql,'MOVDET','NOTDET'),'MOVICD','NOTICD'),'MOVGER','NOTGER');

 Result := LSql;
end;

class function TConsultaDifal.New: IConsulta;
begin
  Result := Self.Create;
end;

{ TGerarTesteDifal }

constructor TGerarTesteDifal.Create;
begin
  FQtdeRegistrosDifalIgnorados := 0;
  FQtdeRegistrosFcpDifalIgnorados := 0;
end;

destructor TGerarTesteDifal.Destroy;
begin

  inherited;
end;

function TGerarTesteDifal.fBuscaAbfIcm(ACodigoDoItem, ACodigoAbreviacaoFiscal,
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

function TGerarTesteDifal.fGerarTesteDifal(const ADados: OleVariant): Boolean;
Var
  LResultadoCalculoDifal        : IResultadoCalculoDifal;
  LResultadoCalculoDifalFcp     : IResultadoCalculoDifalFCP;

  LParametrosResultadoDifal     : IParametrosResultadoDifal;
  LParametrosResultadoDifalFcp  : IParametrosResutladoDifalFCP;

  LResultadoComparacao          : TResultadoComparacao;

  LCasosTestesLogDifal          : ICasosTestesLog;
  LCasosTestesLogFcp            : ICasosTestesLog;
  LEhProdutoSubstituido         : Boolean;
  LPercentualProvisorioPartilha : Double;
  LSimplesNacional              : Boolean;
  LRecordDifalFCP               : TRecDifalFCP;
  LCodigoDaEmpresaTE            : String;
  LCodigoDaEmpresa              : String;
  LAbreviacaoIcmsProduto        : Boolean;
  LCodigoClienteFilial          : String;
  LAtividadeConstrutora         : Boolean;
  LTipoAbfCliente               : String;
  LEstadoEntrega                : String;
  LAliquotaEfetivaOrigem        : Double;
  LAbreviacaoIcmsProdutoUfEmpresa: Boolean;
  LPercentualBaseOrigem         : Double;
  LTipoDeAbreviacaoFiscal       : String;
  LPerBasDifalOrigem            : Double;
  LPerBasDifalDestino           : Double;
  LCalculaAliquotaInterestadual : Double;
  LAliquotaInternaEstadoDestino : Double;
  LCodigoDaSituacaoTributaria   : String;
  LCodigoAbreviacaoTodasEmpresas: String;
  LCodigoAbreviacaoPorEmpresas  : String;
  LCodigoAbreviacaoEmpresa      : String;
  //LAliquotaFCP                  : Double;
  LClientesFiliais              : String;
  LEhClienteFilial              : Boolean;
  LNotaEEspecialFornecedor      : Boolean;
  LDocumentoParaFornecedor      : Boolean;
  LDentroDoEstado               : Boolean;
  LDentroDoEstadoFaturamento    : Boolean;
  LEhProdutorRural              : Boolean;
  LCodigoAtividadeBD            : String;
  LCodigoAtividade              : String;
  LRetornaIesUni                : String;
  LInscricaoEstadual            : String;
  LAliquotaDifalDoItem          : Double;
  LDados                        : TUniClientDataSet;


  function fGetTipoAbfCliente(const strCodCli: String; strConsum: String =''): String;
    Var
      qryCliente: TUniQuery;
  begin
    qryCliente := fCriaQuery;

    qryCliente.SQL.Text := TFunctionFuncoesFaturamento.fGetSelectTipoAbfCliente;
    qryCliente.ParamByName('CODCLI').AsString := strCodCli;
    qryCliente.Open;


    Result :=
      TFunctionFuncoesFaturamento.
        fGetTipoAbfCliente(strCodCli, qryCliente.FieldByName('FISJUR').AsString,
          qryCliente.FieldByName('I_E_S_').AsString, IIF(fEmptyStr(strConsum),
          qryCliente.FieldByName('CONSUM').AsString, strConsum), qryCliente.FieldByName('CODATI').AsString,
          qryCliente.FieldByName('PRORUR').AsString, qryCliente.FieldByName('MICEMP').AsString,
          qryCliente.FieldByName('REGTRI').AsString, '', qryCliente.FieldByName('INDUST').AsString,
          LCodigoClienteFilial, LAtividadeConstrutora);

    FreeAndNil(qryCliente);
  end;
Begin
  LClientesFiliais := fCampoTabela('GROUP_CONCAT(EMP_CLIFIL)', 'CADEMP', [], [], False, '', Nil);

  Result := True;

  LCasosTestesLogDifal := TCasosTestesLog.New();
  LCasosTestesLogFcp   := TCasosTestesLog.New();
  LDados := TUniClientDataSet.Create(Nil);

  Try
    LDados.Data := ADados;
    LDados.Open;
    LDados.First;

    Try
      LSimplesNacional := (fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL) = 'S');

      pCriaClientAbf;
      pAbreClientAbf('', LDados.FieldByName('DET_CODEMP').AsString);

      While Not LDados.Eof Do
      Begin
        if (ValidarPararProcessamento) then
          Break;

        frmModulo.IncrementarRegistrosProcessados;

        pExecutarProgresso(LDados.RecordCount, LDados.RecNo);

        LTipoAbfCliente := fGetTipoAbfCliente(LDados.FieldByName('DET_CODCLI').AsString);

        LEhClienteFilial := ValidarClienteFilial(LDados.FieldByName('DET_CODCLI').AsString, LClientesFiliais);


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

        LDentroDoEstado :=
          TFunctionFuncoesFaturamento.
            fDentroDoEstado(LDados.FieldByName('DET_ESTADO').AsString,
                            LDados.FieldByName('ESTADO_EMPRESA').AsString);

        LDentroDoEstadoFaturamento :=
          TFunctionFuncoesFaturamento.
            fDentroDoEstadoFaturamento(LDentroDoEstado,
                                       LDados.FieldByName('AUX_VENPRE').AsString = 'S');

        LEhProdutorRural :=
          TFunctionFuncoesFaturamento.
            fEhProdutorRural(LDados.FieldByName('CLI_PRORUR').AsString);

        LCodigoAtividade := LDados.FieldByName('CLI_CODATI').AsString;

        LCodigoAtividadeBD :=
            fCampoTabela('ATI_CODATI', 'CLIATI', ['ATI_CODATI', 'ATI_CODEMP'], [LCodigoAtividade, LDados.FieldByName('DET_CODEMP').AsString], False);

        LAtividadeConstrutora :=
          TFunctionFuncoesFaturamento.
            fAtividadeConstrutora(LCodigoAtividade,
                                  LCodigoAtividadeBD);

        LInscricaoEstadual := LDados.FieldByName('CLI_IESUNI').AsString;

        LRetornaIesUni := TFunctionFuncoesFaturamento.fRetornaIesUni(LInscricaoEstadual);

        If Not TFunctionFuncoesFaturamento.
                    fAtendeRegrasDifal(
                      LDados.FieldByName('GER_IESCON').AsString,
                      LDados.FieldByName('AUX_VENPRE').AsString = 'S',
                      LDados.FieldByName('GER_CONSUM').AsString = 'S',
                      LDocumentoParaFornecedor,
                      LDentroDoEstadoFaturamento,
                      LEhClienteFilial,
                      LDados.FieldByName('AUX_OPCDOC').AsString,
                      LEhProdutorRural,
                      LRetornaIesUni,
                      LAtividadeConstrutora,
                      LTipoAbfCliente) Then
        begin
          Inc(FQtdeRegistrosDifalIgnorados);
          Inc(FQtdeRegistrosFcpDifalIgnorados);
          frmModulo.IncrementarRegistrosProcessadosIgnorados;
          LDados.Next;
          Continue;
        end;

        LAliquotaDifalDoItem := (LDados.FieldByName('ICD_ALQUFD').AsFloat - LDados.FieldByName('ICD_ALQINE').AsFloat);

        LRecordDifalFCP.fltAlDifa := LAliquotaDifalDoItem;
        LRecordDifalFCP.fltDifDes := AjustarValoresDestino(LDados.FieldByName('AUX_OPCDOC').AsString, LDados.FieldByName('ICD_VALORI').AsFloat, LDados.FieldByName('ICD_VALDES').AsFloat);
        LRecordDifalFCP.fltDifOri := AjustarValoresOrigem(LDados.FieldByName('AUX_OPCDOC').AsString, LDados.FieldByName('ICD_VALORI').AsFloat, LDados.FieldByName('ICD_VALDES').AsFloat);
        LRecordDifalFCP.fltAlqIne := LDados.FieldByName('ICD_ALQINE').AsFloat;
        LRecordDifalFCP.fltAlqUfd := LDados.FieldByName('ICD_ALQUFD').AsFloat;
        LRecordDifalFCP.fltBcuFde := LDados.FieldByName('ICD_BCUFDE').AsFloat;
        LRecordDifalFCP.fltPerPar := LDados.FieldByName('ICD_PERPAR').AsFloat;


        LParametrosResultadoDifal :=
          TParametrosResultadoDifal.New()
            .ValorBaseDestino(LDados.FieldByName('ICD_BCUFDE').AsFloat)
            .ValorIcmsDestino(AjustarValoresDestino(LDados.FieldByName('AUX_OPCDOC').AsString, LDados.FieldByName('ICD_VALORI').AsFloat, LDados.FieldByName('ICD_VALDES').AsFloat))
            .ValorIcmsOrigem(AjustarValoresOrigem(LDados.FieldByName('AUX_OPCDOC').AsString, LDados.FieldByName('ICD_VALORI').AsFloat, LDados.FieldByName('ICD_VALDES').AsFloat))
            .AliquotaInterestadualCalc(LDados.FieldByName('ICD_ALQINE').AsFloat)
            .RecordDifalFCP(LRecordDifalFCP);

        LEhProdutoSubstituido :=
          TFunctionFuncoesFaturamento.
            ProdutoSubstituidoFaturamento(LDados.FieldByName('DET_CODFIS').AsString);

        LPercentualProvisorioPartilha := LDados.FieldByName('ICD_PERPAR').AsFloat;

        If (LDados.FieldByName('DET_CODCLI').AsString <> EmptyStr) Then
          LCodigoClienteFilial := fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_CLIFIL'], [LDados.FieldByName('DET_CODCLI').AsString], False);

        LEstadoEntrega := RetornarEstadoEntrega(LDados.FieldByName('ETC_CIDENT').AsString, LDados.FieldByName('DET_ESTADO').AsString);

        LCalculaAliquotaInterestadual := LDados.FieldByName('ICD_ALQINE').AsFloat;
         // TFunctionFuncoesFaturamento.fCalculaAliquotaInterestadual(
         //   LDados.FieldByName('DET_CODFIS').AsString, LDados.FieldByName('ESTADO_EMPRESA').AsString, LEstadoEntrega);

        LCodigoDaEmpresaTE :=
          IIF(fEmptyStr(LDados.FieldByName('FGO_EMP_TE').AsString),
            LDados.FieldByName('DET_CODEMP').AsString,
              LDados.FieldByName('FGO_EMP_TE').AsString);

        LCodigoDaEmpresa := LDados.FieldByName('DET_CODEMP').AsString;

        { Abreviacao Fiscal }

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


        LAbreviacaoIcmsProduto :=
          fBuscaAbfIcm(LDados.FieldByName('DET_ITEABF').AsString,
                       LCodigoAbreviacaoEmpresa,
                       LEstadoEntrega,
                       LCodigoDaEmpresaTE,
                       LCodigoDaEmpresa);

        LAliquotaEfetivaOrigem := cdsAbfIcm.FieldByName('ABF_ALQEFO' + LTipoAbfCliente).AsFloat;

        LPerBasDifalOrigem  := cdsAbfIcm.FieldByName('ABF_BASDOR' + LTipoAbfCliente).AsFloat;
        LPerBasDifalDestino := cdsAbfIcm.FieldByName('ABF_BASDDS' + LTipoAbfCliente).AsFloat;
        //LAliquotaFCP        := cdsAbfIcm.FieldByName('ABF_ALQFCP' + LTipoAbfCliente).AsFloat;

        LAliquotaInternaEstadoDestino := LDados.FieldByName('ICD_ALQUFD').AsFloat; //cdsAbfIcm.FieldByName('ABF_ALQIED' + LTipoAbfCliente).AsFloat;
        LCodigoDaSituacaoTributaria   := cdsAbfIcm.FieldByName('ABF_CODSIT' + LTipoAbfCliente).AsString;

        LAbreviacaoIcmsProdutoUfEmpresa :=
          fBuscaAbfIcm(LDados.FieldByName('DET_ITEABF').AsString,
                       LCodigoAbreviacaoEmpresa,
                       LDados.FieldByName('ESTADO_EMPRESA').AsString,
                       LCodigoDaEmpresaTE,
                       LCodigoDaEmpresa);

        LPercentualBaseOrigem   := cdsAbfIcm.FieldByName('ABF_BASICM' + LTipoAbfCliente).AsFloat;
        LTipoDeAbreviacaoFiscal := cdsAbfIcm.FieldByName('ABF_CODSIT' + LTipoAbfCliente).AsString;

        LResultadoCalculoDifal :=
          CalcularValorDifal(
            TParametrosCalculoDifal.New
              .ValorIpiDoItem(LDados.FieldByName('DET_VALIPI').AsFloat)
              .ValorFreteDoItem(LDados.FieldByName('DET_TOTFRE').AsFloat)
              .AliquotaInterestadualCalc(LDados.FieldByName('ICD_ALQINE').AsFloat)
              .ValorIcmsBase(LDados.FieldByName('DET_BASICM').AsFloat)
              .TotalDoItem(LDados.FieldByName('DET_TOTITE').AsFloat)
              .DescontoEspecialDoItem(LDados.FieldByName('DET_DESESP').AsFloat)
              .DespesaAcessoriaDoItem(LDados.FieldByName('DET_DESACE').AsFloat)
              .PercentualBaseOrigem(LPercentualBaseOrigem)
              .PercentualBaseDestino(LDados.FieldByName('DET_PERBAS').AsFloat)
              .PercentualBaseDifalOrigem(LPerBasDifalOrigem)
              .PercentualBaseDifalDestino(LPerBasDifalDestino)
              .CalculaAliquotaInterestadual(LCalculaAliquotaInterestadual)
              .CalculaAliquotaEfetivaOrigem(LAliquotaEfetivaOrigem)
              .AliquotaInternaEstadoDestino(LAliquotaInternaEstadoDestino)
              .PercentualProvisorioPartilha( LPercentualProvisorioPartilha )
              .ProdutoSt(LEhProdutoSubstituido)
              .SimplesNacional(LSimplesNacional)
              .AbreviacaoIcmsProduto(LAbreviacaoIcmsProduto)
              .AbreviacaoIcmsProdutoUfEmpresa(LAbreviacaoIcmsProdutoUfEmpresa)
              .HabilitarPercentualBase(fGetValorConfiguracao(CFG_HABILITAR_PERCENTUAL_BASE_DIFAL, varBoolean))
              .CodigoSituacaoTributaria(RightStr(LCodigoDaSituacaoTributaria, 2))
              .CalculaTipoDeAbreviacaoFiscal(RightStr(LTipoDeAbreviacaoFiscal, 2) = '60')
              .SituacaoReducaoBaseCalculo(RightStr(LDados.FieldByName('DET_CODFIS').AsString, 2) = '20')
              .CalculaBaseReduzidaAliquotaEfetiva(fGetValorConfiguracao(CFG_CALCULAR_DIFAL_COM_BASE_REDUZIDA_UTILIZANDO_ALIQUOTA_EFETIVA, varBoolean))
              .CalculaDiferencialAliquotaProdutosSt(fGetValorConfiguracao(CFG_CALCULAR_DIFERENCIAL_ALIQUOTA_PRODUTOS_ST, varBoolean))
              .RecordDifalFCP(LRecordDifalFCP),
               LParametrosResultadoDifal);

        LResultadoComparacao := rcoFalse;

        if (ValidarResultadosDifal(LResultadoCalculoDifal, LDados, LAliquotaDifalDoItem)) Then
          LResultadoComparacao := rcoTrue;

        AdicionarCasosTestesLogDifal(LCasosTestesLogDifal, LDados, LResultadoComparacao);
        pLimparVariaveisTesteUnitario;

        LParametrosResultadoDifalFcp :=
          TParametrosResutladoDifalFCP.New()
            .AliquotaDifalDoItem(LAliquotaDifalDoItem)
            .IcmsDeOrigem(AjustarValoresOrigem(LDados.FieldByName('AUX_OPCDOC').AsString, LDados.FieldByName('ICD_VALORI').AsFloat, LDados.FieldByName('ICD_VALDES').AsFloat))
            .IcmsDeDestino(AjustarValoresDestino(LDados.FieldByName('AUX_OPCDOC').AsString, LDados.FieldByName('ICD_VALORI').AsFloat, LDados.FieldByName('ICD_VALDES').AsFloat))
            .BaseFCP(LDados.FieldByName('ICD_BASFCP').AsFloat)
            .ValorFCP(LDados.FieldByName('ICD_VALFCP').AsFloat);

        LResultadoCalculoDifalFcp :=
          CalcularValorFCPDifal(
            TParametrosCalculoDifalFCP.New
              .AliquotaFCPDoItem(LDados.FieldByName('ICD_PERFCP').AsFloat)
              .AliquotaDifalDoItem(LResultadoCalculoDifal.RecordDifalFCP.fltAlDifa)
              .SimplesNacional(LSimplesNacional)
              .EnviarIcmsDifalDoRemetenteNaPartilha(fGetValorConfiguracao(CFG_OPTANTE_SIMPLES_NACIONAL_ENVIAR_ICMS_DIFAL_REMETENTE_PARTILHA, varBoolean))
              .EnviarIcmsDifalDoDestinoNaPartilha(fGetValorConfiguracao(CFG_OPTANTE_SIMPLES_NACIONAL_ENVIAR_ICMS_DIFAL_DESTINO_PARTILHA, VarBoolean))
              .IcmsDeOrigem(LResultadoCalculoDifal.ValorIcmsOrigem)
              .IcmsDeDestino(fRoundFiveUp(LResultadoCalculoDifal.ValorIcmsDestino, 2))
              .BaseDeCalculoDaSubstituicaoTributariaDoItem(LDados.FieldByName('DET_BASRET').AsFloat)
              .BaseDestino(LResultadoCalculoDifal.ValorBaseDestino),
              LParametrosResultadoDifalFcp
          );

        LResultadoComparacao := rcoFalse;

        if (ValidarResultadosFCPDifal(LResultadoCalculoDifalFcp, LDados, LAliquotaDifalDoItem)) then
          LResultadoComparacao := rcoTrue;

        AdicionarCasosTestesLogFCP(LCasosTestesLogFcp, LDados, LResultadoComparacao);
        pLimparVariaveisTesteUnitario;

        LDados.Next;
      End;

      frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosDifalIgnorados);
      LCasosTestesLogDifal.GerarLog('Difal');
      frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosFcpDifalIgnorados);
      LCasosTestesLogFcp.GerarLog('FCPDifal');

    Except
      On E : Exception do
         ShowMessage('Documento:'+ LDados.FieldByName('DET_NUMDOC').AsString +
                     '| Especie:'+ LDados.FieldByName('DET_ESPDOC').AsString +
                     '| Item:'+ LDados.FieldByName('DET_CODITE').AsString +
                     '| Empresa:'+ LDados.FieldByName('DET_CODEMP').AsString + #13#10 + E.Message);



    End;
  Finally
    FreeAndNil(cdsAbfIcm);
    FreeAndNil(dspAbfIcm);
    FreeAndNil(qryAbfIcm);
  End;
end;

class function TGerarTesteDifal.New: IGerarTeste;
begin
  Result := Self.Create;
end;

procedure TGerarTesteDifal.pAbreClientAbf(ACodigoDaEmpresaTE, ACodigoDaEmpresa: String);
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

function TGerarTesteDifal.ValidarResultadosDifal(const AResultadoCalculoDifal: IResultadoCalculoDifal; const ADados: TUniClientDataSet;
  const AAliquotaDifalDoItem: double): boolean;
begin
  result := True;

  if (not ValidarDataValidaDoDocumentoOriginalDaDevolucaoHidromar(ADados.FieldByName('AUX_OPCDOC').AsString,
    ADados.FieldByName('GER_DTAENT_DOCORI').AsDateTime)) then
  begin
    Exit;
  end;

  result := ValidarResultadosDifalCamposComuns(AResultadoCalculoDifal, ADados, AAliquotaDifalDoItem);

  if (ADados.FieldByName('AUX_OPCDOC').AsString = 'DV') then
  begin
    result := result And ValidarResultadosDifalDevolucao(AResultadoCalculoDifal, ADados);
    exit;
  end;

  result := result and ValidarResultadosDifalVenda(AResultadoCalculoDifal, ADados);
end;

function TGerarTesteDifal.ValidarResultadosDifalCamposComuns(const AResultadoCalculoDifal: IResultadoCalculoDifal; const ADados: TUniClientDataSet;
  const AAliquotaDifalDoItem: double): boolean;
begin
  result := False;

  if not CompararValores(AResultadoCalculoDifal.ValorBaseDestino, ADados.FieldByName('ICD_BCUFDE').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifal.AliquotaInterestadualCalc, ADados.FieldByName('ICD_ALQINE').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifal.RecordDifalFCP.fltAlDifa, AAliquotaDifalDoItem) then
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

function TGerarTesteDifal.ValidarResultadosDifalVenda(const AResultadoCalculoDifal: IResultadoCalculoDifal; const ADados: TUniClientDataSet): boolean;
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

function TGerarTesteDifal.ValidarResultadosDifalDevolucao(const AResultadoCalculoDifal: IResultadoCalculoDifal; const ADados: TUniClientDataSet): boolean;
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

function TGerarTesteDifal.ValidarResultadosFCPDifal(const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP; const ADados: TUniClientDataSet;
  const AAliquotaDifalDoItem: double): boolean;
begin
  result := True;

  if (not ValidarDataValidaDoDocumentoOriginalDaDevolucaoHidromar(ADados.FieldByName('AUX_OPCDOC').AsString,
    ADados.FieldByName('GER_DTAENT_DOCORI').AsDateTime)) then
  begin
    Exit;
  end;

  result := ValidarResultadosFCPDifalCamposComuns(AResultadoCalculoDifalFcp, ADados, AAliquotaDifalDoItem);

  if (ADados.FieldByName('AUX_OPCDOC').AsString = 'DV') then
  begin
    result := result And ValidarResultadosFCPDifalDevolucao(AResultadoCalculoDifalFcp, ADados);
    exit;
  end;

  result := result and ValidarResultadosFCPDifalVenda(AResultadoCalculoDifalFcp, ADados);
end;

function TGerarTesteDifal.ValidarResultadosFCPDifalCamposComuns(const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP; const ADados: TUniClientDataSet;
  const AAliquotaDifalDoItem: double): boolean;
begin

  result := False;

  if not CompararValores(AResultadoCalculoDifalFcp.AliquotaDifalDoItem, AAliquotaDifalDoItem) then
    Exit;
  if not CompararValores(AResultadoCalculoDifalFcp.BaseFCP, ADados.FieldByName('ICD_BASFCP').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifalFcp.ValorFCP, ADados.FieldByName('ICD_VALFCP').AsFloat) then
    Exit;

  result := True;
end;

function TGerarTesteDifal.ValidarResultadosFCPDifalDevolucao(const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP; const ADados: TUniClientDataSet): boolean;
begin
  result := False;

  if not CompararValores(AResultadoCalculoDifalFcp.IcmsDeOrigem, ADados.FieldByName('ICD_VALDES').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifalFcp.IcmsDeDestino, ADados.FieldByName('ICD_VALORI').AsFloat) then
    Exit;

  result := True;
end;

function TGerarTesteDifal.ValidarResultadosFCPDifalVenda(const AResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP; const ADados: TUniClientDataSet): boolean;
begin
  result := False;

  if not CompararValores(AResultadoCalculoDifalFcp.IcmsDeOrigem, ADados.FieldByName('ICD_VALORI').AsFloat) then
    Exit;
  if not CompararValores(AResultadoCalculoDifalFcp.IcmsDeDestino, ADados.FieldByName('ICD_VALDES').AsFloat) then
    Exit;

  result := True;
end;

function TGerarTesteDifal.RetornarEstadoEntrega(const ACodigoCidadeEntrega, AEstadoDoDocumento: string): String;
begin
  result := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [ACodigoCidadeEntrega], False);

  if (not fEmptyStr(result)) then
    Exit;

  result := AEstadoDoDocumento;
end;

function TGerarTesteDifal.ValidarDataValidaDoDocumentoOriginalDaDevolucaoHidromar(const AOpcaoDocumento: string;
  const ADataDocOriginal: TDate): boolean;
const
  DATA_LIMITE = '29/04/2019';
  HIDROMAR = 'HIDROMAR';
begin
  result := True;

  if (AOpcaoDocumento <> 'DV') then
    Exit;

  if (Pos(HIDROMAR, UpperCase(frmModulo.FNomeEmpresa)) <= 0) then
    Exit;

  result := (ADataDocOriginal >= StrToDate(DATA_LIMITE));
end;

procedure TGerarTesteDifal.AdicionarCasosTestesLogDifal(const ACasosTestesLogDifal: ICasosTestesLog; const ADados: TUniClientDataSet;
  const AResultadoComparacao: TResultadoComparacao);
begin
  if (not ValidarDataValidaDoDocumentoOriginalDaDevolucaoHidromar(ADados.FieldByName('AUX_OPCDOC').AsString,
    ADados.FieldByName('GER_DTAENT_DOCORI').AsDateTime)) then
  begin
    inc(FQtdeRegistrosDifalIgnorados);
    Exit;
  end;

  ACasosTestesLogDifal.Add(
    TParametrosCasosTestesLog.New()
      .ResultadoComparacao(AResultadoComparacao)
      .RetornarNomeOperacao('Difal')
      .NumeroDoDocumento(ADados.FieldByName('DET_NUMDOC').AsString)
      .EspecieDoDocumento(ADados.FieldByName('DET_ESPDOC').AsString)
      .CodigoDaEmpresa(ADados.FieldByName('DET_CODEMP').AsString)
      .CodigoDoItem(ADados.FieldByName('DET_CODITE').AsString)
      .CodigoDoCliente(ADados.FieldByName('DET_CODCLI').AsString)
      .DataEntrada(ADados.FieldByName('DET_DTAENT').AsDateTime)
      .OpcaoDocumento(ADados.FieldByName('AUX_OPCDOC').AsString)
      .CodigoFiscal(ADados.FieldByName('DET_CODFIS').AsString)
      .EstadoDoDocumento(ADados.FieldByName('DET_ESTADO').AsString)
      .Log(fGetVariavelLogDifal));
end;

procedure TGerarTesteDifal.AdicionarCasosTestesLogFcp(const ACasosTestesLogFcp: ICasosTestesLog; const ADados: TUniClientDataSet;
  const AResultadoComparacao: TResultadoComparacao);
begin
  if (not ValidarDataValidaDoDocumentoOriginalDaDevolucaoHidromar(ADados.FieldByName('AUX_OPCDOC').AsString,
    ADados.FieldByName('GER_DTAENT_DOCORI').AsDateTime)) then
  begin
    inc(FQtdeRegistrosFcpDifalIgnorados);
    Exit;
  end;

  ACasosTestesLogFcp.Add(
    TParametrosCasosTestesLog.New()
      .ResultadoComparacao(AResultadoComparacao)
      .RetornarNomeOperacao('FCPDifal')
      .NumeroDoDocumento(ADados.FieldByName('DET_NUMDOC').AsString)
      .EspecieDoDocumento(ADados.FieldByName('DET_ESPDOC').AsString)
      .CodigoDaEmpresa(ADados.FieldByName('DET_CODEMP').AsString)
      .CodigoDoItem(ADados.FieldByName('DET_CODITE').AsString)
      .CodigoDoCliente(ADados.FieldByName('DET_CODCLI').AsString)
      .DataEntrada(ADados.FieldByName('DET_DTAENT').AsDateTime)
      .OpcaoDocumento(ADados.FieldByName('AUX_OPCDOC').AsString)
      .CodigoFiscal(ADados.FieldByName('DET_CODFIS').AsString)
      .EstadoDoDocumento(ADados.FieldByName('DET_ESTADO').AsString)
      .Log(fGetVariavelLogFCPDifal));
end;

function TGerarTesteDifal.AjustarValoresDestino(const AOpcaoDocumento: string;
  const AValorOrigem, AValorDestino: double): double;
begin
  result := AValorDestino;

  if (AOpcaoDocumento = 'DV') then
    result := AValorOrigem;
end;

function TGerarTesteDifal.AjustarValoresOrigem(const AOpcaoDocumento: string;
  const AValorOrigem, AValorDestino: double): double;
begin
  result := AValorOrigem;

  if (AOpcaoDocumento = 'DV') then
    result := AValorDestino;
end;

procedure TGerarTesteDifal.pCriaClientAbf;
begin
  dspAbfIcm := TUniDataSetProvider.Create(Nil);
  cdsAbfIcm := TUniClientDataSet.Create(Nil);
  qryAbfIcm := fCriaQuery(Nil);
  dspAbfIcm.DataSet := qryAbfIcm;
  cdsAbfIcm.SetProvider(dspAbfIcm);
end;

{function TGerarTesteDifal.RetornarPercentualPartilha(const ADados: TUniQuery): double;
begin
  if (ADados.FieldByName('AUX_OPCDOC').AsString = 'DV') then
  Begin
    result := RetornarPercentualPartilhaDocumentoOriginal(ADados);
    Exit;
  End;

  result := TFunctionFuncoesFaturamento.PercentualProvisorioPartilha(ADados.FieldByName('DET_DTAENT').AsDateTime);
end;}

{function TGerarTesteDifal.RetornarPercentualPartilhaDocumentoOriginal(const ADados: TUniQuery): double;
var
  LQuery: TUniQuery;
begin
  LQuery := CarregarDadosPercentualPartilhaDocumentoOriginal(ADados);
  try
    result := LQuery.FieldByName('ICD_PERPAR').AsFloat;
  finally
    FreeAndNil(LQuery);
  end;
end;}

{function TGerarTesteDifal.CarregarDadosPercentualPartilhaDocumentoOriginal(const ADados: TUniQuery): TUniQuery;
begin
  result := fCriaQuery(Nil);
  result.Close;
  result.SQL.Clear;
  result.SQL.Add(RetornarSQLDadosPercentualPartilhaDocumentoOriginal);
  result.ParamByName('NUMDOC').AsString := ADados.FieldByName('DET_DOCDEV').AsString;
  result.ParamByName('ESPDOC').AsString := ADados.FieldByName('DET_ESPDEV').AsString;
  result.ParamByName('CODEMP').AsString := ADados.FieldByName('DET_EMPDEV').AsString;
  result.ParamByName('CODITE').AsString := ADados.FieldByName('DET_CODITE').AsString;
  result.Open;
end;}

{function TGerarTesteDifal.RetornarSQLDadosPercentualPartilhaDocumentoOriginal: string;
begin
  result := EmptyStr;
  result := result + 'SELECT   ';
  result := result + '  ICD_PERPAR ';
  result := result + 'FROM     ';
  result := result + '  MOVDET ';
  result := result + '  INNER JOIN MOVICD ON ICD_SEQGER = MOVDET.AUTOINCREM ';
  result := result + 'WHERE    ';
  result := result + '  DET_NUMDOC = :NUMDOC AND ';
  result := result + '  DET_ESPDOC = :ESPDOC AND ';
  result := result + '  DET_CODEMP = :CODEMP AND ';
  result := result + '  DET_CODITE = :CODITE     ';
  result := result + 'UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(result, 'MOVDET', 'NOTDET'), 'MOVICD', 'NOTICD');
end;}

end.
