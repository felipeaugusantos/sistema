unit OrdemProducaoIndustrial.TFiltroProduto;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  untFuncoesConsulta,
{$ENDIF}
  untTypesSistema,
  Classes,
  SysUtils;

Type
  TFiltroProduto = class
    private
      FReferencia: String;
      FCodigoDepartamento: String;
      FApenasAtivo: boolean;
      FCodigo: String;
      FLinhaGrupo: String;
      FCodigoMarca: String;
      FConsiderarTodosGruposDaLinha: Boolean;
      FLinha: String;

      function getCodigo: String;
      function getCodigoDepartamento: String;
      function getLinhaGrupo: String;
      function getReferencia: String;
      function getCodigoMarca: String;
    public
      property strReferencia: String         read getReferencia         write FReferencia;
      property strCodigoDepartamento: String read getCodigoDepartamento write FCodigoDepartamento;
      property strCodigo: String             read getCodigo             write FCodigo;
      property strLinhaGrupo: String         read getLinhaGrupo         write FLinhaGrupo;
      property strCodigoMarca: String        read getCodigoMarca        write FCodigoMarca;
      property blnApenasAtivo : boolean      read FApenasAtivo          write FApenasAtivo;
      property ConsiderarTodosGruposDaLinha: Boolean    read FConsiderarTodosGruposDaLinha write FConsiderarTodosGruposDaLinha;
      property Linha: String                            read FLinha                write FLinha;

      constructor Create;

      procedure pClonaObjeto(objFiltroOriginal : TFiltroProduto);
      function fRetornaFiltro(strCodigo: String; arrCodigos: TConsultasArray): String;
  End;

implementation

{ TFiltroProduto }

constructor TFiltroProduto.Create;
begin
  FReferencia := '';
  FCodigoDepartamento := '';
  FApenasAtivo := False;
  FCodigo := '';
  FLinhaGrupo := '';
end;

function TFiltroProduto.getCodigo: String;
begin
  Result := Trim(FCodigo);
end;

function TFiltroProduto.getCodigoDepartamento: String;
begin
  Result := Trim(FCodigoDepartamento);
end;

function TFiltroProduto.getCodigoMarca: String;
begin
  Result := Trim(FCodigoMarca);
end;

function TFiltroProduto.getLinhaGrupo: String;
begin
  Result := Trim(FLinhaGrupo);
end;

function TFiltroProduto.getReferencia: String;
begin
  Result := Trim(FReferencia);
end;

procedure TFiltroProduto.pClonaObjeto(objFiltroOriginal: TFiltroProduto);
begin
  Self.FReferencia := objFiltroOriginal.strReferencia;
  Self.FCodigoDepartamento := objFiltroOriginal.strCodigoDepartamento;
  Self.FApenasAtivo := objFiltroOriginal.blnApenasAtivo;
  Self.FCodigo := objFiltroOriginal.strCodigo;
  Self.FLinhaGrupo := objFiltroOriginal.strLinhaGrupo;
  Self.FCodigoMarca := objFiltroOriginal.strCodigoMarca;
end;

function TFiltroProduto.fRetornaFiltro(strCodigo: String; arrCodigos: TConsultasArray): String;
begin
  if Trim(strCodigo) <> '' then
  begin
    if Length(arrCodigos) > 1 then
      Result := fArrCodigosToLista(strCodigo, arrCodigos)
    else
      Result := QuotedStr(strCodigo);
  end
  else
    Result := '';
end;

end.
