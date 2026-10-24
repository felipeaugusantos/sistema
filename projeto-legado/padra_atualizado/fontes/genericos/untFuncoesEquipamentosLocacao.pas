unit untFuncoesEquipamentosLocacao;

interface

uses
  SysUtils, Classes, Controls, StrUtils, Uni;

Type

  TTpSituacaoEquipamentoLocacao = (tpAtivo, tpInativo, tpBloqueado);
  TTpEquipamentoLocacao = (tpPrincipal, tpAcessorio);
  TTipoCalculoValorLocacao = (tpHoras, tpDiaria, tpNone);
  TStatusContratoLocacao = (stNone, stOrcamento, stAtivo, stFaturado, stCancelado);
  TTipoFaturamentoLocacao = (tpTotal, tpParcial);
  TTipoInspecao = (tpInspSaidaEqu, tpInspSaidaAce, tpInspEntraEqu, tpInspEntraAce, tpInspNone);
  TTipoManutencao = (tpAlterarInspecao, tpAlterarCobranca, tpCancelar);
  TPrecoContrato = (preCompraLiq = 1, preCusto = 2, preMedio = 3, preTabela1 = 4, preTabela2 = 5, preTabela3 = 6, preTabela4 = 7, preTabela5 = 8, preTabela6 = 9, preTabela7 = 10);

  function fTpSitEquipamentoLocacaoToStr(const aTipoEquipamento: TTpEquipamentoLocacao): String;
  function fStrTipoEquipamentoLocacaoToTpEquipamentoLocacao(const strTipEquipamento: String): TTpEquipamentoLocacao;
  function fObtemDescricaoSitEquipamentoLocacao(const aSituacao: String): String;
  function fRetDescAcessorio(const strCodAcl: String): String;
  function fTipoCalculoVlLocacaoToStrTipoCalculoVlLocacao(const aTipoCalculo: TTipoCalculoValorLocacao): String;
  function fStrTipoCalculoVlLocacaoToTipoCalculoVlLocacao(const strTipoCalculo: String): TTipoCalculoValorLocacao;
  function fTipoCalculoVlLocacao(const aTipoCalculo: String): String;
  function fStrSituacaoContratoToStatusSituacaoContrato(const strStatus: String): TStatusContratoLocacao;
  function fStrSituacaoContrato(const aSituacaoContrato: String): String;
  function fStatusSituacaoContratoToStrSituacaoContrato(const aStatus: TStatusContratoLocacao): string;
  function fRetornaUltimoDiaMes(const aMesRef: String): TDateTime;
  function fRetornaPrimeiroDiaMes(const aMesRef: String): TDateTime;
  function fObtemData(const aData: TDateTime): TDateTime;
  function fObtemHora(const aData: TDateTime): TDateTime;
  function fNotaEntradaLocEquipamentoExiste(strNumDoc, strEspDoc,
             strSerie, strCliFor, strCodEmp, strTip_FC: String): Boolean;

const
  arrTpSituacaoEquipamentoLocacao: array[TTpSituacaoEquipamentoLocacao] of string = ('A', 'I', 'B');
  arrTpEquipamentoLocacao : array[TTpEquipamentoLocacao] of string = ('P', 'A');
  arrTpCalculoVlLocacao: array[TTipoCalculoValorLocacao] of string = ('H', 'D', '');
  arrSitContratoLocacao: array[TStatusContratoLocacao] of string = ('', 'O', 'A', 'F', 'C');

  cst_TRAVA_FATMENSAL = 'FATMENSAL';

implementation

uses
  untFuncoesSimples, DateUtils;

function fTpSitEquipamentoLocacaoToStr(const aTipoEquipamento: TTpEquipamentoLocacao): String;
Begin
  Try
    Result := arrTpEquipamentoLocacao[aTipoEquipamento];
  Except
    Result := EmptyStr
  End;
End;

function fStrTipoEquipamentoLocacaoToTpEquipamentoLocacao(const strTipEquipamento: String): TTpEquipamentoLocacao;
Begin
  Case AnsiIndexStr(UpperCase(strTipEquipamento), arrTpEquipamentoLocacao) Of
    1 : Result := tpAcessorio
    Else
      Result := tpPrincipal;
  End;
End;

function fObtemDescricaoSitEquipamentoLocacao(const aSituacao: String): String;
Begin
  Result := '';

  Case AnsiIndexStr(UpperCase(aSituacao), arrTpSituacaoEquipamentoLocacao) Of
    0 : Result := 'ATIVO';
    1 : Result := 'INATIVO';
    2 : Result := 'BLOQUEADO';
  End;
End;

function fRetDescAcessorio(const strCodAcl: String): String;
Begin
  Result := fCampoTabela('ACL_DESCRI', 'CADACL', ['ACL_CODIGO'], [strCodAcl], False);
End;

function fTipoCalculoVlLocacaoToStrTipoCalculoVlLocacao(const aTipoCalculo: TTipoCalculoValorLocacao): String;
Begin
  Try
    Result := arrTpCalculoVlLocacao[aTipoCalculo];
  Except
    Result := EmptyStr
  End;
End;

function fStrTipoCalculoVlLocacaoToTipoCalculoVlLocacao(const strTipoCalculo: String): TTipoCalculoValorLocacao;
Begin
  Case AnsiIndexStr(UpperCase(strTipoCalculo), arrTpCalculoVlLocacao) Of
    1 : Result := tpDiaria
    Else
      Result := tpHoras;
  End;
End;

function fTipoCalculoVlLocacao(const aTipoCalculo: String): String;
Begin
  Result := '';

  Case AnsiIndexStr(UpperCase(aTipoCalculo), arrTpCalculoVlLocacao) Of
    1 : Result := 'DIÁRIAS'
  Else
    Result := 'HORAS';
  End;
End;

function fStrSituacaoContratoToStatusSituacaoContrato(const strStatus: String): TStatusContratoLocacao;
Begin
  Case AnsiIndexStr(UpperCase(strStatus), arrSitContratoLocacao) Of
    1 : Result := stOrcamento;
    2 : Result := stAtivo;
    3 : Result := stFaturado;
    4 : Result := stCancelado
    Else
      Result := stNone;
  End;
End;

function fStrSituacaoContrato(const aSituacaoContrato: String): String;
Begin
  Result := '';

  Case AnsiIndexStr(UpperCase(aSituacaoContrato), arrSitContratoLocacao) Of
    1 : Result := 'ORÇAMENTO';
    2 : Result := 'ATIVO';
    3 : Result := 'FATURADO';
    4 : Result := 'CANCELADO'
  Else
    Result := '';
  End;
End;

function fStatusSituacaoContratoToStrSituacaoContrato(const aStatus: TStatusContratoLocacao): string;
Begin
  Result := fStrSituacaoContrato(arrSitContratoLocacao[aStatus]);
End;

function fRetornaUltimoDiaMes(const aMesRef: String): TDateTime;
var
  strPrimeiroDiaMes: String;
  dtaPrimeiroDiaMes: TDateTime;
  dtaUltimoDiaMes: TDateTime;
  strUltimoDiaMes: String;
Begin
  dtaUltimoDiaMes := 0;
  Try
    If fEmptyStr( aMesRef ) Then
    Begin
      Result := 0;
      Exit;
    End;

    strPrimeiroDiaMes := '01/' + aMesRef;
    dtaPrimeiroDiaMes := StrToDateTime(strPrimeiroDiaMes);

    strUltimoDiaMes := IntToStr(DaysInMonth(dtaPrimeiroDiaMes)) + '/' + aMesRef;
    dtaUltimoDiaMes := StrToDateTime(strUltimoDiaMes);
  Finally
    Result := dtaUltimoDiaMes;
  End;
End;

function fRetornaPrimeiroDiaMes(const aMesRef: String): TDateTime;
var
  strPrimeiroDiaMes: String;
  dtaPrimeiroDiaMes: TDateTime;
Begin
  dtaPrimeiroDiaMes := 0;

  Try
    If fEmptyStr( aMesRef ) Then
    Begin
      Result := 0;
      Exit;
    End;

    strPrimeiroDiaMes := '01/' + aMesRef;
    dtaPrimeiroDiaMes := StrToDateTime(strPrimeiroDiaMes);
  Finally
    Result := dtaPrimeiroDiaMes;
  End;
End;

function fObtemData(const aData: TDateTime): TDateTime;
Begin
  Try
    Result := StrToDateTime(FormatDateTime('dd/mm/yyyy', aData));
  Except
    Result := aData;
  End;
End;

function fObtemHora(const aData: TDateTime): TDateTime;
Begin
  Try
    Result := StrToDateTime(FormatDateTime('hh:mm', aData));
  Except
    Result := aData;
  End;
End;

function fNotaEntradaLocEquipamentoExiste(strNumDoc, strEspDoc,
  strSerie, strCliFor, strCodEmp, strTip_FC: String): Boolean;
Var
  strAutinc: String;
begin
  strAutinc := fCampoTabela('AUTOINCREM',
                             'MOVGER',
                             ['GER_NUMDOC',
                               'GER_ESPDOC',
                               'GER_SERIE_',
                               IIF(strTip_FC = 'C', 'GER_CODCLI', 'GER_CODFOR'),
                               'GER_CODEMP',
                               'GER_TIP_FC'],
                             [strNumDoc,
                               strEspDoc,
                               strSerie,
                               strCliFor,
                               strCodEmp,
                               strTip_FC]);

  Result := (Not fEmptyStr(strAutinc));
end;

end.
