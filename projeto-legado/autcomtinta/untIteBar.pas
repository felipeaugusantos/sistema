unit untIteBar;

interface

Uses
  Uni, SysUtils, DB, UniClientDataSet, UniDataSetProvider, DBEditFocus, Controls,
  Classes, Math, frxClass, frxDBset, StrUtils, Forms, untTypesSistema, TypesRel,
  untFuncoesEtiquetas, Graphics, untInterfacedObjectNoCount, untIIteBar;

Type
  TIteBar = Class(TInterfacedObjectNoCount, IIteBar)
    Private
      qryIteBar: TUniQuery;
      qryTabIte: TUniQuery;
      dspIteBar: TUniDataSetProvider;

      dbeCodBar,
      dbeBarEmb,
      dbeEmbala: TDBEditFocus;

      Procedure pVeSeMarcaPrincipalCompra;
      procedure pAfterDelete(DataSet: TDataSet);
      Procedure pAbreCadEmbalagens(wncLocCad: TWincontrol);
      Procedure pAbreCadEmbalagensConsulta;
      Procedure pUpdateCadIte(strIteUpd: String);
      Procedure pRetPrincipais(Var strCodBar, strBarEmb: String;
                               Var fltEmbala: Double);

    Public
      strCodIte: String;
      dtsIteBar: TDataSource;
      cdsIteBar: TUniClientDataSet;
      opcCriaca: TOpcaoCriacao;

      constructor Create(opcCriacaP: TOpcaoCriacao = opcFuncoes;
                         qryTabIteP: TUniQuery = Nil;
                         dbeCodBarP: TDBEditFocus = Nil;
                         dbeBarEmbP: TDBEditFocus = Nil;
                         dbeEmbalaP: TDBEditFocus = Nil;
                         wncLocCadP: TWincontrol  = Nil;
                         strCodIteP: String = ''); Reintroduce;

      Destructor Destroy; override;

      function fFornecedorDuplicado(strCodBar, strCodFor: String): Boolean;

      Class Function fRetEmbalagemFornecedor(strCodIte, strCodFor: String): Double;

      Function fGeraCodBarAuto(fltEmbala: Double): String;
      Function fQuantidadeEmbalagem(strCodIte, strCodBar: String): Double;
      function fValidaCodigoBarras(strCodBar, strCodIte: String; Var strItem: String): Boolean;
      Function fValidaCodBar(strCodBar: String; blnRollback: Boolean = False): Boolean;
      Function fVerificaCodBar(strItem: String; blnRollback: Boolean = False): Boolean;

      function fGeraCodigoBarrasUnidades(strCodIte, strCodGru: String; fltQtdIte: Double): String;
      function fLerCodigoBarrasUnidades(strCodBar: String; Var strCodIte, strCodGru: String; Var fltQtdIte: Double): Boolean;

      function fLerCodigoFabricaMaiorFornecedor(strCodBar: String; var strCodIte: String;
                          var fltQtdIte: Double): Boolean;

      function fCalculaUnidadesRestante(fltQtdIte: Double): Double; overload;
      function fCalculaUnidadesRestante(fltQtdIte: Double; Var strSugestao: String): Double; overload;
      procedure pImprimeEtiquetaUnidadesRestante(arrItens: TArrItensEtiqUnRestante;
                                                 opcEtique: TOpcaoEtiqueta;
                                                 strNumDoc: String = '';
                                                 strEspDoc: String = '';
                                                 strCodEmp: String = '';
                                                 strCodCon: String = '';
                                                 intQuaEti: Integer = 1;
                                                 blnImprime: Boolean = True;
                                                 blnCadEmb: Boolean = False;
                                                 strCodCli: String = '');

      Procedure pRetCodBarPrincipal;

      Procedure pGeraCodigoBarras(strCodGru: String; strItem: String);
      Procedure pExcluiRegistro;
      Procedure pCarregaDados(strCodIteP: String);
      Procedure pSalvaDados(strCodigoItem: String; blnUpdIte: Boolean = False);
      Procedure pCancela;

      Procedure pIncluiCodigo(strCodBar: String; fltEmbala: Double;
                              blnPrinci, blnCompra, blnExbFat: Boolean;
                              fltPreVen: Double; strDescri: String;
                              strTabPre,
                              strCodFor: String;
                              fltAltura, fltLargur, fltProfun : Double;
                              intLastro, intCamada, intEmpMax : Integer;
                              fltPesoBR, fltPesoLQ : Double;
                              blnAtuCodBarCadIte: Boolean = False);

      Procedure pAjustaPrincipalCompra;
      Procedure pIncluiCodigoBarrasCatalogo(strIteCat, strCodBar, strBarEmb: String; fltEmbala: Double);
      Procedure pHabilitaEdicao(blnHabil: Boolean);
      Procedure pFocaCodBarras;
      Procedure pFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      function fValidaTabelaPrecosEmbalagem: Boolean;

      procedure pVerdeVermelho(blnAcesso: Boolean);

      Procedure IncluiPrincipalParaCompras(strCodIte, strCodBar: String; fltEmbala: Double;
                                            var  blnPrincipal: Boolean);
      function fRetFatorPrincipalCompra: Double;

  End;

  function fValidaCodBarra(strCodBar, strCodIte: String; Var strItem: String): Boolean;
  function fValidaCodBarraEsemelhante(strCodBar, strCodIte: String): Boolean;

implementation

Uses
     untfuncoesSimples,untFuncoesRel, untConstantes,untCadEmbalagens, untCfgRel;
  
constructor TIteBar.Create(opcCriacaP: TOpcaoCriacao = opcFuncoes;
                           qryTabIteP: TUniQuery = Nil;
                           dbeCodBarP: TDBEditFocus = Nil;
                           dbeBarEmbP: TDBEditFocus = Nil;
                           dbeEmbalaP: TDBEditFocus = Nil;
                           wncLocCadP: TWincontrol  = Nil;
                           strCodIteP : String = '');
Begin
  Inherited Create;

  qryTabIte   := qryTabIteP;
  dbeCodBar   := dbeCodBarP;
  dbeBarEmb   := dbeBarEmbP;
  dbeEmbala   := dbeEmbalaP;
  opcCriaca   := opcCriacaP;
  strCodIte   := strCodIteP;

  If opcCriaca In [opcCadastro, opcOperacoes, opcConsulta] Then
  Begin
    qryIteBar := fCriaQuery(Nil);

    dspIteBar := TUniDataSetProvider.Create(Nil);
    dspIteBar.ResolveToDataSet := True;
    cdsIteBar := TUniClientDataSet.Create(Nil);
    dtsIteBar := TDataSource.Create(Nil);

    dspIteBar.DataSet := qryIteBar;
    dtsIteBar.DataSet := cdsIteBar;

    cdsIteBar.AfterDelete := pAfterDelete;
  End;

  Case opcCriaca Of
    opcCadastro: pAbreCadEmbalagens(wncLocCadP);
    opcConsulta: pAbreCadEmbalagensConsulta;
  End;

End;

Destructor TIteBar.Destroy;
Begin
  Inherited;

  If opcCriaca In [opcCadastro, opcOperacoes] Then
  Begin
    qryIteBar.Close;
    cdsIteBar.Close;

    FreeAndNil(dtsIteBar);
    FreeAndNil(qryIteBar);
    FreeAndNil(cdsIteBar);
    FreeAndNil(dspIteBar);
  End;

  If (opcCriaca In [opcCadastro]) And (Assigned(frmCadEmbalagens)) Then
    FreeAndNil(frmCadEmbalagens);

End;

Procedure TIteBar.pCarregaDados(strCodIteP: String);
Begin
  strCodIte := strCodIteP;
  qryIteBar.Close;
  cdsIteBar.Close;

  With qryIteBar, SQL Do
  Begin
    Clear;
    Add('SELECT ITEBAR.*, CADITE.ITE_ETIQRES FROM ITEBAR');
    Add('INNER JOIN CADITE ON ITE_CODITE = BAR_CODITE');
    Add('WHERE BAR_CODITE = :CODITE');
    Add('ORDER BY BAR_CODBAR');

    ParamByName('CODITE').AsString := strCodIte;

    Open;
    pSetaClient(qryIteBar);
  End;

  cdsIteBar.SetProvider(dspIteBar);
  cdsIteBar.Open;
  pSetaClient(cdsIteBar);

  TFloatField(cdsIteBar.FieldByName('BAR_EMBALA')).DisplayFormat := fMskDigitos(DEC_EMBALAGEM);
  TFloatField(cdsIteBar.FieldByName('BAR_PREVEN')).DisplayFormat := '#0.00';
  TFloatField(cdsIteBar.FieldByName('BAR_ALTURA')).DisplayFormat := '#0.00';
  TFloatField(cdsIteBar.FieldByName('BAR_LARGUR')).DisplayFormat := '#0.00';
  TFloatField(cdsIteBar.FieldByName('BAR_PROFUN')).DisplayFormat := '#0.00';
  TFloatField(cdsIteBar.FieldByName('BAR_PESOBR')).DisplayFormat := '#0.00';
  TFloatField(cdsIteBar.FieldByName('BAR_PESOLQ')).DisplayFormat := '#0.00';


  If (opcCriaca In [opcCadastro]) And Assigned(frmCadEmbalagens) Then
  Begin
    frmCadEmbalagens.chkBarAut.Checked := Not fEmptyStr(strCodIte);
    frmCadEmbalagens.chkBarAut.Enabled := Not fEmptyStr(strCodIte);
  End;

End;

Procedure TIteBar.pSalvaDados(strCodigoItem: String; blnUpdIte: Boolean = False);
Begin
  With cdsIteBar Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin

      If fEmptyStr(FieldByName('BAR_CODEMP').AsString) Then
      Begin
        Edit;
        FieldByName('BAR_CODITE').AsString := strCodigoItem;
        FieldByName('BAR_CODEMP').AsString := VS_strCodEmp;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ITEBAR', VS_strCodEmp);
        Post;
      End;

      Next;
    End;

    ApplyUpdates(0);

    If blnUpdIte Then
      pUpdateCadIte(strCodigoItem);

    EnableControls;
  End;
End;

Procedure TIteBar.pUpdateCadIte(strIteUpd: String);
  Var
    strCodBar,
    strBarEmb: String;
    fltEmbala: Double;
    qryCadIte: TUniQuery;
Begin
  pRetPrincipais(strCodBar, strBarEmb, fltEmbala);

  qryCadIte := fCriaQuery;
  
  With qryCadIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' UPDATE  ');
    SQL.Add('   CADITE  ');
    SQL.Add(' SET ITE_CODBAR = :CODBAR, ');
    SQL.Add('     ITE_BAREMB = :BAREMB, ');
    SQL.Add('     ITE_EMBALA = :EMBALA  ');
    SQL.Add(' WHERE ITE_CODITE = :CODITE ');

    ParamByName('CODBAR').AsString  := strCodBar;
    ParamByName('BAREMB').AsString  := strBarEmb;
    ParamByName('EMBALA').AsFloat   := fltEmbala;
    ParamByName('CODITE').AsString  := strIteUpd;
    ExecSQL;

    fAtualizaBarFabIte(strIteUpd);
  End;

  FreeAndNil(qryCadIte);
End;

Procedure TIteBar.pCancela;
Begin
  With cdsIteBar Do
  Begin
    CancelUpdates;
  End;

  frmCadEmbalagens.pLimpaTelaIteBar;
  pHabilitaEdicao(False);
End;

Procedure TIteBar.pFocaCodBarras;
Begin
  pSetFocus(frmCadEmbalagens.edtCodbar);
End;

function TIteBar.fFornecedorDuplicado(strCodBar, strCodFor: String): Boolean;
Begin
  With cdsIteBar Do
  Begin
    DisableControls;

    Result := (Not fEmptyStr(strCodFor)) And
              Locate('BAR_CODFOR', strCodFor, []) And
              (strCodBar <> FieldByName('BAR_CODBAR').AsString);

    EnableControls;
  End;
End;

Procedure TIteBar.pIncluiCodigo(strCodBar: String; fltEmbala: Double;
                                blnPrinci, blnCompra, blnExbFat: Boolean;
                                fltPreVen: Double; strDescri: String;
                                strTabPre,
                                strCodFor: String;
                                fltAltura, fltLargur, fltProfun : Double;
                                intLastro, intCamada, intEmpMax : Integer;
                                fltPesoBR, fltPesoLQ : Double;
                                blnAtuCodBarCadIte: Boolean = False);
  var qryAtu: TUniQuery;
Begin
  With cdsIteBar Do
  Begin
    DisableControls;

    If blnPrinci And Locate('BAR_PRINCI', 1, []) Then
    Begin
      Edit;
      FieldByName('BAR_PRINCI').AsInteger := 0;
      Post;
    End;

    If blnCompra And Locate('BAR_COMPRA', 1, []) Then
    Begin
      Edit;
      FieldByName('BAR_COMPRA').AsInteger := 0;
      Post;
    End;

    If Locate('BAR_CODBAR', strCodBar, []) Then
      Edit
    Else
      Insert;

    FieldByName('BAR_CODBAR').AsString  := strCodBar;
    FieldByName('BAR_EMBALA').AsFloat   := fltEmbala;
    FieldByName('BAR_PREVEN').AsFloat   := fltPreVen;
    FieldByName('BAR_DESCRI').AsString  := strDescri;
    FieldByName('BAR_TABPRE').AsString  := strTabPre;
    FieldByName('BAR_PRINCI').AsInteger := IIF(blnPrinci, 1, 0);
    FieldByName('BAR_COMPRA').AsInteger := IIF(blnCompra, 1, 0);
    FieldByName('BAR_EXBFAT').AsString  := IIF(blnExbFat, 'S', 'N');
    FieldByName('BAR_ALTURA').AsFloat   := fltAltura;
    FieldByName('BAR_LARGUR').AsFloat   := fltLargur;
    FieldByName('BAR_PROFUN').AsFloat   := fltProfun;
    FieldByName('BAR_LASTRO').AsInteger := intLastro;
    FieldByName('BAR_CAMADA').AsInteger := intCamada;
    FieldByName('BAR_EMPMAX').AsInteger := intEmpMax;
    FieldByName('BAR_PESOBR').AsFloat   := fltPesoBR;
    FieldByName('BAR_PESOLQ').AsFloat   := fltPesoLQ;

    If fEmptyStr(strCodFor) Then
      FieldByName('BAR_CODFOR').Clear
    Else
      FieldByName('BAR_CODFOR').AsString  := strCodFor;

    Post;
    If blnAtuCodBarCadIte Then
    Begin
      qryAtu := fCriaQuery;
      Try
        Try
          qryAtu.SQL.Add('UPDATE CADITE SET ITE_CODBAR = "' + strCodBar + '"');
          qryAtu.SQL.Add(' WHERE ITE_CODITE = "' + FieldByName('BAR_CODITE').AsString + '"');
          qryAtu.ExecSQL;
        Except
          On E: Exception Do
             pMensagensErro('Aconteceu uma falha ao atulizar Código de Barras no Cadastro do Produto: ' + E.Message, '[TIteBar.pIncluiCodigo]');
        End;
      Finally
        FreeAndNil(qryAtu);
      End;
    End;
    EnableControls;
  End;
End;

function TIteBar.fValidaCodigoBarras(strCodBar, strCodIte: String; Var strItem: String): Boolean;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;

begin
  Try

    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '  ITE_DESITE AS DESITE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEBAR ';
    strSQL := strSQL + 'INNER JOIN CADITE ON ITE_CODITE = BAR_CODITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  BAR_CODBAR = :CODBAR AND ';
    strSQL := strSQL + '  ITE_CODITE <> "'+strCodIte+'"';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBAR').AsString := strCodBar;
      Open;
      If IsEmpty Then
        Result := True
      Else
      Begin
        Result := False;
        strItem := FieldByName('CODITE').AsString + ' - ' + FieldByName('DESITE').AsString;
      End;
      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

end;

function TIteBar.fValidaTabelaPrecosEmbalagem: Boolean;
begin
  Result := True;

  If fCfgSis('PRVEMB', VarBoolean) And (fCfgSis('PREEMB', VarInteger) = 2) Then
  Begin
    With cdsIteBar Do
    Begin
      First;

      While Not Eof Do
      Begin
        If (Not fEmptyStr(FieldByName('BAR_TABPRE').AsString))                       And
           (Not SameText(FieldByName('BAR_TABPRE').AsString, 'F'))                   And
           SameText(VS_strTabPrc[StrToInt(FieldByName('BAR_TABPRE').AsString)], 'N') Then
        Begin
          If Assigned(frmCadEmbalagens) Then
          Begin
            frmCadEmbalagens.intTabPreVal := FieldByName('BAR_TABPRE').AsInteger;
            frmCadEmbalagens.pCarregaTelaIteBar;
            pSetFocus(frmCadEmbalagens.cmbTabPre);
          End;

          fMensagem('ATENÇÃO!', 'Tabela de preço não permitida. A empresa logada está configurado para não trabalhar com esta tabela de preço!', ['&Ok']);
          Result := False;
          Break;
        End;

        Next;
      End;
    End;
  End;
end;

Function TIteBar.fValidaCodBar(strCodBar: String; blnRollback: Boolean = False): Boolean;
  Var
    strItem: String;
Begin
  Result := True;

  If Not fValidaCodigoBarras(strCodBar, strCodIte, strItem) Then
  Begin
    If blnRollback then
      fRollBack;

    fMensagem('ATENÇÃO!', 'Código de Barras ' + strCodBar + ' já cadastrado para o item ' + strItem + '!', ['&Ok']);
    Result := False;
  End

  Else If fCodBarraJaInclusoTabSem(strCodBar, strItem) Then
  Begin
    If blnRollback then
      fRollBack;

    fMensagem('ATENÇÃO!', 'Código de barras ' + strCodBar + 'já está cadastrado para o item semelhante: ' + strItem, ['&O K']);
    Result := False;
  End

  Else If (fCfgSis('TIPBAR', varInteger) = 1) And fCfgSis('VALBAR', varBoolean) And (Not fValidaEan13(strCodBar)) Then
  Begin
    If blnRollback then
      fRollBack;

    fMensagem('ATENÇÃO!',  'Código de barras ' + strCodBar + ' não é um código de barras válido, verifique o digito verificador!', ['&Ok']);
    Result := False;

  End;


End;

Procedure TIteBar.pExcluiRegistro;
Begin
  With cdsIteBar Do
  Begin
    If IsEmpty Then
      Exit;

    Delete;
  End;
End;

Function TIteBar.fVerificaCodBar(strItem: String; blnRollback: Boolean): Boolean;
Begin
  Result := True;
  strCodIte := strItem;

  pVeSeMarcaPrincipalCompra;

  With cdsIteBar Do
  Begin
    DisableControls;

    If IsEmpty Then
    Begin
        If blnRollback then
          fRollBack;

        pMensagemOk('O código de barras do item deve ser preenchido!');
        Result := False;
    End

    Else If (Not Locate('BAR_PRINCI', 1, [])) Then
    Begin
      If blnRollback then
        fRollBack;

      pMensagemOk('Informe qual é o código de barras principal do item!');
      Result := False;
    End

    Else Begin

      First;
      While Not Eof Do
      Begin
        If Not fValidaCodBar(FieldByName('BAR_CODBAR').AsString, blnRollback) Then
        Begin
          Result := False;
          Break;
        End;

        Next;
      End;

    End;

    EnableControls;
  End;
End;

Procedure TIteBar.pAjustaPrincipalCompra;
  Var
    strCodBar: String;
    blnCompra,
    blnPrinci: Boolean;
Begin
  With cdsIteBar Do
  Begin
    strCodBar := FieldByName('BAR_CODBAR').AsString;
    blnCompra := FieldByName('BAR_COMPRA').AsInteger = 1;
    blnPrinci := FieldByName('BAR_PRINCI').AsInteger = 1;

    DisableControls;

    If blnPrinci Then
    Begin
      Edit;
      FieldByName('BAR_EMBALA').AsFloat := 1;
      Post;

      Filter := '(BAR_PRINCI = 1) AND (BAR_CODBAR <> ' + QuotedStr(strCodBar) + ')';
      Filtered := True;

      If Not IsEmpty Then
      Begin
        Edit;
        FieldByName('BAR_PRINCI').AsInteger := 0;
        Post;
      END;
    End;

    If blnCompra Then
    Begin
      Filter := '(BAR_COMPRA = 1) AND (BAR_CODBAR <> ' + QuotedStr(strCodBar) + ')';
      Filtered := True;

      If Not IsEmpty Then
      Begin
        Edit;
        FieldByName('BAR_COMPRA').AsInteger := 0;
        Post;
      End;
    End;

    Filtered := False;
    Locate('BAR_CODBAR', strCodBar, []);
    EnableControls;
  End;
End;

procedure TIteBar.pVerdeVermelho(blnAcesso: Boolean);
begin

  If Assigned(frmCadEmbalagens) Then
  Begin
    frmCadEmbalagens.pnlEmbala.Enabled := blnAcesso;
    frmCadEmbalagens.cxgEmbala.Enabled := blnAcesso;
    frmCadEmbalagens.shpAcesso.Visible := True;
    frmCadEmbalagens.shpAcesso.Brush.Color := IIF(blnAcesso, clGreen, clRed);
  End;

end;

Procedure TIteBar.pVeSeMarcaPrincipalCompra;
Begin

  With cdsIteBar Do
  Begin
    If (RecordCount = 1) And (FieldByName('BAR_EMBALA').AsFloat = 1) Then
    Begin
      Edit;
      FieldByName('BAR_PRINCI').AsInteger := 1;
      Post;
    End;
  End;

End;

Procedure TIteBar.pRetCodBarPrincipal;
  Var
    strCodBar, strBarEmb: String;
    fltEmbala: Double;
Begin
  If Not Assigned(qryTabIte) Then
    Exit;

  If (qryTabIte.State In [dsEdit, dsInsert]) Then
  With cdsIteBar Do
  Begin
    pRetPrincipais(strCodBar, strBarEmb, fltEmbala);

    dbeCodBar.DataSource.DataSet.FieldByName(dbeCodBar.Field.FieldName).AsString := strCodBar;
    dbeBarEmb.DataSource.DataSet.FieldByName(dbeBarEmb.Field.FieldName).AsString := strBarEmb;

    dbeEmbala.DataSource.DataSet.FieldByName(dbeEmbala.Field.FieldName).AsFloat := fltEmbala;

//    dbeEmbala.Text := FormatFloat(fMskDigitos(DEC_EMBALAGEM), fltEmbala);

  End;
End;

Procedure TIteBar.pRetPrincipais(Var strCodBar, strBarEmb: String;
                                 Var fltEmbala: Double);
  Var
    strBarAtu: String;
Begin
  With cdsIteBar Do
  Begin
    strBarAtu := FieldByName('BAR_CODBAR').AsString;

    DisableControls;

    If Locate('BAR_PRINCI', 1, []) Then
      strCodBar := FieldByName('BAR_CODBAR').AsString
    Else
      strCodBar := '';

    If Locate('BAR_COMPRA', 1, []) And (FieldByName('BAR_PRINCI').AsInteger <> 1) Then
    Begin
      strBarEmb := FieldByName('BAR_CODBAR').AsString;
      fltEmbala := FieldByName('BAR_EMBALA').AsFloat;
    End Else
    Begin
      strBarEmb := '';
      fltEmbala := 0;
    End;

    Locate('BAR_CODBAR', strBarAtu, []);
    EnableControls;
  End;
End;

Procedure TIteBar.pGeraCodigoBarras(strCodGru: String; strItem: String);
Begin
  With cdsIteBar Do
  Begin
    Insert;

    FieldByName('BAR_COMPRA').AsInteger := 1;
    FieldByName('BAR_PRINCI').AsInteger := 1;
    FieldByName('BAR_EMBALA').AsFloat   := 1;

    If fCfgSis('TIPBAR') = '2' Then
      FieldByName('BAR_CODBAR').AsString := fGeraCodBarraEAN39(strItem)
    Else
      FieldByName('BAR_CODBAR').AsString := fGeraCodBarraEAN13('1' + strCodGru + strItem);

    Post;
  End;

  pRetCodBarPrincipal;
End;

Procedure TIteBar.pIncluiCodigoBarrasCatalogo(strIteCat, strCodBar, strBarEmb: String; fltEmbala: Double);
Begin
  pCarregaDados(strIteCat);

  With cdsIteBar Do
  Begin
    First;
    While Not Eof Do
     Delete;

    If Not fEmptyStr(strCodBar) Then
    Begin
      Insert;
      FieldByName('BAR_CODBAR').AsString  := strCodBar;
      FieldByName('BAR_EMBALA').AsFloat   := 1;
      FieldByName('BAR_PRINCI').AsInteger := 1;
      FieldByName('BAR_COMPRA').AsInteger := 0;
      Post;
    End;

    If (Not fEmptyStr(strBarEmb)) And (fltEmbala > 0) Then
    Begin
      Insert;
      FieldByName('BAR_CODBAR').AsString  := strBarEmb;
      FieldByName('BAR_EMBALA').AsFloat   := fltEmbala;
      FieldByName('BAR_COMPRA').AsInteger := 1;
      FieldByName('BAR_PRINCI').AsInteger := 0;
      Post;
    End;

  End;
End;

function TIteBar.fCalculaUnidadesRestante(fltQtdIte: Double): Double;
  Var
    strSugestao: String;
begin
  Result := fCalculaUnidadesRestante(fltQtdIte, strSugestao);
end;

Function TIteBar.fQuantidadeEmbalagem(strCodIte, strCodBar: String): Double;
  Var
    qryCodIte: TUniQuery;
Begin
  qryCodIte := fCriaQuery(Nil);

  With qryCodIte, SQL Do
  Begin
    Clear;
    Add('SELECT IFNULL(BAR_EMBALA, 0) AS EMBALA FROM ITEBAR');
    Add('WHERE');
    Add('  BAR_CODITE = :CODITE AND ');
    Add('  BAR_CODBAR = :CODBAR     ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODBAR').AsString := strCodBar;

    Open;

    If IsEmpty Then
      Result := 0
    Else
      Result := FieldByName('EMBALA').AsFloat;

    Close;
  End;

  FreeAndNil(qryCodIte);
End;

procedure TIteBar.pAfterDelete(DataSet: TDataSet);
begin
  inherited;

  pRetCodBarPrincipal;
end;

Procedure TIteBar.pAbreCadEmbalagens(wncLocCad: TWincontrol);
Begin
  pCriarFormularios(TfrmCadEmbalagens, frmCadEmbalagens);
  frmCadEmbalagens.objIteBar         := self;
  frmCadEmbalagens.Dock(wncLocCad, wncLocCad.BoundsRect);
  frmCadEmbalagens.pnlStatus.Visible := False;
  frmCadEmbalagens.Show;
  frmCadEmbalagens.Enabled           := False;
End;

Procedure TIteBar.pAbreCadEmbalagensConsulta;

  Var
    frmCadEmbalagens: TfrmCadEmbalagens;
Begin
  Try
    pCriarFormularios(TfrmCadEmbalagens, frmCadEmbalagens);
    pCarregaDados(strCodIte);
    frmCadEmbalagens.objIteBar                          := self;
    frmCadEmbalagens.Width                              := 1024;
    frmCadEmbalagens.Height                             := 768;
    frmCadEmbalagens.pnlBotoes.Visible                  := True;
    frmCadEmbalagens.pnlEmbala.Visible                  := False;
    frmCadEmbalagens.pnlBotoes.Caption                  := '';
    frmCadEmbalagens.Position                           := poDesktopCenter;
    frmCadEmbalagens.BorderStyle                        := bsSingle;
    frmCadEmbalagens.btnSair.Visible                    := True;
    frmCadEmbalagens.btnSair.ParentFont                 := False;
    frmCadEmbalagens.btnSair.Font.Color                 := clBlack;
    frmCadEmbalagens.btnSair.Font.Size                  := 8;
    frmCadEmbalagens.cxgEmbalaView.OptionsData.Deleting := False;
    frmCadEmbalagens.cxgEmbalaView.OptionsData.Editing  := False;
    frmCadEmbalagens.cxgEmbalaExbFat.Visible            := False;
    frmCadEmbalagens.blnFecharComEscape                 := True;
    cdsIteBar.Filter                                    := 'BAR_EXBFAT = ' + QuotedStr('S');
    cdsIteBar.Filtered                                  := True;

    frmCadEmbalagens.ShowModal;
    FreeAndNil(frmCadEmbalagens);

  Except
    On E: Exception Do
    Begin
      FreeAndNil(frmCadEmbalagens);
      pMensagensErro(E.Message, '[pAbreCadEmbalagensConsulta]')
    End;  
  End;

End;

Procedure TIteBar.pHabilitaEdicao(blnHabil: Boolean);
Begin
  If Assigned(frmCadEmbalagens) Then
    frmCadEmbalagens.Enabled := blnHabil;
End;

procedure TIteBar.pFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frmCadEmbalagens.FormKeyDown(Sender, Key, Shift);
end;

function TIteBar.fCalculaUnidadesRestante(fltQtdIte: Double; Var strSugestao: String): Double;
  Var
    cdsTemp     : TUniClientDataSet;
    fltRestante : Double;
    intEmbala   : integer;
    intQtdEmb   : Integer;
begin
  strSugestao := '';

  fltRestante := fltQtdIte;

  cdsTemp := TUniClientDataSet.Create(nil);

  With cdsTemp Do
  Begin                                         
    Data := cdsIteBar.Data;
    IndexFieldNames := 'BAR_EMBALA';
    Filter := 'BAR_PRINCI = 0 AND BAR_COMPRA = 0';
    Filtered := True;

    Last;
    While Not BOF Do
    Begin
      intEmbala := FieldByName('BAR_EMBALA').AsInteger;
      If fFormataFloat(intEmbala,2) <> 0 Then
        intQtdEmb := Floor(fltRestante / intEmbala)
      Else
        intQtdEmb := 0;

      If intQtdEmb > 0 Then
      Begin
        strSugestao := strSugestao + IntToStr(intQtdEmb) + ' ' +
                       'Embalagens com ' + IntToStr(intEmbala) + ' ' +
                       'unidades' + ' / ';

        fltRestante := fltRestante - (intQtdEmb * intEmbala);
      End;

      Prior;
    End;

  End;

  FreeAndNil(cdsTemp);

  If fltRestante > 0 Then
    strSugestao := FloatToStr(fltRestante) + ' unidades';

  Result := fltRestante;

end;

function TIteBar.fGeraCodigoBarrasUnidades(strCodIte, strCodGru: String;
  fltQtdIte: Double): String;
  Var
    strQtd: String;
begin
  strQtd := AnsiReplaceStr(FloatToStrF(fltQtdIte, ffFixed, 12, 2), FormatSettings.DecimalSeparator, '');

  Result := fStrZero(strCodGru, 6) +
            fStrZero(strCodIte, 6) +
            RightStr(fStrZero(strQtd, 12), 6);
end;

function TIteBar.fLerCodigoFabricaMaiorFornecedor(strCodBar: String; var strCodIte: String;
                          var fltQtdIte: Double): Boolean;
  Var
    strQtdIte: String;
Begin
  Result    := Length(strCodBar) = 16;

  strCodIte := MidStr(strCodBar, 01, 05);

  While (Length(strCodIte) > 0) And (strCodIte[1] = '0') Do
   Delete(strCodIte, 1, 1);

  strQtdIte := MidStr(strCodBar, 12, 05);

  Result := Result And (Length(strQtdIte) = 5);

  If Result Then
  Begin
    fltQtdIte := fStrToFloat(strQtdIte);
    Result    := fltQtdIte > 0;
  End;

End;

function TIteBar.fLerCodigoBarrasUnidades(strCodBar: String; var strCodIte,
  strCodGru: String; var fltQtdIte: Double): Boolean;
  Var
    strQtdIte: String;
begin
  Result    := True;

  strCodGru := MidStr(strCodBar, 01, 06);
  strCodIte := MidStr(strCodBar, 08, 05);
  strQtdIte := MidStr(strCodBar, 13, 06);

  Result := Result And (Not fEmptyStr(fRetNomProduto(strCodIte)));
  Result := Result And (Not fEmptyStr(fRetNomeSoGrupo(strCodGru)));
  Result := Result And (Length(strQtdIte) = 6);

  If Result Then
  Begin
    Insert(FormatSettings.DecimalSeparator, strQtdIte, 5);
    fltQtdIte := fStrToFloat(strQtdIte);
    Result    := fltQtdIte > 0;
  End;

end;

Function TIteBar.fGeraCodBarAuto(fltEmbala: Double): String;
  Var
    strItem,
    strGrupo: String;
Begin
  If Assigned(qryTabIte) Then
  With qryTabIte Do
  Begin
    strGrupo := FieldByName('ITE_CODGRU').AsString;
    strItem  := FieldByName('ITE_CODITE').AsString;
  End
  Else
  Begin
    strGrupo := fRetGrupoItem(strCodIte);
    strItem  := strCodIte;
  End;

  If fCfgSis('TIPBAR') = '2' Then
    Result := strGrupo + strItem + fStrZero(AnsiReplaceStr(FormatFloat('#0.00', fltEmbala), '.', ''), 6)
  Else
    Result := fGeraCodBarraEAN13('1' + strItem + RightStr(fStrZero(AnsiReplaceStr(FormatFloat('#0.00', fltEmbala), '.', ''), 6), 6));
End;

procedure TIteBar.pImprimeEtiquetaUnidadesRestante(arrItens: TArrItensEtiqUnRestante;
                                                   opcEtique: TOpcaoEtiqueta;
                                                   strNumDoc: String = '';
                                                   strEspDoc: String = '';
                                                   strCodEmp: String = '';
                                                   strCodCon: String = '';
                                                   intQuaEti: Integer = 1;
                                                   blnImprime: Boolean = True;
                                                   blnCadEmb: Boolean = False;
                                                   strCodCli: String = '');
  Var
    qryCadIte: TUniQuery;
    qryCfgRel: TUniQuery;
    cdsDados : TUniClientDataSet;
    prmDllEtq: TParamDllEtiquetas;
    intContador: Integer;
    strOrdPdv : String;

  procedure pCriarDataSet;
  begin
    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODITE';
      DataType := ftString;
      Size := 05;
    End;

    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESITE';
      DataType := ftString;
      Size := 60;
    End;

    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESMAR';
      DataType := ftString;
      Size := 60;
    End;

    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := 'REFERE';
      DataType := ftString;
      Size := 20;
    End;

    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODBAR';
      DataType := ftString;
      Size := 20;
    End;

    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := 'NOMOPE';
      DataType := ftString;
      Size := 30;
    End;

    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := 'QTDITE';
      DataType  := ftFloat;
      Precision := 2;
    End;

    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := 'LOCFIS';
      DataType := ftString;
      Size := 10;
    End;

    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := 'SIGUNI';
      DataType := ftString;
      Size := 05;
    End;

    With cdsDados.FieldDefs.AddFieldDef Do
    Begin
      Name := 'AUTINC';
      DataType := ftString;
      Size := 20;
    End;

    cdsDados.CreateDataSet;
  end;

  procedure pAddRegistro(strCodIte,
                         strDescri,
                         strDesmar,
                         strRefere,
                         strCodBar,
                         strSigUni,
                         strLocFis: String;
                         fltQtdIte: Double;
                         strAutInc: String);
  begin
    cdsDados.Append;
    cdsDados.FieldByName('CODITE').AsString := strCodIte;
    cdsDados.FieldByName('DESITE').AsString := strDescri;
    cdsDados.FieldByName('DESMAR').AsString := strDesmar;
    cdsDados.FieldByName('REFERE').AsString := strRefere;
    cdsDados.FieldByName('CODBAR').AsString := strCodBar;
    cdsDados.FieldByName('NOMOPE').AsString := fRetNomeOperador(strLoginUsuarioLogado);
    cdsDados.FieldByName('QTDITE').AsFloat  := fltQtdIte;
    cdsDados.FieldByName('LOCFIS').AsString := strLocFis;
    cdsDados.FieldByName('SIGUNI').AsString := strSigUni;
    cdsDados.FieldByName('AUTINC').AsString := strAutInc;
    cdsDados.Post;
  end;

  function fAbreCadIte: Boolean;
  Begin
    With qryCadIte, SQL Do
    Begin
      Clear;
      Add('SELECT');
      Add('  C.ITE_CODGRU AS CODGRU,');
      Add('  C.ITE_DESITE AS DESITE,');
      Add('  M.MAR_DESMAR AS DESMAR,');
      Add('  C.ITE_REFERE AS REFERE,');
      Add('    UNI_SIGUNI AS SIGUNI,');
      Add('  I.ITE_LOCFIS AS LOCFIS ');
      Add('FROM');
      Add('  CADITE C');

      Add('INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE AND');
      Add('                       I.ITE_CODEMP = :CODEMP         ');

      Add('INNER JOIN CADUNI ON UNI_CODUNI = C.ITE_CODUNI        ');
      Add('      JOIN CADMAR M ON M.MAR_CODMAR = C.ITE_CODMAR ');

      Add('WHERE C.ITE_CODITE = :CODITE ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      Result := Not IsEmpty;

      If Not Result Then
        pMensagemOk('Item ' + strCodIte + ' não econtrado!');
    End;
  End;

  procedure pVerificaCadastraEmbalagem;
    Var
      qryCad: TUniQuery;
      blnCadastrar: Boolean;
  Begin
    qryCad := fCriaQuery;
    blnCadastrar := False;
    
    With qryCad, SQL Do
    Begin
      Add('SELECT');
      Add('  *');
      Add('FROM');
      Add('  ITEBAR');
      Add('WHERE');
      Add('  BAR_CODBAR = :CODBAR AND');
      Add('  BAR_CODITE = :CODITE');
    End;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      qryCad.Close;
      qryCad.ParamByName('CODBAR').AsString := cdsDados.FieldByName('CODBAR').AsString;
      qryCad.ParamByName('CODITE').AsString := cdsDados.FieldByName('CODITE').AsString;
      qryCad.Open;

      If qryCad.IsEmpty Then
      Begin
        blnCadastrar := True;
        Break;
      End;
      
      cdsDados.Next;
    End;

    If (blnCadastrar) and (fMensagem('', 'Deseja cadastrar a(s) embalagem(s) automaticamente?', ['&Sim', '&Não']) = 1) Then
    Begin
      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin
        With qryCad Do
        Begin
          Close;
          ParamByName('CODBAR').AsString := cdsDados.FieldByName('CODBAR').AsString;
          ParamByName('CODITE').AsString := cdsDados.FieldByName('CODITE').AsString;
          Open;

          If IsEmpty Then
          Begin
            Append;
            FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ITEBAR', VS_strCodEmp);
            FieldByName('BAR_CODITE').AsString  := cdsDados.FieldByName('CODITE').AsString;
            FieldByName('BAR_CODBAR').AsString  := cdsDados.FieldByName('CODBAR').AsString;
            FieldByName('BAR_CODEMP').AsString  := VS_strCodEmp;
            FieldByName('BAR_PRINCI').AsInteger := 0;
            FieldByName('BAR_COMPRA').AsInteger := 0;
            FieldByName('BAR_EMBALA').AsFloat   := cdsDados.FieldByName('QTDITE').AsFloat;
            FieldByName('BAR_EXBFAT').AsString  := 'N';
            Post;
          End;
        End;
        
        cdsDados.Next;
      End;
    End;
    
    FreeAndNil(qryCad);
  End;

begin

  Try
    cdsDados := TUniClientDataSet.Create(nil);
    pCriarDataSet;
    qryCadIte := fCriaQuery;

    For intContador := 0 To Length(arrItens) -1 Do
    Begin
      strCodIte := arrItens[intContador].strCodItem;

      If (arrItens[intContador].fltQtdItem <= 0) Then
        Continue;

      If Not fAbreCadIte Then
        Continue;

      With qryCadIte Do
      pAddRegistro(strCodIte,
                   FieldByName('DESITE').AsString,
                   FieldByName('DESMAR').AsString,
                   FieldByName('REFERE').AsString,
                   fGeraCodigoBarrasUnidades(strCodIte, FieldByName('CODGRU').AsString, arrItens[intContador].fltQtdItem),
                   FieldByName('SIGUNI').AsString,
                   FieldByName('LOCFIS').AsString,
                   arrItens[intContador].fltQtdItem,
                   IntToStr(arrItens[intContador].intAutInc));
    End;

    If (Not cdsDados.IsEmpty) Then
    Begin

      strOrdPdv := fCfgSisL('ORDPDV');

      If SameText(strOrdPdv, '1') Then
        cdsDados.IndexFieldNames := 'DESITE'
      Else If SameText(strOrdPdv, '2') Then
        cdsDados.IndexFieldNames := 'SIGUNI;DESITE'
      Else If SameText(strOrdPdv, '3') Then
        cdsDados.IndexFieldNames := 'AUTINC'
      Else
        cdsDados.IndexFieldNames := 'LOCFIS';

      qryCfgRel := fCriaQuery;
      pCarregaConfImpr(qryCfgRel, ETIQUETA_UNIDADES_RESTANTE);

      prmDllEtq := TParamDllEtiquetas.Create;

      With prmDllEtq Do
      Begin
        If (opcEtique = opcFaturamento) Then
          tpeTipEtq := tpeUnidadesRestantesArgoxFat
        Else
          tpeTipEtq := tpeUnidadesRestantesArgoxAvu;

        dtsImpres := cdsDados;
        strNomFil := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
        intNumCop := intQuaEti;
        blnImpEti := blnImprime;
      End;

      prmDllEtq.strNumDoc := ShortString(strNumDoc);
      prmDllEtq.strEspDoc := ShortString(strEspDoc);
      prmDllEtq.strCodEmp := ShortString(strCodEmp);
      prmDllEtq.strCodCon := strCodCon;
      prmDllEtq.strCodCli := strCodCli;

      fImprimeEtiqueta(prmDllEtq, 'fImprimeEtiquetaGeral');

      FreeAndNil(qryCfgRel);
      FreeAndNil(prmDllEtq);
    End;

    If blnCadEmb Then
       pVerificaCadastraEmbalagem;

    FreeAndNil(cdsDados);
    FreeAndNil(qryCadIte);

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pImprimeEtiquetaUnidadesRestante]')
  End;

end;

Procedure TIteBar.IncluiPrincipalParaCompras(strCodIte, strCodBar: String; fltEmbala: Double;
                                             var  blnPrincipal: Boolean);
  Var
    qryInsert: TUniQuery;
    blnInserir: Boolean;
Begin
  blnPrincipal := False;
  blnInserir   := False;
  qryInsert    := fCriaQuery;

  With qryInsert, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM ITEBAR');
    Add('WHERE');
    Add('  BAR_CODITE = :CODITE ');

    ParamByName('CODITE').AsString := strCodIte;

    Open;

    If IsEmpty Then
    Begin
      blnInserir := True;
    End Else
    Begin

      If Locate('BAR_COMPRA', 1, []) Then
      Begin
        Edit;
        FieldByName('BAR_COMPRA').AsInteger := 0;
        Post;
      End;

      If Locate('BAR_CODBAR', strCodBar, []) Then
      Begin
        Edit;
        FieldByName('BAR_COMPRA').AsInteger := 1;
        Post;
      End

      Else blnInserir := True;

    End;

    blnPrincipal := RecordCount = 0;

    If blnInserir Then
    Begin
      qryInsert.Insert;
      FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ITEBAR', VS_strCodEmp);
      FieldByName('BAR_CODEMP').AsString  := VS_strCodEmp;
      FieldByName('BAR_CODITE').AsString  := strCodIte;
      FieldByName('BAR_CODBAR').AsString  := strCodBar;
      FieldByName('BAR_EMBALA').AsFloat   := fltEmbala;
      FieldByName('BAR_COMPRA').AsInteger := 1;
      FieldByName('BAR_PRINCI').AsInteger := IIF(blnPrincipal, 1, 0);
      Post;
    End;

  End;

  FreeAndNil(qryInsert);
End;

{*********************************************
 * VALIDA SE O CÓDIGO DE BARRAS JÁ EXISTE    *
 * E RETORNA EM QUAL ITEM ESTÁ CADASTRADO.   *
 * "strCodIte" UTILIZADA PARA EVITAR A TRAVA *
 *  DURANTE UM EDIT NO CAMPO DE CODIGO BARRA *
 * UM EDIT NO CAMPO DE CODIGO DE BARRA       *
 * SEGUIDO DE NENHUMA ALTERAÇÃO NO CODIGO.   *
 ******************************************MV*}
function fValidaCodBarra(strCodBar, strCodIte: String; Var strItem: String): Boolean;
  Var
    objIteBar: TIteBar;
begin
  Try
    objIteBar := TIteBar.Create(opcFuncoes);

    Result := objIteBar.fValidaCodigoBarras(strCodBar, strCodIte, strItem);

  Finally
    FreeAndNil(objIteBar);
  End;

end;

function fValidaCodBarraEsemelhante(strCodBar, strCodIte: String): Boolean;
  Var
    objIteBar: TIteBar;
Begin
  Try
    objIteBar := TIteBar.Create(opcFuncoes);
    objIteBar.strCodIte := strCodIte;

    Result := objIteBar.fValidaCodBar(strCodBar);
  Finally
    FreeAndNil(objIteBar);
  End;

End;

function TIteBar.fRetFatorPrincipalCompra: Double;
begin
  If cdsItebar.Fields.Count = 0 Then
    Exit(0);
  cdsItebar.Filtered := False;
  cdsIteBar.Filter   := 'BAR_COMPRA = 1';
  cdsIteBar.Filtered := True;
  Result := cdsIteBar.FieldByName('BAR_EMBALA').AsFloat;
  cdsItebar.Filtered := False;
  cdsIteBar.Filter   := '';
end;

Class Function TIteBar.fRetEmbalagemFornecedor(strCodIte, strCodFor: String): Double;
var qryConsulta: TUniQuery;
Begin
  Result := 0;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT BAR_EMBALA');
    qryConsulta.SQL.Add('  FROM ITEBAR');
    qryConsulta.SQL.Add(' WHERE BAR_CODITE = :CODITE');
    qryConsulta.SQL.Add('   AND BAR_CODFOR = :CODFOR');
    qryConsulta.SQL.Add(' ORDER BY BAR_COMPRA DESC');
    qryConsulta.SQL.Add(' LIMIT 1');

    qryConsulta.ParamByName('CODITE').AsString := strCodIte;
    qryConsulta.ParamByName('CODFOR').AsString := strCodFor;

    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
      Result := qryConsulta.FieldByName('BAR_EMBALA').AsFloat;

  Finally
    FreeAndNil(qryConsulta);
  End
End;


end.
