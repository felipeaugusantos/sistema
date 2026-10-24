unit ArquivosBanco.AceiteLGPD;

interface

uses
  ArquivosBanco.Interfaces, ArquivosBanco.Base;

type
  TArquivosBancoAceiteLDPG = class(TArquivosBancoBase)
  public
    function fTabela: String; override;
    function fPrefixo: String; override;
    function fCampoFK: String; override;
    function fTitulo: String; override;
    function fFileOpenFilter: String; override;

    class function New: IArquivosBancoInterface;
  end;

implementation

{ TArquivosBancoAceiteLDPG }

function TArquivosBancoAceiteLDPG.fCampoFK: String;
begin
  Result := 'ACE_CODCLI';
end;

function TArquivosBancoAceiteLDPG.fFileOpenFilter: String;
begin
  Result := 'Arquivos suportados|*.jpeg;*.jpg;*.png;*.pdf'
end;

function TArquivosBancoAceiteLDPG.fPrefixo: String;
begin
  Result := 'ACE_';
end;

function TArquivosBancoAceiteLDPG.fTabela: String;
begin
  Result := 'ARQACE';
end;

function TArquivosBancoAceiteLDPG.fTitulo: String;
begin
  Result := 'Arquivos de Aceite - LGPD';
end;

class function TArquivosBancoAceiteLDPG.New: IArquivosBancoInterface;
begin
  Result := Self.Create;
end;

end.
