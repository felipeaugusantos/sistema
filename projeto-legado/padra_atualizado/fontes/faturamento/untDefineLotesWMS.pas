unit untDefineLotesWMS;

interface

uses StrUtils, SysUtils, Classes, Forms, DB, stdCtrls,
     Uni, Controls, EditFocus, UniClientDataSet, untTypesSistema,
     Math, ComCtrls, Variants, untCadLote, untFuncFat, cxProgressBar,
     Generics.Collections, untMovimentacaoProgramada, untFuncFatTypes,
     AgrupamentoDeOndaDeSeparacao.Funcoes, AgrupamentoDeOndaDeSeparacao.Types,
     untTFatReprocessarSaldoItem;

Type
  TDadosEstoqueLote = record
    fltSaldo : double;
    fltSaldoReservado : double;
    fltMovimentacaoEntrada : double;
    fltMovimentacaoSaida : double;
  end;

  TRecLseWms = Class
  Private
    FCodSep : String;
    FLocFis : Array of String;
  Public
    Constructor Create;

    procedure pAddLocFis(strLocFis : String);
    function fGetLocFis : String;
    Property strCodSep : String Read FCodSep Write FCodSep;
  End;

  TDadosTravaSaldo = Record
    strCodIte: string;
    fltQtdDis: Double;
    fltQtdSep: Double;
    fltQtdPed: Double;
    fltResEnd: Double;
    fltQtdCor: Double;
  End;

  TCorDetRobo = Record
    strNumLot: String;
    fltSalDisLot: Double;
    sltSalFisLot: Double;
  End;

  TarrCorDetRobo = Array of TCorDetRobo;

  TLotCorRobo = Record
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCLi: String;
    strCodIte: String;
    fltSalDisIte: Double;
    fltSalFisIte: Double;
    fltQtdTotPed: Double;
    fltQtdCor: Double;
    arrCorDet: TarrCorDetRobo;
  End;

  TDefineLotesWMS = Class(TComponent)
    Private
      FQtdIte                : Double; // QUANTIDADE DE UM ITEM A SER DIGITADO OS LOTES
      FcdsSaldoEPonRepPorLoc : TUniClientDataSet;
      FNumPed                : String;
      FEmpPed                : String;
      FCadLot                : TCadLot;
      FLabelInf              : TLabel;
      FProgresso             : TcxProgressBar;
      FTemDig                : Boolean;
      FRecalcularQtdeItens   : Boolean;
      FAutIncTinta           : String; //Veio da formulacao de tinta de maquina com todas as regras corretas
      FUsaWMSRastreavelTinta : Boolean;
      FCodIte                : String;
      FCodCli                : String;
      FCodLseItens           : String;
      FEhDefinicaoDeLotesPickingCheckOut : Boolean;

      FCodLot: String;
      FCodEmp: String;
      FLotSep: Boolean;
      FblnSomenteSemLotes: Boolean;
      FExpedicao: Boolean;
      FAtualizaPedCortado: Boolean;
      FModoSemMensagens : Boolean;
      FMensagens: TStringList;
      FItensRemessa : TItensRemessa;
      FComTransacao : Boolean;

      Procedure pCriaSaldoEPonRepPorLoc(Var cdsSaldoEPonRepPorLoc: TUniClientDataSet);
      Procedure pLoteBeforePost(DataSet: TDataSet);

      Procedure pAtualizaLoteItem(strCodIte,
                                  strAutDet,
                                  strLotOri,
                                  strOrigem : String;
                                  fltQtdOri : Double;
                                  blnMostrarLoteNaoPicking : Boolean = False;
                                  strCodBar : String = '';
                                  strIdePro : String = '');

      Procedure pAtualizaLoteItemOndaDeSeparacao(strCodIte : String; fltQtdOri: Double);

      procedure pAtualizaLocalizaoFisica(const cdsItePed: TUniClientDataSet);

      Procedure pAtualizaTotalDigitado(strCodIte: String);

      Procedure pAtualizaSaldosLotes;
      Procedure pAtualizaSaldosLotesOndaDeSeparacao;

      procedure pAtualizaSaldoDisponivelLotes;

      function fRetSaldoLote(strCodIte, strNumLot: String) : TDadosEstoqueLote;
      function fRetSaldoLoteOndaDeSeparacao(strCodIte, strNumLot: String) : TDadosEstoqueLote;

      Procedure pSalvaAlteracaoLotes(cdsItePed: TUniClientDataSet);
      Procedure pCopiaClient(cdsOrigem, cdsDestino: TUniClientDataSet);
      function fLoteBrokerValido(DataSet: TDataSet): Boolean;

      function fTemLoteDig(cdsItePed: TUniClientDataSet): Boolean; Overload;
      function fTemLoteDig(qryItePed: TUniQuery): Boolean; Overload;

      function fQuantidadeLotDor(cdsItePed: TUniClientDataSet): Double;
      function fQuantidadeLotDorOndaDeSeparacao(strCodIte : String): Double;

      procedure pVerificaSeFaraMovimentacaoProgramadaForcada(Var aBlnForcaMovimentacaoProgramada: Boolean);

      procedure pSelecionarLotesSugestao(cdsItePed: TUniClientDataSet);
      procedure pSelecionarLotesSugestaoOndaDeSeparacao(AItensOnda: TUniClientDataSet);

      function fRetornaSaldosLotePicking(strCodIte, strIdePro: string; strCodLoc: string = ''): Double;
      function fRetornaSaldoDeCorte(strCodIte, strIdePro: string): Double;
      function fItemTemLocalizacaoMapeada(strCodIte : String) : Boolean;
      function fItemTemLocalizacaoMapeadaAtiva(strCodIte: String; out strLocFis: String; blnPicking: Boolean = False): Boolean;
      function fRetornaSaldoReservadoEnderecamento(strCodIte: string): Double;
      function fRetornaSaldoDisponivel(strCodIte, strIdePro: string): Double;
      procedure pSalvaLotCor(recLotCorRobo: TLotCorRobo);

      function fGetSqlProdutosAcabado: String;
      procedure pAtualizaLocalizaoFisicaProdutoAcabado(const strCodAca,
        strCodLoc: String);

      procedure pMostraMensagem(strMensagem: String);
      procedure pCriaLotesItens(Var cdsLote: TUniClientDataSet);

      function fVerificaLotesTintaComSaldo: String;
    Protected
      FLotes: TUniClientDataSet;
      FOndaDeSeparacao: String;
      FItensDiverg: TItensDiverg;
      arrLseWms: TObjectDictionary<String, TRecLseWms>;

      procedure pArmazenaMensagem(strMensagem: String);
      procedure pMontaMensagemItensQtdeDivergente;
      procedure pInsereLote(qryLotIte, qryCadLoc: TUniQuery; strAutDet, strLotOri, strOrigem: String; fltQtdOri: Double; blnInserir: Boolean);
      procedure pRegistraProgresso(strMsg: String; intPos, intMax: Integer);

    Public

      class function fClienteEstoqueExterno(strCodCli : String = '') : Boolean;

      function fExisteDefinicaoLotesParaDocumento(strNumDoc, strEspDoc, strCodEmp: String): Boolean;

      procedure pAtualizaScrollLotes(cdsItePed: TUniClientDataSet; strLote: String);

      procedure pAtualizaLotes(cdsItePed: TUniClientDataSet; blnReiniciar: Boolean; arrDadosCodBarra: TarrayDadosCodBarra = Nil);
      procedure pAtualizaLotesOndaDeSeparacao(cdsItensOnda: TUniClientDataSet; blnReiniciar: Boolean);

      procedure pMovimentacaoProgramadaFinal( blnImprimiuSeparacao : Boolean );

      procedure pCarregaLotesDigitados(strCodIte, strAutInc : String; Var cdsDados : TUniClientDataSet);
      procedure pCarregaLotesDigitadosOndaDeSeparacao(strCodIte : String; Var cdsDados : TUniClientDataSet);
      procedure pCarregaLocalizaoFisica(const strCodIte, strCodAca: String;
        Var cdsDados : TUniClientDataSet);

      function fGetSqlItensPedido: String;
      function fGetSqlItensOndaDeSeparacao(blnAgrupar : Boolean;
                                           strCodIte  : String = ''): String;

      function fValidarLotes(cdsItePed: TUniClientDataSet; blnChamouPeloRobo: Boolean = False): Boolean;
      function fValidarLotesOndaDeSeparacao(cdsItensOnda: TUniClientDataSet): Boolean;

      function fQuantidadeDigitadaLotes: Double;
      function fValidaSaldoDisponivelLotes(Var strLotes: String): Boolean;

      function fSalvarQuantidadeDigitadaBD(cdsItePed: TUniClientDataSet; prgProgresso : TProgressBar): Boolean;
      function fSalvarQuantidadeDigitadaBDOndaDeSeparacao(cdsItensOnda: TUniClientDataSet; prgProgresso : TProgressBar): Boolean;

      procedure pCarregarQuantidadeDigitadaBD(cdsItePed: TUniClientDataSet);
      procedure pCarregarQuantidadeDigitadaBDOndaDeSeparacao;

      function fRetQuantidadeDigitada(cdsLote: TUniClientDataSet;
                                      strCodIte, strNumLot, strAutDet: String): Double;

      function fDigitaLotes(strCodIte, strDescri, strAutInc: String;
                            fltQtdIte: Double; strIdePro: String; Var strLote: String): Boolean;

      function fValidaCadastroLotesProdutos: Boolean;
      function fValidaCadastroLotesProdutosOndaDeSeparacao: Boolean;

      function fSolicitaSeparadoresPorLocalDeSeparacao(strSenSep : String): Boolean;

      procedure pSalvarLocalizacaoFisicaCdsLote(const strCodIte, strCodAca,
        strCodLoc: String);

      function fPossuiMensagemDeErro: Boolean;

      class function fGetSqlLotes(blnMostrarLoteNaoPicking             : Boolean = False;
                                  blnExpedicao                         : Boolean = False;
                                  blnEhDefinicaoDeLotesPickingCheckOut : Boolean = False;
                                  strIdePro                            : String = '';
                                  blnCodIteNoWhere                     : Boolean = True): String; static;

      class function fGetSqlWhereLotes : String;

      class function fGetSqlLocFis: String;

      constructor CreateInstance(AOwner                   : TComponent;
                                 strNumPed,
                                 strEmpPed,
                                 strAutIncTinta           : String;
                                 blnUsaWMSRastreavelTinta : Boolean;
                                 strCodIte,
                                 strCodLseItens           : String;
                                 strOndaDeSeparacao       : String = '';
                                 strCodCli                : String = '';
                                 blnEhDefinicaoDeLotesPickingCheckOut : Boolean = False;
                                 blnModoSemMensagens      : Boolean = False;
                                 stlMensagens             : TStringList = nil;
                                 blnComTransacao          : Boolean = True); overload;

      constructor CreateInstance(AOwner: TComponent; strCodLot, strCodEmp: String; blnUsaWMSRastreavelTinta: Boolean; blnSomenteSemLotes: Boolean = False); overload;

      destructor Destroy; override;

      property pgbProgresso : TcxProgressBar    Read FProgresso Write FProgresso;
      property lblInformacao: TLabel            Read FLabelInf  write FLabelInf;
      property blnExpedicao : Boolean           Read FExpedicao Write FExpedicao;
      property Lotes        : TUniClientDataSet Read FLotes     Write FLotes;
      property blnAtualizaPedCortado: Boolean   Read FAtualizaPedCortado Write FAtualizaPedCortado;

      property ItensRemessa : TItensRemessa     Read FItensRemessa;

    end;

implementation

Uses
  untFuncoesSimples, untFatDigitaLotesWMS, untGravando,
  untITintasDeMaquina, untZClient, untTransfArmazens, untTransferenciaArmazens,
  untFuncoes, untFuncTinta, untTMatrizSaldosColorantes, untTipoTinta,
  untDigOperador, untLiberacao, untMsgLiberacao, untIFatReservaSaldo, untTFatReservaSaldo,
  untItensNaoAtendidosSeparacaoWMS, untConstantes, untTPickingCheckOut,
  untSQLItensPedido, untFuncoesWMS, untAuditoriaGravacaoSaldo,
  Shared.Functions.DataSet, Faturamento.Connections.Functions;

Const
  FEspPed: String = 'PD';

{ TDefineLotesWMS }

constructor TDefineLotesWMS.CreateInstance(AOwner                   : TComponent;
                                           strNumPed,
                                           strEmpPed,
                                           strAutIncTinta           : String;
                                           blnUsaWMSRastreavelTinta : Boolean;
                                           strCodIte,
                                           strCodLseItens           : String;
                                           strOndaDeSeparacao       : String = '';
                                           strCodCli                : String = '';
                                           blnEhDefinicaoDeLotesPickingCheckOut : Boolean = False;
                                           blnModoSemMensagens      : Boolean = False;
                                           stlMensagens             : TStringList = nil;
                                           blnComTransacao          : Boolean = True);
begin
  inherited Create(AOwner);
  FTemDig := False;
  FRecalcularQtdeItens := True;
  FNumPed                := strNumPed;
  FEmpPed                := strEmpPed;
  FLotes                 := Nil;
  FcdsSaldoEPonRepPorLoc := Nil;
  FCadLot                := TCadLot.Create(Self);
  FAutIncTinta           := strAutIncTinta;
  FUsaWMSRastreavelTinta := blnUsaWMSRastreavelTinta;
  FCodIte := strCodIte;
  FCodCli := strCodCli;

  FCodLseItens := '';
  If Not fCfgSis('LSEWMS', varBoolean) Then
    FCodLseItens := strCodLseItens;

  arrLseWms := TObjectDictionary<String, TRecLseWms>.Create;

  FLotSep := False;
  FOndaDeSeparacao := strOndaDeSeparacao;
  FEhDefinicaoDeLotesPickingCheckOut := blnEhDefinicaoDeLotesPickingCheckOut;
  FModoSemMensagens := blnModoSemMensagens;

  FMensagens    := stlMensagens;
  FComTransacao := blnComTransacao;

  SetLength(FItensDiverg, 0);

  SetLength(FItensRemessa, 0);

end;

constructor TDefineLotesWMS.CreateInstance(AOwner: TComponent; strCodLot,
  strCodEmp: String; blnUsaWMSRastreavelTinta: Boolean; blnSomenteSemLotes: Boolean = False);
begin
  CreateInstance(AOwner, '', '', '', blnUsaWMSRastreavelTinta, '', '');

  FCodLot := strCodLot;
  FCodEmp := strCodEmp;
  FLotSep := True;
  FblnSomenteSemLotes := blnSomenteSemLotes;
end;

Destructor TDefineLotesWMS.Destroy;
Begin
  If Assigned(FLotes) Then
  Begin
    FLotes.EmptyDataSet;
    FreeAndNil(FLotes);
  End;

  If Assigned(FcdsSaldoEPonRepPorLoc) Then
  Begin
    FcdsSaldoEPonRepPorLoc.EmptyDataSet;
    FreeAndNil(FcdsSaldoEPonRepPorLoc);
  End;

  If Assigned(arrLseWms) Then
    FreeAndNil(arrLseWms);

  inherited;
End;

procedure TDefineLotesWMS.pCriaLotesItens(Var cdsLote: TUniClientDataSet);
begin
  cdsLote := TUniClientDataSet.Create(Nil);

  With cdsLote, FieldDefs Do
  Begin
    AggregatesActive := True;

    With AddFieldDef Do Begin Name := 'AUTINC'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'NUMLOT'; DataType := ftString; Required := False; Size := 30; End;
    With AddFieldDef Do Begin Name := 'LOTORI'; DataType := ftString; Required := False; Size := 30; End;
    With AddFieldDef Do Begin Name := 'LOTDES'; DataType := ftString; Required := False; Size := 30; End;
    With AddFieldDef Do Begin Name := 'DESLOC'; DataType := ftString; Required := False; Size := 100; End;
    With AddFieldDef Do Begin Name := 'LOCFIS'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'PICKIN'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'TRANSI'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'BALCAO'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'PRILAB'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'PRITIN'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'DTAVAL'; DataType := ftDate;   Required := False; End;

    With AddFieldDef Do Begin Name := 'SALDOS'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'SALRES'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'SALDIS'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'QTDITE'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'TOTDIG'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'ORIGEM'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'BROKER'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODSEP'; DataType := ftString; Required := False; End; //utilizado qndo CFG_LSEWMS = S
    With AddFieldDef Do Begin Name := 'CODLSE'; DataType := ftString; Required := False; End; //utilizado qndo CFG_LSEWMS = S
    With AddFieldDef Do Begin Name := 'RASTRE'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'QTDREP'; DataType := ftFloat;  Required := False; End;

    With AddFieldDef Do Begin Name := 'MOVENT'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'MOVSAI'; DataType := ftFloat;  Required := False; End;

    With AddFieldDef Do Begin Name := 'PRIORI'; DataType := ftString; Required := False; Size := 4; End;
    With AddFieldDef Do Begin Name := 'CODACA'; DataType := ftString; Required := False; End;

    With TAggregateField.Create(cdsLote) Do
    Begin
      FieldName := 'AGG_TOTQTD';
      DataSet := cdsLote;
      Expression := 'SUM(QTDITE)';
      Active := True;
    End;

    CreateDataSet;
    Open;

    TFloatField(FieldByName('QTDITE')).DisplayFormat := fMskDigitos(3);
    TFloatField(FieldByName('SALDOS')).DisplayFormat := fMskDigitos(3);
    TFloatField(FieldByName('SALRES')).DisplayFormat := fMskDigitos(3);
    TFloatField(FieldByName('SALDIS')).DisplayFormat := fMskDigitos(3);
    TFloatField(FieldByName('TOTDIG')).DisplayFormat := fMskDigitos(3);

    TStringField(FieldByName('PICKIN')).Alignment    := taCenter;
    TDateTimeField(FieldByName('DTAVAL')).Alignment  := taCenter;

    If fCfgSis('BFSGIS', varBoolean) Then
      IndexFieldNames := 'AUTINC;CODITE;PICKIN;NUMLOT'
    Else
      IndexFieldNames := 'AUTINC;CODITE;NUMLOT';
  End;
end;

Procedure TDefineLotesWMS.pCriaSaldoEPonRepPorLoc(Var cdsSaldoEPonRepPorLoc: TUniClientDataSet);
begin
  If fCfgSis('WMSMOV', varBoolean) And fCfgSis('COLVAL', varBoolean) Then
  Begin
    If Assigned(cdsSaldoEPonRepPorLoc) Then
    Begin
      cdsSaldoEPonRepPorLoc.EmptyDataSet;
    End
    Else
    Begin
      cdsSaldoEPonRepPorLoc := TUniClientDataSet.Create(Self);

      With cdsSaldoEPonRepPorLoc, FieldDefs Do
      Begin
        With AddFieldDef Do Begin Name := 'LOCFIS'; DataType := ftString; Required := False; End;
        With AddFieldDef Do Begin Name := 'SALDIS'; DataType := ftFloat;  Required := False; End;
        With AddFieldDef Do Begin Name := 'QTDREP'; DataType := ftFloat;  Required := False; End;

        CreateDataSet;
        LogChanges := False;
        Open;
      End;
    End;
  End;
end;

procedure TDefineLotesWMS.pMontaMensagemItensQtdeDivergente;
const
  SQL = 'SELECT GROUP_CONCAT(DISTINCT CONCAT(''"'',FGO_SEQSEP,''"'')) SEQSEP ' +
        'FROM EXTGOR E ' +
        'INNER JOIN FATDOR F ON E.FGO_SEQFGO = F.FDO_SEQGER ' +
        'WHERE FGO_SEQOND = :SEQOND ' +
        '  AND FDO_CODITE = :CODITE ' +
        'GROUP BY FDO_CODITE ' +
        'ORDER BY FGO_SEQSEP ';
var
  LItem: TItemDiverg;
  LDesIte: String;
  LQry: TUniQuery;

  ItemRemessa : TItemRemessa;

begin

  If Not fTravaSaldoDisponivelGeracaoRemessaPedido Then
    Exit;

  if (Length(FItensDiverg) <= 0) then
    Exit;

  pArmazenaMensagem('Não foi possível gerar LOTDOR - Não existe saldo disponível ' +
                    'em nenhuma localização física para os produtos abaixo:');

  pArmazenaMensagem('');

  LQry := fCriaQuery;

  try
    LQry.SQL.Text := SQL;

    for LItem in FItensDiverg do
    begin
      LDesIte := fRetNomProduto(LItem.strCodIte);

      pArmazenaMensagem('   ' + LItem.strCodIte + ' - ' + LDesIte +
        ' - qtde necessária: '+ FormatFloat(fMskDigitos(FCadLot.intDecQtd), LItem.fltQtdIte) +
        ' - qtde disponível: '+ FormatFloat(fMskDigitos(FCadLot.intDecQtd), LItem.fltSalDis));

      if (not fEmptyStr(LItem.strLotTin)) then
      begin
        pArmazenaMensagem('     Lotes com saldo marcado(s) como "Principal para Tintas": ');
        pArmazenaMensagem(LItem.strLotTin);
      end;

      LQry.Close;
      LQry.ParamByName('SEQOND').AsString := FOndaDeSeparacao;
      LQry.ParamByName('CODITE').AsString := LItem.strCodIte;
      LQry.Open;

      while not LQry.Eof do
      begin
        pArmazenaMensagem('     Remessa(s) de Pedido: ' + LQry.FieldByName('SEQSEP').AsString);

        FillChar(ItemRemessa, SizeOf(ItemRemessa), #0);

        ItemRemessa.CodigoDoItem    := LItem.strCodIte;
        ItemRemessa.CodigoDaRemessa := LQry.FieldByName('SEQSEP').AsString;

        If Not fEmptyStr(ItemRemessa.CodigoDoItem) And
           Not fEmptyStr(ItemRemessa.CodigoDaRemessa) Then
        Begin
          SetLength(FItensRemessa, Length(FItensRemessa)+1);
          FItensRemessa[High(FItensRemessa)] := ItemRemessa;
        End;

        LQry.Next;

      end;

      pArmazenaMensagem('');
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TDefineLotesWMS.pMostraMensagem(strMensagem: String);
begin
  if FModoSemMensagens then
    pArmazenaMensagem(strMensagem)
  else
    pMensagemOk(strMensagem);
end;

procedure TDefineLotesWMS.pMovimentacaoProgramadaFinal( blnImprimiuSeparacao : Boolean );
var
  strAutoincremFATGOR : String;
begin
  If fCfgSis('WMSMOV', varBoolean) Then
  begin
    strAutoincremFATGOR := fCampoTabela('AUTOINCREM', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [FNumPed, FEspPed, FEmpPed]);
    RealizarMovimentacaoProgramadaPedido(strAutoincremFATGOR, blnImprimiuSeparacao, FExpedicao);
  end;
end;

Procedure TDefineLotesWMS.pInsereLote(qryLotIte, qryCadLoc: TUniQuery; strAutDet, strLotOri, strOrigem: String; fltQtdOri: Double; blnInserir: Boolean);
  Var
    objDadosLoc: IMyCampoTabela;
Begin
  With FLotes Do
  Begin
    If blnInserir Then
    Begin
      Insert;

      FieldByName('PRIORI').AsString := '9999';
      FieldByName('QTDITE').AsFloat  := 0;
      FieldByName('TOTDIG').AsFloat  := 0;

      If fEmptyStr(strLotOri) Then
        FieldByName('LOTORI').AsString := 'A DEFINIR'
      Else
      Begin
        FieldByName('LOTORI').AsString := strLotOri;

        If qryLotIte.FieldByName('LOT_NUMLOT').AsString = strLotOri Then
        Begin
          If (fEmptyStr(FAutIncTinta) Or (Not FUsaWMSRastreavelTinta)) Then
          Begin
            FieldByName('QTDITE').AsFloat  := fltQtdOri;
            FieldByName('TOTDIG').AsFloat  := fltQtdOri;
          End;
        End;
      End;

    End
    Else
    Begin
      Edit;
    End;

    qryCadLoc.Close;
    qryCadLoc.ParamByName('CODLOC').AsString := qryLotIte.FieldByName('LOT_LOCFIS').AsString;
    qryCadLoc.ParamByName('CODEMP').AsString := VS_strCodEmp;

    objDadosLoc := ExecutarQueryEmCache(qryCadLoc);

    FieldByName('AUTINC').AsString   := strAutDet;
    FieldByName('CODITE').AsString   := qryLotIte.FieldByName('LOT_CODITE').AsString;
    FieldByName('NUMLOT').AsString   := qryLotIte.FieldByName('LOT_NUMLOT').AsString;
    FieldByName('LOTDES').AsString   := qryLotIte.FieldByName('LOT_NUMLOT').AsString;
    FieldByName('LOCFIS').AsString   := qryLotIte.FieldByName('LOT_LOCFIS').AsString;

    If fCfgSis('CADLOC', varBoolean) Then
      FieldByName('DESLOC').AsString := objDadosLoc.FieldByName('LOC_DESCRI').AsString
    Else
      FieldByName('DESLOC').AsString := '';

    FieldByName('PICKIN').AsString   := IIF(objDadosLoc.FieldByName('LOC_PICKIN').AsString = 'S', 'SIM', '');
    FieldByName('TRANSI').AsString   := IIF(objDadosLoc.FieldByName('LOC_TRANSI').AsString = 'S', 'SIM', '');
    FieldByName('BALCAO').AsString   := IIF(objDadosLoc.FieldByName('LOC_BALCAO').AsString = 'S', 'SIM', '');
    FieldByName('PRILAB').AsString   := IIF(objDadosLoc.FieldByName('LOC_PRILAB').AsString = 'S', 'SIM', '');
    FieldByName('PRITIN').AsString   := qryLotIte.FieldByName('LOT_PRITIN').AsString;

    If qryLotIte.FieldByName('LOT_DTAVAL').IsNull Then
      FieldByName('DTAVAL').Value := Null
    Else
      FieldByName('DTAVAL').AsDateTime := qryLotIte.FieldByName('LOT_DTAVAL').AsDateTime;

    FieldByName('ORIGEM').AsString   := strOrigem;
    FieldByName('BROKER').AsString   := IIF(qryLotIte.FieldByName('LOT_BROKER').AsString='S', 'S', 'N');
    FieldByName('RASTRE').AsString   := qryLotIte.FieldByName('ITE_RASTRE').AsString;
    FieldByName('QTDREP').AsFloat    := qryLotIte.FieldByName('LCI_QTDREP').AsFloat;
    Post;

  End;

End;

class function TDefineLotesWMS.fGetSqlLocFis: String;
begin
  Result := '';
  Result := Result + 'SELECT LOC_DESCRI, ';
  Result := Result + '       LOC_PICKIN, ';
  Result := Result + '       LOC_TRANSI, ';
  Result := Result + '       LOC_BALCAO, ';
  Result := Result + '       IF(LOC_PICKIN = "S" AND LOC_PRILAB = "S", "S", "N") AS LOC_PRILAB ';
  Result := Result + 'FROM CADLOC ';
  Result := Result + 'WHERE LOC_CODLOC = :CODLOC ';
  Result := Result + '  AND LOC_CODEMP = :CODEMP ';
end;

Class function TDefineLotesWMS.fGetSqlLotes(blnMostrarLoteNaoPicking             : Boolean = False;
                                            blnExpedicao                         : Boolean = False;
                                            blnEhDefinicaoDeLotesPickingCheckOut : Boolean = False;
                                            strIdePro                            : String = '';
                                            blnCodIteNoWhere                     : Boolean = True) : String;
  const
    PICKING_CHECKOUT = ' OR (IFNULL(LOC_PICKIN, "N") = "C") ';
Begin
  Result := '';
  Result := Result + ' SELECT CADLOT.*, CADLOC.*, ';
  Result := Result + '        CADLOT.AUTOINCREM AS LOTINC, ';
  Result := Result + '        ITE_RASTRE, LCI_QTDREP ';
  Result := Result + '   FROM CADLOT ';
  Result := Result + '  INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS ';
  Result := Result + '                   AND LOT_CODEMP = LOC_CODEMP ';
  Result := Result + '  INNER JOIN CADITE ON ITE_CODITE = LOT_CODITE ';
  Result := Result + '   LEFT JOIN LOCITE ON LCI_CODEMP = LOT_CODEMP ';
  Result := Result + '                   AND LCI_CODITE = LOT_CODITE ';
  Result := Result + '                   AND LCI_LOCFIS = CADLOC.AUTOINCREM ';
  Result := Result +   'WHERE LOT_NUMLOT <> "A DEFINIR"     ';
  Result := Result +   '  AND LOT_NUMLOT <> "A REGULARIZAR" ';

  If blnCodIteNoWhere Then
    Result := Result +   '  AND LOT_CODITE = :CODITE ';

  Result := Result +   '  AND LOT_CODEMP = :CODEMP          ';
  Result := Result +   '  AND LOT_BROKER = :BROKER          ';
  Result := Result +   '  AND IFNULL(LOC_CRITIC,"N") = "N"  ';
  Result := Result +   '  AND IFNULL(LOC_BALCAO,"N") = "N"  ';
  Result := Result +   '  AND IFNULL(LOT_TRANSI,"N") = "N"  ';

  //Se não tiver acesso para ver os Buffers, poderá somente visualizar os Pickins, independente das configurações.
  If (blnExpedicao) And (Not fVerificaAcessoSistema('WMSBUF')) Then
  Begin
    Result := Result + '  AND ((IFNULL(LOC_PICKIN,"N") = "S") OR (IFNULL(LOC_TRANSI,"N") = "S")  ) ';
  End
  Else
  Begin
    If fCfgSis('WMSPIC', varBoolean) Then
      If (not blnMostrarLoteNaoPicking) Then
        Result := Result + '  AND ((IFNULL(LOC_PICKIN,"N") = "S") OR (IFNULL(LOC_TRANSI,"N") = "S")  ) ';
  End;

  If fUsaRotinaWMS Then
  Begin

    Result := Result + '  AND (IFNULL(LOC_PICKIN,"N") <> "E") ';

    If (blnExpedicao And TPickingCheckOut.fWMSUtilizaPickingCheckOut) Then
      Result := Result + '  AND (IFNULL(LOC_PICKIN,"N") <> "C") ';

  End;

  Result := Result + '  AND ((LOT_SALDOS > 0) OR (IFNULL(LOC_PICKIN,"N") = "S") ' + IIF(blnEhDefinicaoDeLotesPickingCheckOut, PICKING_CHECKOUT, '') + ') ';

  If fUsaPickingLaboratorioWms Then
  Begin
    If fEhTintaImobiliaria(strIdePro) Then
      Result := Result + '  AND ' + fRetWherePicLab
    Else
      Result := Result + '  AND (IFNULL(LOC_PRILAB,"N") = "N") ';
  End;

  //Lote que tem Movimentação programada NA QUANTIDADE TOTAL (MLT_QTDMOV = 0) nao pode ser selecionada para atender um pedido
  Result := Result + '   AND ((SELECT COUNT(0) FROM MOVLOT   ';
  Result := Result + '        WHERE MLT_CODEMP = LOT_CODEMP  ';
  Result := Result + '          AND MLT_CODITE = LOT_CODITE  ';
  Result := Result + '          AND MLT_LOTORI = LOT_NUMLOT  ';
  Result := Result + '          AND MLT_QTDMOV = 0           ';
  Result := Result + '          AND MLT_DTAREA IS NULL) = 0) ';
End;

function TDefineLotesWMS.fGetSqlProdutosAcabado: String;
begin
  Result := 'SELECT '
          + '       A.* '
          + '     , D.FDO_CODITE '
          + '     , D.FDO_QTDITE '
          + '  FROM ACAGER A '
          + ' INNER JOIN FATDOR D '
          + '   ON D.FDO_CODACA = A.ACA_CODACA '
          + '  AND IFNULL(D.FDO_EMPACA, D.FDO_EMPITE) = A.ACA_CODEMP '
          + ' INNER JOIN FATGOR G ON G.AUTOINCREM = D.FDO_SEQGER '
          + ' WHERE D.FDO_PROACA = "S" '
          + '   AND D.FDO_CODITE = :CODITE '
          + '   AND A.ACA_EMPEST = :CODEMP '
          + '   AND G.FGO_NUMDOC = :NUMDOC '
          + '   AND G.FGO_ESPDOC = :ESPDOC '
          + '   AND G.FGO_CODEMP = :CODEMP '
          + '   AND D.AUTOINCREM = :AUTINC ';
end;

class function TDefineLotesWMS.fGetSqlWhereLotes: String;
begin
  Result := '  AND IFNULL(LOT_STATUS,"S") = "S"  ' +
            '  AND IFNULL(LOT_LOTAPR,"S") = "S"  ' +
            '  AND IFNULL(LOT_DIGCON,"N") = "N"  ' +
            '  AND IFNULL(LOT_GARPRI,"N") = "N"  ';
end;

function TDefineLotesWMS.fItemTemLocalizacaoMapeada(strCodIte: String): Boolean;
var
  qryFatDor : TUniQuery;
begin
  qryFatDor := fCriaQuery;
  try
    qryFatDor.Close;
    qryFatDor.SQL.Clear;

    qryFatDor.SQL.Add(' SELECT COUNT(*) AS QTD FROM LOCITE        ');
    qryFatDor.SQL.Add(' WHERE LCI_CODEMP = :EMPEST  ');
    qryFatDor.SQL.Add('   AND LCI_CODITE = :CODITE  ');

    qryFatDor.ParamByName('EMPEST').AsString := VS_strCodEmp;
    qryFatDor.ParamByName('CODITE').AsString := strCodIte;

    qryFatDor.Open;

    Result := qryFatDor.FieldByName('QTD').AsInteger > 0;

    qryFatDor.Close;
  finally
    FreeAndNil(qryFatDor);
  end;
End;

function TDefineLotesWMS.fItemTemLocalizacaoMapeadaAtiva(strCodIte: String;
  out strLocFis: String; blnPicking: Boolean = False): Boolean;
  Var
    qryLocIte: TUniQuery;
begin
  qryLocIte := fCriaQuery;
  try
    qryLocIte.SQL.Add(' SELECT LOC_CODLOC FROM LOCITE ');
    qryLocIte.SQL.Add(' INNER JOIN CADLOC ON CADLOC.AUTOINCREM = LCI_LOCFIS ');
    qryLocIte.SQL.Add(' WHERE LCI_CODEMP = :EMPEST ');
    qryLocIte.SQL.Add('   AND LCI_CODITE = :CODITE ');
    qryLocIte.SQL.Add('   AND LCI_QTDREP > 0       ');
    qryLocIte.SQL.Add('   AND LCI_QTDMAX > 0       ');
    qryLocIte.SQL.Add('   AND LOC_ATIVO_ = "S"     ');

    if blnPicking then
      qryLocIte.SQL.Add(' AND IFNULL(LOC_PICKIN,"N") = "S" ');

    qryLocIte.ParamByName('EMPEST').AsString := VS_strCodEmp;
    qryLocIte.ParamByName('CODITE').AsString := strCodIte;
    qryLocIte.Open;

    Result := not qryLocIte.IsEmpty;

    strLocFis := qryLocIte.FieldByName('LOC_CODLOC').AsString;
  finally
    FreeAndNil(qryLocIte);
  end;
end;

procedure TDefineLotesWMS.pArmazenaMensagem(strMensagem: String);
begin
  if (not Assigned(FMensagens)) then
    Exit;

  FMensagens.Add(strMensagem);
end;

procedure TDefineLotesWMS.pAtualizaLocalizaoFisica(
  const cdsItePed: TUniClientDataSet);
var
  qryAcaGer: TUniQuery;
Begin
  qryAcaGer := fCriaQuery;

  Try
    qryAcaGer.SQL.Text := fGetSqlProdutosAcabado;
    qryAcaGer.ParamByName('CODITE').AsString := cdsItePed.FieldByName('FDO_CODITE').AsString;
    qryAcaGer.ParamByName('NUMDOC').AsString := cdsItePed.FieldByName('FDO_NUMDOC').AsString;
    qryAcaGer.ParamByName('ESPDOC').AsString := cdsItePed.FieldByName('FDO_ESPDOC').AsString;
    qryAcaGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAcaGer.ParamByName('AUTINC').AsString := cdsItePed.FieldByName('AUTOINCREM').AsString;
    qryAcaGer.Open;

    While Not qryAcaGer.Eof Do
    Begin
      pRegistraProgresso('Aguarde, Carregando localização dos ' +
        'produtos acabados... ', qryAcaGer.RecNo, qryAcaGer.RecordCount);

      FLotes.Append;
      FLotes.FieldByName('CODACA').AsString   := qryAcaGer.FieldByName('ACA_CODACA').AsString;
      FLotes.FieldByName('AUTINC').AsString   := cdsItePed.FieldByName('AUTOINCREM').AsString;
      FLotes.FieldByName('CODITE').AsString   := qryAcaGer.FieldByName('FDO_CODITE').AsString;
      FLotes.FieldByName('PRIORI').AsString   := '9999';
      FLotes.FieldByName('LOTORI').AsString   := 'A DEFINIR';
      FLotes.FieldByName('QTDITE').AsFloat    := qryAcaGer.FieldByName('FDO_QTDITE').AsFloat;
      FLotes.FieldByName('TOTDIG').AsFloat    := qryAcaGer.FieldByName('ACA_SALDOS').AsFloat;
      FLotes.FieldByName('LOCFIS').AsString   := qryAcaGer.FieldByName('ACA_LOCFIS').AsString;
      FLotes.FieldByName('DESLOC').AsString   := EmptyStr;
      FLotes.FieldByName('PICKIN').AsString   := IIF(fEhLocalizacaoFisicaPicking(qryAcaGer.FieldByName('ACA_LOCFIS').AsString), 'SIM', '');
      FLotes.FieldByName('TRANSI').AsString   := IIF(fEhLocalizacaoFisicaTransitoria(qryAcaGer.FieldByName('ACA_LOCFIS').AsString), 'SIM', '');
      FLotes.FieldByName('BALCAO').AsString   := IIF(fEhLocalizacaoFisicaBalcao(qryAcaGer.FieldByName('ACA_LOCFIS').AsString), 'SIM', '');
      FLotes.FieldByName('PRILAB').AsString   := IIF(fEhLocalizacaoFisicaPickingLaboratorio(qryAcaGer.FieldByName('ACA_LOCFIS').AsString), 'SIM', '');
      FLotes.FieldByName('SALDOS').AsFloat    := qryAcaGer.FieldByName('ACA_SALDOS').AsFloat;
      FLotes.FieldByName('SALDIS').AsFloat    := qryAcaGer.FieldByName('ACA_SALDOS').AsFloat;
      FLotes.Post;

      qryAcaGer.Next;
    End;
  Finally
    FreeAndNil(qryAcaGer);
  End;
end;

procedure TDefineLotesWMS.pAtualizaLocalizaoFisicaProdutoAcabado(
  const strCodAca, strCodLoc: String);
var
  qryDados: TUniQuery;
begin
  qryDados := fCriaQuery;
  Try
    qryDados.SQL.Text := 'UPDATE ACAGER '
                       + '   SET ACA_LOCFIS = :CODLOC '
                       + ' WHERE ACA_CODACA = :CODACA '
                       + '   AND ACA_EMPEST = :CODEMP ';

    qryDados.ParamByName('CODACA').AsString := strCodAca;
    qryDados.ParamByName('CODLOC').AsString := strCodLoc;
    qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDados.ExecSQL;
  Finally
    FreeAndNil(qryDados);
  End;
end;

Procedure TDefineLotesWMS.pAtualizaLoteItem(strCodIte,
                                            strAutDet,
                                            strLotOri,
                                            strOrigem : String;
                                            fltQtdOri : Double;
                                            blnMostrarLoteNaoPicking : Boolean = False;
                                            strCodBar : String = '';
                                            strIdePro : String = '');
  Var
    qryLotIte: TUniQuery;
    qryCadLoc: TUniQuery;

    function fItemDoPedidoEhRetiraCaixa : Boolean;
    begin
      Result := FEhDefinicaoDeLotesPickingCheckOut And TPickingCheckOut.fItemDoPedidoEhRetiraCaixa(strAutDet);
    end;

    procedure pCriaOuAtivaLotePicking;
      const
        LOT_STATUS_ATIVO   = 'AND IFNULL(LOT_STATUS,"S") = "S"';
        LOT_STATUS_INATIVO = 'AND IFNULL(LOT_STATUS,"S") = "N"';
      var
        strLocFis: String;
        strNumLot: String;
        intCntLot: Integer;
    begin
      qryLotIte.Close;
      qryLotIte.SQL.Text := ReplaceStr(qryLotIte.SQL.Text, LOT_STATUS_ATIVO, LOT_STATUS_INATIVO);
      qryLotIte.SQL.Add(' AND LOC_ATIVO_ = "S" AND IFNULL(LOC_PICKIN,"N") = "S" AND LCI_QTDREP > 0 AND LCI_QTDMAX > 0 ');
      qryLotIte.Open;

      If qryLotIte.IsEmpty Then
      Begin
        strLocFis := '';
        If fItemTemLocalizacaoMapeadaAtiva(strCodIte, strLocFis, True) Then
        Begin
          intCntLot := 1;
          strNumLot := 'PICKING';

          //busca um número de lote ainda não cadastrado
          While FCadLot.fExisteLote(strCodIte, VS_strCodEmp, strNumLot, False, False) Do
          Begin
            Inc(intCntLot);
            strNumLot := 'PICKING/'+ intCntLot.ToString;
          End;

          //cadastra um novo lote ativo na localização picking mapeada
          FCadLot.GeraLoteAtivo(strCodIte, strNumLot, strLocFis);

          qryLotIte.Close;
          qryLotIte.SQL.Text := ReplaceStr(qryLotIte.SQL.Text, LOT_STATUS_INATIVO, LOT_STATUS_ATIVO);
          qryLotIte.Open;
        End;
      End
      Else
      Begin
        //ativa o lote que está inativo na localização picking mapeada
        FCadLot.fAtivarLote(qryLotIte.FieldByName('LOTINC').AsString);
      End;
    end;

Begin
  qryLotIte := fCriaQuery;
  qryCadLoc := fCriaQuery;

  qryCadLoc.SQL.Text := TDefineLotesWMS.fGetSqlLocFis;

  With qryLotIte, SQL Do
  Begin
    Clear;

    Add(TDefineLotesWMS.fGetSqlLotes(blnMostrarLoteNaoPicking, FExpedicao, fItemDoPedidoEhRetiraCaixa, strIdePro));
    Add(TDefineLotesWMS.fGetSqlWhereLotes);

    If (fEhTintaAutomotiva(strIdePro)) Then
      Add('  AND IFNULL(LOT_PRITIN,"N") = "S"  ');

    If (Not fEmptyStr(strCodBar)) And fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis Then
    Begin
      Add('  AND LOT_CODBAR = :CODBAR  ');
      Add('  ORDER BY LOT_SALDOS  ');
      ParamByName('CODBAR').AsString := strCodBar;
    End;

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('BROKER').AsString := IIF(strOrigem = 'AKZO NOBEL', 'S', 'N');

    Open;

    If IsEmpty And fCfgSis('WMSMOV', varBoolean) Then
    Begin
      pCriaOuAtivaLotePicking;
    End;

    First;
    While Not Eof Do
    Begin

      If Not FLotes.Locate('CODITE;NUMLOT;AUTINC',
        VarArrayOf([strCodIte, FieldByName('LOT_NUMLOT').AsString, strAutDet]), []) Then
      Begin
        pInsereLote(qryLotIte, qryCadLoc, strAutDet, strLotOri, strOrigem, fltQtdOri, True);
      End Else
      Begin
        pInsereLote(qryLotIte, qryCadLoc, strAutDet, strLotOri, strOrigem, fltQtdOri, False);
      End;

      Next;
    End;
  End;

  FreeAndNil(qryLotIte);
  FreeAndNil(qryCadLoc);
End;

procedure TDefineLotesWMS.pAtualizaLoteItemOndaDeSeparacao(strCodIte : String; fltQtdOri: Double);
Var
  qryLotIte: TUniQuery;
  qryOndaPD: TUniQuery;
  qryCadLoc: TUniQuery;

  strOrigem: String;
  strLotOri: String;

  blnUsaPedidoBroker : Boolean;

Begin

  qryOndaPD := fCriaQuery;
  qryLotIte := fCriaQuery;
  qryCadLoc := fCriaQuery;

  blnUsaPedidoBroker := fUsaRotinaWMS(VS_strCodEmp) And (Not fEmptyStr(fCfgSis('AKZCLI', varString)));

  Try

    qryCadLoc.SQL.Text := TDefineLotesWMS.fGetSqlLocFis;

    qryOndaPD.SQL.Clear;
    qryOndaPD.SQL.Add(fGetSqlItensOndaDeSeparacao(True, strCodIte));
    qryOndaPD.Open;

    qryOndaPD.First;
    While Not qryOndaPD.Eof Do
    Begin

      strOrigem := IIF(blnUsaPedidoBroker, qryOndaPD.FieldByName('FGO_ORIGEM').AsString, '');
      strLotOri := qryOndaPD.FieldByName('FDO_NUMLOT').AsString;

      qryLotIte.SQL.Clear;
      qryLotIte.SQL.Add(TDefineLotesWMS.fGetSqlLotes(False, FExpedicao, False, qryOndaPD.FieldByName('FDO_IDEPRO').AsString));
      qryLotIte.SQL.Add('  AND IFNULL(LOT_STATUS,"S") = "S"  ');
      qryLotIte.SQL.Add('  AND IFNULL(LOT_DIGCON,"N") = "N"  ');
      qryLotIte.SQL.Add('  AND IFNULL(LOT_GARPRI,"N") = "N"  ');

      qryLotIte.ParamByName('CODITE').AsString := strCodIte;
      qryLotIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryLotIte.ParamByName('BROKER').AsString := IIF(strOrigem = 'AKZO NOBEL', 'S', 'N');

      qryLotIte.Open;

      While Not qryLotIte.Eof Do
      Begin

        If Not FLotes.Locate('CODITE;NUMLOT', VarArrayOf([strCodIte, qryLotIte.FieldByName('LOT_NUMLOT').AsString]), []) Then
        Begin
          pInsereLote(qryLotIte, qryCadLoc, '', strLotOri, strOrigem, fltQtdOri, True);
        End Else
        Begin
          pInsereLote(qryLotIte, qryCadLoc, '', strLotOri, strOrigem, fltQtdOri, False);
        End;

        qryLotIte.Next;
      End;

      qryOndaPD.Next;

    End;

  Finally

    If Assigned(qryOndaPD) Then
      FreeAndNil(qryOndaPD);

    If Assigned(qryLotIte) Then
      FreeAndNil(qryLotIte);

    If Assigned(qryCadLoc) Then
      FreeAndNil(qryCadLoc);

  End;

End;

(*****************************************************************************)
(* CARREGA NO CLIENT DE Lotes TODOS OS Lotes DOS ITENS DE UM DOCUMENTO       *)
(* DE ENDEREÇAMENTO                                                          *)
(**************************************************************************LA*)
Procedure TDefineLotesWMS.pAtualizaLotes(cdsItePed: TUniClientDataSet; blnReiniciar: Boolean; arrDadosCodBarra: TarrayDadosCodBarra = Nil);
  Var
    intRecNo                  : Integer;
    blnUsaPedidoBroker        : Boolean;
    blnMostrarLoteNaoPicking  : Boolean;
    strCodBar                 : string;
    intIndice                 : integer;
    strIdentificacaoDoProduto : String;
Begin

  blnMostrarLoteNaoPicking := False;

  With cdsItePed Do
  Begin

    blnUsaPedidoBroker := fUsaRotinaWMS(VS_strCodEmp) And (Not fEmptyStr(fCfgSis('AKZCLI', varString)));

    DisableControls;
    intRecNo := RecNo;
    If State = dsEdit Then
      Cancel;

    If Not Assigned(FLotes) Then
    Begin
      pCriaLotesItens(FLotes);
    End;

    If blnReiniciar Then
      FLotes.EmptyDataSet;

    First;
    While Not Eof Do
    Begin

      pRegistraProgresso('Aguarde, Carregando lotes dos ' +
        'produtos... ', RecNo, RecordCount);

      Edit;
      If FCadLot.fExisteLote(FieldByName('FDO_CODITE').AsString, VS_strCodEmp) Then
        FieldByName('TEMLOT').AsInteger := 1
      Else
        FieldByName('TEMLOT').AsInteger := 0;

      strIdentificacaoDoProduto := '';

      If (FindField('FDO_IDEPRO') <> Nil) Then
        strIdentificacaoDoProduto := FieldByName('FDO_IDEPRO').AsString;

      {Mostrar Buffer - CFG_MOSPUL}
      if (fCfgSis('WMSPIC', varBoolean)) and (fCfgSis('MOSPUL', varBoolean)) and (fItemTemLocalizacaoMapeada(FieldByName('FDO_CODITE').AsString)) then
      begin
        if fRetornaSaldoDeCorte(FieldByName('FDO_CODITE').AsString, strIdentificacaoDoProduto) < FieldByName('FDO_QTDITE').AsFloat then
        begin
          blnMostrarLoteNaoPicking := True;
        end;
      end;

      {Mostrar Buffer - Cliente estoque externo}
      If fClienteEstoqueExterno(FCodCli) Then
      Begin
        blnMostrarLoteNaoPicking := (fCfgSis('CLIBUF', varBoolean));
      End;

      //Se não tiver acesso para ver os Buffers, poderá somente visualizar os Pickins, independente das configurações.
      If (FExpedicao) And (Not fVerificaAcessoSistema('WMSBUF')) Then
      Begin
        blnMostrarLoteNaoPicking := False;
      End;

      strCodBar := EmptyStr;
      for intIndice := Low(arrDadosCodBarra) to High(arrDadosCodBarra) do
      begin
        if (arrDadosCodBarra[intIndice].strCodEmp = FieldByName('FDO_CODEMP').AsString) and (arrDadosCodBarra[intIndice].strCodIte = FieldByName('FDO_CODITE').AsString) then
        begin
          strCodBar := arrDadosCodBarra[intIndice].strCodBar;
          Break;
        end;
      end;

      If (FieldByName('FDO_PROACA').AsString = 'S') Then
        pAtualizaLocalizaoFisica(cdsItePed)
      Else
        pAtualizaLoteItem(FieldByName('FDO_CODITE').AsString,
                          FieldByName('AUTOINCREM').AsString,
                          FieldByName('FDO_NUMLOT').AsString,
                          IIF(blnUsaPedidoBroker, FieldByName('FGO_ORIGEM').AsString, ''),
                          FieldByName('FDO_QTDITE').AsFloat,
                          blnMostrarLoteNaoPicking,
                          strCodBar,
                          strIdentificacaoDoProduto);

      Next;
    End;

    //Carrega a quantidade digitada e salva anteriormente (Tabela LOTDOR)
    If blnReiniciar Then
    Begin
      pCarregarQuantidadeDigitadaBD(cdsItePed);
      pAtualizaSaldosLotes;

      If not (cdsItePed.FieldByName('FGO_ORIGEM').AsString = 'AKZO NOBEL') Then
        pSelecionarLotesSugestao(cdsItePed);
    End;

    RecNo := intRecNo;
    EnableControls;
  End;

End;

function TDefineLotesWMS.fRetornaSaldoDeCorte(strCodIte, strIdePro: string): Double;
var
  strCodLoc: string;
begin
  Result := fRetornaSaldosLotePicking(strCodIte, strIdePro);
  Result := Result + fRetornaCapacidadePicking(strCodLoc, strCodIte, strIdePro);
  Result := Result - fRetornaSaldosLotePicking(strCodIte, strIdePro, strCodLoc);
end;

function TDefineLotesWMS.fRetornaSaldoDisponivel(strCodIte, strIdePro: string): Double;
var
  qrySaldos: TUniQuery;
begin
  Result := 0;
  qrySaldos := fCriaQuery;

  try
    qrySaldos.Close;
    qrySaldos.SQL.Clear;
    qrySaldos.SQL.Add('SELECT SUM(LOT_SALDOS) AS SALDOS');
    qrySaldos.SQL.Add('FROM CADLOT');
    qrySaldos.SQL.Add('JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP');
    qrySaldos.SQL.Add('WHERE LOT_CODITE = :CODITE');
    qrySaldos.SQL.Add('  AND LOT_CODEMP = :CODEMP');
    qrySaldos.SQL.Add('  AND LOT_STATUS = "S"');
    qrySaldos.SQL.Add('  AND IFNULL(LOT_TRANSI, "N") = "N"');

    //Se não tiver acesso para ver os Buffers, poderá somente visualizar os Pickins, independente das configurações.
    if (FExpedicao) And (not fVerificaAcessoSistema('WMSBUF')) then
    begin
      qrySaldos.SQL.Add('AND LOC_PICKIN = "S"');
    end
    else
    begin
      if (fCfgSis('WMSPIC', varBoolean)) and (not fCfgSis('MOSPUL', varBoolean)) then
      begin
        qrySaldos.SQL.Add('AND LOC_PICKIN = "S"');
      end;
    end;

    If fUsaRotinaWMS Then
      qrySaldos.SQL.Add('AND IFNULL(LOC_PICKIN,"N") <> "E"');

    If fUsaPickingLaboratorioWms Then
    Begin
      If fEhTintaImobiliaria(strIdePro) Then
        qrySaldos.SQL.Add('AND IFNULL(LOC_PRILAB,"N") = "S"')
      Else
        qrySaldos.SQL.Add('AND IFNULL(LOC_PRILAB,"N") = "N"');
    End;

    qrySaldos.ParamByName('CODITE').AsString := strCodIte;
    qrySaldos.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qrySaldos.Open;

    if not qrySaldos.IsEmpty then
    begin
      Result := qrySaldos.FieldByName('SALDOS').AsFloat;
    end;
  finally
    FreeAndNil(qrySaldos);
  end;
end;

function TDefineLotesWMS.fRetornaSaldoReservadoEnderecamento(
  strCodIte: string): Double;
var
  qrySaldo: TUniQuery;
begin
  Result := 0;
  qrySaldo := fCriaQuery;

  try
    qrySaldo.Close;
    qrySaldo.SQL.Clear;
    qrySaldo.SQL.Add('SELECT ITE_QTPD_E');
    qrySaldo.SQL.Add('FROM ITEGER');
    qrySaldo.SQL.Add('WHERE ITE_CODEMP = :CODEMP');
    qrySaldo.SQL.Add('AND ITE_CODITE = :CODITE');

    qrySaldo.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qrySaldo.ParamByName('CODITE').AsString := strCodIte;

    qrySaldo.Open;

    if not qrySaldo.IsEmpty then
    begin
      Result := qrySaldo.FieldByName('ITE_QTPD_E').AsFloat;
    end;
  finally
    FreeAndNil(qrySaldo);
  end;
end;

function TDefineLotesWMS.fRetornaSaldosLotePicking(strCodIte, strIdePro,
  strCodLoc: string): Double;
var
  qrySaldos: TUniQuery;
begin
  Result := 0;
  qrySaldos := fCriaQuery;

  try
    qrySaldos.Close;
    qrySaldos.SQL.Clear;
    qrySaldos.SQL.Add('SELECT ');
    qrySaldos.SQL.Add('  SUM(LOT_SALDOS) AS SALDOS');
    qrySaldos.SQL.Add('FROM');
    qrySaldos.SQL.Add('  CADLOT');
    qrySaldos.SQL.Add('  INNER JOIN CADLOC');
    qrySaldos.SQL.Add('    ON LOC_CODLOC = LOT_LOCFIS');
    qrySaldos.SQL.Add('    AND LOT_CODEMP = LOC_CODEMP');
    qrySaldos.SQL.Add('  INNER JOIN CADITE');
    qrySaldos.SQL.Add('    ON ITE_CODITE = LOT_CODITE');
    qrySaldos.SQL.Add('  LEFT JOIN LOCITE');
    qrySaldos.SQL.Add('    ON LCI_CODEMP = LOT_CODEMP');
    qrySaldos.SQL.Add('    AND LCI_CODITE = LOT_CODITE');
    qrySaldos.SQL.Add('    AND LCI_LOCFIS = CADLOC.AUTOINCREM');
    qrySaldos.SQL.Add('WHERE LOT_NUMLOT <> "A DEFINIR"');
    qrySaldos.SQL.Add('  AND LOT_NUMLOT <> "A REGULARIZAR"');
    qrySaldos.SQL.Add('  AND LOT_CODITE = :CODITE');
    qrySaldos.SQL.Add('  AND LOT_CODEMP = :CODEMP');
    qrySaldos.SQL.Add('  AND IFNULL(LOC_CRITIC, "N") = "N"');
    qrySaldos.SQL.Add('  AND IFNULL(LOC_BALCAO, "N") = "N"');
    qrySaldos.SQL.Add('  AND IFNULL(LOT_TRANSI, "N") = "N"');

    if not strCodLoc.IsEmpty then
    begin
      qrySaldos.SQL.Add('  AND LOC_CODLOC IN ('+strCodLoc+')');
    end;

    qrySaldos.SQL.Add('  AND (');
    qrySaldos.SQL.Add('    (LOT_SALDOS > 0) ');
    qrySaldos.SQL.Add('    OR (IFNULL(LOC_PICKIN, "N") = "S")');
    qrySaldos.SQL.Add('  ) ');
    qrySaldos.SQL.Add('  AND (');
    qrySaldos.SQL.Add('    (SELECT');
    qrySaldos.SQL.Add('      COUNT(0)');
    qrySaldos.SQL.Add('    FROM');
    qrySaldos.SQL.Add('      MOVLOT');
    qrySaldos.SQL.Add('    WHERE MLT_CODEMP = LOT_CODEMP');
    qrySaldos.SQL.Add('      AND MLT_CODITE = LOT_CODITE');
    qrySaldos.SQL.Add('      AND MLT_LOTORI = LOT_NUMLOT');
    qrySaldos.SQL.Add('      AND MLT_QTDMOV = 0 ');
    qrySaldos.SQL.Add('      AND MLT_DTAREA IS NULL) = 0');
    qrySaldos.SQL.Add('  ) ');
    qrySaldos.SQL.Add('  AND IFNULL(LOT_STATUS, "S") = "S"');
    qrySaldos.SQL.Add('  AND IFNULL(LOT_DIGCON, "N") = "N"');
    qrySaldos.SQL.Add('  AND IFNULL(LOT_GARPRI, "N") = "N"');
    qrySaldos.SQL.Add('  AND ((IFNULL(LOC_PICKIN,"N") = "S") OR (IFNULL(LOC_TRANSI,"N") = "S")  )');

    If fUsaPickingLaboratorioWms Then
    Begin
      If fEhTintaImobiliaria(strIdePro) Then
        qrySaldos.SQL.Add('  AND (IFNULL(LOC_PRILAB,"N") = "S")')
      Else
        qrySaldos.SQL.Add('  AND (IFNULL(LOC_PRILAB,"N") = "N")');
    End;

    qrySaldos.ParamByName('CODITE').AsString := strCodIte;
    qrySaldos.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qrySaldos.Open;

    if not qrySaldos.IsEmpty then
      Result := qrySaldos.FieldByName('SALDOS').AsFloat;
  finally
    FreeAndNil(qrySaldos);
  end;
end;

procedure TDefineLotesWMS.pAtualizaLotesOndaDeSeparacao(cdsItensOnda: TUniClientDataSet; blnReiniciar: Boolean);
Var
  intRecNo : Integer;
Begin

  With cdsItensOnda Do
  Begin

    DisableControls;
    intRecNo := RecNo;
    If State = dsEdit Then
      Cancel;

    If Not Assigned(FLotes) Then
      pCriaLotesItens(FLotes);

    If blnReiniciar Then
      FLotes.EmptyDataSet;

    First;
    While Not Eof Do
    Begin

      pRegistraProgresso('Aguarde, Carregando lotes dos ' + 'produtos... ', RecNo, RecordCount);

      Edit;
      If FCadLot.fExisteLote(FieldByName('FDO_CODITE').AsString, VS_strCodEmp) Then
        FieldByName('TEMLOT').AsInteger := 1
      Else
        FieldByName('TEMLOT').AsInteger := 0;

      If (FieldByName('FDO_PROACA').AsString = 'S') Then
        pAtualizaLocalizaoFisica(cdsItensOnda)
      Else
        pAtualizaLoteItemOndaDeSeparacao(FieldByName('FDO_CODITE').AsString,
                                         FieldByName('FDO_QTDITE').AsFloat);

      Next;
    End;

    //Carrega a quantidade digitada e salva anteriormente (Tabela LOTDOR)
    If blnReiniciar Then
    Begin

      pCarregarQuantidadeDigitadaBDOndaDeSeparacao;
      pAtualizaSaldosLotesOndaDeSeparacao;

      If not (cdsItensOnda.FieldByName('FGO_ORIGEM').AsString = 'AKZO NOBEL') Then
        pSelecionarLotesSugestaoOndaDeSeparacao(cdsItensOnda);

    End;

    RecNo := intRecNo;
    EnableControls;

  End;

End;

Function TDefineLotesWMS.fRetQuantidadeDigitada(cdsLote: TUniClientDataSet;
                                                strCodIte, strNumLot,
                                                strAutDet: String): Double;
Begin
  Result := 0;

  With cdsLote Do
  Begin
    Filter := 'CODITE = ' + QuotedStr(strCodIte) + ' AND NUMLOT = ' + QuotedStr(strNumLot);
    If Not fEmptyStr(strAutDet) Then
      Filter := Filter + ' AND AUTINC <> ' + QuotedStr(strAutDet);

    Filtered := True;
    First;
    While Not Eof Do
    Begin
      Result := Result + FieldByName('QTDITE').AsFloat;
      Next;
    End;

    Filtered := False;
  End;
End;

Procedure TDefineLotesWMS.pAtualizaSaldoDisponivelLotes;
Begin
  With FLotes Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('SALDIS').AsFloat := FieldByName('SALDOS').AsFloat - //Saldo de estoque
                                       FieldByName('SALRES').AsFloat - //Saldo reservaco
                                       FieldByName('TOTDIG').AsFloat;  //Qtde ja digitada

      if fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis then
      begin
        FieldByName('SALDIS').AsFloat := FieldByName('SALDIS').AsFloat + FieldByName('SALRES').AsFloat;
      end;

      Post;
      Next;
    End;
  End;
End;

Procedure TDefineLotesWMS.pAtualizaTotalDigitado(strCodIte: String);
  Var
    cdsLote: TUniClientDataSet;
Begin

  With FLotes Do
  Begin
    cdsLote      := TUniClientDataSet.Create(Self);
    Filtered     := False;
    cdsLote.Data := Data;

    Filter       := 'CODITE = ' + QuotedStr(strCodIte);
    Filtered     := True;

    First;
    While Not Eof Do
    Begin
      Edit;
      FieldbyName('TOTDIG').AsFloat :=
        fRetQuantidadeDigitada(cdsLote, FieldByName('CODITE').AsString,
                                        FieldByName('NUMLOT').AsString,
                                        FieldByName('AUTINC').AsString);
      Post;

      Next;
    End;

    pAtualizaSaldoDisponivelLotes;

    Filtered     := False;
  End;

  FreeAndNil(cdsLote);
End;

function TDefineLotesWMS.fRetSaldoLote(strCodIte, strNumLot: String) : TDadosEstoqueLote;
  Var
    qryCadLot: TUniQuery;
Begin
  result.fltSaldo := 0;
  result.fltSaldoReservado := 0;
  result.fltMovimentacaoEntrada := 0;
  result.fltMovimentacaoSaida := 0;

  qryCadLot := fCriaQuery;
  With qryCadLot, SQL Do
  Begin
    Add('SELECT LOT_SALDOS FROM CADLOT');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE AND ');
    Add('  LOT_CODEMP = :CODEMP AND ');
    Add('  LOT_NUMLOT = :NUMLOT     ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('NUMLOT').AsString := strNumLot;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If not IsEmpty Then
    Begin
      result.fltSaldo := FieldByName('LOT_SALDOS').AsFloat;
      result.fltMovimentacaoEntrada := TMovimentacaoProgramada.fQuantidadeMovimentacaoLote(strCodIte, strNumLot, tmEntrada);


      //Quando nao tem saldo nao faz o select do saldo reservado para ficar mais rápido
      If ((result.fltSaldo <> 0) or (result.fltMovimentacaoEntrada > 0)) Then
      Begin
        result.fltSaldoReservado := TSaldoReservado.New(
                                     TReservaParametros.New()
                                       .EmpresaItem(VS_strCodEmp)
                                       .CodigoItem(strCodIte)
                                       .CodEmpresa(VS_strCodEmp)
                                       .NumeroLote(strNumLot)
                                       .NumeroDocumento(FNumPed)
                                       .TipoFiltroDocumento(tfdIgnorarDocumento)
                                     ).fGetQuantidade();
        result.fltMovimentacaoSaida := TMovimentacaoProgramada.fQuantidadeMovimentacaoLote(strCodIte, strNumLot, tmSaida);
      End;
    End;

  End;

  FreeAndNil(qryCadLot);
End;

function TDefineLotesWMS.fRetSaldoLoteOndaDeSeparacao(strCodIte, strNumLot: String): TDadosEstoqueLote;
  Var
    qryCadLot: TUniQuery;
Begin
  result.fltSaldo := 0;
  result.fltSaldoReservado := 0;
  result.fltMovimentacaoEntrada := 0;
  result.fltMovimentacaoSaida := 0;

  qryCadLot := fCriaQuery;
  With qryCadLot, SQL Do
  Begin
    Add('SELECT LOT_SALDOS FROM CADLOT');
    Add('WHERE');
    Add('  LOT_CODITE = :CODITE AND ');
    Add('  LOT_CODEMP = :CODEMP AND ');
    Add('  LOT_NUMLOT = :NUMLOT     ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('NUMLOT').AsString := strNumLot;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If not IsEmpty Then
    Begin
      result.fltSaldo := FieldByName('LOT_SALDOS').AsFloat;
      result.fltMovimentacaoEntrada := TMovimentacaoProgramada.fQuantidadeMovimentacaoLote(strCodIte, strNumLot, tmEntrada);


      //Quando nao tem saldo nao faz o select do saldo reservado para ficar mais rápido
      If ((result.fltSaldo <> 0) or (result.fltMovimentacaoEntrada > 0)) Then
      Begin
        result.fltSaldoReservado := TSaldoReservado.New(
                                     TReservaParametros.New()
                                       .EmpresaItem(VS_strCodEmp)
                                       .CodigoItem(strCodIte)
                                       .CodEmpresa(VS_strCodEmp)
                                       .NumeroLote(strNumLot)
                                       .OndaDeSeparacao(FOndaDeSeparacao)
                                       .TipoFiltroDocumento(tfdIgnorarDocumentosOnda)
                                     ).fGetQuantidade();
        result.fltMovimentacaoSaida := TMovimentacaoProgramada.fQuantidadeMovimentacaoLote(strCodIte, strNumLot, tmSaida);
      End;
    End;

  End;

  FreeAndNil(qryCadLot);

End;

Procedure TDefineLotesWMS.pAtualizaSaldosLotes;
  Var
    dadosEstoqueLote : TDadosEstoqueLote;
Begin
  With FLotes Do
  Begin
    First;

    While Not Eof Do
    Begin
      pRegistraProgresso('Aguarde, Calculando saldo disponível ' +
        'dos lotes... ', RecNo, RecordCount);

      If (Not fEmptyStr(FieldByName('NUMLOT').AsString)) Then
      Begin
        dadosEstoqueLote := fRetSaldoLote(FieldByName('CODITE').AsString,
                                          FieldByName('NUMLOT').AsString);

        Edit;
        FieldByName('SALDOS').AsFloat := dadosEstoqueLote.fltSaldo + dadosEstoqueLote.fltMovimentacaoEntrada;
        FieldByName('SALRES').AsFloat := dadosEstoqueLote.fltSaldoReservado + dadosEstoqueLote.fltMovimentacaoSaida;

        FieldByName('MOVENT').AsFloat := dadosEstoqueLote.fltMovimentacaoEntrada;
        FieldByName('MOVSAI').AsFloat := dadosEstoqueLote.fltMovimentacaoSaida;

        Post;
      End;

      Next;
    End;

    pAtualizaSaldoDisponivelLotes;

  End;
End;

procedure TDefineLotesWMS.pAtualizaSaldosLotesOndaDeSeparacao;
  Var
    dadosEstoqueLote : TDadosEstoqueLote;
Begin
  With FLotes Do
  Begin
    First;

    While Not Eof Do
    Begin
      pRegistraProgresso('Aguarde, Calculando saldo disponível ' +
        'dos lotes... ', RecNo, RecordCount);

      dadosEstoqueLote := fRetSaldoLoteOndaDeSeparacao(FieldByName('CODITE').AsString,
                                                       FieldByName('NUMLOT').AsString);

      Edit;
      FieldByName('SALDOS').AsFloat := dadosEstoqueLote.fltSaldo + dadosEstoqueLote.fltMovimentacaoEntrada;
      FieldByName('SALRES').AsFloat := dadosEstoqueLote.fltSaldoReservado + dadosEstoqueLote.fltMovimentacaoSaida;

      FieldByName('MOVENT').AsFloat := dadosEstoqueLote.fltMovimentacaoEntrada;
      FieldByName('MOVSAI').AsFloat := dadosEstoqueLote.fltMovimentacaoSaida;

      Post;

      Next;
    End;

    pAtualizaSaldoDisponivelLotes;

  End;
End;

Procedure TDefineLotesWMS.pLoteBeforePost(DataSet: TDataSet);
Begin
  With DataSet Do
  Begin

    If (FieldByName('QTDITE').AsFloat > 0) And (Not fLoteBrokerValido(DataSet)) Then
    Begin
      pMostraMensagem('Para essa origem de pedido, você só pode escolher "Lote Broker" igual a: '+IIF(FieldByName('BROKER').AsString='S', '"N"', '"S"')+' !');
      Abort;
    End

    Else If FieldByName('QTDITE').AsFloat > FQtdIte Then
    Begin
      pMostraMensagem('A quantidade digitada excede a quantidade total do item!');
      Abort;
    End

    Else If FieldByName('QTDITE').AsFloat < 0 Then
    Begin
      pMostraMensagem('A quantidade dever ser maior ou igual a zero!');
      Abort;
    End

    Else If (FieldByName('QTDITE').AsFloat > 0) And fEmptyStr(FieldByName('LOCFIS').AsString) Then
    Begin
      pMostraMensagem('Lote sem localização física!');
      Abort;
    End
       
    Else If (fFormataFloat(FieldByName('QTDITE').AsFloat,4) > 0) And
            (fFormataFloat(FieldByName('QTDITE').AsFloat,4) > fFormataFloat(FieldByName('SALDIS').AsFloat,4)) Then
    Begin
      pMostraMensagem('A quantidade digitada é maior que o saldo disponível do lote!');
      Abort;
    End;

  End;
End;

(*****************************************************************************)
(* ATUALIZA O CLIENT DE Lotes COM AS ALTERACOES DO USUARIO                *)
(**************************************************************************LA*)
Procedure TDefineLotesWMS.pSalvaAlteracaoLotes(cdsItePed: TUniClientDataSet);
Begin
  With cdsItePed Do
  Begin
    First;

    While Not Eof Do
    Begin
      If FLotes.Locate('CODITE;NUMLOT;AUTINC',
                         VarArrayOf([FieldByName('CODITE').AsString,
                                     FieldByName('NUMLOT').AsString,
                                     FieldByName('AUTINC').AsString]), []) Then
      Begin
        FLotes.Edit;
        FLotes.FieldByName('SALDOS').AsFloat := FieldByName('SALDOS').AsFloat;
        FLotes.FieldByName('SALRES').AsFloat := FieldByName('SALRES').AsFloat;
        FLotes.FieldByName('SALDIS').AsFloat := FieldByName('SALDIS').AsFloat;
        FLotes.FieldByName('TOTDIG').AsFloat := FieldByName('TOTDIG').AsFloat;
        FLotes.FieldByName('QTDITE').AsFloat := FieldByName('QTDITE').AsFloat;
        FLotes.Post;
      End;

      Next;
    End;
  End;
End;

procedure TDefineLotesWMS.pSalvaLotCor(recLotCorRobo: TLotCorRobo);
var
  qryLotCor: TUniQuery;
  strAutInc: string;
  intContador: integer;
begin
  qryLotCor := fCriaQuery;

  try
    try
      if fCampoTabela('COUNT(*)', 'LOTCOR', ['COR_NUMDOC','COR_ESPDOC','COR_CODEMP','COR_CODCLI','COR_CODITE'], [recLotCorRobo.strNumDoc, recLotCorRobo.strEspDoc, recLotCorRobo.strCodEmp, recLotCorRobo.strCodCLi, recLotCorRobo.strCodIte]) > 0 then
        Exit;

      If FComTransacao Then
        fStartTransaction;

      qryLotCor.Close;
      qryLotCor.SQL.Clear;
      qryLotCor.SQL.Add('INSERT INTO LOTCOR(AUTOINCREM,');
      qryLotCor.SQL.Add('COR_DTAOCO,');
      qryLotCor.SQL.Add('COR_HOROCO,');
      qryLotCor.SQL.Add('COR_NUMDOC,');
      qryLotCor.SQL.Add('COR_ESPDOC,');
      qryLotCor.SQL.Add('COR_CODEMP,');
      qryLotCor.SQL.Add('COR_CODCLI,');
      qryLotCor.SQL.Add('COR_CODITE,');
      qryLotCor.SQL.Add('COR_SAFIIT,');
      qryLotCor.SQL.Add('COR_SADIIT,');
      qryLotCor.SQL.Add('COR_TOTPEN,');
      qryLotCor.SQL.Add('COR_QTDCOR)');
      qryLotCor.SQL.Add('VALUES(:AUTINC,');
      qryLotCor.SQL.Add(':DTAOCO,');
      qryLotCor.SQL.Add(':HOROCO,');
      qryLotCor.SQL.Add(':NUMDOC,');
      qryLotCor.SQL.Add(':ESPDOC,');
      qryLotCor.SQL.Add(':CODEMP,');
      qryLotCor.SQL.Add(':CODCLI,');
      qryLotCor.SQL.Add(':CODITE,');
      qryLotCor.SQL.Add(':SAFIIT,');
      qryLotCor.SQL.Add(':SADIIT,');
      qryLotCor.SQL.Add(':TOTPEN,');
      qryLotCor.SQL.Add(':QTDCOR)');

      strAutInc := fRetAutoIncrem('LOTCOR', VS_strCodEmp);

      qryLotCor.ParamByName('AUTINC').AsString := strAutInc;
      qryLotCor.ParamByName('DTAOCO').AsDate := fRetDataServidor;
      qryLotCor.ParamByName('HOROCO').AsTime := fRetHoraServidor;
      qryLotCor.ParamByName('NUMDOC').AsString := recLotCorRobo.strNumDoc;
      qryLotCor.ParamByName('ESPDOC').AsString := recLotCorRobo.strEspDoc;
      qryLotCor.ParamByName('CODEMP').AsString := recLotCorRobo.strCodEmp;
      qryLotCor.ParamByName('CODCLI').AsString := recLotCorRobo.strCodCLi;
      qryLotCor.ParamByName('CODITE').AsString := recLotCorRobo.strCodIte;
      qryLotCor.ParamByName('SAFIIT').AsFloat :=  recLotCorRobo.fltSalFisIte;
      qryLotCor.ParamByName('SADIIT').AsFloat :=  recLotCorRobo.fltSalDisIte;
      qryLotCor.ParamByName('TOTPEN').AsFloat :=  recLotCorRobo.fltQtdTotPed;
      qryLotCor.ParamByName('QTDCOR').AsFloat :=  recLotCorRobo.fltQtdCor;

      qryLotCor.ExecSQL;

      qryLotCor.Close;
      qryLotCor.SQL.Clear;
      qryLotCor.SQL.Add('INSERT INTO CORDET(AUTOINCREM,');
      qryLotCor.SQL.Add('DET_SEQCOR,');
      qryLotCor.SQL.Add('DET_NUMLOT,');
      qryLotCor.SQL.Add('DET_SAFILO,');
      qryLotCor.SQL.Add('DET_SADILO)');
      qryLotCor.SQL.Add('VALUES(:AUTINC,');
      qryLotCor.SQL.Add(':SEQCOR,');
      qryLotCor.SQL.Add(':NUMLOT,');
      qryLotCor.SQL.Add(':SAFILO,');
      qryLotCor.SQL.Add(':SADILO)');

      for intContador := low(recLotCorRobo.arrCorDet) to high(recLotCorRobo.arrCorDet) do
      begin
        qryLotCor.Close;
        qryLotCor.ParamByName('AUTINC').AsString := fRetAutoIncrem('CORDET', VS_strCodEmp);
        qryLotCor.ParamByName('SEQCOR').AsString := strAutInc;
        qryLotCor.ParamByName('NUMLOT').AsString := recLotCorRobo.arrCorDet[intContador].strNumLot;
        qryLotCor.ParamByName('SAFILO').AsFloat :=  recLotCorRobo.arrCorDet[intContador].sltSalFisLot;
        qryLotCor.ParamByName('SADILO').AsFloat :=  recLotCorRobo.arrCorDet[intContador].fltSalDisLot;
        qryLotCor.ExecSQL;
      end;

      If FComTransacao Then
        fCommit;

    except

      If FComTransacao Then
        fRollBack;

    end;

  finally
    FreeAndNil(qryLotCor);
  end;
end;

procedure TDefineLotesWMS.pSalvarLocalizacaoFisicaCdsLote(const strCodIte,
  strCodAca, strCodLoc: String);
begin
  If Not FLotes.Locate('CODITE;CODACA',
    VarArrayOf([strCodIte, strCodAca]), []) Then
   Exit;

  FLotes.Edit;
  FLotes.FieldByName('LOCFIS').AsString := strCodLoc;
  FLotes.Post;
end;

procedure TDefineLotesWMS.pCarregaLocalizaoFisica(const strCodIte,
  strCodAca: String; var cdsDados: TUniClientDataSet);
var
  intCorre : Integer;
begin
  If not Assigned(FLotes) Then
    Exit;

  If Assigned(cdsDados) Then
    FreeAndNil(cdsDados);

  pCriaLotesItens(cdsDados);

  FLotes.Filter   := 'CODITE = ' + QuotedStr(strCodIte)
                   + ' AND CODACA = ' + QuotedStr(strCodAca);

  FLotes.Filtered := True;

  FLotes.First;
  While Not FLotes.Eof Do
  Begin
    If fFormataFloat(FLotes.FieldByName('QTDITE').AsFloat, 4) > 0 Then
    Begin
      cdsDados.Append;

      For intCorre := 0 To cdsDados.FieldCount -1 Do
        cdsDados.Fields[intCorre].Value := FLotes.Fields[intCorre].Value;

      cdsDados.Post;
    End;

    FLotes.Next;
  End;
  cdsDados.First;

end;

procedure TDefineLotesWMS.pCarregaLotesDigitados(strCodIte,
  strAutInc: String; var cdsDados: TUniClientDataSet);
  Var
    intCorre : Integer;
begin
  if not Assigned(FLotes) Then
    Exit;

  If Assigned(cdsDados) Then
    FreeAndNil(cdsDados);

  pCriaLotesItens(cdsDados);

  With FLotes Do
  Begin
    try
      if strAutInc <> '' then
        Filter   := 'CODITE = ' + QuotedStr(strCodIte) + ' AND AUTINC = ' + QuotedStr(strAutInc)
      else
        Filter   := 'CODITE = ' + QuotedStr(strCodIte);
      Filtered := True;

      First;
      While Not Eof Do
      Begin

        If fFormataFloat(FieldByName('QTDITE').AsFloat, 4) > 0 Then
        Begin
          cdsDados.Insert;

          For intCorre := 0 To cdsDados.FieldCount -1 Do
            cdsDados.Fields[intCorre].Value := Fields[intCorre].Value;

          cdsDados.Post;
        End;

        Next;
      End;
      cdsDados.First;

    Finally
      Filtered := False;
      Filter   := '';
    End;

  End;

end;

procedure TDefineLotesWMS.pCarregaLotesDigitadosOndaDeSeparacao(strCodIte : String; var cdsDados: TUniClientDataSet);
Var
  intCorre : Integer;
begin

  if not Assigned(FLotes) Then
    Exit;

  If Assigned(cdsDados) Then
    FreeAndNil(cdsDados);

  pCriaLotesItens(cdsDados);

  With FLotes Do
  Begin
    try
      Filter   := 'CODITE = ' + QuotedStr(strCodIte);
      Filtered := True;

      First;
      While Not Eof Do
      Begin

        If fFormataFloat(FieldByName('QTDITE').AsFloat, 4) > 0 Then
        Begin
          cdsDados.Insert;

          For intCorre := 0 To cdsDados.FieldCount -1 Do
            cdsDados.Fields[intCorre].Value := Fields[intCorre].Value;

          cdsDados.Post;
        End;

        Next;
      End;
      cdsDados.First;

    Finally
      Filtered := False;
      Filter   := '';
    End;

  End;

end;

procedure TDefineLotesWMS.pCarregarQuantidadeDigitadaBD(
  cdsItePed: TUniClientDataSet);

  function fTemDigitacao(strIdePro, strNumLot: String): Boolean;
  Begin
    Result := True;
    //Quando parametrizado desta forma o sistema gerou um lotdor na baixa da formulacao
    If FUsaWMSRastreavelTinta And fEmptyStr(FAutIncTinta) And (Not FTemDig) And
      ((strIdePro <> 'NOR') And (strNumLot <> 'A DEFINIR')) And (fTipoTinta(strIdePro) = ttImobiliaria) Then
      Result := False;
  End;

  Var
    strCodIte: String;
    strAutInc: String;
    qryLotDor: TUniQuery;
    prcScroll: TprcScroll;
Begin
  pDisableControls(cdsItePed, prcScroll);

  qryLotDor := fCriaQuery;
  FTemDig   := False;
  FRecalcularQtdeItens := True;

  cdsItePed.First;

  If (fClienteFilial(cdsItePed.FieldByName('FGO_CODCLI').AsString)) Then
  Begin
    qryLotDor.Close;
    qryLotDor.SQL.Clear;
    qryLotDor.SQL.Add(' SELECT COUNT(0) AS QTDITE FROM FATDOR               ');
    qryLotDor.SQL.Add(' INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM ');
    qryLotDor.SQL.Add(' WHERE FATDOR.FDO_SEQGER = :SEQGER                   ');

    qryLotDor.ParamByName('SEQGER').AsString := cdsItePed.FieldByName('FDO_SEQGER').AsString;

    qryLotDor.Open;
    If (qryLotDor.FieldByName('QTDITE').AsInteger > 0) Then
    Begin
      If FModoSemMensagens Then
        pArmazenaMensagem('Deseja recalcular as quantidades de separação deste pedido ?')
      else If fMensagem('', 'Deseja recalcular as quantidades de separação deste pedido ?', ['&Sim', '&Não'], 2) = 2 Then
        FRecalcularQtdeItens := False;
    End;

  End;

  While Not cdsItePed.Eof Do
  Begin
    pRegistraProgresso('Aguarde, Carregando quantidade digitada ' +
      'dos produtos... ', cdsItePed.RecNo, cdsItePed.RecordCount);

    strCodIte := cdsItePed.FieldByName('ITE_CODITE').AsString;
    strAutInc := cdsItePed.FieldByName('AUTOINCREM').AsString;

    With qryLotDor, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM LOTDOR WHERE LDO_SEQFDO = :SEQFDO');
      ParamByName('SEQFDO').AsString := strAutInc;
      Open;

      If Not IsEmpty Then
      Begin
        FTemDig := fTemDigitacao(cdsItePed.FieldByName('FDO_IDEPRO').AsString, cdsItePed.FieldByName('FDO_NUMLOT').AsString);

        If Not FRecalcularQtdeItens Then
          FTemDig := True;

        FLotes.Filter   := 'CODITE = ' + QuotedStr(strCodIte) + ' AND ' +
                           'AUTINC = ' + QuotedStr(strAutInc);
        FLotes.Filtered := True;

        FLotes.First;
        While Not FLotes.Eof Do
        Begin
          FLotes.Edit;
          FLotes.FieldByName('QTDITE').AsFloat := 0;
          FLotes.Post;
          FLotes.Next;
        End;

        FLotes.Filtered := False;
        FLotes.Filter   := '';
      End;

      First;
      While Not Eof Do
      Begin
        If FLotes.Locate('CODITE;NUMLOT;AUTINC',
          VarArrayOf([strCodIte, FieldByName('LDO_NUMLOT').AsString, strAutInc]), []) Then
        Begin
          FLotes.Edit;
          FLotes.FieldByName('QTDITE').AsFloat := FieldByName('LDO_QTDITE').AsFloat;
          FLotes.Post;
        End;
        Next;
      End;
    End;

    pAtualizaTotalDigitado(strCodIte);

    cdsItePed.Next;
  End;

  pEnableControls(cdsItePed, prcScroll);

  If Assigned(qryLotDor) Then FreeAndNil(qryLotDor);

End;

procedure TDefineLotesWMS.pCarregarQuantidadeDigitadaBDOndaDeSeparacao;

  function fTemDigitacao(strIdePro, strNumLot: String): Boolean;
  Begin
    Result := True;
    //Quando parametrizado desta forma o sistema gerou um lotdor na baixa da formulacao
    If FUsaWMSRastreavelTinta And fEmptyStr(FAutIncTinta) And (Not FTemDig) And
      ((strIdePro <> 'NOR') And (strNumLot <> 'A DEFINIR')) And (fTipoTinta(strIdePro) = ttImobiliaria) Then
      Result := False;
  End;

  Var
    strCodIte: String;
    strAutInc: String;
    qryLotDor: TUniQuery;
    qryOndaPD: TUniQuery;
Begin

  FTemDig              := False;
  FRecalcularQtdeItens := True;

  qryLotDor := fCriaQuery;
  qryOndaPD := fCriaQuery;

  Try
    qryOndaPD.SQL.Clear;
    qryOndaPD.SQL.Add(fGetSqlItensOndaDeSeparacao(False, ''));
    qryOndaPD.Open;

    qryOndaPD.First;
    While Not qryOndaPD.Eof Do
    Begin

      pRegistraProgresso('Aguarde, Carregando quantidade digitada ' + 'dos produtos... ', qryOndaPD.RecNo, qryOndaPD.RecordCount);

      strCodIte := qryOndaPD.FieldByName('ITE_CODITE').AsString;
      strAutInc := qryOndaPD.FieldByName('AUTOINCREM').AsString;

      With qryLotDor, SQL Do
      Begin
        Close;
        Clear;
        Add('SELECT * FROM LOTDOR WHERE LDO_SEQFDO = :SEQFDO');
        ParamByName('SEQFDO').AsString := strAutInc;
        Open;

        If Not IsEmpty Then
        Begin
          FTemDig := fTemDigitacao(qryOndaPD.FieldByName('FDO_IDEPRO').AsString, qryOndaPD.FieldByName('FDO_NUMLOT').AsString);

          If Not FRecalcularQtdeItens Then
            FTemDig := True;

          FLotes.Filter   := 'CODITE = ' + QuotedStr(strCodIte);
          FLotes.Filtered := True;

          FLotes.First;
          While Not FLotes.Eof Do
          Begin
            FLotes.Edit;
            FLotes.FieldByName('QTDITE').AsFloat := 0;
            FLotes.Post;
            FLotes.Next;
          End;

        End;

        First;
        While Not Eof Do
        Begin
          If FLotes.Locate('CODITE;NUMLOT',
            VarArrayOf([strCodIte, FieldByName('LDO_NUMLOT').AsString]), []) Then
          Begin
            FLotes.Edit;
            FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('QTDITE').AsFloat + FieldByName('LDO_QTDITE').AsFloat;
            FLotes.Post;
          End;
          Next;
        End;
      End;

      qryOndaPD.Next;

    End;

  Finally

    FLotes.Filtered := False;
    FLotes.Filter   := '';

    If Assigned(qryLotDor) Then
      FreeAndNil(qryLotDor);

    If Assigned(qryOndaPD) Then
      FreeAndNil(qryOndaPD);

  End;

End;

Procedure TDefineLotesWMS.pCopiaClient(cdsOrigem, cdsDestino: TUniClientDataSet);
  Var
    intContador: Integer;
Begin
  With cdsOrigem Do
  Begin
    First;
    While Not Eof Do
    Begin
      cdsDestino.Insert;

      For intContador := 0 To Fields.Count - 1 Do
        cdsDestino.Fields[intContador].Value := Fields[intContador].Value;

      cdsDestino.Post;
      Next;
    End;
  End;
  cdsDestino.First;
End;

function TDefineLotesWMS.fLoteBrokerValido(DataSet: TDataSet): Boolean;
begin
  Result := fEmptyStr(DataSet.FieldByName('ORIGEM').AsString);

  If (Not Result) Then
    Result := IIF(DataSet.FieldByName('ORIGEM').AsString='AKZO NOBEL', 'S', 'N') = DataSet.FieldByName('BROKER').AsString;
end;

function TDefineLotesWMS.fPossuiMensagemDeErro: Boolean;
begin
  Result := False;

  If Not Assigned(FMensagens) Then
    Exit;

  Result := (FMensagens.Count > 0);
end;

class function TDefineLotesWMS.fClienteEstoqueExterno(strCodCli: String): Boolean;
var
  qryEstExt : TUniQuery;
const
  SQL = 'SELECT * FROM CADEEE WHERE EEE_CODCLI = :CODCLI';
begin

  Result := False;

  If fEmptyStr(strCodCli) Then
    Exit;

  qryEstExt := fCriaQuery();

  Try

    qryEstExt.Close;
    qryEstExt.SQL.Clear;
    qryEstExt.SQL.Add(SQL);
    qryEstExt.ParamByName('CODCLI').AsString := strCodCli;
    qryEstExt.Open;

    Result := Not qryEstExt.IsEmpty;

  Finally
    FreeAndNil(qryEstExt);
  End;

end;

Function TDefineLotesWMS.fDigitaLotes(strCodIte, strDescri, strAutInc: String; fltQtdIte: Double; strIdePro: String;
                                      Var strLote: String): Boolean;
  Var
    strFiltro: String;
    frmFatDigitaLotesWMS: TfrmFatDigitaLotesWMS;
Begin
  Result := False;

  pCriarFormularios(TfrmFatDigitaLotesWMS, frmFatDigitaLotesWMS);
  Try
    frmFatDigitaLotesWMS.fltQtdIte := fltQtdIte;

    With frmFatDigitaLotesWMS, FLotes Do
    Begin
      FQtdIte  := fltQtdIte;

      {Se for onda de separação, filtra somente o item, pois
       os itens foram consolidados!}
      If Not FOndaDeSeparacao.IsEmpty Then
      Begin
        Filter   := 'CODITE = ' + QuotedStr(strCodIte);
      End
      Else
      Begin
        Filter   := 'CODITE = ' + QuotedStr(strCodIte) + ' AND ' +
                    'AUTINC = ' + QuotedStr(strAutInc);
      End;

      strFiltro := Filter;

      Filtered := True;

      if (not fEmptyStr(FOndaDeSeparacao)) then
        pAtualizaSaldosLotesOndaDeSeparacao
      else
        pAtualizaSaldosLotes;

      //Que possua saldo ou ja tenha quantidade digitada
      Filtered := False;
      Filter   := IIF(fEmptyStr(Filter), strFiltro +  ' AND ((QTDITE > 0) OR (SALDOS > 0))', Filter +  ' AND ((QTDITE > 0) OR (SALDOS > 0))');
      Filtered := True;

      edtCodIte.Text := strCodIte + ' - ' + strDescri;
      edtQtdIte.Text := FormatFloat(fMskDigitos(FCadLot.intDecQtd), fltQtdIte);

      if strIdePro = 'NOR' then
        edtSituac.Text := 'Normal'
      else
        edtSituac.Text := 'Tinta';

      pCriaLotesItens(cdsLotes);

      pCopiaClient(FLotes, cdsLotes);
      cdsLotes.BeforePost := pLoteBeforePost;

      If ShowModal = mrOk Then
      Begin
        pSalvaAlteracaoLotes(cdsLotes);

        if fEmptyStr(FOndaDeSeparacao) then
          pAtualizaTotalDigitado(strCodIte);

        strLote := strNumLot;

        Result := True;
      End;

      cdsLotes.BeforePost := Nil;
      cdsLotes.EmptyDataSet;
      FreeAndNil(cdsLotes);

      Filtered  := False;
    End;
  Finally
    pFreeAndNil(frmFatDigitaLotesWMS);
  End;
End;

function TDefineLotesWMS.fExisteDefinicaoLotesParaDocumento(strNumDoc,
  strEspDoc, strCodEmp: String): Boolean;
Var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  Try
    qryGen.SQL.Text :=
      '  SELECT ' +
      '    COUNT(0) ' +
      '  FROM ' +
      '    FATGOR ' +
      '    INNER JOIN EXTGOR ' +
      '      ON FGO_SEQFGO = FATGOR.AUTOINCREM ' +
      '    INNER JOIN FATDOR ' +
      '      ON FDO_SEQGER = FATGOR.AUTOINCREM ' +
      '    INNER JOIN LOTDOR ' +
      '      ON LDO_SEQFDO = FATDOR.AUTOINCREM ' +
      '  WHERE FGO_NUMDOC = :NUMDOC ' +
      '    AND FGO_ESPDOC = :ESPDOC ' +
      '    AND FGO_CODEMP = :CODEMP ';
    qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
    qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGen.ParamByName('CODEMP').AsString := strCodEmp;
    qryGen.Open;
    Result := qryGen.Fields[0].AsInteger > 0;
  Finally
    FreeAndNil(qryGen);
  End;
end;

Procedure TDefineLotesWMS.pAtualizaScrollLotes(cdsItePed: TUniClientDataSet; strLote: String);
Begin
  With cdsItePed Do
  Begin
    Edit;
    FieldByName('NUMLOT').AsString := strLote;
    Post;
  End;
End;

Function TDefineLotesWMS.fQuantidadeDigitadaLotes: Double;
Begin
  Result := 0;
  With FLotes Do
  Begin
    First;
    While Not Eof Do
    Begin
      Result := Result + FieldByName('QTDITE').AsFloat;
      Next;
    End;
  End;
End;

function TDefineLotesWMS.fQuantidadeLotDorOndaDeSeparacao(strCodIte : String): Double;
Var
  fltQtdLotDor : Double;
  cdsCloneLote : TUniClientDataSet;
Begin

  Try

    cdsCloneLote := TUniClientDataSet.Create(Nil);
    cdsCloneLote.CloneCursor(FLotes, False, True);

    cdsCloneLote.Filter := 'CODITE = ' + QuotedStr(strCodIte);

    cdsCloneLote.Filtered := True;
    fltQtdLotDor := 0;

    If (Not cdsCloneLote.IsEmpty) Then
    Begin
      cdsCloneLote.First;
      While not cdsCloneLote.Eof Do
      Begin
        fltQtdLotDor := fltQtdLotDor + cdsCloneLote.FieldByName('QTDITE').AsFloat;
        cdsCloneLote.Next;
      End;

      Result := fltQtdLotDor;
    End
    Else
      Result := 0;

  Finally
    FreeAndNil(cdsCloneLote);
  End;
End;

Function TDefineLotesWMS.fValidaSaldoDisponivelLotes(Var strLotes: String): Boolean;
Begin
  Result := True;
  strLotes := '';
  With FLotes Do
  Begin
    First;
    While Not Eof Do
    Begin
      If (fFormataFloat(FieldByName('QTDITE').AsFloat,4) > 0) And
         (fFormataFloat(FieldByName('QTDITE').AsFloat,4) > fFormataFloat(FieldByName('SALDIS').AsFloat,4)) Then
      Begin
        Result := False;
        If Not fEmptyStr(strLotes) Then
          strLotes := strLotes + ', ';

        strLotes := strLotes + QuotedStr('Produto: ' + FieldByName('CODITE').AsString + ' Lote: ' + FieldByName('NUMLOT').AsString + ' Documento: ' + FNumPed + '-' + FEspPed);
      End;
      Next;
    End;
  End;
End;

function TDefineLotesWMS.fVerificaLotesTintaComSaldo: String;
begin
  Result := '';

  if (not fCfgSis('WMSPRI', varBoolean)) then
    Exit;

  FLotes.First;

  while not FLotes.Eof do
  begin
    if (FLotes.FieldByName('PRITIN').AsString = 'S') and
       (FLotes.FieldByName('SALDIS').AsFloat > 0) and
       (fLoteBrokerValido(FLotes)) then
    begin
      if (not fEmptyStr(Result)) then
        Result := Result + #10#13;

      Result := Result + '       - ' + FLotes.FieldByName('NUMLOT').AsString + ' - Saldo Disp: ' + FormatFloat(fMskDigitos(FCadLot.intDecQtd), FLotes.FieldByName('SALDIS').AsFloat);
    end;

    FLotes.Next;
  end;
end;

function TDefineLotesWMS.fValidaCadastroLotesProdutos: Boolean;
  Var
    qryGenDor: TUniQuery;
    blnLocFor: Boolean;
    stlSemADefinir: TStringList;
    stlSemPrincTin: TStringList;
    matrizSaldosAux: TClassMatrizSaldosColorantes;
    recInputSQLItens : TInputSQLItensPedido;
    objSQLItensPedido : TSQLItensPedido;
begin
  Result := True;
  qryGenDor := fCriaQuery;

  stlSemADefinir := TStringList.Create;
  stlSemPrincTin := TStringList.Create;

  stlSemADefinir.Sorted := True;
  stlSemPrincTin.Sorted := True;

  stlSemADefinir.Duplicates := dupIgnore;
  stlSemPrincTin.Duplicates := dupIgnore;

  With qryGenDor Do
  Begin
    FillChar(recInputSQLItens, SizeOf(recInputSQLItens), #0);
    recInputSQLItens.blnHerancaOrcamentoPedido := False;
    recInputSQLItens.blnCarregarClassificacao := False;
    recInputSQLItens.strEspOrc := FEspPed;
    recInputSQLItens.blnWMS := True;
    recInputSQLItens.blnExpedi := False;
    recInputSQLItens.strEmpCfg := VS_strCodEmp;
    recInputSQLItens.strLeftJoinCadLotItensPedido := TFatVenda.fGetSQLLeftJoinCadLotItensPedido(recInputSQLItens.blnWMS);
    recInputSQLItens.blnBaiEntFut := False;
    recInputSQLItens.strOpcDoc := '';
    recInputSQLItens.blnCliFil := False;
    objSQLItensPedido := TSQLItensPedido.Create(recInputSQLItens);
    Try
      Close;
      SQL.Clear;
      SQL.Add(objSQLItensPedido.fGetSQL);

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('NUMDOC').AsString := FNumPed;
      ParamByName('ESPDOC').AsString := FEspPed;
      ParamByName('EMPDOC').AsString := FEmpPed;

      Open;
    Finally
      FreeAndNil(objSQLItensPedido);
    End;

    First;
    While Not Eof Do
    Begin
      pRegistraProgresso('Aguarde, Validando cadastro de lotes dos produtos... ', RecNo, RecordCount);

      //Produto Normal
      If FieldByName('FDO_IDEPRO').AsString = 'NOR' Then
      Begin
        If (FieldByName('FDO_PROACA').AsString <> 'S') Then
        Begin
          If Not FCadLot.fExisteLote(FieldByName('FDO_CODITE').AsString, VS_strCodEmp, 'A DEFINIR', False, False) Then
          Begin
            stlSemADefinir.Add(FieldByName('FDO_CODITE').AsString);
            Result := False;
          End;
        End;
      End
      //Tinta de Maquina
      Else
      Begin
        matrizSaldosAux := fDesfragmentaTintaSaldosOR(qryGenDor, blnLocFor, False);

        If Not TFatVenda.fValidaLoteEmbalagemColorantesWMS(FieldByName('FDO_CODITE').AsString,
                                                           FieldByName('FDO_IDEPRO').AsString,
                                                           FieldByName('FDO_ITEEMB').AsString,
                                                           VS_strCodEmp,
                                                           matrizSaldosAux,
                                                           FCadLot, stlSemPrincTin) Then
        Begin
          Result := False;
        End;

        FreeAndNil(matrizSaldosAux);
      End;
      Next;
    End;
  End;

  If Not Result Then
  Begin
    If stlSemADefinir.Count > 0 Then
      pMensagemSonora('Para separar um pedido utilizando rotina de WMS é necessário que todos os ' +
                      'produtos possuam lote "A DEFINIR" cadastrado corretamente. ' +
                      'Favor verificar o cadastro de lotes dos produtos: ' +
                      AnsiReplaceStr(stlSemADefinir.CommaText, ',', ', ') + '.');

    If stlSemPrincTin.Count > 0 Then
      pMensagemSonora('Para separar um pedido utilizando rotina de WMS é necessário que todos os ' +
                      'Colorantes/Embalagens possuam um "Lote principal para tinta de máquina" cadastrado corretamente. ' +
                      'Favor verificar o cadastro de lotes dos produtos: ' +
                      AnsiReplaceStr(stlSemPrincTin.CommaText, ',', ', ') + '.');
  End;

  FreeAndNil(qryGenDor);
  FreeAndNil(stlSemADefinir);
  FreeAndNil(stlSemPrincTin);
end;

function TDefineLotesWMS.fValidaCadastroLotesProdutosOndaDeSeparacao: Boolean;
Var
  qryGenDor       : TUniQuery;
  //blnLocFor       : Boolean;
  stlSemADefinir  : TStringList;
  stlSemPrincTin  : TStringList;
  //matrizSaldosAux : TClassMatrizSaldosColorantes;
begin

  Result    := True;
  qryGenDor := fCriaQuery;

  stlSemADefinir := TStringList.Create;
  stlSemPrincTin := TStringList.Create;

  stlSemADefinir.Sorted := True;
  stlSemPrincTin.Sorted := True;

  stlSemADefinir.Duplicates := dupIgnore;
  stlSemPrincTin.Duplicates := dupIgnore;

  Try

    With qryGenDor Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(fGetSqlItensOndaDeSeparacao(True, ''));
      Open;

      First;
      While Not Eof Do
      Begin

        pRegistraProgresso('Aguarde, Validando cadastro de lotes dos produtos... ', RecNo, RecordCount);

        //Produto Normal
        If FieldByName('FDO_IDEPRO').AsString = 'NOR' Then
        Begin
          If (FieldByName('FDO_PROACA').AsString <> 'S') Then
          Begin
            If Not FCadLot.fExisteLote(FieldByName('FDO_CODITE').AsString, VS_strCodEmp, 'A DEFINIR', False, False) Then
            Begin
              stlSemADefinir.Add(FieldByName('FDO_CODITE').AsString);
              Result := False;
            End;
          End;
        End;
        //Tinta de Maquina
        {
        Else
        Begin
          matrizSaldosAux := fDesfragmentaTintaSaldosOR(qryGenDor, blnLocFor, False);

          If Not TFatVenda.fValidaLoteEmbalagemColorantesWMS(FieldByName('FDO_CODITE').AsString,
                                                             FieldByName('FDO_IDEPRO').AsString,
                                                             FieldByName('FDO_ITEEMB').AsString,
                                                             VS_strCodEmp,
                                                             matrizSaldosAux,
                                                             FCadLot, stlSemPrincTin) Then
          Begin
            Result := False;
          End;

          FreeAndNil(matrizSaldosAux);
        End;
        }
        Next;
      End;
    End;

    If Not Result Then
    Begin
      If stlSemADefinir.Count > 0 Then
        pMensagemSonora('Para separar um pedido utilizando rotina de WMS é necessário que todos os ' +
                        'produtos possuam lote "A DEFINIR" cadastrado corretamente. ' +
                        'Favor verificar o cadastro de lotes dos produtos: ' +
                        AnsiReplaceStr(stlSemADefinir.CommaText, ',', ', ') + '.');

      If stlSemPrincTin.Count > 0 Then
        pMensagemSonora('Para separar um pedido utilizando rotina de WMS é necessário que todos os ' +
                        'Colorantes/Embalagens possuam um "Lote principal para tinta de máquina" cadastrado corretamente. ' +
                        'Favor verificar o cadastro de lotes dos produtos: ' +
                        AnsiReplaceStr(stlSemPrincTin.CommaText, ',', ', ') + '.');
    End;

  Finally

    If Assigned(qryGenDor) Then
      FreeAndNil(qryGenDor);

    If Assigned(stlSemADefinir) Then
      FreeAndNil(stlSemADefinir);

    If Assigned(stlSemPrincTin) Then
      FreeAndNil(stlSemPrincTin);

  End;

end;

Function TDefineLotesWMS.fValidarLotes(cdsItePed: TUniClientDataSet; blnChamouPeloRobo: Boolean = False): Boolean;
  Var
    strLotes: String;
    qryMovLot : TUniQuery;
    blnExibirEPedirSenhaDosItensComMovimentacaoProgramadaEmAberto : Boolean;
    objLiberacao : TLiberacao;
    objLinha  : TLinhaMsgLibera;
    objTabela : TRegistroMsgLiberaTabela;
    intAux    : Integer;
    strEmpDes : String;
    blnTransferenciaEntreEmpresasWMS : boolean;
    arrInfSaldosTrava: array of TDadosTravaSaldo;
    recLotCorRobo: TLotCorRobo;
Begin

  Result := True;
  blnExibirEPedirSenhaDosItensComMovimentacaoProgramadaEmAberto := False;
  pAtualizaSaldosLotes;
  SetLength(arrInfSaldosTrava, 0);

  With cdsItePed Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      pRegistraProgresso('Aguarde, Validando digitação ' +
        'dos Lotes... ', cdsItePed.RecNo, cdsItePed.RecordCount);

      FLotes.Filter   := 'AUTINC = ' + QuotedStr(FieldByName('AUTOINCREM').AsString);
      FLotes.Filtered := True;


      if (FLotes.RecordCount > 1) then
      begin
        blnTransferenciaEntreEmpresasWMS := false;
        if fClienteFilial(cdsItePed.FieldByName('FGO_CODCLI').AsString, strEmpDes) And (FLotes.FieldByName('RASTRE').AsString = 'S') Then
          blnTransferenciaEntreEmpresasWMS := fUsaRotinaWMS(strEmpDes);

        If blnTransferenciaEntreEmpresasWMS And (Not fCfgSis('LOTDIF', VarBoolean)) Then
        Begin
          intAux := 0;

          FLotes.First;
          While (Not FLotes.Eof) Do
          Begin
            If (FLotes.FieldByName('QTDITE').AsFloat > 0) Then
              Inc(intAux);

            FLotes.Next;
          End;
          FLotes.First;

          If (intAux > 1) Then
          Begin
            Result := False;
            pMostraMensagem('Não é permitido separar o item '+FieldByName('FDO_CODITE').AsString+' em lotes diferentes para cliente filial!' +#10#13+
                            'Separe integralmente ou parcialmente em apenas um lote.');
            Break;
          End;
        End;

      end;

      If (fFormataFloat(FieldByName('FDO_QTDITE').AsFloat, FCadLot.intDecQtd) < fFormataFloat(fQuantidadeDigitadaLotes, FCadLot.intDecQtd)) Then
      Begin
        Result := False;
        pMostraMensagem('A quantidade digitada excede a quantidade total do item!');
        Break;
      End;

      If (FieldByName('FDO_IDEPRO').AsString = 'NOR') And (FieldByName('FDO_PROACA').AsString <> 'S') And (Not fValidaSaldoDisponivelLotes(strLotes)) Then
      Begin
        If Not FEhDefinicaoDeLotesPickingCheckOut Then
        Begin
          Result := False;
          pMostraMensagem('A quantidade digitada é maior que o saldo ' + 'disponível do(s) lote(s) (' + strLotes + ')!');
          Break;
        End;
      End;

      If (fFormataFloat(FieldByName('FDO_QTDITE').AsFloat, FCadLot.intDecQtd) <> fFormataFloat(fQuantidadeDigitadaLotes, FCadLot.intDecQtd)) Then
      Begin

        if fCfgSis('SEPEND', varBoolean) then
        Begin
          if (fQuantidadeDigitadaLotes + fRetornaSaldoReservadoEnderecamento(FieldByName('FDO_CODITE').AsString)) >= FieldByName('FDO_QTDITE').AsFloat then
          begin
            SetLength(arrInfSaldosTrava, Length(arrInfSaldosTrava) + 1);
            arrInfSaldosTrava[Length(arrInfSaldosTrava) - 1].strCodIte := FieldByName('FDO_CODITE').AsString;
            arrInfSaldosTrava[Length(arrInfSaldosTrava) - 1].fltQtdDis := fRetornaSaldoDisponivel(FieldByName('FDO_CODITE').AsString, FieldByName('FDO_IDEPRO').AsString);
            arrInfSaldosTrava[Length(arrInfSaldosTrava) - 1].fltQtdSep := fQuantidadeDigitadaLotes;
            arrInfSaldosTrava[Length(arrInfSaldosTrava) - 1].fltQtdPed := FieldByName('FDO_QTDITE').AsFloat;
            arrInfSaldosTrava[Length(arrInfSaldosTrava) - 1].fltResEnd := fRetornaSaldoReservadoEnderecamento(FieldByName('FDO_CODITE').AsString);
            arrInfSaldosTrava[Length(arrInfSaldosTrava) - 1].fltQtdCor := arrInfSaldosTrava[Length(arrInfSaldosTrava) - 1].fltQtdPed - arrInfSaldosTrava[Length(arrInfSaldosTrava) - 1].fltQtdSep;

          end;
        End;

        If (FieldByName('TEM_MOVLOT').AsString = 'S') And (not fCfgSis('VSEWMS', varBoolean)) Then
        Begin
          blnExibirEPedirSenhaDosItensComMovimentacaoProgramadaEmAberto := True;
          Result := False;
        End
        Else

        If (Not fCfgExpedicaoParcialHabilitada) Or ((Not fEmptyStr(FAutIncTinta)) And FUsaWMSRastreavelTinta) Or (fCfgSis('TIPEXP', varInteger) = 5) Then
        Begin

          //Expedicao Tipo 5 Não vai solicitar o lote mais quando não for possivel
          //atender o pedido, sera exibido a lista de itens que não pode ser atendido
          If (fCfgSis('TIPEXP', varInteger) = 5) Then
          Begin
            TItensNaoAtendidosSeparacaoWMS.pAdd(FieldByName('FDO_CODITE').AsString,
                                                FieldByName('FDO_DESCRI').AsString,
                                                FieldByName('FDO_NUMDOC').AsString,
                                                FieldByName('FDO_ESPDOC').AsString,
                                                FieldByName('FDO_QTDITE').AsFloat,
                                                fQuantidadeDigitadaLotes);
          End
          Else
          Begin
            fLock_Unlock(STR_DEFINICAO_LOTES, False);;
            pMostraMensagem('A quantidade digitada do item difere da quantidade total!');
            Result := False;
          End;

        End
        Else
        Begin
          if Length(arrInfSaldosTrava) = 0 then
          begin

            If FModoSemMensagens Then
            begin
              Result := True;
              pArmazenaMensagem('A quantidade digitada do item ' + FieldByName('FDO_CODITE').AsString + ' '  +
                                'difere da quantidade total!');
            end
            Else
              Result := fMensagem('','A quantidade digitada do item ' + FieldByName('FDO_CODITE').AsString + ' '  +
                                     'difere da quantidade total!' + #13#10 + 'Confirma separação e expedição ' +
                                     'parcial do produto?', ['&Sim', '&Não'], IIF(Pos(fCfgSis('WMSSEP'), '1_3') > 0, 2, 1)) = 1;

          end;
        End;

        // Entra na função somente se o item for cortado, no caso que eu tenha saldo para atender alguma quantidade deste item mas não totalmente.
        If (blnChamouPeloRobo) And (fQuantidadeDigitadaLotes > 0) And ((FieldByName('FDO_QTDITE').AsFloat - fQuantidadeDigitadaLotes) > 0)  Then
        Begin
          FillChar(recLotCorRobo, SizeOf(recLotCorRobo), #0);
          SetLength(recLotCorRobo.arrCorDet, 0);
          recLotCorRobo.strNumDoc := FieldByName('FDO_NUMDOC').AsString;
          recLotCorRobo.strEspDoc := FieldByName('FDO_ESPDOC').AsString;
          recLotCorRobo.strCodEmp := FieldByName('FDO_CODEMP').AsString;
          recLotCorRobo.strCodCLi := FieldByName('FGO_CODCLI').AsString;
          recLotCorRobo.strCodIte := FieldByName('FDO_CODITE').AsString;
          recLotCorRobo.fltSalFisIte := FieldByName('ITE_SALDOS').AsFloat;
          recLotCorRobo.fltSalDisIte := FieldByName('SALDIS').AsFloat;
          recLotCorRobo.fltQtdCor := fQuantidadeDigitadaLotes;
          recLotCorRobo.fltQtdTotPed := FieldByName('FDO_QTDITE').AsFloat - recLotCorRobo.fltQtdCor;

          FLotes.First;
          while not FLotes.Eof do
          begin
            SetLength(recLotCorRobo.arrCorDet, Length(recLotCorRobo.arrCorDet) + 1);
            recLotCorRobo.arrCorDet[Length(recLotCorRobo.arrCorDet) - 1].strNumLot := FLotes.FieldByName('NUMLOT').AsString;
            recLotCorRobo.arrCorDet[Length(recLotCorRobo.arrCorDet) - 1].fltSalDisLot := FLotes.FieldByName('SALDOS').AsFloat - FLotes.FieldByName('SALRES').AsFloat;
            recLotCorRobo.arrCorDet[Length(recLotCorRobo.arrCorDet) - 1].sltSalFisLot := FLotes.FieldByName('SALDOS').AsFloat;
            FLotes.Next;
          end;

          pSalvaLotCor(recLotCorRobo);
        End;

        If Not Result Then
          Break;
      End;

      Next;
    End;

    if Length(arrInfSaldosTrava) > 0 then
    begin

      objLiberacao := TLiberacao.Create;

      try
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddSeparador(127);
        objLiberacao.objMsgLibera.pAddTexto('Não há quantidade disponível para atender à quantidade total do pedido, porém o item possui saldo reservado endereçamento!', alCentro, teAmbos, '', 127);
        objLiberacao.objMsgLibera.pAddTexto('Deseja mesmo realizar o corte?', alCentro, teAmbos, '', 127);
        objLiberacao.objMsgLibera.pAddSeparador(127);

        objTabela := TRegistroMsgLiberaTabela.Create;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'Item'                    ,10 , alEsquerda  , teAutcom);
        objLinha.pAddColuna(''  , 'Qtd. Disponível'         ,10 , alDireita   , teAutcom);
        objLinha.pAddColuna(''  , 'Qtd. Separação'          ,10 , alDireita   , teAutcom);
        objLinha.pAddColuna(''  , 'Qtd. Pedido'             ,10 , alDireita   , teAutcom);
        objLinha.pAddColuna(''  , 'Reservado Endereçamento' ,10 , alDireita   , teAutcom);
        objLinha.pAddColuna(''  , 'Qtd. Corte'              ,10 , alDireita   , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        for intAux := Low(arrInfSaldosTrava) to High(arrInfSaldosTrava) do
        begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('Item'                   , arrInfSaldosTrava[intAux].strCodIte  , 10 , alEsquerda );
          objLinha.pAddColuna('Qtd. Disponível'        , FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), arrInfSaldosTrava[intAux].fltQtdDis), 10 , alDireita  );
          objLinha.pAddColuna('Qtd. Separação'         , FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), arrInfSaldosTrava[intAux].fltQtdSep), 10 , alDireita  );
          objLinha.pAddColuna('Qtd. Pedido'            , FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), arrInfSaldosTrava[intAux].fltQtdPed), 10 , alDireita  );
          objLinha.pAddColuna('Reservado Endereçamento', FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), arrInfSaldosTrava[intAux].fltResEnd), 10 , alDireita  );
          objLinha.pAddColuna('Qtd. Corte'             , FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), arrInfSaldosTrava[intAux].fltQtdCor), 10 , alDireita  );
          objTabela.lstLinhas.Add(objLinha);
        end;

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
        objLiberacao.strDirAce := 'SAREEN';
        objLiberacao.strMsgSen := 'Liberação de corte do pedido';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.strTitulo := 'Liberação de corte do pedido';

        Result := objLiberacao.fLibera;

      finally
        FreeAndNil(objLiberacao);
      end;
    end;

    If blnExibirEPedirSenhaDosItensComMovimentacaoProgramadaEmAberto Then
    Begin
      First;

      qryMovLot := fCriaQuery;

      qryMovLot.SQL.Clear;
      qryMovLot.SQL.Add(' SELECT ORI.LOT_LOCFIS AS LOCORI, ');
      qryMovLot.SQL.Add('        IF(IFNULL(MLT_QTDMOV,0) > 0, MLT_QTDMOV, ORI.LOT_SALDOS) AS QTDMOV, ');
      qryMovLot.SQL.Add('        ORI.LOT_DTAVAL AS DTAVAL, ');
      qryMovLot.SQL.Add('        DES.LOT_LOCFIS AS LOCDES  ');
      qryMovLot.SQL.Add(' FROM MOVLOT                      ');

      qryMovLot.SQL.Add('   INNER JOIN CADLOT ORI ON ORI.LOT_CODITE = MLT_CODITE ');
      qryMovLot.SQL.Add('                        AND ORI.LOT_CODEMP = MLT_CODEMP ');
      qryMovLot.SQL.Add('                        AND ORI.LOT_NUMLOT = MLT_LOTORI ');

      qryMovLot.SQL.Add('   INNER JOIN CADLOT DES ON DES.LOT_CODITE = MLT_CODITE ');
      qryMovLot.SQL.Add('                        AND DES.LOT_CODEMP = MLT_CODEMP ');
      qryMovLot.SQL.Add('                        AND DES.LOT_NUMLOT = MLT_LOTDES ');

      qryMovLot.SQL.Add(' WHERE MLT_CODEMP = :CODEMP ');
      qryMovLot.SQL.Add('   AND MLT_CODITE = :CODITE ');
      qryMovLot.SQL.Add('   AND MLT_DTAREA IS NULL   ');

      objLiberacao := TLiberacao.Create;

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.pAddColuna('', 'CÓDIGO'             , fTamCodIte , alEsquerda, teAutcom);
      objLinha.pAddColuna('', 'DESCRIÇÃO'          , 30 , alEsquerda, teAutcom);
      objLinha.pAddColuna('', 'LOCALIZAÇÃO ORIGEM' , 20 , alEsquerda, teAutcom);
      objLinha.pAddColuna('', 'QUANTIDADE', 12     , alDireita, teAutcom);
      objLinha.pAddColuna('', 'LOCALIZAÇÃO DESTINO', 20 , alEsquerda, teAutcom);

      If fCfgSis('COLVAL', varBoolean) Then
        objLinha.pAddColuna('', 'VALIDADE', 10 , alEsquerda, teAutcom);

      objTabela.lstLinhas.Add(objLinha);

      While not Eof Do
      Begin
        If (fFormataFloat(FieldByName('FDO_QTDITE').AsFloat, FCadLot.intDecQtd) <> fFormataFloat(fQuantidadeDigitadaLotes, FCadLot.intDecQtd)) And
           (FieldByName('TEM_MOVLOT').AsString = 'S') Then
        Begin
          qryMovLot.Close;
          qryMovLot.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryMovLot.ParamByName('CODITE').AsString := FieldByName('FDO_CODITE').AsString;
          qryMovLot.Open;

          If not qryMovLot.isEmpty Then
          Begin

            While Not qryMovLot.Eof Do
            Begin
              objLinha  := TLinhaMsgLibera.Create;
              objLinha.pAddColuna('CÓDIGO'             , FieldByName('FDO_CODITE').AsString   , fTamCodIte , alEsquerda, teAmbos);
              objLinha.pAddColuna('DESCRIÇÃO'          , FieldByName('FDO_DESCRI').AsString, 30 , alEsquerda, teAmbos);
              objLinha.pAddColuna('LOCALIZAÇÃO ORIGEM' , qryMovLot.FieldByName('LOCORI').AsString, 20 , alEsquerda, teAmbos);
              objLinha.pAddColuna('QUANTIDADE'         , FormatFloat('#,##0.00', qryMovLot.FieldByName('QTDMOV').AsFloat), 12 , alDireita, teAmbos);
              objLinha.pAddColuna('LOCALIZAÇÃO DESTINO', qryMovLot.FieldByName('LOCDES').AsString, 20 , alEsquerda, teAmbos);

              If fCfgSis('COLVAL', varBoolean) Then
                objLinha.pAddColuna('VALIDADE', FormatDateTime('dd/MM/yyyy', qryMovLot.FieldByName('DTAVAL').AsDateTime), 10 , alEsquerda, teAmbos);

              objTabela.lstLinhas.Add(objLinha);

              qryMovLot.Next;
            End;

          End;


        End;

        Next;
      End;

      //Solicita senha para liberar com movimentaçao programada em aberto.
      try
        objLiberacao.objMsgLibera.pAddTexto('Liberação de Impressão de Separação com Movimentação Programada em Aberto');
        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        objLiberacao.strDirAce := 'VSEWMS';
        objLiberacao.strSenLib := 'CITEL13347';
        objLiberacao.strMsgSen := 'Liberação de Impressão de Separação com Movimentação Programada em Aberto';
        objLiberacao.blnMosMen := True;
        objLiberacao.strCodOpe := strLoginUsuarioLogado;

        Result := objLiberacao.fLibera;
      finally
        FreeAndNil(objLiberacao);
      end;

    End;

    FLotes.Filtered := False;
    EnableControls;

  End;

  If Assigned(qryMovLot) Then
    FreeAndNil(qryMovLot);

End;

function TDefineLotesWMS.fValidarLotesOndaDeSeparacao(cdsItensOnda: TUniClientDataSet): Boolean;
Var
  strLotes     : String;
  qryMovLot    : TUniQuery;
  blnExibirEPedirSenhaDosItensComMovimentacaoProgramadaEmAberto : Boolean;
  objLiberacao : TLiberacao;
  objLinha     : TLinhaMsgLibera;
  objTabela    : TRegistroMsgLiberaTabela;
  //intAux       : Integer;
  //strEmpDes    : String;
  //blnTransferenciaEntreEmpresasWMS : boolean;
Begin

  Result := True;
  blnExibirEPedirSenhaDosItensComMovimentacaoProgramadaEmAberto := False;
  pAtualizaSaldosLotesOndaDeSeparacao;

  With cdsItensOnda Do
  Begin

    DisableControls;
    First;
    While Not Eof Do
    Begin

      pRegistraProgresso('Aguarde, Validando digitação ' + 'dos Lotes... ', cdsItensOnda.RecNo, cdsItensOnda.RecordCount);

      FLotes.Filter   := 'CODITE = ' + QuotedStr(FieldByName('FDO_CODITE').AsString);
      FLotes.Filtered := True;

      If (fFormataFloat(FieldByName('FDO_QTDITE').AsFloat, FCadLot.intDecQtd) < fFormataFloat(fQuantidadeDigitadaLotes, FCadLot.intDecQtd)) Then
      Begin
        Result := False;
        pMostraMensagem('A quantidade digitada excede a quantidade total do item!');
        Break;
      End;

      If (FieldByName('FDO_IDEPRO').AsString = 'NOR') And (FieldByName('FDO_PROACA').AsString <> 'S') And (Not fValidaSaldoDisponivelLotes(strLotes)) Then
      Begin
        Result := False;
        pMostraMensagem('A quantidade digitada é maior que o saldo ' +
          'disponível do(s) lote(s) (' + strLotes + ')!');
        Break;
      End;

      If (fFormataFloat(FieldByName('FDO_QTDITE').AsFloat, FCadLot.intDecQtd) <> fFormataFloat(fQuantidadeDigitadaLotes, FCadLot.intDecQtd)) Then
      Begin

        If (FieldByName('TEM_MOVLOT').AsString = 'S') And (not fCfgSis('VSEWMS', varBoolean)) Then
        Begin
          blnExibirEPedirSenhaDosItensComMovimentacaoProgramadaEmAberto := True;
          Result := False;
        End
        Else

        If (Not fCfgExpedicaoParcialHabilitada) Or ((Not fEmptyStr(FAutIncTinta)) And FUsaWMSRastreavelTinta) Or (fCfgSis('TIPEXP', varInteger) = 5) Then
        Begin

          //Expedicao Tipo 5 Não vai solicitar o lote mais quando não for possivel
          //atender o pedido, sera exibido a lista de itens que não pode ser atendido
          If (fCfgSis('TIPEXP', varInteger) = 5) Then
          Begin
            TItensNaoAtendidosSeparacaoWMS.pAdd(FieldByName('FDO_CODITE').AsString,
                                                FieldByName('FDO_DESCRI').AsString,
                                                FieldByName('FDO_NUMDOC').AsString,
                                                FieldByName('FDO_ESPDOC').AsString,
                                                FieldByName('FDO_QTDITE').AsFloat,
                                                fQuantidadeDigitadaLotes);
          End
          Else
          Begin
            fLock_Unlock(STR_DEFINICAO_LOTES, False);;
            pMostraMensagem('A quantidade digitada do item difere da quantidade total!');
            Result := False;
          End;

        End
        Else
        Begin

          If FModoSemMensagens Then
          begin
            Result := True;

            SetLength(FItensDiverg, Length(FItensDiverg) +1);
            FItensDiverg[High(FItensDiverg)].strCodIte := FieldByName('FDO_CODITE').AsString;
            FItensDiverg[High(FItensDiverg)].fltQtdIte := FieldByName('FDO_QTDITE').AsFloat;
            FItensDiverg[High(FItensDiverg)].fltSalDis := fQuantidadeDigitadaLotes;
            FItensDiverg[High(FItensDiverg)].strLotTin := fVerificaLotesTintaComSaldo;
          end
          Else
            Result := fMensagem('','A quantidade digitada do item ' + FieldByName('FDO_CODITE').AsString + ' '  +
                                   'difere da quantidade total!' + #13#10 + 'Confirma separação e expedição ' +
                                   'parcial do produto?', ['&Sim', '&Não'], IIF(Pos(fCfgSis('WMSSEP'), '1_3') > 0, 2, 1)) = 1;
        End;

        If Not Result Then
          Break;
      End;

      Next;
    End;

    pMontaMensagemItensQtdeDivergente;

    if (Assigned(FMensagens)) then
      Result := (FMensagens.Count <= 0);

    If blnExibirEPedirSenhaDosItensComMovimentacaoProgramadaEmAberto Then
    Begin
      First;

      qryMovLot := fCriaQuery;

      qryMovLot.SQL.Clear;
      qryMovLot.SQL.Add(' SELECT ORI.LOT_LOCFIS AS LOCORI, ');
      qryMovLot.SQL.Add('        IF(IFNULL(MLT_QTDMOV,0) > 0, MLT_QTDMOV, ORI.LOT_SALDOS) AS QTDMOV, ');
      qryMovLot.SQL.Add('        ORI.LOT_DTAVAL AS DTAVAL, ');
      qryMovLot.SQL.Add('        DES.LOT_LOCFIS AS LOCDES  ');
      qryMovLot.SQL.Add(' FROM MOVLOT                      ');

      qryMovLot.SQL.Add('   INNER JOIN CADLOT ORI ON ORI.LOT_CODITE = MLT_CODITE ');
      qryMovLot.SQL.Add('                        AND ORI.LOT_CODEMP = MLT_CODEMP ');
      qryMovLot.SQL.Add('                        AND ORI.LOT_NUMLOT = MLT_LOTORI ');

      qryMovLot.SQL.Add('   INNER JOIN CADLOT DES ON DES.LOT_CODITE = MLT_CODITE ');
      qryMovLot.SQL.Add('                        AND DES.LOT_CODEMP = MLT_CODEMP ');
      qryMovLot.SQL.Add('                        AND DES.LOT_NUMLOT = MLT_LOTDES ');

      qryMovLot.SQL.Add(' WHERE MLT_CODEMP = :CODEMP ');
      qryMovLot.SQL.Add('   AND MLT_CODITE = :CODITE ');
      qryMovLot.SQL.Add('   AND MLT_DTAREA IS NULL   ');

      objLiberacao := TLiberacao.Create;

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.pAddColuna('', 'CÓDIGO'             , fTamCodIte , alEsquerda, teAutcom);
      objLinha.pAddColuna('', 'DESCRIÇÃO'          , 30 , alEsquerda, teAutcom);
      objLinha.pAddColuna('', 'LOCALIZAÇÃO ORIGEM' , 20 , alEsquerda, teAutcom);
      objLinha.pAddColuna('', 'QUANTIDADE', 12     , alDireita, teAutcom);
      objLinha.pAddColuna('', 'LOCALIZAÇÃO DESTINO', 20 , alEsquerda, teAutcom);

      If fCfgSis('COLVAL', varBoolean) Then
        objLinha.pAddColuna('', 'VALIDADE', 10 , alEsquerda, teAutcom);

      objTabela.lstLinhas.Add(objLinha);

      While not Eof Do
      Begin
        If (fFormataFloat(FieldByName('FDO_QTDITE').AsFloat, FCadLot.intDecQtd) <> fFormataFloat(fQuantidadeDigitadaLotes, FCadLot.intDecQtd)) And
           (FieldByName('TEM_MOVLOT').AsString = 'S') Then
        Begin
          qryMovLot.Close;
          qryMovLot.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryMovLot.ParamByName('CODITE').AsString := FieldByName('FDO_CODITE').AsString;
          qryMovLot.Open;

          If not qryMovLot.isEmpty Then
          Begin

            While Not qryMovLot.Eof Do
            Begin
              objLinha  := TLinhaMsgLibera.Create;
              objLinha.pAddColuna('CÓDIGO'             , FieldByName('FDO_CODITE').AsString   , fTamCodIte , alEsquerda, teAmbos);
              objLinha.pAddColuna('DESCRIÇÃO'          , FieldByName('FDO_DESCRI').AsString, 30 , alEsquerda, teAmbos);
              objLinha.pAddColuna('LOCALIZAÇÃO ORIGEM' , qryMovLot.FieldByName('LOCORI').AsString, 20 , alEsquerda, teAmbos);
              objLinha.pAddColuna('QUANTIDADE'         , FormatFloat('#,##0.00', qryMovLot.FieldByName('QTDMOV').AsFloat), 12 , alDireita, teAmbos);
              objLinha.pAddColuna('LOCALIZAÇÃO DESTINO', qryMovLot.FieldByName('LOCDES').AsString, 20 , alEsquerda, teAmbos);

              If fCfgSis('COLVAL', varBoolean) Then
                objLinha.pAddColuna('VALIDADE', FormatDateTime('dd/MM/yyyy', qryMovLot.FieldByName('DTAVAL').AsDateTime), 10 , alEsquerda, teAmbos);

              objTabela.lstLinhas.Add(objLinha);

              qryMovLot.Next;
            End;

          End;


        End;

        Next;
      End;

      //Solicita senha para liberar com movimentaçao programada em aberto.
      try
        objLiberacao.objMsgLibera.pAddTexto('Liberação de Impressão de Separação com Movimentação Programada em Aberto');
        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        objLiberacao.strDirAce := 'VSEWMS';
        objLiberacao.strSenLib := 'CITEL13347';
        objLiberacao.strMsgSen := 'Liberação de Impressão de Separação com Movimentação Programada em Aberto';
        objLiberacao.blnMosMen := True;
        objLiberacao.strCodOpe := strLoginUsuarioLogado;

        Result := objLiberacao.fLibera;
      finally
        FreeAndNil(objLiberacao);
      end;

    End;

    FLotes.Filtered := False;
    EnableControls;
  End;

End;

Function TDefineLotesWMS.fSalvarQuantidadeDigitadaBD(cdsItePed: TUniClientDataSet; prgProgresso :TProgressBar): Boolean;
  Var
    prcScroll  : TprcScroll;
    qryLotDor  : TUniQuery;
    qryFatDor  : TUniQuery;
    cdsLotes   : TUniClientDataSet;
    stlFdo_TL  : TStringList;
    tintas     : ITintasDeMaquina;
    cdsEstoq   : TZClient;
    fltQtdTot  : Double;
    objTransf  : TTransferenciaArmazens;
    cdsItensTL : TUniClientDataSet;
    strCodLse  : String;
    strLotePD  : String;
    LEmpresa   : String;
    LEmpresas  : TArray<String>;

    objAuditSaldo       : IAuditoriaGravacaoSaldo;
    objReprocessarSaldoItens: IReprocessarSaldoItem;
    strCodErrosAuditoria: String;
Begin
  objAuditSaldo := TAuditoriaGravacaoSaldo.New;
  objReprocessarSaldoItens := TReprocessarSaldoItem.New();

  Try

    Result := True;
    pDisableControls(cdsItePed, prcScroll);

    objAuditSaldo.Limpar;

    If FComTransacao Then
      fStartTransaction;

    cdsLotes  := nil;
    qryLotDor := fCriaQuery;
    stlFdo_TL := TStringList.Create;

    cdsItePed.First;
    While Not cdsItePed.Eof Do
    Begin
      pRegistraProgresso('Aguarde, Salvando digitação ' +
        'dos Lotes... ', cdsItePed.RecNo, cdsItePed.RecordCount);

      If (cdsItePed.FieldByName('FDO_PROACA').AsString = 'S') Then
      Begin
        pCarregaLocalizaoFisica(cdsItePed.FieldByName('FDO_CODITE').AsString,
                                cdsItePed.FieldByName('FDO_CODACA').AsString,
                                cdsLotes);
        cdsLotes.First;
        While Not cdsLotes.Eof Do
        Begin
          pAtualizaLocalizaoFisicaProdutoAcabado(cdsLotes.FieldByName('CODACA').AsString,
                                                 cdsLotes.FieldByName('LOCFIS').AsString);
          cdsLotes.Next;
        End;

        cdsItePed.Next;
        Continue;
      End;

      pCarregaLotesDigitados(cdsItePed.FieldByName('ITE_CODITE').AsString,
                             cdsItePed.FieldByName('AUTOINCREM').AsString, cdsLotes);

      qryLotDor.Close;
      qryLotDor.SQL.Clear;
      qryLotDor.SQL.Add('SELECT * FROM LOTDOR WHERE LDO_SEQFDO = :SEQFDO');
      qryLotDor.ParamByName('SEQFDO').AsString := cdsItePed.FieldByName('AUTOINCREM').AsString;
      qryLotDor.Open;

      If qryLotDor.IsEmpty Then
        stlFdo_TL.Add(cdsItePed.FieldByName('AUTOINCREM').AsString);

      //Apaga os registros ja digitados
      While Not qryLotDor.IsEmpty Do
        qryLotDor.Delete;

      cdsLotes.First;
      While Not cdsLotes.Eof Do
      Begin
        If fFormataFloat(cdsLotes.FieldByName('QTDITE').AsFloat, 4) > 0 Then
        Begin
          If qryLotDor.RecordCount > 0 Then
            qryLotDor.Insert Else qryLotDor.Append;

          qryLotDor.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOTDOR', VS_strCodEmp);
          objAuditSaldo.Adicionar(qryLotDor.FieldByName('AUTOINCREM').AsString, 'LOTDOR');

          qryLotDor.FieldByName('LDO_SEQFDO').AsString := cdsLotes.FieldByName('AUTINC').AsString;
          qryLotDor.FieldByName('LDO_NUMLOT').AsString := cdsLotes.FieldByName('NUMLOT').AsString;
          qryLotDor.FieldByName('LDO_QTDITE').AsFloat  := cdsLotes.FieldByName('QTDITE').AsFloat;

          qryLotDor.FieldByName('LDO_SALCAL').AsFloat  := cdsLotes.FieldByName('SALDIS').AsFloat;
          qryLotDor.FieldByName('LDO_MOVENT').AsFloat  := cdsLotes.FieldByName('MOVENT').AsFloat;
          qryLotDor.FieldByName('LDO_MOVSAI').AsFloat  := cdsLotes.FieldByName('MOVSAI').AsFloat;

          If Not fEmptyStr(FCodLseItens) Then
          Begin
            strCodLse := fGetLocalSeparacaoItem(cdsLotes.FieldByName('CODITE').AsString);

            If arrLseWms.ContainsKey(strCodLse) Then
              qryLotDor.FieldByName('LDO_CODSEP').AsString := arrLseWms.Items[strCodLse].strCodSep;
          End
          Else If fCfgSis('LSEWMS', varBoolean) Then
          Begin
            strCodLse := fGetLocalSeparacaoLocFis(cdsLotes.FieldByName('LOCFIS').AsString);

            If arrLseWms.ContainsKey(strCodLse) Then
              qryLotDor.FieldByName('LDO_CODSEP').AsString := arrLseWms.Items[strCodLse].strCodSep;
          End;

          qryLotDor.Post;

          {Validação caso WMSLOT habilitada!}
          If fCfgSis('WMSLOT', varBoolean) Then
          Begin
            strLotePD := '';
            If (qryLotDor.FieldByName('LDO_SEQFDO').AsString <> '') Then
            Begin
              strLotePD := fCampoTabela('FDO_NUMLOT', 'FATDOR', ['AUTOINCREM'], [qryLotDor.FieldByName('LDO_SEQFDO').AsString]);
              {Vendedor informou lote no pedido?}
              If (strLotePD <> 'A DEFINIR') Then
              Begin
                {O lote informado foi alterado na separação [F6]?}
                If (strLotePD <> qryLotDor.FieldByName('LDO_NUMLOT').AsString) Then
                Begin
                  {Retorna lote para "A DEFINIR" no pedido}
                  fExecutaSQL('UPDATE FATDOR SET FDO_NUMLOT = "A DEFINIR" WHERE AUTOINCREM = ' + QuotedStr(qryLotDor.FieldByName('LDO_SEQFDO').AsString));
                End;
              End;
            End;
          End;

          LEmpresas := fGetEmpresasReprocessarItemPedido(cdsItePed.FieldByName('AUTOINCREM').AsString);

          For LEmpresa In LEmpresas Do
            objReprocessarSaldoItens.AddItem(TItemReprocessarSaldo.New.
                                                Codigo(cdsItePed.FieldByName('FDO_CODITE').AsString).
                                                Empresa(LEmpresa).
                                                EhItemEntregaFutura(True));
        End;
        cdsLotes.Next;
      End;

      cdsItePed.Next;
    End;

    objReprocessarSaldoItens.NotificarRoboParaReprocessarSaldos;

    If fCfgSis('TL_WMS', varBoolean) And (stlFdo_TL.Count > 0) And (fEmptyStr(FAutIncTinta) Or (Not FUsaWMSRastreavelTinta)) Then
    Begin
      tintas := fGetTintasdeMaquina;

      cdsItensTL := CriaCdsItensTL;

      objTransf := TTransferenciaArmazens.Create(Self, cdsItensTL, Nil, prgProgresso);

      cdsEstoq := TZClient.Create(Self, ' SELECT LOT_NUMLOT,              ' +
                                        '        LOT_SALDOS,              ' +
                                        '        LOT_DTAVAL,              ' +
                                        '        IF(LOT_SALDOS > 0,       ' +
                                        '           0, 1) AS INFSAL       ' +
                                        ' FROM CADLOT                     ' +
                                        ' WHERE LOT_CODITE = :CODITE      ' +
                                        '   AND LOT_CODEMP = :CODEMP      ' +
                                        '   AND LOT_NUMLOT <> :NUMLOT     ' +
                                        '   AND LOT_NUMLOT <> "A DEFINIR" ' +
                                        '   AND LOT_NUMLOT <> "A REGULARIZAR" ' +
                                        '   AND IFNULL(LOT_TRANSI, "N") = "N" ' +
                                        ' ORDER BY INFSAL, LOT_DTAVAL     ');

      qryFatDor := fCriaQuery(Self);
      qryFatDor.Close;
      qryFatDor.SQL.Clear;
      qryFatDor.SQL.Add(' SELECT * FROM FATDOR                                           ');
      qryFatDor.SQL.Add(' WHERE AUTOINCREM IN (' + fCommaText(stlFdo_TL, True) + ')      ');
      qryFatDor.SQL.Add('   AND LOCATE(FDO_IDEPRO,"' + tintas.fGetImobiliarias + '") > 0 ');
      qryFatDor.Open;

      While Not qryFatDor.Eof Do
      Begin
        qryLotDor.Close;
        qryLotDor.ParamByName('SEQFDO').AsString := qryFatDor.FieldByName('AUTOINCREM').AsString;
        qryLotDor.Open;
        While not qryLotDor.Eof Do
        Begin
          cdsEstoq.qryQuery.ParamByName('CODITE').AsString := qryFatDor.FieldByName('FDO_CODITE').AsString;
          cdsEstoq.qryQuery.ParamByName('NUMLOT').AsString := qryLotDor.FieldByName('LDO_NUMLOT').AsString;
          cdsEstoq.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
          cdsEstoq.fAbreClient(True, 'TDefineLotesWMS.fSalvarQuantidadeDigitadaBD');

          If qryLotDor.FieldByName('LDO_QTDITE').AsFloat > 0 Then
          Begin
            fltQtdTot := qryLotDor.FieldByName('LDO_QTDITE').AsFloat;

            While (fltQtdTot > 0) Do
            Begin
              if cdsItensTL.RecordCount > 0 Then
                cdsItensTL.Insert Else cdsItensTL.Append;
              cdsItensTL.FieldByName('CODITE').AsString := qryFatDor.FieldByName('FDO_CODITE').AsString;
              cdsItensTL.FieldByName('ARMDES').AsString := qryLotDor.FieldByName('LDO_NUMLOT').AsString;


              If (cdsEstoq.FieldByName('LOT_SALDOS').AsFloat >= fltQtdTot) Or
                 (cdsEstoq.FieldByName('LOT_SALDOS').AsFloat <= 0) Then
              Begin
                cdsItensTL.FieldByName('ARMORI').AsString := cdsEstoq.FieldByName('LOT_NUMLOT').AsString;
                cdsItensTL.FieldByName('QTDITE').AsFloat  := fltQtdTot;
                fltQtdTot := 0;
              End
              Else
              Begin
                fltQtdTot := fltQtdTot - cdsEstoq.FieldByName('LOT_SALDOS').AsFloat;
                cdsItensTL.FieldByName('ARMORI').AsString := cdsEstoq.FieldByName('LOT_NUMLOT').AsString;
                cdsItensTL.FieldByName('QTDITE').AsFloat  := cdsEstoq.FieldByName('LOT_SALDOS').AsFloat;
              End;

              cdsItensTL.Post;

              cdsEstoq.Next;

              If cdsEstoq.Eof Then
                fltQtdTot := 0;
            End;

          End;

          qryLotDor.Next;
        End;

        qryFatDor.Next;
      End;

      If cdsItensTL.RecordCount > 0 Then
        Result := objTransf.fGeraTransferencia(True, False);
    End;

    If (Result) And (Not objAuditSaldo.fValidouTodas(strCodErrosAuditoria)) then
    Begin

      If FComTransacao Then
        fRollBack;

      Result := False;
      pMostraErrosAuditoria(fRetornaErrosAuditoria(strCodErrosAuditoria));
    End;

    If FComTransacao Then
    Begin

      If Result Then
        fCommit
      Else
        fRollBack;

    End;

    If fCfgSis('TL_WMS', varBoolean) And (stlFdo_TL.Count > 0) And Result Then
      If (cdsItensTL.RecordCount > 0) Then
        objTransf.pImprimeTranferencia;

    pEnableControls(cdsItePed, prcScroll);

  Except
    On E: Exception Do
    Begin
      Result := False;

      If FComTransacao Then
      Begin
        fRollBack;
        pMensagensErro(E.Message, '');
      End;

    End;
  End;

  If Assigned(qryLotDor) Then
    FreeAndNil(qryLotDor);

  If Assigned(cdsLotes) Then
    FreeAndNil(cdsLotes);

  If Assigned(stlFdo_TL) Then
    FreeAndNil(stlFdo_TL);

  If Assigned(qryFatDor) Then
    FreeAndNil(qryFatDor);

  If Assigned(cdsEstoq) Then
    FreeAndNil(cdsEstoq);

  If Assigned(objTransf) Then
    FreeAndNil(objTransf);

  If Assigned(cdsItensTL) Then
    FreeAndNil(cdsItensTL);

End;

function TDefineLotesWMS.fSalvarQuantidadeDigitadaBDOndaDeSeparacao(cdsItensOnda: TUniClientDataSet; prgProgresso: TProgressBar): Boolean;
Var
  prcScroll  : TprcScroll;
  qryLotDor  : TUniQuery;
  qryFatDor  : TUniQuery;
  qryOndaPD  : TUniQuery;
  cdsLotes   : TUniClientDataSet;
  stlFdo_TL  : TStringList;
  tintas     : ITintasDeMaquina;
  cdsEstoq   : TZClient;
  fltQtdTot  : Double;
  objTransf  : TTransferenciaArmazens;
  cdsItensTL : TUniClientDataSet;
  strCodLse  : String;
  strLotePD  : String;
  LEmpresa   : String;
  LEmpresas  : TArray<String>;

  fltQtdPed  : Double;

  objAuditSaldo       : IAuditoriaGravacaoSaldo;
  objReprocessarSaldoItens: IReprocessarSaldoItem;
  strCodErrosAuditoria: String;

  procedure pCapturarSaldoDoLoteQueFoiDefinido(fltQtdBaixa : Double);
  begin
    cdsLotes.Edit;
    cdsLotes.FieldByName('QTDITE').AsFloat := (cdsLotes.FieldByName('QTDITE').AsFloat - fltQtdBaixa);
    cdsLotes.Post;
  end;

Begin

  {*** INFORMAÇÃO: Aqui nessa função, é preciso EXPLODIR a onda de forma analítica,
   para que seja possível gravar a tabela LOTDOR! Pois toda a separação
   de onda é realizada de forma consolidada por item!  ***}

  objAuditSaldo := TAuditoriaGravacaoSaldo.New;
  objReprocessarSaldoItens := TReprocessarSaldoItem.New();

  Try
    Result := True;
    pDisableControls(cdsItensOnda, prcScroll);

    objAuditSaldo.Limpar;

    If FComTransacao Then
      fStartTransaction;

    cdsLotes  := nil;
    qryLotDor := fCriaQuery;
    qryOndaPD := fCriaQuery;
    stlFdo_TL := TStringList.Create;

    cdsItensOnda.First;
    While Not cdsItensOnda.Eof Do
    Begin

      pRegistraProgresso('Aguarde, Salvando digitação ' + 'dos Lotes... ', cdsItensOnda.RecNo, cdsItensOnda.RecordCount);

      If (cdsItensOnda.FieldByName('FDO_PROACA').AsString = 'S') Then
      Begin
        pCarregaLocalizaoFisica(cdsItensOnda.FieldByName('FDO_CODITE').AsString,
                                cdsItensOnda.FieldByName('FDO_CODACA').AsString,
                                cdsLotes);
        cdsLotes.First;
        While Not cdsLotes.Eof Do
        Begin
          pAtualizaLocalizaoFisicaProdutoAcabado(cdsLotes.FieldByName('CODACA').AsString,
                                                 cdsLotes.FieldByName('LOCFIS').AsString);
          cdsLotes.Next;
        End;

        cdsItensOnda.Next;
        Continue;
      End;

      pCarregaLotesDigitadosOndaDeSeparacao(cdsItensOnda.FieldByName('ITE_CODITE').AsString, cdsLotes);

      {Ordena por data de validade}
      cdsLotes.IndexFieldnames := 'DTAVAL;NUMLOT;LOCFIS';
      cdsLotes.First;

      {Desagrupar registros da onda para o item}
      qryOndaPD.SQL.Clear;
      qryOndaPD.SQL.Add(fGetSqlItensOndaDeSeparacao(False, cdsItensOnda.FieldByName('ITE_CODITE').AsString));
      qryOndaPD.Open;

      qryOndaPD.First;
      While Not qryOndaPD.Eof Do
      Begin

        qryLotDor.Close;
        qryLotDor.SQL.Clear;
        qryLotDor.SQL.Add('SELECT * FROM LOTDOR WHERE LDO_SEQFDO = :SEQFDO');
        qryLotDor.ParamByName('SEQFDO').AsString := qryOndaPD.FieldByName('AUTOINCREM').AsString;
        qryLotDor.Open;

        If qryLotDor.IsEmpty Then
          stlFdo_TL.Add(qryOndaPD.FieldByName('AUTOINCREM').AsString);

        //Apaga os registros ja digitados
        While Not qryLotDor.IsEmpty Do
          qryLotDor.Delete;

        {*** Vai capturando o saldo do lote definido até
             zerar e passar para o próximo lote com saldo caso tenha! ***}

        fltQtdPed := qryOndaPD.FieldByName('FDO_QTDITE').AsFloat;

        While (Not cdsLotes.Eof) And (fltQtdPed > 0) Do
        Begin

          If fFormataFloat(cdsLotes.FieldByName('QTDITE').AsFloat, 4) > 0 Then
          Begin

            If qryLotDor.RecordCount > 0 Then
              qryLotDor.Insert
            Else
              qryLotDor.Append;

            qryLotDor.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOTDOR', VS_strCodEmp);
            objAuditSaldo.Adicionar(qryLotDor.FieldByName('AUTOINCREM').AsString, 'LOTDOR');

            qryLotDor.FieldByName('LDO_SEQFDO').AsString := qryOndaPD.FieldByName('AUTOINCREM').AsString;
            qryLotDor.FieldByName('LDO_NUMLOT').AsString := cdsLotes.FieldByName('NUMLOT').AsString;

            {Verifica se o saldo do lote definido atende a necessidade}
            If (cdsLotes.FieldByName('QTDITE').AsFloat >= fltQtdPed) Then
            Begin
              qryLotDor.FieldByName('LDO_QTDITE').AsFloat := fltQtdPed;
              pCapturarSaldoDoLoteQueFoiDefinido(fltQtdPed);
              fltQtdPed := 0; {Atendeu completamente...}
            End
            Else
            Begin
              qryLotDor.FieldByName('LDO_QTDITE').AsFloat := cdsLotes.FieldByName('QTDITE').AsFloat;
              fltQtdPed := (fltQtdPed - cdsLotes.FieldByName('QTDITE').AsFloat); {Atendeu parcialmente...}
              pCapturarSaldoDoLoteQueFoiDefinido(cdsLotes.FieldByName('QTDITE').AsFloat);
            End;

            qryLotDor.FieldByName('LDO_SALCAL').AsFloat  := cdsLotes.FieldByName('SALDIS').AsFloat;
            qryLotDor.FieldByName('LDO_MOVENT').AsFloat  := cdsLotes.FieldByName('MOVENT').AsFloat;
            qryLotDor.FieldByName('LDO_MOVSAI').AsFloat  := cdsLotes.FieldByName('MOVSAI').AsFloat;

            If fCfgSis('LSEWMS', varBoolean) Then
            Begin
              strCodLse := fGetLocalSeparacaoLocFis(cdsLotes.FieldByName('LOCFIS').AsString);

              If arrLseWms.ContainsKey(strCodLse) Then
                qryLotDor.FieldByName('LDO_CODSEP').AsString := arrLseWms.Items[strCodLse].strCodSep;
            End;

            qryLotDor.Post;

            {Validação caso WMSLOT habilitada!}
            If fCfgSis('WMSLOT', varBoolean) Then
            Begin
              strLotePD := '';
              If (qryLotDor.FieldByName('LDO_SEQFDO').AsString <> '') Then
              Begin
                strLotePD := fCampoTabela('FDO_NUMLOT', 'FATDOR', ['AUTOINCREM'], [qryLotDor.FieldByName('LDO_SEQFDO').AsString]);
                {Vendedor informou lote no pedido?}
                If (strLotePD <> 'A DEFINIR') Then
                Begin
                  {O lote informado foi alterado na separação [F6]?}
                  If (strLotePD <> qryLotDor.FieldByName('LDO_NUMLOT').AsString) Then
                  Begin
                    {Retorna lote para "A DEFINIR" no pedido}
                    fExecutaSQL('UPDATE FATDOR SET FDO_NUMLOT = "A DEFINIR" WHERE AUTOINCREM = ' + QuotedStr(qryLotDor.FieldByName('LDO_SEQFDO').AsString));
                  End;
                End;
              End;
            End;

            LEmpresas := fGetEmpresasReprocessarItemPedido(qryOndaPD.FieldByName('AUTOINCREM').AsString);

            For LEmpresa In LEmpresas Do
              objReprocessarSaldoItens.AddItem(TItemReprocessarSaldo.New.
                                                  Codigo(cdsItensOnda.FieldByName('FDO_CODITE').AsString).
                                                  Empresa(LEmpresa).
                                                  EhItemEntregaFutura(True));
          End;

          {próximo lote definido...}
          If (fltQtdPed > 0) Then
            cdsLotes.Next;
        End;

        {próximo item analítico...}
        qryOndaPD.Next;
      End;

      {próximo item consolidado...}
      cdsItensOnda.Next;

    End;
    objReprocessarSaldoItens.NotificarRoboParaReprocessarSaldos;

    {***}

    If fCfgSis('TL_WMS', varBoolean) And (stlFdo_TL.Count > 0) And (fEmptyStr(FAutIncTinta) Or (Not FUsaWMSRastreavelTinta)) Then
    Begin
      tintas := fGetTintasdeMaquina;

      cdsItensTL := CriaCdsItensTL;

      objTransf := TTransferenciaArmazens.Create(Self, cdsItensTL, Nil, prgProgresso);

      cdsEstoq := TZClient.Create(Self, ' SELECT LOT_NUMLOT,              ' +
                                        '        LOT_SALDOS,              ' +
                                        '        LOT_DTAVAL,              ' +
                                        '        IF(LOT_SALDOS > 0,       ' +
                                        '           0, 1) AS INFSAL       ' +
                                        ' FROM CADLOT                     ' +
                                        ' WHERE LOT_CODITE = :CODITE      ' +
                                        '   AND LOT_CODEMP = :CODEMP      ' +
                                        '   AND LOT_NUMLOT <> :NUMLOT     ' +
                                        '   AND LOT_NUMLOT <> "A DEFINIR" ' +
                                        '   AND LOT_NUMLOT <> "A REGULARIZAR" ' +
                                        '   AND IFNULL(LOT_TRANSI, "N") = "N" ' +
                                        ' ORDER BY INFSAL, LOT_DTAVAL     ');

      qryFatDor := fCriaQuery(Self);
      qryFatDor.Close;
      qryFatDor.SQL.Clear;
      qryFatDor.SQL.Add(' SELECT * FROM FATDOR                                           ');
      qryFatDor.SQL.Add(' WHERE AUTOINCREM IN (' + fCommaText(stlFdo_TL, True) + ')      ');
      qryFatDor.SQL.Add('   AND LOCATE(FDO_IDEPRO,"' + tintas.fGetImobiliarias + '") > 0 ');
      qryFatDor.Open;

      While Not qryFatDor.Eof Do
      Begin
        qryLotDor.Close;
        qryLotDor.ParamByName('SEQFDO').AsString := qryFatDor.FieldByName('AUTOINCREM').AsString;
        qryLotDor.Open;
        While not qryLotDor.Eof Do
        Begin
          cdsEstoq.qryQuery.ParamByName('CODITE').AsString := qryFatDor.FieldByName('FDO_CODITE').AsString;
          cdsEstoq.qryQuery.ParamByName('NUMLOT').AsString := qryLotDor.FieldByName('LDO_NUMLOT').AsString;
          cdsEstoq.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
          cdsEstoq.fAbreClient(True, 'TDefineLotesWMS.fSalvarQuantidadeDigitadaBDOndaDeSeparacao');

          If qryLotDor.FieldByName('LDO_QTDITE').AsFloat > 0 Then
          Begin
            fltQtdTot := qryLotDor.FieldByName('LDO_QTDITE').AsFloat;

            While (fltQtdTot > 0) Do
            Begin
              if cdsItensTL.RecordCount > 0 Then
                cdsItensTL.Insert Else cdsItensTL.Append;
              cdsItensTL.FieldByName('CODITE').AsString := qryFatDor.FieldByName('FDO_CODITE').AsString;
              cdsItensTL.FieldByName('ARMDES').AsString := qryLotDor.FieldByName('LDO_NUMLOT').AsString;

              If (cdsEstoq.FieldByName('LOT_SALDOS').AsFloat >= fltQtdTot) Or
                 (cdsEstoq.FieldByName('LOT_SALDOS').AsFloat <= 0) Then
              Begin
                cdsItensTL.FieldByName('ARMORI').AsString := cdsEstoq.FieldByName('LOT_NUMLOT').AsString;
                cdsItensTL.FieldByName('QTDITE').AsFloat  := fltQtdTot;
                fltQtdTot := 0;
              End
              Else
              Begin
                fltQtdTot := fltQtdTot - cdsEstoq.FieldByName('LOT_SALDOS').AsFloat;
                cdsItensTL.FieldByName('ARMORI').AsString := cdsEstoq.FieldByName('LOT_NUMLOT').AsString;
                cdsItensTL.FieldByName('QTDITE').AsFloat  := cdsEstoq.FieldByName('LOT_SALDOS').AsFloat;
              End;

              cdsItensTL.Post;

              cdsEstoq.Next;

              If cdsEstoq.Eof Then
                fltQtdTot := 0;
            End;

          End;

          qryLotDor.Next;
        End;

        qryFatDor.Next;
      End;

      If cdsItensTL.RecordCount > 0 Then
        Result := objTransf.fGeraTransferencia(True, False);

    End;

    If Result Then
      If fUsaOndaSeparacaoAgrupamento Then
        Result := RegravarONDSEP(FOndaDeSeparacao);

    If (Result) And (Not objAuditSaldo.fValidouTodas(strCodErrosAuditoria)) then
    Begin
      Result := False;
      pArmazenaMensagem(fRetornaErrosAuditoria(strCodErrosAuditoria));
    End;

    If FComTransacao Then
    Begin

      If Result Then
        fCommit
      Else
        fRollBack;

    End;

    If fCfgSis('TL_WMS', varBoolean) And (stlFdo_TL.Count > 0) And Result Then
      If (cdsItensTL.RecordCount > 0) Then
        objTransf.pImprimeTranferencia;

    pEnableControls(cdsItensOnda, prcScroll);

  Except
    On E: Exception Do
    Begin
      Result := False;

      If FComTransacao Then
      Begin
        fRollBack;
        pMensagensErro(E.Message, '');
      End;

    End;
  End;

  If Assigned(qryLotDor) Then
    FreeAndNil(qryLotDor);

  If Assigned(qryOndaPD) Then
    FreeAndNil(qryOndaPD);

  If Assigned(cdsLotes ) Then
    FreeAndNil(cdsLotes );

  If Assigned(stlFdo_TL) Then
    FreeAndNil(stlFdo_TL);

  If Assigned(qryFatDor) Then
    FreeAndNil(qryFatDor);

  If Assigned(cdsEstoq ) Then
    FreeAndNil(cdsEstoq );

  If Assigned(objTransf) Then
    FreeAndNil(objTransf);

  If Assigned(cdsItensTL) Then
    FreeAndNil(cdsItensTL);

End;

procedure TDefineLotesWMS.pVerificaSeFaraMovimentacaoProgramadaForcada(Var aBlnForcaMovimentacaoProgramada: Boolean);

  function fQtdDisponivel : double;
  begin
    Result := FLotes.FieldByName('SALDIS').AsFloat - FLotes.FieldByName('QTDITE').AsFloat;
  end;

begin
  If Assigned(FcdsSaldoEPonRepPorLoc) Then
  Begin
    aBlnForcaMovimentacaoProgramada := False;

    FcdsSaldoEPonRepPorLoc.First;
    While Not FcdsSaldoEPonRepPorLoc.Eof Do
    Begin
      FLotes.First;
      While Not FLotes.Eof Do
      Begin
        If (FLotes.FieldByName('PICKIN').AsString = 'SIM') And
           (FLotes.FieldByName('TRANSI').AsString <> 'SIM') And
           (FLotes.FieldByName('BALCAO').AsString <> 'SIM') And
           (IIF(fCfgSis('WMSPRI', varBoolean), (FLotes.FieldByName('PRITIN').AsString <> 'S'), True)) And
           (fLoteBrokerValido(FLotes)) And
           (FcdsSaldoEPonRepPorLoc.FieldByName('LOCFIS').AsString = FLotes.FieldByName('LOCFIS').AsString) Then
        Begin
          FcdsSaldoEPonRepPorLoc.Edit;
          FcdsSaldoEPonRepPorLoc.FieldByName('SALDIS').AsFloat := FcdsSaldoEPonRepPorLoc.FieldByName('SALDIS').AsFloat + fQtdDisponivel;
          FcdsSaldoEPonRepPorLoc.Post;
        End;

        FLotes.Next;
      End;

      FcdsSaldoEPonRepPorLoc.Next;
    End;

    FcdsSaldoEPonRepPorLoc.First;
    While Not FcdsSaldoEPonRepPorLoc.Eof Do
    Begin
      If (FcdsSaldoEPonRepPorLoc.FieldByName('SALDIS').AsFloat = 0) Or
         (FcdsSaldoEPonRepPorLoc.FieldByName('SALDIS').AsFloat <= FcdsSaldoEPonRepPorLoc.FieldByName('QTDREP').AsFloat) Then
      Begin
        aBlnForcaMovimentacaoProgramada := True;
        Break;
      End;

      FcdsSaldoEPonRepPorLoc.Next;
    End;
  End;
end;

Procedure TDefineLotesWMS.pSelecionarLotesSugestao(cdsItePed: TUniClientDataSet);
  Var
    strIndexName                   : String;
    fltQtdItePed                   : Double;
    fltQtdItePendente              : Double;
    objMovimentacao                : TMovimentacaoProgramada;
    blnForcaMovimentacaoProgramada : Boolean;
    blnSugerirBuffer               : Boolean;
    blnAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente : Boolean;
    blnPossuiLotePicLab: Boolean;

    strIdentificacaoDoProduto : String;

    function fQtdDisponivel : double;
    begin
      Result := FLotes.FieldByName('SALDIS').AsFloat - FLotes.FieldByName('QTDITE').AsFloat;
    end;

    procedure pSetItemTemMovimentacaoDeLote;
    begin
      cdsItePed.Edit;
      cdsItePed.FieldByName('TEM_MOVLOT').AsString := 'S';
      cdsItePed.Post;
    end;

    function fRetornaQuantidadeParcial : Double;
      var
        fltQtdItemPedido : Double;
        fltQtdDisponivel : Double;
    begin

      fltQtdItemPedido := cdsItePed.FieldByName('FDO_QTDITE').AsFloat;
      fltQtdDisponivel := objMovimentacao.QuantidadeDisponivel;

      If (fltQtdDisponivel >= fltQtdItemPedido) Then
        Result := fltQtdItemPedido
      Else
        Result := fltQtdDisponivel;

    end;

    function fExecutarMovimentacaoProgramada(strIdePro : String = '') : Boolean;
    begin

      If fEhTintaAutomotiva(strIdePro) Then
        Exit(False);

      If blnAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente Then
        Exit(False);

      Result := fCfgSis('WMSMOV', varBoolean) And ((fltQtdItePed > 0) Or (blnForcaMovimentacaoProgramada));

    end;

    function fFiltraLotesPickingLaboratorio: Boolean;
    begin
      If (cdsItePed.FindField('FDO_IDEPRO') <> Nil) And
         (fEhTintaImobiliaria(cdsItePed.FieldByName('FDO_IDEPRO').AsString)) Then
        Result := (FLotes.FieldByName('PRILAB').AsString = 'SIM')
      Else
        Result := (FLotes.FieldByName('PRILAB').AsString <> 'SIM');
    end;

Begin
  strIndexName := FLotes.IndexFieldNames;

  Try
    If cdsItePed.IsEmpty Then
      Exit;

    cdsItePed.DisableControls;
    cdsItePed.First;

    blnForcaMovimentacaoProgramada := False;
    blnAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente := False;

    While Not cdsItePed.Eof Do
    Begin

      pRegistraProgresso('Aguarde, Calculando quantidade sugerida ' + 'dos produtos... ', cdsItePed.RecNo, cdsItePed.RecordCount);

      strIdentificacaoDoProduto := '';

      If (cdsItePed.FindField('FDO_IDEPRO') <> Nil) Then
        strIdentificacaoDoProduto := cdsItePed.FindField('FDO_IDEPRO').AsString;

      fltQtdItePendente := cdsItePed.FieldByName('FDO_QTDITE').AsFloat - fQuantidadeLotDor(cdsItePed);
      fltQtdItePed := fltQtdItePendente;

      If fltQtdItePed = 0 Then
      Begin
        cdsItePed.Next;
        Continue;
      End;

      FLotes.Filter   := 'CODITE = ' + QuotedStr(cdsItePed.FieldByName('FDO_CODITE').AsString) + ' AND AUTINC = ' +
                                       QuotedStr(cdsItePed.FieldByName('AUTOINCREM').AsString);
      FLotes.Filtered := True;

      If fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis Then
      Begin
        FLotes.IndexFieldnames := 'SALDIS';
      End
      Else
      Begin

        FLotes.IndexFieldNames := RetornaIndexFieldNamesPrioridadesSugestaoOndaDeSeparacao(FLotes);

      End;

      {Se o produto for o item de ligação para tinta automotiva, a quantidade
       "Sugerida" deve ser a própria quantidade informada no pedido!.}
      If fEhTintaAutomotiva(strIdentificacaoDoProduto) Then
      Begin
        FLotes.Edit;
        FLotes.FieldByName('QTDITE').AsFloat := fltQtdItePed;
        FLotes.Post;
      End

      Else If FEhDefinicaoDeLotesPickingCheckOut And
              cdsItePed.FieldByName('DESTINO').AsString.Equals('RETIRA CAIXA') And
              FLotes.Locate('NUMLOT', cdsItePed.FieldByName('FDO_NUMLOT').AsString, []) Then
      Begin
        FLotes.Edit;
        FLotes.FieldByName('QTDITE').AsFloat := fltQtdItePed;
        FLotes.Post;
      End

      {Com base nas configurações WMSLOT caso o item seja "ITE_LOTEPD = S" a quantidade
       "Sugerida" deve ser a própria quantidade informada no pedido!.}
      Else If fLoteDefinidoNoPedido(cdsItePed.FieldByName('FDO_CODITE').AsString) And
         FLotes.Locate('NUMLOT', cdsItePed.FieldByName('FDO_NUMLOT').AsString, []) Then
      Begin
        FLotes.Edit;
        FLotes.FieldByName('QTDITE').AsFloat := fltQtdItePed;
        FLotes.Post;
      End

      //Caso for tinta deve selecionar o lote principal para tinta de maquina
      Else If ((cdsItePed.FieldByName('FDO_IDEPRO').AsString <> 'NOR') And (cdsItePed.FieldByName('FDO_NUMLOT').AsString <> 'A DEFINIR')) Or  (cdsItePed.FieldByName('FDO_PROACA').AsString = 'S') Then
      Begin
        If (Not FUsaWMSRastreavelTinta) Or
           (fTipoTinta(cdsItePed.FieldByName('FDO_IDEPRO').AsString) <> ttImobiliaria) Then
        Begin
          If FLotes.Locate('NUMLOT', cdsItePed.FieldByName('FDO_NUMLOT').AsString, []) Then
          Begin
            If fLoteBrokerValido(FLotes) Then
            Begin
              FLotes.Edit;
              FLotes.FieldByName('QTDITE').AsFloat := fltQtdItePed;
              FLotes.Post;
            End;
          End;
        End;
      End

      //Caso nao tenha quantidade ja digitada nos lotes
      Else If Not (FTemDig and fTemLoteDig(cdsItePed))Then
      Begin
        //Caso o produto possua Picking e a quantidade seja suficiente para atender a venda utiliza o mesmo

        blnSugerirBuffer := False;

        If fSugereBufferQuantSepMaiorIgualCapacidadeMaxPicking(cdsItePed.FieldByName('FDO_CODITE').AsString,
                                                               cdsItePed.FieldByName('FDO_QTDITE').AsFloat,
                                                               cdsItePed.FieldByName('FDO_IDEPRO').AsString,
                                                               cdsItePed.FieldByName('FDO_PROACA').AsString) Then
        Begin
          blnSugerirBuffer := True;
        End;

        blnPossuiLotePicLab := False;
        If fUsaPickingLaboratorioWms Then
          blnPossuiLotePicLab := fProdutoPossuiLotePicLab(cdsItePed.FieldByName('FDO_CODITE').AsString, True);

        //Mostrar Buffer - Cliente estoque externo
        If fClienteEstoqueExterno(FCodCli) Then
        Begin
          blnSugerirBuffer := (fCfgSis('CLIBUF', varBoolean));
        End;

        //Se não tiver acesso para ver os Buffers, poderá somente visualizar os Pickins, independente das configurações
        If (FExpedicao) And (Not fVerificaAcessoSistema('WMSBUF')) Then
        Begin
          blnSugerirBuffer := False;
        End;

        If (Not blnSugerirBuffer) Then
        Begin
          pCriaSaldoEPonRepPorLoc(FcdsSaldoEPonRepPorLoc);

          FLotes.First;
          While Not FLotes.Eof Do
          Begin
            blnForcaMovimentacaoProgramada := False;

            If (fltQtdItePed > 0) And
               (FLotes.FieldByName('PICKIN').AsString = 'SIM') And
               (FLotes.FieldByName('TRANSI').AsString <> 'SIM') And
               (FLotes.FieldByName('BALCAO').AsString <> 'SIM') And
               (IIF(fUsaPickingLaboratorioWms And blnPossuiLotePicLab, fFiltraLotesPickingLaboratorio, True)) And
               (IIF(fCfgSis('WMSPRI', varBoolean), (FLotes.FieldByName('PRITIN').AsString <> 'S'), True)) And
               (fQtdDisponivel > 0) And
               (fLoteBrokerValido(FLotes))  Then
            Begin
              If Assigned(FcdsSaldoEPonRepPorLoc) Then
              Begin
                If (Not FcdsSaldoEPonRepPorLoc.Locate('LOCFIS', FLotes.FieldByName('LOCFIS').AsString, [])) Then
                Begin
                  FcdsSaldoEPonRepPorLoc.Insert;
                  FcdsSaldoEPonRepPorLoc.FieldByName('LOCFIS').AsString := FLotes.FieldByName('LOCFIS').AsString;
                  FcdsSaldoEPonRepPorLoc.FieldByName('QTDREP').AsFloat := FLotes.FieldByName('QTDREP').AsFloat;
                  FcdsSaldoEPonRepPorLoc.Post;
                End;
              End;

              FLotes.Edit;
              If fQtdDisponivel >= fltQtdItePed Then
              Begin
                FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('QTDITE').AsFloat + fltQtdItePed;
                fltQtdItePed := 0.00;

                if (fCfgSis('WMSMOV', varBoolean)) then
                begin
                  if (fQtdDisponivel = 0) then
                    blnForcaMovimentacaoProgramada := True
                  else
                  begin
                    if (fQtdDisponivel <= FLotes.FieldByName('QTDREP').AsFloat) then
                      blnForcaMovimentacaoProgramada := True;
                  end;
                end;
              End
              Else
              Begin
                fltQtdItePed := fltQtdItePed - fQtdDisponivel;
                FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('SALDIS').AsFloat;
              End;
              FLotes.Post;

            End;

            If fltQtdItePed = 0 then
              FLotes.Last;

            FLotes.Next;
          End;

          pVerificaSeFaraMovimentacaoProgramadaForcada(blnForcaMovimentacaoProgramada);

        End;

        //Caso nao conseguiu utilizar a quantidade do picking para
        //atender a venda, vai utilizar os lotes por data de validade
        If fltQtdItePed > 0 Then
        Begin
          FLotes.First;
          While Not FLotes.Eof Do
          Begin
            //Caso nao seja o Picking e possua saldo disponivel
            If (FLotes.FieldByName('PICKIN').AsString <> 'SIM') And
               (FLotes.FieldByName('TRANSI').AsString <> 'SIM') And
               (FLotes.FieldByName('BALCAO').AsString <> 'SIM') And
               (IIF(fCfgSis('WMSPRI', varBoolean), (FLotes.FieldByName('PRITIN').AsString <> 'S'), True)) And
               (fQtdDisponivel > 0) And
               (fLoteBrokerValido(FLotes)) Then
            Begin
              FLotes.Edit;

              If fQtdDisponivel >= fltQtdItePed Then
              Begin
                FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('QTDITE').AsFloat + fltQtdItePed;
                fltQtdItePed := 0.00;
              End
              Else
              Begin
                fltQtdItePed := fltQtdItePed - fQtdDisponivel;
                FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('SALDIS').AsFloat;
              End;

              FLotes.Post;
            End;
            FLotes.Next;
          End;
        End;

        //Caso nao conseguiu utilizar a quantidade do picking para
        //atender a venda e utilizou os lotes por data de validade
        //porem ainda possui quantidade pendente, entao também
        //utiliza a quantidade do picking para atender a venda
        If fltQtdItePed > 0 Then
        Begin
          FLotes.First;
          While Not FLotes.Eof Do
          Begin
            //Caso nao seja o Picking e possua saldo disponivel
            If (FLotes.FieldByName('PICKIN').AsString = 'SIM') And
               (FLotes.FieldByName('TRANSI').AsString <> 'SIM') And
               (FLotes.FieldByName('BALCAO').AsString <> 'SIM') And
               (IIF(fUsaPickingLaboratorioWms And blnPossuiLotePicLab, fFiltraLotesPickingLaboratorio, True)) And
               (IIF(fCfgSis('WMSPRI', varBoolean), (FLotes.FieldByName('PRITIN').AsString <> 'S'), True)) And
               (FLotes.FieldByName('SALDIS').AsFloat > 0) And
               (FLotes.FieldByName('QTDITE').AsFloat = 0) And
               (fLoteBrokerValido(FLotes)) Then
            Begin
              FLotes.Edit;

              If fQtdDisponivel >= fltQtdItePed Then
              Begin
                FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('QTDITE').AsFloat + fltQtdItePed;
                fltQtdItePed := 0.00;
              End
              Else
              Begin
                fltQtdItePed := fltQtdItePed - fQtdDisponivel;
                FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('SALDIS').AsFloat;
              End;

              FLotes.Post;
            End;
            FLotes.Next;
          End;
        End;
      End;

      pAtualizaTotalDigitado(cdsItePed.FieldByName('FDO_CODITE').AsString);

      If (fExecutarMovimentacaoProgramada(strIdentificacaoDoProduto)) Then
      Begin

        objMovimentacao := TMovimentacaoProgramadaPedido.Create(cdsItePed.FieldByName('FDO_SEQGER').AsString);
        objMovimentacao.pSetImpressaoDaSeparacao(blnExpedicao);

        try
          Try

            If objMovimentacao.fRealizaMovimentos(cdsItePed.FieldByName('FDO_CODITE').AsString, fltQtdItePendente) Then
            Begin
              pSetItemTemMovimentacaoDeLote;
              pAtualizaLoteItem(cdsItePed.FieldByName('FDO_CODITE').AsString,
                                cdsItePed.FieldByName('AUTOINCREM').AsString,
                                cdsItePed.FieldByName('FDO_NUMLOT').AsString,
                                '',
                                cdsItePed.FieldByName('FDO_QTDITE').AsFloat,
                                False,
                                '',
                                strIdentificacaoDoProduto);
              pAtualizaSaldosLotes;
              Continue;
            End;
          Except
            On E : ExceptionAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente Do
            Begin
              blnAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente := True;

              pSetItemTemMovimentacaoDeLote;
              pAtualizaLoteItem(cdsItePed.FieldByName('FDO_CODITE').AsString,
                                cdsItePed.FieldByName('AUTOINCREM').AsString,
                                cdsItePed.FieldByName('FDO_NUMLOT').AsString,
                                '',
                                fRetornaQuantidadeParcial,
                                False,
                                '',
                                strIdentificacaoDoProduto);
              pAtualizaSaldosLotes;

              If FModoSemMensagens Then
                pArmazenaMensagem(E.Message)
              else
                fMensagem('', E.Message, ['&Ok']);
              Continue;
            End;

            on E: ExceptionAutComNaoFoiPossivelIncluirMovimentacaoProgramada do
            begin
              If FModoSemMensagens Then
                pArmazenaMensagem(E.Message)
              else
                fMensagem('', E.Message, ['&Ok']);
            end;

            on E: ExceptionAutComErroAoIncluirMovimentacaoProgramada do
            begin
              If FModoSemMensagens Then
                pArmazenaMensagem(E.Message)
              else
                pMensagensErro(E.Message, '');
            end;

            On E : Exception Do
            Begin
              If FModoSemMensagens Then
                pArmazenaMensagem(E.Message)
              else
                fMensagem('', E.Message, ['&Ok']);
            End;
          End;
        finally
          FreeAndNil(objMovimentacao);
        end;
      End;

      cdsItePed.Next;
      blnAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente := False;
    End;
  Except
    on E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TDefineLotesWMS.pSelecionarLotesSugestao]');
    End;
  End;

  FLotes.IndexFieldNames := strIndexName;
  FLotes.Filtered := False;
  cdsItePed.EnableControls;
End;

procedure TDefineLotesWMS.pSelecionarLotesSugestaoOndaDeSeparacao(AItensOnda: TUniClientDataSet);
Var
  strIndexName                   : String;
  fltQtdItePed                   : Double;
  fltQtdItePendente              : Double;
  objMovimentacao                : TMovimentacaoProgramada;
  blnForcaMovimentacaoProgramada : boolean;
  qryOndaPD                      : TUniQuery;

  function fQtdDisponivel : double;
  begin
    Result := FLotes.FieldByName('SALDIS').AsFloat - FLotes.FieldByName('QTDITE').AsFloat;
  end;

  procedure pSetItemTemMovimentacaoDeLote;
  begin
    if (not AItensOnda.Locate('FDO_SEQGER; FDO_CODITE',
      VarArrayOf([qryOndaPD.FieldByName('FDO_SEQGER').AsString, qryOndaPD.FieldByName('FDO_CODITE').AsString]), [])) then
      Exit;

    AItensOnda.Edit;
    AItensOnda.FieldByName('TEM_MOVLOT').AsString := 'S';
    AItensOnda.Post;
  end;
Begin

  strIndexName := FLotes.IndexFieldNames;

  qryOndaPD := fCriaQuery;

  Try

    qryOndaPD.SQL.Clear;
    qryOndaPD.SQL.Add(fGetSqlItensOndaDeSeparacao(True, ''));
    qryOndaPD.Open;

    If qryOndaPD.IsEmpty Then
      Exit;

    Try

      qryOndaPD.First;

      blnForcaMovimentacaoProgramada := False;

      While Not qryOndaPD.Eof Do
      Begin

        pRegistraProgresso('Aguarde, Calculando quantidade sugerida ' + 'dos produtos... ', qryOndaPD.RecNo, qryOndaPD.RecordCount);

        fltQtdItePendente := qryOndaPD.FieldByName('FDO_QTDITE').AsFloat - fQuantidadeLotDorOndaDeSeparacao(qryOndaPD.FieldByName('FDO_CODITE').AsString);
        fltQtdItePed      := fltQtdItePendente;

        If fltQtdItePed = 0 Then
        Begin
          qryOndaPD.Next;
          Continue;
        End;

        FLotes.Filter   := 'CODITE = ' + QuotedStr(qryOndaPD.FieldByName('FDO_CODITE').AsString);
        FLotes.Filtered := True;

        FLotes.IndexFieldNames := RetornaIndexFieldNamesPrioridadesSugestaoOndaDeSeparacao(FLotes);

        {Com base nas configurações WMSLOT caso o item seja "ITE_LOTEPD = S" a quantidade
         "Sugerida" deve ser a própria quantidade informada no pedido!.}
        If fLoteDefinidoNoPedido(qryOndaPD.FieldByName('FDO_CODITE').AsString) And
           FLotes.Locate('NUMLOT', qryOndaPD.FieldByName('FDO_NUMLOT').AsString, []) Then
        Begin
          FLotes.Edit;
          FLotes.FieldByName('QTDITE').AsFloat := fltQtdItePed;
          FLotes.Post;
        End

        //Caso for tinta deve selecionar o lote principal para tinta de maquina
        Else If ((qryOndaPD.FieldByName('FDO_IDEPRO').AsString <> 'NOR') And (qryOndaPD.FieldByName('FDO_NUMLOT').AsString <> 'A DEFINIR')) Or  (qryOndaPD.FieldByName('FDO_PROACA').AsString = 'S') Then
        Begin
          If (Not FUsaWMSRastreavelTinta) Or
             (fTipoTinta(qryOndaPD.FieldByName('FDO_IDEPRO').AsString) <> ttImobiliaria) Then
          Begin
            If FLotes.Locate('NUMLOT', qryOndaPD.FieldByName('FDO_NUMLOT').AsString, []) Then
            Begin
              If fLoteBrokerValido(FLotes) Then
              Begin
                FLotes.Edit;
                FLotes.FieldByName('QTDITE').AsFloat := fltQtdItePed;
                FLotes.Post;
              End;
            End;
          End;
        End

        //Caso nao tenha quantidade ja digitada nos lotes
        Else If Not (FTemDig and fTemLoteDig(qryOndaPD))Then
        Begin
          //Caso o produto possua Picking e a quantidade seja suficiente para atender a venda utiliza o mesmo
          pCriaSaldoEPonRepPorLoc(FcdsSaldoEPonRepPorLoc);

          FLotes.First;
          While Not FLotes.Eof Do
          Begin
            blnForcaMovimentacaoProgramada := False;

            If (fltQtdItePed > 0) And
               (FLotes.FieldByName('PICKIN').AsString = 'SIM') And
               (IIF(fCfgSis('WMSPRI', varBoolean), (FLotes.FieldByName('PRITIN').AsString <> 'S'), True)) And
               (fQtdDisponivel > 0) And
               (fLoteBrokerValido(FLotes))  Then
            Begin
              If Assigned(FcdsSaldoEPonRepPorLoc) Then
              Begin
                If (Not FcdsSaldoEPonRepPorLoc.Locate('LOCFIS', FLotes.FieldByName('LOCFIS').AsString, [])) Then
                Begin
                  FcdsSaldoEPonRepPorLoc.Insert;
                  FcdsSaldoEPonRepPorLoc.FieldByName('LOCFIS').AsString := FLotes.FieldByName('LOCFIS').AsString;
                  FcdsSaldoEPonRepPorLoc.FieldByName('QTDREP').AsFloat := FLotes.FieldByName('QTDREP').AsFloat;
                  FcdsSaldoEPonRepPorLoc.Post;
                End;
              End;

              FLotes.Edit;
              If fQtdDisponivel >= fltQtdItePed Then
              Begin
                FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('QTDITE').AsFloat + fltQtdItePed;
                fltQtdItePed := 0.00;

                if (fCfgSis('WMSMOV', varBoolean)) then
                begin
                  if (fQtdDisponivel = 0) then
                    blnForcaMovimentacaoProgramada := True
                  else
                  begin
                    if (fQtdDisponivel <= FLotes.FieldByName('QTDREP').AsFloat) then
                      blnForcaMovimentacaoProgramada := True;
                  end;
                end;
              End
              Else
              Begin
                fltQtdItePed := fltQtdItePed - fQtdDisponivel;
                FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('SALDIS').AsFloat;
              End;
              FLotes.Post;

            End;

            If fltQtdItePed = 0 then
              FLotes.Last;

            FLotes.Next;
          End;

          pVerificaSeFaraMovimentacaoProgramadaForcada(blnForcaMovimentacaoProgramada);

          //Caso nao conseguiu utilizar a quantidade do picking para
          //atender a venda, vai utilizar os lotes por data de validade
          If fltQtdItePed > 0 Then
          Begin
            FLotes.First;
            While Not FLotes.Eof Do
            Begin
              //Caso nao seja o Picking e possua saldo disponivel
              If (FLotes.FieldByName('PICKIN').AsString <> 'SIM') And
                 (IIF(fCfgSis('WMSPRI', varBoolean), (FLotes.FieldByName('PRITIN').AsString <> 'S'), True)) And
                 (fQtdDisponivel > 0) And
                 (fLoteBrokerValido(FLotes)) Then
              Begin
                FLotes.Edit;

                If fQtdDisponivel >= fltQtdItePed Then
                Begin
                  FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('QTDITE').AsFloat + fltQtdItePed;
                  fltQtdItePed := 0.00;
                End
                Else
                Begin
                  fltQtdItePed := fltQtdItePed - fQtdDisponivel;
                  FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('SALDIS').AsFloat;
                End;

                FLotes.Post;
              End;
              FLotes.Next;
            End;
          End;

          //Caso nao conseguiu utilizar a quantidade do picking para
          //atender a venda e utilizou os lotes por data de validade
          //porem ainda possui quantidade pendente, entao também
          //utiliza a quantidade do picking para atender a venda
          If fltQtdItePed > 0 Then
          Begin
            FLotes.First;
            While Not FLotes.Eof Do
            Begin
              //Caso nao seja o Picking e possua saldo disponivel
              If (FLotes.FieldByName('PICKIN').AsString = 'SIM') And
                 (IIF(fCfgSis('WMSPRI', varBoolean), (FLotes.FieldByName('PRITIN').AsString <> 'S'), True)) And
                 (FLotes.FieldByName('SALDIS').AsFloat > 0) And
                 (FLotes.FieldByName('QTDITE').AsFloat = 0) And
                 (fLoteBrokerValido(FLotes)) Then
              Begin
                FLotes.Edit;

                If fQtdDisponivel >= fltQtdItePed Then
                Begin
                  FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('QTDITE').AsFloat + fltQtdItePed;
                  fltQtdItePed := 0.00;
                End
                Else
                Begin
                  fltQtdItePed := fltQtdItePed - fQtdDisponivel;
                  FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('SALDIS').AsFloat;
                End;

                FLotes.Post;
              End;
              FLotes.Next;
            End;
          End;
        End;

        if fCfgSis('WMSMOV', varBoolean) and  ((fltQtdItePed > 0) or (blnForcaMovimentacaoProgramada)) Then
        Begin
          objMovimentacao := TMovimentacaoProgramadaPedido.Create(qryOndaPD.FieldByName('FDO_SEQGER').AsString);
          objMovimentacao.pSetImpressaoDaSeparacao(blnExpedicao);
          try
            try
              If objMovimentacao.fRealizaMovimentos(qryOndaPD.FieldByName('FDO_CODITE').AsString, fltQtdItePendente) Then
              Begin
                pSetItemTemMovimentacaoDeLote;
                pAtualizaLoteItem(qryOndaPD.FieldByName('FDO_CODITE').AsString,
                                  qryOndaPD.FieldByName('AUTOINCREM').AsString,
                                  qryOndaPD.FieldByName('FDO_NUMLOT').AsString,
                                  '',
                                  qryOndaPD.FieldByName('FDO_QTDITE').AsFloat,
                                  False,
                                  '',
                                  qryOndaPD.FieldByName('FDO_IDEPRO').AsString);

                pAtualizaSaldosLotesOndaDeSeparacao;
                Continue;
              End;
            except
              on E : ExceptionAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente Do
              begin
                pSetItemTemMovimentacaoDeLote;
                pAtualizaLoteItem(qryOndaPD.FieldByName('FDO_CODITE').AsString,
                                  qryOndaPD.FieldByName('AUTOINCREM').AsString,
                                  qryOndaPD.FieldByName('FDO_NUMLOT').AsString,
                                  '',
                                  qryOndaPD.FieldByName('FDO_QTDITE').AsFloat,
                                  False,
                                  '',
                                  qryOndaPD.FieldByName('FDO_IDEPRO').AsString);

                pAtualizaSaldosLotesOndaDeSeparacao;
                fMensagem('Aviso', E.Message, ['&OK']);
                Continue;
              end;

              on E: ExceptionAutComNaoFoiPossivelIncluirMovimentacaoProgramada do
              begin
                fMensagem('Aviso', E.Message, ['&OK']);
              end;

              on E: ExceptionAutComErroAoIncluirMovimentacaoProgramada do
                pMensagensErro(E.Message, '');

              on E: Exception Do
                raise;
            end;
          finally
            FreeAndNil(objMovimentacao);
          end;
        End;

        qryOndaPD.Next;
      End;
    Except
      on E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TDefineLotesWMS.pSelecionarLotesSugestao]');
      End;
    End;
  Finally
    FreeAndNil(qryOndaPD);
    FLotes.IndexFieldNames := strIndexName;
    FLotes.Filtered := False;
  End;
End;

procedure TDefineLotesWMS.pRegistraProgresso(strMsg: String; intPos, intMax: Integer);
begin
  If Assigned(pgbProgresso) Then
  Begin
    pgbProgresso.Properties.Min := 0;
    pgbProgresso.Properties.Max := intMax;
    pgbProgresso.Position       := intPos;
  End;

  If Assigned(lblInformacao) Then
  Begin
    lblInformacao.Caption := Format('%s %d / %d',  [strMsg, intPos, intMax]);
  End;

  pProcessMessages;
end;

function TDefineLotesWMS.fGetSqlItensOndaDeSeparacao(blnAgrupar : Boolean;
                                                     strCodIte  : String = ''): String;
begin
  Result := AgrupamentoDeOndaDeSeparacao.Funcoes.GetSqlItensOndaDeSeparacao(FOndaDeSeparacao, blnAgrupar, strCodIte);
end;

function TDefineLotesWMS.fGetSqlItensPedido: String;
Var
  tintas    : ITintasDeMaquina;
  sqlSalDis : String;
begin
  sqlSalDis := EmptyStr;
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '  FDO_NUMDOC,       ';
  Result := Result + '  FDO_ESPDOC,       ';
  Result := Result + '  FDO_CODEMP,       ';
  Result := Result + '  FDO_EMPITE,       ';
  Result := Result + '  FDO_IDEPRO,       ';
  Result := Result + '  FDO_PROACA,       ';
  Result := Result + '  FDO_CODITE,       ';
  Result := Result + '  LOT_NUMLOT AS FDO_NUMLOT, ';
  Result := Result + '  FDO_REFERE,       ';
  Result := Result + '  UNI_SIGUNI,       ';
  Result := Result + '  CONCAT(FDO_DESCRI, ';
  Result := Result + '         IF(IFNULL(FDO_COMPLE, "") <> "", ';
  Result := Result + '            CONCAT(" - ", IFNULL(FDO_COMPLE, "")), "")) AS FDO_DESCRI, ';

  If (Not fEmptyStr(FCodIte)) or FLotSep Then
    Result := Result + ' FDO_QTDITE AS FDO_QTDITE, '
  Else
    Result := Result + ' (FDO_QTDITE - FDO_QTDBAI) AS FDO_QTDITE, ';

  Result := Result + '  (CASE  ';
  Result := Result + '      WHEN FDO_PROACA = "S" THEN ';
  Result := Result + '     A.ACA_SALDOS    ';
  Result := Result + '   ELSE ';
  Result := Result + '     I.ITE_SALDOS    ';
  Result := Result + '   END) AS ITE_SALDOS, ';

  Result := Result + '  C.ITE_CODITE,     ';
  Result := Result + '  C.ITE_CODBAR,     ';
  Result := Result + '  C.ITE_CODFAB,     ';
  Result := Result + '  C.ITE_LOTEPD,     ';

  case fCfgSis('CALSAL', varInteger) of
    1:sqlSalDis := ' (I.ITE_SALDOS - I.ITE_SALREG - I.ITE_QTPD_V - I.ITE_QTPD_E - I.ITE_QTPD_P) ';
    2:sqlSalDis := ' (I.ITE_SALDOS - I.ITE_SALREG - I.ITE_QTPD_V - I.ITE_QTPD_E - I.ITE_QTPD_P - I.ITE_QTEF_P - I.ITE_QTEF_F - I.ITE_QTEF_A) ';
    3:sqlSalDis := ' (I.ITE_SALDOS - I.ITE_SALREG - I.ITE_QTPD_V - I.ITE_QTPD_E - I.ITE_QTPD_P - I.ITE_QTEF_P - I.ITE_QTEF_A) ';
    4:sqlSalDis := ' (I.ITE_SALDOS - I.ITE_SALREG - I.ITE_QTPD_V - I.ITE_QTPD_E - I.ITE_QTPD_P - I.ITE_QTEF_F) ';
    5:sqlSalDis := ' (I.ITE_SALDOS - I.ITE_SALREG - I.ITE_QTPD_V - I.ITE_QTPD_E - I.ITE_QTPD_P - I.ITE_QTEF_P) ';
  end;

  Result := Result + '  (CASE  ';
  Result := Result + '      WHEN FDO_PROACA = "S" THEN ';
  Result := Result + '     A.ACA_SALDOS    ';
  Result := Result + '   ELSE ';
  Result := Result + sqlSalDis;
  Result := Result + '   END) AS SALDIS, ';

  Result := Result + '  IFNULL(LOT_NUMLOT, "A DEFINIR") AS NUMLOT, ';

  Result := Result + '  0 AS TEMLOT, '; // SE O ITEM POSSUI LOTE(S)

  Result := Result + '  FATGOR.FGO_ORIGEM,';

  Result := Result + '    IF((SELECT COUNT(0) FROM MOVLOT    ';
  Result := Result + '        WHERE MLT_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '          AND MLT_CODITE = FDO_CODITE  ';
  Result := Result + '          AND MLT_DTAREA IS NULL) = 0, "N", "S") AS TEM_MOVLOT, ';

  Result := Result + ' CASE ';
  Result := Result + '   WHEN FDO_ENTRET = "R" AND IFNULL(FDO_LOCRET, "") = ""   THEN "RETIRA" ';
  Result := Result + '   WHEN FDO_ENTRET = "R" AND IFNULL(FDO_LOCRET, "") = "C"  THEN "RETIRA CAIXA" ';
  Result := Result + '   WHEN FDO_ENTRET = "R" AND IFNULL(FDO_LOCRET, "") = "E"  THEN "RETIRA EXPEDIÇÃO" ';
  Result := Result + '   WHEN FDO_ENTRET = "E" AND IFNULL(FDO_ENTFUT,"N") = "S"  THEN "ENTREGA FUTURA" ';
  Result := Result + '   ELSE "ENTREGA IMEDIATA" ';
  Result := Result + ' END AS DESTINO, ';

  Result := Result + '  FGO_CODCLI,       ';
  Result := Result + '  FATDOR.AUTOINCREM,';
  Result := Result + '  FATDOR.FDO_SEQGER, ';
  Result := Result + '  0 AS SALCOR,       ';
  Result := Result + '  FDO_CODACA        ';
  Result := Result + 'FROM                ';
  Result := Result + '  FATDOR            ';
  Result := Result + '  INNER JOIN FATGOR   ON FATGOR.AUTOINCREM = FDO_SEQGER ';
  Result := Result + '  INNER JOIN EXTDOR   ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
  Result := Result + '  INNER JOIN CADITE C ON C.ITE_CODITE = FDO_CODITE ';
  Result := Result + '  INNER JOIN ITEGER I ON I.ITE_CODITE = FDO_CODITE AND I.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '  INNER JOIN CADUNI   ON   FDO_UNIDAD = UNI_CODUNI ';

  Result := Result + '  LEFT JOIN ACAGER A ON A.ACA_CODACA = FDO_CODACA ';
  Result := Result + '                    AND A.ACA_EMPEST = FDO_CODEMP ';
  Result := Result + '                    AND A.ACA_CODEMP = FDO_EMPACA ';
  Result := Result + '  LEFT JOIN CADLOT ON  LOT_CODITE = FDO_CODITE AND ';
  Result := Result + '                       LOT_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
  Result := Result + '                       IF(IFNULL(FDO_NUMLOT,"") <> "", LOT_NUMLOT = FDO_NUMLOT, ';

  if fCfgSis('TINWMS', varBoolean) Then
  Begin
    tintas := fGetTintasdeMaquina;
    Result := Result + ' IF((FDO_IDEPRO = "NOR" AND FDO_PROACA <> "S") OR (LOCATE(FDO_IDEPRO,"' + tintas.fGetImobiliarias + '") > 0) , ';
  End
  Else
    Result := Result + '                                                       IF(FDO_IDEPRO = "NOR" AND FDO_PROACA <> "S", ';
  Result := Result + '                                                         LOT_NUMLOT = "A DEFINIR", LOT_PRITIN = "S")) ';

  if FLotSep then
  begin
    Result := Result + 'INNER JOIN ROMLDE D ON (FGO_NUMDOC = D.RLD_NUMDOC AND FGO_ESPDOC = D.RLD_ESPDOC AND FGO_CODEMP = D.RLD_CODEMP) ';
    Result := Result + 'INNER JOIN ROMLGE G ON (D.RLD_SEQRLG = G.AUTOINCREM) ';
    Result := Result + 'WHERE ';
    Result := Result + '  G.RLG_NUMLOT = ' + QuotedStr(FCodLot) + ' AND ';
    Result := Result + '  G.RLG_CODEMP = ' + QuotedStr(FCodEmp) + ' AND ';
    if FblnSomenteSemLotes then
    begin
      Result := Result + '  NOT EXISTS (SELECT AUTOINCREM ';
      Result := Result + '                FROM LOTDOR ';
      Result := Result + '               WHERE LDO_SEQFDO = FATDOR.AUTOINCREM) AND ';
    end;
  end
  else
  begin
    Result := Result + 'WHERE               ';
    Result := Result + '  FGO_ESPDOC =  ' + QuotedStr(FEspPed) + ' AND ';
    Result := Result + '  FGO_NUMDOC =  ' + QuotedStr(FNumPed) + ' AND ';
    Result := Result + '  FGO_CODEMP =  ' + QuotedStr(FEmpPed) + ' AND ';
  end;

  If FEhDefinicaoDeLotesPickingCheckOut Then
    Result := Result + '  FDO_ENTRET = "R" AND IFNULL(FDO_LOCRET, "") = "C" AND ';

  If Not fEmptyStr(FCodIte) Then
    Result := Result + ' FATDOR.FDO_CODITE = ' + QuotedStr(FCodIte)
  Else
  Begin
    Result := Result + '  FDO_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' AND ';
    Result := Result + '  FDO_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + ' AND ';
    Result := Result + '  IFNULL(FDO_ENTFUT,"N") = "N" AND  ';
    Result := Result + '  IFNULL(FDO_PROEMB,"N") <> "S" ';
    if not FLotSep then
    begin
      Result := Result + '  AND FDO_QTDITE > FDO_QTDBAI AND ';
      Result := Result + '  FDO_JAFATU = 0 ';
    end;
  End;

  If fUsaRotinaExpedicaoConferenciaRetiraCaixa Then
  Begin
    If fCfgSis('EMPFAT', VarBoolean) Then
      Result := Result + '  AND FDO_EMPITE = "' + VS_strCodEmp + '" ';

    Result := Result + '  AND FDO_EXIBSE = "S" ';
    //Req 151661, se ja pegou entao ja definiu o lote no pedido nao precisa separar
    Result := Result + '  AND ( ';
    Result := Result + '    IFNULL(FDO_PEGOU_, "N") <> "S" ';
    Result := Result + '    OR IFNULL(FDO_NUMLOT, "A DEFINIR") = "A DEFINIR" ';
    Result := Result + '  ) ';
  End;

  If (Not FCodLseItens.IsEmpty) Then
    Result := Result + '  AND I.ITE_CODLSE = ' + QuotedStr(FCodLseItens);

  If (Not fEmptyStr(FAutIncTinta)) And FUsaWMSRastreavelTinta Then
    Result := Result + '  AND FATDOR.AUTOINCREM = ' + QuotedStr(FAutIncTinta);

  if FAtualizaPedCortado then
  begin
    Result := Result + '  HAVING FDO_QTDITE > IFNULL((SELECT SUM(LDO_QTDITE) FROM LOTDOR ';
    Result := Result + '                              WHERE LDO_SEQFDO = FATDOR.AUTOINCREM), 0) ';
  end;
end;

function TDefineLotesWMS.fSolicitaSeparadoresPorLocalDeSeparacao(strSenSep : String): Boolean;
  function fPedeSenhaOperador(strInfo: String): String;
    Var
      strSenha: String;
  begin
    If ffrmSenha(strSenha, strInfo) Then
      Result := fRetCodVendedor(strSenha);
  end;


  Var
    blnFiltered : Boolean;
    strChave : String;
    strSeparador : String;
Begin
  arrLseWms.Clear;
  blnFiltered := FLotes.Filtered;
  Try
    FLotes.DisableControls;
    FLotes.Filtered := False;
    FLotes.First;

    FLotes.First;
    While Not FLotes.Eof Do
    Begin
      If FLotes.FieldByName('QTDITE').AsFloat <= 0 Then
      Begin
        FLotes.Next;
        Continue;
      End;

      If fEmptyStr(FLotes.FieldByName('CODLSE').AsString) Then
      Begin
        FLotes.Edit;

        If Not fEmptyStr(FCodLseItens) Then
          FLotes.FieldByName('CODLSE').AsString := fGetLocalSeparacaoItem(FLotes.FieldByName('CODITE').AsString)
        Else
          FLotes.FieldByName('CODLSE').AsString := fGetLocalSeparacaoLocFis(FLotes.FieldByName('LOCFIS').AsString);

        FLotes.Post;
      End;

      If Not arrLseWms.ContainsKey(FLotes.FieldByName('CODLSE').AsString) Then
        arrLseWms.Add(FLotes.FieldByName('CODLSE').AsString, TRecLseWms.Create);

      arrLseWms.Items[FLotes.FieldByName('CODLSE').AsString].pAddLocFis(FLotes.FieldByName('LOCFIS').AsString);

      FLotes.Next;
    End;

    If arrLseWms.ContainsKey('') And FCodLseItens.IsEmpty Then
    Begin
      pMostraMensagem('Preencha o Local de Separação das sequintes Localizações Físicas: ' + #13 + arrLseWms.Items[''].fGetLocFis);
      Result := False;
      Exit;
    End;

    For strChave in arrLseWms.Keys Do
    Begin
      If strSenSep = 'S' Then
        strSeparador := fPedeSenhaOperador('Senha do separador para Local: ' + strChave + '-' + fRetLocSep(strChave) )
      Else
        strSeparador := TfrmDigOperador.fGetCodOperador( '', 'Separador para Local: ' + strChave + '-' + fRetLocSep(strChave) );

      If fEmptyStr(strSeparador) Then
      Begin
        Result := False;
        Exit;
      End;

      arrLseWms.Items[strChave].strCodSep := strSeparador;
    End;

    Result := True;
  Finally
    FLotes.Filtered := blnFiltered;
    FLotes.First;
    FLotes.EnableControls;
  End;

End;


function TDefineLotesWMS.fTemLoteDig(qryItePed: TUniQuery): Boolean;
Begin
  If Not FRecalcularQtdeItens Then
    Exit(True);

  Result := fQuantidadeLotDorOndaDeSeparacao(qryItePed.FieldByName('FDO_CODITE').AsString) = qryItePed.FieldByName('FDO_QTDITE').AsFloat;
End;

{ TRecLseWms }

constructor TRecLseWms.Create;
begin
  FCodSep := '';
  SetLength(FLocFis, 0);
  FillChar(FLocFis, SizeOf(TRecLseWms), #0);
end;

function TRecLseWms.fGetLocFis: String;
  Var
    intIndex : Integer;
begin
  Result := '';

  For intIndex := Low(FLocFis) to High(FLocFis) Do
  Begin
    Result := Result + FLocFis[intIndex];

    If intIndex < High(FLocFis) Then
      Result := Result + ', ';
  End;

end;

procedure TRecLseWms.pAddLocFis(strLocFis: String);
begin
  SetLength(FLocFis, Length(FLocFis)+1);
  FLocFis[High(FLocFis)] := strLocFis;
end;

function TDefineLotesWMS.fTemLoteDig(cdsItePed : TUniClientDataSet) : Boolean;
Begin
  If Not FRecalcularQtdeItens Then
    Exit(True);

  Result := (fQuantidadeLotDor(cdsItePed) = cdsItePed.FieldByName('FDO_QTDITE').AsFloat);
End;

function TDefineLotesWMS.fQuantidadeLotDor(cdsItePed : TUniClientDataSet) : Double;
  Var
    fltQtdLotDor : Double;
    cdsCloneLote : TUniClientDataSet;
Begin

  Try
    cdsCloneLote := TUniClientDataSet.Create(Nil);
    cdsCloneLote.CloneCursor(FLotes, False, True);

    cdsCloneLote.Filter   := 'AUTINC = ' + QuotedStr(cdsItePed.FieldByName('AUTOINCREM').AsString);

    cdsCloneLote.Filtered := True;
    fltQtdLotDor := 0;

    If (Not cdsCloneLote.IsEmpty) Then
    Begin
      cdsCloneLote.First;
      While not cdsCloneLote.Eof Do
      Begin
        fltQtdLotDor := fltQtdLotDor + cdsCloneLote.FieldByName('QTDITE').AsFloat;
        cdsCloneLote.Next;
      End;

      Result := fltQtdLotDor;
    End
    Else
      Result := 0;

  Finally
    FreeAndNil(cdsCloneLote);
  End;
End;

end.

