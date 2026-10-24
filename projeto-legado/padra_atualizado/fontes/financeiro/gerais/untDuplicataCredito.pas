unit untDuplicataCredito;

interface

type
  TBaixaCredito = record
    strNumDup : String;
    strParcel : String;
    strEspDoc : String;
    strCodEmp : String;
    strCodCli : String;
    strNomCli : String;
    fltValBxa : Double;
    dtaDtaRec : TDate;
    strEmpLog : String;
    strOpeBai : String;
    strPortador : String;
    blnGravaCaixa : Boolean;
    intSeqConRcx : Integer;
    strNomeForm : String;
    strHistoricoBaixa : String;
  End;

  TDuplicataCredito = class
  public
    class function fBaixaDuplicataCredito(const AInput : TBaixaCredito): Boolean;
  End;

implementation

uses untFuncoesSimples, untCadRec, untCadRcxx, Uni, System.SysUtils;

class function TDuplicataCredito.fBaixaDuplicataCredito(const AInput : TBaixaCredito) : Boolean;
  Var
    strAutIncRcx : String;
    strPorBai : String;
    strCtaBai : String;
begin
  If AInput.blnGravaCaixa Then
  Begin
    strPorBai := fCfgSis('PORRCX');
    strCtaBai := fCfgSis('CTARCX');
  End
  Else
  Begin
    strPorBai := AInput.strPortador;
    strCtaBai := fCfgSis('CTAAVI');
  End;

  If fEmptyStr(fRetDescCentroCusto(fCfgSis('CTARCX'))) Then
  Begin
    fRollBack;
    fMensagem('', 'A configuração Plano de Contas para baixa do Contas a Receber do grupo Resumo de Caixa está vazia ou preenchida incorretamente, corrija!', ['&Ok']);
    Result := False;
    Exit;
  End;

  If fEmptyStr(fRetNomPortador(fCfgSis('PORRCX'))) Then
  Begin
    fRollBack;
    fMensagem('', 'A configuração Portador para baixa do Contas a Receber do grupo Resumo de Caixa está vazia ou preenchida incorretamente, corrija!', ['&Ok']);
    Result := False;
    Exit;
  End
  Else If Not fEmpresaTemAcessoPortador(strPorBai) Then
  Begin
    fRollback;
    fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar o portador '+ strPorBai +'. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
    Result := False;
    Exit;
  End;

  Result := fBaixaTotal(AInput.strNumDup,
                        AInput.strParcel,
                        AInput.strEspDoc,
                        AInput.strCodEmp,
                        AInput.strCodCli,
                        0,
                        AInput.fltValBxa,
                        0,
                        0,
                        0,
                        0,
                        AInput.fltValBxa,
                        0,
                        0,
                        0,
                        AInput.dtaDtaRec,
                        '',
                        AInput.strHistoricoBaixa,
                        strCtaBai,
                        strPorBai,
                        AInput.strOpeBai,
                        0,
                        False,
                        False,
                        True,
                        False,
                        False,
                        False,
                        IIF(AInput.blnGravaCaixa, 1, 0),
                        AInput.intSeqConRcx,
                        0,
                        'N',
                        IIF(Not fEmptyStr(AInput.strEmpLog), AInput.strEmpLog, VS_strCodEmp));

  If (Result) Then
    pGravaLogCtr(AInput.strNumDup,
                 AInput.strEspDoc,
                 AInput.strCodCli,
                 AInput.strCodEmp,
                 AInput.strParcel,
                 0,
                 'BAIXA TOTAL',
                 AInput.strNomeForm);

  If (Result) And (AInput.blnGravaCaixa) Then
    Result := fGravaCadRcx(strAutIncRcx,
                           AInput.strCodCli,
                           AInput.strOpeBai,
                           AInput.strNumDup,
                           AInput.strEspDoc,
                           IIF(fEmptyStr(AInput.strEmpLog), VS_strCodEmp, AInput.strEmpLog),
                           AInput.dtaDtaRec,
                           fRetHoraServidor,
                           AInput.strNumDup,
                           AInput.strParcel,
                           AInput.strHistoricoBaixa,
                           '',
                           '',
                           '',
                           AInput.fltValBxa,
                           0.0,
                           0.0,
                           AInput.fltValBxa,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           '',
                           AInput.intSeqConRcx,
                           0,
                           fCfgSisL('SQFCRX'),
                           AInput.strCodEmp,
                           '',
                           1,
                           0,
                           0,
                           0,
                           0,
                           0);
end;


end.
