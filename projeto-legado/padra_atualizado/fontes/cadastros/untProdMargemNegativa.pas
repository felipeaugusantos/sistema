unit untProdMargemNegativa;

interface

uses StrUtils, SysUtils, Db, Classes, Forms, Variants, Controls, untTypesSistema,
     untZClient, untMsgLiberacao;

Type
  TRotinaAltPreco = (rotCadProdutos,
                     rotAltPrecoGlobal,
                     rotAltPrecoIndividual,
                     rotEfetivacaoLotePrecos,
                     rotAltGlobalCatalogo,
                     rotEntradaMercadorias,
                     rotAlteracaoEfetivacaoPrecos);

  TProdMargemNegativa = Class(TComponent)
  Private

    FCadIte,
    FIteger: TDataSet;

    Function fMontaCabec(objLinha : TLinhaMsgLibera): String;
    Function fMontaPrecos(objLinha : TLinhaMsgLibera): String;
    Function fMontaFiltro: String;
    Function fTemMargemNegativa: Boolean;

  Public
    strSufixoCampo: String;
    rotRotina: TRotinaAltPreco;
    blnFiltrar: Boolean;

    Constructor Create(Owner: TComponent; dtsCadIte, dtsIteger: TDataSet); Reintroduce;

    Function fLiberaMargem: Boolean;

    Class Function fLiberaMargemNegativa(dtsCadIte, dtsIteger: TDataSet;
                                         rotRotina: TRotinaAltPreco): Boolean;

    Class Function fCriaDadosItem(strCodIte: String): TZClient;

  End;

implementation

uses
  untConstantes,   untFuncoesSimples,
  untILiberacao, untLiberacaoFactory;

constructor TProdMargemNegativa.Create(Owner: TComponent; dtsCadIte, dtsIteger: TDataSet);
begin
  Inherited Create(Owner);

  strSufixoCampo := '';

  FCadIte  := dtsCadIte;
  FIteger  := dtsIteger;
End;

Class Function TProdMargemNegativa.fLiberaMargemNegativa(dtsCadIte, dtsIteger: TDataSet;
                                                         rotRotina: TRotinaAltPreco): Boolean;
  Var
    objProMar: TProdMargemNegativa;
    strFilter   : String;
    blnFiltered,
    blnFiltrar: Boolean;
Begin
  With dtsIteger Do
  Begin
    strFilter   := Filter;
    blnFiltered := Filtered;
  End;

  blnFiltrar := rotRotina In [rotAltPrecoGlobal, rotAltPrecoIndividual];

  Try
    objProMar := TProdMargemNegativa.Create(Nil, dtsCadIte, dtsIteger);

    objProMar.rotRotina := rotRotina;

    objProMar.blnFiltrar := blnFiltrar;

    If rotRotina In [rotAltPrecoGlobal, rotAltPrecoIndividual] Then
      objProMar.strSufixoCampo := '_NOV';

    Result := objProMar.fLiberaMargem;

    FreeAndNil(objProMar);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TProdMargemNegativa.fLiberaMargemNegativa]');
    End;
  End;

  With dtsIteger Do
  If blnFiltrar Then
  Begin
    Filter   := strFilter;
    Filtered := blnFiltered;
    EnableControls;
  End;

End;

Function TProdMargemNegativa.fMontaCabec(objLinha : TLinhaMsgLibera): String;
  Var
    intContador: Integer;
    strTitMar: String;
Begin
  Result := '';

  If Pos(fCfgSis('MARMKP') , '1_5_') = 0 Then
    strTitMar := '   MKP '
  Else
    strTitMar := '  MARG ';

  For intContador := 1 To Length(VS_strTabVen) Do
  begin
    If VS_strTabVen[intContador] = 'S' Then
    begin
      objLinha.pAddColuna(''  , strTitMar   + IntToStr(intContador) , 8  , alDireita , teAutcom);
      objLinha.pAddColuna(''  , 'PR.VENDA ' + IntToStr(intContador) , 12  , alDireita , teAutcom);
    end;
  end;
End;

Function TProdMargemNegativa.fMontaPrecos(objLinha : TLinhaMsgLibera): String;
  Var
    intContador: Integer;
    strTitMar : String;
Begin
  Result := '';

  If Pos(fCfgSis('MARMKP') , '1_5_') = 0 Then
    strTitMar := '   MKP '
  Else
    strTitMar := '  MARG ';

  With FIteger Do
  begin
    For intContador := 1 To Length(VS_strTabVen) Do
    begin
      If VS_strTabVen[intContador] = 'S' Then
      begin
        objLinha.pAddColuna(strTitMar   + IntToStr(intContador) , FormatFloat('#,##0.00', FieldByName('ITE_MARBR' + IntToStr(intContador) + strSufixoCampo).AsFloat) + '%' , 8  , alDireita);
        objLinha.pAddColuna('PR.VENDA ' + IntToStr(intContador) , FormatFloat('#,##0.00', FieldByName('ITE_PREVE' + IntToStr(intContador) + strSufixoCampo).AsFloat)       , 12 , alDireita);
      end;
    end;
  end;
End;

Function TProdMargemNegativa.fMontaFiltro: String;
  Var
    intContador: Integer;
Begin
  Result := '';

  For intContador := 1 To Length(VS_strTabVen) Do
    If VS_strTabVen[intContador] = 'S' Then
    Begin

      If Not fEmptyStr(Result) Then
        Result := Result + ' OR ';

      Result := Result + ' ITE_MARBR' + IntToStr(intContador) + strSufixoCampo + ' < 0 ';

      If rotRotina = rotAltPrecoGlobal Then
        Result := '(' + Result + ') AND ITE_MARDES = ' + QuotedStr('M');
    End;
End;

Function TProdMargemNegativa.fTemMargemNegativa: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  With FIteger Do
  For intContador := 1 To Length(VS_strTabVen) Do
    If (VS_strTabVen[intContador] = 'S') And (FieldByName('ITE_MARBR' + IntToStr(intContador) + strSufixoCampo).AsFloat < 0) Then
    Begin
      Result := True;
      Exit;
    End;
End;

Function TProdMargemNegativa.fLiberaMargem: Boolean;
{
.-------------------------------------------------------------------------------------------------------------------------------------------.
| Liberação de produtos com Margem negativa                                                                                                 |
|-------------------------------------------------------------------------------------------------------------------------------------------|
| COD   | DESCRICAO                                             | UN |     PR.CUSTO | MARG 1   |   PR.VENDA 1 |...| MARG 7   |   PR.VENDA 7 |
|-------------------------------------------------------------------------------------------------------------------------------------------|
| 99999 | XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX | XX | 9.999.999,99 | -999,99% | 9.999.999,99 |   | -999,99% | 9.999.999,99 |
|-------------------------------------------------------------------------------------------------------------------------------------------|
          12345678901234567890123456789012345678901234567890123
}

  Var
    strSigUni: String;
    blnTemSigUni: Boolean;
    objLiberacao : ILiberacao;
    objTabela : TRegistroMsgLiberaTabela;
  	objLinha  : TLinhaMsgLibera;
Begin
  Result := True;

  With FIteger Do
  Begin
    blnTemSigUni := FindField('ITE_SIGUNI' + strSufixoCampo) <> Nil;

    If blnFiltrar Then
    Begin
      DisableControls;
      Filter   := fMontaFiltro;
      Filtered := True;
    End;

    If (rotRotina In [rotAltGlobalCatalogo, rotAlteracaoEfetivacaoPrecos]) Or (blnFiltrar And (Not IsEmpty)) Or ((Not blnFiltrar) And fTemMargemNegativa) then
    Begin
      objLiberacao := TLiberacaoFactory.fGetLiberacao;
      objLiberacao.Clear;

      objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE PRODUTOS COM MARGEM NEGATIVA');

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cod.'                            , 7  , alCentro   , teAutcom);
      If (rotRotina = rotAltGlobalCatalogo) Then
       objLinha.pAddColuna('' , '(Código de Fábrica) + Descrição' , 55 , alEsquerda , teAutcom)
      else
       objLinha.pAddColuna('' , 'Descrição'                       , 55 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'UNID'                            , 4  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'PR.CUSTO '                       , 15 , alDireita  , teAutcom);
      fMontaCabec(objLinha);
      objTabela.lstLinhas.Add(objLinha);

      If (rotRotina <> rotCadProdutos) Then
        First;

      While Not Eof do
      Begin
        If blnTemSigUni And (Not fEmptyStr(FieldByName('ITE_SIGUNI' + strSufixoCampo).AsString)) Then
          strSigUni := FieldByName('ITE_SIGUNI' + strSufixoCampo).AsString
        Else
          strSigUni := fRetSiglaUni(FCadIte.FieldByName('ITE_CODUNI' + strSufixoCampo).AsString);

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cod.'                             , FCadIte.FieldByName('ITE_CODITE').AsString                                  , 7  , alCentro);
        If (rotRotina = rotAltGlobalCatalogo) Then
         objLinha.pAddColuna('(Código de Fábrica) + Descrição' , FCadIte.FieldByName('ITE_DESITE').AsString                                  , 55 , alEsquerda)
        else
         objLinha.pAddColuna('Descrição'                       , FCadIte.FieldByName('ITE_DESITE').AsString                                  , 55 , alEsquerda);
        objLinha.pAddColuna('UNID'                             , strSigUni                                                                   , 4  , alCentro  );
        objLinha.pAddColuna('PR.CUSTO '                        , FormatFloat('#,##0.00', FieldByName('ITE_PRECUS' + strSufixoCampo).AsFloat) , 15 , alDireita );
        fMontaPrecos(objLinha);
        objTabela.lstLinhas.Add(objLinha);

        If rotRotina In [rotCadProdutos] Then
          Break;

        Next;
      End;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.strDirAce := 'PROMARNEG';
      objLiberacao.strMsgSen := 'Liberação de Produtos com Margem Negativa';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.intLargura := 1900;

      Result := objLiberacao.fLibera;
    End;

  End;

End;

Class Function TProdMargemNegativa.fCriaDadosItem(strCodIte: String): TZClient;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';

  strSQL := strSQL + '  I.ITE_CODITE, ';
  strSQL := strSQL + '  C.ITE_DESITE, ';
  strSQL := strSQL + '  C.ITE_CODUNI, ';
  strSQL := strSQL + '    UNI_SIGUNI AS ITE_SIGUNI, ';

  for intContador := 1 to 7 do
  Begin
    strSQL := strSQL + '  I.ITE_MARBR' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '  I.ITE_PREVE' + IntToStr(intContador) + ', ';
  End;

  strSQL := strSQL + '  I.ITE_PRECUS ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ITEGER I ';

  strSQL := strSQL + ' INNER JOIN CADITE C ON C.ITE_CODITE = I.ITE_CODITE ';

  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '       I.ITE_CODITE = :CODITE ';
  strSQL := strSQL + '   AND I.ITE_CODEMP = :CODEMP ';

  Result := TZClient.Create(Nil, strSQL);

  With Result.qryQuery Do
  Begin
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;
  End;

  Result.fAbreClient(True, 'TProdMargemNegativa.fCriaDadosItem');
End;

end.

