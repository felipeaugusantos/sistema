unit untFatorPreco;

interface

Uses
  Uni,
  SysUtils,
  ComCtrls,
  Forms,
  Classes,
  untPreAlt_Trigger,
  System.StrUtils;

Type
  TFatorPreco = Class(TObject)

  Private
    arrValFat: Array[2..7] Of Double;
    blnLeuFat: Boolean;
    intDecUni: Integer;
    strTabelasAtiva: string;

    blnInfMat: Boolean;
    arrPreVen,
    arrMarVen: Array[2..7] Of Double;
    FstlTabelasMarcadas: TStringList;

    Function fLeFatores: Boolean;
    procedure pAtualizaIteGer(blnResFor: Boolean; qryIteger: TUniQuery);

  Public
    Constructor Create; Reintroduce;
    function fTabelaAtiva(intTabela: Integer): Boolean;
    Function fCalculaPrecoVendaFator(fltPreVe1: Double; intTabPre: Integer): Double;
    Function fAlteraPrecos(prbProgresso: TProgressBar; stlTabelasMarcadas: TStringList): Boolean;
  End;

implementation

Uses
    untFuncoesSimples, untPreAlt;

Constructor TFatorPreco.Create;
Begin
  Inherited;
  intDecUni := fCfgSis('DECUNI', varInteger);
  blnInfMat := fCfgSis('INFMAT', varBoolean);

  blnLeuFat := fLeFatores;
End;

Function TFatorPreco.fLeFatores: Boolean;
  Var
    qryFatPre: TUniQuery;
    intIndice: Integer;
    Ativo: Char;
Begin
  Result := True;

  For intIndice := 2 To 7 Do
    arrValFat[intIndice] := 0;
  strTabelasAtiva := 'NNNNNNN';
  qryFatPre := fCriaQuery;
  With qryFatPre Do
  Begin
    SQL.Text := 'SELECT * FROM FATPRE WHERE FAT_CODEMP = :CODEMP';
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    For intIndice := 2 To 7 Do
    Begin
      If Not Locate('FAT_NUMFAT', intIndice, []) Then
      Begin
        pMensagemOk('Fator para a Tabela ' + IntToStr(intIndice) +
                    ' não encontrado!');
        Result := False;
        Break;
      End;
      If FieldByName('FAT_ATIVO_').AsString = 'S' Then
        Ativo := 'S'
      Else
        Ativo := 'N';

      strTabelasAtiva[intIndice] := Ativo;

      arrValFat[intIndice] := FieldByName('FAT_VALFAT').AsFloat;

    End;
  End;

  FreeAndNil(qryFatPre);
End;

Function TFatorPreco.fCalculaPrecoVendaFator(fltPreVe1: Double; intTabPre: Integer): Double;
Begin
  If strTabelasAtiva[intTabPre] = 'S' Then
    Result := fFormataFloat(fltPreVe1 * arrValFat[intTabPre], intDecUni)
  Else
    Result := fFormataFloat(fltPreVe1, intDecUni);
End;

Function TFatorPreco.fAlteraPrecos(prbProgresso: TProgressBar; stlTabelasMarcadas: TStringList): Boolean;
  Var
    qryIteger: TUniQuery;
    intIndice: Integer;
    strMARMKP,
    strPcmPro: String;
    strAgrupadorPreAlt: String;


  Procedure pAbreItens;
    Var
      intIndice: Integer;
  Begin
    With qryIteger, SQL Do
    Begin

      Clear;
      Add('SELECT ');
      Add('  ITE_CODFOR,');

      For intIndice := 1 To 7 Do
      Begin
        Add('  I.ITE_PREVE' + IntToStr(intIndice) + ',');
        Add('  I.ITE_MARBR' + IntToStr(intIndice) + ',');
        Add('  I.ITE_COMTB' + IntToStr(intIndice) + ',');
      End;

      Add('  I.ITE_DESOPE, ');
      Add('  I.ITE_IMPFED, ');
      Add('  I.ITE_ICMSAI, ');
      Add('  I.ITE_OUTVAL, ');
      Add('  I.ITE_PRECUS, ');
      Add('  I.ITE_PRECOM, ');
      Add('  I.AUTOINCREM, ');
      Add('  I.ITE_CODEMP, ');
      Add('  I.ITE_CODITE  ');

      Add('FROM');
      Add('  ITEGER I ');
      Add('  INNER JOIN CADITE C ON C.ITE_CODITE = I.ITE_CODITE ');

      Add('WHERE');
      Add('  I.ITE_CODEMP = :CODEMP ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

    End;
  End;

Begin
  Try
    FstlTabelasMarcadas := stlTabelasMarcadas;
    Result := False;

    If Not blnLeuFat Then
      Exit;

    strPcmPro := fCfgSis('PCMPRO');
    strMARMKP := fCfgSis('MARMKP');

    fStartTransaction;

    qryIteger := fCriaQuery;

    pPreAltDefineVariaveisAltPre(fNow, 'ALTERACAO DE FATORES DE PRECO', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

    pAbreItens;

    With qryIteger Do
    Begin
      Result := True;
      prbProgresso.Max := RecordCount;
      prbProgresso.Position := 0;
      prbProgresso.Visible  := True;

      First;

      While Not Eof Do
      Begin

        For intIndice := 0 To stlTabelasMarcadas.Count - 1 Do
        Begin
          arrPreVen[StrToInt(stlTabelasMarcadas[intIndice])] :=  fCalculaPrecoVendaFator(FieldByName('ITE_PREVE1').AsFloat, StrToInt(stlTabelasMarcadas[intIndice]));

          arrMarVen[StrToInt(stlTabelasMarcadas[intIndice])] :=  fCalculaPrecoVenda(2,
                                                                 FieldByName('ITE_PRECUS').AsFloat + FieldByName('ITE_OUTVAL').AsFloat,
                                                                 arrPreVen[StrToInt(stlTabelasMarcadas[intIndice])],
                                                                 0,
                                                                 FieldByName('ITE_ICMSAI').AsFloat,
                                                                 FieldByName('ITE_IMPFED').AsFloat,
                                                                 FieldByName('ITE_DESOPE').AsFloat,
                                                                 FieldByName('ITE_COMTB' + stlTabelasMarcadas[intIndice]).AsFloat,
                                                                 strMARMKP,
                                                                 strPcmPro,
                                                                 intDecUni);
        End;
        If VS_blnPreAltViaTrigger then
          Result := True;
        If (Not VS_blnPreAltViaTrigger) Then
          Result :=
          fGravaPreAlt(FieldByName('ITE_CODITE').AsString,
                       FieldByName('ITE_PRECUS').AsFloat,
                       FieldByName('ITE_PRECUS').AsFloat,
        
                       FieldByName('ITE_PREVE1').AsFloat,
                       FieldByName('ITE_PREVE1').AsFloat,
                       FieldByName('ITE_MARBR1').AsFloat,
                       FieldByName('ITE_MARBR1').AsFloat,

                       FieldByName('ITE_PREVE2').AsFloat,
                       arrPreVen[2],
                       FieldByName('ITE_MARBR2').AsFloat,
                       arrMarVen[2],

                       FieldByName('ITE_PREVE3').AsFloat,
                       arrPreVen[3],
                       FieldByName('ITE_MARBR3').AsFloat,
                       arrMarVen[3],

                       FieldByName('ITE_PREVE4').AsFloat,
                       arrPreVen[4],
                       FieldByName('ITE_MARBR4').AsFloat,
                       arrMarVen[4],

                       FieldByName('ITE_PREVE5').AsFloat,
                       arrPreVen[5],
                       FieldByName('ITE_MARBR5').AsFloat,
                       arrMarVen[5],

                       FieldByName('ITE_PREVE6').AsFloat,
                       arrPreVen[6],
                       FieldByName('ITE_MARBR6').AsFloat,
                       arrMarVen[6],

                       FieldByName('ITE_PREVE7').AsFloat,
                       arrPreVen[7],
                       FieldByName('ITE_MARBR7').AsFloat,
                       arrMarVen[7],

                       FieldByName('ITE_PRECOM').AsFloat,
                       FieldByName('ITE_PRECOM').AsFloat,

                       'ALTERACAO DE FATORES DE PRECO',

                       Nil,
                       '',
                       strLoginUsuarioLogado);

        If Not Result Then
          Break;

        pAtualizaIteGer(False, qryIteger);
        If blnInfMat And fEhEmpresaResponsavelFornecedor(qryIteger.FieldByName('ITE_CODFOR').AsString) Then
          pAtualizaIteGer(True, qryIteger);

        Next;

        prbProgresso.StepBy(1);

        Application.ProcessMessages;
      End; {While}

    End; {With}

    If Result Then
      fCommit
    Else
      fRollBack;
    strAgrupadorPreAlt := '';

    FreeAndNil(qryIteger);

    prbProgresso.Position := 0;
    prbProgresso.Visible  := False;

  Except
    On E: Exception Do
    Begin
      prbProgresso.Position := 0;
      prbProgresso.Visible  := False;
      Result := False;
      strAgrupadorPreAlt := '';
      fRollBack;
      pMensagensErro(E.Message, '[TFatorPreco.fAlteraPrecos]');
    End;
  End;

End;


procedure TFatorPreco.pAtualizaIteGer(blnResFor: Boolean; qryIteger: TUniQuery);
  Var
    strUPD: String;
    strEmpresas: String;
    qryUpdate : TUniQuery;
    intIndice: integer;
begin
  strEmpresas := fRetEmpresasUsamPrecoMatriz;

  qryUpdate := fCriaQuery();
  Try

    If (Not blnResFor) Or (blnResFor And fEhEmpresaResponsavelFornecedor(qryIteger.FieldByName('ITE_CODFOR').AsString)) Then
    Begin

      strUPD := '';
      strUPD := strUPD + 'UPDATE ';
      strUPD := strUPD + '  ITEGER ';
      strUPD := strUPD + 'SET ';

      For intIndice := 0 To FstlTabelasMarcadas.Count - 1 Do
      Begin

        strUPD := strUPD + '  ITE_MARBR' + FstlTabelasMarcadas[intIndice] + ' = :MARBR' + FstlTabelasMarcadas[intIndice] + ', ';
        If intIndice = FstlTabelasMarcadas.Count -1 then
          strUPD := strUPD + '  ITE_PREVE' + FstlTabelasMarcadas[intIndice] + ' = :PREVE' + FstlTabelasMarcadas[intIndice] + ' '
        Else
          strUPD := strUPD + '  ITE_PREVE' + FstlTabelasMarcadas[intIndice] + ' = :PREVE' + FstlTabelasMarcadas[intIndice] + ', ';
      End;

      strUPD := strUPD + 'WHERE ';
      strUPD := strUPD + '  ITE_CODITE = :CODITE AND ';

      If blnResFor Then
        strUPD := strUPD + '  LOCATE(ITE_CODEMP, :CODEMP) = 0 '
      Else
        strUPD := strUPD + '  LOCATE(ITE_CODEMP, :CODEMP) > 0 ';

      With qryUpdate Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strUPD);
        {*****************************************}
        {* DADOS PARA O FILTRO                   *}
        {**************************************MV*}
        ParamByName('CODITE').AsString := qryIteGer.FieldByName('ITE_CODITE').AsString;
        ParamByName('CODEMP').AsString := strEmpresas;

        For intIndice := 0 To FstlTabelasMarcadas.Count - 1 Do
        Begin
         ParamByName('PREVE' + FstlTabelasMarcadas[intIndice]).AsFloat := arrPreVen[StrToInt(FstlTabelasMarcadas[intIndice])];
         ParamByName('MARBR' + FstlTabelasMarcadas[intIndice]).AsFloat := arrMarVen[StrToInt(FstlTabelasMarcadas[intIndice])];
        End;


        ExecSQL;
        If blnResFor Then
          pRecalculaItensResponsavelFornecedor(strEmpresas, qryIteger.FieldByName('ITE_CODITE').AsString, blnResFor)
        Else
        Begin
          If blnInfMat Then
            pRecalculaItensResponsavelFornecedor(strEmpresas, qryIteger.FieldByName('ITE_CODITE').AsString, blnResFor);
        End;
      End;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function TFatorPreco.fTabelaAtiva(intTabela: Integer): Boolean;
begin
  Result := strTabelasAtiva[intTabela] = 'S';
end;



end.
