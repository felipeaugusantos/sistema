unit untFrameBase;

interface

uses
  System.SysUtils, System.StrUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.DateUtils, FMX.Types, FMX.Graphics, FMX.Controls,
  FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Layouts, FMXTee.Engine, untInterfacePlugin;

Const
  cnsFiltroFFDVTR: String = ' /*FF_DV_TR_*/ ';
    
type
  TTipoResultado = (trContagem,
                    trValorVenda,
                    trMargemLucro,
                    trContagemItem,
                    trContagemProdutos,
                    trContagemCliente,
                    trDescontoAplicado);

  TTipoAgrupamento = (taData,
                      taTipoPessoa,
                      taTipoPrazo,
                      taMedia,
                      taMediaDia,
                      taNenhum);

  TFiltroCliente = (fcConsumidor,
                    fcNaoConsumidor,
                    fcReatendidos,
                    fcNovos,
                    fcChave,
                    fcChaveMetaAting,
                    fcTodos);

  TDiasUteisDepartamento = (dudNaoConsiderar = 0, dudIntegral, dudTresQuartosDia, dudMeioDia);
  TDiasUteisDepartamentoHelper = record helper for TDiasUteisDepartamento
    function fGetValue: Double;
  end;


  TParamArrayString = Array Of String; 

  TfraBaseFrame = class(TFrame)
    FlowLayout1: TFlowLayout;
  private
    function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
    function fRetClientesFilial: String;
    function fRetEmpAcessoUsuario(): String;
    function fEhDiaUtil(dteData: TDate): Boolean;
    function fEhFeriado(dteData: TDate): Boolean;
    function fRetCodECarregaInformacoesDepartamento(): String;
    procedure pCalculaDiasUteis();
  protected
    fltDiasUteis,
    fltDiasUteisPassados,
    fltDiasRestantes,
    fltValorSabado,
    fltValorDomingo: Double;
    strClaVen,
    strClaDev,
    strClaBri,
    strCliFil,
    strEmpAcessoUsuarioLogado,
    strCodDeptoUsuarioLogado: String;
    intMes,
    intAnoAtu,
    intAnoAnt: Word;
    dteHoje,
    dteDtaIni,
    dteDtaFin,
    dteAntIni,
    dteAntFin,
    DataAntIni,
    DataAntFin: TDate;

    procedure pIniciaVariaveis(); virtual;
    procedure pCarregaDiasTabelaTemporaria();

    procedure pCriaTemporariaQuantidadeClientes();
    procedure pDestroiTemporariaQuantidadeClientes();

    function fDataAtual(): TDate;
    function fMes(numMes:Integer): String;
    function fMesComp(numMes:Integer): String;
    function fCfgSis(strCodCfg: String): Variant;
    function fSQLVendas(dteDtaIni, dteDtaFin: TDate; enmTipoResultado: TTipoResultado;
      enmTipoAgrupamento: TTipoAgrupamento; strCodDep: String = '';
      enmTipoCliente: TFiltroCliente = fcTodos; blnSomenteConsumiveis: Boolean = False;
      blnValorMetaAtingida: Boolean = False): String;
    function fGetValorVendas(dteDtaIni, dteDtaFin: TDate; enmTipoResultado: TTipoResultado;
      enmTipoAgrupamento: TTipoAgrupamento; strCodDep: String = '';
      enmTipoCliente: TFiltroCliente = fcTodos; blnSomenteConsumiveis: Boolean = False;
      blnValorMetaAtingida: Boolean = False): Double;
    function fTemDireitoAcesso(strNomeForm: String): Boolean;
    function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
    function fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQLItensPorDataEntrada: String; 
                                                              arrAlias: TParamArrayString=NIL;
                                                              arrMacroParaCadaItemDoarrAlias: TParamArrayString=NIL;
                                                              arrApenasAsEspecies: TParamArrayString=NIL; 
                                                              strPrefixo: String='DET_';
                                                              strOperacaoSeSomenteValor: String=''): String;
    function fSqlVendasCliente(strSqlCodCli: String; dteDataIni, dteDataFin: TDate): String;
    function fStrToFloat(strValorUnico: String; fltDefault : real = 0): Double;
  public
    qryAux: IQuery;
    strTabTmp: String;
    strCodEmp: String;
    strLogOpe: String;
    blnDireitoGeral: Boolean;
    blnDireitoEquipe: Boolean;
    blnUtilizaPrazoMedio: Boolean;
    procedure pCarregaDados(); virtual; abstract;
  end;

implementation

{$R *.fmx}

{ TfraBaseFrame }

function TfraBaseFrame.IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
begin
   if lTest then
     Result := vExpr1
   else
     Result := vExpr2
end;

{*****************************************************************************************************}
{*NOTA.: FUNÇÃO REPLICADA. SE MODIFICAR ALGO AQUI TEM QUE MODIFICAR A MESMA EM untFuncoesSimples     *}
{**************************************************************************************************VA*}
function TfraBaseFrame.fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQLItensPorDataEntrada: String; 
                                                                        arrAlias: TParamArrayString=NIL;
                                                                        arrMacroParaCadaItemDoarrAlias: TParamArrayString=NIL;
                                                                        arrApenasAsEspecies: TParamArrayString=NIL; 
                                                                        strPrefixo: String='DET_';
                                                                        strOperacaoSeSomenteValor: String=''): String;
 Var
   strAlias,
   strMacro, 
   strFiltroPorInDeEsp,
   strFiltroPorAndDeFF,
   strSQLItensPorDataFaturam,
   strFiltroFinalPorDtaFaturam,
   strFiltroFinalPorDtaEntrada,
   strFiltroFinalPorDtaFaturamAux,
   strFiltroFinalPorDtaEntradaAux: String;
   intIdx: Integer;

   function fAliasAndTabela: String;
   begin
     Result := '/*<ALIAS>*/'+strPrefixo; 
   end;
   
   function fSepara(Const strSQL: String; strSep: String): String;
   begin
     Result := IfThen(Not strSQL.IsEmpty,' '+strSep+' ',' ')
   end;
   
   procedure pTrocaSQLMacros;
   begin
     strFiltroFinalPorDtaFaturamAux := AnsiReplaceStr(strFiltroFinalPorDtaFaturam, '/*<ALIAS>*/', strAlias);
     strFiltroFinalPorDtaEntradaAux := AnsiReplaceStr(strFiltroFinalPorDtaEntrada, '/*<ALIAS>*/', strAlias);

     //SQL SECUNDÁRIO INCLUI "IN" DO CONTEÚDO DE strFiltroFFTRDV, FILTRANDO PELA DATA DE FATURAMENTO
     strSQLItensPorDataFaturam := AnsiReplaceStr(strSQLItensPorDataFaturam, strAlias+strPrefixo+'DTAENT', strAlias+strPrefixo+'DTAFAT');
     strSQLItensPorDataFaturam := AnsiReplaceStr(strSQLItensPorDataFaturam, strMacro, strFiltroFinalPorDtaFaturamAux + ' AND ');

     //SQL PRINCIPAL INCLUI "NOT IN" DO CONTEÚDO DE strFiltroFFTRDV POIS JÁ ESTARÃO NO strSQLItensPorDataFaturam
     strSQLItensPorDataEntrada := AnsiReplaceStr(strSQLItensPorDataEntrada, strMacro, strFiltroFinalPorDtaEntradaAux + ' AND ');
   end;

   procedure pLimpaSQLMacros;
   begin
     //RETIRA A MACRO /*FF_DV_TR_*/ CASO ELA NÃO TENHA SIDO UTILIZADA
     strSQLItensPorDataEntrada := AnsiReplaceStr(strSQLItensPorDataEntrada, strMacro, ' ');
   end;
   
begin
  If (Length(arrAlias)>1) Then
  Begin  
    //SE TIVER MAIS QUE UM ALIÁS PARA MOVDET O PROGRAMADOR TEM QUE INCLUIR UMA MACRO PARA CADA ALIÁS EXEMPLO: ['A.','B.'], ['<*MACRO_A.*>',<*MACRO_B.*>]] 
    //SE TIVER SÓ UM ALIÁS OU SE arrMacroParaCadaItemDoarrAlias ESTIVER VAZIA O SISTEMA ASSUMIRÁ QUE O PROGRAMADOR INCLUIU A cnsFiltroFFDVTR NO SQL
    //CASO CONTRARIO SERÁ EMITIDO UM ALERTA
    If (Length(arrMacroParaCadaItemDoarrAlias) <> Length(arrAlias)) Then
    Begin
      Result := ' FALSE ';
      Raise Exception.Create('Programador, função de separação de Itens por Data Entrega/Data Faturamento preenchida de forma incorreta. Corrija!');
    End;
  End;
    
  strAlias := '';
  strMacro := cnsFiltroFFDVTR;

  If (Length(arrAlias)=1) Then
  Begin
    If (Length(arrMacroParaCadaItemDoarrAlias)=0) Then  
      arrMacroParaCadaItemDoarrAlias := [strMacro];
  End;
  
  Try
    If (fCfgSis('COM_DV') = '2') Then
      strFiltroPorInDeEsp := strFiltroPorInDeEsp + fSepara(strFiltroPorInDeEsp,',') + '"DV"';

    If (fCfgSis('COM_TR') = '2') Then
      strFiltroPorInDeEsp := strFiltroPorInDeEsp + fSepara(strFiltroPorInDeEsp,',') + '"TR"';

    If (IIF(Length(arrApenasAsEspecies)=0, True, AnsiMatchStr('FF', arrApenasAsEspecies))) Then
    Begin
      If (fCfgSis('COM_FF') = '2') And (fCfgSis('COM_FV') = '2') Then
      Begin
        strFiltroPorInDeEsp := strFiltroPorInDeEsp + fSepara(strFiltroPorInDeEsp,',') + '"FF"';
      End
      Else
      Begin  
        If (fCfgSis('COM_FF') = '2') Then
          strFiltroPorAndDeFF := '(('+fAliasAndTabela+'ESPDOC="FF") AND (IFNULL('+fAliasAndTabela+'CONPAG,"01000")<>"01000"))';

        If (fCfgSis('COM_FV') = '2') Then
          strFiltroPorAndDeFF := '(('+fAliasAndTabela+'ESPDOC="FF") AND (IFNULL('+fAliasAndTabela+'CONPAG,"01000")="01000"))';
      End;
    End;

    If Not strFiltroPorInDeEsp.IsEmpty Then
    Begin
      strFiltroFinalPorDtaFaturam := '('+strFiltroFinalPorDtaFaturam + fSepara(strFiltroFinalPorDtaFaturam,'OR') + fAliasAndTabela+'ESPDOC IN ('+strFiltroPorInDeEsp+'))';
    End;

    If Not strFiltroPorAndDeFF.IsEmpty Then
    Begin
      strFiltroFinalPorDtaFaturam := '('+strFiltroFinalPorDtaFaturam + fSepara(strFiltroFinalPorDtaFaturam,'OR') + strFiltroPorAndDeFF+')';
    End;

    If Not strFiltroFinalPorDtaFaturam.IsEmpty Then
    Begin
      strFiltroFinalPorDtaEntrada := ' (NOT '+strFiltroFinalPorDtaFaturam+') ';

      strSQLItensPorDataFaturam := strSQLItensPorDataEntrada;

      If (Length(arrAlias)=0) Then
      Begin
        pTrocaSQLMacros;
      End
      Else
      Begin
        for intIdx := Low(arrAlias) to High(arrAlias) do
        Begin
          strAlias := arrAlias[intIdx];
          strMacro := arrMacroParaCadaItemDoarrAlias[intIdx];
          pTrocaSQLMacros;
        End;
      End;

      If strOperacaoSeSomenteValor.IsEmpty Then
        strSQLItensPorDataEntrada := strSQLItensPorDataEntrada + ' UNION ALL ' + strSQLItensPorDataFaturam
      Else  
        strSQLItensPorDataEntrada := ' IFNULL(('+strSQLItensPorDataEntrada+'), 0) '+strOperacaoSeSomenteValor+' IFNULL(('+strSQLItensPorDataFaturam+'), 0)';
    End;
  Finally
    If (Length(arrMacroParaCadaItemDoarrAlias)=0) Then
    Begin
      pLimpaSQLMacros;
    End
    Else
    Begin
      for intIdx := Low(arrMacroParaCadaItemDoarrAlias) to High(arrMacroParaCadaItemDoarrAlias) do
      Begin
        strMacro := arrMacroParaCadaItemDoarrAlias[intIdx];
        pLimpaSQLMacros;
      End;
    End;

    Result := strSQLItensPorDataEntrada;
  End;
end;

function TfraBaseFrame.fCfgSis(strCodCfg: String): Variant;
begin
  qryAux.Close;
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT       ');
  qryAux.SQL.Add('  SIS_VALCFG ');
  qryAux.SQL.Add('FROM         ');
  qryAux.SQL.Add('  CFGSIS     ');
  qryAux.SQL.Add('WHERE SIS_CODCFG = ' + QuotedStr('CFG_' + strCodCfg));
  qryAux.SQL.Add('  AND SIS_CODEMP = ' + QuotedStr(strCodEmp));
  qryAux.Open;

  Result := qryAux.FieldValue('SIS_VALCFG');
end;

function TfraBaseFrame.fRetCodECarregaInformacoesDepartamento: String;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT        ';
  strSQL := strSQL + '  OPE_CODDEP, ';
  strSQL := strSQL + '  IFNULL(DEP_SABUTI, 0) AS SABUTI, ';
  strSQL := strSQL + '  IFNULL(DEP_DOMUTI, 0) AS DOMUTI  ';
  strSQL := strSQL + 'FROM          ';
  strSQL := strSQL + '  CADOPE      ';
  strSQL := strSQL + ' LEFT JOIN CADDEP D ON OPE_CODDEP = DEP_CODIGO ';
  strSQL := strSQL + 'WHERE OPE_CODOPE = ' + QuotedStr(strLogOpe);

  qryAux.Close;
  qryAux.SQL.Text := strSQL;
  qryAux.Open;

  If qryAux.FieldValue('OPE_CODDEP') = null Then
    Result := ''
  Else
    Result := qryAux.FieldValue('OPE_CODDEP');

  fltValorSabado := TDiasUteisDepartamento(qryAux.FieldValue('SABUTI')).fGetValue();
  fltValorDomingo:= TDiasUteisDepartamento(qryAux.FieldValue('DOMUTI')).fGetValue();
end;

function TfraBaseFrame.fDataAtual: TDate;
begin
  qryAux.Close;
  qryAux.SQL.Text := 'SELECT CURRENT_DATE AS HOJE';
  qryAux.Open;

  Result := qryAux.FieldValue('HOJE');
end;

function TfraBaseFrame.fEhDiaUtil(dteData: TDate): Boolean;
begin
  If (DayOfWeek(dteData) in [1, 7]) Or fEhFeriado(dteData) Then
    Result := False
  Else
    Result := True;
end;

function TfraBaseFrame.fEhFeriado(dteData: TDate): Boolean;
var
  strCodCid: String;
begin
  qryAux.Close;
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD ');
  qryAux.SQL.Add('FROM CADFER ');
  qryAux.SQL.Add('WHERE FER_DTAFER = ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dteData)));
  qryAux.Open;

  Result := qryAux.FieldValue('QTD') > 0;

  If Not Result Then
  Begin
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT EMP_CODCID ');
    qryAux.SQL.Add('FROM CADEMP ');
    qryAux.SQL.Add('WHERE EMP_CODEMP = ' + QuotedStr(strCodEmp));
    qryAux.Open;
    If qryAux.FieldValue('EMP_CODCID') <> null Then
      strCodCid := qryAux.FieldValue('EMP_CODCID')
    Else
      strCodCid := '';

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT COUNT(*) AS QTD ');
    qryAux.SQL.Add('FROM FERCID ');
    qryAux.SQL.Add('WHERE FCI_DTAFER = ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dteData)));
    qryAux.SQL.Add('  AND FCI_CODCID = ' + QuotedStr(strCodCid));
    qryAux.Open;

    Result := qryAux.FieldValue('QTD') > 0;
  End;
end;

function TfraBaseFrame.fGetValorVendas(dteDtaIni, dteDtaFin: TDate;
  enmTipoResultado: TTipoResultado; enmTipoAgrupamento: TTipoAgrupamento;
  strCodDep: String; enmTipoCliente: TFiltroCliente;
  blnSomenteConsumiveis: Boolean; blnValorMetaAtingida: Boolean): Double;
begin
  Result := 0;

  If (enmTipoCliente = fcReatendidos) Then
    pCriaTemporariaQuantidadeClientes;

  qryAux.Close;
  qryAux.SQL.Text := fSQLVendas(dteDtaIni, dteDtaFin, enmTipoResultado,
                                enmTipoAgrupamento, strCodDep, enmTipoCliente,
                                blnSomenteConsumiveis, blnValorMetaAtingida);
  qryAux.Open;

  While (Not qryAux.Eof) Do
  Begin
    If qryAux.FieldValue('VALOR') <> null Then
      Result := Result + qryAux.FieldValue('VALOR');

    qryAux.Next();
  End;

  If (enmTipoCliente = fcReatendidos) Then
    pDestroiTemporariaQuantidadeClientes;

end;

function TfraBaseFrame.fMes(numMes: Integer): String;
begin
  Case numMes Of
   1:  Result := 'Jan';
   2:  Result := 'Fev';
   3:  Result := 'Mar';
   4:  Result := 'Abr';
   5:  Result := 'Mai';
   6:  Result := 'Jun';
   7:  Result := 'Jul';
   8:  Result := 'Ago';
   9:  Result := 'Set';
   10: Result := 'Out';
   11: Result := 'Nov';
   12: Result := 'Dez';
  End;
end;

function TfraBaseFrame.fMesComp(numMes: Integer): String;
begin
  Case numMes Of
   1:  Result := 'janeiro';
   2:  Result := 'fevereiro';
   3:  Result := 'março';
   4:  Result := 'abril';
   5:  Result := 'maio';
   6:  Result := 'junho';
   7:  Result := 'julho';
   8:  Result := 'agosto';
   9:  Result := 'setembro';
   10: Result := 'outubro';
   11: Result := 'novembro';
   12: Result := 'dezembro';
  End;
end;

function TfraBaseFrame.fRetClientesFilial: String;
begin
  qryAux.Close;
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT       ');
  qryAux.SQL.Add('  EMP_CLIFIL ');
  qryAux.SQL.Add('FROM         ');
  qryAux.SQL.Add('  CADEMP     ');

  qryAux.Open;

  Result := '';
  qryAux.First;
  While Not qryAux.Eof Do
  Begin
    If (qryAux.FieldValue('EMP_CLIFIL') <> null) And (qryAux.FieldValue('EMP_CLIFIL') <> '') Then
      Result := Result + QuotedStr(qryAux.FieldValue('EMP_CLIFIL')) + ',';

    qryAux.Next;
  End;

  Result := Copy(Result, 1, Length(Result) - 1);

  If Result = '' Then
    Result := '""';
end;

function TfraBaseFrame.fRetEmpAcessoUsuario: String;
begin
  qryAux.Close;
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT       ');
  qryAux.SQL.Add('  OPE_EMPACE ');
  qryAux.SQL.Add('FROM         ');
  qryAux.SQL.Add('  CADOPE     ');
  qryAux.SQL.Add('WHERE        ');
  qryAux.SQL.Add('  OPE_CODOPE = ' + QuotedStr(strLogOpe));
  qryAux.Open;

  If qryAux.FieldValue('OPE_EMPACE') <> null Then
    Result := qryAux.FieldValue('OPE_EMPACE')
  Else
    Result := '';
end;

function TfraBaseFrame.fSQLVendas(dteDtaIni, dteDtaFin: TDate; enmTipoResultado: TTipoResultado;
      enmTipoAgrupamento: TTipoAgrupamento; strCodDep: String = '';
      enmTipoCliente: TFiltroCliente = fcTodos; blnSomenteConsumiveis: Boolean = False;
      blnValorMetaAtingida: Boolean = False): String;
var
  strSQL,
  strSQLExt: String;
  intValCfg: Integer;
  LstrFormula : String;

const
  STR_COMP_FRETE_CAMPO = '(COALESCE(DET_FRESUG, 0) - COALESCE(DET_TOTFRE, 0))';

  STR_COMP_JURCUS_CAMPO = '(COALESCE(DET_TOTCUS, 0) * COALESCE(DET_TAXJUR, 0) / 100)';

  STR_COMP_DIFAL_CAMPO = '(COALESCE(ICD_VALORI, 0) + COALESCE(ICD_VALDES, 0))';

  STR_COMP_FCP_CAMPO = 'COALESCE(ICD_VALFCP, 0)';

  ARR_CFG_COMP_CUSTO_CAMPOS  : array[0..12] of String = ('DET_TOTCUS', 'DET_TOTMED', 'DET_TOTULT', 'DET_IMPULT',
                                                         'DET_OUTVAL', 'DET_ICMSAI', 'DET_IMPFED', 'DET_DESOPE',
                                                         STR_COMP_FRETE_CAMPO, STR_COMP_JURCUS_CAMPO,
                                                         STR_COMP_DIFAL_CAMPO, STR_COMP_FCP_CAMPO, 'DET_OPVICM');

  ARR_CFG_COMP_CUSTO_VALCAM  : array[0..12] of Integer = (1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096);

  CLIENTE_CONSUMIDOR = '(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE ' +
                       '"%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI '+
                       'LIKE "%SEGURADORA%")';

  procedure pComposicaoCustoPadrao(var AintComposicao : integer; var AstrFormula : String);
  Begin
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT COM_COMPOS, COM_FORMUL FROM COMCUS WHERE COM_SUGERI = "S"';
    qryAux.Open;

    AintComposicao := qryAux.FieldValue('COM_COMPOS');
    AstrFormula    := qryAux.FieldValue('COM_FORMUL');
  End;

  function fRetornaComposicaoCustoIndices(intValCfg : Integer): TIntArray;
    Var
      intCorre : Integer;
      intValor : Integer;
  begin
    SetLength(Result,0);

    intValor := ARR_CFG_COMP_CUSTO_VALCAM[Length(ARR_CFG_COMP_CUSTO_VALCAM)-1];
    For intCorre := Length(ARR_CFG_COMP_CUSTO_VALCAM)-1 Downto 0 Do
    Begin
      if (intValCfg >= intValor) Then
      Begin
        SetLength(Result, Succ(Length(Result)));
        Result[Length(Result)-1] := intCorre;
        intValCfg := intValCfg - intValor;
      End;

      intValor  := intValor Div 2;
    End;

  End;

  function fRetornaComposicaoCustoCampos(intValCfg : Integer): String;
    Var
      arrTemp   : TIntArray;
      intCorre  : Integer;
      strCampo  : String;
  Begin
    Result := '';
    arrTemp := fRetornaComposicaoCustoIndices(intValCfg);
    For intCorre := Length(arrTemp)-1 DownTo 0 Do
    Begin
      Result := Result + 'IFNULL(' + ARR_CFG_COMP_CUSTO_CAMPOS[arrTemp[intCorre]] + ',0)';

      If (intCorre - 1 ) >= 0 Then
        Result := Result + ' + ';
    End;

    strCampo := 'IFNULL(DET_TOTCUS, 0)';

    Result := 'ROUND(( ' + Result + ' ), 2) ';
  End;

  function fGetVrVend: String;
  Begin
    Result := '';
    Result := Result + ' SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,';
    Result := Result + QuotedStr(strClaBri) + '), 0.00, IF(LEFT(DET_CLAFIS,1)';
    Result := Result + ' < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), ';
    Result := Result + 'DET_TOTITE - DET_DESESP - DET_DESCFF))) ';
  End;

  function fGetVrSuge: String;
  Begin
    Result := '';
    Result := Result + 'SUM(IF(LEFT(DET_CLAFIS,1) < 5, - ROUND((IF(IFNULL(DET_UNIORI, 0) = 0, ';
    Result := Result + 'DET_UNITAR, DET_UNIORI) * DET_QTDITE),2), ROUND((IF(IFNULL(DET_UNIORI, 0)';
    Result := Result + ' = 0, DET_UNITAR, DET_UNIORI) * DET_QTDITE),2)))';
  End;

begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  If enmTipoCliente = fcChaveMetaAting Then
  Begin
    strSQL := strSQL + '  G.GER_CODCLI, ';
    strSQL := strSQL + '  CRF_FATINI,   ';
  End;

  Case enmTipoAgrupamento Of
    taData,
    taMediaDia:
      strSQL := strSQL + ' DET_DTAENT AS DTAVEN, ';
    taTipoPessoa:
      strSQL := strSQL + ' IF(CLI_INDUST = "S", "I", IF(IFNULL(F.AUTOINCREM, "")'+
                         ' <> "", "A", IF(CLI_CGCCPF = 1, "J", "F"))) AS CLI_CGCCPF, ';
    taTipoPrazo:
      strSQL := strSQL + ' IF(GER_CONPAG = "01000", 1, 2) AS GER_PRAZO, ';
  End;

  Case enmTipoResultado Of
    trContagem:
      strSQL := strSQL + ' COUNT(DISTINCT G.AUTOINCREM) AS VALOR ';
    trContagemItem:
      strSQL := strSQL + ' COUNT(DISTINCT D.AUTOINCREM) AS VALOR ';
    trContagemProdutos:
      strSQL := strSQL + ' COUNT(DISTINCT DET_CODITE) AS VALOR ';
    trContagemCliente:
      Begin
        If enmTipoCliente = fcConsumidor Then
          strSQL := strSQL + ' COUNT(0) AS VALOR '
        Else
          strSQL := strSQL + ' COUNT(DISTINCT G.GER_CODCLI) AS VALOR ';
      End;
    trValorVenda:
      strSQL := strSQL + fGetVrVend() + ' AS VALOR ';
    trMargemLucro:
      Begin
        intValCfg   := 0;
        LstrFormula := '';

        pComposicaoCustoPadrao(intValCfg, LstrFormula);

        if LstrFormula = '' then
          LstrFormula:= fRetornaComposicaoCustoCampos(intValCfg);

        strSQL := strSQL + ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' +
                           QuotedStr(strClaBri) + '), 0.00, IF(LEFT(DET_CLAFIS,1)'+
                           ' < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), '+
                           'DET_TOTITE - DET_DESESP - DET_DESCFF)) AS DET_TOTFAT, ';
        strSQL := strSQL + ' IF(LEFT(DET_CLAFIS,1) < 5, -(' + LstrFormula +
                           '), ' + LstrFormula + ') AS DET_TOTCUS ';
      End;
    trDescontoAplicado:
      strSQL := strSQL + ' ROUND(((' + fGetVrSuge + ' - ' + fGetVrVend + ' ) / ' +
                          fGetVrSuge + ' * 100), 2) AS VALOR ';
  End;

  strSQL := strSQL + 'FROM       ';
  strSQL := strSQL + '  MOVDET D ';
  strSQL := strSQL + '  INNER JOIN MOVGER G ON D.DET_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '  LEFT  JOIN MOVICD   ON   ICD_SEQGER = D.AUTOINCREM AND D.DET_VALRET = 0 ';

  If enmTipoAgrupamento = taTipoPessoa Then
  Begin
    strSQL := strSQL + ' INNER JOIN CADCLI C ON C.CLI_CODCLI = G.GER_CODCLI ';
    strSQL := strSQL + ' INNER JOIN CADATI A ON C.CLI_CODATI = A.ATI_CODATI ';
    strSQL := strSQL + ' LEFT  JOIN CADGAT T ON A.ATI_CODGAT = T.GAT_CODGAT ';
    strSQL := strSQL + ' LEFT  JOIN GPAFID F ON T.GAT_CODGAT = F.FID_CODGPA ';
    strSQL := strSQL + '                    AND F.FID_FISJUR = "A"          ';
    strSQL := strSQL + '                    AND F.FID_CODEMP = ' + QuotedStr(strCodEmp);
  End;

  If enmTipoCliente <> fcTodos Then
    strSQL := strSQL + ' INNER JOIN CADCLI C ON C.CLI_CODCLI = G.GER_CODCLI ';

  If enmTipoCliente = fcChaveMetaAting Then
    strSQL := strSQL + ' INNER JOIN CRMFAI R ON R.CRF_CODIGO = C.CLI_CRMFAI ';

  If enmTipoResultado = trMargemLucro Then
    strSQL := strSQL + ' INNER JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER ';

  If blnSomenteConsumiveis Then
    strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = DET_CODITE ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + cnsFiltroFFDVTR;  
  strSQL := strSQL + '  DET_DTAENT BETWEEN ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dteDtaIni)) + ' AND ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dteDtaFin));

  If blnSomenteConsumiveis Then
    strSQL := strSQL + '  AND I.ITE_CLACRM = "C" ';

  Case enmTipoCliente Of
    fcConsumidor     : strSQL := strSQL + '  AND ' + CLIENTE_CONSUMIDOR + ' ';
    fcNaoConsumidor  : strSQL := strSQL + '  AND NOT ' + CLIENTE_CONSUMIDOR + ' ';
    fcReatendidos    : strSQL := strSQL + '  AND NOT ' + CLIENTE_CONSUMIDOR + ' AND G.GER_CODCLI IN (SELECT DISTINCT GER_CODCLI FROM TMP_QTDCLI_' + strLogOpe + ') ';
    fcNovos          : strSQL := strSQL + '  AND NOT ' + CLIENTE_CONSUMIDOR + ' AND (CLI_PRICOM IS NULL OR CLI_PRICOM >= ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dteDtaIni)) + ') ';
    fcChave          : strSQL := strSQL + '  AND CLI_CRMFAI IS NOT NULL ';
  End;

  If Not blnDireitoGeral Then
  Begin
    strSQL := strSQL + '  AND (DET_CODVEN = ' + QuotedStr(strLogOpe) + ' ';
    If blnDireitoEquipe And (strCodDep <> '') Then
    Begin
      strSQL := strSQL + '   OR DET_CODVEN IN ';
      strSQL := strSQL + '   (SELECT          ';
      strSQL := strSQL + '      OPE_CODOPE    ';
      strSQL := strSQL + '    FROM            ';
      strSQL := strSQL + '      CADOPE        ';
      strSQL := strSQL + '    WHERE OPE_CODDEP = ' + QuotedStr(strCodDep);
      strSQL := strSQL + '   )';
    End;
    strSQL := strSQL + '  )';
  End;
  strSQL := strSQL + '  AND DET_PROEMB <> "S" ';
  strSQL := strSQL + '  AND DET_TIP_FC = "C"  ';
  strSQL := strSQL + '  AND DET_CODCLI NOT IN (' + strCliFil + ') ';
  strSQL := strSQL + '  AND ((LOCATE(DET_CLAFIS, ' + QuotedStr(strClaVen) + ') > 0) OR (LOCATE(DET_CLAFIS, ' + QuotedStr(strClaDev) + ') > 0) ';

  If fCfgSis('ENTBRF') = 'S' Then
    strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + QuotedStr(strClaBri) + ')) '
  Else
    strSQL := strSQL + ') ';

  strSQL := strSQL + '  AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If enmTipoCliente = fcChaveMetaAting Then
  Begin
    strSQL := strSQL + 'GROUP BY ';
    If enmTipoAgrupamento = taMediaDia Then
      strSQL := strSQL + ' DET_DTAENT, ';
    strSQL := strSQL + 'G.GER_CODCLI, CRF_FATINI ';
    strSQL := strSQL + 'HAVING VALOR >= (CRF_FATINI / ' +
                       ReplaceStr(ReplaceStr(FloatToStr(fltDiasUteis), '.', ''), ',', '.') + ' * ' +
                       ReplaceStr(ReplaceStr(FloatToStr(fltDiasUteisPassados), '.', ''), ',', '.') + ')';
  End
  Else
  Begin
    Case enmTipoAgrupamento Of
      taData,
      taMediaDia:
        strSQL := strSQL + ' GROUP BY DET_DTAENT ';
      taTipoPessoa:
        strSQL := strSQL + ' GROUP BY DET_DTAENT, IF(CLI_INDUST = "S", "I", IF(IFNULL(F.AUTOINCREM, "") <> "", "A", IF(CLI_CGCCPF = 1, "J", "F"))) ';
      taTipoPrazo:
        strSQL := strSQL + ' GROUP BY DET_DTAENT, GER_PRAZO  ';
    End;
  End;

  strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

  strSQLExt := '';
  strSQLExt := strSQLExt + 'SELECT SQL_NO_CACHE ';

  Case enmTipoAgrupamento Of
    taData:
      strSQLExt := strSQLExt + '  DAY(DTAVEN) AS DIAMES, ';
    taMediaDia:
      strSQLExt := strSQLExt + ' TMP.DIA AS DIAMES, ';
    taTipoPessoa:
      strSQLExt := strSQLExt + '  CLI_CGCCPF, ';
    taTipoPrazo:
      strSQLExt := strSQLExt + '  GER_PRAZO, ';
  End;

  If enmTipoResultado = trMargemLucro Then
  Begin
    strSQLExt := strSQLExt + '  IF(                                                ';
    strSQLExt := strSQLExt + '    (                                                ';
    strSQLExt := strSQLExt + '      (1- (SUM(DET_TOTCUS) / SUM(DET_TOTFAT))) * 100 ';
    strSQLExt := strSQLExt + '    ) IS NULL,                                       ';
    strSQLExt := strSQLExt + '    0,                                               ';
    strSQLExt := strSQLExt + '    (                                                ';
    strSQLExt := strSQLExt + '      (1- (SUM(DET_TOTCUS) / SUM(DET_TOTFAT))) * 100 ';
    strSQLExt := strSQLExt + '    )                                                ';
    strSQLExt := strSQLExt + '  ) AS VALOR                                         ';
  End
  Else If (enmTipoAgrupamento In [taMediaDia]) Then
    strSQLExt := strSQLExt + ' IFNULL(VALOR, 0) AS VALOR '
  Else If (enmTipoAgrupamento In [taMedia]) Then
    strSQLExt := strSQLExt + ' SUM(VALOR) / ' + IntToStr(MonthsBetween(dteDtaFin, dteDtaIni)) + ' AS VALOR '
  Else
  Begin
    If (Not blnValorMetaAtingida) And (enmTipoCliente = fcChaveMetaAting) Then
      strSQLExt := strSQLExt + '  COUNT(GER_CODCLI) AS VALOR '
    Else
      strSQLExt := strSQLExt + '  SUM(VALOR) AS VALOR ';
  End;

  strSQLExt := strSQLExt + 'FROM (      ';
  strSQLExt := strSQLExt + strSQL;
  strSQLExt := strSQLExt + ') AS TAB    ';

  If enmTipoAgrupamento = taMediaDia Then
  Begin
    strSQLExt := strSQLExt + '  RIGHT JOIN ' + strTabTmp + ' TMP ON TMP.DIA = DAY(TAB.DTAVEN) AND TMP.MES = MONTH(TAB.DTAVEN) ';
    strSQLExt := 'SELECT DIAMES, AVG(VALOR) AS VALOR FROM ( ' + strSQLExt + ') TAB2 '
  End;

  Case enmTipoAgrupamento Of
    taData:
      strSQLExt := strSQLExt + ' GROUP BY DTAVEN ORDER BY DTAVEN ';
    taMediaDia:
      strSQLExt := strSQLExt + ' GROUP BY DIAMES ORDER BY DIAMES ';
    taTipoPessoa:
      strSQLExt := strSQLExt + ' GROUP BY CLI_CGCCPF ';
    taTipoPrazo:
      strSQLExt := strSQLExt + ' GROUP BY GER_PRAZO  ';
  End;

  Result := strSQLExt;
end;

function TfraBaseFrame.fSqlVendasCliente(strSqlCodCli: String; dteDataIni,
  dteDataFin: TDate): String;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT DISTINCT(A.GER_CODCLI) ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET D ';
  strSQL := strSQL + '  INNER JOIN MOVGER A ON D.DET_SEQGER = A.AUTOINCREM ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + cnsFiltroFFDVTR;
  strSQL := strSQL + '      DET_DTAENT BETWEEN ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dteDataIni));
  strSQL := strSQL + '  AND ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dteDataFin));
  strSQL := strSQL + '  AND DET_PROEMB <> "S" ';
  strSQL := strSQL + '  AND DET_TIP_FC = "C" ';
  strSQL := strSQL + '  AND DET_CODCLI NOT IN (' + strCliFil + ') ';
  strSQL := strSQL + '  AND ((LOCATE(DET_CLAFIS, ' + QuotedStr(strClaVen) + ') > 0) OR (LOCATE(DET_CLAFIS, ' + QuotedStr(strClaDev) + ') > 0) ';

  If fCfgSis('ENTBRF') = 'S' Then
    strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + QuotedStr(strClaBri) + ')) '
  Else
    strSQL := strSQL + ') ';

  Result := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);
end;

function TfraBaseFrame.fStrToFloat(strValorUnico: String;
  fltDefault: real): Double;
begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',''),fltDefault);
end;

function TfraBaseFrame.fTemDireitoAcesso(strNomeForm: String): Boolean;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT       ';
  strSQL := strSQL + '  DIR_NOMFRM ';
  strSQL := strSQL + 'FROM         ';
  strSQL := strSQL + '  DIROPE     ';
  strSQL := strSQL + 'WHERE        ';
  strSQL := strSQL + '  OPE_CODOPE = ' + QuotedStr(strLogOpe);
  strSQL := strSQL + '  AND DIR_NOMFRM = ' + QuotedStr(strNomeForm);

  qryAux.Close;
  qryAux.SQL.Text := strSQL;
  qryAux.Open;

  If qryAux.FieldValue('DIR_NOMFRM') <> null Then
    Result := True
  Else
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT         ';
    strSQL := strSQL + '  D.DIR_NOMFRM ';
    strSQL := strSQL + 'FROM           ';
    strSQL := strSQL + '  DIRGPO D     ';
    strSQL := strSQL + '  JOIN CADGPO G ON G.GPO_CODGPO = D.GPO_CODGPO ';
    strSQL := strSQL + '  JOIN OPEGPO O ON O.GPO_CODGPO = G.GPO_CODGPO ';
    strSQL := strSQL + 'WHERE          ';
    strSQL := strSQL + ' O.OPE_CODOPE = ' + QuotedStr(strLogOpe);
    strSQL := strSQL + ' AND D.DIR_NOMFRM = ' + QuotedStr(strNomeForm);

    qryAux.Close;
    qryAux.SQL.Text := strSQL;
    qryAux.Open;

    Result := qryAux.FieldValue('DIR_NOMFRM') <> null;
  End;
end;

function TfraBaseFrame.fTransform(strConteudo: String; intStep: Shortint;
  strChar: String): String;
  Var
    strAux       : String;
    intPosicao   : Integer;
begin
  strAux := '';

  intPosicao := 1;
  While intPosicao < Length(strConteudo) Do
  Begin
    strAux := strAux + Copy(strConteudo, intPosicao, intStep) + strChar;
    Inc(intPosicao, intStep);
  End;

  Result := strAux;
end;

procedure TfraBaseFrame.pCalculaDiasUteis;
var
  dteData: TDate;
begin
  dteData := dteDtaIni;
  fltDiasUteis := 0;
  fltDiasUteisPassados := 0;

  While dteData <= dteDtaFin Do
  Begin
    If fEhDiaUtil(dteData) Then
      fltDiasUteis := fltDiasUteis + 1
    Else If (DayOfWeek(dteData) = 7) and (not fEhFeriado(dteData)) Then
      fltDiasUteis := fltDiasUteis + fltValorSabado
    Else If (DayOfWeek(dteData) = 1) Then
      fltDiasUteis := fltDiasUteis + fltValorDomingo;

    if dteData <= dteHoje Then
      fltDiasUteisPassados := fltDiasUteis;

    dteData := dteData + 1;
  End;

  fltDiasRestantes := fltDiasUteis - fltDiasUteisPassados;
end;

procedure TfraBaseFrame.pCarregaDiasTabelaTemporaria;
var
  dtaCurrent: TDatetime;
begin
  If strTabTmp = '' Then
    Exit;

  Try
    qryAux.Close();
    qryAux.SQL.Clear();
    qryAux.SQL.Add('SELECT COUNT(0) AS DIAS FROM ' + strTabTmp);
    qryAux.Open();

    If (qryAux.FieldValue('DIAS') = 0) Then
    Begin
      dtaCurrent := DataAntIni;

      While dtaCurrent <= DataAntFin Do
      Begin
        qryAux.SQL.Clear();
        qryAux.SQL.Add('INSERT INTO ' + strTabTmp + ' ( DIA, MES ) VALUES ( ');
        qryAux.SQL.Add(' DAY( ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dtaCurrent)) + ' ), ');
        qryAux.SQL.Add(' MONTH( ' + QuotedStr(FormatDateTime('yyyy-mm-dd', dtaCurrent)) + ' ));');

        qryAux.ExecSQL();

        dtaCurrent := IncDay(dtaCurrent);
      End;
    End;
  Finally
    qryAux.SQL.Clear();
    qryAux.Close();
  End;
end;

procedure TfraBaseFrame.pCriaTemporariaQuantidadeClientes;
Var
  strSQL: String;
begin
  pDestroiTemporariaQuantidadeClientes;

  Try
    strSQL := '';
    strSQL := strSQL + 'CREATE TABLE TMP_QTDCLI_' + strLogOpe + ' ';
    strSQL := strSQL + fSqlVendasCliente('G.GER_CODCLI', IncMonth(DataAntIni, -3), IncMonth(DataAntFin, -3));

    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ExecSQL;
  Finally
    qryAux.SQL.Clear();
  End;
end;

procedure TfraBaseFrame.pDestroiTemporariaQuantidadeClientes;
Var
  strSQL: String;
begin
  Try
    strSQL := 'DROP TABLE IF EXISTS TMP_QTDCLI_' + strLogOpe + ' ';

    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ExecSQL;
  Finally
    qryAux.SQL.Clear();
  End;
end;

procedure TfraBaseFrame.pIniciaVariaveis;
var
  intDia: Word;
begin
  dteHoje := fDataAtual();
  DecodeDate(dteHoje, intAnoAtu, intMes, intDia);

  dteDtaIni := EncodeDate(intAnoAtu, intMes, 1);
  dteDtaFin := EncodeDate(intAnoAtu, intMes, DaysInMonth(dteHoje));

  intAnoAnt := intAnoAtu - 1;
  dteAntIni := EncodeDate(intAnoAnt, intMes, 1);

  If (intMes = 2) And (DaysInMonth(dteHoje) = 29) Then //Trata ano bissexto para não dar erro quando procurar o dia 29 no ano que não tem.
  Begin
    dteAntFin := EncodeDate(intAnoAnt, intMes, DaysInMonth(dteHoje) - 1);
  End
  Else
  Begin
    dteAntFin := EncodeDate(intAnoAnt, intMes, DaysInMonth(dteHoje));
  End;

  DataAntIni := IncMonth(dteHoje, -3);
  DataAntIni := StartOfTheMonth(DataAntIni);

  DataAntFin := IncMonth(dteHoje, -1);
  DataAntFin := EndOfTheMonth(DataAntFin);

  pCarregaDiasTabelaTemporaria();

  strClaVen := fTransform(fCfgSis('CLAVEN'), 4);
  strClaDev := fTransform(fCfgSis('CLADEV'), 4);
  strClaBri := '5910_6910_';
  strCliFil := fRetClientesFilial();
  strEmpAcessoUsuarioLogado := fRetEmpAcessoUsuario();
  strCodDeptoUsuarioLogado := fRetCodECarregaInformacoesDepartamento();

  If fCfgSis('DUTIDP') = 'N' Then
  Begin
    fltValorSabado := fCfgSis('SABUTI');
    fltValorDomingo:= 0;
  End;

  pCalculaDiasUteis();

  blnDireitoGeral := fTemDireitoAcesso('DASHBOARD_VER_GERAL');
  blnDireitoEquipe := fTemDireitoAcesso('DASHBOARD_VER_EQUIPE');
  blnUtilizaPrazoMedio := (fCfgSis('PRZMED') = 'S');
end;

{ TDiasUteisDepartamentoHelper }

function TDiasUteisDepartamentoHelper.fGetValue: Double;
begin
  Case Self Of
    dudNaoConsiderar: Exit(0);
    dudIntegral: Exit(1);
    dudTresQuartosDia: Exit(0.75);
    dudMeioDia: Exit(0.5);
  Else
    Exit(0);
  End;
end;

end.
