unit Romaneio.TemporariaDocumentos;

interface

uses
  Romaneio.Types, System.Generics.Collections, System.Classes;

type
  TInsertValues = record
    strNomTab : String;
    strInsert : String;
  End;

type
  TTemporariaDocumentosRomaneio = class
  private
    FTables : TStringList;
    FInserts : TList<TInsertValues>;
    function fPegaProximoNomeTemporaria: String;
    function fCriarTemporaria(const ANomTab: String; ATipoTabela: TTipoTabelaTmp): Boolean;
  public
    function fGerarNovaTemporaria(ATipoTabela: TTipoTabelaTmp = tbAutInc): String;
    function fInserirDocumentoTemporaria(const ANomTab: String; const ASeqDocumento: String; const AEntSai: String): Boolean;
    procedure pAddInserirDocumentoTemporaria(const ANomTab: String; const ASeqDocumento: String; const AEntSai: String);
    procedure pExecutaInsertsTemporaria;
    function fInserirDocumentoTmpCRM(const ANomTab: String; ATabela, ANumDoc, AEspDoc,
      ACodEmp, AAutInc, ACodCli, ACodVen, AEntSai, ANumRom: String): Boolean;
    function fInserirDocRomInvalido(const ANomTab: String; ATabela, ANumDoc, AEspDoc,
      ACodEmp, AAutInc, ACodCli, ACodIte: String; AQtdBai: Double): Boolean;
    function fGetJoinDocumentos(const ANomTab: String; ACampoIncremento: String; ACampoEntSai: String = ''): String;
    function fTemRegistrosTabela(const ANomTab: String): Boolean;
    procedure pApagarTemporaria(const ANomTab: String);
    procedure pLimparTemporaria(const ANomTab: String);
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
 {$IFDEF LINUX}
   {$I '..\..\..\core\services.core.uses.inc'},
 {$ELSE }
  untFuncoesSimples,
 {$ENDIF LINUX}
  SysUtils, untConstantes;

{ TTemporariaDocumentosRomaneio }

constructor TTemporariaDocumentosRomaneio.Create;
begin
  FInserts := TList<TInsertValues>.Create;
  FTables := TStringList.Create;
end;

destructor TTemporariaDocumentosRomaneio.Destroy;
begin
  FreeAndNil(FInserts);
  FreeAndNil(FTables);
  inherited;
end;

function TTemporariaDocumentosRomaneio.fCriarTemporaria(const ANomTab: String; ATipoTabela: TTipoTabelaTmp): Boolean;
var
  LSQL: String;
begin
  fStartTransaction;

  LSQL := EmptyStr;
  LSQL := LSQL + ' CREATE TABLE ' + ANomTab   + ' ( ';

  case ATipoTabela of
    tbAutInc:
      begin
        LSQL := LSQL + '   TMP_AUTINC VARCHAR(20),        ';
        LSQL := LSQL + '   TMP_ENTSAI CHAR(1),            ';
        LSQL := LSQL + '   KEY IDX_' + ANomTab + '_01 (TMP_AUTINC), ';
        LSQL := LSQL + '   PRIMARY KEY (TMP_AUTINC, TMP_ENTSAI)     ';
      end;
    tbCRM:
      begin
        LSQL := LSQL + '   TMP_NUMDOC VARCHAR(12),        ';
        LSQL := LSQL + '   TMP_ESPDOC VARCHAR(2),         ';
        LSQL := LSQL + '   TMP_CODEMP VARCHAR(3),         ';
        LSQL := LSQL + '   TMP_CODCLI VARCHAR(8),         ';
        LSQL := LSQL + '   TMP_CODVEN VARCHAR(3),         ';
        LSQL := LSQL + '   TMP_ENTSAI VARCHAR(1),         ';
        LSQL := LSQL + '   TMP_NUMROM VARCHAR(6),         ';
        LSQL := LSQL + '   TMP_TABELA VARCHAR(10),        ';
        LSQL := LSQL + '   TMP_AUTINC VARCHAR(20),        ';
        LSQL := LSQL + '   KEY IDX_' + ANomTab + '_01 (TMP_AUTINC), ';
        LSQL := LSQL + '   PRIMARY KEY (TMP_AUTINC)     ';
      end;
    tbRomInvalido:
      begin
        LSQL := LSQL + '   TMP_NUMDOC VARCHAR(12),        ';
        LSQL := LSQL + '   TMP_ESPDOC VARCHAR(2),         ';
        LSQL := LSQL + '   TMP_CODEMP VARCHAR(3),         ';
        LSQL := LSQL + '   TMP_CODCLI VARCHAR(8),         ';
        LSQL := LSQL + '   TMP_TABELA VARCHAR(10),        ';
        LSQL := LSQL + '   TMP_AUTINC VARCHAR(20),        ';
        LSQL := LSQL + '   TMP_CODITE VARCHAR(10),';
        LSQL := LSQL + '   TMP_QTDBAI DECIMAL(14,4),      ';
        LSQL := LSQL + '   KEY IDX_' + ANomTab + '_01 (TMP_AUTINC), ';
        LSQL := LSQL + '   PRIMARY KEY (TMP_AUTINC)     ';
      end;
  end;

  LSQL := LSQL + ' ) ENGINE = MEMORY DEFAULT CHARSET=LATIN1   ';

  Result := fExecutaSQL(LSQL, True);
  fCommit;
end;

function TTemporariaDocumentosRomaneio.fGerarNovaTemporaria(ATipoTabela: TTipoTabelaTmp = tbAutInc): String;
var
  LNomTab: String;
begin
  Result := EmptyStr;
  LNomTab := fPegaProximoNomeTemporaria;

  if (not fCriarTemporaria(LNomTab, ATipoTabela)) then
    Exit;

  Result := LNomTab;
end;

function TTemporariaDocumentosRomaneio.fGetJoinDocumentos(const ANomTab: String; ACampoIncremento: String; ACampoEntSai: String = ''): String;
begin
  Result := ' JOIN ' + ANomTab + ' AS TMP_DOCSROM ON ' + ACampoIncremento + ' = TMP_AUTINC ';

  If (Not fEmptyStr(ACampoEntSai)) Then
    Result := Result + 'AND ' + ACampoEntSai + ' = TMP_ENTSAI ';
end;

function TTemporariaDocumentosRomaneio.fInserirDocRomInvalido( const ANomTab: String; ATabela, ANumDoc, AEspDoc, ACodEmp, AAutInc, ACodCli,
  ACodIte: String; AQtdBai: Double): Boolean;
var
  LSQL: String;
begin
  LSQL := EmptyStr;
  LSQL := LSQL + STR_SQL_NAO_REPLICAR;
  LSQL := LSQL + ' SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; ';
  LSQL := LSQL + ' INSERT INTO ' + ANomTab + ' (TMP_TABELA, TMP_NUMDOC, TMP_ESPDOC, TMP_CODEMP, TMP_CODCLI, ';
  LSQL := LSQL + '   TMP_AUTINC, TMP_CODITE, TMP_QTDBAI) ';
  LSQL := LSQL + ' VALUES (' + QuotedStr(ATabela) + ', ' + QuotedStr(ANumDoc) + ', ' + QuotedStr(AEspDoc) + ', ';
  LSQL := LSQL + QuotedStr(ACodEmp) + ', ' + QuotedStr(ACodCli) + ', ' + QuotedStr(AAutInc) + ', ';
  LSQL := LSQL + QuotedStr(ACodIte) + ', ' + fFloatToSQL(AQtdBai) + '); ';
  LSQL := LSQL + DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
  Result := fExecutaSQL(LSQL, True);
end;

function TTemporariaDocumentosRomaneio.fInserirDocumentoTemporaria(const ANomTab: String;
  const ASeqDocumento: String; const AEntSai: String): Boolean;
var
  LSQL: String;
begin
  if fEmptyStr(ASeqDocumento) then
    Exit(True);

  LSQL := EmptyStr;
  LSQL := LSQL + STR_SQL_NAO_REPLICAR;
  LSQL := LSQL + ' SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; ';
  LSQL := LSQL + ' INSERT INTO ' + ANomTab + ' (TMP_AUTINC, TMP_ENTSAI) ';
  LSQL := LSQL + ' VALUES (' + QuotedStr(ASeqDocumento) + ', ' + QuotedStr(AEntSai) + '); ';
  LSQL := LSQL + DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
  Result := fExecutaSQL(LSQL, True);
end;

procedure TTemporariaDocumentosRomaneio.pAddInserirDocumentoTemporaria(const ANomTab: String; const ASeqDocumento: String; const AEntSai: String);
  Var
    LValues : TInsertValues;
begin
  If fEmptyStr(ANomTab) Then
    Raise Exception.Create('Temporary table name is empty.');

  If (fEmptyStr(ASeqDocumento)) Then
    Exit;

  If FTables.IndexOf(ANomTab) < 0 Then
    FTables.Add(ANomTab);

  FillChar(LValues, SizeOf(LValues), #0);
  LValues.strNomTab := ANomTab;
  LValues.strInsert := '(' + QuotedStr(ASeqDocumento) + ', ' + QuotedStr(AEntSai) + ')';

  FInserts.Add(LValues);
end;

procedure TTemporariaDocumentosRomaneio.pExecutaInsertsTemporaria;
  Var
    LSQLInsertsValues : String;
    LSQL : String;
    LCountTab : Integer;
    LInsertValues : TInsertValues;
begin
  If (FInserts.Count = 0) Then
    Exit;

  If (FTables.Count = 0) Then
    Exit;

  For LCountTab := 0 To Pred(FTables.Count) Do
  Begin
    LSQL := EmptyStr;
    LSQL := LSQL + STR_SQL_NAO_REPLICAR;
    LSQL := LSQL + ' SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; ';
    LSQL := LSQL + ' INSERT INTO ' + FTables[LCountTab] + ' (TMP_AUTINC, TMP_ENTSAI) VALUES ';
    LSQLInsertsValues := '';
    For LInsertValues In FInserts Do
    Begin
      If (LInsertValues.strNomTab <> FTables[LCountTab]) Then
        Continue;
      If LSQLInsertsValues.IsEmpty Then
        LSQLInsertsValues := LInsertValues.strInsert
      Else
        LSQLInsertsValues := LSQLInsertsValues + ', ' + LInsertValues.strInsert;
    End;
    LSQL := LSQL + LSQLInsertsValues + ' ;';
    LSQL := LSQL + DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
    fExecutaSQL(LSQL, True);
  End;

  FInserts.Clear;
  FTables.Clear;
end;

function TTemporariaDocumentosRomaneio.fInserirDocumentoTmpCRM(const ANomTab: String; ATabela, ANumDoc, AEspDoc,
  ACodEmp, AAutInc, ACodCli, ACodVen, AEntSai, ANumRom: String): Boolean;
var
  LSQL: String;
begin
  LSQL := EmptyStr;
  LSQL := LSQL + STR_SQL_NAO_REPLICAR;
  LSQL := LSQL + ' SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; ';
  LSQL := LSQL + ' INSERT INTO ' + ANomTab + ' (TMP_TABELA, TMP_NUMDOC, TMP_ESPDOC, TMP_CODEMP, ';
  LSQL := LSQL + '   TMP_CODCLI, TMP_CODVEN, TMP_ENTSAI, TMP_AUTINC, TMP_NUMROM) ';
  LSQL := LSQL + ' VALUES (' + QuotedStr(ATabela) + ', ' + QuotedStr(ANumDoc) + ', ' + QuotedStr(AEspDoc) + ', ';
  LSQL := LSQL + QuotedStr(ACodEmp) + ', ' + QuotedStr(ACodCli) + ', ' + QuotedStr(ACodVen) + ', ';
  LSQL := LSQL + QuotedStr(AEntSai) + ', ' + QuotedStr(AAutInc) + ', ' + QuotedStr(ANumRom) + '); ';
  LSQL := LSQL + DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
  Result := fExecutaSQL(LSQL, True);
end;

function TTemporariaDocumentosRomaneio.fPegaProximoNomeTemporaria: String;
var
  LSeqTab: String;
begin
  LSeqTab := fRetSequencial('TPDROM', VS_strCodEmp, 12);
  Result := 'TMP_TPDROM_' + VS_strCodEmp + '_' + LSeqTab;
end;

function TTemporariaDocumentosRomaneio.fTemRegistrosTabela(const ANomTab: String): Boolean;
begin
  Result := fRetornaCountDados(ANomTab, '1', '') > 0;
end;

procedure TTemporariaDocumentosRomaneio.pApagarTemporaria(const ANomTab: String);
begin
  try
    if ANomTab.IsEmpty then
      Exit;

    if (not fTabelaExiste(ANomTab)) then
      Exit;

    fDropTable(ANomTab);
  except
  end;
end;

procedure TTemporariaDocumentosRomaneio.pLimparTemporaria(const ANomTab: String);
var
  LSQL: String;
begin
  try
    if ANomTab.IsEmpty then
      Exit;

    if (not fTabelaExiste(ANomTab)) then
      Exit;

    LSQL := EmptyStr;
    LSQL := LSQL + 'DELETE FROM ' + ANomTab;
    fExecutaSQL(LSQL, True);
  except
  end;
end;

end.
