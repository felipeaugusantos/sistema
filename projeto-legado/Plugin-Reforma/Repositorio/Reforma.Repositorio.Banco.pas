unit Reforma.Repositorio.Banco;

// Onde a simulacao das abas 2 e 3 fica guardada. TSimulacaoReforma escolhe a implementacao pelo CFG_REFCIS:
//  - 'N': so os parametros do Calculo Novo, na REFPRE (Reforma.Repositorio.Refpre, REFTRI-01);
//  - 'S': em lugar nenhum (TRepositorioSemPersistencia). A ITEREF deixou de guardar a simulacao: agora e o backup
//    dos valores novos do Convert (REFTRI-02, RF14/RN20), com outra estrutura (Reforma.Repositorio.Estrutura).

interface

uses
  Data.DB,
  Reforma.Contrato.Gravacao;

type
  IRepositorioSimulacao = interface
    ['{56C967B2-D64B-4923-8A83-B4C4F3FA8F9E}']
    // False quando o banco nao tem onde gravar: o plugin segue sem gravar nem ler, e sem erro.
    function Disponivel: Boolean;
    // Campo do dataset que vai para a tabela (o dataset tambem tem os calculados). A pendencia so olha estes.
    function Gravado(const NomeCampo: string): Boolean;
    // True: a linha gravada substitui o resultado da carga inteira. False: a linha guarda so parametros, que entram
    // antes do calculo inicial (REFPRE, RN05 do REFTRI-01).
    function GuardaFormacaoCompleta: Boolean;
    // Copia a linha da empresa e do item para o dataset. False quando a tabela ou a linha nao existe.
    function Ler(const CodigoItem: string; const Dados: TDataSet): Boolean;
    // Sucesso sem gravar nada quando nao ha onde gravar ou o item nao tem codigo.
    function Gravar(const CodigoItem: string; const Dados: TDataSet): TResultadoGravacao;
  end;

  // CFG_REFCIS = 'S': a simulacao fica so em memoria. Nao le nem grava nada e nunca fica pendente.
  TRepositorioSemPersistencia = class(TInterfacedObject, IRepositorioSimulacao)
  public
    function Disponivel: Boolean;
    function Gravado(const NomeCampo: string): Boolean;
    function GuardaFormacaoCompleta: Boolean;
    function Ler(const CodigoItem: string; const Dados: TDataSet): Boolean;
    function Gravar(const CodigoItem: string; const Dados: TDataSet): TResultadoGravacao;
  end;

implementation

function TRepositorioSemPersistencia.Disponivel: Boolean;
begin
  Result := False;
end;

function TRepositorioSemPersistencia.Gravado(const NomeCampo: string): Boolean;
begin
  Result := False;
end;

function TRepositorioSemPersistencia.GuardaFormacaoCompleta: Boolean;
begin
  Result := False;
end;

function TRepositorioSemPersistencia.Ler(const CodigoItem: string; const Dados: TDataSet): Boolean;
begin
  Result := False;
end;

function TRepositorioSemPersistencia.Gravar(const CodigoItem: string; const Dados: TDataSet): TResultadoGravacao;
begin
  Result.Sucesso := True;
  Result.LinhasAfetadas := 0;
  Result.Mensagem := '';
end;

end.
