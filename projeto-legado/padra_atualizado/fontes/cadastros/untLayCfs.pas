unit untLayCfs;

interface


Uses
  Classes,
  SysUtils,
  Controls,
  DB,
  UniClientDataSet,
  Forms,
  Uni,
  untZClient;

Type

  TCampo = class
  private
    FstrCodigo: String;
    FstrDescricao: String;
    FstrTipoCampo: String;
    FstrObrigatorio: String;
    FstrCadFis: String;
  public
    function fCadFis(strCadFis: String): TCampo; overload;
    function fCadFis: String; overload;

    function fCodigo(strCodigo: String): TCampo; overload;
    function fCodigo: String; overload;
    function fDescricao(strDescricao: String): TCampo; overload;
    function fDescricao: String; overload;
    function fDescricaoCompleta: String; overload;
    function fTipoCampo(strTipoCampo: String): TCampo; overload;
    function fTipoCampo: String; overload;
    function fObrigatorio(strObrigatorio: String): TCampo; overload;
    function fObrigatorio: String; overload;
    class function fNovo: TCampo;
  End;


  TLayCFS = Class(TZClient)
    Private
      Function fSQL: String;
    Public
      constructor Create(Owner: TComponent); Reintroduce;
      function fCampos: TStrings;
      function fOpen: TLayCFS;
    class function fNovo: TLayCFS;
  End;

implementation

{ TLayCFS }

constructor TLayCFS.Create(Owner: TComponent);
begin
  Inherited Create(Owner, fSQL);
end;

function TLayCFS.fCampos: TStrings;
begin
  Result := TStringList.Create;
  fAbreClient(True, 'TLayCFS.fCampos');
  Result.AddObject('',nil);
  While Not Eof Do
  Begin
    Result.AddObject(FieldByName('LAY_DESCAM').AsString,
      TCampo
        .fNovo
        .fCodigo(FieldByName('AUTOINCREM').AsString)
        .fDescricao(FieldByName('LAY_DESCAM').AsString)
        .fTipoCampo(FieldByName('LAY_TIPCAM').AsString)
        .fCadFis(FieldByName('LAY_DESCFS').AsString)
        .fObrigatorio(FieldByName('LAY_OBRIGA').AsString));
    Next;
  End;
end;

class function TLayCFS.fNovo: TLayCFS;
begin
  Result := TLayCFS.Create(Application);
end;

function TLayCFS.fOpen: TLayCFS;
begin
  Result := Self;
  fAbreClient(True, 'TLayCFS.fOpen');
end;

function TLayCFS.fSQL: String;
begin
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '   LAYCFS.*,  ';
  Result := Result + '   CONCAT(LAY_DESCAM," (", LAY_DESCFS, ")") LAY_DESCOM  ';
  Result := Result + ' FROM ';
  Result := Result + '   LAYCFS ';
end;

{ TCampo }


{ TCampo }

function TCampo.fCodigo(strCodigo: String): TCampo;
begin
  Result := Self;
  FstrCodigo := strCodigo;
end;

function TCampo.fDescricao(strDescricao: String): TCampo;
begin
  Result := Self;
  FstrDescricao := strDescricao;
end;

function TCampo.fDescricao: String;
begin
  Result := FstrDescricao;
end;

function TCampo.fDescricaoCompleta: String;
begin
  Result := FstrDescricao + ' (' + FstrCadFis +')';
end;

class function TCampo.fNovo: TCampo;
begin
  Result := TCampo.Create;
end;

function TCampo.fObrigatorio(strObrigatorio: String): TCampo;
begin
  Result := Self;
  FstrObrigatorio := strObrigatorio;
end;

function TCampo.fObrigatorio: String;
begin
  Result := FstrObrigatorio;
end;

function TCampo.fTipoCampo(strTipoCampo: String): TCampo;
begin
  Result := Self;
  FstrTipoCampo := strTipoCampo;
end;

function TCampo.fTipoCampo: String;
begin
  Result := FstrTipoCampo;
end;

function TCampo.fCadFis(strCadFis: String): TCampo;
begin
  result := Self;
  FstrCadFis := strCadFis;
end;

function TCampo.fCadFis: String;
begin
  Result := FstrCadFis;
end;

function TCampo.fCodigo: String;
begin
  Result := FstrCodigo;
end;

end.
