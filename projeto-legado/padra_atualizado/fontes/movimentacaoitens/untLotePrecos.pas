unit untLotePrecos;

interface

uses Classes, Uni, SysUtils, Variants, DB, untFuncoesSimples, UniClientDataSet,
  StrUtils, Forms, Windows, Math, untPedeCotacaoMoeda,untILiberacao, untLiberacaoFactory, untMsgLiberacao,
  untFatorPreco, untZClient, cxProgressBar, untParCalculaPrecoCusto,
  untPnlDadosAtivacaoLotePreco, untPanelCxAtivacaoLotePreco, untTGerenciaItegerPermiteEdicao;

type
  TLotePrecos = class(TComponent)
    private
      FZerLot,
      FOpcCalPreco,
      FMarIde: Boolean;
      FEhPedido: Boolean;
      FMarcar: Boolean;
      FNumDoc: String;
      FEspDoc: String;
      FSerie_: String;
      FCodEmp: String;
      FCodFor: String;
      FOpeRes: String;
      FstrTabela: String;
      FCasaDecimal: String;
      FArredondaPreco: Boolean;
      FArredondaPrecoEmLote: Boolean;
      FstlRes: TStringList;
      FPrcRdz : Boolean;
      FAlterandoMargemGeral: Boolean;

      FCotDol,
      FTotIte,
      FTotFre: Double;

      FFatPre: TFatorPreco;

      blnBloPre,
      FRecarregaPreco: Boolean;
      FRecarregaMargIdeal : Boolean;

      FCamposInfLot: TArrDefCam;
      FCamposPCusto: TArrDefCam;
      FCamposPVenda: TArrDefCam;
      FCamposTblPrc: TArrDefCam;
      FCamposDadSai: TArrDefCam;

      FCdsPrecos: TUniClientDataSet;

      FCdsPrecos1: TUniClientDataSet;
      FCdsPrecos2: TUniClientDataSet;
      FCdsPrecos3: TUniClientDataSet;

      pAfterScroll: TDataSetNotifyEvent;

      intDecimais: Integer;

      MSG_VALIDACAO_MARGEM: String;

      objLiberacao : ILiberacao;
      cpcParams: TParCalculaPrecoCusto;

      blnRecalcularMargemPrecoBeforePost: Boolean;
      blnTravamargem: Boolean;

      blnResLtp: Boolean;

      intOpcCarregaPreMed: Integer;

      FStrCodIteProcessando: String;

      Function fMarcaOpcCalculoPrg(pgbStatus: TcxProgressBar = Nil):Boolean;

      Function fRecarregaAtualPrg(pgbStatus: TcxProgressBar = Nil):Boolean;

      function fMontaSqlItensComum(AblnPedido: Boolean = False): String;
      Function fRetValorCdsPrecos(strNomCam: String): Double;

      function fCampoDatSet(Dataset: TDataSet; strCampo: String): TField;
      function fValidaMargemDataSet(Dataset: TDataSet; fltValor: Double; strTabPrc: String): Boolean;
      function fValidaMargemIdealDataSet(Dataset: TDataSet; fltValor: Double; strTabPrc: String): Boolean;

      Function fSelecionaItens(pgbStatus: TcxProgressBar = Nil):Boolean;

      procedure pSetOpeRes(Value: String);

      procedure pSetaCamposDefault;
      procedure pAddCampo(Var arrCampos: TArrDefCam; strNomCam, strDesCri: String; ftpTipCam: TFieldType; intTamCam: Integer; blnVisible: Boolean; strFormat: String);
      procedure pCriaCdsPrecos;
      procedure pIncluiPreIte(DataSet: TDataSet; dtaDtaAtu: TDateTime; strProPri: String);

      Procedure pAfterPost(dataSet: TDataSet);

      procedure pAtualizaLote(DataSet: TDataSet);
      procedure pAtualizaGrupoPrecosItem(DataSet: TDataSet);

      procedure pAddRegistroPreco(strTitulo,
                                  strNomCam,
                                  strDescri,
                                  strValAnt,
                                  strValAtu,
                                  strEmbAnt,
                                  strEmbAtu,
                                  strCamAlt: String;
                                  blnEfetivacao: Boolean = False;
                                  blnCusto: Boolean = False);

      procedure pBeforePost(DataSet: TDataSet);

      Procedure pAjustaPrecos(Dataset: TDataSet; strTabPrc: String);

      procedure pAlteraPreco(Dataset: TDataSet; intIndice: Integer; blnAlterouPreVen, blnAlterouMargem: Boolean);

      procedure pBaixarPedido(DataSet: TDataSet; strProPri: String; blnGeraPreIte: Boolean = False; dtaDtaAtu: TDateTime = 0);
      procedure pBaixarLote(DataSet: TDataSet; strProPri: String; blnGeraPreIte: Boolean = False; dtaDtaAtu: TDateTime = 0);
      Procedure pRecalculaItensPedido;
      Procedure pCalculaPrecoIdeal(Dataset: TDataSet);
      procedure SetQtdGrid(const Value: Integer);
      procedure pReplicaPrecoParaItens(Dataset, DataSetPrecos: TDataSet; blnRepeticaoValor:Boolean = False; blnExibeTelaDigValor: Boolean = False; fltValorASerReplicado: Double = 0; blnReplicaTabela: Boolean = False; intLinhaAtual: integer = -1);
      procedure pAdicionarListaSelecao(AStrAutInc: String);
      function fApagaReservaEnderecamento(DataSet: TDataSet): boolean;
      function fCarregaPreMedPrg(pgbProgresso: TCxProgressBar): Boolean;
    protected
      FintQtdGrid: Integer;
      GerenciaItegerPermiteEdicao : TGerenciaItegerPermiteEdicao;
      qryConsulta: TUniQuery;
      FTravarApenasNaTabelaDePrecoAlterada: Boolean;
      FstrTabPrc: string;
      procedure pSetCDSGrids;
    public
      blnFiltraResponsavel: Boolean;
      blnALTCVI: Boolean;
      strGrupoPrecoReplica: String;
      FEstado: String;
      FPerfil: String;
      fltCotAnt: Double;

      cdsConsulta: TZClient;
      stlListSelecao: TStringList;
      intUltimoSQLExec: Integer;
      blnAtualizaPrecomUti,
      blnValFor : Boolean;
      strItensComMargemNegativa: string;

      constructor Create(AOwner: TComponent); override;

      Destructor Destroy; override;
      procedure pSetCotDol(Value: Double);
      Procedure pRecalculaItensPedidoVendaComImpostos;
      function fCarregaDadosLotePreco(strNumDoc, strEspDoc, strCodEmp, strSerie_, strCodFor, stOpeRes : String): Boolean;

      Function fAbreConsulta(blnPedido: Boolean): Boolean;
      Function fMarcaOpcCalculo(blnPreco: Boolean): Boolean;
      Function fRecarregaAtual(blnPreco: Boolean; blnMargIdeal : Boolean = False): Boolean;

      Procedure pMarcaDesmarca;
      Procedure pMarcaTodos(blnMarcar: Boolean; blnPrcRdz: Boolean = False);
      Function fRecalculaItensPedido(pgbStatus: TcxProgressBar = Nil):Boolean;
      Function fRecalculaItensPedidoVenaComImpostos(pgbStatus: TcxProgressBar = Nil):Boolean;

      procedure pAfterOpenLotePrecos(DataSet: TDataSet);

      procedure pAtualizaCdsPrecos(DataSet: TDataSet; AStrCamAlt: String = ''; AfltValor: Double = 0);

      procedure pEnviaMensagemResponsavel;

      procedure pBaixarLotePrecos(DataSet: TDataSet; strProPri: String; blnGeraPreIte: Boolean = False; dtaDtaAtu: TDateTime = 0);
      procedure pGravarEfetivacaoPreco(DataSet: TDataSet);

      procedure pAtualizarDataValFornecedor(DataSet: TDataSet);

      function fTemProdutosEmDolar(FCodFor, FNumDoc, FEspDoc, FSerie_, FCodEmp: String; Var fltCotDol: Double): Boolean;
      Procedure pChecaDolarNoPedido(FNumDoc, FEspDoc, FCodEmp: String; Var infCotacao: TInfoCotacao; Var fltCotao: Double);

      function fPesquisarLotes(Form: TForm): Boolean;
      function fPesquisarPedidos(Form: TForm): Boolean;

      function fNotaConferida(strNumDoc, strEspDoc, strCodEmp, strSerie_, strCodFor : String): Boolean;

      function fMontaSqlItens(AblnPedido: Boolean = False): String;
      function fMontaSqlItensPedido(AblnPedido: Boolean = False): String;

      function fCalculaPrecoCusto(Dataset: TDataSet; blnBase: Boolean = False; fltPrecom: Double = -1): Double;

      procedure pAlterarPrecoMargem(blnChamadaOriginal: boolean; Dataset, DataSetPrecos: TDataSet; intFlagUtilizarNovoPreco: Integer = -1; AfltValor: Double =-1; AfltValAtu: Double = 0; blnExibeTelaDigValor:Boolean = True; fltValorASerReplicado: Double = 0; blnContinuaReplicacaoDeTabela: Boolean = False; ATravarApenasNaTabelaDePrecoAlterada: Boolean = False);

      function fCampoTemUti(ACamAlt: string): Boolean;

      Function fCalculaPrecoCompraBruto(fltPreLiq: Double;
                                        ArrDesFor: Array of Double): Double;

      function fCalculaValor(Dataset: TDataSet; intOpcao, intNroPre: Integer; fltPreVen, fltMarbru: Double): Double;
      function fValidaMargens: Boolean;
      Function fValidaMargensAux(pgbStatus: TcxProgressBar = Nil):Boolean;


      function fGravaLoteAlteracaoPrecoItem(strAutIncDet,
                                            strCodIte: String;
                                            fltPreComAnt,
                                            fltPreCom,
                                            fltDesF01Ant,
                                            fltDesF01,
                                            fltDesF02Ant,
                                            fltDesF02,
                                            fltDesF03Ant,
                                            fltDesF03,
                                            fltDesF04Ant,
                                            fltDesF04,
                                            fltDesF05Ant,
                                            fltDesF05,
                                            fltDesF06Ant,
                                            fltDesF06,
                                            fltIcmEntAnt,
                                            fltIcmEnt,
                                            fltSubFedAnt,
                                            fltSubFed,
                                            fltIpiEntAnt,
                                            fltIpiEnt,
                                            fltFreEntAnt,
                                            fltFreEnt,
                                            fltValFreAnt,
                                            fltValFre,
                                            fltAcrFinAnt,
                                            fltAcrFin,
                                            fltSubStiAnt,
                                            fltSubSti,
                                            fltDesAdbAnt,
                                            fltDesAdb,
                                            fltOutValAnt,
                                            fltOutVal,
                                            fltImpFedAnt,
                                            fltImpFed,
                                            fltDesOpeAnt,
                                            fltDesOpe,
                                            fltPreCusAnt,
                                            fltPreCus,
                                            fltIcmSaiAnt,
                                            fltIcmSai,
                                            fltMarBr1Ant,
                                            fltMarBr1,
                                            fltPreVe1Ant,
                                            fltPreVe1,
                                            fltComTb1Ant,
                                            fltComTb1,
                                            fltMarBr2Ant,
                                            fltMarBr2,
                                            fltPreVe2Ant,
                                            fltPreVe2,
                                            fltComTb2Ant,
                                            fltComTb2,
                                            fltMarBr3Ant,
                                            fltMarBr3,
                                            fltPreVe3Ant,
                                            fltPreVe3,
                                            fltComTb3Ant,
                                            fltComTb3,
                                            fltMarBr4Ant,
                                            fltMarBr4,
                                            fltPreVe4Ant,
                                            fltPreVe4,
                                            fltComTb4Ant,
                                            fltComTb4,
                                            fltMarBr5Ant,
                                            fltMarBr5,
                                            fltPreVe5Ant,
                                            fltPreVe5,
                                            fltComTb5Ant,
                                            fltComTb5,
                                            fltMarBr6Ant,
                                            fltMarBr6,
                                            fltPreVe6Ant,
                                            fltPreVe6,
                                            fltComTb6Ant,
                                            fltComTb6,
                                            fltMarBr7Ant,
                                            fltMarBr7,
                                            fltPreVe7Ant,
                                            fltPreVe7,
                                            fltComTb7Ant,
                                            fltComTb7,
                                            fltComLiq: Double;
                                            blnAltPre: Boolean;
                                            strAutIncLOTPRE: String = '';
                                            fltTCIFCu: Double = 0;
                                            fltTCIFCuAnt: Double = 0;
                                            fltTSCust: Double = 0;
                                            fltTSCustAnt: Double = 0;
                                            fltDePiCo: Double = 0;
                                            fltDePiCoAnt: Double = 0;
                                            fltDeICMS: Double = 0;
                                            fltDeICMSAnt: Double = 0;
                                            fltFatReg: Double = 0;
                                            fltFatRegAnt: Double = 0;
                                            strNaoHouveAlteracaoPrecoPorCausaItemNaoAceitaReducaoPreco: String = ''): Boolean;

      procedure pMensagemLotePrecoAtivar(intQtdIte: Integer; strDtaDoc: String);
      function fCarregaNota(strAutoincremGERELE, strAutoincremMOVGER: String): Boolean;
      function fCalculaPrecoVendaComImpostos(ACodIte: String; AEstado: String; APerfil: String; APreven: Double): Double;
      procedure pCarregaPreMedNaPreCom;

      const
      CAMPOSUTILIZAVARIACAO = 'DESF01_DESF02_DESF03_DESF04_DESF05_DESF06_ICMENT_SUBFED_IPIENT_ACRFIN_SUBSTI_DESADB_ICMSAI_IMPFED_DESOPE_';

    published
      property strNumDoc: String read FNumDoc write FNumDoc;
      property strEspDoc: String read FEspDoc write FEspDoc;
      property strSerie : String read FSerie_ write FSerie_;
      property strCodEmp: String read FCodEmp write FCodEmp;
      property strCodFor: String read FCodFor write FCodFor;
      property strOpeRes: String read FOpeRes write pSetOpeRes;
      property cdsPrecos: TUniClientDataSet read FCdsPrecos write FCdsPrecos;
      property cdsPrecos1: TUniClientDataSet read FCdsPrecos1 write FCdsPrecos1;
      property cdsPrecos2: TUniClientDataSet read FCdsPrecos2 write FCdsPrecos2;
      property cdsPrecos3: TUniClientDataSet read FCdsPrecos3 write FCdsPrecos3;
      property intQtdGrid: Integer read FintQtdGrid write SetQtdGrid;

      property strCasaDecimal: String read FCasaDecimal write FCasaDecimal;
      property blnArredondaPreco: Boolean read FArredondaPreco write FArredondaPreco;
      property blnArredondaPrecoEmLote: Boolean read FArredondaPrecoEmLote write FArredondaPrecoEmLote;
      property AlterandoMargemGeral: Boolean read FAlterandoMargemGeral write FAlterandoMargemGeral;


      property fltCotDol: Double read FCotDol;
  end;

implementation

uses  untMsgInterna, untFuncoes, untConsultas, untTypesSistema,
      untTConfiguracao, untGravando,
      untConstantes;

{ TLotePrecos }

constructor TLotePrecos.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTravarApenasNaTabelaDePrecoAlterada := False;
  FAlterandoMargemGeral := False;
  qryConsulta := fCriaQuery;
  intQtdGrid := 1;
  blnALTCVI := fCfgSis('ALTCVI', varBoolean);
  blnFiltraResponsavel := True;
  GerenciaItegerPermiteEdicao := TGerenciaItegerPermiteEdicao.Create;
  GerenciaItegerPermiteEdicao.pSetaEmpresa(VS_StrCodEmp, '');

  FCasaDecimal:= '0';
  FArredondaPreco:= False;
  FArredondaPrecoEmLote:= False;

  fltCotAnt := fGetUltimaCotacaoDolarVenda;

  blnRecalcularMargemPrecoBeforePost := True;

  FZerLot := fCfgSis('ZERLOT', varBoolean);

  blnBloPre := fCfgSis('BLOPRE', varBoolean);

  pAfterScroll := Nil;

  FTotIte := 0;
  FTotFre := 0;
  intUltimoSQLExec := 0;
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

  stlListSelecao := TStringList.Create;
  cdsConsulta    := TZClient.Create(Self, fMontaSqlItens);
  cdsConsulta.qryQuery.DataTypeMap.AddFieldNameRule('ITE_APLICA',TFieldType.ftString,3000);
  cdsConsulta.BeforePost := pBeforePost;

  intDecimais := fCfgSis('DECUNI', varInteger);
  FMarIde     := fCfgSis('MARIDE', varBoolean);
  blnValFor   := fCfgSis('VALFOR', VarBoolean);

  pSetaCamposDefault;
  pCriaCdsPrecos;

  FstlRes := TStringList.Create;
  FstlRes.Sorted := True;
  FstlRes.Duplicates := dupIgnore;

  MSG_VALIDACAO_MARGEM := 'A soma do ( ICMS Saída + Impostos Federais + ' +
                          'Despesas Operacionais + Margem Bruta ' +
                          IIF(fCfgSis('PCMPRO') <> '1',IIF(fCfgSis('PCMPRO') = '2', '+ Comissão ','+ ' + fCfgSis('TCOMTB')),'') +
                          '  ) não pode ser superior a 100%.';

  If fCfgSis('FATPRE', varBoolean) Then
    FFatPre := TFatorPreco.Create
  Else
    FFatPre := Nil;

  blnResLtp := fCfgSis('RESLTP', varBoolean);
end;

Destructor TLotePrecos.Destroy;
Begin
  If Assigned(FFatPre) Then
    FreeAndNil(FFatPre);

  If Assigned(FstlRes) Then
    FreeAndNil(FstlRes);

  FreeAndNil(GerenciaItegerPermiteEdicao);
  FreeAndNil(qryConsulta);
  FreeAndNil(stlListSelecao);

  FreeAndNil(cpcParams);

  Inherited;
End;

Function TLotePrecos.fCalculaPrecoCompraBruto(fltPreLiq: Double;
                                              ArrDesFor: Array Of Double): Double;
  Var
    intContador: Integer;
Begin
  Result := fltPreLiq;
  For intContador := High(ArrDesFor) Downto Low(ArrDesFor) Do
    Result := Result / (1 - ArrDesFor[intContador] / 100);

  Result := RoundTo(Result, -intDecimais);
End;

function TLotePrecos.fGravaLoteAlteracaoPrecoItem(strAutIncDet,
                                                  strCodIte: String;
                                                  fltPreComAnt,
                                                  fltPreCom,
                                                  fltDesF01Ant,
                                                  fltDesF01,
                                                  fltDesF02Ant,
                                                  fltDesF02,
                                                  fltDesF03Ant,
                                                  fltDesF03,
                                                  fltDesF04Ant,
                                                  fltDesF04,
                                                  fltDesF05Ant,
                                                  fltDesF05,
                                                  fltDesF06Ant,
                                                  fltDesF06,
                                                  fltIcmEntAnt,
                                                  fltIcmEnt,
                                                  fltSubFedAnt,
                                                  fltSubFed,
                                                  fltIpiEntAnt,
                                                  fltIpiEnt,
                                                  fltFreEntAnt,
                                                  fltFreEnt,
                                                  fltValFreAnt,
                                                  fltValFre,
                                                  fltAcrFinAnt,
                                                  fltAcrFin,
                                                  fltSubStiAnt,
                                                  fltSubSti,
                                                  fltDesAdbAnt,
                                                  fltDesAdb,
                                                  fltOutValAnt,
                                                  fltOutVal,
                                                  fltImpFedAnt,
                                                  fltImpFed,
                                                  fltDesOpeAnt,
                                                  fltDesOpe,
                                                  fltPreCusAnt,
                                                  fltPreCus,
                                                  fltIcmSaiAnt,
                                                  fltIcmSai,
                                                  fltMarBr1Ant,
                                                  fltMarBr1,
                                                  fltPreVe1Ant,
                                                  fltPreVe1,
                                                  fltComTb1Ant,
                                                  fltComTb1,
                                                  fltMarBr2Ant,
                                                  fltMarBr2,
                                                  fltPreVe2Ant,
                                                  fltPreVe2,
                                                  fltComTb2Ant,
                                                  fltComTb2,
                                                  fltMarBr3Ant,
                                                  fltMarBr3,
                                                  fltPreVe3Ant,
                                                  fltPreVe3,
                                                  fltComTb3Ant,
                                                  fltComTb3,
                                                  fltMarBr4Ant,
                                                  fltMarBr4,
                                                  fltPreVe4Ant,
                                                  fltPreVe4,
                                                  fltComTb4Ant,
                                                  fltComTb4,
                                                  fltMarBr5Ant,
                                                  fltMarBr5,
                                                  fltPreVe5Ant,
                                                  fltPreVe5,
                                                  fltComTb5Ant,
                                                  fltComTb5,
                                                  fltMarBr6Ant,
                                                  fltMarBr6,
                                                  fltPreVe6Ant,
                                                  fltPreVe6,
                                                  fltComTb6Ant,
                                                  fltComTb6,
                                                  fltMarBr7Ant,
                                                  fltMarBr7,
                                                  fltPreVe7Ant,
                                                  fltPreVe7,
                                                  fltComTb7Ant,
                                                  fltComTb7,
                                                  fltComLiq: Double;
                                                  blnAltPre: Boolean;
                                                  strAutIncLOTPRE: String = '';
                                                  fltTCIFCu: Double = 0;
                                                  fltTCIFCuAnt: Double = 0;
                                                  fltTSCust: Double = 0;
                                                  fltTSCustAnt: Double = 0;
                                                  fltDePiCo: Double = 0;
                                                  fltDePiCoAnt: Double = 0;
                                                  fltDeICMS: Double = 0;
                                                  fltDeICMSAnt: Double = 0;
                                                  fltFatReg: Double = 0;
                                                  fltFatRegAnt: Double = 0;
                                                  strNaoHouveAlteracaoPrecoPorCausaItemNaoAceitaReducaoPreco: String = ''
                                                  ): Boolean;
  var
    qryInsert: TUniQuery;

    procedure pRecalculaMargem;
    Begin
      fltMarBr1 := fCalculaPrecoVenda(2,
                                      fltPreCus + fltOutVal,
                                      qryInsert.FieldByName('LTP_PREVE1').AsFloat,
                                      0,
                                      fltIcmSai,
                                      fltImpFed,
                                      fltDesOpe,
                                      fltComTb1);

      fltMarBr2 := fCalculaPrecoVenda(2,
                                      fltPreCus + fltOutVal,
                                      qryInsert.FieldByName('LTP_PREVE2').AsFloat,
                                      0,
                                      fltIcmSai,
                                      fltImpFed,
                                      fltDesOpe,
                                      fltComTb2);

      fltMarBr3 := fCalculaPrecoVenda(2,
                                      fltPreCus + fltOutVal,
                                      qryInsert.FieldByName('LTP_PREVE3').AsFloat,
                                      0,
                                      fltIcmSai,
                                      fltImpFed,
                                      fltDesOpe,
                                      fltComTb3);

      fltMarBr4 := fCalculaPrecoVenda(2,
                                      fltPreCus + fltOutVal,
                                      qryInsert.FieldByName('LTP_PREVE4').AsFloat,
                                      0,
                                      fltIcmSai,
                                      fltImpFed,
                                      fltDesOpe,
                                      fltComTb4);

      fltMarBr5 := fCalculaPrecoVenda(2,
                                      fltPreCus + fltOutVal,
                                      qryInsert.FieldByName('LTP_PREVE5').AsFloat,
                                      0,
                                      fltIcmSai,
                                      fltImpFed,
                                      fltDesOpe,
                                      fltComTb5);

      fltMarBr6 := fCalculaPrecoVenda(2,
                                      fltPreCus + fltOutVal,
                                      qryInsert.FieldByName('LTP_PREVE6').AsFloat,
                                      0,
                                      fltIcmSai,
                                      fltImpFed,
                                      fltDesOpe,
                                      fltComTb6);

      fltMarBr7 := fCalculaPrecoVenda(2,
                                      fltPreCus + fltOutVal,
                                      qryInsert.FieldByName('LTP_PREVE7').AsFloat,
                                      0,
                                      fltIcmSai,
                                      fltImpFed,
                                      fltDesOpe,
                                      fltComTb7);
    End;

begin

  Try

    qryInsert := fCriarQuery('SELECT * FROM LOTPRE WHERE FALSE', Self);
    qryInsert.Open;

    qryInsert.Append;

    If strAutIncLOTPRE.IsEmpty Then
      qryInsert.FieldByName('AUTOINCREM').AsString    := fRetAutoIncrem('LOTPRE', VS_strCodEmp)
    Else
      qryInsert.FieldByName('AUTOINCREM').AsString    := strAutIncLOTPRE;

    qryInsert.FieldByName('LTP_NUMDOC').AsString    := FNumDoc;
    qryInsert.FieldByName('LTP_ESPDOC').AsString    := FEspDoc;
    qryInsert.FieldByName('LTP_SERIE_').AsString    := FSerie_;
    qryInsert.FieldByName('LTP_CODFOR').AsString    := FCodFor;
    qryInsert.FieldByName('LTP_CODEMP').AsString    := FCodEmp;

    If fEmptyStr(FOpeRes) Then
      qryInsert.FieldByName('LTP_OPERES').Value := Null
    Else
      qryInsert.FieldByName('LTP_OPERES').AsString  := FOpeRes;

    qryInsert.FieldByName('LTP_SEQDET').AsString    := strAutIncDet;
    qryInsert.FieldByName('LTP_CODITE').AsString    := strCodIte;

    qryInsert.FieldByName('LTP_DTAENT').AsDateTime  := VS_Date;
    qryInsert.FieldByName('LTP_HORENT').AsDateTime  := fTime();

    qryInsert.FieldByName('LTP_ATUALI').AsString    := 'N';
    qryInsert.FieldByName('LTP_DTAATU').Value       := Null;

    qryInsert.FieldByName('LTP_BAIXAD').AsString    := 'N';
    qryInsert.FieldByName('LTP_DTABAI').Value       := Null;
    qryInsert.FieldByName('LTP_HORBAI').Value       := Null;
    qryInsert.FieldByName('LTP_OPEBAI').Value       := Null;

    qryInsert.FieldByName('LTP_PRECOM_ANT').AsFloat :=  fltPreComAnt;
    qryInsert.FieldByName('LTP_PRECOM').AsFloat     :=  fltPreCom;

    qryInsert.FieldByName('LTP_COMLIQ_ANT').AsFloat :=  untFuncoesSimples.fCalculaPrecoCompraLiq(fltPreComAnt,
                                                         fltDesF01Ant, fltDesF02Ant, fltDesF03Ant,
                                                         fltDesF04Ant, fltDesF05Ant, fltDesF06Ant);

    qryInsert.FieldByName('LTP_COMLIQ').AsFloat     :=  fltComLiq;


    qryInsert.FieldByName('LTP_DESF01_ANT').AsFloat :=  fltDesF01Ant;
    qryInsert.FieldByName('LTP_DESF01').AsFloat     :=  fltDesF01;

    qryInsert.FieldByName('LTP_DESF02_ANT').AsFloat :=  fltDesF02Ant;
    qryInsert.FieldByName('LTP_DESF02').AsFloat     :=  fltDesF02;

    qryInsert.FieldByName('LTP_DESF03_ANT').AsFloat :=  fltDesF03Ant;
    qryInsert.FieldByName('LTP_DESF03').AsFloat     :=  fltDesF03;

    qryInsert.FieldByName('LTP_DESF04_ANT').AsFloat :=  fltDesF04Ant;
    qryInsert.FieldByName('LTP_DESF04').AsFloat     :=  fltDesF04;

    qryInsert.FieldByName('LTP_DESF05_ANT').AsFloat :=  fltDesF05Ant;
    qryInsert.FieldByName('LTP_DESF05').AsFloat     :=  fltDesF05;

    qryInsert.FieldByName('LTP_DESF06_ANT').AsFloat :=  fltDesF06Ant;
    qryInsert.FieldByName('LTP_DESF06').AsFloat     :=  fltDesF06;

    qryInsert.FieldByName('LTP_ICMENT_ANT').AsFloat :=  fltIcmEntAnt;
    qryInsert.FieldByName('LTP_ICMENT').AsFloat     :=  fltIcmEnt;

    qryInsert.FieldByName('LTP_SUBFED_ANT').AsFloat :=  fltSubFedAnt;
    qryInsert.FieldByName('LTP_SUBFED').AsFloat     :=  fltSubFed;

    qryInsert.FieldByName('LTP_IPIENT_ANT').AsFloat :=  fltIpiEntAnt;
    qryInsert.FieldByName('LTP_IPIENT').AsFloat     :=  fltIpiEnt;

    qryInsert.FieldByName('LTP_FREENT_ANT').AsFloat :=  fltFreEntAnt;
    qryInsert.FieldByName('LTP_FREENT').AsFloat     :=  fltFreEnt;

    qryInsert.FieldByName('LTP_VALFRE_ANT').AsFloat :=  fltValFreAnt;
    qryInsert.FieldByName('LTP_VALFRE').AsFloat     :=  fltValFre;

    qryInsert.FieldByName('LTP_ACRFIN_ANT').AsFloat :=  fltAcrFinAnt;
    qryInsert.FieldByName('LTP_ACRFIN').AsFloat     :=  fltAcrFin;

    qryInsert.FieldByName('LTP_SUBSTI_ANT').AsFloat :=  fltSubStiAnt;
    qryInsert.FieldByName('LTP_SUBSTI').AsFloat     :=  fltSubSti;

    qryInsert.FieldByName('LTP_DESADB_ANT').AsFloat :=  fltDesAdbAnt;
    qryInsert.FieldByName('LTP_DESADB').AsFloat     :=  fltDesAdb;

    qryInsert.FieldByName('LTP_OUTVAL_ANT').AsFloat :=  fltOutValAnt;
    qryInsert.FieldByName('LTP_OUTVAL').AsFloat     :=  fltOutVal;

    qryInsert.FieldByName('LTP_IMPFED_ANT').AsFloat :=  fltImpFedAnt;
    qryInsert.FieldByName('LTP_IMPFED').AsFloat     :=  fltImpFed;

    qryInsert.FieldByName('LTP_DESOPE_ANT').AsFloat :=  fltDesOpeAnt;
    qryInsert.FieldByName('LTP_DESOPE').AsFloat     :=  fltDesOpe;

    qryInsert.FieldByName('LTP_PRECUS_ANT').AsFloat :=  fltPreCusAnt;
    qryInsert.FieldByName('LTP_PRECUS').AsFloat     :=  fltPreCus;

    qryInsert.FieldByName('LTP_ICMSAI_ANT').AsFloat :=  fltIcmSaiAnt;
    qryInsert.FieldByName('LTP_ICMSAI').AsFloat     :=  fltIcmSai;

    qryInsert.FieldByName('LTP_PREVE1_ANT').AsFloat :=  fltPreVe1Ant;
    qryInsert.FieldByName('LTP_PREVE1').AsFloat     :=  IIF(blnAltPre, fltPreVe1, fltPreVe1Ant);

    qryInsert.FieldByName('LTP_COMTB1_ANT').AsFloat :=  fltComTb1Ant;
    qryInsert.FieldByName('LTP_COMTB1').AsFloat     :=  fltComTb1;

    qryInsert.FieldByName('LTP_PREVE2_ANT').AsFloat :=  fltPreVe2Ant;
    qryInsert.FieldByName('LTP_PREVE2').AsFloat     :=  IIF(blnAltPre, fltPreVe2, fltPreVe2Ant);

    qryInsert.FieldByName('LTP_COMTB2_ANT').AsFloat :=  fltComTb2Ant;
    qryInsert.FieldByName('LTP_COMTB2').AsFloat     :=  fltComTb2;

    qryInsert.FieldByName('LTP_PREVE3_ANT').AsFloat :=  fltPreVe3Ant;
    qryInsert.FieldByName('LTP_PREVE3').AsFloat     :=  IIF(blnAltPre, fltPreVe3, fltPreVe3Ant);

    qryInsert.FieldByName('LTP_COMTB3_ANT').AsFloat :=  fltComTb3Ant;
    qryInsert.FieldByName('LTP_COMTB3').AsFloat     :=  fltComTb3;

    qryInsert.FieldByName('LTP_PREVE4_ANT').AsFloat :=  fltPreVe4Ant;
    qryInsert.FieldByName('LTP_PREVE4').AsFloat     :=  IIF(blnAltPre, fltPreVe4, fltPreVe4Ant);

    qryInsert.FieldByName('LTP_COMTB4_ANT').AsFloat :=  fltComTb4Ant;
    qryInsert.FieldByName('LTP_COMTB4').AsFloat     :=  fltComTb4;

    qryInsert.FieldByName('LTP_PREVE5_ANT').AsFloat :=  fltPreVe5Ant;
    qryInsert.FieldByName('LTP_PREVE5').AsFloat     :=  IIF(blnAltPre, fltPreVe5, fltPreVe5Ant);

    qryInsert.FieldByName('LTP_COMTB5_ANT').AsFloat :=  fltComTb5Ant;
    qryInsert.FieldByName('LTP_COMTB5').AsFloat     :=  fltComTb5;

    qryInsert.FieldByName('LTP_PREVE6_ANT').AsFloat :=  fltPreVe6Ant;
    qryInsert.FieldByName('LTP_PREVE6').AsFloat     :=  IIF(blnAltPre, fltPreVe6, fltPreVe6Ant);

    qryInsert.FieldByName('LTP_COMTB6_ANT').AsFloat :=  fltComTb6Ant;
    qryInsert.FieldByName('LTP_COMTB6').AsFloat     :=  fltComTb6;

    qryInsert.FieldByName('LTP_PREVE7_ANT').AsFloat :=  fltPreVe7Ant;
    qryInsert.FieldByName('LTP_PREVE7').AsFloat     :=  IIF(blnAltPre, fltPreVe7, fltPreVe7Ant);

    qryInsert.FieldByName('LTP_COMTB7_ANT').AsFloat :=  fltComTb7Ant;
    qryInsert.FieldByName('LTP_COMTB7').AsFloat     :=  fltComTb7;

    If (Not blnAltPre) Then
      pRecalculaMargem;

    qryInsert.FieldByName('LTP_MARBR1_ANT').AsFloat :=  fltMarBr1Ant;
    qryInsert.FieldByName('LTP_MARBR1').AsFloat     :=  fltMarBr1;

    qryInsert.FieldByName('LTP_MARBR2_ANT').AsFloat :=  fltMarBr2Ant;
    qryInsert.FieldByName('LTP_MARBR2').AsFloat     :=  fltMarBr2;

    qryInsert.FieldByName('LTP_MARBR3_ANT').AsFloat :=  fltMarBr3Ant;
    qryInsert.FieldByName('LTP_MARBR3').AsFloat     :=  fltMarBr3;

    qryInsert.FieldByName('LTP_MARBR4_ANT').AsFloat :=  fltMarBr4Ant;
    qryInsert.FieldByName('LTP_MARBR4').AsFloat     :=  fltMarBr4;

    qryInsert.FieldByName('LTP_MARBR5_ANT').AsFloat :=  fltMarBr5Ant;
    qryInsert.FieldByName('LTP_MARBR5').AsFloat     :=  fltMarBr5;

    qryInsert.FieldByName('LTP_MARBR6_ANT').AsFloat :=  fltMarBr6Ant;
    qryInsert.FieldByName('LTP_MARBR6').AsFloat     :=  fltMarBr6;

    qryInsert.FieldByName('LTP_MARBR7_ANT').AsFloat :=  fltMarBr7Ant;
    qryInsert.FieldByName('LTP_MARBR7').AsFloat     :=  fltMarBr7;

    qryInsert.FieldByName('LTP_TCIFCU_ANT').AsFloat :=  fltTCIFCuAnt;
    qryInsert.FieldByName('LTP_TCIFCU').AsFloat     :=  fltTCIFCu;

    qryInsert.FieldByName('LTP_TSCUST_ANT').AsFloat :=  fltTSCustAnt;
    qryInsert.FieldByName('LTP_TSCUST').AsFloat     :=  fltTSCust;

    qryInsert.FieldByName('LTP_DEPICO_ANT').AsFloat :=  fltDePiCoAnt;
    qryInsert.FieldByName('LTP_DEPICO').AsFloat     :=  fltDePiCo;

    qryInsert.FieldByName('LTP_DEICMS_ANT').AsFloat :=  fltDeICMSAnt;
    qryInsert.FieldByName('LTP_DEICMS').AsFloat     :=  fltDeICMS;

    qryInsert.FieldByName('LTP_FATREG_ANT').AsFloat :=  fltFatRegAnt;
    qryInsert.FieldByName('LTP_FATREG').AsFloat     :=  fltFatReg;

    qryInsert.FieldByName('LTP_RPRENT').AsString    :=  strNaoHouveAlteracaoPrecoPorCausaItemNaoAceitaReducaoPreco;

    qryInsert.Post;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(qryInsert);

end;

procedure TLotePrecos.pAddCampo(Var arrCampos: TArrDefCam; strNomCam, strDesCri: String;
  ftpTipCam: TFieldType; intTamCam: Integer; blnVisible: Boolean;
  strFormat: String);
begin
  SetLength(arrCampos, Length(arrCampos) + 1);
  arrCampos[Length(arrCampos) - 1].strNomCam  := strNomCam;
  arrCampos[Length(arrCampos) - 1].strDesCri  := strDesCri;
  arrCampos[Length(arrCampos) - 1].strFormat  := strFormat;
  arrCampos[Length(arrCampos) - 1].ftpTipCam  := ftpTipCam;
  arrCampos[Length(arrCampos) - 1].intTamCam  := intTamCam;
  arrCampos[Length(arrCampos) - 1].blnVisible := blnVisible;
end;

procedure TLotePrecos.pAddRegistroPreco(strTitulo, strNomCam, strDescri, strValAnt,
  strValAtu, strEmbAnt, strEmbAtu, strCamAlt: String; blnEfetivacao: Boolean = False; blnCusto: Boolean = False);
begin
  FCdsPrecos.Append;
  FCdsPrecos.FieldByName('TITULO').AsString := strTitulo;
  FCdsPrecos.FieldByName('NOMCAM').AsString := strNomCam;
  FCdsPrecos.FieldByName('DESCRI').AsString := strDescri;
  FCdsPrecos.FieldByName('VALANT').AsString := strValAnt;
  FCdsPrecos.FieldByName('VALATU').AsString := strValAtu;
  FCdsPrecos.FieldByName('EMBANT').AsString := strEmbAnt;
  FCdsPrecos.FieldByName('EMBATU').AsString := strEmbAtu;
  FCdsPrecos.FieldByName('CAMALT').AsString := strCamAlt;
  If blnCusto Then
    blnCusto := Pos(strNomCam, '_LTP_PREDOL_LTP_COMLIQ_LTP_PRECUS_ITE_CUSREA') = 0;

  If blnCusto Then
    FCdsPrecos.FieldByName('UTILIZ').AsInteger:= IIf(blnEfetivacao, 1, 0)
  Else
    FCdsPrecos.FieldByName('UTILIZ').Clear;

  FCdsPrecos.FieldByName('CCUSTO').AsBoolean := blnCusto;

  FCdsPrecos.Post;
end;

procedure TLotePrecos.pAfterOpenLotePrecos(DataSet: TDataSet);

  procedure pAtribuiInformacoesCampo(arrCampos: TArrDefCam);
    var
      intCont: Integer;
  begin
    For intCont := 0 To Length(arrCampos) -1 Do
      With arrCampos[intCont] Do
      Begin
        If DataSet.FindField(strNomCam) <> nil Then
        Begin
          DataSet.FindField(strNomCam).DisplayLabel := strDesCri;
          DataSet.FindField(strNomCam).Visible      := blnVisible;

          If DataSet.FindField(strNomCam).DataType = ftFloat Then
            TFloatField(DataSet.FindField(strNomCam)).DisplayFormat := strFormat;
        End;
        If DataSet.FindField(arrCampos[intCont].strNomCam + '_UTI') <> nil Then
        Begin
          If DataSet.FindField(strNomCam + '_UTI').DataType = ftFloat Then
            TFloatField(DataSet.FindField(strNomCam + '_UTI')).DisplayFormat := arrCampos[intCont].strFormat;
        End;

        If DataSet.FindField(arrCampos[intCont].strNomCam + '_ATU') <> nil Then
        Begin
          If DataSet.FindField(strNomCam + '_ATU').DataType = ftFloat Then
            TFloatField(DataSet.FindField(strNomCam + '_ATU')).DisplayFormat := arrCampos[intCont].strFormat;
        End;

      End;

  end;

begin
  pAtribuiInformacoesCampo(FCamposInfLot);
  pAtribuiInformacoesCampo(FCamposPCusto);
  pAtribuiInformacoesCampo(FCamposPVenda);
  pAtribuiInformacoesCampo(FCamposTblPrc);
  pAtribuiInformacoesCampo(FCamposDadSai);

  DataSet.AfterPost := pAfterPost;
end;

procedure TLotePrecos.pEnviaMensagemResponsavel;
  var
    intCont: Integer;
    msgMensagem : TMsgInterna;
    stlMensagem : TStringList;
begin
  msgMensagem := TMsgInterna.Create(Self);
  stlMensagem := TStringList.Create;

  stlMensagem.Clear;
  stlMensagem.Add('EMISSÃO: '    + DateToStr(VS_Date));
  stlMensagem.Add('DOCUMENTO: '  + FNumDoc);
  stlMensagem.Add('ESPECIE: '    + FEspDoc);
  stlMensagem.Add('SERIE: '      + FSerie_);
  stlMensagem.Add('FORNECEDOR: ' + FCodFor + '-' + fRetNomFornecedor(FCodFor));

  For intCont := 0 To FstlRes.Count -1 Do
  Begin
    msgMensagem.fEnviaMensagem('NOVO LOTE DE PRECOS (' + FNumDoc + '-' + FEspDoc + ')',
      stlMensagem.Text, strLoginUsuarioLogado, FstlRes[intCont], 'N', '');
  End;

  FreeAndNil(msgMensagem);
  FreeAndNil(stlMensagem);

end;

procedure TLotePrecos.pGravarEfetivacaoPreco(DataSet: TDataSet);
var
  qryGeral: TUniQuery;
begin
  qryGeral := fCriaQuery(Self);
  Try
    qryGeral.SQL.Add(' UPDATE ' + DataSet.FieldByName('TABELA').AsString + ' SET ');
    qryGeral.SQL.Add('   LTP_DTAEFE = :DTABAI, ');
    qryGeral.SQL.Add('   LTP_HOREFE = :HORBAI, ');
    qryGeral.SQL.Add('   LTP_OPEEFE = :OPEBAI ');
    qryGeral.SQL.Add(' WHERE ');
    qryGeral.SQL.Add('   AUTOINCREM = :AUTINC  ');
    qryGeral.ParamByName('AUTINC').AsString := DataSet.FieldByName('AUTOINCREM').AsString;
    qryGeral.ParamByName('DTABAI').AsDate   := VS_Date;
    qryGeral.ParamByName('HORBAI').AsTime   := fTime();
    qryGeral.ParamByName('OPEBAI').AsString := strLoginUsuarioLogado;
    qryGeral.ExecSQL;
  Finally
    FreeAndNil(qryGeral);
  End;
end;

procedure TLotePrecos.pSetaCamposDefault;
  Var
    intCont: Integer;
begin
  SetLength(FCamposInfLot, 0);
  SetLength(FCamposPCusto, 0);
  SetLength(FCamposPVenda, 0);
  SetLength(FCamposTblPrc, 0);
  SetLength(FCamposDadSai, 0);

  pAddCampo(FCamposInfLot, 'AUTOINCREM',         'Autoincremento'             , ftString, 20, False,    '');
  pAddCampo(FCamposInfLot, 'LTP_NUMDOC',         'Documento'                  , ftString, fTamNumDoc, True,    '');
  pAddCampo(FCamposInfLot, 'LTP_ESPDOC',         'Especie'                    , ftString, 02, True,    '');
  pAddCampo(FCamposInfLot, 'LTP_SERIE_',         'Série'                      , ftString, 03, True,    '');
  pAddCampo(FCamposInfLot, 'LTP_CODFOR',         'Cód.Forn.'                  , ftString, 08, True,    '');
  pAddCampo(FCamposInfLot, 'LTP_CODEMP',         'Cód.Emp.'                   , ftString, 03, True,    '');
  pAddCampo(FCamposInfLot, 'LTP_OPERES',         'Cód.Respons.'               , ftString, 03, True,    '');
  pAddCampo(FCamposInfLot, 'LTP_CODITE',         'Cód.Item.'                  , ftString, fTamCodIte, True,    '');
  pAddCampo(FCamposInfLot, 'LTP_DTAENT',         'Data Entrada'               , ftDate,   00, True,    '');
  pAddCampo(FCamposInfLot, 'LTP_HORENT',         'Hora Entrada'               , ftTime,   00, True,    '');
  pAddCampo(FCamposInfLot, 'LTP_ATUALI',         'Atualiza?'                  , ftString, 01, True,    '');
  pAddCampo(FCamposInfLot, 'LTP_DTAATU',         'Data Atualização'           , ftDate,   00, True,    '');
  pAddCampo(FCamposInfLot, 'LTP_BAIXAD',         'Baixado?'                   , ftString, 01, True,    '');
  pAddCampo(FCamposInfLot, 'LTP_DTABAI',         'Data Baixa'                 , ftDate,   00, True,    '');
  pAddCampo(FCamposInfLot, 'LTP_HORBAI',         'Hora Baixa'                 , ftTime,   00, True,    '');
  pAddCampo(FCamposInfLot, 'LTP_OPEBAI',         'Operador Baixa'             , ftString, 03, True,    '');

  {***************************************}
  {*  COMPOSICAO DO PRECO DE CUSTO       *}
  {************************************JC*}
  If fCfgSis('COTDOR', varBoolean) Then
  Begin
    pAddCampo(FCamposPCusto, 'LTP_PREDOL_ANT',     'Preço de Compra em Dólar Ant'    , ftString, 3,  True,     '');
    pAddCampo(FCamposPCusto, 'LTP_PREDOL',         'Preço de Compra em Dólar'        , ftString, 3,  True,     '');
  End;

  pAddCampo(FCamposPCusto, 'LTP_PRECOM_ANT',     'Preço de Compa Ant.'             , ftFloat,  12, True,     fMskDigitos(intDecimais));
  pAddCampo(FCamposPCusto, 'LTP_PRECOM',         'Preço de Compra'                 , ftFloat,  12, True,     fMskDigitos(intDecimais));

  pAddCampo(FCamposPCusto, 'LTP_DESF01_ANT',     '(-) % Desc. Forn. 1 Ant.'        , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_DESF01',         '(-) % Desc. Forn. 1'             , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_DESF02_ANT',     '(-) % Desc. Forn. 2 Ant.'        , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_DESF02',         '(-) % Desc. Forn. 2'             , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_DESF03_ANT',     '(-) % Desc. Forn. 3 Ant.'        , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_DESF03',         '(-) % Desc. Forn. 3'             , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_DESF04_ANT',     '(-) % Desc. Forn. 4 Ant.'        , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_DESF04',         '(-) % Desc. Forn. 4'             , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_DESF05_ANT',     '(-) % Desc. Forn. 5 Ant.'        , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_DESF05',         '(-) % Desc. Forn. 5'             , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_DESF06_ANT',     '(-) % Desc. Forn. 6 Ant.'        , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_DESF06',         '(-) % Desc. Forn. 6'             , ftFloat,  12, True,     '#,##0.00');

  pAddCampo(FCamposPCusto, 'LTP_COMLIQ_ANT',     'Preço de Compa Líquido Ant.'     , ftFloat,  12, True,     fMskDigitos(intDecimais));
  pAddCampo(FCamposPCusto, 'LTP_COMLIQ',         'Preço de Compra Líquido'         , ftFloat,  12, True,     fMskDigitos(intDecimais));

  pAddCampo(FCamposPCusto, 'LTP_ICMENT_ANT',     '(-) % Icms Entrada Ant.'         , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_ICMENT',         '(-) % Icms Entrada'              , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_SUBFED_ANT',     '(-) % Impostos Federais Ant.'    , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_SUBFED',         '(-) % Impostos Federais'         , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_IPIENT_ANT',     '(+) % IPI Entrada Ant.'          , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_IPIENT',         '(+) % IPI Entrada'               , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_FREENT_ANT',     '(+) % Frete Ant.'                , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_FREENT',         '(+) % Frete'                     , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_VALFRE_ANT',     '(+) ' + fCfgSis('DESVFR') + ' Ant.'  , ftFloat,  12, True,  fMskDigitos(intDecimais));
  pAddCampo(FCamposPCusto, 'LTP_VALFRE',         '(+) ' + fCfgSis('DESVFR')        , ftFloat,  12, True,      fMskDigitos(intDecimais));
  pAddCampo(FCamposPCusto, 'LTP_ACRFIN_ANT',     '(+) % Acr. Financ. Ant.'         , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_ACRFIN',         '(+) % Acr. Financ.'              , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_SUBSTI_ANT',     '(+) % Sub. Tributária Ant.'      , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_SUBSTI',         '(+) % Sub. Tributária'           , ftFloat,  12, True,     '#,##0.00');

  pAddCampo(FCamposPCusto, 'LTP_DESADB_ANT',     '(' + fCfgSis('OPEADI') + ') % ' + fCfgSis('DESADI') + ' Ant.' , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPCusto, 'LTP_DESADB',         '(' + fCfgSis('OPEADI') + ') % ' + fCfgSis('DESADI')           , ftFloat,  12, True,     '#,##0.00');

  if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
  begin
    pAddCampo(FCamposPCusto, 'LTP_TCIFCU_ANT',     '(+) % TCIF Ant.'                 , ftFloat,  12, True,     '#,##0.000000');
    pAddCampo(FCamposPCusto, 'LTP_TCIFCU',         '(+) % TCIF'                      , ftFloat,  12, True,     '#,##0.000000');
    pAddCampo(FCamposPCusto, 'LTP_TSCUST_ANT',     '(+) % TS Ant.'                   , ftFloat,  12, True,     '#,##0.000000');
    pAddCampo(FCamposPCusto, 'LTP_TSCUST',         '(+) % TS'                        , ftFloat,  12, True,     '#,##0.000000');
    pAddCampo(FCamposPCusto, 'LTP_DEPICO_ANT',     '(-) % Desconto PIS/COFINS Ant.'  , ftFloat,  12, True,     '#,##0.00');
    pAddCampo(FCamposPCusto, 'LTP_DEPICO',         '(-) % Desconto PIS/COFINS'       , ftFloat,  12, True,     '#,##0.00');
    pAddCampo(FCamposPCusto, 'LTP_DEICMS_ANT',     '(-) % Desconto ICMS Ant.'        , ftFloat,  12, True,     '#,##0.00');
    pAddCampo(FCamposPCusto, 'LTP_DEICMS',         '(-) % Desconto ICMS'             , ftFloat,  12, True,     '#,##0.00');
    pAddCampo(FCamposPCusto, 'LTP_FATREG_ANT',     '(+) % Fator Regional Ant.'       , ftFloat,  12, True,     '#,##0.00');
    pAddCampo(FCamposPCusto, 'LTP_FATREG',         '(+) % Fator Regional'            , ftFloat,  12, True,     '#,##0.00');
  end;


  pAddCampo(FCamposPCusto, 'LTP_PRECUS_ANT',     'Preço de Custo Ant.'             , ftFloat,  12, True,     fMskDigitos(intDecimais));
  pAddCampo(FCamposPCusto, 'LTP_PRECUS',         'Preço de Custo'                  , ftFloat,  12, True,     fMskDigitos(intDecimais));

  {***************************************}
  {*  COMPOSICAO DO PRECO DE VENDA       *}
  {************************************JC*}
  pAddCampo(FCamposPVenda, 'LTP_OUTVAL_ANT',     '(+) ' + fCfgSis('DOVCPP') + ' Ant.'    , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPVenda, 'LTP_OUTVAL',         '(+) ' + fCfgSis('DOVCPP')              , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPVenda, 'LTP_ICMSAI_ANT',     '(+) Icms Saída Ant'                    , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPVenda, 'LTP_ICMSAI',         '(+) Icms Saída'                        , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPVenda, 'LTP_IMPFED_ANT',     '(+) Impostos Federais Ant.'            , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPVenda, 'LTP_IMPFED',         '(+) Impostos Federais'                 , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPVenda, 'LTP_DESOPE_ANT',     '(+) Despesas Operac. Ant.'             , ftFloat,  12, True,     '#,##0.00');
  pAddCampo(FCamposPVenda, 'LTP_DESOPE',         '(+) Despesas Operac.'                  , ftFloat,  12, True,     '#,##0.00');

  pAddCampo(FCamposPVenda, 'ITE_CUSREA',         'Preço de Custo Real'                  , ftFloat,  12, True,    fMskDigitos(intDecimais));
  pAddCampo(FCamposPVenda, 'ITE_CUSREA_ANT',     'Preço de Custo Real Ant.'             , ftFloat,  12, True,    fMskDigitos(intDecimais));

  {**********************************}
  {*  PRECO DE VENDA TABELA PRECO X *}
  {*******************************JC*}
  For intCont := 1 To Length(VS_strTabPrc) Do
  Begin
    pAddCampo(FCamposTblPrc, 'LTP_MARBR' + IntToStr(intCont) + '_ANT', 'Margem Bruta '   + IntToStr(intCont) + ' Ant.' , ftFloat,  12, (VS_strTabPrc[intCont] = 'S'), fMskDigitos(fRetPrecisaoMargemItem));
    pAddCampo(FCamposTblPrc, 'LTP_MARBR' + IntToStr(intCont)         , 'Margem Bruta '   + IntToStr(intCont)           , ftFloat,  12, (VS_strTabPrc[intCont] = 'S'), fMskDigitos(fRetPrecisaoMargemItem));

    If FMarIde Then
    Begin
      pAddCampo(FCamposTblPrc, 'LTP_MARID' + IntToStr(intCont) + '_ANT', 'Margem Ideal '   + IntToStr(intCont) + ' Ant.' , ftFloat,  12, (VS_strTabPrc[intCont] = 'S'), fMskDigitos(intDecimais));
      pAddCampo(FCamposTblPrc, 'LTP_MARID' + IntToStr(intCont)         , 'Margem Ideal '   + IntToStr(intCont)           , ftFloat,  12, (VS_strTabPrc[intCont] = 'S'), fMskDigitos(intDecimais));
    End;
    If fCfgSis('PCMPRO') = '2' Then
    Begin
      pAddCampo(FCamposTblPrc, 'LTP_COMTB' + IntToStr(intCont) + '_ANT', 'Comissão Tab. '  + IntToStr(intCont) + ' Ant.' , ftFloat,  12, (VS_strTabPrc[intCont] = 'S') And (fCfgSis('PCMPRO') = '2'), fMskDigitos(intDecimais));
      pAddCampo(FCamposTblPrc, 'LTP_COMTB' + IntToStr(intCont)         , 'Comissão Tab. '  + IntToStr(intCont)           , ftFloat,  12, (VS_strTabPrc[intCont] = 'S') And (fCfgSis('PCMPRO') = '2'), fMskDigitos(intDecimais));
    End
    Else If fCfgSis('PCMPRO') = '3' Then
    Begin
      pAddCampo(FCamposTblPrc, 'LTP_COMTB' + IntToStr(intCont) + '_ANT', fCfgSis('TCOMTB') + ' Tab. '  + IntToStr(intCont) + ' Ant.' , ftFloat,  12, (VS_strTabPrc[intCont] = 'S') And (fCfgSis('PCMPRO') = '3'), fMskDigitos(intDecimais));
      pAddCampo(FCamposTblPrc, 'LTP_COMTB' + IntToStr(intCont)         , fCfgSis('TCOMTB') + ' Tab. '  + IntToStr(intCont)           , ftFloat,  12, (VS_strTabPrc[intCont] = 'S') And (fCfgSis('PCMPRO') = '3'), fMskDigitos(intDecimais));
    End;
    pAddCampo(FCamposTblPrc, 'LTP_PREVE' + IntToStr(intCont) + '_ANT', 'Preço de Venda ' + IntToStr(intCont) + ' Ant.' , ftFloat,  12, (VS_strTabPrc[intCont] = 'S'), fMskDigitos(intDecimais));
    pAddCampo(FCamposTblPrc, 'LTP_PREVE' + IntToStr(intCont)         , 'Preço de Venda ' + IntToStr(intCont)           , ftFloat,  12, (VS_strTabPrc[intCont] = 'S'), fMskDigitos(intDecimais));
    If blnALTCVI Then
    begin
      pAddCampo(FCamposTblPrc, 'LTP_VENIM' + IntToStr(intCont) + '_ANT', 'Preço de Venda + Impostos(IPI + ST) ' + IntToStr(intCont) + ' Ant.' , ftFloat,  12, (VS_strTabPrc[intCont] = 'S'), fMskDigitos(intDecimais));
      pAddCampo(FCamposTblPrc, 'LTP_VENIM' + IntToStr(intCont)         , 'Preço de Venda + Impostos(IPI + ST) ' + IntToStr(intCont)           , ftFloat,  12, (VS_strTabPrc[intCont] = 'S'), fMskDigitos(intDecimais));
    End;

    If (Pos(fCfgSis('MARMKP', varString), '1_2') > 0) Then
    Begin
      If fCfgSis('VISCPV') = 'S' Then
      Begin
        pAddCampo(FCamposTblPrc, 'LTP_CUSVE' + IntToStr(intCont) + '_ANT', 'Preço de Custo da Venda ' + IntToStr(intCont) + ' Ant.' , ftFloat,  12, (VS_strTabPrc[intCont] = 'S'), fMskDigitos(intDecimais));
        pAddCampo(FCamposTblPrc, 'LTP_CUSVE' + IntToStr(intCont)         , 'Preço de Custo da Venda ' + IntToStr(intCont)           , ftFloat,  12, (VS_strTabPrc[intCont] = 'S'), fMskDigitos(intDecimais));
      End;
    End;
  End;

  {**********************************}
  {*   COMPOSIÇÃO DADOS DE SAÍDA    *}
  {*******************************TS*}
  if blnValFor then
  begin
    pAddCampo(FCamposDadSai, 'LTP_DTAVAL_ANT', 'Data Val. Preço Tab. Forn. Ant.', ftString,  0, True, '');
    pAddCampo(FCamposDadSai, 'LTP_DTAVAL'    , 'Data Val. Preço Tab. Fornecedor', ftString,  0, True, '');
  end;
end;

procedure TLotePrecos.pSetCotDol(Value: Double);
begin
  FCotDol := Value;
end;

procedure TLotePrecos.pSetCDSGrids;
  var
    intDiv: Integer;
    intContador: integer;
    intGrid: Integer;
begin
  If Not Assigned(FCdsPrecos) Or (intQtdGrid = 1) Then
    Exit;
  FCdsPrecos.First;

  intDiv := Ceil(FCdsPrecos.RecordCount / intQtdGrid);
  intGrid := 1;
  intContador := 0;
  While Not FCdsPrecos.Eof Do
  Begin
    FCdsPrecos.Edit;
    FCdsPrecos.FieldByName('USGRID').AsInteger := intGrid;
    inc(intContador);
    If intContador = intDiv Then
    Begin
      inc(intGrid);
      intContador := 0;
    End;

    FCdsPrecos.FieldByName('SEQUEN').AsInteger := FCdsPrecos.RecNo;

    FCdsPrecos.Post;
    FCdsPrecos.Next;
  End;

  FCdsPrecos1.Data := FCdsPrecos.Data;
  FCdsPrecos1.Filtered := False;
  FCdsPrecos1.Filter := 'USGRID = 1';
  FCdsPrecos1.Filtered := True;
  FCdsPrecos1.IndexFieldNames := 'SEQUEN';

  FCdsPrecos2.Data := FCdsPrecos.Data;
  FCdsPrecos2.Filtered := False;
  FCdsPrecos2.Filter := 'USGRID = 2';
  FCdsPrecos2.Filtered := True;
  FCdsPrecos2.IndexFieldNames := 'SEQUEN';

  FCdsPrecos3.Data := FCdsPrecos.Data;
  FCdsPrecos3.Filtered := False;
  FCdsPrecos3.Filter := 'USGRID = 3';
  FCdsPrecos3.Filtered := True;
  FCdsPrecos3.IndexFieldNames := 'SEQUEN';
  FCdsPrecos.First;
end;

procedure TLotePrecos.pSetOpeRes(Value: String);
begin
  FOpeRes := Value;
  If Not fEmptyStr(FOpeRes) Then
    FstlRes.Add(FOpeRes);
end;

procedure TLotePrecos.SetQtdGrid(const Value: Integer);
begin
  FintQtdGrid := Value;
  pSetCDSGrids;
end;

procedure TLotePrecos.pCriaCdsPrecos;
  Var
    intCont: Integer;
begin

  FCdsPrecos := TUniClientDataSet.Create(Self);
  FCdsPrecos1 := TUniClientDataSet.Create(Self);
  FCdsPrecos2 := TUniClientDataSet.Create(Self);
  FCdsPrecos3 := TUniClientDataSet.Create(Self);

  FCdsPrecos.FieldDefs.Add('TITULO', ftString, 01, False);
  FCdsPrecos.FieldDefs.Add('NOMCAM', ftString, 30, False);
  FCdsPrecos.FieldDefs.Add('DESCRI', ftString, 80, False);
  FCdsPrecos.FieldDefs.Add('VALANT', ftString, 20, False);
  FCdsPrecos.FieldDefs.Add('VALATU', ftString, 20, False);
  FCdsPrecos.FieldDefs.Add('EMBANT', ftString, 20, False);
  FCdsPrecos.FieldDefs.Add('EMBATU', ftString, 20, False);
  FCdsPrecos.FieldDefs.Add('CAMALT', ftString, 01, False);
  FCdsPrecos.FieldDefs.Add('USGRID', ftInteger, 0, False);
  FCdsPrecos.FieldDefs.Add('SEQUEN', ftInteger, 0, False);
  FCdsPrecos.FieldDefs.Add('UTILIZ', FtInteger, 0, False);
  FCdsPrecos.FieldDefs.Add('CCUSTO', ftBoolean, 0, False);


  FCdsPrecos.CreateDataSet;

  FCdsPrecos.FieldByName('TITULO').Visible      := False;
  FCdsPrecos.FieldByName('NOMCAM').Visible      := False;
  FCdsPrecos.FieldByName('DESCRI').DisplayLabel := 'Descrição';
  FCdsPrecos.FieldByName('VALANT').DisplayLabel := 'Valor Anterior';
  FCdsPrecos.FieldByName('VALATU').DisplayLabel := 'Valor Atual';
  FCdsPrecos.FieldByName('EMBANT').DisplayLabel := 'Valor Ant. Emb.';
  FCdsPrecos.FieldByName('EMBATU').DisplayLabel := 'Valor Atual Emb.';
  FCdsPrecos.FieldByName('CAMALT').DisplayLabel := 'Alt.?';
  FCdsPrecos.FieldByName('UTILIZ').DisplayLabel := 'Utiliza';
  FCdsPrecos.FieldByName('CCUSTO').DisplayLabel := 'Campo de Custo';


  if blnValFor then
  begin
    pAddRegistroPreco('S', '', 'DADOS DE SAÍDA', '', '', '', '', 'N');

    For intCont := 0 To Length(FCamposDadSai) -1 Do
      If FCamposDadSai[intCont].blnVisible And (Pos('_ANT', FCamposDadSai[intCont].strNomCam) <= 0) Then
        pAddRegistroPreco('N', FCamposDadSai[intCont].strNomCam, FCamposDadSai[intCont].strDesCri, '', '', '', '', 'N');
  end;

  pAddRegistroPreco('S', '', 'PREÇO DE CUSTO', '', '', '', '', 'N');

  For intCont := 0 To Length(FCamposPCusto) -1 Do
    If FCamposPCusto[intCont].blnVisible And
      (Pos('_ANT', FCamposPCusto[intCont].strNomCam) <= 0)  Then
     pAddRegistroPreco('N', FCamposPCusto[intCont].strNomCam, FCamposPCusto[intCont].strDesCri, '', '', '', '', 'N', False, True);

  pAddRegistroPreco('S', '', 'PREÇO DE VENDA', '', '', '', '', 'N');

  For intCont := 0 To Length(FCamposPVenda) -1 Do
    If FCamposPVenda[intCont].blnVisible And (Pos('_ANT', FCamposPVenda[intCont].strNomCam) <= 0)  Then
      pAddRegistroPreco('N', FCamposPVenda[intCont].strNomCam, FCamposPVenda[intCont].strDesCri, '', '', '', '', 'N', False, True);

  For intCont := 0 To Length(FCamposTblPrc) -1 Do
    If FCamposTblPrc[intCont].blnVisible And (Pos('_ANT', FCamposTblPrc[intCont].strNomCam) <= 0)  Then
    Begin
      If AnsiStartsStr('LTP_MARBR', FCamposTblPrc[intCont].strNomCam) Then
        pAddRegistroPreco('S', '', 'TABELA PREÇO ' + RightStr(FCamposTblPrc[intCont].strNomCam, 1), '', '', '', '', 'N');

      pAddRegistroPreco('N', FCamposTblPrc[intCont].strNomCam, FCamposTblPrc[intCont].strDesCri, '', '', '', '', 'N');
    End;

  pSetCDSGrids;
end;

procedure TLotePrecos.pAtualizaCdsPrecos(DataSet: TDataSet; AStrCamAlt: String = ''; AfltValor: Double = 0);
begin

  With FCdsPrecos Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;

      If DataSet.IsEmpty Then
      Begin
        FieldByName('VALATU').AsString := '';
        FieldByName('VALANT').AsString := '';
        FieldByName('EMBATU').AsString := '';
        FieldByName('EMBANT').AsString := '';
        FieldByName('CAMALT').AsString := '';
      End Else
      Begin
        If DataSet.FindField(FieldByName('NOMCAM').AsString) <> nil Then
        Begin
          If AnsiStartsStr('LTP_PREDOL', FieldByName('NOMCAM').AsString)  Then
          Begin
            FieldByName('VALATU').AsString := DataSet.FindField(FieldByName('NOMCAM').AsString).AsString;
          End
          Else If FieldByName('NOMCAM').AsString = 'LTP_DTAVAL' Then
          Begin
            FieldByName('VALATU').AsString := DataSet.FindField(FieldByName('NOMCAM').AsString).AsString;
          End Else
          Begin
            If FCdsPrecos.FieldByName('CCUSTO').AsBoolean Then
               FCdsPrecos.FieldByName('VALATU').AsString := FormatFloat(TFloatField(DataSet.FindField(FCdsPrecos.FieldByName('NOMCAM').AsString + '_ATU')).DisplayFormat,
                                                                        DataSet.FindField(FCdsPrecos.FieldByName('NOMCAM').AsString + '_ATU').AsFloat)
            Else
              FieldByName('VALATU').AsString := FormatFloat(TFloatField(DataSet.FindField(FieldByName('NOMCAM').AsString)).DisplayFormat,
                                                                        DataSet.FindField(FieldByName('NOMCAM').AsString).AsFloat);
          End;

          If (Not AnsiStartsStr('LTP_PREDOL', FieldByName('NOMCAM').AsString)) And
             ((Pos('Preço', FCdsPrecos.FieldByName('DESCRI').AsString) > 0) Or
              (FCdsPrecos.FieldByName('NOMCAM').AsString = 'LTP_VALFRE') Or
              (FCdsPrecos.FieldByName('NOMCAM').AsString = 'LTP_OUTVAL')) Then
            FieldByName('EMBATU').AsString := FormatFloat(TFloatField(DataSet.FindField(FieldByName('NOMCAM').AsString)).DisplayFormat,
                                                                      DataSet.FindField(FieldByName('NOMCAM').AsString).AsFloat * DataSet.FieldByName('EMBALA').AsFloat);

        End;

        If DataSet.FindField(FieldByName('NOMCAM').AsString + '_ANT') <> nil Then
        Begin
          If AnsiStartsStr('LTP_PREDOL', FieldByName('NOMCAM').AsString)  Then
          Begin
            FieldByName('VALANT').AsString := DataSet.FindField(FieldByName('NOMCAM').AsString + '_ANT').AsString;
          End
          Else If FieldByName('NOMCAM').AsString + '_ANT' = 'LTP_DTAVAL_ANT' Then
          Begin
            FieldByName('VALANT').AsString := DataSet.FindField(FieldByName('NOMCAM').AsString + '_ANT').AsString;
          End Else
            FieldByName('VALANT').AsString := FormatFloat(TFloatField(DataSet.FindField(FieldByName('NOMCAM').AsString)).DisplayFormat,
                                                                      DataSet.FindField(FieldByName('NOMCAM').AsString + '_ANT').AsFloat);

          If (Not AnsiStartsStr('LTP_PREDOL', FieldByName('NOMCAM').AsString)) And
             ((Pos('Preço', FCdsPrecos.FieldByName('DESCRI').AsString) > 0) Or
              (FCdsPrecos.FieldByName('NOMCAM').AsString = 'LTP_VALFRE') Or
              (FCdsPrecos.FieldByName('NOMCAM').AsString = 'LTP_OUTVAL')) Then
            FieldByName('EMBANT').AsString := FormatFloat(TFloatField(DataSet.FindField(FieldByName('NOMCAM').AsString)).DisplayFormat,
                                                            DataSet.FindField(FieldByName('NOMCAM').AsString + '_ANT').AsFloat * DataSet.FieldByName('EMBALA').AsFloat);
        End;

        If (FCdsPrecos.FieldByName('CCUSTO').AsBoolean) Then
        Begin
          FieldByName('CAMALT').AsString := IIF(SameStr(FCdsPrecos.FieldByName('VALANT').AsString,
                                                        FormatFloat(TFloatField(DataSet.FindField(FCdsPrecos.FieldByName('NOMCAM').AsString + '_UTI')).DisplayFormat,
                                                           DataSet.FindField(FCdsPrecos.FieldByName('NOMCAM').AsString + '_UTI').AsFloat)), 'N', 'S');

          FCdsPrecos.FieldByName('UTILIZ').AsInteger := IIf((FieldByName('CAMALT').AsString = 'S'), 1, 0);
        End
        Else
          FieldByName('CAMALT').AsString := IIF(SameStr(FieldByName('VALANT').AsString, FieldByName('VALATU').AsString), 'N', 'S');
      End;

      Post;
      Next;
    End;
    First;
    pSetCDSGrids;
    EnableControls;
    blnAtualizaPrecomUti := False;
  End;
End;

procedure TLotePrecos.pAtualizaGrupoPrecosItem(DataSet: TDataSet);
  var
    strUpdate: String;
    qryGeral: TUniQuery;
begin
  strUpdate := '';
  strUpdate := strUpdate + ' UPDATE CADITE SET ';
  strUpdate := strUpdate + '   ITE_CODGPR = :CODGPR ';
  strUpdate := strUpdate + ' WHERE ';
  strUpdate := strUpdate + '   ITE_CODITE = :CODITE  ';

  qryGeral := fCriaQuery(Self);

  With qryGeral, SQL Do
  Begin
    Close;
    Clear;
    Add(strUpdate);

    if DataSet.FieldByName('ITE_CODGPR').AsString <> '' Then
    Begin
      ParamByName('CODGPR').AsString := DataSet.FieldByName('ITE_CODGPR').AsString;
      ParamByName('CODITE').AsString := DataSet.FieldByName('ITE_CODITE').AsString;
    End;

    ExecSQL;
  End;

  FreeAndNil(qryGeral);
end;

function TLotePrecos.fMontaSqlItensComum(AblnPedido: Boolean = False): String;
var
  intCont: Integer;
  blnPisCofins_PorEmpresa: Boolean;
Begin
  Result := '';
  Result := Result  + '   M.MAR_DESMAR AS ITE_DESMAR, ';
  Result := Result  + '   DP.DEP_DESCRI AS ITE_DESDEP,';
  If fCfgSis('TABPRF', varBoolean) Then
    Result := Result  + '  IF(IFNULL(FI.ITE_CODFAB,"") = "", I.ITE_CODFAB, FI.ITE_CODFAB) AS ITE_CODFAB, '
  Else
    Result := Result  + '  IF(IFNULL(FI.ITE_CODITF,"") = "", I.ITE_CODFAB, FI.ITE_CODITF) AS ITE_CODFAB, ';
  Result := Result  + '   U.UNI_SIGUNI AS ITE_SIGUNI, ';
  Result := Result  + '   I.ITE_RPRENT AS ITE_RPRENT, ';
  Result := Result  + '   I.ITE_CLAIPI AS ITE_CLAIPI, ';
  If AblnPedido Then
    Result := Result  + '   1   AS EMBALA, '
  Else
    Result := Result  + '   TRI_EMBALA   AS EMBALA, ';
  Result := Result  + '   GPR_DESCRI AS ITE_DESGPR, ';

  blnPisCofins_PorEmpresa := fCfgSis('TPABPC') = '2';

  Result := Result  + '   CONCAT(ABF_CODABF,"-",ABF_DESABF)AS ABF_DESABF, ';
  Result := Result  + ' (SELECT  IFNULL(CONCAT(COFENT.APC_CODAPC,"-",COFENT.APC_DESCRI),"") FROM COFENT WHERE COFENT.APC_CODAPC = ' + IfThen(blnPisCofins_PorEmpresa,'G.ITE_ABFCOF','I.ITE_ABFCOF') + ' LIMIT 1) AS ABF_DESPIS, ';
  Result := Result  + ' (SELECT  IFNULL(CONCAT(PISENT.APC_CODAPC,"-",PISENT.APC_DESCRI),"") FROM PISENT WHERE PISENT.APC_CODAPC = ' + IfThen(blnPisCofins_PorEmpresa,'G.ITE_ABFPIS','I.ITE_ABFPIS') + ' LIMIT 1) AS ABF_DESCOF, ';

  Result := Result  + '   G.ITE_LOCFIS, ';
  Result := Result  + '   G.ITE_SALDOS, ';

  Result := Result  + '   G.ITE_MARID1 AS LTP_MARID1_ANT, ';
  Result := Result  + '   G.ITE_MARID2 AS LTP_MARID2_ANT, ';
  Result := Result  + '   G.ITE_MARID3 AS LTP_MARID3_ANT, ';
  Result := Result  + '   G.ITE_MARID4 AS LTP_MARID4_ANT, ';
  Result := Result  + '   G.ITE_MARID5 AS LTP_MARID5_ANT, ';
  Result := Result  + '   G.ITE_MARID6 AS LTP_MARID6_ANT, ';
  Result := Result  + '   G.ITE_MARID7 AS LTP_MARID7_ANT, ';

  Result := Result  + '   G.ITE_MARID1 AS LTP_MARID1, ';
  Result := Result  + '   G.ITE_MARID2 AS LTP_MARID2, ';
  Result := Result  + '   G.ITE_MARID3 AS LTP_MARID3, ';
  Result := Result  + '   G.ITE_MARID4 AS LTP_MARID4, ';
  Result := Result  + '   G.ITE_MARID5 AS LTP_MARID5, ';
  Result := Result  + '   G.ITE_MARID6 AS LTP_MARID6, ';
  Result := Result  + '   G.ITE_MARID7 AS LTP_MARID7, ';

  Result := Result  + '   IFNULL(G.ITE_MARID1, 0) AS ITE_MARID1, ';
  Result := Result  + '   IFNULL(G.ITE_MARID2, 0) AS ITE_MARID2, ';
  Result := Result  + '   IFNULL(G.ITE_MARID3, 0) AS ITE_MARID3, ';
  Result := Result  + '   IFNULL(G.ITE_MARID4, 0) AS ITE_MARID4, ';
  Result := Result  + '   IFNULL(G.ITE_MARID5, 0) AS ITE_MARID5, ';
  Result := Result  + '   IFNULL(G.ITE_MARID6, 0) AS ITE_MARID6, ';
  Result := Result  + '   IFNULL(G.ITE_MARID7, 0) AS ITE_MARID7, ';

  Result := Result  + '   0.0000 AS ITE_PREID1, ';
  Result := Result  + '   0.0000 AS ITE_PREID2, ';
  Result := Result  + '   0.0000 AS ITE_PREID3, ';
  Result := Result  + '   0.0000 AS ITE_PREID4, ';
  Result := Result  + '   0.0000 AS ITE_PREID5, ';
  Result := Result  + '   0.0000 AS ITE_PREID6, ';
  Result := Result  + '   0.0000 AS ITE_PREID7, ';
  Result := Result  + '   0.0000 AS ITE_CUSREA, ';
  Result := Result  + '   0.0000 AS ITE_CUSREA_ANT, ';
  Result := Result  + '   0.000  AS ITE_CUSREA_DIF, ';

  If blnALTCVI Then
  begin
    For intCont := 1 To Length(VS_strTabPrc) Do
    Begin
      Result := Result + ' 0.0000 AS LTP_VENIM' + IntToStr(intCont) + ', ';
      Result := Result + ' 0.0000 AS LTP_VENIM' + IntToStr(intCont) + '_ANT, ';
    end;
  end;

  If (Pos(fCfgSis('MARMKP', varString), '1_2') > 0) Then
  Begin
    For intCont := 1 To Length(VS_strTabPrc) Do
    Begin
      Result := Result + ' 0.0000 AS LTP_CUSVE' + IntToStr(intCont) + ', ';
      Result := Result + 'ROUND(((G.ITE_PRECUS + G.ITE_OUTVAL) +  (G.ITE_PREVE' + IntToStr(intCont) + ' * ';
      Result := Result + '       (G.ITE_ICMSAI + G.ITE_IMPFED + G.ITE_DESOPE + G.ITE_COMTB' + IntToStr(intCont)+'))/100), :DECUNI) ';
      Result := Result + ' AS LTP_CUSVE' + IntToStr(intCont) + '_ANT, ';
    End;
  End;

  If fCfgSis('COTDOR', varBoolean) Then
  Begin
    Result := Result  + '   G.ITE_PREDOL, ';
    Result := Result  + '   IF(G.ITE_PREDOL = "S", "SIM", "NÃO") AS LTP_PREDOL_ANT, ';
    Result := Result  + '   IF(G.ITE_PREDOL = "S", "SIM", "NÃO") AS LTP_PREDOL, ';
  End Else
  Begin
    Result := Result  + '  "N"   AS ITE_PREDOL, ';
    Result := Result  + '  "NÃO" AS LTP_PREDOL_ANT, ';
    Result := Result  + '  "NÃO" AS LTP_PREDOL, ';
  End;

  Result := Result  + '   G.ITE_PRECOM AS LTP_PRECOM_ANT, ';

  Result := Result  + '   G.ITE_DESF01 AS LTP_DESF01_ANT, ';
  Result := Result  + '   G.ITE_DESF02 AS LTP_DESF02_ANT, ';
  Result := Result  + '   G.ITE_DESF03 AS LTP_DESF03_ANT, ';
  Result := Result  + '   G.ITE_DESF04 AS LTP_DESF04_ANT, ';
  Result := Result  + '   G.ITE_DESF05 AS LTP_DESF05_ANT, ';
  Result := Result  + '   G.ITE_DESF06 AS LTP_DESF06_ANT, ';

  Result := Result  + ' ROUND((G.ITE_PRECOM * ';
  Result := Result  + ' ( 1 - (G.ITE_DESF01) / 100) * ';
  Result := Result  + ' ( 1 - (G.ITE_DESF02) / 100) * ';
  Result := Result  + ' ( 1 - (G.ITE_DESF03) / 100) * ';
  Result := Result  + ' ( 1 - (G.ITE_DESF04) / 100) * ';
  Result := Result  + ' ( 1 - (G.ITE_DESF05) / 100) * ';
  Result := Result  + ' ( 1 - (G.ITE_DESF06) / 100)) * IF(G.ITE_PREDOL = "S", :COTANT, 1), :DECUNI) AS LTP_COMLIQ_ANT, ';

  Result := Result  + '   G.ITE_ICMENT AS LTP_ICMENT_ANT, ';
  Result := Result  + '   G.ITE_SUBFED AS LTP_SUBFED_ANT, ';
  Result := Result  + '   G.ITE_IPIENT AS LTP_IPIENT_ANT, ';
  Result := Result  + '   G.ITE_FREENT AS LTP_FREENT_ANT, ';
  Result := Result  + '   G.ITE_VALFRE AS LTP_VALFRE_ANT, ';
  Result := Result  + '   G.ITE_ACRFIN AS LTP_ACRFIN_ANT, ';
  Result := Result  + '   G.ITE_SUBSTI AS LTP_SUBSTI_ANT, ';
  Result := Result  + '   G.ITE_DESADB AS LTP_DESADB_ANT, ';
  Result := Result  + '   G.ITE_OUTVAL AS LTP_OUTVAL_ANT, ';
  Result := Result  + '   G.ITE_PRECUS AS LTP_PRECUS_ANT, ';
  Result := Result  + '   G.ITE_IMPFED AS LTP_IMPFED_ANT, ';
  Result := Result  + '   G.ITE_DESOPE AS LTP_DESOPE_ANT, ';
  Result := Result  + '   G.ITE_ICMSAI AS LTP_ICMSAI_ANT, ';
  Result := Result  + '   G.ITE_MARBR1 AS LTP_MARBR1_ANT, ';
  Result := Result  + '   G.ITE_PREVE1 AS LTP_PREVE1_ANT, ';
  Result := Result  + '   G.ITE_COMTB1 AS LTP_COMTB1_ANT, ';
  Result := Result  + '   G.ITE_MARBR2 AS LTP_MARBR2_ANT, ';
  Result := Result  + '   G.ITE_PREVE2 AS LTP_PREVE2_ANT, ';
  Result := Result  + '   G.ITE_COMTB2 AS LTP_COMTB2_ANT, ';
  Result := Result  + '   G.ITE_MARBR3 AS LTP_MARBR3_ANT, ';
  Result := Result  + '   G.ITE_PREVE3 AS LTP_PREVE3_ANT, ';
  Result := Result  + '   G.ITE_COMTB3 AS LTP_COMTB3_ANT, ';
  Result := Result  + '   G.ITE_MARBR4 AS LTP_MARBR4_ANT, ';
  Result := Result  + '   G.ITE_PREVE4 AS LTP_PREVE4_ANT, ';
  Result := Result  + '   G.ITE_COMTB4 AS LTP_COMTB4_ANT, ';
  Result := Result  + '   G.ITE_MARBR5 AS LTP_MARBR5_ANT, ';
  Result := Result  + '   G.ITE_PREVE5 AS LTP_PREVE5_ANT, ';
  Result := Result  + '   G.ITE_COMTB5 AS LTP_COMTB5_ANT, ';
  Result := Result  + '   G.ITE_MARBR6 AS LTP_MARBR6_ANT, ';
  Result := Result  + '   G.ITE_PREVE6 AS LTP_PREVE6_ANT, ';
  Result := Result  + '   G.ITE_COMTB6 AS LTP_COMTB6_ANT, ';
  Result := Result  + '   G.ITE_MARBR7 AS LTP_MARBR7_ANT, ';
  Result := Result  + '   G.ITE_PREVE7 AS LTP_PREVE7_ANT, ';
  Result := Result  + '   G.ITE_COMTB7 AS LTP_COMTB7_ANT, ';
  Result := Result  + '   G.ITE_DTAVAL AS LTP_DTAVAL_ANT, ';
  Result := Result  + '   G.ITE_TCIFCU AS LTP_TCIFCU_ANT, ';
  Result := Result  + '   G.ITE_TSCUST AS LTP_TSCUST_ANT, ';
  Result := Result  + '   G.ITE_DEPICO AS LTP_DEPICO_ANT, ';
  Result := Result  + '   G.ITE_DEICMS AS LTP_DEICMS_ANT, ';
  Result := Result  + '   G.ITE_FATREG AS LTP_FATREG_ANT, ';

  If fCfgSis('BLOPRE', varBoolean) Then
  Begin
    Result := Result  + ' "Margem" AS TIPCAL1, ';
    Result := Result  + ' "Margem" AS TIPCAL2, ';
    Result := Result  + ' "Margem" AS TIPCAL3, ';
    Result := Result  + ' "Margem" AS TIPCAL4, ';
    Result := Result  + ' "Margem" AS TIPCAL5, ';
    Result := Result  + ' "Margem" AS TIPCAL6, ';
    Result := Result  + ' "Margem" AS TIPCAL7, ';
  End Else
  Begin
    Result := Result  + '   (SELECT IF(SIS_VALCFG = "P", "Preço Venda", "Margem") FROM CFGSIS ';
    Result := Result  + '     WHERE SIS_CODCFG = "CFG_ATPVMB" AND SIS_CODEMP = ' + QuotedStr(FCodEmp) + ') AS TIPCAL1, ';

    Result := Result  + '   (SELECT IF(SIS_VALCFG = "P", "Preço Venda", "Margem") FROM CFGSIS ';
    Result := Result  + '     WHERE SIS_CODCFG = "CFG_ATPVM2" AND SIS_CODEMP = ' + QuotedStr(FCodEmp) + ') AS TIPCAL2, ';

    Result := Result  + '   (SELECT IF(SIS_VALCFG = "P", "Preço Venda", "Margem") FROM CFGSIS ';
    Result := Result  + '     WHERE SIS_CODCFG = "CFG_ATPVM3" AND SIS_CODEMP = ' + QuotedStr(FCodEmp) + ') AS TIPCAL3, ';

    Result := Result  + '   (SELECT IF(SIS_VALCFG = "P", "Preço Venda", "Margem") FROM CFGSIS ';
    Result := Result  + '     WHERE SIS_CODCFG = "CFG_ATPVM4" AND SIS_CODEMP = ' + QuotedStr(FCodEmp) + ') AS TIPCAL4, ';

    Result := Result  + '   (SELECT IF(SIS_VALCFG = "P", "Preço Venda", "Margem") FROM CFGSIS ';
    Result := Result  + '     WHERE SIS_CODCFG = "CFG_ATPVM5" AND SIS_CODEMP = ' + QuotedStr(FCodEmp) + ') AS TIPCAL5, ';

    Result := Result  + '   (SELECT IF(SIS_VALCFG = "P", "Preço Venda", "Margem") FROM CFGSIS ';
    Result := Result  + '     WHERE SIS_CODCFG = "CFG_ATPVM6" AND SIS_CODEMP = ' + QuotedStr(FCodEmp) + ') AS TIPCAL6, ';

    Result := Result  + '   (SELECT IF(SIS_VALCFG = "P", "Preço Venda", "Margem") FROM CFGSIS ';
    Result := Result  + '     WHERE SIS_CODCFG = "CFG_ATPVM7" AND SIS_CODEMP = ' + QuotedStr(FCodEmp) + ') AS TIPCAL7,  ';
  End;
  Result := Result  + '   I.ITE_APLICA AS ITE_APLICA, ';
End;


function TLotePrecos.fMontaSqlItens(AblnPedido: Boolean = False): String;
Var
  blnHabCmp: Boolean;
begin
  intUltimoSQLExec := 2;
  Result := '';
  Result := ' SET @NROITE = 0; ';
  Result := Result  + ' SELECT ';
  Result := Result  + ' (@NROITE:=(@NROITE + 1)) AS NROITE, ';
  Result := Result  + ' TAB.*  ';
  Result := Result  + ' FROM ( ';
  Result := Result  + ' SELECT ';
  Result := Result  + fMontaSqlItensComum(AblnPedido);
  Result := Result  + '   "LOTPRE"     AS TABELA, ';
  Result := Result  + '   I.ITE_CODGPR, ';
  Result := Result  + '   D.DET_CODITE AS ITE_CODITE, ';
  Result := Result  + '   D.DET_DESCRI AS ITE_DESCRI, ';
  Result := Result  + '   D.DET_REFERE AS ITE_REFERE, ';
  Result := Result  + '   D.DET_QTDITE AS ITE_QTDITE, ';
  Result := Result  + '   D.DET_UNITAR AS ITE_UNITAR, ';
  Result := Result  + '   D.DET_TOTITE AS ITE_TOTITE, ';
  Result := Result  + '   D.DET_VALIPI + T.DET_VAEIPI AS ITE_VALIPI, ';
  Result := Result  + '   D.DET_VALRET + T.DET_VAERET AS ITE_VALRET, ';
  Result := Result  + '   D.DET_CLAFIS AS ITE_CLAFIS, ';
  Result := Result  + '   T.DET_VFCPST AS VFCPST, ';
  Result := Result  + '     ICD_VALFCP AS VALFCP, ';
  Result := Result  + '   ((L.LTP_PRECUS - G.ITE_PRECUS) / G.ITE_PRECUS) * 100 AS DIFCUS, ';
  Result := Result  + '   ((L.LTP_PREVE1 - G.ITE_PREVE1) / G.ITE_PREVE1) * 100 AS DIFPR1, ';
  Result := Result  + '   ((L.LTP_PREVE2 - G.ITE_PREVE2) / G.ITE_PREVE2) * 100 AS DIFPR2, ';
  Result := Result  + '   ((L.LTP_PREVE3 - G.ITE_PREVE3) / G.ITE_PREVE3) * 100 AS DIFPR3, ';
  Result := Result  + '   ((L.LTP_PREVE4 - G.ITE_PREVE4) / G.ITE_PREVE4) * 100 AS DIFPR4, ';
  Result := Result  + '   ((L.LTP_PREVE5 - G.ITE_PREVE5) / G.ITE_PREVE5) * 100 AS DIFPR5, ';
  Result := Result  + '   ((L.LTP_PREVE6 - G.ITE_PREVE6) / G.ITE_PREVE6) * 100 AS DIFPR6, ';
  Result := Result  + '   ((L.LTP_PREVE7 - G.ITE_PREVE7) / G.ITE_PREVE7) * 100 AS DIFPR7, ';

  Result := Result  + '   (L.LTP_MARBR1 - G.ITE_MARBR1) AS DIFMA1, ';
  Result := Result  + '   (L.LTP_MARBR2 - G.ITE_MARBR2) AS DIFMA2, ';
  Result := Result  + '   (L.LTP_MARBR3 - G.ITE_MARBR3) AS DIFMA3, ';
  Result := Result  + '   (L.LTP_MARBR4 - G.ITE_MARBR4) AS DIFMA4, ';
  Result := Result  + '   (L.LTP_MARBR5 - G.ITE_MARBR5) AS DIFMA5, ';
  Result := Result  + '   (L.LTP_MARBR6 - G.ITE_MARBR6) AS DIFMA6, ';
  Result := Result  + '   (L.LTP_MARBR7 - G.ITE_MARBR7) AS DIFMA7, ';

  Result := Result  + '   L.AUTOINCREM, ';
  Result := Result  + '   L.LTP_NUMDOC, ';
  Result := Result  + '   L.LTP_ESPDOC, ';
  Result := Result  + '   L.LTP_SERIE_, ';
  Result := Result  + '   L.LTP_CODFOR, ';
  Result := Result  + '   L.LTP_CODEMP, ';
  Result := Result  + '   L.LTP_OPERES, ';
  Result := Result  + '   L.LTP_SEQDET, ';
  Result := Result  + '   L.LTP_CODITE, ';
  Result := Result  + '   L.LTP_DTAENT, ';
  Result := Result  + '   L.LTP_HORENT, ';
  Result := Result  + '   L.LTP_ATUALI, ';
  Result := Result  + '   L.LTP_DTAATU, ';
  Result := Result  + '   L.LTP_BAIXAD, ';
  Result := Result  + '   L.LTP_DTABAI, ';
  Result := Result  + '   L.LTP_HORBAI, ';
  Result := Result  + '   L.LTP_OPEBAI, ';

  Result := Result  + '   CONCAT(LEFT(I.ITE_CODGRU, 3), ".",  RIGHT(I.ITE_CODGRU, 3), " - ",';
  Result := Result  + '   COALESCE(R.GRU_DESGRU , I.ITE_CODGRU), "") AS DES_LINGRU, ';

  Result := Result  + '   IF(G.ITE_PREDOL = "S", ROUND(L.LTP_PRECOM / :COTDOL, :DECUNI), L.LTP_PRECOM) AS LTP_PRECOM, ';
  Result := Result  + '   IF(G.ITE_PREDOL = "S", ROUND(L.LTP_PRECOM / :COTDOL, :DECUNI), L.LTP_PRECOM) AS LTP_PRECOM_UTI, ';
  Result := Result  + '   IF(G.ITE_PREDOL = "S", ROUND(L.LTP_PRECOM / :COTDOL, :DECUNI), L.LTP_PRECOM) AS LTP_PRECOM_ATU, ';



  Result := Result  + '   IFNULL(L.LTP_DESF01, 0) AS LTP_DESF01, ';
  Result := Result  + '   IFNULL(L.LTP_DESF02, 0) AS LTP_DESF02, ';
  Result := Result  + '   IFNULL(L.LTP_DESF03, 0) AS LTP_DESF03, ';
  Result := Result  + '   IFNULL(L.LTP_DESF04, 0) AS LTP_DESF04, ';
  Result := Result  + '   IFNULL(L.LTP_DESF05, 0) AS LTP_DESF05, ';
  Result := Result  + '   IFNULL(L.LTP_DESF06, 0) AS LTP_DESF06, ';

  Result := Result  + '   IFNULL(L.LTP_DESF01, 0) AS LTP_DESF01_UTI, ';
  Result := Result  + '   IFNULL(L.LTP_DESF02, 0) AS LTP_DESF02_UTI, ';
  Result := Result  + '   IFNULL(L.LTP_DESF03, 0) AS LTP_DESF03_UTI, ';
  Result := Result  + '   IFNULL(L.LTP_DESF04, 0) AS LTP_DESF04_UTI, ';
  Result := Result  + '   IFNULL(L.LTP_DESF05, 0) AS LTP_DESF05_UTI, ';
  Result := Result  + '   IFNULL(L.LTP_DESF06, 0) AS LTP_DESF06_UTI, ';

  Result := Result  + '   IFNULL(L.LTP_DESF01, 0) AS LTP_DESF01_ATU, ';
  Result := Result  + '   IFNULL(L.LTP_DESF02, 0) AS LTP_DESF02_ATU, ';
  Result := Result  + '   IFNULL(L.LTP_DESF03, 0) AS LTP_DESF03_ATU, ';
  Result := Result  + '   IFNULL(L.LTP_DESF04, 0) AS LTP_DESF04_ATU, ';
  Result := Result  + '   IFNULL(L.LTP_DESF05, 0) AS LTP_DESF05_ATU, ';
  Result := Result  + '   IFNULL(L.LTP_DESF06, 0) AS LTP_DESF06_ATU, ';



  If fCfgSis('ATUICE', VarBoolean) Then
  Begin
    Result := Result  + '   L.LTP_ICMENT, ';
    Result := Result  + '   L.LTP_ICMENT AS LTP_ICMENT_UTI , ';
    Result := Result  + '   L.LTP_ICMENT AS LTP_ICMENT_ATU , ';
  End
  Else
  Begin
    Result := Result  + '   G.ITE_ICMENT AS LTP_ICMENT, ';
    Result := Result  + '   G.ITE_ICMENT AS LTP_ICMENT_UTI, ';
    Result := Result  + '   G.ITE_ICMENT AS LTP_ICMENT_ATU, ';
  End;

  If fCfgSis('SITPRO', VarBoolean) Then
  Begin
    Result := Result  + '   IFNULL(S.SIT_DESCRI,"") AS SIT_DESCRI, IFNULL(S.SIT_CORSIT,"") AS SIT_CORSIT, ';
  End;

  Result := Result  + '   L.LTP_SUBFED, ';
  Result := Result  + '   L.LTP_SUBFED AS LTP_SUBFED_UTI, ';
  Result := Result  + '   L.LTP_SUBFED AS LTP_SUBFED_ATU, ';

  If fCfgSis('ATUIPI', VarBoolean) Then
  Begin
    Result := Result  + '   L.LTP_IPIENT, ';
    Result := Result  + '   L.LTP_IPIENT AS LTP_IPIENT_UTI, ';
    Result := Result  + '   L.LTP_IPIENT AS LTP_IPIENT_ATU, ';
  End
  Else
  Begin
    Result := Result  + '   G.ITE_IPIENT AS LTP_IPIENT, ';
    Result := Result  + '   G.ITE_IPIENT AS LTP_IPIENT_UTI, ';
    Result := Result  + '   G.ITE_IPIENT AS LTP_IPIENT_ATU, ';
  End;

  If fCfgSis('ATUFRE', VarBoolean) Then
  Begin
    Result := Result  + '   L.LTP_FREENT, ';
    Result := Result  + '   L.LTP_VALFRE, ';
    Result := Result  + '   L.LTP_FREENT AS LTP_FREENT_UTI, ';
    Result := Result  + '   L.LTP_VALFRE AS LTP_VALFRE_UTI, ';
    Result := Result  + '   L.LTP_FREENT AS LTP_FREENT_ATU, ';
    Result := Result  + '   L.LTP_VALFRE AS LTP_VALFRE_ATU, ';
  End Else
  Begin
    Result := Result  + '   G.ITE_FREENT AS LTP_FREENT, ';
    Result := Result  + '   G.ITE_VALFRE AS LTP_VALFRE, ';
    Result := Result  + '   G.ITE_FREENT AS LTP_FREENT_UTI, ';
    Result := Result  + '   G.ITE_VALFRE AS LTP_VALFRE_UTI, ';
    Result := Result  + '   G.ITE_FREENT AS LTP_FREENT_ATU, ';
    Result := Result  + '   G.ITE_VALFRE AS LTP_VALFRE_ATU, ';
  End;

  Result := Result  + '   L.LTP_ACRFIN, ';
  Result := Result  + '   L.LTP_ACRFIN AS LTP_ACRFIN_UTI, ';
  Result := Result  + '   L.LTP_ACRFIN AS LTP_ACRFIN_ATU, ';

  If fCfgSis('ATUSUB', VarBoolean) Then
  Begin
    Result := Result  + '   L.LTP_SUBSTI, ';
    Result := Result  + '   L.LTP_SUBSTI AS LTP_SUBSTI_UTI, ';
    Result := Result  + '   L.LTP_SUBSTI AS LTP_SUBSTI_ATU, ';
  End
  Else
  Begin
    Result := Result  + '   G.ITE_SUBSTI AS LTP_SUBSTI, ';
    Result := Result  + '   G.ITE_SUBSTI AS LTP_SUBSTI_UTI, ';
    Result := Result  + '   G.ITE_SUBSTI AS LTP_SUBSTI_ATU, ';
  End;

  blnHabCmp := fCfgSis('HABCMP', VarBoolean);

  If blnHabCmp Then
  Begin
    Result := Result  + '   IF(MG.GER_CONPAG = "01000", F.FOR_DESBAV, F.FOR_DESBAP) AS LTP_DESADB, ';
    Result := Result  + '   IF(MG.GER_CONPAG = "01000", F.FOR_DESBAV, F.FOR_DESBAP) AS LTP_DESADB_UTI, ';
    Result := Result  + '   IF(MG.GER_CONPAG = "01000", F.FOR_DESBAV, F.FOR_DESBAP) AS LTP_DESADB_ATU, ';
  End
  Else
  Begin
    If fCfgSis('ATUADB') <> 'N' Then
    Begin
      Result := Result  + '   L.LTP_DESADB, ';
      Result := Result  + '   L.LTP_DESADB AS LTP_DESADB_UTI, ';
      Result := Result  + '   L.LTP_DESADB AS LTP_DESADB_ATU, ';
    End
    Else
    Begin
      Result := Result  + '   G.ITE_DESADB AS LTP_DESADB, ';
      Result := Result  + '   G.ITE_DESADB AS LTP_DESADB_UTI, ';
      Result := Result  + '   G.ITE_DESADB AS LTP_DESADB_ATU, ';
    End;
  End;

  Result := Result  + '   L.LTP_PRECUS, ';

  Result := Result  + '   L.LTP_OUTVAL, ';
  Result := Result  + '   L.LTP_IMPFED, ';
  Result := Result  + '   L.LTP_DESOPE, ';

  If (fCfgSis('ATUICS', varBoolean)) Then
  Begin
    Result := Result  + '   L.LTP_ICMSAI, ';
    Result := Result  + '   L.LTP_ICMSAI AS LTP_ICMSAI_UTI, ';
    Result := Result  + '   L.LTP_ICMSAI AS LTP_ICMSAI_ATU, ';
  End
  Else
  Begin
    Result := Result  + '   G.ITE_ICMSAI AS LTP_ICMSAI, ';
    Result := Result  + '   G.ITE_ICMSAI AS LTP_ICMSAI_UTI, ';
    Result := Result  + '   G.ITE_ICMSAI AS LTP_ICMSAI_ATU, ';
  End;

  Result := Result  + '   L.LTP_OUTVAL AS LTP_OUTVAL_UTI, ';
  Result := Result  + '   L.LTP_IMPFED AS LTP_IMPFED_UTI, ';
  Result := Result  + '   L.LTP_DESOPE AS LTP_DESOPE_UTI, ';

  Result := Result  + '   L.LTP_OUTVAL AS LTP_OUTVAL_ATU, ';
  Result := Result  + '   L.LTP_IMPFED AS LTP_IMPFED_ATU, ';
  Result := Result  + '   L.LTP_DESOPE AS LTP_DESOPE_ATU, ';

  Result := Result  + '   L.LTP_MARBR1, ';
  Result := Result  + '   L.LTP_PREVE1, ';
  Result := Result  + '   L.LTP_COMTB1, ';
  Result := Result  + '   L.LTP_MARBR2, ';
  Result := Result  + '   L.LTP_PREVE2, ';
  Result := Result  + '   L.LTP_COMTB2, ';
  Result := Result  + '   L.LTP_MARBR3, ';
  Result := Result  + '   L.LTP_PREVE3, ';
  Result := Result  + '   L.LTP_COMTB3, ';
  Result := Result  + '   L.LTP_MARBR4, ';
  Result := Result  + '   L.LTP_PREVE4, ';
  Result := Result  + '   L.LTP_COMTB4, ';
  Result := Result  + '   L.LTP_MARBR5, ';
  Result := Result  + '   L.LTP_PREVE5, ';
  Result := Result  + '   L.LTP_COMTB5, ';
  Result := Result  + '   L.LTP_MARBR6, ';
  Result := Result  + '   L.LTP_PREVE6, ';
  Result := Result  + '   L.LTP_COMTB6, ';
  Result := Result  + '   L.LTP_MARBR7, ';
  Result := Result  + '   L.LTP_PREVE7, ';
  Result := Result  + '   L.LTP_COMTB7, ';
  Result := Result  + '   L.LTP_COMLIQ, ';

  If fCfgSis('ATUTCF', VarBoolean) Then
  Begin
    Result := Result  + '   L.LTP_TCIFCU, ';
    Result := Result  + '   L.LTP_TCIFCU AS LTP_TCIFCU_UTI, ';
    Result := Result  + '   L.LTP_TCIFCU AS LTP_TCIFCU_ATU, ';
  End
  Else
  Begin
    Result := Result  + '   G.ITE_TCIFCU AS LTP_TCIFCU, ';
    Result := Result  + '   G.ITE_TCIFCU AS LTP_TCIFCU_UTI, ';
    Result := Result  + '   G.ITE_TCIFCU AS LTP_TCIFCU_ATU, ';
  End;

  If fCfgSis('ATU_TS', VarBoolean) Then
  Begin
    Result := Result  + '   L.LTP_TSCUST, ';
    Result := Result  + '   L.LTP_TSCUST AS LTP_TSCUST_UTI, ';
    Result := Result  + '   L.LTP_TSCUST AS LTP_TSCUST_ATU, ';
  End
  Else
  Begin
    Result := Result  + '   G.ITE_TSCUST AS LTP_TSCUST, ';
    Result := Result  + '   G.ITE_TSCUST AS LTP_TSCUST_UTI, ';
    Result := Result  + '   G.ITE_TSCUST AS LTP_TSCUST_ATU, ';
  End;

  Result := Result  + '   L.LTP_DEPICO, ';
  Result := Result  + '   L.LTP_DEICMS, ';
  Result := Result  + '   L.LTP_FATREG, ';

  Result := Result  + '   L.LTP_DEPICO AS LTP_DEPICO_UTI, ';
  Result := Result  + '   L.LTP_DEICMS AS LTP_DEICMS_UTI, ';
  Result := Result  + '   L.LTP_FATREG AS LTP_FATREG_UTI, ';

  Result := Result  + '   L.LTP_DEPICO AS LTP_DEPICO_ATU, ';
  Result := Result  + '   L.LTP_DEICMS AS LTP_DEICMS_ATU, ';
  Result := Result  + '   L.LTP_FATREG AS LTP_FATREG_ATU, ';

  Result := Result  + '   G.ITE_DTAVAL AS LTP_DTAVAL,';
  Result := Result  + '   D.AUTOINCREM AS ORDDIG, ';

  Result := Result  + '   (SELECT COUNT(GMT.AUTOINCREM) ';
  Result := Result  + '   FROM GERMAT GMT ';
  Result := Result  + '   WHERE I.ITE_CODITE = GMT.GMT_CODITE) AS ESTRUT, ';

  Result := Result  + '   (SELECT COUNT(DMT.DMT_SEQGER) ';
  Result := Result  + '   FROM DETMAT DMT ';
  Result := Result  + '   WHERE I.ITE_CODITE = DMT.DMT_ITESUB) AS ESTRUT_FILHO, ';
  Result := Result  +  fSQLSaldoDisponivel('G', True, False, True) + ' AS SALDIS, ';
  Result := Result  + '   G.ITE_PREMED PREMED,';
  Result := Result  + '   G.ITE_IMPULT IMPULT,';
  Result := Result  + '   G.ITE_NIVCRI, ';

  If fCfgSis('TIPGIR', VarBoolean) Then
    Result := Result  + '   G.ITE_NIVGIR NIVGIR, '
  Else
    Result := Result  + '   I.ITE_NVLGIR NIVGIR, ';

  Result := Result  + ' L.LTP_RPRENT, ';

  Result := Result  + '     (SELECT IFNULL(MAX(PRE.ALT_DTAALT),"") ';
  Result := Result  + '     FROM PREALT PRE ';
  Result := Result  + '     WHERE ';
  Result := Result  + '     PRE.ALT_CODEMP = G.ITE_CODEMP AND PRE.ALT_CODITE = I.ITE_CODITE ';
  Result := Result  + '     ORDER BY PRE.ALT_DTAALT DESC LIMIT 1) DTAALT ';

  Result := Result  + ' FROM LOTPRE L ';
  Result := Result  + '   INNER JOIN MOVDET D ';
  Result := Result  + '     ON L.LTP_SEQDET = D.AUTOINCREM ';

  If blnHabCmp Then
  Begin
    Result := Result  + '   INNER JOIN MOVGER MG ';
    Result := Result  + '     ON D.DET_SEQGER = MG.AUTOINCREM ';
  End;

  Result := Result  + '   INNER JOIN MOVTRI T ';
  Result := Result  + '     ON T.DET_SEQGER = D.AUTOINCREM ';

  Result := Result  + '   INNER JOIN CADITE I ';
  Result := Result  + '     ON I.ITE_CODITE = D.DET_CODITE ';

  Result := Result  + '   INNER JOIN ITEGER G ';
  Result := Result  + '     ON G.ITE_CODITE = I.ITE_CODITE AND ';
  Result := Result  + '        G.ITE_CODEMP = D.DET_CODEMP ';

  If fCfgSis('SITPRO', VarBoolean) Then
  Begin
    Result := Result  + '   LEFT JOIN SITPRO S ';
    Result := Result  + '     ON G.ITE_SITPRO = S.SIT_CODIGO ';
  End;

  Result := Result  + '   INNER JOIN CADUNI U ';
  Result := Result  + '     ON U.UNI_CODUNI = D.DET_UNIDAD ';

  Result := Result  + '   INNER JOIN CADGRU R ON R.GRU_CODGRU = I.ITE_CODGRU ';

  Result := Result  + '   LEFT JOIN CADGPR ON GPR_CODIGO = I.ITE_CODGPR ';

  Result := Result  + '   LEFT JOIN MOVICD ON ICD_SEQGER = D.AUTOINCREM ';

  Result := Result  + '   INNER JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR  ';

  Result := Result  + '   LEFT JOIN CADDEP DP ON DP.DEP_CODIGO = I.ITE_CODDEP ';

  Result := Result  + '   INNER JOIN CADFOR F ON F.FOR_CODFOR = L.LTP_CODFOR  ';
  Result := Result  + '   INNER JOIN CADCID C ON C.CID_CODCID = F.FOR_CODCID  ';

  If fCfgSis('TABPRF', varBoolean) Then
  Begin
  	Result := Result  + '  LEFT JOIN (SELECT * FROM ITEFOR FI WHERE FI.ITE_CODFAB IS NOT NULL ';
    Result := Result  + '       AND (SELECT COUNT(*) FROM TABPRE                              ';
    Result := Result  + '       WHERE FI.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0   ';
    Result := Result  + '  GROUP BY FI.ITE_CODFAB) FI ON FI.ITE_CODITE = I.ITE_CODITE         ';
    Result := Result  + '                           AND FI.ITE_CODFOR  = L.LTP_CODFOR         ';
  End Else
  Begin
    Result := Result  + ' LEFT JOIN ITEFOR FI ON FI.ITE_CODITE = I.ITE_CODITE               ';
    Result := Result  + '                    AND FI.ITE_CODFOR = L.LTP_CODFOR               ';
    Result := Result  + '  AND FI.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF    ';
    Result := Result  + '                       WHERE FF.ITE_CODITE = I.ITE_CODITE AND      ';
    Result := Result  + '                             FF.ITE_CODFOR = L.LTP_CODFOR)         ';
  End;

  If fCfgSis('TIPABF') = '1' Then
    Result := Result  + '   LEFT JOIN ABFICM AF ON AF.ABF_CODABF = I.ITE_CODABF '
  Else
    Result := Result  + '   LEFT JOIN ABFICM AF ON AF.ABF_CODABF = G.ITE_CODABF ';
  Result := Result  + '                        AND AF.ABF_ESTADO = C.CID_ESTADO ';

  Result := Result  + ' WHERE ';
  Result := Result  + ' 	L.LTP_BAIXAD = "N" AND ';

  Result := Result  + ' 	L.LTP_NUMDOC = ' + QuotedStr(FNumDoc) + ' AND ';
  Result := Result  + ' 	L.LTP_ESPDOC = ' + QuotedStr(FEspDoc) + ' AND ';
  Result := Result  + ' 	L.LTP_SERIE_ = ' + QuotedStr(FSerie_) + ' AND ';
  Result := Result  + ' 	L.LTP_CODEMP = ' + QuotedStr(FCodEmp) + ' AND ';
  Result := Result  + ' 	L.LTP_CODFOR = ' + QuotedStr(FCodFor);

  If (Not FOpeRes.IsEmpty) And blnFiltraResponsavel Then
    Result := Result  + ' AND	(IFNULL(L.LTP_OPERES, "") = ' + QuotedStr(FOpeRes) + ' OR IFNULL(L.LTP_OPERES, "") = "") ';

  Result := Result  + ' ORDER BY T.DET_NITEM_ ';
  Result := Result  + ' ) AS TAB  ';
end;

function TLotePrecos.fMontaSqlItensPedido(AblnPedido: Boolean = False): String;
begin
  intUltimoSQLExec := 1;
  Result := '';
  Result := ' SET @NROITE = 0; ';
  Result := Result  + ' SELECT ';
  Result := Result  + ' (@NROITE:=(@NROITE + 1)) AS NROITE, ';
  Result := Result  + ' TAB.*  ';
  Result := Result  + ' FROM ( ';
  Result := Result  + ' SELECT ';
  Result := Result  + fMontaSqlItensComum(AblnPedido);
  Result := Result  + '   "PCMDET"     AS TABELA, ';
  Result := Result  + '   D.PCD_CODITE AS ITE_CODITE, ';
  Result := Result  + '   D.PCD_DESITE AS ITE_DESCRI, ';
  Result := Result  + '   I.ITE_REFERE AS ITE_REFERE, ';
  Result := Result  + '   D.PCD_QTDITE AS ITE_QTDITE, ';

  Result := Result  + '   D.PCD_UNITAR AS ITE_UNITAR, ';

  Result := Result  + '   D.PCD_TOTITE AS ITE_TOTITE, ';
  Result := Result  + '   D.PCD_TOTIPI AS ITE_VALIPI, ';
  Result := Result  + '   D.PCD_TOTSUB AS ITE_VALRET, ';

  Result := Result  + ' CAST(" " AS CHAR(4)) AS ITE_CLAFIS, ';

//-------------------------------------
  Result := Result  + '   0.000 AS VFCPST, ';
  Result := Result  + '   0.000 AS VALFCP, ';
  Result := Result  + '   0.000 AS DIFCUS, ';

  Result := Result  + '   0.000 AS DIFPR1, ';
  Result := Result  + '   0.000 AS DIFPR2, ';
  Result := Result  + '   0.000 AS DIFPR3, ';
  Result := Result  + '   0.000 AS DIFPR4, ';
  Result := Result  + '   0.000 AS DIFPR5, ';
  Result := Result  + '   0.000 AS DIFPR6, ';
  Result := Result  + '   0.000 AS DIFPR7, ';

  Result := Result  + '   0.000 AS DIFMA1, ';
  Result := Result  + '   0.000 AS DIFMA2, ';
  Result := Result  + '   0.000 AS DIFMA3, ';
  Result := Result  + '   0.000 AS DIFMA4, ';
  Result := Result  + '   0.000 AS DIFMA5, ';
  Result := Result  + '   0.000 AS DIFMA6, ';
  Result := Result  + '   0.000 AS DIFMA7, ';
//-------------------------------------

  Result := Result  + '   D.AUTOINCREM, ';

  Result := Result  + '   PCD_NUMPED AS LTP_NUMDOC, ';
  Result := Result  + '   PCD_ESPDOC AS LTP_ESPDOC, ';
  Result := Result  + '   " " AS LTP_SERIE_, ';
  Result := Result  + '   PCD_CODFOR AS LTP_CODFOR, ';
  Result := Result  + '   PCD_CODEMP AS LTP_CODEMP, ';
  Result := Result  + '   PCG_CODCMP AS LTP_OPERES, ';
  Result := Result  + '   G.AUTOINCREM AS LTP_SEQDET, ';
  Result := Result  + '   PCD_CODITE AS LTP_CODITE, ';
  Result := Result  + '   PCG_DTAPED AS LTP_DTAENT, ';
  Result := Result  + '   PCG_HORENT AS LTP_HORENT, ';

  Result := Result  + '   "N"                   AS LTP_ATUALI, ';
  Result := Result  + '   CAST(NULL AS DATE)    AS LTP_DTAATU, ';
  Result := Result  + '   "N"                   AS LTP_BAIXAD, ';
  Result := Result  + '   CAST(NULL AS DATE)    AS LTP_DTABAI, ';
  Result := Result  + '   CAST(NULL AS TIME)    AS LTP_HORBAI, ';
  Result := Result  + '   CAST(NULL AS CHAR(3)) AS LTP_OPEBAI, ';

  Result := Result  + '   IF(G.ITE_PREDOL = "S" AND PCG_MOEDA_ <> 1, ROUND(IFNULL(PCD_UNITAR, 0) / :COTDOL, :DECUNI), ';
  Result := Result  + '     IF(G.ITE_PREDOL = "N" AND PCG_MOEDA_ = 1, ROUND(IFNULL(PCD_UNITAR, 0) * :COTDOL, :DECUNI), IFNULL(PCD_UNITAR, 0))) AS LTP_PRECOM, ';


  Result := Result  + '   IF(G.ITE_PREDOL = "S" AND PCG_MOEDA_ <> 1, ROUND(IFNULL(PCD_UNITAR, 0) / :COTDOL, :DECUNI), ';
  Result := Result  + '     IF(G.ITE_PREDOL = "N" AND PCG_MOEDA_ = 1, ROUND(IFNULL(PCD_UNITAR, 0) * :COTDOL, :DECUNI), IFNULL(PCD_UNITAR, 0))) AS LTP_PRECOM_UTI, ';

  Result := Result  + '   IF(G.ITE_PREDOL = "S" AND PCG_MOEDA_ <> 1, ROUND(IFNULL(PCD_UNITAR, 0) / :COTDOL, :DECUNI), ';
  Result := Result  + '     IF(G.ITE_PREDOL = "N" AND PCG_MOEDA_ = 1, ROUND(IFNULL(PCD_UNITAR, 0) * :COTDOL, :DECUNI), IFNULL(PCD_UNITAR, 0))) AS LTP_PRECOM_ATU, ';


  Result := Result  + '   IFNULL(PCD_DESUNI, 0) AS LTP_DESF01, ';
  Result := Result  + '   IFNULL(PCD_DESUN2, 0) AS LTP_DESF02, ';
  Result := Result  + '   IFNULL(PCD_DESUN3, 0) AS LTP_DESF03, ';
  Result := Result  + '   IFNULL(PCD_DESUN4, 0) AS LTP_DESF04, ';
  Result := Result  + '   IFNULL(PCD_DESUN5, 0) AS LTP_DESF05, ';
  Result := Result  + '   IFNULL(PCD_DESUN6, 0) AS LTP_DESF06, ';

  Result := Result  + '   G.ITE_ICMENT AS LTP_ICMENT, ';
  Result := Result  + '   G.ITE_SUBFED AS LTP_SUBFED, ';

  Result := Result  + '   IFNULL(PCD_DESUNI, 0) AS LTP_DESF01_UTI, ';
  Result := Result  + '   IFNULL(PCD_DESUN2, 0) AS LTP_DESF02_UTI, ';
  Result := Result  + '   IFNULL(PCD_DESUN3, 0) AS LTP_DESF03_UTI, ';
  Result := Result  + '   IFNULL(PCD_DESUN4, 0) AS LTP_DESF04_UTI, ';
  Result := Result  + '   IFNULL(PCD_DESUN5, 0) AS LTP_DESF05_UTI, ';
  Result := Result  + '   IFNULL(PCD_DESUN6, 0) AS LTP_DESF06_UTI, ';

  Result := Result  + '   G.ITE_ICMENT AS LTP_ICMENT_UTI, ';
  Result := Result  + '   G.ITE_SUBFED AS LTP_SUBFED_UTI, ';


  Result := Result  + '   IFNULL(PCD_DESUNI, 0) AS LTP_DESF01_ATU, ';
  Result := Result  + '   IFNULL(PCD_DESUN2, 0) AS LTP_DESF02_ATU, ';
  Result := Result  + '   IFNULL(PCD_DESUN3, 0) AS LTP_DESF03_ATU, ';
  Result := Result  + '   IFNULL(PCD_DESUN4, 0) AS LTP_DESF04_ATU, ';
  Result := Result  + '   IFNULL(PCD_DESUN5, 0) AS LTP_DESF05_ATU, ';
  Result := Result  + '   IFNULL(PCD_DESUN6, 0) AS LTP_DESF06_ATU, ';

  Result := Result  + '   G.ITE_ICMENT AS LTP_ICMENT_ATU, ';
  Result := Result  + '   G.ITE_SUBFED AS LTP_SUBFED_ATU, ';

  If fCfgSis('SITPRO', VarBoolean) Then
  Begin
    Result := Result  + '   IFNULL(S.SIT_DESCRI,"") AS SIT_DESCRI, IFNULL(S.SIT_CORSIT,"") AS SIT_CORSIT, ';
  End;

  If fCfgSis('ATUIPI', VarBoolean) Then
  Begin
    Result := Result  + '   PCD_PERIPI AS LTP_IPIENT, ';
    Result := Result  + '   PCD_PERIPI AS LTP_IPIENT_UTI, ';
    Result := Result  + '   PCD_PERIPI AS LTP_IPIENT_ATU, ';
  End
  Else
  Begin
    Result := Result  + '   G.ITE_IPIENT AS LTP_IPIENT, ';
    Result := Result  + '   G.ITE_IPIENT AS LTP_IPIENT_UTI, ';
    Result := Result  + '   G.ITE_IPIENT AS LTP_IPIENT_ATU, ';
  End;

  Result := Result  + '   G.ITE_FREENT AS LTP_FREENT, ';  // SERÁ RECALCULADO
  Result := Result  + '   G.ITE_VALFRE AS LTP_VALFRE, ';
  Result := Result  + '   G.ITE_ACRFIN AS LTP_ACRFIN, ';

  Result := Result  + '   G.ITE_FREENT AS LTP_FREENT_UTI, ';  // SERÁ RECALCULADO
  Result := Result  + '   G.ITE_VALFRE AS LTP_VALFRE_UTI, ';
  Result := Result  + '   G.ITE_ACRFIN AS LTP_ACRFIN_UTI, ';

  Result := Result  + '   G.ITE_FREENT AS LTP_FREENT_ATU, ';  // SERÁ RECALCULADO
  Result := Result  + '   G.ITE_VALFRE AS LTP_VALFRE_ATU, ';
  Result := Result  + '   G.ITE_ACRFIN AS LTP_ACRFIN_ATU, ';


  If fCfgSis('ATUSUB', VarBoolean) Then
  Begin
    Result := Result  + '   (PCD_TOTSUB / PCD_TOTITE) * 100 AS LTP_SUBSTI, ';
    Result := Result  + '   (PCD_TOTSUB / PCD_TOTITE) * 100 AS LTP_SUBSTI_UTI, ';
    Result := Result  + '   (PCD_TOTSUB / PCD_TOTITE) * 100 AS LTP_SUBSTI_ATU, ';
  End
  Else
  Begin
    Result := Result  + '   G.ITE_SUBSTI AS LTP_SUBSTI, ';
    Result := Result  + '   G.ITE_SUBSTI AS LTP_SUBSTI_UTI, ';
    Result := Result  + '   G.ITE_SUBSTI AS LTP_SUBSTI_ATU, ';
  End;

  Result := Result  + '   G.ITE_DESADB AS LTP_DESADB, ';
  Result := Result  + '   G.ITE_OUTVAL AS LTP_OUTVAL, ';
  Result := Result  + '   G.ITE_IMPFED AS LTP_IMPFED, ';
  Result := Result  + '   G.ITE_DESOPE AS LTP_DESOPE, ';
  Result := Result  + '   G.ITE_ICMSAI AS LTP_ICMSAI, ';

  Result := Result  + '   G.ITE_DESADB AS LTP_DESADB_UTI, ';
  Result := Result  + '   G.ITE_OUTVAL AS LTP_OUTVAL_UTI, ';
  Result := Result  + '   G.ITE_IMPFED AS LTP_IMPFED_UTI, ';
  Result := Result  + '   G.ITE_DESOPE AS LTP_DESOPE_UTI, ';
  Result := Result  + '   G.ITE_ICMSAI AS LTP_ICMSAI_UTI, ';

  Result := Result  + '   G.ITE_DESADB AS LTP_DESADB_ATU, ';
  Result := Result  + '   G.ITE_OUTVAL AS LTP_OUTVAL_ATU, ';
  Result := Result  + '   G.ITE_IMPFED AS LTP_IMPFED_ATU, ';
  Result := Result  + '   G.ITE_DESOPE AS LTP_DESOPE_ATU, ';
  Result := Result  + '   G.ITE_ICMSAI AS LTP_ICMSAI_ATU, ';

  Result := Result  + '   G.ITE_PRECUS AS LTP_PRECUS, ';

  Result := Result  + '   G.ITE_TCIFCU AS LTP_TCIFCU, ';
  Result := Result  + '   G.ITE_TSCUST AS LTP_TSCUST, ';
  Result := Result  + '   G.ITE_DEPICO AS LTP_DEPICO, ';
  Result := Result  + '   G.ITE_DEICMS AS LTP_DEICMS, ';
  Result := Result  + '   G.ITE_FATREG AS LTP_FATREG, ';

  Result := Result  + '   G.ITE_TCIFCU AS LTP_TCIFCU_UTI, ';
  Result := Result  + '   G.ITE_TSCUST AS LTP_TSCUST_UTI, ';
  Result := Result  + '   G.ITE_DEPICO AS LTP_DEPICO_UTI, ';
  Result := Result  + '   G.ITE_DEICMS AS LTP_DEICMS_UTI, ';
  Result := Result  + '   G.ITE_FATREG AS LTP_FATREG_UTI, ';

  Result := Result  + '   G.ITE_TCIFCU AS LTP_TCIFCU_ATU, ';
  Result := Result  + '   G.ITE_TSCUST AS LTP_TSCUST_ATU, ';
  Result := Result  + '   G.ITE_DEPICO AS LTP_DEPICO_ATU, ';
  Result := Result  + '   G.ITE_DEICMS AS LTP_DEICMS_ATU, ';
  Result := Result  + '   G.ITE_FATREG AS LTP_FATREG_ATU, ';


  // SERÃO RECALCULADOS
  Result := Result  + '   ITE_MARBR1 AS LTP_MARBR1, ';
  Result := Result  + '   ITE_PREVE1 AS LTP_PREVE1, ';
  Result := Result  + '   ITE_COMTB1 AS LTP_COMTB1, ';
  Result := Result  + '   ITE_MARBR2 AS LTP_MARBR2, ';
  Result := Result  + '   ITE_PREVE2 AS LTP_PREVE2, ';
  Result := Result  + '   ITE_COMTB2 AS LTP_COMTB2, ';
  Result := Result  + '   ITE_MARBR3 AS LTP_MARBR3, ';
  Result := Result  + '   ITE_PREVE3 AS LTP_PREVE3, ';
  Result := Result  + '   ITE_COMTB3 AS LTP_COMTB3, ';
  Result := Result  + '   ITE_MARBR4 AS LTP_MARBR4, ';
  Result := Result  + '   ITE_PREVE4 AS LTP_PREVE4, ';
  Result := Result  + '   ITE_COMTB4 AS LTP_COMTB4, ';
  Result := Result  + '   ITE_MARBR5 AS LTP_MARBR5, ';
  Result := Result  + '   ITE_PREVE5 AS LTP_PREVE5, ';
  Result := Result  + '   ITE_COMTB5 AS LTP_COMTB5, ';
  Result := Result  + '   ITE_MARBR6 AS LTP_MARBR6, ';
  Result := Result  + '   ITE_PREVE6 AS LTP_PREVE6, ';
  Result := Result  + '   ITE_COMTB6 AS LTP_COMTB6, ';
  Result := Result  + '   ITE_MARBR7 AS LTP_MARBR7, ';
  Result := Result  + '   ITE_PREVE7 AS LTP_PREVE7, ';
  Result := Result  + '   ITE_COMTB7 AS LTP_COMTB7, ';
  Result := Result  + ' G.ITE_PRECOM AS LTP_COMLIQ, ';
  Result := Result  + '   ITE_DTAVAL AS LTP_DTAVAL, ';

  Result := Result  + '   (SELECT COUNT(GMT.AUTOINCREM) ';
  Result := Result  + '   FROM GERMAT GMT ';
  Result := Result  + '   WHERE I.ITE_CODITE = GMT.GMT_CODITE) AS ESTRUT, ';

  Result := Result  + '   (SELECT COUNT(DMT.DMT_SEQGER) ';
  Result := Result  + '   FROM DETMAT DMT ';
  Result := Result  + '   WHERE I.ITE_CODITE = DMT.DMT_ITESUB) AS ESTRUT_FILHO, ';
  Result := Result  +  fSQLSaldoDisponivel('G', True, False, True) + ' AS SALDIS, ';
  Result := Result  + '   G.ITE_PREMED PREMED,';
  Result := Result  + '   G.ITE_IMPULT IMPULT,';

  If fCfgSis('TIPGIR', VarBoolean) Then
    Result := Result  + '   G.ITE_NIVGIR NIVGIR, '
  Else
    Result := Result  + '   I.ITE_NVLGIR NIVGIR, ';

  Result := Result  + '     (SELECT IFNULL(MAX(PRE.ALT_DTAALT),"") ';
  Result := Result  + '     FROM PREALT PRE ';
  Result := Result  + '     WHERE ';
  Result := Result  + '     PRE.ALT_CODEMP = G.ITE_CODEMP AND PRE.ALT_CODITE = I.ITE_CODITE ';
  Result := Result  + '     ORDER BY PRE.ALT_DTAALT DESC LIMIT 1) DTAALT, ';

  Result := Result  + ' I.ITE_CODGPR ';

  Result := Result  + ' FROM PCMGER P ';
  Result := Result  + '   INNER JOIN PCMDET D ON ';
  Result := Result  + '     PCD_CODEMP = PCG_CODEMP AND ';
  Result := Result  + '     PCD_NUMPED = PCG_NUMPED AND ';
  Result := Result  + '     PCD_ESPDOC = PCG_ESPDOC AND ';
  Result := Result  + '     PCD_BAIXAD = 0  AND ';
  Result := Result  + '     PCD_NUMCTN = 0              ';

  Result := Result  + '   INNER JOIN CADITE I ';
  Result := Result  + '     ON I.ITE_CODITE = D.PCD_CODITE ';

  Result := Result  + '   INNER JOIN ITEGER G ';
  Result := Result  + '     ON G.ITE_CODITE = I.ITE_CODITE AND ';
  Result := Result  + '        G.ITE_CODEMP = PCG_CODEMP ';

  If fCfgSis('SITPRO', VarBoolean) Then
  Begin
    Result := Result  + '   LEFT JOIN SITPRO S ';
    Result := Result  + '     ON G.ITE_SITPRO = S.SIT_CODIGO ';
  End;

  Result := Result  + '   INNER JOIN CADUNI U ';
  Result := Result  + '     ON U.UNI_CODUNI = D.PCD_CODUNI ';
  Result := Result  + '   LEFT JOIN CADGPR ON GPR_CODIGO = ITE_CODGPR ';

  Result := Result  + '   INNER JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';
  Result := Result  + '   LEFT JOIN CADDEP DP ON DP.DEP_CODIGO = I.ITE_CODDEP ';

  Result := Result  + '   INNER JOIN CADFOR F ON F.FOR_CODFOR = P.PCG_CODFOR  ';
  Result := Result  + '   INNER JOIN CADCID C ON C.CID_CODCID = F.FOR_CODCID  ';

  If fCfgSis('TABPRF', varBoolean) Then
  Begin
    Result := Result  + '  LEFT JOIN (SELECT * FROM ITEFOR FI WHERE FI.ITE_CODFAB IS NOT NULL ';
    Result := Result  + '  AND (SELECT COUNT(*) FROM TABPRE                                   ';
    Result := Result  + '       WHERE FI.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0   ';
    Result := Result  + '  GROUP BY FI.ITE_CODFAB) FI ON FI.ITE_CODITE = I.ITE_CODITE         ';
    Result := Result  + '                           AND FI.ITE_CODFOR  = P.PCG_CODFOR         ';
  End Else
  Begin
    Result := Result  + ' LEFT JOIN ITEFOR FI ON FI.ITE_CODITE = I.ITE_CODITE               ';
    Result := Result  + '                    AND FI.ITE_CODFOR = P.PCG_CODFOR               ';
    Result := Result  + '  AND FI.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF    ';
    Result := Result  + '                       WHERE FF.ITE_CODITE = I.ITE_CODITE AND      ';
    Result := Result  + '                             FF.ITE_CODFOR = P.PCG_CODFOR)         ';
  End;

  If fCfgSis('TIPABF') = '1' Then
    Result := Result  + '   LEFT JOIN ABFICM AF ON AF.ABF_CODABF = I.ITE_CODABF '
  Else
    Result := Result  + '   LEFT JOIN ABFICM AF ON AF.ABF_CODABF = G.ITE_CODABF ';
  Result := Result  + '                        AND AF.ABF_ESTADO = C.CID_ESTADO ';

  Result := Result  + ' WHERE ';
  Result := Result  + ' 	PCG_NUMPED = ' + QuotedStr(FNumDoc) + ' AND ';
  Result := Result  + ' 	PCG_ESPDOC = ' + QuotedStr(FEspDoc) + ' AND ';
  Result := Result  + ' 	PCG_CODEMP = ' + QuotedStr(FCodEmp) + ' AND ';
  Result := Result  + ' 	PCG_CODFOR = ' + QuotedStr(FCodFor) + ' AND ';
  Result := Result  + '   IFNULL(PCG_BAIXAD, 0) = 0 AND ';
  Result := Result  + '   PCG_NUMCTN = 0            AND  ';
  Result := Result  + '   IFNULL(PCD_PREATU, "N") = "N" AND ';
  Result := Result  + ' 	IFNULL(PCG_CODCMP, "") = ' + QuotedStr(FOpeRes);

  Result := Result  + ' ORDER BY D.AUTOINCREM ';
  Result := Result  + ' ) AS TAB  ';
end;

function TLotePrecos.fNotaConferida(strNumDoc, strEspDoc, strCodEmp, strSerie_, strCodFor : String): Boolean;
  Var
    strSql: String;
    qryGerEle: TUniQuery;
Begin
  Result := True;

  If (fConferenciaDepoisDaEntrada) And (fCfgSis('USACON', varBoolean)) Then
  Begin
    strSql := '';
    strSql := strSql  + ' SELECT GER_DTACON FROM GERELE ';
    strSql := strSql  + ' WHERE GER_DOCENT = :NUMDOC AND ';
    strSql := strSql  + '       GER_ESPENT = :ESPDOC AND ';
    strSql := strSql  + '       GER_EMPENT = :CODEMP AND ';
    strSql := strSql  + '       B07_SERIE  = :SERIE_ AND ';
    strSql := strSql  + '       GER_CODFOR = :CODFOR     ';

    qryGerEle := fCriaQuery;
    With qryGerEle Do
    Begin
      SQL.Text := strSql;

      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('SERIE_').AsString := strSerie_;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      Result := IsEmpty Or (Not FieldByName('GER_DTACON').IsNull);
    End;

    FreeAndNil(qryGerEle);
  End;

End;

function TLotePrecos.fCarregaDadosLotePreco(strNumDoc, strEspDoc, strCodEmp, strSerie_, strCodFor, stOpeRes : String) : Boolean;
begin

  Result := fCfgSis('ANTCON', VarBoolean) Or fNotaConferida(strNumDoc, strEspDoc, strCodEmp, strSerie_, strCodFor);

  If Result Then
  Begin
    FCodFor := strCodFor;
    FNumDoc := strNumDoc;
    FOpeRes := stOpeRes;
    FEspDoc := strEspDoc;
    FSerie_ := strSerie_;
    FCodEmp := strCodEmp;

    If fCfgSis('COTDOR', varBoolean) And
       fTemProdutosEmDolar(FCodFor, FNumDoc, FEspDoc, FSerie_, FCodEmp, FCotDol) Then
      Result := (FCotDol > 0) Or TfrmPedeCotacaoMoeda.fPedeCotacaoMoeda(FCotDol, infoItemEmDolar);

  End Else
  Begin
    pMensagemOk('É necessário fazer a conferência da entrada antes da atualização de preços!');
  End;

end;


function TLotePrecos.fCarregaNota(strAutoincremGERELE, strAutoincremMOVGER: String): Boolean;
  Var
    qryGerEle: TUniQuery;
Begin
  qryGerEle := fCriaQuery;
  try
    If Not strAutoincremMOVGER.IsEmpty Then
    Begin
      qryGerEle.SQL.Add(' SELECT GER_NUMDOC AS GER_DOCENT,            ');
      qryGerEle.SQL.Add('        IF(GER_ESPDOC = "PD", "TE", GER_ESPDOC) AS GER_ESPENT,  ');
      qryGerEle.SQL.Add('        GER_CODEMP AS GER_EMPENT,            ');
      qryGerEle.SQL.Add('        GER_SERIE_ AS B07_SERIE,             ');
      qryGerEle.SQL.Add('        GER_CODFOR AS GER_CODFOR,            ');
      qryGerEle.SQL.Add('        CAST("" AS CHAR(1)) AS LTP_OPERES    ');
      qryGerEle.SQL.Add('FROM MOVGER                                  ');
      qryGerEle.SQL.Add('WHERE AUTOINCREM = :AUTINC                  ');

      qryGerEle.ParamByName('AUTINC').AsString := strAutoincremMOVGER;

    End Else
    Begin
      qryGerEle.SQL.Add(' SELECT GER_DOCENT,                          ');
      qryGerEle.SQL.Add('        IF(GER_ESPENT = "PD", "TE", GER_ESPENT) AS GER_ESPENT,                          ');
      qryGerEle.SQL.Add('        GER_EMPENT,                          ');
      qryGerEle.SQL.Add('        B07_SERIE,                           ');
      qryGerEle.SQL.Add('        GER_CODFOR,                          ');
      qryGerEle.SQL.Add('        LTP_OPERES                           ');
      qryGerEle.SQL.Add('FROM GERELE                                  ');
      qryGerEle.SQL.Add('LEFT JOIN LOTPRE ON GER_DOCENT = LTP_NUMDOC  ');
      qryGerEle.SQL.Add('                AND IF(GERELE.GER_ESPENT = "PD", "TE", GERELE.GER_ESPENT) = LTP_ESPDOC  ');
      qryGerEle.SQL.Add('                AND GER_EMPENT = LTP_CODEMP  ');
      qryGerEle.SQL.Add('                AND B07_SERIE  = LTP_SERIE_  ');
      qryGerEle.SQL.Add('                AND GER_CODFOR = LTP_CODFOR  ');
      qryGerEle.SQL.Add('WHERE GERELE.AUTOINCREM = :AUTINC            ');

      qryGerEle.ParamByName('AUTINC').AsString := strAutoincremGERELE;
    End;

    qryGerEle.Open;


    Result := fCarregaDadosLotePreco(qryGerEle.FieldByName('GER_DOCENT').AsString,
                                     qryGerEle.FieldByName('GER_ESPENT').AsString,
                                     qryGerEle.FieldByName('GER_EMPENT').AsString,
                                     qryGerEle.FieldByName('B07_SERIE').AsString,
                                     qryGerEle.FieldByName('GER_CODFOR').AsString,
                                     qryGerEle.FieldByName('LTP_OPERES').AsString);

    qryGerEle.Close;

  finally
    FreeAndNil(qryGerEle);
  end;


End;

function TLotePrecos.fCarregaPreMedPrg(pgbProgresso: TCxProgressBar): Boolean;
var
  fltPreMed: Double;
  intRecNo: Integer;
begin
  If (intOpcCarregaPreMed = 1) And (stlListSelecao.Count = 0) Then
  Begin
    pMensagemOK('Nenhum item selecionado!');
    Exit(True);
  End;

  intRecNo := cdsConsulta.RecNo;
  FStrCodIteProcessando := '';
  Try
    cdsConsulta.DisableControls;
    pgbProgresso.Properties.Max := cdsConsulta.RecordCount;

    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      If (intOpcCarregaPreMed = 1) And (stlListSelecao.IndexOf(QuotedStr(cdsConsulta.FieldByName('AUTOINCREM').AsString)) = -1) Then
      Begin
        cdsConsulta.Next;
        Continue;
      End;

      If cdsPrecos.Locate('NOMCAM', 'LTP_PRECOM', []) Then
      Begin
        fltPreMed := cdsConsulta.FieldByName('PREMED').AsFloat;
        FStrCodIteProcessando := ' (Item: ' + cdsConsulta.FieldByName('ITE_CODITE').AsString + ')';
        pAlterarPrecoMargem(True,
                            cdsConsulta,
                            cdsPrecos,
                            -1,
                            -1,
                            0,
                            False,
                            fltPreMed);
      End;

      cdsConsulta.Next;
      pgbProgresso.Position := pgbProgresso.Position + 1;
    End;
    Result := True;
    pMensagemOk('Preços carregados com sucesso!');
  Finally
    cdsConsulta.EnableControls;
    cdsConsulta.RecNo := intRecNo;
  End;

end;

Procedure TLotePrecos.pChecaDolarNoPedido(FNumDoc, FEspDoc, FCodEmp: String; Var infCotacao: TInfoCotacao; Var fltCotao: Double);
  Var
    qryMovDet: TUniQuery;
    strSQL: String;
Begin
  Try
    infCotacao := infoNaoPedirCotacao;

    qryMovDet := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   PCG_MOEDA_,                                     ';
    strSQL := strSQL + '   SUM(IF(ITE_PREDOL  = "S", 1, 0)) AS QTD_DOLAR,  ';
    strSQL := strSQL + '   SUM(IF(ITE_PREDOL <> "S", 1, 0)) AS QTD_REAL,   ';
    strSQL := strSQL + '   COUNT(*)                         AS QTD_PROD    ';
    strSQL := strSQL + ' FROM PCMDET D ';
    strSQL := strSQL + ' INNER JOIN ITEGER ON ITE_CODITE = PCD_CODITE   ';
    strSQL := strSQL + '                  AND ITE_CODEMP = PCD_CODEMP   ';

    strSQL := strSQL + ' INNER JOIN PCMGER ON  ';
    strSQL := strSQL + '       PCD_NUMPED = PCG_NUMPED ';
    strSQL := strSQL + '   AND PCD_ESPDOC = PCG_ESPDOC ';
    strSQL := strSQL + '   AND PCD_CODEMP = PCG_CODEMP ';
    strSQL := strSQL + '   AND PCD_NUMCTN = PCG_NUMCTN ';

    strSQL := strSQL + ' WHERE  ';
    strSQL := strSQL + '       PCD_NUMPED = :NUMDOC ';
    strSQL := strSQL + '   AND PCD_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '   AND PCD_CODEMP = :CODEMP ';
    strSQL := strSQL + '   AND PCD_NUMCTN = 0       ';

    qryMovDet.SQL.Text := strSQL;
    qryMovDet.ParamByName('NUMDOC').AsString := FNumDoc;
    qryMovDet.ParamByName('ESPDOC').AsString := FEspDoc;
    qryMovDet.ParamByName('CODEMP').AsString := FCodEmp;
    qryMovDet.Open;

    If qryMovDet.FieldByName('PCG_MOEDA_').AsInteger = INT_MOEDA_DOLAR Then
    Begin

      If qryMovDet.FieldByName('QTD_DOLAR').AsInteger <> qryMovDet.FieldByName('QTD_PROD').AsInteger Then
      Begin

        infCotacao := infoPedidoEmDolar;

      End Else
      Begin
        qryMovDet.Close;
        qryMovDet.SQL.Text := 'SELECT MOE_DOLVEN FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1';
        qryMovDet.Open;

        fltCotao := qryMovDet.FieldByName('MOE_DOLVEN').AsFloat;

        If fltCotao = 0 Then
          infCotacao := infoPedidoEmDolar;
      End;

    End Else
    Begin

      If qryMovDet.FieldByName('QTD_DOLAR').AsInteger > 0 Then
        infCotacao := infoItemEmDolar;

    End;

    FreeAndNil(qryMovDet);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pChecaDolarNoPedido]');
    End;
  End;
End;

function TLotePrecos.fTemProdutosEmDolar(FCodFor, FNumDoc, FEspDoc, FSerie_, FCodEmp: String; Var fltCotDol: Double): Boolean;
  Var
    qryMovDet: TUniQuery;
    strSQL: String;
Begin
  Try
    fltCotDol := 0;

    qryMovDet := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT AUX_COTMOE, COUNT(*) AS QTD ';
    strSQL := strSQL + ' FROM MOVDET D ';
    strSQL := strSQL + ' INNER JOIN AUXMOV ON AUX_SEQGER = D.DET_SEQGER ';
    strSQL := strSQL + ' INNER JOIN ITEGER ON ITE_CODITE = DET_CODITE   ';
    strSQL := strSQL + '                  AND ITE_CODEMP = DET_CODEMP   ';
    strSQL := strSQL + ' WHERE ITE_PREDOL = "S" ';
    strSQL := strSQL + '   AND DET_CODFOR = :CODFOR ';
    strSQL := strSQL + '   AND DET_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '   AND DET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '   AND DET_SERIE_ = :SERIE_ ';
    strSQL := strSQL + '   AND DET_CODEMP = :CODEMP ';

    qryMovDet.SQL.Text := strSQL;
    qryMovDet.ParamByName('CODFOR').AsString := FCodFor;
    qryMovDet.ParamByName('NUMDOC').AsString := FNumDoc;
    qryMovDet.ParamByName('ESPDOC').AsString := FEspDoc;
    qryMovDet.ParamByName('SERIE_').AsString := FSerie_;
    qryMovDet.ParamByName('CODEMP').AsString := FCodEmp;
    qryMovDet.Open;

    Result := qryMovDet.FieldByName('QTD').AsInteger > 0;

    If Result Then
      fltCotDol := qryMovDet.FieldByName('AUX_COTMOE').AsFloat;

    FreeAndNil(qryMovDet);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TLotePrecos.fTemProdutosEmDolar]');
      Result := False;
    End;
  End;

End;

function TLotePrecos.fPesquisarLotes(Form: TForm): Boolean;
  Var
    qryLotePreco: TUniQuery;
    arrSel   : TConsultasArray;
    chrKey   : Char;
    objPnlLegenda: TPanelCxAtivacaoLotePreco;
begin
  inherited;

  Result := False;

  qryLotePreco := fCriaQuery;
  try
    chrKey := '/';
    FCotDol := 0;

    frmPnlDadosAtivacaoLotePreco := TfrmPnlDadosAtivacaoLotePreco.Create(nil);
    objPnlLegenda := TPanelCxAtivacaoLotePreco.Create(TfrmPnlDadosAtivacaoLotePreco);

    If fPesqLotePre(Form, qryLotePreco, chrKey, arrSel, True, 'Consulta de Lotes de Preço', objPnlLegenda) Then
    begin
      Result := fCarregaDadosLotePreco(qryLotePreco.FieldByName('LTP_NUMDOC').AsString,
                                       qryLotePreco.FieldByName('LTP_ESPDOC').AsString,
                                       qryLotePreco.FieldByName('LTP_CODEMP').AsString,
                                       qryLotePreco.FieldByName('LTP_SERIE_').AsString,
                                       qryLotePreco.FieldByName('LTP_CODFOR').AsString,
                                       qryLotePreco.FieldByName('LTP_OPERES').AsString);
    end;

  finally
  FreeAndNil(qryLotePreco);
  FreeAndNil(objPnlLegenda);
  FreeAndNil(frmPnlDadosAtivacaoLotePreco);
  end;
end;

function TLotePrecos.fPesquisarPedidos(Form: TForm): Boolean;
  Var
    qryLotePreco: TUniQuery;
    arrSel   : TConsultasArray;
    chrKey   : Char;
    strDoc : String;
    strCodEmp: String;
    infCotacao: TInfoCotacao;
begin
  inherited;

  Result := False;

  qryLotePreco := fCriaQuery;

  chrKey := '/';

  If Not (fCfgSis('EMPGER', varBoolean) And fCfgSis('LOTGER', varBoolean)) Then
    strCodEmp := VS_strCodEmp
  Else
    strCodEmp := '';

  FCotDol := 0;

  If fPesqPedidoCompra(Form,
                       Nil,
                       qryLotePreco,
                       chrKey,
                       arrSel,
                       strDoc,
                       strCodEmp,
                       0,
                       True,
                       Nil,
                       '3.600',
                       'Consulta de Pedidos de Compra',
                       True) Then
  Begin
    Result := True;
    FCodFor := qryLotePreco.FieldByName('PCG_CODFOR').AsString;
    FNumDoc := qryLotePreco.FieldByName('PCG_NUMPED').AsString;
    FOpeRes := qryLotePreco.FieldByName('PCG_CODCMP').AsString;
    FEspDoc := qryLotePreco.FieldByName('PCG_ESPDOC').AsString;
    FSerie_ := '';
    FCodEmp := qryLotePreco.FieldByName('PCG_CODEMP').AsString;
    FTotFre := qryLotePreco.FieldByName('PCG_VALFRE').AsFloat;
    FTotIte := qryLotePreco.FieldByName('PCG_TOTITE').AsFloat;

    If fCfgSis('COTDOR', varBoolean) Then
    Begin
      pChecaDolarNoPedido(FNumDoc, FEspDoc, FCodEmp, infCotacao, FCotDol);

      Result := (infCotacao = infoNaoPedirCotacao) Or TfrmPedeCotacaoMoeda.fPedeCotacaoMoeda(FCotDol, infCotacao);
    End;

  End;

  FreeAndNil(qryLotePreco);
end;

procedure TLotePrecos.pBaixarLotePrecos(DataSet: TDataSet; strProPri: String; blnGeraPreIte: Boolean = False; dtaDtaAtu: TDateTime = 0);
Begin
  If SameText(DataSet.FieldbyName('TABELA').AsString, 'PCMDET') Then
    pBaixarPedido(DataSet, strProPri, blnGeraPreIte, dtaDtaAtu)
  Else
  Begin
    pBaixarLote(DataSet, strProPri, blnGeraPreIte, dtaDtaAtu);
    pGravarEfetivacaoPreco(DataSet);
    If blnResLtp Then
      fApagaReservaEnderecamento(DataSet);
  End;

  If blnValFor Then
    pAtualizarDataValFornecedor(DataSet);

  pAtualizaGrupoPrecosItem(DataSet);
End;

procedure TLotePrecos.pAtualizarDataValFornecedor(DataSet: TDataSet);
var
  strUpdate: String;
  qryIteGer: TUniQuery;
begin
  strUpdate := '';
  strUpdate := strUpdate + ' UPDATE ITEGER SET       ';
  strUpdate := strUpdate + '   ITE_DTAVAL = :DTAVAL  ';
  strUpdate := strUpdate + ' WHERE                   ';
  strUpdate := strUpdate + '   ITE_CODITE = :CODITE AND ';
  strUpdate := strUpdate + '   ITE_CODEMP = :CODEMP  ';

  qryIteGer := fCriaQuery(Self);

  with qryIteGer, SQL do
  begin
    Close;
    Clear;
    Add(strUpdate);

    ParamByName('DTAVAL').AsDateTime := DataSet.FieldByName('LTP_DTAVAL').AsDateTime;
    ParamByName('CODITE').AsString   := DataSet.FieldByName('LTP_CODITE').AsString;
    ParamByName('CODEMP').AsString   := FCodEmp;

    ExecSQL;
  end;

  FreeAndNil(qryIteGer);

end;

procedure TLotePrecos.pBaixarPedido(DataSet: TDataSet; strProPri: String; blnGeraPreIte: Boolean = False; dtaDtaAtu: TDateTime = 0);
  var
    strUpdate: String;
    qryGeral: TUniQuery;
begin
  strUpdate := '';
  strUpdate := strUpdate + ' UPDATE PCMDET SET       ';
  strUpdate := strUpdate + '   PCD_PREATU = "S"      ';
  strUpdate := strUpdate + ' WHERE                   ';
  strUpdate := strUpdate + '   AUTOINCREM = :AUTINC  ';

  qryGeral := fCriaQuery(Self);

  With qryGeral, SQL Do
  Begin
    Close;
    Clear;
    Add(strUpdate);

    ParamByName('AUTINC').AsString := DataSet.FieldByName('AUTOINCREM').AsString;

    If blnGeraPreIte Then
    Begin
      pIncluiPreIte(DataSet, dtaDtaAtu, strProPri);
    End;

    ExecSQL;
  End;

  FreeAndNil(qryGeral);
End;

procedure TLotePrecos.pBaixarLote(DataSet: TDataSet; strProPri: String; blnGeraPreIte: Boolean = False; dtaDtaAtu: TDateTime = 0);
  var
    strUpdate: String;
    qryGeral: TUniQuery;
begin
  strUpdate := '';
  strUpdate := strUpdate + ' UPDATE ' + DataSet.FieldByName('TABELA').AsString + ' SET ';
  strUpdate := strUpdate + '   LTP_BAIXAD = "S",     ';
  strUpdate := strUpdate + '   LTP_DTABAI = :DTABAI, ';
  strUpdate := strUpdate + '   LTP_HORBAI = :HORBAI, ';
  strUpdate := strUpdate + '   LTP_OPEBAI = :OPEBAI, ';
  strUpdate := strUpdate + '   LTP_ATUALI = :ATUALI, ';
  strUpdate := strUpdate + '   LTP_DTAATU = :DTAATU  ';
  strUpdate := strUpdate + ' WHERE ';
  strUpdate := strUpdate + '   AUTOINCREM = :AUTINC  ';

  qryGeral := fCriaQuery(Self);

  With qryGeral, SQL Do
  Begin
    Close;
    Clear;
    Add(strUpdate);

    ParamByName('AUTINC').AsString := DataSet.FieldByName('AUTOINCREM').AsString;

    ParamByName('DTABAI').AsDate   := VS_Date;
    ParamByName('HORBAI').AsTime   := fTime();
    ParamByName('OPEBAI').AsString := strLoginUsuarioLogado;

    If blnGeraPreIte Then
    Begin
      ParamByName('ATUALI').AsString := 'S';
      ParamByName('DTAATU').AsDate   := dtaDtaAtu;
      pIncluiPreIte(DataSet, dtaDtaAtu, strProPri);
    End
    Else
    Begin
      ParamByName('ATUALI').AsString := 'N';
      ParamByName('DTAATU').Value    := Null;
    End;

    ExecSQL;
  End;

  FreeAndNil(qryGeral);
end;

procedure TLotePrecos.pAtualizaLote(DataSet: TDataSet);
  var
    strSql: String;
    qryLotPre: TUniQuery;
Begin
  strSql := '';
  strSql := strSql + ' UPDATE LOTPRE SET ';

  strSql := strSql + ' LTP_PRECOM_ANT  = :PRECOM_ANT, ';
  strSql := strSql + ' LTP_DESF01_ANT  = :DESF01_ANT, ';
  strSql := strSql + ' LTP_DESF02_ANT  = :DESF02_ANT, ';
  strSql := strSql + ' LTP_DESF03_ANT  = :DESF03_ANT, ';
  strSql := strSql + ' LTP_DESF04_ANT  = :DESF04_ANT, ';
  strSql := strSql + ' LTP_DESF05_ANT  = :DESF05_ANT, ';
  strSql := strSql + ' LTP_DESF06_ANT  = :DESF06_ANT, ';
  strSql := strSql + ' LTP_ICMENT_ANT  = :ICMENT_ANT, ';
  strSql := strSql + ' LTP_SUBFED_ANT  = :SUBFED_ANT, ';
  strSql := strSql + ' LTP_IPIENT_ANT  = :IPIENT_ANT, ';
  strSql := strSql + ' LTP_FREENT_ANT  = :FREENT_ANT, ';
  strSql := strSql + ' LTP_VALFRE_ANT  = :VALFRE_ANT, ';
  strSql := strSql + ' LTP_ACRFIN_ANT  = :ACRFIN_ANT, ';
  strSql := strSql + ' LTP_SUBSTI_ANT  = :SUBSTI_ANT, ';
  strSql := strSql + ' LTP_DESADB_ANT  = :DESADB_ANT, ';
  strSql := strSql + ' LTP_OUTVAL_ANT  = :OUTVAL_ANT, ';
  strSql := strSql + ' LTP_IMPFED_ANT  = :IMPFED_ANT, ';
  strSql := strSql + ' LTP_DESOPE_ANT  = :DESOPE_ANT, ';
  strSql := strSql + ' LTP_PRECUS_ANT  = :PRECUS_ANT, ';
  strSql := strSql + ' LTP_ICMSAI_ANT  = :ICMSAI_ANT, ';
  strSql := strSql + ' LTP_MARBR1_ANT  = :MARBR1_ANT, ';
  strSql := strSql + ' LTP_PREVE1_ANT  = :PREVE1_ANT, ';
  strSql := strSql + ' LTP_COMTB1_ANT  = :COMTB1_ANT, ';
  strSql := strSql + ' LTP_MARBR2_ANT  = :MARBR2_ANT, ';
  strSql := strSql + ' LTP_PREVE2_ANT  = :PREVE2_ANT, ';
  strSql := strSql + ' LTP_COMTB2_ANT  = :COMTB2_ANT, ';
  strSql := strSql + ' LTP_MARBR3_ANT  = :MARBR3_ANT, ';
  strSql := strSql + ' LTP_PREVE3_ANT  = :PREVE3_ANT, ';
  strSql := strSql + ' LTP_COMTB3_ANT  = :COMTB3_ANT, ';
  strSql := strSql + ' LTP_MARBR4_ANT  = :MARBR4_ANT, ';
  strSql := strSql + ' LTP_PREVE4_ANT  = :PREVE4_ANT, ';
  strSql := strSql + ' LTP_COMTB4_ANT  = :COMTB4_ANT, ';
  strSql := strSql + ' LTP_MARBR5_ANT  = :MARBR5_ANT, ';
  strSql := strSql + ' LTP_PREVE5_ANT  = :PREVE5_ANT, ';
  strSql := strSql + ' LTP_COMTB5_ANT  = :COMTB5_ANT, ';
  strSql := strSql + ' LTP_MARBR6_ANT  = :MARBR6_ANT, ';
  strSql := strSql + ' LTP_PREVE6_ANT  = :PREVE6_ANT, ';
  strSql := strSql + ' LTP_COMTB6_ANT  = :COMTB6_ANT, ';
  strSql := strSql + ' LTP_MARBR7_ANT  = :MARBR7_ANT, ';
  strSql := strSql + ' LTP_PREVE7_ANT  = :PREVE7_ANT, ';
  strSql := strSql + ' LTP_COMTB7_ANT  = :COMTB7_ANT, ';
  strSql := strSql + ' LTP_COMLIQ_ANT  = :COMLIQ_ANT, ';
  strSql := strSql + ' LTP_TCIFCU_ANT  = :TCIFCU_ANT, ';
  strSql := strSql + ' LTP_TSCUST_ANT  = :TSCUST_ANT, ';
  strSql := strSql + ' LTP_DEPICO_ANT  = :DEPICO_ANT, ';
  strSql := strSql + ' LTP_DEICMS_ANT  = :DEICMS_ANT, ';
  strSql := strSql + ' LTP_FATREG_ANT  = :FATREG_ANT, ';


  strSql := strSql + ' LTP_PRECOM_ALT  = :PRECOM_ALT, ';
  strSql := strSql + ' LTP_DESF01_ALT  = :DESF01_ALT, ';
  strSql := strSql + ' LTP_DESF02_ALT  = :DESF02_ALT, ';
  strSql := strSql + ' LTP_DESF03_ALT  = :DESF03_ALT, ';
  strSql := strSql + ' LTP_DESF04_ALT  = :DESF04_ALT, ';
  strSql := strSql + ' LTP_DESF05_ALT  = :DESF05_ALT, ';
  strSql := strSql + ' LTP_DESF06_ALT  = :DESF06_ALT, ';
  strSql := strSql + ' LTP_COMLIQ_ALT  = :COMLIQ_ALT, ';
  strSql := strSql + ' LTP_ICMENT_ALT  = :ICMENT_ALT, ';
  strSql := strSql + ' LTP_SUBFED_ALT  = :SUBFED_ALT, ';
  strSql := strSql + ' LTP_IPIENT_ALT  = :IPIENT_ALT, ';
  strSql := strSql + ' LTP_FREENT_ALT  = :FREENT_ALT, ';
  strSql := strSql + ' LTP_VALFRE_ALT  = :VALFRE_ALT, ';
  strSql := strSql + ' LTP_ACRFIN_ALT  = :ACRFIN_ALT, ';
  strSql := strSql + ' LTP_SUBSTI_ALT  = :SUBSTI_ALT, ';
  strSql := strSql + ' LTP_DESADB_ALT  = :DESADB_ALT, ';
  strSql := strSql + ' LTP_OUTVAL_ALT  = :OUTVAL_ALT, ';
  strSql := strSql + ' LTP_IMPFED_ALT  = :IMPFED_ALT, ';
  strSql := strSql + ' LTP_DESOPE_ALT  = :DESOPE_ALT, ';
  strSql := strSql + ' LTP_PRECUS_ALT  = :PRECUS_ALT, ';
  strSql := strSql + ' LTP_ICMSAI_ALT  = :ICMSAI_ALT, ';
  strSql := strSql + ' LTP_MARBR1_ALT  = :MARBR1_ALT, ';
  strSql := strSql + ' LTP_MARBR2_ALT  = :MARBR2_ALT, ';
  strSql := strSql + ' LTP_MARBR3_ALT  = :MARBR3_ALT, ';
  strSql := strSql + ' LTP_MARBR4_ALT  = :MARBR4_ALT, ';
  strSql := strSql + ' LTP_MARBR5_ALT  = :MARBR5_ALT, ';
  strSql := strSql + ' LTP_MARBR6_ALT  = :MARBR6_ALT, ';
  strSql := strSql + ' LTP_MARBR7_ALT  = :MARBR7_ALT, ';
  strSql := strSql + ' LTP_PREVE1_ALT  = :PREVE1_ALT, ';
  strSql := strSql + ' LTP_PREVE2_ALT  = :PREVE2_ALT, ';
  strSql := strSql + ' LTP_PREVE3_ALT  = :PREVE3_ALT, ';
  strSql := strSql + ' LTP_PREVE4_ALT  = :PREVE4_ALT, ';
  strSql := strSql + ' LTP_PREVE5_ALT  = :PREVE5_ALT, ';
  strSql := strSql + ' LTP_PREVE6_ALT  = :PREVE6_ALT, ';
  strSql := strSql + ' LTP_PREVE7_ALT  = :PREVE7_ALT, ';
  strSql := strSql + ' LTP_COMTB1_ALT  = :COMTB1_ALT, ';
  strSql := strSql + ' LTP_COMTB2_ALT  = :COMTB2_ALT, ';
  strSql := strSql + ' LTP_COMTB3_ALT  = :COMTB3_ALT, ';
  strSql := strSql + ' LTP_COMTB4_ALT  = :COMTB4_ALT, ';
  strSql := strSql + ' LTP_COMTB5_ALT  = :COMTB5_ALT, ';
  strSql := strSql + ' LTP_COMTB6_ALT  = :COMTB6_ALT, ';
  strSql := strSql + ' LTP_COMTB7_ALT  = :COMTB7_ALT, ';
  strSql := strSql + ' LTP_TCIFCU_ALT  = :TCIFCU_ALT, ';
  strSql := strSql + ' LTP_TSCUST_ALT  = :TSCUST_ALT, ';
  strSql := strSql + ' LTP_DEPICO_ALT  = :DEPICO_ALT, ';
  strSql := strSql + ' LTP_DEICMS_ALT  = :DEICMS_ALT, ';
  strSql := strSql + ' LTP_FATREG_ALT  = :FATREG_ALT  ';
  strSql := strSql + ' WHERE AUTOINCREM = :AUTINC ';

  qryLotPre := fCriaQuery;
  qryLotPre.SQL.Text := strSql;

  qryLotPre.ParamByName('PRECOM_ANT').Value := DataSet.FieldByName('LTP_PRECOM_ANT').Value;
  qryLotPre.ParamByName('DESF01_ANT').Value := DataSet.FieldByName('LTP_DESF01_ANT').Value;
  qryLotPre.ParamByName('DESF02_ANT').Value := DataSet.FieldByName('LTP_DESF02_ANT').Value;
  qryLotPre.ParamByName('DESF03_ANT').Value := DataSet.FieldByName('LTP_DESF03_ANT').Value;
  qryLotPre.ParamByName('DESF04_ANT').Value := DataSet.FieldByName('LTP_DESF04_ANT').Value;
  qryLotPre.ParamByName('DESF05_ANT').Value := DataSet.FieldByName('LTP_DESF05_ANT').Value;
  qryLotPre.ParamByName('DESF06_ANT').Value := DataSet.FieldByName('LTP_DESF06_ANT').Value;
  qryLotPre.ParamByName('ICMENT_ANT').Value := DataSet.FieldByName('LTP_ICMENT_ANT').Value;
  qryLotPre.ParamByName('SUBFED_ANT').Value := DataSet.FieldByName('LTP_SUBFED_ANT').Value;
  qryLotPre.ParamByName('IPIENT_ANT').Value := DataSet.FieldByName('LTP_IPIENT_ANT').Value;
  qryLotPre.ParamByName('FREENT_ANT').Value := DataSet.FieldByName('LTP_FREENT_ANT').Value;
  qryLotPre.ParamByName('VALFRE_ANT').Value := DataSet.FieldByName('LTP_VALFRE_ANT').Value;
  qryLotPre.ParamByName('ACRFIN_ANT').Value := DataSet.FieldByName('LTP_ACRFIN_ANT').Value;
  qryLotPre.ParamByName('SUBSTI_ANT').Value := DataSet.FieldByName('LTP_SUBSTI_ANT').Value;
  qryLotPre.ParamByName('DESADB_ANT').Value := DataSet.FieldByName('LTP_DESADB_ANT').Value;
  qryLotPre.ParamByName('OUTVAL_ANT').Value := DataSet.FieldByName('LTP_OUTVAL_ANT').Value;
  qryLotPre.ParamByName('IMPFED_ANT').Value := DataSet.FieldByName('LTP_IMPFED_ANT').Value;
  qryLotPre.ParamByName('DESOPE_ANT').Value := DataSet.FieldByName('LTP_DESOPE_ANT').Value;
  qryLotPre.ParamByName('PRECUS_ANT').Value := DataSet.FieldByName('LTP_PRECUS_ANT').Value;
  qryLotPre.ParamByName('ICMSAI_ANT').Value := DataSet.FieldByName('LTP_ICMSAI_ANT').Value;
  qryLotPre.ParamByName('MARBR1_ANT').Value := DataSet.FieldByName('LTP_MARBR1_ANT').Value;
  qryLotPre.ParamByName('PREVE1_ANT').Value := DataSet.FieldByName('LTP_PREVE1_ANT').Value;
  qryLotPre.ParamByName('COMTB1_ANT').Value := DataSet.FieldByName('LTP_COMTB1_ANT').Value;
  qryLotPre.ParamByName('MARBR2_ANT').Value := DataSet.FieldByName('LTP_MARBR2_ANT').Value;
  qryLotPre.ParamByName('PREVE2_ANT').Value := DataSet.FieldByName('LTP_PREVE2_ANT').Value;
  qryLotPre.ParamByName('COMTB2_ANT').Value := DataSet.FieldByName('LTP_COMTB2_ANT').Value;
  qryLotPre.ParamByName('MARBR3_ANT').Value := DataSet.FieldByName('LTP_MARBR3_ANT').Value;
  qryLotPre.ParamByName('PREVE3_ANT').Value := DataSet.FieldByName('LTP_PREVE3_ANT').Value;
  qryLotPre.ParamByName('COMTB3_ANT').Value := DataSet.FieldByName('LTP_COMTB3_ANT').Value;
  qryLotPre.ParamByName('MARBR4_ANT').Value := DataSet.FieldByName('LTP_MARBR4_ANT').Value;
  qryLotPre.ParamByName('PREVE4_ANT').Value := DataSet.FieldByName('LTP_PREVE4_ANT').Value;
  qryLotPre.ParamByName('COMTB4_ANT').Value := DataSet.FieldByName('LTP_COMTB4_ANT').Value;
  qryLotPre.ParamByName('MARBR5_ANT').Value := DataSet.FieldByName('LTP_MARBR5_ANT').Value;
  qryLotPre.ParamByName('PREVE5_ANT').Value := DataSet.FieldByName('LTP_PREVE5_ANT').Value;
  qryLotPre.ParamByName('COMTB5_ANT').Value := DataSet.FieldByName('LTP_COMTB5_ANT').Value;
  qryLotPre.ParamByName('MARBR6_ANT').Value := DataSet.FieldByName('LTP_MARBR6_ANT').Value;
  qryLotPre.ParamByName('PREVE6_ANT').Value := DataSet.FieldByName('LTP_PREVE6_ANT').Value;
  qryLotPre.ParamByName('COMTB6_ANT').Value := DataSet.FieldByName('LTP_COMTB6_ANT').Value;
  qryLotPre.ParamByName('MARBR7_ANT').Value := DataSet.FieldByName('LTP_MARBR7_ANT').Value;
  qryLotPre.ParamByName('PREVE7_ANT').Value := DataSet.FieldByName('LTP_PREVE7_ANT').Value;
  qryLotPre.ParamByName('COMTB7_ANT').Value := DataSet.FieldByName('LTP_COMTB7_ANT').Value;
  qryLotPre.ParamByName('COMLIQ_ANT').Value := DataSet.FieldByName('LTP_COMLIQ_ANT').Value;
  qryLotPre.ParamByName('TCIFCU_ANT').Value := DataSet.FieldByName('LTP_TCIFCU_ANT').Value;
  qryLotPre.ParamByName('TSCUST_ANT').Value := DataSet.FieldByName('LTP_TSCUST_ANT').Value;
  qryLotPre.ParamByName('DEPICO_ANT').Value := DataSet.FieldByName('LTP_DEPICO_ANT').Value;
  qryLotPre.ParamByName('DEICMS_ANT').Value := DataSet.FieldByName('LTP_DEICMS_ANT').Value;
  qryLotPre.ParamByName('FATREG_ANT').Value := DataSet.FieldByName('LTP_FATREG_ANT').Value;

  qryLotPre.ParamByName('PRECOM_ALT').Value := DataSet.FieldByName('LTP_PRECOM_UTI').Value;
  qryLotPre.ParamByName('DESF01_ALT').Value := DataSet.FieldByName('LTP_DESF01_UTI').Value;
  qryLotPre.ParamByName('DESF02_ALT').Value := DataSet.FieldByName('LTP_DESF02_UTI').Value;
  qryLotPre.ParamByName('DESF03_ALT').Value := DataSet.FieldByName('LTP_DESF03_UTI').Value;
  qryLotPre.ParamByName('DESF04_ALT').Value := DataSet.FieldByName('LTP_DESF04_UTI').Value;
  qryLotPre.ParamByName('DESF05_ALT').Value := DataSet.FieldByName('LTP_DESF05_UTI').Value;
  qryLotPre.ParamByName('DESF06_ALT').Value := DataSet.FieldByName('LTP_DESF06_UTI').Value;
  qryLotPre.ParamByName('COMLIQ_ALT').Value := DataSet.FieldByName('LTP_COMLIQ').Value;
  qryLotPre.ParamByName('ICMENT_ALT').Value := DataSet.FieldByName('LTP_ICMENT_UTI').Value;
  qryLotPre.ParamByName('SUBFED_ALT').Value := DataSet.FieldByName('LTP_SUBFED_UTI').Value;
  qryLotPre.ParamByName('IPIENT_ALT').Value := DataSet.FieldByName('LTP_IPIENT_UTI').Value;
  qryLotPre.ParamByName('FREENT_ALT').Value := DataSet.FieldByName('LTP_FREENT_UTI').Value;
  qryLotPre.ParamByName('VALFRE_ALT').Value := DataSet.FieldByName('LTP_VALFRE_UTI').Value;
  qryLotPre.ParamByName('ACRFIN_ALT').Value := DataSet.FieldByName('LTP_ACRFIN_UTI').Value;
  qryLotPre.ParamByName('SUBSTI_ALT').Value := DataSet.FieldByName('LTP_SUBSTI_UTI').Value;
  qryLotPre.ParamByName('DESADB_ALT').Value := DataSet.FieldByName('LTP_DESADB_UTI').Value;
  qryLotPre.ParamByName('OUTVAL_ALT').Value := DataSet.FieldByName('LTP_OUTVAL_UTI').Value;
  qryLotPre.ParamByName('IMPFED_ALT').Value := DataSet.FieldByName('LTP_IMPFED_UTI').Value;
  qryLotPre.ParamByName('DESOPE_ALT').Value := DataSet.FieldByName('LTP_DESOPE_UTI').Value;
  qryLotPre.ParamByName('PRECUS_ALT').Value := DataSet.FieldByName('LTP_PRECUS').Value;
  qryLotPre.ParamByName('ICMSAI_ALT').Value := DataSet.FieldByName('LTP_ICMSAI_UTI').Value;
  qryLotPre.ParamByName('MARBR1_ALT').Value := DataSet.FieldByName('LTP_MARBR1').Value;
  qryLotPre.ParamByName('MARBR2_ALT').Value := DataSet.FieldByName('LTP_MARBR2').Value;
  qryLotPre.ParamByName('MARBR3_ALT').Value := DataSet.FieldByName('LTP_MARBR3').Value;
  qryLotPre.ParamByName('MARBR4_ALT').Value := DataSet.FieldByName('LTP_MARBR4').Value;
  qryLotPre.ParamByName('MARBR5_ALT').Value := DataSet.FieldByName('LTP_MARBR5').Value;
  qryLotPre.ParamByName('MARBR6_ALT').Value := DataSet.FieldByName('LTP_MARBR6').Value;
  qryLotPre.ParamByName('MARBR7_ALT').Value := DataSet.FieldByName('LTP_MARBR7').Value;
  qryLotPre.ParamByName('PREVE1_ALT').Value := DataSet.FieldByName('LTP_PREVE1').Value;
  qryLotPre.ParamByName('PREVE2_ALT').Value := DataSet.FieldByName('LTP_PREVE2').Value;
  qryLotPre.ParamByName('PREVE3_ALT').Value := DataSet.FieldByName('LTP_PREVE3').Value;
  qryLotPre.ParamByName('PREVE4_ALT').Value := DataSet.FieldByName('LTP_PREVE4').Value;
  qryLotPre.ParamByName('PREVE5_ALT').Value := DataSet.FieldByName('LTP_PREVE5').Value;
  qryLotPre.ParamByName('PREVE6_ALT').Value := DataSet.FieldByName('LTP_PREVE6').Value;
  qryLotPre.ParamByName('PREVE7_ALT').Value := DataSet.FieldByName('LTP_PREVE7').Value;
  qryLotPre.ParamByName('COMTB1_ALT').Value := DataSet.FieldByName('LTP_COMTB1').Value;
  qryLotPre.ParamByName('COMTB2_ALT').Value := DataSet.FieldByName('LTP_COMTB2').Value;
  qryLotPre.ParamByName('COMTB3_ALT').Value := DataSet.FieldByName('LTP_COMTB3').Value;
  qryLotPre.ParamByName('COMTB4_ALT').Value := DataSet.FieldByName('LTP_COMTB4').Value;
  qryLotPre.ParamByName('COMTB5_ALT').Value := DataSet.FieldByName('LTP_COMTB5').Value;
  qryLotPre.ParamByName('COMTB6_ALT').Value := DataSet.FieldByName('LTP_COMTB6').Value;
  qryLotPre.ParamByName('COMTB7_ALT').Value := DataSet.FieldByName('LTP_COMTB7').Value;
  qryLotPre.ParamByName('TCIFCU_ALT').Value := DataSet.FieldByName('LTP_TCIFCU_UTI').Value;
  qryLotPre.ParamByName('TSCUST_ALT').Value := DataSet.FieldByName('LTP_TSCUST_UTI').Value;
  qryLotPre.ParamByName('DEPICO_ALT').Value := DataSet.FieldByName('LTP_DEPICO_UTI').Value;
  qryLotPre.ParamByName('DEICMS_ALT').Value := DataSet.FieldByName('LTP_DEICMS_UTI').Value;
  qryLotPre.ParamByName('FATREG_ALT').Value := DataSet.FieldByName('LTP_FATREG_UTI').Value;

  qryLotPre.ParamByName('AUTINC').Value := DataSet.FieldByName('AUTOINCREM').Value;
  qryLotPre.ExecSQL;
End;

procedure TLotePrecos.pIncluiPreIte(DataSet: TDataSet; dtaDtaAtu: TDateTime; strProPri: String);
  var
    strSql: String;
    intCont: Integer;
    qryGenIte: TUniQuery;
Begin
  pAtualizaLote(DataSet);

  fExecutaSQL(' DELETE FROM PREITE ' +
              ' WHERE PRE_DTAPRE = ' + fCurrentDate(dtaDtaAtu)  + '  AND ' +
              '       PRE_CODITE = ' + QuotedStr(DataSet.FieldByName('LTP_CODITE').AsString));

  strSql := '';
  strSql := strSql + 'INSERT INTO ';
  strSql := strSql + '  PREITE ';
  strSql := strSql + '(PRE_DTAPRE, ';
  strSql := strSql + ' PRE_CODITE, ';
  strSql := strSql + ' PRE_CODEMP, ';
  strSql := strSql + ' PRE_NOMFRM, ';
  strSql := strSql + ' AUTOINCREM, ';
  If Not FEhPedido Then
  Begin
    strSql := strSql + ' PRE_LOTPRE, ';
    strSql := strSql + ' PRE_SEQDET, ';
  End;

  strSql := strSql + ' PRE_PRECOM_ANT, ';
  strSql := strSql + ' PRE_PRECOM, ';
  strSql := strSql + ' PRE_DESF01, ';
  strSql := strSql + ' PRE_DESF02, ';
  strSql := strSql + ' PRE_DESF03, ';
  strSql := strSql + ' PRE_DESF04, ';
  strSql := strSql + ' PRE_DESF05, ';
  strSql := strSql + ' PRE_DESF06, ';
  strSql := strSql + ' PRE_ICMENT, ';
  strSql := strSql + ' PRE_SUBFED, ';
  strSql := strSql + ' PRE_IPIENT, ';
  strSql := strSql + ' PRE_FREENT, ';
  strSql := strSql + ' PRE_VALFRE, ';
  strSql := strSql + ' PRE_ACRFIN, ';
  strSql := strSql + ' PRE_SUBSTI, ';
  strSql := strSql + ' PRE_DESADB, ';
  strSql := strSql + ' PRE_OUTVAL, ';
  strSql := strSql + ' PRE_ICMSAI, ';
  strSql := strSql + ' PRE_IMPFED, ';
  strSql := strSql + ' PRE_MLTCOM, ';
  strSql := strSql + ' PRE_DESOPE, ';
  strSql := strSql + ' PRE_PRECUS, ';
  strSql := strSql + ' PRE_PRECUS_NOV, ';
  
  strSql := strSql + ' PRE_DESMAX, ';
  strSql := strSql + ' PRE_DESMGE, ';
  strSql := strSql + ' PRE_DESMSU, ';
  strSql := strSql + ' PRE_DESMVM, ';
  strSql := strSql + ' PRE_DESMSM, ';
  strSql := strSql + ' PRE_DESMGM, ';

  strSql := strSql + ' PRE_TCIFCU, ';
  strSql := strSql + ' PRE_TSCUST, ';
  strSql := strSql + ' PRE_DEPICO, ';
  strSql := strSql + ' PRE_DEICMS, ';
  strSql := strSql + ' PRE_FATREG, ';

  strSql := strSql + ' PRE_COMTB1, ';
  strSql := strSql + ' PRE_COMTB2, ';
  strSql := strSql + ' PRE_COMTB3, ';
  strSql := strSql + ' PRE_COMTB4, ';
  strSql := strSql + ' PRE_COMTB5, ';
  strSql := strSql + ' PRE_COMTB6, ';
  strSql := strSql + ' PRE_COMTB7, ';

  strSql := strSql + ' PRE_MARBR1, ';
  strSql := strSql + ' PRE_MARBR1_NOV, ';
  strSql := strSql + ' PRE_PREVE1, ';
  strSql := strSql + ' PRE_PREVE1_NOV, ';
  strSql := strSql + ' PRE_MARBR2, ';
  strSql := strSql + ' PRE_MARBR2_NOV, ';
  strSql := strSql + ' PRE_PREVE2, ';
  strSql := strSql + ' PRE_PREVE2_NOV, ';
  strSql := strSql + ' PRE_MARBR3, ';
  strSql := strSql + ' PRE_MARBR3_NOV, ';
  strSql := strSql + ' PRE_PREVE3, ';
  strSql := strSql + ' PRE_PREVE3_NOV, ';
  strSql := strSql + ' PRE_MARBR4, ';
  strSql := strSql + ' PRE_MARBR4_NOV, ';
  strSql := strSql + ' PRE_PREVE4, ';
  strSql := strSql + ' PRE_PREVE4_NOV, ';
  strSql := strSql + ' PRE_MARMIN, ';
  strSql := strSql + ' PRE_MARBR5, ';
  strSql := strSql + ' PRE_MARBR5_NOV, ';
  strSql := strSql + ' PRE_PREVE5, ';
  strSql := strSql + ' PRE_PREVE5_NOV, ';
  strSql := strSql + ' PRE_MARBR6, ';
  strSql := strSql + ' PRE_MARBR6_NOV, ';
  strSql := strSql + ' PRE_PREVE6, ';
  strSql := strSql + ' PRE_PREVE6_NOV, ';
  strSql := strSql + ' PRE_MARBR7, ';
  strSql := strSql + ' PRE_MARBR7_NOV, ';
  strSql := strSql + ' PRE_PREVE7, ';
  strSql := strSql + ' PRE_PREVE7_NOV, ';

  strSql := strSql + ' PRE_MARID1, ';
  strSql := strSql + ' PRE_MARID1_NOV, ';
  strSql := strSql + ' PRE_MARID2, ';
  strSql := strSql + ' PRE_MARID2_NOV, ';
  strSql := strSql + ' PRE_MARID3, ';
  strSql := strSql + ' PRE_MARID3_NOV, ';
  strSql := strSql + ' PRE_MARID4, ';
  strSql := strSql + ' PRE_MARID4_NOV, ';
  strSql := strSql + ' PRE_MARID5, ';
  strSql := strSql + ' PRE_MARID5_NOV, ';
  strSql := strSql + ' PRE_MARID6, ';
  strSql := strSql + ' PRE_MARID6_NOV, ';
  strSql := strSql + ' PRE_MARID7, ';
  strSql := strSql + ' PRE_MARID7_NOV, ';

  strSql := strSql + ' PRE_QTDITE,     ';
  strSql := strSql + ' PRE_PROPRI, ';
  strSql := strSql + ' PRE_CODOPE) ';
  strSql := strSql + '    VALUES ( ';
  strSql := strSql + '  :DTAPRE, ';
  strSql := strSql + '  :CODITE, ';
  strSql := strSql + '  :CODEMP, ';
  strSql := strSql + '  :NOMFRM, ';
  strSql := strSql + '  :AUTOIN, ';

  If Not FEhPedido Then
  Begin
    strSql := strSql + '  :LOTPRE, ';
    strSql := strSql + '  :SEQDET, ';
  End;

  strSql := strSql + '  :PRECOM_ANT, ';
  strSql := strSql + '  :PRECOM, ';
  strSql := strSql + '  :DESF01, ';
  strSql := strSql + '  :DESF02, ';
  strSql := strSql + '  :DESF03, ';
  strSql := strSql + '  :DESF04, ';
  strSql := strSql + '  :DESF05, ';
  strSql := strSql + '  :DESF06, ';
  strSql := strSql + '  :ICMENT, ';
  strSql := strSql + '  :SUBFED, ';
  strSql := strSql + '  :IPIENT, ';
  strSql := strSql + '  :FREENT, ';
  strSql := strSql + '  :VALFRE, ';
  strSql := strSql + '  :ACRFIN, ';
  strSql := strSql + '  :SUBSTI, ';
  strSql := strSql + '  :DESADB, ';
  strSql := strSql + '  :OUTVAL, ';
  strSql := strSql + '  :ICMSAI, ';
  strSql := strSql + '  :IMPFED, ';
  strSql := strSql + '  :MLTCOM, ';
  strSql := strSql + '  :DESOPE, ';
  strSql := strSql + '  :PRECUS, ';
  strSql := strSql + '  :PRECUS_NOV, ';

  strSql := strSql + '  :DESMAX, ';
  strSql := strSql + '  :DESMGE, ';
  strSql := strSql + '  :DESMSU, ';
  strSql := strSql + '  :DESMVM, ';
  strSql := strSql + '  :DESMSM, ';
  strSql := strSql + '  :DESMGM, ';

  strSql := strSql + '  :TCIFCU, ';
  strSql := strSql + '  :TSCUST, ';
  strSql := strSql + '  :DEPICO, ';
  strSql := strSql + '  :DEICMS, ';
  strSql := strSql + '  :FATREG, ';

  strSql := strSql + '  :COMTB1,     ';
  strSql := strSql + '  :COMTB2,     ';
  strSql := strSql + '  :COMTB3,     ';
  strSql := strSql + '  :COMTB4,     ';
  strSql := strSql + '  :COMTB5,     ';
  strSql := strSql + '  :COMTB6,     ';
  strSql := strSql + '  :COMTB7,     ';

  strSql := strSql + '  :MARBR1,     ';
  strSql := strSql + '  :MARBR1_NOV, ';
  strSql := strSql + '  :PREVE1,     ';
  strSql := strSql + '  :PREVE1_NOV, ';

  strSql := strSql + '  :MARBR2,     ';
  strSql := strSql + '  :MARBR2_NOV, ';
  strSql := strSql + '  :PREVE2,     ';
  strSql := strSql + '  :PREVE2_NOV, ';

  strSql := strSql + '  :MARBR3,      ';
  strSql := strSql + '  :MARBR3_NOV, ';
  strSql := strSql + '  :PREVE3,     ';
  strSql := strSql + '  :PREVE3_NOV, ';

  strSql := strSql + '  :MARBR4,     ';
  strSql := strSql + '  :MARBR4_NOV, ';
  strSql := strSql + '  :PREVE4,     ';
  strSql := strSql + '  :PREVE4_NOV, ';

  strSql := strSql + '  :MARMIN,     ';

  strSql := strSql + '  :MARBR5,     ';
  strSql := strSql + '  :MARBR5_NOV, ';
  strSql := strSql + '  :PREVE5,     ';
  strSql := strSql + '  :PREVE5_NOV, ';

  strSql := strSql + '  :MARBR6,     ';
  strSql := strSql + '  :MARBR6_NOV, ';
  strSql := strSql + '  :PREVE6,     ';
  strSql := strSql + '  :PREVE6_NOV, ';

  strSql := strSql + '  :MARBR7,     ';
  strSql := strSql + '  :MARBR7_NOV, ';
  strSql := strSql + '  :PREVE7,     ';
  strSql := strSql + '  :PREVE7_NOV, ';

  strSql := strSql + '  :MARID1,     ';
  strSql := strSql + '  :MARID1_NOV, ';
  strSql := strSql + '  :MARID2,     ';
  strSql := strSql + '  :MARID2_NOV, ';
  strSql := strSql + '  :MARID3,     ';
  strSql := strSql + '  :MARID3_NOV, ';
  strSql := strSql + '  :MARID4,     ';
  strSql := strSql + '  :MARID4_NOV, ';
  strSql := strSql + '  :MARID5,     ';
  strSql := strSql + '  :MARID5_NOV, ';
  strSql := strSql + '  :MARID6,     ';
  strSql := strSql + '  :MARID6_NOV, ';
  strSql := strSql + '  :MARID7,     ';
  strSql := strSql + '  :MARID7_NOV, ';

  strSql := strSql + '  :QTDITE,     ';
  strSql := strSql + '  :PROPRI,     ';
  strSql := strSql + '  :CODOPE)     ';

  qryGenIte := fCriaQuery(Self);

  With DataSet Do
  Begin
    qryGenIte.Close;
    qryGenIte.SQL.Clear;
    qryGenIte.SQL.Add(strSql);

    If Not FEhPedido Then
    Begin
      qryGenIte.ParamByName('LOTPRE').AsString := FieldByName('AUTOINCREM').AsString;
      qryGenIte.ParamByName('SEQDET').AsString := FieldByName('LTP_SEQDET').AsString;
    End;

    qryGenIte.ParamByName('PRECOM_ANT').AsFloat  := FieldByName('LTP_PRECOM_ANT').AsFloat;
    qryGenIte.ParamByName('NOMFRM').AsString := 'Ativação Lote de Preço';
    qryGenIte.ParamByName('PRECOM').AsFloat  := FieldByName('LTP_PRECOM_UTI').AsFloat;
    qryGenIte.ParamByName('DESF01').AsFloat  := FieldByName('LTP_DESF01_UTI').AsFloat;
    qryGenIte.ParamByName('DESF02').AsFloat  := FieldByName('LTP_DESF02_UTI').AsFloat;
    qryGenIte.ParamByName('DESF03').AsFloat  := FieldByName('LTP_DESF03_UTI').AsFloat;
    qryGenIte.ParamByName('DESF04').AsFloat  := FieldByName('LTP_DESF04_UTI').AsFloat;
    qryGenIte.ParamByName('DESF05').AsFloat  := FieldByName('LTP_DESF05_UTI').AsFloat;
    qryGenIte.ParamByName('DESF06').AsFloat  := FieldByName('LTP_DESF06_UTI').AsFloat;
    qryGenIte.ParamByName('ICMENT').AsFloat  := FieldByName('LTP_ICMENT_UTI').AsFloat;
    qryGenIte.ParamByName('SUBFED').AsFloat  := FieldByName('LTP_SUBFED_UTI').AsFloat;
    qryGenIte.ParamByName('IPIENT').AsFloat  := FieldByName('LTP_IPIENT_UTI').AsFloat;
    qryGenIte.ParamByName('FREENT').AsFloat  := FieldByName('LTP_FREENT_UTI').AsFloat;
    qryGenIte.ParamByName('VALFRE').AsFloat  := FieldByName('LTP_VALFRE_UTI').AsFloat;
    qryGenIte.ParamByName('ACRFIN').AsFloat  := FieldByName('LTP_ACRFIN_UTI').AsFloat;
    qryGenIte.ParamByName('SUBSTI').AsFloat  := FieldByName('LTP_SUBSTI_UTI').AsFloat;
    qryGenIte.ParamByName('DESADB').AsFloat  := FieldByName('LTP_DESADB_UTI').AsFloat;
    qryGenIte.ParamByName('OUTVAL').AsFloat  := FieldByName('LTP_OUTVAL_UTI').AsFloat;
    qryGenIte.ParamByName('ICMSAI').AsFloat  := FieldByName('LTP_ICMSAI_UTI').AsFloat;
    qryGenIte.ParamByName('IMPFED').AsFloat  := FieldByName('LTP_IMPFED_UTI').AsFloat;
    qryGenIte.ParamByName('TCIFCU').AsFloat  := FieldByName('LTP_TCIFCU_UTI').AsFloat;
    qryGenIte.ParamByName('TSCUST').AsFloat  := FieldByName('LTP_TSCUST_UTI').AsFloat;
    qryGenIte.ParamByName('DEPICO').AsFloat  := FieldByName('LTP_DEPICO_UTI').AsFloat;
    qryGenIte.ParamByName('DEICMS').AsFloat  := FieldByName('LTP_DEICMS_UTI').AsFloat;
    qryGenIte.ParamByName('FATREG').AsFloat  := FieldByName('LTP_FATREG_UTI').AsFloat;

    qryGenIte.ParamByName('DESOPE').AsFloat  := FieldByName('LTP_DESOPE_UTI').AsFloat;

    qryGenIte.ParamByName('PRECUS').AsFloat     := FieldByName('LTP_PRECUS_ANT').AsFloat;
    qryGenIte.ParamByName('PRECUS_NOV').AsFloat := FieldByName('LTP_PRECUS').AsFloat;

    qryGenIte.ParamByName('DESMAX').Value  := Null;
    qryGenIte.ParamByName('DESMGE').Value  := Null;
    qryGenIte.ParamByName('DESMSU').Value  := Null;
    qryGenIte.ParamByName('DESMVM').Value  := Null;
    qryGenIte.ParamByName('DESMSM').Value  := Null;
    qryGenIte.ParamByName('DESMGM').Value  := Null;

    qryGenIte.ParamByName('MARMIN').Value  := Null;
    qryGenIte.ParamByName('MLTCOM').Value  := Null;

    qryGenIte.ParamByName('COMTB1').AsFloat  := FieldByName('LTP_COMTB1').AsFloat;
    qryGenIte.ParamByName('COMTB2').AsFloat  := FieldByName('LTP_COMTB2').AsFloat;
    qryGenIte.ParamByName('COMTB3').AsFloat  := FieldByName('LTP_COMTB3').AsFloat;
    qryGenIte.ParamByName('COMTB4').AsFloat  := FieldByName('LTP_COMTB4').AsFloat;
    qryGenIte.ParamByName('COMTB5').AsFloat  := FieldByName('LTP_COMTB5').AsFloat;
    qryGenIte.ParamByName('COMTB6').AsFloat  := FieldByName('LTP_COMTB6').AsFloat;
    qryGenIte.ParamByName('COMTB7').AsFloat  := FieldByName('LTP_COMTB7').AsFloat;

    For intCont := 1 To Length(VS_strTabPrc) Do
    Begin
      qryGenIte.ParamByName('MARBR' + IntToStr(intCont) + '').AsFloat     := FieldByName('LTP_MARBR' + IntToStr(intCont) + '_ANT').AsFloat;
      qryGenIte.ParamByName('MARBR' + IntToStr(intCont) + '_NOV').AsFloat := FieldByName('LTP_MARBR' + IntToStr(intCont)).AsFloat;
      qryGenIte.ParamByName('PREVE' + IntToStr(intCont) + '').AsFloat     := FieldByName('LTP_PREVE' + IntToStr(intCont) + '_ANT').AsFloat;
      qryGenIte.ParamByName('PREVE' + IntToStr(intCont) + '_NOV').AsFloat := FieldByName('LTP_PREVE' + IntToStr(intCont)).AsFloat;

      qryGenIte.ParamByName('MARID' + IntToStr(intCont) + '').AsFloat     := FieldByName('LTP_MARID' + IntToStr(intCont) + '_ANT').AsFloat;
      qryGenIte.ParamByName('MARID' + IntToStr(intCont) + '_NOV').AsFloat := FieldByName('LTP_MARID' + IntToStr(intCont)).AsFloat;
    End;

    qryGenIte.ParamByName('CODITE').AsString   := FieldByName('LTP_CODITE').AsString;
    qryGenIte.ParamByName('DTAPRE').AsDateTime := dtaDtaAtu;
    qryGenIte.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    qryGenIte.ParamByName('AUTOIN').AsString   := fRetAutoIncrem('PREITE', VS_strCodEmp);
    qryGenIte.ParamByName('QTDITE').AsFloat    := FieldByName('ITE_QTDITE').AsFloat;

    qryGenIte.ParamByName('PROPRI').AsString   := strProPri;
    qryGenIte.ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
  End;

  qryGenIte.ExecSQL;
  qryGenIte.Close;

  FreeAndNil(qryGenIte);
End;

Function TLotePrecos.fRetValorCdsPrecos(strNomCam: String): Double;
Begin
  Result := 0;
  With FCdsPrecos Do
  Begin
    If Locate('NOMCAM', strNomCam, []) Then
      Result := fStrToFloat(FieldbyName('VALATU').AsString);
  End;
End;

procedure TLotePrecos.pBeforePost(DataSet: TDataSet);
  Var
    intContador: Integer;
    blnAlterouPrecoVenda,
    blnAleroutMargem,
    blnValidaPrecoVenda: Boolean;
    strTabPrc: String;
Begin
  With DataSet Do
  Begin
    If FieldByName('LTP_PRECOM').AsFloat <= 0 Then
    Begin
      pMensagemOk('O Preço de Compra deve ser maior que zero!');
      Abort;
    End;

    For intContador := 1 To 7 Do
    If (VS_strTabPrc[intContador] = 'S') Then
    Begin

      If fEmptyStr((FieldByName('LTP_MARBR' + IntToStr(intContador)).AsString )) Then
      Begin
        fMensagem('ATENÇÃO!', 'Margem não permitida: Informe um valor entre 0 e 100!', ['&Ok']);
        DataSet.Cancel;
        Abort;
      End;

      If Pos(fCfgSis('MARMKP'), '1_5_2') > 0 Then
      Begin
        If (FieldByName('LTP_MARBR' + IntToStr(intContador)).AsFloat >= 100) And (fCfgSis('MARMKP') <> '2') Then
        Begin
          if FTravarApenasNaTabelaDePrecoAlterada and (intContador.ToString <> FstrTabPrc) then
            Continue
          else
          begin
            fMensagem('ATENÇÃO!', 'Margem não permitida: maior ou igual a 100!', ['&Ok']);
            DataSet.Cancel;
            Abort;
          end;
        End

        Else If Not fValidaMargemDataSet(DataSet, FieldByName('LTP_MARBR' + IntToStr(intContador)).AsFloat, IntToStr(intContador)) Then
        Begin
          if FTravarApenasNaTabelaDePrecoAlterada and (intContador.ToString <> FstrTabPrc) then
            Continue
          else
          begin
            fMensagem('', MSG_VALIDACAO_MARGEM + FStrCodIteProcessando, ['&Ok']);
            DataSet.Cancel;
            Abort;
          end;
        End

        Else If FMarIde And (FieldByName('LTP_MARID' + IntToStr(intContador)).AsFloat >= 100) And (fCfgSis('MARMKP') <> '2') Then
        Begin
          if FTravarApenasNaTabelaDePrecoAlterada and (intContador.ToString <> FstrTabPrc) then
            Continue
          else
          begin
            fMensagem('ATENÇÃO!', 'Margem não permitida: maior ou igual a 100!', ['&Ok']);
            DataSet.Cancel;
            Abort;
          end;
        End

        Else If FMarIde And (Not fValidaMargemIdealDataSet(DataSet, FieldByName('LTP_MARID' + IntToStr(intContador)).AsFloat, IntToStr(intContador))) Then
        Begin
          if FTravarApenasNaTabelaDePrecoAlterada and (intContador.ToString <> FstrTabPrc) then
            Continue
          else
          begin
            fMensagem('', MSG_VALIDACAO_MARGEM + FStrCodIteProcessando, ['&Ok']);
            DataSet.Cancel;
            Abort;
          end;
        End;
      End;

      blnValidaPrecoVenda := True;

      If (Not fEmptyStr(FstrTabela)) And (StrToInt(FstrTabela) = intContador) Then
        blnValidaPrecoVenda := True
      Else If (Not fEmptyStr(FstrTabela)) Then
        blnValidaPrecoVenda := False;

      If (Not ((FieldByName('LTP_PREVE' + IntToStr(intContador)).AsFloat = 0) And FZerLot)) And
         (FieldByName('LTP_PREVE' + IntToStr(intContador)).AsFloat <= 0) And
          blnValidaPrecoVenda Then
      Begin
        if FTravarApenasNaTabelaDePrecoAlterada and (intContador.ToString <> FstrTabPrc) then
          Continue
        else
        begin
          If FZerLot Then
            pMensagemOk('O Preço de Venda ' + IntToStr(intContador) + ' deve ser maior ou igual a zero!')
          Else
            pMensagemOk('O Preço de Venda ' + IntToStr(intContador) + ' deve ser maior que zero!');
          DataSet.Cancel;
          Abort;
        end;
      End;
    End;

    If blnAtualizaPrecomUti Then
      DataSet.FieldByName('LTP_PRECOM_UTI').AsFloat := DataSet.FieldByName('LTP_PRECOM_ATU').AsFloat;

    If RoundTo(fRetValorCdsPrecos('LTP_PRECOM'), -intDecimais) <> RoundTo(FieldByName('LTP_PRECOM_UTI').Value, -intDecimais) Then
    Begin
      FieldByName('LTP_COMLIQ').AsFloat := fCalculaPrecoCompraLiq(FieldByName('LTP_PRECOM_UTI').AsFloat,
                                                                  FieldByName('LTP_DESF01_UTI').AsFloat,
                                                                  FieldByName('LTP_DESF02_UTI').AsFloat,
                                                                  FieldByName('LTP_DESF03_UTI').AsFloat,
                                                                  FieldByName('LTP_DESF04_UTI').AsFloat,
                                                                  FieldByName('LTP_DESF05_UTI').AsFloat,
                                                                  FieldByName('LTP_DESF06_UTI').AsFloat,
                                                                  intDecimais,
                                                                  FieldByName('ITE_PREDOL').AsString = 'S',
                                                                  0,
                                                                  FCotDol);

      FieldByName('LTP_PRECUS').AsFloat := fCalculaPrecoCusto(DataSet);
    End;

    DataSet.FieldByName('ITE_CUSREA').AsFloat:= fCalculaCustoReal(FieldByName('LTP_PRECUS').AsFloat,
                                                                  FieldByName('LTP_ICMSAI_UTI').AsFloat,
                                                                  FieldByName('LTP_IMPFED_UTI').AsFloat,
                                                                  FieldByName('LTP_DESOPE_UTI').AsFloat,
                                                                  FieldByName('LTP_OUTVAL_UTI').AsFloat);

    FieldByName('ITE_CUSREA_ANT').AsFloat:=  fCalculaCustoReal(FieldByName('LTP_PRECUS_ANT').AsFloat,
                                                               FieldByName('LTP_ICMSAI_ANT').AsFloat,
                                                               FieldByName('LTP_IMPFED_ANT').AsFloat,
                                                               FieldByName('LTP_DESOPE_ANT').AsFloat,
                                                               FieldByName('LTP_OUTVAL_ANT').AsFloat);

    If FieldByName('ITE_CUSREA_ANT').AsFloat <> 0 Then
      FieldByName('ITE_CUSREA_DIF').AsFloat := ((FieldByName('ITE_CUSREA').AsFloat - FieldByName('ITE_CUSREA_ANT').AsFloat) / FieldByName('ITE_CUSREA_ANT').AsFloat) * 100;

    If FieldByName('LTP_PRECUS_ANT').AsFloat <> 0 Then
      FieldByName('DIFCUS').AsFloat := ((FieldByName('LTP_PRECUS').AsFloat - FieldByName('LTP_PRECUS_ANT').AsFloat) / FieldByName('LTP_PRECUS_ANT').AsFloat) * 100;

    strTabPrc := '1';

    If blnAtualizaPrecomUti Then
    begin
      For intContador := 1 To 7 Do
         pAlteraPreco(Dataset, intContador, False, False);
    End;

    For intContador := 1 To 7 Do
    Begin
      blnAlterouPrecoVenda := RoundTo(fRetValorCdsPrecos('LTP_PREVE' + IntToStr(intContador)), -intDecimais) <> RoundTo(FieldByName('LTP_PREVE' + IntToStr(intContador)).Value, -intDecimais);
      blnAleroutMargem     := RoundTo(fRetValorCdsPrecos('LTP_MARBR' + IntToStr(intContador)), -fRetPrecisaoMargemItem) <> RoundTo(FieldByName('LTP_MARBR' + IntToStr(intContador)).Value, -fRetPrecisaoMargemItem);

      If FAlterandoMargemGeral  then
      begin
        blnAlterouPrecoVenda := False;
        blnAleroutMargem := True;
      end;

      If blnAlterouPrecoVenda Or blnAleroutMargem Then
        strTabPrc := IntToStr(intContador);

      If blnRecalcularMargemPrecoBeforePost And (blnAlterouPrecoVenda Or blnAleroutMargem) Then
        pAlteraPreco(Dataset, intContador, blnAlterouPrecoVenda, blnAleroutMargem);

      If FieldByName('LTP_PREVE' + IntToStr(intContador) + '_ANT').AsFloat <> 0 Then
        FieldByName('DIFPR' + IntToStr(intContador)).AsFloat :=
          ((FieldByName('LTP_PREVE' + IntToStr(intContador)).AsFloat - FieldByName('LTP_PREVE' + IntToStr(intContador) + '_ANT').AsFloat) /
                                               FieldByName('LTP_PREVE' + IntToStr(intContador) + '_ANT').AsFloat) * 100;

      FieldByName('DIFMA' + IntToStr(intContador)).AsFloat := FieldByName('LTP_MARBR' + IntToStr(intContador)).AsFloat -
                                                              FieldByName('LTP_MARBR' + IntToStr(intContador)+ '_ANT').AsFloat;
    End;

    pAjustaPrecos(Dataset, strTabPrc);

    pCalculaPrecoIdeal(Dataset);

    pAfterScroll := AfterScroll;
    AfterScroll  := Nil;
  End;
End;

function TLotePrecos.fCampoDatSet(Dataset: TDataSet; strCampo: String): TField;
begin
  Result := Dataset.FieldByName('LTP_' + strCampo);
end;

function TLotePrecos.fCampoTemUti(ACamAlt: string): Boolean;
begin
  Result := Pos(ACamAlt, '_ITE_PREVE1_ITE_PREVE2_ITE_PREVE3_ITE_PREVE4_' +
                         'ITE_PREVE5_ITE_PREVE6_ITE_PREVE7_ITE_PREVE8_' +
                         'ITE_MARBR1_ITE_MARBR2_ITE_MARBR3_ITE_MARBR4_' +
                         'ITE_MARBR5_ITE_MARBR6_ITE_MARBR7_ITE_MARBR8_' +
                         'ITE_COMTB1_ITE_COMTB2_ITE_COMTB3_ITE_COMTB4_' +
                         'ITE_COMTB5_ITE_COMTB6_ITE_COMTB7_ITE_COMTB8_' +
                         'ITE_MARID1_ITE_MARID2_ITE_MARID3_ITE_MARID4_' +
                         'ITE_MARID5_ITE_MARID6_ITE_MARID7_ITE_MARID8_') = 0;

  {}
end;

function TLotePrecos.fValidaMargemDataSet(Dataset: TDataSet; fltValor: Double; strTabPrc: String): Boolean;
var fltMargem: Double;
begin
  If fCfgSis('MARMKP') = '2' Then
    fltMargem := fMarkupToMargem(fltValor)
  Else
    fltMargem := fltValor;
  Result := Not ((fltMargem +
                  fCampoDatSet(Dataset, 'COMTB' + strTabPrc).AsFloat +
                  fCampoDatSet(Dataset, 'ICMSAI_UTI').AsFloat +
                  fCampoDatSet(Dataset, 'IMPFED_UTI').AsFloat +
                  fCampoDatSet(Dataset, 'DESOPE_UTI').AsFloat) > 100);
End;

function TLotePrecos.fValidaMargemIdealDataSet(Dataset: TDataSet; fltValor: Double; strTabPrc: String): Boolean;
var fltMargem : double;
begin
  If fCfgSis('MARMKP') = '2' then
    fltMargem := fMarkupToMargem(fltValor)
  Else
    fltMargem := fltValor;
  Result := Not ((fltMargem +
                  fCampoDatSet(Dataset, 'COMTB' + strTabPrc).AsFloat +
                  fCampoDatSet(Dataset, 'ICMSAI_UTI').AsFloat +
                  fCampoDatSet(Dataset, 'IMPFED_UTI').AsFloat +
                  fCampoDatSet(Dataset, 'DESOPE_UTI').AsFloat) > 100);
End;

function TLotePrecos.fValidaMargensAux(pgbStatus: TcxProgressBar = Nil):Boolean;
var strFilter: string;
    strMensagem: string;
    strFilterOri: String;
    blnFilteredOri: Boolean;
    intContador: integer;
begin
  strFilterOri := cdsConsulta.Filter;
  blnFilteredOri := cdsConsulta.Filtered;
  Result := True;
  blnTravamargem := False;
  cdsConsulta.First;
  cdsConsulta.Filtered := False;

  For intContador := 1 To 7 Do
  begin
    If (VS_strTabPrc[intContador] = 'S') Then
      strFilter := strFilter + IIf(strFilter = '', ' ( ' , ' OR ') + 'LTP_MARBR' + IntToStr(intContador) + '<=0' ;
  End;
  strFilter := strFilter + ' ) ';

  If Assigned(stlListSelecao) And (stlListSelecao.count > 0) Then
  Begin
    strFilter := strFilter + ' AND AUTOINCREM IN (';
    For intContador := 0 To stlListSelecao.Count-1 Do
    Begin
      strFilter := strFilter +  stlListSelecao[intContador] ;
      if (stlListSelecao.Count > 0) and (intContador < stlListSelecao.Count-1) Then
       strFilter := strFilter + ',';
    End;
    strFilter := strFilter + ' )' ;
  End;

  cdsConsulta.Filter := strFilter;
  cdsConsulta.Filtered := True;

  cdsConsulta.DisableControls;
  Try

    If cdsConsulta.IsEmpty Then
      Exit;
    blnTravamargem := True;


    pgbStatus.Properties.max := cdsConsulta.RecordCount;

    while not cdsConsulta.EoF do
    begin
      objLiberacao.objMsgLibera.pAddTexto('Item:' + cdsConsulta.FieldByName('ITE_CODITE').AsString + '-' + cdsConsulta.FieldByName('ITE_DESCRI').AsString);
      strMensagem := '  ';
      For intContador := 1 To 7 Do
      begin
        If (VS_strTabPrc[intContador] = 'S') Then
          If  cdsConsulta.FieldByName('LTP_MARBR' + IntToStr(intContador)).AsFloat <= 0 Then
          strMensagem := strMensagem + IIf(strFilter = '', '' , '  ') + '[Margem' + IntToStr(intContador) + ' = ' + cdsConsulta.FieldByName('LTP_MARBR' + IntToStr(intContador)).AsString + ']';
      End;
      objLiberacao.objMsgLibera.pAddTexto(strMensagem);

      cdsConsulta.Next;
      pgbStatus.Position := cdsConsulta.RecNo;
      Application.ProcessMessages;
    End;
  Finally
    cdsConsulta.Filter := strFilterOri;
    cdsConsulta.Filtered := blnFilteredOri;
    cdsConsulta.EnableControls;
  End;
end;

function TLotePrecos.fValidaMargens: Boolean;
var frmValidaMargem: TfrmGravando;
begin
  Try
    objLiberacao := TLiberacaoFactory.fGetLiberacao;
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Existem itens com margem menor ou igual a zero!');

    pCriarFormularios(TfrmGravando,frmValidaMargem);
    Try
      frmValidaMargem.fExecutarAcao := fValidaMargensAux;
      frmValidaMargem.lblGravando.Caption := 'Aguarde, Validando margem negativa ou zerada...';

      frmValidaMargem.ShowModal;
    Finally
      freeAndNil(frmValidaMargem);
    End;


    If Not blnTravamargem Then
      Exit(True);

    objLiberacao.strDirAce := 'ELTMARNEG';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Liberação Ativação lote de preço itens com margem negativa ou igual a zero';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    Result :=  objLiberacao.fLibera;
  Finally
    blnTravamargem := False;
  End;
end;

function TLotePrecos.fCalculaPrecoCusto(Dataset: TDataSet; blnBase: Boolean = False; fltPrecom: Double = -1): Double;
Begin
  With cpcParams Do
  Begin
    If fltPrecom > -1 Then
       curPreCom := fltPrecom
    Else
      curPreCom := fCampoDatset(Dataset, 'PRECOM' + IIf(blnBase, '_ATU','_UTI')).AsFloat;

    If Dataset.FieldByName('ITE_PREDOL').AsString = 'S' Then
      curPreCom := RoundTo(curPreCom * fltCotDol, - intDecimais);

    curDesF01 := fCampoDatset(Dataset, 'DESF01' + IIf(blnBase, '_ATU','_UTI')).AsFloat;
    curDesF02 := fCampoDatset(Dataset, 'DESF02' + IIf(blnBase, '_ATU','_UTI')).AsFloat;
    curDesF03 := fCampoDatset(Dataset, 'DESF03' + IIf(blnBase, '_ATU','_UTI')).AsFloat;
    curDesF04 := fCampoDatset(Dataset, 'DESF04' + IIf(blnBase, '_ATU','_UTI')).AsFloat;
    curDesF05 := fCampoDatset(Dataset, 'DESF05' + IIf(blnBase, '_ATU','_UTI')).AsFloat;
    curDesF06 := fCampoDatset(Dataset, 'DESF06' + IIf(blnBase, '_ATU','_UTI')).AsFloat;
    curICMSEnt:= fCampoDatset(Dataset, 'ICMENT' + IIf(blnBase, '_ATU','_UTI')).AsFloat;
    curIPIEnt := fCampoDatset(Dataset, 'IPIENT' + IIf(blnBase, '_ATU','_UTI')).AsFloat;
    curFrete  := fCampoDatset(Dataset, 'FREENT' + IIf(blnBase, '_ATU','_UTI')).AsFloat;
    curAcrFin := fCampoDatset(Dataset, 'ACRFIN' + IIf(blnBase, '_ATU','_UTI')).AsFloat;
    curSubsti := fCampoDatset(Dataset, 'SUBSTI' + IIf(blnBase, '_ATU','_UTI')).AsFloat;
    curValFre := fCampoDatset(Dataset, 'VALFRE' + IIf(blnBase, '_ATU','_UTI')).AsFloat;
    curDesAdb := fCampoDatset(Dataset, 'DESADB' + IIf(blnBase, '_ATU','_UTI')).AsFloat;
    curSubFed := fCampoDatset(Dataset, 'SUBFED' + IIf(blnBase, '_ATU','_UTI')).AsFloat;

    if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
    begin
      curTCIFCu := fCampoDatset(Dataset, 'TCIFCU'+ IIf(blnBase, '_ATU','_UTI')).AsFloat;
      curTSCust := fCampoDatset(Dataset, 'TSCUST'+ IIf(blnBase, '_ATU','_UTI')).AsFloat;
      curDePiCo := fCampoDatset(Dataset, 'DEPICO'+ IIf(blnBase, '_ATU','_UTI')).AsFloat;
      curDeICMS := fCampoDatset(Dataset, 'DEICMS'+ IIf(blnBase, '_ATU','_UTI')).AsFloat;
      curFatReg := fCampoDatset(Dataset, 'FATREG'+ IIf(blnBase, '_ATU','_UTI')).AsFloat;
    end
    else
    begin
      curTCIFCu := 0;
      curTSCust := 0;
      curDePiCo := 0;
      curDeICMS := 0;
      curFatReg := 0;
    end;
  End;

  Result := cpcParams.fCalculaPrecoCusto(false);
End;

function TLotePrecos.fCalculaPrecoVendaComImpostos(ACodIte: String; AEstado: String; APerfil: String; APreven: Double): Double;
begin
  If fEmptyStr(FEstado) Then
    Exit(APreven);
  If fEmptyStr(FPerfil) Then
    Exit(APreven);


  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SET @TIPABF = fCfgSis("TIPABF", "' + VS_StrCodEmp + '");');
  qryConsulta.SQL.Add('SET @TPABPC = fCfgSis("TPABPC", "' + VS_StrCodEmp + '");');
  qryConsulta.SQL.Add('SET @IMPDIR = fCfgSis("IMPDIR", "' + VS_StrCodEmp + '");');
  qryConsulta.SQL.Add('SET @IMPDIG = fCfgSis("IMPDIG", "' + VS_StrCodEmp + '");');
  qryConsulta.SQL.Add('SET @CONIPI = fCfgSis("CONIPI", "' + VS_StrCodEmp + '");');
  qryConsulta.SQL.Add('SET @UTIABI = fCfgSis("UTIABI", "' + VS_StrCodEmp + '");');
  qryConsulta.SQL.Add('SET @REBAST = fCfgSis("REBAST", "' + VS_StrCodEmp + '");');
  qryConsulta.SQL.Add('SET @DECUNI = CAST(IFNULL(fCfgSis("DECUNI", "' + VS_StrCodEmp + '"), "2") AS SIGNED);');
  qryConsulta.SQL.Add('SET @REDALQ = IF(((fCfgSis("IMPCF4", "' + VS_StrCodEmp + '") = "S") AND (fCfgSis("RAICF4", "' + VS_StrCodEmp + '") = "S")), "S", "N");');

  qryConsulta.SQL.Add('SELECT ');
  qryConsulta.SQL.Add('	PREVEN + IFNULL((BASRET - IF(BASRET <> 0, VALICM, 0)),0) + IFNULL(VALIPI,0) + IFNULL((((BASRET / 100) * ALQFCP) - IF(BASRET <> 0, VALFCP, 0)),0) AS VENIMP ');
  qryConsulta.SQL.Add('	FROM (');
  qryConsulta.SQL.Add('	SELECT ABF_ALQFCP_SAI AS ALQFCP, ');
  qryConsulta.SQL.Add('        PREVEN, ');
  qryConsulta.SQL.Add('	((((PREVEN) * ABF_BASICM_SAI / 100)) * (ABF_ALQICM_SAI/100)) AS VALICM, ');
  qryConsulta.SQL.Add('	((((PREVEN) * ABF_BASICM_SAI) / 100) * ABF_ALQFCP_SAI/100) AS VALFCP, ');
  qryConsulta.SQL.Add('	IF(IMPDIR="N" AND EMP_ESTADO = CLI_ESTADO, 0,');
  qryConsulta.SQL.Add('	  (IF(((@IMPDIR = "S") OR (@CONIPI = "S")), IF(@UTIABI = "N", 0.00, ');
  qryConsulta.SQL.Add('	    ((PREVEN * (APC_BASSAI/100) * (APC_ALQSAI/100)) ) ), 0) + ');
  qryConsulta.SQL.Add('	 ( PREVEN * (IF(@REBAST = "S", ABF_BASRET_SAI, 100)/100 ) ) ) * ABF_IVA_ST_SAI* (ABF_ALQRET_SAI/100) ) BASRET, ');
  qryConsulta.SQL.Add('	IF(@UTIABI = "N", 0.00, ((PREVEN ) * (APC_ALQSAI/ 100))) AS VALIPI ');
  qryConsulta.SQL.Add('		FROM (');
  qryConsulta.SQL.Add('				SELECT ');
  qryConsulta.SQL.Add('				CASE "' + APerfil + '"');
  qryConsulta.SQL.Add('				WHEN "NCO" THEN ABFICM.ABF_BASICM_SAI_NCO');
  qryConsulta.SQL.Add('				WHEN "CCO" THEN ABFICM.ABF_BASICM_SAI_CCO');
  qryConsulta.SQL.Add('				WHEN "CNC" THEN ABFICM.ABF_BASICM_SAI_CNC');
  qryConsulta.SQL.Add('				WHEN "SNA" THEN ABFICM.ABF_BASICM_SAI_SNA');
  qryConsulta.SQL.Add('				WHEN "CTA" THEN ABFICM.ABF_BASICM_SAI_CTA');
  qryConsulta.SQL.Add('				WHEN "PRU" THEN ABFICM.ABF_BASICM_SAI_PRU');
  qryConsulta.SQL.Add('				WHEN "IND" THEN ABFICM.ABF_BASICM_SAI_IND');
  qryConsulta.SQL.Add('				WHEN "TRS" THEN ABFICM.ABF_BASICM_SAI_TRS');
  qryConsulta.SQL.Add('			END AS ABF_BASICM_SAI,');
  qryConsulta.SQL.Add('				CASE "' + APerfil + '"');
  qryConsulta.SQL.Add('					WHEN "NCO" THEN ABFICM.ABF_ALQICM_SAI_NCO');
  qryConsulta.SQL.Add('					WHEN "CCO" THEN ABFICM.ABF_ALQICM_SAI_CCO');
  qryConsulta.SQL.Add('					WHEN "CNC" THEN ABFICM.ABF_ALQICM_SAI_CNC');
  qryConsulta.SQL.Add('					WHEN "SNA" THEN ABFICM.ABF_ALQICM_SAI_SNA');
  qryConsulta.SQL.Add('					WHEN "CTA" THEN ABFICM.ABF_ALQICM_SAI_CTA');
  qryConsulta.SQL.Add('					WHEN "PRU" THEN ABFICM.ABF_ALQICM_SAI_PRU');
  qryConsulta.SQL.Add('					WHEN "IND" THEN ABFICM.ABF_ALQICM_SAI_IND');
  qryConsulta.SQL.Add('					WHEN "TRS" THEN ABFICM.ABF_ALQICM_SAI_TRS');
  qryConsulta.SQL.Add('			END AS ABF_ALQICM_SAI,');
  qryConsulta.SQL.Add('				CASE "' + APerfil + '"');
  qryConsulta.SQL.Add('					WHEN "NCO" THEN ABFICM.ABF_BASRET_SAI_NCO');
  qryConsulta.SQL.Add('					WHEN "CCO" THEN ABFICM.ABF_BASRET_SAI_CCO');
  qryConsulta.SQL.Add('					WHEN "CNC" THEN ABFICM.ABF_BASRET_SAI_CNC');
  qryConsulta.SQL.Add('					WHEN "SNA" THEN ABFICM.ABF_BASRET_SAI_SNA');
  qryConsulta.SQL.Add('					WHEN "CTA" THEN ABFICM.ABF_BASRET_SAI_CTA');
  qryConsulta.SQL.Add('					WHEN "PRU" THEN ABFICM.ABF_BASRET_SAI_PRU');
  qryConsulta.SQL.Add('					WHEN "IND" THEN ABFICM.ABF_BASRET_SAI_IND');
  qryConsulta.SQL.Add('					WHEN "TRS" THEN ABFICM.ABF_BASRET_SAI_TRS');
  qryConsulta.SQL.Add('			END AS ABF_BASRET_SAI,');
  qryConsulta.SQL.Add('				CASE "' + APerfil + '"');
  qryConsulta.SQL.Add('					WHEN "NCO" THEN ABFICM.ABF_ALQRET_SAI_NCO');
  qryConsulta.SQL.Add('					WHEN "CCO" THEN ABFICM.ABF_ALQRET_SAI_CCO');
  qryConsulta.SQL.Add('					WHEN "CNC" THEN ABFICM.ABF_ALQRET_SAI_CNC');
  qryConsulta.SQL.Add('					WHEN "SNA" THEN ABFICM.ABF_ALQRET_SAI_SNA');
  qryConsulta.SQL.Add('					WHEN "CTA" THEN ABFICM.ABF_ALQRET_SAI_CTA');
  qryConsulta.SQL.Add('					WHEN "PRU" THEN ABFICM.ABF_ALQRET_SAI_PRU');
  qryConsulta.SQL.Add('					WHEN "IND" THEN ABFICM.ABF_ALQRET_SAI_IND');
  qryConsulta.SQL.Add('					WHEN "TRS" THEN ABFICM.ABF_ALQRET_SAI_TRS');
  qryConsulta.SQL.Add('			END AS ABF_ALQRET_SAI,');
  qryConsulta.SQL.Add('				CASE "' + APerfil + '"');
  qryConsulta.SQL.Add('					WHEN "NCO" THEN ABFICM.ABF_IVA_ST_SAI_NCO');
  qryConsulta.SQL.Add('					WHEN "CCO" THEN ABFICM.ABF_IVA_ST_SAI_CCO');
  qryConsulta.SQL.Add('					WHEN "CNC" THEN ABFICM.ABF_IVA_ST_SAI_CNC');
  qryConsulta.SQL.Add('					WHEN "SNA" THEN ABFICM.ABF_IVA_ST_SAI_SNA');
  qryConsulta.SQL.Add('					WHEN "CTA" THEN ABFICM.ABF_IVA_ST_SAI_CTA');
  qryConsulta.SQL.Add('					WHEN "PRU" THEN ABFICM.ABF_IVA_ST_SAI_PRU');
  qryConsulta.SQL.Add('					WHEN "IND" THEN ABFICM.ABF_IVA_ST_SAI_IND');
  qryConsulta.SQL.Add('					WHEN "TRS" THEN ABFICM.ABF_IVA_ST_SAI_TRS');
  qryConsulta.SQL.Add('			END AS ABF_IVA_ST_SAI,');
  qryConsulta.SQL.Add('				CASE "' + APerfil + '"');
  qryConsulta.SQL.Add('					WHEN "NCO" THEN ABFICM.ABF_ALQEFO_SAI_NCO');
  qryConsulta.SQL.Add('					WHEN "CCO" THEN ABFICM.ABF_ALQEFO_SAI_CCO');
  qryConsulta.SQL.Add('					WHEN "CNC" THEN ABFICM.ABF_ALQEFO_SAI_CNC');
  qryConsulta.SQL.Add('					WHEN "SNA" THEN ABFICM.ABF_ALQEFO_SAI_SNA');
  qryConsulta.SQL.Add('					WHEN "CTA" THEN ABFICM.ABF_ALQEFO_SAI_CTA');
  qryConsulta.SQL.Add('					WHEN "PRU" THEN ABFICM.ABF_ALQEFO_SAI_PRU');
  qryConsulta.SQL.Add('					WHEN "IND" THEN ABFICM.ABF_ALQEFO_SAI_IND');
  qryConsulta.SQL.Add('					WHEN "TRS" THEN ABFICM.ABF_ALQEFO_SAI_TRS');
	qryConsulta.SQL.Add('		END AS ABF_ALQEFO_SAI,');
  qryConsulta.SQL.Add('				CASE "' + APerfil + '"');
	qryConsulta.SQL.Add('        	WHEN "NCO" THEN ABFICM.ABF_ALQIED_SAI_NCO');
	qryConsulta.SQL.Add('        	WHEN "CCO" THEN ABFICM.ABF_ALQIED_SAI_CCO');
	qryConsulta.SQL.Add('        	WHEN "CNC" THEN ABFICM.ABF_ALQIED_SAI_CNC');
	qryConsulta.SQL.Add('        	WHEN "SNA" THEN ABFICM.ABF_ALQIED_SAI_SNA');
	qryConsulta.SQL.Add('        	WHEN "CTA" THEN ABFICM.ABF_ALQIED_SAI_CTA');
	qryConsulta.SQL.Add('        	WHEN "PRU" THEN ABFICM.ABF_ALQIED_SAI_PRU');
	qryConsulta.SQL.Add('        	WHEN "IND" THEN ABFICM.ABF_ALQIED_SAI_IND');
	qryConsulta.SQL.Add('        	WHEN "TRS" THEN ABFICM.ABF_ALQIED_SAI_TRS');
	qryConsulta.SQL.Add('		END AS ABF_ALQIED_SAI,');
  qryConsulta.SQL.Add('				CASE "' + APerfil + '"');
  qryConsulta.SQL.Add('					WHEN "NCO" THEN ABFICM.ABF_ALQFCP_SAI_NCO');
  qryConsulta.SQL.Add('					WHEN "CCO" THEN ABFICM.ABF_ALQFCP_SAI_CCO');
  qryConsulta.SQL.Add('					WHEN "CNC" THEN ABFICM.ABF_ALQFCP_SAI_CNC');
  qryConsulta.SQL.Add('					WHEN "SNA" THEN ABFICM.ABF_ALQFCP_SAI_SNA');
  qryConsulta.SQL.Add('					WHEN "CTA" THEN ABFICM.ABF_ALQFCP_SAI_CTA');
  qryConsulta.SQL.Add('					WHEN "PRU" THEN ABFICM.ABF_ALQFCP_SAI_PRU');
  qryConsulta.SQL.Add('					WHEN "IND" THEN ABFICM.ABF_ALQFCP_SAI_IND');
  qryConsulta.SQL.Add('					WHEN "TRS" THEN ABFICM.ABF_ALQFCP_SAI_TRS');
  qryConsulta.SQL.Add('			END AS ABF_ALQFCP_SAI,');
  qryConsulta.SQL.Add('				CASE "' + APerfil + '"');
  qryConsulta.SQL.Add('					WHEN "NCO" THEN ABFICM.ABF_CODSIT_SAI_NCO');
  qryConsulta.SQL.Add('					WHEN "CCO" THEN ABFICM.ABF_CODSIT_SAI_CCO');
  qryConsulta.SQL.Add('					WHEN "CNC" THEN ABFICM.ABF_CODSIT_SAI_CNC');
  qryConsulta.SQL.Add('					WHEN "SNA" THEN ABFICM.ABF_CODSIT_SAI_SNA');
  qryConsulta.SQL.Add('					WHEN "CTA" THEN ABFICM.ABF_CODSIT_SAI_CTA');
  qryConsulta.SQL.Add('					WHEN "PRU" THEN ABFICM.ABF_CODSIT_SAI_PRU');
  qryConsulta.SQL.Add('					WHEN "IND" THEN ABFICM.ABF_CODSIT_SAI_IND');
  qryConsulta.SQL.Add('					WHEN "TRS" THEN ABFICM.ABF_CODSIT_SAI_TRS');
  qryConsulta.SQL.Add('			END AS ABF_CODSIT_SAI, ');
  qryConsulta.SQL.Add('			:PREVEN AS PREVEN, ');
  qryConsulta.SQL.Add('			CID_ESTADO AS EMP_ESTADO, ');
  qryConsulta.SQL.Add('			CAST("'+AEstado+'"  AS CHAR(2)) AS CLI_ESTADO, ');
	qryConsulta.SQL.Add('			IFNULL(APC_ALQSAI, 0.00) AS APC_ALQSAI, ');
	qryConsulta.SQL.Add('			IFNULL(APC_BASSAI, 0.00) AS APC_BASSAI, ');
	qryConsulta.SQL.Add('			IF(@IMPDIG = "2", ITEGER.ITE_IMPDIR, CADITE.ITE_IMPDIR) IMPDIR ');
	qryConsulta.SQL.Add('					FROM CADITE ');
	qryConsulta.SQL.Add('					LEFT JOIN ITEGER ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ');
	qryConsulta.SQL.Add('													AND ITEGER.ITE_CODEMP = "' + VS_StrCodEmp + '" ');
	qryConsulta.SQL.Add('					LEFT JOIN ABFICM ON IF(@TIPABF = "1", CADITE.ITE_CODABF, ITEGER.ITE_CODABF) = ABFICM.ABF_CODABF ');
	qryConsulta.SQL.Add('													AND ABFICM.ABF_ESTADO = "'+AEstado+'" ');
	qryConsulta.SQL.Add('					LEFT JOIN CADMAR ON CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR');
	qryConsulta.SQL.Add('					LEFT JOIN CADGRU ON CADITE.ITE_CODGRU = CADGRU.GRU_CODGRU');
	qryConsulta.SQL.Add('					LEFT JOIN CADUNI ON UNI_CODUNI = CADITE.ITE_CODUNI');
	qryConsulta.SQL.Add('					LEFT JOIN GRU_COMPRA ON CADITE.ITE_GRUCMP = GRU_COMPRA.GRU_CODIGO');
	qryConsulta.SQL.Add('					LEFT JOIN CADEMP ON CADEMP.EMP_CODEMP = "' + VS_StrCodEmp + '"');
	qryConsulta.SQL.Add('					LEFT JOIN CADCID ON CADEMP.EMP_CODCID = CADCID.CID_CODCID');

	qryConsulta.SQL.Add('					LEFT JOIN IPISAI ON IF(@TPABPC = "1", CADITE.ITE_ABFIPI, ITEGER.ITE_ABFIPI) = IPISAI.APC_CODAPC');
	qryConsulta.SQL.Add('					                AND @UTIABI = "S" AND LOCATE("5102", APC_CFOSAI)>0');
	qryConsulta.SQL.Add('					WHERE TRUE');
	qryConsulta.SQL.Add('			      AND CADITE.ITE_CODITE = "'+ACodIte+'"');
	qryConsulta.SQL.Add('				) AS TAB');
	qryConsulta.SQL.Add('			) AS FIM;');
  qryConsulta.ParamByName('PREVEN').AsFloat :=  APreven;
  qryConsulta.Open;

  Result :=  qryConsulta.FieldByName('VENIMP').AsFloat;

end;

function TLotePrecos.fCalculaValor(Dataset: TDataSet; intOpcao, intNroPre: Integer; fltPreVen, fltMarbru: Double): Double;
begin
  Result := fCalculaPrecoVenda(intOpcao,
                               fCampoDatset(Dataset, 'PRECUS').AsFloat + fCampoDatset(Dataset, 'OUTVAL_UTI').AsFloat,
                               fltPreVen,
                               fltMarbru,
                               fCampoDatset(Dataset, 'ICMSAI_UTI').AsFloat,
                               fCampoDatset(Dataset, 'IMPFED_UTI').AsFloat,
                               fCampoDatset(Dataset, 'DESOPE_UTI').AsFloat,
                               fCampoDatset(Dataset, 'COMTB' + IntToStr(intNroPre)).AsFloat);
End;

Procedure TLotePrecos.pAjustaPrecos(Dataset: TDataSet; strTabPrc: String);
  Var
    intIndice: Integer;
Begin
  If Assigned(FFatPre) Then
    For intIndice := 2 To 7 Do
    Begin
      If FFatPre.fTabelaAtiva(intIndice) Then
      begin
        fCampoDatset(Dataset, 'PREVE' + IntToStr(intIndice)).AsFloat :=
           FFatPre.fCalculaPrecoVendaFator(fCampoDatset(Dataset,'PREVE1').AsFloat, intIndice);

        fCampoDatset(Dataset, 'MARBR' + IntToStr(intIndice)).AsFloat :=
          fCalculaValor(Dataset, 2, StrToInt(strTabPrc), fCampoDatset(Dataset, 'PREVE' + IntToStr(intIndice)).AsFloat, 0);

        If blnALTCVI then
        Begin
          fCampoDatset(Dataset,'VENIM' + IntToStr(intIndice)).AsFloat := fCalculaPrecoVendaComImpostos(fCampoDatset(Dataset, 'CODITE').AsString,
                                                                                                       FEstado,
                                                                                                       FPerfil,
                                                                                                       fCampoDatset(Dataset,'PREVE' + IntToStr(intIndice)).AsFloat);
        End;
      End;
    End;
End;

procedure TLotePrecos.pAlteraPreco(Dataset: TDataSet; intIndice: Integer; blnAlterouPreVen, blnAlterouMargem: Boolean);
Begin
  If blnAlterouPreVen Then
  Begin
    If FArredondaPreco And Not(fEmptyStr(FCasaDecimal)) Then
    Begin
      fCampoDatset(Dataset,'MARBR' + IntToStr(intIndice)).AsFloat :=
        fCalculaValor(Dataset, 2, intIndice, RoundTo(fCampoDatset(Dataset,'PREVE' + IntToStr(intIndice)).AsFloat, StrToIntDef(FCasaDecimal,0) * -1 ), 0)
    End
    Else
      fCampoDatset(Dataset,'MARBR' + IntToStr(intIndice)).AsFloat :=
        fCalculaValor(Dataset, 2, intIndice, fCampoDatset(Dataset,'PREVE' + IntToStr(intIndice)).AsFloat, 0)
  End
  Else If blnAlterouMargem Then
  Begin
    fCampoDatset(Dataset,'PREVE' + IntToStr(intIndice)).AsFloat :=
      fCalculaValor(Dataset, 1, intIndice, 0, fCampoDatset(Dataset,'MARBR' + IntToStr(intIndice)).AsFloat);

    If FArredondaPreco And Not(fEmptyStr(FCasaDecimal)) Then
      fCampoDatset(Dataset,'PREVE' + IntToStr(intIndice)).AsFloat := RoundTo(fCampoDatset(Dataset,'PREVE' + IntToStr(intIndice)).AsFloat, StrToIntDef(FCasaDecimal,0) * -1 );

  End
  Else If ((fCalculaValor(Dataset, 1, intIndice, 0, fCampoDatset(Dataset,'MARBR' + IntToStr(intIndice)).AsFloat) >
               Dataset.FieldByName('LTP_PREVE' + IntToStr(intIndice) + '_ANT').AsFloat) Or
           (Dataset.FieldByName('ITE_RPRENT').AsString = 'S')) And
          SameText(Dataset.FieldByName('TIPCAL' + IntToStr(intIndice)).AsString, 'Preço Venda') Then
  Begin

    fCampoDatset(Dataset,'PREVE' + IntToStr(intIndice)).AsFloat :=
      fCalculaValor(Dataset, 1, intIndice, 0, fCampoDatset(Dataset,'MARBR' + IntToStr(intIndice)).AsFloat);

    If FArredondaPreco And Not(fEmptyStr(FCasaDecimal)) Then
      fCampoDatset(Dataset,'PREVE' + IntToStr(intIndice)).AsFloat := RoundTo(fCampoDatset(Dataset,'PREVE' + IntToStr(intIndice)).AsFloat, StrToIntDef(FCasaDecimal,0) * -1 );

  End
  Else
  Begin

    If FArredondaPreco And Not(fEmptyStr(FCasaDecimal)) Then
      fCampoDatset(Dataset,'MARBR' + IntToStr(intIndice)).AsFloat :=
        fCalculaValor(Dataset, 2, intIndice, RoundTo(fCampoDatset(Dataset,'PREVE' + IntToStr(intIndice)).AsFloat, StrToIntDef(FCasaDecimal,0) * -1 ), 0)
    Else
    fCampoDatset(Dataset,'MARBR' + IntToStr(intIndice)).AsFloat :=
      fCalculaValor(Dataset, 2, intIndice, fCampoDatset(Dataset,'PREVE' + IntToStr(intIndice)).AsFloat, 0);
  End;

  If (Pos(fCfgSis('MARMKP', varString), '1_2') > 0) Then
  Begin
    fCampoDatset(Dataset,'CUSVE' + IntToStr(intIndice)).AsFloat := RoundTo(fCampoDatset(Dataset, 'PRECUS').AsFloat + fCampoDatset(Dataset, 'OUTVAL').AsFloat +
                                                                          (fCampoDatset(Dataset, 'PREVE' + IntToStr(intIndice)).AsFloat *
                                                                          (fCampoDatset(Dataset, 'ICMSAI').AsFloat +
                                                                           fCampoDatset(Dataset, 'IMPFED').AsFloat +
                                                                           fCampoDatset(Dataset, 'DESOPE').AsFloat +
                                                                           fCampoDatset(Dataset, 'COMTB' + IntToStr(intIndice)).AsFloat)/100), -intDecimais);
  End;


  If blnALTCVI then
  Begin
    fCampoDatset(Dataset,'VENIM' + IntToStr(intIndice)).AsFloat := fCalculaPrecoVendaComImpostos(fCampoDatset(Dataset, 'CODITE').AsString,
                                                                                                 FEstado,
                                                                                                 FPerfil,
                                                                                                 fCampoDatset(Dataset,'PREVE' + IntToStr(intIndice)).AsFloat);
  End;

End;


procedure TLotePrecos.pAlterarPrecoMargem(blnChamadaOriginal: boolean; Dataset, DataSetPrecos: TDataSet; intFlagUtilizarNovoPreco: Integer = -1; AfltValor: Double =-1; AfltValAtu: Double = 0;
blnExibeTelaDigValor:Boolean = True; fltValorASerReplicado: Double = 0; blnContinuaReplicacaoDeTabela: Boolean = False; ATravarApenasNaTabelaDePrecoAlterada: Boolean = False);
  var
    strCamAlt: String;
    fltValorDig: Double;
    fltValor : Double;
    fltValorEmb: Double;
    dtaValor : TDateTime;
    intRegPrc: Integer;
    strTabPrc: String;
    blnEmbalagem,
    blnRecCus: Boolean;
    intIndice: Integer;
    blnReplicaValorItens,
    blnEPrecoDeVendaOuMargemBruta,
    blnReplicaTabela: Boolean;
    intCont: Integer;
    linhaAtual: integer;
    blnValidaEscala: Boolean;
    function fCampo(strCampo: String): TField;
    begin
      Result := fCampoDatSet(Dataset, strCampo);
    end;

    function fValidaMargem: Boolean;
    Begin
      Result := fValidaMargemDataSet(Dataset, fltValor, strTabPrc);
    End;
begin
  FTravarApenasNaTabelaDePrecoAlterada := False;
  Try
    If (Not Dataset.Active) Or Dataset.IsEmpty Then
      Exit;

    intRegPrc := DataSetPrecos.RecNo;
    DataSetPrecos.DisableControls;
    Try
      linhaAtual := DataSetPrecos.RecNo;
      strCamAlt := Copy(DataSetPrecos.FieldByName('NOMCAM').AsString, 5, 10);
      blnValidaEscala := Pos(strCamAlt, CAMPOSUTILIZAVARIACAO ) > 0;

      If Not GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_' + strCamAlt) Then
        Exit;
      If FArredondaPrecoEmLote Then
        blnExibeTelaDigValor := False;

      If fEmptyStr(strCamAlt) Or (Pos(strCamAlt, 'PREDOL_COMLIQ_PRECUS_CUSREA_VENIM') > 0) Then
        Exit;

      If (Pos('VENIM', strCamAlt) > 0) Then
        Exit;

      If (AnsiStartsStr('PREVE', strCamAlt) Or AnsiStartsStr('MARBR', strCamAlt)) And blnBloPre Then
        Exit;

      If AnsiStartsStr('CUSVE', strCamAlt) Then
        Exit;

      If (DataSetPrecos <> FCdsPrecos) Then
        FCdsPrecos.Locate('SEQUEN', DataSetPrecos.FieldByName('SEQUEN').AsString, []);

      blnRecCus :=  Not (AnsiStartsStr('PREVE', strCamAlt) Or
                         AnsiStartsStr('MARBR', strCamAlt) Or
                         AnsiStartsStr('COMTB', strCamAlt));

      If AnsiStartsStr('PREVE', strCamAlt) Or AnsiStartsStr('MARBR', strCamAlt) Then
      Begin
        strTabPrc := RightStr(strCamAlt, 1);
        FstrTabPrc := strTabPrc;
        FTravarApenasNaTabelaDePrecoAlterada := ATravarApenasNaTabelaDePrecoAlterada;
      End Else
      Begin
        strTabPrc := '1';
      End;

      If Assigned(FFatPre) And ((strTabPrc <> '1') And (FFatPre.fTabelaAtiva(StrToInt(strTabPrc)))) Then
        Exit;

      If blnContinuaReplicacaoDeTabela Then
        blnReplicaTabela:= True;

      If Pos(strCamAlt, 'DTAVAL') > 0 Then
      Begin
        dtaValor := fCampo(strCamAlt).AsDateTime;

        If ffrmData(dtaValor,
                    FCdsPrecos.FieldByName('DESCRI').AsString,
                    'Nova Data',
                    VS_Date) Then
        Begin
          Dataset.Edit;
          fCampo(strCamAlt).AsDateTime := dtaValor;
          Dataset.Post;
        End;
      End Else
      Begin

        If blnExibeTelaDigValor Then
          fltValor := fCampo(strCamAlt + IIf(fCampoTemUti(strCamAlt), '_UTI', '')).AsFloat
        Else If (FArredondaPreco) And (AnsiStartsStr('PREVE', strCamAlt)) Then
          fltValor := fCampo(strCamAlt).AsFloat
        Else
          fltValor := fltValorASerReplicado;

        If fEmptyStr(FCdsPrecos.FieldByName('EMBATU').AsString) Then
          fltValorEmb := 0
        Else
          fltValorEmb := strToFloat(AnsiReplaceStr(FCdsPrecos.FieldByName('EMBATU').AsString, '.', ''));

        blnEmbalagem := ((Pos('Preço', FCdsPrecos.FieldByName('DESCRI').AsString) > 0) Or
                 (FCdsPrecos.FieldByName('NOMCAM').AsString = 'LTP_VALFRE') Or
                 (FCdsPrecos.FieldByName('NOMCAM').AsString = 'LTP_OUTVAL'));

        fltValorDig := -999999;
        If (intFlagUtilizarNovoPreco > -1) Or ((intFlagUtilizarNovoPreco = -1) And
          (blnEmbalagem And (fDigitaValor(fltValor,
                                           fltValorEmb,
                                           blnReplicaTabela,
                                           blnReplicaValorItens,
                                           DataSet.FieldByName('EMBALA').AsFloat,
                                           FCdsPrecos.FieldByName('DESCRI').AsString,
                                           TFloatField(fCampo(strCamAlt)).DisplayFormat,
                                           (Pos(strCamAlt, 'ITE_PREVE1_ITE_PREVE2_ITE_PREVE3_ITE_PREVE4_' +
                                                           'ITE_PREVE5_ITE_PREVE6_ITE_PREVE7_ITE_PREVE8_' +
                                                           'ITE_PRECOM') <= 0) Or FZerLot, False, True, Not(blnExibeTelaDigValor),
                                           blnValidaEscala,
                                           IIF(blnValidaEscala, 0, -1),
                                           IIF(blnValidaEscala, 100, -1)))) Or
           ((not blnEmbalagem) And (fDigitaValor(fltValor,
                                    blnReplicaTabela,
                                    blnReplicaValorItens,
                                    FCdsPrecos.FieldByName('DESCRI').AsString,
                                    TFloatField(fCampo(strCamAlt)).DisplayFormat,
                                    (Pos(strCamAlt, 'ITE_PREVE1_ITE_PREVE2_ITE_PREVE3_ITE_PREVE4_' +
                                                    'ITE_PREVE5_ITE_PREVE6_ITE_PREVE7_ITE_PREVE8_' +
                                                    'ITE_PRECOM') <= 0), False, True, Not(blnExibeTelaDigValor),
                                    blnValidaEscala,
                                    IIF(blnValidaEscala, 0, -1),
                                    IIF(blnValidaEscala, 100, -1)) Or FZerLot))) Then
        Begin
          If intFlagUtilizarNovoPreco = -1 Then
          Begin
            If AnsiStartsStr('MARBR', strCamAlt) And (Pos(fCfgSis('MARMKP'), '1_5_2') > 0) Then
            Begin
              If (fltValor >= 100) And (fCfgSis('MARMKP') <> '2') Then
              Begin
                fMensagem('ATENÇÃO!', 'Margem não permitida: maior ou igual a 100!', ['&Ok']);
                Exit;
              End
              Else If Not fValidaMargem Then
              Begin
                fMensagem('', MSG_VALIDACAO_MARGEM + FStrCodIteProcessando, ['&Ok']);
                Exit;
              End;
            End;

            If FArredondaPreco Then
            Begin

              If AnsiStartsStr('PREVE', strCamAlt) And Not(fEmptyStr(FCasaDecimal)) Then
              Begin
                fltValor := RoundTo(fltValor, StrToIntDef(FCasaDecimal,0) * -1 );
              End;

            End;

            if (fltValorASerReplicado > 0) Then
              fltValor:= fltValorASerReplicado;

            fltValorDig := fltValor;

          End
          Else
          Begin
            fltValor := AFltValor;

            if (fltValorASerReplicado > 0) Then
              fltValor:= fltValorASerReplicado;

            If FArredondaPreco Then
            Begin

              If AnsiStartsStr('PREVE', strCamAlt) And Not(fEmptyStr(FCasaDecimal)) Then
              Begin
                fltValor := RoundTo(fltValor, StrToIntDef(FCasaDecimal,0) * -1 );
              End;

            End;


          End;

          FstrTabela := '';
          If (AnsiStartsStr('PREVE', strCamAlt)) Then
            FstrTabela := strCamAlt[6];

          blnEPrecoDeVendaOuMargemBruta:= (AnsiStartsStr('PREVE', strCamAlt)) Or (AnsiStartsStr('MARBR', strCamAlt));
          If blnReplicaTabela And blnEPrecoDeVendaOuMargemBruta Then
          Begin
            intCont:= Length(VS_strTabPrc) + 1;
          End
          Else
            intCont:= 2;

          for intCont:= 1 to intCont-1 do
          Begin
            Dataset.Edit;

            If blnReplicaTabela And (AnsiStartsStr('PREVE', strCamAlt)) Then
              strCamAlt:= 'PREVE'+IntToStr(intCont);

            If blnReplicaTabela And (AnsiStartsStr('MARBR', strCamAlt)) Then
              strCamAlt:= 'MARBR'+IntToStr(intCont);

            If Assigned(DataSet.FindField('LTP_' + strCamAlt + '_UTI')) Then
            Begin
              fCampo(strCamAlt + '_UTI').AsFloat := fltValor;
              If fltValorDig > -999999 Then
                fCampo(strCamAlt + '_ATU').AsFloat := fltValorDig;
            End
            Else
              fCampo(strCamAlt).AsFloat := fltValor;

            If blnRecCus Then
            Begin
              fCampo('COMLIQ').AsFloat := fCalculaPrecoCompraLiq(fCampo('PRECOM_UTI').AsFloat,
                                                                 fCampo('DESF01_UTI').AsFloat,
                                                                 fCampo('DESF02_UTI').AsFloat,
                                                                 fCampo('DESF03_UTI').AsFloat,
                                                                 fCampo('DESF04_UTI').AsFloat,
                                                                 fCampo('DESF05_UTI').AsFloat,
                                                                 fCampo('DESF06_UTI').AsFloat,
                                                                 intDecimais,
                                                                 Dataset.FieldByName('ITE_PREDOL').AsString = 'S',
                                                                 0,
                                                                 FCotDol);


              fCampo('PRECUS').AsFloat := fCalculaPrecoCusto(DataSet);
            End;

            For intIndice := 1 To 7 Do
              pAlteraPreco(Dataset, intIndice, AnsiStartsStr('PREVE', strCamAlt), AnsiStartsStr('MARBR', strCamAlt));

            If intFlagUtilizarNovoPreco = -1 Then
               pAjustaPrecos(Dataset, strTabPrc);

            Try
              blnRecalcularMargemPrecoBeforePost := False;
              Dataset.Post;
            Finally
              blnRecalcularMargemPrecoBeforePost := True;
            End;

          End

         End;

        End;
        If  (strGrupoPrecoReplica <> '') And  blnExibeTelaDigValor  and blnReplicaValorItens Then
          strGrupoPrecoReplica := '';
        If blnChamadaOriginal And (strGrupoPrecoReplica <> '') Then
          blnReplicaValorItens := True;


        {se não marcar para replicar para todos porem o item alterado é de um determinado grupo de preço então altera todos do mesmo grupo}

        pReplicaPrecoParaItens(DataSet, DataSetPrecos, blnReplicaValorItens, False, fltValor, blnReplicaTabela, linhaAtual);

    Finally

      If intFlagUtilizarNovoPreco > - 1 Then
        pAtualizaCdsPrecos(Dataset, strCamAlt, AfltValAtu)
      Else
        pAtualizaCdsPrecos(Dataset);

      pSetCDSGrids;

      DataSetPrecos.EnableControls;
      DataSetPrecos.RecNo := intRegPrc;
    End;
  Finally
    FTravarApenasNaTabelaDePrecoAlterada := False;
    FstrTabPrc := '';
  End;

end;


procedure TLotePrecos.pReplicaPrecoParaItens(Dataset, DataSetPrecos: TDataSet; blnRepeticaoValor:Boolean = False; blnExibeTelaDigValor: Boolean = False; fltValorASerReplicado: Double = 0; blnReplicaTabela: Boolean = False; intLinhaAtual: integer = -1);
Var
  intRegPrc :Integer;
Begin

  If blnRepeticaoValor Then
  Begin
    Dataset.First;
    If intLinhaAtual > -1 Then
    Begin
      intRegPrc := intLinhaAtual;
      DataSetPrecos.RecNo := intRegPrc;
    End
    Else
      intRegPrc := DataSetPrecos.RecNo;

    While not Dataset.eof do
    Begin
      If ((strGrupoPrecoReplica <> '') And (strGrupoPrecoReplica =  Dataset.FieldByName('ITE_CODGPR').AsString)) Or
          (strGrupoPrecoReplica = '') Then
        pAlterarPrecoMargem(False, Dataset, DataSetPrecos, -1, -1, 0, False, fltValorASerReplicado, blnReplicaTabela);

      DataSetPrecos.RecNo:= intRegPrc;

      Dataset.Next;

    End;
  End;


End;

Function TLotePrecos.fAbreConsulta(blnPedido: Boolean): Boolean;
  var
    blnRefresh : Boolean;
Begin
  With cdsConsulta Do
  Begin
    DisableControls;
    If (Not IsEmpty) And (ChangeCount > 0) Then
      CancelUpdates;

    Close;

    If blnPedido Then
    Begin
      blnRefresh := intUltimoSQLExec = 1;
      qryQuery.SQL.Text := fMontaSqlItensPedido(blnPedido);
      cdsConsulta.IndexFieldNames := '';
    End
    Else
    Begin
      blnRefresh := intUltimoSQLExec = 2;
      qryQuery.SQL.Text := fMontaSqlItens(blnPedido);
      cdsConsulta.IndexFieldNames := 'ORDDIG';
    End;

    If Assigned(qryQuery.FindParam('COTDOL')) Then
      If fltCotDol = 0 Then
        qryQuery.ParamByName('COTDOL').AsFloat := 1
      Else
        qryQuery.ParamByName('COTDOL').AsFloat := fltCotDol;

    If Assigned(qryQuery.FindParam('COTANT')) Then
      If fltCotAnt = 0 Then
        qryQuery.ParamByName('COTANT').AsFloat := 1
      Else
        qryQuery.ParamByName('COTANT').AsFloat := fltCotAnt;

    If Assigned(qryQuery.FindParam('DECUNI')) Then
      qryQuery.ParamByName('DECUNI').AsInteger := intDecimais;

    Result := fAbreClient(True, 'TLotePrecos.fAbreConsulta', blnRefresh);

    FEhPedido := blnPedido;

    pRecalculaItensPedido;

    EnableControls;
  End;
End;

Procedure TLotePrecos.pCalculaPrecoIdeal(Dataset: TDataSet);
  Var
    intContador: Integer;
Begin
  If Not FMarIde Then
    Exit;

  With Dataset Do
  Begin
    For intContador := 1 To 7 Do
      Dataset.FieldByName('ITE_PREID' + IntToStr(intContador)).AsFloat :=
         fCalculaPrecoVenda(1,
                            fCampoDatset(Dataset, 'PRECUS').AsFloat + fCampoDatset(Dataset, 'OUTVAL').AsFloat,
                            0,
                            Dataset.FieldByName('LTP_MARID' + IntToStr(intContador)).AsFloat,
                            fCampoDatset(Dataset, 'ICMSAI_UTI').AsFloat,
                            fCampoDatset(Dataset, 'IMPFED_UTI').AsFloat,
                            fCampoDatset(Dataset, 'DESOPE_UTI').AsFloat,
                            fCampoDatset(Dataset, 'COMTB' + IntToStr(intContador)).AsFloat);
  End;
End;

procedure TLotePrecos.pCarregaPreMedNaPreCom;
var
  strStatus: String;
begin
  inherited;
  If cdsConsulta.IsEmpty Then
    Exit;

  intOpcCarregaPreMed := fMensagem('','Atualizar o preço de compra, carregando seu respectivo preço médio:',
                                ['Selecionados', 'Todos', 'Cancelar'], 1);
  Case intOpcCarregaPreMed Of
    1: strStatus := 'Carregando preço médio para itens selecionados...';
    2: strStatus := 'Carregando preço médio para todos os itens..';
    3: Exit;
  End;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := strStatus;
    frmGravando.fExecutarAcao := fCarregaPreMedPrg;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TLotePrecos.pCarregaPreMedNaPreCom]');
    End;
  End
end;

Function TLotePrecos.fRecalculaItensPedidoVenaComImpostos(pgbStatus: TcxProgressBar = Nil):Boolean;
var intContador: integer;
    lFCdsPrecos: TUniClientDataSet;
    lFormat: String;
    lAutIncIni: String;
begin
  Try
    Result := True;
    With cdsConsulta Do
    Begin
      cdsConsulta.DisableControls;
      pAfterScroll := AfterScroll;
      AfterScroll := nil;
      pgbStatus.Properties.Max := RecordCount;
      pgbStatus.Position := 0;
      Application.ProcessMessages;
      Try
        lAutIncIni := cdsConsulta.FieldByName('AUTOINCREM').AsString;
        First;
        While Not Eof Do
        Begin
          For intContador := 1 To 7 Do
          Begin
            If blnALTCVI then
            begin
               If FCdsPrecos.Locate('NOMCAM', 'LTP_VENIM' + IntToStr(intContador),[]) then
               begin
                 Edit;
                 lFormat:= TFloatField(cdsConsulta.FindField(FCdsPrecos.FieldByName('NOMCAM').AsString)).DisplayFormat;
                 cdsConsulta.FieldByName('LTP_VENIM' + IntToStr(intContador)).AsFloat :=  fCalculaPrecoVendaComImpostos(FieldByName('LTP_CODITE').AsString,
                                                                                             FEstado,
                                                                                             FPerfil,
                                                                                             FieldByName('LTP_PREVE' + IntToStr(intContador)).AsFloat);
                 cdsConsulta.FieldByName('LTP_VENIM' + IntToStr(intContador)+'_ANT').AsFloat := fCalculaPrecoVendaComImpostos(FieldByName('LTP_CODITE').AsString,
                                                                                                   FEstado,
                                                                                                   FPerfil,
                                                                                                   FieldByName('LTP_PREVE' + IntToStr(intContador)+ '_ANT').AsFloat);
                 Post;
                 If lAutIncIni = cdsConsulta.FieldByName('AUTOINCREM').AsString Then
                 Begin
                   lFCdsPrecos  := FCdsPrecos;
                   case FCdsPrecos.FieldByName('USGRID').AsInteger of
                     1: lFCdsPrecos := FCdsPrecos1;
                     2: lFCdsPrecos := FCdsPrecos2;
                     3: lFCdsPrecos := FCdsPrecos3;
                   end;
                   If lFCdsPrecos.Locate('NOMCAM', 'LTP_VENIM' + IntToStr(intContador),[]) then
                   Begin
                     lFCdsPrecos.Edit;
                     lFCdsPrecos.FieldByName('VALATU').AsString := FormatFloat(lFormat, cdsConsulta.FieldByName('LTP_VENIM' + IntToStr(intContador)).AsFloat);
                     lFCdsPrecos.FieldByName('VALANT').AsString := FormatFloat(lFormat, cdsConsulta.FieldByName('LTP_VENIM' + IntToStr(intContador)+'_ANT').AsFloat);
                     lFCdsPrecos.FieldByName('EMBATU').AsString := FormatFloat(lFormat, cdsConsulta.FieldByName('LTP_VENIM' + IntToStr(intContador)).AsFloat);
                     lFCdsPrecos.FieldByName('EMBANT').AsString := FormatFloat(lFormat, cdsConsulta.FieldByName('LTP_VENIM' + IntToStr(intContador)+'_ANT').AsFloat);
                     lFCdsPrecos.post;
                   end;
                 end;
               End;
            End;
          End;
          Next;
          pgbStatus.Position := pgbStatus.Position + 1;
          Application.ProcessMessages;
        End;
      Finally
       cdsConsulta.EnableControls;
        AfterScroll := pAfterScroll;
      End;
    End;
  Except
    on e: Exception do
    begin
      pMensagensErro(E.Message, '[TLotePrecos.fRecalculaItensPedidoVenaComImpostos]');
      Result := False;
    End;
  End;
End;

Function TLotePrecos.fRecalculaItensPedido(pgbStatus: TcxProgressBar = Nil):Boolean;
  Var
    fltValFre,
    fltFreRes: Double;
    intContador: Integer;
    intPerFre: Integer;
Begin
  With cdsConsulta Do
  Begin
    intPerFre := fCfgSis('PERFRE', varInteger);

    pgbStatus.Properties.Max := RecordCount;
    pgbStatus.Position := 0;
    Application.ProcessMessages;

    pAfterScroll := AfterScroll;
    AfterScroll := Nil;

    fltFreRes := FTotFre;

    TFloatField(FieldByName('ITE_CUSREA_DIF')).DisplayFormat := '###,##0.00';
    TFloatField(FieldByName('ITE_CUSREA')).DisplayFormat     := '###,##0.00';
    TFloatField(FieldByName('ITE_CUSREA_ANT')).DisplayFormat := '###,##0.00';
    TFloatField(FieldByName('LTP_PRECUS')).DisplayFormat     := '###,##0.00';
    TFloatField(FieldByName('LTP_PRECUS_ANT')).DisplayFormat := '###,##0.00';
    TFloatField(FieldByName('DIFCUS')).DisplayFormat         := '###,##0.00';


//    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;

      If FEhPedido And (FTotIte > 0) Then
      Begin
        If RecNo = RecordCount Then
          fltValFre := fltFreRes
        Else
          fltValFre := RoundTo(FTotFre * FieldByName('ITE_TOTITE').AsFloat / FTotIte, -2);

        If FieldByName('ITE_TOTITE').AsFloat > 0 Then
        Begin

          If intPerFre = 2 Then
          Begin

            If FieldByName('ITE_QTDITE').AsFloat > 0 Then
              FieldByName('LTP_VALFRE').AsFloat := RoundTo(fltValFre / FieldByName('ITE_QTDITE').AsFloat, - intDecimais)
            Else
              FieldByName('LTP_VALFRE').AsFloat := 0;

          End
          Else
            FieldByName('LTP_FREENT').AsFloat := (fltValFre / FieldByName('ITE_TOTITE').AsFloat) * 100

        End Else
        Begin

          If intPerFre = 2 Then
            FieldByName('LTP_VALFRE').AsFloat := 0
          Else
            FieldByName('LTP_FREENT').AsFloat := 0;

        End;

        fltFreRes := fltFreRes - fltValFre;
      End;

      FieldByName('LTP_COMLIQ').AsFloat := fCalculaPrecoCompraLiq(FieldByName('LTP_PRECOM_UTI').AsFloat,
                                                                  FieldByName('LTP_DESF01_UTI').AsFloat,
                                                                  FieldByName('LTP_DESF02_UTI').AsFloat,
                                                                  FieldByName('LTP_DESF03_UTI').AsFloat,
                                                                  FieldByName('LTP_DESF04_UTI').AsFloat,
                                                                  FieldByName('LTP_DESF05_UTI').AsFloat,
                                                                  FieldByName('LTP_DESF06_UTI').AsFloat,
                                                                  intDecimais,
                                                                  FieldByName('ITE_PREDOL').AsString = 'S',
                                                                  0,
                                                                  FCotDol);

      FieldByName('LTP_PRECUS').AsFloat := fCalculaPrecoCusto(cdsConsulta);

      FieldByName('ITE_CUSREA').AsFloat := fCalculaCustoReal(FieldByName('LTP_PRECUS').AsFloat,
                                                             FieldByName('LTP_ICMSAI_UTI').AsFloat,
                                                             FieldByName('LTP_IMPFED_UTI').AsFloat,
                                                             FieldByName('LTP_DESOPE_UTI').AsFloat,
                                                             FieldByName('LTP_OUTVAL_UTI').AsFloat);

      FieldByName('ITE_CUSREA_ANT').AsFloat := fCalculaCustoReal(FieldByName('LTP_PRECUS_ANT').AsFloat,
                                                                 FieldByName('LTP_ICMSAI_ANT').AsFloat,
                                                                 FieldByName('LTP_IMPFED_ANT').AsFloat,
                                                                 FieldByName('LTP_DESOPE_ANT').AsFloat,
                                                                 FieldByName('LTP_OUTVAL_ANT').AsFloat);
      If FieldByName('ITE_CUSREA_ANT').AsFloat <> 0 Then
        FieldByName('ITE_CUSREA_DIF').AsFloat := ((FieldByName('ITE_CUSREA').AsFloat - FieldByName('ITE_CUSREA_ANT').AsFloat) / FieldByName('ITE_CUSREA_ANT').AsFloat) * 100;

      If FieldByName('LTP_PRECUS_ANT').AsFloat <> 0 Then
        FieldByName('DIFCUS').AsFloat := ((FieldByName('LTP_PRECUS').AsFloat - FieldByName('LTP_PRECUS_ANT').AsFloat) / FieldByName('LTP_PRECUS_ANT').AsFloat) * 100;

      For intContador := 1 To 7 Do
        pAlteraPreco(cdsConsulta, intContador, False, False);

      pAjustaPrecos(cdsConsulta, '1');

      For intContador := 1 To 7 Do
      Begin
        FieldByName('DIFMA' + IntToStr(intContador)).AsFloat := FieldByName('LTP_MARBR' + IntToStr(intContador)).AsFloat -
                                                                FieldByName('LTP_MARBR' + IntToStr(intContador)+ '_ANT').AsFloat;

        If FieldByName('LTP_PREVE' + IntToStr(intContador) + '_ANT').AsFloat <> 0 Then
          FieldByName('DIFPR' + IntToStr(intContador)).AsFloat :=
            ((FieldByName('LTP_PREVE' + IntToStr(intContador)).AsFloat - FieldByName('LTP_PREVE' + IntToStr(intContador) + '_ANT').AsFloat) /
                                               FieldByName('LTP_PREVE' + IntToStr(intContador) + '_ANT').AsFloat) * 100;


        If blnALTCVI then
        begin
           cdsConsulta.FieldByName('LTP_VENIM' + IntToStr(intContador)).AsFloat := fCalculaPrecoVendaComImpostos(FieldByName('LTP_CODITE').AsString,
                                                                                                     FEstado,
                                                                                                     FPerfil,
                                                                                                     cdsConsulta.FieldByName('LTP_PREVE' + IntToStr(intContador)).AsFloat);

           FieldByName('LTP_VENIM' + IntToStr(intContador)+'_ANT').AsFloat := fCalculaPrecoVendaComImpostos(FieldByName('LTP_CODITE').AsString,
                                                                                                     FEstado,
                                                                                                     FPerfil,
                                                                                                     FieldByName('LTP_PREVE' + IntToStr(intContador)+ '_ANT').AsFloat);
        End;


      End;

      pCalculaPrecoIdeal(cdsConsulta);

      Post;

      Next;

      pgbStatus.Position := pgbStatus.Position + 1;
      Application.ProcessMessages;
    End;
    First;
//    EnableControls;

    AfterScroll := pAfterScroll;

    If Assigned(pAfterScroll) Then
      pAfterScroll(cdsConsulta);
  End;

  Result := True;
End;

Procedure TLotePrecos.pRecalculaItensPedido;
Begin
  cdsConsulta.BeforePost := Nil;
  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := fRecalculaItensPedido;
    frmGravando.lblGravando.Caption := 'Aguarde, recalculando preços...';

    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TLotePrecos.pRecalculaItensPedido]');
    End;
  End;

  pFreeAndNil(frmGravando);

  cdsConsulta.BeforePost := pBeforePost;
End;

Procedure TLotePrecos.pRecalculaItensPedidoVendaComImpostos;
Begin
  If cdsConsulta.IsEmpty Then
    Exit;

  cdsConsulta.BeforePost := Nil;
  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := fRecalculaItensPedidoVenaComImpostos;
    frmGravando.lblGravando.Caption := 'Aguarde, recalculando preços de venda com impostos...';

    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TLotePrecos.pRecalculaItensPedidoVendaComImpostos]');
    End;
  End;

  pFreeAndNil(frmGravando);

  cdsConsulta.BeforePost := pBeforePost;
End;

Function TLotePrecos.fSelecionaItens(pgbStatus: TcxProgressBar = Nil):Boolean;
Var
  intRecNo: Integer;
Begin
  stlListSelecao.Clear;

  cdsConsulta.DisableControls;
  intRecNo := cdsConsulta.RecNo;
  Try
    With cdsConsulta Do
    Begin
      pAfterScroll := AfterScroll;
      AfterScroll := Nil;

      pgbStatus.Properties.Max := RecordCount;
      pgbStatus.Position := 0;
      Application.ProcessMessages;

  //    DisableControls;
      First;
      While Not Eof Do
      Begin
        If FMarcar Then
        Begin
          If FPrcRdz Then
          Begin
            If (cdsConsulta.FieldByName('LTP_PRECOM_ATU').asFloat < cdsConsulta.FieldByName('LTP_PRECOM_ANT').asFloat) Then
              stlListSelecao.Add(QuotedStr(FieldByName('AUTOINCREM').AsString));
          End
          Else
            stlListSelecao.Add(QuotedStr(FieldByName('AUTOINCREM').AsString));
        End;
        Next;

        pgbStatus.Position := pgbStatus.Position + 1;
        Application.ProcessMessages;
      End;
  //    First;
  //    EnableControls;

      AfterScroll := pAfterScroll;

    End;
  Finally
    cdsConsulta.EnableControls;
    cdsConsulta.RecNo := intRecNo;
  End;

  Result := True;
End;

Procedure TLotePrecos.pMarcaTodos(blnMarcar: Boolean; blnPrcRdz: Boolean = False);
Begin
  Try
    FMarcar := blnMarcar;
    FPrcRdz := blnPrcRdz;
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := fSelecionaItens;
    If blnMarcar Then
      frmGravando.lblGravando.Caption := 'Aguarde, selecionando itens...'
    Else
      frmGravando.lblGravando.Caption := 'Aguarde, desmarcando itens...';

    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TLotePrecos.pMarcaTodos]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

procedure TLotePrecos.pMensagemLotePrecoAtivar(intQtdIte: Integer; strDtaDoc: String);
Var
  msgMensagem: TMsgInterna;
  qryCadOpe  : TUniQuery;
  stlMensagem: TStringList;
Begin
  qryCadOpe   := fCriaQuery;
  With qryCadOpe, SQL Do
  Begin
    Clear;
    Add('SELECT OPE_CODOPE AS CODOPE FROM CADOPE');
    Add('WHERE LOCATE(:CODEMP, OPE_EMPACE) > 0 AND ');
    Add(' OPE_MSGLPA = "S"');
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    If Not IsEmpty Then
    Begin
      msgMensagem := TMsgInterna.Create(Nil);
      stlMensagem := TStringList.Create;
      stlMensagem.Clear;
      stlMensagem.Add('-------------------------------------------------------------------- '       );
      stlMensagem.Add('       Ativação de Lote de Preços                                    '       );
      stlMensagem.Add('-------------------------------------------------------------------- '       );
      stlMensagem.Add(' Dt.Entrada   : '+ FormatDateTime('dd/mm/yyyy',VS_Date)                      );
      stlMensagem.Add(' Dt.Documento : '+ FormatDateTime('dd/mm/yyyy',StrToDate(strDtaDoc))         );
      stlMensagem.Add(' N.Documento  : '+ FNumDoc +'  Série: '+ FSerie_ +' Espécie: '+ FEspDoc      );
      stlMensagem.Add(' Fornecedor   : '+ FCodFor +' - ' + fRetNomFornecedor(FCodFor)               );
      stlMensagem.Add('-------------------------------------------------------------------- '       );
      stlMensagem.Add(' Qtd.Itens    : '+ IntToStr(intQtdIte)                                       );
      stlMensagem.Add('-------------------------------------------------------------------- '       );
      While Not Eof Do
      Begin
        msgMensagem.fEnviaMensagem('NOVO LOTE DE PREÇO PARA ATIVAR ( ' + FNumDoc + ' - ' + FEspDoc + ' )',
                                   stlMensagem.Text, strLoginUsuarioLogado, FieldByName('CODOPE').AsString, 'N', '');
        Next;
      End;
      FreeAndNil(msgMensagem);
      FreeAndNil(stlMensagem);
    End;
    Close;
  End;
  FreeAndNil(qryCadOpe);
end;

Procedure TLotePrecos.pAdicionarListaSelecao(AStrAutInc: String);
Var
  intIndice: Integer;
Begin
  intIndice := stlListSelecao.IndexOf(QuotedStr(AStrAutInc));

  If intIndice > -1 Then
    stlListSelecao.Delete(intIndice)
  Else
    stlListSelecao.Add(QuotedStr(AStrAutInc));
End;

Procedure TLotePrecos.pMarcaDesmarca;
var
  intIndice,
  intRecNo: Integer;
  blnDesmarcar: Boolean;
  strIteGrp: String;
  intRecNoAnt: Integer;
  intRecNoProx: Integer;
  blnSelecionado: Boolean;
  blnTemGrupoPreco: Boolean;
Begin
  blnTemGrupoPreco := False;
  With cdsConsulta Do
  Begin
    If IsEmpty Then
      Exit;
    strIteGrp := cdsConsulta.FieldByName('ITE_CODGPR').AsString;
    intRecNo := cdsConsulta.RecNo;
    intRecNoProx := intRecNo;
    intRecNoAnt := intRecNo;

    intIndice := stlListSelecao.IndexOf(QuotedStr(cdsConsulta.FieldByname('AUTOINCREM').AsString));
    blnDesmarcar := intIndice > -1;

    Try
      If Not fEmptyStr(cdsConsulta.FieldByName('ITE_CODGPR').AsString) Then
      Begin
        cdsConsulta.DisableControls;
        cdsConsulta.Filter := 'ITE_CODGPR = ' + QuotedStr(cdsConsulta.FieldByName('ITE_CODGPR').AsString);
        cdsConsulta.Filtered := True;
        blnTemGrupoPreco := cdsConsulta.RecordCount > 1;
        cdsConsulta.Filtered := False;

        If blnTemGrupoPreco Then
        Begin
          fMensagem('', 'Existem outros itens no documento que pertencem ao mesmo grupo de preços, estes itens também serão ' + IIF(blnDesmarcar, 'desmarcados', 'marcados'),['&Ok']);
          cdsConsulta.First;
          While Not cdsConsulta.Eof Do
          Begin
            blnSelecionado := stlListSelecao.IndexOf(QuotedStr(cdsConsulta.FieldByname('AUTOINCREM').AsString)) > 0;
            If cdsConsulta.RecNo < intRecNo Then
              If blnSelecionado Then
                intRecNoAnt := cdsConsulta.RecNo;

            If cdsConsulta.FieldByName('ITE_CODGPR').AsString = strIteGrp Then
            Begin
              pAdicionarListaSelecao(cdsConsulta.FieldByname('AUTOINCREM').AsString);
              blnSelecionado := true;
            End;

            If cdsConsulta.RecNo > intRecNo Then
              If intRecNoProx = intRecNo Then
                  If Not blnSelecionado Then
                    intRecNoProx := cdsConsulta.RecNo;
            cdsConsulta.Next;
          End;
          cdsConsulta.EnableControls;
          If intRecNoProx > intRecNo Then
            intRecNo := intRecNoProx
          else
            intRecNo := intRecNoAnt;
          cdsConsulta.RecNo := intRecNo;
        End
        Else
        Begin
          cdsConsulta.RecNo := intRecNo;
          pAdicionarListaSelecao(cdsConsulta.FieldByname('AUTOINCREM').AsString);
        End;
      End
      Else
      Begin
        cdsConsulta.RecNo := intRecNo;
        pAdicionarListaSelecao(cdsConsulta.FieldByname('AUTOINCREM').AsString);
      End;
    Finally
      If Not blnTemGrupoPreco Then
        cdsConsulta.Next;
      cdsConsulta.EnableControls;
      If intRecNoAnt <> cdsConsulta.RecNo Then
      Begin
        If Assigned(cdsConsulta.AfterScroll) Then
          cdsConsulta.AfterScroll(cdsConsulta);
      End;
    End;
  End;
End;

Function TLotePrecos.fMarcaOpcCalculo(blnPreco: Boolean): Boolean;
Begin
  Try
    FOpcCalPreco := blnPreco;
    pCriarFormularios(TfrmGravando,frmGravando);

    frmGravando.fExecutarAcao := fMarcaOpcCalculoPrg;

    If FOpcCalPreco Then
      frmGravando.lblGravando.Caption := 'Alterando opção de cálculo para Preço de Venda...'
    Else
      frmGravando.lblGravando.Caption := 'Alterando opção de cálculo para Margem...';

    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TLotePrecos.fMarcaOpcCalculo]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

Function TLotePrecos.fMarcaOpcCalculoPrg(pgbStatus: TcxProgressBar = Nil):Boolean;
   Var
     pAfterScroll: TDataSetNotifyEvent;
     intContador: Integer;
Begin
  stlListSelecao.Clear;
  cdsConsulta.DisableControls;

  With cdsConsulta Do
  Begin
    pAfterScroll := AfterScroll;
    AfterScroll := Nil;
    BeforePost  := Nil;

    pgbStatus.Properties.Max := RecordCount;
    pgbStatus.Position := 0;
    Application.ProcessMessages;

    First;
    While Not Eof Do
    Begin
      Edit;

      For intContador := 1 To 7 Do
        If FOpcCalPreco  Then
          FieldByName('TIPCAL' + IntToStr(intContador)).AsString := 'Preço Venda'
        Else
          FieldByName('TIPCAL' + IntToStr(intContador)).AsString := 'Margem';

      Post;

      Next;

      pgbStatus.Position := pgbStatus.Position + 1;
      Application.ProcessMessages;
    End;

    BeforePost  := pBeforePost;
    AfterScroll := pAfterScroll;

    pAfterScroll(cdsConsulta);
  End;
  cdsConsulta.EnableControls;

  Result := True;
End;

Procedure TLotePrecos.pAfterPost(dataSet: TDataSet);
Begin
  If Assigned(pAfterScroll) Then
  Begin
    dataSet.AfterScroll := pAfterScroll;
    pAfterScroll(dataSet);
  End;
End;

Function TLotePrecos.fRecarregaAtual(blnPreco: Boolean; blnMargIdeal : Boolean = False): Boolean;
Begin
  Try
    FRecarregaPreco := blnPreco;
    FRecarregaMargIdeal := blnMargIdeal;
    pCriarFormularios(TfrmGravando,frmGravando);

    frmGravando.fExecutarAcao := fRecarregaAtualPrg;

    If FRecarregaPreco Then
      frmGravando.lblGravando.Caption := 'Recarregando preços...'
    Else
      frmGravando.lblGravando.Caption := 'Recarregando margens...';

    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TLotePrecos.fRecarregaAtual]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

Function TLotePrecos.fRecarregaAtualPrg(pgbStatus: TcxProgressBar = Nil):Boolean;
   Var
     pAfterScroll: TDataSetNotifyEvent;
     intContador: Integer;
     strTabPrc,
     strIndiceSalvo: String;
     blnFiltered: Boolean;
     strFilter: String;
     intRecNo: integer;
Begin
  stlListSelecao.Clear;
  cdsConsulta.DisableControls;

  {Salva os index (Ordenação)}
  strIndiceSalvo := cdsConsulta.IndexFieldNames;
  {Limpra Ordenação}
  cdsConsulta.IndexFieldNames := '';

  strTabPrc := '1';
  For intContador := 1 To Length(VS_strTabPrc) Do
    If VS_strTabPrc[intContador] = 'S' Then
    Begin
      strTabPrc := IntToStr(intContador);
      Break;
    End;

  With cdsConsulta Do
  Begin
    pAfterScroll := cdsConsulta.AfterScroll;

    AfterScroll  := Nil;
    BeforePost   := Nil;

    blnFiltered := Filtered;
    strFilter := Filter;

    Filtered := False;
    Filter := '';

    pgbStatus.Properties.Max := RecordCount;
    pgbStatus.Position := 0;
    Application.ProcessMessages;

    First;
    While Not Eof Do
    Begin
      intRecNo := cdsConsulta.Recno;
      Edit;

      For intContador := 1 To 7 Do
      Begin
        If FRecarregaPreco Then
        Begin
          FieldByName('LTP_PREVE' + IntToStr(intContador)).AsFloat := FieldByName('LTP_PREVE' +  IntToStr(intContador) + '_ANT').AsFloat;
          pAlteraPreco(cdsConsulta, intContador, True, False);
        End Else
        Begin
          If FRecarregaMargIdeal Then
            FieldByName('LTP_MARBR' + IntToStr(intContador)).AsFloat := FieldByName('LTP_MARID' +  IntToStr(intContador)).AsFloat
          Else
            FieldByName('LTP_MARBR' + IntToStr(intContador)).AsFloat := FieldByName('LTP_MARBR' +  IntToStr(intContador) + '_ANT').AsFloat;
          pAlteraPreco(cdsConsulta, intContador, False, True);
        End;
      End;

      pAjustaPrecos(cdsConsulta, strTabPrc);

      For intContador := 1 To 7 Do
      Begin
        If FieldByName('LTP_PREVE' + IntToStr(intContador) + '_ANT').AsFloat <> 0 Then
          FieldByName('DIFPR' + IntToStr(intContador)).AsFloat :=
            ((FieldByName('LTP_PREVE' + IntToStr(intContador)).AsFloat - FieldByName('LTP_PREVE' + IntToStr(intContador) + '_ANT').AsFloat) /
                                                 FieldByName('LTP_PREVE' + IntToStr(intContador) + '_ANT').AsFloat) * 100;

        FieldByName('DIFMA' + IntToStr(intContador)).AsFloat := FieldByName('LTP_MARBR' + IntToStr(intContador)).AsFloat -
                                                                FieldByName('LTP_MARBR' + IntToStr(intContador)+ '_ANT').AsFloat;
      End;

      Post;
      cdsConsulta.Recno :=  intRecNo;
      Next;

      pgbStatus.Position := pgbStatus.Position + 1;
      Application.ProcessMessages;
    End;

    AfterScroll := pAfterScroll;
    BeforePost  := pBeforePost;
    If Assigned(pAfterScroll) Then
      pAfterScroll(cdsConsulta);

    Filter := strFilter;
    Filtered := blnFiltered;
    pAtualizaCdsPrecos(cdsConsulta);

    pSetCDSGrids;
  End;

  Result := True;

  {Restaura a ordenação}
  cdsConsulta.IndexFieldNames := strIndiceSalvo;

  cdsConsulta.EnableControls;

End;

function TLotePrecos.fApagaReservaEnderecamento(DataSet: TDataSet): boolean;
var
  lQryComand,
  lQryComandExe: TUniQuery;
  lCodEmp, lCodIte, lAutIncFatDor, lAutIncFatgor: String;
begin
  Result := True;

  lQryComand := fCriaQuery;
  lQryComandExe := fCriaQuery;
  Try
    Try
      lQryComand.SQL.Clear;

      lQryComand.SQL.Add('SELECT ');
      lQryComand.SQL.Add('  FATDOR.AUTOINCREM AS INCDOR, ');
      lQryComand.SQL.Add('  FATGOR.AUTOINCREM AS INCGOR, ');
      lQryComand.SQL.Add('  FATDOR.FDO_CODITE AS CODITE, ');
      lQryComand.SQL.Add('  FGO_CODEMP AS CODEMP ');
      lQryComand.SQL.Add(' FROM FATGOR ');
      lQryComand.SQL.Add(' INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ');
      lQryComand.SQL.Add(' INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ');
      lQryComand.SQL.Add(' WHERE FDO_SEQPRE = ' + QuotedStr(DataSet.FieldByName('AUTOINCREM').AsString));
      lQryComand.Open;

      If lQryComand.IsEmpty Then
        Exit;

      lQryComand.First;
      While Not lQryComand.Eof Do
      Begin
        lAutIncFatgor  := lQryComand.FieldByName('INCGOR').AsString;
        lAutIncFatDor  := lQryComand.FieldByName('INCDOR').AsString;
        lCodEmp := lQryComand.FieldByName('CODEMP').AsString;
        lCodIte := lQryComand.FieldByName('CODITE').AsString;

        lQryComandExe.Close;
        lQryComandExe.sql.Clear;
        lQryComandExe.sql.Add('DELETE FROM FATDOR WHERE AUTOINCREM = ' + QuotedStr(lAutIncFatDor) + ';');
        lQryComandExe.sql.Add('DELETE FROM FATGOR');
        lQryComandExe.sql.Add(' WHERE FATGOR.AUTOINCREM =  "'+lAutIncFatgor+'"');
        lQryComandExe.sql.Add('   AND (SELECT COUNT(1) FROM FATDOR WHERE FDO_SEQGER = "' + lAutIncFatgor + '") = 0;');
        lQryComandExe.sql.Add('  /*AutIncLotPre = ' +  QuotedStr(DataSet.FieldByName('AUTOINCREM').AsString) + ' */');
        lQryComandExe.ExecSQL;

        lQryComandExe.Close;
        lQryComandExe.SQL.Clear;
        lQryComandExe.SQL.Add('UPDATE ITEGER SET ITE_REPAUD = "S" WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
        lQryComandExe.ParamByName('CODEMP').AsString := lCodEmp;
        lQryComandExe.ParamByName('CODITE').AsString := lCodIte;
        lQryComandExe.ExecSQL;

        lQryComand.Next;
      End;
    Except On
      E:Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TLotePrecos.fApagaReservaEnderecamento]');
      End;
    End;
  Finally
    FreeAndNil(lQryComand);
    FreeAndNil(lQryComandExe);
  End;
end;

end.


