unit Correios.Main;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Correios.Types,
  Correios.Interfaces;

type
  TCorreiosAPI = class(TInterfacedObject, ICorreios)
  public
    function ConsultaCep(const ACep: String; out ACidade, AEndereco, ABairro, AEstado: String): Boolean; stdcall;
    function GetServicosCliente(const ANumContrato, ANumCartao: String; const AHomologacao: Boolean): TServicosCliente; stdcall;
    function EnviaPreListaPostagem(const ADadosPostagem: TDadosPostagem; out AJsonEnv, AJsonRet, AIdPostagem, ACodObjeto: String): Boolean; stdcall;
  end;

implementation

uses
  Correios.Controller,
  Correios.Classes,
  Correios.Funcoes;

{ TCorreiosAPI }

function TCorreiosAPI.ConsultaCep(const ACep: String; out ACidade, AEndereco,
  ABairro, AEstado: String): Boolean;
  var
    LobjConsultaCep: TConsultaCepApi;
begin
  Result := False;
  LobjConsultaCep := TConsultaCepApi.Create;

  try
    try
      LobjConsultaCep.Cep := ACep;

      Result := LobjConsultaCep.ConsultaCep;

      if not Result then
        Exit;

      ACidade   := LobjConsultaCep.Cidade;
      AEndereco := LobjConsultaCep.Endereco;
      ABairro   := LobjConsultaCep.Bairro;
      AEstado   := LobjConsultaCep.Estado;
    except
      raise;
    end;
  finally
    FreeAndNil(LobjConsultaCep);
  end;
end;

function TCorreiosAPI.GetServicosCliente(const ANumContrato, ANumCartao: String; const AHomologacao: Boolean): TServicosCliente;
  var
    LobjContrato: TServicosContratoApi;
    LobjServicos: TArray<TServicoContratoCliente>;
    LobjServico: TServicoContratoCliente;
begin
  Result := TServicosCliente.Create;
  LobjContrato := TServicosContratoApi.Create;

  try
    try
      LobjContrato.NumContrato := ANumContrato;
      LobjContrato.NumCartao   := ANumCartao;
      LobjContrato.Homologacao := AHomologacao;

      LobjServicos := LobjContrato.ConsultaServicos;

      if not Assigned(LobjServicos) then
        Exit;

      for LobjServico in LobjServicos do
        Result.Add(TDadosServico.Create(0, Trim(LobjServico.codigo), Trim(LobjServico.descricao)));
    except
      raise;
    end;
  finally
    FreeAndNil(LobjContrato);
  end;
end;

function TCorreiosAPI.EnviaPreListaPostagem(const ADadosPostagem: TDadosPostagem; out AJsonEnv, AJsonRet, AIdPostagem, ACodObjeto: String): Boolean;
  var
    LobjRequest: TPrePostagemRequest;
    LobjPrePostagem: TPrePostagemApi;
    LobjItem: TItemConteudo;
begin
  Result := False;
  LobjRequest := TPrePostagemRequest.Create;
  LobjPrePostagem := TPrePostagemApi.Create;

  try
    try
      AJsonEnv    := EmptyStr;
      AJsonRet    := EmptyStr;
      AIdPostagem := EmptyStr;
      ACodObjeto  := EmptyStr;

      LobjRequest.remetente.nome                    := ADadosPostagem.remetente.nome;
      LobjRequest.remetente.dddTelefone             := IfThen(ADadosPostagem.remetente.telefone <> '', Copy(ADadosPostagem.remetente.telefone, 1, 2));
      LobjRequest.remetente.telefone                := IfThen(ADadosPostagem.remetente.telefone <> '', Copy(ADadosPostagem.remetente.telefone, 3, 8));
      LobjRequest.remetente.email                   := ADadosPostagem.remetente.email;
      LobjRequest.remetente.cpfCnpj                 := ADadosPostagem.remetente.cnpj;
      LobjRequest.remetente.endereco.cep            := ADadosPostagem.remetente.cep;
      LobjRequest.remetente.endereco.logradouro     := ADadosPostagem.remetente.endereco;
      LobjRequest.remetente.endereco.numero         := ADadosPostagem.remetente.numero;
      LobjRequest.remetente.endereco.complemento    := ADadosPostagem.remetente.compl;
      LobjRequest.remetente.endereco.bairro         := ADadosPostagem.remetente.bairro;
      LobjRequest.remetente.endereco.cidade         := ADadosPostagem.remetente.cidade;
      LobjRequest.remetente.endereco.uf             := ADadosPostagem.remetente.uf;
      LobjRequest.destinatario.nome                 := ADadosPostagem.destinatario.nome;
      LobjRequest.destinatario.dddTelefone          := IfThen(ADadosPostagem.destinatario.telefone <> '', Copy(ADadosPostagem.destinatario.telefone, 1, 2));
      LobjRequest.destinatario.telefone             := IfThen(ADadosPostagem.destinatario.telefone <> '', Copy(ADadosPostagem.destinatario.telefone, 3, 8));
      LobjRequest.destinatario.endereco.cep         := ADadosPostagem.destinatario.cep;
      LobjRequest.destinatario.endereco.logradouro  := ADadosPostagem.destinatario.endereco;
      LobjRequest.destinatario.endereco.numero      := ADadosPostagem.destinatario.numero;
      LobjRequest.destinatario.endereco.complemento := ADadosPostagem.destinatario.compl;
      LobjRequest.destinatario.endereco.bairro      := ADadosPostagem.destinatario.bairro;
      LobjRequest.destinatario.endereco.cidade      := ADadosPostagem.destinatario.cidade;
      LobjRequest.destinatario.endereco.uf          := ADadosPostagem.destinatario.uf;
      LobjRequest.codigoServico                     := ADadosPostagem.codigoServico;
      LobjRequest.numeroNotaFiscal                  := ADadosPostagem.numeroNotaFiscal;
      LobjRequest.chaveNFe                          := ADadosPostagem.chaveNFe;

      if ADadosPostagem.valorServicoAdic > 0 then
        LobjRequest.AddServicoAdicional(
          TServicoAdicional.Create(ADadosPostagem.codigoServicoAdic, ADadosPostagem.valorServicoAdic)
        );

      for LobjItem in ADadosPostagem.itensConteudo do
        LobjRequest.AddDeclaracaoConteudo(
          TItemDeclaracaoConteudo.Create(LobjItem.descricao, LobjItem.quantidade, LobjItem.valor)
        );

      LobjPrePostagem.JsonEnv := LobjRequest.ToJsonString;

      Result := LobjPrePostagem.EnviaPrePostagem;

      AJsonEnv    := LobjPrePostagem.JsonEnv;
      AJsonRet    := LobjPrePostagem.JsonRet;
      AIdPostagem := LobjPrePostagem.IdPostagem;
      ACodObjeto  := LobjPrePostagem.CodObjeto;
    except
      raise;
    end;
  finally
    FreeAndNil(LobjRequest);
    FreeAndNil(LobjPrePostagem);
  end;
end;

end.
