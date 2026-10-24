unit untEntOutrasDespesas;

interface

Uses
  SysUtils,
  Classes,
  Uni,
  MaskUtils,
  Controls,
  untFuncoesSimples,
  Math,
  DB,
  UniClientDataSet,
  StrUtils,
  untTypesSistema,
  untParCalculaPrecoCusto;

Type


  TOpcRateioOutrasDespesas = (opcRatOutDesValorItem,
                              opcRatOutDesPesoItem,
                              opcRatOutDesQuantidade,
                              opcRatOutDesManual);

  TEntOutrasDespesas = Class(TComponent)
  Private
    cpcParams: TParCalculaPrecoCusto;
    strEmpMeds,
    strMedEmp: String;


    FstrAutoIncrem: String;
    ArrDuplicataOutras: TArrDigDuplicArray;
    cdsOutDes: TUniClientDataSet;
    FdtaDtaBas : TDate;
    FOpcRateioOutrasDespesasCfg : TOpcRateioOutrasDespesas;
    FOpcRateioOutrasDespesasSel : TOpcRateioOutrasDespesas;
    FTipRatFreteRPA: TTipoRateioFrete;
    FblnTemOutrasDespesasNotaDeImportacao: Boolean;
    FDecUni: integer;
    FPerFre: integer;
    blnATPVMB: array[1..7] of Boolean;
    Function fTemClassificaoCompra: Boolean;
    function fRetOpcRateioOutrasDespesasCfg:TOpcRateioOutrasDespesas;
    function fOpcRateioOutrasDespesasToInteger(OpcRateioOutrasDespesas: TOpcRateioOutrasDespesas): integer;
    function fIntegerToOpcRateioOutrasDespesas(Index: Integer): TOpcRateioOutrasDespesas;
    procedure pRemovePendentes;
    procedure pUpdateMovtri(strAutInc: String; fltOutDes, fltImpUlt: Double);
    Function fUpdateLotePrecos(blnEncargosNoFrete: Boolean; fltConFre: Double; cdsMovTri: TDataSet; fltPreCom: Double = -1): Boolean;
    procedure pUpdateCadIte(strCodIte, strCodFor, strNotUlt: String; fltImpUlt, fltPreMed: Double);
    Function fAtualizaFreteIteger(strCodIte: String ; fltPrecom, fltValFre: Double; blnPermiteReducaoPreco, blnAlteraPrecoCompra: Boolean; blnEncargosNoFrete: Boolean): Boolean;
    Function fAtualizaPrecomIteger(strCodIte: String; fltPreCom: Double; blnPermiteReducaoPreco: Boolean): Boolean;
    Procedure pCarregaAtpVmb;
    Function fCalculaPrecoCompraBruto(fltPreLiq: Double; ArrDesFor: Array Of Double): Double;

    procedure pDigRateioManual;

  Public
    fltValOut: Double;
    fltValRPA: Double;
    blnRateioManual,
    blnDigAposEntrada,
    blnConverteQtdItensEmb: Boolean;
    intDecimais: integer;
    Constructor Create(Owner: TComponent); override;
    Destructor Destroy; override;
    procedure pCarregaValorOut;
    procedure pGravarOutDes(AOrigem: String = 'E'; blnEfetivado: Boolean = True; intTipRat: integer = 0);
    function fAutoIncrem(strAutoIncrem: String): TEntOutrasDespesas;
    Function fRetOutrasDespesasDigitacao : String;
    Function fRateiaOutrasDespesas: Boolean;
    procedure pInsereDepesasImportacao(fltValor: Double);
    Function fInformaOutrasDespesas(var arrDuplicata: TarrDuplicata; strForEnt: String; dtaDtaBase : TDate; blnVariasNotas: Boolean = False): Boolean;

    function fTemRegistroNaoEfetivado: Boolean;

    Function fGravaContasAPagar(strForEnt, strNumDoc, strEspDoc,
                 strCodEmp, strSerie{, strCodEve},strTipFor, strCompet: String;
                 intCtpCon: Integer; dtaDtaEnt: TDate; blnVariasNotas: Boolean = False;
                 blnConferenciaDepoisDaEntrada: Boolean = False; blnDevolu: Boolean = False; blnRecCliGarantia: Boolean = False;
                 blnConEqu: Boolean = False; blnGarantia:Boolean = False; blnUtilizarCFG_CLARET: Boolean = False ): Boolean;
   function fTotalFreteRpa: Double;
   procedure pPrencheDados(qryDados: TUniQuery; var DataSetDestino: TUniClientDataSet);
   procedure pCriaTemporaria_e_InsereDados(strIncMovGer: String);
   Function fAtualizaDocumento: Boolean;

   Property OpcRateioOutrasDespesasSel: TOpcRateioOutrasDespesas read FOpcRateioOutrasDespesasSel;
   property blnTemOutrasDespesasNotaDeImportacao: Boolean read FblnTemOutrasDespesasNotaDeImportacao;
   property tipRatFreteRPA: TTipoRateioFrete read FtipRatFreteRPA Write FtipRatFreteRPA;
  End;

implementation

Uses
     untCadPag, untConstantes, untEntDadosOutrasDespesas,
  untRateioManualOutrasDespesas, untFuncoes, untPreAlt_Trigger,
  untPreAlt, untFuncoesAuxiliares, untCalculoPisCofins, untPcmGer,
  untTConfiguracao, untLotePrecos;



Constructor TEntOutrasDespesas.Create(Owner: TComponent);
Begin
  inherited Create(Owner);
  intDecimais := fCfgSis('DECUNI', varInteger);
  pCarregaAtpVmb;
  blnDigAposEntrada := False;
  FblnTemOutrasDespesasNotaDeImportacao := False;
  FOpcRateioOutrasDespesasCfg := fRetOpcRateioOutrasDespesasCfg;
  FOpcRateioOutrasDespesasSel := FOpcRateioOutrasDespesasCfg;
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
  fltValOut := 0;
  fltValRPA := 0;
  SetLength(ArrDuplicataOutras, 0);

  blnConverteQtdItensEmb := False;

  cdsOutDes := TUniClientDataSet.Create(Self);

  With cdsOutDes Do
  Begin
    FieldDefs.Add('CODFOR', ftString, 08);
    FieldDefs.Add('NOMFOR', ftString, 60);
    FieldDefs.Add('CODCTA', ftString, 07);
    FieldDefs.Add('DESCTA', ftString, 30);
    FieldDefs.Add('CODPOR', ftString, 07);
    FieldDefs.Add('NOMPOR', ftString, 40);
    FieldDefs.Add('VEIONF', ftString, 03);
    FieldDefs.Add('VEIOBO', ftString, 03);
    FieldDefs.Add('DEPOSI', ftString, 03);
    FieldDefs.Add('BCOFOR', ftString, 20);


    FieldDefs.Add('CODEVE', ftString, 05);

    FieldDefs.Add('CNDPAG', ftString, 38);
    FieldDefs.Add('VALOUT', ftFloat);
    FieldDefs.Add('DUPLIC', ftBlob);

    FieldDefs.Add('HISTOR', ftString, 500);
    FieldDefs.Add('GERFIN', ftString, 3);
    FieldDefs.Add('RPAFRE', ftString, 1);
    FieldDefs.Add('EFETIV', ftString, 10);
    FieldDefs.Add('ORIGEM', ftString, 22);
    FieldDefs.Add('FORNEC', ftString, 80);
    FieldDefs.Add('OUT_EFETIV', ftString, 1);
    FieldDefs.Add('OUT_TIPRAT', ftInteger);

    CreateDataSet;

    FieldByName('CNDPAG').EditMask := '99.999.999.999.999.999.999.999.999.999.999.999.999;0;_';
    FieldByName('CODCTA').EditMask := '99.99.999;0;_';

    Open;
  End;

  case fCfgSis('RATFRE', varInteger) of
    1: FTipRatFreteRPA := TTipoRateioFrete.trfPropValorItem;
    2: FTipRatFreteRPA := TTipoRateioFrete.trfPropPesoItem;
    3: FTipRatFreteRPA := TTipoRateioFrete.trfDefinirEntrada;
    4: FTipRatFreteRPA := TTipoRateioFrete.trfPropQtdItem;
    5: FTipRatFreteRPA := TTipoRateioFrete.trfInformarPercentuais;
  end;

End;

Function TEntOutrasDespesas.fTemClassificaoCompra: Boolean;
  Var
    qryEntMer: TUniQuery;
Begin
  qryEntMer := fCriaQuery;

  With qryEntMer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM TMP_ENTMER LIMIT 1');
    Open;

    Result := (Not IsEmpty) And (Pos(FieldByName('ENT_CLAFIS').AsString, VS_strClaCom) > 0);

    Close;
  End;

  FreeAndNil(qryEntMer);
End;

function TEntOutrasDespesas.fTemRegistroNaoEfetivado: Boolean;
begin
  cdsOutDes.First;
  Result := False;
  While not cdsOutDes.Eof Do
  Begin
    If cdsOutDes.FieldByName('OUT_EFETIV').AsString = 'N' then
      Exit(True);
    cdsOutDes.Next;
  End;

end;

function TEntOutrasDespesas.fTotalFreteRpa: Double;
begin
  Result := 0;

  if Not Assigned(cdsOutDes.FindField('RPAFRE')) then
    Exit;

  cdsOutDes.First;
  While Not cdsOutDes.Eof do
  begin
    if cdsOutDes.FieldByName('RPAFRE').AsString = 'S' THEN
      Result := Result +  cdsOutDes.FieldByName('VALOUT').AsFloat;
    cdsOutDes.Next;
  end;
end;

procedure TEntOutrasDespesas.pInsereDepesasImportacao(fltValor: Double);
begin
  cdsOutDes.Insert;
  cdsOutDes.FieldByName('VALOUT').AsFloat  := fltValor;
  cdsOutDes.FieldByName('HISTOR').AsString  := 'DESPESAS IMPORTACAO';
  cdsOutDes.FieldByName('NOMFOR').AsString  := 'DESPESAS IMPORTACAO';
  cdsOutDes.Post;

  FblnTemOutrasDespesasNotaDeImportacao :=  fltValor > 0;
end;

Function TEntOutrasDespesas.fInformaOutrasDespesas(var arrDuplicata: TarrDuplicata; strForEnt: String; dtaDtaBase : TDate; blnVariasNotas: Boolean = False): Boolean;
Begin
  Result := False;
  If blnDigAposEntrada Then
    blnRateioManual := False;

  If (Not blnDigAposEntrada) And (Not blnVariasNotas) And (Not fTemClassificaoCompra) Then
  Begin
    pMensagemOk('A Classificação fiscal dos itens não está cadastrada como Classificação de Compra!');
    Exit;
  End;

  Try

    pCriarFormularios(TfrmEntDadosOutrasDespesas, frmEntDadosOutrasDespesas);
    blnRateioManual := False;
    frmEntDadosOutrasDespesas.arrDuplicata := @arrDuplicata;
    frmEntDadosOutrasDespesas.blnDigAposEntrada := blnDigAposEntrada;
    frmEntDadosOutrasDespesas.rdgTipoRateio.ItemIndex := fOpcRateioOutrasDespesasToInteger(FOpcRateioOutrasDespesasCfg);
    If Assigned(frmEntDadosOutrasDespesas) Then
    With frmEntDadosOutrasDespesas Do
    Begin
      cdsDados.Data := cdsOutDes.Data;
      dtaDtaEnt := dtaDtaBase;
      pAtribuirGetTextRPAFRE;
      blnEntMer := True;
      frmEntDadosOutrasDespesas.tipRatFreRpa := self.tipRatFreteRPA;
      If blnTemOutrasDespesasNotaDeImportacao Then
      begin
        frmEntDadosOutrasDespesas.rdgTipoRateio.Enabled := False;
        frmEntDadosOutrasDespesas.rdgTipoRateio.ItemIndex := 0;
      End;
      If ShowModal = mrOk Then
      Begin
        self.tipRatFreteRPA := frmEntDadosOutrasDespesas.tipRatFreRpa;
        FOpcRateioOutrasDespesasSel :=  fIntegerToOpcRateioOutrasDespesas(frmEntDadosOutrasDespesas.rdgTipoRateio.ItemIndex);
        FdtaDtaBas := dtaDtaBase;
        fltValOut := 0.00;
        fltValRPA := 0;
        With cdsOutDes Do
        Begin
          cdsOutDes.Data := cdsDados.Data;

          First;
          While Not Eof Do
          Begin
            if FieldByName('RPAFRE').AsString = 'S' then
              fltValRPA := fltValRPA+ FieldByName('VALOUT').AsFloat
            Else
              fltValOut := fltValOut + FieldByName('VALOUT').AsFloat;
            Next;
          End;
        End;


        If blnVariasNotas Then
          Result := True
        Else
        begin
          Result := fRateiaOutrasDespesas;

          If FOpcRateioOutrasDespesasSel = opcRatOutDesManual then
            pDigRateioManual;
        End;
      End;

    End;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TEntOutrasDespesas.fInformaOutrasDespesas]');
      Result := False;
    End;

  End;

  If Assigned(frmEntDadosOutrasDespesas) Then
    FreeAndNil(frmEntDadosOutrasDespesas);
End;


procedure TEntOutrasDespesas.pDigRateioManual;
Begin
  pCriarFormularios(TfrmRateioManualOutrasDespesas, frmRateioManualOutrasDespesas);
  frmRateioManualOutrasDespesas.blnDigAposEntrada := blnDigAposEntrada;
  frmRateioManualOutrasDespesas.fltValOut := fltValOut;
  Try
    frmRateioManualOutrasDespesas.ShowModal;

    If frmRateioManualOutrasDespesas.blnConfirma Then
      blnRateioManual := True;
  finally
    FreeAndNil(frmRateioManualOutrasDespesas);
  End;
End;

function TEntOutrasDespesas.fOpcRateioOutrasDespesasToInteger(
  OpcRateioOutrasDespesas: TOpcRateioOutrasDespesas): integer;
begin
  Result := 0;
  case OpcRateioOutrasDespesas of
    opcRatOutDesValorItem : Result := 0;
    opcRatOutDesPesoItem  : Result := 1;
    opcRatOutDesQuantidade: Result := 2;
    opcRatOutDesManual    : Result := 3;
  End;
end;

procedure TEntOutrasDespesas.pPrencheDados(qryDados: TUniQuery;
  var DataSetDestino: TUniClientDataSet);
var i: integer;
begin
  blnRateioManual := False;
  cdsOutDes.EmptyDataSet;
  qryDados.First;
  while not qryDados.Eof Do
  Begin
    cdsOutDes.Insert;
    for I := 0 to cdsOutDes.Fields.Count -1 do
      cdsOutDes.Fields[i].Value := qryDados.FieldByName(cdsOutDes.Fields[i].FieldName).Value;
    cdsOutDes.Post;
    qryDados.Next;
  End;

  DataSetDestino := cdsOutDes;


  FOpcRateioOutrasDespesasSel := fIntegerToOpcRateioOutrasDespesas(cdsOutDes.FieldByName('OUT_TIPRAT').AsInteger);
  cdsOutDes.First;
  fltValOut := 0;
  While Not cdsOutDes.Eof Do
  Begin
    if cdsOutDes.FieldByName('RPAFRE').AsString = 'S' then
      fltValRPA := fltValrpa + cdsOutDes.FieldByName('VALOUT').AsFloat
    Else
      fltValOut := fltValOut + cdsOutDes.FieldByName('VALOUT').AsFloat;
    cdsOutDes.Next;
  End;
  pCriaTemporaria_e_InsereDados(qryDados.FieldByName('AUTOINCREM').AsString);
end;

procedure TEntOutrasDespesas.pRemovePendentes;
var qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('DELETE FROM OUTDES WHERE DET_SEQGER = "'+FstrAutoIncrem+'" AND OUT_EFETIV = "N"');
    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;

end;

function TEntOutrasDespesas.fIntegerToOpcRateioOutrasDespesas(Index: Integer): TOpcRateioOutrasDespesas;
begin
  Result := opcRatOutDesValorItem;
  case Index of
   0 : Result := opcRatOutDesValorItem;
   1 : Result := opcRatOutDesPesoItem;
   2 : Result := opcRatOutDesQuantidade;
   3 : Result := opcRatOutDesManual;
  End;
End;

destructor TEntOutrasDespesas.Destroy;
begin
  FreeAndNil(cdsOutDes);
  Inherited;
end;

function TEntOutrasDespesas.fAutoIncrem(strAutoIncrem: String): TEntOutrasDespesas;
begin
  Result := Self;
  FstrAutoIncrem := strAutoIncrem;
end;

Function TEntOutrasDespesas.fGravaContasAPagar(strForEnt, strNumDoc, strEspDoc,
                 strCodEmp, strSerie{, strCodEve},strTipFor, strCompet: String;
                 intCtpCon: Integer; dtaDtaEnt: TDate; blnVariasNotas: Boolean = False;
                 blnConferenciaDepoisDaEntrada: Boolean = False; blnDevolu: Boolean = False; blnRecCliGarantia: Boolean = False;
                 blnConEqu: Boolean = False; blnGarantia: Boolean = False; blnUtilizarCFG_CLARET: Boolean = False ): Boolean;

  Var
    strHistorico,
    strNotEnt,
    strVeioBO,
    strBcoFor,
    strDeposi,
    strVeioNF: String;
    intContador: Integer;
    stlDuplic : TStringList;
    blnGerFin: Boolean;
    blnRPAFre: Boolean;
    strPrefixoHistorico: String;
    strSufixoHistorico: String;
Begin
  Result := True;

  If ((fltValOut + fTotalFreteRpa) <= 0)  Then
    Exit;

  If blnVariasNotas Then
    strNotEnt    := ''
  Else
    strNotEnt    := strNumDoc + strEspDoc + strCodEmp + fstrEspaco(strSerie, 3) + strForEnt;

  strSufixoHistorico := strEspDoc + ' ' + strNumDoc + '-' + strCodEmp + ' SERIE: ' + strSerie;
  stlDuplic := TStringList.Create;

  with cdsOutDes Do
  Begin
    First;

    While not Eof Do
    Begin

      If FieldByName('HISTOR').AsString = 'DESPESAS IMPORTACAO' Then
      Begin
        Next;
        Continue;
      End;

      If FieldByName('OUT_EFETIV').AsString = 'S' Then
      Begin
        Next;
        Continue;
      End;

      blnRPAFre := FieldByName('RPAFRE').AsString = 'S';

      If blnRPAFre then
       strPrefixoHistorico := 'REFERENTE A OUTRAS DESPESAS DE RPA '
      else If blnVariasNotas Then
        strPrefixoHistorico := 'REF.OUTRAS DESPESAS NO CONNHEC.FRETE '
      else
        strPrefixoHistorico := 'REF.OUTRAS DESPESAS ';

      strHistorico := strPrefixoHistorico + strSufixoHistorico;
      stlDuplic.Text := FieldByName('DUPLIC').AsString;

      strVeioNF := Copy(FieldByName('VEIONF').AsString,0,1);
      strVeioBO := Copy(FieldByName('VEIOBO').AsString,0,1);
      strBcoFor := FieldByName('BCOFOR').AsString;
      strDeposi := Copy(FieldByName('DEPOSI').AsString,0,1);
      blnGerFin := FieldByName('GERFIN').AsString = 'SIM';

      For intContador := 0 To stlDuplic.Count -1 Do
      Begin
        If (Result) And (blnGerFin) Then
          Result := fGravaCadPag('untEntOutrasDespesas - fGravaContasAPagar',                   // Nome Form LOGCTP
                                 'INCLUSAO ENTRADA OUTRAS DESPESAS',                            // Descrição LOGCTP
                                 FieldByName('CODFOR').AsString,                                // Fornecedor
                                 fRetSequencialCadPag,                                          // Numero da Duplicata
                                 Trim( LeftStr(stlDuplic[intContador],5) ),                     // Parcela
                                 VS_strCodEmp,                                                  // Empresa
                                 FieldByName('CODCTA').AsString,                                // Centro de Custo
                                 '',                                                            // Serie do Documento
                                 0,                                                             // Sequencial de Baixa
                                 IIF(blnConferenciaDepoisDaEntrada And (not (blnDevolu Or blnRecCliGarantia Or blnConEqu Or blnGarantia)) And (strTipFor <> 'M'), 0, dtaDtaEnt),                                                     // Data do lançamento
                                 StrToDate(  Copy(stlDuplic[intContador],6, 10)),               // Data de Vencimento
                                 fStrToFloat( Copy(stlDuplic[intContador], 16, length(stlDuplic[intContador]))), // Valor da Duplicata
                                 fStrToFloat( Copy(stlDuplic[intContador], 16, length(stlDuplic[intContador]))), // Valor Original
                                 'N',                                                           // Previsão?
                                 strVeioBO,                                                     // Veio Boleto
                                 strDeposi,                                                     // Deposito
                                 strHistorico + ' '+FieldByName('HISTOR').AsString,             // Histórico 1
                                 '',                                                            // Histórico 2
                                 '',                                                            // Histórico da Baixa
                                 '',                                                            // Portador da Baixa
                                 '',                                                            // Centro de Custo da Baixa
                                 '',                                                            // Documento da Baixa
                                 '',                                                            // Operador da Baixa
                                 0,                                                             // Data do Pagamento
                                 0,                                                             // Valor Pago
                                 0,                                                             // Valor de Juros
                                 0,                                                             // Valor Desconto
                                 VS_strCodEmp,                                                  // Empresa
                                 FieldByName('CODEVE').AsString{strCodEve},                     // Código do Evento
                                 'N',                                                           // Usa Cheque
                                 FieldByName('CODPOR').AsString,                                // Codigo do Portador
                                 '',                                                            // Nro do Documento da Baixa
                                 0.0,
                                 0.0,
                                 intCtpCon,
                                 False, //blnResCai
                                 0,     //intRcxCon
                                 '1',   //strTipDoc
                                 0,     //fltVendor
                                 strVeioNF,    //strVeioNF
                                 strNotEnt, // Nota de Entrada
                                 CTP_OUTRAS_DESPESAS,
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 'N',
                                 strCompet,                                                     //Competência
                                 '',
                                 '',
                                 '',
                                 '',
                                 0,
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
                                 '0',
                                 '',
                                 strBcoFor,
                                 '',
                                 '',
                                 'N');

        If Not Result Then
          Break;

      End;

      Next;

    End;

  End;
  pGravarOutDes(IIF(blnDigAposEntrada, 'A', 'E'));
  FreeAndNil(stlDuplic);

End;

Function TEntOutrasDespesas.fRateiaOutrasDespesas: Boolean;
  Var
    qryEntMer: TUniQuery;
    fltTotIte,
    fltOutDes,
    fltOutDesIte,
    fltOutDesAcu: Double;
    intNumReg: Integer;
    strFieldSel: String;
Begin
  Try
    qryEntMer := fCriaQuery;

    With qryEntMer Do
    Begin
      fltOutDes    := fltValOut;

      Close;
      SQL.Clear;
      case FOpcRateioOutrasDespesasSel of
        opcRatOutDesValorItem : SQL.Add('SELECT SUM(ENT_TOTITE)AS TOTITE FROM TMP_ENTMER');
        opcRatOutDesPesoItem  : Begin
                                  If blnDigAposEntrada Then
                                     SQL.Add('SELECT SUM(ENT_ITEEMB * ITE_PESOIT)AS TOTITE FROM TMP_ENTMER INNER JOIN CADITE ON ITE_CODITE = ENT_CODITE')
                                  Else
                                  Begin
                                    If blnConverteQtdItensEmb Then
                                      SQL.Add('SELECT SUM((ENT_QTDITE * ENT_EMBALA) * ITE_PESOIT)AS TOTITE FROM TMP_ENTMER INNER JOIN CADITE ON ITE_CODITE = ENT_CODITE')
                                    Else
                                      SQL.Add('SELECT SUM(ENT_QTDITE * ITE_PESOIT)AS TOTITE FROM TMP_ENTMER INNER JOIN CADITE ON ITE_CODITE = ENT_CODITE');
                                  End;
                                End;
        opcRatOutDesQuantidade: Begin
                                  If blnDigAposEntrada Then
                                     SQL.Add('SELECT SUM(ENT_ITEEMB)AS TOTITE FROM TMP_ENTMER')
                                  Else
                                     SQL.Add('SELECT SUM(ENT_QTDITE)AS TOTITE FROM TMP_ENTMER');
                                End;
        Else
         SQL.Add('SELECT SUM(ENT_TOTITE)AS TOTITE FROM TMP_ENTMER');
      End;
      Open;
      fltTotIte := FieldByName('TOTITE').AsFloat;

      case FOpcRateioOutrasDespesasSel of
        opcRatOutDesValorItem : strFieldSel := 'ENT_TOTITE';
        opcRatOutDesPesoItem  : strFieldSel := 'ENT_PESITE';
        opcRatOutDesQuantidade: begin
                                  If blnDigAposEntrada Then
                                    strFieldSel := 'ENT_ITEEMB'
                                  Else
                                    strFieldSel := 'ENT_QTDITE';
                                End
       Else
        strFieldSel := 'ENT_TOTITE';
      End;

      Close;
      SQL.Clear;
      If FOpcRateioOutrasDespesasSel = opcRatOutDesPesoItem then
      Begin
        If blnDigAposEntrada Then
          SQL.Add('SELECT TMP_ENTMER.*, (ENT_ITEEMB * ITE_PESOIT) AS ENT_PESITE FROM TMP_ENTMER  INNER JOIN CADITE ON ITE_CODITE = ENT_CODITE')
        Else
        Begin
          If blnConverteQtdItensEmb Then
            SQL.Add('SELECT TMP_ENTMER.*, ((ENT_QTDITE * ENT_EMBALA )* ITE_PESOIT) AS ENT_PESITE FROM TMP_ENTMER  INNER JOIN CADITE ON ITE_CODITE = ENT_CODITE')
          Else
            SQL.Add('SELECT TMP_ENTMER.*, (ENT_QTDITE * ITE_PESOIT) AS ENT_PESITE FROM TMP_ENTMER  INNER JOIN CADITE ON ITE_CODITE = ENT_CODITE')
        End;
      End
      Else
        SQL.Add('SELECT * FROM TMP_ENTMER');
      Open;

      fltOutDesAcu := 0;
      intNumReg    := 0;

      While Not Eof Do
      Begin
        Inc(intNumReg);

        If intNumReg = RecordCount Then
        Begin
          fltOutDesIte := fltOutDes - fltOutDesAcu;
        End Else
        Begin
          fltOutDesIte := RoundTo((FieldByName(strFieldSel).AsFloat / fltTotIte) * fltOutDes, -2);
          fltOutDesAcu := fltOutDesAcu + fltOutDesIte;
        End;

        Edit;
        FieldByName('ENT_OUTDES').AsFloat := fltOutDesIte;
        Post;

        Next;
      End;

      Close;
    End;

    FreeAndNil(qryEntMer);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntOutrasDespesas.OutrasDespesas]');
    End;
  End;
End;

function TEntOutrasDespesas.fRetOutrasDespesasDigitacao: String;
  Var
    fltTotal: Double;
    strLinha  : String;
    stlDuplic : TStringList;
    intIndex  : Integer;
begin
  Result := '';
  stlDuplic := TStringList.Create;

  With cdsOutDes Do
  Begin
    First;

    If Not IsEmpty Then
      Result := 'Plano de Contas: ' + fFormataCCusto(FieldByName('CODCTA').AsString) + '-' + fRetDescCentroCusto(FieldByName('CODCTA').AsString) + #13#10;

    While not Eof Do
    Begin
      fltTotal := 0.00;
      strLinha := '';
      stlDuplic.Text := FieldByName('DUPLIC').AsString;

      For intIndex := 0 To stlDuplic.Count -1 Do
      Begin

        fltTotal := fltTotal + fStrToFloat( Copy(stlDuplic[intIndex], 16, length(stlDuplic[intIndex])));
        strLinha := strLinha  + ' - ' + Copy(stlDuplic[intIndex],6, 10) +
                           '   ' +  FormatFloat('#0.00', fStrToFloat( Copy(stlDuplic[intIndex], 16, length(stlDuplic[intIndex])))) + '  --  ';
      End;

      If fltTotal > 0 Then
        Result := Result + 'Fornecedor: ' + FieldByName('CODFOR').AsString + '-' + fRetNomFornecedor(FieldByName('CODFOR').AsString) +
                  '   Valor: ' + FormatFloat('#0.00', fltTotal) +  #13#10 + strLinha ;

      if not Eof Then
        Result := Result + #13#10;

      Next;

    End;

  End;
  FreeAndNil(stlDuplic);

end;

procedure TEntOutrasDespesas.pCarregaValorOut;
Begin
  fltValOut := 0;
  with cdsOutDes do
  Begin
    First;
    While Not Eof Do
    Begin
      fltValOut := fltValOut + FieldByName('VALOUT').AsFloat;
      Next;
    End;
  End;
End;

procedure TEntOutrasDespesas.pGravarOutDes(AOrigem: String = 'E'; blnEfetivado: Boolean = True; intTipRat: integer = 0);
Var
  objOutDes: TUniQuery;
  objCampo: TField;
  objParametro: TUniParam;
begin
  If blnDigAposEntrada Then
    pRemovePendentes;
  objOutDes := fCriaQuery;
  try
    objOutDes.SQL.Add('INSERT INTO OUTDES (');
    If blnDigAposEntrada Then
    Begin
      objOutDes.SQL.Add('OUT_DTAGRA,');
      objOutDes.SQL.Add('OUT_CODOPE,');
    End;

    objOutDes.SQL.Add('AUTOINCREM,');
    objOutDes.SQL.Add('DET_SEQGER,');
    objOutDes.SQL.Add('OUT_CODFOR,');
    objOutDes.SQL.Add('OUT_CODCTA,');
    objOutDes.SQL.Add('OUT_CODPOR,');
    objOutDes.SQL.Add('OUT_VEIONF,');
    objOutDes.SQL.Add('OUT_VEIOBO,');
    objOutDes.SQL.Add('OUT_DEPOSI,');
    objOutDes.SQL.Add('OUT_BCOFOR,');
    objOutDes.SQL.Add('OUT_CODEVE,');
    objOutDes.SQL.Add('OUT_CNDPAG,');
    objOutDes.SQL.Add('OUT_VALOUT,');
    objOutDes.SQL.Add('OUT_DUPLIC,');
    objOutDes.SQL.Add('OUT_HISTOR,');
    objOutDes.SQL.Add('OUT_GERFIN,');
    objOutDes.SQL.Add('OUT_RPAFRE,');
    objOutDes.SQL.Add('OUT_ORIGEM,');
    objOutDes.SQL.Add('OUT_EFETIV,');
    objOutDes.SQL.Add('OUT_TIPRAT ');
    objOutDes.SQL.Add(')');
    objOutDes.SQL.Add('VALUES');
    objOutDes.SQL.Add('(');
    If blnDigAposEntrada Then
    Begin
      objOutDes.SQL.Add(':OUT_DTAGRA,');
      objOutDes.SQL.Add(':OUT_CODOPE,');
    End;
    objOutDes.SQL.Add(':AUTOINCREM,');
    objOutDes.SQL.Add(':DET_SEQGER,');
    objOutDes.SQL.Add(':OUT_CODFOR,');
    objOutDes.SQL.Add(':OUT_CODCTA,');
    objOutDes.SQL.Add(':OUT_CODPOR,');
    objOutDes.SQL.Add(':OUT_VEIONF,');
    objOutDes.SQL.Add(':OUT_VEIOBO,');
    objOutDes.SQL.Add(':OUT_DEPOSI,');
    objOutDes.SQL.Add(':OUT_BCOFOR,');
    objOutDes.SQL.Add(':OUT_CODEVE,');
    objOutDes.SQL.Add(':OUT_CNDPAG,');
    objOutDes.SQL.Add(':OUT_VALOUT,');
    objOutDes.SQL.Add(':OUT_DUPLIC,');
    objOutDes.SQL.Add(':OUT_HISTOR,');
    objOutDes.SQL.Add(':OUT_GERFIN,');
    objOutDes.SQL.Add(':OUT_RPAFRE,');
    objOutDes.SQL.Add(':OUT_ORIGEM,');
    objOutDes.SQL.Add(':OUT_EFETIV,');
    objOutDes.SQL.Add(':OUT_TIPRAT ');
    objOutDes.SQL.Add(')');

    cdsOutDes.First;
    while Not cdsOutDes.Eof do
    Begin
      If cdsOutDes.FieldByName('OUT_EFETIV').AsString = 'S' Then
      Begin
        cdsOutDes.Next;
        Continue;
      End;

      for objCampo in cdsOutDes.Fields do
      begin
        objParametro := objOutDes.FindParam('OUT_' + objCampo.FieldName);
        If Assigned(objParametro) Then
          objParametro.Value := objCampo.Value;
      end;
      objOutDes.ParamByName('AUTOINCREM').Value := fRetAutoIncrem('OUTDES', VS_strCodEmp);;
      objOutDes.ParamByName('DET_SEQGER').Value := FstrAutoIncrem;
      objOutDes.ParamByName('OUT_ORIGEM').Value := AOrigem;
      objOutDes.ParamByName('OUT_EFETIV').Value := IIf(blnEfetivado, 'S','N');

      If blnDigAposEntrada Then
      Begin

        objOutDes.ParamByName('OUT_DTAGRA').AsDateTime := fNow;
        objOutDes.ParamByName('OUT_CODOPE').AsString := strLoginUsuarioLogado;
      End;

      objOutDes.ParamByName('OUT_TIPRAT').Value := fOpcRateioOutrasDespesasToInteger(FOpcRateioOutrasDespesasSel);
      objOutDes.ExecSQL;

      cdsOutDes.Next;
    End;

  finally
    objOutDes.Free;
  end;
end;

function TEntOutrasDespesas.fRetOpcRateioOutrasDespesasCfg:TOpcRateioOutrasDespesas;
var opcRateio: integer;
begin
  If fEmptyStr(fCfgSis('RATODE')) Then
    opcRateio := 0
  Else
    opcRateio := StrToInt(fCfgSis('RATODE'));
  Result := opcRatOutDesValorItem;
  case opcRateio of
    0 : result := opcRatOutDesValorItem;
    1 : result := opcRatOutDesPesoItem;
    2 : result := opcRatOutDesQuantidade;
    3 : result := opcRatOutDesManual;
  End;
End;

procedure TEntOutrasDespesas.pCriaTemporaria_e_InsereDados(strIncMovGer: String);
var qryGenMer: TUniQuery;
begin
  FstrAutoIncrem := strIncMovGer;
  qryGenMer := fCriaQuery;
  Try

    If fTabelaExiste('TMP_ENTMER') Then
      pDeletaTabelaEntradaMercadorias;

    fDropTable('TMP_ENTTMP');

    qryGenMer.SQL.Add('CREATE TEMPORARY TABLE TMP_ENTMER( ');
    qryGenMer.SQL.Add('SELECT D.AUTOINCREM,');
    qryGenMer.SQL.Add('       LTP_BAIXAD,');
    qryGenMer.SQL.Add('       DET_VLRCON  AS VLRCON,');
    qryGenMer.SQL.Add('       DET_TOTITE AS ENT_TOTITE,');
    qryGenMer.SQL.Add('       DET_QTDITE AS ENT_QTDITE,');
    qryGenMer.SQL.Add('       DET_QTDITE/IF(IFNULL(ENT_EMBALA, 0) > 0, ENT_EMBALA, 1) AS ENT_ITEEMB,');
    qryGenMer.SQL.Add('       DET_CLAFIS AS ENT_CLAFIS,');
    qryGenMer.SQL.Add('       DET_OUTDES AS DET_OUTDES_ORI, ');
    qryGenMer.SQL.Add('       DET_CODITE AS ENT_CODITE,');
    qryGenMer.SQL.Add('       ITE_DESITE AS ENT_DESITE,');
    qryGenMer.SQL.Add('       DET_ORIDOC,');
    qryGenMer.SQL.Add('       DET_NUMDOC,');
    qryGenMer.SQL.Add('       DET_ESPDOC,');
    qryGenMer.SQL.Add('       DET_CODEMP,');
    qryGenMer.SQL.Add('       DET_CODFOR,');
    qryGenMer.SQL.Add('       DET_SERIE_,');
    qryGenMer.SQL.Add('       DET_CODITE,');
    qryGenMer.SQL.Add('       DET_QTDITE,');
    qryGenMer.SQL.Add('       DET_TOTITE,');
    qryGenMer.SQL.Add('       DET_DESACE AS ENT_DESACE, ');
    qryGenMer.SQL.Add('       DET_DESESP,');
    qryGenMer.SQL.Add('       DET_VALIPI,');
    qryGenMer.SQL.Add('       DET_TOTULT,');
    qryGenMer.SQL.Add('       DET_NUMLOT,');
    qryGenMer.SQL.Add('       DET_ALQICM,');
    qryGenMer.SQL.Add('       MOVTRI.DET_VAEIPI,');
    qryGenMer.SQL.Add('       MOVTRI.DET_ATUPRE,');
    qryGenMer.SQL.Add('       IFNULL(MOVTRI.DET_ICMNCR, 0) AS DET_ICMNCR, ');
    qryGenMer.SQL.Add('       IFNULL(MOVTRI.DET_FCPNCR, 0) AS DET_FCPNCR, ');
    qryGenMer.SQL.Add('       DET_OUTDES,');
    qryGenMer.SQL.Add('       DET_VENDOR,');
    qryGenMer.SQL.Add('       DET_DESACE,');
    qryGenMer.SQL.Add('       DET_ICMANT,');
    qryGenMer.SQL.Add('       DET_VLGNRE,');
    qryGenMer.SQL.Add('       DET_VALTCI,');
    qryGenMer.SQL.Add('       DET_VAL_TS,');
    qryGenMer.SQL.Add('       DET_VALRET,');
    qryGenMer.SQL.Add('       DET_VAERET,');
    qryGenMer.SQL.Add('       DET_VFCPST,');
    qryGenMer.SQL.Add('       DET_ALQPIS,');
    qryGenMer.SQL.Add('       DET_ALQCOF,');
    qryGenMer.SQL.Add('       DET_VALICM,');
    qryGenMer.SQL.Add('       DET_CLAFIS,');
    qryGenMer.SQL.Add('       DET_CODFIS,');
    qryGenMer.SQL.Add('       DET_UNITAR,');
    qryGenMer.SQL.Add('       ITE_INCPIS,');
    qryGenMer.SQL.Add('       ITE_SALDOS,');
    qryGenMer.SQL.Add('       DET_TOTMED,');
    qryGenMer.SQL.Add('       DET_CONFRE,');
    qryGenMer.SQL.Add('       DET_TOTFRE,');
    qryGenMer.SQL.Add('   (SELECT  SUM(D2.DET_QTDITE) FROM MOVDET D2 WHERE D2.DET_CODITE = D.DET_CODITE AND D2.DET_SEQGER = D.DET_SEQGER) QTDTOT, ');

    qryGenMer.SQL.Add('       IFNULL(V.ICD_PERFCP, 0) AS ICD_PERFCP, ');
    qryGenMer.SQL.Add('       IFNULL(V.ICD_VALFCP, 0) AS ICD_VALFCP, ');
    qryGenMer.SQL.Add('       DET_PERBAS,');

    qryGenMer.SQL.Add('       ENT_MOVDET                , ');
    qryGenMer.SQL.Add('       TRI_EMBALA AS ENT_EMBALA  , ');
    qryGenMer.SQL.Add('       ENT_PRECOM_SEM_CALC       , ');
    qryGenMer.SQL.Add('       ENT_PRECOM                , ');
    qryGenMer.SQL.Add('       ENT_PRECUS                , ');
    qryGenMer.SQL.Add('       ENT_OUTDES_NO_PRECOM      , ');
    qryGenMer.SQL.Add('       ENT_OUTDES                , ');
    qryGenMer.SQL.Add('       ENT_FREITE                , ');
    qryGenMer.SQL.Add('       DET_CFRECO AS ENT_FRECON  , ');
    qryGenMer.SQL.Add('       ENT_FRERPA                , ');
    qryGenMer.SQL.Add('       ENT_OUTDES_NO_FREITE      , ');
    qryGenMer.SQL.Add('       ENT_FREENT                , ');
    qryGenMer.SQL.Add('       DET_CFRETE AS ENT_VALFRE  , ');
    qryGenMer.SQL.Add('       DET_ALQFRE                , ');
    qryGenMer.SQL.Add('       ENT_DESESP                , ');
    qryGenMer.SQL.Add('       ENT_ENCARGOS_NO_FRET      , ');
    qryGenMer.SQL.Add('       ENT_PREFRE                , ');
    qryGenMer.SQL.Add('       ENT_FREIPI                , ');
    qryGenMer.SQL.Add('       ENT_VALRET                , ');
    qryGenMer.SQL.Add('       ENT_VAERET                , ');
    qryGenMer.SQL.Add('       ENT_VALANT                , ');
    qryGenMer.SQL.Add('       ENT_DESF01                , ');
    qryGenMer.SQL.Add('       ENT_DESF02                , ');
    qryGenMer.SQL.Add('       ENT_DESF03                , ');
    qryGenMer.SQL.Add('       ENT_DESF04                , ');
    qryGenMer.SQL.Add('       ENT_DESF05                , ');
    qryGenMer.SQL.Add('       ENT_DESF06                , ');
    qryGenMer.SQL.Add('       ENT_GNRORI                , ');
    qryGenMer.SQL.Add('       DET_VLGNRE AS ENT_VALGNR  , ');
    qryGenMer.SQL.Add('       ENT_VFCPST                , ');
    qryGenMer.SQL.Add('       ENT_VALIPI                , ');
    qryGenMer.SQL.Add('       ENT_VAEIPI                , ');
    qryGenMer.SQL.Add('       CADITE.ITE_RPRENT              , ');

    qryGenMer.SQL.Add('       MOVTRI.DET_SEQGER AS AUTINC_TRI ');
    qryGenMer.SQL.Add('  FROM MOVDET D');
    qryGenMer.SQL.Add(' INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = D.AUTOINCREM');
    qryGenMer.SQL.Add(' INNER JOIN CADITE ON CADITE.ITE_CODITE = D.DET_CODITE');
    qryGenMer.SQL.Add(' INNER JOIN ITEGER ON ITEGER.ITE_CODITE = DET_CODITE AND ITEGER.ITE_CODEMP = DET_CODEMP');
    qryGenMer.SQL.Add('  LEFT JOIN PREENT ON PREENT.ENT_MOVDET = D.AUTOINCREM');
    qryGenMer.SQL.Add('  LEFT JOIN LOTPRE ON LOTPRE.LTP_SEQDET = D.AUTOINCREM');


    qryGenMer.SQL.Add('  LEFT JOIN MOVICD V ON ICD_SEQGER = D.AUTOINCREM ');

    qryGenMer.SQL.Add(' WHERE D.DET_SEQGER = "'+strIncMovGer+'")');
    qryGenMer.ExecSQL;
  Finally
    FreeAndNil(qryGenMer);
  End;
End;

Function TEntOutrasDespesas.fAtualizaDocumento: Boolean;
var blnDedIcm,
    blnUltPis,
    blnNotImp,
    blnEncargosNoFrete,
    blnTemLote,
    blnAtuFre: Boolean;
    qryEntMer: TUniQuery;
    strAtuNmd,
    strCodFor: String;
    strForFil: String;
    fltComLot,
    fltIcmMed,
    fltPreMed,
    fltPreMedAnt,
    fltSaldosAnt,
    fltAlqPis,
    fltIcmDet,
    fltImpUlt,
    fltPreCom,
    fltValRetCalc,
    fltIpiCalc,

    fltTotUlt,
    fltPreUlt: Double;
    blnOutDesNoFreIte: Boolean;
    CalculoPrecoMediAgrup : TCalculoPrecoMediAgrup;
begin
  Result := True;
  CalculoPrecoMediAgrup := TCalculoPrecoMediAgrup.Create;
  Try
    If (FOpcRateioOutrasDespesasSel = opcRatOutDesManual) and (Not blnRateioManual) Then
    Begin
      Result := fRateiaOutrasDespesas;
      pDigRateioManual;
    End
    Else If FOpcRateioOutrasDespesasSel <> opcRatOutDesManual Then
      Result := fRateiaOutrasDespesas;

    blnAtuFre := fCfgSis('ATUFRE', varBoolean) And fCfgSis('ATPRAU', varBoolean);
    strAtuNmd := fCfgSis('ATUNMD');
    strForFil := fRetForFilialTodos;
    FPerFre := fCfgSis('PERFRE', VarInteger);


    strEmpMeds := fEmpresasMedEmp;
    strMedEmp  := fCfgSis('MEDEMP', varString);
    FDecUni := fCfgSis('DECUNI', varInteger);

    qryEntMer := fCriaQuery;
    qryEntMer.SQL.text := 'SELECT SUM(ENT_VALFRE) AS ENT_VALFRE, SUM(ENT_FRECON) AS ENT_FRECON,SUM(ENT_FRERPA) AS ENT_FRERPA, DET_CLAFIS, DET_CODFOR, ENT_OUTDES_NO_FREITE FROM TMP_ENTMER';
    qryEntMer.Open;
    strCodFor := qryEntMer.FieldByName('DET_CODFOR').AsString;
    If (Pos(strCodFor, strForFil) > 0) Then
      blnUltPis := fRetForFilialDeduzPisCofinsUltimaCompra(VS_strCodEmp, strCodFor)
    Else
      blnUltPis := fCfgSis('ULTPIS', VarBoolean);

    If (Pos(strCodFor, strForFil) > 0) Then
      blnDedIcm := fRetForFilialDeduzICMSUltimaCompra(VS_strCodEmp, strCodFor)
    Else
      blnDedIcm := fCfgSis('DEDICM', VarBoolean);


  blnEncargosNoFrete := (fCfgSis('ENCIMP') = '2') And (LeftStr(qryEntMer.FieldByName('DET_CLAFIS').AsString, 1) = '3');
  blnNotImp := (LeftStr(qryEntMer.FieldByName('DET_CLAFIS').AsString, 1) = '3');
  If Not (LeftStr(qryEntMer.FieldByName('DET_CLAFIS').AsString, 1) = '3') Then
  begin
    blnEncargosNoFrete := fCfgSis('OUDVFR', varBoolean);
  End;


  If qryEntMer.FieldByName('ENT_OUTDES_NO_FREITE').AsString = 'S' Then
     pAtualizaPercentuaisSubstituicaoFreteDoItem(False,
                                                  False,
                                                    False,
                                                    blnAtuFre,
                                                  False,
                                                  False,
                                                  blnEncargosNoFrete,
                                                  blnNotImp,
                                                  qryEntMer.FieldByName('ENT_VALFRE').AsFloat,
                                                  qryEntMer.FieldByName('ENT_FRECON').AsFloat  + qryEntMer.FieldByName('ENT_FRERPA').AsFloat,
                                                  blnOutDesNoFreIte);
    qryEntMer.SQL.text := 'SELECT * FROM TMP_ENTMER';
    qryEntMer.Open;


    While Not qryEntMer.Eof Do
    Begin
      If blnUltPis Then
        fltAlqPis := (qryEntMer.FieldByName('DET_ALQPIS').AsFloat + qryEntMer.FieldByName('DET_ALQCOF').AsFloat) / 100
      Else
        fltAlqPis := 0;


      If blnDedIcm Then
        fltIcmDet := qryEntMer.FieldByName('DET_VALICM').AsFloat + qryEntMer.FieldByName('ICD_VALFCP').AsFloat +
                     qryEntMer.FieldByName('DET_ICMNCR').AsFloat + qryEntMer.FieldByName('DET_FCPNCR').AsFloat
      Else
        fltIcmDet := 0;

      fltIpiCalc := qryEntMer.FieldByName('DET_VALIPI').AsFloat + qryEntMer.FieldByName('DET_VAEIPI').AsFloat;
      If blnUltPis And (fltIpiCalc > 0) And (fCfgSis('DPCIPU') = 'S') And (qryEntMer.FieldByName('ITE_INCPIS').AsString = 'S') Then
         fltIpiCalc := (fltIpiCalc * (1-(fltAlqPis)));

      fltValRetCalc :=  qryEntMer.FieldByName('DET_VALRET').AsFloat + qryEntMer.FieldByName('DET_VAERET').AsFloat;
      If (fCfgSis('DPCSTU') = 'S') And (blnUltPis) And (qryEntMer.FieldByName('ITE_INCPIS').AsString = 'S') Then
         fltValRetCalc := (fltValRetCalc * (1-(fltAlqPis)));

      fltImpUlt := fFormataFloat((((qryEntMer.FieldByName('DET_TOTITE').AsFloat -
                                    qryEntMer.FieldByName('DET_DESESP').AsFloat) * (1 - fltAlqPis) +

                           fltIpiCalc +

                           qryEntMer.FieldByName('ENT_VALFRE').AsFloat +
                           qryEntMer.FieldByName('ENT_FRECON').AsFloat +

                           qryEntMer.FieldByName('ENT_OUTDES').AsFloat +
                           qryEntMer.FieldByName('DET_VENDOR').AsFloat +
                           qryEntMer.FieldByName('DET_DESACE').AsFloat +
                           qryEntMer.FieldByName('DET_ICMANT').AsFloat +
                           qryEntMer.FieldByName('DET_VLGNRE').AsFloat +
                           qryEntMer.FieldByName('DET_VFCPST').AsFloat +
                           fltValRetCalc - fltIcmDet) / qryEntMer.FieldByName('DET_QTDITE').AsFloat), 4);




      pUpdateMovtri(qryEntMer.FieldByName('AUTINC_TRI').AsString,
                    qryEntMer.FieldByName('ENT_OUTDES').AsFloat,
                    fltImpUlt);

      fltTotUlt := ( qryEntMer.FieldByName('DET_TOTITE').AsFloat - qryEntMer.FieldByName('DET_DESESP').AsFloat );
      fltPreUlt := fltTotUlt / qryEntMer.FieldByName('DET_QTDITE').AsFloat;

      fltPreCom :=  qryEntMer.FieldByName('ENT_PRECOM_SEM_CALC').AsFloat;


      If (strAtuNMD = 'M') Then
        fltPreCom := qryEntMer.FieldByName('ENT_PRECOM').AsFloat
      Else If (strAtuNMD = 'U') Then
        fltPreCom := fltPreUlt
      Else If (strAtuNMD = 'D') Then
      Begin
        If blnEncargosNoFrete Then
          fltPreCom := fltPreUlt
        Else
          fltPreCom := fltPreUlt + ((qryEntMer.FieldByName('ENT_OUTDES').AsFloat + qryEntMer.FieldByName('ENT_DESACE').AsFloat) / qryEntMer.FieldByName('ENT_QTDITE').AsFloat );
      end
      Else If (strAtuNMD = 'I') Then
        fltPreCom :=  fltImpUlt
      Else If (strAtuNMD = 'O') Then
      Begin
        If Not blnEncargosNoFrete Then
          fltPreCom := fltPreCom + ((qryEntMer.FieldByName('ENT_OUTDES').AsFloat + qryEntMer.FieldByName('ENT_DESACE').AsFloat) / qryEntMer.FieldByName('ENT_QTDITE').AsFloat );
      End;


      fltComLot := fCalculaPrecoCompraBruto(fltPreCom,
                                            [qryEntMer.FieldByName('ENT_DESF01').AsFloat,
                                             qryEntMer.FieldByName('ENT_DESF02').AsFloat,
                                             qryEntMer.FieldByName('ENT_DESF03').AsFloat,
                                             qryEntMer.FieldByName('ENT_DESF04').AsFloat,
                                             qryEntMer.FieldByName('ENT_DESF05').AsFloat,
                                             qryEntMer.FieldByName('ENT_DESF06').AsFloat]);


      blnTemLote := fUpdateLotePrecos(qryEntMer.FieldByName('ENT_OUTDES_NO_FREITE').ASString = 'S', qryEntMer.FieldByName('ENT_FREITE').AsFloat, qryEntMer, fltComLot);

      If strMedEmp = '1' Then
        fltSaldosAnt := fSaldoEmpresas(qryEntMer.FieldByName('DET_CODITE').AsString, strEmpMeds)
      Else
        fltSaldosAnt := qryEntMer.FieldByName('ITE_SALDOS').AsFloat;

      fltSaldosAnt := fltSaldosAnt - qryEntMer.FieldByName('QTDTOT').AsFloat;
      If CalculoPrecoMediAgrup.CalculoPreMed[qryEntMer.FieldByName('DET_CODITE').AsString,''].blnEncontrado Then
         fltSaldosAnt := CalculoPrecoMediAgrup.CalculoPreMed[qryEntMer.FieldByName('DET_CODITE').AsString, ''].SaldoAnterior;

      fltPreMedAnt := qryEntMer.FieldByName('DET_TOTMED').AsFloat / qryEntMer.FieldByName('DET_QTDITE').AsFloat;

      fltPreMed := 0.00;

      If (Pos(strCodFor, strForFil) <= 0) Then
         fltIcmMed := IIF((Pos(qryEntMer.FieldByName('DET_CODFIS').AsString, CST_REDUCAO) > 0) ,
                                              fFormataFloat((qryEntMer.FieldByName('DET_ALQICM').AsFloat * qryEntMer.FieldByName('DET_PERBAS').AsFloat) / 100, 2),
                                               qryEntMer.FieldByName('DET_ALQICM').AsFloat + qryEntMer.FieldByName('ICD_PERFCP').AsFloat)
      Else
         fltIcmMed := 0;

      CalculoPrecoMediAgrup.strCodIteAtual := qryEntMer.FieldByName('DET_CODITE').AsString;
      If (fCfgSis('BASMED') <> 'S') And (qryEntMer.FieldByName('DET_ORIDOC').AsString <> 'D') Then
         fltPreMed := fCalculaPrecoMedio(qryEntMer.FieldByName('DET_CODFIS').AsString,               // Código Fiscal
                                         qryEntMer.FieldByName('DET_CLAFIS').AsString,        // ClassificacaoFiscal
                                         fltPreMedAnt,                                     // Preço medio anterior
                                         fltSaldosAnt,                                     // Saldo anterior
                                         qryEntMer.FieldByName('DET_QTDITE').AsFloat,                // Quantidade de entrada
                                         qryEntMer.FieldByName('DET_UNITAR').AsFloat,                // Unitario sem impostos

                                         fltIcmMed,                // Aliquota de ICMS do Item

                                         qryEntMer.FieldByName('DET_VALIPI').AsFloat +
                                         qryEntMer.FieldByName('DET_VAEIPI').AsFloat,                // Valor do IPI

                                         qryEntMer.FieldByName('DET_VALRET').AsFloat +
                                         qryEntMer.FieldByName('DET_VAERET').AsFloat,               // Valor de Substituição

                                         qryEntMer.FieldByName('DET_ICMANT').AsFloat, // Valor ICMS Antecipado

                                         qryEntMer.FieldByName('DET_VLGNRE').AsFloat,
                                         qryEntMer.FieldByName('DET_VALTCI').AsFloat,
                                         qryEntMer.FieldByName('DET_VAL_TS').AsFloat,

                                         fCfgSis('CONIPI', varBoolean),                    // Contribuinte de IPI?
                                         (Pos(strCodFor, strForFil) > 0), // Fornec Filial
                                         qryEntMer.FieldByName('ITE_INCPIS').AsString,               // Indice se incide Pis
                                         qryEntMer.FieldByName('ENT_FRERPA').AsFloat +

                                         qryEntMer.FieldByName('DET_TOTFRE').AsFloat +
                                         qryEntMer.FieldByName('DET_CONFRE').AsFloat,

                                         qryEntMer.FieldByName('DET_DESACE').AsFloat +
                                         qryEntMer.FieldByName('DET_VENDOR').AsFloat +
                                         qryEntMer.FieldByName('ENT_OUTDES').AsFloat,

                                         qryEntMer.FieldByName('DET_VALICM').AsFloat + qryEntMer.FieldByName('ICD_VALFCP').AsFloat,

                                         IIF((qryEntMer.FieldByName('DET_VALICM').AsFloat + qryEntMer.FieldByName('ICD_VALFCP').AsFloat) > 0,
                                             0,
                                             qryEntMer.FieldByName('DET_ICMNCR').AsFloat + qryEntMer.FieldByName('DET_FCPNCR').AsFloat),

                                         qryEntMer.FieldByName('DET_VFCPST').AsFloat,
                                         qryEntMer.FieldByName('DET_ALQFRE').AsFloat,
                                         CalculoPrecoMediAgrup,
                                         qryEntMer.FieldByName('DET_VAEIPI').AsFloat > 0);

      If (Pos(qryEntMer.FieldByName('DET_CLAFIS').AsString, '1922_2922_') <= 0) And (qryEntMer.FieldByName('DET_ORIDOC').AsString <> 'D') Then
      Begin
        pUpdateCadIte(qryEntMer.FieldByName('DET_CODITE').AsString,
                      strCodFor,
                      fCodificaChaveNota(qryEntMer.FieldByName('DET_NUMDOC').AsString,
                                         qryEntMer.FieldByName('DET_ESPDOC').AsString,
                                         qryEntMer.FieldByName('DET_CODEMP').AsString,
                                         qryEntMer.FieldByName('DET_SERIE_').AsString,
                                         strCodFor),
                      fltImpUlt,
                      fltPreMed);

         pAtualizaUltimaCompraCadLot(qryEntMer.FieldByName('DET_CODITE').AsString,
                                     qryEntMer.FieldByName('DET_NUMLOT').AsString,
                                     strCodFor,
                                     fCodificaChaveNota(qryEntMer.FieldByName('DET_NUMDOC').AsString,
                                                        qryEntMer.FieldByName('DET_ESPDOC').AsString,
                                                        qryEntMer.FieldByName('DET_CODEMP').AsString,
                                                        qryEntMer.FieldByName('DET_SERIE_').AsString,
                                                        strCodFor),
                                     qryEntMer.FieldByName('DET_CODEMP').AsString,
                                     fFormataFloat(qryEntMer.FieldByName('DET_TOTULT').AsFloat / qryEntMer.FieldByName('DET_QTDITE').AsFloat, 4),
                                     fltImpUlt,
                                     VS_Date,
                                     True);


        If (fltPreMed > 0) Then
          fGravaCalcPreMed(qryEntMer.FieldByName('AUTINC_TRI').AsString, 'TEntOutrasDespesas.fAtualizaDocumento', '', True);

        If blnAtuFre And (Not blnTemLote) And (qryEntMer.FieldByName('VLRCON').AsFloat > 0) Then
        Begin
          If qryEntMer.FieldByName('ENT_OUTDES_NO_FREITE').AsString = 'S' Then
             Result := fAtualizaFreteIteger(qryEntMer.FieldByName('DET_CODITE').AsString,
                                            fltPrecom,
                                            RoundTo(qryEntMer.FieldByName('ENT_FREITE').AsFloat , - FDecUni),
                                            qryEntMer.FieldByName('ITE_RPRENT').AsString = 'S',
                                            qryEntMer.FieldByName('ENT_OUTDES_NO_PRECOM').AsString = 'S',
                                            qryEntMer.FieldByName('ENT_OUTDES_NO_FREITE').AsString = 'S');


          If Not Result Then
            Break;
        End
        Else If (strAtuNmd = 'I') And (Not blnTemLote) And (qryEntMer.FieldByName('VLRCON').AsFloat > 0) Then
        Begin
          Result := fAtualizaPrecomIteger(qryEntMer.FieldByName('DET_CODITE').AsString,
                                          fltImpUlt,
                                          qryEntMer.FieldByName('ITE_RPRENT').AsString = 'S');


          If Not Result Then
            Break;
        End;

      End;

      qryEntMer.Next;

    End; {While Not Eof Do}
  Finally
    FreeAndNil(CalculoPrecoMediAgrup);
  End;
end;

procedure TEntOutrasDespesas.pUpdateMovtri(strAutInc: String; fltOutDes, fltImpUlt: Double);
  Var
    qryMovTri: TUniQuery;
Begin
  qryMovTri := fCriaQuery(Self);
  With qryMovTri, SQL Do
  Begin
    Add('UPDATE MOVTRI ');
    Add('SET ');


    Add('  DET_OUTDES = :OUTDES, ');
    Add('  DET_IMPULT = :IMPULT  ');
    Add('WHERE');
    Add('  DET_SEQGER = :AUTINC ');


    ParamByName('OUTDES').AsFloat  := fltOutDes;
    ParamByName('IMPULT').AsFloat  := fltImpUlt;

    ParamByName('AUTINC').AsString := strAutInc;

    ExecSQL;
  End;
  FreeAndNil(qryMovTri);
End;

Function TEntOutrasDespesas.fUpdateLotePrecos(blnEncargosNoFrete: Boolean; fltConFre: Double; cdsMovTri: TDataSet; fltPreCom: Double = -1): Boolean;
  Var
    qryLotPre: TUniQuery;
    intOpcAtu,
    intContador: Integer;
    srtCamAtu: String;
Begin
  qryLotPre := fCriaQuery(Self);

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
    ParamByName('AUTINC').AsString := cdsMovTri.FieldByName('AUTINC_TRI').AsString;
    Open;

    If (Not IsEmpty) Then
    Begin

      If (cdsMovTri.FieldByName('VLRCON').AsFloat > 0) Then
      Begin
        Edit;

        If (FPerFre = 2) or blnEncargosNoFrete  Then
        Begin
          FieldByName('LTP_VALFRE').AsFloat := fltConFre;
          FieldByName('LTP_FREENT').AsFloat := 0;
        End;

        If fltPreCom > -1 Then
          FieldByName('LTP_PRECOM').AsFloat := fltPreCom;

        With cpcParams Do
        Begin
          curPreCom := fltConFre;
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

procedure TEntOutrasDespesas.pUpdateCadIte(strCodIte, strCodFor, strNotUlt: String; fltImpUlt, fltPreMed: Double);
  Var
    qryIteger: TUniQuery;
Begin
  qryIteger := fCriaQuery(Self);
  With qryIteger, SQL Do
  Begin
    Add('UPDATE ITEGER');
    Add('SET ');
    Add('  ITE_FORULT = :CODFOR, ');
    Add('  ITE_DTAULT = :DTAULT, ');
    Add('  ITE_IMPULT = :IMPULT  ');

    If fltPreMed > 0 Then
      Add('  ,ITE_PREMED = :PREMED ');

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
    ParamByName('DTAULT').AsDate   := VS_Date;

    ExecSQL;
  End;

  FreeAndNil(qryIteger);

  If fltPreMed > 0 Then
    pAtualizaPrecoMedioEmpreas(strCodIte, strEmpMeds, fltPreMed);
End;


Function TEntOutrasDespesas.fAtualizaFreteIteger(strCodIte: String; fltPrecom, fltValFre: Double; blnPermiteReducaoPreco, blnAlteraPrecoCompra: Boolean; blnEncargosNoFrete: Boolean): Boolean;
  Var
    qryIteger: TUniQuery;
    intOpcAtu,
    intContador: Integer;
    strAgrupadorPreAlt: String;

    strEmpresas,
    srtCamAtu: String;

    arrPreVen: Array[1..7] Of Double;
    arrMarBru: Array[1..7] Of Double;
    fltPreCus: Double;

    Function fSQLIteger: String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT * FROM ITEGER ';
      strSQL := strSQL + ' WHERE ITE_CODITE = :CODITE ';
      strSQL := strSQL + '   AND LOCATE(ITE_CODEMP, :CODEMP) > 0 ';
      Result := strSQL;
    End;

Begin
  Result := True;

  strEmpresas := fRetEmpresasUsamPrecoMatriz;

  qryIteger := fCriaQuery(Self);

  pPreAltDefineVariaveisAltPre(fNow, 'ENTRADA DE MERCADORIAS', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

  With qryIteger, SQL Do
  Begin
    Close;

    SQL.Text := fSQLIteger;

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strEmpresas;

    Open;

    While Not Eof Do
    Begin

      fltPreCus := FieldByName('ITE_PRECUS').AsFloat;

      For intContador := 1 To 7 Do
      Begin
        arrPreVen[intContador] := FieldByName('ITE_PREVE' + IntToStr(intContador) ).AsFloat;
        arrMarBru[intContador] := FieldByName('ITE_MARBR' + IntToStr(intContador) ).AsFloat;
      End;

      Edit;

      If (FPerFre = 2) or blnEncargosNoFrete Then
      Begin
        FieldByName('ITE_VALFRE').AsFloat := fltValFre;
        FieldByName('ITE_FREENT').AsFloat := 0;
      End;

      With cpcParams Do
      Begin
        If blnAlteraPrecoCompra Then
          qryIteger.FieldByName('ITE_PRECOM').AsFloat := fltPrecom;

        curPreCom := FieldByName('ITE_PRECOM').AsFloat;
        curDesF01 := FieldByName('ITE_DESF01').AsFloat;
        curDesF02 := FieldByName('ITE_DESF02').AsFloat;
        curDesF03 := FieldByName('ITE_DESF03').AsFloat;
        curDesF04 := FieldByName('ITE_DESF04').AsFloat;
        curDesF05 := FieldByName('ITE_DESF05').AsFloat;
        curDesF06 := FieldByName('ITE_DESF06').AsFloat;
        curICMSEnt:= FieldByName('ITE_ICMENT').AsFloat;
        curIPIEnt := FieldByName('ITE_IPIENT').AsFloat;
        curFrete  := FieldByName('ITE_FREENT').AsFloat;
        curValFre := FieldByName('ITE_VALFRE').AsFloat;
        curAcrFin := FieldByName('ITE_ACRFIN').AsFloat;
        curSubsti := FieldByName('ITE_SUBSTI').AsFloat;
        curDesAdb := FieldByName('ITE_DESADB').AsFloat;
        curSubFed := FieldByName('ITE_SUBFED').AsFloat;

        if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
        begin
          curTCIFCu := FieldByName('ITE_TCIFCU').AsFloat;
          curTSCust := FieldByName('ITE_TSCUST').AsFloat;
          curDePiCo := FieldByName('ITE_DEPICO').AsFloat;
          curDeICMS := FieldByName('ITE_DEICMS').AsFloat;
          curFatReg := FieldByName('ITE_FATREG').AsFloat;
        end
        else
        begin
          curTCIFCu := 0;
          curTSCust := 0;
          curDePiCo := 0;
          curDeICMS := 0;
          curFatReg := 0;
        end;

        qryIteger.FieldByName('ITE_PRECUS').AsFloat := fCalculaPrecoCusto();
        FieldByName('ITE_PREALT').AsString:= strAgrupadorPreAlt;

        For intContador := 1 To Length(VS_strTabPrc) Do
        Begin
          intOpcAtu := IIF(blnATPVMB[intContador],  1,           2          );
          srtCamAtu := IIF(blnATPVMB[intContador], 'ITE_PREVE', 'ITE_MARBR' );

          FieldByName(srtCamAtu + IntToStr(intContador) ).AsFloat := fCalculaPrecoVenda(intOpcAtu,
                                                                                        FieldByName('ITE_PRECUS').AsFloat + FieldByName('ITE_OUTVAL').AsFloat,
                                                                                        FieldByName('ITE_PREVE' + IntToStr(intContador) ).AsFloat,
                                                                                        FieldByName('ITE_MARBR' + IntToStr(intContador) ).AsFloat,
                                                                                        FieldByName('ITE_ICMSAI').AsFloat,
                                                                                        FieldByName('ITE_IMPFED').AsFloat,
                                                                                        FieldByName('ITE_DESOPE').AsFloat,
                                                                                        FieldByName('ITE_COMTB' + IntToStr(intContador) ).AsFloat);
        End;

        If blnPermiteReducaoPreco Or (qryIteger.FieldByName('ITE_PREVE1').AsFloat >= arrPreVen[1]) Then
        Begin
          Post;
          If (Not VS_blnPreAltViaTrigger) Then
            Result := fGravaPreAlt(FieldByName('ITE_CODITE').AsString,

                               fltPrecus,
                               FieldByName('ITE_PRECUS').AsFloat,

                               arrPreVen[1],
                               FieldByName('ITE_PREVE1').AsFloat,

                               arrMarBru[1],
                               FieldByName('ITE_MARBR1').AsFloat,

                               arrPreVen[2],
                               FieldByName('ITE_PREVE2').AsFloat,

                               arrMarBru[2],
                               FieldByName('ITE_MARBR2').AsFloat,

                               arrPreVen[3],
                               FieldByName('ITE_PREVE3').AsFloat,

                               arrMarBru[3],
                               FieldByName('ITE_MARBR3').AsFloat,

                               arrPreVen[4],
                               FieldByName('ITE_PREVE4').AsFloat,

                               arrMarBru[4],
                               FieldByName('ITE_MARBR4').AsFloat,

                               arrPreVen[5],
                               FieldByName('ITE_PREVE5').AsFloat,

                               arrMarBru[5],
                               FieldByName('ITE_MARBR5').AsFloat,

                               arrPreVen[6],
                               FieldByName('ITE_PREVE6').AsFloat,

                               arrMarBru[6],
                               FieldByName('ITE_MARBR6').AsFloat,

                               arrPreVen[7],
                               FieldByName('ITE_PREVE7').AsFloat,

                               arrMarBru[7],
                               FieldByName('ITE_MARBR7').AsFloat,

                               FieldByName('ITE_PRECOM').AsFloat,
                               FieldByName('ITE_PRECOM').AsFloat,

                               'ENTRADA DE MERCADORIAS',

                               Nil,
                               '',
                               strLoginUsuarioLogado);

        End {If blnPermiteReducaoPreco Or (FieldByName('ITE_PREVE1').AsFloat >= arrPreVen[1]) Then}

        Else Cancel;

      End; {With cpcParams Do}

      Next;
    End; {While Not Eof Do}

  End;
  strAgrupadorPreAlt := '';
  FreeAndNil(qryIteger);
End;

Function TEntOutrasDespesas.fAtualizaPrecomIteger(strCodIte: String; fltPreCom: Double; blnPermiteReducaoPreco: Boolean): Boolean;
  Var
    qryIteger: TUniQuery;
    intOpcAtu,
    intContador: Integer;

    strEmpresas,
    srtCamAtu: String;

    arrPreVen: Array[1..7] Of Double;
    arrMarBru: Array[1..7] Of Double;
    fltPreCus: Double;

    Function fSQLIteger: String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT * FROM ITEGER ';
      strSQL := strSQL + ' WHERE ITE_CODITE = :CODITE ';
      strSQL := strSQL + '   AND LOCATE(ITE_CODEMP, :CODEMP) > 0 ';
      Result := strSQL;
    End;

Begin
  Result := True;

  strEmpresas := fRetEmpresasUsamPrecoMatriz;

  qryIteger := fCriaQuery(Self);

  With qryIteger, SQL Do
  Begin
    Close;

    SQL.Text := fSQLIteger;

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strEmpresas;

    Open;

    While Not Eof Do
    Begin

      For intContador := 1 To 7 Do
      Begin
        arrPreVen[intContador] := FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat;
        arrMarBru[intContador] := FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat;
      End;


      Edit;
      FieldByName('ITE_PRECOM').AsFloat := fltPreCom;

      With cpcParams Do
      Begin
        curPreCom := FieldByName('ITE_PRECOM').AsFloat;
        curDesF01 := FieldByName('ITE_DESF01').AsFloat;
        curDesF02 := FieldByName('ITE_DESF02').AsFloat;
        curDesF03 := FieldByName('ITE_DESF03').AsFloat;
        curDesF04 := FieldByName('ITE_DESF04').AsFloat;
        curDesF05 := FieldByName('ITE_DESF05').AsFloat;
        curDesF06 := FieldByName('ITE_DESF06').AsFloat;
        curICMSEnt:= FieldByName('ITE_ICMENT').AsFloat;
        curIPIEnt := FieldByName('ITE_IPIENT').AsFloat;
        curFrete  := FieldByName('ITE_FREENT').AsFloat;
        curValFre := FieldByName('ITE_VALFRE').AsFloat;
        curAcrFin := FieldByName('ITE_ACRFIN').AsFloat;
        curSubsti := FieldByName('ITE_SUBSTI').AsFloat;
        curDesAdb := FieldByName('ITE_DESADB').AsFloat;
        curSubFed := FieldByName('ITE_SUBFED').AsFloat;

        if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
        begin
          curTCIFCu := FieldByName('ITE_TCIFCU').AsFloat;
          curTSCust := FieldByName('ITE_TSCUST').AsFloat;
          curDePiCo := FieldByName('ITE_DEPICO').AsFloat;
          curDeICMS := FieldByName('ITE_DEICMS').AsFloat;
          curFatReg := FieldByName('ITE_FATREG').AsFloat;
        end
        else
        begin
          curTCIFCu := 0;
          curTSCust := 0;
          curDePiCo := 0;
          curDeICMS := 0;
          curFatReg := 0;
        end;

        fltPreCus := fCalculaPrecoCusto;
        FieldByName('ITE_PRECUS').AsFloat := fltPreCus;

        For intContador := 1 To Length(VS_strTabPrc) Do
        Begin
          intOpcAtu := IIF(blnATPVMB[intContador],  1,           2          );
          srtCamAtu := IIF(blnATPVMB[intContador], 'ITE_PREVE', 'ITE_MARBR' );

          FieldByName(srtCamAtu + IntToStr(intContador) ).AsFloat := fCalculaPrecoVenda(intOpcAtu,
                                                                                        FieldByName('ITE_PRECUS').AsFloat + FieldByName('ITE_OUTVAL').AsFloat,
                                                                                        FieldByName('ITE_PREVE' + IntToStr(intContador) ).AsFloat,
                                                                                        FieldByName('ITE_MARBR' + IntToStr(intContador) ).AsFloat,
                                                                                        FieldByName('ITE_ICMSAI').AsFloat,
                                                                                        FieldByName('ITE_IMPFED').AsFloat,
                                                                                        FieldByName('ITE_DESOPE').AsFloat,
                                                                                        FieldByName('ITE_COMTB' + IntToStr(intContador) ).AsFloat);
        End;

        If blnPermiteReducaoPreco Or (FieldByName('ITE_PREVE1').AsFloat >= arrPreVen[1]) Then
        Begin
          Post;

          Result := fGravaPreAlt(FieldByName('ITE_CODITE').AsString,

                               fltPrecus,
                               FieldByName('ITE_PRECUS').AsFloat,

                               arrPreVen[1],
                               FieldByName('ITE_PREVE1').AsFloat,

                               arrMarBru[1],
                               FieldByName('ITE_MARBR1').AsFloat,

                               arrPreVen[2],
                               FieldByName('ITE_PREVE2').AsFloat,

                               arrMarBru[2],
                               FieldByName('ITE_MARBR2').AsFloat,

                               arrPreVen[3],
                               FieldByName('ITE_PREVE3').AsFloat,

                               arrMarBru[3],
                               FieldByName('ITE_MARBR3').AsFloat,

                               arrPreVen[4],
                               FieldByName('ITE_PREVE4').AsFloat,

                               arrMarBru[4],
                               FieldByName('ITE_MARBR4').AsFloat,

                               arrPreVen[5],
                               FieldByName('ITE_PREVE5').AsFloat,

                               arrMarBru[5],
                               FieldByName('ITE_MARBR5').AsFloat,

                               arrPreVen[6],
                               FieldByName('ITE_PREVE6').AsFloat,

                               arrMarBru[6],
                               FieldByName('ITE_MARBR6').AsFloat,

                               arrPreVen[7],
                               FieldByName('ITE_PREVE7').AsFloat,

                               arrMarBru[7],
                               FieldByName('ITE_MARBR7').AsFloat,

                               FieldByName('ITE_PRECOM').AsFloat,
                               FieldByName('ITE_PRECOM').AsFloat,

                               'ENTRADA DE MERCADORIAS',

                               Nil,
                               '',
                               strLoginUsuarioLogado);

        End {If blnPermiteReducaoPreco Or (FieldByName('ITE_PREVE1').AsFloat >= arrPreVen[1]) Then}

        Else Cancel;

      End; {With cpcParams Do}

      Next;
    End; {While Not Eof Do}

  End;

  FreeAndNil(qryIteger);
End;

Procedure TEntOutrasDespesas.pCarregaAtpVmb;
  Var
    intCont: Integer;
Begin
  For intCont := 1 to 7 Do
    blnAtpVmb[intCont] := (fCfgSis( IIF( intCont = 1, 'ATPVMB', 'ATPVM' + IntToStr(intCont) )) = 'P');
End;

Function TEntOutrasDespesas.fCalculaPrecoCompraBruto(fltPreLiq: Double;
                                              ArrDesFor: Array Of Double): Double;
  Var
    intContador: Integer;
Begin
  Result := fltPreLiq;
  For intContador := High(ArrDesFor) Downto Low(ArrDesFor) Do
    Result := Result / (1 - ArrDesFor[intContador] / 100);

  Result := RoundTo(Result, -intDecimais);
End;




end.
