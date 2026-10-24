unit untEntEmbalagens;

interface

Uses
  Classes,
  Math,
  Uni,
  untZClient,
  Controls,
  Variants,
  SysUtils;

Type
  TEntEmbalagens = Class(TZClient)
    Private

      Function fSQLItens: String;
      Function fSQLItensConferidos(stlPedidos, stlEmpresas: TStringList): String;

    Public

      Function fVerificaEmbalagens(qryEntMer, qryItePed: TUniQuery): Boolean;
      Function fVerificaEmbalagensConferencia(stlPedidos, stlEmpresas: TStringList): Boolean;
      Function fConverteItemPedidoUnidadeVenda(strSeqPcd, strCodIte: String): Boolean;
      Function fConverteItensConferencia: Boolean;

      constructor Create(Owner: TComponent); Reintroduce;

      Destructor Destroy; override;

  End;

implementation

Uses
  untFuncoesSimples, untEntEmbalagensDiverg, Data.DB;
  
constructor TEntEmbalagens.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLItens);

  fAbreClient(True, 'TEntEmbalagens.Create');

  pFormataDecimal('EMBORI', fCfgSis('DEQTEM', varInteger));
  pFormataDecimal('EMBENT', fCfgSis('DEQTEM', varInteger));
  pFormataDecimal('QTDBAI', fCfgSis('DEQTEM', varInteger));
  pFormataDecimal('QTDENT', fCfgSis('DEQTEM', varInteger));
End;

Destructor TEntEmbalagens.Destroy;
Begin
  Inherited;

End;

Function TEntEmbalagens.fSQLItens: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   ITE_CODITE AS CODITE, ';
  Result := Result + '   ITE_DESITE AS DESITE, ';
  Result := Result + '   0.0000     AS EMBORI, ';
  Result := Result + '   0.0000     AS EMBENT, ';
  Result := Result + '   0.0000     AS QTDENT, ';
  Result := Result + '   0.0000     AS QTDBAI, ';
  Result := Result +  '  AUTOINCREM AS SEQPCD  ';
  Result := Result + ' FROM                    ';
  Result := Result + '   CADITE                ';
  Result := Result + ' WHERE FALSE             ';
End;

Function TEntEmbalagens.fVerificaEmbalagens(qryEntMer, qryItePed: TUniQuery): Boolean;
Begin
  Result := True;
  Self.EmptyDataSet;

  If Assigned(qryItePed) And qryItePed.Active Then
  Begin

    qryEntMer.DisableControls;
    qryEntMer.First;

    While Not qryEntMer.Eof Do
    Begin
      If (qryItePed.Locate('ENT_CODITE;ENT_SEQPCD', VarArrayOf([qryEntMer.FieldByName('ENT_CODITE').AsString,
                                                                qryEntMer.FieldByName('ENT_SEQPCD').AsString]), []) Or
          qryItePed.Locate('ENT_CODITE', qryEntMer.FieldByName('ENT_CODITE').AsString, [])) And

         (qryItePed.FieldByName('ENT_EMBPED').AsFloat <> 0) And
         (qryItePed.FieldByName('ENT_EMBPED').AsFloat <> 1) And

         (RoundTo(Frac((qryEntMer.FieldByName('ENT_EMBALA').AsFloat * qryEntMer.FieldByName('ENT_QTDITE').AsFloat) /
            qryItePed.FieldByName('ENT_EMBPED').AsFloat ), -3) <> 0) Then

      Begin
        Self.Insert;

        If qryEntMer.FieldByName('ENT_SEQPCD').AsString = qryItePed.FieldByName('ENT_SEQPCD').AsString Then
          Self.FieldByName('SEQPCD').AsString := qryItePed.FieldByName('ENT_SEQPCD').AsString;

        Self.FieldByName('CODITE').AsString := qryEntMer.FieldByName('ENT_CODITE').AsString;
        Self.FieldByName('DESITE').AsString := qryEntMer.FieldByName('ENT_DESITE').AsString;

        Self.FieldByName('EMBORI').AsFloat  := qryItePed.FieldByName('ENT_EMBPED').AsFloat;
        Self.FieldByName('EMBENT').AsFloat  := qryEntMer.FieldByName('ENT_EMBALA').AsFloat;
        Self.FieldByName('QTDENT').AsFloat  := qryEntMer.FieldByName('ENT_QTDITE').AsFloat;

        Self.FieldByName('QTDBAI').AsFloat  := qryEntMer.FieldByName('ENT_EMBALA').AsFloat *
                                               qryEntMer.FieldByName('ENT_QTDITE').AsFloat;

        Self.Post;
      End;

      qryEntMer.Next;
    End;

    qryEntMer.First;
    qryEntMer.EnableControls;
  End;

  If Not Self.IsEmpty Then
  Begin
    pCriarFormularios(TfrmEntEmbalagensDiverg, frmEntEmbalagensDiverg);
    frmEntEmbalagensDiverg.cxgItensView.DataController.DataSource := dtsSource;
    Result := frmEntEmbalagensDiverg.ShowModal = mrOk;
    pFreeAndNil(frmEntEmbalagensDiverg);
  End;
End;

Function TEntEmbalagens.fConverteItemPedidoUnidadeVenda(strSeqPcd, strCodIte: String): Boolean;
  Var
    qryUpdate: TUniQuery;
Begin
  Try
    Result := True;

    If Self.Locate('SEQPCD;CODITE', VarArrayOf([strSeqPcd, strCodIte]), []) Then
    Begin
      qryUpdate := fCriaQuery(Nil);
      With qryUpdate, SQL Do
      Begin
        Add('UPDATE PCMDET D                                       ');

        Add('INNER JOIN CADITE I ON I.ITE_CODITE = PCD_CODITE      ');
        Add(' SET  ');

        Add('   PCD_UNITAR = PCD_UNITAR / IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA), ');
        Add('   PCD_QTDITE = PCD_QTDITE * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA), ');
        Add('   PCD_QTDBAI = PCD_QTDBAI * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA), ');
        Add('   PCD_EMBALA = 1.0000,      ');
        Add('   PCD_CODUNI = I.ITE_CODUNI ');

        Add('WHERE                        ');
        Add('  PCD_CODITE   = :CODITE AND ');
        Add('  D.AUTOINCREM = :SEQPCD     ');

        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('SEQPCD').AsString := strSeqPcd;

        ExecSQL;

      End;
      FreeAndNil(qryUpdate);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntEmbalagens.fConverteItemPedidoUnidadeVenda]');
    End;
  End;

End;

Function TEntEmbalagens.fSQLItensConferidos(stlPedidos, stlEmpresas: TStringList): String;
  Var
    IntContador: Integer;
Begin
  Result := '';
  Result := Result + ' SELECT                     ';
  Result := Result + '   D.AUTOINCREM AS AUTINC,  ';

  If fCfgSis('CNVEMB') <> 'N' Then
    Result := Result + '  IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) AS EMBPED,  '
  Else
    Result := Result + '   1.0000 AS EMBPED,  ';

  Result := Result + '   PCD_DESITE   AS DESITE,  ';
  Result := Result + '   PCD_QTDCON   AS QTDCON,  ';
  Result := Result + '   PCD_CODITE   AS CODITE   ';
  Result := Result + ' FROM                       ';
  Result := Result + '   PCMDET D                 ';

  Result := Result + ' JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND ';
  Result := Result + '                PCG_ESPDOC = PCD_ESPDOC AND ';
  Result := Result + '                PCG_CODEMP = PCD_CODEMP     ';

  Result := Result + ' WHERE                        ';

  Result := Result + '   IFNULL(PCD_EMBALA, 0) <> 0 AND ';
  Result := Result + '   IFNULL(PCD_EMBALA, 0) <> 1 AND ';
  Result := Result + '   (ROUND(PCD_QTDCON / IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA), 2) - TRUNCATE(ROUND(PCD_QTDCON / IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA), 2), 0)) <> 0 AND '; // NAO É MULTIPLO DA EMBALAGEM

  Result := Result + '   PCD_QTDCON > 0 AND                         ';
  Result := Result + '   PCD_ESPDOC = "PD" AND                      ';

  Result := Result + '   PCD_NUMPED IN (' + stlPedidos.CommaText + ') AND ';

  Result := Result + '   (FALSE  ';

  For IntContador := 0 To stlPedidos.Count - 1 Do
    Result := Result + '  OR (PCG_NUMPED = ' + QuotedStr(stlPedidos[intContador]) + ' AND PCG_CODEMP = ' + QuotedStr(stlEmpresas[intContador]) + ') ';

  Result := Result + '   )  ';
End;

Function TEntEmbalagens.fVerificaEmbalagensConferencia(stlPedidos, stlEmpresas: TStringList): Boolean;
  Var
    qryEntMer: TUniQuery;
Begin
  Result := True;

  If fCfgSis('CNVEMB') = 'N' Then
    Exit;

  EmptyDataSet;

  qryEntMer          := fCriaQuery(Self);
  qryEntMer.SQL.Text := fSQLItensConferidos(stlPedidos, stlEmpresas);
  qryEntMer.Open;

  While Not qryEntMer.Eof Do
  Begin
    Self.Insert;

    Self.FieldByName('SEQPCD').AsString := qryEntMer.FieldByName('AUTINC').AsString;
    Self.FieldByName('CODITE').AsString := qryEntMer.FieldByName('CODITE').AsString;
    Self.FieldByName('DESITE').AsString := qryEntMer.FieldByName('DESITE').AsString;
    Self.FieldByName('EMBORI').AsFloat  := qryEntMer.FieldByName('EMBPED').AsFloat;
    Self.FieldByName('QTDBAI').AsFloat  := qryEntMer.FieldByName('QTDCON').AsFloat;

    Self.Post;

    qryEntMer.Next;
  End;

  If Not IsEmpty Then
  Begin
    pCriarFormularios(TfrmEntEmbalagensDiverg, frmEntEmbalagensDiverg);

    With frmEntEmbalagensDiverg Do
    Begin
      cxgItensEMBENT.Visible := False;
      cxgItensQTDENT.Visible := False;
      cxgItensView.DataController.DataSource := dtsSource;
    End;

    Result := frmEntEmbalagensDiverg.ShowModal = mrOk;
    pFreeAndNil(frmEntEmbalagensDiverg);
  End;

  FreeAndNil(qryEntMer);
End;

Function TEntEmbalagens.fConverteItensConferencia: Boolean;
Begin
  Try
    Result := True;

    If fCfgSis('CNVEMB') = 'N' Then
      Exit;

    First;
    While Not Eof Do
    Begin
      Result := fConverteItemPedidoUnidadeVenda(FieldByName('SEQPCD').AsString,
                                                FieldByName('CODITE').AsString);

      If Not Result Then
        Break;

      Next;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntEmbalagens.fConverteItensConferencia]');
    End;
  End;
End;

end.
