unit untTCadCliRepository;

interface

uses untTCadCli, Aurelius.Criteria.Base, System.Generics.Collections,
  System.SysUtils, Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros,
  Classes, untUtilRepository, untTestabilidade;

Type
  TFiltros = class sealed
  Public
    strCodCli: TFieldFiltros<String>;

    Constructor Create;
  End;

  TCadCliRepository = class
  Private

    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecuta(Filter: TFiltros): TCadCli;

  Public
    procedure pAtualizar;
    function fRetCadCli(strCodCli: String): TCadCli;

    Constructor Create;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoesSimples, Data.DB;

{ TFiltros }

constructor TFiltros.Create;
begin
  strCodCli := '';
end;

{ TCadCliRepository }

constructor TCadCliRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
end;

destructor TCadCliRepository.Destroy;
begin
  If blnCriouObj Then
    FreeAndNil(frwk);
  inherited;
end;

function TCadCliRepository.fExecuta(Filter: TFiltros): TCadCli;
  Var
    lstCli: TList<TCadCli>;
begin
  lstCli := fFiltrar<TCadCli>(Filter).List<TCadCli>;

  If (Not Assigned(lstCli)) Or (lstCli.Count <= 0) Then
    Result := Nil
  Else
    Result := lstCli[0];
end;

function TCadCliRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If Not fEmptyStr(Filter.strCodCli) Then
    ACriteria.Add(TLinq.Eq('FCLI_CODCLI', Filter.strCodCli));

  Result := ACriteria;
end;

procedure TCadCliRepository.pAtualizar;
begin
  frwk.objDBManager.Flush;
end;

function TCadCliRepository.fRetCadCli(strCodCli: String): TCadCli;
  Var
    Filter: TFiltros;
Begin
  Try
    Filter := TFiltros.Create;
    Filter.strCodCli := strCodCli;

    Result := fExecuta(Filter);
    FreeAndNil(Filter);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao retornar os dados do cliente com código: ' + strCodCli + '.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
End;

end.
