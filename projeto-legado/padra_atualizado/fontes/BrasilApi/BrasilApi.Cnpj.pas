unit BrasilApi.Cnpj;

interface

type
  TBrasilApiQSA = class
  private
    Fpais: string;
    Fnome_socio: string;
    Fcodigo_pais: string;
    Ffaixa_etaria: string;
    Fcnpj_cpf_do_socio: string;
    Fqualificacao_socio: string;
    Fcodigo_faixa_etaria: Integer;
    Fdata_entrada_sociedade: string;
    Fidentificador_de_socio: Integer;
    Fcpf_representante_legal: string;
    Fnome_representante_legal: string;
    Fcodigo_qualificacao_socio: Integer;
    Fqualificacao_representante_legal: string;
    Fcodigo_qualificacao_representante_legal: Integer;
  public
    property pais: string read Fpais write Fpais;
    property nome_socio: string read Fnome_socio write Fnome_socio;
    property codigo_pais: string read Fcodigo_pais write Fcodigo_pais;
    property faixa_etaria: string read Ffaixa_etaria write Ffaixa_etaria;
    property cnpj_cpf_do_socio: string read Fcnpj_cpf_do_socio write Fcnpj_cpf_do_socio;
    property qualificacao_socio: string read Fqualificacao_socio write Fqualificacao_socio;
    property codigo_faixa_etaria: Integer read Fcodigo_faixa_etaria write Fcodigo_faixa_etaria;
    property data_entrada_sociedade: string read Fdata_entrada_sociedade write Fdata_entrada_sociedade;
    property identificador_de_socio: Integer read Fidentificador_de_socio write Fidentificador_de_socio;
    property cpf_representante_legal: string read Fcpf_representante_legal write Fcpf_representante_legal;
    property nome_representante_legal: string read Fnome_representante_legal write Fnome_representante_legal;
    property codigo_qualificacao_socio: Integer read Fcodigo_qualificacao_socio write Fcodigo_qualificacao_socio;
    property qualificacao_representante_legal: string read Fqualificacao_representante_legal write Fqualificacao_representante_legal;
    property codigo_qualificacao_representante_legal: Integer read Fcodigo_qualificacao_representante_legal write Fcodigo_qualificacao_representante_legal;
  end;

  TBrasilApiCNAESecundario = class
  private
    Fcodigo: Int64;
    Fdescricao: string;
  public
    property codigo: Int64 read Fcodigo write Fcodigo;
    property descricao: string read Fdescricao write Fdescricao;
  end;

  TBrasilApiRegimeTributario = class
  private
    Fano: Integer;
    Fcnpj_da_scp: string;
    Fforma_de_tributacao: string;
    Fquantidade_de_escrituracoes: Integer;
  public
    property ano: Integer read Fano write Fano;
    property cnpj_da_scp: string read Fcnpj_da_scp write Fcnpj_da_scp;
    property forma_de_tributacao: string read Fforma_de_tributacao write Fforma_de_tributacao;
    property quantidade_de_escrituracoes: Integer read Fquantidade_de_escrituracoes write Fquantidade_de_escrituracoes;
  end;

  TBrasilApiEmpresa = class
  private
    Fuf: string;
    Fcep: string;
    Fqsa: TArray<TBrasilApiQSA>;
    Fcnpj: string;
    Fpais: string;
    Femail: string;
    Fporte: string;
    Fbairro: string;
    Fnumero: string;
    Fddd_fax: string;
    Fmunicipio: string;
    Flogradouro: string;
    Fcnae_fiscal: Int64;
    Fcodigo_pais: string;
    Fcomplemento: string;
    Fcodigo_porte: Integer;
    Frazao_social: string;
    Fnome_fantasia: string;
    Fcapital_social: Double;
    Fddd_telefone_1: string;
    Fddd_telefone_2: string;
    Fopcao_pelo_mei: string;
    Fcodigo_municipio: Integer;
    Fcnaes_secundarios: TArray<TBrasilApiCNAESecundario>;
    Fnatureza_juridica: string;
    Fregime_tributario: TArray<TBrasilApiRegimeTributario>;
    Fsituacao_especial: string;
    Fopcao_pelo_simples: string;
    Fsituacao_cadastral: Integer;
    Fdata_opcao_pelo_mei: string;
    Fdata_exclusao_do_mei: string;
    Fcnae_fiscal_descricao: string;
    Fcodigo_municipio_ibge: Integer;
    Fdata_inicio_atividade: string;
    Fdata_situacao_especial: string;
    Fdata_opcao_pelo_simples: string;
    Fdata_situacao_cadastral: string;
    Fnome_cidade_no_exterior: string;
    Fcodigo_natureza_juridica: Integer;
    Fdata_exclusao_do_simples: string;
    Fmotivo_situacao_cadastral: Integer;
    Fente_federativo_responsavel: string;
    Fidentificador_matriz_filial: Integer;
    Fqualificacao_do_responsavel: Integer;
    Fdescricao_situacao_cadastral: string;
    Fdescricao_tipo_de_logradouro: string;
    Fdescricao_motivo_situacao_cadastral: string;
    Fdescricao_identificador_matriz_filial: string;
  public
    property uf: string read Fuf write Fuf;
    property cep: string read Fcep write Fcep;
    property qsa: TArray<TBrasilApiQSA> read Fqsa write Fqsa;
    property cnpj: string read Fcnpj write Fcnpj;
    property pais: string read Fpais write Fpais;
    property email: string read Femail write Femail;
    property porte: string read Fporte write Fporte;
    property bairro: string read Fbairro write Fbairro;
    property numero: string read Fnumero write Fnumero;
    property ddd_fax: string read Fddd_fax write Fddd_fax;
    property municipio: string read Fmunicipio write Fmunicipio;
    property logradouro: string read Flogradouro write Flogradouro;
    property cnae_fiscal: Int64 read Fcnae_fiscal write Fcnae_fiscal;
    property codigo_pais: string read Fcodigo_pais write Fcodigo_pais;
    property complemento: string read Fcomplemento write Fcomplemento;
    property codigo_porte: Integer read Fcodigo_porte write Fcodigo_porte;
    property razao_social: string read Frazao_social write Frazao_social;
    property nome_fantasia: string read Fnome_fantasia write Fnome_fantasia;
    property capital_social: Double read Fcapital_social write Fcapital_social;
    property ddd_telefone_1: string read Fddd_telefone_1 write Fddd_telefone_1;
    property ddd_telefone_2: string read Fddd_telefone_2 write Fddd_telefone_2;
    property opcao_pelo_mei: string read Fopcao_pelo_mei write Fopcao_pelo_mei;
    property codigo_municipio: Integer read Fcodigo_municipio write Fcodigo_municipio;
    property cnaes_secundarios: TArray<TBrasilApiCNAESecundario> read Fcnaes_secundarios write Fcnaes_secundarios;
    property natureza_juridica: string read Fnatureza_juridica write Fnatureza_juridica;
    property regime_tributario: TArray<TBrasilApiRegimeTributario> read Fregime_tributario write Fregime_tributario;
    property situacao_especial: string read Fsituacao_especial write Fsituacao_especial;
    property opcao_pelo_simples: string read Fopcao_pelo_simples write Fopcao_pelo_simples;
    property situacao_cadastral: Integer read Fsituacao_cadastral write Fsituacao_cadastral;
    property data_opcao_pelo_mei: string read Fdata_opcao_pelo_mei write Fdata_opcao_pelo_mei;
    property data_exclusao_do_mei: string read Fdata_exclusao_do_mei write Fdata_exclusao_do_mei;
    property cnae_fiscal_descricao: string read Fcnae_fiscal_descricao write Fcnae_fiscal_descricao;
    property codigo_municipio_ibge: Integer read Fcodigo_municipio_ibge write Fcodigo_municipio_ibge;
    property data_inicio_atividade: string read Fdata_inicio_atividade write Fdata_inicio_atividade;
    property data_situacao_especial: string read Fdata_situacao_especial write Fdata_situacao_especial;
    property data_opcao_pelo_simples: string read Fdata_opcao_pelo_simples write Fdata_opcao_pelo_simples;
    property data_situacao_cadastral: string read Fdata_situacao_cadastral write Fdata_situacao_cadastral;
    property nome_cidade_no_exterior: string read Fnome_cidade_no_exterior write Fnome_cidade_no_exterior;
    property codigo_natureza_juridica: Integer read Fcodigo_natureza_juridica write Fcodigo_natureza_juridica;
    property data_exclusao_do_simples: string read Fdata_exclusao_do_simples write Fdata_exclusao_do_simples;
    property motivo_situacao_cadastral: Integer read Fmotivo_situacao_cadastral write Fmotivo_situacao_cadastral;
    property ente_federativo_responsavel: string read Fente_federativo_responsavel write Fente_federativo_responsavel;
    property identificador_matriz_filial: Integer read Fidentificador_matriz_filial write Fidentificador_matriz_filial;
    property qualificacao_do_responsavel: Integer read Fqualificacao_do_responsavel write Fqualificacao_do_responsavel;
    property descricao_situacao_cadastral: string read Fdescricao_situacao_cadastral write Fdescricao_situacao_cadastral;
    property descricao_tipo_de_logradouro: string read Fdescricao_tipo_de_logradouro write Fdescricao_tipo_de_logradouro;
    property descricao_motivo_situacao_cadastral: string read Fdescricao_motivo_situacao_cadastral write Fdescricao_motivo_situacao_cadastral;
    property descricao_identificador_matriz_filial: string read Fdescricao_identificador_matriz_filial write Fdescricao_identificador_matriz_filial;
  end;

implementation

end.
