unit untTEnderecamentoMarmoreGranito;


interface

uses Forms, untGravando, System.Classes, SysUtils, StrUtils, untTypesSistema, Uni, untTLock, untZClient,
     Data.DB, winapi.messages, Windows, untFuncoesEtiquetas, cxProgressBar, untTransferenciaArmazens,
     vcl.ComCtrls, UniClientDataSet, DateUtils, Variants, dxCore, untAuditoriaGravacaoSaldo, untConstantes;

type
  TRecMedida = Record
    fltLargura: Double;
    fltAltura: Double;
    function fPreenchido: Boolean;
    function fArea: Double;
  end;
  TMedidaRec = TRecMedida;

  TRecChapa = Record
    strAutInc: String;
    strCodIte: String;
    strSeqDet: String;
    intChapa: Integer;
    strLote: String;
    strLoteBase: String;
    strComplemento: String;
    fltPreco_M2: Double;
    fltPreco_Entrega_M2: Double;
    fltEstPer: Double;
    recMedidaBruta: TMedidaRec;
    recMedidaLiquida: TMedidaRec;
    fltEspessura: Double;
    fltValorTotalM2: Double;
    fltValorTotalEntregaM2: Double;
    fltQtdM2Liquido: Double;
    fltQtdPerda: Double;
    procedure Inicializar;
    function fTodosCamposPreenchidos: Boolean;
  end;

  TChapaRec =  TRecChapa;

  TControleEstoqueChapa =  (cecUmaChapaPorLote, cecVariasChapasPorLote);

  TDividirChapa = class
    private
      FstrNumLotPadrao: String;
      FQtdChapa: Double;
      FqtdItem: Double;
      FStrCodIte: String;
      FStrCodEmp: String;
      FStrLoteSemComplemento: String;
      FstrLoteBase: String;
      FstrComplemento: String;
      FintNChapa: Integer;


      procedure pSetaVariaveisControleIncial;
      function fGetSQLLoteOriginal: String;
      function fGetSqlChapas(blnVariasChapasPorLote: Boolean): String;

    public
      class procedure pIniciaProcessoDivisaoDeChapa(AstrNumLotPadrao: String; AQtdChapa, AQtdItem: Double; AStrCodIte: String; AStrCodEmp: String; AProgress: TProgressBar);
      property GetqtdChapa: Double read  FQtdChapa;

  end;

  TEnderecamentoMarmoreGranito = class
  private
    frmGravando: TfrmGravando;
    objLock: TLock;
    FSeqFgo: String;
    strNom_FC: String;
    FDocume: TEndDocumento;
    strTrava: String;
    intDeqTem: Integer;
    FOwner : TForm;
    strChaveLoteTemporario: String;
    qryConsulta: TUniQuery;
    qryComand: TUniQuery;
    pgbStatusCtrl: TcxProgressBar;
    qryConIte: TUniQuery;
    recServicos : TDadosServicos;
    blnRecuperando: Boolean;
    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    function fGetChaveDocumento(strNumDoc, strCodEmp, strCliFor: String): String;
    procedure pLimpar;
    procedure pSetAutIncPed(const Value: String);
    procedure pSetStrEnderecamento(const Value: String);
    procedure pCarregarAutoIncremPedido;
    function fGetMovGerAutoinc(strCodEmp, strNumDoc, strEspDoc, strSerie, strCodCli, strTip_FC: string): String;

    function fProcessaCarregaEnderecamento: Boolean;
    function fPodeAbrirDefinicoesDeChapa: Boolean;

    function fAbreConsulta: Boolean;
    function fGetSqlItensPedido: String;
    function fGetSqlChapas: String;
    function fGetStrEnderecamento: String;
    procedure onAfterPost(DataSet: TDataSet);
    procedure pAtualizaLoteChapas;

    procedure pValidarAlteracaoItemComChapa;
    procedure OnAfterOpenDados(DataSet: TDataSet);

    procedure onBeforePostChapa(DataSet: TDataSet);
    procedure onValidateDadosCamposChapa(Sender: TField);
    procedure pCalculaPerda;
    procedure pAbreDefinicoesDeChapas;
    procedure pSetFilterSeqDet(strSeqDet: String);


    procedure pNormalizaChapas;
    function fCalculaMediaLiquidaLargura:Boolean;
    function fCalculaMediaLiquidaAltura:Boolean;
    function fCalculaPerda:Boolean;
    function fValidaMargemBrutaDivisaoChapa(AFltMargemBrutaAltura, AFltMargemBrutalargura: Double; fltQtdChapas:Double):Boolean;


    function fRetValField(strField: String): Double;
    function fRetMedidaMetroLiquido: Double;
    function fRetValorTotal: Double;
    function fRetValorTotalEntrega: Double;


    procedure pInsereChapas(intValIni: integer = 1);
    procedure pRemoveLotmar;
    function fPodeAlterarMedida(fltValField, ftlValDef: Double): Boolean;

    procedure pInsereDadosChapa;
    procedure pInjetaInsertLotmar;
    procedure pDeletaReserva;
    procedure pMontaInsertLote;
    function fGetSqlIteGer: String;


    procedure pGeraTransferencia;


    function fConfirmaEnderecamentoAux(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pGeraAjuste;
    function fGetLoteCorreto: String;

    function fTodosOsItensStatusOk: Boolean;
    function fValidaDefinicoesChapa: Boolean;


    procedure pGeraLotes;
    procedure pAtualizaDadosLotePaiDaDivisao;

    procedure pMarcaRoboRecalculoSaldo;
    function fGravaMovGer_Aux(var strAutInc: String; fltCalculaTotGer: Double; strNumDocAJ, strCodCli, strCliEst: String): Boolean;
    function fGravaMovDet_Aux(strNumDocAJ, strAutInc, strCodCli, strCliEst: String): Boolean;
    procedure pReplicaMedidas(fltMEDIDA_BRUTA_LARGURA,
                              fltMEDIDA_BRUTA_ALTURA,
                              fltMEDIDA_LIQUIDA_LARGURA,
                              fltMEDIDA_LIQUIDA_ALTURA,
                              fltESPESSURA,
                              fltPRECO_M2,
                              fltPRECO_ENTREGA_M2: Double);
    function fGetProximoNomeLoteDisponivel: string;
    procedure pAtualizaNumeroDaChapaSeNecessario;


    function fLocalizaProximoLote(qrySQL: TUniQuery): string;

    function fGetNomeLote: String;
    procedure pAtualizaComplementoLinhaPrincipal;
    procedure pRedefineNChapa;
    procedure pPreencherChapa(recChapa: TChapaRec);
    function fRemoverComplementoTextoLote(strLote: String; strComplemento: String): String;



  protected
    objDivideChapa : TDividirChapa;
    fltMarBruAltura : Double;
    fltMarBruLargur : Double;

    procedure pIniciaDadosDivisaoChapa;
    function fGetSQLTransferencia: String;
  public
    cdsDados: TZClient;
    cdsChapas: TZClient;
    strDocumentoSelecionado: String;
    progress: TProgressBar;
    controleEstoqueChapa: TControleEstoqueChapa;
    sizeFieldNumLot: Integer;
    blnDividindoChapa: Boolean;

    function fCarregaEnderecamento: Boolean;
    constructor Create(AOwner: TForm);
    destructor Destroy; override;
    function fInsereLotesNaTemporaria: Boolean;
    function fLoteJaCadastrado: Boolean;
    procedure pImprimeEtiquetas(strFiltroForcado: String);
    procedure pReinicia;
    procedure pAbrirDefinicoesDasChapas;
    function fAbrirDefinicoesDasChapasParaDivisao: Boolean;

    function  fTemQtdChapasDefinidas: Boolean;
    Function  fRegistroGravadoLotMar(strIteDoc: String = ''): Boolean;
    procedure pImprimirItem;
    procedure pInsereChapa(qtdChapa: integer);
    procedure pCarregaChapasLotMar;
    procedure pRecalculaNomeLote;
    procedure pDelete;
    procedure pReplicarMedidas;

    function fGravaRegistroChapa: Boolean;
    function fRetNumerosDoLote: String;
    property strAutIncPed: String read FSeqFgo write pSetAutIncPed;
    property strDocumento: String read fGetStrEnderecamento write pSetStrEnderecamento;
    function fConfirmaEnderecamento: Boolean;
    function fRedefineTextoDoLote: Boolean;
    function fVariasChapasPorLote: Boolean;
    procedure pRestaurarChapas;



  end;


  const WM_GO_TO_COLLUMN_LOTE = WM_APP + 500;

implementation

uses
  untConsultas, untFuncoesSimples, untEnderecamentoMarmoreGranitoChapas, TypesRel,
  untCadIte, untMovGer, untMarmoreTrocaNumeroDoLote, Math;

{ TEnderecamentoMarmoreGranito }

function TEnderecamentoMarmoreGranito.fCalculaMediaLiquidaAltura:Boolean;
begin
  Result := False;
    If cdsChapas.FieldByName('MEDIDA_BRUTA_ALTURA').AsFloat > 0 Then
      If cdsChapas.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat = 0 Then
        Result := True;
End;

function TEnderecamentoMarmoreGranito.fCalculaPerda:Boolean;
Begin
  Result := False;
     If fValidaMargemBrutaDivisaoChapa(cdsChapas.FieldByName('MEDIDA_BRUTA_ALTURA').AsFloat, cdsChapas.FieldByName('MEDIDA_BRUTA_LARGURA').AsFloat, cdsChapas.FieldByName('CHAPA').AsFloat) Then
      If cdsChapas.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat > 0 Then
        If cdsChapas.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat > 0 Then
          Result := True;

End;

function TEnderecamentoMarmoreGranito.fValidaMargemBrutaDivisaoChapa(AFltMargemBrutaAltura, AFltMargemBrutalargura: Double; fltQtdChapas:Double):Boolean;
var MargemBrutaAltura, MargemBrutalargura: Double;
begin
  MargemBrutaAltura := AFltMargemBrutaAltura;
  MargemBrutalargura := AFltMargemBrutalargura;
  If controleEstoqueChapa = cecVariasChapasPorLote Then
  Begin
    If blnDividindoChapa then
    Begin
      If Assigned(objDivideChapa) Then
      Begin
        If MargemBrutaAltura <> fltMarBruAltura Then
          MargemBrutaAltura := MargemBrutaAltura * fltQtdChapas;
        If MargemBrutalargura <> fltMarBruLargur Then
          MargemBrutalargura := MargemBrutalargura * fltQtdChapas;
      End;
    End;
  End;

  Result := False;
  If Not blnDividindoChapa Then
    Exit(True);
  If RoundTo(MargemBrutaAltura, -intDeqTem) <> RoundTo(fltMarBruAltura, -intDeqTem) Then
    Exit(True);
  If RoundTo(MargemBrutalargura, -intDeqTem) <> RoundTo(fltMarBruLargur, -intDeqTem) Then
    Exit(True);
End;

function TEnderecamentoMarmoreGranito.fVariasChapasPorLote: Boolean;
begin
  Result := controleEstoqueChapa = cecVariasChapasPorLote;
end;

procedure TEnderecamentoMarmoreGranito.OnAfterOpenDados(DataSet: TDataSet);
begin
  if Assigned(DataSet.FindField('QTDCHAPA')) Then
    DataSet.FieldByName('QTDCHAPA').OnValidate := onValidateDadosCamposChapa;

  if Assigned(DataSet.FindField('LOT_NUMLOT')) Then
    DataSet.FieldByName('LOT_NUMLOT').OnValidate := onValidateDadosCamposChapa;

  if Assigned(DataSet.FindField('ESTPER')) Then
    DataSet.FieldByName('ESTPER').OnValidate := onValidateDadosCamposChapa;
end;

function TEnderecamentoMarmoreGranito.fCalculaMediaLiquidaLargura:Boolean;
begin
  Result := False;
    If cdsChapas.FieldByName('MEDIDA_BRUTA_LARGURA').AsFloat > 0 Then
      If cdsChapas.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat = 0 Then
        Result := True;
End;

procedure TEnderecamentoMarmoreGranito.pCalculaPerda;
var fltQuantidadeBruta, fltQuantidadeLiquida: Double;
  fltQtdChapas: Double;
begin
  If controleEstoqueChapa = cecVariasChapasPorLote Then
    fltQtdChapas := cdsChapas.FieldByName('CHAPA').AsFloat
  else
    fltQtdChapas := 1;

 If fCalculaPerda Then
 Begin
   fltQuantidadeBruta   := cdsChapas.FieldByName('MEDIDA_BRUTA_LARGURA').AsFloat * cdsChapas.FieldByName('MEDIDA_BRUTA_ALTURA').AsFloat;
   fltQuantidadeLiquida := cdsChapas.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat * cdsChapas.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat;
   cdsChapas.FieldByName('PERDA').AsFloat  := (fltQuantidadeBruta - fltQuantidadeLiquida) * fltQtdChapas;
 End
 Else If blnDividindoChapa Then
   cdsChapas.FieldByName('PERDA').AsFloat  := 0;
end;

constructor TEnderecamentoMarmoreGranito.Create(AOwner: TForm);
begin
  blnRecuperando := False;
  sizeFieldNumLot:= 30;
  blnDividindoChapa := False;
  FOwner := AOwner;
  objLock   := TLock.Create;
  qryComand := fCriaQuery;
  qryConsulta := fCriaQuery;
  qryConIte := fCriaQuery;
  cdsDados := TZClient.Create(nil);
  cdsChapas := TZClient.Create(nil);
  cdsDados.AfterPost := onAfterPost;
  cdsDados.AfterOpen := OnAfterOpenDados;
  If fCfgSis('CTRLCH', varString) = '1' Then
   controleEstoqueChapa := cecUmaChapaPorLote
  Else
   controleEstoqueChapa := cecVariasChapasPorLote;
  fltMarBruAltura := -1;
  fltMarBruLargur := -1;
  intDeqTem := fCfgSis('DEQTEM', varInteger);

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;
end;

destructor TEnderecamentoMarmoreGranito.Destroy;
begin
  FreeAndNil(qryConsulta);
  FreeAndNil(qryComand);
  objLock.pDestravarTodos;
  FreeAndNil(objLock);
  FreeAndNil(cdsDados);
  FreeAndNil(cdsChapas);
  FreeAndNil(qryConIte);
end;

procedure TEnderecamentoMarmoreGranito.pRemoveLotmar;
begin
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('DELETE FROM LOTMAR WHERE LOT_IDENTI = :CHAVE OR LOT_CODDOC = :CHAVE');
  qryConsulta.ParamByName('CHAVE').AsString := IIF(fEmptyStr(strAutIncPed),strChaveLoteTemporario, strAutIncPed);
  qryConsulta.ExecSQL;
End;

function TEnderecamentoMarmoreGranito.fPodeAlterarMedida(fltValField, ftlValDef: Double): Boolean;
Begin
  Result := False;
  If fltValField = 0 then
    If ftlValDef > 0 Then
       Result := True;
End;


procedure TEnderecamentoMarmoreGranito.pReplicaMedidas(fltMEDIDA_BRUTA_LARGURA,
                                                       fltMEDIDA_BRUTA_ALTURA,
                                                       fltMEDIDA_LIQUIDA_LARGURA,
                                                       fltMEDIDA_LIQUIDA_ALTURA,
                                                       fltESPESSURA,
                                                       fltPRECO_M2,
                                                       fltPRECO_ENTREGA_M2: Double);
Begin
  cdsChapas.Edit;
  If fPodeAlterarMedida(cdsChapas.FieldByName('MEDIDA_BRUTA_LARGURA').AsFloat, fltMEDIDA_BRUTA_LARGURA) Then
     cdsChapas.FieldByName('MEDIDA_BRUTA_LARGURA').AsFloat := fltMEDIDA_BRUTA_LARGURA;

  If fPodeAlterarMedida(cdsChapas.FieldByName('MEDIDA_BRUTA_ALTURA').AsFloat, fltMEDIDA_BRUTA_ALTURA) Then
     cdsChapas.FieldByName('MEDIDA_BRUTA_ALTURA').AsFloat := fltMEDIDA_BRUTA_ALTURA;

  If fPodeAlterarMedida(cdsChapas.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat, fltMEDIDA_LIQUIDA_LARGURA) Then
     cdsChapas.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat := fltMEDIDA_LIQUIDA_LARGURA;

  If fPodeAlterarMedida(cdsChapas.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat, fltMEDIDA_LIQUIDA_ALTURA) Then
     cdsChapas.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat := fltMEDIDA_LIQUIDA_ALTURA;

  If fPodeAlterarMedida(cdsChapas.FieldByName('ESPESSURA').AsFloat, fltESPESSURA)  Then
     cdsChapas.FieldByName('ESPESSURA').AsFloat := fltESPESSURA;

  cdsChapas.FieldByName('PRECO_M2').AsFloat := fltPRECO_M2;
  cdsChapas.FieldByName('PRECO_ENTREGA_M2').AsFloat := fltPRECO_ENTREGA_M2;
  cdsChapas.Post;
End;



procedure TEnderecamentoMarmoreGranito.pReplicarMedidas;
var fltMEDIDA_BRUTA_LARGURA,
    fltMEDIDA_BRUTA_ALTURA,
    fltMEDIDA_LIQUIDA_LARGURA,
    fltMEDIDA_LIQUIDA_ALTURA,
    fltESPESSURA: Double;
    fltPRECO_M2: Double;
    fltPRECO_ENTREGA_M2: Double;

begin
  If fPergunta('Deseja copiar a medida da chapa selecionada para todas as outras chapas que ainda não tem medidas informadas?') then
  Begin
     fltMEDIDA_BRUTA_LARGURA := cdsChapas.FieldByName('MEDIDA_BRUTA_LARGURA').AsFloat;
     fltMEDIDA_BRUTA_ALTURA := cdsChapas.FieldByName('MEDIDA_BRUTA_ALTURA').AsFloat;
     fltMEDIDA_LIQUIDA_LARGURA := cdsChapas.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat;
     fltMEDIDA_LIQUIDA_ALTURA := cdsChapas.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat;
     fltESPESSURA := cdsChapas.FieldByName('ESPESSURA').AsFloat;
     fltPRECO_M2 := cdsChapas.FieldByName('PRECO_M2').AsFloat;
     fltPRECO_ENTREGA_M2 := cdsChapas.FieldByName('PRECO_ENTREGA_M2').AsFloat;
     cdsChapas.First;
     While not cdsChapas.Eof Do
     Begin
       pReplicaMedidas(fltMEDIDA_BRUTA_LARGURA,
                       fltMEDIDA_BRUTA_ALTURA,
                       fltMEDIDA_LIQUIDA_LARGURA,
                       fltMEDIDA_LIQUIDA_ALTURA,
                       fltESPESSURA,
                       fltPRECO_M2,
                       fltPRECO_ENTREGA_M2);

       cdsChapas.Next;
     End;
  End;
end;

procedure TEnderecamentoMarmoreGranito.pRestaurarChapas;
  Var
    arrRecChapa: Array of TChapaRec;
    fltQuantidade: Double;
    intTotalChapas: Integer;
    fltTotalAcumulado: Double;
    fltTotalPerda: Double;
    blnQtdTotalEnderecamentoValida,
    blnQtdChapasValida, blnCamposPreenchidos: Boolean;
    blnPermiteVariasChapasLote: Boolean;
    i: Integer;
    strIteDoc: String;
begin
  blnPermiteVariasChapasLote := controleEstoqueChapa = cecVariasChapasPorLote;

  cdsDados.First;
  While Not cdsDados.Eof do
  begin
    pSetFilterSeqDet(cdsDados.FieldByName('SEQDET').AsString);
    strIteDoc := cdsDados.FieldByName('AUTOINCREM').AsString;

    fRegistroGravadoLotMar(strIteDoc);

    if QryConsulta.isEmpty then
      Exit;
    blnCamposPreenchidos := False;
    fltTotalAcumulado := 0.0;
    fltTotalPerda := 0.0;
    intTotalChapas := 0;
    fltQuantidade := cdsDados.FieldByName('FDO_QTDITE').AsFloat;
    qryConsulta.First;

    Setlength(arrRecChapa,0);

    While Not qryConsulta.Eof do
    begin
      setlength(arrRecChapa,length(arrRecChapa)+1);
      arrRecChapa[High(arrRecChapa)].strAutInc                    := strIteDoc;
      arrRecChapa[High(arrRecChapa)].strSeqDet                    := cdsDados.FieldByName('SEQDET').AsString;
      arrRecChapa[High(arrRecChapa)].intChapa                     := QryConsulta.FieldByName('LOT_NCHAPA').AsInteger;
      arrRecChapa[High(arrRecChapa)].strLote                      := QryConsulta.FieldByName('LOT_NUMLOT').AsString;
      arrRecChapa[High(arrRecChapa)].strLoteBase                  := QryConsulta.FieldByName('LOT_LOTBAS').AsString;
      arrRecChapa[High(arrRecChapa)].fltPreco_M2                  := QryConsulta.FieldByName('LOT_PRVMAP').AsFloat;
      arrRecChapa[High(arrRecChapa)].fltPreco_Entrega_M2          := QryConsulta.FieldByName('LOT_PRVENP').AsFloat;
      arrRecChapa[High(arrRecChapa)].strCodIte                    := QryConsulta.FieldByName('LOT_CODITE').AsString;
      arrRecChapa[High(arrRecChapa)].fltEstPer                    := QryConsulta.FieldByName('LOT_ESTPER').AsFloat;
      arrRecChapa[High(arrRecChapa)].recMedidaBruta.fltLargura    := QryConsulta.FieldByName('LOT_MEDB_L').AsFloat;
      arrRecChapa[High(arrRecChapa)].recMedidaBruta.fltAltura     := QryConsulta.FieldByName('LOT_MEDB_A').AsFloat;
      arrRecChapa[High(arrRecChapa)].recMedidaLiquida.fltLargura  := QryConsulta.FieldByName('LOT_MEDL_L').AsFloat;
      arrRecChapa[High(arrRecChapa)].recMedidaLiquida.fltAltura   := QryConsulta.FieldByName('LOT_MEDL_A').AsFloat;
      arrRecChapa[High(arrRecChapa)].fltValorTotalEntregaM2       := QryConsulta.FieldByName('LOT_PRVENT').AsFloat;
      arrRecChapa[High(arrRecChapa)].fltValorTotalM2              := QryConsulta.FieldByName('LOT_PRVMAT').AsFloat;
      arrRecChapa[High(arrRecChapa)].fltEspessura                 := QryConsulta.FieldByName('LOT_ESPESS').AsFloat;
      arrRecChapa[High(arrRecChapa)].strComplemento               := QryConsulta.FieldByName('LOT_COMPLE').AsString;
      arrRecChapa[High(arrRecChapa)].fltQtdPerda                  := qryConsulta.FieldByName('LOT_PERDAS').AsFloat;

      arrRecChapa[High(arrRecChapa)].strLote :=
        fRemoverComplementoTextoLote(arrRecChapa[High(arrRecChapa)].strLote, arrRecChapa[High(arrRecChapa)].strComplemento);


      blnCamposPreenchidos := arrRecChapa[High(arrRecChapa)].fTodosCamposPreenchidos;

      if blnCamposPreenchidos then
      begin

        If blnPermiteVariasChapasLote Then
        begin
          fltTotalAcumulado := fltTotalAcumulado +
            (arrRecChapa[High(arrRecChapa)].recMedidaLiquida.fArea * arrRecChapa[High(arrRecChapa)].intChapa);
          intTotalChapas := intTotalChapas + arrRecChapa[High(arrRecChapa)].intChapa;
        end
        else
        begin
          intTotalChapas := intTotalChapas + 1;
          fltTotalAcumulado := fltTotalAcumulado + arrRecChapa[High(arrRecChapa)].recMedidaLiquida.fArea;
        end;

        fltTotalPerda := fltTotalPerda + arrRecChapa[High(arrRecChapa)].fltQtdPerda;
      end
      else
        break;

      qryConsulta.Next;
    end;

    blnQtdTotalEnderecamentoValida := (RoundTo((fltTotalAcumulado + fltTotalPerda), - intDeqTem) = RoundTo(fltQuantidade, - intDeqTem));

    blnQtdChapasValida := intTotalChapas = cdsDados.FieldByName('QTDCHAPA').Asinteger;

    if blnCamposPreenchidos and blnQtdTotalEnderecamentoValida and blnQtdChapasValida then
    begin
      for i := Low(arrRecChapa) to High(arrRecChapa) do
      begin
        cdsChapas.Insert;
        pPreencherChapa(arrRecChapa[i]);
        cdsChapas.Post;
      end;

      cdsDados.edit;
      cdsDados.FieldByName('STATUS').AsString := '1';
      cdsdados.Post;
    end;
    cdsDados.Next;
  end;

end;

function TEnderecamentoMarmoreGranito.fGetStrEnderecamento: String;
begin
  Result := '';

  Result := Result + fPadL(FDocume.strNumDoc , fTamNumDoc);
  Result := Result + fPadR(FDocume.strEspDoc , 02);
  Result := Result + fPadR(FDocume.strSerie_ , 03);
  Result := Result + fPadR(FDocume.strCodEmp , 03);
  Result := Result + fPadR(FDocume.strCliFor , 08);
  Result := Result + fPadR(FDocume.strTip_FC , 01);
end;

function TEnderecamentoMarmoreGranito.fGravaRegistroChapa: Boolean;
begin
  Result := true;
  Try
    qryConsulta.SQL.Clear;
    fInsereLotesNaTemporaria;
//    pInjetaInsertLotmar;
//    pInsereDadosChapa;
//    qryConsulta.ExecSQL;
  Except
    on e: Exception do
    Begin
      Result := False;
      pMensagensErro(e.message, '[TEnderecamentoMarmoreGranito.fGravaRegistroChapa]');
    End;
  End;
end;

function TEnderecamentoMarmoreGranito.fGetSqlChapas: String;
begin

  Result := '';
  Result := Result + 'SELECT DISTINCT ';
  Result := Result + '  D.DET_SEQGER AS SEQGER, ';
  Result := Result + '  D.AUTOINCREM AS SEQDET, ';
  Result := Result + '  0 AS CHAPA,';
  Result := Result + '  0.00 AS MEDIDA_BRUTA_LARGURA,';
  Result := Result + '  0.00 AS MEDIDA_BRUTA_ALTURA,';
  Result := Result + '  0.00 AS MEDIDA_LIQUIDA_LARGURA,';
  Result := Result + '  0.00 AS MEDIDA_LIQUIDA_ALTURA,';
  Result := Result + '  0.00 AS ESPESSURA,';
  Result := Result + '  0.00 AS PRECO_M2,';
  Result := Result + '  0.00 AS QTD_M2_LIQUIDO,';
  Result := Result + '  0.00 AS VALOR_TOTAL_M2,';
  Result := Result + '    CAST("N" AS CHAR(1)) AS LOTE_DIVIDO, ';

  Result := Result + '  0.00 AS PERDA, ';
  Result := Result + '  0 AS ETIQUETA,';
  Result := Result + '  CAST("" AS CHAR(50)) AS LOTE, ';
  Result := Result + '  FDO_NUMLOT AS LOTE_BASE, ';
  Result := Result + '  CAST("" AS CHAR(20)) AS COMPLEMENTO, ';

  Result := Result + '  C.ITE_CODITE AS CODITE, ';
  Result := Result + '  0.00 AS ESTPER, ';
  Result := Result + '  FATDOR.AUTOINCREM, ';
  Result := Result + '  0.00 AS PRECO_ENTREGA_M2,';
  Result := Result + '  0.00 AS VALOR_TOTAL_ENTREGA_M2 ';
  Result := Result + ' FROM                ';
  Result := Result + '  FATDOR            ';
  Result := Result + '  INNER JOIN EXTDOR   ON FATDOR.AUTOINCREM = FDO_SEQFDO ';
  Result := Result + '  INNER JOIN FATGOR   ON FATGOR.AUTOINCREM = FDO_SEQGER ';
  Result := Result + '  LEFT  JOIN EXTGOR   ON FGO_SEQFGO = FATGOR.AUTOINCREM ';

  Result := Result + '  LEFT JOIN MOVGER G  ON G.GER_NUMDOC =  TRIM(MID(FGO_DOCEND, 01, 12)) ';
  Result := Result + '                     AND G.GER_ESPDOC =  MID(FGO_DOCEND, 13, 2) ';
  Result := Result + '                     AND G.GER_SERIE_ =  TRIM(MID(FGO_DOCEND, 15, 3)) ';
  Result := Result + '                     AND G.GER_CODEMP =  MID(FGO_DOCEND, 18, 3) ';
  Result := Result + '                     AND IFNULL(G.GER_CODFOR, "") =  MID(FGO_DOCEND, 21, 8) ';


  Result := Result + '  INNER JOIN CADITE C ON C.ITE_CODITE = FDO_CODITE ';
  Result := Result + '  INNER JOIN ITEGER I ON I.ITE_CODITE = FDO_CODITE AND I.ITE_CODEMP = FDO_CODEMP ';
  Result := Result + '  INNER JOIN CADUNI   ON   FDO_UNIDAD = UNI_CODUNI ';

  Result := Result + '  LEFT JOIN MOVDET  D ON D.AUTOINCREM = FDO_AUTDET ';       // ENCONTRA A NOTA DE ENTRADA QUE RESERVOU O PEDIDO
  Result := Result + '  LEFT JOIN CADLOT CL ON CL.LOT_NUMLOT = FDO_NUMLOT AND CL.LOT_CODEMP = FDO_CODEMP AND CL.LOT_CODITE = FDO_CODITE ';

  Result := Result + 'WHERE  FALSE             ';



End;

function TEnderecamentoMarmoreGranito.fGetSqlItensPedido: String;
begin
  Result := '';
  Result := Result + 'SELECT DISTINCT ';
  Result := Result + '  D.DET_SEQGER AS SEQGER, ';
  Result := Result + '  D.AUTOINCREM AS SEQDET, ';
  Result := Result + '  D.DET_CODFOR,     ';
  Result := Result + '  FDO_NUMDOC,       ';
  Result := Result + '  FDO_ESPDOC,       ';
  Result := Result + '  FDO_CODEMP,       ';
  Result := Result + '  FDO_CODITE,       ';
  Result := Result + '  FDO_NUMLOT,       ';
  Result := Result + '  FDO_DESCRI,       ';
  Result := Result + '  FDO_REFERE,       ';
  Result := Result + '  UNI_SIGUNI,       ';
  Result := Result + '  FDO_QTDITE,       ';
  Result := Result + '  I.ITE_SALDOS,     ';
  Result := Result + '  C.ITE_CODBAR,     ';
  Result := Result + '  C.ITE_CODFAB,     ';
  Result := Result + '  C.ITE_DESITE,     ';
  Result := Result + '  I.ITE_LOCFIS,     ';
  Result := Result + '  I.ITE_LOCSUP,     ';
  Result := Result + '  I.ITE_USASER,     ';

  Result := Result + '  I.ITE_LOCFIS AS LOCTST, ';
  Result := Result + '  I.ITE_LOCSUP AS SUPTST, ';

  Result := Result + '  I.ITE_LOCFIS AS LOCANT, ';
  Result := Result + '  I.ITE_LOCSUP AS SUPANT, ';
  Result := Result + '  I.ITE_PREVE' + fCfgSis('TABPMA')+ ' AS PRESUG, ';


  Result := Result + '  I.ITE_TAMLCF,     ';
  Result := Result + '  I.ITE_TAMLCS,     ';
  Result := Result + '  C.ITE_NVLGIR,     ';
  Result := Result + '  0 AS DEFSER,      ';
  Result := Result + '  IFNULL(M.LOT_NCHAPA, 0) AS QTDCHAPA,    ';
  Result := Result + '  IFNULL(M.LOT_NCHAPA, 0) AS QTDCHAPA_ORI, ';
  Result := Result + '  IFNULL(M.LOT_ESTPER, 0.00) AS ESTPER,     ';
  Result := Result + '  IFNULL(M.LOT_ESTPER, 0.00) AS ESTPER_ORI, ';
  Result  := Result + ' IFNULL(LOT_LOTBAS,"") AS LOT_NUMLOT, ';
  Result := Result + '  "0" AS DISTRI, ';                // SE FOI DISTRIBUIDO ENTRE VARIOS ARMAZENS
  Result := Result + '  (IFNULL(FDO_QTDITE, 0) + IFNULL(CL.LOT_SALDOS, 0) + IFNULL(CL.LOT_QTEF_A, 0) + IFNULL(CL.LOT_QTEF_F, 0) + IFNULL(CL.LOT_QTEF_P, 0)) AS LOT_SALDOS, ';

  Result := Result + ' IF((SELECT COUNT(*) FROM CADLOT ';
  Result := Result + '     WHERE ';
  Result := Result + '       LOT_CODITE = FDO_CODITE AND ';
  Result := Result + '       LOT_CODEMP = FDO_CODEMP AND LOT_STATUS = "S") > 0, "1", "0") AS TEMLOT, ';   // SE O ITEM POSSUI LOTE (ARMAZENS)

  Result := Result + '  "N" AS REMLOC, ';                // SE O ITEM POSSUI LOTE (ARMAZENS)
  Result := Result + '  FDO_REFUGO AS REFUGO, ';
  Result := Result + '  I.ITE_QTEF_A AS QTDEFA, '; //Quantidade de Entrega Futura Aguardando Cliente
  Result := Result + '  I.ITE_QTEF_F AS QTDEFF, '; //Quantidade de entrega Futura Falta produto.
  Result := Result + '  FGO_MEN001 AS MEN001, ';


  Result := Result + '    IF(IFNULL(G.AUTOINCREM, "") <> "", ';
  Result := Result + '        (SELECT COUNT(1) FROM SEQGAR ';
  Result := Result + '          WHERE SEQ_PCMDET IN (SELECT AUTOINCREM FROM PCMDET ';
  Result := Result + '                                WHERE PCD_NUMPED IN (SELECT DET_PEDCOM FROM MOVDET  D ';
  Result := Result + '                                                      WHERE DET_SEQGER =  G.AUTOINCREM))), 0) > 0  AS GARANT, ';


  Result := Result + '  FATDOR.AUTOINCREM, ';
  Result := Result + '  0 STATUS , ';

  If fCfgSis('CTLEST') = '2' Then
    Result := Result + '  (SELECT AMZ_DESCRI FROM CADAMZ WHERE AMZ_CODAMZ = @CODAMZ AND AMZ_CODEMP = I.ITE_CODEMP) AS AMZDES, '
  Else
    Result := Result + '  CONVERT("", CHAR(30)) AS AMZDES, ';

  Result := Result + ' IFNULL((SELECT %s AS LOT_TCHAPAS FROM LOTMAR WHERE LOT_CODDOC = FATGOR.AUTOINCREM),0) AS TOTALCHAPAS, ';

  if fVariasChapasPorLote then
    Result := Format(Result,['SUM(LOT_NCHAPA)'])
  else
    Result := Format(Result,['COUNT(1)']);

  Result := Result + ' IFNULL((SELECT LOT_IDENTI FROM LOTMAR WHERE LOT_CODDOC = FATGOR.AUTOINCREM AND LOT_IDENTI <> "" LIMIT 1),"") as LOT_IDENTI ';

  Result := Result + 'FROM                ';
  Result := Result + '  FATDOR            ';
  Result := Result + '  INNER JOIN EXTDOR   ON FATDOR.AUTOINCREM = FDO_SEQFDO ';
  Result := Result + '  INNER JOIN FATGOR   ON FATGOR.AUTOINCREM = FDO_SEQGER ';
  Result := Result + '  LEFT  JOIN EXTGOR   ON FGO_SEQFGO = FATGOR.AUTOINCREM ';

  Result := Result + '  LEFT JOIN MOVGER G  ON G.GER_NUMDOC =  TRIM(MID(FGO_DOCEND, 01, 12)) ';
  Result := Result + '                     AND G.GER_ESPDOC =  MID(FGO_DOCEND, 13, 2) ';
  Result := Result + '                     AND G.GER_SERIE_ =  TRIM(MID(FGO_DOCEND, 15, 3)) ';
  Result := Result + '                     AND G.GER_CODEMP =  MID(FGO_DOCEND, 18, 3) ';
  Result := Result + '                     AND IFNULL(G.GER_CODFOR, "") =  MID(FGO_DOCEND, 21, 8) ';


  Result := Result + '  INNER JOIN CADITE C ON C.ITE_CODITE = FDO_CODITE ';
  Result := Result + '  INNER JOIN ITEGER I ON I.ITE_CODITE = FDO_CODITE AND I.ITE_CODEMP = FDO_CODEMP ';
  Result := Result + '  INNER JOIN CADUNI   ON   FDO_UNIDAD = UNI_CODUNI ';

  Result := Result + '  LEFT JOIN MOVDET  D ON D.AUTOINCREM = FDO_AUTDET ';       // ENCONTRA A NOTA DE ENTRADA QUE RESERVOU O PEDIDO

  Result := Result + '  LEFT JOIN (SELECT LOT_CODDOC, LOT_ITEDOC, LOT_LOTBAS, LOT_ESTPER, %s AS LOT_NCHAPA ';
  Result := Result + '            FROM LOTMAR GROUP BY LOT_CODDOC, LOT_ITEDOC) M ';
  Result := Result + '  ON M.LOT_CODDOC = FATGOR.AUTOINCREM AND M.LOT_ITEDOC = FATDOR.AUTOINCREM ';

  if fVariasChapasPorLote then
    Result := Format(Result,['SUM(LOT_NCHAPA)'])
  else
    Result := Format(Result,['COUNT(1)']);

  Result := Result + '  LEFT JOIN CADLOT CL ON CL.LOT_NUMLOT = FDO_NUMLOT AND CL.LOT_CODEMP = FDO_CODEMP AND CL.LOT_CODITE = FDO_CODITE ';

  Result := Result + 'WHERE               ';
  Result := Result + '  FATGOR.AUTOINCREM = ' + QuotedStr(FSeqFgo);
  Result := Result + '  AND FDO_QTDITE > 0 ';
end;


function TEnderecamentoMarmoreGranito.fAbreConsulta: Boolean;
begin
  Result := True;
  Try
    cdsDados.qryQuery.SQL.Text := fGetSqlItensPedido;
    cdsDados.fAbreClient(false, '[TEnderecamentoMarmoreGranito.fAbreConsulta]');

    cdsChapas.qryQuery.SQL.Text := fGetSqlChapas;
    cdsChapas.fAbreClient(false, '[TEnderecamentoMarmoreGranito.fAbreConsulta]');

    cdsChapas.IndexFieldNames := 'CHAPA';

  Except
    Result := False;
  End;
end;

function TEnderecamentoMarmoreGranito.fCarregaEnderecamento(): Boolean;
  Var
    qryGenGer: TUniQuery;
    chrKey: Char;
    arrEndProd: TConsultasArray;
begin
  inherited;
  blnRecuperando := False;
  strChaveLoteTemporario := '';
  Try
    qryGenGer := fCriaQuery(nil);

    chrKey := '/';

    If Not fPesqEnderecamentoProduto('frmEnderecamentoMarmoreGranito', nil, qryGenGer, chrKey, arrEndProd, True, True ) then
    begin
      fMensagem('ATENÇÃO!', 'Selecione o documento para conferência!', ['&O k']);
      Result := False;
      objLock.pDestravarTodos;
    end Else
    begin

      strAutIncPed := qryGenGer.FieldByName('AUTOINCREM').AsString;
      Result := fProcessaCarregaEnderecamento;
      If Result then
      begin
        if blnRecuperando Then
          strChaveLoteTemporario := cdsDados.FieldByName('LOT_IDENTI').AsString
        else
          strChaveLoteTemporario := FormatDateTime('ddmmyyyhh:mm:ss', fNow);
      end;

    end;
  Finally
    FreeAndNil(qryGenGer);
  End;

end;

procedure TEnderecamentoMarmoreGranito.pSetAutIncPed(const Value: String);
begin
  strDocumento := fCampoTabela('FGO_DOCEND', 'EXTGOR', ['FGO_SEQFGO'], [Value]);
end;

procedure TEnderecamentoMarmoreGranito.pSetStrEnderecamento(
  const Value: String);
begin
  pEnderecamentoToDocumento(Value, FDocume);

  FDocume.strAutInc := fGetMovGerAutoinc(FDocume.strCodEmp,
                                         FDocume.strNumDoc,
                                         FDocume.strEspDoc,
                                         FDocume.strSerie_,
                                         FDocume.strCliFor,
                                         FDocume.strTip_FC);
  pCarregarAutoIncremPedido;

end;

procedure TEnderecamentoMarmoreGranito.pValidarAlteracaoItemComChapa;
  Var
    blnAlterouLote,
    blnAlterouQtdChapas,
    blnAlterouEspessura: Boolean;
    blnAlterarStatus: boolean;
    fldNumLot, fldQtdChapa, fldEstPer: TField;
begin
  if (cdsDados.State <> dsEdit) or (cdsDados.FieldByName('STATUS').AsString <> '1') then
    Exit;

  fldNumLot := cdsDados.FieldByName('LOT_NUMLOT');
  fldQtdChapa := cdsDados.FieldByName('QTDCHAPA');
  fldEstPer := cdsDados.FieldByName('ESTPER');

  blnAlterouLote := fldNumLot.Value <> fldNumLot.OldValue;
  blnAlterouQtdChapas := fldQtdChapa.Value <> fldQtdChapa.OldValue;
  blnAlterouEspessura := fldEstPer.Value <> fldEstPer.OldValue;

  blnAlterarStatus := blnAlterouLote;
  blnAlterarStatus := (Not blnAlterarStatus) and blnAlterouQtdChapas;
  blnAlterarStatus := (Not blnAlterarStatus) and blnAlterouEspessura;

  if blnAlterarStatus then
    cdsDados.FieldByName('STATUS').AsString := '0';

end;

function TEnderecamentoMarmoreGranito.fGetChaveDocumento(strNumDoc,
  strCodEmp, strCliFor: String): String;
begin
  Result := 'ENDERECAMENTO' + strNumDoc + strCodEmp + strCliFor;
end;

procedure TEnderecamentoMarmoreGranito.pLimpar;
begin
  strDocumentoSelecionado := '';
End;

function TEnderecamentoMarmoreGranito.fProcessaCarregaEnderecamento: Boolean;
begin
  strTrava := fGetChaveDocumento(FDocume.strNumDoc,
                                 FDocume.strCodEmp,
                                 FDocume.strCliFor);

  objLock.pDestravarTodos;

  If Not objLock.fLock_Unlock(strTrava, True, False) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse documento já está sendo endereçado em outra estação: ' + fGetHostLock(strTrava + '%'), ['&Ok']);

    pLimpar;
    strDocumentoSelecionado := '';
    Result := False;
    Exit;
  End;
  Result := fAbreConsulta;
  If Result Then
  Begin
    blnRecuperando := cdsDados.FieldByName('TOTALCHAPAS').AsInteger > 0;

    if blnRecuperando then
      pRestaurarChapas;

    If FDocume.strTip_FC = 'C' Then
      strNom_FC := fRetNomCliente(FDocume.strCliFor)
    Else
      strNom_FC := fRetNomFornecedor(FDocume.strCliFor);

                            // exibe o número da ordem de produção
    strDocumentoSelecionado := IfThen(FDocume.strEspDoc = 'OP',
                                fCampoTabela('GER_ORDPRO',
                                             'MOVGER',
                                             ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'IFNULL(GER_CODFOR, "")' ],
                                             [FDocume.strNumDoc,
                                              FDocume.strEspDoc,
                                              FDocume.strCodEmp,
                                              FDocume.strCliFor]),
                                FDocume.strNumDoc) + '-' +
                                FDocume.strEspDoc + ' ' +
                                FDocume.strSerie_ + ' ' +
                                FDocume.strCodEmp + ' ' +
                                FDocume.strTip_FC +
                                FDocume.strCliFor + '-' +
                                strNom_FC;
  End
  Else
    pReinicia;
end;

procedure TEnderecamentoMarmoreGranito.onAfterPost(DataSet: TDataSet);
begin
  cdsChapas.First;
end;

procedure TEnderecamentoMarmoreGranito.pAtualizaComplementoLinhaPrincipal;
begin
  If objDivideChapa.FstrComplemento <> '' Then
  Begin
    cdsChapas.Edit;
    cdsChapas.FieldByName('COMPLEMENTO').AsString := objDivideChapa.FstrComplemento;
    cdsChapas.FieldByName('LOTE').AsString := objDivideChapa.FStrLoteSemComplemento;
    cdsChapas.Post;
  End;
end;

procedure TEnderecamentoMarmoreGranito.pAtualizaLoteChapas;
Begin
  cdsChapas.First;

  If controleEstoqueChapa = cecVariasChapasPorLote Then
  Begin
    while not cdsChapas.Eof Do
    Begin
      If cdsChapas.FieldByName('LOTE_BASE').AsString <> cdsDados.FieldByName('LOT_NUMLOT').AsString Then
      begin
        cdsChapas.Edit;
        cdsChapas.FieldByName('LOTE').AsString := AnsiReplaceStr (cdsChapas.FieldByName('LOTE').AsString, cdsChapas.FieldByName('LOTE_BASE').AsString,cdsDados.FieldByName('LOT_NUMLOT').AsString);
        cdsChapas.FieldByName('LOTE_BASE').AsString := cdsDados.FieldByName('LOT_NUMLOT').AsString;

        cdsChapas.Post;
      end;
      cdsChapas.Next;
    end;
    Exit;
  End;


  while not cdsChapas.Eof Do
  Begin
    If cdsChapas.FieldByName('LOTE_BASE').AsString <> cdsDados.FieldByName('LOT_NUMLOT').AsString Then
    begin
      qryConsulta.SQL.Clear;

      qryConsulta.SQL.Add('DELETE FROM LOTMAR ');
      qryConsulta.SQL.Add(' WHERE LOT_IDENTI = :LOT_IDENTI');
      qryConsulta.SQL.Add('   AND LOT_LOTBAS = :LOT_NUMLOT');
      qryConsulta.SQL.Add('   AND LOT_CODITE = :LOT_CODITE');
      qryConsulta.SQL.Add('   AND LOT_CODEMP = :LOT_CODEMP;');

      qryConsulta.ParamByName('LOT_IDENTI').AsString := strChaveLoteTemporario;
      qryConsulta.ParamByName('LOT_NUMLOT').AsString := cdsChapas.FieldByName('LOTE_BASE').AsString;
      qryConsulta.ParamByName('LOT_CODITE').AsString := cdsChapas.FieldByName('CODITE').AsString;
      qryConsulta.ParamByName('LOT_CODEMP').AsString := VS_StrCodEmp;
      qryConsulta.ExecSQL;

      cdsChapas.Edit;
      cdsChapas.FieldByName('LOTE_BASE').AsString := cdsDados.FieldByName('LOT_NUMLOT').AsString;
      cdsChapas.FieldByName('LOTE').AsString := cdsDados.FieldByName('LOT_NUMLOT').AsString + '/' + fstrZero(cdsChapas.FieldByName('CHAPA').AsString ,3);
      cdsChapas.Post;
    End;
    cdsChapas.next;
  End;
End;

procedure TEnderecamentoMarmoreGranito.pNormalizaChapas;
begin
  If controleEstoqueChapa = cecVariasChapasPorLote Then
    Exit;

  If cdsChapas.RecordCount > cdsDados.FieldByName('QTDCHAPA').AsInteger then
  Begin
    cdsChapas.First;
    while not cdsChapas.Eof Do
    Begin
      If cdsChapas.FieldByName('CHAPA').AsInteger  > cdsDados.FieldByName('QTDCHAPA').AsInteger Then
        cdsChapas.Delete
      Else
        cdsChapas.next;
    End;
  End
  Else
    pInsereChapas(cdsChapas.RecordCount + 1);
End;



procedure TEnderecamentoMarmoreGranito.pRecalculaNomeLote;
begin
  cdsChapas.First;
  While not cdsChapas.Eof Do
  Begin
    cdsChapas.Edit;
    cdsChapas.FieldByName('LOTE').AsString :=  cdsDados.FieldByName('LOT_NUMLOT').AsString + '/' + fstrZero(cdsChapas.RecNo ,3);
    cdsChapas.Post;
    cdsChapas.Next
  End;
end;

procedure TEnderecamentoMarmoreGranito.pReinicia;
begin
  //pRemoveLotMar;
  FreeAndNil(cdsDados);
  FreeAndNil(cdsChapas);
  cdsDados := TZClient.Create(nil);
  cdsChapas := TZClient.Create(nil);
  cdsDados.AfterPost := onAfterPost;
end;

procedure TEnderecamentoMarmoreGranito.onBeforePostChapa(DataSet: TDataSet);
begin
 If fCalculaMediaLiquidaLargura Then
    cdsChapas.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat := fFormataFloat(cdsChapas.FieldByName('MEDIDA_BRUTA_LARGURA').AsFloat * ( 1 - ( cdsChapas.FieldByName('ESTPER').AsFloat / 100 ) ),4);
  If fCalculaMediaLiquidaAltura Then
    cdsChapas.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat  := fFormataFloat(cdsChapas.FieldByName('MEDIDA_BRUTA_ALTURA').AsFloat * ( 1 - ( cdsChapas.FieldByName('ESTPER').AsFloat / 100 ) ),4);
  pCalculaPerda;

  cdsChapas.FieldByName('QTD_M2_LIQUIDO').AsFloat := fRetMedidaMetroLiquido;
  cdsChapas.FieldByName('VALOR_TOTAL_M2').AsFloat := fRetValorTotal;
  cdsChapas.FieldByName('VALOR_TOTAL_ENTREGA_M2').AsFloat := fRetValorTotalEntrega;
end;


procedure TEnderecamentoMarmoreGranito.onValidateDadosCamposChapa(Sender: TField);
begin
  pValidarAlteracaoItemComChapa;
end;

procedure TEnderecamentoMarmoreGranito.pSetFilterSeqDet(strSeqDet: String);
Begin
  cdsChapas.Filtered := False;
  cdsChapas.Filter   := 'SEQDET = ' + QuotedStr(cdsDados.FieldByName('SEQDET').AsString);
  cdsChapas.Filtered := True;
End;


procedure TEnderecamentoMarmoreGranito.pAbreDefinicoesDeChapas;
var frmEnderecamentoMarmoreGranitoChapas: TfrmEnderecamentoMarmoreGranitoChapas;
    cdsBackup: TZClient;
begin
  cdsBackup := TZClient.Create(nil);


  cdsChapas.Filtered := False;
  cdsBackup.Data :=  cdsChapas.Data;

  pSetFilterSeqDet(cdsDados.FieldByName('SEQDET').AsString);
  pCriarFormularios(TfrmEnderecamentoMarmoreGranitoChapas, frmEnderecamentoMarmoreGranitoChapas);
  Try
    frmEnderecamentoMarmoreGranitoChapas.dtsDados.DataSet := cdsChapas;
    frmEnderecamentoMarmoreGranitoChapas.lblProduto.Caption    := cdsDados.FieldByName('FDO_CODITE').AsString + ' - ' + cdsDados.FieldByName('FDO_DESCRI').AsString;
    frmEnderecamentoMarmoreGranitoChapas.lblLote.Caption       := cdsDados.FieldByName('LOT_NUMLOT').AsString;
    frmEnderecamentoMarmoreGranitoChapas.lblQtdChapas.Caption  := FormatFloat(fMskDigitos(intDeqTem), cdsDados.FieldByName('QTDCHAPA').AsFloat);
    frmEnderecamentoMarmoreGranitoChapas.lblQtdEntrada.Caption := FormatFloat(fMskDigitos(intDeqTem),cdsDados.FieldByName('FDO_QTDITE').AsFloat);
    frmEnderecamentoMarmoreGranitoChapas.strChaveLoteTemporario := strChaveLoteTemporario;
    frmEnderecamentoMarmoreGranitoChapas.intQtdChapas := cdsDados.FieldByName('QTDCHAPA').Asinteger;
    frmEnderecamentoMarmoreGranitoChapas.fltPercPerda := cdsDados.FieldByName('QTDCHAPA').Asinteger;


    frmEnderecamentoMarmoreGranitoChapas.objEnderecamentoMarmoreGranito := Self;
    cdsChapas.BeforePost := onBeforePostChapa;


    cdsChapas.First;
    frmEnderecamentoMarmoreGranitoChapas.ShowModal;
    If frmEnderecamentoMarmoreGranitoChapas.blnRestaura then
        cdsChapas.Data := cdsBackup.Data;

    cdsDados.AfterPost := nil;
    cdsDados.Edit;
    cdsDados.FieldByName('STATUS').AsString := IIf(frmEnderecamentoMarmoreGranitoChapas.blnDefinicoesCompletas, '1', '0');
    cdsDados.Post;
    cdsDados.AfterPost := onAfterPost;

  Finally
    cdsChapas.BeforePost := nil;
    FreeAndNil(frmEnderecamentoMarmoreGranitoChapas);
  End;

End;

procedure TEnderecamentoMarmoreGranito.pAbrirDefinicoesDasChapas;
  Var
    blnChapasRecuperadas: Boolean;
begin
  blnChapasRecuperadas := blnRecuperando and (cdsDados.FieldByName('STATUS').AsString = '1');
  If fPodeAbrirDefinicoesDeChapa Then
  Begin
    pSetFilterSeqDet(cdsDados.FieldByName('SEQDET').AsString);

    If blnChapasRecuperadas then
    begin
      fRegistroGravadoLotMar(cdsDados.FieldByName('AUTOINCREM').AsString);
    end
    else
    begin
      If cdsChapas.IsEmpty Then
          pInsereChapas(1)
      Else
      Begin
        If cdsChapas.FieldByName('LOTE_BASE').AsString <> cdsDados.FieldByName('LOT_NUMLOT').AsString  Then
          pAtualizaLoteChapas;

        If cdsChapas.RecordCount <> cdsDados.FieldByName('QTDCHAPA').AsInteger Then
          pNormalizaChapas;
      End;
      pCarregaChapasLotMar;
    end;

    pAbreDefinicoesDeChapas;
  End;

end;

function TEnderecamentoMarmoreGranito.fAbrirDefinicoesDasChapasParaDivisao: Boolean;
  var frmEnderecamentoMarmoreGranitoChapas: TfrmEnderecamentoMarmoreGranitoChapas;
begin
  pCriarFormularios(TfrmEnderecamentoMarmoreGranitoChapas, frmEnderecamentoMarmoreGranitoChapas);
  Try
    frmEnderecamentoMarmoreGranitoChapas.dtsDados.DataSet := cdsChapas;
    frmEnderecamentoMarmoreGranitoChapas.lblProduto.Caption    := cdsDados.FieldByName('FDO_CODITE').AsString + ' - ' + cdsDados.FieldByName('FDO_DESCRI').AsString;
    frmEnderecamentoMarmoreGranitoChapas.lblLote.Caption       := cdsDados.FieldByName('LOT_NUMLOT').AsString;
    frmEnderecamentoMarmoreGranitoChapas.lblQtdChapas.Caption  := FormatFloat(fMskDigitos(intDeqTem), cdsDados.FieldByName('QTDCHAPA').AsFloat);
    frmEnderecamentoMarmoreGranitoChapas.lblQtdEntrada.Caption := FormatFloat(fMskDigitos(intDeqTem),cdsDados.FieldByName('FDO_QTDITE').AsFloat);
    frmEnderecamentoMarmoreGranitoChapas.strChaveLoteTemporario := strChaveLoteTemporario;
    frmEnderecamentoMarmoreGranitoChapas.intQtdChapas := cdsDados.FieldByName('QTDCHAPA').Asinteger;
    frmEnderecamentoMarmoreGranitoChapas.fltPercPerda := cdsDados.FieldByName('QTDCHAPA').Asinteger;
    frmEnderecamentoMarmoreGranitoChapas.lblCapQtdChapas.Visible := False;
    frmEnderecamentoMarmoreGranitoChapas.lblQtdChapas.Visible := False;
    frmEnderecamentoMarmoreGranitoChapas.blnDividindoChapa := blnDividindoChapa;
    frmEnderecamentoMarmoreGranitoChapas.lblCapQtdEntrada.Caption := 'Saldo Lote:' ;

    frmEnderecamentoMarmoreGranitoChapas.cxgDBDadosCHAPA.SortIndex := -1;
    frmEnderecamentoMarmoreGranitoChapas.cxgDBDadosCHAPA.SortOrder := soNone;

    frmEnderecamentoMarmoreGranitoChapas.objEnderecamentoMarmoreGranito := Self;
    cdsChapas.BeforePost := onBeforePostChapa;


    cdsChapas.First;
    frmEnderecamentoMarmoreGranitoChapas.ShowModal;

    cdsDados.AfterPost := nil;
    Result := frmEnderecamentoMarmoreGranitoChapas.blnDefinicoesCompletas;

  Finally
    cdsChapas.BeforePost := nil;
    FreeAndNil(frmEnderecamentoMarmoreGranitoChapas);
  End;
end;

function TEnderecamentoMarmoreGranito.fRetValField(strField: String): Double;
begin
  Result := cdsChapas.FieldByName(strField).AsFloat;
end;


function TEnderecamentoMarmoreGranito.fRedefineTextoDoLote: Boolean;
begin
  Result := TfrmMarmoreTrocaNumeroDoLote.fTroca(cdsDados, cdsChapas, sizeFieldNumLot);
  {}
end;

function TEnderecamentoMarmoreGranito.fRegistroGravadoLotMar(strIteDoc: String = ''): Boolean;
  Var
    blnFiltarPorItemDocumento: Boolean;
begin
  blnFiltarPorItemDocumento := fEmptyStr(strIteDoc) = False;

  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT *  FROM LOTMAR           ');
  qryConsulta.SQL.Add('WHERE  LOT_CODITE = :LOT_CODITE ');
  qryConsulta.SQL.Add('   AND LOT_CODDOC = :LOT_CODDOC ');
  qryConsulta.SQL.Add('   AND LOT_CODEMP = :LOT_CODEMP ');
  qryConsulta.SQL.Add('   AND LOT_LOTBAS = :LOT_LOTBAS ');

  if blnFiltarPorItemDocumento then
    qryConsulta.SQL.Add('   AND LOT_ITEDOC = :LOT_ITEDOC ');

  qryConsulta.SQL.Add('ORDER BY LOT_IDENTI DESC        ');
  qryConsulta.SQL.Add('LIMIT :QTD_CHAPAS               ');

  qryConsulta.ParamByName('LOT_CODDOC').AsString  := strAutIncPed;
  qryConsulta.ParamByName('LOT_CODITE').AsString  := cdsDados.FieldByName('FDO_CODITE').AsString;
  qryConsulta.ParamByName('QTD_CHAPAS').AsInteger := cdsDados.FieldByName('QTDCHAPA').AsInteger;
  qryConsulta.ParamByName('LOT_LOTBAS').AsString  := cdsDados.FieldByName('LOT_NUMLOT').AsString;
  qryConsulta.ParamByName('LOT_CODEMP').AsString  := VS_StrCodEmp;

  if blnFiltarPorItemDocumento then
    qryConsulta.ParamByName('LOT_ITEDOC').AsString  := strIteDoc;
  qryConsulta.Open;

  Result := Not qryConsulta.IsEmpty;

end;

function TEnderecamentoMarmoreGranito.fRemoverComplementoTextoLote(strLote,
  strComplemento: String): String;
begin
  if fEmptyStr(strComplemento) then
    exit(strLote);
  strComplemento := ReverseString(strComplemento);
  strLote := ReverseString(strLote);
  if Pos(strComplemento, strLote) = 1 then
    strLote := StringReplace(strLote, strComplemento, '',[]);
  Result := ReverseString(strLote)
end;

function TEnderecamentoMarmoreGranito.fRetMedidaMetroLiquido: Double;
begin
  Result  := fRetValField('MEDIDA_LIQUIDA_LARGURA') * fRetValField('MEDIDA_LIQUIDA_ALTURA');
  If controleEstoqueChapa = cecVariasChapasPorLote Then
    Result := Result * fRetValField('CHAPA');

end;

function TEnderecamentoMarmoreGranito.fRetValorTotal: Double;
begin
  Result  := fRetValField('PRECO_M2') * fRetMedidaMetroLiquido;
End;

function TEnderecamentoMarmoreGranito.fRetValorTotalEntrega: Double;
begin
  Result  := fRetValField('PRECO_ENTREGA_M2') * fRetMedidaMetroLiquido;
End;


function TEnderecamentoMarmoreGranito.fTemQtdChapasDefinidas: Boolean;
begin
  Result := cdsDados.FieldByName('QTDCHAPA').AsInteger > 0
end;


procedure TEnderecamentoMarmoreGranito.pRedefineNChapa;
begin
  If blnDividindoChapa Then
    If (controleEstoqueChapa = cecVariasChapasPorLote) Then
      If (cdsChapas.FieldByName('CHAPA').AsInteger = 0) Then
        cdsChapas.FieldByName('CHAPA').AsInteger :=  1
End;

procedure TEnderecamentoMarmoreGranito.pInsereChapa(qtdChapa: integer);
var
  fltMarBruLar, fltMarBruAlt, fltMarLiqLar, fltMarLiqAlt : Double;
  intChapa: Integer;
begin
  If not blnDividindoChapa Then
  Begin
    If (cdsDados.FieldByName('QTDCHAPA').AsInteger - qtdChapa) <= 0 Then
    Begin
      pMensagemOk('A quantidade de chapas necessárias já foram atendidas, não será possível inserir novo registro.');
      Exit;
    End;
  End;

  fltMarBruLar := cdsChapas.FieldByName('MEDIDA_BRUTA_LARGURA').AsFloat;
  fltMarBruAlt := cdsChapas.FieldByName('MEDIDA_BRUTA_ALTURA').AsFloat;
  fltMarLiqLar := cdsChapas.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat;
  fltMarLiqAlt := cdsChapas.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat;

  cdsChapas.Insert;
  cdsChapas.FieldByName('SEQDET').AsString := cdsDados.FieldByName('SEQDET').AsString;

  intChapa := cdsDados.FieldByName('QTDCHAPA').AsInteger - qtdChapa;

  if blnDividindoChapa and (intChapa < 1) then
    intChapa := 1;

  cdsChapas.FieldByName('CHAPA').AsInteger := intChapa;

  cdsChapas.FieldByName('ESTPER').AsFloat  := cdsDados.FieldByName('ESTPER').AsFloat;
  If (Not blnDividindoChapa) then
    cdsChapas.FieldByName('AUTOINCREM').AsString := cdsDados.FieldByName('AUTOINCREM').AsString;
  pRedefineNChapa;

  cdsChapas.FieldByName('LOTE').AsString :=  fGetNomeLote;
  If blnDividindoChapa then
    cdsChapas.FieldByName('LOTE_BASE').AsString :=  cdsDados.FieldByName('LOTE_BASE').AsString
  Else
    cdsChapas.FieldByName('LOTE_BASE').AsString :=  cdsDados.FieldByName('LOT_NUMLOT').AsString;
  cdsChapas.FieldByName('PRECO_M2').AsFloat := cdsDados.FieldByName('PRESUG').AsFloat;
  cdsChapas.FieldByName('PRECO_ENTREGA_M2').AsFloat := cdsDados.FieldByName('PRESUG').AsFloat;
  cdsChapas.FieldByName('CODITE').AsString := cdsDados.FieldByName('FDO_CODITE').AsString;

  cdsChapas.FieldByName('MEDIDA_BRUTA_LARGURA').AsFloat := fltMarBruLar;
  cdsChapas.FieldByName('MEDIDA_BRUTA_ALTURA').AsFloat := fltMarBruAlt;
  cdsChapas.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat := fltMarLiqLar;
  cdsChapas.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat := fltMarLiqAlt;
  cdsChapas.FieldByName('VALOR_TOTAL_M2').AsFloat := 0;
  cdsChapas.FieldByName('VALOR_TOTAL_ENTREGA_M2').AsFloat := 0;
  cdsChapas.FieldByName('ESPESSURA').AsFloat := 0;
  cdsChapas.Post;

  If not blnDividindoChapa Then
    pRecalculaNomeLote;
end;

function TEnderecamentoMarmoreGranito.fGetProximoNomeLoteDisponivel: string;
begin
  inherited;

  If cdsChapas.RecordCount = 1 then
  begin
    objDivideChapa.FstrLoteBase := '';
    objDivideChapa.FstrComplemento := '';
    objDivideChapa.FintNChapa := -1;
    objDivideChapa.pSetaVariaveisControleIncial;
  End;

  result := fLocalizaProximoLote(qryConsulta);
  pAtualizaNumeroDaChapaSeNecessario;
end;

procedure TEnderecamentoMarmoreGranito.pAtualizaNumeroDaChapaSeNecessario;
begin
  If controleEstoqueChapa = cecUmaChapaPorLote then
    If blnDividindoChapa then
    Begin
      If cdsChapas.State in dsEditModes Then
        cdsChapas.FieldByName('CHAPA').AsInteger :=  objDivideChapa.FintNChapa
      Else
      begin
        cdsChapas.Edit;
        cdsChapas.FieldByName('CHAPA').AsInteger :=  objDivideChapa.FintNChapa;
        cdsChapas.Post;
      End;
    End;
End;

function TEnderecamentoMarmoreGranito.fLocalizaProximoLote(qrySQL: TUniQuery): string;
var blnLocalizou: Boolean;
    strNovoLote: String;
begin
  qrySQL.SQL.Clear;
  qrySQL.SQL.Add('SELECT LOT_NUMLOT FROM CADLOT');
  qrySQL.SQL.Add(' WHERE LOT_CHAPA_ = "S"');
  qrySQL.SQL.Add('   AND  REVERSE(SUBSTRING(REVERSE(LOT_NUMLOT), POSITION("/" IN REVERSE(LOT_NUMLOT)) + 1, LENGTH(LOT_NUMLOT))) = :BASLOT');
  qrySQL.SQL.Add('   AND LOT_CODITE = "'+objDivideChapa.FStrCodIte+'"');
  qrySQL.SQL.Add('   AND LOT_CODEMP = "'+objDivideChapa.FStrCodEmp+'"');
  qrySQL.SQL.Add('   AND LOT_NUMLOT = :NUMLOT');

  qrySQL.ParamByName('BASLOT').AsString :=  objDivideChapa.FstrLoteBase;

  blnLocalizou := False;


  while Not blnLocalizou do
  begin
    Inc(objDivideChapa.FintNChapa);
    strNovoLote := objDivideChapa.FstrLoteBase + '/' + fstrZero(IntToStr(objDivideChapa.FintNChapa), 3);
    qrySQL.ParamByName('NUMLOT').AsString := strNovoLote;
    qrySQL.Close;
    qrySQL.Open;
    If qrySQL.IsEmpty Then
    Begin
      blnLocalizou := True;
      Result := strNovoLote;
    End;
  End;

End;

function TEnderecamentoMarmoreGranito.fGetNomeLote: String;
begin
  If not blnDividindoChapa then
    result := cdsDados.FieldByName('LOT_NUMLOT').AsString + '/' + fstrZero(IntToStr(cdsChapas.RecordCount + 1), 3)
  Else
    result := fGetProximoNomeLoteDisponivel;
End;

procedure TEnderecamentoMarmoreGranito.pInsereChapas(intValIni: integer = 1);
var
  recChapa: TChapaRec;
  intQtd: Integer;
  blnPermiteRecursao: Boolean;
begin
  recChapa.Inicializar;
  recChapa.strAutInc    := cdsDados.FieldByName('AUTOINCREM').AsString;
  recChapa.strSeqDet    := cdsDados.FieldByName('SEQDET').AsString;

  recChapa.strLoteBase  := cdsDados.FieldByName('LOT_NUMLOT').AsString;
  recChapa.fltPreco_M2  := cdsDados.FieldByName('PRESUG').AsFloat;
  recChapa.fltPreco_Entrega_M2  := cdsDados.FieldByName('PRESUG').AsFloat;
  recChapa.strCodIte    := cdsDados.FieldByName('FDO_CODITE').AsString;
  recChapa.fltEstPer    := cdsDados.FieldByName('ESTPER').AsFloat;

  If controleEstoqueChapa = cecVariasChapasPorLote  then
  Begin
    intQtd := 1;
    recChapa.strLote    := cdsDados.FieldByName('LOT_NUMLOT').AsString + '/001';
    recChapa.intChapa   := cdsDados.FieldByName('QTDCHAPA').AsInteger;
    blnPermiteRecursao  := False;
  End
  else
  begin
    intQtd := cdsDados.FieldByName('QTDCHAPA').AsInteger;
    recChapa.intChapa   := intValIni;
    recChapa.strLote    := cdsDados.FieldByName('LOT_NUMLOT').AsString + '/' + fstrZero(IntToStr(intValIni), 3);
    blnPermiteRecursao  := True;
  end;

  cdsChapas.Insert;
  pPreencherChapa(recChapa);
  cdsChapas.Post;

  inc(intValIni);

  blnPermiteRecursao := blnPermiteRecursao and (intValIni <= intQtd);
  if blnPermiteRecursao then
    pInsereChapas(intValIni);

End;


function TEnderecamentoMarmoreGranito.fPodeAbrirDefinicoesDeChapa: Boolean;
begin
  Result := True;
  Try
    If (cdsDados.FieldByName('QTDCHAPA').AsInteger < 1) Then
      Exit(False);
    If (cdsDados.FieldByName('LOT_NUMLOT').AsString = '') then
      Exit(False);
  Finally
    If Not Result Then
      If cdsDados.FieldByName('LOT_NUMLOT').AsString = '' then
        postMessage(FOwner.Handle, WM_GO_TO_COLLUMN_LOTE, 0, 0);
  End;
End;


procedure TEnderecamentoMarmoreGranito.pCarregaChapasLotMar;
var
  blnTemLotMar: Boolean;
begin
  cdsChapas.First;

  blnTemLotMar := fRegistroGravadoLotMar;

  While not cdsChapas.Eof Do
  Begin
    cdsChapas.Edit;
    If Not blnTemLotMar Then
    Begin
      cdsChapas.FieldByName('MEDIDA_BRUTA_LARGURA').AsFloat   := 0.0;
      cdsChapas.FieldByName('MEDIDA_BRUTA_ALTURA').AsFloat    := 0.0;
      cdsChapas.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat := 0.0;
      cdsChapas.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat  := 0.0;
      cdsChapas.FieldByName('VALOR_TOTAL_M2').AsFloat         := 0.0;
      cdsChapas.FieldByName('VALOR_TOTAL_ENTREGA_M2').AsFloat := 0.0;
      cdsChapas.FieldByName('ESPESSURA').AsFloat              := 0.0;
      cdsChapas.FieldByName('QTD_M2_LIQUIDO').AsFloat         := 0.0;
      cdsChapas.FieldByName('ESTPER').AsFloat                 := cdsDados.FieldByName('ESTPER').AsFloat;
    End
    Else
    If qryConsulta.Locate('LOT_NUMLOT',  cdsChapas.FieldByName('LOTE').AsString, []) Then
    Begin
      cdsChapas.FieldByName('PERDA').AsFloat                  := qryConsulta.FieldByName('LOT_PERDAS').AsFloat;
      cdsChapas.FieldByName('ESTPER').AsFloat                 := qryConsulta.FieldByName('LOT_ESTPER').AsFloat;
      cdsChapas.FieldByName('MEDIDA_BRUTA_LARGURA').AsFloat   := qryConsulta.FieldByName('LOT_MEDB_L').AsFloat;
      cdsChapas.FieldByName('MEDIDA_BRUTA_ALTURA').AsFloat    := qryConsulta.FieldByName('LOT_MEDB_A').AsFloat;
      cdsChapas.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat := qryConsulta.FieldByName('LOT_MEDL_L').AsFloat;
      cdsChapas.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat  := qryConsulta.FieldByName('LOT_MEDL_A').AsFloat;
      cdsChapas.FieldByName('PRECO_M2').AsFloat               := qryConsulta.FieldByName('LOT_PRVENP').AsFloat;
      cdsChapas.FieldByName('PRECO_ENTREGA_M2').AsFloat       := qryConsulta.FieldByName('LOT_PRVMAP').AsFloat;
      cdsChapas.FieldByName('VALOR_TOTAL_M2').AsFloat         := qryConsulta.FieldByName('LOT_PRVMAT').AsFloat;
      cdsChapas.FieldByName('VALOR_TOTAL_ENTREGA_M2').AsFloat := qryConsulta.FieldByName('LOT_PRVENT').AsFloat;
      cdsChapas.FieldByName('ESPESSURA').AsFloat              := qryConsulta.FieldByName('LOT_ESPESS').AsFloat;
      cdsChapas.FieldByName('QTD_M2_LIQUIDO').AsFloat         := cdsChapas.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat * cdsChapas.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat;
      If controleEstoqueChapa = cecVariasChapasPorLote Then
        cdsChapas.FieldByName('QTD_M2_LIQUIDO').AsFloat := cdsChapas.FieldByName('QTD_M2_LIQUIDO').AsFloat * fRetValField('CHAPA');

    End;

    cdsChapas.Post;

    cdsChapas.Next;
  End;
end;

procedure TEnderecamentoMarmoreGranito.pCarregarAutoIncremPedido;
begin
  If fEmptyStr(strDocumento) Then
    FSeqFgo := EmptyStr
  Else
    FSeqFgo := fCampoTabela('FGO_SEQFGO', 'EXTGOR', ['FGO_DOCEND'], [strDocumento]);
end;

function TEnderecamentoMarmoreGranito.fGetMovGerAutoinc(strCodEmp, strNumDoc,
  strEspDoc, strSerie, strCodCli, strTip_FC: string): String;
  var qryConsulta: TUniQuery;
begin
  Result := '';
  If strNumDoc = '' Then
    Exit;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT AUTOINCREM FROM MOVGER');
    qryConsulta.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC');
    qryConsulta.SQL.Add('   AND GER_ESPDOC = :ESPDOC');
    qryConsulta.SQL.Add('   AND GER_CODEMP = :CODEMP');
    qryConsulta.SQL.Add('   AND COALESCE(GER_SERIE_, "") = :SERIE_');
    If SameText(strTip_FC, 'F') Then
      qryConsulta.SQL.Add('   AND GER_CODFOR = :CODCLI')
    Else
      qryConsulta.SQL.Add('   AND GER_CODCLI = :CODCLI');

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;
    qryConsulta.ParamByName('SERIE_').AsString := strSerie;
    qryConsulta.ParamByName('CODCLI').AsString := strCodCli;

    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
      Result := qryConsulta.FieldByName('AUTOINCREM').AsString;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;


procedure TEnderecamentoMarmoreGranito.pIniciaDadosDivisaoChapa;
begin
  cdsDados.qryQuery.SQL.Text := objDivideChapa.fGetSQLLoteOriginal;
  cdsDados.fAbreClient(false, '[TEnderecamentoMarmoreGranito.pIniciaDadosDivisaoChapa]');

  cdsChapas.qryQuery.SQL.Text := objDivideChapa.fGetSqlChapas(controleEstoqueChapa = cecVariasChapasPorLote);
  cdsChapas.fAbreClient(false, '[TEnderecamentoMarmoreGranito.pIniciaDadosDivisaoChapa]');

  strChaveLoteTemporario := FormatDateTime('ddmmyyyhh:mm:ss', fNow);

  fltMarBruAltura := cdsChapas.FieldByName('MEDIDA_BRUTA_ALTURA').AsFloat;
  fltMarBruLargur := cdsChapas.FieldByName('MEDIDA_BRUTA_LARGURA').AsFloat;
end;

procedure TEnderecamentoMarmoreGranito.pInjetaInsertLotmar;
begin
  qryConsulta.SQL.Add('  INSERT INTO LOTMAR (');
  qryConsulta.SQL.Add('    LOT_IDENTI,');
  qryConsulta.SQL.Add('    LOT_NUMLOT,');
  qryConsulta.SQL.Add('    LOT_NCHAPA,');
  qryConsulta.SQL.Add('    LOT_MEDB_L,');
  qryConsulta.SQL.Add('    LOT_MEDB_A,');
  qryConsulta.SQL.Add('    LOT_MEDL_L,');
  qryConsulta.SQL.Add('    LOT_MEDL_A,');
  qryConsulta.SQL.Add('    LOT_ESPESS,');
  qryConsulta.SQL.Add('    LOT_PRVMAP,');
  qryConsulta.SQL.Add('    LOT_PRVMAT,');
  qryConsulta.SQL.Add('    LOT_CODITE,');
  qryConsulta.SQL.Add('    LOT_LOTBAS,');
  qryConsulta.SQL.Add('    LOT_PERDAS,');
  qryConsulta.SQL.Add('    LOT_CODEMP,');
  qryConsulta.SQL.Add('    LOT_CODDOC,');
  qryConsulta.SQL.Add('    LOT_ITEDOC,');
  qryConsulta.SQL.Add('    LOT_ESTPER,');
  qryConsulta.SQL.Add('    LOT_PRVENP,');
  qryConsulta.SQL.Add('    LOT_PRVENT,');
  QryConsulta.Sql.Add('    LOT_COMPLE');
  qryConsulta.SQL.Add(' ) VALUES  (');
  qryConsulta.SQL.Add('    :LOT_IDENTI,');
  qryConsulta.SQL.Add('    :LOT_NUMLOT,');
  qryConsulta.SQL.Add('    :LOT_NCHAPA,');
  qryConsulta.SQL.Add('    :LOT_MEDB_L,');
  qryConsulta.SQL.Add('    :LOT_MEDB_A,');
  qryConsulta.SQL.Add('    :LOT_MEDL_L,');
  qryConsulta.SQL.Add('    :LOT_MEDL_A,');
  qryConsulta.SQL.Add('    :LOT_ESPESS,');
  qryConsulta.SQL.Add('    :LOT_PRVMAP,');
  qryConsulta.SQL.Add('    :LOT_PRVMAT,');
  qryConsulta.SQL.Add('    :LOT_CODITE,');
  qryConsulta.SQL.Add('    :LOT_LOTBAS,');
  qryConsulta.SQL.Add('    :LOT_PERDAS,');
  qryConsulta.SQL.Add('    :LOT_CODEMP,');
  qryConsulta.SQL.Add('    :LOT_CODDOC,');
  qryConsulta.SQL.Add('    :LOT_ITEDOC,');
  qryConsulta.SQL.Add('    :LOT_ESTPER,');
  qryConsulta.SQL.Add('    :LOT_PRVENP,');
  qryConsulta.SQL.Add('    :LOT_PRVENT,');
  qryConsulta.SQL.Add('    :LOT_COMPLE)');
End;

procedure TEnderecamentoMarmoreGranito.pInsereDadosChapa;
begin
  qryConsulta.ParamByName('LOT_IDENTI').Value := strChaveLoteTemporario;
  qryConsulta.ParamByName('LOT_NUMLOT').Value := cdsChapas.FieldByName('LOTE').Value + IIF(cdsChapas.FieldByName('COMPLEMENTO').AsString <> '', ' ' + cdsChapas.FieldByName('COMPLEMENTO').AsString, '');
  qryConsulta.ParamByName('LOT_NCHAPA').Value := cdsChapas.FieldByName('CHAPA').Value;
  qryConsulta.ParamByName('LOT_MEDB_L').Value := cdsChapas.FieldByName('MEDIDA_BRUTA_LARGURA').Value;
  qryConsulta.ParamByName('LOT_MEDB_A').Value := cdsChapas.FieldByName('MEDIDA_BRUTA_ALTURA').Value;
  qryConsulta.ParamByName('LOT_MEDL_L').Value := cdsChapas.FieldByName('MEDIDA_LIQUIDA_LARGURA').Value;
  qryConsulta.ParamByName('LOT_MEDL_A').Value := cdsChapas.FieldByName('MEDIDA_LIQUIDA_ALTURA').Value;
  qryConsulta.ParamByName('LOT_ESPESS').Value := cdsChapas.FieldByName('ESPESSURA').Value;
  qryConsulta.ParamByName('LOT_PRVMAP').Value := cdsChapas.FieldByName('PRECO_M2').Value;
  qryConsulta.ParamByName('LOT_PRVMAT').Value := cdsChapas.FieldByName('VALOR_TOTAL_M2').Value;
  qryConsulta.ParamByName('LOT_PRVENP').Value := cdsChapas.FieldByName('PRECO_ENTREGA_M2').Value;
  qryConsulta.ParamByName('LOT_PRVENT').Value := cdsChapas.FieldByName('VALOR_TOTAL_ENTREGA_M2').Value;
  qryConsulta.ParamByName('LOT_CODITE').Value := cdsChapas.FieldByName('CODITE').Value;
  qryConsulta.ParamByName('LOT_LOTBAS').Value := cdsChapas.FieldByName('LOTE_BASE').Value;
  qryConsulta.ParamByName('LOT_PERDAS').Value := cdsChapas.FieldByName('PERDA').Value;
  qryConsulta.ParamByName('LOT_ESTPER').Value := cdsChapas.FieldByName('ESTPER').Value;

  if (Not blnDividindoChapa) then
    qryConsulta.ParamByName('LOT_ITEDOC').Value := cdsChapas.FieldByName('AUTOINCREM').Value;

  qryConsulta.ParamByName('LOT_COMPLE').Value := cdsChapas.FieldByName('COMPLEMENTO').AsString;
  qryConsulta.ParamByName('LOT_CODEMP').Value := VS_StrCodEmp;
  qryConsulta.ParamByName('LOT_CODDOC').Value := strAutIncPed;
End;

procedure TEnderecamentoMarmoreGranito.pPreencherChapa(recChapa: TChapaRec);
begin
  cdsChapas.FieldByName('SEQDET').AsString := recChapa.strSeqDet;
  cdsChapas.FieldByName('CHAPA').AsInteger := recChapa.intChapa;
  cdsChapas.FieldByName('LOTE').AsString :=  recChapa.strLote;
  cdsChapas.FieldByName('LOTE_BASE').AsString :=  recChapa.strLoteBase;
  cdsChapas.FieldByName('PRECO_M2').AsFloat := recChapa.fltPreco_M2;
  cdsChapas.FieldByName('PRECO_ENTREGA_M2').AsFloat := recChapa.fltPreco_Entrega_M2;
  cdsChapas.FieldByName('CODITE').AsString := recChapa.strCodIte;
  cdsChapas.FieldByName('ESTPER').AsFloat := recChapa.fltEstPer;
  cdsChapas.FieldByName('AUTOINCREM').AsString := recChapa.strAutInc;
  cdsChapas.FieldByName('MEDIDA_BRUTA_LARGURA').AsFloat := recChapa.recMedidaBruta.fltLargura;
  cdsChapas.FieldByName('MEDIDA_BRUTA_ALTURA').AsFloat := recChapa.recMedidaBruta.fltAltura;
  cdsChapas.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat := recChapa.recMedidaLiquida.fltLargura;
  cdsChapas.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat := recChapa.recMedidaLiquida.fltAltura;
  cdsChapas.FieldByName('VALOR_TOTAL_M2').AsFloat := recChapa.fltValorTotalM2;
  cdsChapas.FieldByName('VALOR_TOTAL_ENTREGA_M2').AsFloat := recChapa.fltValorTotalEntregaM2;
  cdsChapas.FieldByName('ESPESSURA').AsFloat := recChapa.fltEspessura;
  cdsChapas.FieldByName('COMPLEMENTO').AsString := recChapa.strComplemento;
  cdsChapas.FieldByName('PERDA').AsFloat := recChapa.fltQtdPerda;
  cdsChapas.FieldByName('QTD_M2_LIQUIDO').AsFloat := recChapa.recMedidaLiquida.fArea;
  if controleEstoqueChapa = cecVariasChapasPorLote then
    cdsChapas.FieldByName('QTD_M2_LIQUIDO').AsFloat := cdsChapas.FieldByName('QTD_M2_LIQUIDO').AsFloat * recChapa.intChapa;
end;

function TEnderecamentoMarmoreGranito.fInsereLotesNaTemporaria: Boolean;
begin
  Result := True;

  Try
    qryConsulta.SQL.Clear;


    qryConsulta.SQL.Add('DELETE FROM LOTMAR ');
    qryConsulta.SQL.Add(' WHERE LOT_CODDOC = :LOT_CODDOC');
    qryConsulta.SQL.Add('   AND LOT_LOTBAS = :LOT_LOTBAS');
    qryConsulta.SQL.Add('   AND LOT_CODITE = :LOT_CODITE');
    qryConsulta.SQL.Add('   AND LOT_CODEMP = :LOT_CODEMP');

    if (Not blnDividindoChapa) then
      qryConsulta.SQL.Add('   AND LOT_ITEDOC = :LOT_ITEDOC');

    qryConsulta.ParamByName('LOT_CODDOC').AsString := strAutIncPed;
    qryConsulta.ParamByName('LOT_LOTBAS').AsString := cdsChapas.FieldByName('LOTE_BASE').Value;
    qryConsulta.ParamByName('LOT_CODITE').AsString := cdsChapas.FieldByName('CODITE').Value;
    qryConsulta.ParamByName('LOT_CODEMP').AsString := VS_StrCodEmp;
    if (Not blnDividindoChapa) then
      qryConsulta.ParamByName('LOT_ITEDOC').AsString := cdsChapas.FieldByName('AUTOINCREM').AsString;

    qryConsulta.ExecSQL;

    qryConsulta.SQL.Clear;

    pInjetaInsertLotmar;

    cdsChapas.First;
    While not cdsChapas.Eof do
    begin
      pInsereDadosChapa;
      qryConsulta.ExecSQL;
      cdsChapas.Next;
    End;
  Except
    on e: Exception do
    Begin
      pMensagensErro(e.message, '[TEnderecamentoMarmoreGranito.fInsereLotesNaTemporaria]');
      Result := False;
    End;
  End;
end;


function TEnderecamentoMarmoreGranito.fLoteJaCadastrado: Boolean;
begin
  qryConsulta.sql.clear;
  qryConsulta.sql.Add('SELECT LOT_NUMLOT FROM CADLOT ');
  qryConsulta.sql.Add('WHERE LOT_NUMLOT IN ('+fRetNumerosDoLote+')');
  qryConsulta.sql.Add('AND LOT_CODEMP = "' + VS_StrCodEmp + '"');
  qryConsulta.sql.Add('AND LOT_CODITE = "' + cdsChapas.FieldByName('CODITE').AsString + '"');

  qryConsulta.Open;

  Result:= not qryConsulta.IsEmpty;
end;


function TEnderecamentoMarmoreGranito.fRetNumerosDoLote: String;
var i: integer;
begin
  For i := 1 To cdsDados.FieldByName('QTDCHAPA').AsInteger do
  Begin
    result := Result + '"' + cdsDados.FieldByName('LOT_NUMLOT').AsString + '/' +  fstrZero(intToStr(i), 3) + '"';
  End;


  result := AnsiReplaceStr(result, '""', '","');
End;

procedure TEnderecamentoMarmoreGranito.pImprimeEtiquetas(strFiltroForcado: String);
var prmDllEtq : TParamDllEtiquetas;
begin
  prmDllEtq := TParamDllEtiquetas.Create;
  Try
    prmDllEtq.strCodEmp := ShortString(String(VS_strCodEmp));
    If fCfgSis('ETIMAR') = 'L' Then
      prmDllEtq.tpeTipEtq :=  tpeMarmoreGranito
    Else
      prmDllEtq.tpeTipEtq :=  tpeMarmoreGranitoArgox;
    prmDllEtq.strChaveTemporariaLotMarmore := strChaveLoteTemporario;
    prmDllEtq.strForceFiltro := strFiltroForcado;
    prmDllEtq.intQtdEti := 1;

    fImprimeEtiqueta(prmDllEtq, 'fImprimeEtiquetasLoteProduto');
  Finally
    FreeAndNil(prmDllEtq);
  End;
End;


function TEnderecamentoMarmoreGranito.fValidaDefinicoesChapa: Boolean;
begin
  If controleEstoqueChapa = cecVariasChapasPorLote Then
    Exit(True);
  Result := cdsChapas.RecordCount = cdsDados.FieldByName('QTDCHAPA').AsInteger

End;

procedure TEnderecamentoMarmoreGranito.pImprimirItem;
var strErro: String;
    strFiltroInjetado: String;
begin
  pSetFilterSeqDet(cdsDados.FieldByName('SEQDET').AsString);
  If cdsChapas.RecordCount = 0 Then
    strErro := 'Para imprimir as etiquetas é preciso definir as medidas das chapas através do botão [F9] Medidas das Chapas.'
  Else If not fValidaDefinicoesChapa Then
    strErro := 'Existem chapas que não foram definidas as medidas, é preciso definir as medidas das chapas através do botão [F9] Medidas das Chapas.';

  If strErro = '' then
  Begin
    If fPergunta('Deseja imprimir as etiquetas da(s) chapa(s)?') then
    Begin
      strFiltroInjetado := '';
      strFiltroInjetado := ' AND LOTMAR.LOT_LOTBAS = "' + cdsChapas.FieldByName('LOTE_BASE').AsString + '"' +
                           ' AND LOTMAR.LOT_CODITE = "' + cdsChapas.FieldByName('CODITE').AsString + '"';
      pImprimeEtiquetas(strFiltroInjetado)
    end;
  end
  Else
   fMensagem('ATENÇÃO!', strErro, ['&O k']);
end;


function TEnderecamentoMarmoreGranito.fGetSQLTransferencia: String;
var strLoteOrigem: string;
Begin

  strLoteOrigem := fGetLoteCorreto;

  Result := '';
  Result := Result + 'SELECT LOT_CODITE AS CODITE,';
  Result := Result + '       LOT_NUMLOT AS ARMDES,';
  Result := Result + '       "'+strLoteOrigem+'" AS ARMORI,';
  If controleEstoqueChapa = cecVariasChapasPorLote Then
    Result := Result + '       (IFNULL(LOT_MEDL_L, 0) * IFNULL(LOT_MEDL_A, 0)) * LOT_NCHAPA AS QTDITE'
  Else
    Result := Result + '       IFNULL(LOT_MEDL_L, 0) * IFNULL(LOT_MEDL_A, 0) AS QTDITE';

  Result := Result + '  FROM LOTMAR';
  Result := Result + ' WHERE LOT_IDENTI = "'+strChaveLoteTemporario+'"';
  If blnDividindoChapa Then
    Result := Result + ' AND LOT_NUMLOT <> "'+strLoteOrigem+'"';
End;

procedure TEnderecamentoMarmoreGranito.pGeraTransferencia;
  Var
    cdsItensTL: TUniClientDataSet;
    objTransf : TTransferenciaArmazens;
    qryData: TZClient;
Begin

  qryData := TZClient.Create(nil, fGetSQLTransferencia);
  qryData.fAbreClient(false, '[TEnderecamentoMarmoreGranito.pGeraTransferencia]');

  Try
    If Not qryData.IsEmpty Then
    begin
      progress.Visible := True;


      Try
        cdsItensTL   := TUniClientDataSet.Create(nil);
        cdsItensTL.Data :=  qryData.Data;

        progress.Visible := True;

        objTransf := TTransferenciaArmazens.Create(nil, cdsItensTL, Nil, progress);
        objTransf.strSeqOri := cdsDados.FieldByName('SEQGER').AsString;

        objTransf.fGeraTransferencia(True, False);

      Finally
        progress.Visible := False;
        FreeAndNil(objTransf );
        FreeAndNil(cdsItensTL);
      End;
    End;
  Finally
    FreeAndNil(qryData);
  End

End;


procedure TEnderecamentoMarmoreGranito.pDeletaReserva;
begin
  If blnDividindoChapa Then
    Exit;
  qryComand.SQL.Clear;
  qryComand.SQL.Add('DELETE FROM');
  qryComand.SQL.Add('  FATGOR');
  qryComand.SQL.Add('WHERE');
  qryComand.SQL.Add('  AUTOINCREM =  ' + QuotedStr(FSeqFgo));
  qryComand.SQL.Add(' /* ;');
  qryComand.SQL.Add(' FDocume.strNumDoc =  + FDocume.strNumDoc');
  qryComand.SQL.Add(' FDocume.strEspDoc =  + FDocume.strEspDoc');
  qryComand.SQL.Add(' FDocume.strSerie_ =  + FDocume.strSerie_');
  qryComand.SQL.Add(' FDocume.strCodEmp =  + FDocume.strCodEmp');
  qryComand.SQL.Add(' FDocume.strCliFor =  + FDocume.strCliFor');
  qryComand.SQL.Add(' FDocume.strTip_FC =  + FDocume.strTip_FC*/;');
  qryComand.ExecSQL;
end;


procedure TEnderecamentoMarmoreGranito.pDelete;
begin
  If fPergunta('Deseja excluir o lote '+cdsChapas.FieldByName('LOTE').AsString+'?') then
   cdsChapas.Delete;

 If Not blnDividindoChapa Then
  pRecalculaNomeLote;
end;

procedure TEnderecamentoMarmoreGranito.pMontaInsertLote;
begin
  qryComand.SQL.Clear;
  qryComand.SQL.Add('INSERT INTO CADLOT (');
  qryComand.SQL.Add('AUTOINCREM,');
  qryComand.SQL.Add('LOT_NUMLOT,');
  qryComand.SQL.Add('LOT_CODEMP,');
  qryComand.SQL.Add('LOT_CODITE,');
  qryComand.SQL.Add('LOT_DTAFAB,');
  qryComand.SQL.Add('LOT_DTAVAL,');
  qryComand.SQL.Add('LOT_DTABAL,');
  qryComand.SQL.Add('LOT_SALBAL,');
  qryComand.SQL.Add('LOT_SALDOS,');
  qryComand.SQL.Add('LOT_ML_BAL,');
  qryComand.SQL.Add('LOT_SAL_ML,');
  qryComand.SQL.Add('LOT_SALCON,');
  qryComand.SQL.Add('LOT_DIGCON,');
  qryComand.SQL.Add('LOT_ORDCON,');
  qryComand.SQL.Add('LOT_DIFSAL,');
  qryComand.SQL.Add('LOT_LOCFIS,');
  qryComand.SQL.Add('LOT_CHAPA_,');
  qryComand.SQL.Add('LOT_NCHAPA,');
  qryComand.SQL.Add('LOT_MEDB_L,');
  qryComand.SQL.Add('LOT_MEDB_A,');
  qryComand.SQL.Add('LOT_MEDL_L,');
  qryComand.SQL.Add('LOT_MEDL_A,');
  qryComand.SQL.Add('LOT_ESPESS,');
  qryComand.SQL.Add('LOT_PREVE1,');
  qryComand.SQL.Add('LOT_MARORI,');
  qryComand.SQL.Add('LOT_PRVEE1,');
  qryComand.SQL.Add('LOT_VETOE1,');
  qryComand.SQL.Add('LOT_VENTO1)VALUES(');
  qryComand.SQL.Add(':AUTOINCREM,');
  qryComand.SQL.Add(':LOT_NUMLOT,');
  qryComand.SQL.Add(':LOT_CODEMP,');
  qryComand.SQL.Add(':LOT_CODITE,');
  qryComand.SQL.Add(':LOT_DTAFAB,');
  qryComand.SQL.Add(':LOT_DTAVAL,');
  qryComand.SQL.Add(':LOT_DTABAL,');
  qryComand.SQL.Add(':LOT_SALBAL,');
  qryComand.SQL.Add(':LOT_SALDOS,');
  qryComand.SQL.Add(':LOT_ML_BAL,');
  qryComand.SQL.Add(':LOT_SAL_ML,');
  qryComand.SQL.Add(':LOT_SALCON,');
  qryComand.SQL.Add(':LOT_DIGCON,');
  qryComand.SQL.Add(':LOT_ORDCON,');
  qryComand.SQL.Add(':LOT_DIFSAL,');
  qryComand.SQL.Add(':LOT_LOCFIS,');
  qryComand.SQL.Add(':LOT_CHAPA_,');
  qryComand.SQL.Add(':LOT_NCHAPA,');
  qryComand.SQL.Add(':LOT_MEDB_L,');
  qryComand.SQL.Add(':LOT_MEDB_A,');
  qryComand.SQL.Add(':LOT_MEDL_L,');
  qryComand.SQL.Add(':LOT_MEDL_A,');
  qryComand.SQL.Add(':LOT_ESPESS,');
  qryComand.SQL.Add(':LOT_PREVEN,');
  qryComand.SQL.Add(':LOT_MARORI,');
  qryComand.SQL.Add(':LOT_PREVEE,');
  qryComand.SQL.Add(':LOT_VENTOE,');
  qryComand.SQL.Add(':LOT_VENTOT)');
End;

function TEnderecamentoMarmoreGranito.fGetSqlIteGer: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  G.*, C.ITE_CNV_ML, C.ITE_CODMAR , C.ITE_DESITE, C.ITE_REFERE, C.ITE_CODUNI, C.ITE_CODFOR, C.ITE_INCPIS ';

  Result := Result + 'FROM ';
  Result := Result + '  ITEGER G ';
  Result := Result + ' INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + 'WHERE ';
  Result := Result + '  G.ITE_CODITE = :CODITE AND ';
  Result := Result + '  G.ITE_CODEMP = :CODEMP ';
end;

procedure TEnderecamentoMarmoreGranito.pGeraAjuste;
var strNumDocAJ: String;
    fltCalculaTotGer: Double;
    blnResult: Boolean;
    strAutIncTmp,
    strAutInc,
    strCodCli,
    strCliEst: String;
begin
  qryConsulta.SQl.Clear;

  qryConsulta.SQL.Add('SELECT LOTMAR.*, ');
  qryConsulta.SQL.Add('       SUM(LOT_PERDAS) AS LOT_QTDPER, ');
  qryConsulta.SQL.Add('       ITE_PRECUS  ');
  qryConsulta.SQL.Add('  FROM LOTMAR');
  qryConsulta.SQL.Add(' INNER JOIN ITEGER ON ITE_CODITE = LOT_CODITE AND ITE_CODEMP = LOT_CODEMP');
  qryConsulta.SQL.Add(' WHERE LOT_IDENTI = "'+strChaveLoteTemporario+'"');
  qryConsulta.SQL.Add('   AND LOT_PERDAS > 0');
  qryConsulta.SQL.Add(' GROUP BY LOT_CODITE');



  qryConsulta.Open;


  If qryConsulta.IsEmpty Then
    Exit;

  strCodCli := fCfgSis('CLIAJU');
  strCliEst := fRetEstadoCliente(strCodCli);
  fltCalculaTotGer := 0;

  while not qryConsulta.Eof Do
  Begin
    fltCalculaTotGer := fltCalculaTotGer + qryConsulta.FieldByName('ITE_PRECUS').AsFloat * qryConsulta.FieldByName('LOT_QTDPER').AsFloat;
    qryConsulta.Next;
  End;


  strNumDocAJ := fRetSequencial('PRO_AJ', VS_strCodEmp, fTamDocCadRec);
  qryConsulta.First;
  qryConIte.Close;
  qryConIte.SQL.Clear;
  qryConIte.SQL.Add(fGetSqlIteGer);

  blnResult := fGravaMovGer_Aux(strAutInc, fltCalculaTotGer, strNumDocAJ, strCodCli, strCliEst);
  If blnResult Then
  Begin
    while not qryConsulta.EoF do
    Begin
      qryConIte.Close;
      qryConIte.ParamByName('CODITE').AsString := qryConsulta.FieldByName('LOT_CODITE').AsString;
      qryConIte.ParamByName('CODEMP').AsString := qryConsulta.FieldByName('LOT_CODEMP').AsString;
      qryConIte.Open;

      strAutIncTmp := '';

      blnResult :=  fGravaMovDet_Aux(strNumDocAJ, strAutInc, strCodCli, strCliEst);
      fAtualizaEstoqueCadIte(qryConsulta.FieldByName('LOT_CODITE').AsString,
                             'S',
                             qryConsulta.FieldByName('LOT_QTDPER').AsFloat,
                             0.0,
                             fGetLoteCorreto, False);
      qryConsulta.Next;
      If Not blnResult Then
        Exit;
      ReprocessarItem(qryConsulta.FieldByName('LOT_CODITE').AsString, '', False);
    End;

    qryComand.SQL.Clear;
    qryComand.SQL.Add('INSERT INTO AJPEMA (PEM_INCAJU, PEM_INCENT)VALUES(:PEM_INCAJU, :PEM_INCENT)');
    qryComand.ParamByName('PEM_INCAJU').AsString := strAutInc;
    qryComand.ParamByName('PEM_INCENT').AsString := cdsDados.FieldByName('SEQGER').AsString;
    qryComand.ExecSQL;
  End;
  If Not blnResult Then
     Raise Exception.Create('Falha ao garavar o Ajuste de estoque das perdas');
end;


function TEnderecamentoMarmoreGranito.fGetLoteCorreto: String;
Begin
  If blnDividindoChapa Then
    result :=  objDivideChapa.FstrNumLotPadrao
  Else
   result := 'A DEFINIR';
End;

function TEnderecamentoMarmoreGranito.fGravaMovGer_Aux(var strAutInc: String; fltCalculaTotGer: Double; strNumDocAJ, strCodCli, strCliEst: String): Boolean;
  var
    arrDuplic   : TarrDuplicata;
begin
  recServicos.fltRedIss := 0;
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);
    Result := fGravaMovGer(strAutInc,                                                     // Auto Incremento (Retorno)
                           strNumDocAJ,                      // Numero Documento
                           'AJ',                                                // Espécie
                           VS_strCodEmp,                                                  // Empresa
                           '',                                                            // Transportadora
                           strLoginUsuarioLogado,                                                     // Vendedor
                           '',                                                            // Fornecedor
                           strCodCli,                                                // Cliente
                           'C',                                                           // Tipo ((C)liente / (F)ornecedor)
                           VS_Date,                                                     // Data da Entrada
                           fTime(),                                                       // Hora da Entrada
                           VS_Date,                                                       // Data do Documento
                           '01000',                                                       // Condição de Pagamento
                           strCliEst,                                                     // Estado do Cliente / Fornecedor
                           '',                                                            // Nome do Consumidor
                           '',                                                            // Endereço do Consumidor
                           '',                                                            // Bairro do Consumidor
                           '',                                                            // Cep do Consumidor
                           '',                                                            // Cidade do Consumidor
                           '',                                                            // Estado do Consumidor
                           '',                                                            // Telefone do Consumidor
                           0,
                           '',                                                            // CNPJ / CGC
                           '',                                                            // CNPJ / CGC do consumidor
                           '',                                                            // Inscrição estadual do Consumidor
                           '',                                                            // RG do consumidor
                           0.0,                                                           // Base Simples Paulista
                           0.0,                                                           // Base de IPI
                           0.0,                                                           // Aliquota de IPI
                           0.0,                                                           // Total de IPI
                           0.0,                                                           // Base de ICMS
                           0.0,                                                           // Aliquota de ICMS
                           0.0,                                                           // Total de ICMS
                           0.0,                                                           // Valor de Substituição
                           0.0,                                                           // Aliquota de Substituição
                           0.0,                                                           // Base de Substituição
                           0.0,                                                           // Base de Substituição Simulada
                           0.0,                                                           // Desconto Especial
                           Abs(fltCalculaTotGer),                              // Valor Contábil
                           Abs(fltCalculaTotGer),                              // Total dos Itens
                           0.0,                                                           // Total de Custo
                           0.0,                                                           // Total Médio
                           '',                                                            // Tipo de Frete
                           0.0,                                                           // Valor do Frete
                           0.0,                                                           // Peso Bruto
                           0.0,                                                           // Peso Liquido
                           0.0,                                                           // Volume
                           '',                                                            // Especie
                           '',                                                            // Marca
                           '',                                                // Mensagem 1
                           '',                                                // Mensagem 2
                           '',                                                            // Mensagem 3
                           '',                                                            // Mensagem 4
                           '',                                                            // Mensagem 5
                           False,                                                     // Indica se Faturado ou nao

                           'AJ',                               // Tipo de Faturamento
                           EmptyStr,                         // Numero de Faturamento
                           EmptyStr,                        // Empresa dd Faturamento
                           0,                                    // Data de Faturamento
                           EmptyStr,                           // Vendedor do Faturamento
                           EmptyStr,                             // Condição de Pagamento do Faturamento
                           False,                                                         // Devolução Especial
                           0.0,         // Valor do Faturamento
                           0.0,                                                           // Valor Parcela 01
                           0.0,                                                           // Valor Parcela 02
                           0.0,                                                           // Valor Parcela 03
                           0.0,                                                           // Valor Parcela 04
                           0.0,                                                           // Valor Parcela 05
                           0.0,                                                           // Valor Parcela 06
                           0.0,                                                           // Valor Parcela 07
                           0.0,                                                           // Valor Parcela 08
                           0.0,                                                           // Valor Parcela 09
                           0.0,                                                           // Valor Parcela 10
                           0.0,                                                           // Valor Parcela 11
                           0.0,                                                           // Valor Parcela 12
                           arrDuplic,
                           '',                                                            // Série
                           'N',                                                           // Nota Especial
                           '9999',                                                        // Classificação Fiscal 1
                           '',                                                            // Classificação Fiscal 2
                           '',                                                            // Classificação Fiscal 3
                           '',                                                            // Natureza da Operação
                           0.0,                                                           // Percentual de Desconto
                           strLoginUsuarioLogado,                                                     // Codigo do Digitador
                           '',                                                            // Codigo da Condição
                           '',                                                            // Forma de Pagamento
                           0.0,                                                           // Fator para meia nota
                           recServicos,
                           0.0,                                                           // Despesa acessoria
                           '',                                                            // Origem do Documento (V)enda (D)evolução
                           'N',                                                           // Usa controle de entrega
                           '',                                                            // Representante
                           0.0,                                                           // Aliquota do IRPF (SERVIÇO)
                           0.0,                                                           // Valor do IRPF (SERVIÇO + PRODUTO)
                           0.0,                                                           // Aliquota do Pis (SERVIÇO)
                           0.0,                                                           // Valor do Pis (SERVIÇO + PRODUTO)
                           0.0,                                                           // Aliquota do Cofins (SERVIÇO)
                           0.0,                                                           // Valor do Cofins (SERVIÇO + PRODUTO)
                           0.0,                                                           // Aliquota do CSLL (SERVIÇO)
                           0.0,                                                           // Valor do CSLL (SERVIÇO + PRODUTO)
                           0.0,                                                           // Valor de IRPF que foi retido
                           0.0,                                                           // Valor de PIS que foi retido
                           0.0,                                                           // Valor de COFINS que foi retido
                           0.0,                                                           // Valor de CSLL que foi retido
                           '',                                                            // Notas de Documentos Acumulados
                           0.0,                                                           // Aliquota do IRPF (PRODUTOS)
                           0.0,                                                           // Aliquota do PIS (PRODUTOS)
                           0.0,                                                           // Aliquota do COFINS (PRODUTOS)
                           0.0,                                                           // Aliquota do CSLL (PRODUTOS)
                           0.0,                                                           // Valor de SERVIÇO que foi retido
                           '',                                                            // Notas de documentos acumulados (SERVIÇO)
                           0.0,                                                           // Percentual da Seguridade Social
                           0.0,                                                           // Valor da Seguridade Social
                           0.0,                                                           // Valor do IRPF Retido (Produto)
                           0.0,                                                           // Valor do IRPF Devido (Produto)
                           0.0,                                                           // Valor do IRPF Retido (Serviço)
                           0.0,                                                           // Valor do IRPF Devido (Serviço)
                           0.0,                                                           // Valor do PIS Retido (Produto)
                           0.0,                                                           // Valor do PIS Devido (Produto)
                           0.0,                                                           // Valor do PIS Retido (Serviço)
                           0.0,                                                           // Valor do PIS Devido (Serviço)
                           0.0,                                                           // Valor do COFINS Retido (Produto)
                           0.0,                                                           // Valor do COFINS Devido (Produto)
                           0.0,                                                           // Valor do COFINS Retido (Serviço)
                           0.0,                                                           // Valor do COFINS Devido (Serviço)
                           0.0,                                                           // Valor do CSLL Retido (Produto)
                           0.0,                                                           // Valor do CSLL Devido (Produto)
                           0.0,                                                           // Valor do CSLL Retido (Serviço)
                           0.0,                                                           // Valor do CSLL Devido (Serviço)
                           '',                                                            // Ordem de Produção
                           0.0,                                                           // Base Orgão Público
                           0.0,                                                           // ICMS Orgão Público
                           0,                                                             // Número do Conhecimento de Frete
                           '',                                                            // Consumidor final
                           'N',                                                           // Entrega no Faturamento
                           '',                                                            // Cliente de Faturamento
                           '',                                                            // Operador da Expedição
                           '',                                                            // Separador da Expedição
                           '',                                                            // Tabela de Preços utilizada
                           '',
                           'N',                                                           // Entrega Futura
                           FALSE,                                                         // Baixa de Entrega Futura
                           0,                                                             // Margem de Lucro
                           0.0,                                                           // Base do retido (caso tivesse) com ipi e frete de entrada
                           0.0,                                                           // Valor do retido considerando a base acima.
                           'N',                                                           // Gerar produção fora da loja
                           '',                                                            // Numero do Registro - Correios ou Transportadora
                           VS_Date,                                                       // Data de Entrega no Romaneio
                           '',                                                            // Classificação fiscal 4
                           'N',                                                           // AUTO-SERVIÇO
                           '',                                                            // Evento
                           '',                                                            // AUTINC ENDEREÇO DE ENTREGA
                           '',                                                            // Conteúdo do CNFNFE
                           '',                                                            // Motivo da Devolução
                           '',
                           True,                                                          // Imprime Duplicatas na NF-e
                           0,                                                             //  fltValCre: Double    = 0;
                           0,                                                             //  dtadtlBex: TDateTime = 0;
                           '',                                                            //  strEmlCon: String    = '';
                           0,                                                             //  dtaDtESNf: TDateTime = 0;
                           0,                                                             //  tmrHrESNf: TDateTime = 0;
                           nil,                                                           //  objFinanc: Pointer = Nil;
                           '',                                                            //  strDocCon: String = '';
                           '',                                                            //  strCodObr: String = '';
                           '',                                                            //  strCodArt: String = '';
                           'N',                                                           //  strPermut: String = 'N';
                           '',                                                            //  strRetIss: String = '';
                           '',                                                            //  strOpcDoc: String = '';
                           0,                                                             //  fltFreSug: Double = 0;
                           '',                                                            //  strNumAde: String = '';
                           0,                                                             //  fltBasAnt: Double = 0;
                           0,                                                             //  fltValAnt: Double = 0;
                           '',                                                            //  strNaoAtu: String = '';
                           '',                                                            //  strEntUrg: String = '';
                           '',                                                            //  strMenExp: String = '';
                           '',                                                            //  strMenEx2: String = '';
                           '',                                                            //  strMenEx3: String = '';
                           '',                                                            //  strMenEx4: String = '';
                           0,                                                             //  fltDupRec: Double = 0;
                           0,                                                             //  fltValAdt: Double = 0;
                           0,                                                             //  fltDeDVCf: Double = 0;
                           '',                                                            //  strPlaVei: String = '';
                           '',                                                            //  strKm_Vei: String = '';
                           '',                                                            //  strCliOri: String = '';
                           '',                                                            //  strCodMot: String = '';
                           '',                                                            //  strBetone: String = '';
                           '',                                                            //  strLacre_: String = '';
                           '',                                                            //  strTipMps: String = '';
                           '',                                                            //  strAbatim: String = '';
                           '',                                                            //  strBrita_: String = '';
                           '',                                                            //  strConBom: String = '';
                           0,                                                             //  intFckDia: Integer = 0;
                           0,                                                             //  fltImpPag: Double = 0;
                           0,                                                             //  intPrzMed: integer = 0;
                           False,                                                         //  blnImpPdv: Boolean = False;
                           False,                                                         //  blnDTEXREP: Boolean = False;
                           '',                                                            //  strChvNfeDev: String = '';
                           '',                                                            //  strOpeSol: String = '';
                           False,                                                         //  blnEst_Dv: Boolean = False;
                           '',                                                            //  strNumCOODev: String = '';
                           '',                                                            //  strNumSerDev: String = '';
                           '',                                                            //  strNumUSUDev: String = '';
                           '',                                                            //  strTipDocDev: String = '';
                           0,                                                             //  fltTotDif: Double = 0;
                           nil,                                                           //  objFazenda: Pointer = nil;
                           0,                                                             //  fltFedImp : Double = 0;
                           0,                                                             //  fltEstImp : Double = 0;
                           0,                                                             //  fltMunImp : Double = 0;
                           0,                                                             //  fltTroco_: Double = 0;
                           '',                                                            //  strObsNfeFis: String = '';
                           'N',                                                           //  strVenPre: String = 'N';
                           cdsDados.FieldByName('SEQGER').AsString);

  If Result Then
    objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');
end;

function TEnderecamentoMarmoreGranito.fGravaMovDet_Aux(strNumDocAJ, strAutInc, strCodCli, strCliEst: String) : Boolean;
var strAutIncTmp: String;
    fltCnv_Ml: Integer;
begin
  fltCnv_Ml := 1;
  Result := fGravaMovDet(strAutIncTmp,                                                // Retorna Auto-Incremento por Referencia
                         strAutInc,                                                   // Sequencial do Arquivo Geral
                         strNumDocAJ,                    // Numero Documento
                         'AJ',                                              // Espécie
                         qryConsulta.FieldByName('LOT_CODEMP').AsString,                                                // Empresa
                         qryConsulta.FieldByName('LOT_CODITE').AsString,                          // Cód. Item
                         'AUT',                                                   // Vendedor
                         '',                                                          // Código Diversos
                         qryConIte.FieldByName('ITE_CODMAR').AsString,                          // Código da Marca
                         '',                                                          // Fornecedor
                         strCodCli,                                              // Cliente
                         VS_Date,                                                   // Data da Entrada
                         fTime(),                                                     // Hora da Entrada
                         VS_Date,                                                     // Data do Documento
                         '01000',                                                     // Condição de Pagamento
                         'C',                                                         // Tipo: (C)liente / (F) Fornecedor
                         strCliEst,                                                    // Estado do Fornecedor
                         qryConIte.FieldByName('ITE_DESITE').AsString,                          // Descrição do Item
                         qryConIte.FieldByName('ITE_REFERE').AsString,                          // Referência do Item
                         qryConIte.FieldByName('ITE_CODUNI').AsString,                          // Cód. Unidade
                         qryConIte.FieldByName('ITE_CODFOR').AsString,                // Fornecedor Item
                         qryConsulta.FieldByName('LOT_QTDPER').AsFloat,                           // Quantidade do Item
                         qryConsulta.FieldByName('LOT_PRVMAP').AsFloat,                           // Valor Unitario
                         qryConIte.FieldByName('ITE_PRECUS').AsFloat,                           // Valor Unitário Original
                         qryConIte.FieldByName('ITE_PRECUS').AsFloat,                           // Valor Unitário Original sem juros
                         qryConIte.FieldByName('ITE_PRECUS').AsFloat * qryConsulta.FieldByName('LOT_QTDPER').AsFloat,    // Total do Item
                         qryConIte.FieldByName('ITE_PRECUS').AsFloat * qryConsulta.FieldByName('LOT_QTDPER').AsFloat,    // Valor Contábil do Item

                         ((qryConIte.FieldByName('ITE_PRECUS').AsFloat) / fltCnv_Ml) * qryConsulta.FieldByName('LOT_QTDPER').AsFloat, // Valor Total de Custo

                         (qryConIte.FieldByName('ITE_PREMED').AsFloat / fltCnv_Ml) * qryConsulta.FieldByName('LOT_QTDPER').AsFloat, // Valor Total Medio

                         0.0,                                                         // % Desconto do Item
                         0.0,                                                         // Valor do Frete
                         0.0,                                                         // Valor do Desconto Especial
                         '',                                                          // Código do Representante
                         '',                                                          // Código do Vendedor 2
                         0.0,                                                         // Percentual de Comissão do Vendedor
                         0.0,                                                         // Total de Comissão do Vendedor
                         0.0,                                                         // Total de Comissão do Vendedor 2
                         '5999',                                                   // Classificação Fiscal
                         '',                                                          // Código Fiscal
                         0.0,                                                         // Valor IPI
                         0.0,                                                         // Aliquota IPI
                         0.0,                                                         // Base IPI
                         0.0,                                                         // Valor de ICMS
                         0.0,                                                         // Aliquota de ICMS
                         0.0,                                                         // Base de ICMS
                         0.0,                                                         // Valor de Substituição
                         0.0,                                                         // Aliquota de Substituição
                         0.0,                                                         // Base de Substituição
                         0.0,                                                         // Total de Peso
                         0.0,                                                         // Percentual de Base de ICMS
                         0.0,                                                         // Percentual de Redução de Base
                         False,                                                       // Indica se ja esta Faturado
                         EmptyStr,                              // Tipo de Faturamento
                         EmptyStr,            // Numero de Faturamento
                         EmptyStr,            // Empresa dd Faturamento
                         0,            // Data de Faturamento
                         EmptyStr,            // Vendedor do Faturamento
                         EmptyStr,            // Condição de Pagamento do Faturamento
                         0.0,       // Valor do Faturamento
                         'NOR',                                                       // Identificação Produto ( Normal / Outros )
                         qryConIte.FieldByName('ITE_INCPIS').AsString,                // Indice se incide Pis
                         '',                                                          // Série
                         0.0,                                                         // Valor de Despesa Acessória
                         'N',                                                         // Nota Especial
                         '',                                                          // Documento da Devolução
                         '',                                                          // Espécie da Devolução
                         '',                                                          // Empresa da Devolução
                         '',                                                          // Item de Chamada (TINTA DE MAQUINA)
                         '',                                                          // Item da Tinta (TINTA DE MAQUINA)
                         '',                                                          // Descrição da Cor (TINTA DE MAQUINA)
                         '',                                                          // Tipo de Embalagem (TINTA DE MAQUINA)
                         0.0,                                                         // Quantidade de Embalagem (TINTA DE MAQUINA)
                         0.0,                                                         // Preço da Embalagem (TINTA DE MAQUINA)
                         '',                                                          // Tipo de Preço (TINTA DE MAQUINA)
                         0.0,                                                         // Preço de Venda da Tinta (TINTA DE MAQUINA)
                         0.0,                                                         // Preço de Compra da Tinta (TINTA DE MAQUINA)
                         0.0,                                                         // Fator da Tinta (TINTA DE MAQUINA)
                         '',                                                          // Produto Embalagem (TINTA DE MAQUINA)
                         strLoginUsuarioLogado,                                                   // Código do Digitador
                         '',                                                          // Codigo da Condição
                         '',                                                          // Forma de Pagamento
                         '',                                                          // Item da Embalagem
                         '',                                                          // Grupo do Item da Embalagem
                         0,                                                           // Quarto da Lazzumiz
                         'N',                                                         // É item em promoção?
                         '',                                                          // Tipo de Tinta
                         0.0,                                                         // Quantidade de Pulsos
                         '',                                                          // Número do pedido de compras
                         '',                                                          // Origem do documento
                         '',                                                          // Pedido de Venda - Número
                         '',                                                          // Pedido de Venda - Espécie
                         '',                                                          // Pedido de Venda - Empresa
                         0,                                                           // Pedido de Venda - Sequencial
                         '',                                                          // Ordem de Produção
                         '',                                                          // Descrição para Nota Fiscal Especial
                         '',
                         0,
                         0,
                         0.0,                                                         // Volume a produzir (Tinta de Máquina Venda Dinâmica)
                         '',
                         '',
                         False,  // PROD ACABADO
                         False, // FILKAR
                         '',                                                          //  Especie da Entrega Fututa
                         '',                                                          //  Documento da Entrega Fututa
                         '',
                         '',                                                          //  Empresa da Entrega Fututa
                         '',
                         '',
                         '',
                         '',
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0,
                         'N',
                         '',
                         0,

                         ((qryConIte.FieldByName('ITE_PRECUS').AsFloat) / fltCnv_Ml) * qryConsulta.FieldByName('LOT_QTDPER').AsFloat, // Valor Total de Custo 2

                         0,
                         0,
                         '',
                         fGetLoteCorreto,
                         'N',
                         0,
                         0,
                         0,
                         (qryConIte.FieldByName('ITE_PREULT').AsFloat / fltCnv_Ml) * qryConsulta.FieldByName('LOT_QTDPER').AsFloat, // fltTotUlt
                         (qryConIte.FieldByName('ITE_IMPULT').AsFloat / fltCnv_Ml) * qryConsulta.FieldByName('LOT_QTDPER').AsFloat, // fltImpUlt
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
                         0,  // fltUniTab
                         '', // strLot_TA
                         0,  // fltConFre
                         0,  // fltBasAnt
                         0,  // fltIcmAnt
                         0,  // fltVendor
                         0,  // fltOutDes
                         0,  // fltVlGnre
                         'P',
                         qryConIte.FieldByName('ITE_PRECUS').AsFloat * qryConsulta.FieldByName('LOT_QTDPER').AsFloat,  // fltOutIcm
                         0,         // fltIseIcm
                         0,         // fltFreSug
                         '',        // strCodMot
                         '',        // strNatPis
                         '',        // strNatCof
                         '',        // strSeqGad
                         0,         // fltOutVal
                         0,         // fltIcmSai
                         0,         // fltImpFed
                         0,         // fltDesOpe
                         0,         // fltQtdExp
                         '',        // strNumCmp
                         0,         // intNItCmp
                         0,         // fltDeDVCf
                         '',        // strCodMec
                         'N',       // strAntPro
                         'N',       // strAntFre
                         0,         // fltMedAnt
                         0,         // fltPreAnt
                         0,         // fltImpAnt
                         '',        // strSeqAnt
                         'N',       // strRICMPR
                         0,         // fltComLiq
                         '',        // strNcmTin
                         0,         // fltValIva
                         'N',       // strCliBus
                         '',        // strTurEnt
                         'NOR',     // strIdeDev
                         0,         // fltPeBaST
                         0,         // fltVal_RT
                         0,         // fltDesCli
                         0,         // fltImpPag
                         0,         // fltTaxJur
                         0,         // fltSerRat
                         '',        // strProBri
                         0,         // fltPonBri
                         0,         // fltValDif
                         0,         // fltVaFrAn
                         '',        // strLotAba
                         0,         // fltFedImp
                         0,         // fltEstImp
                         0,         // fltMunImp
                         '',        // strIncDev
                         'N',       // strBrinde
                         '',        // strCodPar
                         '',        // strTipBri
                         0,         // fltIcmOrg
                         '',        // strBaqtze
                         '',        // strIncFut
                         0,         // fltValFle
                         0,         // fltTaxEnt
                         0,         // fltVrdIcm
                         0,         // fltBasVrd
                         '',        // strMtdIcm
                         'N',       // strBxSbIt
                         '',        // strIteAbf
                         'N',       // strAtivac
                         0,         // intSeqCom
                         0,         // fltVICMDe
                         '',        // strNcmIte
                         0,         // fltComDig
                         0,         // fltPerDig
                         0,         // fltIcmPav
                         False,     // blnIcmSai
                         0,         // fltAlDifa
                         '',        // strAutSai
                         0,         // fltBFCPST
                         0,         // fltPFCPST
                         0,         // fltVFCPST
                         '',        // strDadSep
                         '',        // strAutEle
                         '',        // strNotUlt
                         0,         // fltPICMEF
                         0,         // fltBICMEF
                         0,         // fltAICMEF
                         0,         // fltVICMEF
                         0,         // fltBSTANT
                         0,         // fltVSTANT
                         '',        // strNotC17
                         0,         // fltAlq922
                         0,         // fltDesCnd
                         '',        // strProEsp
                         '',        // strCodPro
                         '',        // strInc_Pd
                         0,         // fltSICMEF
                         0,   // fltValTCI:
                         0,   // fltCalTCI:
                         0,   // fltVal_TS:
                         '',        // strExtFul
                         '');        // strCodExt
end;

procedure TEnderecamentoMarmoreGranito.pGeraLotes;
begin
  frmGravando.Caption := 'Atualizando cadastro de lotes...';

  qryConsulta.SQl.Clear;
  qryConsulta.SQL.Add('SELECT * FROM LOTMAR WHERE LOT_IDENTI = "'+strChaveLoteTemporario+'"');
  qryConsulta.Open;
  pgbStatusCtrl.Properties.Max := qryConsulta.RecordCount;
  pgbStatusCtrl.Position := 0;
  pMontaInsertLote;
  While Not qryConsulta.Eof Do
  Begin
    If blnDividindoChapa Then
    begin
      If qryConsulta.FieldByName('LOT_NUMLOT').AsString =  objDivideChapa.FstrNumLotPadrao Then
      Begin
        pAtualizaDadosLotePaiDaDivisao;
        qryConsulta.Next;
        continue;
      End
    End;
    qryComand.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', VS_StrCodEmp);
    qryComand.ParamByName('LOT_NUMLOT').AsString   := qryConsulta.FieldByName('LOT_NUMLOT').AsString;
    qryComand.ParamByName('LOT_CODEMP').AsString   := VS_StrCodEmp;
    qryComand.ParamByName('LOT_CODITE').AsString   := qryConsulta.FieldByName('LOT_CODITE').AsString;
    qryComand.ParamByName('LOT_DTAFAB').AsDateTime  := VS_Date;
    qryComand.ParamByName('LOT_DTAVAL').AsDateTime  := IncYear(VS_Date);
    qryComand.ParamByName('LOT_DTABAL').AsDateTime  := VS_Date -1;//Nao pode ser VS_date, na data de balanco nao pode existir movimentacao
    qryComand.ParamByName('LOT_SALBAL').AsFloat    := 0;
    qryComand.ParamByName('LOT_SALDOS').AsFloat    := 0;
    qryComand.ParamByName('LOT_ML_BAL').AsFloat    := 0;
    qryComand.ParamByName('LOT_SAL_ML').AsFloat    := 0;
    qryComand.ParamByName('LOT_SALCON').Value      := Null;
    qryComand.ParamByName('LOT_DIGCON').AsString   := 'N';
    qryComand.ParamByName('LOT_ORDCON').Value      := Null;
    qryComand.ParamByName('LOT_DIFSAL').AsFloat    := 0;
    qryComand.ParamByName('LOT_LOCFIS').AsString   := '';
    qryComand.ParamByName('LOT_CHAPA_').AsString   := 'S';
    qryComand.ParamByName('LOT_NCHAPA').AsString   := qryConsulta.FieldByName('LOT_NCHAPA').AsString;
    qryComand.ParamByName('LOT_MEDB_L').AsFloat   := qryConsulta.FieldByName('LOT_MEDB_L').AsFloat;
    qryComand.ParamByName('LOT_MEDB_A').AsFloat   := qryConsulta.FieldByName('LOT_MEDB_A').AsFloat;
    qryComand.ParamByName('LOT_MEDL_L').AsFloat   := qryConsulta.FieldByName('LOT_MEDL_L').AsFloat;
    qryComand.ParamByName('LOT_MEDL_A').AsFloat   := qryConsulta.FieldByName('LOT_MEDL_A').AsFloat;
    qryComand.ParamByName('LOT_ESPESS').AsFloat   := qryConsulta.FieldByName('LOT_ESPESS').AsFloat;
    qryComand.ParamByName('LOT_PREVEN').AsFloat   := qryConsulta.FieldByName('LOT_PRVMAP').AsFloat;
    qryComand.ParamByName('LOT_VENTOT').AsFloat   := qryConsulta.FieldByName('LOT_PRVMAT').AsFloat;
    qryComand.ParamByName('LOT_PREVEE').AsFloat   := qryConsulta.FieldByName('LOT_PRVENP').AsFloat;
    qryComand.ParamByName('LOT_VENTOE').AsFloat   := qryConsulta.FieldByName('LOT_PRVENT').AsFloat;
    qryComand.ParamByName('LOT_MARORI').AsString  := cdsDados.FieldByName('SEQGER').AsString;

    qryComand.ExecSQL;
    qryConsulta.Next;
    pgbStatusCtrl.Position :=qryConsulta.RecNo -1;
    Application.ProcessMessages;
  End;

End;

procedure TEnderecamentoMarmoreGranito.pAtualizaDadosLotePaiDaDivisao;
var strBackupSQL: String;
begin
  strBackupSQL := qryComand.SQL.Text;
  qryComand.SQL.Clear;
  qryComand.SQL.Add('UPDATE CADLOT SET ');
  qryComand.SQL.Add('LOT_NCHAPA = :LOT_NCHAPA,');
  qryComand.SQL.Add('LOT_MEDB_L = :LOT_MEDB_L,');
  qryComand.SQL.Add('LOT_MEDB_A = :LOT_MEDB_A,');
  qryComand.SQL.Add('LOT_MEDL_L = :LOT_MEDL_L,');
  qryComand.SQL.Add('LOT_MEDL_A = :LOT_MEDL_A,');
  qryComand.SQL.Add('LOT_ESPESS = :LOT_ESPESS,');
  qryComand.SQL.Add('LOT_PREVE1 = :LOT_PREVEN,');
  qryComand.SQL.Add('LOT_VENTO1 = :LOT_VENTOT,');
  qryComand.SQL.Add('LOT_PRVEE1 = :LOT_PREVEE,');
  qryComand.SQL.Add('LOT_VETOE1 = :LOT_VENTOE');
  qryComand.SQL.Add('WHERE LOT_NUMLOT = "'+objDivideChapa.FstrNumLotPadrao+'"');
  qryComand.SQL.Add(' AND LOT_CODEMP =  "'+objDivideChapa.FStrCodEmp+'"');
  qryComand.SQL.Add(' AND LOT_CODITE =  "'+objDivideChapa.FStrCodIte+'"');
  qryComand.ParamByName('LOT_NCHAPA').AsString   := qryConsulta.FieldByName('LOT_NCHAPA').AsString;
  qryComand.ParamByName('LOT_MEDB_L').AsFloat   := qryConsulta.FieldByName('LOT_MEDB_L').AsFloat;
  qryComand.ParamByName('LOT_MEDB_A').AsFloat   := qryConsulta.FieldByName('LOT_MEDB_A').AsFloat;
  qryComand.ParamByName('LOT_MEDL_L').AsFloat   := qryConsulta.FieldByName('LOT_MEDL_L').AsFloat;
  qryComand.ParamByName('LOT_MEDL_A').AsFloat   := qryConsulta.FieldByName('LOT_MEDL_A').AsFloat;
  qryComand.ParamByName('LOT_ESPESS').AsFloat   := qryConsulta.FieldByName('LOT_ESPESS').AsFloat;
  qryComand.ParamByName('LOT_PREVEN').AsFloat   := qryConsulta.FieldByName('LOT_PRVMAP').AsFloat;
  qryComand.ParamByName('LOT_VENTOT').AsFloat   := qryConsulta.FieldByName('LOT_PRVMAT').AsFloat;
  qryComand.ParamByName('LOT_PREVEE').AsFloat   := qryConsulta.FieldByName('LOT_PRVENP').AsFloat;
  qryComand.ParamByName('LOT_VENTOE').AsFloat   := qryConsulta.FieldByName('LOT_PRVENT').AsFloat;
  qryComand.ExecSQL;

  qryComand.SQL.Text := strBackupSQL;

End;

function TEnderecamentoMarmoreGranito.fConfirmaEnderecamentoAux(pgbStatus: TcxProgressBar = Nil): Boolean;
var
  strCodErrosAuditoria: String;
begin
  Result := blnDividindoChapa;
  If not Result Then
    Result := fTodosOsItensStatusOk;

  If Result Then
  Begin
    pgbStatusCtrl :=  pgbStatus;
    Try
      objAuditoriaSaldo.Limpar;

      fStartTransaction;
      pGeraLotes;
      pGeraAjuste;
      pGeraTransferencia;
      pDeletaReserva;
      pMarcaRoboRecalculoSaldo;
      pRemoveLotmar;

      If (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
      Begin
        Result := False;
        fRollBack;
        pMostraErrosAuditoria(strCodErrosAuditoria);
        Exit;
      End;

      fCommit;
    Except
      on e: Exception do
      begin
        fRollBack;
        Result := False;
        pMensagensErro(e.message, '[TEnderecamentoMarmoreGranito.fConfirmaEnderecamento]');
      End;
    End;
  End


End;


function TEnderecamentoMarmoreGranito.fTodosOsItensStatusOk: Boolean;
begin
  cdsDados.DisableControls;
  Try
    cdsDados.Filtered := False;
    cdsDados.Filter := 'STATUS <> 1';
    cdsDados.Filtered := True;
    Result := cdsDados.IsEmpty;
    If Not Result Then
      fMensagem('ATENÇÃO!', 'Existe Itens que não foram definidos as chapas!', ['&O k']);
  Finally
    cdsDados.EnableControls;
    cdsDados.Filtered := False;
    cdsDados.Filter := '';
  End;

End;


function TEnderecamentoMarmoreGranito.fConfirmaEnderecamento: Boolean;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := IIf(blnDividindoChapa, 'Efetivando divisão das chapas...','Efetivando Endereçamento...');
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fConfirmaEnderecamentoAux;
    frmGravando.ShowModal;
    result :=  frmGravando.blnConfirma;
  finally
    FreeAndNil(frmGravando);
  End;
end;


procedure TEnderecamentoMarmoreGranito.pMarcaRoboRecalculoSaldo;
begin
  qryComand.SQL.Clear;
  qryComand.SQl.Add('UPDATE ITEGER');
  qryComand.SQl.Add('    INNER JOIN LOTMAR ON ITE_CODITE = LOT_CODITE AND LOTMAR.LOT_CODEMP = ITE_CODEMP');
  qryComand.SQl.Add('    SET ITE_REPAUD = "S"');
  qryComand.SQl.Add('    WHERE LOT_IDENTI = "'+strChaveLoteTemporario+'"');
  qryComand.ExecSQL;
end;

{ TDividirChapa }

function TDividirChapa.fGetSqlChapas(blnVariasChapasPorLote: Boolean): String;
begin
  Result := '';
  Result := Result + 'SELECT DISTINCT ';
  Result := Result + '    CADLOT.LOT_MARORI AS SEQGER, ';
  Result := Result + '    CADLOT.AUTOINCREM AS SEQDET, ';
  Result := Result + '    CAST("S" AS CHAR(1)) AS LOTE_DIVIDO, ';
  Result := Result + '    ' + ReplaceStr(FloatToStr(FQtdChapa), '.', '') + ' AS CHAPA, ';
  Result := Result + '    LOT_MEDB_L AS MEDIDA_BRUTA_LARGURA, ';
  Result := Result + '    LOT_MEDB_A AS MEDIDA_BRUTA_ALTURA, ';
  Result := Result + '    LOT_MEDL_L AS MEDIDA_LIQUIDA_LARGURA, ';
  Result := Result + '    LOT_MEDL_A AS MEDIDA_LIQUIDA_ALTURA, ';
  Result := Result + '    LOT_ESPESS AS ESPESSURA, ';
  Result := Result + '    LOT_PREVE1 AS PRECO_M2, ';
  Result := Result + '    LOT_PRVEE1 AS PRECO_ENTREGA_M2, ';
  If blnVariasChapasPorLote Then
  begin
    Result := Result + '    ' + ReplaceStr(FloatToStr(FQtdChapa), '.', '') + ' * LOT_MEDL_L * LOT_MEDL_A AS QTD_M2_LIQUIDO, ';
    Result := Result + '    ' + ReplaceStr(FloatToStr(FQtdChapa), '.', '') + ' * LOT_PREVE1 * (LOT_MEDL_L * LOT_MEDL_A) AS VALOR_TOTAL_M2, ';
    Result := Result + '    ' + ReplaceStr(FloatToStr(FQtdChapa), '.', '') + ' * LOT_PRVEE1 * (LOT_MEDL_L * LOT_MEDL_A) AS VALOR_TOTAL_ENTREGA_M2, ';
  End
  Else
  Begin
    Result := Result + '    LOT_MEDL_L * LOT_MEDL_A AS QTD_M2_LIQUIDO, ';
    Result := Result + '    LOT_PREVE1 * (LOT_MEDL_L * LOT_MEDL_A) AS VALOR_TOTAL_M2, ';
    Result := Result + '    LOT_PRVEE1 * (LOT_MEDL_L * LOT_MEDL_A) AS VALOR_TOTAL_ENTREGA_M2, ';
  End;
  Result := Result + '    0.00 AS PERDA, ';
  Result := Result + '    0 AS ETIQUETA, ';
  Result := Result + '    LOT_NUMLOT AS LOTE,  ';
  Result := Result + '    CAST(IF(LOT_CHAPA_ = "S", REVERSE(SUBSTRING(REVERSE(LOT_NUMLOT), POSITION("/" IN REVERSE(LOT_NUMLOT)) + 1, LENGTH(LOT_NUMLOT))), "") AS CHAR(30)) AS LOTE_BASE, ';
  Result := Result + '    CAST("" AS CHAR(20)) AS COMPLEMENTO,  ';
  Result := Result + '    C.ITE_CODITE AS CODITE, ';
  Result := Result + '    0.00 AS ESTPER ';
  Result := Result + '  FROM                 ';
  Result := Result + '    CADLOT ';
  Result := Result + '    INNER JOIN CADITE C ON C.ITE_CODITE = LOT_CODITE ';
  Result := Result + '    INNER JOIN ITEGER I ON I.ITE_CODITE = LOT_CODITE AND I.ITE_CODEMP = LOT_CODEMP ';
  Result := Result + '    INNER JOIN CADUNI   ON   UNI_CODUNI = ITE_CODUNI ';
  Result := Result + '    WHERE LOT_NUMLOT = "'+FstrNumLotPadrao+'"';
  Result := Result + '    AND LOT_CODEMP =  "'+FStrCodEmp+'"';
  Result := Result + '    AND LOT_CODITE =  "'+FStrCodIte+'"';
end;

function TDividirChapa.fGetSQLLoteOriginal: String;
begin
  Result := '';
  Result := Result + 'SELECT';
  Result := Result + '    LOT_MARORI AS SEQGER, ';
  Result := Result + '    I.AUTOINCREM AS SEQDET,';
  Result := Result + '    ITE_CODFOR AS DET_CODFOR,';
  Result := Result + '    LOT_CODEMP AS FDO_CODEMP,';
  Result := Result + '    LOT_CODITE AS FDO_CODITE,';
  Result := Result + '    LOT_NUMLOT AS FDO_NUMLOT,';
  Result := Result + '    ITE_DESITE AS FDO_DESCRI,';
  Result := Result + '    ITE_REFERE AS FDO_REFERE,';
  Result := Result + '    UNI_SIGUNI,';
  Result := Result + '    LOT_SALDOS AS FDO_QTDITE,';
  Result := Result + '    I.ITE_SALDOS,';
  Result := Result + '    C.ITE_CODBAR,';
  Result := Result + '    C.ITE_CODFAB,';
  Result := Result + '    C.ITE_DESITE,';
  Result := Result + '    I.ITE_LOCFIS,';
  Result := Result + '    I.ITE_LOCSUP,';
  Result := Result + '    I.ITE_USASER,';
  Result := Result + '    I.ITE_LOCFIS AS LOCTST,';
  Result := Result + '    I.ITE_LOCSUP AS SUPTST,';
  Result := Result + '    I.ITE_LOCFIS AS LOCANT,';
  Result := Result + '    I.ITE_LOCSUP AS SUPANT,';
  Result := Result + '    I.ITE_PREVE' + fCfgSis('TABPMA')+ ' AS PRESUG,';
  Result := Result + '    I.ITE_TAMLCF,';
  Result := Result + '    I.ITE_TAMLCS,';
  Result := Result + '    C.ITE_NVLGIR,';
  Result := Result + '    0 AS DEFSER,';
  Result := Result + '    ' + ReplaceStr(FloatToStr(FQtdChapa), '.', '') + ' AS QTDCHAPA,';
  Result := Result + '    0.00 AS ESTPER,';
  Result := Result + '    LOT_NUMLOT,';
  Result := Result + '    "0" AS DISTRI,                 ';
  Result := Result + '    IFNULL(LOT_SALDOS, 0) + IFNULL(LOT_QTEF_A, 0) + IFNULL(LOT_QTEF_F, 0) + IFNULL(LOT_QTEF_P, 0) AS LOT_SALDOS,';
  Result := Result + '    "N" AS REMLOC,                 ';
  Result := Result + '    0 AS REFUGO,';
  Result := Result + '    I.ITE_QTEF_A AS QTDEFA,  ';
  Result := Result + '    I.ITE_QTEF_F AS QTDEFF,  ';
  Result := Result + '    0  AS GARANT,';
  Result := Result + '    0 STATUS , ';
  Result := Result + '    CAST(IF(LOT_CHAPA_ = "S", REVERSE(SUBSTRING(REVERSE(LOT_NUMLOT), POSITION("/" IN REVERSE(LOT_NUMLOT)) + 1, LENGTH(LOT_NUMLOT))), "") AS CHAR(30)) AS LOTE_BASE, ';
  Result := Result + '    CONVERT("", CHAR(30)) AS AMZDES';
  Result := Result + '  FROM';
  Result := Result + '    CADLOT';
  Result := Result + '    INNER JOIN CADITE C ON C.ITE_CODITE = LOT_CODITE';
  Result := Result + '    INNER JOIN ITEGER I ON I.ITE_CODITE = LOT_CODITE AND I.ITE_CODEMP = LOT_CODEMP';
  Result := Result + '    INNER JOIN CADUNI   ON UNI_CODUNI = ITE_CODUNI';
  Result := Result + '    WHERE LOT_NUMLOT = "'+FstrNumLotPadrao+'"';
  Result := Result + '    AND LOT_CODEMP =  "'+FStrCodEmp+'"';
  Result := Result + '    AND LOT_CODITE =  "'+FStrCodIte+'"';
end;

class procedure TDividirChapa.pIniciaProcessoDivisaoDeChapa(AstrNumLotPadrao: String;
  AQtdChapa, AQtdItem: Double; AStrCodIte: String; AStrCodEmp: String; AProgress: TProgressBar);
var objTEnderecamentoMarmoreGranito: TEnderecamentoMarmoreGranito;
    objDividirChapa : TDividirChapa;
begin
  inherited;
  objDividirChapa := TDividirChapa.Create;
  objTEnderecamentoMarmoreGranito := TEnderecamentoMarmoreGranito.Create(nil);
  Try
   objDividirChapa.FstrNumLotPadrao := AstrNumLotPadrao;
   objDividirChapa.FQtdChapa :=  AQtdChapa;
   objDividirChapa.FQtdItem  := AQtdItem;
   objDividirChapa.FStrCodIte := AStrCodIte;
   objDividirChapa.FStrCodEmp := AStrCodEmp;

   objTEnderecamentoMarmoreGranito.blnDividindoChapa := True;
   objTEnderecamentoMarmoreGranito.objDivideChapa := objDividirChapa;
   objTEnderecamentoMarmoreGranito.pIniciaDadosDivisaoChapa;
   objTEnderecamentoMarmoreGranito.progress :=  AProgress;

   objDividirChapa.pSetaVariaveisControleIncial;

   objTEnderecamentoMarmoreGranito.pAtualizaComplementoLinhaPrincipal;

   If objTEnderecamentoMarmoreGranito.fAbrirDefinicoesDasChapasParaDivisao Then
     objTEnderecamentoMarmoreGranito.fConfirmaEnderecamento

  Finally
    FreeAndNil(objTEnderecamentoMarmoreGranito);
    FreeAndNil(objDividirChapa);
  End;
end;


procedure TDividirChapa.pSetaVariaveisControleIncial;
var strLoteOriginal,
    strLote,
    strIdentificacaoDoLote: String;
    intFinal: integer;
begin
  inherited;
  If FstrLoteBase = '' Then
  Begin
    strLoteOriginal := FstrNumLotPadrao;
    strLote := FstrNumLotPadrao;
    FstrComplemento := '';
    FstrLoteBase := ReverseString(copy(ReverseString(strLote), pos('/' ,ReverseString(strLote)) + 1, Length(strLote)));
    strIdentificacaoDoLote :=  ReplaceStr(strLote , FstrLoteBase+ '/', '');
    intFinal := Pos(' ', strIdentificacaoDoLote);
    If intFinal <= 0 Then
      intFinal := Length(strIdentificacaoDoLote)
    Else
      FstrComplemento :=  Trim(Copy(strIdentificacaoDoLote, intFinal, Length(strIdentificacaoDoLote)));
    strIdentificacaoDoLote :=  Trim(Copy(strIdentificacaoDoLote, 0, intFinal));
    FStrLoteSemComplemento := FstrLoteBase + '/' + strIdentificacaoDoLote;
    Try
      FintNChapa := StrToInt(strIdentificacaoDoLote);
    Except
      FintNChapa := 1;
    End;
  End;
end;

{ TRecChapa }

function TRecChapa.fTodosCamposPreenchidos: Boolean;
begin
  Result := Self.recMedidaBruta.fPreenchido and self.recMedidaLiquida.fPreenchido;
  Result := Result and (fltEspessura > 0);
  Result := Result and (fltPreco_M2 > 0);
end;

procedure TRecChapa.Inicializar;
begin
  strAutInc := EmptyStr;
  strCodIte := EmptyStr;
  strSeqDet := EmptyStr;
  strLote   := EmptyStr;
  strLoteBase := EmptyStr;
  strComplemento := EmptyStr;
  intChapa := 0;
  fltPreco_M2 := 0.0;
  fltEstPer := 0.0;
  recMedidaBruta.fltLargura := 0.0;
  recMedidaBruta.fltAltura  := 0.0;
  recMedidaLiquida.fltLargura := 0.0;
  recMedidaLiquida.fltAltura := 0.0;
  fltEspessura := 0.0;
  fltValorTotalM2 := 0.0;
  fltQtdM2Liquido := 0.0;
  fltQtdPerda := 0.0;
end;

{ TRecMedida }

function TRecMedida.fArea: Double;
begin
  Result := Self.fltLargura * Self.fltAltura;
end;

function TRecMedida.fPreenchido: Boolean;
begin
  Result := (Self.fltLargura > 0) and (self.fltAltura > 0);
end;

end.
