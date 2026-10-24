unit untMapeiaParametros;

interface

uses
  Classes, SysUtils, Variants,
  untTypesSistema,
  Controls, StdCtrls, StrUtils,
  UniClientDataSet, UniDataSetProvider,
  BitBtnLockedIncrem,
  Uni, DB, untFuncoesSimples,
  untFuncoesRel,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  untZClient,
  Forms,
  untFuncoesGenerica;

Type
  TMapeiaParametros = Class(TZClient)
  Private
    FGrupoChamada: TGrupoChamada;

    FSaveData: TUniClientDataSet;

    Function fSQLDados: String;
    Function fSQLTipoAtribuicao: String;
    Function fSQLParametrosRelatorio: String;

    Procedure pCriaCdsTipoAtribuicao;

    Procedure pCompletaParametros;

    Procedure pBeforePostMapeia(dtsDados: TDataset);
    Procedure pAfterScrollMapeia(dtsDados: TDataset);

    Function fVeSeTrava(strMensagem: String; blnTravar: Boolean): Boolean;

  Public

    cdsTipoAtribuicao: TZClient;

    objRotinasGrid: Pointer;

    constructor Create(Owner: TComponent; AGrupoChamada: TGrupoChamada);  Reintroduce;
    Destructor Destroy; override;

    Function fCarregaMapeiaParametros(strSeqGer: String): Boolean;
    Function fSalvaMapeiaParametros(strSeqGer: String): Boolean;

    Function fIncluiParametrosRelatorio(strSeqRel: String): Boolean;
    Function fIncluiParametrosRotina(strNomRot: String): Boolean;
    Function fExcluiParametrosRelatorio(strSeqRel: String): Boolean;
    Function fExcluiParametrosRotina(strNomRot: String): Boolean;

    Procedure pFiltraParametros(strNomRot, strSeqRel: String; blnApenasMapeados: Boolean);

    Function fValidaMapeamento(blnTravar: Boolean = True): Boolean;

   // Function fValidaMapeamentoRotina(strNomRot: String; dtsDados: TDataSet): Boolean;

    Procedure pSalvaDados;
    Procedure pRestauraDados;

    Function fLocalizaParametroRotina(strNomRot, strNomPar: String): Boolean;

  End;

implementation

Uses
  untConstantes,
  untRotinasGrid,
  untInterfaceRelatorio;

constructor TMapeiaParametros.Create(Owner: TComponent; AGrupoChamada: TGrupoChamada);
Begin
  FGrupoChamada := AGrupoChamada;
  Inherited Create(Owner, fSQLDados);

  FSaveData := TUniClientDataSet.Create(Self);

  objRotinasGrid := Nil;

  pCriaCdsTipoAtribuicao;
End;

Destructor TMapeiaParametros.Destroy;
Begin
  Inherited;

End;

Function TMapeiaParametros.fSQLTipoAtribuicao: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ' +  IntToStr(INT_SEM_ATRIBUICAO) + ' AS TIPATR, "Nenhum" AS DESATR ';
  strSQL := strSQL + ' UNION ALL ';
  strSQL := strSQL + ' SELECT ' +  IntToStr(INT_PARAMETRO ) + ' AS TIPATR, "Parâmetro" AS DESATR ';
  strSQL := strSQL + ' UNION ALL ';
  strSQL := strSQL + ' SELECT ' +  IntToStr(INT_CONSTANTE) + ' AS TIPATR, "Valor" AS DESATR ';

  If FGrupoChamada = tpcGrid Then
  Begin
    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + ' SELECT ' +  IntToStr(INT_CAMPO) + ' AS TIPATR, "Campo" AS DESATR ';
  End;

  Result := strSQL;
End;

Procedure TMapeiaParametros.pCriaCdsTipoAtribuicao;
Begin
  cdsTipoAtribuicao := TZClient.Create(Self, fSQLTipoAtribuicao);
  cdsTipoAtribuicao.fLeDados('TMapeiaParametros.pCriaCdsTipoAtribuicao');
End;

Function TMapeiaParametros.fSQLDados: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT     ';
  strSQL := strSQL + '   R.*,     ';
  strSQL := strSQL + '   C.PAR_DESPAR AS DESPAR, ';
  strSQL := strSQL + '   C.PAR_NOMPAR            ';
  strSQL := strSQL + ' FROM       ';
  strSQL := strSQL + '   RELMAP R ';

  strSQL := strSQL + ' LEFT JOIN CADPRR C ON C.PAR_SEQGER = R.MAP_SEQREL AND C.PAR_NOMPAR = R.MAP_NOMPAR ';

  strSQL := strSQL + ' WHERE      ';
  strSQL := strSQL + '   MAP_SEQGER = :SEQGER ';

  If FGrupoChamada = tpcTelaFiltros Then
    strSQL := strSQL + '   AND MAP_GRUCHA = ' + IntToStr(INT_GRUPO_FILTROS)
  Else
    strSQL := strSQL + '   AND MAP_GRUCHA = ' + IntToStr(INT_GRUPO_GRID);

  Result := strSQL;
End;

Function TMapeiaParametros.fCarregaMapeiaParametros(strSeqGer: String): Boolean;
Begin
  Self.DisableControls;

  Self.qryQuery.ParamByName('SEQGER').AsString := strSeqGer;
  Result := Self.fLeDados('TMapeiaParametros.fCarregaMapeiaParametros');

  // EXCLUI PARÂMETROS QUE NÃO EXISTEM MAIS NO RELATÓRIO "FILHO"
  Self.Filter := 'PAR_NOMPAR IS NULL AND MAP_SEQREL IS NOT NULL';
  Self.Filtered := True;
  Self.First;
  While Not Self.Eof Do
    Self.Delete;

  // EXCLUI PARÂMETROS QUE NÃO EXISTEM MAIS NA ROTINA"
  If Assigned(objRotinasGrid) Then
  Begin
    Self.Filter := 'MAP_NOMROT IS NOT NULL';
    Self.First;
    While Not Self.Eof Do
      If TRotinasGrid(objRotinasGrid).fExisteParametro(Self.FieldByName('MAP_NOMROT').AsString,
                                                       Self.FieldByName('MAP_NOMPAR').AsString) Then
      Begin
        Self.Edit;
        Self.FieldByName('DESPAR').AsString := TRotinasGrid(objRotinasGrid).cdsParametrosRotinas.FieldByName('DESPAR').AsString;
        Self.Post;
        Self.Next;
      End Else
        Self.Delete;
  End;

  Self.Filtered := False;
  Self.Filter := '';

  pCompletaParametros;

  Self.AfterScroll := pAfterScrollMapeia;
  Self.BeforePost  := pBeforePostMapeia;

  Self.EnableControls;
End;

Procedure TMapeiaParametros.pCompletaParametros;
Begin
  If Not Assigned(objRotinasGrid) Then
    Exit;

  TRotinasGrid(objRotinasGrid).cdsRotinasRelatorio.First;
  While Not TRotinasGrid(objRotinasGrid).cdsRotinasRelatorio.Eof Do
  Begin
    If (Not fEmptyStr(TRotinasGrid(objRotinasGrid).cdsRotinasRelatorio.FieldByName('ROT_NOMROT').AsString)) Then
      fIncluiParametrosRotina(TRotinasGrid(objRotinasGrid).cdsRotinasRelatorio.FieldByName('ROT_NOMROT').AsString);

    If (Not fEmptyStr(TRotinasGrid(objRotinasGrid).cdsRotinasRelatorio.FieldByName('ROT_SEQREL').AsString)) Then
      fIncluiParametrosRelatorio(TRotinasGrid(objRotinasGrid).cdsRotinasRelatorio.FieldByName('ROT_SEQREL').AsString);

    TRotinasGrid(objRotinasGrid).cdsRotinasRelatorio.Next;
  End;
End;

Function TMapeiaParametros.fSalvaMapeiaParametros(strSeqGer: String): Boolean;
Begin
  Self.DisableControls;
  Self.First;
  While Not Self.Eof Do
  Begin
    If fEmptyStr(Self.FieldByName('MAP_SEQGER').AsString) Then
    Begin
      Self.Edit;
      Self.FieldByName('MAP_SEQGER').AsString := strSeqGer;
      Self.Post;
    End;

    Self.Next;
  End;

  Result := Self.fSalva;
  Self.EnableControls;
End;

Function TMapeiaParametros.fSQLParametrosRelatorio: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT         ';
  strSQL := strSQL + '   PAR_NOMPAR,  ';
  strSQL := strSQL + '   PAR_DESPAR   ';
  strSQL := strSQL + ' FROM           ';
  strSQL := strSQL + '   CADPRR       ';
  strSQL := strSQL + ' WHERE          ';
  strSQL := strSQL + '   PAR_SEQGER = :SEQREL ';

  Result := strSQL;
End;

Function TMapeiaParametros.fIncluiParametrosRelatorio(strSeqRel: String): Boolean;
  Var
    qryDados: TUniQuery;
Begin
  qryDados := fCriaQuery;
  qryDados.SQL.Text := fSQLParametrosRelatorio;
  qryDados.ParamByName('SEQREL').AsString := strSeqRel;
  qryDados.Open;

  Self.IndexFieldNames := 'MAP_SEQREL;MAP_NOMPAR';

  While Not qryDados.Eof Do
  Begin
    If Not Self.FindKey([strSeqRel, qryDados.FieldByName('PAR_NOMPAR').AsString]) Then
    Begin
      Self.Append;
      Self.FieldByName('MAP_SEQREL').AsString := strSeqRel;
      Self.FieldByName('MAP_NOMPAR').AsString := qryDados.FieldByName('PAR_NOMPAR').AsString;
      Self.FieldByName('DESPAR').AsString     := qryDados.FieldByName('PAR_DESPAR').AsString;
      Self.FieldByName('MAP_EXIBIR').AsString := 'S';
      Self.FieldByName('MAP_EDITAV').AsString := 'S';
      Self.FieldByName('MAP_TIPATR').AsInteger := INT_SEM_ATRIBUICAO;

      Case FGrupoChamada Of
        tpcTelaFiltros: Self.FieldByName('MAP_GRUCHA').AsInteger := INT_GRUPO_FILTROS;
        tpcGrid       : Self.FieldByName('MAP_GRUCHA').AsInteger := INT_GRUPO_GRID;
      End;

      Self.Post;
    End;

    qryDados.Next;
  End;

  FreeAndNil(qryDados);

  Result := True;
End;

Function TMapeiaParametros.fIncluiParametrosRotina (strNomRot: String): Boolean;
Begin
  Result := False;

  If Not Assigned(objRotinasGrid) Then
    Exit;

  TRotinasGrid(objRotinasGrid).cdsParametrosRotinas.Filter := 'NOMROT = ' + QuotedStr(strNomRot);
  TRotinasGrid(objRotinasGrid).cdsParametrosRotinas.Filtered := True;
  TRotinasGrid(objRotinasGrid).cdsParametrosRotinas.First;

  Self.IndexFieldNames := 'MAP_NOMROT;MAP_NOMPAR';

  While Not TRotinasGrid(objRotinasGrid).cdsParametrosRotinas.Eof Do
  Begin
    If Not Self.FindKey([strNomRot, TRotinasGrid(objRotinasGrid).cdsParametrosRotinas.FieldByName('NOMPAR').AsString]) Then
    Begin
      Self.Append;
      Self.FieldByName('MAP_NOMROT').AsString := strNomRot;
      Self.FieldByName('MAP_NOMPAR').AsString := TRotinasGrid(objRotinasGrid).cdsParametrosRotinas.FieldByName('NOMPAR').AsString;
      Self.FieldByName('DESPAR').AsString     := TRotinasGrid(objRotinasGrid).cdsParametrosRotinas.FieldByName('DESPAR').AsString;
      Self.FieldByName('MAP_EXIBIR').AsString := 'N';
      Self.FieldByName('MAP_EDITAV').AsString := 'N';
      Self.FieldByName('MAP_TIPATR').AsInteger := INT_SEM_ATRIBUICAO;

      Case FGrupoChamada Of
        tpcTelaFiltros: Self.FieldByName('MAP_GRUCHA').AsInteger := INT_GRUPO_FILTROS;
        tpcGrid       : Self.FieldByName('MAP_GRUCHA').AsInteger := INT_GRUPO_GRID;
      End;

      Self.Post;
    End;

    TRotinasGrid(objRotinasGrid).cdsParametrosRotinas.Next;
  End;

  TRotinasGrid(objRotinasGrid).cdsParametrosRotinas.Filtered := False;

  Result := True;
End;

Function TMapeiaParametros.fExcluiParametrosRelatorio(strSeqRel: String): Boolean;
Begin
  Self.DisableControls;
  Self.Filter := Concat('MAP_SEQREL = ', QuotedStr(strSeqRel));
  Self.Filtered := True;

  While Not Self.Eof Do
    Self.Delete;

  Self.Filtered := False;
  Self.EnableControls;

  Result := True;
End;

Function TMapeiaParametros.fExcluiParametrosRotina(strNomRot: String): Boolean;
Begin
  Self.DisableControls;

  Self.Filter := Concat('MAP_NOMROT = ', QuotedStr(strNomRot));
  Self.Filtered := True;

  While Not Self.Eof Do
    Self.Delete;

  Self.Filtered := False;
  Self.EnableControls;

  Result := True;
End;

Procedure TMapeiaParametros.pFiltraParametros(strNomRot, strSeqRel: String; blnApenasMapeados: Boolean);
Begin
  If strNomRot.IsEmpty Then
    Self.Filter := Concat('MAP_SEQREL = ', QuotedStr(strSeqRel), IIF(blnApenasMapeados, ' AND MAP_TIPATR <> 1', ''))
  Else
    Self.Filter := Concat('MAP_NOMROT = ', QuotedStr(strNomRot), IIF(blnApenasMapeados, ' AND MAP_TIPATR <> 1', ''));

  Self.Filtered := True;
  Self.First;
End;

Procedure TMapeiaParametros.pBeforePostMapeia(dtsDados: TDataset);
Begin
  dtsDados.FieldByName('MAP_PARPAI').ReadOnly := False;
  dtsDados.FieldByName('MAP_VALORC').ReadOnly := False;
  dtsDados.FieldByName('MAP_NOMCAM').ReadOnly := False;

  If dtsDados.FieldByName('MAP_TIPATR').AsInteger <> INT_PARAMETRO Then
    dtsDados.FieldByName('MAP_PARPAI').Clear;

  If dtsDados.FieldByName('MAP_TIPATR').AsInteger <> INT_CONSTANTE Then
    dtsDados.FieldByName('MAP_VALORC').Clear;

  If dtsDados.FieldByName('MAP_TIPATR').AsInteger <> INT_CAMPO Then
    dtsDados.FieldByName('MAP_NOMCAM').Clear;

  pAfterScrollMapeia(dtsDados);
End;

Procedure TMapeiaParametros.pAfterScrollMapeia(dtsDados: TDataset);
Begin
  dtsDados.FieldByName('MAP_PARPAI').ReadOnly :=
    dtsDados.FieldByName('MAP_TIPATR').AsInteger <> INT_PARAMETRO;

  dtsDados.FieldByName('MAP_VALORC').ReadOnly :=
    dtsDados.FieldByName('MAP_TIPATR').AsInteger <> INT_CONSTANTE;

  dtsDados.FieldByName('MAP_NOMCAM').ReadOnly :=
    dtsDados.FieldByName('MAP_TIPATR').AsInteger <> INT_CAMPO;
End;

Function TMapeiaParametros.fVeSeTrava(strMensagem: String; blnTravar: Boolean): Boolean;
Begin
  If blnTravar Then
  Begin
    Result := False;
    pMensagemOk(strMensagem);
  End Else
  begin
    Result := fPergunta(strMensagem + #13#10 + 'Deseja continuar?');
  End;
End;

Function TMapeiaParametros.fValidaMapeamento(blnTravar: Boolean = True): Boolean;
  Var
    objInterface: TInterfaceRelatorio;
Begin
  Result := True;
  Self.DisableControls;

  objInterface := TInterfaceRelatorio(TRotinasGrid(objRotinasGrid).objInteface);
  objInterface.cdsCampos.DisableControls;
  objInterface.cdsParams.DisableControls;

  Try
    Self.First;
    While Not Self.Eof Do
    Begin
      Case Self.FieldByName('MAP_TIPATR').AsInteger Of
        INT_SEM_ATRIBUICAO: If Not fEmptyStr(Self.FieldByName('MAP_NOMROT').AsString) Then
                            Begin
                              Result := fVeSeTrava('Todos os parâmetros da rotina precisa ser mapeados!', blnTravar);
                              Exit;
                            End;

        INT_PARAMETRO: If fEmptyStr(Self.FieldByName('MAP_PARPAI').AsString) Then
                       Begin
                         Result := fVeSeTrava('Informe o nome do parâmetro pai para o parâmetro ' + Self.FieldByName('MAP_NOMPAR').AsString + '!', blnTravar);
                         Exit;
                       End
                       Else If (Not objInterface.cdsParams.Locate('PAR_NOMPAR', Self.FieldByName('MAP_PARPAI').AsString, [])) Then
                       Begin
                         Result := fVeSeTrava('Parâmetro pai ' + Self.FieldByName('MAP_PARPAI').AsString + ' não encontrado!', blnTravar);
                         Exit;
                       End;

        INT_CAMPO    : If fEmptyStr(Self.FieldByName('MAP_NOMCAM').AsString) Then
                       Begin
                         Result := fVeSeTrava('Informe o nome do campo pai para o parâmetro ' + Self.FieldByName('MAP_NOMPAR').AsString + '!', blnTravar);
                         Exit;
                       End
                       Else If (Not objInterface.cdsCampos.Locate('CAM_NOMCAM', Self.FieldByName('MAP_NOMCAM').AsString, [])) Then
                       Begin
                         Result := fVeSeTrava('Campo pai ' + Self.FieldByName('MAP_NOMCAM').AsString + ' não encontrado!', blnTravar);
                         Exit;
                       End;
      End;

      Self.Next;
    End;

  Finally
    objInterface.cdsCampos.EnableControls;
    objInterface.cdsParams.EnableControls;
    Self.EnableControls;
  End;
End;

(*
Function TMapeiaParametros.fValidaMapeamentoRotina(strNomRot: String; dtsDados: TDataSet): Boolean;
  Var
    objInterface: TInterfaceRelatorio;
Begin
  Result := False;
  Self.DisableControls;

  objInterface := TInterfaceRelatorio(TRotinasGrid(objRotinasGrid).objInteface);
  objInterface.cdsCampos.DisableControls;
  objInterface.cdsParams.DisableControls;

  TRotinasGrid(objRotinasGrid).pFiltraParametrosRotina(strNomRot);

  Try
    TRotinasGrid(objRotinasGrid).cdsRotinasRelatorio.First;

    While Not TRotinasGrid(objRotinasGrid).cdsRotinasRelatorio.Eof Do
    Begin
      If Self.Locate('MAP_NOMROT;MAP_NOMPAR', VarArrayOf([strNomRot, TRotinasGrid(objRotinasGrid).cdsRotinasRelatorio.FieldByName('NOMPAR').AsString]), []) Then
      Begin

      End Else
      Begin
        pMensagemOk('');
        Result := False;
        Exit;
      End;

      TRotinasGrid(objRotinasGrid).cdsRotinasRelatorio.Next;
    End;

  Finally
    objInterface.cdsCampos.EnableControls;
    objInterface.cdsParams.EnableControls;
    Self.EnableControls;

    TRotinasGrid(objRotinasGrid).cdsRotinasRelatorio.filtered := False;
  End;
End;
*)

Procedure TMapeiaParametros.pSalvaDados;
Begin
  FSaveData.Data := Self.Data;
End;

Procedure TMapeiaParametros.pRestauraDados;
Begin
  Self.Data := FSaveData.Data;
  Self.pSetProvider;
End;

Function TMapeiaParametros.fLocalizaParametroRotina(strNomRot, strNomPar: String): Boolean;
Begin
  Result := Self.Locate('MAP_NOMROT;MAP_NOMPAR', VarArrayOf([strNomRot, strNomPar]), []);
End;

end.
