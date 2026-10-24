unit Contabilidade.Classes.ImportacaoModeloContabil;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  Contabilidade.Classes.TImportacaoDadosContabeis;

const
  CSV_TAG_META        = 'META';
  CSV_TAG_BEGIN_TABLE = 'BEGIN_TABLE';
  CSV_TAG_END_TABLE   = 'END_TABLE';
  CSV_TAG_ROW         = 'ROW';
  CSV_TAG_END_ROW     = 'END_ROW';

  CSV_DEFAULT_VERSION   = '1.0';
  CSV_DEFAULT_CHARSET   = 'UTF-8';
  CSV_DEFAULT_SEPARATOR = ';';

type
  TImportacaoModeloContabilMeta = record
    strVersion: string;
  end;

  TImportacaoModeloContabilTabela = class
  private
    FstrNome: string;
    FFonte  : IImportacaoDadosContabeisFonte;
  public
    constructor Create(const AstrNome: string; AFonte: IImportacaoDadosContabeisFonte);

    property Nome: string read FstrNome;
    property Fonte: IImportacaoDadosContabeisFonte read FFonte;
  end;

  TImportacaoModeloContabilTabelaLista = TObjectList<TImportacaoModeloContabilTabela>;

implementation

{ TImportacaoModeloContabilTabela }

constructor TImportacaoModeloContabilTabela.Create(const AstrNome: string;
  AFonte: IImportacaoDadosContabeisFonte);
begin
  FstrNome := AstrNome;
  FFonte   := AFonte;
end;

end.
