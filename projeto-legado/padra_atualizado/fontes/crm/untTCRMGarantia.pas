unit untTCRMGarantia;

interface
uses
  untAtualizaOcorrenciasCRM,
  untGarantiaRecCliente,
  untTypesCRM,
  untIFuncoesCRM;

Type
  TDadosGarantiaCRM = Record
    strCodCli,
    strCodEmp,
    strNomCli,
    strNomFrm,
    strNumEnt,
    strEspDoc,
    strCodAde,
    strDescri: String;
    blnGeraCreditoNoRecebimento: Boolean;
  end;

  TCRMGarantia = Class
  Private
    FUpdateOccurrenceCRM: IUpdateOccurrenceCRM;
    FrecDadosGA: TDadosGarantiaCRM;
    procedure pCancelarOcorrenciaCRM;overload;
    function fGetDadosGarantia: TDadosGarantiaCRM;
    procedure pIncluirHistoricoOcorrenciaItem(pstrCodIte, pstrDesite: String;
      pfltQtdIte: Double; penuAcaoFatCRM: TAcaoFatCRM);
    procedure pIncluirOcorrenciaCRM;overload;
    procedure pIncluirOcorrenciaCRM(penuAcaoFatCRM: TAcaoFatCRM);overload;
    procedure pIncluirOcorrenciaRecebimentoCliente(pOperacaoGarantia: TOperacaoGarantia); overload;
    procedure pSetDadosGarantia(const pValue: TDadosGarantiaCRM);
    function fMontarDescricao: String;

  public
    property recDadosGarantia: TDadosGarantiaCRM Read fGetDadosGarantia Write pSetDadosGarantia;
    constructor Create;
    class procedure pCancelarOcorrenciaCRM(precDadosGarantiaCRM: TDadosGarantiaCRM);overload;
    procedure pIncluirHistoricoLiberacaoCreditoItem(pstrCodIte, pstrDesite: String; pfltQtdIte: Double);
    procedure pIncluirHistoricoLiberacaoEnvioCliente(pstrCodIte, pstrDesite: String; pfltQtdIte: Double);
    class procedure pIncluirOcorrenciaRecebimentoCliente(precDadosGarantiaCRM:
      TDadosGarantiaCRM; pOperacaoGarantia: TOperacaoGarantia); overload;
  End;

implementation

uses
  untFuncoesSimples,
  StrUtils,
  SysUtils,
  System.Classes;

{ TCRMGarantia }

constructor TCRMGarantia.Create;
begin
  FUpdateOccurrenceCRM := TUpdateOccurrenceCRM.New();
end;

function TCRMGarantia.fGetDadosGarantia: TDadosGarantiaCRM;
begin
  Result := FrecDadosGA;
end;

function TCRMGarantia.fMontarDescricao: String;
Var
  lStrings: TstringList;
begin
  Result := '';
  lStrings := TStringList.Create;
  Try
    lStrings.Clear;
    lStrings.NameValueSeparator := '=';

    if Not fEmptyStr(FrecDadosGA.strCodAde) then
      lStrings.Add('CODADE='+Trim(FrecDadosGA.strCodAde));

    if Not fEmptyStr(FrecDadosGA.strDescri) then
      lStrings.Add('DESCRI='+FrecDadosGA.strDescri);
    if lStrings.Count > 0 then
      Result := lStrings.Text;
  Finally
    lStrings.Free;
  End;
end;

class procedure TCRMGarantia.pCancelarOcorrenciaCRM(
  precDadosGarantiaCRM: TDadosGarantiaCRM);
Var
  lCRMGarantia: TCRMGarantia;
begin
  lCRMGarantia := TCRMGarantia.Create;
  Try
    lCRMGarantia.recDadosGarantia := precDadosGarantiaCRM;
    lCRMGarantia.pCancelarOcorrenciaCRM;
  Finally
    lCRMGarantia.Free;
  End;
end;

procedure TCRMGarantia.pCancelarOcorrenciaCRM;
begin
  FUpdateOccurrenceCRM
    .AcaFat(afcGarantiaCancelada);
  pIncluirOcorrenciaCRM;
end;



procedure TCRMGarantia.pIncluirHistoricoLiberacaoCreditoItem(pstrCodIte,
  pstrDesite: String; pfltQtdIte: Double);
begin
  pIncluirHistoricoOcorrenciaItem(pstrCodite,
                                  pstrDesite,
                                  pfltQtdIte,
                                  afcGarantiaAndamentoPendLibCrd_Confirmacao);
end;

procedure TCRMGarantia.pIncluirHistoricoLiberacaoEnvioCliente(pstrCodIte,
  pstrDesite: String; pfltQtdIte: Double);
begin
  pIncluirHistoricoOcorrenciaItem(pstrCodite,
                                  pstrDesite,
                                  pfltQtdIte,
                                  afcGarantiaAndamentoPendEnvCli_Confirmacao);
end;

procedure TCRMGarantia.pIncluirHistoricoOcorrenciaItem(pstrCodIte,
  pstrDesite: String; pfltQtdIte: Double; penuAcaoFatCRM: TAcaoFatCRM);
begin
  FUpdateOccurrenceCRM
    .CodIte(pstrCodite)
    .DesIte(pstrDesite)
    .QtdIte(pfltQtdIte)
    .AcaFat(penuAcaoFatCRM);
  pIncluirOcorrenciaCRM;
end;

procedure TCRMGarantia.pIncluirOcorrenciaRecebimentoCliente(
  pOperacaoGarantia: TOperacaoGarantia);
Var
  lenuAcaoFatCRM: TAcaoFatCRM;
begin
 If Not VS_strHabilitarCRM Then
    Exit;

  case pOperacaoGarantia of
    TOperacaoGarantia.ogReposicao: lenuAcaoFatCRM := afcGarantiaReposicaoItemConcluida;

    TOperacaoGarantia.ogCredito:
    begin
      if FrecDadosGA.blnGeraCreditoNoRecebimento then
        lenuAcaoFatCRM := afcGarantiaCredito
      else
        lenuAcaoFatCRM := afcGarantiaAndamentoPendLibCrd;
    end
    else
    begin
      if FrecDadosGA.blnGeraCreditoNoRecebimento then
        lenuAcaoFatCRM := afcGarantiaAndamentoPendEnvCli
      else
        lenuAcaoFatCRM := afcGarantiaAndamentoPendLibCrd;
    end;
  end;

  pIncluirOcorrenciaCRM(lenuAcaoFatCRM);
end;

procedure TCRMGarantia.pSetDadosGarantia(const pValue: TDadosGarantiaCRM);
begin
  FrecDadosGA := pValue;
end;

procedure TCRMGarantia.pIncluirOcorrenciaCRM(penuAcaoFatCRM: TAcaoFatCRM);
Begin
  FUpdateOccurrenceCRM
    .AcaFat(penuAcaoFatCRM);
  pIncluirOcorrenciaCRM;
end;

procedure TCRMGarantia.pIncluirOcorrenciaCRM;
Var
  lstrDescri: String;
begin
  lstrDescri := fMontarDescricao;

  FUpdateOccurrenceCRM
    .NumDoc(FrecDadosGA.strNumEnt)
    .EspDoc(FRecDadosGA.strEspDoc)
    .CodEmp(FrecDadosGA.strCodEmp)
    .CodCli(FrecDadosGA.strCodCli)
    .NomCli(FrecDadosGA.strNomCli)
    .Tip_Fc('C')
    .CodOpe(strLoginUsuarioLogado)
    .strNomFrm('['+FrecDadosGA.strNomFrm+']')
    .Descri(lstrDescri);
  FUpdateOccurrenceCRM.pRun();
end;

class procedure TCRMGarantia.pIncluirOcorrenciaRecebimentoCliente(
  precDadosGarantiaCRM: TDadosGarantiaCRM; pOperacaoGarantia: TOperacaoGarantia);
Var
  lCRMGarantia: TCRMGarantia;
begin
  lCRMGarantia := TCRMGarantia.Create;
  Try
    lCRMGarantia.recDadosGarantia := precDadosGarantiaCRM;
    lCRMGarantia.pIncluirOcorrenciaRecebimentoCliente(pOperacaoGarantia);
  Finally
    lCRMGarantia.Free;
  End;
end;

end.
