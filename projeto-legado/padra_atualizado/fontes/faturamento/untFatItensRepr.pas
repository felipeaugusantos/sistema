unit untFatItensRepr;

interface

Uses
  Classes, DB, UniClientDataSet, Uni, StrUtils, SysUtils, UniDataSetProvider;

Type
  TFatItensRepresent = class(TComponent)
  private
    FTblTmp: TUniQuery;
    FCdsTmp: TUniClientDataSet;
    FdspTmp: TUniDataSetProvider;
    FSrcTmp: TDataSource;

    Function fSetaAutoincrem(strNumDoc, strEspDoc, strCodEmp, strSeqGer: String): Boolean;

  protected

  public

    property cdsCdsTmp: TUniClientDataSet Read FCdsTmp;
    property dtsDtsTmp: TDataSource Read FSrcTmp;

    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; strNumDoc, strEspDoc, strCodEmp: String); reintroduce; overload;
    destructor Destroy; override;

    procedure pAdicionaItemTmp(strCodIte,
                               strDesIte,
                               strDesOri,
                               strRefere,
                               strUnidad: String;
                               fltQtdIte,
                               fltUnitar,
                               fltTotIte: Double);

    procedure pEditaItemTmp(strDesIte,
                            strUnidad: String;
                            fltQtdIte,
                            fltUnitar,
                            fltTotIte: Double);


    Function fGravaItens(strNumDoc, strEspDoc, strCodEmp, strSeqGer: String): Boolean;
  end;

implementation
{ TFatItensRepresent }

Uses untModulo, untFuncoesSimples, untTypesSistema;

constructor TFatItensRepresent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

constructor TFatItensRepresent.Create(AOwner: TComponent; strNumDoc, strEspDoc, strCodEmp: String);
  Var
    strSQL: String;
begin
  inherited Create(AOwner);


  FTblTmp := TUniQuery.Create(Self);
  FTblTmp.Connection  := frmModulo.GetCurrentConnection;

  FdspTmp := TUniDataSetProvider.Create(Self);
  FdspTmp.DataSet := FTblTmp;
  FdspTmp.ResolveToDataSet := True;

  FCdsTmp := TUniClientDataSet.Create(Self);
  FCdsTmp.SetProvider(FdspTmp);

  FSrcTmp := TDataSource.Create(Self);
  FSrcTmp.DataSet := FCdsTmp;

  FCdsTmp.AggregatesActive := True;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_TOTITE';
    FieldName     := 'TOT_TOTITE';
    DataSet       := FCdsTmp;
    Expression    := 'SUM(ITE_TOTITE)';
    DisplayFormat := '#,##0.00';
    Active        := True;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_NUMDOC, ';
  strSQL := strSQL + '  ITE_ESPDOC, ';
  strSQL := strSQL + '  ITE_CODEMP, ';
  strSQL := strSQL + '  ITE_DESORI, ';
  strSQL := strSQL + '  ITE_CODITE, ';
  strSQL := strSQL + '  ITE_DESITE, ';
  strSQL := strSQL + '  ITE_UNIDAD, ';
  strSQL := strSQL + '  ITE_REFERE, ';
  strSQL := strSQL + '  ITE_QTDITE, ';
  strSQL := strSQL + '  ITE_UNITAR, ';
  strSQL := strSQL + '  ITE_TOTITE, ';
  strSQL := strSQL + '  ITE_SEQGER, ';
  strSQL := strSQL + '  AUTOINCREM  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEREP ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  ITE_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

  FTblTmp.Close;
  FCdsTmp.Close;

  FTblTmp.SQL.Clear;
  FTblTmp.SQL.Add(strSQL);
  FTblTmp.ParamByName('NUMDOC').AsString := strNumDoc;
  FTblTmp.ParamByName('ESPDOC').AsString := strEspDoc;
  FTblTmp.ParamByName('CODEMP').AsString := strCodEmp;

  FTblTmp.Open;
  pSetaClient(FTblTmp);

  FCdsTmp.Open;
  pSetaClient(FCdsTmp);

  TFloatField(FCdsTmp.FieldByName('ITE_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FCdsTmp.FieldByName('ITE_UNITAR')).DisplayFormat := '#,####0.0000';
  TFloatField(FCdsTmp.FieldByName('ITE_TOTITE')).DisplayFormat := '#,##0.00';

end;

destructor TFatItensRepresent.Destroy;
begin
  inherited Destroy;
end;

Function TFatItensRepresent.fSetaAutoincrem(strNumDoc, strEspDoc, strCodEmp,
  strSeqGer: String): Boolean;
  Var
    prcScroll: TprcScroll;
    qryIteRep: TUniQuery;
Begin
  Result := True;
  With cdsCdsTmp Do
  Begin
    Try
      Try
        qryIteRep := fCriaQuery(Self);
        qryIteRep.SQL.Text := 'SELECT * FROM ITEREP WHERE FALSE';
        qryIteRep.Open;

        pDisableControls(cdsCdsTmp, prcScroll);
        First;

        while Not Eof do
        Begin

          qryIteRep.Insert;

          qryIteRep.FieldByName('ITE_DESORI').AsString := FieldByName('ITE_DESORI').AsString;
          qryIteRep.FieldByName('ITE_CODITE').AsString := FieldByName('ITE_CODITE').AsString;
          qryIteRep.FieldByName('ITE_DESITE').AsString := FieldByName('ITE_DESITE').AsString;
          qryIteRep.FieldByName('ITE_UNIDAD').AsString := FieldByName('ITE_UNIDAD').AsString;
          qryIteRep.FieldByName('ITE_REFERE').AsString := FieldByName('ITE_REFERE').AsString;
          qryIteRep.FieldByName('ITE_QTDITE').AsFloat  := FieldByName('ITE_QTDITE').AsFloat;
          qryIteRep.FieldByName('ITE_UNITAR').AsFloat  := FieldByName('ITE_UNITAR').AsFloat;
          qryIteRep.FieldByName('ITE_TOTITE').AsFloat  := FieldByName('ITE_TOTITE').AsFloat;

          qryIteRep.FieldByName('ITE_CODEMP').AsString := strCodEmp;
          qryIteRep.FieldByName('ITE_ESPDOC').AsString := strEspDoc;
          qryIteRep.FieldByName('ITE_NUMDOC').AsString := strNumDoc;
          qryIteRep.FieldByName('ITE_SEQGER').AsString := strSeqGer;
          qryIteRep.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ITEREP', VS_strCodEmp);
          qryIteRep.Post;

          Next;
        End;

      Except

        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, 'TFatItensRepresent.pGravaItens');
        End;

      End;

    Finally
      pEnableControls(cdsCdsTmp, prcScroll);
      FreeAndNil(qryIteRep);
    End;

  End;
End;

Function TFatItensRepresent.fGravaItens(strNumDoc, strEspDoc, strCodEmp,
  strSeqGer: String): Boolean;
Begin
  Try
    Result := fSetaAutoincrem(strNumDoc, strEspDoc, strCodEmp,  strSeqGer);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TFatItensRepresent.pGravaItens');
    End;
  End;

end;

procedure TFatItensRepresent.pEditaItemTmp(strDesIte,
                                           strUnidad: String;
                                           fltQtdIte,
                                           fltUnitar,
                                           fltTotIte: Double);
begin
  With FCdsTmp Do
  Begin
    Edit;
    FieldByName('ITE_DESITE').AsString := strDesIte;
    FieldByName('ITE_UNIDAD').AsString := strUnidad;
    FieldByName('ITE_QTDITE').AsFloat  := fltQtdIte;
    FieldByName('ITE_UNITAR').AsFloat  := fltUnitar;
    FieldByName('ITE_TOTITE').AsFloat  := fltTotIte;
    Post;
  End;
end;

procedure TFatItensRepresent.pAdicionaItemTmp(strCodIte,
                                              strDesIte,
                                              strDesOri,
                                              strRefere,
                                              strUnidad: String;
                                              fltQtdIte,
                                              fltUnitar,
                                              fltTotIte: Double);
begin
  With FCdsTmp Do
  Begin
    If (Not Active) Then
      Active := True;

    Append;
    FieldByName('ITE_CODITE').AsString := strCodIte;
    FieldByName('ITE_DESITE').AsString := strDesIte;
    FieldByName('ITE_DESORI').AsString := strDesOri;
    FieldByName('ITE_REFERE').AsString := strRefere;
    FieldByName('ITE_UNIDAD').AsString := strUnidad;
    FieldByName('ITE_QTDITE').AsFloat  := fltQtdIte;
    FieldByName('ITE_UNITAR').AsFloat  := fltUnitar;
    FieldByName('ITE_TOTITE').AsFloat  := fltTotIte;
    Post;
  End;
end;

end.
