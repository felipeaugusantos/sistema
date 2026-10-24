unit Expedicao.TManutencaoSeparadoresPorLocal;

interface

uses
  Classes,
  SysUtils,
  Data.DB,

  Expedicao.TSQLSeparadorLocalSeparacao,
  Expedicao.TManutencaoSeparadoresPorLocalConstantes;

Type
  TMetodoUpdate = reference to procedure ( strAutoincremFATGOR, strCodigoLocalSeparacao, strCodigoSeparadorNovo : String );

  TManutencaoSeparadoresPorLocal = class
  private
    FSQLSeparadorLocalSeparacao: ISQLSeparadorLocalSeparacao;
    FLocais: TDataSet;
  public

    function fVerificaSeAtualizaSeparador( strCodigoSeparadorAntigo, strCodigoSeparadorNovo: String ): Boolean;
    function fPermiteAlterarSeparador( strStatuSeparacao: String ): Boolean;
    class function fUtilizaSeparadorPorLocal( strSENSEP : String; blnUtiWms, blnLseWms: Boolean ) : Boolean;

    procedure pAtualizaSeparadores(  strAutoincremFATGOR: String ; metodoUpdate : TMetodoUpdate );

    Constructor Create( blnLSEWMS : Boolean );

    property objSQLSeparadorLocalSeparacao : ISQLSeparadorLocalSeparacao read FSQLSeparadorLocalSeparacao write FSQLSeparadorLocalSeparacao;
    property dtsLocais : TDataSet read FLocais write FLocais;
  end;

implementation

{ TManutencaoSeparadoresPorLocal }

constructor TManutencaoSeparadoresPorLocal.Create(blnLSEWMS: Boolean);
begin
  if blnLSEWMS then
    FSQLSeparadorLocalSeparacao := TSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.Create()
  else
    FSQLSeparadorLocalSeparacao := TSQLSeparadorLocalSeparacaoPorItem.Create();
end;


class function TManutencaoSeparadoresPorLocal.fUtilizaSeparadorPorLocal(strSENSEP: String; blnUtiWms, blnLseWms: Boolean): Boolean;
begin
  if strSENSEP = '' then
    exit(False);

  if strSENSEP = 'N' then
    exit(False);

  if not blnUtiWms then
    Exit(False);

  if not blnLseWms then
    Exit(False);

  exit(True);
end;

procedure TManutencaoSeparadoresPorLocal.pAtualizaSeparadores( strAutoincremFATGOR: String ;metodoUpdate: TMetodoUpdate);
begin
  if not Assigned(dtsLocais) then
    Raise Exception.Create('Objeto dtsLocais não atribuído!');

  dtsLocais.First;
  while not dtsLocais.EOF do
  begin
    if fVerificaSeAtualizaSeparador(dtsLocais.FieldByName( TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_ATUAL ).AsString , dtsLocais.FieldByName( TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_NOVO ).AsString) then
        metodoUpdate( strAutoincremFATGOR, dtsLocais.FieldByName( TManutencaoSeparadoresPorLocalConstantes.CAMPO_CODIGO_LOCAL_SEPARACAO ).AsString, dtsLocais.FieldByName( TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_NOVO ).AsString );

    dtsLocais.Next();
  end;
end;

function TManutencaoSeparadoresPorLocal.fPermiteAlterarSeparador( strStatuSeparacao : String ) : Boolean;
begin
  Result := strStatuSeparacao <> TManutencaoSeparadoresPorLocalConstantes.VALOR_SEPARACAO_INICIADA;
end;

function TManutencaoSeparadoresPorLocal.fVerificaSeAtualizaSeparador(strCodigoSeparadorAntigo, strCodigoSeparadorNovo : String) : Boolean;
begin

  if Trim(strCodigoSeparadorNovo) = '' then
    exit(False);

  if (strCodigoSeparadorNovo = strCodigoSeparadorAntigo) then
    exit(False);

  exit(True);

end;

end.
