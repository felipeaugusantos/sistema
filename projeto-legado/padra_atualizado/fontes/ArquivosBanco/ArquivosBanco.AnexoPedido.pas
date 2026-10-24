unit ArquivosBanco.AnexoPedido;

interface

uses
  ArquivosBanco.Interfaces, ArquivosBanco.Base;

type
  TArquivosBancoAnexoPedido = class(TArquivosBancoBase)
  public
    function fTabela: String; override;
    function fPrefixo: String; override;
    function fCampoFK: String; override;
    function fTitulo: String; override;
    function fFileOpenFilter: String; override;

    class function New: IArquivosBancoInterface;
  end;

implementation

{ TArquivosBancoAnexoPedido }

function TArquivosBancoAnexoPedido.fCampoFK: String;
begin
  Result := 'APD_SEQFGO';
end;

function TArquivosBancoAnexoPedido.fFileOpenFilter: String;
begin
  Result := 'Arquivos suportados|*.jpeg;*.jpg;*.png;*.pdf'
end;

function TArquivosBancoAnexoPedido.fPrefixo: String;
begin
  Result := 'APD_';
end;

function TArquivosBancoAnexoPedido.fTabela: String;
begin
  Result := 'ARQAPD';
end;

function TArquivosBancoAnexoPedido.fTitulo: String;
begin
  Result := 'Anexos do Pedido';
end;

class function TArquivosBancoAnexoPedido.New: IArquivosBancoInterface;
begin
  Result := Self.Create;
end;

end.
