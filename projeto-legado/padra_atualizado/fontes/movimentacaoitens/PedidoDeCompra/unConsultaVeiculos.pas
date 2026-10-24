unit unConsultaVeiculos;

interface

Uses
  Classes,
  DB,
  UniClientDataSet,
  untZClient,
  CxProgressBar;

Type
  TConsutaVeiculos = Class(TZClient)
  Private

    FMaster: TDataSource;

    FcdsItens: TUniClientDataSet;

    Function fSQLConsulta(stlItens: TStringList; strCodIte: String = ''): String;

   Function fCarregaDadosPrg(cxProgressBar: TcxProgressBar): Boolean;

  Public

    constructor Create(Owner: TComponent; dtsItens: TDataSource); Reintroduce; Overload;

    Destructor Destroy; override;

    Function fCarregaDados(stlItens: TStringList; blnMostrarProgresso: Boolean): Boolean; OverLoad;

    Function fCarregaDados(cdsItensPedido: TUniClientDataSet): Boolean; OverLoad;

    Function fIncluiDadosItem(strCodIte: String): Boolean;


  End;

implementation

Uses
  Uni,
  Forms,
  SysUtils,
  untGravando,
  untFuncoesSimples;

constructor TConsutaVeiculos.Create(Owner: TComponent; dtsItens: TDataSource);
Begin
  Inherited Create(Owner, '');

  FMaster := dtsItens;

  fCarregaDados(Nil, False);
End;

Destructor TConsutaVeiculos.Destroy;
Begin

  Inherited;
End;

Function TConsutaVeiculos.fSQLConsulta(stlItens: TStringList; strCodIte: String = ''): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT        ';
  strSQL := strSQL + '   VEI_CODITE, ';
  strSQL := strSQL + '   MAR_DESMAR, ';
  strSQL := strSQL + '   MOD_DESMOD, ';
  strSQL := strSQL + '   MOD_ANOINI, ';
  strSQL := strSQL + '   MOD_ANOFIN, ';
  strSQL := strSQL + '   MOD_VALVUL, ';
  strSQL := strSQL + '   MOD_CILIND, ';
  strSQL := strSQL + '   MOD_POTENC, ';
  strSQL := strSQL + '   MOD_COMBUS, ';
  strSQL := strSQL + '   MOD_OBSERV  ';
  strSQL := strSQL + ' FROM DETMOD   ';
  strSQL := strSQL + '   INNER JOIN MODVEI ON MODVEI.MOD_CODMOD = DETMOD.MOD_CODMOD ';
  strSQL := strSQL + '   INNER JOIN VEIPRO ON VEIPRO.VEI_CODMOD = DETMOD.AUTOINCREM ';
  strSQL := strSQL + '   INNER JOIN MARVEI ON MAR_CODMAR = MOD_CODMAR ';
  strSQL := strSQL + ' WHERE  ';

  If Assigned(stlItens) Then
  Begin

    If stlItens.count > 0 Then
      strSQL := strSQL + '   VEI_CODITE IN (' + fCommaText(stlItens) + ') '
    Else
      strSQL := strSQL + ' False ';

  End Else If strCodIte.IsEmpty Then
    strSQL := strSQL + ' False '

  Else
    strSQL := strSQL + '   VEI_CODITE = ' + QuotedStr(strCodIte);

  Result := strSQL;
End;

Function TConsutaVeiculos.fCarregaDados(stlItens: TStringList; blnMostrarProgresso: Boolean): Boolean;
Begin
  qryQuery.SQL.Text := fSQLConsulta(stlItens);
  Result := fLeDados('TConsutaVeiculos.fCarregaDados', blnMostrarProgresso, 'Carregando dados de veículos...');
  Self.IndexFieldNames := 'VEI_CODITE';

  Self.MasterSource := FMaster;
  Self.MasterFields := 'ITE_CODITE';
End;

Function TConsutaVeiculos.fCarregaDados(cdsItensPedido: TUniClientDataSet): Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  FcdsItens := cdsItensPedido;

  Result := TfrmGravando.fExecuta(fCarregaDadosPrg, frmGravando, 'Carregando dados de veículos...');
End;

Function TConsutaVeiculos.fCarregaDadosPrg(cxProgressBar: TcxProgressBar): Boolean;
  Var
    stlItens: TStringList;
Begin
  Try
    stlItens := TStringList.Create;

    FcdsItens.DisableControls;
    FcdsItens.First;

    cxProgressBar.Properties.Max := FcdsItens.RecordCount;

    While Not FcdsItens.Eof Do
    Begin
      stlItens.Add(QuotedStr(FcdsItens.FieldByName('ITE_CODITE').AsString));

      FcdsItens.Next;

      cxProgressBar.Position := cxProgressBar.Position + 1;
      Application.ProcessMessages;
    End;

    Result := fCarregaDados(stlItens, False);

    FreeAndNil(stlItens);

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TConsutaVeiculos.fCarregaDadosPrg');
    End
  End;

  FcdsItens.First;
  FcdsItens.EnableControls;
End;

Function TConsutaVeiculos.fIncluiDadosItem(strCodIte: String): Boolean;
  Var
    qryDados: TUniQuery;
    intContador: Integer;
Begin
  Try
    Self.DisableControls;
    Self.MasterSource := Nil;

    If Not Self.FindKey([strCodIte]) Then
    Begin
      qryDados := fCriaQuery;

      qryDados.SQL.Text := fSQLConsulta(Nil, strCodIte);
      qryDados.Open;

      While Not qryDados.Eof Do
      Begin
        Self.Append;
        For intContador := 0 To qryDados.Fields.Count - 1 Do
          Self.Fields[intContador].Value := qryDados.Fields[intContador].Value;
        Self.Post;

        qryDados.Next;
      End;

      FreeAndNil(qryDados);
    End;

    Result := True;
  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TConsutaVeiculos.fIncluiDadosItem');
    End
  End;

  Self.MasterSource := FMaster;
  Self.EnableControls;
End;

end.
