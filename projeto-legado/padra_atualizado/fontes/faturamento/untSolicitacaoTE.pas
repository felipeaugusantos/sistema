unit untSolicitacaoTE;

interface

Uses
  Classes, UniClientDataSet, DB, Uni, SysUtils, Forms, Windows, Controls,
  System.Generics.Collections, untFuncFatTypes;

Type

  TSolicitacaoTE = Class(TObject)

  Private

    cdsUsado: TUniClientDataSet;
    qryEmpresas: TUniQuery;

    FCarregandoSubItensDaEstrutura : Boolean;

    function  getCarregandoSubItensDaEstrutura : Boolean;
    procedure setCarregandoSubItensDaEstrutura(AValue : Boolean);

    Procedure pCriaItens;
    Procedure pCriaUsado;
    Function fTemItensSemSaldo: Boolean;
    Function fEhAbstecimentoPorOutraLoja: Boolean;
    function fRetornaSaldoOutrasLojas(strCodIte: String): Double;
    procedure pAjustarQuantidadeSolicitada;
  Public

    cdsItens: TUniClientDataSet;
    stlLojas: TStringList;
    blnReq: Boolean;

    blnExibeMensagemTransferenciaEstoque: Boolean;

    Constructor Create; Reintroduce;
    Destructor Destroy; Override;

    Function fIncluiItem(strCodIte, strCodGru, strDescri, strNumLot: String;
                         intAutInc: Integer; fltQtdIte: Double;
                         blnTemSld: Boolean = False): Boolean;
    Function fInformaLojas: Boolean;
    Function fInformaMultiLojas: Boolean;
    Function fJaUtilizado(strCodIte, strCodEmp, strNumLot: String): Double;
    Function fGetEmpresa(intAutInc: Integer): String;
    Function fGetQtdSolicitada(intAutInc: Integer): Double;
    Function fGetLote(intAutInc: Integer): String;
    Function fTemSolicitacaoPropiaLojaSemSaldo: Boolean;
    Procedure pRetornaInfMultiLoja(intAutInc: Integer; var arrCodEmp: TArrCodEmpML; var arrQtdIte: TArrQtdIteML; var arrLotAba: TArrLotAbaML);
    Procedure pAdicionaLojas(strCodEmp: string);

    Procedure pSomaUtilizado(strCodIte, strCodEmp, strNumLot: String; fltQtdIte: Double; blnSoma: Boolean);
    Procedure pSubtUtilizado(strCodIte, strCodEmp, strNumLot: String; fltQtdIte: Double; blnSubt: Boolean);

    property blnCarregandoSubItensDaEstrutura : Boolean read getCarregandoSubItensDaEstrutura write setCarregandoSubItensDaEstrutura;

  End;

implementation

Uses
   UntFuncoesSimples, untSolicitacaoLojas, Variants, untSolicitacaoMultiLojas;

procedure TSolicitacaoTE.pAdicionaLojas(strCodEmp: string);
var
  intIndice: integer;
begin
  If (Not stlLojas.Find(strCodEmp, intIndice)) And (Not fEmptyStr(strCodEmp)) Then
    stlLojas.Add(strCodEmp);
end;

procedure TSolicitacaoTE.pAjustarQuantidadeSolicitada;
  Var
    dicSaldos: TDictionary<String,Double>;
    strCodigo: String;
    fltSalLoj: Double;
begin
  dicSaldos := TDictionary<String,Double>.Create;
  Try
    Try
      cdsItens.Filter   := 'TEMSLD = FALSE';
      cdsItens.Filtered := True;

      { Cria um dicionario com o saldo da loja e deduz o saldo ja utilizado nessa venda }
      cdsItens.First;
      While Not cdsItens.Eof Do
      Begin
        strCodigo := cdsItens.FieldByName('CODITE').AsString +
                     cdsItens.FieldByName('NUMLOT').AsString;

        fltSalLoj := fFormataFloat(cdsItens.FieldByName('SALLOC').AsFloat -
          fJaUtilizado(cdsItens.FieldByName('CODITE').AsString, VS_strCodEmp,
                       cdsItens.FieldByName('NUMLOT').AsString), fCfgSis('DECQTD', varInteger));

        dicSaldos.AddOrSetValue(strCodigo, fltSalLoj);
        cdsItens.Next;
      End;
      cdsItens.First;

      { Reprocessa os produtos deduzindo o saldo remanescente (sobra de saldo) }
      cdsItens.First;
      While Not cdsItens.Eof Do
      Begin
        strCodigo := cdsItens.FieldByName('CODITE').AsString +
                     cdsItens.FieldByName('NUMLOT').AsString;

        dicSaldos.TryGetValue(strCodigo, fltSalLoj);

        cdsItens.Edit;

        if fCfgSis('ABSPML', varBoolean) then
        begin
          dicSaldos.AddOrSetValue(strCodigo, fltSalLoj);
        end
        else
        begin
          If fltSalLoj > 0 Then
          Begin
            If fltSalLoj >= fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, fCfgSis('DECQTD', varInteger)) Then
            Begin
              fltSalLoj := fltSalLoj - cdsItens.FieldByName('QTDITE').AsFloat;
              cdsItens.FieldByName('QTDITE').AsFloat := 0;
            End
            Else
            Begin
              cdsItens.FieldByName('QTDITE').AsFloat :=
                cdsItens.FieldByName('QTDITE').AsFloat - fltSalLoj;
              fltSalLoj := 0;
            End;
            dicSaldos.AddOrSetValue(strCodigo, fltSalLoj);
          End;
        end;

        cdsItens.Post;
        cdsItens.Next;
      End;
    Finally
      cdsItens.Filter   := '';
      cdsItens.Filtered := False;
    End;

    Try
      cdsItens.Filter   := 'TEMSLD = FALSE AND QTDITE <= 0';
      cdsItens.Filtered := True;
      While Not cdsItens.IsEmpty Do
        cdsItens.Delete;
    Finally
      cdsItens.Filter   := '';
      cdsItens.Filtered := False;
    End;
  Finally
    dicSaldos.Free;
    cdsItens.First;
  End;
end;

Procedure TSolicitacaoTE.pCriaItens;
Begin
  cdsItens := TUniClientDataSet.Create(Application);

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITESUB';
    DataType := ftString;
    Size := 1;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODITE';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODGRU';
    DataType := ftString;
    Size := 6;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESCRI';
    DataType := ftString;
    Size := 70;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDITE';
    DataType := ftFloat;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;
    Size := 3;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMLOT';
    DataType := ftString;
    Size := VS_Size_NumLot;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUTINC';
    DataType := ftString;
    Size := 20;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TEMSLD';
    DataType := ftBoolean;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TRAVOU';
    DataType := ftBoolean;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'LOTABA';
    DataType := ftString;
    Size := 30;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'INFLOT';
    DataType := ftString;
    Size := 1;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SALLOC';
    DataType := ftFloat;
  End;

  With cdsItens.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SALOUT';
    DataType := ftFloat;
  End;

  if fCfgSis('ABSPML', varBoolean) then
  begin
    qryEmpresas.First;
    while not qryEmpresas.Eof do
    begin
      With cdsItens.FieldDefs.AddFieldDef Do
      Begin
        Name := 'QTD' + qryEmpresas.FieldByName('EMP_CODEMP').AsString;
        DataType := ftFloat;
      End;

      With cdsItens.FieldDefs.AddFieldDef Do
      Begin
        Name := 'LOT' + qryEmpresas.FieldByName('EMP_CODEMP').AsString;;
        DataType := ftString;
        Size := 30;
      End;
      qryEmpresas.Next;
    end;

    With cdsItens.FieldDefs.AddFieldDef Do
    Begin
      Name := 'TOTQTD';
      DataType := ftFloat;
    End;
  end;

  cdsItens.CreateDataSet;
  cdsItens.Open;
End;

Procedure TSolicitacaoTE.pCriaUsado;
Begin

  cdsUsado := TUniClientDataSet.Create(Application);

  With cdsUsado.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODITE';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With cdsUsado.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;
    Size := 3;
  End;

  With cdsUsado.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMLOT';
    DataType := ftString;
    Size := VS_Size_NumLot;
  End;

  With cdsUsado.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDITE';
    DataType := ftFloat;
  End;

  cdsUsado.CreateDataSet;
  cdsUsado.Open;

End;

procedure TSolicitacaoTE.pRetornaInfMultiLoja(intAutInc: Integer;
  var arrCodEmp: TArrCodEmpML; var arrQtdIte: TArrQtdIteML;
  var arrLotAba: TArrLotAbaML);
begin
  SetLength(arrCodEmp, 0);
  SetLength(arrQtdIte, 0);
  SetLength(arrLotAba, 0);

  With cdsItens Do
  Begin
    If Locate('AUTINC', IntToStr(intAutInc) , []) Then
    Begin
      qryEmpresas.First;
      while not qryEmpresas.Eof do
      begin
        if FieldByName('QTD'+qryEmpresas.FieldByName('EMP_CODEMP').AsString).AsFloat > 0 then
        begin
          SetLength(arrCodEmp, Length(arrCodEmp) + 1);
          SetLength(arrQtdIte, Length(arrQtdIte) + 1);
          SetLength(arrLotAba, Length(arrLotAba) + 1);

          arrCodEmp[Length(arrCodEmp) - 1] := qryEmpresas.FieldByName('EMP_CODEMP').AsString;
          arrQtdIte[Length(arrQtdIte) - 1] := FieldByName('QTD'+qryEmpresas.FieldByName('EMP_CODEMP').AsString).AsFloat;
          arrLotAba[Length(arrLotAba) - 1] := FieldByName('LOT'+qryEmpresas.FieldByName('EMP_CODEMP').AsString).AsString;
        end;
        qryEmpresas.Next;
      end;
    End;
  End;
end;

Constructor TSolicitacaoTE.Create;
Begin

  FCarregandoSubItensDaEstrutura       := False;
  blnExibeMensagemTransferenciaEstoque := False;

  stlLojas := TStringList.Create;
  stlLojas.Sorted := True;
  stlLojas.Duplicates := dupIgnore;

  if fCfgSis('ABSPML', varBoolean) then
  begin
    qryEmpresas := fCriaQuery;
    qryEmpresas.Close;
    qryEmpresas.SQL.Clear;
    qryEmpresas.SQL.Add('SELECT EMP_CODEMP');
    qryEmpresas.SQL.Add('FROM CADEMP');
    qryEmpresas.SQL.Add('WHERE LOCATE(EMP_CODEMP, '+QuotedStr(strEmpAcessoUsuarioLogado)+') > 0');
    qryEmpresas.Open;
  end;

  pCriaItens;
  pCriaUsado;
End;

Destructor TSolicitacaoTE.Destroy;
Begin
  cdsItens.EmptyDataSet;
  cdsItens.Close;

  cdsUsado.EmptyDataSet;
  cdsUsado.Close;

  stlLojas.Clear;

  FreeAndNil(stlLojas);
  FreeAndNil(cdsItens);
  FreeAndNil(cdsUsado);

  if fCfgSis('ABSPML', varBoolean) and Assigned(qryEmpresas) then
    FreeAndNil(qryEmpresas);

  inherited;
End;

Function TSolicitacaoTE.fIncluiItem(strCodIte, strCodGru, strDescri, strNumLot: String;
  intAutInc: Integer; fltQtdIte: Double;
  blnTemSld: Boolean = False): Boolean;
Begin
  Try

    With cdsItens Do
    Begin

      If (Locate('AUTINC', IntToStr(intAutInc), [])) And (Not FCarregandoSubItensDaEstrutura) Then
        Edit
      Else
        Append;

      FieldByName('CODITE').AsString := strCodIte;
      FieldByName('CODGRU').AsString := strCodGru;
      FieldByName('DESCRI').AsString := strDescri;
      FieldByName('NUMLOT').AsString := strNumLot;
      FieldByName('AUTINC').AsInteger:= intAutInc;
      FieldByName('QTDITE').AsFloat  := fltQtdIte;
      FieldByName('TEMSLD').AsBoolean:= blnTemSld;
      FieldByName('INFLOT').AsString := IIF(fEmptyStr(strNumLot), 'N', 'S');
      FieldByName('SALLOC').AsFloat  := fRetornaSaldoDisponivel(strCodIte, False, True, strNumLot);
      FieldByName('SALOUT').AsFloat  := fRetornaSaldoOutrasLojas(strCodIte);

      FieldByName('ITESUB').AsString := IIF(FCarregandoSubItensDaEstrutura, 'S', 'N');

      if fCfgSis('ABSPML', varBoolean) then
      begin
        qryEmpresas.First;
        while not qryEmpresas.Eof do
        begin
          FieldByName('QTD'+qryEmpresas.FieldByName('EMP_CODEMP').AsString).Value := Null;
          FieldByName('LOT'+qryEmpresas.FieldByName('EMP_CODEMP').AsString).Value := Null;

          qryEmpresas.Next;
        end;
        FieldByName('TOTQTD').AsFloat  := 0;
      end;

      Post;
    End;

    Result := TRUE;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TSolicitacaoTE.fIncluiItem]');
    End;
  End;

End;

Function TSolicitacaoTE.fInformaLojas: Boolean;
  Var
    frmSolicitacaoLojas: TfrmSolicitacaoLojas;
Begin
  Try
    Result := TRUE;
    blnReq := False;

    If (fTemItensSemSaldo) Then
    Begin
      pCriarFormularios(TfrmSolicitacaoLojas, frmSolicitacaoLojas);
      If Assigned(frmSolicitacaoLojas) Then
      With frmSolicitacaoLojas Do
      Begin
        (cdsItens.FieldByName('QTDITE') As TFloatField).DisplayFormat := '#,##0.00';
        (cdsItens.FieldByName('SALLOC') As TFloatField).DisplayFormat := '#,##0.000';
        (cdsItens.FieldByName('SALOUT') As TFloatField).DisplayFormat := '#,##0.000';

        objSoliTE := Self;

        If fCfgSis('SOLAJU', varBoolean) Then
          pAjustarQuantidadeSolicitada;

        cdsItens.IndexFieldNames := 'CODITE';
        cdsItens.BeforePost  := pItensLojaBeforePost;
        cdsItens.BeforeEdit  := pItensLojaBeforeEdit;
        cdsItens.AfterInsert := pItensLojaAfterInsert;
        cdsItens.AfterScroll := pItensLojaAfterScroll;
        cdsItens.First;

        dtsItens.DataSet := cdsItens;

        If (Not cdsItens.IsEmpty) Then
        Begin
          If (Self.blnExibeMensagemTransferenciaEstoque) Then
          Begin          
            fMensagem('','Há produtos que não possuem saldo suficiente para este documento!' + #13#10 +
                         'Será exibida a tela para Transferência de Estoque.', ['&Ok']);

          End;

          Result := ShowModal = mrOk;
          blnReq := Result And fEhAbstecimentoPorOutraLoja;
        End;

        cdsItens.BeforePost  := nil;
        cdsItens.BeforeEdit  := nil;
        cdsItens.AfterInsert := nil;
        cdsItens.AfterScroll := nil;
        pFreeAndNil(frmSolicitacaoLojas);
      End;
    End
    Else
    Begin
      // Esvazia a tabela, pois nesse ponto só ficaram itens com saldo disponível!
      cdsItens.EmptyDataSet;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fInformaLojas]');
    End;
  End;

End;

function TSolicitacaoTE.fInformaMultiLojas: Boolean;
Var
  untSolicitacaoMultiLojas: TfrmSolicitacaoMultiLojas;
Begin
  Try
    Result := TRUE;
    blnReq := False;

    If (fTemItensSemSaldo) Then
    Begin
      pCriarFormularios(TfrmSolicitacaoMultiLojas, untSolicitacaoMultiLojas);
      If Assigned(untSolicitacaoMultiLojas) Then
      With untSolicitacaoMultiLojas Do
      Begin
        qryEmpresas.First;
        while not qryEmpresas.Eof do
        begin
         (cdsItens.FieldByName('QTD' + qryEmpresas.FieldByName('EMP_CODEMP').AsString) As TFloatField).DisplayFormat := '#,##0.00';
          qryEmpresas.Next;
        end;

        (cdsItens.FieldByName('TOTQTD') As TFloatField).DisplayFormat := '#,##0.000';
        (cdsItens.FieldByName('SALLOC') As TFloatField).DisplayFormat := '#,##0.000';
        (cdsItens.FieldByName('SALOUT') As TFloatField).DisplayFormat := '#,##0.000';

        objSoliTE := Self;

        If fCfgSis('SOLAJU', varBoolean) Then
          pAjustarQuantidadeSolicitada;

        cdsItens.IndexFieldNames := 'CODITE';
        cdsItens.BeforePost  := pItensLojaBeforePost;
        cdsItens.BeforeEdit  := pItensLojaBeforeEdit;
        cdsItens.AfterInsert := pItensLojaAfterInsert;
        cdsItens.AfterScroll := pItensLojaAfterScroll;
        cdsItens.First;

        dtsItens.DataSet := cdsItens;

        If (Not cdsItens.IsEmpty) Then
        Begin
          If (Self.blnExibeMensagemTransferenciaEstoque) Then
          Begin          
            fMensagem('','Há produtos que não possuem saldo suficiente para este documento!' + #13#10 +
                         'Será exibida a tela para Transferência de Estoque.', ['&Ok']);

          End;

          Result := ShowModal = mrOk;
          blnReq := Result And fEhAbstecimentoPorOutraLoja;
        End;

        cdsItens.BeforePost  := nil;
        cdsItens.BeforeEdit  := nil;
        cdsItens.AfterInsert := nil;
        cdsItens.AfterScroll := nil;
        pFreeAndNil(untSolicitacaoMultiLojas);
      End;
    End
    Else
    Begin
      // Esvazia a tabela, pois nesse ponto só ficaram itens com saldo disponível!
      cdsItens.EmptyDataSet;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fInformaMultiLojas]');
    End;
  End;

End;

Function TSolicitacaoTE.fJaUtilizado(strCodIte, strCodEmp, strNumLot: String): Double;
Begin
  With cdsUsado Do
  Begin
    If Not Locate('CODITE;CODEMP;NUMLOT;', VarArrayOf([strCodIte, strCodEmp, strNumLot]), []) Then
    Begin
      Insert;
      FieldByName('CODEMP').AsString := strCodEmp;
      FieldByName('CODITE').AsString := strCodIte;
      FieldByName('NUMLOT').AsString := strNumLot;
      FieldByName('QTDITE').AsFloat  := 0;
      Post;
    End;

    Result := FieldByName('QTDITE').AsFloat;
  End;
End;

function TSolicitacaoTE.fRetornaSaldoOutrasLojas(strCodIte: String): Double;
var
  qryAux: TUniQuery;
  fltSaldoTotal: Double;
begin
  qryAux := fCriaQuery();
  Try
    With qryAux Do
    Begin
      SQL.Text := 'SELECT EMP_CODEMP FROM CADEMP WHERE EMP_CODEMP <> :CODEMP';
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      First;
      fltSaldoTotal := 0.0;
      While Not Eof Do
      Begin
        fltSaldoTotal := fltSaldoTotal + fRetornaSaldoDisponivel(strCodIte,
                                                                 False,
                                                                 True,
                                                                 '',
                                                                 True,
                                                                 FieldByName('EMP_CODEMP').AsString);

        Next;
      End;

      Result := fltSaldoTotal;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TSolicitacaoTE.fTemItensSemSaldo: Boolean;
begin
  cdsItens.Filter := 'TEMSLD = FALSE';
  cdsItens.Filtered := True;
  Result := (cdsItens.RecordCount > 0);
  cdsItens.Filter := '';
  cdsItens.Filtered := False;
end;

function TSolicitacaoTE.fEhAbstecimentoPorOutraLoja: Boolean;
begin
  cdsItens.Filter := 'CODEMP <> ' + QuotedStr(VS_strCodEmp);
  cdsItens.Filtered := True;
  Result := (cdsItens.RecordCount > 0);
  cdsItens.Filter := '';
  cdsItens.Filtered := False;
end;

function TSolicitacaoTE.fTemSolicitacaoPropiaLojaSemSaldo: Boolean;
begin
  cdsItens.Filter := '(CODEMP = ' + QuotedStr(VS_strCodEmp) +') AND (TEMSLD = FALSE)';
  cdsItens.Filtered := True;
  Result := (cdsItens.RecordCount > 0);
  cdsItens.Filter := '';
  cdsItens.Filtered := False;
end;

function TSolicitacaoTE.getCarregandoSubItensDaEstrutura: Boolean;
begin
  Result := FCarregandoSubItensDaEstrutura;
end;

Procedure TSolicitacaoTE.pSomaUtilizado(strCodIte, strCodEmp, strNumLot: String; fltQtdIte: Double; blnSoma: Boolean);
Begin
  If (Not fEmptyStr(strCodIte)) And (Not fEmptyStr(strCodEmp)) And blnSoma Then
  With cdsUsado Do
  Begin
    fJaUtilizado(strCodIte, strCodEmp, strNumLot);

    If Locate('CODITE;CODEMP;NUMLOT', VarArrayOf([strCodIte, strCodEmp, strNumLot]), []) Then
    Begin
      Edit;
      FieldByName('QTDITE').AsFloat := FieldByName('QTDITE').AsFloat + fltQtdIte;
      Post;
    End;

  End;

End;

Procedure TSolicitacaoTE.pSubtUtilizado(strCodIte, strCodEmp, strNumLot: String; fltQtdIte: Double; blnSubt: Boolean);
Begin
  If (Not fEmptyStr(strCodIte)) And (Not fEmptyStr(strCodEmp)) And blnSubt Then
  With cdsUsado Do
  Begin
    fJaUtilizado(strCodIte, strCodEmp, strNumLot);

    If Locate('CODITE;CODEMP;NUMLOT', VarArrayOf([strCodIte, strCodEmp, strNumLot]), []) Then
    Begin
      Edit;
      FieldByName('QTDITE').AsFloat := FieldByName('QTDITE').AsFloat - fltQtdIte;
      Post;
    End;

  End;

End;

procedure TSolicitacaoTE.setCarregandoSubItensDaEstrutura(AValue: Boolean);
begin
  FCarregandoSubItensDaEstrutura := AValue;
end;

Function TSolicitacaoTE.fGetEmpresa(intAutInc: Integer): String;
  Var
    intIndice: Integer;
Begin
  Result := '';
  With cdsItens Do
  Begin

    If Locate('AUTINC', IntToStr(intAutInc) , []) Then
    Begin
      Result := FieldByName('CODEMP').AsString;

      If (Not stlLojas.Find(Result, intIndice)) And (Not fEmptyStr(Result)) Then
        stlLojas.Add(Result);
    End;

  End;
End;

function TSolicitacaoTE.fGetLote(intAutInc: Integer): String;
Begin
  Result := '';

  With cdsItens Do
  Begin
    If Locate('AUTINC', IntToStr(intAutInc) , []) Then
      Result := FieldByName('LOTABA').AsString;
  End;
end;

function TSolicitacaoTE.fGetQtdSolicitada(intAutInc: Integer): Double;
begin
  Result := 0;
  With cdsItens Do
  Begin
    If Locate('AUTINC', IntToStr(intAutInc) , []) Then
      Result := FieldByName('QTDITE').AsFloat;
  End;
end;

end.
