unit Cotacao.ProcessaApi;

interface

uses  Forms, System.Classes, SysUtils, untZClient, untGravando, cxProgressBar, Winapi.Messages,
      ancora.comunicacao, pitstop.comunicacao, Uni, Data.DB,  Winapi.Windows,
      Cotacao.ApiPrecos.ConstAndTypes, SkyPecas.Comunicacao,
      PitStop.Classes.EndPoint, Ancora.Classes.EndPoint,
      SkyPecas.Classes.EndPoint, untCotacaoTypesAndConst;

type

  TOpcoesProcessaApi = (opaReinciaProcesso,
                        opaApenasFornecedorSelecionado,
                        opaTodosFornecedores);


  TOpcProcessoApi = set of TOpcoesProcessaApi;

  TfuncCodForToIndex = function (strCodFor: String): Integer of object;
  TFuncfIndice = function (intContador: Integer): String of object;
  TProcAtualizaStatusCotCFOPitStopAncaora = Procedure  (ASeqger, ACotFor: String; AIdentApi: integer; AStatus: Integer; AHorIni: TDateTime) Of object;


  TProcessaApi = class
  private
    FTemporaryTable: String;
    FfrmGravando : TfrmGravando;
    qryComand: TUniQuery;
    qryForEst: TUniQuery;
    FIncPcmGer : String;
    FCodFor : String;

    FCotacaoPitStop: String;
    FParamns: TParamLista;
    function fProcessaAncora: Boolean;
    function fProcessaPitStop: Boolean;
    function fProcessaSkyPecas: Boolean;
    function fInsereItensConsultaPitStopAux(pgbProgresso: TcxProgressBar): Boolean;
    procedure pInsereConsultaPitStop(ACotacaoPitStop: String; AFornecedor: String; ACotSeqger: String; AHandle: HWND);
    Procedure pInsereItensConsultaPitStop(ACotacaoPitStop: String; AParamns: TParamLista);
    function fProcessaPitStopAux(pgbProgresso: TcxProgressBar): Boolean;
    function fProcessaAncoraAux(pgbProgresso: TcxProgressBar): Boolean;
    function fImportarPrecosAux(pgbProgresso: TcxProgressBar): Boolean;
    function fProcessaSkyPecasAux(pgbProgresso: TcxProgressBar): Boolean;
    function fIniciarSegundaEtapaAux(pgbProgresso: TcxProgressBar): Boolean;
    function fFaturarPedidoAux(pgbProgresso: TcxProgressBar): Boolean;
    procedure pMarcaFaturado(AIdCotacaoPitStop: String);
    procedure pCriaTemporaria(ACodFor: String = '');



  public
    blnReinicia: Boolean;
    cdsFornecedores: TZClient;
    cdsItens: TZClient;
    RedeAncora: TRedeAncora;
    RedePitStop: TRedePitStop;
    RedeSkyPecas: TRedeSkyPecas;
    strNumCot: String;
    funcCodForToIndex: TfuncCodForToIndex;
    funcIndice: TFuncfIndice;
    Handle: HWND;
    StatusPitStopCotacao: TStatusPitStopCotacao;
    SeqGerRes: String;
    FAtualizaStatusCotCFOPitStopAncaora: TProcAtualizaStatusCotCFOPitStopAncaora;
    FCalculaPrecoImp: TCalculaPrecoImp;
    IncluiItensFornec_CopiaSeguranca: TIncluiItensFornec_CopiaSeguranca;

    Constructor Create;
    Destructor Destroy; override;
    function fProcessa(AIdApi: Integer): Boolean;
    class function fDefineProcesso(AOpcPreocessoApi: TOpcProcessoApi): TOpcProcessoApi;
    function fImportarPrecos: Boolean;
    function fIniciarSegundaEtapa: Boolean;
    function fFaturarPedido(ACodFor, AIncPcmGer, ANumCot: String): Boolean;
    procedure pCancelaCotacaoPitStop;
  end;


implementation

uses
  untOpcoesConsultaAPI, untFuncoesSimples;

{ TProcessaApi }


constructor TProcessaApi.Create;
begin
  qryComand := fCriaQuery;
  qryForEst := fCriaQuery;
  FTemporaryTable := '';
end;

destructor TProcessaApi.Destroy;
begin
  Inherited;
  FreeAndNil(qryForEst);
  FreeAndNil(qryComand);
end;

class function TProcessaApi.fDefineProcesso(AOpcPreocessoApi: TOpcProcessoApi): TOpcProcessoApi;
var lfrmOpcoesConsultaAPI: TfrmOpcoesConsultaAPI;

begin
  pCriarFormularios(TfrmOpcoesConsultaAPI, lfrmOpcoesConsultaAPI);
  Try
    lfrmOpcoesConsultaAPI.CheckBox1.Visible := (opaReinciaProcesso in AOpcPreocessoApi);
    lfrmOpcoesConsultaAPI.Showmodal;

    Result := [];
    case lfrmOpcoesConsultaAPI.RadioGroup1.ItemIndex of
      0: Result := Result + [opaApenasFornecedorSelecionado];
      1: Result := Result + [opaTodosFornecedores];
    End;

    If lfrmOpcoesConsultaAPI.CheckBox1.Checked Then
      Result := Result + [opaReinciaProcesso];

  Finally
    FreeAndNil(lfrmOpcoesConsultaAPI);
  End;

end;


function TProcessaApi.fFaturarPedido(ACodFor, AIncPcmGer, ANumCot: String): Boolean;
begin
  strNumCot := ANumCot;
  FIncPcmGer := AIncPcmGer;
  FCodFor := ACodFor;
  FfrmGravando := TfrmGravando.Create(nil);
  Try
    FfrmGravando.lblGravando.Caption := 'Gerando Pedido de Compra Pit Stop...';
    FfrmGravando.fExecutarAcao := fFaturarPedidoAux;
    FfrmGravando.ShowModal;
    Result := FfrmGravando.blnConfirma;
  Finally
    FreeAndNil(FfrmGravando);
  End
end;

function TProcessaApi.fFaturarPedidoAux(pgbProgresso: TcxProgressBar): Boolean;
var qryItensPedido: TUniQuery;
    lParam: TParamLista;
begin
  Result := True;
  qryItensPedido := fCriaQuery;
  lParam := TParamLista.Create;
  Try
    Try
      qryItensPedido.SQL.Add('SELECT PIT_ID_PED, PIT_ID_CON, PIT_CODINT, PCD_QTDITE, CI.CPS_CODBAR, ITE_CODFAB, MAR_DESMAR, PCD_CODITE');
      qryItensPedido.SQL.Add('  FROM PCMGER PG');
      qryItensPedido.SQL.Add(' INNER JOIN PCMDET PD ON PD.PCD_NUMPED = PG.PCG_NUMPED');
      qryItensPedido.SQL.Add('                     AND PD.PCD_CODFOR = PG.PCG_CODFOR');
      qryItensPedido.SQL.Add('                     AND PD.PCD_ESPDOC = PG.PCG_ESPDOC');
      qryItensPedido.SQL.Add('                     AND PD.PCD_CODEMP = PG.PCG_CODEMP');
      qryItensPedido.SQL.Add('                     AND PD.PCD_NUMCTN = PG.PCG_NUMCTN');
      qryItensPedido.SQL.Add(' INNER JOIN COTGER CG ON CG.COT_NUMCOT = PCG_NUMCOT');
      qryItensPedido.SQL.Add(' INNER JOIN CONPIT CP ON CP.CON_COTGER = CG.AUTOINCREM');
      qryItensPedido.SQL.Add('                     AND CP.CON_CODFOR = PG.PCG_CODFOR');
      qryItensPedido.SQL.Add(' INNER JOIN CPSITE CI ON CI.CPS_ID_CON = CP.CON_ID_CON');
      qryItensPedido.SQL.Add('                     AND CI.CPS_CODITE = PD.PCD_CODITE');
      qryItensPedido.SQL.Add(' INNER JOIN RETPIT RP ON RP.PIT_ID_CON = CI.CPS_ID_CON');
      qryItensPedido.SQL.Add('                     AND RP.PIT_CODBAR = CI.CPS_CODBAR');
      qryItensPedido.SQL.Add('                     AND RP.PIT_ETAPAC = ' + IIf(StatusPitStopCotacao = spscPendenteRecotarPreco, '1', '2'));
      qryItensPedido.SQL.Add('INNER JOIN CADITE C ON C.ITE_CODITE =   PD.PCD_CODITE');
      qryItensPedido.SQL.Add('INNER JOIN CADMAR M ON M.MAR_CODMAR = C.ITE_CODMAR');
      qryItensPedido.SQL.Add(' WHERE PG.AUTOINCREM = "'+FIncPcmGer+'"');
      qryItensPedido.SQL.Add('   AND CP.CON_STATUS <> -1 ');
      qryItensPedido.Open;
      If not qryItensPedido.IsEmpty Then
      Begin
        lParam.idCotacao := qryItensPedido.FieldByName('PIT_ID_CON').AsString;
        while not qryItensPedido.Eof Do
        Begin
          lParam.pAddItemConsulta(qryItensPedido.FieldByName('PCD_CODITE').AsString,
                                  qryItensPedido.FieldByName('ITE_CODFAB').AsString,
                                  qryItensPedido.FieldByName('MAR_DESMAR').AsString,
                                  qryItensPedido.FieldByName('CPS_CODBAR').AsString,
                                  qryItensPedido.FieldByName('PCD_QTDITE').AsInteger,
                                  '',
                                  0,
                                  0,
                                  '',
                                  qryItensPedido.FieldByName('PIT_CODINT').AsString);
          qryItensPedido.Next;
        End;

        lParam.PitStopTipoConsulta := pstcFaturaPedido;
        If lParam.fGetQtdItens > 0 Then
        Begin
          RedePitStop.fRetFaturaPedido(lParam);
          Result := lParam.RetornoApi.sucess;
          If not Result Then
           raise Exception.Create('Falha ao gerar pedido de compra PitStop:' + lParam.RetornoApi.Falha)
          Else
            pMarcaFaturado(qryItensPedido.FieldByName('PIT_ID_CON').AsString);
        End
        Else
          Result := True;
      End;
    Finally
      FreeAndNil(qryItensPedido);
      FreeAndNil(lParam);
    End;
  Except
    on e: Exception do
    Begin
      pMensagensErro(e.message, '[TProcessaApi.fFaturarPedidoAux]');
      Result := false;
    End;

  End
end;

function TProcessaApi.fImportarPrecos: Boolean;
begin
  FfrmGravando := TfrmGravando.Create(nil);
  Try
    FfrmGravando.lblGravando.Caption := 'Carregando Preços Pit Stop...';
    FfrmGravando.fExecutarAcao := fImportarPrecosAux;
    FfrmGravando.ShowModal;
    Result := FfrmGravando.blnConfirma;
  Finally
    FreeAndNil(FfrmGravando);
  End
end;

function TProcessaApi.fImportarPrecosAux(pgbProgresso: TcxProgressBar): Boolean;
var qryPrecos: TUniQuery;
    lAutIncCot: String;
    fltValUni, fltValTot, fltAqlIpi, fltAlqFrete, fltAlqST: Double;
    fltOldValUni, fltOldAqlIpi, fltOldAlqFrete, fltOldAlqST: Double;
    indiceFornecedor: integer;
    strIndiceFor: String;
    bkpBeforePost: TDataSetNotifyEvent;
    bkpAfterPostItens: TDataSetNotifyEvent;
    bkpAfterScroll: TDataSetNotifyEvent;
begin
  Result := true;

  lAutIncCot := fCampoTabela('AUTOINCREM', 'COTGER', ['COT_NUMCOT'], [strNumCot]);
  cdsItens.DisableControls;

  bkpBeforePost := cdsItens.BeforePost;
  bkpAfterPostItens := cdsItens.AfterPost;
  //cdsItens.BeforePost := nil;
  cdsItens.AfterPost := nil;

  bkpAfterScroll := cdsItens.AfterScroll;
  cdsItens.AfterScroll := nil;

  qryPrecos := fCriaQuery;
  Try
     qryPrecos.SQL.Add('SELECT RETPIT.*,');
     qryPrecos.SQL.Add('       CON_CODFOR,');
     qryPrecos.SQL.Add('       IFNULL((SELECT BAR_CODBAR FROM ITEBAR');
     qryPrecos.SQL.Add('                WHERE BAR_CODFOR = CON_CODFOR');
     qryPrecos.SQL.Add('                  AND BAR_CODBAR = PIT_CODBAR');
     qryPrecos.SQL.Add('                LIMIT 1), ITE_CODBAR) AS CODBAR,');
     qryPrecos.SQL.Add('       ITE_CODITE');
     qryPrecos.SQL.Add('  FROM CONPIT');
     qryPrecos.SQL.Add(' INNER JOIN RETPIT ON PIT_ID_CON = CON_ID_CON');
     qryPrecos.SQL.Add(' INNER JOIN COTGER ON AUTOINCREM = CON_COTGER');
     qryPrecos.SQL.Add('  LEFT JOIN CADITE ON ITE_CODBAR = PIT_CODBAR');
     qryPrecos.SQL.Add(' WHERE CON_COTGER = "'+lAutIncCot+'"');
     qryPrecos.SQL.Add('   AND CON_CODFOR = :CODFOR');
     qryPrecos.SQL.Add('   AND PIT_LOCALI = 1');
     qryPrecos.SQL.Add('   AND CONPIT.CON_STATUS <> -1');
     qryPrecos.SQL.Add('   AND PIT_ETAPAC = IF(CON_STATUS = ' + TStatusBuscaCotacaoPitStop.fConsultaPitStopToInt(scpsConcluidoPrimeiraEtapa).Tostring + ', 1, 2);');

     while not cdsFornecedores.IsEmpty do
     Begin
       pgbProgresso.Position := cdsFornecedores.RecNo;

       qryPrecos.Close;
       qryPrecos.ParamByName('CODFOR').AsString := cdsFornecedores.FieldByName('COT_CODFOR').AsString;
       qryPrecos.Open;
       pgbProgresso.Properties.Max := qryPrecos.RecordCount;
       indiceFornecedor := funcCodForToIndex(cdsFornecedores.FieldByName('COT_CODFOR').AsString);
       while not qryPrecos.Eof do
       Begin
         strIndiceFor := funcIndice(indiceFornecedor);
         pgbProgresso.Position := qryPrecos.RecNo;
         FfrmGravando.lblGravando.Caption := 'Importando preços do fornecedor ['+cdsFornecedores.FieldByName('COT_CODFOR').AsString+'] ' +  qryPrecos.RecNo.ToString + '/' + qryPrecos.RecordCount.ToString;
         Application.ProcessMessages;
         If cdsItens.Locate('CODITE', qryPrecos.FieldByName('ITE_CODITE').AsString, []) Then
         Begin
           fltOldValUni := cdsItens.FieldByName('VALUNI' + strIndiceFor).OldValue;
           fltOldAqlIpi := cdsItens.FieldByName('IPIENT' + strIndiceFor).OldValue;
           fltOldAlqFrete := cdsItens.FieldByName('FREENT' + strIndiceFor).OldValue;
           fltOldAlqST := cdsItens.FieldByName('SUBSTI' + strIndiceFor).OldValue;

           cdsItens.Edit;
           fltValUni := qryPrecos.FieldByName('PIT_VPRECO').AsFloat;
           cdsItens.FieldByName('VALUNI' + strIndiceFor).AsFloat := qryPrecos.FieldByName('PIT_VPRECO').AsFloat;
           If qryPrecos.FieldByName('PIT_VPRECO').AsFloat = 0 Then
           Begin
             fltAqlIpi := 0;
             fltAlqFrete := 0;
             fltAlqST := 0;
           End
           Else
           Begin
             fltValTot := qryPrecos.FieldByName('PIT_VPRECO').AsFloat * cdsItens.FieldByName('QTDITE').AsFloat;
             fltAqlIpi := (qryPrecos.FieldByName('PIT_VALIPI').AsFloat / fltValTot) * 100;
             fltAlqFrete := (qryPrecos.FieldByName('PIT_VFRETE').AsFloat / fltValTot) * 100;
             fltAlqST := (qryPrecos.FieldByName('PIT_VAL_ST').AsFloat / fltValTot) * 100;
           End;
           cdsItens.FieldByName('IPIENT' + strIndiceFor).AsFloat := fltAqlIpi;
           cdsItens.FieldByName('FREENT' + strIndiceFor).AsFloat := fltAlqFrete;
           cdsItens.FieldByName('SUBSTI' + strIndiceFor).AsFloat := fltAlqST;

           cdsItens.FieldByName('UNITOT' + strIndiceFor).AsFloat := fCalculaPrecoImp(qryPrecos.FieldByName('PIT_VPRECO').AsFloat,  fltAqlIpi, fltAlqST, fltAlqFrete);
           cdsItens.FieldByName('VALTOT' + strIndiceFor).AsFloat := cdsItens.FieldByName('UNITOT' + strIndiceFor).AsFloat * cdsItens.FieldByName('QTDITE').AsFloat;



           If (fltValUni <> fltOldValUni) or
              (fltAqlIpi <> fltOldAqlIpi) or
              (fltAlqFrete <> fltOldAlqFrete) or
              (fltOldAlqST <> fltAlqST) Then
             cdsItens.FieldByName('ALTERADO').AsString := 'S';
           IncluiItensFornec_CopiaSeguranca(False, cdsFornecedores.FieldByName('COT_CODFOR').AsString);

           cdsItens.Post;
         End;
         qryPrecos.Next;
       End;

       cdsFornecedores.Edit;
       If TStatusCotacaoPitStop.IntToStatusPitStopCotacao(cdsFornecedores.FieldByName('COT_PITSTO').AsInteger) = spscPendenteImportarConsultaPreco Then
       begin
          cdsFornecedores.FieldByName('COT_PITSTO').AsInteger := TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteRecotarPreco);
          FAtualizaStatusCotCFOPitStopAncaora(SeqGerRes, cdsFornecedores.FieldByName('COT_CODFOR').AsString, idRedePitStop, TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteRecotarPreco), 0 );
       End
       Else If TStatusCotacaoPitStop.IntToStatusPitStopCotacao(cdsFornecedores.FieldByName('COT_PITSTO').AsInteger) = spscPendenteImportarRecotarPreco Then
       Begin
          cdsFornecedores.FieldByName('COT_PITSTO').AsInteger := TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscConcluido);
          FAtualizaStatusCotCFOPitStopAncaora(SeqGerRes, cdsFornecedores.FieldByName('COT_CODFOR').AsString, idRedePitStop, TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscConcluido), 0);
       End;
       cdsFornecedores.post;
     End;
  Finally
    cdsItens.AfterScroll := bkpAfterScroll;
    cdsItens.BeforePost := bkpBeforePost;
    cdsItens.AfterPost :=  bkpAfterPostItens;

    cdsItens.EnableControls;
    FreeAndNil(qryPrecos)
  End;
end;

function TProcessaApi.fIniciarSegundaEtapa: Boolean;
begin
  FfrmGravando := TfrmGravando.Create(nil);
  Try
    FfrmGravando.lblGravando.Caption := 'Iniciando Segunda cotação Pit Stop...';
    FfrmGravando.fExecutarAcao := fIniciarSegundaEtapaAux;
    FfrmGravando.ShowModal;
    Result := FfrmGravando.blnConfirma;
  Finally
    FreeAndNil(FfrmGravando);
  End
end;

function TProcessaApi.fIniciarSegundaEtapaAux(pgbProgresso: TcxProgressBar): Boolean;
  var
     qryConsulta: TUniQuery;
     strFornecedores: String;
     Paramns: TParamLista;
     qryCotacaoFornecedor: TUniQuery;
     lAutIncCotGer: String;
     index: integer;
     strIndex: String;


     blnItensFiltered: Boolean;
     strFilter: String;
begin
  Result := True;
  Try
    blnItensFiltered := cdsItens.Filtered;
    strFilter := cdsItens.Filter;

    cdsItens.DisableControls;
    cdsFornecedores.DisableControls;
    qryConsulta := fCriaQuery;
    qryCotacaoFornecedor := fCriaQuery;
    strIndex := cdsItens.IndexFieldNames;
    cdsItens.IndexFieldNames := 'CODITE';

    Try
      cdsFornecedores.First;
      cdsItens.Filter := '';
      cdsItens.Filter := cdsItens.Filter + 'QTDITE > 0';

      while not cdsFornecedores.Eof do
      begin
        cdsItens.Filter := cdsItens.Filter +  ' AND FORMEN <> ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString);
        cdsFornecedores.Next;
      End;

      cdsItens.Filtered := True;

      If cdsItens.IsEmpty Then
      Begin
        pMensagemOk('Não existe itens com preço menor que este fornecedor ' + cdsFornecedores.FieldByName('COT_CODFOR').AsString);
        Exit;
      end;

      cdsFornecedores.First;
      strFornecedores := '';
      while not cdsFornecedores.IsEmpty do
      begin
        cdsFornecedores.Edit;
        cdsFornecedores.FieldByName('COT_PITSTO').AsInteger := TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscIntegrandoRecotarPreco);
        cdsFornecedores.FieldByName('COT_INIINT').AsDateTime:= fNow;
        FAtualizaStatusCotCFOPitStopAncaora(SeqGerRes, cdsFornecedores.FieldByName('COT_CODFOR').AsString, idRedePitStop, TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscIntegrandoRecotarPreco), fNow);
        strFornecedores := strFornecedores + '"'+cdsFornecedores.FieldByName('COT_CODFOR').AsString + '"' +  IIf(cdsFornecedores.RecordCount = 1, '', ',');
        cdsFornecedores.Post;
      End;

      lAutIncCotGer := fCampoTabela('AUTOINCREM', 'COTGER', ['COT_NUMCOT'], [strNumCot]);
      qryCotacaoFornecedor.SQL.Clear;
      qryCotacaoFornecedor.SQL.Add('SELECT CONPIT.*, FOR_C_G_C_ FROM CONPIT');
      qryCotacaoFornecedor.SQL.Add('INNER JOIN CADFOR ON FOR_CODFOR = CON_CODFOR ');
      qryCotacaoFornecedor.SQL.Add('WHERE CON_COTGER = "' + lAutIncCotGer + '"');
      qryCotacaoFornecedor.SQL.Add('AND CON_CODFOR IN ('+strFornecedores+')');
      qryCotacaoFornecedor.SQL.Add('AND CON_STATUS <> -1');

      qryCotacaoFornecedor.Open;
      cdsFornecedores.Filtered := False;
      cdsFornecedores.Filter := '';
      pgbProgresso.Properties.Max := qryCotacaoFornecedor.RecordCount * cdsItens.RecordCount;

      pCriaTemporaria(strFornecedores);

      while not qryCotacaoFornecedor.Eof Do
      Begin
        Paramns := TParamLista.Create;
        Try
          Paramns.Cnpj_Cliente := fCfgSis('PSTCID');
          Paramns.Cnpj_Filial  := qryCotacaoFornecedor.FieldByname('FOR_C_G_C_').AsString;
          Paramns.PitStopTipoConsulta := pstcCotacaoSegundaEtapa;
          Paramns.PrazoMedio := '';
          Paramns.Quantidade := 0;
          Paramns.LogoMarca := 2;
          Paramns.idCotacao := qryCotacaoFornecedor.FieldByname('CON_ID_CON').AsString;
          cdsFornecedores.First;
          cdsFornecedores.Locate('COT_CODFOR', qryCotacaoFornecedor.FieldByName('CON_CODFOR').AsString, []);

          qryConsulta.SQL.Clear;
          qryConsulta.SQL.Add('SELECT ITE_CODITE, FOR_CODFOR, ITE_CODFAB, FOR_ESTADO , FOR_ESTADO,MAR_DESMAR, IF(FOR_CODBAR = "", ITE_CODBAR,FOR_CODBAR) AS CODBAR FROM  ' + FTemporaryTable + ' WHERE FOR_CODFOR = "' + qryCotacaoFornecedor.FieldByName('CON_CODFOR').AsString + '" ORDER BY ITE_CODITE');
          qryConsulta.Open;

          cdsItens.First;
          while not cdsItens.Eof do
          Begin
            while not (qryConsulta.FieldByName('ITE_CODITE').AsString = cdsItens.FieldByName('CODITE').AsString) do
              qryConsulta.Next;
            If cdsItens.FieldByName('GERPED').AsString = 'N' Then
            Begin
              index := funcCodForToIndex(cdsItens.FieldByName('FORMEN').AsString);
              If cdsItens.FieldByName('VALTOT' + funcIndice(index)).AsFloat > 0 Then
              Begin
                Paramns.pAddItemConsulta(cdsItens.FieldByName('CODITE').AsString,
                                         qryConsulta.FieldByName('ITE_CODFAB').AsString,
                                         qryConsulta.FieldByName('MAR_DESMAR').AsString,
                                         qryConsulta.FieldByName('CODBAR').AsString,
                                         cdsItens.FieldByName('QTDITE').AsInteger,
                                         cdsFornecedores.FieldByName('COT_CONPAG').AsString,
                                         (cdsItens.FieldByName('VALTOT' + funcIndice(index)).AsFloat / cdsItens.FieldByName('QTDITE').AsInteger),
                                         (cdsItens.FieldByName('VALUNI' + funcIndice(index)).AsFloat),
                                         qryConsulta.FieldByName('FOR_ESTADO').AsString);
              End;
            End;
            cdsItens.Next;
            pgbProgresso.Position := pgbProgresso.Position + 1;
            Application.ProcessMessages;
          End;
          if Paramns.fGetQtdItens > 0 then
          Begin
            RedePitStop.fRetProcessaLista(Paramns);
            qryComand.SQL.Clear;
            qryComand.SQL.Add('UPDATE CONPIT SET CON_STATUS  = ' + TStatusBuscaCotacaoPitStop.fConsultaPitStopToInt(scpsPendenteSegundaEtapa).ToString + ',');
            qryComand.SQL.Add('                  CON_HANDLE = ' + IntToStr(Handle) + ',');
            qryComand.SQL.Add('                  CON_HORINI = NULL');
            qryComand.SQL.Add(' WHERE CON_COTGER = "'+lAutIncCotGer+'"');
            qryComand.SQL.Add('   AND CON_ID_CON = "'+qryCotacaoFornecedor.FieldByName('CON_ID_CON').AsString+'"');
            qryComand.SQL.Add('   AND CON_STATUS  <> -1');
            qryComand.ExecSQL;

            StartProcess(ExtractFilePath(Application.ExeName) + '\ConsultaPitStop',
                         VS_StrCodEmp + ' ' +
                         qryCotacaoFornecedor.FieldByName('CON_ID_CON').AsString + ' True');

          End;
        Finally
          FreeAndNil(Paramns);
        End;
        qryCotacaoFornecedor.Next;
      End;



    Finally
      cdsItens.Filter := strFilter;
      cdsItens.Filtered := blnItensFiltered;

      cdsFornecedores.EnableControls;
      cdsItens.Filtered := False;
      cdsItens.Filter := '';
      cdsItens.EnableControls;
      FreeAndNil(qryConsulta);
      FreeAndNil(qryCotacaoFornecedor);
    End;
  Except
    on e: Exception do
    Begin
      pMensagensErro(e.message, '[TProcessaApi.fIniciarSegundaEtapaAux]');
      Result := False;
    End;
  End;
end;

function TProcessaApi.fInsereItensConsultaPitStopAux(pgbProgresso: TcxProgressBar): Boolean;
var Key : string;
    sqlItens: String;
    sqlInsert: string;
    sltListaCotIte: TStringLIst;
    qryComand: TUniQuery;
begin
  Try
    sltListaCotIte := TStringList.Create;
    qryComand := fCriaQuery;
    Try
      sqlInsert := 'INSERT INTO CPSITE (CPS_ID_CON, CPS_CODBAR, CPS_CODITE) VALUES ';
      for Key in FParamns.Produtos.Keys do
      Begin
        sqlItens := '';
        sqlItens := sqlItens + '("'+ FCotacaoPitStop+'", ';
        sqlItens := sqlItens + '"' + FParamns.Produtos.Items[Key].ean  +'", ';
        sqlItens := sqlItens + '"' + Key  +'")';
        If sltListaCotIte.Count = 0 Then
          sltListaCotIte.Add(sqlItens)
        Else
          sltListaCotIte.Add(', ' + sqlItens);
      End;
      If sltListaCotIte.Count > 0 Then
      begin
        qryComand.SQL.Add(sqlInsert + sltListaCotIte.Text);
        qryComand.ExecSQL;
      End;
      Result := True;
    Finally
      FreeAndNil(sltListaCotIte);
      FreeAndNil(qryComand);
    End;
  Except
    on e : Exception do
    Begin
      pMensagensErro(e.message, '[TProcessaApi.fInsereItensConsultaPitStopAux]');
      Result := False;
    End;
  End;
end;

function TProcessaApi.fProcessa(AIdApi: Integer): Boolean;
begin
  Result := False;
  case AIdApi of
    idRedeAncora: Result := fProcessaAncora;
    idRedePitStop: Result := fProcessaPitStop;
    idRedeSkyPecas: Result := fProcessaSkyPecas;
  End;
end;

function TProcessaApi.fProcessaAncora: Boolean;
begin
  FfrmGravando := TfrmGravando.Create(nil);
  Try
    FfrmGravando.lblGravando.Caption := 'Processando itens Rede Âncora...';
    FfrmGravando.fExecutarAcao := fProcessaAncoraAux;
    FfrmGravando.ShowModal;
    Result := FfrmGravando.blnConfirma;
  Finally
    FreeAndNil(FfrmGravando);
  End
end;

function TProcessaApi.fProcessaAncoraAux(pgbProgresso: TcxProgressBar): Boolean;
 var
   lParamns: TParamnsFullSearch;
   bkpCdsFornecedoresBeforePost: TDataSetNotifyEvent;
   bkpCdsFornecedoresAfterPost: TDataSetNotifyEvent;

   bkpCdsItensAfterScroll: TDataSetNotifyEvent;
   bkpCdsItensAfterPostItens: TDataSetNotifyEvent;

   qryConsulta: TUniQuery;
   indiceFornecedor: integer;
   strIndiceFor: String;

begin
  Result := True;
  Try
    qryConsulta := fCriaQuery;


    bkpCdsFornecedoresBeforePost := cdsFornecedores.BeforePost;
    bkpCdsFornecedoresAfterPost := cdsFornecedores.AfterPost;


    bkpCdsItensAfterScroll := cdsItens.AfterScroll;
//    bkpCdsItensBeforePost := cdsItens.BeforePost;
    bkpCdsItensAfterPostItens := cdsItens.AfterPost;

    cdsItens.DisableControls;

    cdsFornecedores.BeforePost := nil;
    cdsFornecedores.AfterPost := nil;

    cdsItens.AfterScroll := nil;
//    bkpCdsItensBeforePost := cdsItens.BeforePost;
    cdsItens.AfterPost := nil;
    cdsItens.IndexFieldNames := 'CODITE';

    pCriaTemporaria;

    Try
      cdsItens.First;
      cdsFornecedores.First;

      pgbProgresso.Properties.Max := cdsItens.RecordCount * cdsFornecedores.RecordCount;
      cdsFornecedores.First;
      lParamns := TParamnsFullSearch.Create;
      while not cdsFornecedores.IsEmpty do
      begin
        FfrmGravando.lblGravando.Caption := 'Consultando Ancora. Fornecedor ['+cdsFornecedores.FieldByName('COT_CODFOR').AsString+'].';
        Application.ProcessMessages;
        cdsItens.First;
        qryConsulta.SQL.Clear;
        qryConsulta.SQL.Add('SELECT ITE_CODITE, FOR_CODFOR, ITE_CODFAB ,MAR_DESMAR, IF(FOR_CODBAR = "", ITE_CODBAR,FOR_CODBAR) AS CODBAR FROM  ' + FTemporaryTable + ' WHERE FOR_CODFOR = ' + cdsFornecedores.FieldByName('COT_CODFOR').AsString + ' ORDER BY ITE_CODITE');
        qryConsulta.Open;
        qryConsulta.First;
        cdsItens.First;
        lParamns.page_size := 1;
        lParamns.empresa := RedeAncora.RetApiProfile.LocateWarehouse(cdsFornecedores.FieldByName('FOR_C_G_C_').AsString);
        lParamns.fields := [prices,stocks];
        indiceFornecedor := funcCodForToIndex(cdsFornecedores.FieldByName('COT_CODFOR').AsString);
        strIndiceFor := funcIndice(indiceFornecedor);
        while not cdsItens.Eof do
        begin

          while not (qryConsulta.FieldByName('ITE_CODITE').AsString = cdsItens.FieldByName('CODITE').AsString) do
            qryConsulta.Next;


          lParamns.pReinciaCampos;
          lParamns.gtin := qryConsulta.FieldByName('CODBAR').AsString;
          If RedeAncora.fRetFullSearch(lParamns) then
          Begin
            cdsItens.Edit;
            cdsItens.FieldByName('VALUNI' + strIndiceFor).AsFloat := RedeAncora.RetApiFullSearch.fltPrecoComSt;
            cdsItens.FieldByName('IPIENT' + strIndiceFor).AsFloat := 0;
            cdsItens.FieldByName('FREENT' + strIndiceFor).AsFloat := 0;
            cdsItens.FieldByName('SUBSTI' + strIndiceFor).AsFloat := 0;
            cdsItens.FieldByName('UNITOT' + strIndiceFor).AsFloat := fCalculaPrecoImp(RedeAncora.RetApiFullSearch.fltPrecoComSt,  0, 0, 0);
            cdsItens.FieldByName('VALTOT' + strIndiceFor).AsFloat := cdsItens.FieldByName('UNITOT' + strIndiceFor).AsFloat * cdsItens.FieldByName('QTDITE').AsFloat;


            cdsItens.FieldByName('ALTERADO').AsString := 'S';
            cdsItens.Post;
          End;

          cdsItens.Next;
          pgbProgresso.Position := pgbProgresso.Position + 1;
          FfrmGravando.lblGravando.Caption := 'Consultando Ancora. Fornecedor ['+cdsFornecedores.FieldByName('COT_CODFOR').AsString+'] ' + pgbProgresso.Position.ToString + '/' + pgbProgresso.Properties.Max.ToString;
          Application.ProcessMessages;
        End;

        cdsFornecedores.Edit;
        cdsFornecedores.FieldByName('COT_ANCORA').AsInteger := 8;
        FAtualizaStatusCotCFOPitStopAncaora(SeqGerRes, cdsFornecedores.FieldByName('COT_CODFOR').AsString, idRedeAncora, 8, 0);

        cdsFornecedores.Post;

      End;
    Finally
      FreeAndNil(qryConsulta);
      If Not fEmptyStr(FTemporaryTable) Then
        fDropTable(FTemporaryTable);
      cdsFornecedores.BeforePost := bkpCdsFornecedoresBeforePost;
      cdsFornecedores.AfterPost :=  bkpCdsFornecedoresAfterPost;

      cdsItens.AfterScroll := bkpCdsItensAfterScroll;
  //    cdsItens.BeforePost := bkpCdsItensBeforePost;
      cdsItens.AfterPost :=  bkpCdsItensAfterPostItens;

      cdsItens.EnableControls;


      If Assigned(lParamns) Then
        FreeAndNil(lParamns);
    End;
  Except
    on e: Exception do
    Begin
      pMensagensErro(e.message, '[TProcessaApi.fProcessaAncoraAux]');
      Result := False;
    End;
  end;
end;

function TProcessaApi.fProcessaPitStop: Boolean;
begin
  FfrmGravando := TfrmGravando.Create(nil);
  Try
    FfrmGravando.lblGravando.Caption := 'Gerando cotação para itens Pit Stop...';
    FfrmGravando.fExecutarAcao := fProcessaPitStopAux;
    FfrmGravando.ShowModal;
    Result := FfrmGravando.blnConfirma;
  Finally
    FreeAndNil(FfrmGravando);
  End
end;

function TProcessaApi.fProcessaPitStopAux(pgbProgresso: TcxProgressBar): Boolean;
var  Paramns: TParamLista;
     qryConsulta: TUniquery;
     bkpBeforePost: TDataSetNotifyEvent;
     bkpAfterPost: TDataSetNotifyEvent;
     bkpAfterScroll: TDataSetNotifyEvent;

     blnProcessa: Boolean;
     lCotSeqger : String;
     strFornecedores: String;
     strIndex: String;
begin
  Result := True;
  cdsItens.DisableControls;

  strIndex := cdsItens.IndexFieldNames;
  cdsItens.IndexFieldNames := 'CODITE';


  bkpBeforePost := cdsFornecedores.BeforePost;
  bkpAfterPost := cdsFornecedores.AfterPost;
  bkpAfterScroll := cdsFornecedores.AfterSCroll;
  Try
    cdsFornecedores.BeforePost := nil;
    cdsFornecedores.AfterPost := nil;
    cdsFornecedores.AfterSCroll := nil;
    lCotSeqger := fCampoTabela('AUTOINCREM', 'COTGER', ['COT_NUMCOT'], [strNumCot]);
    cdsItens.IndexFieldNames := 'CODITE';

    pCriaTemporaria;

    cdsFornecedores.First;
    cdsItens.First;
    qryConsulta := fCriaQuery;
    Try
      pgbProgresso.Properties.Max := cdsItens.RecordCount;
      cdsFornecedores.First;
      blnProcessa := cdsFornecedores.RecordCount > 0;
      while blnProcessa do
      begin
        Paramns := TParamLista.Create;
        Try

          Paramns.Cnpj_Cliente := fCfgSis('PSTCID');
          Paramns.Cnpj_Filial  := cdsFornecedores.FieldByname('FOR_C_G_C_').AsString;
          Paramns.CondicaoPagamento := cdsFornecedores.FieldByName('COT_CONPAG').AsString;
          Paramns.PitStopTipoConsulta := pstcCotacao;
          Paramns.PrazoMedio := '';
          Paramns.Quantidade := 0;
          Paramns.LogoMarca := 2;
          FfrmGravando.lblGravando.Caption := 'Gerando consulta para os itens do fornecedor ['+cdsFornecedores.FieldByName('COT_CODFOR').AsString+'].';
          Application.ProcessMessages;
          cdsItens.First;
          qryConsulta.SQL.Clear;
          qryConsulta.SQL.Add('SELECT ITE_CODITE, FOR_CODFOR, ITE_CODFAB ,MAR_DESMAR, IF(FOR_CODBAR = "", ITE_CODBAR,FOR_CODBAR) AS CODBAR FROM  ' + FTemporaryTable + ' WHERE FOR_CODFOR = ' + cdsFornecedores.FieldByName('COT_CODFOR').AsString + ' ORDER BY ITE_CODITE');
          qryConsulta.Open;
          qryConsulta.First;
          while not cdsItens.Eof do
          begin
            while not (qryConsulta.FieldByName('ITE_CODITE').AsString = cdsItens.FieldByName('CODITE').AsString) do
              qryConsulta.Next;
            If cdsItens.FieldByName('GERPED').AsStrinG = 'N' Then
            Begin
              Paramns.pAddItemConsulta(cdsItens.FieldByName('CODITE').AsString,
                                       qryConsulta.FieldByName('ITE_CODFAB').AsString,
                                       qryConsulta.FieldByName('MAR_DESMAR').AsString,
                                       qryConsulta.FieldByName('CODBAR').AsString,
                                       cdsItens.FieldByName('QTDITE').AsInteger);
              cdsItens.Next;
            End;
            pgbProgresso.Position := cdsitens.RecNo;
            FfrmGravando.lblGravando.Caption := 'Gerando consulta para os itens do fornecedor ['+cdsFornecedores.FieldByName('COT_CODFOR').AsString+'] ' + cdsitens.RecNo.ToString + '/' + cdsitens.RecordCount.Tostring;
            Application.ProcessMessages;
          End;

          RedePitStop.fRetProcessaLista(Paramns);
          If Paramns.RetornoCotacao.idCotacao <> '' Then
          Begin
            pInsereConsultaPitStop(Paramns.RetornoCotacao.idCotacao, cdsFornecedores.FieldByName('COT_CODFOR').AsString, lCotSeqger, Handle);
            pInsereItensConsultaPitStop(Paramns.RetornoCotacao.idCotacao, Paramns);


            StartProcess(ExtractFilePath(Application.ExeName) + '\ConsultaPitStop',
                         VS_StrCodEmp + ' ' + Paramns.RetornoCotacao.idCotacao + ' True');

            cdsFornecedores.Edit;
            strFornecedores := strFornecedores + '"'+cdsFornecedores.FieldByName('COT_CODFOR').AsString + '"';

            cdsFornecedores.FieldByName('COT_PITSTO').AsInteger := TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscIntegrandoConsultaPreco);
            cdsFornecedores.FieldByName('COT_INIINT').AsDateTime := fNow;
            FAtualizaStatusCotCFOPitStopAncaora(SeqGerRes, cdsFornecedores.FieldByName('COT_CODFOR').AsString, idRedePitStop, TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscIntegrandoConsultaPreco), fNow);

            cdsFornecedores.Post;


          End
          Else
            cdsFornecedores.Next;

          If (cdsFornecedores.IsEmpty) Or (cdsFornecedores.Eof) Then
            blnProcessa := False;
        Finally
          FreeAndNil(Paramns);
        End;


      End;
    Finally
      FreeAndNil(qryConsulta);
      cdsFornecedores.BeforePost := bkpBeforePost;
      cdsFornecedores.AfterPost :=  bkpAfterPost;
      cdsFornecedores.AfterSCroll := bkpAfterScroll;
      cdsItens.IndexFieldNames := strIndex;
      cdsItens.EnableControls;

    End;
  Except
    on e: Exception do
    Begin
      pMensagensErro(e.message, '[TProcessaApi.fProcessaPitStopAux]');
      Result := False;
    End;
  end;
end;

function TProcessaApi.fProcessaSkyPecas: Boolean;
begin
  FfrmGravando := TfrmGravando.Create(nil);
  Try
    FfrmGravando.lblGravando.Caption := 'Processando itens Sky Peças...';
    FfrmGravando.fExecutarAcao := fProcessaSkyPecasAux;
    FfrmGravando.ShowModal;
    Result := FfrmGravando.blnConfirma;
  Finally
    FreeAndNil(FfrmGravando);
  End
end;

function TProcessaApi.fProcessaSkyPecasAux(pgbProgresso: TcxProgressBar): Boolean;
 var
   bkpCdsFornecedoresBeforePost: TDataSetNotifyEvent;
   bkpCdsFornecedoresAfterPost: TDataSetNotifyEvent;

   bkpCdsItensAfterScroll: TDataSetNotifyEvent;
//   bkpCdsItensBeforePost: TDataSetNotifyEvent;
   bkpCdsItensAfterPostItens: TDataSetNotifyEvent;

   qryConsulta: TUniQuery;
   ParamSkyConsultaProduto: TParamSkyConsultaProduto;
   indiceFornecedor: integer;
   strIndiceFor: String;


   function fBuscaProduto: Boolean;
   Begin
     ParamSkyConsultaProduto.codigo_barras := qryConsulta.FieldByName('CODBAR').AsString;
     ParamSkyConsultaProduto.codigo_fabrica := '';
     ParamSkyConsultaProduto.Marca := '';
     Result := RedeSkyPecas.fBuscaPrecoProduto(ParamSkyConsultaProduto);
     If Not Result Then
     begin
       ParamSkyConsultaProduto.codigo_barras := '';
       ParamSkyConsultaProduto.codigo_fabrica := qryConsulta.FieldByName('ITE_CODFAB').AsString;
       ParamSkyConsultaProduto.Marca := qryConsulta.FieldByName('MAR_DESMAR').AsString;
       Result := RedeSkyPecas.fBuscaPrecoProduto(ParamSkyConsultaProduto);
     End;
   End;

begin

  Result := True;
  Try
    qryConsulta := fCriaQuery;
    ParamSkyConsultaProduto := TParamSkyConsultaProduto.Create;

    bkpCdsFornecedoresBeforePost := cdsFornecedores.BeforePost;
    bkpCdsFornecedoresAfterPost := cdsFornecedores.AfterPost;

    bkpCdsItensAfterScroll := cdsItens.AfterScroll;
//    bkpCdsItensBeforePost := cdsItens.BeforePost;
    bkpCdsItensAfterPostItens := cdsItens.AfterPost;

    cdsItens.DisableControls;

    cdsFornecedores.BeforePost := nil;
    cdsFornecedores.AfterPost := nil;

    cdsItens.AfterScroll := nil;
//    bkpCdsItensBeforePost := cdsItens.BeforePost;
    cdsItens.AfterPost := nil;
    cdsItens.IndexFieldNames := 'CODITE';

    pCriaTemporaria;

    Try
      cdsItens.First;
      cdsFornecedores.First;

      pgbProgresso.Properties.Max := cdsItens.RecordCount * cdsFornecedores.RecordCount;
      cdsFornecedores.First;

      while not cdsFornecedores.IsEmpty do
      begin
        FfrmGravando.lblGravando.Caption := 'Consultando Sky Peças. Fornecedor ['+cdsFornecedores.FieldByName('COT_CODFOR').AsString+'].';
        Application.ProcessMessages;
        cdsItens.First;
        qryConsulta.SQL.Clear;
        qryConsulta.SQL.Add('SELECT ITE_CODITE, FOR_CODFOR, ITE_CODFAB ,MAR_DESMAR, IF(FOR_CODBAR = "", ITE_CODBAR,FOR_CODBAR) AS CODBAR FROM  ' + FTemporaryTable + ' WHERE FOR_CODFOR = ' + cdsFornecedores.FieldByName('COT_CODFOR').AsString + ' ORDER BY ITE_CODITE');
        qryConsulta.Open;
        qryConsulta.First;



        ParamSkyConsultaProduto.Empresa := RedeSkyPecas.ParamSkyPecas.fCodFornecedorSkyPecas(cdsFornecedores.FieldByName('COT_CODFOR').AsString);
        If ParamSkyConsultaProduto.Empresa = -1 Then
        begin
          cdsFornecedores.Edit;
          cdsFornecedores.FieldByName('COT_SKYPEC').AsInteger := 8;
          FAtualizaStatusCotCFOPitStopAncaora(SeqGerRes, cdsFornecedores.FieldByName('COT_CODFOR').AsString, idRedeSkyPecas, 8, 0);
          cdsFornecedores.Post;
          Continue;
        End;

        indiceFornecedor := funcCodForToIndex(cdsFornecedores.FieldByName('COT_CODFOR').AsString);
        strIndiceFor := funcIndice(indiceFornecedor);


        while not cdsItens.Eof do
        begin
          while not (qryConsulta.FieldByName('ITE_CODITE').AsString = cdsItens.FieldByName('CODITE').AsString) do
            qryConsulta.Next;

          ParamSkyConsultaProduto.RetornoProduto.ReiniciaValores;
          If fBuscaProduto Then
          begin
            cdsItens.Edit;
            cdsItens.FieldByName('VALUNI' + strIndiceFor).AsFloat := ParamSkyConsultaProduto.RetornoProduto.valor;
            cdsItens.FieldByName('IPIENT' + strIndiceFor).AsFloat := 0;
            cdsItens.FieldByName('FREENT' + strIndiceFor).AsFloat := 0;
            cdsItens.FieldByName('SUBSTI' + strIndiceFor).AsFloat := 0;




            cdsItens.Post;
          End;

          cdsItens.Next;
          pgbProgresso.Position := pgbProgresso.Position + 1;
          FfrmGravando.lblGravando.Caption := 'Consultando Sky Peças. Fornecedor ['+cdsFornecedores.FieldByName('COT_CODFOR').AsString+'] ' + pgbProgresso.Position.ToString + '/' + pgbProgresso.Properties.Max.ToString ;
          Application.ProcessMessages;
        End;

        cdsFornecedores.Edit;
        cdsFornecedores.FieldByName('COT_SKYPEC').AsInteger := 8;
        FAtualizaStatusCotCFOPitStopAncaora(SeqGerRes, cdsFornecedores.FieldByName('COT_CODFOR').AsString, idRedeSkyPecas, 8, 0);
        cdsFornecedores.Post;

      End;
    Finally
      FreeAndNil(qryConsulta);
      If Not fEmptyStr(FTemporaryTable) Then
        fDropTable(FTemporaryTable);
      cdsFornecedores.BeforePost := bkpCdsFornecedoresBeforePost;
      cdsFornecedores.AfterPost :=  bkpCdsFornecedoresAfterPost;

      cdsItens.AfterScroll := bkpCdsItensAfterScroll;
  //    cdsItens.BeforePost := bkpCdsItensBeforePost;
      cdsItens.AfterPost :=  bkpCdsItensAfterPostItens;

      If Assigned(ParamSkyConsultaProduto) Then
        FreeAndNil(ParamSkyConsultaProduto);
      cdsItens.EnableControls;


    End;
  Except
    on e: Exception do
    Begin
      pMensagensErro(e.message, '[TProcessaApi.fProcessaAncoraAux]');
      Result := False;
    End;
  end;
end;

Procedure TProcessaApi.pInsereItensConsultaPitStop(ACotacaoPitStop: String; AParamns: TParamLista);
var frmGravandoItensPit: TfrmGravando;
begin
  FCotacaoPitStop := ACotacaoPitStop;
  FParamns := AParamns;
  frmGravandoItensPit := TfrmGravando.Create(nil);
  Try
    frmGravandoItensPit.lblGravando.Caption := 'Gravando Relação dos Itens Pit Stop...';
    frmGravandoItensPit.fExecutarAcao := fInsereItensConsultaPitStopAux;
    frmGravandoItensPit.ShowModal;
  Finally
    FreeAndNil(frmGravandoItensPit);
  End
end;

procedure TProcessaApi.pMarcaFaturado(AIdCotacaoPitStop: String);
begin
  qryComand.sqL.Clear;
  qryComand.SQL.Add('UPDATE CONPIT SET COT_FATURA = "S",');
  qryComand.SQL.Add('                  COT_DTAFAT = CURRENT_TIMESTAMP');
  qryComand.SQL.Add(' WHERE CON_ID_CON = "'+AIdCotacaoPitStop+'"');
  qryComand.ExecSQL;
end;

procedure TProcessaApi.pCancelaCotacaoPitStop;
var lAutIncCot: string;
    lCotacaoPitStop: String;
begin
  lAutIncCot := fCampoTabela('AUTOINCREM', 'COTGER', ['COT_NUMCOT'], [strNumCot]);

  qryComand.sqL.Clear;
  qryComand.SQL.Add('SELECT CON_ID_CON ');
  qryComand.SQL.Add('  FROM CONPIT');
  qryComand.SQL.Add(' WHERE CON_COTGER = "'+lAutIncCot+'"');
  qryComand.SQL.Add('   AND CON_CODFOR = "'+cdsFornecedores.FieldByName('COT_CODFOR').AsString+'"');
  qryComand.SQL.Add('   AND CON_STATUS  <> -1');
  qryComand.Open;
  If qryComand.IsEmpty Then
    Exit;


  while not qryComand.Eof do
  begin
    lCotacaoPitStop := qryComand.FieldByName('CON_ID_CON').AsString;
    StartProcess(ExtractFilePath(Application.ExeName) + '\ConsultaPitStop',
                           VS_StrCodEmp + ' ' + lCotacaoPitStop + ' false' + ' CANCEL');
    qryComand.Next;
  End;

  cdsFornecedores.Edit;
  cdsFornecedores.FieldByName('COT_PITSTO').AsString := TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscComApi).ToString;
  cdsFornecedores.Post;

  FAtualizaStatusCotCFOPitStopAncaora(SeqGerRes, cdsFornecedores.FieldByName('COT_CODFOR').AsString, idRedePitStop, TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscComApi),0);
end;

procedure TProcessaApi.pCriaTemporaria(ACodFor: String = '');
var strFornecedores, strItens: String;
begin
  cdsFornecedores.First;
  strFornecedores := '';
  If ACodFor <> '' Then
    strFornecedores := ACodFor
  Else
  Begin
    while not cdsFornecedores.Eof Do
    Begin
      strFornecedores := strFornecedores + '"' +cdsFornecedores.FieldByName('COT_CODFOR').AsString+ '"';
      cdsFornecedores.Next;
      If Not cdsFornecedores.Eof then
        strFornecedores := strFornecedores + ',';

    End;
  End;
  cdsItens.First;
  while not cdsItens.Eof Do
  Begin
    strItens := strItens + '"' +cdsItens.FieldByName('CODITE').AsString+ '"';
    cdsItens.Next;
    If Not cdsItens.Eof then
      strItens := strItens + ',';
  End;

  FTemporaryTable := 'TMP_COTACAO' + strNumCot;
  fDropTable(FTemporaryTable);

  qryComand.SQL.Clear;
  qryComand.SQL.Add('CREATE TEMPORARY TABLE ' + FTemporaryTable);
  qryComand.SQL.Add('SELECT');
  qryComand.SQL.Add('  C.ITE_CODITE,');
  qryComand.SQL.Add('  FOR_CODFOR,');
  qryComand.SQL.Add('  ITE_CODFAB,');
  qryComand.SQL.Add('  CID_ESTADO AS FOR_ESTADO,');
  qryComand.SQL.Add('  (SELECT MAR_DESMAR FROM CADMAR WHERE MAR_CODMAR = C.ITE_CODMAR) AS MAR_DESMAR,');
  qryComand.SQL.Add('   C.ITE_CODBAR,');
  qryComand.SQL.Add('  IFNULL((SELECT ITE_CODBAR FROM ITEFOR IT WHERE IT.ITE_CODFOR = F.FOR_CODFOR AND IT.ITE_CODITE = C.ITE_CODITE LIMIT 1), "") AS FOR_CODBAR');
  qryComand.SQL.Add('FROM');
  qryComand.SQL.Add('  CADITE C');
  qryComand.SQL.Add(' LEFT JOIN CADFOR F ON TRUE');
  qryComand.SQL.Add(' lEFT JOIN CADCID ON CID_CODCID = F.FOR_CODCID');

  qryComand.SQL.Add('WHERE C.ITE_CODITE IN ('+strItens+')');
  qryComand.SQL.Add('  AND FOR_CODFOR IN ('+strFornecedores+')');
  qryComand.ExecSQL;
  qryComand.SQL.Clear;
  qryComand.SQL.Add('ALTER TABLE `' + FTemporaryTable+ '`');
  qryComand.SQL.Add('  ADD UNIQUE INDEX `idx_unique_tmp_cotacao` (`ITE_CODITE`, `FOR_CODFOR`),');
  qryComand.SQL.Add('  ADD INDEX `idxFornec` (`FOR_CODFOR`)');
  qryComand.ExecSQL;
  qryComand.SQL.Clear;
end;

procedure TProcessaApi.pInsereConsultaPitStop(ACotacaoPitStop: String; AFornecedor: String; ACotSeqger: String; AHandle: HWND);
begin
  qryComand.SQL.Clear;
  qryComand.SQL.Add('INSERT INTO CONPIT(CON_COTGER, CON_ID_CON, CON_STATUS,  CON_HANDLE, CON_CODFOR) VALUES (');
  qryComand.SQL.Add(' :CON_COTGER, ');
  qryComand.SQL.Add(' :CON_ID_CON, ');
  qryComand.SQL.Add(' :CON_STATUS, ');
  qryComand.SQL.Add(' :CON_HANDLE, ');
  qryComand.SQL.Add(' :CON_CODFOR)');


  qryComand.ParamByName('CON_COTGER').AsString := ACotSeqger;
  qryComand.ParamByName('CON_ID_CON').AsString := ACotacaoPitStop;
  qryComand.ParamByName('CON_STATUS').AsInteger := 0;
  qryComand.ParamByName('CON_CODFOR').AsString := AFornecedor;
  qryComand.ParamByName('CON_HANDLE').AsInteger := Ahandle;
  qryComand.ExecSQL;
end;

end.

