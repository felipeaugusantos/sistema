unit untTRomaneioRepository;

interface

uses untTRomaneio, Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
     Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable,
     System.Generics.Defaults;

Type

  TFiltros = class sealed
  Public
    AutoIncremento  : TFieldFiltros<String>;
    Constructor Create;
  End;

  TRomaneioRepository = class
  Private
    blnCriouObj  : Boolean;
    FSelecionado : TRomaneio;
    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecuta(AFilter: TFiltros): TRomaneio;
  Public
    function fGetRomaneio(AutoIncremento : String): TRomaneio;

    class function fRomaneioVinculadoComDespesa(AnumeroRomaneio, ADocumento, AEmpresa : String;
      var AMensagem : String) : Boolean;

    Constructor Create;
    Destructor Destroy; Override;
    property Selecionado : TRomaneio read FSelecionado write FSelecionado;
  End;

implementation

uses untFuncoesSimples, untUtilRepository, Uni, Data.DB;

{ TFiltros }

constructor TFiltros.Create;
begin
  AutoIncremento := '';
end;

{ TRomaneioRepository }

constructor TRomaneioRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
end;

destructor TRomaneioRepository.Destroy;
begin
  If blnCriouObj Then
    FreeAndNil(frwk);
  inherited;
end;

function TRomaneioRepository.fExecuta(AFilter: TFiltros): TRomaneio;
begin
  Result := fFiltrar<TRomaneio>(AFilter).UniqueResult<TRomaneio>;
end;

function TRomaneioRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
Var ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If Not fEmptyStr(Filter.AutoIncremento.Value) Then
  Begin
    Case Filter.AutoIncremento.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FAutoIncremento'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FAutoIncremento'));
      Else ACriteria.Add(TLinq.Eq('FAutoIncremento', Filter.AutoIncremento));
    End;
  End;

  Result := ACriteria;
end;

function TRomaneioRepository.fGetRomaneio(AutoIncremento: String): TRomaneio;
Var SFilter: TFiltros;
begin
  SFilter := TFiltros.Create;
  try
    SFilter.AutoIncremento  := AutoIncremento;
    Result := fExecuta(SFilter);
  finally
    FreeAndNil(SFilter);
  end;

end;

class function TRomaneioRepository.fRomaneioVinculadoComDespesa(AnumeroRomaneio, ADocumento, AEmpresa: String;
  var AMensagem : String): Boolean;
var SQuery : TUniQuery;
begin
  Result := False;

  If fEmptyStr(AnumeroRomaneio) Then
    Exit;
    
  SQuery := fCriaQuery();
  Try
    SQuery.SQL.Add(' SELECT P.PGR_NUMDUP, P.PGR_SERIE_, P.PGR_CODFOR, P.PGR_CODEMP '+
                   '  FROM PAGROM P '+
                   '  JOIN ROMGERX R ON P.PGR_AUTROM = R.AUTOINCREM '+
                   ' WHERE R.GER_NUMROM = :NUMROM ');

    if not fEmptyStr(ADocumento) then
      SQuery.SQL.Add(' AND R.GER_NUMDOC = :NUMDOC ');

    if not fEmptyStr(AEmpresa) then
      SQuery.SQL.Add(' AND R.GER_CODEMP = :CODEMP ');

    SQuery.ParamByName('NUMROM').AsString := AnumeroRomaneio;

    if not fEmptyStr(ADocumento) then
      SQuery.ParamByName('NUMDOC').AsString := ADocumento;

    if not fEmptyStr(AEmpresa) then
      SQuery.ParamByName('CODEMP').AsString := AEmpresa;

    SQuery.Open;
    if not SQuery.IsEmpty then
    begin
      Result := True;
      AMensagem := 'Romaneio vinculado a despesa, não será permitido sua exclusão. '+ #13#10 +
      'Para desvincular vá até a manutenção de contas a pagar e selecione a duplicata "'+SQuery.FieldByName('PGR_NUMDUP').AsString+'", série '+
      '"'+SQuery.FieldByName('PGR_SERIE_').AsString+'", empresa "'+SQuery.FieldByName('PGR_CODEMP').AsString+
      '" e fornecedor "'+SQuery.FieldByName('PGR_CODFOR').AsString+'".';
    end;
    SQuery.Close;
  Finally
    FreeAndNil(SQuery);
  End;
end;

end.
