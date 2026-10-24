unit untFormulaCustoProduto;

interface

Uses
  Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Forms, Uni,
  untZClient, StrUtils, Math, Variants,
  fs_iinterpreter, untFuncoesPrecoCusto,
  Shared.Functions.Interfaces,
  Shared.Functions.Tipos;


Type
  TFormulaCustoProduto = Class(TZClient)
  Private
    FNumeroFormula: Integer;

    frmFormulaCustoProdutoEdicao: Pointer;

    FIncluiReg: Boolean;
    blnRedImpFed: Boolean;

    FblnGeraAutoIncrem: Boolean;

    // REFTRI (teste de 2026-10-15): CFG_REFCIS - cada tabela termina com CBS, IBS, IS e o Preco de Venda com Impostos.
    FRefCis,
    FDemo,
    FReadOnly: Boolean;

    fscScript: TfsScript;

    FFrmCus,
    FMarMKP,
    FPcmPro,
    FOpeAdi: String;

    FCamMar,
    FstrMargem: String;

    FComLiq,
    FIcmEnt,
    FSubFed,
    FIpiEnt,
    FFreEnt,
    FValFre,
    FAcrFin,
    FSubsti,
    FDesAdb,
    FTCIFCu,
    FTSCust,
    FDePiCo,
    FDeICMS,
    FFatReg,

    FOutVal,
    FIcmSai,
    FImpFed,
    FDesOpe: Double;
    FobjTabelasDoItem: TZClient;
    blnTabPrd: Boolean;

    Function fSQLCampos: String;

    Function fValidaRegistros4: Boolean;
    Function fValidaRegistros1: Boolean;
    Function fValidaRegistros2: Boolean;
    Function fValidaRegistros3: Boolean;

    Function fValidaCampo(intPosCam: Integer; strCodCam, strDesCam, strOperador, strBasCal, strNomAlq, strExpVal, strNomCam: String; AblnGeraAutoInc: Boolean = True): Boolean;
    Function fExecutaExpressao(strExpressao: String; blnCompila: Boolean; Var blnErro: Boolean): Double;

    Function fValidaExpressaoCampo(strCodCam, strFrmCus: String): Boolean;

    Function fMontaExpressaoCusto: String;

    Function fCompletaQuadro: Boolean;

    Procedure pAfterScroll(dataSet: TDataSet);
    Procedure pBeforePost(dataSet: TDataSet);

    Procedure pInicializaFastScript;

    Procedure pSetaValores;
    Procedure pSetaAliquotas;

    Procedure pMontaValores(dtsIteger: TDataSet; blnPreDol: Boolean; blnTabelaPrecos: Boolean = False);
    Procedure pMontaValorReforma(dtsIteger: TDataSet; blnTabelaPrecos: Boolean);
    function fConveteCampoCorreto(strCampo: String; blnTabelaPrecos: Boolean): string;

    Procedure pCompletaFormulas(dtsIteger: TDataSet; blnPreDol: Boolean; blnTabelaPrecos: Boolean = False);

    Procedure pCompletaFormulaUsuario(dtsIteger: TDataSet; blnPreDol: Boolean; blnTabelaPrecos: Boolean = False);

    Procedure pRefreshTela;
    procedure pSetTabelaDoItem(const Value: TZClient);
    procedure pDistribuiTabelas;
    procedure pARemovePrevenMarbruDuplicadas(tmp: TUniClientDataSet);
    procedure pAjustaTabelasPrevenMarbru(tmp: TUniClientDataSet);

  Public

    intDecUni: Integer;
    // REFTRI: aliquotas da reforma que a aba 1 do cadastro mostra (pDefinirImpostosReforma, antes de pMostraCalculoFormula).
    fltAlqCbsReforma,
    fltAlqIbsReforma,
    fltAlqIsReforma: Double;
    strMskUni: String;
    constructor Create(Owner: TComponent; intCustoFixo: Integer; blnRecarregar: Boolean = False; blnDemo: Boolean = False; AblnGeraAutoIncrem: Boolean = True); Reintroduce;

    Destructor Destroy; override;

    // REFTRI (teste de 2026-10-15): aliquotas da reforma que a aba 1 mostra, antes de pMostraCalculoFormula.
    Procedure pDefinirImpostosReforma(fltCbs, fltIbs, fltIs: Double);

    Procedure pPedeDadosFormula(docWin: TWinControl);

    Function fFormulaValida(strFrmCus: String): Boolean;

    Function fCalculaPrecoCusto(fltComLiq, fltIcmEnt, fltSubFed,
                                fltIpiEnt, fltFreEnt, fltValFre,
                                fltAcrFin, fltSubsti, fltDesAdb,
                                fltTCIFCu, fltTSCust,
                                fltDePiCo, fltDeICMS, fltFatReg: Double): Double;

    Procedure pMostraCalculoFormula(dtsIteger: TDataSet; blnPreDol: Boolean);
    Procedure pRemoveTodosRegistrosAdicionados;

    Function fValidaExpressaoCustoLoopInfinito(var strCodCam: String): Boolean;

    Procedure pLiberaTela;

    Property intNumeroFormula: Integer Read FNumeroFormula;
    property objTabelasDoItem: TZClient read FobjTabelasDoItem write pSetTabelaDoItem;
    const
      ArrCamposPrecoVenda: Array [0..6] Of string = ('PREVE1', 'PREVE2', 'PREVE3', 'PREVE4', 'PREVE5', 'PREVE6', 'PREVE7');
      ArrCamposMargemBruta: Array [0..6] Of string = ('MARBR1', 'MARBR2', 'MARBR3', 'MARBR4', 'MARBR5', 'MARBR6', 'MARBR7');
      ArrCamposSubTotal: Array [0..6] Of string = ('SUBTO1', 'SUBTO2', 'SUBTO3', 'SUBTO4', 'SUBTO5', 'SUBTO6', 'SUBTO7');
      // REFTRI: linhas da reforma, uma por tabela de preco.
      ArrCamposReforma: Array [0..27] Of string = ('VLCBS1', 'VLCBS2', 'VLCBS3', 'VLCBS4', 'VLCBS5', 'VLCBS6', 'VLCBS7',
                                                   'VLIBS1', 'VLIBS2', 'VLIBS3', 'VLIBS4', 'VLIBS5', 'VLIBS6', 'VLIBS7',
                                                   'VLISE1', 'VLISE2', 'VLISE3', 'VLISE4', 'VLISE5', 'VLISE6', 'VLISE7',
                                                   'PREIM1', 'PREIM2', 'PREIM3', 'PREIM4', 'PREIM5', 'PREIM6', 'PREIM7');

  End;


implementation


Uses
  untTypesSistema,
  untFuncoesSimples,
  untFormulaCustoProdutoEdicao,
  untParCalculaPrecoCusto,
  cxCurrencyEdit,
  untCfgFormulasPrecoCusto,
  Shared.Functions.Types;

constructor TFormulaCustoProduto.Create(Owner: TComponent; intCustoFixo: Integer; blnRecarregar: Boolean = False; blnDemo: Boolean = False; AblnGeraAutoIncrem: Boolean = True);
Begin
  Try
    Inherited Create(Owner, fSQLCampos);
    FRefCis := fCfgSis('REFCIS', varBoolean);
    blnRedImpFed := (fCfgSis('PDISIF') = 'S') And (fCfgSis('ICMDEB') = 'S');
    FIncluiReg := False;

    FDemo := blnDemo;

    FblnGeraAutoIncrem := AblnGeraAutoIncrem;

    FFrmCus := fCfgSis('FRMCUS');
    FMarMKP := fCfgSis('MARMKP');
    blnTabPrd := fCfgSis('TABPRD') = 'S';

    FstrMargem := untFuncoesPrecoCusto.RetornarTipoDoCusto;
    FCamMar    := untFuncoesPrecoCusto.RetornarCampoDoCusto;

    FPcmPro := fCfgSis('PCMPRO');

    FNumeroFormula := intCustoFixo;

    frmFormulaCustoProdutoEdicao := Nil;

    FReadOnly := False;

    FOpeAdi := fCfgSis('OPEADI');

    pInicializaFastScript;

    If blnRecarregar Or fEmptyStr(VS_strFormulaCusto4) Then
    Begin

      If fAbreClient(True) Then
      Begin
        IndexFieldNames := 'FOR_CODCAM';

        Case FNumeroFormula Of
          1:   fValidaRegistros1;
          2:   fValidaRegistros2;
          3:   fValidaRegistros3;
          Else fValidaRegistros4;
        End;

        pAlinhaCampoCentro('FOR_CODCAM');
        pAlinhaCampoCentro('OPERAD');

        AfterScroll := pAfterScroll;
        BeforePost  := pBeforePost;
      End

      Else pMensagemOk(strMsgErr);

      FComLiq := 0;
      FIcmEnt := 0;
      FSubFed := 0;
      FIpiEnt := 0;
      FFreEnt := 0;
      FValFre := 0;
      FAcrFin := 0;
      FSubsti := 0;
      FDesAdb := 0;
      FTCIFCu := 0;
      FTSCust := 0;
      FDePiCo := 0;
      FDeICMS := 0;
      FFatReg := 0;

      FOutVal := 0;
      FIcmSai := 0;
      FImpFed := 0;
      FDesOpe := 0;

      VS_strFormulaCusto4 := fMontaExpressaoCusto;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFormulaCustoProduto.Create]');
    End;
  End;
End;

Destructor TFormulaCustoProduto.Destroy;
Begin
  FreeAndNil(fscScript);

  Inherited;
End;

Procedure TFormulaCustoProduto.pInicializaFastScript;
Begin
  Try
    untFuncoesPrecoCusto.InicializaFastScript(TObject(fscScript));
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFormulaCustoProduto.pInicializaFastScript]');
    End;
  End;
End;

Procedure TFormulaCustoProduto.pSetaValores;
Var
  LParametros : IParametrosFormulaPrecoCustoSetarValores;
Begin
  LParametros :=
    TParametrosFormulaPrecoCustoSetarValores.New
      .PrecoDeCompraLiquido(FComLiq)
      .IcmEntrada(FIcmEnt)
      .ImpostosFederaisEntrada(FSubFed)
      .IpiEntrada(FIpiEnt)
      .FreteEntrada(FFreEnt)
      .ValorFrete(FValFre)
      .AcrescimoFinal(FAcrFin)
      .Substituicao(FSubsti)
      .DescontoAdicionalBoleto(FDesAdb)
      .OutrosValores(FOutVal)
      .IcmSaida(FIcmSai)
      .ImpostosFederaisSaida(FImpFed)
      .DespesaOperacional(FDesOpe)
      .TaxaDeControleDeIncentivosFiscaisSuframa(FTCIFCu)
      .TaxaDeServicoSuframa(FTSCust)
      .DescontoPisCofins(FDePiCo)
      .DescontoICMS(FDeICMS)
      .FatorRegional(FFatReg);


  untFuncoesPrecoCusto.SetarValoresFscScript(TObject(fscScript), LParametros);

End;

procedure TFormulaCustoProduto.pSetTabelaDoItem(const Value: TZClient);
begin
  FobjTabelasDoItem := Value;
end;

Procedure TFormulaCustoProduto.pSetaAliquotas;
Begin
  pSetaValores;
End;

Procedure TFormulaCustoProduto.pRefreshTela;
Begin
  If Assigned(frmFormulaCustoProdutoEdicao) Then
  Begin
    TfrmFormulaCustoProdutoEdicao(frmFormulaCustoProdutoEdicao).cxgItens.Update;
    TfrmFormulaCustoProdutoEdicao(frmFormulaCustoProdutoEdicao).cxgItens.Repaint;
    TfrmFormulaCustoProdutoEdicao(frmFormulaCustoProdutoEdicao).cxgItens.Refresh;
    TfrmFormulaCustoProdutoEdicao(frmFormulaCustoProdutoEdicao).cxvItensBASCAL.Width :=
      TfrmFormulaCustoProdutoEdicao(frmFormulaCustoProdutoEdicao).cxvItensBASCAL.Width + 1;

    TfrmFormulaCustoProdutoEdicao(frmFormulaCustoProdutoEdicao).cxvItensBASCAL.Width :=
      TfrmFormulaCustoProdutoEdicao(frmFormulaCustoProdutoEdicao).cxvItensBASCAL.Width - 1;

    TfrmFormulaCustoProdutoEdicao(frmFormulaCustoProdutoEdicao).Repaint;
    TfrmFormulaCustoProdutoEdicao(frmFormulaCustoProdutoEdicao).Refresh;
    TfrmFormulaCustoProdutoEdicao(frmFormulaCustoProdutoEdicao).Update;

    If Assigned(frmFormulaCalcPCusto) Then
    Begin
      frmFormulaCalcPCusto.Repaint;
      frmFormulaCalcPCusto.Refresh;
      frmFormulaCalcPCusto.Update;
    End;

  End;
  Application.ProcessMessages;
End;

procedure TFormulaCustoProduto.pRemoveTodosRegistrosAdicionados;
var i: integer;


begin
  Self.Filtered := False;
  Self.Filter := 'TABELA <> ' + QuotedStr(IntToStr(fRetPrimeiraTabPrecoAtiva));
  for i:= 0 To 6 do
  Begin
    Self.Filter := Self.Filter + ' AND FOR_CODCAM <> ' + QuotedStr(ArrCamposPrecoVenda[i]);
    Self.Filter := Self.Filter + ' AND FOR_CODCAM <> ' + QuotedStr(ArrCamposMargemBruta[i]);
    Self.Filter := Self.Filter + ' AND FOR_CODCAM <> ' + QuotedStr(ArrCamposSubTotal[i]);
  End;
  for i := Low(ArrCamposReforma) To High(ArrCamposReforma) do
    Self.Filter := Self.Filter + ' AND FOR_CODCAM <> ' + QuotedStr(ArrCamposReforma[i]);

  Self.Filtered := True;
  While not Self.Eof do
    Self.Delete;

  Self.Filtered := False;
  Self.Filter := '';
end;

Function TFormulaCustoProduto.fExecutaExpressao(strExpressao: String; blnCompila: Boolean; Var blnErro: Boolean): Double;
  Var
    strErrorPos,
    strExpres,
    strMsgErr: String;
Begin
  Result := 0;
  blnErro := False;

  strExpres := Trim(strExpressao);

  With fscScript Do
  Try

    If blnCompila Then
    Begin
      pSetaValores;

      Lines.Clear;
      Lines.Add('Function Expressao: Variant;');
      Lines.Add('Begin');
      Lines.Add('  Result := ');
      Lines.Add(strExpres);
      Lines.Add('End;');
      Lines.Add('Begin');
      Lines.Add('End.');

      blnErro := Not Compile;

    End Else
    Begin
      Result := untFuncoesPrecoCusto.ExecutarExpressao(TObject(fscScript), strExpressao);
    End;

    If Not blnErro And
      (  CharInSet( RightStr(strExpres, 1)[1], [';', '+', '-'] )) Then
    Begin
      ErrorMsg := ' "' + RightStr(strExpres, 1) +'" inesperado';
      blnErro := True;
    End;

    If blnErro Then
    Begin
      strMsgErr := ErrorMsg;

      If SameText(strMsgErr, 'Incompatible types') Then
        strMsgErr := 'Tipos incompatíveis'

      Else If Pos('Undeclared identifier', strMsgErr) > 0 Then
      Begin
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Undeclared identifier:', 'Campo desconhecido: ');
      End

      Else If SameText(strMsgErr, ''';'' expected') Then
        strMsgErr := 'Expressão inválida'

      Else
      Begin
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Expression expected', 'Expressão esperada');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'expected', 'esperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Expected', 'Esperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'unexpected', 'inesperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Unexpected', 'Inesperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Identifier', 'Identificador');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'identifier', 'identificador');
      End;

      strErrorPos := ErrorPos;
      If Pos(':', strErrorPos) > 0 Then
        strErrorPos := RightStr(strErrorPos, Length(strErrorPos) - Pos(':', strErrorPos));

      pMensagemOk(strExpressao + #13#10 + strMsgErr + '!' + '  Posição: [' + strErrorPos + ']');

      pRefreshTela;
    End;


  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(strExpressao + ' - ' + E.Message, '[TFormulaCustoProduto.fExecutaExpressao]');
    End;
  End;
End;

Procedure TFormulaCustoProduto.pBeforePost(dataSet: TDataSet);
  Var blnErro: Boolean;

  Procedure pAborta;
  Begin
    pRefreshTela;

    If Assigned(frmFormulaCalcPCusto) And frmFormulaCalcPCusto.btnConfirma.Focused Then
      Cancel
    Else
      Abort;
  End;

Begin
  With DataSet Do
  Begin

    If fEmptyStr(FieldByName('FOR_BASCAL').AsString) Then
      Exit;

    If fEmptyStr(FieldByName('FOR_BASCAL').AsString) Then
    Begin
      pMensagemOk('Base de cálculo para o valor ' + FieldByName('FOR_CODCAM').AsString + ' não informada!');
      pAborta;
    End;

    If Pos(FieldByName('FOR_CODCAM').AsString, FieldByName('FOR_BASCAL').AsString) > 0 Then
    Begin
      pMensagemOk('O Valor do Campo não pode estar em sua própria base de cálculo!');
      pAborta;

      Exit;
    End;

    fExecutaExpressao(FieldByName('FOR_BASCAL').AsString, True, blnErro);

  End;

  If blnErro Then
    pAborta;
End;

Function TFormulaCustoProduto.fSQLCampos: String;
Begin
  Result := untFuncoesPrecoCusto.RetornarSQLFormulaPrecoCusto(VS_strCodEmp, FNumeroFormula);
End;

Function TFormulaCustoProduto.fCompletaQuadro: Boolean;
  Var
    intContador,
    intPosicao: Integer;
    strFormula2,
    strFormula: String;
Begin
  Result := True;

  If FMarMKP = '4' Then
    Exit;

  strFormula  := '';
  strFormula2 := '';



  Result := fValidaCampo(18, 'OUTVAL', fCfgSis('DOVCPP'),        '+', '',          '', '',          'ITE_OUTVAL', FblnGeraAutoIncrem) And
            fValidaCampo(19, 'ICMSAI', 'ICMS Saída',             '+', '',          '', '',          'ITE_ICMSAI', FblnGeraAutoIncrem);


  If blnRedImpFed Then
  Begin
    strFormula  := '(IMPFED * (1 - (ICMSAI/100)))';
    strFormula2 := '(%IMPFED * (1 - (%ICMSAI/100)))';
  End;
   
  Result := Result And
            fValidaCampo(20, 'IMPFED', 'Impostos Federais',      '+', strFormula2, '', strFormula,  'ITE_IMPFED', FblnGeraAutoIncrem);



  strFormula  := '(PRECUS + OUTVAL) / (1 - (IcmSai + ImpFed + DesOpe) / 100)';
  strFormula2 := '(PRECUS + OUTVAL) / (1 - (%ICMSAI + %IMPFED + %DESOPE) / 100)';

  Result := Result And
            fValidaCampo(21, 'DESOPE', 'Despesas Operacionais',  '+', '',          '', '',          'ITE_DESOPE', FblnGeraAutoIncrem) And
            fValidaCampo(22, 'CUSREA', 'Preço de Custo Real',    '',  strFormula2, '', strFormula,  '', FblnGeraAutoIncrem);

  intPosicao := 23;

  For intContador := 1 To 7 Do
  If VS_strTabPrc[intContador] = 'S' Then
  Begin
    Result := Result And
      fValidaCampo(intPosicao, FCamMar + IntToStr(intContador), FstrMargem + ' ' + IntToStr(intContador),     '+', '', '', '',  'ITE_MARBR' + IntToStr(intContador), FblnGeraAutoIncrem);

    If (FMarMkp = '1') Or (FMarMkp = '2') Then
    Begin

      If (FMarMkp = '2') Then
      Begin
        strFormula  := '((MARKP' + IntToStr(intContador) +  '/ 100) / (MARKP' + IntToStr(intContador) +  ' / 100 + 1)) * 100';
        strFormula2 := '((%MARKP' + IntToStr(intContador) +  '/ 100) / (%MARKP' + IntToStr(intContador) +  ' / 100 + 1)) * 100';

        Result := Result And
          fValidaCampo(intPosicao + 1, 'MARBR' + IntToStr(intContador), 'Margem ' + IntToStr(intContador), '', strFormula2, '', strFormula, '', FblnGeraAutoIncrem);
      End;

    End Else
    Begin

    End;

    If FPcmPro = '2' Then
      Result := Result And
        fValidaCampo(intPosicao + 2, 'COMTB' + IntToStr(intContador), 'Comissão ' + IntToStr(intContador),    '-', '', '', '',  'ITE_COMTB' + IntToStr(intContador), FblnGeraAutoIncrem)
    Else If FPcmPro = '3' Then
      Result := Result And
        fValidaCampo(intPosicao + 2, 'COMTB' + IntToStr(intContador), fCfgSis('TCOMTB') +  ' '  + IntToStr(intContador),    '-', '', '', '',  'ITE_COMTB' + IntToStr(intContador), FblnGeraAutoIncrem);


    If (FMarMkp = '1') Or (FMarMkp = '2') Then
    Begin
      If Not blnTabPrd then
      Begin
        strFormula  := '(PRECUS + OUTVAL) + (PREVE' + IntToStr(intContador) + '*(ICMSAI + IMPFED + DESOPE' + IIF(FPcmPro <> '1', ' + COMTB' + IntToStr(intContador), '') + '))/ 100';
        strFormula2 := '(PRECUS + OUTVAL) + (PREVE' + IntToStr(intContador) + '*(%ICMSAI + %IMPFED + %DESOPE' + IIF(FPcmPro <> '1', ' + %COMTB' + IntToStr(intContador), '') + '))/ 100';

        Result := Result And
        fValidaCampo(intPosicao + 3, 'CUSVE' + IntToStr(intContador), 'Preço de Custo da Venda ' + IntToStr(intContador), '', strFormula2, '', strFormula, '', FblnGeraAutoIncrem);
      End;

      strFormula  := 'MARBR' + IntToStr(intContador) + ' + IcmSai + ImpFed + DesOpe' + IIF(FPcmPro <> '1', ' + COMTB' + IntToStr(intContador), '');
      strFormula2 := '%MARBR' + IntToStr(intContador) + ' + %ICMSAI + %IMPFED + %DESOPE' + IIF(FPcmPro <> '1', ' + %COMTB' + IntToStr(intContador), '');

      Result := Result And
        fValidaCampo(intPosicao + 4, 'SUBTO' + IntToStr(intContador), 'Subtotal ' + IntToStr(intContador), '', strFormula2, '', strFormula, '', FblnGeraAutoIncrem);

      strFormula  := '(PRECUS + OUTVAL) / (1 - SUBTO' + IntToStr(intContador) + ' / 100)';

      Result := Result And
        fValidaCampo(intPosicao + 5, 'PREVE' + IntToStr(intContador), 'Preço de Venda ' + IntToStr(intContador), '', strFormula, '', strFormula, 'ITE_PREVE' + IntToStr(intContador), FblnGeraAutoIncrem);
    End Else
    Begin
      strFormula  := '(PRECUS + OUTVAL) / (1 - (ICMSAI + IMPFED + DESOPE' + IIF(FPcmPro <> '1', ' + COMTB' + IntToStr(intContador), '') + ') / 100)';
      strFormula2 := '(PRECUS + OUTVAL) / (1 - (%IMCSAI + %IMPFED + %DESOPE' + IIF(FPcmPro <> '1', ' + %COMTB' + IntToStr(intContador), '') + ') / 100)';

      Result := Result And
        fValidaCampo(intPosicao + 4, 'SUBTO' + IntToStr(intContador), 'Subtotal ' + IntToStr(intContador), '', strFormula2, '', strFormula, '', FblnGeraAutoIncrem);

      If (FMarMkp = '5') Then
      Begin
        strFormula  := 'SUBTO' + IntToStr(intContador) + ' / ((100 - MARBR' + IntToStr(intContador) + ') / 100)';
        strFormula2 := 'SUBTO' + IntToStr(intContador) + ' / ((100 - %MARBR' + IntToStr(intContador) + ') / 100)';
      End Else
      Begin
        strFormula  := 'SUBTO' + IntToStr(intContador) + ' * (1 + MARKP' + IntToStr(intContador) + ' / 100)';
        strFormula2 := 'SUBTO' + IntToStr(intContador) + ' * (1 + %MARKP' + IntToStr(intContador) + ' / 100)';
      End;

      Result := Result And
        fValidaCampo(intPosicao + 4, 'PREVE' + IntToStr(intContador), 'Preço de Venda ' + IntToStr(intContador), '', strFormula2, '', strFormula, 'ITE_PREVE' + IntToStr(intContador), FblnGeraAutoIncrem);
    End;

    // REFTRI (teste de 2026-10-15): depois da conversao a tabela termina com os impostos da reforma e o preco com eles,
    // como a aba 1. So exibicao: sem formula e sem campo (pMontaValorReforma preenche).
    If FRefCis Then
      Result := Result And
        fValidaCampo(intPosicao + 6, 'VLCBS' + IntToStr(intContador), 'CBS ' + IntToStr(intContador),              '+', '', '', '', '', FblnGeraAutoIncrem) And
        fValidaCampo(intPosicao + 7, 'VLIBS' + IntToStr(intContador), 'IBS ' + IntToStr(intContador),              '+', '', '', '', '', FblnGeraAutoIncrem) And
        fValidaCampo(intPosicao + 8, 'VLISE' + IntToStr(intContador), 'Imposto Seletivo ' + IntToStr(intContador), '+', '', '', '', '', FblnGeraAutoIncrem) And
        fValidaCampo(intPosicao + 9, 'PREIM' + IntToStr(intContador), 'Preço de Venda c/ Impostos ' + IntToStr(intContador), '', '', '', '', '', FblnGeraAutoIncrem);

    // Sem CFG_REFCIS a tabela continua com 6 posicoes, como antes da reforma (DelphAI, 2026-10-15).
    If FRefCis Then
      Inc(intPosicao, 10)
    Else
      Inc(intPosicao, 6);
  End;

End;

function TFormulaCustoProduto.fConveteCampoCorreto(strCampo: String;
  blnTabelaPrecos: Boolean): string;
const
  strCamposPrecoVenda = '_ITE_PREVE1_ITE_PREVE2_ITE_PREVE3_ITE_PREVE4_ITE_PREVE5_ITE_PREVE6_ITE_PREVE7';
  strCamposMargemBruta = '_ITE_MARBR1_ITE_MARBR2_ITE_MARBR3_ITE_MARBR4_ITE_MARBR5_ITE_MARBR6_ITE_MARBR7';
  strCamposCommissao= '_ITE_COMTB1_ITE_COMTB2_ITE_COMTB3_ITE_COMTB4_ITE_COMTB5_ITE_COMTB6_ITE_COMTB7';
begin
  Result := strCampo;
  If blnTabelaPrecos then
  Begin
    If Pos(strCampo, strCamposPrecoVenda) > 0 then
      Result := 'ITE_PREVEN'
    Else If Pos(strCampo, strCamposMargemBruta) > 0 then
      Result := 'ITE_MARBRU'
    Else If Pos(strCampo, strCamposCommissao) > 0 then
      Result := 'ITE_COMTBL';
  End;
end;

Function TFormulaCustoProduto.fValidaRegistros4: Boolean;
Begin
  Result := untFuncoesPrecoCusto.ValidarMatrizDeRegistrosMarkup(TObject(Self));

  If FDemo Then
   Result := Result And fCompletaQuadro;

End;

Function TFormulaCustoProduto.fValidaRegistros1: Boolean;
Begin
  Result := fValidaCampo(01, 'PRECOM', 'Preço de Compra',         '',      '',                                                    '',       '', 'ITE_PRECOM')  And
            fValidaCampo(02, 'DESF01', 'Desconto Fornecedor 1',   '-',     'PRECOM',                                              'DesF01', '', 'ITE_DESF01') And
            fValidaCampo(03, 'DESF02', 'Desconto Fornecedor 2',   '-',     'PRECOM - DESF01',                                     'DesF02', '', 'ITE_DESF02') And
            fValidaCampo(04, 'DESF03', 'Desconto Fornecedor 3',   '-',     'PRECOM - DESF01 - DESF02',                            'DesF03', '', 'ITE_DESF03') And
            fValidaCampo(05, 'DESF04', 'Desconto Fornecedor 4',   '-',     'PRECOM - DESF01 - DESF02 - DESF03',                   'DesF04', '', 'ITE_DESF04') And
            fValidaCampo(06, 'DESF05', 'Desconto Fornecedor 5',   '-',     'PRECOM - DESF01 - DESF02 - DESF03 - DESF04',          'DesF05', '', 'ITE_DESF05') And
            fValidaCampo(07, 'DESF06', 'Desconto Fornecedor 6',   '-',     'PRECOM - DESF01 - DESF02 - DESF03 - DESF04 - DESF05', 'DesF06', '', 'ITE_DESF06') And

            fValidaCampo(08, 'COMLIQ', 'Preço de Compra Líquido', '',      '', '',      'PRECOM - DESF01 - DESF02 - DESF03 - DESF04 - DESF05 - DESF06', '') And

            fValidaCampo(09, 'ICMENT', 'ICMS Entrada',            '-',     'COMLIQ + IPIENT + SUBSTI', 'IcmEnt', '',       'ITE_ICMENT') And
            fValidaCampo(10, 'SUBFED', 'Impostos Federais',       '-',     'COMLIQ + IPIENT + SUBSTI', 'SubFed', '',       'ITE_SUBFED') And
            fValidaCampo(11, 'IPIENT', 'IPI Entrada ',            '+',     'COMLIQ',                   'IpiEnt', '',       'ITE_IPIENT') And
            fValidaCampo(12, 'FREENT', 'Frete',                   '+',     'COMLIQ + IPIENT + SUBSTI', 'FreEnt', '',       'ITE_FREENT') And
            fValidaCampo(13, 'VALFRE', fCfgSis('DESVFR'),         '+',     '',                         '',       'VALFRE', 'ITE_VALFRE') And
            fValidaCampo(14, 'ACRFIN', 'Acréscimo Financeiro',    '+',     'COMLIQ + IPIENT + SUBSTI', 'AcrFin', '',       'ITE_ACRFIN') And
            fValidaCampo(15, 'SUBSTI', 'Substituição Tributária', '+',     'COMLIQ + IPIENT',          'Substi', '',       'ITE_SUBSTI') And
            fValidaCampo(16, 'DESADB', fCfgSis('DESADI'),         FOpeAdi, 'COMLIQ - ICMENT - SUBFED + IPIENT + FREENT + VALFRE + ACRFIN + SUBSTI', 'DesAdb', '',       'ITE_DESADB') And

            fValidaCampo(17, 'PRECUS', 'Preço de Custo',          '',      '', '',       'COMLIQ - ICMENT - SUBFED + IPIENT + FREENT + VALFRE + ACRFIN + SUBSTI ' + FOpeAdi + ' DESADB', 'ITE_PRECUS');

  If FDemo Then
   Result := Result And fCompletaQuadro;
End;

Function TFormulaCustoProduto.fValidaRegistros2: Boolean;
Begin
  Result := fValidaCampo(01, 'PRECOM', 'Preço de Compra',         '',     '',                                                    '',       '', 'ITE_PRECOM')  And
            fValidaCampo(02, 'DESF01', 'Desconto Fornecedor 1',   '-',    'PRECOM',                                              'DesF01', '', 'ITE_DESF01') And
            fValidaCampo(03, 'DESF02', 'Desconto Fornecedor 2',   '-',    'PRECOM - DESF01',                                     'DesF02', '', 'ITE_DESF02') And
            fValidaCampo(04, 'DESF03', 'Desconto Fornecedor 3',   '-',    'PRECOM - DESF01 - DESF02',                            'DesF03', '', 'ITE_DESF03') And
            fValidaCampo(05, 'DESF04', 'Desconto Fornecedor 4',   '-',    'PRECOM - DESF01 - DESF02 - DESF03',                   'DesF04', '', 'ITE_DESF04') And
            fValidaCampo(06, 'DESF05', 'Desconto Fornecedor 5',   '-',    'PRECOM - DESF01 - DESF02 - DESF03 - DESF04',          'DesF05', '', 'ITE_DESF05') And
            fValidaCampo(07, 'DESF06', 'Desconto Fornecedor 6',   '-',    'PRECOM - DESF01 - DESF02 - DESF03 - DESF04 - DESF05', 'DesF06', '', 'ITE_DESF06') And

            fValidaCampo(08, 'COMLIQ', 'Preço de Compra Líquido', '',      '', '',      'PRECOM - DESF01 - DESF02 - DESF03 - DESF04 - DESF05 - DESF06', '') And

            fValidaCampo(09, 'ICMENT', 'ICMS Entrada',            '-',     'COMLIQ',                                                                          'IcmEnt', '',       'ITE_ICMENT') And
            fValidaCampo(10, 'SUBFED', 'Impostos Federais',       '-',     'COMLIQ',                                                                          'SubFed', '',       'ITE_SUBFED') And
            fValidaCampo(11, 'IPIENT', 'IPI Entrada ',            '+',     'COMLIQ',                                                                          'IpiEnt', '',       'ITE_IPIENT') And
            fValidaCampo(12, 'FREENT', 'Frete',                   '+',     'COMLIQ + IPIENT + SUBSTI',                                                        'FreEnt', '',       'ITE_FREENT') And
            fValidaCampo(13, 'VALFRE', fCfgSis('DESVFR'),         '+',     '',                                                                                '',       'VALFRE', 'ITE_VALFRE') And
            fValidaCampo(14, 'ACRFIN', 'Acréscimo Financeiro',    '+',     'COMLIQ + IPIENT + SUBSTI',                                                        'AcrFin', '',       'ITE_ACRFIN') And
            fValidaCampo(15, 'SUBSTI', 'Substituição Tributária', '+',     'COMLIQ',                                                                          'Substi', '',       'ITE_SUBSTI') And
            fValidaCampo(16, 'DESADB', fCfgSis('DESADI'),         FOpeAdi, 'COMLIQ - ICMENT - SUBFED + IPIENT + FREENT + VALFRE + ACRFIN + SUBSTI', 'DesAdb', '',       'ITE_DESADB') And

            fValidaCampo(17, 'PRECUS', 'Preço de Custo',          '',      '', '',  'COMLIQ - ICMENT - SUBFED + IPIENT + FREENT + VALFRE + ACRFIN + SUBSTI ' + FOpeAdi + ' DESADB', 'ITE_PRECUS');

  If FDemo Then
   Result := Result And fCompletaQuadro;
End;

Function TFormulaCustoProduto.fValidaRegistros3: Boolean;
Begin
  Result := fValidaCampo(01, 'PRECOM', 'Preço de Compra',         '',  '',                                                    '',       '', 'ITE_PRECOM')  And
            fValidaCampo(02, 'DESF01', 'Desconto Fornecedor 1',   '-', 'PRECOM',                                              'DesF01', '', 'ITE_DESF01') And
            fValidaCampo(03, 'DESF02', 'Desconto Fornecedor 2',   '-', 'PRECOM - DESF01',                                     'DesF02', '', 'ITE_DESF02') And
            fValidaCampo(04, 'DESF03', 'Desconto Fornecedor 3',   '-', 'PRECOM - DESF01 - DESF02',                            'DesF03', '', 'ITE_DESF03') And
            fValidaCampo(05, 'DESF04', 'Desconto Fornecedor 4',   '-', 'PRECOM - DESF01 - DESF02 - DESF03',                   'DesF04', '', 'ITE_DESF04') And
            fValidaCampo(06, 'DESF05', 'Desconto Fornecedor 5',   '-', 'PRECOM - DESF01 - DESF02 - DESF03 - DESF04',          'DesF05', '', 'ITE_DESF05') And
            fValidaCampo(07, 'DESF06', 'Desconto Fornecedor 6',   '-', 'PRECOM - DESF01 - DESF02 - DESF03 - DESF04 - DESF05', 'DesF06', '', 'ITE_DESF06') And

            fValidaCampo(08, 'COMLIQ', 'Preço de Compra Líquido', '',      '', '',      'PRECOM - DESF01 - DESF02 - DESF03 - DESF04 - DESF05 - DESF06', '') And

            fValidaCampo(09, 'ICMENT', 'ICMS Entrada',            '-',     'COMLIQ',                                                                'IcmEnt', '',       'ITE_ICMENT') And
            fValidaCampo(10, 'SUBFED', 'Impostos Federais',       '-',     'COMLIQ',                                                                'SubFed', '',       'ITE_SUBFED') And
            fValidaCampo(11, 'IPIENT', 'IPI Entrada ',            '+',     'COMLIQ',                                                                'IpiEnt', '',       'ITE_IPIENT') And
            fValidaCampo(12, 'FREENT', 'Frete',                   '+',     'COMLIQ',                                                                'FreEnt', '',       'ITE_FREENT') And
            fValidaCampo(13, 'VALFRE', fCfgSis('DESVFR'),         '+',     '',                                                                      '',       'VALFRE', 'ITE_VALFRE') And
            fValidaCampo(14, 'ACRFIN', 'Acréscimo Financeiro',    '+',     'COMLIQ',                                                                'AcrFin', '',       'ITE_ACRFIN') And
            fValidaCampo(15, 'SUBSTI', 'Substituição Tributária', '+',     'COMLIQ + IPIENT + FREENT',                                              'Substi', '',       'ITE_SUBSTI') And
            fValidaCampo(16, 'DESADB', fCfgSis('DESADI'),         FOpeAdi, 'COMLIQ - ICMENT - SUBFED + IPIENT + FREENT + VALFRE + ACRFIN + SUBSTI', 'DesAdb', '',       'ITE_DESADB') And

            fValidaCampo(17, 'PRECUS', 'Preço de Custo',          '',      '', '',       'COMLIQ - ICMENT - SUBFED + IPIENT + FREENT + VALFRE + ACRFIN + SUBSTI ' + FOpeAdi + ' DESADB', 'ITE_PRECUS');

  If FDemo Then
   Result := Result And fCompletaQuadro;
End;

Function TFormulaCustoProduto.fValidaCampo(intPosCam: Integer; strCodCam, strDesCam, strOperador, strBasCal, strNomAlq, strExpVal, strNomCam: String; AblnGeraAutoInc: Boolean = True): Boolean;
Var
  LParametrosValidaCampoPrecoCusto : IParametrosValidaCampoPrecoCusto;
Begin
  LParametrosValidaCampoPrecoCusto :=
    TParametrosValidaCampoPrecoCusto.New
      .PosicaoCampo(intPosCam)
      .CodigoCampo(strCodCam)
      .DescricaoCampo(strDesCam)
      .Operador(strOperador)
      .FormulaBaseCalculo(strBasCal)
      .NomeDaAliquota(strNomAlq)
      .ValorDaExpressao(strExpVal)
      .NomeDoCampo(strNomCam);

  Result :=
    untFuncoesPrecoCusto.
      ValidaCampoPrecoCusto(TObject(Self),  FIncluiReg, LParametrosValidaCampoPrecoCusto, (Not FDemo) And AblnGeraAutoInc);
End;

// REFTRI (teste de 2026-10-15): linha da reforma no registro corrente. Aliquotas = as da aba 1 (fltAlq*Reforma); preco
// com impostos pela mesma conta da aba 1 (TCalculadoraPrecoCliente.fCalculaPrecoComImpostos, RN04). Conteudo = aliquota;
// Valor Calculado = valor do imposto, a parte de (preco com impostos - preco de venda) que cabe a cada aliquota.
Procedure TFormulaCustoProduto.pMontaValorReforma(dtsIteger: TDataSet; blnTabelaPrecos: Boolean);
  Var
    strCodigo: String;
    fltPreVen,
    fltPreImp,
    fltAliquota,
    fltSoma: Double;
Begin
  FieldByName('VALCAD').AsFloat := 0;
  FieldByName('VALCAL').AsFloat := 0;

  If (dtsIteger.FindField(fConveteCampoCorreto('ITE_PREVE' + RightStr(FieldByName('FOR_CODCAM').AsString, 1), blnTabelaPrecos)) = Nil) Or (dtsIteger.FindField('ITE_ICMSAI') = Nil) Then
    Exit;

  strCodigo := LeftStr(FieldByName('FOR_CODCAM').AsString, 5);
  fltSoma   := fltAlqCbsReforma + fltAlqIbsReforma + fltAlqIsReforma;
  fltPreVen := dtsIteger.FieldByName(fConveteCampoCorreto('ITE_PREVE' + RightStr(FieldByName('FOR_CODCAM').AsString, 1), blnTabelaPrecos)).AsFloat;
  fltPreImp := RoundTo(fltPreVen + fltPreVen * (1 - dtsIteger.FieldByName('ITE_ICMSAI').AsFloat / 100) * (fltSoma / 100), -4);

  If strCodigo = 'PREIM' Then
  Begin
    FieldByName('VALCAL').AsFloat := fltPreImp;
    Exit;
  End;

  If strCodigo = 'VLCBS' Then
    fltAliquota := fltAlqCbsReforma
  Else If strCodigo = 'VLIBS' Then
    fltAliquota := fltAlqIbsReforma
  Else
    fltAliquota := fltAlqIsReforma;

  FieldByName('VALCAD').AsFloat := fltAliquota;
  If fltSoma <> 0 Then
    FieldByName('VALCAL').AsFloat := RoundTo((fltPreImp - fltPreVen) * fltAliquota / fltSoma, -intDecUni);
End;

Procedure TFormulaCustoProduto.pMontaValores(dtsIteger: TDataSet; blnPreDol: Boolean; blnTabelaPrecos: Boolean = False);
var fltImpFed: Double;
Begin
  AfterScroll := Nil;
  BeforePost  := Nil;

  First;

  While Not Eof Do
  Begin
    Edit;
    If SameText('IMPFED', FieldByName('FOR_CODCAM').AsString) And blnRedImpFed Then
    Begin
      fltImpFed := dtsIteger.FieldByName('ITE_IMPFED').AsFloat;
      If blnRedImpFed Then
        fltImpFed := (dtsIteger.FieldByName('ITE_IMPFED').AsFloat * (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat/100)));
      FieldByName('VALCAD').AsFloat := fltImpFed;
    End

    Else If SameText('COMLIQ', FieldByName('FOR_CODCAM').AsString) Then
    Begin
      FieldByName('VALCAD').AsFloat := untfuncoesSimples.fCalculaPrecoCompraLiq(dtsIteger.FieldByName('ITE_PRECOM').AsFloat,
                                                     dtsIteger.FieldByName('ITE_DESF01').AsFloat,
                                                     dtsIteger.FieldByName('ITE_DESF02').AsFloat,
                                                     dtsIteger.FieldByName('ITE_DESF03').AsFloat,
                                                     dtsIteger.FieldByName('ITE_DESF04').AsFloat,
                                                     dtsIteger.FieldByName('ITE_DESF05').AsFloat,
                                                     dtsIteger.FieldByName('ITE_DESF06').AsFloat,
                                                     intDecUni,
                                                     blnPreDol);
    End

    Else If SameText('CUSREA', FieldByName('FOR_CODCAM').AsString) Then
    Begin
      FieldByName('VALCAD').AsFloat := untfuncoesSimples.fCalculaCustoReal(dtsIteger.FieldByName('ITE_PRECUS').AsFloat,
                                                     dtsIteger.FieldByName('ITE_ICMSAI').AsFloat,
                                                     dtsIteger.FieldByName('ITE_IMPFED').AsFloat,
                                                     dtsIteger.FieldByName('ITE_DESOPE').AsFloat,
                                                     dtsIteger.FieldByName('ITE_OUTVAL').AsFloat);
      FieldByName('VALCAL').Value := FieldByName('VALCAD').Value;
    End

    Else If Pos(FieldByName('FOR_CODCAM').AsString, 'MARBR1_MARBR2_MARBR3_MARBR4_MARBR5_MARBR6_MARBR7_') > 0 Then
    Begin

      If (FMarMkp = '2') Then
        FieldByName('VALCAD').Value := fMarkupToMargem(dtsIteger.FieldByName(fConveteCampoCorreto('ITE_' + FieldByName('FOR_CODCAM').AsString, blnTabelaPrecos)).AsFloat)
      Else
        FieldByName('VALCAD').Value := dtsIteger.FieldByName(fConveteCampoCorreto('ITE_' + FieldByName('FOR_CODCAM').AsString, blnTabelaPrecos)).AsFloat;

      FieldByName('VALCAL').Value := FieldByName('VALCAD').Value;
    End

    Else If FRefCis And (Pos(LeftStr(FieldByName('FOR_CODCAM').AsString, 5), 'VLCBS_VLIBS_VLISE_PREIM_') > 0) Then
      pMontaValorReforma(dtsIteger, blnTabelaPrecos)

    Else If (Not fEmptyStr(FieldByName('NOMCAM').AsString)) Then
           FieldByName('VALCAD').AsFloat := dtsIteger.FieldByName(fConveteCampoCorreto(FieldByName('NOMCAM').AsString, blnTabelaPrecos)).AsFloat;

    If Pos(FieldByName('FOR_CODCAM').AsString, 'PRECOM_VALFRE_COMLIQ_PRECUS_OUTVAL_ICMSAI_IMPFED_DESOPE_' +
                                               'MARKP1_MARKP2_MARKP3_MARKP4_MARKP5_MARKP6_MARKP7_'+
                                               'COMTB1_COMTB2_COMTB3_COMTB4_COMTB5_COMTB6_COMTB7_') > 0 Then
      FieldByName('VALCAL').Value := FieldByName('VALCAD').Value;

    FieldByName('EXPFUL').Value := FieldByName('EXPVAL').Value;

    Post;

    Next;
  End;

  AfterScroll := pAfterScroll;
  BeforePost  := pBeforePost;
End;

Procedure TFormulaCustoProduto.pAfterScroll(dataSet: TDataSet);
Begin
  With DataSet Do
  ReadOnly := FReadOnly Or (Pos(FieldByName('FOR_CODCAM').AsString, 'ICMENT_SUBFED_IPIENT_FREENT_ACRFIN_SUBSTI_DESADB_TCIFCU_TSCUST_DEPICO_DEICMS_FATREG') = 0);
End;

procedure TFormulaCustoProduto.pAjustaTabelasPrevenMarbru(
  tmp: TUniClientDataSet);

begin
  tmp.First;
  while not tmp.Eof do
  Begin
    tmp.Edit;
    case AnsiIndexStr(tmp.FieldByName('FOR_CODCAM').AsString, ArrCamposPrecoVenda) of
      0: tmp.FieldByName('TABELA').AsString := '1';
      1: tmp.FieldByName('TABELA').AsString := '2';
      2: tmp.FieldByName('TABELA').AsString := '3';
      3: tmp.FieldByName('TABELA').AsString := '4';
      4: tmp.FieldByName('TABELA').AsString := '5';
      5: tmp.FieldByName('TABELA').AsString := '6';
      6: tmp.FieldByName('TABELA').AsString := '7';
    End;
    case AnsiIndexStr(tmp.FieldByName('FOR_CODCAM').AsString, ArrCamposMargemBruta) of
      0: tmp.FieldByName('TABELA').AsString := '1';
      1: tmp.FieldByName('TABELA').AsString := '2';
      2: tmp.FieldByName('TABELA').AsString := '3';
      3: tmp.FieldByName('TABELA').AsString := '4';
      4: tmp.FieldByName('TABELA').AsString := '5';
      5: tmp.FieldByName('TABELA').AsString := '6';
      6: tmp.FieldByName('TABELA').AsString := '7';
    End;
    case AnsiIndexStr(tmp.FieldByName('FOR_CODCAM').AsString, ArrCamposSubTotal) of
      0: tmp.FieldByName('TABELA').AsString := '1';
      1: tmp.FieldByName('TABELA').AsString := '2';
      2: tmp.FieldByName('TABELA').AsString := '3';
      3: tmp.FieldByName('TABELA').AsString := '4';
      4: tmp.FieldByName('TABELA').AsString := '5';
      5: tmp.FieldByName('TABELA').AsString := '6';
      6: tmp.FieldByName('TABELA').AsString := '7';
    End;
    // REFTRI: o numero da tabela e o ultimo digito do codigo.
    If AnsiIndexStr(tmp.FieldByName('FOR_CODCAM').AsString, ArrCamposReforma) >= 0 Then
      tmp.FieldByName('TABELA').AsString := RightStr(tmp.FieldByName('FOR_CODCAM').AsString, 1);
    tmp.Next;
  End;
end;

procedure TFormulaCustoProduto.pARemovePrevenMarbruDuplicadas(
  tmp: TUniClientDataSet);
var i: integer;
begin
  For i := 0 To 6 do
  Begin
    Tmp.Filtered := False;
    Tmp.Filter := 'FOR_CODCAM =  ' + QuotedStr(ArrCamposPrecoVenda[i]);
    Tmp.Filtered := True;
    While tmp.RecordCount > 1 do
      Tmp.Delete;

    Tmp.Filtered := False;
    Tmp.Filter := 'FOR_CODCAM =  ' + QuotedStr(ArrCamposMargemBruta[i]);
    Tmp.Filtered := True;
    While tmp.RecordCount > 1 do
      Tmp.Delete;

    Tmp.Filtered := False;
    Tmp.Filter := 'FOR_CODCAM =  ' + QuotedStr(ArrCamposSubTotal[i]);
    Tmp.Filtered := True;
    While tmp.RecordCount > 1 do
      Tmp.Delete;

    Tmp.Filtered := False;
    Tmp.Filter := '';
  End;

  // REFTRI: as linhas da reforma tambem ficam uma so por codigo.
  For i := Low(ArrCamposReforma) To High(ArrCamposReforma) do
  Begin
    Tmp.Filtered := False;
    Tmp.Filter := 'FOR_CODCAM =  ' + QuotedStr(ArrCamposReforma[i]);
    Tmp.Filtered := True;
    While tmp.RecordCount > 1 do
      Tmp.Delete;
  End;
  Tmp.Filtered := False;
  Tmp.Filter := '';
end;

Procedure TFormulaCustoProduto.pPedeDadosFormula(docWin: TWinControl);
Begin

  Try
    pCriarFormularios(TfrmFormulaCustoProdutoEdicao, frmFormulaCustoProdutoEdicao);

    With TfrmFormulaCustoProdutoEdicao(frmFormulaCustoProdutoEdicao) Do
    Begin
      cxvItensEXPUSU.Visible := False;
      cxvItensVALCAD.Visible := False;
      cxvItensVALCAL.Visible := False;
      cxvItens.OptionsView.ColumnAutoWidth := True;
      objFormula := Self;
      TfrmFormulaCustoProdutoEdicao(frmFormulaCustoProdutoEdicao).blnDemo := Assigned(FobjTabelasDoItem);
      pnlStatus.Visible := False;

      btnSair.ModalResult := mrNone;
      blnFecharComEscape := False;

      pnlBotoes.Visible := False;

      FReadOnly := FNumeroFormula <> 4;

      Align := alClient;
      Dock(docWin, docWin.BoundsRect);

      show;
    End;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFormulaCustoProduto.fPedeDadosFormula]');
    End;

  End;

End;

Procedure TFormulaCustoProduto.pLiberaTela;
Begin
  pFreeAndNil(frmFormulaCustoProdutoEdicao);
End;

Procedure TFormulaCustoProduto.pMostraCalculoFormula(dtsIteger: TDataSet; blnPreDol: Boolean);
Begin
  Try
    Self.Filtered := False;
    Self.Filter := '';

    pDistribuiTabelas;
    FNumeroFormula := fCfgSis('FRMCUS', varInteger);

    intDecUni := fCfgSis('DECUNI', varInteger);
    strMskUni := '#0.' + fStrZero('0', intDecUni);

    If Assigned(FobjTabelasDoItem) Then
    Begin
      FobjTabelasDoItem.First;
      While not FobjTabelasDoItem.Eof Do
      begin
        Self.Filtered := False;
        Self.Filter := 'TABELA = ' + QuotedStr(FobjTabelasDoItem.FieldByName('TABELA').AsString);
        Self.Filtered := True;

        pMontaValores(FobjTabelasDoItem, blnPreDol, True);
        pCompletaFormulas(FobjTabelasDoItem, blnPreDol, True);
        pCompletaFormulaUsuario(FobjTabelasDoItem, blnPreDol, True);
        FobjTabelasDoItem.Next;
      End;
      Self.Filtered := False;
      Self.Filter := '';

    End
    Else
    Begin
      pMontaValores(dtsIteger, blnPreDol);
      pCompletaFormulas(dtsIteger, blnPreDol);
      pCompletaFormulaUsuario(dtsIteger, blnPreDol);

    End;


    pCriarFormularios(TfrmFormulaCustoProdutoEdicao, frmFormulaCustoProdutoEdicao);

    With TfrmFormulaCustoProdutoEdicao(frmFormulaCustoProdutoEdicao) Do
    Begin
      Caption := 'Construção do Preço do Produto';

      btnConfirma.Visible := False;
      btnSair.Caption := '&Sair';

      WindowState := wsMaximized;
      cxvItens.OptionsView.ColumnAutoWidth := True;
      cxvItens.OptionsSelection.CellSelect := False;
      objFormula := Self;
      TfrmFormulaCustoProdutoEdicao(frmFormulaCustoProdutoEdicao).blnDemo := Assigned(FobjTabelasDoItem);

      TcxCurrencyEditProperties(cxvItensVALCAD.Properties).DecimalPlaces := intDecUni;
      TcxCurrencyEditProperties(cxvItensVALCAD.Properties).DisplayFormat := '0.' + fStrZero('0', intDecUni) + ';-0.' + fStrZero('0', intDecUni);

      TcxCurrencyEditProperties(cxvItensVALCAL.Properties).DecimalPlaces := intDecUni;
      TcxCurrencyEditProperties(cxvItensVALCAL.Properties).DisplayFormat := '0.' + fStrZero('0', intDecUni) + ';-0.' + fStrZero('0', intDecUni);

      cxvItens.OptionsData.Editing := False;

      AfterScroll := Nil;
      BeforePost  := Nil;

      ShowModal;

      If Assigned(FobjTabelasDoItem) Then
        pRemoveTodosRegistrosAdicionados;
    End;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFormulaCustoProduto.fPedeDadosFormula]');
    End;

  End;

  pFreeAndNil(frmFormulaCustoProdutoEdicao);
End;

Procedure TFormulaCustoProduto.pDefinirImpostosReforma(fltCbs, fltIbs, fltIs: Double);
Begin
  fltAlqCbsReforma := fltCbs;
  fltAlqIbsReforma := fltIbs;
  fltAlqIsReforma  := fltIs;
End;

Function TFormulaCustoProduto.fFormulaValida(strFrmCus: String): Boolean;
  Var
    strCodCam: String;
Begin
  Result := fValidaExpressaoCampo('ICMENT', strFrmCus) And
            fValidaExpressaoCampo('SUBFED', strFrmCus) And
            fValidaExpressaoCampo('IPIENT', strFrmCus) And
            fValidaExpressaoCampo('FREENT', strFrmCus) And
            fValidaExpressaoCampo('ACRFIN', strFrmCus) And
            fValidaExpressaoCampo('SUBSTI', strFrmCus) And
            fValidaExpressaoCampo('DESADB', strFrmCus);

            If (Result) And (fCfgSis('SUFRAM', varBoolean)) Then
            Begin
              Result := fValidaExpressaoCampo('TCIFCU', strFrmCus) And
                        fValidaExpressaoCampo('TSCUST', strFrmCus) And
                        fValidaExpressaoCampo('DEPICO', strFrmCus) And
                        fValidaExpressaoCampo('DEICMS', strFrmCus) And
                        fValidaExpressaoCampo('FATREG', strFrmCus);
            End;


  If Result And (strFrmCus = '4') Then
  Begin
    Result := fValidaExpressaoCustoLoopInfinito(strCodCam);

    If Not Result Then
      pMensagemOk('A expressão utilizada no campo ' + strCodCam + ' produz um laço infinito no cálculo!');
  End;
End;

Function TFormulaCustoProduto.fValidaExpressaoCampo(strCodCam, strFrmCus: String): Boolean;
Begin
  Result := False;

  If Not FindKey([strCodCam]) Then
  Begin
    pMensagemOk('Valor ' + strCodCam + ' não encontrado!');
    pRefreshTela;
    Exit;
  End;

  If fEmptyStr(FieldByName('FOR_BASCAL').AsString) And (strFrmCus = '4') Then
  Begin
    pMensagemOk('Base de cálculo para o valor ' + FieldByName('FOR_CODCAM').AsString + ' não informada!');
    pRefreshTela;
    Exit;
  End;

  Result := True;
End;

Function TFormulaCustoProduto.fMontaExpressaoCusto: String;
Begin
  BeforePost  := Nil;
  AfterScroll := Nil;

  Result := untFuncoesPrecoCusto.MontarExpressaoCusto(TObject(Self));

  BeforePost  := pBeforePost;
  AfterScroll := pAfterScroll;
End;

Procedure TFormulaCustoProduto.pCompletaFormulaUsuario(dtsIteger: TDataSet; blnPreDol: Boolean; blnTabelaPrecos: Boolean = False);
  Var
    cdsCopia: TUniClientDataSet;
    strExpressao: String;
Begin
  BeforePost  := Nil;
  AfterScroll := Nil;

  First;
  While Not Eof Do
  Begin

    Edit;

    If Pos(FieldByName('FOR_CODCAM').AsString, 'ICMENT_SUBFED_IPIENT_FREENT_ACRFIN_SUBSTI_DESADB_TCIFCU_TSCUST_DEPICO_DEICMS_FATREG') > 0 Then
    Begin

        If FieldByName('VALCAD').AsFloat <> 0 Then
        Begin

          If (Pos('+', FieldByName('FOR_BASCAL').AsString) > 0) Or
             (Pos('-', FieldByName('FOR_BASCAL').AsString) > 0) Or
             (Pos('*', FieldByName('FOR_BASCAL').AsString) > 0) Or
             (Pos('/', FieldByName('FOR_BASCAL').AsString) > 0) Then
            FieldByName('EXPUSU').AsString := '(' + FieldByName('FOR_BASCAL').AsString + ') * ' + FieldByName('VALCAD').AsString + '%'
          Else
            FieldByName('EXPUSU').AsString := FieldByName('FOR_BASCAL').AsString + ' * ' + FieldByName('VALCAD').AsString + '%';

        End

        Else FieldByName('EXPUSU').AsString := '@';

    End;

    If FieldByName('FOR_CODCAM').AsString = 'COMLIQ' Then
      FieldByName('EXPUSU').AsString := 'PRECOM - DESF01 - DESF02 - DESF03 - DESF04 - DESF05 - DESF06';

    If FieldByName('FOR_CODCAM').AsString = 'VALFRE' Then
      FieldByName('EXPUSU').AsString := 'VALFRE';

    If FieldByName('FOR_CODCAM').AsString = 'CUSREA' Then
      FieldByName('EXPUSU').AsString := '(PRECUS + OUTVAL) / (1 - (ICMSAI + IMPFED + DESOPE)/100)';

    If LeftStr(FieldByName('FOR_CODCAM').AsString, 5) = 'SUBTO' Then
      FieldByName('EXPUSU').AsString := UpperCase(FieldByName('EXPVAL').AsString);

    If LeftStr(FieldByName('FOR_CODCAM').AsString, 5) = 'CUSVE' Then
      FieldByName('EXPUSU').AsString := UpperCase(FieldByName('EXPVAL').AsString);

    If Pos(FieldByName('FOR_CODCAM').AsString, 'MARBR1_MARBR2_MARBR3_MARBR4_MARBR5_MARBR6_MARBR7_' +
                                               'PREVE1_PREVE2_PREVE3_PREVE4_PREVE5_PREVE6_PREVE7_') > 0 Then
      FieldByName('EXPUSU').AsString := FieldByName('EXPVAL').AsString;

    Post;

    Next;
  End;

  cdsCopia := TUniClientDataSet.Create(Nil);
  cdsCopia.Data := Self.Data;
  If blnTabelaPrecos Then
  Begin
    cdsCopia.Filtered := False;
    cdsCopia.Filter := 'TABELA = ' + QuotedStr(FobjTabelasDoItem.FieldByName('TABELA').AsString);
    cdsCopia.Filtered := True;
  End;

  cdsCopia.First;

  While Not cdsCopia.Eof Do
  Begin

    First;
    While Not Eof Do
    Begin

      If Not fEmptyStr(FieldByName('EXPUSU').AsString) Then
      Begin

        strExpressao := FieldByName('EXPUSU').AsString;

        If Pos(cdsCopia.FieldByName('FOR_CODCAM').AsString, 'CUSREA_OUTVAL_ICMSAI_IMPFED_DESOPE_PRECOM_COMLIQ_PRECUS_VALFRE_ICMENT_SUBFED_IPIENT_FREENT_ACRFIN_SUBSTI_DESADB_' +
                                                            'DESF01_DESF02_DESF03_DESF04_DESF05_DESF06_' +
                                                            'OUTVAL_ICMSAI_IMPFED_DESOPE_' +
                                                            'MARBR1_MARBR2_MARBR3_MARBR4_MARBR5_MARBR6_MARBR7_'+
                                                            'MARKP1_MARKP2_MARKP3_MARKP4_MARKP5_MARKP6_MARKP7_'+
                                                            'COMTB1_COMTB2_COMTB3_COMTB4_COMTB5_COMTB6_COMTB7_'+
                                                            'SUBTO1_SUBTO2_SUBTO3_SUBTO4_SUBTO5_SUBTO6_SUBTO7_'+
                                                            'CUSVE1_CUSVE2_CUSVE3_CUSVE4_CUSVE5_CUSVE6_CUSVE7_'+
                                                            'TCIFCU_TSCUST_DEPICO_DEICMS_FATREG_') > 0 Then
        Begin

          If cdsCopia.FieldByName('VALCAL').AsFloat <> 0 Then
          Begin

            If Pos(cdsCopia.FieldByName('FOR_CODCAM').AsString, 'DESF01_DESF02_DESF03_DESF04_DESF05_DESF06_') > 0 Then
              strExpressao := AnsiReplaceStr(strExpressao, cdsCopia.FieldByName('FOR_CODCAM').AsString, cdsCopia.FieldByName('VALCAD').AsString + '%')

            Else If Pos(cdsCopia.FieldByName('FOR_CODCAM').AsString, 'ICMSAI_IMPFED_DESOPE_' +
                                                                     'COMTB1_COMTB2_COMTB3_COMTB4_COMTB5_COMTB6_COMTB7_') > 0 Then
              strExpressao := AnsiReplaceStr(strExpressao, cdsCopia.FieldByName('FOR_CODCAM').AsString, cdsCopia.FieldByName('VALCAD').AsString)

            Else If Pos(cdsCopia.FieldByName('FOR_CODCAM').AsString, 'MARKP1_MARKP2_MARKP3_MARKP4_MARKP5_MARKP6_MARKP7_' +
                                                                     'MARBR1_MARBR2_MARBR3_MARBR4_MARBR5_MARBR6_MARBR7_') > 0 Then
              strExpressao := AnsiReplaceStr(strExpressao, cdsCopia.FieldByName('FOR_CODCAM').AsString, FormatFloat(fMskDigitos(2), cdsCopia.FieldByName('VALCAL').AsFloat))

            Else
              strExpressao := AnsiReplaceStr(strExpressao, cdsCopia.FieldByName('FOR_CODCAM').AsString, FormatFloat(fMskDigitos(intDecUni), cdsCopia.FieldByName('VALCAL').AsFloat));

          End
          Else
            strExpressao := AnsiReplaceStr(strExpressao, cdsCopia.FieldByName('FOR_CODCAM').AsString, '@');

        End;

        strExpressao := AnsiReplaceStr(strExpressao, ' + @', '');
        strExpressao := AnsiReplaceStr(strExpressao, ' - @', '');
        strExpressao := AnsiReplaceStr(strExpressao, ' +@',  '');
        strExpressao := AnsiReplaceStr(strExpressao, ' -@',  '');
        strExpressao := AnsiReplaceStr(strExpressao, '+@',   '');
        strExpressao := AnsiReplaceStr(strExpressao, '-@',   '');
        strExpressao := AnsiReplaceStr(strExpressao, '@',    '0');

        Edit;
        FieldByName('EXPUSU').AsString := strExpressao;
        Post;

      End;

      Next;

    End;

    cdsCopia.Next;

  End;

  First;
  While Not Eof Do
  Begin

    If FieldByName('EXPUSU').AsString = '0' Then
    Begin

      Edit;
      FieldByName('EXPUSU').AsString := '';
      Post;

    End;

    Next;
  End;


  FreeAndNil(cdsCopia);

  BeforePost  := pBeforePost;
  AfterScroll := pAfterScroll;
End;

procedure TFormulaCustoProduto.pDistribuiTabelas;
 var tmp: TUniClientDataSet;
     i: integer;
begin
  If Assigned(FobjTabelasDoItem) Then
  Begin
    tmp := TUniClientDataSet.Create(nil);
    Try
      tmp.Data := Self.Data;
      while not tmp.Eof Do
        tmp.delete;
      FobjTabelasDoItem.First;
      While not FobjTabelasDoItem.Eof Do
      Begin
        Self.First;
        While not Self.Eof Do
        Begin
          tmp.Insert;
          for i := 0 To Self.Fields.Count -1 do
            tmp.Fields[i].Value := Self.Fields[i].Value;
          tmp.FieldByName('TABELA').AsString := FobjTabelasDoItem.FieldByName('TABELA').AsString;
          tmp.FieldByName('TABFOR').AsString := 'Tabela do Fornec: ' + FobjTabelasDoItem.FieldByName('ITE_CODTAB').AsString + '-' +
                                                FobjTabelasDoItem.FieldByName('NOMTAB').AsString + '      ' +
                                                'Fornecedor: ' + FobjTabelasDoItem.FieldByName('FORNEC').AsString;

          tmp.FieldByName('DESITE').AsString := 'Item: ' + FobjTabelasDoItem.FieldByName('ITE_CODITE').AsString + '-' +
                                                           fRetNomProduto(FobjTabelasDoItem.FieldByName('ITE_CODITE').AsString);


          tmp.post;
          Self.Next;
        End;
        FobjTabelasDoItem.Next;
      End;

      pARemovePrevenMarbruDuplicadas(tmp);

      pAjustaTabelasPrevenMarbru(tmp);

      Self.Data := tmp.Data;

    Finally
      FreeAndNil(tmp);
    End;
  End;
end;

Procedure TFormulaCustoProduto.pCompletaFormulas(dtsIteger: TDataSet; blnPreDol: Boolean; blnTabelaPrecos: Boolean = False);
  Var
    blnErro: Boolean;
    cdsCopia: TUniClientDataSet;
    fltPreCom: Double;

  Procedure pCompleta(strCampos: String);
    Var
      blnTrocou: Boolean;
      strExpAnt,
      strExpressao: String;

  Begin
    Repeat

      blnTrocou := False;

      cdsCopia.First;

      While Not cdsCopia.Eof Do
      Begin

        If Pos(cdsCopia.FieldByName('FOR_CODCAM').AsString, strCampos) > 0 Then
        Begin

          First;
          While Not Eof Do
          Begin

            If Pos(FieldByName('FOR_CODCAM').AsString, strCampos) > 0 Then
            Begin

              strExpAnt    := FieldByName('EXPFUL').AsString;

              strExpressao := AnsiReplaceStr(strExpAnt, cdsCopia.FieldByName('FOR_CODCAM').AsString, cdsCopia.FieldByName('EXPVAL').AsString);

              If strExpAnt <> strExpressao Then
              Begin
                blnTrocou := True;

                Edit;
                FieldByName('EXPFUL').AsString := strExpressao;
                Post;

              End;

            End;

            Next;
          End;

        End;

        cdsCopia.Next;
      End;

    Until Not blnTrocou;
  End;

Begin
  BeforePost  := Nil;
  AfterScroll := Nil;

  cdsCopia := TUniClientDataSet.Create(Nil);
  cdsCopia.Data := Self.Data;

  pCompleta('DESF01_DESF02_DESF03_DESF04_DESF05_DESF06_');
  pCompleta('ICMENT_SUBFED_IPIENT_FREENT_ACRFIN_SUBSTI_DESADB_TCIFCU_TSCUST_DEPICO_DEICMS_FATREG_');

  FreeAndNil(cdsCopia);

  First;

  While Not Eof Do
  Begin

    If (Pos(FieldByName('FOR_CODCAM').AsString, 'ICMENT_SUBFED_IPIENT_FREENT_ACRFIN_SUBSTI_DESADB_CUSREA_' +
                                                'DESF01_DESF02_DESF03_DESF04_DESF05_DESF06_' +
                                                'SUBTO1_SUBTO2_SUBTO3_SUBTO4_SUBTO5_SUBTO6_SUBTO7_'+
                                                'CUSVE1_CUSVE2_CUSVE3_CUSVE4_CUSVE5_CUSVE6_CUSVE7_'+
                                                'MARBR1_MARBR2_MARBR3_MARBR4_MARBR5_MARBR6_MARBR7_'+
                                                'MARBR1_MARBR2_MARBR3_MARBR4_MARBR5_MARBR6_MARBR7_'+
                                                'PREVE1_PREVE2_PREVE3_PREVE4_PREVE5_PREVE6_PREVE7_'+
                                                'TCIFCU_TSCUST_DEPICO_DEICMS_FATREG_') > 0) And
       (Not fEmptyStr(FieldByName('EXPFUL').AsString)) Then
    Begin
      FComLiq := untfuncoesSimples.fCalculaPrecoCompraLiq(dtsIteger.FieldByName('ITE_PRECOM').AsFloat,
                                                     dtsIteger.FieldByName('ITE_DESF01').AsFloat,
                                                     dtsIteger.FieldByName('ITE_DESF02').AsFloat,
                                                     dtsIteger.FieldByName('ITE_DESF03').AsFloat,
                                                     dtsIteger.FieldByName('ITE_DESF04').AsFloat,
                                                     dtsIteger.FieldByName('ITE_DESF05').AsFloat,
                                                     dtsIteger.FieldByName('ITE_DESF06').AsFloat,
                                                     intDecUni,
                                                     blnPreDol);

      FIcmEnt := dtsIteger.FieldByName('ITE_ICMENT').AsFloat;
      FSubFed := dtsIteger.FieldByName('ITE_SUBFED').AsFloat;
      FIpiEnt := dtsIteger.FieldByName('ITE_IPIENT').AsFloat;
      FFreEnt := dtsIteger.FieldByName('ITE_FREENT').AsFloat;
      FValFre := dtsIteger.FieldByName('ITE_VALFRE').AsFloat;
      FAcrFin := dtsIteger.FieldByName('ITE_ACRFIN').AsFloat;
      FSubsti := dtsIteger.FieldByName('ITE_SUBSTI').AsFloat;
      FDesAdb := dtsIteger.FieldByName('ITE_DESADB').AsFloat;

      FOutVal := dtsIteger.FieldByName('ITE_OUTVAL').AsFloat;
      FIcmSai := dtsIteger.FieldByName('ITE_ICMSAI').AsFloat;
      FImpFed := dtsIteger.FieldByName('ITE_IMPFED').AsFloat;
      If blnRedImpFed Then
        FImpFed := (dtsIteger.FieldByName('ITE_IMPFED').AsFloat * (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat/100)));

      FDesOpe := dtsIteger.FieldByName('ITE_DESOPE').AsFloat;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        FTCIFCu := dtsIteger.FieldByName('ITE_TCIFCU').AsFloat;
        FTSCust := dtsIteger.FieldByName('ITE_TSCUST').AsFloat;
        FDePiCo := dtsIteger.FieldByName('ITE_DEPICO').AsFloat;
        FDeICMS := dtsIteger.FieldByName('ITE_DEICMS').AsFloat;
        FFatReg := dtsIteger.FieldByName('ITE_FATREG').AsFloat;
      end
      else
      begin
        FTCIFCu := 0;
        FTSCust := 0;
        FDePiCo := 0;
        FDeICMS := 0;
        FFatReg := 0;
      end;

      pSetaAliquotas;

      With fscScript Do
      Begin

        fltPreCom := dtsIteger.FieldByName('ITE_PRECOM').AsFloat;

        If (blnPreDol) Then
          fltPreCom  := fConvertePrecos(fltPreCom , moeDolar);

        AddConst('PRECOM', 'Double', fltPreCom);
        AddConst('DesF01', 'Double', dtsIteger.FieldByName('ITE_DESF01').AsFloat);
        AddConst('DesF02', 'Double', dtsIteger.FieldByName('ITE_DESF02').AsFloat);
        AddConst('DesF03', 'Double', dtsIteger.FieldByName('ITE_DESF03').AsFloat);
        AddConst('DesF04', 'Double', dtsIteger.FieldByName('ITE_DESF04').AsFloat);
        AddConst('DesF05', 'Double', dtsIteger.FieldByName('ITE_DESF05').AsFloat);
        AddConst('DesF06', 'Double', dtsIteger.FieldByName('ITE_DESF06').AsFloat);

        AddConst('PRECUS', 'Double', dtsIteger.FieldByName('ITE_PRECUS').AsFloat);
        If blnTabelaPrecos Then
          AddConst('COMTB' +FobjTabelasDoItem.FieldByName('TABELA').AsString, 'Double', dtsIteger.FieldByName('ITE_COMTBL').AsFloat)
        Else
        Begin
          AddConst('COMTB1', 'Double', dtsIteger.FieldByName('ITE_COMTB1').AsFloat);
          AddConst('COMTB2', 'Double', dtsIteger.FieldByName('ITE_COMTB2').AsFloat);
          AddConst('COMTB3', 'Double', dtsIteger.FieldByName('ITE_COMTB3').AsFloat);
          AddConst('COMTB4', 'Double', dtsIteger.FieldByName('ITE_COMTB4').AsFloat);
          AddConst('COMTB5', 'Double', dtsIteger.FieldByName('ITE_COMTB5').AsFloat);
          AddConst('COMTB6', 'Double', dtsIteger.FieldByName('ITE_COMTB6').AsFloat);
          AddConst('COMTB7', 'Double', dtsIteger.FieldByName('ITE_COMTB7').AsFloat);
        End;

       If Not blnTabPrd then
       begin
         AddConst('PREVE1', 'Double', dtsIteger.FieldByName('ITE_PREVE1').AsFloat);
         AddConst('PREVE2', 'Double', dtsIteger.FieldByName('ITE_PREVE2').AsFloat);
         AddConst('PREVE3', 'Double', dtsIteger.FieldByName('ITE_PREVE3').AsFloat);
         AddConst('PREVE4', 'Double', dtsIteger.FieldByName('ITE_PREVE4').AsFloat);
         AddConst('PREVE5', 'Double', dtsIteger.FieldByName('ITE_PREVE5').AsFloat);
         AddConst('PREVE6', 'Double', dtsIteger.FieldByName('ITE_PREVE6').AsFloat);
         AddConst('PREVE7', 'Double', dtsIteger.FieldByName('ITE_PREVE7').AsFloat);
       End;

        Case FMarMkp[1] Of
          '2': Begin
                 If blnTabelaPrecos Then
                 Begin
                   AddConst('MARKP' +FobjTabelasDoItem.FieldByName('TABELA').AsString, 'Double', dtsIteger.FieldByName('ITE_MARBRU').AsFloat);
                   AddConst('MARBR' +FobjTabelasDoItem.FieldByName('TABELA').AsString, 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBRU').AsFloat));
                   AddConst('SUBTO' +FobjTabelasDoItem.FieldByName('TABELA').AsString, 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBRU').AsFloat) + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTBL').AsFloat);
                 End
                 Else
                 Begin

                   AddConst('MARKP1', 'Double', dtsIteger.FieldByName('ITE_MARBR1').AsFloat);
                   AddConst('MARKP2', 'Double', dtsIteger.FieldByName('ITE_MARBR2').AsFloat);
                   AddConst('MARKP3', 'Double', dtsIteger.FieldByName('ITE_MARBR3').AsFloat);
                   AddConst('MARKP4', 'Double', dtsIteger.FieldByName('ITE_MARBR4').AsFloat);
                   AddConst('MARKP5', 'Double', dtsIteger.FieldByName('ITE_MARBR5').AsFloat);
                   AddConst('MARKP6', 'Double', dtsIteger.FieldByName('ITE_MARBR6').AsFloat);
                   AddConst('MARKP7', 'Double', dtsIteger.FieldByName('ITE_MARBR7').AsFloat);

                   AddConst('MARBR1', 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBR1').AsFloat));
                   AddConst('MARBR2', 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBR2').AsFloat));
                   AddConst('MARBR3', 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBR3').AsFloat));
                   AddConst('MARBR4', 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBR4').AsFloat));
                   AddConst('MARBR5', 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBR5').AsFloat));
                   AddConst('MARBR6', 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBR6').AsFloat));
                   AddConst('MARBR7', 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBR7').AsFloat));

                   AddConst('SUBTO1', 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBR1').AsFloat) + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB1').AsFloat);
                   AddConst('SUBTO2', 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBR2').AsFloat) + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB2').AsFloat);
                   AddConst('SUBTO3', 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBR3').AsFloat) + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB3').AsFloat);
                   AddConst('SUBTO4', 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBR4').AsFloat) + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB4').AsFloat);
                   AddConst('SUBTO5', 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBR5').AsFloat) + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB5').AsFloat);
                   AddConst('SUBTO6', 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBR6').AsFloat) + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB6').AsFloat);
                   AddConst('SUBTO7', 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBR7').AsFloat) + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB7').AsFloat);
                   If Not blnTabPrd then
                   begin
                     AddConst('CUSVE1', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat +  FOutVal) + (dtsIteger.FieldByName('ITE_PREVE1').AsFloat * ( FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB1').AsFloat)));
                     AddConst('CUSVE2', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat +  FOutVal) + (dtsIteger.FieldByName('ITE_PREVE2').AsFloat * ( FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB2').AsFloat)));
                     AddConst('CUSVE3', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat +  FOutVal) + (dtsIteger.FieldByName('ITE_PREVE3').AsFloat * ( FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB3').AsFloat)));
                     AddConst('CUSVE4', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat +  FOutVal) + (dtsIteger.FieldByName('ITE_PREVE4').AsFloat * ( FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB4').AsFloat)));
                     AddConst('CUSVE5', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat +  FOutVal) + (dtsIteger.FieldByName('ITE_PREVE5').AsFloat * ( FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB5').AsFloat)));
                     AddConst('CUSVE6', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat +  FOutVal) + (dtsIteger.FieldByName('ITE_PREVE6').AsFloat * ( FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB6').AsFloat)));
                     AddConst('CUSVE7', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat +  FOutVal) + (dtsIteger.FieldByName('ITE_PREVE7').AsFloat * ( FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB7').AsFloat)));
                   End;

                 End;
               End;

          '1': Begin
                 If blnTabelaPrecos Then
                 Begin
                   AddConst('MARBR' +FobjTabelasDoItem.FieldByName('TABELA').AsString, 'Double', dtsIteger.FieldByName('ITE_MARBRU').AsFloat);
                   AddConst('SUBTO' +FobjTabelasDoItem.FieldByName('TABELA').AsString, 'Double', dtsIteger.FieldByName('ITE_MARBRU').AsFloat + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTBL').AsFloat);
                 End
                 Else
                 Begin
                   AddConst('MARBR1', 'Double', dtsIteger.FieldByName('ITE_MARBR1').AsFloat);
                   AddConst('MARBR2', 'Double', dtsIteger.FieldByName('ITE_MARBR2').AsFloat);
                   AddConst('MARBR3', 'Double', dtsIteger.FieldByName('ITE_MARBR3').AsFloat);
                   AddConst('MARBR4', 'Double', dtsIteger.FieldByName('ITE_MARBR4').AsFloat);
                   AddConst('MARBR5', 'Double', dtsIteger.FieldByName('ITE_MARBR5').AsFloat);
                   AddConst('MARBR6', 'Double', dtsIteger.FieldByName('ITE_MARBR6').AsFloat);
                   AddConst('MARBR7', 'Double', dtsIteger.FieldByName('ITE_MARBR7').AsFloat);

                   AddConst('SUBTO1', 'Double', dtsIteger.FieldByName('ITE_MARBR1').AsFloat + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB1').AsFloat);
                   AddConst('SUBTO2', 'Double', dtsIteger.FieldByName('ITE_MARBR2').AsFloat + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB2').AsFloat);
                   AddConst('SUBTO3', 'Double', dtsIteger.FieldByName('ITE_MARBR3').AsFloat + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB3').AsFloat);
                   AddConst('SUBTO4', 'Double', dtsIteger.FieldByName('ITE_MARBR4').AsFloat + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB4').AsFloat);
                   AddConst('SUBTO5', 'Double', dtsIteger.FieldByName('ITE_MARBR5').AsFloat + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB5').AsFloat);
                   AddConst('SUBTO6', 'Double', dtsIteger.FieldByName('ITE_MARBR6').AsFloat + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB6').AsFloat);
                   AddConst('SUBTO7', 'Double', dtsIteger.FieldByName('ITE_MARBR7').AsFloat + FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB7').AsFloat);


                   If Not blnTabPrd then
                   Begin
                     AddConst('CUSVE1', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat +  FOutVal) + (dtsIteger.FieldByName('ITE_PREVE1').AsFloat * ( FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB1').AsFloat)));
                     AddConst('CUSVE2', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat +  FOutVal) + (dtsIteger.FieldByName('ITE_PREVE2').AsFloat * ( FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB2').AsFloat)));
                     AddConst('CUSVE3', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat +  FOutVal) + (dtsIteger.FieldByName('ITE_PREVE3').AsFloat * ( FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB3').AsFloat)));
                     AddConst('CUSVE4', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat +  FOutVal) + (dtsIteger.FieldByName('ITE_PREVE4').AsFloat * ( FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB4').AsFloat)));
                     AddConst('CUSVE5', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat +  FOutVal) + (dtsIteger.FieldByName('ITE_PREVE5').AsFloat * ( FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB5').AsFloat)));
                     AddConst('CUSVE6', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat +  FOutVal) + (dtsIteger.FieldByName('ITE_PREVE6').AsFloat * ( FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB6').AsFloat)));
                     AddConst('CUSVE7', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat +  FOutVal) + (dtsIteger.FieldByName('ITE_PREVE7').AsFloat * ( FIcmSai + FImpFed + FDesOpe + dtsIteger.FieldByName('ITE_COMTB7').AsFloat)));
                   End;
                 End;
               End;

          '3': Begin
                 If blnTabelaPrecos Then
                 Begin
                   AddConst('MARKP' +FobjTabelasDoItem.FieldByName('TABELA').AsString, 'Double', dtsIteger.FieldByName('ITE_MARBRU').AsFloat);
                   AddConst('SUBTO' +FobjTabelasDoItem.FieldByName('TABELA').AsString, 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTBL').AsFloat) / 100));
                 End
                 Else
                 Begin
                   AddConst('MARKP1', 'Double', dtsIteger.FieldByName('ITE_MARBR1').AsFloat);
                   AddConst('MARKP2', 'Double', dtsIteger.FieldByName('ITE_MARBR2').AsFloat);
                   AddConst('MARKP3', 'Double', dtsIteger.FieldByName('ITE_MARBR3').AsFloat);
                   AddConst('MARKP4', 'Double', dtsIteger.FieldByName('ITE_MARBR4').AsFloat);
                   AddConst('MARKP5', 'Double', dtsIteger.FieldByName('ITE_MARBR5').AsFloat);
                   AddConst('MARKP6', 'Double', dtsIteger.FieldByName('ITE_MARBR6').AsFloat);
                   AddConst('MARKP7', 'Double', dtsIteger.FieldByName('ITE_MARBR7').AsFloat);

                   AddConst('SUBTO1', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTB1').AsFloat) / 100));
                   AddConst('SUBTO2', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTB2').AsFloat) / 100));
                   AddConst('SUBTO3', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTB3').AsFloat) / 100));
                   AddConst('SUBTO4', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTB4').AsFloat) / 100));
                   AddConst('SUBTO5', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTB5').AsFloat) / 100));
                   AddConst('SUBTO6', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTB6').AsFloat) / 100));
                   AddConst('SUBTO7', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTB7').AsFloat) / 100));
                 End;
               End;

          '5': Begin
                 If blnTabelaPrecos Then
                 Begin
                   AddConst('MARBR' +FobjTabelasDoItem.FieldByName('TABELA').AsString, 'Double', fMarkupToMargem(dtsIteger.FieldByName('ITE_MARBRU').AsFloat));
                   AddConst('SUBTO' +FobjTabelasDoItem.FieldByName('TABELA').AsString, 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTBL').AsFloat) / 100));
                 End
                 Else
                 Begin
                   AddConst('MARBR1', 'Double', dtsIteger.FieldByName('ITE_MARBR1').AsFloat);
                   AddConst('MARBR2', 'Double', dtsIteger.FieldByName('ITE_MARBR2').AsFloat);
                   AddConst('MARBR3', 'Double', dtsIteger.FieldByName('ITE_MARBR3').AsFloat);
                   AddConst('MARBR4', 'Double', dtsIteger.FieldByName('ITE_MARBR4').AsFloat);
                   AddConst('MARBR5', 'Double', dtsIteger.FieldByName('ITE_MARBR5').AsFloat);
                   AddConst('MARBR6', 'Double', dtsIteger.FieldByName('ITE_MARBR6').AsFloat);
                   AddConst('MARBR7', 'Double', dtsIteger.FieldByName('ITE_MARBR7').AsFloat);

                   AddConst('SUBTO1', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTB1').AsFloat) / 100));
                   AddConst('SUBTO2', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTB2').AsFloat) / 100));
                   AddConst('SUBTO3', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTB3').AsFloat) / 100));
                   AddConst('SUBTO4', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTB4').AsFloat) / 100));
                   AddConst('SUBTO5', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTB5').AsFloat) / 100));
                   AddConst('SUBTO6', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTB6').AsFloat) / 100));
                   AddConst('SUBTO7', 'Double', (dtsIteger.FieldByName('ITE_PRECUS').AsFloat + dtsIteger.FieldByName('ITE_OUTVAL').AsFloat) / (1 - (dtsIteger.FieldByName('ITE_ICMSAI').AsFloat + FImpFed + dtsIteger.FieldByName('ITE_DESOPE').AsFloat + dtsIteger.FieldByName('ITE_COMTB7').AsFloat) / 100));
                 End;
               End;

        End;

      End;

      Edit;
      FieldByName('VALCAL').Value := fExecutaExpressao(FieldByName('EXPFUL').AsString, False, blnErro);
      Post;
    End;

    Next;

  End;

  BeforePost  := pBeforePost;
  AfterScroll := pAfterScroll;
End;

Function TFormulaCustoProduto.fCalculaPrecoCusto(fltComLiq, fltIcmEnt, fltSubFed,
                                                 fltIpiEnt, fltFreEnt, fltValFre,
                                                 fltAcrFin, fltSubsti, fltDesAdb,
                                                 fltTCIFCu, fltTSCust,
                                                 fltDePiCo, fltDeICMS, fltFatReg: Double): Double;
   Var
     blnErro: Boolean;
Begin

  FComLiq := fltComLiq;
  FIcmEnt := fltIcmEnt;
  FSubFed := fltSubFed;
  FIpiEnt := fltIpiEnt;
  FFreEnt := fltFreEnt;
  FValFre := fltValFre;
  FAcrFin := fltAcrFin;
  FSubsti := fltSubsti;
  FDesAdb := fltDesAdb;
  FTCIFCu := fltTCIFCu;
  FTSCust := fltTSCust;
  FDePiCo := fltDePiCo;
  FDeICMS := fltDeICMS;
  FFatReg := fltFatReg;

  pSetaAliquotas;

  Result := fExecutaExpressao(VS_strFormulaCusto4, False, blnErro);
End;

Function TFormulaCustoProduto.fValidaExpressaoCustoLoopInfinito(var strCodCam: String): Boolean;
  Var
    cdsFormula1, cdsFormula2: TUniClientDataSet;
    blnHouveTroca: Boolean;
    strFormula: String;
Begin
  Result := True;

  cdsFormula1 := TUniClientDataSet.Create(Nil);
  cdsFormula1.Data := Self.Data;
  cdsFormula1.IndexFieldNames := 'FOR_CODCAM';

  cdsFormula2 := TUniClientDataSet.Create(Nil);
  cdsFormula2.Data := Self.Data;
  cdsFormula2.IndexFieldNames := 'FOR_CODCAM';

  Try
    Repeat
      blnHouveTroca := False;

      cdsFormula1.First;
      While (Not cdsFormula1.Eof) Do
      Begin

        cdsFormula1.Edit;

        cdsFormula2.First;
        While (Not cdsFormula2.Eof) Do
        Begin
          strFormula := cdsFormula1.FieldByName('FOR_BASCAL').AsString;

          cdsFormula1.FieldByName('FOR_BASCAL').AsString := AnsiReplaceStr(cdsFormula1.FieldByName('FOR_BASCAL').AsString,
                                                                           cdsFormula2.FieldByName('FOR_CODCAM').AsString,
                                                                           cdsFormula2.FieldByName('FOR_BASCAL').AsString);

          If strFormula <> cdsFormula1.FieldByName('FOR_BASCAL').AsString Then
            blnHouveTroca := True;

          cdsFormula2.Next;
        End;

        cdsFormula1.Post;

        If Pos(cdsFormula1.FieldByName('FOR_CODCAM').AsString, cdsFormula1.FieldByName('FOR_BASCAL').AsString) > 0 Then
        Begin
          strCodCam := cdsFormula1.FieldByName('FOR_CODCAM').AsString;
          Result := False;
          Exit;
        End;

        If cdsFormula2.FindKey([cdsFormula1.FieldByName('FOR_CODCAM').AsString]) Then
        Begin
          cdsFormula2.Edit;
          cdsFormula2.FieldByName('FOR_BASCAL').AsString := cdsFormula1.FieldByName('FOR_BASCAL').AsString;
          cdsFormula2.Post;
        End;

        cdsFormula1.Next;
      End;

    Until Not blnHouveTroca;

  Finally
    FreeAndNil(cdsFormula1);
    FreeAndNil(cdsFormula2);
  End;
End;

end.
