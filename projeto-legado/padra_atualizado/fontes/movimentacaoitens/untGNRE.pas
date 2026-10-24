unit untGNRE;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, UniClientDataSet, Controls,
     Math, Contnrs, untZClient, cxProgressBar, untParCalculaPrecoCusto,
     untTConfiguracao, untPortadorFornecedor, untPreAlt_Trigger, untEntNfeXml ,
     untTValidaNFeCapa, untEntPagtoAntecipado;

Type
  TTipoChamada = (tcGnreST, tcGnreTributado, tcGnrePadrao, tcTCIF, tcTS);
  TGNRE = Class(TComponent)
  Private
    FCodPor: String;
    strTipAbfCfg: String;
    strTipAbf: String;
    blnIFCPST: Boolean;
    blnIGNSIM: Boolean;
    blnContribuinteIPI: Boolean;
    blnValidaPisCofins: Boolean;
    strEstEmp: String;
    blnConsiderarDescontoDesonerado: Boolean;
    FExcluida: Boolean;
    FAutoin: String;
    FI_E_S_: String;
    FEstFav: String;
    FDtaGnr: String;
    FBcoGnr: String;
    FNomBan: String;
    FAgeGnr: String;
    FValGnr: String;
    FDtaVen: String;
    FMesAno: String;
    FConPro: String;
    FAutBan: String;
    FCodFor: String;
    FNomFor: String;
    FCodCta: String;
    FDesCta: String;
    FCodEve: String;
    FNumGnr: String;
    FGraFin: Boolean;

    FForDoc: String;
    FSerie : String;
    FNumDoc: String;
    FEspDoc: String;

    FBasCal: String;
    FTipGui: String;
    FCodRec: String;

    FVeiBol : String; // Veio Boleto
    FVeioNF : String; // Veio NF
    FUsaChq : String; // Usa Cheque
    FPrevis : String; // Previsão
    FPagAnt : String; // Pagamento antecipado
    FUsoCon : String; // Uso e Consumo
    FTipDoc : String; // Tipo do documento
    FDeposi : String; // Deposito
    FCompet : String; // Competencia
    FBcoFor : String; // Dados bancario
    FGuiTri : String; // Cod. Guia Tributo
    FHist01 : String; // Histórico 01

    FSeqReg: Integer;

    FAutInc : String;  //MF: 318719

    FItens:  TZClient;
    FTipoChamada: TTipoChamada;
    FCampoValor: String;
    FCampoCalculado: String;
    FTabela: String;
    qryTribut: TUniQuery;


    FPortadorFornecedor : TPortadorFornecedor;

    FPgoAntecipadoGnre : TEntPagtoAntecipado;

    procedure setI_E_S_(const Value: String);
    procedure setEstFav(const Value: String);
    procedure setDtaGnr(const Value: String);
    procedure setBcoGnr(const Value: String);
    procedure setAgeGnr(const Value: String);
    procedure setValGnr(const Value: String);
    procedure setDtaVen(const Value: String);
    procedure setMesAno(const Value: String);
    procedure setConPro(const Value: String);
    procedure setAutBan(const Value: String);
    procedure setCodFor(const Value: String);
    procedure setCodCta(const Value: String);

    procedure setBasCal(const Value: String);
    procedure setTipGui(const Value: String);
    procedure setCodRec(const Value: String);

    Function fGravaCadGnr(strNumDoc, strEspDoc, strSerie, strForDoc, strAutIncCadFis: String; bGraFin: Boolean = False): Boolean;
    Function fGravaCadAjustes(strAutoincrem: String): Boolean;

    Function fVerificaItens(blnComNFE: Boolean; var blnOcultaCamposGNRE: Boolean): Boolean;
    function fVErificaSeTemCTE_E_Pergunta_Se_DesejaRecalcularValorGNRE(blnPergunta: Boolean = True):Boolean;

    Function fSQLTributacao: string;

    Function fCarregaTributacao(strCodIte, strEstFor: String): Boolean;
    Function fDescontoXML(recGerEle: TRecGerEle; recDetCal: TRecDetEle): Double;


    procedure pRecalculaGNRE(blnAlteracao: Boolean = False);
    function fCarregaGerEle(strAutInc: String): TRecGerEle;
    function fCarregaDetEle(strAutInc: String): TRecDetEle;
    function fTipoCalculoBaseST(strCodFor: String): TCalculoBaseSubstituicaoXML;

    Function fCarregaDadosFornecedor(strCodFor: String): TUniQuery;

    Function fSQLItens(blnComNFE: Boolean): String;
    function fRetTotalBasSTCalculado: Double;
    procedure setTipoChamada(const Value: TTipoChamada);
    function fExtrairValorMemCalcGNRE(AMemCal: String): Double;

  Public
    FblnComNFE: Boolean;
    FblnOcultaCamposGNRE: Boolean;
    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; override;

    function fGetNomeProcesso: String;

    function fGravaGnre(strNumDoc, strEspDoc, strSerie, strForDoc, strCodOpe, strNomForm: String;
                        blnImprimeCP: Boolean; dtaDtaDoc : TDate; strAutIncCadFis : String; blnDelCadGnre : Boolean = True): Boolean;
    function fAtualizaAutBancaria(blnImprimeCP : Boolean) : Boolean;
    procedure pVerificaPrevia;
    procedure pTelaGnre(blnComNFE: Boolean; strCodFor : String = '');
    function fTelaGnre(strCodFor : String = ''; blnEdita : Boolean = False; blnComNFE: Boolean = False; blnOcultaCamposGNRE: Boolean = True; blnDigAposEntrada: Boolean= False): Boolean;
    procedure pLimparTudo;
    function fAtualizaValorGnre:Boolean;
    function fRateiaGnre:Boolean;
    function fRateiaTS:Boolean;
    procedure pDeletaGnre(strCodEmp, strNumDoc, strEspDoc, strCodFor, strForDoc: String);
    procedure pCarregaGnre(strAutoincrem : String);
    Function fTemItensSelecionados: Boolean;
    function fRetTipoChamatoToChar: string;

  published
    property strI_E_S_: String Read FI_E_S_  Write SetI_E_S_;
    property strEstFav: String Read FEstFav  Write SetEstFav;
    property strDtaGnr: String Read FDtaGnr  Write SetDtaGnr;
    property strBcoGnr: String Read FBcoGnr  Write SetBcoGnr;
    property strAgeGnr: String Read FAgeGnr  Write SetAgeGnr;
    property strValGnr: String Read FValGnr  Write SetValGnr;
    property strDtaVen: String Read FDtaVen  Write SetDtaVen;
    property strMesAno: String Read FMesAno  Write SetMesAno;
    property strConPro: String Read FConPro  Write SetConPro;
    property strAutBan: String Read FAutBan  Write SetAutBan;
    property strNomBan: String Read FNomBan;
    property strCodFor: String Read FCodFor  Write SetCodFor;
    property strNomFor: String Read FNomFor;
    property strCodCta: String Read FCodCta  Write SetCodCta;
    property strDesCta: String Read FDesCta;

    property strCodEve: String Read FCodEve  Write FCodEve;

    property blnGraFin: Boolean Read FGraFin Write FGraFin;
    property strForDoc: String Read FForDoc  Write FForDoc;
    property strSerie : String Read FSerie   Write FSerie;
    property strNumDoc: String Read FNumDoc  Write FNumDoc;
    property strEspDoc: String Read FEspDoc  Write FEspDoc;
    property strNumGnr: String Read FNumGnr  Write FNumGnr;
    property strAutoin: String Read FAutoin;

    property strCodPor: String Read FCodPor  Write FCodPor;

    property intSeqReg: Integer Read FSeqReg   Write FSeqReg;

    property strBasCal: String Read FBasCal  Write setBasCal;
    property strTipGui: String Read FTipGui  Write setTipGui;
    property strCodRec: String Read FCodRec  Write setCodRec;
    property strGuiTri: String Read FGuiTri  Write FGuiTri;

    property strVeiBol: String Read FVeiBol   Write FVeiBol;
    property strVeioNF: String Read FVeioNF   Write FVeioNF;
    property strUsaCHQ: String Read FUsaCHQ   Write FUsaCHQ;
    property strDeposi: String Read FDeposi   Write FDeposi;
    property strPrevis: String Read FPrevis   Write FPrevis;
    property strPagAnt: String Read FPagAnt   Write FPagAnt;
    property strUsoCon: String Read FUsoCon   Write FUsoCon;
    property strTipDoc: String Read FTipDoc   Write FTipDoc;
    property strCompet: String Read FCompet   Write FCompet;
    property strBcoFor: String Read FBcoFor   Write FBcoFor;
    property strHist01: String Read FHist01   Write FHist01;
    property strAutInc: String Read FAutInc   Write FAutInc;

    property cdsItens:  TZClient Read FItens  Write FItens;
    property objPortadorFornecedor : TPortadorFornecedor read FPortadorFornecedor write FPortadorfornecedor;
    property TipoChamada: TTipoChamada read FTipoChamada write setTipoChamada;
    property objPgoAntecipadoGnre : TEntPagtoAntecipado Read FPgoAntecipadoGnre Write FPgoAntecipadoGnre;

  End;

Type
  {$M+}
  TListGNRE = Class(TObjectList)
  private
    blnIFCPST: Boolean;
    AOwner : TComponent;
    FQtdIns   : Integer;
    FNotifyIns: TNotifyEvent;
    FqryDados : TZClient;
    FdtsDados : TDataSource;

    strMedEmp,
    strEmpMeds: String;

    cpcParams: TParCalculaPrecoCusto;

    strForFil: String;

    blnATPVMB: array[1..7] of Boolean;

    //Paramentro da fGravaGnre
    FFrmCus,
    FNumDoc,
    FEspDoc,
    FSerie,
    FForDoc,
    FCodOpe,
    FNomForm,
    FAutIncCadFis: String;
    FImprimeCP   : Boolean;
    FDtaDoc      : TDate;
    FItensLis       : TZClient;
    strAgrupadorPreAlt: String;
    FTipoChamada    : TTipoChamada;
    FTabela : String;

    Procedure pCarregaAtpVmb;

    procedure pInserir(objGNRE : TGNRE; blnEditar: Boolean = False);
    procedure pSetQtdIns(intNewValue : Integer);
    function fAtualizaValorTodosGNRE(strNumDoc, strEspDoc, strSerie, strForDoc : String) : Boolean;
    procedure pUpdateMovTri(strAutInc : String; fltVlGnre, fltImpUlt: Double);

    procedure  pAtualizaPreco(fltPreCom: Double; strCodIte: String; strCodEmp: String);

    procedure pUpdateCadIte(strCodIte, strCodFor, strNotUlt: String;
      fltImpUlt, fltPreMed: Double; blnAtuPreCom: Boolean);

    function fGravaGnreInterna(pgbProgresso: TcxProgressBar): Boolean; overload;

    function fSQLCarregaItens(strNumDoc, strEspDoc, strSerie, strForDoc, strCodEmp: String; blnComNFE: Boolean): String;
    function fSQLCadTriConcat: String;
    function fCarregaItens(strNumDoc, strEspDoc, strSerie, strForDoc, strCodEmp: String; blnComNFE: Boolean): Boolean;
    Function fCarregaItensConFre(strNumDoc, strEspDoc, strSerie, strCodFor, strCodEmp: String; Var blnComNFE: Boolean): Boolean;
    function fTemNotaElet(strNumDoc, strEspDoc, strSerie, strForDoc, strCodEmp: String): Boolean;

    Function fEncontraGNRE(var intIndice: Integer; strOrigem: string): Boolean;
    function fCampoFCPST(blnComNFE: Boolean): String;
    procedure pGravaMemoriaDeCalculo(ADetAutInc: String; AMemCalGnr: String);

  public
    blnDeuErro: Boolean;
    procedure pLimpaLista;
    procedure pCarregaListaGnre(strAutFis : String);
    procedure pAdiciona(strCodFor : String; blnComNFE: boolean; blnDigAposEntrada: Boolean; out blnResult: Boolean);
    procedure pEdita(blnEdicao: Boolean; strOrigem: string);

    Function fExclui(strOrigem: string): Boolean;

    Function fUpdateLotePrecos(fltGnre: Double; cdsMovTri: TZClient): Boolean;

    function fGravaGnre(strNumDoc, strEspDoc, strSerie, strForDoc, strCodOpe, strNomForm: String;
                          blnImprimeCP: Boolean; dtaDtaDoc : TDate; strAutIncCadFis : String):Boolean; overload;

    Function fValidaDocumento(strNumDoc,
                              strEspDoc,
                              strSerie,
                              strCodEmp,
                              strCodFor: String;
                              var blnComNfe: Boolean;
                              blnShwMsg: Boolean = True): Boolean;

    constructor Create(Owner : TComponent; ATipoChamada : TTipoChamada); Reintroduce;
    destructor Destroy; override;

  published
    property dtsDados       : TDataSource  Read FdtsDados;
    property intQtdInsert   : Integer      Read FQtdIns;
    property OnChangeQtdIns : TNotifyEvent Read FNotifyIns Write FNotifyIns;
    property TipoChamada    : TTipoChamada Read FTipoChamada Write FTipoChamada;

  End;
  {$M-}

implementation

Uses
   untConstantes,untFuncoesSimples, untEntGnre, untGravando,
   untCalculoUltimaCompraImpostos,
   untCadCta, untMovBan, untCadPag, untFuncoes, untPcmGer, untTBanCtpRepository, untTypesSistema, untPreAlt, untFuncoesAuxiliares, untCalculoPisCofins;

constructor TGNRE.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  blnIFCPST := fCfgSis('IFCPST', varBoolean);
  FblnOcultaCamposGNRE := True;
  TipoChamada := tcGnrePadrao;
  strTipAbfCfg := fCfgSis('TIPABF');
  blnContribuinteIPI := (fCfgSis('CONIPI', varBoolean));
  blnIGNSIM := fCfgSis('IGNSIM') = '1';
  strEstEmp := fCadEmp('ESTADO');
  blnValidaPisCofins := fCfgSis('VAPICO', varBoolean);

  blnConsiderarDescontoDesonerado := fConsideraICMSDesoneradoComDesconto(strEstEmp);


  FPortadorFornecedor := TPortadorFornecedor.Create( Assigned(Owner) and (Owner.ClassName = 'TfrmEntDadosFiscaisResumo' ) );

  FGraFin := True;
  FValGnr := '';
  FExcluida := False;

  FCodPor := '';

  FItens := TZClient.Create(Self);

  FPgoAntecipadoGnre := TEntPagtoAntecipado.Create();
End;

procedure TGNRE.setI_E_S_(const Value: String);
Begin
  FI_E_S_ := Value;

//  If fEmptyStr(Value) Then
//    Raise Exception.Create('A inscrição estadual deve ser preenchida!');

  If Not fEmptyStr(Value) Then
  Begin
    If Not fValidaIES(Value, strEstFav) Then
      Raise Exception.Create('Inscrição estadual inválida!');
  End;
End;

procedure TGNRE.setEstFav(const Value: String);
Begin
  FEstFav := Value;

  If fEmptyStr(Value) Then
    Raise Exception.Create('O estado do favorecido deve ser preenchido!');
End;

procedure TGNRE.setDtaGnr(const Value: String);
  Var
    dtaDtaGnr: TDate;
Begin
  FDtaGnr := Value;

//  If fEmptyStr(Value) Then
//    Raise Exception.Create('A Data da GNRE deve ser preenchida!');

  If Not fEmptyStr(fTiraCaracEspeciais(Value)) Then
  Begin
    dtaDtaGnr := StrToDateDef(Value, 0);

    If dtaDtaGnr = 0 Then
      Raise Exception.Create('Data da ' + fGetNomeProcesso + ' inválida!');
  End;
End;

procedure TGNRE.setBcoGnr(const Value: String);
Begin
  FBcoGnr := Value;

//  If fEmptyStr(Value) Then
//    Raise Exception.Create('O banco deve ser preenchido!');

  If Not fEmptyStr(Value) Then
  Begin
    FNomBan := fRetNomeBancoSelec(FBcoGnr);

    If fEmptyStr(FNomBan) Then
      Raise Exception.Create('Código do banco não encontrado!');
  End;
End;

procedure TGNRE.setAgeGnr(const Value: String);
Begin

  FAgeGnr := Value;

//  If fEmptyStr(Value) Then
//    Raise Exception.Create('A agência deve ser preenchida!');

End;

procedure TGNRE.setValGnr(const Value: String);
Begin

  FValGnr := Value;

  If fStrToFloat(Value) <= 0 Then
    Raise Exception.Create('O valor da Guia deve ser maior que zero!');

End;

procedure TGNRE.setDtaVen(const Value: String);
  Var
    dtaDtaVen: TDate;
Begin
  FDtaVen := Value;

//  If fEmptyStr(Value) Then
//    Raise Exception.Create('A Data de vencimento GNRE deve ser preenchida!');

  If Not fEmptyStr(fTiraCaracEspeciais(Value)) Then
  Begin
    dtaDtaVen := StrToDateDef(Value, 0);

    If dtaDtaVen = 0 Then
      Raise Exception.Create('Data de vencimento inválida!');
  End;
End;

procedure TGNRE.setMesAno(const Value: String);
  Var
    dtaDtaRef: TDate;
Begin

  FMesAno := Value;

//  If fEmptyStr(Value) Then
//    Raise Exception.Create('O mês/ano de referência deve ser preenchido!');

  If Not fEmptyStr(fTiraCaracEspeciais(Value)) Then
  Begin
    dtaDtaRef := StrToDateDef('01/' + Value, 0);

    If dtaDtaRef = 0 Then
      Raise Exception.Create('Mês/ano de referência inválido!');
  End;
End;

procedure TGNRE.setConPro(const Value: String);
Begin
  FConPro := Value;

//  If fEmptyStr(Value) Then
//    Raise Exception.Create('O convênio/protocolo deve ser preenchido!');
End;

procedure TGNRE.setAutBan(const Value: String);
Begin
  FAutBan := Value;

//  If fEmptyStr(Value) Then
//    Raise Exception.Create('O autenticação bancária deve ser preenchida!');
End;

procedure TGNRE.setCodFor(const Value: String);
Begin
  FCodFor := Value;

  If fEmptyStr(Value) Then
    Raise Exception.Create('O fornecedor deve ser preenchido!');

  FNomFor := fRetNomFornecedor(Value);
  FEstFav := fCadFor('ESTADO', Value);
  FI_E_S_ := fCadFor('I_E_S_', Value);

  If fEmptyStr(FNomFor) Then
    Raise Exception.Create('Código do fornecedor não encontrado!');

  FPortadorFornecedor.strCodFor := FCodFor;
End;

procedure TGNRE.setBasCal(const Value: String);
Begin
  if fStrToFloat(Value) <= 0 Then
  Begin
    FBasCal := '0,00';
    Raise Exception.Create('O Valor da Base de Cálculo deve ser maior que Zero!');
  End
  Else
    FBasCal := Value;
End;

procedure TGNRE.setTipGui(const Value: String);
Begin
  FTipGui := Value;
End;

procedure TGNRE.setTipoChamada(const Value: TTipoChamada);
begin
  FTipoChamada := Value;
  Case FTipoChamada of
    tcGnreST,
    tcGnreTributado,
    tcGnrePadrao : Begin
                     FTabela := 'CADGNR';
                     FCampoValor := 'ENT_VALGNR';
                   End;
    tcTCIF:        Begin
                     FTabela := 'GNRTCI';
                     FCampoValor := 'ENT_VLTCIF';
                     FCampoCalculado := 'ENT_CLTCIF';
                   End;
    tcTS:          Begin
                     FTabela := 'GNR_TS';
                     FCampoValor := 'ENT_VAL_TS';
                   end;
  End;
end;

procedure TGNRE.setCodRec(const Value: String);
Begin
  FCodRec := Value;
End;

procedure TGNRE.setCodCta(const Value: String);
Begin
  FCodCta := Value;

  If fEmptyStr(Value) Then
    Raise Exception.Create('O Plano de Contas deve ser preenchido!');

  FDesCta := fRetDescCentroCusto(Value);

  If fEmptyStr(FDesCta) Then
    Raise Exception.Create('Código do Plano de Contas não foi encontrado!');

  If (Not fValidaLinhaGrupoCadCta(Value)) Then
    Raise Exception.Create('Linha / Grupo não é permitido!');

  if PlanoDeContasAtivo(Value,False) = False Then
    Raise Exception.Create('O Plano de Contas está Inativo!');

End;

destructor TGNRE.Destroy;
begin
  FreeAndNil(FPortadorFornecedor);
  FreeAndNil(qryTribut);
  FreeAndNil(FPgoAntecipadoGnre);

  If Assigned(FItens) Then
    Try
      FreeAndNil(FItens);
    Except
      {}
    End;

  inherited;
end;

function TGNRE.fAtualizaAutBancaria(blnImprimeCP : Boolean): Boolean;
  Var
    qryUpdate : TUniQuery;
    strDocKey : String;
begin
  Result := True;
  qryUpdate := fCriaQuery(self);
  With qryUpdate, SQL Do
  Begin
    Add(' UPDATE ' + FTabela  + ' SET GNR_AUTBAN = :AUTBAN WHERE AUTOINCREM = :AUTOIN ');

    ParamByName('AUTBAN').AsString := strAutBan;
    ParamByName('AUTOIN').AsString := strAutoin;
    Try
      ExecSQL;
    Except
      On E : Exception Do
      Begin
        pMensagensErro(E.Message, 'TGNRE.fAtualizaAutBancaria');
        Result := False;
      End;
    End;

  End;

  If Result And blnImprimeCP Then
  Begin
    strDocKey := IIF(fEmptyStr(strTipGui), 'GNRE', strTipGui) + fStrZero(FNumGnr, 08);
    pAdicionaImpressaoCP(strDocKey,
                         'A',
                         FCodFor,
                         '',
                         '');
  End;

end;

function TGNRE.fGetNomeProcesso: String;
begin
  Result := '';
  case FTipoChamada of
    tcGnreST,
    tcGnreTributado,
    tcGnrePadrao: Result := 'GNRE';
    tcTCIF : Result := 'TCIF';
    tcTS:    Result := 'TS';
  end;
end;

function TGNRE.fGravaCadAjustes(strAutoincrem: String): Boolean;
var
  qryGen: TUniQuery;
  strGIAINT: String;
  strGIAPRO: String;
begin
  If Not fCfgSis('AJUGIA', varBoolean) Then
    Exit(True);


  qryGen := fCriaQuery;
  Try
    FItens.First;
    strGIAINT := fCfgSis('GIAINT');
    strGIAPRO := fCfgSis('GIAPRO');

    If (strGIAINT = '') Or (strGIAPRO = '') Then
    Begin
      Result := false;
      raise Exception.Create('Quando a configuração "CFG_AJUGIA" PORTARIA CAT 54/2020 - GERAR AJUSTES SOBRE GNRE PARA SPED/GIA EFD, CONFORME PORTARIA CAT 54/2020 ' +
                             ' estiver ativa é preciso definir os ajuste nas configurações "CFG_GIAINT" e "CFG_GIAPRO"');
    End;

    qryGen.Sql.Text := 'SELECT * FROM FISAJD WHERE FALSE';
    qryGen.Open;

    FItens.First;
    While not FItens.Eof Do
    Begin
      If Not (FItens.FieldByName('ENT_COMGNR').AsString = 'S') Then
      Begin
        FItens.Next;
        Continue;
      End;

      qryGen.Insert;
      qryGen.FieldByName('AJD_ALQICM').AsFloat := FItens.FieldByName('CAL_ALQICM').AsFloat;
      qryGen.FieldByName('AJD_BASICM').AsFloat := FItens.FieldByName('CAL_BASICM').AsFloat;
      qryGen.FieldByName('AJD_CD_AJU').AsString := strGIAINT;
      qryGen.FieldByName('AJD_CODITE').AsString := FItens.FieldByName('ENT_CODITE').AsString;
      qryGen.FieldByName('AJD_DESAJU').AsString := fRetDescricaoAjuIcm(strGIAINT);
      qryGen.FieldByName('AJD_OUTROS').AsFloat := FItens.FieldByName('CAL_VLICMS').AsFloat;
      qryGen.FieldByName('AJD_VALICM').AsFloat := FItens.FieldByName('CAL_VR_SUB').AsFloat;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FISAJD', VS_StrCodEmp);
      qryGen.FieldByName('AJD_SEQGER').AsString := strAutoincrem;
      qryGen.Post;

      qryGen.Insert;
      qryGen.FieldByName('AJD_ALQICM').AsFloat := FItens.FieldByName('CAL_ALQINT').AsFloat;
      qryGen.FieldByName('AJD_BASICM').AsFloat := FItens.FieldByName('CAL_BAS_ST').AsFloat;
      qryGen.FieldByName('AJD_CD_AJU').AsString := strGIAPRO;
      qryGen.FieldByName('AJD_CODITE').AsString := FItens.FieldByName('ENT_CODITE').AsString;
      qryGen.FieldByName('AJD_DESAJU').AsString := fRetDescricaoAjuIcm(strGIAPRO);;
      qryGen.FieldByName('AJD_OUTROS').AsFloat := FItens.FieldByName('CAL_VR_IVA').AsFloat;
      qryGen.FieldByName('AJD_VALICM').AsFloat := FItens.FieldByName('CAL_VR_SUB').AsFloat;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FISAJD', VS_StrCodEmp);
      qryGen.FieldByName('AJD_SEQGER').AsString := strAutoincrem;
      qryGen.Post;

      qryGen.Insert;
      qryGen.FieldByName('AJD_ALQICM').Clear;
      qryGen.FieldByName('AJD_BASICM').Clear;
      qryGen.FieldByName('AJD_CD_AJU').AsString := 'SP41090203';
      qryGen.FieldByName('AJD_CODITE').AsString := FItens.FieldByName('ENT_CODITE').AsString;
      qryGen.FieldByName('AJD_DESAJU').AsString := fRetDescricaoAjuIcm('SP41090203');
      qryGen.FieldByName('AJD_OUTROS').Clear;
      qryGen.FieldByName('AJD_VALICM').AsFloat := FItens.FieldByName('CAL_VLICMS').AsFloat *
                                                  (FItens.FieldByName('CAL_ALQINT').AsFloat   - FItens.FieldByName('CAL_ALQICM').AsFloat) / 100;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FISAJD', VS_StrCodEmp);
      qryGen.FieldByName('AJD_SEQGER').AsString := strAutoincrem;
      qryGen.Post;

      FItens.Next;
    End;
    Result := True;
  Finally
    FreeAndNil(qryGen);
  End;

end;

Function TGNRE.fGravaCadGnr(strNumDoc, strEspDoc, strSerie, strForDoc, strAutIncCadFis: String; bGraFin: Boolean = False ): Boolean;
  Var
    qryGen: TUniQuery;
    LAutInc : String;
Begin
  Try
    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      Sql.Text := 'SELECT * FROM ' + FTabela + ' WHERE FALSE';
      Close;
      Open;

      Insert;

      LAutInc := fRetAutoIncrem(FTabela, VS_strCodEmp);
      FieldByName('AUTOINCREM').AsString   := LAutInc;
      FieldByName('GNR_CODEMP').AsString   := VS_strCodEmp;
      FieldByName('GNR_DTAENT').AsDateTime := VS_Date;

      If Not fEmptyStr(strI_E_S_) Then
        FieldByName('GNR_I_E_S_').AsString   := strI_E_S_;

      FieldByName('GNR_ESTFAV').AsString   := strEstFav;

      FieldByName('GNR_C_G_C_').AsString   := fCadEmp('C_G_C_');
      FieldByName('GNR_ESTSUB').AsString   := fCadEmp('ESTADO');


      If Not fEmptyStr(fTiraCaracEspeciais(strDtaGnr)) Then
        FieldByName('GNR_DTAGNR').AsDateTime := StrToDate(strDtaGnr);

      If Not fEmptyStr(strBcoGnr) Then
        FieldByName('GNR_BCOGNR').AsString   := strBcoGnr;

      FNumGnr := fAtualizaProCod(FTabela, 'GNR_NUMGNR');
      FieldByName('GNR_NUMGNR').AsString   := FNumGnr;
      FieldByName('GNR_VALGNR').AsFloat    := fStrToFloat(strValGnr);

      If Not fEmptyStr(fTiraCaracEspeciais(strDtaVen)) Then
        FieldByName('GNR_DTAVEN').AsDateTime := StrToDate(strDtaVen);

      If Not fEmptyStr(fTiraCaracEspeciais(strMesAno)) Then
        FieldByName('GNR_MESANO').AsString   := strMesAno;

      If Not fEmptyStr(strConPro) Then
        FieldByName('GNR_CONPRO').AsString   := strConPro;

      If Not fEmptyStr(strAgeGnr) Then
        FieldByName('GNR_AGEGNR').AsString   := strAgeGnr;

      FieldByName('GNR_CODCTA').AsString   := strCodCta;
      FieldByName('GNR_CODFOR').AsString   := strCodFor;

      If fEmptyStr(strCodEve) Then
        FieldByName('GNR_CODEVE').Clear
      Else
        FieldByName('GNR_CODEVE').AsString   := strCodEve;

      If Not fEmptyStr(strAutBan) Then
        FieldByName('GNR_AUTBAN').AsString   := strAutBan;

      FieldByName('GNR_FORDOC').AsString   := strForDoc;

      If Not fEmptyStr(strSerie) Then
        FieldByName('GNR_SERIE_').AsString := strSerie
      Else
        FieldByName('GNR_SERIE_').AsString := '';

      FieldByName('GNR_ESPDOC').AsString   := strEspDoc;
      FieldByName('GNR_NUMDOC').AsString   := strNumDoc;

      FieldByName('GNR_AUTFIS').AsString   := strAutIncCadFis;
      if fEmptyStr(strAutIncCadFis) Then
        FieldByName('GNR_AUTFIS').Clear;

      FieldByName('GNR_BASCAL').AsFloat  := fStrToFloat(strBasCal);
      If FtipoChamada = tcTCIF Then
      Begin
        qryGen.FieldByName('GNR_TIPGUI').AsString := 'GRU SIMPLES';
        FieldByName('GNR_CODREC').AsString := '20800-00';
      End
      Else If FtipoChamada =  tcTS Then
      Begin
        qryGen.FieldByName('GNR_TIPGUI').AsString := 'GRU SIMPLES';
        FieldByName('GNR_CODREC').AsString := '11113-9';
      End
      Else
      Begin
        qryGen.FieldByName('GNR_TIPGUI').AsString := IIF(Pos('GARE', strTipGui) > 0, 'GARE', strTipGui);
        FieldByName('GNR_CODREC').AsString := strCodRec;
        If fEmptyStr(strCodRec) Then
          FieldByName('GNR_CODREC').Clear;
      End;
      FieldByName('GNR_ORIGEM').AsString := 'P';
      Case FTipoChamada Of
        tcGnreST       : FieldByName('GNR_ORIGEM').AsString := 'S';
        tcGnreTributado: FieldByName('GNR_ORIGEM').AsString := 'T';
        tcGnrePadrao   : FieldByName('GNR_ORIGEM').AsString := 'P';
      End;

      FieldByName('GNR_GRAFIN').AsString := IIf(bGraFin, 'S', 'N');

      Post;

    End;

    FreeAndNil(qryGen);

    If strEspDoc <> 'PD' Then
      Result := fGravaCadAjustes(strAutIncCadFis)
    Else
      Result := True;

    If Result Then
      FAutInc := LAutInc;

  Except
    On E: Exception Do
    Begin
      Result := False;
		 	pMensagensErro(E.Message,'[fGravaCadGnr]');
    End;
  End;

End;

function TGNRE.fGravaGnre(strNumDoc, strEspDoc, strSerie, strForDoc, strCodOpe, strNomForm: String; blnImprimeCP: Boolean;
                          dtaDtaDoc : TDate; strAutIncCadFis : String; blnDelCadGnre : Boolean = True): Boolean;

  Var
    strHisBai,
    strCtaBai,
    strDocBai,
    strOpeBai,
    strDtaVct,
    strSeqLan: String;
    strParcel: Char;
    dtaDtaPag: TDate;
    fltValPag: Double;
    strHistor: String;
    strDocKey: String;
    blnGrava : Boolean;
    intCtpCon: Longint;
    lstBanCtp: TBanCtpRepository;
    intCodGui: Integer;

    fltVlPgAn : Double;
    stlPgoAnt : TStringList;
    blnGrvCtp : Boolean;
    fltValGnr : Double;
Begin
  Try
    intCodGui := 0;
    lstBanCtp := Nil;
    blnGrvCtp := True;

    fltValGnr := fStrToFloat(strValGnr);

    If (fltValGnr <= 0) Or (strCodFor = '') Then
    Begin
       Result := True;
       Exit;
    End;

    if blnDelCadGnre then
      pDeletaGnre(VS_strCodEmp, strNumDoc, strEspDoc, strCodFor, strForDoc);

    Result := fGravaCadGnr(strNumDoc, strEspDoc, strSerie, strForDoc, strAutIncCadFis, FGraFin);

    If Not Result Then
      Exit;

    //If FGraFin Then
    //Begin
      If FtipoChamada in [tcTCIF, tcTS] Then
        strDocKey := IIF(FTipoChamada = tcTCIF, 'TCIF', 'TS00') + fStrZero(FNumGnr, 08)
      Else
        strDocKey := IIF(Pos('GARE', strTipGui) > 0, 'GARE', 'GNRE') + fStrZero(FNumGnr, 08);

      If (fCfgSis('HISCTP', varBoolean)) Then
        strHistor := 'REF: NF-ENTRADA ' + strNumDoc + '-'+ strEspDoc + ', SERIE:' + strSerie + ', DE ' + FormatDateTime('dd/MM/yyyy',dtaDtaDoc) +'. '
      Else
        strHistor := '';

      strHisBai := '';
      strCtaBai := '';
      strDocBai := '';
      strOpeBai := '';
      dtaDtaPag := 0;
      fltValPag := 0;
      strSeqLan := '';

      intCtpCon := fRetCtpCon;

      If ( fCfgSis('CTPAVI', varBoolean) ) Then
      Begin
        blnGrava := False;

        If fEmptyStr(fTiraCaracEspeciais(FDtaVen)) Then
          blnGrava := True;

        If Not blnGrava Then
        Begin
          If StrToDate(FDtaVen) = VS_Date Then
            blnGrava := True;
        End;

        If blnGrava Then
        Begin
          lstBanCtp := TBanCtpRepository.Create;
          lstBanCtp.fAdd(strDocKey,
                         'A',
                         '',
                         VS_strCodEmp,
                         FCodFor,
                         strHistor,
                         '',
                         FCodCta,
                         VS_strCodEmp,
                         0,
                         fltValGnr,
                         0,
                         0,
                         0,
                         0);

          strSeqLan := fGravaMovBan(FCodCta,                            // Centro de Custo
                                    strCodPor,                          // Portador da Baixa
                                    strCodOpe,                          // Operador da Baixa
                                    VS_Date,                            // Data do Lançamento
                                    fTime(),                            // Hora do Lançamento
                                    strDocKey,                          // Numero do Documento
                                    'D',                                // Credito / Debito
                                    VS_strCodEmp,                       // Empresa da Baixa
                                    fltValGnr,                          // Valor Do Lançamento
                                    strHistor,                          // Histórico 1
                                    '',                                 // Histórico 2
                                    '',                                 // Cliente da Duplicata
                                    FCodFor,                            // Fornecedor da Duplicata
                                    strDocKey,                          // Número da Duplicata
                                    0,                                  // Sequencial de Baixa
                                    'A',                                // Parcela da Duplicata
                                    VS_strCodEmp,                       // Empresa da Duplicata
                                    '',                                 // Série
                                    FCodEve,                            // Código do Evento
                                    '',                                 // Documento da Baixa
                                    lstBanCtp.fGetList,                 // Log Bancário
                                    0,
                                    intCtpCon);

          FreeAndNil(lstBanCtp);

          Result := Not fEmptyStr(strSeqLan);

          If Not Result Then
            Exit;

          If (fCfgSis('HISCTP', varBoolean)) Then
            strHisBai := 'REF. AO DOCUMENTO No ' + strDocKey
          Else
            strHisBai := '';

          strCtaBai := FCodCta;
          strDocBai := strSeqLan;
          strOpeBai := strCodOpe;
          dtaDtaPag := VS_Date;
          fltValPag := fStrToFloat(strValGnr);

        End;

      End;

      If fEmptyStr(fTiraCaracEspeciais(FDtaVen)) Then
        strDtaVct := DateToStr(VS_Date)
      Else strDtaVct := FDtaVen;

      If fEmptyStr(fTiraCaracEspeciais(FDtaGnr)) Then
        strDtaGnr:= DateToStr(VS_Date)
      Else strDtaGnr := FDtaGnr;

      If FTipoChamada = tcTCIF Then
      Begin
        intCodGui := 11;
        FCodRec := '20800-00';
      End
      Else If FTipoChamada = tcTS Then
      Begin
        intCodGui := 11;
        FCodRec := '11113-9';
      End
      Else If FTipGui = 'GNRE' Then
        intCodGui := 7
      Else If FTipGui = 'GARE ICMS' Then
        intCodGui := 4
      Else If FTipGui = 'GARE DR' Then
        intCodGui := 5
      Else If FTipGui = 'GARE ITCMD' Then
        intCodGui := 6;

      If Not fEmptyStr(FHist01) Then
        FHist01 := FHist01 + #13#10 + strHistor;

      //MF: 318719 - 06/03/24
      If (FPgoAntecipadoGnre <> nil) Then
      Begin
        //FPagAnt := 'S';
        stlPgoAnt := TStringList.Create;
        FPgoAntecipadoGnre.pRetornaListaSelecao(stlPgoAnt, fltVlPgAn);

        If (stlPgoAnt.Count > 0) Then
        Begin
          FPgoAntecipadoGnre.fGravaPgtosAntecipados('', strNumDoc, '', fStrToFloat(strValGnr), FHist01, '', '', FAutInc, True);  //MF: 318719
          If (fltVlPgAn < fltValGnr) Then
          Begin
             fltValGnr := fltValGnr - fltVlPgAn;
          End
          Else
          Begin
            blnGrvCtp := False;
          End;
        End;


      End;

      strParcel := fNextParcelaValida(strDocKey, '', FCodFor, VS_strCodEmp);

      If (blnGrvCtp) Then
        Result := fGravaCadPag(strNomForm,                                                // Nome Form LOGCTP
                               'BAIXA ' + fGetNomeProcesso + '',                                              // Descrição LOGCTP
                               FCodFor,                                                   // Fornecedor
                               strDocKey,                                                 // Numero da Duplicata
                               strParcel,                                                       // Parcela
                               VS_strCodEmp,                                              // Empresa
                               FCodCta,                                                   // Centro de Custo
                               '',                                                        // Serie do Documento
                               0,                                                         // Sequencial de Baixa
                               StrToDate(strDtaGnr),                                      // Data do lançamento
                               StrToDate(strDtaVct),                                      // Data de Vencimento
                               fltValGnr,                                                 // Valor da Duplicata
                               fltValGnr,                                                 // Valor Original
                               IIF(fEmptyStr(FPrevis),'N',FPrevis),                       // Previsão?
                               IIf(fEmptyStr(FVeiBol),'N',FVeiBol),                       // Veio Boleto
                               IIF(fEmptyStr(FDeposi),'N',FDeposi),                       // Deposito
                               IIF(fEmptyStr(FHist01),strHistor,FHist01),                 // Histórico 1
                               '',                                                        // Histórico 2
                               strHisBai,                                                 // Histórico da Baixa
                               FCodPor,                                                   // Portador da Baixa
                               strCtaBai,                                                 // Centro de Custo da Baixa
                               strDocBai,                                                 // Documento da Baixa
                               strCodOpe,                                                 // Operador da Baixa
                               dtaDtaPag,                                                 // Data do Pagamento
                               fltValPag,                                                 // Valor Pago
                               0,                                                         // Valor de Juros
                               0,                                                         // Valor Desconto
                               VS_strCodEmp,                                              // Empresa
                               FCodEve,                                                   // Código do Evento
                               IIF(fEmptyStr(FUsaChq),'N',FUsaChq),                       // Usa Cheque
                               FCodPor,                                                   // Codigo do Portador
                               strDocKey,                                                 // Numero do Documento
                               0.0,
                               0.0,
                               intCtpCon,
                               False,
                               0,
                               IIF(fEmptyStr(FTipDoc),'2',FTipDoc),
                               0,
                               IIF(fEmptyStr(FVeioNF),'',FVeioNF),
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               IIF(fEmptyStr(FUsoCon),'N',FUsoCon),
                               FCompet,
                               '',
                               '',
                               '',
                               '',
                               fltValPag,
                               0,
                               0,
                               0,
                               '',
                               0,
                               0,
                               '',
                               '',
                               '',
                               '',
                               '',
                               IIF(fEmptyStr(FGuiTri),intCodGui.ToString,FGuiTri),
                               FCodRec,
                               FBcoFor,
                               '',
                               '',
                               IIF(fEmptyStr(FPagAnt),'N',FPagAnt));

      If Result And blnImprimeCP And blnGrvCtp Then
      Begin
        pAdicionaImpressaoCP(strDocKey,
                             strParcel,
                             FCodFor,
                             '',
                             strNomForm);
      End;

    //End;

  Except
    On E: Exception Do
    Begin
      Result := False;
		 	pMensagensErro(E.Message,'[fGravaGnre]');
    End;
  End;

End;

procedure TGNRE.pCarregaGnre(strAutoincrem: String);
  Var
    qryCadGnr : TUniQuery;
begin
  qryCadGnr := fCriaQuery(Self);
  With qryCadGnr, SQL Do
  Begin
    Clear;

    Add( ' SELECT SQL_NO_CACHE ');
    Add( '        AUTOINCREM,  ');
    Add( '        GNR_CODEMP,  ');
    Add( '        GNR_DTAENT,  ');
    Add( '        GNR_C_G_C_,  ');
    Add( '        GNR_I_E_S_,  ');
    Add( '        GNR_DTAGNR,  ');
    Add( '        GNR_ESTSUB,  ');
    Add( '        GNR_ESTFAV,  ');
    Add( '        GNR_BCOGNR,  ');
    Add( '        GNR_AGEGNR,  ');
    Add( '        GNR_NUMGNR,  ');
    Add( '        GNR_VALGNR,  ');
    Add( '        GNR_DTAVEN,  ');
    Add( '        GNR_MESANO,  ');
    Add( '        GNR_CONPRO,  ');
    Add( '        GNR_CODCTA,  ');
    Add( '        GNR_CODEVE,  ');
    Add( '        GNR_CODFOR,  ');
    Add( '        GNR_FORDOC,  ');
    Add( '        GNR_SERIE_,  ');
    Add( '        GNR_ESPDOC,  ');
    Add( '        GNR_NUMDOC,  ');
    Add( '        GNR_AUTBAN,  ');
    Add( '        GNR_AUTFIS,  ');
    Add( '        GNR_BASCAL,  ');
    Add( '        GNR_TIPGUI,  ');
    Add( '        GNR_CODREC,   ');
    Add( '        IF(GNR_GRAFIN = "","S",GNR_GRAFIN) AS GNR_GRAFIN,   ');
    If FTipoChamada in [tcGnreST, tcGnreTributado, tcGnrePadrao] Then
      Add( '        GNR_ORIGEM   ');

    Add( '  FROM ' + FTabela);
    Add( '  WHERE              ');
    Add( '  AUTOINCREM = :AUTOINCREM ');

    ParamByName('AUTOINCREM').AsString := strAutoincrem;

    Open;
    FAutoin   := strAutoincrem;
    strEstFav := FieldByName('GNR_ESTFAV').AsString;
    strI_E_S_ := FieldByName('GNR_I_E_S_').AsString;
    strDtaGnr := FieldByName('GNR_DTAGNR').AsString;
    strBcoGnr := FieldByName('GNR_BCOGNR').AsString;
    FNumGnr   := FieldByName('GNR_NUMGNR').AsString;
    strValGnr := FormatFloat('#,##0.00', FieldByName('GNR_VALGNR').AsFloat);
    strDtaVen := FieldByName('GNR_DTAVEN').AsString;
    strMesAno := FieldByName('GNR_MESANO').AsString;
    strConPro := FieldByName('GNR_CONPRO').AsString;
    strAgeGnr := FieldByName('GNR_AGEGNR').AsString;
    strCodCta := FieldByName('GNR_CODCTA').AsString;
    strCodEve := FieldByName('GNR_CODEVE').AsString;
    strCodFor := FieldByName('GNR_CODFOR').AsString;
    strAutBan := FieldByName('GNR_AUTBAN').AsString;
    strForDoc := FieldByName('GNR_FORDOC').AsString;
    strSerie  := FieldByName('GNR_SERIE_').AsString;
    strEspDoc := FieldByName('GNR_ESPDOC').AsString;
    strNumDoc := FieldByName('GNR_NUMDOC').AsString;
    strBasCal := FormatFloat('#,##0.00', FieldByName('GNR_BASCAL').AsFloat);
    strTipGui := FieldByName('GNR_TIPGUI').AsString;
    strCodRec := FieldByName('GNR_CODREC').AsString;
    If FTipoChamada in [tcGnreST, tcGnreTributado, tcGnrePadrao] Then
    Begin
      If  FieldByName('GNR_ORIGEM').AsString = 'T' Then
        FTipoChamada := tcGnreTributado
      Else If FieldByName('GNR_ORIGEM').AsString = 'S' Then
        FTipoChamada := tcGnreST
      Else If FieldByName('GNR_ORIGEM').AsString = 'P' Then
        FTipoChamada := tcGnrePadrao;
    End;
    intSeqReg := 0;

    FGraFin := FieldByName('GNR_GRAFIN').AsString = 'S';

    Close;

  End;

  FreeAndNil(qryCadGnr);

end;

procedure TGNRE.pDeletaGnre(strCodEmp, strNumDoc, strEspDoc, strCodFor, strForDoc: String);
  Var
    qryDelGnr: TUniQuery;
Begin

  Try

    qryDelGnr := fCriaQuery;

    With qryDelGnr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' DELETE FROM '+ FTabela);
      SQL.Add(' WHERE GNR_CODEMP = :CODEMP ');
      SQL.Add('   AND GNR_NUMDOC = :NUMDOC ');
      SQL.Add('   AND GNR_ESPDOC = :ESPDOC ');
      SQL.Add('   AND GNR_CODFOR = :CODFOR ');
      SQL.Add('   AND GNR_FORDOC = :FORDOC ');
      If Not (FTipoChamada In [tcTCIF, tcTS]) Then
      SQL.Add('   AND IFNULL(GNR_ORIGEM, "P") = :ORIGEM  ');

      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('FORDOC').AsString := strForDoc;
      Case FTipoChamada Of
        tcGnreST       : ParamByName('ORIGEM').AsString := 'S';
        tcGnreTributado: ParamByName('ORIGEM').AsString := 'T';
        tcGnrePadrao   : ParamByName('ORIGEM').AsString := 'P';
      End;

      ExecSQL;
      Close;
    End;

    FreeAndNil(qryDelGnr);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TGNRE.pDeletaGnre]');
    End;
  End;

end;

procedure TGNRE.pLimparTudo;
Begin
  FI_E_S_ := '';
  FEstFav := '';
  FDtaGnr := '';
  FBcoGnr := '';
  FNomBan := '';
  FAgeGnr := '';
  FValGnr := '';
  FDtaVen := '';
  FMesAno := '';
  FConPro := '';
  FAutBan := '';
  FCodFor := '';
  FNomFor := '';
  FCodCta := '';
  FDesCta := '';
  FCodEve := '';
  FNumGnr := '';
  FBasCal := '';
  FTipGui := '';
  FCodRec := '';
  FBasCal := '';
  FCodRec := '';

  FGraFin := True;
End;

Procedure TGNRE.pTelaGnre(blnComNFE: Boolean; strCodFor : String = '');
var blnOcultaCamposGNRE: Boolean;
Begin
  FblnComNFE := blnComNFE;
  If Not fVerificaItens(blnComNFE, blnOcultaCamposGNRE) Then
  Begin
    FValGnr := '0';
    Exit;
  End;

  fTelaGnre(strCodFor, False, FblnComNFE, blnOcultaCamposGNRE);
End;

procedure TGNRE.pVerificaPrevia;
begin
  If FblnComNFE And fPergunta('Durante a importação foi definida a prévia da ' + fGetNomeProcesso + ', porém ela ainda não foi informada, Deseja informar a ' + fGetNomeProcesso + '?') Then
  Begin
    pTelaGnre(True, fCfgSis('FORGNE'));
    fAtualizaValorGnre;
  End;
end;

function TGNRE.fTelaGnre(strCodFor : String = ''; blnEdita : Boolean = False; blnComNFE: Boolean = False; blnOcultaCamposGNRE: Boolean = True; blnDigAposEntrada: Boolean = False): Boolean;
var fltBasCal: Double;
begin
  If (blnEdita Or blnDigAposEntrada) Then
  begin
    If fCfgSis('URSTCL', varBoolean) Then
    Begin

      If fVErificaSeTemCTE_E_Pergunta_Se_DesejaRecalcularValorGNRE(False) Then
      Begin
        blnOcultaCamposGNRE := False;
        FItens.First;
        While not FItens.eof do
        begin
          If (FItens.FieldByName('ENT_CALSTU').AsInteger > 0)Then
          Begin
            pRecalculaGNRE(blnEdita);
          End;
          FItens.Next;
        End;
        FItens.First;
      End;
    End;
  End;

  pCriarFormularios(TfrmEntGNRE, frmEntGNRE);

  frmEntGNRE.fraCtaPagar.InicializaObjetoFrameContaPagar;
 // frmEntGNRE.fraCtaPagar.objFrameCtaPagar.pCarregaGuiasETributos(False,'7_4_5_6');

  frmEntGNRE.TipoChamada := FTipoChamada;

  frmEntGNRE.cxgItensVLRCALGNR.Visible := Not blnOcultaCamposGNRE;
  frmEntGNRE.cxgItensVALSTNF.Visible := Not blnOcultaCamposGNRE;
  frmEntGNRE.cxgItensPERBAS_ST.Visible := Not blnOcultaCamposGNRE;
  frmEntGNRE.cxgItensVLRCTE.Visible := Not blnOcultaCamposGNRE;
  frmEntGNRE.cxgItensVLRPRO.Visible := Not blnOcultaCamposGNRE;
//  frmEntGNRE.cxgItensVFCPST.Visible := Not blnOcultaCamposGNRE;

  If fEmptyStr(Self.strCodFor) And (Not fEmptyStr(strCodFor)) Then
  Begin
    Self.strCodFor := strCodFor;
    Self.strEstFav := fCadFor('ESTADO', strCodFor );
    Self.strI_E_S_ := fCadFor('I_E_S_', strCodFor );
  End;
  If fEmptyStr(strCodCta) And (fCfgSis('GNRPLC') <> '')Then
    Self.strCodCta := fCfgSis('GNRPLC');

  If fEmptyStr(Self.strCodRec) And (fCfgSis('GNRCRF') <> '') Then
  begin
    If frmEntGNRE.dtsTipoTributo.DataSet.Locate('TRI_CODTRI', fCfgSis('GNRCRF'), []) Then
    Begin
      frmEntGNRE.fraCtaPagar.LcbGuiaTributo.KeyValue := frmEntGNRE.dtsTipoTributo.DataSet.FieldByName('GUI_CODGUI').AsInteger;
      frmEntGNRE.fraCtaPagar.objFrameCtaPagar.pChamaEventoSairComponenteGuiaTributo;
      frmEntGNRE.fraCtaPagar.LcbTipoTributo.KeyValue := fCfgSis('GNRCRF');
    End;
  End
  Else
  Begin

    If Not fEmptyStr(Self.strGuiTri) Then
    Begin
      frmEntGNRE.fraCtaPagar.LcbGuiaTributo.KeyValue := Self.strGuiTri;
      frmEntGNRE.fraCtaPagar.objFrameCtaPagar.pChamaEventoSairComponenteGuiaTributo;
    End;

    If Not fEmptyStr(Self.strCodRec) Then
      frmEntGNRE.fraCtaPagar.LcbTipoTributo.KeyValue := Self.strCodRec;
  End;

  If Self.TipoChamada in [tcGnreST, tcGnreTributado, tcGnrePadrao] Then
  Begin
    If fEmptyStr(Self.strCodEve) And (fCfgSis('GNREVE') <> '')Then
      Self.strCodEve:= fCfgSis('GNREVE');

    If fEmptyStr(Self.strDtaGnr) Then
      Self.strDtaGnr := DateToStr(fNow);

    If fEmptyStr(Self.strDtaVen) Then
      Self.strDtaVen := DateToStr(fNow);

    If fEmptyStr(Self.strMesAno) Then
      Self.strMesAno:= FormatDateTime('mm/yyyy', fNow);

    fltBasCal := 0;
    If Not blnEdita Then
      fltBasCal := fRetTotalBasSTCalculado;

    If fEmptyStr(Self.strBasCal) And  (fltBasCal > 0) Then
      strBasCal := FormatFloat('#,##0.00', fltBasCal);

  End;

  Self.FblnComNFE := blnComNFE;

  frmEntGNRE.objGnre := Self;
  frmEntGNRE.blnEditando := blnEdita;
  Result := (frmEntGNRE.ShowModal = mrOk);
  PFreeAndNil(frmEntGNRE);

End;

Function TGNRE.fTemItensSelecionados: Boolean;
Begin
  Result := True;
  If Not FItens.Locate('ENT_COMGNR', 'S', []) Then
  Begin
    Result := False;
    pMensagemOk('Selecione os itens que terão ' + fGetNomeProcesso + '!')
  End;
End;

Function TGNRE.fVerificaItens(blnComNFE: Boolean; var blnOcultaCamposGNRE: Boolean): Boolean;
Begin
  FblnComNFE := blnComNFE;

  Result := False;

  If Assigned(FItens) Then
    FreeAndNil(FItens);
  FItens := TZClient.Create(Self);

  With FItens.qryQuery Do
  Begin
    FItens.qryQuery.SQL.Text := fSQLItens(blnComNFE);

    If (blnComNFE) Or (FTipoChamada = tcGnreTributado) Then
      ParamByName('TRIBUT').AsString := CST_TRIBUTADO + fRetCST_CONCST('CST_TRIBUTADO');

    If FTipoChamada in [tcGnreST, tcGnrePadrao] Then
    begin
      ParamByName('SUBSTI').AsString := CST_SUBSTITUICAO  + fRetCST_CONCST('CST_SUBSTITUICAO');
      If FblnComNFE Then
        ParamByName('TRIBUT').AsString := CST_TRIBUTADO  + fRetCST_CONCST('CST_TRIBUTADO');
    End;

    ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
  End;

  If FItens.fAbreClient(True, 'TGNRE.fVerificaItens') Then
  Begin

    Result := FItens.RecordCount > 0;

    If Not Result Then
    Begin
      If blnComNFE Then
        pMensagemOk('Não há itens cadastrados com substituição tributária no estado da' + #13#10 +
                    'empresa que estejam tributados (CST X00 ou X20) ou tenham substituição' + #13#10 +
                    'tributária na nota eletrônica (XML)!')
      Else
        pMensagemOk('Não há itens cadastrados com substituição tributária no estado da' + #13#10 +
                    'empresa!')
    End
    Else
    Begin
      blnOcultaCamposGNRE := True;
      If TipoChamada in [tcGnreST, tcGnreTributado, tcGnrePadrao] Then
      Begin
        If fCfgSis('URSTCL', varBoolean) Then
        Begin

          If fVErificaSeTemCTE_E_Pergunta_Se_DesejaRecalcularValorGNRE Then
          Begin
            blnOcultaCamposGNRE := False;
            FItens.First;
            While not FItens.eof do
            begin
              If (FItens.FieldByName('ENT_CALSTU').AsInteger > 0)Then
              Begin
                pRecalculaGNRE;
              End;
              FItens.Next;
            End;
            FItens.First;
          End;
        End;
      End;
    End;
  End;
End;

function TGNRE.fVErificaSeTemCTE_E_Pergunta_Se_DesejaRecalcularValorGNRE(blnPergunta: Boolean = True):Boolean;
var blnTemFreteComCte: Boolean;
begin
  FItens.First;
  blnTemFreteComCte := False;
  While not FItens.eof do
  begin

     If (FItens.FieldByName('ENT_FRECON').AsFloat > 0) Then
     begin
       blnTemFreteComCte := true;
       Break;
     End;
     FItens.Next;
  End;

  If blnTemFreteComCte And blnPergunta Then
    Result := fPergunta('Foi encontrado CTE, Recalcular o valor da GNRE?')
  Else
    Result := blnTemFreteComCte


End;

Function TGNRE.fSQLTributacao: string;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   A.* ';
  Result := Result + ' FROM ';
  Result := Result + '   ABFICM A ';

  If strTipAbfCfg = '1' Then
  Begin
    Result := Result + ' INNER JOIN CADITE ON ITE_CODITE = :CODITE ';
  End Else
  Begin
    Result := Result + ' INNER JOIN ITEGER ON ITE_CODITE = :CODITE AND ';
    Result := Result + '                      ITE_CODEMP = "' + VS_StrCodemp + '"';
  End;

  Result := Result + ' WHERE ';
  Result := Result + '   ABF_CODABF = ITE_CODABF AND ';
  Result := Result + '   ABF_ESTADO = :ESTADO ';

End;

Function TGNRE.fCarregaTributacao(strCodIte, strEstFor: String): Boolean;
Begin
  If Not Assigned(qryTribut) Then
    qryTribut := fCriaQuery(Self);

  With qryTribut Do
  Begin
    SQL.Text := fSQLTributacao;
    Close;
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('ESTADO').AsString := strEstFor;
    Open;

    Result := (Not IsEmpty) And (Not fEmptyStr(strEstFor));
  End;

End;

Function TGNRE.fDescontoXML(recGerEle: TRecGerEle; recDetCal: TRecDetEle): Double;
Begin
  With recDetCal, recGerEle Do
  If blnConsiderarDescontoDesonerado Then
    Result := I17_VDESC + IIF((W07_VPROD + W18_VSERV + W06_VST + W08_VFRETE + W09_VSEG +
              W12_VIPI + W15_VOUTRO + N23D_FCPST - W10_VDESC) - W16_VNF > 0.5  , N27A_VICMSDESON, 0)
              {W12_VIPI + W15_VOUTRO + N23D_FCPST - W10_VDESC) - W16_VNF > 0.5  , N27A_VICMSDESON, 0) + N23D_FCPST //req 303332 }
  Else
    Result := I17_VDESC;
End;

function TGNRE.fCarregaGerEle(strAutInc: String):TRecGerEle;
var qryGerEle: TUniQuery;
Begin
  qryGerEle := fCriaQuery;
  Try
    qryGerEle.SQL.Add('SELECT * FROM GERELE WHERE AUTOINCREM = "'+strAutInc+'"');
    qryGerEle.Open;
    Result.GER_CODEMP := ShortString(qryGerEle.FieldByName('GER_CODEMP').AsString);
    Result.GER_CODFOR := ShortString(qryGerEle.FieldByName('GER_CODFOR').AsString);
    Result.GER_CODCLI := ShortString(qryGerEle.FieldByName('GER_CODCLI').AsString);
    Result.E02_CNPJ   := ShortString(qryGerEle.FieldByName('E02_CNPJ').AsString);
    Result.E17_IE     := ShortString(qryGerEle.FieldByName('E17_IE').AsString);

    Result.GER_CONPAG := ShortString(qryGerEle.FieldByName('GER_CONPAG').AsString);

    Result.B02_CUF             := ShortString(qryGerEle.FieldByName('B02_CUF').AsString);
    Result.B03_CNF             := ShortString(qryGerEle.FieldByName('B03_CNF').AsString);
    Result.B04_NATOP           := ShortString(qryGerEle.FieldByName('B04_NATOP').AsString);
    Result.B05_INDPAG          := ShortString(qryGerEle.FieldByName('B05_INDPAG').AsString);
    Result.B06_MOD             := ShortString(qryGerEle.FieldByName('B06_MOD').AsString);
    Result.B07_SERIE           := ShortString(qryGerEle.FieldByName('B07_SERIE').AsString);
    Result.B08_NNF             := ShortString(qryGerEle.FieldByName('B08_NNF').AsString);
    Result.B09_DEMI            := qryGerEle.FieldByName('B09_DEMI').AsDateTime;
    Result.B10_DSAIENT         := qryGerEle.FieldByName('B10_DSAIENT').AsDateTime;
    Result.B11_TPNF            := ShortString(qryGerEle.FieldByName('B11_TPNF').AsString);
    Result.B12_CMUNFG          := ShortString(qryGerEle.FieldByName('B12_CMUNFG').AsString);
    Result.B21_TPIMP           := ShortString(qryGerEle.FieldByName('B21_TPIMP').AsString);
    Result.B22_TPEMIS          := ShortString(qryGerEle.FieldByName('B22_TPEMIS').AsString);
    Result.B24_TPAMB           := ShortString(qryGerEle.FieldByName('B24_TPAMB').AsString);
    Result.B25_FINNFE          := ShortString(qryGerEle.FieldByName('B25_FINNFE').AsString);
    Result.B25B_INDPRES        := qryGerEle.FieldByName('B25B_INDPRES').AsInteger;
    Result.B26_PROCEMI         := ShortString(qryGerEle.FieldByName('B26_PROCEMI').AsString);
    Result.C02_CNPJ            := ShortString(qryGerEle.FieldByName('C02_CNPJ').AsString);
    Result.C02A_CPF            := ShortString(qryGerEle.FieldByName('C02A_CPF').AsString);
    Result.C03_XNOME           := ShortString(qryGerEle.FieldByName('C03_XNOME').AsString);
    Result.C04_XFANT           := ShortString(qryGerEle.FieldByName('C04_XFANT').AsString);
    Result.C03_XLGR            := ShortString(qryGerEle.FieldByName('C03_XLGR').AsString);
    Result.C07_NRO             := ShortString(qryGerEle.FieldByName('C07_NRO').AsString);
    Result.C08_XCPL            := ShortString(qryGerEle.FieldByName('C08_XCPL').AsString);
    Result.C09_XBAIRRO         := ShortString(qryGerEle.FieldByName('C09_XBAIRRO').AsString);
    Result.C10_CMUN            := ShortString(qryGerEle.FieldByName('C10_CMUN').AsString);
    Result.C11_XMUN            := ShortString(qryGerEle.FieldByName('C11_XMUN').AsString);
    Result.C12_UF              := ShortString(qryGerEle.FieldByName('C12_UF').AsString);
    Result.C13_CEP             := ShortString(qryGerEle.FieldByName('C13_CEP').AsString);
    Result.C14_CPAIS           := ShortString(qryGerEle.FieldByName('C14_CPAIS').AsString);
    Result.C15_XPAIS           := ShortString(qryGerEle.FieldByName('C15_XPAIS').AsString);
    Result.C16_FONE            := ShortString(qryGerEle.FieldByName('C16_FONE').AsString);
    Result.C17_IE              := ShortString(qryGerEle.FieldByName('C17_IE').AsString);
    Result.C18_IEST            := ShortString(qryGerEle.FieldByName('C18_IEST').AsString);
    Result.C19_IM              := ShortString(qryGerEle.FieldByName('C19_IM').AsString);
    Result.C20_CNAE            := ShortString(qryGerEle.FieldByName('C20_CNAE').AsString);
    Result.W03_VBC             := qryGerEle.FieldByName('W03_VBC').AsFloat;
    Result.W04_VICMS           := qryGerEle.FieldByName('W04_VICMS').AsFloat;
    Result.W04A_VICMSDESON     := qryGerEle.FieldByName('W04A_VICMSDESON').AsFloat;
    Result.W04H_VFCP           := qryGerEle.FieldByName('W04H_VFCP').AsFloat;
    Result.W05_VBCST           := qryGerEle.FieldByName('W05_VBCST').AsFloat;
    Result.W06_VST             := qryGerEle.FieldByName('W06_VST').AsFloat;
    Result.W06A_VFCPST         := qryGerEle.FieldByName('W06A_VFCPST').AsFloat;
    Result.W07_VPROD           := qryGerEle.FieldByName('W07_VPROD').AsFloat;
    Result.W08_VFRETE          := qryGerEle.FieldByName('W08_VFRETE').AsFloat;
    Result.W09_VSEG            := qryGerEle.FieldByName('W09_VSEG').AsFloat;
    Result.W10_VDESC           := qryGerEle.FieldByName('W10_VDESC').AsFloat;
    Result.W11_VII             := qryGerEle.FieldByName('W11_VII').AsFloat;
    Result.W12_VIPI            := qryGerEle.FieldByName('W12_VIPI').AsFloat;
    Result.W13_VPIS            := qryGerEle.FieldByName('W13_VPIS').AsFloat;
    Result.W14_VCOFINS         := qryGerEle.FieldByName('W14_VCOFINS').AsFloat;
    Result.W15_VOUTRO          := qryGerEle.FieldByName('W15_VOUTRO').AsFloat;
    Result.W16_VNF             := qryGerEle.FieldByName('W16_VNF').AsFloat;
    Result.W15_VSERV           := qryGerEle.FieldByName('W15_VSERV').AsFloat;

    Result.W18_VSERV           := qryGerEle.FieldByName('W18_VSERV').AsFloat;
    Result.W19_VBC             := qryGerEle.FieldByName('W19_VBC').AsFloat;
    Result.W20_VISS            := qryGerEle.FieldByName('W20_VISS').AsFloat;
    Result.W21_VPIS            := qryGerEle.FieldByName('W21_VPIS').AsFloat;
    Result.W22_VCOFINS         := qryGerEle.FieldByName('W22_VCOFINS').AsFloat;
    Result.W22A_DCOMPET        := qryGerEle.FieldByName('W22A_DCOMPET').AsFloat;
    Result.W22B_VDEDUCAO       := qryGerEle.FieldByName('W22B_VDEDUCAO').AsFloat;
    Result.W22D_VDESCINCOND    := qryGerEle.FieldByName('W22D_VDESCINCOND').AsFloat;

    Result.W24_VRETPIS         := qryGerEle.FieldByName('W24_VRETPIS').AsFloat;
    Result.W25_VRETCOFINS      := qryGerEle.FieldByName('W25_VRETCOFINS').AsFloat;
    Result.W26_VRETCSLL        := qryGerEle.FieldByName('W26_VRETCSLL').AsFloat;
    Result.W27_VBCIRRF         := qryGerEle.FieldByName('W27_VBCIRRF').AsFloat;
    Result.W28_VIRRF           := qryGerEle.FieldByName('W28_VIRRF').AsFloat;
    Result.W29_VBCRETPREV      := qryGerEle.FieldByName('W29_VBCRETPREV').AsFloat;
    Result.W30_VRETPREV        := qryGerEle.FieldByName('W30_VRETPREV').AsFloat;
    Result.PR07_CHNFE          := qryGerEle.FieldByName('PR07_CHNFE').AsString;
    Result.X27_QVOL            := qryGerEle.FieldByName('X27_QVOL').AsFloat;
    Result.X28_ESP             := qryGerEle.FieldByName('X28_ESP').AsString;
    Result.X31_PESOL           := qryGerEle.FieldByName('X31_PESOL').AsFloat;
    Result.X32_PESOB           := qryGerEle.FieldByName('X32_PESOB').AsFloat;
    Result.X33_MODFRETE        := qryGerEle.FieldByName('X33_MODFRETE').AsString;
    Result.X34_CNPJ            := qryGerEle.FieldByName('X34_CNPJ').AsString;
  Finally
    FreeAndNil(qryGerEle);
  End;

End;

function TGNRE.fCarregaDetEle(strAutInc: String):TRecDetEle;
  var qryDetEle: TUniQuery;
Begin
  qryDetEle := fCriaQuery;
  Try
    qryDetEle.SQL.Add('SELECT * FROM DETELE WHERE AUTOINCREM = "'+strAutInc+'"');
    qryDetEle.Open;

    Result.I02_NITEM := qryDetEle.FieldByName('I02_NITEM').AsString;
    Result.DET_CODITE := ShortString(qryDetEle.FieldByName('DET_CODITE').AsString);
    Result.DET_CSTXML := ShortString(qryDetEle.FieldByName('DET_CSTXML').AsString);

    Result.N11_ORIG := ShortString(qryDetEle.FieldByName('N11_ORIG').AsString);
    Result.N12_CST := ShortString(qryDetEle.FieldByName('N12_CST').AsString);
    Result.N12_CSOSN := ShortString(qryDetEle.FieldByName('N12_CSOSN').AsString);
    Result.N13_MODBC := ShortString(qryDetEle.FieldByName('N13_MODBC').AsString);
    Result.N14_PREDBC := qryDetEle.FieldByName('N14_PREDBC').AsFloat;
    Result.N15_VBC := qryDetEle.FieldByName('N15_VBC').AsFloat;
    Result.N16_PICMS := qryDetEle.FieldByName('N16_PICMS').AsFloat;
    Result.N17_VICMS := qryDetEle.FieldByName('N17_VICMS').AsFloat;
    Result.N18_MODBCST := ShortString(qryDetEle.FieldByName('N18_MODBCST').AsString);
    Result.N19_PMVAST := qryDetEle.FieldByName('N19_PMVAST').AsFloat;
    Result.N20_PREBCST := qryDetEle.FieldByName('N20_PREBCST').AsFloat;
    Result.N21_VBCST := qryDetEle.FieldByName('N21_VBCST').AsFloat;
    Result.N22_PICMSST := qryDetEle.FieldByName('N22_PICMSST').AsFloat;
    Result.N23_VICMSST := qryDetEle.FieldByName('N23_VICMSST').AsFloat;
    Result.N23A_VBCFCPST := qryDetEle.FieldByName('N23A_VBCFCPST').AsFloat;
    Result.N23B_PFCPST := qryDetEle.FieldByName('N23B_PFCPST').AsFloat;
    Result.N23D_FCPST := qryDetEle.FieldByName('N23D_FCPST').AsFloat;
    Result.N17A_VBCFCP := qryDetEle.FieldByName('N17A_VBCFCP').AsFloat;
    Result.N17B_PFCP := qryDetEle.FieldByName('N17B_PFCP').AsFloat;
    Result.N17C_VFCP := qryDetEle.FieldByName('N17C_VFCP').AsFloat;
    Result.N24_CREDSN := qryDetEle.FieldByName('N24_CREDSN').AsFloat;
    Result.N24_CREDICMSSN := qryDetEle.FieldByName('N24_CREDICMSSN').AsFloat;
    Result.N27A_VICMSDESON := qryDetEle.FieldByName('N27A_VICMSDESON').AsFloat;
    Result.N27A_MOTDESICMS := ShortString(qryDetEle.FieldByName('N27A_MOTDESICMS').AsString);
    Result.I02_CPROD := ShortString(qryDetEle.FieldByName('I02_CPROD').AsString);
    Result.I03_CEAN := ShortString(qryDetEle.FieldByName('I03_CEAN').AsString);
    Result.I04_XPROD := ShortString(qryDetEle.FieldByName('I04_XPROD').AsString);
    Result.I05_NCM := ShortString(qryDetEle.FieldByName('I05_NCM').AsString);
    Result.I70_NFCI := ShortString(qryDetEle.FieldByName('I70_NFCI').AsString);
    Result.I06_EXTIPI := ShortString(qryDetEle.FieldByName('I06_EXTIPI').AsString);
    Result.I07_GENERO := ShortString(qryDetEle.FieldByName('I07_GENERO').AsString);
    Result.I08_CFOP := ShortString(qryDetEle.FieldByName('I08_CFOP').AsString);
    Result.I09_UCOM := ShortString(qryDetEle.FieldByName('I09_UCOM').AsString);
    Result.I10_QCOM := qryDetEle.FieldByName('I10_QCOM').AsFloat;
    Result.I10A_VUNCOM := qryDetEle.FieldByName('I10A_VUNCOM').AsFloat;
    Result.I11_VPROD := qryDetEle.FieldByName('I11_VPROD').AsFloat;
    Result.I12_CEANTRIB := ShortString(qryDetEle.FieldByName('I12_CEANTRIB').AsString);
    Result.I13_UTRIB := ShortString(qryDetEle.FieldByName('I13_UTRIB').AsString);
    Result.I14_QTRIB := qryDetEle.FieldByName('I14_QTRIB').AsFloat;
    Result.I14A_VUNTRIB := qryDetEle.FieldByName('I14A_VUNTRIB').AsFloat;
    Result.I15_VFRETE := qryDetEle.FieldByName('I15_VFRETE').AsFloat;
    Result.I16_VSEG := qryDetEle.FieldByName('I16_VSEG').AsFloat;
    Result.I17_VDESC := qryDetEle.FieldByName('I17_VDESC').AsFloat;
    Result.I17A_VOUTRO := qryDetEle.FieldByName('I17A_VOUTRO').AsFloat;
    Result.O02_CLENQ := ShortString(qryDetEle.FieldByName('O02_CLENQ').AsString);
    Result.O07_IPITRIB := ShortString(qryDetEle.FieldByName('O07_IPITRIB').AsString);
    Result.O09_CST := ShortString(qryDetEle.FieldByName('O09_CST').AsString);
    Result.O10_VBC := qryDetEle.FieldByName('O10_VBC').AsFloat;
    Result.O11_QUNID := qryDetEle.FieldByName('O11_QUNID').AsFloat;
    Result.O12_VUNID := qryDetEle.FieldByName('O12_VUNID').AsFloat;
    Result.O13_PIPI := qryDetEle.FieldByName('O13_PIPI').AsFloat;
    Result.O14_VIPI := qryDetEle.FieldByName('O14_VIPI').AsFloat;
    Result.Q06_CST := ShortString(qryDetEle.FieldByName('Q06_CST').AsString);
    Result.Q07_VBC := qryDetEle.FieldByName('Q07_VBC').AsFloat;
    Result.Q08_PPIS := qryDetEle.FieldByName('Q08_PPIS').AsFloat;
    Result.Q09_VPIS := qryDetEle.FieldByName('Q09_VPIS').AsFloat;
    Result.Q10_QBCPROD := qryDetEle.FieldByName('Q10_QBCPROD').AsFloat;
    Result.Q11_VALIQPROD := qryDetEle.FieldByName('Q11_VALIQPROD').AsFloat;
    Result.S06_CST := ShortString(qryDetEle.FieldByName('S06_CST').AsString);
    Result.S07_VBC := qryDetEle.FieldByName('S07_VBC').AsFloat;
    Result.S08_PCOFINS := qryDetEle.FieldByName('S08_PCOFINS').AsFloat;
    Result.S11_VCOFINS := qryDetEle.FieldByName('S11_VCOFINS').AsFloat;
    Result.S09_QBCPROD := qryDetEle.FieldByName('S09_QBCPROD').AsFloat;
    Result.S10_VALIQPROD := qryDetEle.FieldByName('S10_VALIQPROD').AsFloat;
    Result.S11_VCOFINS := qryDetEle.FieldByName('S11_VCOFINS').AsFloat;
    Result.U02_VBC := qryDetEle.FieldByName('U02_VBC').AsFloat;
    Result.U03_VALIQ := qryDetEle.FieldByName('U03_VALIQ').AsFloat;
    Result.U04_VISSQN := qryDetEle.FieldByName('U04_VISSQN').AsFloat;
    Result.U05_CMUNFG := ShortString(qryDetEle.FieldByName('U05_CMUNFG').AsString);
    Result.U06_CLISTSERV := ShortString(qryDetEle.FieldByName('U06_CLISTSERV').AsString);
    Result.U07_VDEDUCAO := qryDetEle.FieldByName('U07_VDEDUCAO').AsFloat;
    Result.U09_VDESCINCOND := qryDetEle.FieldByName('U09_VDESCINCOND').AsFloat;
    Result.U12_INDSS := ShortString(qryDetEle.FieldByName('U12_INDSS').AsString);
    Result.U14_CMUN := ShortString(qryDetEle.FieldByName('U14_CMUN').AsString);
    Result.U15_CPAIS := ShortString(qryDetEle.FieldByName('U15_CPAIS').AsString);
    Result.U17_INDINCENTIVO := ShortString(qryDetEle.FieldByName('U17_INDINCENTIVO').AsString);
    Result.P04_VII := qryDetEle.FieldByName('P04_VII').AsFloat;
    Result.I23B_VAFRMM := qryDetEle.FieldByName('I23B_VAFRMM').AsFloat;
    Result.P03_VDESPADU := qryDetEle.FieldByName('P03_VDESPADU').AsFloat;
    Result.DET_VALIMP := qryDetEle.FieldByName('DET_VALIMP').AsFloat;
    Result.DET_VALSIS := qryDetEle.FieldByName('DET_VALSIS').AsFloat;
    Result.DET_BASSUB := qryDetEle.FieldByName('DET_BASSUB').AsFloat;
    Result.DET_CODMCO := qryDetEle.FieldByName('DET_CODMCO').AsString;
    Result.XPED := qryDetEle.FieldByName('XPED').AsString;
    Result.NITEMPED := qryDetEle.FieldByName('NITEMPED').AsString;
    Result.N26_VBCSTRET := qryDetEle.FieldByName('N26_VBCSTRET').AsFloat;
    Result.N27_VICMSSTRET := qryDetEle.FieldByName('N27_VICMSSTRET').AsFloat;
    Result.N27_vICMSSubstituto := qryDetEle.FieldByName('N27_vICMSSubstituto').AsFloat;
    Result.N34_PREDBCEEFET := qryDetEle.FieldByName('N34_PREDBCEEFET').AsFloat;
    Result.N35_VBCEFET := qryDetEle.FieldByName('N35_VBCEFET').AsFloat;
    Result.N36_PICMSEFET := qryDetEle.FieldByName('N36_PICMSEFET').AsFloat;
    Result.N37_VICMSEFET := qryDetEle.FieldByName('N37_VICMSEFET').AsFloat;
    Result.N24_VBCUFDEST := qryDetEle.FieldByName('N24_VBCUFDEST').AsFloat;
    Result.N24_VBCFCPUFDEST := qryDetEle.FieldByName('N24_VBCFCPUFDEST').AsFloat;
    Result.N24_PFCPUFDEST := qryDetEle.FieldByName('N24_PFCPUFDEST').AsFloat;
    Result.N24_PICMSUFDEST := qryDetEle.FieldByName('N24_PICMSUFDEST').AsFloat;
    Result.N24_PICMSINTER := qryDetEle.FieldByName('N24_PICMSINTER').AsFloat;
    Result.N24_PICMSINTERPART := qryDetEle.FieldByName('N24_PICMSINTERPART').AsFloat;
    Result.N24_VFCPUFDEST := qryDetEle.FieldByName('N24_VFCPUFDEST').AsFloat;
    Result.N24_VICMSUFDEST := qryDetEle.FieldByName('N24_VICMSUFDEST').AsFloat;
    Result.N24_VICMSUFREMET := qryDetEle.FieldByName('N24_VICMSUFREMET').AsFloat;
    Result.CAL_VLICMS := qryDetEle.FieldByName('CAL_VLICMS').AsFloat;
    Result.CAL_BASICM := qryDetEle.FieldByName('CAL_BASICM').AsFloat;
    Result.CAL_ALQICM := qryDetEle.FieldByName('CAL_ALQICM').AsFloat;
    Result.CAL_BAS_ST := qryDetEle.FieldByName('CAL_BAS_ST').AsFloat;
    Result.CAL_VR_IVA := qryDetEle.FieldByName('CAL_VR_IVA').AsFloat;
    Result.CAL_VR_SUB := qryDetEle.FieldByName('CAL_VR_SUB').AsFloat;
    Result.CAL_ALQINT := qryDetEle.FieldByName('CAL_ALQINT').AsFloat;
    Result.CAL_VFCPST := qryDetEle.FieldByName('CAL_VFCPST').AsFloat;
    Result.DET_CALSTU := qryDetEle.FieldByName('DET_CALSTU').AsInteger;
    Result.strMemCalGNRE := qryDetEle.FieldByName('DET_CALGNR').AsString;
  Finally
    FreeAndNil(qryDetEle);
  End;

End;

function TGNRE.fTipoCalculoBaseST(strCodFor: String): TCalculoBaseSubstituicaoXML;
Begin
  If fEmptyStr(strCodFor) Then
    Exit(tcbsIPIComProdutos);

  If fCampoTabela('FOR_BSTXML', 'CADFOR', ['FOR_CODFOR'], [strCodFor]) = 1 Then
    Result := tcbsProdutosSemIPI
  Else
    Result := tcbsIPIComProdutos;
End;



procedure TGNRE.pRecalculaGNRE(blnAlteracao: Boolean = False);
  Var
    strClaFis,
    strCodFis,
    strEstFor,
    strCodAbf: String;
    fltVlrProd,
    fltBasIcm,
    fltAlqIcm,
    fltAlqIcmRed,
    fltValIcm,
    fltPerBas,
    fltPeBaST,
    fltABF_IVA_ST,
    fltValipi,
    fltFreCon,
    fltAliFCP: Double;

    fltAliSte: Double;
    blnRedCargaMedia: Boolean;
    fltAliSteCargaMedia: Double;
    recDetCal : TRecDetEle;
    qryCadFor: TUniQuery;
    blnFreTri,
    blnFreTIp: Boolean;
    recGerEle: TRecGerEle;
    recDetEle: TRecDetEle;
    fltRedAliCargaMediaEmp: Double;
    CalculoBaseSubstituicaoXML: TCalculoBaseSubstituicaoXML;
Begin
  blnFreTri := fCfgSis('FRETRI', varBoolean);
  blnFreTIp := fCfgSis('FRETIP', varBoolean);


  If fEmptyStr(FItens.FieldByName('ENT_DETEL2').AsString) Then
    Exit;


  recGerEle := fCarregaGerEle(FItens.FieldByName('ENT_AUTELE').AsString);
  recDetEle := fCarregaDetEle(FItens.FieldByName('ENT_DETEL2').AsString);

  recDetCal := recDetEle;
  With recDetCal Do
  Begin
    N11_ORIG    := '';
    N12_CST     := '';
    N12_CSOSN   := '';
    N19_PMVAST  := 0;

    N15_VBC     := 0;
    N16_PICMS   := 0;
    N17_VICMS   := 0;

    N21_VBCST                     := 0;
    N21_VBCST_IPIComDesconto      := 0;
    N21_VBCST_Produto             := 0;
    N21_VBCST_Produto_ComDesconto := 0;
    N21_VBCST_Produto_ComIPI      := 0;

    DET_BASSUB                      := 0;
    N23_VICMSST                     := 0;
    N23_VICMSST_IPIComDesconto      := 0;
    N23_VICMSST_Produto             := 0;
    N23_VICMSST_Produto_ComDesconto := 0;
    N23_VICMSST_Produto_ComIPI      := 0;

    O10_VBC     := 0;
    O13_PIPI    := 0;
    O14_VIPI    := 0;
    O14_VIPI_ComDesconto := 0;

    fltRedAliCargaMediaEmp := 0;
    fltFreCon :=0;
    If fCfgSis('URSTCL', varBoolean, VS_StrCodEmp) Then
    begin
      fltRedAliCargaMediaEmp := fRetReducaoAliquotaCargaMediaEmpresa(VS_StrCodEmp);
      If blnFreTri Then
        fltFreCon := FItens.FieldByName('ENT_FRECON').AsFloat
    End;


    qryCadFor := fCarregaDadosFornecedor(FItens.FieldByName('ENT_CODFOR').AsString);
    Try

      strEstFor  := qryCadFor.FieldByName('ESTFOR').AsString;

      strCodAbf := '';

      fltValipi := 0;
      If  (qryCadFor.FieldByName('SOMIPI').AsString = 'S') Then
      begin
        fltBasIPI   := I11_VPROD + I17A_VOUTRO + I16_VSEG;

        If blnFreTIp Then
          fltBasIPI := fltBasIPI + I15_VFRETE;

        If qryCadFor.FieldByName('MATREV').AsString = 'I' Then
          O13_PIPI    := fCampoTabela('ITE_IPIENT', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [DET_CODITE, recGerEle.GER_CODEMP])
        Else
          O13_PIPI    := 0;

        fltValipi   := RoundTo(fltBasIPI * (O13_PIPI / 100), -2);
      end;
      fltVlrProd := I11_VPROD + fltValipi - fDescontoXML(recGerEle, recDetCal) + I15_VFRETE + I17A_VOUTRO + I16_VSEG;
      If fCarregaTributacao(String(DET_CODITE), strEstFor) And
         fRetornaDadosFiscais(strEstEmp,
                              blnContribuinteIPI,
                              False,
                              IIF(Not fEmptyStr(strCodAbf), strCodAbf, qryTribut.FieldByName('ABF_CODABF').AsString) ,
                              I11_VPROD + fltValipi - fDescontoXML(recGerEle, recDetCal) + I15_VFRETE + I17A_VOUTRO + I16_VSEG  + fltFreCon,
                              fRetornaAlqFor(strEstFor, qryCadFor.FieldByName('I_E_S_').AsString, strEstEmp),
                              strEstFor,
                              FItens.FieldByName('ENT_CODFOR').AsString,
                              fItemRevInd(String(DET_CODITE), String(recGerEle.GER_CODEMP)) = 'R',
                              strClaFis,
                              strCodFis,
                              fltBasIcm,
                              fltAlqIcm,
                              fltAlqIcmRed,
                              fltValIcm,
                              fltPerBas,
                              fltPeBaST,
                              fltAliSte,
                              fltAliFCP,
                              blnRedCargaMedia,
                              False,
                              True,
                              false,
                              false,
                              false,
                              string(recDetCal.I08_CFOP),
                              false,
                              false,
                              nil,
                              False,
                              False) Then

      Begin
        fValorTabelaCFOPEntrada(String(recDetEle.I08_CFOP),  String(recDetEle.N12_CST), fRetTipoProduto(string(recDetCal.DET_CODITE)), strClaFis);
        I08_CFOP := ShortString(strClaFis);

        N11_ORIG    := ShortString(LeftStr(strCodFis, 1));
        N12_CST     := ShortString(RightStr(strCodFis, 2));
        fltAliSteCargaMedia := fltAliSte;
        If blnRedCargaMedia Then
          fltAliSteCargaMedia := fltAliSte * (( 100 - fltRedAliCargaMediaEmp )/100);

        DET_CSTXML  := ShortString(strCodFis);

        fCarregaTributacao(String(DET_CODITE), strEstFor);

        fltABF_IVA_ST := qryTribut.FieldByName('ABF_IVA_ST' + strTipAbf).AsFloat;

        N19_PMVAST  := (fltABF_IVA_ST - 1) * 100;

        O10_VBC     := I11_VPROD - fDescontoXML(recGerEle, recDetCal) + I17A_VOUTRO + I16_VSEG;

        fltBasIPI   := I11_VPROD + I17A_VOUTRO + I16_VSEG;

        fltBasIPI_ComDesconto := fltBasIPI - fDescontoXML(recGerEle, recDetCal);

        If blnFreTri Then
          recDetCal.O10_VBC   := O10_VBC + recDetCal.I15_VFRETE + FItens.FieldByName('ENT_FRECON').AsFloat;

        If blnFreTIp Then
        Begin
          fltBasIPI := fltBasIPI + I15_VFRETE + FItens.FieldByName('ENT_FRECON').AsFloat;
          fltBasIPI_ComDesconto := fltBasIPI_ComDesconto + I15_VFRETE + FItens.FieldByName('ENT_FRECON').AsFloat;
        End;

        If (qryCadFor.FieldByName('MATREV').AsString = 'I') Or (qryCadFor.FieldByName('SOMIPI').AsString = 'T')  Then
          O13_PIPI    := fCampoTabela('ITE_IPIENT', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [DET_CODITE, recGerEle.GER_CODEMP])
        Else
          O13_PIPI    := 0;

        O14_VIPI    := RoundTo(fltBasIPI * (O13_PIPI / 100), -2);

        O14_VIPI_ComDesconto := RoundTo(fltBasIPI_ComDesconto * (O13_PIPI / 100), -2);

        CAL_ALQINT :=  fltAliSte;

        If Pos(strCodFis, CST_SUBSTITUICAO + fRetCST_CONCST('CST_SUBSTITUICAO') ) > 0 Then
        Begin
          CalculoBaseSubstituicaoXML := fTipoCalculoBaseST(string(recGerEle.GER_CODFOR));


          If CalculoBaseSubstituicaoXML = tcbsProdutosSemIPI Then
            N21_VBCST_IPIComDesconto   := fFormataFloat(((((O10_VBC * fltPeBaST) / 100) + O14_VIPI_ComDesconto) * fltABF_IVA_ST), 2)
          Else
            recDetCal.N21_VBCST_IPIComDesconto   := fFormataFloat(((((recDetCal.O14_VIPI_ComDesconto + recDetCal.O10_VBC) * fltPeBaST) / 100) * fltABF_IVA_ST), 2);
          recDetCal.N23_VICMSST := fRetornaValRet(strEstEmp, N21_VBCST_IPIComDesconto, fltValIcm, fltAliSte);
          recDetCal.N23_VFCPST_IPIComDesconto_GARE := fRetornaValFCPRet(recDetCal.N21_VBCST_IPIComDesconto, fltAliFCP);
          recDetCal.N23_VICMSST_IPIComDesconto_GARE := fRetornaValRet(strEstEmp, recDetCal.N21_VBCST_IPIComDesconto, fltValIcm, fltAliSteCargaMedia);


          Case IntToTipoCalculoSTGareImportacaoXML(FItens.FieldByName('ENT_CALSTU').AsInteger) of
            tcsgiPadrao: Begin
                           If CalculoBaseSubstituicaoXML = tcbsProdutosSemIPI Then
                             recDetCal.N21_VBCST   := fFormataFloat(((((recDetCal.O10_VBC * fltPeBaST) / 100) + recDetCal.O14_VIPI) * fltABF_IVA_ST), 2)
                           Else
                             recDetCal.N21_VBCST   := fFormataFloat(((((recDetCal.O14_VIPI + recDetCal.O10_VBC) * fltPeBaST) / 100) * fltABF_IVA_ST), 2);
                            N23_VICMSST := fRetornaValRet(strEstEmp, N21_VBCST, fltValIcm, fltAliSte);
                            recDetCal.N23_VFCPST_GARE := fRetornaValFCPRet(recDetCal.N21_VBCST, fltAliFCP);
                            recDetCal.N23_VICMSST_GARE := fRetornaValRet(strEstEmp, recDetCal.N21_VBCST, fltValIcm, fltAliSteCargaMedia);
                            recDetCal.strMemCalGNRE :=
                                     'Valor GNRE = Vr. Subst. Sistema = ((Base Calc. ICMS ST(' + FormatFloat('#,##0.00', recDetCal.N21_VBCST) + ') ' +
                                   ' * Alíq. ST(' + FormatFloat('#,##0.00', fltAliSteCargaMedia) + ') ' +
                                   ' ) ) / 100) - Valor ICMS(' + FormatFloat('#,##0.00', fltValIcm) +
                                   ') )  - Vr. Subst XML (' + FormatFloat('#,##0.00', recDetEle.N23_VICMSST) + ')';
                         End;
            tcsgiProduto: Begin
                            N21_VBCST_Produto   := fFormataFloat(((((O10_VBC + fDescontoXML(recGerEle, recDetCal)) * fltPeBaST) / 100) * fltABF_IVA_ST), 2);
                            N23_VICMSST := fRetornaValRet(strEstEmp, N21_VBCST_Produto, fltValIcm, fltAliSte);
                            recDetCal.N23_VFCPST_GARE := fRetornaValFCPRet(N21_VBCST_IPIComDesconto, fltAliFCP);
                            recDetCal.N23_VICMSST_GARE := fRetornaValRet(strEstEmp, N21_VBCST_IPIComDesconto, fltValIcm, fltAliSteCargaMedia);
                            recDetCal.strMemCalGNRE :=
                                      'Valor GNRE = Vr. Subst. Sistema = ((Base Calc. ICMS ST IPI com Desconto = ' +
                                    '((Valor Total Produto(' + FormatFloat('#,##0.00', O10_VBC) + ') + Desconto XML(' + FormatFloat('#,##0.00', fDescontoXML(recGerEle, recDetCal)) + ')) ' +
                                    ' * Perc. Redução ST(' + FormatFloat('#,##0.00', fltPeBaST) + ') / 100) ' +
                                    ' * IVA ST(' + FormatFloat('#,##0.00', fltABF_IVA_ST) + ') )) = ' +
                                    FormatFloat('#,##0.00', N21_VBCST_IPIComDesconto) + ' ' +
                                    '=> Valor ICMS ST = ((Base(' + FormatFloat('#,##0.00', N21_VBCST_IPIComDesconto) + ') * Alíq. ST(' + FormatFloat('#,##0.00', fltAliSteCargaMedia) + ') ) / 100) ' +
                                    '- Valor ICMS Próprio(' + FormatFloat('#,##0.00', fltValIcm) + ') ' +
                                    '- Valor XML (' + FormatFloat('#,##0.00', recDetEle.N23_VICMSST) + ')';
                          End;
            tcsgiProduto_ComDesconto: Begin
                                        N21_VBCST_Produto_ComDesconto   := fFormataFloat(((((O10_VBC) * fltPeBaST) / 100) *  fltABF_IVA_ST), 2);
                                        N23_VICMSST := fRetornaValRet(strEstEmp, N21_VBCST_Produto_ComDesconto, fltValIcm, fltAliSte);
                                        recDetCal.N23_VFCPST_GARE := fRetornaValFCPRet(N21_VBCST_IPIComDesconto, fltAliFCP);
                                        recDetCal.N23_VICMSST_GARE := fRetornaValRet(strEstEmp, N21_VBCST_IPIComDesconto, fltValIcm, fltAliSteCargaMedia);
                                        recDetCal.strMemCalGNRE :=
                                            'Valor GNRE = Vr. Subst. Sistema = ((Base Calc. ICMS ST Produto com Desconto = ' +
                                            '((Valor Total Produto(' + FormatFloat('#,##0.00', O10_VBC) + ') * Perc. Redução ST(' + FormatFloat('#,##0.00', fltPeBaST) + ') / 100) ' +
                                            ' * IVA ST(' + FormatFloat('#,##0.00', fltABF_IVA_ST) + ') )) = ' +
                                            FormatFloat('#,##0.00', N21_VBCST_Produto_ComDesconto) + ' ' +
                                            '=> Valor ICMS ST = ((Base(' + FormatFloat('#,##0.00', N21_VBCST_IPIComDesconto) + ') * Alíq. ST(' + FormatFloat('#,##0.00', fltAliSteCargaMedia) + ') ) / 100) ' +
                                            '- Valor ICMS Próprio(' + FormatFloat('#,##0.00', fltValIcm) + ') ' +
                                            '- Valor XML (' + FormatFloat('#,##0.00', recDetEle.N23_VICMSST) + ')';
                                      End;

            tcsgiProduto_ComIPI:Begin
                                  If CalculoBaseSubstituicaoXML = tcbsProdutosSemIPI Then
                                    N21_VBCST_Produto_ComIPI   := fFormataFloat((((((O10_VBC + fDescontoXML(recGerEle, recDetCal)) * fltPeBaST) / 100) + O14_VIPI) * fltABF_IVA_ST), 2)
                                  Else
                                    recDetCal.N21_VBCST_Produto_ComIPI   := fFormataFloat(((((O14_VIPI + O10_VBC + fDescontoXML(recGerEle, recDetCal)) * fltPeBaST) / 100) * fltABF_IVA_ST), 2);
                                  N23_VICMSST := fRetornaValRet(strEstEmp, N21_VBCST_Produto_ComIPI, fltValIcm, fltAliSte);
                                  recDetCal.N23_VFCPST_GARE := fRetornaValFCPRet(recDetCal.N21_VBCST_IPIComDesconto, fltAliFCP);
                                  recDetCal.N23_VICMSST_GARE := fRetornaValRet(strEstEmp, recDetCal.N21_VBCST_IPIComDesconto, fltValIcm, fltAliSteCargaMedia);
                                  recDetCal.strMemCalGNRE :=
                                          'Valor GNRE = Vr. Subst. Sistema = ((Base Calc. ICMS ST Produto com IPI = ';
                                  If CalculoBaseSubstituicaoXML = tcbsProdutosSemIPI Then
                                    recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE +
                                          //'(Se tipo de base for "Produto sem IPI", então: ' +
                                          '((Valor Total Produto(' + FormatFloat('#,##0.00', O10_VBC) + ') + Desconto XML(' + FormatFloat('#,##0.00', fDescontoXML(recGerEle, recDetCal)) + ') ' +
                                          ') * Perc. Redução ST(' + FormatFloat('#,##0.00', fltPeBaST) + ') / 100) + Valor IPI(' + FormatFloat('#,##0.00', O14_VIPI) + ') ' +
                                          ') * IVA ST(' + FormatFloat('#,##0.00', fltABF_IVA_ST) + ') '
                                  Else
                                    recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE +
                                          //'| Se tipo de base for "Produto com IPI", então: ' +
                                          '((Valor Total Produto(' + FormatFloat('#,##0.00', O10_VBC) + ') + Desconto XML(' + FormatFloat('#,##0.00', fDescontoXML(recGerEle, recDetCal)) + ') + Valor IPI(' + FormatFloat('#,##0.00', O14_VIPI) + ') ' +
                                          ') * Perc. Redução ST(' + FormatFloat('#,##0.00', fltPeBaST) + ') / 100) * IVA ST(' + FormatFloat('#,##0.00', fltABF_IVA_ST) + ') )) = ' +
                                          FormatFloat('#,##0.00', N21_VBCST_Produto_ComIPI) + ' ';

                                  recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE +
                                          '=> Valor ICMS ST = ((Base(' + FormatFloat('#,##0.00', recDetCal.N21_VBCST_IPIComDesconto) + ') * Alíq. ST(' + FormatFloat('#,##0.00', fltAliSteCargaMedia) + ') ) / 100) ' +
                                          '- Valor ICMS Próprio(' + FormatFloat('#,##0.00', fltValIcm) + ') ' +
                                          '- Valor XML (' + FormatFloat('#,##0.00', recDetEle.N23_VICMSST) + ')';
                                End;

            tcsgiIPIComDesconto:Begin
                                  If CalculoBaseSubstituicaoXML = tcbsProdutosSemIPI Then
                                    N21_VBCST_IPIComDesconto   := fFormataFloat(((((O10_VBC * fltPeBaST) / 100) + O14_VIPI_ComDesconto) * fltABF_IVA_ST), 2)
                                  Else
                                    N21_VBCST_IPIComDesconto   := fFormataFloat(((((O14_VIPI_ComDesconto + O10_VBC) * fltPeBaST) / 100) * fltABF_IVA_ST), 2);
                                  N23_VICMSST := fRetornaValRet(strEstEmp, N23_VICMSST_IPIComDesconto, fltValIcm, fltAliSte);
                                  recDetCal.N23_VFCPST_GARE := fRetornaValFCPRet(N21_VBCST_IPIComDesconto, fltAliFCP);
                                  recDetCal.N23_VICMSST_GARE := fRetornaValRet(strEstEmp, N21_VBCST_IPIComDesconto, fltValIcm, fltAliSteCargaMedia);
                                  recDetCal.strMemCalGNRE :=
                                        'Valor GNRE = Vr. Subst. Sistema = ((Base Calc. ICMS ST com IPI e Desconto = ';

                                  If CalculoBaseSubstituicaoXML = tcbsProdutosSemIPI Then
                                    recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE +
                                        //'(Se tipo de base for "Produto sem IPI", então: ' +
                                        '((Valor Total Produto(' + FormatFloat('#,##0.00', O10_VBC) + ') ' +
                                        'x Perc. Redução ST(' + FormatFloat('#,##0.00', fltPeBaST) + ') / 100) + Valor IPI com Desconto(' + FormatFloat('#,##0.00', O14_VIPI_ComDesconto) + ') ' +
                                        ') * IVA ST(' + FormatFloat('#,##0.00', fltABF_IVA_ST) + ')'
                                   Else
                                     recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE +
                                        //'| Se tipo de base for "Produto com IPI", então: ' +
                                        '((Valor Total Produto(' + FormatFloat('#,##0.00', O10_VBC) + ') + Valor IPI com Desconto(' + FormatFloat('#,##0.00', O14_VIPI_ComDesconto) + ') ' +
                                        ') * Perc. Redução ST(' + FormatFloat('#,##0.00', fltPeBaST) + ') / 100) * IVA ST(' + FormatFloat('#,##0.00', fltABF_IVA_ST) + ') )) = ' +
                                        FormatFloat('#,##0.00', N21_VBCST_IPIComDesconto) + ' ';
                                   recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE +
                                        '=> Valor ICMS ST = ((Base(' + FormatFloat('#,##0.00', N21_VBCST_IPIComDesconto) + ') * Alíq. ST(' + FormatFloat('#,##0.00', fltAliSteCargaMedia) + ') ) / 100) ' +
                                        '- Valor ICMS Próprio(' + FormatFloat('#,##0.00', fltValIcm) + ') ' +
                                        '- Valor Subst. XML (' + FormatFloat('#,##0.00', recDetEle.N23_VICMSST) + ')';
                                End;
          End;
          FItens.Edit;
          If Not blnAlteracao Then
            FItens.FieldByName('ENT_VALGNR').AsFloat := RoundTo(recDetCal.N23_VICMSST_GARE, -2) - RoundTo(recDetEle.N23_VICMSST, -2);
          If blnIFCPST Then
          Begin
            FItens.FieldByName('ENT_VALGNR').AsFloat := FItens.FieldByName('ENT_VALGNR').AsFloat +
              RoundTo(recDetCal.N23_VFCPST_GARE, -2)-
              RoundTo(recDetEle.N23D_FCPST, -2);
            recDetCal.strMemCalGNRE := recDetCal.strMemCalGNRE +
                              ' + (FCP (' + FormatFloat('#,##0.00', recDetCal.N23_VFCPST_GARE) + ' - ' +
                                            FormatFloat('#,##0.00', recDetEle.N23D_FCPST) + '))';
          End;
          If FItens.FieldByName('ENT_VALGNR').AsFloat < 0 Then
            FItens.FieldByName('ENT_VALGNR').AsFloat := 0;
          FItens.FieldByName('ENT_CALGNR').AsString := recDetCal.strMemCalGNRE;
          If (Not fEmptyStr(FItens.FieldByName('ENT_CALGNR').AsString)) And (FItens.FieldByName('ENT_CALGNR').AsString <> MSG_VLR_GNR_MANUAL) Then
            FItens.FieldByName('ENT_CALGNR').AsString := FItens.FieldByName('ENT_CALGNR').AsString + ' = ' + FormatFloat('#,##0.00',FItens.FieldByName('ENT_VALGNR').AsFloat);
          FItens.FieldByName('VLRPROD').AsFloat := fltVlrProd;
          FItens.FieldByName('ALQBASST').AsFloat := fltPeBaST;
          FItens.FieldByName('CAL_VR_IVA').AsFloat := fltABF_IVA_ST;
          FItens.FieldByName('CAL_BAS_ST').AsFloat := N21_VBCST_IPIComDesconto;
          FItens.FieldByName('CAL_ALQINT').AsFloat := fltAliSteCargaMedia;
          FItens.FieldByName('CAL_BASICM').AsFloat := fltBasIcm;
          FItens.FieldByName('CAL_ALQICM').AsFloat := fltAlqIcm;
          FItens.FieldByName('CAL_VLICMS').AsFloat := fltValIcm;
          FItens.FieldByName('CAL_VR_SUB').AsFloat := recDetCal.N23_VICMSST_GARE;
          FItens.FieldByName('CAL_VFCPST').AsFloat := recDetCal.N23_VFCPST_GARE;
          FItens.FieldByName('VLSTNF').AsFloat := recDetEle.N23_VICMSST;
          FItens.FieldByName('VFCPST').AsFloat := recDetEle.N23D_FCPST;
          FItens.FieldByName('VLRCALGNR').AsFloat := FItens.FieldByName('ENT_VALGNR').AsFloat;

          FItens.Post;

        End;
      End;
    Finally
      FreeAndNil(qryCadFor);
    End;
  End;
End;


Function TGNRE.fCarregaDadosFornecedor(strCodFor: String): TUniQuery;
Begin
  Result := fCriaQuery;
  Result.SQL.Text := TNFeXml.fSQLDadosFornec;
  Result.ParamByName('CODFOR').AsString := strCodFor;
  Result.Open;


  strTipAbf := fGetTipoAbf('F',
                           Result.FieldByName('FISJUR').AsString,
                           Result.FieldByName('I_E_S_').AsString,
                           '', '', '', '',
                           Result.FieldByName('SIMPAU').AsString,
                           Result.FieldByName('MATREV').AsString,
                           '',
                           '');


End;

Function TGNRE.fSQLItens(blnComNFE: Boolean): String;
  Var
    strSQL, strPerfil: String;
Begin
  FblnComNFE := blnComNFE;
  strSQL := ' SELECT  ';

  strSQL := strSQL + '   T.AUTOINCREM, ';
  strSQL := strSQL + '   T.ENT_AUTELE, ';
  strSQL := strSQL + '   T.ENT_DETEL2, ';
  strSQL := strSQL + '   T.ENT_DETELE, ';
  strSQL := strSQL + '   ENT_CODITE,   ';
  strSQL := strSQL + '   ENT_CODFAB,   ';
  strSQL := strSQL + '   ENT_DESITE,   ';
  strSQL := strSQL + '   ENT_REFERE,   ';
  strSQL := strSQL + '   UNI_SIGUNI AS ENT_SIGUNI, ';
  strSQL := strSQL + '   ENT_CODABF,   ';
  strSQL := strSQL + '   ENT_CODFIS,   ';
  strSQL := strSQL + '   ENT_CODFOR,   ';
  strSQL := strSQL + '   ENT_TOTITE,   ';
  strSQL := strSQL + '   0.0000 AS VLRPROD,  ';
  strSQL := strSQL + '   0.0000 AS ALQBASST, ';
  strSQL := strSQL + '   0.0000 AS VLSTNF, ';
  strSQL := strSQL + '   ENT_VFCPST AS VFCPST, ';
  strSQL := strSQL + '   0.0000 AS VLRCALGNR, ';
  strSQL := strSQL + '   ENT_CALGNR, ';

  If TipoChamada = tcGnreTributado Then
    strSQL := strSQL + ' IFNULL(ENT_TOTITE, 0) + IFNULL(ENT_VALIPI, 0) AS BASCAL, ';
  If TipoChamada in [tcGnreST, tcGnreTributado, tcGnrePadrao] Then
  Begin
    strSQL := strSQL + ' CAL_BASICM, ';
    strSQL := strSQL + ' CAL_VLICMS, ';
    strSQL := strSQL + ' CAL_ALQICM, ';
    strSQL := strSQL + ' CAL_VR_IVA, ';
    strSQL := strSQL + ' CAL_BAS_ST, ';
    strSQL := strSQL + ' CAL_VR_SUB, ';
    strSQL := strSQL + ' CAL_ALQINT, ';
    strSQL := strSQL + ' CAL_VFCPST, ';
    strSQL := strSQL + ' ENT_CALSTU, ';
    strSQL := strSQL + ' ENT_FRECON, ';
  End;
  If TipoChamada = tcTCIF Then
    strSQL := strSQL + '   IF(' + FCampoValor + ' > 0, ' + FCampoValor + ',  ' + FCampoCalculado + ') AS ' + FCampoValor + ', '
  Else If TipoChamada = tcTS Then
    strSQL := strSQL + '   ' + FCampoValor + ' , '
  Else If TipoChamada = tcGnreTributado Then
    strSQL := strSQL + '   IF(ENT_VALGNR > 0, ENT_VALGNR,  ENT_VALADB) AS ENT_VALGNR, '
  Else
    strSQL := strSQL + '   IF(ENT_VALGNR > 0, ENT_VALGNR,  ENT_VLRGNR) AS ENT_VALGNR, ';
  If blnComNFE Then
  Begin
    strSQL := strSQL + '  IF(LOCATE(ENT_SITXML, :TRIBUT) > 0 OR TRI_GERGNR IS NOT NULL, "S", IFNULL(ENT_COMGNR, "N")) AS ENT_COMGNR, ';
    strSQL := strSQL + '  IF(LOCATE(ENT_SITXML, :TRIBUT) > 0 OR TRI_GERGNR IS NOT NULL, "S", "N") AS ENT_GNRFIX  ';
  End Else
  Begin
    strSQL := strSQL + '  IFNULL(ENT_COMGNR, "S") AS ENT_COMGNR, ';
    strSQL := strSQL + '  "N" AS ENT_GNRFIX    ';
  End;

  strSQL := strSQL + ' FROM TMP_ENTMER T ';

  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = ENT_CODUNI ';
  strSQL := strSQL + ' LEFT JOIN CADTRI ON TRI_CODTRI = ENT_SITXML AND TRI_GERGNR = "S"  ';

  If TipoChamada IN [tcTCIF, tcTS] Then
  Begin
    strSQL := strSQL + ' INNER JOIN CADITE ON ITE_CODITE = ENT_CODITE ';
    strSQL := strSQL + ' LEFT JOIN CADNCM ON ITE_EXCIPI = NCM_CODEXC AND ITE_CLAIPI = NCM_CODNCM ';
  End;

  strSQL := strSQL + ' LEFT JOIN ABFICM ON ABF_CODABF = ENT_CODABF AND ';
  strSQL := strSQL + '                      ABF_ESTADO = :ESTADO    AND ';

  strPerfil :=  fGetTipoAbfFornecedor(FForDoc);

  If fEmptyStr(FForDoc) Then
    strPerfil := '_ENT_PEJ';

  If FTipoChamada = tcGnreTributado Then
    strSQL := strSQL + '                      LOCATE(ABF_CODSIT' + strPerfil + ', :TRIBUT) > 0'
  Else
    strSQL := strSQL + '                      LOCATE(ABF_CODSIT' + strPerfil + ', :SUBSTI) > 0';
  
  strSQL := strSQL + ' WHERE TRUE';
  If Not (FTipoChamada in [tcTCIF, tcTS]) Then
  Begin
    If FTipoChamada = tcGnreTributado Then
      strSQL := strSQL + ' AND ENT_ITETRI = "S" ';

    If blnComNFE Then
    Begin
      Case FTipoChamada Of
        tcGnreTributado : strSQL := strSQL + ' AND (LOCATE(ENT_SITXML, :TRIBUT) > 0) ';
        tcTCIF,
        tcTS : strSQL := strSQL + ' AND (LOCATE(ENT_SITXML, :SUBSTI) > 0) ';
        tcGnreST,        
      tcGnrePadrao    : Begin
                          strSQL := strSQL + ' AND ';
                          strSQL := strSQL + '  ((LOCATE(ENT_SITXML, :TRIBUT) > 0) OR ';
                          strSQL := strSQL + '   (LOCATE(ENT_SITXML, :SUBSTI) > 0) OR (TRI_GERGNR IS NOT NULL) ';

                          If fCfgSis('GNRX90') = 'S' Then
                            strSQL := strSQL + '  OR (LOCATE(ENT_SITXML, ' + QuotedStr(CST_ANTECIPACAO_ICMS + fRetCST_CONCST('CST_ANTECIPACAO_ICMS')) + ') > 0) ';

                            strSQL := strSQL + ')    ';
                          End;
      End;

    End;
    If (not (FTipoChamada in [tcGnreTributado, tcTCIF, tcTS])) Then
      strSQL := strSQL + ' AND ((ABF_CODABF IS NOT NULL) OR LOCATE(ENT_CODFIS, ' + QuotedStr(CST_ANTECIPACAO_ICMS + fRetCST_CONCST('CST_ANTECIPACAO_ICMS')) + ') > 0)';
  End
  Else If (FTipoChamada = tcTS) Then
      strSQL := strSQL + ' AND NCM_ALQIPI > 0 ';
  Result := strSQL;
End;

function TGNRE.fAtualizaValorGnre:Boolean;
  Var
    qryGenMer: TUniQuery;
    LValMemCal: Double;
begin
  Result := True;
  Try
    qryGenMer  := fCriaQuery;
    Try
      If Not (FTipoChamada in [tcTCIF, tcTS]) Then
      begin
        FItens.Filter   := 'ENT_COMGNR = ' + QuotedStr('S');
        FItens.Filtered := True;
        FItens.First;
        If FItens.IsEmpty Then
          Exit;
      End;

      qryGenMer.Close;
      qryGenMer.SQL.Add(' UPDATE TMP_ENTMER SET      ');
      qryGenMer.SQL.Add('   ' + FCampoValor + ' = :VALGNR,    ');

      If FTipoChamada = tcTCIF Then
        qryGenMer.SQL.Add('  ENT_ALQTCI =  (:VALGNR * 100)/ ENT_VLRCON, ');
      If FTipoChamada = tcTS Then
        qryGenMer.SQL.Add('  ENT_ALQ_TS =  (:VALGNR * 100)/ ENT_VLRCON, ');

      qryGenMer.SQL.Add('  ENT_GNRORI = :GNRORI,    ');
      qryGenMer.SQL.Add('  ENT_CALGNR = :CALGNR     ');

      qryGenMer.SQL.Add(' WHERE AUTOINCREM = :AUTINC ');

      While Not FItens.Eof Do
      Begin
        case FTipoChamada of
          tcGnreST : qryGenMer.ParamByName('GNRORI').AsString := 'S';
          tcGnreTributado : qryGenMer.ParamByName('GNRORI').AsString := 'T';
          tcGnrePadrao : qryGenMer.ParamByName('GNRORI').AsString := 'P';
        End;

        LValMemCal := fExtrairValorMemCalcGNRE(FItens.FieldByName('ENT_CALGNR').AsString);

        If FItens.FieldByName(FCampoValor).AsFloat = 0 Then
           qryGenMer.ParamByName('GNRORI').AsString := 'P';

        qryGenMer.ParamByName('VALGNR').AsFloat := FItens.FieldByName(FCampoValor).AsFloat;

        If (LValMemCal = FItens.FieldByName(FCampoValor).AsFloat) Then
          qryGenMer.ParamByName('CALGNR').AsString := FItens.FieldByName('ENT_CALGNR').AsString
        Else
          qryGenMer.ParamByName('CALGNR').AsString := MSG_VLR_GNR_MANUAL;

        qryGenMer.ParamByName('AUTINC').AsString := FItens.FieldByName('AUTOINCREM').AsString;
        qryGenMer.ExecSQL;
        FItens.Next;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[fAtualizaValorGnre]');
      End;
    End;
  Finally
    FreeAndNil(qryGenMer);
  end;
  FItens.Filtered := False;
end;

function TGNRE.fRateiaGnre:Boolean;
  Var
    intNumReg,
    intQtdReg: Integer;
    fltTotIte,
    fltGnrRes: Double;
begin
  Result := True;
  If FTipoChamada In [tcTCIF, tcTS] Then
    Exit;

  Try
    If FItens.IsEmpty Then
      Exit;

    With FItens Do
    Begin
      Filter   := 'ENT_COMGNR = ' + QuotedStr('S');
      Filtered := True;
      First;

      fltTotIte    := 0;

      While Not Eof Do
      Begin
        fltTotIte := fltTotIte + FieldByName('ENT_TOTITE').AsFloat;
        Next;
      End;

      First;
    End;

    intNumReg := 0;
    intQtdReg := FItens.RecordCount;
    fltGnrRes := fStrToFloat(FValGnr);

    While Not FItens.Eof Do
    Begin
      inc(intNumReg);
      FItens.Edit;
      If fStrToFloat(FValGnr) = 0 Then
        FItens.FieldByName('ENT_VALGNR').AsFloat := 0
      Else If intNumReg = intQtdReg Then
        FItens.FieldByName('ENT_VALGNR').AsFloat := fltGnrRes
      Else
      Begin
        If fltTotIte > 0 Then
          FItens.FieldByName('ENT_VALGNR').AsFloat := RoundTo(FItens.FieldByName('ENT_TOTITE').AsFloat * (fStrToFloat(FValGnr) / fltTotIte), -2)
        Else
          FItens.FieldByName('ENT_VALGNR').AsFloat := 0;

        fltGnrRes := fltGnrRes - FItens.FieldByName('ENT_VALGNR').AsFloat;
      End;

      if FItens.FieldByName('ENT_VALGNR').AsFloat < 0 Then
        Result := False;

      FItens.Post;
      FItens.Next;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[fRateiaGnre]');
    End;
  End;

  FItens.Filtered := False;
end;

function TGNRE.fRateiaTS: Boolean;
  Var
    intNumReg,
    intQtdReg: Integer;
    fltTotIte,
    fltRepresentacao,
    fltGnrRes: Double;
begin
  Result := True;

  Try
    FItens.First;

    intNumReg := 0;
    intQtdReg := FItens.RecordCount;
    fltGnrRes := fStrToFloat(FValGnr);
    fltTotIte := 0;
    While not FItens.Eof Do
    Begin
      fltTotIte := fltTotIte + FItens.FieldByName('ENT_TOTITE').AsFloat;
      FItens.Next;
    End;

    FItens.First;
    While Not FItens.Eof Do
    Begin
      inc(intNumReg);
      FItens.Edit;
      If fStrToFloat(FValGnr) = 0 Then
        FItens.FieldByName('ENT_VAL_TS').AsFloat := 0
      Else If intNumReg = intQtdReg Then
        FItens.FieldByName('ENT_VAL_TS').AsFloat := fltGnrRes
      Else
      Begin
        If fltTotIte > 0 Then
        Begin
          fltRepresentacao := (FItens.FieldByName('ENT_TOTITE').AsFloat * 100) / fltTotIte;
          FItens.FieldByName('ENT_VAL_TS').AsFloat := RoundTo((fltRepresentacao * fStrToFloat(FValGnr)/ 100), -6)

        End
        Else
          FItens.FieldByName('ENT_VAL_TS').AsFloat := 0;

        fltGnrRes := fltGnrRes - FItens.FieldByName('ENT_VAL_TS').AsFloat;
      End;

      if FItens.FieldByName('ENT_VAL_TS').AsFloat < 0 Then
        Result := False;

      FItens.Post;
      FItens.Next;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[fRateiaGnre]');
    End;
  End;

  FItens.Filtered := False;
end;

function TGNRE.fRetTipoChamatoToChar: string;
begin
  Case FTipoChamada Of
    tcGnreST : Result := 'S';
    tcGnreTributado : Result := 'T';
  Else
    Result := 'P';
  End;
end;

function TGNRE.fRetTotalBasSTCalculado: Double;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try

    qryConsulta.SQL.Add('SELECT SUM(ENT_GNRTSU) AS TOTSUB FROM TMP_ENTMER');
    Try
      qryConsulta.Open;
      Result := qryConsulta.FieldByName('TOTSUB').AsFloat;
    Except
      Result := 0;
    End;

  Finally
    FreeAndNil(qryConsulta);
  End

end;

{ TListGNRE }

constructor TListGNRE.Create(Owner: TComponent; ATipoChamada : TTipoChamada);
  Var
    strSQL : String;
begin
  inherited Create;
  blnIFCPST := fCfgSis('IFCPST', varBoolean);
  FTipoChamada := ATipoChamada;

  Case FTipoChamada of
    tcGnreST,
    tcGnreTributado,
    tcGnrePadrao : FTabela := 'CADGNR';
    tcTCIF       : FTabela := 'GNRTCI';
    tcTS         : FTabela := 'GNR_TS';
  End;


  strEmpMeds := fEmpresasMedEmp;
  strMedEmp  := fCfgSis('MEDEMP', varString);

  pCarregaAtpVmb;

  strForFil := fRetForFilialTodos;

  FFrmCus := fCfgSis('FRMCUS', varString);

  cpcParams := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao);

  blnDeuErro := False;
  AOwner := Owner;
  FQtdIns := 0;
  strSQL := '';
  strSQL := strSQL + ' SELECT AUTOINCREM,   ';
  strSQL := strSQL + '        GNR_CODEMP,   ';
  strSQL := strSQL + '        GNR_DTAENT,   ';
  strSQL := strSQL + '        GNR_C_G_C_,   ';
  strSQL := strSQL + '        GNR_I_E_S_,   ';
  strSQL := strSQL + '        GNR_DTAGNR,   ';
  strSQL := strSQL + '        GNR_ESTSUB,   ';
  strSQL := strSQL + '        GNR_ESTFAV,   ';
  strSQL := strSQL + '        GNR_BCOGNR,   ';
  strSQL := strSQL + '        GNR_AGEGNR,   ';
  strSQL := strSQL + '        GNR_NUMGNR,   ';
  strSQL := strSQL + '        GNR_VALGNR,   ';
  strSQL := strSQL + '        GNR_DTAVEN,   ';
  strSQL := strSQL + '        GNR_MESANO,   ';
  strSQL := strSQL + '        GNR_CONPRO,   ';
  strSQL := strSQL + '        GNR_CODCTA,   ';
  strSQL := strSQL + '        GNR_CODEVE,   ';
  strSQL := strSQL + '        GNR_CODFOR,   ';
  strSQL := strSQL + '        GNR_FORDOC,   ';
  strSQL := strSQL + '        GNR_SERIE_,   ';
  strSQL := strSQL + '        GNR_ESPDOC,   ';
  strSQL := strSQL + '        GNR_NUMDOC,   ';
  strSQL := strSQL + '        GNR_AUTBAN,   ';
  strSQL := strSQL + '        GNR_AUTFIS,   ';
  strSQL := strSQL + '        GNR_BASCAL,   ';
  strSQL := strSQL + '        GNR_TIPGUI,   ';
  strSQL := strSQL + '        GNR_CODREC,   ';
  If FTipoChamada in [tcGnreST, tcGnreTributado, tcGnrePadrao] Then
    strSQL := strSQL + '        GNR_ORIGEM,   ';
  strSQL := strSQL + '        "N" AS GNR_INSERT, ';
  strSQL := strSQL + '        0 AS GNR_SEQREG ';
  strSQL := strSQL + ' FROM ' + FTabela;
  strSQL := strSQL + ' WHERE                ';
  strSQL := strSQL + ' GNR_AUTFIS = :AUTFIS ';

  FqryDados := TZClient.Create(Owner, strSQL);

  FdtsDados := TDataSource.Create(Owner);
  FdtsDados.DataSet := FqryDados;
  FdtsDados.AutoEdit:= False;

  With FqryDados Do
  Begin
    If Not fAbreClient(True, 'TListGNRE.Create') Then
    Begin
      blnDeuErro := True;
      Exit;
    End;
    TFloatField(FieldByName('GNR_VALGNR')).DisplayFormat := '#,##0.00';
  end;

  FItensLis := TZClient.Create(Nil);
  FItensLis.pCriaSoma('DET_TOTITE', 'TOT_TOTITE');
end;

destructor TListGNRE.Destroy;
begin
  If Assigned(FdtsDados) Then FreeAndNil(FdtsDados);
  If Assigned(FqryDados) Then FreeAndNil(FqryDados);
  If Assigned(FItensLis) Then
    Try
      FreeAndNil(FItensLis);
    Except
      {}
    End;

  If Assigned(cpcParams) Then FreeAndNil(cpcParams);

  Inherited Destroy;
end;

function TListGNRE.fGravaGnre(strNumDoc, strEspDoc, strSerie, strForDoc,
  strCodOpe, strNomForm: String; blnImprimeCP: Boolean; dtaDtaDoc : TDate;
  strAutIncCadFis: String): Boolean;
Begin
  FNumDoc       := strNumDoc;
  FEspDoc       := strEspDoc;
  FSerie        := strSerie;
  FForDoc       := strForDoc;
  FCodOpe       := strCodOpe;
  FNomForm      := strNomForm;
  FImprimeCP    := blnImprimeCP;
  FDtaDoc       := dtaDtaDoc;
  FAutIncCadFis := strAutIncCadFis;

  Try

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Gravando Guia...';
    frmGravando.fExecutarAcao := fGravaGnreInterna;
    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;


  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TListGNRE.fGravaGnre]');
    End;
  End;

  pFreeAndNil(frmGravando);

end;

function TListGNRE.fGravaGnreInterna(pgbProgresso: TcxProgressBar): Boolean;
  Var
    intContador : Integer;
    fltTotGnr   : Double;
begin
  Result    := True;
  Try
    pInicializaImpressaoCP;
    fltTotGnr := 0.00;
    fStartTransaction;

    pgbProgresso.Properties.Max := Self.Count;

    For intContador := 0 to Self.Count -1 Do
    Begin
      Try
        If (Not TGNRE(Self.Items[intContador]).FExcluida) Then
          fltTotGnr := fltTotGnr + fStrToFloat( TGNRE(Self.Items[intContador]).strValGnr );

        If (Not TGNRE(Self.Items[intContador]).FExcluida) Then
        Begin

          if fEmptyStr(TGNRE(Self.Items[intContador]).strAutoin) Then
            Result := TGNRE(Self.Items[intContador]).fGravaGnre(FNumDoc,
                                                                FEspDoc,
                                                                FSerie,
                                                                FForDoc,
                                                                FCodOpe,
                                                                FNomForm,
                                                                FImprimeCP,
                                                                FDtaDoc,
                                                                FAutIncCadFis,
                                                                False)
          Else
            Result := TGNRE(Self.Items[intContador]).fAtualizaAutBancaria(FImprimeCP);

        End;

      Except
        on E : Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, 'function TListGNRE.fGravaGnre' );
        End;
      end;

      pgbProgresso.Position := pgbProgresso.Position + 1;

      If not Result Then
        Break;

    End;

    if Result Then
      Result := fAtualizaValorTodosGNRE(FNumDoc, FEspDoc, FSerie, FForDoc);

    if FImprimeCP Then
      pImprimeCPs

  Finally
    if Result Then
      fCommit
    Else
      fRollBack;

  End;

end;

Function TListGNRE.fValidaDocumento(strNumDoc,
                                    strEspDoc,
                                    strSerie,
                                    strCodEmp,
                                    strCodFor: String;
                                    var blnComNfe: Boolean;
                                    blnShwMsg: Boolean = True): Boolean;
Begin
  FForDoc := strCodFor;
  blnComNFE := fTemNotaElet(strNumDoc, strEspDoc, strSerie, strCodFor, strCodEmp);
  Result    := fCarregaItens(strNumDoc, strEspDoc, strSerie, strCodFor, strCodEmp, blnComNFE);

  If Not Result Then
    Result := fCarregaItensConFre(strNumDoc, strEspDoc, strSerie, strCodFor, strCodEmp, blnComNFE);

  If (blnShwMsg) Then
  Begin

    If Not Result then
    Begin
      If FTipoChamada in [tcTCIF, tcTS] Then
        pMensagemOk('Não há itens cadastrados para a cobrança dessa taxa para essa nota!')
      Else
      Begin
        If blnComNFE Then
          pMensagemOk('Não há itens cadastrados com substituição tributária no estado da' + #13#10 +
                      'empresa que estejam tributados (CST X00 ou X20) ou tenham substituição' + #13#10 +
                      'tributária na nota eletrônica (XML)!')
        Else
          pMensagemOk('Não há itens cadastrados com substituição tributária no estado da' + #13#10 +
                      'empresa para essa nota!')
      End;
    End;

  End;
End;

function TListGNRE.fTemNotaElet(strNumDoc, strEspDoc, strSerie, strForDoc, strCodEmp: String): Boolean;
  Var
    qryGerEle: TUniQuery;
Begin
  qryGerEle := fCriaQuery;
  With qryGerEle, SQL Do
  Begin
    Add('SELECT GE.AUTOINCREM FROM GERELE GE');
    Add('WHERE');
    Add('  GE.GER_DOCENT = :NUMDOC AND ');
    Add('  GE.GER_EMPENT = :CODEMP AND ');
    Add('  GE.GER_ESPENT = :ESPDOC AND ');
    Add('  GE.GER_CODFOR = :CODFOR AND ');
    Add('  IFNULL(GE.B07_SERIE, "") = IFNULL(:SERIE_, "") ');

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('SERIE_').AsString := strSerie;
    ParamByName('CODFOR').AsString := strForDoc;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    Result := Not IsEmpty;
  End;

  FreeAndNil(qryGerEle);
End;

function TListGNRE.fSQLCadTriConcat: String;
var qryCon: TUniQuery;
begin
  qryCon := fCriaQuery;
  Try
    qryCon.sql.text := 'SELECT GROUP_CONCAT(TRI_CODTRI SEPARATOR "_") AS CST FROM CADTRI ' +
                       '   WHERE TRI_GERGNR  = "S" ';
    qryCon.Open;

    If qryCon.IsEmpty then
      exit('');

    Result := qryCon.FieldByName('CST').AsString;
  Finally
    FreeAndNil(qryCon);
  End
end;

function TListGNRE.fSQLCarregaItens(strNumDoc, strEspDoc, strSerie, strForDoc, strCodEmp: String; blnComNFE: Boolean): String;
  Var
    strSQL, strPerfil: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT  DET_TOTITE,         ';
  strSQL := strSQL + '         DET_VALIPI,         ';
  strSQL := strSQL + '         DET_VALICM,         ';
  strSQL := strSQL + '         IFNULL(T.DET_SISCOM,0) AS DET_SISCOM,  ';

  strSQL := strSQL + '         IFNULL(T.DET_ICMNCR, 0) AS DET_ICMNCR, ';
  strSQL := strSQL + '         IFNULL(T.DET_FCPNCR, 0) AS DET_FCPNCR, ';
  strSQL := strSQL + '         DET_ALQPIS,         ';
  strSQL := strSQL + '         DET_ALQCOF,         ';
  strSQL := strSQL + '       D.DET_INCPIS,         ';
  strSQL := strSQL + '       T.DET_SEQGER AS SEQTRI, ';
  strSQL := strSQL + '       T.DET_ALQFRE,         ';
  strSQL := strSQL + '       T.DET_VAEIPI,         ';
  strSQL := strSQL + '         DET_TOTFRE,         ';
  strSQL := strSQL + '         DET_CONFRE,         ';
  strSQL := strSQL + '         IFNULL(T.DET_RPAFRE, 0) AS DET_RPAFRE, ';
  strSQL := strSQL + '         DET_OUTDES,         ';
  strSQL := strSQL + '       T.DET_CFRETE,         ';
  strSQL := strSQL + '       T.DET_CFRECO,         ';
  strSQL := strSQL + '         DET_VENDOR,         ';
  strSQL := strSQL + '         DET_DESACE,         ';
  strSQL := strSQL + '         DET_ICMANT,         ';
  strSQL := strSQL + '         DET_VLGNRE,         ';
  strSQL := strSQL + '         DET_VALRET,         ';
  strSQL := strSQL + '         DET_VLRCON,         ';
  strSQL := strSQL + '       T.DET_VAERET,         ';

  strSQL := strSQL + '       T.DET_VLGNRE,         ';
  strSQL := strSQL + '       T.DET_VALTCI,         ';
  strSQL := strSQL + '       T.DET_VAL_TS,         ';

  strSQL := strSQL + '         DET_DESESP,         ';
  strSQL := strSQL + '         ITE_INCPIS,         ';
  strSQL := strSQL + '         ITE_SALDOS,         ';
  strSQL := strSQL + '         DET_TOTMED,         ';
  strSQL := strSQL + '         DET_QTDITE,         ';
    strSQL := strSQL + '      (SELECT  SUM(D2.DET_QTDITE) FROM MOVDET D2 WHERE D2.DET_CODITE = D.DET_CODITE AND D2.DET_SEQGER = D.DET_SEQGER) QTDTOT, ';

  strSQL := strSQL + '         DET_CODFIS,         ';
  strSQL := strSQL + '         DET_CLAFIS,         ';
  strSQL := strSQL + '         ROUND((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE, 4) AS DET_UNITAR, ';
  strSQL := strSQL + '         DET_ALQICM,         ';
  strSQL := strSQL + '         DET_PERBAS,         ';
  strSQL := strSQL + '         DET_CODFOR,         ';
  strSQL := strSQL + '         DET_NUMDOC,         ';
  strSQL := strSQL + '         DET_ESPDOC,         ';
  strSQL := strSQL + '         DET_CODEMP,         ';
  strSQL := strSQL + '         DET_SERIE_,         ';
  strSQL := strSQL + '         D.DET_CODITE,       ';

  strSQL := strSQL + '         D.DET_CODFOR AS ENT_CODFOR,       ';
  strSQL := strSQL + '         DET_NUMLOT,         ';

  // CAMPOS PARA A GRID
  strSQL := strSQL + '   0.0000 AS VLRPROD,  ';
  strSQL := strSQL + '   0.0000 AS ALQBASST, ';
  strSQL := strSQL + '   0.0000 AS VLSTNF, ';
  strSQL := strSQL + fCampoFCPST(blnComNFE);
  strSQL := strSQL + '   0.0000 AS VLRCALGNR, ';
  strSQL := strSQL + '   CAST("" AS CHAR(5000)) AS ENT_CALGNR, ';
  strSQL := strSQL + '         D.DET_CODITE AS ENT_CODITE,  ';
  strSQL := strSQL + '         I.ITE_CODFAB AS ENT_CODFAB,  ';
  strSQL := strSQL + '         D.DET_DESCRI AS ENT_DESITE,  ';
  strSQL := strSQL + '         I.ITE_REFERE AS ENT_REFERE,  ';
  strSQL := strSQL + '           UNI_SIGUNI AS ENT_SIGUNI,  ';
  strSQL := strSQL + '         D.DET_CODFIS AS ENT_CODFIS,  ';
  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '  I.ITE_CODABF AS ENT_CODABF, '
  Else
    strSQL := strSQL + '  G.ITE_CODABF AS ENT_CODABF, ';

  strSQL := strSQL + '         ITE_PRECOM,         ' ;
  strSQL := strSQL + '         T.DET_SEQGER AS AUTINC_TRI, ';
  strSQL := strSQL + '         T.DET_VFCPST, ';
  strSQL := strSQL + '         IFNULL(V.ICD_PERFCP, 0) AS ICD_PERFCP, ';
  strSQL := strSQL + '         IFNULL(V.ICD_VALFCP, 0) AS ICD_VALFCP, ';
  strSQL := strSQL + '         DET_TOTITE AS ENT_TOTITE,   ';

  If blnComNFE Then
  Begin
    strSQL := strSQL + ' DE.DET_CALSTU AS ENT_CALSTU, ';
    strSQL := strSQL + ' GE.AUTOINCREM AS ENT_AUTELE, ';
    strSQL := strSQL + ' DE.AUTOINCREM AS ENT_DETEL2, ';
  End
  Else
  begin
    strSQL := strSQL + ' -1 AS ENT_CALSTU, ';
    strSQL := strSQL + ' "" AS ENT_AUTELE, ';
    strSQL := strSQL + ' "" AS ENT_DETEL2, ';
  End;
  strSQL := strSQL + ' T.DET_CONFRE AS ENT_FRECON, ';

  If TipoChamada = tcGnreTributado Then
    strSQL := strSQL + ' IFNULL(DET_TOTITE, 0) + IFNULL(DET_VALIPI, 0) AS BASCAL, ';

  If FTipoChamada in [tcGnreST, tcGnreTributado, tcGnrePadrao] Then
  Begin

    strSQL := strSQL + '   CALGNR.CAL_BASICM, ';
    strSQL := strSQL + '   CALGNR.CAL_VLICMS, ';
    strSQL := strSQL + '   CALGNR.CAL_ALQICM, ';
    strSQL := strSQL + '   CALGNR.CAL_VR_IVA, ';
    strSQL := strSQL + '   CALGNR.CAL_BAS_ST, ';
    strSQL := strSQL + '   CALGNR.CAL_VR_SUB, ';
    strSQL := strSQL + '   CALGNR.CAL_VFCPST, ';
    strSQL := strSQL + '   CALGNR.CAL_ALQINT, ';



    If  blnComNFE Then
      strSQL := strSQL + '         IF(IFNULL(DET_VLGNRE, 0)  > 0, DET_VLGNRE,  DE.DET_VLRGNR) AS ENT_VALGNR,    '
    Else
      strSQL := strSQL + '         T.DET_VLGNRE AS ENT_VALGNR,    ';
  end
  Else
    strSQL := strSQL + '      0 AS ENT_VALGNR, ';
  If FTipoChamada = tcTCIF Then
    strSQL := strSQL + '         IF(DET_VALTCI = 0, DET_CALTCI, DET_VALTCI) AS ENT_VLTCIF,    '
  Else
    strSQL := strSQL + '         0 AS  ENT_VLTCIF, ';
  If FTipoChamada = tcTS Then
    strSQL := strSQL + '         DET_VAL_TS AS ENT_VAL_TS,    '
  Else
    strSQL := strSQL + '         0 AS ENT_VAL_TS,    ';



  strSQL := strSQL + '         0 ENT_ALQTCI, ';
  strSQL := strSQL + '         0 ENT_ALQ_TS, ';

  strSQL := strSQL + '         T.DET_TOTULT, ';

  If blnComNFE Then
  Begin
    strSQL := strSQL + '   IF(LOCATE(DET_CSTXML, CONCAT(:TRIBUT, "' + fSQLCadTriConcat +  '")) > 0, "S", "N") AS ENT_COMGNR, ';
    strSQL := strSQL + '   IF(LOCATE(DET_CSTXML, CONCAT(:TRIBUT, "' + fSQLCadTriConcat +  '")) > 0, "S", "N") AS ENT_GNRFIX, ';
  End Else
  Begin
    strSQL := strSQL + '   "S" AS ENT_COMGNR, ';
    strSQL := strSQL + '   "N" AS ENT_GNRFIX, ';
  End;
  strSQL := strSQL + '  IF(IFNULL(T.DET_GNRORI, "") = "", "P", T.DET_GNRORI) AS ORIGEM, ';
  strSQL := strSQL + ' T.DET_ATUPRE,   ';

  strSQL := strSQL + ' D.AUTOINCREM   ';
  strSQL := strSQL + ' FROM MOVDET D  ';

  strSQL := strSQL + '   INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
  strSQL := strSQL + '   INNER JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '   INNER JOIN ITEGER G ON G.ITE_CODITE = D.DET_CODITE AND G.ITE_CODEMP = D.DET_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN MOVICD V ON ICD_SEQGER = D.AUTOINCREM ';
  strSQL := strSQL + '   LEFT  JOIN CADUNI ON   UNI_CODUNI = I.ITE_CODUNI ';
  strSQL := strSQL + '   LEFT  JOIN CALGNR ON  CALGNR.DET_SEQDET = D.AUTOINCREM ';

  strSQL := strSQL + '  INNER JOIN CADFOR F ON D.DET_CODFOR = F.FOR_CODFOR ';
  strSQL := strSQL + '  INNER JOIN CADCID C ON F.FOR_CODCID = C.CID_CODCID ';
  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '  INNER JOIN ABFICM B ON B.ABF_CODABF = I.ITE_CODABF AND '
  Else
    strSQL := strSQL + '  INNER JOIN ABFICM B ON B.ABF_CODABF = G.ITE_CODABF AND ';

  strSQL := strSQL + '                         B.ABF_ESTADO = C.CID_ESTADO ';

  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + ' LEFT JOIN ABFICM A ON A.ABF_CODABF = I.ITE_CODABF  '
  Else
    strSQL := strSQL + ' LEFT JOIN ABFICM A ON A.ABF_CODABF = G.ITE_CODABF  ';

  strSQL := strSQL + '                        AND A.ABF_ESTADO = :ESTADO     ';

  If Not  (FTipoChamada in  [tcTCIF, tcTS]) Then
  Begin
    strPerfil :=  fGetTipoAbfFornecedor(strForDoc);

	  If fEmptyStr(strForDoc) Then
	    strPerfil := '_ENT_PEJ';

    If FTipoChamada = tcGnreTributado Then
    Begin
      strSQL := strSQL + '     AND LOCATE(A.ABF_CODSIT' + strPerfil + ', :TRIBUT2) > 0 '; //TRIBUT2
      //strSQL := strSQL + '     AND DET_ENTTRI = "S" ';
    end
    Else
     strSQL := strSQL + '      AND LOCATE(A.ABF_CODSIT' + strPerfil + ',  :SUBSTI) > 0 ';

  End;

  If blnComNFE Then
  Begin
    strSQL := strSQL + 'INNER JOIN GERELE GE ON GE.GER_DOCENT = D.DET_NUMDOC AND ';
    strSQL := strSQL + '                        GE.GER_EMPENT = D.DET_CODEMP AND ';
    strSQL := strSQL + '                        GE.GER_ESPENT = D.DET_ESPDOC AND ';
    strSQL := strSQL + '                        GE.GER_CODFOR = D.DET_CODFOR AND ';
    strSQL := strSQL + '                        IFNULL(GE.B07_SERIE, "") = IFNULL(D.DET_SERIE_, "") ';

    strSQL := strSQL + 'INNER JOIN DETELE DE ON DE.DET_SEQGER = GE.AUTOINCREM    ';
    strSQL := strSQL + '                        AND    DE.DET_CODITE = D.DET_CODITE       ';
    If (FTipoChamada in [tcGnreST, tcGnreTributado, tcGnrePadrao]) Then
    Begin
      If FTipoChamada  = tcGnreTributado Then
         strSQL := strSQL + ' AND (LOCATE(DET_CSTXML, ' + QuotedStr(CST_TRIBUTADO + fRetCST_CONCST('CST_TRIBUTADO')) + ') > 0) ' //MF: 20/02/24
      Else
      Begin
        strSQL := strSQL + '                        AND (LOCATE(DE.DET_CSTXML, ' + QuotedStr(CST_TRIBUTADO + fRetCST_CONCST('CST_TRIBUTADO') + fSQLCadTriConcat) + ') > 0 OR ';
        strSQL := strSQL + '                         LOCATE(DE.DET_CSTXML, :SUBSTI) > 0   ';
        If fCfgSis('GNRX90') = 'S' Then
          strSQL := strSQL + '                       OR LOCATE(DE.DET_CSTXML, ' + QuotedStr(CST_ANTECIPACAO_ICMS+ fRetCST_CONCST('CST_ANTECIPACAO_ICMS')) + ') > 0 ';
        strSQL := strSQL + ')   ';
      End;
    End
  End;
  If  (FTipoChamada in  [tcTCIF, tcTS]) Then
    strSQL := strSQL + ' LEFT JOIN CADNCM ON I.ITE_EXCIPI = NCM_CODEXC AND ITE_CLAIPI = NCM_CODNCM ';

  strSQL := strSQL + ' WHERE DET_NUMDOC = ' + strNUMDOC + ' ';
  strSQL := strSQL + '   AND DET_ESPDOC = ' + strEspDoc + ' ';
  strSQL := strSQL + '   AND IFNULL(DET_SERIE_, "") = IFNULL(' + strSerie  + ', "") ';
  strSQL := strSQL + '   AND DET_CODFOR = ' + strForDoc + ' ';
  strSQL := strSQL + '   AND DET_CODEMP = ' + strCodEmp + ' ';
  If Not  (FTipoChamada in  [tcTCIF, tcTS]) Then
    strSQL := strSQL + '   AND ((A.ABF_CODABF IS NOT NULL) OR LOCATE(DET_CODFIS, ' + QuotedStr(CST_ANTECIPACAO_ICMS + fRetCST_CONCST('CST_ANTECIPACAO_ICMS') ) + ') > 0)'
  Else If FTipoChamada = tcTS Then
    strSQL := strSQL + ' AND NCM_ALQIPI > 0 ';
  strSQL := strSQL + '   AND DET_CODEMP = ' + strCodEmp + ' ';
  strSQL := strSQL + '   GROUP BY D.AUTOINCREM ';

  Result := strSQL;
End;

Function TListGNRE.fCarregaItensConFre(strNumDoc, strEspDoc, strSerie, strCodFor, strCodEmp: String; Var blnComNFE: Boolean): Boolean;
  Var
    qryNotas: TUniQuery;
    strSQL: String;
    blnComNFENota: Boolean;
Begin
  Result := False;
  blnComNFE := False;

  qryNotas := fCriaQuery;
  With qryNotas, SQL Do
  Begin
    Add('SELECT');
    Add('  GER_NUMDOC, ');
    Add('  GER_ESPDOC, ');
    Add('  GER_SERIE_, ');
    Add('  GER_CODFOR, ');
    Add('  GER_CODEMP  ');
    Add('FROM');
    Add('  MOVGER G');
    Add('INNER JOIN CONFRE C ON C.CON_SEQGER = G.AUTOINCREM ');

    Add('INNER JOIN CADFIS F ON C.CON_SEQFIS = F.AUTOINCREM ');

    Add('WHERE ');

    Add('  FIS_NUMDOC = :NUMDOC AND ');
    Add('  FIS_ESPDOC = :ESPDOC AND ');
    Add('  IFNULL(FIS_SERIE_, "") = IFNULL(:SERIE_, "") AND');
    Add('  FIS_FORCLI = :CODFOR AND');
    Add('  FIS_TIP_FC = "F" AND');
    Add('  FIS_CODEMP = :CODEMP    ');

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('SERIE_').AsString := strSerie;
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    strSQL := '';
    While Not Eof Do
    Begin
      blnComNFENota := fTemNotaElet(FieldByName('GER_NUMDOC').AsString,
                                    FieldByName('GER_ESPDOC').AsString,
                                    FieldByName('GER_SERIE_').AsString,
                                    FieldByName('GER_CODFOR').AsString,
                                    FieldByName('GER_CODEMP').AsString);

      If Not fEmptyStr(strSQL) Then
        strSQL := strSQL + ' UNION ALL ';

      strSQL := strSQL + fSQLCarregaItens(QuotedStr(FieldByName('GER_NUMDOC').AsString),
                                          QuotedStr(FieldByName('GER_ESPDOC').AsString),
                                          QuotedStr(FieldByName('GER_SERIE_').AsString),
                                          QuotedStr(FieldByName('GER_CODFOR').AsString),
                                          QuotedStr(FieldByName('GER_CODEMP').AsString),
                                          blnComNFENota);

      If blnComNFENota Then
        blnComNFE := True;

      Next;
    End;

    If Not fEmptyStr(strSQL) Then
    Begin
      FItensLis.Close;
      FItensLis.qryQuery.SQL.Clear;
      With FItensLis.qryQuery Do
      Begin
        SQL.Text := strSQL;

        ParamByName('SUBSTI').AsString := CST_SUBSTITUICAO + fRetCST_CONCST('CST_SUBSTITUICAO');
        ParamByName('ESTADO').AsString := fCadEmp('ESTADO');

        Result := FItensLis.fAbreClient(True, 'TListGNRE.fCarregaItens') And
                (FItensLis.RecordCount > 0);
      End;
    End;

  End;

  FreeAndNil(qryNotas);
End;

function TListGNRE.fCarregaItens(strNumDoc, strEspDoc, strSerie, strForDoc, strCodEmp: String; blnComNFE: Boolean): Boolean;
Begin
  FItensLis.Close;
  FItensLis.qryQuery.SQL.Clear;
  With FItensLis.qryQuery Do
  Begin
    SQL.Text := fSQLCarregaItens(':NUMDOC',
                                 ':ESPDOC',
                                 ':SERIE_',
                                 strForDoc,
                                 ':CODEMP',
                                 blnComNFE);

    If Not (TipoChamada in [tcTCIF, tcTS]) Then
    Begin
      If FTipoChamada = tcGnreTributado Then
        ParamByName('TRIBUT2').AsString := CST_TRIBUTADO + fRetCST_CONCST('CST_TRIBUTADO') //TRIBUT2
      Else
        ParamByName('SUBSTI').AsString := CST_SUBSTITUICAO +fRetCST_CONCST('CST_SUBSTITUICAO');
    End;


    ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('SERIE_').AsString := strSerie;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Result := FItensLis.fAbreClient(True, 'TListGNRE.fCarregaItens') And
              (FItenslis.RecordCount > 0);
  End;
End;

function TListGNRE.fAtualizaValorTodosGNRE(strNumDoc, strEspDoc, strSerie, strForDoc : String): Boolean;
  Var
    fltImpUlt,
    fltSaldosAnt,
    fltPreMed,
    fltIcmMed,
    fltPreMedAnt: Double;
    blnContribuinteIPI,
    blnDedIcm,
    blnUltPis: Boolean;
    strBasMed: string;
    CalculoPrecoMediAgrup: TCalculoPrecoMediAgrup;
    objImpUlt: TCalculoUltimaCompraImpostos;
    blnZeraIPI: Boolean;
    blnNotaImp: Boolean;
begin
  CalculoPrecoMediAgrup := TCalculoPrecoMediAgrup.Create;
  Try
    blnContribuinteIPI := fCfgSis('CONIPI', varBoolean);
    strBasMed := fCfgSis('BASMED');

    FItensLis.First;
    strAgrupadorPreAlt := '';
    pPreAltDefineVariaveisAltPre(fNow, 'GNRE APOS ENTRADA DE MERCADORIAS', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

    While Not FItensLis.Eof Do
    Begin
      blnNotaImp := Copy(FItensLis.FieldByName('DET_CLAFIS').AsString, 1 , 1) = '3';
      If (Pos(FItensLis.FieldByName('DET_CODFOR').AsString, strForFil) > 0) Then
        blnUltPis := fRetForFilialDeduzPisCofinsUltimaCompra(VS_strCodEmp, FItensLis.FieldByName('DET_CODFOR').AsString)
      Else
        blnUltPis := fCfgSis('ULTPIS', VarBoolean);

      If (Pos(FItensLis.FieldByName('DET_CODFOR').AsString, strForFil) > 0) Then
        blnDedIcm := fRetForFilialDeduzICMSUltimaCompra(VS_strCodEmp, FItensLis.FieldByName('DET_CODFOR').AsString)
      Else
        blnDedIcm:= fCfgSis('ULTPIS', VarBoolean);

      objImpUlt := TCalculoUltimaCompraImpostos.fCriaImpUlt
        .TotalItem(FItensLis.FieldByName('DET_TOTITE').AsFloat)
        .DescontoEspecial(FItensLis.FieldByName('DET_DESESP').AsFloat);

      If blnUltPis Then
      Begin
        objImpUlt.AliquotaPis(FItensLis.FieldByName('DET_ALQPIS').AsFloat).AliquotaCofins(FItensLis.FieldByName('DET_ALQCOF').AsFloat);
      End
      Else
      Begin
        objImpUlt.AliquotaPis(0).AliquotaCofins(0);
      End;

      blnZeraIPI := fZeraIPI(FItensLis.FieldByName('DET_CODITE').AsString);
      objImpUlt.blnUltPis := blnUltPis;

      objImpUlt
        .ValorIpi(IIf(blnZeraIPI, 0, FItensLis.FieldByName('DET_VALIPI').AsFloat))
        .ValorIpiNaoCreditado(IIf(blnZeraIPI, 0, FItensLis.FieldByName('DET_VAEIPI').AsFloat))

        .Frete(FItensLis.FieldByName('DET_TOTFRE').AsFloat)
        .ConhecimentoFrete(FItensLis.FieldByName('DET_CONFRE').AsFloat)
        .AliquotaICMSdoFrete(FItensLis.FieldByName('DET_ALQFRE').AsFloat)

        .fRecebimentoPagamentoAutonomoFrete(FItensLis.FieldByName('DET_RPAFRE').AsFloat)
        .OutrasDespesas(FItensLis.FieldByName('DET_OUTDES').AsFloat)
        .Vendor(FItensLis.FieldByName('DET_VENDOR').AsFloat)
        .DespesaAcessoria(FItensLis.FieldByName('DET_DESACE').AsFloat)

        .ValorIcms(IIF(blnDedIcm and (not blnNotaImp), FItensLis.FieldByName('DET_VALICM').AsFloat + FItensLis.FieldByName('ICD_VALFCP').AsFloat, 0))

        .ValorIcmsNaoCreditado(IIF(blnDedIcm  and (not blnNotaImp), IIF((FItensLis.FieldByName('DET_VALICM').AsFloat + FItensLis.FieldByName('ICD_VALFCP').AsFloat) > 0,
                                                  0,
                                                  FItensLis.FieldByName('DET_ICMNCR').AsFloat) + FItensLis.FieldByName('DET_FCPNCR').AsFloat, 0))

        .ValorIcmsAntecipado(FItensLis.FieldByName('DET_ICMANT').AsFloat)
        .ValorIcmsAntecipadoFrete(0)

        .ValorGNRE(IIf(FTipoChamada in [tcGnreST, tcGnreTributado, tcGnrePadrao],
                          FItensLis.FieldByName('ENT_VALGNR').AsFloat,
                          FItensLis.FieldByName('DET_VLGNRE').AsFloat))

        .ValorTCIF(IIf(FTipoChamada = tcTCIF, FItensLis.FieldByName('ENT_VLTCIF').AsFloat, FItensLis.FieldByName('DET_VALTCI').AsFloat))

        .ValorTS(IIf(FTipoChamada = tcTS, FItensLis.FieldByName('ENT_VAL_TS').AsFloat, FItensLis.FieldByName('DET_VAL_TS').AsFloat))

        .ValorRetido(FItensLis.FieldByName('DET_VALRET').AsFloat)
        .ValorRetidoNaoCreditado(FItensLis.FieldByName('DET_VAERET').AsFloat)
        .ValorFundoCombateAPobreza(FItensLis.FieldByName('DET_VFCPST').AsFloat)
        .FornecedorFilial(Pos(FItensLis.FieldByName('DET_CODFOR').AsString, strForFil) > 0)
        .ItemIncidePis(FItensLis.FieldByName('DET_INCPIS').AsString)
        .ValorSiscomex(IIf(blnNotaImp, FItensLis.FieldByName('DET_SISCOM').AsFloat, 0))
        .ValorIcmsNotaImportacao(IIf(blnNotaImp, FItensLis.FieldByName('DET_VALICM').AsFloat, 0));

      fltImpUlt := objImpUlt.fTotal;

      FreeAndNil(objImpUlt);

      If strMedEmp = '1' Then
        fltSaldosAnt := fSaldoEmpresas(FItensLis.FieldByName('DET_CODITE').AsString, strEmpMeds)
      Else
        fltSaldosAnt := FItensLis.FieldByName('ITE_SALDOS').AsFloat;

      fltSaldosAnt := fltSaldosAnt - FItensLis.FieldByName('QTDTOT').AsFloat;
      If CalculoPrecoMediAgrup.CalculoPreMed[FItensLis.FieldByName('DET_CODITE').AsString, ''].blnEncontrado Then
         fltSaldosAnt := CalculoPrecoMediAgrup.CalculoPreMed[FItensLis.FieldByName('DET_CODITE').AsString, ''].SaldoAnterior;

      fltPreMedAnt := FItensLis.FieldByName('DET_TOTMED').AsFloat / FItensLis.FieldByName('DET_QTDITE').AsFloat;

      fltPreMed := 0.00;

      If (Pos(FItensLis.FieldByName('DET_CODFOR').AsString, strForFil) <= 0)  OR ((Pos(FItensLis.FieldByName('DET_CODFOR').AsString, strForFil) > 0) And (fCfgSis('TRDPCI') = 'S')) Then       
        fltIcmMed := IIF((Pos(FItensLis.FieldByName('DET_CODFIS').AsString, CST_REDUCAO + fRetCST_CONCST('CST_REDUCAO')) > 0) ,
                                          fFormataFloat((FItensLis.FieldByName('DET_ALQICM').AsFloat * FitensLis.FieldByName('DET_PERBAS').AsFloat) / 100, 2),
                                          FItensLis.FieldByName('DET_ALQICM').AsFloat + FItensLis.FieldByName('ICD_PERFCP').AsFloat)
      Else
        fltIcmMed := 0;
      CalculoPrecoMediAgrup.strCodIteAtual :=  FItensLis.FieldByName('DET_CODITE').AsString;
      If strBasMed <> 'S' Then
         fltPreMed := fCalculaPrecoMedio( FItensLis.FieldByName('DET_CODFIS').AsString, // Código Fiscal
                                          FItensLis.FieldByName('DET_CLAFIS').AsString, // Classificação Fiscal
                                          fltPreMedAnt,                       // Preço medio anterior
                                          fltSaldosAnt,                       // Saldo anterior
                                          FItensLis.FieldByName('DET_QTDITE').AsFloat,  // Quantidade de entrada
                                          FItensLis.FieldByName('DET_UNITAR').AsFloat,  // Unitario sem impostos

                                          fltIcmMed,  // Aliquota de ICMS do Item

                                          FItensLis.FieldByName('DET_VALIPI').AsFloat +
                                          FItensLis.FieldByName('DET_VAEIPI').AsFloat,  // Valor do IPI

                                          FItensLis.FieldByName('DET_VALRET').AsFloat +
                                          FItensLis.FieldByName('DET_VAERET').AsFloat,  // Valor de Substituição

                                          FItensLis.FieldByName('DET_ICMANT').AsFloat,  // Valor ICMS Antecipado
                                          IIf(FTipoChamada in [tcGnreST, tcGnreTributado, tcGnrePadrao],
                                              FItensLis.FieldByName('ENT_VALGNR').AsFloat,
                                              FItensLis.FieldByName('DET_VLGNRE').AsFloat),
                                          IIf(FTipoChamada = tcTCIF, FItensLis.FieldByName('ENT_VLTCIF').AsFloat,  FItensLis.FieldByName('DET_VALTCI').ASFloat),
                                          IIf(FTipoChamada = tcTS  , FItensLis.FieldByName('ENT_VAL_TS').AsFloat,  FItensLis.FieldByName('DET_VAL_TS').ASFloat),
                                          blnContribuinteIPI,                 // Contribuinte de IPI?
                                          (Pos(FItensLis.FieldByName('DET_CODFOR').AsString, strForFil) > 0), // Fornec Filial
                                          FItensLis.FieldByName('ITE_INCPIS').AsString, // Indice se incide Pis

                                          FItensLis.FieldByName('DET_TOTFRE').AsFloat + // VALOR DO FRETE
                                          FItensLis.FieldByName('DET_CONFRE').AsFloat,

                                          FItensLis.FieldByName('DET_DESACE').AsFloat +
                                          FItensLis.FieldByName('DET_OUTDES').AsFloat +
                                          FItensLis.FieldByName('DET_VENDOR').AsFloat,

                                          FItensLis.FieldByName('DET_VALICM').AsFloat + FItensLis.FieldByName('ICD_VALFCP').AsFloat,

                                          IIF((FItensLis.FieldByName('DET_VALICM').AsFloat + FItensLis.FieldByName('ICD_VALFCP').AsFloat) > 0,
                                              0,
                                              FItensLis.FieldByName('DET_ICMNCR').AsFloat + FItensLis.FieldByName('DET_FCPNCR').AsFloat),

                                          FItensLis.FieldByName('DET_VFCPST').AsFloat,
                                          FItensLis.FieldByName('DET_ALQFRE').AsFloat,
                                          CalculoPrecoMediAgrup,
                                          FItensLis.FieldByName('DET_VAEIPI').AsFloat > 0);

      If FTipoChamada in [tcGnreST, tcGnreTributado, tcGnrePadrao] Then
        pUpdateMovTri(FItensLis.FieldByName('AUTINC_TRI').AsString, FItensLis.FieldByName('ENT_VALGNR').AsFloat, fltImpUlt)
      Else If FTipoChamada = tcTCIF Then
        pUpdateMovTri(FItensLis.FieldByName('AUTINC_TRI').AsString, FItensLis.FieldByName('ENT_VLTCIF').AsFloat, fltImpUlt)
      Else If FTipoChamada = tcTS  Then
        pUpdateMovTri(FItensLis.FieldByName('AUTINC_TRI').AsString, FItensLis.FieldByName('ENT_VAL_TS').AsFloat, fltImpUlt);


      If FTipoChamada in [tcGnreST, tcGnreTributado, tcGnrePadrao] Then
        fUpdateLotePrecos(FItensLis.FieldByName('ENT_VALGNR').AsFloat, FItensLis)
      Else If FTipoChamada = tcTCIF Then
        fUpdateLotePrecos(FItensLis.FieldByName('ENT_VLTCIF').AsFloat, FItensLis)
      Else If FTipoChamada = tcTS  Then
        fUpdateLotePrecos(FItensLis.FieldByName('ENT_VAL_TS').AsFloat, FItensLis);


      If Pos(FItensLis.FieldByName('DET_CLAFIS').AsString, '1922_2922_') <= 0 Then
      Begin
        pUpdateCadIte(FItensLis.FieldByName('DET_CODITE').AsString,
                      FItensLis.FieldByName('DET_CODFOR').AsString,
                      fCodificaChaveNota(FItensLis.FieldByName('DET_NUMDOC').AsString,
                                         FItensLis.FieldByName('DET_ESPDOC').AsString,
                                         FItensLis.FieldByName('DET_CODEMP').AsString,
                                         FItensLis.FieldByName('DET_SERIE_').AsString,
                                         FItensLis.FieldByName('DET_CODFOR').AsString),
                      fFormataFloat(fltImpUlt / FItensLis.FieldByName('DET_QTDITE').AsFloat, 4),
                      fltPreMed,
                      FItensLis.FieldByName('DET_ATUPRE').AsString = 'S');


        If (fltPreMed > 0) Then
          fGravaCalcPreMed(FItensLis.FieldByName('AUTOINCREM').AsString, 'TListGNRE.fAtualizaValorTodosGNRE', '', True);

        If (Not fEmptyStr(FItensLis.FieldByName('ENT_CALGNR').AsString)) Then
          pGravaMemoriaDeCalculo(FItensLis.FieldByName('AUTOINCREM').AsString,
                                 FItensLis.FieldByName('ENT_CALGNR').AsString);

        pAtualizaUltimaCompraCadLot(FItensLis.FieldByName('DET_CODITE').AsString,
                                    FItensLis.FieldByName('DET_NUMLOT').AsString,
                                    FItensLis.FieldByName('DET_CODFOR').AsString,
                                    fCodificaChaveNota(FItensLis.FieldByName('DET_NUMDOC').AsString,
                                         FItensLis.FieldByName('DET_ESPDOC').AsString,
                                         FItensLis.FieldByName('DET_CODEMP').AsString,
                                         FItensLis.FieldByName('DET_SERIE_').AsString,
                                         FItensLis.FieldByName('DET_CODFOR').AsString),
                                    FItensLis.FieldByName('DET_CODEMP').AsString,
                                    fFormataFloat(FItensLis.FieldByName('DET_TOTULT').AsFloat / FItensLis.FieldByName('DET_QTDITE').AsFloat, 4),
                                    fFormataFloat(fltImpUlt / FItensLis.FieldByName('DET_QTDITE').AsFloat, 4),
                                    VS_Date,
                                    True);

      End;
      FItensLis.Next;
    End;

    Result := True;
    strAgrupadorPreAlt := '';

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'function TListGNRE.fAtualizaValorTodosGNRE');
      Result := False;
      strAgrupadorPreAlt := '';
    End;
  End;

  FItensLis.Filtered := False;
  FreeAndNil(CalculoPrecoMediAgrup);
end;

procedure TListGNRE.pUpdateCadIte(strCodIte, strCodFor, strNotUlt: String;
                          fltImpUlt, fltPreMed: Double; blnAtuPreCom: Boolean);
  Var
    qryIteger: TUniQuery;
Begin
  qryIteger := fCriaQuery(AOwner);
  With qryIteger, SQL Do
  Begin
    Add('UPDATE ITEGER');
    Add('SET ');
    Add('  ITE_FORULT = :CODFOR, ');
//    Add('  ITE_DTAULT = :DTAULT, ');
    Add('  ITE_IMPULT = :IMPULT  ');

    If fltPreMed > 0 Then
    Begin
      Add('  ,ITE_PREMED = :PREMED ');
    End;


    Add('WHERE');
    Add('  ITE_CODITE = :CODITE AND');
    Add('  ITE_CODEMP = :CODEMP AND');
    Add('  ITE_NOTULT = :NOTULT    ');

    ParamByName('IMPULT').AsFloat  := fltImpUlt;

    If fltPreMed > 0 Then
      ParamByName('PREMED').AsFloat  := fltPreMed;

    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('NOTULT').AsString := strNotUlt;
  //ParamByName('DTAULT').AsDate   := VS_Date;

    ExecSQL;
  End;

  FreeAndNil(qryIteger);

  If fltPreMed > 0 Then
  Begin
    pAtualizaPrecoMedioEmpreas(strCodIte, strEmpMeds, fltPreMed);
    If blnAtuPreCom And (fCfgSis('ATUNMD') = 'M') Then
      pAtualizaPreco(fltPreMed, strCodIte, VS_strCodEmp);
  End;
End;

procedure TListGNRE.pUpdateMovTri(strAutInc: String; fltVlGnre, fltImpUlt: Double);
  Var
    qryMovTri: TUniQuery;
    LqryValGNR: TUniQuery;
    LValGNRMovTri: Double;
    LValGNRDetEle: Double;

    function fGetCampo: String;
    begin
      case FTipoChamada of
        tcGnreST,
        tcGnreTributado,
        tcGnrePadrao: Result := 'DET_VLGNRE';
        tcTCIF : Result := 'DET_VALTCI';
        tcTS: Result := 'DET_VAL_TS';
      end;
    End;
Begin

  LqryValGNR := fCriaQuery(AOwner);
  Try
    LqryValGNR.SQL.Clear;
    LqryValGNR.SQL.Add('SELECT IFNULL(T.DET_VLGNRE, 0) AS DET_VLGNRE, ');
    LqryValGNR.SQL.Add('       IFNULL(E.DET_VLRGNR, 0) AS DET_VLRGNR ');
    LqryValGNR.SQL.Add('FROM MOVDET D ');
    LqryValGNR.SQL.Add('INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
    LqryValGNR.SQL.Add('LEFT JOIN GERELE L ON D.DET_NUMDOC = L.GER_DOCENT ');
    LqryValGNR.SQL.Add('                  AND D.DET_ESPDOC = L.GER_ESPENT ');
    LqryValGNR.SQL.Add('                  AND D.DET_SERIE_ = L.B07_SERIE ');
    LqryValGNR.SQL.Add('                  AND D.DET_CODFOR = L.GER_CODFOR ');
    LqryValGNR.SQL.Add('                  AND D.DET_CODEMP = L.GER_CODEMP ');
    LqryValGNR.SQL.Add(' LEFT JOIN DETELE E ON E.DET_SEQGER = L.AUTOINCREM ');
    LqryValGNR.SQL.Add('                  AND D.DET_CODITE = E.DET_CODITE ');
    LqryValGNR.SQL.Add(' WHERE D.AUTOINCREM = :AUTINC');
    LqryValGNR.ParamByName('AUTINC').AsString := strAutInc;
    LqryValGNR.Open;

    If (Not LqryValGNR.IsEmpty) Then
    Begin
      LValGNRMovTri := LqryValGNR.FieldByName('DET_VLGNRE').AsFloat;
      LValGNRDetEle := LqryValGNR.FieldByName('DET_VLRGNR').AsFloat;

      If (fltVlGnre > 0) And (fltVlGnre <> LValGNRMovTri) And (fltVlGnre <> LValGNRDetEle)  Then
        pGravaMemoriaDeCalculo(strAutInc, MSG_VLR_GNR_MANUAL)
      Else
        If (LValGNRMovTri = 0) And (LValGNRDetEle = 0) Then
          pGravaMemoriaDeCalculo(strAutInc, '');
    End;
  Finally
    FreeAndNil(LqryValGNR);
  End;

  qryMovTri := fCriaQuery(AOwner);
  With qryMovTri, SQL Do
  Begin
    Add(' UPDATE MOVTRI ');
    Add(' SET ' + fGetCampo + ' = :VLGNRE,     ');

    Add('     DET_IMPULT = :IMPULT      ');
    Add(' WHERE                         ');
    Add(' DET_SEQGER = :AUTINC          ');

    ParamByName('AUTINC').AsString := strAutInc;
    ParamByName('VLGNRE').AsFloat  := fltVlGnre;
    ParamByName('IMPULT').AsFloat  := fltImpUlt;

    ExecSQL;

  End;
  FreeAndNil(qryMovTri);
end;

Procedure TListGNRE.pCarregaAtpVmb;
  Var
    intCont: Integer;
Begin
  For intCont := 1 to 7 Do
    blnAtpVmb[intCont] := (fCfgSis( IIF( intCont = 1, 'ATPVMB', 'ATPVM' + IntToStr(intCont) )) = 'P');
End;

Function TListGNRE.fUpdateLotePrecos(fltGnre: Double; cdsMovTri: TZClient): Boolean;
  Var
    qryLotPre: TUniQuery;
    intOpcAtu,
    intContador: Integer;
    srtCamAtu: String;
Begin
  qryLotPre := fCriaQuery(Nil);

  With qryLotPre, SQL Do
  Begin
    Add('SELECT * FROM LOTPRE ');
    Add('WHERE');
    Add('  LTP_ATUALI = "N" AND');
    Add('  LTP_CODITE = :CODITE AND');
    Add('  LTP_NUMDOC = :NUMDOC AND');
    Add('  LTP_CODEMP = :CODEMP AND');
    Add('  LTP_ESPDOC = :ESPDOC AND');
    Add('  LTP_CODFOR = :CODFOR AND');
    Add('  LTP_SEQDET = :AUTINC AND');
    Add('  IFNULL(LTP_SERIE_, "") = :SERIE_');

    ParamByName('NUMDOC').AsString := cdsMovTri.FieldByName('DET_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := cdsMovTri.FieldByName('DET_ESPDOC').AsString;
    ParamByName('CODEMP').AsString := cdsMovTri.FieldByName('DET_CODEMP').AsString;
    ParamByName('CODFOR').AsString := cdsMovTri.FieldByName('DET_CODFOR').AsString;
    ParamByName('SERIE_').AsString := cdsMovTri.FieldByName('DET_SERIE_').AsString;
    ParamByName('CODITE').AsString := cdsMovTri.FieldByName('DET_CODITE').AsString;
    ParamByName('AUTINC').AsString := cdsMovTri.FieldByName('AUTOINCREM').AsString;

    Open;

    If (Not IsEmpty) Then
    Begin

      If (cdsMovTri.FieldByName('DET_TOTITE').AsFloat - cdsMovTri.FieldByName('DET_DESESP').AsFloat) > 0 Then
      Begin
        Edit;
        If FTipoChamada = tcTCIF Then
          qryLotPre.FieldByName('LTP_TCIFCU').AsFloat := (fltGnre * 100)/  cdsMovTri.FieldByName('DET_VLRCON').AsFloat
        Else If FTipoChamada = tcTCIF Then
          FieldByName('LTP_TSCUST').AsFloat :=  (fltGnre * 100)/  cdsMovTri.FieldByName('DET_VLRCON').AsFloat
        Else
        Begin
          If FFrmCus = '1' Then
            FieldByName('LTP_SUBSTI').AsFloat := ( ( ( cdsMovTri.FieldByName('DET_VALRET').AsFloat + cdsMovTri.FieldByName('DET_VAERET').AsFloat +
                                                             IIF(cdsMovTri.FieldByName('ORIGEM').AsString = 'T', 0, fltGnre ) ) / (cdsMovTri.FieldByName('DET_TOTITE').AsFloat - cdsMovTri.FieldByName('DET_DESESP').AsFloat +
                                                             cdsMovTri.FieldByName('DET_VALIPI').AsFloat + cdsMovTri.FieldByName('DET_VAEIPI').AsFloat)) * 100 )
          Else
            FieldByName('LTP_SUBSTI').AsFloat := ( ( ( cdsMovTri.FieldByName('DET_VALRET').AsFloat + cdsMovTri.FieldByName('DET_VAERET').AsFloat + IIF(cdsMovTri.FieldByName('ORIGEM').AsString = 'T', 0, fltGnre ) ) /
                                                             (cdsMovTri.FieldByName('DET_TOTITE').AsFloat - cdsMovTri.FieldByName('DET_DESESP').AsFloat) ) * 100 );
        End;



        With cpcParams Do
        Begin
          curPreCom := FieldByName('LTP_PRECOM').AsFloat;
          curDesF01 := FieldByName('LTP_DESF01').AsFloat;
          curDesF02 := FieldByName('LTP_DESF02').AsFloat;
          curDesF03 := FieldByName('LTP_DESF03').AsFloat;
          curDesF04 := FieldByName('LTP_DESF04').AsFloat;
          curDesF05 := FieldByName('LTP_DESF05').AsFloat;
          curDesF06 := FieldByName('LTP_DESF06').AsFloat;
          curICMSEnt:= FieldByName('LTP_ICMENT').AsFloat;
          curIPIEnt := FieldByName('LTP_IPIENT').AsFloat;
          curFrete  := FieldByName('LTP_FREENT').AsFloat;
          curValFre := FieldByName('LTP_VALFRE').AsFloat;
          curAcrFin := FieldByName('LTP_ACRFIN').AsFloat;
          curSubsti := FieldByName('LTP_SUBSTI').AsFloat;
          curDesAdb := FieldByName('LTP_DESADB').AsFloat;
          curSubFed := FieldByName('LTP_SUBFED').AsFloat;

          if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
          begin
            curTCIFCu := FieldByName('LTP_TCIFCU').AsFloat;
            curTSCust := FieldByName('LTP_TSCUST').AsFloat;
            curDePiCo := FieldByName('LTP_DEPICO').AsFloat;
            curDeICMS := FieldByName('LTP_DEICMS').AsFloat;
            curFatReg := FieldByName('LTP_FATREG').AsFloat;
          end
          else
          begin
            curTCIFCu := 0;
            curTSCust := 0;
            curDePiCo := 0;
            curDeICMS := 0;
            curFatReg := 0;
          end;

          FieldByName('LTP_PRECUS').AsFloat := fCalculaPrecoCusto;
        End;

        For intContador := 1 To Length(VS_strTabPrc) Do
        Begin
          intOpcAtu := IIF(blnATPVMB[intContador],  1,           2          );
          srtCamAtu := IIF(blnATPVMB[intContador], 'LTP_PREVE', 'LTP_MARBR' );

          FieldByName(srtCamAtu + IntToStr(intContador) ).AsFloat := fCalculaPrecoVenda(intOpcAtu,
                                                                       FieldByName('LTP_PRECUS').AsFloat + FieldByName('LTP_OUTVAL').AsFloat,
                                                                       FieldByName('LTP_PREVE' + IntToStr(intContador) ).AsFloat,
                                                                       FieldByName('LTP_MARBR' + IntToStr(intContador) ).AsFloat,
                                                                       FieldByName('LTP_ICMSAI').AsFloat,
                                                                       FieldByName('LTP_IMPFED').AsFloat,
                                                                       FieldByName('LTP_DESOPE').AsFloat,
                                                                       FieldByName('LTP_COMTB' + IntToStr(intContador) ).AsFloat);

        End;

        Post;
      End;

      Result := True;

    End

    Else Result := False;

  End;

  FreeAndNil(qryLotPre);
End;

procedure TListGNRE.pAdiciona(strCodFor : String; blnComNFE: boolean; blnDigAposEntrada: Boolean; out blnResult: Boolean);
  Var
    intIdxAdd : Integer;
begin
  intIdxAdd := Self.Add( TGNRE.Create( nil ) );
  TGnre(Self.Items[ intIdxAdd ]).TipoChamada := TipoChamada;

  TGnre(Self.Items[ intIdxAdd ]).cdsItens := FItensLis;
  TGnre(Self.Items[ intIdxAdd ]).strForDoc := FForDoc;

  if TGnre(Self.Items[ intIdxAdd ]).fTelaGnre(strCodFor, False, blnComNFE, True, blnDigAposEntrada) Then
  Begin
    pInserir( TGnre(Self.Items[ intIdxAdd ]) );
    blnResult := True;
  End
  Else
  Begin
    Self.Delete(intIdxAdd);
    blnResult := False;
  End;
end;

procedure TListGNRE.pAtualizaPreco(fltPreCom: Double; strCodIte: String; strCodEmp: String);
  var
    blnAtuPis,
    blnAtuDIC,
    blnInfMat,
    blnAltPre: Boolean;
    fltPreCus: Double;
    qryConIte,
    qryEntMer: TUniQuery;
    recPrecos: TarrPrecos;
    arrAtpVmb: TarrATPVMB;
    intTabPre: Integer;
    strEmpresas: String;
    intInfFed,
    intInfSai,
    intInfOpe,
    intDecUni:  integer;


    function fItem(strCampo: String): TField;
    begin
      Result := qryConIte.FieldByName('ITE_' + strCampo);
    end;
begin
  qryEntMer := fCriaQuery;
  qryConIte := fCriaQuery;
  blnInfMat := fCfgSis('INFMAT', varBoolean);
  intInfFed := fCfgSis('INFFED', varInteger);
  intInfSai := fCfgSis('INFSAI', varInteger);
  intInfOpe := fCfgSis('INFOPE', varInteger);
  intDecUni := fCfgSis('DECUNI', varInteger);
  blnAtuPis := fCfgSis('ATUPIS', varBoolean) And fSeparaICMDesoneradoDoDesconto;
  blnAtuDIC := fCfgSis('ATUDIC', varBoolean) And fSeparaICMDesoneradoDoDesconto;


  Try
     For intTabPre := 1 to 7 Do
       blnAtpVmb[intTabPre] := (fCfgSis( IIF( intTabPre = 1, 'ATPVMB', 'ATPVM' + IntToStr(intTabPre) )) = 'P');

    qryEntMer.SQL.Add('SELECT');
    {$Region 'sql Na Iteger para Pegar os valores de composição do custo'}
    qryEntMer.SQL.Add('I.ITE_CODITE AS ENT_CODITE,');

    qryEntMer.SQL.Add('ITE_DESOPE AS ENT_DESOPE,');
    qryEntMer.SQL.Add('ITE_DESADB AS ENT_DESADB,');
    qryEntMer.SQL.Add('ITE_DESF01 AS ENT_DESF01,');
    qryEntMer.SQL.Add('ITE_DESF02 AS ENT_DESF02,');
    qryEntMer.SQL.Add('ITE_DESF03 AS ENT_DESF03,');
    qryEntMer.SQL.Add('ITE_DESF04 AS ENT_DESF04,');
    qryEntMer.SQL.Add('ITE_DESF05 AS ENT_DESF05,');
    qryEntMer.SQL.Add('ITE_DESF06 AS ENT_DESF06,');
    qryEntMer.SQL.Add('ITE_ICMENT AS ENT_ICMENT,');
    qryEntMer.SQL.Add('ITE_IPIENT AS ENT_IPIENT,');
    qryEntMer.SQL.Add('ITE_FREENT AS ENT_FREENT,');
    qryEntMer.SQL.Add('ITE_VALFRE AS ENT_FREITE,');
    qryEntMer.SQL.Add('ITE_ACRFIN AS ENT_ACRFIN,');
    qryEntMer.SQL.Add('ITE_SUBSTI AS ENT_SUBSTI,');
    qryEntMer.SQL.Add('ITE_DESADB AS ENT_DESADB,');
    qryEntMer.SQL.Add('ITE_SUBFED AS ENT_SUBFED,');
    qryEntMer.SQL.Add('ITE_ICMSAI AS ENT_ICMSAI,');
    qryEntMer.SQL.Add('ITE_IMPFED AS ENT_IMPFED,');
    qryEntMer.SQL.Add('ITE_DESOPE AS ENT_DESOPE,');
    qryEntMer.SQL.Add('ITE_RPRENT AS ENT_RPRENT,');

    qryEntMer.SQL.Add('ITE_TCIFCU AS ENT_TCIFCU,');
    qryEntMer.SQL.Add('ITE_TSCUST AS ENT_TSCUST,');
    qryEntMer.SQL.Add('ITE_DEPICO AS ENT_DEPICO,');
    qryEntMer.SQL.Add('ITE_DEICMS AS ENT_DEICMS,');
    qryEntMer.SQL.Add('ITE_FATREG AS ENT_FATREG,');

    qryEntMer.SQL.Add('ITE_MARBR1 AS ENT_MARBR1,');
    qryEntMer.SQL.Add('ITE_PREVE1 AS ENT_PREVE1,');
    qryEntMer.SQL.Add('ITE_COMTB1 AS ENT_COMTB1,');

    qryEntMer.SQL.Add('ITE_MARBR2 AS ENT_MARBR2,');
    qryEntMer.SQL.Add('ITE_PREVE2 AS ENT_PREVE2,');
    qryEntMer.SQL.Add('ITE_COMTB2 AS ENT_COMTB2,');

    qryEntMer.SQL.Add('ITE_MARBR3 AS ENT_MARBR3,');
    qryEntMer.SQL.Add('ITE_PREVE3 AS ENT_PREVE3,');
    qryEntMer.SQL.Add('ITE_COMTB3 AS ENT_COMTB3,');

    qryEntMer.SQL.Add('ITE_MARBR4 AS ENT_MARBR4,');
    qryEntMer.SQL.Add('ITE_PREVE4 AS ENT_PREVE4,');
    qryEntMer.SQL.Add('ITE_COMTB4 AS ENT_COMTB4,');

    qryEntMer.SQL.Add('ITE_MARBR5 AS ENT_MARBR5,');
    qryEntMer.SQL.Add('ITE_PREVE5 AS ENT_PREVE5,');
    qryEntMer.SQL.Add('ITE_COMTB5 AS ENT_COMTB5,');

    qryEntMer.SQL.Add('ITE_MARBR6 AS ENT_MARBR6,');
    qryEntMer.SQL.Add('ITE_PREVE6 AS ENT_PREVE6,');
    qryEntMer.SQL.Add('ITE_COMTB6 AS ENT_COMTB6,');

    qryEntMer.SQL.Add('ITE_MARBR7 AS ENT_MARBR7,');
    qryEntMer.SQL.Add('ITE_PREVE7 AS ENT_PREVE7,');
    qryEntMer.SQL.Add('ITE_COMTB7 AS ENT_COMTB7,');
    qryEntMer.SQL.Add('ITE_OUTVAL AS ENT_OUTVAL,');

    qryEntMer.SQL.Add('ITE_PREVE1');
    qryEntMer.SQL.Add('FROM ITEGER G');
    qryEntMer.SQL.Add('INNER JOIN CADITE I ON G.ITE_CODITE = I.ITE_CODITE');
    qryEntMer.SQL.Add('WHERE G.ITE_CODITE = :CODITE');
    qryEntMer.SQL.Add('  AND G.ITE_CODEMP = :CODEMP');
    {$ENDREGION}

    qryEntMer.ParamByName('CODITE').AsString := strCodIte;
    qryEntMer.ParamByName('CODEMP').AsString := strCodEmp;


    qryEntMer.Open;

    qryConIte.SQl.Add('SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
    qryConIte.ParamByName('CODITE').AsString := strCodIte;
    qryConIte.ParamByName('CODEMP').AsString := strCodEmp;

    qryConIte.Open;


    For intTabPre := 1 To length(recPrecos) Do
    Begin
      recPrecos[intTabPre].fltPreVen := qryEntMer.FieldByName('ENT_PREVE' + IntToStr(intTabPre)).AsFloat;
      recPrecos[intTabPre].fltMarBru := qryEntMer.FieldByName('ENT_MARBR' + IntToStr(intTabPre)).AsFloat;
      recPrecos[intTabPre].fltComiss := qryEntMer.FieldByName('ENT_COMTB' + IntToStr(intTabPre)).AsFloat;
    End;


    pRecalculaPrecos(recPrecos,
                     fltPreCus,
                     blnAltPre,
                     cpcParams,
                     fltPreCom,
                     nil,
                     qryEntMer,
                     False,
                     arrAtpVmb);

    strEmpresas := fRetEmpresasUsamPrecoMatriz;
    pAtualizaPrecos(strEmpresas, qryEntMer, recPrecos, fltPreCom, fltPreCus, 1, False, blnInfMat,
                    blnAtuPis, blnAtuDIC, intInfFed, intInfSai, intInfOpe, intDecUni, strAgrupadorPreAlt);


    If blnInfMat And fEhEmpresaResponsavelFornecedor(fRetFornecedorItem(strCodIte)) Then
       pAtualizaPrecos(strEmpresas, qryEntMer, recPrecos, fltPreCom, fltPreCus, 1, True, blnInfMat,
                                  blnAtuPis, blnAtuDIC, intInfFed, intInfSai, intInfOpe, intDecUni, strAgrupadorPreAlt);
    if (Not VS_blnPreAltViaTrigger) Then
      fGravaPreAlt(strCodIte,

                           fItem('PRECUS').AsFloat,
                           fltPreCus,

                           fItem('PREVE1').AsFloat,
                           recPrecos[01].fltPreVen,

                           fItem('MARBR1').AsFloat,
                           recPrecos[01].fltMarBru,

                           fItem('PREVE2').AsFloat,
                           recPrecos[02].fltPreVen,

                           fItem('MARBR2').AsFloat,
                           recPrecos[02].fltMarBru,

                           fItem('PREVE3').AsFloat,
                           recPrecos[03].fltPreVen,

                           fItem('MARBR3').AsFloat,
                           recPrecos[03].fltMarBru,

                           fItem('PREVE4').AsFloat,
                           recPrecos[04].fltPreVen,

                           fItem('MARBR4').AsFloat,
                           recPrecos[04].fltMarBru,

                           fItem('PREVE5').AsFloat,
                           recPrecos[05].fltPreVen,

                           fItem('MARBR5').AsFloat,
                           recPrecos[05].fltMarBru,

                           fItem('PREVE6').AsFloat,
                           recPrecos[06].fltPreVen,

                           fItem('MARBR6').AsFloat,
                           recPrecos[06].fltMarBru,

                           fItem('PREVE7').AsFloat,
                           recPrecos[07].fltPreVen,

                           fItem('MARBR7').AsFloat,
                           recPrecos[07].fltMarBru,

                           fItem('PRECOM').AsFloat,
                           fltPreCom,

                           'GNRE APOS ENTRADA DE MERCADORIAS',

                           Nil,
                           '',
                           strLoginUsuarioLogado);

    pAtualizaItensGrupoPrecos(strCodIte, 'GNRE APOS ENTRADA DE MERCADORIAS', strAgrupadorPreAlt);
   

  Finally
    FreeAndNil(qryConIte);
    FreeAndNil(qryEntMer);
  end;

end;

procedure TListGNRE.pInserir(objGNRE: TGNRE; blnEditar: Boolean = False);
begin
  With FqryDados, objGNRE Do
  Begin
    If blnEditar Then
      Edit
    Else
      Append;

    FieldByName('GNR_I_E_S_').AsString := strI_E_S_;

    if not fEmptyDate(strDtaGnr) Then
      FieldByName('GNR_DTAGNR').AsDateTime := StrToDate( strDtaGnr )
    Else
      FieldByName('GNR_DTAGNR').Clear;

    FieldByName('GNR_ESTFAV').AsString := strEstFav;
    FieldByName('GNR_BCOGNR').AsString := strBcoGnr;
    FieldByName('GNR_NUMGNR').AsString := strNumGnr;
    FieldByName('GNR_VALGNR').AsFloat  := fStrToFloat(strValGnr);

    if not fEmptyDate(strDtaVen) Then
      FieldByName('GNR_DTAVEN').AsDateTime  := StrToDate( strDtaVen )
    Else
      FieldByName('GNR_DTAVEN').Clear;

    FieldByName('GNR_MESANO').AsString := strMesAno;
    FieldByName('GNR_CONPRO').AsString := strConPro;
    FieldByName('GNR_AGEGNR').AsString := strAgeGnr;
    FieldByName('GNR_CODCTA').AsString := strCodCta;

    If fEmptyStr(strCodEve) Then
      FieldByName('GNR_CODEVE').Clear
    Else
     FieldByName('GNR_CODEVE').AsString := strCodEve;

    FieldByName('GNR_CODFOR').AsString := strCodFor;
    FieldByName('GNR_AUTBAN').AsString := strAutBan;
    FieldByName('GNR_FORDOC').AsString := strForDoc;
    FieldByName('GNR_SERIE_').AsString := strSerie ;
    FieldByName('GNR_ESPDOC').AsString := strEspDoc;
    FieldByName('GNR_NUMDOC').AsString := strNumDoc;
    FieldByName('GNR_BASCAL').AsFloat  := fStrToFloat(strBasCal);
    FieldByName('GNR_TIPGUI').AsString := strTipGui;
    FieldByName('GNR_CODREC').AsString := strCodRec;

    If Not blnEditar Then
    Begin
      FieldByName('GNR_INSERT').AsString := 'S';
      pSetQtdIns( intQtdInsert + 1 );
      intSeqReg := intQtdInsert;
      FieldByName('GNR_SEQREG').AsInteger := intQtdInsert;
    End;

    Post;
  End;

end;

procedure TListGNRE.pCarregaListaGnre(strAutFis: String);
  Var
    intIdxAdd : Integer;
begin
  With FqryDados Do
  Begin
    pLimpaLista;

    qryQuery.Close;
    qryQuery.ParamByName('AUTFIS').AsString := strAutFis;

    fAbreClient(True, 'TListGNRE.pCarregaListaGnre');

    TFloatField(FieldByName('GNR_VALGNR')).DisplayFormat := '#,##0.00';

    Try
      DisableControls;
      First;
      While not Eof Do
      Begin
        intIdxAdd := Self.Add( TGNRE.Create( Owner ) );
        TGNRE(Self.Items[intIdxAdd]).TipoChamada := FTipoChamada;
        TGNRE(Self.Items[intIdxAdd]).pCarregaGnre(FieldByName('AUTOINCREM').AsString);
        Next;

      End;
    Finally
      First;
      EnableControls;
    end;

  End;

end;

Function TListGNRE.fEncontraGNRE(var intIndice: Integer; strOrigem: string): Boolean;
  Var
    intIndex : Integer;
Begin
  Result := False;
  intIndice := -1;

  For intIndex := 0 To Self.Count - 1 Do
  Begin

    If TGnre(Self.Items[ intIndex ]).TipoChamada in [tcTCIF, tcTS] Then
    Begin
      If ((TGnre(Self.Items[ intIndex ]).strAutoin = FqryDados.FieldByName('AUTOINCREM').AsString) And
          (Not fEmptyStr(FqryDados.FieldByName('AUTOINCREM').AsString ))) Or

         ((TGnre(Self.Items[ intIndex ]).intSeqReg = FqryDados.FieldByName('GNR_SEQREG').AsInteger) And
          (FqryDados.FieldByName('GNR_SEQREG').AsInteger > 0)) Then
      Begin
        TGnre(Self.Items[ intIndex ]).cdsItens := FItensLis;

        Result := True;
        intIndice := intIndex;
        Break;
      End;
    End
    Else
    Begin
      If ((TGnre(Self.Items[ intIndex ]).strAutoin = FqryDados.FieldByName('AUTOINCREM').AsString) And
          (TGnre(Self.Items[ intIndex ]).fRetTipoChamatoToChar = FqryDados.FieldByName('GNR_ORIGEM').AsString) And
          (Not fEmptyStr(FqryDados.FieldByName('AUTOINCREM').AsString ))) Or

         ((TGnre(Self.Items[ intIndex ]).intSeqReg = FqryDados.FieldByName('GNR_SEQREG').AsInteger) And
          (FqryDados.FieldByName('GNR_SEQREG').AsInteger > 0)) Then
      Begin
        FItensLis.Filtered := False;
        FItensLis.Filter := 'ORIGEM = ' + QuotedStr(FqryDados.FieldByName('GNR_ORIGEM').AsString);
        FItensLis.Filtered := True;
        TGnre(Self.Items[ intIndex ]).cdsItens := FItensLis;

        Result := True;
        intIndice := intIndex;
        Break;
      End;
    End;
  End;
End;

procedure TListGNRE.pEdita(blnEdicao: Boolean; strOrigem: string);
  Var
    intIndex : Integer;
begin
  If Not fEncontraGNRE(intIndex, strOrigem) Then
    Exit;

  if TGnre(Self.Items[ intIndex ]).fTelaGnre('', blnEdicao) Then
  Begin
    pInserir(TGnre(Self.Items[ intIndex ]), True);
    pSetQtdIns(FQtdIns + 1);
  End;
end;

Function TListGNRE.fExclui(strOrigem: string): Boolean;
  Var
    intIndex : Integer;
Begin
  Result := False;

  If Not fEncontraGNRE(intIndex, strOrigem) Then
    Exit;

  TGnre(Self.Items[ intIndex ]).FExcluida := True;
  Result := True;
End;


procedure TListGNRE.pLimpaLista;
  Var
    intContador : Integer;
begin
  pSetQtdIns(0);
  FqryDados.EmptyDataSet;
  For intContador := Self.Count -1 Downto 0 Do
    Self.Delete(intContador);
end;

procedure TListGNRE.pSetQtdIns(intNewValue: Integer);
begin
  FQtdIns := intNewValue;

  if Assigned(FNotifyIns)then
    FNotifyIns(Self);
end;

function TListGNRE.fCampoFCPST(blnComNFE: Boolean): String;
Begin
  Result := '   0.0000 AS VFCPST, ';
  if blnIFCPST THen
    If blnComNFE Then
      Result := '   DE.N23D_FCPST AS VFCPST, ';
End;

procedure TListGNRE.pGravaMemoriaDeCalculo(ADetAutInc: String; AMemCalGnr: String);
Var
  LqryMemGnr: TUniQuery;
  LQtd: Integer;
Begin
  LqryMemGnr := fCriaQuery(Nil);

  Try
    LqryMemGnr.Close;
    LqryMemGnr.SQL.Clear;

    LqryMemGnr.SQL.Add('SELECT COUNT(1) AS QTD FROM CALGNR WHERE DET_SEQDET = :SEQDET');
    LqryMemGnr.ParamByName('SEQDET').AsString := ADetAutInc;
    LqryMemGnr.Open;
    LQtd := LqryMemGnr.FieldByName('QTD').AsInteger;
    LqryMemGnr.Close;
    LqryMemGnr.SQL.Clear;

    If (LQtd = 0) Then
    Begin
      LqryMemGnr.SQL.Add('INSERT INTO CALGNR (DET_SEQDET, CAL_MEMCAL) ');
      LqryMemGnr.SQL.Add('VALUES (:SEQDET, :CALGNR) ');
    End
    Else
    Begin
      LqryMemGnr.SQL.Add('UPDATE CALGNR SET ');
      LqryMemGnr.SQL.Add('      CAL_MEMCAL = :CALGNR ');
      LqryMemGnr.SQL.Add('WHERE DET_SEQDET  = :SEQDET');
    End;

    LqryMemGnr.ParamByName('SEQDET').AsString := ADetAutInc;
    LqryMemGnr.ParamByName('CALGNR').AsString := AMemCalGnr;

    Try
      LqryMemGnr.ExecSQL;
    Except
      On E : Exception Do
      Begin
        pMensagensErro(E.Message, 'TGNRE.pGravaMemoriaDeCalculo');
      End;
    End;

  Finally
    FreeAndNil(LqryMemGnr);
  End;
end;

function TGNRE.fExtrairValorMemCalcGNRE(AMemCal: String): Double;
Var
  LPosIgual: Integer;
  LSubTexto: String;
Begin
  LPosIgual := LastDelimiter('=', AMemCal);

  If (LPosIgual > 0) Then
  Begin
    LSubTexto := Trim(Copy(AMemCal, LPosIgual + 1, Length(AMemCal)));
    //LSubTexto := StringReplace(LSubTexto, '.', '', [rfReplaceAll]);
    Result := StrToFloatDef(LSubTexto, 0.0);
  End
  Else
    Result := 0.0;
End;

end.
