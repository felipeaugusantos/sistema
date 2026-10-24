unit untAtiGru;

interface

uses Uni, Classes, UniDataSetProvider, untZClient;

Type
  TAtiGru = Class(TZClient)

  Private

    FCodAti: string;

    function fGetSqlAtiGru: string;
    procedure pFormataCampos;

  Public

    function fCarregaAtiGru(strCodAti: String): Boolean;
    function fSalvarAtiGru: Boolean;

    function fLinhaGrupoJaInformado(strLinGru: String): Boolean;

    procedure pAdicionar(strCodGru, strDesGru: String);
    procedure pExcluir;

    Constructor Create(Owner: TComponent); reintroduce;
    Destructor Destroy; Override;

  End;

implementation

uses Db, UniClientDataSet, untFuncoesSimples;

{ TAtiGru }

constructor TAtiGru.Create(Owner: TComponent);
begin
  inherited Create(Owner, fGetSqlAtiGru);
end;

destructor TAtiGru.Destroy;
begin

  inherited;
end;

function TAtiGru.fCarregaAtiGru(strCodAti: String): Boolean;
begin
  FCodAti := strCodAti;

  With qryQuery Do
  Begin
    ParamByName('CODATI').AsString := strCodAti;
  End;

  Result := fAbreClient(True, 'TAtiGru.fCarregaAtiGru');

  If Result Then
  Begin
    FieldByName('ATI_DESGRU').ProviderFlags := [];
    pFormataCampos;
    IndexFieldNames := 'ATI_CODGRU';
  End;

end;

function TAtiGru.fGetSqlAtiGru: string;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   ATIGRU.*, ';
  Result := Result + '   (SELECT GRU_DESGRU FROM CADGRU WHERE GRU_CODGRU = ATI_CODGRU) AS ATI_DESGRU ';
  Result := Result + ' FROM ';
  Result := Result + '   ATIGRU ';
  Result := Result + ' WHERE ';
  Result := Result + '   ATI_CODATI = :CODATI ';
end;

function TAtiGru.fSalvarAtiGru: Boolean;
begin
  Result := fSalva;
end;

Procedure TAtiGru.pExcluir;
Begin
  If (Not IsEmpty) And fPergunta('Confirma a exclusão do registro?') Then
    Delete;
End;

function TAtiGru.fLinhaGrupoJaInformado(strLinGru: String): Boolean;
begin
  Result := Locate('ATI_CODGRU', strLinGru, []);
end;

procedure TAtiGru.pAdicionar(strCodGru, strDesGru: String);
begin
  If fLinhaGrupoJaInformado(strCodGru) Then
    Edit
  Else
  Begin
    Append;
    FieldByName('ATI_CODATI').AsString := FCodAti;
    FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ATIGRU', VS_strCodEmp);
  end;

  FieldByName('ATI_CODEMP').AsString := VS_strCodEmp;
  FieldByName('ATI_CODGRU').AsString := strCodGru;
  FieldByName('ATI_DESGRU').AsString := strDesGru;

  Post;
end;

procedure TAtiGru.pFormataCampos;
begin
  FieldByName('ATI_CODGRU').EditMask := '999.999;0;_';
end;

end.

