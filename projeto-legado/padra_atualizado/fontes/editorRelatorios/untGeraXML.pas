unit untGeraXML;

interface

uses
  Classes, SysUtils, Variants, untTypesSistema,
  Controls, StdCtrls, StrUtils, Printers,
  frxClass, frxDBSet, frxDesgn, frxDMPExport,
  Uni, DB, untFuncoesSimples, untRelFrx, frxDMPClass,
  cxProgressBar, Forms,
  untFuncEditorRel, untZClient, Math, untGeraFR3;

type
  TGeraXML = class(TComponent)
    private
      FLinhas: TStringList;

      FArquivoAberto: String;
      FTextFile: TextFile;

      FNroRel,
      FNroCam: Integer;

      FPasta,
      FLinha: String;

      FGeraGR3: TGeraFR3;

      intDecUni,
      intDECQTD,
      intEstDec,
      intDeqTpc: Integer;

      FGravaDireto: Boolean;
      FApenasPrincipal: Boolean;

      Function fEstaQuebrando(objGeraFr3P: TGeraFR3; strCampo: String): Boolean;
      Function fNumeroDecimais(objGeraFr3P: TGeraFR3): Integer;
      Function fCampoToStringSemLimite(filCampo: TField; intNroDec: Integer): String;

      Function fGeraArquivo(Progress: TcxProgressBar): Boolean;

      Function fGeraArquivoPorQuebra(Var intPosRel: Integer): Boolean;

      Procedure pEscreveLinha(strLinha: String);

      Function fGeraLinhas(strNomArq: String; objGeraFr3P: TGeraFR3; blnExprValida: Boolean = False): Boolean;

      Procedure pGeraQuebras(objGeraFr3P: TGeraFR3; blnExprValida: Boolean; var strCamposQuebra: string;
                             var strValoresQuebra: string;
                             Var stlLinhaQuebraAnterior: TStringList);

      Procedure pDesempilhaQuebras(objGeraFr3P: TGeraFR3);

      Procedure pGeraLinhaQuebra(objGeraFr3P: TGeraFR3; strNomeQuebra: String; blnExprValida: Boolean; Var stlLinhaQuebraAnterior: TStringList);

      Procedure pAdicionaCampoNaLinha(strTag: String; filCampo: TField; intNroDec, intTamanho: Integer);

      Function fAbreArquivo(strNomeArquivo: String): Boolean;

      Function fGravaArquivoAuxiliar(strNomArq: String; blnGerarSeVazio: Boolean): Boolean;

      function fGravaArquivo(blnGerarSeVazio: Boolean): Boolean;

      Function fGetCdsCampos: TZClient;
      Function fGetCdsQuebras: TZClient;

    public

      constructor Create(AOwner: TComponent);  Reintroduce;
      destructor Destroy; override;

      Function fGeraXML(strPasta: String; blnApenasPrincipal: Boolean = False): Boolean;

    published

       Property objGeraGR3: TGeraFR3 Read FGeraGR3 Write FGeraGR3;

  end;

implementation

Uses
  untGravando, untRelatorio, untInterfaceRelatorio,
  untGeraXMLPAF;

constructor TGeraXML.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FArquivoAberto := '';

  FLinhas := TStringList.Create;

  FNroRel := 0;

  FGravaDireto := False;

  FApenasPrincipal := False;

  intDecUni := fCfgSis('DECUNI', varInteger);
  intDECQTD := fCfgSis('DECQTD', varInteger);
  intEstDec := fCfgSis('ESTDEC', varInteger);
  intDeqTpc := fCfgSis('DEQTPC', varInteger);
end;

destructor TGeraXML.Destroy;
begin
  inherited;

  FLinhas.Clear;
  FreeAndNil(FLinhas);
end;

Function TGeraXML.fAbreArquivo(strNomeArquivo: String): Boolean;
Begin
  Try
    If SameText(strNomeArquivo, FArquivoAberto) Then
    Begin
      Result := True;
      Exit;
    End;

    AssignFile(FTextFile, strNomeArquivo);
    Rewrite(FTextFile);

    FArquivoAberto := strNomeArquivo;

   Result := True;

  Except

    On E: Exception Do
    Begin
      FArquivoAberto := '';
      pMensagensErro(E.Message, 'TGeraXML.fAbreArquivo');
      Result := False;
    End;
  End;

End;

Function TGeraXML.fGravaArquivo(blnGerarSeVazio: Boolean): Boolean;
Begin
  Result := False;
  if FLinhas.Count > 0 then
    Result := True;
  if blnGerarSeVazio then
    Result := True;
  if FGravaDireto then
    Result := True;
End;

Function TGeraXML.fGravaArquivoAuxiliar(strNomArq: String; blnGerarSeVazio: Boolean): Boolean;
Begin
  Result := fGravaArquivo(blnGerarSeVazio);
  If Result Then
  Begin
    If FGravaDireto Then
    Begin
      If Not FArquivoAberto.IsEmpty Then
      Begin
        Flush(FTextFile);
        Close(FTextFile);
        FArquivoAberto := '';
      End;
    End Else
    Begin
      FLinhas.SaveToFile(Concat(FPasta, strNomArq));
    End;

  End;

  FLinhas.Clear;
  FLinha := '';
  FNroCam := 0;
End;

Function TGeraXML.fGeraXML(strPasta: String; blnApenasPrincipal: Boolean = False): Boolean;
Begin
  Try
    FPasta := strPasta;

    FApenasPrincipal := blnApenasPrincipal;

    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Gerando arquivo XML...';
    frmGravando.fExecutarAcao := fGeraArquivo;
    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

    pFreeAndNil(frmGravando);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TGeraXML.fGeraXML');
      Result := True;
    End;
  End;
End;

Function TGeraXML.fGeraArquivo(Progress: TcxProgressBar): Boolean;
  Var
    intContador: Integer;
Begin
  Try
    Result := True;

    If Not FArquivoAberto.IsEmpty Then
    Begin
      Close(FTextFile);
      FArquivoAberto := '';
    End;

    SetLength(FGeraGR3.FExprValida, 0);

    frmGravando.pgbStatus.Properties.Max := 0;

    For intContador := Low(FGeraGR3.qryDados) To High(FGeraGR3.qryDados) Do
      frmGravando.pgbStatus.Properties.Max := frmGravando.pgbStatus.Properties.Max +
                                              FGeraGR3.qryDados[intContador].RecordCount;

    frmGravando.pgbStatus.Position := 0;

    intContador := 0;

    While intContador <= High(FGeraGR3.arrCadRel) Do
    Begin
      Result := fGeraArquivoPorQuebra(intContador);

      If Not Result Then
        Break;
    End;

  Except

    On E: EFCreateError Do
    Begin
      pMensagemOk('Não foi possível salvar, o arquivo já está sendo usado por outro processo.');
      Result := True;
    end;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TGeraXML.fGeraArquivo');
      Result := True;
    End;
  End;
End;

Function TGeraXML.fGeraArquivoPorQuebra(Var intPosRel: Integer): Boolean;
  Var
    intContador,
    intProximaQuebra: Integer;
    strNomArq: String;
    blnGerarSeVazio: Boolean;
Begin
  Try
    intProximaQuebra := Succ(intPosRel);

    FNroRel := intPosRel;

    FGravaDireto := FGeraGR3.arrCadRel[intPosRel].FieldByName('REL_GRADIR').AsString = 'S';

    Result := True;

    strNomArq       := TInterfaceRelatorio(FGeraGR3.objInterfaceGera).stlArquivos[intPosRel];
    blnGerarSeVazio := TInterfaceRelatorio(FGeraGR3.objInterfaceGera).stlGerarSeVazio[intPosRel] = 'S';

    If FGravaDireto Then
    Begin
      Result := fAbreArquivo(Concat(FPasta, strNomArq));

      If Not Result Then
        Exit;
    End;

    If Not fEmptyStr(FGeraGR3.arrCadRel[intPosRel].FieldByName('REL_TAGCAB').AsString) Then
      pEscreveLinha(FGeraGR3.arrCadRel[intPosRel].FieldByName('REL_TAGCAB').AsString);

    For intContador := intPosRel To High(FGeraGR3.arrCadRel) Do
    Begin
      If (intContador > 0) And
         (Not FGeraGR3.cdsComple.Locate('REL_CODREL', FGeraGR3.arrCadRel[intContador].FieldByName('REL_CODREL').AsString, [])) Then
      Begin
        Result := False;
        pMensagemOk('Erro interno. Relatório não econtrado.');
        Break;
      End;

      If (intContador > 0) And (intContador <> intPosRel) And SameText(FGeraGR3.cdsComple.FieldByName('REL_NOVPAG').AsString, 'S') Then
      Begin
        intProximaQuebra := intContador;
        Break;
      End Else
      Begin
        intProximaQuebra := Succ(intContador);
      End;

      If Not FGeraGR3.qryDados[intContador].IsEmpty Then
      Begin
        FNroRel := intContador;
        Result := fGeraLinhas(strNomArq, FGeraGR3, True);
      End;
    End;

    If Not fEmptyStr(FGeraGR3.arrCadRel[intPosRel].FieldByName('REL_TAGROD').AsString) Then
      pEscreveLinha(FGeraGR3.arrCadRel[intPosRel].FieldByName('REL_TAGROD').AsString);

    SetLength(FGeraGR3.FExprValida, 0);

    If Result Then
      Result := fGravaArquivoAuxiliar(strNomArq, blnGerarSeVazio);

    intPosRel := intProximaQuebra;

  Except

    On E: EFCreateError Do
    Begin
      pMensagemOk('Não foi possível salvar, o arquivo já está sendo usado por outro processo.');
      Result := True;
    end;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TGeraXML.fGeraArquivo');
      Result := True;
    End;
  End;
End;

Procedure TGeraXML.pEscreveLinha(strLinha: String);
Begin
  If FGravaDireto Then
    Write(FTextFile, strLinha)
  Else
    FLinhas.Add(strLinha);
End;

Function TGeraXML.fGetCdsCampos: TZClient;
begin
  If FNroRel = 0 Then
    Result := FGeraGR3.cdsCamposG
  Else
    Result := TRelatorio(FGeraGR3.arrSalvaComplementos[Pred(FNroRel)]).objInterface.cdsCampos;
End;

Function TGeraXML.fGetCdsQuebras: TZClient;
begin
  If FNroRel = 0 Then
    Result := FGeraGR3.cdsQuebras
  Else
    Result := TRelatorio(FGeraGR3.arrSalvaComplementos[Pred(FNroRel)]).objGeraFr3.cdsQuebras;
End;

Function TGeraXML.fGeraLinhas(strNomArq: String; objGeraFr3P: TGeraFR3; blnExprValida: Boolean = False): Boolean;
  Var
    strCamposQuebra,
    strValoresQuebra: String;
    arrCamQue: array of string;
    arrValAnt: array of string;
    stlLinhaQuebraAnterior: TStringList;
    intContador: Integer;
Begin
  If FNroRel = 0 Then
    FGeraGR3.pCarregaQuebras
  Else
    TRelatorio(FGeraGR3.arrSalvaComplementos[Pred(FNroRel)]).objGeraFr3.pCarregaQuebras;

  SetLength(arrValAnt, 0);
  SetLength(arrCamQue, 0);

  If Not fEmptyStr(objGeraFr3P.arrCadRel[FNroRel].FieldByName('REL_TAGREL').AsString) Then
    pEscreveLinha('<' + objGeraFr3P.arrCadRel[FNroRel].FieldByName('REL_TAGREL').AsString + '>');

  stlLinhaQuebraAnterior :=  TStringList.Create;

  objGeraFr3P.qryDados[FNroRel].First;
  While Not objGeraFr3P.qryDados[FNroRel].Eof Do
  Begin
    FLinha := '';
    FNroCam := 0;

    strCamposQuebra := '';
    strValoresQuebra := '';

    pGeraQuebras(objGeraFr3P, blnExprValida, strCamposQuebra, strValoresQuebra, stlLinhaQuebraAnterior);

    For intContador := 0 To stlLinhaQuebraAnterior.Count - 1 Do
      pEscreveLinha(stlLinhaQuebraAnterior[intContador]);

    objGeraFr3P.qryDados[FNroRel].Next;

    frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;

  pDesempilhaQuebras(objGeraFr3P);

  If Not fEmptyStr(objGeraFr3P.arrCadRel[FNroRel].FieldByName('REL_TAGREL').AsString) Then
    pEscreveLinha('</' + objGeraFr3P.arrCadRel[FNroRel].FieldByName('REL_TAGREL').AsString + '>');

  FreeAndNil(stlLinhaQuebraAnterior);
  Result := True;
End;

Procedure TGeraXML.pDesempilhaQuebras(objGeraFr3P: TGeraFR3);
Begin
  fGetCdsQuebras.Last;
  While Not fGetCdsQuebras.Bof Do
  Begin
    If (Not fEmptyStr(fGetCdsQuebras.FieldByName('CAM_TAGPOS').AsString)) And
       (fGetCdsQuebras.FieldByName('EMPPOS').AsString = 'S') Then
    Begin
      pEscreveLinha('</' + fGetCdsQuebras.FieldByName('CAM_TAGPOS').AsString + '>');

      fGetCdsQuebras.Edit;
      fGetCdsQuebras.FieldByName('EMPPOS').AsString := 'N';
      fGetCdsQuebras.Post;
    End;

    If (Not fEmptyStr(fGetCdsQuebras.FieldByName('CAM_TAGANT').AsString)) And
       (fGetCdsQuebras.FieldByName('EMPANT').AsString = 'S') Then
    Begin
      pEscreveLinha('</' + fGetCdsQuebras.FieldByName('CAM_TAGANT').AsString + '>');

      fGetCdsQuebras.Edit;
      fGetCdsQuebras.FieldByName('EMPANT').AsString := 'N';
      fGetCdsQuebras.Post;
    End;

    fGetCdsQuebras.Prior;
  End;
End;

Procedure TGeraXML.pGeraQuebras(objGeraFr3P: TGeraFR3; blnExprValida: Boolean; var strCamposQuebra: string;
                                var strValoresQuebra: string;
                                Var stlLinhaQuebraAnterior: TStringList);
  Var
    strValorQuebra: String;
    intRecNo: Integer;
Begin
  stlLinhaQuebraAnterior.Clear;

  fGetCdsQuebras.First;
  While Not fGetCdsQuebras.Eof Do
  Begin
    strValorQuebra := objGeraFr3P.qryDados[FNroRel].FieldByName(fGetCdsQuebras.FieldByName('CAM_NOMCAM').AsString).AsString;

    If Not SameText(strValorQuebra, fGetCdsQuebras.FieldByName('VALQUE').AsString) Then
    Begin
      If Not fEmptyStr(fGetCdsQuebras.FieldByName('CAM_TAGPOS').AsString) Then
      Begin
        If fGetCdsQuebras.FieldByName('EMPPOS').AsString = 'S' Then
        Begin
          stlLinhaQuebraAnterior.Add('</' + fGetCdsQuebras.FieldByName('CAM_TAGPOS').AsString + '>');

          fGetCdsQuebras.Edit;
          fGetCdsQuebras.FieldByName('EMPPOS').AsString := 'N';
          fGetCdsQuebras.Post;
        End;
      End;

      If Not fEmptyStr(fGetCdsQuebras.FieldByName('CAM_TAGANT').AsString) Then
      Begin
        If fGetCdsQuebras.FieldByName('EMPANT').AsString = 'S' Then
          stlLinhaQuebraAnterior.Add('</' + fGetCdsQuebras.FieldByName('CAM_TAGANT').AsString + '>');

        stlLinhaQuebraAnterior.Add('<' + fGetCdsQuebras.FieldByName('CAM_TAGANT').AsString + '>');

        fGetCdsQuebras.Edit;
        fGetCdsQuebras.FieldByName('EMPANT').AsString := 'S';
        fGetCdsQuebras.Post;
      End;

      fGetCdsQuebras.Edit;
      fGetCdsQuebras.FieldByName('VALQUE').AsString := strValorQuebra;
      fGetCdsQuebras.Post;

      // LIMPA AS QUEBRAS SUBSEQUENTES
      intRecNo := fGetCdsQuebras.RecNo;
      fGetCdsQuebras.Next;
      While Not fGetCdsQuebras.Eof Do
      Begin
        fGetCdsQuebras.Edit;
        fGetCdsQuebras.FieldByName('VALQUE').AsString := '';
        fGetCdsQuebras.Post;

        fGetCdsQuebras.Next;
      End;

      fGetCdsQuebras.RecNo := intRecNo;

      pGeraLinhaQuebra(objGeraFr3P, fGetCdsQuebras.FieldByName('CAM_NOMCAM').AsString, blnExprValida,
                       stlLinhaQuebraAnterior);

      If Not fEmptyStr(fGetCdsQuebras.FieldByName('CAM_TAGPOS').AsString) Then
      Begin
        stlLinhaQuebraAnterior.Add('<' + fGetCdsQuebras.FieldByName('CAM_TAGPOS').AsString + '>');

        fGetCdsQuebras.Edit;
        fGetCdsQuebras.FieldByName('EMPPOS').AsString := 'S';
        fGetCdsQuebras.Post;
      End;

      strCamposQuebra  := strCamposQuebra + IIF(fEmptyStr(strCamposQuebra), '', ';') + fGetCdsQuebras.FieldByName('CAM_NOMCAM').AsString;
      strValoresQuebra := strValoresQuebra + IIF(fEmptyStr(strValoresQuebra), '', ';') + strValorQuebra;

    End;

    fGetCdsQuebras.Next;
  End;

End;

Function TGeraXML.fEstaQuebrando(objGeraFr3P: TGeraFR3; strCampo: String): Boolean;
Begin
  Result := fGetCdsQuebras.Locate('CAM_NOMCAM', strCampo, []);
End;

Function TGeraXML.fNumeroDecimais(objGeraFr3P: TGeraFR3): Integer;
Begin
  If fGetCdsCampos.FieldByName('CAM_NRODEC').IsNull Then
    Result := 2
  Else
    Case TInterfaceRelatorio.fDescMascaraToTipo(fGetCdsCampos.FieldByName('CAM_MASCAR').AsString) Of
      masDecUni: Result := intDecUni;
      masDecQtd: Result := intDECQTD;
      masEstDec: Result := intEstDec;
      masDeqTpc: Result := intDeqTpc;
      Else       Result := fGetCdsCampos.FieldByName('CAM_NRODEC').AsInteger;
    End;
End;

Procedure TGeraXML.pGeraLinhaQuebra(objGeraFr3P: TGeraFR3; strNomeQuebra: String; blnExprValida: Boolean;
                                     Var stlLinhaQuebraAnterior: TStringList);
  Var
    intLinhaQuebra: Integer;
Begin
  FLinha := '';
  FNroCam := 0;

  intLinhaQuebra := 1;

  fGetCdsCampos.IndexFieldNames := 'CAM_LINQUE;CAM_POSICA';

  fGetCdsCampos.First;

  While Not fGetCdsCampos.Eof Do
  Begin

    If SameText(fGetCdsCampos.FieldByName('CAM_LISQUE').AsString, strNomeQuebra) Then
    If objGeraFr3P.fValidaVisibilidade(fGetCdsCampos) Then
    Begin
      If (intLinhaQuebra <> StrToIntDef(fGetCdsCampos.FieldByName('CAM_LINQUE').AsString, -1)) Then
      Begin
        intLinhaQuebra := StrToIntDef(fGetCdsCampos.FieldByName('CAM_LINQUE').AsString, -1);
        If Not FLinha.IsEmpty Then
          stlLinhaQuebraAnterior.Add(FLinha);
        FLinha := '';
        FNroCam := 0;
      End;

      If fEstaQuebrando(objGeraFr3P, fGetCdsCampos.FieldByName('CAM_LISQUE').AsString) And
       (fGetCdsCampos.FieldByName('CAM_LINQUE').AsString <> '') And
       (fEmptyStr(fGetCdsCampos.FieldByName('CAM_QUAQUE').AsString) Or
          objGeraFr3P.fRetornaExpressaBoolean(fGetCdsCampos.FieldByName('CAM_QUAQUE').AsString, blnExprValida)) Then
          pAdicionaCampoNaLinha(fGetCdsCampos.FieldByName('CAM_DESCAM').AsString,
                                objGeraFr3P.qryDados[FNroRel].FieldByName(fGetCdsCampos.FieldByName('CAM_NOMCAM').AsString),
                                fNumeroDecimais(objGeraFr3P),
                                Trunc(fGetCdsCampos.FieldByName('CAM_LARGUR').AsFloat));

    End;

    fGetCdsCampos.Next;
  End;

  If Not FLinha.IsEmpty Then
  Begin
    If Not fEmptyStr(fGetCdsQuebras.FieldByName('CAM_TAGLIN').AsString) Then
      FLinha := '<' + fGetCdsQuebras.FieldByName('CAM_TAGLIN').AsString + '>' + FLinha +
                '</' + fGetCdsQuebras.FieldByName('CAM_TAGLIN').AsString + '>';

    stlLinhaQuebraAnterior.Add(FLinha);
  End;

  FLinha := '';
  FNroCam := 0;
End;

Procedure TGeraXML.pAdicionaCampoNaLinha(strTag: String; filCampo: TField; intNroDec, intTamanho: Integer);
  Var
    strTexto: String;
Begin
  Inc(FNroCam);

  strTexto := fCampoToStringSemLimite(filCampo, intNroDec);

  If Not strTexto.IsEmpty Then
    FLinha := FLinha + '<' +  strTag + '>' + strTexto + '</' +  strTag + '>';
End;

Function TGeraXML.fCampoToStringSemLimite(filCampo: TField; intNroDec: Integer): String;
Begin

  Case filCampo.DataType Of
    ftTime     : result := IfThen(filCampo.IsNull, '', FormatDateTime('HH:NN:SS', filCampo.AsDateTime));
    ftDateTime : result := IfThen(filCampo.IsNull, '', FormatDateTime('DD/MM/YYYY HH:NN:SS', filCampo.AsDateTime));
    ftDate     : result := IfThen(filCampo.IsNull, '', FormatDateTime('DD/MM/YYYY', filCampo.AsDateTime));
    ftFloat    : result := FormatFloat(fMskDigitos(intNroDec), filCampo.AsFloat);
    ftWord,
    ftInteger  : result := filCampo.AsString;
    Else         result := filCampo.AsString;
  End;

End;

end.
