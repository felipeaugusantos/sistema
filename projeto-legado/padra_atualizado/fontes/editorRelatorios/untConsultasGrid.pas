unit untConsultasGrid;

interface

uses
  Classes, SysUtils, Variants,
  untTypesSistema,
  Controls, StdCtrls, StrUtils,
  UniClientDataSet, UniDataSetProvider,
  BitBtnLockedIncrem,
  cxGridDBBandedTableView,
  Uni, DB, untFuncoesSimples,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  untZClient,
  Forms,
  untConsultasRel,
  untFuncoesRel,
  untFuncoesGenerica;

Type
  TConsultasGrid = Class(TZClient)
  Private
    FMultiSelecao: Boolean;

    Function fSQLListaConsultas: String;
    Function fSQLConsultaGrid: String;

    function fGetValorCampo(strNomCam: String): String;
    function fGetValorParametroFiltro(strNomPar: String; blnMultiSelecaoQuoted: Boolean): String;

  Public
    objConsulta: TConsultasRel;

    objInteface: Pointer;

    cdsDadosCorrente: TDataSet;

    cdsConsultasGrid: TZClient;

    constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; override;

    Function fCarregaListaConsultas: Boolean;

    Class Function fPesquisaToString(enuPesquisa:  TPesquisas): String;
    Class Function fPesquisaToEnum(strPesquisa: String): TPesquisas;

    Function fCarregaDados(strSeqGer: String; cdsCampos: TZClient; blnExecutandoPeloMenu: Boolean): Boolean;
    Function fSalvaDados(strSeqGer: String): Boolean;

    Function fIncluiFiltros(strNomCam, strNomCon: String): Boolean;

    Procedure pFiltraConsulta(strNomCam: String);

    Function fRetValorParametro(strNomPar: String): String;

    Function fValidaParametros(cdsCampos, cdsParams: TZClient): Boolean;

  End;

implementation

Uses
  TypInfo,
  untConstantes,
  untInterfaceRelatorio;

constructor TConsultasGrid.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLListaConsultas);

  Self.IndexFieldNames := 'codigo';

  cdsConsultasGrid := TZClient.Create(Self, fSQLConsultaGrid);
End;

Destructor TConsultasGrid.Destroy;
Begin
  Inherited;

End;

Function TConsultasGrid.fSQLListaConsultas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                                 ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(100)) AS codigo,   ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(100)) AS descricao ';
  Result := strSQL;
End;

Class Function TConsultasGrid.fPesquisaToString(enuPesquisa: TPesquisas): String;
Begin
  Result := GetEnumName(TypeInfo(TPesquisas), Integer(enuPesquisa));
End;

Class Function TConsultasGrid.fPesquisaToEnum(strPesquisa: String): TPesquisas;
Begin
  Result := TPesquisas(GetEnumValue(TypeInfo(TPesquisas), strPesquisa));
End;

Function TConsultasGrid.fCarregaListaConsultas: Boolean;
  Var
    enuContador:  TPesquisas;
Begin
  Result := Self.fLeDados('TConsultasGrid.fCarregaListaConsultas');

  Self.EmptyDataSet;

  For enuContador := Succ(Low(TPesquisas)) To High(TPesquisas) Do
  Begin
    Self.Append;
    Self.FieldByName('codigo').AsString := fPesquisaToString(enuContador);
    Self.FieldByName('descricao').AsString := ArrDescPesquisa[enuContador];
    Self.Post;
  End;

End;

Function TConsultasGrid.fSQLConsultaGrid: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                                 ';
  strSQL := strSQL + '   C.*,                                 ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(100)) AS NOMFIL    ';
  strSQL := strSQL + ' FROM                                   ';
  strSQL := strSQL + '   CAMMAP C                             ';
  strSQL := strSQL + ' WHERE                                  ';
  strSQL := strSQL + '   MAP_SEQGER = :SEQGER                 ';
  Result := strSQL;
End;

Function TConsultasGrid.fCarregaDados(strSeqGer: String; cdsCampos: TZClient; blnExecutandoPeloMenu: Boolean): Boolean;
Begin
  cdsConsultasGrid.qryQuery.ParamByName('SEQGER').AsString := strSeqGer;
  Result := cdsConsultasGrid.fLeDados('TConsultasGrid.fCarregaConsultasGrid');

  If blnExecutandoPeloMenu Then
    Exit;

  cdsConsultasGrid.First;

  While Not cdsConsultasGrid.Eof Do
  Begin

    If cdsCampos.Locate('CAM_NOMCAM', cdsConsultasGrid.FieldByName('MAP_NOMCAM').AsString, []) Then
    Begin
      cdsConsultasGrid.Edit;

      If objConsulta.cdsListaFiltros.Locate('TIPPES;CODFIL',
           VarArrayOf([Ord(fPesquisaToEnum(cdsCampos.FieldByName('CAM_PESGRI').AsString)),
                     cdsConsultasGrid.FieldByName('MAP_NOMPAR').AsString]), []) Then
        cdsConsultasGrid.FieldByName('NOMFIL').AsString := objConsulta.cdsListaFiltros.FieldByName('NOMFIL').AsString;

      cdsConsultasGrid.Post;
    End;

    cdsConsultasGrid.Next;
  End;

End;

Procedure TConsultasGrid.pFiltraConsulta(strNomCam: String);
Begin
  cdsConsultasGrid.Filter := 'MAP_NOMCAM = ' + QuotedStr(strNomCam);
  cdsConsultasGrid.Filtered := True;
End;

Function TConsultasGrid.fIncluiFiltros(strNomCam, strNomCon: String): Boolean;
Begin
  pFiltraConsulta(strNomCam);

  objConsulta.cdsListaFiltros.Filter   := 'TIPPES = ' + IntToStr(Ord(fPesquisaToEnum(strNomCon)));
  objConsulta.cdsListaFiltros.Filtered := True;
  objConsulta.cdsListaFiltros.First;

  While Not objConsulta.cdsListaFiltros.Eof Do
  Begin
    If Not cdsConsultasGrid.Locate('MAP_NOMPAR', objConsulta.cdsListaFiltros.FieldByName('CODFIL').AsString, []) Then
    Begin
      cdsConsultasGrid.Append;
      cdsConsultasGrid.FieldByName('MAP_TIPPAR').AsInteger := INT_SEM_ATRIBUICAO;
      cdsConsultasGrid.FieldByName('MAP_NOMCAM').AsString  := strNomCam;
      cdsConsultasGrid.FieldByName('MAP_NOMPAR').AsString  := objConsulta.cdsListaFiltros.FieldByName('CODFIL').AsString;
      cdsConsultasGrid.FieldByName('NOMFIL').AsString      := objConsulta.cdsListaFiltros.FieldByName('NOMFIL').AsString;
      cdsConsultasGrid.Post;
    End;

    objConsulta.cdsListaFiltros.Next;
  End;

  cdsConsultasGrid.First;
  While Not cdsConsultasGrid.Eof Do
  Begin
    If objConsulta.cdsListaFiltros.Locate('CODFIL', cdsConsultasGrid.FieldByName('MAP_NOMPAR').AsString, []) Then
      cdsConsultasGrid.Next
    Else
      cdsConsultasGrid.Delete;
  End;

  Result := True;
End;

Function TConsultasGrid.fSalvaDados(strSeqGer: String): Boolean;
Begin
  cdsConsultasGrid.DisableControls;
  cdsConsultasGrid.Filtered := False;

  cdsConsultasGrid.First;

  While Not cdsConsultasGrid.Eof Do
  Begin
    If fEmptyStr(cdsConsultasGrid.FieldByName('MAP_SEQGER').AsString) Then
    Begin
      cdsConsultasGrid.Edit;
      cdsConsultasGrid.FieldByName('MAP_SEQGER').AsString := strSeqGer;
      cdsConsultasGrid.Post;
    End;

    cdsConsultasGrid.Next;
  End;

  Result := cdsConsultasGrid.fSalva;

  cdsConsultasGrid.EnableControls;
End;

function TConsultasGrid.fGetValorCampo(strNomCam: String): String;
Begin
  If Not Assigned(cdsDadosCorrente.FindField(strNomCam)) Then
    Raise ExceptionAutcom.Create('Erro de configuração do relatório.' + #13#10 +
                                 'Campo ' + strNomCam + ' não econtrado.'  + #13#10 +
                                 'Entre em contato com a Citel!');

  Result := cdsDadosCorrente.FieldByName(strNomCam).AsString;
End;

function TConsultasGrid.fGetValorParametroFiltro(strNomPar: String; blnMultiSelecaoQuoted: Boolean): String;
  Var
    strValPar: String;
    blnAchou: Boolean;
Begin
  strValPar := '';
  blnAchou := False;

  If Assigned(objInteface) Then
    strValPar := TInterfaceRelatorio(objInteface).fGetValorParametroRotinasGrid(strNomPar, blnAchou, FMultiSelecao,
                   True{blnTiraMascara}, True{blnMesmoInvisivel});

  If blnAchou Then
  Begin
    If FMultiSelecao And (Not blnMultiSelecaoQuoted) Then
      strValPar := AnsiReplaceStr(AnsiReplaceStr(strValPar, '''', ''), ', ', ',');

  End Else
  Begin
    Raise ExceptionAutcom.Create('Erro de configuração do relatório.' + #13#10 +
                                 'Parâmetro ' + strNomPar + ' não econtrado.'  + #13#10 +
                                 'Entre em contato com a Citel!');
  End;

  Result := strValPar;
End;

Function TConsultasGrid.fRetValorParametro(strNomPar: String): String;
Begin
  Result := '';

  If cdsConsultasGrid.Locate('MAP_NOMPAR', strNomPar, []) Then
    Case cdsConsultasGrid.FieldByName('MAP_TIPPAR').AsInteger Of
      INT_PARAMETRO: Begin
                       If fEmptyStr(cdsConsultasGrid.FieldByName('MAP_PARPAI').AsString) Then
                         Exit;

                       Result := fGetValorParametroFiltro(cdsConsultasGrid.FieldByName('MAP_PARPAI').AsString, True{blnMultiSelecaoQuoted});
                     End;
      INT_CONSTANTE: Result := cdsConsultasGrid.FieldByName('MAP_VALORC').AsString;
      INT_CAMPO    : Begin
                       If fEmptyStr(cdsConsultasGrid.FieldByName('MAP_CAMPAI').AsString) Then
                         Exit;

                       Result := fGetValorCampo(cdsConsultasGrid.FieldByName('MAP_CAMPAI').AsString);
                     End;
    End;
End;

Function TConsultasGrid.fValidaParametros(cdsCampos, cdsParams: TZClient): Boolean;
  Var
    strMensagem: String;
Begin
  Result := True;

  cdsConsultasGrid.Filtered := False;
  cdsConsultasGrid.First;

  While Not cdsConsultasGrid.Eof Do
  Begin
    Case cdsConsultasGrid.FieldByName('MAP_TIPPAR').AsInteger Of
      INT_PARAMETRO: If Not cdsParams.Locate('PAR_NOMPAR', cdsConsultasGrid.FieldByName('MAP_PARPAI').AsString, []) Then
                     Begin
                       strMensagem := 'Parâmetro "' + cdsConsultasGrid.FieldByName('MAP_PARPAI').AsString + '" não econtraddo no relatório.';
                       Result := False;
                       Break;
                     End;

      INT_CAMPO    : If Not cdsCampos.Locate('CAM_NOMCAM', cdsConsultasGrid.FieldByName('MAP_CAMPAI').AsString, []) Then
                     Begin
                       strMensagem := 'Campo "' + cdsConsultasGrid.FieldByName('MAP_CAMPAI').AsString + '" não econtraddo no relatório. Configure as consultas corretamente';
                       Result := False;
                       Break;
                     End;
    End;

    cdsConsultasGrid.Next;
  End;

  If Not Result Then
    pMensagemOk(strMensagem + ' Configure a consulta do campo ' + cdsConsultasGrid.FieldByName('MAP_NOMCAM').AsString + ' corretamente!');
End;

end.
