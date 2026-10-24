unit untSeqCom;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  System.Classes, System.SysUtils, Uni,  Data.DB;

type

  TSeqCom = Class(TComponent)
  private
    FQuery : TUniQuery;
    function fGetTableName: String;
    function fGetSQL: String;
    procedure pPopularTabela;
    procedure pInsertTabela(intSeqInd: Integer; strDescri: String);
  public
    constructor Create(Owner: TComponent); Reintroduce;
    destructor Destroy; override;
    function fGetLista: TStringList;
    procedure pUpdateTabela(intSeqInd: Integer; strDescri: String);
  End;

  Const
    arrDadosIniciais : Array[0..3] Of String = ('PRODUTO', 'LINHA e GRUPO', 'FORNECEDOR', 'VENDEDOR');

implementation

{ TSeqCom }

constructor TSeqCom.Create(Owner: TComponent);
begin
  Inherited Create(Owner);
  FQuery := fCriarQuery(fGetSQL, Owner);
  FQuery.Open;
  pPopularTabela;
end;

destructor TSeqCom.Destroy;
begin
  FreeAndNil(FQuery);
  inherited Destroy;
end;

function TSeqCom.fGetLista: TStringList;
begin
  Result := TStringList.Create;

  FQuery.First;
  While Not FQuery.Eof Do
  Begin
    Result.Add(FQuery.FieldByName('COM_DESCRI').AsString);
    FQuery.Next;
  End;
end;

function TSeqCom.fGetSQL: String;
begin
  Result := ' SELECT * FROM ' + fGetTableName + ' ORDER BY COM_SEQIND ';
end;

function TSeqCom.fGetTableName: String;
begin
  Result := 'SEQCOM';
end;

procedure TSeqCom.pInsertTabela(intSeqInd: Integer; strDescri: String);
  Var
    qryInsert: TUniQuery;
begin
  qryInsert := fCriaQuery(Self);

  With qryInsert Do
  Begin
    Close;
    SQL.Text := 'INSERT INTO ' + fGetTableName + ' (AUTOINCREM, COM_SEQIND, COM_DESCRI) VALUES (:AUTINC, :SEQIND, :DESCRI)';
    ParamByName('SEQIND').AsInteger := intSeqInd;
    ParamByName('DESCRI').AsString := strDescri;
    ParamByName('AUTINC').AsString := fRetAutoIncrem(fGetTableName, VS_strCodEmp);
    ExecSQL;
  End;

  FreeAndNil(qryInsert);
end;

procedure TSeqCom.pPopularTabela;
  Var
    intCnt : Integer;
begin
  If (FQuery.IsEmpty) Then
  Begin
    For intCnt := Low(arrDadosIniciais) To High(arrDadosIniciais) Do
    Begin
      If Not FQuery.Locate('COM_DESCRI', arrDadosIniciais[intCnt], []) Then
        pInsertTabela(intCnt, arrDadosIniciais[intCnt]);
    End;
  End;

  FQuery.Refresh;
end;

procedure TSeqCom.pUpdateTabela(intSeqInd: Integer; strDescri: String);
  Var
    qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery(Self);

  With qryUpdate Do
  Begin
    Close;
    SQL.Text := ' UPDATE ' + fGetTableName + ' SET COM_SEQIND = :SEQIND WHERE COM_DESCRI = :DESCRI ';
    ParamByName('DESCRI').AsString := strDescri;
    ParamByName('SEQIND').AsInteger := intSeqInd;
    ExecSQL;
  End;

  FreeAndNil(qryUpDate);
end;

end.
