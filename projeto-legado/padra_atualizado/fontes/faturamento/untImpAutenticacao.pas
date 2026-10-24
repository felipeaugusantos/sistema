unit untImpAutenticacao;

interface

uses SysUtils, Uni, DB, WinSpool, untImpNaoFiscal, Dialogs, StrUtils,UniDataSetProvider,
  Windows, Forms, Classes, UniClientDataSet, frxClass, untFuncFatTypes, untConsertoEquipamento,
  untFuncoesSimples, untFuncoesGenerica, Math, Graphics, MaskUtils, DateUtils, untImpMatricial;


Type
  TImpAutenticacao = class(TObject)
    protected
      FNomImp     : String;
      qryCfgRel   : TUniQuery;
      impMatricial: TImpMatricial;
    public
      procedure pImprimeAutenticacao(strNumDoc, strParcel, strEspDoc, strCodCli, strCodEmp, strValor, strCodOpe: String);
      procedure pImprimeAutenticacaoF11(strNumDoc, strEspDoc, strCodEmp, strDtaEnt,
        strHorEnt, strCodVen, strVlrCon, strConPag, strNumDocConf, strEspDocConf : String);

      Constructor Create(strNomImp: String);
      Destructor Destroy; override;
  end;

implementation

uses untFuncoes, untConstantes, untCfgRel;

{TImpAutenticacao}


constructor TImpAutenticacao.Create(strNomImp: String);
begin
  inherited Create;
  FNomImp      := strNomImp;
  qryCfgRel    := fCriaQuery;
  impMatricial := TImpMatricial.Create(FNomImp);
end;

destructor TImpAutenticacao.Destroy;
begin
  FreeAndNil(impMatricial);
  FreeAndNil(qryCfgRel);

  inherited Destroy;
end;

procedure TImpAutenticacao.pImprimeAutenticacao(strNumDoc, strParcel, strEspDoc, strCodCli, strCodEmp, strValor, strCodOpe: String);
begin

  While fGetMenu('Selecione', ['Imprimir Autenticação','Sair'], 1) = 1 Do
  Begin
    impMatricial.pSetaInfoImpressoraMatricial('Impressão de Autenticação', True, True);

    impMatricial.pInicializarImpressoraMatricial;

    ImpMatricial.Reseta;
    ImpMatricial.Imp(ImpMatricial.Um_Oitavo(True), False);

    ImpMatricial.Imp('<' + strNumDoc + '-' +
                      strParcel + '-' +
                      strEspDoc + '-' +
                      strCodEmp + '-' +
                      strCodCli + '-' +
                      strValor  + '-' +
                      strCodOpe + '-' +
                      FormatDateTime('dd/mm/yyyy', VS_Date) + '-' +
                      FormatDateTime('hh:mm:ss', fTime())   + '>',False);

    ImpMatricial.pFinalizarImpressoraMatricial;
  End;

end;


procedure TImpAutenticacao.pImprimeAutenticacaoF11(strNumDoc, strEspDoc,
  strCodEmp, strDtaEnt, strHorEnt, strCodVen, strVlrCon, strConPag,
  strNumDocConf, strEspDocConf: String);
begin
  While fGetMenu('Selecione', ['Imprimir Autenticação','Sair'], 1) = 1 Do
  Begin

    impMatricial.pSetaInfoImpressoraMatricial('Impressão de Faturamento', True, False);

    impMatricial.pInicializarImpressoraMatricial;

    impMatricial.Reseta;
    impMatricial.Imp(impMatricial.Cond_10CPI(False), False);
    impMatricial.Imp(impMatricial.CPI_12(False), False);
    impMatricial.Imp(impMatricial.Um_Oitavo(True), False);

    impMatricial.Imp(impMatricial.Cond_10CPI(True), False);
    impMatricial.Imp(impMatricial.CPI_12(True));

    if fCfgSis('AUT40C', varBoolean) then
    begin
      impMatricial.Imp('<' + fPadR(rightstr(strNumDoc,6),6) + '-' +
          strEspDoc + '-' +
          strCodEmp + '-' +
          strDtaEnt + '-' +
          fPadR(rightstr(strNumDocConf,6),6) + '-' + strEspDocConf + '-' +
          strVlrCon + '>');
    end
    else
    begin
      impMatricial.Imp('<' + strNumDoc + '-' +
          strEspDoc + '-' +
          strCodEmp + '-' +
          strDtaEnt + '-' +
          strHorEnt + '-' +
          strCodVen + '-' +
          fPadR(fRetNomVendRep(strCodVen),20) + '-' +
          strNumDocConf + '-' + strEspDocConf + '-' +
          strVlrCon + '-' +
          strConPag + '>');
    end;

    impMatricial.pFinalizarImpressoraMatricial;
  End;
end;

end.
