unit untComFor;

interface

uses System.Classes, Uni, UniClientDataSet, untFuncoesSimples, System.SysUtils,
     UniDataSetProvider, System.Variants, Data.Db;

type
  TComFor = Class(TComponent)
  private
    FQuery : TUniQuery;
    FClien : TUniClientDataSet;
    FProvi : TUniDataSetProvider;
    function fGetSQL(strCodOpe: String): String;
  public
    constructor Create(Owner: TComponent); Reintroduce;
    destructor Destroy; override;
    function fGetCds: TUniClientDataSet;
    procedure pCarregar(strCodOpe: String);
    procedure pIncluir(strCodOpe, strCodFor: String; fltPerCom: Double);
    procedure pDeletar(strCodOpe, strCodFor: String);
    procedure pConfirmarGravacao(strCodOpe: String);
    procedure pCancelarAlteracoes;
    function fJaInformado(strCodOpe, strCodFor: String): Boolean;
  End;

implementation

{ TComFor }

constructor TComFor.Create(Owner: TComponent);
begin
  Inherited Create(Owner);
  FQuery := fCriaQuery(Owner);
  FClien := TUniClientDataSet.Create(Owner);
  FProvi := TUniDataSetProvider.Create(Owner);
  //FProvi.ResolveToDataSet := True;
  FProvi.DataSet := FQuery;
end;

destructor TComFor.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FClien);
  FreeAndNil(FProvi);
  inherited Destroy;
end;

procedure TComFor.pCancelarAlteracoes;
begin
  If (FClien.Active) Then
    FClien.CancelUpdates;
end;

procedure TComFor.pCarregar(strCodOpe: String);
begin
  FClien.Close;

  With FQuery Do
  Begin
    Close;
    SQL.Text := fGetSQL(strCodOpe);
    Open;
    pSetaClient(FQuery);
  End;

  FClien.SetProvider(FProvi);
  FClien.Open;
  pSetaClient(FClien);

  TFloatField(FClien.FieldByName('FOR_PERCOM')).DisplayFormat := fDisplayFormat(2);
end;

procedure TComFor.pConfirmarGravacao(strCodOpe: String);
  Var
    strAutInc : String;
begin
  strAutInc := FClien.FieldByName('AUTOINCREM').AsString;

  FClien.DisableControls;

  Try
    FClien.First;
    While Not FClien.Eof Do
    Begin
      If fEmptyStr(FClien.FieldByName('FOR_CODOPE').AsString) Then
      Begin
        FClien.Edit;
        FClien.FieldByName('FOR_CODOPE').AsString := strCodOpe;
        FClien.Post;
      End;
      FClien.Next;
    End;
  Finally
    FClien.Locate('AUTOINCREM', strAutInc, []);
    FClien.EnableControls;
  End;

  FClien.ApplyUpDates(0);
end;

procedure TComFor.pDeletar(strCodOpe, strCodFor: String);
begin
  If FClien.Locate('FOR_CODOPE;FOR_CODFOR', VarArrayOf([strCodOpe, strCodFor]), []) Then
  Begin
    FClien.Delete;
  End;
end;

procedure TComFor.pIncluir(strCodOpe, strCodFor: String; fltPerCom: Double);
begin
  FClien.Append;
  FClien.FieldByName('FOR_CODFOR').AsString := strCodFor;
  FClien.FieldByName('FOR_CODOPE').AsString := strCodOpe;
  FClien.FieldByName('FOR_PERCOM').AsFloat := fltPerCom;
  FClien.FieldByName('FOR_NOMFOR').AsString := fRetNomFornecedor(strCodFor);
  FClien.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMFOR', VS_strCodEmp);
  FClien.Post;
end;

function TComFor.fGetCds: TUniClientDataSet;
begin
  Result := FClien;
end;

function TComFor.fGetSQL(strCodOpe: String): String;
begin
  Result := ' SELECT * FROM COMFOR WHERE FOR_CODOPE = ' + QuotedStr(strCodOpe) ;
end;

function TComFor.fJaInformado(strCodOpe, strCodFor: String): Boolean;
begin
  Result := FClien.Locate('FOR_CODOPE;FOR_CODFOR', VarArrayOf([strCodOpe, strCodFor]), []);
end;

end.
