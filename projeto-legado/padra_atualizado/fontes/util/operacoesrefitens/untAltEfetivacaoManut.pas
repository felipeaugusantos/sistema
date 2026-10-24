unit untAltEfetivacaoManut;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, Controls, untTypesSistema,
     UniClientDataSet, UniDataSetProvider, untFuncoesSimples, untZClient,
     cxProgressBar, untConstantes, Math;

Type

  TAltEfetivacaoManut = Class(TZClient)
  Private
     FMarcar: Boolean;

     Function fSQLItens: String;

     Procedure pFiltraMargemNegativa;

     Function fMarcaItens(pgbProgresso: TcxProgressBar): Boolean;
     Function fApagaItens(pgbProgresso: TcxProgressBar): Boolean;

     Function fCalculaCustoRealPrg(cxProgresso: TCxProgressBar): Boolean;

     Function fCalculaCustoReal: Boolean;

     Procedure pBeforePost(dataSet: TDataset);

  Public

    intTabPre,
    intPreMar: Integer;

    blnAlteraPreco: Boolean;

    Constructor Create(Owner: TComponent); Reintroduce;

    Destructor  Destroy; Override;

    Procedure pMostraItens(dtaDtaPre: TDateTime);

    Procedure pMarcaDesmarca;

    Procedure pMarcaTodos(blnMarcar: Boolean);

    Function fApagaMarcados: Boolean;
    Function fConsultaItens: Boolean;

    Function fValidaMargemNegativa: Boolean;
  End;

implementation

Uses
  untProdMargemNegativa,
  untAltEfetivacaoSelec, untGravando;

constructor TAltEfetivacaoManut.Create(Owner: TComponent);
begin
  Inherited Create(Owner, fSQLItens);

  blnAlteraPreco := fCfgSis('ALTEFE', varBoolean);

  intTabPre := 0;
  intPreMar := 0;
end;

destructor TAltEfetivacaoManut.Destroy;
begin
  inherited Destroy;

end;

Function TAltEfetivacaoManut.fSQLItens: String;
Begin
  Result := '';
  Result := Result + ' SELECT            ';
  Result := Result + '   P.*,            ';
  Result := Result + '   UNI_SIGUNI,     ';
  Result := Result + '   DET_NUMDOC,     ';
  Result := Result + '   ITE_DESITE,     ';
  Result := Result + '   "N" AS MARCAD,  ';
  Result := Result + '   CAST(NULL AS DECIMAL(12,2)) AS CUSTO_REAL ';
  Result := Result + ' FROM              ';
  Result := Result + '   PREITE P        ';
  Result := Result + ' INNER JOIN CADITE ON ITE_CODITE = PRE_CODITE  ';

  Result := Result + ' INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI  ';

  Result := Result + ' LEFT JOIN MOVDET D ON D.AUTOINCREM = P.PRE_SEQDET ';

  Result := Result + ' WHERE          ';
  Result := Result + '   PRE_CODEMP = :CODEMP AND ';
  Result := Result + '   PRE_DTAPRE = :DTAPRE     ';
  Result := Result + ' ORDER BY ITE_DESITE   ';
End;

Function TAltEfetivacaoManut.fCalculaCustoReal: Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  Result := TfrmGravando.fExecuta(fCalculaCustoRealPrg, frmGravando, 'Calculando Custo Real, aguarde...');
End;

Function TAltEfetivacaoManut.fCalculaCustoRealPrg(cxProgresso: TCxProgressBar): Boolean;
Begin
  DisableControls;

  Try
    cxProgresso.Properties.Max := RecordCount;

    First;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('CUSTO_REAL').AsFloat :=
        untfuncoesSimples.fCalculaCustoReal(FieldByName('PRE_PRECUS_NOV').AsFloat,
                                            FieldByName('PRE_ICMSAI').AsFloat,
                                            FieldByName('PRE_IMPFED').AsFloat,
                                            FieldByName('PRE_DESOPE').AsFloat,
                                            FieldByName('PRE_OUTVAL').AsFloat);
      Post;

      Next;

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    Result := True;

    First;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TAltEfetivacaoManut.fCalculaCustoRealPrg');
      Result := False;
    End;
  End;

  EnableControls;
End;

Function TAltEfetivacaoManut.fConsultaItens: Boolean;
Begin
  Result := fLeDados('TAltEfetivacaoManut.Create', True, 'Carregando produtos, aguarde...');

  If Result Then
  Begin
    pAlinhaCampoCentro('DET_NUMDOC');
    pAlinhaCampoCentro('PRE_CODITE');
    pAlinhaCampoCentro('PRE_PROPRI');

    Result := fCalculaCustoReal;

    BeforePost := pBeforePost;
  End;
End;

Procedure TAltEfetivacaoManut.pMostraItens(dtaDtaPre: TDateTime);
Begin
  With qryQuery Do
  Begin
    ParamByName('CODEMP').AsString   := VS_strCodEmp;
    ParamByName('DTAPRE').AsDateTime := dtaDtaPre;
  End;

  If Not fConsultaItens Then
    Exit;

  pCriarFormularios(TfrmAltEfetivacaoSelec, frmAltEfetivacaoSelec);
  With frmAltEfetivacaoSelec Do
  Begin
    cxgItensView.DataController.DataSource := Self.dtsSource;
    Caption := 'Manutenção dos Itens para Atualização de Preços - Agendado para ' + DateToStr(dtaDtaPre);
    objAltEfe := Self;
    ShowModal;
  End;
  FreeAndNil(frmAltEfetivacaoSelec);
End;

Procedure TAltEfetivacaoManut.pMarcaDesmarca;
Begin
  If IsEmpty Then
    Exit;

  Edit;

  If SameText(FieldByName('MARCAD').AsString, 'S') Then
    FieldByName('MARCAD').AsString := 'N'
  Else
    FieldByName('MARCAD').AsString := 'S';

  Post;
End;

Procedure TAltEfetivacaoManut.pBeforePost(dataSet: TDataset);
Begin

  If (intTabPre > 0) Then
    If (intPreMar > 0) Then
  Begin

    FieldByName(IIF(intPreMar = 1, 'PRE_PREVE', 'PRE_MARBR') + intTabPre.ToString + '_NOV').AsFloat :=
      fCalculaPrecoVenda(intPreMar,
                         FieldByName('PRE_PRECUS_NOV').AsFloat + FieldByName('PRE_OUTVAL').AsFloat,
                         FieldByName('PRE_PREVE' + intTabPre.ToString + '_NOV').AsFloat,
                         FieldByName('PRE_MARBR' + intTabPre.ToString + '_NOV').AsFloat,
                         FieldByName('PRE_ICMSAI').AsFloat,
                         FieldByName('PRE_IMPFED').AsFloat,
                         FieldByName('PRE_DESOPE').AsFloat,
                         FieldByName('PRE_COMTB' + intTabPre.ToString).AsFloat);

    intPreMar := 0;;
  End;

End;

Procedure TAltEfetivacaoManut.pMarcaTodos(blnMarcar: Boolean);
Begin
  Try
    FMarcar := blnMarcar;

    pCriarFormularios(TfrmGravando, frmGravando);
    With frmGravando Do
    Begin
      fExecutarAcao := fMarcaItens;
      lblGravando.Caption := 'Aguarde, selecionando itens...';
      ShowModal;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TAltEfetivacaoManut.pMarcaTodos]');
    End;
  End;

  FreeAndNil(frmGravando);
End;

Function TAltEfetivacaoManut.fMarcaItens(pgbProgresso: TcxProgressBar): Boolean;
Begin
  DisableControls;

  pgbProgresso.Position       := 0;
  pgbProgresso.Properties.Max := 0;
  Application.ProcessMessages;

  First;
  While Not Eof Do
  Begin
    Edit;

    If FMarcar Then
      FieldByName('MARCAD').AsString := 'S'
    Else
      FieldByName('MARCAD').AsString := 'N';

    Post;

    Next;

    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  EnableControls;

  Result := True;
End;

Function TAltEfetivacaoManut.fApagaMarcados: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    With frmGravando Do
    Begin
      fExecutarAcao := fApagaItens;
      lblGravando.Caption := 'Aguarde, excluindo agendamento...';
      ShowModal;

      Result := blnConfirma;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TAltEfetivacaoManut.fApagaMarcados]');
    End;
  End;

  FreeAndNil(frmGravando);
End;

Function TAltEfetivacaoManut.fApagaItens(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryPreIte: TUniQuery;
Begin
  Try
    qryPreIte := fCriaQuery(Self);
    With qryPreIte, SQL Do
    Begin
      Add('DELETE FROM PREITE WHERE AUTOINCREM = :AUTINC');
    End;

    DisableControls;

    fStartTransaction;

    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := 0;
    Application.ProcessMessages;

    Filter   := 'MARCAD = ' + QuotedStr('S');
    Filtered := True;

    First;
    While Not Eof Do
    Begin
      qryPreIte.Close;
      qryPreIte.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
      qryPreIte.ExecSQL;

      Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    fCommit;

    Result := True;

    FreeAndNil(qryPreIte);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[TAltEfetivacaoManut.fApagaItens]');
    End;
  End;

  Filtered := False;
  Filter   := '';
  EnableControls;
End;

Procedure TAltEfetivacaoManut.pFiltraMargemNegativa;
  Var
    intContador: Integer;
Begin
  For intContador := 1 To 7 Do
    If VS_strTabPrc[intContador] = 'S' Then
      If Self.Filter.IsEmpty Then
        Self.Filter := '(PRE_MARBR' + intContador.ToString + '_NOV < 0) '
      Else
        Self.Filter := Self.Filter + ' OR (PRE_MARBR' + intContador.ToString + '_NOV < 0) ';

  Self.Filtered := True;
End;

Function TAltEfetivacaoManut.fValidaMargemNegativa: Boolean;
  Var
    cdsMarNeg: TZClient;
    intContador: Integer;
Begin
  Result := True;

  If Not fCfgSis('MARNEG', varBoolean) Then
    Exit;

  Try
    Self.DisableControls;

    pFiltraMargemNegativa;

    If Self.RecordCount > 0 Then
    Begin
      cdsMarNeg := TProdMargemNegativa.fCriaDadosItem('');

      First;

      While Not Eof Do
      Begin
        cdsMarNeg.Append;

        cdsMarNeg.FieldByName('ITE_CODITE').AsString := FieldByName('PRE_CODITE').AsString;
        cdsMarNeg.FieldByName('ITE_DESITE').AsString := FieldByName('ITE_DESITE').AsString;
        cdsMarNeg.FieldByName('ITE_SIGUNI').AsString := FieldByName('UNI_SIGUNI').AsString;

        cdsMarNeg.FieldByName('ITE_PRECUS').AsFloat  := FieldByName('PRE_PRECUS_NOV').AsFloat;

        For intContador := 1 To Length(VS_strTabPrc) Do
        Begin
          cdsMarNeg.FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat := FieldByName('PRE_MARBR' + IntToStr(intContador) + '_NOV').AsFloat;
          cdsMarNeg.FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat := FieldByName('PRE_PREVE' + IntToStr(intContador) + '_NOV').AsFloat;
        End;

        cdsMarNeg.Post;

        Next;
      End;

      Result := TProdMargemNegativa.fLiberaMargemNegativa(cdsMarNeg, cdsMarNeg, rotAlteracaoEfetivacaoPrecos);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TAltEfetivacaoManut.fValidaMargemNegativa]');
    End;
  End;

  Self.Filtered := False;
  Self.Filter   := '';

  Self.EnableControls;

  FreeAndNil(cdsMarNeg);
End;

end.
