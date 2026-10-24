unit untFuncoesCRM;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Windows, Messages, Graphics, Controls, Forms, ExtCtrls,
  StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel,
  UniClientDataSet, DBGrids, UniDataSetProvider,
  untFuncoesSimples,
{$ENDIF}
  untAtualizaOcorrenciasCRM,
  SysUtils, Variants, Classes, DB, Uni, StrUtils,
  DateUtils, untTypesSistema,
  untTypesCRM, untIFuncoesCRM;

type
  //Passado para tinta de maquina poder utilizar as ocorrencias do crm
  TFuncoesCRM = class(TInterfacedObject, IFuncoesCRM)
  public
    function fAtualizaInformacoesCRM(strNumDoc_CRM, strEspDoc_CRM,
      strCodEmp_CRM, strCodCli_CRM, strNumOrc_CRM, strEspOrc_CRM,
      strOpeDes_CRM: String; afcAcaFat_CRM: TAcaoFatCRM;
      strEmpFat_CRM: String = ''; strCpfCli_CRM: String = '';
      strCodCliAnt_CRM: String = ''): IAtuOcoCrm;

    function fRetornaCodigoOcorrencia(strNumDoc, strEspDoc, strCodCli,
      strCodEmp, strNumRom: String; strNumOrc: String = '';
      strEspOrc: String = ''): String;
  end;

var
  objAtuOcoCrm: TAtuOcoCrm;

{$IFNDEF LINUX}
  function fRetornaParaMovOcorrencias(strEmailCli,strEmailOpe: String): TStringArray;
  procedure pChamaFormImpOcorrencias(qryOcorr,qryProdDev, qryEndCliDev: TUniQuery);
  procedure pEnviaEmailParaClienteInformandoDV(strCodCli, strNomCli, strNumDoc: String;
    dtaDtaEnt: TDateTime; fltVlrCon: Double; strCodOpe, strCliEma: String);
  procedure pImprimirOcorrencias(strCodOco, strCodEmp, strTip_Fc: String);
{$ENDIF}
  function VerificarAcessoClienteOrdemDeProducaoIndustrial(Const ACodigoCliente : String) : Boolean;
  function fRetornaRemetente(strCodOpe: String): String;
  function fFormataTextoMovOcorrencias(strCodCli,strNomCli,
                                       strCodGoc,strNomGoc,
                                       strDtaInc,strHorInc,strDtaCon,strHorCon,
                                       strTipOco,strNomToc,
                                       strOpeOco,strNomOpeOco,
                                       strDescri,
                                       strCodCoc,strNomCoc,strTip_Fc,
                                       strProcol: String; blnDevolucao: Boolean;
                                       strEmpDoc: String = '';
                                       strEspDoc: String = '';
                                       strNumDoc: String = '';
                                       strNumLead: String = ''):String;
  function fOcorrenciaConcluida(dDataConc: TDateTime; dHoraConc: TDateTime): Boolean;
  function fRetornaParaEnvolvidosOcorrencias(strEmailCli,strCodOco: String): String;
  function fFormataTextoEnvolvidosOcorrencias(strCodCli,strNomCli,
                                              strCodGoc,strNomGoc,
                                              strCodToc,strNomToc,
                                              strCodOco: String): String;
  function fAtualizaInformacoesCRM(strNumDoc_CRM,strEspDoc_CRM,strCodEmp_CRM,
    strCodCli_CRM,strNumOrc_CRM,strEspOrc_CRM, strOpeDes_CRM: String;
    afcAcaFat_CRM: TAcaoFatCRM; strEmpFat_CRM: String = ''; strCpfCli_CRM: String = '';
    strCodCliAnt_CRM: String = ''; strCodFaz: String = ''): TAtuOcoCrm;
  function fExisteOrcamentoHisOcoCrm(strNumDoc, strEspDoc, strCodCli, strCodEmp: String): Boolean;
  function fRetornaCodigoOcorrencia(strNumDoc,strEspDoc,strCodCli,strCodEmp,strNumRom: String; strNumOrc: String = ''; strEspOrc: String = ''): String;
  function fOcorrenciaDevolucao(strCodToc, strTip_Fc: String): Boolean;
  function fOcorrenciaCancelamentoDocumentoVenda(strCodToc: String): Boolean;
  function fOcorrenciaCancelamentoPedidoVenda(strCodToc: String): Boolean;
  function fOcorrenciaDesmembramentoCortePedidoFaltaEstoque(strCodToc, strTip_Fc: String): Boolean;
  function fRetornaSQLOcorrencias(strTip_Fc: String): String;
  function fRetornaSQLOcorrenciasHistorico(strTip_Fc: String): String;
  function fRetornaSQLProdutosDevolucao: String;
  function fRetornaSQLEnderecosClienteDevolucao: String;
  function fRetornaSQLInformacoesCliente: String;
  function fRetornaSQLInformacoesFornecedores: String;
  function fRetornaSQLInformacoesProspecto: String;
  function fRetornaSQLInformacoesContatos: String;
  function fRetornaSQLInformacoesContatosFornecedores: String;
  function fRetornaSQLInformacoesEnderecos: String;
  function fRetornaSQLInformacoesGrupoOcorrencias(strTip_Fc: String = 'C'; blnSomenteOperadorLogado: Boolean = False): String;
  function fRetSQLVerificaDireitoAcessoGrupoOcorrencias: String;
  function fRetornaSQLInformacoesOcorrencias(strTip_Fc: String = 'C'; strChaveLead: String = ''): String;
  function fRetornaSQLOcorrenciasEmergenciais(strTip_Fc: String = 'C'): String;
  function fRetornaSQLUltimasVendasProduto(strNomCol: String): String;
  function fRetornaVendedorUltCompra(strNumDoc, strEspDoc, strCodEmp: String): String;
  function fRetornaSQLAgendaCompromissos: String;
  function fRetornaSQLConsultaDevolucao: String;

  function  fExitemCompromissos: Boolean;
  function  fQuantidadeDevolvida(strNumDoc, strEspDoc, strCodEmp, strCodIte, strCodCli: String; strCodDev: String = ''): Double;
  function fGeraTextoHistorico(dtaData, dtaHora: TDateTime; strNomeOpe, strTexto: String): String;
  function fRetornaTotalDaAD(strNumAde: String): Double;
  function fRetornaInconsistencias(strNumAde: String;
    strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie: String): String;
  function fRetornaOcorrenciaDoAD(strNumAde: String): String;
  function fRetornaSQLInformacoesFazendas: String;

  function fAtualizaOcorrenciaDevolucaoCRM(strNumAde: String; dtaDtaEnt: TDateTime;
    strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strCodVen: String; fltVlrCon: Double;
    strTabela: String; blnMostraErro : Boolean = True): Boolean;

  Function fEnviaMensagemParaOperadorAD(strCodAde, strCodOpe, strCodCli, strNomCli: String): Boolean;

  Function fEnviaMensagemDevolucaoParaOperadorAD(strCodAde, strCodCli, strDocumento: String): Boolean;

  procedure pMarcaDocumentoDevAD(strCodAde, strCodEmp, strDocDev, strEspDev, strEmpDev: String);

  Procedure pRetornaDadosAD(strNumAut, strCodEmp: String;
                            Var strDocsSel, strCodVen, strCodRep, strCodCli: String);

  function fRetornaRegimeTributario(strRegTri: String): String;

  function fVerificaDireitoAcessoGrupoOcorrencia(strCodGoc : String) : Boolean;

  procedure pGeraHisOcoConferencia(const strAutInc: String; const afcAcao: TAcaoFatCRM);
  procedure pPesquisaSitOco(qryTabOri, qryTabela: TUniQuery; strCodSit: String);
  procedure pAtualizarOcorrenciaCrmConfDoc(documento: TDocumentoCRM;
    strCodEmpConf: String; strNumDocConf: String; strEspDocConf: String;
    strCodOpeConf: String);

  function fTipOcoInformaTemperaturaAtendimento(const strCodGoc, strCodToc: String): Boolean;
  procedure pAlterarTemperaturaAtendimento(const strTipFc, srtCodOco, strCodEmp, strCodTea: String);
  function fVerificaPermiteCancelarDocumentoCRM(const strNumDoc,strEspDoc,strCodCli,strCodEmp,strNumRom: String;
    strNumOrc: String = ''; strEspOrc: String = ''): Boolean;
  procedure pFinalizarOcorrenciaDocumentoCancelado(const strNumDoc, strEspDoc, strCodCli,
    strCodEmp, strTipFc: String);
  procedure pReabrirOcorrenciaPorDocumento(const strNumDoc, strEspDoc, strCodCli,
   strCodEmp, strTipFc: String);

  function fEnviarOcorrenciaPorEmail(const strCodToc : String) : Boolean;
  function fOcorrenciaPossuiADVinculada(const ACodOco: String; ACodEmp: String): Boolean;

implementation

uses
{$IFDEF LINUX}
{$ELSE}
  untCfgRel, untQckOcorrenciasCRM, untDigDataHora,
  untConsultas, untTEnvioEmail,
{$ENDIF}
  untDivergenciasDevAD,
  untConstantes, untMsgInterna,
  untFuncoesGenerica, untProximoCodigo;

function fRetornaRemetente(strCodOpe: String): String;
var
  qryConsulta: TUniQuery;
begin
  try
    qryConsulta := fCriaQuery(Nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT SQL_NO_CACHE OPE_E_MAIL FROM CADOPE WHERE OPE_CODOPE = :CODOPE ');
      Params.ParamByName('CODOPE').AsString := strCodOpe;
      Open;
      Result := FieldByName('OPE_E_MAIL').AsString;
    end;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

{$IFNDEF LINUX}
function fRetornaParaMovOcorrencias(strEmailCli,strEmailOpe: String): TStringArray;
  Var
    strDestinatarios: String;
    arrDestinatarios, arrArquivos: TStringArray;
begin
  strDestinatarios := StringReplace(Trim(strEmailCli), ',', ';', [rfReplaceAll]);

  If (Not SameText(Copy(strDestinatarios, Length(strDestinatarios) - 1, 1), ';')) Then
    strDestinatarios := strDestinatarios + ';';

  strDestinatarios := strDestinatarios + StringReplace(Trim(strEmailOpe), ',', ';', [rfReplaceAll]);

  If (Not SameText(Copy(strDestinatarios, Length(strDestinatarios) - 1, 1), ';')) Then
    strDestinatarios := strDestinatarios + ';';

  pCriarArrayAnexosEDestinatarios('',
                                  strDestinatarios,
                                  arrDestinatarios,
                                  arrArquivos);

  Result := arrDestinatarios;
end;
{$ENDIF}

function fFormataTextoMovOcorrencias(strCodCli,strNomCli,
                                     strCodGoc,strNomGoc,
                                     strDtaInc,strHorInc,strDtaCon,strHorCon,
                                     strTipOco,strNomToc,
                                     strOpeOco,strNomOpeOco,
                                     strDescri,strCodCoc,strNomCoc,
                                     strTip_Fc,strProcol: String; blnDevolucao: Boolean;
                                     strEmpDoc: String = '';
                                     strEspDoc: String = '';
                                     strNumDoc: String = '';
                                     strNumLead: String = ''):String;
var
  CorpoMensagem: TStringList;
begin
  CorpoMensagem := TStringList.Create;
  try
    CorpoMensagem.Add('<br>');
    CorpoMensagem.Add('<p style="line-height: 1.5">');
    If blnDevolucao Then
    Begin
      CorpoMensagem.Add(' Prezado cliente, '  + '<br>');
      CorpoMensagem.Add(' O Departamento de Atendimento ao Cliente (DAC), informa que a sua '  + '<br>');
      CorpoMensagem.Add(' solicitação de devolução e ou garantia foi atendida com sucesso '  + '<br>');
      CorpoMensagem.Add(' gerando um crédito conforme as informações da Autorização de Devolução (A.D.) abaixo. '  + '<br>');
      CorpoMensagem.Add(' Esse valor estará disponível para utilização após o recebimento e conferência da mercadoria. ' + '<br>');
      CorpoMensagem.Add(' Qualquer divergência entre a Autorização de Devolução (A.D.) ' + '<br>');
      CorpoMensagem.Add(' e a sua nota fiscal poderá alterar o valor do crédito.');
    End
    Else
    Begin
      CorpoMensagem.Add(' Informamos que uma nova Ocorrência foi Criada pelo CRM');
    End;

    CorpoMensagem.Add('<br><br>');
    CorpoMensagem.Add('<b> OPERADOR DE ORIGEM : </b>' + fRetNomeOperador(strLoginUsuarioLogado)  + ' <br>');
    CorpoMensagem.Add('<b> USUÁRIO DESTINO : </b>' + strOpeOco + ' - ' + fRetNomeOperador(strOpeOco));

    If Not fEmptyStr(strNumLead) Then
    Begin
      CorpoMensagem.Add('<br>');
      CorpoMensagem.Add('<b> LEAD : </b>' + strNumLead);
    End;

    CorpoMensagem.Add(' <br><br>');
    CorpoMensagem.Add(' Informações da Ocorrência : ');
    CorpoMensagem.Add(' <br><br>');

    If strTip_Fc = 'P' Then
      CorpoMensagem.Add('<b> CLIENTE PROSPECTO : </b>' + strCodCli + ' - ' + strNomCli + '<br>')
    Else
    If strTip_Fc = 'C' Then
      CorpoMensagem.Add('<b> CLIENTE : </b>' + strCodCli + ' - ' + strNomCli + '<br>')
    Else
      CorpoMensagem.Add('<b> FORNECEDOR :  </b>' + strCodCli + ' - ' + strNomCli + '<br>');
    CorpoMensagem.Add('<b> GRUPO DA OCORRÊNCIA :  </b>' + strCodGoc + ' - ' + strNomGoc + '<br>');
    CorpoMensagem.Add('<b> DATA/HORA : </b>' + strDtaInc + ' - ' + strHorInc + '<br>');
    if (not fEmptyStr(strDtaCon)) and (not fEmptyStr(strHorCon))  then
      CorpoMensagem.Add('<b> DATA/HORA CONCLUSÃO : </b>' + strDtaCon + ' - ' + strHorCon +'<br>');
    CorpoMensagem.Add('<b> TIPO DA OCORRÊNCIA : </b>' + strTipOco + ' - ' + strNomToc + '<br>');
    CorpoMensagem.Add('<b> COMPLEMENTO DA OCORRÊNCIA : </b>' + strCodCoc + ' - ' + strNomCoc + '<br>');
    If Not fEmptyStr(strNumDoc) Then
    Begin
      If strEspDoc = 'PD' Then
        CorpoMensagem.Add('<b> PEDIDO :  </b>' + strNumDoc + ' - Empresa: ' + strEmpDoc + '<br>');
      If strEspDoc = 'OR' Then
        CorpoMensagem.Add('<b> ORÇAMENTO : </b>' + strNumDoc + ' - Empresa: ' + strEmpDoc + '<br>');
    End;
    CorpoMensagem.Add('<b> HISTÓRICO : </b><br>');
    CorpoMensagem.Add('</p>');
    CorpoMensagem.Add('<pre>');
    CorpoMensagem.Add('<p style="line-height: 1.5; margin-left:50px">');
    CorpoMensagem.Add(strDescri);
    CorpoMensagem.Add('</p>');
    CorpoMensagem.Add('</pre>');
    CorpoMensagem.Add('<p style="line-height: 1.5">');
    CorpoMensagem.Add('<b> PROTOCOLO : </b>' + strProcol + '<br>');
    CorpoMensagem.Add('</p>');

  finally
    Result := CorpoMensagem.Text;
    FreeAndNil(CorpoMensagem);
  end;

end;

function fOcorrenciaConcluida(dDataConc: TDateTime; dHoraConc: TDateTime): Boolean;
begin
  Result := (dDataConc > 0) And (dHoraConc > 0);
end;

function fRetornaParaEnvolvidosOcorrencias(strEmailCli,strCodOco: String): String;
var
  qryConsulta: TUniQuery;
begin
  Result := strEmailCli;
  try
    qryConsulta := fCriaQuery(Nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT SQL_NO_CACHE OPEDES.OPE_E_MAIL AS EMAIL_OPEDES ');
      SQL.Add('  FROM MOVOCO ');
      SQL.Add(' INNER JOIN HISOCO ON HIS_CODOCO = OCO_CODOCO ');
      SQL.Add(' INNER JOIN CADOPE OPEDES ON OPEDES.OPE_CODOPE = HIS_CODOPE ');
      SQL.Add(' WHERE OCO_DTACON IS NOT NULL ');
      SQL.Add('   AND OCO_HORCON IS NOT NULL ');
      SQL.Add('   AND OCO_CODOCO = :CODOCO   ');
      Params.ParamByName('CODOCO').AsString := strCodOco;
      Open;
      First;
      while not eof do
      begin
        if not fEmptyStr(FieldByName('EMAIL_OPEDES').AsString) then
          Result := Result + ';' + FieldByName('EMAIL_OPEDES').AsString;
        Next;
      end;
    end;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

function fFormataTextoEnvolvidosOcorrencias(strCodCli,strNomCli,strCodGoc,strNomGoc,
                                            strCodToc,strNomToc,strCodOco: String): String;
var
  qryConsulta: TUniQuery;
  strTexto,
  strTextoCab   : String;
begin
  Result := '';
  strTextoCab := '';
  try
    qryConsulta := fCriaQuery(Nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT SQL_NO_CACHE ');
      SQL.Add('        HIS_DTAINC,  ');
      SQL.Add('        HIS_HORINC,  ');
      SQL.Add('        HIS_DTACON,  ');
      SQL.Add('        HIS_HORCON,  ');
      SQL.Add('        HIS_OPEHIS,  ');
      SQL.Add('        OPEHIS.OPE_NOMOPE AS NOMOPEHIS, ');
      SQL.Add('        OPEHIS.OPE_E_MAIL AS EMAIL_OPEHIS, ');
      SQL.Add('        HIS_CODOPE,  ');
      SQL.Add('        OPEDES.OPE_NOMOPE AS NOMOPEDES, ');
      SQL.Add('        OPEDES.OPE_E_MAIL AS EMAIL_OPEDES, ');
      SQL.Add('        HIS_DESCRI   ');
      SQL.Add('   FROM MOVOCO       ');
      SQL.Add('  INNER JOIN HISOCO ON HIS_CODOCO = OCO_CODOCO ');
      SQL.Add('  INNER JOIN CADOPE OPEHIS ON OPEHIS.OPE_CODOPE = HIS_OPEHIS ');
      SQL.Add('  INNER JOIN CADOPE OPEDES ON OPEDES.OPE_CODOPE = HIS_CODOPE ');
      SQL.Add('  WHERE OCO_DTACON IS NOT NULL ');
      SQL.Add('    AND OCO_CODOCO = :CODOCO   ');
      Params.ParamByName('CODOCO').AsString := strCodOco;
      Open;
      First;
      while not eof do
      begin
        strTexto := '';
        strTexto := #13#10 + #13#10;
        strTexto := strTexto + ' Informações da Ocorrência : ' + #13#10;
        strTexto := strTexto + #13#10 + #13#10;
        strTexto := strTexto + ' Data/Hora           : ' + FieldByName('HIS_DTAINC').AsString + ' - ' + FieldByName('HIS_HORINC').AsString + #13#10;
        strTexto := strTexto + ' Data/Hora Conclusão : ' + FieldByName('HIS_DTACON').AsString + ' - ' + FieldByName('HIS_HORCON').AsString + #13#10;
        strTexto := strTexto + ' Usuário Ocorrência  : ' + FieldByName('HIS_OPEHIS').AsString + ' - ' + FieldByName('NOMOPEHIS').AsString  + #13#10;
        strTexto := strTexto + ' Usuário Destino     : ' + FieldByName('HIS_CODOPE').AsString + ' - ' + FieldByName('NOMOPEDES').AsString + #13#10;
        strTexto := strTexto + #13#10 + #13#10;
        strTexto := strTexto + ' Histórico           : ' + #13#10;
        strTexto := strTexto + FieldByName('HIS_DESCRI').AsString + #13#10;

        Result := Result + strTexto;

        Next;
      end;

      strTextoCab := 'Informamos que a Ocorrência do Cliente : ' + strCodCli + ' - ' + strNomCli + ' Grupo de Ocorrência: ' + strCodGoc + ' - ' + strNomGoc;
      strTextoCab := strTextoCab + ' do Tipo : ' + strCodToc + ' - ' + strNomToc + ' foi finalizada.' + #13#10;
      strTextoCab := strTextoCab + 'Informamos abaixo todos os históricos da Ocorrência : ' + #13#10;

      Result := strTextoCab + Result;
    end;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

function fAtualizaInformacoesCRM(strNumDoc_CRM,strEspDoc_CRM,strCodEmp_CRM,
    strCodCli_CRM,strNumOrc_CRM,strEspOrc_CRM, strOpeDes_CRM: String;
    afcAcaFat_CRM: TAcaoFatCRM; strEmpFat_CRM: String = ''; strCpfCli_CRM: String = '';
    strCodCliAnt_CRM: String = ''; strCodFaz: String = ''): TAtuOcoCrm;
begin
  Result := TAtuOcoCrm.Create(nil);
  Result.strNumDoc := strNumDoc_CRM;
  Result.strEspDoc := strEspDoc_CRM;
  Result.strCodEmp := strCodEmp_CRM;
  Result.strCodCli := strCodCli_CRM;
  Result.strNumOrc := strNumOrc_CRM;
  Result.strEspOrc := strEspOrc_CRM;
  Result.strEmpFat := strEmpFat_CRM;
  Result.strCodOpe := strOpeDes_CRM;
  Result.afcAcaFat := afcAcaFat_CRM;
  Result.strCpfCli := strCpfCli_CRM;
  Result.strCodCliAnt := strCodCliAnt_CRM;
  Result.strCodFaz := strCodFaz;
end;

function fExisteOrcamentoHisOcoCrm(strNumDoc, strEspDoc, strCodCli, strCodEmp: String): Boolean;
var
  qryConsulta: TUniQuery;
begin
  try
    qryConsulta := fCriaQuery(Nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT SQL_NO_CACHE OCO_NUMDOC ');
      SQL.Add('  FROM MOVOCO ');
      SQL.Add(' INNER JOIN HISOCO ON HIS_CODOCO = OCO_CODOCO ');
      SQL.Add(' WHERE HIS_NUMDOC = :NUMDOC ');
      SQL.Add('   AND HIS_ESPDOC = :ESPDOC ');
      SQL.Add('   AND HIS_CODEMP = :CODEMP ');
      SQL.Add('   AND OCO_CODCLI = :CODCLI ');
      SQL.Add('   AND OCO_TIP_FC = "C"     ');
      Params.ParamByName('NUMDOC').AsString := strNumDoc;
      Params.ParamByName('ESPDOC').AsString := strEspDoc;
      Params.ParamByName('CODCLI').AsString := strCodCli;
      Params.ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      Result := FieldByName('OCO_NUMDOC').AsString <> '';
    end;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

function fRetornaCodigoOcorrencia(strNumDoc,strEspDoc,strCodCli,strCodEmp,strNumRom: String; strNumOrc: String = ''; strEspOrc: String = ''): String;
var
  qryConsulta: TUniQuery;
begin
  Result := '';
  try
    qryConsulta := fCriaQuery(Nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT SQL_NO_CACHE OCO_CODOCO ');
      SQL.Add('  FROM MOVOCO ');
      SQL.Add(' INNER JOIN HISOCO ON HIS_CODOCO = OCO_CODOCO ');
      SQL.Add(' WHERE '+IIF(fEmptyStr(strNumOrc), 'HIS_NUMDOC', 'OCO_NUMDOC')+' = :NUMDOC ');
      SQL.Add('   AND '+IIF(fEmptyStr(strEspOrc), 'HIS_ESPDOC', 'OCO_ESPDOC')+' = :ESPDOC ');
      SQL.Add('   AND HIS_CODEMP = :CODEMP ');
      If Not fEmptyStr(strCodCli) Then
        SQL.Add('   AND OCO_CODCLI = :CODCLI ');

//      SQL.Add('   AND OCO_TIP_FC = "C"     ');

      If Not fEmptyStr(strNumRom) Then
        SQL.Add('   AND HIS_NUMROM = :NUMROM ');

      SQL.Add('ORDER BY OCO_CODOCO DESC');

      Params.ParamByName('NUMDOC').AsString := IIF(fEmptyStr(strNumOrc), strNumDoc, strNumOrc);
      Params.ParamByName('ESPDOC').AsString := IIF(fEmptyStr(strEspOrc), strEspDoc, strEspOrc);
      If Not fEmptyStr(strCodCli) Then
        Params.ParamByName('CODClI').AsString := strCodCli;
      Params.ParamByName('CODEMP').AsString := strCodEmp;
      If Not fEmptyStr(strNumRom) Then
        Params.ParamByName('NUMROM').AsString := strNumRom;

      Open;
      Result := FieldByName('OCO_CODOCO').AsString;
    end;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

function fOcorrenciaDevolucao(strCodToc, strTip_Fc: String): Boolean;
begin
  //Por enquanto somente haverá devolucao para clientes.
  //Hoje o CRM serve tanto para cliente como para fornecedor.
  Result := (fCfgSis('VENDEV', varString) = strCodToc) And (strTip_Fc = 'C');
end;

function fOcorrenciaDesmembramentoCortePedidoFaltaEstoque(strCodToc, strTip_Fc: String): Boolean;
begin
  Result := (fCfgSis('OCODMP', varString) = strCodToc) And (strTip_Fc = 'C');
end;

function fOcorrenciaCancelamentoDocumentoVenda(strCodToc : String): Boolean;
begin
  Result := (fCfgSis('VENCAN', varString) = strCodToc);
end;

function fOcorrenciaCancelamentoPedidoVenda(strCodToc : String): Boolean;
begin
  Result := (fCfgSis('PEDCAN', varString) = strCodToc);
end;

{$IFNDEF LINUX}
procedure pImprimirOcorrencias(strCodOco, strCodEmp, strTip_Fc: String);
var
  qryOcorr,
  qryProdDev,
  qryEndCliDev : TUniQuery;
begin
  Try
    qryOcorr   := fCriaQuery(nil);
    qryProdDev := fCriaQuery(nil);
    qryEndCliDev := fCriaQuery(nil);

    //Ocorrências
    with qryOcorr do
    begin
      Close;
      SQL.Clear;
      SQL.Add(fRetornaSQLOcorrenciasHistorico(strTip_Fc));
      ParamByName('CODOCO').AsString := strCodOco;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
    end;

    //Produtos Devolucao
    with qryProdDev do
    begin
      Close;
      SQL.Clear;
      SQL.Add(fRetornaSQLProdutosDevolucao);
      ParamByName('CODOCO').AsString := strCodOco;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
    end;

    If (strTip_Fc = 'C') Then
    Begin
      qryEndCliDev.Close;
      qryEndCliDev.SQL.Clear;
      qryEndCliDev.SQL.Add(fRetornaSQLEnderecosClienteDevolucao);
      qryEndCliDev.ParamByName('CODOCO').AsString := strCodOco;
      qryEndCliDev.ParamByName('CODEMP').AsString := strCodEmp;
      qryEndCliDev.Open;
    end;

    pChamaFormImpOcorrencias(qryOcorr, qryProdDev, qryEndCliDev);

  Finally
    FreeAndNil(qryOcorr);
    FreeAndNil(qryProdDev);
    FreeAndNil(qryEndCliDev);
  End;
end;
{$ENDIF}

function fRetornaSQLOcorrencias(strTip_Fc: String): String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE                                   ';
  Result := Result + '        OCO_CODOCO,                                    ';
  Result := Result + '        OCO_PROTOC,                                    ';
  Result := Result + '        OCO_TIP_FC,                                    ';
  If strTip_Fc = 'P' Then
  Begin
    Result := Result + '        PRO_CODPRO AS CLI_CODCLI,                      ';
    Result := Result + '        CONCAT(PRO_CODPRO," - ",PRO_NOMCLI) AS DESCLI, ';
    Result := Result + '        PRO_C_G_C_ AS CLI_C_G_C_,                      ';
    Result := Result + '        PRO_EMAIL_ AS CLI_EMAIL_,                      ';
    Result := Result + '        "PROSPECTO" AS DESTIP,                         ';
  End
  Else
  If strTip_Fc = 'C' Then
  Begin
    Result := Result + '        CLI_CODCLI,                                    ';
    Result := Result + '        CONCAT(CLI_CODCLI," - ",CLI_NOMCLI) AS DESCLI, ';
    Result := Result + '        CLI_C_G_C_,                                    ';
    Result := Result + '        CLI_EMAIL_,                                    ';
    Result := Result + '        CONCAT(TIP_CODTIP," - ",TIP_DESTIP) AS DESTIP, ';
  End
  Else
  Begin
    Result := Result + '        FOR_CODFOR AS CLI_CODCLI,                      ';
    Result := Result + '        CONCAT(FOR_CODFOR," - ",FOR_NOMFOR) AS DESCLI, ';
    Result := Result + '        FOR_C_G_C_ AS CLI_C_G_C_,                      ';
    Result := Result + '        FOR_EMAIL_ AS CLI_EMAIL_,                      ';
    Result := Result + '        "" AS DESTIP,                                  ';
  End;
  Result := Result + '        CONCAT(ATI_CODATI," - ",ATI_DESATI) AS DESATI, ';

  Result := Result + '        GOC_CODGOC,                            ';
  Result := Result + '        GOC_DESGOC,                            ';
  Result := Result + '        TOC_CODTOC,                            ';
  Result := Result + '        TOC_DESTOC,                            ';
  Result := Result + '        OCO_DESCRI,                            ';
  Result := Result + '        EMP_CODEMP,                            ';
  Result := Result + '        EMP_NOMEMP,                            ';
  Result := Result + '        OCO_TIP_FC                             ';
  Result := Result + '   FROM MOVOCO                                 ';

  If strTip_Fc = 'P' Then
    Result := Result + '  INNER JOIN PROSPE ON PRO_CODPRO = OCO_CODCLI '
  Else
  If strTip_Fc = 'C' Then
    Result := Result + '  INNER JOIN CADCLI ON CLI_CODCLI = OCO_CODCLI '
  Else
    Result := Result + '  INNER JOIN CADFOR ON FOR_CODFOR = OCO_CODCLI ';
  Result := Result + '  INNER JOIN CADTOC ON TOC_CODTOC = OCO_CODTOC ';
  Result := Result + '  INNER JOIN CADGOC ON GOC_CODGOC = TOC_CODGOC ';
  Result := Result + '  INNER JOIN CADEMP ON EMP_CODEMP = OCO_CODEMP ';

  If strTip_Fc = 'P' Then
    Result := Result + '   LEFT JOIN CADATI ON ATI_CODATI = PRO_CODATI '
  Else
  If strTip_Fc = 'C' Then
  Begin
    Result := Result + '   LEFT JOIN CADATI ON ATI_CODATI = CLI_CODATI ';
    Result := Result + '   LEFT JOIN TIPCLG ON TIP_CODTIP = CLI_TIPCLI ';
  End
  Else
    Result := Result + '   LEFT JOIN CADATI ON ATI_CODATI = FOR_CODATI ';  
  Result := Result + '  WHERE OCO_CODOCO = :CODOCO ';
  Result := Result + '    AND OCO_CODEMP = :CODEMP ';
  Result := Result + '    AND OCO_TIP_FC = ' + QuotedStr(strTip_Fc);
end;

function fRetornaSQLOcorrenciasHistorico(strTip_Fc: String): String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE                                   ';
  Result := Result + '        OCO_CODOCO,                                    ';
  Result := Result + '        OCO_PROTOC,                                    ';
  Result := Result + '        OCO_TIP_FC,                                    ';
  If strTip_Fc = 'P' Then
  Begin
    Result := Result + '        PRO_CODPRO AS CLI_CODCLI,                      ';
    Result := Result + '        CONCAT(PRO_CODPRO," - ",PRO_NOMCLI) AS DESCLI, ';
    Result := Result + '        PRO_C_G_C_ AS CLI_C_G_C_,                      ';
    Result := Result + '        PRO_EMAIL_ AS CLI_EMAIL_,                      ';
    Result := Result + '        "PROSPECTO" AS DESTIP,                         ';
  End
  Else
  If strTip_Fc = 'C' Then
  Begin
    Result := Result + '        CLI_CODCLI,                                    ';
    Result := Result + '        CONCAT(CLI_CODCLI," - ",CLI_NOMCLI) AS DESCLI, ';
    Result := Result + '        CLI_C_G_C_,                                    ';
    Result := Result + '        CLI_EMAIL_,                                    ';
    Result := Result + '        CONCAT(TIP_CODTIP," - ",TIP_DESTIP) AS DESTIP, ';
  End
  Else
  Begin
    Result := Result + '        FOR_CODFOR AS CLI_CODCLI,                      ';
    Result := Result + '        CONCAT(FOR_CODFOR," - ",FOR_NOMFOR) AS DESCLI, ';
    Result := Result + '        FOR_C_G_C_ AS CLI_C_G_C_,                      ';
    Result := Result + '        FOR_EMAIL_ AS CLI_EMAIL_,                      ';
    Result := Result + '        "" AS DESTIP,                                  ';
  End;
  Result := Result + '        CONCAT(ATI_CODATI," - ",ATI_DESATI) AS DESATI, ';

  Result := Result + '        GOC_CODGOC,                                        ';
  Result := Result + '        GOC_DESGOC,                                        ';
  Result := Result + '        TOC_CODTOC,                                        ';
  Result := Result + '        TOC_DESTOC,                                        ';
  Result := Result + '        REPLACE(OCO_DESCRI, "<<csq>>", '+ QuotedStr(sLineBreak) +') AS OCO_DESCRI, ';
  Result := Result + '        EMP_CODEMP,                                        ';
  Result := Result + '        EMP_NOMEMP,                                        ';
  Result := Result + '        OCO_TIP_FC,                                        ';
  Result := Result + '        REPLACE(HIS_DESCRI, "<<csq>>", '+ QuotedStr(sLineBreak) +') AS HIS_DESCRI, ';
  Result := Result + '        HIS_CODOPE,                                        ';
  Result := Result + '        O.OPE_NOMOPE,                                      ';
  Result := Result + '        HIS_OPEHIS,                                        ';
  Result := Result + '        H.OPE_NOMOPE AS NOMHIS,                            ';
  Result := Result + '        HIS_DTAINC,                                        ';
  Result := Result + '        HIS_DTAINC,                                        ';
  Result := Result + '        HIS_HORINC,                                        ';
  Result := Result + '        COC_DESCOC                                         ';
  Result := Result + '   FROM MOVOCO                                             ';

  If strTip_Fc = 'P' Then
    Result := Result + '  INNER JOIN PROSPE ON PRO_CODPRO = OCO_CODCLI '
  Else
  If strTip_Fc = 'C' Then
    Result := Result + '  INNER JOIN CADCLI ON CLI_CODCLI = OCO_CODCLI '
  Else
    Result := Result + '  INNER JOIN CADFOR ON FOR_CODFOR = OCO_CODCLI ';
  Result := Result + '  INNER JOIN CADTOC ON TOC_CODTOC = OCO_CODTOC ';
  Result := Result + '  INNER JOIN CADGOC ON GOC_CODGOC = TOC_CODGOC ';
  Result := Result + '  INNER JOIN CADEMP ON EMP_CODEMP = OCO_CODEMP ';
  Result := Result + '  LEFT  JOIN CADCOC ON COC_CODCOC = OCO_CODCOC ';

  If strTip_Fc = 'P' Then
    Result := Result + '   LEFT JOIN CADATI ON ATI_CODATI = PRO_CODATI '
  Else
  If strTip_Fc = 'C' Then
  Begin
    Result := Result + '   LEFT JOIN CADATI ON ATI_CODATI = CLI_CODATI ';
    Result := Result + '   LEFT JOIN TIPCLG ON TIP_CODTIP = CLI_TIPCLI ';
  End
  Else
    Result := Result + '   LEFT JOIN CADATI ON ATI_CODATI = FOR_CODATI ';
  Result := Result + '  INNER JOIN HISOCO ON HIS_CODOCO = OCO_CODOCO ';
  Result := Result + '  LEFT JOIN CADOPE O ON O.OPE_CODOPE = HIS_CODOPE ';
  Result := Result + '  LEFT JOIN CADOPE H ON H.OPE_CODOPE = HIS_OPEHIS ';
  Result := Result + '  WHERE OCO_CODOCO = :CODOCO ';
  Result := Result + '    AND OCO_CODEMP = :CODEMP ';
  Result := Result + '    AND OCO_TIP_FC = ' + QuotedStr(strTip_Fc);
  Result := Result + '  ORDER BY HIS_DTAINC DESC, HIS_HORINC DESC, HISOCO.AUTOINCREM DESC  ';
end;

function fRetornaSQLProdutosDevolucao: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '        GER_CODADE,  ';
  Result := Result + '        GER_CODOCO,  ';
  Result := Result + '        ITE_CODITE,  ';
  Result := Result + '        ITE_DESITE,  ';
  Result := Result + '        ITE_CODFAB,  ';  
  Result := Result + '        UNI_SIGUNI,  ';
  Result := Result + '        DET_QTDDEV,  ';
  Result := Result + '        DET_UNIDEV,  ';
  Result := Result + '        "DEV" AS DEVOLUCAO, ';
  Result := Result + '        DET_GARANT,  ';
  Result := Result + '        DET_QTDDEV * DET_UNIDEV AS DET_TOTDEV, ';
  Result := Result + '        CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP) AS NUMDOC, ';
  Result := Result + '        DET_DTAMOV   ';
  Result := Result + '   FROM ADEGER       ';
  Result := Result + '  INNER JOIN ADEDET ON DET_CODADE = GER_CODADE ';
  Result := Result + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';
  Result := Result + '  INNER JOIN CADOCO ON OCO_CODOCO = DET_CODMOT ';
  Result := Result + '  INNER JOIN MOVOCO O ON O.OCO_CODOCO = GER_CODOCO ';
  Result := Result + '   LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  Result := Result + '  WHERE O.OCO_CODOCO = :CODOCO ';
  Result := Result + '    AND O.OCO_CODEMP = :CODEMP ';
  Result := Result + '    ORDER BY ITE_CODITE ';
end;

function fRetornaSQLEnderecosClienteDevolucao: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE E.*, I.CID_NOMCID, I.CID_ESTADO ';
  Result := Result + ' FROM MOVOCO M      ';
  Result := Result + '   INNER JOIN CADTOC T ON T.TOC_CODTOC = M.OCO_CODTOC ';
  Result := Result + '   INNER JOIN CADCLI C ON C.CLI_CODCLI = M.OCO_CODCLI ';
  Result := Result + '   INNER JOIN ENTCLI E ON E.ETC_CODCLI = C.CLI_CODCLI ';
  Result := Result + '   INNER JOIN CADCID I ON I.CID_CODCID = E.ETC_CIDENT ';
  Result := Result + ' WHERE M.OCO_CODOCO = :CODOCO ';
  Result := Result + '   AND M.OCO_CODEMP = :CODEMP ';
  Result := Result + '   AND M.OCO_TIP_FC = ' + QuotedStr('C');
  Result := Result + '   AND T.TOC_CODTOC = ' + QuotedStr(fCfgSis('VENDEV', varString));
  Result := Result + '   AND E.ETC_SITUAC = ' + QuotedStr('A');
  Result := Result + ' ORDER BY E.ETC_SEQVIS ASC ';
  Result := Result + ' LIMIT 0, 4 ';
end;

{$IFNDEF LINUX}
procedure pChamaFormImpOcorrencias(qryOcorr,qryProdDev, qryEndCliDev: TUniQuery);
var
  qryCfgRel : TUniQuery;
  strNomFil : String;
  strTipImp : String;
  frmQckOcorrenciasCRM: TfrmQckOcorrenciasCRM;
begin
  Try
    strNomFil := '';
    strTipImp := '';
    qryCfgRel := fCriaQuery(nil);
    Try
      pCriarFormularios(TfrmQckOcorrenciasCRM, frmQckOcorrenciasCRM);
      frmQckOcorrenciasCRM.DBOcorrencias.DataSet  := qryOcorr;
      frmQckOcorrenciasCRM.DBProdutosDev.DataSet  := qryProdDev;
      frmQckOcorrenciasCRM.DBEnderecosDev.DataSet := qryEndCliDev;

      If FileExists(fCfgSis('PATETI') + '\frxOcorrenciasCRM.fr3') Then
        frmQckOcorrenciasCRM.frxOcorrencias.LoadFromFile(fCfgSis('PATETI') + '\frxOcorrenciasCRM.fr3');

      pCarregaConfImpr(qryCfgRel, 'frmCadMovOcorrencias');
      fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);

      frmQckOcorrenciasCRM.frxOcorrencias.PrintOptions.Printer  := AnsiReplaceStr(strNomFil,'\\' + fRetNomeRede + '\','');
      If frmQckOcorrenciasCRM.frxOcorrencias.PrepareReport Then
        pPreviewReport('frmCadMovOcorrencias', 'CRM - Ocorrências', frmQckOcorrenciasCRM.frxOcorrencias);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TFatOrdProTintaMaquina.pImprimir]');
      End;
    End;
  Finally
    FreeAndNil(qryCfgRel);
    pFreeAndNil(frmQckOcorrenciasCRM);
  End;
end;
{$ENDIF}

function fRetornaSQLInformacoesCliente: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '        C.*,         ';
  Result := Result + '        CID_NOMCID,  ';
  Result := Result + '        VEN.OPE_NOMOPE NOMVEN, ';
  Result := Result + '        REP.OPE_NOMOPE NOMREP, ';
  Result := Result + '        SGE.OPE_NOMOPE NOMSGE, ';
  Result := Result + '        SRE.OPE_NOMOPE NOMSRE, ';
  Result := Result + '        ATI_DESATI, ';
  Result := Result + '        FPG_DESCRI, ';
  Result := Result + '        TIP_DESTIP, ';
  Result := Result + '        POR_NOMPOR, ';
  Result := Result + '        REG_DESREG, ';
  Result := Result + '        DIV_NOMDIV, ';
  Result := Result + '        RED_DESRED, ';
  Result := Result + '        CAC_NOMCAC, ';
  Result := Result + '        EMP_NOMEMP  ';
  Result := Result + '   FROM CADCLI C    ';
  Result := Result + '   LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  Result := Result + '   LEFT JOIN CADOPE VEN ON VEN.OPE_CODOPE = CLI_CODVEN ';
  Result := Result + '   LEFT JOIN CADOPE REP ON REP.OPE_CODOPE = CLI_CODREP ';
  Result := Result + '   LEFT JOIN CADOPE SGE ON SGE.OPE_CODOPE = CLI_SUPGER ';
  Result := Result + '   LEFT JOIN CADOPE SRE ON SRE.OPE_CODOPE = CLI_SUPREG ';
  Result := Result + '   LEFT JOIN CADATI ON ATI_CODATI = CLI_CODATI ';
  Result := Result + '   LEFT JOIN CADFPG ON FPG_CODIGO = CLI_CODFPG ';
  Result := Result + '   LEFT JOIN TIPCLG ON TIP_CODTIP = CLI_TIPCLI ';
  Result := Result + '   LEFT JOIN CADPOR ON POR_CODPOR = CLI_CODPOR ';
  Result := Result + '   LEFT JOIN CADREG ON REG_CODREG = CLI_CODREG ';
  Result := Result + '   LEFT JOIN CADDIV ON DIV_CODDIV = CLI_CODDIV ';
  Result := Result + '   LEFT JOIN CADRED ON RED_CODRED = CLI_CODRED ';
  Result := Result + '   LEFT JOIN CADCAC ON CAC_CODCAC = CLI_CODCAC ';
  Result := Result + '   LEFT JOIN CADEMP ON EMP_CODEMP = CLI_CODEMP ';
  Result := Result + '  WHERE CLI_CODCLI = :CODCLI ';
end;

function fRetornaSQLInformacoesProspecto: String;
Begin
  Result := '';
  Result := Result + ' SELECT PRO_CODPRO AS CLI_CODCLI,               ';
  Result := Result + '        PRO_NOMCLI AS CLI_NOMCLI,               ';
  Result := Result + '        PRO_CODCID AS CLI_CODCID,               ';
  Result := Result + '        PRO_CGCCPF AS CLI_CGCCPF,               ';
  Result := Result + '        PRO_FANSOB AS CLI_FANSOB,               ';
  Result := Result + '        CID_NOMCID AS CID_NOMCID,               ';
  Result := Result + '        PRO_C_E_P_ AS CLI_C_E_P_,               ';
  Result := Result + '        PRO_ENDERE AS CLI_ENDERE,               ';
  Result := Result + '        PRO_ENDNUM AS CLI_ENDNUM,               ';
  Result := Result + '        PRO_ENDCOM AS CLI_ENDCOM,               ';
  Result := Result + '        PRO_BAIRRO AS CLI_BAIRRO,               ';
  Result := Result + '        PRO_C_G_C_ AS CLI_C_G_C_,               ';
  Result := Result + '        PRO_NUMR_G AS CLI_NUMR_G,               ';
  Result := Result + '        PRO_I_E_S_ AS CLI_I_E_S_,               ';
  Result := Result + '        ""         AS CLI_I_M_P_,               ';
  Result := Result + '        PRO_NASCIM AS CLI_NASCIM,               ';
  Result := Result + '        PRO_CAIPOS AS CLI_CAIPOS,               ';
  Result := Result + '        PRO_FONE01 AS CLI_FONE01,               ';
  Result := Result + '        ""         AS CLI_RAMAL1,               ';
  Result := Result + '        PRO_FONE02 AS CLI_FONE02,               ';
  Result := Result + '        ""         AS CLI_RAMAL2,               ';
  Result := Result + '        PRO_F_A_X_ AS CLI_F_A_X_,               ';
  Result := Result + '        ""         AS CLI_RAMAL3,               ';
  Result := Result + '        PRO_CELULA AS CLI_CELULA,               ';
  Result := Result + '        PRO_NEXTEL AS CLI_NEXTEL,               ';
  Result := Result + '        PRO_EMAIL_ AS CLI_EMAIL_,               ';
  Result := Result + '        PRO_CONTAT AS CLI_CONTAT,               ';
  Result := Result + '        PRO_EMAIL2 AS CLI_EMAIL2,               ';
  Result := Result + '        PRO_EMAIL3 AS CLI_EMAIL3,               ';
  Result := Result + '        ""         AS CLI_CONSUM,               ';
  Result := Result + '        PRO_HOMEPA AS CLI_HOMEPA,               ';
  Result := Result + '        ""         AS CLI_SUPGER,               ';
  Result := Result + '        ""         AS CLI_NOMVEN,               ';
  Result := Result + '        ""         AS CLI_NOMREP,               ';
  Result := Result + '        ""         AS CLI_NOMSRE,               ';
  Result := Result + '        ""         AS CLI_NOMSGE,               ';
  Result := Result + '        ""         AS NOMVEN,                   ';
  Result := Result + '        ""         AS NOMREP,                   ';
  Result := Result + '        ""         AS NOMSRE,                   ';
  Result := Result + '        ""         AS NOMSGE,                   ';
  Result := Result + '        ""         AS CLI_SUPREG,               ';
  Result := Result + '        PRO_CODATI AS CLI_CODATI,               ';
  Result := Result + '        ATI_DESATI AS ATI_DESATI,               ';
  Result := Result + '        "1"        AS CLI_TABPRE,               ';
  Result := Result + '        0          AS CLI_LIMCRE,               ';
  Result := Result + '        ""         AS CLI_CODFPG,               ';
  Result := Result + '        ""         AS CLI_DESFPG,               ';
  Result := Result + '        ""         AS CLI_TIPCLI,               ';
  Result := Result + '        ""         AS CLI_DESTCL,               ';
  Result := Result + '        ""         AS CLI_DESPOR,               ';
  Result := Result + '        ""         AS CLI_CODPOR,               ';
  Result := Result + '        PRO_CODVEN AS CLI_CODVEN,               ';
  Result := Result + '        ""         AS CLI_CODREG,               ';
  Result := Result + '        ""         AS IP_DESTIP ,               ';
  Result := Result + '        ""         AS CLI_CODDIV,               ';
  Result := Result + '        ""         AS CLI_CODRED,               ';
  Result := Result + '        PRO_CODCAC AS CLI_CODCAC,               ';
  Result := Result + '        ""         AS CLI_EMPRCF,               ';
  Result := Result + '        ""         AS FPG_DESCRI,               ';
  Result := Result + '        ""         AS POR_NOMPOR,               ';
  Result := Result + '        ""         AS EG_DESREG ,               ';
  Result := Result + '        ""         AS DIV_NOMDIV,               ';
  Result := Result + '        CAC_NOMCAC AS CAC_NOMCAC,               ';
  Result := Result + '        ""         AS RED_DESRED,               ';
  Result := Result + '        ""         AS EMP_NOMEMP,               ';
  Result := Result + '        0          AS CLI_PERCOM,               ';
  Result := Result + '        0          AS CLI_DESCON,               ';
  Result := Result + '        0          AS CLI_PEREMP,               ';
  Result := Result + '        ""         AS CLI_DESREG,               ';
  Result := Result + '        ""         AS CLI_NOMDIV,               ';
  Result := Result + '        ""         AS CLI_NOMRED,               ';
  Result := Result + '        ""         AS CLI_NOMCAC,               ';
  Result := Result + '        0          AS CLI_ATRMAX,               ';
  Result := Result + '        "N"        AS CLI_PERMFF,               ';
  Result := Result + '        "N"        AS CLI_PERMFV,               ';
  Result := Result + '        ""         AS CLI_NOMFXA,               ';
  Result := Result + '        ""         AS CLI_NOMERC,               ';
  Result := Result + '        ""         AS TIP_DESTIP,               ';
  Result := Result + '        REG_DESREG AS REG_DESREG,               ';
  Result := Result + '        ""         AS CLI_REGTRI,               ';
  Result := Result + '        PRO_DTACAD AS CLI_DTACAD,               ';
  Result := Result + '        PRO_OBSERV AS CLI_OBSERV,               ';
  Result := Result + '        PRO_RG_EXP AS CLI_RG_EXP,               ';
  Result := Result + '        PRO_CRMFRE AS CLI_CRMFRE,               ';
  Result := Result + '        PRO_CRMPOR AS CLI_CRMPOR,               ';
  Result := Result + '        PRO_CRMFAI AS CLI_CRMFAI,               ';
  Result := Result + '        PRO_CRMCAT AS CLI_CRMCAT                ';
  Result := Result + ' FROM PROSPE                                    ';
  Result := Result + '   INNER JOIN CADCID ON CID_CODCID = PRO_CODCID ';
  Result := Result + '   LEFT  JOIN CADATI ON ATI_CODATI = PRO_CODATI ';
  Result := Result + '   LEFT  JOIN CADREG ON REG_CODREG = PRO_CODREG ';
  Result := Result + '   LEFT  JOIN CADCAC ON CAC_CODCAC = PRO_CODCAC ';
  Result := Result + ' WHERE PRO_CODPRO = :CODCLI                     ';
End;

function fRetornaSQLInformacoesFornecedores: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '        F.*,         ';
  Result := Result + '        CID_NOMCID AS FOR_NOMCID,  ';
  Result := Result + '        OPE_NOMOPE AS FOR_NOMOPE,  ';
  Result := Result + '        ATI_DESATI AS FOR_DESATI,  ';
  Result := Result + '        CCD.CTA_DESCTA AS FOR_CENTCD, ';
  Result := Result + '        CCC.CTA_DESCTA AS FOR_CENTCC, ';
  Result := Result + '        TRA_NOMTRA AS FOR_NOMTRA ';
  Result := Result + '   FROM CADFOR F     ';
  Result := Result + '   LEFT JOIN CADCID ON CID_CODCID = FOR_CODCID ';
  Result := Result + '   LEFT JOIN CADOPE ON OPE_CODOPE = FOR_CODOPE ';
  Result := Result + '   LEFT JOIN CADATI ON ATI_CODATI = FOR_CODATI ';
  Result := Result + '   LEFT JOIN CADCTA CCD ON CCD.CTA_CODCTA = FOR_CTATRA ';
  Result := Result + '   LEFT JOIN CADTRA ON TRA_CODTRA = FOR_CODTRA     ';
  Result := Result + '   LEFT JOIN CADCTA CCC ON CCC.CTA_CODCTA = FOR_CODCTA ';
  Result := Result + '  WHERE FOR_CODFOR = :CODFOR';
end;

function fRetornaSQLInformacoesContatos: String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '       CLI_CODCLI,  ';
  Result := Result + '       CLI_NOMCTT,  ';
  Result := Result + '       CLI_TELCTT,  ';
  Result := Result + '       CLI_CELCTT,  ';
  Result := Result + '       CLI_FAXCTT,  ';
  Result := Result + '       COALESCE(DPT_DESDPT, CLI_DEPCTT) AS DPT_DESDPT,  ';
  Result := Result + '       CGO_DESCGO,  ';
  Result := Result + '       TFU_DESTFU,  ';
  Result := Result + '       HOB_DESHOB,  ';
  Result := Result + '       ECI_DESECI,  ';
  Result := Result + '       GMU_DESGMU,  ';
  Result := Result + '       ESC_DESESC   ';
  Result := Result + '  FROM CLICTT       ';
  Result := Result + '  LEFT JOIN CADDPT ON DPT_CODDPT = CLI_DPTCTT ';
  Result := Result + '  LEFT JOIN CADCGO ON CGO_CODCGO = CLI_CGOCTT ';
  Result := Result + '  LEFT JOIN CADTFU ON TFU_CODTFU = CLI_TFUCTT ';
  Result := Result + '  LEFT JOIN CADHOB ON HOB_CODHOB = CLI_HOBCTT ';
  Result := Result + '  LEFT JOIN CADECI ON ECI_CODECI = CLI_ECICTT ';
  Result := Result + '  LEFT JOIN CADGMU ON GMU_CODGMU = CLI_GMUCTT ';
  Result := Result + '  LEFT JOIN CADESC ON ESC_CODESC = CLI_ESCCTT ';
  Result := Result + ' WHERE CLI_CODCLI = :CODCLI                   ';
end;

function fRetornaSQLInformacoesContatosFornecedores: String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '       FOR_CODFOR,  ';
  Result := Result + '       FOR_NOMCTT,  ';
  Result := Result + '       FOR_ENDCTT,  ';
  Result := Result + '       FOR_BAICTT,  ';
  Result := Result + '       FOR_CIDCTT,  ';
  Result := Result + '       FOR_TELCTT,  ';
  Result := Result + '       FOR_EMACTT,  ';
  Result := Result + '       FOR_CODEMP,  ';
  Result := Result + '       FOR_CELCTT,  ';
  Result := Result + '       FOR_FAXCTT,  ';
  Result := Result + '       FOR_DEPCTT,  ';
  Result := Result + '       FOR_CMPCTT,  ';
  Result := Result + '       CID_NOMCID AS FOR_NOMCID ';
  Result := Result + '  FROM FORCTT       ';
  Result := Result + '  LEFT JOIN CADCID ON CID_CODCID = FOR_CIDCTT ';
  Result := Result + ' WHERE FOR_CODFOR = :CODFOR                   ';
end;

function fRetornaSQLInformacoesEnderecos: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '        ETC_CODCLI,  ';
  Result := Result + '        ETC_CIDENT,  ';
  Result := Result + '        CID_NOMCID,  ';
  Result := Result + '        ETC_ENDENT,  ';
  Result := Result + '        ETC_BAIENT,  ';
  Result := Result + '        ETC_CEPENT,  ';
  Result := Result + '        ETC_TELENT,  ';
  Result := Result + '        ETC_CONENT,  ';
  Result := Result + '        ETC_REFENT,  ';
  Result := Result + '        ETC_CODTRA,  ';
  Result := Result + '        TRA_NOMTRA,  ';
  Result := Result + '        ETC_ENDFAT   ';
  Result := Result + '   FROM ENTCLI       ';
  Result := Result + '   LEFT JOIN CADCID ON CID_CODCID = ETC_CIDENT ';
  Result := Result + '   LEFT JOIN CADTRA ON TRA_CODTRA = ETC_CODTRA ';
  Result := Result + '  WHERE ETC_CODCLI = :CODCLI                   ';
//      SQL.Add('   AND ETC_ENDFAT = "S"                       ');

end;

function fRetornaSQLInformacoesGrupoOcorrencias(strTip_Fc: String = 'C'; blnSomenteOperadorLogado: Boolean = False): String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '        GOC_CODGOC,  ';
  Result := Result + '        GOC_DESGOC,  ';
  Result := Result + '        GOC_CODEMP,  ';
  Result := Result + '        AUTOINCREM,  ';
  Result := Result + ' (SELECT COUNT(*)    ';
  Result := Result + '    FROM             ';
  Result := Result + '  MOVOCO             ';
  Result := Result + '  INNER JOIN CADTOC ON TOC_CODTOC = OCO_CODTOC ';
  Result := Result + '  LEFT JOIN FATGOR ON FGO_NUMDOC = OCO_NUMDOC ';
  Result := Result + '   AND FGO_ESPDOC = OCO_ESPDOC ';
  Result := Result + '   AND FGO_CODEMP = OCO_CODEMP ';
  Result := Result + '  LEFT JOIN CADREC ON CTR_NUMDUP = OCO_NUMDOC ';
  Result := Result + '   AND CTR_ESPDOC = OCO_ESPDOC ';
  Result := Result + '   AND CTR_PARCEL = OCO_PARCEL ';
  Result := Result + '   AND CTR_CODEMP = OCO_CODEMP ';
  Result := Result + '   AND CTR_SEQBAI = 0          ';
  Result := Result + '  LEFT JOIN MOVGER G ON G.GER_NUMDOC = OCO_NUMDOC ';
  Result := Result + '   AND G.GER_ESPDOC = OCO_ESPDOC ';
  Result := Result + '   AND G.GER_CODEMP = OCO_CODEMP ';
  If strTip_Fc = 'C' Then
    Result := Result + ' AND G.GER_CODCLI = OCO_CODCLI '
  ELSE
  If strTip_Fc = 'F' Then
    Result := Result + ' AND G.GER_CODFOR = OCO_CODCLI ';
  Result := Result + 'WHERE TOC_CODGOC = GOC_CODGOC ';
  Result := Result + '  AND OCO_CODCLI = :CODCLI ';
  Result := Result + '  AND OCO_TIP_FC = '+QuotedStr(strTip_Fc) ;
  Result := Result + '  AND OCO_DTACON IS NULL ';
  Result := Result + '  AND OCO_CODEMP IN (' +  fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';
  Result := Result + '  ) AS GOC_NUMTOT ';
  Result := Result + '   FROM CADGOC       ';
  Result := Result + ' WHERE TRUE ';

  If (fCfgSis('CNSGRP', varBoolean)) And (Not fEmptyStr(strTip_FC)) Then
  Begin
    If strTip_FC = 'C' Then
    Begin
      Result := Result + ' AND GOC_USACLI = "S" ';
    End
    Else If strTip_FC = 'P' Then
    Begin
      Result := Result + ' AND GOC_USAPRO = "S" ';
    End
    Else If strTip_FC = 'F' Then
    Begin
      Result := Result + ' AND GOC_USAFOR = "S" ';
    End;
  End;

  If blnSomenteOperadorLogado Then
  Begin
    Result := Result + fRetSQLVerificaDireitoAcessoGrupoOcorrencias;
  End;
end;

function fRetSQLVerificaDireitoAcessoGrupoOcorrencias;
begin
  Result := '';
  Result := Result + ' AND (EXISTS (SELECT ';
  Result := Result + '               GOO_CODGOC';
  Result := Result + '              FROM GOCOPE';
  Result := Result + '              WHERE GOO_CODGOC = GOC_CODGOC';
  Result := Result + '                AND GOO_CODOPE = :OPEGOC)';
  Result := Result + '  OR (EXISTS (SELECT';
  Result := Result + '                GOG_CODGOC';
  Result := Result + '              FROM OPEGPO';
  Result := Result + '              INNER JOIN GOCGPO ON GOG_CODGPO = GPO_CODGPO';
  Result := Result + '              WHERE GOG_CODGOC = GOC_CODGOC';
  Result := Result + '                AND OPE_CODOPE = :OPEGOC)))';
end;

function fRetornaSQLInformacoesOcorrencias(strTip_Fc: String = 'C'; strChaveLead: String = ''): String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '       OCO_CODOCO,   ';
  Result := Result + '       OCO_CODTOC,   ';
  Result := Result + '       TOC_DESTOC,   ';
  Result := Result + '       OCO_PROTOC,   ';
  Result := Result + '       OCO_CODCLI,   ';
  If strTip_Fc = 'P' Then
    Result := Result + '     PRO_NOMCLI AS CLI_NOMCLI,   '
  Else
  If strTip_Fc = 'C' Then
    Result := Result + '       CLI_NOMCLI,   '
  Else
    Result := Result + '       FOR_NOMFOR AS CLI_NOMCLI,   ';

  Result := Result + '       OCO_DTAINC,   ';
  Result := Result + '       OCO_HORINC,   ';
  Result := Result + '       OCO_DTACON,   ';
  Result := Result + '       OCO_HORCON,   ';
  Result := Result + '       OCO_CODOPE,   ';
  Result := Result + '       OCO_DESCRI,   ';
  Result := Result + '       OCO_CODEMP,   ';
  Result := Result + '       OPE_NOMOPE,   ';
  Result := Result + '       OCO_CODSIT,   ';

  Result := Result + '       TIME_TO_SEC(TIMEDIFF(CONCAT(CURRENT_DATE(), " ", CURRENT_TIME()), ';
  Result := Result + '                            CONCAT((SELECT HIS_DTAINC FROM HISOCO WHERE HIS_CODOCO = OCO_CODOCO AND HIS_CODEMP = OCO_CODEMP ORDER BY HIS_DTAINC LIMIT 1), " ", ';
  Result := Result + '                                   (SELECT HIS_HORINC FROM HISOCO WHERE HIS_CODOCO = OCO_CODOCO AND HIS_CODEMP = OCO_CODEMP ORDER BY HIS_DTAINC LIMIT 1)) )) AS OCO_HOREXC, '; // TEMPO PASSADO EM SEGUNDOS

  Result := Result + '       OCO_EMERGE,   ';
  Result := Result + '       OCO_TIP_FC,   ';
  Result := Result + '       OCO_C_P_F_,   ';
  Result := Result + '       TIMESTAMPADD(SECOND, IFNULL(TOC_TMPLIM,0), CAST( CONCAT(OCO_DTAINC," ",OCO_HORINC) AS DATETIME) ) AS OCO_DTALIM, ';
  Result := Result + '       TOC_TMPLIM AS OCO_TMPLIM, ';     //LIMITE EM SEGUNDOS
  Result := Result + '       (TOC_TMPLIM / 2) AS OCO_METLIM, '; // METADADE DO LIMITE EM SEGUNDOS
  Result := Result + '       IF(IFNULL(OCO_NUMDOC,"")<>"", CONCAT(OCO_NUMDOC,"-", OCO_ESPDOC, "-", OCO_CODEMP, IF(IFNULL(OCO_PARCEL,"")<>"",CONCAT("-",OCO_PARCEL),"")),"") AS NUMDOC,  ';

  Result := Result + '       IFNULL(OCO_NUMDOC,"") AS OCO_NUMDOC,  ';
  Result := Result + '       IFNULL(OCO_ESPDOC,"") AS OCO_ESPDOC,  ';
  Result := Result + '       IFNULL(OCO_CODEMP,"") AS OCO_CODEMP,  ';

  Result := Result + '       IF(FGO_CODCND IS NULL, G.GER_CODCND, FGO_CODCND) AS CODCND,  ';
  Result := Result + '       CND_DESCRI,            ';

//  Result := Result + '       (SELECT HIS_DTAINC FROM HISOCO WHERE HIS_CODOCO = OCO_CODOCO AND HIS_CODEMP = OCO_CODEMP ORDER BY HIS_DTAINC LIMIT 1) AS HIS_DTAINC, '; //data da primeira inclusao
//  Result := Result + '       (SELECT HIS_HORINC FROM HISOCO WHERE HIS_CODOCO = OCO_CODOCO AND HIS_CODEMP = OCO_CODEMP ORDER BY HIS_DTAINC LIMIT 1) AS HIS_HORINC  '; //hora da primeira inclusao
  Result := Result + '       MOVOCO.AUTOINCREM,  ';
  Result := Result + '       IF(CTR_NUMDUP IS NULL,IFNULL(FGO_VLRCON, G.GER_VLRCON),IF(CTR_DTAREC IS NULL,CTR_VALDUP,CTR_VALREC)) AS FGO_VLRCON, ';
  Result := Result + fGetSQLNumCmp() + '  AS NUMCMP, ';
  Result := Result + '       CONCAT(IFNULL((SELECT GROUP_CONCAT(DISTINCT IF(FDO_ENTRET = "E", "ENT", "RET") ORDER BY FDO_ENTRET DESC SEPARATOR "/") ';
  Result := Result + '                        FROM EXTDOR ';
  Result := Result + '                       WHERE FDO_SEQFDO IN (SELECT AUTOINCREM FROM FATDOR WHERE FDO_SEQGER = FATGOR.AUTOINCREM)';
  Result := Result + '                         AND IFNULL(FDO_ENTRET, "") <> ""), IF( G.GER_ENTFAT = "S", "ENT", "RET"))) AS ENTRET, ';
  Result := Result + '       IF(IFNULL(FGO_CLILOJ, "N") = "N", "NÃO", "SIM") AS CLILOJ, ';
  Result := Result + '  IFNULL(S.STA_DESCRI, "") AS STATUS, ';
  Result := Result + '  IFNULL(FGO_STATUS, 0) AS FGO_STATUS, ';
  Result := Result + '  (SELECT GROUP_CONCAT(DISTINCT CONCAT(FDO_NUMFAT,"-",FDO_TIPFAT,"-",FDO_EMPFAT)) FROM FATDOR';
  Result := Result + '    WHERE FDO_NUMDOC = FGO_NUMDOC AND FDO_ESPDOC = FGO_ESPDOC AND FDO_CODEMP = FGO_CODEMP) AS DOCCON, ';
  Result := Result + '  E.FGO_USADEP AS USADEPS, ';
  Result := Result + '  E.FGO_STSDEP AS STATUSDEPS, ';
  Result := Result + '  FATGOR.FGO_MOTBAI, ';
  Result := Result + '  FATGOR.AUTOINCREM AS AUTOINCREMFATGOR, ';
  Result := Result + '  FATGOR.FGO_ESPDOC AS ESPDOC, ';
  Result := Result + '  FATGOR.FGO_NUMPOK, ';
  Result := Result + '  FATGOR.FGO_CODCLI AS FGOCLI, ';
  Result := Result + '  G.GER_CODCLI AS GERCLI, ';
  Result := Result + '  CAT_DESCRI, ';
  Result := Result + '  CAT_CORCAT, ';
  Result := Result + '  OCO_SEQLAG, ';
  Result := Result + '  (SELECT HIS_CODCOC  ';
  Result := Result + '     FROM HISOCO ';
  Result := Result + '    WHERE OCO_CODOCO = HIS_CODOCO ';
  Result := Result + '    ORDER BY HISOCO.AUTOINCREM ASC ';
  Result := Result + '    LIMIT 1 ) AS CODCOC,  ';
  Result := Result + '  (SELECT CONCAT(HIS_CODSIT, " - ", SIT_DESSIT)   ';
  Result := Result + '     FROM HISOCO ';
  Result := Result + '     INNER JOIN SITOCO ON SIT_CODSIT = HIS_CODSIT AND SIT_CODTOC =  HIS_CODTOC';
  Result := Result + '    WHERE OCO_CODOCO = HIS_CODOCO ';
  Result := Result + '    ORDER BY HISOCO.AUTOINCREM DESC ';
  Result := Result + '    LIMIT 1 ) AS HIS_SITOCO,  ';
  Result := Result + IIF(strTip_Fc= 'C', 'IFNULL(FGO_NOMCON, IFNULL(GER_NOMCON,CON_NOMCON)) AS NOMCON,' , '""  AS NOMCON, ');
  Result := Result + IIF(strTip_Fc= 'C', 'IFNULL(FGO_TELCON, IFNULL(GER_TELCON,CON_FONE01)) AS TELCON,', '""  AS TELCON,  ');
  Result := Result + '  FATGOR.FGO_JAFATU ';
  Result := Result + '  FROM MOVOCO ';

  If strTip_Fc = 'P' Then
    Result := Result + ' INNER JOIN PROSPE ON PRO_CODPRO = OCO_CODCLI '
  Else
  If strTip_Fc = 'C' Then
  Begin
    Result := Result + ' INNER JOIN CADCLI ON CLI_CODCLI = OCO_CODCLI ';
    Result := Result + ' LEFT JOIN CLICON ON OCO_C_P_F_ = CON_C_P_F_ ';
  End
  Else
    Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = OCO_CODCLI ';

  Result := Result + ' INNER JOIN CADTOC ON TOC_CODTOC = OCO_CODTOC ';
  Result := Result + '  LEFT JOIN CADOPE ON OPE_CODOPE = OCO_CODOPE ';

  Result := Result + ' LEFT JOIN FATGOR ON           ';
  Result := Result + '   FGO_NUMDOC = OCO_NUMDOC AND ';
  Result := Result + '   FGO_ESPDOC = OCO_ESPDOC AND ';
  Result := Result + '   FGO_CODEMP = OCO_CODEMP     ';

  Result := Result + ' LEFT JOIN CADREC ON           ';
  Result := Result + '   CTR_NUMDUP = OCO_NUMDOC AND ';
  Result := Result + '   CTR_ESPDOC = OCO_ESPDOC AND ';
  Result := Result + '   CTR_PARCEL = OCO_PARCEL AND ';
  Result := Result + '   CTR_CODEMP = OCO_CODEMP AND ';
  Result := Result + '   CTR_SEQBAI = 0     ';

  Result := Result + 'LEFT JOIN EXTGOR E ON          ';
  Result := Result + '  E.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  Result := Result + 'LEFT JOIN FGOSTA S ON          ';
  Result := Result + '  E.FGO_STATUS = S.STA_CODIGO  ';

  Result := Result + 'LEFT JOIN MOVGER G ON          ';
  Result := Result + '  G.GER_NUMDOC = OCO_NUMDOC AND';
  Result := Result + '  G.GER_ESPDOC = OCO_ESPDOC AND';
  Result := Result + '  G.GER_CODEMP = OCO_CODEMP    ';

  If strTip_Fc = 'C' Then
    Result := Result + '   AND G.GER_CODCLI = OCO_CODCLI '
  ELSE
  If strTip_Fc = 'F' Then
    Result := Result + '   AND G.GER_CODFOR = OCO_CODCLI ';

  Result := Result + '  LEFT JOIN CATEGO ON FGO_CODCAT = CAT_CODIGO ';

  Result := Result + ' LEFT JOIN CADCND ON           ';
  Result := Result + '   IF(FGO_CODCND IS NULL, G.GER_CODCND, FGO_CODCND) = CND_CODIGO     ';

  If strChaveLead = '' Then
  Begin
    Result := Result + ' WHERE TOC_CODGOC = :CODGOC';
    Result := Result + '   AND OCO_CODCLI = :CODCLI';
    Result := Result + '   AND OCO_TIP_FC = ' + QuotedStr(strTip_Fc);
  End
  Else
  Begin
    Result := Result + ' WHERE OCO_SEQLAG = '+QuotedStr(strChaveLead)+'';
  End;

  Result := Result +' AND OCO_CODEMP IN (' +  fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

end;

function fRetornaSQLOcorrenciasEmergenciais(strTip_Fc: String = 'C'): String;
begin
  Result := '';
{
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '        OCO_CODOCO, ';
  Result := Result + '        OCO_CODTOC, ';
  Result := Result + '        TOC_DESTOC, ';
  Result := Result + '        OCO_CODCLI, ';
  Result := Result + '        GOC_CODGOC, ';
  Result := Result + '        GOC_DESGOC, ';
  Result := Result + '        CLI_NOMCLI, ';
  Result := Result + '        OCO_DTAINC, ';
  Result := Result + '        OCO_HORINC, ';
  Result := Result + '        OCO_DTACON, ';
  Result := Result + '        OCO_HORCON, ';
  Result := Result + '        OCO_CODEMP, ';
  Result := Result + '        OCO_OPEOCO, ';
  Result := Result + '        OPE_NOMOPE, ';
  Result := Result + '        OCO_PROTOC  ';
  Result := Result + '   FROM MOVOCO      ';
  Result := Result + '  INNER JOIN CADCLI ON CLI_CODCLI = OCO_CODCLI ';
  Result := Result + '  INNER JOIN CADTOC ON TOC_CODTOC = OCO_CODTOC ';
  Result := Result + '  INNER JOIN CADGOC ON GOC_CODGOC = TOC_CODGOC ';
  Result := Result + '   LEFT JOIN CADOPE ON OPE_CODOPE = OCO_OPEOCO ';
  Result := Result + '  WHERE OCO_EMERGE = "S"                       ';
  Result := Result + '    AND OCO_DTACON IS NULL                     ';
  Result := Result + '    AND OCO_HORCON IS NULL                     ';
  Result := Result + '    AND OCO_CODCLI = :CODCLI                   ';
  Result := Result + '    AND OCO_CODEMP = :CODEMP                   ';
  Result := Result + '    AND OCO_CODOCO NOT IN (SELECT EME_CODOCO FROM OCOEME) ';

  Result := Result + '  UNION ALL ';
}
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '        OCO_CODOCO, ';
  Result := Result + '        OCO_CODTOC, ';
  Result := Result + '        TOC_DESTOC, ';
  Result := Result + '        OCO_CODCLI, ';
  Result := Result + '        GOC_CODGOC, ';
  Result := Result + '        GOC_DESGOC, ';

  If strTip_Fc = 'P' Then
    Result := Result + '      PRO_NOMCLI AS CLI_NOMCLI, '
  Else
  If strTip_Fc = 'C' Then
    Result := Result + '        CLI_NOMCLI, '
  Else
    Result := Result + '        FOR_NOMFOR AS CLI_NOMCLI, ';
  Result := Result + '        OCO_DTAINC, ';
  Result := Result + '        OCO_HORINC, ';
  Result := Result + '        OCO_DTACON, ';
  Result := Result + '        OCO_HORCON, ';
  Result := Result + '        OCO_CODEMP, ';
  Result := Result + '        OCO_OPEOCO, ';
  Result := Result + '        OPE_NOMOPE, ';
  Result := Result + '        OCO_PROTOC  ';
  Result := Result + '   FROM MOVOCO      ';
  Result := Result + '  INNER JOIN OCOEME ON EME_CODOCO = OCO_CODOCO ';
  If strTip_Fc = 'P' Then
    Result := Result + '  INNER JOIN PROSPE ON PRO_CODPRO = OCO_CODCLI '
  Else
  If strTip_Fc = 'C' Then
    Result := Result + '  INNER JOIN CADCLI ON CLI_CODCLI = OCO_CODCLI '
  Else
    Result := Result + '  INNER JOIN CADFOR ON FOR_CODFOR = OCO_CODCLI ';
  Result := Result + '  INNER JOIN CADTOC ON TOC_CODTOC = OCO_CODTOC ';
  Result := Result + '  INNER JOIN CADGOC ON GOC_CODGOC = TOC_CODGOC ';
  Result := Result + '  LEFT JOIN CADOPE  ON OPE_CODOPE = OCO_OPEOCO ';
  Result := Result + '  WHERE OCO_EMERGE = "S"                       ';
  Result := Result + '    AND OCO_DTACON IS NULL                     ';
  Result := Result + '    AND OCO_HORCON IS NULL                     ';
  Result := Result + '    AND OCO_CODCLI = :CODCLI                   ';
  Result := Result + '    AND EME_CODOPE = :CODOPE                   ';
  Result := Result + '    AND OCO_TIP_FC = ' + QuotedStr(strTip_Fc);
end;

function fRetornaSQLUltimasVendasProduto(strNomCol: String): String;
  function fSqlSelectDataHoraVendaOriginal(strNomCam : String):String;
  Begin
    Result := '';
    Result := Result + '(';
    Result := Result + ' SELECT ' + strNomCam ;
    Result := Result + ' FROM MOVGRC C2 ';
    Result := Result + ' INNER JOIN MOVGAD G2 ON G2.AUTOINCREM = C2.GRC_SEQGAD AND C2.GRC_OPCDOC IN ("GA","OE", "DV") ';
    Result := Result + ' INNER JOIN MOVDET D2 ON D2.DET_NUMDOC = GAD_NUMDOC ';
    Result := Result + '                     AND D2.DET_ESPDOC = GAD_ESPDOC ';
    Result := Result + '                     AND D2.DET_CODITE = GAD_CODITE ';
    Result := Result + '                     AND D2.DET_CODEMP = GAD_CODEMP ';
      Result := Result + ' WHERE C2.GRC_SEQGAD = C.GRC_SEQGAD LIMIT 1';
    Result := Result + ')'
  End;

  Const
    CONF_CUPOM_MOVDET = ' OR ((SELECT COUNT(*) FROM NOTDET DES   '+
                        'WHERE DES.DET_NUMDOC = D.DET_NUMFAT AND '+
                        '      DES.DET_ESPDOC = D.DET_TIPFAT AND '+
                        '      DES.DET_CODEMP = D.DET_EMPFAT AND '+
                        '      DES.DET_ESPDOC = "NF" AND         '+
                        '        D.DET_ESPDOC = "IF") > 0)       ';
    CONF_CUPOM_NOTDET = 'AND ((SELECT COUNT(*) FROM MOVDET ORI   '+
                        'WHERE D.DET_NUMDOC = ORI.DET_NUMFAT AND '+
                        '      D.DET_ESPDOC = ORI.DET_TIPFAT AND '+
                        '      D.DET_CODEMP = ORI.DET_EMPFAT AND '+
                        '      D.DET_ESPDOC = "NF" AND           '+
                        '    ORI.DET_ESPDOC = "IF") = 0)         ';
Begin
  {*********************************}
  { CARREGA AS ULTIMAS VENDAS NO    }
  { DBGRID DA PAGINA - 5            }
  {******************************JB*}

    Result := '';
    Result := Result + 'SELECT ';
    Result := Result + '  SUM(IF(D.DET_ESPDOC="ML", 1, IF(IFNULL(I.ITE_CNV_ML,0) = 0, 1, I.ITE_CNV_ML)) * IF(LEFT(D.DET_CLAFIS,1) < 5, -1, 1) * D.DET_QTDITE) AS QTDCNV,';

    Result := Result + '  (0.00) AS QTDDEV, ';
    Result := Result + '  (0.00) AS QTDADE, ';
    Result := Result + '  (0.00) AS QTDITE, ';
    Result := Result + '  SUM(IF(LEFT(D.DET_CLAFIS,1) < 5, -1, 1) * D.DET_QTDITE) AS QTDFIS, ';
    Result := Result + '  (0.00) AS QTDORI, ';

    Result := Result + '  IF(GRC_SEQDET IS NULL, D.DET_DTAENT, ' + fSqlSelectDataHoraVendaOriginal('DET_DTAENT') + ' ) AS "DTA_MOV",  ';
    Result := Result + '  IF(GRC_SEQDET IS NULL, D.DET_HORENT, ' + fSqlSelectDataHoraVendaOriginal('DET_HORENT') + ') AS "HOR_MOV",  ';

    Result := Result + '  IF(D.DET_ESPDOC="ML", D.DET_NUMFAT, D.DET_NUMDOC) AS NUMDOC, ';
    Result := Result + '  IF(D.DET_ESPDOC="ML", D.DET_TIPFAT, D.DET_ESPDOC) AS ESPDOC, ';
    Result := Result + '  IF(D.DET_ESPDOC="ML", D.DET_EMPFAT, D.DET_CODEMP) AS CODEMP, ';
    Result := Result + '  IF(D.DET_ESPDOC="ML", D.DET_CLIFAT, IF(D.DET_TIP_FC="C", D.DET_CODCLI, D.DET_CODFOR)) AS FORCLI, ';
    Result := Result + '  D.DET_TIP_FC AS TIP_FC, ';
    Result := Result + '  D.DET_SERIE_ AS SERIE_, ';
    Result := Result + '  L.CLI_NOMCLI AS "CLIENTE", ';
    Result := Result + '  I.ITE_CODITE AS CODITE, ';
    Result := Result + '  I.ITE_CODGRU AS CODGRU, ';
    Result := Result + '  ((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE) AS "PR_UNITARIO",  ';
    Result := Result + '  O.OPE_NOMOPE AS VENDEDOR, ';
    Result := Result + '  D.AUTOINCREM AS SEQORI ';

    Result := Result + 'FROM ';
    Result := Result + '  CADITE I ';
    Result := Result + '  INNER JOIN <<SQL_TABDET>> D ON D.DET_CODITE = I.ITE_CODITE ';
    Result := Result + '  INNER JOIN CADCLI L ON L.CLI_CODCLI = D.DET_CODCLI ';
    Result := Result + '  INNER JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';
    Result := Result + '  INNER JOIN CADOPE O ON O.OPE_CODOPE = D.DET_CODVEN ';
    Result := Result + '  LEFT JOIN MOVGRC C ON C.GRC_SEQDET = D.AUTOINCREM ';

    Result := Result + 'WHERE ';
    Result := Result + '  (D.DET_JAFATU = 0 <<SQL_CONF_CUPOM>>) AND ';
    Result := Result + '  D.DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    Result := Result + '  D.DET_TIP_FC = "C"          AND ';
    Result := Result + '  D.DET_ESPDOC IN ("NF", "MI", "FF", "IF", "GC", "NV", "IV") AND ';
    Result := Result + '  IFNULL(D.DET_PROEMB, "N") <> "S" AND ';
    Result := Result + '  IFNULL(DET_ENTFUT, "N") <> "S"    AND ';
    Result := Result + '  D.DET_CODITE = :CODITE      AND ';
    Result := Result + '  D.DET_CODCLI = :CODCLI      AND ';
    Result := Result + '  D.DET_CODEMP = :CODEMP AND ';
    Result := Result + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) OR (DET_ESPDOC = "ML" AND DET_ORIDOC="V") ';
    Result := Result + '  OR (LOCATE(RIGHT(DET_CLAFIS, 3), '+CLAFIS_ENTFUT_VEN_ABR+') > 0) ';
    Result := Result + '  OR (GRC_OPCDOC IN ("GC", "OU" )) ';

    If (fCfgSis('DVBRAD', varBoolean)) Then
      Result := Result + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      Result := Result + ') ';

    Result := Result + 'GROUP BY ';

    Result := Result + '  D.DET_NUMDOC, D.DET_ESPDOC, D.DET_CODEMP, D.DET_CODCLI, D.DET_CODITE, D.DET_UNITAR, D.DET_QTDITE, O.OPE_NOMOPE, D.AUTOINCREM';

    Result := AnsiReplaceStr(AnsiReplaceStr(Result, '<<SQL_TABDET>>', 'MOVDET'), '<<SQL_CONF_CUPOM>>', CONF_CUPOM_MOVDET) +
              ' UNION ALL ' +
              AnsiReplaceStr(AnsiReplaceStr(Result, '<<SQL_TABDET>>', 'NOTDET'), '<<SQL_CONF_CUPOM>>', CONF_CUPOM_NOTDET);

    Result := ' SELECT VW_AUX.*, (QTDITE*PR_UNITARIO) AS PR_TOTAL FROM ( '+Result+' ) AS VW_AUX ';


    Result := Result + '  WHERE TRUE ';

    If fCfgSis('DIADEV', varInteger) > 0 Then
      Result := Result + ' AND DATEDIFF(CURRENT_DATE, DTA_MOV) <= (' + fCfgSis('DIADEV', varString) + ')';

    Result := Result + '  ORDER BY  ';

    If UpperCase(strNomCol) = 'DTA_MOV' Then
      Result := Result + '  DTA_MOV DESC, HOR_MOV DESC'
    Else
      Result := Result + '  ' + strNomCol;
end;

function fRetornaVendedorUltCompra(strNumDoc, strEspDoc, strCodEmp: String): String;
var
  qryConsulta: TUniQuery;
begin
  Result := '';
  try
    qryConsulta := fCriaQuery(Nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT SQL_NO_CACHE CONCAT(OPE_CODOPE, "-", OPE_NOMOPE) AS OPE_NOMOPE ');
      SQL.Add('  FROM CADOPE ');
      SQL.Add(' INNER JOIN MOVDET ON DET_CODVEN = OPE_CODOPE ');
      SQL.Add(' WHERE DET_NUMDOC = :NUMDOC ');
      SQL.Add('   AND DET_ESPDOC = :ESPDOC ');
      SQL.Add('   AND DET_CODEMP = :CODEMP ');
      SQL.Add('LIMIT 1 ');
      Params.ParamByName('NUMDOC').AsString := strNumDoc;
      Params.ParamByName('ESPDOC').AsString := strEspDoc;
      Params.ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      Result := FieldByName('OPE_NOMOPE').AsString;
    end;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

function fRetornaSQLAgendaCompromissos: String;
begin
  Result := '';
  Result := Result + 'SELECT        ';
  Result := Result + '  AGE_DTACOM, ';
  Result := Result + '  AGE_HORCOM, ';
  Result := Result + '  AGE_TITULO, ';
  Result := Result + '  AGE_DESCRI  ';
  Result := Result + 'FROM          ';
  Result := Result + '  AGENDA      ';
  Result := Result + 'WHERE         ';
  Result := Result + '  AGE_CODOCO = :CODOCO AND ';
  Result := Result + '  AGE_CODEMP = :CODEMP AND ';
  Result := Result + '  AGE_BAIXAD = "N"         ';
  Result := Result + 'ORDER BY                   ';
  Result := Result + '  AGE_DTACOM, AGE_HORCOM   ';
end;

function fExitemCompromissos: Boolean;
begin
  Result := fExistemCompromissosAgendados;
end;

function fRetornaSQLConsultaDevolucao: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE  ';
  Result := Result + '        DET_CODITE,   ';
  Result := Result + '        ITE_DESITE,   ';
  Result := Result + '        DET_CODMOT,   ';
  Result := Result + '        OCO_DESOCO,   ';
  Result := Result + '        DET_QTDDEV,   ';
  Result := Result + '        DET_UNIDEV,   ';  
  Result := Result + '        UNI_SIGUNI,   ';
  Result := Result + '        DET_CODADE,   ';
  Result := Result + '        DET_SEQGER,   ';
  Result := Result + '        ITE_REFERE,   ';
  Result := Result + '        UNI_DESUNI,   ';
  Result := Result + '        DET_NUMDOC,   ';
  Result := Result + '        DET_ESPDOC,   ';
  Result := Result + '        DET_CODEMP,   ';
  Result := Result + '        DET_DTAMOV,   ';
  Result := Result + '        DET_QTDORI,   ';
  Result := Result + '        DET_FORCLI,   ';
  Result := Result + '        DET_TIP_FC,   ';
  Result := Result + '        DET_SERIE_,   ';
  Result := Result + '        DET_GARANT,   ';
  Result := Result + '        DET_SEQORI    ';
  Result := Result + '   FROM ADEGER        ';
  Result := Result + '  INNER JOIN ADEDET ON DET_CODADE = GER_CODADE ';
  Result := Result + '  INNER JOIN CADITE ON DET_CODITE = ITE_CODITE ';
  Result := Result + '  INNER JOIN CADOCO ON OCO_CODOCO = DET_CODMOT ';
  Result := Result + '  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  Result := Result + '  WHERE GER_CODEMP = :CODEMP                   ';
  Result := Result + '    AND GER_CODOCO = :CODOCO                   ';
end;

function fQuantidadeDevolvida(strNumDoc, strEspDoc, strCodEmp, strCodIte, strCodCli: String; strCodDev: String = ''): Double;
begin
  Result := fRetQuantidadeDevolvida(strNumDoc, strEspDoc, strCodEmp, strCodIte);
 {//A AD PODE SER BAIXADA PARCIALMENTE EM RELAÇAO A QUANTIDADE, POREM A AD SERA BAIXADA (CASO FOR FAZER OUTRA DEVOLUÇAO TEM QUE CRIAR OUTRA AD),
 // SENDO ASSIM TEM QUE CONSIDERAR A QUANTIDADE DEVOLVIDA SEMPRE DO MOVDET.

  try
    qryConsulta := fCriaQuery(Nil);
    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT SUM(DET_QTDDEV) AS QTDDEV ');
      SQL.Add('  FROM ADEDET                    ');
      SQL.Add(' INNER JOIN ADEGER ON GER_CODADE = DET_CODADE ');
      SQL.Add('                  AND GER_CODEMP = DET_CODEMP ');
      SQL.Add('                  AND ADEGER.AUTOINCREM = DET_SEQGER ');
      SQL.Add(' INNER JOIN MOVOCO ON OCO_CODOCO = GER_CODOCO  ');
      SQL.Add('                  AND OCO_CODEMP = GER_CODEMP  ');
      SQL.Add(' WHERE DET_NUMDOC = :NUMDOC ');
      SQL.Add('   AND DET_ESPDOC = :ESPDOC ');
      SQL.Add('   AND DET_CODEMP = :CODEMP ');
      SQL.Add('   AND DET_CODITE = :CODITE ');
      SQL.Add('   AND OCO_CODCLI = :CODCLI ');
      If Not fEmptyStr(strCodDev) Then
        SQL.Add('   AND GER_CODADE <> :CODADE ');
      Params.ParamByName('NUMDOC').AsString := strNumDoc;
      Params.ParamByName('ESPDOC').AsString := strEspDoc;
      Params.ParamByName('CODEMP').AsString := strCodEmp;
      Params.ParamByName('CODITE').AsString := strCodIte;
      Params.ParamByName('CODCLI').AsString := strCodCli;
      If Not fEmptyStr(strCodDev) Then
        Params.ParamByName('CODADE').AsString := strCodDev;
      Open;
      Result := FieldByName('QTDDEV').AsFloat;
    end;
  finally
    FreeAndNil(qryConsulta);
  end;    }
end;


function fRetornaSQLInformacoesFazendas: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '        FAZ_CODFAZ AS CODFAZ,  ';
  Result := Result + '        FAZ_NOMFAZ AS NOMFAZ,  ';
  Result := Result + '        CID_NOMCID AS NOMCID, ';
  Result := Result + '        CID_ESTADO AS ESTADO, ';
  Result := Result + '        FAZ_C_E_P_ AS C_E_P_  ';
  Result := Result + '   FROM CADFAZ       ';
  Result := Result + '   INNER JOIN CADCID ON FAZ_CODCID = CID_CODCID ';
  Result := Result + '  WHERE FAZ_CODCLI = :CODCLI ';
end;

function fGeraTextoHistorico(dtaData, dtaHora: TDateTime; strNomeOpe, strTexto: String): String;
begin
  Result := strTexto +'<<csq>><<csq>>' +
            'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
            DateToStr(dtaData) + ' ' + TimeToStr(dtaHora) + ' - ' + strNomeOpe;
end;


function fRetornaTotalDaAD(strNumAde: String): Double;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT SUM(IFNULL(TOTAL, 0)) AS TOTAL FROM (');
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  DISTINCT A.AUTOINCREM, A.DET_QTDDEV * IFNULL(A.DET_UNIDEV, D.DET_UNITAR) AS TOTAL');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  ADEDET A ');

  qryAux.SQL.Add('  LEFT JOIN MOVDET D ON D.DET_NUMDOC = A.DET_NUMDOC AND ');
  qryAux.SQL.Add('                        D.DET_ESPDOC = A.DET_ESPDOC AND ');
  qryAux.SQL.Add('                        D.DET_CODEMP = A.DET_CODEMP AND ');
  qryAux.SQL.Add('                        D.DET_CODCLI = A.DET_FORCLI AND ');
  qryAux.SQL.Add('                        D.DET_TIP_FC = A.DET_TIP_FC AND ');
  qryAux.SQL.Add('                        IFNULL(D.DET_SERIE_, "") = IFNULL(A.DET_SERIE_, "") ');

  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  A.DET_CODADE = :CODADE AND ');
  qryAux.SQL.Add('  A.DET_CODEMP = :CODEMP ');
  qryAux.SQL.Add(') AS TAB ');

  qryAux.ParamByName('CODADE').AsString := strNumAde;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.Open;

  Result := qryAux.FieldByName('TOTAL').AsFloat;

  FreeAndNil(qryAux);
end;

function fRetornaInconsistencias(strNumAde: String;
  strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie: String): String;
begin
  Result := fRetornaStringInconsistencias(strNumAde,
    strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie)
end;

function fRetornaOcorrenciaDoAD(strNumAde: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  GER_CODOCO ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  ADEGER ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_CODADE = :CODADE AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP ');

  qryAux.ParamByName('CODADE').AsString := strNumAde;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.Open;

  Result := qryAux.FieldByName('GER_CODOCO').AsString;

  FreeAndNil(qryAux);
end;

function fAtualizaOcorrenciaDevolucaoCRM(strNumAde: String;
                                         dtaDtaEnt: TDateTime;
                                         strNumDoc,
                                         strEspDoc,
                                         strCodEmp,
                                         strCodCli,
                                         strSerie,
                                         strCodVen: String;
                                         fltVlrCon: Double;
                                         strTabela: String;
                                         blnMostraErro : Boolean = True): Boolean;
  Var
    strHistorico: String;
    strTexto: String;
    strInconsistencias: String;
    strCodOcorrencia: String;
    qryUpdOco: TUniQuery;
    DtaMov: TDateTime;
    HorMov: TDateTime;
begin
  Try
    strInconsistencias := fRetornaInconsistencias(strNumAde, strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie);

    strTexto := 'DOCUMENTO: ' + strNumDoc + '-' + strEspDoc + '-' + strCodEmp + STRING_QUEBRA +
                'AD: ' + strNumAde + STRING_QUEBRA +
                'VALOR DO DOCUMENTO: ' + FloatToStrF(fltVlrCon, ffNumber, 12, 2) + STRING_QUEBRA +
                'VALOR ORIGINAL DA AD: ' + FloatToStrF(fRetornaTotalDaAD(strNumAde), ffNumber, 12, 2) + STRING_QUEBRA +
                IIF(fEmptyStr(strInconsistencias), 'DEVOLUCAO SEM DIVERGENCIA', 'DEVOLUCAO COM DIVERGENCIA') + STRING_QUEBRA +
                strInconsistencias;

    strHistorico := fGeraTextoHistorico(dtaDtaEnt, fTime(), fRetNomeOperador(strCodVen),
      strTexto);

    strCodOcorrencia := fRetornaOcorrenciaDoAD(strNumAde);

    DtaMov := VS_Date;
    HorMov := fTime();

    qryUpdOco := fCriaQuery();
//    qryUpdOco.SQL.Add('UPDATE MOVOCO SET OCO_DESCRI = CONCAT(OCO_DESCRI, :TEXTO) ');
    qryUpdOco.SQL.Add('UPDATE MOVOCO SET OCO_DESCRI = CONCAT(:TEXTO, OCO_DESCRI), ');
    qryUpdOco.SQL.Add(' OCO_DTACON = :DTACON, OCO_HORCON = :HORCON ');
    qryUpdOco.SQL.Add('WHERE OCO_CODOCO = :CODOCO AND OCO_CODEMP = :CODEMP ');

//    qryUpdOco.ParamByName('TEXTO').AsString := STRING_QUEBRA + STRING_QUEBRA + strHistorico;
    qryUpdOco.ParamByName('TEXTO').AsString := strHistorico + STRING_QUEBRA + STRING_QUEBRA;
    qryUpdOco.ParamByName('DTACON').AsDateTime := DtaMov;
    qryUpdOco.ParamByName('HORCON').AsDateTime := HorMov;
    qryUpdOco.ParamByName('CODOCO').AsString := strCodOcorrencia;
    qryUpdOco.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryUpdOco.ExecSQL;

    qryUpdOco.SQL.Clear;
    qryUpdOco.SQL.Add('INSERT INTO HISOCO (');
    qryUpdOco.SQL.Add('  HIS_CODHIS, ');
    qryUpdOco.SQL.Add('  HIS_CODOCO, ');
    qryUpdOco.SQL.Add('  HIS_DTAINC, ');
    qryUpdOco.SQL.Add('  HIS_HORINC, ');
    qryUpdOco.SQL.Add('  HIS_DTACON, ');
    qryUpdOco.SQL.Add('  HIS_HORCON, ');
    qryUpdOco.SQL.Add('  HIS_OPEHIS, ');
    qryUpdOco.SQL.Add('  HIS_CODOPE, ');
    qryUpdOco.SQL.Add('  HIS_DESCRI, ');
    qryUpdOco.SQL.Add('  HIS_CODEMP, ');
    qryUpdOco.SQL.Add('  AUTOINCREM, ');
    qryUpdOco.SQL.Add('  HIS_AGECOM) ');
    qryUpdOco.SQL.Add('VALUES ( ');
    qryUpdOco.SQL.Add('  :CODHIS, ');
    qryUpdOco.SQL.Add('  :CODOCO, ');
    qryUpdOco.SQL.Add('  :DTAINC, ');
    qryUpdOco.SQL.Add('  :HORINC, ');
    qryUpdOco.SQL.Add('  :DTACON, ');
    qryUpdOco.SQL.Add('  :HORCON, ');
    qryUpdOco.SQL.Add('  :OPEHIS, ');
    qryUpdOco.SQL.Add('  :CODOPE, ');
    qryUpdOco.SQL.Add('  :DESCRI, ');
    qryUpdOco.SQL.Add('  :CODEMP, ');
    qryUpdOco.SQL.Add('  :AUTINC, ');
    qryUpdOco.SQL.Add('  :AGECOM) ');

    qryUpdOco.ParamByName('CODHIS').AsString   := fGetProximoCodigoEmTransacao('HISOCO', 'HIS_CODHIS');
    qryUpdOco.ParamByName('CODOCO').AsString   := strCodOcorrencia;
    qryUpdOco.ParamByName('DTAINC').AsDateTime := DtaMov;
    qryUpdOco.ParamByName('HORINC').AsDateTime := HorMov;
    qryUpdOco.ParamByName('DTACON').AsDateTime := DtaMov;
    qryUpdOco.ParamByName('HORCON').AsDateTime := HorMov;
    qryUpdOco.ParamByName('OPEHIS').AsString   := strCodVen;
    qryUpdOco.ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
    qryUpdOco.ParamByName('DESCRI').AsString   := strHistorico;
    qryUpdOco.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    qryUpdOco.ParamByName('AUTINC').AsString   := fRetAutoIncrem('HISOCO', VS_strCodEmp);
    qryUpdOco.ParamByName('AGECOM').AsString   := 'N';
    qryUpdOco.ExecSQL;

    FreeAndNil(qryUpdOco);
    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      If (blnMostraErro) Then
        pMensagensErro(E.Message, '[fAtualizaOcorrenciaDevolucaoCRM]')
      Else
        Raise Exception.create('[fAtualizaOcorrenciaDevolucaoCRM] ' + E.message);
    End;
  End;
end;

Function fEnviaMensagemParaOperadorAD(strCodAde, strCodOpe, strCodCli, strNomCli: String): Boolean;
  Var
    qryAux: TUniQuery;
    objMsg: TMsgInterna;
    strTexto: String;
begin
  Result := True;

  If Not VS_strHabilitarCRM Then
    Exit;

  qryAux := fCriaQuery;
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  OCO_PROTOC, ');
  qryAux.SQL.Add('  OCO_OPEOCO ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  MOVOCO ');
  qryAux.SQL.Add('  JOIN ADEGER ON GER_CODOCO = OCO_CODOCO AND ');
  qryAux.SQL.Add('                 GER_CODEMP = OCO_CODEMP ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_CODADE = :CODADE AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP ');

  qryAux.ParamByName('CODADE').AsString := strCodAde;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.Open;

  strTexto := 'DATA: ' + DateToStr(VS_Date) + STRING_QUEBRA +
              'USUÁRIO: ' + strCodOpe + '-' + fRetNomeOperador(strCodOpe) + STRING_QUEBRA +
              'CLIENTE: ' + strCodCli + '-' + strNomCli + STRING_QUEBRA +
              'NÚMERO DA AD: ' + strCodAde + STRING_QUEBRA +
              'PROTOCOLO DA OCORRÊNCIA: ' + qryAux.FieldByName('OCO_PROTOC').AsString;

  objMsg := TMsgInterna.Create(Nil);
  If Not objMsg.fEnviaMensagem('Devolução da AD ' + strCodAde,
                               strTexto,
                               strCodOpe,
                               qryAux.FieldByName('OCO_OPEOCO').AsString,
                               'N',
                               '') Then
  Begin
    Result := False;
    fRollBack;
    fMensagem('ATENÇÃO!', 'Não foi possível enviar a mensagem para o usuário ' +
      fRetNomeOperador(qryAux.FieldByName('OCO_OPEOCO').AsString) + ' avisando sobre a ' +
      'conclusão da devolução da AD. Favor avisá-lo.', ['&Ok']);
  End;
  FreeAndNil(objMsg);
  FreeAndNil(qryAux);
end;

Function fEnviaMensagemDevolucaoParaOperadorAD(strCodAde, strCodCli, strDocumento: String): Boolean;
  Var
    qryAux: TUniQuery;
    objMsg: TMsgInterna;
    strTexto: String;
begin
  Result := True;

  If Not VS_strHabilitarCRM Then
    Exit;

  If fEmptyStr(strCodAde) Then
    Exit;

  qryAux := fCriaQuery;
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  OCO_CODOPE, ');
  qryAux.SQL.Add('  OCO_PROTOC, ');
  qryAux.SQL.Add('  OCO_OPEOCO  ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  MOVOCO ');
  qryAux.SQL.Add('  JOIN ADEGER ON GER_CODOCO = OCO_CODOCO AND ');
  qryAux.SQL.Add('                 GER_CODEMP = OCO_CODEMP ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_CODADE = :CODADE AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP ');

  qryAux.ParamByName('CODADE').AsString := strCodAde;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.Open;

  strTexto := 'DATA: ' + DateToStr(VS_Date) + STRING_QUEBRA +
              'CLIENTE: ' + strCodCli + '-' + fRetNomCliente(strCodCli) + STRING_QUEBRA +
              'NÚMERO DA AD: ' + strCodAde + STRING_QUEBRA +
              'PROTOCOLO DA OCORRÊNCIA: ' + qryAux.FieldByName('OCO_PROTOC').AsString + STRING_QUEBRA +
              'DOCUMENTO DE DEVOLUÇÃO: ' + strDocumento;

  objMsg := TMsgInterna.Create(Nil);
  If Not objMsg.fEnviaMensagem('Devolução da AD ' + strCodAde + ' realizada.',
                               strTexto,
                               qryAux.FieldByName('OCO_CODOPE').AsString,
                               strLoginUsuarioLogado,
                               'N',
                               '') Then
  Begin
    Result := False;
    fRollBack;
    fMensagem('ATENÇÃO!', 'Não foi possível enviar a mensagem para o usuário ' +
      fRetNomeOperador(qryAux.FieldByName('OCO_OPEOCO').AsString) + ' avisando sobre a ' +
      'conclusão da devolução da AD. Favor avisá-lo.', ['&Ok']);
  End;
  FreeAndNil(objMsg);
  FreeAndNil(qryAux);
end;

{$IFNDEF LINUX}
procedure pEnviaEmailParaClienteInformandoDV(strCodCli, strNomCli, strNumDoc: String;
  dtaDtaEnt: TDateTime; fltVlrCon: Double; strCodOpe, strCliEma: String);
  Var
    strTexto: String;
    arrDestinatarios, arrArquivos: TStringArray;

  function fData(dta: TDateTime): String;
  begin
    Result := FormatDateTime('dd/mm/yyyy', dta);
  end;

  function fValor(fltVal: Double): String;
  begin
    Result := FloatToStrF(fltVal, ffNumber, 12, 2);
  end;

begin
  If Not VS_strHabilitarCRM Then
    Exit;

  strTexto := 'Prezado Cliente ' + strCodCli + ' – ' + strNomCli + ', ' + STRING_ENTER +
              STRING_ENTER +
              'Retornamos com as providências tomadas referente a sua nota fiscal de ' + STRING_ENTER +
              'devolução/garantia ' + strNumDoc + ' de ' + fData(dtaDtaEnt) + ' ' +
              'no valor de ' + fValor(fltVlrCon) + '.' + STRING_ENTER +
              STRING_ENTER +
              'A referida nota fiscal deu origem ao crédito de ' + fValor(fltVlrCon) + ', ' + STRING_ENTER +
              'será concedido em sua próxima compra, onde o valor total será abatido na própria ' + STRING_ENTER +
              'nota fiscal. ' + STRING_ENTER +
              STRING_ENTER +
              'Ficamos a disposição para esclarecer as dúvidas que se apresentar. ' + STRING_ENTER +
              STRING_ENTER +
              'Atenciosamente, ' + STRING_ENTER +
              STRING_ENTER +
              'DAC. ' + STRING_ENTER +
              'Departamento de Atendimento ao Cliente ' + STRING_ENTER +
              fCadEmp('NOMEMP') + ' ' + STRING_ENTER +
              'Fone: ' + fFormataFone(fCadEmp('FONE01'));

  pCriarArrayAnexosEDestinatarios('', strCliEma, arrDestinatarios, arrArquivos);

  TEnvioEmail.EnviarEmail(Application.GetParentComponent(),
                          strLoginUsuarioLogado,
                          'Devolução de mercadorias',
                          arrDestinatarios,
                          [],
                          [],
                          TEnvioEmail.ContruirArrayMensagem(strTexto),
                          arrArquivos);
end;
{$ENDIF}

procedure pMarcaDocumentoDevAD(strCodAde, strCodEmp, strDocDev, strEspDev, strEmpDev: String);
  Var
    qryUpd: TUniQuery;
begin
  qryUpd := fCriaQuery;

  With qryUpd, SQL Do
  Begin
    Close;
    Clear;
    Add(' UPDATE ');
    Add('   ADEGER ');
    Add(' SET ');
    Add('   GER_DOCDEV = :DOCDEV, ');
    Add('   GER_ESPDEV = :ESPDEV, ');
    Add('   GER_EMPDEV = :EMPDEV  ');
    Add(' WHERE ');
    Add('   GER_CODADE = :CODADE AND ');
    Add('   GER_CODEMP = :CODEMP ');

    If Not fEmptyStr(strDocDev) Then
      ParamByName('DOCDEV').AsString := strDocDev;

    If Not fEmptyStr(strEspDev) Then
      ParamByName('ESPDEV').AsString := strEspDev;

    If Not fEmptyStr(strEmpDev) Then
      ParamByName('EMPDEV').AsString := strEmpDev;

    ParamByName('CODADE').AsString := strCodAde;
    ParamByName('CODEMP').AsString := strCodEmp;

    ExecSQL;
  End;

  FreeAndNil(qryUpd);
end;

Procedure pRetornaDadosAD(strNumAut, strCodEmp: String;
                          Var strDocsSel, strCodVen, strCodRep, strCodCli: String);
  Var
    strSQL: String;
    qryMovGer: TUniQuery;
Begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE DISTINCT ';
  strSQL := strSQL + '  GER_NUMDOC,       ';
  strSQL := strSQL + '  GER_ESPDOC,       ';
  strSQL := strSQL + '  GER_CODEMP,       ';
  strSQL := strSQL + '  GER_CODCLI,       ';
  strSQL := strSQL + '  GER_ORIDOC,       ';
  strSQL := strSQL + '  GER_CODVEN,       ';
  strSQL := strSQL + '  GER_CODREP        ';

  strSQL := strSQL + 'FROM                ';

  strSQL := strSQL + '  ADEDET A          ';

  strSQL := strSQL + 'INNER JOIN MOVGER ON GER_NUMDOC = DET_NUMDOC AND  ';
  strSQL := strSQL + '                     GER_ESPDOC = DET_ESPDOC AND  ';
  strSQL := strSQL + '                     GER_CODEMP = DET_CODEMP AND  ';
  strSQL := strSQL + '                     GER_SERIE_ = DET_SERIE_ AND  ';
  strSQL := strSQL + '                     GER_CODCLI = DET_FORCLI      ';

  strSQL := strSQL + 'WHERE DET_CODADE = :CODADE AND  ';
  strSQL := strSQL + '      DET_CODEMP = :CODEMP AND  ';
  strSQL := strSQL + '      DET_TIP_FC = "C"         ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(strSQL,'MOVGER','NOTGER'), 'GER_CODREP', 'NULL AS GER_CODREP');

  strDocsSel := '';
  strCodVen  := '';
  strCodRep  := '';
  strCodCli  := '';

  qryMovGer := fCriaQuery;
  With qryMovGer Do
  Begin
    SQL.Text := strSQL;
    ParamByName('CODADE').AsString := strNumAut;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    If Not IsEmpty Then
    Begin
      strCodVen := FieldByName('GER_CODVEN').AsString;
      strCodRep := FieldByName('GER_CODREP').AsString;
      strCodCli := FieldByName('GER_CODCLI').AsString;
    End;

    While Not Eof Do
    Begin
      strDocsSel := strDocsSel + fChaveDocumentoEntradaMercadorias(qryMovGer);

      Next;

      If Not Eof Then
        strDocsSel := strDocsSel + ',';
    End;
  End;

  FreeAndNil(qryMovGer);
End;

function fRetornaRegimeTributario(strRegTri: String): String;
begin
  Result := '';
  If strRegTri = 'P' Then
    Result := 'Lucro (P)resumido'
  Else If strRegTri = 'R' Then
    Result := 'Lucro (R)eal'
  Else If strRegTri = 'S' Then
    Result := '(S)imples';
end;

function fVerificaDireitoAcessoGrupoOcorrencia(strCodGoc : String) : Boolean;
  Var
    qryConsul : TUniQuery;
Begin
  Try
    qryConsul := fCriaQuery;
    With qryConsul, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT * FROM GOCOPE       ');
      Add(' WHERE GOO_CODOPE = :CODOPE ');
      Add('   AND GOO_CODGOC = :CODGOC ');

      ParamByName('CODGOC').AsString := strCodGoc;
      ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

      Open;
      Result := not IsEmpty;

      If Not Result Then
      Begin
        Close;
        Clear;
        Add(' SELECT *                                       ');
        Add(' FROM OPEGPO                                    ');
        Add('   INNER JOIN GOCGPO ON GOG_CODGPO = GPO_CODGPO ');
        Add(' WHERE GOG_CODGOC = :CODGOC                     ');
        Add('   AND OPE_CODOPE = :CODOPE                     ');

        ParamByName('CODGOC').AsString := strCodGoc;
        ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

        Open;
        Result := not IsEmpty;
      End;

      Close;
    End;

  Finally
    FreeAndNil(qryConsul);
  End;
End;

procedure pGeraHisOcoConferencia(const strAutInc: String; const afcAcao: TAcaoFatCRM);
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Nil);

  Try
    qryGen.SQL.Add('SELECT PEL_NUMDOC, PEL_ESPDOC, PEL_CODEMP ');
    qryGen.SQL.Add('  FROM PEDELE WHERE PEL_SEQELE = ' + QuotedStr(strAutInc));
    qryGen.Open();

    While (Not qryGen.Eof) Do
    Begin
      TUpdateOccurrenceCRM.New()
        .NumDoc(qryGen.FieldByName('PEL_NUMDOC').AsString)
        .EspDoc(qryGen.FieldByName('PEL_ESPDOC').AsString)
        .CodEmp(qryGen.FieldByName('PEL_CODEMP').AsString)
        .AcaFat(afcAcao)
        .pRun();

      qryGen.Next();
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fEnviarOcorrenciaPorEmail(const strCodToc : String) : Boolean;
Begin

  Result := True;

  //Enviar ocorrência por e-mail - Cliente
  If (fCampoTabela('TOC_ENVEMA', 'CADTOC', ['TOC_CODTOC'], [strCodToc]) = 'S') Then
    Exit;

  //Enviar ocorrência por e-mail - Usuário Destino
  If (fCampoTabela('TOC_EMADES', 'CADTOC', ['TOC_CODTOC'], [strCodToc]) = 'S') Then
    Exit;

  Result := False;

End;

{ TFuncoesCRM }

function TFuncoesCRM.fAtualizaInformacoesCRM(strNumDoc_CRM, strEspDoc_CRM,
      strCodEmp_CRM, strCodCli_CRM, strNumOrc_CRM, strEspOrc_CRM,
      strOpeDes_CRM: String; afcAcaFat_CRM: TAcaoFatCRM;
      strEmpFat_CRM: String = ''; strCpfCli_CRM: String = '';
      strCodCliAnt_CRM: String = ''): IAtuOcoCrm;
begin
  Result := untFuncoesCRM.fAtualizaInformacoesCRM(strNumDoc_CRM, strEspDoc_CRM,
    strCodEmp_CRM, strCodCli_CRM, strNumOrc_CRM, strEspOrc_CRM, strOpeDes_CRM,
    afcAcaFat_CRM, strEmpFat_CRM, strCpfCli_CRM, strCodCliAnt_CRM);
end;

function TFuncoesCRM.fRetornaCodigoOcorrencia(strNumDoc, strEspDoc, strCodCli,
  strCodEmp, strNumRom, strNumOrc, strEspOrc: String): String;
begin
  Result := untFuncoesCRM.fRetornaCodigoOcorrencia(strNumDoc, strEspDoc, strCodCli,
    strCodEmp, strNumRom, strNumOrc, strEspOrc)
end;

function VerificarAcessoClienteOrdemDeProducaoIndustrial(Const ACodigoCliente : String): Boolean;
begin
  Result := true;

  If fEmptyStr(ACodigoCliente) Then
    Exit;

  If (Not fVerificaAcessoSistema('CLIOPI')) and (ACodigoCliente = fCfgSis('CLIOPI')) Then
  begin
    fMensagem('ATENÇÃO!','Não é permitido visualizar informações do cliente '+#13+
      'configurado para movimentação de estoque("OI") ordem de produção industrial!', ['&OK']);

    Result := false;
  end;

end;

procedure pPesquisaSitOco(qryTabOri, qryTabela: TUniQuery; strCodSit: String);
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SITOCO ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  SIT_CODSIT = :SIT_CODSIT ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('SIT_CODSIT').AsString := strCodSit;
    Open;
  End;
end;

procedure pAtualizarOcorrenciaCrmConfDoc(documento: TDocumentoCRM;
  strCodEmpConf: String; strNumDocConf: String; strEspDocConf: String;
  strCodOpeConf: String);
Begin
  TUpdateOccurrenceCRM.New()
                      .AcaFat(afcConfirmacaoDocumento)
                      .NumDoc(strNumDocConf)
                      .EspDoc(strEspDocConf)
                      .CodEmp(strCodEmpConf)
                      .NumOrc(documento.strNumDoc)
                      .EspOrc(documento.strEspDoc)
                      .CodOpe(strCodOpeConf)
                      .CodCli(documento.strCodCli)
                      .strNomFrm('Confirmação de Documento')
                      .pRun();
End;

function fTipOcoInformaTemperaturaAtendimento(const strCodGoc, strCodToc: String): Boolean;
Begin
  If (fCfgSis('CRMTEA', varBoolean)) Then
    Result := (fCampoTabela('TOC_TMPATD', 'CADTOC', ['TOC_CODGOC', 'TOC_CODTOC'], [strCodGoc, strCodToc]) = 'S')
  Else
    Result := False;
End;

procedure pAlterarTemperaturaAtendimento(const strTipFc, srtCodOco, strCodEmp, strCodTea: String);
var
  objAtuOcoCrm: TAtuOcoCrm;
Begin
  objAtuOcoCrm := TAtuOcoCrm.Create(Nil);
  Try

    objAtuOcoCrm.pCarregaOcorrencia(strTipFc,
                                    srtCodOco,
                                    strCodEmp);

    objAtuOcoCrm.strCodTea := strCodTea;
    objAtuOcoCrm.afcAcaFat := afcAlteracaoTemperaturaAtend;
    objAtuOcoCrm.pProcessaFatOcorrenciasCRM;
  Finally
    FreeAndNil(objAtuOcoCrm);
  End;
End;

function fVerificaPermiteCancelarDocumentoCRM(const strNumDoc,strEspDoc,strCodCli,strCodEmp,strNumRom: String;
  strNumOrc: String = ''; strEspOrc: String = ''): Boolean;
var
  strCodOco: String;
Begin
  Result := False;

  strCodOco := fRetornaCodigoOcorrencia(strNumDoc, strEspDoc, strCodCli,
                                        strCodEmp, strNumRom, strNumOrc, strEspOrc);

  If fEmptyStr(strCodOco) Then
    Exit(True);

  objAtuOcoCrm := TAtuOcoCrm.Create(Nil);
  Try
    objAtuOcoCrm.pCarregaOcorrencia('C',
                                    strCodOco,
                                    strCodEmp);

    If objAtuOcoCrm.blnAgrupamentoPedidos Then
      Exit(True);
  Finally
    FreeAndNil(objAtuOcoCrm);
  End;
End;

procedure pFinalizarOcorrenciaDocumentoCancelado(const strNumDoc, strEspDoc, strCodCli,
  strCodEmp, strTipFc: String);
Begin
  TUpdateOccurrenceCRM.New()
                      .NumDoc(strNumDoc)
                      .EspDoc(strEspDoc)
                      .CodEmp(strCodEmp)
                      .CodCli(strCodCli)
                      .AcaFat(afcDocumentoCancelado)
                      .strNomFrm('[pAtualizarCRMCancelamentoDocumento]')
                      .Tip_Fc(strTipFc)
                      .pRun();
End;


procedure pReabrirOcorrenciaPorDocumento(const strNumDoc, strEspDoc, strCodCli,
  strCodEmp, strTipFc: String);
Begin
  TUpdateOccurrenceCRM.New()
                      .NumDoc(strNumDoc)
                      .EspDoc(strEspDoc)
                      .CodEmp(strCodEmp)
                      .CodCli(strCodCli)
                      .AcaFat(afcReabrirDocumentoFaturado)
                      .strNomFrm('[pReabrirOcorrenciaPorDocumento]')
                      .Tip_Fc(strTipFc)
                      .pRun();
End;

function fOcorrenciaPossuiADVinculada(const ACodOco: String; ACodEmp: String): Boolean;
var
  strSQL: String;
  qrySelect: TUniQuery;
begin
  Result := False;

  qrySelect := fCriaQuery(Nil);

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE  ';
    strSQL := strSQL + '  COUNT(*) AS QTDADE ';
    strSQL := strSQL + 'FROM                 ';
    strSQL := strSQL + '  ADEGER             ';
    strSQL := strSQL + 'WHERE GER_CODOCO = :GER_CODOCO ';
    strSQL := strSQL + '  AND GER_CODEMP = :GER_CODEMP ';

    qrySelect.SQL.Add(strSQL);
    qrySelect.ParamByName('GER_CODOCO').AsString := ACodOco;
    qrySelect.ParamByName('GER_CODEMP').AsString := ACodEmp;
    qrySelect.Open();

    If Not qrySelect.IsEmpty Then
    Begin
      Result := qrySelect.FieldByName('QTDADE').AsInteger > 0;
    End;

  Finally
    FreeAndNil(qrySelect);
  End;

end;

end.
