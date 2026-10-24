unit untZClient;

interface

Uses Uni, SysUtils, DB, UniClientDataSet, UniDataSetProvider, Controls, Classes,
  StrUtils, untConstantes, untIZClient, Datasnap.DBClient, cxProgressBar, Forms;

Type
  TZClient = Class(TUniClientDataSet, IZClient)
    Private
      FClientDataSet : TZClient;

    Public

      fVerificaCampos: TBooleanFunction;
      constructor Create(Owner: TComponent; strSQL: String = ''); Reintroduce;

      Destructor Destroy; override;

      Function fSalva: Boolean; Overload;

      Function fSalva(strTitulo: String): Boolean; Overload;

      Function fRetSoma(strNomAgg: String): Double;
      Function fRetSomaCampo(strNomCam: String): Double;

      Function fAbreClient(blnSetProvider: Boolean = False;
                           strNomFunc: String = ''; blnRefresh: Boolean = False;
                           blnExibirProgresso : Boolean = False): Boolean; Virtual;

      Function fLeDados(strNomFunc: String = ''; blnExibirProgresso : Boolean = False; strMsgLendo: String = ''): Boolean; Virtual;

      Procedure pCancela(blnUpdates: Boolean = True); Virtual;
      Procedure pSetProvider;
      Procedure pCriaSoma(strNomCam: String; strNomAgg: String = ''; strFormula: String = '');

      procedure pSalvaPorRegistro(strNomTab, strCamCod: String);

      Procedure pFormataDecimal(strNomCam: String; intNumDec: Integer = 2);

      Procedure pLimpaDados(strChave: String = '');

      Procedure pAlinhaCampoCentro(strNomCam: String);

      function fGetDataset: TDataset;
      function fGetUniClientDataset: TUniClientDataset;


      function fGetQuery: TUniClientDataSet;
      procedure pSetQuery(Dataset: TUniClientDataSet);


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

//      function FindKey(Value: String): Boolean; overload;

    published
      property qryQuery : TUniClientDataSet  Read fGetQuery  Write pSetQuery;
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


constructor TZClient.Create(Owner: TComponent; strSQL: String = '');
Begin
  inherited Create(Owner)  ;
End;

Destructor TZClient.Destroy;
Begin
  Inherited;

End;

procedure TZClient.pSetAfterScroll(Value: TDataSetNotifyEvent);
begin
end;

procedure TZClient.pSetData(Value: OleVariant);
begin
  Data := Value;
end;

procedure TZClient.pSetFilter(Value: String);
begin
  Filter := Value;

end;

procedure TZClient.pSetFiltered(Value: Boolean);
begin
  Filtered := Value;
end;

Procedure TZClient.pSetProvider;
Begin
End;

procedure TZClient.pSetQuery(Dataset: TUniClientDataSet);
begin
  FClientDataSet := TZClient(Dataset);
end;

procedure TZClient.pSetSource(DataSource: TDataSource);
begin
//  FSource := DataSource;
end;

procedure TZClient.pSetIndexFieldNames(Value: String);
begin
  IndexFieldNames := Value;
end;

Procedure TZClient.pCancela(blnUpdates: Boolean = True);
Begin
End;

Function TZClient.fSalva(strTitulo: String): Boolean;
Begin
  Result := false;
End;


Function TZClient.fSalva: Boolean;
Begin
  Result := true;
End;

function TZClient.fGetIndexFieldNames: String;
begin
  Result := IndexFieldNames;
end;

Procedure TZClient.pCriaSoma(strNomCam: String; strNomAgg: String = ''; strFormula: String = '');
Begin
End;

Function TZClient.fRetSoma(strNomAgg: String): Double;
Begin
  Result := 0;
End;

Function TZClient.fRetSomaCampo(strNomCam: String): Double;
Begin
  Result := 0;
End;


Function TZClient.fLeDados(strNomFunc: String = ''; blnExibirProgresso : Boolean = False; strMsgLendo: String = ''): Boolean;
Begin
  Result := true;
End;

Function TZClient.fAbreClient(blnSetProvider: Boolean = False;
                              strNomFunc: String = '';
                              blnRefresh: Boolean = False;
                              blnExibirProgresso : Boolean = False): Boolean;
Begin
//  TUniClientDataSet(FClientDataSet):= TUniClientDataSet.Create(Nil);
  Self.FieldDefs.add('FOR_CODCAM', ftString, 100);
  Self.FieldDefs.add('FOR_BASCAL', ftString, 200);
  Self.FieldDefs.add('AUTOINCREM', ftString, 100);
  Self.FieldDefs.add('FOR_CODEMP', ftString, 100);
  Self.FieldDefs.add('EXPVAL',     ftString, 100);
  Self.FieldDefs.add('NOMALQ',     ftString, 100);
  Self.FieldDefs.add('OPERAD',     ftString, 100);
  Self.FieldDefs.add('POSCAM',     ftString, 100);
  Self.FieldDefs.add('DESCAM',     ftString, 100);
  Self.FieldDefs.add('NOMCAM',     ftString, 100);

  Self.CreateDataSet;

  Result := true;


End;

function TZClient.fExportaCSV(strNomCSV: String): Boolean;
begin
  result := false;
end;

function TZClient.fGetAfterScroll: TDataSetNotifyEvent;
begin
  Result := nil;
end;

function TZClient.fGetData: OleVariant;
begin
  Result := inherited data;
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
  Result := '';
end;


function TZClient.fGetQuery: TUniClientDataSet;
begin
  Result := FClientDataSet;
end;

function TZClient.fGetSource: TDataSource;
begin
  Result := Nil;
end;

function TZClient.fGetUniClientDataset: TUniClientDataset;
begin
  Result := Self;
end;

procedure TZClient.pSalvaPorRegistro(strNomTab, strCamCod: String);
Begin
End;

Procedure TZClient.pFormataDecimal(strNomCam: String; intNumDec: Integer = 2);
Begin
End;

Procedure TZClient.pLimpaDados(strChave: String = '');
Begin
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
end;

end.
