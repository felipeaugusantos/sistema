unit untLogBan;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy,
  Classes, untFieldFiltros, Aurelius.Criteria.Base, Aurelius.Criteria.Linq, Uni;

Type
  TLogBanDS = Class
  private
    FAUTOINCREM,
    FCTB_SEQLAN: String;
  protected
    function RetornaSQLInsert: String; virtual;
    procedure AdicionaParametros(ALogBanDS: TLogBanDS; var ARegistros: TUniQuery); virtual;

    function getOperad: string; virtual;
    function getOrigem: string; virtual;
    function getTabela: string; virtual;
  public
    property strAutInc: string    read FAUTOINCREM write FAUTOINCREM;
    property strSeqLan: String    read FCTB_SEQLAN write FCTB_SEQLAN;
    property strOperad: string    read getOperad;
    property fGetOrigem: string   read getOrigem;
    property strTabela: string    read getTabela;
  End;

Type
  TGravaLogBanDS = Class
  private
  public
    class function GravaLogBanDS(ALogBan: TLogBanDS;
                                 strCodEmp: String;
                                 strSeqLan: String): Boolean;

    class function fGetOrigem(ALogBan: TLogBanDS): String;
  End;

type
  [Entity]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TLogBan = Class
  private
    [Column('CTB_SEQLAN', [TColumnProp.Required], 13)]
    FCTB_SEQLAN: string;

    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: string;
  public
    property strAutInc: string read FAUTOINCREM write FAUTOINCREM;
    property strSeqLan: string read FCTB_SEQLAN write FCTB_SEQLAN;
    function fGetOrigem: String; virtual; abstract;
  End;

  TGravaLogBan = Class
  public
    class function fGravaLogBan(ALogBan: TLogBan;
                                strCodEmp: String;
                                strSeqLan: String): Boolean;

    class function fGetOrigem(ALogBan: TLogBan): String;
  End;

  TFiltros = class sealed
  Public
    strSeqLan: TFieldFiltros<String>;
    Constructor Create;
  End;

  TLogBanFilter = Class
  private
    blnCriouObj : Boolean;
    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecutaList<E: class>(Filter: TFiltros): TList<E>;
  public
    function fRetDocumentos<E: Class>(strSeqLan: String): TList<E>;
    Constructor Create;
    Destructor Destroy; Override;
  End;

  TLogBanRepository = Class
  private
    objLogBanFiltro : TLogBanFilter;
  public
    function fAdd():Integer; virtual; abstract;
    function fGetList: TList<TLogBan>; virtual; abstract;
    procedure pMerge(arrListLogban: Array Of TList<TLogBan>); virtual; abstract;
    procedure pClear; virtual; abstract;
    function fRetDocumentos<E: Class>(strSeqLan: String): TList<E>;
    Constructor Create;
    Destructor Destroy; Override;
  End;

implementation

uses untUtilRepository, untObjectManager, untFuncoesSimples;

{ TGravaLogBan }

class function TGravaLogBan.fGetOrigem(ALogBan: TLogBan): String;
begin
  If Assigned(ALogBan) Then
    Result := ALogBan.fGetOrigem
  Else
    Result := '';
end;

class function TGravaLogBan.fGravaLogBan(ALogBan: TLogBan;
                                         strCodEmp: String;
                                         strSeqLan: String): Boolean;
  Var
    blnCriouObj : Boolean;
begin
  Try
    blnCriouObj := False;
    frwk := fCriaObjManager(blnCriouObj);

    ALogBan.strSeqLan := strSeqLan;
    If (fEmptyStr(ALogBan.strAutInc)) Then
      ALogBan.strAutInc := fRetAutoIncrem(TUtil.fRetTableName(ALogBan), strCodEmp);
    frwk.objDBManager.Save(ALogBan);

    Result := True;
  Except
    On E: Exception Do
      Raise Exception.Create('[fGravaLogBan] - ' + E.Message);
  End;

  If (blnCriouObj) Then
    FreeAndNil(frwk);
end;

{ TLogBanRepository }

constructor TLogBanRepository.Create;
begin
  objLogBanFiltro := TLogBanFilter.Create;
end;

destructor TLogBanRepository.Destroy;
begin
  FreeAndNil(objLogBanFiltro);
  inherited;
end;

function TLogBanRepository.fRetDocumentos<E>(strSeqLan: String): TList<E>;
begin
  Result := objLogBanFiltro.fRetDocumentos<E>(strSeqLan);
end;

{ TFiltros }

constructor TFiltros.Create;
begin
end;

{ TLogBanFilter }

constructor TLogBanFilter.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
end;

destructor TLogBanFilter.Destroy;
begin
  If blnCriouObj Then FreeAndNil(frwk);
  inherited;
end;

function TLogBanFilter.fExecutaList<E>(Filter: TFiltros): TList<E>;
begin
  Result := fFiltrar<E>(Filter).List<E>;
end;

function TLogBanFilter.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If Not fEmptyStr(Filter.strSeqLan) Then
  Begin
    Case Filter.strSeqLan.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTB_SEQLAN'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTB_SEQLAN'));
      opcDiferente: ACriteria.Add(TLinq.Lt('FCTB_SEQLAN', Filter.strSeqLan) Or
                                  TLinq.Gt('FCTB_SEQLAN', Filter.strSeqLan));
      Else
        ACriteria.Add(TLinq.Eq('FCTB_SEQLAN', Filter.strSeqLan));
    End;
  End;

  Result := ACriteria;
end;

function TLogBanFilter.fRetDocumentos<E>(strSeqLan: String): TList<E>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.strSeqLan := strSeqLan;
  Result := fExecutaList<E>(Filter);
  FreeAndNil(Filter);
end;

{ TLogBanDS }

procedure TLogBanDS.AdicionaParametros(ALogBanDS: TLogBanDS;
  var ARegistros: TUniQuery);
begin
  //criar no filho
end;

function TLogBanDS.getOperad: string;
begin
  //criar no filho
end;

function TLogBanDS.getOrigem: string;
begin
  //criar no filho
end;

function TLogBanDS.getTabela: string;
begin
  //criar no filho
end;

function TLogBanDS.RetornaSQLInsert: String;
begin
  //criar no filho
end;

{ TGravaLogBanDS }

class function TGravaLogBanDS.fGetOrigem(ALogBan: TLogBanDS): String;
begin
  Result := ALogBan.fGetOrigem;
end;

class function TGravaLogBanDS.GravaLogBanDS(ALogBan: TLogBanDS; strCodEmp,
  strSeqLan: String): Boolean;
  Var
    LGravarRegistros: TUniQuery;
begin
  Result := False;

  LGravarRegistros := fCriaQuery;

  Try
    Try
      ALogBan.strSeqLan := strSeqLan;

      If ALogBan.strAutInc.IsEmpty Then
        ALogBan.strAutInc := fRetAutoIncrem(ALogBan.strTabela, strCodEmp);

      LGravarRegistros.SQL.Text := ALogBan.RetornaSQLInsert;
      ALogBan.AdicionaParametros(ALogBan, LGravarRegistros);
      LGravarRegistros.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  Finally
    LGravarRegistros.Close;

    FreeAndNil(LGravarRegistros);
  End;
end;

end.
