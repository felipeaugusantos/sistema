unit untOperadorasExclusaoArquivosCartoes;

interface

type
  IOperadora = interface
    function fGetColunaDTAARQ: string;
    function fGetColunaNOMARQ: string;
    function fGetColunaCONCIL: string;
    function fGetDireitoAcesso: string;
    function fGetNomeRotina: string;
    function fGetTabela: string;
    function fGetNomeOperadora: string;

    property ColunaDTAARQ: string read fGetColunaDTAARQ;
    property ColunaNOMARQ: string read fGetColunaNOMARQ;
    property ColunaCONCIL: string read fGetColunaCONCIL;
    property DireitoAcesso: string read fGetDireitoAcesso;
    property NomeRotina: string read fGetNomeRotina;
    property Tabela: string read fGetTabela;
    property NomeOperadora: string read fGetNomeOperadora;
  end;

  TCielo = class(TInterfacedObject, IOperadora)
  private
    function fGetColunaDTAARQ: string;
    function fGetColunaNOMARQ: string;
    function fGetColunaCONCIL: string;
    function fGetDireitoAcesso: string;
    function fGetNomeOperadora: string;
    function fGetNomeRotina: string;
    function fGetTabela: string;
  end;

  TGetNet = class(TInterfacedObject, IOperadora)
  private
    function fGetColunaDTAARQ: string;
    function fGetColunaNOMARQ: string;
    function fGetColunaCONCIL: string;
    function fGetDireitoAcesso: string;
    function fGetNomeOperadora: string;
    function fGetNomeRotina: string;
    function fGetTabela: string;
  end;

implementation

{ TCielo }

function TCielo.fGetColunaCONCIL: string;
begin
  Result := 'CIE_CONCIL';
end;

function TCielo.fGetColunaDTAARQ: string;
begin
  Result := 'CIE_DTAARQ';
end;

function TCielo.fGetColunaNOMARQ: string;
begin
  Result := 'CIE_NOMARQ';
end;

function TCielo.fGetDireitoAcesso: string;
begin
  Result := 'mnuExcluirArquivoDaCielo';
end;

function TCielo.fGetNomeOperadora: string;
begin
  Result := 'Cielo';
end;

function TCielo.fGetNomeRotina: string;
begin
  Result := 'Excluir arquivos importados da Cielo';
end;

function TCielo.fGetTabela: string;
begin
  Result := 'CIE_CIPGTO';
end;

{ TGetNet }

function TGetNet.fGetColunaCONCIL: string;
begin
  Result := 'GET_CONCIL';
end;

function TGetNet.fGetColunaDTAARQ: string;
begin
  Result := 'GET_DTAARQ';
end;

function TGetNet.fGetColunaNOMARQ: string;
begin
  Result := 'GET_NOMARQ';
end;

function TGetNet.fGetDireitoAcesso: string;
begin
  Result := 'mnuExcluirArquivoDaGetNet';
end;

function TGetNet.fGetNomeOperadora: string;
begin
  Result := 'GetNet';
end;

function TGetNet.fGetNomeRotina: string;
begin
  Result := 'Excluir arquivos importados da GetNet';
end;

function TGetNet.fGetTabela: string;
begin
  Result := 'GET_GEPGTO';
end;

end.
