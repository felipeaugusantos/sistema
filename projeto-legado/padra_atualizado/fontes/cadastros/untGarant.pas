{*******************************************}
{* CLASSE PARA GARANTIA                    *}
{* DATA: 03/12/2007                        *}
{* AUTOR: RICARDO DE LIMA                  *}
{****************************************RL*}

unit untGarant;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, EditFocus, MaskEditFocus, untTypesSistema,
    Variants, UniClientDataSet, UniDataSetProvider, Controls, untFuncoesSimples, DateUtils,
    Math, untFuncFat, untZClient, untFuncFatTypes, untAuditoriaGravacaoSaldo;

const
  sqlItensParaAtualizar = 'SELECT GAD_CODITE, GAD_CODEMP, GAD_NUMLOT          '+
                          '  FROM MOVGAD                                      '+
                          ' WHERE IF(:SEQGAG <> "", GAD_SEQGAG = :SEQGAG, TRUE)'+
                          '   AND IF(:INCREM <> "", AUTOINCREM IN (:INCREM), TRUE)'+
                          '   AND IF(:ITENS <> "", GAD_CODITE IN (:ITENS), TRUE)';

  SEQDET_BAIXA_DEVOLUCAO_ENVIO = 'BAIXA_D';

Type
  TTipoRelatorio = (trAnalitico, trSintetico);
  EGarantQtdReqInvalido = Exception;
  TReposicaoEntregaRetira = (trEntrega = 1, trRetira);
  TReposicaoEntregaRetiraHelper = Record Helper for TReposicaoEntregaRetira
    function AsString_S_N: String;
  end;
  {$SCOPEDENUMS ON}
  TFiltroSqlProdutoRetornado = (fprPeriodoDatas, fprIncGad, fprMultiplosIncGad);
  {$SCOPEDENUMS OFF}
  TSetFiltroSqlProdutoRetornado = Set of TFiltroSqlProdutoRetornado;

{*******************************************}
{* MOVGAD                                  *}
{****************************************RL*}
Type
  TMovGad = Class(TComponent)
  Type
      TTipoRetorno = (trRetorno, trRefugo, trRefent);
      TSetTipoRetorno = Set of TTipoRetorno;
  Private
    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;
    class function fBaixaPedidoVendaAutIncMovGad(strAutIncMovGad, strNumFat,
      strTipFat: String): Boolean; static;
  Public

    qryMovGad : TUniQuery;
    qryFornec : TUniQuery;
    qryCliente: TUniQuery;
    stlIncGau: TStringList;
    dtsMovGad: TDataSource;

    // variaveis garantia CRM
    intPrazo : Integer;
    intDias : Integer;
    dtaLimite : TDate;
    blnTemGarantia : Boolean;
    blnMaisDeUmAno:Boolean;

    procedure pApagaMovGau;
    function fCriarGAGRFG(pstrCodFor: String; out pstrIncRFG: String): Boolean;
    function fGravarGAGRFD(pstrAutInc, pstrIncGau, pstrIncGae: String; pfltQtdRet, pfltQtdRef,pfltQtdBai: Double): Boolean;
    function fGravaMovGad(strSeqGag     : String;
                          Var strAutInc : String;
                          strNumDoc,
                          strEspDoc,
                          strEmpDoc,
                          strRepost,
                          strCodIte: String;
                          fltValIte,
                          fltQtdReq,
                          fltQtdDev,
                          fltQtdPre,
                          fltQtdRet,
                          fltQtdRef: Double;
                          strObsP_1,
                          strObsP_2,
                          strGarFil: String;
                          strNumLot:String = '';
                          blnGerouCredito: boolean = False;
                          strCodFor : String = '';
                          strSeqDoc : String = '';
                          fltUniCrd: Double = 0): Boolean;

    function fCarregaDocVendas(qryTmp: TUniQuery; strCodCli,
      strCodIte: String; blnDevolu: Boolean = True; strPlaVei : String = ''): Boolean;
    function fDeletaMovGad(strSeqGag, strAutInc, strCodIte: String): Boolean;
    Class function fAtualizaProdutosTrocaEspelhoConfirmacao(strIncEspGer, strNumero, strEspDoc, strSerDoc, strCodEmp: String; enuTipoEnvioFornecedorGarantia : TTipoEnvioFornecedorGarantia): Boolean;
    function fAtualizaProdutosTroca(cdsProdutos: TUniClientDataSet;
                                    strNumero, strEspDoc, strSerDoc, strCodEmp: String;
                                    enuTipoEnvioFornecedorGarantia : TTipoEnvioFornecedorGarantia = tefNulo;
                                    cdsGroup : TUniClientDataSet = nil): Boolean;
    procedure pAtualizaProdutoRetornados(cdsProdutos           : TUniClientDataSet;
                                        strNumero: String;
                                        blnBaixar             : Boolean = False;
                                        blnSoQtdeTemporaria   : Boolean = False);

    function fGravarDocRFG(Var pstrIncRFG: String; pstrCodFor: String; pTipoRetorno: TTipoRetorno; pblnBaixa: Boolean;
        pstrIncGau, pstrIncGae: String;const pfltQtdRet, pfltQtdRef: Double): Boolean;

    function fAtualizaProdutosDevolucao(cdsProdutos: TUniClientDataSet; strNumero: String; strEspDoc : String): Boolean;overload;
    class function fSQLInsereTabelaAux : String;
    function fAtualizaTabelaAux(strCodIte,strSeqDet:String): Boolean;
    function fCarregaProdutosNaoEnviadoFornec(strDescri,
                                              strRefere,
                                              strDtaIni,
                                              strDtaFin: String;
                                              edtCodFor,
                                              edtCodMar: TEditFocus;
                                              mskLinGru: TMaskEditFocus;
                                              arrFornecedor,
                                              arrMarca,
                                              arrLinhaGrupo: TConsultasArray;
                                              Var qryProdNaoEnv: TUniQuery): Boolean;

    procedure pCarregaMovGad(strSeqGag: String);
    class procedure pGravaRelacionamentoMovGae(strNumero, strEspDoc, strSerDoc, strCodEmp, strAutIncMovGae: String; VS_Date: TDate);
    procedure pCarregaProdutosTroca(strCodFor: String; edtMarca : TEditFocus; arrMarca : TConsultasArray);
    procedure pCarregaProdutosRetornados(strCodFor: String; dtaDtaIni,
      dtaDtaFin: TDatetime; blnCpoSel: Boolean = False;  AAutIncGerele: String = '');
    Class function fSqlProdutosRetornadosFornecedor(pblnCpoSel: Boolean; pFiltrosSql: TSetFiltroSqlProdutoRetornado = [TFiltroSqlProdutoRetornado.fprPeriodoDatas]; AAutoincrem: String = ''): String;
    procedure pCarregaProdutosDevolucao(strCodCli: String; blnFavorecido: Boolean = False);
    procedure pCarregaDadosGarantia(strCodIte:String; dtaMovimento:TDate=0);

    function fAtualizaSeqGarantia(strColuna, strValCol, strNomFil, strValFil: String): Boolean;
    function fBaixaPedidoVenda(cdsProdutos: TUniClientDataSet; strNumFat,
      strTipFat: String): Boolean;
    function fRetornaSeqGarantia(strColuna, strNomFil, strValFil: String): String;

    function fGetSqlUltimaCompra: String;

    class procedure pBaixaGarantiaNoEnvio(strSeqGad, strSeqGae, strEspDoc, strCodIte: String; fltQuantidade: Double);

    procedure pCarregaProdutosRetornadosConserto(strCodFor: String; dtaDtaIni, dtaDtaFin: TDatetime);
    class function fTestarGravacaoMovGae(strListaMovGae: String): Boolean;
    class function fAtualizaProdutosDevolucao(const strIncGad, strNumero : String; const fltQtdDev, fltQtdPre: Double; blnCancelar: boolean = false): Boolean;overload;
    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;
    class function fCriarMovGaeTemporaria: Boolean;
    class procedure pApagarMovGaeTemporaria;
    class function fGravarGaeTemporaria(const pstrAutInc,
                                              pstrIncGad: String;
                                        const pfltQtdEnv,
                                              pfltPreCus: Double;
                                        const pdtaDtaEnv: TDate): Boolean;
    class function fAtualizaAutIncEnvioGaeTemporaria(const pstrAutInc,
                                                           pstrIncEnv: String): Boolean;

  End;

{*******************************************}
{* MOVGAG                                  *}
{****************************************RL*}

Type
  TMovGag = Class(TComponent)
  Private
    FNumEnt: String;
    FCodCli: String;
    FNomCli: String;
    FNomFor: String;
    FCodVen: String;
    FNomVen: String;
    FCodEmp: String;
    FAutInc: String;
    FDtaEnt: TDateTime;
    //Cliente Favorecido Crédito Garantia
    FCodFav: String;
    FGarInd: String;
    FSeqGor: String;
    {***********************************}
    {* DADOS DO CONSUMIDOR NA GARANTIA *}
    {*********************************FC}
    FstrNomCon: String;
    FstrEndCon: String;
    FstrBaiCon: String;
    FstrCepCon: String;
    FstrCidCon: String;
    FstrEstCon: String;
    FstrTelCon: String;
    FstrCgcCon: String;
    FstrRg_Con: String;
    FintCgcCpf: Integer;
    FstrIesCon: String;
    FstrEmaCon: String;
    FstrNomCid: String;
    FstrCodAti: String;
    FstrNomAti: String;
    FstrIncCTR: String;

    function getNomCli: String;
    function getNomVen: String;
    function getNomCid: String;
    function getNomAti: String;
  Public

    qryMovGag: TUniQuery;
    dtsMovGag: TDataSource;

    qryRelatorio: TUniQuery;

    objMovGad: TMovGad;

    edtDesGru  : TEditFocus;
    edtDesMar  : TEditFocus;
    edtDesIte  : TEditFocus;

    edtMarca  : TEditFocus;
    mskLinGru : TMaskEditFocus;
    edtProduto: TEditFocus;

    strMarca,
    strProduto,
    strLinGru: String;

    arrProduto   : TConsultasArray;
    arrMarca     : TConsultasArray;
    arrLinGru    : TConsultasArray;

    function fGravaMovGag(dtaDtaEnt: TDateTime;
                          strCodVen,
                          strCodCli,
                          strCodFav,
                          strNumDup: String;
                          blnGerarGarNovaForc: Boolean = False;
                          strCodEmpGag: String = '';
                          strObs1: String = '';
                          strObs2: string = ''): Boolean;

    function fAlteraSemelhante(strAutInc, strCodFab: String): Boolean;
    function fRetornaSemelhante(strCodIte: String; var strCodFab: String): Boolean;
    procedure pCarregaMovGag(strNumEnt: String; strCodEmpGag: String = '');
    procedure pLimpaDadosGag;
    procedure pAtuDadosGag;
    procedure pDeletaGarantia(strSeqGag: String);
    procedure pCancelaGarantia;
    function fLimpar: Boolean;
    function fCreditoGerado: Boolean;
    function fVincularCredito(pstrIncGag, pstrIncCTR: String): Boolean;
    class function fVincularCreditoAGarantia(pstrAutInc, pstrIncCTR: String; pblnRecCliente: Boolean = False): Boolean;
    function fVincularGarantiaACADREC(pstrIncGER, pstrIncCTR: String): Boolean;

    class function fInsereMovGrc(strAutIncSeqGad,
                                 strAutIncSeqDet,
                                 strOpcDoc,
                                 strTipMod,
                                 strIncOri: String; blnPedido: Boolean = False): Boolean;

    class function fGetOpcDocFromMovGrc(strAutIncGer: String): String;
    class function fVincularPedidoReposicao(const strIncGag, strIncGor: String): Boolean;
    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;

    property strNumEnt: String    Read FNumEnt   Write FNumEnt;
    property strCodCli: String    Read FCodCli   Write FCodCli;
    property strNomCli: String    Read getNomCli Write FNomCli;
    property strCodVen: String    Read FCodVen   Write FCodVen;
    property strNomVen: String    Read getNomVen Write FNomVen;
    property strCodEmp: String    Read FCodEmp   Write FCodEmp;
    property strAutInc: String    Read FAutInc   Write FAutInc;
    property dtaDtaEnt: TDateTime Read FDtaEnt   Write FDtaEnt;
    property strCodFav: String    Read FCodFav   Write FCodFav;
    property strGarInd: String    Read FGarInd   Write FGarInd;
    property strSeqGor: String    Read FSeqGor   Write FSeqGor;
    {***********************************}
    {* DADOS DO CONSUMIDOR NA GARANTIA *}
    {*********************************FC}
    property strNomCon: String  Read FstrNomCon Write FstrNomCon;
    property strEndCon: String  Read FstrEndCon Write FstrEndCon;
    property strBaiCon: String  Read FstrBaiCon Write FstrBaiCon;
    property strCepCon: String  Read FstrCepCon Write FstrCepCon;
    property strCidCon: String  Read FstrCidCon Write FstrCidCon;
    property strEstCon: String  Read FstrEstCon Write FstrEstCon;
    property strTelCon: String  Read FstrTelCon Write FstrTelCon;
    property strCgcCon: String  Read FstrCgcCon Write FstrCgcCon;
    property strRg_Con: String  Read FstrRg_Con Write FstrRg_Con;
    property intCgcCpf: Integer Read FintCgcCpf Write FintCgcCpf;
    property strIesCon: String  Read FstrIesCon Write FstrIesCon;
    property strEmaCon: String  Read FstrEmaCon Write FstrEmaCon;
    property strNomCid: String  Read getNomCid  Write FstrNomCid;
    property strCodAti: String  Read FstrCodAti Write FstrCodAti;
    property strNomAti: String  Read getNomAti  Write FstrNomAti;
    property strIncCTR: String  Read FstrIncCTR;

  End;
  procedure pCarregaDadosClienteGarantia(strCodCli: String; objFatVendas : TFatVenda);
  function fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
  function fGetSqlSelNotas(blnComFil, blnEmpMat: Boolean): String;
  procedure pAtualizaLoteMovGad(strNumPed, strEmpPed: String);
  function fObterValorSeqGar(const strValCol, strColFil, strValFil: String): String;

  function fBaixaGarantiaReprovada(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  function fEstornaBaixaGarantiaReprovada(strFdoInc: String): Boolean;
  procedure pVerificarSeExisteItemEmProcessoGarantia(const strNumDoc, strEspDoc, strCodEmp: String);
  function fGerarHistoricoCredito(arrIncGad: Array of String): String;
  function fScriptValIte(strAliasMovDet: String): String;
  function fScriptValCredito(strAliasMovDet: String; strAliasMovTri: String): String;

  function fEhPedidoTransferenciaGarantiaGarMat(strAutInc: String): Boolean;overload;
  function fEhPedidoTransferenciaGarantiaGarMat(stlPedidos: TStringList; strPedidosParciais: String; out strPedidoTransfGarant: String): Boolean;overload;
  function fReposicaoEntregaRetira: TReposicaoEntregaRetira;
  function fValidarDocumentoOrigemGarantia(pstrIncGad, pstrIncOri: String): Boolean;

implementation

uses untFuncoes, untModuloSPR,untCfgRel, untMovGer,
     untCadIte, untConstantes, untGarantSemelhante, untFuncoesConsulta,
     untCadLote, untIFatReservaSaldo, untTFatReservaSaldo,
     System.Types, untModulo, untLiberacao;

{ TGarant }

constructor TMovGag.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  qryMovGag    := fCriaQuery(Self);
  dtsMovGag    := fCriaDataSource(qryMovGag);
  qryRelatorio := fCriaQuery(Self);
  objMovGad    := TMovGad.Create(Self);

  pLimpaDadosGag;

end;

destructor TMovGag.Destroy;
begin

  FreeAndNil(qryMovGag);
  FreeAndNil(qryRelatorio);
  FreeAndNil(objMovGad);

  inherited Destroy;
end;

class function TMovGag.fGetOpcDocFromMovGrc(strAutIncGer: String): String;
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  Result := '';

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   GRC_OPCDOC ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   MOVGER G ';
  strSQL := strSQL + ' JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + ' JOIN MOVGRC R ON R.GRC_SEQDET = D.AUTOINCREM ';
  strSQL := strSQL + ' WHERE G.AUTOINCREM = :AUTINC ';

  Try
    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString := strAutIncGer;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('GRC_OPCDOC').AsString;
    End;
  Except
    On E: Exception Do
    Begin
      fMensagem('', E.Message + '[TMovGag.fGetOpcDocFromMovGrc]', ['&O K']);
    End;
  End;

  FreeAndNil(qryTmp);
end;

{*******************************************}
{* GRAVA MOVGAG                            *}
{****************************************RL*}
function TMovGag.fGravaMovGag(dtaDtaEnt: TDateTime;
                              strCodVen,
                              strCodCli,
                              strCodFav,     //cliente favorecido crédito
                              strNumDup: String;
                              blnGerarGarNovaForc: Boolean = False;
                              strCodEmpGag: String = '';
                              strObs1: String = '';
                              strObs2: string = ''): Boolean;
begin
  Self.FstrIncCTR := EmptyStr;
  Try

    With qryMovGag Do
    Begin

      If Not Active Then
        pCarregaMovGag(strNumEnt, strCodEmpGag);

      If (Not Locate('AUTOINCREM', strAutInc, [])) Or (blnGerarGarNovaForc) Then
      Begin
        Append;
        FieldByName('GAG_NUMENT').AsString := fAtualizaProCod('MOVGAG', 'GAG_NUMENT', '', 1, Nil,
          function (const AValue: String) : String
          begin
            Result := fStrZero(AValue, fTamDocCadRec);
          end
        );

        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MOVGAG', VS_strCodEmp);
        FieldByName('GAG_CODEMP').AsString := VS_strCodEmp;
      End
      Else
        Edit;


      dtaDtaEnt := EncodeDateTime(YearOf(dtaDtaEnt),
                                  MonthOf(dtaDtaEnt),
                                  DayOf(dtaDtaEnt),
                                  HourOf(fNow()),
                                  MinuteOf(fNow()),
                                  SecondOf(fNow()),
                                  0);

      FieldByName('GAG_DTAENT').AsDateTime := dtaDtaEnt;
      FieldByName('GAG_OBSER1').AsString   := strObs1;
      FieldByName('GAG_OBSER2').AsString   := strObs2;
      FieldByName('GAG_CODVEN').AsString   := strCodVen;
      FieldByName('GAG_CODCLI').AsString   := strCodCli;
      FieldByName('GAG_NUMCCR').AsString   := strNumDup;
      FieldByName('GAG_CODFAV').AsString   := strCodFav;
      FieldByName('GAG_GARIND').AsString   := strGarInd;
      FieldByName('GAG_SEQGOR').AsString   := strSeqGor;

      If Not fEmptyStr(strNomCon) Then
        FieldByName('GAG_NOMCON').AsString   := strNomCon;
      If Not fEmptyStr(strEndCon) Then
        FieldByName('GAG_ENDCON').AsString   := strEndCon;
      If Not fEmptyStr(strBaiCon) Then
        FieldByName('GAG_BAICON').AsString   := strBaiCon;
      If Not fEmptyStr(strCepCon) Then
        FieldByName('GAG_CEPCON').AsString   := strCepCon;
      If Not fEmptyStr(strCidCon) Then
        FieldByName('GAG_CIDCON').AsString   := strCidCon;
      If Not fEmptyStr(strEstCon) Then
        FieldByName('GAG_ESTCON').AsString   := strEstCon;
      If Not fEmptyStr(strTelCon) Then
        FieldByName('GAG_TELCON').AsString   := strTelCon;
      If Not fEmptyStr(strCgcCon) Then
        FieldByName('GAG_CGCCON').AsString   := strCgcCon;
      If intCgcCpf > 0 Then
        FieldByName('GAG_CGCCPF').AsInteger  := intCgcCpf;
      If Not fEmptyStr(strIesCon) Then
        FieldByName('GAG_IESCON').AsString   := strIesCon;
      If Not fEmptyStr(strEmaCon) Then
        FieldByName('GAG_EMLCON').AsString   := strEmaCon;
      If Not fEmptyStr(strRg_Con) Then
        FieldByName('GAG_R_GCON').AsString   := strRg_Con;
      If Not fEmptyStr(strCodAti) Then
        FieldByName('GAG_CODATI').AsString   := strCodAti;

      Post;
    End;

    pAtuDadosGag;
    Result := True;

  Except
    On E: Exception Do
    Begin
      qryMovGag.Cancel;
      Raise Exception.Create('Erro ao gravar! ' + E.Message + ' - [fGravaMovGag]');
    End;
  End;

end;

class function TMovGag.fInsereMovGrc(strAutIncSeqGad, strAutIncSeqDet, strOpcDoc,
  strTipMod, strIncOri: String; blnPedido: Boolean = False): Boolean;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
begin


  strSQL := '';
  strSQL := strSQL + ' INSERT INTO MOVGRC ( ';
  strSQL := strSQL + '   AUTOINCREM,   ';
  strSQL := strSQL + '   GRC_SEQGAD,   ';
  strSQL := strSQL + '   GRC_SEQDET,   ';
  strSQL := strSQL + '   GRC_OPCDOC,   ';
  strSQL := strSQL + '   GRC_TIPMOD,   ';
  strSQL := strSQL + '   GRC_INCORI)   ';
  strSQL := strSQL + ' VALUES (        ';
  strSQL := strSQL + '   :AUTINC,      ';
  strSQL := strSQL + '   :SEQGAD,      ';
  strSQL := strSQL + '   :SEQDET,      ';
  strSQL := strSQL + '   :OPCDOC,      ';
  strSQL := strSQL + '   :TIPMOD,      ';
  strSQL := strSQL + '   :INCORI)      ';

  Try
    qryTmp := fCriaQuery;

    IF (Not fEmptystr(strIncOri)) And (pos(strOpcDoc, '_GA_NE_OE_DV_') > 0) then
    begin
      if Not fValidarDocumentoOrigemGarantia(strAutIncSeqGad, strIncOri) then
        raise Exception.Create('Foi constatada uma inconsistência de dados ao gravar da MOVGRC. Por favor, contate a Citel!');
    end;


    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTINC').AsString := fRetAutoIncrem('MOVGRC', VS_strCodEmp);
      ParamByName('SEQGAD').AsString := strAutIncSeqGad;
      ParamByName('SEQDET').AsString := strAutIncSeqDet;
      ParamByName('OPCDOC').AsString := strOpcDoc;
      ParamByName('TIPMOD').AsString := strTipMod;
      If not fEmptyStr(strIncOri) Then
        ParamByName('INCORI').AsString := strIncOri
      Else
        ParamByName('INCORI').Clear;

      ExecSQL;

      Result := RowsAffected > 0;
    End;
  Except
    On E: Exception Do
    Begin
      Raise;
//      fMensagem('', E.Message + '[TMovGag.fInsereMovGrc]', ['&O K']);
    End;
  End;

  FreeAndNil(qryTmp);
end;

{*******************************************}
{* ATUALIZA VARIÁVEIS MOVGAG               *}
{****************************************RL*}
procedure TMovGag.pAtuDadosGag;
begin

  With qryMovGag Do
  Begin
    FNumEnt := FieldByName('GAG_NUMENT').AsString;
    FCodCli := FieldByName('GAG_CODCLI').AsString;
    FCodVen := FieldByName('GAG_CODVEN').AsString;
    FCodEmp := FieldByName('GAG_CODEMP').AsString;
    FAutInc := FieldByName('AUTOINCREM').AsString;
    FDtaEnt := FieldByName('GAG_DTAENT').AsDateTime;
    FCodFav := FieldByName('GAG_CODFAV').AsString;

    if Not fEmptyStr(FNumEnt) then
    begin
      FGarInd := FieldByName('GAG_GARIND').AsString;
      FSeqGor := FieldByName('GAG_SEQGOR').AsString;
    end;

    {***********************************}
    {* DADOS DO CONSUMIDOR NA GARANTIA *}
    {*********************************FC}
    If Not fEmptyStr(strAutInc) Then
    Begin
      FstrNomCon := FieldByName('GAG_NOMCON').AsString;
      FstrEndCon := FieldByName('GAG_ENDCON').AsString;
      FstrBaiCon := FieldByName('GAG_BAICON').AsString;
      FstrCepCon := FieldByName('GAG_CEPCON').AsString;
      FstrCidCon := FieldByName('GAG_CIDCON').AsString;
      FstrEstCon := FieldByName('GAG_ESTCON').AsString;
      FstrTelCon := FieldByName('GAG_TELCON').AsString;
      FstrCgcCon := FieldByName('GAG_CGCCON').AsString;
      FstrRg_Con := FieldByName('GAG_R_GCON').AsString;
      FintCgcCpf := FieldByName('GAG_CGCCPF').AsInteger;
      FstrIesCon := FieldByName('GAG_IESCON').AsString;
      FstrEmaCon := FieldByName('GAG_EMLCON').AsString;
      FstrCodAti := FieldByName('GAG_CODATI').AsString;
    End;
  End;
end;

{*******************************************}
{* CARREGA MOVGAG                          *}
{****************************************RL*}
procedure TMovGag.pCarregaMovGag(strNumEnt: String; strCodEmpGag: String = '');
  Var strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + ' SELECT * ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   MOVGAG ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GAG_NUMENT = :NUMENT AND ';
    strSQL := strSQL + '  GAG_CODEMP = :CODEMP ';

    With qryMovGag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('NUMENT').AsString := strNumEnt;

      If fEmptyStr(strCodEmpGag) Then
        ParamByName('CODEMP').AsString := VS_strCodEmp
      Else
        ParamByName('CODEMP').AsString := strCodEmpGag;

      Open;

      pAtuDadosGag;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + ' - [pCarregaMovGag]');
  End;

end;

procedure TMovGag.pLimpaDadosGag;
begin

  FNumEnt := '';
  FCodCli := '';
  FCodVen := '';
  FCodEmp := '';
  FAutInc := '';
  FNomCli := '';
  FNomVen := '';
  FNomFor := '';
  FDtaEnt := 0;
  FCodFav := '';
  FGarInd := 'N';
  FstrIncCTR := '';
end;

{ TMovGad }

constructor TMovGad.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  stlIncGau  := TStringList.Create;
  qryMovGad  := fCriaQuery(Self);
  qryFornec  := fCriaQuery(Self);
  qryCliente := fCriaQuery(Self);
  dtsMovGad  := fCriaDataSource(qryMovGad);

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;
end;

destructor TMovGad.Destroy;
begin
  FreeAndNil(stlIncGau);
  FreeAndNil(qryFornec);
  FreeAndNil(qryCliente);
  FreeAndNil(qryMovGad);

  inherited Destroy;
end;

{*******************************************}
{* GRAVA MOVGAD                            *}
{****************************************RL*}
function TMovGad.fGetSqlUltimaCompra: String;
  CONST  SQL_FORFIL: String = ' (DET_CODFOR IN (SELECT IFNULL(EMP_FORFIL,"") FROM CADEMP)) ';

  Var
    blnATUMED: Boolean;
    strWhere: String;
    strAux: String;

begin
  blnATUMED := fCfgSis('ATUMED', varBoolean);

  {$Region 'Script Query'}
  Result := '          SELECT I2.ITE_CODITE AS "CODITE", CONCAT(D.DET_CODFOR,"-",F.FOR_NOMFOR) AS "FORNEC", ';
  Result := Result + '        D.DET_DTAENT AS "DTAENT", D.DET_QTDITE AS "QTDITE" ';
  Result := Result + ' FROM (SELECT I.ITE_CODITE, D.DTAMOV ';
  Result := Result + '       FROM CADITE I ';
  Result := Result + '       JOIN (SELECT  DET_CODITE, ';
  Result := Result + '                     MAX(CAST( CONCAT(IFNULL(DET_DTAENT,0), " ", IFNULL(DET_HORENT,0)) AS DATETIME)) AS "DTAMOV" ';
  Result := Result + '             FROM  MOVDET ';
  Result := Result + '             WHERE %0:s ';

  Result := Result + '       GROUP BY DET_CODITE) D ON D.DET_CODITE = I.ITE_CODITE) I2 ';

  Result := Result + ' JOIN (SELECT DET_SEQGER, DET_CODITE, SUM(DET_QTDITE)  AS "DET_QTDITE", DET_CODFOR, ';
  Result := Result + '              CAST( CONCAT(IFNULL(DET_DTAENT,0), " ", IFNULL(DET_HORENT,0)) AS DATETIME) AS "DTAMOV", DET_DTAENT ';
  Result := Result + '       FROM MOVDET ';
  Result := Result + '       WHERE %0:s ';

  Result := Result + '       GROUP BY DET_SEQGER, DET_QTDITE) D ON D.DET_CODITE = I2.ITE_CODITE  AND D.DTAMOV = I2.DTAMOV ';

  Result := Result + ' JOIN CADFOR F ON F.FOR_CODFOR = D.DET_CODFOR ';
 {$Endregion}
  {$Region 'Montando Where MovDet'}

  strWhere := ' DET_TIP_FC = "F" ';
  strWhere := strWhere + ' AND IFNULL(DET_DTAENT,0) <>  0 ';
  strWhere := strWhere + ' AND ( ((NOT %0:s) AND (LOCATE(DET_CLAFIS, :CLACOM)>0 )) OR (%1:s)) ';

  If blnATUMED Then
    strAux := strAux + ' ( (%0:s) AND DET_ORIDOC = "") '
  else
    strAux := strAux + ' FALSE ';

  strWhere := Format(strWhere,[SQL_FORFIL, strAux]);

  If blnATUMED Then
    strWhere := Format(strWhere,[SQL_FORFIL]);
  {$Endregion}

  {$Region 'Aplicando Where na query'}
  Result := Format(Result,[strWhere]);
  {$Endregion}

end;

function TMovGad.fGravaMovGad(strSeqGag     : String;
                              Var strAutInc : String;
                              strNumDoc,
                              strEspDoc,
                              strEmpDoc,
                              strRepost,
                              strCodIte: String;
                              fltValIte,
                              fltQtdReq,
                              fltQtdDev,
                              fltQtdPre,
                              fltQtdRet,
                              fltQtdRef: Double;
                              strObsP_1,
                              strObsP_2,
                              strGarFil: String;
                              strNumLot:String = '';
                              blnGerouCredito: Boolean = False;
                              strCodFor : String = '';
                              strSeqDoc : String = '';
                              fltUniCrd: Double = 0): Boolean;
begin

  Try
    With qryMovGad Do
    Begin

      If Not Active Then
        pCarregaMovGad(strSeqGag);

      If Not Locate('GAD_SEQGAG;AUTOINCREM', VarArrayOf([strSeqGag, strAutInc]), []) Then
      Begin
        Append;

        strAutInc := fRetAutoIncrem('MOVGAD', strEmpDoc);

        FieldByName('GAD_SEQGAG').AsString := strSeqGag;
        FieldByName('AUTOINCREM').AsString := strAutInc;
        FieldByName('GAD_CODEMP').AsString := strEmpDoc;
      End
      Else
        Edit;

      FieldByName('GAD_NUMDOC').AsString := strNumDoc;
      FieldByName('GAD_ESPDOC').AsString := strEspDoc;
      FieldByName('GAD_REPOST').AsString := strRepost;
      FieldByName('GAD_CODITE').AsString := strCodIte;
      FieldByName('GAD_VALITE').AsFloat  := fltValIte;
      FieldByName('GAD_QTDREQ').AsFloat  := fltQtdReq;
      FieldByName('GAD_QTDDEV').AsFloat  := fltQtdDev;
      FieldByName('GAD_QTDPRE').AsFloat  := fltQtdPre;
      FieldByName('GAD_QTDRET').AsFloat  := fltQtdRet;
      FieldByName('GAD_QTDREF').AsFloat  := fltQtdRef;
      FieldByName('GAD_PRECUS').AsFloat  := fRetPreCus(VS_strCodEmp, strCodIte);
      FieldByName('GAD_OBSP_1').AsString := strObsP_1;
      FieldByName('GAD_OBSP_2').AsString := strObsP_2;
      FieldByName('GAD_GARFIL').AsString := strGarFil;
      FieldByName('GAD_SEQDOC').AsString := strSeqDoc;
      FieldByName('GAD_CODFOR').AsString := strCodFor;

      If fEmptyStr(strCodFor) Then
        FieldByName('GAD_CODFOR').AsString := fRetFornecedorItem(strCodIte);

      // QUANDO UTILIZAR LOTE, GRAVA O LOTE PRINCIPAL DA GARANTIA ** RL **
      if (Not fEmptyStr(strNumLot)) then
        FieldByName('GAD_NUMLOT').AsString := strNumLot;

      If (strRepost = 'S') Or (blnGerouCredito) Then
        FieldByName('GAD_DTADEV').AsDateTime := VS_Date;

      //0 - PRODUTO REPOSTO | 1 - AGUARDANDO GERAR CADREC | 2 - CADREC JÁ GERADO
      If strRepost = 'S' Then
      Begin
        FieldByName('GAD_SCREDI').AsInteger  := 0;
        FieldByName('GAD_DTACRE').Clear;
        FieldByName('GAD_HRACRE').Clear;
        FieldByName('GAD_OPECRE').Clear;
      End

      Else
      If blnGerouCredito Then
      Begin
        FieldByName('GAD_SCREDI').AsInteger  := 2;
        FieldByName('GAD_DTACRE').AsDateTime := VS_Date;
        FieldByName('GAD_HRACRE').AsDateTime := fNow;
        FieldByName('GAD_OPECRE').AsString   := strLoginUsuarioLogado;
      End

      Else
      Begin
        FieldByName('GAD_SCREDI').AsInteger  := 1;
        FieldByName('GAD_DTACRE').Clear;
        FieldByName('GAD_HRACRE').Clear;
        FieldByName('GAD_OPECRE').Clear;
      End;

      if fltUniCrd <= 0 then
      begin
        If fltQtdReq = 0 then
          raise EGarantQtdReqInvalido.Create('Quantidade não definida!');
        fltUniCrd := (fltValIte/fltQtdReq);
      end;
      FieldByName('GAD_UNICRD').AsFloat := fltUniCrd;

      Post;

      ReprocessarItem(strCodIte, '', False);

    End;

    Result := True;

  Except
    on e: EGarantQtdReqInvalido do
    begin
      raise;
    end;
    On E: Exception Do
    Begin
      qryMovGad.Cancel;
      Raise Exception.Create('Erro ao gravar! ' + E.Message + ' - [fGravaMovGad]');

     End;
  End;

end;

class function TMovGad.fSQLInsereTabelaAux: String;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + ' INSERT INTO MOVGAU ( ';
  strSQL := strSQL + '   AUTOINCREM,   ';
  strSQL := strSQL + '   GAU_SEQGAD,   ';
  strSQL := strSQL + '   GAU_ESPDOC,   ';
  strSQL := strSQL + '   GAU_CODITE,   ';
  strSQL := strSQL + '   GAU_SEQDET,   ';
  strSQL := strSQL + '   GAU_QTDRET,   ';
  strSQL := strSQL + '   GAU_QTDREF,   ';
  strSQL := strSQL + '   GAU_SEQGAE)   ';
  strSQL := strSQL + ' VALUES (        ';
  strSQL := strSQL + '   :AUTINC,      ';
  strSQL := strSQL + '   :SEQGAD,      ';
  strSQL := strSQL + '   :ESPDOC,      ';
  strSQL := strSQL + '   :CODITE,      ';
  strSQL := strSQL + '   :SEQDET,      ';
  strSQL := strSQL + '   :QTDRET,      ';
  strSQL := strSQL + '   :QTDREF,      ';
  strSQL := strSQL + '   :SEQGAE)      ';

  Result := strSQL;
end;

class function TMovGad.fSqlProdutosRetornadosFornecedor(pblnCpoSel: Boolean; pFiltrosSql: TSetFiltroSqlProdutoRetornado = [TFiltroSqlProdutoRetornado.fprPeriodoDatas]; AAutoincrem: String = ''): String;
Var
  blnFilEmp : Boolean;
  blnUsaTabPrF: Boolean;
begin
  blnUsaTabPrF := fCfgSis('TABPRF', varBoolean);
  If (fCfgSis('GARMAT', varBoolean)) then
    blnFilEmp := (VS_strCodEmp <> fCfgSis('EMPGAR', varString))
  Else
    blnFilEmp := True;

  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  D.AUTOINCREM        AS "AUTINC", ';
  Result := Result + '  E.AUTOINCREM        AS "INCGAE", ';
  Result := Result + '  G.GAG_NUMENT        AS "NUMENT", ';
  Result := Result + '  D.GAD_CODITE        AS "CODITE", ';
  Result := Result + '  I.ITE_DESITE        AS "DESITE", ';
  Result := Result + '  I.ITE_REFERE        AS "REFERE", ';
  Result := Result + '  U.UNI_DESUNI        AS "UNIDAD", ';
  Result := Result + '  U.UNI_ITEFRA        AS "ITEFRA", ';
  Result := Result + '  D.GAD_DTARET        AS "DTARET", ';
  Result := Result + '  GAE_QTDENV          AS "QTDREQ", ';
  Result := Result + '  GAE_QTDRET          AS "QTDRET", ';
  Result := Result + '  GAE_QTDREF          AS "QTDREF", ';
  Result := Result + '  G.GAG_CODVEN        AS "CODVEN", ';
  Result := Result + '  G.GAG_CODCLI        AS "CODCLI", ';
  Result := Result + '  D.GAD_CODFOR        AS "CODFOR", ';
  Result := Result + '  D.GAD_OBSF_1        AS "OBSF_1", ';
  Result := Result + '  D.GAD_OBSF_2        AS "OBSF_2", ';
  Result := Result + '  D.GAD_OBSF_3        AS "OBSF_3", ';
  Result := Result + '  D.GAD_OBSF_4        AS "OBSF_4", ';
  Result := Result + '  D.GAD_OBSF_5        AS "OBSF_5", ';
  Result := Result + '  D.GAD_MOTBAI        AS "MOTBAI", ';
  Result := Result + '  (D.GAD_VALITE / D.GAD_QTDREQ) AS "VALITE", ';
  Result := Result + '  CONCAT(GAE_NUMENV,"-",GAE_ESPENV) AS "NUMENV",  ';
  Result := Result + '  (M.DET_VLRCON/M.DET_QTDITE) AS VALUNT, ';

  if blnUsaTabPrF then
    Result := Result + ' IF(IFNULL(F.ITE_CODFAB,"") = "", I.ITE_CODFAB, F.ITE_CODFAB) AS "CODFAB", '
  else
    Result := Result + ' IF(IFNULL(F.ITE_CODITF,"") = "", I.ITE_CODFAB, F.ITE_CODITF) AS "CODFAB",';

  Result := Result + '  G.AUTOINCREM        AS "INCGAG", ';
  Result := Result + '  I.ITE_CODBAR        AS "CODBAR", ';
  Result := Result + '  I.ITE_BAREMB        AS "BAREMB", ';
 
  Result := Result + ' (SELECT COUNT(DISTINCT ITE_CODITF) ';
  Result := Result + '  FROM  ITEFOR ';
  Result := Result + '  JOIN CADFOR ON (ITE_CODFOR=FOR_CODFOR) ';
  Result := Result + '  JOIN CADCID ON (FOR_CODCID=CID_CODCID) ';
  Result := Result + '  WHERE  ITE_CODITE = D.GAD_CODITE ';
  Result := Result + '    AND  ITE_CODFOR = D.GAD_CODFOR) AS QTDSKU ';


  If (fCfgSis('GARMAT', varBoolean)) Then
  Begin
    Result := Result + ' , ';
    Result := Result + ' (SELECT ';
    Result := Result + '    CONCAT(PCG_NUMPED,"-",PCG_ESPDOC) AS NUMPED ';
    Result := Result + 'FROM ';
    Result := Result + '    PCMGER ';
    Result := Result + '  WHERE ';
    If fCfgSis('CPDORI', varBoolean) Then
    Begin
      Result := Result + '    PCG_ORIGND = GAE_NUMENV AND ';
      Result := Result + '    PCG_ORIGES = GAE_ESPENV AND ';
      Result := Result + '    PCG_ORIGEP = :CODEMP   AND  ';
      Result := Result + '    PCG_DTAPED = GAE_DTAENV AND ';
      Result := Result + '    PCG_CODFOR = D.GAD_CODFOR   ';
      Result := Result + '    ) AS "NUMPED" ';
    end
    Else
    begin
      Result := Result + '    SUBSTRING(PCG_DOCORI,1,' + IntToStr(fTamDocCadRec) + ') = GAE_NUMENV AND ';
      Result := Result + '    SUBSTRING(PCG_DOCORI,' + IntToStr(IfThen(fTamDocCadRec = 6, 7, 13)) + ',2) = GAE_ESPENV AND ';
      Result := Result + '    PCG_CODEMP = :CODEMP AND ';
      Result := Result + '    PCG_DTAPED = GAE_DTAENV AND ';
      Result := Result + '    PCG_CODFOR = D.GAD_CODFOR ';
      Result := Result + '    ) AS "NUMPED" ';
    end;
  End;

  if pblnCpoSel then
    Result := Result + ', "0" as "SELECIONADO" ';

  Result := Result + 'FROM ';
  Result := Result + '  MOVGAG G INNER JOIN MOVGAD  D  ON D.GAD_SEQGAG  = G.AUTOINCREM   ';
  Result := Result + '           INNER JOIN CADITE  I  ON D.GAD_CODITE  = I.ITE_CODITE   ';
  Result := Result + '           INNER JOIN CADUNI  U  ON I.ITE_CODUNI  = U.UNI_CODUNI   ';
  Result := Result + '           INNER JOIN MOVGAE  E  ON E.GAE_SEQGAD  = D.AUTOINCREM   ';
  Result := Result + '           INNER JOIN MOVDET  M  ON E.GAE_NUMENV  = M.DET_NUMDOC   ';
  Result := Result + '                                AND E.GAE_ESPENV  = M.DET_ESPDOC   ';
  Result := Result + '                                AND E.GAE_EMPENV  = M.DET_CODEMP   ';
  Result := Result + '                                AND E.GAE_SERENV  = M.DET_SERIE_   ';
  Result := Result + '                                AND IF(IFNULL(E.GAE_INCENV, "") <> "", E.GAE_INCENV = M.AUTOINCREM,  TRUE) ';
  Result := Result + '                                AND D.GAD_CODITE  = M.DET_CODITE   ';
  if blnUsaTabPrF then
  Begin

    Result := Result + '          LEFT JOIN ITEFOR F ON F.ITE_CODITE = I.ITE_CODITE AND ';
    Result := Result + '                                  F.ITE_CODFOR = M.DET_CODFOR ';

    Result := Result + '                                  AND F.ITE_CODTAB = (SELECT TAB_CODTAB FROM TABPRE ';
    Result := Result + '                                                     INNER JOIN ITEFOR IF2 ON IF2.ITE_CODTAB = TABPRE.TAB_CODTAB ';
    Result := Result + '                                                     WHERE IF2.ITE_CODFOR =  F.ITE_CODFOR ';
    Result := Result + '                                                       AND IF2.ITE_CODITE  = F.ITE_CODITE ';
    Result := Result + '                                                       AND TAB_ATICMP = "S" ';
    Result := Result + '                                                     ORDER BY TAB_DTACAD DESC LIMIT 1) ';

  End
  Else
  Begin
    Result := Result + '           LEFT JOIN ITEFOR F ON  F.AUTOINCREM = ';
    Result := Result + '                                 (SELECT MAX(FF.AUTOINCREM) ';
    Result := Result + '                                  FROM ITEFOR FF ';
    Result := Result + '                                  WHERE   FF.ITE_CODITE = M.DET_CODITE ';
    Result := Result + '                                  AND FF.ITE_CODFOR = M.DET_CODFOR) ';
  End;


  Result := Result + 'WHERE TRUE ';
  Result := Result + ' AND  D.GAD_CODFOR = :CODFOR  ';
  If blnFilEmp Then
    Result := Result + ' AND  G.GAG_CODEMP = :CODEMP  '
  Else
  Begin
    Result := Result + ' AND LOCATE(G.GAG_CODEMP, (                                               ';
    Result := Result + '                        SELECT GROUP_CONCAT(SIS_CODEMP SEPARATOR "_") ';
    Result := Result + '                        FROM CFGSIS                                   ';
    Result := Result + '                        WHERE SIS_CODCFG = "CFG_EMPGAR"               ';
    Result := Result + '                          AND SIS_VALCFG = :CODEMP)) > 0           ';

  End;

  If fEmptyStr(AAutoincrem) Then
    If TFiltroSqlProdutoRetornado.fprPeriodoDatas in pFiltrosSql then
      Result := Result + ' AND  GAE_DTAENV BETWEEN :DTAINI AND :DTAFIN  ';

  //se filtrar por autincrem da movgad
  If (TFiltroSqlProdutoRetornado.fprMultiplosIncGad in pFiltrosSql) then
    Result := Result + ' AND  D.AUTOINCREM IN (%s) ' //utilizar format para substituir por uma cadeia de strings(autoincrem)

  Else If (TFiltroSqlProdutoRetornado.fprIncGad in pFiltrosSql) then
    Result := Result + ' AND  D.AUTOINCREM = :INCGAD ';

  //Result := Result + '  ABS(GAE_QTDENV - IFNULL(GAE_QTDRET,0) - IFNULL(GAE_QTDREF,0)) > 0 ';
  Result := Result + ' AND  ABS(IFNULL(GAE_QTDRET,0) + IFNULL(GAE_QTDREF,0)) < IFNULL(GAE_QTDENV,0) ';

  If fUsaRotinaGarantiaItensPesados Then
    Result := Result + '  AND IF((IFNULL(D.GAD_GARFIL,"") = ""),"N", D.GAD_GARFIL) = "S" '
  Else
    Result := Result + '  AND IF((IFNULL(D.GAD_GARFIL,"") = ""),"N", D.GAD_GARFIL) = "N" ';
  If AAutoincrem <> '' Then
  Begin
    Result := Result + '  AND D.GAD_CODITE IN (SELECT DETELE.DET_CODITE ';
    Result := Result + '                         FROM GERELE ';
    Result := Result + '                        INNER JOIN DETELE ON DETELE.DET_SEQGER = GERELE.AUTOINCREM ';
    Result := Result + '                        WHERE GERELE.AUTOINCREM = "'+AAutoincrem+'")  ';
  End;

  Result := Result + '  ORDER BY NUMENV, CODITE, QTDREQ DESC ';
end;

class function TMovGad.fTestarGravacaoMovGae(strListaMovGae: String): Boolean;
  Var
    Qry: TUniQuery;
    strSql: String;
    strAux: String;
    arrGae: TStringDynArray;
    i,
    intQtdVal: integer;
begin
  Result := False;

  strListaMovGae := StringReplace(strListaMovGae,'"VAZIO",', '',[]);
  if fEmptyStr(strListaMovGae)then
    Exit;

  arrGae := SplitString(strListaMovGae,',');
  intQtdVal := 0;
  for i := Low(arrGae) to High(arrGae)  do
  begin
    strAux := arrGae[i];
    strAux := StringReplace(strAux, '"','',[rfReplaceAll]);
    if Length(Trim(strAux)) = 20 then
      inc(intQtdVal);
  end;
  finalize(arrGae);
  if intQtdVal = 0 then
    Exit;

  Qry := Nil;
  Try
    strSQL := 'SELECT COUNT(AUTOINCREM) AS QTDGAE, SUM(IF(IFNULL(GAE_INCENV,"") = "",1,0)) AS FALHAS ';
    strSQL := strSQL + ' FROM MOVGAE WHERE AUTOINCREM IN (%s) ';
    strSql := Format(strSQL,[strListaMovGae]);

    Qry := fCriaQuery(Nil);
    Qry.SQL.clear;
    Qry.Sql.Add(strSQL);
    Qry.Open;

    if Qry.isEmpty then
      Exit;

    Qry.First;
    Result := (Qry.FieldByName('FALHAS').Asinteger = 0) and (Qry.FieldByName('QTDGAE').Asinteger = intQtdVal) ;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

{*******************************************}
{* CARREGA DOCUMENTOS DAS VENDAS           *}
{****************************************RL*}
function TMovGad.fCarregaDocVendas(qryTmp: TUniQuery; strCodCli,
  strCodIte: String; blnDevolu: Boolean = True; strPlaVei : String = ''): Boolean;

  Function fDevolucao(strPrefix : String = ''): String;
  begin
    If blnDevolu Then
      Result := 'OR (LOCATE( ' + IfThen( fEmptyStr(strPrefix), '', strPrefix + '.') + 'DET_CLAFIS, :CLADEV) > 0)'
    Else
      Result := '';
  end;

  Function fGetSql(strTabDet, strTabGer, strTabAux: String; blnTodosDoc: Boolean; pblnSUGPDV: Boolean; pblnSomenteDocEmpresaLogada: Boolean): String;
    Var
      strSQL: String;
      strUniCrd, strTotIte,
      strFormulaCredito, strFormulaTotalItem,
      lstrCodEmp: String;
  Begin
    lstrCodEmp := VS_strCodEmp;
    strFormulaCredito := fScriptValCredito('D', 'T');

    strFormulaTotalItem := fScriptValIte('D');

    strUniCrd := Format(' (IF( LEFT(D.DET_CLAFIS,1) < 5, - (%0:s), (%0:s) )/D.DET_QTDITE)  ',[strFormulaCredito]);
    strTotIte := Format('SUM(IF( LEFT(D.DET_CLAFIS,1) < 5, - (%0:s), (%0:s) ))  ',[strFormulaTotalItem]);

    strSQL := '';
    strSQL := strSQL + '(SELECT ';
    strSQL := strSQL + ' (D.DET_TOTITE - D.DET_DESESP)/D.DET_QTDITE AS VALUNT, ';
    strSQL := strSQL + '  D.AUTOINCREM AS SEQDOC, ';
    strSQL := strSQL + '  DET_NUMDOC, ';
    strSQL := strSQL + '  DET_ESPDOC, ';
    strSQL := strSQL + '  DET_CODEMP, ';
    strSQL := strSQL + '  D.AUTOINCREM AS INCORI, ';
    strSQL := strSQL + '  IFNULL(DET_CODVEN, GER_CODVEN) AS GER_CODVEN, ';
    strSQL := strSQL + '  DET_DESACE, ';
    strSQL := strSQL + '  DET_QTDITE, ';
    strSQL := strSQL + '  DATE(D.DET_DTAENT) AS "DTAENT", ';
    strSQL := strSQL + '  DATE_ADD(D.DET_DTAENT, INTERVAL DET_TMPGAR MONTH) AS "DTAFIN", ';
    strSQL := strSQL + '  D.DET_TMPGAR AS "TMPGAR", ';
    strSQL := strSQL + '  CONCAT(D.DET_NUMFAT, "-", D.DET_TIPFAT, "-", D.DET_EMPFAT) DOCFAT, ';
    strSQL := strSQL + '  "" AS DOCVEN, ';
    strSQL := strSQL + '  SUM(DET_QTDITE) AS "VENDA_", ';


    strSQL := strSQL + strUniCrd + '  AS "UNICRD", ';  //Valor para o credito

    strSQL := strSQL + strTotIte + '  AS "TOTITE", ';   //Valor para a nota


    strSQL := strSQL + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5, - ((DET_TOTITE + D.DET_VALIPI) - DET_DESESP - DET_DESCFF), (DET_TOTITE + D.DET_VALIPI) - DET_DESESP - DET_DESCFF)) AS "VLRCON", ';

    if pblnSUGPDV then
    begin
      strSQL := strSQL + ' DET_UNITAR, ';
      strSQL := strSQL + ' IFNULL(DET_DESESP,0) AS "DET_DESESP", ';
    end
    else begin
      strSQL := strSQL + ' ((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE) AS "DET_UNITAR", ';
      strSQL := strSQL + ' 0 "DET_DESESP", ';
    end;

    strSQL := strSQL + '  D.DET_SERIE_, ';
    strSQL := strSQL + '  "'+strTabGer+'" AS "TABELA" ';
    strSQL := strSQL + 'FROM                          ';
    strSQL := strSQL +    strTabDet + ' D             ';
    strSQL := strSQL + '  INNER JOIN ' + strTabGer + ' ON (' + strTabGer + '.AUTOINCREM = D.DET_SEQGER) ';

    {*****************************************************************}
    {* NÃO PODE ENTRAR DOCUMENTOS DE ENTREGA FUTURA, SOMENTE A BAIXA *}
    {**************************************************************FC*}
    strSQL := strSQL + ' AND GER_ENTFUT <> "S" ';

    If strTabGer = 'NOTGER' then
    begin
     strSQL := strSQL + '      AND GER_TIPFAT <> "FF" ';
    end;


    If strTabDet = 'MOVDET' Then
      strSQL := strSQL + '  INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM '
    Else
      strSQL := strSQL + '  INNER JOIN NOTTRI T ON T.DET_SEQGER = D.AUTOINCREM ';


    if not fEmptyStr(strPlaVei) then
      strSQL := strSQL + ' LEFT JOIN '+ strTabAux + ' ON ('+ strTabAux + '.AUX_SEQGER = D.DET_SEQGER) ';

    strSQL := strSQL + 'WHERE   TRUE  AND                ';

    strSQL := strSQL + '  DET_CODCLI = :CODCLI    AND ';
    strSQL := strSQL + '  DET_CODITE = :CODITE    AND ';
    strSQL := strSQL + '  DET_TIP_FC = "C"        AND ';

    if pblnSomenteDocEmpresaLogada then
      strSQL := strSQL + Format(' D.DET_CODEMP = %s AND ',[QuotedStr(lstrCodEmp)]);

    strSQL := strSQL + '  ((DET_TMPGAR <> 0)) AND ';
    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, ' + CLAFIS_ENTFUT_VEN + IIF(strTabDet = 'NOTDET', CLAFIS_REGISTRADO_ECF, '') + ') > 0) OR (LOCATE(DET_CLAFIS, :CLAFIS) > 0) ' + fDevolucao + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) ';

    If Not blnDevolu Then
      strSQL := strSQL + ' AND LEFT(DET_CLAFIS,1) >= 5 ';

    if not fEmptyStr(strPlaVei) then
      strSQL := strSQL + ' AND AUX_PLAVEI = :PLAVEI ';



    If Not (strTabGer = 'NOTGER') then
    begin
      if blnTodosDoc then
        strSQL := strSQL + ' AND NOT (D.DET_ESPDOC = "FF" AND D.DET_JAFATU = "1" '
                                  + ' AND (IFNULL(D.DET_NUMFAT,"") <> D.DET_NUMDOC '
                                       + ' OR IFNULL(D.DET_TIPFAT,"") <> D.DET_ESPDOC)) ';
    end;


    If blnTodosDoc Then
      strSQL := strSQL + '  AND DET_ESPDOC IN ("IF", "IV", "NF", "EL", "D1", "GC", "NV", "FF") '
    else
      strSQL := strSQL + '  AND DET_ESPDOC IN ("IF", "NF") ';

    If strTabDet = 'MOVDET' Then
      strSQL := strSQL + '   AND (SELECT COUNT(1) FROM  MOVGRC C2 WHERE C2.GRC_SEQDET = D.AUTOINCREM) = 0 ';

    strSQL := strSQL + ' GROUP BY      ';
    strSQL := strSQL + '   DET_NUMDOC, ';
    strSQL := strSQL + '   DET_ESPDOC, ';
    strSQL := strSQL + '   DET_CODEMP, ';
    strSQL := strSQL + '   DET_DTAENT  ';

    strSQL := strSQL + '   HAVING DTAFIN > CURRENT_DATE)';

    strSQL := strSQL + '    UNION';
    strSQL := strSQL + '    ALL';

    strFormulaCredito := fScriptValCredito('D2', 'T2');
    strFormulaTotalItem := fScriptValIte('D2');


    strUniCrd := Format('SUM(IF( LEFT(D2.DET_CLAFIS,1) < 5, - (%0:s), (%0:s) )/D2.DET_QTDITE)  ',[strFormulaCredito]);
    strTotIte := Format('SUM(IF( LEFT(D2.DET_CLAFIS,1) < 5, - (((%0:s)/D2.DET_QTDITE)*D.DET_QTDITE), (((%0:s)/D2.DET_QTDITE)*D.DET_QTDITE) ))  ',[strFormulaTotalItem]);


    strSQL := strSQL + '    (SELECT';
    strSQL := strSQL + '     (D.DET_TOTITE - D.DET_DESESP)/D.DET_QTDITE AS VALUNT, ';
    strSQL := strSQL + '      D.AUTOINCREM AS SEQDOC, ';
    strSQL := strSQL + '      D.DET_NUMDOC,';
    strSQL := strSQL + '      D.DET_ESPDOC,';
    strSQL := strSQL + '      D.DET_CODEMP,';
    strSQL := strSQL + '      D2.AUTOINCREM AS INCORI, ';
    strSQL := strSQL + '      D2.DET_CODVEN, ';
    strSQL := strSQL + '      D2.DET_DESACE, ';
    strSQL := strSQL + '      D2.DET_QTDITE, ';
    strSQL := strSQL + '      D2.DET_DTAENT AS "DTAENT",';
    strSQL := strSQL + '      DATE_ADD( D2.DET_DTAENT, INTERVAL D2.DET_TMPGAR MONTH ) AS "DTAFIN",';
    strSQL := strSQL + '      D2.DET_TMPGAR AS "TMPGAR",';
    strSQL := strSQL + '      CONCAT(D2.DET_NUMFAT, "-", D2.DET_TIPFAT, "-", D2.DET_EMPFAT) DOCFAT, ';
    strSQL := strSQL + '      CONCAT(D2.DET_NUMDOC, "-", D2.DET_ESPDOC, "-", D2.DET_CODEMP) AS DOCVEN, ';
    strSQL := strSQL + '      SUM(D.DET_QTDITE) AS "VENDA_",';
    //Acha o valor unitario da venda original e multiplica pelo total da CG/OU para chegar no valor correto req. 102293

    strSQL := strSQL + strUniCrd + '  AS "UNICRD", ';  //Valor para o credito

    strSQL := strSQL + strTotIte + '  AS "TOTITE", ';   //Valor para a nota

    strSQL := strSQL + '      SUM(((IF(LEFT(D2.DET_CLAFIS, 1) < 5, - ((D2.DET_TOTITE + D2.DET_VALIPI) - D2.DET_DESESP - D2.DET_DESCFF), (D2.DET_TOTITE + D2.DET_VALIPI) - D2.DET_DESESP - D2.DET_DESCFF)) / D2.DET_QTDITE ) * D.DET_QTDITE ) AS "VLRCON", ';

    if pblnSUGPDV then
    begin
      strSQL := strSQL + ' D2.DET_UNITAR, ';
      strSQL := strSQL + ' IFNULL(D2.DET_DESESP, 0) AS "DET_DESESP", ';
    end
    else begin
      strSQL := strSQL + ' ((D2.DET_TOTITE - D2.DET_DESESP) / D2.DET_QTDITE) AS "DET_UNITAR", ';
      strSQL := strSQL + ' 0 "DET_DESESP", ';
    end;

    strSQL := strSQL + '      D.DET_SERIE_, ';
    strSQL := strSQL + '  "'+strTabGer+'" AS "TABELA" ';
    strSQL := strSQL + '    FROM';
    strSQL := strSQL + '      ' +strTabDet +' D';
    strSQL := strSQL + '      INNER JOIN ' +strTabGer;
    strSQL := strSQL + '        ON (' +strTabGer +'.AUTOINCREM = D.DET_SEQGER) ';

    strSQL := strSQL + ' AND GER_ENTFUT <> "S" ';

    If strTabGer = 'NOTGER' then
     strSQL := strSQL + '      AND GER_TIPFAT <> "FF" ';


    if not fEmptyStr(strPlaVei) then
      strSQL := strSQL + '    LEFT JOIN '+ strTabAux + ' ON ('+ strTabAux + '.AUX_SEQGER = D.DET_SEQGER) ';

    strSQL := strSQL + '      INNER JOIN MOVGRC C ON C.GRC_SEQDET = D.AUTOINCREM AND (GRC_OPCDOC IN ("GC", "OU"))';;
    // responsavel por pegar os dados da venda original. O segundo MOVDET (D2) eh o registro da venda original!!!
    strSQL := strSQL + ' INNER JOIN MOVDET D2 ON D2.AUTOINCREM = C.GRC_INCORI';
    strSQL := strSQL + ' INNER JOIN MOVTRI T2 ON T2.DET_SEQGER = D2.AUTOINCREM ';

    strSQL := strSQL + '    WHERE D.DET_CODCLI = :CODCLI';
    strSQL := strSQL + '      AND D.DET_CODITE = :CODITE';

    if pblnSomenteDocEmpresaLogada then
      strSQL := strSQL + Format(' AND D.DET_CODEMP = %s ',[QuotedStr(lstrCodEmp)]);

    if not fEmptyStr(strPlaVei) then
      strSQL := strSQL + '    AND AUX_PLAVEI = :PLAVEI ';

    strSQL := strSQL + '      AND D.DET_TIP_FC = "C"';

    strSQL := strSQL + '      AND ((LOCATE(D2.DET_CLAFIS, ' + CLAFIS_ENTFUT_VEN + IIF(strTabDet = 'NOTDET', CLAFIS_REGISTRADO_ECF, '') + ') > 0) OR (LOCATE(D2.DET_CLAFIS, :CLAFIS) > 0) ' + fDevolucao('D2') + ' OR (D2.DET_ESPDOC = "BR") OR LOCATE(D2.DET_CLAFIS,' + CLAFIS_BR + ')) ';

    strSQL := strSQL + '    GROUP BY D.DET_NUMDOC,';
    strSQL := strSQL + '      D.DET_ESPDOC,';
    strSQL := strSQL + '      D.DET_CODEMP,';
    strSQL := strSQL + '      D.DET_DTAENT';
    strSQL := strSQL + '    HAVING DTAFIN > CURRENT_DATE)';

    // PEGA DOCUMENTO GC, QUANDO A ORIGEM É DE NOTA CONFIRMADA ( INNER JOIN NOTDET D2 ON D2.AUTOINCREM = C.GRC_INCORI )
    If strTabDet = 'MOVDET' Then
    Begin
      strSQL := strSQL + '    UNION';
      strSQL := strSQL + '    ALL';
      strSQL := strSQL + '    (SELECT';
      strSQL := strSQL + '     (D.DET_TOTITE - D.DET_DESESP)/D.DET_QTDITE AS VALUNT, ';
      strSQL := strSQL + '      D.AUTOINCREM AS SEQDOC, ';
      strSQL := strSQL + '      D.DET_NUMDOC,';
      strSQL := strSQL + '      D.DET_ESPDOC,';
      strSQL := strSQL + '      D.DET_CODEMP,';
      strSQL := strSQL + '      D2.AUTOINCREM AS INCORI, ';
      strSQL := strSQL + '      D2.DET_CODVEN, ';
      strSQL := strSQL + '      D2.DET_DESACE, ';
      strSQL := strSQL + '      D2.DET_QTDITE, ';
      strSQL := strSQL + '      D2.DET_DTAENT AS "DTAENT",';
      strSQL := strSQL + '      DATE_ADD( D2.DET_DTAENT, INTERVAL D2.DET_TMPGAR MONTH ) AS "DTAFIN",';
      strSQL := strSQL + '      D2.DET_TMPGAR AS "TMPGAR",';
      strSQL := strSQL + '      CONCAT(D2.DET_NUMFAT, "-", D2.DET_TIPFAT, "-", D2.DET_EMPFAT) DOCFAT, ';
      strSQL := strSQL + '      CONCAT(D2.DET_NUMDOC, "-", D2.DET_ESPDOC, "-", D2.DET_CODEMP) AS DOCVEN, ';
      strSQL := strSQL + '      SUM(D.DET_QTDITE) AS "VENDA_",';
      //Acha o valor unitario da venda original e multiplica pelo total da CG/OU para chegar no valor correto req. 102293

      strSQL := strSQL + strUniCrd + '  AS "UNICRD", ';  //Valor para o credito

      strSQL := strSQL + strTotIte + '  AS "TOTITE", ';   //Valor para a nota

      strSQL := strSQL + '      SUM(((IF(LEFT(D2.DET_CLAFIS, 1) < 5, - ((D2.DET_TOTITE + D2.DET_VALIPI) - D2.DET_DESESP - D2.DET_DESCFF), (D2.DET_TOTITE + D2.DET_VALIPI) - D2.DET_DESESP - D2.DET_DESCFF)) / D2.DET_QTDITE ) * D.DET_QTDITE ) AS "VLRCON", ';

      if pblnSUGPDV then
      begin
        strSQL := strSQL + ' D2.DET_UNITAR, ';
        strSQL := strSQL + ' IFNULL(D2.DET_DESESP, 0) AS "DET_DESESP", ';
      end
      else begin
        strSQL := strSQL + ' ((D2.DET_TOTITE - D2.DET_DESESP) / D2.DET_QTDITE) AS "DET_UNITAR", ';
        strSQL := strSQL + ' 0 "DET_DESESP", ';
      end;

      strSQL := strSQL + '      D.DET_SERIE_, ';
      strSQL := strSQL + '  "'+strTabGer+'" AS "TABELA" ';
      strSQL := strSQL + '    FROM';
      strSQL := strSQL + '      ' +strTabDet +' D';
      strSQL := strSQL + '      INNER JOIN ' +strTabGer;
      strSQL := strSQL + '        ON (' +strTabGer +'.AUTOINCREM = D.DET_SEQGER) ';

      strSQL := strSQL + ' AND GER_ENTFUT <> "S" ';

      if not fEmptyStr(strPlaVei) then
        strSQL := strSQL + '    LEFT JOIN '+ strTabAux + ' ON ('+ strTabAux + '.AUX_SEQGER = D.DET_SEQGER) ';

      strSQL := strSQL + '      INNER JOIN MOVGRC C ON C.GRC_SEQDET = D.AUTOINCREM AND (GRC_OPCDOC IN ("GC", "OU"))';;
      // responsavel por pegar os dados da venda original. O segundo MOVDET (D2) eh o registro da venda original!!!
      strSQL := strSQL + ' INNER JOIN NOTDET D2 ON D2.AUTOINCREM = C.GRC_INCORI';
      strSQL := strSQL + ' INNER JOIN NOTTRI T2 ON T2.DET_SEQGER = D2.AUTOINCREM ';

      strSQL := strSQL + '    WHERE D.DET_CODCLI = :CODCLI';
      strSQL := strSQL + '      AND D.DET_CODITE = :CODITE';

      if pblnSomenteDocEmpresaLogada then
        strSQL := strSQL + Format(' AND D.DET_CODEMP = %s ',[QuotedStr(lstrCodEmp)]);

      if not fEmptyStr(strPlaVei) then
        strSQL := strSQL + '    AND AUX_PLAVEI = :PLAVEI ';

      strSQL := strSQL + '      AND D.DET_TIP_FC = "C"';

      strSQL := strSQL + '      AND ((LOCATE(D2.DET_CLAFIS, ' + CLAFIS_ENTFUT_VEN + IIF(strTabDet = 'NOTDET', CLAFIS_REGISTRADO_ECF, '') + ') > 0) OR (LOCATE(D2.DET_CLAFIS, :CLAFIS) > 0) ' + fDevolucao('D2') + ' OR (D2.DET_ESPDOC = "BR") OR LOCATE(D2.DET_CLAFIS,' + CLAFIS_BR + ')) ';

      strSQL := strSQL + '    GROUP BY D.DET_NUMDOC,';
      strSQL := strSQL + '      D.DET_ESPDOC,';
      strSQL := strSQL + '      D.DET_CODEMP,';
      strSQL := strSQL + '      D.DET_DTAENT';
      strSQL := strSQL + '    HAVING DTAFIN > CURRENT_DATE)';
    End;

    Result := strSQL;
  End;

  Var
    strSQL,
    strUni: String;
    blnTodosDocumento: boolean;
    blnSUGPDV: Boolean;
    blnSomenteDocEmpresaLodada: Boolean;
begin
  blnTodosDocumento := fCfgSis('GANFIF') = '2';
  blnSomenteDocEmpresaLodada := fCfgSis('RLNVEL') = 'S';
  blnSUGPDV := fCfgSis('SUGPDV') = '1';

  Result := False;
  strUni := fGetSql('MOVDET', 'MOVGER', 'AUXMOV', blnTodosDocumento, blnSUGPDV, blnSomenteDocEmpresaLodada)
            + ' UNION ALL '
            + AnsiReplaceStr(
                AnsiReplaceStr(
                  AnsiReplaceStr(fGetSql('NOTDET', 'NOTGER', 'AUXNOT', blnTodosDocumento, blnSUGPDV, blnSomenteDocEmpresaLodada), 'D2.DET_DESCFF', '0'),
                              'D.DET_DESCFF', '0'),
                                  'DET_DESCFF', '0');

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '  VALUNT, ';
	strSQL := strSQL + '  CONCAT(DET_NUMDOC, "-", DET_ESPDOC) AS "NUMDOC",';
  strSQL := strSQL + '  SEQDOC, ';
	strSQL := strSQL + '  DET_NUMDOC,';
	strSQL := strSQL + '  DET_CODEMP AS "EMPDOC",';
	strSQL := strSQL + '  DET_ESPDOC,';
  strSQL := strSQL + '  GER_CODVEN AS CODVEN, ';
  strSQL := strSQL + '  DET_DESACE / DET_QTDITE AS DET_DESACE, ';
	strSQL := strSQL + '  DATE(DTAENT) AS "DTAENT",';
	strSQL := strSQL + '  DATE(DTAFIN) AS "DTAFIN",';
	strSQL := strSQL + '  VENDA_,';
	strSQL := strSQL + '  TOTITE,';
	strSQL := strSQL + '  VLRCON,';
	strSQL := strSQL + '  UNICRD,';

  if blnTodosDocumento then
  begin
    strSQL := strSQL + '  VENDA_ - (IFNULL(GAD_QTDREQ, 0)  ';
    strSQL := strSQL + '            + IF(TABELA = "NOTGER",IFNULL(GFF_GAR_FF,0),0))AS "DISPON", ';


  	strSQL := strSQL + '  IFNULL(TMPGAD.FORNEC, 0) AS "FORNEC",';

  	strSQL := strSQL + '  (IFNULL(TMPGAD.REPOR_, 0) + IF(TABELA = "NOTGER",IFNULL(GFF_GAR_FF,0),0)) AS "REPOR_",';
  end
  else begin
  	strSQL := strSQL + '  VENDA_ - IFNULL(GAD_QTDREQ, 0) AS "DISPON",  ';
  	strSQL := strSQL + '  IFNULL(TMPGAD.FORNEC, 0) AS "FORNEC",';
  	strSQL := strSQL + '  IFNULL(TMPGAD.REPOR_, 0)  AS "REPOR_",'
  end;

	strSQL := strSQL + '  IFNULL(TMPGAD.REFUGO, 0) AS "REFUGO",';
	strSQL := strSQL + '  IFNULL(TMPGAD.PREJUI, 0) AS "PREJUI",';
	strSQL := strSQL + '  "N" AS "MARDES",';
    strSQL := strSQL + '  DOCFAT, ';
    strSQL := strSQL + '  DOCVEN, ';
 	strSQL := strSQL + '  INCORI, ';
	strSQL := strSQL + '  DET_UNITAR,';
	strSQL := strSQL + '  DET_DESESP,';
	strSQL := strSQL + '  TMPGAR, ';
  strSQL := strSQL + '  DET_SERIE_, ';
  strSQL := strSQL + '  TABELA, ';

  if blnTodosDocumento then
    strSQL := strSQL + '  IF(TABELA = "NOTGER", IFNULL(GFF_GAR_FF,0),0) AS GAR_FF '
  else
    strSQL := strSQL + '  0 AS GAR_FF ';

	strSQL := strSQL + ' FROM (' +strUni +') AS TABUNI';
	strSQL := strSQL + '  LEFT JOIN';
	strSQL := strSQL + '    (SELECT';
	strSQL := strSQL + '      GAD_NUMDOC AS "NUMDOC",';
	strSQL := strSQL + '      GAD_ESPDOC AS "ESPDOC",';
	strSQL := strSQL + '      GAD_CODEMP AS "EMPDOC",';

	strSQL := strSQL + '      IFNULL(SUM(GAD_QTDREQ - GAD_QTDDEV - GAD_QTDPRE),0) AS "DISPON",';


	strSQL := strSQL + '      IFNULL(';
	strSQL := strSQL + '        SUM(';
	strSQL := strSQL + '          GAD_QTDREQ - GAD_QTDRET - GAD_QTDREF';
	strSQL := strSQL + '        ),';
	strSQL := strSQL + '        0';
	strSQL := strSQL + '      ) AS "FORNEC",';
	strSQL := strSQL + '      IFNULL(SUM(GAD_QTDREQ),0) AS GAD_QTDREQ, ';
	strSQL := strSQL + '      IFNULL(SUM(GAD_QTDREQ - GAD_QTDDEV), 0) AS "REPOR_",';
	strSQL := strSQL + '      IFNULL(SUM(GAD_QTDREF), 0) AS "REFUGO",';
	strSQL := strSQL + '      IFNULL(SUM(GAD_QTDPRE), 0) AS "PREJUI"';
	strSQL := strSQL + '    FROM MOVGAD';
	strSQL := strSQL + '    JOIN  MOVGAG ON MOVGAG.AUTOINCREM = MOVGAD.GAD_SEQGAG  AND GAG_CODCLI = :CODCLI ';
	strSQL := strSQL + '    WHERE GAD_SEQGAG = MOVGAG.AUTOINCREM';
	strSQL := strSQL + '      AND GAD_CODITE = :CODITE';
	strSQL := strSQL + '    GROUP BY GAD_NUMDOC,';
	strSQL := strSQL + '      GAD_ESPDOC) AS TMPGAD';
	strSQL := strSQL + '    ON TMPGAD.NUMDOC = DET_NUMDOC';
	strSQL := strSQL + '    AND TMPGAD.ESPDOC = DET_ESPDOC';
	strSQL := strSQL + '    AND TMPGAD.EMPDOC = DET_CODEMP';

  if blnTodosDocumento then
  begin
    //Obtendo saldo pendente de garantia FF de processo iniciado antes da confirmação do documento
    strSQL := strSQL + ' LEFT JOIN (SELECT "NOTGER" AS GFF_TABELA, D.DET_CODITE AS GFF_CODITE, D.DET_CODCLI AS GFF_CODCLI, ';
    strSQL := strSQL + '                   D.DET_ESPDOC AS GFF_ESPDOC, D.DET_NUMDOC AS GFF_NUMDOC, D.DET_CODEMP AS GFF_CODEMP, ';
    strSQL := strSQL + '                   ((IFNULL(GD.GAD_QTDREQ,0) - IFNULL(GD.GAD_QTDDEV,0) - IFNULL(GD.GAD_QTDPRE,0))) AS GFF_GAR_FF ';
    strSQL := strSQL + '            FROM NOTDET D ';
    strSQL := strSQL + '            JOIN MOVGER G2 ON G2.GER_JAFATU = "1" AND G2.GER_TIPFAT = D.DET_ESPDOC ';
    strSQL := strSQL + '                        AND G2.GER_EMPFAT = D.DET_CODEMP AND G2.GER_CLIFAT = D.DET_CODCLI AND G2.GER_NUMFAT = D.DET_NUMDOC ';
    strSQL := strSQL + '            JOIN MOVDET D2 ON D2.DET_SEQGER = G2.AUTOINCREM AND D2.DET_CODITE = D.DET_CODITE ';
    strSQL := strSQL + '            JOIN MOVGRC C ON C.GRC_INCORI = D2.AUTOINCREM AND (NOT C.GRC_OPCDOC IN ("GC","OU")) ';
    strSQL := strSQL + '            JOIN MOVGAD GD ON GD.AUTOINCREM = C.GRC_SEQGAD AND GD.GAD_CODITE = D2.DET_CODITE AND GD.GAD_NUMDOC = D2.DET_NUMDOC ';
    strSQL := strSQL + '                        AND GD.GAD_ESPDOC = D2.DET_ESPDOC AND GD.GAD_CODEMP = D2.DET_CODEMP ';
    strSQL := strSQL + '            JOIN MOVGAG GG ON GG.AUTOINCREM = GD.GAD_SEQGAG AND GG.GAG_CODCLI = D2.DET_CODCLI ';
    strSQL := strSQL + '            WHERE G2.GER_ESPDOC = "FF" ';
    strSQL := strSQL + '            GROUP BY GFF_TABELA, D.DET_CODITE, D.DET_CODCLI, D.DET_ESPDOC, D.DET_NUMDOC, D.DET_CODEMP) GFF ';
    strSQL := strSQL + ' ON GFF.GFF_CODITE = :CODITE AND GFF.GFF_NUMDOC = DET_NUMDOC AND GFF.GFF_CODCLI = :CODCLI AND GFF.GFF_TABELA = TABELA ';
    strSQL := strSQL + '     AND GFF.GFF_ESPDOC = DET_ESPDOC AND GFF_CODEMP = DET_CODEMP ';
  end;

  If (Not fClienteFilial(strCodCli)) then
    strSQL := strSQL + ' HAVING DISPON  > 0 ';

	strSQL := strSQL + ' ORDER BY DTAENT, ';
	strSQL := strSQL + '  DET_ESPDOC,';
	strSQL := strSQL + '  DET_NUMDOC;';

  With qryTmp Do
    Try
      Close;
      SQL.Clear;

      SQL.Add(strSQL);

      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CLAFIS').AsString := VS_strClaVen;

      If blnDevolu Then
        ParamByName('CLADEV').AsString := VS_strClaDev;

      if not fEmptyStr(strPlaVei) then
        ParamByName('PLAVEI').AsString := strPlaVei;

      Open;

      If Not IsEmpty Then
        Result := True;

    Except
      On E: Exception Do
        Raise Exception.Create(E.Message + ' - [fCarregaDocVendas]');
    End;
end;

function TMovGad.fCarregaProdutosNaoEnviadoFornec(strDescri, strRefere, strDtaIni, strDtaFin: String;
  edtCodFor, edtCodMar: TEditFocus; mskLinGru: TMaskEditFocus;
  arrFornecedor, arrMarca, arrLinhaGrupo: TConsultasArray; Var qryProdNaoEnv: TUniQuery): Boolean;
  Var
    strSQL,
    strFor,
    strMar,
    strLin: String;
    qryGen: TUniQuery;
    dtaIni,
    dtaFin: TDateTime;
begin
  dtaIni := 0;
  dtaFin := 0;
  Result := False;

  qryGen := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   GAG_NUMENT AS NUMENT, ';
  strSQL := strSQL + '   GAD_CODITE AS CODITE, ';
  strSQL := strSQL + '   ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '   GAD_CODFOR AS CODFOR, ';
  strSQL := strSQL + '   CADFOR.FOR_NOMFOR AS NOMFOR, ';
  strSQL := strSQL + '   GAG_DTAENT AS DTAENT, ';
  strSQL := strSQL + '   GAD_QTDREQ AS QTDREQ, ';
  strSQL := strSQL + '   GAD_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '   GAD_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '   GAD_CODEMP AS EMPDOC, ';
  strSQL := strSQL + '   GAG_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   GAD_REPOST AS REPOST, ';
  strSQL := strSQL + '   GAD_VALITE AS VALITE, ';
  strSQL := strSQL + '   GAD_QTDDEV AS QTDDEV, ';
  strSQL := strSQL + '   GAD_OBSP_1 AS OBSP_1, ';
  strSQL := strSQL + '   GAD_OBSP_2 AS OBSP_2, ';
  strSQL := strSQL + '   GAD_GARFIL AS GARFIL, ';
  strSQL := strSQL + '   MOVGAD.AUTOINCREM AS AUTINC, ';

  strSQL := strSQL + '   G.ITE_CODITE AS UC_CODITE, ';
  strSQL := strSQL + '   CONCAT(G.ITE_FORULT, "-", FU.FOR_NOMFOR) AS UC_FORNEC, ';
  strSQL := strSQL + '   G.ITE_QTDUCO AS UC_QTDITE, ';
  strSQL := strSQL + '   G.ITE_DTAULT AS UC_DTAENT ';

  strSQL := strSQL + ' FROM MOVGAD ';
  strSQL := strSQL + ' INNER JOIN MOVGAG ON MOVGAG.AUTOINCREM = MOVGAD.GAD_SEQGAG ';
  strSQL := strSQL + ' INNER JOIN CADITE ON CADITE.ITE_CODITE = MOVGAD.GAD_CODITE ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = GAD_CODITE AND G.ITE_CODEMP = GAG_CODEMP ';
  strSQL := strSQL + ' INNER JOIN CADUNI ON CADUNI.UNI_CODUNI = CADITE.ITE_CODUNI ';
  strSQL := strSQL + ' INNER JOIN CADFOR ON CADFOR.FOR_CODFOR = MOVGAD.GAD_CODFOR ';
  strSQL := strSQL + '  LEFT JOIN CADFOR FU ON FU.FOR_CODFOR = G.ITE_FORULT ';


  If fCfgSis('GARMAT', varBoolean) Then
  Begin
    strSQL := strSQL + '  LEFT JOIN SEQGAR  ON SEQ_MOVGAD = MOVGAD.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN PCMDET ON PCMDET.AUTOINCREM = SEQ_PCMDET  ';
  End;


  strSQL := strSQL + ' WHERE (SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = MOVGAD.AUTOINCREM) IS NULL ';

  If (fCfgSis('OUSAFO', varString) = '2') Then
  Begin
    strSQL := strSQL + ' AND IFNULL((SELECT SUM(DEG_QTDENV)                               ';
    strSQL := strSQL + '    FROM ESPDEG                                                   ';
    strSQL := strSQL + '      INNER JOIN ESPDET ON ESPDET.AUTOINCREM = DEG_SEQGER         ';
    strSQL := strSQL + '      INNER JOIN ESPGER ON ESPGER.AUTOINCREM = DET_SEQGER         ';
    strSQL := strSQL + '    WHERE DEG_SEQGAD = MOVGAD.AUTOINCREM                          ';
    strSQL := strSQL + '      AND GER_MOVGER IS NULL AND ESPGER.GER_TIP_FC = "F"),0)  = 0 ';
  End;

  If fCfgSis('GARMAT', varBoolean) Then
    strSQL := strSQL + ' AND ((PCD_BAIXAD IS NULL AND GAG_CODEMP = :CODEMP) OR (PCD_BAIXAD = 1 AND GAD_GARFIL = "N")) '
  Else
    strSQL := strSQL + ' AND GAG_CODEMP = :CODEMP ';

  strSQL := strSQL + '  AND IFNULL(GAD_MOTBAI, "") = "" ';

  If Not fEmptyStr(edtCodFor.Text) Then
    strSQL := strSQL + fStrLocate(edtCodFor,arrFornecedor,'GAD_CODFOR','CODFOR');

  If Not fEmptyStr(edtCodMar.Text) Then
    strSQL := strSQL + fStrLocate(edtCodMar,arrMarca,'ITE_CODMAR','CODMAR');

  If Not fEmptyStr(mskLinGru.Text) Then
    strSQL := strSQL + fStrLocateLinGru(mskLinGru,arrLinhaGrupo,'ITE_CODGRU','CODGRU');

  If Not fEmptyStr(strDescri) Then
    strSQL := strSQL + ' AND ITE_DESITE LIKE "%' + strDescri + '%"';

  If Not fEmptyStr(strRefere) Then
    strSQL := strSQL + ' AND ITE_REFERE LIKE "%' + strRefere + '%"';

  If (Not fEmptyStr(fTiraCaracEspeciais(strDtaIni))) And (Not fEmptyStr(fTiraCaracEspeciais(strDtaFin))) Then
  Begin
    dtaIni := StrToDate(strDtaIni);
    dtaFin := StrToDate(strDtaFin);

    If (dtaIni > 0) And (dtaFin > 0) Then
      strSQL := strSQL + ' AND CAST(GAG_DTAENT AS DATE) BETWEEN :DTAINI AND :DTAFIN ';
  End;

  Try
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If Not fEmptyStr(edtCodFor.Text) Then
        pSetaParam(edtCodFor.Text,arrFornecedor,strFor,'CODFOR', qryGen);

      If Not fEmptyStr(edtCodMar.Text) Then
        pSetaParam(edtCodMar.Text,arrMarca,strMar,'CODMAR', qryGen);

      If Not fEmptyStr(mskLinGru.Text) Then
        pSetaParam(mskLinGru.Text,arrLinhaGrupo,strLin,'CODGRU', qryGen);

      If (dtaIni > 0) And (dtaFin > 0) Then
      Begin
        ParamByName('DTAINI').AsDate := dtaIni;
        ParamByName('DTAFIN').AsDate := dtaFin;
      End;


      Open;

      If Not IsEmpty Then
        Result := True;

      qryProdNaoEnv := qryGen;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fCarregaProdutosNaoEnviadoFornec]');
    End;
  End;
end;

function TMovGad.fCriarGAGRFG(pstrCodFor: String; out pstrIncRFG: String): Boolean;
  Var
    lSql: String;
    Qry: TUniQuery;

    lstrNumDoc: String;

begin
  Result := True;
  pstrIncRFG := EmptyStr;
  lSql := ' INSERT INTO GAGRFG (AUTOINCREM, RFG_CODFOR, RFG_DTAENT, RFG_NUMDOC, RFG_ESPDOC, RFG_CODEMP) ';
  lSql := lSql + ' VALUES (:AUTOINCREM, :RFG_CODFOR, :RFG_DTAENT, :RFG_NUMDOC, :RFG_ESPDOC, :RFG_CODEMP) ';
  pstrIncRFG := fRetAutoIncrem('GAGRFG', VS_strCodEmp);

  Qry := Nil;
  Try
    Try
      lstrNumDoc := fAtualizaProCod('GAGRFG', 'RFG_NUMDOC', '', 1, Nil,
        function (const AValue: String) : String
        begin
          Result := fStrZero(AValue, 12);
        end
      );

      Qry := fCriaQuery;
      Qry.Close;
      Qry.Sql.Clear;
      Qry.Sql.Add(lSql);
      Qry.ParamByName('AUTOINCREM').AsString := pstrIncRFG;
      Qry.ParamByName('RFG_CODFOR').AsString := pstrCodFor;
      Qry.ParamByName('RFG_DTAENT').AsDate := fNow;
      Qry.ParamByName('RFG_NUMDOC').AsString := lstrNumDoc;
      Qry.ParamByName('RFG_ESPDOC').AsString := 'GR';
      Qry.ParamByName('RFG_CODEMP').AsString := VS_strCodEmp;
      Qry.Execute;

    Except
      On E: Exception do
      begin
        Result := False;
        pMensagensErro(e.Message, '[TMovGad.fCriarGAGRFG]');
        pstrIncRFG := EmptyStr;
        Exit;
      End;
    End;

  Finally
    if Assigned(Qry) Then
      FreeAndNil(Qry);
  End;
end;

class function TMovGad.fCriarMovGaeTemporaria: Boolean;
Var
  lSql: String;
  lQry: TUniQuery;
begin
  lSql :=         ' CREATE TEMPORARY TABLE IF NOT EXISTS TMP_MOVGAE ';
  lSql :=  lSql + ' SELECT * FROM MOVGAE WHERE FALSE';

  lQry := fCriaQuery;
  Try
    lQry.close;
    lQry.Sql.Clear;
    lQry.Sql.Add(lSql);
    lQry.ExecSQL;
    Result := True;
  Finally
    lQry.Free;
  End;
end;

function TMovGad.fGravarDocRFG(var pstrIncRFG: String; pstrCodFor: String;
  pTipoRetorno: TTipoRetorno; pblnBaixa: Boolean; pstrIncGau,
  pstrIncGae: String;const pfltQtdRet, pfltQtdRef: Double): Boolean;
  Var
    lQtdRfdBAI, lQtdRfdREF, lQtdRfdRET: Double;
begin
  lQtdRfdBAI := 0;
  lQtdRfdREF := pfltQtdRef;
  lQtdRfdRET := pfltQtdRet;

  Result := Not fEmptyStr(pstrIncRFG);
  Try
    if Not Result  then
      Result := fCriarGAGRFG(pstrCodFor, pstrIncRFG);

    if Not Result then
      Exit;

    if pTipoRetorno = trRetorno then
    begin
      if pblnBaixa then
      begin
        lQtdRfdBAI := lQtdRfdRET;
        lQtdRfdRET := 0;
      end;
    end;

    Result := fGravarGAGRFD(pstrIncRFG,
                            pstrIncGau,
                            pstrIncGae,
                            lQtdRfdRET,
                            lQtdRfdREF,
                            lQtdRfdBAI);

  Except
    On E: Exception do
    begin
      raise e;
    end;
  End;
end;

class function TMovGad.fGravarGaeTemporaria(const pstrAutInc,
                                                  pstrIncGad: String;
                                            const pfltQtdEnv,
                                                  pfltPreCus: Double;
                                            const pdtaDtaEnv: TDate): Boolean;
Var
  lSql: String;
  lQry: TUniQuery;
begin
  lSql :=        ' INSERT INTO TMP_MOVGAE (';
  lSql := lSql + '   AUTOINCREM, ';
  lSql := lSql + '   GAE_SEQGAD, ';
  lSql := lSql + '   GAE_QTDENV, ';
  lSql := lSql + '   GAE_PRECUS, ';
  lSql := lSql + '   GAE_DTAENV) ';
  lSql := lSql + ' VALUES( ';
  lSql := lSql + '   :AUTINC, ';
  lSql := lSql + '   :INCGAD, ';
  lSql := lSql + '   :QTDENV, ';
  lSql := lSql + '   :PRECUS, ';
  lSql := lSql + '   :DTAENV) ';

  lQry := fCriaQuery;

  Try
    lQry.Close;
    lQry.Sql.Clear;
    lQry.Sql.Add(lSql);
    lQry.ParamByName('AUTINC').AsString := pstrAutInc;
    lQry.ParamByName('INCGAD').AsString := pstrIncGad;
    lQry.ParamByName('QTDENV').AsFloat := pfltQtdEnv;
    lQry.ParamByName('PRECUS').AsFloat := pfltPreCus;
    lQry.ParamByName('DTAENV').AsDateTime := pdtaDtaEnv;
    lQry.ExecSQL;
    Result := lQry.RowsAffected = 1;
  Finally
    lQry.Free;
  End;
end;

function TMovGad.fGravarGAGRFD(pstrAutInc, pstrIncGau, pstrIncGae: String;
  pfltQtdRet, pfltQtdRef, pfltQtdBai: Double): Boolean;
  Var
    lSql: String;
    Qry: TUniQuery;
begin
  Result := True;

  lSql := ' INSERT INTO GAGRFD (AUTOINCREM, RFD_SEQGAU, RFD_QTDRET, RFD_QTDREF, RFD_QTDBAI, RFD_VALITE, RFD_UNICON) ';

  lSql := lSql + ' SELECT :AUTOINCREM, ';
  lSql := lSql + '        :RFD_SEQGAU, ';
  lSql := lSql + '        :RFD_QTDRET, ';
  lSql := lSql + '        :RFD_QTDREF, ';
  lSql := lSql + '        :RFD_QTDBAI, ';
  lSql := lSql + '        IFNULL(MD.UNICON,0), ';
  lSql := lSql + '        IFNULL(MD.VALITE,0)';
  lSql := lSql + ' FROM  MOVGAE E ';
  lSql := lSql + ' LEFT JOIN (SELECT T.AUTOINCREM, T.DET_QTDITE, ';
  lSql := lSql + '                   (T.DET_VLRCON/T.DET_QTDITE) AS UNICON, ';
  lSql := lSql + '                   (T.DET_TOTITE/T.DET_QTDITE) AS VALITE ';
  lSql := lSql + '            FROM MOVDET T) MD ON MD.AUTOINCREM = E.GAE_INCENV ';
  lSql := lSql + ' WHERE E.AUTOINCREM = :INCGAE ';

  Qry := Nil;
  Try
    Try
      Qry := fCriaQuery;
      Qry.Close;
      Qry.Sql.Clear;
      Qry.Sql.Add(lSql);
      Qry.ParamByName('AUTOINCREM').AsString := pstrAutInc;
      Qry.ParamByName('RFD_SEQGAU').AsString := pstrIncGau;
      Qry.ParamByName('INCGAE').AsString := pstrIncGae;
      Qry.ParamByName('RFD_QTDRET').AsFloat := pfltQtdRet;
      Qry.ParamByName('RFD_QTDREF').AsFloat := pfltQtdRef;
      Qry.ParamByName('RFD_QTDBAI').AsFloat := pfltQtdBai;
      Qry.Execute;
    Except
      On E: Exception do
      begin
        Result := False;
        pMensagensErro(e.Message, '[TMovGad.fGravarGAGRFD]');
        Exit;
      End;
    End;

  Finally
    if Assigned(Qry) Then
      FreeAndNil(Qry);
  End;
end;

{*******************************************}
{* APAGA MOVGAU NÃO CONFIRMADO             *}
{****************************************MM*}
procedure TMovGad.pApagaMovGau;
  Var
    qryTmp: TUniQuery;
begin
  If stlIncGau.Count <= 0 Then
    Exit;

  qryTmp := fCriaQuery;

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM MOVGAU ');
    SQL.Add('WHERE AUTOINCREM IN ( ' + fCommaText(stlIncGau, True) + ')');
    ExecSQL;

  End;

  FreeAndNil(qryTmp);
end;

class procedure TMovGad.pApagarMovGaeTemporaria;
Var
  lQry: TUniQuery;
begin
  lQry := fCriaQuery;
  Try
    lQry.close;
    lQry.Sql.Clear;
    lQry.Sql.Add('DROP TEMPORARY TABLE IF EXISTS TMP_MOVGAE');
    lQry.ExecSQL;
  Finally
    lQry.Free;
  End;
end;

{*******************************************}
{* CARREGA MOVGAD                          *}
{****************************************RL*}
procedure TMovGad.pCarregaDadosGarantia(strCodIte:String; dtaMovimento:TDate=0);
  var
    qryGarTmp : TUniQuery;
    strSQL : String;
  const
    fltMes = 30.4375;
begin
  { RETORNA QUANTIDADE DE MESES DE GARANTIA DO PRODUTO }

  if (fEmptyStr(strCodIte)) then
    Exit; // variaveis devem estar preenchidas

  try
    qryGarTmp := fCriaQuery(nil);
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + ' ITE_TMPGAR';
    strSQL := strSQL + ' FROM';
    strSQL := strSQL + ' CADITE';
    strSQL := strSQL + ' WHERE';
    strSQL := strSQL + ' ITE_CODITE = "' + strCodIte + '"';

    with qryGarTmp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := strSQL;
      Open;
    end;

    if (Not qryGarTmp.IsEmpty) then
    begin
      if ( qryGarTmp.FieldByName('ITE_TMPGAR').AsInteger > 0 ) and ( fCfgSis('GARANT') = 'S' ) then
      begin
        intPrazo := (qryGarTmp.FieldByName('ITE_TMPGAR').AsInteger);
        dtaLimite :=  dtaMovimento + Round(intPrazo * fltMes);
        intDias := DaysBetween(Date, dtaMovimento);
        blnTemGarantia := True;

        if ( intDias > 365 ) then
          blnMaisDeUmAno := True
        Else
          blnMaisDeUmAno := False;
      end
      else if ( qryGarTmp.FieldByName('ITE_TMPGAR').AsInteger <= 0 ) and ( fCfgSis('GARANT') = 'S' ) then
      begin
        intPrazo := 0;
        dtaLimite := 0;
      end
      else if ( fCfgSis('GARANT') = 'N' ) then
      begin
        intPrazo := 0;
        dtaLimite := 0;
        blnMaisDeUmAno := False;
        blnTemGarantia := False;
      end;
    end
    else
    begin
      intPrazo := 0;
      dtaLimite := 0;
      blnTemGarantia := False;
    end;
  finally
    FreeAndNil(qryGarTmp);
  end;
end;

procedure TMovGad.pCarregaMovGad(strSeqGag: String);
  Var
    strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GAD_SEQGAG, ';
    strSQL := strSQL + '  GAD_NUMDOC, ';
    strSQL := strSQL + '  GAD_ESPDOC, ';
    strSQL := strSQL + '  GAD_REPOST, ';
    strSQL := strSQL + '  GAD_VALITE, ';
    strSQL := strSQL + '  GAD_CODITE, ';
    strSQL := strSQL + '  GAD_QTDREQ, ';
    strSQL := strSQL + '  GAD_QTDDEV, ';
    strSQL := strSQL + '  GAD_QTDPRE, ';
    strSQL := strSQL + '  GAD_QTDRET, ';
    strSQL := strSQL + '  GAD_QTDREF, ';
    strSQL := strSQL + '  GAD_PRECUS, ';
    strSQL := strSQL + '  GAD_OBSP_1, ';
    strSQL := strSQL + '  GAD_OBSP_2, ';
    strSQL := strSQL + '  GAD_GARFIL, ';
    strSQL := strSQL + '  GAD_DTADEV, ';
    strSQL := strSQL + '  GAD_CODEMP, ';
    strSQL := strSQL + '  AUTOINCREM, ';
    strSQL := strSQL + '  GAD_NUMLOT, ';
    strSQL := strSQL + '  GAD_DTACRE, ';
    strSQL := strSQL + '  GAD_HRACRE, ';
    strSQL := strSQL + '  GAD_OPECRE, ';
    strSQL := strSQL + '  GAD_CODFOR, ';
    strSQL := strSQL + '  GAD_SEQDOC, ';
    strSQL := strSQL + '  GAD_SCREDI, ';
    strSQL := strSQL + '  GAD_COLETA,  ';
    strSQL := strSQL + '  GAD_UNICRD  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGAD ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GAD_SEQGAG = :SEQGAG ';

    With qryMovGad Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('SEQGAG').AsString := strSeqGag;

      Open;
     End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + ' - [pCarregaMovGad]');
  End;

end;

function TMovGad.fDeletaMovGad(strSeqGag, strAutInc, strCodIte: String): Boolean;
Var
  qryTmp: TUniQuery;
  strSQL: String;
  LQryAux: TUniQuery;
begin
  Result := True;

  qryTmp := fCriaQuery;
  LQryAux:= fCriaQuery;

  LQryAux.SQL.Add(sqlItensParaAtualizar);
  LQryAux.ParamByName('SEQGAG').AsString := strSeqGag;
  LQryAux.ParamByName('INCREM').AsString := strAutInc;
  LQryAux.ParamByName('ITENS').AsString  := strCodIte;
  LQryAux.Open();

  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  MOVGAD ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GAD_SEQGAG = :SEQGAG AND ';
  strSQL := strSQL + '  AUTOINCREM IN (' + strAutInc + ') AND ';
  strSQL := strSQL + '  GAD_CODITE IN (' + strCodIte + ') ';

  Try
    With qryTmp Do
    Begin
      Try
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('SEQGAG').AsString := strSeqGag;
        ExecSQL;

        While (Not LQryAux.Eof) Do
        Begin
          ReprocessarItem(LQryAux.FieldByName('GAD_CODITE').AsString, '', False);
          LQryAux.Next();
        End;

      Except
        On E: Exception Do
        Begin
          Result := False;
          Raise Exception.Create('Erro ao deletar item(s)! ' + E.Message + ' - [fDeletaMovGad]');
        End
      End;
    End;
  Finally
    FreeAndNil(qryTmp);
    FreeAndNil(LQryAux);
  End;

end;

{*******************************************}
{* EXLCUI GARANTIA                         *}
{****************************************RL*}
procedure TMovGag.pDeletaGarantia(strSeqGag: String);
  Var
    qryTmp: TUniQuery;
    strSQL: String;
    LQryAux: TUniQuery;
begin
  qryTmp := fCriaQuery;
  LQryAux:= fCriaQuery;

  Try

    Try
      LQryAux.SQL.Add(sqlItensParaAtualizar);
      LQryAux.ParamByName('SEQGAG').AsString := strSeqGag;
      LQryAux.ParamByName('INCREM').AsString := '';
      LQryAux.ParamByName('ITENS').AsString  := '';
      LQryAux.Open();

      fStartTransaction;

      {*******************************************}
      {* MOVGAD                                  *}
      {****************************************RL*}
      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  MOVGAD ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  GAD_SEQGAG = :SEQGAG ';

      With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('SEQGAG').AsString := strSeqGag;
        ExecSQL;
      End;

      {*******************************************}
      {* MOVGAD                                  *}
      {****************************************RL*}
      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  MOVGAG ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  AUTOINCREM = :SEQGAG ';

      With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('SEQGAG').AsString := strSeqGag;
        ExecSQL;
      End;

      While (Not LQryAux.Eof) Do
      Begin
        ReprocessarItem(LQryAux.FieldByName('GAD_CODITE').AsString, '', False);
        LQryAux.Next();
      End;

      fCommit;

    Except
      On E: Exception Do
      Begin
       pMensagensErro(E.Message,'[TMovGag.pDeletaGarantia]');	
       fRollBack;

      End;
    End;

  Finally;
    FreeAndNil(qryTmp);
  End;

end;

{*********************************************}
{* CARREGA OS PRODUTOS COM PROBLEMA QUE       }
{* AINDA NÃO FORAM ENVIADOS PARA O FORNECEDOR }
{******************************************RL*}
procedure TMovGad.pCarregaProdutosTroca(strCodFor: String; edtMarca : TEditFocus; arrMarca : TConsultasArray);
  Var
    strSQL: String;
    strLinha: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MOVGAD.AUTOINCREM AS "AUTINC", ';
    strSQL := strSQL + '  MOVGAD.GAD_CODFOR AS "CODFOR", ';
    strSQL := strSQL + '  GAD_CODITE        AS "CODITE", ';
    strSQL := strSQL + '  ITE_DESITE        AS "DESITE", ';
    strSQL := strSQL + '  ITE_REFERE        AS "REFERE", ';
    strSQL := strSQL + '  IFNULL(GAD_CODFAB,ITE_CODFAB) AS "CODFAB", ';
    strSQL := strSQL + '  UNI_DESUNI        AS "UNIDAD", ';
    strSQL := strSQL + '  DATE(GAG_DTAENT)  AS "DTAENT", ';
    strSQL := strSQL + '  GAG_NUMENT        AS "NUMENT", ';
    strSQL := strSQL + '  CONCAT(GAD_NUMDOC, "-", GAD_ESPDOC)  AS "NUMDOC", ';
    strSQL := strSQL + '  CAST(NULL AS DATE) AS "DTAENV", ';
    strSQL := strSQL + '  GAD_CODEMP AS CODEMP, ';

    strSQL := strSQL + '  GAD_QTDREQ - IFNULL((SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = MOVGAD.AUTOINCREM),0) ';

    If (fCfgSis('OUSAFO', varString) = '2') Then
    Begin
      strSQL := strSQL + ' - IFNULL((SELECT SUM(DEG_QTDENV)                         ';
      strSQL := strSQL + '    FROM ESPDEG                                           ';
      strSQL := strSQL + '      INNER JOIN ESPDET ON ESPDET.AUTOINCREM = DEG_SEQGER ';
      strSQL := strSQL + '      INNER JOIN ESPGER ON ESPGER.AUTOINCREM = DET_SEQGER ';
      strSQL := strSQL + '    WHERE DEG_SEQGAD = MOVGAD.AUTOINCREM                  ';
      strSQL := strSQL + '      AND GER_MOVGER IS NULL AND ESPGER.GER_TIP_FC = "F"),0)     ';
    End;

    strSQL := strSQL + ' AS "QTDREQ", ';

    strSQL := strSQL + '  GAG_CODCLI        AS "CODCLI", ';
    strSQL := strSQL + '  CLI_NOMCLI        AS "NOMCLI", ';
    strSQL := strSQL + '  GAD_PRECUS        AS "PRECUS", ';
    strSQL := strSQL + '  CLI_TABPRE        AS "TABPRE",  ';
    strSQL := strSQL + '  GAD_OBSP_1        AS  "OBSP_1" ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGAG ';
    strSQL := strSQL + '  INNER JOIN MOVGAD ON GAD_SEQGAG = MOVGAG.AUTOINCREM ';
    strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = GAG_CODCLI        ';
    strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = GAD_CODITE        ';
    strSQL := strSQL + '  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI        ';


    If fCfgSis('GARMAT', varBoolean) Then
    Begin
      strSQL := strSQL + '  LEFT JOIN SEQGAR  ON SEQ_MOVGAD = MOVGAD.AUTOINCREM ';
      strSQL := strSQL + '  LEFT JOIN PCMDET ON PCMDET.AUTOINCREM = SEQ_PCMDET  ';
    End;

    strSQL := strSQL + 'WHERE GAD_CODFOR = :CODFOR  ';
    strSQL := strSQL + ' AND  GAD_COLETA <> ''S'' ';

    strSQL := strSQL + fStrLocate(edtMarca, arrMarca, 'ITE_CODMAR', 'CODMAR');

    If fCfgSis('GARMAT', varBoolean) Then
      strSQL := strSQL + '  AND ((PCD_BAIXAD IS NULL AND GAG_CODEMP = :CODEMP) OR (PCD_BAIXAD = 1 AND GAD_GARFIL = "N"))  '
    Else
      strSQL := strSQL + '  AND GAG_CODEMP = :CODEMP  ';

    If fUsaRotinaGarantiaItensPesados Then
      strSQL := strSQL + ' AND GAD_GARFIL = "S" ';

    strSQL := strSQL + ' AND GAG_GARIND <> "S" ';

    strSQL := strSQL + ' AND IFNULL(GAD_MOTBAI, "") <> "Emissão de Perda/Transferência de Produtos Refugados" ';

    strSQL := strSQL + ' HAVING QTDREQ > 0 ';

    With qryFornec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODFOR').AsString := strCodFor;
      pSetaParam(edtMarca.Text, arrMarca, strLinha, 'CODMAR', qryfornec);
      If FindParam('CODEMP') <> Nil Then
        ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + ' - [pCarregaProdutosTroca]');
  End;

end;

class procedure TMovGad.pGravaRelacionamentoMovGae(strNumero, strEspDoc, strSerDoc, strCodEmp, strAutIncMovGae: String; VS_Date: TDate);
var qryUpdate, qryDocVen: TUniQuery;
    qryDados: TZClient;
    strSQL: String;
    fltQtd : Double;
    intQtdLoop: integer;


begin
  qryDocVen := fCriaQuery;
  qryUpdate := fCriaQuery;

  Try
    Try
      qryDocVen.SQL.Add('SELECT M.AUTOINCREM, M.DET_QTDITE, M.DET_UNITAR, DET_CODITE');
      qryDocVen.SQL.Add('  FROM MOVDET M');
      qryDocVen.SQL.Add('WHERE M.DET_NUMDOC = :NUMDOC');
      qryDocVen.SQL.Add('  AND M.DET_ESPDOC = :ESPDOC');
      qryDocVen.SQL.Add('  AND M.DET_CODEMP = :CODEMP');
      qryDocVen.SQL.Add('  AND M.DET_SERIE_ = :SERIE_');
      qryDocVen.SQL.Add('  ORDER BY DET_CODITE, DET_QTDITE DESC');


      strSQL := '';
      strSQL :=  strSQL + '  SELECT E.AUTOINCREM, GAE_PRECUS, GAE_QTDENV, GAE_INCENV, GAD_CODITE   FROM ';
      strSQL :=  strSQL + '  MOVGAE E ';
      strSQL :=  strSQL + '  INNER JOIN MOVGAD D ON D.AUTOINCREM= E.GAE_SEQGAD ';
      strSQL :=  strSQL + '  WHERE E.AUTOINCREM IN ('+ strAutIncMovGae + ') ';
      strSQL :=  strSQL + '  ORDER BY GAD_CODITE, GAE_QTDENV DESC ';

      qryDados := TZClient.Create(nil, strSQL);


      qryDocVen.ParamByName('NUMDOC').AsString := strNumero;
      qryDocVen.ParamByName('ESPDOC').AsString := strEspDoc;
      qryDocVen.ParamByName('CODEMP').AsString := strCodEmp;
      qryDocVen.ParamByName('SERIE_').AsString := strSerDoc;


      qryDocVen.Open;
      If qryDocVen.IsEmpty Then
        Exit;

      qryDados.fAbreClient(True, '[TMovGad.pGravaRelacionamentoMovGae]');

      while not qryDocVen.Eof Do
      Begin

        qryDados.Filtered := False;
        qryDados.Filter := 'GAD_CODITE = ' + QuotedStr(qryDocVen.FieldByName('DET_CODITE').AsString);
        qryDados.Filtered := True;

        fltQtd :=  qryDocVen.FieldByName('DET_QTDITE').AsFloat;

        If qryDados.RecordCount > 0 Then
        Begin
          intQtdLoop := 1;

          While fltQtd > 0 Do
          Begin
            case intQtdLoop of
             //Relaciona por quantidade e preco de custo
             1: Begin
                  If (qryDados.FieldByName('GAE_PRECUS').AsFloat  = qryDocVen.FieldByName('DET_UNITAR').ASFloat) and
                     (qryDados.FieldByName('GAE_QTDENV').AsFloat  = qryDocVen.FieldByName('DET_QTDITE').ASFloat) And
                     (qryDados.FieldByName('GAE_INCENV').AsString = '') Then
                  Begin
                    fltQtd := fltQtd - qryDados.FieldByName('GAE_QTDENV').AsFloat;
                    qryDados.Edit;
                    qryDados.FieldByName('GAE_INCENV').AsString := qryDocVen.FieldByName('AUTOINCREM').AsString;
                    qryDados.Post;
                  End;

                End;
                //Relaciona por preco de custo
             2: Begin
                  If (qryDados.FieldByName('GAE_PRECUS').AsFloat  = qryDocVen.FieldByName('DET_UNITAR').ASFloat) And
                     (qryDados.FieldByName('GAE_INCENV').AsString = '') Then
                  Begin
                    fltQtd := fltQtd - qryDados.FieldByName('GAE_QTDENV').AsFloat;
                    qryDados.Edit;
                    qryDados.FieldByName('GAE_INCENV').AsString := qryDocVen.FieldByName('AUTOINCREM').AsString;
                    qryDados.Post;
                  End;

                End;
              3: //Relaciona com o resto
                Begin
                  If (qryDados.FieldByName('GAE_INCENV').AsString = '') Then
                  Begin
                    fltQtd := fltQtd - qryDados.FieldByName('GAE_QTDENV').AsFloat;
                    qryDados.Edit;
                    qryDados.FieldByName('GAE_INCENV').AsString := qryDocVen.FieldByName('AUTOINCREM').AsString;
                    qryDados.Post;
                  End;

                End;
            End;

            qryDados.Next;

            If qryDados.Eof Then
            Begin
              qryDados.FIrst;
              intQtdLoop := intQtdLoop + 1;
              If intQtdLoop > 3 Then
                 fltQtd := 0;
            End;
          End;
        End;
        qryDocVen.Next;
      End;

      qryDados.Filtered := False;
      qryDados.Filter := 'GAE_INCENV <> ' + QuotedStr('');
      qryDados.Filtered := True;

      qryDados.First;

      while Not qryDados.Eof Do
      begin
        qryUpdate.SQL.Clear;
        qryUpdate.SQL.Add('UPDATE MOVGAE SET GAE_INCENV = '+ QuotedStr(qryDados.FieldByName('GAE_INCENV').AsString));
        qryUpdate.SQL.Add(' WHERE AUTOINCREM = ' + QuotedStr(qryDados.FieldByName('AUTOINCREM').AsString));
        qryUpdate.ExecSQL;
        qryDados.Next;
      End;
    Except
      On E: Exception do
      begin
        raise;
        Exit;
      end;
    End;
  Finally
    FreeAndNil(qryDocVen);
    FreeAndNil(qryDados);
    FreeAndNil(qryUpdate);
  End;



end;



class function TMovGad.fAtualizaProdutosTrocaEspelhoConfirmacao(strIncEspGer, strNumero, strEspDoc, strSerDoc, strCodEmp: String; enuTipoEnvioFornecedorGarantia : TTipoEnvioFornecedorGarantia): Boolean;
  Var
    strSQL: String;
    qryUnitar : TUniQuery;
    qryEspDet : TUniQuery;
    qryFornec : TUniQuery;
    blnFinalizar,
    blnFalhaMovGae : Boolean;
    strAutIncMovGae : String;
    blnTransacaoInternaMetodo: boolean;
    strAutIncMovGaeLista: String;
begin
  blnFalhaMovGae := False;
  Result := True;

  Try
    qryFornec := fCriaQuery;
    qryEspDet := fCriaQuery;

    blnFinalizar := fFinalizaGarantiaNoEnvio(enuTipoEnvioFornecedorGarantia);

    With qryEspDet, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT DET_CODITE, DEG_SEQGAD, DEG_QTDENV, GAD_NUMLOT, GAD_CODEMP');
      Add(' FROM ESPDET D                                                    ');
      Add(' INNER JOIN ESPDEG G ON DEG_SEQGER = D.AUTOINCREM                 ');
      Add(' INNER JOIN MOVGAD M ON DEG_SEQGAD = M.AUTOINCREM                 ');
      Add(' WHERE DET_SEQGER = :SEQGER                                       ');

      ParamByName('SEQGER').AsString := strIncEspGer;

      Open;
    End;

    qryUnitar := fCriaQuery;
    With qryUnitar, SQL Do
    Begin
      Close;
      Clear;

      Add(' SELECT DET_UNITAR AS UNITAR ');
      Add(' FROM MOVDET                 ');
      Add(' WHERE DET_NUMDOC = :NUMENV  ');
      Add('   AND DET_ESPDOC = :ESPENV  ');
      Add('   AND DET_SERIE_ = :SERIE_  ');
      Add('   AND DET_CODEMP = :CODEMP  ');
      Add('   AND DET_CODITE = :CODITE  ');
    End;

    blnTransacaoInternaMetodo := False;
    if not fInTransaction then
    begin
      blnTransacaoInternaMetodo := True;
      fStartTransaction;
    end;

    With qryFornec Do
    Begin
      strSQL := '';
      strSQL := strSQL + ' INSERT INTO MOVGAE (AUTOINCREM, GAE_SEQGAD, GAE_NUMENV, GAE_ESPENV, GAE_EMPENV, GAE_SERENV, GAE_DTAENV, GAE_QTDENV, GAE_PRECUS) ';
      strSQL := strSQL + ' VALUES(:AUTINC, :SEQGAD, :NUMENV, :ESPENV, :EMPENV, :SERENV, :DTAENV, :QTDENV, :PRECUS) ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      qryEspDet.First;

      strAutIncMovGaeLista := '"VAZIO"';

      While Not qryEspDet.Eof Do
      Begin

        qryUnitar.Close;
        qryUnitar.ParamByName('NUMENV').AsString := strNumero;
        qryUnitar.ParamByName('ESPENV').AsString := strEspDoc;
        qryUnitar.ParamByName('SERIE_').AsString := strSerDoc;
        qryUnitar.ParamByName('CODEMP').AsString := strCodEmp;
        qryUnitar.ParamByName('CODITE').AsString := qryEspDet.FieldByName('DET_CODITE').AsString;
        qryUnitar.Open;

        strAutIncMovGae := fRetAutoIncrem('MOVGAE', VS_strCodEmp);
        strAutIncMovGaeLista := strAutIncMovGaeLista + ', "' + strAutIncMovGae + '"';

        ParamByName('AUTINC').AsString := strAutIncMovGae;
        ParamByName('SEQGAD').AsString := qryEspDet.FieldByName('DEG_SEQGAD').AsString;

        ParamByName('NUMENV').AsString := strNumero;
        ParamByName('ESPENV').AsString := strEspDoc;
        ParamByName('SERENV').AsString := strSerDoc;
        ParamByName('EMPENV').AsString := strCodEmp;
        ParamByName('DTAENV').AsDateTime := VS_Date;
        ParamByName('QTDENV').AsFloat  := qryEspDet.FieldByName('DEG_QTDENV').AsFloat;
        ParamByName('PRECUS').AsFloat  := qryUnitar.FieldByName('UNITAR').AsFloat;

        ExecSQL;

        If (fCfgSis('GARMAT',varBoolean)) then
          Result := Result and TMovGad.fBaixaPedidoVendaAutIncMovGad(qryEspDet.FieldByName('DEG_SEQGAD').AsString, strNumero, strEspDoc);

        if blnFinalizar then
          pBaixaGarantiaNoEnvio(qryEspDet.FieldByName('DEG_SEQGAD').AsString,
                                strAutIncMovGae,
                                strEspDoc,
                                qryEspDet.FieldByName('DET_CODITE').AsString,
                                qryEspDet.FieldByName('DEG_QTDENV').AsFloat);

        Result := Result and ReprocessarItem(qryEspDet.FieldByName('DET_CODITE').AsString, '', False);
        If not Result Then
          Break;

        qryEspDet.Next;
      End;

    End;

    If Result Then
    begin
      If strAutIncMovGae <> '' Then
      Begin
        TMovGad.pGravaRelacionamentoMovGae(strNumero,
                                   strEspDoc,
                                   strSerDoc,
                                   strCodEmp,
                                   strAutIncMovGaeLista,
                                   VS_Date);

        if Not TMovGad.fTestarGravacaoMovGae(strAutIncMovGaeLista) then
        begin
          blnFalhaMovGae := True;
          raise Exception.Create('Ocorreu uma inconsistência na gravação do envio para fornecedor, contate a Citel!'
                                  +' - [fAtualizaProdutosTroca-fTestarGravacaoMovGae]');
        end;

      End;

      if blnTransacaoInternaMetodo and fInTransaction then
        fCommit;
    End;

    FreeAndNil(qryUnitar);
    FreeAndNil(qryEspDet);
    FreeAndNil(qryFornec);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      if blnFalhaMovGae then
        Raise
      else
        Raise Exception.Create('Erro ao confirmar envio para o fornecedor! ' +
          E.Message +  ' - [fAtualizaProdutosTrocaEspelhoConfirmacao]');
    End;
  End;

End;

{*******************************************************}
{* ATUALIZA DATA DE ENVIO PARA O FORNECEDOR DO PRODUTO *}
{****************************************************RL*}
function TMovGad.fAtualizaProdutosTroca(cdsProdutos: TUniClientDataSet; strNumero, strEspDoc, strSerDoc, strCodEmp: String;
              enuTipoEnvioFornecedorGarantia : TTipoEnvioFornecedorGarantia = tefNulo; cdsGroup : TUniClientDataSet = nil): Boolean;
  Var
    strSQL: String;
    qryUnitar : TUniQuery;
    LQryAux: TUniQuery;
    strAutIncs: String;
    strAutIncMovGae : String;
    blnTransacaoExterna : boolean;
    blnFinalizar: Boolean;
    strAutIncMovGaeLista: String;
    intContarReg, intContarRegNovo: Integer;
begin
  Result := False;
  LQryAux := fCriaQuery();
  qryUnitar := fCriaQuery;
  strAutIncs := '';
  blnTransacaoExterna := frmModulo.Database.InTransaction;

  intContarReg := 0;
  intContarRegNovo := 0;

  Try
    If (fCfgSis('OUSAFO', varString) = '2') And (strEspDoc = 'NF') Then
    Begin
     With qryUnitar, SQL Do
      Begin
        Close;
        Clear;

        Add(' SELECT D.AUTOINCREM ');
        Add(' FROM ESPGER G       ');
        Add('   INNER JOIN ESPDET D ON DET_SEQGER = G.AUTOINCREM ');
        Add(' WHERE GER_NUMESP = :NUMENV  ');
        Add('   AND GER_CODEMP = :CODEMP  ');
        Add('   AND DET_CODITE = :CODITE  ');
      End;

      Try

        if not blnTransacaoExterna then
          fStartTransaction;

        With qryFornec Do
        Begin
            strSQL := '';

            strSQL := strSQL + ' INSERT INTO ESPDEG (AUTOINCREM, DEG_SEQGER, DEG_SEQGAD, DEG_QTDENV) ';
            strSQL := strSQL + ' VALUES(:AUTINC, :ESPDET, :SEQGAD, :QTDENV) ';

            Close;
            SQL.Clear;
            SQL.Add(strSQL);

            cdsProdutos.First;

            While Not cdsProdutos.Eof Do
            Begin

              if cdsProdutos.FieldByName('DTAENV').AsDateTime <> 0 Then
              Begin
                inc(intContarReg);
                qryUnitar.Close;
                qryUnitar.ParamByName('NUMENV').AsString := strNumero;
                qryUnitar.ParamByName('CODEMP').AsString := strCodEmp;
                qryUnitar.ParamByName('CODITE').AsString := cdsProdutos.FieldByName('CODITE').AsString;
                qryUnitar.Open;

                ParamByName('AUTINC').AsString := fRetAutoIncrem('ESPDEG', VS_strCodEmp);
                ParamByName('ESPDET').AsString := qryUnitar.FieldByName('AUTOINCREM').AsString;
                ParamByName('SEQGAD').AsString := cdsProdutos.FieldByName('AUTINC').AsString;
                ParamByName('QTDENV').AsFloat  := cdsProdutos.FieldByName('QTDREQ_1').AsFloat;

                ExecSQL;
                inc(intContarRegNovo);
              End;

              cdsProdutos.Next;

            End;

        End;

        if (intContarReg > 0) And (intContarReg = intContarRegNovo) then
          Result := True
        else
          raise Exception.Create('Ocorreu uma falha ao tentar criar registro ESPDEG.');

        if not blnTransacaoExterna then
          fCommit;

        Result := True;

      Except
        On E: Exception Do
        Begin
          fRollBack;
          Raise Exception.Create('Erro ao confirmar envio para o fornecedor! ' +
            E.Message +  ' - [fAtualizaProdutosTroca]');
        End;
      End;



    End
    Else
    Begin
      cdsProdutos.First;
      With qryUnitar, SQL Do
      Begin
        Close;
        Clear;

        Add(' SELECT * ');
        Add(' FROM TMP_MOVGAE     ');
        Add(' ORDER BY AUTOINCREM ');
      End;

      blnFinalizar := fFinalizaGarantiaNoEnvio(enuTipoEnvioFornecedorGarantia);

      Try
        if not blnTransacaoExterna then
          fStartTransaction;

        With qryFornec Do
        Begin
          strSQL := '';

          strSQL := strSQL + ' INSERT INTO MOVGAE (AUTOINCREM, GAE_SEQGAD, GAE_NUMENV, GAE_ESPENV, GAE_EMPENV, GAE_SERENV, GAE_DTAENV, GAE_QTDENV, GAE_PRECUS, GAE_INCENV)';
          strSQL := strSQL + ' VALUES(:AUTINC, :SEQGAD, :NUMENV, :ESPENV, :EMPENV, :SERENV, :DTAENV, :QTDENV, :PRECUS, :INCENV) ';

          Close;
          SQL.Clear;
          SQL.Add(strSQL);

          cdsProdutos.First;
          strAutIncMovGaeLista := '"VAZIO"';

          qryUnitar.Close;
          qryUnitar.Open;
          qryUnitar.First;

          While Not qryUnitar.Eof  do
          Begin
            if Not cdsProdutos.locate('AUTINC', qryUnitar.FieldByName('GAE_SEQGAD').AsString, []) then
              Raise Exception.Create('Ocorreu uma falha ao tentar criar registro MOVGAE.');

            strAutIncMovGae := fRetAutoIncrem('MOVGAE', VS_strCodEmp);
            strAutIncMovGaeLista := strAutIncMovGaeLista + ', "' + strAutIncMovGae + '"';
            qryFornec.ParamByName('AUTINC').AsString := strAutIncMovGae;
            qryFornec.ParamByName('SEQGAD').AsString := qryUnitar.FieldByName('GAE_SEQGAD').AsString;
            qryFornec.ParamByName('NUMENV').AsString := strNumero;
            qryFornec.ParamByName('ESPENV').AsString := strEspDoc;
            qryFornec.ParamByName('SERENV').AsString := strSerDoc;
            qryFornec.ParamByName('EMPENV').AsString := strCodEmp;
            qryFornec.ParamByName('DTAENV').AsDateTime := qryUnitar.FieldByName('GAE_DTAENV').AsDateTime;
            qryFornec.ParamByName('QTDENV').AsFloat  := qryUnitar.FieldByName('GAE_QTDENV').AsFloat;
            qryFornec.ParamByName('PRECUS').AsFloat := qryUnitar.FieldByName('GAE_PRECUS').AsFloat;
            qryFornec.ParamByName('INCENV').AsString := qryUnitar.FieldByName('GAE_INCENV').AsString;
            qryFornec.ExecSQL;

            strAutIncs := strAutIncs + IIF(fEmptyStr(strAutIncs), '', ', ') +
              cdsProdutos.FieldByName('AUTINC').AsString;

            if blnFinalizar then
              pBaixaGarantiaNoEnvio(qryUnitar.FieldByName('GAE_SEQGAD').AsString,
                                    strAutIncMovGae,
                                    strEspDoc,
                                    cdsProdutos.FieldByName('CODITE').AsString,
                                    qryUnitar.FieldByName('GAE_QTDENV').AsFloat);

            qryUnitar.Next;

          End;

        End;

        If (Not fEmptyStr(strAutIncs)) Then
        Begin
          LQryAux.Close;
          LQryAux.SQL.Clear;
          LQryAux.SQL.Add(sqlItensParaAtualizar);
          LQryAux.ParamByName('SEQGAG').AsString := '';
          LQryAux.ParamByName('INCREM').AsString := strAutIncs;
          LQryAux.ParamByName('ITENS').AsString  := '';
          LQryAux.Open();

          While (Not LQryAux.Eof) Do
          Begin
            ReprocessarItem(LQryAux.FieldByName('GAD_CODITE').AsString, '', False);
            LQryAux.Next();
          End;
        End;


        If strAutIncMovGae <> '' Then
        Begin
          pGravaRelacionamentoMovGae(strNumero,
                                     strEspDoc,
                                     strSerDoc,
                                     strCodEmp,
                                     strAutIncMovGaeLista,
                                     VS_Date);

          if Not fTestarGravacaoMovGae(strAutIncMovGaeLista) then
          begin
            raise Exception.Create('Ocorreu uma inconsistência na gravação do envio para fornecedor, contate a Citel!'
                                    +' - [fAtualizaProdutosTroca-fTestarGravacaoMovGae]');
          end;

        End;

        if not blnTransacaoExterna then
          fCommit;

        Result := True;

      Except
        On E: Exception Do
        Begin
          if not blnTransacaoExterna then
            fRollBack;

          Raise Exception.Create('Erro ao confirmar envio para o fornecedor! ' +
           E.Message +  ' - [fAtualizaProdutosTroca]');
        End;
      End;

    End;
  Finally
    FreeAndNil(LQryAux);
    FreeAndNil(qryUnitar);
  End;
end;

class procedure TMovGad.pBaixaGarantiaNoEnvio(strSeqGad, strSeqGae, strEspDoc, strCodIte : String; fltQuantidade : Double);
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    qryAux.SQL.Text := fSQLInsereTabelaAux;

    qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('MOVGAU', VS_strCodEmp);
    qryAux.ParamByName('SEQGAD').AsString := strSeqGad;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('QTDRET').AsFloat  := fltQuantidade;
    qryAux.ParamByName('QTDREF').AsFloat  := 0.00;
    qryAux.ParamByName('SEQDET').AsString := SEQDET_BAIXA_DEVOLUCAO_ENVIO;
    qryAux.ParamByName('SEQGAE').AsString := strSeqGae;
    qryAux.ExecSQL;


    qryAux.SQL.Clear;
    qryAux.SQL.Add(' UPDATE MOVGAD SET GAD_QTDRET = IFNULL(GAD_QTDRET,0) + :QTDRET, ');
    qryAux.SQL.Add('                   GAD_DTARET = ' + fCurrentDate                 );
    qryAux.SQL.Add(' WHERE AUTOINCREM = :AUTINC                                     ');

    qryAux.ParamByName('QTDRET').AsFloat  := fltQuantidade;
    qryAux.ParamByName('AUTINC').AsString := strSeqGad;
    qryAux.ExecSQL;


    qryAux.SQL.Clear;
    qryAux.SQL.Add(' UPDATE MOVGAE SET GAE_QTDRET = IFNULL(GAE_QTDRET,0) + :QTDRET  ');
    qryAux.SQL.Add(' WHERE AUTOINCREM = :AUTINC                                     ');

    qryAux.ParamByName('QTDRET').AsFloat  := fltQuantidade;
    qryAux.ParamByName('AUTINC').AsString := strSeqGae;
    qryAux.ExecSQL;

  finally
    FreeAndNil(qryAux);
  end;
end;

function TMovGad.fRetornaSeqGarantia(strColuna, strNomFil,
  strValFil: String): String;
Var
  strSQL: String;
  qrySeq: TUniQuery;
begin

  Try

    qrySeq := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL +    strColuna + ' ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  SEQGAR ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL +    strNomFil + ' = :VALFIL ';

    With qrySeq Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALFIL').AsString := strValFil;
      Open;
      Result := FieldByName(strColuna).AsString;
    End;

  Finally
    FreeAndNil(qrySeq);
  End;

end;

function TMovGad.fBaixaPedidoVenda(cdsProdutos: TUniClientDataSet; strNumFat, strTipFat: String): Boolean;
Begin
  Result := True;
  Try
    cdsProdutos.Filter   := 'DTAENV <> 0';
    cdsProdutos.Filtered := True;
    cdsProdutos.First;

    While Not cdsProdutos.Eof Do
    Begin
      TMovGad.fBaixaPedidoVendaAutIncMovGad(cdsProdutos.FieldByName('AUTINC').AsString, strNumFat, strTipFat);
      cdsProdutos.Next;
    End;

  Except
    On E: Exception Do
    Begin
      cdsProdutos.Filter   := '';
      cdsProdutos.Filtered := False;
      Result := False;
      pMensagensErro(E.Message, '[TMovGad.fBaixaPedidoVenda]');
    End;
  End;

  cdsProdutos.Filter   := '';
  cdsProdutos.Filtered := False;
End;


Class function TMovGad.fBaixaPedidoVendaAutIncMovGad(strAutIncMovGad, strNumFat, strTipFat: String): Boolean;
Var
  strSQLFdo: String;
  strNumDoc: String;
  strEspDoc: String;
  strCodEmp: String;
  strAutInc: String;
  qryFdo: TUniQuery;

  function fBaixaFatgor(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    strSQL: String;
    qryFgo: TUniQuery;
  Begin

    Result := False;

    Try

      qryFgo := fCriaQuery(Nil);

      strSQL := '';
      strSQL := strSQL + 'UPDATE   ';
      strSQL := strSQL + '  FATGOR ';
      strSQL := strSQL + 'SET      ';
      strSQL := strSQL + '  FGO_JAFATU = 1, ';
      strSQL := strSQL + '  FGO_NUMFAT = :NUMFAT, ';
      strSQL := strSQL + '  FGO_TIPFAT = :TIPFAT, ';
      strSQL := strSQL + '  FGO_EMPFAT = :EMPFAT  ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  FGO_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  FGO_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  FGO_CODEMP = :CODEMP     ';

      With qryFgo Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMFAT').AsString := strNumFat;
        ParamByName('TIPFAT').AsString := strTipFat;
        ParamByName('EMPFAT').AsString := VS_strCodEmp;
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ExecSQL;
        Result := True;
      End;

    Except
      On E:Exception Do
        pMensagensErro(E.Message,'[fBaixaFatgor]');
    End;

    FreeAndNil(qryFgo);
  End;

  procedure pRetDadosPedido(strAutInc: String; Var strNumDoc: String; Var strEspDoc: String; Var strCodEmp: String);
  Var
    strSQL   : String;
    qryPed: TUniQuery;
  Begin

    Try

      qryPed := fCriaQuery(Nil);

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  FDO_NUMDOC AS NUMDOC, ';
      strSQL := strSQL + '  FDO_ESPDOC AS ESPDOC, ';
      strSQL := strSQL + '  FDO_CODEMP AS CODEMP  ';
      strSQL := strSQL + 'FROM     ';
      strSQL := strSQL + '  FATDOR ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

      With qryPed Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTINC').AsString := strAutInc;
        Open;

        strNumDoc := FieldByName('NUMDOC').AsString;
        strEspDoc := FieldByName('ESPDOC').AsString;
        strCodEmp := FieldByName('CODEMP').AsString;
      End;

    Finally
      FreeAndNil(qryPed);
    End;

  End;

  function fExisteItemAberto(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    strSQL: String;
    qryPed: TUniQuery;
  Begin

    Try

      qryPed := fCriaQuery(Nil);

      strSQL := '';
      strSQL := strSQL + 'SELECT   ';
      strSQL := strSQL + '  FDO_NUMDOC ';
      strSQL := strSQL + 'FROM     ';
      strSQL := strSQL + '  FATDOR ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  FDO_NUMDOC = :NUMDOC AND  ';
      strSQL := strSQL + '  FDO_ESPDOC = :ESPDOC AND  ';
      strSQL := strSQL + '  FDO_CODEMP = :CODEMP AND  ';
      strSQL := strSQL + '  FDO_JAFATU <> 1   ';

      With qryPed Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;
        Result := (Not IsEmpty);
      End;

    Finally
      FreeAndNil(qryPed);
    End;

  End;

  Var
    objMovGadTmp : TMovGad;
begin

  Result := True;

  Try

    objMovGadTmp := TMovGad.Create(Nil);
    strAutInc := objMovGadTmp.fRetornaSeqGarantia('SEQ_FATDOR','SEQ_MOVGAD', strAutIncMovGad);
    FreeAndNil(objMovGadTmp);

    If (Not fEmptyStr(strAutInc)) Then
    Begin

      qryFdo := fCriaQuery(Nil);

      strSQLFdo := '';
      strSQLFdo := strSQLFdo + 'UPDATE   ';
      strSQLFdo := strSQLFdo + '  FATDOR ';
      strSQLFdo := strSQLFdo + 'SET      ';
      strSQLFdo := strSQLFdo + '  FDO_JAFATU = 1, ';
      strSQLFdo := strSQLFdo + '  FDO_NUMFAT = :NUMFAT, ';
      strSQLFdo := strSQLFdo + '  FDO_TIPFAT = :TIPFAT, ';
      strSQLFdo := strSQLFdo + '  FDO_EMPFAT = :EMPFAT  ';
      strSQLFdo := strSQLFdo + 'WHERE    ';
      strSQLFdo := strSQLFdo + '  AUTOINCREM = :AUTINC  ';

      With qryFdo Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQLFdo);
        ParamByName('NUMFAT').AsString := strNumFat;
        ParamByName('TIPFAT').AsString := strTipFat;
        ParamByName('EMPFAT').AsString := VS_strCodEmp;
        ParamByName('AUTINC').AsString := strAutInc;

        ExecSQL;

      End;

      pRetDadosPedido(strAutInc, strNumDoc, strEspDoc, strCodEmp);

      If (Not fExisteItemAberto(strNumDoc, strEspDoc, strCodEmp)) Then
        fBaixaFatgor(strNumDoc, strEspDoc, strCodEmp);

      FreeAndNil(qryFdo);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TMovGad.fBaixaPedidoVenda]');
      Result := False;
    End;
  End;

end;

function TMovGad.fAtualizaSeqGarantia(strColuna, strValCol, strNomFil,
  strValFil: String): Boolean;
Var
  strSQL   : String;
  qrySeq   : TUniQuery;
  blnExiste: Boolean;
begin

  Result    := False;

  Try

    qrySeq := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  *      ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  SEQGAR ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL +    strNomFil + ' = :VALFIL ';

    With qrySeq Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALFIL').AsString := strValFil;
      Open;
      blnExiste := (Not IsEmpty);
    End;

    If (blnExiste) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'UPDATE   ';
      strSQL := strSQL + '  SEQGAR ';
      strSQL := strSQL + 'SET      ';
      strSQL := strSQL +    strColuna + ' = :VALCOL ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL +    strNomFil + ' = :VALFIL ';
    End
    Else
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ';
      strSQL := strSQL + '  SEQGAR(   ';
      strSQL := strSQL +           strColuna;
      strSQL := strSQL + '        )   ';
      strSQL := strSQL + 'VALUES  (   ';
      strSQL := strSQL + '         :VALCOL ';
      strSQL := strSQL + '        )   ';
    End;

    With qrySeq Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('VALCOL').AsString := strValCol;

      If (blnExiste) Then
        ParamByName('VALFIL').AsString := strValFil;

      ExecSQL;

      Result := True;
    End;

  Except
    On E:Exception Do
      pMensagensErro(E.Message, '[TMovGad.fAtualizaSeqGarantia]');
  End;

  FreeAndNil(qrySeq);

end;

function TMovGad.fAtualizaTabelaAux(strCodIte,strSeqDet:String): Boolean;
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'UPDATE                       ';
  strSQL := strSQL + '  MOVGAU                     ';
  strSQL := strSQL + 'SET                          ';
  strSQL := strSQL + '  GAU_SEQDET = :SEQDET       ';
  strSQL := strSQL + 'WHERE                        ';
  strSQL := strSQL + '  GAU_CODITE = :CODITE AND   ';
  strSQL := strSQL + '  IFNULL(GAU_SEQDET,"") = "" ';

  With qryTmp Do
  Begin

    Try

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQDET').AsString := strSeqDet;
      ParamByName('CODITE').AsString := strCodIte;
      ExecSQL;

      Result := True;
    Except

      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TMovGad.fAtualizaTabelaAux');
        //Raise Exception.Create('Erro ao atualizar tabela auxiliar! ' + E.Message + ' - [fAtualizaTabelaAux]');
      End

    End;

  End;

  FreeAndNil(qryTmp);
end;

{****************************************}
{* CARREGA OS PRODUTOS COM PROBLEMA QUE *}
{* RETORNARAM DO FORNECEDOR             *}
{*************************************RL*}
procedure TMovGad.pCarregaProdutosRetornados(strCodFor: String; dtaDtaIni,
  dtaDtaFin: TDatetime; blnCpoSel: Boolean = False;  AAutIncGerele: String = '');
  Var
    strSQL: String;
begin
  Try
    strSQL := fSqlProdutosRetornadosFornecedor(blnCpoSel, [TFiltroSqlProdutoRetornado.fprPeriodoDatas], AAutIncGerele);

    With qryFornec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODFOR').AsString   := strCodFor;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      If AAutIncGerele = '' Then
      Begin
        ParamByName('DTAINI').AsDateTime := dtaDtaIni;
        ParamByName('DTAFIN').AsDateTime := dtaDtaFin;
      End;

      Open;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + ' - [pCarregaProdutosRetornados]');
  End;

end;

procedure TMovGad.pCarregaProdutosRetornadosConserto(strCodFor: String; dtaDtaIni, dtaDtaFin: TDatetime);
  Var
    strSQL: String;
    blnFilEmp : Boolean;
begin
  Try

    If (fCfgSis('GARMAT', varBoolean)) then
      blnFilEmp := (VS_strCodEmp <> fCfgSis('EMPGAR', varString))
    Else
      blnFilEmp := True;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  D.AUTOINCREM        AS "AUTINC", ';
    strSQL := strSQL + '  D.GAD_CODITE        AS "CODITE", ';
    strSQL := strSQL + '  D.GAD_NUMLOT        AS "LOTSAI", ';
    strSQL := strSQL + '  D.GAD_DTARET        AS "DTARET", ';
    strSQL := strSQL + '  D.GAD_CODFOR        AS "CODFOR", ';
    strSQL := strSQL + '  D.GAD_MOTBAI        AS "MOTBAI", ';

    strSQL := strSQL + '  E.GAE_DTAENV        AS "DTAENV", ';
    strSQL := strSQL + '  E.GAE_NUMENV        AS "NUMENV", ';
    strSQL := strSQL + '  E.GAE_ESPENV        AS "ESPENV", ';
    strSQL := strSQL + '  E.GAE_EMPENV        AS "EMPENV", ';
    strSQL := strSQL + '  E.AUTOINCREM        AS "INCGAE", ';
    strSQL := strSQL + '  E.GAE_QTDENV        AS "QTDREQ", ';
    strSQL := strSQL + '  (E.GAE_QTDRET + IFNULL(E.GAE_RETCON,0)) AS "QTDRET", ';
    strSQL := strSQL + '  (E.GAE_QTDREF + IFNULL(E.GAE_REFCON,0)) AS "QTDREF", ';

    strSQL := strSQL + '  G.GAG_NUMENT        AS "NUMENT", ';
    strSQL := strSQL + '  G.GAG_CODVEN        AS "CODVEN", ';
    strSQL := strSQL + '  G.GAG_CODCLI        AS "CODCLI", ';

    strSQL := strSQL + '  I.ITE_DESITE        AS "DESITE", ';
    strSQL := strSQL + '  I.ITE_REFERE        AS "REFERE", ';

    strSQL := strSQL + '  U.UNI_DESUNI        AS "UNIDAD", ';
    strSQL := strSQL + '  U.UNI_ITEFRA        AS "ITEFRA", ';

    strSQL := strSQL + '  M.DET_QTDITE        AS "QTDBAI", ';
    strSQL := strSQL + '  M.DET_UNITAR        AS "UNITAR", ';
    strSQL := strSQL + '  M.DET_CLAFIS        AS "CLAFIS", ';
    strSQL := strSQL + '  M.DET_TABPRE        AS "TABPRE", ';
    strSQL := strSQL + '  S.SEQ_FDOREF        AS "FDOREF", ';
    strSQL := strSQL + '  (M.DET_TOTCUS/M.DET_QTDITE) AS "PRECUS", ';
    strSQL := strSQL + '  (D.GAD_VALITE / D.GAD_QTDREQ) AS "VALITE", ';
    strSQL := strSQL + '  (M.DET_VLRCON/M.DET_QTDITE) AS VALUNT, ';
    strSQL := strSQL + '  G.AUTOINCREM        AS "INCGAG" ';

    If (fCfgSis('GARMAT', varBoolean)) Then
    Begin
      strSQL := strSQL + ' , ';
      strSQL := strSQL + ' (SELECT ';
      strSQL := strSQL + '    CONCAT(PCG_NUMPED,"-",PCG_ESPDOC) AS NUMPED ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '    PCMGER ';
      strSQL := strSQL + '  WHERE ';
      If fCfgSis('CPDORI', varBoolean) Then
      Begin
        strSQL := strSQL + '    PCG_ORIGND = GAE_NUMENV AND ';
        strSQL := strSQL + '    PCG_ORIGES = GAE_ESPENV AND ';
        strSQL := strSQL + '    PCG_ORIGEP = :CODEMP   AND  ';
        strSQL := strSQL + '    PCG_DTAPED = GAE_DTAENV AND ';
        strSQL := strSQL + '    PCG_CODFOR = D.GAD_CODFOR   ';
        strSQL := strSQL + '    ) AS "NUMPED" ';
      end
      Else
      begin
        strSQL := strSQL + '    SUBSTRING(PCG_DOCORI,1,' + IntToStr(fTamDocCadRec) + ') = GAE_NUMENV AND ';
        strSQL := strSQL + '    SUBSTRING(PCG_DOCORI,' + IntToStr(IfThen(fTamDocCadRec = 6, 7, 13)) + ',2) = GAE_ESPENV AND ';
        strSQL := strSQL + '    PCG_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '    PCG_DTAPED = GAE_DTAENV AND ';
        strSQL := strSQL + '    PCG_CODFOR = D.GAD_CODFOR ';
        strSQL := strSQL + '    ) AS "NUMPED" ';
      end;
    End;

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGAG G INNER JOIN MOVGAD  D  ON D.GAD_SEQGAG  = G.AUTOINCREM   ';
    strSQL := strSQL + '           INNER JOIN CADITE  I  ON D.GAD_CODITE  = I.ITE_CODITE   ';
    strSQL := strSQL + '           INNER JOIN CADUNI  U  ON I.ITE_CODUNI  = U.UNI_CODUNI   ';
    strSQL := strSQL + '           INNER JOIN MOVGAE  E  ON E.GAE_SEQGAD  = D.AUTOINCREM   ';
    strSQL := strSQL + '           INNER JOIN MOVDET  M  ON E.GAE_NUMENV  = M.DET_NUMDOC   ';
    strSQL := strSQL + '                                AND E.GAE_ESPENV  = M.DET_ESPDOC   ';
    strSQL := strSQL + '                                AND E.GAE_EMPENV  = M.DET_CODEMP   ';
    strSQL := strSQL + '                                AND E.GAE_SERENV  = M.DET_SERIE_   ';
    strSQL := strSQL + '                                AND IF(IFNULL(E.GAE_INCENV, "") <> "", E.GAE_INCENV = M.AUTOINCREM,  TRUE) ';
    strSQL := strSQL + '                                AND D.GAD_CODITE  = M.DET_CODITE   ';
    strSQL := strSQL + '           LEFT  JOIN SEQGAR  S  ON  S.SEQ_MOVGAD  = D.AUTOINCREM ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  D.GAD_CODFOR = :CODFOR AND ';
    If blnFilEmp Then
      strSQL := strSQL + '  G.GAG_CODEMP = :CODEMP AND '
    Else
    Begin
      strSQL := strSQL + ' LOCATE(G.GAG_CODEMP, (                                               ';
      strSQL := strSQL + '                        SELECT GROUP_CONCAT(SIS_CODEMP SEPARATOR "_") ';
      strSQL := strSQL + '                        FROM CFGSIS                                   ';
      strSQL := strSQL + '                        WHERE SIS_CODCFG = "CFG_EMPGAR"               ';
      strSQL := strSQL + '                          AND SIS_VALCFG = :CODEMP)) > 0 AND          ';

    End;

    strSQL := strSQL + '  GAE_DTAENV BETWEEN :DTAINI AND :DTAFIN AND ';

    strSQL := strSQL + '  ABS(GAE_QTDRET + GAE_QTDREF) < GAE_QTDENV';

    If fUsaRotinaGarantiaItensPesados Then
      strSQL := strSQL + '  AND D.GAD_GARFIL = "S" '
    Else
      strSQL := strSQL + '  AND (IF(IFNULL(D.GAD_GARFIL,"") = "","N",D.GAD_GARFIL)) = "N" ';

    strSQL := strSQL + '  ORDER BY NUMENV, CODITE, QTDREQ DESC ';

    With qryFornec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODFOR').AsString   := strCodFor;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('DTAINI').AsDateTime := dtaDtaIni;
      ParamByName('DTAFIN').AsDateTime := dtaDtaFin;

      Open;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + ' - [pCarregaProdutosRetornadosConserto]');
  End;
end;

procedure TMovGad.pAtualizaProdutoRetornados(cdsProdutos           : TUniClientDataSet;
                                            strNumero             : String;
                                            blnBaixar             : Boolean = False;
                                            blnSoQtdeTemporaria   : Boolean = False);

  Var
    strSQL : String;
    qryMovGae : TUniQuery;
    blnTransacaoExterna : boolean;
    blnTemCpoSelecionado: boolean;
    objFieldcdsProdutosSelecionado: TField;
    blnRetornoOuRefugo,
    blnRefent: boolean;
    lstrIncGau,
    lstrSeqDet,
    lstrIncRFG: String;
    lQtdRetGau: Double;
    lTipoRetorno: TTipoRetorno;
    lSetTipoRetorno: TSetTipoRetorno;
begin
  objFieldcdsProdutosSelecionado := cdsProdutos.FindField('SELECIONADO');
  blnTemCpoSelecionado := Assigned(objFieldcdsProdutosSelecionado);

  lstrIncRFG := EmptyStr;
  blnRefent := fCfgSis('REFENT', varBoolean);
  Try
    If blnSoQtdeTemporaria Then
      stlIncGau.Clear;

    blnTransacaoExterna := frmModulo.Database.InTransaction;

    if not blnTransacaoExterna then
      fStartTransaction;

    strSQL := '';

    If  (blnSoQtdeTemporaria) Then
    begin
      strSQL := fSQLInsereTabelaAux;
    end
    else
    Begin
      qryMovGae := fCriaQuery;
      With qryMovGae, SQL Do
      Begin
        Close;
        Clear;
        Add(' UPDATE MOVGAE SET GAE_QTDRET = IFNULL(GAE_QTDRET,0) + :QTDRET, ');
        Add('                   GAE_QTDREF = IFNULL(GAE_QTDREF,0) + :QTDREF  ');
        Add(' WHERE AUTOINCREM = :AUTINC                                     ');
      End;

      strSQL := strSQL + 'UPDATE MOVGAD ';

      strSQL := strSQL + '  SET GAD_QTDRET = IFNULL(GAD_QTDRET,0) + :QTDRET, ';
      strSQL := strSQL + '      GAD_DTARET = ' + fCurrentDate + ', ';

      If Not fEmptyStr(strNumero) Then
        strSQL := strSQL + '    GAD_NUMRET = :NUMRET, ';

      If (blnBaixar) Then
      Begin
        strSQL := strSQL + '  GAD_MOTBAI = :MOTBAI   ';
      End
      Else
      Begin
        strSQL := strSQL + '  GAD_QTDREF = IFNULL(GAD_QTDREF,0) + :QTDREF, ';
        If not blnRefent Then
          strSQL := strSQL + '  GAD_REFBAI = :REFBAI, ';
        strSQL := strSQL + '  GAD_OBSF_1 = :OBSF_1, ';
        strSQL := strSQL + '  GAD_OBSF_2 = :OBSF_2, ';
        strSQL := strSQL + '  GAD_OBSF_3 = :OBSF_3, ';
        strSQL := strSQL + '  GAD_OBSF_4 = :OBSF_4, ';
        strSQL := strSQL + '  GAD_OBSF_5 = :OBSF_5  ';
      End;

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  AUTOINCREM = :AUTINC';
    End;

    With cdsProdutos Do
    Begin

      First;

      qryFornec.Close;
      qryFornec.SQL.Clear;
      qryFornec.SQL.Add(strSQL);

      While Not Eof Do
      Begin
        blnRetornoOuRefugo := (FieldByName('QTDRET_1').AsFloat > 0) Or (FieldByName('QTDREF_1').AsFloat > 0);

        if blnRetornoOuRefugo and blnTemCpoSelecionado then
          blnRetornoOuRefugo := objFieldcdsProdutosSelecionado.AsString = '1';

        if Not blnRetornoOuRefugo then
        begin
          Next;
          continue;
        end;

        {$Region 'se  blnSoQtdTemporaria'}
        If (blnSoQtdeTemporaria) Then
        begin
          {******************************************}
          {* INSERE DADOS NA TABELA AUXILIAR MOVGAU *}
          {******************************************}

          {$Region 'Definindo o tipo de retorno que deve ser processado'}
          if blnRefent then
            lSetTipoRetorno := [trRefent]
          else
            lSetTipoRetorno := [trRetorno, trRefugo];
          {$EndRegion 'Definindo o tipo de retorno que deve ser processado'}

          for lTipoRetorno :=  trRetorno to trRefent do
          begin
            //Para cada tipo de retorno, verificar se ele deve ser processado,
            //se nao estiver contino  no conjunto, ir para próximo.
            if Not (lTipoRetorno in  lSetTipoRetorno) then
              continue;
            {$Region 'Iniciando variáveis para cada tipo de retorno processado'}
            lstrIncGau := EmptyStr;
            lstrSeqDet := EmptyStr;
            lQtdRetGau := 0;
            {$EndRegion 'Iniciando variáveis para cada tipo de retorno processado'}

            Case lTipoRetorno of
              trRetorno: begin
                           lQtdRetGau := FieldByName('QTDRET_1').AsFloat;

                           if blnBaixar then
                             lstrSeqDet := 'BAIXA_N';
                         end;

              trRefugo: begin
                          lstrSeqDet := 'REFUGO_N';
                          lQtdRetGau := FieldByName('QTDREF_1').AsFloat;
                        end;

              trRefent: lQtdRetGau :=  (FieldByName('QTDRET_1').AsFloat + FieldByName('QTDREF_1').AsFloat);

            end;

            if lQtdRetGau <= 0 then
              Continue;

            {$Region 'Gravando MovGau'}
            lstrIncGau := fRetAutoIncrem('MOVGAU', VS_strCodEmp);
            qryFornec.ParamByName('AUTINC').AsString := lstrIncGau;
            qryFornec.ParamByName('SEQGAD').Value    := FieldByName('AUTINC').Value;
            qryFornec.ParamByName('SEQGAE').AsString := FieldByName('INCGAE').AsString;
            qryFornec.ParamByName('CODITE').AsString := FieldByName('CODITE').AsString;
            qryFornec.ParamByName('ESPDOC').AsString := 'NF';
            qryFornec.ParamByName('QTDRET').AsFloat  := lQtdRetGau;
            qryFornec.ParamByName('SEQDET').AsString := lstrSeqDet;
            qryFornec.ExecSQL;

            stlIncGau.Add(lstrIncGau);
            {$EndRegion 'Gravando MovGau'}
            {$Region 'Gravando Documento de Retorno do Fornecedor'}
            if Not fGravarDocRFG(lstrIncRFG,                             //var pstrIncRFG: String;
                                 FieldByName('CODFOR').AsString,         //pstrCodFor: String;
                                 lTipoRetorno,                           //pTipoRetorno: TTipoRetorno;
                                 blnBaixar,                              //pblnBaixa: Boolean;
                                 lstrIncGau,                             //pstrIncGau,
                                 FieldByName('INCGAE').AsString,         //pstrIncGae: String;
                                 FieldByName('QTDRET_1').AsFloat,        //const pfltQtdRet,
                                 FieldByName('QTDREF_1').AsFloat) then   //pfltQtdRef: Double)
            begin
              raise Exception.Create('Ocorreu uma falha ao tentar gravar tabela GAGRFD.');
              Exit;
            end;
            {$EndRegion 'Gravando Documento de Retorno do Fornecedor'}
          end;
        end
        {$EndRegion 'se  blnSoQtdTemporaria'}
        {$Region 'Else'}
        else Begin
          qryFornec.ParamByName('QTDRET').AsFloat := FieldByName('QTDRET').AsFloat + FieldByName('QTDRET_1').AsFloat;
          {$Region 'se blnBaixar'}
          If (blnBaixar) Then
          Begin
            qryFornec.ParamByName('MOTBAI').AsString := FieldByName('MOTIVO').AsString;
          End
          {$EndRegion 'se blnBaixar'}
          Else
          {$Region 'senão blnBaixar'}
          Begin
            qryFornec.ParamByName('QTDREF').AsFloat  := FieldByName('QTDREF').AsFloat + FieldByName('QTDREF_1').AsFloat;

            If not blnRefent Then
              qryFornec.ParamByName('REFBAI').AsFloat  := FieldByName('QTDREF').AsFloat + FieldByName('QTDREF_1').AsFloat;

            qryFornec.ParamByName('OBSF_1').AsString := FieldByName('OBSF_1').AsString;
            qryFornec.ParamByName('OBSF_2').AsString := FieldByName('OBSF_2').AsString;
            qryFornec.ParamByName('OBSF_3').AsString := FieldByName('OBSF_3').AsString;
            qryFornec.ParamByName('OBSF_4').AsString := FieldByName('OBSF_4').AsString;
            qryFornec.ParamByName('OBSF_5').AsString := FieldByName('OBSF_5').AsString;

            If fEmptyStr(qryFornec.ParamByName('OBSF_1').AsString) Then
              qryFornec.ParamByName('OBSF_1').Clear;
            If fEmptyStr(qryFornec.ParamByName('OBSF_2').AsString) Then
              qryFornec.ParamByName('OBSF_2').Clear;
            If fEmptyStr(qryFornec.ParamByName('OBSF_3').AsString) Then
              qryFornec.ParamByName('OBSF_3').Clear;
            If fEmptyStr(qryFornec.ParamByName('OBSF_4').AsString) Then
              qryFornec.ParamByName('OBSF_4').Clear;
            If fEmptyStr(qryFornec.ParamByName('OBSF_5').AsString) Then
              qryFornec.ParamByName('OBSF_5').Clear;
          End;
          {$EndRegion 'senão blnBaixar'}
          If Not fEmptyStr(strNumero) Then
            qryFornec.ParamByName('NUMRET').AsString := strNumero;

          qryFornec.ParamByName('AUTINC').Value   := FieldByName('AUTINC').AsString;
          qryFornec.ExecSQL;

          //Marca a qtde retornada do Envio.
          qryMovGae.ParamByName('QTDRET').AsFloat  := FieldByName('QTDRET_1').AsFloat;
          qryMovGae.ParamByName('QTDREF').AsFloat  := FieldByName('QTDREF_1').AsFloat;
          qryMovGae.ParamByName('AUTINC').AsString := FieldByName('INCGAE').AsString;
          qryMovGae.ExecSQL;
        End;
        {$EndRegion 'Else'}
        Next;

      End;
    End;

    If Not (blnSoQtdeTemporaria) Then
      FreeAndNil(qryMovGae);

    if not blnTransacaoExterna then
      fCommit;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create('Erro ao confirmar retorno do produto do fornecedor! ' +
        E.Message +  ' - [fAtualizaProdutosRetornados]');
    End;
  End;

end;

{***************************************************}
{* CARREGA PRODUTOS QUE AINDA NÃO FORAM DEVOLVIDOS *}
{* PARA O CLIENTE, OU QUE ENTRARAM COMO REFUGO     *}
{************************************************RL*}
procedure TMovGad.pCarregaProdutosDevolucao(strCodCli: String; blnFavorecido: Boolean = False);
  CONST
    NORMAL = 0;
    SEM_REPOSICAO_E_RETORNO = 1;
  Var
    strSQLBase: String;
    strSQL: String;
    blnPermitirLiberarSemNotaVenda: Boolean;
    i: Integer;
begin

  blnPermitirLiberarSemNotaVenda := fCfgSis('LRGCSA', varString) = 'S';

  Try
    strSQLBase :=              'SELECT ';
    strSQLBase := strSQLBase + '  "%s" AS ORIGEM, ';
    strSQLBase := strSQLBase + '  D.AUTOINCREM      AS "AUTINC", ';
    strSQLBase := strSQLBase + '  G.GAG_NUMENT        AS "NUMENT", ';
    strSQLBase := strSQLBase + '  D.GAD_CODITE        AS "CODITE", ';
    strSQLBase := strSQLBase + '  I.ITE_DESITE        AS "DESITE", ';
    strSQLBase := strSQLBase + '  I.ITE_REFERE        AS "REFERE", ';
    strSQLBase := strSQLBase + '  I.ITE_CODFAB        AS "CODFAB", ';
    strSQLBase := strSQLBase + '  U.UNI_DESUNI        AS "UNIDAD", ';
    strSQLBase := strSQLBase + '  D.GAD_DTADEV        AS "DTADEV", ';
    strSQLBase := strSQLBase + '  D.GAD_QTDREQ        AS "QTDREQ", ';
    strSQLBase := strSQLBase + '  D.GAD_QTDRET        AS "QTDRET", ';
    strSQLBase := strSQLBase + '  D.GAD_QTDDEV        AS "QTDDEV", ';
    strSQLBase := strSQLBase + '  D.GAD_QTDPRE        AS "QTDPRE", ';
    strSQLBase := strSQLBase + '  D.GAD_QTDREF        AS "QTDREF", ';
    strSQLBase := strSQLBase + '  G.GAG_CODVEN        AS "CODVEN", ';
    strSQLBase := strSQLBase + '  G.GAG_CODCLI        AS "CODCLI", ';
    strSQLBase := strSQLBase + '  D.GAD_CODFOR        AS "CODFOR", ';
    strSQLBase := strSQLBase + '  D.GAD_OBSF_1        AS "OBSF_1", ';
    strSQLBase := strSQLBase + '  D.GAD_OBSF_2        AS "OBSF_2", ';
    strSQLBase := strSQLBase + '  D.GAD_OBSF_3        AS "OBSF_3", ';
    strSQLBase := strSQLBase + '  D.GAD_OBSF_4        AS "OBSF_4", ';
    strSQLBase := strSQLBase + '  D.GAD_OBSF_5        AS "OBSF_5", ';
    strSQLBase := strSQLBase + '  D.GAD_VALITE / GAD_QTDREQ AS "UNITAR", ';
    strSQLBase := strSQLBase + '  F.ITE_PRECUS        AS "PRECUS", ';
    strSQLBase := strSQLBase + '  CAST(IF((SELECT COUNT(1) FROM CADLOT L WHERE L.LOT_CODITE = D.GAD_CODITE AND L.LOT_CODEMP = G.GAG_CODEMP) > 0, "S", "N") AS CHAR(1)) AS TEMLOTE, ';
    strSQLBase := strSQLBase + '  CAST((SELECT L.LOT_NUMLOT FROM CADLOT L WHERE L.LOT_CODITE = D.GAD_CODITE AND L.LOT_CODEMP = G.GAG_CODEMP AND LOT_ARMOPV = "S" LIMIT 1) AS CHAR(100)) AS LOTEPRINCIPALVENDA, ';
    strSQLBase := strSQLBase + '  IFNULL(D2.AUTOINCREM, D4.AUTOINCREM) AS "INCORI",  ';
    strSQLBase := strSQLBase + '  D.GAD_UNICRD      AS "UNICRD",  ';
    strSQLBase := strSQLBase + '  IFNULL(D.GAD_REPOST,"N") AS "REPOST",  ';
    strSQLBase := strSQLBase + '  IFNULL(G.GAG_CODFAV, G.GAG_CODCLI) AS "CODFAV",  ';
    strSQLBase := strSQLBase + '  D3.DET_SEQGER AS "INCGER",  ';
    strSQLBase := strSQLBase + '  D3.DET_NUMDOC AS "NUMDOC",  ';
    strSQLBase := strSQLBase + '  D3.DET_ESPDOC AS "ESPDOC",  ';
    strSQLBase := strSQLBase + '  CONCAT(D3.DET_NUMDOC,"-",D3.DET_ESPDOC,"-",D3.DET_CODEMP) AS "DOCUMENTO", ';
    strSQLBase := strSQLBase + '  G.AUTOINCREM AS "INCGAG", ';
    strSQLBase := strSQLBase + '  F.ITE_LOCFIS AS LOCFIS ';
    strSQLBase := strSQLBase + 'FROM MOVGAG G ';
    strSQLBase := strSQLBase + ' INNER JOIN MOVGAD D ON D.GAD_SEQGAG  = G.AUTOINCREM ';
    strSQLBase := strSQLBase + ' INNER JOIN CADITE I ON D.GAD_CODITE  = I.ITE_CODITE ';
    strSQLBase := strSQLBase + ' INNER JOIN CADUNI U ON I.ITE_CODUNI  = U.UNI_CODUNI ';
    strSQLBase := strSQLBase + ' INNER JOIN ITEGER F ON F.ITE_CODITE  = D.GAD_CODITE AND F.ITE_CODEMP  = D.GAD_CODEMP ';
    strSQLBase := strSQLBase + ' INNER JOIN MOVGRC C ON C.GRC_SEQGAD = D.AUTOINCREM AND (C.GRC_OPCDOC IN ("DV","GA","OE","NE"))  ';
    strSQLBase := strSQLBase + ' INNER JOIN MOVDET D3 ON D3.AUTOINCREM = C.GRC_SEQDET '; //MOVDET DO RECEBIMENTO DO CLIENTE
    {strSQLBase := strSQLBase + ' ' + IIF(blnPermitirLiberarSemNotaVenda, 'LEFT', 'INNER') + ' JOIN MOVDET D2 ON D2.AUTOINCREM = C.GRC_INCORI ';}
    strSQLBase := strSQLBase + ' LEFT JOIN MOVDET D2 ON D2.AUTOINCREM = C.GRC_INCORI ';
    strSQLBase := strSQLBase + ' LEFT JOIN MOVDET D4 ON D4.AUTOINCREM = C.GRC_INCORI ';

    strSQL := EmptyStr;
    For i := 0 to 1 do
    begin
      if i = 1 then
        strSQL := strSQL + ' UNION ';
      strSQL := strSQL + strSQLBase;

      strSQL := strSQL + 'WHERE TRUE ';

      if blnFavorecido Then
        strSQL := strSQL + '  AND G.GAG_CODFAV = :CODCLI  '
      else
        strSQL := strSQL + '  AND G.GAG_CODCLI = :CODCLI  ';

      strSQL := strSQL + '  AND G.GAG_CODEMP = :CODEMP    ';
      strSQL := strSQL + '  AND G.GAG_GARIND <> "S"       ';
      strSQL := strSQL + '  AND D.GAD_SCREDI = 1          ';
      strSQL := strSQL + '  AND D.GAD_COLETA <> "S"       ';


      Case Ord(i) of
        NORMAL:
        begin
          strSQL := Format(strSQL,[intToStr(NORMAL)]);
          strSQL := strSQL + '  AND ((D.GAD_DTARET IS NOT NULL) OR (D.GAD_REPOST = "S")) ';
          strSQL := strSQL + '  AND ((D.GAD_QTDDEV < D.GAD_QTDRET) OR (D.GAD_QTDPRE < D.GAD_QTDREF)) ';

          If blnPermitirLiberarSemNotaVenda Then
            strSQL := strSQL + ' AND G.GAG_CODCLI NOT IN ( ' + fRetClientesFilial + ') ';
        end;

        SEM_REPOSICAO_E_RETORNO:
        begin
          strSQL := Format(strSQL,[intToStr(SEM_REPOSICAO_E_RETORNO)]);
          strSQL := strSQL + '  AND (D.GAD_DTARET IS NULL)  ';
          strSQL := strSQL + '  AND (D.GAD_REPOST = "N") ';
          strSQL := strSQL + '  AND (IFNULL(D.GAD_QTDDEV,0) = 0) ';
          strSQL := strSQL + '  AND (IFNULL(D.GAD_QTDRET,0) = 0) ';
          strSQL := strSQL + '  AND (IFNULL(D.GAD_QTDPRE,0) = 0) ';
          strSQL := strSQL + '  AND (IFNULL(D.GAD_QTDREF,0) = 0) ';
        end;
      end;
    end;

    With qryCliente Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODCLI').AsString   := strCodCli;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;

      Open;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + ' - [pCarregaProdutosDevolucao]');
  End;

End;

class function TMovGad.fAtualizaAutIncEnvioGaeTemporaria(const pstrAutInc,
                                                               pstrIncEnv: String): Boolean;
Var
  lQry: TUniQuery;
begin
  lQry := fCriaQuery;
  Try
    lQry.Close;
    lQry.Sql.Clear;
    lQry.Sql.Add('UPDATE TMP_MOVGAE SET GAE_INCENV = :INCENV WHERE AUTOINCREM = :AUTINC');
    lQry.ParamByName('AUTINC').AsString := pstrAutInc;
    lQry.ParamByName('INCENV').AsString := pstrIncEnv;
    lQry.ExecSQL;
    Result := lQry.RowsAffected  > 0;
  Finally
    lQry.Free;
  End;
end;

{**********************************************}
{* ATUALIZA DEVOLUÇÃO / PREJUÍZO DOS PRODUTOS *}
{*******************************************RL*}
class function TMovGad.fAtualizaProdutosDevolucao(const strIncGad, strNumero: String; const fltQtdDev, fltQtdPre: Double; blnCancelar: boolean = false): Boolean;
  Var
    strSQL: String;
    Qry: TUniquery;
    blnTemNumero: Boolean;
begin
   blnTemNumero := Not fEmptyStr(strNumero);
  {$Region 'Montando SQL'}
  strSql := EmptyStr;
  strSql := strSql + 'UPDATE MOVGAD SET  GAD_QTDDEV = :QTDDEV, GAD_QTDPRE = :QTDPRE ';

  if blnCancelar then
  begin
    strSql := strSql + ', GAD_DTADEV = NULL ';
    strSQL := strSQL + ', GAD_NUMDEV = NULL  ';
  end
  else begin
    strSql := strSql + ', GAD_DTADEV = %s ';
    strSql := Format(strSql,[fCurrentDate]);

    If blnTemNumero Then
      strSQL := strSQL + ', GAD_NUMDEV = :NUMDEV ';
  end;

  strSql := strSql + ' WHERE AUTOINCREM = :AUTINC ';
  {$Endregion}
  Result := True;
  Try
    Qry := fCriaQuery;
    Try
      Qry.Close;
      Qry.Sql.Clear;
      Qry.Sql.Add(strSQL);
      Qry.ParamByName('AUTINC').AsString := strIncGad;
      Qry.ParamByName('QTDDEV').AsFloat := fltQtdDev;
      Qry.ParamByName('QTDPRE').AsFloat := fltQtdPre;
      if blnTemNumero then
        Qry.ParamByName('NUMDEV').AsString := strNumero;
      Qry.ExecSql;
    Finally
      FreeAndNil(Qry);
    End;
  Except
    On E: Exception do
    begin
      Result := False;
    end;
  End;
end;

function TMovGad.fAtualizaProdutosDevolucao(cdsProdutos: TUniClientDataSet;
  strNumero: String; strEspDoc : String): Boolean;
  Var
    strSQL      : String;
    strAutInc   : String;
    strAutIncDet: String;
    strNumLotEvCli : String;
    recServicos : TDadosServicos;
    blnMovGer   : Boolean;
    blnTemLot   : Boolean;
    objCadlot   : TCadLot;
    arrDuplic   : TarrDuplicata;
    strCodErrosAuditoria: String;
begin
  Try
    if ( objCadlot <> nil ) then
      FreeAndNil(objCadlot);

    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

    objAuditoriaSaldo.Limpar;

    blnMovGer := False;
    fStartTransaction;

    With cdsProdutos Do
    Begin

      First;

      qryCliente.Close;
      qryCliente.SQL.Clear;
      qryCliente.SQL.Add(strSQL);

      While Not Eof Do
      Begin

        If (FieldByName('QTDDEV_1').AsFloat > 0) Or  (FieldByName('QTDPRE_1').AsFloat > 0) Then
        Begin
           fAtualizaProdutosDevolucao(cdsProdutos.FieldByName('AUTINC').AsString,                                                      //strIncGad,
                                      strNumero,                                                                                       //strNumero: String;
                                      (cdsProdutos.FieldByName('QTDDEV').AsFloat + cdsProdutos.FieldByName('QTDDEV_1').AsFloat),       //fltQtdDev,
                                      (cdsProdutos.FieldByName('QTDPRE').AsFloat + cdsProdutos.FieldByName('QTDPRE_1').AsFloat));      //fltQtdPre: Double;
                                                                                                                                       //blnCancelar: boolean = false

        End;

        If POS(strEspDoc, '_NF_PD_') = 0 Then
        Begin
          If (FieldByName('QTDDEV_1').AsFloat > 0) Then
          Begin

            {*****************************************}
            {* GRAVA MOVGER E MOVDET                 *}
            {**************************************RL*}
            If not blnMovGer Then
             If fGravaMovGer(strAutInc,
                             strNumero,
                             'GC',
                             VS_strCodEmp,
                             '',
                             FieldByName('CODVEN').AsString,
                             FieldByName('CODFOR').AsString,
                             FieldByName('CODCLI').AsString,
                             'C',
                             VS_Date,
                             fTime(),
                             VS_Date,
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0,
                             '',
                             '',
                             '',
                             '',
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0.0,
                             0,
                             '',
                             '',
                             'GARANTIA',
                             '',
                             '',
                             '',
                             '',
                             False,
                             '',
                             '',
                             '', // Empresa do Faturamento
                             0,
                             '',
                             '',
                             False,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             arrDuplic,
                             '',
                             'N',
                             '5999',
                             '',
                             '',
                             '',
                             0.0,
                             '',
                             '',
                             '',
                             0.0,
                             recServicos,
                             0.0,
                             '',
                             '',
                             '',
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0,
                             '',
                             'N',
                             '',
                             '',      // Operador da Expedição
                             '',      // Separador da Expedição
                             '',
                             '',
                             'N',     // Entrega Futura
                             FALSE,  // Baixa de Entrega Futura
                             0,      // Margem de Lucro
                             0.0,    // Base do retido (caso tivesse) com ipi e frete de entrada
                             0.0,    // Valor do retido considerando a base acima.
                             'N',    // Gerar produção fora da loja
                             '',     // Numero do Registro - Correios ou Transportadora
                             VS_Date,// Data de Entrega no Romaneio
                             '',     // Classificação fiscal 4
                             'N',    // AUTO-SERVIÇO
                             '',     // Evento
                             '',     // AUTINC ENDEREÇO DE ENTREGA
                             '',     // Conteúdo do CNFNFE
                             '',     // Motivo da Devolução
                             '',
                             True) then  // Imprime Duplicatas na NF-e
            begin
              blnMovGer := true;
              objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');
            end;

            // objeto para verificacao e retorno do lote ** RF **
            objCadLot := TCadLot.Create(Self);

            // faz verificacao se usa lote, e se usar, busca o lote principal da venda
            blnTemLot := objCadlot.fExisteLote(FieldByName('CODITE').AsString, VS_strCodEmp, '', False, False);

            If blnTemLot then // havendo lote principal ele retorna o numero
              strNumLotEvCli := objCadlot.fRetArmazemPrincipalOrcamentoPedidoVenda(FieldByName('CODITE').AsString);

            If blnTemLot And fEmptyStr(strNumLotEvCli) Then
              strNumLotEvCli := 'A DEFINIR';

            strAutIncDet := '';

            fGravaMovDet(strAutIncDet,
                         strAutInc,
                         strNumero,
                         'GC',
                         VS_strCodEmp,
                         FieldByName('CODITE').AsString,
                         FieldByName('CODVEN').AsString,
                         '',
                         fRetMarcaItem(FieldByName('CODITE').AsString),
                         '',
                         FieldByName('CODCLI').AsString,
                         VS_Date,
                         fTime(),
                         VS_Date,
                         '',
                         'C',
                         '',
                         FieldByName('DESITE').AsString,
                         FieldByName('REFERE').AsString,
                         fRetUnidadeItem(FieldByName('CODITE').AsString),
                         FieldByName('CODFOR').AsString,
                         FieldByName('QTDDEV_1').AsFloat,
                         FieldByName('UNITAR').AsFloat,
                         FieldByName('UNITAR').AsFloat,
                         FieldByName('UNITAR').AsFloat,
                         FieldByName('UNITAR').AsFloat * FieldByName('QTDDEV_1').AsFloat,
                         FieldByName('UNITAR').AsFloat * FieldByName('QTDDEV_1').AsFloat,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         '',
                         '',
                         0.0,
                         0.0,
                         0.0,
                         '5999',
                         '',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         False,
                         '',
                         '',
                         '', // Empresa do Faturamento
                         0,
                         '',
                         '',
                         0.0,
                         'NOR',
                         '',
                         '',
                         0.0,
                         'N',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0,
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         0,
                         'N',
                         '',
                         0.0,
                         '',
                         '',
                         '',
                         '',
                         '',
                         0,
                         '',

                         '',

                         '',

                         0,

                         0,

                         0.0,
                         '',
                         '',
                         False,
                         False,
                         '',                                                             //  Especie da Entrega Fututa
                         '',                                                             //  Documento da Entrega Fututa
                         '',
                         '',                                                             //  Empresa da Entrega Fututa
                         '',
                         '',
                         '',
                         '',
                         0.0,
                         '',
                         0.0,
                         FieldByName('UNITAR').AsFloat,
                         0,
                         'N',
                         '',
                         0,
                         0,
                         0,
                         0,
                         '',
                         IIF(blnTemLot, strNumLotEvCli, ''),   // strNumLot // implementação do lote no retorno do cliente "ESPDOC=GC" ** RL**
                         'N',   // strPigBas
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         '',
                         0,
                         0,
                         0,
                         '',
                         '',
                         '',
                         0,
                         0,
                         0,
                         0,
                         0,
                         '',
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         'P',
                         0,
                         0,
                         0,
                         '',
                         '',
                         '',
                         FieldByName('AUTINC').AsString);


            fAtualizaEstoqueCadIte(FieldByName('CODITE').AsString,
                                   'S',
                                   FieldByName('QTDDEV_1').AsFloat,
                                   fRetPreCus(VS_strCodEmp, FieldByName('CODITE').AsString),
                                   IIF(blnTemLot, strNumLotEvCli, ''),
                                   False);

            TMovGag.fInsereMovGrc(FieldByName('AUTINC').AsString, strAutIncDet, strEspDoc, 'EC', FieldByName('INCORI').AsString); // EC - Envio ao Cliente.

          End;

        End;
        strNumLotEvCli := '';



        Next;

      End;

    End;

    // DESTROY OBJETO DO LOTE CASO FOI CRIADO
    if ( objCadlot <> nil ) then
      FreeAndNil(objCadlot);

    If (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
    Begin
      Result := False;
      fRollBack;
      pMostraErrosAuditoria(strCodErrosAuditoria);
      Exit;
    End;

    fCommit;
    Result := True;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create('Erro ao confirmar envio do produto ao cliente! ' +
        E.Message +  ' - [fAtualizaProdutosDevolucao]');
    End;
  End;

end;

{**************************************}
{* CANCELA GARANTIA                   *}
{***********************************AF*}
procedure TMovGag.pCancelaGarantia;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
begin

  qryTmp := fCriaQuery;

  Try
    fStartTransaction;

    {**************************************}
    {* DELETA MOVGER                      *}
    {***********************************AF*}
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM  ';
    strSQL := strSQL + '  MOVGER    ';
    strSQL := strSQL + 'WHERE        ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = "GA"    AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP     ';

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumEnt;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
    End;

    {*************************************}
    {* DELETA MOVDET                     *}
    {**********************************AF*}
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  MOVDET   ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  DET_ESPDOC = "GA"    AND ';
    strSQL := strSQL + '  DET_CODEMP = :CODEMP     ';

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumEnt;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
    End;

    With objMovGad.qryMovGad Do
    Begin
      First;

      While Not Eof Do
      Begin
        If FieldByName('GAD_REPOST').AsString = 'S' Then
          fAtualizaEstoqueCadIte(FieldByName('GAD_CODITE').AsString,
                                 'E',
                                 FieldByName('GAD_QTDREQ').AsFloat,
                                 fRetPreCus(VS_strCodEmp, FieldByName('GAD_CODITE').AsString));
        Next;
      End;

    End;

    pDeletaGarantia(strAutInc);

    fCommit;
    FreeAndNil(qryTmp);

    fMensagem('', 'Garantia cancelada com sucesso!', ['&Ok']);

  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TMovGag.pCancelaGarantia]');
     fRollBack;
     FreeAndNil(qryTmp);
    End;
  End;

end;

Function TMovGag.fRetornaSemelhante(strCodIte: String; Var strCodFab: String): Boolean;
  Var
    qryCadSem: TUniQuery;
    intIndice: Integer;
Begin
  Try
    qryCadSem := fCriaQuery(Self);

    With qryCadSem, SQL Do
    Begin
      Clear;
      Add(' SELECT SQL_NO_CACHE                          ');
      Add('   ITE_CODFAB,                                ');
      Add('   SEM_CODSEM                                 ');
      Add(' FROM                                         ');
      Add('   CADSEM                                     ');
      Add(' INNER JOIN CADITE ON ITE_CODITE = SEM_CODITE ');
      Add(' WHERE                                        ');
      Add('   SEM_CODITE = :CODITE AND                   ');
      Add('   IFNULL(SEM_CODSEM, "") <> ""               ');

      ParamByName('CODITE').AsString := strCodIte;

      Open;

      If IsEmpty Then
      Begin
        fMensagem('','Não há semelhantes cadastrados para esse item!', ['&Ok']);
        Result := False;
      End Else
      Begin

        pCriarFormularios(TfrmGarantSemelhante, frmGarantSemelhante);

        With frmGarantSemelhante, lsbCodFab, Items Do
        Begin
          Add(FieldByName('ITE_CODFAB').AsString);
          While Not qryCadSem.Eof Do
          Begin
            Add(FieldByName('SEM_CODSEM').AsString);
            qryCadSem.Next;
          End;

          For intIndice := 0 To Count - 1 Do
            If SameText(strCodFab, items[intIndice]) Then
            Begin
              ItemIndex := intIndice;
              Break;
            End;

          If ShowModal = mrOk Then
          Begin
            strCodFab := items[ItemIndex];
            Result := True;
          End Else
          Begin
            Result := False;
          End;
        
        End;

        FreeAndNil(frmGarantSemelhante);
      End;
    End;

    FreeAndNil(qryCadSem);
    
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TMovGag.fRetornaSemelhante]');
    End;
  End;
End;

function TMovGag.fVincularCredito(pstrIncGag, pstrIncCTR: String): Boolean;
begin
  If fVincularCreditoAGarantia(pstrIncGag, pstrIncCTR, True) then
  begin
    FstrIncCTR := pstrIncCTR;
    Result := True;
  end
  else
    Result := False;
end;

class function TMovGag.fVincularCreditoAGarantia(pstrAutInc,
  pstrIncCTR: String; pblnRecCliente: Boolean = False): Boolean;
Var
  lQry: TUniQuery;
begin
  Result := False;
  lQry := fCriaQuery;
  Try
    Try
      lQry.Close;
      lQry.SQL.Clear;

      if pblnRecCliente then
        lQry.SQL.Add(' UPDATE MOVGAD SET GAD_INCCTR = :INCCTR WHERE GAD_SEQGAG = :AUTINC ')
      else
        lQry.SQL.Add(' UPDATE MOVGAD SET GAD_INCCTR = :INCCTR WHERE AUTOINCREM = :AUTINC ');

      lQry.ParamByName('INCCTR').AsString := pstrIncCTR;
      lQry.ParamByName('AUTINC').AsString := pstrAutInc;
      lQry.ExecSQL;
      Result := lQry.RowsAffected > 0;
    Except
      On E: Exception do
      begin
        if Result then
          Result := False;
        pMensagensErro(E.Message, '[TMovGag.fVincularCredito]');
      end;
    End;
  Finally
    FreeAndNil(lQry);
  End;
end;

function TMovGag.fVincularGarantiaACADREC(pstrIncGER,
  pstrIncCTR: String): Boolean;
Var
  lQry: TUniQuery;
begin
  Result := False;
  lQry := fCriaQuery;
  Try
    Try
      lQry.Close;
      lQry.SQL.Clear;
      lQry.SQL.Add(' UPDATE CADREC SET CTR_INCDOC = :INCGER WHERE AUTOINCREM = :INCCTR ');
      lQry.ParamByName('INCCTR').AsString := pstrIncCTR;
      lQry.ParamByName('INCGER').AsString := pstrIncGER;
      lQry.ExecSQL;
      Result := lQry.RowsAffected > 0;
    Except
      On E: Exception do
      begin
        if Result then
          Result := False;
        pMensagensErro(E.Message, '[TMovGag.fVincularGarantiaACADREC]');
      end;
    End;
  Finally
    FreeAndNil(lQry);
  End;
end;

function TMovGag.fCreditoGerado: Boolean;
begin
  Result := Not fEmptyStr(FstrIncCTR);
end;

class function TMovGag.fVincularPedidoReposicao(const strIncGag, strIncGor: String): Boolean;
  const
    SQL: String = ' UPDATE MOVGAG SET GAG_SEQGOR = :INCGOR WHERE AUTOINCREM = :AUTINC ';
  Var
    qry: TUniQuery;
Begin
  Result := True;
  Try
    Try
      qry := fCriaQuery;
      Qry.Sql.Clear;
      Qry.Sql.Add(SQL);
      Qry.ParamByName('AUTINC').AsString := strIncGag;
      Qry.ParamByName('INCGOR').AsString := strIncGor;
      Qry.ExecSql;
    Finally
      FreeAndNil(qry);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TMovGag.fVincularPedidoReposicao]');
    End;
  End;

end;

function TMovGag.fLimpar: Boolean;
begin
  Result := False;
  qryMovGag.Close;
  objMovGad.qryMovGad.Close;
  pLimpaDadosGag;
end;

function TMovGag.getNomAti: String;
begin
  Result := fRetAtividade(FstrCodAti);
end;

{*******************************************}
{* RETORNA NOME DO CLIENTE                 *}
{****************************************RL*}
function TMovGag.getNomCid: String;
begin
  Result := fRetNomCidade(FstrCidCon);
end;

function TMovGag.getNomCli: String;
begin
  Result := fRetNomCliente(FCodCli);
end;

{*******************************************}
{* RETORNA NOME DO VENDEDOR                *}
{****************************************RL*}
function TMovGag.getNomVen: String;
begin
  Result := fRetNomeOperador(FCodVen);
end;

Function TMovGag.fAlteraSemelhante(strAutInc: String; strCodFab: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery(Self);

    With qryGen, SQL Do
    Begin
      Clear;
      Add(' UPDATE MOVGAD          ');
      Add(' SET                    ');
      Add('   GAD_CODFAB = :CODFAB ');
      Add(' WHERE                  ');
      Add('   AUTOINCREM = :AUTINC ');

      ParamByName('AUTINC').AsString := strAutInc;
      ParamByName('CODFAB').AsString := strCodFab;

      ExecSQL;

      Result := True;
      FreeAndNil(qryGen);
    End;
    
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TMovGag.fAlteraSemelhante]');
    End;
  End;

End;

procedure pCarregaDadosClienteGarantia(strCodCli: String; objFatVendas : TFatVenda);
  Var
    strSQL: String;
    qryDados: TUniQuery;
begin
  qryDados := fCriaQuery();

  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '  CLI_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  CLI_NOMCLI AS CLIORI, ';
    strSQL := strSQL + '  CLI_NOMCLI AS CLINOM, ';
    strSQL := strSQL + '  CLI_I_M_P_ AS I_M_P_, ';
    strSQL := strSQL + '  CLI_PRORUR AS PRORUR, ';
    strSQL := strSQL + '  CLI_MICEMP AS MICEMP, ';
    strSQL := strSQL + '  CLI_ORGPUB AS ORGPUB, ';
    strSQL := strSQL + '  CLI_DESPIS AS DESPIS, ';
    strSQL := strSQL + '  CLI_SUFRAM AS CODZFM, ';
    strSQL := strSQL + '  CLI_EXPIND AS EXPIND, ';
    strSQL := strSQL + '  CLI_CONSUM AS CONSUM, ';
    strSQL := strSQL + '  "C"        AS INDCOM, ';
    strSQL := strSQL + '  CLI_TABPRE AS TABPRE, ';
    strSQL := strSQL + '  CLI_ORPURD AS ORPURD, ';
    strSQL := strSQL + '  CLI_CALICM AS CALICM, ';
    strSQL := strSQL + '  CLI_ZONFRA AS ZONFRA, ';
    strSQL := strSQL + '  CLI_DESZON AS DESZON, ';
    strSQL := strSQL + '  CLI_CODREG AS CODREG, ';   // - Código da Região
    strSQL := strSQl + '  REG_DESREG AS DESREG, ';   // - Descrição da Região

    if (fCfgSis('SIMPAU', varBoolean) and fCfgSis('RETIMP', varBoolean)) then
    begin
      strSQL := strSQL + '  "N" AS RETPCO, ';          // - Retenção de Pis e Cofins
      strSQL := strSQL + '  "N" AS RETIRF, ';          // - Retenção de IRPF
      strSQL := strSQL + '  "N" AS CDESPI, ';          // - Calcula desconto de PIS/COFINS/IRPJ/CSLL
    end
    else
    begin
      strSQL := strSQL + '  CLI_RETPCO AS RETPCO, ';   // - Retenção de Pis e Cofins
      strSQL := strSQL + '  CLI_RETIRF AS RETIRF, ';   // - Retenção de IRPF
      strSQL := strSQL + '  CLI_CDESPI AS CDESPI, ';   // - Calcula desconto de PIS/COFINS/IRPJ/CSLL
    end;

    strSQL := strSQL + '  CLI_RETISS AS RETISS, ';   // - Retenção de ISS
    strSQL := strSQL + '  CLI_SITIPI AS SITIPI, ';   // - Situação do IPI
    strSQL := strSQL + '  CLI_ENQIPI AS ENQIPI, ';   // - Enquadramento do IPI
    strSQL := strSQL + '  CLI_MENIPI AS MENIPI, ';   // - Mensagem do IPI
    strSQL := strSQL + '  CLI_PERMFF AS PERMFF, ';
    strSQL := strSQL + '  CLI_PERMFV AS PERMFV, ';
    strSQL := strSQL + '  "01000"    AS CONPAG, ';
    strSQL := strSQL + '  CLI_CGCCPF AS CGCCPF, ';
    strSQL := strSQL + '  CLI_ENDERE AS ENDERE, ';
    strSQL := strSQL + '  CLI_ENDNUM AS ENDNUM, ';
    strSQL := strSQL + '  CLI_ENDCOM AS ENDCOM, ';
    strSQL := strSQL + '  CLI_BAIRRO AS BAIRRO, ';
    strSQL := strSQL + '  CLI_CODCID AS CODCID, ';
    strSQL := strSQL + '  CLI_C_E_P_ AS C_E_P_, ';
    strSQL := strSQL + '  CLI_FONE01 AS FONE01, ';
    strSQL := strSQL + '  CLI_NUMR_G AS NUM_RG, ';
    strSQL := strSQL + '  CLI_C_G_C_ AS C_G_C_, ';
    strSQL := strSQL + '  CLI_I_E_S_ AS I_E_S_, ';
    strSQL := strSQL + '  CLI_CODATI AS CODATI  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADCLI      ';
    strSQL := strSQL + ' LEFT JOIN CADREG ON CLI_CODREG = REG_CODREG AND ';
    strSQL := strSQL + '                     CLI_CODEMP = REG_CODEMP  ';
    strSQL := strSQL + ' WHERE         ';
    strSQL := strSQL + '   CLI_CODCLI = :CODCLI ';

    With qryDados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      objFatVendas.strCndFor := fFormataCondPag(FieldByName('CONPAG').AsString); //         - Condição de pagamento formatada
      objFatVendas.strCodCli := FieldByName('CODCLI').AsString;                  //         - Cliente - Codigo
      objFatVendas.strCliNom := FieldByName('CLINOM').AsString;                  //         - Nome
      objFatVendas.strCliOri := FieldByName('CLIORI').AsString;                  //         - Nome Original
      objFatVendas.strCliEnd := FieldByName('ENDERE').AsString;                  //         - Endereco
      objFatVendas.strCliNum := FieldByName('ENDNUM').AsString;                  //         - Numero
      objFatVendas.strCliCom := FieldByName('ENDCOM').AsString;                  //         - Complemento
      objFatVendas.strCliBai := FieldByName('BAIRRO').AsString;                  //         - Bairro
      objFatVendas.strCliCep := FieldByName('C_E_P_').AsString;                  //         - Cep
      objFatVendas.strCodCid := FieldByName('CODCID').AsString;                  //         - Cód. Cidade
      objFatVendas.strCliCid := fRetNomCidade(FieldByName('CODCID').AsString,0); //         - Cidade
      objFatVendas.strCliEst := fRetNomCidade(FieldByName('CODCID').AsString,1); //         - Estado
      objFatVendas.strCliAti := FieldByName('CODATI').AsString;
      objFatVendas.strCliTel := FieldByName('FONE01').AsString;                  //         - Telefone
      objFatVendas.strCli_Rg := FieldByName('NUM_RG').AsString;                  //         - RG
      objFatVendas.strCliCgc := fTiraCaracEspeciais(FieldByName('C_G_C_').AsString);//      - CNPJ
      objFatVendas.strCliCgc := AnsiReplaceStr(objFatVendas.strCliCgc, '.', '');
      objFatVendas.intCgcCpf := FieldByName('CGCCPF').AsInteger;                 //         - CGC/CPF
      objFatVendas.strCliIes := FieldByName('I_E_S_').AsString;                  //         - Ins.Estadual
      objFatVendas.strCliImp := FieldByName('I_M_P_').AsString;                  //         - Insc. Municipal Produtor
      objFatVendas.strProRur := FieldByName('PRORUR').AsString;                  //         - Produtor Rural
      objFatVendas.strMicEmp := FieldByName('MICEMP').AsString;                  //         - MEI-Micro Empreendedor Individual
      objFatVendas.strRetPCo := FieldbyName('RETPCO').AsString;                  //         - Retenção de Pis e Cofins
      objFatVendas.strCDesPI := FieldbyName('CDESPI').AsString;                  //         - Calcula desconto de PIS/COFINS/IRPJ/CSLL
      objFatVendas.strSitIPI := FieldByName('SITIPI').AsString;                  //         - Situação do IPI
      objFatVendas.strEnqIPI := FieldByName('ENQIPI').AsString;                  //         - Enquadramento do IPI
      objFatVendas.strMenIPI := FieldByName('MENIPI').AsString;                  //         - Mensagem do IPI
      objFatVendas.strRetIrf := FieldbyName('RETIRF').AsString;                  //         - Retenção de IRPF
      objFatVendas.strRetIss := FieldbyName('RETISS').AsString;                  //         - Retenção de ISS
      objFatVendas.strCliOrg := FieldByName('ORGPUB').AsString;                  //         - Orgao Publico
      objFatVendas.strDesPis := FieldByName('DESPIS').AsString;                  //         - Orgao Publico
      objFatVendas.strOrPuRD := FieldbyName('ORPURD').AsString;                  //         - Tipo de Desconto (Rateio / Desconto)
      objFatVendas.strCalIcm := FieldbyName('CALICM').AsString;                  //         - Calcula Desconto de ICMS (Orgão Public)
      objFatVendas.strZonFra := FieldByName('ZONFRA').AsString;                  //         - Zona Francade Manaus
      objFatVendas.strDesZon := FieldByName('DESZON').AsString;                  //         - Cliente Zona Franca com desconto especial
      objFatVendas.strCodReg := FieldByName('CODREG').AsString;                  //         - Código Da Região
      objFatVendas.strDesReg := FieldByName('DESREG').AsString;                  //         - Descrição da Região
      objFatVendas.strCodZfm := FieldByName('CODZFM').AsString;                  //         - Cód. Cliente p/ Zona Francade Manaus
      objFatVendas.blnCliExportacaoIndireta := FieldByName('EXPIND').AsString = 'S'; //     - Cliente Exportação Indireta
      objFatVendas.strCliCon := FieldByName('CONSUM').AsString;                  //         - Consumidor Final (S/N)
      objFatVendas.strIndCom := FieldByName('INDCOM').AsString;                  //         - Comercializacao/industrializacao
      objFatVendas.blnCliFil := objFatVendas.fClienteFilialVenda(FieldByName('CODCLI').AsString);  //         - Cliente Filial
      objFatVendas.fltFat_TE := objFatVendas.recDadCli.fltFat_TE;
      objFatVendas.strTEPREV := objFatVendas.recDadCli.strTEPREV;
      objFatVendas.strTabPre := FieldByName('TABPRE').AsString;                  //         - Tabela de Preco

      If fEmptyStr(objFatVendas.strTabPre) And fCfgSis('HIETAB', VarBoolean) Then
        objFatVendas.strTabPre := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [objFatVendas.strCodVen], False);

      objFatVendas.blnPermFF := ((FieldByName('PERMFF').AsString = 'S') Or (FieldByName('PERMFV').AsString = 'S'));//         - Permite FF
    End;

    qryDados.Close;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCarregaDadosClienteGarantia]');
      FreeAndNil(qryDados);
      Exit;
    End;
  End;

  FreeAndNil(qryDados);
end;

function fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
  Var
    strSQL: String;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_PESOIT, ';
    strSQL := strSQL + '  I.ITE_PESLIQ, ';
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  I.ITE_CODFOR, ';
    strSQL := strSQL + '  I.ITE_DESITE, ';
    strSQL := strSQL + '  I.ITE_DESFAB, ';
    strSQL := strSQL + '  I.ITE_COMLUB, ';
    strSQL := strSQL + '  I.ITE_CLAIPI, ';
    strSQL := strSQL + '  I.ITE_CODFAB, ';
    strSQL := strSQL + '  I.ITE_CODBAR, ';
    strSQL := strSQL + '  G.ITE_PRECOM, ';
    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE7, ';
    strSQL := strSQL + '  G.ITE_PREULT, ';
    strSQL := strSQL + '  G.ITE_IMPULT, ';
    strSQL := strSQL + '  G.ITE_QTDUCO, ';
    strSQL := strSQL + '  G.ITE_IPISAI, ';
    strSQL := strSQL + '  G.ITE_DESMAX, ';
    strSQL := strSQL + '  G.ITE_SALDOS, ';
    strSQL := strSQL + '  G.ITE_PREMED, ';
    strSQL := strSQL + '  G.ITE_COMVAR, ';
    strSQL := strSQL + '  G.ITE_COMATA, ';
    strSQL := strSQL + '  G.ITE_COMDIS, ';
    strSQL := strSQL + '  G.ITE_MARMIN, ';
    strSQL := strSQL + '  G.ITE_MARMSG, ';
    strSQL := strSQL + '  G.ITE_MARMGE, ';

    strSQL := strSQL + '  G.ITE_MARMMV, ';
    strSQL := strSQL + '  G.ITE_MARMMS, ';
    strSQL := strSQL + '  G.ITE_MARMMG, ';

    strSQL := strSQL + '  G.ITE_DESMVM, ';
    strSQL := strSQL + '  G.ITE_DESMSM, ';
    strSQL := strSQL + '  G.ITE_DESMGM, ';

    strSQL := strSQL + '  G.ITE_IPIENT, ';
    strSQL := strSQL + '  G.ITE_FREENT, ';
    strSQL := strSQL + '  G.ITE_QTPPRO, ';
    strSQL := strSQL + '  A.ABF_CODABF, ';
    strSQL := strSQL + '  M.MAR_DESMAR, ';
    strSQL := strSQL + '  I.ITE_OBRCPF, ';
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  U.UNI_CODUNI, ';
    strSQL := strSQL + '  U.UNI_DESUNI, ';
    strSQL := strSQL + '  I.ITE_CODMAR, ';
    strSQL := strSQL + '  I.ITE_REFERE, ';

    If fCfgSis('IMPDIG') = '1' Then
      strSQL := strSQL + '  I.ITE_IMPDIR  '
    Else
      strSQL := strSQL + '  G.ITE_IMPDIR  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  ABFICM A, ';
    strSQL := strSQL + '  CADMAR M, ';
    strSQL := strSQL + '  CADUNI U  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  I.ITE_CODUNI = U.UNI_CODUNI AND ';

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '  I.ITE_CODABF = A.ABF_CODABF AND '
    Else
      strSQL := strSQL + '  G.ITE_CODABF = A.ABF_CODABF AND ';

    strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  A.ABF_ESTADO = :ESTADO ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
      Open;
    End;

    Result := TRUE;

  Except

    On E: Exception Do
    Begin
      Result := False;
			pMensagensErro(E.Message,'[TfrmGarantiaRecCliente.fGetItem]');
    End;

  End;
end;

function fGetSqlSelNotas(blnComFil, blnEmpMat: Boolean): String;
begin
  Result := Result + ' SELECT * FROM (                                     ';
  Result := Result + ' SELECT SQL_NO_CACHE                                 ';
  Result := Result + '        @RANK   := @RANK + IF(@NUMDOC = CONCAT(D.DET_NUMDOC, D.DET_ESPDOC, D.DET_CODEMP), 1, -@RANK + 1) AS ORDITE, ';
  Result := Result + '        @NUMDOC := CONCAT(D.DET_NUMDOC, D.DET_ESPDOC, D.DET_CODEMP) AS DOCATU, ';
  Result := Result + '        D.DET_NUMDOC,                                  ';
  Result := Result + '        IFNULL(D.DET_SERIE_, "") AS DET_SERIE_,        ';
  Result := Result + '        D.DET_ESPDOC,                                  ';
  Result := Result + '        D.DET_CODEMP,                                  ';
  Result := Result + '        D.DET_CODITE,                                  ';
  Result := Result + '        D.DET_QTDITE,                                  ';
  Result := Result + '        D.DET_DTAENT,                                  ';
  Result := Result + '        ITE_DESITE,                                  ';
  Result := Result + '        ITE_REFERE,                                  ';
  Result := Result + '        D.DET_UNITAR, ';
  Result := Result + '        IFNULL(D.DET_ALQIPI,0) + IFNULL(MOVTRI.DET_ALEIPI,0) AS DET_ALQIPI, ';
  Result := Result + '        D.AUTOINCREM,                           ';
  Result := Result + '        FIS_ACESSO,                                  ';
  Result := Result + '        CAST("" AS CHAR(20)) AS INCGAR,              ';
  Result := Result + '        0 AS QTDITE,                                 ';
  Result := Result + '        @QTDDEV := ';
  Result := Result + '        (IFNULL((SELECT SUM(B.DET_QTDITE) ';
  Result := Result + '         FROM MOVDET B ';
  Result := Result + '         WHERE B.DET_CODFOR = D.DET_CODFOR ';
  Result := Result + '           AND B.DET_TIP_FC = D.DET_TIP_FC ';
  Result := Result + '           AND B.DET_CODITE = D.DET_CODITE ';
  Result := Result + '           AND B.DET_DOCDEV = D.DET_NUMDOC ';
  Result := Result + '           AND B.DET_ESPDEV = D.DET_ESPDOC ';
  Result := Result + '           AND B.DET_EMPDEV = D.DET_CODEMP), 0) ';
  //quantidade em espelho
  Result := Result + '        + IFNULL((SELECT SUM(C2.DET_QTDITE) ';
  Result := Result + '                  FROM ESPGER C ';
  Result := Result + '                  JOIN ESPDET C2 ON C2.DET_SEQGER = C.AUTOINCREM ';
  Result := Result + '                  WHERE C.GER_CODFOR = D.DET_CODFOR ';
  Result := Result + '                    AND C.GER_TIP_FC = D.DET_TIP_FC ';
  Result := Result + '                    AND C2.DET_CODITE = D.DET_CODITE ';
  Result := Result + '                    AND C2.DET_DOCDEV = D.DET_NUMDOC ';
  Result := Result + '                    AND C2.DET_ESPDEV = D.DET_ESPDOC ';
  Result := Result + '                    AND IFNULL(C.GER_MOVGER,"") = ""), 0)) AS QTDDEV, ';

  Result := Result + '        0.0000 AS QTDRES, ';
  Result := Result + '        0.0000 AS QTDDIS, ';
  Result := Result + '        0 AS MARDES                                  ';
  Result := Result + ' FROM MOVGER                                         ';
  Result := Result + ' INNER JOIN MOVDET D ON MOVGER.AUTOINCREM = D.DET_SEQGER ';
  Result := Result + ' INNER JOIN (SELECT @RANK := 0, @NUMDOC := "") R ON TRUE ';
  Result := Result + ' INNER JOIN CADITE ON ITE_CODITE = D.DET_CODITE        ';
  Result := Result + ' INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = D.AUTOINCREM ';
  Result := Result + ' LEFT JOIN CADFIS ON D.DET_NUMDOC = FIS_NUMDOC ';
  Result := Result + '                 AND D.DET_ESPDOC = FIS_ESPDOC ';
  Result := Result + '                 AND D.DET_CODEMP = FIS_CODEMP ';
  Result := Result + '                 AND D.DET_CODFOR = FIS_FORCLI ';
  Result := Result + '                 AND IFNULL(D.DET_SERIE_, "") = FIS_SERIE_ ';
  Result := Result + '                 AND D.DET_TIP_FC = FIS_TIP_FC ';
  Result := Result + ' WHERE     ';

  If blnComFil Then
  Begin
    Result := Result + '           MOVGER.GER_CODFOR = :CODFOR                       ';

    If blnEmpMat then
    begin
      Result := Result + '       AND MOVGER.GER_CODEMP IN (SELECT DISTINCT C.SIS_CODEMP ';
      Result := Result + '     		                         FROM CFGSIS C ';
      Result := Result + '                                 WHERE C.SIS_CODCFG = "CFG_EMPGAR" AND C.SIS_VALCFG = :CODEMP) ';
    end
    else
      Result := Result + '       AND MOVGER.GER_CODEMP = :CODEMP ';

    Result := Result + '   AND D.DET_TIP_FC = "F"                             ';
    Result := Result + '   AND LOCATE(D.DET_CLAFIS, "'+ vs_strClaCom + '_1910_2910' + '") > 0 ';
    Result := Result + '   AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIM       ';
    Result := Result + '   AND D.DET_CODITE = :CODITE                         ';
    Result := Result + '   AND D.DET_ORIDOC = ""                              ';
  End
  Else
    Result := Result + ' FALSE                                        ';

  Result := Result + ' ORDER BY D.DET_DTAENT DESC, CONCAT(D.DET_CODEMP, D.DET_ESPDOC, D.DET_NUMDOC) ASC, D.AUTOINCREM ASC) AS TAB ';
  Result := Result + ' WHERE  (TAB.DET_QTDITE - TAB.QTDDEV) > 0 ';
end;

procedure pAtualizaLoteMovGad(strNumPed, strEmpPed: String);
  Var
    qryUpdate : TUniQuery;
    qryMovGad : TUniQuery;
    strAutInc : String;
    strNumLot : String;
    objCadLot : TCadLot;
Begin
  qryMovGad := fCriaQuery;
  qryUpdate := fCriaQuery;
  objCadLot := TCadLot.Create(nil);
  Try
    qryMovGad.SQL.Add(' SELECT D.AUTOINCREM, GAD_CODITE ');
    qryMovGad.SQL.Add(' FROM PCMDET T ');
    qryMovGad.SQL.Add(' INNER JOIN SEQGAR S ON S.SEQ_PCMDET = T.AUTOINCREM ');
    qryMovGad.SQL.Add(' INNER JOIN MOVGAD D ON D.AUTOINCREM = SEQ_MOVGAD ');
    qryMovGad.SQL.Add(' WHERE PCD_NUMPED = :NUMPED ');
    qryMovGad.SQL.Add('   AND PCD_CODEMP = :CODEMP ');
    qryMovGad.SQL.Add('   AND PCD_ESPDOC = :ESPDOC ');

    qryMovGad.ParamByName('NUMPED').AsString := strNumPed;
    qryMovGad.ParamByName('CODEMP').AsString := strEmpPed;
    qryMovGad.ParamByName('ESPDOC').AsString := 'PD';

    qryMovGad.Open;

    While Not qryMovGad.Eof Do
    Begin
      strNumLot := objCadLot.fRetArmazemPrincipalGarantia(qryMovGad.FieldByName('GAD_CODITE').AsString);
      strAutInc := qryMovGad.FieldByName('AUTOINCREM').AsString;

      qryUpdate.Close;
      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add(' UPDATE MOVGAD SET GAD_NUMLOT = :NUMLOT ');
      qryUpdate.SQL.Add(' WHERE AUTOINCREM = :AUTINC             ');

      qryUpdate.ParamByName('NUMLOT').AsString := strNumLot;
      qryUpdate.ParamByName('AUTINC').AsString := strAutInc;
      qryUpdate.ExecSQL;

      qryMovGad.Next;
    End;

  Finally
    FreeAndNil(qryMovGad);
    FreeAndNil(qryUpdate);
    FreeAndNil(objCadLot);
  End;

End;

function fSqlObterValorSeqGar(const strColFil: String):String;
Var
  Sql: String;
begin
  Sql :=         ' SELECT * ';
  Sql :=   Sql + ' FROM SEQGAR ';
  Sql :=   Sql + ' WHERE %0:s = :VALFIL ';
  Result := Format(Sql,[strColFil]);
end;
function fObterValorSeqGar(const strValCol, strColFil, strValFil: String): String;
Var
  Qry: TUniQuery;
begin
  Qry := nil;
  Result := EmptyStr;
  Try
    Qry := fCriaQuery(Nil);
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add(fSqlObterValorSeqGar(strColFil));
    Qry.ParamByName('VALFIL').AsString := strValFil;
    Qry.Open;
    if  Qry.Active then
    begin
      if Not Qry.IsEmpty then
      begin
        Result := Qry.FieldByName(strValCol).AsString;
      end;
      Qry.Close;
    end;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

function fBaixaGarantiaReprovada(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
Var
  qryUpdate : TUniQuery;
Begin
  Result := False;
  Try
    qryUpdate := fCriaQuery;
    Try
      qryUpdate.SQL.Add('UPDATE MOVGAD');
      qryUpdate.SQL.Add('   SET GAD_QTDREF = GAD_QTDREP,');
      qryUpdate.SQL.Add('       GAD_QTDREP = 0');
      qryUpdate.SQL.Add(' WHERE MOVGAD.AUTOINCREM IN (SELECT GPV_SEQGAD FROM FATGOR');
      qryUpdate.SQL.Add('                              INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM');
      qryUpdate.SQL.Add('                              INNER JOIN MOVGPV ON MOVGPV.GPV_SEQFDO = FATDOR.AUTOINCREM');
      qryUpdate.SQL.Add('                              WHERE FATGOR.FGO_NUMDOC = "' + strNumDoc + '"');
      qryUpdate.SQL.Add('                                AND FATGOR.FGO_ESPDOC = "' + strEspDoc + '"');
      qryUpdate.SQL.Add('                                AND FATGOR.FGO_CODEMP = "' + strCodEmp + '")');
      qryUpdate.SQL.Add('   AND GAD_QTDREP > 0');
      qryUpdate.ExecSQL;
      Result := True;
    Finally
      FreeAndNil(qryUpdate);
    End;

  Except
    on E:Exception do
      pMensagensErro(E.Message, '[untGarant.fBaixaGarantiaReprovada]');
  End;
End;

function fEstornaBaixaGarantiaReprovada(strFdoInc: String): Boolean;
  Var
    qryUpdate : TUniQuery;
Begin
  Result := False;
  Try
    qryUpdate := fCriaQuery;
    Try
      qryUpdate.SQL.Add('UPDATE MOVGAD');
      qryUpdate.SQL.Add(' INNER JOIN MOVGPV ON MOVGPV.GPV_SEQGAD = MOVGAD.AUTOINCREM');
      qryUpdate.SQL.Add(' INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = MOVGPV.GPV_SEQFDO AND FDO_REPGAR = 2');
      qryUpdate.SQL.Add(' INNER JOIN FATDOR ON FATDOR.AUTOINCREM = MOVGPV.GPV_SEQFDO');
      qryUpdate.SQL.Add('   SET GAD_QTDREF = GAD_QTDREF - FDO_QTDITE,');
      qryUpdate.SQL.Add('       GAD_QTDREP = GAD_QTDREP + FDO_QTDITE');
      qryUpdate.SQL.Add(' WHERE MOVGPV.GPV_SEQFDO = "' + strFdoInc + '"');
      Result := True;
    Finally
      FreeAndNil(qryUpdate);
    End;

  Except
    on E:Exception do
      pMensagensErro(E.Message, '[untGarant.fBaixaGarantiaReprovada]');
  End;
End;

procedure pVerificarSeExisteItemEmProcessoGarantia(const strNumDoc, strEspDoc, strCodEmp: String);
(* régua
                                                                              79 posições
| Item    | Descrição                                   | Documento           |
| 1234567 | 1234567890123456789012345678901234567890123 | 123456789012-12-123 |

*)
  const
    LARGURA_LINHA: Integer = 79;

  function fGetSql: String;
  begin
    Result := EmptyStr;
    Result := Result + ' SELECT  D.DET_CODITE, D.DET_NUMDOC, D.DET_ESPDOC, D.DET_CODEMP,  D.DET_DOCDEV, D.DET_ESPDEV, C.GRC_OPCDOC, ';
    Result := Result + '         IF(C.GRC_OPCDOC = ''GA'', GAG.GAG_NUMENT, D2.DET_NUMDOC) AS NUMDOCGAR, ';
    Result := Result + '         D2.DET_ESPDOC ESPDOCGAR, D2.DET_CODEMP EMPDOCGAR, ITE.ITE_DESITE ';
    Result := Result + ' FROM MOVDET D ';
    Result := Result + ' JOIN MOVGAE E ON E.GAE_INCENV = D.AUTOINCREM ';
    Result := Result + ' JOIN MOVGRC C ON C.GRC_SEQGAD = E.GAE_SEQGAD AND C.GRC_OPCDOC IN ("NE","OE","GA") ';
    Result := Result + ' JOIN MOVDET D2 ON D2.AUTOINCREM = C.GRC_SEQDET ';
    Result := Result + ' JOIN MOVGAD GAD ON GAD.AUTOINCREM = C.GRC_SEQGAD ';
    Result := Result + ' JOIN MOVGAG GAG ON GAG.AUTOINCREM = GAD.GAD_SEQGAG ';
    Result := Result + ' JOIN CADITE ITE ON ITE.ITE_CODITE = D.DET_CODITE ';
    Result := Result + ' WHERE D.DET_DOCDEV = :NUMDOC AND D.DET_ESPDEV = :ESPDOC AND D.DET_EMPDEV = :CODEMP ';
    Result := Result + ' ORDER BY D.DET_CODITE, NUMDOCGAR, ESPDOCGAR, EMPDOCGAR; ';
  end;
  function fMontarLinhaMsg(strCodIte, strDesIte, strNumDoc, strEspDoc, strCodEmp: String; blnTitulo: boolean): String;
  Const
    LARGURA_PRODUTO : Integer = 7;
    LARGURA_DESCRICAO: Integer = 43;
    LARGURA_NUMDOC: Integer =  19;
    MASCARA_LINHA: String = '| %0:s | %1:s | %2:s |';
  Var
    lCodIte: String;
    lDesIte: String;
    lNumDoc: String;
    strProduto: String;
    strDescricao: string;
    strDocumento: String;
  begin
    if blnTitulo then
    begin
      lCodIte := 'Item';
      lDesIte := 'Descrição';
      lNumDoc := 'Documento';
    end
    else begin
      lCodIte := strCodIte;
      lDesIte := strDesIte;
      lNumDoc := strNumDoc+'-'+strEspDoc+'-'+strCodEmp;
    end;

    strProduto  := leftstr(fPadR(lCodIte, LARGURA_PRODUTO), LARGURA_PRODUTO);
    strDescricao := LeftStr(fPadR(lDesIte, LARGURA_DESCRICAO), LARGURA_DESCRICAO);
    strDocumento := LeftStr(fPadR(lNumDoc, LARGURA_NUMDOC), LARGURA_NUMDOC);
    Result := Format(MASCARA_LINHA,[strProduto, strDescricao, strDocumento]);
  end;
  Var
    Qry: TUniQuery;
    objLiberacao: TLiberacao;
begin
  Qry := Nil;
  objLiberacao := Nil;
  Try
    Qry := fCriaQuery;
    Qry.SQL.Clear;
    Qry.Sql.Add(fGetSql);
    Qry.ParamByName('NUMDOC').AsString := strNumDoc;
    Qry.ParamByName('ESPDOC').AsString := strEspDoc;
    Qry.ParamByName('CODEMP').AsString := strCodEmp;
    Qry.Open;
    Qry.First;

    If Qry.IsEmpty then
      Exit;

    objLiberacao := TLiberacao.Create;

    objLiberacao.strDirAce := '_SEM_DIR_'; // APENAS PARA NÃO EXIBIR NENHUM CAMINHO DE DIREITO DE ACESSO NA MENSAGEM.
    objLiberacao.strSenLib := EmptyStr;
    objLiberacao.strMsgSen := EmptyStr;
    objLiberacao.strCodOpe := EmptyStr;
    objLiberacao.strCodDig := EmptyStr;
    objLiberacao.strCliente := EmptyStr;
    objLiberacao.strCpfCnpj := EmptyStr;
    objLiberacao.blnAviso_ := True;
    objLiberacao.blnTraTel := False;

    objLiberacao.objMsgLibera.pAddTexto('O documento selecionado contém vínculo com documento(s) de garantia. ');
    objLiberacao.objMsgLibera.pAddTexto('Não poderá ser realizada sua devolução integral.');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddSeparador(LARGURA_LINHA);
    objLiberacao.objMsgLibera.pAddTexto(fMontarLinhaMsg('','','','','',true));
    objLiberacao.objMsgLibera.pAddSeparador(LARGURA_LINHA);
    While Not Qry.Eof do
    begin
      objLiberacao.objMsgLibera.pAddTexto(fMontarLinhaMsg(Qry.FieldByName('DET_CODITE').AsString,
                                                          Qry.FieldByName('ITE_DESITE').AsString,
                                                          Qry.FieldByName('NUMDOCGAR').AsString,
                                                          Qry.FieldByName('ESPDOCGAR').AsString,
                                                          Qry.FieldByName('EMPDOCGAR').AsString,
                                                          false));

      Qry.Next;
    end;
    objLiberacao.objMsgLibera.pAddSeparador(LARGURA_LINHA);
    objLiberacao.fLibera;
  Finally
    if Assigned(objLiberacao) then
      FreeAndNil(ObjLiberacao);
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

function fGerarHistoricoCredito(arrIncGad: Array of String): String;
  CONST
    OBS_ITEM: String = 'PRODUTO: %s-%s -Qtd %s';
    OBS_DOCUMENTO: String =  'DT.VENDA: %s NF VENDA: %s-%s-%s Documento: %s-GA-%s';
    DOCUMENTO: Byte = 0;
    OBSERVACAO: Byte = 1;
    ITEM: Byte = 2;
    DOCUMENTO_AUX: Byte = 3;
  Var
    stlGarantias: TStringList;
    Qry: TUniQuery;
    strSQL: String;
    intIdx: Integer;
    strGarantias: String;
    arrObservacao: Array [0..3] Of String;
    blnParar: Boolean;
begin
  Result := EmptyStr;
  if length(arrIncGad) = 0then
    Exit;

  stlGarantias := TStringList.Create;
  stlGarantias.Delimiter := '=';

  for intIdx := Low(arrIncGad) to High(arrIncGad) do
  begin
    if stlGarantias.IndexOfName(arrIncGad[intIdx]) = -1 then
    begin
      stlGarantias.add(arrIncGad[intIdx]+'= ');

      if strGarantias = EmptyStr then
        strGarantias := QuotedStr(arrIncGad[intIdx])
      else
        strGarantias := strGarantias + ', '+QuotedStr(arrIncGad[intIdx]);
    end;
  end;

  strSQL := EmptyStr;
  strSQL := strSQL + 'SELECT D.AUTOINCREM, D2.DET_DTAENT, D2.DET_NUMDOC, D2.DET_ESPDOC, D2.DET_DESCRI, D2.DET_CODEMP, D.GAD_NUMDOC, D.GAD_ESPDOC, D.GAD_CODEMP, ';
  strSQL := strSQL + '       D.GAD_CODITE, D.GAD_QTDREQ, D.GAD_SCREDI, G.GAG_NUMENT, G.GAG_CODEMP ';
  strSQL := strSQL + 'FROM MOVGAD D ';
  strSQL := strSQL + 'JOIN MOVGAG G ON G.AUTOINCREM = D.GAD_SEQGAG ';
  strSQL := strSQL + 'JOIN MOVDET D2 ON D2.AUTOINCREM = D.GAD_SEQDOC ';
  strSQL := strSQL + 'WHERE D.AUTOINCREM IN (%s) ';
  strSQL := strSQL + 'ORDER BY DET_NUMDOC, DET_ESPDOC, DET_CODEMP, GAD_CODITE ';

  strSQL := Format(strSQL,[strGarantias]);
  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add(strSQL);
    Qry.Open;
    if Qry.IsEmpty Then
      Exit;

//    REF. LANC. CREDITO ( GARANTIA )
//    DT.VENDA: 22/12/2020 - NF VENDA: 000000001014-NF-001 - Documento: 000000000211-GA-001 - PRODUTO: 91002-02 ITEM ST - FREDERICO-UNIDADE-Qtd: 2
//    PRODUTO: 91001-01 ITEM TRIBUTADO - FREDERICO-TESTE-Qtd: 2

    Qry.First;

//   'DT.VENDA: %0:s NF VENDA: %1:s-%2:s-%3:s Documento: %4:s-GA-%5:s
    arrObservacao[DOCUMENTO] := Format(OBS_DOCUMENTO,
                                       [FormatDateTime('dd/mm/yyyy',Qry.FieldByName('DET_DTAENT').AsDateTime),
                                        Qry.FieldByName('DET_NUMDOC').AsString,
                                        Qry.FieldByName('DET_ESPDOC').AsString,
                                        Qry.FieldByName('DET_CODEMP').AsString,
                                        Qry.FieldByName('GAG_NUMENT').AsString,
                                        Qry.FieldByName('GAG_CODEMP').AsString]);

    While Not Qry.Eof do
    begin
      arrObservacao[DOCUMENTO_AUX] := arrObservacao[DOCUMENTO];
      Repeat
//     'PRODUTO: %s-%s -Qtd %s';
        arrObservacao[ITEM] := Format(OBS_ITEM,[Qry.FieldByName('GAD_CODITE').AsString,
                                                Qry.FieldByName('DET_DESCRI').AsString,
                                                FormatFloat('#0',Qry.FieldByName('GAD_QTDREQ').AsFloat)]);

        if arrObservacao[OBSERVACAO] = EmptyStr then
          arrObservacao[OBSERVACAO] := arrObservacao[ITEM]
        else
          arrObservacao[OBSERVACAO] := arrObservacao[OBSERVACAO] +', '+arrObservacao[ITEM];

        Qry.Next;

        blnParar := Qry.Eof;

        if Not blnParar then
        begin
//        'DT.VENDA: %0:s NF VENDA: %1:s-%2:s-%3:s Documento: %4:s-GA-%5:s
          arrObservacao[DOCUMENTO_AUX] :=  Format(OBS_DOCUMENTO,
                                                  [FormatDateTime('dd/mm/yyyy',Qry.FieldByName('DET_DTAENT').AsDateTime), //0
                                                   Qry.FieldByName('DET_NUMDOC').AsString,                                //1
                                                   Qry.FieldByName('DET_ESPDOC').AsString,                                //2
                                                   Qry.FieldByName('DET_CODEMP').AsString,                                //3
                                                   Qry.FieldByName('GAG_NUMENT').AsString,                                //4
                                                   Qry.FieldByName('GAG_CODEMP').AsString]);                              //5

          blnParar := (arrObservacao[DOCUMENTO_AUX] <> arrObservacao[DOCUMENTO]);
        end;
      Until  blnParar;
      intIdx := stlGarantias.IndexOfName(Qry.FieldByName('AUTOINCREM').AsString);
      if intIdx >= 0 then
        stlGArantias[intIdx] := Format('%s %s',[arrObservacao[DOCUMENTO],
                                                arrObservacao[OBSERVACAO]]);
    end;

    for intIdx := 0 to stlGarantias.Count -1 do
    begin
      if Result = EmptyStr then
        Result := stlGarantias[intIdx]
      else
        Result := Result +'; '+slineBreak+stlGarantias[intIdx];
    end;

    Result := 'REF. LANC. CREDITO ( GARANTIA ) '+sLineBreak + Result;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);

    if Assigned(stlGarantias) then
      FreeAndNil(stlGarantias);
  End;
end;

function fScriptValIte(strAliasMovDet: String): String;
  Var
    strAux: String;
begin
//  valite = 'MOVDET.DET_TOTITE - MOVDET.DET_DESESP - MOVDET.DET_DESCFF';

  if femptystr(strAliasMovDet) then
    strAux := EmptyStr
  else
    strAux := strAliasMovDet+'.';

  Result := Format(' IFNULL(%0:sDET_TOTITE,0) - IFNULL(%0:sDET_DESESP,0) - IFNULL(%0:sDET_DESCFF,0) ',[strAux]);

end;
function fScriptValCredito(strAliasMovDet: String; strAliasMovTri: String): String;
  Var
    strAliasT1, strAliasT2: String;
begin
//    CREDITO =  FORMULA_VALITE + '+ (MOVDET.DET_VALIPI + MOVDET.DET_VALRET + MOVDET.DET_DESACE + T.DET_VFCPST) ';
  if femptystr(strAliasMovDet) then
    strAliasT1 := EmptyStr
  else
    strAliasT1 := strAliasMovDet+'.';

  if femptystr(strAliasMovTri) then
    strAliasT2 := EmptyStr
  else
    strAliasT2 := strAliasMovTri+'.';

  Result := fScriptValIte(strAliasMovDet);
  Result := Result + ' + (IFNULL(%0:sDET_VALIPI,0) + IFNULL(%0:sDET_VALRET,0) + IFNULL(%0:sDET_DESACE,0) + IFNULL(%1:sDET_VFCPST,0))  ';
  Result := Format(Result,[strAliasT1, strAliasT2]);
end;

function fEhPedidoTransferenciaGarantiaGarMat(strAutInc: String): Boolean;
  Var
    Qry: TUniQuery;
    strSql: String;
begin
  strSql := ' SELECT COUNT(1) AS "TOTAL" ';
  strSql := strSql + ' FROM FATDOR D ';
  strSql := strSql + ' JOIN SEQGAR G ON G.SEQ_FDO_TE = D.AUTOINCREM ';
  strSql := strSql + ' WHERE D.FDO_SEQGER = :strSeqGor; ';

  Result := False;
  Qry := Nil;
  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add(strSql);
    Qry.ParamByName('strSeqGor').AsString := strAutInc;
    Qry.Open;
    if Qry.IsEmpty Then
      Exit;

    Result := Qry.FieldByName('TOTAL').AsInteger >= 1;

  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

function fEhPedidoTransferenciaGarantiaGarMat(stlPedidos: TStringList; strPedidosParciais: String; out strPedidoTransfGarant: String): Boolean;overload;
  Var
    intIndex: Integer;
begin
  Result := False;

  if stlPedidos.Count = 0 then
    Exit;

  strPedidoTransfGarant := '';
  try
    for intIndex := 0 to stlPedidos.Count -1 do
    begin
      if Assigned(TPedidoVenda(stlPedidos.Objects[intIndex])) then
      Begin
        if (Pos(TPedidoVenda(stlPedidos.Objects[intIndex]).strNumDoc, strPedidosParciais) > 0) then
        Begin
          If fEhPedidoTransferenciaGarantiaGarMat(TPedidoVenda(stlPedidos.Objects[intIndex]).strSeqGer) Then
          Begin
            strPedidoTransfGarant := strPedidoTransfGarant + IfThen(fEmptyStr(strPedidoTransfGarant),'', ', ') + TPedidoVenda(stlPedidos.Objects[intIndex]).strNumDoc;
          End;
        End;
      end;
    end;
  finally
    Result := Not fEmptyStr(strPedidoTransfGarant);
  end;
end;

function fReposicaoEntregaRetira: TReposicaoEntregaRetira;
Var
  intOpcao: Integer;
begin
  intOpcao := fMensagem('',
                        'Destino dos Itens?',
                        ['&Entrega','&Retira'],
                        1,
                        False,
                        1,
                        0,
                        False,
                        0,
                        False,
                        False,
                        True);

  if TReposicaoEntregaRetira(ord(intOpcao)) in [trEntrega, trRetira] Then
    Result := TReposicaoEntregaRetira(ord(intOpcao))
  else
    raise Exception.Create('Opção inválida para destino dos itens.');

end;

function fValidarDocumentoOrigemGarantia(pstrIncGad,
  pstrIncOri: String): Boolean;
Var
  lQry: TUniQuery;
  lstrSQL: String;
begin
  Result := False;
  lQry := fCriaquery;
  Try
    lstrSql :=           ' SELECT A.GAD_CODITE, ';
    lstrSql := lstrSql + '        B.GAG_CODCLI, ';
    lstrSql := lstrSql + '        (SELECT COUNT(1) ';
    lstrSql := lstrSql + '         FROM MOVDET T ';
    lstrSql := lstrSql + '         WHERE T.AUTOINCREM = :INCORI ';
    lstrSql := lstrSql + '           AND T.DET_CODCLI = B.GAG_CODCLI ';
    lstrSql := lstrSql + '           AND T.DET_CODITE = A.GAD_CODITE) AS MOVDET, ';

    lstrSql := lstrSql + '        (SELECT COUNT(1) ';
    lstrSql := lstrSql + '         FROM NOTDET T ';
    lstrSql := lstrSql + '         WHERE T.AUTOINCREM = :INCORI ';
    lstrSql := lstrSql + '           AND T.DET_CODCLI = B.GAG_CODCLI ';
    lstrSql := lstrSql + '           AND T.DET_CODITE = A.GAD_CODITE) AS NOTDET ';

    lstrSql := lstrSql + ' FROM MOVGAD A ';
    lstrSql := lstrSql + ' JOIN MOVGAG B ON B.AUTOINCREM = A.GAD_SEQGAG ';
    lstrSql := lstrSql + ' WHERE A.AUTOINCREM = :INCGAD  ';

    lQry.Close;
    lQry.Sql.Clear;
    lQry.Sql.Add(lstrSql);
    lQry.ParamByName('INCGAD').AsString := pstrIncGad;
    lQry.ParamByName('INCORI').AsString := pstrIncOri;
    lQry.Open;

    if lQry.IsEmpty then
      Exit;

    lQry.First;
    Result := (lqry.FieldByName('MOVDET').AsInteger > 0)
      Or (lqry.FieldByName('NOTDET').AsInteger > 0);

  Finally
    lQry.Free;
  End;
end;

{ TReposicaoEntregaRetiraHelper }

function TReposicaoEntregaRetiraHelper.AsString_S_N: String;
begin
  if Not (Self in [trEntrega, trRetira]) then
    raise Exception.Create('Opção inválida para destino dos itens.');

  if Self = trEntrega then
    Result := 'S'
  else
    Result := 'N';
end;

end.

