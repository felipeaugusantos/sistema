unit untDuplicatasPedidoCompra;

interface

Uses
  Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Forms, Uni,
  untZClient, StrUtils, Math, Variants, untConsultas, cxProgressBar,
  untFuncoesSimples, untFuncoesGenerica, untTypesSistema,
  UniDataSetProvider;

Type

  TDuplicatasPedidoCompra = Class
  Private

     Procedure pGravaUmaParcela(strSeqGer: String; recDigDuplic: TArrDigDuplic);
     Procedure pApagaParcelas(strSeqGer: String);

  Public

    arrParcelas: TarrDuplicata;

    blnManterValoresPadrao: Boolean;

    Constructor Create;

    Destructor Destroi;

    Procedure pGravaParcelasGeral(strSeqGer, strConPag, strCodFor: String; fltTotGer, fltTotIte: Double; dtaDtaPed: TDateTime;
                     Var arrParcelasP: TarrDuplicata);

    Procedure pCopiaDuplicatas(arrOrigem: TarrDuplicata; Var arrDestino: TarrDuplicata; strConPag: String);

    Procedure pGravaParcelas(strSeqGer, strConPag, strCodFor: String; fltTotGer, fltTotIte: Double; dtaDtaPed: TDateTime);

    Procedure pCarregaParcelas(strSeqGer: String);

    Function fGetCondPagamento(dtaDtaDoc: TDateTime): String;

    Procedure pSetaDuplicatas(arrDuplicata: TarrDuplicata; strConPag: String);

    Function fTemValores: Boolean; Overload;

    Function fTemValores(arrParcelasP: TarrDuplicata): Boolean; overLoad;

    Function fGetTotalParcelas: Double;

    Procedure pInicializaParcelas(strConPag, strCodFor: String; fltTotGer, fltTotIte: Double; dtaDtaDoc: TDateTime; Var arrParcelasP: TarrDuplicata);

    Procedure pCalculaDuplicatasProporcional(strConPag, strCodFor: String; fltTotGer, fltTotIte: Double; dtaDtaDoc: TDateTime; Var arrParcelasDesmen: TarrDuplicata);

    Procedure pAtualizaDuplicatasProporcional(strSeqGer, strConPag, strCodFor: String;
                  fltTotGer, fltTotIte: Double; dtaDtaPed: TDateTime);

    Function fDigDuplicPedido(var arrDuplicata: TarrDuplicata; strConPag, strCodFor: String; fltTotGer, fltTotIte: Double; dtaDtaPed: TDateTime;
                              blnMostrarTela, blnEditavel, blnManterValoesOriginais: Boolean): Boolean;

    Class Procedure pAtualizaBaixaParcial(strNumPed, strCodEmp, strEspDoc: String);

    Class Procedure pMostraDuplicatas(var arrDuplicata: TarrDuplicata; strNumPed, strCodEmp, strEspDoc: String);

    Procedure pLimpaParcelas;

  End;

implementation

uses
  untConstantes, untDuplicatas;

Const
	arrLetra : Array[0..25] Of Char = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');

Procedure pExecutaComando(strSQL: String;
                          arrParametros: Array Of String;
                          arrValores  : Array Of Variant;
                          qryExecuta  : TUniQuery = Nil);
  Var
    intContador: Integer;
    blnLiberar: Boolean;
Begin
  If Not Assigned(qryExecuta) Then
  Begin
    qryExecuta := fCriaQuery;
    blnLiberar := True;
  End

  Else blnLiberar := False;

  With qryExecuta Do
  Begin
    SQL.Text := strSQL;

    For intContador := Low(arrParametros) To High(arrParametros) Do
      ParamByName(arrParametros[intContador]).Value := arrValores[intContador];

    ExecSQL;
  End;

  If blnLiberar Then
    FreeAndNil(qryExecuta);
End;

Constructor TDuplicatasPedidoCompra.Create;
Begin
  blnManterValoresPadrao := True;
End;

Destructor TDuplicatasPedidoCompra.Destroi;
Begin

End;

Procedure TDuplicatasPedidoCompra.pInicializaParcelas(strConPag, strCodFor: String;
                fltTotGer, fltTotIte: Double; dtaDtaDoc: TDateTime;
                Var arrParcelasP: TarrDuplicata);
  Var
    intQtdPar,
    intContador: Integer;
    curTotalRes: Currency;
    arrDuplicatas: TArrDigDuplicArray;
Begin

  fDigDuplicSemTelaVar(False, arrDuplicatas, intQtdPar, curTotalRes, strConPag, 0, fltTotGer,
                       False, False, dtaDtaDoc, False, fltTotGer - fltTotIte, 'N', fRetArred2ParcFornec(strCodFor), False, 0.0, Nil,
                       True {blnSabDomFeriadosComoDiaUtil}, False{blnFatPed});

  FillChar(arrParcelasP, SizeOf(arrParcelasP), #0);

  For intContador := Low(arrParcelasP) To High(arrParcelasP) Do
  Begin
    If intContador > High(arrDuplicatas) Then
      Break;

    arrParcelasP[intContador] := arrDuplicatas[intContador];
  End;

End;

Procedure TDuplicatasPedidoCompra.pApagaParcelas(strSeqGer: String);
Begin
  pExecutaComando('DELETE FROM PCMPAR WHERE PAR_SEQGER = :SEQGER', ['SEQGER'], [strSeqGer]);
End;

Procedure TDuplicatasPedidoCompra.pGravaParcelas(strSeqGer, strConPag, strCodFor: String; fltTotGer, fltTotIte: Double; dtaDtaPed: TDateTime);
Begin
  pGravaParcelasGeral(strSeqGer, strConPag, strCodFor, fltTotGer, fltTotIte, dtaDtaPed, arrParcelas);
End;

Procedure TDuplicatasPedidoCompra.pGravaParcelasGeral(strSeqGer, strConPag, strCodFor: String; fltTotGer, fltTotIte: Double; dtaDtaPed: TDateTime;
                     Var arrParcelasP: TarrDuplicata);
  Var
    recDigDuplic: TArrDigDuplic;
Begin
  pApagaParcelas(strSeqGer);

  If (fStatusCndPag(strConPag) <> A_VISTA) Then
  Begin
    If (Not fTemValores(arrParcelasP)) Then
      pInicializaParcelas(strConPag, strCodFor, fltTotGer, fltTotIte, dtaDtaPed, arrParcelasP);

    For recDigDuplic In arrParcelasP Do
      If (Not fEmptyStr(recDigDuplic.dtaDtaVen)) And (recDigDuplic.curValor > 0) Then
        pGravaUmaParcela(strSeqGer, recDigDuplic)
      Else
        Break;
  End;
End;

Procedure TDuplicatasPedidoCompra.pGravaUmaParcela(strSeqGer: String; recDigDuplic: TArrDigDuplic);
Begin
  With recDigDuplic Do
  pExecutaComando('INSERT INTO PCMPAR ' +
                  '(PAR_SEQGER, PAR_DTAVEN, PAR_VALPAR) VALUES ' +
                  '(:SEQGER, :DTAVEN, :VALPAR)' ,
                   ['SEQGER', 'DTAVEN', 'VALPAR'],
                   [strSeqGer, StrToDate(dtaDtaVen), curValor]);
End;

Procedure TDuplicatasPedidoCompra.pCopiaDuplicatas(arrOrigem: TarrDuplicata; Var arrDestino: TarrDuplicata; strConPag: String);
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrOrigem) To High(arrOrigem) Do
  Begin
    arrDestino[intContador] := arrOrigem[intContador];

    If intContador < StrToIntDef(Copy(strConPag,0,2), 0) Then
      arrDestino[intContador].strSequen := arrLetra[intContador];
  End;

  arrDestino[Low(arrOrigem)].blnManterValoresPadrao := blnManterValoresPadrao;
End;

Procedure TDuplicatasPedidoCompra.pSetaDuplicatas(arrDuplicata: TarrDuplicata; strConPag: String);
Begin
  pCopiaDuplicatas(arrDuplicata, arrParcelas, strConPag);

  blnManterValoresPadrao := arrDuplicata[Low(arrDuplicata)].blnManterValoresPadrao;
End;

Procedure TDuplicatasPedidoCompra.pLimpaParcelas;
Begin
  FillChar(arrParcelas, SizeOf(arrParcelas), #0);
End;

Procedure TDuplicatasPedidoCompra.pCarregaParcelas(strSeqGer: String);
  Var
    qryPcmPar: TUniQuery;
    intContador: Integer;
Begin
  FillChar(arrParcelas, SizeOf(arrParcelas), #0);

  qryPcmPar := fCriaQuery;

  With qryPcmPar Do
  Begin
    SQL.Text := 'SELECT * FROM PCMPAR WHERE PAR_SEQGER = :SEQGER ORDER BY PAR_DTAVEN';

    ParamByName('SEQGER').Value := strSeqGer;

    Open;

    intContador := 0;

    While Not Eof Do
    Begin
      arrParcelas[intContador].dtaDtaVen := FormatDateTime('DD/MM/YYYY', FieldByName('PAR_DTAVEN').AsDateTime);
      arrParcelas[intContador].curValor  := FieldByName('PAR_VALPAR').AsFloat;
      arrParcelas[intContador].strSequen := arrLetra[intContador];

      Inc(intContador);

      Next;
    End;

  End;

  FreeAndNil(qryPcmPar);
End;

Function TDuplicatasPedidoCompra.fTemValores(arrParcelasP: TarrDuplicata): Boolean;
  Var
    recDigDuplic: TArrDigDuplic;
Begin
  Result := False;

  For recDigDuplic In arrParcelasP Do
    If Not fEmptyStr(recDigDuplic.dtaDtaVen) Then
    Begin
      Result := True;
      Exit;
    End;

End;

Function TDuplicatasPedidoCompra.fTemValores: Boolean;
Begin
  Result := fTemValores(arrParcelas);
End;

Function TDuplicatasPedidoCompra.fGetCondPagamento(dtaDtaDoc: TDateTime): String;
  Var
    intContador : Integer;
    arrDatas    : TDateArray;
begin
  intContador := 0;

  While (arrParcelas[intContador].dtaDtaVen <> '') And
        (intContador <= 23)                         Do
  Begin

    SetLength(arrDatas, intContador+1);
    arrDatas[intContador] := StrToDate(arrParcelas[intContador].dtaDtaVen);
    Inc(intContador);

  End;

  Result := fRetornaCndPag(arrDatas, dtaDtaDoc);
end;

Function TDuplicatasPedidoCompra.fGetTotalParcelas: Double;
  Var
    recDigDuplic: TArrDigDuplic;
Begin
  Result := 0;

  For recDigDuplic In arrParcelas Do
    If Not fEmptyStr(recDigDuplic.dtaDtaVen) Then
      Result := Result + recDigDuplic.curValor;

  Result := RoundTo(Result, -2);
End;

Procedure TDuplicatasPedidoCompra.pCalculaDuplicatasProporcional(strConPag, strCodFor: String; fltTotGer, fltTotIte: Double; dtaDtaDoc: TDateTime;
                    Var arrParcelasDesmen: TarrDuplicata);
  Var
    intQtdPar,
    intContador: Integer;
    fltTotRes,
    fltTotSum: Double;
    arrParcelasNovaData: TarrDuplicata;
Begin
  intQtdPar := StrToIntDef(LeftStr(strConPag, 2), 0);

  fltTotSum := fGetTotalParcelas;

  If fltTotSum = 0 Then
  Begin
    pInicializaParcelas(strConPag, strCodFor, fltTotGer, fltTotIte, dtaDtaDoc, arrParcelasDesmen);
    Exit;
  End;

  pInicializaParcelas(strConPag, strCodFor, fltTotGer, fltTotIte, dtaDtaDoc, arrParcelasNovaData);

  fltTotRes := fltTotGer;

  For intContador := Low(arrParcelas) To High(arrParcelas) Do
  Begin
    arrParcelasDesmen[intContador] := arrParcelas[intContador];
    arrParcelasDesmen[intContador].dtaDtaVen := arrParcelasNovaData[intContador].dtaDtaVen;

    If arrParcelasDesmen[intContador].curValor > 0 Then
    Begin

      If intQtdPar = Succ(intContador) Then
      Begin

        arrParcelasDesmen[intContador].curValor := fltTotRes;

      End Else
      Begin

        If RoundTo((arrParcelas[intContador].curValor / fltTotSum) * fltTotGer, -2) < fltTotRes Then
          arrParcelasDesmen[intContador].curValor := RoundTo((arrParcelas[intContador].curValor / fltTotSum) * fltTotGer, -2)
        Else
          arrParcelasDesmen[intContador].curValor := fltTotRes;

      End;

    End;

    fltTotRes := fltTotRes - arrParcelasDesmen[intContador].curValor;

  End;

End;

Procedure TDuplicatasPedidoCompra.pAtualizaDuplicatasProporcional(strSeqGer, strConPag, strCodFor: String;
                  fltTotGer, fltTotIte: Double; dtaDtaPed: TDateTime);
  Var
    arrParcelasDesmen: TarrDuplicata;
Begin
  pCalculaDuplicatasProporcional(strConPag, strCodFor, fltTotGer, fltTotIte, dtaDtaPed, arrParcelasDesmen);

  pGravaParcelasGeral(strSeqGer, strConPag, strCodFor, fltTotGer, fltTotIte, dtaDtaPed, arrParcelasDesmen);
end;

Class Procedure TDuplicatasPedidoCompra.pAtualizaBaixaParcial(strNumPed, strCodEmp, strEspDoc: String);
  Var
    qryPcmger: TUniQuery;
    objDuplicatas: TDuplicatasPedidoCompra;
Begin
  qryPcmger := fCriaQuery(Nil);

  With qryPcmger, SQL Do
  Begin
    Add('SELECT');
    Add('  PCG_CONPAG,');
    Add('  PCG_TOTGER,');
    Add('  PCG_TOTITE,');
    Add('  PCG_DTAENT,');
    Add('  PCG_CODFOR,');
    Add('  AUTOINCREM');
    Add('FROM');
    Add('  PCMGER');
    Add('WHERE');
    Add('      PCG_NUMPED = :NUMPED');
    Add('  AND PCG_CODEMP = :CODEMP');
    Add('  AND PCG_ESPDOC = :ESPDOC');

    ParamByName('NUMPED').AsString := strNumPed;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('ESPDOC').AsString := strEspDoc;

    Open;

    If Not IsEmpty Then
    Begin
      objDuplicatas := TDuplicatasPedidoCompra.Create;
      objDuplicatas.pCarregaParcelas(FieldByName('AUTOINCREM').AsString);
      objDuplicatas.pAtualizaDuplicatasProporcional(FieldByName('AUTOINCREM').AsString,
                                                    FieldByName('PCG_CONPAG').AsString,
                                                    FieldByName('PCG_CODFOR').AsString,
                                                    FieldByName('PCG_TOTGER').AsFloat,
                                                    FieldByName('PCG_TOTITE').AsFloat,
                                                    FieldByName('PCG_DTAENT').AsDateTime);
      FreeAndNil(objDuplicatas);
    End;

  End;

  FreeAndNil(qryPcmger);
End;

Function TDuplicatasPedidoCompra.fDigDuplicPedido(var arrDuplicata: TarrDuplicata; strConPag, strCodFor: String; fltTotGer, fltTotIte: Double; dtaDtaPed: TDateTime;
                                                  blnMostrarTela, blnEditavel, blnManterValoesOriginais: Boolean): Boolean;
Begin
  pCopiaDuplicatas(arrParcelas, arrDuplicata, strConPag);

  Result := fDigDuplic( arrDuplicata,
                        strConPag,
                        0,
                        fltTotGer,
                        blnMostrarTela, //blnMosTela,
                        blnEditavel,
                        False,   // blnHabEditDup
                        dtaDtaPed,
                        False,   // blnPergConf
                        fltTotGer - fltTotIte,
                        'N',     // strUsaChq
                        fRetArred2ParcFornec(strCodFor), // blnDupsRedondas
                        False,   // blnUsaHist
                        0,
                        False,    // blnFaturamento
                        Nil,
                        '',
                        True,    // blnSabDomFeriadoDiasUteis
                        True,    // blnHabEditValor
                        Nil,
                        '',
                        True,    // blnPerRep
                        False,   // blnValoresPadrao
                        '',      // strCodCnd: String = '';
                        '',      // strCodVen: String = '';
                        Nil,     // fSenVar: TGenericFunctionWithArrayParam = Nil;
                        False,   // blnFatPed: Boolean = False;
                        False,   // blnAgrupVeio: Boolean = False;
                        Nil,     // objArredondamento: IArredondaParcela = Nil;
                        blnManterValoesOriginais,
                        True {blnMostrarOpcaoPadrao} );
End;

Class Procedure TDuplicatasPedidoCompra.pMostraDuplicatas(var arrDuplicata: TarrDuplicata; strNumPed, strCodEmp, strEspDoc: String);
  Var
    qryPcmger: TUniQuery;
    objDuplicatas: TDuplicatasPedidoCompra;
Begin
  qryPcmger := fCriaQuery(Nil);

  With qryPcmger, SQL Do
  Begin
    Add('SELECT');
    Add('  PCG_CONPAG,');
    Add('  PCG_TOTGER,');
    Add('  PCG_TOTITE,');
    Add('  PCG_DTAENT,');
    Add('  PCG_CODFOR,');
    Add('  AUTOINCREM');
    Add('FROM');
    Add('  PCMGER');
    Add('WHERE');
    Add('      PCG_NUMPED = :NUMPED');
    Add('  AND PCG_CODEMP = :CODEMP');
    Add('  AND PCG_ESPDOC = :ESPDOC');

    ParamByName('NUMPED').AsString := strNumPed;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('ESPDOC').AsString := strEspDoc;

    Open;

    If Not IsEmpty Then
    Begin

      If (fStatusCndPag(FieldByName('PCG_CONPAG').AsString) <> A_VISTA) Then
      Begin

        objDuplicatas := TDuplicatasPedidoCompra.Create;
        objDuplicatas.pCarregaParcelas(FieldByName('AUTOINCREM').AsString);

        objDuplicatas.blnManterValoresPadrao := False;

       { If (Not objDuplicatas.fTemValores) Then
           objDuplicatas.pInicializaParcelas(FieldByName('PCG_CONPAG').AsString,
                                             FieldByName('PCG_CODFOR').AsString,
                                             FieldByName('PCG_TOTGER').AsFloat,
                                             FieldByName('PCG_TOTITE').AsFloat,
                                             FieldByName('PCG_DTAENT').AsDateTime,
                                             objDuplicatas.arrParcelas); }

        objDuplicatas.fDigDuplicPedido(arrDuplicata,
                         FieldByName('PCG_CONPAG').AsString,
                         FieldByName('PCG_CODFOR').AsString,
                         FieldByName('PCG_TOTGER').AsFloat,
                         FieldByName('PCG_TOTITE').AsFloat,
                         FieldByName('PCG_DTAENT').AsDateTime,
                         True {blnMostrarTela},
                         False {blnEditavel},
                         True {blnManterValoesOriginais});

        FreeAndNil(objDuplicatas);

      End

      Else pMensagemOk('Esse pedido é a vista!');

    End

    Else pMensagemOk('Pedido não encontrado!');
  End;

  FreeAndNil(qryPcmger);
End;

end.
