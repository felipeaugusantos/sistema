unit untTParticipante;

interface

uses System.Generics.Collections,
     untTCidade;

type
  TAlteracaoParticipante = class
  private
    FDataAlteracao: TDateTime;
    FCampoAlterado: string;
    FValorAnterior: string;
    FValorAtual: string;
  public
    property dtaDataAlteracao: TDateTime read FDataAlteracao write FDataAlteracao;
    property strCampoAlterado: string read FCampoAlterado write FCampoAlterado;
    property strValorAnterior: string read FValorAnterior write FValorAnterior;
    property strValorAtual: string read FValorAtual write FValorAtual;
  end;

Type
  TParticipante = class(TObject)
    private
      FInscricaoEstadual: string;
      FContaContabil: string;
      FContaReduzida: string;
      FMunicipio: string;
      FEndereco: string;
      FEnderecoNumero: string;
      FTelefone: string;
      FCodigo: string;
      FCgcCpf: string;
      FTabela: string;
      FBairro: string;
      FNome: string;
      FCodCid: string;
      FCep: string;
      FUf: string;
      FTipFc: string;
      FCgcCpfInt: Int64; //variavel criada para ser possivel ordenar por cgccpf
      FDataCadastro: TDateTime;
      FConsumidorFinal: boolean;
      FCidade: TCidade;
      FListaAlteracaoParticipante: TObjectList<TAlteracaoParticipante>;
    public
      property strInscricaoEstadual: string read FInscricaoEstadual write FInscricaoEstadual;
      property strContaContabil: string read FContaContabil write FContaContabil;
      property strContaReduzida: string read FContaReduzida write FContaReduzida;
      property strMunicipio: string read FMunicipio write FMunicipio;
      property strEndereco: string read FEndereco write FEndereco;
      property strEnderecoNumero: string read FEnderecoNumero write FEnderecoNumero;
      property strTelefone: string read FTelefone write FTelefone;
      property strCodigo: string read FCodigo write FCodigo;
      property strCgcCpf: string read FCgcCpf write FCgcCpf;
      property strTabela: string read FTabela write FTabela;
      property strBairro: string read FBairro write FBairro;
      property strNome: string read FNome write FNome;
      property strCodCid: string read FCodCid write FCodCid;
      property strCep: string read FCep write FCep;
      property strUf: string read FUf write FUf;
      property intCgcCpfInt: Int64 read FCgcCpfInt write FCgcCpfInt;
      property dtaDataCadastro: TDateTime read FDataCadastro write FDataCadastro;
      property blnConsumidorFinal: boolean read FConsumidorFinal write FConsumidorFinal;
      property cidade: TCidade read FCidade write FCidade;
      property strTipFc: string read FTipFc write FTipFc;
      property listaAlteracaoParticipante: TObjectList<TAlteracaoParticipante> read FListaAlteracaoParticipante write FListaAlteracaoParticipante;

      constructor Create;
      destructor Destroy; override;
  end;

  TCliente = class(TParticipante)
    private
      FInscricaoMunicipalProdutor: string;
      FOrgaoPublico: string;
    public
      property strInscricaoMunicipalProdutor: string read FInscricaoMunicipalProdutor write FInscricaoMunicipalProdutor;
      property strOrgaoPublico: string read FOrgaoPublico write FOrgaoPublico;
  end;

  TFornecedor = class(TParticipante)
    private
      FSimplesNacional: string;
    public
      property strSimplesNacional: string read FSimplesNacional write FSimplesNacional;
  end;


implementation

{ TPessoa }

{ TParticipante }

constructor TParticipante.Create;
begin
  inherited create;

  FListaAlteracaoParticipante := TObjectList<TAlteracaoParticipante>.Create;
  FCidade := TCidade.Create;
end;

destructor TParticipante.Destroy;
begin
  FListaAlteracaoParticipante.Free;
  FCidade.Free;

  inherited;
end;

end.
