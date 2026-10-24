unit untZClient;

interface

Uses Uni, SysUtils, DB, UniClientDataSet, UniDataSetProvider, Controls, Classes,
  StrUtils, untConstantes, untIFuncoes, untIZClient, Datasnap.DBClient, cxProgressBar, Forms;

Type
  TZClient = Class(TUniClientDataSet, IZClient)
    Private
      FSetProvider: Boolean;
      FNomFunc: String;
      FRefresh: Boolean;

      FArqCSV: String;
      FNomTab: String;
      FCamCod: String;

      FMsgErr: String;
      FQuery : TUniQuery;
      FProvid: TUniDataSetProvider;
      FSource: TDataSource;


      procedure pReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError;
                   UpdateKind: TUpdateKind; var Action: TReconcileAction);

      procedure pBeforePost(DataSet: TDataSet);
      procedure pAfterPost(DataSet: TDataSet);

      function fExportaCSVInterna(cxProgress : TcxProgressBar): Boolean;
      function fAbreClientProgress(prgProgressBar: TcxProgressBar): Boolean;


    Public
      fVerificaCampos: TBooleanFunction;
      constructor Create(Owner: TComponent; strSQL: String = ''); Reintroduce;

      Destructor Destroy; override;

      Function fSalva: Boolean;
      Function fRetSoma(strNomAgg: String): Double;
      Function fAbreClient(blnSetProvider: Boolean = False;
                           strNomFunc: String = ''; blnRefresh: Boolean = False;
                           blnExibirProgresso : Boolean = False): Boolean; Virtual;

      Procedure pCancela(blnUpdates: Boolean = True); Virtual;
      Procedure pSetProvider;
      Procedure pCriaSoma(strNomCam: String; strNomAgg: String = ''; strFormula: String = '');

      procedure pSalvaPorRegistro(strNomTab, strCamCod: String);

      Procedure pFormataDecimal(strNomCam: String; intNumDec: Integer = 2);

      Procedure pLimpaDados(strChave: String = '');

      Procedure pAlinhaCampoCentro(strNomCam: String);

      function fGetDataset: TDataset;
      function fGetUniClientDataset: TUniClientDataset;

      function fGetQuery: TUniQuery;
      procedure pSetQuery(Dataset: TUniQuery);

      function fGetSource: TDataSource;
      procedure pSetSource(DataSource: TDataSource);

      function fGetMsgErr: String;

      function fGetFiltered: Boolean;
      procedure pSetFiltered(Value: Boolean);

      function fGetFilter: String;
      procedure pSetFilter(Value: String);

      function fGetData: OleVariant;
      procedure pSetData(Value: OleVariant);

      function fGetAfterScroll: TDataSetNotifyEvent;
      procedure pSetAfterScroll (Value: TDataSetNotifyEvent);

      function fGetIndexFieldNames: String;
      procedure pSetIndexFieldNames(Value: String);

      function fGetFFields: TFields;
      function fGetFEOF: Boolean;

      function fExportaCSV(strNomCSV : String):Boolean;
      procedure pSetUpdateMode(enuUpdateMode: TUpdateMode);

    published
      property qryQuery : TUniQuery      Read fGetQuery  Write pSetQuery;
      property dtsSource: TDataSource    Read fGetSource Write pSetSource;
      property strMsgErr: String         Read fGetMsgErr;
      property Filtered: Boolean         Read fGetFiltered Write pSetFiltered;
      property Filter: string            Read fGetFilter   Write pSetFilter;
      property Data: OleVariant          Read fGetData     Write pSetData;
      property Fields: TFields           Read fGetFFields;
      property Eof: Boolean              Read fGetFEOF;
      property AfterScroll: TDataSetNotifyEvent read fGetAfterScroll write pSetAfterScroll;
  End;

implementation

uses untfuncoesSimples, untGravando, untHelperCitel;

constructor TZClient.Create(Owner: TComponent; strSQL: String = '');
Begin
  Inherited Create(Owner);

  fVerificaCampos := Nil;

  FQuery := fCriaQuery(Self);
  FQuery.SQL.Text := strSQL;

  FProvid := TUniDataSetProvider.Create(Self);
  FProvid.ResolveToDataSet := True;
  FProvid.DataSet := FQuery;

  Self.SetProvider(FProvid);

  FSource := TDataSource.Create(Self);
  FSource.DataSet := Self;

  AggregatesActive := True;

  Self.OnReconcileError := pReconcileError;
End;

Destructor TZClient.Destroy;
Begin
  Inherited;

End;

procedure TZClient.pSetAfterScroll(Value: TDataSetNotifyEvent);
begin
  inherited AfterScroll := Value;
end;

procedure TZClient.pSetData(Value: OleVariant);
begin
  inherited Data := Value;
end;

procedure TZClient.pSetFilter(Value: String);
begin
  inherited Filter := Value;
end;

procedure TZClient.pSetFiltered(Value: Boolean);
begin
  inherited Filtered := Value;
end;

Procedure TZClient.pSetProvider;
Begin
  Self.SetProvider(FProvid);
End;

procedure TZClient.pSetQuery(Dataset: TUniQuery);
begin
  FQuery := Dataset;
end;

procedure TZClient.pSetSource(DataSource: TDataSource);
begin
  FSource := DataSource;
end;

procedure TZClient.pSetIndexFieldNames(Value: String);
begin
  inherited IndexFieldNames := Value;
end;

Procedure TZClient.pCancela(blnUpdates: Boolean = True);
Begin
  If Self.State In [dsEdit, dsInsert] Then
    Self.Cancel;

  If blnUpdates And Self.Active Then
    Self.Cancel;
End;


procedure TZClient.pReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError;
  UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  Action := raAbort;

  Raise ExceptionAutCom.Create(E.Message);
end;

Function TZClient.fSalva: Boolean;
Begin
  If Self.State In [dsEdit, dsInsert] Then
    Self.Post;

  Try

    If (Self.ChangeCount > 0)  Then
      Result := Self.ApplyUpdates(0) = 0
    Else
      Result := True;

  Except
    On E: ExceptionAutCom Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TZClient.fSalva]');
      Result := False;
      Exit;
    End;

    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TZClient.fSalva]');
      Result := False;
    End;
  End;
End;

function TZClient.fGetIndexFieldNames: String;
begin
  Result := inherited IndexFieldNames;
end;

Procedure TZClient.pCriaSoma(strNomCam: String; strNomAgg: String = ''; strFormula: String = '');
Begin
  If fEmptyStr(strNomAgg) Then
    strNomAgg := 'SUM_' + strNomCam;

  With TAggregateField.Create(Owner) Do
  Begin
    FieldName := strNomAgg;
    DataSet := Self;
    DisplayFormat := '#,##0.00';
    Alignment := taRightJustify;

    If fEmptyStr(strFormula) Then
      Expression := 'SUM(' + strNomCam + ')'
    Else
      Expression := strFormula;

    Active := True;
  End;
End;

Function TZClient.fRetSoma(strNomAgg: String): Double;
Begin
  Result := fDoubleAggregate(Self, strNomAgg);
End;

Function TZClient.fAbreClientProgress(prgProgressBar : TcxProgressBar):Boolean;
Begin
  Try

    With FQuery Do
    Begin

      If Not FRefresh Then
      Begin
        Self.Close;
        Close;
      End;

      If FSetProvider Then
        pSetProvider;

      If FRefresh And Self.Active Then
        Self.Refresh
      Else
      Begin
        Open;
        pSetaClient(FQuery);
        Self.Open;
      End;

    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      FmsgErr := E.Message;

      If Not fEmptyStr(FNomFunc) Then
        pMensagensErro(E.Message, '[' + FNomFunc + ']');
    End;
  End;

End;

Function TZClient.fAbreClient(blnSetProvider: Boolean = False;
                              strNomFunc: String = '';
                              blnRefresh: Boolean = False;
                              blnExibirProgresso : Boolean = False): Boolean;
  Var
    frmGravandoProgress : TfrmGravando;
Begin
  FSetProvider := blnSetProvider;
  FNomFunc     := strNomFunc;
  FRefresh     := blnRefresh;

  If blnExibirProgresso Then
  Begin
    try
      pCriarFormularios(TfrmGravando, frmGravandoProgress);
      frmGravandoProgress.fExecutarAcao := fAbreClientProgress;
      frmGravandoProgress.pgbStatus.Visible := False;
      frmGravandoProgress.lblGravando.Caption := 'Aguarde, Carregando...';
      frmGravandoProgress.ShowModal;
      Result := frmGravandoProgress.blnConfirma;
    Finally
      FreeAndNil(frmGravandoProgress);
    End;

  End
  Else
    Result := fAbreClientProgress(nil);
End;

function TZClient.fExportaCSV(strNomCSV: String): Boolean;
begin
  FArqCSV := strNomCSV;
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao:= fExportaCSVInterna;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

function TZClient.fExportaCSVInterna(cxProgress : TcxProgressBar): Boolean;
  Var
    intIndex : Integer;
    csvFile  : TextFile;
    strLinha : String;
begin
  Result := True;
  If not Active Then
  Begin
    Result := False;
    Exit;
  End;

  Try
    Try
      AssignFile(csvFile, FArqCSV);
      If FileExists(FArqCSV) Then
      Begin
        Reset(csvFile);
      End
      Else
      Begin
        Rewrite(csvFile);
      End;

      System.Append(csvFile);

      First;

      cxProgress.pSetMax( RecordCount + 1 );

      strLinha := '';
      For intIndex := 0 To Fields.Count-1 Do
      Begin
        strLinha := strLinha + Fields[intIndex].FieldName;

        If intIndex < (Fields.Count-1) Then
          strLinha := strLinha + ';';
      End;
      WriteLn(csvFile, strLinha);
      cxProgress.pStep;


      While Not Eof Do
      Begin

        strLinha := '';
        For intIndex := 0 To Fields.Count-1 Do
        Begin

          Case Fields[intIndex].DataType Of
            ftString,
            ftWideString : strLinha := strLinha + Fields[intIndex].AsString;

            ftLargeint,
            ftSmallint,
            ftInteger,
            ftLongWord,
            ftWord       : strLinha := strLinha + Fields[intIndex].AsString;

            ftBoolean    : If Fields[intIndex].AsBoolean Then
                             strLinha := strLinha + 'TRUE'
                           Else
                             strLinha := strLinha + 'FALSE';

            ftFloat,
            ftCurrency,
            ftBCD        : FormatFloat(fMskDigitos(TFloatField(Fields[intIndex]).Precision), Fields[intIndex].AsFloat);

            ftDate,
            ftDateTime   : FormatDateTime('dd/mm/yyyy', Fields[intIndex].AsDateTime);

            ftTime       : FormatDateTime('hh:nn:ss', Fields[intIndex].AsDateTime);

          End;

          If intIndex < (Fields.Count-1) Then
            strLinha := strLinha + ';';
        End;
        WriteLn(csvFile, strLinha);
        Next;

        cxProgress.pStep;

        Application.ProcessMessages;

      End;

    Finally
      System.Flush(csvFile);
      System.Close(csvFile);
    End;

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TZClient.fExportaCSVInterna');
    End;
  End;
End;

function TZClient.fGetAfterScroll: TDataSetNotifyEvent;
begin
  Result := inherited AfterScroll;
end;

function TZClient.fGetData: OleVariant;
begin
  Result := inherited Data;
end;

function TZClient.fGetDataset: TDataset;
begin
  Result := Self;
end;

function TZClient.fGetFEOF: Boolean;
begin
  Result := inherited Eof;
end;

function TZClient.fGetFFields: TFields;
begin
  Result := inherited Fields;
end;

function TZClient.fGetFilter: String;
begin
  Result := inherited Filter;
end;

function TZClient.fGetFiltered: Boolean;
begin
  Result := inherited Filtered;
end;

function TZClient.fGetMsgErr: String;
begin
  Result := FMsgErr;
end;

function TZClient.fGetQuery: TUniQuery;
begin
  Result := FQuery;
end;

function TZClient.fGetSource: TDataSource;
begin
  Result := FSource;
end;

function TZClient.fGetUniClientDataset: TUniClientDataset;
begin
  Result := Self;
end;

procedure TZClient.pBeforePost(DataSet: TDataSet);
Begin
  With DataSet Do
  Begin
    If Assigned(fVerificaCampos) And (Not fVerificaCampos) Then
    Begin
      Abort;
      Exit;
    End;

    If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
    Begin
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(FNomTab, VS_strCodEmp);
      FieldByName(FCamCod).AsString      := fAtualizaProCod(FNomTab);
    End;
  End;
End;

procedure TZClient.pAfterPost(DataSet: TDataSet);
Begin
  fSalva;
End;

procedure TZClient.pSalvaPorRegistro(strNomTab, strCamCod: String);
Begin
  FNomTab := strNomTab;
  FCamCod := strCamCod;

  Self.BeforePost := pBeforePost;
  Self.AfterPost  := pAfterPost;
End;

Procedure TZClient.pFormataDecimal(strNomCam: String; intNumDec: Integer = 2);
Begin
  If Fields.FindField(strNomCam) <> Nil Then
  Begin
    (FieldByName(strNomCam) As TFloatField).DisplayFormat := fMskDigitos(intNumDec);
  End

  Else If AggFields.FindField(strNomCam) <> Nil Then
  Begin
    (AggFields.FieldByName(strNomCam) As TAggregateField).DisplayFormat := fMskDigitos(intNumDec);
  End;
End;

Procedure TZClient.pLimpaDados(strChave: String = '');
  Var
    intIndice: Integer;
Begin
  If State In [dsEdit, dsInsert] Then
  Begin

    For intIndice := 0 To Fields.Count - 1 Do
      If (Fields[intIndice].Name <> 'AUTOINCREM') And
         (Pos('_CODEMP', Fields[intIndice].Name) <= 0) And
         (Pos(strChave, Fields[intIndice].Name) <= 0) Then
       Fields[intIndice].Clear;

  End;
End;

Procedure TZClient.pAlinhaCampoCentro(strNomCam: String);
Begin
  If Fields.FindField(strNomCam) <> Nil Then
  Begin
    FieldByName(strNomCam).Alignment := taCenter;
  End
End;

procedure TZClient.pSetUpdateMode(enuUpdateMode: TUpdateMode);
begin
  FProvid.UpdateMode := enuUpdateMode;
end;

end.
