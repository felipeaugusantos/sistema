unit untAtualizaPreco;

interface

Uses
  Classes, StrUtils, SysUtils, Uni, Variants, UniClientDataSet,
  untFuncoesSimples, untZClient, untGravando, cxProgressBar, DB,
  Forms, untFuncoes, Math;

Const
  STR_TIPALT_MARGEM = 'Margem';
  STR_TIPALT_PRECO  = 'Preço';

Type
  TTipoMarcaca = (marInverte, marMarca, marDesmarca);

  TAtualizaPreco = Class(TZClient)
    FCotIte,
    FqryItem: TUniQuery;
    FcdsItensFornec,
    FcdsItens: TUniClientDataSet;
    FdicPrecoEscol: TDicionario;

    Function fRecalculaItens(pgbProgresso: TcxProgressBar): Boolean;
    Function fProgramaAtualizaPrecos(pgbProgresso: TcxProgressBar): Boolean;
    function fCalculaPrecoCusto: Double;
    Function fSQLItens(blnCodIte: Boolean): String;

    Function fSQLUpdateCotItem: String;

    Function fIncluiItens(pgbProgresso: TcxProgressBar): Boolean;
    function fValidaMargemDataSet(Dataset: TDataSet; fltValor: Double; strTabPrc: String): Boolean;

    Function fDesmarcaAtualizados(pgbProgresso: TcxProgressBar): Boolean;

    Procedure pDesmarcaCotacao;

    Procedure pAtualizaCotIte(strCodIte: String);

    Procedure pIncluiItem(strCodIte,
                          strPJAATU: String;
                          fltPreCot,
                          fltIpiEnt,
                          fltSubsti,
                          fltQtdIte: Double);

    Procedure pBeforePost(dtsDataSet: TDataSet);
    Procedure pMarcaItemCorrente(pmrTipMar: TTipoMarcaca);
    Procedure pIncluiPreIte(DataSet: TDataSet; dtaDtaAtu: TDateTime; strProPri: String);
    Procedure pProgramaAtualizaPrecos;
    Procedure pRecalculaPreco(blnMantemPrecoVenda: Boolean);

    Procedure pRecalculaPrecoTabela(intIndice: Integer; blnPreVen, blnMantemPrecoVenda: Boolean);

    Procedure pAtualizaItens(cdsItens,
                             cdsItensFornec: TUniClientDataSet;
                             dicPrecoEscol: TDicionario;
                             blnAtuIPI: Boolean);

  Public
    strMARMKP: String;
    MSG_VALIDACAO_MARGEM: String;

    dtaDtaAtu: TDateTime;

    blnAtuIPISub,
    FAtualizando,
    FPreVen: Boolean;
    blnDeuErr: Boolean;
    blnAtuPrePadrao: Boolean;

    Constructor Create(Owner: TComponent); Reintroduce;

    Function fTemAlteracaoManual: Boolean;

    Procedure pDesmarcaAtualizados;

    Procedure pMarcaItem;
    Procedure pMarcaTodos(pmrTipMar: TTipoMarcaca);

    Procedure pAtualizaPrecos;
    Procedure pRecalculaItens(blnPreVen: Boolean);
  End;

implementation

Uses
  untParCalculaPrecoCusto,
  untCadCotItens,
  untTConfiguracao,
  untDllOpeProd;

Constructor TAtualizaPreco.Create(Owner: TComponent);
Begin
  Inherited Create(Owner);

  MSG_VALIDACAO_MARGEM := 'A soma do ( ICMS Saída + Impostos Federais + ' +
                          'Despesas Operacionais + Margem Bruta ' +
                          IIF(fCfgSis('PCMPRO') = '2', '+ Comissão ', '') +
                          '  ) não pode ser superior a 100%.';

  FAtualizando := False;

  blnAtuPrePadrao := fCfgSis('ATPVMB', varBoolean);

  strMARMKP := fCfgSis('MARMKP');

  blnDeuErr := False;

  qryQuery.SQL.Text := fSQLItens(False);
  qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
  If Not fAbreClient(True, 'TAtualizaPreco.Create') Then
  Begin
    blnDeuErr := True;
    Exit;
  End;

  FCotIte := fCriaQuery(Self);
  FCotIte.SQL.Text := fSQLUpdateCotItem;

  FqryItem := fCriaQuery(Self);
  FqryItem.SQL.Text := fSQLItens(True);
End;

function TAtualizaPreco.fValidaMargemDataSet(Dataset: TDataSet; fltValor: Double; strTabPrc: String): Boolean;
begin
  With Dataset Do
  Result := Not ((fltValor +
                  FieldByName('ITE_COMTB' + strTabPrc).AsFloat +
                  FieldByName('ITE_ICMSAI').AsFloat +
                  FieldByName('ITE_IMPFED').AsFloat +
                  FieldByName('ITE_DESOPE').AsFloat) > 100);
End;

Procedure TAtualizaPreco.pBeforePost(dtsDataSet: TDataSet);
  Var
    intContador: Integer;
    blnRecalculaPreco: Boolean;
Begin
  With dtsDataSet Do
  Begin
    If (FieldByName('ATUPRE').AsString = 'S') Then
    Begin

      If (FieldByName('PRECOT').AsFloat <= 0) Then
      Begin
        FieldByName('ATUPRE').AsString := 'N';
        pMensagemOk('Preço de cotação zerado!');
        Abort;
      End;

    End;

    For intContador := 1 to Length(VS_strTabPrc) do
    Begin
      If VS_strTabPrc[intContador] = 'S' Then
      Begin
        If FieldByName('NOVVE' + IntToStr(intContador)).AsFloat <= 0 Then
        Begin
          pMensagemOk('O Preço de Venda ' + IntToStr(intContador) + ' deve ser maior ou igual a zero!');
          Cancel;
          Abort;
        End;

        If strMARMKP = '1' Then
        Begin
          If (FieldByName('NOVBR' + IntToStr(intContador)).AsFloat >= 100) Then
          Begin
            fMensagem('ATENÇÃO!', 'Margem não permitida: maior ou igual a 100!', ['&Ok']);
            Abort;
          End
          Else If Not fValidaMargemDataSet(dtsDataSet, FieldByName('NOVBR' + IntToStr(intContador)).AsFloat, IntToStr(intContador)) Then
          Begin
            fMensagem('', MSG_VALIDACAO_MARGEM, ['&Ok']);
            Abort;
          End;
        End;
      End;

      blnRecalculaPreco := RoundTo(Self.FieldByName('NOVBR' + IntToStr(intContador)).AsFloat, -2) <>
                           RoundTo(Self.FieldByName('DIGBR' + IntToStr(intContador)).AsFloat, -2);

      pRecalculaPrecoTabela(intContador,
                            blnRecalculaPreco,
                            True);
    End
  End;
End;

Function TAtualizaPreco.fSQLUpdateCotItem: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE COTITE SET COT_PJAATU = "S" ';
  strSQL := strSQL + ' WHERE AUTOINCREM = :AUTINC ';
  Result := strSQL;
End;

Function TAtualizaPreco.fSQLItens(blnCodIte: Boolean): String;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   C.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   C.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '   C.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   C.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '     UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '     ITE_LOCFIS AS LOCFIS, ';

  strSQL := strSQL + '     0.0000     AS PRECOT, ';
  strSQL := strSQL + '     ITE_PRECOM AS PRECOM, ';
  strSQL := strSQL + '     0.0000     AS DIFCOM, ';

  strSQL := strSQL + '     0.0000     AS NOVCUS, ';
  strSQL := strSQL + '     ITE_PRECUS AS PRECUS, ';
  strSQL := strSQL + '     0.0000     AS DIFCUS, ';

  strSQL := strSQL + '     0.0000     AS QTDITE, ';

  for intContador := 1 to Length(VS_strTabPrc) do
  Begin
    strSQL := strSQL + '     0.0000 AS NOVBR' + IntToStr(intContador) + ', ';

    strSQL := strSQL + '     ITE_MARBR' + IntToStr(intContador) + ' AS DIGBR' + IntToStr(intContador) + ', ';

    strSQL := strSQL + '     ITE_MARBR' + IntToStr(intContador) + ' AS MARBR' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '     0.0000 AS DIFBR' + IntToStr(intContador) + ', ';

    strSQL := strSQL + '     0.0000 AS NOVVE' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '     0.0000 AS NOVCA' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '     ITE_PREVE' + IntToStr(intContador) + ' AS PREVE' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '     0.0000 AS DIFER' + IntToStr(intContador) + ', ';

    strSQL := strSQL + '     ITE_COMTB' + IntToStr(intContador) + ', ';
  End;

  strSQL := strSQL + '     ITE_DESF01, ';
  strSQL := strSQL + '     ITE_DESF02, ';
  strSQL := strSQL + '     ITE_DESF03, ';
  strSQL := strSQL + '     ITE_DESF04, ';
  strSQL := strSQL + '     ITE_DESF05, ';
  strSQL := strSQL + '     ITE_DESF06, ';

  strSQL := strSQL + '     ITE_ICMENT, ';
  strSQL := strSQL + '     ITE_IPIENT, ';
  strSQL := strSQL + '     ITE_FREENT, ';
  strSQL := strSQL + '     ITE_ACRFIN, ';
  strSQL := strSQL + '     ITE_SUBSTI, ';
  strSQL := strSQL + '     ITE_VALFRE, ';
  strSQL := strSQL + '     ITE_DESADB, ';
  strSQL := strSQL + '     ITE_SUBFED, ';

  strSQL := strSQL + '     ITE_OUTVAL, ';
  strSQL := strSQL + '     ITE_ICMSAI, ';
  strSQL := strSQL + '     ITE_IMPFED, ';
  strSQL := strSQL + '     ITE_DESOPE, ';

  strSQL := strSQL + '     ITE_IPIENT AS IPICAD, ';
  strSQL := strSQL + '     ITE_SUBSTI AS SUBCAD, ';

  strSQL := strSQL + '     ITE_SALDOS       AS SALDOS, ';
  strSQL := strSQL + '     "N"              AS ATUPRE, ';
  strSQL := strSQL + '     "N"              AS PJAATU, ';

  strSQL := strSQL + ' "' + STR_TIPALT_MARGEM + '" AS TIPALT  ';

  strSQL := strSQL + ' FROM CADITE C ';
  strSQL := strSQL + ' INNER JOIN CADUNI   ON C.ITE_CODUNI = UNI_CODUNI ';
  strSQL := strSQL + ' INNER JOIN ITEGER I ON C.ITE_CODITE = I.ITE_CODITE AND I.ITE_CODEMP = :CODEMP ';
  strSQL := strSQL + ' WHERE ';

  if Not blnCodIte then
    strSQL := strSQL + ' FALSE '
  Else
    strSQL := strSQL + ' I.ITE_CODITE = :CODITE ';

  Result := strSQL;
End;

function TAtualizaPreco.fCalculaPrecoCusto: Double;
  Var
    cpcParams: TParCalculaPrecoCusto;
begin
  Try
    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

    With cpcParams Do
    Begin
      curPreCom := FieldByName('PRECOT').AsFloat;
      curDesF01 := FieldByName('ITE_DESF01').AsFloat;
      curDesF02 := FieldByName('ITE_DESF02').AsFloat;
      curDesF03 := FieldByName('ITE_DESF03').AsFloat;
      curDesF04 := FieldByName('ITE_DESF04').AsFloat;
      curDesF05 := FieldByName('ITE_DESF05').AsFloat;
      curDesF06 := FieldByName('ITE_DESF06').AsFloat;
      curICMSEnt:= FieldByName('ITE_ICMENT').AsFloat;
      curIPIEnt := FieldByName('ITE_IPIENT').AsFloat;
      curFrete  := FieldByName('ITE_FREENT').AsFloat;
      curAcrFin := FieldByName('ITE_ACRFIN').AsFloat;
      curSubsti := FieldByName('ITE_SUBSTI').AsFloat;
      curValFre := FieldByName('ITE_VALFRE').AsFloat;
      curDesAdb := FieldByName('ITE_DESADB').AsFloat;
      curSubFed := FieldByName('ITE_SUBFED').AsFloat;
    End;

    Result := cpcParams.fCalculaPrecoCusto(Nil);

  Finally
    FreeAndNil(cpcParams);
  End;
End;

Procedure TAtualizaPreco.pIncluiItem(strCodIte,
                                     strPJAATU: String;
                                     fltPreCot,
                                     fltIpiEnt,
                                     fltSubsti,
                                     fltQtdIte: Double);
  Var
    intIndice: Integer;
    blnAchou: Boolean;
Begin
  blnAchou := Self.Locate('CODITE', strCodIte, []);

  If (Not blnAchou) Or (FAtualizando) then
  Begin
    If fltPreCot = 0 Then
      Exit;

    With FqryItem Do
    Begin
      Close;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If Not IsEmpty then
      Begin

        If blnAchou Then
          Self.Edit
        Else
          Self.Insert;

        For intIndice := 0 to Fields.Count -1 do
          If Not SameText(Self.Fields[intIndice].FieldName, 'TIPALT') Then
            Self.Fields[intIndice].Value := Fields[intIndice].Value;

        If Self.State = dsInsert Then
        Begin
          If blnAtuPrePadrao Then
            Self.FieldByName('TIPALT').AsString := STR_TIPALT_PRECO
          Else
            Self.FieldByName('TIPALT').AsString := STR_TIPALT_MARGEM;
        End;

        Self.FieldByName('PJAATU').AsString := strPJAATU;

        Self.Post;
      End

      Else Exit;

    End;
  End Else
  Begin
    If fltPreCot = 0 Then
    Begin
      Self.Delete;
      Exit;
    End;
  End;

  Self.Edit;

  Self.FieldByName('PRECOT').AsFloat := fltPreCot;

  Self.FieldByName('DIFCOM').AsFloat := ((Self.FieldByName('PRECOT').AsFloat - Self.FieldByName('PRECOM').AsFloat) /
                                           Self.FieldByName('PRECOM').AsFloat) * 100;

  If (Self.FieldByName('ATUPRE').AsString = 'S') And
     (Self.FieldByName('PRECOT').AsFloat <= 0) Then
    Self.FieldByName('ATUPRE').AsString := 'N';

  If blnAtuIPISub Then
  Begin
    Self.FieldByName('ITE_IPIENT').AsFloat := fltIpiEnt;
    Self.FieldByName('ITE_SUBSTI').AsFloat := fltSubsti;
  End Else
  Begin
    Self.FieldByName('ITE_IPIENT').AsFloat := Self.FieldByName('IPICAD').AsFloat;
    Self.FieldByName('ITE_SUBSTI').AsFloat := Self.FieldByName('SUBCAD').AsFloat;
  End;

  Self.FieldByName('NOVCUS').AsFloat := fCalculaPrecoCusto;

  If Self.FieldByName('PRECUS').AsFloat > 0 then
    Self.FieldByName('DIFCUS').AsFloat := ((Self.FieldByName('NOVCUS').AsFloat - Self.FieldByName('PRECUS').AsFloat) /
                                             Self.FieldByName('PRECUS').AsFloat) * 100
  Else
    Self.FieldByName('DIFCUS').Clear;

  pRecalculaPreco(False);

  Self.Post;
End;

Procedure TAtualizaPreco.pRecalculaPrecoTabela(intIndice: Integer; blnPreVen, blnMantemPrecoVenda: Boolean);
Begin
  If Self.FieldByName('PRECOT').AsFloat > 0 then
  Begin

    If blnPreVen Then
    Begin
      If Not blnMantemPrecoVenda Then
        Self.FieldByName('NOVBR' + IntToStr(intIndice)).AsFloat := Self.FieldByName('MARBR' + IntToStr(intIndice)).AsFloat;

      Self.FieldByName('NOVVE' + IntToStr(intIndice)).AsFloat :=
                                  fCalculaPrecoVenda(1,
                                     FieldByName('NOVCUS').AsFloat + FieldByName('ITE_OUTVAL').AsFloat,
                                     0,
                                     FieldByName('NOVBR' + IntToStr(intIndice)).AsFloat,
                                     FieldByName('ITE_ICMSAI').AsFloat,
                                     FieldByName('ITE_IMPFED').AsFloat,
                                     FieldByName('ITE_DESOPE').AsFloat,
                                     FieldByName('ITE_COMTB' + IntToStr(intIndice)).AsFloat);

      Self.FieldByName('NOVCA' + IntToStr(intIndice)).AsFloat := Self.FieldByName('NOVVE' + IntToStr(intIndice)).AsFloat;

    End Else
    Begin
      If Not blnMantemPrecoVenda Then
      Begin
        Self.FieldByName('NOVVE' + IntToStr(intIndice)).AsFloat := Self.FieldByName('PREVE' + IntToStr(intIndice)).AsFloat;
        Self.FieldByName('NOVCA' + IntToStr(intIndice)).AsFloat := Self.FieldByName('NOVVE' + IntToStr(intIndice)).AsFloat;
      End;

      Self.FieldByName('NOVBR' + IntToStr(intIndice)).AsFloat :=
                                    fCalculaPrecoVenda(2,
                                       FieldByName('NOVCUS').AsFloat + FieldByName('ITE_OUTVAL').AsFloat,
                                       FieldByName('NOVVE' + IntToStr(intIndice)).AsFloat,
                                       0,
                                       FieldByName('ITE_ICMSAI').AsFloat,
                                       FieldByName('ITE_IMPFED').AsFloat,
                                       FieldByName('ITE_DESOPE').AsFloat,
                                       FieldByName('ITE_COMTB' + IntToStr(intIndice)).AsFloat);

    End;

    If Self.FieldByName('PREVE' + IntToStr(intIndice)).AsFloat > 0 Then
      Self.FieldByName('DIFER' + IntToStr(intIndice)).AsFloat := ((Self.FieldByName('NOVVE' + IntToStr(intIndice)).AsFloat -
                                                                   Self.FieldByName('PREVE' + IntToStr(intIndice)).AsFloat) /
                                                                     Self.FieldByName('PREVE' + IntToStr(intIndice)).AsFloat) * 100
    Else
      Self.FieldByName('DIFER' + IntToStr(intIndice)).Clear;

    Self.FieldByName('DIFBR' + IntToStr(intIndice)).AsFloat := (Self.FieldByName('NOVBR' + IntToStr(intIndice)).AsFloat -
                                                                   Self.FieldByName('MARBR' + IntToStr(intIndice)).AsFloat);

    Self.FieldByName('DIGBR' + IntToStr(intIndice)).AsFloat := Self.FieldByName('NOVBR' + IntToStr(intIndice)).AsFloat;
  End;
End;

Procedure TAtualizaPreco.pRecalculaPreco(blnMantemPrecoVenda: Boolean);
  Var
    intIndice: Integer;
Begin
  For intIndice := 1 to Length(VS_strTabPrc) do
    pRecalculaPrecoTabela(intIndice, SameText(STR_TIPALT_PRECO, FieldByName('TIPALT').AsString), blnMantemPrecoVenda);
End;

Function TAtualizaPreco.fIncluiItens(pgbProgresso: TcxProgressBar): Boolean;
  Var
    fltIpiEnt,
    fltSubsti,
    fltPreCot: Double;
    strPJAATU,
    strCodFor: String;
    blnFilterFornec: Boolean;
Begin
  blnFilterFornec := FcdsItensFornec.Filtered;
  Try
    FcdsItensFornec.Filtered := False;
    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := FcdsItens.RecordCount;

    Self.DisableControls;
    Self.BeforePost := Nil;

    If Assigned(frmCadCotItens) And Assigned(frmCadCotItens.cdsConsulta) Then
    begin
      frmCadCotItens.cdsConsulta.DisableControls;
    End;

    With FcdsItens Do
    Begin
      DisableControls;
      First;
      while Not Eof do
      Begin
        fltPreCot := 0;
        fltIpiEnt := 0;
        fltSubsti := 0;

        If FdicPrecoEscol[FieldByName('CODITE').AsString] <> Null Then
        Begin
          strCodFor := FdicPrecoEscol[FieldByName('CODITE').AsString];

          If (Not fEmptyStr(strCodFor)) And
             FcdsItensFornec.Locate('CODITE;CODFOR', VarArrayOf([FieldByName('CODITE').AsString, strCodFor]), []) then
          Begin
            fltPreCot := FcdsItensFornec.FieldByName('VALUNI').AsFloat;
            fltIpiEnt := FcdsItensFornec.FieldByName('IPIENT').AsFloat;
            fltSubsti := FcdsItensFornec.FieldByName('SUBSTI').AsFloat;
          End;
        End;

       If Assigned(frmCadCotItens) And Assigned(frmCadCotItens.cdsConsulta) And
          frmCadCotItens.cdsConsulta.Locate('CODITE', FieldByName('CODITE').AsString, []) Then
         strPJAATU := frmCadCotItens.cdsConsulta.FieldByName('PJAATU').AsString
       Else
         strPJAATU := 'N';

        pIncluiItem(FieldByName('CODITE').AsString,
                    strPJAATU,
                    fltPreCot,
                    fltIpiEnt,
                    fltSubsti,
                    FieldByName('QTDITE').AsFloat);
        Next;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;

      EnableControls;
    End;

    frmGravando.lblGravando.Caption := 'Atualizando itens...';
    pgbProgresso.Position           := 0;
    pgbProgresso.Properties.Max     := Self.RecordCount;

    Self.First;
    while Not Self.Eof do
    Begin
      if Not FcdsItens.Locate('CODITE', Self.FieldByName('CODITE').AsString, []) then
        Self.Delete
      Else
        Self.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    Self.BeforePost := pBeforePost;

    Self.EnableControls;

    Result := True;

    If Assigned(frmCadCotItens) And Assigned(frmCadCotItens.cdsConsulta) Then
    begin
      frmCadCotItens.cdsConsulta.EnableControls;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TAtualizaPreco.fIncluiItens]');
    End;
  End;

  FcdsItensFornec.Filtered := blnFilterFornec;
End;

Function TAtualizaPreco.fRecalculaItens(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Try
    Self.DisableControls;
    Self.BeforePost := Nil;

    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := FcdsItens.RecordCount;

    Self.First;
    while Not Self.Eof do
    Begin
      Edit;

      If FPreVen Then
        Self.FieldByName('TIPALT').AsString := STR_TIPALT_PRECO
      Else
        Self.FieldByName('TIPALT').AsString := STR_TIPALT_MARGEM;

      pRecalculaPreco(True);

      Post;

      Self.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    Self.BeforePost := pBeforePost;

    Self.EnableControls;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TAtualizaPreco.fRecalculaItens]');
    End;
  End;
End;

Procedure TAtualizaPreco.pRecalculaItens(blnPreVen: Boolean);
Begin
  Try
    FPreVen := blnPreVen;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Recalculando preço dos itens...';
    frmGravando.fExecutarAcao := fRecalculaItens;
    frmGravando.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TAtualizaPreco.pRecalculaItens]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

Procedure TAtualizaPreco.pDesmarcaCotacao;
  Var
    qryCotIte: TUniQuery;
Begin
  If Assigned(frmCadCotItens) Then
  Begin
    qryCotIte := fCriaQuery;
    With qryCotIte, SQL Do
    Begin
      Add('UPDATE COTITE SET COT_PJAATU = "N"');
      Add('WHERE COT_SEQGER = ' + QuotedStr(frmCadCotItens.strSeqGer));
      ExecSQL;
    End;
    FreeAndNil(qryCotIte);
  End;
End;

Function TAtualizaPreco.fDesmarcaAtualizados(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Try
    Self.DisableControls;
    Self.BeforePost := Nil;

    If Assigned(frmCadCotItens) And Assigned(frmCadCotItens.cdsConsulta) Then
    begin
      frmCadCotItens.cdsConsulta.DisableControls;
    End;

    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := Self.RecordCount;
    Application.ProcessMessages;
    pDesmarcaCotacao;

    Self.First;
    while Not Self.Eof do
    Begin
      Edit;
      FieldByName('PJAATU').AsString := 'N';
      Post;

      If Assigned(frmCadCotItens) And Assigned(frmCadCotItens.cdsConsulta) And
        frmCadCotItens.cdsConsulta.Locate('CODITE', FieldByName('CODITE').AsString, []) Then
      Begin
        frmCadCotItens.cdsConsulta.Edit;
        frmCadCotItens.cdsConsulta.FieldByName('PJAATU').AsString := 'S';
        frmCadCotItens.cdsConsulta.Post;
      End;

      Self.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    Self.BeforePost := pBeforePost;

    Self.EnableControls;

    If Assigned(frmCadCotItens) And Assigned(frmCadCotItens.cdsConsulta) Then
    begin
      frmCadCotItens.cdsConsulta.EnableControls;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TAtualizaPreco.fRecalculaItens]');
    End;
  End;
End;

Procedure TAtualizaPreco.pDesmarcaAtualizados;
Begin
  Try

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Desmarcando itens...';
    frmGravando.fExecutarAcao := fDesmarcaAtualizados;
    frmGravando.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TAtualizaPreco.pDesmarcaAtualizados]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

Procedure TAtualizaPreco.pAtualizaItens(cdsItens,
                                        cdsItensFornec: TUniClientDataSet;
                                        dicPrecoEscol: TDicionario;
                                        blnAtuIPI: Boolean);
Begin
  Try
    FcdsItens       := cdsItens;
    FcdsItensFornec := cdsItensFornec;
    FdicPrecoEscol  := dicPrecoEscol;
    blnAtuIPISub    := blnAtuIPI;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Carregando preço dos itens...';
    frmGravando.fExecutarAcao := fIncluiItens;
    frmGravando.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TAtualizaPreco.pAtualizaItens]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

Procedure TAtualizaPreco.pMarcaItem;
Begin
  if Not IsEmpty then
    pMarcaItemCorrente(marInverte);
End;

Procedure TAtualizaPreco.pMarcaItemCorrente(pmrTipMar: TTipoMarcaca);
Begin
  Edit;
  case pmrTipMar of
    marInverte:  if FieldByName('ATUPRE').AsString = 'S' Then
                   FieldByName('ATUPRE').AsString := 'N'
                 Else
                   FieldByName('ATUPRE').AsString := 'S';

    marMarca   : FieldByName('ATUPRE').AsString := 'S';

    marDesmarca: FieldByName('ATUPRE').AsString := 'N';
  end;

  Post;
End;

Procedure TAtualizaPreco.pMarcaTodos(pmrTipMar: TTipoMarcaca);
Begin
  DisableControls;
  First;
  while Not Eof do
  Begin
    pMarcaItemCorrente(pmrTipMar);
    Next;
  End;
  EnableControls;
End;

Procedure TAtualizaPreco.pIncluiPreIte(DataSet: TDataSet; dtaDtaAtu: TDateTime; strProPri: String);
  var
    strSql: String;
    intCont: Integer;
    qryGenIte: TUniQuery;
Begin
  fExecutaSQL(' DELETE FROM PREITE ' +
              ' WHERE PRE_DTAPRE = ' + fCurrentDate(dtaDtaAtu)  + '  AND ' +
              '       PRE_CODITE = ' + QuotedStr(FieldByName('CODITE').AsString));

  strSql := '';
  strSql := strSql + 'INSERT INTO ';
  strSql := strSql + '  PREITE ';
  strSql := strSql + '(PRE_DTAPRE, ';
  strSql := strSql + ' PRE_CODITE, ';
  strSql := strSql + ' PRE_CODEMP, ';
  strSql := strSql + ' AUTOINCREM, ';
  strSql := strSql + ' PRE_PRECOM, ';
  strSql := strSql + ' PRE_DESF01, ';
  strSql := strSql + ' PRE_DESF02, ';
  strSql := strSql + ' PRE_DESF03, ';
  strSql := strSql + ' PRE_DESF04, ';
  strSql := strSql + ' PRE_DESF05, ';
  strSql := strSql + ' PRE_DESF06, ';
  strSql := strSql + ' PRE_ICMENT, ';
  strSql := strSql + ' PRE_SUBFED, ';
  strSql := strSql + ' PRE_IPIENT, ';
  strSql := strSql + ' PRE_FREENT, ';
  strSql := strSql + ' PRE_VALFRE, ';
  strSql := strSql + ' PRE_ACRFIN, ';
  strSql := strSql + ' PRE_SUBSTI, ';
  strSql := strSql + ' PRE_DESADB, ';
  strSql := strSql + ' PRE_OUTVAL, ';
  strSql := strSql + ' PRE_ICMSAI, ';
  strSql := strSql + ' PRE_IMPFED, ';
  strSql := strSql + ' PRE_MLTCOM, ';
  strSql := strSql + ' PRE_DESOPE, ';
  strSql := strSql + ' PRE_PRECUS, ';
  strSql := strSql + ' PRE_PRECUS_NOV, ';
  strSql := strSql + ' PRE_DESMAX, ';
  strSql := strSql + ' PRE_DESMGE, ';
  strSql := strSql + ' PRE_DESMSU, ';

  strSql := strSql + ' PRE_COMTB1, ';
  strSql := strSql + ' PRE_COMTB2, ';
  strSql := strSql + ' PRE_COMTB3, ';
  strSql := strSql + ' PRE_COMTB4, ';
  strSql := strSql + ' PRE_COMTB5, ';
  strSql := strSql + ' PRE_COMTB6, ';
  strSql := strSql + ' PRE_COMTB7, ';

  strSql := strSql + ' PRE_MARBR1, ';
  strSql := strSql + ' PRE_MARBR1_NOV, ';
  strSql := strSql + ' PRE_PREVE1, ';
  strSql := strSql + ' PRE_PREVE1_NOV, ';
  strSql := strSql + ' PRE_MARBR2, ';
  strSql := strSql + ' PRE_MARBR2_NOV, ';
  strSql := strSql + ' PRE_PREVE2, ';
  strSql := strSql + ' PRE_PREVE2_NOV, ';
  strSql := strSql + ' PRE_MARBR3, ';
  strSql := strSql + ' PRE_MARBR3_NOV, ';
  strSql := strSql + ' PRE_PREVE3, ';
  strSql := strSql + ' PRE_PREVE3_NOV, ';
  strSql := strSql + ' PRE_MARBR4, ';
  strSql := strSql + ' PRE_MARBR4_NOV, ';
  strSql := strSql + ' PRE_PREVE4, ';
  strSql := strSql + ' PRE_PREVE4_NOV, ';
  strSql := strSql + ' PRE_MARMIN, ';
  strSql := strSql + ' PRE_MARBR5, ';
  strSql := strSql + ' PRE_MARBR5_NOV, ';
  strSql := strSql + ' PRE_PREVE5, ';
  strSql := strSql + ' PRE_PREVE5_NOV, ';
  strSql := strSql + ' PRE_MARBR6, ';
  strSql := strSql + ' PRE_MARBR6_NOV, ';
  strSql := strSql + ' PRE_PREVE6, ';
  strSql := strSql + ' PRE_PREVE6_NOV, ';
  strSql := strSql + ' PRE_MARBR7, ';
  strSql := strSql + ' PRE_MARBR7_NOV, ';
  strSql := strSql + ' PRE_PREVE7, ';
  strSql := strSql + ' PRE_PREVE7_NOV, ';
  strSql := strSql + ' PRE_QTDITE,     ';
  strSql := strSql + ' PRE_PROPRI)     ';
  strSql := strSql + '    VALUES ( ';
  strSql := strSql + '  :DTAPRE, ';
  strSql := strSql + '  :CODITE, ';
  strSql := strSql + '  :CODEMP, ';
  strSql := strSql + '  :AUTOIN, ';
  strSql := strSql + '  :PRECOM, ';
  strSql := strSql + '  :DESF01, ';
  strSql := strSql + '  :DESF02, ';
  strSql := strSql + '  :DESF03, ';
  strSql := strSql + '  :DESF04, ';
  strSql := strSql + '  :DESF05, ';
  strSql := strSql + '  :DESF06, ';
  strSql := strSql + '  :ICMENT, ';
  strSql := strSql + '  :SUBFED, ';
  strSql := strSql + '  :IPIENT, ';
  strSql := strSql + '  :FREENT, ';
  strSql := strSql + '  :VALFRE, ';
  strSql := strSql + '  :ACRFIN, ';
  strSql := strSql + '  :SUBSTI, ';
  strSql := strSql + '  :DESADB, ';
  strSql := strSql + '  :OUTVAL, ';
  strSql := strSql + '  :ICMSAI, ';
  strSql := strSql + '  :IMPFED, ';
  strSql := strSql + '  :MLTCOM, ';
  strSql := strSql + '  :DESOPE, ';
  strSql := strSql + '  :PRECUS, ';
  strSql := strSql + '  :PRECUS_NOV, ';
  strSql := strSql + '  :DESMAX, ';
  strSql := strSql + '  :DESMGE, ';
  strSql := strSql + '  :DESMSU, ';

  strSql := strSql + '  :COMTB1,     ';
  strSql := strSql + '  :COMTB2,     ';
  strSql := strSql + '  :COMTB3,     ';
  strSql := strSql + '  :COMTB4,     ';
  strSql := strSql + '  :COMTB5,     ';
  strSql := strSql + '  :COMTB6,     ';
  strSql := strSql + '  :COMTB7,     ';

  strSql := strSql + '  :MARBR1,     ';
  strSql := strSql + '  :MARBR1_NOV, ';
  strSql := strSql + '  :PREVE1,     ';
  strSql := strSql + '  :PREVE1_NOV, ';

  strSql := strSql + '  :MARBR2,     ';
  strSql := strSql + '  :MARBR2_NOV, ';
  strSql := strSql + '  :PREVE2,     ';
  strSql := strSql + '  :PREVE2_NOV, ';

  strSql := strSql + '  :MARBR3,      ';
  strSql := strSql + '  :MARBR3_NOV, ';
  strSql := strSql + '  :PREVE3,     ';
  strSql := strSql + '  :PREVE3_NOV, ';

  strSql := strSql + '  :MARBR4,     ';
  strSql := strSql + '  :MARBR4_NOV, ';
  strSql := strSql + '  :PREVE4,     ';
  strSql := strSql + '  :PREVE4_NOV, ';

  strSql := strSql + '  :MARMIN,     ';

  strSql := strSql + '  :MARBR5,     ';
  strSql := strSql + '  :MARBR5_NOV, ';
  strSql := strSql + '  :PREVE5,     ';
  strSql := strSql + '  :PREVE5_NOV, ';

  strSql := strSql + '  :MARBR6,     ';
  strSql := strSql + '  :MARBR6_NOV, ';
  strSql := strSql + '  :PREVE6,     ';
  strSql := strSql + '  :PREVE6_NOV, ';

  strSql := strSql + '  :MARBR7,     ';
  strSql := strSql + '  :MARBR7_NOV, ';
  strSql := strSql + '  :PREVE7,     ';
  strSql := strSql + '  :PREVE7_NOV, ';
  strSql := strSql + '  :QTDITE,     ';
  strSql := strSql + '  :PROPRI)     ';

  qryGenIte := fCriaQuery(Self);

  With DataSet Do
  Begin
    qryGenIte.Close;
    qryGenIte.SQL.Clear;
    qryGenIte.SQL.Add(strSql);

    qryGenIte.ParamByName('PRECOM').AsFloat  := FieldByName('PRECOT').AsFloat;
    qryGenIte.ParamByName('DESF01').AsFloat  := FieldByName('ITE_DESF01').AsFloat;
    qryGenIte.ParamByName('DESF02').AsFloat  := FieldByName('ITE_DESF02').AsFloat;
    qryGenIte.ParamByName('DESF03').AsFloat  := FieldByName('ITE_DESF03').AsFloat;
    qryGenIte.ParamByName('DESF04').AsFloat  := FieldByName('ITE_DESF04').AsFloat;
    qryGenIte.ParamByName('DESF05').AsFloat  := FieldByName('ITE_DESF05').AsFloat;
    qryGenIte.ParamByName('DESF06').AsFloat  := FieldByName('ITE_DESF06').AsFloat;
    qryGenIte.ParamByName('ICMENT').AsFloat  := FieldByName('ITE_ICMENT').AsFloat;
    qryGenIte.ParamByName('SUBFED').AsFloat  := FieldByName('ITE_SUBFED').AsFloat;
    qryGenIte.ParamByName('IPIENT').AsFloat  := FieldByName('ITE_IPIENT').AsFloat;
    qryGenIte.ParamByName('FREENT').AsFloat  := FieldByName('ITE_FREENT').AsFloat;
    qryGenIte.ParamByName('VALFRE').AsFloat  := FieldByName('ITE_VALFRE').AsFloat;
    qryGenIte.ParamByName('ACRFIN').AsFloat  := FieldByName('ITE_ACRFIN').AsFloat;
    qryGenIte.ParamByName('SUBSTI').AsFloat  := FieldByName('ITE_SUBSTI').AsFloat;
    qryGenIte.ParamByName('DESADB').AsFloat  := FieldByName('ITE_DESADB').AsFloat;
    qryGenIte.ParamByName('OUTVAL').AsFloat  := FieldByName('ITE_OUTVAL').AsFloat;
    qryGenIte.ParamByName('ICMSAI').AsFloat  := FieldByName('ITE_ICMSAI').AsFloat;
    qryGenIte.ParamByName('IMPFED').AsFloat  := FieldByName('ITE_IMPFED').AsFloat;

    qryGenIte.ParamByName('DESOPE').AsFloat  := FieldByName('ITE_DESOPE').AsFloat;

    qryGenIte.ParamByName('PRECUS').AsFloat     := FieldByName('PRECUS').AsFloat;
    qryGenIte.ParamByName('PRECUS_NOV').AsFloat := FieldByName('NOVCUS').AsFloat;

    qryGenIte.ParamByName('DESMAX').Value  := Null;
    qryGenIte.ParamByName('DESMGE').Value  := Null;
    qryGenIte.ParamByName('DESMSU').Value  := Null;
    qryGenIte.ParamByName('MARMIN').Value  := Null;
    qryGenIte.ParamByName('MLTCOM').Value  := Null;

    qryGenIte.ParamByName('COMTB1').AsFloat  := FieldByName('ITE_COMTB1').AsFloat;
    qryGenIte.ParamByName('COMTB2').AsFloat  := FieldByName('ITE_COMTB2').AsFloat;
    qryGenIte.ParamByName('COMTB3').AsFloat  := FieldByName('ITE_COMTB3').AsFloat;
    qryGenIte.ParamByName('COMTB4').AsFloat  := FieldByName('ITE_COMTB4').AsFloat;
    qryGenIte.ParamByName('COMTB5').AsFloat  := FieldByName('ITE_COMTB5').AsFloat;
    qryGenIte.ParamByName('COMTB6').AsFloat  := FieldByName('ITE_COMTB6').AsFloat;
    qryGenIte.ParamByName('COMTB7').AsFloat  := FieldByName('ITE_COMTB7').AsFloat;

    For intCont := 1 To Length(VS_strTabPrc) Do
    Begin
      qryGenIte.ParamByName('MARBR' + IntToStr(intCont)).AsFloat := FieldByName('MARBR' + IntToStr(intCont)).AsFloat;
      qryGenIte.ParamByName('PREVE' + IntToStr(intCont)).AsFloat := FieldByName('PREVE' + IntToStr(intCont)).AsFloat;

      qryGenIte.ParamByName('MARBR' + IntToStr(intCont) + '_NOV').AsFloat := FieldByName('NOVBR' + IntToStr(intCont)).AsFloat;
      qryGenIte.ParamByName('PREVE' + IntToStr(intCont) + '_NOV').AsFloat := FieldByName('NOVVE' + IntToStr(intCont)).AsFloat;
    End;

    qryGenIte.ParamByName('CODITE').AsString   := FieldByName('CODITE').AsString;
    qryGenIte.ParamByName('DTAPRE').AsDateTime := dtaDtaAtu;
    qryGenIte.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    qryGenIte.ParamByName('AUTOIN').AsString   := fRetAutoIncrem('PREITE', VS_strCodEmp);
    qryGenIte.ParamByName('QTDITE').AsFloat    := FieldByName('QTDITE').AsFloat;
    qryGenIte.ParamByName('PROPRI').AsString   := strProPri;

  End;

  qryGenIte.ExecSQL;
  qryGenIte.Close;

  FreeAndNil(qryGenIte);
End;

Procedure TAtualizaPreco.pAtualizaCotIte(strCodIte: String);
Begin
 If Assigned(frmCadCotItens) And Assigned(frmCadCotItens.cdsConsulta) And
    frmCadCotItens.cdsConsulta.Locate('CODITE', FieldByName('CODITE').AsString, []) Then
  With FCotIte Do
  Begin
    Close;
    ParamByName('AUTINC').AsString := frmCadCotItens.cdsConsulta.FieldByName('AUTCOT').AsString;
    ExecSQL;

    frmCadCotItens.cdsConsulta.Edit;
    frmCadCotItens.cdsConsulta.FieldByName('PJAATU').AsString := 'S';
    frmCadCotItens.cdsConsulta.Post;
  End;
End;

Function TAtualizaPreco.fProgramaAtualizaPrecos(pgbProgresso: TcxProgressBar):Boolean;
  Var
    strProPri: String;
Begin
  Try
    If Assigned(frmCadCotItens) And Assigned(frmCadCotItens.cdsConsulta) Then
      frmCadCotItens.cdsConsulta.DisableControls;

    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := RecordCount;

    DisableControls;
    Filter   := 'ATUPRE = ' + QuotedStr('S');
    Filtered := True;

    strProPri := fRetSequencial('PROPRI', VS_strCodEmp);

    First;
    while Not Eof do
    Begin
      pIncluiPreIte(Self, dtaDtaAtu, strProPri);

      Edit;
      FieldByName('PJAATU').AsString := 'S';
      Post;

      pAtualizaCotIte(FieldByName('CODITE').AsString);

      Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    EnableControls;

    If Assigned(frmCadCotItens) And Assigned(frmCadCotItens.cdsConsulta) Then
      frmCadCotItens.cdsConsulta.EnableControls;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TAtualizaPreco.fProgramaAtualizaPrecos]');
    End;
  End;

  Filtered := False;
End;

Procedure TAtualizaPreco.pProgramaAtualizaPrecos;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Agendando atualizando cadastro de itens...';
    frmGravando.fExecutarAcao := fProgramaAtualizaPrecos;
    frmGravando.ShowModal;

    If frmGravando.blnConfirma then
      pMensagemOk('Operação concluida com sucesso!');

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TAtualizaPreco.pProgramaAtualizaPrecos]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

Procedure TAtualizaPreco.pAtualizaPrecos;
  Var
    strMensagem: String;
Begin
  Try
    strMensagem := 'Confirma a atualização dos Preços/Margens para todos os itens marcados?';
    dtaDtaAtu := VS_Date;

    If Not (fPergunta(strMensagem) And
            ffrmData(dtaDtaAtu, '', 'Digite a Data para a Atualização de Preços', VS_Date)) Then
      Exit;

    pProgramaAtualizaPrecos;

    If dtaDtaAtu <= VS_Date then
      pOpeProd(AltEfetivacaoPrecos);

    FAtualizando := True;

    pAtualizaItens(FcdsItens, FcdsItensFornec, FdicPrecoEscol, blnAtuIPISub);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TAtualizaPreco.pAtualizaPrecos]');
    End;
  End;

  FAtualizando := False;
End;

Function TAtualizaPreco.fTemAlteracaoManual: Boolean;
Begin
  Result := False;

  If Not Active Then
    Exit;

  If IsEmpty Then
    Exit;

  DisableControls;
  Filter := ' (NOVVE1 <> NOVCA1) OR ' +
            ' (NOVVE2 <> NOVCA2) OR ' +
            ' (NOVVE3 <> NOVCA3) OR ' +
            ' (NOVVE4 <> NOVCA4) OR ' +
            ' (NOVVE5 <> NOVCA5) OR ' +
            ' (NOVVE6 <> NOVCA6) OR ' +
            ' (NOVVE7 <> NOVCA7) ';

  Filtered := True;

  Result := Not IsEmpty;

  Filtered := False;

  EnableControls;
End;

end.

